<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: ���ø����������
 * ���α׷�ID 	: P030010_house1
 * J  S  P		: P030010_house1,P030010_08s
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������	: 
 *                   
 * ������������ 	: 2011-01-12
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");				//���
%>

<html>
<head>
<title><%=eyy%> �� �ٷμҵ���� ���ο���, ��������, ����ֽ�������� �� �Է�</title>
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

		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ

	}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //������ : �Ķ���� �޾Ƽ� �⺻ ��ȸ

			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i_08",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);

			//prompt(this, ds1.text);
			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')="none"; //�ԷºҰ���
	}
	
/******************************************************************************
	Description : �߰�
******************************************************************************/
	function fnAddRow(){

		ds1.AddRow();		//�����ͼ� ��� ������ �ȵǼ� �׳��ϸ� �ȵǾ���..
							// ó�� ��ȸ�Ҷ� ��������� �޾ƿ´�. ������ ����ȸ�� �Ѵ�..

		ds1.namevalue(ds1.RowPosition, "APPYY") = ds1.namevalue(1, "APPYY");
		ds1.namevalue(ds1.RowPosition, "EMPNMK") = ds1.namevalue(1, "EMPNMK");
		ds1.namevalue(ds1.RowPosition, "EMPJUNO") = ds1.namevalue(1, "EMPJUNO");
		ds1.namevalue(ds1.RowPosition, "DUDGB") = ds1.namevalue(1, "DUDGB");		
		ds1.namevalue(ds1.RowPosition, "EMPNO") = ds1.namevalue(1, "EMPNO");

	}
	
/******************************************************************************
	Description : ����
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

		//prompt(this,(ds1.namevalue(ds1.rowposition,"STATDT")));

	    if(!Pension_Apply_Chk()) return;

        if (ds1.IsUpdated) {

			if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			}

			v_job = "I";	

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"        
				
            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_08",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);

        } else {
            alert("�� ������ ���� ������ �����ϴ�.");
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
	Description : Ȯ���۾�
******************************************************************************/
    function Pension_Apply_Chk() {




			//if((ds1.namevalue(ds1.rowposition,"STATDT")).length != 8){
			//		alert("�������� �ڸ����� ���� �ʽ��ϴ�.");
			//		return false;
			//}

		if(ds1.namevalue(ds1.rowposition,"DUDGB") != '41' ){	
		if(ds1.namevalue(ds1.rowposition,"STATDT") >= '20110101' ){
		alert("�������� ��� 2011�� ���� �ڷḸ �Է¹ٶ��ϴ�.");
		return false;
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20101231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20100101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "1";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20091231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20090101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "2";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20081231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20080101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "3";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20071231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20070101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "4";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20061231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20060101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "5";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20051231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20050101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "6";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20041231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20040101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "7";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20031231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20030101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "8";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20021231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20020101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "9";
		}else if(ds1.namevalue(ds1.rowposition,"STATDT") <= '20011231' && ds1.namevalue(ds1.rowposition,"STATDT") >= '20010101'){
		ds1.namevalue(ds1.rowposition,"YEARLY") = "10";
		}else{
		ds1.namevalue(ds1.rowposition,"YEARLY") = "11";		
		}
		}


	if(ds1.namevalue(ds1.rowposition,"DUDGB") == '21' ){
		if(ds1.namevalue(ds1.rowposition,"STATDT") > '20010101'){
		alert("���ο��������� 2000�� 12�� 31�� ���� ������ ���ุ �Է��� �� �ֽ��ϴ�.");		
		ds1.namevalue(ds1.rowposition,"STATDT")="";
		return false;
		}
	}

	if(ds1.namevalue(ds1.rowposition,"DUDGB") == '22' ){
		if(ds1.namevalue(ds1.rowposition,"STATDT") < '20010101'){
		alert("���������� 2001�� 1�� 1�� ���� ������ ���ุ �Է��� �� �ֽ��ϴ�.");		
		ds1.namevalue(ds1.rowposition,"STATDT")="";
		return false;
		}
	}

		if(ds1.namevalue(ds1.rowposition,"ACCNO") == ""){
		alert("���¹�ȣ�� �ʼ��Է� �����Դϴ�.");		
		return false;
		}

		if(ds1.namevalue(ds1.rowposition,"STATDT") == ""){
		alert("�������� �ʼ��Է� �����Դϴ�.");		
		return false;
		}

            return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/

	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 

	function fnClose()	{
		window.close();
		opener.fnSelect11("<%=eyy%>", "<%=eno%>");		//����
	}
	

function openFinance(){

	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	strURL = "P030010_financeselect.jsp"
	strPos = "dialogWidth:380px;dialogHeight:400px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no"; 

	arrResult = showModalDialog(strURL,arrSend,strPos);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.RowPosition, "FINACD") = arrParam[0]; 
			ds1.namevalue(ds1.RowPosition, "FINANM") = arrParam[1]; 
		} 
}

