<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:cgto="https://vocab.methodandstructure.com/graph-tool#"
                xmlns:rdfa="http://www.w3.org/ns/rdfa#"
                xmlns:xc="https://makethingsmakesense.com/asset/transclude#"
                xmlns:str="http://xsltsl.org/string"
                xmlns:uri="http://xsltsl.org/uri"
		xmlns:x="urn:x-dummy:"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="html str uri rdfa xc x">

<xsl:import href="rdfa-util"/>

<!-- too bad firefox still has no namespace:: axis -->
<xsl:variable name="CGTO" select="'https://vocab.methodandstructure.com/graph-tool#'"/>
<xsl:variable name="SIOC" select="'http://rdfs.org/sioc/ns#'"/>

<x:doc>
  <h1>Graph tool UI</h1>
  <p>This stylesheet handles UI peculiar to the collaborative graph tool ontology.</p>
</x:doc>

<xsl:template match="html:*" mode="cgto:get-user">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="type">
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="." mode="rdfa:get-type">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
    </xsl:apply-templates>
    <xsl:text> </xsl:text>
  </xsl:param>
</xsl:template>

<x:doc>
  <h2>cgto:get-focus</h2>
  <p>Obtain the focus (foci) from the <code>cgto:State</code> which is assumed to be the subject. More than one focus should be interpreted as an error.</p>
  <p>Assuming the subject <code>?s</code> is a <code>skos:Concept</code> or <code>ibis:Entity</code>, the property path to the focus will look something like <code>?s skos:inScheme/sioc:has_space/cgto:index/cgto:user/^cgto:owner/cgto:focus ?network</code>.</p>
</x:doc>

<xsl:template match="html:*" mode="cgto:get-focus">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="type">
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="." mode="rdfa:get-type">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
    </xsl:apply-templates>
    <xsl:text> </xsl:text>
  </xsl:param>
  <xsl:param name="via" select="concat($CGTO, 'state')"/>
  <!-- this either *is* the space or you *get* the space -->

  <xsl:variable name="actual-subject">
    <xsl:choose>
      <xsl:when test="contains($type, concat(' ', $CGTO, 'State '))">
	<xsl:value-of select="$subject"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="str:safe-first-token">
	  <xsl:with-param name="tokens">
	    <xsl:apply-templates select="." mode="rdfa:object-resources">
	      <xsl:with-param name="base" select="$base"/>
	      <xsl:with-param name="subject" select="$subject"/>
	      <xsl:with-param name="predicate" select="concat($CGTO, 'focus')"/>
	    </xsl:apply-templates>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="string-length(normalize-space($actual-subject)) = 0">
    <xsl:message terminate="yes">No <xsl:value-of select="$via"/> for subject <xsl:value-of select="$subject"/></xsl:message>
  </xsl:if>

  <xsl:variable name="doc">
    <xsl:call-template name="uri:document-for-uri">
      <xsl:with-param name="uri" select="$actual-subject"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="root" select="document($doc)/*"/>

  <xsl:apply-templates select="$root" mode="rdfa:object-resources">
    <xsl:with-param name="subject" select="$actual-subject"/>
    <xsl:with-param name="predicate" select="concat($CGTO, 'focus')"/>
  </xsl:apply-templates>
</xsl:template>


<x:doc>
  <h2>cgto:get-state</h2>
  <p>Given a list of candidate <code>cgto:State</code>s (retrieved from the encapsulating <code>cgto:Space</code>), get the state that belongs to the current user.</p>
  <p>This template will dereference the user's containing document.</p>
</x:doc>

<xsl:template match="html:*" mode="cgto:get-state">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject"/>
  <xsl:param name="candidates"/>

  <xsl:variable name="doc">
    <xsl:call-template name="uri:document-for-uri">
      <xsl:with-param name="uri" select="$subject"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="ours">
    <xsl:variable name="root" select="document($doc)/*"/>
    <xsl:apply-templates select="rdfa:object-resources">
      <xsl:with-param name="subject" select="$user"/>
      <xsl:with-param name="predicate" select="concat($CGTO, 'state')"/>
    </xsl:apply-templates>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="rdfa:subject-resources">
      <xsl:with-param name="predicate" select="concat($CGTO, 'owner')"/>
      <xsl:with-param name="object" select="$user"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="out">
    <xsl:call-template name="str:token-intersection">
      <xsl:with-param name="left" select="$candidates"/>
      <xsl:with-param name="right" select="$ours"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="str:safe-first-token">
    <xsl:with-param name="tokens" select="out"/>
  </xsl:call-template>
