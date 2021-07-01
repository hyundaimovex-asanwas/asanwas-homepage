	<!--*************************************************************************
	* @source      : proa130.jsp												*
	* @description : ����������� PAGE	 								  			*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/29            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�����������(proa130)</title>
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

		var btnList = 'TTTTFFTT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var REPU_CD = "K1";  // ����/¡�� ���п� ���� �ڵ� ��ȯ(K1, K2)
		var REPU_NM = "����";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	if( document.form1.txtPMT_YMD_SHR.value=="" ){
        		alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	if( document.form1.txtPMT_YMD_SHR.value.length != 4 ){
        		alert("�����⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}

			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;

			dsT_PM_REWARD.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa130.cmd.PROA130CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR;
			dsT_PM_REWARD.reset();

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
			trT_PM_REWARD.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa130.cmd.PROA130CMD&S_MODE=SAV";
			trT_PM_REWARD.post();
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_PM_REWARD.CountColumn == 0) {
				dsT_PM_REWARD.setDataHeader("REPU_CD:STRING, REPU_TAG:STRING, REPU_TAG_NM:STRING, STR_YMD:STRING, END_YMD:STRING, ANS_TAG:STRING, ANS_CNT:STRING");
			}

			enableInput();
			dsT_PM_REWARD.AddRow();
			document.form1.cmbREPU_CD.selectedIndex = 0;
			document.form1.cmbANS_TAG.selectedIndex = 0;
			fnc_ChgRepuCombo();
			document.form1.cmbREPU_CD.focus();
			
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
	        if (dsT_PM_REWARD.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "���      = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_NM")+"\n";
            	tmpMSG += "����      = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_TAG_NM")+"\n";
            	tmpMSG += "������   = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "STR_YMD")+"\n";
            	tmpMSG += "������   = "+dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "END_YMD");

	            if( confirm(tmpMSG) ){
					var REPU_CD  = dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_CD");
					var REPU_TAG = dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "REPU_TAG");
					var STR_YMD  = dsT_PM_REWARD.nameValue(dsT_PM_REWARD.RowPosition, "STR_YMD");

					dsT_PM_REWARD.DeleteRow(dsT_PM_REWARD.RowPosition);
					// �Ķ���� �߰�
					trT_PM_REWARD.Parameters = "REPU_CD="+REPU_CD+",REPU_TAG="+REPU_TAG+",STR_YMD="+STR_YMD;

					trT_PM_REWARD.KeyValue = "tr02(I:dsT_PM_REWARD=dsT_PM_REWARD)";
					trT_PM_REWARD.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa130.cmd.PROA130CMD&S_MODE=DEL";
					trT_PM_REWARD.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

        	disableInput();

        	document.getElementById("resultMessage").innerText = ' ';
        	//document.form1.txtPMT_YMD_SHR.value = next_yy;
        	dsT_PM_REWARD.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_REWARD.IsUpdated)  {
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
         	if (!dsT_PM_REWARD.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			disableInput();
        	document.form1.txtPMT_YMD_SHR.value = next_yy;
			cfStyleGrid(form1.grdT_PM_REWARD,15,"true","false");      // Grid Style ����
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

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		  	for(var i=2; i<8; i++){
  		  		if(i==2) continue; // �ڵ�
                if(i==3) continue; // �ڵ��
                if(i==4) continue; // ������

				document.form1.elements[i].readOnly = false;
	 			document.form1.elements[i].className = "";
  			}
  			//document.getElementById("cmbREPU_CD").disabled  = false;  // ����/¡�� ����
  			document.getElementById("cmbANS_TAG").disabled  = false;  // ����/���� ����
  			//document.getElementById("img_HelpOn2").disabled = false;  // �ڵ� �˻�
  			//document.getElementById("imgSTR_YMD").disabled  = false;  // ������
  			document.getElementById("imgEND_YMD").disabled  = false;  // ������
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		  	for(var i=2; i<8; i++){
  		  		if(i==6) continue; // ���� �޺�
				document.form1.elements[i].readOnly = true;
	 			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.getElementById("cmbREPU_CD").disabled  = true;  // ����/¡�� ����
  			document.getElementById("cmbANS_TAG").disabled  = true;  // ����/���� ����
  			document.getElementById("img_HelpOn2").disabled = true;  // �ڵ� �˻�
  			document.getElementById("imgSTR_YMD").disabled  = true;  // ������
  			document.getElementById("imgEND_YMD").disabled  = true;  // ������
  		}

		/********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

 		/********************************************
         * �������ڿ��� ��Ŀ�� ������ ��û���ڿ� ��       		*
         ********************************************/
		function cfCheckDateTermPROA130(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�������ڰ� �������ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
			}
		}

  		/********************************************
         * ������п����� �ڵ��� ��ȯ	       			*
         ********************************************/
        function fnc_ChgRepuCombo() {
        	if(document.form1.cmbREPU_CD.selectedIndex == 0){
        		REPU_CD = "K1"; // ����
        		REPU_NM = "����";
        	}else{
        		REPU_CD = "K2"; // ¡��
        		REPU_NM = "¡��";
        	}
        }

  		/********************************************
         * �ڵ����� ���� �˾�			       			*
         ********************************************/
        function fnc_RepuPop() {
	        fnc_commonCodePopup('txtREPU_TAG','txtREPU_TAG_NM',REPU_NM, REPU_CD);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_REWARD)			   |
    | 3. ���Ǵ� Table List(T_PM_REWARD) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_REWARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_PM_REWARD)			   |
    | 3. ���Ǵ� Table List(T_PM_REWARD)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_REWARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_REWARD=dsT_PM_REWARD,I:dsT_PM_REWARD=dsT_PM_REWARD)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
	<Script For=dsT_PM_REWARD Event="OnLoadCompleted(iCount)">
		if (iCount == 0){
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_REWARD.CountRow);
			enableInput();
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_REWARD Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_REWARD Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_REWARD event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_REWARD event="OnFail()">
        alert(trT_PM_REWARD.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_PM_REWARD event=CanRowPosChange(row)>
		if ( dsT_PM_REWARD.NameValue(row,"REPU_CD") == "" ) {
			alert("[ " + grdT_PM_REWARD.GetHdrDispName('-3','REPU_CD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_PM_REWARD.NameValue(row,"REPU_TAG") == "" ) {
			alert("[ " + grdT_PM_REWARD.GetHdrDispName('-3','REPU_TAG') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_PM_REWARD.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_PM_REWARD.GetHdrDispName('-3','STR_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
	</script>

    <!-----------------------------------------------------+
    | Grid Ŭ���� �������ο� ���� ������ư ����				   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_PM_REWARD event=OnClick(row,colid)>
		fnc_ChgRepuCombo();
	</script>
	
    <script language=JavaScript for=dsT_PM_REWARD event=OnRowPosChanged(row)>

        if(dsT_PM_REWARD.SysStatus(row) == "1"){
            document.getElementById("txtREPU_TAG").readOnly = false;//�ڵ�
            document.getElementById("txtREPU_TAG").className = "";  //�ڵ�
            document.getElementById("txtSTR_YMD").readOnly = false;//������
            document.getElementById("txtSTR_YMD").className = "";//������
            
            document.getElementById("cmbREPU_CD").disabled  = false;  // ����/¡�� ����
            document.getElementById("img_HelpOn2").disabled = false;  // �ڵ� �˻�
            document.getElementById("imgSTR_YMD").disabled  = false;  // ������
            
        }else{
            document.getElementById("txtREPU_TAG").readOnly = true;//�ڵ�
            document.getElementById("txtREPU_TAG").className = "input_ReadOnly";  //�ڵ�
            document.getElementById("txtSTR_YMD").readOnly = true;//������
            document.getElementById("txtSTR_YMD").className = "input_ReadOnly";//������
                            
            document.getElementById("cmbREPU_CD").disabled   = true;
            document.getElementById("img_HelpOn2").disabled = true;  // ������ �˻�
            document.getElementById("imgSTR_YMD").disabled  = true;  // ������
        }
        
    </script>        

	<!--**************************************************************************************
    *                                                                                        *
	*	BODY START                                                                           *
    *                                                                                        *
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����������</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">�����������</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�����⵵&nbsp;</td>
					<td class="padding2423" align="left">
                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPMT_YMD_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                </td>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPMT_YMD_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPMT_YMD_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
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
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="180"></col>
			<col width="60"></col>
			<col width="120"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423">
				<select id="cmbREPU_CD" style="width:90%;" onChange="fnc_ChgRepuCombo();">
					<option value="H">����</option>
					<option value="P">¡��</option>
				</select>
			</td>
			<td align="center" class="creamBold">�ڵ�</td>
			<td class="padding2423">
				<input type="text" id="txtREPU_TAG" size="4"> <input type="text" id="txtREPU_TAG_NM" size="14" class="input_ReadOnly"  readOnly>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_RepuPop()"></a>
			</td>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423">
				<input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA130('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','384','98');"></a>
			</td>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423">
				<input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA130('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD','','384','98');"></a>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<select id="cmbANS_TAG" style="width:90%;">
					<option value="1">����</option>
					<option value="2">����</option>
				</select>
			</td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423" colspan="5">
				<input type="text" id="txtANS_CNT" size="4" maxLength="3" style="text-align:right">
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
					<object id="grdT_PM_REWARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
						<param name="DataID" value="dsT_PM_REWARD">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=29	name="NO"		align=center	value={String(Currow)}   </C>
							<C> id="REPU_CD"		width=80	name="���"		align=center	Edit=none	value={decode(REPU_CD, "H", "����", "P", "¡��")}</C>
							<C> id="REPU_TAG"		width=70	name="�ڵ�"		align=center	Edit=none	             </C>
							<C> id="REPU_TAG_NM"	width=185	name="����"		align=left		Edit=none	             </C>
							<C> id="STR_YMD"		width=120	name="������"	align=center	Edit=none                </C>
							<C> id="END_YMD"		width=120	name="������"	align=center	Edit=none                </C>
							<C> id="ANS_TAG"		width=80	name="����"		align=center	Edit=none	value={decode(ANS_TAG, 1, "����", 2, "����")}    </C>
							<C> id="ANS_CNT"		width=80	name="����"		align=right		Edit=none	             </C>
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

	<!-- T_PM_REWARD ���� ���̺� -->
	<object id="bndT_PM_REWARD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_REWARD">
		<Param Name="BindInfo", Value="
			<C>Col=REPU_CD		Ctrl=cmbREPU_CD			Param=value</C>
			<C>Col=REPU_TAG		Ctrl=txtREPU_TAG		Param=value</C>
			<C>Col=REPU_TAG_NM	Ctrl=txtREPU_TAG_NM		Param=value</C>
			<C>Col=STR_YMD		Ctrl=txtSTR_YMD			Param=value</C>
			<C>Col=END_YMD		Ctrl=txtEND_YMD			Param=value</C>
			<C>Col=ANS_TAG		Ctrl=cmbANS_TAG			Param=value</C>
			<C>Col=ANS_CNT		Ctrl=txtANS_CNT			Param=value</C>
		">
	</object>