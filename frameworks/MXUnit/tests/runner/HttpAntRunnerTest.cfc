<cfcomponent generatedOn="12-12-2007 4:35:38 AM EST" extends="mxunit.framework.TestCase">
 

<cffunction name="testRun">

 Tests the AntRunner and makes sure the generated content is aok
  <cfsavecontent variable="actual">
  <cfinvoke component="#httpAntRunner#"  method="run">
    <cfinvokeargument name="type" value="dir" />
    <cfinvokeargument name="value" value="#dir#" />
    <cfinvokeargument name="packagename" value="mxunit.httpantrunnertests" />
    <cfinvokeargument name="outputformat" value="xml" />
	<cfinvokeargument name="recurse" value="false">
  </cfinvoke>
  </cfsavecontent>  
 <!---  <cfset debug(actual)> --->
  <cfset actual = replace(actual,'<?xml version="1.0" encoding="UTF-8"?>','','one') />
  <cfset rsDom = xmlParse(actual) />
  <cfset assertisXmlDoc(rsDom) />
  <cfset debug(rsDom.xmlroot.xmlAttributes) />
  <cfset assertEquals(rsDom.xmlroot.xmlAttributes["tests"],8,"Should only be 8 tests in this suite") />
  
  <cfreturn />
   
  <cfsavecontent variable="actual">
  <cfinvoke component="#httpAntRunner#"  method="run">
    <cfinvokeargument name="type" value="dir" />
    <cfinvokeargument name="value" value="#dir#" />
    <cfinvokeargument name="packagename" value="mxunit.httpantrunnertests" />
    <cfinvokeargument name="outputformat" value="junitxml" />
	<cfinvokeargument name="recurse" value="false">
  </cfinvoke>
  </cfsavecontent>
  <cfset rsDom = xmlParse(actual) />
  <cfset assertisXmlDoc(rsDom) />
  <cfset debug(rsDom.xmlroot.xmlAttributes) />
  <cfset assertEquals(rsDom.xmlroot.xmlAttributes["tests"],8,"Should only be 8 tests in this suite") />
  
  
  <cfsavecontent variable="actual">
  <cfinvoke component="#httpAntRunner#"  method="run">
    <cfinvokeargument name="type" value="dir" />
    <cfinvokeargument name="value" value="#dir#" />
    <cfinvokeargument name="packagename" value="mxunit.httpantrunnertests" />
    <cfinvokeargument name="outputformat" value="html" />
	<cfinvokeargument name="recurse" value="false">
  </cfinvoke>
  </cfsavecontent>
  <!--- Search for this pattern:
    <title>Test Results [12/12/07 06:12:47] [127.0.0.1]</title>   
  --->
  <cfset found = refind("<title>Test Results \[[0-9]{2}/[0-9]{2}/[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}[ ]*.*</title>", actual, 0, true)>
  <cfset debug(found) />
  <cfset assertTrue(arrayLen(found.len) gt 0) />
  <cfset assertTrue(arrayLen(found.pos) gt 0) /> 
 
</cffunction>


<!--- Override these methods as needed. Note that the call to setUp() is Required if using a this-scoped instance--->

<cffunction name="setUp">
<!--- Assumption: Instantiate an instance of the component we want to test --->
 <cfset httpAntRunner = createObject("component","mxunit.runner.HttpAntRunner") />
 
 <!--- Below is to adjust context depending upon the runner. --->
 <!--- Logic maybe should be a static util as setContext() ... 
 <cfset dirPath = expandPath("HttpAntRunnerTest.cfc")>
 <cfset contextDir = getDirectoryFromPath(dirPath) />
 <cfset dir = listSetAt(contextDir,listLen(contextDir,'\'),'','\') />
 <cfset dir = dir & 'framework\fixture\fixturetests\' />
 
 <cfset debug("contextDir=" & contextDir) />
 <cfset debug(listLen(contextDir,'\')) />
 --->
 <cfset dir = expandPath('/mxunit/tests/framework/fixture/fixturetests') />
 
 <cfset debug(dir) />
 
<!--- Add additional set up code here--->
</cffunction>
 

<cffunction name="tearDown">
   <cfset debug(dir) />
</cffunction>



</cfcomponent>
