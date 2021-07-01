<!--
***********************************************************************
* @source      : educourse.jsp
* @description : ����������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/10/13      ���뼺        �����ۼ�.
* 2006/11/22      ������        �����̺�Ʈ �߰�.
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
    <title>����������ȸ</title>
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

        var retObj = window.dialogArguments;

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'T' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value;//������ȸ�� ���
            var COMM_CD = document.getElementById("txtCOMM_CD_SHR").value;

            dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.education.cmd.EDUCATIONCMD&S_MODE=SHR&COMM_CD="+COMM_CD;
            dsT_CM_COMMON.Reset();

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

            dsT_CM_COMMON.ClearData();
            dsT_ED_CHASULIST.ClearData();
            document.getElementById("resultMessage").innerHTML = "&nbsp;";

            document.getElementById("txtCOMM_CD_SHR").value = "";
            document.getElementById("txtCOMM_CD_SHR").focus();

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

            cfStyleGrid(form1.grdT_CM_COMMON,0,"false","right");      // Grid Style ����

            form1.grdT_CM_COMMON.HiddenHScroll  = true;
            form1.grdT_CM_COMMON.DisableNoHScroll = false;

            cfStyleGrid(form1.grdT_ED_CHASULIST,0,"false","right");      // Grid Style ����

            form1.grdT_ED_CHASULIST.HiddenHScroll  = true;
            form1.grdT_ED_CHASULIST.DisableNoHScroll = false;


            //document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);

            fnc_SearchList();

            document.getElementById("txtCOMM_CD_SHR").focus();
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        //Ȯ��ó��
        function fnc_Confirm(row) {

	        retObj.edu_cd  = dsT_ED_CHASULIST.NameValue(row,'EDU_CD');
	        retObj.edu_nm  = dsT_ED_CHASULIST.NameValue(row,'EDU_NM');
	        retObj.seq_no  = dsT_ED_CHASULIST.NameValue(row,'SEQ_NO');
	        retObj.edu_str_ymd = dsT_ED_CHASULIST.NameValue(row,'EDU_STR_YMD');
	        retObj.edu_end_ymd = dsT_ED_CHASULIST.NameValue(row,'EDU_END_YMD');

	        retObj.edu_gbn_cd  = dsT_ED_CHASULIST.NameValue(row,'EDU_GBN_CD');

	        retObj.int_nam  = dsT_ED_CHASULIST.NameValue(row,'INT_NAM');
	        retObj.place_cd = dsT_ED_CHASULIST.NameValue(row,'PLACE_CD');
	        retObj.place_nm = dsT_ED_CHASULIST.NameValue(row,'PLACE_NM');
	        retObj.cpt_pnt  = dsT_ED_CHASULIST.NameValue(row,'CPT_PNT');

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
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            //grdT_CM_COMMON.SetColumn("COMM_CD");//set focus
            grdT_CM_COMMON.focus();
        }
    </Script>

    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_ED_CHASULIST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<script language=JavaScript for=dsT_CM_COMMON event=OnRowPosChanged(row)>

        if(dsT_CM_COMMON.countrow > 0){
	        //var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;//������ȸ�� ���
		    var EDU_CD = dsT_CM_COMMON.NameValue(row,'COMM_CD');

	        dsT_ED_CHASULIST.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.education.cmd.EDUCATIONCMD&S_MODE=SHR_01&EDU_CD="+EDU_CD;
	        dsT_ED_CHASULIST.Reset();
        }

	</script>


    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_COMMON event=OnDblClick(row,colid)>

        if(dsT_ED_CHASULIST.countrow > 0){
            form1.grdT_ED_CHASULIST.Focus();
        }

    </script>

    <script language=JavaScript for=grdT_ED_CHASULIST event=OnDblClick(row,colid)>

        fnc_Confirm(row);

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_COMMON event=OnReturn(row,colid)>

        if(dsT_ED_CHASULIST.countrow > 0){
            form1.grdT_ED_CHASULIST.Focus();
        }

    </script>

    <script language=JavaScript for=grdT_ED_CHASULIST event=OnReturn(row,colid)>

        fnc_Confirm(row);

    </script>

<script language=JavaScript for=grdT_ED_CHASULIST event=OnKillFocus()>

      //alert("grdT_ED_CHASULIST OnKillFocus");

</script>


<script language=JavaScript for=grdT_ED_CHASULIST event=OnSetFocus()>

      //alert("grdT_ED_CHASULIST OnSetFocus");

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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ڵ���ȸ</td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
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
                                <colgroup>
                                    <col width="80">
                                    <col width="90">
                                    <col width="80">
                                    <col width="">
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�����ڵ�/��&nbsp;</td>
                                    <td class="padding2423" align="left">
                                        <input name="txtCOMM_CD_SHR" id="txtCOMM_CD_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
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
                            <object    id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:144px;">
                                <param name="DataID"            value="dsT_CM_COMMON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=COMM_CD      width=100   name=�����ڵ�       align=center    </C>
                                    <C> id=COMM_NM      width=329   name=�����ڵ��     align=left     </C>
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

   <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop15">
                <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>��������</strong>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_ED_CHASULIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:144px;">
                                <param name="DataID"            value="dsT_ED_CHASULIST">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=SEQ_NO       width=79   name=����           align=center  </C>
                                    <C> id=EDU_STR_YMD  width=100   name=�н�������     align=center  </C>
                                    <C> id=EDU_END_YMD  width=100   name=�н�������     align=center  </C>
                                    <C> id=EDU_NM      width=150   name=����������     align=left    </C>
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

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">* �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->
    </form>
    <!-- form �� -->

</body>
</html>