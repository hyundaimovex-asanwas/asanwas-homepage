<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ��ü��Ͽ�û (�����) 
+ ���α׷� ID	: a010050.jsp
+ �� �� �� ��	: ��ü��Ͽ�û 
+ �� �� �� ��	: 
+ �� �� �� ��	: 
------------------------------------------------------------------------------
+ �� �� �� ��  : �����ȣ ����
+ ��   ��  ��  :  �� �� ��
+ �� �� �� ��  : 2016.03.09
------------------------------------------------------------------------------
+ �� �� �� ��  : ����÷�� ��� �߰� 
+ ��    ��  �� : �� �� ��
+ �� �� �� ��  : 2017.06.07
------------------------------------------------------------------------------
+ �� �� �� ��  : ��� ��ư Ŭ�����ϸ� �Է¾ȵǰԲ� ����
+ ��    ��  �� : �� �� ��
+ �� �� �� ��  : 2019.05.31
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010050_s1, a010050_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_position =0;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    
    gclx_status_0.bindcolval ="N"    
    gcra_usegb_0.codevalue="1";
    gclx_cocomyn.bindcolval="";
    gclx_status.bindcolval ="N";
    
    txt_empno.value =gusrid;
	txt_empnmk.value = gusrnm;
	
    document.getElementById("txt_vend_nm").disabled = true;
    document.getElementById("txt_vend_nm").className = "input_ReadOnly";
	
    document.getElementById("txt_vd_direct").disabled = true;
    document.getElementById("txt_vd_direct").className = "input_ReadOnly";
    
    document.getElementById("txt_bsns_cnd").disabled = true;
    document.getElementById("txt_bsns_cnd").className = "input_ReadOnly";    
    
    document.getElementById("txt_bsns_knd").disabled = true;
    document.getElementById("txt_bsns_knd").className = "input_ReadOnly";  
    
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
		
	//alert("gs_userid::"+gs_userid+"::gusrid::"+gusrid);
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	
	document.all.LowerFrame.style.visibility="visible";
	
	//÷������ �ʱ�ȭ 
	document.fileForm.reset();

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="+gcem_vend_id_0.text    
                                                                        +"&v_str5="+ txt_empno.value   	
                                                                        +"&v_str6="+gcra_usegb_0.codevalue;     	
	                                                                                                                                                                                                                                                       
   // prompt('',gcds_data.DataID);
	gcds_data.Reset();
	
}


/******************************************************************************
	Description : ��ȸ2
******************************************************************************/
function ln_Query2(){
	
	//alert("gs_userid::"+gs_userid+"::gusrid::"+gusrid);

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
	                                                                    +"&v_str2="+gcem_vend_nm_0.text
	                                                                    +"&v_str3="+gclx_status_0.bindcolval
	                                                                    +"&v_str4="+gcds_data.namevalue(gcds_data.rowposition,"VEND_ID")   
	                                                                    +"&v_str5="+ txt_empno.value;     	
	                                                                                                                                                                                                                                                       
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();

}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
		
		
    document.getElementById("txt_vend_nm").disabled = false;
    document.getElementById("txt_vend_nm").className = "";
	
    document.getElementById("txt_vd_direct").disabled = false;
    document.getElementById("txt_vd_direct").className = "";
    
    document.getElementById("txt_bsns_cnd").disabled = false;
    document.getElementById("txt_bsns_cnd").className = "";    
    
    document.getElementById("txt_bsns_knd").disabled = false;
    document.getElementById("txt_bsns_knd").className = "";  		
		
	ln_SetDataHeader();
	
	gcds_data.addrow();	
	
	gcds_data.namevalue(gcds_data.rowposition,"CHK")="T";
	//gcra_use_tag.CodeValue="Y";	
    //gclx_cocomyn.index=1;
    
    gclx_cocomyn.bindcolval="";
    gclx_status.bindcolval ="N";
    
    gcds_data.namevalue(gcds_data.rowposition,"USE_TAG")="Y";
    
    ln_Find2();
    
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
		
	if(gs_userid==""||gs_userid==undefined){
		alert("����� id�� �������� �ʽ��ϴ�. �ٽ� �α��� �Ͻñ� �ٶ��ϴ�.");
		return false;
	}	
		
		
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		
	    if(!ln_Chk_Save_Status())return;
	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
		//prompt(this, gcds_data.text);
		
		gctr_pyo.post();
		
		ln_Query2();
		
		//alert(gcds_data.namevalue(1,"CHK"));
		gcds_data.namevalue(gcds_data.rowposition,"CHK")="T";
		
		ln_AppReq();
		
		}	
		
	}
	
}


