<!--
***********************************************************************
* @source      : gunc071.jsp
* @description : ���ϱٹ� ���� ���� ����  PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/06      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ϱٹ� ���� ���� ����(gunc071)</title>
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
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'F' + 'F' + 'T';

        var today = getToday();
        var param = window.dialogArguments;
		var obj = new String();
		obj.app_cmt = "";
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			//���º����û��Ȳ ���� ��ȸ
            //var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_yymm = param.gun_ymd;

			//alert("dpt_cd: "+dpt_cd + " str_yymm: "+str_yymm);

			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc071.cmd.GUNC071CMD&S_MODE=SHR&STR_YYMM="+str_yymm;
			dsT_DI_HOLIDAYWORK.reset();

			//������ ��ȸ
            fnc_SearchApprover();
        }



        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {
            var HOL_YMD = param.gun_ymd.replace("-","");
            var REQ_NO  = HOL_YMD + "JZZZ";

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=J";
            dsT_DI_APPROVAL.Reset();

        }
		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

          	// save

/*
			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
*/
			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc070.cmd.GUNC070CMD&S_MODE=SAV";
			trT_DI_HOLIDAYWORK.post();



        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_DI_HOLIDAYWORK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_HOLIDAYWORK.GridToExcel("���ϱٹ���������", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {
			//document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_HOLIDAYWORK.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			window.close();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_DI_HOLIDAYWORK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
			//form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

            cfStyleGrid(form1.grdT_DI_HOLIDAYWORK, 0, "true", "false");      // Grid Style ����
            form1.grdT_DI_HOLIDAYWORK.Editable = "false";

            document.getElementById("txtPIS_YM_SHR").value = param.gun_ymd;

                document.getElementById("imgApproval").style.display = "none";
                document.getElementById("imgRejection").style.display = "none";

           // document.getElementById("hidDPT_CD_ORI").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ�


            fnc_SearchList();
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
          // test  fnc_HiddenElement("imgConduct");
          //  fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

<%
    }
%>

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * ������ ������ ��ȸ�սô�.

        function fnc_Approval() {
            var DPT_CD = document.getElementById("hidDPT_CD_ORI").value;

            //������ ���� ��ȸ
            window.showModalDialog("./gunc011.jsp", dsT_DI_APPROVAL, "dialogWidth:500px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            for(var i=1; i<=2; i++) {
                document.getElementById("txtA"+i+"_ENO_NM").innerText   = dsT_DI_APPROVAL.NameValue(i, "JOB_NM")+" "+dsT_DI_APPROVAL.NameValue(i, "ENO_NM");
                document.getElementById("txtA"+i+"_APP_STS").innerText  = dsT_DI_APPROVAL.NameValue(i, "APP_YN_NM");

            }

        }
         * ������ ������ ��ȸ�սô�.
         */
        /**
         * ���縦 ó�� �Ѵ�.
         *
         */
		function fnc_SubmitApproval(kind) {
            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

            var app_yn = "";    //����ϷῩ��
            var	row = "";
            var leno_no = dsT_DI_APPROVAL.NameValue(1,"ENO_NO");//�ֻ����� ����������
            var our_man = '<%=box.get("SESSION_ENONO")%>';

			if(leno_no != our_man){
	            dsT_DI_APPROVAL.NameString(2, "APP_YN") = "Y";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "R";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            row = "2"

            }else if(leno_no == our_man){
	            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "Y";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            row = "1"
            }

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc071.cmd.GUNC071CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +dsT_DI_APPROVAL.NameString(row, "APP_YN")
                                      + "&GUN_YMD=" +dsT_DI_APPROVAL.NameString(row, "GUN_YMD")
                                      + "&GUN_GBN=" +dsT_DI_APPROVAL.NameString(row, "GUN_GBN")
                                      + "&GUN_DPT=" +dsT_DI_APPROVAL.NameString(row, "GUN_DPT")
                                      + "&SEQ_NO="  +dsT_DI_APPROVAL.NameString(row, "SEQ_NO");
			trT_DI_HOLIDAYWORK.post();
			//������ ��ȸ
            fnc_SearchApprover();
                document.getElementById("imgApproval").style.display = "none";
                document.getElementById("imgRejection").style.display = "none";

		}

        /**
         * �ΰ��� ó�� �Ѵ�.
         *
         */
		function fnc_SubmitCancle(kind) {

            var	row = "";
            var leno_no = dsT_DI_APPROVAL.NameValue(1,"ENO_NO");//�ֻ����� ����������
            var our_man = '<%=box.get("SESSION_ENONO")%>';

			if(leno_no != our_man){
	            dsT_DI_APPROVAL.NameString(2, "APP_YN") = "N";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            row = "2"

            }else if(leno_no == our_man){
	            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "N";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            row = "1"
            }

            window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != ""){

				trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc071.cmd.GUNC071CMD"
	                                      + "&S_MODE=UPT_REJ"
	                                      + "&APP_YN="  +dsT_DI_APPROVAL.NameString(row, "APP_YN")
	                                      + "&GUN_YMD=" +dsT_DI_APPROVAL.NameString(row, "GUN_YMD")
	                                      + "&GUN_GBN=" +dsT_DI_APPROVAL.NameString(row, "GUN_GBN")
	                                      + "&GUN_DPT=" +dsT_DI_APPROVAL.NameString(row, "GUN_DPT")
	                                      + "&SEQ_NO="  +dsT_DI_APPROVAL.NameString(row, "SEQ_NO")
	                                      + "&REMARK="  +obj.app_cmt;
				trT_DI_HOLIDAYWORK.post();
			//������ ��ȸ
            fnc_SearchApprover();
                document.getElementById("imgApproval").style.display = "none";
                document.getElementById("imgRejection").style.display = "none";


            }

        }



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_HOLIDAYWORK)	   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-----------------------------------------------------+
    | 1. ī�ǿ� DataSet							           |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_HOLIDAYWORK)	   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_HOLIDAYWORK)	   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK)		       |
    +------------------------------------------------------>
	<Object ID="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK,I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)">
	</Object>
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_DI_APPROVAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>


    <!-- ���缱 ��ȸ �� -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
	 var SESSION_ENONO = '<%=box.get("SESSION_ENONO")%>';
      if(dsT_DI_APPROVAL.CountRow == 0) {
                 return;
        }
		// ������ ��� ������ ��� �����ڿ��� ����,�ΰ� �̹��� �����ֱ�
		for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
			var APP_YN = dsT_DI_APPROVAL.NameString(i, "APP_YN");
			var ENO_NO = dsT_DI_APPROVAL.NameString(i, "ENO_NO");

			if(ENO_NO == SESSION_ENONO && APP_YN == "R") {
				fnc_ShowElement("imgApproval");
				fnc_ShowElement("imgRejection");
				dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
				break;
			}
		}
        //������ ���� ���ε�
            document.getElementById("txtORD_NO").innerText      = dsT_DI_APPROVAL.NameValue(1, "REQ_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IENO_NM");
            document.getElementById("txtDPT_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
            document.getElementById("txtJOB_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IJOB_NM");


    </Script>
	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
        alert("��ȸ �� ���缱 �����Ͽ� �ֽñ� �ٶ��ϴ�");
    </Script>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
        alert("��ȸ �� ���缱 �����Ͽ� �ֽñ� �ٶ��ϴ�");
    </Script>
	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_DI_HOLIDAYWORK event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_HOLIDAYWORK event="OnFail()">
        cfErrorMsg(this);
    </script>
    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_DI_HOLIDAYWORK event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "CONF_SEL" && dsT_DI_HOLIDAYWORK.CountRow > 0) {
            for(var i=1; i<=dsT_DI_HOLIDAYWORK.CountRow; i++) {
                if(dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") == "F") {
                    dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") = "T";
                } else if(dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") == "T") {
                    dsT_DI_HOLIDAYWORK.NameString(i, "CONF_SEL") = "F";
                }
            }
        }

    </script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ��Է�" ){

		window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
  </script>
	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱٹ���������</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���ϱٹ���������</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
		<!-- 	<td height="35"  class="searchState" align="left">�ش���&nbsp;<input id="txtPIS_YM_SHR" size="7" maxlength="7" class="input_ReadOnly" readOnly></td> -->
			<td height="35"  width="103" class="searchState" align="center">�ش���</td>
			<td  width="120">
			<input id="txtPIS_YM_SHR" size="27" maxlength="7" class="input_ReadOnly" readOnly>
			</td>
			<td height="35" class="paddingTop5" align="right">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('����');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('�ΰ�');"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->


