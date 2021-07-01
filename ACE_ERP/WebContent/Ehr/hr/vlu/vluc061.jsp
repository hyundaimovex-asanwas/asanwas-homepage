<!--
    ************************************************************************************
    * @Source         : vluc061.jsp                                                    *
    * @Description    : ���󼼰���.                                                  *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/16  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/17  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>���󼼰���(vluc061)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String T_MODE        = request.getParameter("T_MODE");                    //��屸��
    String GUBUN         = request.getParameter("GUBUN");                     //��������
    String EVL_YY        = request.getParameter("EVL_YY");                    //�ش�⵵
    String EVL_FRQ       = request.getParameter("EVL_FRQ");                   //ȸ��
    String ENO_NO        = request.getParameter("ENO_NO");                    //�Ǹ���ڻ��
    String ENO_NM        = request.getParameter("ENO_NM");                    //�Ǹ���ڼ���
    String EVLENO_NO     = request.getParameter("EVLENO_NO");                 //����ڻ��
    String EVLENO_NM     = request.getParameter("EVLENO_NM");                 //����ڼ���
    String INTERVIEW_YMD = request.getParameter("INTERVIEW_YMD");             //�������
    String AIM_YMD       = request.getParameter("AIM_YMD");                   //�������
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';
        var opener = window.dialogArguments;

        var GUBUN = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList( searchDiv ) {

            if( searchDiv == '1' ) {

                if( '<%=T_MODE%>' == 'I' ) {
                    //�����ͼ� ����
                    dsT_EV_INTERVIEW.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc061.cmd.VLUC061CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR=<%=EVL_YY%>&txtEVL_FRQ_SHR=<%=EVL_FRQ%>&txtENO_NO_SHR=<%=ENO_NO%>&txtEVLENO_NO_SHR=<%=EVLENO_NO%>&txtINTERVIEW_YMD_SHR="+document.getElementById("txtINTERVIEW_YMD_SHR").value+"&txtAIM_YMD_SHR=<%=AIM_YMD%>";
                    dsT_EV_INTERVIEW.Reset();
                } else if( '<%=T_MODE%>' == 'U' || '<%=T_MODE%>' == 'S' ) {
                    //�����ͼ� ����
                    dsT_EV_INTERVIEW.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc061.cmd.VLUC061CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR=<%=EVL_YY%>&txtEVL_FRQ_SHR=<%=EVL_FRQ%>&txtENO_NO_SHR=<%=ENO_NO%>&txtEVLENO_NO_SHR=<%=EVLENO_NO%>&txtINTERVIEW_YMD_SHR=<%=INTERVIEW_YMD%>&txtAIM_YMD_SHR=<%=AIM_YMD%>";
                    dsT_EV_INTERVIEW.Reset();
                }

            }

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( '<%=T_MODE%>' != 'S' ) {

                if( !fnc_SaveItemCheck() ) {
                    return;
                }

                for( i=1; i<=dsT_EV_INTERVIEW.CountRow; i++ ) {
                    if( dsT_EV_INTERVIEW.RowStatus(i) == 1 || dsT_EV_INTERVIEW.RowStatus(i) == 3 ) {        //Update����
                        if( dsT_EV_INTERVIEW.NameValue(i,"DATA_STATUS") == 'I' ) {        //�Էµ�����
                            dsT_EV_INTERVIEW.NameValue(i,"INTERVIEW_YMD")=document.getElementById("txtINTERVIEW_YMD_SHR").value;
                            dsT_EV_INTERVIEW.UserStatus(i)=1;
                        } else {    //����������
                            dsT_EV_INTERVIEW.NameValue(i,"INTERVIEW_YMD")=document.getElementById("txtINTERVIEW_YMD_SHR").value;
                            dsT_EV_INTERVIEW.UserStatus(i)=3;
                        }
                    }
                }

                //Ʈ����� ����
                trT_EV_INTERVIEW.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc061.cmd.VLUC061CMD&S_MODE=SAV";
                trT_EV_INTERVIEW.Post();
            }
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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�

            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_INTERVIEW.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            window.close();

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

            if ( dsT_EV_INTERVIEW.isUpdated ) {
                if( document.getElementById("txtINTERVIEW_YMD_SHR").value == '' ) {
                    alert("������ڴ� �ʼ��Է»����Դϴ�..");
                    document.getElementById("txtINTERVIEW_YMD_SHR").focus();
                    return false;
                }

                if( cfDateExpr(document.getElementById("txtINTERVIEW_YMD_SHR").value) == false || document.getElementById("txtINTERVIEW_YMD_SHR").value.length != 10 ) {
                    alert("������ڰ� ��¥���Ŀ� �����ʽ��ϴ�.");
                    document.getElementById("txtINTERVIEW_YMD_SHR").focus();
                    return false;
                }
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("���� �� ������ �����ϴ�!");
                return false;
            }

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            if( '<%=T_MODE%>' == 'I' || '<%=T_MODE%>' == 'U' ) {        //�Է¸��
                //Grid Style ����
                cfStyleGrid(form1.grdT_EV_INTERVIEW, 15, "true", "false");
            } else if( '<%=T_MODE%>' == 'S' ) {                         //��Ȳ���
                //Grid Style ����
                cfStyleGrid(form1.grdT_EV_INTERVIEW, 15, "false", "false");
            }

            if( '<%=T_MODE%>' == 'I' )  {       //�Է¸��
                document.getElementById("txtINTERVIEW_YMD_SHR").value = getToday();
            }
            else if( '<%=T_MODE%>' == 'U' || '<%=T_MODE%>' == 'S' ) {
                document.getElementById("txtINTERVIEW_YMD_SHR").value = '<%=INTERVIEW_YMD%>';
            }

            // ��������
            if ("<%=GUBUN%>" == "01") {
                // �λ���
                GUBUN = "01";

            }
            else {
                // ������
                GUBUN = "02";

            }

            document.getElementById("txtEVLENO_NO_SHR").value = '<%=EVLENO_NO%>';
            document.getElementById("txtEVLENO_NM_SHR").value = '<%=EVLENO_NM%>';
            document.getElementById("txtENO_NO_SHR").value    = '<%=ENO_NO%>';
            document.getElementById("txtENO_NM_SHR").value    = '<%=ENO_NM%>';

            fnc_DisableSet();        //�Է¿���ó��
            fnc_SearchList('1');     //��㳻����ȸ
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. ��ǥ���� ���ο� ����,        *
         *        ���󼼰����� �Է� disable,                            *
         *******************************************/
        function fnc_DisableSet() {

            if( '<%=T_MODE%>' == 'I'  || '<%=T_MODE%>' == 'U' ) {    //�Է¸��, �������
                form1.grdT_EV_INTERVIEW.Editable = true;
                document.getElementById("image1").disabled = false;

                if ('<%=T_MODE%>' == 'I') {

                    document.getElementById("txtINTERVIEW_YMD_SHR").readOnly = false;
                    document.getElementById("txtINTERVIEW_YMD_SHR").style.backgroundColor = 'FFFFFF';
                }
                else {

                    document.getElementById("txtINTERVIEW_YMD_SHR").readOnly = true;
                    document.getElementById("txtINTERVIEW_YMD_SHR").style.backgroundColor = 'EEEEEE';
                }

            } else if( '<%=T_MODE%>' == 'S' ) {    //��Ȳ���
                form1.grdT_EV_INTERVIEW.Editable = false;
                document.getElementById("txtINTERVIEW_YMD_SHR").readOnly = true;
                document.getElementById("txtINTERVIEW_YMD_SHR").style.backgroundColor = 'EEEEEE';
            }

        }

        /********************
         * 16. ����Ű ó��  *
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

    <Object ID="dsT_EV_INTERVIEW" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_INTERVIEW" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_INTERVIEW)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_INTERVIEW Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

        } else {
            for( i=1; i<=dsT_EV_INTERVIEW.CountRow; i++ ) {
                if( dsT_EV_INTERVIEW.NameValue(i,"RESULT_WRT") == '' &&
                    dsT_EV_INTERVIEW.NameValue(i,"CUR_LEVEL")  == '' &&
                    dsT_EV_INTERVIEW.NameValue(i,"CAUSE_CTS")  == '' &&
                    dsT_EV_INTERVIEW.NameValue(i,"ADVICE_CTS") == '' ) {
                    dsT_EV_INTERVIEW.NameValue(i,"DATA_STATUS") = 'I';
                }
            }

            dsT_EV_INTERVIEW.ResetStatus();
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_INTERVIEW.CountRow);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_INTERVIEW Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = '1 ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_INTERVIEW Event="OnDataError()">

        document.getElementById("resultMessage").innerText = '2 ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_INTERVIEW event="OnSuccess()">
        for( i=1; i<=dsT_EV_INTERVIEW.CountRow; i++ ) {
            if( !(dsT_EV_INTERVIEW.NameValue(i,"RESULT_WRT") == '' &&
                  dsT_EV_INTERVIEW.NameValue(i,"CUR_LEVEL")  == '' &&
                  dsT_EV_INTERVIEW.NameValue(i,"CAUSE_CTS")  == '' &&
                  dsT_EV_INTERVIEW.NameValue(i,"ADVICE_CTS") == '') )  {
                dsT_EV_INTERVIEW.NameValue(i,"DATA_STATUS") = '';
            }
        }

        dsT_EV_INTERVIEW.ResetStatus();

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        opener.fnc_SearchList('2');

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_INTERVIEW event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        dsT_EV_INTERVIEW.ResetUserStatus();
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">
                        <% if( T_MODE.equals("I") || T_MODE.equals("U") )
                                out.print("���󼼰���");
                             else if( T_MODE.equals("S") )
                                 out.println("���󼼰���(��Ȳ)");
                        %>
                        </td>
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
                <% if( T_MODE.equals("I") || T_MODE.equals("U")) { %>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <% } %>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',2)">  <img src="/images/button/btn_ExitOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                    <col width="*"></col>
                                  </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�������</td>
                                    <td class="padding2423"><input id=txtINTERVIEW_YMD_SHR size="10" maxlength="10" style="ime-mode:disabled;text-align:center;" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    </td>
                                    <td align="right" class="searchState">�����</td>
                                    <td class="padding2423"><input id=txtEVLENO_NO_SHR size="10"  style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td class="padding2423"><input id=txtEVLENO_NM_SHR  size="10"  style="text-align:center" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">�Ǹ����</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR size="10"  style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR  size="10"  style="text-align:center" class="input_ReadOnly" readonly>
                                    </td>
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
                            <object    id="grdT_EV_INTERVIEW" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                                <param name="DataID"                  value="dsT_EV_INTERVIEW">
                                <param name="EdiTABLE"                value="true">
                                <param name="DragDropEnable"          value="true">
                                <param name="AutoReSizing"            value="true">
                                <param name=ColSizing                 value="true">
                                <param name="Format"                  value="

                                    <C> id='TASK_AIM'         width=128        name='�ֿ��ٽɰ���'     align=left        edit=none     suppress=1</C>
									<C> id='BASIC_PAR'        width=128        name='KPI(�������)'    align=left        edit=none     suppress=2</C>
                                    <C> id='RESULT_WRT'       width=127        name='�������'         align=left        editlimit=100 </C>
                                    <G>name='��㳻��' HeadBgColor='#F7DCBB'
                                        <C> id='CUR_LEVEL'    width=127        name='������/�������'           align=left        editlimit=100 </C>
                                        <C> id='CAUSE_CTS'    width=127        name='����/����'        align=left        editlimit=100 </C>
                                        <C> id='ADVICE_CTS'   width=127        name='����/���𳻿�'    align=left        editlimit=100 </C>
                                    <G>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>