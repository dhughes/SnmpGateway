<cfcomponent output="false">
	<!--- 
	Making a simple non-effectual change for SVN practice - 06-09-07
	 --->
  <cfset this.name = "MXUnit Generator">
  <cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
  <cfset this.clientManagement = true>
  <cfset this.clientStorage = "cookie">
  <cfset this.loginStorage = "session">
  <cfset this.sessionManagement = true>
  <cfset this.sessionTimeout = createTimeSpan(0,1,0,0)>
  <cfset this.setClientCookies = true>
  <cfset this.setDomainCookies = false>
  <cfset this.scriptProtect = true>
  
  <cffunction name="onApplicationStart">
  </cffunction>
  
  <cffunction name="onApplicationEnd">
  </cffunction>
  
  <cffunction name="onRequestStart">
 <!---~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Change these values as needed. If you unzipped MXUnit directly
    into the webroot, then no changes are requires. However, if you
    unzipped MXUnit into somewhere else, you will need to change 
    these values.
    
    Example,
    Is you unzipped MXUnit into E:\inetpub\wwwroot\apps\
    the below values would be:
    
    <cfset request.mxunitRoot = "apps.mxunit" />
    <cfset request.mxunitTestCase = "apps.mxunit.framework.TestCase" />
    <cfset request.mxunitTestSuite = "apps.mxunit.framework.TestSuite" />
    
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--->
   <cfset request.mxunitRoot = "mxunit" />
   <cfset request.mxunitTestCase = "mxunit.framework.TestCase" />
   <cfset request.mxunitTestSuite = "mxunit.framework.TestSuite" />
  </cffunction>
  

  
  <cffunction name="onRequestEnd" returnType="void" output="false">
  </cffunction>
  
  <cffunction name="onError" returnType="void" output="true">
    <cfargument name="exception" required="true">
    <cfargument name="eventname" type="string" required="true">
    <cfthrow object="#exception#" />
  </cffunction>
  
  <cffunction name="onSessionStart">
   </cffunction>
  
  <cffunction name="onSessionEnd" returnType="void" output="false">
  </cffunction>
</cfcomponent>

