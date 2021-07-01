<!--*************************************************************************
* @source      : taxa070.jsp                                                *
* @description : ���������ڷ�޿��ݿ� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>���������ڷ�޿��ݿ�(taxa070)</title>
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
                    + "F"   //����(ó��)
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa070.cmd.TAXA070CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oPIS_YY     = document.getElementById("txtPIS_YY_SHR");

            params = "&S_MODE=SHR"
                   + "&OCC_CD="+oOCC_CD.value
                   + "&PIS_YY="+oPIS_YY.value;

            dsT_CP_PAYMASTER.ClearData();

            dsT_CP_PAYMASTER.dataid = dataClassName+params;
            dsT_CP_PAYMASTER.reset();
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
            //��ȿ�� �˻�
            if(!fnc_CheckElement(oElementList, oElementMsgList, new Array())) return;
            if(fnc_GetCheckedValue("radSAL_GBN") == "") {
                alert("������ ������ �ּ���.");
                document.getElementById("radSAL_GBN").focus();
                return;
            }
            dsT_CP_PAYMASTER.UseChangeInfo = "false";

            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oPIS_YY     = document.getElementById("txtPIS_YY_SHR");
            var vPIS_YM     = document.getElementById("txtPIS_YM").value.split("-");
            var oSVC_TYPE   = document.getElementById("txtSVC_TYPE");

            params = "&S_MODE=SAV"
                   + "&OCC_CD="+oOCC_CD.value
                   + "&PIS_YY2="+oPIS_YY.value
                   + "&PIS_YY="+vPIS_YM[0]
                   + "&PIS_MM="+vPIS_YM[1]
                   + "&SAL_GBN="+fnc_GetCheckedValue("radSAL_GBN")
                   + "&SVC_TYPE="+oSVC_TYPE.value;

            trT_CP_PAYMASTER.KeyValue = "SAV"
                                      + "(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"
                                      + ",O:dsRESULT=dsRESULT"
                                      + ")";
            trT_CP_PAYMASTER.action = dataClassName+params;
            trT_CP_PAYMASTER.post();
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
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_CP_PAYMASTER.GridToExcel("���������ڷ�޿��ݿ�", '', 225);
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

            dsT_CP_PAYMASTER.ClearData();

            //���ڰ��� ���ε�
            var toDays = getTodayArray();
            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1];
            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1];
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_PAYMASTER.IsUpdated)  {
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
            var oPIS_YY_SHR = document.getElementById("txtPIS_YY_SHR");
            oPIS_YY_SHR.value = getTodayArray()[0]-1;

            var oBTN1 = document.getElementById("btnPROC1");
            var oBTN2 = document.getElementById("btnPROC2");
            oBTN1.disabled = true;
            oBTN2.disabled = true;

   				alert("��������  �޿� �ݿ� �����ڷ�� ó���ٶ��ϴ�.");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
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
        var oElementList = new Array(   "txtPIS_YY_SHR"
                                       ,"cmbOCC_CD_SHR"
                                       ,"txtPIS_YM");

        //�׸���� �޼���
        var oElementMsgList = new Array("�⸻���� �ش�⵵"
                                       ,"�ٷα���"
                                       ,"�ش���");

        //���� �׸��
        var oExceptionList = new Array( "cmbOCC_CD_SHR"
                                       ,"txtPIS_YM");




    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_PAYMASTER)                |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut             value="3600000">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=TimeOut             value="3600000">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_PAYMASTER)                |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName             Value="toinb_dataid4">
        <param name=TimeOut             value="3600000">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0 )    {
            alert("���� ����� �����ϴ�.");
        } else {
            var vPRO_STS;
            var oBTN1 = document.getElementById("btnPROC1");
            var oBTN2 = document.getElementById("btnPROC2");

            oBTN1.disabled = true;
            oBTN2.disabled = true;

            if(dsT_CP_PAYMASTER.NameString(1, "PIS_YY") != "" || dsT_CP_PAYMASTER.NameString(1, "PIS_MM") != "")
                document.getElementById("txtPIS_YM").value  = dsT_CP_PAYMASTER.NameString(1, "PIS_YY")+"-"+dsT_CP_PAYMASTER.NameString(1, "PIS_MM");
            fnc_CheckedElement("radSAL_GBN", dsT_CP_PAYMASTER.NameString(1, "SAL_GBN"));

            vPRO_STS = dsT_CP_PAYMASTER.NameString(1, "PRO_STS");
            document.getElementById("txtPRO_STS").value     = vPRO_STS;
            document.getElementById("txtPRO_STS_MSG").value = dsT_CP_PAYMASTER.NameString(1, "PRO_STS_MSG");

            document.getElementById("txtPRO_CNT").value     = dsT_CP_PAYMASTER.NameString(1, "PRO_CNT");

            if(vPRO_STS == "3") oBTN1.disabled = false;
            else oBTN2.disabled = false;
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        alert(dsRESULT.NameString(1,"PRO_STS")+":("+dsRESULT.NameString(1,"RTN_CD")+") "+dsRESULT.NameString(1,"RTN_MSG"));
        fnc_OnLoadProcess();
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���������ڷ�޿��ݿ�</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">���������ڷ�޿��ݿ�</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
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
				<colgroup>
					<col width="130"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td class="searchState" align="right">�⸻���� �ش�⵵</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()" onchange="clearDS()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY','','134','108');"></a>
                    </td>
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD_SHR" id="cmbOCC_CD_SHR">
                            <option value="A">�繫��</option>
                            <option value="M">�ù���</option>
                        </select>
                    </td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->


    <!-- ���� �Է� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    	<tr>
            <td class="paddingTop8">
    			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    				<colgroup>
                        <col width="80"></col>
    					<col width="80"></col>
    					<col width="310"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
                        <td align="center" class="creamBold">��(��)��</td>
    					<td align="center" class="creamBold">�ش���</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','134','108');"></a>
    					</td>
    	        		<td align="center" class="creamBold">����</td>
    	        		<td>
                            &nbsp;&nbsp;
                            <input type="radio" id="radSAL_GBN" name="radSAL_GBN" value="0">&nbsp;�޿�
                            &nbsp;&nbsp;
                            <input type="radio" id="radSAL_GBN" name="radSAL_GBN" value="1">&nbsp;��
    	        		</td>
    				</tr>
    				<tr>
    	        		<td align="center" class="creamBold" colspan="2">�۾���Ȳ</td>
    	        		<td  class="padding2423">
    	        			<input id="txtPRO_STS" name="txtPRO_STS" style="width:20px"  class="input_ReadOnly" readonly>
    	        			<input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:90%"  class="input_ReadOnly" readonly>
    	        		</td>
                        <td align="center" class="creamBold">ó���ο�</td>
                        <td  class="padding2423">
                            <input id="txtPRO_CNT" name="txtPRO_CNT" style="width:100px"  class="input_ReadOnly" readonly>&nbsp;��
                        </td>
    	            </tr>
                    <tr>
                        <td align="center" class="creamBold" colspan="2">�۾�����</td>
                        <td  class="padding2423" colspan="3" colspan="3" height="60">
                            <input type="hidden" id="txtSVC_TYPE" name="txtSVC_TYPE" value="">
                            &nbsp;&nbsp;
                            <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" ��   �� " onclick="document.getElementById('txtSVC_TYPE').value = 'Y'; fnc_Save();">
                            &nbsp;
                            <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" ��   �� " onclick="document.getElementById('txtSVC_TYPE').value = 'N'; fnc_Save();">
                            &nbsp;&nbsp;
                        </td>
                    </tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- ���� �Է� ���̺� �� -->

    </form>
    <!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
