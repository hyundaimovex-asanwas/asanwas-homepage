<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: ��������>��������>��������>�������
* ���α׷� ID	: li0200i.jsp
* �� �� �� ��	: �������
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2011.10.21
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
* �� �� �� ��	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>�������</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var sApproveLine="";

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    fnInit();
    
    txt_own_dpt.value = gdeptcd;
    txt_own_dptnm.value = gdeptnm;
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){
	ds_doc_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI001&s_item1=Y";
    ds_doc_grd.Reset(); //�������
    
    ds_doc_frm.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI002&s_item1=Y";
    ds_doc_frm.Reset(); //��������
    
    ds_crt_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI003&s_item1=Y";
    ds_crt_div.Reset(); //��������
    
    ds_sgn_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP002&s_item1=Y";
    ds_sgn_sts.Reset(); //�������
    
    ds_snd_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI005&s_item1=Y";
    ds_snd_div.Reset(); //�߽ű���
    
    ds_rcp_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI004&s_item1=Y";
    ds_rcp_sts.Reset(); //���ſ���
}

/******************************************************************************
	Description : ���Ϲ��� ��ȸ
******************************************************************************/
function fnSelect(){

     /** �̰��� �ǹ� ����. ==> ������Ǹ� ��ȸ �����ϰ� �� 
     if(gcem_doc_mag_sid.text==""){
     	alert("������ȣ �Է� �� ��ȸ �����մϴ�.");
        return;
     }
     **/

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_grd="+gclx_doc_grd.bindcolval
		              + ",v_doc_frm=" +gclx_doc_frm.bindcolval
		              + ",v_gdeptcd=" + txt_own_dpt.value
		              + ",v_doc_tle=" + gcem_doc_tle.text
		              + ",v_doc_cts=" + gcem_doc_cts.text
		              + ",v_doc_kwd=" + gcem_doc_kwd.text;       
		              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);
  
}


/******************************************************************************
	Description : �������� ��ȸ
******************************************************************************/
function fnSelect2(int_doc_mag_sid){

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_mag_sid="+int_doc_mag_sid;
		              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(O:DS_DEFAULT2=ds_default2)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);

}



/******************************************************************************
	Description : ������ ��ȸ
******************************************************************************/
function fnSelect3(){

     //doc_mag_sid ����üũ
      
     var srow;
  	
  	 //����������ġ Ȯ�� 
	 for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
         	srow = ds_default2.rowposition;
        }
    }
  
    fnDisplay(srow,"SND_DIV");  
     

	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                 + ",v_dtb_mag_sid="+gcem_dtb_mag_sid.text;
		              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(O:DS_DEFAULT3=ds_default3)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);

}