/******************************************************************************
	Description : ���� 
******************************************************************************/
function ln_Delete(){

    //���°� üũ 
    if(!ln_Chk_Delete_Status()) return false;
    
	if (confirm(" �ش� �����͸� ���� �Ͻðڽ��ϱ�?")){	
		
		gcds_data.DeleteMarked();
		
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
		gctr_pyo.post();
		
		ln_Query();
		
	}	
	
}

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {

  //���°��� ��� �ϰ�츸 ���� 
   for(i=1;i<=gcds_data.countrow;i++){
   		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
   		
   			if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
				alert("��Ϲ�ȣ�� �Է��ϼ���.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VEND_NM")) == ""){//�ŷ�ó��
				alert("�ŷ�ó����  �Է��ϼ���.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VD_DIRECT")) == ""){//��ǥ�ڸ�
				alert("��ǥ�ڸ���  �Է��ϼ���.");
				return false;
			}
				
			if(fn_trim(gcds_data.namevalue(i,"BSNS_CND")) == "" ){ //����				
				alert("���¸� �Է��ϼ��� .");
				return false;
			}		
			
			if(fn_trim(gcds_data.namevalue(i,"BSNS_KND")) == "" ){ //����				
				alert("������  �Է��ϼ��� .");
				return false;
			}		
			
			if(gcds_data.namevalue(i,"COCOMYN") == "" ){ //��ü����				
				alert("��ü������  �Է��ϼ��� .");
				return false;
			}	
			
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO1"))==""){ //�����ȣ				
				alert("�����ȣ��  �Է��ϼ���1.");
				return false;
			}	
			
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO2"))==""){ //�����ȣ				
				alert("�����ȣ��  �Է��ϼ���2.");
				return false;
			}	

			
			if(fn_trim(gcds_data.namevalue(i,"ADDRESS1")) == "" ){ //�ּ�				
				alert("�ּҸ�  �Է��ϼ��� .");
				return false;
			}	
			
			if(fn_trim(gcds_data.namevalue(i,"ADDRESS2")) == "" ){ //��Ÿ�ּ�				
				alert("��Ÿ�ּҸ�  �Է��ϼ��� .");
				return false;
			}	
			
		}
   		
   }
 
	return true;
	
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
		
	gcds_data.undo(gcds_data.rowposition);
	
}

/******************************************************************************
	Description : ���ο�û
******************************************************************************/
function ln_AppReq(){
		
    //���°� üũ : ��� �ݼ� ���¸� ��û ������ 
    
    if(!ln_Chk_Status("���ο�û")) return false;
   
	if (confirm(" �ش� �ŷ�ó ��� ���� ��û �Ͻðڽ��ϱ�?")){	
		
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t2";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
	//	prompt('',gcds_data.text);
		gctr_pyo.post();
		
		ln_Query();
		
	}else{
		
		gcds_data.UndoAll();
		
	}	
	
}


/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Save_Status(){
		
	for(var i =1; i<=gcds_data.countrow;i++){
		
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data.SysStatus(i)==3){
			
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ���� ���ɰ��� �ƴմϴ�.");
				
				return false;
				
			}
		}
	}

	return true;
}

/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Status(strReq){
		
    var vcnt=0;
    
    for(var i =1; i<=gcds_data.countrow;i++){
    	
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.SysStatus(i)=="1"){
				
				alert("���� �� "+strReq+" �Ͻʽÿ�.");
				
				return false;
				
			}
			
			vcnt+=1;	
		}
		
	}
    
  
    if (vcnt==0){
    	
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		
		return false;
		
	}
	
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� "+strReq+" ���� �ƴմϴ�.");
				
				return false;
				
			}else{
				
				gcds_data.namevalue(i,"STATUS")="R"; 
				
			}
			
		}
		
	}
	
	return true;
	
}

/******************************************************************************
	Description : ���°� üũ ����
******************************************************************************/
function ln_Chk_Delete_Status(){
		
    var vcnt=0;
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")=="Y"){
				
				alert(gcds_data.namevalue(i,"VEND_NM") + "��  ���� ���ɰ��� �ƴմϴ�.");
				
				return false;
				
			}
			
			gcds_data.MarkRows(i,i);
			
			vcnt+=1;
		}
		
	}
	
	if (vcnt==0){
		
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		
		return false;
		
	}
	
	return true;
	
}


