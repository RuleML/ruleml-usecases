<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<?cocoon-process type="xslt"?>

<!-- Transforming Hornlog RFML to Hornlog RuleML 0.89              2005-08-18  -->
<!-- Harold Boley  -->
<!-- Updated for RuleML 0.89 and OO jDREW by Jie Li (JL).-->
<!-- Preliminary template:If greater than negative "infinity", then regard as type Real (Integer united Real). -->
<!--Examples of the file before and after transformation
    RFML                                                                        RuleML                
    <tup>                                                                       <Plex>
    	<var>y</var>                                                       	<Var>y</Var>
    	<con>b</con>                     XSLT                           <Ind type="String">b</Ind>
    	<rest></rest>                __________                      <repo>
    	<var>x</var>                                                           <Var>x</Var>
    </tup>                                                                        </repo>
                                                                                   </Plex>
  -->
  
 <!-- process rfml knowledge base and position hn transformer -->
  <xsl:template match="/rfml">
    <Assert>
		<!-- <And mapClosure="universal">-->
		<And mapClosure="universal">
		  <xsl:apply-templates/>
		</And>
    </Assert>
  </xsl:template>

  <!-- process hn clause, that is a fact,
       a single-premise, or a multi-premise implication -->
  <!-- <xsl:template match="hn">
    <xsl:choose>
      <xsl:when test="count(child::*)=1">
            <xsl:apply-templates select="pattop"/>
      </xsl:when>
      <xsl:when test="count(child::*)=2">
        <Implies>
          <body>
            <xsl:apply-templates select="con|var|anon|struc|callop|is|tup"/>
          </body>
          <head>
            <xsl:apply-templates select="pattop"/>
          </head>
        </Implies>
      </xsl:when>
      <xsl:otherwise>
        <Implies>
          <body>
            <And>
              <xsl:for-each select="con|var|anon|struc|callop|is|tup">
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </And>
          </body>
          <head>
            <xsl:apply-templates select="pattop"/>
          </head>
        </Implies>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->


  <xsl:template match="hn">
    <xsl:choose>
      <xsl:when test="count(child::*)=1">
            <xsl:apply-templates select="pattop"/>
      </xsl:when>
      <xsl:when test="count(child::*)=2">
        <Implies>
            <xsl:apply-templates select="con|var|anon|struc|callop|is|tup|dom"/>
            <xsl:apply-templates select="pattop"/>
        </Implies>
      </xsl:when>
      <xsl:otherwise>
        <Implies>
            <And>
              <xsl:for-each select="con|var|anon|struc|callop|is|tup|dom">
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </And>
            <xsl:apply-templates select="pattop"/>
        </Implies>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="callop">
    <Atom>
        <Rel>
          <xsl:value-of select="(con|struc|dom)[position()=1]"/>
        </Rel>
       <!-- 
        <xsl:for-each select="con[position()=1"/>
        <xsl:if test="string-greaterthan">
         </xsl:if>
        -->            
     	<xsl:for-each select="(con|var|anon|struc|callop|is|tup|dom)[position()>1]">
             <xsl:apply-templates select="."/>
             </xsl:for-each>
    </Atom>
  </xsl:template>

  <xsl:template match="pattop">
    <Atom>
        <Rel>
          <xsl:value-of select="(con|struc|dom)[position()=1]"/>
        </Rel>
      <xsl:for-each select="(con|var|anon|struc|tup|dom)[position()>1]">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </Atom>
  </xsl:template>

  <xsl:template match="struc">
    <Cterm>       
		 <Ctor>
          <xsl:value-of select="con[position()=1]"/>
     </Ctor>
      <xsl:for-each select="(con|var|anon|struc|is|tup)[position()>1]">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </Cterm>
  </xsl:template>
  
  <xsl:template match="is">
	  <Equal>
		  <xsl:for-each select="con|var|anon|struc|callop|tup">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
	  </Equal>
  </xsl:template>
  
    <xsl:template match="dom">
	  <Set>
		  <xsl:for-each select="con">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
	  </Set>
  </xsl:template>
  
  <xsl:template match="tup">
	  <Plex>
	  <xsl:choose>
      <xsl:when test="rest">
		 <xsl:for-each select="(con|var|anon|struc|pattop|callop|tup)[not(position()=last())]">
			<xsl:apply-templates select="."/>
        </xsl:for-each>
         <xsl:choose>
			 <xsl:when test="rest">
				<repo>
					<xsl:apply-templates select="(var|anon|tup)[position()=last()]"/>
				</repo>
			</xsl:when>
		</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="con|var|anon|struc|pattop|callop">
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</xsl:otherwise>
	  </xsl:choose>
	  </Plex>
  </xsl:template>
  


  <xsl:template match="var">
    <Var><xsl:value-of select="."/></Var>
  </xsl:template>
   
  

  <xsl:template match="con">
   <xsl:choose>
        <xsl:when test=" . &gt; -2147483648">
		<Ind type="Real"><xsl:value-of select="."/></Ind>
	</xsl:when>
	<xsl:otherwise>
		<Ind type="String"><xsl:value-of select="."/></Ind>
	</xsl:otherwise>
</xsl:choose>
  </xsl:template>


<xsl:template match="anon">
    <Var><xsl:value-of select="."/></Var>
  </xsl:template>
  
<!--
 <xsl:template match="con">
     <xsl:choose>
        <xsl:when test="string-greaterthan">
           <Ind type="String">
              <xsl:value-of select="."/>
      	    </Ind>
      </xsl:when>
      <xsl:when test="greaterthan">
           <Ind type="Real">
              <xsl:value-of select="."/>
      	    </Ind>
      </xsl:when>
      <xsl:otherwise>
  		<Ind><xsl:value-of select="."/></Ind>
     </xsl:otherwise>
   </xsl:choose>
</xsl:template>

 <xsl:template match="var">
     <xsl:choose>
        <xsl:when test="string-greaterthan">
           <Ind type="String">
              <xsl:value-of select="."/>
      	    </Ind>
      </xsl:when>
      <xsl:when test="greaterthan">
           <Ind type="Real">
              <xsl:value-of select="."/>
      	    </Ind>
      </xsl:when>
      <xsl:otherwise>
  		<Ind><xsl:value-of select="."/></Ind>
     </xsl:otherwise>
   </xsl:choose>
</xsl:template>
  -->
  
</xsl:stylesheet>
