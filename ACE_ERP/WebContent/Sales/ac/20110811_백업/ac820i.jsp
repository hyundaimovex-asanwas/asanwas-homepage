<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 카드거래현황
 * 프로그램ID   : AC820I
 * J  S  P      : ac820i
 * 서 블 릿        : Ac820I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-11
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-12-18][심동현] 가수금 구분을 위해 상품 컬럼 추가..
 * [2010-01-19][박경국] 좌측 GRID에서 상품/출발일자 컬럼 삭제.. 
                        여러개의 상품을 동시에 결재시 중복된 거래내역이 조회되는 현상 방지..
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
    String startDay = "";
    String endDay = "";

    //월요일이면 토요일 부터 일요일까지 거래에 대해서만 지정해주며,
    //기타 요일인 경우는 전일자에 대해서만 셋팅해준다.
    if(java.util.Calendar.DAY_OF_WEEK == java.util.Calendar.MONDAY){
        date.add(java.util.Calendar.DATE, -2);
        startDay = m_today.format(date.getTime());
        date.add(java.util.Calendar.DATE, +1);
        endDay = m_today.format(date.getTime());
    } else {
        date.add(java.util.Calendar.DATE, -1);
        startDay = m_today.format(date.getTime());
        endDay = m_today.format(date.getTime());
    }
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
            cfStyleGrid(getObjectFirst("gr2"), "comn1");
            fnInit(); 
        } 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */ 
        function fnInit() {
            //작업구분
            ds_job_sel.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC014";
            ds_job_sel.Reset();
 
 			//지역구분           
   	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS_ALL=codeDs1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);   
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
                        + ",v_to_date="+getObjectFirst("v_to_date").Text
                        + ",v_job_sel="+v_job_sel.ValueOfIndex ("DETAIL", v_job_sel.Index)
                        + ",v_card_no="+getObjectFirst("v_card_no").Text
                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                        + ",v_issue_company_nm="+getObjectFirst("v_issue_company_nm").value
						+ ",v_job_gu="+v_job_gu		//--요넘은 늘 1로 날아가네..후움..
	                    + ",v_saup_sid=" + v_saup_sid.ValueOfIndex("saup_sid", v_saup_sid.Index);

            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(O:DEFAULT=ds_default)",
                v_param);
            tr_post(tr1);
        }
