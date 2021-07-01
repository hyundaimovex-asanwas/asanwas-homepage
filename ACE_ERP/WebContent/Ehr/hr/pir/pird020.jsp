<!--
    ************************************************************************************
    * @Source         : pird020.jsp                                                    *
    * @Description    : �λ���ī�� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/05/16  |  �̽¿�   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�λ���ī��-�İ߻��(pird020)</title>
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

        var btnList = 'TFFTFTFT';

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            // ���κ��ΰ��
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                if (document.getElementById("txtNO_SHR").value == "") {
                    alert("����� �ʼ��Է��׸��Դϴ�.");
                    document.getElementById("txtNO_SHR").focus();
                    return;
                }

            }

            var hnwParm = "[:OCC_CD]=[:PRT_SELT]=[:NO_SHR]="; // ������ �ʱ�ȭ
            document.form1.rptObject.SetValues = hnwParm;

			hnwParm = "";
            hnwParm    += "[:OCC_CD]="   + document.getElementById("cmbOCC_CD_SHR").value;
            hnwParm    += "[:PRT_SELT]=" + document.getElementById("cmbPRT_SELT_SHR").value;
            hnwParm    += "[:NO_SHR]="   + document.getElementById("txtNO_SHR").value;

            document.form1.rptObject.SetValues = hnwParm;
            document.form1.rptObject.RunButton("CommandPrint");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            alert("�������Դϴ�.");

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

   			//�˾����� ȣ���
            if (dsTemp != null) {

            }else{

	            document.getElementById("cmbOCC_CD_SHR").value    = 'AM';
	            document.getElementById("cmbPRT_SELT_SHR").value  = '1';
	            document.getElementById("txtNO_SHR").value        = '';
	            document.getElementById("txtNM_SHR").value        = '';

	            document.getElementById("cmbOCC_CD_SHR").focus();

            }

            document.getElementById("resultMessage").innerText = ' ';

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

   			//�˾����� ȣ���
            if (dsTemp != null) {

            	//�ٷα���
				document.getElementById("cmbOCC_CD_SHR").value = dsTemp.NameValue(1,"OCC_CD");
            	document.getElementById("cmbOCC_CD_SHR").disabled = true;

            	//��¼���
				document.getElementById("cmbPRT_SELT_SHR").value = "1";
            	document.getElementById("cmbPRT_SELT_SHR").disabled = true;

            	//���
            	document.getElementById("txtNO_SHR").value = dsTemp.NameValue(1,"ENO_NO");
            	document.getElementById("txtNM_SHR").value = dsTemp.NameValue(1,"ENO_NM");
                document.getElementById("txtNO_SHR").className = "input_ReadOnly";
                document.getElementById("txtNO_SHR").readOnly     = true;
                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly     = true;
                document.getElementById("ImgNo").style.display = "none";


            }else{

	            document.getElementById("cmbOCC_CD_SHR").focus();

            }



        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsTemp != null) {
                window.close();

            } else {
                frame = window.external.GetFrame(window);

                frame.CloseFrame();
            }

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

        function fnc_Popup(cd, nm){

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
               // fnc_emplPopup(cd, nm);
               fnc_empl3Popup(cd, nm,'','','','','2');
            }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
               fnc_commonCodePopup(cd, nm,'�Ҽ�','A4');
            }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
               fnc_commonCodePopup(cd, nm,'����','A2');
            }

        }

        function fnc_FldChange() {

            document.getElementById("txtNO_SHR").value = "";
            document.getElementById("txtNM_SHR").value = "";

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                document.getElementById("txtNM_SHR").className = "";
                document.getElementById("txtNM_SHR").readOnly  = false;
            } else{
                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly  = true;
            }

        }

        function fnc_GetNm() {

            // ���κ�
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                fnc_GetEnoNm('txtNO_SHR', 'txtNM_SHR','2','0');
            }
            // �ҼӺ�
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
                fnc_GetCommNm('A4', 'txtNO_SHR','txtNM_SHR');
            }
            // ������
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
                fnc_GetCommNm('A2', 'txtNO_SHR','txtNM_SHR');
            }
        }

        function fnc_Getcd() {

            // ���κ�
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
	            fnc_GetEnoNo('txtNM_SHR','txtNO_SHR','2','0');
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)    |
    | 3. ���Ǵ� Table List(T_CM_PERSON)           |
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
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�λ���ī��-�İ߻��</td>
                    <td align="right" class="navigator">HOME/�λ����/�λ��������/<font color="#000000">�λ���ī��-�İ߻��</font></td>
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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right" >(�Ҽ�/�������� ��� BLANK: ALL)</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="90"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td align="left" class="padding2423">
                        <select id="cmbOCC_CD_SHR" style="width:76"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                            <option value="AM">��  ü</option>
                            <option value="A">�繫��</option>
                            <option value="M">�ù���</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">��¼���</td>
                    <td class="padding2423">
                        <select id=cmbPRT_SELT_SHR onchange="fnc_FldChange()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" style="width:72">
                            <option value="1">���κ�</option>
                            <option value="2">�ҼӺ�</option>
                            <option value="3">������</option>
                        </select>
                        <input id=txtNO_SHR  name=txtNO_SHR size="8"  maxlength="8" onKeyPress="JavaScript: if(document.getElementById('cmbPRT_SELT_SHR').value == '1') cfNumberCheck();" onChange="fnc_GetNm();"> <input id=txtNM_SHR name=txtNM_SHR size="12" onchange="fnc_Getcd();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('txtNO_SHR','txtNM_SHR')"></a>
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
                    <td valign="top" class="searchState">
                    <!--���⼭���� �ڵ��Դϴ�//-->
                    <comment id="__NSID__">
                      <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
                      <param name="hnwsrc"    VALUE="pird020.hnw">
                      <param name="initvalue" VALUE="">
                      <param name="hidewnd"   VALUE="N">
                      <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                      </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    <!--������� �ڵ��Դϴ�//-->
                        <span id="resultMessage">&nbsp;</span>
                    </td>
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
