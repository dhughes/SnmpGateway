<cfcomponent generatedOn="02-09-2007 4:38:59 AM EST" extends="mxunit.framework.TestCase">
 

<cffunction name="testGenerateTestSuite">

  <cfset packs = this.generator.getPackages() />
 <!---  <cfset components = structFind(packs,"mxunit.tests.generator.fixture") > --->
  <cfset debug(packs)>
  <!---
  <cfinvoke component="#this.generator#"  method="generateTestSuite" returnVariable="actual">
    <cfinvokeargument	name="package" value="foo.bar" />
    <cfinvokeargument	name="components" value="#components#" />
    <cfinvokeargument	name="subDir" value="" />
    <cfinvokeargument	name="testSuitePath" value="" />
  </cfinvoke> 
 ---> 
  <cfset assertEquals(1,1) />

</cffunction>


<cffunction name="testGenerate">
  <cfinvoke component="#this.generator#"  method="generate" returnVariable="actual">
    <cfinvokeargument	name="component" value="#cfc#" />
    <cfinvokeargument	name="subDir" value="generator_temp_tests" />
    <cfinvokeargument	name="acceptDefaultValues" value="true" />
    <cfinvokeargument	name="xUnitPath" value="mxunit.framework.TestCase" />
    <cfinvokeargument	name="overwrite" value="true" />
    <cfinvokeargument	name="destination" value="" />
  </cfinvoke>
  <cfset debug("actual = " & actual) />
  <cfset debug("target = " & target) />
  <cfset assertTrue(fileExists(target), "Target generated file was not found. ") />
  <cfset assertEquals(target,actual, "Target and actual files are different.") />

</cffunction>


<cffunction name="testGetPackagesAsXml">
  <cfinvoke component="#this.generator#"  method="getPackagesAsXml" returnVariable="actual">
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertEquals(1,1) />

</cffunction>


<cffunction name="testABunchOfParams">
  <cfinvoke component="#this.generator#"  method="aBunchOfParams" returnVariable="actual">
    <cfinvokeargument	name="component" value="#this#" />
    <cfinvokeargument	name="aString" value="foo" />
    <cfinvokeargument	name="aBoolean" value="false" />
    <cfinvokeargument	name="aNumber" value="1" />
    <cfinvokeargument	name="anInt" value="3900" />
    <cfinvokeargument	name="noType" value="3900" />
  </cfinvoke>
  <cfset debug("actual = " & actual) />
  <cfset assertEquals(1,1) />

</cffunction>


<cffunction name="testGenerateTestMethods">
  <cfset var expected = '<cfset this.arbitraryCFComponent = createObject("component","mxunit.tests.generator.fixture.ArbitraryCFComponent") />' />
  <cfset var found = false />
  <cfinvoke component="#this.generator#"  method="generateTestMethods" returnVariable="actual">
    <cfinvokeargument	name="component" value="#cfc#" />
  </cfinvoke>
  <cfset debug("actual = " & actual) />
  <cfset found = find(expected,actual) />
  <cfset assertTrue(found gt 0, "createObject(...) substring was not *correctly* found in generated methods.") />

</cffunction>


<cffunction name="testGenerateAll">
  
  <cftry>
  <cfinvoke component="#this.generator#"  method="generateAll" returnVariable="actual">
  </cfinvoke>  
  <cfcatch type="mxunit.exception.NotImplementedException" />
    <!--- no worries. we want this to fail --->
  </cftry>

  

</cffunction>


<cffunction name="testGetPackages">
  <cfinvoke component="#this.generator#"  method="getPackages" returnVariable="actual">
  </cfinvoke>
  <cfset debug(actual) />
  <cfset assertEquals(1,1) />

</cffunction>


<cffunction name="testGenerator">
  <cfinvoke component="#this.generator#"  method="Generator" returnVariable="actual">
  </cfinvoke>
  <!--- <cfset debug(getMetaData(actual).extends) /> --->
  <cfset assertIsTypeOf(actual, "mxunit.generator.Generator", "The value returned from Generator constructor is not of Generator type.") />

</cffunction>


<!--- Override these methods as needed. Note that the call to setUp() is Required if using a this-scoped instance--->

<cffunction name="setUp">

<!--- Assumption: Instantiate an instance of the component we want to test --->
<cfset this.generator = createObject("component","mxunit.generator.Generator") />

<!--- Add additional set up code here--->
 <cfset  cfc = createObject("component","mxunit.tests.generator.fixture.ArbitraryCFComponent") />
 <!--- When generating a single file, it should be this, though I don't like the install cfxm7' --->
 
 <cfset target = expandPath("/mxunit/tests/generator/fixture/generator_temp_tests/ArbitraryCFComponentTest.cfc") />
 <cfdirectory action="create" directory="#expandPath('/mxunit/tests/generator/fixture/generator_temp_tests/')#">
</cffunction>
 

<cffunction name="tearDown">
  <!--- Clean up --->
 <cfif fileexists(target)>
   <cffile action="delete" file="#target#" /> 
 </cfif>
  <cfdirectory action="delete" directory="#expandPath('/mxunit/tests/generator/fixture/generator_temp_tests/')#">
</cffunction>


</cfcomponent>
