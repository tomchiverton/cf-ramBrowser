<cfparam name="url.path" default="/"/>

<cfdirectory action="list"
	directory="ram://#url.path#"
	name="dir"
	/>

<cfset partSoFar='/'/>
<cfoutput>
App : <a href="index.cfm">#url.appName#</a>

<a href="browseApp.cfm?appName=#url.appName#&path=/">ram:</a>///</cfoutput><cfloop list="#url.path#" index="part" delimiters="/"><cfoutput><a href="browseApp.cfm?appName=#url.appName#&path=#partSoFar##part#/">#part#</a>/</cfoutput><cfset partSofar&=part&'/'/></cfloop>
<p>
<table>
<cfoutput query="dir">
	<tr>
		<td>
			<cfif dir.type eq 'Dir'>
				<a href="browseApp.cfm?appName=#url.appName#&path=#url.path##dir.name#/">
				#dir.name#
				</a>
			<cfelse>
				<a href="browseAppSendFile.cfm?appName=#url.appName#&path=#url.path#/&name=#dir.name#">
				#dir.name#
				</a>
			</cfif>
		</td>
		<td>#dir.DateLastModified#</td>
		<td>#numberFormat(dir.size/1024)#k</td>
		<td>
			<cfif dir.type eq 'file'>
				<a href="del.cfm?appName=#url.appName#&path=#url.path#/&name=#dir.name#">DEL</a>
			</cfif>
		</td>
	</tr>
</cfoutput>
</table>