<!--
    ************************************************************************************
    * @Source         : misc040.jsp                                                    *
    * @Description    : �ο������ȹ��Ȳ PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/04 |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�ο������ȹ��Ȳ(misc040)</title>
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
    
        var btnList  = 'TFFTTTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var DPT_CD   = document.getElementById("txtDPT_CD_SHR").value;
            var HIRS_YM  = document.getElementById("cmbHIRS_YM_SHR").value;
            var HIRE_YM  = document.getElementById("cmbHIRE_YM_SHR").value;
            var JOB_CD   = document.getElementById("cmbJOB_CD_SHR").value;
            
            if (PIS_YY == "") {
                alert("����⵵�� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }
            
            if (HIRS_YM > HIRE_YM) {
                alert("��ȹ��� FROM����� ��ȹ��� TO������� Ů�ϴ�.");
                return;
            }
            
            dsT_MI_LEVYPLAN.ClearData();
            
            dsT_MI_LEVYPLAN.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc040.cmd.MISC040CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&DPT_CD="+DPT_CD+"&HIRS_YM="+HIRS_YM+"&HIRE_YM="+HIRE_YM+"&JOB_CD="+JOB_CD;
            dsT_MI_LEVYPLAN.Reset();
            
            form1.grdT_MI_LEVYPLAN.Focus();
            
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

            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var DPT_CD   = document.getElementById("txtDPT_CD_SHR").value;
            var DPT_NM   = document.getElementById("txtDPT_NM_SHR").value;
            var HIRS_YM  = document.getElementById("cmbHIRS_YM_SHR").value;
            var HIRE_YM  = document.getElementById("cmbHIRE_YM_SHR").value;
            var JOB_CD   = document.getElementById("cmbJOB_CD_SHR").value;
            var JOB_NM   = document.getElementById("cmbJOB_CD_SHR").options[document.getElementById("cmbJOB_CD_SHR").selectedIndex].text; 

			var url = "misc040_PV.jsp?pis_yy="+PIS_YY+"&dpt_cd="+DPT_CD+"&dpt_nm="+DPT_NM+"&hirs_ym="+HIRS_YM+"&hire_ym="+HIRE_YM+"&job_cd="+JOB_CD+"&job_nm="+JOB_NM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_MI_LEVYPLAN.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_MI_LEVYPLAN.GridToExcel("�ο������ȹ��Ȳ", '', 225);

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

            document.getElementById("cmbPIS_YY_SHR").selectedIndex = 0;
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            // ��ȹ���(FROM)
            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value, "cmbHIRS_YM_SHR");
            
            // ��ȹ���(TO)
            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value, "cmbHIRE_YM_SHR");
            document.getElementById("cmbJOB_CD_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_MI_LEVYPLAN.ClearData();
            
            form1.cmbPIS_YY_SHR.value = PlanYear;
            document.getElementById("cmbPIS_YY_SHR").focus();

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
            var tempDS = null;
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_MI_LEVYPLAN,0,"false","false");
            
            //����
            tempDS = fnc_GetJobCd();
            
            for( var i=1; i<=tempDS.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = tempDS.NameValue(i,"COMM_CD");
                oOption.text = tempDS.NameValue(i,"COMM_NM");
                document.getElementById("cmbJOB_CD_SHR").add(oOption);
            }
            
            // �İ߻��
            oOption = document.createElement("OPTION");
            oOption.value = 'ZZ';
            oOption.text = '�İ���';
            document.getElementById("cmbJOB_CD_SHR").add(oOption);  
          
            // ����⵵ �� ���Ⱓ ����
            dsT_CP_WORKLOG.ClearData();
            
            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc040.cmd.MISC040CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();
            
            
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
         
        function fnc_setHirYm(pis_yy, fld) {
            
            var oOption;
            var obj     = document.getElementById(fld);
            var Index   = obj.length;
            var Row     = dsT_CP_WORKLOG.NameValueRow("PIS_YY", pis_yy);
            var PAY_YM  = dsT_CP_WORKLOG.NameValue(Row, "PAY_YMD");
            var APY_YM  = dsT_CP_WORKLOG.NameValue(Row, "APY_YMD");
            var Month   = 0; 
            var Month2  = 0;
            var HIR_YM  = 0;
            
            //������ ��ȹ��� ����
            for( var i = Index; i >= 0; i--){

                obj.options.remove(i);

            }
            
            // ��ȹ���
            // ����⵵�� ���⵵�� ���
            if (PAY_YM.substr(0,4) != pis_yy) {

                Month = new Number(PAY_YM.substr(4,2));
                HIR_YM = new Number(PAY_YM);

                for (i = Month; i <= 12; i++) {
                    oOption = document.createElement("OPTION");
                    oOption.value = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    oOption.text  = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    obj.add(oOption);
                    
                    HIR_YM = HIR_YM + 1;
                }
                
                Month2 = new Number(APY_YM.substr(4,2));
                HIR_YM = new Number(pis_yy+"01");

                for (i = 1; i <= Month2; i++) {
                    oOption = document.createElement("OPTION");
                    oOption.value = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    oOption.text  = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    obj.add(oOption);
                    
                    HIR_YM = HIR_YM + 1;
                }
            }
            
            // ����⵵�� ���س⵵�� ���
            if (PAY_YM.substr(0,4) == pis_yy) {
            
                Month  = new Number(PAY_YM.substr(4,2));
                Month2 = new Number(APY_YM.substr(4,2));
                HIR_YM = new Number(PAY_YM);
            
                for (i = Month; i <= Month2; i++) {
                    oOption = document.createElement("OPTION");
                    oOption.value = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    oOption.text  = HIR_YM.toString().substr(0,4)+"-"+HIR_YM.toString().substr(4,2);
                    obj.add(oOption);
                    
                    HIR_YM = HIR_YM + 1;
                }
            }
            
            if (fld == 'cmbHIRS_YM_SHR') {
                obj.value = obj.options[0].text;
            }
            else if (fld == 'cmbHIRE_YM_SHR') {
                obj.value = obj.options[obj.length - 1].text;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_MI_LEVYPLAN)  |
    | 3. ���Ǵ� Table List(T_MI_LEVYPLAN)         |
    +----------------------------------------------->
    <Object ID="dsT_MI_LEVYPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
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
    
    
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_MI_LEVYPLAN.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
    
        var oOption;
        var Index  = document.getElementById("cmbPIS_YY_SHR").length;
    
        if (iCount == 0)    {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ����⵵ ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = getToday().substr(0,4);
            oOption.text  = getToday().substr(0,4);
            document.getElementById("cmbPIS_YY_SHR").add(oOption);

        }
        else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ����⵵ ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            //����⵵
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text  = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                document.getElementById("cmbPIS_YY_SHR").add(oOption);

            }
            
            var obj    = document.getElementById("cmbPIS_YY_SHR");
            var idx    = obj.selectedIndex;
            var PIS_YY = obj.options[idx].text;

            // ��ȹ���
            fnc_setHirYm(PIS_YY, "cmbHIRS_YM_SHR");
            
            // ��ȹ���
            fnc_setHirYm(PIS_YY, "cmbHIRE_YM_SHR");
            
           
            ProSts = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

        }
        
        document.getElementById("cmbPIS_YY_SHR").focus();
    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ο������ȹ��Ȳ</td>
                    <td align="right" class="navigator">HOME/�濵����/�����ȹ/<font color="#000000">�ο������ȹ��Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="ImgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print();"></a>
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
                                <col width="65"></col>
                                <col width="60 "></col>
                                <col width="65 "></col>
                                <col width="180"></col>
                                <col width="65 "></col>
                                <col width="200"></col>
                                <col width="65 "></col>
                                <col width="100"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">����⵵ </td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR" onChange="fnc_setHirYm(this.value, 'cmbHIRS_YM_SHR');fnc_setHirYm(this.value, 'cmbHIRE_YM_SHR');" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">�μ� </td>
                                <td class="padding2423">
                                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3"  maxlength="3" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd1" name="ImgDptCd1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">��ȹ���</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbHIRS_YM_SHR" style="width:45%" >
                                    </select> ~
                                    <select id="cmbHIRE_YM_SHR" style="width:45%" >
                                    </select>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbJOB_CD_SHR" style="width:100%" >
                                        <option value="">��ü</option>
                                    </select>
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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_MI_LEVYPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"                  value="dsT_MI_LEVYPLAN">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'               align=center </C>
                                <C> id='PIS_YY'       width=55    name='����⵵'           align=center </C>
                                <C> id='DPT_NM'       width=90    name='�μ�'               align=left   </C>
                                <C> id='JOB_NM'       width=55    name='����'               align=center </C>
                                <C> id='MF_TNM'       width=60    name='����'               align=center </C>
                                <C> id='HIR_YM'       width=60    name='��ȹ���'           align=center </C>
                                <C> id='HEAD_NM'      width=55    name='����'               align=center </C>
                                <C> id='LEVY_NM'      width=100   name='�������'           align=left   </C>
                                <C> id='JIKMU_NM'     width=100   name='����'               align=left   </C>
                                <C> id='OCC_NM'       width=55    name='�ٷα���'               align=center </C>
                                <C> id='OENO_NO'      width=65    name='�������'           align=center </C>
                                <C> id='OENO_NM'      width=65    name='����'           align=center </C>
                                <C> id='NDPT_NM'      width=90    name='��ȯ�μ�'           align=left   </C>
                                <C> id='REMARK'       width=130   name='�ֿ����'           align=left   </C>
                                <C> id='LEVY_TXT'     width=230   name='����'               align=left   </C>
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

