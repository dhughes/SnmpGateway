<cfcomponent hint="Base for beans" output="false">
	<cffunction name="onMissingMethod">
		<cfargument name="missingMethodName" />
		<cfargument name="missingMethodArguments" />
		
		<cfset var name = "" />
		<cfset var propList = ""/>
		
		<!--- Create list of properties --->
		<cfset md = getMetaData(this)>
		<cfset propArray = md.properties/>
		<cfloop from="1" to="#arrayLen(propArray)#" index="item">
			<cfset propList = listAppend(propList,propArray[item].name,",")>
		</cfloop>
		
		<!--- Getters --->
		<cfif left(missingMethodName,3) is "get">
			<cfset name = right(missingMethodName,len(missingMethodName)-3) />
			<cfif listFindNoCase(propList,name)>
				<cfreturn variables.instance[name] />
			<cfelse>
				<cfthrow type="bean" message="Property #name# is not defined in component #md.name#.">
			</cfif>
			
		<!--- Setters --->
		<cfelseif left(missingMethodName,3) is "set">
			<cfset name = right(missingMethodName,len(missingMethodName)-3) />
			<cfif structIsEmpty(missingMethodArguments)>
				<cfthrow type="bean" message="The #uCase(name)# parameter to the get#name# function is required but was not passed in."/>
			<cfelseif NOT listfindNoCase(propList,name)>
				<cfthrow type="bean" message="The set#name#() method of the component #md.name# is not defined."/>
			<cfelse>
				<cfset evaluate("this.val#name#('" & missingMethodArguments[1] & "')")>
				<cfset evaluate("this.do#name#('" & missingMethodArguments[1] & "')")>
			</cfif>

			
		<!--- Doers --->
		<cfelseif left(missingMethodName,2) is "do">
			<cfset name = right(missingMethodName, len(missingMethodName)-2) />
			<cfset variables.instance[name] = missingMethodArguments[1]>
		
		<!--- Business Rule place holder --->
		<!--- if this method is not overriden in your component for each property,
				no business rules or format enforcement is taking place --->	
		<cfelseif left(missingMethodName,3) is "val">
			<!--- This should be overriden in your component --->
			<cfset name = right(missingMethodName, len(missingMethodName)-3) />
			
		<cfelse>

			<cfthrow type="Application"
				message="The method #missingMethodName# was not found in component #expandPath('/' & replace(md.name,'.','/','all'))#"
				detail="Make sure that you have defined the property using cfproperty." />

		</cfif>

	</cffunction>
</cfcomponent>