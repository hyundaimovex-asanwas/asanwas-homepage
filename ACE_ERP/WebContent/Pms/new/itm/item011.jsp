<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ����_û������
 * ���α׷�ID 	 : PMS/PU020I
 * J  S  P		 	 : pu020i.jsp
 * �� �� ��		 : Pu020I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-11-21
 * �������		 : ����_û������
 * [ �������� ][������] ����
 * [2011-11-21][�ڰ汹] �ű�
 * [2012-10-23][�ɵ���] ���̺� ���޼���(DG_CNT) �÷� �߰�
 *						���� RQST_CNT = û������(=�������)
 * [2013-11-26][�ڰ汹] 13 �籸��-���� ����
 * [2014-06-09][�ڰ汹] ���缱 ���� â ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
       
        v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

       	//alert("1");

       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//�۾�����(��ȸ)
       
       ds_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_rqst_status.Reset();	//�۾�����
        
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//���ó
       
       ds_rqst_seq.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU008&s_item1=Y";
       ds_rqst_seq.Reset();	//��ü����
      
      ds_put_wh.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU003&s_item1=Y";
       ds_put_wh.Reset();	//����â��
       //alert("2");
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender)",
            "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1");
        tr_post(tr1);
        //alert("3");
    }
    
    <%//���� ��ȸ  %>
    function fnSelect() {
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";
		    
	        var fr_date = v_fr_rqst_date.Text.trim();
	        var to_date = v_to_rqst_date.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("û������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("û������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    	
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_fr_rqst_date=" + fr_date
	                  + ",v_to_rqst_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        
	        //÷������ �ɰ���
	        var real_fileList="";
			var sys_fileList="";
				
			var real_fileList =txt_real_file.value;
			var sys_fileList =txt_sys_file.value;
		
			var real_file10= new Array();
			var sys_file10= new Array();
		
			real_file10 = real_fileList.split(":");	//�迭�� ����
			sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
			var real_file1=real_file10.slice(0,1);
			var sys_file1=sys_file10.slice(0,1);	
			var real_file2=real_file10.slice(1,2);
			var sys_file2=sys_file10.slice(1,2);	
			var real_file3=real_file10.slice(2,3);
			var sys_file3=sys_file10.slice(2,3);	
		};
    }    

    <%//������ ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID");
        
        //alert(v_param);            
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
    }

	<%//���� %>
	function fnApply(){
		v_job = "A";
		
		var row=ds_default.countRow;
			
		if (ds_default.IsUpdated) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
                "JSP(I:DS_DEFAULT=ds_default)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
    	}else if(ds_tender.IsUpdated)
    	{
    	 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
                "JSP(I:DS_TENDER=ds_tender)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        }else
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}

	/******************************************************************************
		Description : ���缱  popup
	******************************************************************************/
	
	function fnApproval() {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;
		//strURL = "<%=dirPath%>/Config/help/sy040h.jsp";
		//strPos = "dialogWidth:620px;dialogHeight:500px;status:no;scroll:no;resizable:no";

		 strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
		strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);
		//alert("arrResult===========");
		//alert(arrResult);
		sApproveLine = arrResult; // ru
		//alert("sApproveLine==========");
		//	alert(sApproveLine);
	}
	
	/******************************************************************************
		Description : ���  popup
	******************************************************************************/
	function fnDraft() {
	
		if(ds_default.CountRow ==0){
			alert("��� �� ������ ��ȸ �� �ּ���");
			return;
		}
		
		if(sApproveLine==""||sApproveLine=="undefined"){
		   alert("���缱������ ���� �ʾҽ��ϴ�.");
		   return;
		}
		
		var result="";
	    var arrParam	= new Array();
	    var arrResult	= new Array();
		//alert(sApproveLine);	
		arrParam[0]="320";  // AP006 ( 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û .310 ����û��, 320 ����û������, 330 ����ǰ��)
		arrParam[1]=ds_default.namevalue(ds_default.rowposition,"RQST_SID");  //û��SID
		arrParam[2]=sApproveLine;      // ���缱���� 
		
		
		strURL = "<%=dirPath%>/Pms/help/pu020h.jsp?";
		strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
		      
		if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
		} 
	}  

	<%//�׼� �ٿ�ε� %>
    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:����û����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("����û����", "����û����.xls", 8);        
    }
    
	<%//���ް��� ��- ��ȸ%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnCtSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    
	<%//���� ��- �Է�%>
    function fnSelSitePopup1(dirPath) {
        if(ds_default.CountRow==0){
            alert("�ű� ��ư���� �� ���� �߰��Ͻñ� �ٶ��ϴ�.");
            return;
        }

        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtSitePop1(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_site_sid1.value = arrParam[0];//SITE_SID //
			v_rqst_date.text = arrParam[1];//DATE_CT //
			v_site_nm1.value = arrParam[2];//SITE_NM //
			//v_orderer_sid.value = arrParam[3];//ORDERER_SID //
			//v_orderer_nm.value = arrParam[4];//ORDERER_NM //
			// = arrParam[5]; //SITE_SEQ_CT_CD //
			// = arrParam[6]; //SITE_SEQ_CH_CD //
			//v_site_seq_ct.value = arrParam[7]; //SITE_SEQ_CT //
			//v_site_seq_ch.value = arrParam[8]; //SITE_SEQ_CH //
			//v_amt_ct_tot.text = arrParam[9]; //AMT_CT_TOT //
			//v_amt_ct.text = arrParam[10]; //AMT_CT //
			//v_amt_ct_vat.text = arrParam[11]; //AMT_CT_VAT //
			//v_ct_date_begin.text = arrParam[12]; //DATE_BEGIN //
			//v_ct_date_end.text = arrParam[13]; //DATE_END //

        } else {
			fnSelSiteCleanup1();
        }               
    }
	function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    function fnSelSiteCleanup1(){
        v_site_nm1.value = "";
        v_site_sid1.value  = "";
    }

	<%// ������ �ű� %>
	function fnAddRowDsDefault(){
		if(ds_tender.IsUpdated) {
			alert("�������� ���� ������ �ű� û�������� ������ �� �����ϴ�.");
			return;
		}else {
			v_job="N";
			ds_default.addrow();
			ds_tender.clearall();
			v_rqst_date.text="<%=DateUtil.getCurrentDate(8)%>";
			lc_rqst_status.index = 0;			
			
			v_rqst_date.focus();
			
			return;
		}
	}

	<%// ������ ���� %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("�������� �۾��� �־� ������ �� �����ϴ�.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};

	<%//������ ���߰� %>
	function fnAddRowDs2() {
		if (ds_default.namevalue(ds_default.rowposition,"RQST_SID") == undefined || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == "" || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == 0 ) {
			alert("û�������� ��ȸ/���� �� �߰��� �ּ���.");
		} else {
			ds_tender.addrow();
			ds_tender.namevalue(ds_tender.RowPosition, "RQST_SID") = ds_default.namevalue(ds_default.rowposition,"RQST_SID");
			
			msgTxt.innerHTML="û��ǰ�� ���� ���ԵǾ����ϴ�.";
		}
	}

	<%//������ ����� %>
	function fnDeleteRowDs2(){
		ds_tender.deleterow(ds_tender.rowposition);
		msgTxt.innerHTML="û��ǰ�� ���� �����Ǿ����ϴ�.";
	}

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
	
	/*
	* ǰ�� �˾� : �� �׸��忡�� 
	*/
	function fnITEMPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Pms/help/pu001h_01.jsp"
		strPos = "dialogWidth:570px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_SID") = arrParam[0];
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_NM") = arrParam[1];
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_SIZE") = arrParam[2];
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_UNIT") = arrParam[3];
		} else {
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_SID") = "";
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_NM") = "";
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_SIZE") = "";
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_UNIT") = "";			
   		}				
	}			 	 

	function fnExcel() {
  	
	        getObjectFirst("gr_tender").SetExcelTitle(0, "");
	        getObjectFirst("gr_tender").GridToExcel("Sheet2","����û���⺻����.xls", 32);   
	        
	        getObjectFirst("gr_default").SetExcelTitle(0, "");
	        getObjectFirst("gr_default").GridToExcel("Sheet1","ǰ������.xls", 32);   
    }	
         
  //÷������(1) �ٿ�ε�_����
    function fnFile(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
				
		if(real_file1==''){
			alert("÷�������� �������� �ʽ��ϴ�")
			return;
		}else if(real_file1.length==1){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //����

		}

	}
	//÷������(2) �ٿ�ε�_����
    function fnFile2(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	

		//alert(real_file2);				
		//alert(sys_file2);						
		//alert(real_file2.length);
		
		if(real_file2.length==0){
		alert("2��° ������ �������� �ʽ��ϴ�")
		}
		if(real_file2.length>0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //����

		}
	}
	//÷������(3) �ٿ�ε�_����
    function fnFile3(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
		
		if(real_file3.length==0){
		alert("3��° ������ �������� �ʽ��ϴ�")
		}
		if(real_file3.length >0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //����
		}

	}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//û������ Ŭ���� û��ǰ�� ��ȸ %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("��������  �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			return false;
		} else {
		    var row2=ds_tender.countrow;
		    if(Row==0) return;
		    if(v_default_row==Row){
				return;
			}else{
			    fnSelectDetail(Row);				
		    }
		};
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>
alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_tender.clearall();
			}else{
				fnSelectDetail(v_default_row);
			}
		}
	</script>
	<script language=JavaScript for=gr_tender event=OnPopup(row,colid,data)>
		if (colid=="ITEM_NM") {
			fnITEMPopup();
		}
	</script>    
	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_tender classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ȸ: �۾����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �۾����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ó -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_seq classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--��ü����-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_put_wh classid=<%=HDConstant.CT_DATASET_CLSID%>><!--  ����â�� -->
    <param name="SyncLoad"  value="False">
