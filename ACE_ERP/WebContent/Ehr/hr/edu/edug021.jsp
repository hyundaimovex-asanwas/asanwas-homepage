<!--
    ************************************************************************************
    * @Source         : edug021.jsp                                                    *
    * @Description    : ��ȹ��� PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2017/04/04      �̵���        �����ۼ�
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>OJT��ȹ���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

<script language=javascript src="../../common/common.js"></script>
<script language=javascript src="../../common/result.js"></script>
<script language=javascript src="../../common/input.js"></script>
<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var opener = window.dialogArguments;
        
        var flag   = '';                       // 0: ��ȸ, 1: ����/����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO  = opener.eno_no;

            flag = '0';

            dsT_CD_OJT.ClearData();

            dsT_CD_OJT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug020.cmd.EDUG020CMD&S_MODE=SHR_21&ENO_NO="+ENO_NO;
            dsT_CD_OJT.Reset();

            form1.grdT_CD_OJTPLAN.Focus();

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
        	
            if(fnc_SaveItemCheck()) {

                flag = '1';

                trT_CD_OJT.KeyValue = "SVL(I:SAV=dsT_CD_OJTPLAN)";
                trT_CD_OJT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug020.cmd.EDUG020CMD&S_MODE=SAV_21";
                trT_CD_OJT.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            var status = "";

            // ��ǥ
            if(dsT_CD_OJTPLAN.CountRow < 1) {
                alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
                return;
            }

            status = dsT_CD_OJTPLAN.RowStatus(dsT_CD_OJTPLAN.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CD_OJTPLAN.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            if(confirm("��ǥ���� ["+dsT_CD_OJTPLAN.RowPosition +"]�� �����͸� �����Ͻðڽ��ϱ�?")){
                dsT_CD_OJTPLAN.DeleteRow(dsT_CD_OJTPLAN.RowPosition);
            }

            if (status != "1")    {

                flag = '2';

                trT_CD_OJT.KeyValue = "SVL(I:DEL=dsT_CD_OJTPLAN)";
                trT_CD_OJT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug020.cmd.EDUG020CMD&S_MODE=DEL_21";
                trT_CD_OJT.post();
            }

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CD_OJTPLAN.IsUpdated) {

                alert("* ������ ������ �����ϴ�.");
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CD_OJTPLAN,0,"true","false");

            //�İ����� ��쿡�� ��ϰ����ϰ�
            if(gusrid != opener.eno_no) {
            	
                form1.grdT_CD_OJTPLAN.Enabled = false;


            }

            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJTPLAN.IsUpdated )
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList();

            window.close();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

         function fnc_BuildOJTPLAN() {

			var tmpStrYmd;
			var tmpEndYmd;
			for(var i=0; i<3; i++){
				tmpStrYmd = shiftTime(document.getElementById("txtSTR_YMD").value, i*7);
				tmpEndYmd = shiftTime(document.getElementById("txtSTR_YMD").value, ((i+1)*7)-1);

	            dsT_CD_OJTPLAN.AddRow();
	            dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,'ENO_NO') = opener.eno_no;
            	dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"TRA_WEEK") = dsT_CD_OJTPLAN.CountRow;
	            dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,'TRA_ENO_NO') = document.getElementById("txtTRA_ENO_NO").value;
	            dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,'TRA_ENO_NM') = document.getElementById("txtTRA_ENO_NM").value;
            	dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"STR_YMD") = tmpStrYmd;
            	dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"END_YMD") = tmpEndYmd;

	            document.form1.grdT_CD_OJTPLAN.SetColumn(form1.grdT_CD_OJTPLAN.getColumnID(0));

			}

        }

        //�����Ͽ��� iday��ŭ ������
		function shiftTime(p_value, iday) {
			var gs_DateStr = p_value.replaceStr("-","");
			var go_Date = null;
			if (gs_DateStr.length == 8) {	//�����
				go_Date = new Date(gs_DateStr.substring(0,4), gs_DateStr.substring(4,6) -1, gs_DateStr.substring(6,8));
				go_Date.setDate(go_Date.getDate()+iday);
				var tmpYear = go_Date.getYear();
				if (tmpYear < 2000)
				{
					tmpYear = "19" + go_Date.getYear();
				}

				var ls_DateStr = tmpYear + "";
				ls_DateStr += "-";

				if (go_Date.getMonth()+1 < 10) {
					ls_DateStr += "0" + (go_Date.getMonth()+1);
				} else {
					ls_DateStr += "" + (go_Date.getMonth()+1);
				}
				ls_DateStr += "-";

				if (go_Date.getDate() < 10) {
					ls_DateStr += "0" + go_Date.getDate();
				} else {
					ls_DateStr += "" + go_Date.getDate();
				}
			}

			return ls_DateStr;
		}

		function fnc_UsrGetEnoNm() {

            var obj = new String();

            obj = fnc_GetEnoNm("txtPlanTRA_ENO_NO");

            document.getElementById("txtPlanTRA_ENO_NO").value = obj.eno_no;
            document.getElementById("txtPlanTRA_ENO_NM").value = obj.eno_nm;
        }

        function fnc_UsrGetEnoNo() {

        	fnc_GetEnoNo('txtPlanTRA_ENO_NM', 'txtPlanTRA_ENO_NO');
        	fnc_UsrGetEnoNm();

        }

        function fnc_Popup() {
            var obj = new String();

                // ������ �����ڸ�
                obj = fnc_emplPopup('txtPlanTRA_ENO_NO','txtPlanTRA_ENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtPlanTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtPlanTRA_ENO_NM").value = obj.eno_nm;

        }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTOPLAN) |
    | 3. ���Ǵ� Table List(T_CD_MENTOPLAN)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTO)     |
    | 3. ���Ǵ� Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CD_OJT                    |
    | 3. Table List : T_CD_MENTO                |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_OJT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        	fnc_BuildOJTPLAN();

        } else {

        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTPLAN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTPLAN Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {

            alert("�ش� �ʼ��Է��׸�[����] �Է� �� ���� �۾��� �����մϴ�.");

        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">

        var ENO_NO  = opener.eno_no;

        if (iCount > 0) {
        	var today = getToday().replace("-","").replace("-","");
        	var STR_YMD = dsT_CD_OJT.NameValue(1, "STR_YMD").replace("-","").replace("-","");
        	var END_YMD = dsT_CD_OJT.NameValue(1, "END_YMD").replace("-","").replace("-","");

            if (STR_YMD > today || END_YMD < today) {

                form1.grdT_CD_OJTPLAN.Enabled = false;

            }

            trT_CD_OJT.KeyValue = "tr01(O:SHR_22=dsT_CD_OJTPLAN)";
            trT_CD_OJT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug020.cmd.EDUG020CMD&S_MODE=SHR_22&ENO_NO="+ENO_NO;
            trT_CD_OJT.post();

        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CD_OJT event="OnSuccess()">

        // ������ ��� ����ȸ
        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CD_OJT event="OnFail()">

        cfErrorMsg(this);
        flag = '';

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">   <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
        	<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�����</td>
                    <td align="center" class="blueBold">���</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold"></td>
                    <td align="center" class="blueBold">�Ի���</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtHIR_YMD" name="txtHIR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">å���������</td>
                    <td align="center" class="blueBold">���</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">OJT</td>
                    <td align="center" class="blueBold">�Ⱓ</td>
                    <td class="padding2423">
                    	<input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly> ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�μ�</td>
                    <td class="padding2423" colspan="3">
                    	<input id="txtTRA_DPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_DPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="blueBold"></td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                    	<input id="txtHEAD_EMP_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtHEAD_EMP_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">������</td>
                    <td class="padding2423" colspan="3">
						<input id="txtTRA_DUTY" size="53" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="blueBold"></td>
                    <td align="center" class="blueBold">������ǥ</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtEDU_GOAL1" size="100" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL2" size="100" class="input_ReadOnly" readonly>
                    	<input id="txtEDU_GOAL3" size="100" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������ȹǥ</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
        	<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="120"></col>
                    <col width="70"></col>
                    <col width="215"></col>
                    <col width="90"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtPlanTRA_WEEK" size="2" maxlength="2" style="ime-mode:disabled" class="input_ReadOnly" readOnly> ��
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtPlanSTR_YMD" name="txtPlanSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPlanStrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPlanStrYmd" name="ImgPlanStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPlanSTR_YMD','','36','227');"></a>
                        ~
                        <input id="txtPlanEND_YMD" name="txtPlanEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPlanEndYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPlanEndYmd" name="ImgPlanEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPlanEND_YMD','','152','227');"></a>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtPlanTRA_ENO_NO" size="8" maxlength="8" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm();" onChange="fnc_UsrGetEnoNm();">
                        <input id="txtPlanTRA_ENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo();" onchange="fnc_UsrGetEnoNo();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPlanEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPlanEnoNo" name="ImgPlanEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup()"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����׸�</td>
                    <td class="padding2423" colspan="5">
                    	<input id="txtPlanTRA_SUBITEM" size="100">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3" colspan="2">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_OJTPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:277px;">
                            <param name="DataID"                  value="dsT_CD_OJTPLAN">
                            <param name="Editable"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
	                            <G> name='��������' HeadBgColor='#dae0ee'
	                                <C> id='TRA_WEEK'     	width=40   name='����'         	align=center edit='none'</C>
	                                <C> id='STR_YMD'     	width=80   name='������'         align=center edit='none'</C>
	                                <C> id='END_YMD'     	width=80   name='������'         align=center edit='none'</C>
	                            </G>
	                                <C> id='TRA_ENO_NM'     width=70   name='�������'         align=center edit='none'</C>
	                                <C> id='TRA_SUBITEM'    width=500  name='�����׸�'         align=left   EditLimit=2000 edit='none'</C>
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
<!-- ����(Mentor)��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=TRA_ENO_NO       Ctrl=txtTRA_ENO_NO       Param=value </C>
        <C> Col=TRA_ENO_NM       Ctrl=txtTRA_ENO_NM       Param=value </C>
        <C> Col=MDPT_CD       Ctrl=txtMDPT_CD       Param=value </C>
        <C> Col=MDPT_NM       Ctrl=txtMDPT_NM       Param=value </C>
        <C> Col=MJOB_CD       Ctrl=txtMJOB_CD       Param=value </C>
        <C> Col=MJOB_NM       Ctrl=txtMJOB_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD       Param=value </C>
        <C> Col=TRA_DPT_CD        Ctrl=txtTRA_DPT_CD        Param=value </C>
        <C> Col=TRA_DPT_NM        Ctrl=txtTRA_DPT_NM        Param=value </C>
        <C> Col=HIR_YMD       Ctrl=txtHIR_YMD       Param=value </C>
        <C> Col=TRA_DUTY        Ctrl=txtTRA_DUTY        Param=value </C>
        <C> Col=HEAD_EMP_NO        Ctrl=txtHEAD_EMP_NO        Param=value </C>
        <C> Col=HEAD_EMP_NM        Ctrl=txtHEAD_EMP_NM        Param=value </C>
        <C> Col=EDU_GOAL1        Ctrl=txtEDU_GOAL1        Param=value </C>
        <C> Col=EDU_GOAL2        Ctrl=txtEDU_GOAL2        Param=value </C>
        <C> Col=EDU_GOAL3        Ctrl=txtEDU_GOAL3        Param=value </C>
    '>
</object>
<object id="mxBind" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJTPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=TRA_WEEK        Ctrl=txtPlanTRA_WEEK        Param=value </C>
        <C> Col=TRA_SUBITEM        Ctrl=txtPlanTRA_SUBITEM        Param=value </C>
        <C> Col=STR_YMD        Ctrl=txtPlanSTR_YMD        Param=value </C>
        <C> Col=END_YMD        Ctrl=txtPlanEND_YMD        Param=value </C>
        <C> Col=TRA_ENO_NO        Ctrl=txtPlanTRA_ENO_NO        Param=value </C>
        <C> Col=TRA_ENO_NM        Ctrl=txtPlanTRA_ENO_NM        Param=value </C>
    '>
</object>