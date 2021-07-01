	<!--*************************************************************************
	* @source      : welc020.jsp												*
	* @description : �ǰ����� ������� PAGE										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/05            ä����          	        �����ۼ�									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
	<title>�ǰ����� �������(welc020)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//�ǰϰ��� ��� ���� ��ȸ
			var stdt = document.getElementById("txtPRO_YMD_STDT_SHR").value;
			var endt = document.getElementById("txtPRO_YMD_ENDT_SHR").value;
			var dptCd = document.getElementById("txtDPT_CD_SHR").value.toUpperCase();
			// �ҹ��� �˻��� �빮�ڷ� ��ȯ
			document.getElementById("txtDPT_CD_SHR").value = dptCd;

            dsT_CM_BODY.UseChangeInfo = true;
			dsT_CM_BODY.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD&S_MODE=SHR&PRO_YMD_STDT_SHR="+stdt+"&PRO_YMD_ENDT_SHR="+endt+"&DPT_CD_SHR="+dptCd;
			dsT_CM_BODY.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_CM_BODY.KeyValue = "tr01(I:dsT_CM_BODY=dsT_CM_BODY)";
			trT_CM_BODY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD&S_MODE=SAV";
			trT_CM_BODY.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CM_BODY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_BODY.GridToExcel("�ǰ����� �������", '', 225)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_CM_BODY.CountColumn == 0) {
				dsT_CM_BODY.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, CET_NO:STRING, PRO_YMD:STRING, EYE_LEF:DECIMAL(2.1), EYE_RHT:DECIMAL(2.1), HEIGHT:STRING, WEIGHT:STRING, AB_HGT:STRING, CBLD_CD:STRING, BLD_TYP:STRING, BLD_PRE:STRING, PH:STRING, XRY_RMK:STRING, EXM_HSP:STRING, DECISION:STRING, SPEC:STRING");
			}

			// �Է��ʵ� ��밡���ϰ�
			enableInput();

			// �� �߰�
			dsT_CM_BODY.AddRow();

			// ��¥ �Է¶����� ��Ŀ�� �̵�
			document.form1.cmbCBLD_CD.selectedIndex = 0;
			document.form1.cmbBLD_TYP.selectedIndex = 0;
			document.form1.txtEYE_LEF.value = "";
			document.form1.txtEYE_RHT.value = "";
			document.getElementById("txtPRO_YMD").focus();

            fnc_EnableElementAll(new Array("txtENO_NO", "txtENO_NM"));
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_CM_BODY.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "��� = "+dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "����  = "+dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "��������  = "+dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "PRO_YMD")+"\n";

	            if( confirm(tmpMSG) ){
					var ENO_NO = dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "ENO_NO");
					var PRO_YMD = dsT_CM_BODY.nameValue(dsT_CM_BODY.RowPosition, "PRO_YMD");

					dsT_CM_BODY.DeleteRow(dsT_CM_BODY.RowPosition);
							// �Ķ���� �߰�
					trT_CM_BODY.Parameters = "ENO_NO="+ENO_NO+",PRO_YMD="+PRO_YMD;

					trT_CM_BODY.KeyValue = "tr01(I:dsT_CM_BODY=dsT_CM_BODY)";
					trT_CM_BODY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD&S_MODE=DEL";
					trT_CM_BODY.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
	        document.getElementById("txtDPT_CD_SHR").value = "";
	        document.getElementById("txtDPT_NM_SHR").value = "";

	        document.getElementById("resultMessage").innerText = ' ';

        	disableInput();
        	dsT_CM_BODY.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CM_BODY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
            if ( !dsT_CM_BODY.isUpdated && dsT_CM_BODY.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
			for( var i = 1; i <= dsT_CM_COMMON.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCBLD_CD").add(oOption);
			}

            document.getElementById("txtPRO_YMD_STDT_SHR").value = getStrDate();
            document.getElementById("txtPRO_YMD_ENDT_SHR").value = getEndDate();

			cfStyleGrid(form1.grdT_CM_BODY,15,"true","false");      // Grid Style ����
			disableInput();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"txtPRO_YMD"
                                    ,"txtEYE_LEF"
                                    ,"txtEYE_RHT"
                                    ,"txtHEIGHT"
                                    ,"txtWEIGHT"
                                    ,"txtAB_HGT"
                                    ,"cmbCBLD_CD"
                                    ,"cmbBLD_TYP"
                                    ,"txtBLD_PRE"
                                    ,"txtPH"
                                    ,"txtXRY_RMK"
                                    ,"txtEXM_HSP"
                                    ,"txtDECISION"
                                    ,"txtSPEC"
                                    ,"FindEmpl"
                                    ,"ImgPRO_YMD"
                                    );

        var exceptionList = new Array(
                                     "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"txtPRO_YMD"
                                    ,"FindEmpl"
                                    ,"ImgPRO_YMD"
                                    );

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  			fnc_EnableElementAll(elementList);
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  			fnc_DisableElementAll(elementList);
  		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO");
            fnc_ClearInputFieldAll(new Array("txtENO_NO", "txtENO_NM", "txtCET_NO"));
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
            }
        }



        /**
         * EXCEL ��� ������ ���ε� ��Ű�� DS�� �߰� ���Ѽ� ��������
         */
        function fnc_FileUpload() {

            //file�� binding ��Ų��.
            if(!bindingFile())
                return;

            //���ε� �ϱ� ���� ��ȸ�� ������ �ʱ�ȭ ��Ų��.
            dsT_CM_BODY.ClearData();

            //ds���� ���� ���ε�
            trFILE_UPLOAD.KeyValue = "TR_FILE"
                                   + "(I:dsFILE_UPLOAD=dsFILE_UPLOAD"                   //���ε��� ����
                                   + ",O:dsT_CM_BODY=dsT_CM_BODY"         //��� ����Ʈ
                                   + ",O:dsRESULT=dsRESULT"
                                   + ")";

            trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.wel.c.welc020.cmd.WELC020CMD"
                                 + "&S_MODE=ULD";
            trFILE_UPLOAD.post();
        }

        /**
         * DataSet �� FILE �� ���ε� ��Ų��.
         */
        function bindingFile() {
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            return true;
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_BODY)			 	   |
    | 3. ���Ǵ� Table List(T_CM_BODY) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_BODY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON"/>
       <jsp:param name="CODE_GUBUN"    value="D4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton                          |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_BODY)                  |
    | 3. ���Ǵ� Table List(T_CM_BODY)                    |
    +------------------------------------------------------>
    <Object ID="trT_CM_BODY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <Param Name=KeyValue Value="sample_tr01(O:dsT_CM_BODY=dsT_CM_BODY,I:dsT_CM_BODY=dsT_CM_BODY)">
    </Object>

    <!-----------------------------------------------------+
    | 1. FILE UPLOAD��  Data Transacton                       |
    +------------------------------------------------------>
    <Object ID="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CM_BODY Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_BODY.CountRow);

			// ���,�̸�,�ֹι�ȣ,�������� ���� ��������
			fnc_EnableElementAll(elementList, exceptionList);
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowPopup("�ǰ����� ���� ���� ��� ���", dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_BODY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsFILE_UPLOAD Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_BODY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_CM_BODY event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		//fnc_SearchList();
    </script>

    <script for=trFILE_UPLOAD event="OnSuccess()">
        dsT_CM_BODY.UseChangeInfo = "false";
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_CM_BODY event="OnFail()">
        alert(trT_CM_BODY.ErrorMsg);
    </script>

    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_CM_BODY event=CanRowPosChange(row)>
		if ( dsT_CM_BODY.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_CM_BODY.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}else if ( dsT_CM_BODY.NameValue(row,"PRO_YMD") == "" ) {
			alert("[ " + grdT_CM_BODY.GetHdrDispName('-3','PRO_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ǰ����� �������</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ǰ�����/<font color="#000000">�ǰ����� �������</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"     onClick="fnc_ToExcel()"     ><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle"     ></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <col width="60"></col>
                            <col width="300"></col>
                            <col width="60"></col>
                            <col width="300"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">��������</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtPRO_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPRO_YMD_STDT_SHR','','97','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~
                                <input type="text" id="txtPRO_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPRO_YMD_ENDT_SHR','','212','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td class="searchState" align="right">�μ�</td>
                            <td class="padding2423"><input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
                                </a>
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
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="25"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="FindEmpl" name="FindEmpl" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>
					<td align="center" class="creamBold">�ֹι�ȣ</td>
					<td class="padding2423">
                        <input id="txtCET_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
                    </td>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423" colspan="3">
						<input type="text" id="txtPRO_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPRO_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="ImgPRO_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtPRO_YMD','','570','155');"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�½÷�</td>
					<td class="padding2423"><input id="txtEYE_LEF" size="10" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"></td>
					<td align="center" class="creamBold">��÷�</td>
					<td class="padding2423"><input id="txtEYE_RHT" size="10" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"></td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
                        <input id="txtHEIGHT" size="10" maxLength="5" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"> cm
                    </td>
					<td align="center" class="creamBold">ü��</td>
					<td class="padding2423" colspan="3">
                        <input id="txtWEIGHT" size="10" maxLength="5" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"> kg
                    </td>
				</tr>
				<tr>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
                        <input id="txtAB_HGT" size="10" maxLength="5" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"> cm
                    </td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
						<select id="cmbCBLD_CD" style="width:70%"></select>
					</td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<select id="cmbBLD_TYP" style="width:70%">
							<option value="A">A��</option>
							<option value="B">B��</option>
							<option value="O">O��</option>
							<option value="AB">AB��</option>
						</select>
					</td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423"><input id="txtBLD_PRE" size="10" maxLength="8" style="ime-mode:disabled" onKeypress="cfCheckNumber4()"></td>
					<td align="center" class="creamBold">pH</td>
					<td class="padding2423"><input id="txtPH" size="10" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber3()"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">X���Ұ�</td>
					<td class="padding2423"><input id="txtXRY_RMK" size="15" maxLength="5"></td>
					<td align="center" class="creamBold">�˻纴��</td>
					<td class="padding2423"><input id="txtEXM_HSP" size="15" maxLength="5"></td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
                        <input id="txtDECISION" size="10" maxLength="3">
                    </td>
					<td align="center" class="creamBold">Ư�����</td>
					<td class="padding2423" colspan="3"><input id="txtSPEC" size="30" maxLength="20"></td>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td width="80" style="padding-right:5px; padding-top:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('welc020.xls', '<%=FILEURL %>/welc020.xls');"></a>
                        </td>
	                    <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                        </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_BODY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_CM_BODY">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=40	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="ENO_NO"		width=60	name="���"			align=center	Edit=none</C>
							<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none</C>
							<C> id="CET_NO"		width=95	name="�ֹι�ȣ"		align=center	Edit=none</C>
							<C> id="PRO_YMD"	width=70	name="��������"		align=center	Edit=none</C>
							<C> id="EYE_LEF"	width=30	name="��;�÷�"		align=center	Edit=none</C>
							<C> id="EYE_RHT"	width=30	name="��;�÷�"		align=center	Edit=none</C>
							<C> id="HEIGHT"		width=40	name="����"			align=center	Edit=none</C>
							<C> id="WEIGHT"		width=40	name="ü��"			align=center	Edit=none</C>
							<C> id="AB_HGT"		width=40	name="����"			align=center	Edit=none</C>
							<C> id="CBLD_CD"	width=55	name="�����ڵ�"		align=center	Edit=none EditStyle=Lookup  Data="dsT_CM_COMMON:CODE:CODE_NAME" </C>
							<C> id="BLD_TYP"	width=30	name="����;��"		align=center	Edit=none</C>
							<C> id="BLD_PRE"	width=55	name="����"			align=left		Edit=none</C>
							<C> id="PH"			width=40	name="pH"			align=center	Edit=none	Dec=1</C>
							<C> id="XRY_RMK"	width=50	name="X��;�Ұ�"		align=left		Edit=none</C>
							<C> id="EXM_HSP"	width=80	name="�˻纴��"		align=left		Edit=none</C>
							<C> id="DECISION"	width=50	name="����"			align=left		Edit=none</C>
							<C> id="SPEC"		width=250	name="Ư�����"		align=left		Edit=none</C>
						'>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_CM_BODY ���� ���̺� -->
	<object id="bndT_CM_BODY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CM_BODY">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=CET_NO		Ctrl=txtCET_NO		Param=value</C>
			<C>Col=PRO_YMD		Ctrl=txtPRO_YMD		Param=value</C>
			<C>Col=EYE_LEF		Ctrl=txtEYE_LEF		Param=value</C>
			<C>Col=EYE_RHT		Ctrl=txtEYE_RHT		Param=value</C>
			<C>Col=HEIGHT		Ctrl=txtHEIGHT		Param=value</C>
			<C>Col=WEIGHT		Ctrl=txtWEIGHT		Param=value</C>
			<C>Col=AB_HGT		Ctrl=txtAB_HGT		Param=value</C>
			<C>Col=CBLD_CD		Ctrl=cmbCBLD_CD		Param=value</C>
			<C>Col=BLD_TYP		Ctrl=cmbBLD_TYP		Param=value</C>
			<C>Col=BLD_PRE		Ctrl=txtBLD_PRE		Param=value</C>
			<C>Col=PH			Ctrl=txtPH			Param=value</C>
			<C>Col=XRY_RMK		Ctrl=txtXRY_RMK		Param=value</C>
			<C>Col=EXM_HSP		Ctrl=txtEXM_HSP		Param=value</C>
			<C>Col=DECISION		Ctrl=txtDECISION	Param=value</C>
			<C>Col=SPEC			Ctrl=txtSPEC		Param=value</C>
		">
	</object>