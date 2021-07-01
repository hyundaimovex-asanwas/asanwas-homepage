<!--
    ************************************************************************************
    * @Source         : taxa150.jsp                                                    *
    * @Description    : ������������� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/21  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�������������(taxa150)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    <script language=javascript src="/common/input.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFFTFTFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var DPT_CD    = document.getElementById("cmbDPT_CD_SHR").value;


            dsT_CM_DEPT.ClearData();

            dsT_CM_DEPT.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa150.cmd.TAXA150CMD&S_MODE=SHR&DPT_CD="+DPT_CD;
            dsT_CM_DEPT.Reset();

            form1.grdT_CM_DEPT.Focus();

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

            if(fnc_SaveItemCheck()) {

                trT_CM_DEPT.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa150.cmd.TAXA150CMD&S_MODE=SAV";
                trT_CM_DEPT.post();

            } else {

                return;

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

            if (dsT_CM_DEPT.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_DEPT.GridToExcel("�������������", '', 225);

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

            document.getElementById("cmbDPT_CD_SHR").value = '';
          /*  document.getElementById("txtDPT_NM_SHR").value = ''; */

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CM_DEPT.ClearData();

            fnc_ColEnabled('D');

            document.getElementById("cmbDPT_CD_SHR").focus();

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

            var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_DEPT.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_DEPT.CountRow; i++ ) {
                if ( dsT_CM_DEPT.RowStatus(i) == 1 ||
                     dsT_CM_DEPT.RowStatus(i) == 3 ) {

                    // ���
                    if( dsT_CM_DEPT.NameValue(i, "DPT_CD") == '' ) {
                        alert("������� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_DEPT.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return false;
                    }

                    // ���
                    if( dsT_CM_DEPT.NameValue(i, "DPT_CD") != '' && dsT_CM_DEPT.NameValue(i, "DPT_NM") == '') {
                        alert("�Է��Ͻ� ������� �������� �ʴ� ������Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_DEPT.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return false;
                    }


                        // �������ڿ� �������� ��
                        if( dsT_CM_DEPT.NameValue(i, "STR_YMD") != '' && dsT_CM_DEPT.NameValue(i, "END_YMD") != '' ) {
                            if( cfDateDiff(dsT_CM_DEPT.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_CM_DEPT.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                                alert("�������ڰ� �������ں��� �۽��ϴ�.");
                                dsT_CM_DEPT.RowPosition = i;
                                document.getElementById("txtEND_YMD").focus();
                                return false;
                            }
                        }


                    if ( dsT_CM_DEPT.RowStatus(i) == 1) {
                       document.getElementById("txtDPT_CD").disabled  = true;
                       document.getElementById("txtDPT_NM").disabled  = true;

                    }

                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_DEPT,0,"false","false");

            fnc_ColEnabled('D');


            dsT_CM_DEPT2.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD"
                                     + "&S_MODE=SHR_DPT"
                                     + "&PIS_YY=2007"
                                     + "&PIS_MM=09";
            dsT_CM_DEPT2.reset();

            fnc_ConstructCommonCode("dsT_CM_DEPT2", "cmbDPT_CD_SHR", "", "�� ü");

            document.getElementById("cmbDPT_CD_SHR").focus();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

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


        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtDPT_NM").disabled   = false;
                document.getElementById("txtREMARK2").disabled  = false;
                document.getElementById("txtREMARK3").disabled  = false;
                document.getElementById("txtOFFICE").disabled   = false;
                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtCOM_NO").disabled   = false;

                document.getElementById("ImgStrYmd").disabled   = false;
                document.getElementById("ImgEndYmd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtDPT_NM").disabled   = true;
                document.getElementById("txtREMARK2").disabled  = true;
                document.getElementById("txtREMARK3").disabled  = true;
                document.getElementById("txtOFFICE").disabled   = true;
                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtCOM_NO").disabled   = true;

                document.getElementById("ImgStrYmd").disabled   = true;
                document.getElementById("ImgEndYmd").disabled   = true;

            }
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_DEPT)      |
    | 3. ���Ǵ� Table List(T_CM_DEPT)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_DEPT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_DEPT                         |
    | 3. Table List : T_CM_DEPT                     |
    +----------------------------------------------->
    <Object ID ="trT_CM_DEPT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_DEPT)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_DEPT.CountRow );

            fnc_ColEnabled('E');

            document.getElementById("txtDPT_CD").disabled  = true;
            document.getElementById("txtDPT_NM").disabled  = true;

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_DEPT Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DEPT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_DEPT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_DEPT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_DEPT event=OnRowPosChanged(row)>



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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������������</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�������������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="60"></col>
                                <col width="215"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">����� </td>
                                <td class="padding2423">
                             <!--        <input name=txtDPT_CD_SHR size="6"  maxlength="6" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input name=txtDPT_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                         <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd1" name="ImgDptCd1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�����','BRCH');"></a>  -->
                                  <select id="cmbDPT_CD_SHR">
                                  </select>
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

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="75"></col>
                    <col width="120"></col>
                    <col width="75"></col>
                    <col width="120 "></col>
                    <col width="75"></col>
                    <col width="130"></col>
                    <col width="75"></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" colspan="3">
                        <input name=txtDPT_CD id=txtDPT_CD style="width:15%;ime-mode:disabled" maxlength="6" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');"> <input name=txtDPT_NM id=txtDPT_NM style="width:80%" class="input_ReadOnly" readOnly>
                    </td>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423"  colspan="3">
                        <input name=txtREMARK2 id=txtREMARK2 maxlength="150" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:70" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','65','159');"><img src="/images/button/btn_HelpOn.gif" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<input id="txtEND_YMD" style="width:70" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','265','159');"><img src="/images/button/btn_HelpOn.gif" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
                    <td align="center" class="creamBold">��ȭ��ȣ</td>
                    <td class="padding2423">
                        <input name=txtREMARK3 id=txtREMARK3 maxlength="60" style="width:100%;ime-mode:disabled" >
                    </td>
                    <td align="center" class="creamBold"><span id="name">����ڹ�ȣ</span></td>
                    <td class="padding2423">
                        <input name=txtCOM_NO id=txtCOM_NO maxlength="12" style="width:100%" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfComNoHyphen(this);cfNumberCheck();">
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">����/����</td>
					<td class="padding2423">
						<select id="cmbGBN2_TAG" style="width:100%">
							<option value="" >����</option>
							<option value="1" >����</option>
							<option value="9" >����</option>
						</select>
					</td>                    					<td align="center" class="creamBold">�ֹμ�</td>
					<td class="padding2423">
						<select id="cmbHEAD_TAG" style="width:100%">
							<option value="" >����</option>
							<option value="0" >����μ�</option>
							<option value="1" >����μ�</option>
							<option value="2" >�����</option>
						</select>
					</td>
                    <td align="center" class="creamBold">���ұ��</td>
                    <td class="padding2423" colspan="3">
                        <input name=txtOFFICE id=txtOFFICE maxlength="20" style="width:100%">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_DEPT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_DEPT">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='{currow}'       width=40    name='����'           align=center </FC>
                                <FC> id='COMM_CD'        width=80    name='�ڵ�'           align=left  </FC>
                                <FC> id='COMM_NM'        width=150   name='�����'         align=left   </FC>
                                <C>  id='OFFICE'         width=100   name='���ұ��'       align=left   </C>
                                <C>  id='GBN2_TAG'       width=70    name='����/����'      align=center value={Decode(GBN2_TAG,'0','����','9','����','������')} </C>
                                <C>  id='HEAD_TAG'       width=70    name='�ֹμ�'         align=center value={Decode(HEAD_TAG,'0','����','1','����','2','�����','������')} </C>
                                <C>  id='REMARK2'        width=200   name='�ּ�'           align=left   </C>
                                <C>  id='REMARK3'        width=90    name='��ȭ��ȣ'       align=left   </C>
                                <C>  id='STR_YMD'        width=70    name='�����'         align=center </C>
                                <C>  id='END_YMD'        width=70    name='�����'         align=center </C>
                                <C>  id='COM_NO'         width=90    name='����ڹ�ȣ'     align=center </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_DEPT">
    <Param Name="BindInfo", Value='
        <C> Col=COMM_CD      Ctrl=txtDPT_CD     Param=value Disable=disabled</C>
        <C> Col=COMM_NM      Ctrl=txtDPT_NM     Param=value </C>
        <C> Col=REMARK2     Ctrl=txtREMARK2    Param=value </C>
        <C> Col=REMARK3     Ctrl=txtREMARK3    Param=value </C>
        <C> Col=OFFICE      Ctrl=txtOFFICE     Param=value </C>
        <C> Col=GBN2_TAG    Ctrl=cmbGBN2_TAG   Param=value </C>
        <C> Col=HEAD_TAG    Ctrl=cmbHEAD_TAG   Param=value </C>
        <C> Col=STR_YMD     Ctrl=txtSTR_YMD    Param=value </C>
        <C> Col=END_YMD     Ctrl=txtEND_YMD    Param=value </C>
        <C> Col=GBN_CD      Ctrl=txtGBN_CD     Param=value </C>
        <C> Col=COM_NO      Ctrl=txtCOM_NO     Param=value </C>
    '>
</object>

