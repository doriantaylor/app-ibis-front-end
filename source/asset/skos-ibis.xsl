<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:ibis="https://vocab.methodandstructure.com/ibis#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
		xmlns:cgto="https://vocab.methodandstructure.com/graph-tool#"
		xmlns:pm="https://vocab.methodandstructure.com/process-model#"
		xmlns:x="urn:x-dummy:"
                xmlns:rdfa="http://www.w3.org/ns/rdfa#"
                xmlns:xc="https://makethingsmakesense.com/asset/transclude#"
                xmlns:str="http://xsltsl.org/string"
                xmlns:uri="http://xsltsl.org/uri"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="html str uri rdfa xc x">

<xsl:import href="cgto"/>

<x:doc>
  <h1>SKOS/IBIS UI</h1>
  <p>This stylesheet transforms markup specific to SKOS and IBIS.</p>
</x:doc>

<x:doc>
  <h2>Data</h2>
  <p>These are variables and embedded data structures for the templates to operate over.</p>
</x:doc>

<!--<xsl:variable name="uri:DEBUG" select="true()"/>-->

<xsl:variable name="RDF" select="$rdfa:RDF-NS"/>
<xsl:variable name="RDFS" select="$rdfa:RDFS-NS"/>
<xsl:variable name="IBIS" select="'https://vocab.methodandstructure.com/ibis#'"/>
<xsl:variable name="PM"   select="'https://vocab.methodandstructure.com/process-model#'"/>
<xsl:variable name="CGTO" select="'https://vocab.methodandstructure.com/graph-tool#'"/>
<xsl:variable name="BIBO" select="'http://purl.org/ontology/bibo/'"/>
<xsl:variable name="DCT"  select="'http://purl.org/dc/terms/'"/>
<xsl:variable name="FOAF" select="'http://xmlns.com/foaf/0.1/'"/>
<xsl:variable name="ORG"  select="'http://www.w3.org/ns/org#'"/>
<xsl:variable name="PROV" select="'http://www.w3.org/ns/prov#'"/>
<xsl:variable name="QB"   select="'http://purl.org/linked-data/cube#'"/>
<xsl:variable name="SIOC" select="'http://rdfs.org/sioc/ns#'"/>
<xsl:variable name="SKOS" select="'http://www.w3.org/2004/02/skos/core#'"/>
<xsl:variable name="XHV"  select="'http://www.w3.org/1999/xhtml/vocab#'"/>
<xsl:variable name="XSD"  select="$rdfa:XSD-NS"/>

<x:lprops>
  <x:prop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
  <x:prop uri="http://www.w3.org/2004/02/skos/core#prefLabel"/>
  <x:prop uri="http://www.w3.org/2000/01/rdf-schema#label"/>
  <x:prop uri="http://purl.org/dc/terms/title"/>
  <x:prop uri="http://purl.org/dc/terms/identifier"/>
  <x:prop uri="http://xmlns.com/foaf/0.1/name"/>
</x:lprops>

<x:inverses>
  <!-- skos -->
  <x:pair a="http://www.w3.org/2004/02/skos/core#related" b="http://www.w3.org/2004/02/skos/core#related"/>
  <x:pair a="http://www.w3.org/2004/02/skos/core#narrower" b="http://www.w3.org/2004/02/skos/core#broader"/>
  <x:pair a="http://www.w3.org/2004/02/skos/core#narrowerTransitive" b="http://www.w3.org/2004/02/skos/core#broaderTransitive"/>
  <x:pair a="http://www.w3.org/2004/02/skos/core#narrowMatch" b="http://www.w3.org/2004/02/skos/core#broadMatch"/>
  <x:pair a="http://www.w3.org/2004/02/skos/core#closeMatch" b="http://www.w3.org/2004/02/skos/core#closeMatch"/>
  <x:pair a="http://www.w3.org/2004/02/skos/core#exactMatch" b="http://www.w3.org/2004/02/skos/core#exactMatch"/>
  <!-- ibis -->
  <x:pair a="https://vocab.methodandstructure.com/ibis#concerns" b="https://vocab.methodandstructure.com/ibis#concern-of"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#endorses" b="https://vocab.methodandstructure.com/ibis#endorsed-by"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#generalizes" b="https://vocab.methodandstructure.com/ibis#specializes"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#replaces" b="https://vocab.methodandstructure.com/ibis#replaced-by"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#questions" b="https://vocab.methodandstructure.com/ibis#questioned-by"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#suggests" b="https://vocab.methodandstructure.com/ibis#suggested-by"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#response" b="https://vocab.methodandstructure.com/ibis#responds-to"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#supports" b="https://vocab.methodandstructure.com/ibis#supported-by"/>
  <x:pair a="https://vocab.methodandstructure.com/ibis#opposes" b="https://vocab.methodandstructure.com/ibis#opposed-by"/>
  <!-- pm -->
  <x:pair a="https://vocab.methodandstructure.com/process-model#achieves" b="https://vocab.methodandstructure.com/process-model#achieved-by"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#anchors" b="https://vocab.methodandstructure.com/process-model#anchored-by"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#context" b="https://vocab.methodandstructure.com/process-model#contextualizes"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#dependency" b="https://vocab.methodandstructure.com/process-model#dependency-of"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#initiates" b="https://vocab.methodandstructure.com/process-model#initiated-by"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#method" b="https://vocab.methodandstructure.com/process-model#instance"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#process" b="https://vocab.methodandstructure.com/process-model#outcome"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#subtask" b="https://vocab.methodandstructure.com/process-model#supertask"/>
  <x:pair a="https://vocab.methodandstructure.com/process-model#variant" b="https://vocab.methodandstructure.com/process-model#variant"/>
  <!-- foaf/org -->
  <x:pair a="http://xmlns.com/foaf/0.1/knows" b="http://xmlns.com/foaf/0.1/knows"/>
  <x:pair a="http://www.w3.org/ns/org#hasMember" b="http://www.w3.org/ns/org#memberOf"/>
  <x:pair a="http://www.w3.org/ns/org#hasSubOrganization" b="http://www.w3.org/ns/org#subOrganizatonOf"/>
  <x:pair a="http://www.w3.org/ns/org#hasUnit" b="http://www.w3.org/ns/org#unitOf"/>
</x:inverses>

<!-- XXX i feel like some of this could be SHACL and the rest of it could be the ontologies themselves -->
<!-- maybe make something better like an rdfa page iunno -->
<x:sequence>
  <!-- skos -->
  <x:class uri="http://www.w3.org/2004/02/skos/core#Concept" icon="&#x1f5ed;">
    <x:lprop uri="http://www.w3.org/2004/02/skos/core#prefLabel"/>
    <x:label>Position</x:label>
    <x:prop uri="http://www.w3.org/2004/02/skos/core#broader">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Has Broader</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/2004/02/skos/core#narrower">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Has Narrower</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/2004/02/skos/core#related">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Has Related</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concern-of">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:label>Concern Of</x:label>
    </x:prop>
  </x:class>
  <!-- ibis -->
  <x:class uri="https://vocab.methodandstructure.com/ibis#Issue" icon="&#xf071;">
    <x:lprop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
    <x:label>Issue</x:label>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#response">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Has Response</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#dependency-of">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Dependency Of</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questioned-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Questioned By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questions">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Questions</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggests">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Suggests</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggested-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Suggested By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#generalizes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Generalizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#specializes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Specializes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concerns">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Concerns</x:label>
    </x:prop>
  </x:class>
  <x:class uri="https://vocab.methodandstructure.com/ibis#Position" icon="&#xf0e3;">
    <x:lprop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
    <x:label>Position</x:label>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#responds-to">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Responds To</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#supported-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Supported By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#opposed-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Opposed By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questioned-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Questioned By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggests">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Suggests</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#generalizes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Generalizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#specializes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Specializes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concerns">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Concerns</x:label>
    </x:prop>
  </x:class>
  <x:class uri="https://vocab.methodandstructure.com/ibis#Argument" icon="&#xf086;">
    <x:lprop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
    <x:label>Argument</x:label>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#supports">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Supports</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#opposes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Opposes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#response">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Has Response</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#dependency-of">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Dependency Of</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questioned-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Questioned By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggests">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Suggests</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggested-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Suggested By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#generalizes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Generalizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#specializes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Specializes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concerns">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Concerns</x:label>
    </x:prop>
  </x:class>
  <!-- pm -->
  <x:class uri="https://vocab.methodandstructure.com/process-model#Goal" icon="&#xf11e;">
    <x:lprop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
    <x:label>Goal</x:label>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#achieved-by">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Achieved By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#anchored-by">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:label>Anchored By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#contextualizes">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Contextualizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#response">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Has Response</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#dependency-of">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Dependency Of</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questioned-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Questioned By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questions">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Questions</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggests">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Suggests</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggested-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Suggested By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#generalizes">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Generalizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#specializes">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Specializes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concerns">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Concerns</x:label>
    </x:prop>
  </x:class>
  <x:class uri="https://vocab.methodandstructure.com/process-model#Task" icon="&#xf7d9;">
    <x:lprop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
    <x:label>Task</x:label>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#achieves">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:label>Achieves</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#initiated-by">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:label>Initiated By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#context">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:label>Context</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#responds-to">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Responds To</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#supported-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Supported By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#opposed-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Opposed By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#dependency">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Depends On</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questioned-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Questioned By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggests">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Suggests</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#subtask">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Subtask</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#supertask">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Subtask Of</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#generalizes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Generalizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#specializes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Specializes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concerns">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Concerns</x:label>
    </x:prop>
  </x:class>
  <x:class uri="https://vocab.methodandstructure.com/process-model#Target" icon="&#xf140;">
    <x:lprop uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#value"/>
    <x:label>Target</x:label>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#achieved-by">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Achieved By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#anchored-by">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:label>Anchored By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#contextualizes">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Contextualizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#response">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Has Response</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/process-model#dependency-of">
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Dependency Of</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questioned-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Questioned By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#questions">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Questions</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggests">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Suggests</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#suggested-by">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Position"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Task"/>
      <x:label>Suggested By</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#generalizes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Generalizes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#specializes">
      <x:range uri="https://vocab.methodandstructure.com/ibis#Issue"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Goal"/>
      <x:range uri="https://vocab.methodandstructure.com/process-model#Target"/>
      <x:range uri="https://vocab.methodandstructure.com/ibis#Argument"/>
      <x:label>Specializes</x:label>
    </x:prop>
    <x:prop uri="https://vocab.methodandstructure.com/ibis#concerns">
      <x:range uri="http://www.w3.org/2004/02/skos/core#Concept"/>
      <x:label>Concerns</x:label>
    </x:prop>
  </x:class>
  <!-- foaf/org -->
  <x:class uri="http://xmlns.com/foaf/0.1/Person" icon="&#xf007;">
    <x:lprop uri="http://xmlns.com/foaf/0.1/name"/>
    <x:label>Person</x:label>
    <x:prop uri="http://xmlns.com/foaf/0.1/knows">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Knows</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#memberOf">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>In Organization</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#headOf">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Head Of</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#reportsTo">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Reports To</x:label>
    </x:prop>
  </x:class>
  <x:class uri="http://xmlns.com/foaf/0.1/Group" icon="&#xf0c0;">
    <x:lprop uri="http://xmlns.com/foaf/0.1/name"/>
    <x:label>Group</x:label>
    <x:prop uri="http://xmlns.com/foaf/0.1/member">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Has Member</x:label>
    </x:prop>
  </x:class>
  <x:class uri="http://www.w3.org/ns/org#Organization" icon="&#xf1ad;">
    <x:lprop uri="http://xmlns.com/foaf/0.1/name"/>
    <x:label>Organization</x:label>
    <x:prop uri="http://www.w3.org/ns/org#hasMember">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Has Member</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasSubOrganization">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Has Sub-Organization</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasUnit">
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:label>Has Unit</x:label>
    </x:prop>
  </x:class>
  <x:class uri="http://www.w3.org/ns/org#FormalOrganization" icon="&#xed45;">
    <x:lprop uri="http://xmlns.com/foaf/0.1/name"/>
    <x:label>Formal Organization</x:label>
    <x:prop uri="http://www.w3.org/ns/org#hasMember">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Has Member</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasSubOrganization">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Has Sub-Organization</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#subOrganizationOf">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Sub-Organization Of</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasUnit">
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:label>Has Unit</x:label>
    </x:prop>
  </x:class>
  <x:class uri="http://www.w3.org/ns/org#OrganizationalUnit" icon="&#xe594;">
    <x:lprop uri="http://xmlns.com/foaf/0.1/name"/>
    <x:label>Organizational Unit</x:label>
    <x:prop uri="http://www.w3.org/ns/org#hasMember">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Has Member</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasSubOrganization">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Has Sub-Organization</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#subOrganizationOf">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Sub-Organization Of</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasUnit">
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:label>Has Unit</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#unitOf">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Unit Of</x:label>
    </x:prop>
  </x:class>
  <x:class uri="http://www.w3.org/ns/org#OrganizationalCollaboration" icon="&#xf2b5;">
    <x:lprop uri="http://xmlns.com/foaf/0.1/name"/>
    <x:label>Organizational Collaboration</x:label>
    <x:prop uri="http://www.w3.org/ns/org#hasMember">
      <x:range uri="http://xmlns.com/foaf/0.1/Person"/>
      <x:label>Has Member</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasSubOrganization">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Has Sub-Organization</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#subOrganizationOf">
      <x:range uri="http://www.w3.org/ns/org#Organization"/>
      <x:range uri="http://www.w3.org/ns/org#FormalOrganization"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:range uri="http://www.w3.org/ns/org#OrganizationalCollaboration"/>
      <x:label>Sub-Organization Of</x:label>
    </x:prop>
    <x:prop uri="http://www.w3.org/ns/org#hasUnit">
      <x:range uri="http://www.w3.org/ns/org#OrganizationalUnit"/>
      <x:label>Has Unit</x:label>
    </x:prop>
  </x:class>
</x:sequence>

<x:doc>
  <h2>Utility functions</h2>
</x:doc>

