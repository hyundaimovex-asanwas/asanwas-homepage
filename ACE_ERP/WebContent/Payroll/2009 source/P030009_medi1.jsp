      <%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030009_medi1
 * J  S  P		: P030009_03i,P030009_03s
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
<title>2006�� �ٷμҵ���� �Ƿ�� �� �Է�</title>
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
			    "../services/servlet/Payroll.p030009i_03",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	
/******************************************************************************
	Description : �߰�, ����, ����, ���
******************************************************************************/
	function fnAddRow(){
		ds1.AddRow();		//�����ͼ� ��� ������ �ȵǼ� �׳��ϸ� �ȵǾ���..
							// ó�� ��ȸ�Ҷ� ��������� �޾ƿ´�. ������ ����ȸ�� �Ѵ�..
	
		ds1.namevalue(ds1.RowPosition, "APPDT") = ds1.namevalue(1, "APPDT");
		ds1.namevalue(ds1.RowPosition, "EMPNMK") = ds1.namevalue(1, "EMPNMK");
		ds1.namevalue(ds1.RowPosition, "EMPJUNO") = ds1.namevalue(1, "EMPJUNO");
		ds1.namevalue(ds1.RowPosition, "FAMNMK") = ds1.namevalue(1, "FAMNMK");
		ds1.namevalue(ds1.RowPosition, "FAMRELA_NM") = ds1.namevalue(1, "FAMRELA_NM");
		ds1.namevalue(ds1.RowPosition, "FAMJUNO") = ds1.namevalue(1, "FAMJUNO");
		ds1.namevalue(ds1.RowPosition, "EMPNO") = ds1.namevalue(1, "EMPNO");
		ds1.namevalue(ds1.RowPosition, "FAMRELA_CD") = ds1.namevalue(1, "FAMRELA_CD");
		ds1.namevalue(ds1.RowPosition, "REF1")= ds1.namevalue(1, "REF1");
		ds1.namevalue(ds1.RowPosition, "REF2")= ds1.namevalue(1, "REF2");
		ds1.namevalue(ds1.RowPosition, "REF3")= ds1.namevalue(1, "REF3");
		ds1.namevalue(ds1.RowPosition, "REF4")= ds1.namevalue(1, "REF4");
		ds1.namevalue(ds1.RowPosition, "REF5")= ds1.namevalue(1, "REF5");
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
                "../services/servlet/Payroll.p030009i_03",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�Ƿ�� �� ������ ���� ������ �����ϴ�.");
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
<table width="970" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">�� �Է¾ȳ�</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td>1. ��� �׸���� ��Ȯ�� ������ �Է��ϼž� �մϴ�.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">2. <b><u>������� ���� ����ó�� ���� �� ������ ��� "���� �Ѿ�"�� �Է��Ͻø� �˴ϴ�.</b></u></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">3. �ݾ�(�Ѿ� - ���ܡ������ںδ�� = ȯ�ںδ��)�� ������ "����"�� �����Ͽ� �Է��ϼž� �մϴ�.</font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>4. ���������� �Ƿ�� ���޳��� �Է¼����� ��ġ�ǵ��� �����Ͽ� �ֽñ� �ٶ��ϴ�.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(A4 ũ�⺸�� ���� ���������� A4 �̸����� ���� �� ������)
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font style="font-size:12pt;color:#3366FF;"><b>�� <u>1�δ� �÷º����� �Ȱ�(����) ���Ժ� �� 50������ �ʰ��ϴ� ��� 50���������� �Է¹ٶ��ϴ�.</u><br>
						&nbsp;&nbsp;&nbsp;&nbsp;<u>(�� 50���� �ѵ���)</u></b></font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right"><br><font color="#FF6633">�� �ſ�ī��(���ݿ�����)��� �Ƿ���� ���߰��� ���������� 2007������ ����ʿ� ����
						"�������"�� ������� Ȱ��ȭ�� �ݾ׶��� �Է��Ͻø� �˴ϴ�.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
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
							��<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">							
						</nobr>&nbsp;</td>
					</tr>					
				</table>
			</td>
		</tr>
	</table>

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 970px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
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
	<FC> Name='���'				ID=APPDT   		Width=50	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1</FC>
	<G> name='�ٷμҵ���'
		<FC> Name='����'				ID=EMPNMK  		Width=60	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='�ֹι�ȣ'			ID=EMPJUNO  	Width=90	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2</FC>
	</G>
	<G> name='�� �� �� �� ��'
		<FC> Name='����'				ID=FAMNMK		Width=60	HeadAlign=Center align=center  EDIT=NONE  SUPPRESS=3</FC>
		<FC> Name='����'		ID=FAMRELA_NM	Width=50	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=3</FC>
		<FC> Name='�����ֹι�ȣ'		ID=FAMJUNO		Width=90	HeadAlign=Center align=center	 mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=3</FC>
	</G>

	<G> name='����ó'
		<C> Name='����ڹ�ȣ'		ID=INDNO 		Width=90	HeadAlign=Center align=center  mask='XXX-XX-XXXXX' EDIT=NUMERIC</C>	
		<C> Name='��   ȣ'			ID=INDNAME		Width=160	HeadAlign=Center align=center </C>
	</G>
	<G> name='����û�ڷ�'
		<C> Name='�Ǽ�'			ID=CARDCNTA		Width=50	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='�� ��'			ID=CARDAMTA		Width=100	HeadAlign=Center align=RIGHT  EDIT=NUMERIC</C>	
	</G>		
	<G> name='�׹��� �ڷ�'
		<C> Name='�Ǽ�'			ID=CARDCNTB		Width=50	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='�� ��'			ID=CARDAMTB		Width=100	HeadAlign=Center align=RIGHT  EDIT=NUMERIC</C>	
	</G>

	<C> Name='���'				ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	show=false</C>	
	<C> Name='�����ڵ�'			ID=FAMRELA_CD	Width=35	HeadAlign=Center align=center show=false SUPPRESS=3</C>		
	<C> Name='�ܱ���YN'			ID=REF1   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='100��������YN'		ID=REF2   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='�����YN'			ID=REF3   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='�ڳ�YN'			ID=REF4   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='���YN'			ID=REF5   		Width=40	HeadAlign=Center align=center show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>


</body>
</html>