<!-- ���� ����  ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ����� ���� ���� -->
			<table width="290" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="creamBold">ǰ�ǹ�ȣ</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="27" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="creamBold">�Ҽ�</td>
								<td class="padding2423">
                                    <input id="txtDPT_NM" size="27" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">����</td>
								<td class="padding2423">
                                    <input id="txtJOB_NM" size="27" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">�����</td>
								<td class="padding2423">
                                    <input id="txtENO_NM" size="27" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ����� ���� �� -->
        </td>
        <td width="20">&nbsp;</td>
        <td>
        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="430" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='REQ_NO'		width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
								<C> id='ENO_NO'		width=100	name='���'		align=center	show=false</C>
            					<C> id='SEQ_NO'		width=70	name='����'		align=center	Value={DECODE(ENO_NO,'100019','����','����')}</C>
								<C> id='ENO_NM'		width=90	name='������'	align=center</C>
								<C> id='JOB_NM'		width=80	name='����'		align=center	</C>
                                <C> id='DPT_NM'		width=100	name='�μ�'		align=left		show=false</C>
								<C> id='APP_YN'		width=160	name='�������'	align=left		Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&APP_YMD} </C>
								<C> id='REMARK1'	width=75	name='�ǰ�'		align=center 	Color='Blue'	</C>
								<C> id='REMARK'		width=60	name='����'		align=center	show=false</C>
							">
							<param name="wmode" value="transparent" >
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- ���缱 ���� ���̺� �� -->
        </td>
    </tr>
</table>
<!-- ���� ����  �� -->
<br>



	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
						<param name="DataID" value="dsT_DI_HOLIDAYWORK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=50    name="NO"			align=center </C>
                            <C> id="DPT_NM"		width=120	name="�Ҽ�"		    align=center    Edit=none	Suppress="1" </C>
                            <C> id="JOB_NM"		width=60	name="����"		    align=center    Edit=none	Suppress="2" </C>
                            <C> id="ENO_NO"	    width=70	name="���"         align=center    Edit=none	</C>
                            <C> id="ENO_NM"	    width=70	name="����"	        align=center    Edit=none	</C>
                            <C> id="HOL_AMT"	width=80	name="���ϱٹ�����"	align=right     Edit=none	</C>
                            <C> id="CNT"		width=100	name="�ο�"    	    align=center    Edit=none	value={Decode(CNT,0,"",CNT)}</C>
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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