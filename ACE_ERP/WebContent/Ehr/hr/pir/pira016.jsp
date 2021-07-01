<!--
    ************************************************************************************
    * @Source         : pira016.jsp                                                    *
    * @Description    : �з»��� PAGE                                                  *
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
<title>�з»���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
      String ENO_NO = request.getParameter("ENO_NO");            //���
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_SCHOOL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_SCHOOL.Reset();

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

                trT_CM_SCHOOL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=SAV";
                trT_CM_SCHOOL.post();

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
            if (dsT_CM_SCHOOL.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_SCHOOL.RowStatus(dsT_CM_SCHOOL.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_SCHOOL.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�з±���[" + dsT_CM_SCHOOL.NameValue(dsT_CM_SCHOOL.RowPosition,"EDGR_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            dsT_CM_SCHOOL.DeleteRow(dsT_CM_SCHOOL.RowPosition);

            if (status != 1) {

                trT_CM_SCHOOL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=DEL";
                trT_CM_SCHOOL.post();

            }

            bnd.ActiveBind = false;

            form1.grdT_CM_SCHOOL.SetColumn(form1.grdT_CM_SCHOOL.GetColumnID(0));
            form1.grdT_CM_SCHOOL.Focus();

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
            if (dsT_CM_SCHOOL.CountColumn == 0) {
                dsT_CM_SCHOOL.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, EDGR_CD:STRING:KEYVALUETYPE, EDGR_NM:STRING, GURS_YMD:STRING, GURE_YMD:STRING:KEYVALUETYPE, SCH_CD:STRING, SCH_NAM:STRING, MAJ_CD:STRING, MAJ_NM:STRING, MAJ_CD2:STRING, MAJ_NM2:STRING, GRD_CD:STRING:KEYVALUETYPE, GRD_NM:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_SCHOOL.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_SCHOOL.setColumn(form1.grdT_CM_SCHOOL.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtEDGR_CD").disabled  = false;
            document.getElementById("txtGURE_YMD").disabled = false;
            document.getElementById("txtGRD_CD").disabled   = false;
            document.getElementById("ImgEdgrCd").disabled   = false;
            document.getElementById("ImgGrdCd").disabled    = false;
            document.getElementById("txtEDGR_CD").focus();

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

   			dsT_CM_SCHOOL.ClearData();
   			
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
            if (!dsT_CM_SCHOOL.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_SCHOOL.CountRow; i++ ) {
                if ( dsT_CM_SCHOOL.RowStatus(i) == 1 ||
                     dsT_CM_SCHOOL.RowStatus(i) == 3 ) {


                    // �з±���
                    if( dsT_CM_SCHOOL.NameValue(i, "EDGR_CD") == '' ) {
                        alert("�з±����� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return false;
                    }

                    // �з±���
                    if (dsT_CM_SCHOOL.NameValue(i, "EDGR_CD") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "EDGR_NM") == "") {
                        alert("�б������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return;
                    }

                    // ������ CHECK
                    if (dsT_CM_SCHOOL.NameValue(i, "GURS_YMD").length != 4 && dsT_CM_SCHOOL.NameValue(i, "GURS_YMD").length != 0) {
                        alert("���г⵵�� ���� 4�ڸ� �Դϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGURS_YMD").focus();
                        return false;
                    }


                    if (dsT_CM_SCHOOL.NameValue(i, "GURE_YMD").length != 4) {
                    	alert("�����⵵(4�ڸ�)�� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGURE_YMD").focus();
                        return false;
                    }

					//�б����� �б������� �ƴ϶�� �ڵ尡 ���� �̸��� ������ ������ �ȴ�.
					if(document.getElementById('txtSCH_NAM').readOnly == false){
						// �з±���
	                    if( dsT_CM_SCHOOL.NameValue(i, "SCH_CD") == '' && dsT_CM_SCHOOL.NameValue(i, "SCH_NAM") == '') {
	                        alert("�б��ڵ峪 �б����� �ʼ� �Է»����Դϴ�.");
	                        dsT_CM_SCHOOL.RowPosition = i;
	                        document.getElementById("txtSCH_CD").focus();
	                        return false;
	                    }

	                    if(dsT_CM_SCHOOL.NameValue(i, "SCH_CD") != ""){
		                    if (dsT_CM_SCHOOL.NameValue(i, "SCH_CD") != "" &&
		                        dsT_CM_SCHOOL.NameValue(i, "SCH_NAM") == "") {
		                        alert("�б��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
		                        dsT_CM_SCHOOL.RowPosition = i;
		                        document.getElementById("txtSCH_CD").focus();
		                        return;
		                    }
	                    }

					}else{
						// �з±���
	                    if( dsT_CM_SCHOOL.NameValue(i, "SCH_CD") == '' ) {
	                        alert("�б��ڵ�� �ʼ� �Է»����Դϴ�.");
	                        dsT_CM_SCHOOL.RowPosition = i;
	                        document.getElementById("txtSCH_CD").focus();
	                        return false;
	                    }

	                    // �б��ڵ�
	                    if (dsT_CM_SCHOOL.NameValue(i, "SCH_CD") != "" &&
	                        dsT_CM_SCHOOL.NameValue(i, "SCH_NAM") == "") {
	                        alert("�б��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
	                        dsT_CM_SCHOOL.RowPosition = i;
	                        document.getElementById("txtSCH_CD").focus();
	                        return;
	                    }
					}

                    // �����ڵ�
                    if (dsT_CM_SCHOOL.NameValue(i, "MAJ_CD") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "MAJ_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtMAJ_CD").focus();
                        return;
                    }

                    // ���������ڵ�
                    if (dsT_CM_SCHOOL.NameValue(i, "MAJ_CD2") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "MAJ_NM2") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtMAJ_CD2").focus();
                        return;
                    }

                    // �����ڵ�
                    if (dsT_CM_SCHOOL.NameValue(i, "GRD_CD") == "") {
                        alert("�����ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGRD_CD").focus();
                        return;
                    }

                    // �����ڵ�
                    if (dsT_CM_SCHOOL.NameValue(i, "GRD_CD") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "GRD_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGRD_CD").focus();
                        return;
                    }

                    if ( dsT_CM_SCHOOL.RowStatus(i) == 1) {
                       document.getElementById("txtEDGR_CD").disabled  = true;
                       document.getElementById("txtGURE_YMD").disabled = true;
                       document.getElementById("txtGRD_CD").disabled   = true;
                       document.getElementById("ImgEdgrCd").disabled   = true;

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
            cfStyleGrid_New(form1.grdT_CM_SCHOOL, 15,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_SCHOOL.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            fnc_EdgrEnabled();

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {
                document.getElementById("txtEDGR_CD").disabled   = false;
                document.getElementById("txtGURS_YMD").disabled  = false;
                document.getElementById("txtGURE_YMD").disabled  = false;

                document.getElementById("ImgEdgrCd").disabled    = false;


            }
            else if (prop == 'D') {

                document.getElementById("txtEDGR_CD").disabled   = true;
                document.getElementById("txtGURS_YMD").disabled  = true;
                document.getElementById("txtGURE_YMD").disabled  = true;
                document.getElementById("txtSCH_CD").readonly    = true;
                document.getElementById("txtSCH_NAM").readonly   = true;
                document.getElementById("txtMAJ_CD").readonly    = true;
                document.getElementById("txtMAJ_CD2").readonly    = true;
                document.getElementById("txtGRD_CD").readonly    = true;

                document.getElementById("ImgEdgrCd").disabled    = true;
                document.getElementById("ImgSchCd").disabled     = true;
                document.getElementById("ImgMajCd").disabled     = true;


            }
        }

        function fnc_EdgrEnabled() {
            // ���Է½�
            if (document.getElementById('txtEDGR_CD').value == "") {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_NAM').className = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').readOnly  = false;
                document.getElementById('txtMAJ_CD').className  = '';
                document.getElementById('txtMAJ_CD').readOnly   = false;
                document.getElementById('txtMAJ_CD2').className  = '';
                document.getElementById('txtMAJ_CD2').readOnly   = false;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = false;
                document.getElementById("ImgMajCd2").disabled     = false;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
            // ������
            else if (document.getElementById('txtEDGR_CD').value == "0") {
                document.getElementById('txtSCH_CD').className  = 'input_ReadOnly';
                document.getElementById('txtSCH_NAM').className = 'input_ReadOnly';
                document.getElementById('txtSCH_CD').readOnly   = true;
                document.getElementById('txtSCH_NAM').readOnly  = true;
                document.getElementById('txtMAJ_CD').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD').readOnly   = true;
                document.getElementById('txtMAJ_CD2').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD2').readOnly   = true;
                document.getElementById('txtGRD_CD').className  = 'input_ReadOnly';
                document.getElementById('txtGRD_CD').readOnly   = true;

                document.getElementById("ImgSchCd").disabled     = true;
                document.getElementById("ImgMajCd").disabled     = true;
                document.getElementById("ImgMajCd2").disabled     = true;

            }
            // �ʵ��б�, ���б�
            else if (document.getElementById('txtEDGR_CD').value == "1" ||
                       document.getElementById('txtEDGR_CD').value == "2") {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_NAM').className = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').readOnly  = false;
                document.getElementById('txtMAJ_CD').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD').readOnly   = true;
                document.getElementById('txtMAJ_CD2').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD2').readOnly   = true;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = true;
                document.getElementById("ImgMajCd2").disabled     = true;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
            // ���б�
            else if (document.getElementById('txtEDGR_CD').value == "5" ||
                       document.getElementById('txtEDGR_CD').value == "6") {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').className = 'input_ReadOnly';
                document.getElementById('txtSCH_NAM').readOnly  = true;
                document.getElementById('txtMAJ_CD').className  = '';
                document.getElementById('txtMAJ_CD').readOnly   = false;
                document.getElementById('txtMAJ_CD2').className  = '';
                document.getElementById('txtMAJ_CD2').readOnly   = false;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = false;
                document.getElementById("ImgMajCd2").disabled     = false;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
            else {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').className = '';
                document.getElementById('txtSCH_NAM').readOnly  = false;
                document.getElementById('txtMAJ_CD').className  = '';
                document.getElementById('txtMAJ_CD').readOnly   = false;
                document.getElementById('txtMAJ_CD2').className  = '';
                document.getElementById('txtMAJ_CD2').readOnly   = false;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = false;
                document.getElementById("ImgMajCd2").disabled     = false;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
        }

        function fnc_EdgrCd() {
            fnc_commonCodePopup('txtEDGR_CD','txtEDGR_NM','�з±���','E1');

            document.getElementById('txtSCH_CD').value  = '';
            document.getElementById('txtSCH_NAM').value = '';
            document.getElementById('txtMAJ_CD').value  = '';
            document.getElementById('txtMAJ_NM').value  = '';
            document.getElementById('txtMAJ_CD2').value  = '';
            document.getElementById('txtMAJ_NM2').value  = '';
            document.getElementById('txtGRD_CD').value  = '';
            document.getElementById('txtGRD_NM').value  = '';

            fnc_EdgrEnabled();
        }

        function fnc_ChgEdgrCd() {

            fnc_GetCommNm('E1', 'txtEDGR_CD','txtEDGR_NM');

            document.getElementById('txtSCH_CD').value  = '';
            document.getElementById('txtSCH_NAM').value = '';
            document.getElementById('txtMAJ_CD').value  = '';
            document.getElementById('txtMAJ_NM').value  = '';
            document.getElementById('txtMAJ_CD2').value  = '';
            document.getElementById('txtMAJ_NM2').value  = '';
            document.getElementById('txtGRD_CD').value  = '';
            document.getElementById('txtGRD_NM').value  = '';

            fnc_EdgrEnabled();

        }

        function fnc_SchCd() {
            var EDGR_CD = document.getElementById("txtEDGR_CD").value;

            if (EDGR_CD == "") {
                alert("�з±����� ���� �Է��Ͽ��ֽñ� �ٶ��ϴ�.");
                document.getElementById("txtEDGR_CD").focus();
                return;
            }
            else if (EDGR_CD == "0") {
                return;
            }
            else if (EDGR_CD == "1") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','�ʵ��б�','E8');
            }
            else if (EDGR_CD == "2") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','���б�','E8');
            }
            else if (EDGR_CD == "3") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','����б�','E2');
            }
            else if (EDGR_CD == "4") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','������','E3');
            }
            else if (EDGR_CD == "5") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','���б�','E4');
            }
            else if (EDGR_CD == "6" ||
                     EDGR_CD == "7" ||
                     EDGR_CD == "8" ) {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','���п�','E5');
            }
        }

        function fnc_ChgSchCd() {
            var EDGR_CD = document.getElementById("txtEDGR_CD").value;

            if (EDGR_CD == "") {
                alert("�з±����� ���� �Է��Ͽ��ֽñ� �ٶ��ϴ�.");
                document.getElementById("txtEDGR_CD").focus();
                return;
            }
            else if (EDGR_CD == "0") {
                return;
            }
            else if (EDGR_CD == "1") {
                fnc_GetCommNm('E8', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "2") {
                fnc_GetCommNm('E8', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "3") {
                fnc_GetCommNm('E2', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "4") {
                fnc_GetCommNm('E3', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "5") {
                fnc_GetCommNm('E4', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "6" ||
                     EDGR_CD == "7" ||
                     EDGR_CD == "8" ) {
                fnc_GetCommNm('E5', 'txtSCH_CD','txtSCH_NAM');
            }
        }

        //�б��� ������ �б��ڵ� Ŭ����
        function fnc_ClsSchCd(KeyCode) {

            if(KeyCode != 0  && KeyCode != 9  && KeyCode != 13 && KeyCode != 33 && KeyCode != 34 && KeyCode != 35 && KeyCode != 36 &&
               KeyCode != 37 && KeyCode != 39 && KeyCode != 38 && KeyCode != 40 && KeyCode != 45){
                document.getElementById('txtSCH_CD').value  = '';

            }


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
    | 2. �̸� : dsT_CM_SCHOOL                       |
    | 3. Table List : T_CM_SCHOOL                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_SCHOOL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_SCHOOL                       |
    | 3. Table List : T_CM_SCHOOL                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_SCHOOL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_SCHOOL)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_SCHOOL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_SCHOOL.CountRow);

            document.getElementById("txtEDGR_CD").disabled  = true;
            document.getElementById("txtGURE_YMD").disabled = true;
            document.getElementById("txtGRD_CD").disabled   = true;
            document.getElementById("ImgEdgrCd").disabled   = true;


        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_SCHOOL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_SCHOOL Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�з±���/������/��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�з±���/�� �� ��/�������п� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_SCHOOL event="OnSuccess()">

        var old_i = 0;

        // ����ȸ(�λ�⺻2 �� ����ȸ)
        old_i = parent.old_i;
        parent.old_i = 1;
        parent.fnc_SearchList();
        parent.old_i = old_i;

        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_SCHOOL event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_SCHOOL Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_SCHOOL.SysStatus(row);

        fnc_EdgrEnabled();

        if (SysStatus == 1) {
        	
            document.getElementById("txtEDGR_CD").disabled  = false;
            document.getElementById("txtGURE_YMD").disabled = false;
            document.getElementById("txtGRD_CD").disabled   = false;
            document.getElementById("ImgEdgrCd").disabled   = false;
            document.getElementById("ImgGrdCd").disabled    = false;

        }else {
        	
            document.getElementById("txtEDGR_CD").disabled  = true;
            document.getElementById("txtGURE_YMD").disabled = true;
            document.getElementById("txtGRD_CD").disabled   = true;
            document.getElementById("ImgEdgrCd").disabled   = true;

        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�з»���</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
                    <col width="65 "></col>
                    <col width="140"></col>
                    <col width="65 "></col>
                    <col width="140"></col>
                    <col width="65 "></col>
                    <col width="120"></col>
                    <col width="65 "></col>
                    <col width="140"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�з��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" style="width:20%" maxlength="2" onChange="fnc_ChgEdgrCd();"> <input id="txtEDGR_NM" style="width:54%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEdgrCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEdgrCd" name="ImgEdgrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_EdgrCd(); "></a>
                    </td>
                    <td align="center" class="blueBold">���г⵵</td>
                    <td class="padding2423" >
                        <input id="txtGURS_YMD" style="width:78%;ime-mode:disabled" maxlength="4"  onkeypress="cfCheckNumber();">
                        <!--  //<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGursYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGursYmd" name="ImgGursYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGURS_YMD','','335','53');"></a> -->
                    </td>
                    <td align="center" class="blueBold">�����⵵</td>
                    <td class="padding2423" >
                        <input id="txtGURE_YMD" style="width:78%;ime-mode:disabled" maxlength="4"  onkeypress="cfCheckNumber();">
                        <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGureYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGureYmd" name="ImgGureYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGURE_YMD','','600','53');"></a>  -->
                    </td>
                    <td align="center" class="blueBold">�б��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtSCH_CD" style="width:20%" maxlength="3" onChange="fnc_ChgSchCd();"> <input id="txtSCH_NAM" style="width:54%" onkeydown="fnc_ClsSchCd(event.keyCode);">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSchCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSchCd" name="ImgSchCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_SchCd()"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('E6', 'txtMAJ_CD','txtMAJ_NM');"> <input id="txtMAJ_NM" style="width:54%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMajCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMajCd" name="ImgMajCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMAJ_CD','txtMAJ_NM','����','E6')"></a>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD2" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('E6', 'txtMAJ_CD2','txtMAJ_NM2');"> <input id="txtMAJ_NM2" style="width:54%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMajCd2','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMajCd2" name="ImgMajCd2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMAJ_CD2','txtMAJ_NM2','����','E6')"></a>
                    </td>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGRD_CD" style="width:25" maxlength="2" onChange="fnc_GetCommNm('E7', 'txtGRD_CD','txtGRD_NM');"> <input id="txtGRD_NM" style="width:69" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrdCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGrdCd" name="ImgGrdCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRD_CD','txtGRD_NM','��������','E7')"></a>
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
                        <object id="grdT_CM_SCHOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_SCHOOL">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='����'         align=center show=false </C>
                                <C> id=EDGR_CD         width=40   name='�ڵ�'         align=center </C>
                                <C> id=EDGR_NM         width=80   name='�з±���'                  </C>
                                <C> id=GURS_YMD        width=80   name='�� �� ��'     align=center </C>
                                <C> id=GURE_YMD        width=80   name='�� �� ��'     align=center </C>
                                <C> id=SCH_CD          width=40   name='�ڵ�'         align=center </C>
                                <C> id=SCH_NAM         width=120   name='�б�'                      </C>
                                <C> id=MAJ_CD          width=40   name='�ڵ�'         align=center </C>
                                <C> id=MAJ_NM          width=120   name='����'                      </C>
                                <C> id=MAJ_CD2         width=40   name='�ڵ�'         align=center </C>
                                <C> id=MAJ_NM2         width=120   name='��������'                  </C>
                                <C> id=GRD_CD          width=40  name='�ڵ�'         align=center </C>
                                <C> id=GRD_NM          width=120   name='��������'                  </C>
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
<!-- �з»��� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_SCHOOL">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD      Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM      Param=value </C>
        <C> Col=GURS_YMD      Ctrl=txtGURS_YMD     Param=value </C>
        <C> Col=GURE_YMD      Ctrl=txtGURE_YMD     Param=value </C>
        <C> Col=SCH_CD        Ctrl=txtSCH_CD       Param=value </C>
        <C> Col=SCH_NAM       Ctrl=txtSCH_NAM      Param=value </C>
        <C> Col=MAJ_CD        Ctrl=txtMAJ_CD       Param=value </C>
        <C> Col=MAJ_NM        Ctrl=txtMAJ_NM       Param=value </C>
        <C> Col=MAJ_CD2       Ctrl=txtMAJ_CD2      Param=value </C>
        <C> Col=MAJ_NM2       Ctrl=txtMAJ_NM2      Param=value </C>
        <C> Col=GRD_CD        Ctrl=txtGRD_CD       Param=value </C>
        <C> Col=GRD_NM        Ctrl=txtGRD_NM       Param=value </C>
    '>
</object>