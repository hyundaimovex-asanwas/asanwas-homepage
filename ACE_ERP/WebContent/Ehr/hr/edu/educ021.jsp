<!--
    ************************************************************************************
    * @Source         : educ021.jsp                                                    *
    * @Description    : �����������̷� PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  ���м�   | �����ۼ�                                               *
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
    <title>���������������̷�(educ021)</title>
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

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'T' + 'F' + 'T';

        var edu_cd      = '';
        var edu_nm      = '';
        var seq_no      = '';
        var eno_no      = '';
        var str_ymd     = '';
        var edu_autho   = '';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//�н��� ���

			fnc_DutyCheck();
			var JIKMU_CD = document.getElementById("txtJIKMU_CD_SHR").value;//�⵵

            if(JIKMU_CD == ""){
        		alert("�ش�⵵�� �Է��ϼ���.");
                document.getElementById("txtJIKMU_CD_SHR").focus();
                return false;
        	}

        	if(ENO_NO == ""){
        		alert("����� �Է��ϼ���.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("����� �߸��Ǿ����ϴ�.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}


        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_EDUCATION_01=dsT_CM_EDUCATION_01, "+
        	                                "O:dsT_CM_EDUCATION_02=dsT_CM_EDUCATION_02, "+
        	                                "O:dsT_ED_LCTRHIST_03=dsT_ED_LCTRHIST_03, "+
        	                                "O:dsT_CM_EDUCATION_04=dsT_CM_EDUCATION_04, "+
        	                                "O:dsT_ED_EXCEPTER_05=dsT_ED_EXCEPTER_05)";
			trT_CM_EDUCATION.Action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ021.cmd.EDUC021CMD&S_MODE=SHR&JIKMU_CD="+JIKMU_CD+"&ENO_NO="+ENO_NO;
			trT_CM_EDUCATION.Post();

			fnc_SaveResult();

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

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        	var JIKMU_CD = document.getElementById("txtJIKMU_CD_SHR").value;//�⵵
        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//�н��� ���

        	if(ENO_NO == ""){
        		alert("����� �Է��ϼ���.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("����� �߸��Ǿ����ϴ�.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

            var url = "educ021_PV.jsp?eno_no="+ENO_NO+"&str_ymd="+JIKMU_CD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CM_EDUCATION_01.CountRow < 1 &&
                dsT_CM_EDUCATION_02.CountRow < 1 &&
                dsT_ED_LCTRHIST_03.CountRow < 1 &&
                dsT_CM_EDUCATION_04.CountRow < 1 &&
                dsT_ED_EXCEPTER_05.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }


/*          if(dsT_ED_EXCEPTER_05.CountRow > 0){
		      form1.grdT_ED_EXCEPTER_05.GridToExcel("�������̷�", '', 225);
            }
            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.RunExcelSheetEx("��ܱ����̷�", 1, 0);
            }
            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.RunExcelSheetEx("�系�����̷�", 1, 0);
            }
            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.RunExcelSheetEx("�系�����̷�", 1, 0);
            }
            if(dsT_CM_EDUCATION_01.CountRow > 0){
                form1.grdT_CM_EDUCATION_01.RunExcelSheetEx("����������Ȳ", 1, 0);
            }                         */



            if(dsT_CM_DUTYMST.CountRow > 0){
               // form1.grdT_CM_EDUCATION_01.GridToExcel("����������Ȳ", "C:\\educ021.xls", 1+4);
                form1.grdT_CM_EDUCATION_01.SaveExcel("����������Ȳ", true, true, false, "C:\\educ021.xls");
            }
            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.GridToExcel("���뱳���̷�", "C:\\educ021.xls", 1+32);
            }
            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.GridToExcel("���������̷�", "C:\\educ021.xls", 1+32);
            }
            if(dsT_ED_EXCEPTER_05.CountRow > 0){
                form1.grdT_ED_EXCEPTER_05.GridToExcel("��Ÿ�����̷�"  ,  "C:\\educ021.xls", 1+32);
            }
            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.GridToExcel("�系�����̷�",  "C:\\educ021.xls", 1+32);
            }


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

            dsT_CM_EDUCATION_01.ClearData();
            dsT_CM_EDUCATION_02.ClearData();
            dsT_ED_LCTRHIST_03.ClearData();
            dsT_CM_EDUCATION_04.ClearData();
            dsT_ED_EXCEPTER_05.ClearData();



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
        function fnc_SaveResult() {

			// ���ǽð� ���
			dsT_CM_DUTYMST.NameValue(1, "LCT_TIME") = 0;
			for (var i = 1; i <= dsT_ED_LCTRHIST_03.CountRow; i++) {

			    dsT_CM_DUTYMST.NameValue(1, "LCT_TIME") = dsT_CM_DUTYMST.NameValue(1, "LCT_TIME") + dsT_ED_LCTRHIST_03.NameValue(i, "LCT_TIME");
			}
			// ���뿪�� ���� �Ǽ� ���
			dsT_CM_DUTYMST.NameValue(1, "COM_FNSH") = dsT_CM_EDUCATION_02.CountRow;

			// ���뿪�� ���� ��� ���
			dsT_CM_DUTYMST.NameValue(1, "COM_AVG") = 0;
			for (var i = 1; i <= dsT_CM_EDUCATION_02.CountRow; i++) {

			    dsT_CM_DUTYMST.NameValue(1, "COM_AVG") = dsT_CM_DUTYMST.NameValue(1, "COM_AVG") + dsT_CM_EDUCATION_02.NameValue(i, "APP_VAL");
			}
            if (dsT_CM_EDUCATION_02.CountRow != 0) {
               dsT_CM_DUTYMST.NameValue(1, "COM_AVG") = dsT_CM_DUTYMST.NameValue(1, "COM_AVG") / dsT_CM_EDUCATION_02.CountRow;
            }

			// �������� ���� �Ǽ� ���
			dsT_CM_DUTYMST.NameValue(1, "JOB_FNSH") = dsT_CM_EDUCATION_01.CountRow;

			// �������� ���� ��� ���
			dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") = 0;
			for (var i = 1; i <= dsT_CM_EDUCATION_01.CountRow; i++) {

			    dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") = dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") + dsT_CM_EDUCATION_01.NameValue(i, "APP_VAL");
			}
            if (dsT_CM_EDUCATION_02.CountRow != 0) {
               dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") = dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") / dsT_CM_EDUCATION_01.CountRow;
            }

			// ��Ÿ���� �Ǽ� ���
			dsT_CM_DUTYMST.NameValue(1, "ETC_CNT") = dsT_ED_EXCEPTER_05.CountRow;


        }
        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_DutyCheck() {
            var ENO_NO    = document.getElementById("txtENO_NO_SHR").value;

        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_DUTYMST=dsT_CM_DUTYMST)";
			trT_CM_EDUCATION.Action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ021.cmd.EDUC021CMD&S_MODE=SHR_00&&ENO_NO="+ENO_NO;
			trT_CM_EDUCATION.Post();
        }
        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

   			cfStyleGrid(form1.grdT_CM_EDUCATION_01,0,"false","false");      // Grid Style ����
			form1.grdT_CM_EDUCATION_01.HiddenHScroll  = true;
			form1.grdT_CM_EDUCATION_01.HiddenVScroll  = true;
			form1.grdT_CM_EDUCATION_01.DisableNoHScroll = false;
			form1.grdT_CM_EDUCATION_01.DisableNoVScroll = false;

			cfStyleGrid(form1.grdT_CM_EDUCATION_02,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_ED_LCTRHIST_03,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_CM_EDUCATION_04,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_ED_EXCEPTER_05,0,"false","false");      // Grid Style ����



            if (opener != null){
                document.getElementById("txtENO_NO_SHR").value = opener.eno_no;
                document.getElementById("txtENO_NM_SHR").value = opener.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
                document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            }
