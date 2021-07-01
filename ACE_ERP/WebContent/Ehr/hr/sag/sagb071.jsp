<!--
***********************************************************************
* @source      : sagb071.jsp
* @description : ������������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/09/08      ����ȣ        �����ۼ�.
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
    <head>
    <title>������������ȸ(sagb071)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
        //���缱 ����
        var ds_idx = 2;
        var ds_nxt = 2;
        var dataSet = window.dialogArguments;

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            
            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=common.empl.cmd.EMPLCMD&S_MODE=SHR"
                                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                                 + "&DPT_CD="+document.getElementById("txtDPT_CD_SHR").value
                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value
                                 ;
            dsT_CM_PERSON.reset();
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
            cfStyleGrid(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style ����
            
            //���� �̸� ������ ���� ds �ʱ�ȭ
            dsAPPROVER.setDataHeader("JOB_CD:STRING, JOB_NM:STRING, ENO_NO:STRING, ENO_NM:STRING");
            dsAPPROVER.AddRow();
            dsAPPROVER.AddRow();
            dsAPPROVER.AddRow();
            
            //�⺻���� ������ ����
            ds_idx = 2;
            fnc_CheckedElement("rdoIDX", ds_idx);
            
            document.getElementById("txtENO_NO").value      = "<%=box.get("SESSION_ENONO") %>";
            document.getElementById("hidGBN_CD").value      = "1";      //'' : ��ü, '1' : ��������, '2' : �İ߻��, '3' : ���»��
            document.getElementById("hidRET_CD").value      = "1";      //'' : ��ü, '1' : �����ڸ�, '2' : ����ڸ�, '3' : �Ի��ڸ�
            document.getElementById("hidSTR_YMD").value     = getToday().replace(/-/g, "");
            document.getElementById("hidEND_YMD").value     = getToday().replace(/-/g, "");
            
            //�ڱ������� ���� ����� ������ ��ȸ�� �´�.
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO", "", "", "3");
            if(enoObj.eno_no == "") {
                alert("��û�� ������ �����ϴ�.");
                window.close();
                return;
            }
            
            //�˻�����(�Ҽ�)����
            document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
            
            fnc_SearchList();
        }
        
        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }
        
        /**
         * �����ڸ� ������ �� Ȯ���� ������ ������������ �Ѿ
         * (�����ڰ� ������ ��û�ڰ� �����ڷ� �Ѿ)
         */
        function fnc_Confirm() {
            if(dsAPPROVER.NameValue(1, "ENO_NO") == ""
                    || dsAPPROVER.NameValue(ds_nxt, "ENO_NO") == "") {
                alert("������ ������, ����������(������) ������ ��� �����ϼž� �˴ϴ�.");       
                return;
            }

            var idx;
            if(ds_nxt == 2)
                idx = 2;
            else
                idx = 4;
                
                
            for(var i=1; i<=4; i++) {
                dataSet.NameString(i, "ENO_NO") = "";
                dataSet.NameString(i, "ENO_NM") = "";
                dataSet.NameString(i, "JOB_CD") = "";
                dataSet.NameString(i, "JOB_NM") = "";
                dataSet.NameString(i, "APP_YN_NM" ) = "";
            }
                        
        
            dataSet.NameString(1  , "ENO_NO") = dsAPPROVER.NameValue(1, "ENO_NO");
            dataSet.NameString(1  , "ENO_NM") = dsAPPROVER.NameValue(1, "ENO_NM");
            dataSet.NameString(1  , "JOB_CD") = dsAPPROVER.NameValue(1, "JOB_CD");
            dataSet.NameString(1  , "JOB_NM") = dsAPPROVER.NameValue(1, "JOB_NM");
            dataSet.NameString(1  , "APP_YN_NM" ) = "�̰�";
            
            dataSet.NameString(idx, "ENO_NO") = dsAPPROVER.NameValue(ds_nxt, "ENO_NO");
            dataSet.NameString(idx, "ENO_NM") = dsAPPROVER.NameValue(ds_nxt, "ENO_NM");
            dataSet.NameString(idx, "JOB_CD") = dsAPPROVER.NameValue(ds_nxt, "JOB_CD");
            dataSet.NameString(idx, "JOB_NM") = dsAPPROVER.NameValue(ds_nxt, "JOB_NM");
            dataSet.NameString(idx, "APP_YN_NM" ) = "�̰�";
        
        
            window.close();
        }
        
        /**
         * ������ ���� ������������ ���� ��
         */
        function fnc_ChkIdx() {
            if(!confirm("����������, ������ �� �ϳ��� ������ �����մϴ�.\n����Ͻðڽ��ϱ�?")) {
                fnc_CheckedElement("rdoIDX", ds_idx);
                return;
            }
            
            fnc_ClearDsRow(ds_idx);
            
            ds_nxt = fnc_GetCheckedValue("rdoIDX");
            ds_idx = fnc_GetCheckedValue("rdoIDX");
        }
        
        /**
         * �ش����� ������ ����
         */
        function fnc_ClearDsRow(row) {
            dsAPPROVER.NameString(row, "ENO_NO") = "";
            dsAPPROVER.NameString(row, "ENO_NM") = "";
            dsAPPROVER.NameString(row, "JOB_CD") = "";
            dsAPPROVER.NameString(row, "JOB_NM") = "";

            document.getElementById("lblJOB_NM_A"+row).innerText   = "";
            document.getElementById("lblENO_NO_A"+row).innerText   = "";
            document.getElementById("lblENO_NM_A"+row).innerText   = "";
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
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsAPPROVER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>
        dsAPPROVER.NameString(ds_idx, "ENO_NO") = dsT_CM_PERSON.NameValue(row, "ENO_NO");
        dsAPPROVER.NameString(ds_idx, "ENO_NM") = dsT_CM_PERSON.NameValue(row, "ENO_NM");
        dsAPPROVER.NameString(ds_idx, "JOB_CD") = dsT_CM_PERSON.NameValue(row, "JOB_CD");
        dsAPPROVER.NameString(ds_idx, "JOB_NM") = dsT_CM_PERSON.NameValue(row, "JOB_NM");

        //������ ���� �߰�
        document.getElementById("lblJOB_NM_A"+ds_idx).innerText   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        document.getElementById("lblENO_NO_A"+ds_idx).innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        document.getElementById("lblENO_NM_A"+ds_idx).innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        
        if(ds_idx == "1")
            ds_idx = ds_nxt;
        else
            ds_idx = "1";            
            
        fnc_CheckedElement("rdoIDX", ds_idx);
    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>
        dsAPPROVER.NameString(ds_idx, "ENO_NO") = dsT_CM_PERSON.NameValue(row, "ENO_NO");
        dsAPPROVER.NameString(ds_idx, "ENO_NM") = dsT_CM_PERSON.NameValue(row, "ENO_NM");
        dsAPPROVER.NameString(ds_idx, "JOB_CD") = dsT_CM_PERSON.NameValue(row, "JOB_CD");
        dsAPPROVER.NameString(ds_idx, "JOB_NM") = dsT_CM_PERSON.NameValue(row, "JOB_NM");

        //������ ���� �߰�
        document.getElementById("lblJOB_NM_A"+ds_idx).innerText   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        document.getElementById("lblENO_NO_A"+ds_idx).innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        document.getElementById("lblENO_NM_A"+ds_idx).innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        
        if(ds_idx == "1")
            ds_idx = ds_nxt;
        else
            ds_idx = "1";   
            
        fnc_CheckedElement("rdoIDX", ds_idx);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������ȸ</td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                                <tr>
                                    <td align="center" class="searchState">��� ��ȣ/����&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">
                                        
                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">
                                        
                                        <input type="hidden" id="txtENO_NO">
                                    </td>
                                    
                                    <td align="center" class="searchState">�Ҽ�&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:160px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           width=100  name=����   align=left   </C>
                                    <C> id=DPT_NM            width=90   name=�Ҽ�   align=left   </C>
                                    <C> id=JOB_NM            width=80   name=����   align=left   </C>
                                    <C> id=ENO_NO            width=80   name=���   align=center </C>
                                    <C> id=ENO_NM            width=80   name=����   align=center </C>
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
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="15"></col>
                        <col width="75"></col>
                        <col width="45"></col>
                        <col width="65"></col>
                        <col width="45"></col>
                        <col width="65"></col>
                        <col width="45"></col>
                        <col width="65"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold"><input type="radio" name="rdoIDX" value="3" onclick="fnc_ChkIdx()"></td>
                        <td align="center" class="creamBold">������</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblJOB_NM_A3"></td>
                        <td align="center" class="creamBold">���</td>
                        <td class="padding2423" id="lblENO_NO_A3"></td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblENO_NM_A3"></td>
                        <td class="padding2423">
                            <img src="/images/top/win_CloseOn.gif" name="Image54" width="16" height="14" border="0" onclick="fnc_ClearDsRow('3')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image54','','/images/top/win_CloseOver.gif',1)" style="cursor:hand;">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold"><input type="radio" name="rdoIDX" value="2" onclick="fnc_ChkIdx()"></td>
                        <td align="center" class="creamBold">����������</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="creamBold">���</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                        <td class="padding2423">
                            <img src="/images/top/win_CloseOn.gif" name="Image55" width="16" height="14" border="0" onclick="fnc_ClearDsRow('2')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image55','','/images/top/win_CloseOver.gif',1)" style="cursor:hand;">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold"><input type="radio" name="rdoIDX" value="1" onclick="fnc_ChkIdx()"></td>
                        <td align="center" class="creamBold">������</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblJOB_NM_A1"></td>
                        <td align="center" class="creamBold">���</td>
                        <td class="padding2423" id="lblENO_NO_A1"></td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" id="lblENO_NM_A1"></td>
                        <td class="padding2423">
                            <img src="/images/top/win_CloseOn.gif" name="Image56" width="16" height="14" border="0" onclick="fnc_ClearDsRow('1')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image56','','/images/top/win_CloseOver.gif',1)" style="cursor:hand;">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->
    
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