/******************************************************************************
Description : ����
******************************************************************************/
function ln_Apply(){

	if(!ln_Chk_Apply_Status()){
		
		return;
		
	}else if (gcds_data.IsUpdated) {
		
		if (confirm("��ü ����� ���� �Ͻðڽ��ϱ�?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
		
		//prompt('',gcds_data.text);
		
		gctr_pyo.post();
		
		ln_Query();
		
		}	
	}
}


function ln_Chk_Apply_Status(){
	
    var vcnt=0;
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="R"){
				
				alert("���� ��� ���� �ƴմϴ�.");
				
				return false;
				
			}else{
				
				gcds_data.namevalue(i,"STATUS")="Y"; 
				
			}
			
			vcnt+=1;
		}
		
	}
	
	if(vcnt==0){
		
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		
		return false;
		
	}
	
	 //ȭ��󿡼� ���ϰ� üũ 
  	 for(var k =1; k<=gcds_data.countrow;k++){
  		 
  	 	for(var j=k+1;j<=gcds_data.countrow;j++){
  	 		
  	 	    //alert("k::"+k+"::j::"+j+"::"+gcds_data.namevalue(k,"VEND_ID")+":::"+gcds_data.namevalue(j,"VEND_ID"));
   	 		if(gcds_data.namevalue(k,"CHK")=="T"&& gcds_data.namevalue(j,"CHK")=="T" && gcds_data.namevalue(k,"VEND_ID")==gcds_data.namevalue(j,"VEND_ID")){
   	 			
   	 		    alert(gcds_data.namevalue(k,"VEND_ID")+"  ������ ����� ��ȣ�� ���� �մϴ� .");
   	 		    
   	 			return false;
   	 			
   	 		}
   	 		
   	    }
  	 	
  	 }
  	 
  	 
  	 //DB �󼼼� ���ϰ� üũ 
  	 for(var p =1; p<=gcds_data.countrow;p++){
  		 
		if(gcds_data.namevalue(p,"CHK")=="T"){
			
			gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s6?v_str1="+gcds_data.namevalue(p,"VEND_ID"); 
			gcds_temp01.Reset();
			
			if(gcds_temp01.namevalue(1,"CNT")>0){
				
				alert(gcds_data.namevalue(p,"VEND_ID")+" �ߺ��� ��ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
				
				return false;
				
			}
			
		}
		
	}
	
	return true;
	
}



/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : ���ڿ�üũ
******************************************************************************/


/******************************************************************************
	Description : �ߺ�üũ �˾�
******************************************************************************/
function ln_Find2(){
		
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
	    alert("�ű� ��Ͻÿ��� �ߺ� üũ �����մϴ�.");
		return false;
	}
	
	strURL = "<%=dirPath%>/Account/jsp/a010050_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:120px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
 		
		arrParam = arrResult.split(";");
		ln_usegb_format(arrParam[1]);
		gcem_vend_id.text = arrParam[0];
		gcem_vend_id_0.text = arrParam[0];
		
	} else {
		
		gcem_vend_id.text ="";
		
	}
 	
}



/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_usegb_format(strusegb){
		
	if(strusegb=="1"){ //
		
		gcem_vend_id.Format = "000-00-00000";        //���� 
		
	}else if(strusegb=="2"){
		
		gcem_vend_id.Format = "000000-0000000";  //���� 
		
	}
	
}

/******************************************************************************
	Description : Dataset Head ���� -  
******************************************************************************/
function ln_SetDataHeader(){
		
	if(gcds_data.countrow<1){
		
		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
							+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
							+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
							+ "USE_TAG:STRING,"
							+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
							+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING,"
							+ "EMPNMK:STRING,SB_REASON:STRING,VENDER_USERGB:STRING,"
							+ "REAL_FILE4:STRING,SYS_FILE4:STRING,REAL_FILE3:STRING,SYS_FILE3:STRING,"
							+ "REAL_FILE2:STRING,SYS_FILE2:STRING,REAL_FILE1:STRING,SYS_FILE1:STRING";
		
		gcds_data.SetDataHeader(THeader);					
		
	}
	
}

/***********************************************************************************************
	Description : �����ȣ ã��
	parameter   : p==> 01 - �ŷ�ó, 02 - ����, 03 - ����� 
**********************************************************************************************/
function ln_Popup(e){
		
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "<%=dirPath%>/Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);


	if (arrResult != null) {
		
		arrParam = arrResult.split(";");
		
		var post_no1 = arrParam[0];
		
		txt_post_no1.value= post_no1.substring(0,3);
		txt_post_no2.value= post_no1.substring(3,6);
		txt_address1.value = arrParam[1] + arrParam[2]; 
		txt_address2.value= arrParam[3] + arrParam[4];
		
	}else {
		
		txt_post_no1.value= "";
		txt_post_no2.value= "";
		txt_address1.value=""; 
		txt_address2.value="";
		
	}
}


