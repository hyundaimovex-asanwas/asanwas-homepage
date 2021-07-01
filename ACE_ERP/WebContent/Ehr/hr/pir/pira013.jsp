<!--
    ************************************************************************************
    * @Source         : pira013.jsp                                                    		*
    * @Description    : �λ�⺻3 PAGE                                                 		*
    * @Developer Desc :                                                               			*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            	*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�λ�⺻3</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
%>

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
        	
            var ENONO = <%=ENO_NO%>;
            
            if (form1.ENO_NO.value == "" || (parent.dsT_CM_PERSON.CountRow < 1 && parent.dsT_CM_PERSON.RowStatus(1) != 1)) {

                dsT_CM_PERSON.ClearData();

                //fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                	
                    parent.document.getElementById("txtENO_NM").focus();
                    
                }

                //return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira013.cmd.PIRA013CMD&S_MODE=SHR&ENO_NO="+parent.document.getElementById("txtENO_NO").value;
            dsT_CM_PERSON.Reset();

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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira013.cmd.PIRA013CMD&S_MODE=SAV&ENO_NO="+parent.document.getElementById("txtENO_NO").value+"&HEAD_CD="+parent.document.getElementById("txtHEAD_CD").value+"&DPT_CD="+parent.document.getElementById("txtDPT_CD").value;
                trT_CM_PERSON.post();

            } else {

                return false;

            }

            return true;

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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_PERSON.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.ImgZipNo.focus();

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


            // �����ȣ �������ϰ�, �ּ� �Է��� ���
            if (document.getElementById("txtZIP_NO").value == "" && document.getElementById("txtADDRESS").value != "") {
                alert("�����ȣ�� �Է����� �����̽��ϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtADDRESS").focus();
                return false;
            }

            // �����ȣ �������ϰ�, �ּ� �Է��� ���
            if (document.getElementById("txtRZI_NO").value == "" && document.getElementById("txtRADR").value != "") {
                alert("�����ȣ�� �Է����� �����̽��ϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtRADR").focus();
                return false;
            }

            // �̸��� CHECK
            if (!fnc_ChgEmail()) {
                document.getElementById("txtE_MAIL").focus();
                return false;
            }

            // �ְ�����
            if (document.getElementById("txtHOU_CD").value != "" &&
                document.getElementById("txtHOU_NM").value == "") {
                alert("�ְ������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtHOU_CD").focus();
                return false;
            }

            // �޿���������
            if (document.getElementById("txtABA_CD").value != "" &&
                document.getElementById("txtABA_NM").value == "") {
                alert("�޿����������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtABA_CD").focus();
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //document.getElementById("ENO_NO").value = "";

            //fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtADDRESS").disabled   = false;
                document.getElementById("txtRADR").disabled      = false;
                document.getElementById("txtPHN_NO").disabled    = false;
                document.getElementById("txtEM_PHN_NO").disabled = false;
                document.getElementById("txtE_MAIL").disabled    = false;
                document.getElementById("txtHOU_CD").disabled    = false;
                document.getElementById("txtROM_CNT").disabled   = false;
                document.getElementById("txtHIU_NO").disabled    = false;
                document.getElementById("txtLAN_SPA").disabled   = false;
                document.getElementById("txtFLR_SPA").disabled   = false;
                document.getElementById("txtABA_CD").disabled    = false;
                form1.medMOV_AMT.enable                          = true;
                form1.medMOVP_AMT.enable                         = true;
                document.getElementById("txtACC_NO").disabled    = false;

                document.getElementById("ImgZipNo").disabled     = false;
                document.getElementById("ImgRziNo").disabled     = false;
                document.getElementById("imgCopyAddress").disabled = false;
                document.getElementById("ImgHouCd").disabled     = false;
                document.getElementById("ImgAbaCd").disabled     = false;

            }
            else if (prop == 'D') {


            	
                document.getElementById("txtADDRESS").disabled   = true;
                document.getElementById("txtRADR").disabled      = true;
                document.getElementById("txtPHN_NO").disabled    = true;
                document.getElementById("txtEM_PHN_NO").disabled = true;
                document.getElementById("txtE_MAIL").disabled    = true;
                document.getElementById("txtHOU_CD").disabled    = true;
                document.getElementById("txtROM_CNT").disabled   = true;
                document.getElementById("txtHIU_NO").disabled    = true;
                document.getElementById("txtLAN_SPA").disabled   = true;
                document.getElementById("txtFLR_SPA").disabled   = true;
                document.getElementById("txtABA_CD").disabled    = true;
                form1.medMOV_AMT.enable                          = false;
                form1.medMOVP_AMT.enable                         = false;

                document.getElementById("txtACC_NO").disabled    = true;

                document.getElementById("ImgZipNo").disabled     = true;
                document.getElementById("ImgRziNo").disabled     = true;
                document.getElementById("imgCopyAddress").disabled = true;
                document.getElementById("ImgHouCd").disabled     = true;
                document.getElementById("ImgAbaCd").disabled     = true;

            }
        }

        function fnc_ChgEmail() {
            var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

            if (document.getElementById("txtE_MAIL").value == '') {
                return true;
            }

            if (document.getElementById("txtE_MAIL").value.search(format) == -1) {
                alert("��ȿ�� �̸��� �ּҰ� �ƴմϴ�.");
                document.getElementById("txtE_MAIL").focus();

                return false;
            }

            return true;
        }

        function fnc_UsrpostPopup(zip_no, addr, addr2) {
        	if(zip_no=="txtZIP_NO"){
        		openDaumPostcode('1');
        	}else{
        		openDaumPostcode('2');
        	}
            
            /**20150916 jys ����
            var no = document.getElementById(zip_no).value;

            fnc_postPopup(zip_no, addr);

            if (document.getElementById(zip_no).value != "") {
                if (document.getElementById(zip_no).value.substr(3,1) != '-') {
                    document.getElementById(zip_no).value = document.getElementById(zip_no).value.substr(0,3) + '-' + document.getElementById(zip_no).value.substr(3,3);
                }

                if (no != document.getElementById(zip_no).value) {
                    document.getElementById(addr2).value = '';
                }
            }
            **/
        }

        function fnc_CopyAddress(){

            if(document.getElementById("txtZIP_NO").value.trim() == "" &&
                document.getElementById("txtADR_CT").value.trim() == "" &&
                document.getElementById("txtADDRESS").value.trim() == ""){
                alert("������ �ּҰ� �����ϴ�.");
                return false;
            }

            document.getElementById("txtRZI_NO").value = document.getElementById("txtZIP_NO").value;
            document.getElementById("txtRADR_CT").value = document.getElementById("txtADR_CT").value;
            document.getElementById("txtRADR").value = document.getElementById("txtADDRESS").value;
        }

    </script>
    
    
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
    function openDaumPostcode(gb) {
        var width =500;
        var height =600;
        new daum.Postcode({
            width:width,
            height:height,
            
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ְ�, Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
                var strpostcode="";  //���� �����ȣ ( 6�ڸ� )
                var strzonecode="";  //�ű� �����ȣ ( 5�ڸ� )
                strzonecode = data.zonecode;    
                //strpostcode = data.postcode;  
                //strpostcode = strpostcode.substring(0,3)+strpostcode.substring(4,7)
                //document.getElementById('gcem_post').text = strpostcode;
                
                if(gb=="1"){
	                document.getElementById('txtZIP_NO').value = strzonecode;
	                
	                //document.getElementById('gcem_post_1').text = data.postcode1;
	                //document.getElementById('gcem_post_2').text = data.postcode2;
	                document.getElementById('txtADR_CT').value = data.address;
	                document.getElementById('txtADDRESS').value = "";
	
	                //��ü �ּҿ��� ���� ���� �� ()�� ���� �ִ� �ΰ������� �����ϰ��� �� ���,
	                //�Ʒ��� ���� ���Խ��� ����ص� �ȴ�. ���Խ��� �������� ������ �°� �����ؼ� ��� �����ϴ�.
	                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
	                //document.getElementById('addr').value = addr;
	
	                document.getElementById('txtADDRESS').focus();
	            }else{
	            	document.getElementById('txtRZI_NO').value = strzonecode;
	                document.getElementById('txtRADR_CT').value = data.address;
	                document.getElementById('txtRADR').value = "";
	                document.getElementById('txtRADR').focus();
	            
	            }
            }
        }).open({
				    left:(window.screen.width/2)-(width/2),
				    top:(window.screen.height/2)-(height/2)
				} );
    }
