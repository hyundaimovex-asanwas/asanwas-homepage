<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: ä�ǰ��з�����
+ ���α׷� ID: a070023.jsp
+ �� �� �� ��	: ä�ǰ��з�����
+ ��  ��   ��  : �� �� ��
+ �� �� �� �� : 2013.03.13
-----------------------------------------------------------------------------
+ �� �� �� �� : ��ǥ �� ���Ը��� ���ó���� ��� �ڱ� ( �濵������ ��û ) 
+ ��   ��  �� : ������
+ �� �� �� �� : 2017.03.02
-----------------------------------------------------------------------------
+ �� �� �� ��	: a070023_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>ä�ǰ��з�����</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;

<%
/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
	gclx_credgb_0.index = 0 ;
	
	gcem_recdat_fr.text = gs_date2+"01";
	gcem_recdat_to.text = gs_date;	
 }
 
<%
/******************************************************************************
	Description : ��ȸ
	//�˻�����
    //������ -   ����, ȸ����, ��������
    //������ -   ����, ȸ����, ��������  
******************************************************************************/
%>
function ln_Query(){ 
 
  	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_s1"
								     + "?v_str1="+gclx_credgb_0.BindColVal     
								 	 + "&v_str2="+txt_vend_nm_0.value   
								 	 + "&v_str3="+txt_vend_cd_0.value     
									 + "&v_str4="+gcem_recdat_fr.text       
									 + "&v_str5="+gcem_recdat_to.text;								 	 
								 	       
									     
	 //prompt('', gcds_code01.DataID);				
	gcds_code01.Reset();
}


<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Excel(){
     var strTitle="";
     strTitle ="ä��(��)�з� ��Ȳ ";
     gcgd_disp01.SetExcelTitle(1, "value:"+strTitle+"; font-face:��������u; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
	 gcgd_disp01.GridToExcel(strTitle,"",1);
}


<%
/******************************************************************************
	Description : ���  
******************************************************************************/
%>
function ln_Print(){

	        if (gcds_master.countrow<1){ 
	           var s_temp = "TITLE:STRING,USEDATE:STRING";
				gcds_master.SetDataHeader(s_temp);
			}
			
	        gcds_master.addrow();
	        gcds_master.namevalue(gcds_master.rowposition,"TITLE") = "ä��(��)�з� ��Ȳ";
	        gcds_master.namevalue(gcds_master.rowposition,"USEDATE") = gs_date;                                         
			gcrp_print.Preview();
			  
}


<%
/******************************************************************************
	Description : �ŷ�ó (��ȸ)
******************************************************************************/
%>
function ln_Popup_Vendcd(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vend_nm_0.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vend_cd_0.value = arrParam[0];
		 txt_vend_nm_0.value = arrParam[1];
	} else {
		 txt_vend_cd_0.value = "";
		 txt_vend_nm_0.value = "";
    }
}

<%
/******************************************************************************
	Description : �ŷ�ó (�Է�)
******************************************************************************/
%>
function ln_Popup_Vendcd2(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vend_nm.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vend_cd.value = arrParam[0];
		 txt_vend_nm.value = arrParam[1];
		 gcem_vend_id.text = arrParam[5];
		 
	} else {
		 txt_vend_cd.value = "";
		 txt_vend_nm.value = "";
		 gcem_vend_id.text ="";
    }
}


<%
/******************************************************************************
	Description : �߰�  
******************************************************************************/
%>
function ln_Add(){
	ln_SetDataHeader();;
	gcds_code01.Addrow();

}

<%
/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
%>

function ln_SetDataHeader(){

	if (gcds_code01.countrow<1){
		var s_temp = "VEND_CD:STRING(13),VEND_SEQ:STRING(3),VEND_NM:STRING(62),VEND_ID:STRING(15),CREDITOR:STRING(100),DEMAMT:DECIMAL(15),"
		           + "RECDAT:STRING(8),DEPDAT:STRING(8),CANDAT:STRING(8),CREDGB:STRING(1),REMARK:STRING(32),"
		           + "I_EMPNO:STRING(10),I_DATE:STRING(10),U_EMPNO:STRING(10),U_DATE:STRING(10)";
		gcds_code01.SetDataHeader(s_temp);
	}
}



