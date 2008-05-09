<cfsetting showdebugoutput="false" >
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MXUnit TestCase Stub  Generator - Version: Alpha-1 </title>
<style>
			body  {
				font-family: verdana, arial, helvetica, sans-serif;
				background-color: #FFFFFF;
				font-size: 12px;
				margin-top: 10px;
				margin-left: 10px;
			}
			
			table	{
				font-size: 11px;
				font-family: Verdana, arial, helvetica, sans-serif;
				width: 90%;
			}
			
			th {
				padding: 6px;
				font-size: 12px;
				background-color: #cccccc;
			}
			
			td {
				padding: 6px;
				background-color: #eeeeee;
				vertical-align : top;
			}
			
			code {
				color: #000099 ;
			}
			</style>
</head>
<body style="font-family: arial, helvetica, sans-serif;">
	<h3 align="center">MXUnit TestCase Stub Generator (Version Alpha-1)</h3>
	<p>
	Generates test stubs and a test suite for MXUnit or other unit test frameworks for ColdFusion. For every public or remote method found in the components in the specified package,
  the MXUnit Generator will create an accompanying test case stub. This will save you a lot of typing. You <strong><em>will</em></strong> need to, however, go
  into the generated test cases and assign appropriate values for the function parameters as well as specify the correct assertion.
  <p><strong>Stay tuned for the MXUnit TestRunner and TestGenerator!</strong></p>
  </p>
	<p>
	<strong>Instructions</strong>:<br />
	<ol>
   <li>Edit the Application.cfc::onRequestStart() to name the installation path of MXUnit. The default is in the web root.</li>
	 <li>Type in the fully qualified component name of the TestCase to inherit. This is the location of the unit test framework's TestCase you are using; e.g. mxunit.framework.TestCase</li>
	 <li>Type in the fully qualified name of the TestSuite component. This is the location of the unit test framework's TestSuite you are using; e.g. mxunit.framework.TestSuite</li>
	 <li>Select the component package from which to generate the tests. Note that the 
		 MXUnit Generator will automatically generate a TestCase for each component found
		 in the package you select.	
	</li>
	 <li> Type in the sub-directory to where you want the TestCases written. By default,
		 The MXUnit Generator will create a <code>tests</code> sub-directory in the 
		 directory which contains the package you selected in step 2.
	</li>
  <li>Choose whether or not you want to append a date driven string to the directory name; e.g., <code>/tests_mmddyyy_hhmmsss</code>. 
  The default is no.</li>
	</ol>
  
<p align="center">
		 <strong style="color:darkred">WARNING</strong>: <u>THE MXUNIT GENERATOR WILL
		 OVERWRITE ANY AND ALL EXISTING DIRECTORIES AND FILES WITHOUT WARNING!</u> 
</p>	</p>
<div style="padding-left:24px">	
  <cfoutput>
<form action="Generator.cfm" method="post">
<strong>2.) xUnit TestCase Name</strong> <input type="text" name="uXunitTestCase" size="34" value="#request.mxunitTestCase#" />
<br /><br />
<strong>3.) xUnit TestSuite Name</strong> <input type="text" name="uXunitTestSuite" size="34" value="#request.mxunitTestSuite#" />

<p>
  <cfset gen = createObject("component", "#request.mxunitRoot#.generator.Generator").Generator() />
  <cfset packages = gen.getPackages() />
  <cfset sortedPackages = structNew() />
  <!--- 
    Should be an easier way to do this. The problem is that
    if the key is null an error is thrown, and if a component
    exists in a root (wwwroot,customtags, mapping), the key
    will be null and should be omitted.  
   --->
  <cfscript>
   for(item in packages){
   	 if(item is not ""){
   	  structinsert(sortedPackages,item,item);
   	 }
   }
  </cfscript>
  
  <cfset sorted = structSort(sortedPackages,"textnocase","asc") />

  <cfset packageXml = gen.getPackagesAsXml() />

<strong>4.) &nbsp;</strong><select name="packages" onchange="loadComponents">
 <option value="-0">---- Select A Package ----</option> 
 <cfscript>
   for(i = 1; i lte arraylen(sorted); i = i + 1){
      writeoutput("<option>" & sorted[i] & "</option>");
   }
  </cfscript>

</select>
<script>
function loadComponents(){
 sel = getElementById("packages");
 
}
</script>
</p>

<strong>5.) Sub-directory name:</strong> &nbsp;
<input type="text" name="subDir" value="tests" /><br /> <br /> 


<strong>6.) Append date-derived string to directory name </strong>&nbsp;&nbsp; &nbsp;  Yes
<input type="radio" name="dateAppend" value="true" />
No
<input type="radio" name="dateAppend" value="false" checked="true" />
<p>
<input type="submit" value="Generate Test Stubs"/><input type="reset" value="Reset" onclick="location.href='Generator.cfm'" />
</p>

</form>
</cfoutput>

<!--- 

  Ok, do the test case generation ....


 --->
<cfif isDefined("form.packages")>
<cfif form.packages is "-0" or form.packages is "">
 <strong style="color:darkred">Error: Please select a package</strong>
<cfabort>
</cfif>
 <cfset components = structFind(packages,form.packages) >
<!---  <cfdump var="#components#">  --->
 
 
 <cfscript>
  out = getPageContext().getOut();
  try{ 
   generator = createObject("component" , "#request.mxunitRoot#.generator.Generator").Generator();
  	
  	if (form.dateAppend is true) {
  	 dir = form.subDir & '_' & dateformat(now(), "mmddyyyy_hhmmss");
  	}
  	else {
  	 dir = form.subDir;  	
  	}
  	
    for(i = 1; i lte arraylen(components); i = i + 1){
  	  comp = createObject("component" , "#form.packages#.#components[i]#");
      fileName = generator.generate(comp, dir, false, form.uXunitTestCase);
      out.println("Generated test file : " & fileName & "<br />" );
      out.flush();
     }
     
     //Generate the test suite
     
     testSuite = generator.generateTestSuite(form.packages, components, dir, form.uXunitTestSuite );
     
   }
   catch(any a){
    out.println("Failure creating test for component <code> #form.packages#.#components[i]#. Error: <strong>#a.getMessage()#</strong></code>. There's a chance there is a problem with the component itself. ");
    //out.println(a.getMessage());
    fileName = " no file generated";
   }
  </cfscript>	
  
  
</cfif>
</div>


</body>
</html>



















