<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 영업담당정보변경 
 * 프로그램ID   : MY310I (코드는 대문자)
 * J  S  P      : my310i (jsp파일명은 소문자로 한다 )
 * 서 블 릿        : My310I
 * 작 성 자        : 안준성
 * 작 성 일        : 2006-07-15
 * 기능정의     : 영업담당정보변경
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
    
    //사원정보
    HDCookieManager cookie = new HDCookieManager(request, response);
    String c_uid = cookie.getCookieValue("vusrid",request);
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
        
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

                fnInit();
                fnSelect();
            }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  선조회
// Parameter    : 
%>
            function fnInit(){ 
                ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=1&proType=INIT";
                ds2.Reset();            
                ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=2&proType=INIT";
                ds3.Reset();                            
                ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=1&proType=S&s_Head=SY012&s_Detail=&s_DetailNm=";
                ds4.Reset();                                            
                ds5.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=1&proType=S&s_Head=SY006&s_Detail=&s_DetailNm=";
                ds5.Reset();                                                            
            }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  [조회]
%>
            function fnSelect() {
                if (ds1.IsUpdated ) {
                    alert("수정중인 행이 있습니다!");
                } else {
                    ds1.ClearAll();
                    //ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=1&proType=S&sSaldamCd=4060008&sSaldamNm=최선아";
                    ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=1&proType=S&sSaldamCd=<%=c_uid%>";
                    ds1.Reset();
                }
            }
                                    
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  [적용 ]
%>

        function fnApply() {
            if(ds1.IsUpdated) {
                for( i=1;i<=ds1.CountRow;i++ ) {                
                    if ( ds1.namevalue(i,"sal_dam_nm") == '' ) {
                        alert("담당자명은 필수 입력사항입니다.");
                        return;
                    }
                    if ( ds1.namevalue(i,"sal_dam_cd") == '' ) {
                        alert("담당자코드는 필수 입력사항입니다.");
                        return;
                    }                       
                }
                tr1.KeyValue = "Sy410I(I:INPUT_DATA=ds1)";
                tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?proType=A&dsNum=1";
                tr1.post();
            }
        }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
        function fnCancel(){
            if(ds1.IsUpdated ) {
                ds1.undoall();
            }
            window.status="데이터 변경이 취소되었습니다.";
            return;
        }
                        
<%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
///////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
// Description :  담당업무 팝업                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
        function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

                var arrParam    = new Array();
                var arrResult   = new Array();
                var strURL; 
                var strPos;
                strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
                strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
                arrParam[0] = ds4.namevalue(1,"head");
                arrParam[1] = ds4.namevalue(1,"detail_nm"); //공통코드의 마스터값

                arrResult = showModalDialog(strURL,arrParam,strPos);    

                if (arrResult != null) {
                    arrParam = arrResult.split(";");
                    business_gu.value = arrParam[1];
                    business_gunm.value = arrParam[2];
                } else {
                    business_gu.value = "";
                    business_gunm.value = "";               
                }
        }           
        
<%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
///////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
// Description :  근무지역 팝업                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
        function fnPopup2() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

                var arrParam    = new Array();
                var arrResult   = new Array();
                var strURL; 
                var strPos;
                strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
                strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
                arrParam[0] = ds5.namevalue(1,"head");
                arrParam[1] = ds5.namevalue(1,"detail_nm"); //공통코드의 마스터값
                arrResult = showModalDialog(strURL,arrParam,strPos);    
            
                if (arrResult != null) {
                    arrParam = arrResult.split(";");
                    area_cd.value = arrParam[1];
                    area_cdnm.value = arrParam[2];
                } else {
                    area_cd.value = "";
                    area_cdnm.value = "";               
                }
        }           
        
