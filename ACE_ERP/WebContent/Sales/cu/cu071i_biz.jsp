<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ��ϱ��� ��û
 * ���α׷�ID 	: CU070I
 * J  S  P			: cu070i
 * �� �� ��		: Cu070i
 * �� �� ��		: ������
 * �� �� ��		: 2006-06-12
 * �������		 : ��ϱ����׹������û ��ȸ,����
 * [��  ��   ��  ��][������] ����
 * [2006-06-20][�̺���]
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-01-31][�ɵ���] �� ��å�� ���� ���� ����.
 * [2008-04-21][�ɵ���] ��ϱ����� ����� �߱� ��û �и�  
 * [2010-04-06][�ڰ汹] ������߱޽�û �޴�(��ϱ����� ���� �¶��α������� ����)
 * [2010-04-16][�ɵ���] ��߱� ��û�� ���ε� ����(�̹��� ���ε� 42�� ������)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript">

    var v_job = "";
    var today = "";
	<%// ������ �ε� %>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit(); 
		}
	<%// �ʱ�ȭ : �������� ���´�%>
	function fnInit(){		
        v_job = "H";
        today = new Date();
        if(today.getMonth()<10) {
        	if(today.getDate()<10) {
        		txt_req_dt.text=today.getYear()+"0"+(today.getMonth()+1)+"0"+today.getDate();
        	}
        	else {
        		txt_req_dt.text=today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
        	}
        } else {
        	txt_req_dt.text=today.getYear()+""+(today.getMonth()+1)+""+today.getDate();
        };
        
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		ds2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU015";
		ds2.Reset(); //����۾�����
 		ds3.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU014";
		ds3.Reset(); //��ϱ�������
 		ds8.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU016";
		ds8.Reset(); //��ϸ���		
 		ds9.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds9.Reset(); //�����ڵ�
 		//ds9.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?proType=S&dsType=1";
		//ds9.Reset(); //����(�׸����)


		//����(�˻�����: ��ü����)
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS_ALL=ds4)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		fnEducDate();
		
		fnSetHeaderDs1();
		
		drp_visit_object.Index = 1;
	}

	<%// �����ͼ� ��� ���� (������)%>
	function fnSetHeaderDs1(){
		if (ds1.countrow<1){
			var s_temp = ""
			+ "CLIENT_NM:STRING,CUST_NM:STRING,MANAGE_NO:STRING,REQ_DT:STRING,EDUC_PLAN_DT:STRING,SAUP_SID:INT,"
			+ "N_EDUC_YN:STRING,N_JOB_GU:STRING,VISIT_OBJECT_CD:STRING,VISIT_OBJECT:STRING,REMARKS:STRING,"
			+ "CLIENT_SID:INT,EDUC_CARD_SID:INT,CUST_SID:INT";
			ds1.SetDataHeader(s_temp);
		}
	};

	
	function fnEducDate() {	
		ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
            	"JSP(O:EDUC_PLAN_DT=codeDs1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

	<%// ������ȸ-------------------------------%>
	function fnSelect() {	
        v_job = "S";

        if(ds1.IsUpdated!=false && confirm("���� ���� �۾����� �����Ͱ� �ֽ��ϴ�. �����Ͻðڽ��ϱ�")==false)
            return;
/*        if(txt_client_cd.value=="" || txt_client_sid.value == "") {
        	alert("���¾�ü�ڵ带 �Է��Ͻʽÿ�.");
            return;
        }        */
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid=" + txt_client_sid.value												// �ŷ�ó ���̵�
                 // + ",sEducPlanDt=" + txt_educ_dt.text											// ��������
				  + ",sVisitObjCd=" + drp_visit_object.ValueOfIndex("detail", drp_visit_object.Index)				// ��ϸ����ڵ�
                 // + ",sSaupSid=" + drp_saup_sid_s.ValueOfIndex("saup_sid", drp_saup_sid_s.Index)		// ����� SID
                  + ",sCustNm=" + txt_cust_nm.value																						// ���� 
                  + ",sManageNo=" + txt_manage_no.value;	
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}

	<%//���¾�ü Ű����� ��ȸ------------------------------------------%>
	function fnSelectDs11() {
		if(txt_client_cd.value!=""&&txt_client_nm.value=="") {
			ds5.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?proType=S&dsType=1&keyWord="+txt_client_cd.value+"&gubun=2" ;
			ds5.Reset();
		}
	}

	<%//���¾�ü���� ��ȸ--------------------------------------------%>
	function fnSelectDs13() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=4"
                  + ",sClientSid=" + txt_client_sid.value;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
            "JSP(O:DEFAULT=ds7)",
            param);
        tr_post(tr2);
	}
	<%// ���߰� (�׸��庰)--------------------------------------------%>
	function fnAddRow() {
        if(txt_client_cd.value=="" || txt_client_sid.value == "") {
        	alert("���¾�ü�ڵ带 �Է��Ͻʽÿ�.");
            return;
        }	
		ds1.addRow();
		ds1.namevalue(ds1.rowposition,"req_dt")=txt_req_dt.text;	//��û����
		ds1.namevalue(ds1.rowposition,"n_job_gu")=drp_n_job_gu.ValueOfIndex ("detail", drp_n_job_gu.Index);//�۾�����
		ds1.namevalue(ds1.rowposition,"visit_object_cd")=drp_visit_object.ValueOfIndex ("detail", drp_visit_object.Index); //��ϸ�������(���ð�)
		ds1.namevalue(ds1.rowposition,"visit_object")= getObjectFirst("txt_visit_object").value ;	//��ϸ���
		ds1.namevalue(ds1.rowposition,"client_sid") = txt_client_sid.value;
		ds1.namevalue(ds1.rowposition,"client_nm") = txt_client_nm.value;
		ds1.namevalue(ds1.rowposition,"educ_card_sid") = 0;
		ds1.namevalue(ds1.rowposition,"saup_sid") = drp_saup_sid.ValueOfIndex ("saup_sid", drp_saup_sid.Index); //��������
		//ds1.namevalue(ds1.rowposition,"educ_plan_dt")=txt_educ_plan_dt.ValueOfIndex("title_nm",txt_educ_plan_dt.Index);//������������
		//ds1.namevalue(ds1.rowposition,"n_educ_yn")="2";	//��������(==2)		
	}
	<%//����� (�׸��庰)--------------------------------------------%>
	function fnDeleteRow() {
		ds1.DeleteRow(ds1.RowPosition);
	}
	<%//���� --------------------------------------------%>
	function fnApply() {
		if (ds1.IsUpdated) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,sDrp_n_job_gu="+drp_n_job_gu.ValueOfIndex("detail", drp_n_job_gu.Index)
                + ",sClientSid="+txt_client_cd.value
                );
        		tr_post(tr1);
		}	
	}
	<%//���--------------------------------------------%>
	function fnCancel() {
	 	ds1.UndoAll();
	}
		
	<%//�μ� (������)--------------------------------------------%>
	function fnPrintDs1() {
	
	}
	<%//���� (������)--------------------------------------------%>
	function fnExcelDs1() {

	}

	<%// �ο� �˾� : �ο� �׸��忡�� --------------------------------------------%>
	function fnCustPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv004h.jsp?sClientSid="+txt_client_sid.value;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	   		ds1.namevalue(ds1.rowposition,"cust_sid") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition,"cust_nm") = arrParam[1];
	   		ds1.namevalue(ds1.rowposition, "manage_no") = arrParam[2];
	   		
	   		for (row2 = 1; row2 < ds1.countrow; row2++) {
   				if (ds1.namevalue(row2,"cust_sid") == arrParam[0]) {
   					alert("�ο��� �ߺ� ����Ҽ� �����ϴ�!");
		   			ds1.namevalue(ds1.rowposition,"cust_sid") = "";
			   		ds1.namevalue(ds1.rowposition,"cust_nm") = "";
			   		ds1.namevalue(ds1.rowposition, "manage_no") = "";
	   		
   					return;
   				}
   			}
		} else {
   			ds1.namevalue(ds1.rowposition,"cust_sid") = "";
	   		ds1.namevalue(ds1.rowposition,"cust_nm") = "";
	   		ds1.namevalue(ds1.rowposition, "manage_no") = "";
		}				
	}			 	 

	<%// Description :  �Է°� üũ --------------------------------------------%>
	function fnCheck() {
	}
	<%// Description :  ȭ�ϸ� üũ --------------------------------------------%>
	function fnDivide(str, delim){
	}

	<%// Description :  ���¾�ü�ڵ� Help --------------------------------------------%>
    function fnClientSidPopup() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
            
        strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=2";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");        
            txt_client_sid.value= arrParam[0];
            txt_client_nm.value= arrParam[1];
            txt_client_cd.value = arrParam[2];
          	fnSelectDs13();
        } else {

        }       
    }
    
	<%//2010-04-16 ��߱� ��û�� ���ε�â ------------------------------------------%>
	function fnUploadPop_again(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/again_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}
    
    
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
==============================��===============================================*/
%>

