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
       
        v_fr_con_date.Text =  "<%=DateUtil.getCurrentDate(8)%>";
        v_to_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
         v_fr_date_cgc.Text =  "<%=DateUtil.getCurrentDate(8)%>";
        v_to_date_cgc.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //v_fr_con_date.Text = "20111114";
        //v_to_con_date.Text = "20111114";


       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//작업상태(조회)
       ds_put_wh.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU003&s_item1=Y";
       ds_put_wh.Reset();	//투입창고
       ds_terms_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU004&s_item1=Y";
       ds_terms_trans.Reset();	//인도조건
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
	        var fr_date_cgc = v_fr_date_cgc.Text.trim();
	        var to_date_cgc = v_to_date_cgc.Text.trim();
	
	       //if(fr_date.length!=8) {
	            //alert("품의일자(From)를 입력하시길 바랍니다.");
	            //return;
	        //}
	        if(to_date.length!=8) {
	            alert("품의일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_fr_con_date=" + fr_date
	                  + ",v_to_con_date=" + to_date
                      + ",v_fr_date_cgc=" + fr_date_cgc
	                  + ",v_to_date_cgc=" + to_date_cgc
                      + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index)
                       + ",v_rqst_no="+ sRqstNo.value
	                  + ",v_site_sid="+ v_site_sid.value;
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
        fnSelectDetail2(1);
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
    
     <%//detail_검수일자별 조회%>
    function fnSelectDetail3(row) {
        //v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
                    + ",v_cgc_sid="+getObjectFirst("ds_detail").NameValue(row, "CGC_SID")
                    + ",v_cgcd_sid="+getObjectFirst("ds_detail").NameValue(row, "CGCD_SID")
                    + ",v_con_sid="+getObjectFirst("ds_detail").NameValue(row, "CON_SID")
                    + ",v_date_cgcd="+getObjectFirst("ds_detail").NameValue(row, "DATE_CGCD")
                    ;
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu080S",
            "JSP(O:DS_DETAIL_DATE=ds_detail)",
            v_param);
        tr_post(tr2);
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
    

	<%//현장명 팝- 조회%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnPuSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[4];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    
	function fnSelSiteCleanup(){
	    v_site_nm.value = "";
	    v_site_sid.value  = "";
    }

	function fnExcel() {
		if(ds_default.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        } 
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:발주조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("발주조회","발주조회.xls", 8);

	    if(ds_tender.RowCount==0){
            return;
        }
        
        getObjectFirst("gr_tender").SetExcelTitle(0, "");
        getObjectFirst("gr_tender").SetExcelTitle(1, "value:견적내역; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_tender").GridToExcel("견적내역","견적내역.xls", 8);
        
         if(ds_detail.RowCount==0){
            return;
        } 
        getObjectFirst("gr_detail").SetExcelTitle(0, "");
        getObjectFirst("gr_detail").SetExcelTitle(1, "value:발주품목; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_detail").GridToExcel("발주품목","발주품목.xls", 8);
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
		arrParam[1]=ds_detail.namevalue(ds_detail.rowposition,"CON_SID");  //품의SID
		arrParam[2]=sApproveLine;      // 결재선정보 
		arrParam[4]=ds_detail.namevalue(ds_detail.rowposition,"CGCD_SID");  //검수디테일SID
		arrParam[5]=ds_detail.namevalue(ds_detail.rowposition,"DATE_CGCD");   //검수일자
		arrParam[6]=ds_detail.namevalue(ds_detail.rowposition,"RQST_SID");   //청구SID
		arrParam[7]=ds_detail.namevalue(ds_detail.rowposition,"EST_SID");   //견적SID
		arrParam[8]=ds_tender.namevalue(ds_tender.rowposition,"VEND_CD");   //거래처코드
		
		//alert(arrParam);
		strURL = "<%=dirPath%>/Pms/help/pu040h.jsp?";
		strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
		      
		if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
		} 
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

	/*
	 * 레포트
	 */
	function fnPrint() {
	
        	//기본사항 조회 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_con_sid=" + ds_detail.namevalue(ds_detail.rowposition,"CON_SID")
		                       + ",v_cgcd_sid=" + ds_detail.namevalue(ds_detail.rowposition,"CGCD_SID")
		                       + ",v_date_cgcd=" + ds_detail.namevalue(ds_detail.rowposition,"DATE_CGCD");
		                       
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT6=ds_default6)",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
		     // 견적품목
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_con_sid=" + ds_detail.namevalue(ds_detail.rowposition,"CON_SID")
 	                       + ",v_date_cgcd=" + ds_detail.namevalue(ds_detail.rowposition,"DATE_CGCD");
		                     // alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT8=ds_default8 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
     	     // 공급자준수사항
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_con_sid=" + ds_detail.namevalue(ds_detail.rowposition,"CON_SID")
 	                       + ",v_date_cgcd=" + ds_detail.namevalue(ds_detail.rowposition,"DATE_CGCD");
		                       //alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT8=ds_default8 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
	       // 청구(현장)결재정보		    
	     	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                     + ",v_con_sid="  + ds_detail.namevalue(ds_detail.rowposition,"CON_SID")
		                     + ",v_date_cgcd="  + ds_detail.namevalue(ds_detail.rowposition,"DATE_CGCD");
		 	//alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT10=ds_default10)",  param);
		     tr_post(tr1);
		     
     		pr1.PreView();
    }

 </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%//품의정보 클릭시 공급업체조회 %>
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
<%//공급업체클릭시 품목 조회 %>
	<script language=javascript for="gr_tender" event="OnClick(Row, Colid)">
			    fnSelectDetail2(Row);				
	</script>
	
