<!---
	CFCBlaster Copyright (C) 2006 Mike Rankin
	
	This program is free software; you can redistribute it and/or modify it 
	under the terms of the GNU General Public License as published by the Free 
	Software Foundation; either	version 2 of the License, or (at your option) 
	any later version.

	This program is distributed in the hope that it will be useful, but WITHOUT
	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
	FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for 
	more details.

	You should have received a copy of the GNU General Public License along 
	with this program; if not, write to the Free Software Foundation, Inc., 
	59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
--->

<cfapplication name="cfcBlaster" applicationtimeout="#createTimespan(0,2,0,0)#"
				clientmanagement="false" sessionmanagement="false">
				
				
<!--- cfapplication is set up primarily to name the application for logging purposes.
	at this time, there really isn't much in the way of application that needs to be
	managed. If I make a change, what happens to the svn repository?
--->

<!--- Ok, maybe we add a few udfs here --->
<cfinclude template="lib_cfscript.cfm">
<cffunction name="argType">
	<cfargument name="column" required="true" type="string" />
	<cfargument name="data_type" required="true" type="string" />
	<cfset var arg = "" />
	<cfswitch expression="#arguments.data_type#">
		<cfcase value="varchar,char">
			<cfset arg = '		~cfargument name="#arguments.column#" required="false" default="" type="string" />#chr(13)##chr(10)#'>
		</cfcase>
		<cfcase value="int,tinyint">
			<cfset arg = '		~cfargument name="#arguments.column#" required="false" default="0" type="numeric" />#chr(13)##chr(10)#'>
		</cfcase>
		<cfcase value="bit">
			<cfset arg = '		~cfargument name="#arguments.column#" required="false" default="false" type="boolean" />#chr(13)##chr(10)#'>
		</cfcase>
		<cfcase value="datetime">
			<cfset art = '		~cfargument name="#arguments.column#" required="false" default="" type="date" />#chr(13)##chr(10)#'>
		</cfcase>
	</cfswitch>
	<cfreturn arg />
</cffunction>

<cffunction name="queryParamType">
	<cfargument name="column" required="true" type="string" />
	<cfargument name="data_type" required="true" type="string" />
	<cfargument name="is_nullable" required="true" type="string" />
	<cfargument name="maxLength" required="true" type="string" />
	<cfargument name="scale" required="true" type="string" />
	<cfset var qparam = "" />
	<cfswitch expression="#arguments.data_type#">
		<cfcase value="varchar,char,ntext">
			<cfif arguments.is_nullable is 'yes'>
				<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_#arguments.data_type#" maxLength="#arguments.maxLength#" null="##NOT len(trim(get#column#()))##" />'>
			<cfelse>
				<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_#arguments.data_type#" maxLength="#arguments.maxLength#" />'>
			</cfif>
		</cfcase>
		<cfcase value="int">
			<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_integer" />'>
		</cfcase>
		<cfcase value="tinyint,smallint">
			<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_#arguments.data_type#" />'>
		</cfcase>
		<cfcase value="bit">
			<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_#arguments.data_type#" />'>
		</cfcase>
		<cfcase value="datetime">
			<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_date" />'>
		</cfcase>
		<cfcase value="float,real">
			<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_#arguments.data_type#" />'>
		</cfcase>
		<cfcase value="numeric,decimal">
			<cfset qparam = '~cfqueryparam value="##arguments.obj.get#arguments.column#()##" cfsqltype="cf_sql_#arguments.data_type#" scale="#arguments.scale#" />'>
		</cfcase>
	</cfswitch>
	<cfreturn qparam />
</cffunction>

<cffunction name="cfDataType" output="false">
	<cfargument name="sqlDatatype" required="true" type="string" />
	<cfswitch expression="#arguments.sqlDatatype#">
		<cfcase value="varchar,char,nvarchar,nchar,text,ntext">
			<cfreturn "string" />
		</cfcase>
		<cfcase value="int,tinyint,real,float">
			<cfreturn "numeric" />
		</cfcase>
		<cfcase value="bit">
			<cfreturn "boolean" />
		</cfcase>
		<cfcase value="datetime">
			<cfreturn "date" />
		</cfcase>
		<cfcase value="image">
			<cfreturn "binary" />
		</cfcase>

	</cfswitch>
</cffunction>


<!--- Get current platform file separator so paths can be built on different platforms --->
<cffunction name="getFileSeparator" output="false">
	<cfset var fileObj = ""/>
	<cfif isDefined("application._fileSeparator")>
		<cfreturn application._fileSeparator />
	<cfelse>
		<cfset fileObj = createObject("java","java.io.File") />
		<cfset application._fileSeparator = fileObj.separator />
		<cfreturn getFileSeparator()/>
	</cfif>
</cffunction>

<!--- Set profile path --->
<cffunction name="getProfilePath" output="false">
	<cfif isDefined("application._profilePath")>
		<cfreturn application._profilePath />
	<cfelse>
		<cfset application._profilePath = getDirectoryFromPath(getCurrentTemplatePath()) & 'setup.ini'/>
		<cfreturn getProfilePath()/>
	</cfif>
</cffunction>

