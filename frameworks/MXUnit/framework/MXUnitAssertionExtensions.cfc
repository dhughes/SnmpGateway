<!--- 
 Extends the base Assertions ... assertEquals and AssertTrue ...

 --->
<cfcomponent displayname="MXUnitAssertionExtensions" extends="Assert" output="false" hint="Extends core mxunit assertions.">

  <cffunction name="assertIsXMLDoc" access="public" returntype="boolean">
     <cfargument name="xml" required="yes" type="any" />
	 <cfargument name="message" required="no" default="The test result is not a valid ColdFusion XML DOC object." type="string">
    
  
   <cfif not isXMLDoc(arguments.xml)>
       <cfinvoke method="fail">
        <cfinvokeargument name="message" value="#arguments.message#">
      </cfinvoke>
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


  <cffunction name="assertIsEmptyArray" access="public" returntype="boolean">
  	 <cfargument name="a" required="yes" type="any" />
 	   <cfargument name="message" required="no" default="The test result is an empty ARRAY." type="string">
    
     <cfif not arrayLen(arguments.a)>
     <cfinvoke method="fail">
        <cfinvokeargument name="message" value="#arguments.message#">
      </cfinvoke>
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


  <cffunction name="assertIsArray" access="public" returntype="boolean">
     <cfargument name="a" required="yes" type="any" />
     <cfif not isArray(arguments.a)>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The test result is not a valid ColdFusion ARRAY." />
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


  <cffunction name="assertIsEmptyQuery" access="public" returntype="boolean">
     <cfargument name="q" required="yes" type="any" />
     <cfif not arguments.q.recordCount gt 0>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The test result retuned zero records." detail="There should be at least one record returned" />
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


  <cffunction name="assertIsQuery" access="public" returntype="boolean">
     <cfargument name="q" required="yes" type="any" />
     <cfif not isQuery(arguments.q)>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The test result is not a valid ColdFusion QUERY." />
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


  <cffunction name="assertQueryRowCount" access="public" returntype="boolean">
     <cfargument name="expected" required="yes" type="numeric" />
     <cfargument name="actual"   required="yes" type="numeric" />
     <cfif not expected eq actual>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The ACTUAL and EXPECTED numbers are not equal."
                detail="EXPECTED=#expected# ... ACTUAL=#actual#" />
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


  <cffunction name="assertIsStruct" access="public" returntype="boolean">
     <cfargument name="struct" required="yes" type="any" />
     <cfif not isStruct(arguments.struct)>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The test result is not a valid ColdFusion STRUCTURE." />
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


   <cffunction name="assertIsEmptyStruct" access="public" returntype="boolean">
     <cfargument name="struct" required="yes" type="any" />
     <cfif StructIsEmpty(arguments.struct)>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The test result is an empty STRUCTURE." />
     <cfelse>
       <cfreturn true />
     </cfif>
   </cffunction>


   <cffunction name="assertIsEmpty" access="public" returntype="boolean">
     <cfargument name="o" required="yes" type="any" />
     <cfif arguments.o is "">
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The test result is EMPTY" />
     <cfelse>
       <cfreturn true />
     </cfif>
  </cffunction>

  <cffunction name="assertIsDefined" access="public" returntype="boolean">
     <cfargument name="o" required="yes" type="any" />
     <cfif not isDefined(evaluate("arguments.o"))>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The value is NOT DEFINED" />
     <cfelse>
       <cfreturn true />
     </cfif>
  </cffunction>


  <cffunction name="assertIsTypeOf" access="public" returntype="boolean">
     <cfargument name="o" required="yes" type="WEB-INF.cftags.component" />
     <cfargument name="type" required="yes" type="string" />

     <cfscript>
      var md = getMetaData(o);
    var oType = md.name;
     </cfscript>

     <cfif  oType is not arguments.type>
       <cfthrow type="mxunit.exception.AssertionFailedError" message="The object,#oType#  , is not of type #arguments.type#" />
     <cfelse>
       <cfreturn true />
    </cfif>
   </cffunction>


</cfcomponent>