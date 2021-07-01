<!--
***********************************************************************
* @source      : pirc020.jsp
* @description : �޻����޾���ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/16      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    boolean isMaster = false;
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002"))
        isMaster = true;
%>
<html>
<head>
<title>�޻����޾���ȸ(pirc020)</title>
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
		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTFTFT';
		var _OCC_CD;

        var ActiveIndex = 0;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            TabEvent(0);
        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

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


        	var OCC_CD = dsT_CP_PAYMASTER.NameValue(1,'OCC_CD');


        	var pis_yymm = document.getElementById('txtPIS_YYMM_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_gbn = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var seq = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ



            if(!fnc_SearchItemCheck()) return;      //�˻����� ��ȿ�� �˻�


	            var url = "pirc020_PV.jsp?eno_no="+eno_no+"&sal_gbn="+sal_gbn+"&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7)+"&seq="+seq+"&OCC_CD="+OCC_CD;
	            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	            return;

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

<%
    //������ ������ ��쿡�� ����� ����
    if(isMaster) {
%>
            document.getElementById('txtENO_NO_SHR').value = '';
            document.getElementById('txtENO_NM_SHR').value = '';
<%
    }
%>
            document.getElementById('txtENO_NM_SHR').value = '';
            document.getElementById("cmbSAL_GBN_SHR").value = "0";
			document.getElementById("cmbSEQ_SHR").value = "1";
			document.getElementById("resultMessage").innerText = ' ';

			dsT_CP_PAYMASTER.ClearData();
			dsT_CP_PAYMASTER_01.ClearData();
			dsT_CP_PAYMASTER_02.ClearData();

            document.getElementById('txtPIS_YYMM_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_yymm = document.getElementById("txtPIS_YYMM_SHR");
            var eno_no = document.getElementById('txtENO_NO_SHR');

            if(pis_yymm.value == "" || pis_yymm.value.length < 7){
                alert("YYYY-MM ������ �ش����� �Է��ϼ���!");
                pis_yymm.focus();
                return false;
            }
            if(eno_no.value == ""){
                alert("����� �Է��ϼ���!");
                eno_no.focus();
                return false;
            }
            return true;

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

            fnc_ChangeGrid(1);      //�׸��� ���� ó��

			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");      // Grid Style ����

			//���� �׸���
			//cfStyleGrid(form1.grdT_CP_PAYMASTER_02,0,"false","false");      // Grid Style ����
			//form1.grdT_CP_PAYMASTER_02.HiddenHScroll  = true;
			//form1.grdT_CP_PAYMASTER_02.HiddenVScroll  = true;
			//form1.grdT_CP_PAYMASTER_02.DisableNoHScroll = false;
			//form1.grdT_CP_PAYMASTER_02.DisableNoVScroll = false;
            //form1.grdT_CP_PAYMASTER_02.IgnoreSelectionColor = "true";



			document.getElementById("btn4").style.display = "";
			document.getElementById("btn5").style.display = "none";


            document.getElementById('txtENO_NO_SHR').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM_SHR').value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById('txtENO_NO').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtENO_NM').value = '<%=box.get("SESSION_ENONM")%>';

<%

    if(isMaster) {
%>
            fnc_ShowElement("eno_no");
            fnc_ShowElement("eno_no_shr");
<%
    }
%>
            document.getElementById('txtPIS_YYMM_SHR').value = getToday().substring(0,7);
            document.getElementById('txtPIS_YYMM_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*************************
         * 16. �׸��� ���� ó��  *
         ************************/
		function fnc_ChangeGrid(kind) {

			_OCC_CD = dsT_CP_PAYMASTER.NameValue(1,'OCC_CD');

			if(kind == '1'){
				var OCC_CD = dsT_CP_PAYMASTER.NameValue(1,'OCC_CD');

				if(OCC_CD != "M"){//�繫��
					document.getElementById("divPIRC020_01").style.display = "";
					document.getElementById("divPIRC020_03").style.display = "none";
					document.getElementById("divPIRC020_04").style.display = "none";

				}else{//�ù���
					document.getElementById("divPIRC020_01").style.display = "none";
					document.getElementById("divPIRC020_03").style.display = "none";
					document.getElementById("divPIRC020_04").style.display = "none";

				}



            }else if(kind == '2'){
					document.getElementById("divPIRC020_01").style.display = "none";
					document.getElementById("divPIRC020_03").style.display = "";
					document.getElementById("divPIRC020_04").style.display = "none";

            }else if(kind == '3'){
					document.getElementById("divPIRC020_01").style.display = "none";
					document.getElementById("divPIRC020_03").style.display = "none";
					document.getElementById("divPIRC020_04").style.display = "";

            }

		}

        /********************************
         * 17. �ǹ�ư Ŭ���� ���� ó��  *
         *******************************/
		function fnc_TabOnClick(kind) {

            var pis_yymm = document.getElementById('txtPIS_YYMM_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var sal_gbn = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���
			var seq = document.getElementById("cmbSEQ_SHR").value; // �Ϸù�ȣ
            var shr = "";

            if(kind == 1){
                shr = "SHR_01";
            }else if(kind == 2){
                shr = "SHR_02";
            }else if(kind == 3){
                shr = "SHR_03";
            }

            if(!fnc_SearchItemCheck()) return;      //�˻����� ��ȿ�� �˻�

			//�������� ��ȸ
   			dsT_CP_PAYMASTER_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc020.cmd.PIRC020CMD"
                                       + "&S_MODE=SHR_06"
                                       + "&PIS_YY="+pis_yymm.substring(0,4)
                                       + "&PIS_MM="+pis_yymm.substring(5,7)
                                       + "&ENO_NO="+eno_no
                                       + "&SAL_GBN="+sal_gbn
                                       + "&SEQ="+seq;
    		dsT_CP_PAYMASTER_01.reset();

			//�׸��� ��ȸ
			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc020.cmd.PIRC020CMD"
                                    + "&S_MODE="+shr
                                    + "&PIS_YY="+pis_yymm.substring(0,4)
                                    + "&PIS_MM="+pis_yymm.substring(5,7)
                                    + "&ENO_NO="+eno_no
                                    + "&SAL_GBN="+sal_gbn
                                    + "&SEQ="+seq;
    		dsT_CP_PAYMASTER.reset();

            if(kind == 1){
                //��Ÿ���� + ��Ÿ���Ҿ��� 0 �� �ƴҶ��� �����ش�.
                if( (parseInt(dsT_CP_PAYMASTER.NameValue(1,'ETC_AMT')) + parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTH_AMT'))) != 0){
                    document.getElementById("btn4").style.display = "";
                }else{
                    document.getElementById("btn4").style.display = "none";
                }

                document.getElementById("btn5").style.display = "none";

            }else if(kind == 2){
                document.getElementById("btn4").style.display = "none";

                //��Ÿ�������� 0 �� �ƴҶ��� �����ش�.
                if( parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTHD_AMT')) != 0){
                    document.getElementById("btn5").style.display = "";
                }else{
                    document.getElementById("btn5").style.display = "";
                }

            }else if(kind == 3){
                document.getElementById("btn4").style.display = "none";
                document.getElementById("btn5").style.display = "none";
            }

            fnc_ChangeGrid(kind);       //�׸��� ���� ó��

		}



        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {
            ActiveIndex = idx+1;

            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=3; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";

            fnc_TabOnClick(ActiveIndex);
        }



		function fnc_saga070Popup(){

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var ENO_NM = document.getElementById('txtENO_NM').value;

            if(ENO_NO.trim() == ""){
                alert("��������� �����ϴ�. ��ȸ�� ���� �������ּ���.");
                return false;
            }

            window.showModalDialog("/hr/sag/saga070.jsp?ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM, "Modal", "dialogWidth:850px; dialogHeight:580px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		}

		function fnc_pirc021Popup(kind){
			if(dsT_CP_PAYMASTER.countrow == 0 ){
				alert("��ȸ�� ���� �������ּ���.");
				return false;
			}

			window.showModalDialog("/hr/pir/pirc021.jsp", dsT_CP_PAYMASTER, "dialogWidth:510px; dialogHeight:400px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		}





    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_PAYMASTER)|
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)		 |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_PAYMASTER)|
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)		 |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_PAYMASTER)|
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)		 |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

	        var kind = dsT_CP_PAYMASTER.NameValue(1,'KIND');
	        var tot_amt = 0;

        	if(kind == '1'){
        		tot_amt = parseInt(dsT_CP_PAYMASTER.NameValue(1,'BAS_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'DUTY_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'WEL_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'OT_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'OSE_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'LSEV_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'RUN_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'MH_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'ETC_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'PPEN_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTH_AMT'));

				if(tot_amt == 0){
					fnc_Message(document.getElementById("resultMessage"), "MSG_02");
				}else{
					fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
				}

        	}else if(kind == '2'){
				tot_amt = parseInt(dsT_CP_PAYMASTER.NameValue(1,'INCM_TAX')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'CITI_TAX')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'HINU_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'NPEN_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'HINS_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'DHLP_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'PPED_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'LON_RPY')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'LON_INT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'OTHD_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'LAB_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'WOM_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'SAV_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'APP_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'CONT_AMT')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'DRE_INTX')) +
        			parseInt(dsT_CP_PAYMASTER.NameValue(1,'DRE_CTTX')) +
                    parseInt(dsT_CP_PAYMASTER.NameValue(1,'DRE_DFTX'));


				if(tot_amt == 0){
					fnc_Message(document.getElementById("resultMessage"), "MSG_02");
				}else{
					fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
				}

        	}else{
				fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        	}

        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			//fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			//������ȸ
			var PIS_YY = dsT_CP_PAYMASTER_01.NameValue(1,"PIS_YY");
			var PIS_MM = dsT_CP_PAYMASTER_01.NameValue(1,"PIS_MM");
			var ENO_NO = dsT_CP_PAYMASTER_01.NameValue(1,"ENO_NO");
			var OCC_CD = dsT_CP_PAYMASTER_01.NameValue(1,"OCC_CD");
			var SAL_GBN = dsT_CP_PAYMASTER_01.NameValue(1,"SAL_GBN");
			var SEQ = dsT_CP_PAYMASTER_01.NameValue(1,"SEQ");

			dsT_CP_PAYMASTER_02.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc020.cmd.PIRC020CMD"
                                       + "&S_MODE=SHR_05"
                                       + "&PIS_YY="+PIS_YY
                                       + "&PIS_MM="+PIS_MM
                                       + "&ENO_NO="+ENO_NO
                                       + "&OCC_CD="+OCC_CD
                                       + "&SAL_GBN="+SAL_GBN
                                       + "&SEQ="+SEQ;
    		dsT_CP_PAYMASTER_02.reset();

        }

    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			//fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޻����޾���ȸ</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">�޻����޾���ȸ</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearSalary','','/images/button/btn_YearSalaryOver.gif',1)"><img src="/images/button/btn_YearSalaryOn.gif" name="imgYearSalary" border="0" align="absmiddle" onClick="fnc_saga070Popup()"></a>
			&nbsp;
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="90"></col>
									<col width="70"></col>
									<col width="90"></col>
									<col width="80"></col>
                                    <col width="90"></col>
                                    <col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">�ش���&nbsp;</td>
								<td class="padding2423">
									<input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13){fnc_SearchList();}cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();}">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','10','116');"></a>
								</td>
								<td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="WIDTH:70" onchange="fnc_SearchList()">
										<option value="0" >��  ��</option>
	                                    <option value="2" >��  ��</option>
									</select>
								</td>
								<td align="right" class="searchState">�Ϸù�ȣ&nbsp;</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:60" onchange="fnc_SearchList()">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
                                <td align="right" class="searchState"><div id="eno_no" style="display:none">��&nbsp;&nbsp;��&nbsp;</div></td>
                                <td class="padding2423">
                                <div id="eno_no_shr" style="display:none">
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13){fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13){fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>

                                </div>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="126"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input type=hidden id="REG_NO">
                        <input id="txtENO_NO" style="width:100%;border-width:0;" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" style="width:100%;border-width:0;" readonly>
                    </td>
                    <td align="center" class="creamBold">���� </td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%;border-width:0;" readonly>
                    </td>
                    <td align="center" class="creamBold">���¹�ȣ</td>
                    <td class="padding2423">
                        <input id="txtACC_NO" style="width:100%;border-width:0;" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ξ��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtSOU_CNT" size="1" readonly>
                        <input id="txtDFM_CNT" size="1" readonly>
                        <input id="txtTRB_CNT" size="1" readonly>
                        <input id="txtGOL_CNT" size="1" readonly>
                        <input id="txtWCT_CNT" size="1" readonly>
                        <input id="txtCHI_CNT" size="1" readonly>
                    </td>
                    <td align="center" class="creamBold">�����޾�</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSALT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
							<param name=Enable					value=true>
							<param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDDTT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">�Ǽ��ɾ�</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#FFFFFF">
                            <param name=Enable                  value=true>
                            <param name=ReadOnly                value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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

<!-- �� ��� ���۳�Ʈ ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- �ǹ�ư���̺� ���� -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="120">
                        <!-- �ǿ��� -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">���޳���</td>
                                <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">�Ϲݰ�������</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">����/���⳻��</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn4','','/images/button/btn_EtcSalaryOver.gif',1)"><img src="/images/button/btn_EtcSalaryOn.gif" name="btn4" border="0" align="absmiddle" onClick="fnc_pirc021Popup(1)"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn5','','/images/button/btn_EtcSalaryOver.gif',1)"><img src="/images/button/btn_EtcSalaryOn.gif" name="btn5" border="0" align="absmiddle" onClick="fnc_pirc021Popup(2)"></a>
        </td>
    </tr>
    <tr>
        <td colspan="2">

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
            <!-- �ǹ�ư���̺� �� -->

        </td>
    </tr>