<xsl:template match="html:*" mode="skos:get-schemes">
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

  <xsl:variable name="scheme-type">
    <xsl:call-template name="str:token-intersection">
      <xsl:with-param name="left" select="$type"/>
      <xsl:with-param name="right" select="concat($IBIS, 'Network ', $SKOS, 'ConceptScheme')"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="normalize-space($scheme-type) != ''">
      <xsl:value-of select="$subject"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="_">
	<xsl:apply-templates select="." mode="rdfa:object-resources">
	  <xsl:with-param name="subject" select="$subject"/>
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="predicate" select="concat($SKOS, 'inScheme')"/>
	</xsl:apply-templates>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="rdfa:object-resources">
	  <xsl:with-param name="subject" select="$subject"/>
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="predicate" select="concat($SKOS, 'topConceptOf')"/>
	</xsl:apply-templates>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="rdfa:subject-resources">
	  <xsl:with-param name="object" select="$subject"/>
	  <xsl:with-param name="base" select="$base"/>
	  <xsl:with-param name="predicate" select="concat($SKOS, 'hasTopConcept')"/>
	</xsl:apply-templates>
      </xsl:variable>
      <xsl:call-template name="str:unique-tokens">
	<xsl:with-param name="string" select="normalize-space($_)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<x:doc>
  <h2>skos:get-spaces</h2>
  <p>This is different from <code>cgto:get-spaces</code> insofar as it assumes it's coming from the point of view of a <code>skos:Concept</code> or <code>skos:ConceptScheme</code> (and their IBIS derivatives)</p>
</x:doc>

<xsl:template match="html:*" mode="skos:get-spaces">
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
  <xsl:param name="scheme">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens">
	<xsl:apply-templates select="." mode="skos:get-schemes">
	  <xsl:with-param name="subject" select="$subject"/>
	  <xsl:with-param name="type" select="$type"/>
	</xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>

  <xsl:if test="$scheme != ''">
    <xsl:variable name="root" select="document($scheme)/*"/>
    <xsl:apply-templates select="$root" mode="cgto:get-spaces">
      <xsl:with-param name="subject" select="$scheme"/>
    </xsl:apply-templates>
  </xsl:if>
</xsl:template>


<x:doc>
  <h2>SKOS Concepts</h2>
</x:doc>

<x:doc>
  <h3>Concept head</h3>
</x:doc>


<xsl:template match="html:head" mode="skos:Concept">
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

<x:doc>
  <h3>Concept body</h3>
</x:doc>

<xsl:template match="html:body" mode="skos:Concept">
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

  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <!--
      This will produce all the concept schemes this entity is known
      to participate in.
  -->
  <xsl:variable name="schemes">
    <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
      <xsl:with-param name="subjects" select="$subject"/>
      <xsl:with-param name="predicates" select="'skos:inScheme skos:topConceptOf ^skos:hasTopConcept'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="string-length(normalize-space($schemes))">
      <!-- this is okay, continue -->
      <!--<xsl:apply-templates select="." mode="skos:body-check-space">
      </xsl:apply-templates>-->
    </xsl:when>
    <xsl:otherwise>
      <!-- this concept is not attached to a concept scheme, so defer to a modal to create one -->
      <!--<xsl:apply-templates select="." mode="skos:modal-attach-scheme">
      </xsl:apply-templates>-->
    </xsl:otherwise>
  </xsl:choose>

  <!--
      Okay so first problem here is there may be multiple concept
      schemes. Furthermore the resolution of the space has to be done
      *from* the document that represents the concept scheme. In other
      words, this entity *may* be present in multiple schemes, and
      each scheme *may* be present in multiple spaces. (Though we hope
      this all coalesces to one space. I'm actually thinking more than
      one cgto:Space on a domain managing these types of entities
      should produce an error.)

      *Why* this is a problem is that none of the RDFa stuff I wrote
      actually dereferences the subject document before querying it,
      so I have to patch rdfa:multi-object-resources which means I
      actually have to patch rdfa.xsl.
  -->

  <xsl:variable name="space">
    <xsl:if test="string-length(normalize-space($schemes))">
      <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
	<xsl:with-param name="subjects" select="$schemes"/>
	<!-- XXX there is a bug in the prefix resolution somewhere -->
	<xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#has_space ^http://rdfs.org/sioc/ns#space_of'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <!--
      Given that we potentially have more than one concept scheme, we
      necessarily have to account for more than one space. Here we can
      assert that there should be *exactly one* space for these kinds
      of resources on this domain. So if there are more than one, this
      should throw an (internal) error.

      At any rate, all spaces should converge on the same index,
      because the index (at least *this* index) should be the only one
      on the site. Anything else is an internal error.
  -->

  <xsl:variable name="index">
    <xsl:if test="string-length(normalize-space($space))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$space"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <!--
      At any rate, the (exactly one) index should yield (at most)
      exactly one user, and if it doesn't, that's the signal that
      whoever's looking at this site isn't logged in and therefore not
      entitled to modify anything, so we don't show them the UI for
      modifying anything.
  -->

  <xsl:variable name="user">
    <xsl:if test="string-length(normalize-space($index))">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$index"/>
      <xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#user'"/>
      <xsl:with-param name="traverse" select="true()"/>
    </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <!--
      If, however, there *is* a user, then there should be a state (if
      not there should be a modal that forces the user to define one).
  -->

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

  <!--
      The (application) state importantly is the thing that defines
      the focus for this application.
  -->

  <xsl:variable name="focus">
    <xsl:if test="string-length(normalize-space($state))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$state"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#focus'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <!-- XXX if there is a user there should be a state and a focus; it's not necessary if there is no user -->

  <main>
    <article>
      <hgroup class="self">
        <xsl:apply-templates select="." mode="skos:process-self">
          <xsl:with-param name="base"    select="$base"/>
          <xsl:with-param name="subject" select="$subject"/>
          <xsl:with-param name="type"    select="$type"/>
        </xsl:apply-templates>
      </hgroup>

      <section class="relations">
        <xsl:apply-templates select="." mode="ibis:process-neighbours">
          <xsl:with-param name="base"          select="$base"/>
          <xsl:with-param name="resource-path" select="$resource-path"/>
          <xsl:with-param name="rewrite"       select="$rewrite"/>
          <xsl:with-param name="main"          select="true()"/>
          <xsl:with-param name="heading"       select="$heading"/>
          <xsl:with-param name="subject"       select="$subject"/>
          <xsl:with-param name="type"          select="$type"/>
	  <xsl:with-param name="schemes"       select="$schemes"/>
	  <xsl:with-param name="user"          select="$user"/>
	  <xsl:with-param name="focus"         select="$focus"/>
        </xsl:apply-templates>
      </section>
    </article>
    <figure id="force" class="aside"/>
    <xsl:apply-templates select="." mode="ibis:make-datalist">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
      <xsl:with-param name="main"          select="true()"/>
      <xsl:with-param name="heading"       select="$heading"/>
      <xsl:with-param name="subject"       select="$subject"/>
      <xsl:with-param name="index"         select="$index"/>
    </xsl:apply-templates>
  </main>

  <xsl:apply-templates select="." mode="skos:footer">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
    <xsl:with-param name="type"          select="$type"/>
    <xsl:with-param name="schemes"       select="$schemes"/>
    <xsl:with-param name="space"         select="$space"/>
    <xsl:with-param name="index"         select="$index"/>
    <xsl:with-param name="user"          select="$user"/>
    <xsl:with-param name="state"         select="$state"/>
    <xsl:with-param name="focus"         select="$focus"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="html:body" mode="skos:modal-attach-scheme">
</xsl:template>

<xsl:template match="html:body" mode="cgto:modal-attach-space">
</xsl:template>

<xsl:template match="html:*" mode="cgto:modal-attach-state">
  <!-- we can only do this if we locate a user -->
</xsl:template>

<xsl:template match="html:body" mode="skos:actual-body">
</xsl:template>

<x:doc>
  <h2>skos:footer</h2>
  <p>This is a UI component for <code>skos:Concept</code> (i.e. <code>ibis:Entity</code>)-derived subjects, as well as <code>skos:ConceptScheme</code>/<code>ibis:Network</code> aggregates.</p>
  <p>If it's a concept or derivative thereof (I should really change <code>ibis:Entity</code> to <code>ibis:Statement</code>), it has to first find the <em>scheme</em> it belongs to (via <code>skos:inScheme</code>, <code>skos:topConceptOf</code>, or its inverse, <code>skos:hasTopConcept</code>), otherwise we are currently looking at the scheme.</p>
  <p>We then have to determine if the scheme is in <em>focus</em>. For this we first find the <code>xhv:top</code> (at least for now; I may come up with a better one later) relative to the scheme.</p>
  <aside role="note">
    <p>Note that there is nothing preventing a conceptual entity from belonging to zero schemes, or belonging to more than one scheme. There is furthermore nothing preventing none of the associated schemes from being in focus, although having more than one scheme in focus is an error. (This is partly why I have to change the focus mechanism from being relative to the <em>space</em>, to being relative to the <em>user</em>, not only because it can potentially get into this state in a multiuser system, but also because people will be continually clobbering each other's focus.)</p>
    <p>If a concept belongs to zero schemes, we should throw up a modal to force the user to pick a scheme. We should default to the scheme in focus. If there are other schemes present, we should provide an option to set the focus as well as attach the concept. We should provide a mechanism to create a new scheme (which we assume will attach the concept). There should be an option (default?) to focus a new scheme.</p>
  </aside>
  <p>A concept attached to multiple schemes needs UI to be able to detach from one scheme, but only if there are multiples.</p>
  <p>A concept should also be able to import all of its neighbours into the scheme</p>
  <section>
    <h3>Concept UI</h3>
    <ul>
      <li>
	<p>flyout list of all schemes</p>
	<ul>
	  <li>participating scheme(s) gathered at the top</li>
	  <li>focused scheme at the tippy-top/closed position (if participating)</li>
	  <li>then non-participating schemes, whether focused or not</li>
	  <li>each has a link to the scheme itself</li>
	  <li>unfocused schemes have a set focus button</li>
	  <li>non-participating schemes have attach+set focus, attach+no-focus buttons as well</li>
	</ul>
      </li>
      <li>
	<p>create new scheme UI</p>
	<ul>
	  <li>text box for name</li>
	  <li>attach concept?</li>
	  <li>if current subject is <em>not</em> an <code>ibis:Entity</code>, provide toggle between <code>skos:ConceptScheme</code> and <code>ibis:Network</code></li>
	  <li>go to</li>
	  <li>set focus</li>
	</ul>
      </li>
    </ul>
  </section>
  <section>
    <h3>Scheme UI</h3>
    <ul>
      <li>schemes do not have to worry about attaching concepts, so when the subject location is a scheme, there is only the matter of navigating to another one of the listed schemes, or otherwise focusing it (and presumably navigating to it as well).</li>
      <li>in other words the scheme UI is the same as the concept UI minus all the <em>attach</em> business.</li>
    </ul>
  </section>
</x:doc>

<xsl:template match="html:*" mode="skos:footer">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="schemes">
    <xsl:variable name="_">
      <xsl:call-template name="str:token-intersection">
	<xsl:with-param name="left" select="$type"/>
	<xsl:with-param name="right" select="concat($IBIS, 'Network ', $SKOS, 'ConceptScheme')"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($_))">
	<xsl:value-of select="$subject"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates select="." mode="rdfa:multi-object-resources">
	  <xsl:with-param name="subjects" select="$subject"/>
	  <xsl:with-param name="predicates" select="'skos:inScheme skos:topConceptOf ^skos:hasTopConcept'"/>
	</xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="space">
    <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
      <xsl:with-param name="subjects" select="$schemes"/>
      <xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#has_space ^http://rdfs.org/sioc/ns#space_of'"/>
      <xsl:with-param name="traverse" select="true()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="index">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$space"/>
      <xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
      <xsl:with-param name="traverse" select="true()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="user">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$index"/>
      <xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#user'"/>
      <xsl:with-param name="traverse" select="true()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:param name="state">
    <xsl:if test="string-length($user)">
      <xsl:apply-templates select="." mode="rdfa:subject-resources">
	<xsl:with-param name="object" select="$user"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#owner'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:param>

  <xsl:param name="focus">
    <xsl:if test="string-length($state)">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$state"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#focus'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:param>

  <xsl:variable name="is-scheme" select="contains(concat(' ', $schemes, ' '), concat(' ', $subject, ' '))"/>

  <!--
      * provide some kind of ui for creating a new ibis:Network/skos:ConceptScheme
      * make setting the cgto:focus optional (default??)
  -->
  <xsl:variable name="all-schemes">
    <xsl:variable name="_">
      <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
	<xsl:with-param name="subjects" select="$space"/>
	<xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#space_of ^http://rdfs.org/sioc/ns#has_space'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:message>wat <xsl:value-of select="$_"/></xsl:message>
    <xsl:if test="string-length(normalize-space($_))">
      <xsl:apply-templates select="document($space)/*" mode="rdfa:filter-by-type">
	<xsl:with-param name="subjects" select="$_"/>
	<xsl:with-param name="classes" select="concat($IBIS, 'Network ', $SKOS, 'ConceptScheme')"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <footer>
    <form>
      <button type="button" id="scheme-collapsed">
      <xsl:call-template name="skos:scheme-collapsed-item">
	<xsl:with-param name="schemes"    select="$schemes"/>
	<xsl:with-param name="focus"      select="$focus"/>
      </xsl:call-template>
      </button>
    </form>
    <ul id="scheme-list" class="schemes">
      <!--
      <li>schemes: <xsl:value-of select="$schemes"/></li>
      <li>all schemes: <xsl:value-of select="$all-schemes"/></li>
      <li>space: <xsl:value-of select="$space"/></li>
      <li>index: <xsl:value-of select="$index"/></li>
      <li>user: <xsl:value-of select="$user"/></li>
      <li>state: <xsl:value-of select="$state"/></li>
      <li>focus: <xsl:value-of select="$focus"/></li>-->

      <xsl:call-template name="skos:scheme-item">
	<xsl:with-param name="subject"    select="$subject"/>
	<xsl:with-param name="schemes"    select="$all-schemes"/>
	<xsl:with-param name="attached"   select="$schemes"/>
	<xsl:with-param name="focus"      select="$focus"/>
	<xsl:with-param name="state"      select="$state"/>
	<xsl:with-param name="is-concept" select="not($is-scheme)"/>
      </xsl:call-template>
      <xsl:if test="string-length($state)">
        <!-- get the neighbours of $subject filtered by type -->
	<li>
	  <form class="new-scheme" method="POST" action="">
	    <input type="hidden" name="$ SUBJECT $" value="$NEW_UUID_URN"/>
            <input type="hidden" name="! sioc:space_of :" value="{$space}"/>
	    <xsl:choose>
	      <xsl:when test="false()">
		<label><input name="= rdf:type :" type="radio" value="ibis:Network" checked="checked"/> IBIS Network</label>
	  <xsl:text>&#xa0;</xsl:text>
	  <label><input name="= rdf:type :" value="skos:ConceptScheme" type="radio"/> SKOS Concepts</label>
	      </xsl:when>
	      <xsl:otherwise>
		<input type="hidden" name="= rdf:type :" value="ibis:Network"/>
	      </xsl:otherwise>
	    </xsl:choose>
	    <input type="text" name="= skos:prefLabel" placeholder="Name&#x2026;"/>
	    <xsl:if test="false()">
	      <label><input type="checkbox" name="! skos:inScheme :" value="{$subject}"/> Import this entity</label>
	    </xsl:if>
	    <button>Create</button>
	    <button name="= {$state} cgto:focus :" value="$SUBJECT">+ Focus</button>
	  </form>
	</li>
      </xsl:if>
    </ul>
  </footer>
