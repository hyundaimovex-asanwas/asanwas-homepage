 <!--
*****************************************************
* @source      : reta031.jsp
* @description : ���꼼��/�����ݰ���/�����ݾȺг�������
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/07/10      ����ȣ                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����ݾȺг�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">

    <!--*****************************
    *  CSS ����  *
    *****************************-->
    <style type="text/css">
    .header {
        padding: 1px;
        background-color: #f7dcbb;
        text-align: center;
    }
    .content {
        padding: 1px;
        padding-right : 6px;
        background-color: #ffffff;
        text-align: right;
    }
    .content2 {
        padding: 1px;
        background-color: #ffffff;
        text-align: center;
    }
    .content3 {
        padding: 1px;
        background-color: #ffffff;
        text-align: left;
    }
    </style>


<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<script language="javascript" src="/common/dateformat.js"></script>
<script language="javascript" src="/common/input.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
                //����Ű ����
        var btnList = "F"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����
                    + "F"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta031.cmd.RETA031CMD";
        var params = null;

        var retObj = window.dialogArguments;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            params = "&S_MODE=SHR"
                   + "&ENO_NO=" +retObj.eno_no
                   + "&HIR_YMD="+retObj.hir_ymd
                   + "&SEQ_NO=" +retObj.seq_no;

            dsT_AC_RETPROPORTIONAL.dataid = dataClassName+params;
            dsT_AC_RETPROPORTIONAL.reset();
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
            if ( !dsT_AC_RETPROPORTIONAL.isUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }

            var oHIR_YMD    = document.getElementById("txtHIR_YMD");
            var oCO_NM      = document.getElementById("txtCO_NM");

            if(oHIR_YMD.value == "") {
                alert("�Ի����� �Է��ϼ���.");
                oHIR_YMD.focus();
                return;
            }
            if(oCO_NM.value == "") {
                alert("ȸ����� �Է��ϼ���.");
                oCO_NM.focus();
                return;
            }

            params = "&S_MODE=SAV";

            //���Ϲ��� DataSet ����
            trT_AC_RETPROPORTIONAL.KeyValue = "TR_SAV"
                                   + "(I:dsT_AC_RETPROPORTIONAL=dsT_AC_RETPROPORTIONAL)";

            trT_AC_RETPROPORTIONAL.action = dataClassName+params;
            trT_AC_RETPROPORTIONAL.post();
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

        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {
            dsT_AC_RETPROPORTIONAL.setDataHeader("ENO_NO:STRING ,HIR_YMD:STRING ,RET_YMD:STRING ,CO_NM:STRING ,LSE_YY:INT ,LSE_MM:INT ,LSE_DD:INT ,BAS_AMT:INT ,RET_AMT:INT ,DEB_AMT:INT ,JOB_NM:STRING ,MUL_VAL:DECIMAL ,SEQ_NO:STRING");
            dsT_AC_RETPROPORTIONAL.AddRow();

            dsT_AC_RETPROPORTIONAL.NameString(dsT_AC_RETPROPORTIONAL.RowPosition, "ENO_NO") = retObj.eno_no;
            dsT_AC_RETPROPORTIONAL.NameString(dsT_AC_RETPROPORTIONAL.RowPosition, "SEQ_NO") = "0";
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

            dsT_AC_RETPROPORTIONAL.ClearData();
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();
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
            if(retObj.mode == "mod") {
                fnc_SearchList();
            } else if(retObj.mode == "add"){
                fnc_HiddenElement("imgSearch");
                fnc_HiddenElement("ImgClear");

                fnc_AddNew();
            }
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
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETPROPORTIONAL)                |
    | 3. ���Ǵ� Table List(T_AC_RETPROPORTIONAL)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETPROPORTIONAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_AC_RETPROPORTIONAL                       |
    | 3. Table List : T_AC_RETPROPORTIONAL                 |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETPROPORTIONAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_AC_RETPROPORTIONAL Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETPROPORTIONAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_AC_RETPROPORTIONAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AC_RETPROPORTIONAL event="OnSuccess()">
        alert("ó���� �Ϸ� �Ǿ����ϴ�.");
        window.close();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_AC_RETPROPORTIONAL event="OnFail()">
        cfErrorMsg(this);
        window.close();
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
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ݾȺг�������</td>
                        <td align="right" class="navigator">HOME/���꼼��/�����ݰ���/<font color="#000000">�����ݾȺг�������</font></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- �Ⱥ� ���� ��ư ���̺� ���� -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" class="paddingTop5" align="right">

                <img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"   onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"   style="cursor:hand;">
                <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"         onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"       style="cursor:hand;">
                <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"        onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"    style="cursor:hand;">
                <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="window.close()"     onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"       style="cursor:hand;">

            </td>
        </tr>
    </table>
    <!-- �Ⱥ� ���� ��ư ���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
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

    <!-- ���� �Է� ���̺� ���� -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="90"></col>
                        <col width="110"></col>
                        <col width="105"></col>
                        <col width="110"></col>
                        <col width="90"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">ȸ���</td>
                        <td class="padding2423" colspan="5">
                            <input id="txtCO_NM" name="txtENO_NO" size="14">
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">�Ի���</td>
                        <td class="padding2423">
                            <input type="text" id="txtHIR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgHIR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD','','103','110');"></a>
                        </td>
                        <td class="creamBold" align="center">������</td>
                        <td class="padding2423">
                            <input type="text" id="txtRET_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRET_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgRET_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtRET_YMD','','103','110');"></a>
                        </td>
                        <td class="creamBold" align="center">������</td>
                        <td class="padding2423">
                            <input id="txtJOB_NM" name="txtJOB_NM" size="14">
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">����</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtMUL_VAL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=2>
                                <param name=MaxDecimalPlace         value=2>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td class="creamBold" align="center">�ٹ��ϼ�</td>
                        <td class="padding2423" colspan="3">
                            <input id="txtLSE_YY" name="txtLSE_YY" size="2" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber2();">��&nbsp;&nbsp;
                            <input id="txtLSE_MM" name="txtLSE_MM" size="2" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber2();">��&nbsp;&nbsp;
                            <input id="txtLSE_DD" name="txtLSE_DD" size="2" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber2();">��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">�⺻��</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                        <td class="creamBold" align="center">���������</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtRET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                        <td class="creamBold" align="center">�д��</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtDEB_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
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

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_AC_RETPROPORTIONAL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETPROPORTIONAL">
    <Param Name="BindInfo", Value='
        <C>Col=HIR_YMD              Ctrl=txtHIR_YMD             Param=value     </C>
        <C>Col=RET_YMD              Ctrl=txtRET_YMD             Param=value     </C>
        <C>Col=CO_NM                Ctrl=txtCO_NM               Param=value     </C>
        <C>Col=LSE_YY               Ctrl=txtLSE_YY              Param=value     </C>
        <C>Col=LSE_MM               Ctrl=txtLSE_MM              Param=value     </C>
        <C>Col=LSE_DD               Ctrl=txtLSE_DD              Param=value     </C>
        <C>Col=BAS_AMT              Ctrl=txtBAS_AMT             Param=text      </C>
        <C>Col=RET_AMT              Ctrl=txtRET_AMT             Param=text      </C>
        <C>Col=DEB_AMT              Ctrl=txtDEB_AMT             Param=text      </C>
        <C>Col=JOB_NM               Ctrl=txtJOB_NM              Param=value     </C>
        <C>Col=MUL_VAL              Ctrl=txtMUL_VAL             Param=text     </C>
    '>
</object>

