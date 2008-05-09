<!---

Build: @buildNumber@
Build Date: @buildDate@

--->
<cfcomponent displayname="Application" output="false"
	hint="Main Application Object" >

	<!--- -------------------------------------------------- --->
	<!--- pseudo constructor --->

	<cfset this.name = "SNMPManager" /> <!--- application name, should be unique --->
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0) /> <!--- how long application vars persist --->

	<cfset this.clientManagement = false /> <!--- should client vars be enabled? --->
	<cfset this.clientStorage = "registry" /> <!--- where should we store them, if enable? --->
	<cfset this.loginStorage = "session" /> <!--- where should cflogin stuff persist --->
	<cfset this.sessionManagement = true /> <!--- should we even use sessions? --->
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0) /> <!--- how long do session vars persist? --->
	<cfset this.setClientCookies = true /> <!--- should we set cookies on the browser? --->
	<cfset this.setDomainCookies = false /> <!--- should cookies be domain specific, ie, *.foo.com or www.foo.com --->

	<cfset this.scriptProtect = false /> <!--- should we try to block 'bad' input from users --->
	<cfset this.secureJSON = false /> <!--- should we secure our JSON calls? --->
	<cfset this.secureJSONPrefix = "" /> <!--- should we use a prefix in front of JSON strings? --->
	<cfset this.welcomeFileList = "" /> <!--- used to help CF work with missing files and dir indexes --->

	<!--- define custom coldfusion mappings. keys are mapping names, values are full paths  --->
	<cfset this.mappings = structNew() />

	<cfset this.mappings["/com"] = expandPath("../com/") />
	<cfset this.mappings["/test"] = expandPath("../test/") />

	<cfset this.mappings["/MXUnit"] = expandPath("../frameworks/MXUnit/") />

	<!--- define a list of custom tag paths. --->
	<cfset this.customtagpaths = "" />

	<!--- -------------------------------------------------- --->
	<!--- public methods --->

	<!---
		function:		onApplicationStart
		description: 	Runs when ColdFusion receives the first request for a page in the application.
	--->
	<cffunction name="onApplicationStart" access="public" output="false" returnType="boolean"
		hint="Runs when ColdFusion receives the first request for a page in the application.">

		<cfreturn true />
	</cffunction> <!--- end: onApplicationStart() --->

	<!---
		function:		onApplicationEnd
		description: 	Runs when an application times out or the server is shutting down.
	--->
	<cffunction name="onApplicationEnd" access="public" output="false" returnType="void"
		hint="Runs when an application times out or the server is shutting down." >

		<cfargument name="applicationScope" type="struct" required="true" hint="the application scope data structure" />

		<cfreturn />
	</cffunction> <!--- end: onApplicationEnd() --->

	<!---
		function:		onMissingTemplate
		description: 	Runs when a request specifies a non-existent CFML page.
	--->
	<cffunction name="onMissingTemplate" access="public" output="false" returnType="boolean"
		hint="Runs when a request specifies a non-existent CFML page." >

		<cfargument name="targetPage" type="string" required="true" hint="the path from the web root to the requested CFML page" />

		<cfreturn true />
	</cffunction> <!--- end: onMissingTemplate() --->

	<!---
		function:		onRequestStart
		description: 	Runs when a request starts.
	--->
	<cffunction name="onRequestStart" access="public" output="false" returnType="boolean"
		hint="Runs when a request starts." >

		<cfargument name="targetPage" type="string" required="true" hint="the path from the web root to the requested page." />

		<cfreturn true />
	</cffunction> <!--- end: onRequestStart() --->

	<!---
		function:		onRequest
		description: 	Runs when a request starts, after the onRequestStart event handler.
	--->
	<cffunction name="onRequest" access="public" output="true" returnType="void"
		hint="Runs when a request starts, after the onRequestStart event handler." >

		<cfargument name="targetPage" type="string" required="true" hint="the path from the web root to the requested page." />

		<cfinclude template="#arguments.targetPage#" />

		<cfreturn />
	</cffunction> <!--- end: onRequest() --->

	<!---
		function:		onRequestEnd
		description: 	Runs at the end of a request, after all other CFML code.
	--->
	<cffunction name="onRequestEnd" access="public" output="false" returnType="void"
		hint="Runs at the end of a request, after all other CFML code." >

		<cfargument name="targetPage" type="string" required="true" hint="the path from the web root to the requested page." />

		<cfreturn />
	</cffunction> <!--- end: onRequestEnd() --->

	<!---
		function:		onError
		description: 	Runs when an uncaught exception occurs in the application.
	--->
	<cffunction name="onError" access="public" output="false" returnType="void"
		hint="Runs when an uncaught exception occurs in the application." >

		<cfargument name="exception" type="any" required="true" hint="the ColdFusion Exception object" />
		<cfargument name="eventname" type="string" required="true" hint="the name of the event handler that generated the exception.">

		<cfdump var="#arguments#"><cfabort>

		<cfreturn />
	</cffunction> <!--- end: onError() --->

	<!---
		function:		onSessionStart
		description: 	Runs when a session starts.
	--->
	<cffunction name="onSessionStart" access="public" output="false" returnType="void"
		hint="Runs when a session starts.">

		<cfreturn />
	</cffunction> <!--- end: onSessionStart() --->

	<!---
		function:		onSessionEnd
		description: 	Runs when a session ends.
	--->
	<cffunction name="onSessionEnd" access="public" output="false" returnType="void"
		hint="Runs when a session ends." >

		<cfargument name="sessionScope" type="struct" required="true" hint="the session scope data structure" />
		<cfargument name="applicationScope" type="struct" required="false" hint="the application scope data structure" />

		<cfreturn />
	</cffunction> <!--- end: onSessionEnd() --->

</cfcomponent>