<!---
 MXUnit TestCase Template
 @author
 @description
 @history
 --->

<cfcomponent  extends="mxunit.framework.TestCase">

<!--- Begin Specific Test Cases --->

<cffunction name="testGetStringValue">
   <cfscript>
     var trace = "";
     var foo = structNew();
     var foo2 = structNew();
     var a = arrayNew(1);
     a[1] = myComponent3;
     a[2] = myComponent4;
     foo2.bar = a;
     foo.bar =  myComponent3;
     foo.bar2 = myComponent4;
     foo.bar3 = foo2;
     writeoutput(getStringValue(foo)) ;
     exp = "test stringValue output from ComparatorTestData.cfc";
     assertEquals(exp, getStringValue(myComponent3), "getStringValue(myComponent3) problem");
    </cfscript>
</cffunction>

  <cffunction name="testFailNotEquals">
   <cftry>
   <cfscript>
     failNotEquals(mycomponent1,mycomponent2,"fail this"); 
    </cfscript>  
   <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
  </cftry>

  </cffunction>

 <cffunction name="testAssertEquals" access="public" returntype="void">
    <cfscript>
     assertEquals(myComponent4, myComponent3,"stringValue() implemented"); //
    </cfscript>
  </cffunction>

  <cffunction name="testAssertTrue" access="public" returntype="void">
   <cfscript>
    assertTrue(true,"This test should pass.");
   </cfscript>
 </cffunction>

	<cffunction name="testAssertFalse" access="public" returntype="void">
		<cfset assertFalse(false,"this test should pass")>
	</cffunction>
	
	<cffunction name="testAssertFalseFailure">
		<cftry>
			<cfset assertFalse(true,"this should fail")>
			<cfthrow message="should not get here">
			<cfcatch type="mxunit.exception.AssertionFailedError">
			
			</cfcatch>
		</cftry>
	</cffunction>

  <cffunction name="testAssertFailures" access="public" returntype="void">
    <cftry>
    <cfscript>
     assertEquals(myComponent1,myComponent2,"This should fail because toString() or stringValue() not implemented.");
     assertEquals(1,2,"This should fail");
    </cfscript>
     <cfcatch type="mxunit.exception.AssertionFailedError" />
     </cftry>
  </cffunction>

	<cffunction name="testFailure" access="public" returntype="void">
	  This tests an intentional failure. It should catch the exception
	  correctly and return true.
	     <cftry>
	       <cfset fail("Did not catch AssertionFailedError") />
	       <cfcatch type="mxunit.exception.AssertionFailedError" />
	     </cftry>
	</cffunction>

	<cffunction name="testAssertEqualsNumbers">
		<!--- these should all fail if they are not equals --->
		<cfset assertEquals(1,1)>
		<cfset assertEquals(1.0,1)>
		<cfset assertEquals(1000000000000.0,1000000000000)>
		<cfset assertEquals(-5,-5.0)>
		<cfset assertEquals(-100.222,-100.222)>
		<cfset assertEquals("1",1)>
		<cfset assertEquals(2,"2")>
		<cfset assertEquals("2.222",2.222)>

	</cffunction>

	<cffunction name="testAssertEqualsNumbersFailures">
		<cftry>
			<cfset assertEquals(1,2)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
		<cftry>
			<cfset assertEquals(121.000001,121.000)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
		<cftry>
			<cfset assertEquals(1,"1.1")>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
		<cftry>
			<cfset assertEquals(-1,0)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
		<cftry>
			<cfset assertEquals(-1,-.9999999999999)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="testAssertEqualsStrings" access="public" returntype="void">
		<cfset assertEquals("one","one" , "Should pass!")>
		<cfset assertEquals("#repeatString('aaaaaa ',50)#","#repeatString('aaaaaa ',50)#")>
		<cfset assertEquals("One","ONE","case sensitivity shouldn't matter when comparing strings")>
	 </cffunction>


	<cffunction name="testAssertEqualsStringsFailures">
		<cftry>
			<cfset assertEquals("ONE","ONE ")>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>

		<cftry>
			<cfset assertEquals("ONE"," ONE")>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="testAssertEqualsStructs">
		<cfset s1 = StructNew()>
		<cfset s2 = StructNew()>
		<cfset assertEquals(s1,s2)>

		<cfset s1.one = "one">
		<cfset s2.one = "one">
		<cfset assertEquals(s1,s2)>

		<cfset s1.two = ArrayNew(1)>
		<cfset s2.two = ArrayNew(1)>
		<cfset assertEquals(s1,s2)>

		<cfset s1.two[1] = "one">
		<cfset s2.two[1] = "one">
		<cfset assertEquals(s1,s2)>
	</cffunction>

	<cffunction name="testAssertEqualsStructsDeepComparison">
		<cfset s1 = StructNew()>
		<cfset s2 = StructNew()>
		<cfloop from="1" to="100" index="i">
			<cfset s1["a"&i] = "b_#i#">
			<cfset s2["a"&i] = "b_#i#">
		</cfloop>
		<cfset assertEquals(s1,s2)>

		<cfset rand = getTickCount()>
		<cfloop collection="#s1#" item="key">
			<cfset s1[key] = StructNew()>
			<cfset s1[key][key] = rand>
			<cfset s2[key] = StructNew()>
			<cfset s2[key][key] = rand>
		</cfloop>
		<cfset assertEquals(s1,s2)>
		<cfset s2[key][key] = rand & "boo">
		<cftry>
			<cfset assertEquals(s1,s2)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>

	</cffunction>

	<cffunction name="testAssertEqualsStructsFailures">
		<cfset s1 = StructNew()>
		<cfset s2 = StructNew()>

		<cfset s1.one = "one">
		<cfset s2.one = "two">

		<cftry>
			<cfset assertEquals(s1,s2)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>

		<cfset s1.two = ArrayNew(1)>
		<cfset s2.two = ArrayNew(1)>
		<cftry>
			<cfset assertEquals(s1,s2)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>

		<cfset s1.two[1] = "one">
		<cfset s2.two[1] = "two">

		<cftry>
			<cfset assertEquals(s1,s2)>
			<cfthrow type="other" message="should throw an AssertionFailedError before this one">
			<cfcatch type="mxunit.exception.AssertionFailedError"></cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="testNormalizeArgumentsDefaultEquals">
		<cfset asserttype = "equals">
		<cfset args = structnew()>
		<cfset args.expected = "1">
		<cfset args.actual = "2">
		<cfset args.message = "message">
		<cfset newargs = normalizeArguments(asserttype,args)>
		<cfset debug("Teststyle is " & getTestStyle())>
		<cfset debug(newargs)>

		<cfset assertTrue(args.expected eq newargs.expected)>
		<cfset assertTrue(args.actual eq newargs.actual)>
		<cfset assertTrue(args.message eq newargs.message)>


	</cffunction>

	<cffunction name="testNormalizeArgumentsDefaultTrue">
		<cfset asserttype = "true">
		<cfset args = structnew()>
		<cfset args.condition = false>
		<cfset args.message = "message">
		<cfset newargs = normalizeArguments(asserttype,args)>
		<cfset debug("Teststyle is " & getTestStyle())>
		<cfset debug(newargs)>

		<cfset assertTrue(args.condition eq newargs.condition)>
		<cfset assertTrue(args.message eq newargs.message)>
	</cffunction>

	<cffunction name="testNormalizeArgumentsDefaultXMLDoc">
		<cfset asserttype = "isxmldoc">
		<cfset args = structnew()>
		<cfset args.xml = "<myxml>blah</myxml>">
		<cfset args.message = "message">
		<cfset newargs = normalizeArguments(asserttype,args)>
		<cfset debug("Teststyle is " & getTestStyle())>
		<cfset debug(newargs)>

		<cfset assertTrue(args.xml eq newargs.xml)>
		<cfset assertTrue(args.message eq newargs.message)>
	</cffunction>

	<cffunction name="testNormalizeArgumentsDefaultEmptyArray">
		<cfset asserttype = "isemptyarray">
		<cfset args = structnew()>
		<cfset args.a = ArrayNew(1)>
		<cfset args.message = "message">
		<cfset newargs = normalizeArguments(asserttype,args)>
		<cfset debug("Teststyle is " & getTestStyle())>
		<cfset debug(newargs)>

		<cfset assertTrue(ArrayLen(args.a) eq ArrayLen(newargs.a))>
		<cfset assertTrue(args.message eq newargs.message)>
	</cffunction>

	<cffunction name="testNormalizeArgumentsCFUnitTrue">
		<cfset setTestStyle("cfunit")>

		<cfset asserttype = "true">
		<cfset args = structnew()>
		<cfset args.condition = "message">
		<cfset args.message = false>
		<cfset newargs = normalizeArguments(asserttype,args)>

		<cfset debug("Teststyle is " & getTestStyle())>
		<cfset debug(newargs)>

		<cfset assertTrue(args.condition eq newargs.message)>
		<cfset assertTrue(args.message eq newargs.condition)>
	</cffunction>

	<cffunction name="testNormalizeArgumentsCFUnitEquals">
		<cfset setTestStyle("cfunit")>
		<cfset asserttype = "equals">
		<cfset args = structnew()>

		<cfset args.expected = "1">
		<cfset args.actual = "2">
		<cfset args.message = "message">
		<cfset newargs = normalizeArguments(asserttype,args)>
		<cfset debug("Teststyle is " & getTestStyle())>
		<cfset debug(newargs)>

		<cfset assertTrue(args.expected neq newargs.expected)>
		<cfset assertTrue(args.actual neq newargs.actual)>
		<cfset assertTrue(args.message neq newargs.message)>

		<!--- here's the tale of the tape, in a way: if this doesn't work, it'll throw an error  --->
		<cfset expected=2>
		<cfset actual=2>
		<cfset assertEquals("message",expected,actual)>


	</cffunction>




  <!---End Specific Test Cases --->




  <cffunction name="setUp" access="public" returntype="void">
	<cfset this.setTestStyle('default')>
    <!--- Place additional setUp and initialization code here --->
       <cfscript>
       myComponent1 = createObject("component","mxunit.tests.framework.fixture.NewCFComponent");
       myComponent2 = createObject("component","mxunit.tests.framework.fixture.NewCFComponent");
      //below implement consistent stringValue()
       myComponent3 = createObject("component","mxunit.tests.framework.fixture.ComparatorTestData");
       myComponent4 = createObject("component","mxunit.tests.framework.fixture.ComparatorTestData");
    </cfscript>
  </cffunction>

  <cffunction name="tearDown" access="public" returntype="void">
   <!--- Place tearDown/clean up code here --->
  </cffunction>



</cfcomponent>