<%//검수일자클릭시 해당날짜의 품목 조회 %>
	<script language=javascript for="gr_detail" event="OnDblClick(Row, Colid)">
	    	  fnSelectDetail3(Row);				
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
<object id=ds_put_wh classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 투입창고 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_date_ddl classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  납기일자 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  인도조건 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_pay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지불조건 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bur_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  운반지부담 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_default6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트--%>
<object id=ds_default8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트_서브1--%>
<object id=ds_default8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트_서브2--%>
<object id=ds_default9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트_서브3--%>
<object id=ds_default10 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트_서브4--%>
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
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">		<!-- 엑셀 -->
							<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:pointer"  onclick="fnPrint()">		<!-- 인쇄 -->							
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
			                        <td align=left class="text"  width="70">품의일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">
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
			                            <object id=v_to_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">            
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
			                        <td align=left class="text"  width="70">검수일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_date_cgc classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">
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
			                            <object id=v_to_date_cgc classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">            
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
			                        <td align=left bgcolor="#ffffff" WIDTH="120">&nbsp;<%=HDConstant.COMMENT_START%>
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
			             		<tr>
									<td align=left width="70px" class="text">청구번호</td>
									<td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sRqstNo" value="" size="20" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>			                        
								    <td align="center" class="text" width="70">현장명</td>
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">
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
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='200px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="0">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name=SortView  value="Right">
                                <param name="Format"            value="
	                                 <C> name='작업상태'	ID='CON_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='작업상태'	ID='CON_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=false	</C>
                                     <C> name='청구일자' 	ID='RQST_DATE'    		width=70 	align=CENTER	Edit=None sort=true		</C>
                                     <C> name='품의일자' 	ID='DATE_CON'    		width=70 	align=CENTER	Edit=None sort=true		</C>
                                     <C> name='검수일자' 	ID='DATE_CGC'    		width=80 	align=CENTER	Edit=None sort=true		show=false </C>                                     
                                     <C> name='납기일자'		ID='DATE_DDL'    		width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='품의번호'	ID='CON_NO' 				width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='품의SID'    ID='CON_SID'       		width=60 	align=CENTER	Edit=None	 	 show=false decao=0	Edit=None </C>                                     
                                     <C> name='견적SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None </C>
                                     <C> name='청구번호' 	ID='RQST_NO'	    		width=150 	align=CENTER	Edit=None sort=true		</C>
                                     <C> name='청구SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장담당자'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장명'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='현장SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 		 show=false  </C>
                                     <C> name='사용처'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None		 show=false </C>
                                     <C> name='투입창고'		ID='PUT_WH' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='인도조건'    	ID='TERMS_TRANS' width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='검사방법'		ID='WAY_CHK' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='지불조건'		ID='TERMS_PAY'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='운반비부담'	ID='BUR_TRANS' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='공급자 준수사항'    ID='OSV_PVR'  width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='품의특기사항'		ID='CON_NOTE' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='검수특기사항'		ID='CGC_NOTE' 		width=60 	align=CENTER	Edit=None		show=false</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">현장담당자</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_empno' id="v_pu_empno" style="width:100px;" class='input01' readOnly="readonly" > </td>
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
									<input type="hidden"  name='v_con_sid' id='v_con_sid'>
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
										<input type="hidden" name='v_rqst_sid' id="v_rqst_sid" >
										<input type="hidden" name='v_est_sid' id="v_est_sid" >
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">공급자 준수사항</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_osv_pvr' id="v_osv_pvr" style="width:300px;" class='input01' readOnly="readonly"  >
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
        <tr>
        	<td align=right>
        	<b>[공급업체]</b>
        	</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='38px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="false">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='선정여부' 			ID='CHOICE_YN'	   	width=80 		align=CENTER	edit=none show=false</C>
	                     <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none  show=false </C>
                         <C> name='거래처코드' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false</C>
                         <C> name='협력사명' 			ID='VEND_NM'    		width=150 	align=CENTER	edit=none</C>
                         <C> name='견적금액'			ID='TOT_EST_AMT'  width=90 		align=right 	 decao=0 edit=none </C>
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
			   <b>[품목]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_detail" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='300px' border='1'  bgcolor='green'>
                    <param name="DataID"            value="ds_detail">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="false">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="ViewSummary"       value="1">
                    <param name="Format"            value="
                         <C> name='순번'     	   	    ID=CurRow   	    width=50	    align=center  show=false edit=none Value={CurRow}</C>
                         <C> name='EST_SID' 			ID='EST_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='CON_SID' 		ID='CON_SID'   		width=80 		align=CENTER		edit=none  show=false</C>
                         <C> name='RQST_SID' 		ID='RQST_SID'   	width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='ITEM_SID' 		ID='ITEM_SID'   	width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='검수마스터SID' 			ID='CGC_SID'	   	width=200 		align=CENTER	edit=none show=false	</C>
                         <C> name='검수디테일SID' 			ID='CGCD_SID'	   	width=200 		align=CENTER	edit=none show=false	/C>
                         <C> name='검수일자'	 		ID='DATE_CGCD'   	width=80 		align=CENTER	editlimit=8	edit=true show=true		suppress=1</C>
                         <C> name='품명' 				ID='ITEM_NM'    	width=150 	align=CENTER	 	edit=none sumtext='총'  sumtextalign='right' suppress=2</C>
                         <C> name='규격' 				ID='ITEM_SIZE'   	width=150 		align=CENTER	 	edit=none sumtext='@count' sumtextalign='right' suppress=3</C>
                         <C> name='단위' 				ID='ITEM_UNIT'   	width=60 		align=CENTER		edit=none sumtext='품목' sumtextalign='left' suppress=4</C>
                         <C> name='수량' 				ID='EST_CNT'   	width=60 		align=CENTER		edit=none </C>
						<G> name='결정'
                         <C> name='단가' 				ID='FN_EST_AMT'   	width=85 		align=right	 decao=0 	edit=none</C>
                         <C> name='금액'    				ID='FN_SUM_AMT'  	width=85 		align=right	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
                         </G>
						<G> name='전회정산'
	  						 <C> name='수량' 		ID='CGCD_PRE_CNT'	width=85 		align=right	 show=false	decao=0 		edit=none</C>
    	                     <C> name='금액'    		ID='CGCD_PRE_AMT'  width=85 		align=right	 show=false	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
						</G>
						<G> name='금월정산'
 							 <C> name='수량' 		ID='CGCD_NOW_CNT'	width=85 		align=right	 show=true	decao=0 	 	edit=true	</C>
            	             <C> name='금액'    		ID='CGCD_NOW_AMT'  	width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none	</C>
						</G>
						<G> name='누계정산'
							 <C> name='수량' 		ID='CGCD_SUM_CNT'	width=85 		align=right	 show=true	decao=0 		edit=none</C>
                    	     <C> name='금액'    		ID='CGCD_SUM_AMT'  width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
						</G>
						<G> name='잔여분'
							 <C> name='수량' 		ID='CGCD_RES_CNT'	width=85 		align=right	 show=true	decao=0 	 	edit=none</C>
                         	<C> name='금액'    		ID='CGCD_RES_AMT'  width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
						</G>
                         <C> name='검수특기사항V' 	ID='CGCD_NOTE'   		width=200 		align=CENTER	edit=true show=true</C>                                                  
						<G> name='도급'
                         <C> name='단가'    			ID='DG_AMT'    	    width=85 		align=right	 show=false  decao=0	sumtext='원' sumtextalign='left'	edit=none </C>
                         <C> name='금액'   			ID='DG_SUM_AMT'   width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=false  edit=none	decao=0	 </C>
                         </G>
                         <G> name='예산'
                         <C> name='단가' 			ID='YS_AMT'   			width=85 		align=right	 decao=0 sumtext='원' sumtextalign='left'	show=false edit=none</C>
                         <C> name='금액'    			ID='YS_SUM_AMT'    width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=false  edit=none	decao=0	 </C>
                         </G>
                         <C> name='거래처코드' 	ID='VEND_CD'   		width=200 		align=CENTER	edit=none show=false</C>                                                  
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
    </table> 
    <table>
    <BR>
    <B>** [조회] ==> [품목]에서 [검수일자]더블클릭 ==> [결재선지정] ==> [기안]</B>
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
		<param NAME="MasterDataID"				VALUE=ds_default6>
		<PARAM NAME="PaperSize"					VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="true">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<PARAM NAME="Format"                VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=587 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=839 ,top=151 ,right=1677 ,bottom=225 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=828 ,top=127 ,right=1662 ,bottom=206 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=148 ,top=296 ,right=2717 ,bottom=587 ,border=true ,penstyle=solid ,penwidth=5</X>
	<T>id='강원도 고성군 현내면 초도리 258-2' ,left=1397 ,top=500 ,right=1931 ,bottom=566 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='221-81-13834' ,left=1368 ,top=307 ,right=1931 ,bottom=362 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1140 ,top=373 ,right=2717 ,bottom=373 </L>
	<L> left=1140 ,top=296 ,right=1140 ,bottom=587 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='청구번호' ,left=1971 ,top=397 ,right=2135 ,bottom=458 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현 장 명' ,left=1971 ,top=500 ,right=2135 ,bottom=561 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='품의번호' ,left=1971 ,top=304 ,right=2135 ,bottom=365 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1140 ,top=482 ,right=2717 ,bottom=482 </L>
	<L> left=243 ,top=482 ,right=1050 ,bottom=482 </L>
	<L> left=243 ,top=373 ,right=1050 ,bottom=373 </L>
	<T>id='등록번호' ,left=1143 ,top=304 ,right=1352 ,bottom=365 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=460 ,top=296 ,right=460 ,bottom=587 </L>
	<L> left=1050 ,top=296 ,right=1050 ,bottom=587 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=296 ,right=2154 ,bottom=587 </L>
	<T>id='자' ,left=1053 ,top=519 ,right=1140 ,bottom=566 ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='는' ,left=1053 ,top=466 ,right=1140 ,bottom=513 ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='받' ,left=1053 ,top=413 ,right=1140 ,bottom=460 ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=1053 ,top=360 ,right=1140 ,bottom=407 ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=1058 ,top=307 ,right=1140 ,bottom=355 ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=243 ,top=296 ,right=243 ,bottom=587 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='VEND_ID', left=474, top=302, right=1032, bottom=362 ,mask='XXX-XX-XXXXX', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='물 품 인 수 증' ,left=831 ,top=116 ,right=1659 ,bottom=193 ,face='HY중고딕' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='ADDRESS1', left=471, top=489, right=1037, bottom=572, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CON_NO', left=2164, top=302, right=2699, bottom=368, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SITE_NM', left=2167, top=497, right=2701, bottom=564, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RQST_NO', left=2164, top=397, right=2699, bottom=463, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공' ,left=156 ,top=299 ,right=241 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=156 ,top=389 ,right=241 ,bottom=474 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=156 ,top=476 ,right=241 ,bottom=561 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='VEND_NM', left=474, top=381, right=1027, bottom=426, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주    소' ,left=249 ,top=503 ,right=460 ,bottom=572 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상    호' ,left=251 ,top=400 ,right=452 ,bottom=463 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등록번호' ,left=249 ,top=304 ,right=460 ,bottom=365 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상    호' ,left=1148 ,top=397 ,right=1349 ,bottom=474 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주    소' ,left=1143 ,top=500 ,right=1352 ,bottom=566 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산(주)' ,left=1365 ,top=386 ,right=1627 ,bottom=466 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명: 조건식' ,left=1638 ,top=386 ,right=1926 ,bottom=463 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='today', left=2365, top=212, right=2712, bottom=270, align='right', face='굴림', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1953 ,top=296 ,right=1953 ,bottom=587 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1355 ,top=296 ,right=1355 ,bottom=587 </L>
	<T>id='성명:' ,left=471 ,top=429 ,right=601 ,bottom=476 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='VD_DIRECT', left=606, top=429, right=807, bottom=476, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='pu080s_s1.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default8'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=119 ,face='Arial' ,size=10 ,penwidth=5
			<X>left=148 ,top=29 ,right=2717 ,bottom=119 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=148 ,top=29 ,right=148 ,bottom=119 </L>
			<L> left=2717 ,top=29 ,right=2717 ,bottom=119 </L>
			<L> left=148 ,top=29 ,right=2717 ,bottom=29 </L>
			<L> left=243 ,top=29 ,right=243 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=831 ,top=29 ,right=831 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='No' ,left=159 ,top=40 ,right=238 ,bottom=111 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2127 ,top=29 ,right=2127 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='품     명' ,left=251 ,top=40 ,right=823 ,bottom=106 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='규   격' ,left=844 ,top=40 ,right=1270 ,bottom=106 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='단위' ,left=1283 ,top=40 ,right=1363 ,bottom=106 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='수량' ,left=1381 ,top=40 ,right=1537 ,bottom=106 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='금액' ,left=2421 ,top=77 ,right=2709 ,bottom=111 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='단가' ,left=2138 ,top=74 ,right=2416 ,bottom=108 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='금회정산' ,left=2151 ,top=34 ,right=2707 ,bottom=69 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='발주' ,left=1556 ,top=34 ,right=2114 ,bottom=69 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='금액' ,left=1831 ,top=79 ,right=2114 ,bottom=114 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='단가' ,left=1553 ,top=77 ,right=1807 ,bottom=111 ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1545 ,top=71 ,right=2712 ,bottom=71 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1815 ,top=74 ,right=1815 ,bottom=116 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2421 ,top=71 ,right=2421 ,bottom=114 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1275 ,top=29 ,right=1275 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1545 ,top=29 ,right=1545 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1378 ,top=29 ,right=1378 ,bottom=119 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=148 ,top=0 ,right=2717 ,bottom=79 ,border=true</X>
			<L> left=148 ,top=0 ,right=148 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2717 ,top=0 ,right=2717 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=243 ,top=0 ,right=243 ,bottom=79 </L>
			<L> left=831 ,top=0 ,right=831 ,bottom=79 </L>
			<L> left=1275 ,top=0 ,right=1275 ,bottom=79 </L>
			<L> left=1378 ,top=0 ,right=1378 ,bottom=79 </L>
			<L> left=1545 ,top=0 ,right=1545 ,bottom=79 </L>
			<L> left=2127 ,top=0 ,right=2127 ,bottom=79 </L>
			<C>id='ITEM_NM', left=249, top=5, right=826, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=156, top=11, right=233, bottom=66, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ITEM_SIZE', left=841, top=5, right=1267, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ITEM_UNIT', left=1283, top=5, right=1371, bottom=71, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EST_CNT', left=1384, top=8, right=1535, bottom=69, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='FN_SUM_AMT', left=1828, top=5, right=2111, bottom=71, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</C>
			<C>id='CGCD_NOW_AMT', left=2426, top=5, right=2709, bottom=71, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0</C>
			<C>id='FN_EST_AMT', left=1553, top=5, right=1810, bottom=71, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</C>
			<L> left=1815 ,top=3 ,right=1815 ,bottom=71 </L>
			<C>id='FN_EST_AMT', left=2146, top=8, right=2416, bottom=74, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0</C>
			<L> left=2421 ,top=0 ,right=2421 ,bottom=79 </L>
		</B>
		<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=80 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=148 ,top=0 ,right=2717 ,bottom=79 ,border=true</X>
			<L> left=148 ,top=0 ,right=148 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2717 ,top=0 ,right=2717 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=243 ,top=0 ,right=243 ,bottom=79 </L>
			<L> left=831 ,top=0 ,right=831 ,bottom=79 </L>
			<L> left=1275 ,top=0 ,right=1275 ,bottom=79 </L>
			<L> left=1378 ,top=0 ,right=1378 ,bottom=79 </L>
			<L> left=1545 ,top=0 ,right=1545 ,bottom=79 </L>
			<L> left=2127 ,top=0 ,right=2127 ,bottom=79 </L>
			<L> left=148 ,top=79 ,right=2717 ,bottom=79 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='계' ,left=164 ,top=13 ,right=228 ,bottom=64 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1815 ,top=0 ,right=1815 ,bottom=79 </L>
			<S>id='{Sum(FN_SUM_AMT)}' ,left=1834 ,top=8 ,right=2111 ,bottom=74 ,align='right' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</S>
			<S>id='{Sum(CGCD_NOW_AMT)}' ,left=2432 ,top=5 ,right=2709 ,bottom=71 ,align='right' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Dec=0</S>
			<L> left=2421 ,top=0 ,right=2421 ,bottom=79 </L>
		</B>
	</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='pu080s_s2.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default8'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=132 ,face='Tahoma' ,size=10 ,penwidth=1
			<C>id='OSV_PVR', left=463, top=21, right=2720, bottom=101, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='*공급자 준수사항:' ,left=148 ,top=21 ,right=452 ,bottom=101 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
	</R>
