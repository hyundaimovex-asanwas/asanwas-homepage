<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 대관명단 - 통통 업로드용
 * 프로그램ID   : RV771S
 * J  S  P      : rv771
 * 서 블 릿     : Rv771S
 * 작 성 자     : 심동현
 * 작 성 일     : 20080307
 * 기능정의     : 교류협력시스템에 업로드를 하기 위한 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-12-03][심동현] 금강산/개성분리. 조회/출력/
 * [2008-03-07][심동현] 컬럼 순서 및 값 수정 
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
    
    String startDay = m_today.format(date.getTime());
    
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
        var v_depart_date = "";
        
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
            fnInit(); 
        }
        
        function fnInit(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");

			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드
        }
        
        function fnSelect() {
            if(getObjectFirst("v_depart_date").Text.trim()=="" || getObjectFirst("v_depart_date").Text.trim().length!=8){
                alert("출발일자  <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date").Focus();
                return;
            }
            
            v_depart_date = getObjectFirst("v_depart_date").Text;
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
	                    + ",v_saup_sid="+ v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)            
                        + ",v_depart_date="+ v_depart_date
                        + ",v_nights="+ getObjectFirst("v_nights").value;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv771S",
                "JSP(O:DEFAULT=ds1)",
                v_param);
            tr_post(tr1);
        }
        
        
        function fnApply() {
        }
        
        function fnExcel(){
            if(ds1.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
//            getObjectFirst("gr1").SetExcelTitle(1, "value:대관명단(통통) 출발일자 ("+v_depart_date +") "+ getObjectFirst("v_nights").value +"박; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("대관명단(통통)", "대관명단(통통).xls", 8);        
        }

    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
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

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    if(row==0) return;
    
    var v_param = "sourceName=<%=HDConstant.FILE_UPLOAD_PATH_POLICE%>"+ds_result.NameValue(row, "FILE_NAME")
                + "&realName="+ds_result.NameValue(row, "FILE_NAME");
    
    location.href = "<%=dirPath%><%=HDConstant.PATH_COMMON%>DownLoadFile?"+v_param;
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
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

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" id=btn_excel onClick="fnExcel()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">출발일자</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=startDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td class="text" width="100">지역</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_saup>
                                        <param name=ListExprFormat  value="saup_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text">구분(숙박수)</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;
									<select name=v_nights>
										<option value="-1"> 전체 </option>
										<option value="2"> 3일 (2박)</option>
										<option value="1"> 2일 (1박)</option>
										<option value="0"> 1일 (0박)</option>																				
									</select>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>             
                <tr>
                    <td>
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:420px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="True">
                        <param name="SuppressOption"    value="1">
                        <Param Name="UsingOneClick"     value="1">
                        <Param Name="AllShowEdit"       value="True">
                        <param name="ViewSummary"       value="1">
                        <param name="Format"            value=" 
                            <C> name='번호'    				ID='{CURROW}'	Width=40	Edit=none align=Center</C>
                            <C> name='구분'    				ID='DAYS'		Width=30	Edit=none align=Center</C>
                            <C> name='관광증번호'			ID='UNITY_NO'	Width=90	Edit=none align=Left SumText='총건수'</C>
                            <C> name='주민번호/여권번호'	ID='MANAGE_NO'	Width=120   Edit=none align=Left SumText=@count </C>
                            <C> name='성명'         		ID='CUST_NM'	Width=70	Edit=none align=Left</C>
                            <C> name='성명(영문)'			ID='CUST_ENM'	Width=70	Edit=none align=Left</C>
                            <C> name='성별'         		ID='GENDER'		Width=50	Edit=none align=Left</C>
                            <C> name='생년월일'         	ID='BIRTHDATE'	Width=70	Edit=none align=Left</C>
                            <C> name='휴대전화'         	ID='HPNO'		Width=60	Edit=none align=Left</C>
                            <C> name='집전화'         		ID='TELNO'		Width=60	Edit=none align=Left</C>
                            <C> name='직장명'         		ID='COMPANY_NM'	Width=120	Edit=none align=Left/C>
                            <C> name='직위'         		ID='POSITIONS'	Width=80	Edit=none align=Left</C>
                            <C> name='우편번호'         	ID='ZIP_CD' 	Width=60	Edit=none align=Left</C>
                            <C> name='주소1'         		ID='ADDR1' 		Width=100	Edit=none align=Left</C>
                            <C> name='주소2'         		ID='ADDR2' 		Width=100	Edit=none align=Left</C>
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