<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
	if (Row != 0 && Colid=="cust_nm") {
		fnCustPopup();
	}
	
    if(Row==0) {	//�������� Ŭ��������.
    
        if(ds1.CountRow<=1) return;
        gr1.Redraw = "False";
        
        //��������							�۾�����									��������
        if(Colid=="n_educ_yn" || Colid=="visit_object_cd" || Colid=="n_job_gu"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        gr1.Redraw = "True";
        return;
    }
	
//	if (colid=="n_card_no") {
//		fnNcardPopup();
//	}		                              
//    if (colid=="room_type_cd") {		
//		fnRoomTypePopup();
//	}
/*
	var flag = ds1.namevalue(Row,"n_educ_yn");
	//������ üũ�ϸ� ���� ������ �Էµǰ�
	if(Colid=="job_sel") {
		if(ds1.namevalue(Row,"job_sel")=="T") {	//�����̸�
			ds1.namevalue(Row,"req_dt")=txt_req_dt.text;	//��û����
			ds1.namevalue(Row,"educ_plan_dt")=txt_educ_plan_dt.ValueOfIndex("title_nm",txt_educ_plan_dt.Index);//������������
			ds1.namevalue(Row,"saup_sid")=drp_saup_sid.ValueOfIndex ("saup_sid", drp_saup_sid.Index);//����
			ds1.namevalue(Row,"n_job_gu")=drp_n_job_gu.ValueOfIndex ("detail", drp_n_job_gu.Index);//�۾�����
			ds1.namevalue(Row,"n_educ_yn")="2";	//��������(==2)
			ds1.namevalue(Row,"visit_object_cd")="01";	//��ϸ�������
			ds1.namevalue(Row,"visit_object")= getObjectFirst("txt_visit_object").value ;	//��ϸ�������
		} else {
			if (ds1.namevalue(Row,"n_educ_yn")=="2") {
				ds1.namevalue(Row,"educ_plan_dt")="";
				ds1.namevalue(Row,"saup_sid")="";
				ds1.namevalue(Row,"req_dt")="";
				ds1.namevalue(Row,"n_job_gu")="";
				ds1.namevalue(Row,"n_educ_yn")="1";	//�̱���(==1)
				ds1.namevalue(Row,"visit_object_cd")="";	//��ϸ�������
				ds1.namevalue(Row,"visit_object")="";
			} else {
				 ds1.Undo(ds1.RowPosition);
			}
		};
	};*/
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<script language="javascript" for="tr1" event="OnSuccess()">
    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);        