/******************************************************************************
	Description : �������� ���߰� 
******************************************************************************/
function fnAddRow2(){
    
    if(gcem_doc_mag_sid.text==0 ||gcem_doc_mag_sid.text==""){
    	alert("��Ϲ�ȣ�� �����ϼ���");
    	return;
    }
    
	if(ds_default2.CountRow==0){
		 fnSelect2("0");
	}
	
	ds_default2.addrow();
	ds_default2.namevalue(ds_default2.rowposition,"DOC_MAG_SID")=gcem_doc_mag_sid.text; //
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
 function fnApply2() {
    
    //alert("����2::"+ds_default2.IsUpdated);
 
    if (ds_default2.IsUpdated) {
        if (fnChk()) {
            ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(I:DS_DEFAULT2=ds_default2 )",  "proType=A,dsType=1");
           // prompt('',ds_default.text);
            tr_post(tr2);
        }
    }
}

/******************************************************************************
	Description : �������� ���
******************************************************************************/
 function fnCancel2() {           
    ds_defaul2.undoall();
    window.status="�������� �Է��� ��ҵǾ����ϴ�.";      
}


/******************************************************************************
	Description : ����
******************************************************************************/
function fnCreate3(){

    //üũ�ڽ� üũ 
   var chk_yn="N";
   var chk_cnt=0;
   var chk_dtb_mag_sid="";
   var chk_dtb_sgn_sts="";
   
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   			chk_yn="Y";	
   			chk_cnt = ds_default2.namevalue(i,"DTB_CNT");
   			chk_dtb_mag_sid=ds_default2.namevalue(i,"DTB_MAG_SID");
   			chk_dtb_sgn_sts=ds_default2.namevalue(i,"DTB_SGN_STS");
   		}
   } 
   
   if(chk_yn=="N"){
   		alert("���������� �����Ͻʽÿ�.");
   		return ;
   }
   
   //�����μ� üũ 
   if(chk_cnt==0){
   		alert("�������� �Է��Ͻʽÿ�.");
   		return;
   }
   
    //�����μ� üũ 
   if(chk_dtb_mag_sid==0){
   		alert("������ȣ�� �����ϴ�. ���� ������ ���� �����Ͻʽÿ� ");
   		return;
   }
   
   
    //������� üũ
   if(chk_dtb_sgn_sts!="1"){
   		alert("������°� �ۼ��߸� ������ ���� �����մϴ�.");
   		return;
   }
   
   
   ds_default3.ClearAll();
     
   if(ds_default3.CountRow==0){
   		fnSelect3(0);
   }
   
   
   if(ds_default3.CountRow>=1){
   	 alert("�̹� �����󼼰� ��� �Ǿ����ϴ�.");
   	 return;	
   }
   
   
   //alert("ds_default3.CountRow::"+ds_default3.CountRow);
    
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   		     fnDisplay(i,"SND_DIV"); //
   			for(var j=1;j<=chk_cnt;j++ ){
   				fnAddrow3(i,j,ds_default2.namevalue(i,"SND_DIV") );
   			}	
   		}
   }
}

/******************************************************************************
	Description : �ڵ����߰�  
	                     
******************************************************************************/
function fnAddrow3(i,j,strSndDiv){

    //alert ("i::"+i+"::j::"+j+"ds_default::"+ds_default.namevalue(i,"DOC_MAG_SID"));
 
    //���������� ������Ͽ� �� �����͸� ��� ������ �־����. 

	ds_default3.Addrow();
		
	ds_default3.namevalue(j,"DTB_MAG_SID")=ds_default2.namevalue(i,"DTB_MAG_SID");;  //���� ��ȣ
	ds_default3.namevalue(j,"DTB_SEQ")=j;  //���� ����
	
	ds_default3.namevalue(j,"RCP_DPT")=""  //���źμ� ����ڰ� ���� �Է�
	ds_default3.namevalue(j,"SGN_STS")= "1";  //�ۼ���
	
	if(strSndDiv=="1"){ //����
		ds_default3.namevalue(j,"RCP_STS")= "3";  //������Ȯ��
	}else if(strSndDiv=="2"){ //�系����
		ds_default3.namevalue(j,"RCP_STS")= "1";  //���Ź�Ȯ��
	}else{
	    ds_default3.namevalue(j,"RCP_STS")= "9"; //��ܹ���
	}
	
	
	ds_default3.namevalue(j,"TNS_RCP_DST")= ""; //�������ó  ����ڰ� ���� �Է�
	ds_default3.namevalue(j,"TNS_RCP_PSN")= ""; //���������  ����ڰ� ���� �Է�
	
	ds_default3.namevalue(j,"RCP_DT")="";            //��������  ����Ȯ�ν� �������� 
	ds_default3.namevalue(j,"RCP_PSN")="";         //������      ����ڰ� �����Է� 
	ds_default3.namevalue(j,"DOC_MAG_SID")=gcem_doc_mag_sid.text;   //��Ϲ�ȣ
	
	ds_default3.namevalue(j,"CRT_DIV")="2" ;  //�纻 ( ���纻�̹Ƿ� �׻� �纻 ) 
	ds_default3.namevalue(j,"DOC_GRD")=ds_default.namevalue(ds_default.rowposition,"DOC_GRD"); //���
	ds_default3.namevalue(j,"DOC_FRM")=ds_default.namevalue(ds_default.rowposition,"DOC_FRM"); //����
	ds_default3.namevalue(j,"DOC_TLE") =ds_default.namevalue(ds_default.rowposition,"DOC_TLE"); //����

}


