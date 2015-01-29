<cfif listLast(url.name,'.') eq 'sql' or
	  listLast(url.name,'.') contains 'cf' or
	  listLen(url.name,'.') eq 1
>
	<cfset contents=fileRead("ram://#url.path##url.name#")/>
	<cfset contents=replace(contents,'>','&gt;','all')/>
	<cfset contents=replace(contents,'<','&lt;','all')/>
	<cfset contents=replace(contents,chr(10),'<br>','all')/>
	<cfoutput>#contents#</cfoutput>
<cfelse>
	<cfcontent file="ram://#url.path##url.name#"/>
</cfif>
