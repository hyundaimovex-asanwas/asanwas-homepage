<!--*************************************************************************
* @source      : reta020.jsp                                                *
* @description : �������߰������û��Ȳ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�������߰������û��Ȳ(reta020)</title>
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
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta020.cmd.RETA020CMD";
        var params = null;


        //���� �׸��� ������ ����
        var gridFormat =   "<C> id='{CUROW}'        width=40        align=center        name='NO'                       HeadBgColor='#F7DCBB'   value={String(Currow)}</C>"
                         + "<C> id=DPT_NM           width=70        align=center        name='�� ��'                    HeadBgColor='#F7DCBB'   Edit=None SubSumText='��'</C>"
                         + "<C> id=JOB_NM           width=70        align=center        name='�� ��'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=ENO_NM           width=70        align=center        name='�� ��'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=IPT_YMD          width=70        align=center        name='��û��'                   HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=APP_YN           width=50        align=center        name='����'                   HeadBgColor='#F7DCBB'   EditStyle=Combo  Pointer=Hand Data='A:��û,R:����,N:�ݼ�,Y:����'    BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "<C> id=HIRG_YMD         width=70        align=center        name='�Ի���'                   HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=RAM_YMD          width=70        align=center        name='�߰�������'               HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<G> name='�������'     HeadBgColor='#F7DCBB'"
                         + "    <C> id=REQ_YMD      width=70        align=center        name='�������'                 HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=RET_LSE_YMD  width=110       align=center        name='�ټӱⰣ (A)'             HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=AVG_PAY      width=130       align=right         name='����ӱ�/�� (B)'          HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "    <C> id=RET_PAY      width=150       align=right         name='�������Ѿ� (C = A x B)'   HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "</G>"
                         + "<G> name='�߰����� ��û����'     HeadBgColor='#F7DCBB'"
                         + "    <C> id=SEQ_NO       width=40        align=center        name='�� ��'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=BASIC_YMD    width=70        align=center        name='�������'                 HeadBgColor='#F7DCBB'   Edit=Numeric        Mask='XXXX/XX/XX'        BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "    <C> id=MID_LSE_YMD  width=110       align=center        name='�� ��'                    HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "    <C> id=MID_PAY      width=110       align=right         name='�� ��'                    HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "    <C> id=MID_PAY_PER  width=50        align=center        name='%'                        HeadBgColor='#F7DCBB'   Edit=None</C> SubSumText=''"
                         + "    <C> id=Expr         width=70        align=right         name='�������ܾ�'               value={RET_PAY-MID_PAY} HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "</G>"
                         + "<X> name='��������ȸ ����(��)' HeadBgColor='#F7DCBB'"
                         + "    <C> id=APP_YMD      width=70        align=center        name='�������'                 HeadBgColor='#F7DCBB'     Edit=Numeric       Mask='XXXX/XX/XX'        BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "    <C> id=APP_LSE_YMD  width=110       align=center        name='�� ��'                    HeadBgColor='#F7DCBB'     Edit=None</C>"
                         + "    <C> id=APP_PAY      width=110       align=right         name='�� ��'                    HeadBgColor='#F7DCBB'     rightmargin=10             BgColor='#EEEEEE'   SubBgColor='#ffffe1'</C>"
                         + "    <R>"
                         + "        <G> name='��������'            HeadBgColor='#F7DCBB'"
                         + "            <C> id=Expr         width=110       align=right         name='ȸ������'        value={if(APP_PAY-BNK_SUM > 0, APP_PAY-BNK_SUM, 0)} HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "            <C> id=BNK_SUM      width=110       align=right         name=' �� '            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>" ;

        //���� �׸��� ���� �޺κ�
        var gridFormat2 =  "        </G>"
                         + "    </R>"
                         + "    <R>"
                         + "        <G> name='������'            HeadBgColor='#F7DCBB'"
                         + "            <C> id=ICM_TAX      width=110       align=right         name='�ҵ漼'            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "            <C> id=DBW_TAX      width=110       align=right         name='�����Ư����'            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "            <C> id=DJM_TAX      width=110       align=right         name='�ֹμ�'            HeadBgColor='#F7DCBB'   Edit=None rightmargin=10</C>"
                         + "        </G>"
                         + "    </R>"
                         + "</X>"
                         + "<C> id=REASON_NM        width=120       align=center        name='��û����'                 HeadBgColor='#F7DCBB'   Edit=None</C>"
                         + "<C> id=REASON           width=180       align=center        name='��û���� ��'                 HeadBgColor='#F7DCBB'   Edit=None</C>";


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�
            if(!fnc_SearchItemCheck()) return;

            //�˻�����
            var oSTR_YMD = document.getElementById("txtSTR_YMD_SHR");
            var oEND_YMD = document.getElementById("txtEND_YMD_SHR");
            var oDPT_CD = document.getElementById("txtDPT_CD_SHR");
            var oAPP_YN = document.getElementById("cmbAPP_YN_SHR");

            params = "&S_MODE=SHR"
                   + "&DPT_CD="+oDPT_CD.value
                   + "&STR_YMD="+oSTR_YMD.value
                   + "&END_YMD="+oEND_YMD.value
                   + "&APP_YN="+oAPP_YN.value;

            trT_AC_RETTABLE.KeyValue = "SHR(O:dsT_AC_RETTABLE=dsT_AC_RETTABLE,O:dsBNK_INFO=dsBNK_INFO)";
            trT_AC_RETTABLE.action = dataClassName+params;
            trT_AC_RETTABLE.post();
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
            //������ȿ�� �˻�
            if(!fnc_SaveItemCheck()) return;

            trT_AC_RETTABLE.KeyValue = "reta(I:dsT_AC_RETTABLE=dsT_AC_RETTABLE)";
            trT_AC_RETTABLE.action = dataClassName+"&S_MODE=SAV";
            trT_AC_RETTABLE.post();

            fnc_SearchList();
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
	           //�˻�����
            var oSTR_YMD = document.getElementById("txtSTR_YMD_SHR");
            var oEND_YMD = document.getElementById("txtEND_YMD_SHR");
            var oDPT_CD = document.getElementById("txtDPT_CD_SHR");
            var oAPP_YN = document.getElementById("cmbAPP_YN_SHR");

			var url = "reta020_PV.jsp?PIS_SDAY="+oSTR_YMD.value + "&PIS_EDAY="+oEND_YMD.value + "&DPT_CD="+oDPT_CD.value + "&APP_YN="+oAPP_YN.value;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETTABLE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETTABLE.GridToExcel("�������߰������û��Ȳ", '', 225);
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
            document.getElementById("resultMessage").innerText = '&nbsp;';
            dsT_AC_RETTABLE.ClearData();
            fnc_ClearInputElement(oElementList);

            document.getElementById("grdT_AC_RETTABLE").Format = gridFormat+gridFormat2;

            //document.getElementById("txtSTR_YMD_SHR").value = getToday();
            //document.getElementById("txtEND_YMD_SHR").value = getToday();

            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"true","false");      // Grid Style ����
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETTABLE.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            /*
            for(var i=1; i<=dsT_AC_RETTABLE.CountRow; i++) {
                if(dsT_AC_RETTABLE.RowStatus(i) == "3") {
                    if(dsT_AC_RETTABLE.NameString(i, "IS_PROC") == "N") {
                        alert("no:"+i+" �̹� �߰����� ó���� �Ϸ� �Ǿ����ϴ�.");
                        dsT_AC_RETTABLE.RowPosition = i;
                        return false;
                    }
                }
            }
            */
            return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            document.getElementById("grdT_AC_RETTABLE").Format = gridFormat+gridFormat2;

            document.getElementById("txtSTR_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtEND_YMD_SHR").value = getToday();

            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"true","false");      // Grid Style ����
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

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "txtSTR_YMD_SHR"
                                        ,"txtEND_YMD_SHR"
                                        ,"txtDPT_NM_SHR");

        //�׸���� �޼���
        var oElementMsgList = new Array( "�˻�������"
                                        ,"�˻�������"
                                        ,"�μ���");
        //���� �׸��
        var oExceptionList = new Array(  "txtDPT_NM_SHR");

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsBNK_INFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETTABLE)                |
    | 3. ���Ǵ� Table List(T_AC_RETTABLE)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value=total>
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETTABLE)                |
    | 3. ���Ǵ� Table List(T_AC_RETTABLE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName             Value="toinb_dataid4">
        <param name=TimeOut             value="360000">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETTABLE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETTABLE event="OnSuccess()">
        if (dsT_AC_RETTABLE.CountRow == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETTABLE.RealCount(1, dsT_AC_RETTABLE.CountRow));

            //�˻��� ���������� �̷�� ������ �ش� ����� ��ŭ �ʵ� ũ�⸦ �ø�
            var oGRID = document.getElementById("grdT_AC_RETTABLE");
            var gridAdd = "";

            for(var i=1; i<=dsBNK_INFO.CountRow; i++) {
                gridAdd += "<C> id='"+dsBNK_INFO.NameString(i,"BNK_CD")+"' width=110 align=right name='"+dsBNK_INFO.NameString(i,"BNK_NM")+"' HeadBgColor='#F7DCBB' Edit=None rightmargin=10</C>" ;
            }

            oGRID.Format = gridFormat+gridAdd+gridFormat2;
            cfStyleGrid(oGRID,0,"true","false");
        }
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETTABLE event="OnFail()">
        alert(trT_AC_RETTABLE.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AC_RETTABLE event=OnRowPosChanged(row)>

    </script>

    <script language=JavaScript for=grdT_AC_RETTABLE event=OnClick(row,colid)>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������߰������û��Ȳ</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����ݰ���/<font color="#000000">�������߰������û��Ȳ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="50"></col>
					<col width="220"></col>
					<col width="50"></col>
					<col width="190"></col>
					<col width="50"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�Ⱓ</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
						 ~
						<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','208','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
                    <td class="searchState" align="right">�μ�</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) { fnc_SearchList(); fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR'); }" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
                        </a>
                    </td>
                    <td class="searchState" align="right">����</td>
                    <td class="padding2423" align="left">
                        <select name="cmbAPP_YN_SHR" id="cmbAPP_YN_SHR">
                            <option value="">�����ϼ���</option>
                            <option value="A">��û</option>
                            <option value="R">����</option>
                            <option value="N">�ݼ�</option>
                            <option value="Y">����</option>
                        </select>
                    </td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="520" border="0" cellspacing="0" cellpadding="0">
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
					<object id="grdT_AC_RETTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RETTABLE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='

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
