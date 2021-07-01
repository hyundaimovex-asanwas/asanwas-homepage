<!--*************************************************************************
* @source      : yaca050.jsp                                                *
* @description : ������������ȸ PAGE                                      *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2013/12/18            �̵���             �����ۼ�  
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");

    //���������� �ƴ��� ����
    boolean isMaster = false;

    if(YAC_AUTHO.equals("M")) {
        isMaster = true;
    }
%>

<html>
<head>
    <title>������������ȸ(yaca050)</title>
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
                    + "F"   //����
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca050.cmd.YACA050CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            if (!fnc_SearchItemCheck()) return;

            var oPIS_YY = document.getElementById("txtPIS_YY_SHR");
            var oENO_NO = document.getElementById("txtENO_NO_SHR");

            params = "&S_MODE=SHR"
                   + "&PIS_YY="+oPIS_YY.value
                   + "&ENO_NO="+oENO_NO.value;

            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         */
        function fnc_SearchEmp() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm('txtENO_NO_SHR');

            if(document.getElementById("txtENO_NO_SHR").value != "") {
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtOCC_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
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

            fnc_ClearInputFieldAll(); //��� �Է�â�� �ʱ�ȭ

            //����� �α����� ������� ������ ���� �⺻������ �����´�.
            document.getElementById("txtENO_NO_SHR").value = "<%=ls_UserId %>";

            //��� ���� ��ȸ
            fnc_SearchEmp();

        	//document.form1.txtPIS_YY_SHR.value = getTodayArray()[0] - 1;
        	document.form1.txtPIS_YY_SHR.value = '2012';        	
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETACC.ClearData();
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            var pis_yy = document.getElementById("txtPIS_YY_SHR").value;

            if(pis_yy == "" || pis_yy.length != 4) {
                alert("�ͼӳ⵵�� �߸��Է� �Ǿ����ϴ�.");
                return false;
            }

            if(parseInt(pis_yy) < 2012) {
                alert("2012�� ���� �ڷ���� ��ȸ�����մϴ�.");
                return false;
            }
            return true;
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

            //����� �α����� ������� ������ ���� �⺻������ �����´�.
            document.getElementById("txtENO_NO_SHR").value = "<%=ls_UserId %>";

            //��� ���� ��ȸ
            fnc_SearchEmpNo();

            //�ͼӳ⵵ �ʱⰪ ����
            //document.getElementById("txtPIS_YY_SHR").value = getTodayArray()[0] - 1;
            document.getElementById("txtPIS_YY_SHR").value = '2012';


<%
    //�����ڰ� �ƴ� ��� Ÿ���� ��ȸ�� ���� �ʰ�
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
        //    document.getElementById("ImgEnoNo").style.display = "none";
<%
    } else {
%>
			document.getElementById("ImgEnoNo").style.display = "";
<%
    }
