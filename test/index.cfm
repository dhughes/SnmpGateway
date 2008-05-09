<cfparam name="URL.output" default="extjs" />
<cfparam name="URL.quiet" default="false" />

<cfset dir = expandPath("/test/com/") />
<cfoutput><h1>#dir#</h1></cfoutput>

<cfset DTS = createObject( "component", "test.DirectoryTestSuite" ) />
<cfset excludes = "InvalidMarkupTest,FiveSecondTest" />

<cfinvoke component="#DTS#"
	method="run"
	directory="#dir#"
	componentPath="test.com"
	recurse="true"
	excludes="#excludes#"
	componentPrefix=""
	returnvariable="Results" />

<cfif NOT URL.quiet>
	<cfif NOT StructIsEmpty(DTS.getCatastrophicErrors()) >
		<cfdump var="#DTS.getCatastrophicErrors()#" expand="false" label="#StructCount(DTS.getCatastrophicErrors())# Catastrophic Errors" />
	</cfif>

	<cfsetting showdebugoutput="true">
	<cfoutput>#results.getResultsOutput(URL.output)#</cfoutput>
</cfif>