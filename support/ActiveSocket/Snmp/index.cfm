<cfoutput>
<html>

<head>
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
<!--- creating the object --->
<cfobject class="ActiveXperts.SnmpManager" type="com" name="objSnmpManager" Action="Create">

<cfscript>

getvars();

if(IsDefined("URL.getnext") eq "true"){
   snmpget("getnext", strOid);
}
else{
	 snmpget("dontgetnext", strOid);
}


function getvars(){

    strOid = "system.sysName.0";
    strHost = "localhost";
    strCommunity = "public";
    strPort = 161;
    strVersion = 2;
    strLogFile = "";
    strValue = "";
		
    if(IsDefined("URL.oid")){
     if(URL.oid neq ""){
		  strOid = URL.oid;
		 }
		}
    if(IsDefined("URL.host")){
     if(URL.host neq ""){
      strHost = URL.host;
     }
    }
    if(IsDefined("URL.community")){
     if(URL.community neq ""){
      strCommunity = URL.community;
     }
    }
    if(IsDefined("URL.port")){
     if(URL.port neq ""){
      strPort = URL.port;
     }
    }
    if(IsDefined("URL.version")){
     if(URL.version neq ""){
      strVersion = URL.version;
		 }
    }
    if(IsDefined("URL.logfile")){
     if(URL.logfile neq ""){
      strLogFile = URL.logfile;
     }
    }

}

function snmpget(getnext, OID){

   objSnmpManager.LogFile = strLogFile;
   objSnmpManager.Initialize();
   objSnmpManager.ProtocolVersion = strVersion;
   
   if(objSnmpManager.LastError eq 0){
      objSnmpManager.Open(strHost,strCommunity,strPort);
   }

   if(objSnmpManager.LastError eq 0){
     objSnmpObject = objSnmpManager.get(OID);
     if (getnext eq "getnext") {
       objSnmpObject = objSnmpManager.getnext();
     }
	   
     }
	 
     if(objSnmpManager.LastError eq 0){

     strOid = objSnmpObject.oid;
     strValue = objSnmpObject.value & "<br>";
		 
     }

     strResult = objSnmpManager.LastError & " : " & objSnmpManager.GetErrorDescription(objSnmpManager.LastError);
	 
     objSnmpManager.Close();
     objSnmpManager.Shutdown();	 
}

</cfscript>

<cfoutput>

</head>

<body>

<h2>ActiveSocket ColdFusion Sample (SNMP)</h2>
<form>
<table class="table">
 <tr>
  <td width=150>Host:</td>
  <td><input class="input" type=text name=host value="#strHost#"></td>
 </tr>
 <tr>
  <td>Community:</td>
	<td><input class="input" type=text name=community value="#strCommunity#"></td>
 </tr>
 <tr>
  <td>Port:</td>
	<td><input class="input" type=text name=port value="#strPort#"></td>
 </tr>
 <tr>
  <td>Version:</td>
	<td>
	 <cfif strVersion eq 2>
   <select name=version class="input">
    <option value="2">Snmp v2 (default)</option>
    <option value="1">Snmp v1</option>
   </select>
	 <cfelse>
   <select name=version class="input">
    <option value="1">Snmp v1</option>
    <option value="2">Snmp v2 (default)</option>		
   </select>	 
	 </cfif>
	</td>
 </tr> 
 <tr>
  <td>OID:</td>
	<td><input class="input" type=text name=oid value="#strOid#"></td>
 </tr>
 <tr>
  <td>Logfile:</td>
	<td><input class="input" type=text name=logfile value="#strLogfile#"></td>
 </tr>
 <tr>
  <td>&nbsp;</td>
	<td><input class="input" type=submit value="Get"></form></td>
 </tr>
 <tr>
  <td>&nbsp;</td>
	<td>
   <form>
    <input type=hidden name=oid value="#strOid#">
		<input type=hidden name=host value="#strHost#">
		<input type=hidden name=community value="#strCommunity#">
		<input type=hidden name=port value="#strPort#">
		<input type=hidden name=logfile value="#strLogfile#">
		<input type=hidden name=Version value="#strVersion#">
		<input type=hidden name=getnext value="true">					
		<input type=submit value="Get next!" class=input>
   </form>
	</td>
 </tr>
</table>

<br>

<table class=table>
  <tr>
	  <td><b>#strOid#:</b><br>#strValue#</td>
	</tr>
</table>

<br>

<table class=table>
  <tr>
	  <td><b>Result:</b><br>#strResult#</td>
	</tr>
</table>

<br>

<a href="http://www.activexperts.com">This sample is using ActiveXperts Software</a>.

</body>
</html>

</cfoutput>