%>

           fnc_SearchList();
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


        var oFieldList = new Array(  "TAX_INCOME"
                                    ,"MGR_AMT"
                                    ,"MNI_AMT"
                                    ,"BADD_AMT"
                                    ,"SPSB_AMT"
                                    ,"GDED_AMT"
                                    ,"GOL_AMT70"
                                    ,"TBL_DED"
                                    ,"WDD_AMT"
                                    ,"RCH_AMT"
                                    ,"SMD_AMT"
                                    ,"INP_AMT"
                                    ,"NPEN_DED"
                                    ,"MIN_DED"
                                    ,"MMA_DED"
                                    ,"GRA_AMT"
                                    ,"CHI_DED"
                                    ,"HIG_DED"
                                    ,"UNI_DED"
                                    ,"HED_AMT"
                                    ,"LOAN_DED"
                                    ,"MRENT_DED"
                                    ,"LONG_DED"
                                    ,"SAVE_DED"
                                    ,"CPC_DED"

                                    ,"NSE_TOT"
                                    ,"MNI_TOT"
                                    ,"PER_SAV"
                                    ,"ANN_DED"

                                    ,"CARD_DED"
                                    ,"STOCK_DED"
                                    ,"TTAX_STD"
                                    ,"TAX_AMT"
                                    ,"HGR_DED"
                                    ,"HTX_DED"
                                    ,"OTX_DED"
                                    ,"GOV_DED"
                                    ,"TDED_TOT"
                                    ,"DGG_TAX"
                                    ,"DJM_TAX"
                                    ,"DGG_DJM"
                                    ,"AGG_TAX"
                                    ,"AJM_TAX"
                                    ,"AGG_AJM"                                    
                                    ,"DRE_INTX"
                                    ,"DRE_CTTX"
                                    ,"INTX_CTTX");

        var oElementList = new Array("txtTAX_INCOME"
                                    ,"txtMGR_AMT"
                                    ,"txtMNI_AMT"
                                    ,"txtBADD_AMT"
                                    ,"txtSPSB_AMT"
                                    ,"txtGDED_AMT"
                                    ,"txtGOL_AMT70"
                                    ,"txtTBL_DED"
                                    ,"txtWDD_AMT"
                                    ,"txtRCH_AMT"
                                    ,"txtSMD_AMT"
                                    ,"txtINP_AMT"
                                    ,"txtNPEN_DED"
                                    ,"txtMIN_DED"
                                    ,"txtMMA_DED"
                                    ,"txtGRA_AMT"
                                    ,"txtCHI_DED"
                                    ,"txtHIG_DED"
                                    ,"txtUNI_DED"
                                    ,"txtHED_AMT"
                                    ,"txtLOAN_DED"
                                    ,"txtMRENT_DED"
                                    ,"txtLONG_DED"
                                    ,"txtSAVE_DED"
                                    ,"txtCPC_DED"

                                    ,"txtNSE_TOT"
                                    ,"txtMNI_TOT"
                                    ,"txtPER_SAV"
                                    ,"txtANN_DED"

                                    ,"txtCARD_DED"
                                    ,"txtSTOCK_DED"
                                    ,"txtTTAX_STD"
                                    ,"txtTAX_AMT"
                                    ,"txtHGR_DED"
                                    ,"txtHTX_DED"
                                    ,"txtOTX_DED"
                                    ,"txtGOV_DED"
                                    ,"txtTDED_TOT"
                                    ,"txtDGG_TAX"
                                    ,"txtDJM_TAX"
                                    ,"txtDGG_DJM"
                                    
                                    ,"txtAGG_TAX"
                                    ,"txtAJM_TAX"
                                    ,"txtAGG_AJM"                                    
                                    ,"txtDRE_INTX"
                                    ,"txtDRE_CTTX"
                                    ,"txtINTX_CTTX");



        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtOCC_NM_SHR").value      = obj.occ_cd+" "+obj.occ_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtOCC_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
        }

        function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

        }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }
		function KeyEventHandle()
		{
		if(
		( event.ctrlKey == true && ( event.keyCode == 78 || event.keyCode == 82 ) ) ||
		( event.keyCode >= 112 && event.keyCode <= 123 ))
		{
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
		}
		}
		document.onkeydown=KeyEventHandle;
		document.onkeyup=KeyEventHandle;



