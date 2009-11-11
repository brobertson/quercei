<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
    xmlns:tbank="http://nlp.perseus.tufts.edu/syntax/treebank/1.5"
    xmlns:tbankRDF="http://nlp.perseus.tufts.edu/syntax/treebank/1.5/RDF"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
<xsl:output	method="text" indent="no"/>
<xsl:template match="sentence">
<xsl:if test="(@subdoc != preceding-sibling::sentence[1]/@subdoc) or not(preceding-sibling::sentence)">subdoc__<xsl:value-of select="@document_id"/>_<xsl:value-of select="@subdoc"/>:
  label: "<xsl:value-of select="@subdoc"/>"
  document_urn: "<xsl:value-of select="@document_id"/>"
  field1: <xsl:value-of select="substring-before(@subdoc,'=')"/>
  value1: <xsl:value-of select="substring-after(@subdoc, '=')"/>
  <xsl:text>
</xsl:text>
<xsl:apply-templates/></xsl:if></xsl:template>
<xsl:template match="text()"></xsl:template>
</xsl:stylesheet>
