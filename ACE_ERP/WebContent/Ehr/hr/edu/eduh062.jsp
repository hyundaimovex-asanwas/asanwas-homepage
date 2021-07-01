<!--
    ************************************************************************************
    * @Source         : eduh062.jsp                                                    *
    * @Description    : �系���簭�ǽ������ PAGE                                      *
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
    <title>�系���簭�ǽ������(eduh062)</title>
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
    
        var btnList = 'FFTFFFFT';
        
        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_LCTRHIST.ClearData();
            
            dsT_ED_LCTRHIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh062.cmd.EDUH062CMD&S_MODE=SHR&CET_NO="+opener.cet_no;
            dsT_ED_LCTRHIST.Reset();
            
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

            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            dsT_ED_LCTRHIST.UseChangeInfo = false;
            
            trT_ED_LCTRHIST.KeyValue = "tr01(I:SAV=dsT_ED_LCTRHIST)";
            trT_ED_LCTRHIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh062.cmd.EDUH062CMD&S_MODE=SAV";
            trT_ED_LCTRHIST.post();
            
            dsT_ED_LCTRHIST.UseChangeInfo = true;
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
            if (form1.grdT_ED_LCTRHIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_ED_LCTRHIST.GridToExcel("�系���簭�ǽ������", '', 225);
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

            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_ED_LCTRHIST.ClearData();
            
            fnc_ColEnabled('D');

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
            
            if (!dsT_ED_LCTRHIST.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
            
            if ( dsT_ED_LCTRHIST.isUpdated) {
                for( i = 1; i <= dsT_ED_LCTRHIST.CountRow; i++ ) {
                    if( dsT_ED_LCTRHIST.RowStatus(i) == 1 || 
                        dsT_ED_LCTRHIST.RowStatus(i) == 3 ) {
                        /*
                        // ���Ǹ�
                        if (dsT_ED_LCTRHIST.NameValue(i, "LCT_TAG") == '') {
                            alert("���Ǹ��� �ʼ��Է��׸��Դϴ�.");
                            dsT_ED_LCTRHIST.RowPosition = i;
                            return false;
                        }
                        
                        // �����
                        
                        if (dsT_ED_LCTRHIST.NameValue(i, "LCT_AMT") == '' ||
                            dsT_ED_LCTRHIST.NameValue(i, "LCT_AMT") == 0) {
                            alert("������ �ʼ��Է��׸��Դϴ�.");
                            dsT_ED_LCTRHIST.RowPosition = i;
                            document.getElementById("medLCT_AMT").focus();
                            return false;
                        }*/
                        
                        // �̼�����
                        /*
                        if (dsT_ED_LCTRHIST.NameValue(i, "CPT_PNT") == '') {
                            alert("�̼������� �ʼ��Է��׸��Դϴ�.");
                            dsT_ED_LCTRHIST.RowPosition = i;
                            document.getElementById("txtCPT_PNT").focus();
                            return false;
                        }*/
                    }
                }
            }            

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var oOption = null;
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_ED_LCTRHIST,0,"false","false");
            
            // �������� ������ ��ȸ
            fnc_SearchList();
           
        }
        
        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_ED_LCTRHIST.IsUpdated)
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
        
        
        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                form1.medLCT_AMT.enable                            = true;
                document.getElementById("txtCPT_PNT").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;
                
            }
            else if (prop == 'D') {

                form1.medLCT_AMT.enable                            = false;
                document.getElementById("txtCPT_PNT").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;
                
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_LCTRHIST)|
    | 3. ���Ǵ� Table List(T_ED_LCTRHIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_LCTRHIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
   
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_LCTRHIST)|
    | 3. ���Ǵ� Table List(T_ED_LCTRHIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_LCTRHIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_LCTRHIST)">
    </Object>
    
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_LCTRHIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_LCTRHIST.CountRow );
            
            fnc_ColEnabled('E');
            
        }
            
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_LCTRHIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>
    
    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_LCTRHIST Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    
   
    <!-- Ʈ������ ����. -->
    <script for=trT_ED_LCTRHIST event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
        opener.fnc_SearchList();
        
    </script>
    
    <!--Ʈ������ ���� -->
    <script for=trT_ED_LCTRHIST event="OnFail()">
    
        cfErrorMsg(this);
        
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�系���簭�ǽ������</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>        
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <input type="hidden" id="txtSEQ_NO">
                    <input type="hidden" id="txtCET_NO">
                    <td align="center" class="creamBold">���籸��</td>
                    <td class="padding2423" >
                        <input id="txtLCT_CD" name="txtLCT_CD" style="width:20%"  class="input_ReadOnly"  readOnly> <input id="txtLCT_NM" name="txtLCT_NM" style="width:77%" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">���Ǻо�</td>
                    <td class="padding2423" >
                        <input id="txtLCT_Q5_GBN" name="txtLCT_Q5_GBN" style="width:20%"  class="input_ReadOnly"  readOnly> <input id="txtLCT_Q5_NM" name="txtLCT_Q5_NM" style="width:77%" class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtEDU_CD" name="txtEDU_CD" style="width:20%"  class="input_ReadOnly"  readOnly> <input id="txtEDU_NM" name="txtEDU_NM" style="width:77%" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtSEQ_NO"  name="txtSEQ_NO" style="width:100%"  class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" name="txtENO_NM" style="width:100%"  class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtLCT_TAG"  name="txtLCT_TAG" style="width:100%" maxlength="20" class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���ǽð�</td>
                    <td class="padding2423" >
                        <input id="txtLCT_TIME"  name="txtLCT_TIME" style="width:85%;ime-mode:disabled;text-align:right;"  class="input_ReadOnly"  readOnly> �ð�
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medLCT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  ��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtLCT_STR_YMD"  name="txtLCT_STR_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly"  readOnly> ~
                        <input id="txtLCT_END_YMD"  name="txtLCT_END_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">�̼�����</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="width:90%;ime-mode:disabled;text-align:right;" maxlength="1" onkeypress="cfCheckNumber();"> ��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">Ư�̻���</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtREMARK"  name="txtREMARK" cols="112" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_LCTRHIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
                            <param name="DataID"                  value="dsT_ED_LCTRHIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'           align=center </C>
                                <C> id='LCT_NM'       width=60    name='���籸��'       align=center </C>
                                <C> id='LCT_Q5_NM'    width=98    name='���Ǻо�'       align=center </C>
                                <C> id='EDU_NM'       width=120   name='������'         align=center </C>
                                <C> id='SEQ_NO'       width=60    name='����'           align=center </C>
                                <C> id='ENO_NM'       width=60    name='�����'         align=center </C>
                                <C> id='LCT_TAG'      width=120   name='���Ǹ�'         align=center </C>
                                <C> id='LCT_TERM'     width=160   name='��������'       align=center </C>
                                <C> id='LCT_TIME'     width=60    name='���ǽð�'       align=center </C>
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
<!-- �򰡴���ڼ��� ���̺� -->
<object id="bndT_ED_LCTRHIST"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_LCTRHIST">
    <Param Name="BindInfo", Value='
        <C>Col=LCT_CD       Ctrl=txtLCT_CD       Param=value </C>
        <C>Col=LCT_NM       Ctrl=txtLCT_NM       Param=value </C>
        <C>Col=LCT_Q5_GBN   Ctrl=txtLCT_Q5_GBN   Param=value </C>
        <C>Col=LCT_Q5_NM    Ctrl=txtLCT_Q5_NM    Param=value </C>
        <C>Col=EDU_CD       Ctrl=txtEDU_CD       Param=value </C>
        <C>Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=LCT_TAG      Ctrl=txtLCT_TAG      Param=value </C>
        <C>Col=LCT_TIME     Ctrl=txtLCT_TIME     Param=value </C>
        <C>Col=LCT_AMT      Ctrl=medLCT_AMT      Param=text  </C>
        <C>Col=LCT_STR_YMD  Ctrl=txtLCT_STR_YMD  Param=value </C>
        <C>Col=LCT_END_YMD  Ctrl=txtLCT_END_YMD  Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=REMARK       Ctrl=txtREMARK       Param=value </C>
        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=CET_NO       Ctrl=txtCET_NO       Param=value </C>
    '>                                         
</object>