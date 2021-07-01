<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 관광객|차량 예약	↔ 사업자|차량 예약
 * 프로그램ID 	: RV200I_N			↔ RV200I_N_biz
 * J  S  P  	: rv200i_N			↔ rv200i_N_biz
 * 서 블 릿     : Rv200I_N			↔ Rv200I_N_biz
 * 프로시저     : PR_RV200I_XX		↔ PR_RV200I_XX_biz
 * 기능정의     : 인원, 차량 예약신청 - 관광객 전용
 * [  일  자  ][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-10-11][심동현] 당일 중복 입력 확인하고 고치기
 * [2007-12-21][심동현] 개성지역/상품 선택시 객실타입도 조건 받아 조회
 * [2009-03-11][심동현] 국내상품 추가로 복수 상품 예약가능하게 변경 
						그외 불필요한 스크립트도 보이는 대로 정리~
 * [2010-01-06][심동현] 고객사진 경로 수정( line 609)
 * [2010-02-09][심동현] 메이저 업데이트 : 인원+차량 합체!
 * 						우측 그리드에 차량명단 GRID 추가. 따로 차량 추가 / 삭제 / 저장 
 * 						가운데 고객정보 부분 = only 관광객용으로
 * 						하단 투숙객 명단─ 관광객 전용
 * 										├ 복귀일자, 시간 개별적으로 저장될 수 있게!!!! (3박 손님등..)
 * 										├   (하지만 여기에 따르는 수많은 저장 프로시저가..음..ㅠ_ㅠ 다 체크...)
 * 										├   (하지만 여기에 따르는 수많은 저장 프로시저가..음..ㅠ_ㅠ 다 체크...)
 *										├     우대 모듈 확인(SALES.PR_DC_MAIN) (개인값) pNIGHTS,pARRIVE_DATE
 *										├     블록실적 반영(SALES.PR_RV200I_04)	pNIGHTS만 사용.(헤더 종속)
 *										├     포캐스팅 셋팅(SALES.PR_RV200I_03)	pNIGHTS,pARRIVE_DATE 둘다 사용.(==사실)
 *										├     예약디테일 입력 (trv020)	pNIGHTS,V_ARRIVE_DATE (==사실)
 *										└     관광요금 셋팅-기본요금(SALES.PR_RV200I_02) (==사실)
 *	2박 블록을 받아놓고.. 4박으로 입력하는 경우는 ? 향후..차차..;
 *		※ 블록실적 반영 정보 빼고는 다 사실 그대로!
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

    
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

    
    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i_N.js"></script>
    <script language=javascript src="<%=dirPath%>/Sales/common/js/rv200i_N.js"></script>
<%
/*=============================================================================
                Developer Java Script
=============================================================================*/
%>
    <script language="javascript">
        var v_job = "H";
        var v_ut = "<%=v_ut%>";
        var c_cd = "<%=c_cd%>";
        
        var v_dirPath = "<%=dirPath%>";
        
        subimg__a_url = new Array();
        subimg__url = new Array();
        subimg__a_url[0] = new Image();
        subimg__a_url[1] = new Image();
//        subimg__a_url[2] = new Image();
        subimg__url[0] = new Image();
        subimg__url[1] = new Image();
//        subimg__url[2] = new Image();
    
        subimg__a_url[0].src="<%=dirPath%>/Sales/images/tab_01_on.gif";
        subimg__a_url[1].src="<%=dirPath%>/Sales/images/tab_04_on.gif";
//        subimg__a_url[2].src="<%=dirPath%>/Sales/images/tab_03_on.gif";
        subimg__url[0].src="<%=dirPath%>/Sales/images/tab_01.gif";
        subimg__url[1].src="<%=dirPath%>/Sales/images/tab_04.gif";
//        subimg__url[2].src="<%=dirPath%>/Sales/images/tab_03.gif";
        
        var sub_click_img = 1;
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩
// Parameter    :
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
        
        function fnInit(){
            window.status = "초기화중입니다. 잠시만 기다려 주시길 바랍니다.";

   			fnShowLoading(410,180);
        
            changesubclick(1);
            cfStyleGrid(getObjectFirst("gr_block"), "viewField");
            cfStyleGrid(getObjectFirst("gr_cust"), "comn");
            cfStyleGrid(getObjectFirst("gr_tourlist"), "comn1");
            cfStyleGrid(getObjectFirst("gr_carlist"), "comn1");
            
            //화면 컨트롤
//            fnCustDisplay(""); (우측 고객탭)
            fnSearchDataChange(); //(상단 검색부분)

            //내외구분(bound_gu)
            init_boundDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM024&s_item1=Y";
            init_boundDs.Reset();
            
            //지역 코드
//            init_businessDs.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
//            init_businessDs.Reset();
           
            //예약타입 기초데이터 추출
            init_blockTypeDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV002";
            init_blockTypeDs.Reset();
            
            //연령
            init_ageDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV014&s_item1=Y";
            init_ageDs.Reset();
            
            //할인유형(cust_type)
            init_custTypeDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV003&s_item1=Y";
            init_custTypeDs.Reset();
            
            //사업
            init_saupGuDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CU004&s_item2=Y";
            init_saupGuDs.Reset();
            
            //동숙
            init_joinDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV006&s_item1=Y";
            init_joinDs.Reset();
            
			//2007-05-10 할인상세 추가 by 심동현 
			//자차여부 (자차=Y, 버스=N)
            init_carownerDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM021&s_item1=Y";
            init_carownerDs.Reset();
            
            //제주여부 (제주=Y, 非제주=N)
            init_jejuDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM020&s_item1=Y";
            init_jejuDs.Reset();
            
            //주말여부 (주말=Y, 주중=N)
            init_weekendDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM019&s_item1=Y";
            init_weekendDs.Reset();
			
            //테마코드(theme_cd)
            init_themeDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM018&s_item1=Y";
            init_themeDs.Reset();

			//입경시각 (RM015:관광객 시간대만item2=Y)
			init_arrTimeDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y&s_item2=Y";
			init_arrTimeDs.Reset();
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
                "JSP(O:NATION=initds1,O:PASS=initds6,O:IMAGE=imgDs)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
        }
        
        function fnCustCancel(){
            ds_cust.UndoAll();
            ds_block.NameValue(v_block_row, "RSV_PERSONS") = ds_cust.CountRow;
        }
        
        /*
         * 유치자 정보 등록
         */
        function fnHoldEmp(){
		    var strURL = "<%=dirPath%>/Sales/help/sy030h.jsp";
		    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		    var return_value = showModalDialog(strURL,arrParam,strPos); 
        	
    		if(return_value!=undefined){
    			var arrParam = return_value.split(";");
	            ds_cust.NameValue(ds_cust.RowPosition, "HOLD_EMPNO") = arrParam[0];	//empno
	            ds_cust.NameValue(ds_cust.RowPosition, "HOLD_EMPNM") = arrParam[1];	//empnm
    		}
        }
    </script>
