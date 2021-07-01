<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명         : 상품권
 * 프로그램ID   : AC020H
 * J  S  P      : AC020H
 * 서 블 릿        : AC020H
 * 작 성 자        : 이병욱
 * 작 성 일        : 2006-08-14
 * 기능정의     : 
 * 수정내용     : 
 * 수 정 자        : 
 * 최종수정일자 :  
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    
     String sSaup_sid = HDUtil.nullCheckStr(request.getParameter("sSaup_sid"));
     String sGoods_sid = HDUtil.nullCheckStr(request.getParameter("sGoods_sid"));
     String sClient_sid = HDUtil.nullCheckStr(request.getParameter("sClient_sid"));
     String sSDate = HDUtil.nullCheckStr(request.getParameter("sSDate"));
     String sUpjang_sid = HDUtil.nullCheckStr(request.getParameter("sUpjang_sid"));
	 String sCustGu = HDUtil.nullCheckStr(request.getParameter("sCustGu"));	    
     String v_status = HDUtil.nullCheckStr(request.getParameter("v_status"));
		           
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
            cfStyleGrid(getObjectFirst("gr1"), "comn");
	              var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	              		+",dsType=4"
				          + ",sSaup_sid=<%=sSaup_sid%>"
				          + ",sGoods_sid=<%=sGoods_sid%>"
			             + ",sClient_sid=<%=sClient_sid%>"
				          + ",sSDate=<%=sSDate%>"
				          + ",sUpjang_sid=<%=sUpjang_sid%>"
				          + ",sCustGu=<%=sCustGu%>"
				          + ",v_status=<%=v_status%>";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac020H",
				    "JSP(O:DS060=ds1)",
				    param);
				   
				tr_post(tr1);
            }
            
            
            function fnClose() {
            	window.close();
            }
            
            	/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:상품권; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("상품권","상품권.xls", 8);
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
            fnShowLoading(410,180); 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
              fnHideLoading(); 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            fnHideLoading();
        </script>



<%=HDConstant.COMMENT_START%>       
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
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
    
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	
		
        <table width=98% align=center>
            <tr height=30>
                <td width=50% align=left><img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <span id=v_title>상품권</span></td>
                <td width=50% align=right><img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">
                　<img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" align=absmiddle onClick="fnClose()">
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:0px">
            <tr>
                <td>
<%
/*---------------------------------------------------------------------------->
    Object ID   : 그리드 , gr1
    Data ID     : ds1
-----------------------------------------------------------------------------*/
%>
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='800px' height='278px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name="SuppressOption"    value="1">
						<param name=ViewSummary     value=1>
                        <param name="Format"        value="
                            <c> Name='출발일자'     ID='DEPART_DATE'    Width=80   align=center mask='XXXX-XX-XX' suppress=1 SumText='합계'</c>
                            <c> Name='상품'     	ID='GOODS_NM'      	Width=100  align=center dec=0 suppress=2 </c>
                            <c> Name='대리점'     	ID='CLIENT_NM'     	Width=100  align=left dec=0 suppress=3 </c>
                            <c> Name='결제관리번호'	ID='PAY_MANAGE_NO' 	Width=80   align=center suppress=4 </c>
                            <c> Name='회수일자'    	ID='PAY_DATE'     	Width=80   align=center suppress=4 </c>
                            <c> Name='결제액'    	ID='PAY_AMT_TOT'    Width=80  align=right  dec=0  SumText=@sum SumTextAlign=right</c>
                            <c> Name='인원'	    	ID='PPL'	     	Width=40   align=right  dec=0  SumText=@sum SumTextAlign=right</c>
                            <c> Name='매출액'    	ID='TOUR_AMT'     	Width=80  align=right  dec=0  SumText=@sum SumTextAlign=right</c>
                            <c> Name='입금액'     	ID='PAY_AMT'     	Width=80  align=right  dec=0  SumText=@sum SumTextAlign=right</c>
                            <c> Name='정산액'     	ID='SALE_AMT' 		Width=80  align=right 	dec=0  SumText=@sum SumTextAlign=right</c>

                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%> 
                </td>
            </tr>
            <tr>
                <td>※ 결제액 = 해당 결제관리번호의 총 결제액<BR>
                　 매출액 = 해당 결제관리번호 고객들의 판매가의 합<BR>
                　 입금액 = 해당 결제관리번호 고객들의 입금액의 합<BR>
                　 정산액 = 해당 결제관리번호 고객들의 정산액의 합
                </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>