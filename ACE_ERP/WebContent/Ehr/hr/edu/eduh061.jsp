<!--
    ************************************************************************************
    * @Source         : eduh061.jsp                                                    *
    * @Description    : �系�������_�űԵ�� PAGE                                     *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/28  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>�系�������_�űԵ��(eduh061)</title>
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
    
        var btnList = 'FFTFFFFT';
        
        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_LCTRLIST.ClearData();
            
            dsT_ED_LCTRLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh061.cmd.EDUH061CMD&S_MODE=SHR&CET_NO="+opener.cet_no;
            dsT_ED_LCTRLIST.Reset();
            
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

            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            trT_ED_LCTRLIST.KeyValue = "tr01(I:SAV=dsT_ED_LCTRLIST)";
            trT_ED_LCTRLIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh061.cmd.EDUH061CMD&S_MODE=SAV";
            trT_ED_LCTRLIST.post();
            
            
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
            var LCT_Q5_GBN = '';
            
            for( i = 1; i <= dsT_ED_LCTRLIST.CountRow; i++ ) {
                // ���Ǻо�
                for (var j = 0; j < document.getElementById('cmbLCT_Q5_GBN').options.length; j++) {
                    if (document.getElementById('cmbLCT_Q5_GBN').options[j].selected == true) {
                        LCT_Q5_GBN = LCT_Q5_GBN + document.getElementById('cmbLCT_Q5_GBN').options[j].value + '|';
                    }
                }
                
                dsT_ED_LCTRLIST.NameValue(i, "LCT_Q5_GBN") = LCT_Q5_GBN.substr(0, LCT_Q5_GBN.length - 1);
            }
                        
            if (!dsT_ED_LCTRLIST.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
            
            if ( dsT_ED_LCTRLIST.isUpdated) {
                for( i = 1; i <= dsT_ED_LCTRLIST.CountRow; i++ ) {
                    if( dsT_ED_LCTRLIST.RowStatus(i) == 1 || 
                        dsT_ED_LCTRLIST.RowStatus(i) == 3 ) {
                        
                        // ���籸��
                        if( dsT_ED_LCTRLIST.NameValue(i, "LCT_CD") == '' ) {
                            alert("���籸���� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbLCT_CD").focus();
                            return false;
                        }
                        
                        // ���Ǻо�
                        if( dsT_ED_LCTRLIST.NameValue(i, "LCT_Q5_GBN") == '' ) {
                            alert("���Ǻоߴ� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbLCT_Q5_GBN").focus();
                            return false;
                        }
                        
                        // �����
                        if( dsT_ED_LCTRLIST.NameValue(i, "ENO_NM") == '' ) {
                            alert("�����ְ��� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtENO_NM").focus();
                            return false;
                        }
                        
                        // �ֹι�ȣ
                        if( dsT_ED_LCTRLIST.NameValue(i, "CET_NO") == '' ) {
                            alert("�ֹι�ȣ�� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtCET_NO").focus();
                            return false;
                        }
                        
                        // �ֹι�ȣ CHECK
                        if (!fnc_SsnValid(document.getElementById("txtCET_NO"))) {
                            document.getElementById("txtCET_NO").focus();
                            return false;
                        }
                        
                        if (document.getElementById('txtE_MAIL1').value != '') {
                            // �̸��� CHECK
                            if (!fnc_ChgEmail('txtE_MAIL1')) {
                                document.getElementById('txtE_MAIL1').focus();
                                return false;
                            }
                        }
                        
                        if (document.getElementById('txtE_MAIL2').value != '') {
                            // �̸��� CHECK
                            if (!fnc_ChgEmail('txtE_MAIL2')) {
                                document.getElementById('txtE_MAIL2').focus();
                                return false;
                            }
                        }
                        
                        if ( dsT_ED_LCTRLIST.RowStatus(i) == 1) {
                            document.getElementById("txtCET_NO").disabled = true;
                        }
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_ComboSet();            

            // ������ �����̸�
            if (opener.gbn == "2") {

                document.getElementById('txtCET_NO').value = opener.cet_no;
            
                // �������� ������ ��ȸ
                fnc_SearchList();
            }
            else {
            
                fnc_ColEnabled('E');
                
                // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
                if (dsT_ED_LCTRLIST.CountColumn == 0) {
                    dsT_ED_LCTRLIST.setDataHeader("LCT_CD:STRING, LCT_Q5_GBN:STRING, ENO_NM:STRING, ENO_NO:STRING, DPT_NM:STRING, JOB_NM:STRING, CET_NO:STRING:KEYVALUETYPE, HIR_YMD:STRING, LCT_TXT:STRING, SCH_TXT:STRING, LIC_TXT:STRING, ETC_TXT:STRING, ADDR_TXT:STRING, PHN_NO:STRING, EM_PHN_NO:STRING, E_MAIL1:STRING, E_MAIL2:STRING, BANK_TAG:STRING, CAR_TAG:STRING");
                }
                
                // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
                dsT_ED_LCTRLIST.AddRow();
                
                document.getElementById('cmbLCT_CD').focus();
            }
            
        }
        
        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_ED_LCTRLIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }
            
            window.close();
        }
        
        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }
        
        
        /********************
         * �޺��ڽ� �� SET  *
         ********************/
        function fnc_ComboSet() {
            var oOption = null;        

            //���籸��
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbLCT_CD").add(oOption);
                
            }
            
            //�����о�
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbLCT_Q5_GBN").add(oOption);
                
            }
            
        }

        
        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("cmbLCT_CD").disabled     = false;
                document.getElementById("cmbLCT_Q5_GBN").disabled = false;
                document.getElementById("txtENO_NM").disabled     = false;
                document.getElementById("txtENO_NO").disabled     = false;
                document.getElementById("txtDPT_NM").disabled     = false;
                document.getElementById("txtJOB_NM").disabled     = false;
                document.getElementById("txtCET_NO").disabled     = false;
                document.getElementById("txtHIR_YMD").disabled    = false;
                document.getElementById("txtLCT_TXT").disabled    = false;
                document.getElementById("txtSCH_TXT").disabled    = false;
                document.getElementById("txtLIC_TXT").disabled    = false;
                document.getElementById("txtETC_TXT").disabled    = false;
                document.getElementById("txtADDR_TXT").disabled   = false;
                document.getElementById("txtPHN_NO").disabled     = false;
                document.getElementById("txtEM_PHN_NO").disabled  = false;
                document.getElementById("txtE_MAIL1").disabled    = false;
                document.getElementById("txtE_MAIL2").disabled    = false;
                document.getElementById("txtBANK_TAG").disabled   = false;
                document.getElementById("txtCAR_TAG").disabled    = false;
                
                document.getElementById("ImgEnoNo").disabled      = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("cmbLCT_CD").disabled     = true;
                document.getElementById("cmbLCT_Q5_GBN").disabled = true;
                document.getElementById("txtENO_NM").disabled     = true;
                document.getElementById("txtENO_NO").disabled     = true;
                document.getElementById("txtDPT_NM").disabled     = true;
                document.getElementById("txtJOB_NM").disabled     = true;
                document.getElementById("txtCET_NO").disabled     = true;
                document.getElementById("txtHIR_YMD").disabled    = true;
                document.getElementById("txtLCT_TXT").disabled    = true;
                document.getElementById("txtSCH_TXT").disabled    = true;
                document.getElementById("txtLIC_TXT").disabled    = true;
                document.getElementById("txtETC_TXT").disabled    = true;
                document.getElementById("txtADDR_TXT").disabled   = true;
                document.getElementById("txtPHN_NO").disabled     = true;
                document.getElementById("txtEM_PHN_NO").disabled  = true;
                document.getElementById("txtE_MAIL1").disabled    = true;
                document.getElementById("txtE_MAIL2").disabled    = true;
                document.getElementById("txtBANK_TAG").disabled   = true;
                document.getElementById("txtCAR_TAG").disabled    = true;
                
                document.getElementById("ImgEnoNo").disabled      = true;
                
            }
            
            if (opener.gbn == '2') {
                document.getElementById("txtCET_NO").disabled     = true;
                document.getElementById("ImgEnoNo").disabled      = true;
            }
            
        }
        
        /***************************************
         * �������˻� ��ư Ŭ���� ó�� ��ƾ    *
         ***************************************/
        function fnc_Popup() {
            var obj = new String();
            
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        
            document.getElementById("txtENO_NO").value  = obj.eno_no; 
            document.getElementById("txtENO_NM").value  = obj.eno_nm; 
            document.getElementById("txtDPT_NM").value  = obj.dpt_nm; 
            document.getElementById("txtJOB_NM").value  = obj.job_nm; 
            document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
            
            if (opener.gbn != '2') {
                document.getElementById("txtCET_NO").value  = obj.cet_no;
            }
        }
        
        function fnc_ChangeFld() {
            if (document.getElementById("txtENO_NM").value == "") {
                document.getElementById("txtENO_NO").value  = "";
                document.getElementById("txtDPT_NM").value  = "";            
                document.getElementById("txtJOB_NM").value  = "";            
                document.getElementById("txtHIR_YMD").value = "";            
            }
            else if (document.getElementById("txtENO_NO").value == "") {
                document.getElementById("txtDPT_NM").value  = "";            
                document.getElementById("txtJOB_NM").value  = "";            
                document.getElementById("txtHIR_YMD").value = ""; 
            }
        }
        
        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("�߸��� �ֹι�ȣ�Դϴ�. Ȯ�ιٶ��ϴ�.");
                    return false;
                }
            }
            
            return true;
        }
        
        function fnc_ChgEmail(fld) {
            var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
        
            if (document.getElementById(fld).value.search(format) == -1) {
                alert("��ȿ�� �̸��� �ּҰ� �ƴմϴ�.");
                document.getElementById(fld).focus();
                
                return false;
            }
        
            return true;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_LCTRLIST)|
    | 3. ���Ǵ� Table List(T_ED_LCTRLIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_LCTRLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
   
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_LCTRLIST)|
    | 3. ���Ǵ� Table List(T_ED_LCTRLIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_LCTRLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_LCTRLIST)">
    </Object>
    
    <!-- ���� �޺��� ���� DataSet -->
    <!-- ���籸�� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- ���Ǻо� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_LCTRLIST Event="OnLoadCompleted(iCount)">
        var LCT_Q5_GBN = '';
        var Index = 0;

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            // ��ư�� ������ ����.
            document.getElementById("view_1").style.display='none';
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_LCTRLIST.CountRow );
            
            if (dsT_ED_LCTRLIST.NameValue(1, "IPT_MAN") == '<%=box.get("SESSION_ENONO")%>') {
        
                // ��ư�� ����
                document.getElementById("view_1").style.display='inline';
                
                fnc_ColEnabled('E');
            }
            else {
                
                // ��ư�� ������ ����.
                document.getElementById("view_1").style.display='none';
            
                fnc_ColEnabled('D');
            }
            
            LCT_Q5_GBN = dsT_ED_LCTRLIST.NameValue(1, "LCT_Q5_GBN");

            while (LCT_Q5_GBN != "") {

                index = LCT_Q5_GBN.indexOf("|");

                for (var i = 0; i <  document.getElementById('cmbLCT_Q5_GBN').options.length; i++) {

                    if (index != -1) {
                        if (document.getElementById('cmbLCT_Q5_GBN').options[i].value == LCT_Q5_GBN.substr(0, LCT_Q5_GBN.indexOf("|"))) {
                            document.getElementById('cmbLCT_Q5_GBN').options[i].selected = true;
                            break;
                        }
                    }
                    else {
                        if (document.getElementById('cmbLCT_Q5_GBN').options[i].value == LCT_Q5_GBN) {
                            document.getElementById('cmbLCT_Q5_GBN').options[i].selected = true;
                            break;
                        }
                    }
                }
                
                LCT_Q5_GBN = LCT_Q5_GBN.substr(LCT_Q5_GBN.indexOf("|") + 1, LCT_Q5_GBN.length - LCT_Q5_GBN.indexOf("|"));

                if (index == -1) {
                    break;
                }
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>
    
    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    
   
    <!-- Ʈ������ ����. -->
    <script for=trT_ED_LCTRLIST event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
        opener.fnc_SearchList();
        
        window.close();
        
    </script>
    
    <!--Ʈ������ ���� -->
    <script for=trT_ED_LCTRLIST event="OnFail()">
    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�系�������_�űԵ��</td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="120"></col>
                    <col width="280"></col>
                    <col width="120"></col>
                    <col width="280"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">���籸��</td>
                    <td class="padding2423" >
                        <select id="cmbLCT_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">���Ǻо�</td>
                    <td class="padding2423" >
                        <select id="cmbLCT_Q5_GBN" multiple style="height:50;width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" name="txtENO_NM" size="16" onChange="fnc_ChangeFld();">
                        <input type=button id='ImgEnoNo' value="�������˻�" onclick="fnc_Popup();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO"  name="txtENO_NO" style="width:100%" maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_ChangeFld();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtDPT_NM" name="txtDPT_NM" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtJOB_NM" name="txtJOB_NM" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ֹι�ȣ</td>
                    <td class="padding2423">
                        <input id="txtCET_NO"  name="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onChange="fnc_SsnValid(this);">
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD"  name="txtHIR_YMD" style="width:100%;ime-mode:disabled" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ֿ䰭�Ǻо�</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtLCT_TXT"  name="txtLCT_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�з�/��������</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtSCH_TXT"  name="txtSCH_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ڰ�/������</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtLIC_TXT"  name="txtLIC_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">����/��Ÿ</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtETC_TXT"  name="txtETC_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423"  colspan="3">
                        <input id="txtADDR_TXT"  name="txtADDR_TXT" style="width:100%;" maxlength="120" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��ȭ��ȣ</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO"  name="txtPHN_NO" style="width:100%;" maxlength="16" >
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO"  name="txtEM_PHN_NO" style="width:100%;" maxlength="16" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">E-Mail 1</td>
                    <td class="padding2423" >
                        <input id="txtE_MAIL1" name="txtE_MAIL1" style="width:100%"  onChange="fnc_ChgEmail('txtE_MAIL1');">
                    </td>
                    <td align="center" class="creamBold">E-Mail 2</td>
                    <td class="padding2423" >
                        <input id="txtE_MAIL2" name="txtE_MAIL2" style="width:100%"  onChange="fnc_ChgEmail('txtE_MAIL1');">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�Աݰ���</td>
                    <td class="padding2423" >
                        <input id="txtBANK_TAG" name="txtBANK_TAG" style="width:100%" >
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtCAR_TAG" name="txtCAR_TAG" style="width:100%" >
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
<!-- �򰡴���ڼ��� ���̺� -->
<object id="bndT_ED_LCTRLIST"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_LCTRLIST">
    <Param Name="BindInfo", Value='
        <C>Col=LCT_CD       Ctrl=cmbLCT_CD      Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=CET_NO       Ctrl=txtCET_NO      Param=value </C>
        <C>Col=HIR_YMD      Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=LCT_TXT      Ctrl=txtLCT_TXT     Param=value </C>
        <C>Col=SCH_TXT      Ctrl=txtSCH_TXT     Param=value </C>
        <C>Col=LIC_TXT      Ctrl=txtLIC_TXT     Param=value </C>
        <C>Col=ETC_TXT      Ctrl=txtETC_TXT     Param=value </C>
        <C>Col=ADDR_TXT     Ctrl=txtADDR_TXT    Param=value </C>
        <C>Col=PHN_NO       Ctrl=txtPHN_NO      Param=value </C>
        <C>Col=EM_PHN_NO    Ctrl=txtEM_PHN_NO   Param=value </C>
        <C>Col=E_MAIL1      Ctrl=txtE_MAIL1     Param=value </C>
        <C>Col=E_MAIL2      Ctrl=txtE_MAIL2     Param=value </C>
        <C>Col=BANK_TAG     Ctrl=txtBANK_TAG    Param=value </C>
        <C>Col=CAR_TAG      Ctrl=txtCAR_TAG     Param=value </C>
    '>                                         
</object>