/******************************************************************************
	Description : ����
******************************************************************************/
 function fnApply3() {
    if (ds_default3.IsUpdated) {
        if (fnChk3()) {
            ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(I:DS_DEFAULT3=ds_default3 )",  "proType=A,dsType=1");
           // prompt('',ds_default.text);
            tr_post(tr1);
        }
    }
}

/******************************************************************************
	Description : ����� üũ
******************************************************************************/
 function fnChk() {           
    var chk_yn="N";
  	var chk_cnt=0;
  	var chk_snd_div="";
  	var chk_dtb_dt="";
  	var chk_tns_rsn="";
  	var chk_tns_way="";
  	var chk_row=0;
  	
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   			chk_yn="Y";	
   			chk_cnt = ds_default2.namevalue(i,"DTB_CNT");
   			chk_snd_div = ds_default2.namevalue(i,"SND_DIV");
   			chk_dtb_dt = ds_default2.namevalue(i,"DTB_DT");
   			chk_tns_rsn = ds_default2.namevalue(i,"TNS_RSN");
   			chk_tns_way = ds_default2.namevalue(i,"TNS_WAY");
   			chk_row=i;
   		}
   } 
      
  	
  	//�ʼ��׸�üũ 
  	if(chk_yn=="N"){
  		alert("���������� �����Ͻʽÿ�.");
  		return false;
  	}
  	
  	
  	if(chk_snd_div==""){
  		alert("�߽ű�����  �Է��Ͻʽÿ�.");
  		return false;
  	}
  	
  	if(chk_cnt==0){
  		alert("�������� �Է��Ͻʽÿ�.");
  		return false;
  	}
  	
  	if(chk_dtb_dt==""){
  		alert("�������ڸ� �Է��Ͻʽÿ�.");
  		return false;
  	}
  	
  	
  	//��ܹ����� ��� ���������� ������� �ʼ��Է� 
  	if(chk_snd_div=="3"){
  		if(chk_tns_rsn==""){
	  		alert("����������  �Է��Ͻʽÿ�.");
	  		return false;
  		}
  		
  		if(chk_tns_way==""){
	  		alert("��������� �Է��Ͻʽÿ�.");
	  		return false;
  		}
  	}
  	
  	//�������� ���� 
  	if(chk_dtb_dt.length!=8){
  		alert("�������ڸ� Ȯ���Ͻʽÿ�");
  		return false;
  	}
  	
  	
  	
    if(ds_default2.namevalue(chk_row,"DTB_SGN_STS")!=""){
    	alert("�� �̻� ���� �� �� �����ϴ�.");
    	return false;
    }
  	
    return true;
  	
  	//üũ ������ �� ���� �� �����Է� cell ���� ����ǰ� �ұ�?
}


