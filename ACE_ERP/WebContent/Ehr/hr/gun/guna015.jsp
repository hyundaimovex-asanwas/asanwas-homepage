	<!--*************************************************************************
	* @source      : guna015.jsp												*
	* @description : GROUPWARE �α��� üũ PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/11/12            ������                      �α��� ���½�û�����ۼ�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	String ENO_NO = request.getParameter("ENO_NO").substring(3);
	String LOGIN_IP = request.getRequestURL().toString();
	//System.out.println("LOGIN_IP [" + LOGIN_IP + "]");
%>


<html>
<head>
	<title>�α��� üũ(guna015)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			var ENO_NO = "<%=ENO_NO%>";
			var GUN_YMD = getToday();
			//GUN_YMD = "20110105";
			// save
			if(ENO_NO == null || ENO_NO == ""){

			}else{

				//��Ͻð� üũ
				if( new Date().getHours() >= "9"){
					//return false;
				}

				fnc_AddNew();

				trT_DI_GROUPWARE.KeyValue = "tr01(I:dsT_DI_GROUPWARE=dsT_DI_GROUPWARE)";
				trT_DI_GROUPWARE.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=GROUPWARE_SAV&ENO_NO="+ENO_NO+"&GUN_YMD="+GUN_YMD;
				trT_DI_GROUPWARE.post();

			}
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			dsT_DI_GROUPWARE.AddRow();
			dsT_DI_GROUPWARE.NameValue(1, "ENO_NO") = "<%=ENO_NO%>";
        }



		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	        dsT_DI_GROUPWARE.SetDataHeader(
								"ENO_NO:STRING(10),"+			// ���
								"LOGIN_IP:STRING(20)"			// LOGIN_IP
								);
			fnc_Save();
        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_GROUPWARE)			 	   |
    | 3. ���Ǵ� Table List(T_DI_GROUPWARE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_GROUPWARE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_GROUPWARE)		       |
    | 3. ���Ǵ� Table List(T_DI_GROUPWARE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_GROUPWARE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_GROUPWARE=dsT_DI_GROUPWARE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_GROUPWARE Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_GROUPWARE Event="OnLoadError()">
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_GROUPWARE event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_GROUPWARE event="OnFail()">
    </script>

  </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onload="fnc_OnLoadProcess();">

	<!-- form ���� -->
	<form name="form1">
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">Group Ware �α��� üũ</td>
					<td align="right" class="navigator">HOME/���°���/���ϱ��°���/<font color="#000000">Group Ware �α��� üũ</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	</form>
	<!-- form �� -->
</body>
</html>
