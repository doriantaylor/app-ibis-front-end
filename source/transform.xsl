<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:rdfa="http://www.w3.org/ns/rdfa#"
                xmlns:xc="https://makethingsmakesense.com/asset/transclude#"
                xmlns:x="urn:x-dummy:"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:bibo="http://purl.org/ontology/bibo/"
                xmlns:cgto="https://vocab.methodandstructure.com/graph-tool#"
                xmlns:ci="https://vocab.methodandstructure.com/content-inventory#"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:ibis="https://vocab.methodandstructure.com/ibis#"
                xmlns:org="http://www.w3.org/ns/org#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:pav="http://purl.org/pav/"
                xmlns:pm="https://vocab.methodandstructure.com/process-model#"
                xmlns:prov="http://www.w3.org/ns/prov#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:sioc="http://rdfs.org/sioc/ns#"
                xmlns:sioct="http://rdfs.org/sioc/types#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:xhv="http://www.w3.org/1999/xhtml/vocab#"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
                xmlns:str="http://xsltsl.org/string"
                xmlns:uri="http://xsltsl.org/uri"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="html str uri rdfa xc x">

<xsl:import href="asset/rdfa-util"/>
<xsl:import href="asset/cgto"/>
<xsl:import href="asset/skos-ibis"/>

<xsl:output
    method="xml" media-type="application/xhtml+xml"
    indent="yes" omit-xml-declaration="no"
    encoding="utf-8" doctype-public=""/>

<!-- note the namespace:: axis does not work in firefox or we could just use that -->
<xsl:variable name="RDFS" select="'http://www.w3.org/2000/01/rdf-schema#'"/>
<xsl:variable name="IBIS" select="'https://vocab.methodandstructure.com/ibis#'"/>
<xsl:variable name="CGTO" select="'https://vocab.methodandstructure.com/graph-tool#'"/>
<xsl:variable name="BIBO" select="'http://purl.org/ontology/bibo/'"/>
<xsl:variable name="DCT"  select="'http://purl.org/dc/terms/'"/>
<xsl:variable name="QB"   select="'http://purl.org/linked-data/cube#'"/>
<xsl:variable name="SIOC" select="'http://rdfs.org/sioc/ns#'"/>
<xsl:variable name="SKOS" select="'http://www.w3.org/2004/02/skos/core#'"/>
<xsl:variable name="XHV"  select="'http://www.w3.org/1999/xhtml/vocab#'"/>

<!--
    Here is instance data we wish one day would live in the actual rdf
    or markup or whatever.
 -->

<!--
    This body template is intended to dispatch to type-specific
    templates; unfortunately I think they have to be hard-coded.
-->

<xsl:template match="html:*" mode="dispatch">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="debug" select="$xc:DEBUG"/>

  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="$debug"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="vocabs" select="document('asset/vocabs')"/>
  <xsl:param name="match" select="$vocabs/rdf:RDF//*[self::rdfs:Class|self::owl:Class][contains(concat(' ', normalize-space($type), ' '), concat(' ', @rdf:about, ' '))][1]"/>

  <xsl:choose>
    <xsl:when test="$match">
      <!-- use the internal dispatcher -->
      <xsl:apply-templates select="$match[1]">
        <xsl:with-param name="base"          select="$base"/>
        <xsl:with-param name="resource-path" select="$resource-path"/>
        <xsl:with-param name="rewrite"       select="$rewrite"/>
        <xsl:with-param name="main"          select="$main"/>
        <xsl:with-param name="heading"       select="$heading"/>
        <xsl:with-param name="current"       select="."/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <!-- otherwise just pass through -->
      <xsl:apply-templates>
        <xsl:with-param name="base"          select="$base"/>
        <xsl:with-param name="resource-path" select="$resource-path"/>
        <xsl:with-param name="rewrite"       select="$rewrite"/>
        <xsl:with-param name="main"          select="$main"/>
        <xsl:with-param name="heading"       select="$heading"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

<xsl:template match="html:html">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="debug" select="$xc:DEBUG"/>

