      <%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �Ƿ�����
 * ���α׷�ID 	: P030010_medi1
 * J  S  P		: P030010_03i,P030010_03s
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������	: 
 *                   
 * ������������ 	: 2011-01-5
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");				//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");				//���
    String eJuno 		 = request.getParameter("eJuno");			//������� �ֹι�ȣ
%>

<html>
<head>
<title><%=eyy%> �� �ٷμҵ���� �Ƿ�� �� �Է�</title>
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
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //���
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	

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
			    "/services/servlet/Payroll.p030010i_03",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	
/******************************************************************************
	Description : �߰�, ����, ����, ���
******************************************************************************/
	function fnAddRow(){

		//prompt(this, ds1.namevalue(1, "APPDT"));

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
	

/******************************************************************************
	Description : �����
******************************************************************************/

	function fnDeleteRow() {//Row ����
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds1.DeleteRow(ds1.RowPosition);
	}
	

/******************************************************************************
	Description : ����
******************************************************************************/

    function fnApply() {// ���� �����ͼ� �ݿ�

		//prompt(this, ds1.text);
		
		if(!Medi_Apply_Chk("ds1")) return;
		
        if (ds1.IsUpdated) {        
			if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			}

			v_job = "I";	

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_03",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);

        } else {
            alert("�Ƿ�� �� ������ ���� ������ �����ϴ�.");
        }

    }
    
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


/******************************************************************************
	Description : ���
******************************************************************************/

	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 

	function fnClose()	{
		window.close();
		opener.fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
	}



/******************************************************************************
	Description :  �����ڵ尡 1�̸� ����ڹ�ȣ,��ȣ,�Ǽ�, �� ���� �͵� �Է� ���� 
******************************************************************************/
	function ln_Grid_Prfcdlock(row){

		if(ds1.namevalue(row,"PRFCD")=="1"){
			getObjectFirst("gr1").ColumnProp('INDNO','Edit')="none"; //�ԷºҰ�
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="none";
			getObjectFirst("gr1").ColumnProp('CASHCNTB','Edit')="none";
			getObjectFirst("gr1").ColumnProp('CASHAMTB','Edit')="none";
			alert("�����ڵ尡 1:����û���� �����ϴ� �Ƿ���ڷ��� ��� ��������� ���� �Ƿ�� �����հ�׸� �Է��ϼ���");
		} else{
            getObjectFirst("gr1").ColumnProp('INDNO','Edit')=""; //�Է°���
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="";
			getObjectFirst("gr1").ColumnProp('CASHCNTB','Edit')="";
			getObjectFirst("gr1").ColumnProp('CASHAMTB','Edit')="";
	    }
    }
</script>


<script language=javascript for="gr1" event="OnClick(row, Colid)">
	if(ds1.namevalue(row,"PRFCD")=="1"){
			getObjectFirst("gr1").ColumnProp('INDNO','Edit')="none"; //�ԷºҰ�
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="none";
		} else{
			getObjectFirst("gr1").ColumnProp('INDNO','Edit')=""; //�Է°���
			getObjectFirst("gr1").ColumnProp('INDNAME','Edit')="";
	    }
</script>


<script language="javascript" for="tr1" event="onsuccess()">

    if(v_job=="I") {	//����
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose(); 
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";

    }

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

<script language=JavaScript for=gr1 event=OnCloseUp(row,colid)>
    if(colid=="PRFCD"){ //�����ڵ尡 1�̸� ����ڹ�ȣ,��ȣ,�Ǽ� �Է� ���� 
		ln_Grid_Prfcdlock(row);
    }
</script>

<script language=JavaScript for=ds1 event="OnLoadCompleted(Row)">
	if(Row>0){
		for(i=1;i<=Row;i++){
		}
    }	
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


