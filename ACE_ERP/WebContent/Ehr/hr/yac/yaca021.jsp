<!--*************************************************************************
* @source      : yaca021.jsp                                                *
* @description : �ξ簡������ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/18            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%

     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");
     //String ENO_NO       = box.getString("SESSION_ENONO");


     //ROLE_CD�� IT���� ����
     boolean itMaster = false;

     if(ROLE_CD.equals("1001")) {
	 itMaster = true;
     }

     //���������� �ƴ��� ����
     //boolean isMaster = false;

     //if(YAC_AUTHO.equals("M")) {
     // isMaster = true;
     // }

     // ���� ����
     //boolean open_yn = false;

     //if(ENO_NO.equals("19511030")) {
     //   open_yn = true;
     //  }

%>


<html>
<head>
    <title>�ξ簡������(yaca021)</title>
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
                    + "T"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "T"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params = null;

        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YY = document.getElementById("txtPIS_YY");
            var oBNK_CD = document.getElementById("cmbBNK_CD");

            params = "&S_MODE=SHR"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO;

            dsT_AC_FAMILY.dataid = dataClassName+params;
            dsT_AC_FAMILY.reset();
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
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AC_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
            }

            if(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "REL_NM") == "����"){
                alert("���� �ڷ�� ������ �� �����ϴ�.");
                return false;

            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "NAM_KOR")+" [" + dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "CET_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            //DataSet�� �Է»��·� ����
            dsT_AC_FAMILY.UseChangeInfo = false;

            params = "&S_MODE=DEL"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO
                   + "&ROW_ID="+dsT_AC_FAMILY.RowPosition;

            trT_AC_FAMILY.KeyValue = "TR_SAV(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
            trT_AC_FAMILY.Action = dataClassName+params;
            trT_AC_FAMILY.post();
            fnc_SearchList();
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
            if (dsT_AC_FAMILY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_FAMILY.GridToExcel("�ξ簡������", '', 225);
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
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_FAMILY.ClearData();
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();
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

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_AC_FAMILY,0,"false","false");      // Grid Style ����

            //���� ��ȸ
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

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "txtPIS_YY"
                                        ,"cmbBNK_CD");

        //�׸���� �޼���
        var oElementMsgList = new Array( "���ؿ���"
                                        ,"����ȸ�籸��");

        //���� �׸��
        var oExceptionList = new Array(  );

        /**
         * �ξ簡�����׵��
         */
        function fnc_RegFamily() {
            var href_page = "/hr/yac/yaca022.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO;

            window.showModalDialog(href_page, "", "dialogWidth:480px; dialogHeight:678px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();
        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_FAMILY)                |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_FAMILY)                |
    | 3. ���Ǵ� Table List(T_AC_FAMILY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        document.getElementById("txtPIS_YY_SHR").value      = getTodayArray()[0];
        document.getElementById("txtENO_NO_SHR").value      = dsT_CM_PERSON.NameValue(1, "ENO_NO"   );
        document.getElementById("txtENO_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "ENO_NM"   );
        document.getElementById("txtOCC_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "OCC_NM"   );
        document.getElementById("txtDPT_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "DPT_NM"   );
        document.getElementById("txtJOB_NM_SHR").value      = dsT_CM_PERSON.NameValue(1, "JOB_NM"   );
        document.getElementById("txtCET_NO_SHR").value      = dsT_CM_PERSON.NameValue(1, "CET_NO"   );
        document.getElementById("txtADDRESS_SHR").value     = dsT_CM_PERSON.NameValue(1, "ADDRESS"  );
    </Script>

    <Script For=dsT_AC_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_FAMILY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");

        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Grid OnDblClick event ó��                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_AC_FAMILY event=OnDblClick(row,colid)>
        var href_page = "/hr/yac/yaca022.jsp"
                      + "?TYPE=UPT"
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO");

        window.showModalDialog(href_page, "", "dialogWidth:480px; dialogHeight:678px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        fnc_SearchList();
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
    <table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ξ簡������</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">�ξ簡������</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="left">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFamilyRegistration','','/images/common/btnFamilyRegistration.gif',1)"><img src="/images/common/btnFamilyRegistration.gif" name="imgFamilyRegistration" width="130" height="25" border="0" align="absmiddle" onClick="fnc_RegFamily()"></a>
            </td>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
<%
    if(itMaster){    //  ||(open_yn)) ��������
%>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<%  }
%>

                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right" valign="bottom" class="searchState">�ػ󼼳����� ���Ͻø� �ش系���� ����Ŭ�� �ϼ���.</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->


    <!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="660" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:660px;height:315px;">
						<param name="DataID" value="dsT_AC_FAMILY">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='

                            <FC> id=NO          width=24        align=center       name=NO                suppress=2  </FC>
                            <FC> id=REL_NM      width=106       align=center       name=����              suppress=2  </FC>
                            <FC> id=NAM_KOR     width=55        align=center       name=����              suppress=2  </FC>
                            <C> id=CET_NO       width=95        align=center       name=�ֹι�ȣ          suppress=2  </C>
                            <C> id=BAS_MAN      width=53        align=center       name=�⺻����          suppress=2  </C>
                            <C> id=GOL_65       width=50        align=center       name="���;(65~69)"    suppress=2  </C>
                            <C> id=GOL_70       width=53        align=center       name="���;(70�̻�)"   suppress=2  </C>
                            <C> id=TRB_MAN      width=50        align=center       name=�����            suppress=2  </C>
                            <C> id=WCT_MAN      width=50        align=center       name=�γ���            suppress=2  </C>
                            <C> id=RCH_MAN      width=53        align=center       name=�ڳ����          suppress=2  </C>
                            <C> id=CHI_MAN      width=50        align=center       name=���ڳ�            suppress=2  </C>
                            <C> id=GBN_NM       width=70        align=center       name=����                </C>
                            <C> id=LIN_AMT      width=70        align=right        name=�����              </C>
                            <C> id=MED_AMT      width=70        align=right        name=�Ƿ��              </C>
                            <C> id=EDU_AMT      width=70        align=right        name=������              </C>
                            <C> id=CARD_AMT     width=70        align=right        name=�ſ�ī��            </C>
                            <C> id=CASH_AMT     width=70        align=right        name=���ݿ�����          </C>
                            <C> id=SCH_AMT      width=70        align=right        name="�п���;���γ��ξ�" </C>
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