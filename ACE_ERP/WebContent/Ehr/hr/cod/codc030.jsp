<!--
*****************************************************
* @source       : codc030.jsp
* @description : ���������Ѱ��� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/03      ������        �����ۼ�.(������ �ݵ�� ���°����� �μ�������ڵ�ϰ��� ����)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String LAW_AUTHO    = box.getString("SESSION_LAW_AUTHO");
    String ROLE_CD      = box.getString("SESSION_ROLE_CD");
%>

<html>
<head>
<title>���������Ѱ���</title>
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

		var btnList = 'TFTTFFFT';
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

<%
    //�ƹ��� ������ ������ ��ȸ�� �� ����.
    if(!ROLE_CD.equals("1001")
            && !ROLE_CD.equals("1002")
            && !LAW_AUTHO.equals("M")) {
%>
            alert("��ȸ �� �� �ִ� ������ �����ϴ�.");
            return;
<%
    } else {
%>

			//�˻����� 3����
			var service = document.form1.cmbSERVICE_SHR.value;		//���
			var eno_no = document.form1.txtENO_NO_SHR.value;		//���
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;		//�Ҽ�
			var autho = document.form1.cmbAUTHO_SHR.value;	//�򰡱׷�

			//���� �� ���� ��� ���� ��ȸ
			dsT_CM_EMPLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc030.cmd.CODC030CMD&S_MODE=SHR&SERVICE="+service+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&AUTHO="+autho;
			dsT_CM_EMPLIST.reset();
<%
    }
%>
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

			var service = document.form1.cmbSERVICE_SHR.value;		//���

			trT_CM_EMPLIST.KeyValue = "tr01(I:dsT_CM_EMPLIST=dsT_CM_EMPLIST)";
			trT_CM_EMPLIST.action = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc030.cmd.CODC030CMD&S_MODE=SAV&SERVICE="+service;
			trT_CM_EMPLIST.post();

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

			document.getElementById("cmbSERVICE_SHR").selectedIndex = 0;
			document.getElementById("txtENO_NO_SHR").value = '';
			document.getElementById("txtENO_NM_SHR").value = '';
			document.getElementById("txtDPT_CD_SHR").value = '';
			document.getElementById("txtDPT_NM_SHR").value = '';
			document.getElementById("cmbAUTHO_SHR").value = '';

			document.getElementById("resultMessage").innerText = ' ';
			dsT_CM_EMPLIST.ClearAll();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CM_EMPLIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_CM_EMPLIST.IsUpdated) {
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

			cfStyleGrid(form1.grdT_CM_EMPLIST,15,"false","false")      // Grid Style ����

			document.form1.txtENO_NO_SHR.focus();

            //Role �ڵ带 ������Ų��.
            var oSelect = document.getElementById("cmbROLE_CD");
            var oOption = null;
            for(var i = 1; i <= dsT_CM_COMMON_RL.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_RL.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_RL.NameValue(i,"CODE_NAME");

                if(oOption.value < "2100")
                    oSelect.add(oOption);
            }


            //Service �ڵ带 ������Ų��.
            oSelect = document.getElementById("cmbSERVICE_SHR");
            for(var i = 0; i < serviceCdList.length; i++ ) {
<%
    //�������� �������� ��� ���� �� ������ ������Ŵ (Role ������ ���� ��� Role ������ �켱�� )
    if(!(ROLE_CD.equals("1001") || ROLE_CD.equals("1002")) && LAW_AUTHO.equals("M")) {
%>
                if(serviceCdList[i] != "LAW")
                    continue;
<%
    }
%>
                oOption       = document.createElement("OPTION");
                oOption.value = serviceCdList[i];
                oOption.text  = serviceNmList[i];

                oSelect.add(oOption);
            }

            fnc_ChangeStateElement(false, "cmbAUTHO_SHR");
            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * ������ ��ü�϶��� ���ѿ��� ������� ��ȸ��Ŵ
         */
        function fnc_checkAuthoType() {
            var oSERVICE_SHR = document.getElementById("cmbSERVICE_SHR");
            var oAUTHO_SHR = document.getElementById("cmbAUTHO_SHR");
            var oOption = null;

            if(oSERVICE_SHR.value == "") {
                oAUTHO_SHR.selectedIndex = 0;
                fnc_ChangeStateElement(false, "cmbAUTHO_SHR");
            } else {
                fnc_ChangeStateElement(true, "cmbAUTHO_SHR");
            }
        }


        //���� �ڵ�
        var serviceCdList = new Array(   "LAW"
                                        ,"EDU"
                                        ,"PLN"
                                        ,"SEL"
                                        ,"EIS"
                                        ,"CON"
                                        ,"YAC"
                                        ,"L3" );
        //���� �̸�
        var serviceNmList = new Array(   "����"
                                        ,"����"
                                        ,"�����ȹ"
                                        ,"��������"
                                        ,"EIS"
                                        ,"�ܵ�"
                                        ,"��������"
                                        ,"���������" );

        //�Է�â ����Ʈ
        var elementList = new Array( "cmbLAW_AUTHO"
                                    ,"cmbEDU_AUTHO"
                                    ,"cmbPLN_AUTHO"
                                    ,"cmbSEL_AUTHO"
                                    ,"cmbEIS_AUTHO"
                                    ,"cmbCON_AUTHO"
                                    ,"cmbYAC_AUTHO"
                                    ,"cmbL3_AUTHO"
                                    ,"cmbROLE_CD"   );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_CM_EMPLIST                      |
    | 3. Table List : T_CM_EMPLIST                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_RL"/>
       <jsp:param name="CODE_GUBUN"    value="RL"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_CM_EMPLIST)		|
    | 3. ���Ǵ� Table List(T_CM_EMPLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtENO_NO_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_CM_EMPLIST.focus();

            fnc_EnableElementAll(elementList);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_EMPLIST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_EMPLIST event="OnFail()">
        cfErrorMsg(this);
    </script>





    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_CM_EMPLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
<%
    //��ü �������� ��� ��� �޴��� ���� �� ����� �����ϰ� �Ѵ�.
    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")) {
%>
            fnc_EnableElementAll(elementList);
<%
    }
    //���� �������� ��� ���� ���Ѹ� ������ �����ϰ� Ǯ���ش�.
    else if(LAW_AUTHO.equals("M")) {
%>
            fnc_ChangeStateElement(true, "cmbLAW_AUTHO");
<%
    }
