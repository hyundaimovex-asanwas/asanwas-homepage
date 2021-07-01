<!--
*****************************************************
* @source       : BOOK011.jsp
* @description : �������Խ�û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/15      �̵���        �����ۼ�
*----------------------------------------------------
* 2016/06/03    |  ������   | �ҽ�����                                           *
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�������԰���</title>
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

        var param = window.dialogArguments;
        
		var rqst_no = param.req_no;
		
		var chkValid  = 'T';
		
		var rq_seq = 0;
		
		var obj = new String();
		
		obj.app_cmt = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	
			//������û��Ȳ ���� ��ȸ
			dsT_ED_BOOKMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_11&REQ_NO="+rqst_no;
			dsT_ED_BOOKMASTER.reset();

			dsT_ED_BOOKDETAIL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_02&REQ_NO="+rqst_no;
			dsT_ED_BOOKDETAIL.reset();

            //������ ��ȸ
            dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_APP&REQ_NO="+rqst_no;
            dsT_DI_APPROVAL.reset();
            
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

			trT_ED_BOOKDETAIL.KeyValue = "tr01(I:dsT_ED_BOOKDETAIL=dsT_ED_BOOKDETAIL)";
			trT_ED_BOOKDETAIL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book011.cmd.BOOK011CMD&S_MODE=UPT_DETAIL&REQ_NO="+rqst_no;
			trT_ED_BOOKDETAIL.post();

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
         * 08. ��ȿ�� �˻� *
         ******************/
        function fnc_Valid() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
		function fnc_Append(){

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
        function fnc_SearchItemCheck() {

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
        	
        	
        	dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();
        	

            //�����ϴ� �͵� ����
			fnc_SearchList();

			cfStyleGrid_New(form1.grdT_ED_BOOKDETAIL,0,"true","false");      // Grid Style ����

			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * ���ó��
         */
        function fnc_Conduct() {


            if(dsT_ED_BOOKMASTER.CountRow < 1){
              alert("��Ű����� �������Խ�û������ �����ϴ�");
              return;
            }

            if(dsT_ED_BOOKDETAIL.CountRow < 1){
              alert("��Ű����� �������Խ�û������ �����ϴ�");
              return;
            }

            //1.���ó�� ������
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("���缱�� �������ּ���.");
                return;
            }

            //2.���ó��

            var RQST_YMD = document.getElementById("txtRQST_YMD").value;
			var GUN_YMD = RQST_YMD.replace("-","").replace("-","")
            //var DPT_CD  = document.getElementById("hidDPT_CD_ORI").value;
			var DPT_CD  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			var REQ_NO  = dsT_ED_BOOKMASTER.NameValue(1,"RQST_NO");

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +"R"
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"Q"
                                      + "&GUN_DPT=" +DPT_CD
                                      + "&REQ_NO="	+REQ_NO;

			trT_DI_APPROVAL.post();

        }





        /**
         * ���縦 ó�� �Ѵ�.
         */
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

            var app_yn = "Y";    //����ϷῩ��

			if (kind == "�ΰ�") {

				app_yn = "N";

				window.showModalDialog("../../hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			}

			dsT_DI_APPROVAL.UserStatus(1) = 1;

			dsT_DI_APPROVAL.NameValue(1,"REMARK") = obj.app_cmt;   	//�����ǰ� Container

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";

			trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book011.cmd.BOOK011CMD"
                                      + "&S_MODE=SAV_APP"
                                      + "&APP_YN="  +app_yn
                                      + "&GUN_GBN=" +"Q"
                                      + "&REQ_NO="  +param.req_no;

			trT_DI_APPROVAL.post();
			
			window.close();

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
    | 2. �̸� : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ED_BOOKDETAIL                   |
    | 3. Table List : T_ED_BOOKDETAIL               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKDETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_HOLIDAY                      |
    | 3. Table List : T_DI_HOLIDAY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�ּ�)              |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)      |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)        |
    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
	  <Param Name="UseChangeInfo"   Value="True">
	  <Param Name="ViewDeletedRow"  Value="False">
	 </Object>
    

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_APPROVAL)	|
    | 3. ���Ǵ� Table List(T_DI_APPROVAL)	        	|
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKDETAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadCompleted(iCount)">

    </Script>

    <!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <!-- ���缱 ��ȸ �� -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    
    	var SESSION_ENONO = gusrid;

		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");
		fnc_HiddenElement("imgReport");
		fnc_HiddenElement("imgSave");

		//fnc_InputDisabled();
		
		// ������ ��� ������ ��� �����ڿ��� ����,�ΰ� �̹��� �����ֱ�
		for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
			var APP_YN = dsT_DI_APPROVAL.NameString(i, "APP_YN");
			var ENO_NO = dsT_DI_APPROVAL.NameString(i, "ENO_NO");
			var PENO_NO = dsT_DI_APPROVAL.NameString(i, "PENO_NO");
		
			if(ENO_NO == SESSION_ENONO && APP_YN == "A") {
				fnc_ShowElement("imgApproval");
				fnc_ShowElement("imgRejection");
				fnc_HiddenElement("imgReport");
				dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
				break;
			}
		}

			var END_TAG = dsT_ED_BOOKMASTER.NameString(1, "END_TAG");

			//���� ������̰� ���°� ����϶�
			if(PENO_NO == SESSION_ENONO && END_TAG == "A") {
				fnc_HiddenElement("imgReport");
			}

			//���� ������̰� ���°� �����϶�
			if(PENO_NO == SESSION_ENONO && END_TAG == "R") {
				fnc_ShowElement("imgReport");
				fnc_ShowElement("imgSave");
			}

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_APPROVAL event="OnSuccess()">
        fnc_SearchList();
        //document.getElementById("resultMessage").innerText = "ó���Ǿ����ϴ�";
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|   =>  2010/4/8 ���ǻ���      || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "R"
    +------------------------------------------->
	<script language="javascript"  for=dsT_DI_HOLIDAYWORK  event=OnRowPosChanged(row)>

        var today   = fnc_covNumber(getToday());
        if(row > 0) {

                //��������̰ų� �ΰ��϶� ������ ������
                if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
                        || dsT_DI_APPROVAL.NameString(2, "APP_YN") == "N"
                        || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N") {
                    //�ű��� ���
                    if(dsT_DI_HOLIDAYWORK.RowStatus(row) == "1") {  //�ű�

                        fnc_EnableElementAll(elementList);

                    } else {
                        fnc_EnableElementAll(elementList, exceptionList);   //�ű��̿�
                    }
                }

        }

	</script>

	<!-----------------------------------------------------+
    | grdT_ED_BOOKDETAIL OnClick ó�� - Ȩ������ ��ȸ      |
    +------------------------------------------------------>
  	<script language="javascript"  for=grdT_ED_BOOKDETAIL event=OnDblClick(row,colid)>

		if(colid=="HOMEPAGE"){
			var siteTag = dsT_ED_BOOKDETAIL.NameValue(row,"HOMEPAGE");

			if(siteTag == ""){
				return;
			}
			
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
			
			
		}
  	</script>


	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  	<script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ��Է�" ){

		window.showModalDialog("../../hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">


<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�������԰���</td>
					<td align="right" class="navigator">HOME/�������԰���/��������/<font color="#000000">�������԰���</font></td>
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
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)"><img src="../../images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('����');"></a>
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)"><img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('�ΰ�');"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   		    name="imgSave"   	  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)"><img src="../../images/button/btn_ReportOn.gif"          name="imgReport"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"            name="imgExit"      width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>

		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<table border="0">
	<tr>
		<td valign="top">
			<!-- ���� �Է� ���̺� ���� -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="50"></col>
                                <col width="100"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="blueBold">��û��</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"   class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"  class="input_ReadOnly"  readonly>
			                        <input id="hidDPT_CD_ORI" type="hidden">
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">�Ҽ�</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                                <td align="center" class="blueBold">����</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="blueBold">��û��</td>
                                <td class="padding2423" colspan ="3" >
			                        <input id="txtRQST_YMD" name="txtRQST_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly"  readonly">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRQST_YMD','','../../images/button/btn_HelpOver.gif',1)">
			                        <img src="../../images/button/btn_HelpOn.gif" id="ImgRQST_YMD" name="ImgRQST_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRQST_YMD','','36','227');"></a>
                                </td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">�뵵</td>
                                <td class="padding2423" colspan ="3">
                                    <input id="txtREMARK" style="width=100%"  class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- ���缱 ���� ���̺� ���� -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:110px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
			            					<C> id='SEQ_NO'		width=35		name='NO'			align=center	</C>
											<C> id='SEQ_NM'		width=45		name='����'			align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
											<C> id='JOB_NM'		width=55		name='����'			align=center	</C>
											<C> id='ENO_NM'		width=65		name='����'			align=center	</C>
											<C> id='APP_YN'		width=150	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&APP_YMD} </C>
											<C> id='REMARK1'	width=60		name='����'			align=center	Color='Blue'</C>
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
		</div>
		</td>
	</tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ED_BOOKDETAIL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				value="dsT_ED_BOOKDETAIL">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">					
							<param name="VIEWSUMMARY"			value=1>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=30				name='NO'			align=center		value={String(Currow)}	 SumBgColor=#C3D0DB</C>
								<C> id='BOOK_NM'			width=180			name='������'		align=center		SumBgColor=#C3D0DB 	SumText='��'	</C>
								<C> id='BOOK_PUL'			width=120			name='���ǻ�'		align=center		SumBgColor=#C3D0DB 	</C>
								<C> id='BOOK_WRT'		width=80				name='����'			align=center		SumBgColor=#C3D0DB 	</C>
								<C> id='BOOK_QTY'			width=70				name='����'			align=center		edit=numeric editlimit=3 SumBgColor=#C3D0DB SumText=@sum	</C>
								<C> id='BOOK_AMT'			width=80				name='����'			align=center		edit=numeric editlimit=6 SumBgColor=#C3D0DB SumText=@sum	</C>
                                <C> id='HOMEPAGE'    		width=120           name='Ȩ������'    align=left      		SumBgColor=#C3D0DB</C>
                                <C> id='BOOK_REMARK'    width=80            name='���'         	align=left      		SumBgColor=#C3D0DB</C>
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


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_ED_BOOKMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKMASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			Param=value 	</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=RQST_YMD				Ctrl=txtRQST_YMD	   		Param=value		</C>
		<C>Col=RQST_REMARK			Ctrl=txtREMARK	   			Param=value		</C>
    '>
</object>


