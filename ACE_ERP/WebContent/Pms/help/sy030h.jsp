<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	 : 협력사 조회 헬프
 * 프로그램ID 	 : PMS/Help/sy030h.jsp
 * J  S  P		 : sy030h.jsp
 * 서 블 릿		 : help/Sy030H
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2011-07-01
 * 기능정의		 : 협력사 검색 / 선택
 * [ 수정일자 ][수정자] 내용
 * [2011-07-01][심동현] 신규
 * [2013-11-25][심동현] 시스템 이전 : 신규
 *						기존 협력회사 테이블 pms.tsy030 -->> pms.tbc030 복제.. 
 *						java 쪽에서도 tbc030 을 조회하도록 쿼리를 수정
 * [2014-02-04][심동현] 협력사 테이블 TBC030 → TBC030 으로 변경
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
            }
            
            function fnSelect() {
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy030H?proType=S&dsType=1&v_keyword=" + keyword.value ;
                ds1.Reset();
            }
            
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "BP_CD") + ";" +
                                     ds1.namevalue(row, "BP_NM") + ";" +
                                     ds1.namevalue(row, "BP_SID");
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
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
            ft_cnt1.innerText="Cnt : " + row;
            document.all.LowerFrame.style.visibility="hidden";
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
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
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>


    </head> 
    
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:120;height:15;left:5px;">협력사 조회</font>
                            </td>
                        </tr>
                        <tr>
                            <td class="text" width="100px" height="30" style="border:1 solid #708090">협력사명</td>
                            <td width="110px" style="border:1 solid #708090;border-left-width:0px">
                                <input type="text" name="keyword" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
                        <tr>
                            <td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="코드/명을 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
                                <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
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
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='479px' height='248px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name="Format"        value="
                            <F> name='순'				ID={CurRow}	width=40	align=right	</F> 
                            <c> Name='협력사 코드'    	ID='BP_CD'	Width=100	align=center </c>
                            <c> Name='협력사 명'      	ID='BP_NM'	Width=300</c>
                            
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%> 
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
                    &nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                <!--  상태바 플레쉬  -->
            <iframe id="LowerFrame" 
                name="work" 
                style="visibility:hidden; position:absolute; left:100px; top:150px;" 
                Frameborder="0" src="<%=dirPath%>/Purch/common/include/loadingSales.jsp" 
                width="320px" 
                height="42px">
            </iframe>
	
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>