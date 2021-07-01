<!--
***********************************************************************
* @source      : edue061.jsp
* @description : ����������� ����ó�� - ���缼�λ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/20      ������        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
%>
<html>
<head>
	<title>����������� ����ó�� - ���缼�λ���(edue061)</title>
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

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var dsTemp = window.dialogArguments;
		var obj = new String();
		obj.app_cmt = "";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            //���缼�λ��� ��ȸ
            trT_DI_APPROVAL.KeyValue = "SVC(O:SHR=dsT_ED_COURSELIST, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue061.cmd.EDUE061CMD&S_MODE=SHR&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
            trT_DI_APPROVAL.post();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

			// �����ڸ� ��ư�� Ȱ��ȭ
            if(dsTemp.NameValue(1,"ENO_NO")== "<%=eno_no%>"){
                fnc_ShowElement("btn_approval");
            }else{
                fnc_HiddenElement("btn_approval");
            }

            var nowDate = getToday().replace("-","").replace("-","");

            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. �׸��� ���� ó��  *
         ************************/
		function fnc_ChangeGrid() {

		}

        /********************************************
         * 17. ����, �Ⱒ ��ư ó��					*
         ********************************************/
		function fnc_Approval() {

            if (confirm("����ó���� �Ͻðڽ��ϱ�?")) {

				dsT_ED_COURSELIST.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_ED_COURSELIST=dsT_ED_COURSELIST)";
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue061.cmd.EDUE061CMD&S_MODE=SAV&APP_YN=Y&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+obj.app_cmt+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				trT_DI_APPROVAL.post();
            }

            //window.close();
			document.getElementById("btn_approval").style.display = "none";
            fnc_SearchList();

		}
		function fnc_Reject() {

            if (confirm("�ΰ�ó���� �Ͻðڽ��ϱ�?")) {
				if(obj.app_cmt == ""){
          			window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
          	    }

	            if(obj.app_cmt == ""){
	                alert("�ΰ� �Ǵ� �ݼۻ����� �Է��� ó���ٶ��ϴ�.\n \n�۾��� ��ҵǾ����ϴ�.");
	                return false;
            	}
				dsT_ED_COURSELIST.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_ED_COURSELIST=dsT_ED_COURSELIST)";
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.edu.e.edue061.cmd.EDUE061CMD&S_MODE=SAV&APP_YN=N&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD");
				trT_DI_APPROVAL.post();
            }
            window.close();
			document.getElementById("btn_approval").style.display = "none";
            fnc_SearchList();
		}
		function fnc_ShowRemarkPop(){
			showPopupLayer("PopupLayer");
		}

