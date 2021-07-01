<!--
    ************************************************************************************
    * @Source         : pira011.jsp                                                    *
    * @Description    : ���Ի�� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�									 *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>���Ի��(pira011)</title>
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
    
        var retObj = window.dialogArguments;

        retObj.reg_no  = '';
        retObj.jumin1  = '';
        retObj.jumin2  = '';
        retObj.eno_nm  = '';
        retObj.nam_eng = '';
        retObj.nam_chi = '';
        retObj.sexgu   = '';
        retObj.birymd  = '';
        retObj.birtag  = '';
    
		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
        var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var REGYY  = document.getElementById("txtREGYY_SHR").value;
            var REGCH  = document.getElementById("txtREGCH_SHR").value;
            
            if (REGYY == "") {
                alert("�⵵�� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtREGYY_SHR").focus();
                return;
            }
            
            if (REGCH == "") {
                alert("������ �ʼ��Է��׸��Դϴ�.");
                document.getElementById("txtREGCH_SHR").focus();
                return;
            }

            dsT_RC_MASTER.ClearData();
            
            dsT_RC_MASTER.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira011.cmd.PIRA011CMD&S_MODE=SHR&REGYY="+REGYY+"&REGCH="+REGCH;
            dsT_RC_MASTER.Reset();
            
            form1.grdT_RC_MASTER.Focus();
            
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
            var CountRow = 0;
            
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            document.getElementById("txtREGYY_SHR").value = '';
            document.getElementById("txtREGCH_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_RC_MASTER.ClearData();
            
            document.getElementById("txtREGYY_SHR").focus();

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
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_RC_MASTER,0,"false","false");
            
            // �׸��忡 ���κ������򰡴���ڼ��� ������ ��ȸ
            //fnc_SearchList();
                        
            document.getElementById("txtREGYY_SHR").focus();
        }
        
        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_RC_MASTER.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }
            
            window.close();
        }
        
        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_RC_MASTER)    |
    | 3. ���Ǵ� Table List(T_RC_MASTER)           |
    +----------------------------------------------->
    <Object ID="dsT_RC_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_RC_MASTER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_RC_MASTER.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_RC_MASTER Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_MASTER Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_RC_MASTER event=OnDblClick(row,colid)>

        var retObj = window.dialogArguments;

        retObj.reg_no  = dsT_RC_MASTER.NameValue(row,'REG_NO');
        retObj.jumin1  = dsT_RC_MASTER.NameValue(row,'JUMIN1');
        retObj.jumin2  = dsT_RC_MASTER.NameValue(row,'JUMIN2');
        retObj.eno_nm  = dsT_RC_MASTER.NameValue(row,'ENO_NM');
        retObj.nam_eng = dsT_RC_MASTER.NameValue(row,'NAM_ENG');
        retObj.nam_chi = dsT_RC_MASTER.NameValue(row,'NAM_CHI');
        retObj.sexgu   = dsT_RC_MASTER.NameValue(row,'SEXGU');
        retObj.birymd  = dsT_RC_MASTER.NameValue(row,'BIRYMD');
        retObj.birtag  = dsT_RC_MASTER.NameValue(row,'BIRTAG');
        
        window.close();

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ� |
    +-------------------------------->
    <script language=JavaScript for=grdT_RC_MASTER event=OnReturn(row,colid)>

        var retObj = window.dialogArguments;

        retObj.reg_no  = dsT_RC_MASTER.NameValue(row,'REG_NO');
        retObj.jumin1  = dsT_RC_MASTER.NameValue(row,'JUMIN1');
        retObj.jumin2  = dsT_RC_MASTER.NameValue(row,'JUMIN2');
        retObj.eno_nm  = dsT_RC_MASTER.NameValue(row,'ENO_NM');
        retObj.nam_eng = dsT_RC_MASTER.NameValue(row,'NAM_ENG');
        retObj.nam_chi = dsT_RC_MASTER.NameValue(row,'NAM_CHI');
        retObj.sexgu   = dsT_RC_MASTER.NameValue(row,'SEXGU');
        retObj.birymd  = dsT_RC_MASTER.NameValue(row,'BIRYMD');
        retObj.birtag  = dsT_RC_MASTER.NameValue(row,'BIRTAG');
        
        window.close();

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
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���Ի��</td>
                    <td align="right" class="navigator">HOME/�λ���/�򰡱�������/<font color="#000000">���Ի��</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="40"></col>
                                <col width="50"></col>
                                <col width="40"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�⵵ </td>
                                <td class="padding2423">
                                    <input name=txtREGYY_SHR size="4"  maxlength="4" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
                                </td>
                                <td align="right" class="searchState">���� </td>
                                <td class="padding2423">
                                    <input name=txtREGCH_SHR size="4"  maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
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
<table width="400" border="0" cellspacing="0" cellpadding="0">
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
<table width="400" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_RC_MASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:250px;">
                            <param name="DataID"                  value="dsT_RC_MASTER">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'         align=center </C>
                                <C> id='REG_NO'       width=100   name='�����ȣ'     align=center </C>
                                <C> id='ENO_NM'       width=80    name='����'         align=left   </C>
                                <C> id='FIN_DPT_NM'   width=90    name='��ġ�μ�'     align=left   </C>
                                <C> id='SPLIT_NM'     width=70    name='����'         align=center </C>
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

<!-- ��ȸ ���� ���̺� ���� -->
    <table width="400" border="0" cellspacing="0" cellpadding="0">
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