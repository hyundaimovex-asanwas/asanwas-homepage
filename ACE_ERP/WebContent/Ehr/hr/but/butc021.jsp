<!--
***********************************************************************
* @source      : butc021.jsp
* @description : �����꼭 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/02/05      ������        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String status = request.getParameter("STATUS");         //�����������
	String role_cd = box.getString("SESSION_ROLE_CD");         //�ѱ���
	System.out.println("status [" + status + "]");
	System.out.println("role_cd [" + role_cd + "]");
%>

<html>
<head>
	<title>�����꼭(butc021)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFTFFT';

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

            //�����꼭 ��ȸ
            dsT_DI_DISPATCH_ACCOUNT.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc021.cmd.BUTC021CMD&S_MODE=SHR_01&ORD_NO="+dsTemp.NameValue(1,"ORD_NO");
            dsT_DI_DISPATCH_ACCOUNT.reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {
        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {
        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

            if (dsT_DI_DISPATCH_ACCOUNT.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_DI_DISPATCH_ACCOUNT,0,"true","false");      // Grid Style ����

			fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. �����ͼ� ����(fnc_compareDS�� ���� �����ؾ� ��)*
         ********************************************/
		function fnc_SettingDS() {

		}

        /********************************************
         * 16. �����ͼ� ��(fnc_SettingDS�� ���� �����ؾ� ��)*
         ********************************************/
		function fnc_compareDS() {

		}

        /********************************************
         * 17. �հ�ݾ� ���						*
         ********************************************/
		function fnc_TotAccount() {

		}

        /********************************************
         * 18. 'ó��'��ư ó��  					*
         ********************************************/
		function fnc_Reflect() {
		}

        /********************************************
         * 19. '�λ���Ȯ��'��ư ó��  					*
         ********************************************/
		function fnc_InsaConfirm() {
			var today = getToday();     //�ý��۳�¥
			apprdate=prompt("��ǥó���� �����꼭�� Ȯ���Ͻðڽ��ϱ�? \n�������ڸ� Ȯ�ιٶ��ϴ�.",today);


//cfDateExpr(apprdate)
			if(apprdate == null){
			  alert("�۾��� ��ҵǾ����ϴ�");
			  return
			}else{
			  //alert("apprdate:"+apprdate);
			}

			if(cfDateExpr(apprdate)){
				trT_DI_DISPATCH_ACCOUNT.KeyValue = "tr02(I:dsT_DI_DISPATCH_ACCOUNT=dsT_DI_DISPATCH_ACCOUNT)";
				trT_DI_DISPATCH_ACCOUNT.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc021.cmd.BUTC021CMD&S_MODE=PROC"+"&APPRDATE="+apprdate;
				trT_DI_DISPATCH_ACCOUNT.post();

			}else{
			}
		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->
    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_DISPATCH)	|
    | 3. ���Ǵ� Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_ACCOUNT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

	<!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DISPATCH_ACCOUNT)|
    | 3. ���Ǵ� Table List(T_DI_DISPATCH_ACCOUNT) 		|
    +------------------------------------------------------->
	<Object ID="dsT_DI_DISPATCH_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->
    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_DISPATCH_ACCOUNT event="OnSuccess()">
        cfErrorMsg(this);
		window.close();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_DISPATCH_ACCOUNT event="OnFail()">
        cfErrorMsg(this);
		window.close();
    </script>
	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DISPATCH_ACCOUNT Event="OnLoadCompleted(iCount)">
		   var APP_STATUS = dsTemp.NameValue(1,"APP_STATUS");
		   //alert("<%=role_cd%>");
		   //alert(APP_STATUS);
			if( ("1001" == "<%=role_cd%>" || "1002" == "<%=role_cd%>") && (APP_STATUS == 4 || APP_STATUS == 7) ){
				//alert("ó�����");
				grdT_DI_DISPATCH_ACCOUNT.ColumnProp("TRANS_GBN", "Edit") = "Any";
			}else{
				//alert("�б���");
				grdT_DI_DISPATCH_ACCOUNT.ColumnProp("TRANS_GBN", "Edit") = "none";
			}
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_DISPATCH_ACCOUNT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------------------------------------------------------+
    | Grid�󿡼� Editable���¿��� �ϳ��� Cell�� �Է��� �Ϸ��� ��, ���� Cell�� ��Ŀ���� �ű� �� �߻��ϴ� Event  |
    +---------------------------------------------------------------------------------------------------------->
	<script language=JavaScript for="grdT_DI_DISPATCH_ACCOUNT" event="OnCloseUp(row,colid)">
		if(colid == "TRANS_GBN"){
			var TRANS_GBN = dsT_DI_DISPATCH_ACCOUNT.NameValue(row, "TRANS_GBN");
			var ORG_TRANS_GBN = dsT_DI_DISPATCH_ACCOUNT.OrgNameValue(row, "TRANS_GBN");
			if(ORG_TRANS_GBN == "Y"){
				alert("�̹� ��ǥó���Ǿ����ϴ�");
				dsT_DI_DISPATCH_ACCOUNT.NameValue(row, "TRANS_GBN") = ORG_TRANS_GBN;
				return;
			}
			if(TRANS_GBN == "Y"){
				fnc_InsaConfirm();
			}
		}
	</script>


	<!-----------------------------------------------------+
    | Grid ���� ��¥ ���������� �����ڵ� ��������						   |
    +------------------------------------------------------>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�İߺ����</td>
					<td align="right" class="navigator">HOME/���°���/�İ߰���/<font color="#000000">�İߺ����</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" width="300">
			    <span id="helpMessage">&nbsp;</span>

			</td>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DISPATCH_ACCOUNT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:700px;height:315px;">
						<param name="DataID" value="dsT_DI_DISPATCH_ACCOUNT">
						<Param Name="ViewSummary"   value="1" >
						<param name="Format" value='
							<G>name=�İߺ���⳻��	HeadBgColor=#F7DCBB
							<C> id="{CUROW}"	width=40	name="NO"		align=center	value={String(Currow)}</C>
							<C> id="YYYY"	    width=60	name="��"		align=center	    Edit=none SumText="�� ��" suppress=1 </C>
							<C> id="MM"			width=40	name="��"		align=center	Edit=none </C>
                            <C> id="PAY_DAY"	width=100	name="������"	align=center	Edit=none sumtext=@sum</C>
							<C> id="EAT_AMT"	width=100	name="�ĺ�"	align=center    Edit=none sumtext=@sum</C>
                            <C> id="ETC_AMT"	width=100	name="���"		align=right Edit=none     sumtext=@sum</C>
                            <C> id="COST_AMT"	width=100	name="���ް�(��)"		align=right     Edit=none sumtext=@sum</C>
							</G>
                            <C> id="TRANS_GBN"	width=100	name="��ǥó��"	align=center	EditStyle=Combo Data="Y:ó��,N:��ó��"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <tr>
			<td  width="50%" align="left" class="paddingTop5">
				�� �İߺ� : ������ * 70%
			</td>
		</tr>
        <tr>
			<td  width="50%" align="left" class="paddingTop5">
				<!-- ��ȸ ���� ���̺� ���� -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- ��ȸ ���� ���̺� �� -->
			</td>
		</tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->
	</form>
	<!-- form �� -->
</body>
</html>