</script>




<script language=JavaScript for=gr1 event=OnCloseUp(row,colid)>


			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')="none"; //�ԷºҰ���

	if(ds1.namevalue(ds1.rowposition,"DUDGB") == '41' ){

	//alert("1");
		//YEARLY.enable = "false";
			//alert(ds1.namevalue(ds1.RowPosition, "YEARLY"));		
			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')=""; //�Է°���

	}else{


			ds1.namevalue(ds1.RowPosition, "YEARLY") ="-";	
			getObjectFirst("gr1").ColumnProp('YEARLY','Edit')="none"; //�ԷºҰ���
			//ds1.namevalue(ds1.RowPosition, "YEARLY").ReadOnly = "false";
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



<script language=javascript for="gr1" event="OnClick(row, Colid)">
//Ŭ���� �� �˾� ����
    var strResino="";
	var strGb="";
	var strGb2="";



    if(row<1){
     return;
    }

    if (Colid =="FINANM") { 
    	//alert(ds1.namevalue(ds1.rowposition, "RESINO1"));
    	openFinance();
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

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<form name="entry" method="post" action="">
	<!-- �������� �� �����׸� -->
	<table width="975" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="10">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3">�� �Է¾ȳ�</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#000000">1. ��� �׸���� ��Ȯ�� ������ �Է��ϼž� �մϴ�.</font></td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">2. ������԰��Ⱓ ���� �� ������ ���·� ���޹޴� �������μ� ���� ����� ���� �����Դϴ�.

						</font></b>
						</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">3. ��������� ��� �˾�â���� �˻��� ���ؼ� �����մϴ�.<br></font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#000000">4. ���������� ���� �Է¼����� ��ġ�ǵ��� �����Ͽ� �ֽñ� �ٶ��ϴ�.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(A4ũ�⺸�� ���� ���������� A4 �̸����� ���� �� ������)</font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="red">5. ������ ����ֽ��������� ��쿡�� ���� �����Ͻñ� �ٶ��ϴ�.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(�� ���� ������ ���� �Է� �ʿ����)</font>
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
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 970px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick" value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<FC> Name='�ͼӳ��'		ID=APPYY   		Width=70	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1 show=false</FC>
	<G> name='�ٷμҵ���'
		<FC> Name='����'		ID=EMPNMK  		Width=60	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='�ֹι�ȣ'	ID=EMPJUNO  	Width=120	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2</FC>
	</G>

	<G> name='�� ��'
		<FC> Name='����'		ID=DUDGB		Width=170	HeadAlign=Center align=center EditStyle=Combo 
			 Data='11:��������,12:���б���ΰ���,21:���ο�������,22:��������,41:����ֽ�������ҵ����'</FC>
		<FC> Name='����'	ID=YEARLY  	Width=70	HeadAlign=Center align=center EditStyle=Combo Data='1:1����,2:2����,3:3����'</FC>
	</G>

	<C> Name='��������ڵ�'		ID=FINACD     Width=240	HeadAlign=Center align=LEFT show=TRUE	EDIT=none show=false</C>
	<C> Name='�������'			ID=FINANM     Width=180	HeadAlign=Center align=center show=TRUE	</C>
	<C> Name='���¹�ȣ'			ID=ACCNO     Width=140	HeadAlign=Center align=center show=TRUE	Edit=numeric editlimit=16</C> 	
	<C> Name='������'				ID=STATDT     Width=110	HeadAlign=Center align=center show=TRUE	mask='XXXX-XX-XX' editlimit=8</C> 	
	<C> Name='���Ծ�'				ID=PAYAMT     Width=120	HeadAlign=Center align=right show=TRUE	 Dec=0 editlimit=8</C> 		
	<C> Name='������'				ID=DEDAMT     Width=100	HeadAlign=Center align=right show=false	 Dec=0</C> 	

	<C> Name='���'	    	ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    	ID=FLAGCOL		Width=20	show=false</C>	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>



</body>
</html>
