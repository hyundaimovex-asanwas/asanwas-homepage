<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ΰ����� - ����ΰ����ν�û ���� view
+ ���α׷� ID	: a400150_approve_view.jsp
+ �� �� �� ��	: ����ΰ����ν�û ���� view
+ �� �� �� ��	: 2017.04.28 jys
+ ���콺 ����    : 5.2
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: a400140_approve_s1, a400140_approve_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% 
   //ContextPath ���� ����.
   String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����.
   
   String v_dwr_sid  = request.getParameter("v_dwr_sid");	    //�۾��Ϻ� index
   String v_status	 = request.getParameter("v_status");	    //������ �۾� ������ : ���� 010�ۼ���, 011�������������, 012�������Ϸ�
   String v_ap_m_sid = request.getParameter("v_ap_m_sid");	    //���縶���� sid : �ݷ��ÿ��� �������� ��°� �ƴϹǷ� �Ϻ� �ε����� ��ģ��.
   
   String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ
%>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_yymm = gcurdate.substring(2,4) + gcurdate.substring(5,7); 


var g_WinParam = window.dialogArguments;
var g_ap_sid =0;
var g_ap_gu="";
var g_row=0;
var g_ap_sid2 =0;
var g_ap_gu2="";
var g_row2=0;
var g_ap_type2="";

//alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]+"::g_WinParam[2]::"+g_WinParam[2]+"::g_WinParam[3]::"+g_WinParam[3]+"::g_WinParam[4]::"+g_WinParam[4]);

/*
var array1= new Array();
var array2= new Array();
var array3= new Array();
var array4= new Array();

var strAppline_gb=""; //���缱���� ��ȸ ���� 

if(g_WinParam[2]!=""){
	
	array1= g_WinParam[2].split(";");
	array2 =array1[0].split("/");  //���
	array3 =array1[1].split("/");  //����
	array4 =array1[2].split("/");  //Ȯ��
	array5 =array1[3].split("/");  //����
	strAppline_gb="1"; //���
	
}else{
	strAppline_gb="2"; // �̰����Կ��� ó�� �� ��� 
}

*/

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(){
	
	ln_Query(g_WinParam[4],g_WinParam[3] );
	
	//���� ��ȸ
	gcds_jobcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_job_cd_s1?v_str1="+txt_app_empno.value;
	gcds_jobcd.Reset();
	
	txt_app_jobcd.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBCD");
	txt_app_jobnm.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBNM");
	
	
	
	//�ΰ�������ȣ ���� + �ΰ����ع�ȣ + ��� + ����
	//gcem_signet_mgr_no.text = gs_yymm ;
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// �������� AP005 - �������� �����ڵ� �о����
	
	ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// �������_D AP003 - �������� �����ڵ� �о����
	
	//gcem_ap_desc.style.background ="#99CC00";
	
	//����ΰ�id �� ����.
	gcds_signet_id.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_s1?v_str1=2&v_str2=1";
	gcds_signet_id.Reset();
}
<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query(strAppno,strAp_m_sid){
	
	//����ΰ� ������ ��ȸ 
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400150_approve_s0?v_str1="+strAppno;                                                  
	gcds_data.Reset();
	
	if(gcds_data.namevalue(gcds_data.rowposition,"SEAL_PAPER_CHK") == "Y"){
		chkbox_seal_paper.checked=true;
	}else{
		chkbox_seal_paper.checked=false;
	}
	
	//���缱 MST ��ȸ
	gcds_ap_mst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s2?v_str1="+strAp_m_sid;                                                  
	gcds_ap_mst.Reset();
	
	//��û�� ���缱 ��ȸ 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s1?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
	
	//�ְ��� ���缱 ��ȸ 
	ds_apline2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_s1?v_str1="+strAp_m_sid+"&v_str2=4";                                                  
	ds_apline2.Reset();
	
	//��û�� ���缱
	_line_chk1:
	for(var i=ds_apline.countrow;i>=1;i--){
		//alert(i+"::AP_TYPE::"+ ds_apline.namevalue(i,"AP_TYPE"));
		if(ds_apline.namevalue(i,"AP_EMPNO")==gs_userid&&ds_apline.namevalue(i,"AP_STATUS_D")=="1"){
			g_ap_sid = ds_apline.namevalue(i,"AP_SID");
			g_ap_gu  = ds_apline.namevalue(i,"AP_GU");
			g_row = i;
			break _line_chk1;
		}
	}
	
	//�ְ��� ���缱
	_line_chk2:
	for(var j=ds_apline2.countrow;j>=1;j--){
		//alert(j+"::AP_TYPE::"+ ds_apline.namevalue(j,"AP_TYPE"));
		if(ds_apline2.namevalue(j,"AP_EMPNO")==gs_userid&&ds_apline2.namevalue(j,"AP_STATUS_D")=="1"){
			g_ap_sid2 = ds_apline2.namevalue(j,"AP_SID");
			g_ap_gu2  = ds_apline2.namevalue(j,"AP_GU");
			g_row2 = j;
			g_ap_type2 = ds_apline2.namevalue(j,"AP_TYPE");
			break _line_chk2;
		}
	}
	
}


