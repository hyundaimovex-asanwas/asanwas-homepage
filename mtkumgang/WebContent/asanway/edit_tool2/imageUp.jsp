<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.imjk.util.ParamUtil"%>

<%
    String saveDirName    	= ParamUtil.getReqParameter(request.getParameter("saveDirName"));

%>

<HTML>
<HEAD>
<TITLE> 그림 삽입 </TITLE>
<script language=javascript>
<!--
  function sendit(){
  var imgCapacity = document.all.tempImg.fileSize;
  if(imgCapacity > 1024*1024){   
    alert("이미지의 사이즈는 1M로 제한합니다.");
    document.form.filename.focus();
    return false;
  }else if(imgCapacity < 0){
    alert("이미지파일은 gif,jpg만 가능합니다.");
    document.form.filename.focus();
    return false;
  }  
     
  if(document.form.filename.value==""){
    alert("이미지를 선택하세요");
    document.form.filename.focus();
    return false;
  }
  if (!CheckImageFile()){
    alert("이미지파일은 gif,jpg만 가능하며\n한글이름은 지원하지 않습니다.");
    document.form.filename.focus();
    return false;
  }
  
  var realFileName = document.form.filename.value;
  var idx = realFileName.lastIndexOf("\\");
	realFileName = realFileName.substring(idx+1);
  document.form.realFileName.value=realFileName;
  //alert(document.form.saveDirName.value);
  document.form.submit();
	
/*var ImageFile = "";
  ImageFile = document.form.filename.value;
  var ext = ImageFile.split("\\");

	var ImgInfo;
//  ImgInfo = opener.parent.parent.main.board.imgInfo.value + ext[ext.length-1];
  ImgInfo = opener.form.imgInfo.value + ext[ext.length-1];

  var ImgLen = ImgInfo.split(".");
  var ImgLenCnt = ImgLen.length;
  if (ImgLenCnt > 10){
    alert("이미지를 더이상 추가하실수 없습니다.");
    window.close();
    return false;
  }else{
    document.form.submit(); 
  }
*/
}

function CheckImageFile()
{
  var ImageFile = document.form.filename.value;
  var extFile = ImageFile.split("\\");
  var ImgInfo = extFile[extFile.length-1];
  var ext = ImgInfo.split(".");
    if (ext[1].toUpperCase() == "JPG" || ext[1].toUpperCase() == "GIF"){
      if (isKorean(ext[0])){
        return true;
      }else{
        return false;
      }
    }else
      return false;
}

function isKorean(ch) 
{
   var numUnicode = ch.charCodeAt(0);                                                                                    
   if ( 44032 <= numUnicode && numUnicode <= 55203 ) return false;            
   return true;
}

function Imgview () {
  document.all.tempImg.src = "";
  document.all.tempImg.src = document.form.filename.value;
  if (document.all.tempImg.src != ""){
	  document.all.viewer.style.display = "";
	}
}

-->
</script>
</head>
<body bgcolor="#aaaaaa" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="document.form.filename.focus()">
<form name="form" action="image_save.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="realFileName">
<input type="hidden" name="saveDirName" value=<%=saveDirName%>>


<p align=center><br>
	<font size=2><b>이미지를 선택해주세요.</b></font><br>
	<table border=1 width="100" height="100" cellspacing=0 cellpadding=0 bordercolor=Black>
		<tr id="viewer" style="display:none" height="100">
			<td align=center><img src="" id="tempImg" height="100"> </td>
		</tr>
	</table><br>
<TABLE border=0 cellpadding=0 cellspacing=0>
<TR>
  <TD><input type="file" name="filename" style="BORDER-RIGHT: #486b70 1px solid; BORDER-TOP: #486b70 1px solid; BORDER-LEFT: #486b70 1px solid; BORDER-BOTTOM: #486b70 1px solid" 
      onFocus="Imgview()"><FONT 
      size=2></FONT></TD>
</TR>
<TR>
  <TD align=middle style="PADDING-TOP: 10px"><INPUT TYPE=button value="사진삽입" name="bt" OnClick="sendit()">&nbsp;<INPUT TYPE=button value=" 닫기 " OnClick="window.close()"></TD></TD>
</TR>
</TABLE>
</form>
</p>
</body>
</HTML>