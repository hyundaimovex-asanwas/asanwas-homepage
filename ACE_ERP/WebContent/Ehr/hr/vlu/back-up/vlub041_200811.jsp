<!--
    ************************************************************************************
    * @Source         : vlub041.jsp                                                    *
    * @Description    : ������ǥ PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/26  |  ������   | �����ۼ�                                               *
    * 2007/03/16  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
<title>������ǥ�ۼ�(vlub041)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //��������
    String EVL_YY     = request.getParameter("EVL_YY");         //�ش�⵵
    String EVL_GBN    = request.getParameter("EVL_GBN");        //����(����/����)
    String EVL_FRQ    = request.getParameter("EVL_FRQ");        //ȸ��
    String IPT_STDT   = request.getParameter("IPT_STDT");       //���Է±Ⱓ(����)
    String IPT_ENDT   = request.getParameter("IPT_ENDT");       //���Է±Ⱓ(����)
    String ENO_NO     = request.getParameter("ENO_NO");         //�����ڻ��
    String DEGREE_GBN = request.getParameter("DEGREE_GBN");     //����
    String EVLENO_NO  = request.getParameter("EVLENO_NO");      //���ڻ��
    String UPDN_GBN   = request.getParameter("UPDN_GBN");       //��/�����򰡱���
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
    
        var btnList = 'FFTFFFFT';
    
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            
            // DATASET �ʱ�ȭ
            fnc_Clear();
            
            var GUBUN      = "<%=GUBUN%>";
            var EVL_YY     = form1.txtEVL_YY_SHR.value;
            var EVL_GBN    = form1.txtEVL_GBN_SHR.value;
            var EVL_FRQ    = form1.txtEVL_FRQ_SHR.value;
            var ENO_NO     = form1.txtENO_NO_SHR.value;
            var UPDN_GBN   = form1.txtUPDN_GBN_SHR.value;
            var DEGREE_GBN = form1.txtDEGREE_GBN_SHR.value;
            var EVLENO_NO  = form1.txtEVLENO_NO_SHR.value;
            
            form1.txtFLAG.value = "1"; // ��ȸFLAG
            
            // �������̸�
            if (UPDN_GBN == '2') {
            
                trT_EV_ABLTBL.KeyValue = "tr01(O:SHR=dsT_EV_ABLTBL,O:SHR2=dsT_EV_EVLIST_HD)";
                trT_EV_ABLTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub041.cmd.VLUB041CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&UPDN_GBN="+UPDN_GBN+"&DEGREE_GBN="+DEGREE_GBN+"&EVLENO_NO="+EVLENO_NO;
                trT_EV_ABLTBL.post();
            }
            else {
                trT_EV_ABLTBL.KeyValue = "tr01(O:SHR=dsT_EV_ABLTBL,O:SHR2=dsT_EV_EVLIST_HD)";
                trT_EV_ABLTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub041.cmd.VLUB041CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&UPDN_GBN="+UPDN_GBN+"&DEGREE_GBN="+DEGREE_GBN+"&EVLENO_NO="+EVLENO_NO;
                trT_EV_ABLTBL.post();
            }
            
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
            
            var UPDN_GBN   = form1.txtUPDN_GBN_SHR.value;
            var DEGREE_GBN = form1.txtDEGREE_GBN_SHR.value;
            
            // ����� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            form1.txtFLAG.value = "2"; // ����FLAG
            
            trT_EV_ABLTBL.KeyValue = "tr01(I:SAV=dsT_EV_ABLTBL)";
            trT_EV_ABLTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub041.cmd.VLUB041CMD&S_MODE=SAV&UPDN_GBN="+UPDN_GBN+"&DEGREE_GBN="+DEGREE_GBN;
            trT_EV_ABLTBL.post();
            
            dsT_EV_ABLTBL.UseChangeInfo = "true";
            
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

            if (dsT_EV_ABLTBL.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            
            form1.mgrdT_EV_ABLTBL.GridToExcel("������ǥ", '', 4);

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

            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_EV_ABLTBL.ClearData();

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

            var SUBPNT = 0;

            // ���� 1���� �۰ų� 10���� ũ�� ������ ���� �ʵ��� �Ѵ�.            
            for (var i = 1; i<= dsT_EV_ABLTBL.CountRow; i++) {
                
                if ( dsT_EV_ABLTBL.NameValue(i, "SUBPNT_01") < 1  || 
                     dsT_EV_ABLTBL.NameValue(i, "SUBPNT_01") > 10 ) {
                    alert("["+dsT_EV_ABLTBL.NameValue(i, "EST_NM")+"]["+dsT_EV_ABLTBL.NameValue(i, "ABL_NM")+"]�� �ൿ��ǥ�� ������ ���������� ���� �ƴմϴ�.\n�ش� ������ �Է��Ͻñ� �ٶ��ϴ�.");
                    
                    form1.mgrdT_EV_ABLTBL.Draw = false;
                    form1.mgrdT_EV_ABLTBL.RowPosition    = i;
                    form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_01";
                    form1.mgrdT_EV_ABLTBL.Draw = true;
            
                    form1.mgrdT_EV_ABLTBL.Focus();
                    return false;
                }
                
                if ( dsT_EV_ABLTBL.NameValue(i, "SUBPNT_02") < 1  || 
                     dsT_EV_ABLTBL.NameValue(i, "SUBPNT_02") > 10 ) {
                    alert("["+dsT_EV_ABLTBL.NameValue(i, "EST_NM")+"]["+dsT_EV_ABLTBL.NameValue(i, "ABL_NM")+"]�� �ൿ��ǥ�� ������ ���������� ���� �ƴմϴ�.\n�ش� ������ �Է��Ͻñ� �ٶ��ϴ�.");
                    
                    form1.mgrdT_EV_ABLTBL.Draw = false;
                    form1.mgrdT_EV_ABLTBL.RowPosition    = i;
                    form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_02";
                    form1.mgrdT_EV_ABLTBL.Draw = true;
            
                    form1.mgrdT_EV_ABLTBL.Focus();
                    return false;
                }
                
                if ( dsT_EV_ABLTBL.NameValue(i, "SUBPNT_03") < 1  || 
                     dsT_EV_ABLTBL.NameValue(i, "SUBPNT_03") > 10 ) {
                    alert("["+dsT_EV_ABLTBL.NameValue(i, "EST_NM")+"]["+dsT_EV_ABLTBL.NameValue(i, "ABL_NM")+"]�� �ൿ��ǥ�� ������ ���������� ���� �ƴմϴ�.\n�ش� ������ �Է��Ͻñ� �ٶ��ϴ�.");
                    
                    form1.mgrdT_EV_ABLTBL.Draw = false;
                    form1.mgrdT_EV_ABLTBL.RowPosition    = i;
                    form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_03";
                    form1.mgrdT_EV_ABLTBL.Draw = true;
            
                    form1.mgrdT_EV_ABLTBL.Focus();
                    return false;
                }
             
            }
            
            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
    
            form1.txtEVL_YY_SHR.value     = "<%=EVL_YY%>";
            form1.txtEVL_GBN_SHR.value    = "<%=EVL_GBN%>";
            form1.txtEVL_FRQ_SHR.value    = "<%=EVL_FRQ%>";
            form1.txtIPT_STDT_SHR.value   = "<%=IPT_STDT%>";
            form1.txtIPT_ENDT_SHR.value   = "<%=IPT_ENDT%>";
            form1.txtENO_NO_SHR.value     = "<%=ENO_NO%>";
            form1.txtDEGREE_GBN_SHR.value = "<%=DEGREE_GBN%>";
            form1.txtEVLENO_NO_SHR.value  = "<%=EVLENO_NO%>";
            form1.txtUPDN_GBN_SHR.value   = "<%=UPDN_GBN%>";
            
            if ("<%=GUBUN%>" == "01") {
                //�򰡱׷�
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {
                    
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                    
                }
                
            }
            else if ("<%=GUBUN%>" == "02") {
                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;
                
                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }
                
            }
            
            //Grid Style ����
            //cfStyleGrid(dsT_EV_ABLTBL, "comn", false);
            
            // �׸��忡 ���κ������򰡴���ڼ��� ������ ��ȸ
            fnc_SearchList();
            
            form1.txtAVG_PNT.value  = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);
            form1.txtAVG_PNT2.value = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);

        }
        
        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {
            var SUBPNT_AVG = null;

            if (dsT_EV_ABLTBL.IsUpdated)
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
        
        
    </script>

    </head>



    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLTBL)    |
    | 3. ���Ǵ� Table List(T_EV_ABLTBL)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr + �ֿ� ���̺��(T_EV_ABLTBL)     |
    | 3. ���Ǵ� Table List(T_EV_ABLTBL)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_ABLTBL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ABLTBL)">
    </Object>
    
    <!-- ���� �޺��� ���� DataSet -->
    <!-- �򰡱׷� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    
    <script for=dsT_EV_ABLTBL Event=onColumnChanged(row,colid)>
    
        var SUBPNT_AVG = 0;
        
        if ( colid == 'SUBPNT_01' || 
             colid == 'SUBPNT_02' || 
             colid == 'SUBPNT_03' ) {
                 
            // ���� �Է½� ��հ��� ���Ѵ�. (�Ҽ��� ��°�ڸ����� �ݿø�)
            SUBPNT_AVG = (dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_01') + dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_02') + dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_03')) / 3;
            SUBPNT_AVG = new Number(SUBPNT_AVG).toFixed(2);
            dsT_EV_ABLTBL.NameValue(row, 'SUBPNT_AVG') = SUBPNT_AVG;
            
            form1.txtAVG_PNT.value = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);
        
        }
        
        
        
    </script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLTBL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
        } else {

            // ���ʵ���ڰ� ���ٸ� �����Ͱ� ������ǥ�� ���� �������� flag �ʵ忡 SETTING
            if (dsT_EV_ABLTBL.NameValue(1, "IPT_MAN").trim() == "") {
                
                dsT_EV_ABLTBL.UseChangeInfo = "false";
            }
            
            form1.mgrdT_EV_ABLTBL.Draw = false;
            form1.mgrdT_EV_ABLTBL.RowPosition    = 1;
            form1.mgrdT_EV_ABLTBL.ColumnPosition = "SUBPNT_01";
            form1.mgrdT_EV_ABLTBL.Draw = true;
            
            form1.mgrdT_EV_ABLTBL.Focus();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLTBL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLTBL Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EV_ABLTBL event="OnSuccess()">
    
        if (form1.txtFLAG.value == "1") {
            dsT_EV_EVLIST_HD.RowPosition = 1;
        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");
            
            form1.txtAVG_PNT2.value = dsT_EV_ABLTBL.Sum(dsT_EV_ABLTBL.ColumnIndex("SUBPNT_AVG"),0,0);
            window.returnValue = new Number(form1.txtAVG_PNT2.value).toFixed(2);
            
        }
        
    </script>
    
    <!--Ʈ������ ���� -->
    <script for=trT_EV_ABLTBL event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>
    
    
    <script language=JavaScript for=mgrdT_EV_ABLTBL event=OnKeyDown(keycode,keystate)>

        if (keycode == 13) {
            
            if (mgrdT_EV_ABLTBL.ColumnPosition == 'SUBPNT_01') {
                mgrdT_EV_ABLTBL.ColumnPosition ='SUBPNT_02';
                mgrdT_EV_ABLTBL.focus();
            }
            else if (mgrdT_EV_ABLTBL.ColumnPosition == 'SUBPNT_02') {
                mgrdT_EV_ABLTBL.ColumnPosition ='SUBPNT_03';
                mgrdT_EV_ABLTBL.focus();
            }
            else if (mgrdT_EV_ABLTBL.ColumnPosition == 'SUBPNT_03') {
                
                if (mgrdT_EV_ABLTBL.RowPosition==dsT_EV_ABLTBL.CountRow) return false;
                
                mgrdT_EV_ABLTBL.RowPosition = mgrdT_EV_ABLTBL.RowPosition + 1;
                mgrdT_EV_ABLTBL.ColumnPosition ='SUBPNT_01';
                mgrdT_EV_ABLTBL.focus();
            }
            
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ǥ�ۼ�</span></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="580">
        <table width="580" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>���������� </strong></td>
            </tr>
            <tr>
                <td class="paddingTop3">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="580" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="110"></col>
                            <col width="180"></col>
                            <col width="110"></col>
                            <col width="180"></col>
                        </colgroup>
                        <tr>
                            <td align="center" height="25" class="creamBold">�򰡱���</td>
                            <td class="padding2423">
                                <input id=txtEVL_YY_SHR  name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly> ��&nbsp;
                                <input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly> ȸ��
                            </td>
                            <td align="center" class="creamBold">�򰡱Ⱓ</td>
                            <td class="padding2423">
                                <input id=txtIPT_STDT_SHR name=txtIPT_STDT_SHR size="10" class="input_ReadOnly" readonly> ~
                                <input id=txtIPT_ENDT_SHR name=txtIPT_ENDT_SHR size="10" class="input_ReadOnly" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">�򰡱׷�</td>
                            <td class="padding2423" class="input_ReadOnly" readonly>
                                <select id=cmbGROUP_CD_SHR name=cmbGROUP_CD_SHR disabled="true">
                                </select>
                            </td>
                            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                            <td class="padding2423"><input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="28" class="input_ReadOnly" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">������</td>
                            <td class="padding2423">
                                <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly>
                                <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="14" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">����</td>
                            <td class="padding2423">
                                <input id=txtDEGREE_GBN_SHR name=txtDEGREE_GBN_SHR size="2" maxlength=2 class="input_ReadOnly" readonly> �� ����&nbsp;
                                <input id=txtEVLENO_NM_SHR  name=txtEVLENO_NM_SHR size="12" class="input_ReadOnly" readonly>
                            </td>
                            <!-- Hidden Filed -->
                            <input type=hidden id=txtEVL_GBN_SHR   name=txtEVL_GBN_SHR>
                            <input type=hidden id=txtEVLENO_NO_SHR name=txtEVLENO_NO_SHR>
                            <input type=hidden id=txtUPDN_GBN_SHR  name=txtUPDN_GBN_SHR>
                            <input type=hidden name=txtFLAG>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
        <td width="20">&nbsp;</td>
        <td width="200">
        <table width="200" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>�������� </strong></td>
            </tr>
            <tr>
                <td class="paddingTop3">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="200" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="45"></col>
                            <col width="65"></col>
                            <col width="45"></col>
                            <col width="65"></col>
                        </colgroup>
                        <tr>
                            <td height="25" class="creamBold" align="center">Ź��</td>
                            <td class="padding2423">&nbsp;9 ~ 10</td>
                            <td class="creamBold" align="center">���</td>
                            <td class="padding2423">&nbsp;7 ~ 8</td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center">��ȣ</td>
                            <td class="padding2423">&nbsp;5 ~ 6</td>
                            <td class="creamBold" align="center">����</td>
                            <td class="padding2423">&nbsp;3 ~ 4</td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center">����</td>
                            <td class="padding2423" colspan="3">&nbsp;1 ~ 2</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
<table>
    
<!-- ���� �Է� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15" width="600" ><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�������Է� </strong>
        </td>
        <td width="200" align="right" class="searchState" valign="bottom">
            ������ ��&nbsp;<input id=txtAVG_PNT  name=txtAVG_PNT size="6" style="text-align:right;font-weight:bold;" readonly>
            <!-- DB�� �ݿ��� �������� ���� ��հ� (ȣ���� ȭ�鿡 �Ѱ��ֱ� ���� ����)-->
            <input type=hidden id=txtAVG_PNT2  name=txtAVG_PNT2 size="5" >
        </td>
    </tr>
</table>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="mgrdT_EV_ABLTBL" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=800 height=304>
                            <Param Name="DataID"         value="dsT_EV_ABLTBL">
                            <Param Name="IndicatorInfo"     value='<INDICATORINFO width="0"></INDICATORINFO>'>
                            <param name="Sort"           value="false">
                            <Param Name="ColumnInfo"     value='
                              <COLUMNINFO>
                                <COLUMN id="EST_NM" refcolid="EST_NM">
                                    <HEADER left="0" top="0" right="70" bottom="35" bgcolor="#F7DCBB" text="�� ��"/>
                                    <SUPPRESS>
                                        <REFCOLID>EST_NM</REFCOLID>
                                    </SUPPRESS>
                                    <VIEW   left="0" top="0" right="70" bottom="66" bgcolor="#FEFBF6" align="centercenter"/>
                                </COLUMN>
                                <COLUMN id="ABL_NM" refcolid="ABL_NM">
                                    <HEADER left="70" top="0" right="140" bottom="35" bgcolor="#F7DCBB" text="�� �� ��"/>
                                    <VIEW   left="70" top="0" right="140" bottom="66" bgcolor="#FEFBF6" align="centercenter"/>
                                </COLUMN>
                                <COLUMN id="SUBITEM_01" refcolid="SUBITEM_01">
                                    <HEADER left="140" top="0" right="660" bottom="35" bgcolor="#F7DCBB" text="��      ��      ��      ǥ"/>
                                    <VIEW   left="140" top="0" right="660" bottom="22" bgcolor="#FEFBF6" align="leftcenter"/>
                                </COLUMN>
                                <COLUMN id="SUBITEM_02" refcolid="SUBITEM_02">
                                    <HEADER left="140" top="0"  right="660" bottom="35" bgcolor="#F7DCBB" text="��      ��      ��      ǥ"/>
                                    <VIEW   left="140" top="22" right="660" bottom="44" bgcolor="#FEFBF6" align="leftcenter"/>
                                </COLUMN>
                                <COLUMN id="SUBITEM_03" refcolid="SUBITEM_03">
                                    <HEADER left="140" top="0"  right="660" bottom="35" bgcolor="#F7DCBB" text="��      ��      ��      ǥ"/>
                                    <VIEW   left="140" top="44" right="660" bottom="66" bgcolor="#FEFBF6" align="leftcenter"/>
                                </COLUMN>

                                <COLUMN id="SUBPNT_01" refcolid="SUBPNT_01">
                                    <HEADER left="660" top="0" right="695" bottom="35" bgcolor="#F7DCBB" text="����"/>
                                    <VIEW   left="660" top="0" right="695" bottom="22" align="rightcenter"/>
                                    <CHILD type="edit" inputtype="num"/>
                                </COLUMN>
                                <COLUMN id="SUBPNT_02" refcolid="SUBPNT_02">
                                    <HEADER left="660" top="0"  right="695" bottom="35" bgcolor="#F7DCBB" text="����"/>
                                    <VIEW   left="660" top="22" right="695" bottom="44" align="rightcenter"/>
                                    <CHILD type="edit" inputtype="num"/>
                                </COLUMN>
                                <COLUMN id="SUBPNT_03" refcolid="SUBPNT_03">
                                    <HEADER left="660" top="0"  right="695" bottom="35" bgcolor="#F7DCBB" text="����"/>
                                    <VIEW   left="660" top="44" right="695" bottom="66" align="rightcenter"/>
                                    <CHILD type="edit" inputtype="num"/>
                                </COLUMN>

                                <COLUMN id="WEIGHT" refcolid="WEIGHT">
                                    <HEADER left="695" top="0" right="740" bottom="35" bgcolor="#F7DCBB" text="����ġ"/>
                                    <VIEW   left="695" top="0" right="740" bottom="66" bgcolor="#FEFBF6" align="rightcenter"/>
                                </COLUMN>    
                                <COLUMN id="SUBPNT_AVG" refcolid="SUBPNT_AVG">
                                    <HEADER left="740" top="0" right="778" bottom="35" bgcolor="#F7DCBB"  text="���"/>
                                    <VIEW   left="740" top="0" right="778" bottom="66" bgcolor="#FEFBF6" align="rightcenter"/>
                                </COLUMN>
                             </COLUMNINFO>'>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
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
<object id="bndT_EV_EVLIST_HD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_EVLIST_HD">
    <Param Name="BindInfo", Value='
        <C>Col=EVL_YY       Ctrl=txtEVL_YY_SHR     Param=value </C>
        <C>Col=EVL_GBN      Ctrl=txtEVL_GBN_SHR    Param=value </C>
        <C>Col=EVL_FRQ      Ctrl=txtEVL_FRQ_SHR    Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO_SHR     Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM_SHR     Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM_SHR     Param=value </C>
        <C>Col=GROUP_CD     Ctrl=cmbGROUP_CD_SHR   Param=value </C>
        <C>Col=DEGREE_GBN   Ctrl=txtDEGREE_GBN_SHR Param=value </C>
        <C>Col=EVLENO_NO    Ctrl=txtEVLENO_NO_SHR  Param=value </C>
        <C>Col=EVLENO_NM    Ctrl=txtEVLENO_NM_SHR  Param=value </C>
    '>
</object>