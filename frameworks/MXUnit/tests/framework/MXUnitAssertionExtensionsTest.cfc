<cfcomponent generatedOn="12-04-2007 9:29:57 PM EST" extends="mxunit.framework.TestCase">
 
<cffunction name="testAssertQueryRowCount">
  
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertQueryRowCount" returnVariable="actual">
    <cfinvokeargument name="expected" value="1" />
    <cfinvokeargument name="actual" value="1" />
  </cfinvoke>
    
	<cftry>
	  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertQueryRowCount" returnVariable="actual">
	    <cfinvokeargument name="expected" value="3" />
	    <cfinvokeargument name="actual" value="1" />
	  </cfinvoke>
	  <cfcatch type="mxunit.exception.AssertionFailedError" />
	  <!--- no worries. we want this to fail --->
	</cftry>
 
</cffunction>


<cffunction name="testAssertIsEmptyStruct">
  <cfscript>
   var s = structNew();
   s.foo = "bar";
  </cfscript>
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmptyStruct" returnVariable="actual">
    <cfinvokeargument name="struct" value="#s#" />
  </cfinvoke>
  
   <cftry>
     <cfset structClear(s) />
     <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmptyStruct" returnVariable="actual">
     <cfinvokeargument name="struct" value="#s#" />
     </cfinvoke>
   <cfcatch type="mxunit.exception.AssertionFailedError" />
   <!--- no worries. we want this to fail --->
   </cftry>

  
</cffunction>


<cffunction name="testAssertIsStruct">
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsStruct" returnVariable="actual">
    <cfinvokeargument name="struct" value="#structNew()#" />
  </cfinvoke>
  <cftry>
    <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsStruct" returnVariable="actual">
    <cfinvokeargument name="struct" value="a string and not a struct" />
     </cfinvoke>
  <cfcatch type="mxunit.exception.AssertionFailedError" />
  <!--- no worries. we want this to fail --->
  </cftry>

</cffunction>


<cffunction name="testAssertIsEmpty">
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmpty" returnVariable="actual">
    <cfinvokeargument name="o" value="asd" />
  </cfinvoke>
  <cftry>
   <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmpty" returnVariable="actual">
    <cfinvokeargument name="o" value="" />
  </cfinvoke>
    <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
  </cftry>

</cffunction>


<cffunction name="testAssertIsDefined">
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsDefined" returnVariable="actual">
    <cfinvokeargument name="o" value="url" />
  </cfinvoke>
  
 <cftry>
 <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsDefined" returnVariable="actual">
    <cfinvokeargument name="o" value="zxcasdqweoiuqweoiquweqiowueqwieuqwjekjbq" />
  </cfinvoke>
  <cfcatch type="mxunit.exception.AssertionFailedError" />
  <!--- no worries. we want this to fail --->
  </cftry>

</cffunction>


<cffunction name="testAssertIsArray">
  <cfset var a = arrayNew(1) />
  <cfset a[1] = 1 />
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsArray" returnVariable="actual">
    <cfinvokeargument name="a" value="#a#" />
  </cfinvoke>
  <cftry>
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsArray" returnVariable="actual">
    <cfinvokeargument name="a" value="a string not an array" />
   </cfinvoke>
    <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
    </cftry> 
</cffunction>


<cffunction name="testAssertIsEmptyArray">
  <cfset var a = arrayNew(1) />
  <cfset var a2 = arrayNew(1) />
  <cfset a[1] = "" />
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmptyArray" returnVariable="actual">
    <cfinvokeargument name="a" value="#a#" />
    <cfinvokeargument name="message" value="Test array not empty" />
  </cfinvoke>
  
  <cftry>
    <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmptyArray" returnVariable="actual">
    <cfinvokeargument name="a" value="#a2#" />
    <cfinvokeargument name="message" value="Test array not empty" />
  </cfinvoke>
  <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
  </cftry>

  
  
</cffunction>


<cffunction name="testAssertIsTypeOf">
  Tests if THIS is the correct type (mxunit.tests.framework.MXUnitAssertionExtensionsTest)
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsTypeOf" returnVariable="actual">
    <cfinvokeargument name="o" value="#this#" />
    <cfinvokeargument name="type" value="mxunit.tests.framework.MXUnitAssertionExtensionsTest" />
  </cfinvoke>
  
  <cftry>
   <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsTypeOf" returnVariable="actual">
    <cfinvokeargument name="o" value="#this#" />
    <cfinvokeargument name="type" value="some.bogus.ass.component.name.that.should.fail.no.matter.what" />
    </cfinvoke>
  <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
  </cftry>

</cffunction>


<cffunction name="testAssertIsQuery">
  <cfscript>
   var q = queryNew("foo");
       queryAddRow(q,1);
       querySetCell(q, "foo","bar");
  </cfscript>
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsQuery" returnVariable="actual">
    <cfinvokeargument name="q" value="#q#" />
  </cfinvoke>
  
 <cftry>
 <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsQuery" returnVariable="actual">
    <cfinvokeargument name="q" value="foo" />
  </cfinvoke>
  <cfcatch type="mxunit.exception.AssertionFailedError" />
  <!--- no worries. we want this to fail --->
  </cftry> 
</cffunction>


<cffunction name="testAssertIsEmptyQuery">
    <cfscript>
     var q2 = queryNew("foo");
     var q = queryNew("foo");
       queryAddRow(q,1);
       querySetCell(q, "foo","bar");
  </cfscript>
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmptyQuery" returnVariable="actual">
    <cfinvokeargument name="q" value="#q#" />
  </cfinvoke>

  <cftry>   
    <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsEmptyQuery" returnVariable="actual">
     <cfinvokeargument name="q" value="#q2#" />
    </cfinvoke>
  <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
 </cftry> 
</cffunction>


<cffunction name="testAssertIsXMLDoc">
  <cfscript>
   var xml1 = xmlNew();
  </cfscript>
  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsXMLDoc" returnVariable="actual">
    <cfinvokeargument name="xml" value="#xml1#" />
    <cfinvokeargument name="message" value="This is not an XML Dom Object" />
  </cfinvoke>
  
 <cftry>
 	  <cfinvoke component="#this.MXUnitAssertionExtensions#"  method="assertIsXMLDoc" returnVariable="actual">
	    <cfinvokeargument name="xml" value="a string is not XML and should fail" />
	    <cfinvokeargument name="message" value="This is not an XML Dom Object" />
	  </cfinvoke>
   <cfcatch type="mxunit.exception.AssertionFailedError" />
    <!--- no worries. we want this to fail --->
  </cftry>


</cffunction>


<!--- Override these methods as needed. Note that the call to setUp() is Required if using a this-scoped instance--->

<cffunction name="setUp">
<!--- Assumption: Instantiate an instance of the component we want to test --->
<cfset this.MXUnitAssertionExtensions = createObject("component","mxunit.framework.MXUnitAssertionExtensions") />
<!--- Add additional set up code here--->
</cffunction>
 

<cffunction name="tearDown">
</cffunction>


</cfcomponent>
