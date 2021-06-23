<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<FORM METHOD=POST ACTION="tour_review_proc.jsp">
<INPUT TYPE="hidden" name="cmd" value="insert">
<table width="640" border="1">
  <tr> 
    <td width="405">제목 
      <input type="text" name="title">
    </td>
  </tr>
  <tr> 
    <td width="405">내용 
      <textarea name="content" cols="50" rows="10"></textarea>
    </td>
  </tr>
  <tr> 
    <td width="405"><INPUT TYPE="submit"></td>
  </tr>
 
</table>
</FORM>
</BODY>
</HTML>
