<cfcomponent extends="mxunit.framework.TestCase">

	<cfset objUnderTest = "">
	
	<cffunction name="setUp">
		<!--- we'll use this here object as a target, just for demonstration --->
		<cfset objUnderTest = createObject("component","PrivateMethodTest")>
	</cffunction>

	<cffunction name="testPrivateDirectly">
		<!--- this is gonna fail! --->
		<cfset result = objUnderTest.somePrivateMethod("blah")>
		<cfset assertEquals("blah",result)>
	</cffunction>
	
	<cffunction name="testPrivateAndLookNoError">
		<cfset makePublic(objUnderTest,"somePrivateMethod","_YeeHaw")>
		<cfset result = objUnderTest._YeeHaw("blah")>
		<cfset assertEquals("blah",result)>
		
		<!--- without the 3rd arg, it defaults to the method name with an underscore in front --->
		<cfset makePublic(objUnderTest,"somePrivateMethod")>
		<cfset result = objUnderTest._somePrivateMethod("i love this stuff!")>
		<cfset assertEquals("i love this stuff!",result)>
	</cffunction>

	<!--- pretend this is in some other object you're trying to test --->
	<cffunction name="somePrivateMethod" access="private">
		<cfargument name="arg1" type="string" required="false" default="">
		<cfreturn arg1>
	</cffunction>

</cfcomponent>