<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030009_card1
 * J  S  P		: P030009i
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������	: 
 *                   
 * ������������ 	: 2007-01-11
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");				//���
    String eJuno 	 = request.getParameter("eJuno");		//������� �ֹι�ȣ
%>

<html>
<head>
<title>2006�� �ٷμҵ���� �ſ�ī�� / ���ݿ����� ���� �� �Է�</title>
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
<SCRIPT language=JavaScript src="imgs/web.js"></SCRIPT>
<SCRIPT language=JavaScript src="imgs/06YearEntry.js"></SCRIPT>
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

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
	function ln_Start(){
		//�׸��� ��Ÿ�� �ֱ�
		cfStyleGrid(getObjectFirst("gr1"), "comn");
	
		fnSelect("<%=eyy%>", "<%=eno%>", "<%=eJuno%>");	//�⺻���� ��ȸ
	}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno, pJuno) {	 //������ : �Ķ���� �޾Ƽ� �⺻ ��ȸ
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno 
			          + ",eJuno="     + pJuno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i_05",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	
/******************************************************************************
	Description : �߰�, ����, ����, ���
******************************************************************************/
	function fnAddRow(){
		if(ds1.countrow > 1) {
			alert("���� �ٹ����� 2�������� �Է��� �� �ֽ��ϴ�.");
		} else {
			ds1.addrow();
		}
	}
	
	function fnDeleteRow() {//Row ����
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds1.DeleteRow(ds1.RowPosition);
	}
	

    function fnApply() {// ���� �����ͼ� �ݿ�
		v_job = "I";	
        if (ds1.IsUpdated) {
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i_05",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�ſ�ī�� / ���ݿ����� �� ������ ���� ������ �����ϴ�.");
        }
    }
    
	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 
	
	
	function fnClose()	{
		window.close();
		opener.fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
//		opener.ds3.reset();
	};
	
	
	
	
//�հ� ���
function calTotal(gbn) {
	if (gbn=='1')	{
		getObjectFirst("f_CARDTOT1").text= parseInt(getObjectFirst("f_CARD11").text) + parseInt(getObjectFirst("f_CARD21").text);
	} else if (gbn=='2') {
		getObjectFirst("f_CARDTOT2").text= parseInt(getObjectFirst("f_CARD12").text) + parseInt(getObjectFirst("f_CARD22").text);
	} else if (gbn=='3') {
		getObjectFirst("f_CARDTOT3").text= parseInt(getObjectFirst("f_CARD13").text);
	};
	
}	;
</script>


<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//		fnSelect("<%=eyy%>", "<%=eno%>", "<%=eJuno%>");	//�⺻���� ��ȸ
		fnClose();
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		calTotal('1');
		calTotal('2');
		calTotal('3');		
    };	
	// ������� �׽�Ʈ �Ϸ� : ds_result�� ���� ���� �� ���־�� ������ �ȳ���.~
</script>



<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
// ��� �޼��� Ȯ��...
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
if(Row==0) return;
</script>
<%=HDConstant.COMMENT_START%>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<form name="entry" method="post" action="">
	<!-- �������� �� �����׸� -->
	<table width="820" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2"><b>�� �ſ�/����/����ī��</b></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#FF6633">1. ���� ���� (���� �Ѽҵ� 100���� ������)</font></b></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;- �����, ��������, �������� ����� �ſ�ī�� �� �� ���ݾ��� "�������ܴ���"�� ������ �ݾ�
						</font></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#3366FF">2. ���� �Ұ��� (���� �Ѽҵ� 100���� �ʰ���)</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">&nbsp;&nbsp;&nbsp;&nbsp;- ī��� ������ �Ƿ�� �� �ҵ���� ������ ���� �κп� ���ؼ��� �ߺ� ���� �Ұ����� (2006������� �ߺ� ���� ������)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- <u>�����ڸŰ� ����� �ſ�ī�� �� ���ݾ�</u><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- ����� �� ȸ����<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �ؿ� ���ݾ� ��<br><br>
						</font></td>
					</tr>
					<tr>
						<td colspan="2"><b>�� �п��� ���γ��ξ�</b></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#FF6633">1. ���� ���� (���� �Ѽҵ� 100���� ������)</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;- �����, ��������, �������� �п� �����Ḧ "����(Zero)����"�� �̿��Ͽ� ������ ���
						</font></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#3366FF">2. ���� �Ұ��� (���� �Ѽҵ� 100���� �ʰ���)</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">&nbsp;&nbsp;&nbsp;&nbsp;- <u>�����ڸ��� ���� ���� �п� ������</u><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �����, ��������, �������� �п� �����Ḧ ī�� ���� �� �������Ա��� ��� ��<br><br>
						</font></td>
					</tr>
					<tr>
						<td colspan="2"><b>�� ���ݿ����� ����</b></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#FF6633">1. ���� ���� (���� �Ѽҵ� 100���� ������)</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;- ����û "���ݿ����� Ȩ������(www.taxsave.go.kr)"�� ȸ�������� ��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �����, ��������, �������� ����� ���ݿ����� �� ���ݾ��� "�������ܴ���"�� ������ �ݾ�
						</font></td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><b><font color="#3366FF">2. ���� �Ұ��� (���� �Ѽҵ� 100���� �ʰ���)</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">&nbsp;&nbsp;&nbsp;&nbsp;- ���ݿ����� �ҵ���� �������� ������ �Ƿ�� �� �ҵ���� ������ ���� �κп� ���ؼ��� �ߺ� ���� �Ұ����� (2006������� �ߺ� ���� ������)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- <u>�����ڸŰ� ����� ���ݿ����� ���ݾ�</u><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- ����� �� ȸ����<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �ؿ� ���ݾ� ��
						</font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right"><br>
						<nobr>
							<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
							<!-- <img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()"> -->
							<!-- <img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()"> -->
							<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
							��<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">							
						</nobr>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>	