</xsl:template>

<x:doc>
  <h2>cgto:get-spaces</h2>
  <p>The subject either <em>is</em> a <code>cgto:Space</code> or is related to it by one degree.</p>
</x:doc>

<xsl:template match="html:*" mode="cgto:get-spaces">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="type-xx">
    <xsl:call-template name="str:token-intersection">
      <xsl:with-param name="left" select="$type"/>
      <xsl:with-param name="right" select="concat($CGTO, 'Space')"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="string-length(normalize-space($type-xx))">
      <xsl:value-of select="$subject"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="_">
	<xsl:apply-templates select="." mode="rdfa:object-resources">
	  <xsl:with-param name="subject" select="$subject"/>
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="predicate" select="concat($SIOC, 'has_space')"/>
	</xsl:apply-templates>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="rdfa:subject-resources">
          <xsl:with-param name="object" select="$subject"/>
          <xsl:with-param name="base" select="$base"/>
          <xsl:with-param name="predicate" select="concat($SIOC, 'space_of')"/>
	</xsl:apply-templates>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="rdfa:subject-resources">
          <xsl:with-param name="object" select="$subject"/>
          <xsl:with-param name="base" select="$base"/>
          <xsl:with-param name="predicate" select="concat($CGTO, 'focus')"/>
	</xsl:apply-templates>
      </xsl:variable>
      <xsl:call-template name="str:unique-tokens">
	<xsl:with-param name="string" select="normalize-space($_)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<x:doc>
  <h2>cgto:find-summaries</h2>
  <p></p>
</x:doc>

<!-- extremely specific i know but we use this more than once -->
<xsl:template match="html:*" mode="cgto:find-summaries">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="origins">
    <xsl:apply-templates select="." mode="cgto:get-spaces">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="relations">
    <xsl:message terminate="yes">`relations` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="debug" select="$rdfa:DEBUG"/>

  <xsl:variable name="indices">
    <xsl:apply-templates select="." mode="rdfa:find-relations">
      <xsl:with-param name="resources" select="$origins"/>
      <xsl:with-param name="predicate" select="concat($CGTO, 'index')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:if test="$debug">
    <xsl:message>cgto:find-summaries: metas: <xsl:value-of select="$metas"/></xsl:message>
  </xsl:if>

  <xsl:variable name="candidates">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$indices"/>
      <xsl:with-param name="class" select="concat($CGTO, 'Index')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:if test="$debug">
    <xsl:message>cgto:find-summaries: <xsl:value-of select="$candidates"/></xsl:message>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="string-length(normalize-space($relations))">
      <xsl:apply-templates select="." mode="rdfa:find-relations">
        <xsl:with-param name="resources" select="$candidates"/>
        <xsl:with-param name="predicate" select="$relations"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise><xsl:value-of select="$candidates"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- okay you run this *on* the index -->

