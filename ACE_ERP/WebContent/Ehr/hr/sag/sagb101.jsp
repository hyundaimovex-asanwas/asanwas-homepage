<!--
***********************************************************************
* @source      : sagb101.jsp
* @description : ���缼�λ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>���缼�λ���(sagb101)</title>
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

		var btnList = 'FFFFFFFT';

        var dsT_CP_APPROVAL = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	var ENO_NO2 = dsT_CP_APPROVAL.NameValue(1,"ENO_NO2");
        	var PIS_YM = dsT_CP_APPROVAL.NameValue(1,"PIS_YM");
        	
			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb101.cmd.SAGB101CMD&S_MODE=SHR&ENO_NO2="+ENO_NO2+"&PIS_YM="+PIS_YM;
			dsT_DI_HOLIDAYWORK.reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,0,"false","false");      // Grid Style ����

            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
		
			fnc_HotKey_Process(btnList, event.keyCode);
			
		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_HOLIDAYWORK)		   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

  	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���缼�λ���</td>
					<td align="right" class="navigator">HOME/���°���/ö�ߴ���/ö�ߴ����񺻺������ó��/<font color="#000000">���缼�λ���</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
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
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_HOLIDAYWORK">
						<param name="Format"				value="
						<FC> id={currow}		width=30    name='NO'		    align=center </FC>
						<FC> id='DPT_NM'		width=80	name='�Ҽ�'			align=left		Edit=none	leftMargin='10'</FC>
						<FC> id='JOB_NM'		width=50	name='����'			align=left		Edit=none	leftMargin='10'</FC>
						<FC> id='ENO_NO'		width=60	name='���'			align=center	Edit=none</FC>
						<FC> id='ENO_NM'		width=60	name='����'			align=center	Edit=none</FC>
                        <C> id='PIS_YM'		width=70	name='�ش���'		align=center	Edit=none</C>
                        <C> id='DUTY_CNT'	width=70	name='�����ϼ�'		align=right 	Edit=none</C>
                        <C> id='DUTY_AMT'	width=70	name='��������'		align=right 	Edit=none</C>
                        <C> id='REMARK'		width=100	name='���'		    align=left	    Edit=none</C>
						<G> name='��û��' HeadBgColor='#F7DCBB'
							<C> id='AT1_CD'		width=20	name='1'	align=center	Edit=none   bgcolor={Decode(AT1_CD,'Y','#F2AC47','#FEEFEF')}    </C>
							<C> id='AT2_CD'		width=20	name='2'	align=center	Edit=none   bgcolor={Decode(AT2_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT3_CD'		width=20	name='3'	align=center	Edit=none   bgcolor={Decode(AT3_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT4_CD'		width=20	name='4'	align=center	Edit=none   bgcolor={Decode(AT4_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT5_CD'		width=20	name='5'	align=center	Edit=none   bgcolor={Decode(AT5_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT6_CD'		width=20	name='6'	align=center	Edit=none   bgcolor={Decode(AT6_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT7_CD'		width=20	name='7'	align=center	Edit=none   bgcolor={Decode(AT7_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT8_CD'		width=20	name='8'	align=center	Edit=none   bgcolor={Decode(AT8_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT9_CD'		width=20	name='9'	align=center	Edit=none   bgcolor={Decode(AT9_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT10_CD'	width=20	name='10'	align=center	Edit=none   bgcolor={Decode(AT10_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT11_CD'	width=20	name='11'	align=center	Edit=none   bgcolor={Decode(AT11_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT12_CD'	width=20	name='12'	align=center	Edit=none   bgcolor={Decode(AT12_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT13_CD'	width=20	name='13'	align=center	Edit=none   bgcolor={Decode(AT13_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT14_CD'	width=20	name='14'	align=center	Edit=none   bgcolor={Decode(AT14_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT15_CD'	width=20	name='15'	align=center	Edit=none   bgcolor={Decode(AT15_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT16_CD'	width=20	name='16'	align=center	Edit=none   bgcolor={Decode(AT16_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT17_CD'	width=20	name='17'	align=center	Edit=none   bgcolor={Decode(AT17_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT18_CD'	width=20	name='18'	align=center	Edit=none   bgcolor={Decode(AT18_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT19_CD'	width=20	name='19'	align=center	Edit=none   bgcolor={Decode(AT19_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT20_CD'	width=20	name='20'	align=center	Edit=none   bgcolor={Decode(AT20_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT21_CD'	width=20	name='21'	align=center	Edit=none   bgcolor={Decode(AT21_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT22_CD'	width=20	name='22'	align=center	Edit=none   bgcolor={Decode(AT22_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT23_CD'	width=20	name='23'	align=center	Edit=none   bgcolor={Decode(AT23_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT24_CD'	width=20	name='24'	align=center	Edit=none   bgcolor={Decode(AT24_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT25_CD'	width=20	name='25'	align=center	Edit=none   bgcolor={Decode(AT25_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT26_CD'	width=20	name='26'	align=center	Edit=none   bgcolor={Decode(AT26_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT27_CD'	width=20	name='27'	align=center	Edit=none   bgcolor={Decode(AT27_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT28_CD'	width=20	name='28'	align=center	Edit=none   bgcolor={Decode(AT28_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT29_CD'	width=20	name='29'	align=center	Edit=none   bgcolor={Decode(AT29_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT30_CD'	width=20	name='30'	align=center	Edit=none   bgcolor={Decode(AT30_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT31_CD'	width=20	name='31'	align=center	Edit=none   bgcolor={Decode(AT31_CD,'Y','#F2AC47','#FEEFEF')}    </C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->

	</form>
	<!-- form �� -->

</body>
</html>