<%
/******************************************************************************
	Description : üũ  
******************************************************************************/
%>
function ln_Chk(){

   // �ŷ�ó �ڵ� �� ������ üũ 
      for (var i =1; i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"VEND_CD")==""){
			alert( i + "���� �ŷ�ó �ڵ带 Ȯ�� �ϼ���");
			return false;
		}
    }
       
    if(!ln_Chk_Credgb()) return false; 
	
	//��Ź���� - ä�Ǳ��� ( ��Ź )
	//�������� - ä�Ǳ��� ( ���� )
	return true;
}

<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Save(){

	if(!ln_Chk()) return;

	if (gcds_code01.IsUpdated ){
		if (confirm("�����Ͻðڽ��ϱ� ?")) {
		  
			gctr_code01.KeyValue = "Account.a070023_t1(I:USER=gcds_code01)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t1";
            gctr_code01.Parameters="v_str1="+gusrid;

			gctr_code01.post();
		}
	}
}


<%
/******************************************************************************
	Description : ��Ź, ������ üũ 
	���� : 2017.03.03 ä��(��)�з� - 1, 2 �� ��� ��Ź���� �Է°���  by ������
	
******************************************************************************/
%>
function ln_Chk_Credgb(){

	if(gcem_depdat.text==""&&gclx_credgb.bindcolval=="3"){
		alert("��Ź���ڸ� Ȯ���ϼ���");
		return false;
	}else if (gcem_depdat.text!=""&&gclx_credgb.bindcolval!="3"){
		if(gclx_credgb.bindcolval=="4"){
			alert("ä�Ǳ�����  Ȯ���ϼ���");
			return false;	
		}
	}else if(gcem_candat.text==""&&gclx_credgb.bindcolval=="4"){
		alert("�������ڸ� Ȯ���ϼ���");
		return false;
	}else if (gcem_candat.text!=""&&gclx_credgb.bindcolval!="4"){
		//alert("ä�Ǳ�����  Ȯ���ϼ���");
		//return false;
	}
	
	return true;
}

<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Delete(){

	if (confirm("�����Ͻ� ä�ǰ��з� �����͸� �����Ͻðڽ��ϱ�?")){
		gcds_code01.deleterow(gcds_code01.rowposition);
		gctr_code01.KeyValue = "a070023_t1(I:USER=gcds_code01)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t1";
		gctr_code01.post();
	}
}



<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query2(strrow){ 
	
	if (gcds_code01.namevalue(strrow,"VEND_CD")==""){
		alert("�ŷ�ó���� ���� �Ͽ� �ֽʽÿ�.");
		return false;
	}
 
  	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_s2"
					   + "?v_str1="+gcds_code01.namevalue(strrow,"VEND_CD");     								 	 							    				
	
  	//prompt('',gcds_code02.DataID );
  	gcds_code02.Reset();
}


<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Delete2(){

	if (confirm("�����Ͻ� ��ǥ������� �����͸� �����Ͻðڽ��ϱ�?")){
		gcds_code02.deleterow(gcds_code02.rowposition);
		gctr_code01.KeyValue = "a070023_t2(I:USER=gcds_code02)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t2";
		gctr_code01.post();
	}
}
<%
/******************************************************************************
	Description : �߰�  
******************************************************************************/
%>
function ln_Add2(){
	ln_SetDataHeader2();
	gcds_code02.Addrow();
	
	gcds_code02.namevalue(gcds_code02.rowposition,"VEND_CD")=gcds_code01.namevalue(gcds_code01.rowposition,"VEND_CD");
	gcds_code02.namevalue(gcds_code02.rowposition,"VEND_NM")=gcds_code01.namevalue(gcds_code01.rowposition,"VEND_NM");
	
	if(gcds_code02.rowposition==1){
		gcds_code02.namevalue(gcds_code02.rowposition,"HIS_SEQ")=1;	
	}else if(gcds_code02.rowposition>1) {
		gcds_code02.namevalue(gcds_code02.rowposition,"HIS_SEQ")=gcds_code02.namevalue(gcds_code02.rowposition-1,"HIS_SEQ")+1;
	}
	
	gcds_code02.namevalue(gcds_code02.rowposition,"CERTI_DATE")=gs_date;
}

