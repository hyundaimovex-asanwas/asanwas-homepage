<!--
    ************************************************************************************
    * @Source         : edue010.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/14  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");
    
    boolean isMaster = false;
    boolean isSubMaster = false;
    
    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>

    <head>
    <title>��������(edue010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
    
        var btnList = 'TTFTFFFT';
        
        var bbs_gbn = "3"              // �Խ��Ǳ��� : �������� 
        var maxNum  = 0;               // ù�������� ���� ū ����
        var recNum  = 12;              // ���������� �������� ��ϼ�
        var pagNum  = 0;               // ������
        var vGbn    = '';              // �˻����� (1: ����, 2: ����, 3: �ۼ���)
        var vText   = '';              // �˻����� ����
        var strRec  = 1;               // ���� REC
        var endRec  = 0;               // ���� REC
        
        var gbn     = '';
        var title   = '';
        var seq_no  = '';
        var ref_no  = '';
        var step_no = '';
        var dept_no = '';
        var eno_no  = '';
        var eno_nm  = '';
        

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var GBN     = document.getElementById("cmbGBN_SHR").value;
            var TEXT    = document.getElementById("txtTEXT_SHR").value;
            
            dsT_ED_BOARD.ClearData();
            
            if (endRec == 0) {
                endRec = recNum;
            }
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue010.cmd.EDUE010CMD&S_MODE=SHR&BBS_GBN="+bbs_gbn+"&GBN="+GBN+"&TEXT="+TEXT+"&STRREC="+strRec+"&ENDREC="+endRec;
            dsT_ED_BOARD.Reset();
            
            form1.grdT_ED_BOARD.Focus();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            var obj = new String();
            
            maxNum  = 0;                      // ù�������� ���� ū ����
            pagNum  = 0;                      // ������
            vGbn    = '';                     // �˻����� (1: ����, 2: ����, 3: �ۼ���)
            vText   = '';                     // �˻����� ����
            strRec  = 1;                      // ���� REC
            endRec  = 0;                      // ���� REC

            gbn     = "1";                // 1: ���, 2: ����, 3: �亯
            title   = "���";
            seq_no  = "";
            ref_no  = "";
            step_no = "0";
            dept_no = "0";
            eno_no  = '<%=box.get("SESSION_ENONO")%>';
            eno_nm  = '<%=box.get("SESSION_ENONM")%>';

            window.showModalDialog("/hr/edu/edue011.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            maxNum  = 0;                      // ù�������� ���� ū ����
            pagNum  = 0;                      // ������
            vGbn    = '';                     // �˻����� (1: ����, 2: ����, 3: �ۼ���)
            vText   = '';                     // �˻����� ����
            strRec  = 1;                      // ���� REC
            endRec  = 0;                      // ���� REC
            
            document.getElementById("cmbGBN_SHR").value  = '1';
            document.getElementById("txtTEXT_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            fnc_SearchList();
            
            document.getElementById("cmbGBN_SHR").focus();

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
            cfStyleGrid(form1.grdT_ED_BOARD,0,"false","false");
            
<%
    if(!isMaster) {
%>
            fnc_HiddenElement("imgAddnew");
<%
    }
%>        
                      
            fnc_SearchList();
            
            document.getElementById("cmbGBN_SHR").focus();
            
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
         
        function fnc_Next() {

            pagNum = pagNum + 1;
            
            strRec = (pagNum * recNum) + 1;
            endRec = (pagNum + 1) * recNum;
            
            dsT_ED_BOARD.ClearData();            
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue010.cmd.EDUE010CMD&S_MODE=SHR&BBS_GBN="+bbs_gbn+"&GBN="+vGbn+"&TEXT="+vText+"&STRREC="+strRec+"&ENDREC="+endRec;
            dsT_ED_BOARD.Reset();
            
            form1.grdT_ED_BOARD.Focus();
        }
        
        function fnc_Prev() {

            pagNum = pagNum - 1;
            
            strRec = (pagNum * recNum) + 1;
            endRec = (pagNum + 1) * recNum;
            
            dsT_ED_BOARD.ClearData();            
            
            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue010.cmd.EDUE010CMD&S_MODE=SHR&BBS_GBN="+bbs_gbn+"&GBN="+vGbn+"&TEXT="+vText+"&STRREC="+strRec+"&ENDREC="+endRec;
            dsT_ED_BOARD.Reset();
            
            form1.grdT_ED_BOARD.Focus();
            
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_BOARD)    |
    | 3. ���Ǵ� Table List(T_ED_BOARD)           |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    
    <Script For=grdT_ED_BOARD Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: ���, 2: ����, 3: �亯
        bbs_gbn = dsT_ED_BOARD.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/edu/edue012.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        
    </Script>
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            // ���� ��ư�� ������ ����.
            document.getElementById("view_1").style.display='none';
            document.getElementById("view_2").style.display='none'; 

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_BOARD.CountRow );
            
            if (pagNum == 0) {
                maxNum = dsT_ED_BOARD.NameValue(1, "NUM");
                
                vGbn  = document.getElementById("cmbGBN_SHR").value;
                vText = document.getElementById("txtTEXT_SHR").value;

            }

            if (maxNum == dsT_ED_BOARD.NameValue(1, "NUM")) {
                // ���� ��ư�� ������ ����.
                document.getElementById("view_1").style.display='none';
            }
            else {
                // ���� ��ư�� ����
                document.getElementById("view_1").style.display='inline';
            }
            
            if (dsT_ED_BOARD.NameValue(dsT_ED_BOARD.CountRow, "NUM") > 1) {
                // ���� ��ư�� ����
                document.getElementById("view_2").style.display='inline';
                
            }
            else {
                // ���� ��ư�� ������ ����
                document.getElementById("view_2").style.display='none';
            }
            
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD Event="OnDataError()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������</td>
                    <td align="right" class="navigator">HOME/��������/�����ȳ���û/<font color="#000000">��������</font></td>
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
            <img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)" style="cursor:hand;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="searchState" align="left">
                                    <select id=cmbGBN_SHR>
                                        <option value="1">����</option>
                                        <option value="2">����</option>
                                        <option value="3">�ۼ���</option>
                                    </select>
                                    <input id="txtTEXT_SHR" name="txtTEXT_SHR" size="50">
                                    <input type=hidden id="txtEDU_AUTHO_SHR" name="txtEDU_AUTHO_SHR">
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_BOARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:298px;">
                            <param name="DataID"                  value="dsT_ED_BOARD">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='ROWNM'        width=40    name='����'           align=center </C>
                                <C> id='SUBJECT_TAG'  width=390   name='����'           align=left   </C>
                                <C> id='ENO_NM'       width=70    name='�����'         align=center </C>
                                <C> id='DPT_NM'       width=85    name='�μ�'     align=center </C>
                                <C> id='JOB_NM'       width=70    name='����'     align=center </C>
                                <C> id='FILE_YN'      width=55    name='÷�ι���'       align=center </C>
                                <C> id='UPT_YMD'      width=70    name='�������'       align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="right" class="paddingTop5">
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <input type=button id="btnPIRA024" value="�� ��"  style="width:57pt;" onclick="fnc_Prev();">
            </div>
            <div id="view_2" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <input type=button id="btnPIRA025" value="�� ��"  style="width:57pt;" onclick="fnc_Next();">
            </div>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>