</script>      
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            //fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
          if (parent.savflag != '1') {
              parent.savflag = 1;
          }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�⺻3</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="74 "></col>
                    <col width="75 "></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">����ּ�</td>
                    <td align="center" class="blueBold">�����ȣ</td>
                    <td class="padding2423">
                        <input id="txtZIP_NO" size="7" maxlength="7" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgZipNo" name="ImgZipNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_UsrpostPopup('txtZIP_NO','txtADR_CT','txtADDRESS');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                         <input id="txtADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtADDRESS" maxlength="60" style="width:46%"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">�ǰ�����</td>
                    <td align="center" class="blueBold">�����ȣ</td>
                    <td class="padding2423">
                        <input id="txtRZI_NO" size="7" maxlength="7" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRziNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRziNo" name="ImgRziNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_UsrpostPopup('txtRZI_NO','txtRADR_CT','txtRADR')"></a>
                        &nbsp;
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCopyAddress','','../../images/button/btn_CopyAddressOver.gif',1)"><img src="../../images/button/btn_CopyAddressOn.gif" name="imgCopyAddress" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CopyAddress();"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtRADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtRADR" maxlength="60" style="width:46%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="78 "></col>
                    <col width="76 "></col>
                    <col width="155"></col>
                    <col width="76 "></col>
                    <col width="155"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >������ȣ</td>
                    <td align="center" class="blueBold">��ȭ��ȣ</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO" style="width:100%;ime-mode:disabled"  maxlength="20" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">E-mail</td>
                    <td class="padding2423">
                        <input id="txtE_MAIL" maxlength="40" style="width:100%" onChange="fnc_ChgEmail();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="3">�ְ�����</td>
                    <td align="center" class="blueBold">�ְ�����</td>
                    <td class="padding2423">
                        <input id="txtHOU_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('D3', 'txtHOU_CD','txtHOU_NM');"> <input id="txtHOU_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHouCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHouCd" name="ImgHouCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHOU_CD','txtHOU_NM','�ְ�����','D3')"></a>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtROM_CNT" maxlength="1" style="width:83%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();"> ��
                    </td>
                    <td align="center" class="blueBold">�ǰ���������ȣ</td>
                    <td class="padding2423">
                        <input id="txtHIU_NO" maxlength="15" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtLAN_SPA" maxlength="3" style="width:83%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();"> ��
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtFLR_SPA" maxlength="3" style="width:83%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();"> ��
                    </td>
                    <td align="center" class="blueBold">�޿���������</td>
                    <td class="padding2423">
                        <input id="txtABA_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('BK', 'txtABA_CD','txtABA_NM');"> <input id="txtABA_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAbaCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgAbaCd" name="ImgAbaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtABA_CD','txtABA_NM','����','BK')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">����</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="75%"">
                                    <comment id="__NSID__"><object id="medMOV_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            	value=2>
                                        <param name=Border               		value=true>
                                        <param name=ClipMode             	value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               		value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=5>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> ����
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">�ε���</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="75%"">
                                    <comment id="__NSID__"><object id="medMOVP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            value=2>
                                        <param name=Border               value=true>
                                        <param name=ClipMode             value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=5>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> ����
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">�޿����¹�ȣ</td>
                    <td class="padding2423">
                        <input id="txtACC_NO" maxlength="17" style="width:100%">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=ZIP_NO        Ctrl=txtZIP_NO      Param=value </C>
        <C> Col=ADDRESS       Ctrl=txtADDRESS     Param=value </C>
        <C> Col=ADR_CT        Ctrl=txtADR_CT      Param=value </C>
        <C> Col=RZI_NO        Ctrl=txtRZI_NO      Param=value </C>
        <C> Col=RADR          Ctrl=txtRADR        Param=value </C>
        <C> Col=RADR_CT       Ctrl=txtRADR_CT     Param=value </C>
        <C> Col=PHN_NO        Ctrl=txtPHN_NO      Param=value </C>
        <C> Col=EM_PHN_NO     Ctrl=txtEM_PHN_NO   Param=value </C>
        <C> Col=E_MAIL        Ctrl=txtE_MAIL      Param=value </C>
        <C> Col=HOU_CD        Ctrl=txtHOU_CD      Param=value </C>
        <C> Col=HOU_NM        Ctrl=txtHOU_NM      Param=value </C>
        <C> Col=ROM_CNT       Ctrl=txtROM_CNT     Param=value </C>
        <C> Col=HIU_NO        Ctrl=txtHIU_NO      Param=value </C>
        <C> Col=LAN_SPA       Ctrl=txtLAN_SPA     Param=value </C>
        <C> Col=FLR_SPA       Ctrl=txtFLR_SPA     Param=value </C>
        <C> Col=ABA_CD        Ctrl=txtABA_CD      Param=value </C>
        <C> Col=ABA_NM        Ctrl=txtABA_NM      Param=value </C>
        <C> Col=MOV_AMT       Ctrl=medMOV_AMT     Param=text  </C>
        <C> Col=MOVP_AMT      Ctrl=medMOVP_AMT    Param=text </C>
        <C> Col=ACC_NO        Ctrl=txtACC_NO      Param=value </C>
    '>
</object>