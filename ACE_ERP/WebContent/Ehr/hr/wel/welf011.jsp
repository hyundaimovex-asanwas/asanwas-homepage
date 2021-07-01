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
	<title>����������(welf011)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>
<%
	String ENO_NO = request.getParameter("ENO_NO");         //���
	String Gubun = request.getParameter("GUBUN");
	String mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
%>
	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFFF';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {


  // alert("/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR&SUP_YMD_SHR="+SUP_YMD_SHR+"&RET_YMD_SHR="+RET_YMD_SHR+"&SERIAL_NO_SHR="+SERIAL_NO_SHR+"&USE_GBN_SHR="+USE_GBN_SHR);


			dsT_WL_VISITOR.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SHR_01&ENO_NO_SHR=<%=ENO_NO%>";
			dsT_WL_VISITOR.reset();
        }

        /**
         * ��� ��ȣ�� ��밡������ ���θ� �����Ѵ�.
         */
        function fnc_ChkCardNo() {
            var SERIAL_NO = document.getElementById("txtSERIAL_NO").value;
            if(SERIAL_NO == "") {
                return;
            }
			dsCHK_SERIAL_NO.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=CHK&SERIAL_NO="+SERIAL_NO;
			dsCHK_SERIAL_NO.reset();
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


			// save
			trT_WL_VISITOR.KeyValue = "tr01(I:dsT_WL_VISITOR=dsT_WL_VISITOR)";
			trT_WL_VISITOR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=SAV";
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
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_WL_VISITOR.CountColumn == 0) {
				dsT_WL_VISITOR.setDataHeader("EQUP_KIND:STRING, PUM_NM:STRING, MODEL_NO:STRING, SERIAL_NO:STRING, DPT_NM:STRING, JOB_NM:STRING, ENO_NM:STRING,  CONFIG:STRING, BUY_YMD:STRING, SUP_YMD:STRING, USE_GBN:STRING, REMARK:STRING, ASST_NO:STRING, ASST_AMT:DECIMAL(15.0), DPT_NM1:STRING, REG_NM:STRING");
			}

			// �� �߰�
			dsT_WL_VISITOR.AddRow();

			// ����ȣ �Է¶����� ��Ŀ�� �̵�
			document.form1.txtSERIAL_NO.selectedIndex = 0;
			document.form1.cmbUSE_GBN.selectedIndex = 0;
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
			//	fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "SERIAL ��ȣ   = "+dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "SERIAL_NO")+"\n";

	            if( confirm(tmpMSG) ){
					var SERIAL_NO = dsT_WL_VISITOR.nameValue(dsT_WL_VISITOR.RowPosition, "SERIAL_NO");

					dsT_WL_VISITOR.DeleteRow(dsT_WL_VISITOR.RowPosition);

					// �Ķ���� �߰�
					trT_WL_VISITOR.Parameters = "SERIAL_NO = "+SERIAL_NO;

					trT_WL_VISITOR.KeyValue = "tr01(I:dsT_WL_VISITOR=dsT_WL_VISITOR)";
					trT_WL_VISITOR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.f.welf010.cmd.WELF010CMD&S_MODE=DEL";
					trT_WL_VISITOR.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {


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
			//	fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {


             document.getElementById("ENO_NO").value = "<%=ENO_NO%>";
              fnc_SearchList() ; //��ȸ
			//cfStyleGrid(form1.grdT_WL_VISITOR,15,"false","right");      // Grid Style ����-> Sort ����
			cfStyleGrid(form1.grdT_WL_VISITOR, 0,"false","false");


            fnc_DisableElementAll(elementList);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_VISITOR)			 	   |
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
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_VISITOR)			       |
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
		//	fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
		//	fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_VISITOR.CountRow);
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
	//	fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
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


	</script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +----------------------------------------------------
    --<script language=JavaScript for=dsT_WL_VISITOR event=OnRowPosChanged(row)>
		fnc_DisableElementAll(elementList);
        if(row > 0) {
            //��û�̰ų�  �̹ݳ��� ��� ������ ������ �� �ִ�.
            if(dsT_WL_VISITOR.RowStatus(row) == "1"
                    || dsT_WL_VISITOR.NameValue(row, "USE_GBN") == "1") {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
        fnc_EnableElementAll(elementList, exceptionList);
	--</script>

     -->

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">
	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<input type=hidden id="ENO_NO" size="10">

	<!-- ��ư ���̺� ���� -->
	<table width="794" border="0" cellspacing="0" cellpadding="0">
		<tr>
	        <td class="paddingTop8">
    	        <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
        	    <strong>���κ� ������� ����</strong>
	        </td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->





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
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="EQUP_KIND"	width=50	name="�з�"			sort=true align=center	Edit=none</C>
							<C> id="PUM_NM"		width=100	name="ǰ��"			sort=true align=center	Edit=none</C>
							<C> id="MODEL_NO"	width=120	name="�𵨸�"		sort=true align=center	Edit=none</C>
							<C> id="SERIAL_NO"	width=120	name="SERIAL NO"	sort=true align=center	Edit=none</C>
							<C> id="CONFIG" 	width=130	name="���" 		sort=true align=center	Edit=none</C>
							<C> id="SUP_YMD"	width=80	name="������"		sort=true align=center	Edit=none</C>
							<C> id="BUY_YMD"	width=80	name="������"		sort=true align=center	Edit=none</C>
							<C> id="ASST_NO"	width=80	name="�ڻ��ȣ"		sort=true align=center	Edit=none</C>
							<C> id="ASST_AMT"	width=80	name="���ݾ�"		sort=true align=center	Edit=none</C>
							<C> id="REMARK"		width=150	name="���"     	sort=true align=center	Edit=none</C>
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
            <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value</C>
            <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value</C>
            <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value</C>
            <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value</C>
			<C>Col=BUY_YMD		Ctrl=txtBUY_YMD		Param=value</C>
			<C>Col=SUP_YMD		Ctrl=txtSUP_YMD		Param=value</C>
			<C>Col=EQUP_KIND	Ctrl=txtEQUP_KIND	Param=value</C>
			<C>Col=PUM_NM 		Ctrl=txtPUM_NM 		Param=value</C>
			<C>Col=MODEL_NO		Ctrl=txtMODEL_NO	Param=value</C>
			<C>Col=SERIAL_NO    Ctrl=txtSERIAL_NO	Param=value</C>
			<C>Col=CONFIG       Ctrl=txtCONFIG  	Param=value</C>
			<C>Col=REMARK       Ctrl=txtREMARK  	Param=value</C>
			<C>Col=USE_GBN		Ctrl=cmbUSE_GBN	Param=value</C>
			<C>Col=ASST_NO		Ctrl=txtASST_NO		Param=value</C>
			<C>Col=ASST_AMT		Ctrl=txtASST_AMT	Param=value</C>
			<C>Col=DPT_NM1		Ctrl=txtDPT_NM1		Param=value</C>
			<C>Col=REG_NM		Ctrl=txtREG_NM		Param=value</C>
		">
	</object>