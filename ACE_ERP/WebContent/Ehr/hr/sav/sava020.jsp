	<!--*************************************************************************
	* @source      : sava020.jsp												*
	* @description : ����ݰ������� PAGE 										    *
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/20            ä����          	        �����ۼ�		        *
    * 2006/05/07            ���м�          	        �μ�κ��߰�            *	
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>����ݰ�������(sava020)</title>
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

		var today_ym  = getToday().substring(0,7);
		var btnList = 'TFFTFFFT';
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	var DED_YM_SHR = document.form1.txtDED_YM_SHR.value;
        	
        	if( DED_YM_SHR == "" ){
        		alert("�˻��Ϸ��� ���س�� �� �ٸ��� �Է��Ͻʽÿ�. \n��)"+today_ym);
        		return;
       		}
        	
        	if( DED_YM_SHR > today_ym ){
	        	alert("�˻��Ϸ��� ���س⵵/���� \n���� �⵵/���� �ʰ��Ҽ� �����ϴ�. \n");
	        	return;
        	}

			// ����� ���� ��ȸ
			var OCC_CD_SHR = document.form1.cmbOCC_CD_SHR.value;
			var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;
			var JOB_CD_SHR = document.form1.txtJOB_CD_SHR.value;
			var BNK_CD_SHR = document.form1.txtBNK_CD_SHR.value;
			
			dsT_SV_SAVEBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sav.a.sava020.cmd.SAVA020CMD&S_MODE=SHR&DED_YM_SHR="+DED_YM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&BNK_CD_SHR="+BNK_CD_SHR;
			dsT_SV_SAVEBOOK.reset();
			
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
        	var DED_YM_SHR = document.form1.txtDED_YM_SHR.value;
        	
        	if( DED_YM_SHR == "" ){
        		alert("�˻��Ϸ��� ���س�� �� �ٸ��� �Է��Ͻʽÿ�. \n��)"+today_ym);
        		return;
       		}
        	
        	if( DED_YM_SHR > today_ym ){
	        	alert("�˻��Ϸ��� ���س⵵/���� \n���� �⵵/���� �ʰ��Ҽ� �����ϴ�. \n");
	        	return;
        	}

			// ����� ���� ��ȸ
			var OCC_CD_SHR = document.form1.cmbOCC_CD_SHR.value;
			var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;
			var JOB_CD_SHR = document.form1.txtJOB_CD_SHR.value;
			var BNK_CD_SHR = document.form1.txtBNK_CD_SHR.value;

			var url = "sava020_PV.jsp?DED_YM_SHR="+DED_YM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&BNK_CD_SHR="+BNK_CD_SHR;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
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
			document.form1.txtDED_YM_SHR.value = "";
			document.form1.txtDPT_CD_SHR.value = "";
			document.form1.txtDPT_NM_SHR.value = "";
			document.form1.txtJOB_CD_SHR.value = "";
			document.form1.txtJOB_NM_SHR.value = "";
			document.form1.txtBNK_CD_SHR.value = "";
			document.form1.txtBNK_NM_SHR.value = "";
			document.form1.cmbOCC_CD_SHR.selectedIndex = 0;
			
	        document.getElementById("resultMessage").innerText = " ";
	        
			// �޺��ڽ� �⺻ ����
			
        	dsT_SV_SAVEBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
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
			
            // �ٷα��� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
            
            document.getElementById("txtDED_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
			
			cfStyleGrid(form1.grdT_SV_SAVEBOOK,15,"false","false");      // Grid Style ����
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
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return; 
            if(!cfDateExpr(obj.value)) { 
                alert('��ȿ�� ��¥�� �ƴմϴ�.'); 
                obj.focus();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SV_SAVEBOOK)			   |
    | 3. ���Ǵ� Table List(T_SV_SAVEBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SV_SAVEBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_SV_SAVEBOOK)		       |
    | 3. ���Ǵ� Table List(T_SV_SAVEBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_SV_SAVEBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SV_SAVEBOOK=dsT_SV_SAVEBOOK,I:dsT_SV_SAVEBOOK=dsT_SV_SAVEBOOK)">
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
	<Script For=dsT_SV_SAVEBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SV_SAVEBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_SV_SAVEBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
	<Script For=dsT_TACCCOD_BK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
 
	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_SV_SAVEBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SV_SAVEBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SV_SAVEBOOK event="OnFail()">
        alert(trT_SV_SAVEBOOK.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ݰ�������</td>
					<td align="right" class="navigator">HOME/�����/<font color="#000000">����ݰ�������</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
							<col width="100"></col>
							<col width="250"></col>
							<col width="80"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">���س��</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtDED_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtDED_YM_SHR','','134','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">�ҼӺ�</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" style="width:10%" maxlength="2"> <input id="txtDPT_NM_SHR" style="width:28%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right" rowspan="3">�ٷα��к�</td>
							<td class="padding2423" align="left" rowspan="3">
								<select id="cmbOCC_CD_SHR" style="WIDTH: 29%" onChange="fnc_SearchList()">
									<option value="0">���</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right">������</td>
							<td class="padding2423" align="left">
								<input id="txtJOB_CD_SHR" style="width:10%" maxlength="2"> <input id="txtJOB_NM_SHR" style="width:28%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right">���ະ</td>
							<td class="padding2423" align="left">
								<input id="txtBNK_CD_SHR" style="width:10%" maxlength="2"> <input id="txtBNK_NM_SHR" style="width:28%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBnkCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBNK_CD_SHR','txtBNK_NM_SHR','����','BT')"></a>
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
					<object id="grdT_SV_SAVEBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_SV_SAVEBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width="25"		name="NO"			align="center"	value={String(Currow)}</C>
							<C> id="ENO_NM"			width="60"		name="����"			align="center"	Edit=none</C>
							<C> id="DPT_NM"			width="90"		name="�μ�"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_NM"			width="50"		name="����"			align="center"	Edit=none</C>
							<C> id="PIN_CNT"		width="80"		name="����Ƚ��"		align="right"	Edit=none	Show="false"</C>
							<C> id="PYM_AMT"		width="90"		name="�����Ծ�"		align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SUM_SAV"		width="90"		name="���Դ���"		align="right"	Edit=none	RightMargin="10" value="{(PYM_AMT * PIN_CNT)}"</C>
							<C> id="CON_YMD"		width="70"		name="�����"			align="center"	Edit=none</C>
							<C> id="DUE_YMD"		width="70"		name="������"			align="center"	Edit=none</C>
							<C> id="BNK_NM"			width="100"		name="�����"			align="left"	Edit=none	EditStyle=Lookup  Data="dsT_TACCCOD_BK:CODE:CODE_NAME"		LeftMargin="10"</C>
							<C> id="ACC_NO"			width="120"		name="���¹�ȣ"		align="left"	Edit=none	LeftMargin="10"</C>
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
	
	<input type="hidden" id="hidBIR_YMD" size="10">
	</form>
	<!-- form �� -->
	
</body>
</html>