<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ :�����Ƿڼ�
 * ���α׷�ID 	: pr010h
 * J  S  P	    : pr010h.jsp
 * �� �� ��		: pr010h
 * �� �� ��		: �̵���
 * �� �� ��		: 2015-09-12
 * [ �������� ][������] ����
 * [2015-09-12][�̵���]
 *****************************************************************************/
%>
<%@ page import="pms.common.*" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid =0;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���ڰ��� - �����Ƿڼ�����</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">

		var retObj = window.dialogArguments;

        /********************************************
         * 1. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			document.form1.txtAP_DESC.focus();          //�˻� 1���ǿ� Focus

        }

        /*************************
         * 2. �ݼ۹�ư Click    *
         *************************/
        function fnApply_Back() {

            var ap_desc = document.getElementById("txtAP_DESC");

            if(ap_desc.value.trim().length < 1){
            	
                alert("�ǰ��� �Է��Ͻñ� �ٶ��ϴ�.");
                
                ap_desc.focus();
                
                return;
                
            }
            
			window.returnValue = "Y"+ ";" + document.getElementById("txtAP_DESC").value + ";" 
            window.close();

        }

        /*************************
         * 3. ��ҹ�ư Click    *
         *************************/
        function fnCancel() {

            window.close();

        }        

    </script>

    </head>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnc_OnLoadProcess()">


<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25  width=800 align ="right">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_Back();">
	    	<img src="<%=dirPath%>/Sales/images/b_cancel.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnCancel();">	    	
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>&nbsp;&nbsp;
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:100;height:15;">&nbsp;�ǰ��Է�</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=800>
		<table width="790px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">�ǰ�</td>
				<td height="25px"  width="660px" bgcolor="#eeeeee" align=left class="text">
                       <input name="txtAP_DESC" id="txtAP_DESC" size="100" maxlength="100" >
				</td>
			</tr>	
		</table>
	</td>
  </tr>
</table>
 <br>
 &nbsp;&nbsp;* �ǰ߸� �Է��Ͻð� '�ݼ�' ��ư�� �����ø� �ݼ�ó���� �Ϸ�˴ϴ�.
 <br>
 &nbsp;&nbsp;* '���' ��ư�� �����ø� �ݼ�ó���� ��ҵǰ� â�� ����˴ϴ�.
</body>
<!- BODY END -->
</html>