<xsl:template match="html:*" mode="cgto:find-inventories-by-class">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="classes">
    <xsl:message terminate="yes">`classes` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="summaries">
    <xsl:apply-templates select="." mode="rdfa:find-relations">
      <xsl:with-param name="resources" select="$subject"/>
      <xsl:with-param name="predicate" select="concat($CGTO, 'by-class')"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="inferred" select="false()"/>

  <!--<xsl:message>lol summaries <xsl:value-of select="$summaries"/></xsl:message>-->

  <xsl:if test="string-length(normalize-space($summaries))">
    <xsl:variable name="observations">
      <xsl:variable name="_">
        <xsl:apply-templates select="." mode="rdfa:find-relations">
          <xsl:with-param name="resources" select="$summaries"/>
          <xsl:with-param name="predicate" select="concat($QB, 'dataSet')"/>
          <xsl:with-param name="reverse"   select="true()"/>
        </xsl:apply-templates>
      </xsl:variable>

      <!--<xsl:message>did this net anything? <xsl:value-of select="$_"/></xsl:message>-->

      <xsl:choose>
        <xsl:when test="string-length(normalize-space($classes))">
          <xsl:apply-templates select="." mode="rdfa:filter-by-predicate-object">
            <xsl:with-param name="subjects" select="$_"/>
            <xsl:with-param name="predicate" select="concat($CGTO, 'class')"/>
            <xsl:with-param name="object" select="$classes"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$_"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--<xsl:message>observations: <xsl:value-of select="$observations"/></xsl:message>-->

    <xsl:variable name="p">
      <xsl:choose>
	<xsl:when test="$inferred">inferred</xsl:when>
	<xsl:otherwise>asserted</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:apply-templates select="." mode="rdfa:find-relations">
      <xsl:with-param name="resources" select="$observations"/>
      <xsl:with-param name="predicate" select="concat($CGTO, $p, '-subjects')"/>
    </xsl:apply-templates>

  </xsl:if>

</xsl:template>

<xsl:template match="html:head" mode="cgto:head-generic">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:apply-templates>
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
  </xsl:apply-templates>

  <!-- XXX get rid of this lol -->
  <link rel="stylesheet" type="text/css" href="/asset/skos-ibis/style"/>
  <link rel="stylesheet" type="text/css" href="/type/font-awesome"/>
  <link rel="stylesheet" type="text/css" href="/type/noto-sans-symbols2"/>
  <script type="text/javascript" src="/asset/rdf"></script>
  <script type="text/javascript" src="/asset/rdf-viz"></script>
  <script type="text/javascript" src="/asset/complex"></script>
  <script type="text/javascript" src="/asset/d3"></script>
  <script type="text/javascript" src="/asset/hierarchical"></script>
  <script type="text/javascript" src="/asset/force-directed"></script>
  <script type="text/javascript" src="/asset/skos-ibis/scripts"></script>

</xsl:template>


<!-- graph tool space -->