<%
/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
%>
function ln_SetDataHeader2(){

	if (gcds_code02.countrow<1){
		var s_temp = "VEND_CD:STRING(13),VEND_NM:STRING(62),HIS_SEQ:DECIMAL(2),CERTI_EMPNO:STRING(10),ENO_NM:STRING(20),CERTI_DATE:STRING(8),"
		           + "WRID:STRING(10),WRDT:STRING(10),UPID:STRING(10),UPDT:STRING(10)";
		gcds_code02.SetDataHeader(s_temp);
	}
}

<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Save2(){

	if(!ln_Chk2()) return;

	if (gcds_code02.IsUpdated ){
		if (confirm("�����Ͻðڽ��ϱ� ?")) {
		  
			gctr_code01.KeyValue = "Account.a070023_t2(I:USER=gcds_code02)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t2";
            gctr_code01.Parameters="v_str1="+gusrid;

			gctr_code01.post();
		}
	}
}

<%
/******************************************************************************
	Description : üũ  
******************************************************************************/
%>
function ln_Chk2(){

   // �ŷ�ó �ڵ� �� ������ üũ 
    for (var i =1; i<=gcds_code02.countrow;i++){
		if(gcds_code02.namevalue(i,"VEND_CD")==""){
			alert( i + "���� �ŷ�ó �ڵ带 Ȯ�� �ϼ���");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"VEND_NM")==""){
			alert( i + "���� �ŷ�ó ���� Ȯ�� �ϼ���");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"CERTI_EMPNO")==""){
			alert( i + "���� ��ǥ�ۼ��� ����� Ȯ�� �ϼ���");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"ENO_NM")==""){
			alert( i + "���� ��ǥ�ۼ��� ���� Ȯ�� �ϼ���");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"CERTI_DATE")==""){
			alert( i + "���� ��ǥ�ۼ����ڸ� Ȯ�� �ϼ���");
			return false;
		}		
    }
       
	return true;
}

