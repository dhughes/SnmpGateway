package com.esc.msu;

import coldfusion.eventgateway.Gateway;
import coldfusion.eventgateway.GatewayHelper;
import coldfusion.eventgateway.GatewayServices;
import coldfusion.eventgateway.Logger;

public class SnmpGatewayHelper implements GatewayHelper {

	private String gatewayID;
	/**
	 * The handle to the CF gateway service
	 */
	private GatewayServices gatewayServices;
	/**
	 * our instance of the Logger for log messages
	 */
	private Logger logger = null;
	
	public SnmpGatewayHelper(String gatewayID) {
		
		this.gatewayID = gatewayID;
		
		this.gatewayServices = GatewayServices.getGatewayServices();
	    this.logger = this.gatewayServices.getLogger(this.gatewayID + "-helper");
	    this.logger.info("Instantiating " + this.gatewayID);
	}
}
