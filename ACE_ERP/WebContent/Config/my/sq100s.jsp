<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ��ü �޴� ��ȸ �� ���� ��û!
 * ���α׷�ID  	: SY140I
 * J  S  P   	: Sy140i
 * �� �� ��     : Sy120I
 * �� �� ��     : ������
 * �� �� ��     : 2006-09-10
 * �������     : �޴���ȸ ���� ��û
 * [ �������� ][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
        <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	

<style type="text/css">
<!--
	td
	{
		font:9pt ����;
		line-height: 160%;
	}
	th
	{
		font:9pt ����;
		line-height: 160%;
	}
	A:link     {font: bold 9pt "���� new"; color:#5A8AAD; text-decoration:none}
	A:active   {font: bold 9pt "���� new"; color:#36618A; text-decoration:none}
	A:visited  {font: bold 9pt "���� new"; color:#36618A; text-decoration:none}
	A:hover    {font: bold 9pt "���� new"; color:#36618A; text-decoration:none}
	.input
	{
		BACKGROUND-COLOR: #ffffff;
		BORDER-BOTTOM: #999999 1px solid;
		BORDER-LEFT: #999999 1px solid;
		BORDER-RIGHT: #999999 1px solid;
		BORDER-TOP: #999999 1px solid;
		COLOR: #999999;
		FONT-SIZE: 9pt
	}
//-->
</style>
<script language=javascript>
	function fnOnLoad(tree_idx)
	{
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	}

	function popup(url)
	{
		var nWidth= 1024;
		var nHeight = 680;
		var sw = screen.availWidth;
		var sh = screen.availHeight;
		var px = (sw - nWidth) / 2;
		var py = (sh - nHeight) / 2;
		window.open(url,'','width='+nWidth+',height='+nHeight+',scrollbars=no,toolbars=no,menubars=0,top = ' + py + ', left = ' + px);
	}
	
	function devMsg()
	{
	  alert("���� �������� �����Դϴ�.");
	}
	
</script>

</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="620"  border="0" align="center" cellpadding="3" cellspacing="5">
  
  <tr> 
    <td colSpan="2" height="30" align="center"><FONT SIZE="2" COLOR="#0099cc">&nbsp; 
      </font></td>
  </tr>
  <tr> 
    <td colSpan="2" height="30" align="center" bgcolor="#F7FAFD"><FONT SIZE="2" COLOR="#0099cc"> 
      <b><font color="#333333">��å�Ӱ� �Բ��ϴ� ����������ȣ �����ϱ�</font></b></FONT></td>
  </tr>
  <tr> 
    <td bgColor="#69AFDA" colSpan="2" height="2"></td>
  </tr>
  <tr align="center" valign="middle"> 
    <td height="10"></td>
    <td></td>
  </tr>
  <tr>
  <td height="30" bgcolor="#F7FAFD" align="center" colSpan="2" >
		<table cellpadding="4" cellspacing="1" border="0"  bgcolor="#D8D8D8" width="100%">
			<tr  align="center" class="css3">
				<Td  height=25 colspan=3 bgcolor="#E8F3FF"   class="table"><b>Topic</b></td>
			</TR>
			<tr align="center" class="css3">	
				<TD width=10% height=23 align=center bgcolor="#F2F2F2">1</TD>
				<TD align="left" bgcolor="white"><b><A href="javascript:popup('01/0101.htm');">&#160;����!, ����������ȣ�� �̷� �ű���</a></b></TD>
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">2</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('02/0201.htm');">&#160;����, ������� ���Ұ� �ֿ������ �ٷ� ����</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">3</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('03/0301.htm');">&#160;�ùٸ� ���������� ������ �� �ִ� 7���� DNA�� ã��!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">4</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('04/0401.htm');">&#160;ȿ������ �������� �̿� ����� �˾ƺ���!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">5</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('05/0501.htm');">&#160;�������� �������޿� �ƿ��ҽ��� �ٽ��� �����!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">6</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('06/0601.htm');">&#160;����� �������� ������ �ı�����!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">7</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('07/0701.htm');">&#160;���� �������� �����ϰ� ��ȣ����!</a></b></TD>	
			</TR>
			<tr align="center" bgcolor="#F2F2F2" class="css3">
						<TD width=10% height=23 align=center bgcolor="#F2F2F2">8</TD>
						<TD align="left" bgcolor="white"><b><A href="javascript:popup('08/0801.htm');">&#160;���� �䱸, �ż��ϰ� ��������!</a></b></TD>	
			</TR>

		</TABLE>
	</td>
  </tr>
  <tr align="center" valign="middle"> 
    <td height="15"></td>
    <td></td>
  </tr>
  <tr align="center" valign="middle">
  <td height="55" valign="top" colSpan="2" >  �� ���ø��� Ŭ���Ͻø� �ش� ������ ������ ����˴ϴ�.</td>

  </tr>
  <tr align="center" valign="middle">
    <td height="51"></td>
    <td></td>
  </tr>
</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		