<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
/*
function ln_Save(){
		
	
	if(g_ap_gu=="1"){         //��û�� ���缱 
		
		//ds_apline.namevalue(g_row,"AP_DESC") = gcem_ap_desc.text;
		if(!ln_Chk_Save())return;
		else if (ds_apline.IsUpdated) {
			if (confirm("�Է��Ͻ� �ǰ��� ����Ͻðڽ��ϱ�?")){
				gctr_data.KeyValue = "Account.a400140_approve_t1(I:USER=ds_apline)";	
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t1";
				gctr_data.Parameters = "v_str1="+gs_userid;
				
				gctr_data.post();
				//ln_Query(gcem_app_no.text);
			}	
		}
		
	}else if (g_ap_gu2=="4") { //�ְ��� ���缱 
		//ds_apline2.namevalue(g_row2,"AP_DESC") = gcem_ap_desc.text;
		if(!ln_Chk_Save())return;
		else if (ds_apline2.IsUpdated) {
			if (confirm("�Է��Ͻ� �ǰ��� ����Ͻðڽ��ϱ�?")){
				gctr_data.KeyValue = "Account.a400140_approve_t1(I:USER=ds_apline2)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t1";
				gctr_data.Parameters = "v_str1="+gs_userid;
				gctr_data.post();
				//ln_Query(gcem_app_no.text);
			}	
		}
	}
}

*/

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
   //AP_SID üũ      
   return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
	
}
<%
/******************************************************************************
	Description : ���
******************************************************************************/
%>
function ln_Print(){

}


<% //����MST %>
function ln_SetDataHeader3(){
	if (gcds_ap_mst.countrow<1){
		var s_temp = "AP_M_SID:DECIMAL(10),DOC_SID:DECIMAL(10),DOC_GU:STRING(10),DOC_GU2:STRING(10),AP_STATUS_M:STRING(10),L_EMPNO:STRING(10),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "NUM_PARAM1:DECIMAL(10),NUM_PARAM2:DECIMAL(10),NUM_PARAM3:DECIMAL(10),NUM_PARAM4:DECIMAL(10),NUM_PARAM5:DECIMAL(10),"
				   + "CH_PARAM1:STRING(20),CH_PARAM2:STRING(20),CH_PARAM3:STRING(20)";
		gcds_ap_mst.SetDataHeader(s_temp);
	}
}


<% //����DTL %>
function ln_SetDataHeader4(){
	if (gcds_ap_dtl.countrow<1){
		var s_temp = "AP_SID:DECIMAL(10),AP_M_SID:DECIMAL(10),AP_GU:STRING(10),AP_SEQ:DECIMAL(10),AP_TYPE:STRING(10),AP_STATUS_D:STRING(10),"
				   + "AP_EMPNO:STRING(10),AP_REAL_EMPNO:STRING(10),AP_DESC:STRING(100),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "AP_JOBNM:STRING(20),AP_DPTNM:STRING(50)";
		gcds_ap_dtl.SetDataHeader(s_temp);
	}
}

