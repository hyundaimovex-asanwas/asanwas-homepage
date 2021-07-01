<!--
    ************************************************************************************
    * @Source         : eduj010.jsp                                                    *
    * @Description    : �ڵ���� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�ڵ����(eduj010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >
    
        var btnList = 'TTTTFFTT';
    
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var f = document.form1;

            try {
                dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=SHR&COMM_CD="+f.txtCOMM_CD_SHR.value;
                dsT_CM_COMMON.Reset();
    
                f.grdT_CM_COMMON.focus();
            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
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
            var f = document.form1;
            if(fnc_SaveItemCheck()) {
                tr01T_CM_COMMON.KeyValue = "SVL(I:SAV=ds01T_CM_COMMON)";
                tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=SAV";
                tr01T_CM_COMMON.post();
    
                dsT_CM_COMMON.Reset();
    
                ds01T_CM_COMMON.Reset();
            } else {
                return;
            }
        }
    
        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (ds01T_CM_COMMON.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");//�޼����� �����ε� ������ �������
                return;
            }
            
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("�ڵ�[" + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            ds01T_CM_COMMON.DeleteRow(ds01T_CM_COMMON.RowPosition);
            tr01T_CM_COMMON.KeyValue = "SVL(I:DEL=ds01T_CM_COMMON)";
            tr01T_CM_COMMON.action = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=DEL";
            tr01T_CM_COMMON.post();
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
    
        }
    
        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CM_COMMON.CountRow < 1) {

                alert('��ȸ �� �űԵ���� �����մϴ�.');
                document.getElementById("resultMessage").innerText = "* ��ȸ �� �űԵ���� �����մϴ�."
                return;
            }
    
            // AddNew �� �Է� ���̺�� ��Ŀ��
            ds01T_CM_COMMON.AddRow();
    
            var oCD_GBN = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition,"COMM_CD");
            
            document.getElementById("txtCD_GBN").value = oCD_GBN;
            document.getElementById("txtCOMM_CD").focus();
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
    
        }
    
        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
    
            dsT_CM_COMMON.ClearData();
            ds01T_CM_COMMON.ClearData();
            document.getElementById("txtCOMM_CD_SHR").focus();
        }
    
        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_COMMON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }
    
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
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
               var f = document.form1;
    
            //DataSet�� ���� ���� Ȯ��
            if (!ds01T_CM_COMMON.IsUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
    
            var i = 0;
            var oCD_GBN, oCOMM_CD, oCOMM_NM, oSORT_NO, oEND_YMD;
            var RowCnt = ds01T_CM_COMMON.CountRow;
            for(i=1; i<=RowCnt; i++){
    
                oCD_GBN = ds01T_CM_COMMON.NameValue(i,"CD_GBN");
                if(oCD_GBN.trim() == ""){
                    alert(i+"��°�� ���뱸���ڵ尡 �߸��Ǿ����ϴ�." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtCD_GBN").focus();
                    return false;
                }
    
                oCOMM_CD = ds01T_CM_COMMON.NameValue(i,"COMM_CD");
                if(oCOMM_CD.trim() == ""){
                    alert(i+"��°�� �ڵ尡 �߸��Ǿ����ϴ�." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtCOMM_CD").focus();
                    return false;
                }
    
                oCOMM_NM = ds01T_CM_COMMON.NameValue(i,"COMM_NM");
                if(oCOMM_NM.trim() == ""){
                    alert(i+"��°�� �ڵ��1�� �߸��Ǿ����ϴ�." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtCOMM_NM").focus();
                    return false;
                }
    
                oSORT_NO = ds01T_CM_COMMON.NameValue(i,"SORT_NO");
                if(oSORT_NO.toString().trim().length == 0 || oSORT_NO == 0){
                    alert(i+"��°�� ���ļ�����  �߸��Ǿ����ϴ�." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.medSORT_NO.Focus();
                    return false;
                }
    
                oEND_YMD = ds01T_CM_COMMON.NameValue(i,"END_YMD");
                if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){
                    alert(i+"��°�� ������ڰ�  �߸��Ǿ����ϴ�." );
                    ds01T_CM_COMMON.RowPosition = i;
                    document.getElementById("txtEND_YMD").focus();
                    return false;
                }
            }
    
            return true;
        }
    
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_COMMON,15,"false","right");
            cfStyleGrid(form1.grd01T_CM_COMMON,15,"false","right");
        }
    
        /********************
         * 16. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {
    
            fnc_HotKey_Process(btnList, event.keyCode);
    
        }
    
        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/
    
    </script>
    </head>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_CM_COMMON                       |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : ds01T_CM_COMMON                     |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <Object ID="ds01T_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : tr01T_CM_COMMON                     |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_COMMON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
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
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_COMMON.CountRow);
        }
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CM_COMMON.CountRow);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=tr01T_CM_COMMON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=tr01T_CM_COMMON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid���� row�� Ŭ�������� |
    +------ -------------------->
    <script for=grdT_CM_COMMON event=OnClick(Row,Colid)>

        var overId = "COMM_CD";
        var overValue = dsT_CM_COMMON.NameValue(Row,overId);
        
        if(Row < 1) {
            return;
        } else {
            try {
                ds01T_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.edu.j.eduj010.cmd.EDUJ010CMD&S_MODE=SHR_01&"+overId+"="+overValue;
                ds01T_CM_COMMON.Reset();

            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ڵ����</td>
                    <td align="right" class="navigator">HOME/��������/�ý��۰���/<font color="#000000">�ڵ����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <!-- ���� ȭ�� ����-->
            <table width="350" border="0" cellspacing="0" cellpadding="0">
                <tr align="center"  valign="top">
                    <td  valign="top">
                        <!-- power Search���̺� ���� -->
                        <table width="350" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" class="greenTable">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <colgroup>
                                                        <col width="130"></col>
                                                        <col width=""></col>
                                                        <col width="60"></col>
                                                    </colgroup>
                                                    <tr>
                                                        <td align="right" class="searchState">�ڵ�/�ڵ��</td>
                                                        <td align="center"><input id="txtCOMM_CD_SHR" name="txtCOMM_CD_SHR" style="width 100%;" class="divInput" onKeypress="javascript:if(event.keyCode==13)fnc_SearchList()"></td>
                                                        <td align="left"></td>
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
                        <table width="350" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop15">
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
                        <table width="350" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr align="center">
                                            <td>
                                                <comment id="__NSID__">
                                                <object id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:350px;height:370px;">
                                                    <param name="DataID"                 value="dsT_CM_COMMON">
                                                    <param name="EdiTABLE"               value="false">
                                                    <param name="DragDropEnable"         value="true">
                                                    <param name="SortView"               value="Left">
                                                    <param name="VIEWSUMMARY"            value=0>
                                                    <param name="Format"                 value="
                                                        <C> id='CURROW'     width=50     name='����'                 align=center    value={CurRow} </C>
                                                        <C> id='COMM_CD'    width=80     name='�ڵ�'    sort=true    align=center                   </C>
                                                        <C> id='COMM_NM'    width=184    name='�ڵ��'  sort=true    align=left                     </C>
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

                    </td>
                </tr>
            </table>
            <!-- ���� ȭ�� ��-->
        </td>
        <td>
            <!-- ������ ȭ�� ����-->
            <table width="440" border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <!-- ���� �Է� ���̺� ���� -->
                        <table width="440" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                        <colgroup>
                                            <col width="90"></col>
                                            <col width="120"></col>
                                            <col width="90"></col>
                                            <col width=""></col>
                                        </colgroup>
                                        <tr>
                                            <td align="center" class="creamBold">���뱸���ڵ�</td>
                                            <td class="padding2423"><input id="txtCD_GBN" style="width:100%" maxlength="2"></td>
                                            <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
                                            <td class="padding2423"><input id="txtCOMM_CD" style="width:100%"  maxlength="5"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">�ڵ��1</td>
                                            <td class="padding2423"><input id="txtCOMM_NM" style="width:100%" maxlength="50"></td>
                                            <td align="center" class="creamBold">�ڵ��2</td>
                                            <td class="padding2423"><input id="txtCOMM_NM2" style="width:100%" maxlength="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">���ļ���</td>
                                            <td class="padding2423">
                                                <comment id="__NSID__"><object id="medSORT_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                                    <param name=Alignment            value=0>
                                                    <param name=Border               value=true>
                                                    <param name=ClipMode             value=true>
                                                    <param name=DisabledBackColor    value="#EEEEEE">
                                                    <param name=Enable               value=true>
                                                    <param name=IsComma              value=true>
                                                    <param name=Language             value=0>
                                                    <param name=MaxLength            value=3>
                                                    <param name=Numeric              value=true>
                                                    <param name=ShowLiteral          value="false">
                                                    <param name=Visible              value="true">
                                                </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                            </td>
                                            <td align="center" class="creamBold">�������</td>
                                            <td class="padding2423">
                                                <input id="txtEND_YMD" style="width:78%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','500','125');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">��Ÿ�׸�1</td>
                                            <td class="padding2423"><input id="txtEXT_01" style="width:100%" maxlength="50"></td>
                                            <td align="center" class="creamBold">��Ÿ�׸�2</td>
                                            <td class="padding2423"><input id="txtEXT_02" style="width:100%" maxlength="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">��Ÿ�׸�3</td>
                                            <td class="padding2423"><input id="txtEXT_03" style="width:100%" maxlength="50"></td>
                                            <td align="center" class="creamBold">��Ÿ�׸�4</td>
                                            <td class="padding2423"><input id="txtEXT_04" style="width:100%" maxlength="50"></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
                                            <td class="padding2423" colspan="3"><input id="txtOTH_DEC" style="width:100%" maxlength="100"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <!-- ���� �Է� ���̺� �� -->

                        <!-- ���� ��ȸ �׸��� ���̺� ����-->
                        <table width="440" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr align="center">
                                            <td>
                                                <comment id="__NSID__">
                                                <object id="grd01T_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:300px;">
                                                    <param name="DataID"                    value="ds01T_CM_COMMON">
                                                    <param name="EdiTABLE"                  value="false">
                                                    <param name="DragDropEnable"            value="true">
                                                    <param name="SortView"                  value="Left">
                                                    <param name="VIEWSUMMARY"               value=0>
                                                    <param name="Format"                    value="
                                                        <C> id='CURROW'     width=50        name='����'                     align=center    value={CurRow}  </C>
                                                        <C> id='COMM_CD'    width=80        name='�ڵ�'        sort=true    align=center                    </C>
                                                        <C> id='COMM_NM'    width=154       name='�ڵ��'      sort=true    align=left                      </C>
                                                        <C> id='END_YMD'    width=120       name='�������'    sort=true    align=center                    </C>
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

                    </td>
                </tr>
            </table>
            <!-- ������ ȭ�� ��-->
        </td>
    </tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(Bind Component)                                          *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                        |
    | 2. �̸� : bndT_CM_COMMON                      |
    | 3. Table List : T_CM_COMMON                   |
    +----------------------------------------------->
    <object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="ds01T_CM_COMMON">
        <Param Name="BindInfo", Value="
            <C>Col='CD_GBN'        Ctrl='txtCD_GBN'        Param=value        Disable=disabled</C>
            <C>Col='COMM_CD'       Ctrl='txtCOMM_CD'       Param=value        Disable=disabled</C>
            <C>Col='COMM_NM'       Ctrl='txtCOMM_NM'       Param=value        Disable=disabled</C>
            <C>Col='COMM_NM2'      Ctrl='txtCOMM_NM2'      Param=value        Disable=disabled</C>
            <C>Col='SORT_NO'       Ctrl='medSORT_NO'       Param=text         Disable=disabled/C>
            <C>Col='END_YMD'       Ctrl='txtEND_YMD'       Param=value        Disable=disabled</C>
            <C>Col='EXT_01'        Ctrl='txtEXT_01'        Param=value        Disable=disabled</C>
            <C>Col='EXT_02'        Ctrl='txtEXT_02'        Param=value        Disable=disabled</C>
            <C>Col='EXT_03'        Ctrl='txtEXT_03'        Param=value        Disable=disabled</C>
            <C>Col='EXT_04'        Ctrl='txtEXT_04'        Param=value        Disable=disabled</C>
            <C>Col='OTH_DEC'       Ctrl='txtOTH_DEC'       Param=value        Disable=disabled</C>
        ">
    </object>