</xsl:template>

<x:doc>
  <h2>skos:scheme-item-label</h2>
  <p>this is just a plain list</p>
</x:doc>

<xsl:template name="skos:scheme-item-label">
  <xsl:param name="subject" select="''"/>
  <xsl:param name="is-focused" select="false()"/>

  <xsl:variable name="doc" select="document($subject)/*"/>
  <!-- get label shenanigans -->
  <xsl:variable name="label-raw">
    <xsl:apply-templates select="$doc" mode="skos:object-form-label">
      <xsl:with-param name="subject" select="$subject"/>
    </xsl:apply-templates>
  </xsl:variable>
  <xsl:variable name="label-prop" select="substring-before($label-raw, ' ')"/>
  <xsl:variable name="label-val" select="substring-after($label-raw, ' ')"/>
  <xsl:variable name="label" select="substring-before($label-val, $rdfa:UNIT-SEP)"/>
  <xsl:variable name="label-type">
    <xsl:if test="not(starts-with(substring-after($label-val, $rdfa:UNIT-SEP), '@'))">
      <xsl:value-of select="substring-after($label-val, $rdfa:UNIT-SEP)"/>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="label-lang">
    <xsl:if test="starts-with(substring-after($label-val, $rdfa:UNIT-SEP), '@')">
      <xsl:value-of select="substring-after($label-val, concat($rdfa:UNIT-SEP, ' '))"/>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="span">
    <xsl:choose>
      <xsl:when test="$is-focused">strong</xsl:when>
      <xsl:otherwise>span</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$span}">
    <xsl:if test="$label-prop">
      <xsl:attribute name="property">
	<xsl:value-of select="$label-prop"/>
      </xsl:attribute>
      <xsl:if test="$label-type">
	<xsl:attribute name="datatype"><xsl:value-of select="$label-type"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="$label-lang">
	<xsl:attribute name="xml:lang"><xsl:value-of select="$label-lang"/></xsl:attribute>
      </xsl:if>
    </xsl:if>
    <xsl:value-of select="$label"/>
  </xsl:element>
</xsl:template>

<x:doc>
  <h2>skos:scheme-collapsed-item</h2>
  <p>this is just a plain list</p>
</x:doc>

<xsl:template name="skos:scheme-collapsed-item">
  <xsl:param name="schemes" select="''"/>
  <xsl:param name="focus"   select="''"/>

  <xsl:variable name="first">
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($focus)) and contains(concat(' ', $focus, ' '), concat(' ', $schemes, ' '))">
	<xsl:value-of select="normalize-space($focus)"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="str:safe-first-token">
	  <xsl:with-param name="tokens" select="$schemes"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="is-focused" select="normalize-space($focus) = $first"/>

  <xsl:variable name="rest">
    <xsl:choose>
      <xsl:when test="$is-focused">
	<xsl:call-template name="str:token-minus">
	  <xsl:with-param name="tokens" select="$schemes"/>
	  <xsl:with-param name="minus" select="$first"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="substring-after(normalize-space($schemes), ' ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="string-length($first)">
    <xsl:call-template name="skos:scheme-item-label">
      <xsl:with-param name="subject" select="$first"/>
      <xsl:with-param name="is-focused" select="$is-focused"/>
    </xsl:call-template>

    <xsl:if test="string-length($rest)">
      <xsl:text>, </xsl:text>
      <xsl:call-template name="skos:scheme-collapsed-item">
	<xsl:with-param name="schemes" select="$rest"/>
	<xsl:with-param name="focus" select="$focus"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h2>skos:scheme-item</h2>
  <p>okay so this is supposed consume a space-delimited queue of addresses recursively and produce a list of things.</p>
  <p>it needs to know</p>
  <p>XXX THIS IS A DUPLICATE NAME, there is a mode="skos:scheme-item" above </p>
</x:doc>

<xsl:template name="skos:scheme-item">
  <xsl:param name="schemes"  select="''"/>
  <xsl:param name="attached" select="''"/>
  <xsl:param name="focus"    select="''"/>
  <xsl:param name="subject">
    <xsl:message terminate="yes">skos:scheme-item: `subject` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="state">
    <xsl:message terminate="yes">skos:scheme-item: `state` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="is-concept" select="false()"/>

  <xsl:variable name="snorm" select="normalize-space($schemes)"/>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$snorm"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="string-length($first)">
    <xsl:variable name="scheme-doc" select="document($first)/*"/>

    <!-- test if attached -->
    <xsl:variable name="attach-intersection">
      <xsl:call-template name="str:token-intersection">
	<xsl:with-param name="left" select="$first"/>
	<xsl:with-param name="right" select="$attached"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="is-attached" select="string-length($attach-intersection)"/>

    <li>
      <a href="{$first}">
	<xsl:if test="$is-attached">
	  <xsl:attribute name="rel">skos:inScheme</xsl:attribute>
	</xsl:if>
	<xsl:call-template name="skos:scheme-item-label">
	  <xsl:with-param name="subject" select="$first"/>
	  <xsl:with-param name="is-focused" select="$first = $focus"/>
	</xsl:call-template>
      </a>
      <!-- 'set focus' button (if not focused, unconditional) -->
      <xsl:if test="string-length($state)">
	<form method="POST" action="">
	  <xsl:if test="$is-concept">
	    <!-- 'detach' button if attached -->
	    <xsl:choose>
	      <xsl:when test="$is-attached">
		<button name="- skos:inScheme :" value="{$first}">Detach</button>
	      </xsl:when>
	      <xsl:otherwise>
	        <button name="skos:inScheme :" value="{$first}">Attach</button>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:if>
	  <xsl:if test="$first != $focus">
	    <button name="= {$state} cgto:focus :" value="{$first}">Set Focus</button>
	  </xsl:if>
	</form>
      </xsl:if>
    </li>

    <xsl:variable name="rest" select="normalize-space(substring-after($snorm, ' '))"/>
    <xsl:if test="string-length($rest)">
      <xsl:call-template name="skos:scheme-item">
	<xsl:with-param name="subject"    select="$subject"/>
	<xsl:with-param name="schemes"    select="$rest"/>
	<xsl:with-param name="attached"   select="$attached"/>
	<xsl:with-param name="focus"      select="$focus"/>
	<xsl:with-param name="state"      select="$state"/>
	<xsl:with-param name="is-concept" select="$is-concept"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>

</xsl:template>

<x:doc>
  <h3>skos:hidden-subject-inscheme</h3>
</x:doc>

<xsl:template name="skos:hidden-subject-inscheme">
</xsl:template>

<x:doc>
  <h2>skos:footer-option</h2>
</x:doc>

<xsl:template match="html:*" mode="skos:footer-option">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="candidates">
    <xsl:message terminate="yes">`candidates` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="selected">
    <xsl:message terminate="yes">`selected` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="cnorm" select="normalize-space($candidates)"/>

  <xsl:if test="string-length($cnorm)">
    <xsl:variable name="first">
      <xsl:choose>
	<xsl:when test="contains($cnorm, ' ')">
	  <xsl:value-of select="substring-before($cnorm, ' ')"/>
	</xsl:when>
	<xsl:otherwise><xsl:value-of select="$cnorm"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="label-raw">
      <xsl:apply-templates select="." mode="skos:object-form-label">
	<xsl:with-param name="subject" select="$first"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="label-prop" select="substring-before($label-raw, ' ')"/>
    <xsl:variable name="label-val" select="substring-after($label-raw, ' ')"/>
    <xsl:variable name="label" select="substring-before($label-val, $rdfa:UNIT-SEP)"/>
    <xsl:variable name="label-type">
      <xsl:if test="not(starts-with(substring-after($label-val, $rdfa:UNIT-SEP), '@'))">
	<xsl:value-of select="substring-after($label-val, $rdfa:UNIT-SEP)"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="label-lang">
      <xsl:if test="starts-with(substring-after($label-val, $rdfa:UNIT-SEP), '@')">
	<xsl:value-of select="substring-after($label-val, concat($rdfa:UNIT-SEP, ' '))"/>
      </xsl:if>
    </xsl:variable>

    <option about="{$first}" value="{$first}">
      <xsl:if test="$selected and $first = $selected">
	<xsl:attribute name="selected"></xsl:attribute>
      </xsl:if>
      <xsl:if test="$label-prop">
	<xsl:attribute name="property">
	  <xsl:value-of select="$label-prop"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="$label"/>
    </option>

    <xsl:variable name="rest" select="substring-after($cnorm, ' ')"/>
    <xsl:if test="$rest">
      <xsl:apply-templates select="." mode="skos:footer-option">
	<xsl:with-param name="base" select="$base"/>
	<xsl:with-param name="candidates" select="$rest"/>
	<xsl:with-param name="selected" select="$selected"/>
      </xsl:apply-templates>
      </xsl:if>
    </xsl:if>
</xsl:template>

<x:doc>
  <h2>skos:process-self</h2>
</x:doc>

<xsl:template match="html:*" mode="skos:process-self">
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

  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="label">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($SKOS, 'prefLabel')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="definition">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($SKOS, 'definition')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="created">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="'http://purl.org/dc/terms/created'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="creator">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="'http://purl.org/dc/terms/creator'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="name">
    <xsl:if test="string-length(normalize-space($creator))">
      <xsl:variable name="_">
	<xsl:call-template name="uri:document-for-uri">
	  <xsl:with-param name="uri" select="$creator"/>
	</xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="document($_)/*" mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$creator"/>
      <xsl:with-param name="predicate" select="'http://xmlns.com/foaf/0.1/name'"/>
    </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

<h1>
  <form accept-charset="utf-8" action="" method="POST">
    <input type="text" name="= skos:prefLabel" value="{substring-before($label, $rdfa:UNIT-SEP)}"/>
    <button class="fa fa-sync"/>
  </form>
</h1>
<form accept-charset="utf-8" action="" method="POST">
  <textarea class="description" name="= skos:definition">
    <xsl:value-of select="substring-before($definition, $rdfa:UNIT-SEP)"/>
  </textarea>
  <button class="update fa fa-sync"></button>
</form>
<xsl:apply-templates select="." mode="skos:literal-form">
  <xsl:with-param name="base" select="$base"/>
  <xsl:with-param name="subject" select="$subject"/>
</xsl:apply-templates>

<xsl:apply-templates select="." mode="skos:literal-form">
  <xsl:with-param name="base" select="$base"/>
  <xsl:with-param name="subject" select="$subject"/>
  <xsl:with-param name="predicate" select="concat($SKOS, 'hiddenLabel')"/>
  <xsl:with-param name="heading" select="'Hidden Labels'"/>
</xsl:apply-templates>

<xsl:apply-templates select="." mode="skos:object-form">
  <xsl:with-param name="base" select="$base"/>
  <xsl:with-param name="subject" select="$subject"/>
</xsl:apply-templates>

<xsl:apply-templates select="." mode="skos:created-by">
  <xsl:with-param name="base" select="$base"/>
  <xsl:with-param name="subject" select="$subject"/>
</xsl:apply-templates>

</xsl:template>

<x:doc>
  <h2>skos:created-by</h2>
</x:doc>

<xsl:template match="html:*" mode="skos:created-by">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>

  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="created">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="'http://purl.org/dc/terms/created'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="creator">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="'http://purl.org/dc/terms/creator'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="name">
    <xsl:if test="string-length(normalize-space($creator))">
      <xsl:variable name="_">
	<xsl:call-template name="uri:document-for-uri">
	  <xsl:with-param name="uri" select="$creator"/>
	</xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="document($_)/*" mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$creator"/>
      <xsl:with-param name="predicate" select="'http://xmlns.com/foaf/0.1/name'"/>
    </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <span class="date" property="dct:created" content="{substring-before($created, $rdfa:UNIT-SEP)}" datatype="{substring-after($created, $rdfa:UNIT-SEP)}">Created <xsl:value-of select="substring-before($created, 'T')"/>
  <xsl:if test="string-length($creator)">
    <xsl:text> by </xsl:text>
    <a rel="dct:creator" href="{$creator}">
      <xsl:choose>
	<xsl:when test="string-length($name)">
	  <span property="foaf:name">
	    <xsl:value-of select="substring-before($name, $rdfa:UNIT-SEP)"/>
	  </span>
	</xsl:when>
	<xsl:otherwise><xsl:value-of select="$creator"/></xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:if>
  </span>
</xsl:template>

<x:doc>
  <h3>skos:literal-form</h3>
</x:doc>

