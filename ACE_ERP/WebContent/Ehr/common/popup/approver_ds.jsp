<!--
***********************************************************************
* @source      : approver.jsp
* @description : ������������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/10/13      ���뼺        �����ۼ�.
* 2006/11/22      ������        �����̺�Ʈ �߰�.
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>

<%

    String gbn_cd     = request.getParameter("GBN_CD");
    String ret_cd     = request.getParameter("RET_CD");
    String str_ymd    = request.getParameter("STR_YMD");
    String end_ymd    = request.getParameter("END_YMD");
    String dpt_cd     = request.getParameter("DPT_CD");
%>

<html>

    <head>
    <title>������������ȸ(approver)</title>
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

        var dataSet  = window.dialogArguments;
        var dataSet1 = window.dialogArguments;


        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=common.empl.cmd.EMPLCMD&S_MODE=SHR"
                                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                                 + "&DPT_CD="+document.getElementById("txtDPT_CD_SHR").value
                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value
                                 ;
            dsT_CM_PERSON.reset();
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

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)

            // ���� �� �ش� �׸���� Focus �̵�

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


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style ����
            form1.grdT_CM_PERSON.HiddenHScroll  = true;
            form1.grdT_CM_PERSON.DisableNoHScroll = false;

            cfStyleGrid(form1.grdT_AD_DECISION,0,"false","false");      // Grid Style ����
            form1.grdT_AD_DECISION.HiddenHScroll  = true;
            form1.grdT_AD_DECISION.DisableNoHScroll = false;
			//������ : ����� �����ڷ� �ڵ����� �Ұ�
            var eno_no  = dataSet.NameValue(dataSet.countRow,"ENO_NO");
            var dpt_cd  = "<%=dpt_cd %>";
	        var gbn_cd  = "<%=gbn_cd %>";
	        var ret_cd  = "<%=ret_cd %>";
	        var str_ymd = "<%=str_ymd %>";
	        var end_ymd = "<%=end_ymd %>";

            //�Ѿ�� ����� ������ �����ϰ�
            document.getElementById("txtENO_NO").value      = eno_no;
            document.getElementById("hidGBN_CD").value      = gbn_cd;
            document.getElementById("hidRET_CD").value      = ret_cd;
            document.getElementById("hidSTR_YMD").value     = str_ymd;
            document.getElementById("hidEND_YMD").value     = end_ymd;

            //�Ѿ�� ������� ������� �˻�
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO");
            if(enoObj.eno_no == "") {
                alert("��û�� ������ �����ϴ�.");
                window.close();
                return;
            }

            //�˻�����(�Ҽ�)����
            if(dpt_cd != "") {
                document.getElementById("txtDPT_CD_SHR").value  = dpt_cd;
                fnc_GetCommNm('A4', "txtDPT_CD_SHR", "txtDPT_NM_SHR");
            } else {
                document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
                document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
            }

            //��û�� ���� �߰�
            document.getElementById("lblJOB_NM_A2").innerText   = enoObj.job_nm;
            document.getElementById("lblENO_NO_A2").innerText   = enoObj.eno_no;
            document.getElementById("lblENO_NM_A2").innerText   = enoObj.eno_nm;

            //��û�� ���� ����
            document.getElementById("txtENO_NO").value      = enoObj.eno_no;
            document.getElementById("txtENO_NM").value      = enoObj.eno_nm;
            document.getElementById("txtDPT_CD").value      = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM").value      = enoObj.dpt_nm;
            document.getElementById("txtJOB_CD").value      = enoObj.job_cd;
            document.getElementById("txtJOB_NM").value      = enoObj.job_nm;

            //���缱����

            cfCopyDataSet(dataSet, dsT_AD_DECISION);
            fnc_SearchList();
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
            cfCopyDataSet(dsT_AD_DECISION, dataSet1);
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
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_AD_DECISION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <Script For=dsT_AD_DECISION Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_AD_DECISION Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_AD_DECISION Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var i = 0;

        //�ߺ����üũ
        for(i=1; i<=dsT_AD_DECISION.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_AD_DECISION.NameValue(i,'ENO_NO')){
                alert("�ش� �����ڴ� �̹� ���缱�� ���ԵǾ� �ֽ��ϴ�.");
                return false;
            }
        }

		if(dsT_AD_DECISION.CountRow >= 5){
			alert("���缱�� 5 �� ������ �����Ҽ��ֽ��ϴ�.");
			return false;
		}

        dsT_AD_DECISION.InsertRow(1);//���������� �ֱ� ���� insert

        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ORD_NO") = dsT_AD_DECISION.NameValue(dsT_AD_DECISION.countRow,"ORD_NO");//������� ǰ�ǹ�ȣ
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"NAM_KOR") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"AUTHO_CD") = "A"+dsT_AD_DECISION.CountRow;

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var i = 0;

        //�ߺ����üũ
        for(i=1; i<=dsT_AD_DECISION.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_AD_DECISION.NameValue(i,'ENO_NO')){
                alert("�ش� �����ڴ� �̹� ���缱�� ���ԵǾ� �ֽ��ϴ�.");
                return false;
            }
        }
		if(dsT_AD_DECISION.CountRow >= 5){
			alert("���缱�� 5 �� ������ �����Ҽ��ֽ��ϴ�.");
			return false;
		}

        dsT_AD_DECISION.InsertRow(1);//���������� �ֱ� ���� insert

        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ORD_NO") = dsT_AD_DECISION.NameValue(dsT_AD_DECISION.countRow,"ORD_NO");//������� ǰ�ǹ�ȣ
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"NAM_KOR") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_AD_DECISION.NameValue(dsT_AD_DECISION.RowPosition,"AUTHO_CD") = "A"+dsT_AD_DECISION.CountRow;

    </script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_AD_DECISION event=OnDblClick(row,colid)>

        var j = 0;
        var i = 0;

        // ����ڴ� ���� ���Ѵ�.
        if(dsT_AD_DECISION.CountRow == row){
            alert("��û�ڴ� ���缱���� ������ �� �����ϴ�.");
            return;
        }

        dsT_AD_DECISION.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_AD_DECISION.CountRow-1; i>=1; i--){
            j++;
            dsT_AD_DECISION.NameValue(i,"AUTHO_CD") = "A"+j;
        }

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_AD_DECISION event=OnReturn(row,colid)>

        var j = 0;
        var i = 0;

        // ����ڴ� ���� ���Ѵ�.
        if(dsT_AD_DECISION.CountRow == row){
            alert("��û�ڴ� ���缱���� ������ �� �����ϴ�.");
            return;
        }

        dsT_AD_DECISION.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_AD_DECISION.CountRow-1; i>=1; i--){
            j++;
            dsT_AD_DECISION.NameValue(i,"AUTHO_CD") = "A"+j;
        }

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������ȸ</td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">��� ��ȣ/����&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">

                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">

                                        <input type="hidden" id="txtENO_NO">
                                        <input type="hidden" id="txtENO_NM">
                                        <input type="hidden" id="txtDPT_CD">
                                        <input type="hidden" id="txtDPT_NM">
                                        <input type="hidden" id="txtJOB_CD">
                                        <input type="hidden" id="txtJOB_NM">
                                    </td>

                                    <td align="center" class="searchState">�Ҽ�&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:144px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           width=100  name=����   align=left   </C>
                                    <C> id=DPT_NM            width=90   name=�Ҽ�   align=left   </C>
                                    <C> id=JOB_NM            width=80   name=����   align=left   </C>
                                    <C> id=ENO_NO            width=80   name=���   align=center show=false</C>
                                    <C> id=ENO_NM            width=159   name=����   align=center </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">�� �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>���缱</strong>
	        </td>
	    </tr>
	    <tr>
	        <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_AD_DECISION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:144px;">
                                <param name="DataID"            value="dsT_AD_DECISION">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=AUTHO_CD          width=39    name=NO     align=center   </C>
                                    <C> id=DPT_NM            width=110   name=�Ҽ�   align=left     </C>
                                    <C> id=JOB_NM            width=80    name=����   align=center   </C>
                                    <C> id=ENO_NO            width=100   name=���   align=center   show=false</C>
                                    <C> id=NAM_KOR           width=200   name=����   align=center   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">�� �ش��׸��� ����Ŭ�� �Ͻø� �����˴ϴ�.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">��û��</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="creamBold">���</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                    </tr>
                </table>
            </td>
        </tr>
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