<%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
///////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
// Description :  사원정보 팝업                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
        function fnPopup3() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

                var arrParam    = new Array();
                var arrResult   = new Array();
                var strURL; 
                var strPos;
                strURL = "<%=dirPath%>/Sales/help/sy020h.jsp";
                strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
                if ( empno.value != '' ) 
                    arrParam[0] = empno.value;
                arrResult = showModalDialog(strURL,arrParam,strPos);    
            
                if (arrResult != null) {
                    arrParam = arrResult.split(";");
                    empno.value = arrParam[0];
                    empnmk.value = arrParam[1];
                    deptcd.value = arrParam[2];
                    deptnm.value = arrParam[3];                 
                } else {
                    empno.value = "";
                    empnmk.value = "";
                    deptcd.value = "";
                    deptnm.value = "";                                  
                }
        }                   

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  우편번호 팝업
%>
            function fnZipCodePopup(){ 
                var arrParam    = new Array();
                var arrResult   = new Array();
                var strURL; 
                var strPos;
                
                strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
                strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
                arrResult = showModalDialog(strURL,arrParam,strPos);    
            
                if (arrResult != null) {
                    arrParam = arrResult.split(";");
                    zip_cd.text = arrParam[0];
                    address1.value = arrParam[1];
                    
                } else {
                  zip_cd.text = "";
                  address1.value = "";
                }
            }
        </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>      
        <script language=JavaScript for= lc1 event=OnSelChange()>
            ds1.namevalue(ds1.RowPosition, "bithday_gu") = ds2.namevalue(ds2.rowposition, "detail");
        </script>       
        
        <script language=JavaScript for= lc2 event=OnSelChange()>
            ds1.namevalue(ds1.RowPosition, "use_yn") = ds3.namevalue(ds3.rowposition, "detail");        
        </script>               

<%
////////////////////////////////////////////////////////////////////////////////
//// 영업담당자 정보 조회
%>      
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
        <script language=JavaScript  for=ds2 event="OnLoadStarted()" >
            window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
                        
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            window.status="조회가 완료 되었습니다.";
            
            var index=lc1.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bithday_gu"));
            lc1.index=index;
            index=lc2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"use_yn"));
            lc2.index=index;            
            
            document.all.LowerFrame.style.visibility="hidden";
            if( row < 1){
                alert("검색된 데이타가 없습니다."); 
            }
        </script>
        <script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
            ds2.insertRow(1);
            ds2.namevalue(1,"detail_nm") = "";
            lc1.index = 0;          
        </script>
        
        <script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
            ds3.insertRow(1);
            ds3.namevalue(1,"detail_nm") = "";
            lc2.index = 0;          
        </script>       
        
        <script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
            window.status="조회가 완료 되었습니다.";

            document.all.LowerFrame.style.visibility="hidden";
            if( row < 1){
                alert("검색된 데이타가 없습니다."); 
            }
        </script>       
