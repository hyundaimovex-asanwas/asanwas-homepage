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
 * ������������	: 2007-12-04
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");		//�ͼӳ⵵
    String eno = request.getParameter("eno");		//���
%>

<html>
<head>
<title><%=eyy%>�� �ٷμҵ���� �������� �������</title>
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
<SCRIPT language="JavaScript" src="imgs/web.js"></SCRIPT>
<SCRIPT language="JavaScript" src="imgs/06YearEntry.js"></SCRIPT>
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT>
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
			<td width="93">
				<div align="center"><font face="����">�����ݾ�</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="40" bgcolor="#FFF8EE" rowspan=9>
				<div align="center"><font face="����">�⺻</font></div>
			</td>
			<td width="83" bgcolor="#FFF8EE">
				<div align="center"><font face="����">�� ��</font></div>
			</td>
			<td colspan="2"><font face="����">��� �ٷ��� <br>
				</font></td>
			<td width="93">
				<div align="center"><font face="����">150����</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="83" bgcolor="#FFF8EE">
				<div align="center"><font face="����"> ����ڰ���</font></div>
			</td>
			<td colspan="2"><font face="����"> �ҵ�ݾ��� ���ų� �ڻ�ҵ�(�ٷ�,����,����,���,��Ÿ�ҵ� ��)��<br>
				������ ���� �ҵ�ݾ��� �հ���� 100���� ������ ��<br>
				</font></td>
			<td width="93">
				<div align="center"><font face="����"> 150����</font></div>
			</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
			<td rowspan="7" width="83" bgcolor="#FFF8EE">
				<div align="center"><font face="����">�ξ簡�� </font></div>
			</td>
			<td colspan="2"><font face="����">�ٷ��ں��� �� ������� �ξ簡��(���� ���� ���ϻ���)���μ�<br>
				���� �ҵ�ݾ��� �հ���� 100���� ������ ��<br>
				</font></td>
			<td rowspan="7" width="93">
				<div align="center"><font face="����">150���� </font></div>
				<p align="center"><font face="����">(1�δ�)<br>
					</font></p>
			</td>
		</tr>
		
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�ڳ�<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="����">�� 20�� ����(1989.1.1
				���� ���)<br>
				���ؿ����߿� �� 20���� �����ϴ��� ����������</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�θ�<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="����">�� : �� 60�� �̻�(1949.12.31
				���� ���) <br>
				�� : �� 60�� �̻�(1949.12.31 ���� ���)</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�����ڸ�<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="����">�� 20������(1989.1.1
				���� ���) �Ǵ� <br>
				�� : �� 60�� �̻�(1949.12.31 ���� ���)<br>
				�� : �� 60�� �̻�(1949.12.31 ���� ���) </font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">��Ȱ��ȣ<br>
					�����</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="����">���α��ʻ�Ȱ ����� ��2�� ��2ȣ�� ������</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">�����
				</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="����">�������� ����<br> 
			������ �Ǵ� �Ծ��ڿ� �� ����ڰ� ��� ����ο� <br>
			�ش��ϴ� ��� �� ����ڵ� ����.
			</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="����">��Ź�Ƶ�<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="����" color=#ff6633>�� 18�� ����(1991.1.1
				���� ���)<br>
				�ش� �����Ⱓ�� 6���� �̻� ���� ������ ��Ź�Ƶ�<br>
				���ؿ����߿� �� 18���� �����ϴ��� ����������</font></td>
		</tr>
	  
	  <tr bgcolor="#FFFFFF">
	    <td width="40" bgcolor="#FFF8EE" rowspan=4>
			<div align="center"><font face="����">�߰�</font></div>
		</td>
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">��ο����� </font></div>
		</td>
		<td width="408" colspan="2" ><font face="����">�ٷ��� ���� �Ǵ� ���踦 �����ϴ� �ξ簡�� (����� ����) ��
		  <br>&nbsp;�� 70�� �̻�(1939.12.31 ���� ���)
		  </font></td>
		<td width="86" valign="top">
		  <div align="center"><font face="����">
			100����
			<br>(1�δ�)
			</font></div>
		</td>
	  </tr>
	   <tr bgcolor="#FFFFFF">
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">����ΰ��� </font></div>
		</td>
		<td width="408" colspan="2" ><font face="����">�ٷ��� ���� �Ǵ� ���踦 �����ϴ� �ξ簡�� �� ������� �ִ�
		  ��� <br>
		  (������� ����) <br>
		  - ����κ������� ���� ����� <br>
		  - ���������� �� ���� �� ������ ���� ������ ���� ������ <br>
		  - ���� �����ڿ� ������ �ڷμ� �ٷδɷ��� ������ <br>
		  - ������ ���Ͽ� ���� ġ�Ḧ ���ϴ� �ڰ� �� ġ��Ⱓ�� 1�� �̻�<br>
		  &nbsp;&nbsp;&nbsp;���ӵ� ���� ����ǰ� ���ġ��Ⱓ ���ȿ��� ���С������ ����� ���¿�<br>
		  &nbsp;&nbsp;&nbsp;�ִ� ��(���� ��, ���� �ź�����ȯ�� ��)
		  <br>&nbsp;&nbsp;&nbsp;�� �Ƿ��� ������ "���������" ÷��
		  </font></td>
		<td  valign="middle" align="center">
		  200����<br>(1�δ�)
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">�γ��ڰ��� </font></div>
		</td>
		<td width="408" colspan="2"><font face="����"> ����ڰ� ���� �����ٷ��ڷμ� �⺻������ ����޴� �ξ簡���� �ִ� <br>
						�������̰ų�, ����ڰ� �ִ� �����ٷ����� ���(���� �ҵ� ���� ����)<br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="����">50���� <br>
			<br>
			</font></div>
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="����">�ڳ�������� <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="����">�� 6�� ������ �������� �ִ� ��� <br>
		  (2003. 1. 1 ���� ����� ������ �Ǵ� �Ծ���,��Ź�Ƶ�) <br>
		  &nbsp;�� ��ġ����, ������ �� ������ �Ƶ��� ����������� �ߺ����� ����
		  </font></td>
		<td width="86">
		  <div align="center"><font face="����">100����<br>
			(1�δ�) <br>
			</font></div>
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="120" colspan="2" bgcolor="#FFF8EE">
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
	   <tr bgcolor="#FFFFFF">
		<td width="120" colspan="2" bgcolor="#FFF8EE">
		  <div align="center"><font face="����" >��ꡤ�Ծ��� ���� <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="����">���س⵵ ��ꡤ�Ծ��� �ڳడ �ִ� ���<br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="����"> 200����<br>(1�δ�)
			</font></div>
		</td>
	  </tr> 
	</table>

</body>
</html>
