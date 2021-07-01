<!--
    ************************************************************************************
    * @source         : saga261.jsp 				                                   *
    * @description   : �系���� ���� PAGE.                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 201111/07|  �̵���   | �����ۼ�                                                  *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���ݻ�ȯ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

        var dsT_Loan_Master = window.dialogArguments;//opener���� �޾ƿ´�.

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			var i = 1;

			var ENO_NO = dsT_Loan_Master.NameValue(i,"ENO_NO");
			var ENO_NM = dsT_Loan_Master.NameValue(i,"ENO_NM");
			var APPDT = dsT_Loan_Master.NameValue(i,"APPDT");
			var APLDT = dsT_Loan_Master.NameValue(i,"APLDT");
			var APPAMT = dsT_Loan_Master.NameValue(i,"APPAMT");


			document.getElementById("txtSTR_YYMM_SHR").value = dsT_Loan_Master.NameValue(i,"APLDT"); // ���۳��
			document.getElementById("txtEND_YYMM_SHR").value = dsT_Loan_Master.NameValue(i,"APLDT"); // ������

            //�����ͼ� ����
			dsT_Loan_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SHR_02&ENO_NO_SHR="+ENO_NO;
            dsT_Loan_Detail.Reset();


        }

   		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

   			if( !fnc_SaveItemCheck() )	return;

			if (confirm("�����Ͻðڽ��ϱ�?")) {

			//Ʈ����� ����
				trT_Loan_Detail.KeyValue = "SVL(I:SAV=dsT_Loan_Temp)";
				trT_Loan_Detail.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SAV_DELAY";
				trT_Loan_Detail.Post();

			}

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			fnc_OnLoadProcess();
			
			dsT_Loan_Detail.ClearData();
			
			document.getElementById("resultMessage").innerText = ' ';
			
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���

			window.close();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_Loan_Detail.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_Loan_Detail,15,"true","false");        	
        	
			fnc_SearchList();

        }


		/*********************************************
         * 15. ���� �۾� ó�� �κ�                    *
		*********************************************/
		function fnc_Delay() {

            var start_month = document.getElementById("txtSTR_YYMM_SHR").value;
            var end_month = document.getElementById("txtEND_YYMM_SHR").value;
			var count = ((end_month.substring(2, 4) - start_month.substring(2, 4))*12) + (end_month.substring(5, 7) - start_month.substring(5, 7)) +1;

			if (confirm(start_month + "����  " + end_month +"����  " +count+ "���� ��ȯ�� �����Ͻðڽ��ϱ�?")) {

	            for(i=1; i<=dsT_Loan_Detail.countrow; i++){

	            //���鼭 �����������ޱ����� ���ܵΰ� �������۴޺��� ��������.
					if(start_month.replace("-", "") == dsT_Loan_Detail.namevalue(i,"APLDT").substring(0, 6)){

						for(j=0; j<count; j++){

							dsT_Loan_Detail.InsertRow(i);
							dsT_Loan_Detail.namevalue(i,"ENO_NO") = dsT_Loan_Detail.namevalue(i-1,"ENO_NO");			//���
							dsT_Loan_Detail.namevalue(i,"APPDT")  = dsT_Loan_Detail.namevalue(i-1,"APPDT");				//��������

							dsT_Loan_Detail.namevalue(i,"APLDT") = ln_APLDT(i,dsT_Loan_Detail.namevalue(i-1,"APLDT"));	 //��ȯ����
							dsT_Loan_Detail.namevalue(i,"APPAMT") = dsT_Loan_Detail.namevalue(i-1,"APPAMT");			//����ݾ�
							dsT_Loan_Detail.namevalue(i,"APJAMT") = dsT_Loan_Detail.namevalue(i-1,"APJAMT")-dsT_Loan_Detail.namevalue(i-1,"APLAMT");			//�����ܾ�
							dsT_Loan_Detail.namevalue(i,"APLAMT") = 0;
							dsT_Loan_Detail.namevalue(i,"APLRAT") = dsT_Loan_Detail.namevalue(i+1,"APLRAT");
							dsT_Loan_Detail.namevalue(i,"AMT_1")  = dsT_Loan_Detail.namevalue(i+1,"APLRAT");
							dsT_Loan_Detail.namevalue(i,"REASON") = dsT_Loan_Detail.namevalue(i-1,"REASON");			//����ݾ�
							i = i + 1;
						}

					}

					if(start_month.replace("-", "") <= dsT_Loan_Detail.namevalue(i,"APLDT").substring(0, 6)){
							dsT_Loan_Detail.namevalue(i,"APLDT") = ln_APLDT(i,dsT_Loan_Detail.namevalue(i-1,"APLDT"));	  //��ȯ����
					}

				}//FOR

			}//IF


			dsT_Loan_Temp.ClearData();

			var THeader = "ENO_NO:STRING(7),APPDT:STRING(10),APLDT:STRING(10),APPCNT:DECIMAL(3),APPAMT:DECIMAL(9),APLAMT:DECIMAL(9),APJAMT:DECIMAL(9),APLRAT:DECIMAL(9),REASON:STRING(50)";

			dsT_Loan_Temp.SetDataHeader(THeader);


	        for(i=1; i<=dsT_Loan_Detail.countrow; i++){

			dsT_Loan_Temp.addRow();
			dsT_Loan_Temp.namevalue(i,"ENO_NO") = dsT_Loan_Detail.namevalue(i,"ENO_NO");		//���
			dsT_Loan_Temp.namevalue(i,"APPDT")  = dsT_Loan_Detail.namevalue(i,"APPDT");			//��������
			dsT_Loan_Temp.namevalue(i,"APLDT")  = dsT_Loan_Detail.namevalue(i,"APLDT");			//��ȯ����
			dsT_Loan_Temp.namevalue(i,"APPCNT") = i;											//Ƚ��
			dsT_Loan_Temp.namevalue(i,"APPAMT") = dsT_Loan_Detail.namevalue(i,"APPAMT");		//����ݾ�
			dsT_Loan_Temp.namevalue(i,"APLAMT") = dsT_Loan_Detail.namevalue(i,"APLAMT");		//��ȯ����
			dsT_Loan_Temp.namevalue(i,"APJAMT") = dsT_Loan_Detail.namevalue(i,"APJAMT");		//�����ܾ�
			dsT_Loan_Temp.namevalue(i,"APLRAT") = dsT_Loan_Detail.namevalue(i,"APLRAT");		//��ȯ����
			dsT_Loan_Temp.namevalue(i,"REASON") = dsT_Loan_Detail.namevalue(i,"REASON");		//����ݾ�

			}

		}//FUNCTION



		/******************************************************************************
			Description : ��ȯ����
			              cnt - Ƚ��, aplday - ��ȯ����
		******************************************************************************/
		function ln_APLDT2(cnt,aplday) {

		   var yyyy="";
		   var mm="";
		   var dd="";

			yyyy = aplday.substr(0,4);
			mm=aplday.substr(4,2);
			dd = aplday.substr(6,2);


				if (mm=="12"){
						yyyy = Number(yyyy) + 1;
						mm="01";
		        return yyyy+mm+dd;
				}else{
		        mm = Number(mm) + 1;
						if(mm=="10"||mm=="11"||mm=="12"){
		        		}else{
							mm="0"+mm;
						}
				    return yyyy+mm+dd;
				}

		}

		/******************************************************************************
			Description : ��ȯ����
			              cnt - Ƚ��, aplday - ��ȯ����
		******************************************************************************/
		function ln_APLDT(cnt,aplday) {

		   var yyyy="";
		   var mm="";
		   var dd="";

			yyyy = aplday.substr(0,4);
			mm=aplday.substr(4,2);
			dd = aplday.substr(6,2);

			if(cnt==1){
				return aplday;
			}else{
				if (mm=="12"){
						yyyy = Number(yyyy) + 1;
						mm="01";
		        return yyyy+mm+dd;
				}else{
		        mm = Number(mm) + 1;
						if(mm=="10"||mm=="11"||mm=="12"){
		        		}else{
							mm="0"+mm;
						}
				    return yyyy+mm+dd;
				}
			}
		}


		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

		function fnc_APPLY() {

			var i = 1;

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_Loan_Master                     |
    | 3. Table List : dsT_Loan_Master               |
    +----------------------------------------------->
    <Object ID="dsT_Loan_Master" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_Loan_Detail                     |
    | 3. Table List : dsT_Loan_Detail               |
    +----------------------------------------------->
    <Object ID="dsT_Loan_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_Loan_Detail                     |
    | 3. Table List : dsT_Loan_Detail               |
    +----------------------------------------------->
    <Object ID="dsT_Loan_Temp" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_Loan_Detail                     |
    | 3. Table List : T_Loan_Detail                 |
    +----------------------------------------------->
    <Object ID ="trT_Loan_Detail" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_Loan_Detail Event="OnLoadCompleted(iCount)">

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_Loan_Detail Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_Loan_Detail Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=dsT_Loan_Detail Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = dsT_Loan_Detail.NameValue(1,"APLDT").trim();



			document.getElementById("txtSTR_YYMM_SHR").focus();
        }
    </Script>


    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_Loan_Detail event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_Loan_Detail event="OnFail()">
        cfErrorMsg(this);
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
<table width="550" border="0" cellspacing="0" cellpadding="0" leftmargin="20">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="20"></td>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">���ݻ�ȯ����</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/�����������/<font color="#000000">���ݻ�ȯ����</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->



