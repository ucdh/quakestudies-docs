<?xml version="1.0" encoding="UTF-8"?>
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

    <xsl:template name="css">

    <meta charset="utf-8"></meta>
    <title>Quakestudies Repository: ontology documentation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
    <meta name="description" content=""></meta>
    <meta name="author" content=""></meta>

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet"></link>
    <link href="css/bootstrap-responsive.css" rel="stylesheet"></link>
    <!-- note that the custom stylesheet overrides some of the CSS in the above stylesheets. -->
    <link href="css/custom.css" rel="stylesheet"></link>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="images/favicon.ico"></link>
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png"></link>
    <link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png"></link>
    <link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png"></link>
    </xsl:template>
    
    <xsl:template name="javascript">
			<!-- Le javascript
			================================================== -->
			<!-- Placed at the end of the document so the pages load faster -->
			<script src="js/jquery.js"></script>
			<!--
			<script src="js/bootstrap-transition.js"></script>
			<script src="js/bootstrap-alert.js"></script>
			<script src="js/bootstrap-modal.js"></script>
			<script src="js/bootstrap-dropdown.js"></script>
			<script src="js/bootstrap-scrollspy.js"></script>
			<script src="js/bootstrap-tab.js"></script>
			<script src="js/bootstrap-tooltip.js"></script>
			<script src="js/bootstrap-popover.js"></script>
			<script src="js/bootstrap-button.js"></script>
			<script src="js/bootstrap-collapse.js"></script>
			<script src="js/bootstrap-carousel.js"></script>
			<script src="js/bootstrap-typeahead.js"></script>
			-->
			<script type="text/javascript">
					$(document).ready(function(){            	
						$("p.trigger").click(function(){
							 $(".toggle_container").slideToggle("slow");
							 $(this).toggleClass("active");
						});
						$("h2.trigger").click(function(){
							$(this).toggleClass("active").next().slideToggle("slow");
						});
					});
			</script>
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap-transition.js"></script>
    <script src="js/bootstrap-alert.js"></script>
    <script src="js/bootstrap-modal.js"></script>
    <script src="js/bootstrap-dropdown.js"></script>
    <script src="js/bootstrap-scrollspy.js"></script>
    <script src="js/bootstrap-tab.js"></script>
    <script src="js/bootstrap-tooltip.js"></script>
    <script src="js/bootstrap-popover.js"></script>
    <script src="js/bootstrap-button.js"></script>
    <script src="js/bootstrap-collapse.js"></script>
    <script src="js/bootstrap-carousel.js"></script>
    <script src="js/bootstrap-typeahead.js"></script>
    </xsl:template>
    
</xsl:stylesheet>