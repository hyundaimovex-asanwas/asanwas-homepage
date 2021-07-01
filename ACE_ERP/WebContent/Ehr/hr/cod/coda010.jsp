<!--
    ******************************************************************
    * @Source              : coda010.jsp                                                                       *
    * @Description        : ȸ�������Է�                                                                                          *
    * @Font                   :                                                                                      *
    * @Developer Desc :                                                                                          *
    *******************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                               *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�															   *
    *******************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

<title>ȸ�������Է�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->

<script language="javascript" >

  

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

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
        	
			if(fnc_SaveItemCheck()) {
				
				trT_CM_COMPANY.KeyValue = "SVL(I:dsT_CM_COMPANY=dsT_CM_COMPANY)";
				trT_CM_COMPANY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.a.coda010.cmd.CODA010CMD&S_MODE=SAV";
				trT_CM_COMPANY.post();
				
			} else {
				return;
			}
			
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
        	
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CM_COMPANY.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

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
        	
   			var f = document.form1;

			//DataSet�� ���� ���� Ȯ��
			if (!dsT_CM_COMPANY.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 1;//row�� �ϳ����̴�.
			var oGUBUN, oGUBUN_NM, oCOMP_NM, oPRESIDENT_NM, oTAX_NO, oCORP_NO, oCAPITAL_TOT, oSTR_YMD, oACC_STDT, oACC_ENDT, oPAY_DAY;

			oGUBUN = dsT_CM_COMPANY.NameValue(i,"GUBUN");
			if(oGUBUN.trim() == ""){
				alert("ȸ������� �Է����ּ���." );
				document.getElementById("txtGUBUN").focus();
				return false;
			}

			oGUBUN_NM = dsT_CM_COMPANY.NameValue(i,"GUBUN_NM");
			if(oGUBUN_NM.trim() == ""){
				alert("ȸ��������� �Է����ּ���." );
				document.getElementById("txtGUBUN_NM").focus();
				return false;
			}

			oCOMP_NM = dsT_CM_COMPANY.NameValue(i,"COMP_NM");
			if(oCOMP_NM.trim() == ""){
				alert("ȸ����� �Է����ּ���." );
				document.getElementById("txtCOMP_NM").focus();
				return false;
			}

			oPRESIDENT_NM = dsT_CM_COMPANY.NameValue(i,"PRESIDENT_NM");
			if(oPRESIDENT_NM.trim() == ""){
				alert("��ǥ�ڸ��� �Է����ּ���." );
				document.getElementById("txtPRESIDENT_NM").focus();
				return false;
			}

			oTAX_NO = dsT_CM_COMPANY.NameValue(i,"TAX_NO");
			if(oTAX_NO.trim().length != 10){
				alert("����ڹ�ȣ�� ����(XXX-XX-XXXXX)�� �°� �Է����ּ���." );
				document.medTAX_NO.Focus();
				return false;
			}

			oCORP_NO = dsT_CM_COMPANY.NameValue(i,"CORP_NO");
			if(oCORP_NO.trim().length != 13){
				alert("���ε�Ϲ�ȣ�� ����(XXXXXX-XXXXXXX)�� �°� �Է����ּ���." );
				document.medCORP_NO.Focus();
				return false;
			}

			oCAPITAL_TOT = dsT_CM_COMPANY.NameValue(i,"CAPITAL_TOT");
			if(oCAPITAL_TOT.toString().trim().length == 0 || oCAPITAL_TOT == 0){
				alert("�ں��Ѱ踦 �Է����ּ���." );
				document.getElementById("txtCAPITAL_TOT").focus();
				return false;
			}

			oSTR_YMD = dsT_CM_COMPANY.NameValue(i,"STR_YMD");
			if(!cfDateExpr(oSTR_YMD) && oSTR_YMD.trim().length != 0){
				alert("ȸ�缳������  �߸��Ǿ����ϴ�." );
				document.getElementById("txtSTR_YMD").focus();
				return false;
			}

			oACC_STDT = dsT_CM_COMPANY.NameValue(i,"ACC_STDT");
			if(!cfDateExpr(oACC_STDT) && oACC_STDT.trim().length != 0){
				alert("ȸ��Ⱓ�������� �߸��Ǿ����ϴ�." );
				document.getElementById("txtACC_STDT").focus();
				return false;
			}

			oACC_ENDT = dsT_CM_COMPANY.NameValue(i,"ACC_ENDT");
			if(!cfDateExpr(oACC_ENDT) && oACC_ENDT.trim().length != 0){
				alert("ȸ��Ⱓ�������� �߸��Ǿ����ϴ�." );
				document.getElementById("txtACC_ENDT").focus();
				return false;
			}

			oACC_STDT = parseInt(oACC_STDT.replaceStr("-",""));
			oACC_ENDT = parseInt(oACC_ENDT.replaceStr("-",""));
			if(oACC_STDT > oACC_ENDT){
				alert("�������� �����Ϻ��� �����ϴ�." );
				document.getElementById("txtACC_ENDT").focus();
				return false;
			}

			oPAY_DAY = dsT_CM_COMPANY.NameValue(i,"PAY_DAY");
			if(!(oPAY_DAY > 0 && oPAY_DAY <= 31)){
				alert("�޿��������� �߸��Ǿ����ϴ�." );
				document.getElementById("txtPAY_DAY").focus();
				return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	
            //Grid Style ����
            //cfStyleGrid(form1.grdT_EV_KPIPOOL,15,"false","right");

            //form load�� ������ �������� ��ȸ
            var f = document.form1;
            
			//if (!valid(form1)) return;//Validation ����
			try {
				
				dsT_CM_COMPANY.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.a.coda010.cmd.CODA010CMD&S_MODE=SHR";
				dsT_CM_COMPANY.Reset();

				//���� ���� ���ٸ� �����ϱ� ���� row�߰�
				if(dsT_CM_COMPANY.CountRow == 0){
					dsT_CM_COMPANY.AddRow();
					//�ű��ۼ��϶� ȸ�豸������ ��Ŀ��
           			document.getElementById("txtGUBUN").focus();
				}else{//���� ���� �ִٸ� ���´�.

				// ��ȭ��ȣ�� �ѽ���ȣ "-" ���ִ޶�� �䱸�������� ���úκ� ����

	            }
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CM_COMPANY                                  |
    | 3. Table List : T_CM_COMPANY                                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMPANY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CM_COMPANY                                    |
    | 3. Table List : T_CM_COMPANY                                 |
    +----------------------------------------------->
    <Object ID ="trT_CM_COMPANY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMPANY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMPANY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMPANY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CM_COMPANY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CM_COMPANY event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
            <table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" bgcolor="">
				<colgroup>
					<col width="100"></col>
					<col width="400"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">ȸ�����</td>
					<td class="padding2423"><input id="txtGUBUN" style="width:50" maxlength="2"></td>
					<td align="center" class="blueBold">ȸ�������</td>
					<td class="padding2423"><input id="txtGUBUN_NM" style="width:100%" maxlength="100"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">ȸ���</td>
					<td class="padding2423"><input id="txtCOMP_NM" style="width:100%" maxlength="100"></td>
					<td align="center" class="blueBold">ȸ���(����)</td>
					<td class="padding2423"><input id="txtCOMP_ENM" style="width:100%" maxlength="100"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">��ǥ��</td>
					<td class="padding2423"><input id="txtPRESIDENT_NM" style="width:100%" maxlength="50"></td>
					<td align="center" class="blueBold">��ǥ��(����)</td>
					<td class="padding2423"><input id="txtPRESIDENT_ENM" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">����ڹ�ȣ</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medTAX_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:50%">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode						value=true>
							<param name=DisabledBackColor			value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=Format						value="000-00-00000">
							<param name=IsComma					value=false>
							<param name=Language					value=0>
							<param name=Numeric						value=false>
							<param name=PromptChar					value=" ">
							<param name=ShowLiteral					value="false">
							<param name=Visible							value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">���ε�Ϲ�ȣ</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medCORP_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:50%">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode						value=true>
							<param name=DisabledBackColor			value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=Format						value="000000-0000000">
							<param name=IsComma					value=false>
							<param name=Language					value=0>
							<param name=Numeric						value=false>
							<param name=PromptChar					value=" ">
							<param name=ShowLiteral					value="false">
							<param name=Visible							value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423"><input id="txtBUSI_COND" style="width:100%" maxlength="50"></td>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423"><input id="txtBUSI_ITEM" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">�ּ�</td>
					<td class="padding2423" colspan="3">
						<input id="txtPOST_NO" style="width:60" class="input_ReadOnly" readonly maxlength="7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_postPopup('txtPOST_NO','txtADDRESS_HD')"></a>
						<input id="txtADDRESS_HD" style="width:281" class="input_ReadOnly" readonly>
						<input id="txtADDRESS_DT" style="width:310" maxlength="100">
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">��ȭ��ȣ</td>
					<td class="padding2423"><input id="txtTEL_NO" style="width:100%" maxlength="15"></td>
					<td align="center" class="blueBold">�ѽ���ȣ</td>
					<td class="padding2423"><input id="txtFAX_NO" style="width:100%" maxlength="15"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">URL</td>
					<td class="padding2423"><input id="txtCOMP_URL" style="width:100%" maxlength="50"></td>
					<td align="center" class="blueBold">Ȩ�ý�ID</td>
					<td class="padding2423"><input id="txtHOMETAX_ID" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">��������</td>
					<td class="padding2423">
						<select id="cmbCORP_KIND" style="width:100%" >
							<option value="" >����</option>
							<option value="1" >1.�߼ұ��</option>
							<option value="2" >2.�� ��</option>
							<option value="3" >3.�� ��</option>
							<option value="4" >4.������������</option>
							<option value="5" >5.�� ��</option>
							<option value="6" >6.�񿵸�</option>
							<option value="7" >7.�� ��</option>
						</select>
					</td>
					<td align="center" class="blueBold">���α���</td>
					<td class="padding2423">
						<select id="cmbCORP_GBN" style="width:100%">
							<option value="" >����</option>
							<option value="1" >1.��������</option>
							<option value="2" >2.�ܱ�����</option>
							<option value="3" >3.��������</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">����������</td>
					<td class="padding2423">
						<select id="cmbLOCATION_GBN" style="width:100%">
							<option value="" >����</option>
							<option value="1" >1.Ư����</option>
							<option value="2" >2.������</option>
							<option value="3" >3.��</option>
							<option value="4" >4.��</option>
						</select>
					</td>
					<td align="center" class="blueBold">���Ҽ�����</td>
					<td class="padding2423">
						<select id="cmbTAX_OFFICE" style="width:100%">
							<option value="" >����</option>
							<option value="����" >(101) ����</option>
							<option value="���빮" >(104) ���빮</option>
							<option value="����" >(105) ����</option>
							<option value="���" >(106) ���</option>
							<option value="������" >(107) ������</option>
							<option value="����" >(108) ����</option>
							<option value="����" >(109) ����</option>
							<option value="���빮" >(110) ���빮</option>
							<option value="����" >(113) ����</option>
							<option value="����" >(114) ����</option>
							<option value="��õ" >(117) ��õ</option>
							<option value="��õ" >(119) ��õ</option>
							<option value="�Ｚ" >(120) �Ｚ</option>
							<option value="��õ" >(121) ��õ</option>
							<option value="����õ" >(122) ����õ</option>
							<option value="�Ⱦ�" >(123) �Ⱦ�</option>
							<option value="����" >(124) ����</option>
							<option value="����" >(125) ����</option>
							<option value="��õ" >(126) ��õ</option>
							<option value="������" >(127) ������</option>
							<option value="���" >(128) ���</option>
							<option value="����" >(129) ����</option>
							<option value="��õ" >(130) ��õ</option>
							<option value="����õ" >(131) ����õ</option>
							<option value="������" >(132) ������</option>
							<option value="�Ȼ�" >(134) �Ȼ�</option>
							<option value="������" >(135) ������</option>
							<option value="����õ" >(137) ����õ</option>
							<option value="���Ⱦ�" >(138) ���Ⱦ�</option>
							<option value="����" >(140) ����</option>
							<option value="����" >(141) ����</option>
							<option value="�ߺ�" >(201) �ߺ�</option>
							<option value="���빮" >(204) ���빮</option>
							<option value="����" >(206) ����</option>
							<option value="����" >(209) ����</option>
							<option value="����" >(210) ����</option>
							<option value="����" >(211) ����</option>
							<option value="����" >(212) ����</option>
							<option value="����" >(214) ����</option>
							<option value="����" >(215) ����</option>
							<option value="���" >(217) ���</option>
							<option value="����" >(220) ����</option>
							<option value="��õ" >(221) ��õ</option>
							<option value="��ô" >(222) ��ô</option>
							<option value="ȫõ" >(223) ȫõ</option>
							<option value="����" >(224) ����</option>
							<option value="����" >(225) ����</option>
							<option value="����" >(226) ����</option>
							<option value="����" >(227) ����</option>
							<option value="û��" >(301) û��</option>
							<option value="����" >(302) ����</option>
							<option value="����" >(303) ����</option>
							<option value="��õ" >(304) ��õ</option>
							<option value="����" >(305) ����</option>
							<option value="����" >(307) ����</option>
							<option value="���" >(308) ���</option>
							<option value="ȫ��" >(310) ȫ��</option>
							<option value="����" >(311) ����</option>
							<option value="õ��" >(312) õ��</option>
							<option value="����" >(313) ����</option>
							<option value="������" >(314) ������</option>
							<option value="����" >(316) ����</option>
							<option value="����" >(401) ����</option>
							<option value="����" >(402) ����</option>
							<option value="�ͻ�" >(403) �ͻ�</option>
							<option value="����" >(404) ����</option>
							<option value="����" >(407) ����</option>
							<option value="����" >(408) ����</option>
							<option value="�ϱ���" >(409) �ϱ���</option>
							<option value="������" >(410) ������</option>
							<option value="����" >(411) ����</option>
							<option value="����" >(412) ����</option>
							<option value="�س�" >(415) �س�</option>
							<option value="��õ" >(416) ��õ</option>
							<option value="����" >(417) ����</option>
							<option value="���뱸" >(502) ���뱸</option>
							<option value="���뱸" >(503) ���뱸</option>
							<option value="�ϴ뱸" >(504) �ϴ뱸</option>
							<option value="����" >(505) ����</option>
							<option value="����" >(506) ����</option>
							<option value="����" >(507) ����</option>
							<option value="�ȵ�" >(508) �ȵ�</option>
							<option value="��õ" >(510) ��õ</option>
							<option value="����" >(511) ����</option>
							<option value="����" >(512) ����</option>
							<option value="����" >(513) ����</option>
							<option value="���뱸" >(514) ���뱸</option>
							<option value="���" >(515) ���</option>
							<option value="�ߺλ�" >(602) �ߺλ�</option>
							<option value="���λ�" >(603) ���λ�</option>
							<option value="�λ���" >(605) �λ���</option>
							<option value="�Ϻλ�" >(606) �Ϻλ�</option>
							<option value="����" >(607) ����</option>
							<option value="����" >(608) ����</option>
							<option value="â��" >(609) â��</option>
							<option value="���" >(610) ���</option>
							<option value="��â" >(611) ��â</option>
							<option value="�뿵" >(612) �뿵</option>
							<option value="����" >(613) ����</option>
							<option value="����" >(615) ����</option>
							<option value="����" >(616) ����</option>
							<option value="����" >(617) ����</option>
							<option value="�����" >(620) �����</option>
							<option value="����" >(621) ����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">���ұ�û</td>
					<td class="padding2423" colspan="3"><input id="txtWARD_OFFICE" style="width:39%" maxlength="100"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td class="paddingTop8">
            <table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" bgcolor="">
				<colgroup>
					<col width="100"></col>
					<col width="200"></col>
					<col width="100"></col>
					<col width="120"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">�ں��Ѱ�</td>
					<td>
						<table width="100%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medCAPITAL_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode						value=true>
										<param name=DisabledBackColor			value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength					value=12>
										<param name=Numeric						value=true>
										<param name=ShowLiteral					value="false">
										<param name=Visible							value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td align="left">��</td>
							</tr>
						</table>
					</td>
					<td align="center" class="blueBold">��������</td>
					<td>
						<table width="100%" border="0" >
							<tr>
								<td width="70%">
									<comment id="__NSID__"><object id="medEMPLOYEE_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode						value=true>
										<param name=DisabledBackColor			value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength					value=6>
										<param name=Numeric						value=true>
										<param name=ShowLiteral					value="false">
										<param name=Visible							value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td align="left">��</td>
							</tr>
						</table>
					</td>
					<td align="center" class="blueBold">ȸ�缳����</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:70%;padding-left:20" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','625','205');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">ȸ��Ⱓ</td>
					<td class="padding2423" colspan="3">
						<input id="txtACF_QUT" style="width:30;text-align:right" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">&nbsp;��&nbsp;&nbsp;
						<input id="txtACC_STDT" style="width:100;padding-left:20"  maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtACC_STDT','','150','230');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle"></a>
						&nbsp;~&nbsp;
						<input id="txtACC_ENDT" style="width:100;padding-left:20" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn4','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtACC_ENDT','','305','230');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn4" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
					<td align="center" class="blueBold">�޿�������</td>
					<td class="padding2423">�ſ�&nbsp;<input id="txtPAY_DAY" style="width:30;text-align:right" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">&nbsp;��</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


    <!--**************************************************************************************
    *                                                                                                                                                          *
    *  Non Visible Component �����(Bind Component)                                                                            				*
    *                                                                                                                                                          *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_CM_COMPANY                                   |
    | 3. Table List : T_CM_COMPANY                                 |
    +----------------------------------------------->
	<object id="bndT_CM_COMPANY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   		Value="dsT_CM_COMPANY">
		<Param Name="BindInfo", 		Value="
			<C>Col='GUBUN'						Ctrl='txtGUBUN'					Param=value</C>
			<C>Col='GUBUN_NM'					Ctrl='txtGUBUN_NM'				Param=value</C>
			<C>Col='COMP_NM'					Ctrl='txtCOMP_NM'				Param=value</C>
			<C>Col='COMP_ENM'					Ctrl='txtCOMP_ENM'				Param=value</C>
			<C>Col='PRESIDENT_NM'			Ctrl='txtPRESIDENT_NM'			Param=value</C>
			<C>Col='PRESIDENT_ENM'			Ctrl='txtPRESIDENT_ENM'		Param=value</C>
			<C>Col='TAX_NO'						Ctrl='medTAX_NO'				Param=text	</C>
			<C>Col='CORP_NO'					Ctrl='medCORP_NO'				Param=text	</C>
			<C>Col='BUSI_COND'					Ctrl='txtBUSI_COND'				Param=value</C>
			<C>Col='BUSI_ITEM'					Ctrl='txtBUSI_ITEM'				Param=value</C>
			<C>Col='POST_NO'					Ctrl='txtPOST_NO'					Param=value</C>
			<C>Col='ADDRESS_HD'				Ctrl='txtADDRESS_HD'			Param=value</C>
			<C>Col='ADDRESS_DT'				Ctrl='txtADDRESS_DT'			Param=value</C>
			<C>Col='TEL_NO'						Ctrl='txtTEL_NO'					Param=value</C>
			<C>Col='FAX_NO'						Ctrl='txtFAX_NO'					Param=value</C>
			<C>Col='COMP_URL'					Ctrl='txtCOMP_URL'				Param=value</C>
			<C>Col='HOMETAX_ID'				Ctrl='txtHOMETAX_ID'			Param=value</C>
			<C>Col='CORP_KIND'					Ctrl='cmbCORP_KIND'			Param=value</C>
			<C>Col='CORP_GBN'					Ctrl='cmbCORP_GBN'				Param=value</C>
			<C>Col='LOCATION_GBN'			Ctrl='cmbLOCATION_GBN'		Param=value</C>
			<C>Col='TAX_OFFICE'				Ctrl='cmbTAX_OFFICE'			Param=value</C>
			<C>Col='WARD_OFFICE'				Ctrl='txtWARD_OFFICE'			Param=value</C>
			<C>Col='CAPITAL_TOT'				Ctrl='medCAPITAL_TOT'			Param=text	</C>
			<C>Col='EMPLOYEE_TOT'			Ctrl='medEMPLOYEE_TOT'		Param=text	</C>
			<C>Col='STR_YMD'					Ctrl='txtSTR_YMD'				Param=value</C>
			<C>Col='ACF_QUT'					Ctrl='txtACF_QUT'					Param=value</C>
			<C>Col='ACC_STDT'					Ctrl='txtACC_STDT'				Param=value</C>
			<C>Col='ACC_ENDT'					Ctrl='txtACC_ENDT'				Param=value</C>
			<C>Col='PAY_DAY'					Ctrl='txtPAY_DAY'					Param=value</C>
	    ">
	</object>
