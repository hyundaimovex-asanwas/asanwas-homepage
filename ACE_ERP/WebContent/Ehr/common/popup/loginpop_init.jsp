<!--
    ************************************************************************************
    * @Source         : loginPop.jsp 					                               *
    * @Description    : ����� ��й�ȣ ����                                           *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/10  |  �����   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>


<html>
<head>
<title>��й�ȣ �ʱ�ȭ(loginPop)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../css/style.css" rel="stylesheet" type="text/css">
<link href="../../css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="../../common/common.js"></script>
<script language=javascript src="../../common/mdi_common.js"></script>
<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
<script language="javascript">

		var retObj = window.dialogArguments;




        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'F' + 'F' + 'T' + 'F' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        if ( !fnc_SearchItemCheck() ) return;

			dsT_CM_PERSON.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;

			//Ʈ����� ����
			trT_CM_PERSON.KeyValue = "SAV(I:SAV=dsT_CM_PERSON)";
			trT_CM_PERSON.Action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_05";
			trT_CM_PERSON.Post();


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

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew(p_gbn) {

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

	        if (dsT_CM_PERSON.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {



			if( document.getElementById("txtCET_NO").value == '') {
				alert("�ֹι�ȣ�� �Է����ּ���.");
				document.getElementById("txtCET_NO").focus();
				return false;
			}

			trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_05&ENO_NO="+document.getElementById("txtENO_NO").value+"&ENO_NM="+document.getElementById("txtENO_NM").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
            trT_CM_PERSON.post();


            var Empty = dsT_CM_PERSON.CountRow;


			if( dsT_CM_PERSON.NameValue(1,"CET_NO") != document.getElementById("txtCET_NO").value) {
				alert("�ֹι�ȣ�� �ٸ��ϴ�. \n�ٽ� �Է����ּ���.");
				document.getElementById("txtCET_NO").value='';
				document.getElementById("txtCET_NO").focus();
				return false;
			}


       if(Empty!= 0 && dsT_CM_PERSON.NameValue(1,"NAME") == document.getElementById("txtENO_NM").value && dsT_CM_PERSON.NameValue(1,"CET_NO") == document.getElementById("txtCET_NO").value && document.getElementById("txtEM_PHN_NO").value !='')
        {
              document.getElementById("layer_1").style.display='';
        }




			return true;

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

			//alert(retObj.ks_id);
            document.getElementById("txtENO_NO").innerText = retObj.ks_id;

            trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            
            //trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
 
            //trT_CM_PERSON.action = "/../../servlet/common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
            
			//gctr_code01.Action = "/servlet/pms.menu.ct.a010001_t1?";
            //trT_CM_PERSON.action = "../../servlets/common.ipcheck";			
            //trT_CM_PERSON.action = "../../servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;

           //trT_CM_PERSON.action = "../../servlets/common.groupware.GroupWareServlet?ENO_NO=hda1990098";

            //prompt(this, trT_CM_PERSON.action);   
            trT_CM_PERSON.action = "../../servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
            
            trT_CM_PERSON.post();
            //document.getElementById("txtENO_NM").innerText = dsT_CM_PERSON.NameValue(1,"CNT");
            document.getElementById("txtENO_NM").innerText = dsT_CM_PERSON.NameValue(1,"NAME");

			form1.txtCET_NO.focus();
        }


        /********************************************************
         * ��Ÿ�Լ�                                             *
         *******************************************************/

         function fnc_Confirm(){

            trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_07&ENO_NO="+document.getElementById("txtENO_NO").value;
            trT_CM_PERSON.post();

			if( dsT_CM_PERSON.NameValue(1,"CET_NO") != document.getElementById("txtCET_NO").value) {
				alert("�ֹι�ȣ�� Ʋ���ϴ�.\n��Ȯ�� �ֹι�ȣ 13�ڸ��� �Է����ּ���.");
				document.getElementById("txtCET_NO").value='';
				document.getElementById("txtCET_NO").focus();
			}else{
	    		 trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
	             trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=UPT_06&ENO_NO="+document.getElementById("txtENO_NO").value;
	             trT_CM_PERSON.post();
	             alert("��й�ȣ�� �ֹι�ȣ �� 7�ڸ��� �ʱ�ȭ �Ǿ����ϴ�.");
	             window.close();
	    		 return false;

	    		}

         }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



<!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->

    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


<!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->



<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
<Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

<Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

<!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
<Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

<Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

<!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
<script for=trT_CM_PERSON event="OnSuccess()">

        if(trT_CM_PERSON.KeyValue.substring(0,3) == "SHR_05"){
			alert('������ Ȯ�εǾ����ϴ�.');
			window.close();
		}

    </script>

<!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
<script for=trT_CM_PERSON event="OnFail()">

        alert(trT_CM_PERSON.ErrorMsg);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form ���� -->
<form name="form1">
<table width="300" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif"><!-- Ÿ��Ʋ �� ���̺� ���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
				<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">��й�ȣ �ʱ�ȭ</td>
			</tr>
		</table>
		<!-- Ÿ��Ʋ �� ���̺� �� --></td>
	</tr>
	<tr>
		<!-- ��ư -->
		<td height="35" align="right" class="paddingTop5">
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_ConfirmOver.gif',1)">
		<img src="../../images/button/btn_ConfirmOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>

		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExitOver.gif',1)">
		<img src="../../images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>

		</td>
	</tr>
	<tr>
		<td height="125"><!--�����������̺� �� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="400" align="center" valign="middle">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="hrWtable" style="padding:0 26 0 14">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="74" style="padding:0 19 0 0"><img
									src="../../images/specialHr/iconPc.gif"></td>
								<td>
                            	<table width="300" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;">
										<img src="../../images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> �� &nbsp ��
										</td>
										<td>
										<input type="text"	 id=txtENO_NO value="" size="20" maxlength=10 style="ime-mode:disabled" class="divInput">
										</td>
									</tr>
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;">
										<img src="../../images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> �� &nbsp ��
										</td>
										<td>
										<input type="text"	 id=txtENO_NM value="" size="20" maxlength=10 style="ime-mode:auto" class="divInput">
										</td>
									</tr>
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;padding-bottom:10px;">
										<img src="../../images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> �ֹι�ȣ
										</td>
										<td>
										    <input type="text"	id=txtCET_NO value="" size="20" maxlength=14
									          style="ime-mode:disabled" class="divInput" onKeyPress="JavaScript: cfCetNoHyphen(this);">
									    </td>
								    	</tr>
          						</table>
	    					</td>
		    			</tr>
			    	</table>
			   	</td>
			 </tr>
		 </table>


		<!--�����������̺� �� -->
		</td>
	</tr>
</table>
</form>
</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->

<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=EM_PHN_NO           Ctrl=txtEM_PHN_NO              Param=value     </C>
        <C>Col=SMS_NUMBER          Ctrl=txtSMS_NUMBER             Param=value     </C>

    '>
</object>


