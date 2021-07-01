<!--
*****************************************************
* @source      : vlua020.jsp
* @description : KPI Pool ���� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/21      ���뼺        �����ۼ�.
* 2007/03/15      ������        ����. (�����򰡾������� �߰�)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%> 

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>KPI Pool ����(vlua020)</title>
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

        var btnList = 'TTTTFFTT';
        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            
            var form     = document.form1;
            var gubun    = GUBUN;
            var kpi_cd   = form.txtKPI_CD_SHR.value;
            var kpi_gb   = form.cmbKPI_GB_SHR.value;
            var checked  = '';
            
            if(form.chkEND_YN_SHR.checked){
                checked = 'T';
            } else {
                checked = 'F';
            }
            
            dsT_EV_KPIPOOL.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua020.cmd.VLUA020CMD&S_MODE=SHR&GUBUN="+gubun+"&KPI_CD="+kpi_cd+"&KPI_GB="+kpi_gb+"&CHECK="+checked;
            dsT_EV_KPIPOOL.reset();

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
                trT_EV_KPIPOOL.KeyValue = "tr01(I:dsT_EV_KPIPOOL=dsT_EV_KPIPOOL)";
                trT_EV_KPIPOOL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua020.cmd.VLUA020CMD&S_MODE=SAV";
                trT_EV_KPIPOOL.post();
            } else {
                return;
            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            
            if(dsT_EV_KPIPOOL.CountRow < 1) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if(confirm("KPI�ڵ� ["+dsT_EV_KPIPOOL.NameValue(dsT_EV_KPIPOOL.RowPosition,"KPI_CD")+"] ������ �����Ͻðڽ��ϱ�?")){
                dsT_EV_KPIPOOL.DeleteRow(dsT_EV_KPIPOOL.RowPosition);
                trT_EV_KPIPOOL.KeyValue = "tr01(I:dsT_EV_KPIPOOL=dsT_EV_KPIPOOL)";
                trT_EV_KPIPOOL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua020.cmd.VLUA020CMD&S_MODE=DEL";
                trT_EV_KPIPOOL.post();
            }

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

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
            
            //DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
            if(dsT_EV_KPIPOOL.CountColumn < 1){
                // �����ͼ��� ��� ���� ����.
                // KEY : KPI_CD
                dsT_EV_KPIPOOL.setDataHeader("GUBUN:STRING, KPI_CD:STRING(4):KEYVALUETYPE, KPI_NM:STRING, KPI_DEC:STRING, KPI_GB:STRING, GAUGE_GB:STRING, FORMULAS:STRING, STR_YMD:STRING, END_YMD:STRING");
            }
            
            dsT_EV_KPIPOOL.AddRow();                                    //Row �߰�
            
            fnc_ColEnabled('E');
            
            document.getElementById("txtKPI_CD").focus();               //�Է� ù��°�� FOCUS
            document.getElementById("txtGUBUN").value   = GUBUN;        // ��������
            document.getElementById("txtSTR_YMD").value = getToday();   //������� �Է¶��� ���� ��¥ ǥ��
            
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
            
            var form = document.form1;
            
            form.txtKPI_CD_SHR.value = '';
            form.cmbKPI_GB_SHR.value = '';
            form.chkEND_YN_SHR.checked = false;
            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_EV_KPIPOOL.ClearData();

            fnc_ColEnabled('D');
            
            form.txtKPI_CD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_KPIPOOL.IsUpdated)  {
                
                if (!fnc_ExitQuestion()) return;
            
            }
            
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var form = document.form1;
            //DataSet�� ���� ���� Ȯ��
            if (!dsT_EV_KPIPOOL.IsUpdated ) {
                    alert("������ �ڷᰡ �����ϴ�.");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                    return false;
            }
            
            for(i=0;i<dsT_EV_KPIPOOL.CountRow;i++){
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_CD") == '') {
                    alert("KPI �ڵ�� �ʼ� �Է� �׸��Դϴ�.");
                    form.txtKPI_CD.focus();
                    return false;
                } else if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_CD").length != 4) {
                    alert("�ڵ�� �ݵ�� 4�ڸ��� �Է� �ϼ���!.");
                    form.txtKPI_CD.focus();
                    return false;
                } else if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_NM") == '') {
                    alert("KPI ���� �ʼ� �Է� �׸��Դϴ�.");
                    dsT_EV_KPIPOOL.RowPosition = i+1;
                    form.txtKPI_NM.focus();
                    return false;
                }else if (dsT_EV_KPIPOOL.NameValue(i+1,"KPI_GB") == '') {
                    alert("KPI ������ �ʼ� �Է� �׸��Դϴ�.");
                    dsT_EV_KPIPOOL.RowPosition = i+1;
                    form.cmbKPI_GB.focus();
                    return false;
                }else if (dsT_EV_KPIPOOL.NameValue(i+1,"GAUGE_GB") == '') {
                    alert("�跮 ������ �ʼ� �Է� �׸��Դϴ�.");
                    dsT_EV_KPIPOOL.RowPosition = i+1;
                    form.cmbGAUGE_GB.focus();
                    return false;
                }
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD") != '') {
                    if (!cfDateExpr(dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD"))){
                        alert("������ڰ� ��¥���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_KPIPOOL.RowPosition = i+1;
                        form.txtSTR_YMD.focus();
                        return false;
                    }
                }
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD") != '') {
                    if (!cfDateExpr(dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD"))){
                        alert("������ڰ� ��¥���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_KPIPOOL.RowPosition = i+1;
                        form.txtEND_YMD.focus();
                        return false;
                    }
                }
                
                if (dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD") != '' && dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD") != '') {
                    if(removeChar(dsT_EV_KPIPOOL.NameValue(i+1,"STR_YMD"),'-') > removeChar(dsT_EV_KPIPOOL.NameValue(i+1,"END_YMD"),'-')) {
                        alert("������ڴ� �ݵ�� ������ں��� �۾ƾ��մϴ�.");
                        form.txtSTR_YMD.focus();
                        return false;
                    }
                }

            }

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_KPIPOOL,15,"false","right")      // Grid Style ����
            
            // ��������
            if (frameid == "vlua020") {
                // �λ���
                GUBUN = "01";                
                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";
            }
            else {
                // ������
                GUBUN = "02";            
                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }
            
            fnc_ColEnabled('D');
            
            form1.txtKPI_CD_SHR.focus();                               // ó�� �׸� Focus

        }


        /****************************************
         * 15. ���ڿ� �����ڸ� ������ üũ  *
         ***************************************/
        function fnc_NumCharCheck() {
            if (!((event.keyCode > 47)&&(event.keyCode < 58)) && 
                !((event.keyCode > 64)&&(event.keyCode < 91)) && 
                !((event.keyCode > 96)&&(event.keyCode < 123))) {
                    event.returnValue=false;
                }
            }

        /********************
         * 16. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }
        
        
        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {
            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {
                form1.txtKPI_CD.disabled   = false;
                form1.txtKPI_NM.disabled   = false;
                form1.txtKPI_DEC.disabled  = false;
                form1.cmbKPI_GB.disabled   = false;
                form1.cmbGAUGE_GB.disabled = false;
                form1.txtFORMULAS.disabled = false;
                form1.txtSTR_YMD.disabled  = false;
                form1.txtEND_YMD.disabled  = false;
                
                document.getElementById("image20").disabled=false;
                document.getElementById("image21").disabled=false;
            }
            // �ش� �÷��� �Ӽ��� Disabled�� ����
            else if (prop == 'D') {
                form1.txtKPI_CD.disabled   = true;
                form1.txtKPI_NM.disabled   = true;
                form1.txtKPI_DEC.disabled  = true;
                form1.cmbKPI_GB.disabled   = true;
                form1.cmbGAUGE_GB.disabled = true;
                form1.txtFORMULAS.disabled = true;
                form1.txtSTR_YMD.disabled  = true;
                form1.txtEND_YMD.disabled  = true;
                
                document.getElementById("image20").disabled=true;
                document.getElementById("image21").disabled=true;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_KPIPOOL)   |
    | 3. ���Ǵ� Table List(T_EV_KPIPOOL)          |
    +----------------------------------------------->
    <object id="dsT_EV_KPIPOOL" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"       value="true">
        <param name="UseChangeInfo"  value="true">
    </object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_KPIPOOL)   |
    | 3. ���Ǵ� Table List(TEST_T_EV_KPIPOOLMAIN) |
    +----------------------------------------------->
    <object id="trT_EV_KPIPOOL" classid=CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5>
        <param name=KeyName value="toinb_dataid4">
    </object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    <script language=JavaScript for="dsT_EV_KPIPOOL" event=OnLoadCompleted(iCount)>
        
            if (iCount < 1)    {

                fnc_Message(document.getElementById("resultMessage"), "MSG_02");
                
                fnc_ColEnabled('D');
                
                document.form1.txtKPI_CD_SHR.focus();

            } else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
                
                fnc_ColEnabled('E');
                
                document.form1.grdT_EV_KPIPOOL.focus();

            }

    </script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <script language="javascript"  for="dsT_EV_KPIPOOL" event="OnLoadError()">
        
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_KPIPOOL Event="OnDataError(row, colid)">

        //Dataset���� Error ó��
        //alert(row + " : " + colid);
        // Ű�� NOT NULL�� ���
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[KPI�ڵ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("KPI�ڵ忡 ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script language="javascript" for=trT_EV_KPIPOOL event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script language="javascript" for=trT_EV_KPIPOOL event="OnFail()">
        
        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">KPI Pool ����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">KPI Pool ����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="15"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="center" class="searchBold">KPI�ڵ�/��&nbsp;</td>
                                <td><input name="txtKPI_CD_SHR" id="txtKPI_CD_SHR" class="divInput" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()" size="15"></td>
                                <td align="right" class="searchBold">KPI����&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbKPI_GB_SHR" onChange="fnc_SearchList()">
                                        <option value="">��ü</option>
                                        <option value="1">����</option>
                                        <option value="2">�</option>
                                        <option value="3">��ȹ/����</option>
                                    </select> </td>
                                <td class="padding2423">
                                    <input type="checkbox" name="chkEND_YN_SHR" id=chkEND_YN_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()"></td>
                                <td align="left" class="searchBold">����ڷ�����</td>
                                <td>&nbsp;</td>
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
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                    <td align="center" class="creamBold">KPI�ڵ�</td>
                    <td class="padding2423"><input id=txtKPI_CD size="8" maxlength="4" style="ime-mode:disabled" onkeypress="fnc_NumCharCheck();"></td>
                    <td align="center" class="creamBold">KPI��</td>
                    <td class="padding2423"><input id=txtKPI_NM value="" size="16" maxlength="50"></td>
                    <td align="center" class="creamBold">KPI���</td>
                    <td class="padding2423"><input id=txtKPI_DEC value="" style="WIDTH: 100%" maxlength="100">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">KPI����</td>
                    <td class="padding2423">
                        <select id="cmbKPI_GB" style="WIDTH: 100%">
                            <option value="1">����</option>
                            <option value="2">�</option>
                            <option value="3">��ȹ/����</option>
                        </select> </td>
                    <td align="center" class="creamBold">�跮����</td>
                    <td class="padding2423">
                        <select id="cmbGAUGE_GB" style="WIDTH: 100%">
                            <option value="1">�跮</option>
                            <option value="2">��跮</option>
                        </select> </td>
                    <td align="center" class="creamBold">�����</td>
                    <td class="padding2423"><input id="txtFORMULAS" value="" style="WIDTH: 100%" maxlength="50">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD');cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','45','150');"></a>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD');cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image21" name="Image21" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','235','150');"></a>
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
                        <object    id="grdT_EV_KPIPOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
                            <param name="DataID"                    value="dsT_EV_KPIPOOL">
                            <param name="Format"                    value="
                                <C> id='KPI_CD'      width=80       name='KPI�ڵ�'        align=center</C>
                                <C> id='KPI_NM'      width=150      name='KPI��'          align=left </C>
                                <C> id='KPI_DEC'     width=200      name='KPI���'        align=left </C>
                                <C> id='KPI_GB'      width=80       name='KPI����'        align=left EditStyle=Combo Data='1:����,2:�,3:��ȹ/����'</C>
                                <C> id='GAUGE_GB'    width=100      name='�跮����'       align=left EditStyle=Combo Data='1:�跮,2:��跮'</C>
                                <C> id='FORMULAS'    width=154      name='�����'         align=left </C>
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
<!-- KPI Pool ���� ���̺� -->
<object id="bndT_EV_KPIPOOL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_KPIPOOL">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN           Ctrl=txtGUBUN           Param=value  Disable=disabled</C>
        <C>Col=KPI_CD          Ctrl=txtKPI_CD          Param=value  Disable=disabled</C>
        <C>Col=KPI_NM          Ctrl=txtKPI_NM          Param=value</C>
        <C>Col=KPI_DEC         Ctrl=txtKPI_DEC         Param=value</C>
        <C>Col=KPI_GB          Ctrl=cmbKPI_GB          Param=value</C>
        <C>Col=GAUGE_GB        Ctrl=cmbGAUGE_GB        Param=value</C>
        <C>Col=FORMULAS        Ctrl=txtFORMULAS        Param=value</C>
        <C>Col=STR_YMD         Ctrl=txtSTR_YMD         Param=value</C>
        <C>Col=END_YMD         Ctrl=txtEND_YMD         Param=value</C>
    '>
</object>
