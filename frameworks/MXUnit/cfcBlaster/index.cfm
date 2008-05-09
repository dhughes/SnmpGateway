<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" href="main.css" rel="stylesheet" />
<title>MXUnit Test Generator</title>

<cfoutput>
	<cfscript>
		//read ini file 
		dir = getProfileString(getProfilePath(),"blaster","rootDirectory");
		sig = getProfileString(getProfilePath(),"blaster","rootSignature");
		testdir = getProfileString(getProfilePath(),"blaster","testDirectory");
		testsig = getProfileString(getProfilePath(),"blaster","testSignature");
		recurse = getProfileString(getProfilePath(),"blaster","recurse");
		lastTemplate = getProfileString(getProfilePath(),"blaster","template");
		cfversion = val(listFirst(server.ColdFusion.ProductVersion));
	</cfscript>
	
	<cfset templateDirectory = getDirectoryFromPath(getCurrentTemplatePath()) & getFileSeparator() & 'templates' />

	<cfdirectory action="list" directory="#templateDirectory#" filter="*.xslt" name="templates">
	
	
	<script type="text/javascript">
		function toggle(frm)
		{
			for (ii=0;ii < frm.tableNameList.length;ii++)
			{
				frm.tableNameList[ii].checked = frm.all.checked;
			}
		}
	</script>
</cfoutput>	
</head>
<cfoutput>
<body>
	<H1>MXUnit Blaster</H1>
	<h2>Setup</h2>

	<form name="setup" method="post" action="listFiles.cfm">
		<table>
			<thead>
				<tr>
					<th colspan="2">The following information is needed to generate your components.<br/>  You may also edit the setup.ini file in the cfcblaster root directly to change the values.</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Component Directory</td>
					<td><input type="text" name="rootdirectory" value="#dir#" style="width:400px;"></td>
				</tr>
				<tr>
					<td>Component Root Signature</td>
					<td><input type="text" name="rootsignature" value="#sig#" style="width:400px;"></td>
				</tr>
				<tr>
					<td>Test Directory</td>
					<td><input type="text" name="testdirectory" value="#testdir#" style="width:400px;"><br/>
					Leave blank to have tests cuddle their associated component.
					
					</td>
				</tr>
				<tr>
					<td>Test Signature</td>
					<td><input type="text" name="testsignature" value="#testsig#" style="width:400px;"><br/>
					Leave blank to have the suite runner calculate it each time.<br/>
					Otherwise fill in the signature of your test path. If you put your test<br/> 
					directory in your component folder this will be the same as the<br/>
					Component Root Signature with your test directory appended.
					</td>
				</tr>
				<tr>
					<td>Recursive</td>
					<td><input type="checkbox" name="recurse" checked="#recurse#" #disabled(cfversion lt 7)# value="true">
						<cfif cfversion lt 7>
							You can only recurse directories with ColdFusion 7 or later.
						</cfif>
					</td>
				</tr>
				<tr>
					<td>Template</td>
					<td>
						<select name="template">
							<cfloop query="templates">
								<option value="#templates.name#" #selected(lastTemplate,templates.name)#>#templates.name#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="submit" name="submitFrm" class="button"/>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>	
<!--- Notes --->
	<h2>Notes</h2>
	<ul>
		<li>There is no error trapping in this utility.  Hiding errors from developers just seems silly to me.</li>
		<li>Cuddling tests next to their associated components can make it a little more difficult to rip them all out and start again.</li>
		<li>This is a derivative of the <a href="http://cfcblaster.googlecode.com">cfcBlaster project</a>, but it has been substantially modified to build tests from existing components instead of creating components from database tables.</li>
		<li>Add as many different test templates as yo like to the "template" directory under the "cfcBlaster" directory.  They will appear in the drop down on this page and be used to transform your components into test files.</li>
		<li>The datasource for the transform is the object returned by the getMetadata function.  Each component that is having a test built will have to be able to be instantiated on it's own.  If you need additional data, get hacking.</li>
		<li>Hack as needed and use at your own risk.</li>
		<li>Adding a component root signature will make your tests run significantly faster.  If you see no tests when you run the test suite file, check this entry first.</li>
	</ul>	
</body>
</html>
</cfoutput>