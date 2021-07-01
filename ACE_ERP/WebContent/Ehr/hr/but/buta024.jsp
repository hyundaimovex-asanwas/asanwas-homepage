<!--
***********************************************************************
* @source      : buta024.jsp
* @description : �ڰ��� �ܰ� ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/09/17      ������        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>

<html>
<head>
<title>�ڰ���ܰ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

    <script language="javascript" >

        //��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
        var btnList = 'FFTTFTFT';

        var dataSet = window.dialogArguments;
        var row  = "<%=request.getParameter("row")%>";
        var flag = "<%=request.getParameter("flag")%>";

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

	        //��ư ǥ�� ����
	        if(flag == "N"){
	            document.getElementById("imgSave").style.display = "none";//ó����ư �ʺ��̰�
	            fnc_InputDisabled();
	        }else{
	            document.getElementById("imgSave").style.display = "";//ó����ư �ʺ��̰�
	            fnc_InputEnable();
	        }

	        cfCopyDataSet(dataSet, dsT_DI_BUSINESSTRIP_ACCOUNT);

	        form1.medCAR_TOLL.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_TOLL");
	        form1.medCAR_OIL.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_OIL");
	        form1.medCAR_DISTANCE.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_DISTANCE");
	        form1.medCAR_EFFICIENCY.Text = dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_EFFICIENCY");

	        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
	           form1.medPRICE_AMT.Text = 0;
            }else{

               form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
            }


        }

        function fnc_Confirm() {

            if(Number(form1.medCAR_DISTANCE.Text) != 0 && (isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)))){
                alert("�Ÿ��� 0���� ������ �����ϴ�.");
                return false;
            }

            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_TOLL") = form1.medCAR_TOLL.Text;
            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_OIL") = form1.medCAR_OIL.Text;
            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_DISTANCE") = form1.medCAR_DISTANCE.Text;
            dsT_DI_BUSINESSTRIP_ACCOUNT.NameValue(row,"CAR_EFFICIENCY") = form1.medCAR_EFFICIENCY.Text;

            cfCopyDataSet(dsT_DI_BUSINESSTRIP_ACCOUNT, dataSet);

            window.close();

        }

        function fnc_InputDisabled() {

            document.form1.medCAR_TOLL.Enable = "false";
            document.form1.medCAR_OIL.Enable = "false";
            document.form1.medCAR_DISTANCE.Enable = "false";
            document.form1.medCAR_EFFICIENCY.Enable = "false";

        }

        function fnc_InputEnable() {

            document.form1.medCAR_TOLL.Enable = "true";
            document.form1.medCAR_OIL.Enable = "true";
            document.form1.medCAR_DISTANCE.Enable = "true";
            document.form1.medCAR_EFFICIENCY.Enable = "true";

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
    <Object ID="dsT_DI_BUSINESSTRIP_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <script language=JavaScript for=medCAR_TOLL event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>
    <script language=JavaScript for=medCAR_OIL event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>
    <script language=JavaScript for=medCAR_DISTANCE event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>
    <script language=JavaScript for=medCAR_EFFICIENCY event=onKillFocus()>

        if(isNaN(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)) || !isFinite(Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text))){
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + 0;
        }else{
            form1.medPRICE_AMT.Text = Number(form1.medCAR_TOLL.Text) + (Number(form1.medCAR_OIL.Text) * (Number(form1.medCAR_DISTANCE.Text) / Number(form1.medCAR_EFFICIENCY.Text)));
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�ڰ��� �ܰ� ���</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ConductOver.gif',1)"><img src="../../images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- ���� �Է� ���̺� ���� -->
    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>��ӵ��� �����</strong>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0">
	                <colgroup>
	                    <col width="80"></col>
	                    <col width=""></col>
	                </colgroup>
                    <tr>
                        <td class="padding2423" align="left">
                            &nbsp;
	                        <comment id="__NSID__"><object id="medCAR_TOLL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
	                            <param name=Alignment               value=2>
	                            <param name=Border                  value=true>
	                            <param name=ClipMode                value=true>
	                            <param name=DisabledBackColor       value="#EEEEEE">
	                            <param name=Enable                  value=true>
	                            <param name=IsComma                 value=true>
	                            <param name=Language                value=0>
	                            <param name=MaxLength               value=9>
	                            <param name=Numeric                 value=true>
	                            <param name=ShowLiteral             value="false">
	                            <param name=Visible                 value="true">
	                            <param name=SelectAll               value="true">
	                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left">��</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table width="570" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>���� ������</strong>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <table border="0">
                        <col width="80"></col>
                        <col width="90"></col>
                        <col width="80"></col>
                        <col width="80"></col>
                        <col width="80"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td class="padding2423" align="left">
                            &nbsp;
                            <comment id="__NSID__"><object id="medCAR_OIL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left">��(�ܰ�)&nbsp;&nbsp;��&nbsp;&nbsp;(</td>
                        <td class="padding2423" align="left">
                            <comment id="__NSID__"><object id="medCAR_DISTANCE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left"><font style="font-size:15px;">��</font>(�Ÿ�)&nbsp;&nbsp;/</td>
                        <td class="padding2423" align="left">
                            <comment id="__NSID__"><object id="medCAR_EFFICIENCY" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="left"><font style="font-size:15px;">��</font>/<font style="font-size:15px;">��</font>(����)&nbsp;)</td>
                    </tr>
                    <tr height="50" valign="bottom">
                        <td class="padding2423" align="right" colspan="5">
                            <font style="font-size:12px;font-weight:bold;">�հ�&nbsp;:</font>
                        </td>
                        <td class="padding2423" align="left" colspan="1">
                           <comment id="__NSID__"><object id="medPRICE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=9>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=SelectAll               value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

	</form>
	<!-- form �� -->

</body>
</html>