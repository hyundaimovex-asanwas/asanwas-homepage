<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 옵션예약
 * 프로그램ID   : RV260I
 * J  S  P      : rv260I
 * 서 블 릿        : Rv260I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-14
 * 기능정의     :
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-03-12][김병진] 저장시 에러 수정
 * [2009-11-30][심동현] plz 스키장 옵션 추가하면서 원화 고려..
 * [2009-12-04][심동현] 선택한 항목을 취소하는 프로세스 추가.
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
    date.add(Calendar.DATE, +1);					//여기서 add()함수를 쓰려면 java.util.Calendar를 로드해야하는듯. 
    String lastday = m_today.format(date.getTime());	//근데 쓰는 곳이 없네..


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
        var v_default_row = 1;
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_master"), "comn1");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
		fnInit(); 
	} 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
            //지역
	        ds_business.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds_business.Reset(); //지역코드


            //상품정보
            ds_goods.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
            ds_goods.Reset();
        }
        
        function fnSelect(){
            if((getObjectFirst("v_fr_depart_date").Text.trim()=="" 
                || getObjectFirst("v_fr_depart_date").Text.trim().length!=8) && v_accept_no.Text==""){
                alert("출발일자 또는 신청서번호 중에 하나는 입력해 주세요!");
                return;
            }
                     
            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_saup_sid="+v_saup.ValueOfIndex ("SAUP_SID", v_saup.Index)
                        + ",v_fr_depart_date="+getObjectFirst("v_fr_depart_date").Text
                        + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_cust_nm="+getObjectFirst("v_cust_nm").value
                        + ",v_manage_no="+getObjectFirst("v_manage_no").Text
                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv260I",
                "JSP(O:DEFAULT=ds_default)",
                v_param);
            tr_post(tr1);
        }
        
        function fnSelectDefault(Row){
            if(ds_detail.IsUpdated){
                ds_default.RowPosition = v_default_row;
                alert("수정중인 데이터가 있습니다.");
                return;
            }
            
            v_default_row = Row;
                    
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_upjang_sid="+ v_upjang.ValueOfIndex ("UPJANG_SID", v_upjang.Index)
                        + ",v_rsv_sid="+ ds_default.NameValue(Row, "RSV_SID")
                        + ",v_depart_date="+ ds_default.NameValue(Row, "DEPART_DATE");
            ln_TRSetting(tr3, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv260I",
                "JSP(O:MASTER=ds_master, O:DETAIL=ds_detail)",
                v_param);
            tr_post(tr3);
        }
        
        function fnSelectMaster(){
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_upjang_sid="+ v_upjang.ValueOfIndex ("UPJANG_SID", v_upjang.Index)
                        + ",v_rsv_sid="+ ds_default.NameValue(ds_default.RowPosition, "RSV_SID")
                        + ",v_depart_date="+ ds_default.NameValue(ds_default.RowPosition, "DEPART_DATE");;
            ln_TRSetting(tr2, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv260I",
                "JSP(O:MASTER=ds_master)",
                v_param);
            tr_post(tr2);
        }
        
        function fnSave(){
            if(ds_detail.IsUpdated==false){
                alert("변경된 내역이 없습니다.");
                return;
            }
             
//             (ds_detail.RowStatus(Row)!=1)
            for(var i=1; i<=ds_detail.CountRow; i++){
                if(ds_detail.NameValue(i, "SALE_QTY")==0){
                    alert("수량<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_detail.RowPosition = i;
                    gr_detail.SetColumn("SALE_QTY");
                    return;
                }
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1"
                        + ",v_rsv_sid="+ ds_default.NameValue(ds_default.RowPosition, "RSV_SID")
                        + ",v_depart_date="+ ds_default.NameValue(ds_default.RowPosition, "DEPART_DATE");
                        
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv260I",
                "JSP(I:DETAIL=ds_detail,O:RESULT=ds_result)",
                v_param);
            tr_post(tr_save);
        }
        
        function fnCancel(){
            ds_master.UndoAll();
            ds_detail.UndoAll();
        }

	    function fnDeleteRow() {
	        ds_detail.DeleteRow(ds_detail.RowPosition);
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
            
            arrResult = fnClientPop(dirPath,'1');
        
            if (arrResult != null && arrResult!=undefined) {
                arrParam = arrResult.split(";");
                v_client_sid.value = arrParam[0];
                v_client_nm.value = arrParam[1];
                v_client_cd.value = arrParam[2];
            } else {
                v_client_sid.value = "";
                v_client_nm.value  = "";
                v_client_cd.value = "";
            }               
        }

        /**
         * 신청서 번호 조회
         */
        function fnAcceptNoPopup(dirPath, servletPath){
            v_cust_row = 0;
            var arrResult   = new Array();
            arrResult = fnAcceptNoPop(dirPath);
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                getObjectFirst("v_accept_sid").value = arrParam[0];
                getObjectFirst("v_accept_no").Text   = arrParam[1];
            }
        }
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    
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