</A>
<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='pu080s_s3.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default10'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=191 ,face='Tahoma' ,size=10 ,penwidth=5
			<T>id='* 현장결재선' ,left=148 ,top=50 ,right=548 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=148 ,top=111 ,right=2048 ,bottom=191 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=775 ,top=111 ,right=775 ,bottom=191 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=556 ,top=111 ,right=556 ,bottom=191 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1175 ,top=111 ,right=1175 ,bottom=191 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1376 ,top=111 ,right=1376 ,bottom=191 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1691 ,top=111 ,right=1691 ,bottom=191 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=352 ,top=111 ,right=352 ,bottom=191 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='결재일시' ,left=1699 ,top=116 ,right=2040 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='의견' ,left=1386 ,top=116 ,right=1683 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='상태' ,left=1177 ,top=116 ,right=1365 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='부서' ,left=786 ,top=116 ,right=1167 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='결재자' ,left=362 ,top=116 ,right=548 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='구분' ,left=156 ,top=116 ,right=336 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='직위' ,left=564 ,top=116 ,right=767 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=148 ,top=0 ,right=2048 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=352 ,top=3 ,right=352 ,bottom=77 </L>
			<L> left=556 ,top=0 ,right=556 ,bottom=79 </L>
			<L> left=775 ,top=0 ,right=775 ,bottom=79 </L>
			<L> left=1175 ,top=0 ,right=1175 ,bottom=79 </L>
			<L> left=1376 ,top=0 ,right=1376 ,bottom=79 </L>
			<L> left=1691 ,top=0 ,right=1691 ,bottom=79 </L>
			<C>id='U_DATE', left=1701, top=5, right=2040, bottom=71</C>
			<C>id='AP_DESC', left=1397, top=5, right=1683, bottom=71</C>
			<C>id='AP_STATUS_D_NM', left=1180, top=5, right=1368, bottom=71</C>
			<C>id='DEPTNM', left=788, top=5, right=1167, bottom=71</C>
			<C>id='EMPNMK', left=365, top=5, right=548, bottom=71</C>
			<C>id='AP_TYPE_NM', left=153, top=3, right=331, bottom=69</C>
			<C>id='PAYGRD', left=564, top=5, right=770, bottom=71</C>
		</B>
	</R>
</A>


	">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		