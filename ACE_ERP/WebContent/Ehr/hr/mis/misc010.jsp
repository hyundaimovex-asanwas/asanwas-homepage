<!--
    ************************************************************************************
    * @Source         : misc010.jsp                                                    *
    * @Description    : �����ȹ�۾����� PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/02  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�����ȹ�۾�����(misc010)</title>
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

        var btnList  = 'TFTFFFFT';
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var Month    = getToday().substr(0,7);

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;

            if (PIS_YY == "") {
                alert("����⵵�� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YY_SHR").focus();
                return;
            }


            // �޿�ó�� �۾��α� ������ ��ȸ
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc010.cmd.MISC010CMD&S_MODE=SHR&PIS_YY="+PIS_YY;
            dsT_CP_WORKLOG.Reset();

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

            //��� ��ü ��Ȱ��ȭ
            fnc_DisableElementAll(elementList);

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CP_WORKLOG.ClearData();

            document.getElementById("txtPIS_YY_SHR").focus();

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
            //��� ��ü ��Ȱ��ȭ
            fnc_DisableElementAll(elementList);


            document.getElementById("txtPIS_YY_SHR").value = PlanYear;
            document.getElementById("txtPIS_YY_SHR").focus();

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



        /**
         * �۾������� ���� �����Ѵ�.
         */
        function fnc_check() {
            var PIS_YY      = document.getElementById("txtPIS_YY").value;
            var PAY_YMD     = document.getElementById("txtPAY_YMD").value;
            var APY_YMD     = document.getElementById("txtAPY_YMD").value;
            var PAY_YY      = PAY_YMD.substr(0,4);// ��������� ���۳��,������ �񱳿�

            if (PIS_YY == "") {
                alert("����� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPIS_YY").focus();
                return false;
            }

            if (PAY_YMD == "") {
                alert("���Ⱓ �������ڴ� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }

            // �������� CHECK
            if (!fnc_CheckDate2(PAY_YMD, "���Ⱓ ��������") && PAY_YMD != "") {
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }

            if (PAY_YMD < Month) {
                alert("���Ⱓ ���۳���� ���������� Ŀ�� �մϴ�.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }
            else if (PAY_YY < PIS_YY - 1 || PAY_YMD > PIS_YY+'-01') {
                alert("���Ⱓ ���۳���� ����⵵ 1���̰ų� ���� ����̾�� �մϴ�.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }

            if (APY_YMD == "") {
                alert("���Ⱓ �������ڴ� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtAPY_YMD").focus();
                return false;
            }

            // �������� CHECK
            if (!fnc_CheckDate2(APY_YMD, "���Ⱓ ��������") && APY_YMD != "") {
                document.getElementById("txtAPY_YMD").focus();
                return false;
            }

            if (APY_YMD != PIS_YY+'-12') {
                alert("���Ⱓ �������� ����⵵�� ���������̾�� �մϴ�.");
                document.getElementById("txtAPY_YMD").focus();
                return false;
            }

            // �������ڿ� �������� ��
            if( cfDateDiff(document.getElementById("txtPAY_YMD").value.replace(/\-/g,''),document.getElementById("txtAPY_YMD").value.replace(/\-/g,'')) < 0 ) {
                alert("�������ڰ� �������ں��� Ů�ϴ�.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }
            
            return true;
        }
        

        
        /**
         * �۾�OPEN �� �����սô�.
         * @param - sel_sts (PRO_STS  1:�۾� open, 2:�ο���ȹ�Ϸ�, 3:����ڼ���, 4:�����Ϸ�, 5:�±޿Ϸ�, 6:�޻��۾��Ϸ�, 7:�۾� close)
         */
        function fnc_PROSTS(sel_sts) {

            //��ȿ�� ����
            if(sel_sts == 1 && !fnc_check()) {
                return;
            }
            
            var msg = " �۾��� �Ͻðڽ��ϱ�?";
            switch(sel_sts) {
                case 1: msg = "�۾� OPEN"+msg; break;
                case 2: msg = "�ο���ȹ�Ϸ�"+msg; break;
                case 3: msg = "����ڼ���"+msg; break;
                case 4: msg = "�����Ϸ�"+msg; break;
                case 5: msg = "�±޿Ϸ�"+msg; break;
                case 6: msg = "�޻��۾��Ϸ�"+msg; break;
                case 7: msg = "�۾� CLOSE"+msg; break;
            }
            
            if(!confirm(msg)) {
                return;
            }
            
            
            dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = sel_sts;

			trT_CP_WORKLOG.KeyValue = "SVL(I:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc010.cmd.MISC010CMD&S_MODE=PROC";
            trT_CP_WORKLOG.post();
        }


        /**
         * ���۾� ó��
         */
        function fnc_PROSTS_RESET() {

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1, "PRO_STS")
            
            
            var msg = " ���۾��Ͻðڽ��ϱ�?";
            switch(PRO_STS) {
                case 2: msg = "�ο���ȹ�Ϸ�"+msg; break;
                case 3: msg = "����ڼ���"+msg; break;
                case 4: msg = "�����Ϸ�"+msg; break;
                case 5: msg = "�±޿Ϸ�"+msg; break;
                case 6: msg = "�޻��۾��Ϸ�"+msg; break;
            }
            
            if(!confirm(msg)) {
                return;
            }
            
            dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = fnc_covNumber(PRO_STS)-1;
            
            trT_CP_WORKLOG.KeyValue = "SVL(I:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc010.cmd.MISC010CMD&S_MODE=RESET";
            trT_CP_WORKLOG.post();

        }
        
        
        //�Է� ��ü��
        var elementList = new Array(    "btnMISC01" 
                                       ,"btnMISC02" 
                                       ,"btnMISC03" 
                                       ,"btnMISC04" 
                                       ,"btnMISC05" 
                                       ,"btnMISC06" 
                                       ,"btnMISC07" 
                                       ,"btnMISC08" 
                                       ,"txtPIS_YY"
                                       ,"txtPAY_YMD"
                                       ,"txtAPY_YMD"
                                       ,"ImgPayYmd" 
                                       ,"ImgApyYmd"
                                       ,"img_spinup"
                                       ,"img_spindown" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)   |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CP_WORKLOG                      |
    | 3. Table List : T_CP_WORKLOG                  |
    +----------------------------------------------->
    <Object ID ="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CP_WORKLOG)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        fnc_DisableElementAll(elementList);
        
        document.getElementById("resultMessage").innerText = '';

        if (iCount == 0) {
            dsT_CP_WORKLOG.AddRow();
        
            //�۾������� �����ϰ�        
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        
            fnc_ChangeStateElement(true, "txtPIS_YY");
            fnc_ChangeStateElement(true, "txtPAY_YMD");
            fnc_ChangeStateElement(true, "txtAPY_YMD");
            fnc_ChangeStateElement(true, "ImgPayYmd");
            fnc_ChangeStateElement(true, "ImgApyYmd");
            
            fnc_ChangeStateElement(true, "btnMISC01");
            
            document.getElementById("txtPIS_YY").value = document.getElementById("txtPIS_YY_SHR").value;

        } else {


            switch (dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) {
                case "1" :  // �۾�OPEN �Ϸ����
                    // �ο���ȹ�Ϸ� ��ư Ȱ��ȭ
                    fnc_ChangeStateElement(true, "btnMISC02");
                    
                    document.getElementById("resultMessage").innerText = '�۾��� OPEN �Ͽ����ϴ�. ';

                    break;
                case "2" :  // �ο���ȹ�Ϸ� �Ϸ����
                    // ����ڼ��� ��ư Ȱ��ȭ
                    fnc_ChangeStateElement(true, "btnMISC03");
                    
                    //���۾�
                    fnc_ChangeStateElement(true, "btnMISC08");
                    
                    document.getElementById("resultMessage").innerText = '�ο���ȹ�� �Ϸ��Ͽ����ϴ�. ';

                    break;
                case "3" :  // ����ڼ��� �Ϸ����
                    // �����Ϸ� ��ư Ȱ��ȭ
                    fnc_ChangeStateElement(true, "btnMISC04");
                    
                    //���۾�
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;
                case "4" :  // �����Ϸ����
                    // �±޿Ϸ� ��ư Ȱ��ȭ
                    fnc_ChangeStateElement(true, "btnMISC05");
                    
                    //���۾�
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;

                case "5" :  // �±޿Ϸ� ����
                    // �޻��۾��Ϸ� Ȱ��ȭ
                    fnc_ChangeStateElement(true, "btnMISC06");
                    
                    //���۾�
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;

                case "6" :  // �޻��۾��Ϸ� ����
                    // �۾�CLOSE ��Ȱ��ȭ
                    fnc_ChangeStateElement(true, "btnMISC07");
                    
                    //���۾�
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;

                case "7" :  // �۾��Ϸ����

                    break;
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
    
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CP_WORKLOG event="OnFail()">

        cfErrorMsg(this);

    </script>


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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ȹ�۾�����</td>
                    <td align="right" class="navigator">HOME/�濵����/�����ȹ/<font color="#000000">�����ȹ�۾�����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="100"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">����⵵&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup_shr" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown_shr" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>     
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
                    <col width="120"></col>
                    <col width="200"></col>
                    <col width="120"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                
                    <td class="creamBold" align="center">����⵵</td>
                    <td class="padding2423" align="left">
                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPIS_YY" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                </td>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            </tr>
                        </table>     
                        
                        <input type=hidden id="txtSAL_GBN">
                        <input type=hidden id="txtPRO_STS">
                                    
                    </td> 
                    
                    
                    <td align="center" class="creamBold">���Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtPAY_YMD" name="txtPAY_YMD" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '���Ⱓ FROM����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPayYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPayYmd" name="ImgPayYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPAY_YMD','','340','110');"></a> ~
                        <input id="txtAPY_YMD" name="txtAPY_YMD" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '���Ⱓ TO����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgApyYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgApyYmd" name="ImgApyYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtAPY_YMD','','457','110');"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="194"></col>
	                            <col width="194"></col>
	                            <col width="194"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC01"  style="cursor:hand;width:110pt;height:25pt;" value=" �۾� OPEN "      onclick="fnc_PROSTS(1)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC02"  style="cursor:hand;width:110pt;height:25pt;" value=" �ο���ȹ�Ϸ� "   onclick="fnc_PROSTS(2)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC03"  style="cursor:hand;width:110pt;height:25pt;" value=" ����ڼ��� "     onclick="fnc_PROSTS(3)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC04"  style="cursor:hand;width:110pt;height:25pt;" value=" �����Ϸ� "       onclick="fnc_PROSTS(4)">
                                </td>
                            </tr>
                            <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC05"  style="cursor:hand;width:110pt;height:25pt;" value=" �±޿Ϸ�"        onclick="fnc_PROSTS(5)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC06"  style="cursor:hand;width:110pt;height:25pt;" value=" �޻��۾��Ϸ� " onclick="fnc_PROSTS(6)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC07"  style="cursor:hand;width:110pt;height:25pt;" value=" �۾� CLOSE "     onclick="fnc_PROSTS(7)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC08"  style="cursor:hand;width:110pt;height:25pt;" value=" ���۾� "         onclick="fnc_PROSTS_RESET()">
                                </td>
	                        </tr>
	                    </table>
	                <td>
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


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_WORKLOG">
    <Param Name="BindInfo", Value='
        <C> Col=SAL_GBN       Ctrl=txtSAL_GBN       Param=value </C>
        <C> Col=PRO_STS       Ctrl=txtPRO_STS       Param=value </C>
        <C> Col=PIS_YY        Ctrl=txtPIS_YY        Param=value </C>
        <C> Col=PAY_YMD       Ctrl=txtPAY_YMD       Param=value </C>
        <C> Col=APY_YMD       Ctrl=txtAPY_YMD       Param=value </C>
    '>
</object>