<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 신청서 Help 
 * 프로그램ID   : RV001H (코드는 대문자)
 * J  S  P      : rv001h (jsp파일명은 소문자로 한다 )
 * 서 블 릿        : Rv001H
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-06-17
 * 기능정의     : 신청서 조회 
 * 수정내용     : 2006-06-17 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * [수정  일자][수정자] 내용
 * [2008-03-24][심동현] 로딩바/스타일
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());           
//    date.set(java.util.Calendar.HOUR_OF_DAY, 24*30);
    date.add(java.util.Calendar.DATE, +31);
    String firstday1 = m_today.format(date.getTime());           


	String pDepartDate = HDUtil.nullCheckStr(request.getParameter("depart_date")); //받아온 날짜
	String pClient_cd = HDUtil.nullCheckStr(request.getParameter("client_cd")); //받아온 대리점 코드
	if(!pDepartDate.equals("")){
		 firstday = pDepartDate;
		 firstday1 = pDepartDate;		 
	}
	
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
    
    String v_accept_enable = "False";
    
    if(v_ut.equals("")) v_accept_enable = "True";
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<title>신청서번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
        var var_depart_date = "<%=firstday%>";
        
        // 페이지 로딩
        function fnOnLoad(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");

			//대리점코드 강제세팅~
			var client_cd = "<%=pClient_cd%>";
			
//			alert(client_cd);
			if(client_cd!=""){
				 v_client_cd.Text = client_cd;
				 v_client_cd.Visible = "false";
				 v_client_btn.style.display="none";
			}

        }

        // 메인 조회
        function fnSelect() {
            var var_depart_date1 = getObjectFirst("v_depart_date1").Text.trim();
            var var_depart_date2 = getObjectFirst("v_depart_date2").Text.trim();
            var var_client_cd  = v_client_cd.Text.trim();
            
            if(var_depart_date1=="" || var_depart_date1.length!=8){
                alert("출발일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date1").Focus();
                return;
            }
            
            if(var_depart_date2=="" || var_depart_date2.length!=8){
                alert("출발일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date2").Focus();
                return;
            }

            if(var_client_cd.length>0 && var_client_cd.length<5){
                alert("대리점코드는 5자리 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
            
            var v_param = "proType=S&dsType=1"
                        + "&v_depart_date1="+var_depart_date1
                        + "&v_depart_date2="+var_depart_date2
                        + "&v_client_cd="+var_client_cd;
                        
            ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv001H?"+v_param;
            ds1.Reset();
        }
        
        // 사업장을 조회 
        function fnAdd() {
            var row = ds1.rowposition;
            if(ds1.CountRow==0) {
                alert("먼저 조회를 하시길 바랍니다.");
                getObjectFirst("v_depart_date").Focus();
                return false;
            }
            window.returnValue  = ds1.NameValue(row, "ACCEPT_SID")+";"
                                + ds1.NameValue(row, "ACCEPT_NO")+";"
                                + ds1.NameValue(row, "GOODS_NM")+";"
                                + ds1.NameValue(row, "DEPART_DATE")+";"
                                + ds1.NameValue(row, "DEPART_TIME")+";"
                                + ds1.NameValue(row, "NIGHTS")+";"
                                + ds1.NameValue(row, "GOODS_SID")+";"
                                + ds1.NameValue(row, "ARRIVE_DATE")+";"
                                + ds1.NameValue(row, "ARRIVE_TIME")+";"
                                + ds1.NameValue(row, "CLIENT_SID")+";"
                                + ds1.NameValue(row, "CLIENT_CD")+";"
                                + ds1.NameValue(row, "CLIENT_NM")+";";
            fnClose();
        }
        
        function fnClose() {
            window.close();
        }

        /**
         * 검색조건 대리점  팝업 
         */
        function fnSelClientPopup(dirPath, servletPath) {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            arrResult = fnClientPop(dirPath,'');
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                v_client_cd.Text = arrParam[2];
            } else {
                v_client_cd.Text = "";
            }               
        }
            
        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			fnShowLoading(410,180);
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
			fnHideLoading();
            if(row==0){
                alert("출발일자에 대한 신청서가 없습니다.");
            }
        </script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  조회중 에러 
%>      
        <script language=JavaScript  for=ds1 event="OnLoadError()">
			fnHideLoading();
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  그리드 더블클릭 이벤트 발생
//
%>          
        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnAdd();
        </script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  출발일자 엔터키 발생시
//
%>          
    <script language=JavaScript for=v_depart_date1 event=onKeyUp(kcode,scode)>
        if(kcode==13) fnSelect();
    </script>
    <script language=JavaScript for=v_depart_date1 event=OnKillFocus()>
        if(var_depart_date!=v_depart_date1.Text.trim()){
            var_depart_date = v_depart_date1.Text.trim();
            v_depart_date2.Text = v_depart_date1.Text;
        }
    </script>
    <script language=JavaScript for=v_depart_date2 event=onKeyUp(kcode,scode)>
        if(kcode==13) fnSelect();
    </script>
    <script language=JavaScript for=v_client_cd event=onKeyUp(kcode,scode)>
        if(kcode==13) fnSelect();
    </script>
    
<!-----------------------------------------------------------------------------
                                DataSet Components 선언 
# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
        <%=HDConstant.COMMENT_START%>
        <object id="ds1" classid=<%=HDConstant.CT_DATASET_CLSID%>>
            <param name="SyncLoad" value="false">
        </object>
        <%=HDConstant.COMMENT_END%>

    </head> 
    
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;" width="100%">
                        <tr>
                            <td height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center>신청서번호
                            </td>
                        </tr>
                        <tr>
                            <td valign=bottom align=right>
                                <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="객실타입/명을 검색합니다" style="cursor:hand;" onclick="fnSelect();">
                                <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">                            
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table border='0' cellpadding='0' cellspacing='1' width='100%' height='100%' bgcolor="#666666">
                                    <tr>
                                        <td class="text" width="80px" height="30" style="solid #708090">출발일자</td>
                                        <td width="210px" bgcolor="#ffffff">&nbsp;
                                            <%=HDConstant.COMMENT_START%>
                                            <object id=v_depart_date1 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                                <param name=Format      value="YYYY-MM-DD">
                                                <PARAM NAME=InputFormat value="YYYYMMDD">
                                                <param name=Alignment   value=1>
                                                <param name=ClipMode    value=true>
                                                <param name=Border      value=false>
                                                <param name=MaxLength   value="8">
                                                <param name=SelectAll   value=true>
                                                <param name=SelectAllOnClick      value=true>
                                                <param name=SelectAllOnClickAny   value=false>
                                                <param name=Text        value="<%=firstday%>">
                                            </object>
                                            <%=HDConstant.COMMENT_END%> ~ 
                                            <%=HDConstant.COMMENT_START%>
                                            <object id=v_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                                <param name=Format      value="YYYY-MM-DD">
                                                <PARAM NAME=InputFormat value="YYYYMMDD">
                                                <param name=Alignment   value=1>
                                                <param name=ClipMode    value=true>
                                                <param name=Border      value=false>
                                                <param name=MaxLength   value="8">
                                                <param name=SelectAll   value=true>
                                                <param name=SelectAllOnClick      value=true>
                                                <param name=SelectAllOnClickAny   value=false>
                                                <param name=Text        value="<%=firstday1%>">
                                            </object>
                                            <%=HDConstant.COMMENT_END%>
                                        </td>
                                        <td class="text" width="80px" height="30" style="solid #708090">대리점코드</td>
                                        <td width="210px" bgcolor="#ffffff">&nbsp;
                                            <%=HDConstant.COMMENT_START%>
                                            <object id=v_client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                                <param name=Format      value="00000">
                                                <param name=Alignment   value=1>
                                                <param name=ClipMode    value=true>
                                                <param name=Border      value=false>
                                                <param name=MaxLength   value="5">
                                                <param name=Text        value="<%=c_cd%>">
                                                <param name=Enable      value="<%=v_accept_enable%>">
                                                <param name=SelectAll   value=true>
                                                <param name=SelectAllOnClick      value=true>
                                                <param name=SelectAllOnClickAny   value=false>
                                            </object>
                                            <%=HDConstant.COMMENT_END%>&nbsp;
                                        <%if(v_ut.equals("")){%>
                                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" id="v_client_btn" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                                        <%}%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
            <tr>
                <td>
<%
/*---------------------------------------------------------------------------->
    Object ID   : 그리드 , gr1
    Data ID     : ds1
-----------------------------------------------------------------------------*/
%>
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=479px; height:240px;border:1 solid #777777;">
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="AllShowEdit"   value="false"> <!-- Edit가능  -->
                        <param name="ColSizing"     value="true">
                        <param name="Editable"      value="false">
                        <param name="FillArea"      value="True">
                        <param name="SortView"      value="Right">
                        <param name="Viewsummary"   value="1">
                        <param name="Format"        value="
                            <c> Name='신청서번호'      ID='ACCEPT_NO'       Edit=None Width=130  align=center sort=true sumtext='계'</c>
                            <c> Name='상 품 명'        ID='GOODS_NM'        Edit=None Width=200 sort=true sumtext=@cnt</c>
                            <c> Name='매 출 처'        ID='CLIENT_NM'       Edit=None Width=130 sort=true</c>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>