<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
    xmlns:tbank="http://nlp.perseus.tufts.edu/syntax/treebank/1.5"
    xmlns:tbankRDF="http://nlp.perseus.tufts.edu/syntax/treebank/1.5/RDF"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
<xsl:output	method="text" indent="no"/>
<!--
<xsl:template match="/treebank">-
<xsl:apply-templates/></xsl:template>
-->
<xsl:template match="sentence">head__<xsl:value-of select="@document_id"/>_<xsl:value-of select="@id"/>:
  form: "HEAD"
  number: 0
  sentence: <xsl:value-of select="@id"/>
  document_urn: "<xsl:value-of select="@document_id"/>"
  subdoc: <xsl:value-of select="@subdoc"/><xsl:text>
</xsl:text>
<xsl:apply-templates/></xsl:template>

<xsl:template match="treebank/sentence/word"><xsl:text>word__</xsl:text><xsl:value-of select="../@document_id"/><xsl:value-of select="count(preceding-sibling::*) + count(../preceding-sibling::*/*)"/><xsl:text>:
  </xsl:text>form: "<xsl:value-of select="@form"/><xsl:text>"
  </xsl:text>number: "<xsl:value-of select="@id"/><xsl:text>"
  </xsl:text>sentence: "<xsl:value-of select="../@id"/><xsl:text>"
  </xsl:text>document_urn: "<xsl:value-of select="../@document_id"/><xsl:text>"
  </xsl:text>subdoc: "<xsl:value-of select="../@subdoc"/><xsl:text>"
  </xsl:text>span: "<!--xsl:value-of select="../@span"/-->BOGUS<xsl:text>"
</xsl:text></xsl:template>
<xsl:template match="text()"></xsl:template>
</xsl:stylesheet>
