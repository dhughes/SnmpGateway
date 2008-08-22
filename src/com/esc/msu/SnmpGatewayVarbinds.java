package com.esc.msu;

import java.util.ArrayList;

public class SnmpGatewayVarbinds extends ArrayList<String> {

	public String getVarbindList() {
		String vbl = new String();
		
		for(String vb : this) {
			vbl = vbl.concat(vb + " ");
		}
		
		return(vbl);
	}
}
