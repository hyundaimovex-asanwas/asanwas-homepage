<!--
    ************************************************************************************
    * @Source         : pira018.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>��������</title>
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

            dsT_CM_FAMILY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_FAMILY.Reset();

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

                trT_CM_FAMILY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=SAV";
                trT_CM_FAMILY.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;
            var row = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CM_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_FAMILY.RowStatus(dsT_CM_FAMILY.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_FAMILY.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("����[" + dsT_CM_FAMILY.NameValue(dsT_CM_FAMILY.RowPosition,"REL_NM") + "] [" + dsT_CM_FAMILY.NameValue(dsT_CM_FAMILY.RowPosition,"ENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            dsT_CM_FAMILY.DeleteRow(dsT_CM_FAMILY.RowPosition);

            if (status != 1) {

                trT_CM_FAMILY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=DEL";
                trT_CM_FAMILY.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_FAMILY.SetColumn(form1.grdT_CM_FAMILY.GetColumnID(0));
            form1.grdT_CM_FAMILY.Focus();

            bnd.ActiveBind = true;

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

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CM_FAMILY.CountColumn == 0) {
                dsT_CM_FAMILY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, REL_NM:STRING, ENO_NM:STRING:KEYVALUETYPE,  BIR_YMD:STRING, EDGR_CD:STRING, EDGR_NM:STRING, OCC_NAM:STRING, JOB_CD:STRING,  DPD_TAG:STRING, HIU_TAG:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_FAMILY.AddRow();

            form1.grdT_CM_FAMILY.setColumn(form1.grdT_CM_FAMILY.getColumnID(0));

            //�űԸ� ��� �ʵ� ��밡���ϰ�
            fnc_EnableElementAll(elementList);

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("cmbDPD_TAG").value = "O";
            document.getElementById("cmbHIU_TAG").value = "O";

            document.getElementById("txtREL_CD").focus();
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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

   			dsT_CM_FAMILY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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
            if (!dsT_CM_FAMILY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_FAMILY.CountRow; i++ ) {
                if ( dsT_CM_FAMILY.RowStatus(i) == 1 ||
                     dsT_CM_FAMILY.RowStatus(i) == 3 ) {

                    // ��������
                    if( dsT_CM_FAMILY.NameValue(i, "REL_CD") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return false;
                    }

                    // ����
                    if( dsT_CM_FAMILY.NameValue(i, "ENO_NM") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtENO_NM").focus();
                        return false;
                    }

                    // ��������
                    if (dsT_CM_FAMILY.NameValue(i, "REL_CD") != "" &&
                        dsT_CM_FAMILY.NameValue(i, "REL_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return;
                    }

                    // �з��ڵ�
                    if (dsT_CM_FAMILY.NameValue(i, "EDGR_CD") != "" &&
                        dsT_CM_FAMILY.NameValue(i, "EDGR_NM") == "") {
                        alert("�з��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

//�������� ��ȸ�� ó��
<%
if(Gubun != null) {
    if(Gubun.equals("1") && mode.equals("read")){
%>
            document.getElementById("ImgRelCd").style.display = "none";
            document.getElementById("imgSearch").style.display = "none";
            document.getElementById("ImgEdgrCd").style.display = "none";
            document.getElementById("ImgAdd").style.display = "none";
            document.getElementById("imgSave").style.display = "none";
            document.getElementById("imgClear").style.display = "none";
            document.getElementById("imgDelete").style.display = "none";
<%
    }
}
%>

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_FAMILY, 0,"false","false");

            //��� �ʵ� ����
            fnc_DisableElementAll(elementList);

            fnc_SearchList();
        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();
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

        var elementList = new Array(    "txtREL_CD"
                                       ,"txtENO_NM"
                                       ,"txtBIR_YMD"
                                       ,"txtEDGR_CD"
                                       ,"txtOCC_NAM"
                                       ,"txtJOB_CD"
                                       ,"cmbDPD_TAG"
                                       ,"cmbHIU_TAG"
                                       ,"ImgRelCd"
                                       ,"ImgBirYmd"
                                       ,"ImgEdgrCd"
                                    );

        var exceptionList = new Array(  "txtREL_CD"
                                       ,"txtENO_NM"
                                       ,"ImgRelCd"
                                      );

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
    | 2. �̸� : dsT_CM_FAMILY                       |
    | 3. Table List : T_CM_FAMILY                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_FAMILY                       |
    | 3. Table List : T_CM_FAMILY                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_FAMILY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //Ű ���� ������ ������ �ʵ� ��밡���ϰ�
            //fnc_EnableElementAll(elementList, exceptionList);

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_FAMILY.CountRow);
        }


    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_FAMILY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_FAMILY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[��������/��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("��������/�������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_FAMILY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_FAMILY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_FAMILY Event="OnRowPosChanged(row)">
<%
    //�������� ��ȸ�� ó��
    if(Gubun == null
            || (!Gubun.equals("1") && !mode.equals("read"))) {
%>
        var SysStatus = dsT_CM_FAMILY.SysStatus(row);

        //�ű��̸� ��� ���� �����ϰ�
        if (SysStatus == 1) {
            fnc_EnableElementAll(elementList);
        } else {
            fnc_EnableElementAll(elementList, exceptionList);
        }
<%
    }
%>
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('G1', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','��������','G1')"></a>
                    </td>
                    <td align="center" maxlength="12" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtBIR_YMD" style="width:75%" maxlength="6">

                    </td>
                    <td align="center" class="blueBold">�з��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('E1', 'txtEDGR_CD','txtEDGR_NM');"> <input id="txtEDGR_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEdgrCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEdgrCd" name="ImgEdgrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEDGR_CD','txtEDGR_NM','�з±���','E1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtOCC_NAM" maxlength="30" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">�ξ翩��</td>
                    <td class="padding2423">
                        <select id="cmbDPD_TAG" style="width:100%" >
                            <option value="" ></option>
                            <option value="O" >�ξ�</option>
                            <option value="X" >�̺ξ�</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">�Ǻ�����</td>
                    <td class="padding2423">
                        <select id="cmbHIU_TAG" style="width:100%" >
                            <option value="" ></option>
                            <option value="O" >�ξ�</option>
                            <option value="X" >�̺ξ�</option>
                        </select>
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_FAMILY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center </C>
                                <C> id=REL_CD          width=80   name='�����ڵ�'     align=center </C>
                                <C> id=REL_NM          width=80   name='����'         align=center </C>
                                <C> id=ENO_NM          width=100   name='����'         align=center </C>
                                <C> id=BIR_YMD         width=100  name='�������'     align=center mask='XX-XX-XX'</C>
                                <C> id=EDGR_NM         width=80   name='�з�'                      </C>
                                <C> id=OCC_NAM         width=100   name='�ٹ�ó'                    </C>
                                <C> id=JOB_CD          width=100   name='����'                      </C>
                                <C> id=DPD_TAG1        width=100   name='�ξ翩��'     align=center value={Decode(DPD_TAG,'O','�ξ�','X','�̺ξ�','')} </C>
                                <C> id=HIU_TAG1        width=100   name='�Ǻ�����'     align=center value={Decode(HIU_TAG,'O','�ξ�','X','�̺ξ�','')} </C>
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
<!-- �������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_FAMILY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=REL_CD        Ctrl=txtREL_CD       Param=value </C>
        <C> Col=REL_NM        Ctrl=txtREL_NM       Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM       Param=value </C>
        <C> Col=BIR_YMD       Ctrl=txtBIR_YMD      Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD      Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM      Param=value </C>
        <C> Col=OCC_NAM       Ctrl=txtOCC_NAM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=DPD_TAG       Ctrl=cmbDPD_TAG      Param=value </C>
        <C> Col=HIU_TAG       Ctrl=cmbHIU_TAG      Param=value </C>
    '>
</object>