<%@ page import= "java.util.*,java.net.*,java.lang.*,java.io.*, java.text.NumberFormat,java.lang.Runtime" errorPage="dir_error.jsp" contentType="text/html;charset=euc-kr"%>
<%@ page import="com.hmm.ejb.common.*" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ include file="dir_config.inc" %>
<%
	String h_path = request.getParameter("h_path");
	if(h_path == null){
		h_path = "";
	}
	String path = g_path + h_path;
	File fck_file = new File(path);
	File dirfiles[];
	String prepath = "/";

	Vector v_dir = new Vector();
	Vector v_file = new Vector();
	Vector v_dir_leng = new Vector();
	Vector v_file_leng = new Vector();
	
	dirfiles = fck_file.listFiles();
	
	if(dirfiles != null)
	{
		Arrays.sort(dirfiles);
		for(int k = 0 ; k < dirfiles.length; k++)
		{
			if (dirfiles[k].isDirectory())
			{	
				v_dir.add(dirfiles[k].getName());
				v_dir_leng.add(String.valueOf(dirfiles[k].length()));
			}
			else
			{
				v_file.add(dirfiles[k].getName());
				v_file_leng.add(String.valueOf(dirfiles[k].length()));
			}
		}
	}

	StringTokenizer tok = new StringTokenizer(fck_file.getPath(),"/");
	String tok_link="",tok_dir="",tok_godir="/";
	while (tok.hasMoreTokens())
	{
		tok_dir = tok.nextToken()+"/";
		tok_godir = tok_godir + tok_dir;
		tok_link = tok_link + "<a href='dir_Filelist.jsp?path="+tok_godir+"'>"+tok_dir+"</a>";
	}
%>

<HTML>
<HEAD>
<TITLE> 이미지 업로드 </TITLE>
<link rel="stylesheet" href="/css/asan.css" type="text/css">
<!--link rel="stylesheet" href="/asanway/css/style.css" type="text/css"-->
<script>
function EDIT(mode){
	var msg = "";
	msg = "'" + document.selform.h_newdir.value + "'디렉토리를 생성하시겠습니까?";

	if(confirm(msg) == true){
		document.selform.action = "dir_Dirmake.jsp";
		document.selform.h_mode.value = mode;
		document.selform.submit();
	}
}

function showWin(type){
	if(type == "UPLOAD")
	{
		document.all.UPLOAD.style.display="";
		document.all.MKDIR.style.display="none";		
		document.upform.upfile.focus();
	} else
	if(type == "MKDIR")
	{
		document.all.UPLOAD.style.display="none";
		document.all.MKDIR.style.display=""		
		document.selform.h_newdir.focus();
	}
}

function doCheck(val){
	var cnt = eval(document.selform.selcount.value);

	if(val == true){
		document.selform.selcount.value = eval(cnt + 1);
	} else {
		document.selform.selcount.value = eval(cnt - 1);
	}
}

function upFile()
{
	if(document.upform.upfile.value == "")
	{
		alert("! 업로드할 파일을 선택하세요.");
		document.upform.upfile.focus();
		return;
	}
	else {
		document.upform.submit();
	}
}

function OpenFile( fileUrl )
{
	
	window.top.opener.SetUrl( fileUrl ) ;
	window.top.close() ;
	window.top.opener.focus() ;
}
</script>
</HEAD>

<BODY topmargin="10" leftmargin="10" bgcolor="#FCFCF6">
<center>

<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="500" bgcolor="#234790">
<tr>
	<td valign=bottom style="padding-left:10px;padding-bottom:4px"><B><FONT SIZE="3" COLOR="white">이미지 업로드</FONT></B><!-- <img src="/img/common/pop_tit_03.gif"> --></td>
	<td align="right"><img src="/img/common/pop_logo.gif"></td>
</tr>
</table>

<!----- Title----->
<table border="0" cellpadding="0" cellspacing="0" width="500" height="10"><tr><td></td></tr></table>

<!----- Box----->
<table border="0" cellpadding="0" cellspacing="0" width="500" height="100" bgcolor="#F1F1DB">
<tr>
	<td height="8"><img src="/img/common/pop_box500_top.gif"></td>
</tr>
<tr><td height="10"></td></tr>
<tr>
	<td align="center">

		<TABLE>
		<TR>
		<TD>
			<TABLE cellpadding=0 cellspacing=0 border=0 width=470>
			<TR bgcolor="#D0D0B9" height=3><TD colspan=3></TD></TR>
			<TR bgcolor="#D0D0B9">
				<TD width=5></TD>
				<TD><li><font color=black><b><font color=darkblue>/<%=h_path%></font> 이미지 업로드 목록</b></font> <!--134.100.2.233--></TD>
				<TD align=right>
					<a href="javascript:showWin('UPLOAD');"><img src="/FCKeditor/editor/skins/default/toolbar/image.gif" alt="이미지업로드" border=0></a>&nbsp;
<%
	if(1==2 && (h_path == null || h_path.equals(""))){
%>
					<a href="javascript:showWin('MKDIR');"><img src="/FCKeditor/editor/skins/default/toolbar/directory.gif" alt="디렉토리생성" border=0></a>&nbsp;
<%
	}
%>
				</TD>
			</TR>
			</TABLE>
			<table border="0" cellpadding="0" cellspacing="0" height="8"><tr><td></td></tr></table>

			<TABLE cellpadding=0 cellspacing=0 border=0 width=440>
<%
	if(h_path != null && !h_path.equals("")){
%>
			<TR height=22>
				<TD width=20></TD>
				<TD width=20><img src='/FCKeditor/editor/filemanager/browser/default/images/Folder.gif'></TD>
				<TD width=350><A HREF="./dir_Filelist.jsp"><B>..</B></A></TD>
				<TD width=100 align=right></TD>
			</TR>
<%
	}