<!-- ���� �Է� ���̺� ���� -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
 
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�ο�����</strong></td>
        <td class="paddingTop15">&nbsp;</td>
    </tr>
    <tr>
        <td class="paddingTop5" colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
				</colgroup>
				<tr>

					<td align="center" class="blueBold">����</td>
					<td class="padding2423">
					<input id="txtENO_NM" size="12"></td>

			        <td align="center" class="blueBold">�Ҽ�</td>
					<td class="padding2423">
					<input id="txtDPT_NM" size="12" ></td>

			        <td align="center" class="blueBold">����</td>
					<td class="padding2423">
					<input id="txtJOB_NM" size="12" ></td>

				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>���������</strong></td>
        <td class="paddingTop15">&nbsp;</td>
    </tr>
    <tr>
        <td class="paddingTop5" colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">�Ⱓ</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<tr>
								<td>
									<input id="txtSTR_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM_SHR','','75','112');"></a>
									&nbsp;~&nbsp;
									<input id="txtEND_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM_SHR','','190','112');"></a>

								    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelay','','../../images/button/btn_DeferlOver.gif',1)">
            						<img src="../../images/button/btn_DeferlOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delay()"></a>

								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->



<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>���λ���</strong></td>
        <td class="paddingTop15">&nbsp;</td>
    </tr>

    <tr>
		<td class="paddingTop5">
	    <table border="1" cellspacing="0" cellpadding="0">
		<tr align="center">
		    <td>
			<object id="grdT_Loan_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:250px;">
			    <param name="DataID"				value="dsT_Loan_Detail">
			    <param name="EdiTABLE"				value="false">
			    <param name="DragDropEnable"		value="true">
			    <param name="SortView"				value="Left">
			    <param name="VIEWSUMMARY"			value=1>
			    <param name="Format"				value="
					<C> Name='��'			ID={CURROW} 	HeadAlign=Center Width=35  		align=center	SumBgColor=#C3D0DB 	</C>
					<C> Name='�����ܾ�'		ID=APJAMT 		HeadAlign=Center Width=90	 	align=right		SumBgColor=#C3D0DB SumText='��'	</C>
					<C> Name='��ȯ����'		ID=APLDT 		HeadAlign=Center Width=95	 	align=center 	SumBgColor=#C3D0DB SumText=''  Mask = 'XXXX-XX-XX' </C>
					<C> Name='��ȯ����'		ID=APLAMT 		HeadAlign=Center Width=90	 	align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
					<C> Name='��ȯ����'		ID=APLRAT		HeadAlign=Center Width=90  		align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
					<C> Name='��ȯ��'		ID=AMT_1 		HeadAlign=Center Width=95		align=right 		SumBgColor=#C3D0DB SumText=@sum	</C>
			    ">
			</object>
		    </td>
		</tr>
	    </table>
	</td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
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

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                        |
    | 2. �̸� : bndT_Loan_Detail                    |
    | 3. Table List : T_AC_EMLOAN                   |
    +----------------------------------------------->
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_Loan_Detail">
		<Param Name="BindInfo", Value="
			<C>Col='ENO_NO'			Ctrl='txtENO_NO'		Param=value			</C>
			<C>Col='ENO_NM'			Ctrl='txtENO_NM'		Param=value			</C>
			<C>Col='DPT_NM'			Ctrl='txtDPT_NM'		Param=value			</C>
			<C>Col='JOB_NM'			Ctrl='txtJOB_NM'		Param=value			</C>
			<C>Col='APPDT'			Ctrl='txtAPP_YMD'		Param=value			</C>
			<C>Col='APPAMT'			Ctrl='txtAPP_AMT'		Param=text			</C>
			<C>Col='APLDT'			Ctrl='txtAPL_YMD'		Param=value			</C>
			<C>Col='REASON'			Ctrl='cmbREASON'		Param=value			</C>

	    ">
	</object>