%>

            //��ȸ�� ROW�� ���� �������ΰ�� �������ϰ� ���´�.
            if(dsT_CM_EMPLIST.NameString(row, "LAW_AUTHO") == "M")
                fnc_ChangeStateElement(false, "cmbLAW_AUTHO");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���������Ѱ���</td>
					<td align="right" class="navigator">HOME/��������/���Ѱ���/<font color="#000000">���������Ѱ���</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="40"></col>
                                <col width="170"></col>
                                <col width="50"></col>
                                <col width="180"></col>
                                <col width="50"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbSERVICE_SHR" name="cmbSERVICE_SHR" style="WIDTH: 85%" onChange="fnc_checkAuthoType();fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
										<option value="">�� ü</option>
                                    </select>
								</td>
                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">�Ҽ�&nbsp;</td>
                                <td class="padding2423">
                                    <input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbAUTHO_SHR" name="cmbAUTHO_SHR" style="WIDTH: 85%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
										<option value=''>�� ü</option>
										<option value='N'>����</option>
										<option value='S'>�ش�Ҽ�</option>
										<option value='A'>���Ҽ�</option>
                                        <option value='M'>MASTER</option>
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
                    <col width="110"></col>
                    <col width="90"></col>
                    <col width="100"></col>
                    <col width="90"></col>
                    <col width="100"></col>
                    <col width="90"></col>
                    <col width="100"></col>
                    <col width=""></col>
                </colgroup>
				<tr>
                    <td align="center" class="creamBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input type="hidden" id=txtDPT_CD name=txtDPT_CD>
                        <input id=txtDPT_NM name=txtDPT_NM style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423">
                        <input id=txtENO_NO name=txtENO_NO style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id=txtENO_NM name=txtENO_NM style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
						<select id="cmbLAW_AUTHO" name="cmbLAW_AUTHO" style="width:90px">
							<option value=''>����</option>
							<option value='S'>�ش�Ҽ�</option>
							<option value='A'>���Ҽ�</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
						<select id="cmbEDU_AUTHO" name="cmbEDU_AUTHO" style="width:90px">
							<option value=''>����</option>
							<option value='S'>�ش�Ҽ�</option>
							<option value='A'>���Ҽ�</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">�����ȹ����</td>
                    <td class="padding2423">
						<select id="cmbPLN_AUTHO" name="cmbPLN_AUTHO" style="width:90px">
							<option value=''>����</option>
							<option value='S'>�ش�Ҽ�</option>
							<option value='A'>���Ҽ�</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">�������񽺱���</td>
                    <td class="padding2423">
						<select id="cmbSEL_AUTHO" name="cmbSEL_AUTHO" style="width:90px">
							<option value=''>����</option>
							<option value='S'>�ش�Ҽ�</option>
							<option value='A'>���Ҽ�</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">EIS����</td>
                    <td class="padding2423">
						<select id="cmbEIS_AUTHO" name="cmbEIS_AUTHO" style="width:90px">
							<option value=''>����</option>
							<option value='M'>�����ֱ�</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">�ܵ�����</td>
                    <td class="padding2423">
                        <select id="cmbCON_AUTHO" name="cmbCON_AUTHO" style="width:90px">
                            <option value=''>����</option>
                            <option value='M'>�����ֱ�</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">�����������</td>
                    <td class="padding2423">
                        <select id="cmbYAC_AUTHO" name="cmbYAC_AUTHO" style="width:90px">
                            <option value=''>����</option>
                            <option value='M'>�����ֱ�</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">����/�μ������</td>
                    <td class="padding2423">
                        <select id="cmbL3_AUTHO" name="cmbLAW_AUTHO" style="width:90px">
                            <option value=''>����</option>
                            <option value='M'>������ ����</option>
                            <option value='A'>�μ��� ����</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">ROLE����</td>
                    <td class="padding2423" colspan="7">
						<select id="cmbROLE_CD" name="cmbROLE_CD" style="width:90px">
							<option value=''>����</option>
                        </select>
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
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CM_EMPLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
							<param name="DataID"				value="dsT_CM_EMPLIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<FC> id={currow}		width=29		name='NO'		        align=center					    </FC>
                                <FC> id='DPT_NM'        width=90        name='�Ҽ�'             align=center        Edit=None       </FC>
                                <FC> id='JOB_NM'        width=50        name='����'             align=center        Edit=None       </FC>
                                <FC> id='ENO_NO'        width=70        name='���'             align=center        Edit=None       </FC>
                                <FC> id='ENO_NM'        width=70        name='����'             align=center        Edit=None       </FC>
                                <C>  id='LAW_AUTHO'      width=68        name='����'             align=center        Edit=none       Value={Decode(LAW_AUTHO, 'S', '�ش�Ҽ�', 'A', '���Ҽ�', 'M', 'MASTER')} </C>
