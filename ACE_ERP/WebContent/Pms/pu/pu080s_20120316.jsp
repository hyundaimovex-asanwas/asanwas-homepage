<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 구매_검수
 * 프로그램ID 	 : PMS/PU080I
 * J  S  P		 	 : pu080i.jsp
 * 서 블 릿		 : Pu080I
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2011-12-01
 * 기능정의		 : 구매_검수
 * [ 수정일자 ][수정자] 내용
 * [2011-12-01][박경국] 신규
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
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
       
        v_fr_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //v_fr_con_date.Text = "20111114";
        //v_to_con_date.Text = "20111114";


       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//작업상태(조회)
       ds_con_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_con_status.Reset();	//작업상태
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//사용처
       ds_put_wh.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU003&s_item1=Y";
       ds_put_wh.Reset();	//투입창고
       ds_terms_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU004&s_item1=Y";
       ds_terms_trans.Reset();	//인도조건
       ds_way_chk.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU005&s_item1=Y";
       ds_way_chk.Reset();	//검사방법
       ds_terms_pay.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU006&s_item1=Y";
       ds_terms_pay.Reset();	//지불조건
       ds_bur_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU007&s_item1=Y";
       ds_bur_trans.Reset();	//운반비부담
       
      
      
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender,O:DS_DETAIL=ds_detail)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    <%//메인 조회  %>
    function fnSelect() {
    
    	//alert("1");
		if (ds_default.IsUpdated || ds_tender.IsUpdated|| ds_detail.IsUpdated) {
			alert("수정중인 행인 있습니다.");
		} else {
		    v_job="S";
		    
	        var fr_date = v_fr_con_date.Text.trim();
	        var to_date = v_to_con_date.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("품의일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("품의일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_site_sid="+ v_site_sid.value
	                  + ",v_fr_con_date=" + fr_date
	                  + ",v_to_con_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        
	         //첨부파일 쪼개기
	        var real_fileList="";
			var sys_fileList="";
				
			var real_fileList =txt_real_file.value;
			var sys_fileList =txt_sys_file.value;
		
			var real_file10= new Array();
			var sys_file10= new Array();
		
			real_file10 = real_fileList.split(":");	//배열로 정리
			sys_file10 = sys_fileList.split(":");	//배열로 정리
		
			var real_file1=real_file10.slice(0,1);
			var sys_file1=sys_file10.slice(0,1);	
			var real_file2=real_file10.slice(1,2);
			var sys_file2=sys_file10.slice(1,2);	
			var real_file3=real_file10.slice(2,3);
			var sys_file3=sys_file10.slice(2,3);	
		};
    }    

    <%//tender 조회%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID")
                    + ",v_est_sid="+getObjectFirst("ds_default").NameValue(row, "EST_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
       // fnSelectDetail2(row);
    }

    <%//detail 조회%>
    function fnSelectDetail2(row) {
        //v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_est_sid="+getObjectFirst("ds_tender").NameValue(row, "EST_SID")
                    + ",v_vend_cd="+getObjectFirst("ds_tender").NameValue(row, "VEND_CD");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }

	<%//저장 %>
	function fnApply(){
		v_job = "A";
				
		if ( ds_detail.CountRow==0 ) { 
			alert("적어도 하나의 견적품목을 조회 하셔야 합니다."); 
			return;
	 	} 	

		if (ds_default.IsUpdated	||	ds_tender.IsUpdated	||	ds_detail.IsUpdated) {
			  //alert("1");
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_TENDER=ds_tender,I:DS_DETAIL=ds_detail)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        		fnSelect();
    	}else
     		alert("업데이트된 행이 없습니다.");
	}

	<%// 그리드 수정 취소 %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
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
			alert("품의 할 내용을 조회 해 주세요");
			return;
		}
		
		if(sApproveLine==""||sApproveLine=="undefined"){
		   alert("결재선지정이 되지 않았습니다.");
		   return;
		}
		
		var result="";
	    var arrParam	= new Array();
	    var arrResult	= new Array();
		//alert(sApproveLine);	
		arrParam[0]="340";  // AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의, 340 구매검수)
		arrParam[1]=ds_default.namevalue(ds_default.rowposition,"EST_SID");  //견적SID
		arrParam[2]=sApproveLine;      // 결재선정보 
		arrParam[4]=ds_default.namevalue(ds_default.rowposition,"RQST_SID");  //청구SID
		arrParam[5]=ds_tender.namevalue(ds_tender.rowposition,"VEND_CD");   //거래처코드
		
		//alert(arrParam);
		strURL = "<%=dirPath%>/Pms/help/pu040h.jsp?";
		strPos = "dialogWidth:740px;dialogHeight:850px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
		      
		if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
		} 
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

	<%// 그리드 수정 취소 %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
	}
	function fnExcel() {
  	
	        getObjectFirst("gr_detail").SetExcelTitle(0, "");
	        getObjectFirst("gr_detail").GridToExcel("Sheet3","견적품목.xls", 32);   
	        
	        getObjectFirst("gr_tender").SetExcelTitle(0, "");
	        getObjectFirst("gr_tender").GridToExcel("Sheet2","견적내역.xls", 32);   
	        
	        getObjectFirst("gr_default").SetExcelTitle(0, "");
	        getObjectFirst("gr_default").GridToExcel("Sheet1","검수정보.xls", 32);   
         }
         
 //첨부파일(1) 다운로드_열기
    function fnFile(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
				
		if(real_file1==''){
			alert("첨부파일이 존재하지 않습니다")
			return;
		}else if(real_file1.length==1){
			location.href = '/services/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //운영
		}

	}
	//첨부파일(2) 다운로드_열기
    function fnFile2(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
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
		alert("2번째 파일이 존재하지 않습니다")
		}
		if(real_file2.length>0){
		location.href = '/services/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //운영
		}
	}
	//첨부파일(3) 다운로드_열기
    function fnFile3(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
		
		if(real_file3.length==0){
		alert("3번째 파일이 존재하지 않습니다")
		}
		if(real_file3.length >0){
			location.href = '/services/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //운영
		}

	}
	
	/*
	 * 레포트
	 */
	function fnPrint() {
	    v_job = "S";
       var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
        			 + ",v_rqst_sid=" + v_rqst_sid.value
        			+ ",v_est_sid=" + v_est_sid.value;
        			//alert(param);
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
            "JSP(O:DS9=ds9)",
            v_param);
        tr_post(tr1);
    }
 </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%//품의정보 클릭시 견적내역 조회 %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("수정중인  작업이 있을 경우에는 조회를 할수 없습니다!");
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
<%//견적내역 클릭시 견적품목 조회 %>
	<script language=javascript for="gr_tender" event="OnClick(Row, Colid)">
			    fnSelectDetail2(Row);				
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
				fnSelectDetail(row);
			}
		}
	</script>
	<script language=javascript for="ds_tender" event="OnLoadCompleted(row)">
        window.status="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_detail.clearall();
			}else{
				fnSelectDetail2(row);
			}
		}
	</script>
	<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	pr1.PreView();
	</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
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
<object id=ds_con_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용처 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_put_wh classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 투입창고 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_date_ddl classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  납기일자 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  인도조건 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_way_chk classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  검사방법 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_pay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지불조건 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bur_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  운반지부담 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트--%>
<object id=ds10 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트--%>
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
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand"  onclick="fnPrint()">		<!-- 인쇄 -->							
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
                                    <td align="center" class="text" width="70">도급계약명</td>
                                    <td bgcolor="#FFFFFF" colspan="5">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="값 지우기">
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">품의일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=v_to_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='285px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
	                                 <C> name='작업상태'	ID='CON_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='작업상태'	ID='CON_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=TRUE	</C>
                                     <C> name='청구일자' 	ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='품의일자' 	ID='DATE_CON'    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='검수일자' 	ID='DATE_CGC'    		width=80 	align=CENTER	Edit=None 		</C>                                     
                                     <C> name='납기일자'		ID='DATE_DDL'    		width=60 	align=CENTER	Edit=None 		</C>
                                     <C> name='품의번호'	ID='CON_NO' 				width=120 align=CENTER	Edit=None		</C>
                                     <C> name='품의SID'    ID='CON_SID'       		width=60 	align=CENTER	Edit=None	 	 show=false decao=0	Edit=None </C>                                     
                                     <C> name='견적SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None </C>
                                     <C> name='청구번호' 	ID='RQST_NO'	    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='청구SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장담당자'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		</C>
                                     <C> name='현장명'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None		</C>
                                     <C> name='현장SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 		 show=false  </C>
                                     <C> name='사용처'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None		 show=false </C>
                                     <C> name='투입창고'		ID='PUT_WH' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='인도조건'    	ID='TERMS_TRANS' width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='검사방법'		ID='WAY_CHK' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='지불조건'		ID='TERMS_PAY'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='운반비부담'	ID='BUR_TRANS' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='공급자 준수사항'    ID='OSV_PVR'  width=60 	align=CENTER	Edit=None 		</C>
                                     <C> name='품의특기사항'		ID='CON_NOTE' 		width=60 	align=CENTER	Edit=None		</C>
                                     <C> name='검수특기사항'		ID='CGC_NOTE' 		width=60 	align=CENTER	Edit=None		</C>
                                     
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">작업상태</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_con_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_con_status>
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
									<td width="120px" class="text">납기일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_ddl classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
								</tr>	
								<tr height="21px">
									<td width="120px" class="text">청구번호</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'   readOnly="readonly"> </td>
									<td width="120px" class="text">청구일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
								</tr>
								<tr height="21px">
									<td width="120px" class="text">품의번호</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_con_no' id="v_con_no" style="width:130px;" class='input01'  readOnly="readonly"> </td>
									<td width="120px" class="text">품의일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_con classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
								</tr>
								<tr>
									<td width="120px" class="text">현장담당자</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_empno' id="v_pu_empno" style="width:100px;" class='input01' readOnly="readonly" > </td>
									<td width="120px" class="text">인수일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_cgc classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">현장명</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">인도조건</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_trans>
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
									<td width="120px" class="text">투입창고</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_put_wh classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_put_wh>
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
									<td width="120px" class="text">지불조건</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_pay classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_pay>
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
									<td width="120px" class="text">운반비부담</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_bur_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_bur_trans>
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
									<td width="120px" class="text">청구sid</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_sid' id="v_rqst_sid" style="width:130px;" class='input01'  readOnly="readonly"> </td>
									<td width="120px" class="text">견적sid</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_est_sid' id="v_est_sid" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">결재반려사유</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_ap_desc_re' id="v_ap_desc_re" style="width:400px;" class='input01' readOnly="readonly"  >
                                    </td>
								</tr>		
								<tr height="21px">
									<td width="120px" class="text">공급자 준수사항</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_osv_pvr' id="v_osv_pvr" style="width:300px;" class='input01' readOnly="readonly"  >
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">품의 특기사항</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_con_note' id="v_con_note" style="width:300px;" class='input01'  readOnly="readonly" >
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">인수 특기사항</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_cgc_note' id="v_cgc_note" style="width:300px;" class='textbox'  >
                                    </td>
								</tr>
								<tr>
									<td width="120px" class="text">첨부파일</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;
                                        <input type="hidden"  name='txt_sys_file' id='txt_sys_file'>
                                        <input type="text" name='txt_real_file' id="txt_real_file" style="width:310px;" class='input01'   readOnly="readonly">
                                        <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='input01' value="(1)"  onclick="fnFile()" readOnly="readonly">
					                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='input01'   value="(2)" onclick="fnFile2()" readOnly="readonly">
					                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='input01'   value="(3)" onclick="fnFile3()" readOnly="readonly">
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
        	<b>[견적내역]</b>
        	</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='100px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='선정여부' 			ID='CHOICE_YN'	   	width=80 		align=CENTER	edit=none show=TRUE</C>
	                     <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none  show=false </C>
                         <C> name='거래처코드' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=TRUE</C>
                         <C> name='협력사명' 			ID='VEND_NM'    		width=150 	align=CENTER	edit=none</C>
                         <C> name='총견적가'			ID='TOT_EST_AMT'  width=90 		align=right 	 decao=0 edit=none </C>
                         <C> name='결정금액'			ID='TOT_FN_EST_AMT'  	width=90 		align=right 	 decao=0	edit=none</C>
                         <C> name='증감액'				ID='UD_EST_AMT'  	width=90 		align=right 	 decao=0 edit=none</C>                                                  
                         <C> name='견적서번호'		ID='EST_NO'    		width=150 	show=false 	 align=CENTER	edit=none</C>
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
				<b>[견적품목]</b>
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
                    <param name="ViewSummary"       value="1">
                    <param name="Format"            value="
                         <C> name='EST_SID' 			ID='EST_SID'   			width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='RQST_SID' 		ID='RQST_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='품명' 				ID='ITEM_NM'    		width=100 	align=CENTER	 	edit=none sumtext='총'  sumtextalign='right'</C>
                         <C> name='규격' 				ID='ITEM_SIZE'   		width=60 		align=CENTER	 	edit=none sumtext='@count' sumtextalign='right'</C>
                         <C> name='단위' 				ID='ITEM_UNIT'   		width=60 		align=CENTER		edit=none sumtext='품목' sumtextalign='left'</C>
                         <C> name='수량' 				ID='EST_CNT'   		width=60 		align=CENTER		edit=none </C>
                         <C> name='도급단가'    		ID='DG_AMT'    	    width=85 		align=CENTER	 show=true decao=0	sumtext='@sum' sumtextalign='right'	 </C>
                         <C> name='도급액'   			ID='DG_SUM_AMT'   width=85 		align=CENTER	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                         <C> name='예산단가' 			ID='YS_AMT'   			width=85 		align=CENTER	 decao=0 sumtext='@sum' sumtextalign='right'	</C>
                         <C> name='예산액'    			ID='YS_SUM_AMT'    width=85 		align=CENTER	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                         <C> name='견적금액'    		ID='SUM_AMT'    	    width=85 		align=CENTER	 show=true decao=0	sumtext='@sum' sumtextalign='right'	 </C>
                         <C> name='결정단가' 			ID='FN_EST_AMT'   			width=85 		align=CENTER	 decao=0 	</C>
                         <C> name='결정금액'    		ID='FN_SUM_AMT'    width=85 		align=CENTER	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	</C>
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
					<C>Col=CON_STATUS     	 Ctrl=lc_con_status    	Param=BindColVal </C>
					<C>Col=CON_STATUS_NM     	 Ctrl=v_con_status_nm    	Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        	Param=Text </C>
					<C>Col=DATE_DDL       	 Ctrl=v_date_ddl         	Param=Text </C>					
					<C>Col=DATE_CON       	 Ctrl=v_date_con        	Param=Text </C>
					<C>Col=DATE_CGC       	 Ctrl=v_date_cgc        	Param=Text </C>					
					<C>Col=DATE_FR       	 	 Ctrl=v_date_fr  	     	Param=Text </C>
					<C>Col=DATE_TO       	 	 Ctrl=v_date_to        	 	Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 	Param=value </C>
					<C>Col=CON_NO       	 	 Ctrl=v_con_no        	 	Param=value </C>					
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     	Param=Value </C>
					<C>Col=CON_SID		       	 Ctrl=v_con_sid 	     	Param=Value </C>					
					<C>Col=EST_SID		       	 Ctrl=v_est_sid 	     	Param=Value </C>										
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     	Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     	Param=value </C>
					<C>Col=PUT_WH     		 	 Ctrl=lc_put_wh	     	Param=BindColVal </C>
					<C>Col=TERMS_TRANS     Ctrl=lc_terms_trans  	Param=BindColVal </C>
					<C>Col=WAY_CHK     		 Ctrl=lc_way_chk	     	Param=BindColVal </C>
					<C>Col=TERMS_PAY     	 Ctrl=lc_terms_pay    	Param=BindColVal </C>
					<C>Col=BUR_TRANS     	 Ctrl=lc_bur_trans     	Param=BindColVal </C>
					<C>Col=OSV_PVR       	 	 Ctrl=v_osv_pvr		     	Param=value </C>
					<C>Col=CON_NOTE	       	 Ctrl=v_con_note	    	Param=Value </C>					
					<C>Col=CGC_NOTE	       	 Ctrl=v_cgc_note	    	Param=Value </C>										
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        	Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     	Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   		Param=value </C>
					<C>Col=PREPAY_AMT_RATE    Ctrl=v_prepay_amt_rate   	Param=text </C>
					<C>Col=PREPAY_AMT    			Ctrl=v_prepay_amt   		Param=value </C>
					<C>Col=CH_RATE    	 	 			Ctrl=v_ch_rate   		Param=text </C>
					<C>Col=CH_AMT    	 	 			Ctrl=v_ch_amt   		Param=value </C>
					<C>Col=DB_RATE    	 	 			Ctrl=v_db_rate   		Param=text </C>
					<C>Col=DB_AMT    	 	 			Ctrl=v_db_amt   		Param=value </C>
					<C>Col=TERM_GRN    	 	 		Ctrl=v_term_grn   		Param=value </C>																				
					<C>Col=TOT_FN_EST_AMT  	 	 		Ctrl=v_tot_fn_est_amt		Param=value </C>			
					<C>Col=FN_EST_AMT  	 	 		Ctrl=v_fn_est_amt		Param=value </C>		
					<C>Col=AP_DESC_RE 	 	 Ctrl=v_ap_desc_re   	 Param=value </C>											
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>	
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
<%
/*=============================================================================
			레포트 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
	<param NAME="MasterDataID"			VALUE="ds9">
	<param NAME="DetailDataID"			VALUE="ds9">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"			VALUE="true">
	<PARAM NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="LandScape"					VALUE="true">
	<param name="NullRecordFlag"    value="false">
  	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2971 ,bottom=757 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=839 ,top=151 ,right=1677 ,bottom=225 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=828 ,top=127 ,right=1662 ,bottom=206 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1781 ,top=53 ,right=2717 ,bottom=280 ,border=true ,penstyle=solid ,penwidth=5</X>
	<X>left=148 ,top=296 ,right=2717 ,bottom=587 ,border=true ,penstyle=solid ,penwidth=5</X>
	<T>id='강원도 고성군 현내면 초도리 258-2' ,left=1397 ,top=500 ,right=1931 ,bottom=566 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='현대아산(주)' ,left=1397 ,top=402 ,right=1603 ,bottom=450 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명: 장경작' ,left=1638 ,top=405 ,right=1926 ,bottom=452 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='221-81-13834' ,left=1368 ,top=307 ,right=1931 ,bottom=362 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1140 ,top=373 ,right=2717 ,bottom=373 </L>
	<L> left=1140 ,top=296 ,right=1140 ,bottom=587 </L>
	<T>id='청구번호' ,left=1971 ,top=397 ,right=2135 ,bottom=458 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현 장 명' ,left=1971 ,top=500 ,right=2135 ,bottom=561 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='품의번호' ,left=1971 ,top=304 ,right=2135 ,bottom=365 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1140 ,top=482 ,right=2717 ,bottom=482 </L>
	<T>id='성명:' ,left=704 ,top=431 ,right=833 ,bottom=479 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=243 ,top=482 ,right=1050 ,bottom=482 </L>
	<L> left=243 ,top=373 ,right=1050 ,bottom=373 </L>
	<T>id='사업장' ,left=1143 ,top=487 ,right=1352 ,bottom=527 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등록번호' ,left=1143 ,top=304 ,right=1352 ,bottom=365 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업장' ,left=249 ,top=487 ,right=460 ,bottom=527 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등록번호' ,left=249 ,top=304 ,right=460 ,bottom=365 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=460 ,top=296 ,right=460 ,bottom=587 </L>
	<L> left=1050 ,top=296 ,right=1050 ,bottom=587 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1950 ,top=296 ,right=1950 ,bottom=587 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1352 ,top=296 ,right=1352 ,bottom=587 </L>
	<L> left=2154 ,top=296 ,right=2154 ,bottom=587 </L>
	<T>id='자' ,left=1053 ,top=519 ,right=1140 ,bottom=566 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='는' ,left=1053 ,top=466 ,right=1140 ,bottom=513 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='받' ,left=1053 ,top=413 ,right=1140 ,bottom=460 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=1053 ,top=360 ,right=1140 ,bottom=407 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=156 ,top=495 ,right=241 ,bottom=561 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=156 ,top=320 ,right=241 ,bottom=386 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=156 ,top=407 ,right=241 ,bottom=474 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=1058 ,top=307 ,right=1140 ,bottom=355 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=249 ,top=527 ,right=460 ,bottom=572 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1143 ,top=521 ,right=1352 ,bottom=566 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=243 ,top=296 ,right=243 ,bottom=587 </L>
	<C>id='VEND_ID', left=474, top=302, right=1032, bottom=362 ,mask='XXX-XX-XXXXX'</C>
	<T>id='(법인명)' ,left=251 ,top=431 ,right=452 ,bottom=474 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상    호' ,left=251 ,top=381 ,right=452 ,bottom=423 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상    호' ,left=1146 ,top=381 ,right=1347 ,bottom=423 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(법인명)' ,left=1146 ,top=431 ,right=1347 ,bottom=474 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DATE_CGC', left=352, top=222, right=587, bottom=280, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='인수일자:' ,left=148 ,top=222 ,right=360 ,bottom=280 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='품의 특기사항 :' ,left=146 ,top=595 ,right=407 ,bottom=661 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인수 특기사항 :' ,left=146 ,top=683 ,right=407 ,bottom=746 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1781 ,top=127 ,right=2715 ,bottom=127 </L>
	<T>id='확인' ,left=2336 ,top=66 ,right=2477 ,bottom=127 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승인' ,left=2540 ,top=66 ,right=2680 ,bottom=127 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2508 ,top=53 ,right=2508 ,bottom=280 </L>
	<L> left=2302 ,top=53 ,right=2302 ,bottom=280 </L>
	<T>id='검토' ,left=2135 ,top=66 ,right=2275 ,bottom=127 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2096 ,top=53 ,right=2096 ,bottom=280 </L>
	<T>id='담당' ,left=1929 ,top=66 ,right=2069 ,bottom=127 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1894 ,top=53 ,right=1894 ,bottom=280 </L>
	<T>id='결재' ,left=1797 ,top=69 ,right=1876 ,bottom=124 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현' ,left=1797 ,top=140 ,right=1876 ,bottom=196 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장' ,left=1797 ,top=201 ,right=1876 ,bottom=257 ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='물 품 인 수 증' ,left=831 ,top=116 ,right=1659 ,bottom=193 ,face='HY중고딕' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='VEND_NM', left=474, top=381, right=1027, bottom=426</C>
	<C>id='VD_DIRECT', left=839, top=429, right=1040, bottom=476</C>
	<C>id='ADDRESS1', left=471, top=489, right=1037, bottom=572</C>
	<C>id='CON_NO', left=2164, top=302, right=2699, bottom=368</C>
	<C>id='SITE_NM', left=2167, top=497, right=2701, bottom=564</C>
	<C>id='RQST_NO', left=2164, top=397, right=2699, bottom=463</C>
	<C>id='CON_NOTE', left=415, top=593, right=2707, bottom=659</C>
	<C>id='CGC_NOTE', left=413, top=680, right=2704, bottom=746</C>
	<C>id='Column', left=1905, top=143, right=2090, bottom=267</C>
	<C>id='Column', left=2315, top=138, right=2500, bottom=262</C>
	<C>id='Column', left=2106, top=140, right=2291, bottom=265</C>
	<C>id='Column', left=2516, top=143, right=2701, bottom=267</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2971 ,bottom=119 ,face='Arial' ,size=10 ,penwidth=5
	<X>left=148 ,top=29 ,right=2717 ,bottom=119 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=148 ,top=29 ,right=148 ,bottom=119 </L>
	<L> left=2717 ,top=29 ,right=2717 ,bottom=119 </L>
	<L> left=148 ,top=29 ,right=2717 ,bottom=29 </L>
	<L> left=243 ,top=29 ,right=243 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=831 ,top=29 ,right=831 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1402 ,top=29 ,right=1402 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1500 ,top=29 ,right=1500 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1680 ,top=29 ,right=1680 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2400 ,top=29 ,right=2400 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='No' ,left=159 ,top=40 ,right=238 ,bottom=111 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='단위' ,left=1413 ,top=40 ,right=1492 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수량' ,left=1511 ,top=40 ,right=1667 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='단   가' ,left=1688 ,top=40 ,right=1990 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금   액' ,left=2011 ,top=40 ,right=2392 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비   고' ,left=2410 ,top=40 ,right=2701 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2000 ,top=29 ,right=2000 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='규   격' ,left=844 ,top=40 ,right=1389 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='품     명' ,left=251 ,top=40 ,right=823 ,bottom=106 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2971 ,bottom=80 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=148 ,top=0 ,right=2717 ,bottom=79 ,border=true</X>
	<L> left=148 ,top=0 ,right=148 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2717 ,top=0 ,right=2717 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=243 ,top=0 ,right=243 ,bottom=79 </L>
	<L> left=831 ,top=0 ,right=831 ,bottom=79 </L>
	<L> left=1402 ,top=0 ,right=1402 ,bottom=79 </L>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=79 </L>
	<L> left=1680 ,top=0 ,right=1680 ,bottom=79 </L>
	<L> left=2000 ,top=0 ,right=2000 ,bottom=79 </L>
	<L> left=2400 ,top=0 ,right=2400 ,bottom=79 </L>
	<C>id='ITEM_NM', left=249, top=5, right=826, bottom=71</C>
	<C>id='{CURROW}', left=156, top=11, right=233, bottom=66</C>
	<C>id='ITEM_SIZE', left=841, top=5, right=1397, bottom=71</C>
	<C>id='ITEM_UNIT', left=1408, top=11, right=1495, bottom=77</C>
	<C>id='RQST_CNT', left=1511, top=5, right=1677, bottom=66, align='right', MargineX=3</C>
	<C>id='FN_EST_AMT', left=1685, top=5, right=1992, bottom=71, align='right', MargineX=3, Dec=0, Decao=0</C>
	<C>id='FN_SUM_AMT', left=2016, top=8, right=2392, bottom=74, align='right', MargineX=3, Dec=0, Decao=0</C>
	<C>id='RQST_NOTE', left=2413, top=5, right=2707, bottom=71</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2971 ,bottom=80 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=148 ,top=0 ,right=2717 ,bottom=79 ,border=true</X>
	<L> left=148 ,top=0 ,right=148 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2717 ,top=0 ,right=2717 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=243 ,top=0 ,right=243 ,bottom=79 </L>
	<L> left=831 ,top=0 ,right=831 ,bottom=79 </L>
	<L> left=1402 ,top=0 ,right=1402 ,bottom=79 </L>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=79 </L>
	<L> left=1680 ,top=0 ,right=1680 ,bottom=79 </L>
	<L> left=2000 ,top=0 ,right=2000 ,bottom=79 </L>
	<L> left=2400 ,top=0 ,right=2400 ,bottom=79 </L>
	<L> left=148 ,top=79 ,right=2717 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='계' ,left=164 ,top=13 ,right=228 ,bottom=64</T>
	<S>id='{Sum(FN_SUM_AMT)}' ,left=2006 ,top=5 ,right=2392 ,bottom=71 ,align='right', MargineX=3, Dec=0, Decao=0</S>
</B>
<B>id=Footer ,left=0 ,top=1709 ,right=2971 ,bottom=2100 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='Page : #p of #t' ,left=1318 ,top=175 ,right=1550 ,bottom=228 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


	">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		