/***********************************************************************************************
	Description : ���ã��
	parameter   :
**********************************************************************************************/
function ln_Popup_Empno(){
		
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="" ;//

	strURL =  "./empno_popup.jsp";
	strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		
		arrResult = result.split(";");
		txt_empno.value =arrResult[1];
		txt_empnmk.value = arrResult[0];
		
	}else{
		
   		txt_empno.value="";
		txt_empnmk.value="";
		
	}
}


function link_1(url){  // default â
	
  var stat='top=0,left=50,width=1024,height=768,toolbar=1,location=1,status=1,menubar=1,scrollbars=1,directories=0,resizable=1';

  newWin=window.open('','',stat);
  
  newWin.location=url;
  
}

</script>


<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>

<script>
function openDaumPostcode() {
    	
    var width =500;
    var height =600; 	
    	
    new daum.Postcode({
    	
    	 width:width,
         height:height,
    	
    	
        oncomplete: function(data) {
            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ��Դϴ�.
            // ������ �����Ͽ� �پ��� Ȱ����� Ȯ���� ������.
            
        	 var strpostcode="";  //���� �����ȣ ( 6�ڸ� )
             var strzonecode="";  //�ű� �����ȣ ( 5�ڸ� )
             strzonecode = data.zonecode;    
             document.getElementById('txt_post_no1').value = strzonecode.substring(0,3);
             document.getElementById('txt_post_no2').value = strzonecode.substring(3,5);
             
             document.getElementById('txt_address1').value = data.address;
             document.getElementById('txt_address2').focus();
        }
    }).open({
    	    left:(window.screen.width/2)-(width/2),
		    top:(window.screen.height/2)-(height/2)
    	
    		});
 }

</script> 



