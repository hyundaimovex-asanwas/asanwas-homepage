<!--
***********************************************************************
* @source      : sagb080.jsp
* @description : ö�ߴ�������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/31      ���뼺        �����ۼ�.
* 2007/04/23      ���м�        �μ�κ��߰�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>ö�ߴ�������Ȳ(sagb080)</title>
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
    <script language="javascript" >

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'F' + 'F' + 'T';    

        var today = getToday();

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			//���º����û��Ȳ ���� ��ȸ
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_yymm = document.getElementById("txtSTR_YYMM_SHR").value; // ���۳��
			var end_yymm = document.getElementById("txtEND_YYMM_SHR").value; // ������
			var app_yn  = document.getElementById("cmbAPP_YN_SHR").value;

			//���۳���� ������ ��ȸ����.
			if(str_yymm.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(str_yymm.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(end_yymm.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(end_yymm.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(end_yymm.replaceStr("-","")) < parseInt(str_yymm.replaceStr("-",""))){
					alert("�������� ���۳������ �����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}
			
			dsT_CP_NIGHTDUTY.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb080.cmd.SAGB080CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&STR_YYMM="+str_yymm+"&END_YYMM="+end_yymm+"&APP_YN="+app_yn;
			dsT_CP_NIGHTDUTY.reset();
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

            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_yymm = document.getElementById("txtSTR_YYMM_SHR").value; // ���۳��
			var end_yymm = document.getElementById("txtEND_YYMM_SHR").value; // ������
			var app_yn  = document.getElementById("cmbAPP_YN_SHR").value;

            var url = "sagb080_PV.jsp?DPT_CD="+dpt_cd+"&STR_YYMM="+str_yymm+"&END_YYMM="+end_yymm+"&APP_YN="+app_yn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CP_NIGHTDUTY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_NIGHTDUTY.GridToExcel("ö�ߴ�������Ȳ", '', 225);

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
			document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
			document.getElementById("cmbAPP_YN_SHR").value = "";
			
            document.getElementById("resultMessage").innerText = ' ';

        	dsT_CP_NIGHTDUTY.ClearData();

            document.getElementById("txtSTR_YYMM_SHR").focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CP_NIGHTDUTY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();
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
        
         	if ( !dsT_CP_NIGHTDUTY.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			
			return true;
			
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_CP_NIGHTDUTY,0,"true","false");      // Grid Style ����
            
            document.getElementById("txtSTR_YYMM_SHR").value = today.substring(0,7);
            document.getElementById("txtEND_YYMM_SHR").value = today.substring(0,7);
            
            document.getElementById("txtSTR_YYMM_SHR").focus();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. ó�� ��ư							*
         ********************************************/
		function fnc_Reflect() {

            if ( !dsT_CP_NIGHTDUTY.isUpdated ) {
                alert("ó���� �ڷᰡ �����ϴ�!");
				document.getElementById("resultMessage").innerText = "* ó���� �ڷᰡ �����ϴ�!";
                return;
			}

            trT_CP_NIGHTDUTY.KeyValue = "tr01(I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY)";
			trT_CP_NIGHTDUTY.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb080.cmd.SAGB080CMD&S_MODE=SAV";
			trT_CP_NIGHTDUTY.post();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_NIGHTDUTY)	   |
    | 3. ���Ǵ� Table List(T_CP_NIGHTDUTY) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_NIGHTDUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_NIGHTDUTY)	   |
    | 3. ���Ǵ� Table List(T_CP_NIGHTDUTY)		       |
    +------------------------------------------------------>
	<Object ID="trT_CP_NIGHTDUTY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY,I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_CP_NIGHTDUTY event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_CP_NIGHTDUTY event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | Grid Head Check event ó��                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_CP_NIGHTDUTY event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_CP_NIGHTDUTY.CountRow; i++) {
        
        	if(dsT_CP_NIGHTDUTY.NameValue(i, "END_TAG") != "Y" 
                    && dsT_CP_NIGHTDUTY.NameValue(i, "APP_YN") == "Y"){
	            dsT_CP_NIGHTDUTY.NameValue(i, "CHECKED") = bCheck;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ö�ߴ�������Ȳ</td>
					<td align="right" class="navigator">HOME/���°���/ö�ߴ���/<font color="#000000">ö�ߴ�������Ȳ</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="80"></col>
							<col width="220"></col>
							<col width="60"></col>
							<col width="180"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�ش�Ⱓ&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtSTR_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM_SHR','','75','112');"></a>
								&nbsp;~&nbsp;
								<input id="txtEND_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM_SHR','','190','112');"></a>
							</td>
                            <td class="searchState" align="right">��&nbsp;&nbsp;��&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly" readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
							</td>
							<td class="searchState" align="right">���籸��&nbsp;</td>
							<td class="padding2423" align="left">
								<select id="cmbAPP_YN_SHR"  style="width='60%';" onChange="fnc_SearchList()">
									<option value="">��ü</option>
									<option value="1">�̻��</option>
									<option value="2">�̰�</option>
									<option value="3">����</option>
									<option value="4">�ΰ�</option>
								</select>
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
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td valign="top" align="right" class="searchState">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"> <img src="/images/button/btn_ConductOn.gif" name="imgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
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
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CP_NIGHTDUTY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_CP_NIGHTDUTY">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=39    name="NO"		align=center </C>
                            <C> id="DPT_NM"		width=100	name="�Ҽ�"		    align=left      LeftMargin=10 Edit=none </C>
                            <C> id="JOB_NM"		width=60	name="����"		    align=center    Edit=none </C>
                            <C> id="ENO_NO"	    width=70	name="���"         align=center    Edit=none </C>
                            <C> id="ENO_NM"	    width=70	name="����"	        align=center    Edit=none </C>
							<C> id="DUTY_CNT"	width=70	name="�����ϼ�"		align=right 	Edit=none</C>
                            <C> id="DUTY_AMT"	width=70	name="��������"		align=right 	Edit=none</C>
                            <C> id="REMARK" 	width=140	name="���" 		align=left   	Edit=none</C>
							<C> id="APP_YN_NM"	width=60	name="��������"		align=center	Edit=none	</C>
							<C> id="END_TAG"	width=60	name="�ݿ�����"	    align=center	Edit=none Value={Decode(END_TAG,"Y","�ݿ�","�̹ݿ�")}</C>
                            <C> id="CHECKED"	width=40	name="Chk"		    align=center	HeadCheckShow=true Editstyle="CheckBox"  Edit={Decode(END_TAG,"Y",0,Decode(APP_YN, "Y", 1, 0))} </C>
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