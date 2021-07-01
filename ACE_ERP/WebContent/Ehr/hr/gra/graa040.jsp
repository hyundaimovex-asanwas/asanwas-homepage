<!--
***********************************************************************
* @source      : graa040.jsp
* @description : ���κ��޻���Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/12      ���뼺        �����ۼ�.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���κ��޻���Ȳ(graa040)</title>
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

		var btnList = 'TFFTTTFT';
        var raiYmd = getToday().substring(0,5)+"03-01";
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			
            var f = document.form1;
            var snd_kind = "";
            if(f.rdoSND_KIND[0].checked){
                snd_kind = "PAY";//�޿�
            } else {
                snd_kind = "BNS";//��
            }
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var rai_ymd = f.txtRAI_YMD_SHR.value;
            var aow_gbn = "";
            if(f.chkAOW_GBN_SHR.checked){
                aow_gbn = "Y";//�ټӼ���
            }
            var aow_ymd = f.txtAOW_YMD_SHR.value;
            var gbn = "";
            var dpt_cd = f.cmbDPT_CD_SHR.value;
            var job_cd = f.cmbJOB_CD_SHR.value;
            if(f.rdoGBN_SHR[0].checked){
                gbn = "DPT";//�μ�
            } else {
                gbn = "JOB";//����
            }

            if(!fnc_SearchItemCheck()) return;

            dsT_PM_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa040.cmd.GRAA040CMD&S_MODE=SHR&SND_KIND="+snd_kind+"&OCC_CD="+occ_cd+"&RAI_YMD="+rai_ymd+"&AOW_GBN="+aow_gbn+"&AOW_YMD="+aow_ymd+"&DPT_CD="+dpt_cd+"&JOB_CD="+job_cd+"&GBN="+gbn;
            dsT_PM_GRADE.reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
            var f = document.form1;
            var snd_kind = "";
            if(f.rdoSND_KIND[0].checked){
                snd_kind = "PAY";  //�޿�
            } else {
                snd_kind = "BNS";  //��
            }
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var rai_ymd = f.txtRAI_YMD_SHR.value;
            var aow_gbn = "";
            if(f.chkAOW_GBN_SHR.checked){
                aow_gbn = "Y";
            }
            var aow_ymd = f.txtAOW_YMD_SHR.value;
            var gbn = "";
            var dpt_cd = f.cmbDPT_CD_SHR.value;
            var job_cd = f.cmbJOB_CD_SHR.value;
            if(f.rdoGBN_SHR[0].checked){
                gbn = "DPT";
            } else {
                gbn = "JOB";
            }
            
            var url = "graa040_PV.jsp?SND_KIND="+snd_kind+"&OCC_CD="+occ_cd+"&RAI_YMD="+rai_ymd+"&AOW_GBN="+aow_gbn+"&AOW_YMD="+aow_ymd+"&DPT_CD="+dpt_cd+"&JOB_CD="+job_cd+"&GBN="+gbn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			if (dsT_PM_GRADE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            
            form1.grdT_PM_GRADE.GridToExcel("���κ��޻���Ȳ", '', 225)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
			
            var f = document.form1;
            f.rdoSND_KIND[0].checked = true;
            f.cmbOCC_CD_SHR.selectedIndex = 0;
            //f.txtRAI_YMD_SHR.value = raiYmd;
            f.chkAOW_GBN_SHR.checked = true;
            //f.txtAOW_YMD_SHR.value = raiYmd;
            f.cmbDPT_CD_SHR.selectedIndex = 0;
            f.cmbJOB_CD_SHR.selectedIndex = 0;
            f.rdoGBN_SHR[0].checked = true;
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_GRADE.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {
			
			var rai_ymd = document.getElementById("txtRAI_YMD_SHR");
            var aow_ymd =  document.getElementById("txtAOW_YMD_SHR");
            
            if(rai_ymd.value == ""){
                alert("�±޿������� �ݵ�� �Է��ϼž� �մϴ�!");
                rai_ymd.focus();
                return false;
            }
            if(document.form1.chkAOW_GBN_SHR.checked == true && aow_ymd.value == ""){
                alert("�ټӼ��� ���ý� �������� �ݵ�� �Է��ϼž� �մϴ�!");
                aow_ymd.focus();
                return false;
            }
            return true;
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            
            // �ٷα���
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			//����
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR").add(oOption);
                
            }
            //�Ҽ�
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR").add(oOption);
                
            }
            document.form1.txtRAI_YMD_SHR.value = raiYmd;
            document.form1.txtAOW_YMD_SHR.value = raiYmd;
            document.form1.chkAOW_GBN_SHR.checked = true;

			cfStyleGrid(form1.grdT_PM_GRADE,0,"false","false");      // Grid Style ����
			
            document.getElementById('radio1').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



	</script>
	

 </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_PM_GRADE)    |
    | 3. ���Ǵ� Table List(T_PM_GRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
    </Object>

	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �Ҽ� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">
		
        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
            if(document.form1.chkAOW_GBN_SHR.checked){
                grdT_PM_GRADE.ColumnProp("AOW_AMT", "Show") = "true";
            }else {
                grdT_PM_GRADE.ColumnProp("AOW_AMT", "Show") = "false";
            }
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount-1);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ��޻���Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�±�/<font color="#000000">���κ��޻���Ȳ</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="100"></col>
									<col width="60"></col>
									<col width="150"></col>
									<col width="80"></col>
									<col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">��¼���&nbsp;</td>
								<td class="padding2423">
									<input type="radio" id="radio1" name="rdoSND_KIND" style="border:none" value="0" checked>�޿� <input type="radio" id="radio2" name="rdoSND_KIND" style="border:none" value="1">��
								</td>
								<td align="right" class="searchState">�ٷα���&nbsp;</td>
								<td class="padding2423">
									<select id="cmbOCC_CD_SHR" name="cmbOCC_CD_SHR" style="WIDTH:80%"></select>
								</td>
								<td align="right" class="searchState">�±޿�����&nbsp;</td>
								<td class="padding2423"><input id="txtRAI_YMD_SHR" name="txtRAI_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAI_YMD_SHR','','460','106');"></a></td>
							</tr>
							<tr>
								<td align="right" class="searchState">��±���&nbsp;</td>
								<td class="padding2423" colspan="5">
								    &nbsp;�ټӼ���<input type= "checkbox" name="chkAOW_GBN_SHR" value="Y" style="border:none">
								    &nbsp;&nbsp;������
								    <input id="txtAOW_YMD_SHR" name="txtAOW_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAOW_YMD_SHR','','220','135');"></a>
									&nbsp;&nbsp;<input type="radio" id="radio11" name="rdoGBN_SHR" style="border:none" value="0" checked>�Ҽ�
                                    <select id="cmbDPT_CD_SHR" name="cmbDPT_CD_SHR" style="WIDTH:120">
                                    </select>
                                    <input type="radio" id="radio12" name="rdoGBN_SHR" style="border:none" value="0">����
                                    <select id="cmbJOB_CD_SHR" name="cmbJOB_CD_SHR" style="WIDTH:100">
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
                        <object	id="grdT_PM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                            <param name="DataID"                    value="dsT_PM_GRADE">
                            <param name="Format"                    value="
                                <C> id={currow}     width=29    name='NO'           align=center </C>
                                <C> id='DPT_NM'     width=100    name='�Ҽ�'         align=center subsumtext='��  ��'</C>
                                <C> id='PJOB_NM'     width=50    name='����'         align=center </C>
                                <C> id='ENO_NO'     width=70    name='���'         align=center </C>
                                <C> id='ENO_NM'     width=70    name='����'         align=center </C>
                                <C> id='HIR_YMD'    width=70    name='�Ի���'       align=center Mask='XXXX-XX-XX'</C>
                                <C> id='GHI_YMD'    width=70    name='�׷��Ի���'   align=center Mask='XXXX-XX-XX'</C>
                                <C> id='FPRO_YMD'   width=70    name='����������'   align=center Mask='XXXX-XX-XX'</C>
                                <C> id='YRP_CNT'    width=35    name='����'         align=center </C>
                                <C> id='BAS_HOB'    width=55    name='����ȣ��'     align=center </C>
                                <C> id='HOB'        width=55    name='����ȣ��'     align=center </C>
                                <C> id='SAL_AMT'    width=75    name='����޿�'       align=right </C>
                                <C> id='CON_HOB'    width=55    name='����ȣ��'     align=center </C>
                                <C> id='CON_SAL'    width=75    name='�����޿�'     align=right </C>
                                <C> id='FIN_HOB'    width=55    name='Ȯ��ȣ��'     align=center </C>
                                <C> id='FIN_SAL'    width=75    name='Ȯ���޿�'     align=right </C>
                                <C> id='AOW_AMT'    width=60    name='�ټӼ���'     align=right </C>
                                <C> id='INC_AMT'    width=70    name='�λ��'       align=right </C>
                                <C> id='INC_PER'    width=40    name='�λ���'       align=right </C>
                                <C> id='REMARK'     width=150   name='���'         align=left </C>
                            ">
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
