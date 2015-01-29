<cfset vfscolumnList="enabled,limit,used,free"/>

<cfset appTracker = createObject( 'java', 'coldfusion.runtime.ApplicationScopeTracker' ) />
<cfset allAppKeysIt=appTracker.getApplicationKeys()/>
<cfset sessiontracker = createObject("java","coldfusion.runtime.SessionTracker")/>

<cfset appSizes=queryNew("appname,url,"&vfscolumnList,'varchar,varchar,varchar,Integer,Integer,Integer')/>

<cfset totalAppCount=0>
<cfloop condition="#allAppKeysIt.hasNext()#">
  	<cfset k=allAppKeysIt.next()/>
	.<cfset totalAppCount++>
	<cfflush>
</cfloop>

<cfset allAppKeysIt=appTracker.getApplicationKeys()/>
<cfset doneCount=1/>

<cfloop condition="#allAppKeysIt.hasNext()#">
	<cfset k=allAppKeysIt.next()/>
	<cfset appScope=appTracker.getApplicationScope(k)/>

	<cfhttp url="http://193.133.125.6/utils/ramBrowser/sizeOfApp.cfm?appName=#appScope.applicationname#"
		timeout="10"
		result="res"
	/>

	<cfset queryAddRow(appSizes)/>
	<cfset querySetCell(appSizes,'appname',appScope.applicationname)/>
	<cfset querySetCell(appSizes,'url','browseApp.cfm?appName='&appScope.applicationname)/>
	<cfset colNum=1/>
	<cfloop list="#vfscolumnList#" index="col">
		<cfset querySetCell(appSizes,col, listGetAt(res.filecontent,colNum) )/>
		<cfset colNum++/>
	</cfloop>

	<!---cfoutput>#doneCount#/#totalAppCount# #appScope.applicationname# #res.filecontent#</cfoutput--->
	<cfset doneCount++/>
</cfloop>

<cfquery dbtype="query" name="q">
	select *
	from appSizes
	where used>0
	order by used desc
</cfquery>

<p>

<table>
<tr>
	<th>name</th>
	<th>free</th>
	<th>limit</th>
	<th>used</th>
</tr>
<cfoutput query="q">
	<tr>
		<td>#q.appName#</td>
		<td>#numberformat(q.free/1024)#k</td>
		<td>#numberformat(q.limit/1024)#k</td>
		<td>#numberformat(q.used/1024)#k</td>
		<td><a href="#q.url#">browse</a></td>
	</tr>
</cfoutput>
</table>

<p>

<cfoutput>#q.recordCount#/#doneCount# apps have RAM disk use</cfoutput>