<%
/******************************************************************************
	Description : ���� ��ǥ�ۼ��� ã�� 
******************************************************************************/
%>
function ln_Popup_Certi_Empno(row){
	
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_code02.namevalue(row,"CERTI_EMPNO")   = arrParam[1];
		gcds_code02.namevalue(row,"ENO_NM")        = arrParam[0];
	}else{
		gcds_code02.namevalue(row,"CERTI_EMPNO")="";
		gcds_code02.namevalue(row,"EMO_NM")  ="";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- ���з���Ȳ ��ȸ  -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
	<param name=SubSumExpr    value="1:VEND_CD">
</object>

<object  id=gcds_master classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- ��ǥ��� history  -->
<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
       	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
   	   document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
    var icnt=0;

   	if(gcds_code01.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}else {
	  	ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_code01.RealCount(1,row) + " ��";
	}
 
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>


<script language=JavaScript for=gcds_code02 event=OnDataError()>

alert("Error Code : " + gcds_code02.ErrorCode + "\n" +"Error Message : " + gcds_code02.ErrorMsg + "\n");

</script>
 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 
<script language=JavaScript for=gcem_depdat event=onKillFocus()>
	if(!ln_Chk_Credgb()) return; 
 </script>


<script language=JavaScript for=gcem_candat event=onKillFocus()>
	if(!ln_Chk_Credgb()) return; 
 </script>
 
 
<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
	ln_Query2(row);
</script>
 
<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	
	if(row>0){
		if(colid=="CERTI_EMPNO"){
			ln_Popup_Certi_Empno(row); 
		}
	}
</script>
  


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
    alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a070023_head.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_print.gif"       style="cursor:hand"  onclick="ln_Print()">
		    <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand"  onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">

	<tr> 
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>��������</td> 
		<td class="tab24"  colspan="7">&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_recdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_recdat_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_recdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		 value=0>
			<param name=Border	         value=true>
			<param name=Format	         value="YYYY/MM/DD">
			<param name=PromptChar	 value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_recdat_to', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>

	<tr> 
		<td width="80px"  class="tab27" bgcolor="#eeeeee" align=center>ä����</td>
		<td width="300px" class="tab28"  colspan =3>&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_nm_0" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="36" >
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd();">
			<input id="txt_vend_cd_0" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> ä�Ǳ���</td>  
	    <td width="300px"  class="tab28"  colspan=3>&nbsp;
			<comment id="__NSID__">
			<object id=gclx_credgb_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
				<param name=CBData			         value="A^��ü,1^ä��(��)�з�,3^��Ź,4^����">
				<param name=CBDataColumns	 value="CODE,NAME">
				<param name=SearchColumn	     value=NAME>
				<param name=Sort			             value=false>
				<param name=ListExprFormat       value="NAME">								
				<param name=BindColumn		     value="CODE">
			</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
</table>

<table id="div_disp1"  width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;width:858px; height:330px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='�ŷ�ó'	              ID=VEND_CD	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}  show =false</C>
					<C> Name='�ŷ�ó��(ä����)'      ID=VEND_NM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='����ڹ�ȣ'		      ID=VEND_ID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}MASK='XXX-XX-XXXXX'</C>
					<C> Name='ä���� '			  ID=CREDITOR	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} Value={Decode(curlevel,1,'��  ��',CREDITOR)}</C>
					<C> Name='û���ݾ�'             ID=DEMAMT       HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right	  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='��������'             ID=RECDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=69 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX' </C>
					<C> Name='��Ź����'             ID=DEPDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=69	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX'  </C>
					<C> Name='��������'		      ID=CANDAT       HeadAlign=Center HeadBgColor=#B9D4DC Width=69     align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} </C>
					<C> Name='ä�Ǳ���'	          ID=CREDGB   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=125    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} EditStyle=Combo  Data='1:ä�ǰ��з�,2:ä�Ǿз� �� �߽ɸ��,3:��Ź,4:����'</C>
					<C> Name='���'	        	  ID=REMARK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td class="tab31" ><b><font size="2" color="blue">[���з� ���]</font></b></td>
          <td align=right class="tab31" >
				<img id="btn_Delete08"   src="../../Common/img/btn/com_b_delete.gif"    style="cursor:hand;position:relative;top:2px;" onclick="ln_Delete()">
				<img id="btn_Insert08"   src="../../Common/img/btn/com_b_insert.gif"	    style="cursor:hand;position:relative;top:2px;" onClick="ln_Add()">
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Save()">
		  </td>
    </tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>ä����</td>
		<td width="310px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" readOnly>
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:1px" align=center onclick="ln_Popup_Vendcd2();">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:50px;height:20px;" readOnly >	
			<input id="txt_vend_seq" type="hidden" class="txtbox"  style= "position:relative;left:0px;top:0px;width:50px;height:20px;" maxlength="6" >			
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		
		<td width="80px"     class="tab24"   bgcolor="#eeeeee"  align=center ><nobr>����ڵ�Ϲ�ȣ</nobr></td>
		<td width="200px"   class="tab24" ><nobr>&nbsp;
		    <comment id="__NSID__"><nobr> 
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:100px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=1>
				<param name=Border	        value=True>
				<param name=Format	        value="000-00-00000">
				<param name=PromptChar	value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
				<param name=ReadOnly      value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr> 
		</td>
	
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center> ��������</td>  
	    <td width="130px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_recdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_recdat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>ä����</td>
		<td width="310px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_creditor" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="36" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		
		<td width="80px"     class="tab24"   bgcolor="#eeeeee"  align=center ><nobr>û���ݾ�</nobr></td>
		<td width="200px"   class="tab24" ><nobr>&nbsp;
		    <comment id="__NSID__"><nobr> 
			<object id=gcem_demamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:100px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=2>
				<param name=Border	        value=True>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr> 
		</td>
	
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center> ��Ź����</td>  
	    <td width="130px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_depdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_depdat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>ä�Ǳ���</td>
		<td width="310px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_credgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:180px;">
				<param name=CBData			         value="1^ä�ǰ��з�,2^ä�Ǿз� �� �߽ɸ��,3^��Ź,4^����">
				<param name=CBDataColumns	 value="CODE,NAME">
				<param name=SearchColumn	     value=NAME>
				<param name=Sort			             value=false>
				<param name=ListExprFormat       value="NAME">								
				<param name=BindColumn		     value="CODE">
			</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td> 
		
		<td width="80px"     class="tab24"   bgcolor="#eeeeee"  align=center ><nobr>���</nobr></td>
		<td width="200px"   class="tab24"   ><nobr>&nbsp;
		    <comment id="__NSID__"><nobr> 
			<object id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:180px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=0>
				<param name=Border	        value=True>
	            <param name=GeneralEdit   value="true">		
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr> 
		</td>
	
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center> ��������</td>  
	    <td width="130px"  class="tab24" >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_candat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_candat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td class="tab31" ><b><font size="2" color="blue">[��ǥ�������]</font></b></td>
          <td align=right class="tab31" >
				<img id="btn_Delete08"   src="../../Common/img/btn/com_b_delete.gif"    style="cursor:hand;position:relative;top:0px;" onclick="ln_Delete2()">
				<img id="btn_Insert08"   src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:0px;" onClick="ln_Add2()">
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:0px;" onclick="ln_Save2()">
		  </td>
    </tr>
    
    <tr>
    	<td colspan =2>
    		<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			  style="position:relative;left:0px;width:858px; height:110px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code02">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='�ŷ�ó'	            ID=VEND_CD		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	    align=center  edit=none  bgcolor='#eeeeee'</C>
					<C> Name='�ŷ�ó��'	        ID=VEND_NM        HeadAlign=Center HeadBgColor=#B9D4DC Width=200    align=left    edit=none  bgcolor='#eeeeee'</C>
					<C> Name='����'	        	ID=HIS_SEQ   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30     align=center  edit=none  bgcolor='#eeeeee'</C>
                    <C> Name='��ǥ�ۼ���'	        ID=CERTI_EMPNO	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  EditStyle=Popup </C>
                    <C> Name='��ǥ�ۼ���'	        ID=ENO_NM	      HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none  bgcolor='#eeeeee'</C>
					<C> Name='��ǥ�ۼ�����'		ID=CERTI_DATE  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee' </C>
					<C> Name='�ۼ���'	            ID=WRID     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none  bgcolor='#eeeeee'</C>
					<C> Name='ó���Ͻ�'		    ID=WRDT     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none  bgcolor='#eeeeee' </C>	
					<C> Name='������'	            ID=UPID     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  show = false bgcolor='#eeeeee'</C>
					<C> Name='��������'		    ID=UPDT     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  show=false  bgcolor='#eeeeee'</C>	
					">
			</object></comment><script>__ws__(__NSID__);</script>
    	</td>
    </tr>