<script language="javascript" for="tr2" event="onsuccess()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr2" event="onfail()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
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

<script language=JavaScript for=v_saup event=OnSelChange()>
    var v_param = "dsType=1"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                + "&s_UpjangType=99"
                + "&s_use_yn=Y";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //업장
</script>

<script language=JavaScript for=v_upjang event=OnSelChange()>
    if(ds_default.CountRow==0) return;
    fnSelectMaster();
</script>

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        ds_master.ClearAll();
        ds_detail.ClearAll();
        return;
    }
    gr_default.ReDraw = "True";
    fnSelectDefault(v_default_row);
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
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDefault(Row);
</script>

<script language=javascript for=gr_default event="OnKeyPress(kcode)">
    if(ds_default.CountRow==0) return;
    if(kcode==38 || kcode==40)
        fnSelectDefault(ds_default.RowPosition);
</script>

<script language=javascript for=gr_master event="OnDblClick(Row,Colid)">
    if(Row==0) return;
    
    ds_detail.AddRow();
    ds_detail.NameValue(ds_detail.RowPosition, "UPJANG_SID")    = ds_master.NameValue(Row, "UPJANG_SID");
    ds_detail.NameValue(ds_detail.RowPosition, "UPJANG_NM")     = ds_master.NameValue(Row, "UPJANG_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "MENU_SID")      = ds_master.NameValue(Row, "MENU_SID");
    ds_detail.NameValue(ds_detail.RowPosition, "MENU_NM")       = ds_master.NameValue(Row, "MENU_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "UNIT_AMT")      = ds_master.NameValue(Row, "UNIT_AMT");
    ds_detail.NameValue(ds_detail.RowPosition, "CURRENCY_NM")   = ds_master.NameValue(Row, "CURRENCY_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "REMARKS")       = ds_master.NameValue(Row, "REMARKS");
    ds_detail.NameValue(ds_detail.RowPosition, "CURRENCY_CD")   = ds_master.NameValue(Row, "CURRENCY_CD");
    ds_detail.NameValue(ds_detail.RowPosition, "EXCH_AMT")      = ds_master.NameValue(Row, "EXCH_AMT");
    
    
    ds_master.DeleteRow(Row);
</script>

<script language=javascript for=gr_detail event="OnDblClick(Row,Colid)">
    if(Row==0) return;
    if(ds_detail.RowStatus(Row)!=1) return; //add된 상태여야지만 빠진다..ㅎ;
    
    ds_master.AddRow();
    ds_master.NameValue(ds_master.RowPosition, "UPJANG_SID")    = ds_detail.NameValue(Row, "UPJANG_SID");
    ds_master.NameValue(ds_master.RowPosition, "UPJANG_NM")     = ds_detail.NameValue(Row, "UPJANG_NM");
    ds_master.NameValue(ds_master.RowPosition, "MENU_SID")      = ds_detail.NameValue(Row, "MENU_SID");
    ds_master.NameValue(ds_master.RowPosition, "MENU_NM")       = ds_detail.NameValue(Row, "MENU_NM");
    ds_master.NameValue(ds_master.RowPosition, "UNIT_AMT")      = ds_detail.NameValue(Row, "UNIT_AMT");
    ds_master.NameValue(ds_master.RowPosition, "CURRENCY_NM")   = ds_detail.NameValue(Row, "CURRENCY_NM");
    ds_master.NameValue(ds_master.RowPosition, "REMARKS")       = ds_detail.NameValue(Row, "REMARKS");
    ds_master.NameValue(ds_master.RowPosition, "CURRENCY_CD")   = ds_detail.NameValue(Row, "CURRENCY_CD");
    ds_master.NameValue(ds_master.RowPosition, "EXCH_AMT")      = ds_detail.NameValue(Row, "EXCH_AMT");
    
    ds_detail.DeleteRow(Row);
</script>

<script language=javascript for=gr_detail event="OnExit(Row,Colid,OldData)">
    if(Row==0) return;
    if(Colid=="SALE_QTY"){
		ds_detail.NameValue(Row, "SUM_AMT") = ds_detail.NameValue(Row, "EXCH_AMT") * ds_detail.NameValue(Row, "SALE_QTY") * ds_detail.NameValue(Row, "UNIT_AMT");
    }
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
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_business classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품코드 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  업장명 -->
    <param name="SyncLoad"  value="false">
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
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
    <param name="StatusResetType"  value="2">
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
                            <img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:hand" align=absmiddle onclick="fnSave()">
                            <img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:hand" align=absmiddle onclick="fnCancel()">
                            <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand"  align=absmiddle onClick="fnDeleteRow()" >
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text" width="70">지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_business>
                                <param name=BindColumn      value="saup_sid">
                                <param name=BindColVal      value="saup_sid">
                                <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                <param name=ListExprFormat  value="saup_nm^0^120">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>   
                        <td class="text"  width="70">출발일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
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
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>                                                                                           
                        <td class="text" width="70">상품정보</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_goods>
                                <param name=ListExprFormat  value="goods_nm^0^150"></object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class="text" width="70">대리점</td>
                        <td align=left bgcolor="#FFFFFF">&nbsp;<input type="text" value="<%=c_cd%>" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
                            <input type="hidden" value="<%=c_sid%>" name='v_client_sid' id='v_client_sid'>
                            <%if(v_ut.equals("")){%>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                            <%}%>
                            <input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:70px;" class='input01' readOnly>
                        </td>
                    </tr>
                    <tr height='25px'>
                        <td class="text">성명</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="10" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                        <td class="text">주민번호</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
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
                        <td class="text">신청서번호</td>
                        <td bgcolor="#FFFFFF" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000-000000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=Enable      value=true>
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn">
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
                        <td width=370>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='370px' height='420px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="Format"            value="
                                     <C> name='출발일자'     ID='DEPART_DATE_VIEW' width=70 align=center Edit=None suppress=2</C>
                                     <C> name='신청서번호'    ID='ACCEPT_NO'       width=90 align=left Edit=None suppress=5</C>
                                     <C> name='성명'         ID='CUST_NM'          width=70 align=left Edit=None</C>
                                     <C> name='주민등록번호'   ID='MANAGE_NO'      width=90 align=left Edit=None</C>
                                     <C> name='총금액'        ID='TOT_OPTION_AMT'  width=60 align=right Edit=None dec=0</C>
                                     <C> name='출발일'   		ID='DEPART_DATE'  </C>
                             ">                             
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=10>&nbsp;</td>
                        <td width=465 valign=top>
                            
                            
                            
                            
                            
                            <table width="100%" border=0 cellspacing=0 cellpadding=0>
                                <tr height=25>
                                    <td>
                                        <table width="100%" border=0 cellspacing=1 cellpadding=0 bgcolor="#666666">
                                            <tr>
                                                <td class="text">영업장</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=180 style="position:relative;left:1px;top:2px" class="txtbox" >
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
                                        <object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='465px' height='180px' border='1'>
                                            <param name="DataID"            value="ds_master">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="
                                                 <C> name='영업장'  ID='UPJANG_NM'      width=70 align=left Edit=None suppress=1</C>
                                                 <C> name='항목'    ID='MENU_NM'        width=100 align=left Edit=None</C>
                                                 <C> name='단가' 	ID='UNIT_AMT'       width=40 align=right Edit=None DEC=0</C>
                                                 <C> name='통화'    ID='CURRENCY_CD'    width=40 align=center Edit=None </C>
                                                 <C> name='환율'    ID='EXCH_AMT'       width=40 align=center Edit=None dec=0</C>
                                                 <C> name='소개'    ID='REMARKS'        width=95 align=left Edit=None</C>
                                         ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                                <tr height=5><td></td></tr>
                                <tr>
                                    <td>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='465px' height='200px' border='1'>
                                            <param name="DataID"            value="ds_detail">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name=UsingOneClick       value="1">
                                            <Param Name="AllShowEdit"       value="True">
                                            <param name="ViewSummary"       value="1">
                                            <param name="Format"            value="
                                                 <C> name='영업장'        ID='UPJANG_NM'     width=70 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' suppress=1</C>
                                                 <C> name='항목'          ID='MENU_NM'   SumText='금액' width=100 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                                 <C> name='단가'     ID='UNIT_AMT'       width=40 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
                                                 <C> name='통화'    ID='CURRENCY_CD'    width=40 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                                 <C> name='환율'	      ID='EXCH_AMT'       width=40 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' DEC=0</C>
                                                 <C> name='수량'          ID='SALE_QTY'       width=40 align=right Edit=Numeric EditLimit=5 DEC=0</C>
                                                 <C> name='합계\\(￦)'    ID='SUM_AMT'        width=70 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0 SumText=@sum</C>
                                                 <C> name='예약시\\결재'  ID='RSV_PAY_YN'     width=60 align=center EditStyle=CheckBox show=true</C>
                                                 <C> name='기재사항'      ID='REMARKS'        width=100 align=left Edit=true</C>
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

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


