<!--
***********************************************************************
* @source      : educ012.jsp
* @description : �����̷� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/08/08      ������        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�����̷�(educ012)</title>
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

        var opener = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_EDUCATION_01=dsT_CM_EDUCATION_01, "+
        	                                "O:dsT_CM_EDUCATION_02=dsT_CM_EDUCATION_02, "+
        	                                "O:dsT_ED_LCTRHIST_03=dsT_ED_LCTRHIST_03, "+
        	                                "O:dsT_CM_EDUCATION_04=dsT_CM_EDUCATION_04, "+
        	                                "O:dsT_ED_EXCEPTER_05=dsT_ED_EXCEPTER_05)";

			trT_CM_EDUCATION.Action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ012.cmd.EDUC012CMD"
                                    + "&S_MODE=SHR"
                                    + "&PIS_YY="+opener.edu_yy  //�⵵
                                    + "&ENO_NO="+opener.eno_no; //�н��� ���
			trT_CM_EDUCATION.Post();

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

            if (dsT_CM_EDUCATION_01.CountRow < 1 &&
                dsT_CM_EDUCATION_02.CountRow < 1 &&
                dsT_ED_LCTRHIST_03.CountRow < 1 &&
                dsT_CM_EDUCATION_04.CountRow < 1 &&
                dsT_ED_EXCEPTER_05.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }


             if(dsT_ED_EXCEPTER_05.CountRow > 0){
				form1.grdT_ED_EXCEPTER_05.GridToExcel("�������̷�", '', 225);
            }

            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.RunExcelSheetEx("��ܱ����̷�", 1, 0);
            }

            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.RunExcelSheetEx("�系�����̷�", 1, 0);
            }

            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.RunExcelSheetEx("�系�����̷�", 1, 0);
            }

            if(dsT_CM_EDUCATION_01.CountRow > 0){
                form1.grdT_CM_EDUCATION_01.RunExcelSheetEx("����������Ȳ", 1, 0);
            }

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

			cfStyleGrid(form1.grdT_CM_EDUCATION_01,0,"false","false");      // Grid Style ����
			form1.grdT_CM_EDUCATION_01.HiddenHScroll  = true;
			form1.grdT_CM_EDUCATION_01.HiddenVScroll  = true;
			form1.grdT_CM_EDUCATION_01.DisableNoHScroll = false;
			form1.grdT_CM_EDUCATION_01.DisableNoVScroll = false;

			cfStyleGrid(form1.grdT_CM_EDUCATION_02,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_ED_LCTRHIST_03,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_CM_EDUCATION_04,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_ED_EXCEPTER_05,0,"false","false");      // Grid Style ����

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EDUCATION)		   |
    | 3. ���Ǵ� Table List(T_CM_EDUCATION) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_EDUCATION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_LCTRHIST_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_EXCEPTER_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

  	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadCompleted(iCount)">
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����̷�</td>
					<td align="right" class="navigator">HOME/��������/�����н�����/����������Ȳ/<font color="#000000">�����̷�</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>����������Ȳ</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:86px;">
						<param name="DataID" value="dsT_CM_EDUCATION_01">
						<param name="Format"				value="
							<G> name='�����հ�'  HeadBgColor='#F7DCBB'
								<C> id='CPT_PNT_TOT'		width='100'		name='���'			align='right'	Edit=none</C>
								<C> id='APP_POINT'			width='100'		name='����'			align='right'	Edit=none</C>
							</G>
							<G> name='�系����'  HeadBgColor='#F7DCBB'
								<C> id='CPT_PNT_AA1'		width='100'		name='�ʼ�'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB1'		width='100'		name='����'			align='right'	Edit=none</C>
							</G>
                            <C> id='CPT_PNT_LCT'            width='99'      name='�系����'           align='right'   Edit=none</C>
							<G> name='��ܱ���'  HeadBgColor='#F7DCBB'
								<C> id='CPT_PNT_AA2'		width='99'		name='�ʼ�'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB2'		width='99'		name='����'			align='right'	Edit=none</C>
							</G>
							<C> id='CPT_PNT_EXP'			width='99'		name='��������'			align='right'	Edit=none</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�系�����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_02">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='150'		name='������'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='90'		name='����'			align='center'		Edit=none				</C>
								<C> id='LCT_TIME'		width='85'		name='�����ð�'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_TAG'		width='90'		name='���'			align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='85'		name='����'			align='right'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�系�����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_LCTRHIST_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_LCTRHIST_03">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='LCT_TAG'		width='150'		name='���Ǹ�'		align='left'		Edit=none				</C>
								<C> id='LCT_TIME'		width='70'		name='���ǽð�'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='EDU_NM'			width='150'		name='������'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='75'		name='����'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='75'		name='����'			align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='70'		name='����'			align='right'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>��ܱ����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_04">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='150'		name='������'		align='left'		Edit=none				</C>
								<C> id='LCT_TIME'		width='85'		name='�����ð�'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='����'			align='center'		Edit=none				</C>
								<C> id='INT_NAM'		width='90'		name='�������'		align='left'		Edit=none				</C>
								<C> id='PLACE_NM'		width='90'		name='�������'		align='left'		Edit=none				</C>
								<C> id='CPT_PNT'		width='85'		name='����'			align='right'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�������̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_EXCEPTER_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_EXCEPTER_05">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EXC_NM'			width='540'		name='���ܱ���'		align='left'		Edit=none				</C>
								<C> id='CPT_PNT'		width='200'		name='����'			align='right'		Edit=none				</C>
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