<%
/*=============================================================================
            DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row)">
    if(Row<1) return;
//    fnCustDisplay(ds1.NameValue(Row, "COUNTRY_GU"));
</script>


<script language="javascript" for="tr1" event="OnSuccess()">
//기본 로딩할때.. 일단 한번 사용됩니다.
//상품검색할 때
//객실타입 선택 후 잔여객실수 리스트 표시할 때
//객실 리스트에서 선택해서 투숙인원 조회할 때
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert(info_msg);

	if(v_cust_flag == "S_cust"){	// 객실 눌러서 인원정보 불러올 때.
        var v_goods_sid = v_goods_nm.ValueOfIndex("GOODS_SID", v_goods_nm.Index);
        if(v_goods_sid==50){	//내금강 상품이면
        	//여기서 루프를 돌아야 할 것 같기도 한데.. 온석세스 이벤트를 이용하는게 찜찜..
			lc_theme.index = 1;	//테마코드란에 내금강 기본세팅 --------------------------------------------
        };
	};   
//	alert("175라인");        
</script>

<script language="javascript" for="tr1" event="OnFail()">
	fnHideLoading();
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_search" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    var info_cnt = tr_search.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr_search.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert(info_msg);
//	alert("205라인"); 	//출발일자 검색하면 사용 
</script>

<script language="javascript" for="tr_search" event="OnFail()">
	fnHideLoading();
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_search.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_search.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_search.ErrorCode + "\n" + "Error Message : " + tr_search.ErrorMsg + "\n");
//	alert("221라인");                
</script>

<script language="javascript" for="tr_temp" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    var info_cnt = tr_temp.SrvErrCount("INFO");
    var info_msg = "";

    for(var i=1; i<=ds_cust_result.CountRow; i++){
        if(ds_cust_result.NameValue(i, "S_YN")=="Y"){
            if(ds_cust_result.NameValue(i, "MSG_CD")!="0000"){
                alert(ds_cust_result.NameValue(i, "MSG"));
				//alert("235라인");
            }
        } else {
            alert(ds_cust_result.NameValue(i, "MSG"));
            	//alert("239라인");        
            getObjectFirst("ds_cust_temp").ClearAll();
            getObjectFirst("ds_cust_result").ClearAll();
            return;
        }
    }
    
    if(getObjectFirst("ds_cust_temp").CountRow==0){
        if(v_manage_no.Text!=""){
            alert("주민/여권등록번호 : "+ v_manage_no.Text +" 인 사용자는 존재하지 않습니다.");
            getObjectFirst("v_manage_no").Focus();
        } else {
            alert("주민/여권등록번호 : "+ ds_tour.NameValue(ds_tour.RowPosition, "MANAGE_NO") +" 인 사용자는 존재하지 않습니다.");
        }
        getObjectFirst("ds_cust_temp").ClearAll();
        getObjectFirst("ds_cust_result").ClearAll();
        	//alert("255라인");        
        return;
    }
    
    var max_person = eval(getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "MAX_PERSONS"));
    var cust_cnt = getObjectFirst("ds_cust").CountRow;
    
    if(max_person<(Number(cust_cnt)+Number(getObjectFirst("ds_cust_temp").CountRow))){
        alert("최대 인원을 초과했습니다. ["+ (Number(cust_cnt)+Number(getObjectFirst("ds_cust_temp").CountRow)) +"]");
        return;
    }
    
    
    /*
     * 신규 추가시 ds_cust 에 관광객이 존재하면, 무조건 다른 사용자는 지인으로 분류한다.
     * 2006. 09. 18 차과장님 요청사항
     * modifier : 김영민
     */
    var v_bonin_gubn = "01";	//본인
    
    for(var i=1; i<=getObjectFirst("ds_cust_temp").CountRow; i++){
    	if(getObjectFirst("ds_cust").CountRow>0)
    		v_bonin_gubn = "02";	//지인
    		
        getObjectFirst("ds_cust").AddRow();
        
        for(var j=1; j<=getObjectFirst("ds_cust_temp").CountColumn; j++)
            getObjectFirst("ds_cust").ColumnString(getObjectFirst("ds_cust").RowPosition, j) = getObjectFirst("ds_cust_temp").ColumnString(i, j);
        
        getObjectFirst("ds_cust").NameValue(getObjectFirst("ds_cust").RowPosition, "JOIN_CD")  = v_bonin_gubn;
        
        for(var j=1; j<=getObjectFirst("ds_tour").CountRow; j++){
            if(getObjectFirst("ds_tour").NameValue(j, "MANAGE_NO") == getObjectFirst("ds_cust_temp").NameValue(i, "MANAGE_NO") && getObjectFirst("ds_cust").CountRow>0){
                getObjectFirst("ds_tour").NameValue(j, "MOVE_TEMP")="M";//이동여부
            }
        }
        
        if(v_ut=="")
        	getObjectFirst("hold_btn").style.display = "inline";
    }

//    if(getObjectFirst("ds_cust_temp").NameValue(1, "COUNTRY_GU")=="10")
//        getObjectFirst("regi_no").Text = getObjectFirst("ds_cust_temp").NameValue(1, "MANAGE_NO");
//    else
//        getObjectFirst("pass_no").Text = getObjectFirst("ds_cust_temp").NameValue(1, "MANAGE_NO");

    getObjectFirst("ds_cust_temp").ClearAll();
    getObjectFirst("ds_cust_result").ClearAll();
    
    getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "RSV_PERSONS") = getObjectFirst("ds_cust").CountRow;
    fnCustInfoChange();
    
    getObjectFirst("v_manage_no").Text = "";

</script>

<script language="javascript" for="tr_temp" event="OnFail()">
//투숙객 추가할 때 사용하는 TR오브젝트의 OnFail 이벤트.
//오류가 발생한 경우 아래에서 메세지를 띄워준다.
	fnHideLoading();
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr_temp.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_temp.SrvErrMsg("ERROR", i)+"\n";
    }

    if(error_msg!="") {
        alert(error_msg);
    } else {
        alert("Error Code : " + tr_temp.ErrorCode + "\n" + "Error Message : " + tr_temp.ErrorMsg + "\n");
    }
