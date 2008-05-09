
<!---
	@desc:		This object is designed to be provide an interface for performing a variety of operations
				via either the SNMP v1 or SNMP v2c protocols including get, getNext, and set operations.
	@author:	Jeff Chastain (jchastain@alagad.com)
	@version:	@buildNumber@
	@since:		1.0
--->
<cfcomponent displayname="SNMP Manager Object" output="false"
	hint="Provides an interface for performing get, getNext, set, and other remote functions via SNMP" >

	<!--- -------------------------------------------------- --->
	<!--- definition --->

	<cfproperty name="lastError" type="numeric" default="0" hint="result of the last called function" />
	<cfproperty name="port" type="numeric" default="161" hint="the UDP port number to identify an SNMP agent" />
	<cfproperty name="protocol" type="string" default="v2c" hint="specifies the SNMP protocol version to use" />
	<cfproperty name="timeout" type="numeric" default="2000" hint="the number of milliseconds before an SNMP operation will time out" />

	<!--- -------------------------------------------------- --->
	<!--- pseudo constructor --->

	<cfset variables.instance = structNew() />

	<!--- public properties --->
	<cfset variables.instance.lastError = 0 /> <!--- zero value indicates success --->
	<cfset variables.instance.port = 161 /> <!--- default to port 161 (default SNMP port) --->
	<cfset variables.instance.protocol = "v2c" /> <!--- default to SNMP v2c --->
	<cfset variables.instance.timeout = 2000 /> <!--- default to 2000 miliseconds --->

	<!--- private properties --->
	<cfset variables.private.allowedProtocols = "v1,v2c" /> <!--- list of valid, accepted SNMP protocols --->

	<!--- -------------------------------------------------- --->
	<!--- constructor method --->

	<!---
		@desc:		This function is the default constructor for the service and initializes the service.
					This function must be called before you can open an SNMP session.  The shutDown
					function should be called once operations are complete.
		@return:	<code>com.SNMPManager</code>: the instantiated service
		@since:		1.0
	--->
	<cffunction name="init" access="public" output="false" returntype="any"
		hint="the default constructor for the service; returns the initialized service instance" >

		<!--- return the initialized service --->
		<cfreturn this />
	</cffunction> <!-- end: init() --->

	<!--- -------------------------------------------------- --->
	<!--- accessor methods --->

	<!---
		@desc:		Returns the current value of the lastError property
		@return:	<code>numeric</code>: the value of the current lastError property
		@since:		1.0
	--->
	<cffunction name="getLastError" access="public" output="false" returntype="numeric"
		hint="returns the current value of the lastError property" >

		<cfreturn variables.instance.lastError />
	</cffunction> <!--- end: getLastError() --->

	<!---
		@desc:		Stores the specified value as the lastError property
		@param:		<code>lastError : numeric</code> - the value to be set as the lastError property
		@since:		1.0
	--->
	<cffunction name="setLastError" access="private" output="false" returntype="void"
		hint="sets the specified value as the lastError property" >

		<cfargument name="lastError" type="numeric" required="true" hint="the value to be set for the lastError property" />

		<!--- store the received argument --->
		<cfset variables.instance.lastError = arguments.lastError />

		<!--- return void --->
		<cfreturn />
	</cffunction> <!--- end: setLastError() --->

	<!---
		@desc:		Returns the current value of the SNMP port property
		@return:	<code>numeric</code>: the value of the current SNMP port property
		@since:		1.0
	--->
	<cffunction name="getPort" access="public" output="false" returntype="numeric"
		hint="returns the current value of the SNMP port property" >

		<cfreturn variables.instance.port />
	</cffunction> <!--- end: getPort() --->

	<!---
		@desc:		Stores the specified value as the SNMP port property
		@param:		<code>port : numeric</code> - the value to be set as the SNMP port property
		@return:	<code>com.SNMPManager</code>: the instantiated service
		@since:		1.0
	--->
	<cffunction name="setPort" access="public" output="false" returntype="any"
		hint="sets the specified value as the SNMP port property; returns a pointer to the service instance" >

		<cfargument name="port" type="numeric" required="true" hint="the value to be set for the SNMP port property" />

		<!--- test that the received argument is between 1 and 65535 --->
		<cfif ( arguments.port LT 1 ) OR ( arguments.port GT 65535 ) >
			<cfthrow type="snmpManager.invalidPort" message="Invalid port value" detail="The supplied port value must be between 1 and 65535 (#arguments.port#)" />
		</cfif>

		<!--- store the received argument --->
		<cfset variables.instance.port = arguments.port />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setPort() --->

	<!---
		@desc:		Returns the current value of the SNMP protocol property
		@return:	<code>string</code>: the value of the current SNMP protocol property
		@since:		1.0
	--->
	<cffunction name="getProtocol" access="public" output="false" returntype="string"
		hint="returns the current value of the SNMP protocol property" >

		<cfreturn variables.instance.protocol />
	</cffunction> <!--- end: getTimeout() --->

	<!---
		@desc:		Stores the specified value as the SNMP protocol property
		@param:		<code>protocol : string</code> - the value to be set as the SNMP protocol property
		@return:	<code>com.SNMPManager</code>: the instantiated service
		@since:		1.0
	--->
	<cffunction name="setProtocol" access="public" output="false" returntype="any"
		hint="sets the specified value as the SNMP protocol property; returns a pointer to the service instance" >

		<cfargument name="protocol" type="string" required="true" hint="the value to be set for the SNMP protocol property" />

		<!--- test that the received argument is in the list of allowed protocols --->
		<cfif listFindNoCase( variables.private.allowedProtocols, arguments.protocol ) EQ 0 >
			<cfthrow type="snmpManager.invalidProtocol" message="Invalid SNMP protocol value" detail="The SNMP protocol value must be be one of the following: #replace( variables.private.allowedProtocols, ',', ', ', 'all' )#" />
		</cfif>

		<!--- store the received argument --->
		<cfset variables.instance.protocol = lcase( arguments.protocol ) />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setProtocol() --->

	<!---
		@desc:		Returns the current value of the timeout property
		@return:	<code>numeric</code>: the value, in milliseconds, of the current timeout property
		@since:		1.0
	--->
	<cffunction name="getTimeout" access="public" output="false" returntype="numeric"
		hint="returns the current value of the timeout property" >

		<cfreturn variables.instance.timeout />
	</cffunction> <!--- end: getTimeout() --->

	<!---
		@desc:		Stores the specified value as the timeout property
		@param:		<code>timeout : numeric</code> - the value, in milliseconds, to be set as the timeout property
		@return:	<code>com.SNMPManager</code>: the instantiated service
		@since:		1.0
	--->
	<cffunction name="setTimeout" access="public" output="false" returntype="any"
		hint="sets the specified value as the timeout property; returns a pointer to the service instance" >

		<cfargument name="timeout" type="numeric" required="true" hint="the value to be set for the timeout property" />

		<!--- test that the received argument is greater than 0 --->
		<cfif arguments.timeout LT 0 >
			<cfthrow type="snmpManager.invalidTimeout" message="Invalid timeout value" detail="The supplied timeout value must be greater that 0" />
		</cfif>

		<!--- store the received argument --->
		<cfset variables.instance.timeout = arguments.timeout />

		<!--- return a pointer to the current object --->
		<cfreturn this />
	</cffunction> <!--- end: setTimeout() --->

	<!--- -------------------------------------------------- --->
	<!--- public methods --->

	<!--- -------------------------------------------------- --->
	<!--- private methods --->

</cfcomponent>