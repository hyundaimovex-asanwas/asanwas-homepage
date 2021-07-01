<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명         : 환불/ 환입
 * 프로그램ID   : AC020H
 * J  S  P      : AC020H
 * 서 블 릿        : AC020H
 * 작 성 자        : 정영식
 * 작 성 일        : 2008-03-27
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
	              		+",dsType=2"
				          + ",sSaup_sid=<%=sSaup_sid%>"
				          + ",sGoods_sid=<%=sGoods_sid%>"
			             + ",sClient_sid=<%=sClient_sid%>"
				          + ",sSDate=<%=sSDate%>"
				          + ",sUpjang_sid=<%=sUpjang_sid%>"
				           + ",sCustGu=<%=sCustGu%>" 
						+ ",v_status=<%=v_status%>";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac020H",
				    "JSP(O:DS34=ds1)",
				    param);
				    
				   // prompt('',param);
				   
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:환불환입; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("환불환입","환불환입.xls", 8);
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
            if(row==0){
                alert("<%=HDConstant.S_MSG_NO_DATA%>");
                window.close();
            }
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
                <td width=50% align=left><img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <span id=v_title>환불/환입</span></td>
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
                        <param name=Format        value="
                            <fc> Name='출발일자'    ID='DEPART_DATE'  Width=70  align=center  suppress=1  SumText='합계' mask ='XXXX-XX-XX' </fc>
                            <fc> Name='상품'          ID='GOODS_NM'       Width=90  align=left  suppress=2  </fc>
                            <fc> Name='대리점'       ID='CLIENT_NM'       Width=90  align=left  suppress=3  </fc>
                            <fc> Name='영업장'       ID='UPJANG_NM'      Width=90  align=left  suppress=4 </fc>
                            <fc> Name='이름'          ID='CUST_NM'         Width=50  align=center  suppress=5  </fc>
                            <fc> Name='입금일자'    ID='PAY_DATE'        Width=70  align=center  mask ='XXXX-XX-XX'</fc>
                            <fc> Name='입금구분'    ID='PAY_NM'           Width=70  align=center </fc>
                            <c> Name='판매가'     	ID='TOUR_AMT'        Width=70  align=right  decao=0 </c>
                            <c> Name='입금액'    	ID='PAY_AMT'       	Width=70  align=right   SumText=@sum SumTextAlign=right  decao=0</c>
                            <c> Name='정산액'       ID='SALE_AMT'    	Width=70  align=right  SumText=@sum SumTextAlign=right  decao=0</c>
                            <c> Name='외상매출'  	ID='CREDIT_AMT'     Width=70  align=right   SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='환불액'     	ID='refund_amt'      	Width=70  align=right  SumText=@sum SumTextAlign=right  decao=0</c>
                     	    <c> Name='환입액'       ID='fund_amt'       	width=70	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='가상계좌'    ID='a_amt'  		        width=70 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='보증금' 	  	ID='g_amt'  		        width=70 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='계좌이체'   	ID='b_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0 show=false</c>
                            <c> Name='신용카드'   	ID='c_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='온라인카드'   	ID='h_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>                     
                            <c> Name='상품권'   		ID='d_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='무통장입금'     ID='e_amt'        width=70    align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='기타대체'        ID='f_amt'         width=70     align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
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

        </table>
    </body>
    <!-- BODY END -->
</html>