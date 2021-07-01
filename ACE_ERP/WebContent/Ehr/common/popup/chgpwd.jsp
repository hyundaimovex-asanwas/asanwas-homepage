<!--
    ************************************************************************************
    * @Source         : chgpwd.jsp 					                                 *
    * @Description    : ����� ��й�ȣ ����.           *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/10  |  ���ؼ�   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>����� ��й�ȣ ����(chgpwd)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

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

            //������й�ȣ ��ȸ
            trT_CM_EMPLIST.KeyValue = "SHR(O:dsT_CM_EMPLIST=dsT_CM_EMPLIST)";
            trT_CM_EMPLIST.Action = "/servlet/GauceChannelSVL?cmd=common.popup.chgpwd.cmd.CHGPWDCMD&S_MODE=SHR&txtENO_NO="+document.getElementById("txtENO_NO").value;
            trT_CM_EMPLIST.Post();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			if( !fnc_SaveItemCheck() ) return;

            //
            if (confirm("��й�ȣ�� ���� �Ͻðڽ��ϱ�?") == false) return;

			dsT_CM_EMPLIST.NameValue(1,"PWD_NO") = document.getElementById("txtNEW_PWD_NO").value;

			//Ʈ����� ����
			trT_CM_EMPLIST.KeyValue = "SAV(I:SAV=dsT_CM_EMPLIST)";
			trT_CM_EMPLIST.Action = "/servlet/GauceChannelSVL?cmd=common.popup.chgpwd.cmd.CHGPWDCMD&S_MODE=SAV";
			trT_CM_EMPLIST.Post();

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

	        if (dsT_CM_EMPLIST.IsUpdated)  {

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

			if( document.getElementById("txtPWD_NO").value == '') {
				alert("������й�ȣ�� �Է����ּ���.");
				document.getElementById("txtPWD_NO").focus();
				return false;
			}
			if( document.getElementById("txtNEW_PWD_NO").value == '') {
				alert("�űԺ�й�ȣ�� �Է����ּ���.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}
			if( document.getElementById("txtNEW_PWD_NO").value.length < 6) {
				alert("����,���� 6�� �̻�~10�� ���Ϸ� �Է����ּ���.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

			if( document.getElementById("txtNEW_PWD_NO").value.length > 15) {
				alert("����,���� 6�� �̻�~15�� ���Ϸ� �Է����ּ���.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

			var filterA = /[a-z]/i;
			var filter9 = /[0-9]/;
			var filterY = /[!@$%^*()_|<>?~]/;
			var filterN = /[#&+]/;

			var tagA = false;
			var tag9 = false;
			var tagY = false;
			var tagN = false;

			//alert(document.getElementById("txtNEW_PWD_NO").value);

			if (filterN.test(document.getElementById("txtNEW_PWD_NO").value) == true) {
				alert("��ȣ�� #,&,+ �� �����Ͽ� �ֽñ� �ٶ��ϴ�");
				document.getElementById("txtNEW_PWD_NO").value='';
				document.getElementById("txtCHECK_PWD_NO").value='';
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;	}


			if (filterA.test(document.getElementById("txtNEW_PWD_NO").value) == true) {	 tagA = true;	}
			if (filter9.test(document.getElementById("txtNEW_PWD_NO").value) == true) {	 tag9 = true;	}
			if (filterY.test(document.getElementById("txtNEW_PWD_NO").value) == true) {	 tagY = true;	}


			if (!(tagA && tag9 && tagY)) {
				alert("����,����, Ư������ �����Ͽ� 6�� �̻�~15�� ���Ϸ� �Է����ּ���.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

			if( document.getElementById("txtCHECK_PWD_NO").value == '') {
				alert("��й�ȣȮ���� ���ּ���.");
				document.getElementById("txtCHECK_PWD_NO").focus();
				return false;
			}
			if( document.getElementById("txtNEW_PWD_NO").value != document.getElementById("txtCHECK_PWD_NO").value ) {
				alert("�űԺ�й�ȣ�� Ȯ�κ�й�ȣ�� ���� �ٸ��ϴ�. \n�ٽ� �Է����ּ���.");
				document.getElementById("txtNEW_PWD_NO").value='';
				document.getElementById("txtCHECK_PWD_NO").value='';
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

            trT_CM_EMPLIST.KeyValue = "SHR(O:dsT_CM_EMPLIST_01=dsT_CM_EMPLIST_01)";
            trT_CM_EMPLIST.Action = "/servlet/GauceChannelSVL?cmd=common.popup.chgpwd.cmd.CHGPWDCMD&S_MODE=CHG&PWD_NO="+document.getElementById("txtPWD_NO").value+"&NEW_PWD_NO="+document.getElementById("txtNEW_PWD_NO").value;
            trT_CM_EMPLIST.Post();

            var PWD_NO = dsT_CM_EMPLIST_01.NameValue(1,"PWD_NO");
            var NEW_PWD_NO = dsT_CM_EMPLIST_01.NameValue(1,"NEW_PWD_NO");

			if( dsT_CM_EMPLIST.NameValue(1,"PWD_NO") != PWD_NO ) {
				
				alert("������й�ȣ�� �ٸ��ϴ�. \n�ٽ� �Է����ּ���.");
				document.getElementById("txtPWD_NO").value='';
				document.getElementById("txtPWD_NO").focus();
				return false;
			}
			if( dsT_CM_EMPLIST.NameValue(1,"PWD_NO") == NEW_PWD_NO ) {
				alert("������й�ȣ�� �����ϴ�. \n�ٽ� �Է����ּ���.");
				document.getElementById("txtNEW_PWD_NO").value='';
				document.getElementById("txtCHECK_PWD_NO").value='';
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			fnc_SearchItem();
			form1.txtPWD_NO.focus();

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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

    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("������й�ȣ�� �����ϴ�.");

        } else {
            //alert(dsT_CM_EMPLIST.ExportData(1, dsT_CM_EMPLIST.CountRow, true));
        }

    </Script>

    <Script For=dsT_CM_EMPLIST_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CM_EMPLIST_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CM_EMPLIST_01 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_EMPLIST event="OnSuccess()">

        if(trT_CM_EMPLIST.KeyValue.substring(0,3) == "SAV"){
			alert('��й�ȣ�� ����Ǿ����ϴ�.');
			window.close();
		}

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_EMPLIST event="OnFail()">

        alert(trT_CM_EMPLIST.ErrorMsg);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- �̸��� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
		<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

<!-- form ���� -->
<form name="form1">
<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <!-- Ÿ��Ʋ �� ���̺� ���� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����� ��й�ȣ ����</td>
        </tr>
      </table>
      <!-- Ÿ��Ʋ �� ���̺� �� -->
    </td>
  </tr>
  <tr>
    <!-- ��ư -->
    <td height="35" align="right" class="paddingTop5">
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
	</td>
  </tr>
  <tr>
    <td height="125">
      <!--�����������̺� �� -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="400" align="center" valign="middle">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="hrWtable" style="padding:0 26 0 14">
					<table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74" style="padding:0 19 0 0"><img src="/images/specialHr/inputImg3.gif"></td>
                      <td>
                      <table width="400" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:10px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								��� <font color="#525450"><%=box.get("SESSION_ENONO") %></font>
								<input type=hidden id=txtENO_NO value="<%=box.get("SESSION_ENONO") %>" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="inputDisabled" disabled>
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								���� <font color="#525450"><%=box.get("SESSION_ENONM") %></font>
								<input type="hidden" id=txtENO_NM value="<%=box.get("SESSION_ENONM") %>" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="inputDisabled" disabled>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								�����й�ȣ
								<input type=password id=txtPWD_NO value="" size="20" maxlength=20 style="ime-mode:disabled" class="divInput">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								�űԺ�й�ȣ
								<input type=password id=txtNEW_PWD_NO valid="key=true;type=eng" value="" size="30" maxlength=20 style="ime-mode:disabled" class="divInput">

                            </td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;padding-bottom:10px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								��й�ȣȮ��
								<input type=password id=txtCHECK_PWD_NO valid="key=true;type=eng" value="" size="30" maxlength=20 style="ime-mode:disabled" class="divInput">
                            </td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextBLUE" style="padding-top:5px;padding-bottom:10px;">
                            <font color="blue">������ Ư����ȣ ! @ $ % ^ * ( ) _ | ? ~</font><BR>
                            <font color="red">�Ұ����� Ư����ȣ # & +</font>
                            </td>
                          </tr>
                        </table>
                        </td>
                    </tr>
                  </table></td>
              </tr>
            </table> </td>
        </tr>
      </table>
      <!--�����������̺� �� -->
    </td>
  </tr>
</table>
</form>
</body>
</html>