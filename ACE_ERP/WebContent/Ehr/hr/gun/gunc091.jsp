<!--
*****************************************************
* @source       : gunc091.jsp
* @description : ���ϱٹ�������û ���� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2009/09/10      �幮��        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ϱٹ�������û����</title>
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
		var btnList = 'TTTTTFTT';
        var param = window.dialogArguments;
        var GUN_YMD  = param.gun_ymd
		var GUN_DPT  = param.req_no.substr(9,3);
		var REQ_NO   = param.req_no;
		var obj = new String();
		obj.app_cmt = "";
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc090.cmd.GUNC090CMD"
                                      + "&S_MODE=SHR"
                                      + "&HOL_YMD_SHR="+GUN_YMD
                                      + "&DPT_CD_SHR="+GUN_DPT;
			dsT_DI_HOLIDAYWORK.reset();

            //������ ��ȸ
            fnc_SearchApprover();
        }

        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=R";
            dsT_DI_APPROVAL.Reset();
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

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

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
        function fnc_SearchItemCheck(year) {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,15,"false","false")      // Grid Style ����

        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";


            //�������ڸ��� �� �ε�
            fnc_SearchList();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        //�Է� element
        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_HOL_HOUR"
                                        ,"cmbSTR_HOL_MIN"
                                        ,"cmbEND_HOL_HOUR"
                                        ,"cmbEND_HOL_MIN"
                                        ,"txtREMARK" );

        //���� �׸�
        var exceptionList = new Array(   "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");


		function fnc_InputDisabled() {
            document.getElementById("txtHOL_YMD_SHR").className = "input_ReadOnly";
            document.getElementById("txtHOL_YMD_SHR").readOnly = true;
            document.getElementById("txtHOL_YMD_SHR").innerText  = GUN_YMD.substring(0,4)+"-"+GUN_YMD.substring(4,6)+"-"+GUN_YMD.substring(6,8);


		}


        /**
         * ���縦 ó�� �Ѵ�.
         */
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

            var app_yn = "Y";    //����ϷῩ��

			if (kind == "�ΰ�") {
				app_yn = "N";
				window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			}

			dsT_DI_HOLIDAYWORK.UserStatus(1) = 1;
			dsT_DI_HOLIDAYWORK.NameValue(1,"REMARK") = obj.app_cmt;   // �����ǰ� Container

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc091.cmd.GUNC091CMD"
                                      + "&S_MODE=SAV_APP"
                                      + "&APP_YN="  +app_yn
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"R"
                                      + "&GUN_DPT=" +GUN_DPT
                                      + "&REQ_NO="  +REQ_NO;
			trT_DI_HOLIDAYWORK.post();
            //������� ��ȸ
            //fnc_SearchApprover();

		}

        /**
         * �ΰ��� ó�� �Ѵ�.

		function fnc_SubmitCancle(kind) {
            var obj = new String();
            var	row = "";
            var leno_no = dsT_DI_APPROVAL.NameValue(2,"ENO_NO");//�ֻ����� ����������
            var our_man = '<%=box.get("SESSION_ENONO")%>';

			if(leno_no != our_man){
	            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "N";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            row = "1"

            }else if(leno_no == our_man){
	            dsT_DI_APPROVAL.NameString(2, "APP_YN") = "N";  // 'R' ���, 'Y' ����, 'N' �ݷ�
	            row = "2"
            }

            window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != undefined){

				trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc091.cmd.GUNC091CMD"
	                                      + "&S_MODE=UPT_REJ"
	                                      + "&APP_YN="  +dsT_DI_APPROVAL.NameString(row, "APP_YN")
	                                      + "&GUN_YMD=" +dsT_DI_APPROVAL.NameString(row, "GUN_YMD")
	                                      + "&GUN_GBN=" +dsT_DI_APPROVAL.NameString(row, "GUN_GBN")
	                                      + "&GUN_DPT=" +dsT_DI_APPROVAL.NameString(row, "GUN_DPT")
	                                      + "&SEQ_NO="  +dsT_DI_APPROVAL.NameString(row, "SEQ_NO")
	                                      + "&REMARK="  +obj.app_cmt;
				trT_DI_HOLIDAYWORK.post();
            //������� ��ȸ
            fnc_SearchApprover();

           //     document.getElementById("btn_approval").style.display = "none";

            }

        }
*/

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_HOLIDAYWORK                                |
    | 3. Table List : T_DI_HOLIDAYWORK                           |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_HOLIDAY                                      |
    | 3. Table List : T_DI_HOLIDAY                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			                  |
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_HOLIDAYWORK)		  |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK)	                  |
    +--------------------------------------------------->
    <Object ID ="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_DI_HOLIDAYWORK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>


    <!-- ���缱 ��ȸ �� -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    	var SESSION_ENONO = '<%=box.get("SESSION_ENONO")%>';
		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");

		fnc_InputDisabled();


		// ������ ��� ������ ��� �����ڿ��� ����,�ΰ� �̹��� �����ֱ�
		for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
			var APP_YN = dsT_DI_APPROVAL.NameString(i, "APP_YN");
			var ENO_NO = dsT_DI_APPROVAL.NameString(i, "ENO_NO");

			if(ENO_NO == SESSION_ENONO && APP_YN == "") {
				fnc_ShowElement("imgApproval");
				fnc_ShowElement("imgRejection");
				dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
				break;
			}
		}
            document.getElementById("txtORD_NO").innerText      = dsT_DI_APPROVAL.NameValue(1, "REQ_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IENO_NM");
            document.getElementById("txtDPT_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
            document.getElementById("txtJOB_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IJOB_NM");

            document.getElementById("txtDPT_NM_SHR").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
            document.getElementById("txtDPT_CD_SHR").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_CD");

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnDataError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_HOLIDAYWORK event="OnSuccess()">
        fnc_SearchList();
		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_HOLIDAYWORK event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱٹ�������û����</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���ϱٹ�����ó��</font></td>
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
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('����');"></a>
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('�ΰ�');"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"            name="imgExit"      width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->
<!-- ���� ����  ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ����� ���� ���� -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
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
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="creamBold">�Ҽ�</td>
								<td class="padding2423">
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">����</td>
								<td class="padding2423">
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">�����</td>
								<td class="padding2423">
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ����� ���� �� -->
        </td>
        <td width="30">&nbsp;&nbsp;&nbsp;</td>
        <td>
        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='REQ_NO'		width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
								<C> id='ENO_NO'		width=100	name='���'		align=center	show=false</C>
            					<C> id='SEQ_NO'		width=50	name='����'		align=center	Value={DECODE(ENO_NO,'100019','����','����')}</C>
								<C> id='ENO_NM'		width=70	name='������'	align=center</C>
								<C> id='JOB_NM'		width=60	name='����'		align=center	</C>
                                <C> id='DPT_NM'		width=100	name='�μ�'		align=left		</C>
								<C> id='APP_YN'		width=160	name='�������'	align=left		Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&APP_YMD} </C>
								<C> id='REMARK1'	width=87	name='�ǰ�'		align=center 	Color='Blue'	</C>
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
<br>
<!-- ���� ����  �� -->
<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td align="center" >
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            	<colgroup>
                	<col width="100"></col>
                    <col width="120"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
					<td align="right" class="searchState">���ϱٹ�����&nbsp;</td>
                    <td class="padding2423">

                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="100" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input id="txtHOL_YMD_SHR" readonly size="10" maxLength="10" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" ></a>
                                </td>
                            </tr>
                   </table>

					</td>
                    <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                    <td class="padding2423">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="3" class="input_ReadOnly" readOnly>
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" ></a>
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				value="dsT_DI_HOLIDAYWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=39			name='NO'								align=center	value={String(Currow)}	</C>
								<C> id='JOB_NM'			width=70			name='����'								align=center													</C>
								<C> id='ENO_NO'			width=70			name='���'								align=center													</C>
								<C> id='ENO_NM'			width=70			name='����'								align=center													</C>
								<C> id='HOL_YMD'		width=90			name='�ٹ�����'							align=center													</C>
								<C> id='STR_TIME'		width=75			name='���۽ð�'							align=center													</C>
                                <C> id='END_TIME'		width=75			name='����ð�'						    align=center													</C>
                                <C> id='TOT_TIME'		width=75			name='�ѱٹ��ð�'						align=center													</C>
                                <C> id='REMARK'         width=200           name='�ٹ�����'                         align=left      Edit=none                  </C>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
            	<colgroup>
                	<col width="400"></col>
                    <col width="350"></col>
                    <col width="*"></col>
                </colgroup>
	<tr>
		<td class="paddingTop8">
			<table  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	  	<td class="paddingTop8">
	  		<table  border="0" cellspacing="0" cellpadding="0">
	  		  <tr>
				<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
				  * ���ϱٹ����ޱ���:����1��~���Ϻб��� �ݿ��޿��� ���� <br>
				  * �Է±Ⱓ:���������� <br>
				  * ���ϱٹ��ð� : 4 ~ 8 �ð� ����<br></font>
				</td>
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