//----------------------------------------------
		function closePopupLayer(name){
		 if(document.all[name].style.display==""){
		  document.all[name].style.display="none"
		 }
		}
		function showPopupLayer(name){
		 if(document.all[name].style.display=="none"){
		  document.all[name].style.display=""
		 }
		}

	isIE=document.all;
	isNN=!document.all&&document.getElementById;
	isN4=document.layers;
	isHot=false;

	function ddInit(e){
	  topDog=isIE ? "BODY" : "HTML";
	  whichDog=isIE ? document.all.PopupLayer : document.getElementById("PopupLayer");
	  hotDog=isIE ? event.srcElement : e.target;
	  while (hotDog.id!="PopupLayer"&&hotDog.tagName!=topDog){
	    hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
	  }
	  if (hotDog.id=="PopupLayer"){
	    offsetx=isIE ? event.clientX : e.clientX;
	    offsety=isIE ? event.clientY : e.clientY;
	    nowX=parseInt(whichDog.style.left);
	    nowY=parseInt(whichDog.style.top);
	    ddEnabled=true;
	    document.onmousemove=dd;
	  }
	}

	function dd(e){
	  if (!ddEnabled) return;
	  whichDog.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx;
	  whichDog.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
	  return false;
	}

		// Link
		function fnc_SiteTag(){
			var siteTag = document.getElementById("txtSITE_TAG").value;
			if(siteTag == ""){
				return;
			}
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
		}

	document.onmousedown=ddInit;
	document.onmouseup=Function("ddEnabled=false");




    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet									|
    | 2. �̸��� ds_ + �ֿ� ���̺��		   						|
    | 3. ���Ǵ� Table List              			 	   |
    |                    dsT_ED_COURSELIST 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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

    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_APPROVAL)	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

            document.getElementById("txtORD_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "REQ_NO");
            document.getElementById("txtENO_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_NM");
            document.getElementById("txtDPT_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_DPT_CD");
            document.getElementById("txtDPT_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_DPT_NM");
            document.getElementById("txtJOB_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_JOB_CD");
            document.getElementById("txtJOB_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_JOB_NM");

            document.getElementById("txtEDU_ENO_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_ENO_NO");
            document.getElementById("txtEDU_ENO_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_ENO_NM");
            document.getElementById("txtFIELD_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "FIELD_NM");
            document.getElementById("txtEDU_STR_YMD").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_STR_YMD");
            document.getElementById("txtEDU_END_YMD").innerText  = dsT_ED_COURSELIST.NameValue(1, "EDU_END_YMD");
            document.getElementById("txtCPT_PNT").innerText    = dsT_ED_COURSELIST.NameValue(1, "CPT_PNT");
            document.getElementById("txtPLACE_TAG").innerText    = dsT_ED_COURSELIST.NameValue(1, "PLACE_TAG");
            document.getElementById("txtINS_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "INS_NM");
            document.getElementById("txtEDU_CD").innerText    = dsT_ED_COURSELIST.NameValue(1, "EDU_CD");
            document.getElementById("txtSHAPE_NM").innerText = dsT_ED_COURSELIST.NameValue(1, "SHAPE_NM");
            document.getElementById("txtTIME_NO").innerText  = dsT_ED_COURSELIST.NameValue(1, "TIME_NO");
            document.getElementById("txtINT_NAM").innerText     = dsT_ED_COURSELIST.NameValue(1, "INT_NAM");
            document.getElementById("txtCOST_AMT").innerText     = dsT_ED_COURSELIST.NameValue(1, "COST_AMT");
            document.getElementById("txtRTN_AMT").innerText     = dsT_ED_COURSELIST.NameValue(1, "RTN_AMT");
            document.getElementById("txtABSTRACT_TXT").innerText      = dsT_ED_COURSELIST.NameValue(1, "ABSTRACT_TXT");
            document.getElementById("txtIMPRESSION_TXT").innerText      = dsT_ED_COURSELIST.NameValue(1, "IMPRESSION_TXT");
            document.getElementById("txtOPINION_TXT").innerText     = dsT_ED_COURSELIST.NameValue(1, "OPINION_TXT");
            document.getElementById("txtRE_TARGET_TAG").innerText    = dsT_ED_COURSELIST.NameValue(1, "RE_TARGET_TAG");
            document.getElementById("txtFILE_NAME").innerText     = dsT_ED_COURSELIST.NameValue(1, "FILE_NAME");
            document.getElementById("txtSITE_TAG").innerText        = dsT_ED_COURSELIST.NameValue(1, "SITE_TAG");
            document.getElementById("txtDEGREE_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "DEGREE_TAG");


        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

		document.getElementById("btn_approval").style.display = "none";
        var eno_no = "";
		var app_yn = "";

                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//������
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//���翩��

			            //�ش� ������ �ǰ��Է� �غ�.
					if(eno_no == '<%=box.get("SESSION_ENONO")%>' &&  app_yn == "" ){
						document.getElementById("btn_approval").style.display = "";
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
						break;
					}
                }
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
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
		alert(obj.app_cmt);
		if(obj.app_cmt != undefined){
			document.getElementById("txtREMARK").innerText = obj.app_cmt;
		}

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������� ����ó�� - ���缼�λ���</td>
					<td align="right" class="navigator">HOME/��������/���հ���/<font color="#000000">����������� ����ó�� - ���缼�λ���</font></td>
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
                <span id="btn_approval" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)">  <img src="/images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Approval();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)">  <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ShowRemarkPop();"></a>
                </span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ���� �Է� ���̺� ���� -->
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
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">����</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">���/����</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
        </td>
        <td width="30">&nbsp;</td>
        <td>
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="								<C> id='REQ_NO'		width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
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
        </td>
    </tr>
</table>
<br>
<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <span id="txtEDU_ENO_NO" name="txtEDU_ENO_NO" ></span>
                        <span id="txtEDU_ENO_NM" name="txtEDU_ENO_NM" ></span>
                    </td>
                    <td align="center" class="creamBold">�����о�</td>
                    <td class="padding2423" >
                        <span id="txtFIELD_NM" name="txtFIELD_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�н��Ⱓ</td>
                    <td class="padding2423" >
                        <span id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" ></span> ~
                        <span id="txtEDU_END_YMD" name="txtEDU_END_YMD" ></span>
                    </td>
                    <td align="center" class="creamBold">�̼�����</td>
                    <td class="padding2423" >
                        <span id="txtCPT_PNT" name="txtCPT_PNT" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <span id="txtPLACE_TAG" name="txtPLACE_TAG" ></span>
                    </td>
                    <td align="center" class="creamBold">��뺸��</td>
                    <td class="padding2423" >
                        <span id="txtINS_NM" name="txtINS_NM" ></span>
                    </td>

                </tr>
                <tr>
                	<td align="center" class="creamBold">�����ڵ�</td>
                    <td class="padding2423" >
                        <span id="txtEDU_CD" name="txtEDU_CD" ></span>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <span id="txtSHAPE_NM" name="txtSHAPE_NM" ></span>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">�����ð�</td>
                    <td class="padding2423" >
                        <span id="txtTIME_NO" name="txtTIME_NO" ></span>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <span id="txtINT_NAM" name="txtINT_NAM" ></span>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <span id="txtCOST_AMT" name="medCOST_AMT" ></span>
                    </td>
                    <td align="center" class="creamBold">ȯ�ޱݾ�</td>
                    <td class="padding2423" >
                        <span id="txtRTN_AMT" name="medRTN_AMT" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ֿ䳻����</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtABSTRACT_TXT" name="txtABSTRACT_TXT" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� �Ұ�</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtIMPRESSION_TXT" name="txtIMPRESSION_TXT" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������<br>�������</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtOPINION_TXT" name="txtOPINION_TXT" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�н���õ���</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtRE_TARGET_TAG" name="txtRE_TARGET_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�����ڷ�</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtFILE_NAME" name="txtFILE_NAME" onClick="fnc_link()"></span>
                        <input type=hidden id=txtFILE_URL name=txtFILE_URL size="60"><input type=hidden id=txtFILE_URL2 name=txtFILE_URL2 size="60">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������Ʈ</td>
                    <td class="padding2423">
                        <!-- http://<span id="txtSITE_TAG" name="txtSITE_TAG" ></span> -->
                         http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="30" maxlength="300" >&nbsp;<input type="button" value="����" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                    <td align="center" class="creamBold">�н�������</td>
                    <td class="padding2423" >
                        <span id="txtDEGREE_TAG" name="txtDEGREE_TAG" ></span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->
	</form>
	<!-- form �� -->

</body>
<!-- new popup start -->
<div id="PopupLayer" style="position:absolute; left:200px; top:185px; z-index:10000; width:300px; height:180px; display:none ;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="3" bgcolor="dbdbdb">
  <tr>
    <td bgcolor="#FFFFFF" style="padding:1 1 1 1" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="45" bgcolor="#408080">&nbsp;&nbsp;
		<span style="font-weight: bold"><font style='color:#FFFFFF;font-size:15px;font-face:����'>�ΰ�����Է�</font></span>
		</td>
		<td width="50" bgcolor="#408080" align="center">
		<a href="#" onClick="closePopupLayer('PopupLayer');return false"><font color=#ffffff face=arial  style="text-decoration:none">�ݱ�</font></a>
		</td>
      </tr>
      </table>
      <table width="100%" border="0" cellspacing="30" cellpadding="0">
        <tr>
          <td><textarea id="txtREMARK"  name="txtREMARK" cols="50" rows="5"></textarea></td>
        </tr>
      </table>
      <table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="d3e3dd" height="26">
        <tr height='26'>
          <form name="form" id="form">
            <td width="15"></td>
            <td align="center"><a href="#" onClick="fnc_Reject();return false"><font color=#000000 face=arial  style="text-decoration:none">Ȯ��</font></a>
            <td width="15"></td>
          </form>
        </tr>
      </table></td>
  </tr>
</table>
</div>
<!-- new popup end -->
</html>