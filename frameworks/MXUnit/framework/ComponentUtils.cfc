<cfcomponent name="mxunit.framework.ComponentUtils" output="true" hint="Internal component not generally used outside the framework">
	<cfset sep = getSeparator()>

  <cffunction name="ComponentUtils" returnType="ComponentUtils" hint="Constructor">
   <cfreturn this />
  </cffunction>

	<cffunction name="isFrameworkTemplate" returntype="boolean" hint="whether the passed in template is part of the mxunit framework">
		<cfargument name="template" type="string" required="true">
		<cfset var isIt = false>
		<!--- braindead simple.... is anything more than this necessary? --->
		<cfif findNoCase("mxunit#sep#framework",template)>
			<cfset isIt = true>
		</cfif>
		<cfreturn isIt>
	</cffunction>

	<cffunction name="getSeparator" returntype="string" hint="Returns file.separator as seen by OS.">
		<cfreturn createObject("java","java.lang.System").getProperty("file.separator")>
	</cffunction>

	<cffunction name="getLineSeparator" returntype="string" hint="Returns file.separator as seen by OS.">
		<cfreturn createObject("java","java.lang.System").getProperty("line.separator")>
	</cffunction>

 <cffunction name="getInstallRoot" returnType="string" access="public">
 <cfargument name="fullPath" type="string" required="false" default="" hint="Used for testing, really." />
  <cfscript>
	    var i = 1;//loop index
	    var sep = "/";
	    var package = arrayNew(1); //list
	    var installRoot = "";
	    //We know THIS will always be in mxunt.framework.ComponentUtils
	    var md = getMetaData(this);
	    var name = md.name ;
	    if(len(arguments.fullPath)) {
	      name = arguments.fullPath;
	    }
	    package = listToArray(name,".");
	    //Use the getContextPath to support J2EE apps
	    installRoot = getPageContext().getRequest().getContextPath() & sep;
	     for(i; i lte arrayLen(package)-2; i = i + 1){
	      installRoot = installRoot & package[i] & sep;
	     }
	    return installRoot;
	  </cfscript>
</cffunction>



<cffunction name="getComponentRoot" returnType="string" access="public">
 <cfargument name="fullPath" type="string" required="false" default="" hint="Used for testing, really." />
 	 <cfscript>
	    var i = 1;//loop index
	    var sep = ".";
	    var package = arrayNew(1); //list
	    var installRoot = "";
	    //We know THIS will always be in mxunt.framework.ComponentUtils
	    var md = getMetaData(this);
	    var name = md.name ;

	    if(len(arguments.fullPath)) {
	      name = arguments.fullPath;
	    }
	    package = listToArray(name,".");
	    for(i; i lte arrayLen(package)-2; i = i + 1){
	      installRoot = installRoot & package[i] & sep;
	     }
	    return left(installRoot, len(installRoot)-1);
	  </cfscript>
</cffunction>


<cffunction name="hasJ2EEContext">
 <cfscript>
  return(getContextRootPath() is not "");
 </cfscript>
</cffunction>


<cffunction name="getContextRootComponent">
 <cfset var rootComponent = "" />
 <cfif hasJ2EEContext()>
   <!--- This last  "." worries me. Under what circumstance will this not be true? --->
   <cfset rootComponent = right(ctx,len(ctx)-1) &  "."/>
 </cfif>
 <cfreturn  rootComponent />
</cffunction>


<cffunction name="getContextRootPath">
 <cfset ctx = getPageContext().getRequest().getContextPath() />
 <cfreturn ctx />
</cffunction>


</cfcomponent>

