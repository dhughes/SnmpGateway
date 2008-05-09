<!---
	@desc:		This is the unit test for the com.SNMPManager object
	@author:	Jeff Chastain (jchastain@alagad.com)
	@version:	@buildNumber@
	@since:		1.0
--->
<cfcomponent displayname="SNMPManager Test Harness" output="false"
	hint="Unit test harness for the com.SNMPManager object"
	extends="mxunit.framework.TestCase" >

	<!--- -------------------------------------------------- --->
	<!--- setup / teardown methods --->

	<!--- -------------------------------------------------- --->
	<!--- test methods --->

	<!---
		@desc:		This function will verify the functionality of the init function for the
					SNMPManager object.  This test will verify that the function accepts no
					arguments returns an object instance with the name 'com.snmp.SNMPManager'.
		@since:		1.0
	--->
	<cffunction name="testInit" access="public" output="false" returntype="void"
		hint="I will test the init function to verify it returns an object of the right type" >

		<!--- get a new instance of the SNMPManager and run its init method --->
		<cfset var SNMPManager = createObject( "component", "com.snmp.SNMPManager" ).init() />

		<!--- verify the return value --->
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata(SNMPManager ).name, "The init function did not return an object with the name 'com.snmp.SNMPManager'. (actual: '#getMetadata(SNMPManager ).name#')" ) />

		<cfreturn />
	</cffunction> <!--- end: testInit() --->

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
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata(SNMPManager).name, "The name of the object returned from the setPort() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata(SNMPManager).name#')" ) />

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
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata(SNMPManager).name, "The name of the object returned from the setProtocol() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata(SNMPManager).name#')" ) />

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
		<cfset assertEquals( "com.snmp.SNMPManager", getMetadata(SNMPManager).name, "The name of the object returned from the setTimeout() function is not 'com.snmp.SNMPManager'. (actual: '#getMetadata(SNMPManager).name#')" ) />

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

	<!--- -------------------------------------------------- --->
	<!--- support methods --->


</cfcomponent>