<script>
<%
//���� ÷��
%>
function fnFileUpload(){
	
	//�ŷ�ó �ڵ尡 �����ؾ߸� ���ε� ����.
    //alert("VEND_CD::"+gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD"));
	 
	if(gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD")==""||gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD")==undefined){
		alert("�ŷ�ó�� ���� �� ���� ���ε� �����մϴ�.");
		return false;
	}
	
	//������ ������ ÷�� �Ǿ��� ���.....���� �� �ٽ� ÷�� �ؾ���.......
	
	//������ ���ϸ��� �����մϴ�.
	
	//���°� ��� �� �ݼ۸� �����մ�.
	//if(!ln_Chk_Status("����÷��")) return false;
	
	f = document.fileForm;
	
	if(f.filename1.value!=""){
		file_position ="1";
	}else if(f.filename2.value!=""){
		file_position ="2";
	}else if(f.filename3.value!=""){
		file_position ="3";
	}else if(f.filename4.value!=""){	
		file_position ="4";
	}
	
	gs_position = file_position; 
	
	//alert("file_position::"+file_position+"::gs_position::"+gs_position);
	
	var realFileName = f.filename1.value;
	
	//var realFileName = eval("f.filename"+seq).value;
	var idx = realFileName.lastIndexOf("\\");
	realFileName = realFileName.substring(idx+1);
	//alert("realFileName:::"+realFileName);
	

	if(f.filename4.value==""){
		alert("����ڵ���� ÷���� ������ �����Ͻʽÿ�1.");	
		return false;
	}
	
	
	//alert(f.filename4.value.substring(f.filename4.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF"));
	//alert(f.filename3.value.substring(f.filename3.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF"));
	
	if(f.filename4.value.substring(f.filename4.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
		alert("����ڵ������ PDF���ϸ� ÷�� �����մϴ�. ");
		return false;
	}
	
	
	if(f.filename3.value!=""){
		if(f.filename3.value.substring(f.filename3.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
			alert("���ε�� PDF���ϸ� ÷�� �����մϴ�. ");
			return false;
		}
	}
	
	
	if(f.filename2.value!=""){
		if(f.filename2.value.substring(f.filename2.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
			alert("�ϳ������� PDF���ϸ� ÷�� �����մϴ�. ");
			return false;
		}
	}
	
	if(f.filename1.value!=""){
		if(f.filename1.value.substring(f.filename1.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
			alert("��Ÿ�� PDF���ϸ� ÷�� �����մϴ�. ");
			return false;
		}
	}
	
	var file_nm
	
	f.target="tempUpload";	//���ε� ���� Ÿ���� iFrame !
	f.realFileName.value=realFileName;
	f.mode.value="insert";
	
	f.action = "./a010050_fileUpload.jsp";
	f.submit();
	
	/*
	//fileForm.filename.value = txt_file_dir.value ;
	fileForm.target="tempUpload";	              //���ε� ���� Ÿ���� iFrame !
	//fileForm.action="./a010050_fileUpload_old.jsp";   //�������� ���� ���ε�
	
	fileForm.realFileName.value=realFileName;
	fileForm.mode.value="insert";
	
	fileForm.action="./a010050_fileUpload.jsp";   //�������� ���� ���ε� 
	fileForm.submit();
	*/
}



<%
//���� �߰� ����Ʈ  --> a010050_fileUpload���� ȣ�� 
//�������ε� �� ���ϸ��� ������ ��. 
%>
function addFileList(realName, virtualName, intTot, strfilename)	{
	//alert("addFileList");
	//alert("strfilename::"+strfilename);
	
	f = document.fileForm;
	//eval("f."+strfilename).reset();
	//document.getElementsByName("filename4").form.reset();
	
	//alert("f.fileList.options.length::"+f.fileList.options.length);
	//alert("intTot::"+intTot);
	
	intTot = intTot - 1;

	if(realName!=""){
		//f.fileList.options[f.fileList.options.length] = new Option(realName,virtualName);
		f.fileList.options[intTot] = new Option(realName,virtualName);
	}
	
	/*
	alert("f.fileList.options[1].value:"+f.fileList.options[1].value);
	alert("f.fileList.options[1].text::"+f.fileList.options[1].text);
	alert("f.fileList.options[2].value:"+f.fileList.options[2].value);
	alert("f.fileList.options[2].text::"+f.fileList.options[2].text);
	*/
	
	//alert("gcds_data.rowposition::"+gcds_data.rowposition);
	
	//���ϸ� �������� ó��...
	if(strfilename=="filename4"){        //����ڵ����
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE4")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE4")=virtualName;
	}else if(strfilename=="filename3"){ //���ε
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE3")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE3")=virtualName;
	}else if(strfilename=="filename2"){ //�ϳ�����
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE2")=virtualName;
	}else if(strfilename=="filename1"){ //��Ÿ 
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE1")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE1")=virtualName;
	}
	
	//alert( "strfilename.substring(8,9)::"+strfilename.substring(8,9));
	if (gs_position==strfilename.substring(8,9)){
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t3";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_data.post();
	}
	//f.file1.value ="÷���������ִ�10M���������մϴ�." ;  //f.file1.title;
}




<%
//��ȸ �� �׸��� Ŭ���ý� ÷�������� �����ϸ� ÷��list�� �־��.
%>
function fnFileList(row){
	var strReal_file="";
	var strSys_file ="";
	var intpo =4;
	for(var i=0;i<=3; i++){
		
		//alert("i::"+i);
		strReal_file = gcds_data.namevalue(row,"REAL_FILE"+intpo);
		strSys_file  = gcds_data.namevalue(row,"SYS_FILE"+intpo);
		//alert("strReal_file::"+strReal_file+"::strSys_file::"+strSys_file);
		document.fileForm.fileList.options[i] = new Option(strReal_file,strSys_file);
		intpo = intpo-1;
	}
}




<%
//���ϻ���
//���ϸ�Ͽ��� ���� 
%>
function fnFileDelete(){
	f = document.fileForm;
  
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('������ ������ ������ �ֽʽÿ�');
		f.fileList.focus();
		return;
	}	

	if(confirm('������ ���� �Ͻðڽ��ϱ�?')){
		var i = f.fileList.options.selectedIndex;
		var select_val  = f.fileList.options[i].value;
		var select_text = f.fileList.options[i].text;
		
		/*
		alert("i::"+i);
		alert("select_val::"+select_val);
		alert("select_text::"+select_text);
		*/
		
		//����ã���ؼ� �����Ǹ� ���־� ��...
		//var realFileName = f.file1.value;
	    //var fileArray = oldFileNames.split(":");

		//alert(select_val);
		//alert(oldFileNames);

		//******** START ������ �ִ� �������� ���� ***********/
		var isNew = "i_del"; // �̰� �ݹ� �ø� ������ ���... insert_file
		/*
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
		*/
		//******** END  ������ �ִ� �������� ���� ***********/
		 
		//alert(isNew);
		document.file_del.target="tempUpload";
		//document.file_del.realFileName.value=realFileName;
		document.file_del.realFileName.value=select_text;
		document.file_del.virtualFileName.value = select_val;
//		document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "./a010050_deleteFile.jsp";	//����� ����
		document.file_del.submit();
		
	}
}




