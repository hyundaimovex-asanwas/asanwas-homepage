<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 관광예약현황
 * 프로그램ID   : RV201S
 * J  S  P      : rv201S
 * 서 블 릿        : Rv201S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-14
 * 기능정의     :  예약조회(퀵)
 *             간단한 쿼리와 조건으로 방문횟수 조회 및 업데이트. 기록 보기.
 * 수정내용     :  2007-03-30 
 * 수 정 자        : 심동현
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
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
			v_job = "H";

	        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds_saup.Reset(); //지역코드
        }
        
    
        /*
         * 메인 조회
         */
        function fnSelect() {
            var manage_no = getObjectFirst("v_manage_no").value.trim();//v_manage_no.value
            if(manage_no.length=0) {
                alert("주민/여권번호를 입력하시기 바랍니다.");
                return;
            }
        
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                      + ",v_manage_no=" + v_manage_no.value;
                      
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv201S",
                "JSP(O:DS_CUST=ds_cust)",
                param);
               
            tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            var manage_no = getObjectFirst("v_manage_no").value.trim();//v_manage_no.value

            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:예약조회 (퀵) - " + manage_no + "; font-face:; font-size:24pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("예약조회 (퀵)", "예약조회 (퀵).xls", 8);        
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
</object>

<!-- 지역 정보 기초데이터 추출 -->
<object id=init_businessDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
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
            <td align='right'>
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
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                            <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                                <tr>
                    				<td class="text" width="100">지역</td>
                                    <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=ListExprFormat  value="saup_nm^0^70">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td align=left class="text">주민/여권번호</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;<input type="text" name="v_manage_no" size="20" maxlength="20" class="textbox" OnKeyUp="if(event.keyCode==13) fnSelect();"></td>
			                       </tr>
                            </table>
                    	</td>
                    </tr>
	                <tr>
	                  <td style="padding-top:8px;padding-bottom:8px">
	                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                      <tr>
	                      	<td style="padding:6px" width=44><img src=../images/attention_Mark.jpg border=0></td>
	                      	<td width=100%>　1. 관광 기록 중, 상태가 <font color=blue>출경(DP), 입경(AR)</font>인 경우만 조회됩니다.<br>
	                      	　2. 조회와 동시에 <A HREF="../cu/cu010i.jsp?scode=SAL&id=m1&menu=1">[고객등록]</A> 메뉴의 관광방문횟수 항목이 업데이트 됩니다.<br>
	                      	</td>
	                      </tr>
	                    </table>
	                  </td>
	                </tr>                    
                </table>
            </td>
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
				                            <param name="ViewSummary"       value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="

  										 	   <C> name='No.'         ID='{STRING(CURROW)}' Width=40  align=RIGHT </C>
                                               <C> name='신청서번호'    ID='ACCEPT_NO'        width=100 align=CENTER Edit=None SumText=총</C>
                                               <C> name='출발일자'      ID='DEPART_DATE'      width=80 align=CENTER Edit=None SumText=@cnt</C>
                                               <C> name='상품'         ID='GOODS_NM'        width=100 align=CENTER Edit=None SumText=회</C>
                                               <C> name='숙박일수'      ID='NIGHTS'          width=60 align=CENTER Edit=None</C>
                                               <C> name='도착일자'     ID='DEPART_DATE'      width=80 align=CENTER  Edit=None </C>
                                               <C> name='고객구분'     ID='CUST_GU'          width=80 align=CENTER  Edit=None </C>
                                               <C> name='당시 핸드폰'   	ID='MOBILE_NO'        width=100 align=CENTER  Edit=None</C>
                                               <C> name='상태'         ID='STATUS_NM'        width=60 align=CENTER  Edit=None</C>
                                               <C> name='입력자'       ID='I_EMPNO'      width=100 align=CENTER  Edit=None</C>
                                                            
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

