<!--*************************************************************************
* @source      : taxa130.jsp                                                *
* @description : ��Ÿ�ҵ�/�������ξװ��� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/26            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>��Ÿ�ҵ�/�������ξװ���(taxa210)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����(ó��)
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD";
        var params;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR");

            if(oPIS_YM.value == "") {
                alert("�ش����� ����ֽ��ϴ�.");
                oPIS_YM.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            dsT_AC_ETCPAY.dataid = dataClassName+params;
            dsT_AC_ETCPAY.reset();
        }


        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            if(oPIS_YM.value == "")
                return;

            var pis_ym      = oPIS_YM.value.split("-");

            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];

            //�μ� �ڵ带 �����´�.
            dsT_CM_COMMON_DPT.dataid = dataClassName+params;
            dsT_CM_COMMON_DPT.reset();
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
            if (!dsT_AC_ETCPAY_SAV.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            trT_AC_ETCPAY.KeyValue = "SAV(I:dsSAVE=dsT_AC_ETCPAY_SAV)";
            trT_AC_ETCPAY.action = dataClassName+"&S_MODE=SAV";
            trT_AC_ETCPAY.post();
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }


        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("��Ÿ�ҵ�/�������ξװ���", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {
            if(dsT_AC_ETCPAY_SAV.CountRow > 0) {
                if(!confirm("�Է��ϴ� �ڷᰡ �ֽ��ϴ�.\n�������� ������ �����˴ϴ�.\n����Ͻðڽ��ϱ�?")) {
                    return;
                }
            }
            dsT_AC_ETCPAY_SAV.ClearData();
            dsT_AC_ETCPAY_SAV.AddRow();

            var pis_ym = document.getElementById("txtPIS_YM_SHR").value.split("-");
            dsT_AC_ETCPAY_SAV.NameString(dsT_AC_ETCPAY_SAV.RowPosition, "PIS_YY") = pis_ym[0];
            dsT_AC_ETCPAY_SAV.NameString(dsT_AC_ETCPAY_SAV.RowPosition, "PIS_MM") = pis_ym[1];

            fnc_EnableElementAll(elementList);
        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_ETCPAY.ClearData();
            dsT_AC_ETCPAY_SAV.ClearData();

            //��� �Է�â�� �ʱ�ȭ
            fnc_ClearInputElement(elementList);
            fnc_DisableElementAll(elementList);

            document.getElementById("cmbDPT_CD_SHR").selectedIndex = 0;
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //ù��° �μ� : �׸����
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"false","false");      // Grid Style ����

            document.getElementById("txtPIS_YM_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";

            //����� ����Ÿ�� �������
            dsT_AC_ETCPAY_SAV.setDataHeader ( " PIS_YY  :STRING  "
                                            + ",PIS_MM  :STRING  "
                                            + ",DPT_CD  :STRING  "
                                            + ",SAL_CD  :STRING  "
                                            + ",ADD_TAG :STRING  "
                                            + ",AMOUNT  :DECIMAL "
                                            + ",OCC_CD  :STRING  " );


            //���� �ڵ� ����
            fnc_ConstructCommonCode("dsT_CM_COMMON_H2", "cmbSAL_CD");

            //�ڵ� ��ȸ
            fnc_SearchItem();

            fnc_DisableElementAll(elementList);
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/

        var elementList = new Array( "cmbSAL_CD"
                                    ,"rdoADD_TAG"
                                    ,"cmbDPT_CD"
                                    ,"txtAMOUNT");

        var msgList = new Array(     "�� ��"
                                    ,"�� ��"
                                    ,"�� ��"
                                    ,"�� ��" );

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_ETCPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet                               |
    +------------------------------------------------------>

    <!-- �׸� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H2"/>
       <jsp:param name="CODE_GUBUN"    value="H2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_ETCPAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    <Script For=dsT_CM_COMMON_DPT Event="OnLoadCompleted(iCount)">
        if (iCount > 0)    {
            fnc_ConstructCommonCode("dsT_CM_COMMON_DPT", "cmbDPT_CD_SHR", "", "�� ü");
            fnc_ConstructCommonCode("dsT_CM_COMMON_DPT", "cmbDPT_CD");
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* �۾��� �Ϸ� �Ͽ����ϴ�!");
        dsT_AC_ETCPAY_SAV.ClearData();
        fnc_DisableElementAll(elementList);

        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
    <script for=grdT_AC_ETCPAY event=OnDblClick(Row,Colid)>
        if(Row < 1) {
            return;
        } else {
            var href_page = "/hr/tax/taxa211.jsp"
                          + "?PIS_YY="+dsT_AC_ETCPAY.NameValue(Row, "PIS_YY")
                          + "&PIS_MM="+dsT_AC_ETCPAY.NameValue(Row, "PIS_MM")
                          + "&DPT_CD="+dsT_AC_ETCPAY.NameValue(Row, "DPT_CD");

            window.showModalDialog(href_page, "", "dialogWidth:610px; dialogHeight:530px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();
        }
    </script>


    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_AC_ETCPAY_SAV event=CanRowPosChange(row)>
        var keyName;
        var colName;
        var colMsg;

        if(row > 0) {
            for(var i=0; i<elementList.length; i++) {
                keyName = elementList[i];
                colName = keyName.substring(3, keyName.length);
                colMsg  = msgList[i];

                if (dsT_AC_ETCPAY_SAV.NameString(row, colName) == "" ) {
                    alert("[ " + colMsg + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
        }
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��Ÿ�ҵ�/�������ξװ���</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">��Ÿ�ҵ�/�������ξװ���</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" class="greenTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">�ش���</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onchange="fnc_SearchItem()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
                    </td>
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbDPT_CD_SHR">
                        </select>
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
                        <col width="90"></col>
                        <col width="140"></col>
                        <col width="90"></col>
                        <col width="180"></col>
                        <col width="90"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <select name="cmbSAL_CD" id="cmbSAL_CD">
                                <option value=""></option>
                            </select>
                        </td>
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <comment id="__NSID__">
                                <object id=rdoADD_TAG classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:14;width:180;">
                                    <param name=AutoMargin  value="true">
                                    <param name=Cols        value="2">
                                    <param name=Format      value="0^��ȯ�ޱ�,1^�̳��α�">
                                </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <select id="cmbDPT_CD">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423" colspan="5">
                            <comment id="__NSID__">
                            <object id="txtAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                        <param name="DataID" value="dsT_AC_ETCPAY">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"     width=60         align=center   name="NO"         value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM        width=145        align=center   name=" ��  �� "     </C>
                            <C> id=LAB_AMT       width=115        align=right    rightmargin=10        name="�ٷμҵ�"        </C>
                            <C> id=SO_AMT        width=115        align=right    rightmargin=10        name="��Ÿ�ҵ�"        </C>
                            <C> id=MIS_CAL       width=115        align=right    rightmargin=10        name="���ΰ��Ǽ�"    </C>
                            <C> id=MIS_AMT       width=115        align=right    rightmargin=10        name="���αݾ׽Ǽ�"    </C>
                            <C> id=MIS_PRO       width=115        align=right    rightmargin=10        name="�������"        </C>
                        '>
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
<object id="bndT_AC_ETCPAY_SAV" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_ETCPAY_SAV">
    <Param Name="BindInfo", Value='
        <C>Col=DPT_CD           Ctrl=cmbDPT_CD          Param=value     </C>
        <C>Col=SAL_CD           Ctrl=cmbSAL_CD          Param=value     </C>
        <C>Col=ADD_TAG          Ctrl=rdoADD_TAG         Param=CodeValue </C>
        <C>Col=AMOUNT           Ctrl=txtAMOUNT          Param=Text      </C>
    '>
</object>