<%
    //�����ڰ� �ƴϸ� �ٸ� ������� ��ȸ�� ���� �ʰ�
    if(!isMaster && !isSubMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
<%
    }
    //�ҼӺμ�������̰ų� �Ϲݻ������ ��� �ڽ��� �μ������� �˻��� ����
    if(!isMaster) {
%>
            document.getElementById("hidEMPL_DPT_CD").value = "<%=box.get("SESSION_DPTCD") %>";
<%
    }
%>
        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

           if (opener != null){

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


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EMPLIST)   |
    | 3. ���Ǵ� Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->

	<Object ID="dsT_CM_EDUCATION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_LCTRHIST_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_EXCEPTER_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">


	    if (iCount == 0)    {

            alert("�Ի��� ��� - �����ڵ� ���� �� �۾��ٶ��ϴ�.");

        } else {

            document.getElementById("txtJIKMU_CD_SHR").value = dsT_CM_DUTYMST.NameValue(1, "JIKMU_CD");
            document.getElementById("txtJIKMU_NM").value     = dsT_CM_DUTYMST.NameValue(1, "DUTY_NM");
            document.getElementById("txtJIKMU_NM_UP").value  = dsT_CM_DUTYMST.NameValue(1, "UP_DUTY_NM");

        }
    </Script>


    <Script For=grdT_CM_EDUCATION_04 Event="OnDblClick(row, col)">
        var obj = new String();

        obj.edu_cd      = dsT_CM_EDUCATION_04.NameValue(row, "EDU_CD");
        obj.edu_nm      = dsT_CM_EDUCATION_04.NameValue(row, "EDU_NM");
        obj.seq_no      = dsT_CM_EDUCATION_04.NameValue(row, "SEQ_NO");
        obj.eno_no      = dsT_CM_EDUCATION_04.NameValue(row, "ENO_NO");
        obj.eno_nm      = document.getElementById("txtENO_NO_SHR").value;

        //obj.str_ymd     = dsT_ED_CHASULIST.NameValue(row, "STR_YMD");



        // �������
        // 1: ���, 2: ����
        if (col == 'EDU_RPT' && dsT_CM_EDUCATION_04.NameValue(row, "EDU_RPT") == "�����ۼ�") {
            if(dsT_CM_EDUCATION_04.NameValue(row, "EDU_RPT") == "�����ۼ�"){
            	obj.gbn = "1";
            } else if(dsT_CM_EDUCATION_04.NameValue(row, "EDU_RPT") == "�Ϸ�"){
            	obj.gbn = "2";
            }

            window.showModalDialog("/hr/edu/educ011.jsp", obj, "dialogWidth:860px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }



    </Script>
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������Ȳ</td>
                    <td align="right" class="navigator">HOME/��������/�����н�����/<font color="#000000">������������Ȳ</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
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
			            	<colgroup>
			                	<col width="80"></col>
			                    <col width="180"></col>
			                    <col width="80"></col>
			                    <col width="100"></col>
			                    <col width="80"></col>
			                    <col width="*"></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">�����ȣ&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD')">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD')">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
									<input type="text" id="txtJIKMU_NM_UP"  style="width:100%" class="input_ReadOnly"  readOnly >
                                </td>
                                <td align="right" class="searchState">��������&nbsp;</td>
                                <td class="padding2423">
									<input type="text" id="txtJIKMU_CD_SHR" size="6" class="input_ReadOnly"  readOnly >
									<input type="text" id="txtJIKMU_NM"     size="20" class="input_ReadOnly"  readOnly >
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

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�����Ʒ� �̼���Ȳ</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:86px;">
						<param name="DataID" value="dsT_CM_DUTYMST">
						<param name="Format"				value="
							<G> name='���뿪��'  HeadBgColor='#F7DCBB'
								<C> id='ACH_COM'			width='80'		name='��ǥ'			align='center'	Edit=none</C>
								<C> id='COM_FNSH'			width='80'		name='�̼�'			align='center'	Edit=none</C>
								<C> id='COM_RAT'			width='80'		name='�̼���(%)'	align='center'	Edit=none Value={COM_FNSH/ACH_COM*100}</C>
								<C> id='COM_AVG'			width='80'		name='����(���)'	align='center'	Edit=none</C>
							</G>
							<G> name='��������'  HeadBgColor='#F7DCBB'
								<C> id='ACH_JOB'			width='80'		name='��ǥ'			align='center'	Edit=none</C>
								<C> id='JOB_FNSH'			width='80'		name='�̼�'			align='center'	Edit=none</C>
								<C> id='JOB_RAT'			width='80'		name='�̼���(%)'	align='center'	Edit=none  Value={JOB_FNSH/ACH_JOB*100}</C>
								<C> id='JOB_AVG'			width='80'		name='����(���)'	align='center'	Edit=none</C>
							</G>
							<G> name='��Ÿ����'  HeadBgColor='#F7DCBB'
							<C> id='ETC_CNT'            	width='80'      name='�̼�'     	align='center'   Edit=none</C>
							</G>
							<G> name='�系����'  HeadBgColor='#F7DCBB'
							<C> id='LCT_TIME'			width='80'		name='�̷�(HR)'			align='center'	Edit=none</C>
							</G>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>���뿪�� ���� �̼�����</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_02">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='165'		name='������'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='50'		name='����'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='ATND'	        width='50'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_TNM'        width='75'     	name='���Ῡ��'     align='center' 		value={DECODE(EDU_TAG,'N','�̼���','Y','����')} </C>
								<C> id='APP_VAL'        width='75'		name='�̼�����'		align='center'		Edit=none				</C>
								<C> id='TIME_NO'		width='75'		name='�����ð�'		align='center'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�������� ���� �̼�����</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_04">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='CLAS_NM'		width='75'		name='�����з�'		align='left'		Edit=none				</C>
								<C> id='INT_NAM'		width='75'		name='�������'		align='left'		Edit=none				</C>
								<C> id='EDU_NM'			width='165'		name='������'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='50'		name='����'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='ATND'	        width='50'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_TNM'        width='75'     	name='���Ῡ��'     align='center' 		value={DECODE(EDU_TAG,'N','�̼���','Y','����')} </C>
								<C> id='APP_VAL'        width='75'		name='�̼�����'		align='center'		Edit=none				</C>
								<C> id='TIME_NO'		width='75'		name='�����ð�'		align='center'		Edit=none				</C>
								<C> id='RPT_REQ_NO'		width='75'		name='�����ȣ'		align='center'		Edit=none				</C>
								<C> id='RPT_YN'			width='75'		name='�������'		align='center'		Edit=none				</C>
								<C> id='SPRD'			width='75'		name='���ı���'		align='center'		Edit=none				</C>
								<C> id='EDU_RPT'		width='90'		name='�����ۼ�'	align='center'		Edit=none	Color='Blue'			</C>
								<C> id='ENO_NO'			width='75'		name='���'		align='center'		Edit=none	show=false			</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>��Ÿ���� �̼�����</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_EXCEPTER_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_EXCEPTER_05">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='165'		name='������'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='50'		name='����'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='ATND'	        width='50'		name='����'			align='center'		Edit=none				</C>
								<C> id='EDU_TNM'        width='75'     	name='���Ῡ��'     align='center' 		value={DECODE(EDU_TAG,'N','�̼���','Y','����')} </C>
								<C> id='TIME_NO'		width='75'		name='�����ð�'		align='center'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�系�����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_LCTRHIST_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_LCTRHIST_03">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='LCT_TAG'		width='150'		name='���Ǹ�'		align='left'		Edit=none				</C>
								<C> id='LCT_TIME'		width='70'		name='���ǽð�'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='EDU_NM'			width='150'		name='������'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='75'		name='����'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='75'		name='����'			align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='70'		name='����'			align='right'		Edit=none				</C>
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