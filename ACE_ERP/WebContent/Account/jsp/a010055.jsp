<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ��ü������û (�����) 
+ ���α׷� ID	: a010055.jsp
+ �� �� �� ��	: ��ü������û 
+ �� �� �� ��	: 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ �� �� �� ��  : �����ȣ����
+ ��   ��  ��  :  �� �� �� 
+ �� �� �� ��  : 2016.03.09
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010055_s1, a010055_t1
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
    gcra_usegb_0.codevalue="1";
    gcra_usegb_2.codevalue="1";
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
    //����ڵ�Ϲ�ȣ �Ǵ� �ŷ�ó�� �ʼ��׸� �Է��ؾ� ��. 	
    if(gcem_vend_cd_0.text =="" && gcem_vend_nm_0.text=="" && gcem_vend_id_0.text=="" ){
    	alert("�ŷ�ó�ڵ� �Ǵ� �ŷ�ó�� �Ǵ� �����(�ֹ�)��ȣ �� �Ѱ��� �ʼ� �׸��Դϴ�.");
    	return false;
    }
    
 
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s0?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gcem_vend_id_0.text             	
                                                                        +"&v_str4="+gcra_usegb_0.codevalue;     	
	                                                                                                                                                                                                                                                       
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
	
	gcds_data_md.ClearAll();
}

/******************************************************************************
Description : ����������ȸ
******************************************************************************/
function ln_MD_Query(){
	if(gcem_vend_id_2.text==""){
		alert("�����(�ֹ�)��Ϲ�ȣ�� �ʼ� �˻������Դϴ�.");
		return false;
	}
	
	gcds_data_md.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s1?v_str1="+gs_userid
			                                                            +"&v_str2="+gcem_vend_nm_2.text
                                                                        +"&v_str3="+gcem_vend_id_2.text             	
                                                                        +"&v_str4="+gcra_usegb_2.codevalue    
	                                                                    +"&v_str5=";
	gcds_data_md.Reset();
}


