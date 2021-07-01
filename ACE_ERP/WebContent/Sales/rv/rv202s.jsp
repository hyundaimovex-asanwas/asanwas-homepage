<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 홈>관광영업>예약관리>예약신청>예약조회 (예약판매용)
 * 프로그램ID   : RV200S
 * J  S  P      : rv200s
 * 서 블 릿        : Rv200S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-14
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-02-12][박경국]	신청일자에 대한 검색조건 추가 
 * [2010-01-28][심동현] 예판 관리를 위한 [유치자], [입금구분] 컬럼 검색조건 추가..ㅠ_ㅠ;;
 * [2010-02-02][박경국] 예판 관리를 위한 예약조회화면. 모든 조회조건 없음. 조회되는 컬럼 줄임
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
    
<%
/****************************************************************************
                사용자 스크립트
******************************************************************************/
%>      
        <script language="javascript">
            var div = "";
            var jobFlag = "";
        /*
         * 페이지로딩
         */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

            cfStyleGrid(getObjectFirst("gr_cust"), "comn");
            fnInit(); 
        } 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
        }
        /*
         * 메인 조회
         */
        function fnSelect() {
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid=1";
                    
          ln_TRSetting(tr1, 
              "<%=dirPath%><%=HDConstant.PATH_RV%>Rv202S",
              "JSP(O:DS_CUST=ds_cust)",
              param);
          tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:관광예약현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("관광예약현황", "관광예약현황.xls", 8);        
        }

              </script>

<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
%>

	
    <script language=JavaScript  for=ds_cust event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_cust event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
	<script language=JavaScript  for=initds1 event="OnLoadCompleted(row)">
		initds1.insertrow(1);
		initds1.namevalue(initds1.rowposition, "detail") = "";
		initds1.namevalue(initds1.rowposition, "detail_nm") = "전체";
		lc_cust_gu.Index = 0;
    </script>
	<script language=JavaScript  for=initds2 event="OnLoadCompleted(row)">
		initds2.insertrow(1);
		initds2.namevalue(initds2.rowposition, "detail") = "";
		initds2.namevalue(initds2.rowposition, "detail_nm") = "전체";
		
		lc_country_gu.Index = 0;

    </script>
	<script language=JavaScript  for=initds3 event="OnLoadCompleted(row)">
 		initds3.insertrow(1);
		initds3.namevalue(initds3.rowposition, "detail") = "";
		initds3.namevalue(initds3.rowposition, "detail_nm") = "전체";     
		
		lc_saup_gu.Index = 0; 
    </script>        
     
    
    
    
    <script language="javascript" for="tr1" event="onsuccess()">
        msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
    </script>   
    
    
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
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

<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
    <param name=SubsumExpr	value="TOTAL,1:CLIENT_NM">
	<param name=SortExpr	value="+CLIENT_NM+GOODS_NM+CUST_NM">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 예약상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 고객 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 국적 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 사업 -->
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

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
     
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right' width=845>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDs1()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                            <table  border='0' cellpadding='0' cellspacing='0' width='845px' height='350px' >
                                <tr>
                                    <td valign=top>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_cust classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
                                            <param name="DataID"            value="ds_cust">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="
                                                 <C> name='대리점'			ID='CLIENT_NM'		width=110	align=left 		Edit=None suppress=1</C>
                                                 <C> name='출발일자'    	ID='DEPART_DATE'    width=70 	align=CENTER	Edit=None  show=false</C>
												 <C> name='신청일자'    	ID='ACCEPT_DATE'    width=70 	align=CENTER	Edit=None  show=false</C>
                                                 <C> name='출발시간'    	ID='DEPART_TIME'	width=60 	align=center	Edit=None  mask='XX:XX' show=false</C>
                                                 <C> name='상품'        	ID='GOODS_NM'       width=90 	align=left 		Edit=None suppress=2 </C>
                                                 <C> name='신청서번호'  	ID='ACCEPT_NO'      width=110 	align=left 		Edit=None suppress=3 mask='XXXXX-XXXXXX-XXX'</C>
                                                 <C> name='성명'        	ID='CUST_NM'        width=70 	align=left 		Edit=None			 SubSumText=소계</C>
                                                 <C> name='인원'  	     	ID='pplcnt'			width=40 	align=right		Edit=None show=true</C>
                                                 <C> name='인증여부'       	ID='regi_yn_t_name' width=60 	align=CENTER	Edit=None show=false</C>
                                                 <C> name='예약상태'    	ID='STATUS_CD'      width=60 	align=left 		Edit=None</C>
                                                 <C> name='직장/직위'   	ID='COMPANY_NM'     width=130 	align=left 		Edit=None show=false</C>
                                                 <C> name='주민등록번호'	ID='MANAGE_NO'      width=100 	align=CEMTER	Edit=None</C>
                                                 <C> name='사는곳'      	ID='ADDRESS1'       width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='동행자'      	ID='M_CUST_NM'      width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='관계'        	ID='JOIN_CD'        width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='반/조'       	ID='CLASS'       	width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='신청객실'   		ID='A_ROOM_TYPE_CD' width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='확정객실'    	ID='ROOM_TYPE_CD'   width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='ROOM'        	ID='ROOM_NO'        width=60 	align=left 		Edit=None show=false</C>
                                                 <C> name='판매금액'    	ID='TOT_TOUR_AMT'   width=80 	align=right 	Edit=None dec=0</C>
                                                 <C> name='입금액'      	ID='TOT_PAY_AMT'    width=80 	align=right 	Edit=None dec=0</C>
                                                 <C> name='연락처(자택)'	ID='TEL_NO'       	width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='연락처(핸드폰)'	ID='MOBILE_NO'      width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='고객구분'   		ID='CUST_GU'        width=60 	align=CENTER	Edit=None show=false</C>
                                                 <C> name='국적구분'   		ID='COUNTRY_GU'     width=60 	align=CENTER	Edit=None show=false</C>
                                                 <C> name='사업구분'   		ID='SAUP_GU'        width=100 	align=left		Edit=None show=false</C>
                                                 <C> name='반'   			ID='CLASS'       	width=70 	align=left		Edit=None show=false</C>
                                                 <C> name='조'   			ID='TEAMS'        	width=30 	align=CENTER 	Edit=None show=false</C>
                                                 <C> name='관광증번호'  	ID='TOUR_NO'	    width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='통일부번호'  	ID='UNITY_NO'   	width=90 	align=CENTER 	Edit=None show=false</C>
                                                 <C> name='유치자'   		ID='EMPNM'        	width=70 	align=left 		Edit=None show=false</C>
                                                 <C> name='입력자'   		ID='I_EMPNM'        width=100 	align=left 		Edit=None show=false</C>
                                                 <C> name='수정자'   		ID='U_EMPNM'        width=100 	align=left 		Edit=None show=false</C> 
												 <C> name='방문횟수'		ID='north_cnt'		width=60	align=right 	show=true dec=0 show=false</C>
		                                         <C> name='복귀일자'       	ID='arrive_date' 	width=60 	align=CENTER	Edit=None show=false</C>
		                                         <C> name='복귀시각'       	ID='arrive_time' 	width=60 	align=CENTER	Edit=None show=false</C>												
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

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

