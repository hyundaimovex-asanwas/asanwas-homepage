<!--
    ************************************************************************************
    * @Source         : cdpc050.jsp                                                    *
    * @Description    : �İ��κ�����Ȳ PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/26 |  ������   | �����ۼ�                                                *
    * 2007/04/17 |  ���м�   | �μ��߰�                                                *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�İ��κ�����Ȳ(cdpc050)</title>
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
    
        var btnList = 'TTTTTTFT';
        var role_cd = '';
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var MENO_NO  = document.getElementById("txtMENO_NO_SHR").value;
            var MENO_NM  = document.getElementById("txtMENO_NM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            
            if (role_cd != "1001"
                    && rolce_cd != "1002") {
                alert("��ȸ������ �����ϴ�.");
                return;
            }
            
            // �İ��λ��
            if( MENO_NO == '' ) {
                alert("�İ��λ���� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            if( MENO_NM == '' ) {
                alert("�İ��λ���� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            // �İ߽�������
            if( STR_YMD == '' ) {
                alert("�İ߱Ⱓ FROM���ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            } 
            
            // �İ߽������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "�İ߱�� FROM����") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }
            
            // �İ߱Ⱓ TO����
            if( END_YMD == '' ) {
                alert("�İ߱Ⱓ TO���ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            } 
            
            // �İ߱Ⱓ TO���� CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "�İ߱Ⱓ TO����") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }
            
            // �İ߱Ⱓ FROM���ڿ� TO���� ��
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("�İ߱Ⱓ FROM���ڴ� �ݵ�� �İ߱Ⱓ TO���ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }
                    
            dsT_CD_MENTO.ClearData();
            
            dsT_CD_MENTO.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc050.cmd.CDPC050CMD&S_MODE=SHR&MENO_NO="+MENO_NO+"&ENO_NO="+ENO_NO+"&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD;
            dsT_CD_MENTO.Reset();
            
            form1.grdT_CD_MENTO.Focus();
            
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
            var MENO_NO  = document.getElementById("txtMENO_NO_SHR").value;
            var MENO_NM  = document.getElementById("txtMENO_NM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            
            if (role_cd != "1001"
                    && rolce_cd != "1002") {
                alert("��ȸ������ �����ϴ�.");
                return;
            }
            
            // �İ��λ��
            if( MENO_NO == '' ) {
                alert("�İ��λ���� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            if( MENO_NM == '' ) {
                alert("�İ��λ���� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            // �İ߽�������
            if( STR_YMD == '' ) {
                alert("�İ߱Ⱓ FROM���ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            } 
            
            // �İ߽������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "�İ߱�� FROM����") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }
            
            // �İ߱Ⱓ TO����
            if( END_YMD == '' ) {
                alert("�İ߱Ⱓ TO���ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            } 
            
            // �İ߱Ⱓ TO���� CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "�İ߱Ⱓ TO����") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }
            
            // �İ߱Ⱓ FROM���ڿ� TO���� ��
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("�İ߱Ⱓ FROM���ڴ� �ݵ�� �İ߱Ⱓ TO���ں��� �۾ƾ��մϴ�.");
                    document.getElementById("txtSTR_YMD").focus();
                    return false;
                }
            }
            var url = "cdpc050_PV.jsp?MENO_NO="+MENO_NO+"&ENO_NO="+ENO_NO+"&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");


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

            document.getElementById("txtMENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtMENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtENO_NO_SHR").value   = '';
            document.getElementById("txtENO_NM_SHR").value   = '';
            
            fnc_SetDateTerm();
            
            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_CD_MENTO.ClearData();
            
            document.getElementById("txtMENO_NO_SHR").focus();

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
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_CD_MENTO,0,"false","false");
            
            document.getElementById("txtMENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtMENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            
            fnc_SetDateTerm();
            
            // �α��λ���� �ý��۱����� ������ �ִ��� Ȯ��
            dsT_CM_EMPLIST.ClearData();
            
            dsT_CM_EMPLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc050.cmd.CDPC050CMD&S_MODE=SHR_00&ENO_NO="+'<%=box.get("SESSION_ENONO")%>';
            dsT_CM_EMPLIST.Reset();
            
            document.getElementById("txtENO_NO_SHR").focus();
            
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
        
        // �İ߱Ⱓ SET
        function fnc_SetDateTerm() {
            var dateinfo = getToday().split("-");
                
            //from - to ��¥�� �����ϱ�
            var schDate  = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);  
            var fromDate = null;
            var toDate   = null;
            
            fromDate = new Date(schDate.getFullYear(), schDate.getMonth(), "01");
            toDate   = new Date(schDate.getFullYear(), schDate.getMonth(), fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1));
            
            // FROM ����
            document.getElementById("txtSTR_YMD_SHR").value = fnc_MakeDateString(fromDate);
            
            // TO ����
            document.getElementById("txtEND_YMD_SHR").value = fnc_MakeDateString(toDate);

        }
         
        // DATE���� STRING(YYYY-MM-DD)���� ���ڷ� ��ȯ
        function fnc_MakeDateString(date) {
            var year  = date.getYear();
            var month = date.getMonth() + 1;
            var date  = date.getDate();

            if (month < 10) {
                month = "0" + month;
            }
            
            if (date < 10) {
                date = "0" + date;
            }

            return year + "-" + month + "-" + date
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTO)     |
    | 3. ���Ǵ� Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EMPLIST)   |
    | 3. ���Ǵ� Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CD_MENTO                        |
    | 3. Table List : T_CD_MENTO                    |
    +----------------------------------------------->
    <Object ID ="trT_CD_MENTO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_MENTO)">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_MENTO.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {

            // �ý��۱��ѿ� ���� �İ��λ�� enable ����
            role_cd = dsT_CM_EMPLIST.NameValue(1, "ROLE_CD");
           
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�İ��κ�����Ȳ</td>
                    <td align="right" class="navigator">HOME/��������/CDP/���丵����/<font color="#000000">�İ��κ�����Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                            <tr>
                                <td align="right" class="searchState">�İ��λ��</td>
                                <td class="padding2423"><input id=txtMENO_NO_SHR name=txtMENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtMENO_NO_SHR','txtMENO_NM_SHR','1','1');"> <input id=txtMENO_NM_SHR name=txtMENO_NM_SHR size="8" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMenoNo1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMenoNo1" name="ImgMenoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtMENO_NO_SHR','txtMENO_NM_SHR','','','','','2')"></a>
                                </td> 
                                <td align="right" class="searchState">���İ��λ��</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo1" name="ImgEnoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','2')"></a>
                                </td>
                                <td align="right" class="searchState">�İ߱Ⱓ</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�İ߱Ⱓ FROM����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~ 
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�İ߱Ⱓ TO����');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_MENTO" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"             value="dsT_CD_MENTO">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=40    name='����'       align=center </C>
                                <G> name='���İ���' HeadBgColor='#F7DCBB'
                                    <C> id='DPT_NM'          width=80    name='�Ҽ�'       align=left   </C>
                                    <C> id='JOB_NM'          width=60    name='����'       align=center </C>
                                    <C> id='ENO_NO'          width=60    name='���'       align=center </C>
                                    <C> id='ENO_NM'          width=60    name='����'       align=center </C>
                                </G>
                                <G> name='�İ���' HeadBgColor='#F7DCBB'
                                    <C> id='MDPT_NM'         width=80    name='�Ҽ�'       align=left   </C>
                                    <C> id='MJOB_NM'         width=60    name='����'       align=center </C>
                                    <C> id='MENO_NO'         width=60    name='���'       align=center </C>
                                    <C> id='MENO_NM'         width=60    name='����'       align=center </C>
                                </G>
                                <G> name='�İ߱Ⱓ' HeadBgColor='#F7DCBB'
                                    <C> id='STR_YMD'         width=80    name='��������'   align=center </C>
                                    <C> id='END_YMD'         width=80    name='��������'   align=center </C>
                                </G>
                                <C> id='IPT_YMD'             width=80    name='�ۼ�����'   align=center </C>
                                <C> id='OBJ_TXT'             width=220   name='����'       align=left   </C>
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