<xsl:template match="html:head" mode="cgto:Space">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:apply-templates select="." mode="cgto:head-generic">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="html:body" mode="cgto:Space">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>

  <xsl:variable name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="index">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="user">
    <xsl:if test="string-length(normalize-space($index))">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$index"/>
      <xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#user'"/>
      <xsl:with-param name="traverse" select="true()"/>
    </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="state">
    <xsl:if test="string-length(normalize-space($user))">
      <xsl:apply-templates select="." mode="rdfa:subject-resources">
	<xsl:with-param name="object" select="$user"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#owner'"/>
	<xsl:with-param name="traverse" select="true()"/>
	<!--<xsl:with-param name="debug" select="true()"/>-->
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="focus">
    <xsl:if test="string-length(normalize-space($state))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$state"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#focus'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="string-length(normalize-space($focus)) and not(contains(normalize-space($focus), ' '))">
      <!-- congratulations there is exactly one focus -->
      <xsl:apply-templates select="." mode="cgto:show-focus">
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="resource-path" select="$resource-path"/>
        <xsl:with-param name="rewrite" select="$rewrite"/>
        <xsl:with-param name="main" select="$main"/>
        <xsl:with-param name="heading" select="$heading"/>
        <xsl:with-param name="subject" select="$subject"/>
        <xsl:with-param name="focus" select="$focus"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <!-- there are either zero foci or there are too many -->
      <xsl:apply-templates select="." mode="cgto:select-focus">
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="resource-path" select="$resource-path"/>
        <xsl:with-param name="rewrite" select="$rewrite"/>
        <xsl:with-param name="main" select="$main"/>
        <xsl:with-param name="heading" select="$heading"/>
        <xsl:with-param name="subject" select="$subject"/>
	<xsl:with-param name="index" select="$index"/>
	<xsl:with-param name="user" select="$user"/>
        <xsl:with-param name="focus" select="$focus"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="html:*" mode="cgto:select-focus">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="focus">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="concat($CGTO, 'focus')"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:if test="string-length($focus)">
    <section>
      <p>Resolve the conflict of multiple foci by specifying <em>exactly</em> one focus from those that have been erroneously selected:</p>
      <ul>
        <xsl:apply-templates select="." mode="cgto:focus-item">
          <xsl:with-param name="items" select="$inventory"/>
        </xsl:apply-templates>
      </ul>
    </section>
    <hr/>
 </xsl:if>

  <!-- if it doesn't have a focus, we try to give it one (or make one) -->

  <xsl:variable name="inventory">
    <xsl:variable name="_">
      <xsl:apply-templates select="." mode="cgto:find-inventories-by-class">
        <xsl:with-param name="subject" select="$subject"/>
        <xsl:with-param name="classes">
          <xsl:value-of select="concat($IBIS, 'Network')"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="concat($SKOS, 'ConceptScheme')"/>
        </xsl:with-param>
      </xsl:apply-templates>
    </xsl:variable>

    <!-- subtract existing foci from the inventory -->
    <xsl:call-template name="str:token-minus">
      <xsl:with-param name="tokens">
        <!-- just grab the raw inventory here; we don't use it elsewhere -->
        <xsl:apply-templates select="." mode="rdfa:find-relations">
          <xsl:with-param name="resources" select="$_"/>
          <xsl:with-param name="predicate" select="concat($DCT, 'hasPart')"/>
        </xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="minus" select="$focus"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:message><xsl:value-of select="$inventory"/></xsl:message>

  <xsl:if test="string-length($inventory)">
    <!-- if there *are* candidates for a focus, offer them for selection -->
    <section>
      <p>Pick a focus from other candidates found in the graph:</p>
      <ul>
        <xsl:apply-templates select="." mode="cgto:focus-item">
          <xsl:with-param name="items" select="$inventory"/>
        </xsl:apply-templates>
      </ul>
    </section>

    <!-- or -->
    <hr/>
  </xsl:if>

  <!-- if there are no candidates for a focus, try to make one -->
  <section>
    <p>Create a new focus:</p>
    <form method="POST" action="" accept-charset="utf-8">
      <input type="hidden" name="$ new $" value="$NEW_UUID_URN"/>
      <input type="hidden" name="cgto:focus : $" value="$new"/>
      <select name="= $new rdf:type :">
        <option value="ibis:Network">Issue Network</option>
        <option value="skos:ConceptScheme">Concept Scheme</option>
      </select>
      <input type="text" name="= $new skos:prefLabel" placeholder="Name of new focus"/>
      <button class="fa fa-plus"></button>
    </form>
  </section>

</xsl:template>

<xsl:template match="html:*" mode="cgto:focus-item">
  <xsl:param name="items">
    <xsl:message terminate="yes">`items` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$items"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="doc">
    <xsl:call-template name="uri:document-for-uri">
      <xsl:with-param name="uri" select="$first"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="root" select="document($doc)/*"/>

  <xsl:variable name="types">
    <xsl:call-template name="rdfa:make-curie-list">
      <xsl:with-param name="node" select="$root"/>
      <xsl:with-param name="list">
        <xsl:apply-templates select="$root/html:body" mode="rdfa:object-resources">
          <xsl:with-param name="subject" select="$first"/>
          <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="label">
    <xsl:apply-templates select="$root/html:body" mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$first"/>
      <xsl:with-param name="predicate" select="concat($SKOS, 'prefLabel')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="suffix" select="substring-after($label, $rdfa:UNIT-SEP)"/>

  <li about="{$first}" typeof="{$types}">
    <a property="skos:prefLabel" href="{$first}">
      <xsl:choose>
        <xsl:when test="contains($suffix, ':')">
          <xsl:attribute name="datatype"><xsl:value-of select="$suffix"/></xsl:attribute>
        </xsl:when>
        <xsl:when test="string-length($suffix)">
          <xsl:attribute name="xml:lang"><xsl:value-of select="$suffix"/></xsl:attribute>
        </xsl:when>
      </xsl:choose>
    <xsl:value-of select="substring-before($label, $rdfa:UNIT-SEP)"/></a>
    <form method="POST" action="" accept-charset="utf-8">
      <button class="fa fa-equals" name="= cgto:focus :" value="{$first}"/>
    </form>
  </li>

  <xsl:variable name="rest" select="substring-after(normalize-space($items), ' ')"/>

  <xsl:if test="string-length($rest)">
    <xsl:apply-templates select="." mode="cgto:focus-item">
      <xsl:with-param name="items" select="$rest"/>
    </xsl:apply-templates>
  </xsl:if>