/******************************************************************************
Description : ��������üũ ��ȸ
******************************************************************************/
function ln_MD_Chk_Query(){
	
	
	gcds_data_md_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s1?v_str1="+gs_userid
																			    +"&v_str2="+gcem_vend_nm_2.text
																			    +"&v_str3="+gcem_vend_id_2.text             	
																			    +"&v_str4="+gcra_usegb_2.codevalue    
																			    +"&v_str5=C";
	gcds_data_md_chk.Reset();
	
	if(gcds_data_md_chk.countrow>0){
		return false;
	}else{
		return true;
	}
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
		
	//��Ͻ����� ���ο�û �Ǵ� ��� ���� ������ ��� �ȵǰ� ����. 	
	if (!ln_MD_Chk_Query()){
		alert("���� ���������� �����մϴ�. Ȯ�� �ٶ��ϴ�.");
		return false;
	} 

    //addrow�� �ѹ��� ������. 		
	var irow =0;	
	ln_SetDataHeader();
	gcds_data_md.addrow();	
	
	irow =gcds_data_md.RowPosition; 
	orow =gcds_data.RowPosition 
	
	gcds_data_md.namevalue(irow,"VEND_CD") = txt_vend_cd.value;
	gcds_data_md.namevalue(irow,"VEND_ID") = gcem_vend_id.text;
	gcds_data_md.namevalue(irow,"SEQ") =  gcds_data_md.Max(4,0,0)+1;
	gcds_data_md.namevalue(irow,"A_VEND_NM")  = txt_vend_nm.value;
	gcds_data_md.namevalue(irow,"A_VD_DIRECT")= txt_vd_direct.value;
	gcds_data_md.namevalue(irow,"A_POST_NO1") = txt_post_no1.value;
	gcds_data_md.namevalue(irow,"A_POST_NO2") = txt_post_no2.value;
	gcds_data_md.namevalue(irow,"A_ADDRESS1") = txt_address1.value;
	gcds_data_md.namevalue(irow,"A_ADDRESS2") = txt_address2.value;
	gcds_data_md.namevalue(irow,"A_COCOMYN")  = gclx_cocomyn.bindcolval;
	
	//������������ 
	gcds_data_md.namevalue(irow,"B_VEND_NM")  = gcds_data.OrgNameValue(orow,"VEND_NM");
	gcds_data_md.namevalue(irow,"B_VD_DIRECT")= gcds_data.OrgNameValue(orow,"VD_DIRECT");
	gcds_data_md.namevalue(irow,"B_POST_NO1") = gcds_data.OrgNameValue(orow,"POST_NO1");
	gcds_data_md.namevalue(irow,"B_POST_NO2") = gcds_data.OrgNameValue(orow,"POST_NO2");
	gcds_data_md.namevalue(irow,"B_ADDRESS1") = gcds_data.OrgNameValue(orow,"ADDRESS1");
	gcds_data_md.namevalue(irow,"B_ADDRESS2") = gcds_data.OrgNameValue(orow,"ADDRESS2");
	gcds_data_md.namevalue(irow,"B_COCOMYN")  = gcds_data.OrgNameValue(orow,"COCOMYN");
	
	gcds_data_md.namevalue(irow,"STATUS") = "N"; 
	gcds_data_md.namevalue(irow,"WRID") =gs_userid;
	gcds_data_md.namevalue(irow,"UPID") =gs_userid;

	if(gcds_data_md.namevalue(irow,"B_VEND_NM")==gcds_data_md.namevalue(irow,"A_VEND_NM")&&
	   gcds_data_md.namevalue(irow,"B_VD_DIRECT")==gcds_data_md.namevalue(irow,"A_VD_DIRECT")&&
	   gcds_data_md.namevalue(irow,"B_POST_NO1")==gcds_data_md.namevalue(irow,"A_POST_NO1")&&
	   gcds_data_md.namevalue(irow,"B_POST_NO2")==gcds_data_md.namevalue(irow,"A_POST_NO2")&&
	   gcds_data_md.namevalue(irow,"B_ADDRESS1")==gcds_data_md.namevalue(irow,"A_ADDRESS1")&&
	   gcds_data_md.namevalue(irow,"B_ADDRESS2")==gcds_data_md.namevalue(irow,"A_ADDRESS2")&&
	   gcds_data_md.namevalue(irow,"B_COCOMYN")==gcds_data_md.namevalue(irow,"A_COCOMYN")
	){
	   alert("���������� �������� �ʽ��ϴ�.\n\n[���������Է�]���� ������ ���� �� [���] ��ư�� �����ʽÿ�.");
	   gcds_data_md.UndoAll();
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	
    //�ŷ�ó 		
		
	//if(!ln_Chk_Save())return;
	if (gcds_data_md.IsUpdated) {
	    //if(!ln_Chk_Save_Status())return;
	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_t1";
			gctr_data.Parameters = "v_str1="+gs_userid;
		
			//prompt(this, gcds_data_md.text);
			gctr_data.post();
		    //ln_Query();
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
		gcds_data_md.DeleteMarked();
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
		//prompt('',gcds_data_md.text);
		gctr_data.post();
		ln_Query();
	}	
}


/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {

  //���°��� ��� �ϰ�츸 ���� 

   for(i=1;i<=gcds_data_md.countrow;i++){
   		if(gcds_data_md.SysStatus(i)=="1"){
   		
   			if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
				alert("��Ϲ�ȣ�� �������� �ʽ��ϴ�.");
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
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO1")) == "" && fn_trim(gcds_data.namevalue(i,"POST_NO2")) ){ //�����ȣ				
				alert("�����ȣ��  �Է��ϼ��� .");
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
			
			if(fn_trim(gcds_data.namevalue(i,"COCOMYN")) == "" ){ //���¾�ü����				
				alert("���¾�ü������  �Է��ϼ��� .");
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
	gcds_data_md.undo(gcds_data_md.rowposition);
}

/******************************************************************************
	Description : ���ο�û
******************************************************************************/
function ln_AppReq(){
    //���°� üũ : ��� �ݼ� ���¸� ��û ������ 
    if(!ln_Chk_Status()) return false;
	if (confirm(" �ش� �ŷ�ó ���� ���� ��û �Ͻðڽ��ϱ�?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data_md.text);
		gctr_data.post();
		ln_Query();
	}	
}

/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Save_Status(){
	for(var i =1; i<=gcds_data_md.countrow;i++){
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data_md.SysStatus(i)==3){
			if(gcds_data_md.namevalue(i,"STATUS")!="N"&&gcds_data_md.namevalue(i,"STATUS")!="B"){
				alert(gcds_data_md.namevalue(i,"VEND_ID")+"�� ���� ���ɰ��� �ƴմϴ�.");
				return false;
			}
		}
	}
	return true;
}

/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
function ln_Chk_Status(){
    var vcnt=0;
	for(var i=1; i<=gcds_data_md.countrow;i++){
		if(gcds_data_md.namevalue(i,"CHK")=="T"){
			if(gcds_data_md.namevalue(i,"STATUS")!="N"&&gcds_data_md.namevalue(i,"STATUS")!="B"){
				alert(gcds_data_md.namevalue(i,"VEND_ID")+" ����:"+gcds_data_md.namevalue(i,"SEQ")+ "�� ��û ���ɰ��� �ƴմϴ�.");
				return false;
			}else{
				gcds_data_md.namevalue(i,"STATUS")="R"; 
			}
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
	Description : ���°� üũ ����
******************************************************************************/
function ln_Chk_Delete_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data_md.countrow;i++){
		if(gcds_data_md.namevalue(i,"CHK")=="T"){
			if(gcds_data_md.namevalue(i,"STATUS")=="R"||gcds_data_md.namevalue(i,"STATUS")=="Y"){
				alert(gcds_data_md.namevalue(i,"VEND_ID") +" ����:"+gcds_data_md.namevalue(i,"SEQ") + " ��  ���� ���ɰ��� �ƴմϴ�.");
				return false;
			}
			gcds_data_md.MarkRows(i,i);
			
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
	Description : ���
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : ���ڿ�üũ
******************************************************************************/


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
		var THeader = "CHK:STRING,VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
					+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
					+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
					+ "USE_TAG:STRING,"
					+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
					+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
					+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
					+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
	
	if(gcds_data_md.countrow<1){
		var THeader = "CHK:STRING,VEND_CD:STRING,VEND_ID:STRING,SEQ:DECIMAL,"
					+ "B_VEND_NM:STRING,B_VD_DIRECT:STRING,B_POST_NO1:STRING,B_POST_NO2:STRING,B_ADDRESS1:STRING,B_ADDRESS2:STRING,B_COCOMYN:STRING,"
					+ "A_VEND_NM:STRING,A_VD_DIRECT:STRING,A_POST_NO1:STRING,A_POST_NO2:STRING,A_ADDRESS1:STRING,A_ADDRESS2:STRING,A_COCOMYN:STRING,"
					+ "STATUS:STRING,WRID:STRING,UPID:STRING";
		gcds_data_md.SetDataHeader(THeader);						
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




<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- �������� -->
<object  id=gcds_data_md classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data_md_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a010055_t1(I:USER=gcds_data_md)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
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
//		ln_Query();
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>


<script language=JavaScript  for=gcds_data_md event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
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
		gcem_vend_id.Format = "000-00-00000";        //���� 
		gcem_vend_id_2.Format = "000-00-00000";      //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";      //���� 
		gcem_vend_id_2.Format = "000000-0000000";    //����
	}
	
	gcem_vend_id.text   = gcds_data.namevalue(row,"VEND_ID");
	gcem_vend_id_2.text = gcds_data.namevalue(row,"VEND_ID");
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";      //���� 
		gcem_vend_id_2.Format = "000-00-00000";    //����
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";    //���� 
		gcem_vend_id_2.Format = "000000-0000000";  //���� 
	}
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
	gcem_vend_id_2.text = gcds_data.namevalue(row,"VEND_ID");
</script>

<script language=JavaScript for=gcgd_pyo2 event=OnClick(row,colid)>
   if(colid =="CHK"){
	   if(gcds_data_md.namevalue(row,"STATUS")!="N"){
		   alert("���°� ���� �Ұ����մϴ�.");
		   gcds_data_md.namevalue(row,"CHK")="F";
	   }
   }
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
    	<td height="30" align=right>   
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
    </tr>
	<tr>
	 	<td>
			<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" rowspan=2 >�˻�����</td>
					<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">�ŷ�ó�ڵ�</td>
					<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
					<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
						<param name=Text				    value="">
						<param name=Alignment			value=0>
						<param name=Border				value=true>
						<param name=GeneralEdit		value="true">
						<param name=PromptChar		value="_">
					</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
					<td width="400px" class="tab24" align="left" ><comment id="__NSID__">
						<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
						<param name=Text			        value="">
						<param name=Alignment		    value=0>
						<param name=Border			    value=true>
						<param name=GeneralEdit		value="true">
						<param name=PromptChar		value="_">
					</object></comment><script>__ws__(__NSID__);</script>
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
							<param name=Text		   value="">
							<param name=Alignment      value=0>
							<param name=Border         value=true>
							<param name=Numeric        value=false>
							<param name=Format         value="000-00-00000">
							<param name=PromptChar     value="">
							<param name=BackColor      value="#CCCCCC">
							<param name=InheritColor   value=false>
							<param name=readOnly       value=false>
					   </object></comment><script>__ws__(__NSID__);</script>
					</td>
				
				</tr> 
			</table>
		</td>
	<tr>
		<td>
			<table>
				<tr>
					<td>
						<!--Grid-->
						<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:866px;HEIGHT:200px;border:1 solid #777777;display:block;" viewastext>
			 						 <PARAM NAME="DataID"			VALUE="gcds_data">
									 <PARAM NAME="BorderStyle"  VALUE="0">
									 <PARAM NAME="Indwidth"		VALUE="0">
									 <PARAM NAME="Fillarea"		    VALUE="true">
									 <PARAM NAME="ColSizing"		VALUE="true">
									 <param name="sortview"         value=left>
									 <param name="Editable"     	value='true'>
									 <param name=UsingOneClick  value="1">
								     <PARAM NAME="Format"			VALUE="    
										<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,		    width=75,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
										<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = true</FC>
										<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
										<C> ID=VD_DIRECT,	 Name=��ǥ��,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=BSNS_CND,	 Name=����,	            width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=BSNS_KND,	 Name=����,	            width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=ADDRESS1,	 Name=�ּ�,	            width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=ADDRESS2,	 Name=���ּ�,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=COCOMYN,	     Name=��ü����,	        width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true EditStyle=Combo, Data='N:�Ϲݾ�ü,T:���̰�����ü,M:�鼼��ü', show = true </C>
										<C> ID=STATUS		 Name=����,			    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
									">
								 </object></comment><script>__ws__(__NSID__);</script> 
								</td>
							 </tr>
					 	</table>
					</td>
	 			</tr>
			</table>
		</td>
	<tr>
		<td  height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td>
    </tr>
    
    <tr>
		<td height="30" align="left"><strong><font size="2" color="blue"> [���������Է�]</font></strong></td>
    </tr>	
    <tr>
    	<td>
			<!--�Է�â -->
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;height:100px;border:1 solid #708090;">
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��Ϲ�ȣ</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px" colspan =5><nobr>&nbsp;<comment id="__NSID__">
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
					</td>
				</tr>
				<tr>
				    <td style="width:80px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�ڵ� </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;position:relative;left:-7px;top:0px;background-color:#d7d7d7"    ReadOnly>
					</td>
					<td style="width:80px;height:25px;" bgcolor="#eeeeee"  class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�� </nobr></td>               
					<td Style="width:200px;height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;position:relative;left:-7px;top:0px"   >
					</td>			
				
				
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��ǥ�ڸ�</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_direct"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
					</nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�����ȣ</nobr></td>
					<td class="tab13" style="text-align:left" ><nobr>
						<input id="txt_post_no1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:30px;height:20px;top:1px;background-color:#d7d7d7"" readOnly="true";>&nbsp;~
						<input id="txt_post_no2"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:30px;height:20px;top:1px;background-color:#d7d7d7"" readOnly="true";>
						<!-- <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ȣ�� �˻��մϴ�" style="cursor:hand;position:relative;left:1px;top:0px" align=center onclick="ln_Popup('c')">&nbsp;			 
						</nobr> ��)000-000
						-->
						<input type="button" onclick="openDaumPostcode()"  style="position:relative;top:0px;width:100px" value="�����ȣ ã��">&nbsp;
					</td>
					<td style="width:80px;height:25px;" bgcolor="#eeeeee"  class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��ü���� </nobr></td>   
					<td class="tab13" style="text-align:left" colspan =3>
					<nobr><comment id="__NSID__">
						 		<object id=gclx_cocomyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			         value="N^�Ϲݾ�ü,T^���̰�����ü,M^�鼼��ü">
											<param name=CBDataColumns	     value="CODE,NAME">
											<param name=SearchColumn	     value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat       value="NAME">								
											<param name=BindColumn		     value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
					    <a href="Javascript:link_1('https://www.hometax.go.kr/websquare/websquare.wq?w2xPath=/ui/pp/index.xml&tmIdx=0&tm2lIdx=&tm3lIdx=')"><font color="blue"><b>����������ȸ</b></font></a>
						</nobr>
					</td>
					
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left  readOnly="true";><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ּ�</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_address1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:280px;height:20px;">
						</nobr> 
					</td>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;��Ÿ�ּ�</nobr></td>
					<td class="tab13" style="text-align:left"  colspan=3 ><nobr>
						<input id="txt_address2"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:380px;height:20px;">
						</nobr> 
					</td>
				</tr>	
			  </table>
		 </td>
    </tr>
    
    <tr>
		<td> 
			<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr>
					<td  height="24" align="left"><strong><font size="2" color="blue"> [����������ȸ]</font></strong></td>
					<td height="30" align=right>   
			            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"	style="cursor:hand" onclick="ln_AppReq()" >&nbsp;&nbsp;
			    
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_MD_Query()">&nbsp;
					</td>
					
				</tr>
			</table>
		</td>
    </tr>	
    <tr>
    	<td>
			 <table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td class="tab15" width="90px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
					<td width="160px" class="tab18" ><comment id="__NSID__">
						<object id=gcra_usegb_2 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
							<param name=Cols	value="2">
							<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				
					<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">��ȣ</td>
					<td width="90px" class="tab24"   Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
							<param name=Text		   value="">
							<param name=Alignment      value=0>
							<param name=Border         value=true>
							<param name=Numeric        value=false>
							<param name=Format         value="000-00-00000">
							<param name=PromptChar     value="">
							<param name=BackColor      value="#CCCCCC">
							<param name=InheritColor   value=false>
							<param name=readOnly       value=true>
						    <param name=ReadOnlyBackColor   value="#d7d7d7">
					   </object></comment><script>__ws__(__NSID__);</script>
					</td>
					
					<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
					<td width="400px" class="tab24" align="left" ><comment id="__NSID__">
						<object  id=gcem_vend_nm_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
						<param name=Text			        value="">
						<param name=Alignment		    value=0>
						<param name=Border			    value=true>
						<param name=GeneralEdit		    value="true">
						<param name=PromptChar		    value="_">
						<param name=readOnly       value=true>
						<param name=ReadOnlyBackColor   value="#d7d7d7">
					</object></comment><script>__ws__(__NSID__);</script>
					</td>
				
				</tr> 
			</table>
    	</td>
    </tr>
    
    <tr> 			
		<td ALIGN=LEFT VALIGN=TOP>
			<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo2 style="WIDTH:866px;HEIGHT:200px;border:1 solid #777777;display:block;" viewastext>
				 <PARAM NAME="DataID"	VALUE="gcds_data_md">
			 <PARAM NAME="BorderStyle"  VALUE="0">
			 <PARAM NAME="Indwidth"		VALUE="0">
			 <PARAM NAME="Fillarea"		VALUE="false">
			 <PARAM NAME="ColSizing"	VALUE="true">
			 <param name="sortview"     value=left>
			 <param name="Editable"     value='true'>
			 <param name=UsingOneClick  value="1">
		     <PARAM NAME="Format"			VALUE="
		        <FC>ID=CHK,  	     Name=����,		        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  editstyle=checkbox  </FC>    
				<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,		    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true </FC>
				<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = true  </FC>
				<FC>ID=SEQ,	         Name=����,		        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = false </FC>
				<G> Name=��������,	 HeadBgColor=#B9D4DC, 
				<C> ID=A_VEND_NM,	 Name=�ŷ�ó��,			width=120,	HeadBgColor=#B9D4DC, BgColor={IF(B_VEND_NM=A_VEND_NM,'FFFFFF','#FFCC66')},     align=left,   edit=none  sort = true</C>
				<C> ID=A_VD_DIRECT,	 Name=��ǥ��,			    width=60,	HeadBgColor=#B9D4DC, BgColor={IF(B_VD_DIRECT=A_VD_DIRECT,'FFFFFF','#FFCC66')}, align=left,	 edit=none  sort = true show = true </C>
				<C> ID=A_POST_NO1,	 Name=����,	            width=30,	HeadBgColor=#B9D4DC, BgColor={IF(B_POST_NO1=A_POST_NO1,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = false show = true </C>
				<C> ID=A_POST_NO2,	 Name=��ȣ,	            width=30,	HeadBgColor=#B9D4DC, BgColor={IF(B_POST_NO2=A_POST_NO2,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = false show = true </C>
				<C> ID=A_ADDRESS1,	 Name=�ּ�,	            width=140,	HeadBgColor=#B9D4DC, BgColor={IF(B_ADDRESS1=A_ADDRESS1,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = true show = true </C>
				<C> ID=A_ADDRESS2,	 Name=���ּ�,	        width=140,	HeadBgColor=#B9D4DC, BgColor={IF(B_ADDRESS2=A_ADDRESS2,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = true show = true  </C>
				<C> ID=A_COCOMYN,	 Name=��ü����,	        width=70,	HeadBgColor=#B9D4DC, BgColor={IF(B_COCOMYN=A_COCOMYN,'FFFFFF','#FFCC66')},     align=left,	 edit=none  sort = true show = true  EditStyle=Combo, Data='N:�Ϲݾ�ü,T:���̰�����ü,M:�鼼��ü'</C>
				</G>
				<C> ID=STATUS		 Name=����,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
                <C> ID=B_VEND_NM,	 Name=�ŷ�ó��,			width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  show = false </C>
				<C> ID=B_VD_DIRECT,	 Name=��ǥ��,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_POST_NO1,	 Name=����,	            width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_POST_NO2,	 Name=��ȣ,	            width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_ADDRESS1,	 Name=�ּ�,	            width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_ADDRESS2,	 Name=���ּ�,	        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
 			">
			 </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=VEND_ID,     Ctrl=gcem_vend_id   Param=text		    </C>
		<C>Col=VEND_CD,     Ctrl=txt_vend_cd    Param=value		    </C>
		<C>Col=VEND_NM,     Ctrl=txt_vend_nm  	Param=value		    </C>
		<C>Col=VD_DIRECT,   Ctrl=txt_vd_direct  Param=value		    </C>
		<C>Col=POST_NO1,  	Ctrl=txt_post_no1   Param=value		    </C>
		<C>Col=POST_NO2,  	Ctrl=txt_post_no2 	Param=value		    </C>
		<C>Col=ADDRESS1,  	Ctrl=txt_address1 	Param=value		    </C>
		<C>Col=ADDRESS2,  	Ctrl=txt_address2   Param=value  	    </C>
		<C>Col=COCOMYN,  	Ctrl=gclx_cocomyn   Param=bindcolval    </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



