<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ȸ�����/���԰���(���ڼ��ݰ�꼭)
+ ���α׷� ID	: A040075.html
+ �� �� �� ��	: ��������� �� ���԰���(���ڼ��ݰ�꼭)
+ �� �� �� ��	: ������
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a040075_s2 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���԰���</title>

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
//document.domain = "http://erp.hdasan.com"; 
var gs_gubun="";
var gs_status="";
var gs_signal="";
var gs_sm_call_status=""; // ȣ�� asp ����
var gs_conversation_id="";
//var gs_interface_batch_id="";
var gs_empnos="";
var gs_deptcds="";

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

  //&&
	//newWin=window.open('inform.html','child','width=350,height=230,top=310,left=350');
	
	
	gclx_cocode.index=2;
	//ln_Find_Regno();
	//ln_Query(gcem_regno.text);
  	ln_Before();

    //gcem_frdt.text="20090901";
	//gcem_todt.text="20090930";

	gclx_fdcode.index=1;
	gclx_supbuy.index=0;
	gclx_status.index=0;

	gcem_frdt.text=ln_Load_Date('s');
  	gcem_todt.text=ln_Load_Date('c');

	//gclx_status.style.color="#FF0000";
	//gclx_status.style.background="#FFFFCC";
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

  	ln_Authority();
}


/******************************************************************************
	Description : ������ȸ
******************************************************************************/
function ln_Authority(){
	
	//login�ڿ� �ΰ��� ������Ȯ��---------------------------------------------------------
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gusrid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
		gs_empnos="";
		gs_deptcds="";
	}else{
		hid_login.value="";	
	
		//�α������� ����.-----------------------------------------------------------------------
		gcds_right.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0902&v_str3="+gusrid;
		//prompt(this,gcds_right.DataID);
		gcds_right.Reset();

		for(i=1;i<=gcds_right.countrow;i++){
			if(gcds_right.namevalue(i,"CDREMARK")!=""){   // ���κ����� ������.empno
				gs_empnos=gs_empnos+gcds_right.namevalue(i,"CDREMARK")+"','";
			}else if(gcds_right.namevalue(i,"GBCD")!=""){ // �μ������� ������.deptcd
				gs_deptcds=gs_deptcds+gcds_right.namevalue(i,"GBCD")+"','"; 
			}
		}

		//�Ǹ������� �޸��� �����.
		if(gs_empnos.length>1){
			gs_empnos = gs_empnos.substring(0,gs_empnos.length-3);
		}

		if(gs_deptcds.length>1){
			gs_deptcds = gs_deptcds.substring(0,gs_deptcds.length-3);
		}
		//------------------------------------------------------------------------------------
	} 
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  var strregno ="";   

	if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;

  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040075_s2?v_str1="+gclx_fdcode.bindcolval   //����                
	                                                                  +"&v_str2="+strregno                 //�����              
																	  +"&v_str3="+gcem_frdt.text		   //��꼭�Ⱓ from     
																 	  +"&v_str4="+gcem_todt.text		   //��꼭�Ⱓ to       
																	  +"&v_str5="+gcem_regno.text		   //����ڵ�Ϲ�ȣ      
																	  +"&v_str6="+gcem_vendnm.text		   //�ŷ�ó��            
																	  +"&v_str7="+gcem_vendcd.text		   //�ŷ�ó�ڵ�    ( ���� )      
																	  +"&v_str8="+gclx_supbuy.bindcolval   //���౸��
																	  +"&v_str9="+gclx_status.bindcolval   //����
																	  +"&v_str10="+gusrid                  //id     
																	  +"&v_str11="+gs_empnos	           //���������� ���     
																	  +"&v_str12="+gs_deptcds	           //���������� �μ�
																	  +"&v_str13="+hid_login.value;	       //�����ڱ���																											
//prompt("",gcds_data.DataID);
  gcds_data.Reset();

}

