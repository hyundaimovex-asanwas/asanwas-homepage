<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030010_ofc
 * J  S  P		: P030010i
 * �� �� ��		: 
 * �� �� ��		: �̵���
 * �� �� ��		: 2001-1-10
 * �������	: ��Ÿ����� �κ� �� �߰�
 *                   
 *                   
 * ������������ 	: 2011-1-10
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");			//�ͼӳ⵵
    String eno = request.getParameter("eno");		//���
%>

<html>
<head>
<title><%=eyy%>�� �ٷμҵ���� ��(��)�ٹ��� �� �Է�</title>
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
			    "/services/servlet/Payroll.p030010i_01",	//		��� ������ ��!
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
			calTotal('1');
		    calTotal('2');
		    calTotal('3');
		    calTotal('4');

			getObjectFirst("f_YYYY").value = "<%=eyy%>";		//�ͼӳ�
			getObjectFirst("f_EMPNO").value = "<%=eno%>";	//���
		//	getObjectFirst("f_EMPNMK").value = "ȫ�浿";		//�⺻�� insert
		//	getObjectFirst("f_STRTDT").value = "20061228";	    //�⺻�� insert
		//	getObjectFirst("f_ENDDT").value = "20061228";		//�⺻�� insert
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
		if(!Ofc_Apply_Chk("ds1")) return;
        if (ds1.IsUpdated) {
					// prompt('',ds1.text);
            if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			};

			v_job = "I";	
        
	    	for (i = 1; i <= ds1.countrow; i++) {
				if (!ds1.namevalue(i, "SEQ")) {
					ds1.namevalue(i, "SEQ") = i;
				};
	    	};
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           
            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_01",
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


	function fnSaveChk(){ //������ �������ⱸ��üũ
		v_job = "S";	  //select �ϵ�..
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				  + ",eyy="       + <%=eyy%>
				  + ",eno="       + <%=eno%> ;
        
		ln_TRSetting(tr1, 
			"/services/servlet/Payroll.p030010i",	//		��� ������ ��!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}

		
//�հ� ���
function calTotal(gbn) {
	var intBP11000=0; var intBP12000=0;	var intBP13000=0;
	var intBP21000=0; var intBP22000=0;	var intBTAXAMT01=0; var intBTAXAMT02=0; 
	var intBP31000=0; var intBP32000=0;	var intBP33000=0;  var intBP34000=0;
	var intBP41000=0; var intBP42000=0;	var intBP43000=0;
	
    if (gbn=='1')	{
        if(isNaN(parseInt(getObjectFirst("f_BP11000").text))==false)  intBP11000 =parseInt(getObjectFirst("f_BP11000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP12000").text))==false)  intBP12000 =parseInt(getObjectFirst("f_BP12000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP13000").text))==false)  intBP13000 =parseInt(getObjectFirst("f_BP13000").text);
		getObjectFirst("f_BP10SUM").text= intBP11000 +intBP12000 + intBP13000;
    } else if (gbn=='2') {
		if(isNaN(parseInt(getObjectFirst("f_BP21000").text))==false)  intBP21000 =parseInt(getObjectFirst("f_BP21000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP22000").text))==false)  intBP22000 =parseInt(getObjectFirst("f_BP22000").text);
		if(isNaN(parseInt(getObjectFirst("f_BTAXAMT01").text))==false)  intBTAXAMT01 =parseInt(getObjectFirst("f_BTAXAMT01").text);
		if(isNaN(parseInt(getObjectFirst("f_BTAXAMT02").text))==false)  intBTAXAMT02 =parseInt(getObjectFirst("f_BTAXAMT02").text);
		getObjectFirst("f_BP20SUM").text= intBP21000 +intBP22000 + intBTAXAMT01 + intBTAXAMT02;
	} else if (gbn=='3') {
		if(isNaN(parseInt(getObjectFirst("f_BP31000").text))==false)  intBP31000 =parseInt(getObjectFirst("f_BP31000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP32000").text))==false)  intBP32000 =parseInt(getObjectFirst("f_BP32000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP33000").text))==false)  intBP33000 =parseInt(getObjectFirst("f_BP33000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP34000").text))==false)  intBP34000 =parseInt(getObjectFirst("f_BP34000").text);
		getObjectFirst("f_BP30SUM").text= intBP31000 +intBP32000 + intBP33000 + intBP34000;
	} else if (gbn=='4') {
		if(isNaN(parseInt(getObjectFirst("f_BP41000").text))==false)  intBP41000 =parseInt(getObjectFirst("f_BP41000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP42000").text))==false)  intBP42000 =parseInt(getObjectFirst("f_BP42000").text);
		if(isNaN(parseInt(getObjectFirst("f_BP43000").text))==false)  intBP43000 =parseInt(getObjectFirst("f_BP43000").text);
		getObjectFirst("f_BP40SUM").text= intBP41000 +intBP42000 + intBP43000;
	};

    /*
	if (gbn=='1')	{	 
		getObjectFirst("f_BP10SUM").text= parseInt(getObjectFirst("f_BP11000").text) + parseInt(getObjectFirst("f_BP12000").text) + parseInt(getObjectFirst("f_BP13000").text);
    } else if (gbn=='2') {
		getObjectFirst("f_BP20SUM").text= parseInt(getObjectFirst("f_BP21000").text) + parseInt(getObjectFirst("f_BP22000").text) + parseInt(getObjectFirst("f_BP23000").text);
	} else if (gbn=='3') {
		getObjectFirst("f_BP30SUM").text= parseInt(getObjectFirst("f_BP31000").text) + parseInt(getObjectFirst("f_BP32000").text) + parseInt(getObjectFirst("f_BP33000").text);
	} else if (gbn=='4') {
		getObjectFirst("f_BP40SUM").text= parseInt(getObjectFirst("f_BP41000").text) + parseInt(getObjectFirst("f_BP42000").text) + parseInt(getObjectFirst("f_BP43000").text);
	};
	*/
}	
</script>