//���Ͼ��ε� 4
// ������ �������� ���� �� ����Ʈ���� ����
function delResult(realName, virtualName){
	
	//alert("delResult:realName:"+realName+"virtualName"+virtualName);
	
	f = document.fileForm;

	idx = f.fileList.selectedIndex;
	cnt = f.fileList.options.length;
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	f.fileList.options[cnt - 1] = null;
	//f.file1.value = "÷���������ִ�5M���������մϴ�.";
	
	//alert("gcds_data.rowposition::"+gcds_data.rowposition+"::del::realName"+realName+":virtualName:"+virtualName);
	
	var intPo=0;
	for(var j=4; j>=1; j--){
		//alert("j::"+j)
		if(gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE"+j)==virtualName){
			gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE"+j)="";
			gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE"+j)="";
			intPo = j;
		}
	}
	
	//������Ʈ �Ŀ� DB���� ������Ʈ �ؾ���.
	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t4";
	gctr_data.Parameters = "v_str1="+intPo;
	//prompt('',gcds_data.text);
	gctr_data.post();
}





/*
function fnAddFileList(realName){
	f = document.fileForm;
	if(realName!=""){
		f.fileList.options[0].value="1";
		f.fileList.options[0].text=realName;
		
		//gcds_data.namevalue(gcds_data.rowposition,"ATT_GB") ="Y";
		//gcds_data.namevalue(gcds_data.rowposition,"ATT_FILE_NAME")= realName;
	}  
}
*/
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- �α��� ��� üũ  -->
<object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 

</comment><script>__ws__(__NSID__);</script> 


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010050_t1(I:USER=gcds_data)">
</object>


<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010050_t3(I:USER=gcds_data)">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_pyo" event="onfail()">

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
	
</script>


<script language=JavaScript event="OnLoadError()" for=gcds_data>

	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
	
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	document.all.LowerFrame.style.visibility="hidden";
	
	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	
	fnFileList(1);

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";    //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //���� 
	}
	
</script>


<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>

    var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }

	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";    //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
	
	if(row>=1){
		fnFileList(row);
	}
	
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";    //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");