/******************************************************************************
	Description : ����� üũ
******************************************************************************/
 function fnChk3() {    
   var chk_row=0;
   var chk_snd_div="";
   var chk_sgn_sts="";
   var chk_yn="N";
   var chk_dtb_mag_sid="";
   
      
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   			chk_row=i;
   			chk_snd_div = ds_default2.namevalue(i,"SND_DIV");
   			chk_sgn_sts =ds_default2.namevalue(i,"DTB_SGN_STS");      
   			chk_yn="Y";      
   			chk_dtb_mag_sid = ds_default2.namevalue(i,"DTB_MAG_SID");
   		}
   } 
   
   //alert("chk_snd_div::"+chk_snd_div);
   //alert("chk_sgn_sts::"+chk_sgn_sts);
   //alert("chk_dtb_mag_sid::"+chk_dtb_mag_sid);
   
  	if(chk_yn=="N"){
  		alert("���������� �����Ͻʽÿ�.");
  		return false;
  	}
   
   if (chk_dtb_mag_sid!=ds_default3.namevalue(1,"DTB_MAG_SID")) {
   	  alert("������ȣ�� Ȯ���Ͻʽÿ�.");
   	  return false;
   }
   
   if (chk_sgn_sts!=1&&chk_sgn_sts!="") {
   	 alert("������°� �������Դϴ�. ������ �� �����ϴ�.");
   	 return false;
   }
   
   
   //����� �ʼ��׸� üũ 
   if(chk_snd_div==3){ // ��ܹ��� 
   		for (var j =1;j<=ds_default3.countrow;j++){
   			if(ds_default3.namevalue(j,"TNS_RCP_DST")==""){
   				alert("�������ó�� �ʼ� �׸��Դϴ�.");
   				return false;	
   			}
   			
   			if(ds_default3.namevalue(j,"TNS_RCP_PSN")==""){
   				alert("��������ڴ� �ʼ� �׸��Դϴ�.");
   				return false;
   			}
   		}
   }else{
    	for (var j =1;j<=ds_default3.countrow;j++){
   			if(ds_default3.namevalue(j,"������")==""){
   				alert("�����ڴ� �ʼ� �׸��Դϴ�.");
   				return false;	
   			}
   			
   			if(ds_default3.namevalue(j,"RCP_DPT")==""){
   				alert("���źμ��� �ʼ� �׸��Դϴ�.");
   				return false;
   			}
   		}
   }
      
     
  return true;
 
 }  

/******************************************************************************
	Description : �������� �׸����� ����ó,������, �������ó,��������� display
	                     �߽ű��� = ��ܹ����ϰ�츸, �������ó, ��������� ������.
******************************************************************************/
function fnDisplay(row,colid) {

	if(ds_default2.namevalue(row,colid)=="3"){ //��ܹ���
 			gcgd_disp03.ColumnProp("RCP_DPT_NM","show")="false"; 
 			gcgd_disp03.ColumnProp("RCP_PSN_NM","show")="false";
 			gcgd_disp03.ColumnProp("TNS_RCP_DST","show")="true";
 			gcgd_disp03.ColumnProp("TNS_RCP_PSN","show")="true";
 	}else{
 			gcgd_disp03.ColumnProp("RCP_DPT_NM","show")="true";
 			gcgd_disp03.ColumnProp("RCP_PSN_NM","show")="true";
 			gcgd_disp03.ColumnProp("TNS_RCP_DST","show")="false";
 			gcgd_disp03.ColumnProp("TNS_RCP_PSN","show")="false";
 	}
}



/******************************************************************************
	Description : ������, ������ �μ� 
******************************************************************************/
function fnRcpDptPopup(row,colid,data) {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			
			//alert(" arrParam[0]::"+ arrParam[0]);
			ds_default3.namevalue(row,"RCP_DPT")       = arrParam[3];
	   		ds_default3.namevalue(row,"RCP_DPT_NM") = arrParam[0];
	   		ds_default3.namevalue(row,"RCP_PSN")      = arrParam[1];
	   		ds_default3.namevalue(row,"RCP_PSN_NM")   = arrParam[2];
		} else {
			ds_default3.namevalue(row,"RCP_DPT")      = "";
	   		ds_default3.namevalue(row,"RCP_DPT_NM") = "";
	   		ds_default3.namevalue(row,"RCP_PSN")      = "";
	   		ds_default3.namevalue(row,"RCP_PSNM")   = "";
   		}				
	}


/******************************************************************************
	Description : ���缱  popup
******************************************************************************/
function fnApproval() {
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;
	var strPos;
	strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
	strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
	sApproveLine = arrResult; // ru
}