</table>







<!-- ���� ��ȸ �׸��� ���̺� ����-->
<div id="divPIRC020_01" style="position:absolute; left:20; top:230; width:800; height:500; z-index:1;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="156"></col>
                    <col width="155"></col>
                    <col width="155"></col>
                    <col width="155"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�⺻��</td>
                    <td align="center" class="creamBold">��å����</td>
                    <td align="center" class="creamBold">�ð���</td>
                    <td align="center" class="creamBold">�󿩺������ޱ�</td>
                    <td align="center" class="creamBold">����������</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medBAS_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDUTY_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medLAW_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medBNS_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���ο���</td>
                    <td align="center" class="creamBold">������å����</td>
                    <td align="center" class="creamBold">�Ĵ�</td>
                    <td align="center" class="creamBold">�ڱ��ߺ�</td>
                    <td align="center" class="creamBold">���ϰ�������</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPPEN_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPOSITION_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT31" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT01" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT03" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ټӼ���</td>
                    <td align="center" class="creamBold">�����ξ�� </td>
                    <td align="center" class="creamBold">�����ٹ�����</td>
                    <td align="center" class="creamBold">���ڱ�</td>
                    <td align="center" class="creamBold">��Ÿ����</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medLSEV_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT41" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT21" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSCH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medOTH_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>
