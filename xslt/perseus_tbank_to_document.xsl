<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
    xmlns:tbank="http://nlp.perseus.tufts.edu/syntax/treebank/1.5"
    xmlns:tbankRDF="http://nlp.perseus.tufts.edu/syntax/treebank/1.5/RDF"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
<xsl:output	method="text" indent="no"/>
<xsl:template match="/">
	<xsl:apply-templates select="/treebank/sentence[1]"/>
</xsl:template>
<xsl:template match="sentence[1]">document__<xsl:value-of select="@document_id"/>:
  title: "[unknown]"
  author: "[unknown]"
  urn: "<xsl:value-of select="@document_id"/>"
</xsl:template>
</xsl:stylesheet>
