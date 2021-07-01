<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 카드거래현황 - 온라인
 * 프로그램ID   : AC830I
 * J  S  P      : ac830i
 * 서 블 릿        : Ac830I
 * 작 성 자        : 심동현
 * 작 성 일        : 2007-04-13
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

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    
    String toDay = m_today.format(date.getTime());
    String startDay = toDay;
    String endDay = toDay;

    //월요일이면 토요일 부터 일요일까지 거래에 대해서만 지정해주며,
    //기타 요일인 경우는 전일자에 대해서만 셋팅해준다.
    /*
    if(java.util.Calendar.DAY_OF_WEEK == java.util.Calendar.MONDAY){
        date.add(java.util.Calendar.DATE, -2);
        startDay = m_today.format(date.getTime());
        date.add(java.util.Calendar.DATE, +1);
        endDay = m_today.format(date.getTime());
    } else {
        date.add(java.util.Calendar.DATE, -1);
        startDay = m_today.format(date.getTime());
        endDay = m_today.format(date.getTime());
    }*/
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
        var v_today = "<%=toDay%>";
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

            cfStyleGrid(getObjectFirst("gr_default"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn");
            fnInit(); 
        } 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */ 
        function fnInit() {


        }
        
        function fnSelect(v_job_gu){
            if(getObjectFirst("v_fr_date").Text.trim()=="" 
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("거래일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()=="" 
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("거래일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }

            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac830I",
                "JSP(O:DEFAULT=ds_default)",
                v_param);
            tr_post(tr1);
        }

        
        function fnExcel() {
            if(ds_default.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr_default").SetExcelTitle(0, "");
            getObjectFirst("gr_default").SetExcelTitle(1, "value:카드거래(ON); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("카드거래(ON)", "카드거래(ON).xls", 8);
        }
        
		//카드 영수증 팝업
		function popReceipt(idx){
			var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
		   	window.open(receiptURL,"cardReceipt","width=420,height=670,top=0,left=0");
		}        
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
    gr_default.ReDraw = "True";
</script>

<script language=javascript for=gr_default event="OnClick(Row,Colid)">
	if("PAY_MANAGE_NO"==Colid) {
		popReceipt(ds_default.NameValue(ds_default.RowPosition,"VAN_IDX_NO"));	
	} else {
	 var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                + ",dsType=1"
					+ ",v_pay_manage_no="+ds_default.NameValue(ds_default.RowPosition,"PAY_MANAGE_NO");
	    ln_TRSetting(tr1, 
	        "<%=dirPath%><%=HDConstant.PATH_AC%>Ac830I",
	        "JSP(O:DS2=ds2)",
	        v_param);
	    tr_post(tr1);
	}; 
</script>

<script language=javascript for=ds_result event="OnLoadCompleted(Row)">

    if(Row==0) return;
    
    var v_result_msg = "";
    for(var i=1; i<=ds_result.CountRow; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_result_msg += ds_result.NameValue(i, "MSG")+"\n"
        }
    }
    if(v_result_msg!="")
        alert(v_result_msg);
</script>

<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_default2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품코드 -->
    <param name="SyncLoad"  value="True">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect('1')">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text"  width="100">거래일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=startDay%>">
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
                            </object>　~　
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=endDay%>">
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
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=610>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='610px' height='400px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="Format"            value="
                                     <C> name='거래일시'     ID='U_DATE'         width=70  align=LEFT  EDIT=NONE </FC>
                                     <C> name='결제관리번호' ID='PAY_MANAGE_NO' width=90  align=center Edit=NONE</C>
                                     <C> name='거래금액'  ID='PAY_AMT'        width=80 align=RIGHT Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' DEC=0</C>
                                     <C> name='할부'      ID='QUOTA'         width=40  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' mask='XX'</C>
                                     <C> name='카드사'      ID='CARD_NAME'   width=70  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='결제자'    ID='ORDER_NM'      width=80  align=CENTER Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' </C>
                                     <C> name='상품명'    ID='USER_KEY'      width=180  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                             ">                             
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=227>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='227px' height='400px' border='1'>
                                <param name="DataID"            value="ds2">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="ViewSummary"		value="1">
                                <param name="Format"            value="
                                     <C> name='이름'     		ID='CUST_NM'          	width=60  align=center  SumText='합계' </C>
                                     <C> name='주민/여권번호'     	ID='MANAGE_NO'          width=90  align=center </C>
                                     <C> name='결제액'  			ID='PAY_AMT'           	width=60 align=right dec=0 SumText=@sum</C>
                                     <C> name='신청서번호'      	ID='ACCEPT_NO'          width=90  align=center </C> 
                                     <C> name='출발일자'      	ID='DEPART_DATE'        width=90  align=center </C>
                             ">                             
                            </object>    
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
                <br>
		                ※ [결제관리번호]를 클릭하면 <b>영수증</b>이 표시됩니다.
            </td>
        </tr>
    </table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