%>
			<form name='selform' action='dir_Filelist.jsp' method='post'>
			<input type=hidden name='h_mode' value=''>
			<input type=hidden name='h_path' value='<%=h_path%>'>
<%
	if(dirfiles != null)
	{
		// 디렉토리 리스트
		for (int i = 0; i < v_dir.size() ; i++)
		{
%>
			<TR height=22>
				<TD width=20></TD>
				<TD width=20><img src='/FCKeditor/editor/filemanager/browser/default/images/Folder.gif'></TD>
				<TD width=350><A HREF="./dir_Filelist.jsp?h_path=<%=v_dir.get(i)%>"><B><%=v_dir.get(i)%></B></A></TD>
				<TD width=100 align=right><B><%=v_dir_leng.get(i)%></B>&nbsp;bytes &nbsp;</TD>
			</TR>
<%
		}
		
		// 파일 리스트
		for (int i = 0; i < v_file.size() ; i++)
		{
			String fname = v_file.get(i) + "";

			tok = new StringTokenizer(fname,".");
			while(tok.hasMoreTokens()) {
				fname = tok.nextToken();
			}

			if (fname.equals("jpg") || fname.equals("gif") || fname.equals("bmp") || fname.equals("tif") || fname.length()==0)
			{
%>
			<TR height=22>
				<TD width=20></TD>
				<TD width=20><a href="#" onclick="OpenFile('<%=g_path_web%><%=h_path%>/<%=v_file.get(i)%>');return false;"><img src='/FCKeditor/editor/filemanager/browser/default/images/icons/<%=fname%>.gif' border=0></a></TD>
				<TD width=350>
<%
			String s_filesize = v_file_leng.get(i) + "";
			int filesize = Integer.parseInt(s_filesize);
%>
					<!--img src='<%=g_path_web%>/<%=v_file.get(i)%>' style="border:1" width=20 height=20-->
					<a href="#" onclick="OpenFile('<%=g_path_web%><%=v_file.get(i)%>');return false;"><%=v_file.get(i)%></a>
				</TD>
				<TD width=100 align=right><B><%=v_file_leng.get(i)%></B>&nbsp;bytes &nbsp;</TD>
			</TR>
<%
			}
		}
	}
%>
			<TR>
				<TD colspan=4 height=10></TD>
			</TR>
			</TABLE>		
		</TD>
		</TR>
		</form>
		</TABLE>
	</td>
</tr>
<tr><td height="25"></td></tr>
<tr>
	<td height="8"><img src="/img/common/pop_box500_bottom.gif"></td>
</tr>
</table>
<!----- //Box----->


<!-------------------------------------  디렉토리 생성 -------------------------------------->
<div id="MKDIR" style="display:none;position:absolute;left:206;top:120">
	<table cellpadding="0" cellspacing="1" bgcolor="slategray">
		<tr height="18">
			<td align="right" style="padding-right:5;">
				<TABLE cellpadding=0 cellspacing=0 width=100%>
				<TR>
					<TD>&nbsp; <font color='white'>☞ 생성할 디렉토리명을 입력하세요</font></TD>
					<TD align=right><img src="/img/common/icon_close.gif" style="cursor:hand" onClick="javascript:document.all.MKDIR.style.display='none';" WIDTH="12" HEIGHT="11"></TD>
				</TR>
				</TABLE>
			</td>
		</tr>
		<tr>	
			<td bgcolor="white" height=80 style="padding-left:30;padding-right:30;padding-bottom:10;padding-top:5">
				<TABLE cellpadding=0 cellspacing=0 width=100%>
				<TR>
					<TD><input name="h_newdir" value='' style="width:140; height:18; padding:2; border:1 solid slategray">  </TD>
					<TD valign=bottom>&nbsp;<input type=button value='생성하기' onclick="javascript:EDIT('MKDIR');">&nbsp;</TD>
				</TR>
				</TABLE>
			</td>
		</tr>
	</table>
</div>

<!-------------------------------------  파일 업로드 ----------------------------------------->
<div id="UPLOAD" style="display:none;position:absolute;left:64;top:120">
	<table cellpadding="0" cellspacing="1" bgcolor="slategray">
	<form action="dir_Fileupload.jsp" name="upform" method="post" enctype="multipart/form-data">
	<input type='hidden' name='h_mode' value='UPLOAD'>
	<input type='hidden' name='h_view' value=''>
	<input type='hidden' name='h_path' value='<%=h_path%>'>
		<tr height="18">
			<td align="right" style="padding-right:5;">
				<TABLE cellpadding=0 cellspacing=0 width=100%>
				<TR>
					<TD>&nbsp; <font color='white'>☞ 업로드할 이미지를 선택하세요</font></TD>
					<TD align=right><img src="/img/common/icon_close.gif" style="cursor:hand" onClick="javascript:document.all.UPLOAD.style.display='none';" WIDTH="12" HEIGHT="11"></TD>
				</TR>
				</TABLE>
			</td>
		</tr>
		<tr>	
			<td bgcolor="white" height=70 style="padding-left:30;padding-right:30;padding-bottom:10;padding-top:5">
				<TABLE>
				<TR>
					<TD colspan=2><input type='file' name="upfile" style="width:300; height:18; padding:2; border:1 solid slategray"> <input type=button value='업로드' onclick="javascript:upFile();"></TD>
				</TR>
				</TABLE>
			</td>
		</tr>
	</form>
	</table>
</div>

</BODY>
</HTML>
