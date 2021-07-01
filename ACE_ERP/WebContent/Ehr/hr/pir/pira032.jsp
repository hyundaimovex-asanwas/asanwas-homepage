<!--
    ************************************************************************************
    * @Source         : pira032.jsp                                                    *
    * @Description    : ������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�������</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String p_srcid = request.getParameter("srcid") != null ? request.getParameter("srcid") : "";
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        var GUBUN = '';
        var p_srcid = "<%=p_srcid %>";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira032.cmd.PIRA032CMD&S_MODE=SHR&GUBUN="+GUBUN;
            dsT_CM_PERSON.Reset();

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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

            dsT_CM_PERSON.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
            document.getElementById("resultMessage").innerText = ' ';

            document.getElementById("txtENO_NO1").value = '';
            document.getElementById("txtNO").value = '';
            document.getElementById("txtENO_NO").value = '';
            document.getElementById("txtMSG").value = '';

            document.getElementById("txtENO_NO1").focus();

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
            cfStyleGrid_New(form1.grdT_CM_PERSON, 0,"false","false");

            if (p_srcid == 'pira010') {
                // ���Ի��
                GUBUN = '1';
            }
            else if (p_srcid == 'mema010') {
                // �İ߻��
                GUBUN = '2';
            }

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

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

        /******************************
         * ������� ��ư Ŭ���� ó��  *
         ******************************/
        function fnc_CreateEnono() {
        	
            var NO1 = 0;

            if (document.getElementById("txtENO_NO1").value.length < 7) {
                alert("���ڸ� 7�ڸ� �Է��Ͻñ� �ٶ��ϴ�.\n\n�Ʒ� ������ �׸��忡�� Double Click�ϼ���");
                document.getElementById("txtENO_NO1").focus();
                return;
            }

            document.getElementById("txtNO").value = 1;
            document.getElementById("txtENO_NO").value = parseInt(document.getElementById("txtENO_NO1").value) + 1;

        }

        function fnc_CopyEnono() {
        	
            if(!confirm("���� �۾����̴� ��������� ��������� �����ϴ��� ������� �ʰ� �ű� ����� �����մϴ�.\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;

            parent.fnc_Clear();
            parent.fnc_AddNew();
            parent.document.getElementById("txtENO_NO").value = document.getElementById("txtENO_NO").value;
            
        }

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | ����Ŭ���� �ش� ���ڵ��� ������������� ������   |
    +-------------------------------------------------->
    <Script For=grdT_CM_PERSON Event="OnDblClick(row,colid)">

        var ENO_NO = dsT_CM_PERSON.NameValue(row, "ENO_NO");
        document.getElementById("txtENO_NO1").value = ENO_NO.substr(0, 7);

        fnc_CreateEnono();

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�������</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="475">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;height:230px;" bordercolor="#999999" class="table_cream">
                <tr>
                    <td class="padding2423">
                        <input id="txtENO_NO1" maxlength="7" size="8" style="ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();"> + <input id="txtNO" maxlength="1" size="2"  class="input_ReadOnly"  readonly> = <input id="txtENO_NO" maxlength="8" size="9"  class="input_ReadOnly"  readonly>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnonocreate','','../../images/button/btn_EnonocreateOver.gif',1)"><img src="../../images/button/btn_EnonocreateOn.gif"  name="imgAdd"    width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateEnono()"></a>
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnonoapply','','../../images/button/btn_EnonoapplyOver.gif',1)"><img src="../../images/button/btn_EnonoapplyOn.gif"  name="imgAdd"    width="80" height="20" border="0" align="absmiddle" onClick="fnc_CopyEnono()"></a>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423">
                        <textarea id=txtMSG name=txtMSG rows="16" cols="78" class="input_ReadOnly"  readonly></textarea>
                    </td>
                </tr>
            </table>
        </td>
        <td width="515" >
            <!-- ��ȸ ���� ���̺� ���� -->
            <table width="515" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="bottom" class="searchState">&nbsp;<span id="resultMessage">&nbsp;</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!-- ��ȸ ���� ���̺� �� -->

            <!-- ���� ��ȸ �׸��� ���̺� ����-->
            <table width="515" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop3" align="right">
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:510px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_PERSON">
                                        <param name="Format"                  value="
                                            <C> id=ENO_NO          width=90   name='���'                  </C>
                                            <C> id=ENO_NM          width=90   name='����'                  </C>
                                            <C> id=DPT_NM          width=100   name='�μ�'                  </C>
                                            <C> id=JOB_NM          width=100   name='����'                  </C>
                                            <C> id=HIR_YMD         width=80   name='�Ի���'                </C>
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
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>
