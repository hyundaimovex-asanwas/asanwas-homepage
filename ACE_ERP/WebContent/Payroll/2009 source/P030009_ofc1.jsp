<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030009_ofc
 * J  S  P		: P030009i
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2006-12-19
 * �������	: �������곻���Ű� - ���� �ٹ��� ��! : UNI �ҽ��� �޾����� ���� Ȱ���ϴ°� �츮 ����
 *                   ������ �ε�� �޾ƿ� ������� ���� ���� ǥ��
 *                   ��Ϲ�ư 1ȸ ���������� �� ���� & 2ȸ���� ����
 *                   ���ܳ��� DS�� ����..
 *                   
 *                   
 * ������������ 	: 2006-12-19
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");			//�ͼӳ⵵
    String eno = request.getParameter("eno");		//���
%>

<html>
<head>
<title>2006�� �ٷμҵ���� ��(��)�ٹ��� �� �Է�</title>
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
	
		fnSelect(<%=eyy%>,  <%=eno%>);	//�⺻���� ��ȸ
	}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //������ : �Ķ���� �޾Ƽ� �⺻ ��ȸ
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy=" + pYear
			          + ",eno="+  pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i_01",	//		��� ������ ��!
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
			getObjectFirst("dspImg").style.display="none";			

			getObjectFirst("f_YYYY").value = "<%=eyy%>";		//�ͼӳ�
			getObjectFirst("f_EMPNO").value = "<%=eno%>";		//���
			getObjectFirst("f_EMPNMK").value = "ȫ�浿";		//�⺻�� insert
			getObjectFirst("f_STRTDT").value = "20061228";	//�⺻�� insert
			getObjectFirst("f_ENDDT").value = "20061228";		//�⺻�� insert
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
	    	for (i = 1; i <= ds1.countrow; i++) {
				if (!ds1.namevalue(i, "SEQ")) {
					ds1.namevalue(i, "SEQ") = i;
				};
	    	};
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i_01",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�ٹ��� ������ ���� ������ �����ϴ�.");
        }
    }
    
	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
		
		if(ds1.countrow > 0) {
			getObjectFirst("dspImg").style.display="none";
		} else {
			getObjectFirst("dspImg").style.display="";
		}	
	} 


	function fnClose()	{	//â ���� ��.
		window.close();
		opener.fnSelect2("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)

	};
		
//�հ� ���
function calTotal(gbn) {
	if (gbn=='1')	{
		getObjectFirst("f_BP10SUM").value= parseInt(getObjectFirst("f_BP11000").text) + parseInt(getObjectFirst("f_BP12000").text) + parseInt(getObjectFirst("f_BP13000").text);
	} else if (gbn=='2') {
		getObjectFirst("f_BP20SUM").value= parseInt(getObjectFirst("f_BP21000").text) + parseInt(getObjectFirst("f_BP22000").text) + parseInt(getObjectFirst("f_BP23000").text);
	} else if (gbn=='3') {
		getObjectFirst("f_BP30SUM").value= parseInt(getObjectFirst("f_BP31000").text) + parseInt(getObjectFirst("f_BP32000").text) + parseInt(getObjectFirst("f_BP33000").text);
	} else if (gbn=='4') {
		getObjectFirst("f_BP40SUM").value= parseInt(getObjectFirst("f_BP41000").text) + parseInt(getObjectFirst("f_BP42000").text) + parseInt(getObjectFirst("f_BP43000").text);
	};

	
}	;
</script>


<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
		getObjectFirst("dspImg").style.display="none";
	} else {
		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose();	
		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		calTotal('1');
		calTotal('2');
		calTotal('3');
		calTotal('4');
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
	<table width="638" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">�� �Է¾ȳ�</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#FF6633"><b>�� ���س⵵ ����Ի��� �Ǵ� 2�� �̻��� �ٹ�ó���� �ҵ��� �߻��ϴ� ���� ��쿡�� �Է��մϴ�.</b></font><br>
						&nbsp;&nbsp;&nbsp;&nbsp; ��) �����ù� ������ ����� �Ի���, �������� �� ����� 2������ �޿��� �޴� ��
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>�� ��(��)�ٹ����κ��� "<u>�ٷμҵ��õ¡�������� �� �ҵ��ں��ٷμҵ��õ¡����</u>"�� �߱� �޾ƾ� �մϴ�.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">�� �ҵ��ڷ� (���ٹ��� �ҵ� + ���ٹ��� �ҵ� = �ջ�ҵ� �Ű�)</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �����ҵ��� �޿��� �󿩷� ���� �Է��մϴ�. (����� �ҵ��� ���� �Է�)<br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �����󿩿� �ش��ϴ� �����ҵ� �� : ���������Ϳ��� ���޹޴� ������ �ް��޿�
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">�� ���������� ��(��)�ٹ��� �Է¼����� ��ġ�ǵ��� �����Ͽ� �ֽñ� �ٶ��ϴ�.</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �ٷμҵ��õ¡���������� ��<u>���ݺ����(���ο���), �����(�ǰ�����+��뺸��)</u>�� �ݾ���<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ǥ�� �Ǿ� ���� ���� ��� "�ҵ��ں��ٷμҵ��õ¡����"�� �����մϴ�.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF6633">�� ������ �� ¡���λ� ���� �ݾ��� ���� ��� ���ٹ��� �������� ����ڿ��� �ݾ���<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����ϼž� �մϴ�.</font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#3366FF">�� �����ڷ� (���ٹ��� ���� �ҵ漼/�ֹμ� + ���ٹ��� ���� �ҵ漼/�ֹμ� = �ջ꼼�� �Ű�)</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- ����¡�������� �ƴ� "<u>���⼼�װ� ��������</u>"�� �Է��մϴ�.
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right"><br>
						<nobr>
							<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
							<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
							<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">
							<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						</nobr>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>