/******************************************************************************
	Description : ������ ����
	�����͸� XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS�� INSERT �ؾ���.
******************************************************************************/
function ln_Save(){
  /*

  if (gcds_data.IsUpdated) {
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t1"

			gctr_data.Parameters = "v_str1=1018510695,v_str2="+gusrid;

			prompt('',gcds_data.text);
			gctr_data.post();
		}	
	}
  */

 /*
  if(!ln_Chk()) return;
  
  var v_left = (screen.width-300)/2;
  var v_top  = (screen.height-300)/2;
  //var v_left = screen.availWidth/2 - 300/2; 
  //var v_top  = screen.availHeight/2 - 300/2;            

	
	if(gcds_data.namevalue(1,"CHK")=="T"){        //������ ���
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_s+"&CERT_COMNAME="+gs_comname_s;		
	}else if(gcds_data.namevalue(2,"CHK")=="T"){  //������ ���
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_g+"&CERT_COMNAME="+gs_comname_g;	
	}

  window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
	*/
}

/******************************************************************************
	Description : ����� �ڵ�� ����ڵ�Ϲ�ȣ ã�� 
******************************************************************************/
function ln_Find_Regno(){
  /*
	if(gclx_cocode.bindcolval=="01"){
		gcem_regno.text =gs_regno_g;
	}else if(gclx_cocode.bindcolval=="02"){
    gcem_regno.text =gs_regno_s;
	}else{
    gcem_regno.text ="";
	}
	*/
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Chk(){
  /*
	var intcnt = 0; 

  //������ ������ �� �͵� �� �Ȱ��
  for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	
  if (intcnt==0){
		alert("�ش� ����� ��ȣ�� �����Ͻʽÿ�.");
		return false;
	}else if(intcnt==1){
    return true;
	}else if(intcnt==2){
		alert("����� ��ȣ�� 1�Ǹ� �����Ͻʽÿ�.");
		return false;
	}else{
    alert("��Ÿ");
    return false;
	}
	*/
}
/******************************************************************************
	Description : ã�� - �ŷ�ó�ڵ�
******************************************************************************/
function ln_Popup(){
    var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
			gcem_regno.text	= arrParam[5];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
			gcem_regno.text="";
		}
}


/******************************************************************************
	Description : ������ ���Կ�û 
	parameter   : strStatus  - ������ �����ڵ�           
	              strSignal  - signal
                strBtnname - ��ư��Ī
  ������ ������ ���������� ������ ��Ʈ��ũ ������ ȣ�������� ȣ�� ���� ��� STATUS ='S' �ΰ��� ��ȸ�� �� �� ������.
******************************************************************************/
function ln_Issue(strStatus,strSignal,strBtnname){

	if (gcds_data.IsUpdated) {
		if (confirm(strBtnname+" �Ͻðڽ��ϱ�?")){	
			gs_sm_call_status="I";
		  ln_Batch_id();
		}
	}
}



