<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�         : ȯ��/ ȯ��
 * ���α׷�ID   : AC020H
 * J  S  P      : AC020H
 * �� �� ��        : AC020H
 * �� �� ��        : ������
 * �� �� ��        : 2008-03-27
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
     *                            ����� ���� Java Script                       *
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
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:ȯ��ȯ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("ȯ��ȯ��","ȯ��ȯ��.xls", 8);
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
            fnShowLoading(410,180); 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
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
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
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
	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	
		
        <table width=98% align=center>
            <tr height=30>
                <td width=50% align=left><img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <span id=v_title>ȯ��/ȯ��</span></td>
                <td width=50% align=right><img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">
                ��<img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" align=absmiddle onClick="fnClose()">
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:0px">
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
                        <param name=Format        value="
                            <fc> Name='�������'    ID='DEPART_DATE'  Width=70  align=center  suppress=1  SumText='�հ�' mask ='XXXX-XX-XX' </fc>
                            <fc> Name='��ǰ'          ID='GOODS_NM'       Width=90  align=left  suppress=2  </fc>
                            <fc> Name='�븮��'       ID='CLIENT_NM'       Width=90  align=left  suppress=3  </fc>
                            <fc> Name='������'       ID='UPJANG_NM'      Width=90  align=left  suppress=4 </fc>
                            <fc> Name='�̸�'          ID='CUST_NM'         Width=50  align=center  suppress=5  </fc>
                            <fc> Name='�Ա�����'    ID='PAY_DATE'        Width=70  align=center  mask ='XXXX-XX-XX'</fc>
                            <fc> Name='�Աݱ���'    ID='PAY_NM'           Width=70  align=center </fc>
                            <c> Name='�ǸŰ�'     	ID='TOUR_AMT'        Width=70  align=right  decao=0 </c>
                            <c> Name='�Աݾ�'    	ID='PAY_AMT'       	Width=70  align=right   SumText=@sum SumTextAlign=right  decao=0</c>
                            <c> Name='�����'       ID='SALE_AMT'    	Width=70  align=right  SumText=@sum SumTextAlign=right  decao=0</c>
                            <c> Name='�ܻ����'  	ID='CREDIT_AMT'     Width=70  align=right   SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='ȯ�Ҿ�'     	ID='refund_amt'      	Width=70  align=right  SumText=@sum SumTextAlign=right  decao=0</c>
                     	    <c> Name='ȯ�Ծ�'       ID='fund_amt'       	width=70	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='�������'    ID='a_amt'  		        width=70 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='������' 	  	ID='g_amt'  		        width=70 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='������ü'   	ID='b_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0 show=false</c>
                            <c> Name='�ſ�ī��'   	ID='c_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='�¶���ī��'   	ID='h_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>                     
                            <c> Name='��ǰ��'   		ID='d_amt'  		width=70 	  align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='�������Ա�'     ID='e_amt'        width=70    align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
                            <c> Name='��Ÿ��ü'        ID='f_amt'         width=70     align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</c>
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