<xsl:template match="html:*" mode="skos:literal-form">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="predicate" select="concat($SKOS, 'altLabel')"/>
  <xsl:param name="heading" select="'Alternate Labels'"/>

  <xsl:variable name="literals">
    <xsl:apply-templates select="." mode="rdfa:object-literals">
      <xsl:with-param name="subject"   select="$subject"/>
      <xsl:with-param name="base"      select="$base"/>
      <xsl:with-param name="predicate" select="$predicate"/>
    </xsl:apply-templates>
  </xsl:variable>

  <!--<xsl:message><xsl:value-of select="$literals"/></xsl:message>-->

  <aside>
    <h5><xsl:value-of select="$heading"/></h5>
    <ul>
      <xsl:apply-templates select="." mode="skos:literal-form-entry">
        <xsl:with-param name="predicate" select="$predicate"/>
        <xsl:with-param name="literals"    select="$literals"/>
      </xsl:apply-templates>
      <li>
        <form method="POST" action="" accept-charset="utf-8">
          <input type="text" name="{$predicate}"/>
          <button class="fa fa-plus"/>
        </form>
      </li>
    </ul>
  </aside>
</xsl:template>

<xsl:template match="html:*" mode="skos:literal-form-entry">
  <xsl:param name="predicate"/>
  <xsl:param name="literals"/>

  <xsl:variable name="first">
    <xsl:choose>
      <xsl:when test="contains($literals, $rdfa:RECORD-SEP)">
        <xsl:value-of select="substring-before($literals, $rdfa:RECORD-SEP)"/>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$literals"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="string-length($first)">
    <xsl:variable name="value" select="substring-before($first, $rdfa:UNIT-SEP)"/>
    <xsl:variable name="lang-or-dt" select="substring-after($first, $rdfa:UNIT-SEP)"/>
    <xsl:variable name="language">
      <xsl:if test="starts-with($lang-or-dt, '@')">
        <xsl:value-of select="substring-after(normalize-space($lang-or-dt), '@')"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="datatype">
      <xsl:if test="not(string-length($language))">
	<xsl:value-of select="$lang-or-dt"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="designator">
      <xsl:choose>
        <xsl:when test="string-length($datatype)">
          <xsl:text> ^</xsl:text>
          <xsl:value-of select="$datatype"/>
        </xsl:when>
        <xsl:when test="string-length($language)">
          <xsl:text> @</xsl:text>
          <xsl:value-of select="$language"/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>

    <li>
      <form method="POST" action="" accept-charset="utf-8">
      <span property="{$predicate}">
        <xsl:if test="string-length($language)">
          <xsl:attribute name="xml:lang"><xsl:value-of select="$language"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="string-length($datatype)">
          <xsl:attribute name="datatype"><xsl:value-of select="$datatype"/></xsl:attribute>
        </xsl:if>
        <xsl:value-of select="$value"/>
      </span>
        <button class="disconnect fa fa-times" name="- {$predicate}{$designator}" value="{$value}"></button>
      </form>
    </li>

    <xsl:variable name="rest" select="substring-after($literals, $rdfa:RECORD-SEP)"/>
    <xsl:if test="string-length($rest)">
      <xsl:apply-templates select="." mode="skos:literal-form-entry">
        <xsl:with-param name="predicate" select="$predicate"/>
        <xsl:with-param name="literals" select="$rest"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>skos:object-form</h3>
</x:doc>

<xsl:template match="html:*" mode="skos:object-form">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="predicate" select="concat($RDFS, 'seeAlso')"/>
  <xsl:param name="heading" select="'See Also'"/>
  <xsl:param name="can-write" select="false()"/>

  <xsl:variable name="objects">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject"   select="$subject"/>
      <xsl:with-param name="base"      select="$base"/>
      <xsl:with-param name="predicate" select="$predicate"/>
    </xsl:apply-templates>
  </xsl:variable>

  <!--<xsl:message><xsl:value-of select="$labels"/></xsl:message>-->

  <aside>
    <h5><xsl:value-of select="$heading"/></h5>
    <ul>
      <xsl:apply-templates select="." mode="skos:object-form-entry">
        <xsl:with-param name="predicate" select="$predicate"/>
        <xsl:with-param name="objects"   select="$objects"/>
        <xsl:with-param name="can-write" select="$can-write"/>
      </xsl:apply-templates>
      <xsl:if test="$can-write">
      <li>
        <form method="POST" action="" accept-charset="utf-8">
          <input type="text" name="{$predicate} :"/>
          <button class="fa fa-plus"/>
        </form>
      </li>
      </xsl:if>
    </ul>
  </aside>
</xsl:template>

<x:doc>
  <h3>skos:object-form-entry</h3>
</x:doc>

<xsl:template match="html:*" mode="skos:object-form-entry">
  <xsl:param name="predicate"/>
  <xsl:param name="objects"/>
  <xsl:param name="can-write"/>

  <xsl:variable name="o" select="normalize-space($objects)"/>

  <xsl:variable name="first">
    <xsl:choose>
      <xsl:when test="contains($o, ' ')">
        <xsl:value-of select="substring-before($o, ' ')"/>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$o"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="string-length($first)">
    <xsl:variable name="label">
      <xsl:variable name="_">
	<xsl:apply-templates select="." mode="skos:object-form-label">
	  <xsl:with-param name="subject" select="$first"/>
	</xsl:apply-templates>
      </xsl:variable>
      <xsl:value-of select="normalize-space($_)"/>
    </xsl:variable>
    <li>
      <form method="POST" action="" accept-charset="utf-8">
	<a rel="{$predicate}" href="{$first}">
	  <xsl:choose>
	    <xsl:when test="string-length($label)">
	      <xsl:variable name="raw" select="substring-after($label, ' ')"/>
	      <xsl:variable name="literal" select="substring-before($raw, $rdfa:UNIT-SEP)"/>
	      <xsl:variable name="dt" select="substring-after($raw, $rdfa:UNIT-SEP)"/>
	      <span property="{substring-before($label, ' ')}">
		<xsl:choose>
		  <xsl:when test="starts-with($dt, '@')">
		    <xsl:attribute name="xml:lang"><xsl:value-of select="$dt"/></xsl:attribute>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:attribute name="datatype"><xsl:value-of select="$dt"/></xsl:attribute>
		  </xsl:otherwise>
		</xsl:choose>
	      <xsl:value-of select="$literal"/></span>
	    </xsl:when>
	    <xsl:otherwise><xsl:value-of select="$first"/></xsl:otherwise>
	  </xsl:choose>
	</a>
        <xsl:if test="$can-write">
	  <button class="disconnect fa fa-times" name="- {$predicate} :" value="{$first}"></button>
        </xsl:if>
      </form>
    </li>
    <xsl:variable name="rest" select="substring-after($o, ' ')"/>
    <xsl:if test="string-length($rest)">
      <xsl:apply-templates select="." mode="skos:object-form-entry">
        <xsl:with-param name="predicate" select="$predicate"/>
        <xsl:with-param name="objects" select="$rest"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>skos:object-form-label</h3>
</x:doc>

<xsl:template match="html:*" mode="skos:object-form-label">
  <xsl:param name="subject"/>
  <xsl:param name="predicates" select="document('')/xsl:stylesheet/x:lprops/x:prop/@uri"/>

  <xsl:if test="count($predicates)">
    <!--<xsl:message>PREDICATE LOL <xsl:value-of select="concat($subject, ' ', $predicates[1])"/></xsl:message>-->
    <xsl:variable name="out">
      <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
	<xsl:with-param name="subject" select="$subject"/>
	<xsl:with-param name="predicate" select="normalize-space($predicates[1])"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($out))">
	<!--<xsl:message>FOUND <xsl:value-of select="$out"/></xsl:message>-->
	<xsl:value-of select="concat($predicates[1], ' ', $out)"/>
      </xsl:when>
      <xsl:when test="count($predicates[position() &gt; 1])">
	<xsl:apply-templates select="." mode="skos:object-form-label">
	  <xsl:with-param name="subject" select="$subject"/>
	  <xsl:with-param name="predicates" select="$predicates[position() &gt; 1]"/>
	</xsl:apply-templates>
      </xsl:when>
    </xsl:choose>
  </xsl:if>
</xsl:template>

<x:doc>
  <h2>Concept Schemes</h2>
</x:doc>

<x:doc>
  <h3>Concept scheme head</h3>
</x:doc>

<xsl:template match="html:head" mode="skos:ConceptScheme">
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

<x:doc>
  <h3>Concept scheme body</h3>
</x:doc>

<xsl:template match="html:body" mode="skos:ConceptScheme">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>

  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="space">
    <xsl:if test="string-length(normalize-space($subject))">
      <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
	<xsl:with-param name="subjects" select="$subject"/>
	<!-- XXX there is a bug in the prefix resolution somewhere -->
	<xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#has_space ^http://rdfs.org/sioc/ns#space_of'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="index">
    <xsl:if test="string-length(normalize-space($space))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$space"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
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

  <xsl:variable name="top-concepts">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($SKOS, 'hasTopConcept')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="in-scheme">
    <xsl:call-template name="str:token-minus">
      <xsl:with-param name="tokens">
        <xsl:apply-templates select="." mode="rdfa:subject-resources">
          <xsl:with-param name="object" select="$subject"/>
          <xsl:with-param name="base" select="$base"/>
          <xsl:with-param name="predicate" select="concat($SKOS, 'inScheme')"/>
        </xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="minus" select="$top-concepts"/>
    </xsl:call-template>
  </xsl:variable>

  <main>
    <article>
      <form method="POST" action="" accept-charset="utf-8">
        <input type="hidden" name="$ SUBJECT $" value="$NEW_UUID_URN"/>
        <input type="hidden" name="rdf:type :" value="skos:Concept"/>
        <input type="hidden" name="skos:inScheme :" value="{$subject}"/>
	<input type="hidden" name="dct:created ^xsd:dateTime $" value="$NEW_TIME_UTC"/>
	<input type="hidden" name="dct:creator :" value="{$user}"/>
        <input type="text" name="= skos:prefLabel"/>
        <button class="fa fa-plus"/>
      </form>
      <ul>
        <xsl:if test="string-length(normalize-space($top-concepts))">
          <xsl:apply-templates select="." mode="skos:scheme-item">
            <xsl:with-param name="resources" select="normalize-space($top-concepts)"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="string-length(normalize-space($in-scheme))">
          <xsl:apply-templates select="." mode="skos:scheme-item">
            <xsl:with-param name="resources" select="normalize-space($in-scheme)"/>
          </xsl:apply-templates>
        </xsl:if>
      </ul>
    </article>
    <figure id="force" class="aside"/>
  </main>

  <xsl:apply-templates select="." mode="skos:footer">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
    <xsl:with-param name="space"         select="$space"/>
    <xsl:with-param name="index"         select="$index"/>
    <xsl:with-param name="user"          select="$user"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>skos:scheme-item MODE</h3>
  <p>we really need to sort out this terminology</p>
</x:doc>

<xsl:template match="html:*" mode="skos:scheme-item">
  <xsl:param name="resources">
    <xsl:message terminate="yes">`resources` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="lprop" select="concat($SKOS, 'prefLabel')"/>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$resources"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="types">
    <xsl:call-template name="rdfa:make-curie-list">
      <xsl:with-param name="list">
        <xsl:apply-templates select="." mode="rdfa:object-resources">
          <xsl:with-param name="subject" select="$first"/>
          <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="lpc">
    <xsl:call-template name="rdfa:make-curie">
      <xsl:with-param name="uri" select="$lprop"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="label">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$first"/>
      <xsl:with-param name="predicate" select="$lprop"/>
    </xsl:apply-templates>
  </xsl:variable>

  <li>
    <a href="{$first}">
      <xsl:if test="string-length($types)">
        <xsl:attribute name="typeof"><xsl:value-of select="$types"/></xsl:attribute>
      </xsl:if>
      <span property="{$lpc}">
        <xsl:choose>
          <xsl:when test="contains(substring-after($label, $rdfa:UNIT-SEP), ':')">
            <xsl:attribute name="datatype">
              <xsl:value-of select="substring-after($label, $rdfa:UNIT-SEP)"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="string-length(substring-after($label, $rdfa:UNIT-SEP))">
            <xsl:attribute name="xml:lang">
              <xsl:value-of select="substring-after($label, $rdfa:UNIT-SEP)"/>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
        <xsl:value-of select="substring-before($label, $rdfa:UNIT-SEP)"/>
      </span>
    </a>
  </li>

  <xsl:variable name="rest" select="substring-after(normalize-space($resources), ' ')"/>
  <xsl:if test="string-length($rest)">
    <xsl:apply-templates select="." mode="skos:scheme-item">
      <xsl:with-param name="resources" select="$rest"/>
      <xsl:with-param name="lprop" select="$lprop"/>
    </xsl:apply-templates>
  </xsl:if>
</xsl:template>

<x:doc>
  <h2>IBIS Entities</h2>
</x:doc>

<x:doc>
  <h3>Entity head</h3>
  <p>Resources we need:</p>
  <ul>
    <li>The <em>space</em>, to fetch CSS/JavaScript for the whole app</li>
  </ul>
</x:doc>

<xsl:template match="html:head" mode="ibis:Entity">
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

<x:doc>
  <h3>Entity body</h3>
  <p>Resources we need:</p>
  <ul>
    <li>The <em>user</em>, if present, to determine whether the UI renders writing widgets, and to attribute changes/endorsements</li>
    <li>The <em>focus</em> (contingent on the user), to determine which concept scheme (and/or IBIS network) to attach new entities to</li>
  </ul>
</x:doc>