</div>


<div id="divPIRC020_03" style="position:absolute; left:20; top:230; width:800; height:240; z-index:1;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="126"></col>
                    <col width="125"></col>
                    <col width="125"></col>
                    <col width="125"></col>
                    <col width="124"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�ҵ漼</td>
                    <td align="center" class="creamBold">�ֹμ�</td>
                    <td align="center" class="creamBold">���ο���</td>
                    <td align="center" class="creamBold">�ǰ�����</td>
                    <td align="center" class="creamBold">��������纸��</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medINCM_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medCITI_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medNPEN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medHINU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medOLD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��뺸��</td>
                    <td align="center" class="creamBold">����ȸ��</td>
                    <td align="center" class="creamBold">���ο���</td>
                    <td align="center" class="creamBold">�޿�����</td>
                    <td align="center" class="creamBold">��������</td>
                </tr>
                <tr height="28">
                	 <td class="padding2423">
						<comment id="__NSID__"><object id="medHINS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medDHLP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medPPED_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medITXD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medLAB_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">������ȸ��</td>
                    <td align="center" class="creamBold">����ǰ�����</td>
                    <td align="center" class="creamBold">�����뺸��</td>
                    <td align="center" class="creamBold">�����ȯ��</td>
                    <td align="center" class="creamBold">�����ȯ����</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medWOM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDRE_INTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medDRE_CTTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medLON_RPY" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                     <td class="padding2423">
                        <comment id="__NSID__"><object id="medLON_INT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>


                <tr>
                    <td align="center" class="creamBold">��Ÿ����1</td>
                    <td align="center" class="creamBold">��Ÿ����2</td>
                    <td align="center" class="creamBold">��������ҵ漼</td>
                    <td align="center" class="creamBold">���������ֹμ�</td>
                    <td align="center" class="creamBold">���������Ư��</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medOTHD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT_AF" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                     <td class="padding2423">
						<comment id="__NSID__"><object id="medYC_INT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                     <td class="padding2423">
						<comment id="__NSID__"><object id="medYC_CTT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                     <td class="padding2423">
						<comment id="__NSID__"><object id="medETC_AMT_A6" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>

			</table>
		</td>
	</tr>




