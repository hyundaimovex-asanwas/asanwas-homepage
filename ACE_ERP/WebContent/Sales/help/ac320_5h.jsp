<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�         : �ܻ����
 * ���α׷�ID   : AC320H
 * J  S  P      : AC320H
 * �� �� ��        : AC320H
 * �� �� ��        : ����ǥ
 * �� �� ��        : 2006-09-14
 * �������     : 
 * ��������     : 
 * �� �� ��        : 
 * ������������ :  
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    
     int sSaup_sid = HDUtil.nullCheckNum(request.getParameter("sSaup_sid"));
     int sGoods_sid = HDUtil.nullCheckNum(request.getParameter("sGoods_sid"));
     int sClient_sid = HDUtil.nullCheckNum(request.getParameter("sClient_sid"));
     String sSDate = HDUtil.nullCheckStr(request.getParameter("sSDate"));
     String sEDate = HDUtil.nullCheckStr(request.getParameter("sEDate"));
			          
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
            function fnOnLoad() {
            cfStyleGrid(getObjectFirst("gr1"), "comn");
	              var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	              		+",dsType=5"
				          + ",sSaup_sid=<%=sSaup_sid%>"
				          + ",sGoods_sid=<%=sGoods_sid%>"
			             + ",sClient_sid=<%=sClient_sid%>"
				          + ",sSDate=<%=sSDate%>"
				           + ",sEDate=<%=sEDate%>";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac320H",
				    "JSP(O:DSMI=ds1)",
				    param);
				   
				tr_post(tr1);
            }
            
            
            function fnClose() {
            	window.close();
            }
            
            	/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:�ܻ���� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("�ܻ���� ��Ȳ","�ܻ���� ��Ȳ.xls", 8);
		}
        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
              document.all.LowerFrame.style.visibility="hidden"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            document.all.LowerFrame.style.visibility="hidden";
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
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=absmiddle> <span id=v_title>�ܻ����</span></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="720px">
                        <tr>
                            <td align=right>
                            	<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
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
    Object ID   : �׸��� , gr1
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
                        	<C>	Name=''				ID='{Currow}'				width=30 	</c>
                            <c> Name='�������'      	ID='DEPART_TIME'    		Width=70  align=center  suppress=1 mask='XXXX-XX-XX'  SumText='�հ�' </c>
                            <c> Name='��ǰ'     		ID='GOODS_NM'      			Width=80  align=center  suppress=2</c>
                            <c> Name='�븮��'     	ID='CLIENT_NM'      		Width=80  align=left  suppress=3</c>
                            <c> Name='��û����ȣ'     ID='ACCEPT_NO'      		Width=80  align=left</c>
                            <c> Name='����'     		ID='CUST_NM'      			Width=50  align=left</c>
                            <c> Name='�ֹι�ȣ'     	ID='MANAGE_NO'      		Width=90  align=center mask='XXXXXX-XXXXXXX'</c>
                            <c> Name='������'     	ID='ROOM_TYPE_CD'      		Width=60   align=center  suppress=4</c>
                            <c> Name='�ǸŰ�'     	ID='TOUR_AMT'     			Width=80  align=right SumText=@sum SumTextAlign=right	dec=0</c>
                            <c> Name='�Աݾ�'     	ID='PAY_AMT'   	 			Width=80  align=right SumText=@sum SumTextAlign=right dec=0</c>
                            <c> Name='�������'     	ID='A_AMT'      			Width=80  align=right SumText=@sum SumTextAlign=right dec=0 </c>
                            <c> Name='������ü'  		ID='B_AMT'   				Width=80  align=right SumText=@sum SumTextAlign=right dec=0 </c>
                            <c> Name='�ſ�ī��'     	ID='C_AMT'     				Width=80  align=right SumText=@sum SumTextAlign=right dec=0 </c>
                            <c> Name='��ǰ��'     	ID='D_AMT'      			Width=80  align=right SumText=@sum SumTextAlign=right dec=0 </c>
                            <c> Name='�ܻ����'     	ID='CH_AMT'     			Width=80  align=right SumText=@sum SumTextAlign=right dec=0 </c>
                            <c> Name='��ġ��'     	ID='EMPNM'     				Width=50  align=left</c>
                            
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
                <!--  ���¹� �÷���  -->
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