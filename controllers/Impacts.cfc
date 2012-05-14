 <cfcomponent extends="Controller">
 <cffunction name="init"> 
  <cfscript>
   // I tend to use filters to prevent having to do model("department").findAll() calls all the time
   // I've removed authentication for delete /admin methods in this example
   filters(through="getAllDepartments", except="index");
  </cfscript>
 </cffunction>
    
<!---------------------------------------------------------------Public----------------------------------------------------------------->
     
<cffunction name="view" hint="View a single Impact Entry">
    <cfscript>
     impact=model("impact").findOne(where="id = #params.key#", include="departmentimpacts");
    if( NOT isObject(impact)){
        flashinsert(error="Sorry, that entry couldn't be found");
        redirectTo(route="home");
    }
    </cfscript>        
</cffunction> 
    
<!---------------------------------------------------------------Admin----------------------------------------------------------------->
<cffunction name="index" hint="Admin Index"> 
	<cfset impacts = model("impact").findAll(order="name ASC", returnAs="query")>
</cffunction>

<cffunction name="add" hint="Add New Impact">
	<cfscript>
		impact = model("impact").new();
		// I use the same edit/add forms where possible
		renderPage(action="edit");
    </cfscript>
</cffunction>

<cffunction name="create" hint="Create New Impact">
	<cfscript>
        impact=model("impact").create(params.impact);	  
        if (impact.hasErrors()){
			renderPage(action="edit");
        }
        else {
			flashInsert(success="impact Entry #params.impact.name# created successfully.");
			redirectTo(route='admin', controller='impacts', action='index');
        }
    </cfscript>
</cffunction> 

<cffunction name="edit" hint="Edit Existing Impact">    
	<cfset impact = model("impact").findOne(Where="id =#params.key#", include="departmentimpacts")>
</cffunction>

<cffunction name="update" hint="Update Existing Impact">  
	<cfscript>
    impact = model("impact").findOne(where="id = #params.key#", include="departmentimpacts");
    if(isobject(impact)){
		impact.update(params.impact);
		if(impact.hasErrors()){
			renderimpact(action="edit", key=impact.id);
			}
		else {
			flashInsert(success="impact Entry #impact.name# updated successfully.");
			redirectTo(route='admin', controller='impacts', action="index");     
		}
    }
    else
    {
		flashInsert(error="Impact not returned as object?");
		redirectTo(back=true); 
    };
    </cfscript>
</cffunction>

<cffunction name="delete" hint="Soft Delete Impact">
	<cfscript>
        impact = model("impact").findByKey(params.key);
        impact.delete();
        flashInsert(success="#impact.name# was successfully deleted.");
        redirectTo(action="index");
    </cfscript>
</cffunction> 
    
<!---------------------------------------------------------------Private----------------------------------------------------------------->  
<cffunction name="getAllDepartments" access="private">
    <cfset departments=model("department").findAll(order="name")>
</cffunction> 
    
</cfcomponent>