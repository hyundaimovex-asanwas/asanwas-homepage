<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 체류현황
 * 프로그램ID   : AC020S
 * J  S  P      : ac020s
 * 서 블 릿        : Ac020S
 * 작 성 자        : 이병욱
 * 작 성 일        : 2006-08-07
 * 기능정의     :
 * 수정내용     : 
 * 수 정 자        :
 * 최종수정일자   :
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
    // ContextPath
    String dirPath = request.getContextPath(); //HDASan
    
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());           
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <!-- HEAD 정보 -->
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/****************************************************************************
                사용자 스크립트
******************************************************************************/
%>      
        <script language="javascript">
        /*
         * 페이지로딩
         */
        function fnOnLoad(){
            cfStyleTab(getObjectFirst("mxTab"), "comn");
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn");
            cfStyleGrid(getObjectFirst("gr3"), "comn");
            cfStyleGrid(getObjectFirst("gr4"), "comn");
            cfStyleGrid(getObjectFirst("gr5"), "comn");
            cfStyleGrid(getObjectFirst("gr6"), "comn");
            cfStyleGrid(getObjectFirst("gr7"), "comn");
            cfStyleGrid(getObjectFirst("gr8"), "comn");
            
            fnInit(); 
        }       

        /*
         * 초기작업
         */
        function fnInit(){
           
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy511B",
                "JSP(O:EXCELDS=tempExcelDs)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
        }

        /**
         * 엑셀적용 
         * 파일 업로드 후에 조회 
         */
         
        function fnExcelApply()  {
        
            tempExcelDs.addrow();
            
            tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
            tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
         
             ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy511B",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS1=ds1,O:EXCELDS2=ds2,O:EXCELDS3=ds3,O:EXCELDS4=ds4,O:EXCELDS5=ds5,O:EXCELDS6=ds6,O:EXCELDS7=ds7,O:EXCELDS8=ds8)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>");
            tr_post(tr1);
        }
            
        /*
         * 저장
         */
        function fnApply() {
            
            var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
                         
            if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated || ds5.IsUpdated || ds6.IsUpdated || ds7.IsUpdated || ds8.IsUpdated) {
                 ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy511B",
                 "JSP(I:EXCELDS1=ds1,I:EXCELDS2=ds2,I:EXCELDS3=ds3,I:EXCELDS4=ds4,I:EXCELDS5=ds5,I:EXCELDS6=ds6,I:EXCELDS7=ds7,I:EXCELDS8=ds8,O:RESULT=ds_result)",
                 param);
                 
                tr_post(tr1);
            }   
        }
        
        /*
         * 엑셀적용후 저장 
         */
            
            
        </script>
