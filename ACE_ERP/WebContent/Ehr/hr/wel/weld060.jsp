	<!--
	***********************************************************************
	* @source      : weld060.jsp
	* @description : �������ܵ���û PAGE
	***********************************************************************
	* DATE            AUTHOR        DESCRIPTION
	*----------------------------------------------------------------------
	* 2006/12/15      ���뼺        �����ۼ�.
	***********************************************************************
	-->

	<%@ page contentType="text/html; charset=EUC-KR"%>
	<%@ include file="/common/sessionCheck.jsp" %>

	<html>
	<head>
	<title>�������ܵ���û(weld060)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>


	    <!--*****************************
	    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
	    *****************************-->
	    <script language="javascript" >

	        //����Ű ����
	        var btnList = "T"   //��ȸ
	                    + "F"   //�ű�
	                    + "T"   //����
	                    + "T"   //���
	                    + "F"   //����
	                    + "F"   //�μ�
	                    + "F"   //����
	                    + "T";  //�ݱ�

	        /***********************************
	         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
	         ***********************************/
	        function fnc_SearchList() {

				var ORD_NO = document.getElementById("cmbORD_NO_SHR").value;

	            trSHR.KeyValue  = "tr01(O:CONDOLOT=dsT_WL_CONDOLOT, O:CONDOSSN=dsT_WL_CONDOSSN2)";
	            trSHR.action    = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld060.cmd.WELD060CMD&S_MODE=SHR&ORD_NO="+ORD_NO;
	            trSHR.post();

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

				if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

				trT_WL_CONDOLOT.KeyValue = "tr01(I:dsT_WL_CONDOLOT=dsT_WL_CONDOLOT)";
				trT_WL_CONDOLOT.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld060.cmd.WELD060CMD&S_MODE=SAV";
				trT_WL_CONDOLOT.post();

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

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

	        }

	        /******************
	         * 07. �ű� �Լ�  *
	         ******************/
	        function fnc_AddNew() {

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

	        }

	        /******************
	         * 08. �߰� �Լ�  *
	         ******************/
	        function fnc_Append() {

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

				//document.getElementById('cmbRST_YN_SHR').value = '';
				document.getElementById("resultMessage").innerText = ' ';

				dsT_WL_CONDOLOT.ClearData();

	        }

	        /************************
	         * 11. ȭ�� ����(�ݱ�)  *
	         ***********************/
	        function fnc_Exit() {

				if (dsT_WL_CONDOLOT.IsUpdated)  {

					if (!fnc_ExitQuestion()) return;

				}

				frame = window.external.GetFrame(window);
				frame.CloseFrame();

	        }

	        /******************************
	         * 12. �˻� ���� ��ȿ�� �˻�  *
	         ******************************/
	        function fnc_SearchItemCheck() {

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

	        }

	        /*************************
	         * 13. ���� ��ȿ�� üũ  *
	         *************************/
	        function fnc_SaveItemCheck() {

				var app1     = dsT_WL_CONDOSSN2.NameValue(1,'APP1_YMD');
				var app2     = dsT_WL_CONDOSSN2.NameValue(1,'APP2_YMD');
				var lottery  = dsT_WL_CONDOSSN2.NameValue(1,'LOTTERY');
				var today    = removeChar(getToday(),"-");


				if (app1 > today || app2 < today){
					alert("������ ��÷ ��û �Ⱓ�� �ƴմϴ�!");
					return false;
				}
				if (lottery > 0){
					alert("������ ��÷�� �Ϸ�Ǿ� ���� �� �� �����ϴ�!");
					return false;
				}

	            if (!dsT_WL_CONDOLOT.IsUpdated ) {
	                alert("������ �ڷᰡ �����ϴ�.");
	                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
	                return false;
	            }

				return true;

	        }

	        /********************************************
	         * 14. Form Load �� Default �۾� ó�� �κ�  *
	         *******************************************/
	        function fnc_OnLoadProcess() {

				cfStyleGrid(form1.grdT_WL_CONDOLOT,15,"false","false");      // Grid Style ����

				//�ܵ� ������ ������ȣ (weld050 ���)
				dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR_01";
				dsT_WL_CONDOSSN.Reset();

	        }

			/********************
	         * 15. ����Ű ó��  *
	         *******************/
			function fnc_HotKey() {

				fnc_HotKey_Process(btnList, event.keyCode);

			}


	    </script>

	    </head>


	    <!--**************************************************************************************
	    *                                                                                        *
	    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
	    *                                                                                        *
	    ***************************************************************************************-->

	    <!-----------------------------------------------+
	    | 1. ��ȸ�� DataSet								 |
	    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOLOT) |
	    | 3. ���Ǵ� Table List(T_WL_CONDOLOT)		     |
	    +------------------------------------------------>
	    <Object ID="dsT_WL_CONDOLOT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	        <Param Name="Syncload"        Value="True">
	        <Param Name="UseChangeInfo"   Value="True">
	        <Param Name="ViewDeletedRow"  Value="False">
	    </Object>

		<!-----------------------------------------------+
	    | 1. ��ȸ�� DataSet								 |
	    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOSSN) |
	    | 3. ���Ǵ� Table List(T_WL_CONDOSSN)		     |
	    +------------------------------------------------>
	    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	        <Param Name="Syncload"        Value="True">
	        <Param Name="UseChangeInfo"   Value="True">
	        <Param Name="ViewDeletedRow"  Value="False">
	    </Object>

	    <Object ID="dsT_WL_CONDOSSN2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	        <Param Name="Syncload"        Value="True">
	        <Param Name="UseChangeInfo"   Value="True">
	        <Param Name="ViewDeletedRow"  Value="False">
	    </Object>

	    <!--------------------------------------------------+
	    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
	    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_CONDOLOT)	|
	    | 3. ���Ǵ� Table List(T_WL_CONDOLOT)	            |
	    +--------------------------------------------------->
	    <Object ID ="trT_WL_CONDOLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	        <Param Name=KeyName     Value="toinb_dataid4">
	        <Param Name=ReadOnly	Value="True">
	    </Object>

	    <Object ID ="trSHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	        <Param Name=KeyName     Value="toinb_dataid4">
	    </Object>


	    <!-- ���� �޺��� ���� DataSet -->
	    <!-- �ܵ� -->
	    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
	       <jsp:param name="DATASET_ID"    value="dsCOMMON_CN"/>
	       <jsp:param name="CODE_GUBUN"    value="CN"/>
	       <jsp:param name="SYNCLOAD"      value="false"/>
	       <jsp:param name="USEFILTER"     value="false"/>
	    </jsp:include>


	    <!--*************************************
	    *                                       *
	    *  Component���� �߻��ϴ� Event ó����  *
	    *                                       *
	    **************************************-->

	    <!-------------------------------------------------+
	    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
	    +-------------------------------------------------->
	    <Script For=dsT_WL_CONDOLOT Event="OnLoadCompleted(iCount)">

	        if (iCount < 1)    {

	            alert("���� ������ ��÷��ϱⰣ�� �ƴմϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_02");

	        } else {

				fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

	        }

	    </Script>

	    <!-----------------------------------------------------+
	    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
	    +------------------------------------------------------>
	    <Script For=dsT_WL_CONDOLOT Event="OnLoadError()">

	        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
	        cfErrorMsg(this);

	        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

	    </Script>

		<!-------------------------------------------------+
	    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
	    +-------------------------------------------------->
	    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

	        if (iCount > 0) {
				var oOption;
				for(var i=1 ; i<=iCount ; i++) {

					oOption         = document.createElement("OPTION");
					oOption.text    = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
					oOption.value   = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");

					document.getElementById("cmbORD_NO_SHR").add(oOption);
				}
				document.getElementById("cmbORD_NO_SHR").selectedIndex = 0;
	        }

	    </Script>

	    <Script For=dsT_WL_CONDOSSN2 Event="OnLoadCompleted(iCount)">
	        var app1     = dsT_WL_CONDOSSN2.NameValue(1,'APP1_YMD');
	        var app2     = dsT_WL_CONDOSSN2.NameValue(1,'APP2_YMD');
	        var lottery  = dsT_WL_CONDOSSN2.NameValue(1,'LOTTERY');
	        var today    = removeChar(getToday(),"-");


	        if (app1 > today || app2 < today || lottery > 0){
	            grdT_WL_CONDOLOT.Editable = false;
	        } else {
	            grdT_WL_CONDOLOT.Editable = true;
	        }

	    </Script>

	    <!-----------------------------------------------------+
	    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
	    +------------------------------------------------------>
	    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

	        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
	        cfErrorMsg(this);

	        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

	    </Script>

	    <!-----------------------------------------------------------------+
	    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
	    +------------------------------------------------------------------>
	    <Script For=dsT_WL_CONDOLOT Event="OnDataError()">

	        //Dataset���� Error ó��
	        cfErrorMsg(this);

	    </Script>

	    <!-----------------------------+
	    | Transaction Successful ó��  |
	    +------------------------------>
	    <script for=trT_WL_CONDOLOT event="OnSuccess()">
			fnc_SearchList();
	        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
	    </script>

	    <!--------------------------+
	    | Transaction Failure ó��  |
	    +--------------------------->
	    <script for=trT_WL_CONDOLOT event="OnFail()">
	        cfErrorMsg(this);
	    </script>

	    <!--------------------------+
	    | grid���� row�� Ŭ�������� |
	    +------ -------------------->
		<script for=grdT_WL_CONDOLOT event=OnClick(Row,Colid)>

			if(Row < 1 || !grdT_WL_CONDOLOT.Editable) {
				return;
			} else {
				if(Colid == 'APP_YN'){

	                if(dsT_WL_CONDOLOT.Namevalue(Row, 'APP_YN') != "F") {
	    				for(i=1;i<dsT_WL_CONDOLOT.CountRow+1;i++){
	    					if(i != Row){
	    						dsT_WL_CONDOLOT.Namevalue(i, 'APP_YN') = 'F';
	    					}
	    				}
	                }

				}

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
						<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������ܵ���û</td>
						<td align="right" class="navigator">HOME/�����Ļ�/�ܵ�/<font color="#000000">�������ܵ���û</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
										<col width="120"></col>
										<col width="*"></col>
									</colgroup>
								<tr>
									<td align="center" class="searchState">�����������ȣ</td>
									<td class="padding2423">
	                                    <select id="cmbORD_NO_SHR" name="cmbORD_NO_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
	                                    </select>
									</td>
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

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							<object	id="grdT_WL_CONDOLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
								<param name="DataID"					value="dsT_WL_CONDOLOT">
								<param name="Format"					value="
									<C> id={currow}	   width=39   name='NO'				align=center	edit=none </C>
									<C> id='ORD_NO'	   width=90   name='�����������ȣ'	align=center	edit=none  </C>
									<C> id='STR_YMD'   width=80   name='�̿������'		align=center	edit=none  </C>
									<C> id='CN_NM'	   width=80	  name='�ܵ�'			align=left leftmargin=10	edit=none  </C>
									<C> id='CO_NM'	   width=220  name='����'			align=left leftmargin=10	edit=none  </C>
									<C> id='ROOM_CNT'  width=55	  name='���Ǽ�'			align=right rightmargin=10	edit=none  </C>
									<C> id='STAY_CNT'  width=60	  name='�̿��ϼ�'		align=right rightmargin=10	edit=none  </C>
									<C> id='APP_CNT'   width=80	  name='�����û�ڼ�'	align=right rightmargin=10	edit=none  </C>
									<C> id='APP_YN'	   width=60	  name='��û����'		align=center  EditStyle=CheckBox </C>
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