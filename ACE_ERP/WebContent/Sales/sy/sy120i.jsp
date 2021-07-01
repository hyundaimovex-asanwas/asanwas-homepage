<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명       : 메세지관리
 * 프로그램ID  : SY120I
 * J  S  P   : Sy120i
 * 서 블 릿       : Sy120I
 * 작 성 자       : 차태주
 * 작 성 일       : 2006-09-10
 * 기능정의      : 메세지 관리
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
%>



<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
        <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
<script language="javascript">
    var v_job = "H";

    var v_Main_row = 0;

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
        cfStyleGrid(getObjectFirst("grMain"), "comn");
   }

   /*
    * 메인조회
    */
    function fnSelect() {
      if (dsMain.isUpdated) {
         alert("수정중인 행이 있습니다.");
            return;
      } else {

           v_job = "S";
           window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           document.all.LowerFrame.style.visibility="visible";
           var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
                     + "v_msg_cd=" + v_msg_cd.text.trim();
           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_SY%>Sy120I",
               "JSP(O:Main=dsMain)",
               v_param);
           tr_post(tr1);
       }
    }

    function fnAddRow(){
        dsMain.AddRow();
    }

    function fnDeleteRow(){
        if(dsMain.RowPosition==0) return;
        dsMain.DeleteRow(dsMain.RowPosition);
    }

   /*
    * 적용
    */
   function fnApply() {
        var v_apply_cnt = 0;
      if (dsMain.IsUpdated) {
            if(dsMain.IsUpdated){
                for(i=1;i<=dsMain.CountRow;i++) {
                    if(dsMain.NameValue(i, "S_MSG_CD")=="" || dsMain.NameValue(i, "S_MSG_CD").length!=4){
                        alert("메세지코드 <%=HDConstant.A_MSG_MUST_INPUT%>");
                        grMain.SetColumn("S_MSG_CD");
                        dsMain.RowPosition = i;
                        return;
                    }
                }
            }

            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_msg_cd="+ dsMain.NameValue(dsMain.RowPosition, "S_MSG_CD");

            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy120I",
                "JSP(I:Main=dsMain,O:RESULT=dsResult)",
                v_param);
            tr_post(tr1);
            window.status="<%=HDConstant.A_MSG_SAVE_DONE%>";
      }
   }

   /*
    * 취소
    */
   function fnCancel() {
        dsMain.undoall();
        ds_detail.undoall();
      window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
   }

</script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>

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

<script language=JavaScript  for=dsResult event="OnLoadCompleted(row)" >
    dsMain.ResetStatus();

    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(dsResult.NameValue(i, "MSG_CD")!="0000"){
            v_msg += dsResult.NameValue(i, "MSG")+"\n";
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
<script language=javascript for=dsResult event="OnLoadCompleted(Row)">
    if(Row==0) return;
</script>

<%
/*=============================================================================
         DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=dsMain classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=dsResult classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table border="0" width="845px"  cellpadding="0" cellspacing="0">
		  <tr>
			<td align="right" colspan="2">
				<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				  <tr>
					<td WIDTH=300>
						<table width="303" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
						    <tr bgcolor="#6f7f8d">
						        <td align="center" width="80px" class="text">메세지코드</td>
						        <td align="left" bgcolor="#ffffff">&nbsp;
						            <%=HDConstant.COMMENT_START%>
						            <object id=v_msg_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>
						                <param name=Format      value="0000">
						                <PARAM NAME=InputFormat value="0000">
						                <param name=Alignment   value=1>
						                <param name=ClipMode    value=true>
						                <param name=Border      value=false>
						                <param name=Text        value="">
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
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=grMain  style="width=800px; height:460px" border="1">
					        <param name="DataID"            value="dsMain">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="true">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="Format"            value="
					            <C> name='코드'        ID='S_MSG_CD'   Width=50  align=center Edit=Any</C>
					            <C> name='메세지'       ID='S_MSG'      Width=300  align=left Edit=Any</C>
					            <C> name='입력가능'        ID='S_S_YN'     Width=50  align=center EditStyle=CheckBox</C>
					            <C> name='웹메세지'     ID='WEB_MSG'    Width=300  align=left Edit=Any</C>
					            <C> name='웹가능'       ID='WEB_S_YN'   Width=50  align=center EditStyle=CheckBox</C>
					            <C> name='참고사항'     ID='REMARKS'    Width=300  align=left Edit=Any</C>
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