<%
    if(ROLE_CD.equals("1001")){
%>
                                <C> id='EDU_AUTHO'      width=68        name='����'             align=center        Edit=none       Value={Decode(EDU_AUTHO, 'S', '�ش�Ҽ�', 'A', '���Ҽ�')}                </C>
                                <C> id='PLN_AUTHO'      width=68        name='�����ȹ'         align=center        Edit=none       Value={Decode(PLN_AUTHO, 'S', '�ش�Ҽ�', 'A', '���Ҽ�')}                </C>
                                <C> id='SEL_AUTHO'      width=68        name='��������'       align=center        Edit=none       Value={Decode(SEL_AUTHO, 'S', '�ش�Ҽ�', 'A', '���Ҽ�')}                </C>
                                <C> id='EIS_AUTHO'      width=68        name='EIS'              align=center        Edit=none       Value={Decode(EIS_AUTHO, 'M', 'MASTER')}                                   </C>
                                <C> id='CON_AUTHO'      width=68        name='�ܵ�'             align=center        Edit=none       Value={Decode(CON_AUTHO, 'M', 'MASTER')}                                   </C>
                                <C> id='YAC_AUTHO'      width=68        name='��������'         align=center        Edit=none       Value={Decode(YAC_AUTHO, 'M', 'MASTER')}                                   </C>
                                <C> id='L3_AUTHO'       width=68        name='���������'       align=center        Edit=none       Value={Decode(L3_AUTHO,  'M', '������ ����', 'A', '�μ��� ����')}                </C>
                                <C> id='ROLE_CD'        width=68        name='ROLE'             align=center        Edit=none       EditStyle=Lookup   Data='dsT_CM_COMMON_RL:CODE:CODE_NAME'                  </C>
<% } %>

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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_CM_EMPLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_EMPLIST">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO      	    Ctrl=txtENO_NO      	Param=value  Disable=disabled</C>
		<C>Col=ENO_NM		    Ctrl=txtENO_NM	      	Param=value</C>
		<C>Col=DPT_NM    	    Ctrl=txtDPT_NM      	Param=value</C>
		<C>Col=JOB_NM		    Ctrl=txtJOB_NM      	Param=value</C>
        <C>Col=LAW_AUTHO        Ctrl=cmbLAW_AUTHO       Param=value</C>
        <C>Col=DOC_AUTHO        Ctrl=cmbDOC_AUTHO       Param=value</C>
        <C>Col=EDU_AUTHO        Ctrl=cmbEDU_AUTHO       Param=value</C>
        <C>Col=PLN_AUTHO        Ctrl=cmbPLN_AUTHO       Param=value</C>
        <C>Col=SEL_AUTHO        Ctrl=cmbSEL_AUTHO       Param=value</C>
        <C>Col=EIS_AUTHO        Ctrl=cmbEIS_AUTHO       Param=value</C>
        <C>Col=CON_AUTHO        Ctrl=cmbCON_AUTHO       Param=value</C>
        <C>Col=YAC_AUTHO        Ctrl=cmbYAC_AUTHO       Param=value</C>
        <C>Col=L3_AUTHO         Ctrl=cmbL3_AUTHO        Param=value</C>
        <C>Col=ROLE_CD          Ctrl=cmbROLE_CD         Param=value</C>
    '>
</object>