<!--
*****************************************************
* @source       : etcb010.jsp
* @description : ���հ�����Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/10/07      ������        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�̰�����Ȳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'F' + 'F' + 'T';

        var today = getToday();
        var sso_flag = "";
        if("<%=box.get("SSO_FLAG")%>" != ""){
            sso_flag = "<%=box.get("SSO_FLAG")%>";
        }


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO_SHR  = "<%=box.get("SESSION_ENONO") %>";//���
            var APP_GBN_SHR = document.getElementById("cmbAPP_GBN_SHR").value;//���籸��


            dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb010.cmd.ETCB010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&APP_GBN_SHR="+APP_GBN_SHR;
            dsT_DI_APPROVAL.reset();

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

            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_APPROVAL.GridToExcel("���հ�����Ȳ", '', 225);

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

            document.getElementById("cmbAPP_GBN_SHR").value = "";//���籸��
            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_APPROVAL.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(sso_flag == ""){
	            if (dsT_DI_APPROVAL.IsUpdated)  {
	                if (!fnc_ExitQuestion()) return;
	            }

	            frame = window.external.GetFrame(window);

	            frame.CloseFrame();

            }else{
		        ds_LOGOUT.DataId="/servlet/GauceChannelSVL?cmd=common.menu.logout.cmd.LOGOUTCMD";
		        ds_LOGOUT.reset();
            }

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

            if (!dsT_DI_APPROVAL.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {


            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����

            document.getElementById("cmbAPP_GBN_SHR").value = "%";//���籸��

            fnc_SearchList();//�ڵ���ȸ

            if(sso_flag == ""){
	            if(dsT_DI_APPROVAL.countrow > 0){
	                alert(dsT_DI_APPROVAL.countrow+"���� �̰��系���� �����մϴ�.");
	            }
            }


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
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!------------------------------------+
    | 1. Logout�� DataSet                  |
    | 2. �̸� : dsT_CM_EMPLIST            |
    | 3. Table List :T_CM_EMPLIST         |
    +------------------------------------->
    <Object ID="ds_LOGOUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <Script For=ds_LOGOUT Event="OnLoadCompleted(iCount)">

        var frame = window.external.GetFrame(window);
        frame.outerWindow.do_logout();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=ds_LOGOUT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">

        var param = new String();

        if(row < 1) {

            return;

        } else {
			//���ϱٹ� param �� Setting
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                      //������ ����
	            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");
          		param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");
          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
            }

            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

            //���ϱ���, ���º���, �Ϳ�����, ����������
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "0" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "1" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "2" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "3"){
                window.showModalDialog("/hr/gun/guna071.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //�İ߰���
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "4"){
				var url = "/hr/but/butc020.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO") + "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
                window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:540px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //�ؿ�����
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "5"){
				var url = "/hr/but/butb020.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO") + "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");

                window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:700px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //���ϱٹ� ����
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6"){
                window.showModalDialog("/hr/gun/gunc071.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //���ϱٹ� ������û
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7"){
                window.showModalDialog("/hr/gun/gunc091.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //���ϱٹ� �������
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                window.showModalDialog("/hr/gun/gunc012.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //��������
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "9"){
				var url = "/hr/but/buta025.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&PENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");

                window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //�������
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "10"){
                 var url = "/hr/aid/aida011.jsp?REQ_NO="+dsT_DI_APPROVAL.NameString(row, "REQ_NO")+"&TYPE=TYPE2";
				cfWinOpen(url,"�����",870,500)
               // window.showModalDialog("/hr/aid/aida010.jsp", "Modal", "dialogWidth:870px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //������û
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "11"){
				window.showModalDialog("/hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:770px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //������û
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "12"){
				window.showModalDialog("/hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:770px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //�����������
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "13"){
                 window.showModalDialog("/hr/edu/edue061.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:550px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //���Ի��OJT
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "14"){
                 window.showModalDialog("/hr/cdp/cdpd061.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:860px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //��������
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "15"){

          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
            	window.showModalDialog("/hr/cdp/book011.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");


            //�Ͽ����빫��
	        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "16"){
	
	      		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");

	        	window.showModalDialog("/hr/ada/aday051.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
	        }
            
			fnc_SearchList();
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�̰�����Ȳ</td>
                    <td align="right" class="navigator">HOME/��������/���հ���/<font color="#000000">�̰�����Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="20"></col>
                                <col width="30"></col>
                                <col width="40"></col>
                                <col width="120"></col>
                                <col width="80"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">���籸��&nbsp;</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_GBN_SHR" style="width:100" onChange="fnc_SearchList();">
			                            <option value="%" >��ü</option>
			                            <option value="0" >���ϱ���</option>
			                            <option value="1" >���º���</option>
			                            <option value="3" >����������</option>
			                            <option value="6" >��������</option>
			                            <option value="7" >���Ͻ�û</option>
			                            <option value="8" >���ϰ��</option>
			                            <option value="9" >��������</option>
			                            <option value="10" >�������</option>
			                            <option value="11" >������û</option>
			                            <option value="12" >����������û</option>
			                            <option value="13" >�����������</option>
			                            <option value="14" >���Ի��OJT</option>
			                            <option value="15" >��������</option>
			                            <option value="16" >�Ͽ����빫��</option>			                            
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
        <td align="center" width="45%" valign="bottom">
            <b>�� ����Ŭ���� �Ͻø� �ش� ������Ȳ���� �̵��մϴ�. </b>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td style="padding-top:2px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                value="dsT_DI_APPROVAL">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    width=39    name='NO'           align=center    value={String(Currow)}</C>
                                <FC> id='APP_GBN_NM' width=100   name='���籸��'     align=center </FC>
                                <FC> id='APP_TITLE'  width=440   name='����'         align=left   </FC>
                                <FC> id='APP_YMD'    width=110   name='�������'     align=center </FC>
                                <C> id='PENO_NM'    width=90    name='�����'       align=center  </C>
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