<xsl:template match="html:body" mode="ibis:Entity">
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
  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <!--
      this has gotta have all the same stuff as the skos concept
  -->
  <xsl:variable name="schemes">
    <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
      <xsl:with-param name="subjects" select="$subject"/>
      <xsl:with-param name="predicates" select="'skos:inScheme skos:topConceptOf ^skos:hasTopConcept'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="space">
    <xsl:if test="string-length(normalize-space($schemes))">
      <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
	<xsl:with-param name="subjects" select="$schemes"/>
	<!-- XXX there is a bug in the prefix resolution somewhere -->
	<xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#has_space ^http://rdfs.org/sioc/ns#space_of'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="index">
    <xsl:if test="string-length(normalize-space($space))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$space"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
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
	<xsl:with-param name="debug" select="false()"/>
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

  <main>
    <article>
      <hgroup class="self">
        <xsl:apply-templates select="." mode="ibis:process-self">
          <xsl:with-param name="base"    select="$base"/>
          <xsl:with-param name="subject" select="$subject"/>
          <xsl:with-param name="type"    select="$type"/>
          <xsl:with-param name="user"    select="$user"/>
        </xsl:apply-templates>
        <!--
        <p>subject: <xsl:value-of select="$subject"/></p>
        <p>type: <xsl:value-of select="$type"/></p>
        <p>schemes: <xsl:value-of select="$schemes"/></p>
        <p>space: <xsl:value-of select="$space"/></p>
        <p>index: <xsl:value-of select="$index"/></p>
        <p>user: <xsl:value-of select="$user"/></p>
        <p>focus: <xsl:value-of select="$focus"/></p>-->
      </hgroup>

      <section class="relations">
        <xsl:apply-templates select="." mode="ibis:process-neighbours">
          <xsl:with-param name="base"          select="$base"/>
          <xsl:with-param name="resource-path" select="$resource-path"/>
          <xsl:with-param name="rewrite"       select="$rewrite"/>
          <xsl:with-param name="main"          select="true()"/>
          <xsl:with-param name="heading"       select="$heading"/>
          <xsl:with-param name="subject"       select="$subject"/>
          <xsl:with-param name="type"          select="$type"/>
	  <xsl:with-param name="schemes"       select="$schemes"/>
	  <xsl:with-param name="user"          select="$user"/>
	  <xsl:with-param name="focus"         select="$focus"/>
          </xsl:apply-templates>
      </section>
    </article>
    <!--<h1>index: <xsl:value-of select="$index"/> user: <xsl:value-of select="$user"/> state: <xsl:value-of select="$state"/> focus: <xsl:value-of select="$focus"/></h1>-->
    <figure id="force" class="aside"/>
    <xsl:apply-templates select="." mode="ibis:make-datalist">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
      <xsl:with-param name="main"          select="true()"/>
      <xsl:with-param name="heading"       select="$heading"/>
      <xsl:with-param name="subject"       select="$subject"/>
      <xsl:with-param name="index"         select="$index"/>
    </xsl:apply-templates>
  </main>

  <xsl:apply-templates select="." mode="skos:footer">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
    <xsl:with-param name="type"          select="$type"/>
    <xsl:with-param name="schemes"       select="$schemes"/>
    <xsl:with-param name="space"         select="$space"/>
    <xsl:with-param name="index"         select="$index"/>
    <xsl:with-param name="user"          select="$user"/>
    <xsl:with-param name="state"         select="$state"/>
    <xsl:with-param name="focus"         select="$focus"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>ibis:endorsements</h3>
</x:doc>

<xsl:template match="html:*" mode="ibis:endorsements">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:message terminate="yes">`subject` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="user">
    <xsl:message terminate="yes">`user` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="endorsements">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="concat($IBIS, 'endorsed-by')"/>
    </xsl:apply-templates>
  </xsl:variable>
  <xsl:variable name="i-endorse" select="string-length($user) and contains(concat(' ', normalize-space($endorsements), ' '), concat(' ', normalize-space($user), ' '))"/>

  <xsl:message>endorsements: <xsl:value-of select="$endorsements"/></xsl:message>

  <ul rel="ibis:endorsed-by">
    <xsl:call-template name="ibis:one-endorsement">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="endorsements" select="$endorsements"/>
      <xsl:with-param name="user" select="$user"/>
    </xsl:call-template>

    <xsl:if test="string-length($user)">
      <li>
        <form method="POST" action="">
          <xsl:choose>
            <xsl:when test="$i-endorse">
              <button name="- ibis:endorsed-by :" value="{$user}" class="fa-solid fa-thumbs-up"/>
            </xsl:when>
            <xsl:otherwise>
              <button name="ibis:endorsed-by :" value="{$user}" class="fa-regular fa-thumbs-up"/>
            </xsl:otherwise>
          </xsl:choose>
        </form>
      </li>
    </xsl:if>
  </ul>
</xsl:template>

<x:doc>
  <h3>ibis:endorsements</h3>
</x:doc>

<xsl:template name="ibis:one-endorsement">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="endorsements">
    <xsl:message terminate="yes">`endorsements` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="user">
    <xsl:message terminate="yes">`user` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$endorsements"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="string-length($first)">
    <xsl:variable name="name">
      <xsl:variable name="_">
        <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
          <xsl:with-param name="base"      select="$base"/>
          <xsl:with-param name="subject"   select="$first"/>
          <xsl:with-param name="predicate" select="concat($FOAF, 'name')"/>
        </xsl:apply-templates>
      </xsl:variable>
      <xsl:value-of select="substring-before($_, $rdfa:UNIT-SEP)"/>
    </xsl:variable>

    <li><a href="{$first}" property="foaf:name"><xsl:value-of select="$name"/></a></li>

    <xsl:variable name="rest" select="substring-after(normalize-space($endorsements), ' ')"/>
    <xsl:if test="$rest">
      <xsl:call-template name="ibis:one-endorsement">
        <xsl:with-param name="base"         select="$base"/>
        <xsl:with-param name="endorsements" select="$rest"/>
        <xsl:with-param name="user"         select="$user"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h2>ibis:make-datalist</h2>
  <p>This is the outer envelope of the datalist function that goes and fetches the inventories (which may or may not be windows)</p>
</x:doc>

<xsl:template match="html:*" mode="ibis:make-datalist">
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
  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="spaces">
    <xsl:apply-templates select="." mode="skos:get-spaces">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="index">
    <xsl:message terminate="yes">`index` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="search-types" select="concat($SKOS, 'Concept')"/>
  <xsl:param name="inferred" select="true()"/>
  <xsl:param name="id" select="'big-friggin-list'"/>


  <xsl:variable name="inventories">
    <xsl:apply-templates select="document($index)/*" mode="cgto:find-inventories-by-class">
      <xsl:with-param name="classes" select="$search-types"/>
      <xsl:with-param name="inferred" select="$inferred"/>
    </xsl:apply-templates>
  </xsl:variable>

  <datalist id="{$id}">
    <xsl:if test="string-length(normalize-space($inventories))">
      <xsl:apply-templates select="." mode="ibis:datalist-start">
        <xsl:with-param name="inventories" select="$inventories"/>
      </xsl:apply-templates>
    </xsl:if>
  </datalist>
</xsl:template>

<x:doc>
  <h2>ibis:datalist-start</h2>
  <p>The purpose of this is to handle the redirect that happens from the inventory to the window <em>over</em> the inventory.</p>
</x:doc>

<xsl:template match="html:*" mode="ibis:datalist-start">
  <xsl:param name="inventories" select="''"/>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$inventories"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- unlikely but whatever -->
  <xsl:variable name="doc">
    <xsl:call-template name="uri:document-for-uri">
      <xsl:with-param name="uri" select="$first"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="root" select="document($doc)/*"/>
  <xsl:variable name="subject">
    <xsl:apply-templates select="$root" mode="rdfa:get-subject"/>
  </xsl:variable>
  <xsl:variable name="type">
  </xsl:variable>
  <!-- handle window -->

  <xsl:apply-templates select="$root" mode="ibis:datalist-window">
    <xsl:with-param name="window" select="$subject"/>
    <xsl:with-param name="inventory" select="$first">
    </xsl:with-param>
  </xsl:apply-templates>

  <xsl:variable name="rest" select="substring-after(normalize-space($inventories), ' ')"/>
  <xsl:if test="string-length($rest)">
    <xsl:apply-templates select="." mode="ibis:datalist-start">
      <xsl:with-param name="inventories" select="$rest"/>
    </xsl:apply-templates>
  </xsl:if>
</xsl:template>

<x:doc>
  <h2>ibis:datalist-window</h2>
  <p>this is the thing that iterates over individual windows</p>
</x:doc>

<xsl:template match="html:*" mode="ibis:datalist-window">
  <xsl:param name="window" select="''"/>
  <xsl:param name="inventory" select="''"/>
  <xsl:param name="state" select="''"/>

  <xsl:message>inventory: <xsl:value-of select="$inventory"/> window: <xsl:value-of select="$window"/></xsl:message>

  <xsl:apply-templates select="." mode="ibis:datalist-options">
    <xsl:with-param name="inventories" select="$inventory"/>
  </xsl:apply-templates>

  <xsl:variable name="next">
    <xsl:variable name="_">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$window"/>
	<xsl:with-param name="predicate" select="concat($XHV, 'next')"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$_"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="string-length($next)">
    <xsl:message>next: <xsl:value-of select="$next"/></xsl:message>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>ibis:datalist-options</h3>
</x:doc>

<xsl:template match="html:*" mode="ibis:datalist-options">
  <xsl:param name="inventories">
    <xsl:message terminate="yes">`inventories` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$inventories"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="string-length($first)">
    <xsl:variable name="doc">
      <xsl:call-template name="uri:document-for-uri">
        <xsl:with-param name="uri" select="$first"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="root" select="document($doc)/*"/>

    <xsl:variable name="resources">
      <xsl:apply-templates select="$root/html:body" mode="rdfa:object-resources">
        <xsl:with-param name="subject" select="$first"/>
        <xsl:with-param name="base"    select="$doc"/>
        <xsl:with-param name="predicate" select="concat($RDFS, 'member')"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:message><xsl:value-of select="$first"/></xsl:message>

    <xsl:apply-templates select="$root" mode="ibis:actual-option">
      <xsl:with-param name="inventory" select="$first"/>
      <xsl:with-param name="resources" select="$resources"/>
    </xsl:apply-templates>

    <xsl:variable name="rest" select="normalize-space(substring-after(normalize-space($inventories), ' '))"/>
    <xsl:if test="string-length($rest)">
      <xsl:apply-templates select="." mode="ibis:datalist-options">
        <xsl:with-param name="inventories" select="$rest"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>ibis:actual-option</h3>
</x:doc>

<xsl:template match="html:*" mode="ibis:actual-option">
  <xsl:param name="inventory">
    <xsl:message terminate="yes">`inventory` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="resources">
    <xsl:message terminate="yes">`resources` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="first">
    <xsl:call-template name="str:safe-first-token">
      <xsl:with-param name="tokens" select="$resources"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="string-length($first)">

    <xsl:variable name="types">
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="subject" select="$first"/>
        <!--<xsl:with-param name="base" select="$first"/>-->
        <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
      </xsl:apply-templates>
      <xsl:text> </xsl:text>
    </xsl:variable>

    <xsl:variable name="sequence" select="document('')/xsl:stylesheet/x:sequence[1]"/>
    <xsl:variable name="lprop" select="$sequence/x:class[contains($types, @uri)]/x:lprop/@uri"/>

    <xsl:variable name="type-curie">
      <xsl:call-template name="rdfa:make-curie-list">
        <xsl:with-param name="list" select="$types"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="lprop-curie">
      <xsl:call-template name="rdfa:make-curie-list">
        <xsl:with-param name="list" select="$lprop"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
        <xsl:with-param name="subject" select="$first"/>
        <xsl:with-param name="predicate" select="$lprop"/>
      </xsl:apply-templates>
    </xsl:variable>

    <option about="{$first}" typeof="{$type-curie}" value="{$first}" property="{$lprop-curie}">
      <xsl:value-of select="substring-before($label, $rdfa:UNIT-SEP)"/>
    </option>

    <xsl:variable name="rest" select="normalize-space(substring-after(normalize-space($resources), ' '))"/>
    <xsl:if test="string-length($rest)">
      <xsl:apply-templates select="." mode="ibis:actual-option">
        <xsl:with-param name="inventory" select="$inventory"/>
        <xsl:with-param name="resources" select="$rest"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>ibis:process-self</h3>
</x:doc>

<xsl:template match="html:*" mode="ibis:process-self">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite"       select="''"/>
  <xsl:param name="main"          select="false()"/>
  <xsl:param name="heading"       select="0"/>

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

  <xsl:param name="user">
    <xsl:message terminate="yes">`user` parameter required</xsl:message>
  </xsl:param>

  <xsl:param name="can-write" select="normalize-space($user) != ''"/>

  <xsl:variable name="value">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($rdfa:RDF-NS, 'value')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="created">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($DCT, 'created')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="creator">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="concat($DCT, 'creator')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="name">
    <xsl:if test="string-length(normalize-space($creator))">
      <xsl:variable name="_">
	<xsl:call-template name="uri:document-for-uri">
	  <xsl:with-param name="uri" select="$creator"/>
	</xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="document($_)/*" mode="rdfa:object-literal-quick">
      <xsl:with-param name="subject" select="$creator"/>
      <xsl:with-param name="predicate" select="concat($FOAF, 'name')"/>
    </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <h1 class="heading">
    <xsl:choose>
      <xsl:when test="$can-write">
        <xsl:call-template name="ibis:toggle-list">
          <xsl:with-param name="type" select="$type"/>
        </xsl:call-template>
        <form accept-charset="utf-8" action="" class="description" method="POST">
          <textarea class="heading" name="= rdf:value"><xsl:value-of select="substring-before($value, $rdfa:UNIT-SEP)"/></textarea>
          <button class="fa fa-sync" title="Save Text"></button>
        </form>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="property">rdf:value</xsl:attribute>
        <xsl:value-of select="substring-before($value, $rdfa:UNIT-SEP)"/>
      </xsl:otherwise>
    </xsl:choose>
  </h1>

  <xsl:apply-templates select="." mode="skos:created-by">
    <xsl:with-param name="base" select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
  </xsl:apply-templates>

  <xsl:apply-templates select="." mode="skos:referenced-by-inset">
    <xsl:with-param name="base" select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
    <xsl:with-param name="can-write" select="$can-write"/>
  </xsl:apply-templates>

  <xsl:apply-templates select="." mode="skos:object-form">
    <xsl:with-param name="base" select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
    <xsl:with-param name="can-write" select="$can-write"/>
  </xsl:apply-templates>

  <xsl:apply-templates select="." mode="ibis:endorsements">
    <xsl:with-param name="base" select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
    <xsl:with-param name="user" select="$user"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>skos:referenced-by-inset</h3>
