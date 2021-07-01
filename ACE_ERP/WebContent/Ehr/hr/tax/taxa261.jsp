	<!--*************************************************************************
	* @source      : taxa250.jsp												*
	* @description : ������û PAGE 												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/20            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String REQ_NO = request.getParameter("REQ_NO");
%>

<html>
<head>
	<title>������û(taxa250)</title>
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

		var btnList = 'TTFTFTTT';
		var today = getToday();
        var trTypeMsg = "";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            dsT_AC_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SHR&REQ_NO=<%=REQ_NO %>";
            dsT_AC_CEFBOOK.reset();
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
        function fnc_Save(sts) {
            //���°� ��û�̸� ���°��� ���� ��Ų��.
            if(dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'CEF_STS') == "B") {
    			dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'CEF_STS') = sts;
    			if(sts == "F" || sts == "E"){
    				dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'SPL_YMD') = today;
    			}

    			if ( !fnc_SaveItemCheck() ) {
    				return;
    			}

                //��� �޼����� ��� �ϱ� ����
                if(sts == "C")
                    trTypeMsg = "�ݼ�";
                else if(sts == "E")
                    trTypeMsg = "�߱�";

    			// save
    			trT_AC_CEFBOOK.KeyValue = "tr01(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
    			trT_AC_CEFBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SAV";
    			trT_AC_CEFBOOK.post();
            }

            //�μ� ȣ��- �߱޹�ư�� ������ �ٷ� ȣ��
            if(sts == "E")
                fnc_Print();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            if(dsT_AC_CEFBOOK.RowPosition == "0") return;

            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_CNT = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_CNT");  //�߱޸ż�
            var CEF_RSN = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN");  //�߱޻���
            var REQ_NO  = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");   //�߱޹�ȣ

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var STR_YMD  = document.getElementById("txtREQ_YMD").value;
            var STR_YY  = document.getElementById("txtCEF_YY").value.substring(0,4);
            var STR_YM  = document.getElementById("txtCEF_YY").value;
			var DPT_CD ="";

            if(CEF_STS != "E" && CEF_STS != "F") {
                alert("���°� �߱��̳� ��������� �ƴϸ� ����Ͻ� �� �����ϴ�.");
                return;
            }
        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("�μ��Ͻ� ������ �����ϴ�.");
                return;
            }

			//01^�ٷμҵ��õ¡�� ������,02^�ٷμҵ��õ¡����,03^�����ҵ��õ¡�� ������,04^���ټ���õ¡������
			if(CEF_SEC == "01"){  //�ٷμҵ��õ¡�� ������
				var url = "taxa160_PV.jsp"
	                    + "?PIS_YY="+STR_YY   //����⵵
	                    + "&ENO_NO="+ENO_NO     //���
	                    + "&DPT_CD="+DPT_CD 		//�μ��ڵ�
	                    + "&STR_YMD="+STR_YMD	//��û����
	                    + "&CEF_CNT="+CEF_CNT
	                    + "&TYPE=E&STP_GBN=2&TAX_GBN=8&PRT_GBN=1&CHK_OCC=ALL&SEND_PARM=1";
	                    //+ "&TYPE="+TYPE			//������ E : ������� ��� �Ѵ�.
	                    //+ "&STP_GBN="+STP_GBN	//������� ���� : ������ ������� : 1
	                    //+ "&TAX_GBN="+TAX_GBN   //���걸��:1��������
	                    //+ "&PRT_GBN="+PRT_GBN   //���� ����(������ 1: �ҵ���,������)
	                    //+ "&CHK_OCC="+CHK_OCC;  //�ٷα��б���(���⼭�� ���ǹ�)
            }else if(CEF_SEC == "02"){  //�ٷμҵ� ��õ¡����

            	var url = "taxa080_PV.jsp"
                    + "?PIS_YY="+STR_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                    + "&CEF_CNT="+CEF_CNT
                    + "&TYPE=2&SEND_PARM=1";

            }else if(CEF_SEC == "03"){  //�����ҵ� ��õ¡��������

            	var url = "taxa170_PV.jsp"
                    + "?PIS_YM="+STR_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&STP_GBN=2"//+STP_GBN
                    + "&CEF_CNT="+CEF_CNT
                    + "&PRT_GBN=1"//+PRT_GBN;

            }else if(CEF_SEC == "04"){  //���ټ� ����

				var url = "taxa180_PV.jsp"
                    + "?PIS_YY="+STR_YM.replace("-","")
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                    + "&CEF_CNT="+CEF_CNT
//                    + "&JOB_CD="+JOB_CD
                    + "&IS_YEAR_AMT=Y"//+IS_YEAR_AMT
                   // + "&DOC1="+DOC1
                   // + "&DOC2="+DOC2
                   // + "&DOC3="+DOC3;
            }
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {

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

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			window.close();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
            if ( !dsT_AC_CEFBOOK.isUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
            return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);
            fnc_HiddenElement("btnC");      //�ݼ�
            fnc_HiddenElement("btnE");      //�߱�

            fnc_SearchList();
        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        //�Է� element��
        var elementList = new Array(     "txtHIR_CNT"
                                        ,"txtEXP_CNT"
                                        ,"txtRET_CNT"
                                        ,"txtCAR_CNT"
                                        ,"txtREMARK"
                                        ,"rdoCEF_SEC"
                                        ,"txtCEF_CNT"
                                        ,"txtCEF_YY"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM");

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_CEFBOOK)			   |
    | 3. ���Ǵ� Table List(T_AC_CEFBOOK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_AC_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">

	</Object>

	<Object ID="dsT_AC_CEFBOOK_UPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_CEFBOOK)			   |
    | 3. ���Ǵ� Table List(T_AC_CEFBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_AC_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsT_AC_CEFBOOK)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->

    <!-- ���� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R3"/>
       <jsp:param name="CODE_GUBUN"    value="R3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnLoadCompleted(iCount)">
		if (iCount != 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_CEFBOOK.CountRow);

        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_CEFBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* "+trTypeMsg+" �۾��� �Ϸ� �Ͽ����ϴ�!");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_AC_CEFBOOK event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AC_CEFBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        fnc_HiddenElement("btnC");      //�ݼ�
        fnc_HiddenElement("btnE");      //�߱�

        if(row > 0) {
            var CEF_STS = dsT_AC_CEFBOOK.NameString(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");

            //��û ���°� �ƴϸ� ���� ���� ���� ����
            if(CEF_STS == "B")
                fnc_ShowElement("btnC");    //�ݼ�

            //���°� ��û�̰ų� �߱��̰ų� ��������� ��� �߱޹�ư ���̰�
            if(CEF_STS == "B"
                    || CEF_STS == "E"
                    || CEF_STS == "F" )
                fnc_ShowElement("btnE");    //�߱�

        }
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_AC_CEFBOOK event=CanRowPosChange(row)>
		if ( dsT_AC_CEFBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_AC_CEFBOOK.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_AC_CEFBOOK.NameValue(row,"CEF_CNT") == "" ) {
			alert("[ " + grdT_AC_CEFBOOK.GetHdrDispName('-3','CEF_CNT') + " ]�� �ʼ� �Է»����Դϴ�");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������û</td>
					<td align="right" class="navigator">HOME/��������/�����߱ް���/<font color="#000000">������û</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

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
            <td height="35" class="paddingTop5" width="260" align="right">
                <img src="/images/button/btn_SendbackOn.gif" id="btnC" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('C');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnC','','/images/button/btn_SendbackOver.gif',1)">
                <img src="/images/button/btn_IssueOn.gif"    id="btnE" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('E');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnE','','/images/button/btn_IssueOver.gif',1)">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->


	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="180"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">��û��ȣ</td>
			<td class="padding2423" align="left">
				<input id="txtREQ_NO" name="txtREQ_NO" size="12"  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">���</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
            </td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423" align="left">
				<input id="txtJOB_NM" name="txtJOB_NM" size="10" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidJOB_CD">
			</td>
			<td align="center" class="creamBold">�μ�</td>
			<td class="padding2423" align="left">
				<input id="txtDPT_NM" name="txtDPT_NM" size="15" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidDPT_CD">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtPER_ADR" name="txtPER_ADR" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">�ּ�</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtADDRESS" name="txtADDRESS" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">

		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="230"></col>
			<col width="60"></col>
			<col width="100"></col>
            <col width="60"></col>
            <col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold" rowspan="4">����<br>����</td>
			<td class="padding2423" align="left" rowspan="4">

                <comment id="__NSID__">
                    <object id=rdoCEF_SEC classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200;height:90;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^�ٷμҵ��õ¡�� ������,02^�ٷμҵ��õ¡����,03^�����ҵ��õ¡�� ������,04^���ټ���õ¡������">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>

			</td>
			<td align="center" class="creamBold">�뵵</td>
			<td class="padding2423" colspan="3">
                <input type="text" id="txtCEF_RSN_NM" style="width:100%" class="input_ReadOnly" readonly>
			</td>

            <td align="center" class="creamBold">�ż�</td>
            <td class="padding2423">
                <input id="txtCEF_CNT" size="4"  maxlength="2" style="ime-mode:disabled">
            </td>
		</tr>
		<tr>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423" colspan="5">
				<input type="text" id="txtREMARK" style="width:100%" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
            <td align="center" class="creamBold">�ͼӳ��</td>
            <td class="padding2423" align="left">
                <input type="text" id="txtCEF_YY" style="ime-mode:disabled" size="7" maxlength= "7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
            </td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_STS_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">��û����</td>
			<td class="padding2423">
				<input type="text" id="txtREQ_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">�߱޹�ȣ</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtCEF_NO" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">�߱�����</td>
			<td class="padding2423">
				<input type="text" id="txtSPL_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr>
			<td>
            [���� ��û���]<br>
			&nbsp;&nbsp;1. ���� ������ �����ϼ���.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. ��û�� ������ �ż��� �Է��ϰ� ��û�뵵�� �����ϼ���.<br>
			[������� ����]<br>
			&nbsp;&nbsp;��������� ������ ���� ������ ����� �� ������ ���ΰ� ��������� �̹��� ó�� �˴ϴ�.
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->

</body>
</html>


	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_CEFBOOK ���� ���̺� -->
	<object id="bndT_AC_CEFBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_CEFBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=PER_ADR		Ctrl=txtPER_ADR		Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>

			<C>Col=CEF_RSN_NM	Ctrl=txtCEF_RSN_NM	Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=CEF_NO		Ctrl=txtCEF_NO		Param=value</C>
			<C>Col=CEF_STS_NM	Ctrl=txtCEF_STS_NM	Param=value</C>
			<C>Col=CEF_SEC		Ctrl=rdoCEF_SEC		Param=CodeValue</C>
			<C>Col=CEF_CNT		Ctrl=txtCEF_CNT		Param=value</C>
            <C>Col=CEF_YY       Ctrl=txtCEF_YY      Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
		">
	</object>