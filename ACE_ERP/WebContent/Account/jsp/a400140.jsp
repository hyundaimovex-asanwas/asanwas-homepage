<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ΰ����� - �����ΰ����ν�û
+ ���α׷� ID	: a400140.jsp
+ �� �� �� ��	: �����ΰ����ν�û
+ �� �� �� ��	: 2017.04.10 jys
+ ���콺 ����    : 5.2
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: a400140_s1, a400140_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% 
   //ContextPath ���� ����.
   String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����.
   
   String v_dwr_sid = request.getParameter("v_dwr_sid");	//�۾��Ϻ� index
   String v_status	 = request.getParameter("v_status");	//������ �۾� ������ : ���� 010�ۼ���, 011�������������, 012�������Ϸ�
   String v_ap_m_sid = request.getParameter("v_ap_m_sid");	//���縶���� sid : �ݷ��ÿ��� �������� ��°� �ƴϹǷ� �Ϻ� �ε����� ��ģ��.
   
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

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	//ln_Query("C201704210001");
	//ln_Query_Apline("12237");
	
	ln_Query('C209912310001');  // ������ �� ��� �������� 
	
	txt_app_teamcd.value = gdeptcd;
	txt_app_teamnm.value = gdeptnm;
	txt_app_empno.value = gusrid;
	txt_app_empnm.value = gusrnm;
	
	//���� ��ȸ
	gcds_jobcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_job_cd_s1?v_str1="+txt_app_empno.value;
	gcds_jobcd.Reset();
	
	txt_app_jobcd.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBCD");
	txt_app_jobnm.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBNM");
	
	//�ΰ�������ȣ ���� + �ΰ����ع�ȣ + ��� + ����
	//gcem_signet_mgr_no.text = gs_yymm ;
	
	ln_SetDataHeader();	 //���缱 ���
	ln_SetDataHeader2(); //�ְ�ħ ���缱 ���

	ds_apline_2_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_apline2_s1?v_str1=0001";
	ds_apline_2_temp.Reset();
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// �������� AP005 - �������� �����ڵ� �о����
	
	ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// �������_D AP003 - �������� �����ڵ� �о����
	
}
<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query(strAppno){
	
	if(strAppno==""){
		alert("��û��ȣ�� �����ؾ� �մϴ�. ");
		return false;
	}
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s1?v_str1="+strAppno;	                                                            
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


function ln_Query_Apline(strAp_m_sid){
	
	//��û�� ���缱 ��ȸ 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s2?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
	
	//�ְ��� ���缱 ��ȸ 
	ds_apline2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s2?v_str1="+strAp_m_sid+"&v_str2=4";                                                  
	ds_apline2.Reset();
}

<%
/******************************************************************************
	Description : �߰�
******************************************************************************/
%>
function ln_Add(){
	
	gcds_data.Addrow();
	
	gcem_signet_id.text="0001"; 
	gcem_app_date.text = gs_date2;
	
	txt_app_teamcd.value = gdeptcd;
	txt_app_empno.value = gusrid;
	txt_app_jobcd.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBCD");
	
	ln_File_Clear();
	//��û��ȣ �� �ΰ�������ȣ�� ��Ž� �߻�	
}

<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){			
			gctr_data_save.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t1";
			gctr_data_save.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_data_save.post();
			ln_Query(gcem_app_no.text);
		}	
	}
}

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
    //�ʼ��׸� üũ     
    
    //��û�Ҽ�/����/��û��
    if(txt_app_teamcd.value==""){
    	alert("��û�� �Ҽ� �ڵ带 Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    if(txt_app_jobcd.value==""){
    	alert("��û�� ������ Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    if(txt_app_empno.value==""){
    	alert("��û�� ����� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //�ΰ�ID
    if(gcem_signet_id.text==""){
    	alert("�ΰ� ID�� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //��û����
    if(gcem_app_date.text==""){
    	alert("��û���ڸ� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //�뵵
    if(gcem_signet_use.text==""){
    	alert("�뵵�� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //�뵵
    if(gcem_signet_submit.text==""){
    	alert("����ó�� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //������
    if(gcem_paper_cnt.text==0){
    	alert("�������� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //���μ���
    if(gcem_seal_cnt.text==0){
    	alert("���μ����� Ȯ���Ͻʽÿ�");
    	return false;
    } 
    
    //ǰ�Ǽ� �纻�� ÷��
    if(document.fileForm.fileList.options[0].text==""){
    	alert("ǰ�Ǽ� �纻���� Ȯ���Ͻʽÿ�");
    	return false;
    } 

    return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
	
}

<%	
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Delete(){
	
	if(!ln_Chk_Delete())return;
	
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data_save.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t1";
		gctr_data_save.Parameters = "v_str1="+gs_userid;
		gctr_data_save.post();
	    
		ln_Query("C209912310001");
	}
	else gcds_data.undo(gcds_data.rowposition);		
}

<%//���ϻ��� üũ%>
function ln_Chk_Delete(){
	
	if(gcem_app_no.text==""){
		alert("��û��ȣ�� �������� �ʽ��ϴ�. ���� ������ �ƴմϴ�.");
		return false;
	}
	
    if(document.fileForm.filename.value!=""){
		if(document.fileForm.fileList.options[0].text!=""){
			alert("������ ÷�εǾ� �ֽ��ϴ�. ���� ������ ������ ���� �����մϴ�.")
			return false;
		}
    }
	return true;
}

<%
/******************************************************************************
	Description : ���
******************************************************************************/
%>
function ln_Print(){

}

function ln_File_Clear(){
	//÷������
	//txt_real_file.value="";
	
    //����÷�� �ʱ�ȭ 
    fileForm.filename.outerHTML = fileForm.filename.outerHTML;
	fileForm.fileList.options[0].text="";
}

<%//file upload %>
function fnFileUpload(){
	
	/*
	var str = document.fileForm.filename.value;
	var ary = str.split('\\');
	var strFilename = ary[ary.length-1];  //�������ϸ� 
	
	alert( '���ϸ� : ' + ary[ary.length-1].split('.')[0] );
	alert( '���ϸ�1 : ' + ary[ary.length-1]);
	alert( '���ϱ��� : ' + ary[ary.length-1].split('.')[0].length );
	*/
	
	if(gcem_signet_id.text==""){
		alert("��� �� ���� ÷�� �Ͻʽÿ�.");
		return false;
	}
	
	if(document.fileForm.filename.value==""){
		alert("÷���� ������ �������� �ʽ��ϴ�.");
		return false;
	}
		
	fileForm.target="tempUpload";	//���ε� ���� Ÿ���� iFrame !
	fileForm.action="a400140_fileUpload.jsp";
	fileForm.submit();
}

function fnAddFileList(realName){
	f = document.fileForm;
	if(realName!=""){
		f.fileList.options[0].value="1";
		f.fileList.options[0].text=realName;
		
		gcds_data.namevalue(gcds_data.rowposition,"ATT_GB") ="Y";
		gcds_data.namevalue(gcds_data.rowposition,"ATT_FILE_NAME")= realName;
	}  
}

<%//���ϻ���%>
function fnFileDelete(){
	f = document.fileForm;
	  
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('������ ������ ������ �ֽʽÿ�');
		f.fileList.focus();
		return;
	}	

	if(confirm('������ ���� �Ͻðڽ��ϱ�?')){
		var i = f.fileList.options.selectedIndex;
		
		var select_val = f.fileList.options[i].text;
		//var realFileName = f.file1.value;

		var realFileName = f.fileList.options[0].text;
		var oldFileNames = f.fileList.options[0].text;
	    var fileArray = oldFileNames.split(":");

		//alert(select_val);
		//alert(oldFileNames);

		//******** START ������ �ִ� �������� ���� ***********/
		var isNew = "i_del"; // �̰� �ݹ� �ø� ������ ���... insert_file
		 
		if(fileArray.length>1){
			 for(j=0;j< fileArray.length;j++){
			    tempFileName = fileArray[j];
			   if(tempFileName == select_val){
			      isNew = "u_del";		// ���Ⱑ ���� ����	update_file 
			      break;
			    }
			 }
		}
		 
		if(fileArray.length <=1){
		    if(oldFileNames == select_val){
				isNew = "u_del";
			}
		}
		//******** END  ������ �ִ� �������� ���� ***********/
		 
		//alert(isNew);

		document.file_del.target="tempUpload";
		document.file_del.realFileName.value=realFileName;
		document.file_del.virtualFileName.value = select_val;
//		document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "./a400140_deleteFile.jsp";	//����� ����
		document.file_del.submit();
	}	
}


<% //������ �������� ���� �� ����Ʈ���� ���� %>
function delResult(){
	
	f = document.fileForm;
	
	idx = f.fileList.selectedIndex;
	
	cnt = f.fileList.options.length;
	
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	
	f.fileList.options[cnt - 1] = null;
	//f.file1.value = "÷���������ִ� 1M���������մϴ�.";
	fnAttchFile_delete();
}

function fnAttchFile_delete(){
	
	setDataHeader();
	gcds_data2.addrow();
	gcds_data2.namevalue(gcds_data2.rowposition,"APP_NO") = gcem_app_no.text
	gcds_data2.namevalue(gcds_data2.rowposition,"ATT_FILE_NAME") = "";
	gcds_data2.namevalue(gcds_data2.rowposition,"ATT_GB") = "N"
	gcds_data2.namevalue(gcds_data2.rowposition,"UPID") = gs_userid;
	gcds_data2.namevalue(gcds_data2.rowposition,"UPDT") = "";
	
	gctr_data.KeyValue = "Account.a400140_t2(I:USER=gcds_data2)";
	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t2";
	gctr_data.Parameters = "v_str1="+gs_userid;
	
	gctr_data.post();
	ln_File_Clear();
	ln_Query(gcem_app_no.text);
}

function fnFileNameDisplay(row){
	f = document.fileForm;
	//txt_real_file.value= gcds_data.namevalue(row,"ATT_FILE_NAME");
	f.fileList.options[0].value=gcds_data.namevalue(row,"ATT_FILE_NAME");
}

<%//���ϻ��� ������ �� ��� ���� %>
function setDataHeader() {
	 var s_temp = "APP_NO:STRING,ATT_FILE_NAME:STRING,ATT_GB:STRING,UPID:STRING,UPDT:STRING";
	 gcds_data2.SetDataHeader(s_temp);
}

<%
/******************************************************************************
	Description : ���缱  popup
******************************************************************************/
%>
function fnPopApline() {
	
	//�ΰ����� ��� üũ 
	if(gcem_app_no.text==""){
		alert(" ��û�� ���� �� ���缱���� �����մϴ�.");
		return false;
	}
	
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;
	var strPos;
	var sApproveLine;
	strURL = "<%=dirPath%>/Config/help/sy040h.jsp";
	strPos = "dialogWidth:620px;dialogHeight:500px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
	fnSetApline(arrResult);	
}

function fnSetApline(val){
	//alert("�޾ƿ� ���缱="+val);
	var apline_tot = new Array();
	var apline_row = new Array();

	if(val!=""){
		ds_apline.clearData();	//���� �����
		ds_apline2.clearData();	//���� �����
		
		apline_tot=val.split(";");	// ���缱 �ະ�� ����
		//alert("���� ���缱 �� + 1�� == "+apline_tot.length);	// 1���̸� 2 ����.. ;�� �������� �� ������
		for(i=1;i<apline_tot.length;i++){
			apline_row = apline_tot[i-1].split("/");  // 1�����
			/*
			alert(apline_row.length);	//
			alert("�⺻���缱(1) : " + apline_row[0]);	//
			alert("���� : " + apline_row[1]);	//
			alert("�������� : " + apline_row[2]);	//
			alert("��� : " + apline_row[3]);	//
			alert("�̸� : " + apline_row[4]);	//
			alert("���� : " + apline_row[5]);	//
			alert("�μ� : " + apline_row[6]);	//
			alert("�� ���缱 SID : " + apline_row[7]);	//
			*/
			
			ds_apline.AddRow();
			ds_apline.NameValue(i, "SEQ") 				= apline_row[1];//����
			ds_apline.NameValue(i, "AP_TYPE") 			= apline_row[2];//��������
			ds_apline.NameValue(i, "ENO_NO")			= apline_row[3];//���
			ds_apline.NameValue(i, "ENO_NM") 			= apline_row[4];//�̸�
			ds_apline.NameValue(i, "JOB_NM") 			= apline_row[5];//����
			ds_apline.NameValue(i, "DPT_NM") 			= apline_row[6];//�μ�
			
			/*
			if(apline_row[1]==1){
				ds_apline.NameValue(i, "AP_STATUS_D") 	= "2";	//==���
				
			}else{
				ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==�̰�
			};
			*/
			
			ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==�̰�
			
			ds_apline.NameValue(i, "U_DATE") 			= "";
			ds_apline.NameValue(i, "AP_DESC") 			= "";
		}
		
		//�ְ��� ���缱 
		//alert("ds_apline_2_temp::"+ds_apline_2_temp.countrow);
		for(var j=1;j<=ds_apline_2_temp.countrow;j++){
			
			ds_apline2.AddRow();
			ds_apline2.NameValue(j, "SEQ") 				= ds_apline_2_temp.namevalue(j,"SEQ");        //����
			ds_apline2.NameValue(j, "AP_TYPE") 			= ds_apline_2_temp.namevalue(j,"AP_TYPE");    //��������
			ds_apline2.NameValue(j, "ENO_NO")			= ds_apline_2_temp.namevalue(j,"ENO_NO");     //���
			ds_apline2.NameValue(j, "ENO_NM") 			= ds_apline_2_temp.namevalue(j,"ENO_NM");     //�̸�
			ds_apline2.NameValue(j, "JOB_NM") 			= ds_apline_2_temp.namevalue(j,"JOB_NM");     //����
			ds_apline2.NameValue(j, "DPT_NM") 			= ds_apline_2_temp.namevalue(j,"DPT_NM");     //�μ�
			ds_apline2.NameValue(j, "AP_STATUS_D") 	    = ds_apline_2_temp.namevalue(j,"AP_STATUS_D");//==�̰�
			ds_apline2.NameValue(j, "U_DATE") 			= "";
			ds_apline2.NameValue(j, "AP_DESC") 			= "";
								
		}

	}else{
    	v_job="S_AP";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_dwr_sid=<%=v_dwr_sid%>"
			+ ",v_ap_m_sid=<%=v_ap_m_sid%>"	//���缱sid
			;
		
		//�� ���缱 ��ȸ�� Ap200I.java�� �ű�°� ���� ��.. -_-
        ln_TRSetting(tr1, 
        	"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",	
            "JSP(O:DS_APLINE=ds_apline)",
            param);
        tr_post(tr1);
	}
} 


<% //���缱 �����ͼ� ��� %>
function ln_SetDataHeader(){
	if (ds_apline.countrow<1){
		var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
				   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
				   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
		ds_apline.SetDataHeader(s_temp);
	}
}

<% //���缱 �����ͼ� ������ %>
function ln_SetDataHeader2(){
	if (ds_apline2.countrow<1){
		var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
				   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
				   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
		ds_apline2.SetDataHeader(s_temp);
	}
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

<% //���  ���ڰ���MST, ���ڰ���DTL %>
function ln_Apply(){
   
    if(!ln_Chk_Apply())return;
	
	if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			
		ln_Data_Setting();	
		
		gctr_data.KeyValue = "Account.a400140_t3(I:USER=gcds_ap_mst,I:USER2=gcds_ap_dtl)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t3";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_ap_mst',gcds_ap_mst.text);
		//prompt('gcds_ap_dtl',gcds_ap_dtl.text);
		
		gctr_data.post();
		
		ln_Query(gcem_app_no.text);
		ln_Query_Apline(gcds_data.namevalue(gcds_data.rowposition,"AP_M_SID"));
	}
}

<% //��� üũ %>
function ln_Chk_Apply(){
	
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
	
	//���� �Ŀ��� ��� �Ұ�...
	if(gcds_data.namevalue(gcds_data.rowposition,"AP_M_SID")!=0){
		alert("�̹� ����ϼ̽��ϴ�.");
		return false;
	}
	return true;
}

<% //������ ���� %>
function ln_Data_Setting(){
	var mrow=0;
	var drow=0;
	//���� MST
	ln_SetDataHeader3();
	gcds_ap_mst.addrow();
	mrow = gcds_ap_mst.rowposition;
	
	//gcds_ap_mst.namevalue(mrow,"AP_M_SID") ="" ;      //���������� ������.
	gcds_ap_mst.namevalue(mrow,"DOC_SID") ="3000";      //�̰� �׳� ���Ƿ� ����....�ǹ̾���. 
	gcds_ap_mst.namevalue(mrow,"DOC_GU") = "15";        //�ΰ�
	gcds_ap_mst.namevalue(mrow,"DOC_GU2") ="210";       //�����ΰ�
	gcds_ap_mst.namevalue(mrow,"AP_STATUS_M") ="2";     //��������
	gcds_ap_mst.namevalue(mrow,"L_EMPNO") =gs_userid;   //���������� - ��Žô� �����. ��� update 
	gcds_ap_mst.namevalue(mrow,"I_EMPNO") =gs_userid;   //�����
	gcds_ap_mst.namevalue(mrow,"I_DATE") ="" ;          //����Ͻ�  
	gcds_ap_mst.namevalue(mrow,"I_IP") = "<%=gusrip%>"; //����� IP
	gcds_ap_mst.namevalue(mrow,"U_EMPNO") ="" ;
	gcds_ap_mst.namevalue(mrow,"U_DATE") ="" ;
	gcds_ap_mst.namevalue(mrow,"U_IP") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM1") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM2") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM3") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM4") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM5") ="" ;
	gcds_ap_mst.namevalue(mrow,"CH_PARAM1") =gcem_app_no.text ; //�����ΰ� ��ûNO
	gcds_ap_mst.namevalue(mrow,"CH_PARAM2") ="" ;
	gcds_ap_mst.namevalue(mrow,"CH_PARAM3") ="" ;
	
	//���� DTL (��û��)
	ln_SetDataHeader4();
	for(var i=1;i<=ds_apline.countrow;i++ ){
		gcds_ap_dtl.addrow();
		drow=gcds_ap_dtl.rowposition;
		//gcds_ap_dtl.namevalue(drow,"AP_SID") =""; //���������� ������.
		//gcds_ap_dtl.namevalue(drow,"AP_M_SID") =ds_apline2.namevalue(i,""); // MST ������ ������.
		
		gcds_ap_dtl.namevalue(drow,"AP_GU") = "1"; //1���� 2���� 3���� 4����
		gcds_ap_dtl.namevalue(drow,"AP_SEQ")       =ds_apline.namevalue(i,"SEQ");
		gcds_ap_dtl.namevalue(drow,"AP_TYPE")      =ds_apline.namevalue(i,"AP_TYPE");
		
		if(ds_apline.namevalue(i,"SEQ")==1){
			gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  ="2"; //���
		}else{
			gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  =ds_apline.namevalue(i,"AP_STATUS_D");
		}
		gcds_ap_dtl.namevalue(drow,"AP_EMPNO")     =ds_apline.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_REAL_EMPNO")=ds_apline.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_DESC")      =ds_apline.namevalue(i,"AP_DESC");
		gcds_ap_dtl.namevalue(drow,"I_EMPNO")      =gs_userid;
		gcds_ap_dtl.namevalue(drow,"I_DATE")  ="";
		gcds_ap_dtl.namevalue(drow,"I_IP")    ="<%=gusrip%>";
		gcds_ap_dtl.namevalue(drow,"U_EMPNO") ="";
		gcds_ap_dtl.namevalue(drow,"U_DATE")  ="";
		gcds_ap_dtl.namevalue(drow,"U_IP")    ="";
		gcds_ap_dtl.namevalue(drow,"AP_JOBNM") =ds_apline.namevalue(i,"JOB_NM");
		gcds_ap_dtl.namevalue(drow,"AP_DPTNM") =ds_apline.namevalue(i,"DPT_NM");
	}
	
	//���� DTL (�ְ���)	
	for(var i=1;i<=ds_apline2.countrow;i++ ){
		gcds_ap_dtl.addrow();
		drow=gcds_ap_dtl.rowposition;
		//gcds_ap_dtl.namevalue(drow,"AP_SID") =""; //���������� ������.
		//gcds_ap_dtl.namevalue(drow,"AP_M_SID") =ds_apline2.namevalue(i,""); // MST ������ ������.
		gcds_ap_dtl.namevalue(drow,"AP_GU")   ="4"; //1���� 2���� 3���� 4����
		gcds_ap_dtl.namevalue(drow,"AP_SEQ")       =ds_apline2.namevalue(i,"SEQ");
		gcds_ap_dtl.namevalue(drow,"AP_TYPE")      =ds_apline2.namevalue(i,"AP_TYPE");
		gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  =ds_apline2.namevalue(i,"AP_STATUS_D");
		gcds_ap_dtl.namevalue(drow,"AP_EMPNO")     =ds_apline2.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_REAL_EMPNO")=ds_apline2.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_DESC")      =ds_apline2.namevalue(i,"AP_DESC");
		gcds_ap_dtl.namevalue(drow,"I_EMPNO")      =gs_userid;
		gcds_ap_dtl.namevalue(drow,"I_DATE") ="";   //�����Ͻ�
		gcds_ap_dtl.namevalue(drow,"I_IP") ="<%=gusrip%>" ;
		gcds_ap_dtl.namevalue(drow,"U_EMPNO") ="";  //����
		gcds_ap_dtl.namevalue(drow,"U_DATE")  ="";  //����
		gcds_ap_dtl.namevalue(drow,"U_IP")    ="";  //����
		gcds_ap_dtl.namevalue(drow,"AP_JOBNM") =ds_apline2.namevalue(i,"JOB_NM");
		gcds_ap_dtl.namevalue(drow,"AP_DPTNM") =ds_apline2.namevalue(i,"DPT_NM");
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_apline2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_apline_2_temp classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_mst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_dtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_gc_apsts_d classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=gcds_jobcd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data_appno classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	</object>

    <object id=gctr_data_save classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a400140_t1(I:USER=gcds_data,O:USER2=gcds_data_appno)">
	</object> 	
</comment><script>__ws__(__NSID__);</script>
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
	if (rowcount ==0 ){
		//alert("�˻��� ����Ÿ�� �����ϴ�.");
	}else{
		//alert("rowposition::"+rowposition);
		//alert(gcds_data.namevalue(rowposition,"ATT_FILE_NAME"));
		if(gcds_data.namevalue(rowposition,"ATT_FILE_NAME")!=""){
			fnAddFileList(gcds_data.namevalue(rowposition,"ATT_FILE_NAME"));
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
<script language="javascript" for="gctr_data_save" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	gcem_app_no.text=gcds_data_appno.namevalue(gcds_data_appno.rowposition,"APP_NO");
</script>
<script language="javascript" for="gctr_data_save" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data_save.ErrorCode + "\n" + "Error Message : " + gctr_data_save.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="998px" align="right"  style="padding-top:4px;"> 
					    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/btn_ReportOver.gif" style="cursor:hand" onclick="ln_Apply()" >
					    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	 style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	 style="cursor:hand" onclick="ln_Delete()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;�� �����ΰ� ���� ��û�ۼ�</font></b>
		<td>
	</tr>
	<tr>
		<td colspan=2 >
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:1 solid #708090'>
			<tr>
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
				     <input id="txt_app_jobnm"  type="text"  style= "position:relative;top:0px;left:4px;width:100px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��û��</nobr> </td>
				<td class="tab22">
					 <input id="txt_app_empno"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_empnm"  type="text"  style= "position:relative;top:0px;left:4px;width:100px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
		    </tr>
		    <tr>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>�ΰ�ID</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_signet_id  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="0000">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
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
				<td class="tab21" colspan=3>
					<comment id="__NSID__">
						<object id=gcem_signet_submit  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:380px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    
		    
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
				<td class="tab22" >
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
		    </tr>
		    
		    <form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  > 
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>ǰ�Ǽ� �纻��</nobr> </td>
				<td class="tab22" colspan=7>
					<input type="file"  name="filename"  style="position:relative;left:4px;top:0px;width:736px;height:20px" >
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>ǰ�Ǽ� �纻�� ÷��</nobr> </td>
				<td class="tab22" colspan=7>
					<select multiple name="fileList" id="fileList" style="position:relative;left:4px;top:2px; width:230px;height:25px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
						 <option></option>
					</select>
					<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload()">
					<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">    
		    </tr>
		    </form>
			     
			    <!-- ���� ������ ��-->
				<FORM METHOD=POST NAME="file_del">
				<input type="hidden" name="realFileName">
				<input type="hidden" name="virtualFileName">
				<input type="hidden" name="saveDir">
				<input type="hidden" name="mode">
				</FORM> 
			     
			     <!-- ���� �ӽ� ���ε�� iFrame -->
				<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>
		    
		     <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>�ΰ����� ����</nobr> </td>
				<td class="tab21" colspan=3 >
					<comment id="__NSID__">
						<object id=gcem_signet_certi_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:3px;width:50px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script><font size="2" >&nbsp;(��)</font>
				</td>
				
		    	<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>��⺻�</nobr> </td>
				<td class="tab22" colspan=3>
					<comment id="__NSID__">
						<object id=gcem_regi_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:3px;width:50px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script><font size="2" >&nbsp;&nbsp;(��)</font>
					&nbsp;	
					<comment id="__NSID__">
						<object id=gcra_cur_can_gb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="position:relative;left:0px;top:3px; width:180px;height:20px" >
							<param name=Cols	value="2">
							<param name=Format	value="1^��ȿ����, 2^���һ���">
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
		</table>
		</td>
	</tr>
	<tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnPopApline()">
		</td>
	</tr>
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090'><b><font size="2" color="blue">&nbsp;�� ��û�� ���缱</font></b></td>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090'><b><font size="2" color="blue">&nbsp;�� �ְ��� ���缱</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
			<tr>
				<td><nobr>
					<comment id="__NSID__">
			  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='498px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='����'	      ID=SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='����'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='���'	      ID=ENO_NO   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='�̸�'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='����'		  ID=JOB_NM           HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='�Ҽ�'        ID=DPT_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='�������'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='�ǰ�'        ID=SP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td><nobr>  
					<comment id="__NSID__">
			  		<object id=gcgd_supteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='498px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline2">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='����'	      ID=SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='����'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='���'	      ID=ENO_NO   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='�̸�'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='����'		  ID=JOB_NM           HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='�Ҽ�'        ID=DPT_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='�������'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='�ǰ�'        ID=SP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 1.��� ��ư Ŭ�� �� �Է� �Ͻýʽÿ�.</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 2.��û �ۼ� �� ���� ��ư Ŭ��</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 3.���缱���� ��ư Ŭ��</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 4.��� ��ư Ŭ��</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 5.���� - ���� ���ϸ��� ������ ������ ��� [���ϸ�+NO]�� �ڵ� ����˴ϴ�.</font></td>
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
	<C>Col=SIGNET_ID               Ctrl=gcem_signet_id        Param=text</C>
	<C>Col=SIGNET_USE              Ctrl=gcem_signet_use       Param=text</C>
	<C>Col=SIGNET_SUBMIT           Ctrl=gcem_signet_submit    Param=text</C>
	<C>Col=PAPER_CNT               Ctrl=gcem_paper_cnt        Param=text</C>
	<C>Col=SEAL_CNT                Ctrl=gcem_seal_cnt         Param=text</C>
	<C>Col=ATT_FILE_NAME           Ctrl=fileList              Param=text</C>
	<C>Col=SIGNET_CERTI_CNT        Ctrl=gcem_signet_certi_cnt Param=text</C>
	<C>Col=REGI_CNT                Ctrl=gcem_regi_cnt         Param=text</C>
	<C>Col=CUR_CAN_GB              Ctrl=gcra_cur_can_gb       Param=codevalue</C>
	<C>Col=SEAL_DATE               Ctrl=gcem_seal_date        Param=text</C>
	<C>Col=SIGNET_MGR_NO           Ctrl=gcem_signet_mgr_no    Param=text</C>
	<C>Col=APP_TEAMCD              Ctrl=txt_app_teamcd        Param=value</C>
	<C>Col=APP_JOBCD               Ctrl=txt_app_jobcd         Param=value</C>
	<C>Col=APP_EMPNO               Ctrl=txt_app_empno         Param=value</C>
	<C>Col=APP_DATE                Ctrl=gcem_app_date         Param=text</C>
	<C>Col=REMARK                  Ctrl=gcem_remark           Param=text</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



