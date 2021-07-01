<!--
    ************************************************************************************
    * @Source         : edug030.jsp                                                    *
    * @Description    : OJT ����                                                                      *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2017/04/04      �̵���        �����ۼ�
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>OJT���</title>
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

        var gbn      = '';
        var eno_no   = '';
        var tra_week   = '';
        var tra_ymd = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	
            var MNT_GBN  = document.getElementById("cmbMNT_GBN").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;


            dsT_CD_OJTPLAN.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD"
																						                                + "&S_MODE=SHR"
																						                                + "&MNT_GBN="+MNT_GBN
																						                                + "&ENO_NO="+ENO_NO;
            dsT_CD_OJTPLAN.Reset();

            form1.grdT_CD_OJTPLAN.Focus();
            
        }

        function fnc_SearchList2() {

            dsT_CD_OJTREPORT.ClearData();

            dsT_CD_OJTREPORT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SHR_01&ENO_NO="+eno_no+"&TRA_WEEK="+tra_week;
            
            dsT_CD_OJTREPORT.Reset();
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

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CD_OJTREPORT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var today = getToday().replace("-","").replace("-","");
            var STR_YMD = dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition, "STR_YMD").replace("-","").replace("-","");
        	var END_YMD = dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition, "END_YMD").replace("-","").replace("-","");

        	if (STR_YMD > today || END_YMD < today) {
        		alert("���丵 �Ⱓ�������� ������ �����մϴ�.");
        		return;
        	}


            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("����� [" + dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition,"ENO_NM") + "] �ۼ����� [" + dsT_CD_OJTREPORT.NameValue(dsT_CD_OJTREPORT.RowPosition,"TRA_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CD_OJTREPORT.DeleteRow(dsT_CD_OJTREPORT.RowPosition);

            trT_CD_OJTREPORT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=DEL";
            trT_CD_OJTREPORT.post();

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

            gbn      = "1";        // 1: �ű�, 2: ����
            eno_no   = dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition, "ENO_NO");
            tra_week   = dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition, "PLAN_TRA_WEEK");
            tra_ymd = getToday();

            if (eno_no == "" && tra_week == "") {
                alert("OJT����� ����� ��ȸ�Ͽ� �ش� ���� �� ���� �����ϼż� �ǹ����������� �ۼ��Ͻʽÿ�");
                return;
            }

            window.showModalDialog("../../../Ehr/hr/edu/edug031.jsp", self, "dialogHeight:700px; dialogWidth:850px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            dsT_CD_OJTPLAN.ClearData();
            dsT_CD_OJTREPORT.ClearData();

            document.getElementById("txtENO_NO_SHR").focus();

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
            cfStyleGrid_New(form1.grdT_CD_OJTPLAN,0,"false","false");
            cfStyleGrid_New(form1.grdT_CD_OJTREPORT,0,"false","false");

            
            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

        	//�������� ��� �⵵, ��� �˻� Ȱ��ȭ
        	if(gusrid == "6060002" || gusrid == "2070020"){             
            
                fnc_ChangeStateElement(true, "txtENO_NO_SHR");
                fnc_ChangeStateElement(true, "txtENO_NM_SHR");
                fnc_ChangeStateElement(true, "ImgEnoNoShr");
                fnc_ChangeStateElement(true, "cmbMNT_GBN");
                document.getElementById("cmbMNT_GBN").value = "";     

        	}else if(gusrid == "2170006" || gusrid == "2170007" || gusrid == "2170008" || gusrid == "2170009" || gusrid == "2170012"){
        		
                fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                fnc_ChangeStateElement(false, "ImgEnoNoShr");
                fnc_ChangeStateElement(false, "cmbMNT_GBN");
                document.getElementById("cmbMNT_GBN").value = "P";        		
        		

        	}else if(gusrid == "2040024" || gusrid == "2070027" || gusrid == "2120008" || gusrid == "2130021"){
            
                fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                fnc_ChangeStateElement(false, "ImgEnoNoShr");
                fnc_ChangeStateElement(false, "cmbMNT_GBN");
                document.getElementById("cmbMNT_GBN").value = "M";             		
        		
        	}

            fnc_SearchList();
            
        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJTPLAN.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

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



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTO)     |
    | 3. ���Ǵ� Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                      |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTORESULT)|
    | 3. ���Ǵ� Table List(T_CD_MENTORESULT)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTREPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CD_MENTO                        |
    | 3. Table List : T_CD_MENTO                    |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJTREPORT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_CD_OJTREPORT)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_CD_OJTPLAN Event="OnClick(row, col)">

        eno_no   = dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition, "ENO_NO");
        tra_week   = dsT_CD_OJTPLAN.NameValue(dsT_CD_OJTPLAN.RowPosition, "PLAN_TRA_WEEK");
        tra_ymd = "";

        fnc_SearchList2();

    </Script>

    <Script For=grdT_CD_OJTPLAN Event="OnDblClick(row, col)">

        //eno_no   = dsT_CD_OJTPLAN.NameValue(row, "ENO_NO");
        //tra_week = dsT_CD_OJTPLAN.NameValue(row, "PLAN_TRA_WEEK");
        //window.showModalDialog("../../../Ehr/hr/edu/edug031.jsp", self, "dialogHeight:700px; dialogWidth:850px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>
    
    <Script For=grdT_CD_OJTREPORT Event="OnDblClick(row, col)">

        gbn      = "2";             // ����
        eno_no   = dsT_CD_OJTREPORT.NameValue(row, "ENO_NO");
        tra_week = dsT_CD_OJTREPORT.NameValue(row, "TRA_WEEK");
        tra_ymd  = dsT_CD_OJTREPORT.NameValue(row, "TRA_YMD").replace("-","");
        status    = dsT_CD_OJTREPORT.NameValue(row, "STATUS");
        
        if (document.getElementById("cmbMNT_GBN").value == 'P')    {
       	 	window.showModalDialog("../../../Ehr/hr/edu/edug031.jsp", self, "dialogHeight:700px; dialogWidth:850px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        }else{
       	 	window.showModalDialog("../../../Ehr/hr/edu/edug032.jsp", self, "dialogHeight:700px; dialogWidth:850px; help:No; resizable:No; status:No; scroll:No; center:Yes;");        	
        }
        
        fnc_SearchList();
        
    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJTPLAN.CountRow );

            eno_no   = dsT_CD_OJTPLAN.NameValue(1, "ENO_NO");
            tra_week   = dsT_CD_OJTPLAN.NameValue(1, "PLAN_TRA_WEEK");
            tra_ymd = "";

            fnc_SearchList2();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTPLAN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTPLAN Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTREPORT Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTREPORT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTREPORT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_CD_OJTREPORT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CD_OJTREPORT event="OnFail()">

        cfErrorMsg(this);
        
        flag = '';

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">

                            <colgroup>
                                <col width="90"></col>
                                <col width="100"></col>
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>

                            <tr>

                                <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbMNT_GBN">
                                        <option value="">��ü</option>
                                        <option value="P">���Ի��</option>
                                        <option value="M">å���������</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState" width="70">�����ȣ&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

