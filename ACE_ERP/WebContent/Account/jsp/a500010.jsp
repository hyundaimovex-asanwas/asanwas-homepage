<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ŷ�ó ���� ��� ��û
+ ���α׷� ID	: a500010.jsp
+ �� �� �� ��	: �ŷ�ó ���� ��� ��û
+ �� �� �� ��	: 2016.12.07
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: �� �� ��
-----------------------------------------------------------------------------
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: 2017.01.09
+ �� �� �� ��	: ����÷�α�� �߰� 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a500010_s1, a500010_t1, a500010_t2
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

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    gcra_usegb_0.codevalue ="1";
    gclx_status_0.index=0;
    
    txt_empno_0.value =gusrid;
	txt_empnmk_0.value = gusrnm;
	
	chkbox_v_acctno_chk.checked=false;
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.";
	
	ln_File_Clear();
	
	//document.all.LowerFrame.style.visibility="visible";
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500010_s1?v_str1="+gcem_vendnm_0.text
																	    +"&v_str2="+gcra_usegb_0.codevalue	
																		+"&v_str3="+gcem_vend_id_0.text 
																		+"&v_str4="+gclx_status_0.bindcolval 
	                                                                    +"&v_str5="+txt_bankcd_0.value 
	                                                                    +"&v_str6="+txt_banknm_0.value 
	                                                                    +"&v_str7="+txt_acctno_0.value
																		+"&v_str8="+txt_empno_0.value;
	
	gcds_data.Reset();
}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	
	ln_SetDataHeader();
	gcds_data.addrow();	
	gcds_data.namevalue(gcds_data.rowposition,"CHK") = "T";
	
	//���� ÷�� ����
	if(gcds_data.namevalue(gcds_data.rowposition,"ATT_FILE_NAME")!=""){
		gcds_data.namevalue(gcds_data.rowposition,"ATT_GB")="Y";
	}else{
		gcds_data.namevalue(gcds_data.rowposition,"ATT_GB")="N";
	}
	
	gcds_data.namevalue(gcds_data.rowposition,"STATUS") = "N";
	
	ln_File_Clear();
}

function ln_File_Clear(){
	//÷������
	txt_real_file.value="";
	
    //����÷�� �ʱ�ȭ 
    fileForm.filename.outerHTML = fileForm.filename.outerHTML;
	fileForm.fileList.options[0].text="";
}


/******************************************************************************
	Description : ���ο�û
******************************************************************************/
function ln_AppReq(){
		
	if(!ln_Chk_Status()) return false;
	
	/*
	if(gcds_data.namevalue(gcds_data.rowposition,"STATUS") != "N" && gcds_data.namevalue(gcds_data.rowposition,"STATUS") != "B"){
		alert("���°��� [���] �� [�ݼ�] �Ǹ� ���ο�û �����մϴ�.");
		return false;
	}else{
		gcds_data.namevalue(gcds_data.rowposition,"STATUS") = "R";
	}
	*/
	
	if (confirm("�ش� �ŷ�ó ��� ���� ��û �Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500010_t2";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
	}else{
		gcds_data.UndoAll();
		
	}	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	
	else if (gcds_data.IsUpdated) {
		if(!ln_Chk_Save_Status())return;
		
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500010_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		
		//ln_Query();
		
		}	
	}
}



/******************************************************************************
Description : �Է°� üũ
******************************************************************************/
/*
function ln_Chk_Status(){
	
	var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			vcnt+=1;
		}
	}
	
	if(vcnt==0){
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	
	return true;
}

*/

