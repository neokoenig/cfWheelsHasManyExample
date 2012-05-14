 <cfcomponent extends="Model">
    <cffunction name="init"> 
        <cfset hasMany("departmentImpacts")>
        <cfset nestedProperties(associations="departmentimpacts", allowDelete=true, shortcut="departments")>  
    </cffunction>
</cfcomponent>