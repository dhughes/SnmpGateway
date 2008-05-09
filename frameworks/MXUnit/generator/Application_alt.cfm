<cfapplication name="MXUnit Generator" 
				applicationtimeout="#createTimeSpan(0,2,0,0)#"
				clientmanagement=""
				clientstorage="cookie"
				loginstorage="session"
				sessionmanagement="true"
				sessiontimeout="#createTimeSpan(0,1,0,0)#"
				setclientcookies="true"
				setdomaincookies="false">
 

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