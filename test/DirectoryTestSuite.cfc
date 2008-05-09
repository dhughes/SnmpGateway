
<!---

Author:	Jeff Chastain (jeff.chastain@admentus.com)
Build: @buildNumber@

--->

<cfcomponent displayname="DirectoryTestSuite" output="false"
	hint="Extends the MXUnit DirectoryTestSuite, adding the ability to override the required test CFC prefix"
	extends="mxunit.runner.DirectoryTestSuite" >

	<!--- -------------------------------------------------- --->
	<!--- over-ridden methods --->

	<!---
		function:		run
		description: 	Overrides the run method in the base DirectoryTestSuite, adding a new argument 'componentPrefix'
	--->
	<cffunction name="run" access="public" output="false" returntype="any"
		hint="Overrides the run method in the base DirectoryTestSuite, adding a new argument 'componentPrefix'">

		<cfargument name="directory" type="string" required="true" hint="directory of tests to run" />
		<cfargument name="componentPath" type="string" required="false" default="" hint="the component path to put in front of all tests found (i.e. 'com.blah'). If no path is passed, we'll attempt to discover it ourselves" />
   		<cfargument name="recurse" type="boolean" required="false" default="true" hint="whether to recurse down the directory tree" />
		<cfargument name="excludes" type="string" required="false" default="" hint="list of Tests, in cfc notation, to exclude. uses ListContains so it's as greedy as possible. Currently does not support ant-style syntax or whole-directory filtering" />
   		<cfargument name="refreshCache" type="boolean" required="false" default="false" hint="flag to indicate whether or not to refresh the CF cache of CFCs. Maybe needed if any of the tests in the directory have not yet been compiled - to do: prove" />
   		<cfargument name="componentPrefix" type="string" required="false" default="test" hint="prefix (or suffix) that will indicate which CFCs within the component path to use as unit tests." />

    	<cfset var testResult = "" />
		<cfset var files = "" />
		<cfset var suite = createObject( "component", "mxunit.framework.TestSuite" ) />
		<cfset var i = 1 />

		<!--- clean up the director path --->
		<cfset arguments.directory = normalizeDirectory( arguments.directory ) />

		<!--- attempt to determine the component (dot) path to the directory if it is not specifed --->
		<cfif NOT len( arguments.componentPath ) >
			<cfset arguments.componentPath = getComponentPath( arguments.directory, arguments.refreshCache ) />
		</cfif>

		<!--- get the list of files from the directory --->
		<cfset files = getTests( arguments.directory, arguments.componentPath, arguments.recurse, trim( arguments.excludes ), arguments.componentPrefix ) />

		<!--- add each of the files to the test suite --->
		<cfloop from="1" to="#arrayLen(files)#" index="i">
			<cftry>
				<cfset suite.addAll( files[i] ) />
				<cfcatch type="any">
					<cfset s_results.errors[files[i]] = cfcatch />
				</cfcatch>
			</cftry>
		</cfloop>

		<!--- run the constructed test suite --->
		<cfset testResult = suite.run() />

		<cfreturn testResult />
	</cffunction> <!--- end: run() --->

	<!---
		function:		getTests
		description: 	Overrides the getTests method in the base DirectoryTestSuite, adding a new argument 'componentPrefix'
	--->
	<cffunction name="getTests" access="private" output="false" returntype="any"
		hint="Overrides the getTests method in the base DirectoryTestSuite, adding a new argument 'componentPrefix'">

		<cfargument name="directory" type="string" required="true" hint="directory of tests to run" />
		<cfargument name="componentPath" type="string" required="false" default="" hint="the component path to put in front of all tests found (i.e. 'com.blah'). If no path is passed, we'll attempt to discover it ourselves" />
   		<cfargument name="recurse" type="boolean" required="false" default="true" hint="whether to recurse down the directory tree" />
		<cfargument name="excludes" type="string" required="false" default="" hint="list of Tests, in cfc notation, to exclude. uses ListContains so it's as greedy as possible. Currently does not support ant-style syntax or whole-directory filtering" />
   		<cfargument name="componentPrefix" type="string" required="false" default="test" hint="prefix (or suffix) that will indicate which CFCs within the component path to use as unit tests." />

		<!--- get the list of tests in the specified directory as a recordset --->
		<cfset var qTests = getDirectoryQuery( arguments.directory, arguments.recurse ) />
		<cfset var aTests = arrayNew(1) />

		<!--- for every test file --->
		<cfloop query="qTests">

			<!--- get the dot path to the test file --->
			<cfset testPath = formatTestPath( arguments.directory, qTests.directory & sep & qTests.name, arguments.componentPath ) />

			<!--- attempt to create an instance of the test file, updating the server cache --->
			<cftry>
		        <!---
		          Compile first. This ensures that any new tests NOT found in the server cache get added.
		          This may actually be quicker than searching the array and then conditionally compiling.
		          Appears not to have much overhead, but, we should monitor anyway for large test runs.
		         --->
		        <cfset createObject("component","#testPath#") />

				<cfcatch type="any"><!--- no worries ---></cfcatch>
			</cftry>

			<!--- check if the test file is acceptable based upon argument parameters --->
			<cfif accept( testPath, excludes, componentPrefix )>
				<!--- add the test file to the array of tests --->
				<cfset arrayAppend( aTests, testPath ) />
			</cfif>

		</cfloop> <!--- end: qTests loop --->

		<!--- return the array of 'good' tests --->
		<cfreturn aTests />
	</cffunction> <!--- end: getTests() --->

	<!---
		function:		accept
		description: 	Overrides the accept method in the base DirectoryTestSuite, adding a new argument 'componentPrefix'
	--->
	<cffunction name="accept" access="private" output="false" returntype="any"
		hint="Overrides the accept method in the base DirectoryTestSuite, adding a new argument 'componentPrefix'">

		<cfargument name="test" type="string" required="true" hint="the name of the test CFC to evaluate" />
		<cfargument name="excludes" type="string" required="false" default="" hint="list of Tests, in cfc notation, to exclude. uses ListContains so it's as greedy as possible. Currently does not support ant-style syntax or whole-directory filtering" />
   		<cfargument name="componentPrefix" type="string" required="false" default="test" hint="prefix (or suffix) that will indicate which CFCs within the component path to use as unit tests." />

		<!--- grab the last item in the dot path string as the test file name --->
		<cfset var testName = listLast( arguments.test, "." ) />
		<cfset var thisExclude = "" />

		<!--- check if the componentPrefix argument was specified, and if so, use it to check the name of the test CFC --->
		<cfif len(arguments.componentPrefix) AND NOT reFindNoCase( "^#arguments.componentPrefix#", testName ) AND NOT reFindNoCase( "#arguments.componentPrefix#$", testName ) >
			<cfreturn false />
		</cfif>

		<!--- if the list of excluded test names is empty, exit now, returning true --->
		<cfif NOT len(excludes) >
			<cfreturn true />
		</cfif>

		<!--- convert the test file path to a dot path --->
		<cfset arguments.test = listChangeDelims( arguments.test, "/", "." ) />

		<!--- check if the test name is included in the exclusion list --->
		<cfloop list="#arguments.excludes#" index="thisExclude" delimiters=",">
			<cfset thisExclude = replace( thisExclude, "\", "/" ) />
			<cfif reFindNoCase( "\b#thisExclude#\b", test ) >
				<!--- test name matched an excluded file, return false --->
				<cfreturn false />
			</cfif>
		</cfloop> <!--- end: excluded file loop --->

		<!--- all tests have passed, return true --->
		<cfreturn true />
	</cffunction> <!--- end: accept() --->

</cfcomponent>