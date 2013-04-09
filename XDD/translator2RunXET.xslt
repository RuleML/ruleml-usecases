<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- ..................XET....................  -->
	<xsl:template match="/XET">
		<xet:XET xmlns:mm="text" xmlns:xet="XET" xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance">
				<xsl:apply-templates select="Fact"/>
				<xet:RuleClassOrder>1 2 3 4</xet:RuleClassOrder>
				<xsl:for-each select="Rule">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
		</xet:XET>
	</xsl:template>

	<!-- ..................Rule.....................  -->
	<xsl:template match="Rule">
		<xet:Rule  name="RuleName" priority="1">
			<xsl:apply-templates select="Head|Body"/> 
		</xet:Rule>	
	</xsl:template> 
	<!-- ..................Body.....................  -->
	<xsl:template match="Body">
		<xet:Body>
				<xsl:copy-of select="*"/>
		</xet:Body>
	</xsl:template>
	<!-- ..................Head.....................  -->
	<xsl:template match="Head">
		<xet:Head>
				<xsl:copy-of select="*"/>
		</xet:Head>		
	</xsl:template> 
	<!-- ..................Fact.....................  --> 
	<xsl:template match="Fact">
			<xet:Fact>
					<xsl:copy-of select="*"/>
			</xet:Fact>
	</xsl:template>
</xsl:stylesheet>
