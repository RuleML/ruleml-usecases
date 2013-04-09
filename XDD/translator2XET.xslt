<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- ..................Assert....................  -->
	<xsl:template match="/Assert">
		<XET xmlns:xet="XET" xmlns:mm="text" xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance">
			<Fact>
				<xsl:for-each select="Atom">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</Fact>
			<xet:RuleClassOrder>1 2 3 4</xet:RuleClassOrder>
			<xsl:for-each select="Implies">
				<Rule name="RuleName" priority="1">
					<xsl:apply-templates select="."/>
				</Rule>	
			</xsl:for-each>	
		</XET>
	</xsl:template>
<!-- ..................Implies.....................  -->
	<xsl:template match="Implies">
			<Head>
				<xsl:choose>
					<xsl:when test="count(child::Atom)=1">	
			   			<xsl:apply-templates select="(Atom)[position()=1]"/>   	
	   				</xsl:when>
	   				<xsl:otherwise>
	   					<xsl:apply-templates select="(Atom)[position()=2]"/>   	
	   				</xsl:otherwise>
				</xsl:choose> 			
			</Head>	
			<Body>
				<xsl:apply-templates select="(Atom|And)[position()=1]"/>
			</Body>	
	</xsl:template> 
	
<!-- ..................And.....................  -->
	<xsl:template match="And">
				<xsl:for-each select="Atom">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
	
	</xsl:template>
		
<!-- ..................Atom.....................  -->
	<xsl:template match="Atom">
		<xsl:choose>
			<xsl:when test="count(child::*)=2">
				<xsl:element name="{Rel}">
					<xsl:apply-templates select="Ind|Var"/>
				</xsl:element>
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:element name="{Rel}">
					<xsl:for-each select="Ind|Var">
						<Ind>
							<xsl:apply-templates select="."/>
						</Ind>
					</xsl:for-each>
				</xsl:element>
			</xsl:otherwise>
			
		</xsl:choose>
	</xsl:template>

<!-- ..................Ind and Var.....................  -->
<xsl:template match="Ind"><xsl:value-of select="."/></xsl:template>

<xsl:template match="Var">Svar_<xsl:value-of select="."/></xsl:template> 

</xsl:stylesheet>