<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
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
   
                                            <table border="0" width="845px"  cellpadding="0" cellspacing="0">
                                                <tr height="35px">
                                                    <td align="left" >
                                                        <table width="845px" border="0"  cellspacing="0" cellpadding="0" >
                                                            <tr> 
                                                                <td align="right">
                                                                    <table border="0"  cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td align="right" height="30px">        
                                                                                <img src="<%=dirPath%>/Sales/images/save.gif"       style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
                                                                                <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>    
                                                    </td>                                           
                                                </tr>
                                                <tr>
                                                    <td width="845px">
                                                        <table  border="0" cellpadding="0" cellspacing="0">
                                                            <tr valign="top"">
                                                                <td align="left" valign="top" width="845px">
                                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td>
                                                                                <table border="0" cellpadding="0" cellspacing="0">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table width="845px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
                                                                                                <tr>
                                                                                                    <td  height="25px" align="center" class="text">담당자코드</td>
                                                                                                    <td  height="25px" bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input name="sal_dam_cd" id="sal_dam_cd" type="text" size="20" value="" maxlength="7" class="input01" readOnly>
                                                                                                    </td>
                                                                                                    <td  align="center" class="text">담당자명</td>
                                                                                                    <td  bgcolor="#FFFFFF">&nbsp;
                                                                                                        <input name="sal_dam_nm" id="sal_dam_nm" type="text" size="20" value="" maxlength="22" class="input01" readOnly>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="2">&nbsp;</td>
                                                                                                    <td align=center class="text">동명이인구분</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="name_gu" type="text" class="textbox" size="20" maxlength="22" onBlur="bytelength(this,this.value,22);">
                                                                                                    </td>                                                                                                   
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td align="center" class="text">회사전화</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="office_tel" type="text" class="textbox" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
                                                                                                    </td>
                                                                                                    <td align="center" class="text">자택전화</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="house_tel" type="text" class="textbox" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
                                                                                                    </td>                                                                                                   
                                                                                                </tr>                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">휴대전화</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="mobile_tel" type="text" class="textbox" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
                                                                                                    </td>
                                                                                                    <td align="center" class="text">기타전화</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="etc_tel" type="text" class="textbox" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
                                                                                                    </td>                                                                                                   
                                                                                                </tr>                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">팩스번호</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <input id="fax_no" type="text" class="textbox" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
                                                                                                    </td>
                                                                                                </tr>                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">담당업무</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="business_gu" type="text" class="input01"  style= "position:relative;left:-0px;top:2px;width:20px; height:20px;" maxlength="2" readOnly>
                                                                                                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="담당업무를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
                                                                                                        <input id="business_gunm" type="text" class="input01"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black;" maxlength="50" onBlur="bytelength(this,this.value,50);" readOnly>                                                                                        
                                                                                                    </td>
                                                                                                    <td align="center" class="text">근무지역</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="area_cd" type="text" class="input01"  style= "position:relative;left:-0px;top:2px;width:20px; height:20px;" maxlength="2" readOnly>
                                                                                                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="근무지역을 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2();">
                                                                                                        <input id="area_cdnm" type="text" class="input01"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" readOnly>
                                                                                                    </td>                                                                                                   
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                <tr>
                                                                                                    <td align="center" class="text">기본메일주소</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="b_email" type="text" class="textbox" size="20" value="" maxlength="30" onBlur="bytelength(this,this.value,30);">
                                                                                                    </td>
                                                                                                    <td align="center" class="text">msn메일주소</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="msn_email" type="text" class="textbox" size="20" value="" maxlength="30" onBlur="bytelength(this,this.value,30);">
                                                                                                    </td>                                                                                                   
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">네이트메일주소</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <input id="etc_email" type="text" class="textbox" size="20" value="" maxlength="30" onBlur="bytelength(this,this.value,30);">
                                                                                                    </td>
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">생년월일</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <%=HDConstant.COMMENT_START%>
                                                                                                        <object id=bithday classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>            
                                                                                                            <param name=Text        value="">
                                                                                                            <param name=Alignment   value=1>
                                                                                                            <param name=Format      value="0000-00-00">
                                                                                                            <param name=Cursor      value="iBeam">
                                                                                                            <param name=Border      value="0">      
                                                                                                            <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                                                                                            <param name=ReadOnly    value="true">
                                                                                                        </object>
                                                                                                        <%=HDConstant.COMMENT_END%>
                                                                                                    </td>
                                                                                                    <td align="center" class="text">음력 양력구분</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <%=HDConstant.COMMENT_START%>
                                                                                                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                                                                            <param name=ComboDataID     value=ds2>
                                                                                                            <param name=EditExprFormat  value="%;bithday_gu">
                                                                                                            <param name=ListExprFormat  value="detail_nm^0^100">
                                                                                                        </object>
                                                                                                        <%=HDConstant.COMMENT_END%>
                                                                                                    </td>                                                                                                   
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">우편번호</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <%=HDConstant.COMMENT_START%>
                                                                                                        <object id=zip_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>            
                                                                                                            <param name=Text        value="">
                                                                                                            <param name=Alignment   value=1>
                                                                                                            <param name=Format      value="000-000">
                                                                                                            <param name=Cursor      value="iBeam">
                                                                                                            <param name=Border      value="0">          
                                                                                                            <param name=InheritColor      value="true">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                            <param name=ReadOnly    value="false">
                                                                                                        </object>
                                                                                                        <%=HDConstant.COMMENT_END%>
                                                                                                        &nbsp;<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnZipCodePopup();">                                                                                                                                                                                                           
                                                                                                    </td>
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">주소1</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <input id=address1 type="text" class="textbox" size="30" value="" maxlength="60" onBlur="bytelength(this,this.value,60);" readOnly>
                                                                                                    </td>
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">주소2</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <input id="address2" type="text" class="textbox" size="50" value="" maxlength="60" onBlur="bytelength(this,this.value,60);">
                                                                                                    </td>
                                                                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                <tr>
                                                                                                    <td align="center" class="text">비고사항</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <input id="desc" type="text" class="textbox" size="60" value="" maxlength="60" onBlur="bytelength(this,this.value,60);">
                                                                                                    </td>
                                                                                                </tr>           
                                                                                                <tr>
                                                                                                    <td align="center" class="text">사원번호</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="empno" type="text" class="input01"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" readOnly>
                                                                                                        <input id="empnmk" type="text" class="input01"  style= "position:relative;left:-0px;top:2px;width:70px; height:20px;" maxlength="50" readOnly>                                                                                                                                                                                            
                                                                                                    </td>
                                                                                                    <td align="center" class="text">부서코드</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left">&nbsp;
                                                                                                        <input id="deptcd" type="text" class="input01"  size="4" value="" maxlength="4" readOnly>
                                                                                                        <input id="deptnm" type="text" class="input01"  size="20" value="" maxlength="50" readOnly>                                                                                                        
                                                                                                    </td>                                                                                                   
                                                                                                </tr>           
                                                                                                <tr>
                                                                                                    <td align="center" class="text">사용유무</td>
                                                                                                    <td bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
                                                                                                        <%=HDConstant.COMMENT_START%>
                                                                                                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                                                                            <param name=ComboDataID     value=ds3>
                                                                                                            <param name=EditExprFormat  value="%;bithday_gu">
                                                                                                            <param name=ListExprFormat  value="detail_nm^0^100">
                                                                                                            <para name=Enabe            value=false>
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
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>                                           
<!--------------------------------- 코딩 부분 끝 -------------------------------->       
<%
/*=============================================================================
            Bind 선언
=============================================================================*/
%>
    <%=HDConstant.COMMENT_START%>
    <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
        <param name="DataId" value="ds1">           
        <param name=BindInfo    value="                                                
            <C>Col=sal_dam_cd       Ctrl=sal_dam_cd         Param=value </C>
            <C>Col=sal_dam_nm       Ctrl=sal_dam_nm                 Param=value </C>     
            <C>Col=name_gu          Ctrl=name_gu                Param=value </C>     
            <C>Col=office_tel           Ctrl=office_tel                 Param=value </C>     
            <C>Col=house_tel            Ctrl=house_tel          Param=value </C>     
            <C>Col=mobile_tel           Ctrl=mobile_tel                 Param=value </C>     
            <C>Col=etc_tel                  Ctrl=etc_tel                Param=value </C>     
            <C>Col=fax_no                   Ctrl=fax_no             Param=value </C>     
            <C>Col=business_gu      Ctrl=business_gu            Param=value </C>     
            <C>Col=business_gunm    Ctrl=business_gunm          Param=value </C>            
            <C>Col=area_cd              Ctrl=area_cd            Param=value </C>     
            <C>Col=area_cdnm        Ctrl=area_cdnm              Param=value </C>            
            <C>Col=b_email              Ctrl=b_email                Param=value </C>     
            <C>Col=msn_email        Ctrl=msn_email                  Param=value </C>
            <C>Col=etc_email            Ctrl=etc_email          Param=value </C>
            <C>Col=bithday                  Ctrl=bithday        Param=text </C>
            <C>Col=bithday_gu           Ctrl=bithday_gu                 Param=value </C>     
            <C>Col=zip_cd                   Ctrl=zip_cd             Param=text </C>     
            <C>Col=address1             Ctrl=address1           Param=value </C>     
            <C>Col=address2             Ctrl=address2           Param=value </C>     
            <C>Col=desc                     Ctrl=desc               Param=value </C>     
            <C>Col=empno                Ctrl=empno              Param=value </C>     
            <C>Col=empnmk               Ctrl=empnmk                 Param=value </C>            
            <C>Col=deptcd               Ctrl=deptcd                 Param=value </C>
            <C>Col=deptnm               Ctrl=deptnm                 Param=value </C>"       
        >
    </object>
    <%=HDConstant.COMMENT_END%>

<input type="hidden" name="row" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

