<!--
***********************************************************************
* @source      : buta040.jsp
* @description : ���´��������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���´��������Ȳ(buta040)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
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

            if(!fnc_SearchItemCheck()) return;

			//���º����û��Ȳ ���� ��ȸ
			var pis_ym = document.getElementById("txtPIS_YM_SHR").value;
			var str_date = document.getElementById("txtSTR_DATE_SHR").value;
			var end_date = document.getElementById("txtEND_DATE_SHR").value;
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;

			dsT_DI_BUSINESSTRIP.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta040.cmd.BUTA040CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&STR_DATE="+str_date+"&END_DATE="+end_date+"&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
			dsT_DI_BUSINESSTRIP.reset();
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

            if (dsT_DI_BUSINESSTRIP.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_BUSINESSTRIP.GridToExcel("���´��������Ȳ", '', 225);

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

			//document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
			//document.getElementById("txtSTR_DATE_SHR").value = "";
			//document.getElementById("txtEND_DATE_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_BUSINESSTRIP.ClearData();
            dsT_DI_BUSINESSTRIP_SET.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var pis_ym = document.getElementById("txtPIS_YM_SHR");
			var str_date = document.getElementById("txtSTR_DATE_SHR");
			var end_date = document.getElementById("txtEND_DATE_SHR");

            if(pis_ym.value == ""){
                alert("���±Ⱓ ��-���� �Է��ϼ���!");
                pis_ym.focus();
                return false;
            }
            if(str_date.value == ""){
                alert("���±Ⱓ �������� �Է��ϼ���!");
                str_date.focus();
                return false;
            }
            if(end_date.value == ""){
                alert("���±Ⱓ �������� �Է��ϼ���!");
                end_date.focus();
                return false;
            }
            return true;

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

            document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
			document.getElementById("txtSTR_DATE_SHR").value = "01";
			document.getElementById("txtEND_DATE_SHR").value = today.substring(8,10);
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";

			cfStyleGrid(form1.grdT_DI_BUSINESSTRIP,0,"false","false");      // Grid Style ����

            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************
         * 15. �Է��� ũ�� ��					*
         ********************************************/
        function fnc_DateTerm(p_stdt,p_endt) {

            if(document.getElementById(p_stdt).value != "" && document.getElementById(p_endt).value != ""){
                if(document.getElementById(p_stdt).value > document.getElementById(p_endt).value){
                    alert("�������� ������ ���� Ů�ϴ�.");
                    document.getElementById(p_stdt).focus();
                }
            }

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP)   |
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_BUSINESSTRIP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							    |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_SET)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_SET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | ���ͻ��, ��ü��ȸ�϶��� ���峯¥�� ���´�           |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_DI_BUSINESSTRIP_SET event=onFilter(row)>

		if (dsT_DI_BUSINESSTRIP_SET.NameValue(row,"BUSI_CD") == "E"){
			return true;
		}else{
			return false;
		}

	</script>

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP Event="OnLoadCompleted(iCount)">

        var pis_ym = document.getElementById("txtPIS_YM_SHR").value;
		var str_date = document.getElementById("txtSTR_DATE_SHR").value;
		var end_date = document.getElementById("txtEND_DATE_SHR").value;
        var cnt = 0;

        dsT_DI_BUSINESSTRIP_SET.ClearData();

		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
            dsT_DI_BUSINESSTRIP_SET.setDataHeader("ENO_NO:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING, PIS_YMD:STRING, AT_NM:STRING, AT_CD:STRING, BUSI_CD:STRING, FLAG:STRING");

			//���ͽ��࿩�� ������ȸ�� ��ü�����ְ� �ƴϸ� ���常 ������ �Ѵ�.
			if(document.getElementById("txtENO_NO_SHR").value.length != 8){
				dsT_DI_BUSINESSTRIP_SET.UseFilter=true;
            }else{
				dsT_DI_BUSINESSTRIP_SET.UseFilter=false;
            }

            for(i=1; i<=iCount; i++){
                cnt = 5;    //�����ڵ带 �������� ���� ����(�����ڵ�� 5��° �÷����� ��¥ ����ŭ �������)

                if(i==1 || dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO") != dsT_DI_BUSINESSTRIP.NameValue(i-1,"ENO_NO")){
                    for(j=Number(str_date); j<=Number(end_date); j++){
                        dsT_DI_BUSINESSTRIP_SET.AddRow();
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO");
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"ENO_NM") = dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NM");
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"DPT_NM") = dsT_DI_BUSINESSTRIP.NameValue(i,"DPT_NM");
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"JOB_NM") = dsT_DI_BUSINESSTRIP.NameValue(i,"JOB_NM");
                        if(j < 10){
                            dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"PIS_YMD") = pis_ym+"-0"+j;
                        }else{
                            dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"PIS_YMD") = pis_ym+"-"+j;
                        }
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"AT_CD") = dsT_DI_BUSINESSTRIP.ColumnValue(i,cnt);
                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"AT_NM") = dsT_DI_BUSINESSTRIP.ColumnValue(i,cnt+1);
                        if(j>=Number(dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_FR_YMD").substring(6,8)) && j<=Number(dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_TO_YMD").substring(6,8))){
                            dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"BUSI_CD") = "E";
	                        dsT_DI_BUSINESSTRIP_SET.NameValue(dsT_DI_BUSINESSTRIP_SET.RowPosition,"FLAG") = dsT_DI_BUSINESSTRIP.NameValue(i,"FLAG");//���屸��
                        }

                        cnt = cnt + 2;

                    }//end for
                }//end if

                //��ȸ �Ⱓ���ȿ� �ߺ��� ������ ���� ���
                else if(i>1 && dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO") == dsT_DI_BUSINESSTRIP.NameValue(i-1,"ENO_NO")){
                    for(k=1; k<=dsT_DI_BUSINESSTRIP_SET.CountRow; k++){
                        //������ ����� �����ϴ� ���
                        if(dsT_DI_BUSINESSTRIP.NameValue(i,"ENO_NO") == dsT_DI_BUSINESSTRIP_SET.NameValue(k,"ENO_NO")){
                            //�������� ����Ⱓ���ȿ� ���ϴ� ���
                            if(removeChar(dsT_DI_BUSINESSTRIP_SET.NameValue(k,"PIS_YMD"),"-") >= dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_FR_YMD") && removeChar(dsT_DI_BUSINESSTRIP_SET.NameValue(k,"PIS_YMD"),"-") <= dsT_DI_BUSINESSTRIP.NameValue(i,"BUT_TO_YMD")){
                                dsT_DI_BUSINESSTRIP_SET.NameValue(k,"BUSI_CD") = "E";
                                dsT_DI_BUSINESSTRIP_SET.NameValue(k,"FLAG") = dsT_DI_BUSINESSTRIP.NameValue(i,"FLAG");//���屸��
                            }
                        }
                    }//end for
                }
            }//end for

            dsT_DI_BUSINESSTRIP_SET.Filter();//���ͽ���
            dsT_DI_BUSINESSTRIP_SET.RowPosition = "1";//ȭ���� ���������� �ʺ��̴� ���׶����� Ŀ���� �����δ�.

			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_BUSINESSTRIP_SET.countrow);


        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���´��������Ȳ</td>
					<td align="right" class="navigator">HOME/���°���/�������/<font color="#000000">���´��������Ȳ</font></td>
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
							<col width="80"></col>
							<col width="180"></col>
                            <col width="60"></col>
							<col width="180"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">���±Ⱓ&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtPIS_YM_SHR"  name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                <input id="txtSTR_DATE_SHR" style="ime-mode:disabled" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" onblur="javascript:if(txtPIS_YM_SHR.value != '' && !cfDateExpr(txtPIS_YM_SHR.value+this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} fnc_DateTerm('txtSTR_DATE_SHR','txtEND_DATE_SHR');">�� ~
                                <input id="txtEND_DATE_SHR" style="ime-mode:disabled" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" onblur="javascript:if(txtPIS_YM_SHR.value != '' && !cfDateExpr(txtPIS_YM_SHR.value+this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} fnc_DateTerm('txtSTR_DATE_SHR','txtEND_DATE_SHR');">��
							</td>
                            <td align="right" class="searchState">�� ��&nbsp;</td>
                            <td class="padding2423">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')">
								</a>
                            </td>
                            <td align="right" class="searchState">�� ��&nbsp;</td>
                            <td class="padding2423">
                                <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','0');">
								<input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
					<object id="grdT_DI_BUSINESSTRIP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_DI_BUSINESSTRIP_SET">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}			</C>
                            <C> id="DPT_NM"	    width=120	name="�Ҽ�"		align=center    suppress=1 </C>
                            <C> id="JOB_NM"		width=80	name="����"		align=center    suppress=1 </C>
                            <C> id="ENO_NO"     width=80	name="���"     align=center    suppress=1 </C>
                            <C> id="ENO_NM"	    width=80	name="����"	    align=center    suppress=1 </C>
                            <C> id="PIS_YMD"	width=100	name="������"	align=center    </C>
                            <C> id="AT_NM"	    width=100	name="���¹ݿ���"	align=center    </C>
                            <C> id="BUSI_NM"	width=100	name="����ݿ���"	align=center    Value={Decode(FLAG,"I","��������","O","�ؿ�����")}</C>
                            <C> id="AT_CD"	    width=100	name="�����ڵ�"	align=center    Show=false</C>
                            <C> id="BUSI_CD"	width=100	name="����"	    align=center    Show=false</C>
                            <C> id="DIF_YN"	    width=80	name="�񱳰��"	align=center    Value={Decode(BUSI_CD,"E",Decode(AT_CD,"E","","N"))}</C>
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