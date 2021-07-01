<!--
    ************************************************************************************
    * @Source         : vlub070.jsp                                                    *
    * @Description    : ����������Ȯ��_����.                                           *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/28  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/16  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>����������Ȯ��_����(vlub070)</title>
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

        var btnList = 'FFFFFFFT';
        var flag= false;        //������ ����Ȯ�� �Ⱓüũ

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�⵵�� ��ȸ������ ��ȸ
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save(p_gbn) {

            if (dsT_EV_ABLRST.CountRow == 0) {
                alert("���� Ȯ�� �Ǵ� ���� ��Ҹ� �� ���ڷᰡ �������� �ʽ��ϴ�.");
                return;
            }

            if( p_gbn != undefined ) {
                //������ ����Ȯ��
                if( p_gbn == 'T') {
                    //��ȿ��üũ
                    if( !fnc_SaveItemCheck() )    return;
                    // ���������� Ȯ�� ���θ� ���� ����.
                    if (confirm(document.getElementById("EVL_YY").innerText+"�⵵ "+document.getElementById("EVL_FRQ").innerText+"ȸ���� ������ ���� Ȯ���� �Ͻðڽ��ϱ�?") == false) return;
                }

                //������ ����Ȯ�� ���
                if( p_gbn == 'F') {
                    // ���������� Ȯ�� ��� ���θ� ���� ����.
                    if (confirm(document.getElementById("EVL_YY").innerText+"�⵵ "+document.getElementById("EVL_FRQ").innerText+"ȸ���� ������ ���� Ȯ�� ��Ҹ� �Ͻðڽ��ϱ�?") == false) return;
                }

                //�ű��Լ�
                fnc_AddNew(p_gbn);

                //Ʈ����� ����
                trT_EV_ABLRST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub070.cmd.VLUB070CMD&S_MODE=SAV";
                trT_EV_ABLRST.Post();
            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew(p_gbn) {

            dsT_EV_ABLRST.NameValue(1,"FEEDBK_GBN") = p_gbn;

            if( p_gbn == 'T' )        //������ ���� Ȯ��
                dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD") = getToday();
            else
                dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD") = '';

            dsT_EV_ABLRST.NameValue(1,"GUBUN")   = GUBUN;
            dsT_EV_ABLRST.NameValue(1,"EVL_YY")  = (document.getElementById("EVL_YY").innerText).trim();
            dsT_EV_ABLRST.NameValue(1,"EVL_GBN") = '1';    //����
            dsT_EV_ABLRST.NameValue(1,"EVL_FRQ") = (document.getElementById("EVL_FRQ").innerText).trim();

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

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if( document.getElementById("txtFEDDBK_YMD").value == '') {
                alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtFEDDBK_YMD").focus();
                return false;
            }
            if( (document.getElementById("txtFEDDBK_YMD").value != ''
                && ( cfDateExpr(document.getElementById("txtFEDDBK_YMD").value) == false || document.getElementById("txtFEDDBK_YMD").value.length != 10 ) ) ) {
                alert("�������ڰ� ��¥���Ŀ� �����ʽ��ϴ�.");
                document.getElementById("txtFEDDBK_YMD").focus();
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtFEDDBK_YMD").value = getToday();

            // ��������
            if (frameid == "vlub070") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            fnc_SearchItem();

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0) {
            alert("���� Ȯ�� �Ǵ� ���� ��Ҹ� �� ���ڷᰡ �������� �ʽ��ϴ�.");
            return;
        }
        else {

            if (dsT_EV_ABLRST.NameValue(1,"FEEDBK_GBN") == 'T') {
                document.getElementById("FEEDBK_YYYY").innerText = dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD").substring(0,4)+" ";
                document.getElementById("FEEDBK_MM").innerText = dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD").substring(5,7)+" ";
                document.getElementById("FEEDBK_DD").innerText = dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD").substring(8,10)+" ";
            }
            else {
                document.getElementById("FEEDBK_YYYY").innerText = " ";
                document.getElementById("FEEDBK_MM").innerText   = " ";
                document.getElementById("FEEDBK_DD").innerText   = " ";
            }

        }

    </Script>

       <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

           alert("������Ⱓ�� �ƴմϴ�.");

        } else {

            document.getElementById("EVL_YY").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+" ";
            document.getElementById("EVL_FRQ").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ")+" ";
            document.getElementById("EVL_STDT_YYYY").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_STDT").substring(0,4)+" ";
            document.getElementById("EVL_STDT_MM").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_STDT").substring(5,7)+" ";
            document.getElementById("EVL_STDT_DD").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_STDT").substring(8,10)+" ";
            document.getElementById("EVL_ENDT_YYYY").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_ENDT").substring(0,4)+" ";
            document.getElementById("EVL_ENDT_MM").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_ENDT").substring(5,7)+" ";
            document.getElementById("EVL_ENDT_DD").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_ENDT").substring(8,10)+" ";

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub070.cmd.VLUB070CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("EVL_YY").innerText+"&EVL_GBN=1&EVL_FRQ="+document.getElementById("EVL_FRQ").innerText;
            dsT_EV_ABLRST.Reset();

        }

    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //dsT_EV_ABLRST.ClearAll();
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">

        alert('�۾��� �Ϸ� �Ͽ����ϴ�!');

        dsT_EV_ABLRST.ClearData();

        dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub070.cmd.VLUB070CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("EVL_YY").innerText+"&EVL_GBN=1&EVL_FRQ="+document.getElementById("EVL_FRQ").innerText;
        dsT_EV_ABLRST.Reset();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">

        //dsT_EV_ABLRST.ClearAll();
        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- �̸��� ������-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

<!-- form ���� -->
<form name="form1">
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <!-- Ÿ��Ʋ �� ���̺� ���� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������Ȯ��_����</td>
          <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">����������Ȯ��_����</font></td>
        </tr>
      </table>
      <!-- Ÿ��Ʋ �� ���̺� �� -->
    </td>
  </tr>
  <tr>
    <!-- ��ư -->
    <td height="35" align="right" class="paddingTop5">
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/over_decision.gif',1)"><img src="/images/button/decision.gif" name="Image1" width="90" height="20" border="0" align="absmiddle" onclick="fnc_Save('T');"></a>
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/over_decisionCancel.gif',1)"><img src="/images/button/decisionCancel.gif" name="Image2" width="80" height="20" border="0" align="absmiddle" onclick="fnc_Save('F');"></a>
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onclick="fnc_Exit();"></a>
    </td>
  </tr>
  <tr>
    <td height="125" background="/images/specialHr/gridGreen.gif">
      <!--�����������̺� �� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10"><img src="/images/specialHr/gridWhiteL2.gif" width="10" height="205"></td>
          <td width="780" align="center" valign="middle">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="hrWtable" style="padding:0 26 0 14">
                    <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74" style="padding:0 19 0 0"><img src="/images/specialHr/hr3Icon.gif" width="74" height="52"></td>
                      <td><table width="400" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                              <img src="/images/specialHr/info1.gif" width="21" height="15" align="absmiddle">
                              <span id="EVL_YY">
                              </span><img src="/images/specialHr/info2.gif" width="20" height="15" align="absmiddle"></td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                              <img src="/images/specialHr/hr3T01.gif" width="21" height="13" align="absmiddle">
                              <span id="EVL_FRQ"></span>
                              <img src="/images/specialHr/info3.gif" width="20" height="15" align="absmiddle">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                              <img src="/images/specialHr/hr3T02.gif" width="41" height="13" align="absmiddle">
                              <span id="EVL_STDT_YYYY"></span>
                              <img src="/images/specialHr/hr3T03.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_STDT_MM"></span>
                              <img src="/images/specialHr/hr3T04.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_STDT_DD"></span>
                              <img src="/images/specialHr/hr3T05.gif" width="9" height="13" align="absmiddle">
                              <img src="/images/specialHr/hr3wave.gif" width="10" height="5" align="absmiddle">
                              <span id="EVL_ENDT_YYYY"></span>
                              <img src="/images/specialHr/hr3T03.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_ENDT_MM"></span>
                              <img src="/images/specialHr/hr3T04.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_ENDT_DD"></span>
                              <img src="/images/specialHr/hr3T05.gif" width="9" height="13" align="absmiddle">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;">
                                <img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                <img src="/images/specialHr/hr3T06.gif" width="41" height="13" align="absmiddle">
                              <span id="FEEDBK_YYYY"></span>
                              <img src="/images/specialHr/hr3T03.gif" width="9" height="13" align="absmiddle">
                              <span id="FEEDBK_MM"></span>
                              <img src="/images/specialHr/hr3T04.gif" width="9" height="13" align="absmiddle">
                              <span id="FEEDBK_DD"></span>
                              <img src="/images/specialHr/hr3T05.gif" width="9" height="13" align="absmiddle">
                                <input type=hidden id=txtFEDDBK_YMD name=txtFEDDBK_YMD value="" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="divInput" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" valid='key=true' field='��������'>
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
                <td align="left" style="padding:3 0 0 25"><img src="/images/specialHr/hr3Img.gif" width="178" height="158"></td>
              </tr>
            </table> </td>
          <td width="10"><img src="/images/specialHr/gridWhiteR2.gif" width="10" height="205"></td>
        </tr>
      </table>
      <!--�����������̺� �� -->
    </td>
  </tr>
</table>
</form>
</body>
</html>