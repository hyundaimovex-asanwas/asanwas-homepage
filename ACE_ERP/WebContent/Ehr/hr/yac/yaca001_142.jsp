<!--
    *****************************************************
    * @source         : yaca001_14.jsp 				                                  *
    * @description   : ����û �����ü �����ڷ� PAGE.                              *
    *****************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                       *
    *-------------+-----------+----------------------------------------+
    * 2015/01/28  |  �̵���   | �����ۼ�                                              *
    *****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<title>����û �����ü �����ڷ�</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/result.js"></script>		
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFTTTFFT';
		//var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_date = gcurdate;		
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // �ش�⵵

            //�����ͼ� ����
			if(document.tabYACA001.ActiveIndex==1){//��������
				dsT_AC_RETACC_01.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD&S_MODE=SHR_14&PIS_YY_SHR="+PIS_YY_SHR;
				dsT_AC_RETACC_01.Reset();
				
			}else if(document.tabYACA001.ActiveIndex==2){//�Ƿ��Ű�
	            dsT_AC_MEDICAL_02.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD&S_MODE=SHR_MED_14&PIS_YY_SHR="+PIS_YY_SHR;
	            dsT_AC_MEDICAL_02.Reset();

			}else if(document.tabYACA001.ActiveIndex==3){//��αݽŰ�
	            dsT_AC_DONATION_03.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD&S_MODE=SHR_DON_14&PIS_YY_SHR="+PIS_YY_SHR;
	            dsT_AC_DONATION_03.Reset();
            }

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

			if(document.tabYACA001.ActiveIndex==1){//��������
				
				if (dsT_AC_RETACC_01.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_RETACC_01.GridToExcel("��������", '', 225)

			}else if(document.tabYACA001.ActiveIndex==2){//�Ƿ��Ű�
				
				if (dsT_AC_MEDICAL_02.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_MEDICAL_02.GridToExcel("�Ƿ��Ű�", '', 225)

			}else if(document.tabYACA001.ActiveIndex==3){//��αݽŰ�
				if (dsT_AC_DONATION_03.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_AC_DONATION_03.GridToExcel("��αݽŰ�", '', 225)

            }

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
        	
        	//alert(gs_date);
        	
            document.getElementById("txtPIS_YY_SHR").value =  '2014';
			document.getElementById("txtPIS_YMD").value = gs_date; // �ش�����
			
			
			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_AC_RETACC_01,0,"false","true");
			cfStyleGrid_New(form1.grdT_AC_MEDICAL_02,0,"false","true");
			cfStyleGrid_New(form1.grdT_AC_DONATION_03,0,"false","true");

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /**
         * ���Ϸ� ����
         */
        function fnc_ToFile() {

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; 	// �ش�⵵
			var PIS_YMD = document.getElementById("txtPIS_YMD").value; 			// ��������
			
			var FILE_NAME = "";//���ϸ�

			if(document.tabYACA001.ActiveIndex==1){//��������

	            if (dsT_AC_RETACC_01.CountRow < 1) {
	                alert("����Ÿ�� �����ϴ�.");
	                return;
	            }

    	        FILE_NAME = "C2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "../../../servlet/JspChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD_FILE&S_MODE=FILE_01&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;
	            //prompt(this,form.action);	            
	            form.submit();


			}else if(document.tabYACA001.ActiveIndex==2){//�Ƿ��Ű�

	            if (dsT_AC_MEDICAL_02.CountRow < 1) {
	                alert("����Ÿ�� �����ϴ�.");
	                return;
	            }

	            //�������ڰ� ������ ��ȸ����.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڸ� �Է��ϼ���.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//�������ڰ� �߸��Ǿ����� ��ȸ����.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڰ� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "CA2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "../../../servlet/JspChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD_FILE&S_MODE=FILE_02&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;          
	            form.submit();

			}else if(document.tabYACA001.ActiveIndex==3){//��αݽŰ�

	            if (dsT_AC_DONATION_03.CountRow < 1) {
	                alert("����Ÿ�� �����ϴ�.");
	                return;
	            }

	            //�������ڰ� ������ ��ȸ����.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڸ� �Է��ϼ���.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//�������ڰ� �߸��Ǿ����� ��ȸ����.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("�������ڰ� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "H2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "../../../servlet/JspChannelSVL?cmd=Ehr.yac.a.yaca001.cmd.YACA001CMD_FILE&S_MODE=FILE_03&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;
	            form.submit();


            }

        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->
    
    <Object ID="dsT_AC_RETACC_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">             
    </Object>

    <Object ID="dsT_AC_MEDICAL_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">        
    </Object>

    <Object ID="dsT_AC_DONATION_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">             
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_AC_RETACC_01                                           |
    | 3. Table List :                                                             |
    +----------------------------------------------->
    <Object ID ="trT_AC_RETACC_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_AC_LOAN_06                                           |
    | 3. Table List : T_AC_LOAN                                         |
    +----------------------------------------------->

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->

    <Script For=dsT_AC_RETACC_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_MEDICAL_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_DONATION_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    
    <Script For=dsT_AC_RETACC_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_MEDICAL_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_DONATION_03 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->

    <Script For=dsT_AC_RETACC_01 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_MEDICAL_02 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_DONATION_03 Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AC_RETACC_01 event="OnSuccess()">

   		var iCount = dsT_AC_RETACC_01.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_AC_RETACC_01 event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- ���� ������ ���� -->
<iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">����û �����ü</td>
					<td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">����û �����ü</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->


<!-- ��ư ���̺� ���� -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr><td valign="center" class="searchState"><span id="resultMessage">&nbsp;</span></td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a  href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFilecreate','','../../images/button/btn_FilecreateOver.gif',3)" ><img src="../../images/button/btn_FilecreateOn.gif" id="imgFilecreate" name="imgFilecreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_ToFile()" ></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="80"></col>
								<col width="150"></col>									
								<col width="80"></col>	
								<col width="150"></col>																
			                    <col width="*"></col>
							</colgroup>
							<tr>					
								<td class="searchState" align="right">�ش�⵵</td>
								<td class="padding2423" align="left">
										<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
								</td>
								<td class="searchState" align="right">��������</td>
								<td class="padding2423" align="left">
										<input id="txtPIS_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD','','634','150');"></a>
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



<!-- �� ��� ���۳�Ʈ ���� -->
<comment id="__NSID__">
<object id=tabYACA001 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C style="position:absolute; left:10; top:200; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#dae0ee">
	<param name="DisableBackColor"	value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 				value="1">
	<param name="Format"			value='
		<T>divid="tabYACA001_01"	title="��������"</T>
		<T>divid="tabYACA001_02"	title="�Ƿ��"</T>
		<T>divid="tabYACA001_03"	title="��α�"</T>
	'>
</object>
</comment>
<script> __ShowEmbedObject(__NSID__); </script>
<!-- �� ��� ���۳�Ʈ �� -->




<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabYACA001_01" style="position:absolute; left:10; top:220; width:1050; height:550; z-index:4; visibility:hidden">

	<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETACC_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
					<param name="DataID" value="dsT_AC_RETACC_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
                            <FC> id="{CUROW}"        width=40    height =150 align=center    name="NO"         value={String(Currow)}    SubSumText=""</FC>
                            <FC> id=RET_YN           width=60   align=center    name=����     SubSumText="" Value={Decode(RET_YN,"","����","����")}</FC>
                            <FC> id=RET_YMD         width=70   align=center    name=������     SubSumText="" </FC>                       
                            <FC> id=DPT_NM           width=100   align=left    name=�Ҽ�                          SubSumText=""</FC>
                            <FC> id=ENO_NO           width=55   align=center    name=���                          SubSumText=""</C>
                            <FC> id=ENO_NM           width=55   align=center    name=����                          SubSumText=""</FC>
                            <C> id=CET_NO           width=100   align=center    name=�ֹι�ȣ                          SubSumText=""</C>
                            <C> id=JOB_NM           width=75   align=center    name=����                          SubSumText=" �� �� "</FC>
                            <C> id=TAX_INCOME       width=100   align=right     rightmargin=10    name="�������޿�"                 BgColor=#FAFAD2 </C>
                            <C> id=MGR_AMT          width=100   align=right     rightmargin=10    name="�ٷμҵ�;������"                </C>
                            <C> id=MNI_AMT          width=100   align=right     rightmargin=10    name="�ٷμҵ�ݾ�"                  BgColor=#FABBCC </C>
                            <C> id=BADD_AMT         width=100   align=right     rightmargin=10    name="���ΰ���"                    </C>
                            <C> id=SPSB_AMT         width=100   align=right     rightmargin=10    name="����ڰ���"                  </C>
                            <C> id=GDED_AMT         width=100   align=right     rightmargin=10    name="�ξ簡��;����"                </C>
                            <C> id=GOL_AMT          width=100   align=right     rightmargin=10    name="��ο��;����"                </C>
                            <C> id=TBL_DED          width=100   align=right     rightmargin=10    name="����ڰ���"                  </C>
                            <C> id=WDD_AMT          width=100   align=right     rightmargin=10    name="�γ��ڰ���"                  </C>
                            <C> id=OTX_DED          width=100   align=right     rightmargin=10    name="�Ѻθ����"                  </C>
                            <C> id=NPEN_DED         width=100   align=right     rightmargin=10    name="���ο��ݺ���;����"   </C>
                            <C> id=HIN_DED          width=100   align=right     rightmargin=10    name="�ǰ�,��뺸���;����"         /C>   
                            <C> id=LOAN_DED          width=100   align=right     rightmargin=10    name="��������;���Ա�;�����ݻ�ȯ��"     </C>
                            <C> id=LONG_DED          width=100   align=right     rightmargin=10    name="�����������;���Ա�;�������޾�"  </C>                                                     
                            <C> id=DON_FWD          width=100   align=right     rightmargin=10    name="��α�;�̿�"  </C>                                                      
                            <C> id=VEN_DED          width=100   align=right     rightmargin=10    name="Ư���ҵ�;����"  </C>                                                        
                            <C> id=INDED_TOT          width=100   align=right     rightmargin=10    name="�����ҵ�ݾ�"                  BgColor=#FAFAD2</C>                                             
                            <C> id=PER_DED          width=100   align=right     rightmargin=10    name="���ο���;�������"          </C>                                             
                            <C> id=SAVE_DED          width=100   align=right     rightmargin=10    name="���ø���;����"              </C>                                             
                            <C> id=CARD_DED         width=100   align=right     rightmargin=10    name="�ſ�ī��;����"                </C>                                             
                            <C> id=SAJU_DED         width=100   align=right     rightmargin=10    name="�츮�����⿬;����"              </C>                                             
                            <C> id=LSS_DED         width=100   align=right     rightmargin=10    name="�����������;�����������"         </C>  
                            <C> id=INDED_EXC         width=100   align=right     rightmargin=10    name="�ҵ����;�����ѵ�;�ʰ���"         </C>                            
                            <C> id=TTAX_STD         width=100   align=right     rightmargin=10    name="���ռҵ�;����ǥ��"                  </C>
                            <C> id=TAX_AMT          width=100   align=right     rightmargin=10    name="���⼼��"                        BgColor=#AAFAD2</C>                                                                                  
                           <G> name=���װ��� BgColor="#dae0ee"
                            <C> id=HGR_DED          width=100   align=right     rightmargin=10    name="�ٷμҵ�;���װ���"      </C> 
                            <C> id=AGE_AMT          width=100   align=right     rightmargin=10    name="�ڳ�;���װ���"             </C>  
                            <C> id=ANN_DED          width=100   align=right     rightmargin=10    name="���ݰ���;����"         </C>
                            <C> id=MIN_DED          width=100   align=right     rightmargin=10    name="���强����;���װ���"          </C>                                                                                                         
                            <C> id=MMA_DED          width=100   align=right     rightmargin=10    name="�Ƿ��;���װ���"          </C>
                            <C> id=EDU_DED          width=100   align=right     rightmargin=10    name="������;���װ���"           </C>
                            <C> id=GOV1_DED         width=100   align=right     rightmargin=10    name="��ġ�ڱ�;(10��������)"     </C>
                            <C> id=GOV2_DED          width=100   align=right     rightmargin=10    name="��ġ�ڱ�;(10�����ʰ�)"    </C>
                            <C> id=LC1_DED           width=100   align=right     rightmargin=10    name="������α�"                    </C>
                            <C> id=LC23_DED          width=100   align=right     rightmargin=10    name="������α�"                    </C>
                            <C> id=CPC_DED          width=100   align=right     rightmargin=10    name="��α�;���װ���"           </C>
                            <C> id=NSE_TOT          width=100   align=right     rightmargin=10    name="Ư������;������"             BgColor=#99FF22</C>
                            <C> id=STA_TOT          width=100   align=right     rightmargin=10    name="ǥ�ؼ��װ���"              </C>   
                            <C> id=MRENT_DED       width=100   align=right     rightmargin=10    name="������;���װ���"         </C>                                                       
                            <C> id=TDED_TOT         width=100   align=right     rightmargin=10    name="���װ����� "                   BgColor=#FAFAD2</C>
                           </G> 
                           <G> name=�������� BgColor="#dae0ee"                            
                            <C> id=DGG_TAX          width=100   align=right     rightmargin=10    name=�����ҵ漼                   </C>
                            <C> id=DJM_TAX          width=100   align=right     rightmargin=10    name=�����ֹμ�                   </C>
                            <C> id=DBW_TAX          width=100   align=right     rightmargin=10    name=������Ư��                   </C>                            
                            <C> id=AAA_TOT          width=100   align=right     rightmargin=10    name=�������װ�                    value={DGG_TAX+DJM_TAX+DBW_TAX}   BgColor=#FAFAD2</C>
                           <G> name=�ⳳ�μ��� BgColor="#dae0ee"                            
                            <C> id=AGG_TAX         width=100   align=right     rightmargin=10    name=���μҵ漼                    </C>
                            <C> id=AJM_TAX         width=100   align=right     rightmargin=10    name=�����ֹμ�                    </C>
                            <C> id=CONT_TAX         width=100   align=right     rightmargin=10    name=���γ�Ư��                    </C>                            
                            <C> id=CCC_TOT          width=100   align=right     rightmargin=10    name=���μ��װ�                        value={AGG_TAX +AJM_TAX+CONT_TAX} BgColor=#FAFAD2</C>
                            </G>                            
                           <G> name=ȯ�޼��� BgColor="#dae0ee"                                                    
                            <C> id=DRE_INTX        width=100   align=right     rightmargin=10    name=ȯ�޼ҵ漼                    </C>
                            <C> id=DRE_CTTX        width=100   align=right     rightmargin=10    name=ȯ���ֹμ�                    </C>
                            <C> id=DRE_DFTX        width=100   align=right     rightmargin=10    name=ȯ�޳�Ư��                    </C>                            
                            <C> id=EEE_TOT          width=100   align=right     rightmargin=10    name=ȯ�޼��װ�                    value={DRE_INTX+DRE_CTTX+DRE_DFTX} BgColor=#FFAADD</C>
                            </G>  
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��1 ���� �Է� ���̺� �� -->


<!-- ��2 ���� �Է� ���̺� ���� -->
<div class=page id="tabYACA001_02" style="position:absolute; left:10; top:220; width:1050; height:550; z-index:4; visibility:hidden">

	<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_MEDICAL_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
					<param name="DataID" value="dsT_AC_MEDICAL_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=40		name="NO"								align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=90		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="���"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="�ֹε�Ϲ�ȣ"					align=center		Edit=none		SubBgColor="#99FFCC"	show=false</C>
						<C> id="ENO_NM"				width=70		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"			width=90		name="����ڹ�ȣ"					align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXX-XX-XXXXX"</C>
						<C> id="COM_NM"			width=200		name="��ü��"							align=left			Edit=none		SubBgColor="#99FFCC"	SubSumText=" �� �� "</C>
						<C> id="MED_CD"				width=220		name="�����ڵ�"						align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="�Ǽ�"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="���ޱݾ�"						align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMM_CD"			width=50		name="����"							align=center		Edit=none		SubBgColor="#99FFCC"	show=false</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��2 ���� �Է� ���̺� �� -->

<!-- ��3 ���� �Է� ���̺� ���� -->
<div class=page id="tabYACA001_03" style="position:absolute; left:10; top:220; width:1050; height:550; z-index:4; visibility:hidden">

	<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_DONATION_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
					<param name="DataID" value="dsT_AC_DONATION_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=35		name="NO"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="�Ҽ�"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=80		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="���"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="����"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="�ֹε�Ϲ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"			width=90		name="����ڹ�ȣ"			align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXX-XX-XXXXX"</C>
						<C> id="COM_NM"			width=190		name="��ü��"					align=left			Edit=none		SubBgColor="#99FFCC"	SubSumText=" �� �� "</C>
						<C> id="REL_NM"				width=170		name="�������"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="�Ǽ�"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="�ݾ�"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- ��3 ���� �Է� ���̺� �� -->


</form>
<!-- form �� -->

</body>
</html>