/******************************************************************************
Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Status(){
	var vcnt=0;
	
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.SysStatus(i)=="1"){
				alert("���� �� ���ο�û �Ͻʽÿ�.");
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
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ��û ���ɰ��� �ƴմϴ�.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
		}
	}
	
	return true;
}



/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
		
	for(i=1;i<=gcds_data.countrow;i++){
			
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){

			if(gcds_data.namevalue(i,"VEND_CD") == ""){ //�ŷ�ó	
				alert("�ŷ�ó�� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
				alert("����ڵ�Ϲ�ȣ�� �Է��ϼ���.");
				return false;
			}

			if(gcds_data.namevalue(i,"BANK_CD") == ""){
				alert("���� �ڵ带 �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BANK_NM") == ""){
				alert("������� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"ACCT_NO") == ""){
				alert("���¹�ȣ�� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"ACCT_AUTH") == ""){
				alert("�����ָ� �Է��ϼ���.");
				return false;
			}
		}

	} 
	
	return true;
	
}


function ln_Chk_Save_Status(){
	for(var i =1; i<=gcds_data.countrow;i++){
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
Description : ���°� üũ ����
******************************************************************************/
function ln_Chk_Delete_Status(){
	var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")=="R"||gcds_data.namevalue(i,"STATUS")=="Y"){
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




/******************************************************************************************
Descrition : �α��ν� �ش����� ���� ������.
parameter  : ����ڵ�
retun      : true - ���� , false - �Ұ���
             gcds_name - dataset ��
******************************************************************************************/
function gf_empno_Enable(s, gcds_name){
	
	gcds_name.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s5?v_str1=2169"
													  					+"&v_str2="+s;
																						
	gcds_name.Reset();			
	
	if(gcds_name.countrow>0){	
		return true;
	}else { 
		return false;
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
		

	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
		
	if(!ln_Chk_Delete_Status()) return false;	
		
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.KeyValue = "Account.A500010_t1(I:USER=gcds_data)";
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500010_t1";
		gctr_pyo.post();
		ln_Query();
	}else{ 
		gcds_data.undo(gcds_data.rowposition);
		
	}
	
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
Description : �ŷ�ó �˾�
******************************************************************************/
function ln_Find_Vend(e){
	
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	//�˻�����  
	if(e=="1"){
		
		strURL = "./gczm_vender_popup.jsp";
		
		strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:yes";
		
		arrResult = showModalDialog(strURL,'',strPos);	
		
		if (arrResult != null) {
			
			arrParam = arrResult.split(";");
			gcem_vendcd_0.text = arrParam[0];
			gcem_vendnm_0.text = arrParam[1];
			//gcem_vend_id_0.text = arrParam[5];
			
			ln_usegb_format(arrParam[5],"0");
		
		} else {
		
			gcem_vendcd_0.text = "";
			gcem_vendnm_0.text = "";
			gcem_vend_id_0.text ="";
		
		}
	//�Է�	
	}else if(e=="2"){
		
		if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
		    alert("�ű� ��Ͻÿ��� ã�� ��ư ����� �����մϴ�.");
			return;
		}		
		
		strURL = "./gczm_vender_popup.jsp";
		
		strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:yes";
		
		arrResult = showModalDialog(strURL,'',strPos);			
		
		if (arrResult != null) {
			
			arrParam = arrResult.split(";");

			//ln_usegb_format(arrParam[1]);
			txt_vend_cd.value = arrParam[0];
			txt_vend_nm.value = arrParam[1];
			//gcem_vend_id.text = arrParam[5];	
			ln_usegb_format(arrParam[5],"1");
		} else {
			txt_vend_cd.value = "";
			txt_vend_nm.value = "";
			gcem_vend_id.text="";
		}		

	}

}


/******************************************************************************
	Description : �����˾�
******************************************************************************/
function ln_Find_Bank(strgb){
		
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	strURL = "./a500000_popup3.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (strgb=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_bankcd_0.value = arrParam[0];
			txt_banknm_0.value = arrParam[1];		
		} else {
			txt_bankcd_0.value = "";
			txt_banknm_0.value = "";
		} 
		
	}else if(strgb=="1"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_bankcd.value = arrParam[0];
			txt_banknm.value = arrParam[1];		
		} else {
			txt_bankcd.value = "";
			txt_banknm.value = "";
		} 
	}

 	
}



/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){

}


/******************************************************************************
	Description : Dataset Head ���� -  
******************************************************************************/
function ln_SetDataHeader(){
		
	if(gcds_data.countrow<1){
		
		var THeader = "CHK:STRING(1),VEND_CD:STRING(13),VEND_NM:STRING(100),VEND_ID:STRING(15),SEQ:DECIMAL(2),"
			        + "BANK_CD:STRING(5),BANK_NM:STRING(100),ACCT_NO:STRING(40),ACCT_AUTH:STRING(100),"
			        + "REASON:STRING(100),GUBUN:STRING(1),STATUS:STRING(1),"
			        + "ATT_GB:STRING(1),ATT_FILE_NAME:STRING(200),V_ACCTNO_CHK:STRING(1)";
		
		gcds_data.SetDataHeader(THeader);	//Header Set
	}
	
}