</xsl:template>

<xsl:template match="html:*" mode="cgto:show-focus">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="focus">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($CGTO, 'focus')"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="others">
    <xsl:call-template name="str:token-minus">
      <xsl:with-param name="tokens">
        <xsl:apply-templates select="." mode="rdfa:object-resources">
          <xsl:with-param name="subject" select="$subject"/>
          <xsl:with-param name="base" select="$base"/>
          <xsl:with-param name="predicate" select="concat($SIOC, 'space_of')"/>
        </xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="minus" select="$focus"/>
    </xsl:call-template>
  </xsl:variable>

  <main>
    <nav>
      <xsl:apply-templates select="." mode="cgto:space-cartouche">
        <xsl:with-param name="resources" select="$focus"/>
        <xsl:with-param name="relation" select="'cgto:focus'"/>
      </xsl:apply-templates>
      <xsl:if test="string-length(normalize-space($others))">
        <xsl:apply-templates select="." mode="cgto:space-cartouche">
          <xsl:with-param name="resources" select="$others"/>
          <xsl:with-param name="relation" select="'sioc:space_of'"/>
        </xsl:apply-templates>
      </xsl:if>
    </nav>
  </main>

</xsl:template>

<xsl:template match="html:*" mode="cgto:space-cartouche">
  <xsl:param name="resources">
    <xsl:message terminate="yes">`resources` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="relation">
    <xsl:message terminate="yes">`relation` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$resources"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="doc">
    <xsl:call-template name="uri:document-for-uri">
      <xsl:with-param name="uri" select="$first"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="root" select="document($doc)/*"/>

  <xsl:variable name="types">
    <xsl:call-template name="rdfa:make-curie-list">
      <xsl:with-param name="list">
        <xsl:apply-templates select="$root" mode="rdfa:object-resources">
          <xsl:with-param name="subject" select="$first"/>
          <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="title" select="$root/html:head/html:title"/>

  <xsl:variable name="entities">
    <xsl:apply-templates select="$root" mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$first"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:variable>

  <a rel="{$relation}" href="{$first}" typeof="{$types}">
    <h1 property="{$title/@property}"><xsl:value-of select="normalize-space($title)"/></h1>
  </a>

  <xsl:variable name="rest" select="substring-after(normalize-space($resources), ' ')"/>
  <xsl:if test="string-length($rest)">
    <xsl:apply-templates select="." mode="cgto:space-cartouche">
      <xsl:with-param name="resources" select="$rest"/>
      <xsl:with-param name="relation" select="$relation"/>
    </xsl:apply-templates>
  </xsl:if>

</xsl:template>

<!-- -->

<xsl:template match="html:body" mode="cgto:Error">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="top">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="'http://www.w3.org/1999/xhtml/vocab#top'"/>
    </xsl:apply-templates>
  </xsl:variable>

<main>
  <!-- get the title -->
  <h1><xsl:value-of select="../html:head/html:title"/></h1>

  <!-- get all the cgto:Space entities -->

    <!--
        remember we're seeing this "error" because there's either no
        cgto:Space at all in the graph or at least none that are
        attached to the root (and if there are more than one, then *only*
        one is to be designated as the root)

        anyway probably a table?
    -->
    <form method="POST" action="" accept-charset="utf-8">
    <table>
      <thead>
        <tr>
          <th>Space</th>
          <th>Make Active</th>
        </tr>
      </thead>
      <tbody>
        <!-- put the existing ones here -->
        <tr>
          <td>
            <input type="hidden" name="$ new $" value="$NEW_UUID_URN"/>
            <input type="text" name="$new dct:title" placeholder="Give a name for the new space"/>
          </td>
          <td>
            <input type="hidden" name="$new rdf:type :" value="cgto:Space"/>
            <button class="fa fa-plus" name="= $new ci:canonical :" value="{$top}"/>
          </td>
        </tr>
      </tbody>
    </table>
    </form>
  </main>

</xsl:template>

</xsl:stylesheet>
