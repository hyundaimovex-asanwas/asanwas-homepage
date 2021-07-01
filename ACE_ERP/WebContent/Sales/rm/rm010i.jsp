<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 영업장 등록
 * 프로그램ID 	 : RM010I
 * J  S  P		 : rm010i
 * 서 블 릿		 : RM010I
 * 작 성 자		 : 차태주
 * 작 성 일		 : 2006-06-06
 * 기능정의		 : 영업장 등록 (조회 등록 삭제 수정)
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
    
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var sSaupSid = "";
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description 	:  페이지 로딩
	// Parameter 	:
	%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}

	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description 	: 선조회
	// Parameter 	:
	%>
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds2.Reset(); //지역코드

        ds21.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=RM001";
        ds21.Reset(); //객실타입
        
        ds_class.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=RV017";
        ds_class.Reset();//반정보

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm010I",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	:
%>
    function fnSelect() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        v_job = "S";
        sSaupSid = drp_saup.ValueOfIndex("saup_sid", drp_saup.Index);
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid="  + sSaupSid + ","
            + "sUpjangCd=" + txt_UpjangCd.value + ","
            + "sUpjangNm=" + txt_UpjangNm.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm010I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행추가 (그리드별)
// Parameter 	:
%>
	function fnAddRow() {
		ds1.addrow();
        gr1.SetColumn("UPJANG_CD");
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행삭제 (그리드별)
// Parameter 	:
%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용
// Parameter 	:
%>
	function fnApply() {
        v_job = "I";
        sSaupSid = drp_saup.ValueOfIndex("saup_sid", drp_saup.Index);
		if (ds1.IsUpdated) {
            if(confirm("저장하시겠습니까?")){
                for(var i=1; i<=ds1.CountRow; i++){
                    if(ds1.NameValue(i, "UPJANG_CD")==""){
                        alert("영업장 코드<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("UPJANG_CD");
                        return;
                    }
                    if(ds1.NameValue(i, "UPJANG_NM")==""){
                        alert("영업장명<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("UPJANG_NM");
                        return;
                    }
                    if(ds1.NameValue(i, "UPJANG_TYPE_NM")==""){
                        alert("업장타입명<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("UPJANG_TYPE");
                        return;
                    }
                }
                msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                document.all.LowerFrame.style.visibility="visible";
				ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_RM%>Rm010I",
                    "JSP(I:DEFAULT=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,sSaupSid="+sSaupSid);
                tr_post(tr1);
            }
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
	function fnCancel() {
		ds1.undoall();
		msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
    <script language="javascript"  for=gr1 event=OnClick(row,colid)>
        if(row==0){
            if(ds1.CountRow==0) return;
            
            gr1.ReDraw = "False";
            if(colid=="UPJANG_TYPE"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "UPJANG_TYPE") = ds1.NameValue(1, "UPJANG_TYPE");
                    ds1.NameValue(i, "UPJANG_TYPE_NM") = ds1.NameValue(1, "UPJANG_TYPE_NM");
                }
            } else if(colid=="DIRECT_YN1") {
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "DIRECT_YN1") = ds1.NameValue(1, "DIRECT_YN1");
                    if(ds1.NameValue(1, "DIRECT_YN1")=="T")
                        ds1.NameValue(i, "DIRECT_YN") = "Y";
                    else 
                         ds1.NameValue(i, "DIRECT_YN") = "N";
               }
            } else if(colid=="USE_YN1" ){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "USE_YN1") = ds1.NameValue(1, "USE_YN1");
                    if(ds1.NameValue(1, "USE_YN1")=="T")
                        ds1.NameValue(i, "USE_YN") = "Y";
                    else 
                         ds1.NameValue(i, "USE_YN") = "N";
               }
            }
            gr1.ReDraw = "True";
            return;
        }
        
        if(colid=="DIRECT_YN1") {
            if(ds1.NameValue(row, "DIRECT_YN1")=="T")
                ds1.NameValue(row, "DIRECT_YN") = "Y";
            else 
                 ds1.NameValue(row, "DIRECT_YN") = "N";
        } else if(colid=="USE_YN1" ){
            if(ds1.NameValue(row, "USE_YN1")=="T")
                ds1.NameValue(row, "USE_YN") = "Y";
            else 
                 ds1.NameValue(row, "USE_YN") = "N";
        }
    </script>
    
    <script language=JavaScript for=ds1 event=onColumnChanged(row,colid)>
        var flag = false;
        if(colid=="UPJANG_TYPE"){
            for(var i=1; i<=ds21.CountRow; i++){
                if(ds21.NameValue(i, "DETAIL")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "UPJANG_TYPE_NM") = ds21.NameValue(i, "DETAIL_NM");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "UPJANG_TYPE_NM") = "";
        }
    </script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
    <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
        if(colid=="UPJANG_TYPE") {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL;
            var strPos;
            //arrParam[0] : head
            //arrParam[1] : detail
            //arrParam[2] : detail_nm
            //arrParam[3] : item1
            arrParam[0] = "RM001";
            arrParam[1] = "업장타입"; //공통코드의 마스터값
            strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);
            if (arrResult != undefined) {
                arrParam = arrResult.split(";");
                ds1.namevalue(ds1.RowPosition,"UPJANG_TYPE")=arrParam[1];
                ds1.namevalue(ds1.RowPosition,"UPJANG_TYPE_NM")=arrParam[2];
            }
        }
    </script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        document.all.LowerFrame.style.visibility="hidden";
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert("서버로부터 다음과 같은 오류 메시지를 출력했습니다.\n\n" + error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert(row + " 검색된 데이타가 없습니다."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds21 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_class classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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


<table width="100%" height="525" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border=0 cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
							<tr bgcolor="#6f7f8d">
								<td width="120px" class="text">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=drp_saup classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;left:1px;top:2px" class="txtbox" >
									<param name=ComboDataID			value=ds2>
									<param name=SearchColumn		value="saup_nm">
									<param name=Sort				value="false">
									<param name=ListExprFormat		value="saup_nm^0^100">
									<param name=BindColumn			value="saup_sid">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align=left class="text">&nbsp;영업장코드</td>
								<td align=left bgcolor="#ffffff">&nbsp;<input id="txt_UpjangCd" type="text" class="txtbox" size=10 maxlength="40">&nbsp;&nbsp;</td>
								<td align=left class="text">&nbsp;영업장명</td>
								<td align=left bgcolor="#ffffff">&nbsp;<input id="txt_UpjangNm" type="text" class="txtbox" size=10 maxlength="40">&nbsp;&nbsp;</td>
							</tr>
						</table>
					</td>
					<td align="right" width="50%" style="padding-right:6px"><img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelect()">
            			<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:pointer;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
            			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply()">
            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnCancel()">
            		</td>
            	</tr>
            	<tr>
            		<td height=3  border="0"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:470px" border="1">
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="
                                            <FC> name=''             ID='{CURROW}'           Width=25    align=center</FC>
                                            <FC> name='영업장코드'    ID='UPJANG_CD'          Width=100   align=center    Edit=Upper editlimit=5 Sort=True</FC>
                                            <FC> name='영업장명'     ID='UPJANG_NM'          Width=120   align=left      Edit=Any Sort=True</FC>
                                            <C> name='영문명'          ID='UPJANG_ENG_NM'      Width=100   align=left      Edit=AlphaUpper</C>
                                            <C> name='단축명'          ID='UPJANG_SHORT_NM'    Width=100   align=left      Edit=Any</C>
                                            <C> name='업장타입√'     ID='UPJANG_TYPE'        Width=60    align=left      Edit=Numeric EditStyle=popup</C>
                                            <C> name='업장타입명'    ID='UPJANG_TYPE_NM'     Width=100   align=left      BgColor=#fefec0 Edit=none</C>
                                            <C> name='직영여부√'     ID='DIRECT_YN1'          Width=60    align=Center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='사용여부√'     ID='USE_YN1'             Width=60    align=Center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='순서'         ID='DISPLAY_SEQ'        Width=60  align=Center    Edit=Numeric Sort=True</C>
                                            <C> name='반'           ID='CLASS'             Width=60  align=Center    EditStyle=Lookup Data='ds_class:detail:detail_nm' Sort=True</C>
                                            <C> name='참고사항'     ID='REMARKS'            Width=200   align=left      Edit=Any</C>
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

