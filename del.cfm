<cfset contents=fileRead("ram://#url.path##url.name#")/>

<cfoutput>ram://#url.path##url.name#" <hr> #contents#</cfoutput>

<cfset fileDelete("ram://#url.path##url.name#")/>

<hr>
hone.