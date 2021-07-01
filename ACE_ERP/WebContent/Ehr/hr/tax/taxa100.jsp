<!--*************************************************************************
* @source      : taxa100.jsp                                                *
* @description : �������μ���������Ȳ PAGE                                    *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/05/05            ���м�             �����ۼ�
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�������μ���������Ȳ(taxa100)</title>
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

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa050.cmd.TAXA050CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            var f = document.form1;
            var STR_YM  = f.txtSTR_YM_SHR.value;
            var END_YM  = f.txtEND_YM_SHR.value;
            var OCC_CD1;
            var OCC_CD2;
            var OCC_NM;
            var SAL_GBN = f.cmbSAL_GBN_SHR.value;
            var SAL_VAL;
            var SEQ     = f.cmbSORT_GBN_SHR.value;
            var LUN_AMT = f.cmbLUN_AMT_SHR.value;

            if ( STR_YM == null || STR_YM == "" )
            {
                alert("���۳�¥�� �Է��� �ֽʽÿ�!");
                f.txtSTR_YM_SHR.focus();
                return false;
            }
            if ( END_YM == null || END_YM == "" )
            {
                alert("�����³�¥�� �Է��� �ֽʽÿ�!");
                f.txtEND_YM_SHR.focus();
                return false;
            }

            if(removeChar(STR_YM,'-') > removeChar(END_YM,'-') || removeChar(STR_YM,'/') > removeChar(END_YM,'/')) {
                alert("���ۿ����� ���Ῥ������ Ů�ϴ�!");
                document.getElementById("txtSTR_YM_SHR").focus();
                return;
            }

            if ( f.cmbOCC_CD_SHR.value == "T" ) {
                OCC_CD1 = "A";
                OCC_CD2 = "M";
                OCC_NM  = "�ٷα��� : ��ü";
            } else if ( f.cmbOCC_CD_SHR.value == "A" ) {
                OCC_CD1 = "A";
                OCC_CD2 = "A";
                OCC_NM  = "�ٷα��� : �繫��";
            } else if ( f.cmbOCC_CD_SHR.value == "M" ) {
                OCC_CD1 = "M";
                OCC_CD2 = "M";
                OCC_NM  = "�ٷα��� : �ù���";
            } else {
                OCC_CD1 = "A";
                OCC_CD2 = "M";
                OCC_NM  = "�ٷα��� : ��ü";
            }

            if ( SAL_GBN == "0" ) {
                SAL_VAL = "�� �� : �޿�";
            } else if ( SAL_GBN == "1" ) {
                SAL_VAL = "�� �� : ��";
            } else if ( SAL_GBN == "4" ) {
                SAL_VAL = "�� �� : ����";
            } else {
                SAL_GBN = "0";
                SAL_VAL = "�� �� : �޿�";
            }


            params = "STR_YM="+STR_YM
                   + "&END_YM="+END_YM
                   + "&OCC_CD1="+OCC_CD1
                   + "&OCC_CD2="+OCC_CD2
                   + "&OCC_NM="+OCC_NM
                   + "&SAL_GBN="+SAL_GBN
                   + "&SAL_VAL="+SAL_VAL
                   + "&SEQ="+SEQ
                   + "&LUN_AMT="+LUN_AMT;

			var url = "taxa100_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

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

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {

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
            //ù��° �μ� : �׸����
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)

            document.getElementById("txtSTR_YM_SHR").value = getTodayArray()[0]+"-01";
            document.getElementById("txtEND_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
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
         * ��¥ ���� ��ȿ�� üũ                     *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

         /********************************************
         * �������ڿ��� ��Ŀ�� ������ ��û���ڿ� ��*
         ********************************************/
        function cfCheckDateTermGUNA040(p_obj,p_stdt,p_endt) {
          if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
            if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
              alert("�������ڰ� �������ں��� Ů�ϴ�.");
              document.getElementById(p_obj).value = '';
            }
          }
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet                               |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U5"/>
       <jsp:param name="CODE_GUBUN"    value="U5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
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
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������μ���������Ȳ</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�������μ���������Ȳ</font></td>
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
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a -->
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a -->
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td align="right" class="searchState">�ش�Ⱓ&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtSTR_YM_SHR"  name="txtSTR_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtSTR_YM_SHR','','108','113');">
                        <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                         ~
                        <input type="text" id="txtEND_YM_SHR"  name="txtEND_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtEND_YM_SHR','','224','113');">
                        <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>

                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbOCC_CD_SHR">
                            <option value="T">��ü</option>
                            <option value="A">�繫��</option>
                            <option value="M">�ù���</option>
                        </select>
<!--
                        <input type="checkbox" name="chkOCC_CD_SHR" id="chkOCC_CD_SHR" style="margin-bottom:-2px;border:0;" checked>�繫��
                        <input type="checkbox" name="chkOCC_CD_SHR" id="chkOCC_CD_SHR" style="margin-bottom:-2px;border:0;">�ù���  -->
                    </td>
                    <td align="right" class="searchState">�߽Ĵ�</td>
                    <td class="padding2423">
                        <select id="cmbLUN_AMT_SHR">
                            <option value="Y">����</option>
                            <option value="N">������</option>
                        </select>
<!--                         <input type="checkbox" name="radLUN_AMT_SHR" id="radLUN_AMT_SHR" style="margin-bottom:-2px;border:0;" checked> -->
                    </td>
                    <td class="searchState" align="right">����1</td>
                    <td class="padding2423" align="left">
                        <select id="cmbSAL_GBN_SHR">
                            <option value="0">�޿�</option>
                            <option value="1">��</option>
                            <option value="4">����</option>
                        </select>
<!--                         <input type="radio" name="radSAL_GBN_SHR" id="radSAL_GBN_SHR" style="margin-bottom:-2px;border:0;" checked>�޿�
                        <input type="radio" name="radSAL_GBN_SHR" id="radSAL_GBN_SHR" style="margin-bottom:-2px;border:0;">��
                        <input type="radio" name="radSAL_GBN_SHR" id="radSAL_GBN_SHR" style="margin-bottom:-2px;border:0;">����� -->
                    </td>

                    <td class="searchState" align="right">����2</td>
                    <td class="padding2423" align="left">
                        <select id="cmbSORT_GBN_SHR">
                            <option value="10">�μ���</option>
                            <option value="20">������</option>
                            <option value="30">T������</option>
                        </select>
<!--                        <input type="radio" name="radSORT_GBN_SHR" id="radSORT_GBN_SHR" style="margin-bottom:-2px;border:0;" checked>�μ���
                        <input type="radio" name="radSORT_GBN_SHR" id="radSORT_GBN_SHR" style="margin-bottom:-2px;border:0;">������
                        <input type="radio" name="radSORT_GBN_SHR" id="radSORT_GBN_SHR" style="margin-bottom:-2px;border:0;">T������ -->
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