/******************************************************************************
	Description : ���������
	parameter   : strStatus  - ������ �����ڵ�           
	              strSignal  - signal
                strBtnname - ��ư��Ī
  ������ ���� �ϰ�� ==> ATTAXMST �� ATTAXDTL�� �����͸� �����ؾ���.
******************************************************************************/
function ln_SaleIssue(strStatus,strSignal,strBtnname){

	var rowcnt=0;
//	gs_interface_batch_id="";
	gs_status="";
	gs_signal="";
	
	var strChk="";
 
    //2011.01.10 jys
	//����ڵ�Ϲ�ȣ 1018510695�� �� ���� ���Ž��� �ȵ�.

	//üũ - �Ǻ��θ� ������ ���� ������.
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			rowcnt+=1;
			if(gcds_data.namevalue(i,"BYR_COM_REGNO")=="1018510695"){
				strChk="N";
			}
		}
	}

	if(strChk=="N"){
		alert("����ڵ�ι�ȣ�� 1018510695 �Դϴ�. �������� Ȯ�� ��Ź�մϴ�.");	
    }

	if(rowcnt>1){
		alert("������ ������ ��� 1�Ǿ� �����մϴ�.");
		return;
	}

	gs_status = strStatus; 
	gs_signal = strSignal;

	//üũ ....
	//������� �ŷ� �̸����� ��ϵǾ� ���� ������...���� �ȵ�.
	//�ش� �������� ������ ��� ( ��������� ������ �ߴµ�, �ƻ� db���� ������ �Ǿ��µ�, ����Ʈ�� asp ������ ȣ���� ���� ��� )
	// ==> �� ���� ��� ó���ұ�? 1. ������ ������ �� �̸� üũ�Ͽ� �����ϸ� update�� ģ��.
	//                         2. ������ ������ �� �̸� üũ�Ͽ� �����ϸ� delete �� insert�� ģ��.
	//                         3. ������ �ٸ� ���������� üũ�غ���. ( �Ǻ� ó���� ������ �� ����.)  

	var strregno ="";
  	if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;
 
	if (gcds_data.IsUpdated) {
		if (confirm(strBtnname+" �Ͻðڽ��ϱ�?")){	
		    gs_sm_call_status="S";
		    //gctr_data.KeyValue = "a040065_t3(I:USER=gcds_data,O:USER2=gcds_return)";
			gctr_data.KeyValue = "a040075_t3(I:USER=gcds_data,O:USER2=gcds_return)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040075_t3"
			gctr_data.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
		  //prompt('gcds_data',gcds_data.text);
			gctr_data.post();
	
		}
	}
}

/******************************************************************************
	Description : �����ڵ� ����
	parameter   : strStatus - ������ �����ڵ�           
	              strSignal - signal
                strBtnname - ��ư��Ī
******************************************************************************/
function ln_Status(strStatus,strSignal,strBtnname){
  var strTitle="";
  gs_status="";
  gs_signal="";

  gs_sm_call_status="S";   //���º���

  if(strSignal=="REJECT"){               // ���Űź�
		strTitle="���Űź� ����";
  }else if(strSignal=="CANCELRREQUEST"){ //�������û���
		strTitle="�������û��� ����";
  }else if(strSignal=="CANCELREQ"){      //������ҿ�û
    strTitle="������ҿ�û ����";
  }else if(strSignal=="REQREJECTP"){     //������Ұź�
    strTitle="������Ұź� ����";
  }

	if (gcds_data.IsUpdated) {
		if (confirm(strBtnname+" �Ͻðڽ��ϱ�?")){	
			if(strTitle!=""){
				ln_Reason_Popup(strSignal,strTitle); 
			}
			gs_status = strStatus; 
			gs_signal = strSignal;
		 
			//BATCH_ID �����Ͽ� XXSB_DTI_MAIN�� UPDATE�ϰ�  UPDATE �� BATCH_ID�� XXSB_DTI_STATUS_CHANGE.asp�� �ѱ�(�����ͼ����� ���� ) 
			ln_Batch_id();
		}
	}//IsUpdated

}

/******************************************************************************
	Description : �����Է�
	parameter   :            
******************************************************************************/
function ln_Reason_Popup(strSignal,strTitle){
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;

		hid_sbdescription.value= "";

		arrParam[0] = strTitle;

		strURL = "./a040065_popup.jsp";
		strPos = "dialogWidth:350px;dialogHeight:140px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			hid_sbdescription.value  = arrParam[0];	
		} else {
			hid_sbdescription.value= "";
		}

		//alert("hid_sbdescription.value ::"+hid_sbdescription.value );
}

/******************************************************************************
	Description : Interface_Batch_id ���� �� ������� id, pw ã��
	parameter   :            
******************************************************************************/
function ln_Batch_id(){      

    var strregno ="";
    if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;

    gctr_data.KeyValue = "a040065_t1(I:USER=gcds_data,O:USER2=gcds_return)";
	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t1"
	gctr_data.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
	//	prompt('gcds_data',gcds_data.text);
	gctr_data.post();
}

/******************************************************************************
	Description : ������� id, pw ã��
	parameter   :            
******************************************************************************/
function ln_ID_PW_Find(){

    var strregno ="";
    if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;

	gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t2"
	gctr_data2.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
	//prompt('gcds_data',gcds_data.text);
	gctr_data2.post();
}