</table>


<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			value="gcds_master">
	<param name="DetailDataID"			value="gcds_code01">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="FixPaperSize"		    VALUE="true">
	<PARAM NAME="PrintMargine"			VALUE="false">
	<PARAM NAME="NullRecordFlag"	    VALUE="false">
	<PARAM NAME="Format"                VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=381 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=995 ,top=98 ,right=1929 ,bottom=376 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1344 ,top=310 ,right=1320 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1580 ,top=312 ,right=1556 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1804 ,top=310 ,right=1781 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1103 ,top=312 ,right=1080 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=304 ,right=1924 ,bottom=304 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=156 ,right=1924 ,bottom=156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1693 ,top=98 ,right=1693 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1463 ,top=98 ,right=1463 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1228 ,top=98 ,right=1228 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=1699 ,top=101 ,right=1924 ,bottom=153 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ  ��' ,left=1466 ,top=101 ,right=1691 ,bottom=153 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1233 ,top=101 ,right=1458 ,bottom=153 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1000 ,top=101 ,right=1225 ,bottom=153 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=995 ,top=32 ,right=1929 ,bottom=98 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='��     ��     ��   (  ��� :               )' ,left=1024 ,top=40 ,right=1900 ,bottom=93 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>	
	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=288 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='Page : #p of #t' ,left=1508 ,top=143 ,right=1929 ,bottom=191 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=204 ,right=1958 ,bottom=204 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TITLE', left=50, top=45, right=1926, bottom=132, face='����', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='ä�Ǳ���' ,left=1651 ,top=213 ,right=1950 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='������' ,left=1463 ,top=213 ,right=1638 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��Ź��' ,left=1283 ,top=213 ,right=1458 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='������' ,left=1103 ,top=213 ,right=1278 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='û���ݾ�' ,left=844 ,top=213 ,right=1090 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='ä����' ,left=463 ,top=213 ,right=836 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='ä����' ,left=21 ,top=213 ,right=450 ,bottom=288 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>

	<L> left=19 ,top=204 ,right=19 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1958 ,top=204 ,right=1958 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=455 ,top=204 ,right=455 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=839 ,top=204 ,right=839 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1095 ,top=204 ,right=1095 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1281 ,top=204 ,right=1281 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1463 ,top=204 ,right=1463 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1643 ,top=204 ,right=1643 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='USEDATE', left=45, top=143, right=265, bottom=191, align='left' ,mask='XXXX.XX.XX', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=74 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=19 ,top=0 ,right=19 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=19 ,top=74 ,right=1958 ,bottom=74 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=19 ,top=0 ,right=1958 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(CREDGB,1,\'ä�ǰ��з�\',2,\'ä�Ǿз� �� �߽ɸ��\',3,\'��Ź\',4,\'����\',CREDGB)}', left=1651, top=5, right=1950, bottom=66, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1643 ,top=0 ,right=1643 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='CANDAT', left=1463, top=5, right=1638, bottom=66, align='center' ,mask='XXXX/XX/XX', face='����', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1463 ,top=0 ,right=1463 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DEPDAT', left=1283, top=5, right=1458, bottom=66, align='center' ,mask='XXXX/XX/XX', face='����', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1281 ,top=0 ,right=1281 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='RECDAT', left=1103, top=5, right=1278, bottom=66, align='center' ,mask='XXXX/XX/XX', face='����', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1095 ,top=0 ,right=1095 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DEMAMT', left=844, top=5, right=1090, bottom=66, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=839 ,top=0 ,right=839 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'               ��\',CREDITOR)}', left=463, top=5, right=836, bottom=66, align='left', face='����', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=455 ,top=0 ,right=455 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'               ��\',VEND_NM)}', left=21, top=5, right=450, bottom=66, align='left', face='����', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2788 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1550 ,top=0 ,right=1929 ,bottom=82</I>
	<L> left=45 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_code01">
<PARAM NAME="BindInfo" VALUE="
	<C>Col=VEND_CD		  Ctrl=txt_vend_cd		Param=value</C>
	<C>Col=VEND_SEQ		  Ctrl=hid_vend_seq	    Param=value</C>
	<C>Col=VEND_NM		  Ctrl=txt_vend_nm		Param=value</C>
	<C>Col=VEND_ID		  Ctrl=gcem_vend_id	    Param=Text</C>
	<C>Col=CREDITOR		  Ctrl=txt_creditor	    Param=value</C>
	<C>Col=DEMAMT		  Ctrl=gcem_demamt	    Param=Text</C>
	<C>Col=RECDAT		  Ctrl=gcem_recdat	    Param=Text</C>
	<C>Col=DEPDAT   	  Ctrl=gcem_depdat      Param=Text</C>
	<C>Col=CANDAT		  Ctrl=gcem_candat		Param=Text</C>
	<C>Col=CREDGB		  Ctrl=gclx_credgb		Param=bindcolval</C>
	<C>Col=REMARK		  Ctrl=gcem_remark		Param=Text</C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 