<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 사진마감해제
 * 프로그램ID 	 : RV612I
 * J  S  P		 : rv612i
 * 서 블 릿		 : Rv612I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2006-07-29
 * 기능정의		 : 대리점마감해제 조회,등록,삭제,저장
 * [ 수정일자 ][수정자] 내용
 * [2008-10-16][심동현] 신규 
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
   String startday = m_today.format(date.getTime());           
   date.add(java.util.Calendar.DATE, +10);         
   String endday = m_today.format(date.getTime());           
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
    var v_job = "H";
    
    var v_master_row = 0;

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		fnInit();
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr_master"), "comn1");
        cfStyleGrid(getObjectFirst("gr_detail"), "comn");
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds_master.isUpdated || ds_detail.isUpdated) { 
			alert("수정중인 행이 있습니다.");
            return;
		} else {        
            if ( v_fr_date.text.trim() == '' || v_fr_date.text.trim().length!=8) {
                alert("출발일자(From)를 입력해주세요.");
                v_fr_date.Focus();
                return;
            }
            if ( v_to_date.text.trim() == '' || v_to_date.text.trim().length!=8) {
                alert("출발일자(To)를 입력해주세요.");
                v_to_date.Focus();
                return;
            }
            
	        v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";
	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
        	            + "v_fr_date=" + v_fr_date.text.trim() + ","
        	         	+ "v_to_date=" + v_to_date.text.trim();
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv612I",
	            "JSP(O:MASTER=ds_master)",
	            v_param);
	        tr_post(tr1);
	    }
    }
    
    function fnSelectDetail(Row){
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
                    + "v_depart_date=" + ds_master.NameValue(Row, "CALN_DATE");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv612I",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }

    function fnAddRow(){
        ds_detail.AddRow();
        
        if(ds_detail.CountRow==0){
            alert("먼저 조회후 추가하시길 바랍니다.");
            return;
        }
        
    }
    
    function fnDeleteRow(){
        if(ds_detail.RowPosition==0) return;
        
        if(ds_detail.RowStatus(ds_detail.RowPosition)==1){
            ds_detail.DeleteRow(ds_detail.RowPosition);
        } else {
            alert("삭제할 수 없는 데이터입니다.");
            return;
        }
    }
    
	/*
	 * 적용
	 */
	function fnApply() {
        var v_apply_cnt = 0;
		if (ds_master.IsUpdated || ds_detail.IsUpdated) {
            if(ds_master.IsUpdated){
                for(i=1;i<=ds_master.CountRow;i++) {
                    if(ds_master.NameValue(i, "PIC_CLOSE_DATE")=="" || ds_master.NameValue(i, "PIC_CLOSE_DATE").length!=8){
                        alert("마감일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                        gr_master.SetColumn("PIC_CLOSE_DATE");
                        ds_master.RowPosition = i;
                        return;
                    }
                }
            }

            if(ds_detail.IsUpdated){
                for(i=1;i<=ds_detail.CountRow;i++) {
                    if(ds_detail.NameValue(i, "TL_DATE_PIC")!="" && ds_detail.NameValue(i, "TL_DATE_PIC").length!=8){
                        alert("T/L 일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                        gr_detail.SetColumn("TL_DATE_PIC");
                        ds_detail.RowPosition = i;
                        return;
                    }
                    
                    if(ds_detail.NameValue(i, "CLIENT_CD")==""){
                        alert("대리점코드 <%=HDConstant.A_MSG_MUST_INPUT%>");
                        gr_detail.SetColumn("CLIENT_CD");
                        ds_detail.RowPosition = i;
                        return;
                    }
                    if(ds_detail.NameValue(i, "CLIENT_NM")==""){
                        alert("대리점명 <%=HDConstant.A_MSG_MUST_INPUT%>");
                        gr_detail.SetColumn("CLIENT_CD");
                        ds_detail.RowPosition = i;
                        return;
                    }
                }
            }

            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_depart_date="+ ds_master.NameValue(ds_master.RowPosition, "CALN_DATE");
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv612I",
                "JSP(I:MASTER=ds_master,I:DETAIL=ds_detail,O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
            window.status="<%=HDConstant.A_MSG_SAVE_DONE%>";
		}
	}

	/*
	 * 취소
	 */
	function fnCancel() {
        ds_master.undoall();
        ds_detail.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}

</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
    <script language=JavaScript for=ds_master event=OnRowPosChanged(Row)>
        if(Row==0) return;
        
        if(v_master_row==Row) return;
        
        if(ds_detail.IsUpdated){
            alert("변경내역이 있습니다.");
            ds_master.RowPosition = v_master_row;
            return;
        }
        v_master_row = Row;
        fnSelectDetail(Row);
    </script>
	
    <script language=JavaScript for=gr_detail event=OnClick(Row,Colid)>
        if(Row==0) {
            if(Colid == "TL_DATE_PIC"){
                for(var i=1; i<=ds_detail.CountRow; i++){
                    ds_detail.NameValue(i, Colid)=ds_detail.NameValue(1, Colid);
                    ds_detail.NameValue(i, "YOIL_NM")=ds_detail.NameValue(1, "YOIL_NM");
                }
            }
            return;
        }
        
        if(Colid=="CLIENT_CD"){
            if(ds_detail.RowStatus(Row)==1){
                gr_detail.ColumnProp(Colid, "Edit") = "Any";
                gr_detail.ColumnProp(Colid, "EditStyle") = "Popup";
            } else {
                gr_detail.ColumnProp(Colid, "Edit") = "None";
                gr_detail.ColumnProp(Colid, "EditStyle") = "";
            }
        }
    </script>
    
    <script language=JavaScript for=gr_detail event=OnPopup(Row,Colid,data)>
        if(Row==0) return;
        
        if(Colid=="CLIENT_CD"){
            ds_detail.NameValue(Row, "CLIENT_CD") = "";
            ds_detail.NameValue(Row, "CLIENT_NM") = "";
            
            var arrParam    = new Array();
            var arrResult   = new Array();
            
            arrResult = fnClientPop("<%=dirPath%>", "");    
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                
                for(var i=1; i<=ds_detail.CountRow; i++){
                    if(ds_detail.NameValue(i, "CLIENT_CD") == arrParam[2]){
                        alert("동일한 대리점이 존재 합니다.");
                        return;
                    }
                }
                
                ds_detail.NameValue(Row, "CLIENT_NM") = arrParam[1];
                ds_detail.NameValue(Row, "CLIENT_CD") = arrParam[2];
            } else {
                ds_detail.NameValue(Row, "CLIENT_NM") = "";
                ds_detail.NameValue(Row, "CLIENT_CD") = "";
            }               
        }
    </script>
    
    <script language=JavaScript for=gr_detail event=OnExit(Row,Colid,olddata)>
        if(Row==0) return;
        if(Colid == "TL_DATE_PIC"){
            var v_TL_DATE_PIC = ds_detail.NameValue(Row, Colid);
            if(v_TL_DATE_PIC=="" || v_TL_DATE_PIC.length!=8) {
                ds_detail.NameValue(Row, "YOIL_NM") = "";
                return;
            }
            
            if(ds_detail.NameValue(Row, Colid)!=olddata){
                var first_date=new Date(v_TL_DATE_PIC.substring(0, 4),eval(v_TL_DATE_PIC.substring(4, 6))-1,eval(v_TL_DATE_PIC.substring(6)));
                switch(first_date.getDay()+1){
                    case 1 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "일";
                        break;
                    case 2 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "월";
                        break;
                    case 3 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "화";
                        break;
                    case 4 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "수";
                        break;
                    case 5 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "목";
                        break;
                    case 6 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "금";
                        break;
                    case 7 :
                        ds_detail.NameValue(Row, "YOIL_NM_PIC") = "토";
                        break;
                }
            }
        } else if(Colid=="CLIENT_CD"){
            if(ds_detail.NameValue(Row, Colid)!=olddata){
                ds_detail.NameValue(Row, "CLIENT_CD") = "";
                ds_detail.NameValue(Row, "CLIENT_NM") = "";
            }
        }
    </script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
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

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    ds_master.ResetStatus();
    ds_detail.ResetStatus();
    
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(Row==0) return;
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <table border="0" width="845px"  cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right" colspan="2">
                        <table border="0"  cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <table width="303" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr bgcolor="#6f7f8d" height=26>
                                            <td align="center" width="80px" class="text">출발일자</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                    <param name=Text        value="<%=startday%>">
                                                    <param name=SelectAll   value=true>
                                                    <param name=SelectAllOnClick      value=true>
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                                &nbsp;
                                                ~
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                    <param name=Text        value="<%=endday%>">
                                                    <param name=SelectAll   value=true>
                                                    <param name=SelectAllOnClick      value=true>
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" height="30px">        
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/plus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnAddRow()">
                                    <img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()">
                                    <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
                                </td>
                            </tr>   
                        </table>
                    </td>
                </tr>
                <tr> 
                    <td height='5px'></td>
                </tr>
                <tr>
                    <td width="845px" colspan='2'>
                        <table  border="0" cellpadding="0" cellspacing="0" >
                            <tr valign="top"">
                                <td align="left" width="240px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=240px; height:460px" border="1">
                                        <param name="DataID"            value="ds_master">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <C> name='출발일자'				ID='CALN_DATE'         Width=80  align=center mask=XXXX-XX-XX Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='요일'       			ID='YOIL_NM'            Width=60  align=center Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='사진제출\\마감일자' 	ID='PIC_CLOSE_DATE'     Width=80  align=center mask=XXXX-XX-XX Edit=Numeric</C>
                                        ">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>       
                                <td width=10></td>
                                <td align="right" width="595px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_detail  style="width:595px; height:460px" border="1">
                                        <param name="DataID"            value="ds_detail">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <Param Name="SortView"          value="Right">
                                        <param name="Format"            value=" 
                                            <C> name='대리점코드'  ID='CLIENT_CD' sort=true Width=100  align=center Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='대리점'      ID='CLIENT_NM' sort=true Width=120  align=Left Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='T/L 사진√'   ID='TL_DATE_PIC'     Width=80  align=center mask=XXXX-XX-XX Edit=Numeric EditLimit=8</C>
                                            <C> name='요일'        ID='YOIL_NM_PIC'     Width=45  align=center Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='T/L 예약√'   ID='TL_DATE'         Width=80  align=center mask=XXXX-XX-XX Edit=Numeric EditLimit=8 bgcolor='<%=HDConstant.GRID_ITEM%>' Edit=None</C>
                                            <C> name='요일'        ID='YOIL_NM'         Width=45  align=center Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='T/L Biz√'    ID='TL_DATE_BIZ'     Width=80  align=center mask=XXXX-XX-XX Edit=Numeric EditLimit=8 bgcolor='<%=HDConstant.GRID_ITEM%>' Edit=None</C>
                                            <C> name='요일'        ID='YOIL_NM_BIZ'		Width=45  align=center Edit=none bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='참고사항'    ID='REMARKS'         Width=215  align=left Edit=Any EditLimit=50</C>
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

