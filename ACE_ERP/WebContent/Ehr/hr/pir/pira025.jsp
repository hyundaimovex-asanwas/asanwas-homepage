<!--
    ************************************************************************************
    * @Source         : pira025.jsp                                                    *
    * @Description    : �Ի��İ�� PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�Ի��İ��</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
    String p_mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
    String p_srcid = request.getParameter("srcid") != null ? request.getParameter("srcid") : "";
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        var str_ymd = '';
        var seq_no  = '';
        var p_mode = "<%=p_mode %>";
        var p_srcid = "<%=p_srcid %>";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_AHISTORY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_AHISTORY.Reset();

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

            if(fnc_SaveItemCheck()) {

                trT_CM_AHISTORY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SAV";
                trT_CM_AHISTORY.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CM_AHISTORY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_AHISTORY.RowStatus(dsT_CM_AHISTORY.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_AHISTORY.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }


            //ù��° �ο�(�������� �� SEQ�� ����ū�Ÿ� ���� ����)���� ���ʴ�� ���� ����(�ƴϸ� ������ ���δ�)
            if(dsT_CM_AHISTORY.RowPosition != 1){
                alert("�ֱ� �Է� �����ͺ��� ������ �����մϴ�. ");
                return false;
            }


            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��������[" + dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition,"STR_YMD") + "] [" + dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition,"SEQ_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_AHISTORY.DeleteRow(dsT_CM_AHISTORY.RowPosition);

            if (status != 1) {
                trT_CM_AHISTORY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=DEL";
                trT_CM_AHISTORY.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_AHISTORY.SetColumn(form1.grdT_CM_AHISTORY.GetColumnID(0));
            form1.grdT_CM_AHISTORY.Focus();

            bnd.ActiveBind = true;

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CM_AHISTORY.CountColumn == 0) {
                dsT_CM_AHISTORY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, SEQ_NO:STRING:KEYVALUETYPE, OCC_CD:STRING, OCC_NM:STRING, END_YMD:STRING, APP_CD:STRING, APP_NM:STRING, HEAD_CD:STRING, HEAD_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, TEAM_CD:STRING, TEAM_NM:STRING, JOB_CD:STRING, JOB_NM:STRING,HOB_CD:STRING, HOB_NM:STRING,  DUTY_CD:STRING, DUTY_NM:STRING, SRV_CD:STRING, SRV_NM:STRING, PART_CD:STRING, PART_NM:STRING, CHIEF_YN:STRING, JCD_CD:STRING, JCD_NM:STRING, APP_YMD:STRING, REMARK:STRING, TAX_DPT:STRING, TAX_DPTNM:STRING");
            }

            //�űԸ� �ϱ��� �����ű��� �ʼ��׸��� ���� �� ���� ������ �߰� �Ұ�
            if(dsT_CM_AHISTORY.SysStatus(1) ==  "1" ){

	            if(dsT_CM_AHISTORY.NameValue(1,"STR_YMD").trim() == "" || // ����
	               dsT_CM_AHISTORY.NameValue(1,"DPT_CD" ).trim() == "" || // �Ҽ�
	               dsT_CM_AHISTORY.NameValue(1,"OCC_CD" ).trim() == "" || // �ٷα���
	               dsT_CM_AHISTORY.NameValue(1,"JOB_CD" ).trim() == "" || // ����
	               dsT_CM_AHISTORY.NameValue(1,"HOB_CD" ).trim() == "" || // ȣ��
	               dsT_CM_AHISTORY.NameValue(1,"DUTY_CD").trim() == "" || // ��å
	               dsT_CM_AHISTORY.NameValue(1,"APP_CD" ).trim() == "" || // �߷�
	               dsT_CM_AHISTORY.NameValue(1,"JCD_CD" ).trim() == "" || // ����
	               dsT_CM_AHISTORY.NameValue(1,"TAX_DPT").trim() == "" || // ȸ��
	               dsT_CM_AHISTORY.NameValue(1,"APP_YMD").trim() == ""){  // �λ�߷�

	                alert("�űԵ������� �ʼ��׸��� ��� �Է��ؾ� �߰��� �����մϴ�.");
	                return false;
	            }
            }
            
            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_AHISTORY.InsertRow(1);

            fnc_ColEnabled('E');

            form1.grdT_CM_AHISTORY.setColumn(form1.grdT_CM_AHISTORY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
        
            var temp = dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition,"SEQ_NO")+1;
 			 dsT_CM_AHISTORY.NameValue(1,"SEQ_NO") = temp; 			 
             document.getElementById("txtSEQ_NO").value = temp;
		
            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("cmbCHIEF_YN").value   = 'N';

			//���� �Ի��İ�¿� �������� ������ �״��� ��¥�� ���� ���� ������ ���� ��¥�� �����´�.
			//�����Է½� undefined ���´�.
			var END_YMD = dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition+1,"END_YMD");

			if(END_YMD != undefined && END_YMD.trim().length > 0){
	            document.getElementById("txtSTR_YMD").value = addDate("D",END_YMD, 1);
	            document.getElementById("txtAPP_YMD").value = addDate("D",END_YMD, 1);//�λ�߷��ϵ� ���� �־��ش�.
			}else{
	            document.getElementById("txtSTR_YMD").value = getToday();
	            document.getElementById("txtAPP_YMD").value = getToday();//�λ�߷��ϵ� ���� �־��ش�.
            }

            document.getElementById("txtSTR_YMD").focus();

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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_AHISTORY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_AHISTORY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_AHISTORY.CountRow; i++ ) {
                if ( dsT_CM_AHISTORY.RowStatus(i) == 1 ||
                     dsT_CM_AHISTORY.RowStatus(i) == 3 ) {


                    // ��������
                    if( dsT_CM_AHISTORY.NameValue(i, "STR_YMD") == '' ) {
                        alert("�������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_AHISTORY.NameValue(i, "STR_YMD"), "������") && dsT_CM_AHISTORY.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // �������� CHECK
                    if (!fnc_CheckDate2(dsT_CM_AHISTORY.NameValue(i, "END_YMD"), "������") && dsT_CM_AHISTORY.NameValue(i, "END_YMD") != "") {
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // �������ڿ� �������� ��
                    if( dsT_CM_AHISTORY.NameValue(i, "STR_YMD") != '' && dsT_CM_AHISTORY.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_AHISTORY.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_CM_AHISTORY.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_CM_AHISTORY.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
                        }
                    }

                    // �Ҽ�
                    if( dsT_CM_AHISTORY.NameValue(i, "DPT_CD") == '' ) {
                        alert("�Ҽ��� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return false;
                    }

                    // �Ҽ�
                    if (dsT_CM_AHISTORY.NameValue(i, "DPT_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "DPT_NM") == "") {
                        alert("�Ҽ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    }

                    // ��Ʈ
                    if (dsT_CM_AHISTORY.NameValue(i, "TEAM_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "TEAM_NM") == "") {
                        alert("��Ʈ�ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtTEAM_CD").focus();
                        return;
                    }

                    // ����
                    if( dsT_CM_AHISTORY.NameValue(i, "JOB_CD") == '' ) {
                        alert("������ �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtJOB_CD").focus();
                        return false;
                    }

                    // ����
                    if (dsT_CM_AHISTORY.NameValue(i, "JOB_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "JOB_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtJOB_CD").focus();
                        return;
                    }


                    // ��å
                    if (dsT_CM_AHISTORY.NameValue(i, "DUTY_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "DUTY_NM") == "") {
                        alert("��å�ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return;
                    }

                    // ����
                    if (dsT_CM_AHISTORY.NameValue(i, "SRV_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "SRV_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtSRV_CD").focus();
                        return;
                    }

                    // �ι�
                    if (dsT_CM_AHISTORY.NameValue(i, "PART_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "PART_NM") == "") {
                        alert("�ι��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtPART_CD").focus();
                        return;
                    }

                    // �߷�
                    if( dsT_CM_AHISTORY.NameValue(i, "APP_CD") == '' ) {
                        alert("�߷��� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtAPP_CD").focus();
                        return false;
                    }

                    // �߷�
                    if (dsT_CM_AHISTORY.NameValue(i, "APP_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "APP_NM") == "") {
                        alert("�߷��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtAPP_CD").focus();
                        return;
                    }

                    if (dsT_CM_AHISTORY.RowStatus(i) == 1) {
                        dsT_CM_AHISTORY.NameValue(i, "OLD_APP_CD") = dsT_CM_AHISTORY.NameValue(i, "APP_CD");
                    }

                    // ����
                    if( dsT_CM_AHISTORY.NameValue(i, "JCD_CD") == '' ) {
                        alert("������ �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtJCD_CD").focus();
                        return false;
                    }

                    // ����
                    if (dsT_CM_AHISTORY.NameValue(i, "JCD_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "JCD_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtJCD_CD").focus();
                        return;
                    }

                    // �ٷα���
                    if( dsT_CM_AHISTORY.NameValue(i, "OCC_CD") == '' ) {
                        alert("�ٷα����� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtOCC_CD").focus();
                        return false;
                    }

                    // �ٷα���
                    if (dsT_CM_AHISTORY.NameValue(i, "OCC_CD") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "OCC_NM") == "") {
                        alert("�ٷα����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtOCC_CD").focus();
                        return;
                    }

                    // ȸ��Ҽ�
                    if( dsT_CM_AHISTORY.NameValue(i, "TAX_DPT") == '' ) {
                        alert("ȸ��ҼӴ� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtTAX_DPT").focus();
                        return false;
                    }

                    // ȸ��Ҽ�
                    if (dsT_CM_AHISTORY.NameValue(i, "TAX_DPT") != "" &&
                        dsT_CM_AHISTORY.NameValue(i, "TAX_DPTNM") == "") {
                        alert("ȸ��Ҽ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtTAX_DPT").focus();
                        return;
                    }

                    // �λ�߷��� CHECK
                    if (!fnc_CheckDate2(dsT_CM_AHISTORY.NameValue(i, "APP_YMD"), "�λ�߷���") && dsT_CM_AHISTORY.NameValue(i, "APP_YMD") != "") {
                        dsT_CM_AHISTORY.RowPosition = i;
                        document.getElementById("txtAPP_YMD").focus();
                        return false;
                    }

                    if ( dsT_CM_AHISTORY.RowStatus(i) == 1) {
                        document.getElementById("txtSTR_YMD").disabled = true;
                        document.getElementById("ImgStrYmd").disabled  = true;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_AHISTORY, 0,"false","false");

            fnc_SearchList();

            //�������� ��ȸ�� ó��
            if (p_mode == "read" || p_srcid == 'pirc010') {
                document.getElementById("txtEND_YMD").className = "input_ReadOnly";
                document.getElementById("txtEND_YMD").readOnly     = true;
                document.getElementById("txtHEAD_CD").className = "input_ReadOnly";
                document.getElementById("txtHEAD_CD").readOnly     = true;
                document.getElementById("txtDPT_CD").className = "input_ReadOnly";
                document.getElementById("txtDPT_CD").readOnly     = true;
                document.getElementById("txtTEAM_CD").className = "input_ReadOnly";
                document.getElementById("txtTEAM_CD").readOnly     = true;
                document.getElementById("txtJOB_CD").className = "input_ReadOnly";
                document.getElementById("txtJOB_CD").readOnly     = true;
                document.getElementById("txtHOB_CD").className = "input_ReadOnly";
                document.getElementById("txtHOB_CD").readOnly     = true;
                document.getElementById("txtDUTY_CD").className = "input_ReadOnly";
                document.getElementById("txtDUTY_CD").readOnly     = true;
                document.getElementById("txtSRV_CD").className = "input_ReadOnly";
                document.getElementById("txtSRV_CD").readOnly     = true;
                document.getElementById("txtPART_CD").className = "input_ReadOnly";
                document.getElementById("txtPART_CD").readOnly     = true;
                document.getElementById("txtAPP_CD").className = "input_ReadOnly";
                document.getElementById("txtAPP_CD").readOnly     = true;
                document.getElementById("txtJCD_CD").className = "input_ReadOnly";
                document.getElementById("txtJCD_CD").readOnly     = true;
                document.getElementById("txtOCC_CD").className = "input_ReadOnly";
                document.getElementById("txtOCC_CD").readOnly     = true;
                document.getElementById("txtAPP_YMD").className = "input_ReadOnly";
                document.getElementById("txtAPP_YMD").readOnly     = true;
                document.getElementById("txtREMARK").className = "input_ReadOnly";
                document.getElementById("txtREMARK").readOnly     = true;
                document.getElementById("txtTAX_DPT").className = "input_ReadOnly";
                document.getElementById("txtTAX_DPTNM").readOnly     = true;
                document.getElementById("cmbCHIEF_YN").disabled   = true;
                document.getElementById("ImgStrYmd").style.display = "none";
                document.getElementById("ImgEndYmd").style.display = "none";
                document.getElementById("ImgDptCd").style.display = "none";
                document.getElementById("ImgTeamCd").style.display = "none";
                document.getElementById("ImgJobCd").style.display = "none";
                document.getElementById("ImgHobCd").style.display = "none";
                document.getElementById("ImgDutyCd").style.display = "none";
                document.getElementById("ImgSrvCd").style.display = "none";
                document.getElementById("ImgPartCd").style.display = "none";
                document.getElementById("ImgAppCd").style.display = "none";
                document.getElementById("ImgJcdCd").style.display = "none";
                document.getElementById("ImgOccCd").style.display = "none";
                document.getElementById("ImgAppYmd").style.display = "none";
                document.getElementById("ImgAdd").style.display = "none";
                document.getElementById("imgSave").style.display = "none";
                document.getElementById("imgClear").style.display = "none";
                document.getElementById("imgDelete").style.display = "none";
                document.getElementById("imgTaxDpt").style.display = "none";

                document.getElementById("imgInforcopy").style.display = "none";

                //�忩�� �����
                document.getElementById("cmbCHIEF_YN").style.display = "none";
                document.getElementById("txtCHIEF_YN").style.display = "none";
                form1.grdT_CM_AHISTORY.ColumnProp("CHIEF_YN","Show") = false;

            }

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_AHISTORY.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_PIRA025_HotKey(event.ctrlKey, event.keyCode);

        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtSEQ_NO").disabled   = true;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtTEAM_CD").disabled  = false;
                document.getElementById("txtJOB_CD").disabled   = false;
                document.getElementById("txtHOB_CD").disabled   = false;
                document.getElementById("txtDUTY_CD").disabled  = false;
                document.getElementById("txtSRV_CD").disabled   = false;
                document.getElementById("txtPART_CD").disabled  = false;
                document.getElementById("cmbCHIEF_YN").disabled = false;
                document.getElementById("txtAPP_CD").disabled   = false;
                document.getElementById("txtJCD_CD").disabled   = false;
                document.getElementById("txtOCC_CD").disabled   = false;
                document.getElementById("txtAPP_YMD").disabled  = false;
                document.getElementById("txtREMARK").disabled   = false;
                document.getElementById("txtTAX_DPT").disabled  = false;

                document.getElementById("ImgStrYmd").disabled   = false;
                document.getElementById("ImgEndYmd").disabled   = false;
                document.getElementById("ImgDptCd").disabled    = false;
                document.getElementById("ImgTeamCd").disabled   = false;
                document.getElementById("ImgJobCd").disabled    = false;
                document.getElementById("ImgHobCd").disabled    = false;
                document.getElementById("ImgDutyCd").disabled   = false;
                document.getElementById("ImgSrvCd").disabled    = false;
                document.getElementById("ImgPartCd").disabled   = false;
                document.getElementById("ImgAppCd").disabled    = false;
                document.getElementById("ImgJcdCd").disabled    = false;
                document.getElementById("ImgOccCd").disabled    = false;
                document.getElementById("ImgAppYmd").disabled   = false;
                document.getElementById("ImgTaxDpt").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtSEQ_NO").disabled   = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtTEAM_CD").disabled  = true;
                document.getElementById("txtJOB_CD").disabled   = true;
                document.getElementById("txtHOB_CD").disabled   = true;
                document.getElementById("txtDUTY_CD").disabled  = true;
                document.getElementById("txtSRV_CD").disabled   = true;
                document.getElementById("txtPART_CD").disabled  = true;
                document.getElementById("cmbCHIEF_YN").disabled = true;
                document.getElementById("txtAPP_CD").disabled   = true;
                document.getElementById("txtJCD_CD").disabled   = true;
                document.getElementById("txtOCC_CD").disabled   = true;
                document.getElementById("txtAPP_YMD").disabled  = true;
                document.getElementById("txtREMARK").disabled   = true;
                document.getElementById("txtTAX_DPT").disabled  = true;

                document.getElementById("ImgStrYmd").disabled   = true;
                document.getElementById("ImgEndYmd").disabled   = true;
                document.getElementById("ImgDptCd").disabled    = true;
                document.getElementById("ImgTeamCd").disabled   = true;
                document.getElementById("ImgJobCd").disabled    = true;
                document.getElementById("ImgHobCd").disabled    = true;
                document.getElementById("ImgDutyCd").disabled   = true;
                document.getElementById("ImgSrvCd").disabled    = true;
                document.getElementById("ImgPartCd").disabled   = true;
                document.getElementById("ImgAppCd").disabled    = true;
                document.getElementById("ImgJcdCd").disabled    = true;
                document.getElementById("ImgOccCd").disabled    = true;
                document.getElementById("ImgAppYmd").disabled   = true;
                document.getElementById("ImgTaxDpt").disabled   = true;

            }
        }


        function fnc_getSeqNo(obj) {

        	var SysStatus = dsT_CM_AHISTORY.SysStatus(dsT_CM_AHISTORY.RowPosition);
            var SeqNo = 1;
              
            if (SysStatus == 1) {

                if (obj.value != '') {

                    for (var i = 1; i <= dsT_CM_AHISTORY.CountRow; i++) {
                       	
                        if (dsT_CM_AHISTORY.NameValue(i, "STR_YMD") == obj.value) {

                           SeqNo = new Number(dsT_CM_AHISTORY.NameValue(2, "SEQ_NO")) + 1;
                           
                        }
                    }

                    if (SeqNo == 0) {
                        SeqNo = 1;
                    }

                    document.getElementById("txtSEQ_NO").value = SeqNo;
                }
                    
            }

            str_ymd = document.getElementById("txtSTR_YMD").value;
            seq_no  = document.getElementById("txtSEQ_NO").value;

        }

        function fnc_BlurYmd() {
            if (str_ymd == document.getElementById("txtSTR_YMD").value &&
                seq_no  == document.getElementById("txtSEQ_NO").value) {
                return;
            }

            fnc_getSeqNo(document.getElementById("txtSTR_YMD"));

        }

        function fnc_ChgBlurYmd() {

            fnc_getSeqNo(document.getElementById("txtSTR_YMD"));
            
            document.getElementById("txtAPP_YMD").value = document.getElementById("txtSTR_YMD").value;
            
        }

        /************************************************
         * ���� �� �Ҽ��ڵ� �˾�â ó��                 *
         ************************************************/
        function fnc_DptNmPopup(gbn) {

            var obj = new String();

            if (gbn == 'DEPT') {
                obj.title = '�Ҽ�';
                obj.gbn   = 'DEPT2';

                window.showModalDialog("../../common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                if(obj.comm_cd != '' && obj.comm_nm != '') {
                    document.getElementById('txtDPT_CD').value  = obj.comm_cd;
                    document.getElementById('txtDPT_NM').value  = obj.comm_nm;
                    document.getElementById('txtTEAM_CD').value = '';
                    document.getElementById('txtTEAM_NM').value = '';

                    // �ش� �Ҽ��� �ι��� �����´�.
                    fnc_GetPartNm('txtDPT_CD','txtPART_CD','txtPART_NM');

                    // ������ �ڵ��� ������ �����̸�
                    if (obj.cd_gbn == 'B2') {
                        document.getElementById('txtHEAD_CD').value = obj.comm_cd;
                        document.getElementById('txtHEAD_NM').value = obj.comm_nm;
                    }
                    else {

                        // �ش�Ҽ��� ���� ã�ƿ���
                        // �Ҽ��ڵ�
                        fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM', 'txtHEAD_CD');

                        // �����ڵ�� ã�ƿ���
                        fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');

                    }
                }

                // ȸ��Ҽ� �Է�
                 //document.getElementById('txtTAX_DPT').value = document.getElementById('txtDPT_CD').value;
                 //document.getElementById('txtTAX_DPTNM').value = document.getElementById('txtDPT_NM').value;

            }
            else if (gbn == 'TEAM') {
                if (document.getElementById("txtDPT_CD").value == "") {
                    alert("�Ҽ��ڵ带 ���� �Է��Ͻ� �� ��Ʈ�ڵ� �˾�â�� �����Ͽ� �ֽʽÿ�.");
                    return;
                }
                else {
                    fnc_commnmPopup('txtTEAM_CD','txtTEAM_NM','��','TEAM','txtDPT_CD');
                }
            }
        }

        /*************************************************
         * ����, ����, ���� �� �����ڵ� ��ȸ�� �˾�      *
         ************************************************/
        function fnc_dutyPopup(ctrl_01, ctrl_02) {

            var obj = new String();

            window.showModalDialog("../../common/popup/duty.jsp", obj, "dialogWidth:400px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.duty_cd != ''){

                document.getElementById(ctrl_01).value = obj.duty_cd;
                document.getElementById(ctrl_02).value = obj.duty_nm;
            }

        }

        /*************************************************
         * �Ҽ� �� ��Ʈ�ڵ� �Է½� �ش� �� DISPLAY         *
         ************************************************/
        function fnc_CommNm(gbn) {
            var DEPT_CD = '';

            // �Ҽ��ڵ�
            if (gbn == 'DEPT') {
                document.getElementById('txtHEAD_CD').value = "";
                document.getElementById('txtHEAD_NM').value = "";
                document.getElementById('txtTEAM_CD').value = "";
                document.getElementById('txtTEAM_NM').value = "";

                // �Ҽ��ڵ�
                fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM', 'txtHEAD_CD');
				// �ش� �Ҽ��� �ι��� �����´�.
                fnc_GetPartNm('txtDPT_CD','txtPART_CD','txtPART_NM');

				// �ڵ常 �ְ� �ڵ���� ������ ���δ� (�Ҽӿ� ���ε� �Է� ����)
                if (document.getElementById('txtDPT_CD').value != "" && document.getElementById('txtDPT_NM').value == "") {
                    fnc_GetCommNm('B2', 'txtDPT_CD','txtDPT_NM');

                }

                // ���������ڵ� �����ϸ� �ش� �ڵ�� �Ҽ�
                if (document.getElementById('txtHEAD_CD').value != "") {
                    // �����ڵ�
                    fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');
                }
                // ���������ڵ� �������� �ʰ� �Ҽ��ڵ尡 �����ϸ� �Ҽ��ڵ� ��ü�� �����ڵ尡 ��
                else {

                    if (document.getElementById('txtDPT_CD').value != "" && document.getElementById('txtDPT_NM').value != "") {
                        document.getElementById('txtHEAD_CD').value = document.getElementById('txtDPT_CD').value;
                        document.getElementById('txtHEAD_NM').value = document.getElementById('txtDPT_NM').value;
                    }
                    else {
                        document.getElementById('txtHEAD_CD').value = "";
                        document.getElementById('txtHEAD_NM').value = "";
                    }
                }

                // ȸ��Ҽ� �Է�
                 //document.getElementById('txtTAX_DPT').value = document.getElementById('txtDPT_CD').value;
                 //document.getElementById('txtTAX_DPTNM').value = document.getElementById('txtDPT_NM').value;
            }
            // ��Ʈ�ڵ�
            else if (gbn == 'TEAM') {
                if (document.getElementById('txtDPT_CD').value != "" && document.getElementById('txtDPT_NM').value != "") {
                    if (document.getElementById('txtDPT_CD').value != document.getElementById('txtHEAD_CD').value) {

                        DEPT_CD = document.getElementById('txtDPT_CD').value;
                        fnc_GetCommNm('A6', 'txtTEAM_CD','txtTEAM_NM', 'txtDPT_CD');
                    }
                }
                else {
                    alert("�Ҽ��ڵ带 ���� �Է��Ͻ� �� ��Ʈ�ڵ带 �Է��Ͽ� �ֽʽÿ�.");
                    document.getElementById('txtTEAM_CD').value = "";
                    document.getElementById('txtTEAM_NM').value = "";
                    return;
                }
            }
        }

        function fnc_ClickBtn() {

            var StrYmd    = '';
            var SeqNo     = '';
            var iRow      = 0;
            var Row       = dsT_CM_AHISTORY.RowPosition;

            if (dsT_CM_AHISTORY.RowStatus(dsT_CM_AHISTORY.RowPosition) != 1) {
                // �ش� ROW�� �ű԰� �ƴ� ��� ����
                alert("�ű��۾��ø� ���������� ������ �� �ֽ��ϴ�.");
                return;
            }

            for (var i = 1; i <= dsT_CM_AHISTORY.CountRow; i++ ) {
                if (Row != i) {

                    if( dsT_CM_AHISTORY.NameValue(i, "STR_YMD") > StrYmd) {
                        StrYmd = dsT_CM_AHISTORY.NameValue(i, "STR_YMD");
                        SeqNo  = dsT_CM_AHISTORY.NameValue(i, "SEQ_NO");
                        iRow   = i;              
                    }
                    else if (dsT_CM_AHISTORY.NameValue(i, "STR_YMD") == StrYmd &&
                             dsT_CM_AHISTORY.NameValue(i, "SEQ_NO") > SeqNo) {
                        StrYmd = dsT_CM_AHISTORY.NameValue(i, "STR_YMD");
                        SeqNo  = dsT_CM_AHISTORY.NameValue(i, "SEQ_NO");
                        iRow   = i;
                    }
                }
            }

            // �������� ��� Row ������ �ű԰ǿ� ����
            if (iRow != 0) {
                // �����ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "HEAD_CD") = dsT_CM_AHISTORY.NameValue(iRow, "HEAD_CD");
                dsT_CM_AHISTORY.NameValue(Row, "HEAD_NM") = dsT_CM_AHISTORY.NameValue(iRow, "HEAD_NM");

                // �Ҽ��ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "DPT_CD") = dsT_CM_AHISTORY.NameValue(iRow, "DPT_CD");
                dsT_CM_AHISTORY.NameValue(Row, "DPT_NM") = dsT_CM_AHISTORY.NameValue(iRow, "DPT_NM");

                // ��Ʈ�ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "TEAM_CD") = dsT_CM_AHISTORY.NameValue(iRow, "TEAM_CD");
                dsT_CM_AHISTORY.NameValue(Row, "TEAM_NM") = dsT_CM_AHISTORY.NameValue(iRow, "TEAM_NM");

                // �����ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "JOB_CD") = dsT_CM_AHISTORY.NameValue(iRow, "JOB_CD");
                dsT_CM_AHISTORY.NameValue(Row, "JOB_NM") = dsT_CM_AHISTORY.NameValue(iRow, "JOB_NM");

                // ��å�ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "DUTY_CD") = dsT_CM_AHISTORY.NameValue(iRow, "DUTY_CD");
                dsT_CM_AHISTORY.NameValue(Row, "DUTY_NM") = dsT_CM_AHISTORY.NameValue(iRow, "DUTY_NM");

                // �����ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "SRV_CD") = dsT_CM_AHISTORY.NameValue(iRow, "SRV_CD");
                dsT_CM_AHISTORY.NameValue(Row, "SRV_NM") = dsT_CM_AHISTORY.NameValue(iRow, "SRV_NM");

                // �ι��ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "PART_CD") = dsT_CM_AHISTORY.NameValue(iRow, "PART_CD");
                dsT_CM_AHISTORY.NameValue(Row, "PART_NM") = dsT_CM_AHISTORY.NameValue(iRow, "PART_NM");

                // �忩��
                dsT_CM_AHISTORY.NameValue(Row, "CHIEF_YN") = dsT_CM_AHISTORY.NameValue(iRow, "CHIEF_YN");

                // �����ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "JCD_CD") = dsT_CM_AHISTORY.NameValue(iRow, "JCD_CD");
                dsT_CM_AHISTORY.NameValue(Row, "JCD_NM") = dsT_CM_AHISTORY.NameValue(iRow, "JCD_NM");

                // �ٷα����ڵ�
                dsT_CM_AHISTORY.NameValue(Row, "OCC_CD") = dsT_CM_AHISTORY.NameValue(iRow, "OCC_CD");
                dsT_CM_AHISTORY.NameValue(Row, "OCC_NM") = dsT_CM_AHISTORY.NameValue(iRow, "OCC_NM");

                // ȸ��Ҽ�
                dsT_CM_AHISTORY.NameValue(Row, "TAX_DPT")   = dsT_CM_AHISTORY.NameValue(iRow, "TAX_DPT");
                dsT_CM_AHISTORY.NameValue(Row, "TAX_DPTNM") = dsT_CM_AHISTORY.NameValue(iRow, "TAX_DPTNM");

                // ������
                dsT_CM_AHISTORY.NameValue(Row, "REMARK") = dsT_CM_AHISTORY.NameValue(iRow, "REMARK");

            }
        }

        //�߷��ڵ尡 ���Ի��� ��� �Ի��ϰ� �׷��Ի��� �������� �ִ´�.
		function fnc_GetHIR_YMD(){

			//���Ի� �ڵ��� ��츸
			if(dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition, "APP_CD") == "LC3"){

				//�����Ի��� ���� üũ(�ش����� �ֹι�ȣ�� üũ)
				dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SHR_01&ENO_NO="+form1.ENO_NO.value;
	            dsT_CM_PERSON.Reset();

				//�λ������� 1���̸� ���Ի��ڵ� ��� ����.
	            if(dsT_CM_PERSON.countrow > 1){
		            if (confirm("���� �Ի����� �ݿ��Ͻðڽ��ϱ�?") == false) return;

					//Ʈ������ ������ ���� �߰�
					dsT_CM_PERSON.UserStatus(1) = "1";
					dsT_CM_PERSON.UserStatus(2) = "1";

					trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
	                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SAV_01";
	                trT_CM_PERSON.post();

                    //parent.fnc_SearchList();
                    //������ �ٽ� ��ȸ���� �ʰ� �׳� ���� �־����.
                    parent.form1.txtHIR_YMD.value = dsT_CM_PERSON.NameValue(2, "HIR_YMD");
                    parent.form1.txtHIRG_YMD.value = dsT_CM_PERSON.NameValue(2, "HIRG_YMD");

	            }else{
	            	alert("���� �λ��������� �����ϴ�.");

	            	dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition, "APP_CD") = "";
	            	dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition, "APP_NM") = "";

					return false;
	            }

			}

		}

		//�ٷα����ڵ忡 ���� �����ڵ带 �����´�. �ٷα����ڵ尡 �ݵ�� �ʿ��ϴ�.
		function fnc_ChkJobCd(){

			var OCC_CD = dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition, "OCC_CD");
			var OCC_NM = dsT_CM_AHISTORY.NameValue(dsT_CM_AHISTORY.RowPosition, "OCC_NM");

			if(OCC_CD.trim().length == 0 || OCC_NM.trim().length == 0 ){
				alert("�ٷα����ڵ带 ���� �Է��ϼ���.");
				return false;
			}

			if(event.type == "change"){
				fnc_GetCommNm('A2', 'txtJOB_CD','txtJOB_NM','','N',OCC_CD);

			} else if(event.type == "click"){
				fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','����','A2','N',OCC_CD);

			} else if(event.type == "keyup"){
				fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','����','A2','N',OCC_CD);
			}

			return true;

		}

		//�� ���� ����Ű ó��
		function fnc_PIRA025_HotKey(CtrlKey, KeyCode) {

			//ctrl+L(�� �Է´ܺ� �ڵ� ��ȸ)
			if(CtrlKey && KeyCode == 76){

				var FocusId = event.srcElement.id;


				if(FocusId == "txtDPT_CD"){//�Ҽ�
					fnc_DptNmPopup('DEPT');

				}else if(FocusId == "txtTEAM_CD"){//��Ʈ
					fnc_DptNmPopup('TEAM');

				}else if(FocusId == "txtOCC_CD"){//�ٷα���
					fnc_commonCodePopup('txtOCC_CD','txtOCC_NM','�ٷα���','A1')

				}else if(FocusId == "txtJOB_CD"){//����
					fnc_ChkJobCd();

				}else if(FocusId == "txtHOB_CD"){//����
					fnc_commonCodePopup('txtHOB_CD','txtHOB_NM','ȣ��','A4');

				}else if(FocusId == "txtDUTY_CD"){//��å
					fnc_commonCodePopup('txtDUTY_CD','txtDUTY_NM','��å','A7');

				}else if(FocusId == "txtSRV_CD"){//����
					fnc_dutyPopup('txtSRV_CD','txtSRV_NM');

				}else if(FocusId == "txtPART_CD"){//�ι�
					fnc_commonCodePopup('txtPART_CD','txtPART_NM','�ι�','B1');

				}else if(FocusId == "txtAPP_CD"){//�߷�
					fnc_commonCodePopup('txtAPP_CD','txtAPP_NM','�߷ɱ���','J2');
					fnc_GetHIR_YMD();

				}else if(FocusId == "txtJCD_CD"){//����
					fnc_commonCodePopup('txtJCD_CD','txtJCD_NM','��������','J3');

				}else if(FocusId == "txtTAX_DPT"){//ȸ��

					fnc_commonCodePopup('txtTAX_DPT','txtTAX_DPTNM','ȸ��Ҽ�','AD');
				}

			}


		}

		//�ڵ����� �빮�ڷ� ��ȯ
        function fnc_UpperCase(obj){

            obj.value = obj.value.toUpperCase();

        }

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_AHISTORY                     |
    | 3. Table List : T_CM_AHISTORY                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                     |
    | 3. Table List : T_CM_PERSON                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_AHISTORY                       |
    | 3. Table List : T_CM_AHISTORY                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_AHISTORY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_AHISTORY)">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_AHISTORY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //�������� ��ȸ�� ó��
            if (p_mode == "read" || p_srcid == 'pirc010') {

	            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
	            fnc_ColEnabled('D');

            }else{

	            //�Ի��� ����� ������ �ݵ�� �Է��� �Ǿ�� �Ѵ�.
	            document.getElementById("resultMessage").innerText = " ";
	            fnc_AddNew();

            }

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_AHISTORY.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_AHISTORY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_AHISTORY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[��������/SEQ��ȣ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50020) {
            alert("��������/SEQ��ȣ�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_CM_PERSON Event="OnDataError()">

		cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_AHISTORY event="OnSuccess()">

        // ����ȸ
        parent.fnc_SearchList();
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <script for=trT_CM_PERSON event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_AHISTORY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_AHISTORY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_AHISTORY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onkeyup="fnc_HotKey()" onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�Ի��İ��</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInforcopy','','../../images/button/btn_InforcopyOver.gif',1)"><img src="../../images/button/btn_InforcopyOn.gif" name="imgInforcopy"    width="100" height="20" border="0" align="absmiddle" onClick="fnc_ClickBtn();"></a>
            &nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">   <img src="../../images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','../../images/button/btn_CancelOver.gif',1)"> <img src="../../images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <input type=hidden id="txtHEAD_CD">
                    <input type=hidden id="txtHEAD_NM">
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onBlur="fnc_BlurYmd();" onChange="if (fnc_CheckDate(this, '������')) {fnc_ChgBlurYmd();}" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','10','53');"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','410','53');"></a>
                    </td>
                    <!--td align="center" class="blueBold">SEQ ��ȣ</td-->
                    <input type=hidden id="txtSEQ_NO" style="width:100%;ime-mode:disabled;text-align:right;">
                    <td align="center" class="blueBold">�Ҽ��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:20%;ime-mode:inactive" maxlength="6" onChange="fnc_CommNm('DEPT');"> <input id="txtDPT_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DptNmPopup('DEPT');"></a>
                    </td>
                    <td align="center" class="blueBold">��Ʈ�ڵ�</td>
                    <td class="padding2423">
                        <input id="txtTEAM_CD" style="width:20%;ime-mode:inactive" maxlength="6" onChange="fnc_CommNm('TEAM');"> <input id="txtTEAM_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeamCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgTeamCd" name="ImgTeamCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DptNmPopup('TEAM');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�ٷα���</td>
                    <td class="padding2423">
                        <input id="txtOCC_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('A1', 'txtOCC_CD','txtOCC_NM')"> <input id="txtOCC_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgOccCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgOccCd" name="ImgOccCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtOCC_CD','txtOCC_NM','�ٷα���','A1')"></a>
                    </td>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:20%;ime-mode:inactive" maxlength="3" onChange="fnc_ChkJobCd();"> <input id="txtJOB_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_ChkJobCd();"></a>
                    </td>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtHOB_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtHOB_CD','txtHOB_NM')"> <input id="txtHOB_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHobCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHobCd" name="ImgHobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHOB_CD','txtHOB_NM','����','A4')"></a>
                    </td>
                    <td align="center" class="blueBold">��å�ڵ�</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('A7', 'txtDUTY_CD', 'txtDUTY_NM')"> <input id="txtDUTY_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDutyCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDutyCd" name="ImgDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDUTY_CD','txtDUTY_NM','��å','A7')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtSRV_CD" style="width:36%;ime-mode:inactive" maxlength="6" onChange="fnc_GetCommNm('DUTY', 'txtSRV_CD','txtSRV_NM')"> <input id="txtSRV_NM" style="width:36%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSrvCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSrvCd" name="ImgSrvCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtSRV_CD','txtSRV_NM')"></a>
                    </td>

                    <td align="center" class="blueBold">�ٹ���</td>
                    <td class="padding2423">
                        <input id="txtPART_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('B7', 'txtPART_CD','txtPART_NM')"> <input id="txtPART_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPartCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPartCd" name="ImgPartCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtPART_CD','txtPART_NM','�ٹ�������','B7')"></a>
                    </td>
                    <td align="center" class="blueBold">�߷��ڵ�</td>
                    <td class="padding2423">
                        <input type=hidden id="txtOLD_APP_CD">
                        <input id="txtAPP_CD" style="width:20%;ime-mode:inactive" maxlength="3" onChange="fnc_GetCommNm('J2', 'txtAPP_CD','txtAPP_NM');fnc_GetHIR_YMD();"> <input id="txtAPP_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgAppCd" name="ImgAppCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtAPP_CD','txtAPP_NM','�߷ɱ���','J2');fnc_GetHIR_YMD();"></a>
                    </td>

                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtJCD_CD" style="width:20%;ime-mode:inactive" maxlength="3" onChange="fnc_GetCommNm('J3', 'txtJCD_CD','txtJCD_NM')"> <input id="txtJCD_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJcdCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJcdCd" name="ImgJcdCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJCD_CD','txtJCD_NM','��������','J3')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold"><span ID="txtCHIEF_YN">��(��)����</span></td>
                    <td class="padding2423">
                        <select id="cmbCHIEF_YN" style="width:90%" >
                            <option value="N">NO</option>
                            <option value="5">Dummy����</option>
                            <option value="7">Dummy��Ʈ��</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">ȸ��Ҽ�</td>
                    <td class="padding2423">
                        <input id="txtTAX_DPT" style="width:20%;ime-mode:inactive" maxlength="4" onChange="fnc_GetCommNm('AD','txtTAX_DPT','txtTAX_DPTNM');">
                        <input id="txtTAX_DPTNM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTaxDpt','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgTaxDpt" name="ImgTaxDpt" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtTAX_DPT','txtTAX_DPTNM','ȸ��Ҽ�','AD');"></a>
                    </td>
                    <td align="center" class="blueBold">�λ�߷���</td>
                    <td class="padding2423" >
                        <input id="txtAPP_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�λ�߷���');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgAppYmd" name="ImgAppYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_YMD','','550','130');"></a>
                    </td>
                    <td align="center" class="blueBold">���</td>
                    <td class="padding2423">
                        <input id="txtREMARK" style="width:100%" maxlength="60">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_AHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:250px;">
                            <param name="DataID"                  value="dsT_CM_AHISTORY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=30   	name='����'         align=center </C>
                                <C> id=STR_YMD         width=70   	name='������'       align=center </C>
                                <C> id=SEQ_NO          width=30   	name='SEQ'          align=center show=false</C>
                                <C> id=END_YMD         width=70   	name='������'       align=center </C>
                                <C> id=APP_NM          width=80   	name='�߷�'         align=center </C>
                                <C> id=DPT_NM          width=100  	name='�Ҽ�'                      </C>
                                <C> id=TEAM_NM         width=100  	name='��Ʈ'           			 </C>
                                <C> id=JOB_NM          width=60   	name='����'    align=center  </C>
                                <C> id=DUTY_NM         width=60   	name='��å'   align=center    </C>
                                <C> id=SRV_NM          width=60  	name='����'   align=center   </C>
                                <C> id=JCD_NM          width=100   	name='����'    align=center  </C>
                                <C> id=OCC_NM          width=70   	name='�ٷα���'	    align=center </C>
                                <C> id=APP_YMD         width=70   	name='�λ�߷���'   align=center </C>
                                <C> id=REMARK          width=105  	name='���'                  </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �Ի��İ�� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_AHISTORY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=HEAD_CD       Ctrl=txtHEAD_CD      Param=value </C>
        <C> Col=HEAD_NM       Ctrl=txtHEAD_NM      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=TEAM_CD       Ctrl=txtTEAM_CD      Param=value </C>
        <C> Col=TEAM_NM       Ctrl=txtTEAM_NM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=HOB_CD        Ctrl=txtHOB_CD       Param=value </C>
        <C> Col=HOB_NM        Ctrl=txtHOB_NM       Param=value </C>
        <C> Col=DUTY_CD       Ctrl=txtDUTY_CD      Param=value </C>
        <C> Col=DUTY_NM       Ctrl=txtDUTY_NM      Param=value </C>
        <C> Col=SRV_CD        Ctrl=txtSRV_CD       Param=value </C>
        <C> Col=SRV_NM        Ctrl=txtSRV_NM       Param=value </C>
        <C> Col=PART_CD       Ctrl=txtPART_CD      Param=value </C>
        <C> Col=PART_NM       Ctrl=txtPART_NM      Param=value </C>
        <C> Col=CHIEF_YN      Ctrl=cmbCHIEF_YN     Param=value </C>
        <C> Col=APP_CD        Ctrl=txtAPP_CD       Param=value </C>
        <C> Col=OLD_APP_CD    Ctrl=txtOLD_APP_CD   Param=value </C>
        <C> Col=APP_NM        Ctrl=txtAPP_NM       Param=value </C>
        <C> Col=JCD_CD        Ctrl=txtJCD_CD       Param=value </C>
        <C> Col=JCD_NM        Ctrl=txtJCD_NM       Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=OCC_NM        Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=APP_YMD       Ctrl=txtAPP_YMD      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
        <C> Col=TAX_DPT       Ctrl=txtTAX_DPT      Param=value </C>
        <C> Col=TAX_DPTNM     Ctrl=txtTAX_DPTNM    Param=value </C>
    '>
</object>