</x:doc>

<xsl:template match="html:*" mode="skos:referenced-by-inset">
  <aside>
    <h5>Referenced By</h5>
  </aside>
</xsl:template>

<x:doc>
  <h3>ibis:process-neighbours</h3>
</x:doc>

<xsl:template match="html:*" mode="ibis:process-neighbours">
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
  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="schemes">
    <xsl:message terminate="yes">`schemes` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="user">
    <xsl:message terminate="yes">`user` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="focus">
    <xsl:message terminate="yes">`focus` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="has-focus" select="string-length(normalize-space($focus)) and contains(concat(' ', normalize-space($schemes), ' '), concat(' ', $focus, ' '))"/>
  <xsl:variable name="can-write" select="$user and $has-focus"/>

  <xsl:variable name="current" select="."/>
  <xsl:variable name="sequence" select="document('')/xsl:stylesheet/x:sequence[1]"/>


  <xsl:for-each select="$sequence/x:class[@uri = $type]/x:prop">
    <xsl:variable name="targets">
      <xsl:apply-templates select="$current" mode="rdfa:object-resources">
        <xsl:with-param name="subject" select="$subject"/>
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="predicate" select="@uri"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="has-targets" select="normalize-space($targets) != ''"/>

    <xsl:variable name="curie">
      <xsl:call-template name="rdfa:make-curie">
        <xsl:with-param name="uri" select="@uri"/>
        <xsl:with-param name="node" select="$current"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:comment>curie: <xsl:value-of select="$curie"/></xsl:comment>

    <xsl:if test="$can-write or $has-targets">
      <section about="{@uri}">
        <h3 property="rdfs:label"><xsl:value-of select="x:label"/></h3>
        <xsl:if test="$can-write">
          <xsl:apply-templates select="." mode="ibis:add-relation">
            <xsl:with-param name="base"    select="$base"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="subject" select="$subject"/>
            <xsl:with-param name="schemes" select="$schemes"/>
            <xsl:with-param name="user"    select="$user"/>
            <xsl:with-param name="focus"   select="$focus"/>
          </xsl:apply-templates>
        </xsl:if>
        <xsl:if test="$has-targets">
	  <ul><!-- about="{$base}" rel="{$curie}">-->
	    <xsl:attribute name="about"/>
	    <xsl:attribute name="rel"><xsl:value-of select="$curie"/></xsl:attribute>
            <xsl:apply-templates select="$current" mode="ibis:link-stack">
              <xsl:with-param name="base"          select="$base"/>
              <xsl:with-param name="resource-path" select="$resource-path"/>
              <xsl:with-param name="rewrite"       select="$rewrite"/>
              <xsl:with-param name="main"          select="$main"/>
              <xsl:with-param name="heading"       select="$heading"/>
              <xsl:with-param name="predicate"     select="@uri"/>
              <xsl:with-param name="stack"         select="$targets"/>
              <xsl:with-param name="can-write"     select="$can-write"/>
            </xsl:apply-templates>
          </ul>
        </xsl:if>
      </section>
    </xsl:if>
  </xsl:for-each>

</xsl:template>

<x:doc>
  <h3>ibis:add-relation</h3>
</x:doc>

<xsl:template match="x:prop" mode="ibis:add-relation">
  <xsl:param name="base" select="/.."/>
  <xsl:param name="current" select="/.."/>
  <xsl:param name="subject">
    <xsl:apply-templates select="$current" mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="schemes">
    <xsl:message terminate="yes">`schemes` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="user">
    <xsl:message terminate="yes">`user` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="focus">
    <xsl:message terminate="yes">`focus` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="predicate" select="string(@uri)"/>

  <xsl:variable name="p-curie">
    <xsl:call-template name="rdfa:make-curie">
      <xsl:with-param name="uri" select="@uri"/>
      <xsl:with-param name="node" select="$current"/>
    </xsl:call-template>
  </xsl:variable>

 <xsl:variable name="inverse">
    <xsl:variable name="_" select="document('')/xsl:stylesheet/x:inverses"/>
    <xsl:value-of select="($_/x:pair[@a=$predicate]/@b|$_/x:pair[@b=$predicate]/@a)[1]"/>
  </xsl:variable>

  <xsl:variable name="i-curie">
    <xsl:call-template name="rdfa:make-curie">
      <xsl:with-param name="uri" select="$inverse"/>
      <xsl:with-param name="node" select="$current"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="prefixes">
    <xsl:apply-templates select="$current" mode="rdfa:merge-prefixes">
      <xsl:with-param name="with" select="'ci: https://vocab.methodandstructure.com/content-inventory# cgto: https://vocab.methodandstructure.com/graph-tool# dct: http://purl.org/dc/terms/ foaf: http://xmlns.com/foaf/0.1/ ibis: https://vocab.methodandstructure.com/ibis# pm: https://vocab.methodandstructure.com/process-model# rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns# rdfs: http://www.w3.org/2000/01/rdf-schema# xsd: http://www.w3.org/2001/XMLSchema#'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="sequence" select="document('')/xsl:stylesheet/x:sequence[1]"/>
  <!--<h1>focus <xsl:value-of select="$focus"/></h1>-->

  <form method="POST" action="" accept-charset="utf-8">
    <input class="new" type="hidden" name="$ SUBJECT $" value="$NEW_UUID_URN"/>
    <input class="new" type="hidden" name="{$i-curie} :" value="{$base}"/>
    <input class="new" type="hidden" name="dct:created ^xsd:dateTime $" value="$NEW_TIME_UTC"/>
    <input class="new" type="hidden" name="dct:creator :" value="{$user}"/>
    <!-- not sure yet if i want this to attach to all schemes or just the focused one -->
    <input class="new" type="hidden" name="skos:inScheme :" value="{$focus}"/>
    <!--
    <xsl:apply-templates select="$current" mode="ibis:add-hidden-inscheme">
      <xsl:with-param name="schemes" select="$schemes"/>
    </xsl:apply-templates>-->

    <xsl:for-each select="x:range">
      <xsl:variable name="class" select="$sequence/x:class[@uri = current()/@uri]"/>
      <xsl:variable name="label" select="normalize-space($class/x:label[1])"/>
      <xsl:variable name="c-curie">
        <xsl:call-template name="rdfa:make-curie">
          <xsl:with-param name="uri" select="$class/@uri"/>
          <xsl:with-param name="node" select="$current"/>
	  <xsl:with-param name="prefixes" select="$prefixes"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="lprop" select="$class/x:lprop[1]/@uri"/>
      <xsl:variable name="lprop-curie">
        <xsl:call-template name="rdfa:make-curie-list">
          <xsl:with-param name="list" select="$lprop"/>
          <xsl:with-param name="node" select="$current"/>
	  <xsl:with-param name="prefixes" select="$prefixes"/>
        </xsl:call-template>
      </xsl:variable>
      <!-- safari requires tabindex for :focus-within to work -->
      <input tabindex="{count(preceding-sibling::x:range)}" type="radio" class="fa" name="$ type" value="{$c-curie}" aria-label="{$label}" title="{$label}"/>
      <input about="{$c-curie}" class="new label" disabled="disabled" type="hidden" name="= {$lprop-curie} $" value="$label"/>
    </xsl:for-each>
    <input class="new" type="hidden" name="= rdf:type : $" value="$type"/>
    <input class="existing" disabled="disabled" type="hidden" name="{$p-curie} :"/>
    <!-- fucking safari and its tabindex -->
    <input tabindex="{count(x:range)}" type="text" name="$ label" list="big-friggin-list" autocomplete="off"/>
    <!-- this is down here now because the javascript i wrote is goofed -->
    <input class="existing" disabled="disabled" type="hidden" name="! skos:inScheme {$focus} : $" value="$SUBJECT"/>
  </form>
</xsl:template>

<x:doc>
  <h3>ibis:add-hidden-inscheme</h3>
  <p>This just iterates over a set of schemes and creates potentially multiple hidden fields with skos:inScheme.</p>
</x:doc>

<xsl:template match="html:*" mode="ibis:add-hidden-inscheme">
  <xsl:param name="schemes">
    <xsl:message terminate="yes">`schemes` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="snorm" select="normalize-space($schemes)"/>

  <xsl:if test="string-length($snorm)">
    <xsl:variable name="first">
      <xsl:call-template name="str:safe-first-token">
        <xsl:with-param name="tokens" select="$schemes"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:comment>wat</xsl:comment>
    <input class="new" type="hidden" name="skos:inScheme :" value="{$first}"/>

    <xsl:variable name="rest" select="substring-after($snorm, ' ')"/>
    <xsl:if test="string-length($rest)">
      <xsl:apply-templates select="." mode="ibis:add-hidden-inscheme">
        <xsl:with-param name="schemes" select="$rest"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>ibis:link-stack</h3>
</x:doc>

<xsl:template match="html:*" mode="ibis:link-stack">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>

  <xsl:param name="predicate" select="''"/>
  <xsl:param name="stack" select="''"/>
  <xsl:param name="can-write" select="false()"/>

  <xsl:variable name="s" select="normalize-space($stack)"/>

  <xsl:if test="string-length($s)">
    <xsl:variable name="first">
      <xsl:call-template name="str:safe-first-token">
        <xsl:with-param name="tokens" select="$s"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="rest" select="substring-after($s, ' ')"/>
    <xsl:variable name="type">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="subject" select="$first"/>
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="type-curie">
      <xsl:call-template name="rdfa:make-curie-list">
        <xsl:with-param name="list" select="$type"/>
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="sequence" select="document('')/xsl:stylesheet/x:sequence[1]"/>
    <xsl:variable name="lprop" select="$sequence/x:class[@uri = $type]/x:lprop/@uri"/>

    <xsl:variable name="label-curie">
      <xsl:call-template name="rdfa:make-curie">
        <xsl:with-param name="uri" select="$lprop"/>
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
        <xsl:with-param name="subject" select="$first"/>
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="predicate" select="$lprop"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="p-curie">
      <xsl:call-template name="rdfa:make-curie">
        <xsl:with-param name="uri" select="$predicate"/>
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="inverse">
      <xsl:variable name="_" select="document('')/xsl:stylesheet/x:inverses"/>
      <xsl:value-of select="($_/x:pair[@a=$predicate]/@b|$_/x:pair[@b=$predicate]/@a)[1]"/>
    </xsl:variable>

    <xsl:variable name="i-curie">
      <xsl:call-template name="rdfa:make-curie">
        <xsl:with-param name="uri" select="$inverse"/>
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <li about="{$first}" typeof="{$type-curie}">
      <form accept-charset="utf-8" action="" method="POST">
        <xsl:if test="$can-write">
          <input name="-! {$i-curie} :" type="hidden" value="{$first}"/>
          <button class="disconnect fa fa-unlink" name="- {$p-curie} :" value="{$first}"></button>
        </xsl:if>
        <a href="{$first}" property="{$label-curie}">
          <xsl:value-of select="substring-before($label, $rdfa:UNIT-SEP)"/>
        </a>
      </form>
    </li>
    <!--<xsl:comment><xsl:value-of select="$rest"/></xsl:comment>-->
    <xsl:if test="normalize-space($rest)">
      <xsl:apply-templates select="." mode="ibis:link-stack">
        <xsl:with-param name="base"          select="$base"/>
        <xsl:with-param name="resource-path" select="$resource-path"/>
        <xsl:with-param name="rewrite"       select="$rewrite"/>
        <xsl:with-param name="main"          select="$main"/>
        <xsl:with-param name="heading"       select="$heading"/>
        <xsl:with-param name="predicate"     select="$predicate"/>
        <xsl:with-param name="stack"         select="$rest"/>
        <xsl:with-param name="can-write"     select="$can-write"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:if>
</xsl:template>

<x:doc>
  <h3>ibis:toggle-list</h3>
</x:doc>

<xsl:template name="ibis:toggle-list">
  <xsl:param name="type" select="'https://vocab.methodandstructure.com/ibis#Issue'"/>

  <xsl:variable name="tpad" select="concat(' ', normalize-space($type), ' ')"/>

  <form accept-charset="utf-8" action="" class="types" method="POST">
    <button class="set-type fa fa-exclamation-triangle" name="= rdf:type :" title="Convert to Issue" value="ibis:Issue">
      <xsl:if test="$type = 'https://vocab.methodandstructure.com/ibis#Issue'">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </button>
    <button class="set-type fa fa-gavel" name="= rdf:type :" title="Convert to Position" value="ibis:Position">
      <xsl:if test="$type = 'https://vocab.methodandstructure.com/ibis#Position'">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </button>
    <button class="set-type fa fa-comments" name="= rdf:type :" title="Convert to Argument" value="ibis:Argument">
      <xsl:if test="$type = 'https://vocab.methodandstructure.com/ibis#Argument'">
        <xsl:attribute name="disabled">disabled</xsl:attribute>
      </xsl:if>
    </button>
  </form>
</xsl:template>

<x:doc>
  <h2>ibis:Network</h2>
</x:doc>

<xsl:template match="html:head" mode="ibis:Network">
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

