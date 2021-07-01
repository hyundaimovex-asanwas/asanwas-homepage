<!--*************************************************************************
* @source      : reta010.jsp                                                *
* @description : �������߰������û PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            ����ȣ             �����ۼ�
* 2007/05/04            ���м�             �����ۼ�                         *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�������ݰ����ڸ��(reta010)</title>
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
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta010.cmd.RETA010CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻�����
            var oENO_NO = document.getElementById("txtENO_NO_SHR");

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value;

            dsT_AC_RETTABLE.dataid = dataClassName+params;
            dsT_AC_RETTABLE.reset();
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


            trT_AC_RETTABLE.KeyValue = "reta(I:dsT_AC_RETTABLE=dsT_AC_RETTABLE)";
            trT_AC_RETTABLE.action = dataClassName+"&S_MODE=SAV";
            trT_AC_RETTABLE.post();

        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AC_RETTABLE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[����:"+dsT_AC_RETTABLE.NameString(dsT_AC_RETTABLE.RowPosition, "ENO_NM")+"]�� �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_AC_RETTABLE.DeleteRow(dsT_AC_RETTABLE.RowPosition);

            trT_AC_RETTABLE.KeyValue = "SVL(I:dsT_AC_RETTABLE=dsT_AC_RETTABLE)";
            trT_AC_RETTABLE.Action = dataClassName+"&S_MODE=DEL";
            trT_AC_RETTABLE.post();
        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

            //�˻�����
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            var rownum = document.getElementById("cmbSEQ_NO").value;
            var param = "ENO_NO="+oENO_NO.value+"&rownum="+rownum;

            var url = "reta010_PV.jsp?"+param;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETTABLE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETTABLE.GridToExcel("�������ݰ����ڸ��", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ �˻��� ���� �ʾҴٴ� ������ �����ϰ� ����
            if (dsT_AC_RETTABLE.CountColumn == 0) {
                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
                return;
            }


            dsT_AC_RETTABLE.AddRow();

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
            dsT_AC_RETTABLE.ClearData();
            //fnc_DisableElementAll(oElementList);
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
            cfStyleGrid(form1.grdT_AC_RETTABLE,0,"false","false");      // Grid Style ����




<%
    //�����ڰ� �ƴϸ� ��� �˻��� ����� �� ����.
    if(!box.getString("SESSION_ROLE_CD").equals("1001")
            && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
%>

            //����� �α����� ������� ������ ���� �⺻������ �����´�.
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            //oENO_NO.value = "<%=ls_UserId %>";

            //��������� �������� ����� �߰����� ����Ʈ�� �����´�.
            fnc_SearchEmpNo();
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


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO_SHR");

            fnc_SearchEmpNo();
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
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            //�˻�����
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

            dsT_CM_PERSON.dataid = dataClassName+"&S_MODE=SHR_EMP&ENO_NO="+oENO_NO;
            dsT_CM_PERSON.reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_RETTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_RD"/>
       <jsp:param name="CODE_GUBUN"    value="RD"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETTABLE)                |
    | 3. ���Ǵ� Table List(T_AC_RETTABLE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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

    </Script>

    <Script For=dsT_AC_RETTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETTABLE.CountRow);
        }
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
        fnc_SearchList();
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

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_AC_RETTABLE event=CanRowPosChange(row)>
        var keyName;
        var colName;
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������� �����ڸ��</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����ݰ���/<font color="#000000">�������� �����ڸ��</font></td>
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
                <img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)" style="cursor:hand;">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                    <col width="240"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" maxlength= "14"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR', 'txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
<table border="0"><tr><td height="10"></td></tr></table>
	<!-- ���� �Է� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <tr>
                        <td align="center" class="table_cream">
                            <table width="100%" border="1" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="140"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td align="center" class="creamBold"">��&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO" name="txtENO_NO" style="width:70%" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO', 'txtENO_NM');" onChange="fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM');">
                                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo1" name="ImgEnoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                    </td>
                                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO', 'txtENO_NM');" onchange="fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM');">
                                    </td>
                                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
                                    <td class="padding2423" colspan="3">
                                        <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" style="width:100%" class="input_ReadOnly" readonly>
                                    </td>
                                </tr>
                                <tr>
                                	<td align="center" class="creamBold">���ݱ���</td>
                                    <td class="padding2423">
										<select id="cmbRET_GBN" name="cmbRET_GBN" style="width:85">
				                            <option value="DB">DB</option>
				                            <option value="NW">�̰���</option>
				                        </select>
                                    </td>
                                	<td align="center" class="creamBold">�űԱ���</td>
                                    <td class="padding2423">
                                        <input id="txtNEW_GBN" name="txtNEW_GBN" style="width:100%" >
                                    </td>
                                	<td align="center" class="creamBold">�������</td>
                                    <td class="padding2423">
                                        <input id="txtPRV_GBN" name="txtPRV_GBN" style="width:100%" >
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
	<!-- ���� �Է� ���̺� ���� -->
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
					<object id="grdT_AC_RETTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AC_RETTABLE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"    width=30		align=center	    name="NO"         value={String(Currow)}</C>
                            <C> id=ENO_NO       width=70        align=center        name=���               </C>
                            <C> id=ENO_NM       width=70        align=center        name=����               </C>
                            <C> id=JOB_NM       width=70        align=center        name=����               </C>
                            <C> id=RET_GBN      width=100       align=center        name=���ݱ���     value={DECODE(RET_GBN,"DB","DB","DC","DC","NW", "�̰���")}</C>
                            <C> id=NEW_GBN      width=90        align=center        name=�űԱ���               </C>
                            <C> id=PRV_GBN      width=70        align=center        name=������             </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
    <input type="hidden" name="rownum" value="1">
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


<!-- T_SV_SAVELIST ���ο��ݰ����� ���ε��� ���� -->
<object id="bndT_AC_RETTABLE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETTABLE">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO               Ctrl=txtENO_NO              Param=value     </C>
        <C>Col=ENO_NM               Ctrl=txtENO_NM              Param=value     </C>
        <C>Col=JOB_NM               Ctrl=txtJOB_NM_SHR              Param=value     </C>
        <C>Col=RET_GBN        	 Ctrl="cmbRET_GBN"        Param=value   </C>
        <C>Col=NEW_GBN           Ctrl=txtNEW_GBN        Param=value   </C>
        <C>Col=PRV_GBN           Ctrl=txtPRV_GBN        Param=value   </C>
    '>
</object>