/******************************************************************************
	Description : DataSet Header ����
	parameter   :            
******************************************************************************/
function ln_SetDataHeader(){
 
    gcds_temp.clearAll();
   
	if (gcds_temp.countrow<1){
		var s_temp = "TEMPC:STRING";							 
		gcds_temp.SetDataHeader(s_temp);
	}
   
	gcds_temp.Addrow();
	gcds_temp.namevalue(gcds_temp.rowposition,"TEMPC")="A";
}

/******************************************************************************
	Description : ���ݰ�꼭 ����
	parameter   :            
******************************************************************************/
function ln_Bill_View(){

	if (gcds_data.IsUpdated){
		gs_sm_call_status="V"; // ��꼭���� tag
		ln_Batch_id();
	}
}

/******************************************************************************
	Description : Email ��߼�
	parameter   :            
******************************************************************************/
function ln_Email(){

	var rowcnt=0;
	var strSupEmail="";
	gs_conversation_id="";

	//üũ - �Ǻ��θ� ���� �߼۰�����.
	for(i=1;i<=gcds_data.countrow;i++){
	  //alert("i:::"+i+"::CONVERSATION_ID::"+gcds_data.namevalue(i,"CONVERSATION_ID")+":CHK:"+gcds_data.namevalue(i,"CHK"));
		if(gcds_data.namevalue(i,"CHK")=="T"){
			rowcnt+=1;
			gs_conversation_id = gcds_data.namevalue(i,"CONVERSATION_ID");
			strSupEmail = gcds_data.namevalue(i,"SUP_EMAIL");
		}
	}

	if(rowcnt>1){
		alert("�̸��� ��߼��� 1�Ǿ� �����մϴ�.");
		return;
	}

	//���� �Է� �˾�
	if (gcds_data.IsUpdated){
	  
		//true false ����
		if(!ln_Mail_Popup('�����Է�', strSupEmail)) return;
		gs_sm_call_status="E"; // Email ��߼�
		ln_SetDataHeader();
		ln_ID_PW_Find();
	}
}


/******************************************************************************
	Description : ��߼� Email �Է� �˾�
	parameter   :            
******************************************************************************/
function ln_Mail_Popup(strTitle, strSupEmail){
	  	var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL="";	
		var strPos="";;

		hid_email.value= "";

		arrParam[0] = strTitle;
		arrParam[1] = strSupEmail;
		
		strURL = "./a040065_email_popup.jsp";
		strPos = "dialogWidth:350px;dialogHeight:140px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			hid_email.value  = arrParam[0];	
			return true;
		} else {
			hid_email.value= "";
			return false;
		}

	    //alert("::::hid_email::::"+hid_email.value);
}

