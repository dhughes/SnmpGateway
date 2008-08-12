<!---
	@desc:		This is the unit test for the com.snmp.SNMPManager object
	@author:	Jeff Chastain (jchastain@alagad.com)
	@version:	@buildNumber@
	@since:		1.0
--->
<cfcomponent displayname="SNMPManager Test Harness" output="false"
	hint="Unit test harness for the com.snmp.SNMPManager object"
	extends="mxunit.framework.TestCase" >

	<!--- -------------------------------------------------- --->
	<!--- setup / teardown methods --->

	<!---
		@desc:		This function will setup a common set of know test data that can be
					used by the unit tests in this test suite.
		@since:		1.0
	--->
	<cffunction name="setUp" access="public" output="false" returntype="void"
		hint="I will initialize the test suite before every test is run" >

		<!--- setup a known set of SNMP service properties --->
		<cfset variables.snmp = structNew() />
		<cfset variables.snmp.lastError = 0 />
		<cfset variables.snmp.port = 161 />
		<cfset variables.snmp.protocol = "v2c" />
		<cfset variables.snmp.timeout = 2000 />

		<!--- setup a known set of SNMP agent properties --->
		<cfset variables.snmpa = structNew() />
		<cfset variables.snmpa.agent = "localhost" />
		<cfset variables.snmpa.community = "public" />

		<!--- setup a known set of SNMP object properties --->
		<cfset variables.snmpo = structNew() />
		<cfset variables.snmpo.OID = "" />
		<cfset variables.snmpo.type = "" />
		<cfset variables.snmpo.value = "" />

		<cfreturn />
	</cffunction> <!--- end: testInit() --->

	<!--- -------------------------------------------------- --->
	<!--- test methods --->

	<!---
		@desc:		This function will verify the functionality of the init function for the
					SNMPManager object.  This test will verify that the function accepts no
					arguments returns an object instance with the name 'com.snmp.SNMPManager'.
		@since:		1.0
	--->
	<cffunction name="testInit" access="public" output="false" returntype="void"
		hint="I will test the init function to verify its functionality" >

		<!--- get a new instance of the SNMPManager and run its init method --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata(SNMPManager ).name, "The init function did not return an object with the name 'com.snmp.SNMPManager'. (actual: '#getMetadata(SNMPManager ).name#')" ) />

		<cfreturn />
	</cffunction> <!--- end: testInit() --->

	<!--- test accessor methods --->

	<!---
		@desc:		This function will verify the functionality of the lastError accessor
					function (get) for the SNMPManager object.  This test will verify that
					the set function accepts no arguments and returns a numeric error code
					value.
		@since:		1.0
	--->
	<cffunction name="testLastErrorAccessors" access="public" output="false" returntype="void"
		hint="I will test the lastError property accessor functions to verify that the correct value is returned" >

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- call getLastError method on the SNMPManager, retrieving the lastError value --->
		<cfset var result = SNMPManager.getLastError() />

		<!--- verify the return value --->
		<cfset assertEquals( 0, result, "The lastError value returned from the getLastError function does not match the expected result (0). (actual: '#result#')" ) />

		<cfreturn />
	</cffunction> <!--- end: testLastErrorAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the port accessor
					functions (get/set) for the SNMPManager service.  This test will verify
					that the get function accepts no arguments and returns a valid numeric
					port value and that the set function accepts a numeric value to be used
					as the port number and that the function returns a pointer to an object
					instance with the meta name 'com.snmp.SNMPManager' which has its port
					property set as the numeric value which was passed to the setPort function
					initially.
		@since:		1.0
	--->
	<cffunction name="testPortAccessors" access="public" output="false" returntype="void"
		hint="I will test the port property accessor functions (get/set) to verify their functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- setup a collection of port numbers to use for testing --->
		<cfset var ports = structNew() />
		<cfset ports.default = 161 />
		<cfset ports.valid = 200 />
		<cfset ports.invalid = -1 />

		<!--- call getPort method on the SNMPManager, retrieving the default port value --->
		<cfset result = SNMPManager.getPort() />

		<!--- call the getPort method on the SNMPManager, verifying the default port value --->
		<cfset assertEquals( ports.default, result, "The default value returned from the getPort function does not match the expected result (#ports.default#). (actual: '#result#')" ) />

		<!--- call setPort method on the SNMPManager, passing in a valid port value --->
		<cfset result = SNMPManager.setPort( ports.valid ) />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the setPort() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata( result ).name#')" ) />

		<!--- call getPort method on the SNMPManager, retrieving the current port property value --->
		<cfset result = SNMPManager.getPort() />

		<!--- verify the return value --->
		<cfset assertEquals( ports.valid, result, "The value returned from the getPort function does not match the expected result (#ports.valid#). (actual: '#result#')" ) />

		<!--- call setPort method on the SNMPMnager, passing in an invalid port value --->
		<cftry>
			<cfset result = SNMPManager.setPort( ports.invalid ) />
			<cfset fail( "The setPort function did not throw an error when attempting to set an invalid port value (#ports.invalid#).") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testPortAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the protocol accessor
					functions (get/set) for the SNMPManager service.  This test will verify
					that the get function accepts no arguments and returns a valid numeric
					protocol value and that the set function accepts a string value to be used
					as the protocol version and that the function returns a pointer to an object
					instance with the meta name 'com.snmp.SNMPManager' which has its protocol
					property set as the string value which was passed to the setProtocol function
					initially.
		@since:		1.0
	--->
	<cffunction name="testProtocolAccessors" access="public" output="false" returntype="void"
		hint="I will test the protocol property accessor functions (get/set) to verify their functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- setup a collection of protocol numbers to use for testing --->
		<cfset var protocols = structNew() />
		<cfset protocols.default = "v2c" />
		<cfset protocols.valid = "v1" />
		<cfset protocols.invalid = "invalid" />

		<!--- call getProtocol method on the SNMPManager, retrieving the default protocol value --->
		<cfset result = SNMPManager.getProtocol() />

		<!--- call the getProtocol method on the SNMPManager, verifying the default protocol value --->
		<cfset assertEquals( protocols.default, result, "The default value returned from the getProtocol function does not match the expected result (#protocols.default#). (actual: '#result#')" ) />

		<!--- call setProtocol method on the SNMPManager, passing in a valid protocol value --->
		<cfset result = SNMPManager.setProtocol( protocols.valid ) />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the setProtocol() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata( result ).name#')" ) />

		<!--- call getProtocol method on the SNMPManager, retrieving the current protocol property value --->
		<cfset result = SNMPManager.getProtocol() />

		<!--- verify the return value --->
		<cfset assertEquals( protocols.valid, result, "The value returned from the getProtocol function does not match the expected result (#protocols.valid#). (actual: '#result#')" ) />

		<!--- call setProtocol method on the SNMPMnager, passing in an invalid protocol value --->
		<cftry>
			<cfset result = SNMPManager.setProtocol( protocols.invalid ) />
			<cfset fail( "The setProtocol function did not throw an error when attempting to set an invalid protocol value (#protocols.invalid#).") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testProtocolAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the timeout accessor
					functions (get/set) for the SNMPManager service.  This test will verify
					that the get function accepts no arguments and returns a valid numeric
					timeout value and that the set function accepts a numeric value to be used
					as the timeout value and that the function returns a pointer to an object
					instance with the meta name 'com.snmp.SNMPManager' which has its timeout
					property set as the numeric value which was passed to the setTimeout function
					initially.
		@since:		1.0
	--->
	<cffunction name="testTimeoutAccessors" access="public" output="false" returntype="void"
		hint="I will test the timeout property accessor functions (get/set) to verify their functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- setup a collection of timeout numbers to use for testing --->
		<cfset var timeouts = structNew() />
		<cfset timeouts.default = 2000 />
		<cfset timeouts.valid = 200 />
		<cfset timeouts.invalid = -1 />

		<!--- call getTimeout method on the SNMPManager, retrieving the default timeout value --->
		<cfset result = SNMPManager.getTimeout() />

		<!--- call the getTimeout method on the SNMPManager, verifying the default timeout value --->
		<cfset assertEquals( timeouts.default, result, "The default value returned from the getTimeout function does not match the expected result (#timeouts.default#). (actual: '#result#')" ) />

		<!--- call setTimeout method on the SNMPManager, passing in a valid timeout value --->
		<cfset result = SNMPManager.setTimeout( timeouts.valid ) />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the setTimeout() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata( result ).name#')" ) />

		<!--- call getTimeout method on the SNMPManager, retrieving the current timeout property value --->
		<cfset result = SNMPManager.getTimeout() />

		<!--- verify the return value --->
		<cfset assertEquals( timeouts.valid, result, "The value returned from the getTimeout function does not match the expected result (#timeouts.valid#). (actual: '#result#')" ) />

		<!--- call setTimeout method on the SNMPMnager, passing in an invalid timeout value --->
		<cftry>
			<cfset result = SNMPManager.setTimeout( timeouts.invalid ) />
			<cfset fail( "The setTimeout function did not throw an error when attempting to set an invalid timeout value (#timeouts.invalid#).") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testTimeoutAccessors() --->

	<!--- test public methods --->

	<!---
		@desc:		This function will verify the functionality of the clear function for the
					SNMPManager object.  This test will verify that the function accepts no
					arguments returns an object instance with the name 'com.snmp.SNMPManager'.
					In addition, it will verify that all properties of the SNMManager object
					have been reset to default values.
		@since:		1.0
	--->
	<cffunction name="testClear" access="public" output="false" returntype="any"
		hint="I will test the clear function to verify its functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- setup a collection of sample properties to use for testing --->
		<cfset var testData = structNew() />
		<cfset testData.port = 2515 />
		<cfset testData.protocol = "v1" />
		<cfset testData.timeout = 1000 />

		<!--- call clear method on the SNMPManager --->
		<cfset result = SNMPManager.clear() />

		<!--- check the lastError property to verify the clear function succeeded --->
		<cfif SNMPManager.getLastError() NEQ 0 >
			<cfset fail( "The clear function threw an unexpected error.  Error Code: #SNMPManager.getLastError()#" ) />
		</cfif>

		<!--- call the property accessor methods on the SNMPManager, verifying the current property values --->
		<cfset assertEquals( variables.snmp.lastError, SNMPManager.getLastError(), "The lastError property value returned from the getLastError() function does not match the expected result ('#variables.snmp.lastError#') after the clear function was run. (actual: '#SNMPManager.getLastError()#')" ) />
		<cfset assertEquals( variables.snmp.port, SNMPManager.getPort(), "The port property value returned from the getPort() function does not match the expected result ('#variables.snmp.port#') after the clear function was run. (actual: '#SNMPManager.getPort()#')" ) />
		<cfset assertEquals( variables.snmp.protocol, SNMPManager.getProtocol(), "The protocol property value returned from the getProtocol() function does not match the expected result ('#variables.snmp.protocol#') after the clear function was run. (actual: '#SNMPManager.getProtocol()#')" ) />
		<cfset assertEquals( variables.snmp.timeout, SNMPManager.getTimeout(), "The timeout property value returned from the getTimeout() function does not match the expected result ('#variables.snmp.timeout#') after the clear function was run. (actual: '#SNMPManager.getTimeout()#')" ) />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the clear() function is not 'com.snmp.SNMPManager'. [1] (actual: '#getMetadata( result ).name#')" ) />

		<!--- recreate the SNMPManager instance and load the test data into the SNMPManager --->
		<cfset SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />
		<cfset SNMPManager.setPort( testData.port ) />
		<cfset SNMPManager.setProtocol( testData.protocol ) />
		<cfset SNMPManager.setTimeout( testData.timeout ) />

		<!--- call clear method on the SNMPManager --->
		<cfset result = SNMPManager.clear() />

		<!--- check the lastError property to verify the clear function succeeded --->
		<cfif SNMPManager.getLastError() NEQ 0 >
			<cfset fail( "The clear function threw an unexpected error.  Error Code: #SNMPManager.getLastError()#" ) />
		</cfif>

		<!--- call the property accessor methods on the SNMPManager, verifying the current property values --->
		<cfset assertEquals( variables.snmp.lastError, SNMPManager.getLastError(), "The lastError property value returned from the getLastError() function does not match the expected result ('#variables.snmp.lastError#') after the clear function was run. (actual: '#SNMPManager.getLastError()#')" ) />
		<cfset assertEquals( variables.snmp.port, SNMPManager.getPort(), "The port property value returned from the getPort() function does not match the expected result ('#variables.snmp.port#') after the clear function was run. (actual: '#SNMPManager.getPort()#')" ) />
		<cfset assertEquals( variables.snmp.protocol, SNMPManager.getProtocol(), "The protocol property value returned from the getProtocol() function does not match the expected result ('#variables.snmp.protocol#') after the clear function was run. (actual: '#SNMPManager.getProtocol()#')" ) />
		<cfset assertEquals( variables.snmp.timeout, SNMPManager.getTimeout(), "The timeout property value returned from the getTimeout() function does not match the expected result ('#variables.snmp.timeout#') after the clear function was run. (actual: '#SNMPManager.getTimeout()#')" ) />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the clear() function is not 'com.snmp.SNMPManager'. [2] (actual: '#getMetadata( result ).name#')" ) />

		<cfreturn />
	</cffunction> <!--- end: testClear() --->

	<!---
		@desc:		This function will verify the functionality of the close function for the
					SNMPManager object.  This test will verify that the function accepts no
					arguments and returns an object instance with the name 'com.snmp.SNMPManager'.
					In addition, it will attempt to verify the edge cases which will cause the
					function to throw errors including calling the function before opening a
					session using the open function.
		@since:		1.0
	--->
	<cffunction name="testClose" access="public" output="false" returntype="void"
		hint="I will test the close function to verify its functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- open a new test connection --->
		<cfset result = SNMPManager.open( "localhost", "public" ) />

		<!--- call close function on the SNMPManager --->
		<cfset result = SNMPManager.close() />

		<!--- check the lastError property to verify the close function succeeded --->
		<cfif SNMPManager.getLastError() NEQ 0 >
			<cfset fail( "The close function threw an unexpected error.  Error Code: #SNMPManager.getLastError()#" ) />
		</cfif>

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the close() function is not 'com.snmp.SNMPManager'. [1] (actual: '#getMetadata( result ).name#')" ) />

		<!--- call close function on the SNMPManager again without calling the open function --->
		<cfset result = SNMPManager.close() />

		<!--- check the lastError property to verify the close function call failed as expected --->
		<cfif SNMPManager.getLastError() NEQ 1003 >
			<cfset fail( "The close function did not throw an error when attempting to close a session as it should have when a session was not currently open.") />
		</cfif>

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the close() function is not 'com.snmp.SNMPManager'. [2] (actual: '#getMetadata( result ).name#')" ) />

		<cfreturn />
	</cffunction> <!--- end: testClose() --->

	<!---
		@desc:		This function will verify the functionality of the get function for the
					SNMPManager object.  This test will verify that the function accepts a single
					string argument representing an object identifier and returns an SNMPObject
					instance with the name 'com.snmp.SNMPObject' which contains the expected
					type and value properties.  In addition, it will attempt to verify the edge
					cases which will cause the function to throw errors including calling the
					function without an open session.
		@since:		1.0
	--->
	<cffunction name="testGet" access="public" output="false" returntype="any"
		hint="I will test the get function to verify its functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />











		<cfreturn />
	</cffunction> <!--- end: testGet() --->

	<!---
		@desc:		This function will verify the functionality of the open function for the
					SNMPManager object.  This test will verify that the function accepts two
					arguments and returns an object instance with the name 'com.snmp.SNMPManager'.
					In addition, it will attempt to verify the edge cases which will cause the
					function to throw errors including calling the function before initializing
					the SNMPManager.
		@since:		1.0
	--->
	<cffunction name="testOpen" access="public" output="false" returntype="void"
		hint="I will test the open function to verify its functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing - but don't initialize it --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ) />

		<!--- call open method on the SNMPManager before initializing it --->
		<cfset result = SNMPManager.open( variables.snmpa.agent, variables.snmpa.community ) />

		<!--- check the lastError property to verify the open function call failed as expected --->
		<cfif SNMPManager.getLastError() NEQ 1000 >
			<cfset fail( "The open function did not throw an error when attempting to open a session before initializing the SNMPManager as it should have.") />
		</cfif>

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the open() function is not 'com.snmp.SNMPManager'. [1] (actual: '#getMetadata( result ).name#')" ) />

		<!--- call the init function on the SNMPManager to initialize it as it is supposed to be --->
		<cfset result = SNMPManager.init() />

		<!--- call the open function again, passing valid arguments --->
		<cfset result = SNMPManager.open( variables.snmpa.agent, variables.snmpa.community ) />

		<!--- check the lastError property to verify the open function succeeded --->
		<cfif SNMPManager.getLastError() NEQ 0 >
			<cfset fail( "The open function threw an unexpected error.  Error Code: #SNMPManager.getLastError()#" ) />
		</cfif>

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the open() function is not 'com.snmp.SNMPManager'. [2] (actual: '#getMetadata( result ).name#')" ) />

		<!--- TODO: Add test to verify error '1000 - SNMP Manager not initialized' is thrown properly --->
		<!--- TODO: Add test to verify error '1001 - Unable to open SNMP session' is thrown properly --->
		<!--- TODO: Add test to verify error '1002 - SNMP session already opened' is thrown properly --->

		<cfreturn />
	</cffunction> <!--- end: testOpen() --->

	<!---
		@desc:		This function will verify the functionality of the shutDown function for the
					SNMPManager object.  This test will verify that the function accepts no
					arguments returns an object instance with the name 'com.snmp.SNMPManager'.
					In addition, it will attempt to call another method on the SNMP manager which
					should result in an error because the SNMP manager is no longer initialized.
		@since:		1.0
	--->
	<cffunction name="testShutdown" access="public" output="false" returntype="void"
		hint="I will test the shutdown function to verify its functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPManager for testing --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- call shutdown method on the SNMPManager --->
		<cfset result = SNMPManager.shutdown() />

		<!--- check the lastError property to verify the shutdown function succeeded --->
		<cfif SNMPManager.getLastError() NEQ 0 >
			<cfset fail( "The shutdown function threw an unexpected error.  Error Code: #SNMPManager.getLastError()#" ) />
		</cfif>

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata( result ).name, "The name of the object returned from the shutdown() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata( result ).name#')" ) />

		<!--- TODO: Add a test for calling another method (open?) on the SNMPManager after the shutdown function has been called to verify that the mangaer has been un-initialized --->

		<cfreturn />
	</cffunction> <!--- end: testShutdown() --->

	<!--- -------------------------------------------------- --->
	<!--- support methods --->

</cfcomponent>