<script language=JavaScript for=f_BTAXAMT01 event=onChar(char)>
	if(gclx_btaxcd01.BindColVal ==""){
		if ((char > 0) || (char < 9)) {
			if (char == 13) return;
			alert("����� �׸���� �Է��ϼ���.");
			f_BTAXAMT01.text = 0;
			char = 0;
			
		}
}
</script>


<script language=JavaScript for=f_BTAXAMT02 event=onChar(char)>
	if(gclx_btaxcd02.BindColVal ==""){
		if ((char > 0) || (char < 9)) {
			if (char == 13) return;
			alert("����� �׸���� �Է��ϼ���.");
			f_BTAXAMT02.text = 0;
			char = 0;
			
		}
}
</script>


<script language="javascript" for="tr1" event="onsuccess()">
    

	if(ds1.countrow > 0) {
		getObjectFirst("dspImg").style.display="none";
	} else {
		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
	    gf_msg();
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

    alert("result");
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

<script language=JavaScript for=gclx_btaxcd01 event=onSelChange()>
		txt_index.value  = gclx_btaxcd01.Index;
		//txt_BTAXCD01.value  = gclx_btaxcd01.ValueOfIndex("BTAXCD01", txt_index.value);
		txt_BTAXNM01.value   = gclx_btaxcd01.ValueOfIndex("BTAXNM01", txt_index.value);
		if(txt_index.value==0) f_BTAXAMT01.text=0;
</script>

<script language=JavaScript for=gclx_btaxcd02 event=onSelChange()>
		txt_index2.value  = gclx_btaxcd02.Index;
		txt_BTAXNM02.value   = gclx_btaxcd02.ValueOfIndex("BTAXNM02", txt_index2.value);
		//txt_BTAXCD02.value  = gclx_btaxcd02.ValueOfIndex("BTAXCD02", txt_index2.value);
		if(txt_index2.value==0) f_BTAXAMT02.text=0;
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
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<comment id="__NSID__"><object id="gcds_btax" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--�޿�����-->
</object></comment><script>__ws__(__NSID__);</script>

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
						&nbsp;&nbsp;&nbsp;&nbsp; ��) �����ù� ������ ����ƻ� �Ի���, �������� �� ����ƻ� 2������ �޿��� �޴� ��
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
						&nbsp;&nbsp;&nbsp;&nbsp;- �����󿩿� �ش��ϴ� �����ҵ� <!--�� : ���������Ϳ��� ���޹޴� ������ �ް��޿�-->
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
						<td><font color="#FF6633"><b>�� �������ݼҵ���� </b></font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;- [�ٷ��������޿� �����]�� ���� <b>�ٷ��ڰ� �δ��� �������� ���Ծ� ��</b>�� �����մϴ�.  <br>
						&nbsp;&nbsp;&nbsp;&nbsp;- �����ѵ��� ������������װ� ���Ͽ� �� 300�����Դϴ�.
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
							&nbsp;&nbsp;<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">	
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

	<C> Name='�����Ի�����'	ID=STRTDT	HeadAlign=Center Width=80	align=center  mask='XXXX/XX/XX' show=false</C>
	<C> Name='�����������'	ID=ENDDT 	HeadAlign=Center Width=80	align=center  mask='XXXX/XX/XX' show=false</C>
	<C> Name='�޿��Ѿ�'				ID=BP11000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��'					ID=BP12000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='������'				ID=BP13000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ѱ޿���'				ID=BP10SUM	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='���ܱٷκ����'	    ID=BP21000	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='�߰��ٷκ����'	    ID=BP22000	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='���ο���'				ID=BP31000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ǰ�����'				ID=BP32000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��뺸��'				ID=BP33000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��������'				ID=BP34000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ҵ漼'					ID=BP41000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='�ֹμ�'					ID=BP42000	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='��Ư��'					ID=BP43000	HeadAlign=Center Width=80	align=right		show=false</C>
    <C> Name='���װ�'					ID=BP40SUM	HeadAlign=Center Width=80	align=right		show=false</C>
	<C> Name='����'		ID='SEQ' 	HeadAlign=Center Width=33		align=center  show=false</C>
	<C> Name='��Ÿ������ڵ�1'	    ID=BTAXCD01	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='��Ÿ������ڵ�2'	    ID=BTAXCD02	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='��Ÿ������ݾ�1'	    ID=BTAXAMT01	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='��Ÿ������ݾ�2'	    ID=BTAXAMT02	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='��Ÿ�����1'	    ID=BTAXNM01	HeadAlign=Center Width=90	align=right		show=false</C>
	<C> Name='��Ÿ�����2'	    ID=BTAXNM02	HeadAlign=Center Width=90	align=right		show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>


