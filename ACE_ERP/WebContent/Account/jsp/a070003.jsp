<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ڱݰ��� - �ְ��ڱݽ�û
+ ���α׷� ID	: A700003.html
+ �� �� �� ��	: �Է�,��ȸ,����,���� ȭ���̴�.
+ ��   ��  �� :   
+ �� �� �� ��	:	
------------------------------------------------------------------------------
+ �� �� �� ��  :	�˾�â ���� �� �������� ����   
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.12.13
-----------------------------------------------------------------------------
+ �� �� �� ��	: a070003_s1, a070003_s2
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ְ��ڱݽ�û</title> 


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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	ln_DispChk(0);
	
	if (gs_userid=="ACCOUNT"){
		gs_userid="1990046";
		gs_fdcode = '02';
		gs_deptcd= 'C260';
		gs_deptnm='ȸ����';
		gs_cocode='02';
	}
	gclx_week2.index =0;
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(s){
	
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				  //�����ڵ�   
		var str2  = gclx_cadeptcd.BindColVal;					//�μ��ڵ�       
		var str3  = fn_trim(gcem_sgetdatefr1.text);	  //��û���
		var str4  = gclx_week1.bindcolval;
		var str5  = gs_userid;          //ID üũ 
		var str6 = "";	//���а�


		if (str5 =="ACCOUNT"||str5 =='2060005' ||str5=='2020029'||str5=='6060001') {
			str6 = "1";
		}else  {
			str6 = "2";
		}

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070003_s1?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+"&v_str4="+str4+"&v_str6="+str5+"&v_str7="+str6;

       //prompt('',gcds_data1.DataID);
		
		gcds_data1.Reset();
	
	}else if(s=="02") {

		var str1  = gclx_sfdcode2.BindColVal;				    //�����ڵ�   
		var str2  = gclx_cadeptcd2.BindColVal;					//�μ��ڵ�       
		var str3  = fn_trim(gcem_sgetdatefr2.text);	    //��û���
		var str4  = gclx_week2.BindColVal;							//�ְ�����
		var str5  = gs_userid;          //ID üũ 
		var str6 = "";	//���а�

		if (str5 =="ACCOUNT"||str5 =='2060005' ||str5=='2020029'||str5=='6060001') {
			str6 = "1";
		}else  {
			str6 = "2";
		}
  
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070003_s2?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
							 			                                     +"&v_str4="+str4+"&v_str6="+str5+"&v_str7="+str6;
		//prompt('',gcds_data2.DataID);
		
		gcds_data2.Reset();
	}
}

