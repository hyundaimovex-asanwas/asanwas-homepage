	<!--*************************************************************************
	* @source      : welf010.jsp												*
	* @description : ���������� PAGE										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/21            ä����          	        �����ۼ�			    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>��� �뿩 ��û(welf012)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

<%
      String ENO_NO = box.getString("SESSION_ENONO") ;        //���
%>
	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//��� �뿩 ��û ��ȸ
			var EQUP_KIND_SHR      = document.getElementById("txtEQUP_KIND_SHR").value;
			var STATE_GBN_SHR      = document.getElementById("cmbSTATE_GBN_SHR").value;
			var REQ_YMD_SHR        = document.getElementById("txtREQ_YMD_SHR").value;

  // alert("/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR&SUP_YMD_SHR="+SUP_YMD_SHR+"&RET_YMD_SHR="+RET_YMD_SHR+"&SERIAL_NO_SHR="+SERIAL_NO_SHR+"&STATE_GBN_SHR="+STATE_GBN_SHR);

			dsT_WL_VISITOR.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf012.cmd.WELF012CMD&S_MODE=SHR&EQUP_KIND_SHR="+EQUP_KIND_SHR+"&STATE_GBN_SHR="+STATE_GBN_SHR+"&REQ_YMD_SHR="+REQ_YMD_SHR;

			dsT_WL_VISITOR.reset();
        }

        /**
         * ��� ��ȣ�� ��밡������ ���θ� �����Ѵ�.
         */
        function fnc_ChkCardNo() {
  //          var SERIAL_NO = document.getElementById("txtSERIAL_NO").value;
  //          if(SERIAL_NO == "") {
  //              return;
  //          }
			var EQUP_KIND_SHR      = document.getElementById("txtEQUP_KIND_SHR").value;
			dsT_WL_VISITOR.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf012.cmd.WELF012CMD&S_MODE=SHR_01&EQUP_KIND_SHR="+EQUP_KIND_SHR;
			dsT_WL_VISITOR.reset();
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

           //
           // trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE, O:dsRESULT=dsRESULT)";
		   // trT_CP_PAYTABLE.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SAV&TYPE="+savObj.type+"&APY_YMD="+savObj.apy_ymd+"&OCC_CD="+savObj.occ_cd;
		   // trT_CP_PAYTABLE.Post();
			var IS_CHK = dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "IS_CHK");

			// save
			trT_WL_VISITOR.KeyValue = "tr01(I:dsT_WL_VISITOR=dsT_WL_VISITOR)";
			trT_WL_VISITOR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf012.cmd.WELF012CMD&S_MODE=SAV";
			trT_WL_VISITOR.post();

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
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ ���� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_WL_VISITOR.CountColumn == 0) {
				dsT_WL_VISITOR.setDataHeader("EQUP_KIND:STRING, PUM_NM:STRING, MODEL_NO:STRING, SERIAL_NO:STRING, DPT_NM:STRING, JOB_NM:STRING, ENO_NM:STRING,  CONFIG:STRING, REQ_YMD:STRING, SUP_YMD:STRING, STATE_GBN:STRING, REMARK:STRING");
			}

			// �� �߰�
			dsT_WL_VISITOR.AddRow();

			// ����ȣ �Է¶����� ��Ŀ�� �̵�
			document.form1.txtSERIAL_NO.selectedIndex = 0;
			document.form1.cmbSTATE_GBN.selectedIndex = 1;
			document.getElementById("txtEQUP_KIND").focus();
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
	        if (dsT_WL_VISITOR.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "SERIAL ��ȣ   = "+dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "SERIAL_NO")+"\n";
            	tmpMSG += "��û�Ͻ�      = "+dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "REQ_YMD")+"\n";

	            if( confirm(tmpMSG) ){
					var SERIAL_NO = dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "SERIAL_NO");
					var REQ_YMD = dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "REQ_YMD");


					dsT_WL_VISITOR.DeleteRow(dsT_WL_VISITOR.RowPosition);

					// �Ķ���� �߰�
					trT_WL_VISITOR.Parameters = "SERIAL_NO = "+SERIAL_NO;
					trT_WL_VISITOR.Parameters = "REQ_YMD = "+REQ_YMD;

					trT_WL_VISITOR.KeyValue = "tr01(I:dsT_WL_VISITOR=dsT_WL_VISITOR)";
					trT_WL_VISITOR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf012.cmd.WELF012CMD&S_MODE=DEL";
					trT_WL_VISITOR.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
			//document.form1.txtSUP_YMD_SHR.value = "";          // ��������(�˻�)
			//document.form1.txtRET_YMD_SHR.value = "";          // ��������(�˻�)
			document.form1.txtSERIAL_NO.selectedIndex = 0;       // Serial ��ȣ
			document.form1.cmbSTATE_GBN.selectedIndex = 1;      // ��뿩��
			document.form1.cmbSTATE_GBN_SHR.selectedIndex = 0;  // ��뿩��(�˻�)

            fnc_DisableElementAll(elementList);
        	dsT_WL_VISITOR.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_VISITOR.IsUpdated)  {
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
         	if ( !dsT_WL_VISITOR.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            // document.getElementById("txtSUP_YMD_SHR").value = getStrDate();
            // document.getElementById("txtRET_YMD_SHR").value = getEndDate();

			//cfStyleGrid(form1.grdT_WL_VISITOR,15,"false","right");      // Grid Style ����-> Sort ����

			  cfStyleGrid(form1.grdT_WL_VISITOR, 0, "true", "false");      // Grid Style ����


            fnc_DisableElementAll(elementList);
            document.getElementById("txtREQ_YMD_SHR").value = getToday();
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



        var elementList = new Array(
                                    "txtPUM_NM"
                                    );
        var exceptionList = new Array(
        					        "txtSERIAL_NO"
                                      );


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
          function fnc_ClickEmpPopup() {
           var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
       }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO','1');
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO","","1");
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
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
    | 2. �̸��� ds_ + �ֿ� ���̺���(T_WL_VISITOR)			 	   |
    | 3. ���Ǵ� Table List(T_WL_VISITOR) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_VISITOR" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<Object ID="dsCHK_SERIAL_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺���(T_WL_VISITOR)			       |
    | 3. ���Ǵ� Table List(T_WL_VISITOR)				       |
    +------------------------------------------------------>
	<Object ID="trT_WL_VISITOR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_VISITOR=dsT_WL_VISITOR,I:dsT_WL_VISITOR=dsT_WL_VISITOR)">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_VISITOR Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_VISITOR.CountRow);
        }
    </Script>

	<Script For=dsCHK_SERIAL_NO Event="OnLoadCompleted(iCount)">
        if(dsCHK_SERIAL_NO.NameString(0, "IS_USE") == "Y") {
            alert("����� �� ���� ����ȣ �Դϴ�.");

            document.getElementById("txtSERIAL_NO").value = "";
            document.getElementById("txtSERIAL_NO").focus();
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_WL_VISITOR Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_VISITOR Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_VISITOR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_VISITOR event="OnFail()">
        alert(trT_WL_VISITOR.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_WL_VISITOR event=CanRowPosChange(row)>
		if ( dsT_WL_VISITOR.NameValue(row,"SERIAL_NO") == "" ) {
			alert("[ " + grdT_WL_VISITOR.GetHdrDispName('-3','SERIAL_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_WL_VISITOR.NameValue(row,"EQUP_KIND") == "" ) {
			alert("[ " + grdT_WL_VISITOR.GetHdrDispName('-3','EQUP_KIND') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}

        if (dsT_WL_VISITOR.NameValue(row, "RET_YMD") != "") {

        	// - alert("[" + dsT_WL_VISITOR.NameValue(row,"REQ_YMD").substring(0, 10) + "]");                               substr ���� ����

            if (dsT_WL_VISITOR.NameValue(row,"REQ_YMD").substring(0, 10) > dsT_WL_VISITOR.NameValue(row,"RET_YMD")) {
                alert("�ݳ����� ��û�� ���� �۽��ϴ�.");
                document.getElementById("txtRET_YMD").value = "";
                document.getElementById("txtRET_YMD").focus();
                return false;
            }
        }

        if( dsT_WL_VISITOR.NameValue(row, "STATE_GBN") == "3" ){ // �ݳ�
            if(dsT_WL_VISITOR.NameValue(row, "RET_YMD") == "") {
                alert("�ݳ� ��� �ݳ����� �Է��ϼŵ˴ϴ�.");
                return false;
            }
        }
	</script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +----------------------------------------------------
    --<script language=JavaScript for=dsT_WL_VISITOR event=OnRowPosChanged(row)>
		fnc_DisableElementAll(elementList);
        if(row > 0) {
            //��û�̰ų�  �̹ݳ��� ��� ������ ������ �� �ִ�.
            if(dsT_WL_VISITOR.RowStatus(row) == "1"
                    || dsT_WL_VISITOR.NameValue(row, "STATE_GBN") == "1") {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
        fnc_EnableElementAll(elementList, exceptionList);
	--</script>

     -->
	<!-----------------------------------------------------+
    | üũ�ڽ� click �ű涧 ó��	   |
    +------------------------------------------------------>
     <script language=JavaScript for=dsT_WL_VISITOR event=OnCheckClick(row,colid,check)>
      <!--     alert("Occur OnCheckClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" + "<CheckState :" + Check + ">")  -->

			alert("�Է»����Դϴ�");
			return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���뿩��û</td>
					<td align="right" class="navigator">HOME/��Ÿ/�������/<font color="#000000">���뿩��û</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_ApplicationOver.gif',1)"><img src="/images/button/btn_ApplicationOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ChkCardNo()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
							<col width="260"></col>
							<col width="60"></col>
							<col width="150"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
						    <td align="right" class="searchState"> ǰ&nbsp;&nbsp;��&nbsp;</td>
							<td class="padding2423"><input type="text" name="txtEQUP_KIND_SHR" id="txtEQUP_KIND_SHR" size="3" maxlength="3" onChange="fnc_GetCommNm('EQ', 'txtEQUP_KIND_SHR','txtPUM_NM_SHR');">
					                        <input type="text" name="txtPUM_NM_SHR"     id="txtPUM_NM_SHR" size="18" class="input_ReadOnly"  readonly>
					                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEQUP_KIND_SHR','txtPUM_NM_SHR','����','EQ')"></a>
                    		</td>
							<td class="searchState" align="right">��뱸��</td>
							<td class="padding2423" align="left">
								<select id="cmbSTATE_GBN_SHR" style="width='50%';" onChange="fnc_SearchList()">
									<option value="">��ü</option>
									<option value="1">��û</option>
									<option value="2">�̹ݳ�</option>
									<option value="3">�ݳ�</option>
									<option value="4">����</option>
								    <option value="5">�ݼ�</option>
								</select>
							</td>
							<td class="searchState" align="right">��û��</td>
							<td class="padding2423" align="left">
						<input type="text" id="txtREQ_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBUY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBUY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtREQ_YMD_SHR','','150','200');">����~</a>
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

	<!--  �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="100"></col>
					<col width="100"></col>
					<col width="100"></col>
					<col width="60"></col>
					<col width="*"></col>

				</colgroup>
				<tr>
					<td align="center" class="creamBold">ǰ��</td>
					<td class="padding2423"><input type="text" name="txtEQUP_KIND" id="txtEQUP_KIND" size="3" maxlength="3" onChange="fnc_GetCommNm('EQ', 'txtEQIP_KIND','txtPUM_NM');" class="input_ReadOnly"  readonly>
					                        <input type="text" name="txtPUM_NM"     id="txtPUM_NM" size="18" class="input_ReadOnly"  readonly>
					                  <!--       <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEQUP_KIND','txtPUM_NM','�������','EQ')"></a>  -->
                    </td>
					<td align="center" class="creamBold">�𵨸�</td>
					<td class="padding2423">
                        <input type="text" name="txtMODEL_NO" id="txtMODEL_NO" size="15" maxlength="30" class="input_ReadOnly"  readonly>
					</td>
					<td align="center" class="creamBold">Serial No</td>
					<td class="padding2423">
                        <input type="text" name="txtSERIAL_NO" id="txtSERIAL_NO" size="15" maxlength="30" class="input_ReadOnly"  readonly>
					</td>
					<td align="center" class="creamBold">���</td>
					<td class="padding2423">
                        <input type="text" name="txtCONFIG" id="txtCONFIG" size="15" maxlength="30" class="input_ReadOnly"  readonly>
				</tr>

				<tr>
					<td align="center" class="creamBold">��뱸��</td>
					<td class="padding2423" align="left">
						<select id="cmbSTATE_GBN" style="width='50%">
									<option value="1">��û</option>
									<option value="2">�̹ݳ�</option>
									<option value="3">�ݳ�</option>
									<option value="4">����</option>
								    <option value="5">�ݼ�</option>
							</select>
					</td>
					<td align="center" class="creamBold">��û����</td>
					<td class="padding2423">
						<input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="10" maxlength="30" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBUY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBUY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtREQ_YMD','','150','200');"></a>
					</td>
                    <td align="center" class="creamBold">�ݳ�����</td>
					<td class="padding2423">
						<input type="text" id="txtRET_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSUP_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSUP_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtRET_YMD','','150','200');"></a>
					</td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
                        <input type="text" name="txtAPP_MAN" id="txtAPP_MAN" size="15" maxlength="30" class="input_ReadOnly"  readonly>
				</tr>
				<tr>
					<td align="left" class="creamBold">����/�Ⱓ</td>
                    <td class="padding2423" colspan="3" >
                    	<input type="text" name="txtREMARK" id="txtREMARK" size="57" maxlength="80" >
                    </td>
					<td align="center" class="creamBold">�ݼۻ���</td>
                    <td class="padding2423" colspan="3" >
                    	<input type="text" name="txtAPP_RMK" id="txtAPP_RMK" size="45" maxlength="80"  class="input_ReadOnly"  readonly>
                    </td>
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
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_VISITOR" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_VISITOR">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
                            <C> id="IS_CHK"     width=70    name="����"         align=center    Edit=True EditStyle=CheckBox,Pointer=Hand   HeadCheckShow=true  </C>
							<C> id="EQUP_KIND"	width=50	name="�з�"			sort=true align=center	Edit=TRUE</C>
							<C> id="PUM_NM"		width=100	name="ǰ��"			sort=true align=left	Edit=none</C>
							<C> id="MODEL_NO"	width=120	name="�𵨸�"		sort=true align=left	Edit=none</C>
							<C> id="SERIAL_NO"	width=120	name="SERIAL NO"	sort=true align=left	Edit=none</C>
							<C> id="CONFIG" 	width=130	name="���" 		sort=true align=left	Edit=none</C>
							<C> id="STATE_GBN"	width=80	name="���±���"		sort=true align=center	Edit=none	EditStyle=Combo		Data = "1:��û,2:�̹ݳ�,3:�ݳ�,4:����,5:�ݼ�"</C>
							<C> id="DPT_NM" 	width=80	name="�Ҽ�" 		sort=true align=center	Edit=none</C>
							<C> id="JOB_NM" 	width=60	name="����" 		sort=true align=left	Edit=none</C>
							<C> id="ENO_NM" 	width=80	name="����" 		sort=true align=center	Edit=none</C>
							<C> id="REQ_YMD"	width=80	name="��û��"		sort=true align=left	Edit=none</C>
							<C> id="REMARK"		width=150	name="��û ����/�Ⱓ"   	sort=true align=left	Edit=none</C>
							<C> id="SUP_YMD"	width=80	name="������"		sort=true align=center	Edit=none</C>
							<C> id="RET_YMD"	width=80	name="�ݳ���"		sort=true align=left	Edit=none</C>
							<C> id="APP_YMD"	width=80	name="������"		sort=true align=left	Edit=none</C>
							<C> id="APP_MAN"	width=80	name="������"		sort=true align=left	Edit=none</C>
							<C> id="APP_RMK"	width=150	name="�ݼۻ���"		sort=true align=left	Edit=none</C>

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

	<!-- T_WL_VISITOR ���� ���̺� -->
	<object id="bndT_WL_VISITOR" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_VISITOR">
		<Param Name="BindInfo", Value="
			<C>Col=EQUP_KIND	Ctrl=txtEQUP_KIND	Param=value</C>
			<C>Col=PUM_NM 		Ctrl=txtPUM_NM 		Param=value</C>
			<C>Col=MODEL_NO		Ctrl=txtMODEL_NO	Param=value</C>
			<C>Col=SERIAL_NO    Ctrl=txtSERIAL_NO	Param=value</C>
			<C>Col=CONFIG       Ctrl=txtCONFIG  	Param=value</C>
			<C>Col=STATE_GBN	Ctrl=cmbSTATE_GBN	Param=value</C>
			<C>Col=REMARK	    Ctrl=txtREMARK  	Param=value</C>
            <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value</C>
            <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value</C>
            <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value</C>
            <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=SUP_YMD		Ctrl=txtSUP_YMD		Param=value</C>
			<C>Col=RET_YMD		Ctrl=txtRET_YMD		Param=value</C>
			<C>Col=APP_YMD		Ctrl=txtAPP_YMD		Param=value</C>
			<C>Col=APP_MAN		Ctrl=txtAPP_MAN		Param=value</C>
			<C>Col=APP_RMK		Ctrl=txtAPP_RMK		Param=value</C>
			<C>Col=IS_CHK       Ctrl=txtIS_CHK  	Param=value</C>
		">
	</object>