<% //����  ���ڰ���MST, ���ڰ���DTL %>
function ln_Apply(){
	
	//alert("AP_M_SID::"+gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_M_SID"));
	//alert("g_ap_gu2::"+g_ap_gu2);
	
	if(g_ap_gu=="1"){         //��û�� ���缱 
   
	    if(!ln_Chk_Apply_1())return;
		
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			
			ln_Data_Apply_1();
			
			gctr_data.KeyValue = "Account.a400140_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			prompt('gcds_ap_mst',gcds_ap_mst.text);
			prompt('ds_apline',ds_apline.text);
			
			gctr_data.post();
		}
	}else if (g_ap_gu2=="4") { //�ְ��� ���缱 
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			ln_Data_Apply_2();
			
			gctr_data.KeyValue = "Account.a400140_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline2)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			prompt('gcds_ap_mst',gcds_ap_mst.text);
			prompt('ds_apline2',ds_apline2.text);
			
			gctr_data.post();
		}
	}
}

<% //���� üũ %>
function ln_Chk_Apply_1(){
	
	//������� üũ 
	//SID üũ 
	
	
	/*
	//��û��ȣ üũ
	if(gcem_app_no.text==""){
		alert("��û��ȣ�� �������� �ʽ��ϴ�. Ȯ�� �ٶ��ϴ�.");
		return false;
	}	
	
	//üũ - ���缱 ���� Ȯ�� .
	if(ds_apline.countrow<2){
		alert("��û�� ���缱�� Ȯ�� �ٶ��ϴ�.");
		return false;
	}
	*/
	
	return true;
}

<% //���ν� ������ �ݿ�  %>
function ln_Data_Apply_1(){
	//����MST
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "2";
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	
	//���缱
	ds_apline.namevalue(g_row,"AP_STATUS_D") = "3";
	ds_apline.namevalue(g_row,"U_EMPNO") = gs_userid;
	ds_apline.namevalue(g_row,"U_IP") ="<%=gusrip%>";
}


<% //�ְ��� ���ν� ������ �ݿ�  %>
function ln_Data_Apply_2(){
	//����MST
	//���缱�� �ְ��� ������ �� ������´� ������������ ������. 
	if(g_ap_type2=="4"){
		gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "3"; //��������
	}else{
		gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "2"; //��������
	}
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	//���缱
	ds_apline2.namevalue(g_row2,"AP_STATUS_D") = "3";
	ds_apline2.namevalue(g_row2,"U_EMPNO") = gs_userid;
	ds_apline2.namevalue(g_row2,"U_IP") ="<%=gusrip%>";
}


<% //�ݼ�  ���ڰ���MST, ���ڰ���DTL %>
function ln_Return(){
	
	//alert("AP_M_SID::"+gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_M_SID"));
	//alert("g_ap_gu2::"+g_ap_gu2);
	
	if(g_ap_gu=="1"){         //��û�� ���缱 
   
	    if(!ln_Chk_Return_1())return;
		
		if (confirm("�ݼ� �Ͻðڽ��ϱ�?")){
			
			ln_Data_Return_1();
			
			gctr_data.KeyValue = "Account.a400140_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_ap_mst',gcds_ap_mst.text);
			//prompt('ds_apline',ds_apline.text);
			
			gctr_data.post();
		}
	}else if (g_ap_gu2=="4") { //�ְ��� ���缱 
				
		if (confirm("�ݼ� �Ͻðڽ��ϱ�?")){
			
			ln_Data_Return_2();
				
			gctr_data.KeyValue = "Account.a400140_approve_t2(I:USER=gcds_ap_mst,I:USER2=ds_apline2)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_approve_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_ap_mst',gcds_ap_mst.text);
			//prompt('ds_apline2',ds_apline2.text);
			
			gctr_data.post();
		}	
	}
}

<% //�ݼ� üũ %>
function ln_Chk_Return_1(){
	
	//������� üũ 
	//SID üũ 
	
	return true;
}

<% //�ݼ� üũ %>
function ln_Chk_Return_2(){
	
	//������� üũ 
	//SID üũ 
	
	return true;
}


<% //��û�� �ݼ۽� ������ �ݿ�  %>
function ln_Data_Return_1(){
	//����MST
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "4"; //�ΰ�
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	
	//���缱
	ds_apline.namevalue(g_row,"AP_STATUS_D") = "4";  //�ݷ�
	ds_apline.namevalue(g_row,"U_EMPNO") = gs_userid;
	ds_apline.namevalue(g_row,"U_IP") ="<%=gusrip%>";
}