</script>

 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010050_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
    
            <!-- <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif" 	    style="cursor:hand" onclick="ln_Apply()" >&nbsp;&nbsp; -->
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"		style="cursor:hand" onclick="ln_AppReq()">&nbsp;&nbsp;
    
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
	</td>
  </tr>
  <tr>
	<td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" rowspan=2 >�˻�����</td>
			<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">�ŷ�ó�ڵ�</td>
			<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td width="200px" class="tab24" align="left" >
				<comment id="__NSID__">
					<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
						<param name=Text			value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=GeneralEdit		value="true">
						<param name=PromptChar		value="_">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab14" >&nbsp;
				<comment id="__NSID__">
					<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-53px;top:2px;font-size:12px;width:100px;">
								<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
								<param name=CBDataColumns	     value="CODE,NAME">
								<param name=SearchColumn	     value=NAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat       value="NAME">								
								<param name=BindColumn		     value="CODE">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		<tr> 
		<td class="tab11" width="90px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
		<td width="160px" class="tab11" ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="90px;" bgcolor="#eeeeee" align="center">��ȣ</td>
		<td width="90px" class="tab11"   Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
						<param name=Text			value="">
						<param name=Alignment       value=0>
						<param name=Border          value=true>
						<param name=Numeric         value=false>
						<param name=Format          value="000-00-00000">
						<param name=PromptChar      value="">
						<param name=BackColor       value="#CCCCCC">
						<param name=InheritColor    value=false>
						<param name=readOnly        value=false>
					   </object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab11" width="90px;" bgcolor="#eeeeee" align="center">�ۼ���</td>
		<td class="tab11" ><nobr> &nbsp;
			<input type="text" class="txt11" id="txt_empno"  style="position:relative;top:2px;left:-2px;width:60px;background-color:#d7d7d7" readOnly>
			<img src="../../Common/img/btn/com_b_find.gif" alt="�ڵ� �� �ڵ���� �˻��մϴ�" style="cursor:hand;position:relative;top:2px;left:-3px" onclick="ln_Popup_Empno()">
		    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="position:relative;top:2px;left:-4px;width:90px;"></nobr> 
		</td> 	 
		</tr> 
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:555px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"      VALUE="0">
						 <PARAM NAME="Indwidth"		    VALUE="0">
						 <PARAM NAME="Fillarea"		    VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="sortview"         value=left>
						 <param name="Editable"     	value='true'>
						 <param name=UsingOneClick      value="1">
					     <PARAM NAME="Format"			VALUE="  
					        <FC>ID=CHK 	         Name='����'             	Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center		EditStyle=CheckBox   </FC>  
							<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,		    width=85,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   	edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=�ŷ�ó��,				width=160,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     	edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   	edit=none, sort=true</FC>
							<C> ID=VD_DIRECT,	 Name=��ǥ��,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=BSNS_CND,	 Name=����,	           		width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=BSNS_KND,	 Name=����,	            	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=COCOMYN,	     Name=��ü����,	        	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true EditStyle=Combo, Data='N:�Ϲݾ�ü,T:���̰�����ü,M:�鼼��ü', show = true </C>
							<C> ID=STATUS		 Name=����,			    	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     	edit=none, sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
						    <C> ID=SB_REASON,    Name=�ݼۻ���,	        	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
						    <C> ID=REAL_FILE4,   Name=����ڵ����,        	width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE3,   Name=���ε,         	width=130,     HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE2,   Name=�ϳ�����,         	width=130,     HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE1,   Name=��Ÿ,             	width=130,     HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:310px;height:400px;border:1 solid #708090;">
				<tr>
					<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��Ϲ�ȣ</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:0px;top:3px;">		
						<param name=Text		   value="">
						<param name=Alignment      value=0>
						<param name=Border         value=true>
						<param name=Numeric        value=false>
						<param name=Format         value="###-##-#####">
						<param name=PromptChar     value="">
						<param name=BackColor      value="#CCCCCC">  
						<param name=InheritColor   value=false>
						<param name=readOnly       value=true>
						<param name=ReadOnlyBackColor   value="#d7d7d7">
						
					   </object></comment><script>__ws__(__NSID__);</script> </nobr>
					   <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="��Ϲ�ȣ�� �˻� Ȯ��" style="position:relative;left:3px;top:3px;cursor:hand;" onclick="ln_Find2()">&nbsp;<font color="#ff0000">�ߺ�üũ</font>					
					</td>
				</tr>
				
				<tr>
				   <td style="width:100px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�ڵ� </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;position:relative;left:-7px;top:0px;background-color:#d7d7d7"    ReadOnly>
					</td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee"  class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�� </nobr></td>               
					<td Style="width:200px;height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;position:relative;left:-7px;top:0px"   >
					</td>
				</tr>
				
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��ǥ�ڸ�</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_direct"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
					</nobr></td>
				</tr>
					<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;����</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_cnd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr></td>
					</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_knd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��ü����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr><comment id="__NSID__">
						 		<object id=gclx_cocomyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			     value="N^�Ϲݾ�ü,T^���̰�����ü,M^�鼼��ü">
											<param name=CBDataColumns	     value="CODE,NAME">
											<param name=SearchColumn	     value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat       value="NAME">								
											<param name=BindColumn		     value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
					    <!-- <a href="Javascript:link_1('https://www.hometax.go.kr/websquare/websquare.wq?w2xPath=/ui/pp/index.xml&tmIdx=0&tm2lIdx=&tm3lIdx=')"><font color="blue"><b>����������ȸ</b></font></a> -->
					    <a href="Javascript:link_1('https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml')"><font color="blue"><b>����������ȸ</b></font></a>
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�����ȣ</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_post_no1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:30px;height:20px;top:2px;background-color:#d7d7d7"" readOnly="true";>&nbsp;~
						<input id="txt_post_no2"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:30px;height:20px;top:2px;background-color:#d7d7d7"" readOnly="true";>
						<!-- <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ȣ�� �˻��մϴ�" style="cursor:hand;position:relative;left:1px;top:0px" align=center onclick="ln_Popup('c')">&nbsp;			 
						</nobr> ��)000-000  --> 
						<input type="button" onclick="openDaumPostcode()"  style="position:relative;top:0px;width:100px" value="�����ȣ ã��">&nbsp;
						</td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left  readOnly="true";><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ּ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_address1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��Ÿ�ּ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_address2"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;��ȭ��ȣ</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_telno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
						</nobr> ��)000-0000-0000 </td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;�ѽ���ȣ</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_faxno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
						</nobr> ��)000-0000-0000 </td>
				</tr>		
				<!--
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;�������</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_use_tag classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
								<param name=Cols	value="2">
								<param name=Format	value="Y^���,N^�̻��">
								<param name=Enable 	value="false">
								<param name=Enable 	value="false">
								
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
				</tr>
				-->
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;" ; >
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;�����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr><comment id="__NSID__">
						 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
											<param name=CBDataColumns	     value="CODE,NAME">
											<param name=SearchColumn	     value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat       value="NAME">								
											<param name=BindColumn		     value="CODE">
											<param name=Enable               value="false">
								</object></comment><script>__ws__(__NSID__);</script> 
						</nobr> </td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;�ݼۻ���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_sb_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
			  </table>
		 </td>
		 </tr>
		</table>
	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
    </tr>
    
    <form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  >
    <input type="hidden" name="realFileName">
	<input type="hidden" name="virtualFileName">
	<input type="hidden" name="mode"> 
	<input type="hidden" name="file_position"> 
    
    
    <tr>
		<td colspan="2" >
	     
    	<table cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;border:1 solid #708090;">
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>����ڵ����</nobr> </td>
			<td class="tab22">
				<input type="file"  name="filename4"   style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!-- <img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('1')"> 
				<!-- <img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()"> -->
			</td>	
	    </tr>
	     
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>���ε</nobr> </td>
			<td class="tab22" >
				<input type="file"  name="filename3"  style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!--<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('2')">-->
				<!--<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">-->
			</td>
	    </tr>
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>�ϳ�����</nobr> </td>
			<td class="tab22" >
				<input type="file"  name="filename2"  style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!--<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('3')">-->
				<!--<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">-->
			</td>
	    </tr>
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>��Ÿ</nobr> </td>
			<td class="tab22" >
				<input type="file"  name="filename1"  style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!--<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('4')">-->
				<!--<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">-->
			</td>
	    </tr>
	    
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>÷������</nobr> </td>
			<td class="tab22" >
				<select multiple name="fileList" id="fileList" style="position:relative;left:4px;top:2px; width:400px;height:70px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
					 <option></option>
				</select>
				<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload()">
			    <img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">
			</td>    
	    </tr>
	    </table>
	    </td>
	  </tr>
    </form>
    
    <!-- ���� ������ ��-->
	<form METHOD=POST NAME="file_del">
	<input type="hidden" name="realFileName">
	<input type="hidden" name="virtualFileName">
	<input type="hidden" name="saveDir">
	<input type="hidden" name="mode">
	</form> 
    
    <!-- ���� �ӽ� ���ε�� iFrame -->
	<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>
			     
