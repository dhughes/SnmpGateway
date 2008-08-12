
<!---
	@desc:		This object is designed to be sent to or received from an SNMP agent and will
				contain a data type and value.
	@author:	Jeff Chastain (jchastain@alagad.com)
	@version:	@buildNumber@
	@since:		1.0
--->
<cfcomponent displayname="SNMP Transfer Object" output="false"
	hint="Provides a container for an SNMP data type and value to be sent to or received from an SNMP agent" >

	<!--- -------------------------------------------------- --->
	<!--- definition --->

	<cfproperty name="OID" type="strung" default="" hint="SNMP object identifer" />
	<cfproperty name="type" type="string" default="" hint="SNMP data type" />
	<cfproperty name="value" type="string" default="" hint="SNMP data value" />
	<cfproperty name="requestId" type="numeric" default="0" hint="SNMP node identifier" />

	<!--- -------------------------------------------------- --->
	<!--- pseudo constructor --->

	<cfset variables.instance = structNew() />

	<!--- public properties --->
	<cfset variables.instance.OID = "" /> <!--- default to empty string --->
	<cfset variables.instance.type = "" /> <!--- default to empty string --->
	<cfset variables.instance.value = "" /> <!--- default to empty string --->
	<cfset variables.instance.requestId = 0 /> <!--- default to -1 --->

	<!--- private properties --->

	<!--- -------------------------------------------------- --->
	<!--- constructor method --->

	<!---
		@desc:		This function is the default constructor for the object and initializes the object.
		@return:	<code>com.snmp.SNMPObject</code>: the instantiated service
		@since:		1.0
	--->
	<cffunction name="init" access="public" output="false" returntype="com.snmp.SNMPObject"
		hint="the default constructor for the object; returns the initialized object instance" >

		<!--- return the initialized service --->
		<cfreturn this />
	</cffunction> <!-- end: init() --->

	<!--- -------------------------------------------------- --->
	<!--- accessor methods --->

	<!---
		@desc:		Returns the current value of the OID property
		@return:	<code>string</code>: the value of the current OID property
		@since:		1.0
	--->
	<cffunction name="getOID" access="public" output="false" returntype="string"
		hint="returns the current value of the OID property" >

		<cfreturn variables.instance.OID />
	</cffunction> <!--- end: getOID() --->

	<!---
		@desc:		Stores the specified value as the OID property
		@param:		<code>OID (string)</code> - the value to be set as the OID property
		@return:	<code>com.snmp.SNMPObject</code>: the instantiated object
		@since:		1.0
	--->
	<cffunction name="setOID" access="public" output="false" returntype="any"
		hint="sets the specified value as the OID property; returns a pointer to the object instance" >

		<cfargument name="OID" type="string" required="true" hint="the value to be set for the OID property" />

		<!--- store the received argument --->
		<cfset variables.instance.OID = arguments.OID />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setOID() --->

	<!---
		@desc:		Returns the current value of the SNMP type property
		@return:	<code>string</code>: the value of the current SNMP type property
		@since:		1.0
	--->
	<cffunction name="getType" access="public" output="false" returntype="string"
		hint="returns the current value of the SNMP type property" >

		<cfreturn variables.instance.type />
	</cffunction> <!--- end: getType() --->

	<!---
		@desc:		Stores the specified value as the SNMP type property
		@param:		<code>type (string)</code> - the value to be set as the SNMP type property
		@return:	<code>com.snmp.SNMPObject</code>: the instantiated object
		@since:		1.0
	--->
	<cffunction name="setType" access="public" output="false" returntype="com.snmp.SNMPObject"
		hint="sets the specified value as the SNMP type property; returns a pointer to the object instance" >

		<cfargument name="type" type="string" required="true" hint="the value to be set for the SNMP type property" />

		<!--- store the received argument --->
		<cfset variables.instance.type = arguments.type />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setType() --->

	<!---
		@desc:		Returns the current value of the SNMP value property
		@return:	<code>string</code>: the value of the current SNMP value property
		@since:		1.0
	--->
	<cffunction name="getValue" access="public" output="false" returntype="string"
		hint="returns the current value of the SNMP value property" >

		<cfreturn variables.instance.value />
	</cffunction> <!--- end: getValue() --->

	<!---
		@desc:		Stores the specified value as the SNMP value property
		@param:		<code>value (string)</code> - the value to be set as the SNMP value property
		@return:	<code>com.snmp.SNMPObject</code>: the instantiated object
		@since:		1.0
	--->
	<cffunction name="setValue" access="public" output="false" returntype="com.snmp.SNMPObject"
		hint="sets the specified value as the SNMP value property; returns a pointer to the service instance" >

		<cfargument name="value" type="string" required="true" hint="the value to be set for the SNMP value property" />

		<!--- store the received argument --->
		<cfset variables.instance.value = lcase( arguments.value ) />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setValue() --->

	<!---
		@desc:		Returns the current value of the request id property
		@return:	<code>numeric</code>: the value of the current requestId property
		@since:		1.0
	--->
	<cffunction name="getRequestId" access="public" output="false" returntype="numeric"
		hint="returns the current value of the requestId property" >

		<cfreturn variables.instance.requestId />
	</cffunction> <!--- end: getRequestId() --->

	<!---
		@desc:		Stores the specified value as the request id property
		@param:		<code>requestId (numeric)</code> - the value to be set as the requestId property
		@return:	<code>com.snmp.SNMPObject</code>: the instantiated object
		@since:		1.0
	--->
	<cffunction name="setRequestId" access="public" output="false" returntype="com.snmp.SNMPObject"
		hint="sets the specified value as the etRequestId property; returns a pointer to the object instance" >

		<cfargument name="requestId" type="numeric" required="true" hint="the value to be set for the requestId property" />

		<!--- store the received argument --->
		<cfset variables.instance.requestId = arguments.requestId />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setRequestId() --->

	<!--- -------------------------------------------------- --->
	<!--- public methods --->

	<!---
		@desc:		Clears all properties of the object, resetting them to default values
		@return:	<code>com.snmp.SNMPObject</code>: the instantiated object
		@since:		1.0
	--->
	<cffunction name="clear" access="public" output="false" returntype="com.snmp.SNMPObject"
		hint="resets all properties of the object; returns a pointer to the service instance" >

		<!--- call the set function for each property, passing a default, null value --->
		<cfset setOID("") />
		<cfset setType("") />
		<cfset setValue("") />
		<cfset setRequestId(0) />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: clear() --->

</cfcomponent>