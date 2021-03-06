<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 구매_견적의뢰
 * 프로그램ID 	 : PMS/PU040I
 * J  S  P		 	 : pu040i.jsp
 * 서 블 릿		 : Pu040I
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2011-11-22
 * 기능정의		 : 구매_견적의뢰
 * [ 수정일자 ][수정자] 내용
 * [2011-11-22][박경국] 신규
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
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
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_est"), "comn");
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
    	//alert("1");
	    v_job ="I";
       
        v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //v_fr_rqst_date.Text = "20111114";
        //v_to_rqst_date.Text = "20111114";


       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//작업상태(조회)
       
       ds_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_rqst_status.Reset();	//작업상태
        
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//사용처
       
     //데이터셋 헤더 초기화 = 빈 조회
       ln_TRSetting(tr1, 
           "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
           "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender,O:DS_DETAIL=ds_detail)",
           "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
       tr_post(tr1);
       
	}
    
    <%//메인 조회  %>
    function fnSelect() {
    	//alert("2");
		if (ds_default.IsUpdated || ds_tender.IsUpdated|| ds_detail.IsUpdated) {
			alert("수정중인 행인 있습니다.");
		} else {
		    v_job="S";
		    
	        var fr_date = v_fr_rqst_date.Text.trim();
	        var to_date = v_to_rqst_date.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("청구일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("청구일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  //+ ",v_site_sid="+ v_site_sid.value
	                  + ",v_fr_rqst_date=" + fr_date
	                  + ",v_to_rqst_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	        tr_post(tr1);
		};
    }
        
    <%//견적서 조회%>
    function fnSelectEst(row) {
    	//alert("3");
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID");
        //alert(v_param);            
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
            "JSP(O:DS_EST=ds_est)",
            v_param);
        tr_post(tr2);
    }

    <%//청구품목 조회%>
    function fnSelectDetail(row) {
    	//alert("4");
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_est").NameValue(row, "RQST_SID")
                    + ",v_est_sid="+getObjectFirst("ds_est").NameValue(row, "EST_SID");                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
    }

    <%//협력사 조회%>
    function fnSelectDetail2(row) {
        v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			        + ",v_rqst_sid="+getObjectFirst("ds_est").NameValue(row, "RQST_SID")
                    + ",v_est_sid="+getObjectFirst("ds_tender").NameValue(row, "EST_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }

	<%//저장 %>
	function fnApply(){
		v_job = "A";
		var checkDiv='';	
		
		 if(ds_est.CountRow==0){
            alert("[견적서] 데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
		
		for( i=1;i<=ds_tender.CountRow;i++ ) {
			if (ds_tender.namevalue(i,"USE_YN") == 'T' ) {
								checkDiv='true';
								break;
			}
		}
		if ( checkDiv != 'true' ) { 
			alert("적어도 하나의 청구품목을 선택하셔야 합니다."); 
			return;
	 	} 				
		if ( ds_detail.CountRow==0 ) { 
			alert("적어도 하나의 협력사를 행추가 하셔야 합니다."); 
			return;
	 	} 	
	 	
 	   	if (ds_default.IsUpdated	||	ds_tender.IsUpdated	||	ds_detail.IsUpdated) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_EST=ds_est,I:DS_TENDER=ds_tender,I:DS_DETAIL=ds_detail)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);

    	}else
     		alert("업데이트된 행이 없습니다.");
	}
	
	<%//저장 %>
	function fnApply2(){
		v_job = "A";
		var checkDiv='';	
		
	     if(ds_est.CountRow==0){
            alert("[견적서] 데이터가 없습니다.");
            return;
        }

		if (ds_est.IsUpdated	) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu040I",
                "JSP(I:DS_EST=ds_est)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);

    	}else
     		alert("업데이트된 행이 없습니다.");
	}

	/******************************************************************************
		Description : 결재선  popup
	******************************************************************************/
	
	function fnApproval() {
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
				strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";
	
				arrResult = showModalDialog(strURL,arrParam,strPos);
				//alert("arrResult===========");
				//alert(arrResult);
				sApproveLine = arrResult; // ru
				//alert("sApproveLine==========");
				//alert(sApproveLine);
		}
	
	
	/******************************************************************************
		Description : 기안  popup
	******************************************************************************/
	function fnDraft() {
	
		if(ds_default.CountRow ==0){
			alert("기안 할 내용을 조회 해 주세요");
			return;
		}
		
		if(sApproveLine==""||sApproveLine=="undefined"){
		   alert("결재선지정이 되지 않았습니다.");
		   return;
		}
		
		var arrParam	= new Array();
			
		arrParam[0]="010";  // AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 
		arrParam[1]=ds_default.namevalue(ds_default.rowposition,"DOC_MAG_SID");  //등록번호
		arrParam[2]=sApproveLine;      // 결재선정보 
		
		
		strURL = "<%=dirPath%>/Security/help/li0100h.jsp?";
		strPos = "dialogWidth:740px;dialogHeight:480px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}

	<%//액셀 다운로드 %>
    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:자재청구서; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("자재청구서", "자재청구서.xls", 8);        
    }
    
	<%//도급계약명 팝- 조회%>
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
    
	<%//현장 팝- 입력%>
    function fnSelSitePopup1(dirPath) {
        if(ds_default.CountRow==0){
            alert("신규 버튼으로 새 행을 추가하시기 바랍니다.");
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

	<%// 마스터 신규 %>
	function fnAddRowDsDefault(){
		if(ds_tender.IsUpdated) {
			alert("수정중인 행이 있으면 신규 청구정보를 생성할 수 없습니다.");
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

	<%// 마스터 삭제 %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("수정중인 작업이 있어 삭제할 수 없습니다.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};
	<%//견적서 행추가 %>
	function fnAddRowDs7() {
		if (ds_default.namevalue(ds_default.rowposition,"RQST_SID") == undefined || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == "" || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == 0 ) {
			alert("청구정보를 조회/저장 후 추가해 주세요.");
		} else {
			ds_est.addrow();
			ds_est.namevalue(ds_est.RowPosition, "RQST_SID") = ds_default.namevalue(ds_default.rowposition,"RQST_SID");
			
			window.status="협력사 행이 삽입되었습니다.";
		}
	}

	<%//견적서 행삭제 %>
	function fnDeleteRowDs7(){
		ds_est.deleterow(ds_est.rowposition);
		window.status="견적서 행이 삭제되었습니다.";
	}
	<%//디테일 행추가 %>
	function fnAddRowDs2() {
		//alert(ds_est.rowposition,"EST_SID");
		if (ds_est.namevalue(ds_est.rowposition,"EST_SID") == undefined || ds_est.namevalue(ds_est.rowposition,"EST_SID") == "" || ds_est.namevalue(ds_est.rowposition,"EST_SID") == 0 ) {
			//alert("견적서정보를 조회/저장 후 추가해 주세요.");
		}  else {
			ds_detail.addrow();
			ds_detail.namevalue(ds_detail.RowPosition, "EST_SID") = ds_est.namevalue(ds_est.rowposition,"EST_SID");
			
			window.status="협력사 행이 삽입되었습니다.";
		}
	}

	<%//디테일 행삭제 %>
	function fnDeleteRowDs2(){
		ds_detail.deleterow(ds_detail.rowposition);
		window.status="협력사 행이 삭제되었습니다.";
	}

	<%// 그리드 수정 취소 %>
	function fnCancel() {
		ds_est.undoall();
        ds_default.undoall();
        ds_tender.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
	}
	
	/*
	* 협력사 : 상세 그리드에서 
	*/
	function fnVENDPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Pms/help/pu040h_01.jsp"
		strPos = "dialogWidth:570px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds_detail.namevalue(ds_detail.rowposition,"VEND_CD") = arrParam[0];
	   		ds_detail.namevalue(ds_detail.rowposition, "VEND_NM") = arrParam[1];
	   		ds_detail.namevalue(ds_detail.rowposition, "VEND_ID") = arrParam[2];
	   		ds_detail.namevalue(ds_detail.rowposition, "VD_DIRECT") = arrParam[3];
		} else {
			ds_detail.namevalue(ds_detail.rowposition,"VEND_CD") = "";
	   		ds_detail.namevalue(ds_detail.rowposition, "VEND_NM") = "";
			ds_detail.namevalue(ds_detail.rowposition,"VEND_ID") = "";
			ds_detail.namevalue(ds_tender.rowposition,"VD_DIRECT") = "";			
   		}				
		
	}		
	
	/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			if(ds_default.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr_default").SetExcelTitle(0, "");
	        getObjectFirst("gr_default").SetExcelTitle(1, "value:견적의뢰서; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_default").GridToExcel("견적의뢰서","견적의뢰서.xls", 8);

			if(ds_est.RowCount==0){
	            return;
	        }
	        getObjectFirst("gr_est").SetExcelTitle(0, "");
	        getObjectFirst("gr_est").SetExcelTitle(1, "value:견적서; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_est").GridToExcel("견적서","견적서.xls", 8);
	        
	        if(ds_tender.RowCount==0){
	            return;
	        }
	        
	        getObjectFirst("gr_tender").SetExcelTitle(0, "");
	        getObjectFirst("gr_tender").SetExcelTitle(1, "value:청구품목; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_tender").GridToExcel("청구품목","청구품목.xls", 8);
	        
	         if(ds_detail.RowCount==0){
	            return;
	        } 
	        getObjectFirst("gr_detail").SetExcelTitle(0, "");
	        getObjectFirst("gr_detail").SetExcelTitle(1, "value:협력사; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_detail").GridToExcel("협력사","협력사.xls", 8);

		}	 	 
	
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>


<%//청구번호 클릭시 청구품목 조회 %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_est.IsUpdated) {
			alert("수정중인  작업이 있을 경우에는 조회를 할수 없습니다!");
			return false;
		} else {
		    var row2=ds_default.countrow;
		    if(row2==0) return;
		    
		     fnSelectEst(Row);				
		    
		};
	</script>
<%//견적서 클릭시 청구품목 조회 %>
	<script language=javascript for="gr_est" event="OnDblClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_est.IsUpdated) {
			alert("수정중인  작업이 있을 경우에는 조회를 할수 없습니다!");
			return false;
		} else {
		    var row2=ds_est.countrow;
		    if(row2==0) return;
		    
		     fnSelectDetail(Row);				
		     fnSelectDetail2(Row);						    
		};
	</script>
