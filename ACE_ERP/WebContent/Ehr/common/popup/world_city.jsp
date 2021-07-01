<!--
***********************************************************************
* @source      : world_city.jsp
* @description : ���赵��������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/03/12     ������        �����ۼ�.
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="common.util.JSPUtil" %>
<%

%>

<html>

    <head>
    <title>���赵��������ȸ(world_city)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
		var paramDataSet  = window.dialogArguments;
        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';


        /************************
         * 11. ��ȸ  *
         ***********************/
        function fnc_SearchList() {
			var SEARCH_GBN = document.getElementById("cmbSEARCH_GBN").value;
			var TEXT_SHR = document.getElementById("txtTEXT_SHR").value;

            //�����ͼ� ����
            dsT_CM_NAT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=NAT_SHR&SEARCH_GBN="+SEARCH_GBN+"&TEXT_SHR="+TEXT_SHR;
            dsT_CM_NAT.reset();

        }
        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            window.close();

        }
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_CM_NAT,0,"false","false");      // Grid Style ����
            cfStyleGrid(form1.grdT_CM_CITY,0,"false","false");      // Grid Style ����

            //�����ͼ� ����
            dsT_CM_NAT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=NAT_SHR";
            dsT_CM_NAT.reset();
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /**
         * �����ڸ� ������ �� Ȯ���� ������ ������������ �Ѿ
         * (�����ڰ� ������ ��û�ڰ� �����ڷ� �Ѿ)
         */
        function fnc_Confirm() {
			paramDataSet.nat_cd = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "NAT_CD");
			paramDataSet.nat_nm = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "NAT_NM");
			paramDataSet.city_cd = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "CITY_CD");
			paramDataSet.city_nm = dsT_CM_CITY.NameValue(dsT_CM_CITY.RowPosition, "CITY_NM");
            window.close();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��()      |
    | 3. ���Ǵ� Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_NAT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_CITY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_NAT Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            //�����ͼ� ����
			var NAT_CD = dsT_CM_NAT.NameValue(dsT_CM_NAT.RowPosition, "NAT_CD");
            dsT_CM_CITY.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=CITY_SHR&NAT_CD="+NAT_CD;
            dsT_CM_CITY.reset();
        }
    </Script>

    <Script For=dsT_CM_CITY Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
        } else {
        }

    </Script>
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_NAT Event="OnLoadError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CM_CITY Event="OnLoadError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_NAT Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CM_CITY Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_NAT event=OnDblClick(row,colid)>
			var NAT_CD = dsT_CM_NAT.NameValue(row, "NAT_CD");
            dsT_CM_CITY.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=CITY_SHR&NAT_CD="+NAT_CD;
            dsT_CM_CITY.reset();
    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_NAT event=OnReturn(row,colid)>
			var NAT_CD = dsT_CM_NAT.NameValue(dsT_CM_NAT.RowPosition, "NAT_CD");
            dsT_CM_CITY.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.worldcity.cmd.WORLDCITYCMD&S_MODE=CITY_SHR&NAT_CD="+NAT_CD;
            dsT_CM_CITY.reset();

    </script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_CITY event=OnDblClick(row,colid)>
		fnc_Confirm();
    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_CITY event=OnReturn(row,colid)>
		fnc_Confirm();
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���谢�� ����������ȸ</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
				<!--
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				-->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->


    <!-- power Search���̺� ���� 
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">
										<select id="cmbSEARCH_GBN" style="width:85">
											<option value="1">����</option>
											<option value="2">����</option>
										</select>
									</td>
                                    <td align="center" class="searchState">����/����&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtTEXT_SHR" id="txtTEXT_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()"><input type="text" style="display:none">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_NAT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:200px;height:400px;">
                                <param name="DataID"            value="dsT_CM_NAT">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=NAT_CD           width=50  name=�ڵ�      align=center   </C>
                                    <C> id=NAT_NM           width=130  name=������   align=left   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_CITY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:250px;height:400px;">
                                <param name="DataID"            value="dsT_CM_CITY">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll       value="true">
                                <param name="Format"            value='
                                    <C> id=CITY_CD           width=50   name=�ڵ�      align=center   </C>
                                    <C> id=CITY_NM           width=180   name=���ø�   align=left   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->
    </form>
    <!-- form �� -->
</body>
</html>