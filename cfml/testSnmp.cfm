<!--- 
	Get a handle on the snmp event gateway helper.
	Note that the name of the gateway configured must be "snmp"
--->
<cfset snmpHelper = GetGatewayHelper("snmp") />

<!--- dump the snmp object --->
<cfdump var="#snmpHelper#" />
 