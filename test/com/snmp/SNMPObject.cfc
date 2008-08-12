<!---
	@desc:		This is the unit test for the com.snmp.SNMPObject object
	@author:	Jeff Chastain (jchastain@alagad.com)
	@version:	@buildNumber@
	@since:		1.0
--->
<cfcomponent displayname="SNMPObject Test Harness" output="false"
	hint="Unit test harness for the com.snmp.SNMPObject object"
	extends="mxunit.framework.TestCase" >

	<!--- -------------------------------------------------- --->
	<!--- setup / teardown methods --->

	<!---
		@desc:		This function will setup the SNMPObject object instance and any
					other test infrastructure information before each test.
		@since:		1.0
	--->
	<cffunction name="setUp" access="public" output="false" returntype="void"
		hint="I will configure the SNMPObject to be used during each unit test." >

		<!--- setup the SNMPObject object --->
		<cfset variables.SNMPObject = createObject( "component", "com.snmp.SNMPObject" ).init() />

		<cfreturn />
	</cffunction> <!--- end: setUp() --->

	<!--- -------------------------------------------------- --->
	<!--- test methods --->

	<!---
		@desc:		This function will verify the functionality of the init function for the
					SNMPObject object.  This test will verify that the function accepts no
					arguments and initalizes the SNMPObject to its expected default state.
		@since:		1.0
	--->
	<cffunction name="testInit" access="public" output="false" returntype="void"
		hint="I will test the init function to verify its functionality" >

		<cfreturn />
	</cffunction> <!--- end: testInit() --->

	<!---
		@desc:		This function will verify the functionality of the OID accessor functions
					(get/set) for the SNMPObject object.  This test will verify that the get
					function accepts no arguments and returns a valid string value and that
					the set function accepts a single string argument to be used as the OID
					value and that the function returns a pointer to an object which has its
					OID property set as the string value which was passed to the setOID()
					function initially.
		@since:		1.0
	--->
	<cffunction name="testOIDAccessors" access="public" output="false" returntype="void"
		hint="I will test the OID property accessor functions to verify that the correct value is returned" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- setup a collection of OID values to use for testing --->
		<cfset var OID = structNew() />
		<cfset OID.default = "" />
		<cfset OID.valid = "1.3.1.2.3.4.5" />
		<cfset OID.invalid = structNew() />

		<!--- call getOID() method on the SNMPObject, retrieving the default OID value --->
		<cfset result = variables.SNMPObject.getOID() />

		<!--- call the getOID() method on the SNMPObject, verifying the default OID value --->
		<cfset assertEquals( OID.default, result, "The default value returned from the getOID() function does not match the expected result (#OID.default#). (actual: '#result#')" ) />

		<!--- call setOID() method on the SNMPObject, passing in a valid OID value --->
		<cfset result = variables.SNMPObject.setOID( OID.valid ) />

		<!--- call getOID() method on the SNMPObject, retrieving the current OID property value --->
		<cfset result = variables.SNMPObject.getOID() />

		<!--- verify the return value --->
		<cfset assertEquals( OID.valid, result, "The value returned from the getOID() function does not match the expected result (#OID.valid#). (actual: '#result#')" ) />

		<!--- call setOID() method on the SNMPMnager, passing in an invalid OID value --->
		<cftry>
			<cfset result = variables.SNMPObject.setOID( OID.invalid ) />
			<cfset fail( "The setOID() function did not throw an error when attempting to set an invalid OID value.") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testOIDAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the SNMPT type accessor
					functions (get/set) for the SNMPObject object.  This test will verify that
					the get function accepts no arguments and returns a valid string type value
					and that the set function accepts a string value to be used as the SNMP type
					value and that the function returns a pointer to an object instance which
					has its SNMP type property set as the string value which was passed to the
					setType() function initially.
		@since:		1.0
	--->
	<cffunction name="testTypeAccessors" access="public" output="false" returntype="void"
		hint="I will test the SNMP type property accessor functions (get/set) to verify their functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- setup a collection of SNMP type values to use for testing --->
		<cfset var type = structNew() />
		<cfset type.default = "" />
		<cfset type.valid = "SNMP_TYPE_UNDEFINED" />
		<cfset type.invalid = structNew() />

		<!--- call getType() method on the SNMPObject, retrieving the default type value --->
		<cfset result = variables.SNMPObject.getType() />

		<!--- verify the default type value --->
		<cfset assertEquals( type.default, result, "The default value returned from the getType() function does not match the expected result (#type.default#). (actual: '#result#')" ) />

		<!--- call setType() method on the SNMPObject, passing in a valid type value --->
		<cfset result = variables.SNMPObject.setType( type.valid ) />

		<!--- call getType() method on the SNMPObject, retrieving the current type property value --->
		<cfset result = variables.SNMPObject.getType() />

		<!--- verify the return value --->
		<cfset assertEquals( type.valid, result, "The value returned from the getType() function does not match the expected result (#type.valid#). (actual: '#result#')" ) />

		<!--- call setType() method on the SNMPMnager, passing in an invalid type value --->
		<cftry>
			<cfset result = variables.SNMPObject.setType( types.invalid ) />
			<cfset fail( "The setType function did not throw an error when attempting to set an invalid type value.") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testTypeAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the SNMP value accessor
					functions (get/set) for the SNMPObject object.  This test will verify
					that the get function accepts no arguments and returns a valid string
					SNMP value and that the set function accepts a string value to be used
					as the SNMP value and that the function returns a pointer to an object
					instance which has its SNMP value property set as the string value
					which was passed to the setValue() function initially.
		@since:		1.0
	--->
	<cffunction name="testValueAccessors" access="public" output="false" returntype="void"
		hint="I will test the SNMP value property accessor functions (get/set) to verify their functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- setup a collection of SNMP value strings to use for testing --->
		<cfset var value = structNew() />
		<cfset value.default = "" />
		<cfset value.valid = "10.1.1.10" />
		<cfset value.invalid = structNew() />

		<!--- call getValue() method on the SNMPObject, retrieving the default value value --->
		<cfset result = variables.SNMPObject.getValue() />

		<!--- call the getValue() method on the SNMPObject, verifying the default value value --->
		<cfset assertEquals( value.default, result, "The default value returned from the getValue() function does not match the expected result (#value.default#). (actual: '#result#')" ) />

		<!--- call setValue() method on the SNMPObject, passing in a valid value value --->
		<cfset result = variables.SNMPObject.setValue( value.valid ) />

		<!--- call getValue() method on the SNMPObject, retrieving the current value property value --->
		<cfset result = variables.SNMPObject.getValue() />

		<!--- verify the return value --->
		<cfset assertEquals( value.valid, result, "The value returned from the getValue() function does not match the expected result (#value.valid#). (actual: '#result#')" ) />

		<!--- call setValue method on the SNMPMnager, passing in an invalid value value --->
		<cftry>
			<cfset result = variables.SNMPObject.setValue( values.invalid ) />
			<cfset fail( "The setValue() function did not throw an error when attempting to set an invalid value value (#values.invalid#).") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testValueAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the SNMP request id accessor
					functions (get/set) for the SNMPObject object.  This test will verify that
					the get function accepts no arguments and returns a valid numeric SNMP
					node id and that the set function accepts a numeric requestId value to be
					used as the SNMP requestId and that the function returns a pointer to an object
					instance which has its SNMP requestId property set as the numeric value
					which was passed to the setRequestId() function initially.
		@since:		1.0
	--->
	<cffunction name="testRequestIdAccessors" access="public" output="false" returntype="void"
		hint="I will test the SNMP requestId property accessor functions (get/set) to verify their functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- setup a collection of SNMP requestId strings to use for testing --->
		<cfset var requestId = structNew() />
		<cfset requestId.default = 0 />
		<cfset requestId.valid = 10 />
		<cfset requestId.invalid = structNew() />

		<!--- call getRequestId() method on the SNMPObject, retrieving the default requestId value --->
		<cfset result = variables.SNMPObject.getRequestId() />

		<!--- verify the default requestId value --->
		<cfset assertEquals( requestId.default, result, "The default requestId returned from the getRequestId() function does not match the expected result (#requestId.default#). (actual: '#result#')" ) />

		<!--- call setRequestId() method on the SNMPObject, passing in a valid requestId value --->
		<cfset result = variables.SNMPObject.setRequestId( requestId.valid ) />

		<!--- call getRequestId() method on the SNMPObject, retrieving the current requestId property value --->
		<cfset result = variables.SNMPObject.getRequestId() />

		<!--- verify the return value --->
		<cfset assertEquals( requestId.valid, result, "The requestId returned from the getRequestId() function does not match the expected result (#requestId.valid#). (actual: '#result#')" ) />

		<!--- call setRequestId method on the SNMPMnager, passing in an invalid requestId value --->
		<cftry>
			<cfset result = variables.SNMPObject.setRequestId( requestId.invalid ) />
			<cfset fail( "The setRequestId() function did not throw an error when attempting to set an invalid requestId value (#requestId.invalid#).") />

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>
			<cfcatch type="any">
				<!--- this is the expected result --->
			</cfcatch>
		</cftry>

		<cfreturn />
	</cffunction> <!--- end: testRequestIdAccessors() --->

	<!---
		@desc:		This function will verify the functionality of the clear function for the
					SNMPObject object.  This test will verify that the function accepts no
					arguments returns an object instance with the name 'com.snmp.SNMPObject'
					which has its OID, SNMP Type, and SNMP value properties set to default
					null values.
		@since:		1.0
	--->
	<cffunction name="testClear" access="public" output="false" returntype="void"
		hint="I will test the clear function to verify its functionality" >

		<!--- declare the variables to be used in testing --->
		<cfset var result = "" />

		<!--- get a new instance of the SNMPObject for testing --->
		<cfset var SNMPObject = createObject( "component", "com.snmp.SNMPObject" ).init() />

		<!--- setup a collection of SNMP sample properties to use for testing --->
		<cfset var data = structNew() />
		<cfset data.OID = "interfaces.ifTable.ifEntry.ifDescr.7" />
		<cfset data.type = "ASN_OCTETSTRING" />
		<cfset data.value = "Marvell Yukon 88E8053 PCI-E Gigabit Ethernet Controller" />

		<!--- call clear method on the SNMPObject --->
		<cfset result = SNMPObject.clear() />

		<!--- call the property accessor methods on the SNMPObject, verifying the current property values --->
		<cfset assertEquals( "", SNMPObject.getOID(), "The OID property value returned from the getOID function does not match the expected result (empty string) after the clear function was run. (actual: '#SNMPObject.getOID()#')" ) />
		<cfset assertEquals( "", SNMPObject.getType(), "The type property value returned from the getType function does not match the expected result (empty string) after the clear function was run. (actual: '#SNMPObject.getType()#')" ) />
		<cfset assertEquals( "", SNMPObject.getValue(), "The value property value returned from the getValue function does not match the expected result (empty string) after the clear function was run. (actual: '#SNMPObject.getValue()#')" ) />

		<!--- recreate the SNMPObject instance and load the test data into the SNMPObject --->
		<cfset SNMPObject = createObject( "component", "com.snmp.SNMPObject" ).init() />
		<cfset SNMPObject.setOID( data.OID ) />
		<cfset SNMPObject.setType( data.type ) />
		<cfset SNMPObject.setValue( data.value ) />

		<!--- call clear method on the SNMPObject --->
		<cfset result = SNMPObject.clear() />

		<!--- call the property accessor methods on the SNMPObject, verifying the current property values --->
		<cfset assertEquals( "", SNMPObject.getOID(), "The OID property value returned from the getOID function does not match the expected result (empty string) after the clear function was run. (actual: '#SNMPObject.getOID()#')" ) />
		<cfset assertEquals( "", SNMPObject.getType(), "The type property value returned from the getType function does not match the expected result (empty string) after the clear function was run. (actual: '#SNMPObject.getType()#')" ) />
		<cfset assertEquals( "", SNMPObject.getValue(), "The value property value returned from the getValue function does not match the expected result (empty string) after the clear function was run. (actual: '#SNMPObject.getValue()#')" ) />

		<cfreturn />
	</cffunction> <!--- end: testClear() --->

</cfcomponent>