<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ������ü 
 * ���α׷�ID   : RV007H (�ڵ�� �빮��)
 * J  S  P      : rv007h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��        : Rv007H
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
    	<title>�������Ա� ��������������������������������������������������������������������������������������������������������</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
        // ������ �ε�
        function fnOnLoad(){
            fnSelect();
        }

        // ���� ��ȸ
        function fnSelect() {
			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
            	        + ",pay_cd=<%=pay_cd%>"
                	    + ",pay_manage_no=<%=pay_manage_no%>";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv007H",
	            "JSP(O:DS7=ds7)",
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
       <script language=JavaScript for=ds7 event=OnLoadCompleted(rowcnt)>

            if(rowcnt==0){
            	alert("��ȸ�� �׸��� �����ϴ�!");
            	return;
            }
            
            pay_manage_no.value = ds7.namevalue(1,"pay_manage_no");
            bank_acct.value = ds7.namevalue(1,"bank_acct");
            bank_name.value = ds7.namevalue(1,"bank_name");
            bank_nm.value = ds7.namevalue(1,"bank_nm");
            order_nm.value = ds7.namevalue(1,"order_nm");
            pay_date.value = ds7.namevalue(1,"pay_date");
            pay_amt.value = ds7.namevalue(1,"pay_amt");
            
            
            
            
            
        </script>

        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnClose();
        </script>

<!-----------------------------------------------------------------------------
                                DataSet Components ���� 
# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
        <%=HDConstant.COMMENT_START%>
        <object id="ds7" classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
		       
       <table width="100%" height="320" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
        	<tr>
				<td height="3" bgcolor="#35ace8"></td>
			</tr>
			<tr>
	            <td height=25>
	                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align='absmiddle'><font style="position:relative;top:1px;width:60;height:15;left:5px;">�������Ա�</font>
	            </td>
	        </tr>
			<tr>
				<td height="3" bgcolor="#35ace8"></td>
			</tr>
            <tr>
                <td align="center" background="<%=dirPath%>/Sales/images/c_bg.gif" valign="top">
					<table width="90%" cellpadding="0" cellspacing="0" border="0">
						<tr height="10">
							<td></td>
						</tr>
						<tr>
							<td width="12"><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">����������ȣ</td>
							<td><input type="text" name="pay_manage_no" value="" readonly class="input"></td>
						</tr>
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">���¹�ȣ</td>
							<td><input type="text" name="bank_acct" value="" readonly class="input"></td>
						</tr>
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">�����</td>
							<td><input type="text" name="bank_name" value="" readonly class="input" size=8>
								<input type="text" name="bank_nm" value="" readonly class="input" size=9></td>
						</tr>
						<tr>
							<td width="12"><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">�Ա���</td>
							<td><input type="text" name="order_nm" value="" readonly class="input"></td>
						</tr>
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">�Ա�����</td>
							<td><input type="text" name="pay_date" value="" readonly class="input"></td>
						</tr>					
						<tr>
							<td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>
							<td width="110" height="22" align="left">�Աݾ�</td>
							<td><input type="text" name="pay_amt" value="" readonly class="input"></td>
						</tr>	
					</table>
            	</td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>