</table>
</div>

<div id="divPIRC020_04" style="position:absolute; left:20; top:230; width:800; height:170; z-index:1;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:160px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='BNK_NM'	 width=80	name='��������'			align=left </C>
	                            <C> id='SAV_NM'		 width=120	name='����'				align=center </C>
	                            <C> id='GUBUN'		 width=80	name='����'				align=center </C>
	                            <C> id='DUE_YMD'	 width=110	name='������'			align=center </C>
	                            <C> id='CONM_AMT'	 width=110	name='������Ծ�'		align=right </C>
	                            <C> id='SUMP_CNT'	 width=90	name='Ƚ��'				align=right </C>
	                            <C> id='SUM_SAV'	 width=90	name='�����'			align=right </C>
	                            <C> id='GMK_AMT'	 width=80	name='�������'	    align=right show=false</C>
	                            <C> id='GMK_BAK'	 width=90	name='������ܾ�'		align=right </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="divPIRC020_03" style="position:absolute; left:20; top:450; width:800; height:170; z-index:1;" >
<table width="800"  border="0" cellspacing="0" cellpadding="0">
     <tr>
         <td width="120">
             <!-- �ǿ��� -->
             <table width="120" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25"  ></td>
                     <td align="center" class="overMenu25"  style="cursor:hand"  >�⵵����</td>
                     <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" ></td>
                 </tr>
             </table>
         </td>
     </tr>
	 <tr>
        <td colspan="6">

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
            <!-- �ǹ�ư���̺� �� -->

        </td>
    </tr>
 </table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="126"></col>
                    <col width="125"></col>
                    <col width="125"></col>
                    <col width="125"></col>
                    <col width="124"></col>
                    <col width="124"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold"  >�Ǽ��ɾ�</td>
                    <td align="center" class="padding2423"  colspan="5">
                    	<comment id="__NSID__"><object id="medPAY_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�Ѽҵ�</td>
                    <td align="center" class="creamBold">�ҵ漼</td>
                    <td align="center" class="creamBold">�ֹμ�</td>
                    <td align="center" class="creamBold">���ο���</td>
                    <td align="center" class="creamBold">�ǰ�����</td>
                    <td align="center" class="creamBold">��뺸��</td>
                </tr>
                <tr height="28">
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medSALT_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medINCM_TAX_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCITI_TAX_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="medNPEN_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHINU_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHINS_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=false>
                            <param name=ClipMode                value=true>
                            <param name=ReadOnly                value=true>
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=12>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                 value="true">
                            <param name=MaxDecimalPlace         value=0>
                            <param name=VisibleMaxDecimal       value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold"></td>
                    <td align="center" class="creamBold"> </td>
                    <td align="center" class="creamBold"> </td>
                </tr>
                <tr height="28">

                    <!--<td class="padding2423">
						<comment id="__NSID__"><object id="medSAV_AMT_02" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=false>
							<param name=ClipMode				value=true>
							<param name=ReadOnly                value=true>
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible					value="true">
							<param name=MaxDecimalPlace 	    value=0>
							<param name=VisibleMaxDecimal   	value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>-->
                    <td class="padding2423">
                    </td>
                    <td class="padding2423">
                    </td>
                    <td class="padding2423">
                    </td>
                    <td class="padding2423">
                    </td>
                    <td class="padding2423">
                    </td>
                    <td class="padding2423">
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>