/******************************************************************************
	Description : �ߺ�üũ
******************************************************************************/
function double_check(){

		var str1  = gclx_sfdcode2.BindColVal;				    //�����ڵ�   
		var str2  = gclx_cadeptcd2.BindColVal;					//�μ��ڵ�       
		var str3  = fn_trim(gcem_sgetdatefr2.text);	           //��û���

		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070003_s1"
									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;		
										
		gcds_data4.Reset();
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_PrintHederSet(){

	var THeader1 = "FDCODE:STRING,ACYYMM:STRING,ACWEEK:STRING,DEPTCD:STRING,REMCODE:STRING,"
						+ "AMTDIV:STRING,PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,"
						+ "STATDIV:STRING,ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING,AMTDIV1:STRING";
	
	gcds_temp01.SetDataHeader(THeader1);

	var THeader2 = "CURDT:STRING,KBUNAM:STRING";
	gcds_temp02.SetDataHeader(THeader2);

}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_HederSet(){
	var THeader1 = "FDCODE:STRING,ACYYMM:STRING,ACWEEK:STRING,DEPTCD:STRING,REMCODE:STRING,"
							 + "AMTDIV:STRING,PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,"
							 + "STATDIV:STRING,ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING";
	gcds_data2.SetDataHeader(THeader1);
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(e){
  if(e=="01") {
		if(gcds_data1.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcds_temp01.clearall();
			gcds_temp02.clearall();
			ln_PrintHederSet();
			gcds_temp01.ImportData(gcds_data1.ExportData(1,gcds_data1.countrow,false));
			gcds_temp02.addrow();
			gcds_temp02.namevalue(gcds_temp02.rowposition,"CURDT")
				= gcem_sgetdatefr1.text;
			gcds_temp02.namevalue(gcds_temp02.rowposition,"KBUNAM")=gclx_cadeptcd.text;
			for(i=1;i<=gcds_temp01.countrow;i++) {
				if(gcds_temp01.namevalue(i,"AMTDIV")=="C")
					gcds_temp01.namevalue(i,"AMTDIV1")="����";
				else if(gcds_temp01.namevalue(i,"AMTDIV")=="B")
					gcds_temp01.namevalue(i,"AMTDIV1")="����";
				else if(gcds_temp01.namevalue(i,"AMTDIV")=="D")
					gcds_temp01.namevalue(i,"AMTDIV1")="���뿹��";
			}
			gcrp_print1.preview();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('��û��Ȳ');
	}
}


/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){

	gcem_sgetdatefr1.text = gs_date2+"01";	 
	gcem_sgetdatefr2.text = gs_date2+"01";
	gclx_week1.index =0;
	gclx_amtdiv2.bindcolval = "C";	//���ޱ���(����)
	
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_hcdept_s2?v_str1="; 
	gcds_dept1.Reset();

	gcds_dept2.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept2.Reset();

    gcds_com.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054"; 
    gcds_com.Reset();

	gcds_dept00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	gcds_dept00.Reset();
}

/******************************************************************************
	Description : ��Ϲ�ư
******************************************************************************/
function ln_Insert(){
	ln_HederSet();
	var row = gcds_data2.rowposition;
	gcds_data2.AddRow();
	gclx_amtdiv2.bindcolval = "C";	
}

/******************************************************************************
	Description : �����ư
******************************************************************************/
function ln_Save(){
	if(gcds_data2.countrow>0){
		if(ln_Chk()) {
			if (gcds_data2.IsUpdated){
				var str1  = gclx_sfdcode2.BindColVal;				    //�����ڵ�  
				var str2  = fn_trim(gcem_sgetdatefr2.text);	            //��û����		
				var str3  = gclx_week2.BindColVal;						//�ְ�����
				var str4  = gclx_cadeptcd2.BindColVal;					//�μ��ڵ� 	
				gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070003_t1?";
				gctr_code02.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3
									  + ",v_str4="+str4+ ",v_str5="+gs_date+",v_str6="+gs_userid;
				gctr_code02.post();
				('02');
			}else alert("����� ������ �����ϴ�.");
		}
	}else alert("������ ������ �����ϴ�.");	  
}

/******************************************************************************
	Description : �ʼ��׸� �Է�üũ 
******************************************************************************/
function ln_Chk() {
	if(gclx_week2.BindColVal=="") {
		alert("��Ȯ�� �ְ������� �����Ͻʽÿ�.");
		return false;
	}

	if(fn_trim(txt_atcode_fr.value)=="") {
		alert('��Ȯ�� ���������� �����Ͻʽÿ�.');
		txt_atcodenm_fr.focus();
		return false;
	}

	if(gcem_plamt2.text==0||gcem_plamt2.text=="") {
		alert('��Ȯ�� ��û�ݾ��� �Է��Ͻʽÿ�.');
		gcem_PLAMT.focus();
		return false;
	}
	return true;
}

/******************************************************************************
	Description : ������ư
******************************************************************************/
function ln_Delete(){
	if(gcds_data2.countrow>0){
		var str1  = gclx_sfdcode2.BindColVal;				  //�����ڵ�  
	  var str2  = fn_trim(gcem_sgetdatefr2.text);	  //��û����		
		var str3  = gclx_week2.BindColVal;						//�ְ�����
		var str4  = gclx_cadeptcd2.BindColVal;				//�μ��ڵ�
	
		if (confirm("���� �Ͻðڽ��ϱ�?")){
			gcds_data2.deleterow(gcds_data2.rowposition);
			gctr_code02.action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070003_t1?";
			gctr_code02.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3+",v_str4="+str4;
			gctr_code02.post();
			ln_Query('02');
		}
	}else alert("������ ������ �����ϴ�.");
}

/***********************************************************************************************
	Description : �����ڵ� 
	parameter   : p1 - ����  p2-����2, p3-�ڱݱ��а� obj
**********************************************************************************************/
function ln_Popup3(p1,p2,p3,obj1,obj2){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="01"){//��������
		strURL = "./actcode_fund_popup.jsp";
		arrParam[0]=eval(obj1).value;
		arrParam[1]=eval(obj2).value;
		arrParam[2]="C";//"'10'";p3;
		arrParam[3]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}

		} else {
			if(p2=="fr") {
			  txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
				gstr_fundiv = "";
			}
		}
	}
}

