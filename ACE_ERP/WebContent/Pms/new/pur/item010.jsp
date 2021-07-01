<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 구매_청구접수
 * 프로그램ID 	 : PMS/PU020I
 * J  S  P		 	 : pu020i.jsp
 * 서 블 릿		 : Pu020I
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2011-11-21
 * 기능정의		 : 구매_청구접수
 * [ 수정일자 ][수정자] 내용
 * [2011-11-21][박경국] 신규
 * [2012-10-23][심동현] 테이블에 도급수량(DG_CNT) 컬럼 추가
 *						기존 RQST_CNT = 청구수량(=예산수량)
 * [2013-11-26][박경국] 13 재구성-실행 이전
 * [2014-06-09][박경국] 결재선 지정 창 변경
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
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
       
        v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

       	//alert("1");

       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//작업상태(조회)
       
       ds_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_rqst_status.Reset();	//작업상태
        
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//사용처
       
       ds_rqst_seq.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU008&s_item1=Y";
       ds_rqst_seq.Reset();	//업체선정
      
      ds_put_wh.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU003&s_item1=Y";
       ds_put_wh.Reset();	//투입창고
       //alert("2");
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender)",
            "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1");
        tr_post(tr1);
        //alert("3");
    }
    
    <%//메인 조회  %>
    function fnSelect() {
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
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
	                  + ",v_fr_rqst_date=" + fr_date
	                  + ",v_to_rqst_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu020I",
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

    <%//디테일 조회%>
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

	<%//저장 %>
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
		
		var result="";
	    var arrParam	= new Array();
	    var arrResult	= new Array();
		//alert(sApproveLine);	
		arrParam[0]="320";  // AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의)
		arrParam[1]=ds_default.namevalue(ds_default.rowposition,"RQST_SID");  //청구SID
		arrParam[2]=sApproveLine;      // 결재선정보 
		
		
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

	<%//디테일 행추가 %>
	function fnAddRowDs2() {
		if (ds_default.namevalue(ds_default.rowposition,"RQST_SID") == undefined || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == "" || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == 0 ) {
			alert("청구정보를 조회/저장 후 추가해 주세요.");
		} else {
			ds_tender.addrow();
			ds_tender.namevalue(ds_tender.RowPosition, "RQST_SID") = ds_default.namevalue(ds_default.rowposition,"RQST_SID");
			
			msgTxt.innerHTML="청구품목 행이 삽입되었습니다.";
		}
	}

	<%//디테일 행삭제 %>
	function fnDeleteRowDs2(){
		ds_tender.deleterow(ds_tender.rowposition);
		msgTxt.innerHTML="청구품목 행이 삭제되었습니다.";
	}

	<%// 그리드 수정 취소 %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		return;		
	}
	
	/*
	* 품목 팝업 : 상세 그리드에서 
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
	        getObjectFirst("gr_tender").GridToExcel("Sheet2","자재청구기본내역.xls", 32);   
	        
	        getObjectFirst("gr_default").SetExcelTitle(0, "");
	        getObjectFirst("gr_default").GridToExcel("Sheet1","품목정보.xls", 32);   
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
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //로컬

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
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //로컬

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
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //로컬
		}

	}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//청구정보 클릭시 청구품목 조회 %>
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
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
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
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
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

<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 조회: 작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용처 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_seq classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--업체선정-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_put_wh classid=<%=HDConstant.CT_DATASET_CLSID%>><!--  투입창고 -->
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
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
							<!-- <img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">-->		<!-- 엑셀 -->
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
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='233px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='작업상태'	ID='RQST_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	</C>
                                     <C> name='작업상태'	ID='RQST_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=true</C>
                                     <C> name='일자' 		ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='청구번호'	ID='RQST_NO' 			width=120 align=CENTER	Edit=None	</C>
                                     <C> name='청구SID'    ID='RQST_SID'       		show=false width=60 	align=CENTER	Edit=None 		decao=0	Edit=None  sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=TRUE</C>
                                     <C> name='현장담당자'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		</C>
                                     <C> name='현장명'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None	</C>
                                     <C> name='현장SID'    ID='SITE_SID'       			show=false width=60 	align=CENTER	Edit=None 		 </C>
                                     <C> name='사용처'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None	show=false</C>
                                     <C> name='업체선정'	ID='RQST_SEQ' 			width=120 align=CENTER	Edit=None show=false</C>                                     
                                     <C> name='업체선정'	ID='RQST_SEQ_NM' 	width=120 align=CENTER	Edit=None 	</C>   
                                     <C> name='real_file'	ID='real_file'    	width=100 	align=CENTER	Edit=None 	show=false	</C>
                                     <C> name='sys_file'	ID='sys_file'    	width=100 	align=CENTER	Edit=None 	show=false	</C>                                  
                                     <C> name='접수특기사항'	ID='RQSTAC_MEMO' 			width=120 align=CENTER	Edit=None show=true</C>                                     
                                     
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>작업상태</b></font></td>
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
									<td width="120px" class="text"><font color="green"><b>업체선정</b></font></td>
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
									<td width="120px" class="text"><font color="green"><b>접수일자</b></font></td>
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
									<td width="120px" class="text">청구일자</td>
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
									<td width="120px" class="text">현장코드</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text"  edit='false' name='v_pu_site_cd' id="v_pu_site_cd" style="width:100px;" class='input01'  readOnly="readonly" > </td>
									<td width="120px" class="text">현장담당자</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" edit='false' name='v_pu_empnm' id="v_pu_empnm" style="width:100px;" class='input01'  readOnly="readonly" > </td>
                                        <input type="hidden"  edit='false' name='v_pu_empno' id='v_pu_empno'>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">현장명</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  edit='false' name='v_site_sid1' id='v_site_sid1'>
                                     </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">사용처</td>
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
									<td width="120px" class="text">투입창고</td>
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
									<td width="120px" class="text">첨부파일</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;
                                        <input type="hidden"  name='txt_sys_file' id='txt_sys_file'>
                                        <input type="text" name='txt_real_file' id="txt_real_file" style="width:310px;" class='input01'   readOnly="readonly">
                                        <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='input01' value="(1)"  onclick="fnFile()" readOnly="readonly">
					                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='input01'   value="(2)" onclick="fnFile2()" readOnly="readonly">
					                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='input01'   value="(3)" onclick="fnFile3()" readOnly="readonly">
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">청구특기사항</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_rqst_memo' id="v_rqst_memo" style="width:380px;" class='input01'  readOnly="readonly"  >
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>접수특기사항</b></font></td>
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

	                     <C> name='순번' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
                         <C> name='품명' 		ID='ITEM_NM'    	width=150 	align=CENTER	 edit=none editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='규격' 		ID='ITEM_SIZE'   	width=150 	align=CENTER	 edit=none</C>
                         <C> name='단위' 		ID='ITEM_UNIT'   	width=60 	align=CENTER	 edit=none	</C>
                        <G> name='도급'
                         <C> name='수량' 		ID='DG_CNT'   		width=60 	align=right	 edit=none</C>
                         <C> name='단가'    	ID='DG_AMT'    	    width=85 	align=right	  edit=none show=true decao=0	sumtext='총'  sumtextalign='right'  </C>
                         <C> name='금액'   		ID='DG_SUM_AMT'   	width=85 	align=right	 show=true edit=none	decao=0	 sumtext='@sum' sumtextalign='right'	 </C>
                        </G>
                        <G> name='예산'
                         <C> name='수량' 		ID='RQST_CNT'   	width=60 	align=right	 edit=none</C>
                         <C> name='단가' 		ID='YS_AMT'   		width=85 	align=right	  edit=none decao=0	sumtext='원'  sumtextalign='left'</C>
                         <C> name='금액'    	ID='YS_SUM_AMT'		width=85 	align=right	 show=true edit=none	decao=0	 sumtext='@sum' sumtextalign='right'	 </C>
                        </G>
                         <C> name='용도' 		ID='RQST_USE'    	width=150 	align=CENTER	 edit=none show=false</C>
                         <C> name='소요일' 		ID='DATE_USE'    	width=80 	align=CENTER	 edit=none	sumtext='원'  sumtextalign='left'</C>
                         <C> name='비고' 		ID='RQST_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>
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
                <b>※ 접수업무:</b> [작업상태][업체선정][접수일자][접수특기사항] 저장 　
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
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		