<%//file upload %>
function fnFileUpload(){
	
	//fileForm.filename.value = txt_file_dir.value ;
	fileForm.target="tempUpload";	//���ε� ���� Ÿ���� iFrame !
	fileForm.action="a500010_fileUpload.jsp";
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


function fnFileDelete(){
	f = document.fileForm;
	  
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('������ ������ ������ �ֽʽÿ�');
		f.fileList.focus();
		return;
	}	

	if(confirm('������ ���� �Ͻðڽ��ϱ�?')){
		var i = f.fileList.options.selectedIndex;
		
		alert("i"+i);
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
		document.file_del.action = "./a500010_deleteFile.jsp";	//����� ����
		document.file_del.submit();
	}
	
}


//������ �������� ���� �� ����Ʈ���� ����
function delResult(){
	f = document.fileForm;

	idx = f.fileList.selectedIndex;
	cnt = f.fileList.options.length;
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	f.fileList.options[cnt - 1] = null;
	f.file1.value = "÷���������ִ� 2M���������մϴ�.";
}





function fnFileDown(){
	
	var real_fileList="";
	//var sys_fileList="";
	var fileHtml="";		
			
	var real_fileList =txt_real_file.value;
	//var sys_fileList =txt_sys_file.value;
	
	var real_file10= new Array();
	//var sys_file10= new Array();
	
	real_file10 = real_fileList.split(":");	//�迭�� ����
	//sys_file10 = sys_fileList.split(":");	//�迭�� ����
	
	var real_file1=real_file10.slice(0,1);
	//var sys_file1=sys_file10.slice(0,1);	


	if(real_file1==""){
		alert("÷�������� �������� �ʽ��ϴ�")
		return;
	}else if(real_file1.length==1){
		location.href ="./a500010_fileDownload.jsp?dir=&filename="+real_file1+"&sysfilename="+real_file1; //�
	}
	
}


function fnFileNameDisplay(row){
	f = document.fileForm;
	txt_real_file.value= gcds_data.namevalue(row,"ATT_FILE_NAME");
	f.fileList.options[0].value=gcds_data.namevalue(row,"ATT_FILE_NAME");
}


/******************************************************************************
Description : data clear
******************************************************************************/
function ln_usegb_format(strVendid,strGB){

	intChk = strVendid.length;
	
	if(strGB=="0"){
		
		if(intChk==10){ //
			gcem_vend_id_0.Format= "000-00-00000";    //���� 
			gcra_usegb_0.codevalue="1";
		}else if(intChk==13){
			gcem_vend_id_0.Format= "000000-0000000";  //����
			gcra_usegb_0.codevalue="2";
		}
		
		gcem_vend_id_0.text = strVendid;
		
	}else{
		
		if(intChk==10){ //
			gcem_vend_id.Format= "000-00-00000";    //���� 
		}else if(intChk==13){
			gcem_vend_id.Format= "000000-0000000";  //���� 
		}
		
		gcem_vend_id.text = strVendid;
		
	}
}



<%
/******************************************************************************
	Description : üũ�ڽ�����
******************************************************************************/
%>
function ln_Check_Vacctno(){
	
	if(chkbox_v_acctno_chk.checked == true){
		gcds_data.namevalue(gcds_data.rowposition,"V_ACCTNO_CHK") = "T";
	}else{
		gcds_data.namevalue(gcds_data.rowposition,"V_ACCTNO_CHK") = "F";
	}
}


