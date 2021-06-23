<!--#include virtual = "include/dbconnection.asp"-->
<!--#include virtual="include/common_function.asp"-->
<%
Set objUpload = server.CreateObject("DEXT.FileUpload")
DownLoadFolder = "\img_etc\"
objUpload.DefaultPath = server.mappath("../../") & "\img_etc\"


file_name		= objUpload("filename").filename



if file_name <> "" then	
	mimetype = objUpload("filename").MimeType 
	If mimetype="image/gif" or mimetype="image/pjpeg" Then 
		filepath = objUpload.DefaultPath & "\" & file_name
		filepath = GetUniquePath(objUpload,filepath,file_name)
		strfilename = GetUniqueName(filepath,DownLoadFolder)					
		objUpload("filename").SaveAs filepath
	else
		Response.write "<script>"
		Response.write "alert('확장자가 gif나 jpg파일만 업로드가 가능합니다.');"
		Response.write "history.back();"
		Response.write "</script>"
		Response.End	
	end if		
end if

'strfilename = trim(strfilename)

set fs = createobject("scripting.filesystemobject")
set fl = fs.GetFile(objUpload.DefaultPath & "\" & strfilename)
strfname = fl.name


%>
<script language=javascript>
		parent.opener.setImage('<%=strfname%>','center','bottom');
		self.close();
</script>