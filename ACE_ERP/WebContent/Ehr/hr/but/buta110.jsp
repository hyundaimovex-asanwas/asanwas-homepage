<!--
*****************************************************
* @source      : buta110.jsp
* @description : �ؿ���������ޱ��� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/15      ���뼺        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�ؿ���������ޱ���(buta110)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTFFTT';

        var today = getToday();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			//�˻�����
			var basic_ymd = document.getElementById("txtBASIC_YMD_SHR").value;		//������
            var but_city_cd = document.getElementById("cmbBUT_CITY_CD_SHR").value;  //������ CODE

			dsT_DI_OVERSEASBT_BASIS.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta110.cmd.BUTA110CMD&S_MODE=SHR&BASIC_YMD="+basic_ymd+"&BUT_CITY_CD="+but_city_cd;
			dsT_DI_OVERSEASBT_BASIS.reset();

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

			if(!fnc_SaveItemCheck()) return;

			trT_DI_OVERSEASBT_BASIS.KeyValue = "tr01(I:dsT_DI_OVERSEASBT_BASIS=dsT_DI_OVERSEASBT_BASIS)";
			trT_DI_OVERSEASBT_BASIS.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta110.cmd.BUTA110CMD&S_MODE=SAV";
			trT_DI_OVERSEASBT_BASIS.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_DI_OVERSEASBT_BASIS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var index_city = document.getElementById("cmbBUT_CITY_CD").selectedIndex;
            var index_job = document.getElementById("cmbJOB_CD_FROM").selectedIndex;

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            var msg = "[������:"
                    + document.getElementById("txtBASIC_YMD_SHR").value
                    + "/������:"
                    + dsT_CM_COMMON_LT.NameValue(dsT_CM_COMMON_LT.RowPosition, "CODE_NAME")
                    + "/����:"+document.getElementById("cmbJOB_CD_FROM")[index_job].text
                    + "] �ڷḦ �����Ͻðڽ��ϱ�?";
            if (confirm(msg) == false) return;
            dsT_DI_OVERSEASBT_BASIS.DeleteRow(dsT_DI_OVERSEASBT_BASIS.RowPosition);

			trT_DI_OVERSEASBT_BASIS.KeyValue = "SVL(I:dsT_DI_OVERSEASBT_BASIS=dsT_DI_OVERSEASBT_BASIS)";
			trT_DI_OVERSEASBT_BASIS.Action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta110.cmd.BUTA110CMD&S_MODE=SAV";
			trT_DI_OVERSEASBT_BASIS.post();
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
			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_DI_OVERSEASBT_BASIS.CountColumn < 1) {
                dsT_DI_OVERSEASBT_BASIS.setDataHeader(    "BASIC_YMD:STRING:KEYVALUETYPE"
                                                        +",BUT_CITY_CD:STRING:KEYVALUETYPE"
                                                        +",JOB_CD_FROM:STRING:KEYVALUETYPE"
                                                        +",JOB_CD_TO:STRING"
                                                        +",BUT_EXPENSE:DECIMAL"
                                                        +",BUT_LODGING:DECIMAL"
                                                        +",BUT_EXPENSE_OFFER:DECIMAL"
                                                        +",CURRENCY_CD:STRING"
                                                      );
            }
            dsT_DI_OVERSEASBT_BASIS.AddRow();
            document.getElementById("txtBASIC_YMD").focus();
            document.getElementById("txtBASIC_YMD").value = getToday();
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
			//�̰��� �ش� �ڵ� �Է� �ϼ���
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
            //document.getElementById("txtBASIC_YMD_SHR").value = "";	    //������
            document.getElementById("cmbBUT_CITY_CD_SHR").value = "";   //������ CODE
			dsT_DI_OVERSEASBT_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtBASIC_YMD_SHR").focus();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
			if (dsT_DI_OVERSEASBT_BASIS.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {
			var basic_ymd = document.getElementById("txtBASIC_YMD_SHR");
            if(basic_ymd.value == ""){
                alert("�������ڸ� �Է��ϼ���!");
                basic_ymd.focus();
                return false;
            }
            return true;
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
			if (!dsT_DI_OVERSEASBT_BASIS.IsUpdated) {
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
            cfStyleGrid(form1.grdT_DI_OVERSEASBT_BASIS,15,"false","false")      // Grid Style ����
            //������
            fnc_ConstructCommonCode("dsT_CM_COMMON_LT", "cmbBUT_CITY_CD_SHR");
            //fnc_ConstructCommonCode("dsT_CM_COMMON_LT", "cmbBUT_CITY_CD");
            //����
            //fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM");
                        //��������
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_FROM").add(oOption);
            }
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO");
            //����
            fnc_ConstructCommonCode("dsT_CM_COMMON_EX", "cmbCURRENCY_CD");
            document.getElementById("txtBASIC_YMD_SHR").value = getToday();
            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /****************************
         * 16. ���� �Է�(�̻��)    *
         ***************************/
		function fnc_InputCurrency() {
            if(document.getElementById("cmbBUT_CITY_CD").value == "KR"){
                alert("���ѹα��� ������ �� �����ϴ�!");
                document.getElementById("cmbBUT_CITY_CD").value = "";
                return;
            }
			if(document.getElementById("cmbBUT_CITY_CD").value == "JP"){
                document.getElementById("cmbCURRENCY_CD").value = "JPY";
            }else {
                document.getElementById("cmbCURRENCY_CD").value = "USD";
            }
		}

        var elementList = new Array(     "txtBASIC_YMD"
                                        ,"imgBASIC_YMD"
                                        ,"cmbBUT_CITY_CD"
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbJOB_CD_TO"
                                        ,"txtBUT_LODGING"
                                        ,"txtBUT_EXPENSE"
                                        ,"txtBUT_EXPENSE_OFFER"
                                        ,"cmbCURRENCY_CD" );

        var exceptionList = new Array(  // "txtBASIC_YMD"
                                        //,"imgBASIC_YMD"
                                         "cmbBUT_CITY_CD"
                                        ,"cmbJOB_CD_FROM");

        var keyList = new Array(         "txtBASIC_YMD"
                                        ,"cmbBUT_CITY_CD"   // ȭ�����
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbCURRENCY_CD" );
    </script>
    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERSEASBT_BASIS             |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ������ -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_LT"/>
       <jsp:param name="CODE_GUBUN"    value="LT"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ȯ�� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_EX"/>
       <jsp:param name="CODE_GUBUN"    value="EX"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_OVERSEASBT_BASIS)|
    | 3. ���Ǵ� Table List(T_DI_OVERSEASBT_BASIS)	        |
    +------------------------------------------------------->
    <Object ID ="trT_DI_OVERSEASBT_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtBASIC_YMD_SHR.focus();
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERSEASBT_BASIS Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������/������/����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("������/������/������ ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_OVERSEASBT_BASIS event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_OVERSEASBT_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_DI_OVERSEASBT_BASIS event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //�ű��� ���
            if(dsT_DI_OVERSEASBT_BASIS.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_DI_OVERSEASBT_BASIS event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_DI_OVERSEASBT_BASIS.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_DI_OVERSEASBT_BASIS.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }

            //���
            var exp = fnc_covNumber(dsT_DI_OVERSEASBT_BASIS.NameString(row, "BUT_LODGING"))
                    + fnc_covNumber(dsT_DI_OVERSEASBT_BASIS.NameString(row, "BUT_EXPENSE"))
                    + fnc_covNumber(dsT_DI_OVERSEASBT_BASIS.NameString(row, "BUT_EXPENSE_OFFER"));

            if(exp == 0) {
                alert("����� �ݵ�� �ϳ��� �Է��ϼž� �˴ϴ�.");
                document.getElementById("txtBUT_LODGING").focus();
                return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ؿ���������ޱ���</td>
					<td align="right" class="navigator">HOME/���°���/�ؿ�����/<font color="#000000">�ؿ���������ޱ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="160"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">������&nbsp;</td>
                                <td class="padding2423">
									<input id="txtBASIC_YMD_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBASIC_YMD_SHR','','40','110');"></a>
								</td>
                                <td class="searchState" align="right">��������&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbBUT_CITY_CD_SHR"  style="width='170';" onChange="fnc_SearchList()">
                                        <option value="">�� ü</option>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<input type="text" id="txtBASIC_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtBASIC_YMD.disabled == true) return; calendarBtn('datetype1','txtBASIC_YMD','','60','150');"></a>
					</td>
					<td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
									<comment id="__NSID__">
				<object id=cmbBUT_CITY_CD classid="clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197" height="120" width="130">
					<param name=ComboDataID		value="dsT_CM_COMMON_LT">
					<param name=SearchColumn	value="CODE">
					<param name=Sort			value="True">
					<param name=ListExprFormat	value="CODE^0^20,CODE_NAME^0^140">
					<param name=BindColumn		value="CODE">
					<param name=EditExprFormat 	value="% %;CODE;CODE_NAME">

					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>

					<!--
                        <select id="cmbBUT_CITY_CD"  style="width='100%';" onChange="">
                        </select>
						-->
                    </td>
					<td align="center" class="creamBold">����</td>
                    <td class="padding2423" colspan="3">
                        <select id="cmbJOB_CD_FROM"  style="width=100px" onChange="">
                        </select>
                        &nbsp;~&nbsp;
                        <select id="cmbJOB_CD_TO"  style="width=100px" onChange="">
                        </select>
                    </td>

				</tr>
                <tr>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <select id="cmbCURRENCY_CD"  style="width='100%';" onChange="">
                        </select>
                    </td>
					<td align="center" class="creamBold">���ں�</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="txtBUT_LODGING" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">�ϴ�</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="txtBUT_EXPENSE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">���������� �ϴ�</td>
					<td class="padding2423">
                        <comment id="__NSID__"><object id="txtBUT_EXPENSE_OFFER" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERSEASBT_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_OVERSEASBT_BASIS">
							<param name="Format"				value="
								<FC> id={currow}		    width=35    name='NO'		align=center </FC>
								<FC> id='BASIC_YMD'	    width=80	name='������'	align=center </FC>
								<FC> id='BUT_CITY_CD'	width=151	name='��������'	align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_LT:CODE:CODE_NAME'</FC>
                                <FC> id='JOB_CD_FROM'	width=71	name='���� From'	    align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_A2:CODE:CODE_NAME'</FC>
                                <FC> id='JOB_CD_TO'	    width=71	name='���� To'	    align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_A2:CODE:CODE_NAME'</FC>
                                <FC> id='CURRENCY_CD'    width=71    name='����'       align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_EX:CODE:CODE_NAME'</FC>
                                <FC> id='BUT_LODGING'    width=71   name='���ں�'  align=right     rightmargin=10</FC>
                                <FC> id='BUT_EXPENSE'	width=71	name='�ϴ�' 	align=right     rightmargin=10</FC>
                                <FC> id='SUM'	        width=71	name='�հ�'	    align=right	Value={BUT_LODGING+BUT_EXPENSE}      rightmargin=10</FC>
                                <C> id='BUT_EXPENSE_OFFER'	width=71	name='����������'	align=right     rightmargin=10</C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �ؿ������ ���ޱ��� ���̺� -->
<object id="bndT_DI_OVERSEASBT_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_OVERSEASBT_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=BASIC_YMD      	    Ctrl=txtBASIC_YMD      	    Param=value </C>
		<C>Col=BUT_CITY_CD		    Ctrl=cmbBUT_CITY_CD	   	    Param=BindColVal	</C>
		<C>Col=JOB_CD_FROM  		Ctrl=cmbJOB_CD_FROM 	    Param=value	</C>
		<C>Col=JOB_CD_TO    		Ctrl=cmbJOB_CD_TO 	        Param=value	</C>
		<C>Col=BUT_LODGING		    Ctrl=txtBUT_LODGING 	    Param=Text	</C>
		<C>Col=BUT_EXPENSE		    Ctrl=txtBUT_EXPENSE		    Param=Text	</C>
        <C>Col=BUT_EXPENSE_OFFER    Ctrl=txtBUT_EXPENSE_OFFER	Param=Text	</C>
        <C>Col=CURRENCY_CD          Ctrl=cmbCURRENCY_CD        	Param=value	</C>
    '>
</object>