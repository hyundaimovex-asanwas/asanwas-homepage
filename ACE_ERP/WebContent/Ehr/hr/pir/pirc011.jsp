<!--
    ************************************************************************************
    * @Source         : pirc011.jsp                                                    *
    * @Description    : �⺻���� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�									 *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�⺻����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
    String Gubun = request.getParameter("GUBUN");
    String mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.c.pirc011.cmd.PIRC011CMD&S_MODE=SHR&ENO_NO=<%=ENO_NO%>";
            dsT_CM_PERSON.Reset();

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

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.c.pirc011.cmd.PIRC011CMD&S_MODE=SAV";
                trT_CM_PERSON.post();

            } else {

                return;

            }

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

            fnc_SearchList();

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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_PERSON.IsUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_SearchList();


            document.getElementById("txtBCT_CD").className = "input_ReadOnly";
            document.getElementById("txtBCT_CD").readOnly     = true;
            document.getElementById("txtHF_NAM").className = "input_ReadOnly";
            document.getElementById("txtHF_NAM").readOnly     = true;
            document.getElementById("txtHFRE_CD").className = "input_ReadOnly";
            document.getElementById("txtHFRE_CD").readOnly     = true;
            document.getElementById("txtPER_ADR").className = "input_ReadOnly";
            document.getElementById("txtPER_ADR").readOnly     = true;
            document.getElementById("txtADDRESS").className = "input_ReadOnly";
            document.getElementById("txtADDRESS").readOnly     = true;
            document.getElementById("txtRADR").className = "input_ReadOnly";
            document.getElementById("txtRADR").readOnly     = true;
            document.getElementById("txtPHN_NO").className = "input_ReadOnly";
            document.getElementById("txtPHN_NO").readOnly     = true;
            document.getElementById("txtEM_PHN_NO").className = "input_ReadOnly";
            document.getElementById("txtEM_PHN_NO").readOnly     = true;
            document.getElementById("txtE_MAIL").className = "input_ReadOnly";
            document.getElementById("txtE_MAIL").readOnly     = true;

            document.getElementById("ImgBctCd").style.display = "none";
            document.getElementById("ImgHfreCd").style.display = "none";
            document.getElementById("ImgZipNo").style.display = "none";
            document.getElementById("ImgRziNo").style.display = "none";
            document.getElementById("ImgHfreCd").style.display = "none";
            document.getElementById("imgSave").style.display = "none";
            document.getElementById("imgClear").style.display = "none";

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/


    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->



<!-- form ���� -->
<form name="form1">
<input type="hidden" id="ENO_NO">

<!-- ��ư ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�⺻����</strong>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="898" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="160"></col>
                    <col width="80"></col>
                    <col width="160"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">�Ż�����</td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtBCT_CD" maxlength="3" style="width:17%" maxlength="2"> <input id="txtBCT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">ȣ&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHF_NAM" maxlength="12" style="width:100%"></td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHFRE_CD" maxlength="3" style="width:17%" maxlength="2"> <input id="txtHFRE_NM" style="width:60%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="5"><input id="txtPER_ADR" maxlength="60" style="width:90%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">����ּ�</td>
                    <td align="center" class="blueBold">�����ȣ</td>
                    <td class="padding2423">
                        <input id="txtZIP_NO" size="7" maxlength="7" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtADR_CT" style="width:50%" class="input_ReadOnly" readonly> <input id="txtADDRESS" maxlength="50" style="width:45%"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">�ǰ�����</td>
                    <td align="center" class="blueBold">�����ȣ</td>
                    <td class="padding2423">
                        <input id="txtRZI_NO" size="7" maxlength="7" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtRADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtRADR" maxlength="50" style="width:45%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                    <col width="70 "></col>
                    <col width="155"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >������ȣ</td>
                    <td align="center" class="blueBold">��ȭ��ȣ</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO" style="width:65%;ime-mode:disabled"  maxlength="10" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">E-mail</td>
                    <td class="padding2423">
                        <input id="txtE_MAIL" maxlength="30" style="width:90%">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=BCT_CD        Ctrl=txtBCT_CD      Param=value </C>
        <C> Col=BCT_NM        Ctrl=txtBCT_NM      Param=value </C>
        <C> Col=HF_NAM        Ctrl=txtHF_NAM      Param=value </C>
        <C> Col=HFRE_CD       Ctrl=txtHFRE_CD     Param=value </C>
        <C> Col=HFRE_NM       Ctrl=txtHFRE_NM     Param=value </C>
        <C> Col=PER_ADR       Ctrl=txtPER_ADR     Param=value </C>
        <C> Col=ZIP_NO        Ctrl=txtZIP_NO      Param=value </C>
        <C> Col=ADDRESS       Ctrl=txtADDRESS     Param=value </C>
        <C> Col=ADR_CT        Ctrl=txtADR_CT      Param=value </C>
        <C> Col=RZI_NO        Ctrl=txtRZI_NO      Param=value </C>
        <C> Col=RADR          Ctrl=txtRADR        Param=value </C>
        <C> Col=RADR_CT       Ctrl=txtRADR_CT     Param=value </C>
        <C> Col=PHN_NO        Ctrl=txtPHN_NO      Param=value </C>
        <C> Col=EM_PHN_NO     Ctrl=txtEM_PHN_NO   Param=value </C>
        <C> Col=E_MAIL        Ctrl=txtE_MAIL      Param=value </C>
    '>
</object>