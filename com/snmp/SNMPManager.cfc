
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

	<!--- private properties --->
	<cfset variables.private = structNew() /> <!--- private properties container --->

	<cfset variables.private.allowedProtocols = "v1,v2c,v3" /> <!--- list of valid, accepted SNMP protocols --->
	<cfset variables.private.oSNMP = "" /> <!--- Java SNMP API instance --->

	<!--- default property values (constants) --->
	<cfset variables.private.lastError = 0 /> <!--- zero value indicates success --->
	<cfset variables.private.port = 161 /> <!--- default to port 161 (default SNMP port) --->
	<cfset variables.private.protocol = "v2c" /> <!--- default to SNMP v2c --->
	<cfset variables.private.timeout = 2000 /> <!--- default to 2000 miliseconds --->

	<!--- public properties --->
	<cfset variables.instance = structNew() /> <!--- mutable properties container --->

	<!--- setup default property values --->
	<cfset variables.instance.lastError = variables.private.lastError />
	<cfset variables.instance.port = variables.private.port />
	<cfset variables.instance.protocol = variables.private.protocol />
	<cfset variables.instance.timeout = variables.private.timeout />

	<!--- -------------------------------------------------- --->
	<!--- constructor method --->

	<!---
		@desc:		This function is the default constructor for the service and initializes the service.
					This function must be called before you can open an SNMP session.  The shutDown
					function should be called once operations are complete.
		@param:		<code>port (integer)</code> - an optional default port value to use for SNMP communications
		@param:		<code>protocol (string)</code> - an optional default protocol value to use for SNMP communications
		@param:		<code>timeout (integer)</code> - an optional default timeout value to use for SNMP communications
		@return:	<code>com.snmp.SNMPManager</code>: the instantiated service
		@since:		1.0
	--->
	<cffunction name="init" access="public" output="false" returntype="any"
		hint="the default constructor for the service; returns the initialized service instance" >

		<cfargument name="port" type="numeric" required="false" hint="an optional default port value to use for SNMP communications" />
		<cfargument name="protocol" type="string" required="false" hint="an optional default protocol value to use for SNMP communications" />
		<cfargument name="timeout" type="numeric" required="false" hint="an optional default timeout value to use for SNMP communications" />

		<!--- if received, store the default property values --->
		<cfif isDefined( "arguments.port" ) >
			<cfset setPort( arguments.port ) />
		</cfif>
		<cfif isDefined( "arguments.protocol" ) >
			<cfset setProtocol( arguments.protocol ) />
		</cfif>
		<cfif isDefined( "arguments.timeout" ) >
			<cfset setTimeout( arguments.timeout ) />
		</cfif>

		<!--- setup the Java SNMP4J object instance and initialize it, storing the instance as an internal property --->
		<cfset variables.private.oSNMP = createObject( "component", "SNMPObject" ) /> <!--- TODO: this is only for testing purposes, remove this --->

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
		@return:	<code>com.snmp.SNMPManager</code>: the instantiated service
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
	</cffunction> <!--- end: getProtocol() --->

	<!---
		@desc:		Stores the specified value as the SNMP protocol property
		@param:		<code>protocol : string</code> - the value to be set as the SNMP protocol property
		@return:	<code>com.snmp.SNMPManager</code>: the instantiated service
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
		@return:	<code>com.snmp.SNMPManager</code>: the instantiated service
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

	<!---
		@desc:		Resets all properties of the SNMPManager to default values including LastError,
					Port, Protocol, and Timeout.  This function is used when you are opening and
					closing SNMP sessions multiple times.
		@return:	<code>com.snmp.SNMPManager</code>: a pointer to the service instance
		@since:		1.0
	--->
	<cffunction name="clear" access="public" output="false" returntype="any"
		hint="resets all properties of the SNMPMnager to default values; returns a pointer to the service instance" >

		<!--- call the set function for each property, passing in the default value --->
		<cfset setLastError( variables.private.lastError ) />
		<cfset setPort( variables.private.port ) />
		<cfset setProtocol( variables.private.protocol ) />
		<cfset setTimeout( variables.private.timeout ) />

		<!--- set error 0 : function call success --->
		<cfset setLastError( 0 ) />

		<!--- return the a pointer to the service object --->
		<cfreturn this />
	</cffunction> <!--- end: clear() --->

	<!---
		@desc:		Closes an SNMP session that was previously opened using the
					open function.
		@return:	<code>com.snmp.SNMPManager</code>: a pointer to the service instance
		@since:		1.0
	--->
	<cffunction name="close" access="public" output="false" returntype="any"
		hint="closes an existing SNMP session; returns a pointer to the service instance" >

		<!--- test to make sure an open session exists --->
		<cfif FALSE >
			<!--- set error 1003 : Open an SNMP session first --->
			<cfset setLastError( 1003 ) />

			<!--- exit the function, returning the a pointer to the service object --->
			<cfreturn this />
		</cfif>

		<!--- TODO: attempt to close the existing SNMP session --->

		<!--- set error 0 : function call success --->
		<cfset setLastError( 0 ) />

		<!--- return the a pointer to the service object --->
		<cfreturn this />
	</cffunction> <!--- end: close() --->

	<!---
		@desc:		Get the value and type of the specified object identifier (OID) from
					the SNMP agent.  An SNMP session must first be opened.
		@return:	<code>com.snmp.SNMPObject</code>: an SNMPObject instance containing the value and type results
		@since:		1.0
	--->
	<cffunction name="get" access="public" output="false" returntype="any"
		hint="get the value and type of the specified OID; returns an SNMPObject instance" >

		<cfargument name="OID" type="string" required="true" hint="the object identifier to reference" />

		<!--- create a new SNMPObject to populate with the result of the get operation --->
		<cfset var oSNMP = createObject( "component", "SNMPObject" ).init() />

		<!--- TODO: test to make sure an open session exists --->
		<cfif FALSE >
			<!--- set error 1003 : Open an SNMP session first --->
			<cfset setLastError( 1003 ) />

			<!--- exit the function, returning the a pointer to the SNMPObject --->
			<cfreturn oSNMP />
		</cfif>

		<!--- TODO: attempt to process the get transaction and populate the SNMPObject with the result --->

		<!--- set error 0 : function call success --->
		<cfset setLastError( 0 ) />

		<!--- return the a pointer to the SNMPObject --->
		<cfreturn oSNMP />
	</cffunction> <!--- end: get() --->

	<!---
		@desc:		Get the value and type of the "next" object identifier (OID) from
					the SNMP agent.  An SNMP session must first be opened and a successful
					get function call should preceed this function call.				.
		@return:	<code>com.snmp.SNMPObject</code>: an SNMPObject instance containing the value and type results
		@since:		1.0
	--->
	<cffunction name="getNext" access="public" output="false" returntype="any"
		hint="get the value and type of the next OID; returns an SNMPObject instance" >

		<cfargument name="OID" type="string" required="true" hint="the object identifier to reference" />

		<!--- create a new SNMPObject to populate with the result of the getNext operation --->
		<cfset var oSNMP = createObject( "component", "SNMPObject" ).init() />

		<!--- TODO: test to make sure an open session exists --->
		<cfif FALSE >
			<!--- set error 1003 : Open an SNMP session first --->
			<cfset setLastError( 1003 ) />

			<!--- exit the function, returning the a pointer to the SNMPObject --->
			<cfreturn oSNMP />
		</cfif>

		<!--- TODO: attempt to process the getNext transaction and populate the SNMPObject with the result --->

		<!--- set error 0 : function call success --->
		<cfset setLastError( 0 ) />

		<!--- return the a pointer to the SNMPObject --->
		<cfreturn oSNMP />
	</cffunction> <!--- end: getNext() --->

	<!---
		@desc:		Opens an SNMP session to a remote host based upon the SNMP
					agent and community paramters
		@param:		<code>agent : string</code> - the hostname or IP address of the device running
					an SNMP agent application to connect to
		@param:		<code>community : string</code> - the community string name for the device
					to connect to
		@return:	<code>com.snmp.SNMPManager</code>: a pointer to the service instance
		@throw:		<code>1000 - SNMP Manager not initialized</code>
		@throw:		<code>1001 - Unable to open SNMP session</code>
		@throw:		<code>1002 - SNMP session already opened</code>
		@since:		1.0
	--->
	<cffunction name="open" access="public" output="false" returntype="any"
		hint="opens an SNMP session to a remote host; returns a pointer to the service instance" >

		<cfargument name="agent" type="string" required="true" hint="the SNMP hosname or IP address to connect to" />
		<cfargument name="community" type="string" required="true" hint="the community string for the device to connect to" />

		<!--- test to make sure the SNMPManager has been initilized --->
		<cfif NOT isObject( variables.private.oSNMP ) >
			<!--- set error 1000 : SNMP Manager not initialized --->
			<cfset setLastError( 1000 ) />

			<!--- exit the function, returning the a pointer to the service object --->
			<cfreturn this />
		</cfif>

		<!--- TODO: attempt to establish an SNMP session based upon the agent and community arguments --->

		<!--- set error 0 : function call success --->
		<cfset setLastError( 0 ) />

		<!--- return the a pointer to the service object --->
		<cfreturn this />
	</cffunction> <!--- end: open() --->

	<!---
		@desc:		Shuts down the SNMP manager, releasing all resources.
		@return:	<code>com.snmp.SNMPManager</code>: a pointer to the service instance
		@since:		1.0
	--->
	<cffunction name="shutDown" access="public" output="false" returntype="any"
		hint="shuts down the SNMP manager; returns a pointer to the service instance" >

		<!--- TODO: Perform any shutdown actions on the Java SNMP4J object instance --->
		<!--- TODO: Remove the Java SNMP4J object instance from the internal scope --->

		<!--- set error 0 : function call success --->
		<cfset setLastError( 0 ) />

		<!--- return the a pointer to the service object --->
		<cfreturn this />
	</cffunction> <!--- end: shutDown() --->

	<!--- -------------------------------------------------- --->
	<!--- private methods --->

</cfcomponent>