<%//청구픔목 클릭시 협력사 조회 %>
	<script language=javascript for="gr_tender" event="OnDblClick(Row, Colid)">
			   // fnSelectDetail2(Row);				
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
	}
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
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
        window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        window.status="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_tender.clearall();
			}else{
				fnSelectEst(v_default_row);
				//fnSelectDetail(v_default_row);
			}
		}
	</script>
	<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
		if (colid=="VEND_NM") {
			fnVENDPopup();
		}
	</script>    
<%
/*=============================================================================
			DataSet Components(DS) 선언
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

<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 조회: 작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용처 -->
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	 onClick="fnExcelDs1()">		<!-- 엑셀 -->
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
			                        <td align=left class="text"  width="70">청구일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">
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
			                            <object id=v_to_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">            
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
                    				<td align=left class="text">작업상태</td>
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
				<b>[청구서]</b>
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
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="0">
                                <param name=SortView  value="Right">
                                <param name="Format"            value="
		                             <C> name='작업상태'	ID='RQST_STATUS'    	width=80 	align=CENTER	Edit=None 		 sort=true show=false	</C>
                                     <C> name='작업상태'	ID='RQST_STATUS_NM'    	width=80 	align=CENTER	Edit=None  sort=true		show=true	suppress=1</C>
                                     <C> name='일자' 		ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None  sort=true		suppress=2</C>
                                     <C> name='청구번호'	ID='RQST_NO' 			width=120 align=CENTER	Edit=None  sort=true	</C>
                                     <C> name='청구SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 			show=false decao=0	Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 					show=false</C>
                                     <C> name='현장담당자'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		show=false	</C>
                                     <C> name='현장명'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='현장SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 	show=false 		 </C>
                                     <C> name='사용처'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None		show=false</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">작업상태</td>
									<td 	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
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
									<td width="120px" class="text">사용처</td>
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
									<td width="120px" class="text">청구일자</td>
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
									<td width="120px" class="text">청구번호</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr>
									<td width="120px" class="text">현장코드</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_site_cd' id="v_pu_site_cd" style="width:100px;" class='input01' readOnly="readonly"> </td>
									<td width="120px" class="text">현장담당자</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" edit='false' name='v_pu_empnm' id="v_pu_empnm" style="width:100px;" class='input01'  readOnly="readonly" > </td>
                                        <input type="hidden"  edit='false' name='v_pu_empno' id='v_pu_empno'>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">현장명</td>
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
				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDs7()" >
				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRowDs7()" >
				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply2();">
				<b>[견적서]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_est" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='80px' border='1'>
                    <param name="DataID"            value="ds_est">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='견적SID(시스템 고유번호)' 			ID='EST_SID'	   		width=200 		align=CENTER	edit=none show=false</C>
                         <C> name='요청SID(시스템 고유번호)' 		ID='RQST_SID'   		width=200 		align=CENTER	edit=none show=false</C>
                         <C> name='견적서 순번'     	    ID=CurRow   	        width=100	    align=center  show=true edit=none Value={CurRow}</ </C>
                         <C> name='견적담당자사번' 		ID='EST_EMPNO'   		width=100 		align=CENTER	editlimit=7 edit=true show=true</C>
                         <C> name='견적마감일자'	 		ID='DATE_TO'   			width=100 		align=CENTER	editlimit=8	edit=true show=true</C>
                         <C> name='견적특기사항' 			ID='EST_MEMO'   		width=400 		align=CENTER	edit=true show=true</C>                                                  
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
        	<b>[청구 품목]</b>
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
                    <param name=SortView  value="Right">
                    <param name="Format"            value="
	                     <C> name='선택' 			ID='USE_YN'    		edit=true		width=30 		align=CENTER	editstyle=checkbox 	bgColor=<%=HDConstant.GRID_ITEM%> </C>
	                     <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none show=TRUE	show=false </C>
	                     <C> name='RQST_SID' 		ID='RQST_SID'   		width=80 		align=CENTER	edit=none show=TRUE	show=false </C>
	                     <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=80 		align=CENTER	edit=none show=TRUE	show=false </C>
	                     <C> name='순번' 			ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
                         <C> name='품명' 			ID='ITEM_NM'    	width=150 	align=CENTER	 edit=none</C>
                         <C> name='규격' 			ID='ITEM_SIZE'   	width=150 	align=CENTER	 edit=none</C>
                         <C> name='단위' 			ID='ITEM_UNIT'   	width=80 	align=CENTER	edit=none </C>
                         <C> name='용도' 			ID='RQST_USE'    	width=150 	align=CENTER	 edit=none show=false</C>
                        <G> name='도급'
                         <C> name='수량' 				ID='DG_CNT'   		width=45 		align=right edit=none</C>
                         <C> name='단가'    		ID='DG_AMT'    	    width=75 		align=right show=true decao=0	edit=none	sumtext='총'  sumtextalign='right' </C>
                         <C> name='금액'   	ID='DG_SUM_AMT'   width=85 		align=right show=true edit=none	decao=0	sumtext='@sum' sumtextalign='right' </C>
                        </G>
                        <G> name='예산'
                         <C> name='수량' 			ID='RQST_CNT'   		width=45 		align=right edit=none sumtext='원'  sumtextalign='left'</C>
                         <C> name='단가' 			ID='YS_AMT'   			width=75 		align=right decao=0 edit=none	 </C>
                         <C> name='금액'    		ID='YS_SUM_AMT'    width=85 		align=right show=true edit=none	decao=0	 sumtext='@sum' sumtextalign='right'</C>
						</G>
                         <C> name='소요일' 			ID='DATE_USE'    	width=80 		align=CENTER	 edit=none sumtext='원'  sumtextalign='left'</C>
                         <C> name='청구비고' 		ID='RQST_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>
                         <C> name='견적비고' 		ID='EST_ITEM_NOTE'    	width=150 	align=LEFT	 	 edit=true	bgColor=<%=HDConstant.GRID_ITEM%></C>
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
				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDs2()" >
				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRowDs2()" >
				<b>[협력사]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_detail" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='100px' border='1'>
                    <param name="DataID"            value="ds_detail">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none show=false </C>
                         <C> name='거래처코드' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false </C>
                         <C> name='협력사명' 			ID='VEND_NM'    		width=150 	align=CENTER	 bgColor=<%=HDConstant.GRID_ITEM%>	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='사업자번호' 		ID='VEND_ID'   			width=80 		align=CENTER	 </C>
                         <C> name='대표' 				ID='VD_DIRECT'   	width=80 		align=CENTER	 </C>
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
    </table>
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=RQST_STATUS     Ctrl=lc_rqst_status    Param=BindColVal </C>
					<C>Col=RQST_STATUS_NM	 Ctrl=v_rqst_status_nm        	 Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        Param=Text </C>
					<C>Col=DATE_FR       	 	 Ctrl=v_date_fr  	     Param=Text </C>
					<C>Col=DATE_TO       	 	 Ctrl=v_date_to        	 Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 Param=value </C>
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     Param=Value </C>
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     Param=value </C>
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   	 Param=value </C>
					<C>Col=PU_EMPNM    	 	 Ctrl=v_pu_empnm   	 Param=value </C>
					<C>Col=RQSTAC_MEMO 	 	 Ctrl=v_rqstac_memo  	 Param=value </C>		
					<C>Col=PUT_WH			     Ctrl=lc_put_wh    Param=BindColVal </C>	
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>