//        function fnSelect2(){
//        	gr_default.ReDraw = "False";
//            var v_param = "proType=<%//=HDConstant.PROCESS_TYPE_APPLY%>"
//                        + ",dsType=1"
//                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
//                        + ",v_to_date="+getObjectFirst("v_to_date").Text
//                        + ",v_job_sel="+v_job_sel.ValueOfIndex ("DETAIL", v_job_sel.Index)
//                        + ",v_card_no="+getObjectFirst("v_card_no").Text
//                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
//                        + ",v_issue_company_nm="+getObjectFirst("v_issue_company_nm").value;
//
//            ln_TRSetting(tr1, 
//                "<%//=dirPath%><%//=HDConstant.PATH_AC%>Ac820I",
//                "JSP(O:DEFAULT2=ds_default2)",
//                v_param);
//            tr_post(tr1);
        
        
 //       }

        function fnSave(){
            if(ds_default.IsUpdated==false){
                alert("변경된 내역이 없습니다.");
                return;
            }
            
            for(var i=1; i<=ds_default.CountRow; i++){
                if(ds_default.RowStatus(i)==3){
                    var t_req_date = ds_default.NameValue(i, "REQ_DATE").trim();
                    if(ds_default.NameValue(i, "JOB_SEL")=="T"){
                        if(t_req_date=="" || t_req_date.length!=8){
                            alert("청구일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                            ds_default.RowPosition = i;
                            gr_default.SetColumn("REQ_DATE");
                            return;
                        } else {
                            if(t_req_date<v_today){
                                alert("청구일자는 오늘일자 이후로 지정하시길 바랍니다.");
                                ds_default.RowPosition = i;
                                gr_default.SetColumn("REQ_DATE");
                                return;
                            }
                        }
                    } else if(ds_default.NameValue(i, "JOB_SEL")=="F"){
                        if(t_req_date!=""){
                            alert("선택하시길 바랍니다.");
                            ds_default.RowPosition = i;
                            gr_default.SetColumn("JOB_SEL");
                            return;
                        }
                    }
                }
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1";
                        
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(I:DEFAULT=ds_default,O:RESULT=ds_result)",
                v_param);
            tr_post(tr_save);
            fnSelect('2');
        }

        function fnCancel(){
            ds_default.UndoAll();
        }
        
        function fnExcel() {
            if(ds_default.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr_default").SetExcelTitle(0, "");
            getObjectFirst("gr_default").SetExcelTitle(1, "value:카드거래 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("카드거래 현황", "카드거래 현황.xls", 8);
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

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr_save" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
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
</script>

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
    gr_default.ReDraw = "True";
</script>

<script language=javascript for=gr_default event="OnClick(Row,Colid)">
    if(Row==0) {
        if(Colid=="JOB_SEL" || Colid=="REQ_DATE"){
            gr_default.ReDraw = "false";
            for(var i=2; i<=ds_default.CountRow; i++) {
                if(ds_default.NameValue(i, "REQ_YN")!="Y")
                    ds_default.NameValue(i, Colid) = ds_default.NameValue(1, Colid);
            }
            gr_default.ReDraw = "true";
        }
        return;
    }
    
    if(Colid=="JOB_SEL" || Colid=="REQ_DATE"){
        if(ds_default.NameValue(Row, "REQ_YN")=="Y"){
            ds_default.NameValue(Row, "JOB_SEL") = "T";
            if(Colid=="REQ_DATE"){
                gr_default.ColumnProp(Colid, "Edit") = "None";
            }
        } else {
            if(Colid=="REQ_DATE"){
                gr_default.ColumnProp(Colid, "Edit") = "Numeric";
            }
        }
    }
    if(Colid=="JOB_SEL" || Colid=="REQ_DATE" || Colid=="ACCEPT_NO" || Colid=="PAY_DATE" || Colid=="CARD_COMPANY_NM" || Colid=="CARD_NO" || Colid=="AGREE_NO" || Colid=="PAY_AMT" || Colid=="PAY_MANAGE_NO"){
    	 var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
						+ ",v_pay_manage_no="+ds_default.NameValue(ds_default.RowPosition,"PAY_MANAGE_NO");
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(O:DS2=ds2)",
                v_param);
            tr_post(tr1);
    }
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
<object id=ds_default2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_job_sel classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품코드 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품코드 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 사업지역구분 -->
    <param name="SyncLoad"  value="False">
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
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect('1')">
                            <img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:hand" align=absmiddle onclick="fnSave()">
                            <img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:hand" align=absmiddle onclick="fnCancel()">
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
                            </object> ~ 
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
                        <td class="text" width="100">작업구분</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_job_sel classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_job_sel>
                                <param name=ListExprFormat  value="detail_nm^0^120"></object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class="text" >지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=codeDs1>
                                <param name=ListExprFormat  value="saup_nm^1^80,saup_sid^1^40">
								<param name=SearchColumn	value="saup_nm">
								<param name=BindColumn		value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>					
                        
                    </tr>
                    <tr height='25px'>
                        <td class="text" width=100>신청서번호</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000-000000000">
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
                        <td class="text" width=100>카드번호</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_card_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=130 align=center class="textbox">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="0000-0000-0000-0000">
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
                        <td class="text" width=100>카드사명</td>
                        <td bgcolor="#FFFFFF">&nbsp;<input type="text" name="v_issue_company_nm" size="10" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
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
                        <td width=630>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='630px' height='420px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
								<param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='선택√'     ID='JOB_SEL'            width=35  align=center EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</FC>
                                     <C> name='청구일√'      ID='REQ_DATE'              width=70  align=center Edit=Numeric EditLimit=8 Mask='XXXX-XX-XX' SumText=합계</C>
                                     <C> name='신청서번호'  ID='ACCEPT_NO'           width=90 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' SumText=@cnt</C>
                                     <C> name='거래일'      ID='PAY_DATE'              width=70  align=center Edit=None Mask='XXXX-XX-XX' bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='카드사'      ID='CARD_COMPANY_NM'   width=40  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='카드번호'    ID='CARD_NO'            width=120  align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' mask='XXXX-XXXX-XXXX-XXXX'</C>
									 <C> name='할부'    ID='CARD_HALBU'            width=30  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' mask='XX'</C>
                                     <C> name='승인번호'    ID='AGREE_NO'           width=60 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='거래금액'    ID='PAY_AMT'            width=70  align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0 SumText=@sum</C>
                                     <C> name='결제관리번호'    ID='PAY_MANAGE_NO'   width=90  align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
									 <C> name='지역'		ID='SAUP_SID' Width=60 Align=center editstyle=lookup data='codeDs1:saup_sid:saup_nm' bgcolor='<%=HDConstant.GRID_ITEM%>' Show=true </C>
							 ">                             
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=207>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='207px' height='420px' border='1'>
                                <param name="DataID"            value="ds2">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="ViewSummary"		value="1">
                                <param name="Format"            value="
									<C> name='이름'     	 ID='CUST_NM'       width=60 align=center  SumText='합계' </C>
									<C> name='주민/여권번호' ID='MANAGE_NO'		width=90 align=center </C>
									<C> name='결제액'  		 ID='PAY_AMT'       width=60 align=right dec=0 SumText=@sum</C>
									<C> name='회계\\구분'    ID='ACCT_GUBN_NM'  Width=40 align=Center</C>
									<C> name='입금\\방법'    ID='PAY_CD_NM'     Width=40 align=Left   show=false </C>
									<C> name='입금\\여부'    ID='PAY_YN'        Width=35 align=Center show=false </C>
									<C> name='신청서번호'	 ID='ACCEPT_NO'     width=90 align=center show=false </C>
                             ">                             
                            </object>    
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><br>※ 상품권 결제내역을 조회하려면 [지역=전체]이어야 하며 신청서번호,카드번호는 무시됩니다.

            </td>
        </tr>
        
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

