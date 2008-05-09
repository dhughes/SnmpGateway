<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" href="main.css" rel="stylesheet" />
<title>Generate tests</title>

<!--- Store file list --->
<cfset setProfileString(getProfilePath(),"blaster","file","#form.file#")>

<!--- Read from ini file --->
<cfscript>
	rootDir = getProfileString(getProfilePath(),"blaster","rootDirectory");
	rootSig = getProfileString(getProfilePath(),"blaster","rootSignature");
	template = getProfileString(getProfilePath(),"blaster","template");
	testDir = getProfileString(getProfilePath(),"blaster","testDirectory");
	testSig = getProfileString(getProfilePath(),"blaster","testSignature");
	
	componentArray = arraynew(1);
</cfscript>
</head>
<body>
	<cfoutput>
		<h1>MXUnit Blaster</h1>
		<h2>Generating Tests</h2>
		<table>
			<tbody>
				<tr>
					<td>
						<cfloop list="#form.file#" index="currentComponent">
							<cfscript>
								// build the component signature
								class = replaceNoCase(currentComponent,rootDir,rootSig);
								class = removeChars(class,len(class)-3,4);
								class = replaceNoCase(class,getFileSeparator(),".","all");
								
								// invoke it so we can read metadata
								obj = createObject("component",class); // note that we don't invoke any methods
								md = getMetaData(obj);
								
							</cfscript>	
				
<cfxml variable="comp">
<root>
	<component path="#listDeleteAt(md.name,listLen(md.name,"."),".")#" name="#listLast(md.name,".")#" fullname="#md.name#">
	<cfloop index="method" from="1" to="#arrayLen(md.functions)#">
		<method name="#md.functions[method].name#" 
			<cfif structKeyExists(md.functions[method],"access")>
				access="#md.functions[method].access#"
			</cfif>
			<cfif structKeyExists(md.functions[method],"output")>
				output="#md.functions[method].output#"
			</cfif>
			<cfif structKeyExists(md.functions[method],"returntype")>
				returntype="#md.functions[method].returntype#"
			</cfif>
		>
			<name>#md.functions[method].name#</name>
		<cfloop index="argument" from="1" to="#arrayLen(md.functions[method].parameters)#">
			<parameter name="#md.functions[method].parameters[argument].name#" 
		 	<cfif structKeyExists(md.functions[method].parameters[argument],"required")>
				required="#md.functions[method].parameters[argument].required#"
			</cfif>
			<cfif structKeyExists(md.functions[method].parameters[argument],"type")>
				type="#md.functions[method].parameters[argument].type#"
			</cfif>
			<cfif structKeyExists(md.functions[method].parameters[argument],"default")>
				default="#md.functions[method].parameters[argument].default#"
			</cfif>
			/></cfloop>
		</method>
	</cfloop>
	</component>
</root>
</cfxml>
							<!--- store the xml for troubleshooting purposes --->
							<cffile action="write" file="#getDirectoryFromPath(getCurrentTemplatePath()) & getFileSeparator() & 'temp.xml'#" output="#comp#">	
							<!--- read the template file --->
							<cffile action="read" file="#getDirectoryFromPath(getCurrentTemplatePath()) & getFileSeparator() & 'templates' & getFileSeparator() & template#" variable="xmlTransform">
							<cfset newFile = xmlTransform(comp,xmlTransform) />
				
							<!--- Build test path --->
							<cfset name = listLast(md.name,".") & "Test.cfc">
							<cfif len(testDir)>
								<cfset testFile = replaceNoCase(md.path,rootDir,testDir)>
								<cfset testPath = listDeleteAt(testFile,listLen(testFile,getFileSeparator()),getFileSeparator()) & getFileSeparator()>
								<!--- Create directory if needed --->
								<cfif NOT directoryExists(testPath)>
									<cfdirectory action="create" directory="#testPath#">
								</cfif>			
							<cfelse>					
								<cfset testPath = listDeleteAt(md.path,listLen(md.path,getFileSeparator()),getFileSeparator()) & getFileSeparator()/>
							</cfif>
							
							<!--- Write the test file --->
							<cffile action="write" file="#testPath & name#" output="#newFile#" >
							<p>#testPath##name# generated.</p>
						</cfloop>
					</td>
				</tr>
			</tbody>
		</table>
	</cfoutput>
		
		<!--- Create test suite --->
<cfif len(testDir)>
	<cfset testSuite = '<cfparam name="URL.output" default="html">

<cfscript>
	DTS = createObject("component","mxunit.runner.DirectoryTestSuite");
	excludes = "";
	results = DTS.run(
				directory="#testDir##getFileSeparator()#",
				componentPath="#trim(testSig)#",
				recurse="true",
				excludes="##excludes##"
			);
</cfscript>
 
<cfoutput>##results.getResultsOutput(URL.output)##</cfoutput>  			
	'>
	<cfoutput>
		<cffile action="write" file="#testDir & getFileSeparator() & 'myTestSuite.cfm'#" output="#testSuite#">
	</cfoutput>
</cfif>
</body>
</html>