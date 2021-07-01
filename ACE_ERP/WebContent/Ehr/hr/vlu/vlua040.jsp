<!--
    ************************************************************************************
    * @Source         : vlua040.jsp                                                    *
    * @Description    : ��޺� ����� ����.                                            *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/15  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>��޺����������(vlua040)</title>
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

        var year = getToday().substring(0,4);
        var btnList = 'TFTFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_EV_GRDRATE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SHR&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_GRDRATE.Reset();

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

            //�⵵ �Է� �ؽ�Ʈ �ڽ�
            var tempYear = document.getElementById("cmbEVL_YY_SHR").value;

            if( dsT_EV_GRDRATE.NameValue(1,"EVL_YY") == '' ) {

                //����
                dsT_EV_GRDRATE.NameValue(1,"GUBUN") = document.form1.txtGUBUN.value;
                dsT_EV_GRDRATE.NameValue(2,"GUBUN") = document.form1.txtGUBUN.value;
                dsT_EV_GRDRATE.NameValue(3,"GUBUN") = document.form1.txtGUBUN.value;
                dsT_EV_GRDRATE.NameValue(4,"GUBUN") = document.form1.txtGUBUN.value;

                // �ش�⵵
                dsT_EV_GRDRATE.NameValue(1,"EVL_YY") = tempYear.trim();
                dsT_EV_GRDRATE.NameValue(2,"EVL_YY") = tempYear.trim();
                dsT_EV_GRDRATE.NameValue(3,"EVL_YY") = tempYear.trim();
                dsT_EV_GRDRATE.NameValue(4,"EVL_YY") = tempYear.trim();

            }

            if( !fnc_SaveItemCheck() )     return;

            //Ʈ����� ����
            trT_EV_GRDRATE.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SAV";
            trT_EV_GRDRATE.Post();

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


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_GRDRATE.IsUpdated)  {

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

            if (document.form1.cmbEVL_YY_SHR.value != year) {

                alert("����⵵ �̿��� �ڷ�� ���� �� ������ �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.cmbEVL_YY_SHR.focus();
                return false;

            }

            // DataSet�� ���� ���� Ȯ��
            if ( dsT_EV_GRDRATE.IsUpdated ) {

                //������ ���� 100%�� �� ��쿡�� �����Ѵ�.
                if((dsT_EV_GRDRATE.NameValue(1,"S_RATE")+dsT_EV_GRDRATE.NameValue(1,"A_RATE")+dsT_EV_GRDRATE.NameValue(1,"B_RATE")+dsT_EV_GRDRATE.NameValue(1,"C_RATE")+dsT_EV_GRDRATE.NameValue(1,"D_RATE")) != 100){
                    alert("����(%)�� ���� '100'�� �Ǿ�� �մϴ�.\nȮ�� �� �ٽ� �����ϼ���!");
                     form1.grdT_EV_GRDRATE.SetColumn("S_RATE");//set focus
                    return false;
                }

            } else {

                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                return false;

            }

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_GRDRATE, 15, "true", "false");
            form1.grdT_EV_GRDRATE.RowHeight = 26;

            // ��������
            if (frameid == "vlua040") {
                // �λ���
                GUBUN = "01";
                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";
            }
            else {
                // ������
                GUBUN = "02";
                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            document.form1.txtGUBUN.value = GUBUN;

            getSelYy2('cmbEVL_YY_SHR');                 //SelectBox�⵵ Setting
            fnc_SearchList();                           //�⺻���� ��ȸ
            document.form1.cmbEVL_YY_SHR.focus();       //�˻� 1���ǿ� Focus

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

		//���⵵ ���� ����
        function fnc_Yearcopy(){

   			if( ! confirm("���⵵ ������ �����Ͻðڽ��ϱ�?") ){
				return false;
			}

            //��޺� ����� ������ ���� ��ȸ
            dsT_EV_GRDRATE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SHR&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_GRDRATE_01.reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_GRDRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_GRDRATE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID ="trT_EV_GRDRATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_GRDRATE)">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_EV_GRDRATE_01                   |
    | 3. Table List : T_EV_GRDRATE                  |
    +----------------------------------------------->
    <Object ID ="trT_EV_GRDRATE_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_GRDRATE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            var tempYear = document.getElementById("cmbEVL_YY_SHR").value;

            // �����ͼ��� ��� ������ �����ϰ� �����ͼ¿� �˻��⵵�� SEQ�� �����Ѵ�.
            dsT_EV_GRDRATE.setDataHeader("GUBUN:STRING, EVL_YY:STRING, GBN_CD:STRING, S_RATE:INT, A_RATE:INT, B_RATE:INT, C_RATE:INT, D_RATE:INT");

            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','1'");
            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','2'");
            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','3'");
            dsT_EV_GRDRATE.ImportData(GUBUN+",'"+tempYear+"','4'");

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            document.getElementById("resultMessage").innerText = '* �ڷᰡ ��ȸ �Ǿ����ϴ�!';

        }

        grdT_EV_GRDRATE.SetColumn("S_RATE");//set focus

    </Script>

    <Script For=dsT_EV_GRDRATE_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("���������Ͱ� �����մϴ�. ��� �Ͻðڽ��ϱ�?") ){
				return false;
			}

        }

		//Ʈ����� üũ�� ���� �ӽû���
        dsT_EV_GRDRATE_01.AddRow();

		//Ʈ����� ����
		trT_EV_GRDRATE_01.KeyValue = "SVL(I:dsT_EV_GRDRATE_01=dsT_EV_GRDRATE_01)";
		trT_EV_GRDRATE_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua040.cmd.VLUA040CMD&S_MODE=SAV_01&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
		trT_EV_GRDRATE_01.Post();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_GRDRATE Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_GRDRATE_01 Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_GRDRATE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_GRDRATE_01 Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_GRDRATE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <script for=trT_EV_GRDRATE_01 event="OnSuccess()">

        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_GRDRATE event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <script for=trT_EV_GRDRATE_01 event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
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

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��޺����������</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">��޺����������</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearcopy','','/images/button/btn_YearcopyOver.gif',1)"><img src="/images/button/btn_YearcopyOn.gif" name="imgYearcopy"    width="110" height="20" border="0" align="absmiddle" onClick="fnc_Yearcopy();"></a>
	            &nbsp;&nbsp;
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- ���� �Է� ���̺� ���� -->
    <!-- ���� �Է� ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                    <td align="center" class="searchBold">�ش�⵵</td>
                                    <td>
                                        <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
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
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_GRDRATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"            value="dsT_EV_GRDRATE">
                                <param name="LineColor"         value="Silver">
                                <param name="IndWidth"          value="0">
                                <param Name="Editable"          value="true">
                                <param name="RowHeight"         value="30">
                                <param name=HiddenHScroll       value="true">
                                <param name=HiddenVScroll       value="true">
                                <param name="AutoReSizing"      value="true">
                                <param name=ColSizing           value="true">
                                <param name="Format"            value='
                                    <C> id=EVL_YY    width=100  name=����              align=center   Show=false </C>
                                    <C> id=GBN_CD    width=269  name="��        ��"    align=center   Value={Decode(GBN_CD,1,"����(%)                (����)",2,"�󿩱� ������(%)       (����)",3,"����(����)      (���� + ����)",4,"������(%)       (���� + ����)")} </C>
                                    <C> id=S_RATE    width=99   name="S ���"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=A_RATE    width=99   name="A ���"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=B_RATE    width=99   name="B ���"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=C_RATE    width=99   name="C ���"          align=right    EditLimit=3        edit=numeric </C>
                                    <C> id=D_RATE    width=99   name="D ���"          align=right    EditLimit=3        edit=numeric </C>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>