<html>
  <xsl:apply-templates select="@*[local-name() != 'prefix']" mode="xc:attribute">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
  </xsl:apply-templates>
  <xsl:attribute name="prefix">
    <xsl:call-template name="rdfa:merge-prefixes">
      <xsl:with-param name="prefixes" select="@prefix"/>
      <xsl:with-param name="with" select="'ci: https://vocab.methodandstructure.com/content-inventory# cgto: https://vocab.methodandstructure.com/graph-tool# dct: http://purl.org/dc/terms/ foaf: http://xmlns.com/foaf/0.1/ ibis: https://vocab.methodandstructure.com/ibis# pm: https://vocab.methodandstructure.com/process-model# rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns# rdfs: http://www.w3.org/2000/01/rdf-schema# xsd: http://www.w3.org/2001/XMLSchema#'"/>
    </xsl:call-template>
  </xsl:attribute>

  <!-- do the damn type selection -->
  <xsl:variable name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="type-pad" select="concat(' ', normalize-space($type), ' ')"/>

  <!-- XXX UN-HARDCODE THIS -->
  <!--<xsl:variable name="vocabs" select="document('/13e45ee1-0b98-4d4b-9e74-a83a09e85030')"/>-->
  <xsl:variable name="vocabs" select="document('asset/vocabs')"/>

  <xsl:variable name="match" select="$vocabs/rdf:RDF//*[self::rdfs:Class|self::owl:Class][@rdf:about][contains($type-pad, concat(' ', @rdf:about, ' '))][1]"/>

  <xsl:message>woops <xsl:value-of select="name($match)"/><xsl:text> </xsl:text><xsl:value-of select="$match/@rdf:about"/></xsl:message>

  <!-- do head -->
  <head>
    <xsl:apply-templates select="html:head/@*" mode="xc:attribute">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
    </xsl:apply-templates>

    <xsl:apply-templates select="html:head[1]" mode="dispatch">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
      <xsl:with-param name="main"          select="$main"/>
      <xsl:with-param name="heading"       select="$heading"/>
      <xsl:with-param name="subject"       select="$subject"/>
      <xsl:with-param name="type"          select="$type"/>
      <xsl:with-param name="vocabs"        select="$vocabs"/>
      <xsl:with-param name="match"         select="$match[1]"/>
    </xsl:apply-templates>
  </head>

  <!-- do body -->
  <body>
    <xsl:apply-templates select="html:body/@*" mode="xc:attribute">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
    </xsl:apply-templates>

    <xsl:apply-templates select="html:body[1]" mode="dispatch">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
      <xsl:with-param name="main"          select="$main"/>
      <xsl:with-param name="heading"       select="$heading"/>
      <xsl:with-param name="subject"       select="$subject"/>
      <xsl:with-param name="type"          select="$type"/>
      <xsl:with-param name="vocabs"        select="$vocabs"/>
      <xsl:with-param name="match"         select="$match[1]"/>
    </xsl:apply-templates>
  </body>
</html>

</xsl:template>

<!--
    These are shims that use the data embedded in the stylesheet to
    forward matches on to the type-specific templates. The current
    node (which should be the <body>) is passed in as a parameter.
-->

<xsl:template match="html:*" mode="noop">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>

  <xsl:apply-templates>
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="x:class">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current/node()">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about]">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="noop">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/ibis#Issue']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="ibis:Entity">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/ibis#Position']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="ibis:Entity">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/ibis#Argument']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="ibis:Entity">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/process-model#Goal']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="pm:Goal">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/process-model#Task']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="pm:Task">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/process-model#Target']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="pm:Target">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='http://www.w3.org/2004/02/skos/core#Concept']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="skos:Concept">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='http://www.w3.org/2004/02/skos/core#ConceptScheme']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="skos:ConceptScheme">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/ibis#Network']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="ibis:Network">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/graph-tool#Space']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="cgto:Space">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/graph-tool#View']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="cgto:View">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="*[self::rdfs:Class|self::owl:Class][@rdf:about='https://vocab.methodandstructure.com/graph-tool#Error']">
  <xsl:param name="base">
    <xsl:message terminate="yes">`base` parameter required.</xsl:message>
  </xsl:param>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="current">
    <xsl:message terminate="yes">`current` parameter required.</xsl:message>
  </xsl:param>

  <xsl:apply-templates select="$current" mode="cgto:Error">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<!--
    These are the actual type-specific templates.
-->

</xsl:stylesheet>
