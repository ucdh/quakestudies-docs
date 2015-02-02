<?xml version="1.0" encoding="UTF-8"?>
<!-- owl_to_vocabularies.xslt: reveal quakestudies vocabularies -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:protege="http://protege.stanford.edu/plugins/owl/protege#"
    xmlns:xsp="http://www.owl-ontologies.com/2005/08/07/xsp.owl#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:swrl="http://www.w3.org/2003/11/swrl#"
    xmlns:swrlb="http://www.w3.org/2003/11/swrlb#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    exclude-result-prefixes="xsl rdf protege xsp owl xsd swrl swrlb rdfs"
    >
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:include href="css.xslt"/>
    
    <xsl:variable name="lcletters">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    <xsl:variable name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
    <xsl:variable name="base" select="/rdf:RDF/@xml:base"></xsl:variable>

    <!-- main template-->
    <xsl:template match="/">
			<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
			<html lang="en">
				<head>
					<xsl:call-template name="css" />
				</head>
        <body>
				<!-- <div class="navbar navbar-fixed-top"> -->
					<div class="navbar navbar-fixed-top">
						<div class="navbar-inner">
							<div class="container">
								<a class="brand" href="#">Quakestudies Repository: ontology description</a>
									<ul class="nav">
										<li class="active dropdown"><a href="index.html" class="dropdown-toggle" data-toggle="dropdown">Ontology <b class="caret"></b></a>
											<ul class="dropdown-menu">
												<li><a href="index.html">Ontology documentation</a></li>
												<li class="divider"></li>
												<li><a href="../owl/ceismic.owl">OWL-RDF ontology</a></li>
												<li><a href="ontology.html">Ontology description</a></li>
												<li><a href="vocabularies.html">Vocabularies</a></li>
												<li><a href="../owl/ceismic.gif">Ontology diagram</a></li>
												<li><a href="mappings.html">Mappings</a></li>
											</ul>
										</li>
										<li class="dropdown"><a href="system.html" class="dropdown-toggle" data-toggle="dropdown">System <b class="caret"></b></a>
											<ul class="dropdown-menu">
												<li><a href="system.html">System documentation</a></li>
												<li class="divider"></li>
												<li><a href="system.html#architecture">Architecture</a></li>
												<li><a href="system.html#administration_interfaces">Administration interfaces</a></li>
												<li><a href="system.html#authentication">Authentication</a></li>
												<li><a href="system.html#authorisation">Authorisation</a></li>
											</ul>
										</li>
										<li class="dropdown"><a href="user.html" class="dropdown-toggle" data-toggle="dropdown">User <b class="caret"></b></a>
											<ul class="dropdown-menu">
												<li><a href="user.html">User documentation</a></li>
												<li class="divider"></li>
												<li><a href="user.html#roles">Roles</a></li>
												<li><a href="user.html#workflows">Workflows</a></li>
												<li><a href="user.html#bulk_ingest">Generic bulk ingest</a></li>
											</ul>
										</li>
										<li class="dropdown"><a href="api.html" class="dropdown-toggle" data-toggle="dropdown">API <b class="caret"></b></a>
											<ul class="dropdown-menu">
												<li><a href="api.html">API documentation</a></li>
												<li class="divider"></li>
												<li><a href="api.html#Introduction">Introduction</a></li>
												<li><a href="api.html#ResourceIndexSearch">Resource index search</a></li>
												<li><a href="api.html#RESTAPI">REST API</a></li>
											</ul>
										</li>
									</ul>
							</div>
						</div>
					</div>

					<div class="container">
						<!-- Main hero unit for a primary marketing message or call to action -->
						<div class="hero-unit" style="position: relative;">
							<div>
								<img src="assets/eq-info.jpg" width="200"/>
							</div>
							<div style="position: absolute; left: 300px; top: 52px;">
                <h1>Vocabularies</h1>
								<p>Documentation about the vocabularies represented in the Quakestudies ontology.</p>
								<!--
								<p><a class="btn btn-primary btn-large">Learn more &raquo;</a></p>
								-->
							</div>
						</div>

						<div class="nav">
								<p class="trigger"><a href="#">toggle all</a></p> 
						</div>
						<div class="span8 offset2">
							<h1>Vocabularies used in Quakestudies Repository</h1>
							<xsl:apply-templates select="/rdf:RDF/rdfs:Class" />
						</div>
					</div>
					<hr/>
		
					<footer>
						<p>This work is licensed under a <a href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-Share Alike 3.0 Unported License</a>.</p>
					</footer>
					<xsl:call-template name="javascript" />
        </body>
			</html>
    </xsl:template>

    <xsl:template match="rdfs:Class">
        <div class="class_name">
            <xsl:variable select="@rdf:ID" name="class_name" />
            <h3 class="trigger"><a href="#"><xsl:value-of select="$class_name"/></a></h3>
            <div class="toggle_container">
                <xsl:for-each select="//owl:ObjectProperty[rdfs:domain[@*=concat('#', $class_name)]]">
                    <xsl:choose>
                        <xsl:when test="@rdf:about">
                            <xsl:call-template name="format_element">
                                <xsl:with-param name="property_type" select="local-name(.)"/>
                                <xsl:with-param name="element_name" select="substring(@rdf:about,2)"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="@rdf:ID">
                            <xsl:call-template name="format_element">
                                <xsl:with-param name="property_type" select="local-name(.)"/>
                                <xsl:with-param name="element_name" select="@rdf:ID"/>
                            </xsl:call-template>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:for-each select="//owl:DatatypeProperty[rdfs:domain[@*=concat('#', $class_name)]]">
                    <xsl:call-template name="format_element">
                        <xsl:with-param name="element_name" select="@rdf:ID"/>
                    </xsl:call-template>
                </xsl:for-each>
                <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]]">
                    <xsl:call-template name="format_element">
                        <xsl:with-param name="element_name" select="@rdf:ID"/>
                    </xsl:call-template>
                </xsl:for-each>
                <xsl:for-each select="//owl:*[local-name(.)='FunctionalProperty' or local-name(.)='ObjectProperty' or local-name(.)='DatatypeProperty'][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
                    <xsl:call-template name="format_element">
                        <xsl:with-param name="element_name" select="@rdf:ID"/>
                    </xsl:call-template>
                </xsl:for-each>        
            </div>
        </div>
    </xsl:template>

    <xsl:template name="format_element">
        <xsl:param name="element_name"/>
        <xsl:if test="rdfs:range/owl:DataRange/owl:oneOf//rdf:first">
            <table class="element">
                <tr class="element_name"><td colspan="2"><xsl:value-of select='$element_name'/></td></tr>
                <xsl:for-each select="rdfs:range/owl:DataRange/owl:oneOf//rdf:first">
                    <tr><td colspan="2"><xsl:value-of select="."/></td></tr>                    
                </xsl:for-each>
             </table>                
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text()|@*" />

</xsl:stylesheet>