<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<form name="entry" method="post" action="">
	<!-- �������� �� �����׸� -->
   <br>
   <b><font face="����">&nbsp;�� �Ƿ�����</a></font></b> 
   <b><font color="EA5200" size="2" face="����"> &nbsp;(���� ����� ����, �ҵ� ���� ����)</font></b><br>
   <table width="970" border="0" cellspacing="0" cellpadding="0">
      <tr bgcolor="#FFFFFF">
	    <td height="85">
		   <table width="100%" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
		   <tr bgcolor="#FFF8EE">
				<td width="115">
					<div align="center"><font face="����">�� ��</font></div>
				</td>
				<td width="600">
					<div align="center"><font face="����">�� �� �� �� �� ��</font></div>
				</td>
				<td width="250">
					<div align="center"><font face="����">�� �� �� ��</font></div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="115" bgcolor="#FFF8EE">
					<div align="center"><font face="����">�⺻���� </font></div>
				</td>
				<td width="600"><font face="����">�⺻���������(����,�ҵ�ҹ�) �� ����,65�� �̻���, ������� ���Ͽ� ������ �Ƿ��</font>
				</td>

				<td width="250">
					<div align="center"><font face="����">���� �Ƿ������(��, �Ʒ��� �߰������� �������̸� �⺻�������� ����) </font></div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="115" bgcolor="#FFF8EE">
					<div align="center"><font face="����">�߰����� </font></div>
				</td>
				<td width="600"><font face="����">�⺻���������(����,�ҵ�ҹ�) �� ����, 65�� �̻���, ����� �̿��� �ڸ� ���Ͽ� ������ �Ƿ��</font>
				</td>
				<td width="250">
					<div align="center"><font face="����">Min(���� �Ƿ��-�ѱ޿��ס�3%, 700����) </font></div>
				</td>
			</tr>
		 </table>
		</td>
	</tr>

	<tr bgcolor="#FFFFFF">
	       <td  height="50">
			<font color="#7800BF" size="2" face="����">&nbsp;�� ���� </font> <br><b>
			&nbsp;�ҵ��������Ƿ�� �̿������������ ���� ��� �� �ǰ������� ���� �Ǿ�ǰ ���Ժ���� ������</b><br>
            &nbsp;- �̿������������(����Ȯ��, ��������, ���彺, �����ϸ�, ����̽�, ��ġ�� ��)<br>
            &nbsp;- ����, ��Ÿ�� �ǰ����� �Ǿ�ǰ<br>
			</td>
	</tr>
    <tr bgcolor="#FFFFFF">
		<td colspan="12" height="30">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="2">&nbsp;�� �Է¾ȳ�</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><font color="#FF6633">1. �ݾ�(�Ѿ� - ���ܡ������ںδ�� = ȯ�ںδ��)��  �Է��ϼž� �մϴ�. <br>
					2. 1�δ� �÷º����� �Ȱ�(����) ���Ժ� �� 50������ �ʰ��ϴ� ��� 50���������� �Է¹ٶ��ϴ�.<br>

					</font></td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
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

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 970px; HEIGHT: 290px;border:1 solid #777777;display:;" viewastext>
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
	<FC> Name='���'			 ID=APPDT   		Width=50	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1 show=false</FC>
	<G> name='�ٷ���'
		<FC> Name='����'		 ID=EMPNMK  	Width=45	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='�ֹι�ȣ'	 ID=EMPJUNO  	Width=90	HeadAlign=Center align=left mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2 </FC>
	</G>
	<G> name='�� �� �� �� ��'
		<FC> Name='����'		 ID=FAMNMK		Width=45	HeadAlign=Center align=center  EDIT=NONE  SUPPRESS=3</FC>
		<FC> Name='����'		 ID=FAMRELA_NM	Width=88	HeadAlign=Center align=center  SUPPRESS=3</FC>
		<FC> Name='�����ֹι�ȣ' ID=FAMJUNO		Width=89	HeadAlign=Center align=center	 mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=3</FC>
	</G>
	<G> name='����ó'
		<C> Name='�����ڵ�'		ID=PRFCD		Width=208  HeadAlign=Center align=center EditStyle=Combo Data='1:����û���� �����ϴ� �Ƿ�� �ڷ�,2:���ΰǰ���������Ƿ��δ����,3:������꼭/�������꼭,4:�����޿����,5:��Ÿ�Ƿ�񿵼���'</C>
		<C> Name='����ڹ�ȣ'	ID=INDNO 		Width=82	HeadAlign=Center align=center  mask='XXX-XX-XXXXX' EDIT=NUMERIC</C>	
		<C> Name='��   ȣ'		ID=INDNAME		Width=130	HeadAlign=Center align=center </C>
	</G>

	<G> name='����û�ڷ�'
		<C> Name='�Ǽ�'			ID=CASHCNTA		Width=26	HeadAlign=Center align=center  EDIT=NUMERIC </C>
		<C> Name='����' 		ID=CASHAMTA		Width=70	HeadAlign=Center align=RIGHT   EDIT=NUMERIC dec=0 </C>	
	</G>		
	<G> name='�׹��� �ڷ�'
		<C> Name='�Ǽ�'			ID=CASHCNTB		Width=26	HeadAlign=Center align=center  EDIT=NUMERIC </C>	
		<C> Name='����' 		ID=CASHAMTB		Width=70	HeadAlign=Center align=RIGHT  EDIT=NUMERIC dec=0 </C>	
	</G>
	<C> Name='���'				ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	show=false</C>	
	<C> Name='�����ڵ�'			ID=FAMRELA_CD	Width=35	HeadAlign=Center align=center show=false SUPPRESS=3</C>		
	<C> Name='�ܱ���YN'			ID=REF1   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='100��������YN'	ID=REF2   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='�����YN'			ID=REF3   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='�ڳ�YN'			ID=REF4   		Width=40	HeadAlign=Center align=center show=false</C>
	<C> Name='���YN'			ID=REF5   		Width=40	HeadAlign=Center align=center show=false</C>
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>


</body>
</html>