//		 function clickIE(){
//		  if (document.all) {(message);return false;}
//		  }
//		 function clickNS(e){
//		  if (document.layers||(document.getElementByld&!document.all)){
//		  if (e.witch==2||e.which==3){(messae);return false;}}}
//		  if (document.layers){
//		   document.captureEvents(Event.MOUSEDOWN);document.onmousedown=clickNS;}
//		  else{
//		   document.onmouseup=clickNS;document.oncontextmenu=clickIE;}
//		   document.oncontextmenu=new Function("return false")
		   
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
	//		alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);

            for(var i =0; i<oFieldList.length; i++) {
                
                document.getElementById(oElementList[i]).value = formatNumber(dsT_AC_RETACC.NameString(1, oFieldList[i]));

            }

            //document.getElementById("txtTAMP_AMT1").value = "0";
            //document.getElementById("txtTAMP_AMT2").value = "0";
            //document.getElementById("txtTAMP_AMT3").value = "0";
        }
        
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Grid Head Check event ó��                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_RETACC event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_AC_RETACC.CountRow; i++) {
            dsT_AC_RETACC.NameValue(i, "STATUS") = bCheck;
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������ȸ</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">������������ȸ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
                                    <td class="padding2423" align="left">
                                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                        			<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>                                                
                                           <!--   <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()"> -->
                                                </td>
                                                <!--  
                                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                            </tr>
                                            <tr>
                                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                            -->
                                            
                                            </tr>
                                        </table>
                                    </td>

                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchEmp();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchEmp();" style="ime-mode:disabled">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="DISPLAY:none">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
                                    </td>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchEmp();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchEmp();">
                                    </td>

                                </tr>
                                <tr>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="12" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="20" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="12" class="input_ReadOnly" readonly>
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
    					<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->


    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="400" valign="top" style="padding-right:5px">

                <!-- ù��° ���̺� -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="70"></col>
                        <col width="70"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center" colspan="3">�������޿�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTAX_INCOME" id="txtTAX_INCOME" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly onchange="this.value=formatNumber(this.value)"> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="3">�ٷμҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtMGR_AMT" id="txtMGR_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="3">�������ٷμҵ�ݾ�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtMNI_AMT" id="txtMNI_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="center" rowspan="3">�⺻����</td>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtBADD_AMT" id="txtBADD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtSPSB_AMT" id="txtSPSB_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�ξ簡��</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtGDED_AMT" id="txtGDED_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="center" rowspan="6">�߰�����</td>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">��ο��(70��)</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtGOL_AMT70" id="txtGOL_AMT70" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTBL_DED" id="txtTBL_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�γ���</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtWDD_AMT" id="txtWDD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">6�� ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtRCH_AMT" id="txtRCH_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">������Ծ�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtINP_AMT" id="txtINP_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">���ڳ��߰�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtSMD_AMT" id="txtSMD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="3">���ݺ�������</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtNPEN_DED" id="txtNPEN_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="center" rowspan="12">Ư������</td>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtMIN_DED" id="txtMIN_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�Ƿ��</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtMMA_DED" id="txtMMA_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" rowspan="5">������</td>
                        <td class="creamBold" align="left" style="padding-left:10px">����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtGRA_AMT" id="txtGRA_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px">������</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtCHI_DED" id="txtCHI_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px">���߰�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtHIG_DED" id="txtHIG_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px">���л�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtUNI_DED" id="txtUNI_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px">�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtHED_AMT" id="txtHED_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�����������Կ����ݻ�ȯ</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtLOAN_DED" id="txtLOAN_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">������</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtMRENT_DED" id="txtMRENT_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" colspan="2">�������������������</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtLONG_DED" id="txtLONG_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px"  colspan="2">��α�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtCPC_DED" id="txtCPC_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px"  colspan="2">�հ�(Ư������)</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtNSE_TOT" id="txtNSE_TOT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                </table>
                <!-- ù��° ���̺� -->

            </td>
            <td valign="top">

                <!-- �ι�° ���̺� -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="140"></col>
                        <col width="*"></col>
                    </colgroup>


                    <tr>
                        <td class="creamBold" align="center" colspan="2">�����ҵ�ݾ�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtMNI_TOT" id="txtMNI_TOT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="2">���ο������� �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtPER_SAV" id="txtPER_SAV" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="2">�������� �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtANN_DED" id="txtANN_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="2">���ø������� �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtSAVE_DED" id="txtSAVE_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <!--
                    <tr>
                        <td class="creamBold" align="center" colspan="2">������������ �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtVEN_DED" id="txtVEN_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    -->
                    <tr>
                        <td class="creamBold" align="center" colspan="2">�ſ�ī���� �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtCARD_DED" id="txtCARD_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="2">����ֽ������� �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtSTOCK_DED" id="txtSTOCK_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    
                    <!--  
                    <tr>
                        <td class="creamBold" align="center" colspan="2">�츮�������� �ҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTAMP_AMT1" id="txtTAMP_AMT1" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    -->
                    
                    <tr>
                        <td class="creamBold" align="center" colspan="2">���ռҵ����ǥ��</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTTAX_STD" id="txtTTAX_STD" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center" colspan="2">���⼼��</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTAX_AMT" id="txtTAX_AMT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>

                    <tr>
                        <td class="creamBold" align="center" rowspan="6">���װ���</td>
                        <td class="creamBold" align="left" style="padding-left:10px" >���鼼�װ�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTAMP_AMT2" id="txtTAMP_AMT2" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" >�ٷμҵ漼�װ���</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtHGR_DED" id="txtHGR_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" >�����ڱ����Ա�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtHTX_DED" id="txtHTX_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" >�ܱ����μ��װ���</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtOTX_DED" id="txtOTX_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" >��ġ�ڱݼ��װ���</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtGOV_DED" id="txtGOV_DED" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="left" style="padding-left:10px" >���װ�����</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtTDED_TOT" id="txtTDED_TOT" size="15" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                </table>
                <!-- �ι�° ���̺� -->

                <br><br>

                <!-- ����° ���̺� -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="95"></col>
                        <col width="95"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center"></td>
                        <td class="creamBold" align="center">�ҵ漼</td>
                        <td class="creamBold" align="center">�ֹμ�</td>
                        <td class="creamBold" align="center">��</td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">��������</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtDGG_TAX" id="txtDGG_TAX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtDJM_TAX" id="txtDJM_TAX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtDGG_DJM" id="txtDGG_DJM" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">�ⳳ�ξ�</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtAGG_TAX" id="txtAGG_TAX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtAJM_TAX" id="txtAJM_TAX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtAGG_AJM" id="txtAGG_AJM" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">ȯ�޼���</td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtDRE_INTX" id="txtDRE_INTX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtDRE_CTTX" id="txtDRE_CTTX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid" readonly> ��
                        </td>
                        <td class="padding2423" style="padding-left:10px">
                            <input type="text" name="txtINTX_CTTX" id="txtINTX_CTTX" size="10" style="text-align:right;" style="ime-mode:disabled" onkeypress="cfCheckNumber();" style="border: #333333 1px solid; color:red" readonly > ��
                        </td>
                    </tr>
                </table>
                <!-- ����° ���̺� -->

            </td>
        </tr>
    </table>


    </form>
    <!-- form �� -->

</body>
</html>

