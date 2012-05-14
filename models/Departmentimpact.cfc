 <cfcomponent extends="Model">
		<cffunction name="init"> 
        	<cfset belongsTo("department")>
        	<cfset belongsTo("impact")>
        </cffunction>
</cfcomponent>