<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 100px;border:1 solid #777777;display:none;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='���'				ID=APPDT   		Width=63	</C> 
	<C> Name='���'				ID=EMPNO  		Width=60	</C> 
	<C> Name='����'				ID=EMPNMK  		Width=40	</C> 
	<C> Name='�ֹι�ȣ'			ID=EMPJUNO  	Width=60	</C> 	
	<C> Name='�ξ簡������1'		ID=FAMNMK		Width=64	</C>
	<C> Name='�ξ簡������1'		ID=FAMRELA_NM	Width=65	</C>
	<C> Name='�����ڵ�'			ID=FAMRELA_CD	Width=35	</C>	
	<C> Name='�����ֹι�ȣ1'		ID=FAMJUNO		Width=55	</C>
	<C> Name='�ܱ���YN'			ID=REF1   		Width=40	</C>
	<C> Name='100��������YN'		ID=REF2   		Width=40	</C>
	<C> Name='�����YN'			ID=REF3   		Width=40	</C>
	<C> Name='�ڳ�YN'			ID=REF4   		Width=40	</C>
	<C> Name='���YN'			ID=REF5   		Width=40	</C>
	<C> Name='����ûī��' 		ID=CARD11		Width=50	</C>
	<C> Name='����û����' 		ID=CARD12		Width=50	</C>
	<C> Name='����û����' 		ID=CARD13		Width=50	</C>
	<C> Name='ī���    ' 			ID=CARD21		Width=50	</C>
	<C> Name='���ο�    ' 			ID=CARD22		Width=50	</C>
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	</C>	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

	<table width="820" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#FFFFFF">
			<td colspan="2" bgcolor="#ffedd2">�� �� �� �� ��</td>
			<td colspan="3" bgcolor="#ffedd2">�� �� �� û �� (= �� �� ��)</td>
			<td colspan="4" bgcolor="#ffedd2">�� ��</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee" width="65">�� ��</td>
			<td bgcolor="#fff8ee" width="90">�ֹε�Ϲ�ȣ</td>
			<td bgcolor="#fff8ee" width="65">�� ��</td>
			<td bgcolor="#fff8ee" width="90">�� ��</td>
			<td bgcolor="#fff8ee" width="110">�ֹε�Ϲ�ȣ</td>
			<td bgcolor="#fff8ee" width="65">�ڷ� ����</td>
			
			<td bgcolor="#fff8ee" width="85">�ſ�ī��</td>
			<td bgcolor="#fff8ee" width="85">���ݿ�����</td>
			<td bgcolor="#fff8ee" width="85">�п������γ���</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPNMK" style= "position:relative;left:0px;top:2px;width:65px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>			
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=FORMAT 			value="000000-0000000">
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>	
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMNMK" style= "position:relative;left:0px;top:2px;width:65px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>	
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMRELA_CD" style= "DISPLAY:NONE;position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<object id="f_FAMRELA_NM" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>			
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMJUNO" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
				<input type="hidden" name="f_REF1" id="f_REF1" value="">
				<input type="hidden" name="f_REF2" id="f_REF2" value="">
				<input type="hidden" name="f_REF3" id="f_REF3" value="">
				<input type="hidden" name="f_REF4" id="f_REF4" value="">
				<input type="hidden" name="f_REF5" id="f_REF5" value="">
			</td>
			<td bgcolor="#fff8ee"><font color="#FF6633">����û�ڷ�</font></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD11" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD13" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD12" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee">�׹����ڷ�</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD21" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td>-</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD22" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>

		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td colspan="6">�� ��	</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT1" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT3" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT2" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			
		</tr>
	</table>
</form>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNMK 	Ctrl=f_EMPNMK  	Param=text</C>
		<C>Col=EMPNO  	Ctrl=f_EMPNO   	Param=text</C>		
		<C>Col=EMPJUNO	Ctrl=f_EMPJUNO 	Param=text</C>
		<C>Col=APPDT  	Ctrl=f_APPDT   	Param=text</C>
		<C>Col=FAMRELA_NM	Ctrl=f_FAMRELA_NM 	Param=text</C>
		<C>Col=FAMRELA_CD	Ctrl=f_FAMRELA_CD 	Param=text</C>		
		<C>Col=FAMNMK 	Ctrl=f_FAMNMK  	Param=text</C>
		<C>Col=FAMJUNO	Ctrl=f_FAMJUNO 	Param=text</C>
		<C>Col=REF1   	Ctrl=f_REF1    	Param=value</C>
		<C>Col=REF2   	Ctrl=f_REF2    	Param=value</C>
		<C>Col=REF3   	Ctrl=f_REF3    	Param=value</C>
		<C>Col=REF4   	Ctrl=f_REF4    	Param=value</C>
		<C>Col=REF5   	Ctrl=f_REF5    	Param=value</C>
		<C>Col=CARD11 	Ctrl=f_CARD11  	Param=text</C>
		<C>Col=CARD12 	Ctrl=f_CARD12  	Param=text</C>
		<C>Col=CARD13 	Ctrl=f_CARD13  	Param=text</C>
		<C>Col=CARD21 	Ctrl=f_CARD21  	Param=text</C>
		<C>Col=CARD22 	Ctrl=f_CARD22  	Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>


</body>
</html>
