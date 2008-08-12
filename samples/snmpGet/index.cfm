<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Simple SNMP Get Test</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link href="../_common/css/examples.css" type="text/css" rel="stylesheet" />
</head>

<body>
	<h1>Simple SNMP Get</h1>
	<p>This is a simple example allows you to perform an SNMP get operation on a given SNMP agent.</p>

	<form action="index.cfm" method="post" name="simpleGet">
		<fieldset>
			<div class="formField">
				<label for="agent">Agent:</label>
				<input type="text" name="agent" id="agent" class="inputText" value="localhost" />
			</div>
			<div class="formField">
				<label for="port">Port:</label>
				<input type="text" name="port" id="port" class="inputText" value="161" />
				<div class="fieldMsg">(default port: 161)</div>
			</div>
			<div class="formField">
				<label for="community">Community:</label>
				<input type="text" name="community" id="community" class="inputText" value="public" />
			</div>
			<div class="formField">
				<label for="protocol">Protocol Version:</label>
				<select name="protocol" id="protocol" class="inputSelectOne" >
					<option value="v1">SNMP v1</option>
					<option value="v2c">SNMP v2c</option>
				</select>
			</div>
			<div class="formField">
				<label for="oid">Object Id::</label>
				<input type="text" name="oid" id="oid" class="inputText" value="system.sysName.0" />
			</div>
			<div class="formField formButtons">
				<input type="submit" name="action" value="Submit" class="inputButton" />
				<input type="reset" value="Reset" class="inputButton" />
			</div>
		</fieldset>
	</form>

	<!--- process the form submission if it exists --->
	<cfif isDefined("form.action") AND form.action EQ "Submit">
		<cfinclude template="result.cfm">
	</cfif>

</body>
</html>