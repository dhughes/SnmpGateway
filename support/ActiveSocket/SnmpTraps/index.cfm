<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>ActiveSocket SNMP Traps Using ColdFusion</title>
<style>
<!--
body{
 text-align: center;
}
h2{
 font-family: verdana;
 color: navy;
 font-weight: bold;
}
form{
 margin: 0px;
}
.input{
 font-family: verdana;
 font-size: 9pt;
 color: navy;
 border: 1px solid navy;
 background-color: white;
 width: 300px;
}
.table{
 font-family: verdana;
 font-size: 9pt;
 color: navy;
 border: 1px solid navy;
 width: 450px;
}
a{
 font-family: verdana;
 font-size: 8pt;
 color: red;
}
-->
</style>

</cfoutput>

<cfscript>
strHost = "localhost";
strCommunity = "public";
intVersion = 2;
strOid = "system.sysName.0";
strDatatype = "string";
strValue = "Hello world!";
intErrorNo = "";
strErrorDescr = "";
</cfscript>

<cfif IsDefined("URL.submitbutton")>

   <!--- Setting the objects --->
   <cfobject class="ActiveXperts.SnmpTrap" type="com" name="objSnmpTrap" Action="Create">
   <cfobject class="ActiveXperts.SnmpTrapManager" type="com" name="objSnmpTrapManager" Action="Create">.
   <cfobject class="ActiveXperts.SnmpObject" type="com" name="objSnmpObject" Action="Create">.
   <cfobject class="ActiveXperts.ASConstants" type="com" name="objConstants" Action="Create">

   <!--- Setting the logfile --->
   <cfscript>
     strLogfile = "C:\temp\logfile.txt";
     if(IsDefined("URL.Logfile")){
       objSnmpTrapManager.Logfile = URL.logfile;
       strLogfile = URL.logfile;
     }
   </cfscript>

   <!--- Initializing --->
   <cfif objSnmpTrapManager.LastError eq 0>
     <cfset objSnmpTrapManager.Initialize()>
   </cfif>
	 
   <!--- Setting the protocolversion --->
   <cfscript>
    if(objSnmpTrapManager.LastError eq 0){
       intVersion = 2;
       if(IsDefined("URL.version")){
         objSnmpTrapManager.ProtocolVersion = URL.version;
         intVersion = URL.version;
       }
     }
    </cfscript>
	 
   <!--- executing the OID --->
   <cfscript>
    if(objSnmpTrapManager.LastError eq 0){
      strOid = "system.sysName.0";
      objSnmpObject.Clear();
      if(IsDefined("URL.oid")){
        objSnmpObject.OID = URL.oid;
        strOid = URL.oid;			 
      }
    }
   </cfscript> 
	 
   <!--- Setting the datatype --->
   <cfscript>
    if(objSnmpTrapManager.LastError eq 0){
      if(IsDefined("URL.datatype")){
        strDatatype = "string";
        switch(URL.datatype){
          case "string":
            objSnmpObject.Type = objConstants.asSNMP_TYPE_OCTETSTRING;
            strDatatype = "string";
          break;
          case "number":
            objSnmpObject.Type = objConstants.asSNMP_TYPE_INTEGER;
            strDatatype = "number";
          break;
        }
      }
    }
   </cfscript>	 
	 
   <!--- Setting the Value --->
   <cfscript>
    if(objSnmpTrapManager.LastError eq 0){
      strValue = "Hello world!";
      if(IsDefined("URL.value")){
        objSnmpObject.Value = URL.value;
        strValue = URL.value;
      }
    }
   </cfscript>
	 	 
	 <!--- Adding the trap and sending it --->
   <cfscript>
    if(objSnmpTrapManager.LastError eq 0){
      
      objSnmpTrapManager.Sleep(200);
		 
      strHost = "localhost";
      strCommunity = "public";

      if(IsDefined("URL.host") and IsDefined("URL.community"))
      {
        strHost = URL.host;
        strCommunity = URL.community;		 
      }

      objSnmpTrap.Host = strHost;
      objSnmpTrap.Community = strCommunity;
      objSnmpTrap.AddObject ( objSnmpObject );

      objSnmpTrapManager.Send(objSnmpTrap);
    }
   </cfscript>
	 
	 <!--- Echo the results --->
   <cfscript>
     intErrorNo = objTrapManager.LastError;
     strErrorDescr = objTrapManager.GetErrorDescription(objTrapManager.LastError);	 
   </cfscript>
	 
</cfif>

<cfoutput>

</head>
<body>

<form method=get>

<h2>ActiveSocket SNMP-Traps Sample<br>Using ColdFusion</h2>

<table class=table>
 <tr>
  <td width=150>Host:</td>
  <td><input class=input type=text name=host value="#strHost#"></td>
 </tr>
 <tr>
  <td>Community:</td>
  <td><input class=input type=text name=community value="#strCommunity#"></td>
 </tr>
 <tr>
  <td>Snmp Version:</td>
  <td>
    <cfif intVersion eq "1">
     <select class=input name=version>
       <option value="1">SNMP V1</option>
       <option value="2">SNMP V2 (Default)</option>
     </select>
    <cfelse>
     <select class=input name=version>
       <option value="2">SNMP V2 (Default)</option>
       <option value="1">SNMP V1</option>
     </select>		
    </cfif>
  </td>
 </tr>
 <tr>
  <td>Enter an OID:</td>
  <td><input class=input type=text name=oid value="#strOid#"></td>
 </tr>
 <tr>
  <td>OID Datatype:</td>
  <td>
    <cfif strDatatype eq "string">
     <select class=input name=datatype>
       <option value="string">String</option>
       <option value="number">Number</option>
     </select>
    <cfelse>
     <select class=input name=datatype>
       <option value="number">Number</option>
       <option value="string">String</option>	 
     </select>
   </cfif>	 
  </td>
 </tr>
 <tr>
  <td>Value</td>
  <td><input class=input type=text name=value value="#strValue#"></td>
 </tr>
 <tr>
  <td>&nbsp;</td>
  <td><input class=input type=submit name=submitbutton value="Send trap!"></td>
 </tr>      
</table>
</form>

<br>

<table class=table>
 <tr>
  <td>
   <b>Results:</b> #intErrorNo# : #strErrorDescr#
  <td>
 </tr>
</table>

<br>

<a href="http://www.activexperts.com">This sample is using ActiveXperts Software</a>.

</body>
</html>

</cfoutput>