</script>
<script language="javascript" for="tr1" event="OnFail()">
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>
<script language="javascript" for="tr2" event="OnSuccess()">
    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr2.SrvErrMsg("INFO", i);
    }
    if(info_msg!="") 
        window.status="============= �ȳ� �޽���=============" + info_msg;
</script>
<script language="javascript" for="tr2" event="OnFail()">
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        window.status="�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�." + error_msg;
    else
        window.status="Error Code : " + tr2.ErrorCode + ", Error Message : " + tr2.ErrorMsg;
</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	
	</script> 
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();    
	    if(v_job == "H") return; //fnInit();
	    if( row < 1){
	       window.status = "��ȸ�� ������ �����ϴ�."; 
	    }
	    else
	    	window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
	    gr1.ReDraw = "True";
	</script>
	<script language=JavaScript  for=ds1 event="OnLoadError()">
	</script>
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
        photo.src  = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO_FULL").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO_FULL")+"_��߱�.JPG";

	</script>
	
	
	<script language=JavaScript  for=ds2 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds2 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>    
	<script language=JavaScript  for=ds3 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>
	<script language=JavaScript  for=ds5 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
	    if(ds5.namevalue(ds5.rowposition,"client_nm")!=undefined) {
	    	txt_client_sid.value=ds5.namevalue(ds5.rowposition,"client_sid");
	    	txt_client_nm.value=ds5.namevalue(ds5.rowposition,"client_nm");
	    }
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
		fnSelectDs13();
	</script>
	<script language=JavaScript  for=ds5 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- ���¾�ü�ڵ� Ű����˻� -->
	<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- ���¾�ü�ڵ� �˻� -->
	<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- ��ϸ������� -->
	<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- ����(�׸����) -->
	<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- ��ϱ��� ��û�� -->
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width=845 align="right" height="25px">
			<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">					<!-- ��ȸ -->
			<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" align=absmiddle onClick="fnAddRow()" >				<!-- ���߰� -->
			<img src="<%=dirPath%>/Sales/images/minus.gif" 	style="cursor:hand" align=absmiddle onClick="fnDeleteRow()" >		<!-- ����� -->
			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">					<!-- ���� -->
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">&nbsp;&nbsp;<td>			<!-- ��� -->
	</tr>
	<tr>
		<td>
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="840px">
				<tr height=25px>
					<td width=20px align=center rowspan=2 bgcolor="#303030" style="color:#ffffff;weight:heavy;">��<br>��</td>
					<td align="center" width="100px" class="text">���¾�ü�ڵ�</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<input id="txt_client_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:1px;width:40px; height:18px" maxlength="10" onchange="txt_client_sid.value='',txt_client_nm.value=''" onblur="fnSelectDs11()" onkeyup="this.value=this.value.toUpperCase()">
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="���¾�ü�� �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="fnClientSidPopup();">
						<input id="txt_client_nm" type="text" class="boardt04"  style= "position:relative;left:0px;top:3px;color:black;width:100px; height:20px;" maxlength="50" readonly>
						<input id="txt_client_sid" type="hidden">
					</td>
					<td align="center" width="100px" class="text">��������</td>
					<td bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
	                    <object id=drp_visit_object classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
						<param name=ComboDataID     value=ds8>
						<param name=SearchColumn    value="detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^140">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>					
				</tr>
				<tr height="25px">
					<td align="center" width="100px" class="text">����</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<input type="text" name="txt_cust_nm" size="15" maxlength="30" class="textbox"></td>
					<td align="center" width="100px" class="text">�ֹ�/���ǹ�ȣ</td>
					<td align="left" bgcolor="#ffffff" colspan=3>&nbsp;
						<input type="text" name="txt_manage_no" size="15" maxlength="20" class="textbox" onkeyup="this.value=this.value.toUpperCase()"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="5px">
		<td></td>										
	</tr>
	<tr>
		<td valign="top">
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="840px">
				<tr height=25px>
					<td width=20px align=center rowspan=2 bgcolor="#303030" style="color:#ffffff;weight:heavy;">��<br>��</td>
					<td align="center" width="100px" class="text">��û����</td>
					<td bgcolor="#ffffff">&nbsp;
					<%=HDConstant.COMMENT_START%>
 					<object id=txt_req_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style= "position:relative;left:0px;top:1px;width:70px; height:18px"  align='absmiddle' class='textbox'>            
  						<param name=Format      value="YYYY-MM-DD">
   						<PARAM NAME=InputFormat value="YYYYMMDD">
   						<param name=Alignment   value=1>
   						<param name=ClipMode    value=true>
 						<param name=Border      value=false>
 						<param name=readonly   value=true>
 					</object>
 					<%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" width="100px" class="text" >����۾�����</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
	                    <object id=drp_n_job_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
	                        <param name=ComboDataID     value=ds2>
	                        <param name=SearchColumn    value="detail_nm">
	                        <param name=ListExprFormat  value="detail_nm^0^100">
	                        <param name=Enable  value="true">
	                    </object>
	                    <%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" width="100px" class="text">����</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds9>
                        	<param name=SearchColumn    value="saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^150">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
				</tr>
				<tr height='25px'>
					<td align="center" width="100px" class="text">��������</td>
					<td bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
	                    <object id=drp_visit_object1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
						<param name=ComboDataID     value=ds8>
						<param name=SearchColumn    value="detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^140">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>					
	    			<td align="center" width="100px" class="text">��ϸ���</td>
					<td bgcolor='#ffffff' colspan=3>&nbsp;
	                    <input type=text id=txt_visit_object maxlength=32 class="textbox" OnKeyUp="cfLengthCheck(this, 32);" style="width:150px">
	                </td>
				</tr>		
			</table>
		</td>
	</tr>
	<tr height="5px">
		<td></td>										
	</tr>
	<tr>
		<td width="100%">
			<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
				<tr>
					<td  valign="top">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width=710>
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=710px; height:300px" border="1">
									    <param name="DataID"            value="ds1">
									    <param name="BorderStyle"       value="0">
									    <param name="ColSizing"         value="true">
									    <param name="editable"          value="true">
									    <param name=UsingOneClick  		value="1">
									    <param name=ViewSummary  		value="1">
                                        <param name="Format"            value=" 
                                            <FC> name='��ü��'			ID='client_nm'      Width=60 align=left edit=none</FC>
                                            <FC> name='����'			ID='cust_nm'        Width=60 align=left editstyle=popup sumtext=�� BgColor=#fefec0</FC>
									        <FC> name='�ֹ�/���ǹ�ȣ'	ID='manage_no'      Width=80  align=left edit=none sumtext=@cnt</FC>
                                            <C> name='��û����'			ID='req_dt'         Width=80 	align=center mask=XXXX-XX-XX edit=none</C>
									        <C> name='����'           	ID='saup_sid'       Width=50  align=left editstyle=lookup data='ds9:saup_sid:saup_nm' BgColor=#fefec0</C>
									        <C> name='�۾�����'			ID='n_job_gu'    	Width=90  align=center editstyle=lookup data='ds2:detail:detail_nm' edit=none</C>
                                            <C> name='�������С�'		ID='visit_object_cd'	Width=100  align=center editstyle=Lookup data='ds8:detail:detail_nm' BgColor=#fefec0</C>
                                            <C> name='��ϸ���'			ID='visit_object'	Width=120  	align=Left edit=true BgColor=#fefec0</C>
                                            <C> name='����'				ID='remarks'		Width=120  	align=Left edit=true BgColor=#fefec0</C>
                                            <C> name='educ_card_sid'	ID='educ_card_sid'	Width=120  	align=Left edit=true show=false</C>
                                            <C> name='cust_sid'			ID='cust_sid'		Width=120  	align=Left edit=true show=false</C>
									    ">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
								<td valign=top width=130 align=center><!-- �߰�ǥ 2010-04-16 -->
								
					<table border="0" cellpadding="0" cellspacing="1" width="103px" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_again()" style="cursor:hand">��߱�<br>��û��</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="113px"></td>
					  </tr>
					</table>
					
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>