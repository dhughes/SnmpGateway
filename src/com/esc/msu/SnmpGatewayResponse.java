/**
 * 
 */
package com.esc.msu;

import org.snmp4j.PDU;
import java.util.Date;

/**
 * comprises a response for an SNMP gateway request
 */
public class SnmpGatewayResponse {

	private final String requestType;
	private final Date requestStart;
	private final long requestDuration;
	private final String target;
	private final PDU response;	
	private final SnmpGatewayVarbinds requestVbs;
	
	/**
	 * construct a response for an SNMP gateway request
	 *  
	 * @param requestType the request type (GET or GETNEXT)
	 * @param requestStart the time in milliseconds when the request was sent
	 * @param requestDuration the duration in millesconds between the time the
	 * 				request was sent and a response was received
	 * @param target the target SNMP Agent to which the request was sent
	 * @param requestVbs the set of requested variable bindings (varbinds)
	 * @param response the response PDU received for the associated request
	 */
	public SnmpGatewayResponse(String requestType,
							   long requestStart, long requestDuration,
			                   String target,
			                   SnmpGatewayVarbinds requestVbs,
			                   PDU response) {
		
		this.requestType = new String(requestType);
		this.requestStart = new Date(requestStart);
		this.requestDuration = requestDuration;
		this.target = new String(target);
		this.requestVbs = (SnmpGatewayVarbinds )requestVbs.clone();
		this.response = response;	
	}

	/**
	 * get the date and time the request was sent
	 * @return a displayable string providing the date and time the request was sent
	 */
	public String getStart() {
		return this.requestStart.toString();
	}
	
	/**
	 * get the target SNMP Agent involved with the request/response
	 * @return a displayable string of the target SNMP Agent IP Address
	 */
	public String getTarget() {
		return new String(this.target);
	}
	/**
	 * get the duration between the time the request was sent and the
	 * response received
	 * @return a displayable string providing the duration in milliseconds
	 */
	public String getDuration() {
		return new String(Long.toString(this.requestDuration) + " milliseconds");
	}
	
	/**
	 * get the request type of the original request sent for this response
	 * @return the request type of the original request
	 */
	public String getRequestType() {
		return new String(this.requestType);
	}
	
	/**
	 * get the response error-index.  This value identifies which
	 * request varbind is associated with the error-status.  The first
	 * varbind index is 1.
	 * @return the response error-index
	 */
	public int getErrorIndex() {
		return this.response.getErrorIndex();
	}
	
	/**
	 * get the response error-status 
	 * @return the response error-status
	 */
	public int getErrorStatus() {
		return this.response.getErrorStatus();
	}
	
	/**
	 * get the text associated with the response error-status
	 * @return string containing the error-status text
	 */
	public String getErrorStatusText() {
		return this.response.getErrorStatusText();
	}
	
	/**
	 * get the response varbindlist as a display string
	 * @return string containing a representation of the reponse varbindlist
	 */
	public String getResponseVarbinds() {
		return this.response.getVariableBindings().toString();
	}
	
	public String getSynopsis() {
		return new String(this.getRequestType() + " sent to " + this.getTarget() +
				   "\n\t started at " + this.getStart() +
				   " response received after " + this.getDuration() +
				   "\n\t with error_status=" + this.getErrorStatusText() + 
				   " and error_index=" + this.getErrorIndex() +
				   "\n\t and varbindlist " + this.getResponseVarbinds());
	}
}