<% //�ְ��� �ݼ۽� ������ �ݿ�  %>
function ln_Data_Return_2(){
	//����MST
	
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"AP_STATUS_M") =  "4";
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"L_EMPNO") = gs_userid;
	gcds_ap_mst.namevalue(gcds_ap_mst.rowposition,"U_IP") = "<%=gusrip%>";
	
	//���缱
	ds_apline2.namevalue(g_row2,"AP_STATUS_D") = "4";  //�ݷ�
	ds_apline2.namevalue(g_row2,"U_EMPNO") = gs_userid;
	ds_apline2.namevalue(g_row2,"U_IP") ="<%=gusrip%>";
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_ap_mst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_dtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_gc_apsts_d classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object id=gcds_signet_id classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_jobcd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	
    //alert(":::rowcount::"+rowcount);
	if (rowcount ==0 ){
		//alert("�˻��� ����Ÿ�� �����ϴ�.");
	}else{
		//alert("::"+(gcds_data.namevalue(gcds_data.rowposition,"SEAL_PAPER_CHK")+""::"");
		if(gcds_data.namevalue(gcds_data.rowposition,"SEAL_PAPER_CHK") == "Y"){
			chkbox_seal_paper.checked=true;
		}else{
			chkbox_seal_paper.checked=false;
		}
	}
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="��ü";
    gclx_signet_gb_0.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="998px" align="right"  style="padding-top:4px;"> 
						<!-- <img src="<%=dirPath%>/Sales/images/btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="ln_Apply();">  -->
	    	            <!-- <img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="ln_Return();">-->
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;�� ����ΰ� ���� ��û�ۼ�</font></b>
		<td>
	</tr>

	<tr>
		<td colspan=2 >
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:1 solid #708090'>
			<tr>
			    <td class="tab11" width="50px" bgcolor="#eeeeee" rowspan=5><nobr>����</nobr> </td>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>��û��ȣ</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_app_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#00000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
 						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>�Ҽ�</nobr> </td>
				<td class="tab21">
					 <input id="txt_app_teamcd"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; "  >
				     <input id="txt_app_teamnm"  type="text"  style= "position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36"  readOnly>			
			    </td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>����</nobr> </td>
				<td class="tab21">
					 <input id="txt_app_jobcd"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_jobnm"  type="text"  style= "position:relative;top:0px;left:4px;width:80px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��û��</nobr> </td>
				<td class="tab22">
					 <input id="txt_app_empno"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_empnm"  type="text"  style= "position:relative;top:0px;left:4px;width:80px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
		    </tr>
		    <tr>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>�ΰ�ID</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object  id=gclx_signet_id  classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:120px;">
								<param name=ComboDataID      value="gcds_signet_id">
								<param name=CBDataColumns	 value="SIGNET_ID,MGR_TEAMNM,SIGNET_HEAD_NO">
								<param name=SearchColumn	 value=SIGNET_ID>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="SIGNET_ID^0^30,SIGNET_HEAD_NO^0^20,MGR_TEAMNM^0^100">								
								<param name=BindColumn		 value="SIGNET_ID">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>�ΰ�������ȣ</nobr> </td>
				<td class="tab21">
					<comment id="__NSID__">
						<object id=gcem_signet_mgr_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:150px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=IsComma       value=false>
							<param name=GeneralEdit   value="true">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��û����</nobr> </td>
				<td class="tab21">
					<comment id="__NSID__">
						<object  id=gcem_app_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:0px;left:4px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��������</nobr> </td>
				<td class="tab22">
					<comment id="__NSID__">
						<object  id=gcem_seal_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:0px;left:4px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
				</td>
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>�뵵</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_signet_use  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>����/���ó</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_signet_submit  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		      <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>���</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_remark  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		     <tr>
		        <td class="tab11" width="50px" bgcolor="#eeeeee" rowspan=2><nobr>����</nobr> </td>
		    	<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>������</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_paper_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>���μ���</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_seal_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>���μ����纻</nobr> </td>
				<td class="tab22" colspan=3>
					<input type=checkbox  id=chkbox_seal_paper  style="width:15px;position:relative;left:0px;top:-3px">&nbsp;��û�� ��ü ����
				</td>
		    </tr>
		     <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>�纻��÷�λ���</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_attach_reason  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		     <tr>
		        <td class="tab11" width="50px" bgcolor="#eeeeee"><nobr>����</nobr> </td>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>��������</nobr> </td>
				<td class="tab21" colspan=3>
					<comment id="__NSID__">
						<object  id=gcem_send_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
					<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_send_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
				</td>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>��������</nobr> </td>
				<td class="tab22" colspan=3>
					<comment id="__NSID__">
						<object  id=gcem_receive_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
					<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_receive_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							
				</td>
		    </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			&nbsp;
		</td>
	</tr>
	<!-- 
	 <tr>
	    <td colspan=2>
	    <table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:1 solid #708090'>
	    <tr>
    	<td class="tab11" style="width:120px;height:20px;" bgcolor="#eeeeee"><nobr><font size="2" color="blue">�ǰ�</font></nobr> </td>
		<td class="tab21" >
			<comment id="__NSID__">
				<object id=gcem_ap_desc  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative; left:4px;top:2px;width:800px;height:20px;" class="txtbox">
					<param name=Alignment	       value=0>
					<param name=Border	           value=true>
					<param name=UpperFlag          value=1>
					<param name=GeneralEdit        value=true>
					<param name=MaxLength          value=50>
					<param name=InheritColor		value=true>
				</object>
			</comment><script>__ws__(__NSID__);</script>&nbsp;
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="cursor:hand" onclick="ln_Save()">
		</td>
		</tr>
		</table>
		</td>
    </tr>
     -->
    <tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			&nbsp;
		</td>
	</tr>
	
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090' colspan=2><b><font size="2" color="blue">&nbsp;�� ��û�� ���缱</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
			<tr>
				<td><nobr>
					<comment id="__NSID__">
			  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='����'	      ID=AP_SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='����'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='���'	      ID=AP_EMPNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='�̸�'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='����'		  ID=AP_JOBNM         HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='�Ҽ�'        ID=AP_DPTNM   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='�������'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='�ǰ�'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=565    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090' colspan=2><b><font size="2" color="blue">&nbsp;�� �ְ��� ���缱</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:0 solid #708090'>
			<tr>
				<td><nobr>  
					<comment id="__NSID__">
			  		<object id=gcgd_supteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='1000px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline2">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='����'	      ID=AP_SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='����'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='���'	      ID=AP_EMPNO   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='�̸�'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='����'		  ID=AP_JOBNM         HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='�Ҽ�'        ID=AP_DPTNM   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='�������'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='�ǰ�'        ID=AP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=565    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
 ------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=APP_NO                  Ctrl=gcem_app_no           Param=text</C>
	<C>Col=SIGNET_ID               Ctrl=gclx_signet_id        Param=bindcolval</C>
	<C>Col=SIGNET_USE              Ctrl=gcem_signet_use       Param=text</C>
	<C>Col=SIGNET_SUBMIT           Ctrl=gcem_signet_submit    Param=text</C>
	<C>Col=PAPER_CNT               Ctrl=gcem_paper_cnt        Param=text</C>
	<C>Col=SEAL_CNT                Ctrl=gcem_seal_cnt         Param=text</C>
	<C>Col=SEAL_PAPER_CHK          Ctrl=chkbox_seal_paper     Param=value</C>
	<C>Col=ATTACH_REASON           Ctrl=gcem_attach_reason    Param=text</C>
	<C>Col=SEND_DATE               Ctrl=gcem_send_date        Param=text</C>
	<C>Col=RECEIVE_DATE            Ctrl=gcem_receive_date     Param=text</C>
	<C>Col=SEAL_DATE               Ctrl=gcem_seal_date        Param=text</C>
	<C>Col=SIGNET_MGR_NO           Ctrl=gcem_signet_mgr_no    Param=text</C>
	<C>Col=APP_TEAMCD              Ctrl=txt_app_teamcd        Param=value</C>
	<C>Col=APP_TEAMNM              Ctrl=txt_app_teamnm        Param=value</C>
	<C>Col=APP_JOBCD               Ctrl=txt_app_jobcd         Param=value</C>
	<C>Col=APP_EMPNO               Ctrl=txt_app_empno         Param=value</C>
	<C>Col=APP_EMPNM               Ctrl=txt_app_empnm         Param=value</C>
	<C>Col=APP_DATE                Ctrl=gcem_app_date         Param=text</C>
	<C>Col=REMARK                  Ctrl=gcem_remark           Param=text</C>
	'>
  </object>
  
  
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>




