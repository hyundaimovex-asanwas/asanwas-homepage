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
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
<script language="javascript">

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
        if( document.getElementById("txtENO_NO").value == '') {
				alert("����� �Է����ּ���.");
				document.getElementById("txtENO_NO").focus();
				return false;
			}
			 if( document.getElementById("txtENO_NM").value == '') {
				alert("�̸��� �Է����ּ���.");
				document.getElementById("txtENO_NM").focus();
				return false;
			}

			if( document.getElementById("txtCET_NO").value == '') {
				alert("�ֹι�ȣ�� �Է����ּ���.");
				document.getElementById("txtCET_NO").focus();
				return false;
			}

			trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_05&ENO_NO="+document.getElementById("txtENO_NO").value+"&ENO_NM="+document.getElementById("txtENO_NM").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
            trT_CM_PERSON.post();


            var Empty = dsT_CM_PERSON.CountRow;


             if(  Empty == 0 ) {
				alert("����� �ٸ��ϴ�. \n�ٽ� �Է����ּ���.");
				document.getElementById("txtENO_NO").value='';
				document.getElementById("txtENO_NO").focus();
 				return false;
			}


			if( dsT_CM_PERSON.NameValue(1,"NAME") != document.getElementById("txtENO_NM").value ) {
				alert("�̸��� �ٸ��ϴ�. \n�ٽ� �Է����ּ���.");
				document.getElementById("txtENO_NM").value='';
				document.getElementById("txtENO_NM").focus();
				return false;
			}
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


       if(document.getElementById("txtEM_PHN_NO").value ==''){
       alert("��ȭ��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�. ���������η� �����Ͽ� ��й�ȣ�� �ʱ�ȭ �Ͻñ� �ٶ��ϴ�.");
       return false;
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

			form1.txtENO_NO.focus();
        }


        /********************************************************
         * ��Ÿ�Լ�                                             *
         *******************************************************/
         function fnc_Random(){

            trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=UPT_05&ENO_NO="+document.getElementById("txtENO_NO").value;
            trT_CM_PERSON.post();
            alert("������ȣ�� ��ϵ� �ڵ������� ���۵Ǿ����ϴ�. Ȯ�� �� ������ȣ�� �Է��� �ּ���");

            document.getElementById("txtCER_NO").focus();
         }

         function fnc_Confirm(){

            trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
            trT_CM_PERSON.post();

         if( document.getElementById("txtSMS_NUMBER").value != document.getElementById("txtCER_NO").value ) {
    		 alert("������ȣ�� �ٸ��ϴ�. �ٽ� Ȯ���Ͽ� �ֽñ� �ٶ��ϴ�.");
			 return false;
			}
		 else{
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
		<td height="25" background="/images/common/barBg.gif"><!-- Ÿ��Ʋ �� ���̺� ���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">��й�ȣ �ʱ�ȭ</td>
			</tr>
		</table>
		<!-- Ÿ��Ʋ �� ���̺� �� --></td>
	</tr>
	<tr>
		<!-- ��ư -->
		<td height="35" align="right" class="paddingTop5">
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)">
		<img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0"
		align="absmiddle" onClick="fnc_SearchItem()"></a>
		<a href="#" onMouseOut="MM_swapImgRestore()"
			onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img
			src="/images/button/btn_ExitOn.gif" name="Image4" width="60"
			height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>

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
									src="/images/specialHr/iconPc.gif"></td>
								<td>
                            	<table width="300" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;">
										<img src="/images/specialHr/arrowGreen.gif" width="8"
											height="15" align="absmiddle"> �� &nbsp �� </td><td> <input
											type="text"	 id=txtENO_NO value="" size="20" maxlength=10
											style="ime-mode:disabled" class="divInput"></td>
									</tr>
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;">
										<img src="/images/specialHr/arrowGreen.gif" width="8"
											height="15" align="absmiddle"> �� &nbsp ��</td><td>  <input
											type="text"	 id=txtENO_NM value="" size="20"
											maxlength=10 style="ime-mode:auto" class="divInput">

										</td>
									</tr>
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;padding-bottom:10px;">
										<img src="/images/specialHr/arrowGreen.gif" width="8"
										    height="15" align="absmiddle"> �ֹι�ȣ</td><td>   <input
										    type="text"	id=txtCET_NO value="" size="20" maxlength=14
									          style="ime-mode:disabled" class="divInput" onKeyPress="JavaScript: cfCetNoHyphen(this);"></td>
								    	</tr>
          						</table>
	    					</td>
		    			</tr>
			    	</table>
			   	</td>
			 </tr>
		 </table>
                  <tr>
                      <td>
                              <div id="layer_1" style="position:absolute; display:none; width:477px; z-index:1;">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                 <tr>
                                    <td height="27" class="hrTextGreen" align="left" style="padding-top:5px;padding-bottom:10px;">
                                      &nbsp<img src="images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle" >
                                      <input type="text"   id=txtEM_PHN_NO value="" size="13"  maxlength=14 style="ime-mode:disabled" class="input_ReadOnly"> ��ȣ�� ������ȣ�� �����մϴ�.
                                      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_IssueOver.gif',1)">
                                      <img src="images/button/btn_IssueOn.gif" name="imgSearch" width="60" height="20" border="0"
                                       align="absmiddle" onClick="fnc_Random()"></a></td>
                                  </tr>
                                  <br>
                                  <tr>
                                        <td height="1" background="/images/specialHr/dot.gif"></td>
                                    </tr>
                                  <tr>

                                      <td height="27" class="hrTextGreen" align="left" style="padding-top:5px;padding-bottom:10px;">
                                       &nbsp<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> ������ȣ
                                       <input type="text"  id=txtCER_NO value="" size="20" maxlength=14 style="ime-mode:disabled" class="divInput">&nbsp
                                       <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_ConfirmOver.gif',1)">
                                       <img src="/images/button/btn_ConfirmOn.gif" name="imgSearch" width="60" height="20" border="0"
                                       align="absmiddle" onClick="fnc_Confirm()"></a></td>

                                       <td class="padding2423" colspan="7">
                                       <input type=hidden id="txtSMS_NUMBER">
                                       </td>
                                    </tr>
                                </table>
                              </div>


                            </td>
                          </tr>
                       </table>
					</td>
			</tr>



		<!--�����������̺� �� --></td>
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
        <C>Col=EM_PHN_NO          Ctrl=txtEM_PHN_NO             Param=value     </C>
        <C>Col=SMS_NUMBER          Ctrl=txtSMS_NUMBER             Param=value     </C>

    '>
</object>