<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:block;" viewastext>
	<PARAM NAME="DataID"			VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='No.'		ID='{STRING(CURROW)}' 		HeadAlign=Center Width=33		align=center  </C> 

	<C> Name='�ͼӳ⵵'		ID=YYYY 	HeadAlign=Center Width=90	align=center  mask='XXXX'</C> 
	<C> Name='���'			ID=EMPNO  	HeadAlign=Center Width=103	align=center  </C> 
	<C> Name='ȸ���'		    ID=WKNM		HeadAlign=Center Width=205	align=reft	</C>
	<C> Name='����ڵ�Ϲ�ȣ'	ID=WKRESINO	HeadAlign=Center Width=204	align=center  mask='XXX-XX-XXXXX' EDIT=NUMERIC</C>

	<C> Name='����'			ID=EMPNMK  	HeadAlign=Center Width=55	align=reft	  			show=false</C>
	<C> Name='�����Ի�����'	ID=STRTDT	HeadAlign=Center Width=80	align=center  mask='XXXX/XX/XX' show=false</C>
	<C> Name='�����������'	ID=ENDDT 	HeadAlign=Center Width=80	align=center  mask='XXXX/XX/XX' show=false</C>
		
	<C> Name='�޿��Ѿ�'				ID=BP11000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��'						ID=BP12000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='������'				ID=BP13000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ѱ޿���'				ID=BP10SUM	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='���ܱٷκ����'	ID=BP21000	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='�߰��ٷκ����'	ID=BP22000	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='��Ÿ�����'			ID=BP23000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='���ο���'				ID=BP31000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ǰ�����'				ID=BP32000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��뺸��'				ID=BP33000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ҵ漼'					ID=BP41000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ֹμ�'					ID=BP42000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��Ư��'					ID=BP43000	HeadAlign=Center Width=80	align=right		show=false</C>
    <C> Name='���װ�'					ID=BP40SUM	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='����'		ID='SEQ' 	HeadAlign=Center Width=33		align=center  show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>


