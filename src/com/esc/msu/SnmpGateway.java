package com.esc.msu;

import coldfusion.eventgateway.CFEvent;
import coldfusion.eventgateway.Gateway;
import coldfusion.eventgateway.GatewayHelper;
import coldfusion.eventgateway.GatewayServices;
import coldfusion.eventgateway.Logger;

import java.io.IOException;
import java.util.ArrayList;

import org.snmp4j.PDU;
import org.snmp4j.tools.console.SnmpRequest;

/**
 * ColdFusion gateway to provide interaction with the
 * org.snmp4j.tools.console.SnmpRequest class
 */
public class SnmpGateway implements Gateway {

	/**
	 * ID provided by EventService
	 */
	private String gatewayID = "";
	/**
	 * Path to my configuration file
	 */
	private String config = null;
	/**
	 * The handle to the CF gateway service
	 */
	private GatewayServices gatewayServices = null;
	/**
	 * our instance of the Logger for log messages
	 */
	private Logger logger = null;
    /**
     * Listener CFC paths for our events
     */
    private String[] listeners = null;
    /**
     * ColdFusion Gateway status
     */
    private int status = Gateway.STOPPED;
    
	public SnmpGateway(String gatewayID, String config) {
	      this.gatewayID = gatewayID;
	      this.config = config;
	      this.gatewayServices = GatewayServices.getGatewayServices();
	      this.logger = this.gatewayServices.getLogger();
	      this.status = Gateway.RUNNING;
	      this.logger.info("Instantiating Gateway: " + this.gatewayID);
	}

	/**
     * Return the id that uniquely defines the gateway
     *
     * @return the id that uniquely defines the gateway
     */
	public String getGatewayID() {
		return this.gatewayID;
	}
	
	public GatewayHelper getHelper() {
		//add logging to say this was called
		return new SnmpGatewayHelper(this.gatewayID);
	}
	
	/**
     * Return the status of the gateway
     *
     * @return one of STARTING, RUNNING, STOPPING, STOPPED, FAILED.
     */
	public int getStatus() {
		String s = "UNKNOWN";
		
		switch(this.status) {
		case Gateway.FAILED:
			s = "FAILED";
			break;
		case Gateway.RUNNING:
			s = "RUNNING";
			break;
		case Gateway.STARTING:
			s = "STARTING";
			break;
		case Gateway.STOPPED:
			s = "STOPPED";
			break;
		case Gateway.STOPPING:
			s = "STOPPING";
			break;
		}
		
		this.logger.info("Reporting Gateway Status: " + s);
		return this.status;
	}
	
	public String outgoingMessage(CFEvent arg0) {
		// TODO Auto-generated method stub
		return null;
	}
	
    /**
     * Restart this Gateway
     * <P>
     * Generally this can be implemented as a call to stop() and then start(),
     * but you may be able to optimize this based on what kind
     * of service your gateway talks to.
     */
	public void restart() {
        this.stop();
        this.start();
	}
	
	/**
     * Set the CFClisteners list.
     * <P>
     * Takes a list of fully qualified CF component names (e.g. "my.components.HandleEvent")
     * which should each receive events when the gateway sees one.
     * This will reset the list each time it is called.
     * <P>
     * This is called by the Event Service manager on startup, and may be called
     * if the configuration of the Gateway is changed during operation.
     *
     * @param listeners a list of component names
     */
	public void setCFCListeners(String[] listeners) {
		this.listeners = listeners;	
	}
	
    /**
     * Set the id that uniquely defines the gateway
     * 
     * @param id this gateways id string
     */
	public void setGatewayID(String id) {
		this.gatewayID = id;
		
	}
	
	/**
	 * bump the gateway status to RUNNING
	 */
	public void start() {
		this.status = Gateway.RUNNING;
		this.logger.info("Starting Gateway: " + this.gatewayID);
	}
	
	/**
	 * bump the gateway status to STOPPED
	 */
	public void stop() {
		this.status = Gateway.STOPPED;
		this.logger.info("Stopping Gateway: " + this.gatewayID);
	}

	
	/**
	 * @param args not called with any parameters!
	 
	public static void main(String[] args) {
		
		SnmpGateway sg = new SnmpGateway("ColdFusion SnmpGateway", null);
		SnmpGatewayCredentials cred = sg.createCredentials("192.168.1.220",
				                                                 "public");
		cred.setTargetPort(1161);
		ArrayList<String> vbl = new ArrayList<String>();
		vbl.add("1.3.6.1.2.1.1.3.0");
		vbl.add("1.3.6.1.2.1.1");
		
		try {
			SnmpGatewayResponse sgr = sg.get(cred, vbl);
			System.out.println(sgr.getSynopsis());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		vbl.clear();
		vbl.add("1.3.6.1.2.1.1.3");
		vbl.add("1.3.6.1.2.1.1.5");
		vbl.add("1.3.6.1.2.1.8");
		
		try {
			SnmpGatewayResponse sgr = sg.getNext(cred, vbl);
			System.out.println(sgr.getSynopsis());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	*/




}
