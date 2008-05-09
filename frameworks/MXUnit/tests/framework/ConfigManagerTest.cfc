
<cfcomponent  extends="mxunit.framework.TestCase">

<cffunction name="testGetConfigElementValue">
 Tests whether or not UseRemoteFacadeObjectCache element returns true.
 <cfscript>
  val = cm.getConfigElementValue("pluginControl","UseRemoteFacadeObjectCache");
  addtrace('cm.getConfigElementValue("pluginControl","UseRemoteFacadeObjectCache"); = ' & val);
  assertTrue(val, "Value returned from xml config is not true, but should be");
 </cfscript>

</cffunction>

<cffunction name="testGetVersion">
 Tests that the version in the config file is 0.9
 <cfscript>
  val = cm.getConfigElementValue("meta","version");
  addtrace('cm.getConfigElementValue("meta","version") = ' & val);
  assertTrue(val, "Value returned from xml config is not 0.9, but should be");
 </cfscript>

</cffunction>

<cffunction name="testGetConfigElements">
 <cfset var assertionExtensionXpath =  "/mxunit-config/config-element[@type='assertionExtension' and @autoload='true']"  />
  Tests how many assertion config elements are returned for a given xpath (1).
 <cfscript>
  var elements = cm.getConfigElements(assertionExtensionXpath);
  addtrace( arraylen(elements) );
  assertTrue(arraylen(elements), 1, "More than one element returned from config");
 </cfscript>
</cffunction>

<cffunction name="setUp">
   <cfset  cm = createObject("component","mxunit.framework.ConfigManager").ConfigManager() />
   
</cffunction>

</cfcomponent>
