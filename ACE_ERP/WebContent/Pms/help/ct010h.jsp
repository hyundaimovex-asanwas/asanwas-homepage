<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	 : 현장명 조회 헬프
 * 프로그램ID 	 : PMS/Help/ct010h.jsp
 * J  S  P		 : ct010h.jsp
 * 서 블 릿		 : help/Ct010H
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2011-07-01
 * 기능정의		 : 현장명(계약건) 검색 / 선택
 * [ 수정일자 ][수정자] 내용
 * [2011-07-01][심동현] 신규
 * [2014-06-13][심동현] 단축명도 같이 표시
 * [2014-10-30][심동현] 사용유무도 같이 표시
 
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
    <title>공사>현장명 조회</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                ds_use_yn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
                ds_use_yn.Reset();	//사용유무
            }
            
            function fnSelect() {
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Ct010H?proType=S&dsType=1&v_keyword="
                		+ keyword.value
                		+ "&use_yn=" + lc_use_yn.ValueOfIndex("detail",lc_use_yn.index);
                ds1.Reset();
            }
            
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "SITE_CD") + ";" +
                                     ds1.namevalue(row, "SITE_NM") + ";" +
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
	<object id=ds_use_yn classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
	    <param name="SyncLoad"  value="false">
	</object>



    </head> 
    
<!--  BODY START -->
	<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table cellpadding="0" cellspacing="0" border="0" width="100%"">
            <tr>
			   <td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="코드/명을 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">
			       <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">                            
			       <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
			   </td>
			</tr>
			<tr>
				<td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:319px;">
                        <tr>
                            <td class="text" width="100px" height="30" style="border:1 solid #708090">현장명</td>
                            <td width="110px" style="border:1 solid #708090;border-left-width:0px">
                                <input type="text" name="keyword" class="textbox" style="position:relative;left:5px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
                            </td>
                            <td class="text" width="50px" height="30" style="border:1 solid #708090;border-left-width:0px">사용</td>
                            <td width="60px" style="border:1 solid #708090;border-left-width:0px">&nbsp;
	                            <object id=lc_use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=60 width=50 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_use_yn>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^50">
	                            </object>
	                            
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
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='479px' height='248px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name="Format"        value="
                            <c> Name='현장코드'   ID='SITE_CD'     	Width=100  align=center show=false</c>
                            <c> Name='현장번호'   ID='SITE_SID'		Width=60   align=center</c>
                            <c> Name='단축명'	  ID='SITE_NM_S'	Width=80   align=center</c>
                            <c> Name='현 장 명'   ID='SITE_NM'		Width=319</c>
                        ">
                    </object>
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
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>