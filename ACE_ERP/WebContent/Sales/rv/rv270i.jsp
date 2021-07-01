<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	: 요청등록_서비스 
 * 프로그램ID 	: RV270I
 * J  S  P		 	: rv270i
 * 서 블 릿		 	: RV270I
 * 작 성 자		 	: 안준성
 * 작 성 일		 	: 2010-08-09
 * 기능정의	 	: 요청등록_서비스
 * [수  정   일  자][수정자] 내용
 * [2010-08-09][박경국] 요청등록_서비스 신규구현.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);		   
   String firsttime = m_today.format(date.getTime()).substring(8,12);		      

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
	var v_default_row = 1;
    var v_job = "H";
	<%//페이지로딩%>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	<%//트리초기화 호출%>
			cfStyleGrid(getObjectFirst("gr_default"), "comn");
			cfStyleGrid(getObjectFirst("gr_use_date"), "comn1");
	        cfStyleGrid(getObjectFirst("gr_master"), "comn1");
			cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
			fnInit();
		}
	<%// 데이타셋 헤더 설정%>
	function fnSetHeader(){
		if (ds_default.countrow < 1){
			v_job = "H";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
	            "JSP(O:DEFAULT=ds_default, O:DETAIL=ds_detail)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);           
		}
	}
	<%// 선조회%>
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>'; 
		
        v_job = "H";
        fnSetHeader();

       //지역
	   ds_business.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	   ds_business.Reset(); //지역코드                        
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
            "JSP(O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);           
        <%//대리점%>
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         
        <%//작업상태1%>
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset(); 
        <%//작업상태2%>
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();   
   }
	
	function fnSelect(){
	    if((getObjectFirst("sBgnDate").Text.trim()=="" 
            || getObjectFirst("sBgnDate").Text.trim().length!=8)){
            alert("신청일자는 필수 입력사항 입니다.");
            return;
        }
        if((getObjectFirst("sEndDate").Text.trim()=="" 
            || getObjectFirst("sEndDate").Text.trim().length!=8)){
            alert("신청일자는 필수 입력사항 입니다.");
            return;
        }
	    gr_default.ReDraw = "False";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" + "," 
					+ "sSaupSid=" + ds_business.namevalue(ds_business.rowposition,"saup_sid") + "," 
                    + "sClientSid=" + sClientSid.value + "," 
                    + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + "," 
					+ "sManageNo=" + sManageNo.text + ","                         
				    + "sDepartDate=" + sDepartDate.text + ","                         
		            + "sBgnDate=" + sBgnDate.text + ","                         
        		    + "sEndDate=" + sEndDate.text;                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
            //"JSP(O:DEFAULT=ds_default, O:DETAIL=ds_detail)",
            "JSP(O:DEFAULT=ds_default)",
            v_param);
        tr_post(tr1);
    }
    
    function fnSelectDefault(Row){
    	/* 
        if(ds_detail.IsUpdated){
            ds_default.RowPosition = v_default_row;
            alert("수정중인 데이터가 있습니다.");
            return;
       }*/
        //v_default_row = Row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sUpjangSid="+ sUpjang.ValueOfIndex ("UPJANG_SID", sUpjang.Index)
                    + ",sRsvSid="+ ds_default.NameValue(Row, "RSV_SID")
                    + ",sReqNo="+ ds_default.NameValue(Row, "REQ_NO")
                    + ",sDepartDate="+ ds_default.NameValue(Row, "DEPART_DATE");
                    //alert(v_param);
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
            //"JSP(O:MASTER=ds_master, O:DETAIL=ds_detail)",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr3);
    }
        
    function fnSelectMaster(Row){
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sUseDate="+ ds_use_date.NameValue(ds_use_date.RowPosition, "USE_DATE")
                    + ",sUpjangSid="+ sUpjang.ValueOfIndex ("UPJANG_SID", sUpjang.Index)
                    + ",sRsvSid="+ ds_default.NameValue(ds_default.RowPosition, "RSV_SID")
                    + ",sDepartDate="+ ds_default.NameValue(ds_default.RowPosition, "DEPART_DATE");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
//            "JSP(O:MASTER=ds_master,O:DETAIL=ds_detail)",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr2);
    }
    
	<%// 행추가(그리드별)%>
	function fnAddRow(Row) {
		if ( sClientSid.value == '' ) {
			alert("대리점을 선택해 주세요");
			return;
		}
		ds_default.addrow();
		ds_default.namevalue(ds_default.rowposition,"client_sid") = sClientSid.value;
		ds_default.namevalue(ds_default.rowposition,"accept_date") = '<%=firstday%>';
		ds_default.namevalue(ds_default.rowposition,"accept_time") = '<%=firsttime%>';		
		lc_status2.index = lc_status2.IndexOfColumn("detail", "RR");
		ds_default.namevalue(ds_default.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");	
		for ( i=1;i<=ds_client_info.CountRow;i++ ) {
			if ( sClientSid.value == ds_client_info.namevalue(i,"client_sid") )  {
				client_dam_nm.value = ds_client_info.namevalue(i,"client_dam_nm");
				mobile_no.value = ds_client_info.namevalue(i,"tel_no");
				break;
			}
		}
		var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sUpjangSid="+ sUpjang.ValueOfIndex ("UPJANG_SID", sUpjang.Index)
                    + ",sRsvSid="+ ds_default.NameValue(Row, "RSV_SID")
                    + ",sDepartDate="+ ds_default.NameValue(Row, "DEPART_DATE");
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
            //"JSP(O:MASTER=ds_master, O:DETAIL=ds_detail)",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr3);
	}
	<%// 행삭제(그리드별)%>
	function fnDeleteRow() {
		ds_default.deleterow(ds_default.rowposition);
	}
	<%// 적용%>
	function fnApply() {
		if ( ds_default.isUpdated ) {	
			for ( i=1; i<= ds_default.CountRow; i++ )  {
				if ( ds_default.RowStatus(i) == 1 || ds_default.RowStatus(i) == 3 ) {	<%//insert||update 인 경우%>
					//저장 전 체크
					if(ds_default.namevalue(i,"accept_sid") == '' || ds_default.namevalue(i,"accept_sid") == '0' ) {
						alert("신청서 번호를 입력해 주세요.");
						return;
					}			
					if(ds_default.namevalue(i,"rsv_sid") == '' || ds_default.namevalue(i,"rsv_sid") == '0' ) {
						alert("성명을 입력해 주세요.");
						return;
					};
				}
			}
		}
        v_job = "I";	
		window.status="저장 중입니다. 잠시만 기다려 주십시오...";

		ln_TRSetting(tr1, 
             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
             "JSP(I:DEFAULT=ds_default,I:MASTER=ds_master,I:DETAIL=ds_detail,O:reqNoDS=reqNoDS,O:msgDS=msgDS,O:RESULT=ds_result)",
             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
         tr_post(tr1);
	}
	//취소
	function fnCancel() {
		if (ds_default.IsUpdated ) {
			ds_default.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
		if (ds_master.IsUpdated ) {
			ds_master.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
		if (ds_detail.IsUpdated ) {
			ds_detail.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	/*
	 * 대리점팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup1() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=1";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];					
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	} 	
	// 신청서 번호 팝업
	function fnPopup2() {    
		if ( sClientSid.value == '' ) {
			alert("대리점를 선택해 주세요");
			return;
		}             
		if ( depart_date.text.trim() == '' ) {
			alert("출발일자를 입력해 주세요.");
			return;
		}             		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv011h.jsp?sClientSid="+sClientSid.value+"&sDepartDate="+depart_date.text;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
	    	accept_sid.value = arrParam[0];
			accept_no.value = arrParam[1];
		} else {
	    	accept_sid.value = 0;
			accept_no.value = '';
		}
	} 	

	//취소|환불 요청고객정보 팝업
	function fnPopup3() { 
		if ( sClientSid.value.trim() == '' || sClientSid.value.trim() == '0' ) {
			alert("대리점를 선택해 주세요");
			return;
		}
		if ( accept_sid.value.trim() =='' || accept_sid.value.trim() == '0' ) {
			alert("신청서 번호를 입력해 주세요.");
			return;
		}
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "<%=dirPath%>/Sales/help/rv012h.jsp?sClientSid="+sClientSid.value+"&sAcceptSid="+accept_sid.value+"&sAcceptDate="+accept_date.text+"&sAcceptTime="+accept_time.text;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			rsv_sid.value = arrParam[8];							
	    	cust_sid.value = arrParam[0];				
	    	cust_nm.value = arrParam[1];
	    	manage_no.value = arrParam[2];
	    	depart_date.text = arrParam[15];								
			depart_time.text = arrParam[16];														
		} else {
			rsv_sid.value = 0;									
	    	cust_sid.value = 0;			
	    	cust_nm.value = '';
	    	manage_no.value = '';
	    	cust_mobile_no.value = '';
			depart_time.text = '';								
		}
	} 	
	
	// 대리점 자동셋팅(조건)
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 
	
	//대리점 자동셋팅(조건)
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 	
	//작업상태 셋팅
	// 요청취소(RC)인 것만 요청(RR)로 수정할 수 있습니다.!
	function fnStatusSet(status) {
		if ( ds_default.namevalue(ds_default.rowposition,"status_cd") == 'RC' ) {
			lc_status2.index = lc_status2.IndexOfColumn("detail", status);		
		} else {
			alert("[요청취소]상태인 것들만 [요　청]으로 수정할 수 있습니다.");
		};
	}
	//이용일자 조회
    function fnSelectUseDate(){
	    gr_default.ReDraw = "False";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" 
			    	+ ",sRsvSid="+ rsv_sid.value; 
        //alert(v_param);                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
            "JSP(O:USE_DATE=ds_use_date)",
            v_param);
        tr_post(tr1);
    }
</script>	    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<script language=JavaScript for=sSaupSid event=OnSelChange()>
	var v_param = "dsType=1"
                + "&proType=S"
                + "&s_SaupSid="+sSaupSid.ValueOfIndex("SAUP_SID", sSaupSid.Index)
                + "&s_UpjangType=99"
                + "&s_use_yn=Y";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //업장
</script>
<script language=JavaScript for=sUpjang event=OnSelChange()>
    if(ds_default.CountRow==0)	return;
    if(cust_nm =='') {
    	alert("성명을 먼저 조회 하세요"); 
    	return;
    }
    fnSelectUseDate();
</script>
<script language=javascript for=ds_use_date event="OnLoadCompleted(Row)">
    fnSelectMaster(Row);
</script>
<script language=javascript for=gr_use_date event="OnClick(Row,Colid)">
	fnSelectMaster(Row);
</script>
<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
	var index=lc_status2.IndexOfColumn("detail", ds_default.namevalue(ds_default.Rowposition,"status_cd"));
	lc_status2.index=index;
    //gr_default.ReDraw = "True";
	if ( ds_default.CountRow > 0 )
				fnSelectDefault();
</script>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(ds_result.CountRow>0){
        for(var i=1, j=1; i<=ds_detail.CountRow; i++){
            if(ds_detail.RowStatus(i)==1){
                ds_detail.NameValue(i, "KEY_SEQ")=ds_result.NameValue(j, "KEY_SEQ");
                j++;
            }
        }
    }
    ds_detail.ResetStatus();
</script>
<script language=javascript for=gr_default event="OnClick(Row,Colid)">
	//var index=lc_status2.IndexOfColumn("detail", ds_default.namevalue(ds_default.Rowposition,"status_cd"));
	//lc_status2.index=index;
    if(Row<1) return;
    //if(v_default_row==Row) return;
    fnSelectDefault(Row);
</script>
<script language=javascript for=gr_master event="OnDblClick(Row,Colid)">
    if(Row==0) return;
    ds_detail.AddRow();
    ds_detail.NameValue(ds_detail.RowPosition, "USE_DATE")	   	= ds_use_date.NameValue(ds_use_date.RowPosition, "USE_DATE");
    ds_detail.NameValue(ds_detail.RowPosition, "RSV_SID")	    	= ds_default.NameValue(Row, "RSV_SID");
//    ds_detail.NameValue(ds_detail.RowPosition, "USE_DATE")    	= ds_use_date.NameValue(Row, "USE_DATE");
    ds_detail.NameValue(ds_detail.RowPosition, "UPJANG_SID")    	= ds_master.NameValue(Row, "UPJANG_SID");
    ds_detail.NameValue(ds_detail.RowPosition, "UPJANG_NM")     	= ds_master.NameValue(Row, "UPJANG_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "MENU_SID")     	= ds_master.NameValue(Row, "MENU_SID");
    ds_detail.NameValue(ds_detail.RowPosition, "MENU_NM")       	= ds_master.NameValue(Row, "MENU_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "USE_SEQ")      	= ds_master.NameValue(Row, "USE_SEQ");
    ds_detail.NameValue(ds_detail.RowPosition, "AVAILABLE_CNT")	= ds_master.NameValue(Row, "AVAILABLE_CNT");
    ds_detail.NameValue(ds_detail.RowPosition, "UNIT_AMT")      	= ds_master.NameValue(Row, "UNIT_AMT");
    ds_detail.NameValue(ds_detail.RowPosition, "CURRENCY_NM")   = ds_master.NameValue(Row, "CURRENCY_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "REMARKS")       	= ds_master.NameValue(Row, "REMARKS");
    ds_detail.NameValue(ds_detail.RowPosition, "CURRENCY_CD")   = ds_master.NameValue(Row, "CURRENCY_CD");
    ds_detail.NameValue(ds_detail.RowPosition, "EXCH_AMT")      	= ds_master.NameValue(Row, "EXCH_AMT");
    //ds_master.DeleteRow(Row);
</script>
<script language=javascript for=gr_detail event="OnDblClick(Row,Colid)">
    if(Row==0) return;
    if(ds_detail.RowStatus(Row)!=1) return; //add된 상태여야지만 빠진다..ㅎ;
    ds_master.AddRow();
    ds_master.NameValue(ds_master.RowPosition, "UPJANG_SID")    	= ds_detail.NameValue(Row, "UPJANG_SID");
    ds_master.NameValue(ds_master.RowPosition, "UPJANG_NM")    	= ds_detail.NameValue(Row, "UPJANG_NM");
    ds_master.NameValue(ds_master.RowPosition, "MENU_SID")      	= ds_detail.NameValue(Row, "MENU_SID");
    ds_master.NameValue(ds_master.RowPosition, "MENU_NM")       	= ds_detail.NameValue(Row, "MENU_NM");
    ds_master.NameValue(ds_master.RowPosition, "USE_SEQ")      	= ds_detail.NameValue(Row, "USE_SEQ");
    ds_master.NameValue(ds_master.RowPosition, "AVAILABLE_CNT")	= ds_detail.NameValue(Row, "AVAILABLE_CNT");
    ds_master.NameValue(ds_master.RowPosition, "UNIT_AMT")      	= ds_detail.NameValue(Row, "UNIT_AMT");
    ds_master.NameValue(ds_master.RowPosition, "CURRENCY_NM")   = ds_detail.NameValue(Row, "CURRENCY_NM");
    ds_master.NameValue(ds_master.RowPosition, "REMARKS")       	= ds_detail.NameValue(Row, "REMARKS");
    ds_master.NameValue(ds_master.RowPosition, "CURRENCY_CD")   = ds_detail.NameValue(Row, "CURRENCY_CD");
    ds_master.NameValue(ds_master.RowPosition, "EXCH_AMT")      	= ds_detail.NameValue(Row, "EXCH_AMT");
    ds_detail.DeleteRow(Row);
</script>
<script language=javascript for=gr_detail event="OnExit(Row,Colid,OldData)">
    if(Row==0) return;
    if(Colid=="SALE_QTY"){
		ds_detail.NameValue(Row, "SUM_AMT") = ds_detail.NameValue(Row, "EXCH_AMT") * 
		ds_detail.NameValue(Row, "SALE_QTY") * ds_detail.NameValue(Row, "UNIT_AMT");
    }
</script>
<script language=JavaScript for= lc_status2 event=OnSelChange()>
	ds_default.namevalue(ds_default.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");		
</script>	
<script language=JavaScript for=sBgnDate event=OnKillFocus()> 
	if ( sBgnDate.Modified ) {
		sEndDate.text = sBgnDate.text;
	}
</script>	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
          	            
			//req_no셋팅          	            
            var count=1;
            for ( i=1;i<=ds_default.CountRow;i++ ) {
            	if ( ds_default.namevalue(i,"req_no") == '' )
		            ds_default.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds_default.ResetStatus();
            
            //메시지 처리
			if ( msgDS.CountRow > 0 ) {
		        for ( j=1; j<=msgDS.CountRow; j++ )
		          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
				if(msg!='')
					alert(msg);
		    }
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = tr1.SrvErrMsg("ERROR", i) + "\n";
		
		if(alertMsg!='')
			alert(alertMsg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            var count=1;
            for ( i=1;i<=ds_default.CountRow;i++ ) {
            	if ( ds_default.namevalue(i,"req_no") == '' )
		            ds_default.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds_default.ResetStatus();
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
	<script language="javascript" for="tr_save" event="onfail()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
        
    fnSelect();
</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_use_date classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  업장명 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_status2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=reqNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_business classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="50px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >																																								
					 			</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>											
	</tr>
	<tr height="30px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					 <td class="text" width="70">지역</td>
		                         <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=sSaupSid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
		                                <param name=ComboDataID     value=ds_business>
		                                <param name=BindColumn      value="saup_sid">
		                                <param name=BindColVal      value="saup_sid">
		                                <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
		                                <param name=ListExprFormat  value="saup_nm^0^120">
		                            </object>
		                            <%=HDConstant.COMMENT_END%>
		                        </td>  
            					<td align=left width=70 class="text">&nbsp;대리점</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sClientSid" type="hidden" value="<%=c_sid%>">                                
									<input id="sClientCd" type="text" class="textbox" value="<%=c_cd%>" style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="textbox_d" value="<%=c_nm%>" style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>		
            					<td align=left width=70 class="text">&nbsp;신청일자</td>
                                <td align=left bgcolor="#ffffff" width=300>&nbsp;																										
								     <%=HDConstant.COMMENT_START%>
								     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>	
								<td align=left width=70 class="text">&nbsp;작업상태</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status1>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>
								<td class="text">주민번호</td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=sManageNo classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
		                                <param name=Format      value="ZZZZZZZZZZZZZ">
		                                <param name=Alignment   value=1>
		                                <param name=ClipMode    value=true>
		                                <param name=Border      value=false>
		                                <param name=Enable      value=true>
		                                <param name=UpperFlag   value=1>
		                                <param name=SelectAll   value=true>
		                                <param name=SelectAllOnClick      value=true>
		                                <param name=SelectAllOnClickAny   value=false>
		                            </object>
		                            <%=HDConstant.COMMENT_END%>
		                        </td>
								<td class="text"  width="70">출발일자</td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=sDepartDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
		                                <param name=Text        value="">
		                                <param name=Alignment   value=1>
		                                <param name=Format      value="YYYY-MM-DD">
		                                <param name=InputFormat value="YYYYMMDD">
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
		                    </tr>
            			</table>
					</td>
				</tr>															
			</table>	
		</td>											
	</tr>
	<tr>
		<td height="10"></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="290px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> style="width=290px; height:370" border="1" >
             				<param name="DataID"		VALUE="ds_default">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
                            <param name="ViewSummary" value="1">
							<param name="Format" 			value="
				                <C> name='작업상태'   		ID='status_cd' 		width=60  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true sumtext=계</C>
				                <C> name='신청일자'   		ID='accept_date'  	width=70  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX sumtext=@count suppress=1</C>
				                <C> name='신청번호'   		ID='accept_no'  	width=100 	sumcolor=#000000 sumbgcolor=#E0CFE4 align=center editlimit=15 edit=none show=true sumtext=건 suppress=2</C>
				                <C> name='이름'      		ID='cust_nm'   		width=60  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=30 edit=none show=true suppress=3</C>															                
				                <C> name='요청관리번호'  ID='req_no'  			width=100  sumcolor=#000000 sumbgcolor=#E0CFE4 align=center editlimit=20 edit=none show=true suppress=4</C>															                
				                <C> name='대리점SID' 		ID='client_sid' 		width=60  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=12 show=false</C>
				                <C> name='신청시간'  		ID='accept_time'     sumcolor=#000000 sumbgcolor=#E0CFE4    align=left show=false </C>															                
				                <C> name='담당자'        	ID='client_dam_nm'  sumcolor=#000000 sumbgcolor=#E0CFE4    align=left editlimit=20 show=false</C>
				                <C> name='연락처'    		ID='mobile_no'   	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left  editlimit=15 show=false</C>
				                <C> name='출발일'  			ID='depart_date'  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left  editlimit=8 show=false</C>
				                <C> name='출발시간'  		ID='depart_time'  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left  editlimit=8 show=false</C>															                
				                <C> name='신청SID'   		ID='accept_sid'  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left  editlimit=12 show=false</C>
				                <C> name='예약SID'      	ID='rsv_sid'     		sumcolor=#000000 sumbgcolor=#E0CFE4 align=left  editlimit=12 show=false</C>
				                <C> name='고객SID'     	ID='cust_sid'    		sumcolor=#000000 sumbgcolor=#E0CFE4 align=left  editlimit=12 show=false</C>
				                <C> name='주민/여권번호'    ID='manage_no'   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=20 show=false</C>
				                <C> name='직장명'   		ID='company_nm' 	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=30 show=false</C>
				                <C> name='직위'    			ID='positions'   		sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=30 show=false</C>
				                <C> name='연락처'    		ID='cust_mobile_no'   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=15 show=false</C>
				                <C> name='판매가'      		ID='tour_amt'      	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=33 show=false</C>															                
				                <C> name='입금액'      		ID='pay_amt'      	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=33 show=false</C>
				                <C> name='환불요청금액'  ID='rq_amt'         	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=12 show=False</C>
				                <C> name='환불액'  			ID='rq_amt'         	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=12 show=False</C>
				                <C> name='공제코드'    	ID='charge_cd'    	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=1 show=False</C>
				                <C> name='표준공제율'     ID='charge_rate'  	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	show=false</C>														                
				                <C> name='송금은행'        ID='bancod'       	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=2 show=False</C>
				                <C> name='송금은행명'     ID='bannm'       	sumcolor=#000000 sumbgcolor=#E0CFE4 align=left 	editlimit=50 show=false</C>
				                <C> name='송금계좌'  		ID='bank_acc_no'         sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=20 show=false</C>
				                <C> name='예금주' 			ID='bank_acct_nm'        sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=32 show=false</C>
				                <C> name='사유'       		ID='reason'      		sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=200 show=false</C>
				                <C> name='처리결과' 		ID='desc'        		sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=200 show=false</C>	
				               	<C> name='취소' 				ID='job_type'   		sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=200 show=false</C>						                
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
					<td width="25px">
					</td>					
					<td align="left" valign="top" width="530px">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="530px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업상태</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left"  colspan="3">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_status2>
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=Enable2  value=false>																											
															</object>
															<%=HDConstant.COMMENT_END%>
															<img src="<%=dirPath%>/Sales/images/refund_rq.gif"   	style="cursor:hand;position:relative;top:1px" onclick="fnStatusSet('RR')">
														</td>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청일</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																											
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																						
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																										
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">요청관리번호</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="req_no" type="text" class="textbox_d"   value="" size="20" readonly>
														</td>																																																			
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">담당자</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="client_dam_nm" type="text" class="textbox"   value="담당자" size="20">
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">연락처</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="textbox"   value="010-3399-0101" size="20">
														</td>	
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">출발일</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청서번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;                                
															<input id="accept_no" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="신청서번호를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2();">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">성명</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">																									
															<input type="hidden" id="cust_sid" value="0">&nbsp;
															<input id="cust_nm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="고객정보를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup3();">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주민/여권번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="textbox_d"  size="20" value="" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">요청의견</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="textbox"  size="50" value=""  style="text-align: left" >
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">접수의견</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc" type="text" class="textbox_d"  " size="50" value="" bgcolor="#FFFFFF" style="text-align: left"  readonly>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr height=100>
								<td>
									<table width="100%" border=0 cellspacing=0 cellpadding=0>
										<tr height=5>
											<td>
												<table width="100%" border=0 cellspacing=1 cellpadding=0 bgcolor="#666666">
													<tr>
														<td class="text">영업장</td>
														<td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
															<object id=sUpjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=172 style="position:relative;left:1px;top:2px" class="txtbox" >
																<param name=ComboDataID         value=ds_upjang>
																<param name=SearchColumn        value="upjang_nm">
																<param name=Sort                value="false">
																<param name=ListExprFormat      value="upjang_nm^0^180">
																<param name=BindColumn          value="upjang_sid">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr height=5><td></td></tr>
										<tr>
											<td>
												<%=HDConstant.COMMENT_START%>
												<object id=gr_use_date classid=<%=HDConstant.CT_GRID_CLSID%> width='70px' height='180px' border='1'>
													<param name="DataID"          value="ds_use_date">
													<param name="BorderStyle"  	value="0">
						                			<param name=ColSizing       	value="true">
						                			<param name="editable"      	value="true">
						                			<param name=UsingOneClick  	value="1">
						                            <Param Name="AllShowEdit"   value="True">
						                            <param name="SortView"       value="Right">
						                            <param name="ViewSummary" value="1">
													<param name="Format"          value="
														 <C> name='이용일자'  ID='USE_DATE'     width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX </C>
												 ">
												</object>
												<%=HDConstant.COMMENT_END%>
												<%=HDConstant.COMMENT_START%>
												<object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='458px' height='180px' border='1'>
													<param name="DataID"            value="ds_master">
													<param name="ColSizing"         value="true">
													<param name="Editable"          value="true">
													<param name="SuppressOption"    value="1">
													<param name="BorderStyle"       value="0">
													<param name="Format"            value="
														 <C> name='RSV_SID' 	ID='RSV_SID'       	sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None DEC=0 show=false</C>
														 <C> name='영업장'  	ID='UPJANG_NM'    sumcolor=#000000 sumbgcolor=#E0CFE4 width=70 align=left Edit=None suppress=1</C>
														 <C> name='항목'    		ID='MENU_NM'       sumcolor=#000000 sumbgcolor=#E0CFE4 width=150 align=left Edit=None</C>
														 <C> name='가용' 		ID='AVAILABLE_CNT'       sumcolor=#000000 sumbgcolor=#E0CFE4 width=60 align=right Edit=None DEC=0</C>
 														 <C> name='회차' 		ID='USE_SEQ'        sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None DEC=0</C>
														 <C> name='단가' 		ID='UNIT_AMT'        sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None DEC=0</C>
														 <C> name='통화'    		ID='CURRENCY_CD'   sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=center Edit=None </C>
														 <C> name='환율'    		ID='EXCH_AMT'       	sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=center Edit=None dec=0</C>
														 <C> name='소개'    		ID='REMARKS'        	sumcolor=#000000 sumbgcolor=#E0CFE4 width=95 align=left Edit=None</C>
												 ">
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>
										</tr>
										<tr height=5><td></td></tr>
										<tr>
											<td>
												<%=HDConstant.COMMENT_START%>
												<object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='530px' height='200px' border='1'>
													<param name="DataID"            value="ds_detail">
													<param name="ColSizing"         value="true">
													<param name="Editable"          value="true">
													<param name="SuppressOption"    value="1">
													<param name="BorderStyle"       value="0">
													<param name=UsingOneClick       value="1">
													<Param Name="AllShowEdit"       value="True">
													<param name="ViewSummary"       value="1">
													<param name="Format"            value="
														 <C> name='RSV_SID' 		ID='RSV_SID'       	sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None DEC=0 show=false </C>
														 <C> name='이용일자'  		ID='USE_DATE'     	sumcolor=#000000 sumbgcolor=#E0CFE4 width=70 align=center editlimit=8 bgcolor='<%=HDConstant.GRID_ITEM%>' sumtext=계 edit=none show=true mask=XXXX-XX-XX suppress=1</C>
														 <C> name='영업장'          ID='UPJANG_NM'    sumcolor=#000000 sumbgcolor=#E0CFE4 width=70 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' sumtext=@count suppress=2</C>
   													     <C> name='항목'          	ID='MENU_NM'   	sumcolor=#000000 sumbgcolor=#E0CFE4 width=100 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' sumtext='건'  suppress=3</C>
														 <C> name='회차' 			ID='USE_SEQ'      	sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None DEC=0 bgcolor='<%=HDConstant.GRID_ITEM%>' suppress=4</C>
														 <C> name='가용' 			ID='AVAILABLE_CNT'  sumcolor=#000000 sumbgcolor=#E0CFE4 width=60 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' DEC=0</C>
														 <C> name='단가'     		ID='UNIT_AMT'       sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
														 <C> name='통화'    			ID='CURRENCY_CD'  	sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
														 <C> name='환율'	      		ID='EXCH_AMT'     sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' DEC=0</C>
														 <C> name='수량'          	ID='SALE_QTY'      sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=Numeric EditLimit=5 DEC=0 SumText='금액' </C>
														 <C> name='합계\\(￦)'  ID='SUM_AMT'   	sumcolor=#000000 sumbgcolor=#E0CFE4 width=70 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0 SumText=@sum</C>
														 <C> name='예약시\\결재'  ID='RSV_PAY_YN'   sumcolor=#000000 sumbgcolor=#E0CFE4 SumText='원' width=60 align=center EditStyle=CheckBox show=true</C>
														 <C> name='기재사항'       ID='REMARKS'       sumcolor=#000000 sumbgcolor=#E0CFE4 width=100 align=left Edit=true</C>
												 ">
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>
										</tr>
									</table>
									※ [예약시 결제]를 체크해야 옵션요금 결제가능합니다.
								</td>
							</tr>
						</table>	
					</td>
				</tr>
			</table>
		</td>
	</tr>											
</table>
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds_default">           
	<param name=BindInfo	value="                                                
        <C>Col=req_no           		Ctrl=req_no           	  	Param=value </C>
        <C>Col=client_sid       		Ctrl=client_sid         		Param=value </C>
        <C>Col=accept_date      	Ctrl=accept_date        	Param=text </C>
        <C>Col=accept_time      	Ctrl=accept_time        	Param=text </C>        
        <C>Col=client_dam_nm    	Ctrl=client_dam_nm      	Param=value </C>
        <C>Col=mobile_no        	Ctrl=mobile_no          	Param=value </C>
        <C>Col=depart_date      	Ctrl=depart_date        	Param=text </C>
        <C>Col=depart_time      	Ctrl=depart_time        	Param=text </C>

        <C>Col=goods_nm			Ctrl=goods_nm				Param=value </C>
        <C>Col=confirm_yn			Ctrl=confirm_yn				Param=value </C>
        <C>Col=status_nm			Ctrl=status_nm				Param=value </C>
        
        <C>Col=accept_sid  	    	Ctrl=accept_sid         	Param=value </C>
        <C>Col=accept_no        	Ctrl=accept_no          	Param=value </C>
        <C>Col=rsv_sid          		Ctrl=rsv_sid            		Param=value </C>
        <C>Col=cust_sid         		Ctrl=cust_sid           		Param=value </C>
        <C>Col=cust_nm          	Ctrl=cust_nm           		Param=value </C>
        <C>Col=manage_no      	Ctrl=manage_no          	Param=value </C>
        <C>Col=company_nm        Ctrl=company_nm          Param=value </C>
        <C>Col=positions        		Ctrl=positions          		Param=value </C>
        <C>Col=cust_mobile_no   	Ctrl=cust_mobile_no     	Param=value </C>
        <C>Col=tour_amt         		Ctrl=tour_amt          		Param=text </C>        
        <C>Col=pay_amt          	Ctrl=pay_amt            		Param=text </C>
        <C>Col=rq_amt           		Ctrl=rq_amt             		Param=text </C>
        <C>Col=amt           			Ctrl=amt                		Param=text </C>
        <C>Col=charge_cd        	Ctrl=lc_charge   	 		Param=BindColVal</C>
        <C>Col=bancod           		Ctrl=lc_bancod          	Param=BindColVal </C>
        <C>Col=charge_rate      	Ctrl=charge_rate        	Param=value </C>        
        <C>Col=bannm            		Ctrl=bannm              		Param=value </C>
        <C>Col=bank_acc_no      	Ctrl=bank_acc_no        	Param=value </C>
        <C>Col=bank_acct_nm     	Ctrl=bank_acct_nm         Param=value </C>
        <C>Col=reason           		Ctrl=reason             		Param=value </C>
        <C>Col=desc             		Ctrl=desc               		Param=value </C>        
        <C>Col=desc2            		Ctrl=desc2              		Param=value </C>
		<C>Col=north_cnt        		Ctrl=north_cnt          		Param=value </C>  
		<C>Col=job_type         		Ctrl=sJobType           	Param=BindColVal </C>  
	">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    

<input type="hidden" name="row" value="">
<!-----------------------------------------------------------------------------
					출력물 정의부분
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="DetailDataID"			VALUE="selectImgDs">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<param name="SuppressColumns"		value="1:pageskip,skip">
		<PARAM NAME="Format"                VALUE="
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='picture_info' ,left=80 ,top=120 ,right=1900 ,bottom=2700</I>
		</B>
	">
	</object> 
<%=HDConstant.COMMENT_END%>      
<input type="hidden" name="row" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		