function ln_Check_Vacctno2(strRow){
	
	if(gcds_data.namevalue(strRow,"V_ACCTNO_CHK")=="T"){
		chkbox_v_acctno_chk.checked = true;
	}else{
		chkbox_v_acctno_chk.checked = false;
	}
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �α��� ��� üũ  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A500010_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	chkbox_v_acctno_chk.checked=false;
	if (rowcount ==0 ){		
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}else{
		fnFileNameDisplay(1);
		ln_Check_Vacctno2(1);
	}	

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	
</script>


<script language=JavaScript event="OnLoadError()" for=gcds_data>

	alert("������ �߻� �߽��ϴ�.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=gcgd_data event=OnClick(row,Colid)>
   
   //alert("OnClick");
   
    if(row>0){
		fnFileNameDisplay(row);
	}
    
	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }

	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
	
	//alert("V_ACCTNO_CHK::"+gcds_data.namevalue(row,"V_ACCTNO_CHK"));
	
	ln_Check_Vacctno2(row);
	
</script>


<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //���� 
	}
	
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");

</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.")
	//ln_Query();
</script>

<script language="javascript" for="gctr_pyo" event="onfail()">

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
    fileList.focus();
    
    setTimeout(fnFileDelete(),100000);

	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
	
</script>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="1000" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:15px;">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"		style="cursor:hand" onclick="ln_AppReq()">&nbsp;&nbsp;    
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"		style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"    	style="cursor:hand" onclick="ln_Delete()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
	 <td>
		<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			
			<td class="tab15" width="80px;" bgcolor="#eeeeee" align="center" >�ŷ�ó��</td>
			<td class="tab18" width="300px"  align="left">
			<comment id="__NSID__">
				<object  id=gcem_vendnm_0 	classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:5px;top:2px;cursor:hand;" onclick="ln_Find_Vend(1)">
			<comment id="__NSID__">			
			<object  id=gcem_vendcd_0		classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:10px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit			value="true">
				<param name=PromptChar			value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>

			<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
			<td class="tab18" width="160px"  ><comment id="__NSID__">
				<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
					<param name=Cols		value="2">
					<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
		
			<td class="tab18" width="60px;" bgcolor="#eeeeee" align="center">��ȣ</td>
			<td class="tab18"   Style="height:20px;" colspan=3><nobr>&nbsp;
			    <comment id="__NSID__">
				<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
					<param name=Text		   value="">
					<param name=Alignment      value=0>
					<param name=Border         value=true>
					<param name=Numeric        value=false>
					<param name=Format         value="000-00-00000">
					<param name=PromptChar     value="">
					<param name=BackColor      value="#CCCCCC">
					<param name=InheritColor   value=false>
					<param name=readOnly       value=false>
			     </object>
			     </comment><script>__ws__(__NSID__);</script>
			</td>
		</tr> 
		<tr> 
			<td class="tab17" width="80px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab20"  align="left" >
			<input id="txt_bankcd_0"   type="text"   class="txtbox"  style= "position:relative;left:2px;width:50px;height:20px;">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:2px;top:0px;cursor:hand;" onclick="ln_Find_Bank('0')">						
				<input id="txt_banknm_0"   type="text"   class="txtbox"  style= "position:relative;left:2px;width:150px;height:20px;">		
			</td>
			
			<td class="tab20" width="80px;" bgcolor="#eeeeee" align="center">���¹�ȣ</td>
			<td class="tab20"  align="left" >
				<input id="txt_acctno_0"   type="text"   class="txtbox"  style= "position:relative;left:2px;width:150px;height:20px;">	
			</td>
			
			<td class="tab20" width="80px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab20"   align="left" >	
				<comment id="__NSID__">
				<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
					<param name=CBData			        value="^��ü,N^���,R^���ο�û,Y^����,B^�ݼ�">
					<param name=CBDataColumns	 		value="CODE,NAME">
					<param name=SearchColumn	     	value=NAME>
					<param name=Sort			        value=false>
					<param name=ListExprFormat       	value="NAME">								
					<param name=BindColumn		     	value="CODE">
				</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
			
			<td class="tab20" width="80px;" bgcolor="#eeeeee" align="center">��û��</td>
			<td class="tab20"   align="left" >	
				<input type="hidden" class="txt11" id="txt_empno_0"  style="position:relative;top:2px;left:-2px;width:60px;background-color:#d7d7d7" readOnly>
			    <input type="text" class="txt11" id="txt_empnmk_0" maxlength=8 style="position:relative;top:0px;left:2px;width:70px;background-color:#d7d7d7" readOnly></nobr> 
			</td>
			
		</tr> 
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:650px;HEIGHT:500px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle" 		VALUE="0">
						 <PARAM NAME="Indwidth"			VALUE="0">
						 <PARAM NAME="Fillarea"			VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="Editable"     	value='true'>						 
						 <param name="sortview"    		value=left>
					     <PARAM NAME="Format"			VALUE="  
					        <FC>ID=CHK 	         Name='����'             Width=30      	HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,			width=80,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=120,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
							<FC>ID=SEQ,	     	 Name=����,			    width=30,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = false</FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,			width=90,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true mask = {decode(Len(VEND_ID),10,'XXX-XX-XXXXX',13,'XXXXXX-XXXXXXX')}</FC>
							<C> ID=BANK_CD,		 Name=�ڵ�,				width=50,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true show = false </C>
							<C> ID=BANK_NM,		 Name=��������,	        width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	  edit=none  sort = true show = true </C>
							<C> ID=ACCT_NO,	 	 Name=���¹�ȣ,	        width=90,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	  edit=none  sort = true show = true </C>
							<C> ID=ACCT_AUTH,	 Name=������,	        	width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = true </C>
							<C> ID=ATT_FILE_NAME,Name=����÷��,			width=50,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none  sort = true show = false </C>
						    <C> ID=REASON,       Name=�뵵,	        	width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = false </C>
						    <C> ID=GUBUN,        Name=����,	        	width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = false EditStyle=Combo, Data='1:���뿹��,2:��ȭ���뿹��'</C>
						    <C> ID=STATUS,       Name=����,	        	width=50,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	  edit=none  sort = true show = true EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�'</C>
						    <c> ID=ATT_GB        Name=÷��,              Width=30        HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center    edit=none    </c>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>
			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:345px;height:500px;border:1 solid #708090;">
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee" align=left class="tab19"><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>�ŷ�ó�ڵ�</nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:80px;position:relative;left:-5px;top:-1px;background-color:#d7d7d7"    ReadOnly >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:-5px;top:0px;cursor:hand;" onclick="ln_Find_Vend(2)">						
					</td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee" align=left class="tab19"><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>�ŷ�ó��</nobr></td>               
				
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:230px;position:relative;left:-5px;top:0px;background-color:#d7d7d7"  ReadOnly>
					</td>
				</tr>
				<tr>
					<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>����ڹ�ȣ</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:150px;height:20px;position:relative;left:0px;top:2px">		
						<param name=Text					value="">
						<param name=Alignment     			value=0>
						<param name=Border        			value=true>
						<param name=Numeric       			value=false>
						<param name=Format        			value="###-##-#####">
						<param name=PromptChar    			value="">
						<param name=ReadOnlyBackColor   	value="#d7d7d7">
						<param name=InheritColor  			value=false>
						<param name=readOnly      			value=true>
					   </object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>����</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bankcd"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:30px;height:20px;background-color:#d7d7d7" readOnly>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:1px;top:0px;cursor:hand;" onclick="ln_Find_Bank('1')">						
						<input id="txt_banknm"   type="text"   class="txtbox"  style= "position:relative;left:0px;width:153px;height:20px;background-color:#d7d7d7" readOnly>						
					</nobr></td>
				</tr>
					<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>���¹�ȣ</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
						<input id="txt_acctno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;">
						</nobr></td>
					</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_acctauth"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;">
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;�뵵</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;">
						</nobr> </td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;����</nobr></td>
						<td class="tab13" style="text-align:left">
						<nobr><comment id="__NSID__">
						 		<object id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:3px;font-size:12px;width:100px;">
											<param name=CBData			        value="1^���뿹��,2^��ȭ���뿹��">
											<param name=CBDataColumns	 		value="CODE,NAME">
											<param name=SearchColumn	     	value=NAME>
											<param name=Sort			        value=false>
											<param name=ListExprFormat       	value="NAME">								
											<param name=BindColumn		     	value="CODE">
											<param name=Enable                  value="true">
								</object></comment><script>__ws__(__NSID__);</script> 
						</nobr> &nbsp;
						
						<input type=checkbox  id=chkbox_v_acctno_chk  style="width:15px;position:relative;left:0px;top:-3px"   onclick="ln_Check_Vacctno()">&nbsp;������� üũ
						</td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;÷������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						
							<input type="text" name='txt_real_file' id="txt_real_file" style="position:relative;left:5px;top:0px;width:150px;" class='input01'   readOnly="readonly">
	                       <!--<img src="<%=dirPath%>/Omsm/images/download.gif"           style="position:relative;left:0px;top:0px;cursor:hand"  onClick="fnFileDown()" >-->
						
						</nobr> </td>
				</tr>
				
				<form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  > 
			    <tr> 	
					<td align=left  height="1px" bgcolor="#eeeeee"   class="tab19"   rowspan=2 >&nbsp;&nbsp;����÷��</td>
					<td align=left  bgcolor="#ffffff" height="25px"  class="tab13"  >&nbsp;
						<input type="file"  name="filename"  style="position:relative;left:-6px;top:0px;width:230px;height:20px" >  
					</td>
				</tr>
				<tr>
					<td class="tab13" >
					    <select multiple name="fileList" id="fileList" style="position:relative;left:0px;top:0px; width:230px;height:25px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
						 <option></option>
					    </select>
						<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:0px;cursor:hand"  onclick="fnFileUpload()">
						<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:0px;cursor:hand"  onclick="fnFileDelete()">                              
					</td>
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
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;����</nobr></td>
						<td class="tab13" style="text-align:left">
						<nobr><comment id="__NSID__">
						 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			        value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
											<param name=CBDataColumns	 		value="CODE,NAME">
											<param name=SearchColumn	     	value=NAME>
											<param name=Sort			        value=false>
											<param name=ListExprFormat       	value="NAME">								
											<param name=BindColumn		     	value="CODE">
											<param name=Enable                  value="false">
								</object></comment><script>__ws__(__NSID__);</script> 
						</nobr> 
						</td>
				</tr>				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>	
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>								
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_upid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>	
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;�����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_updt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>	
				<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;�ݼۻ���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_reject_reason"    type="text"    style= "position:relative;left:5px;width:230px;height:20px;"   class='input01'   readOnly="readonly">
						</nobr> </td> 
				</tr>
				
				<tr>
						<td height="25px" align=center colspan=2 > <font color="#ff0000">*</font> ǥ�ð��� �ʼ� �׸��Դϴ�.</td>
				</tr>
			  </table>
		 </td>
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td>
		<br>
   </tr>
   
   <tr>
		<td colspan="2" height="24" align="left">
			<font color="#ff0000">÷���� ���ϸ��� [�ŷ�ó��_���¹�ȣ]�� ������ֽñ� �ٶ��ϴ�.</font>	
		</td>
		
   </tr>	
  
  
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		<C>Col=VEND_CD,	    Ctrl=txt_vend_cd    Param=value			</C>
		<C>Col=VEND_NM,	    Ctrl=txt_vend_nm	Param=value			</C>
		<C>Col=VEND_ID,	    Ctrl=gcem_vend_id	Param=text			</C>
		<C>Col=BANK_CD,	    Ctrl=txt_bankcd		Param=value			</C>
		<C>Col=BANK_NM,	    Ctrl=txt_banknm		Param=value			</C>
		<C>Col=ACCT_NO,		Ctrl=txt_acctno		Param=value			</C>
		<C>Col=ACCT_AUTH,	Ctrl=txt_acctauth	Param=value			</C>
		<C>Col=REASON,		Ctrl=txt_reason		Param=value			</C>		
		<C>Col=GUBUN,		Ctrl=gclx_gubun		Param=bindcolval	</C>		
		<C>Col=STATUS,   	Ctrl=gclx_status 	Param=bindcolval	</C>
		<C>Col=I_EMPNO,   	Ctrl=txt_wrid 		Param=value			</C>
		<C>Col=I_DATE,   	Ctrl=txt_wrdt 		Param=value			</C>	
		<C>Col=U_EMPNO,   	Ctrl=txt_upid 		Param=value			</C>
		<C>Col=U_DATE,   	Ctrl=txt_updt 		Param=value			</C>
		<C>Col=ATT_FILE_NAME, Ctrl=fileList 	Param=value			</C>
		<C>Col=REJECT_REASON, Ctrl=txt_reject_reason 	Param=value			</C>	
		
						
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



