<!--
*****************************************************
* @source      : vluf050.jsp
* @description : ������������Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/24      ���뼺        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<script>
//Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�.
var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}
</script>
<html>
<head>
<title>������������Ȳ(vluf015)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
	<script language="javascript" >
		
		var btnList = 'FFFTFFFT';
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {
			
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			dsT_EV_DUTYRSH.ClearData();
			document.form1.tvT_CM_DUTYMST.Reset();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

   			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            
			cfStyleGrid(form1.grdT_EV_DUTYRSH,0,"false","right")      // Grid Style ����

			//form load�� ������ �����ڵ� Ʈ�����·� ��ȸ
            var f = document.form1;
			
			try {
				dsT_CM_DUTYMST.DataId="/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf010.cmd.VLUF010CMD&S_MODE=SHR";
				dsT_CM_DUTYMST.Reset();
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

	</script>
</head>

    <!--***************************************************************************************
    *                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)  *
    *                                                                                         *
    *****************************************************************************************-->

    <!----------------------------------------------+
    | 1. Ʈ�������� DataSet                         |
    | 2. �̸� : dsT_CM_DUTYMST                      |
    | 3. Table List : T_CM_DUTYMST                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : ds01T_CM_DUTYMST                    |
    | 3. Table List : T_CM_DUTYMST                  |
    +----------------------------------------------->
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_EV_DUTYRSH						|
    | 3. Table List : T_EV_DUTYRSH                  |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYRSH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------------------+
    | 1. ī�ǿ� DataSet												   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DUTYRSH)					   |
    | 3. ���Ǵ� Table List(T_EV_DUTYRSH, T_CM_DUTYMST)			   |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_DUTYRSH_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
	        //���������� �ϳ��� ������ ȸ�������� �ִ´�.
	        dsT_CM_DUTYMST.AddRow();
			tr01T_CM_DUTYMST.KeyValue = "SVL(I:dsT_CM_DUTYMST=dsT_CM_DUTYMST)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf010.cmd.VLUF010CMD&S_MODE=SAV";
			tr01T_CM_DUTYMST.post();
            dsT_CM_DUTYMST.Reset();//Ʈ���� �籸���Ѵ�.
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
	        
        }
		//����ȸ���� �������� ���� VLUF020CMD�� ���
        ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
        ds01T_EV_DUTYBAS.Reset();
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            alert("���� ���� ������ ������ ȸ���� �����ϴ�.");
        } else {
	        //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			var i;
			var oOption;

			//�˻����� �޺��ڽ��� ����ȸ���� ����
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO_SHR").add(oOption);
			}

        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DUTYMST Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_DUTYMST Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYRSH Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
	        fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
	        fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_EV_DUTYRSH Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYRSH Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>


    <!------------------------------------+
    | treeview���� item�� Ŭ��������      |
    +------ ------------------------------>
	<script language=JavaScript for=tvT_CM_DUTYMST event=OnItemClick(index)>
 
		var overNm = tvT_CM_DUTYMST.ItemText;
		var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
		var duty_cd = dsT_CM_DUTYMST.NameValue(Row,'DUTY_CD');
//		alert("overNm=>"+overNm+",Row=>"+Row+",duty_cd=>"+duty_cd);
		try {
			dsT_EV_DUTYRSH.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf050.cmd.VLUF050CMD&S_MODE=SHR&DUTY_NO="+getElementById('cmbDUTY_NO_SHR').value+"&DUTY_CD="+duty_cd;
			dsT_EV_DUTYRSH.Reset();

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}

	</script>

	<!--------------------------+
    | �׸����� ROW�� Ŭ�� �Ҷ�  |
    +--------------------------->
	<script language=JavaScript for=grdT_EV_DUTYRSH event="OnClick(row,colid)">
		
		if(row < 1) {
			return;
		} else {
			var url = "/hr/vlu/vluf041.jsp?HEAD_NM="+ds01T_EV_DUTYBAS.NameValue(1,'HEAD_NM')+"&TITLE=������������Ȳ_��&SHOW=ONLY";
			//���õ� ROW�� dsT_EV_DUTYRSH_CP�� �����Ͽ� Modalâ�� dsT_EV_DUTYRSH_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_EV_DUTYRSH, dsT_EV_DUTYRSH_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

			window.showModalDialog(url, dsT_EV_DUTYRSH_CP, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();
		}

	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������Ȳ</td>
					<td align="right" class="navigator">HOME/�λ���/��������/��������/<font color="#000000">������������Ȳ</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
							<tr>
								<td align="center" class="searchState">����ȸ��</td>
								<td width="50">
									<select id="cmbDUTY_NO_SHR" name="cmbDUTY_NO_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
									</select>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
							<param name=DataID		value="dsT_CM_DUTYMST">
							<param name=TextColumn	value="DUTY_NM">
							<param name=LevelColumn	value="DUTY_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CM_DUTYMST">
							<param name=ImgCColumn	value="ImgC">
							<param name=ImgDColumn	value="ImgD">
							<param name=ImgOColumn	value="ImgO"> -->
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ Ʈ�� ��-->
    </td>
    <td>
        <!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
        				<comment id="__NSID__">
        				<object	id="grdT_EV_DUTYRSH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500;height:375px;">
        					<param name="DataID"				value="dsT_EV_DUTYRSH">
        					<param name="EdiTABLE"				value="false">
        					<param name="DragDropEnable"		value="true">
        					<param name="SortView"				value="Left">
        					<param name="VIEWSUMMARY"			value=0>
        					<param name="Format"				value="
        								<C> id={currow}		width=50        name='����'		align=center </C>
										<C> id='HEAD_NM'	width=90       name='����'		align=left </C>
										<C> id='DPT_NM'		width=90       name='�μ�'		align=left </C>
										<C> id='JOB_NM'		width=55       name='����'		align=left </C>
        								<C> id='ENO_NO'		width=60        name='���'	    align=center </C>
        								<C> id='ENO_NM'		width=60        name='����'	    align=center </C>
        								<C> id='DUTY_YMD'	width=75        name='�ۼ���'	align=center </C>
        							">
        				</object>
        				</comment><script> __ShowEmbedObject(__NSID__); </script>
        			</td>
        		</tr>
        	</table>
        <!-- ���� ��ȸ �׸��� ���̺� ��-->
    </td>
</tr>
</table>

</form>
<!-- form �� -->

</body>
</html>