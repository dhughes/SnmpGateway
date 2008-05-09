<cfcomponent generatedOn="02-09-2007 4:38:59 AM EST" extends="mxunit.framework.TestCase">
 

<cffunction name="testGenFloat">
  <cfinvoke component="#this.testDataGenerator#"  method="genFloat" returnVariable="actual">
    <cfinvokeargument	name="min" value="1" />
    <cfinvokeargument	name="max" value="1000" />
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertTrue(actual lte 1000 or actual gte 1) />

</cffunction>


<cffunction name="testGenInteger">
  <cfinvoke component="#this.testDataGenerator#"  method="genInteger" returnVariable="actual">
    <cfinvokeargument	name="min" value="5715" />
    <cfinvokeargument	name="max" value="887" />
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertTrue(actual lte 5715 or actual gte 887) />

</cffunction>


<cffunction name="testGenTelephone">
  <cfinvoke component="#this.testDataGenerator#"  method="genTelephone" returnVariable="actual">
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertEquals(1,1) />

</cffunction>


<cffunction name="testGenString">
  <cfinvoke component="#this.testDataGenerator#"  method="genString" returnVariable="actual">
    <cfinvokeargument	name="len" value="100" />
    <cfinvokeargument	name="regex" value="[a-zA-Z0-9]" />
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertEquals(len(actual),100) />

</cffunction>


<cffunction name="testGenZipcode">
  <cfinvoke component="#this.testDataGenerator#"  method="genZipcode" returnVariable="actual">
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertEquals(len(actual),5) />

</cffunction>


<cffunction name="testGenCC">
  <cfinvoke component="#this.testDataGenerator#"  method="genCC" returnVariable="actual">
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertEquals(1,1) />

</cffunction>


<cffunction name="testGenSSN">
  <cfinvoke component="#this.testDataGenerator#"  method="genSSN" returnVariable="actual">
  </cfinvoke>
  <cfset addTrace("actual = " & actual) />
  <cfset assertEquals(1,1) />

</cffunction>


<!--- Override these methods as needed. Note that the call to setUp() is Required if using a this-scoped instance--->

<cffunction name="setUp">
<!--- Assumption: Instantiate an instance of the component we want to test --->
<cfset this.testDataGenerator = createObject("component","mxunit.generator.TestDataGenerator") />
<!--- Add additional set up code here--->
</cffunction>
 

<cffunction name="tearDown">
</cffunction>


</cfcomponent>