/******************************************************************************
	Description : ���  popup
******************************************************************************/
function fnDraft() {
    var row=0;
    var strGB="";
    var int_doc_mag_sid=0;

	if(ds_default.CountRow ==0){
		alert("��� �� ������ ��ȸ �� �ּ���");
		return;
	}
	
	if(ds_default.namevalue(ds_default.rowposition,"DOC_GRD")!="1"){
		alert("��������� ��и� ��� �����մϴ�.");
		return;
	}
		
	if(sApproveLine==""||sApproveLine=="undefined"){
	   alert("���缱������ ���� �ʾҽ��ϴ�.");
	   return;
	}
	
	
	//����������ġ Ȯ�� 
	for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
         	row = ds_default2.rowposition;
        }
   }
    
   
    if(row<1){
    	alert("���������� ������ üũ �Ͻʽÿ�.");
    	return;
    }
    
    
    //����������� Ȯ�� �ۼ��߸� ��� ����  
   	if(ds_default2.namevalue(row,"DTB_SGN_STS")!="1"){
   		alert("����������°� �ۼ��߸� ��� �����մϴ�.");
   		return;
   	}
         	

    //������  �Ǽ� Ȯ�� 
    if(ds_default3.countrow<1){
    	alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
    	return;
    } 
    
    //alert("ds_default3::"+ds_default3.SysStatus(ds_default3.countrow));   
    if(ds_default3.SysStatus(ds_default3.countrow)!=0){
    	alert("������ ������ ���� �� ��� �����մϴ�.");
    	return;
    }
      
   
	if (ds_default2.namevalue(row,"SND_DIV")=="1"){  //����
		strGB ="040";
	}else if(ds_default2.namevalue(row,"SND_DIV")=="2"||ds_default2.namevalue(row,"SND_DIV")=="3" ){ //�系����, ��ܹ��� 
	    strGB ="020";	
	};
	
	
	int_doc_mag_sid = ds_default.namevalue(ds_default.rowposition,"DOC_MAG_SID");
	var arrParam	= new Array();
		
	arrParam[0]=strGB;  // AP006 ( 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û 
	arrParam[1]=ds_default2.namevalue(ds_default2.rowposition,"DTB_MAG_SID");  //������ȣ 
	arrParam[2]=sApproveLine;      // ���缱���� 
	
	
	strURL = "<%=dirPath%>/Security/help/li0200h.jsp?";
	strPos = "dialogWidth:740px;dialogHeight:500px;status:no;scroll:no;resizable:no";
	
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	
	fnSelect2(int_doc_mag_sid);
}
	
	

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-DOC_MAG_SID">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name=SortExpr   value="-DTB_MAG_SID">
</object>

