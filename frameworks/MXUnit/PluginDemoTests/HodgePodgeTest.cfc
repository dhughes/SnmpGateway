<cfcomponent extends="mxunit.framework.TestCase">
	<cfset MyStruct = StructNew()>
	<cfset MyStruct.SomeData = "blahhhhhhh wahahahaha">


	<cffunction name="setUp" output="false" access="public" returntype="void" hint="">
	</cffunction>

	<cffunction name="tearDown" output="false" access="public" returntype="void" hint="">
		<!--- to be safe, since i know i'm monkeying with abandon up in this mofo --->
		<cfset setTestStyle("default")>
	</cffunction>


	<cffunction name="testOK">
		<cfset assertTrue(true,"true")>
		<cfoutput>Hi mommmmm  is< valid? what about & </cfoutput>
		<cfdump var="#MyStruct#">
		<cfset q = QueryNew("one,two")>
		<cfset QueryAddRow(q)>
		<cfset QuerySetCell(q,"one","one")>
		<cfset QuerySetCell(q,"two","two")>
		<cfdump var="#q#">
		<cfset addTrace("Hi mom")>

	</cffunction>

	<cffunction name="testFail" returntype="void" hint="">
		<cfoutput>wooopity doo!</cfoutput>
		<cfset debug("blah")>
		<cfset fail("failing intentionally")>
	</cffunction>

	<cffunction name="testNotEquals" returntype="void">
		<cfset assertEquals(1,2,"one is not two")>
	</cffunction>

	<cffunction name="testError" returntype="void" hint="">
		<cfset debug(arraynew(1))>
		<cfset debug("throwing error from inside testError before i throw intentionally")>
		 <cfthrow message="throwing error intentially">
	</cffunction>

	<cffunction name="throwErrorFromComponentNotInWorkspace" output="false" access="public" returntype="any" hint="calls a component that isn't in the cfeclipse workspace">
		<cfset var sc = createObject("component","SomeComponent")>
		<cfset sc.saySomething()>
		<cfset sc.throwAnError()>
	</cffunction>

	<cffunction name="testAnotherError" returntype="void" hint="">
		<cfinvoke component="mxunit.framework.Formatters" method="toStructs" xml="invalidxml" returnvariable="nothin">
	</cffunction>

	<cffunction name="testWithDebug">
		<cfset debug(StructNew())>
		<cfset debug(arraynew(1))>
		<cfdump var="#getDebug()#">
	</cffunction>

	<cffunction name="testPrivate" output="false" access="private">
		<cfthrow message="this is private and should never run">
	</cffunction>

	<cffunction name="testPackage" output="false" access="package">
		<cfthrow message="this is package and should never run">
	</cffunction>

	<cffunction name="testAssertTrueFailing" output="false" access="public" returntype="any" hint="">
		<cfset assertTrue(1 eq 2,"this should fail because one equals two is not true")>
	</cffunction>

	<cffunction name="testAssertTrueFailingWithoutMessage" output="false" access="public" returntype="any" hint="">
		<cfset assertTrue(1 eq 2)>
	</cffunction>

	<cffunction name="testAssertTrueOK">
		<cfset assertTrue(1 eq 1,"")>
	</cffunction>

	<cffunction name="testAssertTrueCFCUnitStyle">
		<cfset setTestStyle("default")>
		<cfset assertTrue(1 eq 1,"OK")>
		<cfset assertTrue(1 eq 1)>
	</cffunction>

	<cffunction name="testAssertTrueCFCUnitStyleFailure">
		<cfset setTestStyle("default")>
		<cfset assertTrue(1 eq 2,"1 does not equal 2")>
	</cffunction>

	<cffunction name="testAssertTrueCFUnitStyleFailure">
		<cfset setTestSTyle("cfunit")>
		<cfset assertTrue("false ain't true, sucka",false)>
	</cffunction>


</cfcomponent>