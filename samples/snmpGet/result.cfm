
<!--- create a new instance of the SNMPManager --->
<cfset objSNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init( form.port, form.protocol, 2000 ) />

<!--- verify that the SNMPManager was initialized without error --->
<cfif objSNMPManager.getLastError() NEQ 0 >
	<cfoutput>"Initialization failed, error #objSNMPManager.getLastError()#"</cfoutput>
	<cfabort />
</cfif>

<!--- open a session to the remote SNMP agent --->
<cfset objSNMPManager.open( form.agent, form.community ) />

<!--- verify that the SNMPManager opent the connection without error --->
<cfif objSNMPManager.getLastError() NEQ 0 >
	<cfoutput>"Open failed, error #objSNMPManager.getLastError()#"</cfoutput>
	<cfabort />
</cfif>

<!--- retrieve the object identifier value --->
<cfset objSNMPObject = objSNMPManager.get( form.oid ) />

<!--- verify the result of the lst get operation --->
<cfif objSNMPManager.getLastError() NEQ 0 >
	<cfoutput>"Get failed, error #objSNMPManager.getLastError()#"</cfoutput>

<cfelse>
	<!--- display the results --->
	<fieldset>
		<div class="formField">
			<label for="dataType">Data Type:</label>
			<input type="text" name="dataType" id="dataType" class="inputText" readonly="true" value="<cfoutput>#objSNMPObject.getType()#</cfoutput>" />
		</div>
		<div class="formField">
			<label for="dataValue">Data Value:</label>
			<input type="text" name="dataValue" id="dataValue" class="inputText" readonly="true" value="<cfoutput>#objSNMPObject.getValue()#</cfoutput>" />
		</div>
	</fieldset>

</cfif>

<!--- close the session to the remote SNMP agent --->
<cfset objSNMPManager.close() />