//	alert("324라인");                
</script>

<script language="javascript" for="tr_cust" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    alert("저장되었습니다.");
    v_cust_flag = "";
    //getObjectFirst("v_manage_no").Text = getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "MANAGE_NO");
</script>

<script language="javascript" for="tr_cust" event="OnFail()">
	fnHideLoading();
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_cust.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_cust.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_cust.ErrorCode + "\n" + "Error Message : " + tr_cust.ErrorMsg + "\n");
//	alert("349라인");
</script>

<script language="javascript" for="tr_save" event="OnSuccess()">
    /**
     * ds_cust_result(투숙객정보), ds_room_result(객실정보변경), ds_amt_result(판매가 계산)
     * 결과를 처리하며 Display 한다.
     */
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();
    
    var total_result_msg    = "";     //전체 메시지 처리 결과
    var cust_result_msg     = "";     //투숙객정보 저장 결과
    var option_result_msg   = "";     //옵션정보 저장 결과
    var room_result_msg     = "";     //객실정보변경 저장 결과
    var amt_result_msg      = "";     //판매가 계산 저장 결과
    
    var var_accept_no       = "";     //고객정보 처리후 accept_no
    var var_accept_sid      = "";     //고객 정보 처리후 accept_sid
    
    if(ds_cust_result.CountRow>0){
        for(var i=1; i<=ds_cust_result.CountRow; i++){
            if(ds_cust_result.NameValue(i, "MSG_CD")!="0000"){
                cust_result_msg += "["+ ds_cust_result.NameValue(i, "MANAGE_NO") + "] 처리결과["
                                + ds_cust_result.NameValue(i, "MSG")+"]\n";
            }
            
            var_accept_no = ds_cust_result.NameValue(i, "ACCEPT_NO");
            var_accept_sid = ds_cust_result.NameValue(i, "ACCEPT_SID");
        }
        if(cust_result_msg!="")
            total_result_msg += "투숙객 정보 저장시 처리결과 \n\n"+cust_result_msg+"\n";
    }
    if(ds_room_result.CountRow>0){
        var v_room_flag = false;
        for(var i=1; i<=ds_room_result.CountRow; i++){
            if(ds_room_result.NameValue(i, "MSG_CD")!="0000"){
                room_result_msg += ds_room_result.NameValue(i, "MSG")+"\n";
            } else v_room_flag = true;
        }
        
        ds_room_result.ClearAll();
        
        if(room_result_msg!="")
            total_result_msg += "객실정보변경 저장시 처리결과 \n\n"+room_result_msg+"\n";
            
        if(v_room_flag){
            fnRoomType("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
            fnGetTour("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
	        fnGetCar('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
        }
    }
    if(ds_amt_result.CountRow>0){
        for(var i=1; i<=ds_amt_result.CountRow; i++){
            if(ds_amt_result.NameValue(i, "MSG_CD")!="0000"){
                amt_result_msg += ds_amt_result.NameValue(i, "MSG")+"\n";
            }
        }
        if(amt_result_msg!="")
            amt_result_msg += "판매가계산 저장시 처리결과 \n\n"+amt_result_msg+"\n";
    }

    if(amt_result_msg!="")
        alert(amt_result_msg);
    else
        alert("저장되었습니다.");
    
    //투숙객 정보 저장 성공시 고객 정보 및 
    if(ds_cust_result.CountRow>0){
        if(var_accept_no!=""){
            v_accept_no.Text = var_accept_no;
            v_accept_sid.value = var_accept_sid;
            fnAcceptNoAfter('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
            fnRoomType('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
            
            v_block_row = ds_block.RowPosition;
        }
        fnGetDataCust('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
        fnGetTour('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
    } else if(ds_amt_result.CountRow>0){
        fnGetTour('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
    }
    
    ds_amt_result.ClearAll();
    ds_cust_result.ClearAll();
    getObjectFirst("v_manage_no").Text = "";
</script>

<script language="javascript" for="tr_save" event="OnFail()">
	fnHideLoading();
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
//alert("tr_save OnFail : " + error_cnt);
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
//	alert("450라인");        
</script>

<script language=javascript for="ds_search" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    if(row==0){	//아.. 조회결과가 없을 떄!
        alert("<%=HDConstant.S_MSG_NO_DATA%>");

        var temp_data = "";
        if(v_function=="ACCEPT"){
            temp_data = getObjectFirst("v_accept_no").Text;
            v_function = "RESET";
            fnDataSetClear();
            getObjectFirst("v_accept_no").Text = temp_data;
            //getObjectFirst("v_accept_no").Focus();
        } else if(v_function == "DEPART_DATE"){
            temp_data = getObjectFirst("v_depart_date").Text;
            v_function = "RESET";
            fnDataSetClear();
            getObjectFirst("v_depart_date").Text = temp_data;
            //getObjectFirst("v_depart_date").Focus();
        }
        return;
    }

    fnSearchDataChange();	// 조회 데이터에 대한 컨트롤 조절
    fnSearchEnd(row);		// ds_search OnLoadCompleted Event
    if(v_accept_sid.value!="") {
        fnGetTour('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
        fnGetCar('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
	}
</script>

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    if(v_cust_flag=="S"){
        if(row==0) {
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
            fnCancelCust();
        }
    }
</script>

<script language=javascript for="ds_cust" event="OnLoadCompleted(row)">
    fnCustButtonChange();
    fnCustInfoChange();
</script>

<script language=javascript for="ds_block" event="OnLoadCompleted(row)">
    if(row==0){
        alert("블록 및 객실정보 데이터가 존재하지 않습니다.");
        return false;
    }
//alert("ds_block : " + ds_block.RowPosition + " v_block_row : "+ v_block_row);
    ds_block.RowPosition = v_block_row;
    if(v_function!="ROOM"){
        fnGetDataCust('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
    }
</script>

<script language=javascript for=v_accept_no event="OnKillFocus()">	<%//신청서번호 입력후 빠져나올 때%>
    fnAcceptNo("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
</script>
<script language=javascript for=v_depart_date event="OnKillFocus()"> <%//출발일자 입력 후 빠져나올 때%>
    fnDepartDate("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
</script>
<script language=javascript for="v_goods_nm" event="OnSelChange()">
    if(getObjectFirst("ds_search").CountRow<=1 || v_cust_flag=="") return;
    setTimeout("fnRoomType('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
</script>
<script language=javascript for="v_bound" event="OnSelChange()">	<%//bound 변경했을 때%>
    fnBound('<%=dirPath%>', '<%=HDConstant.PATH_HELP%>');
</script>
<script language=javascript for="v_blockType" event="OnSelChange()">
    if(getObjectFirst("init_blockTypeDs").CountRow==0 || v_cust_flag=="") return;
    setTimeout("fnBlockType('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
</script>
<script language=javascript for="v_roomType" event="OnSelChange()">
    if(getObjectFirst("ds_room").CountRow==0 || v_cust_flag=="") return;
    
    v_block_row = 0;
    setTimeout("fnRoomType('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
</script>

<script language=javascript for="gr_block" event="OnClick(Row, Colid)">
    if(Row==0) return;

    if(getObjectFirst("ds_cust").IsUpdated){
        if(getObjectFirst("ds_block").RowPosition != v_block_row)
            alert("투숙객 명단에 저장되지 않은 상태입니다.\n\n먼저 저장후 블록 선택을 하시길 바랍니다.");
        getObjectFirst("ds_block").RowPosition = v_block_row;
        return;
    }
    
    getObjectFirst("photo").src = "<%=dirPath%>/Sales/images/00000.gif";
    v_block_row = Row;
    setTimeout("fnGetDataCust('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
    gr_cust.Focus();
</script>

<script language=JavaScript for=gr_carlist event=OnPopup(row,colid,data)>
	if(colid=="car_nm") {                            
		fnCarPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');   
	}            
</script>

<script language=JavaScript for=gr_cust event=OnPopup(row,colid,data)>
	if(colid=="DUMMY_COL") {
		fnCalPopup('<%=dirPath%>', row);
	}            
</script>


<script language=JavaScript  for=ds_cust event="OnRowPosChanged(Row)">
    fnResetCust();
//    fnCustDisplay(ds_cust.NameValue(Row, "COUNTRY_GU"));
    getObjectFirst("ds1").ClearAll();
    if(Row==0) return;
    
    for(var i=1; i<=initds1.CountRow; i++){
        if(initds1.NameValue(i, "DETAIL")==ds_cust.NameValue(Row, "COUNTRY_GU")){
            initds1.RowPosition = i;
        }
    }
//    if(ds_cust.NameValue(Row, "COUNTRY_GU") == "10")
//        regi_no.Text = ds_cust.NameValue(Row, "MANAGE_NO");
//    else
//        pass_no.Text = ds_cust.NameValue(Row, "MANAGE_NO");
    
    v_cust_row = Row;
//    photo.src = "http://erp.hdasan.com/services/Sales/file/photo/cust/"+ ds_cust.NameValue(Row, "MANAGE_NO") +".JPG";
    photo.src = "http://203.242.32.42/photos/cust/"+ds_cust.NameValue(Row,"MANAGE_NO").substring(0,1)+"/"+ ds_cust.NameValue(Row, "MANAGE_NO") +".JPG";

    

// 할인상세 추가 - 편집은 안되는 자동 커서 변경 2007-05-11 by 심동현
	//제주
//	index=lc_jeju.IndexOfColumn("detail", ds_cust.namevalue(ds_cust.Rowposition,"jeju_yn"));
//	lc_jeju.index=index;
	//주말
//	index=lc_weekend.IndexOfColumn("detail", ds_cust.namevalue(ds_cust.Rowposition,"weekend_yn"));
//	lc_weekend.index=index;
	
	
</script>

<script language=JavaScript  for=gr_tourlist event="OnDblClick(Row, Colid)">
    if(Row==0) return;
    
    if(ds_block.CountRow==0){
        alert("블록 정보를 먼저 조회 후 클릭하시길 바랍니다.");
        return;
    }
    if(ds_cust.CountRow==0){
        ds_cust.AddRow();
        if(ds_cust.CountRow==0){
            alert("투숙객 정보를 먼저 조회 후 클릭하시길 바랍니다.");
            return;
        } else {
            ds_cust.DeleteRow(ds_cust.CountRow);
        }
    }
    fnTourCust('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');
</script>

<script language=JavaScript  for=gr_tourlist event=onKeyPress(keycode)>
  			
    if (keycode == 13) {
	    if(ds_tour.CountRow==0) return;
	    
	    if(ds_block.CountRow==0){
	        alert("블록 정보를 먼저 조회 후 클릭하시길 바랍니다.");
	        return;
	    }
	    if(ds_cust.CountRow==0){
	        ds_cust.AddRow();
	        if(ds_cust.CountRow==0){
	            alert("투숙객 정보를 먼저 조회 후 클릭하시길 바랍니다.");
	            return;
	        } else {
	            ds_cust.DeleteRow(ds_cust.CountRow);
	        }
	    }
	    fnTourCust('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');
    }

</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds_search classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 룸타입 기초데이터 추출 -->
<object id=ds_room classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 블록 객실 -->
<object id=ds_block classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
    <param name="ViewDeletedRow" value="True">
</object>
<!-- 투숙객 명단 -->
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 관광객 명단 -->
<object id=ds_tour classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 차량 명단 -->
<object id=ds_car classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- ForeCasting 목록 -->
<object id=ds_forecasting classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 지역 정보 기초데이터 추출 -->
<object id=init_businessDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 예약타입 기초데이터 추출 -->
<object id=init_blockTypeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 고객 연령대 기초데이터 추출 -->
<object id=init_ageDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 고객 할인유형 기초데이터 추출 -->
<object id=init_custTypeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 고객구분 기초데이터 추출 -->
<object id=init_custGuDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 사업구분 기초데이터 추출 -->
<object id=init_saupGuDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 고객 동숙 기초데이터 추출 -->
<object id=init_joinDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 복귀시각 기초데이터 추출 -->
<object id=init_arrTimeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<%//<!-- 내외구분기초데이터 추출 -->%>
<object id=init_boundDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 투숙객 추가를 위한 임시 DataSet -->
<object id=ds_cust_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 투숙객 정보 저장 결과 -->
<object id=ds_cust_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 룸 정보 변경 저장 결과 -->
<object id=ds_room_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 판매가 계산 저장 결과 -->
<object id=ds_amt_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 투숙객 추가를 위한 임시 DataSet -->
<object id=ds_save_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 할인상세를 위한 데이터셋 추가 2007-05-11 by 심동현 ------------------------------------------------->
<!-- 자차여부 기초데이터 추출 -->
<object id=init_carownerDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 제주여부 기초데이터 추출 -->
<object id=init_jejuDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 주말여부 기초데이터 추출 -->
<object id=init_weekendDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 고객 테마코드 기초데이터 추출 -->
<object id=init_themeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_search" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_cust" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_temp" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%//<!-- 고객정보 변경과 관련된 Components -->%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <PARAM NAME="SyncLoad" VALUE="False">
</object>
<object id=initds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <PARAM NAME="SyncLoad" VALUE="False">
</object>

<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		




<table width="857" border="0" cellspacing="0" cellpadding="0" valign=top>
    <tr>
        <td valign=top>
            <table width="554" border="0" cellspacing="0" cellpadding="0" valign=top >
                <tr>
                    <td width="554" colspan="3" valign=top>
                        <table width="554" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr>
                                <td width="52" height="25" class="text">대리점</td>
                                <td width="90" bgcolor="#FFFFFF">&nbsp;<input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:55px;" class='input01' readOnly>
                                    <input type="hidden" name='v_client_sid' value="<%=c_sid%>" id='v_client_sid'><%if(v_ut.equals("")){%><img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" id="v_client_btn" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                                    <%}%></td>
                                <td width="72" height="25" class="text">신청서번호</td>
                                <td width="131" bgcolor="#FFFFFF">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='95px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000-000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=true>
                                    <%if(!v_ut.equals("")){%>
                                        <param name=Text        value="<%=c_cd%>">
                                    <%}%>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn"></td>
                                <td width="62" height="25" class="text" >단체행사</td>
                                <td width="142" bgcolor="#FFFFFF">&nbsp;<input name="v_event_no" id="v_event_no" type="text" style="width:30px;" class="input01" readOnly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand;display:" id="v_event_btn" onclick="fnGroupPopup('<%=dirPath%>');">
                                    <input type=hidden name="v_event_sid" id="v_event_sid"><input name="v_event_nm" type="text" style="width:60px;" class="input01" readOnly></td>
                            </tr>
                        </table>
                        
                        <table height=6px><tr><td></td></tr></table>

                        <table width="554" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr>
                                <td width="52" height="25" class="text">Bound</td>
                                <td width="90" bgcolor="#FFFFFF">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_bound classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                        <param name=ComboDataID         value=init_boundDs>
                                        <param name=EditExprFormat  	value="%,%,%;head,detail,detail_nm">
                                        <param name=ListExprFormat 		value="detail_nm^0^70">
                                        <param name=BindColumn          value="detail">
                                    </object>
                                    <%=HDConstant.COMMENT_END%></td>                                
                                <td width="72" height="25" class="text" >지역</td>
                                <td width="131" bgcolor="#FFFFFF">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_business classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=90 border="0" align=absmiddle>
                                        <param name=ComboDataID         value=init_businessDs>
                                        <param name=SearchColumn        value="saup_nm">
                                        <param name=Sort                value="false">
                                        <param name=ListExprFormat      value="saup_nm^0^90">
                                        <param name=BindColumn          value="saup_sid">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="62" height="25" class="text">상품순번</td>
                                <td width="142" bgcolor="#FFFFFF"><b>&nbsp;<font onclick="fnSeqPrev()">◀</font>&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_bound_seq classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='20px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="0">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>&nbsp;/&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_bound_total_seq classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='20px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="0">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>&nbsp;<font onclick="fnSeqNext()">▶</font></b></td>
                            </tr>
                            <tr height="25">
                                <td class="text" >출발일자</td>
                                <td colspan="2" bgcolor="#FFFFFF">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                    &nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_time classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='35px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="##:##">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                    &nbsp;<input name="v_nights" id="v_nights" type="text" style="width:20px;" class="input01" readOnly></td>
                                <td colspan="3" bgcolor="#FFFFFF">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods_nm classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=130 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_search>
                                        <param name=EditExprFormat  value="%;goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^200">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                    &nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_blockType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=init_blockTypeDs>
                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                        <param name=ListExprFormat  value="detail_nm^0^80">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                    &nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_roomType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=90 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_room>
                                        <param name=SyncComboData   value=true>
                                        <param name=EditExprFormat  value="%,%,%;ROOM_TYPE_SID,ROOM_TYPE_CD,ROOM_TYPE_NM">
                                        <param name=ListExprFormat  value="ROOM_TYPE_CD^0^140">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr height="25">
                                <td class="text" >복귀일자</td>
                                <td bgcolor="#FFFFFF" colspan="2">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=MaxLength   value="8">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                    &nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_arrive_time classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='35px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="##:##">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td colspan="3" bgcolor="#FFFFFF" align=right><!--<img src="<%=dirPath%>/Sales/images/reset.gif" align="absmiddle" style="cursor:hand" onClick="fnReset()"> -->
                                	&nbsp;<img src="<%=dirPath%>/Sales/images/resetAll.gif" align="absmiddle" style="cursor:hand" onClick="fnResetAll()">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td><%// 가운데부분: 객실상태 + 고객정보 %>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="114" valign=top><%//객실상태그리드%>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="28"><img src="<%=dirPath%>/Sales/images/trace_dot.gif" width="4" height="4" align="absmiddle">&nbsp;<strong>객실상태 </strong><span id="block_title"></span></td>
                                        </tr>
                                        <tr>
                                            <td valign=top>
                                                <%=HDConstant.COMMENT_START%><%// 객실상태: ds_block %>
                                                <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_block  style="width=114px; height:209px" border="1">
                                                    <param name="DataID"        VALUE="ds_block">
                                                    <param name="BorderStyle"   VALUE="0">
                                                    <param name=ColSizing       value="true">
                                                    <param name="editable"      value="false">
                                                    <param name="ViewSummary"   value="1">
                                                    <param name="Format"        VALUE="
                                                        <!-- C> name=''       ID='{CURROW}'  Width=20   align=Center</C-->
                                                        <G> name='인원'
                                                        <C> name='R'    ID='RSV_PERSONS'     Width=34      align=Center Edit=none sumtext=@cnt</C>
                                                        <C> name='S'    ID='STD_PERSONS'     Width=32     align=Center Edit=none sumtext=실</C>
                                                        <C> name='M'    ID='MAX_PERSONS'     Width=32     align=Center Edit=none</C>
                                                        </G>
                                                    ">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
								<td width="6">&nbsp;</td>
                                <td valign=top><%//고객정보영역 시작%>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                        	<td colspan=3>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr  height="28">
	                                                    <td align="left"><img src="<%=dirPath%>/Sales/images/trace_dot.gif" width="4" height="4" align="absmiddle">&nbsp;<strong>주민/여권번호</strong><%=HDConstant.COMMENT_START%>
                                                            <object id=v_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='85px' align='absmiddle' class='textbox'>
                                                                <param name=Format      value="#############">
                                                                <param name=Alignment   value=1>
                                                                <param name=ClipMode    value=true>
                                                                <param name=Border      value=false>
                                                                <param name=SelectAll   value=true>
                                                                <param name=SelectAllOnClick      value=true>
                                                                <param name=SelectAllOnClickAny   value=false>
                                                            </object><%=HDConstant.COMMENT_END%>
                                                        </td>
                                                        <td align=right>
                                                            <img src="<%=dirPath%>/Sales/images/add.gif"    id="btn_cust_add"  style="display:none;cursor:hand" onClick="fnCustAdd('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/delete.gif" id="btn_cust_del"  style="display:none;cursor:hand" onClick="fnCustDel('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/save.gif"   id="btn_cust_save" style="display:none;cursor:hand" onClick="fnCustSave('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/cancel.gif" id="btn_cust_cancel" style="display:none;cursor:hand" onClick="fnCustCancel()">
                                                        </td>
                                                    </tr>
                                                </table>
                                        	</td>
                                        </tr>
                                        <tr>
                                            <td width="102" height="120" valign=top>
                                                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                                    <tr bgcolor="#ffffff">    
                                                        <td width="100%" height="120">
                                                            <img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" border=0 width="100" height="120">
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                                    <tr bgcolor="#ffffff" height=20>    
                                                        <td align=center bgcolor="#efefef" width=40>자차</td>
                                                        <td align=center>
														<%=HDConstant.COMMENT_START%>
							                            <object id=lc_carowner classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_carownerDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
														</object>
														<%=HDConstant.COMMENT_END%>	</td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" height=20>
                                                     	<td align=center bgcolor="#efefef">제주</td>
                                                        <td align=center>
                                                        <%=HDConstant.COMMENT_START%>
							                            <object id=lc_jeju classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_jejuDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
															<param name=Enable2  value=false>
														</object>
														<%=HDConstant.COMMENT_END%>	</td>
													</tr>
                                                    <tr bgcolor="#ffffff" height=20>
                                                     	<td align=center bgcolor="#efefef">주말</td>

                                                        <td align=center>
                                                        <%=HDConstant.COMMENT_START%>
							                            <object id=lc_weekend classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_weekendDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
															<param name=Enable2  value=false>
														</object>
														<%=HDConstant.COMMENT_END%>	</td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" height=20>
                                                        <td align=center bgcolor="#efefef">테마</td>
                                                        <td align=center>
                                                        <%=HDConstant.COMMENT_START%>
							                            <object id=lc_theme classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=63 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_themeDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
														</object>
														<%=HDConstant.COMMENT_END%>	</td>
                                                    </tr>
                                                </table>                                                            
                                            </td>
                                            <td width="3">&nbsp;</td>
                                            <td width="326" valign="top">
                                                <table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                                    <tr height="25">
                                                        <td class="text" width=70>영문성명</td>
                                                        <td width=92 bgcolor="#FFFFFF">&nbsp;<input name="cust_cust_enm" id="cust_cust_enm" type="text" class="input01" size="12" readOnly></td>
                                                        <td class="text" width=70>생년월일</td>
                                                        <td width=92 bgcolor="#FFFFFF">&nbsp;<input name="cust_birthday" id="cust_birthday" type="text" class="input01" size=12 readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">직장</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input type=text name="cust_company_nm" id="cust_company_nm" class="input01" size=12 readOnly></td>
                                                        <td class="text">방문횟수</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_north_cnt" id="cust_north_cnt" type="text" class="input01" size="12" readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">직위</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_positions" id="cust_positions" type="text" class="input01" size="12" readOnly></td>
                                                        <td class="text">성별</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_sex" id="cust_sex" type="text" class="input01" size=12 readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">사는곳</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_address1" id="cust_address1" type="text" class="input01" size="12" readOnly></td>
                                                        <td class="text">국적/민족</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_country_nm" id="cust_country_nm" type="text" class="input01" size=12 OnKeyUp="cfLengthCheck(this, 15);" readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">여권종류</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_pass_type" id="cust_pass_type" type="text" class="input01" size="12" readOnly></td>
                                                        <td class="text">여권번호</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_pass_no" id="cust_pass_no" type="text" class="input01" size=12 readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">유치자</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="hold_empnm" id="hold_empnm" type="text" class="input01" size="8" readOnly> <img src="<%=dirPath%>/Sales/images/help.gif" id="hold_btn" border="0" align=absmiddle style="cursor:hand;display:none" onclick="fnHoldEmp()"></td>
                                                        <td class="text">휴대폰</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_mobile_no" id="cust_mobile_no" type="text" class="textbox" size=12 OnKeyUp="cfLengthCheck(this, 15);" readOnly></td>
                                                    </tr>
                                                    <tr height="53">
                                                        <td class="text">참고사항</td>
                                                        <td colspan="3" bgcolor="#FFFFFF">&nbsp;<textarea name="cust_remarks" id="cust_remarks"  class=textbox cols=38 rows=3 OnKeyUp="cfLengthCheck(this, 100);" readOnly></textarea></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>

                                </td><%//고객정보영역 끝%>
                            </tr>
                        </table>
                    </td><%// 가운데부분: 객실상태 + 고객정보 끝%>
                </tr>
                <tr>
                    <td height="20"><img src="<%=dirPath%>/Sales/images/trace_dot.gif" width="4" height="4" align="absmiddle">&nbsp;<strong>투숙객 명단</strong></td>
                </tr>
                <tr>
                    <td><%//하단부 투숙객 GRID 시작%>
                        <%=HDConstant.COMMENT_START%>
                        <object classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_cust  style="width=554px; height:200px" border="1">
                            <param name="DataID"        VALUE="ds_cust">
                            <param name="BorderStyle"   VALUE="0">
                            <param name=ColSizing       value="true">
                            <param name="editable"      value="true">
                            <param name="Format"        VALUE="
                                <C> name='No'           	ID='{CURROW}'       Width=25    align=Center Edit=None</C>
                                <C> name='▼'           	ID='DUMMY_COL' 		Width=20    align=Center EditStyle=popup </C>
								<C> name='복귀일자'   	ID='ARRIVE_DATE'    Width=70	align=center Edit=None editlimit=8 suppress=1 mask='XXXX-XX-XX'</C>
								<C> name='시간'   		ID='ARRIVE_TIME'    Width=50	align=Left   EditStyle=Lookup Data='init_arrTimeDs:DETAIL:DETAIL_NM' </C>
                                <C> name='주민/여권'	ID='MANAGE_NO'      Width=100   align=Left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                <C> name='성명'			ID='CUST_NM'        Width=50    align=Left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                <C> name='연령'			ID='AGE_CD'         Width=50    align=Left EditStyle=Lookup Data='init_ageDs:DETAIL:DETAIL_NM'</C>
                            <%
                                if(v_ut.equals("")){
                            %>
                                <C> name='할인유형'    ID='CUST_TYPE'      Width=60    align=Left EditStyle=Lookup Data='init_custTypeDs:DETAIL:DETAIL_NM'</C>
                            <%
                                } else {
                            %>
                                <C> name='할인유형'    ID='CUST_TYPE_NM'      Width=60    align=Left Edit=None</C>
                            <%
                                }
                            %>
                                
                                <C> name='사업'       ID='SAUP_GU'     Width=55  align=Left EditStyle=Lookup Data='init_saupGuDs:DETAIL:DETAIL_NM'</C>
                                <C> name='동숙'       ID='JOIN_CD'     Width=45  align=Left EditStyle=Lookup Data='init_joinDs:DETAIL:DETAIL_NM'</C>
                                <C> name='자차'       ID='CAROWNER_YN' Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='제주'       ID='JEJU_YN'     Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='주말'       ID='WEEKEND_YN'  Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='테마'       ID='THEME_CD'    Width=50  align=Left Edit=None SHOW=FALSE</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    
                    </td><%//하단부 투숙객 GRID 끝%>
                </tr>
                
            </table>
        </td>
        <td width="6">&nbsp;</td>
        <td width="295" height="524" valign=top>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table height="30" border="0" cellspacing="0" cellpadding="0" align=left>
                            <tr>                                
                                <td width="95"><img src="<%=dirPath%>/Sales/images/tab_01.gif" name="sub1" width="95" height="28" border="0" onMouseOver="changesub(1)" onMouseOut="changesubout(1)" style="cursor:hand" onClick="changesubclick(1), fnOnChangTab('1')"></td>
                                <td width="95"><img src="<%=dirPath%>/Sales/images/tab_04.gif" name="sub2" width="95" height="28" border="0" onMouseOver="changesub(2)" onMouseOut="changesubout(2)" style="cursor:hand" onClick="changesubclick(2), fnOnChangTab('2')"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="497" valign=top style="padding-top:4px">
                        <!-- 관광객 명단 TAB -->
                        <table id=tb_tourlist style="display:inline" border=0 cellspacing=0 cellpadding=0>
							<tr  height="26">                              
                                <td align=left valign=middle>고객등록 자료조회<input type=checkbox name=v_accept_check id=v_accept_check>
                                    &nbsp;<img src="<%=dirPath%>/Sales/images/refresh.gif" style="cursor:hand" id=v_tour_check style="display:none" onClick="fnGetTour('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')"></td>
                            </tr>
                            <tr>
                                <td valign=top>
                                    <%=HDConstant.COMMENT_START%>
                                    <object classid=<%=HDConstant.CT_GRID_CLSID%> id=gr_tourlist  style="width=293px; height:510" border="1">
                                        <param name="DataID"        VALUE="ds_tour">
                                        <param name="BorderStyle"   VALUE="0">
                                        <param name=ColSizing       value="true">
                                        <param name="editable"      value="true">
                                        <Param Name="SuppressOption"      value="1">
                                        <param name=ViewSummary     value=1>
                                        <Param Name="SortView"     value="Right">
                                        <param name="Format"         VALUE="
                                            <C> name='상품'		   ID='GOODS_NM'  Width=70   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left suppress=1 sort=false</C>
                                            <C> name='객실\\등급'   ID='ROOM_TYPE_CD'  Width=70   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left SumText='인원/금액' suppress=1 sort=true</C>
                                            <C> name='성명'        ID='CUST_NM'       Width=100   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left SumText=@count SumTextAlign=right sort=true</C>
                                            <C> name='판매가'       ID='TOUR_AMT'     Width=65   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right SumText=@sum SumTextAlign=right dec=0 show=False</C>
                                            <C> name='할인\\유형'   ID='CUST_TYPE_NM'  Width=50   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left sort=true</C>
                                            <C> name='주민등록번호'  ID='MANAGE_NO_s'     Width=90   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left</C>
                                            <C> name='옵션\\요금'    ID='OPTION_AMT'  Width=65   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right SumText=@sum SumTextAlign=right dec=0 show=False</C>
                                        ">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                        </table>

                        <!-- 차량 명단 TAB -->
                        <table id=tb_car style="display:none" border=0 cellspacing=0 cellpadding=0>
                            <tr>                                
                                <td align=right valign=middle>
                                
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr  height="26">
                                                        <td align=right>
                                                            <img src="<%=dirPath%>/Sales/images/add.gif"    id="btn_cust_add"  style="cursor:hand" onClick="fnCarAdd('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/delete.gif" id="btn_cust_del"  style="cursor:hand" onClick="fnCarDel('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/save.gif"   id="btn_cust_save" style="cursor:hand" onClick="fnCarSave('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/cancel.gif" id="btn_cust_cancel" style="cursor:hand" onClick="fnCarCancel()">
                                                        </td>
                                                    </tr>
                                                </table>
                                
                                
								</td>
                            </tr>
                            <tr>
                                <td valign=top>
                                    <%=HDConstant.COMMENT_START%>
                                    <object classid=<%=HDConstant.CT_GRID_CLSID%> id=gr_carlist  style="width=293px; height:510" border="1">
                                        <param name="DataID"        VALUE="ds_car">
                                        <param name="BorderStyle"   VALUE="0">
                                        <param name=ColSizing       value="true">
                                        <param name="editable"      value="true">
                                        <Param Name="SuppressOption"      value="1">
                                        <param name=ViewSummary     value=1>
                                        <Param Name="SortView"     value="Right">
                                        <param name="Format"         VALUE="
											<C> name='복귀일자'		ID='ARRIVE_DATE'  Width=70  editlimit=8	align=Left sort=false mask='XXXX-XX-XX'  SumText='총'  SumTextAlign=right</C>
											<C> name='시간'   		ID='ARRIVE_TIME'  Width=50	editlimit=4 align=Left EditStyle=Lookup Data='init_arrTimeDs:DETAIL:DETAIL_NM'  SumText=@cnt SumTextAlign=right</C>
								                <C> name='차량SID'      ID='car_sid'     	align=left width=100 	editlimit=12 	show=false</C>
											<C> name='차명'       	ID='car_nm'      	align=left width=100 	editlimit=32 	show=true  	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%>  SumText='대' SumTextAlign=left</C>
											<C> name='차량등록번호'	ID='CAR_NO'       	align=left Width=100    Edit=None 	sort=false</C>
											<C> name='차종' 		ID='CAR_TYPE' 	  	align=left Width=65   	Edit=None</C>
											<C> name='참고사항' 		ID='car_desc'       align=left width=120 	editlimit=100 	show=true  bgColor=<%=HDConstant.GRID_ITEM%></C>
												<C> name='신청SID'   	ID='accept_sid'  	align=left width=100 	editlimit=12 	show=false </C>
												<C> name='상품순번'   	ID='bound_seq'  	align=left width=60 	editlimit=12 	show=false </C>
												<C> name='대리점SID'   	ID='client_sid'  	align=left width=100 	editlimit=12 	show=false </C>
												<C> name='출경일자'		ID='depart_DATE'  Width=70  Edit=None	align=Left sort=false mask='XXXX-XX-XX' show=false</C>
												<C> name='시간'   		ID='depart_TIME'  Width=50	Edit=None	align=Left sort=false mask='XX:XX' show=false</C>
												<C> name='차량예약SID'  	ID='car_rsv_sid'    align=left width=100 	editlimit=12 	show=false </C>
												<C> name='화물'        	ID='cargo'       	align=left width=80 	editlimit=100 	show=false</C>
                                        ">
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
</table>

<%
/*=============================================================================
            Bind 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
     <object id=searchBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds_search">
             <param name=BindInfo    value="
                <C>Col=DEPART_DATE     Ctrl=v_depart_date          Param=Text</C>
                <C>Col=DEPART_TIME     Ctrl=v_depart_time          Param=Text</C>
                <C>Col=ARRIVE_DATE     Ctrl=v_arrive_date          Param=Text</C>
                <C>Col=ARRIVE_TIME     Ctrl=v_arrive_time          Param=Text</C>
                <C>Col=NIGHTS          Ctrl=v_nights               Param=Value</C>

                <C>Col=BOUND_SEQ       Ctrl=v_bound_seq				Param=Text</C>
                <C>Col=BOUND_TOTAL     Ctrl=v_bound_total_seq		Param=Text</C>
                                
                
              ">
     </object>
     <object id=custBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds_cust">
             <param name=BindInfo    value="
                <C>Col=CUST_ENM        Ctrl=cust_cust_enm               Param=Value</C>
                <C>Col=BIRTHDAY        Ctrl=cust_birthday               Param=Value</C>
                <C>Col=COMPANY_NM      Ctrl=cust_company_nm             Param=Value</C>
                <C>Col=POSITIONS       Ctrl=cust_positions              Param=Value</C>
                <C>Col=ADDRESS1        Ctrl=cust_address1               Param=Value</C>
                <C>Col=COUNTRY_NM      Ctrl=cust_country_nm             Param=Value</C>
                <C>Col=PASS_TYPE       Ctrl=cust_pass_type              Param=Value</C>
                <C>Col=PASS_NO         Ctrl=cust_pass_no                Param=Value</C>
                <C>Col=NORTH_CNT       Ctrl=cust_north_cnt              Param=Value</C>
                <C>Col=HOLD_EMPNM       Ctrl=hold_empnm              Param=Value</C>
                <C>Col=SEX             Ctrl=cust_sex                    Param=Value</C>
                <C>Col=MOBILE_NO       Ctrl=cust_mobile_no              Param=Value</C>
                <C>Col=REMARKS         Ctrl=cust_remarks                Param=Value</C>
                
                <C>Col=CAROWNER_YN     Ctrl=lc_carowner   	 	Param=BindColVal</C>
                <C>Col=JEJU_YN         Ctrl=lc_jeju   	 		Param=BindColVal</C>
                <C>Col=WEEKEND_YN      Ctrl=lc_weekend   	 	Param=BindColVal</C>
                <C>Col=THEME_CD        Ctrl=lc_theme   	 		Param=BindColVal</C>
              ">
     </object>
     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                <C>Col=group_cd         Ctrl=group_cd           Param=Text</C>
                <C>Col=height           Ctrl=height             Param=Text</C>
                <C>Col=regi_no          Ctrl=regi_no            Param=Text</C>
                <C>Col=regi_yn          Ctrl=lc_regi_yn         Param=BindColVal </C>
                <C>Col=cust_gu          Ctrl=lc_cust_gu         Param=BindColVal</C>
                <C>Col=country_gu       Ctrl=lc_country_gu      Param=value</C>
                <C>Col=saup_gu          Ctrl=lc_saup_gu         Param=BindColVal</C>
                <C>Col=cust_type        Ctrl=lc_cust_type       Param=BindColVal </C>
                <C>Col=CUST_NM          Ctrl=txt_cust_nm        Param=Value</C>
                <C>Col=last_nm          Ctrl=last_nm            Param=Text</C>
                <C>Col=country_cd       Ctrl=country_cd         Param=Value</C>
                <C>Col=nation_cd        Ctrl=lc_nation          Param=Value </C>
                <C>Col=birthday         Ctrl=birthday            Param=Text</C>
                <C>Col=sex              Ctrl=lc_sex             Param=BindColVal</C>
                <C>Col=tel_no           Ctrl=tel_no             Param=value</C>
                <C>Col=mobile_no        Ctrl=mobile_no          Param=value</C>
                <C>Col=zip_cd           Ctrl=zip_cd             Param=Text</C>
                <C>Col=address1         Ctrl=txt_address1       Param=value</C>
                <C>Col=address2         Ctrl=txt_address2       Param=value</C>
                <C>Col=eng_zip_cd       Ctrl=eng_zip_cd         Param=Text</C>
                <C>Col=eng_addr1        Ctrl=txt_eng_addr1      Param=value</C>
                <C>Col=pass_type        Ctrl=lc_pass_type       Param=BindColVal</C>
                <C>Col=pass_no          Ctrl=pass_no            Param=Text</C>
                <C>Col=pass_expire_date Ctrl=pass_expire_date   Param=Text</C>
                <C>Col=company_nm       Ctrl=txt_company_nm         Param=Value</C>
                <C>Col=positions        Ctrl=txt_positions          Param=Value</C>
                <C>Col=eng_company_nm   Ctrl=eng_company_nm     Param=Text</C>
                <C>Col=eng_position     Ctrl=eng_position       Param=Text</C>
                <C>Col=north_cnt        Ctrl=north_cnt          Param=value </C>
                <C>Col=client_sid       Ctrl=client_sid       Param=Value</C>
                <C>Col=client_nm        Ctrl=client_nm          Param=Value</C>
              ">
      </object>
<%=HDConstant.COMMENT_END%>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