<!-- ��ȸ ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="120"></col>
                    <col width="150"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                    <col width="100"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�����</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="8"  maxlength="8"  class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="12" maxlength="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">å���������</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="8"  class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="left" width="800">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_OJTPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:750px;height:500px;">
                            <param name="DataID"                  value="dsT_CD_OJTPLAN">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='���Ի��' HeadBgColor='#dae0ee'
                                    <C> id='ENO_NO'          width=70    name='���'       align=center  Gte_ColumnType='Number:0:False' Suppress=1  show=false</C>
                                    <C> id='ENO_NM'          width=70    name='����'       align=center  Suppress=1</C>
                                    <C> id='DPT_NM'          width=90    name='�Ҽ�'       align=left    Suppress=1 show=false</C>
                                    <C> id='JOB_NM'          width=60    name='����'       align=center  Suppress=1 show=false</C>
                                    <C> id='HIR_YMD'        width=70    name='�Ի���'     align=center  Suppress=1</C>
                                </G>
                                <C> id='TRA_DPT_NM'            width=90    name='OJT�μ�'       align=center  Suppress=1  show=false</C>
                                <G> name='å���������' HeadBgColor='#dae0ee'
                                    <C> id='TRA_ENO_NO'         width=70    name='���'       align=center Gte_ColumnType='Number:0:False'  Suppress=1  show=false</C>
                                    <C> id='TRA_ENO_NM'         width=70    name='����'       align=center  Suppress=1 show=false</C>
                                    <C> id='MDPT_NM'         width=90    name='�Ҽ�'       align=left    Suppress=1 show=false</C>
                                    <C> id='MJOB_NM'         width=60    name='����'       align=center  Suppress=1 show=false</C>
                                </G>
                                <G> name='OJT�Ⱓ' HeadBgColor='#dae0ee'
                                    <C> id='STR_YMD'         width=70    name='��������'   align=center  Suppress=1 show=false</C>
                                    <C> id='END_YMD'         width=70    name='��������'   align=center  Suppress=1 show=false</C>
                                </G>
                                <G> name='��������' HeadBgColor='#dae0ee'
	                                <C> id='PLAN_TRA_WEEK'     width=40    name='����'         align=center edit='none'</C>
	                                <C> id='PLAN_STR_YMD'     width=80   name='������'         align=center edit='none'</C>
	                                <C> id='PLAN_END_YMD'     width=80   name='������'         align=center edit='none'</C>
	                            </G>
	                                <C> id='PLAN_TRA_ENO_NM'     width=70   name='�������'         align=center edit='none' show=false</C>
	                                <C> id='PLAN_TRA_SUBITEM'     width=390   name='�����׸�'         align=left   EditLimit=2000 edit='none'</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td width="10">
                        &nbsp;
                    </td>
                    <td align="right" width="190">
                        <comment id="__NSID__">
                        <object    id="grdT_CD_OJTREPORT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:240px;height:500px;">
                            <param name="DataID"                  value="dsT_CD_OJTREPORT">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='TRA_YMD'     width=150    name='OJT����'   align=center mask='XXXX-XX-XX' </C>
                                <C> id='STATUS'        width=88     name='����'       align=center </C>                                
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
<!-- ���뺸�� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJTPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=TRA_ENO_NO    Ctrl=txtTRA_ENO_NO    Param=value </C>
        <C> Col=TRA_ENO_NM    Ctrl=txtTRA_ENO_NM    Param=value </C>
        <C> Col=MDPT_CD       Ctrl=txtMDPT_CD       Param=value </C>
        <C> Col=MDPT_NM       Ctrl=txtMDPT_NM       Param=value </C>
        <C> Col=MJOB_CD       Ctrl=txtMJOB_CD       Param=value </C>
        <C> Col=MJOB_NM       Ctrl=txtMJOB_NM       Param=value </C>
        <C> Col=TRA_DPT_CD    Ctrl=txtTRA_DPT_CD    Param=value </C>
        <C> Col=TRA_DPT_NM    Ctrl=txtTRA_DPT_NM    Param=value </C>
        <C> Col=HIR_YMD       Ctrl=txtHIR_YMD       Param=value </C>
        <C> Col=TRA_DUTY      Ctrl=txtTRA_DUTY      Param=value </C>
        <C> Col=HEAD_EMP_NO   Ctrl=txtHEAD_EMP_NO   Param=value </C>
        <C> Col=HEAD_EMP_NM   Ctrl=txtHEAD_EMP_NM   Param=value </C>
        <C> Col=EDU_GOAL1     Ctrl=txtEDU_GOAL1     Param=value </C>
        <C> Col=EDU_GOAL2     Ctrl=txtEDU_GOAL2     Param=value </C>
        <C> Col=EDU_GOAL3     Ctrl=txtEDU_GOAL3     Param=value </C>
    '>
</object>