<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 계좌번호
 * 프로그램ID   : AC003H (코드는 대문자)
 * J  S  P      : ac003h (jsp파일명은 소문자로 한다 )
 * 서 블 릿        : Ac003H
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-17
 * 기능정의     : 계좌번호 조회 
 * 수정내용     : 2006-08-17 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * 수 정 자        : 김영민
 * 최종수정일자 :  
 * TODO         :
 * TODO         :
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>계좌번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
        
        // 페이지 로딩
        function fnOnLoad(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            fnSelect();
        }

        // 메인 조회
        function fnSelect() {
            ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac003H?proType=S";
            ds1.Reset();
        }
        
        // 사업장을 조회 
        function fnAdd() {
            var row = ds1.rowposition;
            if(row==0){
                return;
            }
            if(ds1.CountRow==0) {
                alert("먼저 조회를 하시길 바랍니다.");
                return false;
            }
            window.returnValue  = ds1.NameValue(row, "BNKNUM")+";"
                                + ds1.NameValue(row, "BANCOD")+";"
                                + ds1.NameValue(row, "BNKNAM")+";"
                                + ds1.NameValue(row, "ACCTNONM")+";";
            fnClose();
        }
        
        function fnClose() {
            window.close();
        }

        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            document.all.LowerFrame.style.visibility="hidden";
            if(row==0){
                alert("계좌번호가 없습니다.");
                return;
            }
        </script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  조회중 에러 
%>      
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            document.all.LowerFrame.style.visibility="hidden";
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  그리드 더블클릭 이벤트 발생
//
%>          
        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnAdd();
        </script>
        <script language=JavaScript for=gr1 event=onKeyPress(keycode)>
            
            if (keycode == 13) {
                fnAdd();
            }
        </script>

    <%=HDConstant.COMMENT_START%>
    <object id="ds1" classid=<%=HDConstant.CT_DATASET_CLSID%>>
        <param name="SyncLoad" value="false">
    </object>
    <%=HDConstant.COMMENT_END%>

    </head> 
    
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td height=25>
                    <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center>계좌번호조회
                </td>
            </tr>
            <tr>
                <td valign=bottom align=right>
                    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="객실타입/명을 검색합니다" style="cursor:hand;" onclick="fnSelect();">
                    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">                            
                    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">&nbsp;
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
            <tr>
                <td>
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=479px; height:260px;border:1 solid #777777;">
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="AllShowEdit"   value="false"> <!-- Edit가능  -->
                        <param name="ColSizing"     value="true">
                        <param name="Editable"      value="false">
                        <param name="FillArea"      value="True">
                        <param name="SortView"      value="Right">
                        <param name="Format"        value="
                            <c> Name='계좌번호'      ID='BNKNUM'       Edit=None Width=130 align=center</c>
                            <c> Name='은행코드'      ID='BANCOD'       Edit=None Width=100 align=center</c>
                            <c> Name='은행지점'      ID='BNKNAM'       Edit=None Width=130 align=center</c>
                            <c> Name='계좌명'        ID='ACCTNONM'     Edit=None Width=100 align=center</c>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                </td>
            </tr>
            <tr>
                <td>
                <!--  상태바 플레쉬  -->
            <iframe id="LowerFrame" 
                name="work" 
                style="visibility:hidden; position:absolute; left:100px; top:150px;" 
                Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
                width="320px" 
                height="42px">
            </iframe>   
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>