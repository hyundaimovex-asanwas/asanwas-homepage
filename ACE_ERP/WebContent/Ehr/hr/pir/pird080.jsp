<!--
    ************************************************************************************
    * @Source         : pird080.jsp                                                    *
    * @Description    : ������߱� PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/10  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>������߱�(pird080)</title>
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

        var btnList = 'FFFTFTFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
	var PRT_TYPE = "";
			var DPT_CD_SHR;
			var HIRS_YMD_SHR;
            var HIRD_YMD_SHR;
            var ENO_NO;
            // �μ����μ�
            if (form1.rdoGBN_SHR[0].checked == true) {
                if (document.getElementById("txtDPT_CD_SHR").value == "") {
                    alert("�μ��ڵ�� �ʼ��Է��׸��Դϴ�.");
                    document.getElementById("txtDPT_CD_SHR").focus();
                    return;
                }
               DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;
               PRT_TYPE = "BUSOR";
             }
            // �Ի��Ϻ��μ�
            else if (form1.rdoGBN_SHR[1].checked == true) {
                if (document.getElementById("txtHIRS_YMD_SHR").value == "") {
                    alert("�Ի�������ڴ� �ʼ��Է��׸��Դϴ�.");
                    document.getElementById("txtHIRS_YMD_SHR").focus();
                    return;
                }
                else if (document.getElementById("txtHIRD_YMD_SHR").value == "") {
                    alert("�Ի��������ڴ� �ʼ��Է��׸��Դϴ�.");
                    document.getElementById("txtHIRD_YMD_SHR").focus();
                    return;
                }

                // �ش����� �������ڿ� �������� ��
                if( cfDateDiff(document.getElementById("txtHIRS_YMD_SHR").value.replace(/\-/g,''),document.getElementById("txtHIRD_YMD_SHR").value.replace(/\-/g,'')) < 0 ) {
                    alert("�������ڰ� �������ں��� Ů�ϴ�.");
                    document.getElementById("txtHIRS_YMD_SHR").focus();
                    return;
                }
                HIRS_YMD_SHR = document.getElementById("txtHIRS_YMD_SHR").value;
                HIRD_YMD_SHR = document.getElementById("txtHIRD_YMD_SHR").value;
                PRT_TYPE = "INDAY";
            }
            // ���κ��μ�
            else {
                if (document.getElementById("txtENO_NO1_SHR").value == "" &&
                    document.getElementById("txtENO_NO2_SHR").value == "" &&
                    document.getElementById("txtENO_NO3_SHR").value == "" &&
                    document.getElementById("txtENO_NO4_SHR").value == "" &&
                    document.getElementById("txtENO_NO5_SHR").value == "" &&
                    document.getElementById("txtENO_NO6_SHR").value == "" &&
                    document.getElementById("txtENO_NO7_SHR").value == "" &&
                    document.getElementById("txtENO_NO8_SHR").value == "" &&
                    document.getElementById("txtENO_NO9_SHR").value == "" ) {
                    alert("����� �ʼ��Է��׸��Դϴ�.");
                    return;
                    document.getElementById("txtENO_NO1_SHR").focus();
                    }

                    ENO_NO = "";

                 if (document.getElementById("txtENO_NO1_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO1_SHR").value;}
                if (document.getElementById("txtENO_NO2_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO2_SHR").value;}
                if (document.getElementById("txtENO_NO3_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO3_SHR").value;}
                if (document.getElementById("txtENO_NO4_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO4_SHR").value;}
                if (document.getElementById("txtENO_NO5_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO5_SHR").value;}
                if (document.getElementById("txtENO_NO6_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO6_SHR").value;}
                if (document.getElementById("txtENO_NO7_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO7_SHR").value;}
                if (document.getElementById("txtENO_NO8_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO8_SHR").value;}
                if (document.getElementById("txtENO_NO9_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO9_SHR").value;}
                ENO_NO = ENO_NO.substring(1, ENO_NO.length);
                PRT_TYPE = "";
            }

			var url = "pird080_PV.jsp?PRT_TYPE="+PRT_TYPE+"&ENO_NO="+ENO_NO+"&HIRS_YMD_SHR="+HIRS_YMD_SHR+"&HIRD_YMD_SHR="+HIRD_YMD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
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

            form1.rdoGBN_SHR[0].checked = true;

            fnc_FldChange();

            document.getElementById("txtDPT_CD_SHR").focus();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_FldChange();

            document.getElementById("txtDPT_CD_SHR").focus();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

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

        function fnc_FldChange() {
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";

            document.getElementById("txtHIRS_YMD_SHR").value = "";
            document.getElementById("txtHIRD_YMD_SHR").value = "";

            document.getElementById("txtENO_NO1_SHR").value = "";
            document.getElementById("txtENO_NM1_SHR").value = "";
            document.getElementById("txtENO_NO2_SHR").value = "";
            document.getElementById("txtENO_NM2_SHR").value = "";
            document.getElementById("txtENO_NO3_SHR").value = "";
            document.getElementById("txtENO_NM3_SHR").value = "";
            document.getElementById("txtENO_NO4_SHR").value = "";
            document.getElementById("txtENO_NM4_SHR").value = "";
            document.getElementById("txtENO_NO5_SHR").value = "";
            document.getElementById("txtENO_NM5_SHR").value = "";
            document.getElementById("txtENO_NO6_SHR").value = "";
            document.getElementById("txtENO_NM6_SHR").value = "";
            document.getElementById("txtENO_NO7_SHR").value = "";
            document.getElementById("txtENO_NM7_SHR").value = "";
            document.getElementById("txtENO_NO8_SHR").value = "";
            document.getElementById("txtENO_NM8_SHR").value = "";
            document.getElementById("txtENO_NO9_SHR").value = "";
            document.getElementById("txtENO_NM9_SHR").value = "";

            // �μ����μ�
            if (form1.rdoGBN_SHR[0].checked == true) {

                document.getElementById("txtDPT_CD_SHR").disabled = false;
                document.getElementById("ImgDptCd").disabled = false;
            }
            else {
                document.getElementById("txtDPT_CD_SHR").disabled = true;
                document.getElementById("ImgDptCd").disabled = true;
            }

            // �Ի��Ϻ��μ�
            if (form1.rdoGBN_SHR[1].checked == true) {
                document.getElementById("txtHIRS_YMD_SHR").disabled = false;
                document.getElementById("txtHIRD_YMD_SHR").disabled = false;
                document.getElementById("ImgHirsYmd").disabled = false;
                document.getElementById("ImgHirdYmd").disabled = false;
            }
            else {
                document.getElementById("txtHIRS_YMD_SHR").disabled = true;
                document.getElementById("txtHIRD_YMD_SHR").disabled = true;
                document.getElementById("ImgHirsYmd").disabled = true;
                document.getElementById("ImgHirdYmd").disabled = true;
            }

            // ���κ��μ�
            if (form1.rdoGBN_SHR[2].checked == true) {

                document.getElementById("txtENO_NO1_SHR").disabled = false;
                document.getElementById("txtENO_NM1_SHR").disabled = false;
                document.getElementById("ImgEnoNo1").disabled      = false;
                document.getElementById("txtENO_NO2_SHR").disabled = false;
                document.getElementById("txtENO_NM2_SHR").disabled = false;
                document.getElementById("ImgEnoNo2").disabled      = false;
                document.getElementById("txtENO_NO3_SHR").disabled = false;
                document.getElementById("txtENO_NM3_SHR").disabled = false;
                document.getElementById("ImgEnoNo3").disabled      = false;
                document.getElementById("txtENO_NO4_SHR").disabled = false;
                document.getElementById("txtENO_NM4_SHR").disabled = false;
                document.getElementById("ImgEnoNo4").disabled      = false;
                document.getElementById("txtENO_NO5_SHR").disabled = false;
                document.getElementById("txtENO_NM5_SHR").disabled = false;
                document.getElementById("ImgEnoNo5").disabled      = false;
                document.getElementById("txtENO_NO6_SHR").disabled = false;
                document.getElementById("txtENO_NM6_SHR").disabled = false;
                document.getElementById("ImgEnoNo6").disabled      = false;
                document.getElementById("txtENO_NO7_SHR").disabled = false;
                document.getElementById("txtENO_NM7_SHR").disabled = false;
                document.getElementById("ImgEnoNo7").disabled      = false;
                document.getElementById("txtENO_NO8_SHR").disabled = false;
                document.getElementById("txtENO_NM8_SHR").disabled = false;
                document.getElementById("ImgEnoNo8").disabled      = false;
                document.getElementById("txtENO_NO9_SHR").disabled = false;
                document.getElementById("txtENO_NM9_SHR").disabled = false;
                document.getElementById("ImgEnoNo9").disabled      = false;
            }
            else {
                document.getElementById("txtENO_NO1_SHR").disabled = true;
                document.getElementById("txtENO_NM1_SHR").disabled = true;
                document.getElementById("ImgEnoNo1").disabled      = true;
                document.getElementById("txtENO_NO2_SHR").disabled = true;
                document.getElementById("txtENO_NM2_SHR").disabled = true;
                document.getElementById("ImgEnoNo2").disabled      = true;
                document.getElementById("txtENO_NO3_SHR").disabled = true;
                document.getElementById("txtENO_NM3_SHR").disabled = true;
                document.getElementById("ImgEnoNo3").disabled      = true;
                document.getElementById("txtENO_NO4_SHR").disabled = true;
                document.getElementById("txtENO_NM4_SHR").disabled = true;
                document.getElementById("ImgEnoNo4").disabled      = true;
                document.getElementById("txtENO_NO5_SHR").disabled = true;
                document.getElementById("txtENO_NM5_SHR").disabled = true;
                document.getElementById("ImgEnoNo5").disabled      = true;
                document.getElementById("txtENO_NO6_SHR").disabled = true;
                document.getElementById("txtENO_NM6_SHR").disabled = true;
                document.getElementById("ImgEnoNo6").disabled      = true;
                document.getElementById("txtENO_NO7_SHR").disabled = true;
                document.getElementById("txtENO_NM7_SHR").disabled = true;
                document.getElementById("ImgEnoNo7").disabled      = true;
                document.getElementById("txtENO_NO8_SHR").disabled = true;
                document.getElementById("txtENO_NM8_SHR").disabled = true;
                document.getElementById("ImgEnoNo8").disabled      = true;
                document.getElementById("txtENO_NO9_SHR").disabled = true;
                document.getElementById("txtENO_NM9_SHR").disabled = true;
                document.getElementById("ImgEnoNo9").disabled      = true;
            }

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)    |
    | 3. ���Ǵ� Table List(T_CM_PERSON)           |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������߱�</td>
                    <td align="right" class="navigator">HOME/�λ����/�λ��������/<font color="#000000">������߱�</font></td>
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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="6">������߱�</td>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="100"></col>
                            <col width="70"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="padding2423" >
                                <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" onClick="fnc_FldChange()">�μ��� �μ�
                            </td>
                            <td class="padding2423" colspan="2">
                                <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="4"  maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="22" class="input_ReadOnly"  readOnly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" onClick="fnc_FldChange()">�Ի��Ϻ��μ�
                            </td>
                            <td class="padding2423" colspan="2">
                                <input id="txtHIRS_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�Ի��������');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirsYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirsYmd" name="ImgHirsYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIRS_YMD_SHR','','145','125');"></a> -
                                <input id="txtHIRD_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�Ի���������');"   onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirdYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirdYmd" name="ImgHirdYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIRD_YMD_SHR','','260','125');"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423"  valign="top" rowspan="10">
                                <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;"  onClick="fnc_FldChange()">���κ� �μ�
                            </td>
                            <td class="paddingTop5">&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;��
                            </td>
                            <td class="paddingTop5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;��
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO1_SHR  name=txtENO_NO1_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO1_SHR', 'txtENO_NM1_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM1_SHR name=txtENO_NM1_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM1_SHR','txtENO_NO1_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo1" name="ImgEnoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO1_SHR','txtENO_NM1_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO1_SHR  name=txtENO_NO2_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO2_SHR', 'txtENO_NM2_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM1_SHR name=txtENO_NM2_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM2_SHR','txtENO_NO2_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo2" name="ImgEnoNo2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO2_SHR','txtENO_NM2_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO3_SHR  name=txtENO_NO3_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO3_SHR', 'txtENO_NM3_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM3_SHR name=txtENO_NM3_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM3_SHR','txtENO_NO3_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo3" name="ImgEnoNo3" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO3_SHR','txtENO_NM3_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO4_SHR  name=txtENO_NO4_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO4_SHR', 'txtENO_NM4_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM4_SHR name=txtENO_NM4_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM4_SHR','txtENO_NO4_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo4','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo4" name="ImgEnoNo4" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO4_SHR','txtENO_NM4_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO5_SHR  name=txtENO_NO5_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO5_SHR', 'txtENO_NM5_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM5_SHR name=txtENO_NM5_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM5_SHR','txtENO_NO5_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo5','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo5" name="ImgEnoNo5" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO5_SHR','txtENO_NM5_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO6_SHR  name=txtENO_NO6_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO6_SHR', 'txtENO_NM6_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM6_SHR name=txtENO_NM6_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM6_SHR','txtENO_NO6_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo6" name="ImgEnoNo6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO6_SHR','txtENO_NM6_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO7_SHR  name=txtENO_NO7_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO7_SHR', 'txtENO_NM7_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM7_SHR name=txtENO_NM7_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM7_SHR','txtENO_NO7_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo7','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo7" name="ImgEnoNo7" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO7_SHR','txtENO_NM7_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO8_SHR  name=txtENO_NO8_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO8_SHR', 'txtENO_NM8_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM8_SHR name=txtENO_NM8_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM8_SHR','txtENO_NO8_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo8','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo8" name="ImgEnoNo8" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO8_SHR','txtENO_NM8_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO9_SHR  name=txtENO_NO9_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO9_SHR', 'txtENO_NM9_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM9_SHR name=txtENO_NM9_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM9_SHR','txtENO_NO9_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo9','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo9" name="ImgEnoNo9" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO9_SHR','txtENO_NM9_SHR')"></a>
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

</form>
<!-- form �� -->

</body>
</html>