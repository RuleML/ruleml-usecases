<?xml version="1.0"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:r="http://ruleml.org/spec">

<xsl:output method="xml" indent="yes" version="1.0"/>

<xsl:template match="node()">
  <xsl:copy>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="r:*[@closure = 'universal']">
  <xsl:choose>
    <xsl:when test="descendant::r:Var">
      <xsl:element name="Forall" namespace="http://ruleml.org/spec">
        <xsl:for-each-group select="descendant::r:Var" group-by="text()">
          <xsl:copy-of select="."/>
        </xsl:for-each-group>
        <xsl:copy>
          <xsl:apply-templates/>
        </xsl:copy>
      </xsl:element>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy>
        <xsl:apply-templates/>
      </xsl:copy>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="@closure[. = 'universal']"/>

</xsl:stylesheet> 
