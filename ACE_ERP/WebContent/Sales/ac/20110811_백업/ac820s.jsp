<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 신용카드매입내역
 * 프로그램ID   : AC820S
 * J  S  P      : ac820s
 * 서 블 릿        : Ac820S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-11
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-07-27][심동현] 그리드의 지역컬럼  eidt=none 속성 추
 * [2010-01-19][박경국] GRID에 가장 오른쪽 끝에 [해당금액] 추가
	                    [해당금액]은 각 상품별 소계임
 * [2011-01-27][심동현] 쇼핑몰 쪽 카드결제를 포함
 * [2011-01-31][심동현] 조회조건 추가
 *						매출구분 , 지역|구분1, 상품|구분2
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
            fnInit(); 
        } 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
            cfStyleGrid(getObjectFirst("gr_default"), "comn1");
        }
        
        function fnSelect(){
            if(getObjectFirst("v_fr_date").Text.trim()=="" 
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("청구일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()=="" 
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("청구일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            
            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text
                        + ",v_agree_no="+getObjectFirst("v_agree_no").Text
                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                        + ",v_issue_company_nm="+getObjectFirst("v_issue_company_nm").value;

            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820S",
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
            getObjectFirst("gr_default").SetExcelTitle(1, "value:신용카드매입내역 ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("신용카드매입내역 ("+ getObjectFirst("v_fr_date").Text +" ~ "+ getObjectFirst("v_to_date").Text +")", "신용카드매입내역.xls", 8);
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

<script language=JavaScript for=v_fr_date event=OnKillFocus()>
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
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

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
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
                        <td class="text"  width="100">청구일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=toDay%>">
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
                            </object> ~ 
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=toDay%>">
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
                        <td class="text" width="150">카드사명</td>
                        <td bgcolor="#FFFFFF">&nbsp;<input type="text" name="v_issue_company_nm" size="10" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                    </tr>
                    <tr height='25px'>
                        <td class="text">승인번호</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_agree_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="00000000">
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
                        <td class="text">신청서|주문 번호</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000000000000">
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
                        <td width=845>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='420px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="Format"            value="
 <C> name='거래일'      ID='PAY_DATE'          width=70	align=center Edit=None Mask='XXXX-XX-XX'	suppress=1</C>
 <C> name='청구일'      ID='REQ_DATE'          width=70	align=center Edit=None Mask='XXXX-XX-XX'	suppress=2</C>
 <C> name='카드사'      ID='CARD_COMPANY_NM'   width=60 align=center Edit=None	suppress=3</C>
 <C> name='카드번호'    ID='CARD_NO'           width=110	align=left   Edit=None	suppress=4</C>
 <C> name='승인번호'    ID='AGREE_NO'          width=65 align=center Edit=None	suppress=5</C>
 <C> name='청구금액'    ID='PAY_AMT'           width=70 align=right  Edit=None decao=0	suppress=6</C>
 <C> name='지역 |\\구분1'		ID='SAUP_SID' 		   Width=60  Align=center Edit=None Show=true Edit=None	suppress=7</C>
 <C> name='상품 |\\구분2'		ID='GOODS_NM'  		   Width=70  Align=center edit=none  Show=true suppress=8</C>
 <C> name='출발일 |\\주문일자'	ID='DEPART_DATE' 	   Width=70  Align=center edit=none  Show=true	suppress=9 </C>
 <C> name='신청서 |\\주문번호'  ID='ACCEPT_NO'         width=100 align=left   Edit=None	</C>
 <C> name='해당금액'    ID='GOODS_PAY_AMT'     width=70 align=right  Edit=None decao=0	</C>
                             ">                             
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

