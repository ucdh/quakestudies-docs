<?xml version="1.0" encoding="UTF-8"?>
<!-- owl_to_schema.xslt: convert quakestudies owl to schema XML -->
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
    xmlns:qsr="http://quakestudies.canterbury.ac.nz"
    exclude-result-prefixes="xsl rdf protege xsp owl xsd swrl swrlb rdfs"
    >
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:include href="css.xslt"/>
    
    <xsl:variable name="lcletters">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    <xsl:variable name="ucletters">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
    <xsl:variable name="base" select="/rdf:RDF/@xml:base"></xsl:variable>
    <xsl:variable name="qsr">qsr</xsl:variable>
    
    <!-- main template-->
    <xsl:template match="/">
        <xsl:call-template name="css" />
        <body>
            <div class="main">
                <div class="nav">
                    <p class="trigger"><a href="#">toggle all</a></p> 
                </div>
                <h1>Quakestudies Repository: Schema description</h1>
                <xsl:apply-templates select="/rdf:RDF/rdfs:Class" />
            </div>
        </body>
    </xsl:template>

    <xsl:template match="rdfs:Class">
        <div class="class_name">
            <xsl:variable select="@rdf:ID" name="class_name" />
            <h3 class="trigger"><a href="#"><xsl:value-of select="$class_name"/></a></h3>
            <div class="toggle_container">
                <table class="element">
                    <tr><td colspan="2">&lt;<xsl:value-of select='$class_name'/>&gt;</td></tr>
                    <tr><td colspan="2">&#160;&#160;&#160;&#160;&lt;properties&gt;</td></tr>
                    <xsl:for-each select="//owl:DatatypeProperty[rdfs:domain[@*=concat('#', $class_name)]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>            
                    <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'DatatypeProperty')]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>
                    <xsl:for-each select="//owl:*[local-name(.)='FunctionalProperty'][rdf:type[contains(@rdf:resource,'DatatypeProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>
                    <xsl:for-each select="//owl:*[local-name(.)='DatatypeProperty'][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>
                    <tr><td colspan="2">&#160;&#160;&#160;&#160;&lt;/properties&gt;</td></tr>
                    <tr><td colspan="2">&#160;&#160;&#160;&#160;&lt;relations&gt;</td></tr>
                    <xsl:for-each select="//owl:ObjectProperty[rdfs:domain[@*=concat('#', $class_name)]]">
                        <xsl:choose>
                            <xsl:when test="@rdf:about">
                                <xsl:call-template name="format_element">
                                    <xsl:with-param name="element_name" select="substring(@rdf:about,2)"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:when test="@rdf:ID">
                                <xsl:call-template name="format_element">
                                    <xsl:with-param name="element_name" select="@rdf:ID"/>
                                </xsl:call-template>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>
                    <xsl:for-each select="//owl:*[local-name(.)='FunctionalProperty'][rdf:type[contains(@rdf:resource,'ObjectProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>
                    <xsl:for-each select="//owl:*[local-name(.)='ObjectProperty'][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
                        <xsl:call-template name="format_element">
                            <xsl:with-param name="element_name" select="@rdf:ID"/>
                        </xsl:call-template>
                    </xsl:for-each>
                    <tr><td colspan="2">&#160;&#160;&#160;&#160;&lt;/relations&gt;</td></tr>
                    <tr><td colspan="2">&lt;/<xsl:value-of select='$class_name'/>&gt;</td></tr>
                </table>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="format_element">
        <xsl:param name="element_name"/>
        <tr><td colspan="2">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&lt;<xsl:value-of select='$element_name'/>/&gt;</td></tr>
    </xsl:template>
    
    <xsl:template match="text()|@*" />

</xsl:stylesheet>
