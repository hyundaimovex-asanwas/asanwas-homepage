<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ����_��������
 * ���α׷�ID 	 : PMS/PU160I
 * J  S  P		 	 : pu160i.jsp
 * �� �� ��		 : Pu160I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-11-24
 * �������		 : ����_��������
 * [ �������� ][������] ����
 * [2011-11-24][�ڰ汹] �ű�
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
     <script language=javascript src="<%=dirPath%>/Pms/common/js/common_pop.js"></script>
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
		cfStyleGrid(getObjectFirst("gr_est"), "comn");
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
       
        v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//�۾�����(��ȸ)
       
       ds_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_rqst_status.Reset();	//�۾�����
        
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//���ó
      
      
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_EST=ds_est,O:DS_TENDER=ds_tender,O:DS_DETAIL=ds_detail)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    <%//���� ��ȸ  %>
    function fnSelect() {
    
    	//alert("1");
		if (ds_default.IsUpdated || ds_tender.IsUpdated|| ds_detail.IsUpdated) {
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
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	        tr_post(tr1);
		}
    }    
    
    <%//������ ��ȸ%>
    function fnSelectEst(row) {
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
            "JSP(O:DS_EST=ds_est)",
            v_param);
        tr_post(tr2);
    }

    <%//û��ǰ�� ��ȸ%>
    function fnSelectDetail(row) {
        v_est_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_est").NameValue(row, "RQST_SID")
                    + ",v_est_sid="+getObjectFirst("ds_est").NameValue(row, "EST_SID");                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
	    fnSelectDetail2(row);						    
    }

    <%//�������� ��ȸ%>
    function fnSelectDetail2(row) {
        v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_est_sid="+getObjectFirst("ds_tender").NameValue(row, "EST_SID")
                    + ",v_rqst_sid="+getObjectFirst("ds_tender").NameValue(row, "RQST_SID");
                  //  + ",v_item_sid="+getObjectFirst("ds_tender").NameValue(row, "ITEM_SID");
        //alert(v_param);            
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
    
    <%//�������� ��ȸ__�������� �Է��� ��ȸ%>
    function fnSelectDetail3(row) {
        v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_est_sid="+getObjectFirst("ds_detail").NameValue(row, "EST_SID")
                    + ",v_rqst_sid="+getObjectFirst("ds_detail").NameValue(row, "RQST_SID");
                  //  + ",v_item_sid="+getObjectFirst("ds_tender").NameValue(row, "ITEM_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
    
    <%//�����ݾ׳��� ��ȸ__�����ݾ׳��� �Է��� ��ȸ%>
    function fnSelectDetail4(row) {
        v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_est_sid="+getObjectFirst("ds_detail").NameValue(row, "EST_SID")
                    + ",v_rqst_sid="+getObjectFirst("ds_detail").NameValue(row, "RQST_SID");
                  //  + ",v_item_sid="+getObjectFirst("ds_tender").NameValue(row, "ITEM_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
		
		//alert(ds_detail.CountRow);
		//�����ݾ� �ڵ���� ��ũ��Ʈó��
        for( i=1;i<=ds_detail.CountRow;i++ ) {
        	ds_detail.NameValue(i, "UD_EST_AMT") = 	ds_detail.NameValue(i, "TOT_FN_EST_AMT") - ds_detail.NameValue(i, "TOT_EST_AMT");	
        	ds_detail.NameValue(i, "UDRATE_EST_AMT") = 	ds_detail.NameValue(i, "UD_EST_AMT")/ds_detail.NameValue(i, "TOT_EST_AMT")*100;	
		}
    }

	<%//���� %>
	function fnApply(){
		v_job = "A";
		var checkDiv='';	
		var checkCY=1; 
		
		for( i=1;i<=ds_detail.CountRow;i++ ) {
			if (ds_detail.namevalue(i,"CHOICE_YN") == 'T' ) {
								checkDiv='true';
								break;
			}
		}
		if ( checkDiv != 'true' ) { 
			alert("��� �ϳ��� ���»縦 �����ϼž� �մϴ�."); 
			return;
	 	} 				
				
		if ( ds_detail.CountRow==0 ) { 
			alert("��� �ϳ��� ���������� �Է��ϼž� �մϴ�."); 
			return;
	 	} 	


		for( j=1;j<=ds_detail.CountRow;i++ ) {
			if (ds_detail.namevalue(i,"CHOICE_YN") == 'T' ) {
								checkCY = checkCY+1;
								break;
			}
		}
		if ( checkCY != 2 ) { 
			alert("���¾�ü ������ �ϳ��̾�� �մϴ�."); 
			return;
	 	} 	
		
		
		if (ds_default.IsUpdated	||	ds_tender.IsUpdated	||	ds_detail.IsUpdated) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu160I",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_TENDER=ds_tender,I:DS_DETAIL=ds_detail)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
    	}else
     		alert("������Ʈ�� ���� �����ϴ�.");
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

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
	
	 /*
	 * ���������˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnESTAMTPopup(Row) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			
			strURL = "<%=dirPath%>/Pms/help/pu060h_01.jsp";
			strPos = "dialogWidth:1000px;dialogHeight:500px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,window,strPos);	
			//ds_detail.Reset();
			fnSelectDetail3(Row);
	} 	
	
	 /*
	 * �����ݾ��˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnFNESTAMTPopup(Row) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			
			strURL = "<%=dirPath%>/Pms/help/pu060h_02.jsp";
			strPos = "dialogWidth:1000px;dialogHeight:500px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,window,strPos);	
			//ds_detail.Reset();
			fnSettle(Row);
			//fnSelectDetail3(Row);
	} 	
	
	//ó����ư : ������ ����� ȭ�鿡 �����ش�.
	function fnSettle(Row) {
	//alert("fnSettle");
		fnSelectDetail4(Row);
		//ds_detail.NameValue(Row, "UD_EST_AMT") = 	ds_detail.NameValue(Row, "TOT_FN_EST_AMT") - ds_detail.NameValue(Row, "TOT_EST_AMT");
	}
	
	function fnExcel() {
			if(ds_default.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr_default").SetExcelTitle(0, "");
	        getObjectFirst("gr_default").SetExcelTitle(1, "value:�����Ƿڼ�; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_default").GridToExcel("�����Ƿڼ�","�����Ƿڼ�.xls", 8);

			if(ds_est.RowCount==0){
	            return;
	        }
	        getObjectFirst("gr_est").SetExcelTitle(0, "");
	        getObjectFirst("gr_est").SetExcelTitle(1, "value:������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_est").GridToExcel("������","������.xls", 8);
	        
	        if(ds_tender.RowCount==0){
	            return;
	        }
	        
	        getObjectFirst("gr_tender").SetExcelTitle(0, "");
	        getObjectFirst("gr_tender").SetExcelTitle(1, "value:û��ǰ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_tender").GridToExcel("û��ǰ��","û��ǰ��.xls", 8);
	        
	         if(ds_detail.RowCount==0){
	            return;
	        } 
	        getObjectFirst("gr_detail").SetExcelTitle(0, "");
	        getObjectFirst("gr_detail").SetExcelTitle(1, "value:��������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_detail").GridToExcel("��������","��������.xls", 8);
	}	 	 
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%//û������ Ŭ���� ������ ��ȸ %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		//v_job="SD";
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("��������  �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			return false;
		} else {
//		    var row2=ds_tender.countrow;
//		    if(Row==0) return;
//		    if(v_default_row==Row){
//				return;
//			}else{
			    fnSelectEst(Row);				
//		    }
		};
	</script>
<%//������ Ŭ���� û��ǰ�� ��ȸ %>
	<script language=javascript for="gr_est" event="OnClick(Row, Colid)">
		//v_job="SD";
		if (ds_default.IsUpdated || ds_est.IsUpdated) {
			alert("��������  �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			return false;
		} else {
		    var row2=ds_est.countrow;
		    if(row2==0) return;
		    
		     fnSelectDetail(Row);				
		}
	</script>
	<%//û��ǰ��  Ŭ���� û��ǰ�� ��ȸ %>
	<script language=javascript for="gr_tender" event="OnClick(Row, Colid)">
		//v_job="SD";
		if (ds_default.IsUpdated || ds_est.IsUpdated) {
			alert("��������  �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			return false;
		} else {
		    var row2=ds_est.countrow;
		    if(row2==0) return;
		    
		     fnSelectDetail2(Row);				
		}
	</script>
	<script language=javascript for=gr_detail event="OnExit(Row,Colid,OldData)">
	//    if(Row==0) return;
	//    if(Colid=="TOT_FN_EST_AMT"){
	//       	ds_detail.NameValue(Row, "UD_EST_AMT") = 	ds_detail.NameValue(Row, "TOT_FN_EST_AMT") - ds_detail.NameValue(Row, "TOT_EST_AMT");
	//   	}else{return;}
	</script>
	
	<script language="javascript"  for=gr_tender event=OnClick(Row,Colid)>
    if(Row==0) {	//�������� Ŭ��������.
        if(ds_tender.CountRow<=1) return;
        gr_tender.Redraw = "False";
      
        //���� 
        if(Colid=="USE_YN"){
            for(var i=2; i<=ds_tender.CountRow; i++){
                ds_tender.NameValue(i, Colid) = ds_tender.NameValue(1, Colid);
            }
        }
        gr_tender.Redraw = "True";
        return;
    }
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		//gr_default.ReDraw();
		//gr_tender.ReDraw();
		//gr_detail.ReDraw();
	}
	if(v_job=="S"){
		alert("��ȸ�� �Ϸ�Ǿ����ϴ�.");
	}
</script>

<script language=JavaScript for=tr1 event=OnFail()>
	if(v_job=="A"){
		alert("�����۾� �� ������ �߻��߽��ϴ�.");
	}
	if(v_job=="S"){
		alert("��ȸ�۾� �� ������ �߻��߽��ϴ�.");
	}

</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
 
	<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
		if (colid=="TOT_EST_AMT") {
			fnESTAMTPopup(row);
		}else if (colid=="TOT_FN_EST_AMT") {
			fnFNESTAMTPopup(row);
		}
	</script>    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_est classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_tender classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
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
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<!--<img src="<%=dirPath%>/Sales/images/settle.gif" 	style="cursor:pointer"  onClick="fnSettle();">-->
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">		<!-- ���� -->
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
            <td align=right>
				<b>[û����]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='103px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="0">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='�۾�����'	ID='RQST_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='�۾�����'	ID='RQST_STATUS_NM'    	width=80 	align=CENTER	Edit=None	show=true</C>
                                     <C> name='����' 		ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='û����ȣ'	ID='RQST_NO' 			width=120 align=CENTER	Edit=None		</C>
                                     <C> name='����SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		show=false	decao=0	Edit=None </C>
                                     <C> name='û��SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 		show=false 	decao=0	Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='�����ڵ�'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='��������'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='�����'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='����SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='���ó'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None		show=false</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">�۾�����</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_status>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=ReadOnly    value="true">											
											<param name="Editable"          value="false">											
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^80">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
										<td width="120px" class="text">���ó</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_use>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="true">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>	
								<tr height="21px">
									<td width="120px" class="text">û������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="true">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                                <param name=Enable  value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">û����ȣ</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr>
									<td width="120px" class="text">�����ڵ�</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_site_cd' id="v_pu_site_cd" style="width:100px;" class='input01' readOnly="readonly"> </td>
									<td width="120px" class="text">��������</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_empno' id="v_pu_empno" style="width:100px;" class='input01' readOnly="readonly" > </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
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
            <td align=right>
				<b>[������]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_est" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='80px' border='1'>
                    <param name="DataID"            value="ds_est">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="false">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='����SID(�ý��� ������ȣ)' 			ID='EST_SID'	   		width=200 		align=CENTER	edit=none show=false</C>
                         <C> name='û��SID(�ý��� ������ȣ)' 		ID='RQST_SID'   		width=200 		align=CENTER	edit=none show=false</C>
                         <C> name='������ ����'     	    ID=CurRow   	        width=200	    align=center  show=true edit=none Value={CurRow}</ </C>
                         <C> name='��������ڻ��' 		ID='EST_EMPNO'   		width=100 		align=CENTER	editlimit=7 edit=false show=true</C>
                         <C> name='������������'	 		ID='DATE_TO'   			width=100 		align=CENTER	editlimit=8	edit=false show=true</C>
                         <C> name='����Ư�����' 			ID='EST_MEMO'   		width=400 		align=CENTER	edit=false show=true</C>                                                  
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
         <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
        	<td align=right>
        	<b>[û��ǰ��]</b>
        	</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='200px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="ViewSummary"       value="1">
                    <param name="Format"            value="
	                     <C> name='����V' 				ID='USE_YN'    		edit=true		width=50 		align=LEFT	editstyle=checkbox </C>
	                     <C> name='EST_SID' 			ID='EST_SID'   			width=80 		align=CENTER	edit=none show=false</C>
                         <C> name='RQST_SID' 		ID='RQST_SID'   		width=80 		align=CENTER	edit=none  show=false</C>
                         <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=80 		align=CENTER	edit=none  show=false</C>
                         <C> name='ǰ��' 				ID='ITEM_NM'    		width=150 	align=CENTER	 edit=none</C>
                         <C> name='�԰�' 				ID='ITEM_SIZE'   		width=150 		align=CENTER	 edit=none</C>
                         <C> name='����' 				ID='ITEM_UNIT'   		width=60 		align=CENTER	edit=none </C>
                         <C> name='����' 				ID='RQST_CNT'   		width=60 		align=CENTER	 edit=none</C>
                         <C> name='�뵵' 				ID='RQST_USE'    	width=150 	align=CENTER	 edit=none show=false</C>
						<G> name='����'                         
                         <C> name='�ܰ�'    		ID='DG_AMT'    	    width=85 		align=CENTER	 show=true decao=0	edit=none	sumtext='��'  sumtextalign='right'  </C>
                         <C> name='�ݾ�'   			ID='DG_SUM_AMT'   width=85 		align=CENTER	 show=true edit=none	decao=0	sumtext='@sum' sumtextalign='right'  </C>
                         <G> name='����'
                         <C> name='�ܰ�' 			ID='YS_AMT'   			width=85 		align=CENTER	 decao=0 edit=none	 sumtext='��'  sumtextalign='left'</C>
                         <C> name='�ݾ�'    			ID='YS_SUM_AMT'    width=85 		align=CENTER	 show=true edit=none	decao=0	 sumtext='@sum' sumtextalign='right'</C>
                         </G>
                         <C> name='�ҿ���' 				ID='DATE_USE'    	width=80 		align=CENTER	 edit=none	sumtext='��'  sumtextalign='left'</C>
                         <C> name='û�����' 				ID='RQST_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>
                         <C> name='�������' 				ID='EST_ITEM_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>                         
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
		<tr>
            <td align=right>
				<b>[��������]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_detail" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='150px' border='1'>
                    <param name="DataID"            value="ds_detail">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
	                     <C> name='����YN(3)' 			ID='CHOICE_YN'    		edit=true	width=80 		 show=true align=LEFT	editstyle=checkbox 	bgColor=<%=HDConstant.GRID_ITEM%> </C>
                         <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none  show=false</C>
                         <C> name='�ŷ�ó�ڵ�' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false</C>
                         <C> name='���»��' 			ID='VEND_NM'    		width=150 	align=CENTER	edit=none</C>
                         <C> name='�����ݾ�(1)'			ID='TOT_EST_AMT'  width=150 		align=right 	 decao=0   	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='�����ݾ�(2)'		ID='TOT_FN_EST_AMT'  	width=150 		align=right 	 decao=0	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='������(�ڵ�)'				ID='UD_EST_AMT'  	width=150 		align=right 	 decao=0 edit=none</C>                                                  
                         <C> name='ǰ������(4)'			ID='DATE_CON' 	 	width=90 		align=right 	show=false  editlimit=8 bgColor=<%=HDConstant.GRID_ITEM%></C>   
                         <C> name='��������(%�ڵ�)'				ID='UDRATE_EST_AMT'  	width=100 		align=right 	 decao=0 edit=none</C>                                                  
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>

              
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
					<C>Col=RQST_STATUS_NM	 Ctrl=v_rqst_status_nm        	 Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 Param=value </C>
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     Param=Value </C>
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     Param=value </C>
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   	 Param=value </C>
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		