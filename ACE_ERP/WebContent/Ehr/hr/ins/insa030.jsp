	<!--*************************************************************************
	* @source      : insa030.jsp												*
	* @description : ���ο��ݰ��κ���ȸ PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/08            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>���ο��ݰ��κ���ȸ(insa030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
                    
		var today = getToday().substr(0,4);

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STD_PIS_YY_SHR = document.form1.txtSTD_PIS_YY_SHR.value;
			var END_PIS_YY_SHR = document.form1.txtEND_PIS_YY_SHR.value;
			var ENO_NO_SHR = document.form1.txtENO_NO.value;

        	if( ENO_NO_SHR == "" ){
        		alert("����� �Է��Ͻʽÿ�.");
        		return false;
        	}
        	if( STD_PIS_YY_SHR == "" ){
        		alert("���� �⵵�� �Է��ϼ���.");
        		return false;
        	}
        	if( END_PIS_YY_SHR == "" ){
        		alert("������ �⵵�� �Է��ϼ���.");
        		return false;
        	}

			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa030.cmd.INSA030CMD&S_MODE=SHR&STD_PIS_YY_SHR="+STD_PIS_YY_SHR+"&END_PIS_YY_SHR="+END_PIS_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_CP_PAYMASTER.reset();

            return true;
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {

        	//if(!fnc_SearchList())
            //    return;
            if(dsT_CP_PAYMASTER.CountRow < 1) {
                alert("��ȸ�� ���� ���ּ���");
                return;
            }
            
            var eno_no  = document.getElementById("txtENO_NO").value;
            var job_nm  = document.getElementById("txtJOB_NM").value;
            var dpt_nm  = document.getElementById("txtDPT_NM").value;
            var eno_nm  = document.getElementById("txtENO_NM").value;
            var hir_ymd = document.getElementById("txtHIR_YMD").value;
            var cet_no  = document.getElementById("txtCET_NO").value;
            
            
            var str_yy  = dsT_CP_PAYMASTER.NameValue(1,"PIS_YY");
            var end_yy  = dsT_CP_PAYMASTER.NameValue(Number(dsT_CP_PAYMASTER.CountRow)-2,"PIS_YY");
            //alert(str_yy+",  "+end_yy);
            
            var url = "insa030_PV.jsp?eno_no="+eno_no+"&job_nm="+job_nm+"&dpt_nm="+dpt_nm+"&eno_nm="+eno_nm+"&hir_ymd="+hir_ymd+"&cet_no="+cet_no+"&str_yy="+str_yy+"&end_yy="+end_yy;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("���ο��ݰ��κ���ȸ", '', 225)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_CP_PAYMASTER.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CP_PAYMASTER.IsUpdated)  {
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
  			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            
            //�˻� ���ǵ� �ʱ�ȭ
            document.getElementById("txtSTD_PIS_YY_SHR").value = today;
            document.getElementById("txtEND_PIS_YY_SHR").value = today;
            
            //��� ���� ��ȸ
            document.getElementById("txtENO_NO").value = "<%=box.get("SESSION_ENONO") %>";
            fnc_SearchEmpNo();
            
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"true","false");      // Grid Style ����
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
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

            if(obj.eno_no != "") {            
                document.getElementById("txtENO_NO"     ).value = obj.eno_no;
                document.getElementById("txtENO_NM"     ).value = obj.eno_nm;
                document.getElementById("txtOCC_CD"     ).value = obj.occ_cd;
                document.getElementById("txtOCC_NM"     ).value = obj.occ_nm;
                document.getElementById("txtJOB_NM"     ).value = obj.job_nm;
                document.getElementById("txtDPT_NM"     ).value = obj.dpt_nm;
                document.getElementById("txtHIR_YMD"    ).value = obj.hir_ymd;
                document.getElementById("txtCET_NO"     ).value = obj.cet_no;

            } else {
                document.getElementById("txtENO_NO"     ).value = "";
                document.getElementById("txtENO_NM"     ).value = "";
                document.getElementById("txtOCC_CD"     ).value = "";
                document.getElementById("txtOCC_NM"     ).value = "";
                document.getElementById("txtJOB_NM"     ).value = "";
                document.getElementById("txtDPT_NM"     ).value = "";
                document.getElementById("txtHIR_YMD"    ).value = "";
                document.getElementById("txtCET_NO"     ).value = "";
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
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_PAYMASTER)			   |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
        <param name="SubSumExpr"      value="total , 1:PIS_YY">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_PAYMASTER)			   |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)				   |
    +------------------------------------------------------>
	<Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
            //alert(dsT_CP_PAYMASTER.ExportData(1, dsT_CP_PAYMASTER.CountRow, true));
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.RealCount(1, dsT_CP_PAYMASTER.CountRow));
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnFail()">
        alert(trT_CP_PAYMASTER.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ο��ݰ��κ���ȸ</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ο���/<font color="#000000">���ο��ݰ��κ���ȸ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="45"></col>
					<col width="65"></col>
					<col width="45"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width="85"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�⵵&nbsp;</td>
					<td class="padding2423" align="left" colspan="3">
						<input type="text" id="txtSTD_PIS_YY_SHR" name="txtSTD_PIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTD_PIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgSTD_PIS_YY_SHR" name="imgSTD_PIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtSTD_PIS_YY_SHR','','340','108');"></a>
						~
						<input type="text" id="txtEND_PIS_YY_SHR" name="txtEND_PIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_PIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgEND_PIS_YY_SHR" name="imgEND_PIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtEND_PIS_YY_SHR','','425','108');"></a>
					</td>
                    <td align="right" class="searchState">���&nbsp;</td>
                    <td class="padding2423" align="left" colspan="3">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>
                </tr>
                <tr>
                    <td align="right" class="searchState">�ٷα���&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="hidden" id="txtOCC_CD" size="2" class="input_ReadOnly" readonly>
                        <input type="text" id="txtOCC_NM" size="6" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">�Ҽ�&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">����&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtJOB_NM" size="10" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">�Ի���&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtHIR_YMD" size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="right" class="searchState">�ֹι�ȣ&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtCET_NO" size="15" class="input_ReadOnly" readonly>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="65"></col>
			<col width="80"></col>
			<col width="65"></col>
			<col width="90"></col>
			<col width="65"></col>
			<col width="70"></col>
			<col width="65"></col>
			<col width="80"></col>
			<col width="65"></col>
			<col width="*"></col>
		</colgroup>

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
					<object id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
						<param name="DataID" value="dsT_CP_PAYMASTER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"	width=50	name="NO"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	 SubSumText={decode(currow,LastRow,"�� ��","�� ��")}</C>
							<C> id="PIS_YY"		width=50	name="��"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	 SubSumText=""</C>
							<C> id="PIS_MM"		width=50	name="��"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}</C>
							<C> id="STDB_AMT"	width=110	name="ǥ�غ�������"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
							<C> id="NPN_GRD"	width=80	name="���"			align=center	Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}</C>
							<C> id="NPEN_AMT"	width=110	name="���κδ��"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
							<C> id="COM_AMT"	width=110	name="ȸ��δ��"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
							<C> id="RTPL_AMT"	width=110	name="������ȯ��"	align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"      SubSumText={IF(curlevel=9999, Max(RTPL_TOT), RTPL_AMT)} </C>
							<C> id="NPN_SUM"	width=110	name="�հ�"			align=right		Edit=none	BgColor={decode(NPN_GRD, "", "#99FFCC")}	RightMargin="10"</C>
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
