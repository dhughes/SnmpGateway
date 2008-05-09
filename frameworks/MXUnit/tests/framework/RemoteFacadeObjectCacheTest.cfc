<cfcomponent extends="mxunit.framework.TestCase">
	
	<cfset cache = "">
	
	<cffunction name="setup">
		<cfset cache = createObject("component", "mxunit.framework.RemoteFacadeObjectCache")>
	</cffunction>
	
	
	<cffunction name="testStartTestRun">
		<cfset initial = cache.getSuitePoolCount()>
		<cfset debug("initial: #initial#")>
		<cfset new1 = cache.startTestRun()>
		<cfset new2 = cache.startTestRun()>
		<cfset final = cache.getSuitePoolCount()>
		<cfset cache.endTestRun(new1)>
		<cfset cache.endTestRun(new2)>
		<cfset assertEquals(initial+2,final,"added 2, so suite should be 2 larger")>
	</cffunction>
	
	<cffunction name="testEndTestRun">
		<cfset initial = cache.getSuitePoolCount()>
		<cfset new1 = cache.startTestRun()>
		<cfset new2 = cache.startTestRun()>		
		<cfset cache.endTestRun(new1)>
		<cfset cache.endTestRun(new2)>
		<cfset final = cache.getSuitePoolCount()>
		<cfset assertEquals(initial,final,"added 2, then removed them, so suite should be same as when it started")>
	</cffunction>
	
	<cffunction name="testPurgeStaleTests">
		<!--- ensure everything that needs to go is gone--->
		<cfset cache.purgeStaleTests()>
		<cfset pool = cache.getSuitePool()>
		<cfset pool.blah1 = structnew()>
		<cfset pool.blah1.lastaccessed = dateAdd("n",-100,now())>
		<cfset pool.blah2 = structnew()>
		<cfset pool.blah2.lastaccessed = dateAdd("n",-100,now())>
		
		<cfset purged = cache.purgeStaleTests()>
		
		<cfset assertEquals(2,purged,"")>
	</cffunction>
	
	<cffunction name="testPurgeSuitePool">
		<cfset current = cache.purgeSuitePool()>
		<cfset assertEquals(0,current,"shouldn't be a pool no mo'")>
	</cffunction>
	
	<cffunction name="testGetObjectNotInCache">
		<cfset path = "mxunit.PluginDemoTests.SingleMethodTest">
		<cfset obj = cache.getObject(path,"")>
		<cfset md = getMetadata(obj)>
		<cfset assertEquals(path,md.name)>
		<cfset cache.purgeSuitePool()>
	</cffunction>
	
	<cffunction name="testGetObjectWhenCachePurged">
		<cfset path = "mxunit.PluginDemoTests.SingleMethodTest">
		<cfset key = cache.startTestRun()>
		<cfset obj = cache.getObject(path,key)>
		<cfset md = getMetadata(obj)>
		<cfset assertEquals(path,md.name)>
		
		<cfset cache.purgeSuitePool()>
		
		<cfset obj = cache.getObject(path,key)>
		<cfset md = getMetadata(obj)>
		<cfset assertEquals(path,md.name)>
		
		<cfset cache.purgeSuitePool()>
	</cffunction>
	
</cfcomponent>