<!-- ���⿡ �� ������ �� �ϳ� �־��ٲ�...��.. -->
<div id=dspImg style="display:;position:absolute;left:0;top:345;width:638;height:236;Z-INDEX: 8"><img src=imgs/back_base.gif width=638 height=236 id=dspImg2 style="filter:alpha(opacity=70)"></div>
	<table width="638" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#fff8ee">
			<td bgcolor="#ffedd2" width="30"  rowspan="9">��<br><br>��<br><br>��<br><br>��<br><br>��</td>
			<td width="110">ȸ���</td>
			<td colspan="2" bgcolor="#FFFFFF">
				<input type="text" id="f_WKNM" name="f_WKNM" value="" class="input01" size="28" style="text-align:center;" maxlength="13">
			</td>
			<td>����ڹ�ȣ</td>
			<td colspan="2" bgcolor="#FFFFFF">
				<%=HDConstant.COMMENT_START%>
				<object id="f_WKRESINO" style= "position:relative;left:0px;top:2px;width:165px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=165 class="input01">
					<param name=Text 		value="">
					<param name=Alignment 	value=1>
					<param name=Format 		value="000-00-00000">
					<param name=Cursor	 	value="iBeam">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
					<param name=SelectAllOnClick  	value="true">		
					<param name=SelectAllOnClickAny   value="false">
				</object>
				<%=HDConstant.COMMENT_END%>				
			</td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">�����ҵ�</td>
			<td width="100">�����޿�</td>
			<td width="100">������</td>
			<td width="100">������</td>
			<td width="100">�����ҵ��</td>
			<td width="100"></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP11000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP12000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">					
				</object>
				<%=HDConstant.COMMENT_END%></td>				
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP13000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td>
				<input type="text" id="f_BP10SUM" name="f_BP10SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">������ҵ�</td>
			<td width="100">���ܺ����</td>
			<td width="100">�߰��ٷ�</td>
			<td width="100">��Ÿ�����</td>
			<td width="100">������ҵ��</td>
			<td width="100"></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP21000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP22000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP23000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td>
				<input type="text" id="f_BP20SUM" name="f_BP20SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">����</td>
			<td>���ο���</td>
			<td>�ǰ�����</td>
			<td>��뺸��</td>
			<td>������</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP31000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP32000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP33000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>										
			<td>
				<input type="text" id="f_BP30SUM" name="f_BP30SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">����</td>
			<td>�����ҵ漼</td>
			<td>�����ֹμ�</td>
			<td>������Ư��</td>
			<td>�������װ�</td>
			<td></td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP41000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP42000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP43000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>										
			<td>
				<input type="text" id="f_BP40SUM" name="f_BP40SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td>
			<td></td>
		</tr>
	</table>
	<input type="hidden" id="f_EMPNMK" name="f_EMPNMK" value="">
	<input type="hidden" id="f_STRTDT" name="f_STRTDT" value="">
	<input type="hidden" id="f_ENDDT" name="f_ENDDT" value="">
	<input type="hidden" id="f_YYYY" name="f_YYYY" value="">
	<input type="hidden" id="f_EMPNO" name="f_EMPNO" value="">

</form>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=YYYY 		Ctrl=f_YYYY 			Param=value</C>
		<C>Col=EMPNO  		Ctrl=f_EMPNO  			Param=value</C>
		<C>Col=WKNM	    	Ctrl=f_WKNM	    		Param=value</C>
		<C>Col=WKRESINO 	Ctrl=f_WKRESINO 		Param=text</C>
		<C>Col=EMPNMK   	Ctrl=f_EMPNMK   		Param=value</C>
		<C>Col=STRTDT		Ctrl=f_STRTDT			Param=value</C>
		<C>Col=ENDDT 		Ctrl=f_ENDDT 			Param=value</C>
		<C>Col=BP11000		Ctrl=f_BP11000			Param=text</C>
		<C>Col=BP12000		Ctrl=f_BP12000			Param=text</C>
		<C>Col=BP13000		Ctrl=f_BP13000			Param=text</C>
		<C>Col=BP10SUM		Ctrl=f_BP10SUM			Param=text</C>
		<C>Col=BP21000		Ctrl=f_BP21000			Param=text</C>
		<C>Col=BP22000		Ctrl=f_BP22000			Param=text</C>
		<C>Col=BP23000		Ctrl=f_BP23000			Param=text</C>
		<C>Col=BP31000		Ctrl=f_BP31000			Param=text</C>
		<C>Col=BP32000		Ctrl=f_BP32000			Param=text</C>
		<C>Col=BP33000		Ctrl=f_BP33000			Param=text</C>
		<C>Col=BP41000		Ctrl=f_BP41000			Param=text</C>
		<C>Col=BP42000		Ctrl=f_BP42000			Param=text</C>
		<C>Col=BP43000		Ctrl=f_BP43000			Param=text</C>
		<C>Col=BP40SUM		Ctrl=f_BP40SUM			Param=text</C>
		<C>Col=SEQ	 		Ctrl=f_SEQ	 			Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>



</body>
</html>
