<cfcomponent extends="mxunit.framework.TestCase">
	<cfset rf = createObject("component","mxunit.framework.RemoteFacade")>

	<cffunction name="testPing" returntype="void" hint="">
		<cfset var b = rf.ping()>
		<cfset assertTrue(b,"should be true")>
	</cffunction>
	
	<cffunction name="testGetComponentMethods">		
		<cfset var a_methods = rf.getComponentMethods("mxunit.PluginDemoTests.EmptyTest")>
		<cfset assertEquals(0,ArrayLen(a_methods),"should be 0 runnable methods in EmptyTest")>
		<cfset a_methods = rf.getComponentMethods("mxunit.PluginDemoTests.SingleMethodTest")>
		<cfset assertEquals(1,ArrayLen(a_methods),"should be one runnable method in SingleMethodTest")>
		<cfset a_methods = rf.getComponentMethods("mxunit.PluginDemoTests.DoubleMethodTest")>
		<cfset assertEquals(2,ArrayLen(a_methods),"should be 2 runnable methods in DoubleMethodTest")>
	</cffunction>


	<cffunction name="testExecuteTestCase" returntype="void" hint="">
		<cfset var name = "mxunit.PluginDemoTests.DoubleMethodTest">
		<cfset var methods = "">
		<cfset var results = "">
		
		<cfset results = rf.executeTestCase(name,methods,"")>
		<cfset methods = rf.getComponentMethods(name)>
		<!--- <cfset debug(results)> --->
		<cfset assertTrue(isStruct(results),"results should be struct")>		
		<cfset assertEquals(ArrayLen(methods),ArrayLen(StructKeyArray(results[name])),"")>
	</cffunction>
	
	<cffunction name="testStartTestRun">
		<cfset key = rf.startTestRun()>
		<cfset assertTrue(len(key) GT 0)>
	</cffunction>
	
	

</cfcomponent>