<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
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
    
    <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        if (ds1.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds1.countrow; i++) {
            ds1.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
        if (ds2.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds2.countrow; i++) {
            ds2.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
        if (ds3.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds3.countrow; i++) {
            ds3.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
        if (ds4.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds4.countrow; i++) {
            ds4.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
        if (ds5.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds5.countrow; i++) {
            ds5.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
        if (ds6.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds6.countrow; i++) {
            ds6.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
        if (ds7.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds7.countrow; i++) {
            ds7.namevalue(i, "yn") = "U";
        }
    </script>      
    <script language=JavaScript  for=ds8 event="OnLoadCompleted(row)">
		if (ds8.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds8.countrow; i++) {
			ds8.namevalue(i, "yn") = "U";
		}
	</script>             
    
    <script language="javascript" for="gcip_file" event=OnClick()>
        if (fn_trim(gcip_file.value)!="") {
        
            alert(gcip_file.value);
            file_path.value = gcip_file.value;
        }
    </script>

        <script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(ds_result.CountRow>0){
        var v_result_msg = "";
        for(var i=1; i<=ds_result.CountRow; i++){
            if(ds_result.NameValue(i, "MSG_CD")!="0000")
                v_result_msg += ds_result.NameValue(i, "MSG")+"\n";
        }

        if(v_result_msg!="")
            alert(v_result_msg);
    }
</script>

<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!--  사업소 -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
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
    
<body leftmargin="10" topmargin="10" marginwidth="0" marginheight="0" onLoad="fnOnLoad();">
<!--------------------------------- 코딩 부분 시작 ------------------------------->       
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
           <td width="422" height="30" align="left" valign="middle" class="tt"><img src="/HDASan/Sales/images/icon.gif" width="14" height="14"> 자료전송</td>
         </tr>
    </table>
    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td width='845px'>
                <table   border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td>
                            <table border='0' cellpadding='0' cellspacing='1' bgcolor=#666666>
                                <tr height="30px">
                                    <td align="center" width="85px" height="30px" class="text">엑셀파일</td>       
                                    <td width=350 bgcolor=#ffffff  valign="middle">&nbsp;
                                        <input type="text" name="file_path" value="" >&nbsp;
                                        <%=HDConstant.COMMENT_START%>
                                        <OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
                                            <param name="Text"      value="찾아보기">
                                        </OBJECT>&nbsp;
                                        <img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:hand"  border='0' onClick='javascript:fnExcelApply();'>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align='right' bgcolor=#ffffff>
                            <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand" align=absmiddle onClick="fnApply();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px"><td>&nbsp;</td></tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr>
                        <td>
                            <table  border="0" cellpadding="0" cellspacing="0">
                                <tr valign="top"">
                                    <td align="left" width="845px" bordercolor="#000000">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='845px' height='20px'>
                                            <param name="BackColor"         value="#00ffff">
                                            <param name="DisableBackColor"  value="#ffffee">
                                            <param name="Format"            value='
                                                <T>divid="mxTab_page1"  title="영업장정보"</T>
                                                <T>divid="mxTab_page2"  title="동정보"</T>
                                                <T>divid="mxTab_page3"  title="객실타입정보"</T>
                                                <T>divid="mxTab_page4"  title="객실정보"</T>
                                                <T>divid="mxTab_page5"  title="상품정보"</T>
                                                <T>divid="mxTab_page6"  title="공통코드"</T>
                                                <T>divid="mxTab_page7"  title="매출처정보"</T>
                                                <T>divid="mxTab_page8"	title="관광 사업자요금정보"</T>
                                                '> 
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                                <tr valign=top>
                                    <td align="left" width="845px" bordercolor="#000000">
                                        <div class=page id="mxTab_page1" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds1">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='업장SID'            ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0</C>  
                                                <C> name='업장코드'         ID='UPJANG_CD'          width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='업장명'          ID='UPJANG_NM'          width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='업장영문명'            ID='UPJANG_ENG_NM'      width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='업장단축명'            ID='UPJANG_SHORT_NM'    width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='업장타입'         ID='UPJANG_TYPE'        width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='직영여부'         ID='DIRECT_YN'          width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='사용여부'         ID='USE_YN'             width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='화면표시순서'       ID='DISPLAY_SEQ'        width=100 align=left editlimit=50 show=true dec=0</C>  
                                                <C> name='참고사항'         ID='REMARKS'            width=100 align=left editlimit=50 show=true </C>  
                                                    <C> name='사업SID'            ID='SAUP_SID'           width=100 align=left editlimit=50 show=true dec=0</C>  
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page2" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds2">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='동SID'             ID='DONG_SID'           width=100 align=left editlimit=50 show=true dec=0 </C>
                                                <C> name='동코드'          ID='DONG_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='동이름'          ID='DONG_NM'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='영문명'          ID='DONG_ENG_NM'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='단축명'          ID='DONG_SHORT_NM'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='업장SID'            ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0 </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page3" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds3">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='객실타입SID'              ID='ROOM_TYPE_SID'          width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='업장SID'            ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='객실등급코드'           ID='ROOM_GRADE_CD'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='배드타입'         ID='BED_TYPE_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='객실타입'         ID='ROOM_TYPE_CD'           width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='객실타입명'            ID='ROOM_TYPE_NM'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='평형'               ID='PYUNG'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='최소인원'         ID='STD_PERSONS'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='최대인원'         ID='MAX_PERSONS'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='화면표시순서'           ID='DISPLAY_SEQ'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                
                                                <C> name='사용여부'         ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page4" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds4">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='객실SID'            ID='ROOM_SID'           width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='객실번호'         ID='ROOM_NO'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='시작일자'         ID='BGN_DATE'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='종료일자'         ID='END_DATE'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='객실전망:R'           ID='ROOM_VIEW_CD'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='객실층'          ID='FLOORS'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='사용여부:S'           ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='사업장SID'           ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='동SID'             ID='DONG_SID'           width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='객실타입SID'      ID='ROOM_TYPE_SID'          width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='참고사항'         ID='REMARKS'            width=100 align=left editlimit=50 show=true </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page5" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr5 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds5">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='상품SID'            ID='GOODS_SID'          width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='상품코드'         ID='GOODS_CD'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='상품명'          ID='GOODS_NM'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='영문상품명'            ID='ENG_NM'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='기본경로'         ID='COURSE'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='박수'               ID='NIGHTS'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='일수'               ID='DAYS'           width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='사용여부'         ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page6" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr6 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds6">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='대분류'          ID='HEAD'           width=100 align=left editlimit=50 show=true </C>
                                                <C> name='소분류'          ID='DETAIL'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='소분류명'         ID='DETAIL_NM'      width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성1'              ID='ITEM1'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성2'              ID='ITEM2'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성3'              ID='ITEM3'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성4'              ID='ITEM4'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성5'              ID='ITEM5'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성6'              ID='ITEM6'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성7'              ID='ITEM7'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성8'              ID='ITEM8'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성9'              ID='ITEM9'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성10'         ID='ITEM10'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성11'         ID='ITEM11'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성12'         ID='ITEM12'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성13'         ID='ITEM13'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성14'         ID='ITEM14'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='속성15'         ID='ITEM15'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page7" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr7 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds7">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='매출처SID'           ID='CLIENT_SID'         width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='회계거래처'            ID='VEND_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='매출처코드'            ID='CLIENT_CD'      width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='매출처명'         ID='CLIENT_NM'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='매출처구분'            ID='CLIENT_GU'          width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='대리점구분'            ID='AGEN_GU'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='직판여부'         ID='DIR_YN'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='지역코드'         ID='AREA_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='영업담당자코드'      ID='SAL_DAM_SID'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='매출처담당자'       ID='CLIENT_DAM_NM'          width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='전화번호'         ID='TEL_NO'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='휴대전화'         ID='MOBILE_NO'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='FAX번호'            ID='FAX_NO'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='이메일'          ID='E_MAIL'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='우편번호'         ID='ZIP_CD'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='주소1'          ID='ADDRESS1'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='주소2'          ID='ADDRESS2'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='수수료율'         ID='COMMI_RATE'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='계약상태'         ID='CUNT_STATUS'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='은행코드'         ID='BANCOD'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='은행계좌번호'           ID='BANK_ACC_NO'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='예금주'          ID='BANK_ACCT_NM'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='사용여부'         ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page8" style="position:absolute; width:845; height:300">
										<%=HDConstant.COMMENT_START%>
										<object id=gr8 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
		                        			<param name="DataID"		VALUE="ds8">
		                        			<param name="BorderStyle"   VALUE="0">
		                        			<param name=ColSizing       value="true">
		                        			<param name="editable"      value="false">
		                        			<param name=UsingOneClick  	value="1">
		                                    <Param Name="AllShowEdit"   value="True">
		                                    <param name="SortView"      value="Right">
											<param name=SuppressOption value=1>
											<param name="Format" 			value="
							           					<C> name='메뉴SID'			ID='MENU_SID'	width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='메뉴코드'			ID='MENU_CD'	 width=100 align=left editlimit=13 show=true</C>
														<C> name='메뉴구분코드'		ID='MENU_GUBUN_CD'	width=100  align=left editlimit=2 show=true</C>
														<C> name='메뉴구분1'			ID='MENU_ITEM1'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='메뉴구분2'			ID='MENU_ITEM2'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='메뉴구분3'			ID='MENU_ITEM3'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='메뉴구분4'			ID='MENU_ITEM4'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='메뉴구분5'			ID='MENU_ITEM5'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='적용시작일자'		ID='BGN_DATE'	 width=100 align=left editlimit=8 show=true</C>
														<C> name='적용종료일자'		ID='END_DATE'	 width=100 align=left editlimit=8 show=true</C>
														<C> name='시작인원'			ID='BGN_PERSONS'	width=100  align=left editlimit=4 show=true dec=0</C>
														<C> name='종료인원'			ID='END_PERSONS'	width=100  align=left editlimit=4 show=true dec=0</C>
														<C> name='메뉴명'			ID='MENU_NM'	 width=100 align=left editlimit=50 show=true</C>
														<C> name='메뉴영문명'			ID='MENU_ENG_NM'	width=100  align=left editlimit=30 show=true</C>
														<C> name='메뉴단축명'			ID='MENU_SHORT_NM'	width=100  align=left editlimit=12 show=true</C>
														<C> name='과세여부'			ID='TAX_YN'	 width=100 align=left editlimit=1 show=true</C>
														<C> name='세금계산방법'		ID='TAX_CALCU_CD'	width=100  align=left editlimit=1 show=true</C>
															<C> name='단가'				ID='UNIT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='공급가'			ID='NET_AMT'	width=100  align=left editlimit=12 show=true dec=0</C>
														<C> name='부가세'			ID='VAT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='특소세'			ID='EXCISE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='교육세'			ID='EDU_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='농특세'			ID='VILLAGE_AMT' width=100 	 align=left editlimit=12 show=true dec=0</C>
														<C> name='체육기금'			ID='SPORTS_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='관광기금'			ID='TOUR_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='협회비'			ID='ASSOC_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='봉사료'			ID='TIP_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='통화코드(RV022)'	ID='CURRENCY_CD'	width=100  align=left editlimit=3 show=true</C>
														<C> name='옵션상품여부'		ID='OPTION_YN'	 width=100 align=left editlimit=1 show=true</C>
														<C> name='옵션보시(RV023)'	ID='OPTION_VIEW_CD'width=100 	 align=left editlimit=1 show=true</C>
														<C> name='화면표시순서'		ID='DISPLAY_SEQ'	width=100  align=left editlimit=4 show=true dec=0</C>
														<C> name='사용여부'			ID='USE_YN'	 width=100 align=left editlimit=1 show=true</C>
														<C> name='사업SID'			ID='SAUP_SID'	width=100  align=left editlimit=12 show=true dec=0</C>
														<C> name='업장SID'			ID='UPJANG_SID' width=100 	 align=left editlimit=12 show=true dec=0</C>
														<C> name='참고사항'			ID='REMARKS'	width=100  align=left editlimit=100 show=true</C>
	
											">
										</object>
										<%=HDConstant.COMMENT_END%>	
										</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <%=HDConstant.COMMENT_START%>   
    <object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
    <param name="DataId" value="tempExcelDs">
    <param name=BindInfo    value="
        <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
        <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
    ">
    </object>
    <%=HDConstant.COMMENT_END%>     
<!--------------------------------- 코딩 부분 끝 -------------------------------->   
    <iframe id="LowerFrame" 
            name="work" 
            style="visibility:hidden; position:absolute; left:280px; top:220px;" 
            Frameborder="0" src="/HDASan/Sales/common/img/flash/loading.swf" 
            width="320px" 
            height="42px">
    </iframe>   
<!---------------------------------- BODY End --------------------------------> 
    </body>
</html>