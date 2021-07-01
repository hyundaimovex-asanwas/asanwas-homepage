<!--
*****************************************************
* @source      : misc330.jsp
* @description : �����ȹ���ذ��� PAGE
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
<title>�����ȹ���ذ���(misc330)</title>
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
			var basic_ymd    = document.getElementById("txtBASIC_YMD_SHR").value;		//������
            var bas_cd      = document.getElementById("cmbBAS_CD_SHR").value;  //������ CODE

			dsT_MI_BASIS.dataid = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc330.cmd.MISC330CMD&S_MODE=SHR&BASIC_YMD="+basic_ymd+"&BAS_CD="+bas_cd;
			dsT_MI_BASIS.reset();
            
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

			trT_MI_BASIS.KeyValue = "tr01(I:dsT_MI_BASIS=dsT_MI_BASIS)";
			trT_MI_BASIS.action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc330.cmd.MISC330CMD&S_MODE=SAV";
			trT_MI_BASIS.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_MI_BASIS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var basType     = document.getElementById("rdoBAS_TYPE").CodeValue;
            var index_bas   = document.getElementById("cmbBAS_CD").selectedIndex;
            var index_job   = document.getElementById("cmbJOB_CD_FROM").selectedIndex;

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            var msg = "������:"
                    + document.getElementById("txtBASIC_YMD_SHR").value
                    + "\n�����ȹ:"
                    + document.getElementById("cmbBAS_CD")[index_bas].text
                    + (basType == "J" ? "\n����:"+document.getElementById("cmbJOB_CD_FROM")[index_job].text : "\n���س⵵:"+document.getElementById("txtBAS_YY_FROM").value)
                    + "\n�ڷḦ �����Ͻðڽ��ϱ�?";
            if (confirm(msg) == false) return;
            dsT_MI_BASIS.DeleteRow(dsT_MI_BASIS.RowPosition);

			trT_MI_BASIS.KeyValue = "SVL(I:dsT_MI_BASIS=dsT_MI_BASIS)";
			trT_MI_BASIS.Action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc330.cmd.MISC330CMD&S_MODE=SAV";
			trT_MI_BASIS.post();

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
            if (dsT_MI_BASIS.CountColumn < 1) {
                dsT_MI_BASIS.setDataHeader(   "BASIC_YMD:STRING"
                                            +",BAS_CD:STRING"
                                            +",BAS_TYPE:STRING"
                                            +",JOB_CD_FROM:STRING"
                                            +",JOB_CD_TO:STRING"
                                            +",BAS_YY_FROM:STRING"
                                            +",BAS_YY_TO:STRING"
                                            +",BAS_AMT:DECIMAL"
                                          );
            }

            dsT_MI_BASIS.AddRow();
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("cmbBAS_CD_SHR").value = "";   //������ CODE

			dsT_MI_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtBASIC_YMD_SHR").focus();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_MI_BASIS.IsUpdated)  {

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

			if (!dsT_MI_BASIS.IsUpdated) {
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
            cfStyleGrid(form1.grdT_MI_BASIS,15,"false","false")      // Grid Style ����

            //����
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM");
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO");
            
            //���ޱ���
            fnc_ConstructCommonCode("dsT_CM_COMMON_MI", "cmbBAS_CD_SHR");
            fnc_ConstructCommonCode("dsT_CM_COMMON_MI", "cmbBAS_CD");

            document.getElementById("txtBASIC_YMD_SHR").value = getToday();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
        
        /**
         * ���������� ���� �Է�â ��ȭ
         * @param - isClear �ʱ�ȭ�� ��ų ������ ���θ� ����
         */
        function fnc_ChangeType(isClear) {
            if(isClear == ""
                    || isClear == null
                    || isClear == undefined)
                isClear = false;
        
            var basType = document.getElementById("rdoBAS_TYPE").CodeValue;
            var row     = dsT_MI_BASIS.RowPosition;
        
            fnc_ChangeStateElement(false, "cmbJOB_CD_FROM"  );
            fnc_ChangeStateElement(false, "cmbJOB_CD_TO"    );
            fnc_ChangeStateElement(false, "txtBAS_YY_FROM"  );
            fnc_ChangeStateElement(false, "txtBAS_YY_TO"    );
            
            //������������ �˻�
            if(basType == "J") {
                if(dsT_MI_BASIS.RowStatus(row) == "1")
                    fnc_ChangeStateElement(true, "cmbJOB_CD_FROM"  );
                fnc_ChangeStateElement(true, "cmbJOB_CD_TO"    );
                
                if(isClear) {
                    document.getElementById("txtBAS_YY_FROM").value = "";
                    document.getElementById("txtBAS_YY_TO").value = "";
                }
            } 
            //�⵵�������� �˻�
            else if(basType == "Y") {
                if(dsT_MI_BASIS.RowStatus(row) == "1")
                    fnc_ChangeStateElement(true, "txtBAS_YY_FROM"  );
                fnc_ChangeStateElement(true, "txtBAS_YY_TO"    );
                
                if(isClear) {
                    document.getElementById("cmbJOB_CD_FROM").value = "";
                    document.getElementById("cmbJOB_CD_TO").value = "";
                }
            }
        }


        var elementList = new Array(     "txtBASIC_YMD"
                                        ,"imgBASIC_YMD"
                                        ,"cmbBAS_CD"
                                        ,"rdoBAS_TYPE"
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbJOB_CD_TO"
                                        ,"txtBAS_YY_FROM"
                                        ,"txtBAS_YY_TO"
                                        ,"medBAS_AMT" );

        var exceptionList = new Array(   "txtBASIC_YMD"
                                        ,"imgBASIC_YMD"
                                        ,"cmbBAS_CD"
                                        ,"rdoBAS_TYPE");

        var keyList = new Array(         "txtBASIC_YMD"
                                        ,"cmbBAS_CD"   
                                        ,"rdoBAS_TYPE"
                                        ,"medBAS_AMT" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_MI_BASIS             |
    | 3. Table List : T_MI_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_MI_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ���ޱ��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_MI"/>
       <jsp:param name="CODE_GUBUN"    value="MI"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="TA2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_MI_BASIS)|
    | 3. ���Ǵ� Table List(T_MI_BASIS)	        |
    +------------------------------------------------------->
    <Object ID ="trT_MI_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_MI_BASIS Event="OnLoadCompleted(iCount)">

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
    <Script For=dsT_MI_BASIS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_BASIS Event="OnDataError()">

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
    <script for=trT_MI_BASIS event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_MI_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!--------------------------+
    | ���� ��ư Ŭ���� �߻��ϴ� �̺�Ʈ ó��  |
    +--------------------------->
    <script language=JavaScript for=rdoBAS_TYPE event=OnSelChange()>
        //���������� ���� ó�� ����
        fnc_ChangeType(true);
    </script>



    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_MI_BASIS event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
        
            //�ű��� ���
            if(dsT_MI_BASIS.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }

            //���������� ���� ó�� ����
            fnc_ChangeType();
        }
    </script>


    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_MI_BASIS event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_MI_BASIS.NameString(row, colName) == "" ) {
                    alert("[ " +colName + grdT_MI_BASIS.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
                
                //���������� ���� ó��
                if(colName == "BAS_TYPE") {
                    if(dsT_MI_BASIS.NameString(row, colName) == "J"
                            && document.getElementById("cmbJOB_CD_FROM").value == "") {
                        alert("���� From �� �Է� �ϼž� �˴ϴ�.");
                        document.getElementById("cmbJOB_CD_FROM").focus();
                        return;   
                    }
                    
                    if(dsT_MI_BASIS.NameString(row, colName) == "Y"
                            && document.getElementById("txtBAS_YY_FROM").value == "") {
                        alert("���س⵵ From �� �Է� �ϼž� �˴ϴ�.");
                        document.getElementById("txtBAS_YY_FROM").focus();
                        return;   
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ȹ���ذ���</td>
					<td align="right" class="navigator">HOME/�濵����/�����ȹ/�޻󿩰�ȹ/<font color="#000000">�����ȹ���ذ���</font></td>
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
                                    <select id="cmbBAS_CD_SHR"  style="width='170';" onChange="fnc_SearchList()">
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
					<col width="130"></col>
					<col width="80"></col>
					<col width="230"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<input type="text" id="txtBASIC_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtBASIC_YMD.disabled == true) return; calendarBtn('datetype1','txtBASIC_YMD','','60','150');"></a>
					</td>
					<td align="center" class="creamBold">�����ȹ</td>
                    <td class="padding2423">
                        <select id="cmbBAS_CD"  style="width='100%';" onChange="">
                        </select>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                <tr>
                
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <comment id="__NSID__">
						<object id=rdoBAS_TYPE classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:20; width:120">
							<param name=AutoMargin	value="true">
							<param name=Cols		value="2">
							<param name=Format		value="J^������,Y^�⵵��">
						</object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <select id="cmbJOB_CD_FROM"  style="width=100px" onChange="">
                        </select>
                        &nbsp;~&nbsp;
                        <select id="cmbJOB_CD_TO"  style="width=100px" onChange="">
                        </select>
                    </td>
                    
                    <td align="center" class="creamBold">���س⵵</td>
                    <td class="padding2423">
                        <input id="txtBAS_YY_FROM" size="9" maxlength= "3" onkeypress="cfCheckNumber();" style="ime-mode:disabled;text-align:right;">
                        &nbsp;~&nbsp;
                        <input id="txtBAS_YY_TO" size="9" maxlength= "3" onkeypress="cfCheckNumber();" style="ime-mode:disabled;text-align:right;">
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
						<object	id="grdT_MI_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_MI_BASIS">
							<param name="Format"				value="
                                <FC> id={currow}            width=35    name='NO'           align=center    </FC>
                                <FC> id='BASIC_YMD'         width=90    name='������'       align=center    </FC>
                                <FC> id='BAS_CD'            width=160   name='�����ȹ'     align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_MI:CODE:CODE_NAME'</FC>
                                <FC> id='BAS_TYPE'          width=81    name='��������'     align=center    value={decode(BAS_TYPE, 'J', '������', 'Y', '�⵵��')} </FC>
                                <FC> id='JOB_CD_FROM'       width=81    name='���� From'    align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_A2:CODE:CODE_NAME'</FC>
                                <FC> id='JOB_CD_TO'         width=81    name='���� To'      align=center    EditStyle=Lookup  Data='dsT_CM_COMMON_A2:CODE:CODE_NAME'</FC>
                                <FC> id='BAS_YY_FROM'       width=81    name='�⵵ From'    align=right     rightmargin=10 </FC>
                                <FC> id='BAS_YY_TO'         width=81    name='�⵵ To'      align=right     rightmargin=10 </FC>
                                <C>  id='BAS_AMT'           width=81    name='��������'     align=right     rightmargin=10 </C>
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
<object id="bndT_MI_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_MI_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=BASIC_YMD      	    Ctrl=txtBASIC_YMD      	    Param=value </C>
		<C>Col=BAS_CD		        Ctrl=cmbBAS_CD	   	        Param=value	</C>
        <C>Col=BAS_TYPE             Ctrl=rdoBAS_TYPE            Param=CodeValue</C>
		<C>Col=JOB_CD_FROM  		Ctrl=cmbJOB_CD_FROM 	    Param=value	</C>
		<C>Col=JOB_CD_TO    		Ctrl=cmbJOB_CD_TO 	        Param=value	</C>
		<C>Col=BAS_YY_FROM  		Ctrl=txtBAS_YY_FROM 	    Param=value	</C>
		<C>Col=BAS_YY_TO    		Ctrl=txtBAS_YY_TO 	        Param=value	</C>
		<C>Col=BAS_AMT		        Ctrl=medBAS_AMT 	        Param=Text	</C>
    '>
</object>