<object  id=ds_default3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=ds_doc_grd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_doc_frm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_crt_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_sgn_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_snd_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_rcp_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	if(ds_default.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>

<script language="javascript" for="ds_default2" event="onloadCompleted(row,colid)">
  
    ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	if(ds_default2.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>

<script language="javascript" for="ds_default3" event="onloadCompleted(row,colid)">
  
    ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	if(ds_default3.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

    if(row>0){
       // alert("DOC_MAG_SID::"+ds_default.namevalue(row,"DOC_MAG_SID"));
		fnSelect2(ds_default.namevalue(row,"DOC_MAG_SID"));
		ds_default3.ClearAll();
	}
 </script>
 
 
 <script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>

    if(row>0){
       // alert("DOC_MAG_SID::"+ds_default.namevalue(row,"DOC_MAG_SID"));
		fnSelect2(ds_default.namevalue(row,"DOC_MAG_SID"));
		ds_default3.ClearAll();
	}
 </script>

 <script language=JavaScript for=gcgd_disp02 event=OnCloseUp(row,colid)>

 	if(colid=="SND_DIV"){
 		fnDisplay(row,colid);
 	}
  </script>
  
 <script language="javascript"  for=gcgd_disp02 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=ds_default2.countrow;i++) {
			if(i != Row) {
				ds_default2.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>


<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	var __calendarRtn;
 	__calendarRtn = window.showModalDialog("<%=dirPath%>/Common/html/com_calender.htm","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
	
	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
        ds_default2.namevalue(row,colid)= __calendarRtn[3];
		__calendarRtn=null;
	}
</script>
 
 
 <script language=JavaScript for=gcgd_disp03 event=OnPopup(row,colid,data)>
 		fnRcpDptPopup(row,colid,data);
 </script>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=tr2  event=OnSuccess()>

	fnSelect2(gcem_doc_mag_sid.text);
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=left >
			<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnApproval()">
			<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:hand" onclick="fnDraft()">
		</td>
		<td align=right >
		    <img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">	
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	
	<tr> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>�������</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_grd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_doc_grd">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>��������</td>  
	    <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_frm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_doc_frm">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>�����μ�</td> 
		<td class="tab24"  colspan =3 >&nbsp;
			<input type="text" class="txt11" id="txt_own_dpt"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_own_dptnm"  style="position:relative;left:-4px;width:100px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	
	<tr> 
		<td width="80px"    class="tab30"  bgcolor="#eeeeee" align=center>����</td>
		<td class="tab28"  colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_tle classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>����</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_cts classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>Ű����</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_kwd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
   <tr><td height="5px"> </td> </tr>
   <tr>
   		<td align=left><font  SIZE="2"   COLOR="blue" style="position:relative;top:-3px"><b>[���Ϲ���]</b></font>
   		
   		<font  SIZE="2"   COLOR="black"  style="position:relative;left:5px;top:-3px" > *��Ϲ�ȣ : </font>
            <comment id="__NSID__">
			<OBJECT id=gcem_doc_mag_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:80px">
				<param name=Text				value="">
				<param name=Alignment		value=2>
				<param name=Border			value= true>
				<param name=ReadOnly     value="true">
				<param name=IsComma      value="false">
				<param name=MaxLength    value=10>
				<param name=ReadOnlyBackColor   value="#C0C0C0">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
   		</td>
   		
        <td align=right >
            <font  SIZE="2"   COLOR="blue"  style="position:relative;left:-45px;top:-3px"><b>[��������]</b></font>
            
           <font  SIZE="2"   COLOR="black"  style="position:relative;left:-30px;top:-3px" > *������ȣ : </font>
            <comment id="__NSID__">
			<OBJECT id=gcem_dtb_mag_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:-30px;width:80px">
				<param name=Text				value="">
				<param name=Alignment		value=2>
				<param name=Border			value= true>
				<param name=ReadOnly     value="true">
				<param name=IsComma      value="false">
				<param name=MaxLength    value=10>
				<param name=ReadOnlyBackColor   value="#C0C0C0">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
    		<img src="<%=dirPath%>/Sales/images/plus.gif"   	       style="cursor:hand" onclick="fnAddRow2()">
    		<img src="<%=dirPath%>/Sales/images/save.gif"	 	    style="cursor:hand" onclick="fnApply2()">
		    <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" onclick="fnCancel2()">
		</td>
   </tr>
   <tr> 
		<td >
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:380px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name="Format"	 	 value=" 
					<C> Name='��Ϲ�ȣ'		        ID=DOC_MAG_SID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=right    edit = none </C>
					<C> Name='����\\����'         ID=CRT_DIV                HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left       edit = none  EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm'  </C>
                    <C> Name='���'  	                ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left       edit = none  EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm' </C>
					<C> Name='����'  	                ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left       edit = none  EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </C>
					<C> Name='����'  	                ID=DOC_TLE	          HeadAlign=Center HeadBgColor=#B9D4DC Width=140 	align=left       edit = none</C>
					<C> Name='���\\�������'	ID=SGN_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=left       edit = none EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:382px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
		<td >
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:0px;width:475px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default2">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name=UsingOneClick  value="1">
					<param name="Format"	 	 value=" 
					<C> Name='����'      		        ID=CHK              	      HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  EditStyle=CheckBox</C>
					<C> Name='������ȣ'	            ID=DTB_MAG_SID 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=right     edit = none </C>
					<C> Name='�߽ű���'  	            ID=SND_DIV	              HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=left       BgColor=#81F79F   EditStyle=Lookup	Data='ds_snd_div:detail:detail_nm' </C>
					<C> Name='����\\��'   	        ID=DTB_CNT	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=right     BgColor=#81F79F  </C>
					<C> Name='��������'  	            ID=DTB_DT	              HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center  BgColor=#81F79F  EditStyle=Popup  mask ='XXXX/XX/XX'</C>
					<C> Name='��������'  	            ID=TNS_RSN	          HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left        BgColor=#81F79F </C>
					<C> Name='�������'  	            ID=TNS_WAY	          HeadAlign=Center HeadBgColor=#B9D4DC Width=77 	align=left        BgColor=#81F79F </C>
					<C> Name='����\\�������'	ID=DTB_SGN_STS      HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=left       edit = none EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:477px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
   <tr><td height="5px"> </td> </tr>
   <tr>
   		<td align=left><font  SIZE="2"   COLOR="blue"><b>[������]</b></font></td>
   		
        <td align=right >
		    <img src="<%=dirPath%>/Sales/images/refer.gif"		   style="cursor:hand" onclick="fnSelect3()">
		    <img src="<%=dirPath%>/Sales/images/n_create.gif"	    style="cursor:hand" onclick="fnCreate3()">
    		<img src="<%=dirPath%>/Sales/images/save.gif"	 	    style="cursor:hand" onclick="fnApply3()">
		    <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" onclick="fnCancel3()">
		</td>
   </tr>
   <tr> 
		<td colspan=2>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
			style="position:relative;left:0px;width:858px; height:250px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default3">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name="Format"	 	 value=" 
					<C> Name='��Ϲ�ȣ'		              ID=DOC_MAG_SID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right   edit = none  </C>
					<C> Name='������ȣ' 	                  ID=DTB_MAG_SID     HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=right   edit = none  </C>
                    <C> Name='����'  	                      ID=DTB_SEQ  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=right   edit = none  </C>
					<C> Name='����\\����'               ID=CRT_DIV   	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left     edit = none  EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm' </C>
					<C> Name='���'  	                      ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left     edit = none  EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm'  </C>
					<C> Name='����'  	                      ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left     edit = none  EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </C>
					<C> Name='����'  	                      ID=DOC_TLE	          HeadAlign=Center HeadBgColor=#B9D4DC Width=175	align=left     edit = none  </C>
					<C> Name='������'	                      ID=RCP_PSN            HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left     BgColor=#81F79F  EditStyle=Popup  show=false </C>
					<C> Name='�����ڸ�'	                  ID=RCP_PSN_NM     HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left     BgColor=#81F79F  EditStyle=Popup </C>
					<C> Name='���źμ�'	                  ID=RCP_DPT            HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left     show=false  </C>
					<C> Name='���źμ���'	              ID=RCP_DPT_NM     HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	align=left      </C>
					<C> Name='����\\����ó'	          ID=TNS_RCP_DST    HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      BgColor=#81F79F </C>
					<C> Name='����\\������'	          ID=TNS_RCP_PSN    HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      BgColor=#81F79F </C>
					<C> Name='���ſ���\\�������'  ID=SGN_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      edit = none  EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					<C> Name='���Ż���'	                  ID=RCP_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=left      edit = none  EditStyle=Lookup	Data='ds_rcp_sts:detail:detail_nm' </C>
					<C> Name='Ű����'  	                  ID=DOC_KWD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left      edit = none  show=false</C>
					<C> Name='����'  	                      ID=DOC_CTS	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left      edit = none   show=false</C>					
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>
<comment id="__NSID__">
	<object  id=gcbn_01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default>
	<param name=BindInfo  value='  
	<C>Col=DOC_MAG_SID	  Ctrl=gcem_doc_mag_sid   Param=TEXT </C>
	'>
</object>

<object  id=gcbn_02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default2>
	<param name=BindInfo  value='  
	<C>Col=DTB_MAG_SID	  Ctrl=gcem_dtb_mag_sid   Param=TEXT </C>
	'>
</object>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 