<xsl:template match="html:body" mode="ibis:Network">
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

  <xsl:variable name="space">
    <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subjects" select="$subject"/>
      <!-- XXX there is a bug in the prefix resolution somewhere -->
      <xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#has_space ^http://rdfs.org/sioc/ns#space_of'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="index">
    <xsl:if test="string-length(normalize-space($space))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$space"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
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

  <xsl:variable name="adjacents">
    <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
      <xsl:with-param name="subjects" select="$subject"/>
      <xsl:with-param name="predicates" select="'^skos:inScheme ^skos:topConceptOf skos:hasTopConcept'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <!--
  <p>subject: <xsl:value-of select="$subject"/></p>
  <p>space: <xsl:value-of select="$space"/></p>
  <p>index: <xsl:value-of select="$index"/></p>
  <p>user: <xsl:value-of select="$user"/></p>
  <p>adjacents: <xsl:value-of select="$adjacents"/></p>
  -->

  <xsl:variable name="issues">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($IBIS, 'Issue')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="positions">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($IBIS, 'Position')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="arguments">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($IBIS, 'Argument')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="goals">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($PM, 'Goal')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="tasks">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($PM, 'Task')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="targets">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($PM, 'Target')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="concepts">
    <xsl:apply-templates select="." mode="rdfa:filter-by-type">
      <xsl:with-param name="subjects" select="$adjacents"/>
      <xsl:with-param name="classes" select="concat($SKOS, 'Concept')"/>
      <xsl:with-param name="traverse" select="false()"/>
    </xsl:apply-templates>
  </xsl:variable>

  <main>
    <article>
      <form method="POST" action="" accept-charset="utf-8">
        <input type="hidden" name="$ SUBJECT $" value="$NEW_UUID_URN"/>
        <input type="hidden" name="skos:inScheme :" value="{$subject}"/>
	<input type="hidden" name="dct:created ^xsd:dateTime $" value="$NEW_TIME_UTC"/>
	<input type="hidden" name="dct:creator :" value="{$user}"/>
        <select name="= rdf:type :">
          <option value="ibis:Issue">Issue</option>
          <option value="ibis:Position">Position</option>
          <option value="ibis:Argument">Argument</option>
          <option value="pm:Goal">Goal</option>
          <option value="pm:Task">Task</option>
          <option value="pm:Target">Target</option>
        </select>
        <input type="text" name="= rdf:value"/>
        <button class="fa fa-plus"/>
      </form>
      <xsl:if test="string-length(normalize-space($issues))">
        <section>
          <h3>Issues</h3>
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$issues"/>
              <xsl:with-param name="lprop" select="concat($rdfa:RDF-NS, 'value')"/>
            </xsl:apply-templates>
          </ul>
        </section>
      </xsl:if>
      <xsl:if test="string-length(normalize-space($positions))">
        <section>
          <h3>Positions</h3>
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$positions"/>
              <xsl:with-param name="lprop" select="concat($rdfa:RDF-NS, 'value')"/>
            </xsl:apply-templates>
          </ul>
        </section>
      </xsl:if>
      <xsl:if test="string-length(normalize-space($arguments))">
        <section>
          <h3>Arguments</h3>
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$arguments"/>
              <xsl:with-param name="lprop" select="concat($rdfa:RDF-NS, 'value')"/>
            </xsl:apply-templates>
          </ul>
        </section>
      </xsl:if>
      <xsl:if test="string-length(normalize-space($goals))">
        <section>
          <h3>Goals</h3>
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$goals"/>
              <xsl:with-param name="lprop" select="concat($rdfa:RDF-NS, 'value')"/>
            </xsl:apply-templates>
          </ul>
        </section>
      </xsl:if>
      <xsl:if test="string-length(normalize-space($tasks))">
        <section>
          <h3>Tasks</h3>
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$tasks"/>
              <xsl:with-param name="lprop" select="concat($rdfa:RDF-NS, 'value')"/>
            </xsl:apply-templates>
          </ul>
        </section>
      </xsl:if>
      <xsl:if test="string-length(normalize-space($targets))">
        <section>
          <h3>Targets</h3>
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$targets"/>
              <xsl:with-param name="lprop" select="concat($rdfa:RDF-NS, 'value')"/>
            </xsl:apply-templates>
          </ul>
        </section>
      </xsl:if>
      <section>
        <h3>Concepts</h3>
        <form method="POST" action="" accept-charset="utf-8">
          <input type="hidden" name="$ SUBJECT $" value="$NEW_UUID_URN"/>
          <input type="hidden" name="skos:inScheme :" value="{$subject}"/>
          <input type="hidden" name="rdf:type :" value="skos:Concept"/>
	  <input type="hidden" name="dct:created ^xsd:dateTime $" value="$NEW_TIME_UTC"/>
	  <input type="hidden" name="dct:creator :" value="{$user}"/>
          <input type="text" name="= skos:prefLabel"/>
          <button class="fa fa-plus"/>
        </form>
        <xsl:if test="string-length(normalize-space($concepts))">
          <ul>
            <xsl:apply-templates select="." mode="skos:scheme-item">
              <xsl:with-param name="resources" select="$concepts"/>
              <xsl:with-param name="lprop" select="concat($SKOS, 'prefLabel')"/>
            </xsl:apply-templates>
          </ul>
        </xsl:if>
      </section>
    </article>
    <figure id="force" class="aside"/>
  </main>

  <!--<h1>wtf <xsl:value-of select="$space"/></h1>-->
  <xsl:apply-templates select="." mode="skos:footer">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
    <xsl:with-param name="space"         select="$space"/>
    <xsl:with-param name="index"         select="$index"/>
    <xsl:with-param name="user"          select="$user"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h2>Process Model Entities</h2>
</x:doc>

<xsl:template match="html:body" mode="pm:body-generic">
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
  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
    </xsl:apply-templates>
  </xsl:param>

  <!--
      this has gotta have all the same stuff as the skos concept
  -->
  <xsl:variable name="schemes">
    <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
      <xsl:with-param name="subjects" select="$subject"/>
      <xsl:with-param name="predicates" select="'skos:inScheme skos:topConceptOf ^skos:hasTopConcept'"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="space">
    <xsl:if test="string-length(normalize-space($schemes))">
      <xsl:apply-templates select="." mode="rdfa:multi-object-resources">
	<xsl:with-param name="subjects" select="$schemes"/>
	<!-- XXX there is a bug in the prefix resolution somewhere -->
	<xsl:with-param name="predicates" select="'http://rdfs.org/sioc/ns#has_space ^http://rdfs.org/sioc/ns#space_of'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="index">
    <xsl:if test="string-length(normalize-space($space))">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
	<xsl:with-param name="subject" select="$space"/>
	<xsl:with-param name="predicate" select="'https://vocab.methodandstructure.com/graph-tool#index'"/>
	<xsl:with-param name="traverse" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
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
	<xsl:with-param name="debug" select="false()"/>
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

  <main>
    <article>
      <hgroup class="self">
        <xsl:apply-templates select="." mode="pm:process-self">
          <xsl:with-param name="base"    select="$base"/>
          <xsl:with-param name="subject" select="$subject"/>
          <xsl:with-param name="type"    select="$type"/>
          <xsl:with-param name="user"    select="$user"/>
        </xsl:apply-templates>
      </hgroup>

      <section class="relations">
        <xsl:apply-templates select="." mode="ibis:process-neighbours">
          <xsl:with-param name="base"          select="$base"/>
          <xsl:with-param name="resource-path" select="$resource-path"/>
          <xsl:with-param name="rewrite"       select="$rewrite"/>
          <xsl:with-param name="main"          select="true()"/>
          <xsl:with-param name="heading"       select="$heading"/>
          <xsl:with-param name="subject"       select="$subject"/>
          <xsl:with-param name="type"          select="$type"/>
	  <xsl:with-param name="schemes"       select="$schemes"/>
	  <xsl:with-param name="user"          select="$user"/>
	  <xsl:with-param name="focus"         select="$focus"/>
        </xsl:apply-templates>
      </section>
    </article>

    <figure id="force" class="aside"/>

    <xsl:apply-templates select="." mode="ibis:make-datalist">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
      <xsl:with-param name="main"          select="true()"/>
      <xsl:with-param name="heading"       select="$heading"/>
      <xsl:with-param name="subject"       select="$subject"/>
      <xsl:with-param name="index"         select="$index"/>
    </xsl:apply-templates>

    <xsl:apply-templates select="." mode="ibis:make-datalist">
      <xsl:with-param name="base"          select="$base"/>
      <xsl:with-param name="resource-path" select="$resource-path"/>
      <xsl:with-param name="rewrite"       select="$rewrite"/>
      <xsl:with-param name="main"          select="true()"/>
      <xsl:with-param name="heading"       select="$heading"/>
      <xsl:with-param name="subject"       select="$subject"/>
      <xsl:with-param name="index"         select="$index"/>
      <xsl:with-param name="search-types"  select="concat($FOAF, 'Person')"/>
      <xsl:with-param name="id"            select="'agents'"/>
    </xsl:apply-templates>

  </main>

  <xsl:apply-templates select="." mode="skos:footer">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="heading"       select="$heading"/>
    <xsl:with-param name="subject"       select="$subject"/>
    <xsl:with-param name="type"          select="$type"/>
    <xsl:with-param name="schemes"       select="$schemes"/>
    <xsl:with-param name="space"         select="$space"/>
    <xsl:with-param name="index"         select="$index"/>
    <xsl:with-param name="user"          select="$user"/>
    <xsl:with-param name="state"         select="$state"/>
    <xsl:with-param name="focus"         select="$focus"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>pm:process-self</h3>
  <p>This is a really crappy dispatcher for the <q>self</q> part of the UI lozenge-y thing.</p>
</x:doc>

<xsl:template match="html:*" mode="pm:process-self">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="type">
    <xsl:apply-templates select="." mode="rdfa:get-type">
      <xsl:with-param name="base"    select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="user">
    <xsl:message terminate="yes">`user` parameter required</xsl:message>
  </xsl:param>

  <xsl:variable name="type-padded" select="concat(' ', normalize-space($type), ' ')"/>

  <xsl:choose>
    <xsl:when test="contains($type-padded, concat(' ', $PM, 'Target '))">
      <xsl:apply-templates select="." mode="pm:process-target">
      </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="contains($type-padded, concat(' ', $PM, 'Task '))">
      <xsl:apply-templates select="." mode="pm:process-task">
      </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="contains($type-padded, concat(' ', $PM, 'Goal '))">
      <xsl:apply-templates select="." mode="pm:process-goal">
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <p>Unknown type (<strong><xsl:value-of select="$type"/></strong>)</p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<x:doc>
  <h3>pm:Goal (head)</h3>
</x:doc>

<xsl:template match="html:head" mode="pm:Goal">
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
    <xsl:with-param name="base"    select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>pm:Goal (body)</h3>
</x:doc>

<xsl:template match="html:body" mode="pm:Goal">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="resource-path" select="$base"/>
  <xsl:param name="rewrite" select="''"/>
  <xsl:param name="main"    select="false()"/>
  <xsl:param name="heading" select="0"/>

  <xsl:apply-templates select="." mode="pm:body-generic">
    <xsl:with-param name="base"          select="$base"/>
    <xsl:with-param name="resource-path" select="$resource-path"/>
    <xsl:with-param name="rewrite"       select="$rewrite"/>
    <xsl:with-param name="main"          select="$main"/>
    <xsl:with-param name="heading"       select="$heading"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>pm:process-goal</h3>
</x:doc>

<xsl:template match="html:*" mode="pm:process-goal">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="value">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="concat($RDF, 'value')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <h1 class="heading">
    <form accept-charset="utf-8" action="" class="description" method="POST">
      <textarea class="heading" name="= rdf:value"><xsl:value-of select="substring-before($value, $rdfa:UNIT-SEP)"/></textarea>
      <button class="fa fa-sync" title="Save Text"></button>
    </form>
  </h1>

  <xsl:apply-templates select="." mode="skos:created-by">
    <xsl:with-param name="base" select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
  </xsl:apply-templates>

  <!-- who wants this goal? -->
  <section>
    <h5>Wanted by:</h5>
    <xsl:call-template name="cgto:editable-resource-list">
      <xsl:with-param name="base"        select="$base"/>
      <xsl:with-param name="subject"     select="$subject"/>
      <xsl:with-param name="predicate"   select="concat($PM, 'performer')"/>
      <xsl:with-param name="resources">
        <xsl:apply-templates select="." mode="rdfa:object-resources">
          <xsl:with-param name="base"      select="$base"/>
          <xsl:with-param name="subject"   select="$subject"/>
          <xsl:with-param name="predicate" select="concat($PM, 'wanted-by')"/>
        </xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="label-prop"  select="concat($FOAF, 'name')"/>
      <xsl:with-param name="new-type"    select="concat($FOAF, 'Person')"/>
      <xsl:with-param name="datalist-id" select="'agents'"/>
    </xsl:call-template>
  </section>

  <!-- who else endorses this goal? -->

</xsl:template>

<x:doc>
  <h3>pm:Task (head)</h3>
</x:doc>

<xsl:template match="html:head" mode="pm:Task">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:apply-templates select="." mode="cgto:head-generic">
    <xsl:with-param name="base"    select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>pm:Task (body)</h3>
</x:doc>

<xsl:template match="html:body" mode="pm:Task">
  <xsl:apply-templates select="." mode="pm:body-generic"/>
</xsl:template>

<x:doc>
  <h3>pm:process-task</h3>
</x:doc>