<!--	<C> Name='����'			ID=EMPNMK  	HeadAlign=Center Width=55	align=reft	  			show=false</C> -->

<!-- ���⿡ �� ������ �� �ϳ� �־��ٲ�...��.. -->
<div id=dspImg style="display:;position:absolute;left:0;top:345;width:638;height:236;Z-INDEX: 8"><img src=imgs/back_base.gif width=638 height=436 id=dspImg2 style="filter:alpha(opacity=70)"></div>
	<table width="638" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#fff8ee">
			<td bgcolor="#ffedd2" width="30"  rowspan="10">��<br><br>��<br><br>��<br><br>��<br><br>��</td>
			<td width="130">ȸ���</td>
			<td colspan="2" bgcolor="#FFFFFF">
				<input type="text" id="f_WKNM" name="f_WKNM" value="" class="input01" size="25" style="text-align:center;" maxlength="13">
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
			            <td><%=HDConstant.COMMENT_START%>
				
				<%=HDConstant.COMMENT_END%></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td>�ٹ��Ⱓ</td>
			<td colspan="2" bgcolor="#FFFFFF">
			<%=HDConstant.COMMENT_START%>
				<object  id="f_STRTDT" height=17 width=68 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:-5px;top:2px;width:68px;" class="txtbox">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
				</object>
				<%=HDConstant.COMMENT_END%>	
			<!--	<img src="../Sales/images/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('f_STRTDT', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">-->~&nbsp;
				<%=HDConstant.COMMENT_START%>
				<object  id="f_ENDDT" height=17 width=68 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:-5px;top:2px;width:68px;" class="txtbox">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
				</object>
				<%=HDConstant.COMMENT_END%>	
			<!--	<img src="../Sales/images/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('f_ENDDT', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>	 -->					
			</td>
								<td width="100">
								<%=HDConstant.COMMENT_START%>
								<%=HDConstant.COMMENT_END%></td>
								<td width="100">
								<%=HDConstant.COMMENT_START%>
								<%=HDConstant.COMMENT_END%></td>
								<td><%=HDConstant.COMMENT_START%>
								<%=HDConstant.COMMENT_END%></td>
								<td><%=HDConstant.COMMENT_START%>
								<%=HDConstant.COMMENT_END%></td>
						</tr>


		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">�����ҵ�</td>
			<td width="100">�����޿�</td>
			<td width="100">������</td>
			<td width="100">������</td>
			<td width="100"></td>
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
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>

            <td><%=HDConstant.COMMENT_START%>
				
				<%=HDConstant.COMMENT_END%></td>

            <td><%=HDConstant.COMMENT_START%>
				<object id="f_BP10SUM" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02" ;">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2>
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	  value="true">
                    <param name=ReadOnlyBackColor   value="#f5f5f5">
					<param name=SelectAll  	  value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>

			<!-- <td>
				<input type="text" id="f_BP10SUM" name="f_BP10SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td> -->
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">�����<br>�ҵ�</td>
			<td width="100">O01 �߰��ٷ�</td>
			<td width="100">	
			<comment id="__NSID__"><object id=gclx_btaxcd01 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 style="position:relative;top:2px;" class="txtbox">
					<param name=CBData				value="^' ',M01^���ܱٷ�(100����),M02^���ܱٷ�(150����),M03^���ܱٷ�">
					<param name=CBDataColumns		value="BTAXCD01,BTAXNM01">
					<param name=SearchColumn		value="BTAXNM01">
					<param name=Sort            value="false">
					<param name=ListExprFormat	value="BTAXCD01^1^30,BTAXNM01^0^170">
					<param name=BindColumn			value="BTAXCD01">
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td>
			<td width="100">
			<comment id="__NSID__"><object id=gclx_btaxcd02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 style="position:relative;top:2px;" class="txtbox">
					<param name=CBData				value="^' ',Q01^���_6�������ڳຸ��,X01^�ܱ��αٷ���,H10^��(����������),H09^��(����������),H08^��(����������)Ư����,H07^��(����������)����,H06^��(����������)�����ʵ��,G01^���ڱ�,H11^�������,H12^��������,H13^���ر޿�,H01^��������,K01^�ܱ��ֵб��α޿�,S01^�ֽĸż����ñ�,T01^�ܱ��α���ڼҵ�,Y01^�츮�������չ���,Y02^�츮������������_50%,Y03^�츮������������_75%,Y20^�����ڱ����_��������,Z01^���������ڿ�����,H05^��ȣ�����,I01^�ܱ����ζǴ±�������ٹ�">
					<param name=CBDataColumns		value="BTAXCD02,BTAXNM02">
					<param name=SearchColumn		value="BTAXNM02">
					<param name=Sort            value="false">
					<param name=ListExprFormat	value="BTAXCD02^1^30,BTAXNM02^0^170">
					<param name=BindColumn			value="BTAXCD02">
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td>
			<td width="100"></td>
			<td width="100">������ҵ��</td>
			<td width="100"></td>

		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td><%=HDConstant.COMMENT_START%> <!--�߰�-->
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
				<object id="f_BTAXAMT01" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
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
				<object id="f_BTAXAMT02" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
				<td><%=HDConstant.COMMENT_START%> <!--���� ���� ���Ƶ�-->
				<object id="f_BP21000" style= "position:relative;left:0px;top:2px;width:0px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="" onKeyup="calTotal('2');">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																							<param name=Visible    value="false">																								<param name=ShowLiteral   value="false">					
					<param name=ReadOnly  	value="false">
				</object>
				<%=HDConstant.COMMENT_END%></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP20SUM" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02" ;">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2>
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	  value="true">
                    <param name=ReadOnlyBackColor   value="#f5f5f5">
					<param name=SelectAll  	  value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>

			<!-- <td>
				<input type="text" id="f_BP20SUM" name="f_BP20SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td> -->
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">����</td>
			<td>���ο���</td>
			<td>�ǰ�����</td>
			<td>��뺸��</td>
			<td>��������</td>
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

			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP34000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');">
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
				<object id="f_BP30SUM" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02" ;">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2>
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	  value="true">
                    <param name=ReadOnlyBackColor   value="#f5f5f5">
					<param name=SelectAll  	  value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>
				
			<!-- <td>
				<input type="text" id="f_BP30SUM" name="f_BP30SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td> -->
			<td></td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td rowspan="2">����</td>
			<td>�����ҵ漼</td>
			<td>�����ֹμ�</td>
			<td>������Ư��</td>
			<td></td>
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

			<td><%=HDConstant.COMMENT_START%>

				<%=HDConstant.COMMENT_END%></td>	

			<td><%=HDConstant.COMMENT_START%>
				<object id="f_BP40SUM" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02" ;">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2>
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	  value="true">
                    <param name=ReadOnlyBackColor   value="#f5f5f5">
					<param name=SelectAll  	  value="true">
				</object>
				<%=HDConstant.COMMENT_END%></td>	

			<!-- <td>
				<input type="text" id="f_BP40SUM" name="f_BP40SUM" value="0" class="input02" size="12" style="text-align:right;ime-mode:disabled;" readonly>
			</td> -->
			<td></td>
		</tr>
	</table>