</table>


<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		<C>Col=VEND_ID,     Ctrl=gcem_vend_id   Param=text		  </C>
		<C>Col=VEND_CD,     Ctrl=txt_vend_cd    Param=value		  </C>
		<C>Col=VEND_NM,     Ctrl=txt_vend_nm  	Param=value		  </C>
		<C>Col=VD_DIRECT,   Ctrl=txt_vd_direct  Param=value		  </C>
		<C>Col=BSNS_CND,    Ctrl=txt_bsns_cnd   Param=value		  </C>
		<C>Col=BSNS_KND,  	Ctrl=txt_bsns_knd   Param=value		  </C>
		<C>Col=VD_TELNO,  	Ctrl=txt_vd_telno   Param=value		  </C>
		<C>Col=VD_FAXNO,  	Ctrl=txt_vd_faxno   Param=value		  </C>
		<C>Col=POST_NO1,  	Ctrl=txt_post_no1   Param=value		  </C>
		<C>Col=POST_NO2,  	Ctrl=txt_post_no2   Param=value		  </C>
		<C>Col=ADDRESS1,  	Ctrl=txt_address1 	Param=value		  </C>
		<C>Col=ADDRESS2,  	Ctrl=txt_address2   Param=value  	  </C>
		<C>Col=COCOMYN,   	Ctrl=gclx_cocomyn   Param=bindcolval  </C>

		<C>Col=REMARK,    	Ctrl=txt_remark     Param=value		  </C>
		<C>Col=WRID,      	Ctrl=txt_wrid     	Param=value		  </C>
		<C>Col=WRDT,      	Ctrl=txt_wrdt     	Param=value		  </C>
		<C>Col=STATUS,   	Ctrl=gclx_status 	Param=bindcolval  </C>
		<C>Col=SB_REASON,   Ctrl=txt_sb_reason  Param=value       </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



