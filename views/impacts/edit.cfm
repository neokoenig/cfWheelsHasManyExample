<!--- Impact Edit / Add Form --->

<!--- We need an impact object, and the list of 
departments to use in the hasMany Checkboxes--->
<cfparam name="Impact">
<cfparam name="departments">

<cfoutput>
<cfif params.action EQ "edit">
	<h1>Edit Impact</h1> 
	<!--- I prefer to post to /impacts/update/[key], 
	rather than having to remember a hidden form field --->
	#startFormTag(action="update", route='admin', controller='Impacts', key=impact.id)#
<cfelse>
	<h1>Add New Impact</h1>
	#startFormTag(action="create", route='admin', controller='Impacts')#
</cfif>

<!--- Model error msg output--->
#errorMessagesFor("Impact")#

<!--- Main fields for the Impact etc.. --->   
#textField(objectName="Impact", property="name", label="Name")#
 
<!--- The clever bit - hasMany checkboxes

	This should output something like this for a new Impact, checkbox for Department ID 37;
	
	<label class="checkbox" for="Impact-departmentImpacts--37-_delete">
		Department Name for ID 37
		<input id="Impact-departmentImpacts--37-_delete" type="checkbox" value="0" name="Impact[departmentImpacts][,37][_delete]">
		<input id="Impact-departmentImpacts--37-_delete-checkbox" type="hidden" value="1" name="Impact[departmentImpacts][,37][_delete]($checkbox)">
	</label>
	
	If editing Impact (ID 20), then we'll get something like
	
	<label class="checkbox" for="Impact-departmentImpacts-20-4-_delete">
		Department Name for ID 4
		<input id="Impact-departmentImpacts-20-4-_delete" type="checkbox" value="0" name="Impact[departmentImpacts][20,4][_delete]" checked="checked">
		<input id="Impact-departmentImpacts-20-4-_delete-checkbox" type="hidden" value="1" name="Impact[departmentImpacts][20,4][_delete]($checkbox)">
	</label>
	
	note the impactid being passed in to complete the composite ID.	

--->
<cfloop query="departments">  
#hasManyCheckBox(
	objectName="Impact", 
	association="departmentImpacts", 
    keys="#Impact.key()#,#id#", 
    label=name)#
</cfloop>

#submitTag()#
#endFormTag()# 
</cfoutput>