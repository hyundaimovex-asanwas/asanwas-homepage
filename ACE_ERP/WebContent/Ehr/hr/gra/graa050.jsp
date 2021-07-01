<!--
***********************************************************************
* @source      : graa050.jsp
* @description : ����ȣ�����ӱ�������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      ���뼺        �����ۼ�.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����ȣ�����ӱ�������Ȳ(graa050)</title>
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

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			
			var f = document.form1;
            var snd_kind = "";
            if(f.rdoSND_KIND[0].checked){
                snd_kind = "PAY";  //�޿�
            } else {
                snd_kind = "BNS";  //��
            }
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var rai_ymd = f.txtRAI_YMD_SHR.value;
            var hba_ymd = f.txtHBA_YMD_SHR.value;
            var pis_ym = f.txtPIS_YM_SHR.value;
            var gubun = f.cmb_GUBUN_SHR.value;
            var dpt_cd1 = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2 = f.cmbDPT_CD_SHR2.value;
            var job_cd1 = f.cmbJOB_CD_SHR1.value;
            var job_cd2 = f.cmbJOB_CD_SHR2.value;
            var sel = "";
            if(f.rdoSEL_SHR[0].checked){
                sel = "DPT";   //�Ҽ�
            } else {
                sel = "JOB";  //����
            }

            if(!fnc_SearchItemCheck()) return;

			dsT_PM_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa050.cmd.GRAA050CMD&S_MODE=SHR&SND_KIND="+snd_kind+"&OCC_CD="+occ_cd+"&RAI_YMD="+rai_ymd+"&HBA_YMD="+hba_ymd+"&PIS_YM="+pis_ym+"&DPT_CD1="+dpt_cd1+"&DPT_CD2="+dpt_cd2+"&JOB_CD1="+job_cd1+"&JOB_CD2="+job_cd2+"&GUBUN="+gubun+"&SEL="+sel;
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
            var hba_ymd = f.txtHBA_YMD_SHR.value;
            var pis_ym = f.txtPIS_YM_SHR.value;
            var gubun = f.cmb_GUBUN_SHR.value;
            var dpt_cd1 = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2 = f.cmbDPT_CD_SHR2.value;
            var job_cd1 = f.cmbJOB_CD_SHR1.value;
            var job_cd2 = f.cmbJOB_CD_SHR2.value;
            var sel = "";
            if(f.rdoSEL_SHR[0].checked){
                sel = "DPT";
            } else {
                sel = "JOB";  //��
            }

            var url = "graa050_PV.jsp?SND_KIND="+snd_kind+"&OCC_CD="+occ_cd+"&RAI_YMD="+rai_ymd+"&HBA_YMD="+hba_ymd+"&PIS_YM="+pis_ym+"&DPT_CD1="+dpt_cd1+"&DPT_CD2="+dpt_cd2+"&JOB_CD1="+job_cd1+"&JOB_CD2="+job_cd2+"&GUBUN="+gubun+"&SEL="+sel;
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
            
            form1.grdT_PM_GRADE.GridToExcel("����ȣ�����ӱ�������Ȳ", '', 225)

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
            f.rdoSEL_SHR[0].checked = true;
            f.cmbOCC_CD_SHR.value = "";
            //f.txtRAI_YMD_SHR.value = "";
            //f.txtHBA_YMD_SHR.value = "";
            //f.txtPIS_YM_SHR.value = "";
            f.cmb_GUBUN_SHR.value = "CON";
            f.cmbDPT_CD_SHR1.value = "";
            f.cmbDPT_CD_SHR2.value = "";
            f.cmbJOB_CD_SHR1.value = "";
            f.cmbJOB_CD_SHR2.value = "";
			
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
			
			var pis_ym = document.getElementById("txtPIS_YM_SHR");
            var rai_ymd = document.getElementById("txtRAI_YMD_SHR");
            var hba_ymd = document.getElementById("txtHBA_YMD_SHR");

            if(pis_ym.value == ""){
                alert("������س���� �ݵ�� �Է��ϼž��մϴ�!");
                pis_ym.focus();
                return false;
            }
            if(rai_ymd.value == ""){
                alert("�±޿������� �ݵ�� �Է��ϼž��մϴ�!");
                rai_ymd.focus();
                return false;
            }
            if(hba_ymd.value == ""){
                alert("����±����� �ݵ�� �Է��ϼž��մϴ�!");
                hba_ymd.focus();
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

			//�ٷα���
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);
                
            }
            
            //����
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR1").add(oOption);
                
            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR2").add(oOption);
                
            }
            
            //�Ҽ�
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR1").add(oOption);
                
            }            
            for( var i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR2").add(oOption);
                
            }

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
        <param name="SubSumExpr"      value="total , 1:PJOB_CD, 1:PJOB_NM">
    </Object>

	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
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
			
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ȣ�����ӱ�������Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�±�/<font color="#000000">����ȣ�����ӱ�������Ȳ</font></td>
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
									<col width="85"></col>
									<col width="95"></col>
									<col width="60"></col>
									<col width="70"></col>
									<col width="75"></col>
									<col width="150"></col>
									<col width="75"></col>
									<col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">��¼���&nbsp;</td>
								<td class="padding2423">
                                    <input type="radio" id="radio1" name="rdoSND_KIND" style="border:none" value="0" checked>�޿� 
                                    <input type="radio" id="radio2" name="rdoSND_KIND" style="border:none" value="1">��
								</td>
								<td align="right" class="searchState">�ٷα���&nbsp;</td>
								<td class="padding2423">
									<select id="cmbOCC_CD_SHR" style="WIDTH:60">
                                        <option value="">��ü</option>
									</select>
								</td>
								<td colspan="2">
								    <input type="radio" id="radio11" name="rdoSEL_SHR" style="border:none" value="0" checked>�Ҽ� 
                                    <select id="cmbDPT_CD_SHR1" name="cmbDPT_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~ 
                                    <select id="cmbDPT_CD_SHR2" name="cmbDPT_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                </td>
								<td colspan="2">
								    <input type="radio" id="radio12" name="rdoSEL_SHR" style="border:none" value="0">���� 
                                    <select id="cmbJOB_CD_SHR1" name="cmbJOB_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~ 
                                    <select id="cmbJOB_CD_SHR2" name="cmbJOB_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                </td>
							</tr>
							<tr>
								<td align="right" class="searchState">������س��&nbsp;</td>
								<td class="padding2423">
								    <input id="txtPIS_YM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','50','138');"></a></td>
								<td align="right" class="searchState">�����ڷ�&nbsp;</td>
								<td class="padding2423">
									<select id="cmb_GUBUN_SHR" style="WIDTH:60">
										<option value="CON">����</option>
                                        <option value="FIN">Ȯ��</option>
									</select>
								</td>
                                <td align="right" class="searchState">�±޿�����&nbsp;</td>
								<td class="padding2423">
								    <input id="txtRAI_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAI_YMD_SHR','','380','138');"></a>
								</td>
                                <td align="right" class="searchState">����±���&nbsp;</td>
								<td class="padding2423">
								    <input id="txtHBA_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHBA_YMD_SHR','','615','138');"></a>
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
						<object	id="grdT_PM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_PM_GRADE">
							<param name="Format"					value="
								<C> id='PJOB_CD'	width=60    name='����'			align=center Show=false</C>
                                <C> id='JOB_NM'	    width=60    name='����'			align=center BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} SubSumText='�� ��'</C>
								<C> id='HOB'		width=50	name='��ȣ��'		align=center BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='CNT'		width=60	name='���ο�'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='AVR_SAL'	width=80	name='���ӱ�'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_SAL)),AVR_SAL)} </C>
								<C> id='AVR_AOW'	width=80	name='���ټ�'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_AOW)),AVR_AOW)} </C>
								<C> id='ETC_AVR'	width=80	name='����Ÿ'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(ETC_AVR)),ETC_AVR)} </C>
								<C> id='SUM_SAL'	width=80	name='���հ�'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} DECAO=0</C>
								<C> id='HOB2'		width=50	name='��ȣ��'		align=center BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='CNT2'		width=60	name='���ο�'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} </C>
								<C> id='AVR_SAL2'		width=80	name='���ӱ�'	align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_SAL2)),AVR_SAL2)} </C>
								<C> id='AVR_AOW2'		width=80	name='�ıټ�'	align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(AVR_AOW2)),AVR_AOW2)} </C>
								<C> id='ETC_AVR2'	width=80	name='�ı�Ÿ'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SubAvg(ETC_AVR2)),ETC_AVR2)} </C>
								<C> id='SUM_SAL2'		width=80	name='���հ�'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} DECAO=0</C>
                                <C> id='INC_PER'		width=80	name='�λ���'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', decode(SUM_SAL2-SUM_SAL,0,0,((SUM_SAL2-SUM_SAL)/SUM_SAL*100))))} Dec=1</C>
								<C> id='INC_AMT'		width=80	name='�ҿ����'		align=right BgColor={decode(HOB, '', decode(HOB2, '', '#99FFCC'))} Value={decode(HOB,'',decode(HOB2, '', SUM_SAL2-SUM_SAL))}</C>
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