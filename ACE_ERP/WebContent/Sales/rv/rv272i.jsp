<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 서비스 요청내역(사업소 업장 중심 뷰)
 * 프로그램ID   : RV272I
 * J  S  P      : rv272i
 * 서 블 릿        : Rv272I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-31
 * 기능정의     :
 * [수  정   일  자][수정자] 내용
 * [2010-08-25][박경국] 서비스 요청관리 신규화면.
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

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());
    date.add(Calendar.DATE, +1);
    String lastday = m_today.format(date.getTime());
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
        var div='';
        //var v_job='';
        /*
         * 페이지로딩
         */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			fnInit();
		}
        function fnInit() {
            // 지역
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드
		}
        /*
         * 메인 조회
         */
        function fnSelect() {
            if(getObjectFirst("v_fr_use_date").Text.trim()==""
                || getObjectFirst("v_fr_use_date").Text.trim().length!=8){
                alert("출발일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_use_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_use_date").Text.trim()==""
                || getObjectFirst("v_to_use_date").Text.trim().length!=8){
                alert("출발일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_use_date").Focus();
                return;
            }
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_saup.ValueOfIndex("saup_sid", v_saup.Index)
                      + ",sClientSid=" + sClientSid.value 
                      + ",v_upjang_sid="+v_upjang.ValueOfIndex("upjang_sid", v_upjang.Index)
                      + ",v_fr_accept_date=" + v_fr_accept_date.Text
                      + ",v_to_accept_date=" + v_fr_accept_date.Text
                      + ",v_fr_date=" + v_fr_date.Text
                      + ",v_to_date=" + v_to_date.Text
                      + ",v_fr_use_date=" + v_fr_use_date.Text
                      + ",v_to_use_date=" + v_to_use_date.Text
                      + ",v_cust_nm=" + v_cust_nm.value;
			//alert(param);
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv272I",
                "JSP(O:MASTER=ds1)",
                param);
            tr_post(tr1);
        }
         /*
         * 디테일 조회
         */
        function fnSelectDetail() {
           
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_saup.ValueOfIndex("saup_sid", v_saup.Index)
                      + ",sClientSid=" + sClientSid.value 
                      + ",v_upjang_sid="+v_upjang.ValueOfIndex("upjang_sid", v_upjang.Index)
                      + ",v_fr_accept_date=" + v_fr_accept_date.Text
                      + ",v_to_accept_date=" + v_fr_accept_date.Text
                      + ",v_fr_date=" + v_fr_date.Text
                      + ",v_to_date=" + v_to_date.Text
                      + ",v_fr_use_date=" + v_fr_use_date.Text
                      + ",v_to_use_date=" + v_to_use_date.Text
                      + ",v_cust_nm=" + v_cust_nm.value
		              + ",v_menu_sid=" + ds1.namevalue(ds1.rowposition,"menu_sid")
      	              + ",v_use_seq="  + ds1.namevalue(ds1.rowposition,"use_seq");
            //alert(param);
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv272I",
                "JSP(O:DETAIL=ds2)",
                param);
            tr_post(tr1);
        }
        // 적용
		function fnApply() {
			if ( ds2.isUpdated ) {
            window.status="저장 중입니다. 잠시만 기다려 주십시오...";

			ln_TRSetting(tr2, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv272I",
	             "JSP(I:DETAIL=ds2)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr2);
            
	        } else {
	        	alert("업데이트된 행이 없습니다.");
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
        // 취소
		function fnCancel() {
			if (ds2.IsUpdated ) {
				ds2.undoall();
			}
		}
    	//엑셀
	     function fnExcelds2() {
		     
		      if(gr1.CountRow==0 && ds_tour.CountRow==0){
	                alert("데이터를 먼저 조회하시길 바랍니다.");
	                return;
	            }
	            getObjectFirst("gr1").SetExcelTitle(0, "");
	            getObjectFirst("gr1").SetExcelTitle(1, "value:서비스 요청관리; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	            getObjectFirst("gr1").GridToExcel("서비스요청관리", "서비스요청관리.xls", 8);        

	            if(gr2.CountRow==0 && ds_tour.CountRow==0){
	                alert("데이터를 먼저 조회하시길 바랍니다.");
	                return;
	            }
	            getObjectFirst("gr2").SetExcelTitle(0, "");
	            getObjectFirst("gr2").SetExcelTitle(1, "value:서비스 요청관리; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	            getObjectFirst("gr2").GridToExcel("서비스요청관리", "서비스요청관리.xls", 8);        
        }
       </script>
<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
%>
<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
</script>	
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)" >
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)" >
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>
<script language=JavaScript  for=v_fr_date event="OnKillFocus()" >
    if(v_fr_date.Modified)
        v_to_date.Text = v_fr_date.Text
</script>
<script language=JavaScript  for=v_fr_accept_date event="OnKillFocus()" >
    if(v_fr_accept_date.Modified)
        v_to_accept_date.Text = v_fr_accept_date.Text
</script>
<script language=JavaScript  for=v_fr_use_date event="OnKillFocus()" >
    if(v_fr_use_date.Modified)
        v_to_use_date.Text = v_fr_use_date.Text
</script>
 <script language=JavaScript for=v_saup event=OnSelChange()>
    var v_param = "dsType=1"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.bindcolval
                + "&s_UpjangType=99";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //업장
</script>
<script language="javascript" for=gr1 event=OnClick(row,colid)>
			fnSelectDetail();
</script>
<script language=JavaScript for=ds1 event="OnLoadCompleted(row)">
	if ( ds1.CountRow > 0 )
		fnSelectDetail();
</script>
<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=true>
</object>
<object id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value=true>
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0' width='845'>
        <tr>
            <td width='845px'>
                <table  border='0' cellpadding='0' cellspacing='0' width='845'>
                    <tr>
	                    <td>
							  <table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
								<tr bgcolor="#6f7f8d">
									<td align=center class="text" width="80">출발일자</td>
			                        <td align=left width=175 bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
			                                <param name=Text                  value="">
			                                <param name=Alignment             value=1>
			                                <param name=Format                value="YYYY-MM-DD">
			                                <param name=InputFormat           value="YYYYMMDD">
			                                <param name=Cursor                value="iBeam">
			                                <param name=Border                value="false">
			                                <param name=InheritColor          value="true">
			                                <param name=ReadOnly              value="false">
			                                <param name=SelectAll             value="true">
			                                <param name=SelectAllOnClick      value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>~
			                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
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
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>								  
								</tr>
							  </table>
						 <td align=right>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle 	onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" align=absmiddle 	onClick="fnApply()">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle  	onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelds2()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
                    <tr>
                         <td align=left class="text" width="80">신청일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text                  value="">
                                <param name=Alignment             value=1>
                                <param name=Format                value="YYYY-MM-DD">
                                <param name=InputFormat           value="YYYYMMDD">
                                <param name=Cursor                value="iBeam">
                                <param name=Border                value="false">
                                <param name=InheritColor          value="true">
                                <param name=ReadOnly              value="false">
                                <param name=SelectAll             value="true">
                                <param name=SelectAllOnClick      value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>~
                            <object id=v_to_accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
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
                                <param name=SelectAllOnClickAny   value="false">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td align=left class="text" width="80">지역</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=80 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_saup>
                                <param name=SearchColumn        value="saup_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="saup_nm^0^80">
                                <param name=BindColumn          value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td align=center class="text">대리점</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
							<input id="sClientSid" type="hidden" value="0">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
							<input id="sClientNm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="" readOnly>
						</td>
					</tr>
                    <tr>
	                    <td align=left class="text" width="80">이용일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_use_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text                  value="<%=firstday%>">
                                <param name=Alignment             value=1>
                                <param name=Format                value="YYYY-MM-DD">
                                <param name=InputFormat           value="YYYYMMDD">
                                <param name=Cursor                value="iBeam">
                                <param name=Border                value="false">
                                <param name=InheritColor          value="true">
                                <param name=ReadOnly              value="false">
                                <param name=SelectAll             value="true">
                                <param name=SelectAllOnClick      value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>~
                            <object id=v_to_use_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text        value="<%=firstday%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class=text>업장명</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=170 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_upjang>
                                <param name=SearchColumn        value="upjang_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="upjang_nm^0^170">
                                <param name=BindColumn          value="upjang_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
						<td class="text">성명</td>
                        <td align=left bgcolor="#ffffff" colspan="3">&nbsp;<input type="text" name="v_cust_nm" size="13" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 20);"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr>
                        <td>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='200px' border='1'>
                                <param name="DataID"              value="ds1">
                                <param name="ColSizing"           value="true">
                                <param name="Fillarea"            value="false">
                                <param name="Editable"            value="true">
                                <param name="BorderStyle"         value="0">
                                <param name=SortView              value="Left">
                                <param name="SuppressOption"      value="1">
                                <param name="ViewSummary"         value="1">
                                <param name="Format"              value="
					                <C> name='이용일자'     ID='use_date'    width=70 align=left show=true mask=XXXX-XX-XX suppress=1 sumcolor=#000000 sumbgcolor=#E0CFE4 sumtext=계</C>							            
					                <C> name='요일'      	 ID='yoil_nm'       width=70 align=center edit=none show=true sumcolor=#000000 sumbgcolor=#E0CFE4  suppress=2 sumtext=@count</C>
					                <C> name='영업장'    	 ID='upjang_nm'     width=100 align=left edit=none show=true  sumcolor=#000000 sumbgcolor=#E0CFE4 suppress=3 sumtext='건' </C>
                       				<C> name='메뉴명'        ID='menu_nm'        Width=150   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left</C>		
                       				<C> name='메뉴명'        ID='menu_sid'        Width=150   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left show=false</C>																			
									<C> name='회차'           ID='use_seq'        Width=70   sumcolor=#000000 sumbgcolor=#E0CFE4 lign=right  sumtext='총'  </C>		
					                <C> name='수량'     		 ID='menu_cnt'      width=70 sumcolor=#000000 sumbgcolor=#E0CFE4 align=right edit=none how=true sumtext=@sum </C>
					                <C> name='가용'   		 ID='available_cnt'    fontstyle=bold Width=70  sumcolor=#000000 sumbgcolor=#E0CFE4 align=right edit=none sumtext=@sum </C>
					                <C> name='예약'  		ID='rsv_cnt'           width=70 align=right edit=none sumcolor=#000000 sumbgcolor=#E0CFE4 show=true sumtext=@sum </C>
                           			<C> name='참고'     		ID='remarks'        Width=160   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left</C>
					               ">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
            </td>
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr height="10">
                        <td>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='200px' border='1'>
                                <param name="DataID"              value="ds2">
                                <param name="ColSizing"           value="true">
                                <param name="Fillarea"            value="false">
                                <param name="Editable"            value="true">
                                <param name="BorderStyle"         value="0">
                                <param name=SortView              value="Left">
                                <param name="SuppressOption"      value="1">
                                <param name="ViewSummary"         value="1">
                                <param name="Format"              value="
									<G>name='요청 서비스 항목'
						                <C> name='이용일자'  		ID='use_date'     	width=70 align=center editlimit=8   sumcolor=#000000 sumbgcolor=#E0CFE4 edit=none show=true mask=XXXX-XX-XX sumtext=계</C>
									    <C> name='메뉴명'          	ID='menu_nm'   	width=100 align=center Edit=None    sumcolor=#000000 sumbgcolor=#E0CFE4 sumtext=@count </C>
										<C> name='영업장'         	ID='upjang_nm'    	width=70 align=center Edit=None    sumcolor=#000000 sumbgcolor=#E0CFE4 sumtext='건' </C>
										<C> name='가용' 				ID='available_cnt'   width=60 align=right Edit=None     sumcolor=#000000 sumbgcolor=#E0CFE4 DEC=0</C>
										<C> name='단가'     			ID='unit_amt'       	width=40 align=right Edit=None     sumcolor=#000000 sumbgcolor=#E0CFE4 dec=0</C>
										<C> name='통화'    			ID='currency_cd'  	width=40 align=center Edit=None   sumcolor=#000000 sumbgcolor=#E0CFE4  </C>
										<C> name='환율'	      		ID='exch_amt'     	width=40 align=center Edit=None     sumcolor=#000000 sumbgcolor=#E0CFE4 DEC=0  </C>
										<C> name='수량'          	ID='sale_qty'      	width=40 align=right Edit=true   sumcolor=#000000 SumText='금액' sumbgcolor=#E0CFE4 EditLimit=5 DEC=0 bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
										<C> name='합계(￦)'   		ID='sum_amt'   		width=70 align=right Edit=None     sumcolor=#000000 dec=0 sumbgcolor=#E0CFE4 SumText=@sum</C>
										<C> name='기재사항'        ID='remarks'       	width=100 align=left Edit=true   sumcolor=#000000 bgcolor='<%=HDConstant.GRID_ITEM%>' SumText='원' sumbgcolor=#E0CFE4 </C>
									</G>
		                             <G>name='요청서 정보'
		                                <C> name='RSV_SID'    	ID='rsv_sid' 		    width=60  align=center editlimit=2   sumcolor=#000000 editstyle=lookup  sumbgcolor=#E0CFE4 show=false edit=none </C>
                                   	    <C> name='요청관리번호'     ID='req_no'  		width=100  width=100  align=center   sumcolor=#000000 editlimit=20 sumbgcolor=#E0CFE4 edit=none show=true</C>
                                   	    <C> name='출발일자'  		ID='depart_date'     align=left editlimit=8 show=true   sumcolor=#000000 sumbgcolor=#E0CFE4 edit=none</C>
						                <C> name='이름'   	   		ID='cust_nm'   		width=60  align=left editlimit=30   sumcolor=#000000 edit=none show=true sumbgcolor=#E0CFE4 sort=true</C>
                                   	    <C> name='신청일자'  		ID='accept_date'    width=70    align=center editlimit=8   sumcolor=#000000 edit=none show=true sumbgcolor=#E0CFE4 mask=XXXX-XX-XX </C>
						                <C> name='신청서번호'  	ID='accept_no'  	width=100 align=center editlimit=15   sumcolor=#000000 edit=none show=true sumbgcolor=#E0CFE4 sort=true </C>
                                   	    <C> name='작업상태'    	ID='status_cd' 		width=60  align=center editlimit=2   sumcolor=#000000 editstyle=lookup  sumbgcolor=#E0CFE4 show=true edit=none  Data='ds_status1:detail:detail_nm' </C>
						                <C> name='담당자'       	ID='client_dam_nm'       align=left editlimit=20 show=true   sumcolor=#000000 sumbgcolor=#E0CFE4 edit=none</C>
						                <C> name='연락처'    		ID='mobile_no'   	align=left editlimit=15 show=true   sumcolor=#000000 sumbgcolor=#E0CFE4 edit=none</C>
						                <C> name='요청의견' 		ID='reason'        	width=100	align=left editlimit=200   sumcolor=#000000 show=true sumbgcolor=#E0CFE4 edit=true bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
						                <C> name='접수의견' 		ID='desc'        		width=100  align=left editlimit=200   sumcolor=#000000 show=true sumbgcolor=#E0CFE4 edit=true bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
					                </G>
					               ">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
                <br>
            </td>
        </tr>
    </table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		