/******************************************************************************
	Description : lost focus �� 
	prameter    : p1 - 01 ��ǥ�ۼ�
	                   02 ������ȸ
								p2 - atcode:����
								obj
******************************************************************************/
function ln_Blur(p1,p2,obj1,obj2){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
				ln_Popup3('01','fr','B',obj1,obj2);
			 
		}
	}
}

/******************************************************************************
	Description : ã�� - �ŷ�ó�ڵ�
******************************************************************************/
function ln_Popup(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_vendcd.value  = arrParam[0];
		txt_vendnm.value	= arrParam[1];
	} else {
		txt_vendcd.value	= "";
		txt_vendnm.value	= "";
	}
}

/******************************************************************************
	Description : �Ǳ���
	prameter    :
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_com" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_dept00" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp01" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp02" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
<PARAM NAME="KeyValue" VALUE="a070003_t1(I:USER=gcds_data2)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.BindColVal   =  gs_fdcode;
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	gclx_sfdcode2.BindColVal   =  gs_fdcode;
</script>

<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";     
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.BindColVal   =  gs_deptcd;
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";       
	gcds_dept2.InsertRow(1);
	gcds_dept2.NameValue(1,"DEPTCD")="";
	gcds_dept2.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd2.BindColVal  =  gs_deptcd;
</script>

<!-- <script language="javascript" for="gcds_com" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";       
	gcds_com.InsertRow(1);
	gcds_com.NameValue(1,"CDCODE")="";
	gcds_com.NameValue(1,"CDNAM")="";
	gclx_com.index=0;
</script> -->

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code02" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�."); 
</script>

<script language="javascript" for="gctr_code02" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_code02.ErrorCode + "\n" + "Error Message : " + gctr_code02.ErrorMsg + "\n");
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070003_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:-6px;">
				<tr> 
					<td width="0" align=left><nobr>
					  <comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						<PARAM NAME="BackColor"					VALUE="#cccccc">
   						<PARAM NAME="titleHeight"				VALUE="20px">
						 <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						 <PARAM NAME="Format"						VALUE="
									<T>divid=div_1		title=��û��Ȳ</T>									
							    <T>divid=div_2		title=�ڱݽ�û</T>							 
						  ">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- ��û��Ȳ ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >

	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:90px"><comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�μ�</nobr></td>
					<td class="tab23" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_dept1">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="DEPTNM^0^110">
								<param name=BindColumn			value="DEPTCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td class="tab12" style="width:50px;" bgcolor="#eeeeee"><nobr>��û���</nobr></td>
					<td style="width:70px"><comment id="__NSID__">
						<object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->&nbsp;
					</td>
					<td class="tab12" style="width:70px;border-left-width:1px" bgcolor="#eeeeee"><nobr>�ְ�����</nobr></td>
					<td style="width:90px">
						<comment id="__NSID__"><object  id=gclx_week1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=CBDATA            value="^��ü,1^1��,2^2��,3^3��,4^4��,5^5��">
							<param name=CBDataColumns			value="WEEKCD,WEEKNAME">
							<param name=SearchColumn			value="WEEKNAME">
							<param name=Sort							value="false">
							<param name=ListExprFormat		value="WEEKNAME^0^60">
							<param name=BindColumn				value="WEEKCD">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')">
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'					ID={CURROW}	HeadAlign=Center	HeadBgColor=#B9D4DC Width=40	align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='�ְ�����'			ID=ACWEEK		HeadAlign=Center	HeadBgColor=#B9D4DC Width=60	align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='1:1��,2:2��,3:3��,4:4��,5:5��'</C>
								<C> Name='��������'			ID=ATKORNAM	HeadAlign=Center	HeadBgColor=#B9D4DC Width=100	align=left		SumText='��'	SumBgColor='#C3D0DB'</C>
								<C> Name='�ŷ�ó'				ID=VENDNM		HeadAlign=Center	HeadBgColor=#B9D4DC Width=250	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='��û�ݾ�'			ID=PLAMT		HeadAlign=Center	HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='���ޱ���'			ID=AMTDIV		HeadAlign=Center	HeadBgColor=#B9D4DC Width=60	align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:����,B:����,D:���뿹��'</C>
								<C> Name='��������'			ID=EXDATE		HeadAlign=Center	HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='����'					ID=REMARK		HeadAlign=Left		HeadBgColor=#B9D4DC Width=340	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>  
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 


<!-- �ڱݽ�û ===========================================================================================================-->
<!--<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="position:absolute;top:66px;display:none;">	
<tr><td height="3px"><td></tr>
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�μ�</nobr></td>
					<td class="tab23" style="width:120px">
						<comment id="__NSID__"><OBJECT id=gclx_cadeptcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
							<param name=ComboDataID			value="gcds_dept2">
							<param name=CBDataColumns		value="DEPTCD,DEPTNM">
							<param name=SearchColumn		value="DEPTNM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="DEPTNM^0^110">
							<param name=BindColumn			value="DEPTCD">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 			
					</td>
					<td class="tab12" style="width:50px;" bgcolor="#eeeeee"><nobr>��û���</nobr></td>
					<td style="width:70px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:0px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM">
						<param name=PromptChar		value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
					</td>
					<td class="tab12" style="width:70px;border-left-width:1px" bgcolor="#eeeeee"><nobr>�ְ�����</nobr></td>
					<td style="width:90px">
						<comment id="__NSID__"><object  id=gclx_week2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=CBDATA              value="1^1��,2^2��,3^3��,4^4��,5^5��">
							<param name=CBDataColumns		value="WEEKCD,WEEKNAME">
							<param name=SearchColumn		value="WEEKNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="WEEKNAME^0^60">
							<param name=BindColumn			value="WEEKCD">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">&nbsp;<nobr>
						<IMG src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Delete()"> <IMG  src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Insert()" >
						<IMG  src="../../Common/img/btn/com_b_save.gif"    style="cursor:hand;position:relative;top:2px;right:2px"  onclick="ln_Save()">
						<IMG src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 

						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_data2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:520px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data2">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 						
								<C> Name='��������'	ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		SumText='��'	SumBgColor='#C3D0DB'</C>
								<C> Name='�ŷ�ó'		ID=VENDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='��û�ݾ�'	ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=right		SumText=@sum	SumBgColor='#C3D0DB' Edit=Numeric</C>	
								<C> Name='����'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:-1px;width:522px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
					</fieldset>
						</td>
						<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:343px;height:402px;border:1 solid #708090;position:relative;left:1px'>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">��������</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr', 'txt_atcodenm_fr')">
									<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('01','fr','B','txt_atcode_fr','txt_atcodenm_fr');">
									<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" disabled>
								</td>
							</tr>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">�� �� ó</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_vendnm" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" >
									<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup();">
									<input id="txt_vendcd" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" disabled>
								</td>
							</tr>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">���ޱ���</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;width:130px"><comment id="__NSID__">
									<object  id=gclx_amtdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
										<param name=CBData					value="^,C^����,B^����,D^���뿹��">
										<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="CDNAM^0^110">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">��û�ݾ�</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;"><comment id="__NSID__">
									<object  id=gcem_plamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:2px;">		
										<param name=Text          value="">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="000,000,000">
										<param name=MaxLength     value=13>
										<param name=IsComma	      value=true>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">��������</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;"><comment id="__NSID__">
									<object id=gcem_exdate2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="YYYY/MM/DD">
										<param name=PromptChar	value="_">
										<param name=Enable			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_exdate2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_remark2" type="text" class="txtbox" style= "width:250px;height:20px;position:relative;left:5px;" MaxLength=132>			
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;">&nbsp;
								</td>
							</tr>
						</table>
								</TD>
							</tr>
						</table>
					</td>
				 </tr>
			 </table>
			 
		</td> 
	</tr> 
</table> 
			 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value=' 
		<C>Col=ATKORNAM		Ctrl=txt_atcodenm_fr		  Param=value</C>
		<C>Col=REMCODE		Ctrl=txt_atcode_fr		    Param=value</C>
		<C>Col=PLAMT			Ctrl=gcem_plamt2			    Param=text</C>
		<C>Col=VENDCD			Ctrl=txt_vendcd				Param=value</C>
		<C>Col=VENDNM			Ctrl=txt_vendnm				Param=value</C>
		<C>Col=AMTDIV			Ctrl=gclx_amtdiv2			    Param=BindColVal</C>
		<C>Col=EXDATE			Ctrl=gcem_exdate2			    Param=text</C>
		<C>Col=REMARK			Ctrl=txt_remark2			    Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<!--param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;"-->
	<param name="MasterDataID"		value="gcds_temp02">
	<param name="DetailDataID"		value="gcds_temp01">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2870 ,bottom=556 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=47 ,top=203 ,right=887 ,bottom=279 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� û �� �� :' ,left=47 ,top=427 ,right=279 ,bottom=480 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� û �� �� :' ,left=47 ,top=364 ,right=279 ,bottom=422 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=42 ,top=190 ,right=877 ,bottom=269 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� ��  �� ��  �� û ��' ,left=45 ,top=198 ,right=869 ,bottom=258 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CURDT', left=282, top=364, right=877, bottom=422, align='left' ,mask='XXXX/XX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KBUNAM', left=282, top=427, right=877, bottom=480, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1938 ,top=401 ,right=2714 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1938 ,top=192 ,right=2714 ,bottom=192 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=1943 ,top=227 ,right=1996 ,bottom=277 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1943 ,top=324 ,right=1996 ,bottom=372 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2001 ,top=192 ,right=2001 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1938 ,top=192 ,right=1938 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2714 ,top=192 ,right=2714 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2533 ,top=192 ,right=2533 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2356 ,top=192 ,right=2356 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2180 ,top=192 ,right=2180 ,bottom=401 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2001 ,top=253 ,right=2714 ,bottom=253 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='������' ,left=2541 ,top=200 ,right=2709 ,bottom=248 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2362 ,top=200 ,right=2530 ,bottom=248 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2185 ,top=200 ,right=2354 ,bottom=248 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2006 ,top=200 ,right=2177 ,bottom=248 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=97 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=39 ,top=3 ,right=2714 ,bottom=3 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=55 ,top=50 ,right=124 ,bottom=92 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1427 ,top=18 ,right=1851 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û�ݾ�' ,left=1948 ,top=18 ,right=2156 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ޱ���' ,left=2254 ,top=18 ,right=2427 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ޱ���' ,left=2520 ,top=18 ,right=2701 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=39 ,top=98 ,right=2714 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=39 ,top=3 ,right=39 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=753 ,top=5 ,right=753 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=237 ,top=3 ,right=237 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=39 ,top=3 ,right=237 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1901 ,top=3 ,right=1901 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2193 ,top=3 ,right=2193 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2483 ,top=3 ,right=2483 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2714 ,top=3 ,right=2714 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=279 ,top=18 ,right=706 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=155 ,top=11 ,right=224 ,bottom=53 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�ó' ,left=819 ,top=18 ,right=1245 ,bottom=82 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1372 ,top=5 ,right=1372 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2483 ,top=0 ,right=2483 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2193 ,top=0 ,right=2193 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=39 ,top=0 ,right=39 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=237 ,top=0 ,right=237 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=753 ,top=0 ,right=753 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ACYYMM', left=47, top=3, right=232, bottom=63 ,mask='XXXX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1393, top=3, right=1896, bottom=63, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=245, top=3, right=748, bottom=63, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMTDIV1', left=2225, top=3, right=2451, bottom=63, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EXDATE', left=2520, top=3, right=2701, bottom=63 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLAMT', left=1932, top=3, right=2162, bottom=63, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=39 ,top=66 ,right=2714 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1372 ,top=0 ,right=1372 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VENDNM', left=785, top=3, right=1287, bottom=63, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2714 ,top=0 ,right=2714 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2870 ,bottom=398 ,face='Arial' ,size=10 ,penwidth=1
	<S>id='{Sum(PLAMT)}' ,left=1959 ,top=3 ,right=2190 ,bottom=63 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=2714 ,top=0 ,right=2714 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1901 ,top=0 ,right=1901 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=753 ,top=0 ,right=753 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=237 ,top=0 ,right=237 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=39 ,top=0 ,right=39 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2193 ,top=0 ,right=2193 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2483 ,top=0 ,right=2483 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=45 ,top=3 ,right=234 ,bottom=63 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=39 ,top=66 ,right=2714 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1938 ,top=380 ,right=2714 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=1943 ,top=253 ,right=1996 ,bottom=303 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2001 ,top=174 ,right=2001 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1938 ,top=174 ,right=1938 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2714 ,top=174 ,right=2714 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2533 ,top=174 ,right=2533 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2356 ,top=174 ,right=2356 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2180 ,top=174 ,right=2180 ,bottom=380 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2001 ,top=235 ,right=2714 ,bottom=235 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='������' ,left=2541 ,top=182 ,right=2709 ,bottom=229 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ���' ,left=2362 ,top=182 ,right=2530 ,bottom=229 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2185 ,top=182 ,right=2354 ,bottom=229 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=2006 ,top=182 ,right=2177 ,bottom=229 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1943 ,top=190 ,right=1996 ,bottom=240 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1943 ,top=319 ,right=1996 ,bottom=369 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1938 ,top=174 ,right=2714 ,bottom=174 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1372 ,top=0 ,right=1372 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1902 ,right=2870 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2341 ,top=3 ,right=2720 ,bottom=84</I>
	<L> left=39 ,top=0 ,right=2712 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>





	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 