<!--
***********************************************************************
* @source      : gunc040.jsp
* @description : ���κ����ϱٹ���Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/07      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ϱٹ���Ȳ(gunc040)</title>
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

		var btnList = 'TFFTTFFT';

        var today = getToday();

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			//���º����û��Ȳ ���� ��ȸ
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

			//�������ڰ� ������ ��ȸ����.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� ������ ��ȸ����.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc040.cmd.GUNC040CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&STR_YMD="+str_ymd+"&END_YMD="+end_ymd;
			dsT_DI_HOLIDAYWORK.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
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

            if (dsT_DI_HOLIDAYWORK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_HOLIDAYWORK.GridToExcel("���ϱٹ���Ȳ", '', 225);

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
			//document.getElementById("txtSTR_YMD_SHR").value = "";
			//document.getElementById("txtEND_YMD_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_HOLIDAYWORK.ClearData();

            document.getElementById("txtDPT_CD_SHR").focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_DI_HOLIDAYWORK.IsUpdated)  {
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

         	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,15,"true","true");      // Grid Style ����

            document.getElementById("txtSTR_YMD_SHR").value = today.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = today;

            document.getElementById("txtSTR_YMD_SHR").focus();


            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }
%>

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_HOLIDAYWORK)	   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-----------------------------------------------------+
    | 1. ī�ǿ� DataSet							           |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_HOLIDAYWORK)	   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
<!--	<script language=JavaScript for=grdT_DI_HOLIDAYWORK event="OnDblClick(row,colid)">

		if(row < 1 || dsT_DI_HOLIDAYWORK.NameValue(row,"ENO_NO") == "") {
			return;
		} else {

            //���õ� ROW�� dsT_DI_CHANGE_CP �����Ͽ� guna061�� dsT_DI_CHANGE_CP �Ѱ��ش�.
			cfCopyDataSet(dsT_DI_HOLIDAYWORK, dsT_DI_HOLIDAYWORK_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

			window.showModalDialog("/hr/gun/gunc041.jsp", dsT_DI_HOLIDAYWORK_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

		}    -->

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱٹ���Ȳ</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���ϱٹ���Ȳ</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="100"></col>
							<col width="300"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">��&nbsp;&nbsp;��&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
							    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
							</td>
                            <td class="searchState" align="right">��&nbsp;&nbsp;��&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_DI_HOLIDAYWORK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<FC> id={currow}		width=39    name="NO"				align=center 					</FC>
                            <FC> id="DPT_NM"		width=130	name="�Ҽ�"			    align=center  Suppress="1"      </FC>
                            <FC> id="ENO_NO"	    width=70	name="���"    	   		align=center  Suppress="2"		</FC>
                            <FC> id="JOB_NM"		width=60	name="����"			    align=center  Suppress="2" 		</FC>
                            <FC> id="ENO_NM"	    width=70	name="����"	    	    align=center  Suppress="2" 		</FC>
                            <FC> id="HOL_YMD"		width=90	name="���ϱٹ�����"	    MASK="XXXX-XX-XX" align=center	</FC>
						    <G>name=�������γ���	HeadBgColor=#F7DCBB
				   			   <C> id="BEF_TIME"	width=90	name="��û�ð�"	    align=center              		</C>
				   			   <C> id="BEF_HOL"	    width=60	name="�ѽð�"	    align=center              		</C>
				   			   <C> id="REMARK"	    width=200	name="�ٹ�����"	    align=center              		</C>
				   			   <C> id="END_NM"	    width=70	name="�������"     align=center             		</C>
				   			</G>
				   			<G>name=���������	HeadBgColor=#F7DCBB
				   			   <C> id="AFT_TIME"	width=90	name="�ٹ��ð�"  	align=center              		</C>
				   			   <C> id="AFT_HOL"	    width=60	name="�ѽð�"	    align=center              		</C>
				   			   <C> id="SIGN_NM"	    width=70	name="�������"     align=center              		</C>
				   			   <C> id="REP_NM"	    width=70	name="���籸��"         align=center              		</C>
				   			</G>
				   		    <C> id="HOL_AMT"	    width=80	name="���ϼ���"		align=right  	value={Decode(HOL_AMT,0,"",HOL_AMT)}		</C>
				   			 <C> id="REP_YMD"	    width=70	name="��ü�ް���"   	      align=center              		</C>
   			   			    <C> id="REP_TYP_NM"		width=100	name="�ް� ����"          align=center              		</C>
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