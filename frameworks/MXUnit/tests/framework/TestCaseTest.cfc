<!--- 
 MXUnit TestCase Template
 @author
 @description
 @history
 --->
 
<cfcomponent  extends="mxunit.framework.TestCase">

  <cffunction name="getSomeValue" hint="Used by child test for testing inherited tests" returntype="string">
   <cfreturn "Some TestCase Data To Read" />
  </cffunction>

<!--- Begin Specific Test Cases --->
	<cffunction name="testGetRunnableMethodsSimple">		
		<!--- Should be 2 --->
    	<cfset methods = this.getRunnableMethods()>		
		<cfset thesemethods = getMetadata(this)>
		<!--- the 3 is the one private function plus the setup and teardown functions --->
		<cfset expectedMethodCount = Arraylen(thesemethods.functions) - 3>
		<cfset assertEquals(ArrayLen(methods),expectedMethodCount,"returned methods should be 2 less than total methods in this test case (excludes setup/teardown/private/package)")>
	</cffunction>
	
	<cffunction name="testGetRunnableMethodsInheritance">
		<cfset baseobj = createobject("component","mxunit.PluginDemoTests.inheritance.BaseTest")>
		<cfset obj1 = createObject("component","mxunit.PluginDemoTests.inheritance.SomeExtendingTest")>
		<cfset obj2 = createObject("component","mxunit.PluginDemoTests.inheritance.SomeDoublyExtendingTest")>
		<cfset md = getMetadata(baseobj)>
		<cfset md2 = getMetadata(obj1)>
		<cfset md3 = getMetadata(obj1)>
		<cfset totalMethods = ArrayLen(md.functions) + ArrayLen(md2.functions) + ArrayLen(md.functions)>
		<cfset methods = obj2.getRunnableMethods()>
		<cfset debug(totalMethods)> 
		<cfset assertEquals(totalMethods-1,ArrayLen(methods),"count of total returned methods should equal cumulative method count for all 3 objects minus 1, since one of the tests overrides a parent function")>	 	
	</cffunction>
	
	<cffunction name="testGetRunnableMethodsHyphenInName" output="false" access="public" returntype="void" hint="">
		<cfset cfcWithHyphen = createObject("component","mxunit.tests.framework.fixture.mxunit-TestCase-Template")>
		<cfset methods = cfcWithHyphen.getRunnableMethods()>
		<cfset md = getMetadata(cfcWithHyphen)>
		<cfset debug(methods)>
		<cfset assertEquals(arraylen(md.functions)-2,arraylen(methods),"number of runnable methods should be 2 fewer than total number of methods (subtracting out setup and teardown)")>
	</cffunction>
	
	
	<cffunction name="testMakePublicPassthroughSanityCheck" hint="make sure it would fail if we tried calling it directly">
		<cfset objWithPrivate = createObject("component","TestCaseTest")>			
		<cftry>
			<cfset objWithPrivate.aPrivateMethod()>	
			<cfset fail("should've thrown error before it go to here")>
		<cfcatch type="mxunit.AssertionFailedException">
			<cfrethrow>
		</cfcatch>
		<cfcatch></cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="setUpAndTearDownAreNotAcceptableTests">
		<cfset makePublic(this,"testIsAcceptable")>
		<cfset s_test = structnew()>
		<cfset s_test.name = "setup">
		<cfset s_test.access = "public">		
		<cfset result = this._testIsAcceptable(s_test)>
		<cfset assertFalse(result,"setup should not be acceptable")>
		
		<cfset s_test.name = "teardown">		
		<cfset result = this._testIsAcceptable(s_test)>
		<cfset assertFalse(result,"teardown should not be acceptable")>
	</cffunction>
	
	<cffunction name="privateAndPackageAreNotAcceptableTests">
		<cfset makePublic(this,"testIsAcceptable")>
		
		<cfset s_test = structnew()>
		<cfset s_test.name = "someTestGoesHere">
		<cfset s_test.access = "private">		
		<cfset result = this._testIsAcceptable(s_test)>
		<cfset assertFalse(result,"private test not be acceptable")>
		
		<cfset s_test.access = "package">		
		<cfset result = this._testIsAcceptable(s_test)>
		<cfset assertFalse(result,"package test should not be acceptable")>
	</cffunction>
	
	<cffunction name="cfthreadsInTestAreNotAcceptableTests">
		<cfset makePublic(this,"testIsAcceptable")>
		
		<cfset s_test = structnew()>
		<cfset s_test.name = "_cffunccfthread">
		<cfset s_test.access = "public">		
		<cfset result = this._testIsAcceptable(s_test)>
		<cfset assertFalse(result,"methods injected into cfcs as a result of cfthread calls are not acceptable")>		
	</cffunction>
	
	
	<cffunction name="publicFunctionsAreAcceptableTests">
		<cfset makePublic(this,"testIsAcceptable")>
		
		<cfset s_test = structnew()>
		<cfset s_test.name = "ILoveToTestCF">
		<cfset s_test.access = "public">		
		<cfset result = this._testIsAcceptable(s_test)>
		<cfset assertTrue(result,"Almost all public functions are testable. This one should be, too")>		
	</cffunction>
	
	
	
	<cffunction name="testMakePublicPassthrough" hint="test that the passthrough to PublicProxyMaker is correctly constructed; we're not worried about testing functionality here since that's already tested elsewhere">
		<cfset objWithPrivate = createObject("component","TestCaseTest")>			
		<cfset proxy = makePublic(objWithPrivate,"aPrivateMethod")>
		<!--- simply ensure it doesn't fail --->
		<cfset ret = proxy.aPrivateMethod()>
		<cfset assertEquals("foo",ret)>
	</cffunction>
<!--- End Specific Test Cases --->


	<cffunction name="setUp" access="public" returntype="void">
    <cfset debug("In TestCaseTest.setUp()") />
	  <!--- Place additional setUp and initialization code here --->
    <!--- <cfset debug(getMetadata(this))>   --->
	</cffunction>
	
	<cffunction name="tearDown" access="public" returntype="void">
	 <!--- Place tearDown/clean up code here --->	
	</cffunction>
	
	<cffunction name="aPrivateMethod" access="private">
		<cfreturn "foo">
	</cffunction>

</cfcomponent>
