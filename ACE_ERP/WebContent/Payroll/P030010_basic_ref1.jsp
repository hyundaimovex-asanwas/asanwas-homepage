<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030009_basic_ref
 * J  S  P		: 
 * �� �� ��		: 
 * �� �� ��		: ������
 * �� �� ��		: 2007-12-04
 * �������	    : �⺻������ ���� ����   
 *                   
 *                   
 * ������������	: 2010-12-21   �� �� ��
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");		//�ͼӳ⵵
    String eno = request.getParameter("eno");		//���
%>

<html>
<head>
<title>2010�� �ٷμҵ���� �������� �������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>


<!-- ���� ���콺 ����-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>
<script language="javascript" src="js/embedControl.js"></script>
<script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_gauce.js"></script>
<script language="javascript" src="js/common_pop.js"></script>      
<script language="javascript" src="js/common.js"></script>       
<script language="javascript" src="imgs/web.js"></script>
<script language="javascript" src="imgs/06yearentry.js"></script>
<script language="javascript" src="imgs/applychk.js"></script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //���
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	
	//var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

</script>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
    <br>
    <b><font face="����">&nbsp;&nbsp;&nbsp;�� ��������</a></font></b>
	<table width="640" border="0" cellspacing="1" cellpadding="2" bordercolor="#666666" bgcolor="#666666" align="center">
		<tr bgcolor="#FFF8EE">
			<td width="123" colspan=2>
				<div align="center"><font face="����">�⺻��������</font></div>
			</td>
			<td colspan="2" bgcolor="#FFF8EE">
				<div align="center"><font face="����">�� �� �� �� �� ��</font></div>
			</td>
			<td width="100">
				<div align="center"><font face="����">�����ݾ�</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="40" bgcolor="#FFF8EE" rowspan=8>
				<div align="center"><font face="����">�⺻</font></div>
			</td>
			<td width="100" bgcolor="#FFF8EE">
				<div align="center"><font face="����">�� ��</font></div>
			</td>
			<td colspan="2"><font face="����">��� �ٷ��� <br>
				</font></td>
			<td width="100">
				<div align="center"><font face="����">150����</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="100" bgcolor="#FFF8EE">
				<div align="center"><font face="����"> ����ڰ���</font></div>
			</td>
			<td colspan="2"><font face="����"> �ҵ�ݾ��� ���ų� �ҵ�ݾ�(�ٷ�,����,����,���,��Ÿ�ҵ� ��)��<br>
				�հ���� 100���� ������ ��<br>
				</font></td>
			<td width="100">
				<div align="center"><font face="����"> 150����</font></div>
			</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
			<td rowspan="6" width="100" bgcolor="#FFF8EE">
				<div align="center"><font face="����">�ξ簡�� </font></div>
			</td>
			<td colspan="2"><font face="����">�ٷ��ں��� �� ������� �ξ簡��(���� ���� ���ϻ���)���μ�<br>
				���� �ҵ�ݾ��� �հ���� 100���� ������ ��<br>
				</font></td>
			<td rowspan="6" width="100">
				<div align="center"><font face="����">150���� </font><br>
				<font face="����">(1�δ�)
					</font></div>
			</td>
		</tr>






		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">������<br>
					</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="����">�� 20�� ����(1990.1.1
				���� ���)</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�θ�<br>
					</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="����">�� 60�� �̻�(1950.12.31
				���� ���) </font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�����ڸ�<br>
					</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="����">�� 20�� ����(1990.1.1
				���� ���) �Ǵ� <br>
				�� 60�� �̻�(1950.12.31 ���� ���)</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">��Ȱ��ȣ<br>
					�����</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="����">���α��ʻ�Ȱ ������� ������</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�����</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="����">�������� ����</font></td>
		</tr>
	  




	  <tr bgcolor="#FFFFFF">
	    <td width="40" bgcolor="#FFF8EE" rowspan=5>
			<div align="center"><font face="����">�߰�</font></div>
		</td>
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">��ο����� </font></div>
		</td>
		<td width="408" colspan="2" ><font face="����">�ٷ��� ���� �Ǵ� ���踦 �����ϴ� �ξ簡�� (����� ����) ��


		  <br>�� 70�� �̻�(1940.12.31 ���� ���)
		  </font></td>
		<td width="86" valign="top">
		  <div align="center"><font face="����">

			100����
			<br>(1�δ�)
			</font></div>
		</td>
	  </tr>
	   <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">����ΰ��� </font></div>
		</td>
		<td width="408" colspan="2" ><font face="����">�ٷ��� ���� �Ǵ� ���踦 �����ϴ� �ξ簡�� �� ����ڰ� �ִ�
		  ��� <br>
		  (������� ����) <br>
		  - ����κ������� ����� <br>
		  - ������ <br>
		  - �����ڿ� ������ �ڷμ� �ٷδɷ��� ������ <br>
		  - �׽� ġ�Ḧ ���ϴ� ����ȯ��
		  <br>&nbsp;&nbsp;&nbsp;�� "���������" �Ǵ� "����������" ÷��
		  </font></td>
		<td  valign="middle" align="center">
		  200����<br>(1�δ�)
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">�γ��ڰ��� </font></div>
		</td>
		<td width="408" colspan="2"><font face="����"> ����ڰ� ���� �����ٷ��ڷμ� �ξ簡���� �ִ� �������� ���,<br>
						 ����ڰ� �ִ� �����ٷ����� ���(���� �ҵ� ���� ����)<br>
		  </font></td>
		<td width="86"valign="middle">
		  <div align="center"><font face="����">50���� 
			</font></div>
		</td>
	  </tr>

	  <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">�ڳ��������� <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="����">��6�� ������ ������, �Ծ���, ��Ź�Ƶ��� �ִ� ��� <br>
		  (2004. 1. 1 ���� �����) <br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="����">100����<br>
			(1�δ�) <br>
			</font></div>
		</td>
	  </tr>

	  <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">���/�Ծ��� <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="����">�⺻������� ������ �Ǵ� �Ծ���<br>
		  - �ش� �����Ⱓ�� ��� �Ǵ� �Ծ�Ű�
		  </font></td>
		<td width="86">
		  <div align="center"><font face="����">200����<br>
			(1�δ�) <br>
			</font></div>
		</td>
	  </tr>


	  <tr bgcolor="#FFFFFF">
		<td width="140" colspan="2" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">���ڳ��߰� ���� <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="����">�⺻��������ڳడ 2�� �̻��� �ٷ����� ���<br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="����">50���� + <br> (�ڳ��-2��) <br> * 100����
			</font></div>
		</td>
	  </tr> 
	</table>

</body>
</html>