<!-- ��/�� MASTER ���̺� -->
<object id="bndT_CP_PAYMASTER_02" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_PAYMASTER_02">
    <Param Name="BindInfo", Value='
		<C> Col=SALT_AMT      Ctrl=medSALT_AMT_02      Param=text  </C>
		<C> Col=INCM_TAX      Ctrl=medINCM_TAX_02      Param=text  </C>
		<C> Col=CITI_TAX      Ctrl=medCITI_TAX_02      Param=text  </C>
		<C> Col=HINU_AMT      Ctrl=medHINU_AMT_02      Param=text  </C>
		<C> Col=NPEN_AMT      Ctrl=medNPEN_AMT_02      Param=text  </C>
		<C> Col=HINS_AMT      Ctrl=medHINS_AMT_02      Param=text  </C>
		<C> Col=SAV_AMT      Ctrl=medSAV_AMT_02      Param=text  </C>
		<C> Col=APP_AMT      Ctrl=medAPP_AMT_02      Param=text  </C>
		<C> Col=INV_AMT      Ctrl=medINV_AMT_02      Param=text  </C>
		<C> Col=DHLP_AMT      Ctrl=medDHLP_AMT_02      Param=text  </C>
		<C> Col=PPED_AMT      Ctrl=medPPED_AMT_02      Param=text  </C>
		<C> Col=OTHD_AMT      Ctrl=medOTHD_AMT_02      Param=text  </C>
		<C> Col=OLD_AMT       Ctrl=medOLD_AMT_02       Param=text  </C>
		<C> Col=CONT_AMT      Ctrl=medCONT_AMT_02      Param=text  </C>
		<C> Col=PAY_AMT       Ctrl=medPAY_AMT_02       Param=text  </C>
    '>