<xsl:template match="html:*" mode="pm:process-task">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="value">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="concat($RDF, 'value')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <h1 class="heading">
    <form accept-charset="utf-8" action="" class="description" method="POST">
      <textarea class="heading" name="= rdf:value"><xsl:value-of select="substring-before($value, $rdfa:UNIT-SEP)"/></textarea>
      <button class="fa fa-sync" title="Save Text"></button>
    </form>
  </h1>

  <p>
    <!-- when did it start -->
    <xsl:variable name="started">
      <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="subject" select="$subject"/>
        <xsl:with-param name="predicate" select="concat($PROV, 'startedAtTime')"/>
        <xsl:with-param name="datatype" select="concat($XSD, 'dateTime')"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:comment><xsl:value-of select="$started"/></xsl:comment>
    <form accept-charset="utf-8" action="" method="POST">
      <label>Started: <input type="datetime-local" name="= prov:startedAtTime ^xsd:dateTime" value="{$started}"/></label>
    </form>
    <!-- when did it end -->
    <xsl:variable name="ended">
      <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
        <xsl:with-param name="base" select="$base"/>
        <xsl:with-param name="subject" select="$subject"/>
        <xsl:with-param name="predicate" select="concat($PROV, 'endedAtTime')"/>
        <xsl:with-param name="datatype" select="concat($XSD, 'dateTime')"/>
      </xsl:apply-templates>
    </xsl:variable>
    <form accept-charset="utf-8" action="" method="POST">
      <label>Ended: <input type="datetime-local" name="= prov:endedAtTime ^xsd:dateTime" value="{$ended}"/></label>
    </form>
    <!-- (other PROV stuff??) -->
  </p>

  <!-- who endorses this task? -->

  <section>
    <xsl:variable name="performers">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="base"      select="$base"/>
        <xsl:with-param name="subject"   select="$subject"/>
        <xsl:with-param name="predicate" select="concat($PM, 'performer')"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="responsible">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="base"      select="$base"/>
        <xsl:with-param name="subject"   select="$subject"/>
        <xsl:with-param name="predicate" select="concat($PM, 'responsible')"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="recipients">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="base"      select="$base"/>
        <xsl:with-param name="subject"   select="$subject"/>
        <xsl:with-param name="predicate" select="concat($PM, 'recipient')"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="involved">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="base"      select="$base"/>
        <xsl:with-param name="subject"   select="$subject"/>
        <xsl:with-param name="predicate" select="concat($PM, 'involved')"/>
      </xsl:apply-templates>
    </xsl:variable>

    <!-- who is performing this task -->
    <div>
      <h5>Performed By:</h5>
      <xsl:call-template name="cgto:editable-resource-list">
        <xsl:with-param name="base"        select="$base"/>
        <xsl:with-param name="subject"     select="$subject"/>
        <xsl:with-param name="predicate"   select="concat($PM, 'performer')"/>
        <xsl:with-param name="resources"   select="$performers"/>
        <xsl:with-param name="new-type"    select="concat($FOAF, 'Person')"/>
        <xsl:with-param name="label-prop"  select="concat($FOAF, 'name')"/>
        <xsl:with-param name="datalist-id" select="'agents'"/>
      </xsl:call-template>
    </div>
    <!-- who is responsible -->
    <div>
      <h5>Responsible Parties:</h5>
      <xsl:call-template name="cgto:editable-resource-list">
        <xsl:with-param name="base"        select="$base"/>
        <xsl:with-param name="subject"     select="$subject"/>
        <xsl:with-param name="predicate"   select="concat($PM, 'responsible')"/>
        <xsl:with-param name="resources"   select="$performers"/>
        <xsl:with-param name="new-type"    select="concat($FOAF, 'Person')"/>
        <xsl:with-param name="label-prop"  select="concat($FOAF, 'name')"/>
        <xsl:with-param name="datalist-id" select="'agents'"/>
      </xsl:call-template>
    </div>
    <!-- who is the recipient of the result -->
    <div>
      <h5>Recipient of Result:</h5>
      <xsl:call-template name="cgto:editable-resource-list">
        <xsl:with-param name="base"        select="$base"/>
        <xsl:with-param name="subject"     select="$subject"/>
        <xsl:with-param name="predicate"   select="concat($PM, 'recipient')"/>
        <xsl:with-param name="resources"   select="$performers"/>
        <xsl:with-param name="new-type"    select="concat($FOAF, 'Person')"/>
        <xsl:with-param name="label-prop"  select="concat($FOAF, 'name')"/>
        <xsl:with-param name="datalist-id" select="'agents'"/>
      </xsl:call-template>
    </div>
    <!-- who else is involved -->
    <div>
      <h5>Otherwise Involved:</h5>
      <xsl:call-template name="cgto:editable-resource-list">
        <xsl:with-param name="base"        select="$base"/>
        <xsl:with-param name="subject"     select="$subject"/>
        <xsl:with-param name="predicate"   select="concat($PM, 'involved')"/>
        <xsl:with-param name="resources"   select="$performers"/>
        <xsl:with-param name="new-type"    select="concat($FOAF, 'Person')"/>
        <xsl:with-param name="label-prop"  select="concat($FOAF, 'name')"/>
        <xsl:with-param name="datalist-id" select="'agents'"/>
      </xsl:call-template>
    </div>
  </section>

  <section>
    <!-- what was the actual outcome after the fact (this can be multiple things) -->
  </section>

  <!-- other stuff like see also and notes -->

  <!-- (these are probably going to be neighbours) -->
  <!-- what is the expected outcome (this is the target) -->
  <!-- what goal is achieved -->
</xsl:template>

<x:doc>
  <h3>pm:Target (head)</h3>
</x:doc>

<xsl:template match="html:head" mode="pm:Target">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:apply-templates select="." mode="cgto:head-generic">
    <xsl:with-param name="base"    select="$base"/>
    <xsl:with-param name="subject" select="$subject"/>
  </xsl:apply-templates>
</xsl:template>

<x:doc>
  <h3>pm:Target (body)</h3>
</x:doc>

<xsl:template match="html:body" mode="pm:Target">
  <xsl:apply-templates select="." mode="pm:body-generic"/>
</xsl:template>

<x:doc>
  <h3>pm:process-target</h3>
</x:doc>

<xsl:template match="html:*" mode="pm:process-target">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="debug" select="false()"/>
    </xsl:apply-templates>
  </xsl:param>

  <xsl:variable name="value">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="concat($RDF, 'value')"/>
    </xsl:apply-templates>
  </xsl:variable>

  <h1 class="heading">
    <form accept-charset="utf-8" action="" class="description" method="POST">
      <textarea class="heading" name="= rdf:value"><xsl:value-of select="substring-before($value, $rdfa:UNIT-SEP)"/></textarea>
      <button class="fa fa-sync" title="Save Text"></button>
    </form>
  </h1>
  <!-- who wants this target? -->

  <!-- who endorses this target? -->
</xsl:template>

<x:doc>
  <h2>cgto:editable-resource-list</h2>
  <p>This is tentatively going to be moved to the CGTO template. The goal is to create a <code>&lt;ul&gt;</code> of resources connected by a given predicate, and such that the last entry in the list is a form to add a new entry.</p>
</x:doc>

<!-- XXX make these part of CGTO -->

<xsl:template name="cgto:editable-resource-list">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="predicate">
    <xsl:message terminate="yes">`predicate` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="resources">
    <xsl:apply-templates select="." mode="rdfa:object-resources">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="$predicate"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="new-type">
    <xsl:message terminate="yes">`new-type` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="label-prop" select="concat($RDF, 'value')"/>
  <xsl:param name="datalist-id"/>
  <xsl:param name="prefixes"/>

  <xsl:variable name="actual-prefixes">
    <xsl:variable name="_">
      <xsl:apply-templates select="." mode="rdfa:prefix-stack"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="string-length(normalize-space($prefixes))">
        <xsl:apply-templates select="." mode="rdfa:merge-prefixes">
          <xsl:with-param name="prefixes" select="$_"/>
          <xsl:with-param name="with" select="$prefixes"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$_"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="p-curie">
    <xsl:call-template name="rdfa:make-curie">
      <xsl:with-param name="uri" select="$predicate"/>
      <xsl:with-param name="prefixes" select="$actual-prefixes"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="c-curie">
    <xsl:call-template name="rdfa:make-curie">
      <xsl:with-param name="uri" select="$new-type"/>
      <xsl:with-param name="prefixes" select="$actual-prefixes"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="lprop-curie">1
    <xsl:call-template name="rdfa:make-curie">
      <xsl:with-param name="uri" select="$label-prop"/>
      <xsl:with-param name="prefixes" select="$actual-prefixes"/>
    </xsl:call-template>
  </xsl:variable>

  <ul>
    <!-- already added -->
    <xsl:call-template name="cgto:editable-resource-list-items">
      <xsl:with-param name="resources" select="$resources"/>
      <xsl:with-param name="predicate" select="$predicate"/>
    </xsl:call-template>

    <!-- add new / link existing -->
    <li>
      <form method="POST" action="" accept-charset="utf-8">
        <input class="new" type="hidden" name="$ SUBJECT $" value="$NEW_UUID_URN"/>
        <input class="new" type="hidden" name="= rdf:type : $" value="{$new-type}"/>
        <input class="new label" type="hidden" about="{$c-curie}" disabled="disabled" name="= {$lprop-curie} $" value="$label"/>
        <input class="existing" type="hidden" disabled="disabled" name="{$p-curie} :"/>
        <input tabindex="0" type="text" name="$ label">
          <xsl:if test="$datalist-id">
            <xsl:attribute name="list"><xsl:value-of select="$datalist-id"/></xsl:attribute>
            <xsl:attribute name="autocomplete">off</xsl:attribute>
          </xsl:if>
        </input>
      </form>
    </li>
  </ul>
</xsl:template>

<x:doc>
  <h3>cgto:editable-resource-list-items</h3>
  <p>what's this doing here?</p>
</x:doc>

<xsl:template name="cgto:editable-resource-list-items">
  <xsl:param name="resources"/>
  <xsl:param name="predicate"/>
  <xsl:param name="label-p"/>
  <xsl:param name="prefixes"/>

  <xsl:variable name="rs" select="normalize-space($resources)"/>

  <xsl:if test="string-length($rs)">

    <xsl:variable name="first">
      <xsl:call-template name="str:safe-first-token">
        <xsl:with-param name="tokens" select="$rs"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="type">
      <xsl:apply-templates select="." mode="rdfa:object-resources">
        <xsl:with-param name="subject" select="$first"/>
        <xsl:with-param name="predicate" select="$rdfa:RDF-TYPE"/>
      </xsl:apply-templates>
    </xsl:variable>

    <li>
      <a rel="{$predicate}" href="{$first}" typeof="{$type}">
        <span>
          <xsl:apply-templates select="." mode="cgto:literal-content">
            <xsl:with-param name="prefixes"  select="$prefixes"/>
            <xsl:with-param name="subject"   select="$first"/>
            <xsl:with-param name="predicate" select="$label-p"/>
            <xsl:with-param name="prefixes"  select="$prefixes"/>
          </xsl:apply-templates>
        </span>
      </a>
      <form method="POST" action="" accept-charset="utf-8">
        <button name="- {$predicate} :" value="{$first}"/>
      </form>
    </li>

    <xsl:variable name="rest" select="substring-after($rs, ' ')"/>
    <xsl:if test="string-length($rest)">
      <xsl:call-template name="cgto:editable-resource-list-items">
        <xsl:with-param name="resources" select="$rest"/>
        <xsl:with-param name="predicate" select="$predicate"/>
        <xsl:with-param name="label-p"   select="$label-p"/>
        <xsl:with-param name="prefixes"  select="$prefixes"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>

</xsl:template>

<x:doc>
  <h3><code>cgto:literal-content</code></h3>
  <p>This template spits out some attributes and a text node. You supply the enclosing element and other attributes (but don't put a <code>property</code>, <code>datatype</code>, or <code>xml:lang</code> in it, or the template will blow up).</p>
  <dl>
    <dt><code>base</code></dt>
    <dd>You can pass in the <code>base href</code> to save it the effort of re-fetching it.</dd>
    <dt><code>prefixes</code></dt>
    <dd>Any additional prefixes that may not already be in the document, in the form of an RDFa <code>prefix</code> attribute, for CURIEs.</dd>
    <dt><code>subject</code></dt>
    <dd>Likewise the subject, or otherwise override if it's not the same as the base.</dd>
    <dt><code>predicate</code></dt>
    <dd>This is the only mandatory parameter, the predicate associated with the label.</dd>
    <dt><code>object</code></dt>
    <dd>This is the actual label, and will be derived from the subject and the predicate, but if overridden, the value passed in must be a raw literal with <code>$rdfa:UNIT-SEP</code> delimiting the language/datatype (whether it has one or not).</dd>
    <dt><code>content</code></dt>
    <dd>If non-empty, this will place the label content (if present) in the <code>content</code> attribute and create a text node with this content instead.</dd>
    <dt><code>noop</code></dt>
    <dd>This will place the URL of the subject if no label is found (unless the <code>content</code> parameter is set, then it's that).</dd>
  </dl>
</x:doc>

<xsl:template match="html:*" mode="cgto:literal-content">
  <xsl:param name="base" select="normalize-space((ancestor-or-self::html:html[html:head/html:base[@href]][1]/html:head/html:base[@href])[1]/@href)"/>
  <xsl:param name="prefixes"/>
  <xsl:param name="subject">
    <xsl:apply-templates select="." mode="rdfa:get-subject">
      <xsl:with-param name="base" select="$base"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="predicate">
    <xsl:message terminate="yes">`predicate` parameter required</xsl:message>
  </xsl:param>
  <xsl:param name="object">
    <xsl:apply-templates select="." mode="rdfa:object-literal-quick">
      <xsl:with-param name="base" select="$base"/>
      <xsl:with-param name="subject" select="$subject"/>
      <xsl:with-param name="predicate" select="$predicate"/>
    </xsl:apply-templates>
  </xsl:param>
  <xsl:param name="content"/>
  <xsl:param name="noop" select="false()"/>

  <xsl:choose>
    <xsl:when test="string-length($object)">
      <xsl:variable name="pfx">
        <xsl:apply-templates select="." mode="rdfa:merge-prefixes">
          <xsl:with-param name="with" select="prefixes"/>
        </xsl:apply-templates>
      </xsl:variable>

      <xsl:variable name="p-curie">
        <xsl:call-template name="rdfa:make-curie">
          <xsl:with-param name="uri" select="$predicate"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="label" select="substring-before($object, $rdfa:UNIT-SEP)"/>
      <xsl:variable name="label-type">
        <xsl:if test="not(starts-with(substring-after($object, $rdfa:UNIT-SEP), '@'))">
          <xsl:value-of select="substring-after($object, $rdfa:UNIT-SEP)"/>
        </xsl:if>
      </xsl:variable>
      <xsl:variable name="label-lang">
        <xsl:if test="starts-with(substring-after($object, $rdfa:UNIT-SEP), '@')">
          <xsl:value-of select="substring-after($object, concat($rdfa:UNIT-SEP, '@'))"/>
        </xsl:if>
      </xsl:variable>

      <xsl:attribute name="property"><xsl:value-of select="$p-curie"/></xsl:attribute>

      <xsl:if test="$label-type">
        <xsl:variable name="d-curie">
          <xsl:call-template name="rdfa:make-curie">
            <xsl:with-param name="uri" select="$label-type"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:attribute name="datatype"><xsl:value-of select="$label-type"/></xsl:attribute>
      </xsl:if>

      <xsl:if test="$label-lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="$label-lang"/></xsl:attribute>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="string-length($content)">
          <xsl:attribute name="content"><xsl:value-of select="$label"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$label"/></xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="string-length($content)">
      <xsl:value-of select="$content"/>
    </xsl:when>
    <xsl:when test="$noop"><xsl:value-of select="$subject"/></xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