</object>
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                    	<td align=left >
							<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:pointer" onclick="fnApproval()">
							<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:pointer" onclick="fnDraft()">
						</td>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<!-- <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">-->
							<!-- <img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">-->		<!-- ���� -->
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
			                        <td align=left class="text"  width="70">û������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=v_to_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>
			                        <td align=left class="text">�۾�����</td>
			                        <td align=left bgcolor="#ffffff" WIDTH="220">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_srch_rqst_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_srch_rqst_status>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>			                        
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='233px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='�۾�����'	ID='RQST_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	</C>
                                     <C> name='�۾�����'	ID='RQST_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=true</C>
                                     <C> name='����' 		ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='û����ȣ'	ID='RQST_NO' 			width=120 align=CENTER	Edit=None	</C>
                                     <C> name='û��SID'    ID='RQST_SID'       		show=false width=60 	align=CENTER	Edit=None 		decao=0	Edit=None  sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='�����ڵ�'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=TRUE</C>
                                     <C> name='��������'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		</C>
                                     <C> name='�����'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None	</C>
                                     <C> name='����SID'    ID='SITE_SID'       			show=false width=60 	align=CENTER	Edit=None 		 </C>
                                     <C> name='���ó'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None	show=false</C>
                                     <C> name='��ü����'	ID='RQST_SEQ' 			width=120 align=CENTER	Edit=None show=false</C>                                     
                                     <C> name='��ü����'	ID='RQST_SEQ_NM' 	width=120 align=CENTER	Edit=None 	</C>   
                                     <C> name='real_file'	ID='real_file'    	width=100 	align=CENTER	Edit=None 	show=false	</C>
                                     <C> name='sys_file'	ID='sys_file'    	width=100 	align=CENTER	Edit=None 	show=false	</C>                                  
                                     <C> name='����Ư�����'	ID='RQSTAC_MEMO' 			width=120 align=CENTER	Edit=None show=true</C>                                     
                                     
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>�۾�����</b></font></td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_status>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
			                                <param name=Editable  value="false">											
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^80">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text"><font color="green"><b>��ü����</b></font></td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_seq classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_seq>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
			                                <param name=Editable  value="false">											
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^80">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>	
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>��������</b></font></td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_ac_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">  
			                                <param name=Enable  value=true>                                                                                                                                                                                                           
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">û������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">  
			                                <param name=Enable  value=false>                                                                                                                                                                                                           
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
								</tr>
								<tr>
									<td width="120px" class="text">�����ڵ�</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text"  edit='false' name='v_pu_site_cd' id="v_pu_site_cd" style="width:100px;" class='input01'  readOnly="readonly" > </td>
									<td width="120px" class="text">��������</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" edit='false' name='v_pu_empnm' id="v_pu_empnm" style="width:100px;" class='input01'  readOnly="readonly" > </td>
                                        <input type="hidden"  edit='false' name='v_pu_empno' id='v_pu_empno'>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  edit='false' name='v_site_sid1' id='v_site_sid1'>
                                     </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">���ó</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 class="input01" border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_use>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=ReadOnly    value="true">
											<param name=Editable  value="false">
											<param name=Enable  value=false>
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text">����â��</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_put_wh classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle class="input01" >
											<param name=ComboDataID     value=ds_put_wh>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
										<input type="hidden"  name='v_rqst_sid' id='v_rqst_sid'>
									</td>
								</tr>	
								<tr>
									<td width="120px" class="text">÷������</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;
                                        <input type="hidden"  name='txt_sys_file' id='txt_sys_file'>
                                        <input type="text" name='txt_real_file' id="txt_real_file" style="width:310px;" class='input01'   readOnly="readonly">
                                        <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='input01' value="(1)"  onclick="fnFile()" readOnly="readonly">
					                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='input01'   value="(2)" onclick="fnFile2()" readOnly="readonly">
					                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='input01'   value="(3)" onclick="fnFile3()" readOnly="readonly">
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">û��Ư�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_rqst_memo' id="v_rqst_memo" style="width:380px;" class='input01'  readOnly="readonly"  >
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>����Ư�����</b></font></td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_rqstac_memo' id="v_rqstac_memo" style="width:380px;" class='textbox'    >
                                    </td>
								</tr>
							</table>
							<iframe id="hiddenFrm" style="display:none"></iframe>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='250px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="false">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="ViewSummary"       value="1">
                    <param name="Format"            value="
                         <C> name='RQST_SID' 	ID='RQST_SID'   		width=40 		align=CENTER	 edit=none 	show=false </C>
                         <C> name='ITEM_SID' 	ID='ITEM_SID'   		width=40 		align=CENTER	 edit=none 	show=false </C>

	                     <C> name='����' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
                         <C> name='ǰ��' 		ID='ITEM_NM'    	width=150 	align=CENTER	 edit=none editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='�԰�' 		ID='ITEM_SIZE'   	width=150 	align=CENTER	 edit=none</C>
                         <C> name='����' 		ID='ITEM_UNIT'   	width=60 	align=CENTER	 edit=none	</C>
                        <G> name='����'
                         <C> name='����' 		ID='DG_CNT'   		width=60 	align=right	 edit=none</C>
                         <C> name='�ܰ�'    	ID='DG_AMT'    	    width=85 	align=right	  edit=none show=true decao=0	sumtext='��'  sumtextalign='right'  </C>
                         <C> name='�ݾ�'   		ID='DG_SUM_AMT'   	width=85 	align=right	 show=true edit=none	decao=0	 sumtext='@sum' sumtextalign='right'	 </C>
                        </G>
                        <G> name='����'
                         <C> name='����' 		ID='RQST_CNT'   	width=60 	align=right	 edit=none</C>
                         <C> name='�ܰ�' 		ID='YS_AMT'   		width=85 	align=right	  edit=none decao=0	sumtext='��'  sumtextalign='left'</C>
                         <C> name='�ݾ�'    	ID='YS_SUM_AMT'		width=85 	align=right	 show=true edit=none	decao=0	 sumtext='@sum' sumtextalign='right'	 </C>
                        </G>
                         <C> name='�뵵' 		ID='RQST_USE'    	width=150 	align=CENTER	 edit=none show=false</C>
                         <C> name='�ҿ���' 		ID='DATE_USE'    	width=80 	align=CENTER	 edit=none	sumtext='��'  sumtextalign='left'</C>
                         <C> name='���' 		ID='RQST_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
 		    </td>
        </tr>
 		<tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
        	<td>
                <b>�� ��������:</b> [�۾�����][��ü����][��������][����Ư�����] ���� ��
            </td>
         </tr>
    </table>

	
	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=RQST_STATUS     Ctrl=lc_rqst_status    Param=BindColVal </C>
					<C>Col=RQST_USE		     Ctrl=lc_rqst_use    Param=BindColVal </C>
					<C>Col=RQST_STATUS_NM	 Ctrl=v_rqst_status_nm        	 Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        Param=Text </C>
					<C>Col=AC_DATE       	 	 Ctrl=v_ac_date          Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 Param=value </C>
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     Param=Value </C>
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     Param=value </C>
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   	 Param=value </C>
					<C>Col=PU_EMPNM    	 	 Ctrl=v_pu_empnm   	 Param=value </C>
					<C>Col=RQST_SEQ     		 Ctrl=lc_rqst_seq   Param=BindColVal </C>
					<C>Col=RQST_SEQ_NM	 Ctrl=lc_rqst_seq_nm       Param=BindColVal </C>
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>
					<C>Col=RQST_MEMO 	 	 Ctrl=v_rqst_memo  	 Param=value </C>		
					<C>Col=RQSTAC_MEMO 	 	 Ctrl=v_rqstac_memo  	 Param=value </C>		
					<C>Col=PUT_WH			     Ctrl=lc_put_wh    Param=BindColVal </C>																		
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		