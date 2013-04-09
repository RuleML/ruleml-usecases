<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- ..................XET....................  -->
	<xsl:template match="/XET">
		<Assert>
			<And mapClosure="universal">
				<xsl:for-each select="Rule">
					<xsl:apply-templates select="."/>
				</xsl:for-each>
				<xsl:apply-templates select="Fact"/>
			</And>
		</Assert>
	</xsl:template>
	<!-- ..................Rule.....................  -->
	<xsl:template match="Rule">
		<Implies>
			<xsl:apply-templates select="Body"/>
			<xsl:apply-templates select="Head"/>
		</Implies>
	</xsl:template>
	<!-- ..................Body.....................  -->
	<xsl:template match="Body">
		<xsl:choose>
			<xsl:when test="count(child::*)&lt;2">
				<!--when body has one child-->
				<xsl:for-each select="./*">
					<!-- choose the child element of Head-->
					<xsl:choose>
						<xsl:when test="count(child::*)&lt;2">
							<Atom>
								<Rel>
									<xsl:value-of select="name(.)"/>
								</Rel>
								<xsl:choose>
									<xsl:when test="starts-with((.),'Svar_')">
										<Var>
											<xsl:value-of select="substring((.),6)"/>
										</Var>
									</xsl:when>
									<xsl:otherwise>
										<Ind>
											<xsl:value-of select="."/>
										</Ind>
									</xsl:otherwise>
								</xsl:choose>
							</Atom>
						</xsl:when>
						<xsl:otherwise>
							<Atom>
								<Rel>
									<xsl:value-of select="name(.)"/>
								</Rel>
								<xsl:for-each select="Ind">
									<xsl:choose>
										<xsl:when test="starts-with((.),'Svar_')">
											<Var>
												<xsl:value-of select="substring((.),6)"/>
											</Var>
										</xsl:when>
										<xsl:otherwise>
											<Ind>
												<xsl:value-of select="."/>
											</Ind>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</Atom>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<!--when body has 2 or more children-->
				<And>
					<xsl:for-each select="./*">
						<!-- choose the child element of Head-->
						<xsl:choose>
							<xsl:when test="count(child::*)&lt;2">
								<Atom>
									<Rel>
										<xsl:value-of select="name(.)"/>
									</Rel>
									<xsl:choose>
										<xsl:when test="starts-with((.),'Svar_')">
											<Var>
												<xsl:value-of select="substring((.),6)"/>
											</Var>
										</xsl:when>
										<xsl:otherwise>
											<Ind>
												<xsl:value-of select="."/>
											</Ind>
										</xsl:otherwise>
									</xsl:choose>
								</Atom>
							</xsl:when>
							<xsl:otherwise>
								<Atom>
									<Rel>
										<xsl:value-of select="name(.)"/>
									</Rel>
									<xsl:for-each select="Ind">
										<xsl:choose>
											<xsl:when test="starts-with((.),'Svar_')">
												<Var>
													<xsl:value-of select="substring((.),6)"/>
												</Var>
											</xsl:when>
											<xsl:otherwise>
												<Ind>
													<xsl:value-of select="."/>
												</Ind>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</Atom>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</And>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ..................Head.....................  -->
	<xsl:template match="Head">
		<xsl:for-each select="./*">
			<!-- choose the child element of Head-->
			<xsl:choose>
				<xsl:when test="count(child::*)&lt;2">
					<Atom>
						<Rel>
							<xsl:value-of select="name(.)"/>
						</Rel>
						<xsl:choose>
							<xsl:when test="starts-with((.),'Svar_')">
								<Var>
									<xsl:value-of select="substring((.),6)"/>
								</Var>
							</xsl:when>
							<xsl:otherwise>
								<Ind>
									<xsl:value-of select="."/>
								</Ind>
							</xsl:otherwise>
						</xsl:choose>
					</Atom>
				</xsl:when>
				<xsl:otherwise>
					<Atom>
						<Rel>
							<xsl:value-of select="name(.)"/>
						</Rel>
						<xsl:for-each select="Ind">
							<xsl:choose>
								<xsl:when test="starts-with((.),'Svar_')">
									<Var>
										<xsl:value-of select="substring((.),6)"/>
									</Var>
								</xsl:when>
								<xsl:otherwise>
									<Ind>
										<xsl:value-of select="."/>
									</Ind>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</Atom>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- ..................Fact.....................  -->
	<xsl:template match="Fact">
		<xsl:for-each select="./*">
			<xsl:choose>
				<xsl:when test="count(child::*)&lt;2">
					<Atom>
						<Rel>
							<xsl:value-of select="name(.)"/>
						</Rel>
						<Ind>
							<xsl:value-of select="."/>
						</Ind>
					</Atom>
				</xsl:when>
				<xsl:otherwise>
					<Atom>
						<Rel>
							<xsl:value-of select="name(.)"/>
						</Rel>
						<xsl:for-each select="Ind">
							<Ind>
								<xsl:value-of select="."/>
							</Ind>
						</xsl:for-each>
					</Atom>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Ind">
		<Ind>
			<xsl:value-of select="."/>
		</Ind>
	</xsl:template>
</xsl:stylesheet>