/******************************************************************************
	Description : ����Ʈ ��� ȣ�� 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){

    	//alert("gs_sm_call_status::"+gs_sm_call_status+"::::");
		//alert("gs_interface_batch_id"+gs_interface_batch_id+"::::"); 
		//alert("strId::"+strId+"::::");
		//alert("strPass::"+strPass+"::::");
        //alert("strBatchId::"+strBatchId+"::STATUS::"+gs_status+"::SIGNAL::"+gs_signal+"::strId::"+strId+"strPass::"+strPass+"::SBDESCRIPTION::"+hid_sbdescription.value);
    
		var url="";

	    var v_left = (screen.width-300)/2;
	    var v_top  = (screen.height-300)/2;

		if(gs_sm_call_status=="S"){          //���º���
				url=gs_url+"/callSB_V3/XXSB_DTI_STATUS_CHANGE.asp?BATCH_ID="+strBatchId+"&STATUS="+gs_status+"&SIGNAL="+gs_signal
																+"&ID="+strId+"&PASS="+strPass+"&SBDESCRIPTION="+hid_sbdescription.value;	
        		window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );																													
		}else if (gs_sm_call_status=="V"){   //���ݰ�꼭 ���� �� ���
				url=gs_url+"/callSB_V3/XXSB_DTI_PRINT.asp?BATCH_ID="+strBatchId+"&SORTFIELD=A&SORTORDER=1";			
				window.open(url,"", "status=1,  scrollbars=yes, width=300, height=280, left="+v_left+", top="+v_top  );
   		}else if (gs_sm_call_status=="R"){   //������ ����
				url=gs_url+"/callSB_V3/XXSB_DTI_RARISSUE.asp?CONVERSATION_ID="+gs_conversation_id+"&ID="+strId+"&PASS="+strPass;	
				window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
		}else if (gs_sm_call_status=="I"){   //��������Կ�û
				url=gs_url+"/callSB_V3/XXSB_DTI_ISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
				window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
    }

		ln_Query();
}

/******************************************************************************
	Description : ����Ʈ ��� ȣ�� _ Email 
******************************************************************************/
function ln_SM_Email_Call( strId, strPass){

  //  alert("::CONVERSATION_ID::"+gs_conversation_id+"::EMAIL::"+hid_email.value+"::strId::"+strId+"strPass::"+strPass+"::STATUS::"+gclx_status.bindcolval);  
	var url="";
    var v_left = (screen.width-300)/2;
    var v_top  = (screen.height-300)/2;

    if (gs_sm_call_status=="E"){   //Email ��߼�
		url=gs_url+"/callSB_V3/XXSB_DTI_SEND_EMAIL.asp?CONVERSATION_ID="+gs_conversation_id+"&EMAIL="+hid_email.value	
		                                             +"&ID="+strId+"&PASS="+strPass+"&STATUS="+gclx_status.bindcolval;	
    }
		window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}

/******************************************************************************
	Description : ����Ʈ ��� ȣ�� _������ ���� 
******************************************************************************/
/*
function ln_SM_ISSUE_Call( strId, strPass){
  //  alert("::CONVERSATION_ID::"+gs_conversation_id+"::EMAIL::"+hid_email.value+"::strId::"+strId+"strPass::"+strPass+"::STATUS::"+gclx_status.bindcolval);  
		var url="";
    var v_left = (screen.width-300)/2;
    var v_top  = (screen.height-300)/2;

    if (gs_sm_call_status=="R"){   //������ ����
				url=gs_url+"/callSB_V3/XXSB_DTI_RARISSUE.asp?CONVERSATION_ID="+gs_conversation_id+"&ID="+strId+"&PASS="+strPass;	
    }
		window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}
*/
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- ���Ѱ��� -->
<object id=gcds_right classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
	<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
  </object>     
	<object id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a040065_t2(I:USER=gcds_temp,O:USER2=gcds_return)">
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

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��     ***** ���ǻ��� : ������ ������ ��� ���Ž��� �� ���ݰ�꼭 ����Ͽ� ���Ը����Ͽ��� ������ֽʽÿ�. *****";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
  
	//ln_Find_Regno();
  //ln_Query(gcem_regno.text);

</script>

<script language="javascript"  for=gcgd_data event="OnClick(row,colid)">
  
	if(row==0 && colid=="CHK"){ //��ü����              
		if(gcds_data.namevalue(1,"CHK")=="T"){ //ù���� üũ �Ǿ� ���� ���
			for(i=1;i<=gcds_data.Countrow;i++){
				gcds_data.namevalue(i,"CHK") = "F";
			}//for
		}else{
			for(i=1;i<=gcds_data.Countrow;i++){  //ù����  üũ ���� ���� ��� ��� üũ 
				gcds_data.namevalue(i,"CHK") = "T";
			}//for
		}
	}else if (row!=0 && colid=="CHK"){  //��������
      /*
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		if(gs_gubun=="1"||gs_gubun==""){
			gcds_data.namevalue(row,"CHK")="T";
		}else{
			gcds_data.namevalue(row,"CHK")="F";
		}
	 */
	}
</script>

