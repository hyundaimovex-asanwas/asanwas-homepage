<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ��ǰ�� 
 * ���α׷�ID   : RV009H (�ڵ�� �빮��)
 * J  S  P      : rv009h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��        : Rv009H
 * �� �� ��        : �̺���
 * �� �� ��        : 2006-07-22
 * �������     : �Ա������� ���� ��ȸ ������ü 
 * ��������     : 2006-07-22 : XXXXX ���� XXXXX ������û (�Ϸ�/�̿Ϸ�)
 * �� �� ��        : �̺���
 * ������������ :  
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    String pay_cd = request.getParameter("pay_sid");
    String pay_manage_no = request.getParameter("pay_manage_no");
    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<title>��ǰ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
        // ������ �ε�
        function fnOnLoad(){
          cfStyleGrid(getObjectFirst("gr1"), "comn");
            fnSelect();
        }

        // ���� ��ȸ
        function fnSelect() {
			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
            	        + ",pay_cd=<%=pay_cd%>"
                	    + ",pay_manage_no=<%=pay_manage_no%>";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv007H",
	            "JSP(O:DS6=ds6)",
	            v_param);
	        tr_post(tr1);
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
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
       <script language=JavaScript for=ds6 event=OnLoadCompleted(rowcnt)>

            if(rowcnt==0){
            	alert("��ȸ�� �׸��� �����ϴ�!");
            	return;
            }
           
            
        </script>

        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnClose();
        </script>

<!-----------------------------------------------------------------------------
                                DataSet Components ���� 
# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
        <%=HDConstant.COMMENT_START%>
        <object id="ds6" classid=<%=HDConstant.CT_DATASET_CLSID%>>
            <param name="SyncLoad" value="false">
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
    
<!--  BODY START -->
    <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	       
        <table width="300" height="320" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
       		 <tr>
				<td height="3" bgcolor="#35ace8"></td>
			</tr>
			 <tr>
	            <td height=25>
	                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:50;height:15;left:5px;">��ǰ��</font>
	            </td>
	        </tr>
			<tr>
				<td height="3" bgcolor="#35ace8"></td>
			</tr>
            <tr>
                <td align="center" background="<%=dirPath%>/Sales/images/c_bg.gif" valign="top">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr height="10">
							<td></td>
						</tr>
						<tr>
							<td>
								 <%=HDConstant.COMMENT_START%>
				                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='280px' height='250px' border=1">
				                        <param name="DataID"        value="ds6">
				                        <param name="BorderStyle"   value="0"> 
				                        <param name="AllShowEdit"   value="false"> <!-- Edit����  -->
				                        <param name="ColSizing"     value="true">
				                        <param name="Editable"      value="false">
				                        <param name="FillArea"      value="True">
				                        <param name="Format"        value="
				                            <c> Name='��ǰ�� �ڵ�'      ID='GIFT_CD'      Edit=None Width=130  align=center </c>
				                            <c> Name='����'      ID='GIFT_TYPE'    Edit=None Width=50</c>
				                            <c> Name='����'   ID='FR_GIFT_SEQ'   Edit=None Width=50</c>
				                            <c> Name='���� '  ID='TO_GIFT_SEQ'   Edit=None Width=50</c>
				                            <c> Name='�����ż�'        ID='PAY_QTY'       Edit=None Width=60</c>
				                            <c> Name='�����ݾ�'        ID='PAY_AMT'       Edit=None Width=60</c>
				                        ">
				                    </object>
				                    <%=HDConstant.COMMENT_END%>
							</td>
						</tr>																
					</table>
            	</td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>