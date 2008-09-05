/**
 * 
 */
package com.esc.msu;

import java.io.IOException;

import org.snmp4j.CommandResponderEvent;
import org.snmp4j.CommunityTarget;
import org.snmp4j.MessageDispatcher;
import org.snmp4j.MessageDispatcherImpl;
import org.snmp4j.PDU;
import org.snmp4j.Snmp;
import org.snmp4j.mp.MPv1;
import org.snmp4j.mp.MPv2c;
import org.snmp4j.mp.MPv3;
import org.snmp4j.mp.SnmpConstants;
import org.snmp4j.security.Priv3DES;
import org.snmp4j.security.SecurityModels;
import org.snmp4j.security.SecurityProtocols;
import org.snmp4j.security.USM;
import org.snmp4j.security.UsmUser;
import org.snmp4j.smi.OctetString;
import org.snmp4j.smi.TcpAddress;
import org.snmp4j.smi.UdpAddress;
import org.snmp4j.tools.console.SnmpRequest;
import org.snmp4j.transport.AbstractTransportMapping;
import org.snmp4j.transport.DefaultTcpTransportMapping;
import org.snmp4j.transport.DefaultUdpTransportMapping;
import org.snmp4j.util.MultiThreadedMessageDispatcher;
import org.snmp4j.util.ThreadPool;

/**
 * @author ellison
 *
 */
public class SnmpGatewayEventListener extends SnmpRequest implements Runnable {

	private SnmpGateway sg;
    private AbstractTransportMapping transport;
    private ThreadPool threadPool;
    private Snmp snmp;
    private OctetString localEngineID = new OctetString(MPv3.createLocalEngineID());

    /**
	 * @param arg0
	 */
	public SnmpGatewayEventListener(SnmpGateway sg, String[] arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
		this.sg = sg;
	}
	
	private void addUsmUser(Snmp snmp) {
		  snmp.getUSM().addUser(getSecurityName(), new UsmUser(getSecurityName(),
		                                                       getAuthProtocol(),
		                                                       getAuthPassphrase(),
		                                                       getPrivProtocol(),
		                                                       getPrivPassphrase()));
	}
	
	public synchronized void listen() throws IOException {

		if (this.getAddress() instanceof TcpAddress) {
		    this.transport = new DefaultTcpTransportMapping((TcpAddress) this.getAddress());
		} else {
		    this.transport = new DefaultUdpTransportMapping((UdpAddress) this.getAddress());
		}
		this.threadPool = ThreadPool.create("DispatcherPool", this.getNumDispatcherThreads());
		MessageDispatcher mtDispatcher = new MultiThreadedMessageDispatcher(threadPool, new MessageDispatcherImpl());

		// add message processing models
		mtDispatcher.addMessageProcessingModel(new MPv1());
		mtDispatcher.addMessageProcessingModel(new MPv2c());
		mtDispatcher.addMessageProcessingModel(new MPv3(this.localEngineID.getValue()));

		// add all security protocols
		SecurityProtocols.getInstance().addDefaultProtocols();
		SecurityProtocols.getInstance().addPrivacyProtocol(new Priv3DES());

		this.snmp = new Snmp(mtDispatcher, transport);
		if (this.getVersion() == SnmpConstants.version3) {
		    USM usm = new USM(SecurityProtocols.getInstance(), localEngineID, 0);
		    SecurityModels.getInstance().addSecurityModel(usm);
		    if (this.getAuthoritativeEngineID() != null) {
		        snmp.setLocalEngine(this.getAuthoritativeEngineID().getValue(), 0, 0);
		    }
		    // Add the configured user to the USM
		    addUsmUser(snmp);
		} else {
		    CommunityTarget target = new CommunityTarget();
		    target.setCommunity(this.getCommunity());
		    this.setTarget(target);
		}

		snmp.addCommandResponder(this);

		transport.listen();
		//System.out.println("Listening on "+ this.getAddress());

		try {
		    this.wait();
		} catch (InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
	}


	public synchronized void processPdu(CommandResponderEvent e) {
		PDU command = e.getPDU();
		if (command != null) {
		    e.setProcessed(true);
			if ((command.getType() == PDU.TRAP)   ||
				(command.getType() == PDU.V1TRAP)) {
		        this.sg.inboundMessage(new SnmpGatewayEvent(e));
		    }
		}
	}

	public void run() {
		try {
			this.listen();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void stop() {
		this.threadPool.interrupt();
		try {
			this.transport.close();
			this.snmp.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