<script language=JavaScript for=gclx_supbuy event=OnSelChange()>

	if(gclx_supbuy.bindcolval=="0"){  //��ü   - �ϴ� ���౸���� ��ü�� ����.
		gclx_status.CBData ="";
	}else if(gclx_supbuy.bindcolval=="1"){ //������
    gclx_status.CBData ="''^��ü,A^��������,V^�������û,I^���Ź̽���,C^���Ž���,M^������ҿ�û(���޹޴���),N^������ҿ�û(������),R^���Űź�,O^��ҿϷ�,T^������ź�,W^�������û ���";
	}else if(gclx_supbuy.bindcolval=="2"){ //������
    gclx_status.CBData ="''^��ü,I^���Ź̽���,C^���Ž���,M^������ҿ�û(���޹޴���),N^������ҿ�û(������),R^���Űź�,O^��ҿϷ�";
	}

	ln_Query();
</script>

<script language=JavaScript for= gclx_status event=OnSelChange()>
   //����
	if(gclx_status.bindcolval =="I"){ // ���Ź̽��� => ���Ž���, ���Űź�
	   
		 //alert("I::���Ź̽���");
    	 sp4.style.display = "";
		 sp5.style.display = "";

		 sp0.style.display = "none";
	   	 sp1.style.display = "none";
		 sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp6.style.display = "none";
		 sp7.style.display = "none";
		 sp8.style.display = "none";

	}else if(gclx_status.bindcolval =="C"){ //���Ž��� => ������ҿ�û, ���ݰ�꼭����
		 sp1.style.display = "none";  //2014.01.09
		 sp7.style.display = "";

		 sp0.style.display = "none";
	     sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp6.style.display = "none";
		 sp8.style.display = "none";

	}else if(gclx_status.bindcolval =="N"){ //������ҿ�û(������) => ������ҽ���, ������Ұź�
		 sp2.style.display = "";
 	     sp3.style.display = "";

		 sp0.style.display = "none";
	     sp1.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp6.style.display = "none";
		 sp7.style.display = "none";
		 sp8.style.display = "none";

 	}else if(gclx_status.bindcolval =="V"){ //�������û => �������û���, �̸�����߼�

	     sp0.style.display = "";
		 sp6.style.display = "";
		 
	     sp1.style.display = "none";
		 sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp7.style.display = "none";
		 sp8.style.display = "none";
  
	}else if(gclx_status.bindcolval =="A"){ //��������

	     sp8.style.display = "";
		 
		 sp0.style.display = "none";
	     sp1.style.display = "none";
		 sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp6.style.display = "none";
		 sp7.style.display = "none";

	}else{
	     sp0.style.display = "none"; //�������          X  ==> �������û���
		 sp1.style.display = "none"; //������ҿ�û    O
		 sp2.style.display = "none"; //������ҽ���    O
		 sp3.style.display = "none"; //������Ұź�    O
		 sp4.style.display = "none"; //������ź�       X  ==> ���Ž���
		 sp5.style.display = "none"; //���������       X  ==> ���Űź�
		 sp6.style.display = "none"; //�̸�����߼�    0  
		 sp7.style.display = "none"; //���ݰ�꼭���� 0
		 sp8.style.display = "none";
	}

  ln_Query();
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>
	ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data2 event=OnSuccess()>

  if(gs_sm_call_status=="E"){ //Email ��߼�
		ln_SM_Email_Call(gcds_return.namevalue(gcds_return.rowposition,"ID"),
						 gcds_return.namevalue(gcds_return.rowposition,"PASS"));
  /*
	}else if(gs_sm_call_status=="R"){ //������ ����
		ln_SM_ISSUE_Call(gcds_return.namevalue(gcds_return.rowposition,"ID"),
										 gcds_return.namevalue(gcds_return.rowposition,"PASS"));
  */
	}
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>
 
 
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040075_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
    <!--   <img src="../../common/img/btn/com_b_sale.gif"      style="cursor:hand" onclick="ln_Save()">-->

      		<span id=sp0 style="display:none;"> <!-- �������û��� -->
				<img src="../../Common/img/btn/com_b_op_order_cancel.gif"   style="cursor:hand" onclick="ln_Status('W','CANCELRREQUEST','�������û���')">
			</span>

			<span id=sp1 style="display:none;"> <!-- ������ҿ�û -->
				<img src="../../Common/img/btn/com_b_p_cancel_re.gif"   style="cursor:hand" onclick="ln_Status('M','CANCELREQ','������ҿ�û')">
			</span>

			<span id=sp2 style="display:none;"> <!-- ������ҽ��� -->
				<img src="../../Common/img/btn/com_b_p_cancel_ap.gif"   style="cursor:hand" onclick="ln_Status('O','SRADAPPRP','������ҽ���')">
			</span>

			<span id=sp3 style="display:none;"> <!-- ������Ұź� -->
				<img src="../../Common/img/btn/com_b_p_cancel_rj.gif"   style="cursor:hand" onclick="ln_Status('C','REQREJECTP','������Ұź�')">
			</span>

			<!-- <span id=sp4 style="display:none;"> <!-- ���Ž���
				<img src="../../common/img/btn/com_b_reveive_ap.gif"    style="cursor:hand" onclick="ln_Status('C','APPROVE','���Ž���')">
			</span> -->

			<span id=sp4 style="display:none;"> <!-- ���Ž��� -->
				<img src="../../Common/img/btn/com_b_reveive_ap.gif"    style="cursor:hand" onclick="ln_SaleIssue('C','APPROVE','���Ž���')">
			</span>

			<span id=sp5 style="display:none;"> <!-- ���Űź� -->
				<img src="../../Common/img/btn/com_b_receive_rj.gif"    style="cursor:hand" onclick="ln_Status('R','REJECT','���Űź�')">
			</span>

     <!--  <span id=sp5 style="display:none;"> 
				<img src="../../common/img/btn/com_b_op_sale.gif"       style="cursor:hand" onclick="ln_SaleIssue('R','REJECT','���Űź�')">
			</span> -->
      
			<span id=sp6 style="display:none;"> <!-- �̸��� ��߼�  -->
				<img src="../../Common/img/btn/com_b_email_re.gif"      style="cursor:hand" onclick="ln_Email()">
			</span>

			<span id=sp7 style="display:none;"> <!-- ���ݰ�꼭���� -->
				<img src="../../Common/img/btn/com_b_bill_view.gif"     style="cursor:hand" onclick="ln_Bill_View()">
			</span>
			<span id=sp8 style="display:none;"> <!-- �������� -->
				<img src="../../Common/img/btn/com_b_op_order.gif"     style="cursor:hand" onclick="ln_Issue('I','','��������Կ�û')">
			</span>
			<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onclick="ln_Query()"> 
			</nobr>
		</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;" >
		<tr> 
      <td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>�����ڵ�</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:2px;width:100px;">
					<param name=ComboDataID			value="gcds_fdcode">
					<param name=CBDataColumns		value="FDCODE,FDNAME">
					<param name=SearchColumn		value="FDNAME">
					<param name=Sort						value=false>
					<param name=Enable          value="true">
					<param name=ListExprFormat	value="FDNAME^0^100">
					<param name=BindColumn			value="FDCODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab18" ><nobr>�����</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object id=gclx_cocode      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:100px;">
					<param name=CBData			  value="00^��ü,01^����,02^����,04^ȫ��">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			      value=false>
					<param name=ListExprFormat	Value="CODE^1^30,NAME^1^60">								
					<param name=BindColumn		  value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>����Ⱓ</nobr></td>
			<td width="400px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY-MM-DD">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
					<param name=ClipMode      value=false>
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
				<comment id="__NSID__">
				<object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY-MM-DD">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
					<param name=ClipMode      value=false>
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
			</td>
		</tr>
		<tr> 
      <td width="100px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>����ڵ�Ϲ�ȣ</nobr></td>
			<td width="150px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:80px;height:20px;">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="000-00-00000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<!-- <param name=ReadOnly      value=true> -->
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>�ŷ�ó��</nobr></td>
			<td width="150px" class="tab19" colspan=3><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:250px" onKeydown="if(event.keyCode==13) ln_Popup()">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit value="true">
					<param name=PromptChar	value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script>&nbsp;
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
			  <comment id="__NSID__">
				<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) ln_Popup()">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#############">
					<param name=PromptChar	value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text = '';gcem_vendcd.text = '';gcem_regno.text=''">
			  </nobr> 
			</td>
		</tr>
		<tr> 
      <td width="100px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>���౸��</nobr></td>
			<td width="150px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gclx_supbuy      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:100px;">
					<param name=CBData			  value="2^������,1^������">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			      value=false>
					<param name=ListExprFormat	Value="CODE^0^30,NAME^0^60">								
					<param name=BindColumn		  value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>��    ��</nobr></td>
			<td width="150px" class="tab19" colspan=3><nobr>&nbsp;<comment id="__NSID__">
				<object id=gclx_status      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:180px;color:#FF0000;background:#FFFFCC">
					<param name=CBData			  value="''^��ü,I^���Ź̽���,C^���Ž���,R^���Űź�,O^��ҿϷ�,M^������ҿ�û(���޹޴���),N^������ҿ�û(������),V^�������û,T^������ź�,W^�������û ���">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			      value=false>
					<param name=ListExprFormat	Value="CODE^0^30,NAME^0^160">								
					<param name=BindColumn		  value="CODE">
					<param name=InheritColor	  value=true>
				</object>
				</comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp; <FONT SIZE="2" COLOR="BLUE"><B>�� ���� ���ÿ� ���� ��ư�� ����˴ϴ�.</B></FONT>
			  </nobr> 
			</td>
		</tr>
		</table>
   </td>
	</tr>

	<tr>
	<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_data">
						<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="IndWidth"      value="0">
						<param name="Fillarea"		  VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<param name="UsingOneClick" value="1">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='����'	             ID=CHK         	      HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	EditStyle=CheckBox </FC> 
						<FC> Name='�ŷ�ó��'			 ID=CONVERSATION_ID   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=250	align=left		edit=none  show = false </FC>
						<FC> Name='�ŷ�ó��'			 ID=SUP_COM_NAME   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		edit=none </FC>
						<FC> Name='����ڵ�Ϲ�ȣ'	     ID=SUP_COM_REGNO         HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=center    edit=none  Mask='XXX-XX-XXXXX'</FC>
						<C>  Name='���ް���'			 ID=SUP_AMOUNT            HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right		edit=none </C>
						<C>  Name='�ΰ�����'		     ID=TAX_AMOUNT            HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right		edit=none </C>
						<C>  Name='�հ�'              ID=TOTAL_AMOUNT   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right  	edit=none </C>			
						<C>  Name='����'              ID=DTI_STATUS    	      HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  EditStyle=Combo Data='A:��������,V:�������û,I:���Ź̽���,C:���Ž���,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),R:���Űź�,O:��ҿϷ�,T:������ź�,W:�������û ���'</C>			  					
						<C>  Name='�����ڵ�'		     ID=RETURN_CODE  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none </C>
						<C>  Name='�����ڵ峻��'        ID=RETURN_DESCRIPTION    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none Value={IF(RETURN_CODE=30000,'����',RETURN_DESCRIPTION)}</C>					
						<C>  Name='����'              ID=SBDESCRIPTION         HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none </C>					
  				        <C>  Name='Email'			 ID=SUP_EMAIL   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left		edit=none </C>
						<C>  Name='���޹޴´����'       ID=BYR_EMP_NAME	      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none </C>
						<C>  Name='���޹޴»���ڵ�Ϲ�ȣ' ID=BYR_COM_REGNO	      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none  Mask='XXX-XX-XXXXX'</C>
					    <C>  Name='��꼭����'    	      ID=DTI_WDATE  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center  edit=none  </FC>
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			  <input id="hid_sbdescription" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
				<input id="hid_email" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
			</td>
		</tr>
		
		</table> 
  	</td>
	</tr>
	<tr><td colspan="2" height="30" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td> </tr>
	<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
</table>

 </body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