</object>

<!-- ��/�� MASTER ���̺� -->
<object id="bndT_CP_PAYMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_PAYMASTER">
    <Param Name="BindInfo", Value='
        <C> Col=BAS_AMT      Ctrl=medBAS_AMT1      Param=text  </C>
        <C> Col=DUTY_AMT     Ctrl=medDUTY_AMT1     Param=text  </C>
        <C> Col=WEL_AMT      Ctrl=medWEL_AMT1      Param=text  </C>
        <C> Col=OT_AMT       Ctrl=medOT_AMT1       Param=text  </C>
        <C> Col=OSE_AMT      Ctrl=medOSE_AMT1      Param=text  </C>
        <C> Col=LSEV_AMT     Ctrl=medLSEV_AMT1     Param=text  </C>
        <C> Col=RUN_AMT      Ctrl=medRUN_AMT1  	   Param=text  </C>
        <C> Col=MH_AMT       Ctrl=medMH_AMT1   	   Param=text  </C>
        <C> Col=ETC_AMT      Ctrl=medETC_AMT1      Param=text  </C>
        <C> Col=ETC_AMT2     Ctrl=medETC_AMT21     Param=text  </C>
        <C> Col=ETC_AMT3     Ctrl=medETC_AMT31     Param=text  </C>
        <C> Col=ETC_AMT4     Ctrl=medETC_AMT41     Param=text  </C>
        <C> Col=PPEN_AMT     Ctrl=medPPEN_AMT1     Param=text  </C>
        <C> Col=OTH_AMT      Ctrl=medOTH_AMT1      Param=text  </C>
        <C> Col=LAW_AMT      Ctrl=medLAW_AMT1      Param=text  </C>
        <C> Col=BNS_AMT      Ctrl=medBNS_AMT1      Param=text  </C>
        <C> Col=SCH_AMT      Ctrl=medSCH_AMT1      Param=text  </C>
        <C> Col=HOL_AMT      Ctrl=medHOL_AMT1      Param=text  </C>

        <C> Col=BAS_AMT      Ctrl=medBAS_AMT2      Param=text  </C>
        <C> Col=DUTY_AMT     Ctrl=medDUTY_AMT2     Param=text  </C>
        <C> Col=WEL_AMT      Ctrl=medWEL_AMT2      Param=text  </C>
        <C> Col=OT_AMT       Ctrl=medOT_AMT2       Param=text  </C>
        <C> Col=OSE_AMT      Ctrl=medOSE_AMT2      Param=text  </C>
        <C> Col=LSEV_AMT     Ctrl=medLSEV_AMT2     Param=text  </C>
        <C> Col=RUN_AMT      Ctrl=medRUN_AMT2  	   Param=text  </C>
        <C> Col=MH_AMT       Ctrl=medMH_AMT2   	   Param=text  </C>
        <C> Col=ETC_AMT      Ctrl=medETC_AMT2      Param=text  </C>
        <C> Col=PPEN_AMT     Ctrl=medPPEN_AMT2     Param=text  </C>
        <C> Col=OTH_AMT      Ctrl=medOTH_AMT2      Param=text  </C>

        <C> Col=POSITION_AMT      Ctrl=medPOSITION_AMT      Param=text  </C>

        <C> Col=INCM_TAX      Ctrl=medINCM_TAX      Param=text  </C>
        <C> Col=CITI_TAX      Ctrl=medCITI_TAX      Param=text  </C>
        <C> Col=HINU_AMT      Ctrl=medHINU_AMT      Param=text  </C>
        <C> Col=NPEN_AMT      Ctrl=medNPEN_AMT      Param=text  </C>
        <C> Col=HINS_AMT      Ctrl=medHINS_AMT      Param=text  </C>
        <C> Col=DHLP_AMT      Ctrl=medDHLP_AMT      Param=text  </C>
        <C> Col=PPED_AMT      Ctrl=medPPED_AMT      Param=text  </C>
        <C> Col=LON_RPY       Ctrl=medLON_RPY       Param=text  </C>
        <C> Col=LON_INT       Ctrl=medLON_INT       Param=text  </C>
        <C> Col=OTHD_AMT      Ctrl=medOTHD_AMT      Param=text  </C>
        <C> Col=LAB_AMT       Ctrl=medLAB_AMT       Param=text  </C>
        <C> Col=WOM_AMT       Ctrl=medWOM_AMT       Param=text  </C>
        <C> Col=SAV_AMT       Ctrl=medSAV_AMT       Param=text  </C>
        <C> Col=OLD_AMT       Ctrl=medOLD_AMT       Param=text  </C>
        <C> Col=CONT_AMT      Ctrl=medCONT_AMT      Param=text  </C>
        <C> Col=DRE_INTX      Ctrl=medDRE_INTX      Param=text  </C>
        <C> Col=DRE_CTTX      Ctrl=medDRE_CTTX      Param=text  </C>
        <C> Col=DRE_DFTX      Ctrl=medDRE_DFTX      Param=text  </C>
        <C> Col=YC_INT      Ctrl=medYC_INT      Param=text  </C>
        <C> Col=YC_CTT      Ctrl=medYC_CTT      Param=text  </C>
        <C> Col=ITXD_AMT      Ctrl=medITXD_AMT      Param=text  </C>
        <C> Col=ETC_AMT_AF      Ctrl=medETC_AMT_AF      Param=text  </C>

        <C> Col=ETC_AMT01      Ctrl=medETC_AMT01       Param=text  </C>
        <C> Col=ETC_AMT03      Ctrl=medETC_AMT03       Param=text  </C>
        <C> Col=SCH_AMT      Ctrl=medSCH_AMT       Param=text  </C>
        <C> Col=ETC_AMT_A6      Ctrl=medETC_AMT_A6       Param=text  </C>
    '>
</object>


<!-- ��/�� MASTER ���̺� -->
<object id="bndT_CP_PAYMASTER_01" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_PAYMASTER_01">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C> Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=ACC_NO       Ctrl=txtACC_NO       Param=value </C>
        <C> Col=SOU_CNT      Ctrl=txtSOU_CNT      Param=value </C>
        <C> Col=DFM_CNT      Ctrl=txtDFM_CNT      Param=value </C>
        <C> Col=TRB_CNT      Ctrl=txtTRB_CNT      Param=value </C>
        <C> Col=GOL_CNT      Ctrl=txtGOL_CNT      Param=value </C>
        <C> Col=WCT_CNT      Ctrl=txtWCT_CNT      Param=value </C>
        <C> Col=CHI_CNT      Ctrl=txtCHI_CNT      Param=value </C>
        <C> Col=SALT_AMT     Ctrl=medSALT_AMT     Param=text  </C>
        <C> Col=DDTT_AMT     Ctrl=medDDTT_AMT     Param=text  </C>
        <C> Col=PAY_AMT      Ctrl=medPAY_AMT      Param=text  </C>
    '>
</object>