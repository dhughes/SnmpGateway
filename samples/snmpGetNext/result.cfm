
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

<!--- loop until an error is found --->
<cfloop condition=" objSNMPManager.getLastError() EQ 0 " >

	<!--- display the results --->
	<fieldset>
		<div class="formField">
			<label for="oid">Object Id:</label>
			<input type="text" name="oid" id="oid" class="inputText" readonly="true" value="<cfoutput>#objSNMPObject.getOID()#</cfoutput>" />
		</div>
		<div class="formField">
			<label for="dataType">Data Type:</label>
			<input type="text" name="dataType" id="dataType" class="inputText" readonly="true" value="<cfoutput>#objSNMPObject.getType()#</cfoutput>" />
		</div>
		<div class="formField">
			<label for="dataValue">Data Value:</label>
			<input type="text" name="dataValue" id="dataValue" class="inputText" readonly="true" value="<cfoutput>#objSNMPObject.getValue()#</cfoutput>" />
		</div>
	</fieldset>

	<!--- retrieve the next object --->
	<cfset objSNMPObject = objSNMPManager.getNext() />

</cfloop>

<!--- close the session to the remote SNMP agent --->
<cfset objSNMPManager.close() />