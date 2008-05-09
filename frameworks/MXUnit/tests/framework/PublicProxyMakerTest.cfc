<cfcomponent extends="mxunit.framework.TestCase">

	<cfset maker = "">
	<cfset objectWithPrivateMethod = "">

	<cffunction name="setup">
		<cfset maker = createObject("component","mxunit.framework.PublicProxyMaker")>
		<cfset objectWithPrivateMethod = createObject("component","PublicProxyMakerTest")>
	</cffunction>

	<cffunction name="testSanity">

		<cftry>
			<cfset str = objectWithPrivateMethod.aPrivateMethod()>
			<cfset fail("should not get to here; should've thrown an error trying to run a private method")>
		<cfcatch type="mxunit.exception.AssertionFailedError">
			<cfrethrow>
		</cfcatch>
		<cfcatch type="any"></cfcatch>
		</cftry>

	</cffunction>


	<!--- here's how to use  the object returned by the proxy maker to invoke
	the method with the exact method name under test; under the hood, this creates
	a new component that extends the object under test and adds a public version
	of the private method. it simply calls super.Whatever(args....)

	The primary disadvantage is that you lose anything you've done to the object in setUp()
	or any other initialization prior to running the function since you're now working with a new object

	see testMakePublicObjectWithInit for how to overcome this disadvantage

	--->
	<cffunction name="testMakePublicObject">
		<cfset proxy = maker.makePublic(objectWithPrivateMethod,"aPrivateMethod")>
		<cfset ret = proxy.aPrivateMethod("one","two","++")>
		<cfset assertEquals("one++two",ret)>
	</cffunction>

	<cffunction name="testMakePublicObjectNoArg">
		<cfset proxy = maker.makePublic(objectWithPrivateMethod,"aNoArgPrivateMethod")>
		<!--- if it doesn't fail, all is OK --->
		<cfset ret = proxy.aNoArgPrivateMethod()>
		<cfset assertEquals("boo",ret)>
	</cffunction>

	<cffunction name="testMakePublicObjectWithInit">
		<!--- so that you don't lose any of the initialization you'd do in setup, you can perform
		that initialization inside the object itself AFTER making the public proxy --->
		<cfset proxy = maker.makePublic(objectWithPrivateMethod,"aPrivateMethod")>
		<!---  just an example:
		<cfset proxy.init(blah,blah)>
		<cfset proxy.setSomethingOrOther(foo)>

		--->
		<cfset ret = proxy.aPrivateMethod("one","two","()")>
	</cffunction>

	<cffunction name="testMakePublicObjectVoid">
		<cfset proxy = maker.makePublic(objectWithPrivateMethod,"aPrivateVoid")>
		<cfset ret = proxy.aPrivateVoid()>
		<cfset assertEquals(5,proxy.x)>
	</cffunction>


	<!---
	here's how to use the proxy method created and injected into the existing object under test.

	the primary benefit of this version over the "proxy object" version is that you retain any
	object modification done prior to invoking the method.

	--->


	<cffunction name="testMakePublicNamedArgs">
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethod","_aPrivateMethod")>
		<cfset result = objectWithPrivateMethod._aPrivateMethod(arg1="one",arg2="two")>
		<cfset assertEquals("one_two",result)>

		<cfset result = objectWithPrivateMethod._aPrivateMethod(arg1="one",arg2="two",sep="~~")>
		<cfset assertEquals("one~~two",result)>
	</cffunction>

	<cffunction name="testMakePublicNonNamedArgs">
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethod","_aPrivateMethod")>
		<cfset result = objectWithPrivateMethod._aPrivateMethod("one","two","+")>
		<cfset assertEquals("one+two",result)>
		<cfset result = objectWithPrivateMethod._aPrivateMethod("one","two","_")>
		<cfset assertEquals("one_two",result)>

		<cfset result = objectWithPrivateMethod._aPrivateMethod("one","two")>
		<cfset assertEquals("one_two",result)>
	</cffunction>

	<cffunction name="testMakePublicNonExistentMethod">
		<cftry>
			<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethodThatDoesNotExist","_aPrivateMethod")>
			<cfset fail("should not get to here. should throw error in makePublic")>
		<cfcatch type="mxunit.exception.AssertionFailedError">
			<cfrethrow>
		</cfcatch>
		<cfcatch></cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="testMakePublicNoThirdArg">
		<!--- we're simply testing here that the name of the resultant public method to use exists and doesn't fail --->
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethod")>
		<cfset result = objectWithPrivateMethod._aPrivateMethod(arg1="one",arg2="two")>
		<cfset assertEquals("one_two",result)>
	</cffunction>

	<cffunction name="testMakePublicNoArgMethod">
		<cfset maker.makePublic(objectWithPrivateMethod,"aNoArgPrivateMethod","_aNoArgPrivateMethod")>
		<!--- simply test that it doesn't error --->
		<cfset ret = objectWithPrivateMethod._aNoArgPrivateMethod()>
		<cfset assertEquals("boo",ret)>
	</cffunction>

	<cffunction name="testMakePublicVoid">
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateVoid")>
		<cfset ret = objectWithPrivateMethod._aPrivateVoid()>
		<cfset assertEquals(5,objectWithPrivateMethod.x)>
	</cffunction>

	<cffunction name="testMakePublicNoReturnType">
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethodNoRT")>
		<cfset ret = objectWithPrivateMethod._aPrivateMethodNoRT>
		<cfset assertTrue(len(ret) GT 0)>
	</cffunction>

	<cffunction name="testMakePublicArray">
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethodReturnArray")>
		<cfset ret = objectWithPrivateMethod._aPrivateMethodReturnArray()>
		<cfset assertTrue(isArray(ret),"returned value should be an array")>
	</cffunction>

	<cffunction name="testMakePublicArray2">
		<cfset maker.makePublic(objectWithPrivateMethod,"aPrivateMethodReturnArray2")>
		<cfset ret = objectWithPrivateMethod._aPrivateMethodReturnArray2()>
		<cfset assertTrue(isArray(ret),"returned value should be an array")>
	</cffunction>

	<cffunction name="testMakePublicSuperClassMethod">
		<cfset maker.makePublic(objectWithPrivateMethod,"createResult")>
		<cfset result = objectWithPrivateMethod._createResult()>
		<cfset assertTrue(findNoCase("TestResult", getMetadata(result).NAME))>
	</cffunction>
	
	<cffunction name="testMakePublicSuperClassMethodWithSubclassWithNoFunctions">
		<!--- this subclass has no functions, but it extends a superclass that does have a private function --->
		<cfset var obj = createObject("component","mxunit.tests.framework.fixture.fixturetests.SubClassWithNoMethodsTest")>
		<cfset maker.makePublic(obj,"aPrivateMethod")>
		<cfset result = obj._aPrivateMethod()>
		<cfset assertTrue(result)>
	</cffunction>



	<!--- these are the private methods we're going to make public since we're using an instance of this component as the object under test --->

	<cffunction name="aPrivateMethod" access="private" returntype="string">
		<cfargument name="arg1" type="string" required="true">
		<cfargument name="arg2" type="string" required="true">
		<cfargument name="sep" type="string" required="false" default="_">
		<cfreturn arg1 & sep & arg2>
	</cffunction>

	<cffunction name="aNoArgPrivateMethod" access="private" returntype="string">
		<cfreturn "boo">
	</cffunction>

	<cffunction name="aPrivateMethodNoRT">
		<cfset var purpose = "no return type specified">
		<cfreturn purpose>
	</cffunction>

	<cffunction name="aPrivateMethodReturnArray">
		<cfreturn ArrayNew(1)>
	</cffunction>

	<cffunction name="aPrivateMethodReturnArray2" returntype="array">
		<cfreturn ArrayNew(1)>
	</cffunction>

	<!--- this will run as constructor code --->
	<cfset this.x = 1>
	<cffunction name="aPrivateVoid" access="private" returntype="void">
		<cfset this.x = 5>
	</cffunction>






</cfcomponent>