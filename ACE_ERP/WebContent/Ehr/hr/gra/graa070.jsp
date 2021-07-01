<!--
***********************************************************************
* @source      : graa070.jsp
* @description : �޻󿩼ұ�ó�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      ���뼺        �����ۼ�.
* 2007/04/25      ���м�        �μ�κ��߰�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�޻󿩼ұ�ó��(graa070)</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFTTTTFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;
            var pis_yymm = f.txtPIS_YYMM_SHR.value;
            var occ_cd = f.cmbOCC_CD_SHR.value;
            var dpt_cd1 = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2 = f.cmbDPT_CD_SHR2.value;
            var job_cd1 = f.cmbJOB_CD_SHR1.value;
            var job_cd2 = f.cmbJOB_CD_SHR2.value;
            var cd_gbn = "";
            if(f.rdoSEL_SHR[0].checked){
                cd_gbn = "A4";  //�Ҽ�
            } else {
                cd_gbn = "A2";  //����
            }

            if(!fnc_SearchItemCheck()) return;

			dsT_CP_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa070.cmd.GRAA070CMD&S_MODE=SHR&PIS_YYMM="+pis_yymm+"&OCC_CD="+occ_cd+"&DPT_CD1="+dpt_cd1+"&DPT_CD2="+dpt_cd2+"&JOB_CD1="+job_cd1+"&JOB_CD2="+job_cd2+"&CD_GBN="+cd_gbn;
    		dsT_CP_CHANGE.reset();

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
            var f = document.form1;
            var PIS_YYMM_SHR = f.txtPIS_YYMM_SHR.value;
            var RET_YYMM_SHR = f.txtRET_YYMM_SHR.value;
            var APY_YMD_SHR = f.txtAPY_YMD_SHR.value;

			//���Գ���� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���Գ���� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//���Գ���� �߸��Ǿ����� ��ȸ����.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("���Գ���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//�ұ޳���� ������ ��ȸ����.
			if(RET_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ұ޳���� �Է��ϼ���.");
					document.getElementById("txtRET_YYMM_SHR").focus();
					return false;
				}
			}

			//�ұ޳���� �߸��Ǿ����� ��ȸ����.
			if(RET_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ұ޳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtRET_YYMM_SHR").focus();
					return false;
				}
			}

			//ȣ��ǥ������ ������ ��ȸ����.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("ȣ��ǥ���ڸ� �Է��ϼ���.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//ȣ��ǥ������ �߸��Ǿ����� ��ȸ����.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("ȣ��ǥ���ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

            if (confirm("�޻� �ұ�ó���� �Ͻðڽ��ϱ�? ") == false) return;


			dsT_CP_WORKLOG.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa070.cmd.GRAA070CMD&S_MODE=SAV&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&RET_YYMM_SHR="+RET_YYMM_SHR+"&APY_YMD_SHR="+APY_YMD_SHR;
			dsT_CP_WORKLOG.reset();
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
            var pis_yymm = f.txtPIS_YYMM_SHR.value;
            var occ_cd   = f.cmbOCC_CD_SHR.value;
            var dpt_cd1  = f.cmbDPT_CD_SHR1.value;
            var dpt_cd2  = f.cmbDPT_CD_SHR2.value;
            var job_cd1  = f.cmbJOB_CD_SHR1.value;
            var job_cd2  = f.cmbJOB_CD_SHR2.value;

            var cd_gbn = "";
            if(f.rdoSEL_SHR[0].checked){
                cd_gbn = "A4";
            } else {
                cd_gbn = "A2";  //��
            }

            if(!fnc_SearchItemCheck()) return;

            var url = "graa070_PV.jsp?pis_yymm="+pis_yymm+"&occ_cd="+occ_cd+"&dpt_cd1="+dpt_cd1+"&dpt_cd2="+dpt_cd2+"&job_cd1="+job_cd1+"&dpt_cd2="+dpt_cd2+"&cd_gbn="+cd_gbn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_CHANGE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            
            form1.grdT_CP_CHANGE.GridToExcel("�޻󿩼ұ�ó��", '', 225)

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

            //document.getElementById('txtPIS_YYMM_SHR').value = '';
            //document.getElementById('txtRET_YYMM_SHR').value = '';
            //document.getElementById('txtAPY_YMD_SHR').value = '';
            document.getElementById('cmbOCC_CD_SHR').value = 'A';
            document.getElementById('cmbDPT_CD_SHR1').value = ' ';
            document.getElementById('cmbDPT_CD_SHR2').value = ' ';
            document.getElementById('cmbJOB_CD_SHR1').value = ' ';
            document.getElementById('cmbJOB_CD_SHR2').value = ' ';
            document.form1.rdoSEL_SHR[0].checked = true;
			document.getElementById("resultMessage").innerText = ' ';

            changeInput();
            
			dsT_CP_CHANGE.ClearData();
			dsT_CP_WORKLOG.ClearData();

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

			var pis_yymm = document.getElementById("txtPIS_YYMM_SHR");

            if(pis_yymm.value == ""){
                alert("���Գ���� �ݵ�� �Է��ϼž��մϴ�!");
                pis_yymm.focus();
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

			cfStyleGrid(form1.grdT_CP_CHANGE,0,"false","false");      // Grid Style ����
			
			changeInput();
			
			document.getElementById('txtPIS_YYMM_SHR').value = getToday().substring(0,4)+"-04";
			document.getElementById('txtRET_YYMM_SHR').value = getToday().substring(0,4)+"-03";
			
			//ȣ��ǥ���� �ڵ����� ��������
            ds01T_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR_01";
            ds01T_CP_PAYTABLE.Reset();

            document.getElementById('txtPIS_YYMM_SHR').focus();
            
            

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************
         * ����/�Ҽ� ���ÿ� ���� �Է� ����          *
         ********************************************/
        function changeInput() {

            if( document.form1.rdoSEL_SHR[0].checked ){
                document.form1.cmbDPT_CD_SHR1.disabled = false;
                document.form1.cmbDPT_CD_SHR2.disabled = false;
                document.form1.cmbJOB_CD_SHR1.disabled = true;
                document.form1.cmbJOB_CD_SHR2.disabled = true;

                document.form1.cmbDPT_CD_SHR1.value = " ";
                document.form1.cmbDPT_CD_SHR2.value = " ";
                document.form1.cmbJOB_CD_SHR1.value = " ";
                document.form1.cmbJOB_CD_SHR2.value = " ";

            }else{
                document.form1.cmbDPT_CD_SHR1.disabled = true;
                document.form1.cmbDPT_CD_SHR2.disabled = true;
                document.form1.cmbJOB_CD_SHR1.disabled = false;
                document.form1.cmbJOB_CD_SHR2.disabled = false;            

                document.form1.cmbDPT_CD_SHR1.value = " ";
                document.form1.cmbDPT_CD_SHR2.value = " ";
                document.form1.cmbJOB_CD_SHR1.value = " ";
                document.form1.cmbJOB_CD_SHR2.value = " ";
               
            }

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_CHANGE)   |
    | 3. ���Ǵ� Table List(T_CP_CHANGE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubSumExpr"      value="total">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_WORKLOG)   |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubSumExpr"      value="total">
        <param name=TimeOut           value=200000>
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount-1);//�հ� ����(-1)

            //�׸��忡 �հ� ���� ǥ��
//            var sum = 0;
//
//            for(i=1;i<=iCount;i++){
//                sum = sum + dsT_CP_CHANGE.NameValue(i,"AMOUNT");
//            }
//            dsT_CP_CHANGE.AddRow();
//
//            dsT_CP_CHANGE.NameValue(iCount+1,"DPT_NM") = "      ��   ��";
//            dsT_CP_CHANGE.NameValue(iCount+1,"ENO_NO") = iCount+" ��";
//            dsT_CP_CHANGE.NameValue(iCount+1,"AMOUNT") = sum;

        }

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </Script>
    
    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
            var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
            document.getElementById("txtAPY_YMD_SHR").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
            document.getElementById("txtAPY_YMD_SHR").focus();
        }
    </Script>    

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>
    
    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޻󿩼ұ�ó��</td>
					<td align="right" class="navigator">HOME/�λ����/�±�/<font color="#000000">�޻󿩼ұ�ó��</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ConductOver.gif',1)">    <img src="/images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>			
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
                                    <col width="65"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="230"></col>
                                    <col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">���Գ��&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                   <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','10','120');"></a>
                                </td>
								<td align="right" class="searchState">�ٷα���&nbsp;</td>
								<td class="padding2423">
									<select id="cmbOCC_CD_SHR" style="WIDTH:60" onChange="fnc_SearchList();">
									</select>
								</td>
								<td class="padding2423">
									<input type="radio" id="radio11" name="rdoSEL_SHR" style="border:none" value="0" onClick="changeInput()" checked>
									<b>�Ҽ�</b>
                                    <select id="cmbDPT_CD_SHR1" name="cmbDPT_CD_SHR1" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                    ~
                                    <select id="cmbDPT_CD_SHR2" name="cmbDPT_CD_SHR2" style="WIDTH:75">
                                        <option value=" "> </option>
                                    </select>
                                </td>
								<td>
								    <input type="radio" id="radio12" name="rdoSEL_SHR" style="border:none" value="0" onClick="changeInput()">
								    <b>����</b>
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
								<td align="right" class="searchState">�ұ޳��&nbsp;</td>
								<td class="padding2423"><input id="txtRET_YYMM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtRET_YYMM_SHR','','10','150');"></a>
                                </td>
								<td align="right" class="searchState">ȣ��ǥ����&nbsp;</td>
								<td class="padding2423" colspan="3">
									<input id="txtAPY_YMD_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','220','150');"></a>
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
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_CP_CHANGE">
							<param name="Format"					value="
								<C> id={currow}		width=40    name='NO'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='DPT_NM'		width=120	name='�Ҽ�'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} SubSumText='�հ�'</C>
								<C> id='JOB_NM'		width=74	name='����'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='ENO_NO'		width=90	name='���'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='ENO_NM'		width=90	name='����'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='PAY_CNT'	width=70	name='Ƚ��'		align=center    BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='AMOUNT'		width=110	name='�ұ޾�'	align=right     BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
								<C> id='REMARK'		width=185	name='���'		align=left      BgColor={decode(ENO_NO, '', '#99FFCC')} </C>
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
