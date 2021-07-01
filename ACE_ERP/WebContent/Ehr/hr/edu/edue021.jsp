<!--
    ************************************************************************************
    * @Source         : edue032.jsp                                              
    * @Description    : ������û����������û�� PAGE                         
    * @Developer Desc :                                                          
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                  
    *-------------+-----------+--------------------------------------------------------+
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/23  |  ������   | �ҽ�����                                     
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>

    <head>
    <title>������û ����������û��</title>
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


        var opener = window.dialogArguments;
        
        var flag   = '';                       // 0: ��ȸ, 1: ����/����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_RQSTOBJTLIST.ClearData();
            dsT_ED_OPENRQST.ClearData();

            flag = '0';

            trT_ED_CHASULIST.KeyValue = "SVL(O:SHR=dsT_ED_OPENRQST, O:SHR2=dsT_ED_RQSTOBJTLIST, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue021.cmd.EDUE021CMD&S_MODE=SHR&ORD_NO="+opener.ord_no;
            trT_ED_CHASULIST.post();

            form1.grdT_CM_EDUCATION.Focus();

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

            if(fnc_SaveItemCheck()) {

                flag = '1';

                // �ش� ���������� �����Ǿ����� CHECK
                dsT_ED_OPENRQST.UseChangeInfo = false;

                trT_ED_CHASULIST.KeyValue = "SVL(I:SAV=dsT_ED_OPENRQST, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
                trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue021.cmd.EDUE021CMD&S_MODE=SAV&DPT_CD="+dsVI_T_PERSON.NameValue(0,"DPT_CD")+"&JOB_CD="+dsVI_T_PERSON.NameValue(0,"JOB_CD")+"&ORD_NO="+opener.ord_no;
                trT_ED_CHASULIST.post();

                dsT_ED_OPENRQST.UseChangeInfo = true;

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = dsT_ED_OPENRQST.NameValue(1, "CHK_YN");

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_OPENRQST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�ش���� [" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"EDU_CD") + "] [" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"EDU_NM") + "] ��û�� ����Ͻðڽ��ϱ�?") == false) return;

            if (status == "Y")    {

                flag = '1';

                dsT_ED_RQSTOBJTLIST.DeleteRow(dsT_ED_RQSTOBJTLIST.RowPosition);

                trT_ED_CHASULIST.KeyValue = "SVL(I:DEL=dsT_ED_RQSTOBJTLIST)";
                trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue021.cmd.EDUE021CMD&S_MODE=DEL";
                trT_ED_CHASULIST.post();
            }
            else {
                flag = '';
                document.getElementById("Message").innerText = '* ��û���� ���� ���������� ��û����� �� �����ϴ�.';
                return;
            }

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

            if (dsT_ED_RQSTOBJTLIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("������û���½�û��", '', 225);

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

          //  fnc_Delete();

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

            var f = document.form1;

            // Ȯ�� CHECK
            if( document.getElementById("chkCHECK").checked == false ) {
                alert("��û�Ͻñ� ���� Ȯ�ζ��� üũ�Ͽ� �ֽʽÿ�.");
                document.getElementById("chkCHECK").focus();
                return false;
            }

            if(dsT_DI_APPROVAL.CountRow < 1){
				alert("���缱�� �ϳ��̻� ������ �ֽʽÿ�");
				return false;
			}

            if (dsT_ED_OPENRQST.NameValue(1, "CHK_YN") == "Y") {
                alert("�̹� ��û�Ͻ� ���������Դϴ�.");
                document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_EDUCATION,0,"false","false");
            
            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");
            
            dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// ���³�¥
	                            "GUN_GBN:STRING(1),"+			// ���°��籸��
								"DPT_CD:STRING(6),"+			// ���ºμ�
								"DPT_NM:STRING(10),"+			// ���ºμ���
								"SEQ_NO:STRING(1),"+			// ���缱
								"ENO_NO:STRING(10),"+			// �����ڻ��
								"JOB_CD:STRING(10),"+			// ����������
								"APP_TIME:STRING(10),"+			// ����ð�
								"PENO_NO:STRING(10),"+			// ����ڻ��
								"APP_YN:STRING(10),"+			// ���翩��
								"ENO_NM:STRING(10),"+			// �����ڸ�
								"JOB_NM:STRING(10)"				// ������
								);
            
            
            //�������� �ҷ����� �߰�  ( ����, �Ҽ�   ������ �����.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            
            dsVI_T_PERSON.reset();

            

            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;
            document.getElementById("txtDPT_NM").value = dsVI_T_PERSON.NameValue(0,"DPT_NM");;
            document.getElementById("txtJOB_NM").value = dsVI_T_PERSON.NameValue(0,"JOB_NM");

            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_OPENRQST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList();

            window.close();

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
         //���缱����
		function fnc_Approval(){

         	var STR_YMD_SHR = "";
			var END_YMD_SHR = "";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			var EMP_NO      = gusrid;
			var COST = dsT_ED_OPENRQST.NameValue(1, "COST_AMT");

			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"M",COST);

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");	//���缱(�������)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// �Ϻ� ���¿��� ������ ���� �ʰ� �ϱ����ؼ�...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = gusrid;	//����� ���
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "M";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EDUCATION) |
    | 3. ���Ǵ� Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_RQSTOBJTLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_CHASULIST) |
    | 3. ���Ǵ� Table List(T_ED_CHASULIST)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_OPENRQST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_OPENRQST)">
    </Object>
    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_APPROVAL)			 	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
      <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�ּ�)							       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
	</Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_RQSTOBJTLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_RQSTOBJTLIST.CountRow );

        }

    </Script>
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {


        } else {

            //fnc_HiddenElement("imgSave");
            //fnc_HiddenElement("imgReport");
            fnc_HiddenElement("ImgSelectapproval");

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_RQSTOBJTLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_RQSTOBJTLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_OPENRQST Event="OnLoadCompleted(iCount)">

        if (dsT_ED_OPENRQST.NameValue(1, "CHK_YN") != "Y")    {

            document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ͻ� �� �ֽ��ϴ�.';
            document.getElementById("chkCHECK").checked = false;
            document.getElementById("chkCHECK").disabled = false;
            document.getElementById("chkCHECK").focus();

        } else {

            document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
            document.getElementById("chkCheck").checked = true;
            document.getElementById("chkCheck").disabled = true;

        }

        document.getElementById("txtEDU_TXT").value      = dsT_ED_OPENRQST.NameValue(1, "EDU_TXT");
        document.getElementById("txtEDU_STR_YMD").value = dsT_ED_OPENRQST.NameValue(1, "EDU_STR_YMD");
        document.getElementById("txtEDU_END_YMD").value = dsT_ED_OPENRQST.NameValue(1, "EDU_END_YMD");

        document.getElementById("txtEDU_GBN_TXT").value     = dsT_ED_OPENRQST.NameValue(1, "EDU_GBN_TXT");
        document.getElementById("txtPLACE_TXT").value   = dsT_ED_OPENRQST.NameValue(1, "PLACE_TXT");
        form1.medCOST_AMT.text                          = dsT_ED_OPENRQST.NameValue(1, "COST_AMT");
        document.getElementById("txtFIX_NO").value      = dsT_ED_OPENRQST.NameValue(1, "FIX_NO");
        document.getElementById("txtREQ_CNT").value      = dsT_ED_OPENRQST.NameValue(1, "REQ_CNT");
        document.getElementById("txtCONTENT_TXT").value = dsT_ED_OPENRQST.NameValue(1, "CONTENT_TXT");
        document.getElementById("txtINS_NM").value      = dsT_ED_OPENRQST.NameValue(1, "INS_NM");
        form1.medRTN_AMT.text                           = dsT_ED_OPENRQST.NameValue(1, "RTN_AMT");

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ED_CHASULIST event="OnSuccess()">

        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ED_CHASULIST event="OnFail()">

        cfErrorMsg(this);
        flag = '';

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
        <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������û����������û��</td>
                    <td align="right" class="navigator">HOME/�λ����/�İ߻��/<font color="#000000">������û����������û��</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">   <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                    <td valign="top" class="searchState"><span id="Message">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >��������</td>
                    <td class="padding2423" align="left">
						<input id="txtEDU_TXT" name="txtEDU_TXT" size="19" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="blueBold">�����Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                    </td>
                    <td class="padding2423" colspan="2" rowspan="4">
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
							<tr><td align="right">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()"></a>
							</td></tr>
                    		<tr><td class="padding2423">
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:250px;height:100px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'	width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
	            					<C> id='SEQ_NO'	width=30	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=80	name='�μ�'		align=center	</C>
									<C> id='JOB_NM'	width=60	name='����'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='���'		align=center	show=false</C>
									<C> id='ENO_NM'	width=60	name='����'		align=center	</C>
									<C> id='APP_YN'	width=70	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')} show=false</C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td></tr>
						</table>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtEDU_GBN_TXT" name="txtEDU_GBN_TXT" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtPLACE_TXT" name="txtPLACE_TXT" maxlength="50" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREQ_CNT" name="txtREQ_CNT" maxlength="20" style="width:70;text-align:right;" class="input_ReadOnly" readonly>
                        / <input id="txtFIX_NO" name="txtFIX_NO" maxlength="20" style="width:70;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="70" rows="3" maxlength="300"  class="input_ReadOnly" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">ȯ�޿���</td>
                    <td class="padding2423">
                        <input id="txtINS_NM" name="txtINS_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">ȯ�޿����</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="blueBold">&nbsp;</td>
                    <td class="padding2423">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�� û ��</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtENO_NO" size="10" maxlength="8" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                        &nbsp;&nbsp;&nbsp;�μ� <input id="txtDPT_NM" size="20" class="input_ReadOnly" readonly>
                        &nbsp;&nbsp;���� <input id="txtJOB_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="padding2423" colspan="6">
                        �ش� �������¸� ��û�մϴ�. <input type="checkbox" id="chkCHECK"  name="chkCHECK">Ȯ��&nbsp;&nbsp;
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
                            <param name="DataID"                  value="dsT_ED_RQSTOBJTLIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     		width=40    	name='����'         	align=center </C>
                                <C> id='EDU_STR_YMD'  	width=150    	name='��������'     	align=center </C>
                                <C> id='EDU_END_YMD'  	width=150    	name='��������'     	align=center </C>
                                <C> id='ENO_NO'       		width=80    	name='���'     		align=center </C>
                                <C> id='ENO_NM'       		width=80    	name='����'         	align=center </C>
                                <C> id='DPT_NM'       		width=180    	name='�μ�'         	align=center </C>
                                <C> id='JOB_NM'       		width=90    	name='����'         	align=center </C>
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