<!--	<input type="hidden" id="f_EMPNMK" name="f_EMPNMK" value=""> <C>Col=EMPNMK   	Ctrl=f_EMPNMK   		Param=value</C>
	<input type="hidden" id="f_STRTDT" name="f_STRTDT" value="">
	<input type="hidden" id="f_ENDDT" name="f_ENDDT" value=""> 
	<C>Col=BTAXCD01		Ctrl=txt_BTAXCD01		Param=value</C>
		<C>Col=BTAXCD02		Ctrl=txt_BTAXCD02		Param=value</C>
		-->
	<input type="hidden" id="f_YYYY" name="f_YYYY" value="">
	<input type="hidden" id="f_EMPNO" name="f_EMPNO" value="">

	<input type="hidden" id="txt_index" name="txt_index" value="">
	<input type="hidden" id="txt_BTAXNM01" name="txt_BTAXNM01" value="">	
	<input type="hidden" id="txt_BTAXCD01" name="txt_BTAXCD01" value="">
	<input type="hidden" id="txt_index2" name="txt_index2" value="">
	<input type="hidden" id="txt_BTAXNM02" name="txt_BTAXNM02" value="">	
	<input type="hidden" id="txt_BTAXCD02" name="txt_BTAXCD02" value="">			
</form>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=YYYY 		Ctrl=f_YYYY 			Param=value</C>
		<C>Col=EMPNO  		Ctrl=f_EMPNO  			Param=value</C>
		<C>Col=WKNM	    	Ctrl=f_WKNM	    		Param=value</C>
		<C>Col=WKRESINO 	Ctrl=f_WKRESINO 		Param=text</C>
	
		<C>Col=STRTDT		Ctrl=f_STRTDT			Param=text</C>
		<C>Col=ENDDT 		Ctrl=f_ENDDT 			Param=text</C>
		<C>Col=BP11000		Ctrl=f_BP11000			Param=text</C>
		<C>Col=BP12000		Ctrl=f_BP12000			Param=text</C>
		<C>Col=BP13000		Ctrl=f_BP13000			Param=text</C>
		<C>Col=BP10SUM		Ctrl=f_BP10SUM			Param=text</C>
		<C>Col=BP21000		Ctrl=f_BP21000			Param=text</C>
		<C>Col=BP22000		Ctrl=f_BP22000			Param=text</C>
		<C>Col=BP20SUM		Ctrl=f_BP20SUM			Param=text</C>
		<C>Col=BP31000		Ctrl=f_BP31000			Param=text</C>
		<C>Col=BP32000		Ctrl=f_BP32000			Param=text</C>
		<C>Col=BP33000		Ctrl=f_BP33000			Param=text</C>
		<C>Col=BP34000		Ctrl=f_BP34000			Param=text</C>
		<C>Col=BP30SUM		Ctrl=f_BP30SUM			Param=text</C>
		<C>Col=BP41000		Ctrl=f_BP41000			Param=text</C>
		<C>Col=BP42000		Ctrl=f_BP42000			Param=text</C>
		<C>Col=BP43000		Ctrl=f_BP43000			Param=text</C>
		<C>Col=BP40SUM		Ctrl=f_BP40SUM			Param=text</C>
		<C>Col=SEQ	 		Ctrl=f_SEQ	 			Param=text</C>
		
		<C>Col=BTAXAMT01	Ctrl=f_BTAXAMT01		Param=text</C>
		<C>Col=BTAXAMT02	Ctrl=f_BTAXAMT02		Param=text</C>
		<C>Col=BTAXNM01		Ctrl=txt_BTAXNM01		Param=value</C>
		<C>Col=BTAXNM02		Ctrl=txt_BTAXNM02		Param=value</C>
		<C>Col=BTAXCD01		Ctrl=gclx_btaxcd01		Param=BindColVal</C>
		<C>Col=BTAXCD02		Ctrl=gclx_btaxcd02		Param=BindColVal</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>

</body>
</html>
