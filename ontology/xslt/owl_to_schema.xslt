<?xml version="1.0" encoding="UTF-8"?>
<!-- owl_to_schema.xslt: convert quakestudies owl to XML schema -->
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
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl rdf protege xsp owl xsd swrl swrlb rdfs"
    >
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:variable name="base" select="/rdf:RDF/@xml:base"></xsl:variable>
    
    <!-- main template-->
    <xsl:template match="/">
      <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified" targetNamespace="http://quakestudies.canterbury.ac.nz" xmlns:qsr="http://quakestudies.canterbury.ac.nz" xmlns:dcmi="http://purl.org/dc/dcmitype/">
        <xs:import namespace="http://www.w3.org/XML/1998/namespace" schemaLocation="xml.xsd"/>
        <xs:import namespace="http://purl.org/dc/dcmitype/" schemaLocation="http://dublincore.org/schemas/xmls/qdc/dcmitype.xsd"/>
        <xs:element name="content">
          <xs:complexType>
            <xs:all>
              <xsl:for-each select="/rdf:RDF/rdfs:Class[@rdf:ID='Format' or @rdf:ID='DateTime' or @rdf:ID='Collection' or @rdf:ID='Part' or @rdf:ID='Event' or @rdf:ID='Object' or @rdf:ID='Address' or @rdf:ID='Person' or @rdf:ID='Category' or @rdf:ID='ContentPartner' or @rdf:ID='Version' or @rdf:ID='License' or @rdf:ID='Party' or @rdf:ID='Availability' or @rdf:ID='Audience' or @rdf:ID='Role' or @rdf:ID='Position']">
                <xsl:element name="xs:element">
                  <xsl:attribute name="ref"><xsl:value-of select="concat('qsr:',@rdf:ID)"/></xsl:attribute>
                  <xsl:attribute name="minOccurs">0</xsl:attribute>
                  <xsl:attribute name="maxOccurs">1</xsl:attribute>
                </xsl:element>
              </xsl:for-each>
            </xs:all>
			<xs:attribute name="origin"/>
			<xs:attribute name="url"/>
			</xs:complexType>
        </xs:element>
        <xsl:apply-templates select="/rdf:RDF/rdfs:Class[@rdf:ID='Format' or @rdf:ID='DateTime' or @rdf:ID='Collection' or @rdf:ID='Part' or @rdf:ID='Event' or @rdf:ID='Object' or @rdf:ID='Address' or @rdf:ID='Person' or @rdf:ID='Category' or @rdf:ID='ContentPartner' or @rdf:ID='Version' or @rdf:ID='License' or @rdf:ID='Party' or @rdf:ID='Availability' or @rdf:ID='Audience' or @rdf:ID='Role' or @rdf:ID='Position']" />

        <xs:element name="properties">
          <xs:complexType>
            <xs:choice>
              <xsl:for-each select="/rdf:RDF/rdfs:Class[@rdf:ID='Format' or @rdf:ID='DateTime' or @rdf:ID='Collection' or @rdf:ID='Part' or @rdf:ID='Event' or @rdf:ID='Object' or @rdf:ID='Address' or @rdf:ID='Person' or @rdf:ID='Category' or @rdf:ID='ContentPartner' or @rdf:ID='Version' or @rdf:ID='License' or @rdf:ID='Party' or @rdf:ID='Availability' or @rdf:ID='Audience' or @rdf:ID='Role' or @rdf:ID='Position']">
                <xs:sequence>
                  <xsl:call-template name="properties-ref">
                    <xsl:with-param name="class_name" select="@rdf:ID"/>
                    <xsl:with-param name="class_type">ref</xsl:with-param>
                  </xsl:call-template>
                </xs:sequence>
              </xsl:for-each>          
            </xs:choice>
          </xs:complexType>
        </xs:element>

        <xsl:for-each select="/rdf:RDF/rdfs:Class[@rdf:ID='Format' or @rdf:ID='DateTime' or @rdf:ID='Collection' or @rdf:ID='Part' or @rdf:ID='Event' or @rdf:ID='Object' or @rdf:ID='Address' or @rdf:ID='Person' or @rdf:ID='Category' or @rdf:ID='ContentPartner' or @rdf:ID='Version' or @rdf:ID='License' or @rdf:ID='Party' or @rdf:ID='Availability' or @rdf:ID='Audience' or @rdf:ID='Role' or @rdf:ID='Position']">
          <xsl:call-template name="properties-name">
            <xsl:with-param name="class_name" select="@rdf:ID"/>
            <xsl:with-param name="class_type">name</xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>          

        <xs:element name="relations">
          <xs:complexType>
            <xs:choice>
              <xsl:for-each select="/rdf:RDF/rdfs:Class[@rdf:ID='Format' or @rdf:ID='DateTime' or @rdf:ID='Collection' or @rdf:ID='Part' or @rdf:ID='Event' or @rdf:ID='Object' or @rdf:ID='Address' or @rdf:ID='Person' or @rdf:ID='Category' or @rdf:ID='ContentPartner' or @rdf:ID='Version' or @rdf:ID='License' or @rdf:ID='Party' or @rdf:ID='Availability' or @rdf:ID='Audience' or @rdf:ID='Role' or @rdf:ID='Position']">
                <xsl:variable select="@rdf:ID" name="class_name" />
                  <xsl:if test="//owl:ObjectProperty[rdfs:domain[@*=concat('#', $class_name)]] or 
                    //owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]] or 
                    //owl:InverseFunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]] or 
                    //owl:*[local-name(.)='FunctionalProperty'][rdf:type[contains(@rdf:resource,'ObjectProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]] or 
                    //owl:*[local-name(.)='ObjectProperty'][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
                    <xs:sequence>
                      <xsl:call-template name="relations-ref">
                        <xsl:with-param name="class_name" select="$class_name"/>
                        <xsl:with-param name="class_type">ref</xsl:with-param>
                      </xsl:call-template>
                    </xs:sequence>
                  </xsl:if>
              </xsl:for-each>          
              <xs:sequence>
              </xs:sequence>
            </xs:choice>
          </xs:complexType>
        </xs:element>

        <xsl:for-each select="/rdf:RDF/rdfs:Class[@rdf:ID='Format' or @rdf:ID='DateTime' or @rdf:ID='Collection' or @rdf:ID='Part' or @rdf:ID='Event' or @rdf:ID='Object' or @rdf:ID='Address' or @rdf:ID='Person' or @rdf:ID='Category' or @rdf:ID='ContentPartner' or @rdf:ID='Version' or @rdf:ID='License' or @rdf:ID='Party' or @rdf:ID='Availability' or @rdf:ID='Audience' or @rdf:ID='Role' or @rdf:ID='Position']">
          <xsl:call-template name="relations-name">
            <xsl:with-param name="class_name" select="@rdf:ID"/>
            <xsl:with-param name="class_type">name</xsl:with-param>
          </xsl:call-template>          
        </xsl:for-each>          
      </xs:schema>

    </xsl:template>

    <xsl:template match="rdfs:Class">
      <xsl:variable select="@rdf:ID" name="class_name" />
      <xs:element>
        <xsl:attribute name="name"><xsl:value-of select="$class_name"/></xsl:attribute>
        <xs:complexType>
          <xs:all>
            <xs:element ref="qsr:properties">
              <xsl:if test="not(//owl:DatatypeProperty[rdfs:domain[@*=concat('#', $class_name)]]) and  
                not(//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'DatatypeProperty')]]) and 
                not(//owl:*[local-name(.)='FunctionalProperty'][rdf:type[contains(@rdf:resource,'DatatypeProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]) and 
                not(//owl:*[local-name(.)='DatatypeProperty'][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]])">
                <xsl:attribute name="minOccurs">0</xsl:attribute>
              </xsl:if>
              <xsl:attribute name="maxOccurs">1</xsl:attribute>
            </xs:element>
            <xs:element ref="qsr:relations">
              <xsl:if test="not(//owl:ObjectProperty[rdfs:domain[@*=concat('#', $class_name)]]) and 
                not(//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]]) and 
                not (//owl:*[local-name(.)='FunctionalProperty'][rdf:type[contains(@rdf:resource,'ObjectProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]) and 
                not (//owl:*[local-name(.)='ObjectProperty'][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]])">
                <xsl:attribute name="minOccurs">0</xsl:attribute>
              </xsl:if>
              <xsl:attribute name="maxOccurs">1</xsl:attribute>
            </xs:element>
          </xs:all>
          <xs:attribute ref="xml:id" use="required"/>
        </xs:complexType>
      </xs:element>      
    </xsl:template>

    <xsl:template name="properties-ref">
      <xsl:param name="class_name" />
      <xsl:param name="class_type" />
      <xsl:for-each select="//owl:DatatypeProperty[rdfs:domain[@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>            
      <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'DatatypeProperty')]]">
      <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:FunctionalProperty[rdf:type[contains(@rdf:resource,'DatatypeProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:DatatypeProperty[rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:template>

    <xsl:template name="properties-name">
      <xsl:param name="class_name" />
      <xsl:param name="class_type" />
      <xsl:for-each select="//owl:DatatypeProperty[rdfs:domain[@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>            
      <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'DatatypeProperty')]]">
      <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:FunctionalProperty[rdf:type[contains(@rdf:resource,'DatatypeProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[1][@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:DatatypeProperty[rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[1][@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:template>

    <xsl:template name="relations-ref">
      <xsl:param name="class_name" />
      <xsl:param name="class_type" />
      <xsl:for-each select="//owl:ObjectProperty[rdfs:domain[@*=concat('#', $class_name)]]">
        <xsl:choose>
          <xsl:when test="@rdf:about">
            <xsl:call-template name="format_element">
              <xsl:with-param name="element_name" select="substring(@rdf:about,2)"/>
              <xsl:with-param name="element_type" select="$class_type"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="@rdf:ID">
            <xsl:call-template name="format_element">
              <xsl:with-param name="element_name" select="@rdf:ID"/>
              <xsl:with-param name="element_type" select="$class_type"/>
            </xsl:call-template>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:InverseFunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:FunctionalProperty[rdf:type[contains(@rdf:resource,'ObjectProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:ObjectProperty[rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="relations-name">
      <xsl:param name="class_name" />
      <xsl:param name="class_type" />
      <xsl:for-each select="//owl:ObjectProperty[rdfs:domain[@*=concat('#', $class_name)]]">
        <xsl:choose>
          <xsl:when test="@rdf:about">
            <xsl:call-template name="format_element">
              <xsl:with-param name="element_name" select="substring(@rdf:about,2)"/>
              <xsl:with-param name="element_type" select="$class_type"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="@rdf:ID">
            <xsl:call-template name="format_element">
              <xsl:with-param name="element_name" select="@rdf:ID"/>
              <xsl:with-param name="element_type" select="$class_type"/>
            </xsl:call-template>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <xsl:for-each select="//owl:FunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:InverseFunctionalProperty[rdfs:domain[@*=concat('#', $class_name)]][rdf:type[contains(@rdf:resource,'ObjectProperty')]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:FunctionalProperty[rdf:type[contains(@rdf:resource,'ObjectProperty')]][rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[1][@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//owl:ObjectProperty[rdfs:domain/owl:Class/owl:unionOf/rdfs:Class[1][@*=concat('#', $class_name)]]">
        <xsl:call-template name="format_element">
          <xsl:with-param name="element_name" select="@rdf:ID"/>
          <xsl:with-param name="element_type" select="$class_type"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:template>

    <xsl:template name="format_element">
      <xsl:param name="element_name"/>
      <xsl:param name="element_type"/>
      <xsl:choose>
        <xsl:when test="$element_type = 'ref'">
          <xsl:element name="xs:element">
            <xsl:attribute name="ref"><xsl:value-of select="concat('qsr:',$element_name)"/></xsl:attribute>
          </xsl:element>
        </xsl:when>
        <xsl:when test="$element_type = 'name'">
          <xsl:element name="xs:element">
            <xsl:attribute name="name"><xsl:value-of select="$element_name"/></xsl:attribute>
            <xsl:choose>
              <xsl:when test="starts-with(rdfs:range/@rdf:resource,'#')">
                <xs:complexType>
                  <xs:attribute name="idref"/>
                </xs:complexType>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="type">
                  <xsl:choose>
                    <!-- Certain types need special treatment -->
                    <xsl:when test="$element_name = 'mime_type'"><xsl:value-of select="concat('qsr:','type_',$element_name)"/></xsl:when>
                    <xsl:when test="$element_name = 'format_type'">dcmi:DCMIType</xsl:when>
                    <xsl:when test="rdfs:range/@rdf:resource='http://www.w3.org/2001/XMLSchema#string'">xs:string</xsl:when>
                    <xsl:when test="rdfs:range/@rdf:resource='http://www.w3.org/2001/XMLSchema#int'">xs:int</xsl:when>
                    <xsl:when test="rdfs:range/@rdf:resource='http://www.w3.org/2001/XMLSchema#float'">xs:float</xsl:when>
                    <xsl:when test="rdfs:range/owl:DataRange"><xsl:value-of select="concat('qsr:','type_',$element_name)"/></xsl:when>
                    <xsl:otherwise>xs:ID</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
				</xsl:otherwise>
            </xsl:choose>
          </xsl:element>
          <xsl:choose>
            <!-- Certain types need special treatment -->
            <xsl:when test="$element_name = 'mime_type'">
              <xs:simpleType>
                <xsl:attribute name="name"><xsl:value-of select="concat('type_',$element_name)"/></xsl:attribute>
                <xs:restriction base="xs:string">
                  <xsl:comment>&lt;xs:enumeration value="application/x-shockwave-flash"/&gt;</xsl:comment>
                  <xs:pattern value="[-a-z]*/[-+a-z0-9]*"/>
                </xs:restriction>
              </xs:simpleType>
            </xsl:when>
            <xsl:when test="rdfs:range/owl:DataRange">
              <xs:simpleType>
                <xsl:attribute name="name"><xsl:value-of select="concat('type_',$element_name)"/></xsl:attribute>
                <xs:restriction base="xs:string">
                  <xsl:for-each select="rdfs:range/owl:DataRange//rdf:first">
                    <xs:enumeration>
                      <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
                    </xs:enumeration>
                  </xsl:for-each>
                    <!-- Allow empty strings -->
                    <xs:enumeration>
                      <xsl:attribute name="value"></xsl:attribute>
                    </xs:enumeration>
                </xs:restriction>
              </xs:simpleType>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </xsl:template>
    
    <xsl:template match="text()|@*" />

</xsl:stylesheet>
