<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	 : 현장명 조회 헬프
 * 프로그램ID 	 : PMS/Help/pu010h_01.jsp
 * J  S  P		 : pu010h_01.jsp
 * 서 블 릿		 : help/Pu010H_01
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2011-12-26
 * 기능정의		 : 현장명(계약건) 검색 / 선택
 * [ 수정일자 ][수정자] 내용
 * [2011-12-26][박경국] 신규
 *****************************************************************************/
%>
<%@ page import="pms.common.HDConstant"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <title></title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                fnSelect();
            }
            
            function fnSelect() {
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H_01?proType=S&dsType=1&v_keyword=" + keyword.value ;
                ds1.Reset();
            }
            
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "PU_SITE_CD") + ";" +
                                     ds1.namevalue(row, "SITE_NM") + ";" +
                                     ds1.namevalue(row, "EMPNO") + ";" +
									 ds1.namevalue(row, "EMPNM") + ";" +                                     
                                     ds1.namevalue(row, "SITE_SID");
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
            ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";

        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
            ft_cnt1.innerText="Cnt : " + row;
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
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

	<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="false">
	</object>

    </head> 
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:319px;">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:120;height:15;left:5px;">현장명 조회</font>
                            </td>
                        </tr>
                        <tr>
                            <td class="text" width="100px" height="30" style="border:1 solid #708090">현장명</td>
                            <td width="110px" style="border:1 solid #708090;border-left-width:0px">
                                <input type="text" name="keyword" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
                        <tr>
                            <td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="코드/명을 검색합니다" style="position:relative;left:8px;top:0px;cursor:pointer;" onclick="fnSelect();">
                                <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnAdd()">                            
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnClose()">                          
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
            <tr>
                <td>
					<%
					/*---------------------------------------------------------------------------->
					    Object ID   : 그리드 , gr1
					    Data ID     : ds1
					-----------------------------------------------------------------------------*/
					%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='579px' height='248px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name="Format"        value="
                            <c> Name='현장코드'   ID='PU_SITE_CD'     	Width=100  align=center show=TRUE</c>
                            <c> Name='현 장 명'   ID='SITE_NM'		Width=219</c>
                            <c> Name='담당자사번' ID='EMPNO'     	Width=90  align=center show=TRUE</c>                                                        
                            <c> Name='담당자명'   ID='EMPNM'     	Width=90  align=center show=TRUE</c>                                                                                    
                            <c> Name='현장번호'   ID='SITE_SID'		Width=60   align=center</c>                            
                            
                        ">
                    </object>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset id=ft_div1 style="width:580;height:15px;border:0 solid #708090;text-align:left;">
                    &nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
                    </fieldset><BR>
                    * 로그인 한 담당자가 설정된 현장만 조회됩니다.
                </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>