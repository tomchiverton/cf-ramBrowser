<cfset vfscolumnList="enabled,limit,used,free"/>

<cfset vfs=getVFSMetaData('ram')/>
<cfset vfsval=''/>
<cfloop list="#vfscolumnList#" index="col">
	<cfset vfsval=listAppend(vfsval, vfs[col] )/>
</cfloop>

<cfcontent reset="true"/><!---cfoutput>#vfscolumnList##chr(13)##chr(10)#</cfoutput--->
<cfoutput>#vfsval#
</cfoutput>