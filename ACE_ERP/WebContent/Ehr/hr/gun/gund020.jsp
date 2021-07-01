<!--
*****************************************************
* @source       : gund020.jsp
* @description : �����ް���������� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�����ް����������</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����
			var pis_yy = document.form1.txtPIS_YY_SHR.value;	//�ش�⵵
			var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;	//�Ҽ�
			var eno_no = document.form1.txtENO_NO_SHR.value;	//�Ҽ�


			if(pis_yy.trim().length == 0){
				alert("�ش�⵵�� �Է��ϼ���.");
				document.getElementById("txtPIS_YY_SHR").focus();
				return false;
			}else if(pis_yy.trim().length != 4){
				alert("�ش�⵵�� �ùٸ��� �ʽ��ϴ�.");
				document.getElementById("txtPIS_YY_SHR").focus();
				return false;
			}

            trT_DI_ACCELERATE.KeyValue = "tr01(O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY, O:dsT_DI_ACCELERATE=dsT_DI_ACCELERATE, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_ACCELERATE.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund020.cmd.GUND020CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&PIS_MM="+pis_mm+"&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
            trT_DI_ACCELERATE.post();

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

			var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�

			trT_DI_ACCELERATE.KeyValue = "tr02(I:dsT_DI_ACCELERATE=dsT_DI_ACCELERATE)";
			trT_DI_ACCELERATE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund020.cmd.GUND020CMD&S_MODE=SAV&PIS_MM="+pis_mm;
			trT_DI_ACCELERATE.post();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

            form1.grdT_DI_ACCELERATE.GridToExcel("�����������", '', 225);
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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



        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_ACCELERATE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

        	window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {



			if (!dsT_DI_ACCELERATE.IsUpdated ) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

            for( i = 1; i <= dsT_DI_ACCELERATE.CountRow; i++ ) {

    			if(dsT_DI_ACCELERATE.NameValue(i, "ENO_NO") != '1990037'){

             	USE_PER = 0; //--
             	
	            var REM_CNT = 0; //-- �ܿ�
	            var YRP_CNT = dsT_DI_ACCELERATE.NameValue(i, "YRP_CNT"); //-- �ѿ���
				var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�


				REM_CNT = dsT_DI_ACCELERATE.NameValue(i, "YRP_REM")-(dsT_DI_ACCELERATE.NameValue(i, "ATT_OCT") + dsT_DI_ACCELERATE.NameValue(i, "ATT_NOV") + dsT_DI_ACCELERATE.NameValue(i, "ATT_DEC"));

				if(YRP_CNT != 0){
					USE_PER =  ( YRP_CNT - REM_CNT) / YRP_CNT;
				}else{
					USE_PER = 100;
				}

				if (pis_mm == "010203"  && USE_PER < 0.20 ){
					alert(dsT_DI_ACCELERATE.NameValue(i, "ENO_NM") + "���� 1/4 �б� ������  : "+parseInt(USE_PER*100)+"%  �����Դϴ�\n\n 1/4 �б� ��� ��ǥ 20% �̻� ��û�ϼž� ���� �� �� �ֽ��ϴ�. \n\n �۾��� ��ҵǾ����ϴ�. ");
					fnc_SearchList();
					return false;
				}else if (pis_mm == "040506"  && USE_PER < 0.40 ){
					alert(dsT_DI_ACCELERATE.NameValue(i, "ENO_NM") + "���� 2/4 �б� ������  : "+parseInt(USE_PER*100)+"%  �Դϴ�\n\n 2/4 �б� ��� ��ǥ 40% �̻� ��û�ϼž� ���� �� �� �ֽ��ϴ�. \n\n �۾��� ��ҵǾ����ϴ�. ");
					fnc_SearchList();
					return false;
				}else if (pis_mm == "070809"  && USE_PER < 0.80 ){
					alert(dsT_DI_ACCELERATE.NameValue(i, "ENO_NM") + "���� 3/4 �б� ������  : "+parseInt(USE_PER*100)+"%  �Դϴ�\n\n 3/4 �б� ��� ��ǥ 80% �̻� ��û�ϼž� ���� �� �� �ֽ��ϴ�. \n\n �۾��� ��ҵǾ����ϴ�. ");
					fnc_SearchList();
					return false;
				}else if (pis_mm == "101112"  && USE_PER < 1 ){
					alert(dsT_DI_ACCELERATE.NameValue(i, "ENO_NM") + "���� 4/4 �б� ������  : "+parseInt(USE_PER*100)+"%  �Դϴ�\n\n �ܿ� �ް��� ���� ��û�ٶ��ϴ�.. \n\n �۾��� ��ҵǾ����ϴ�. ");
					fnc_SearchList();
					return false;
				}

    			}

			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	
			var todayMM = getToday().substring(5, 7);
			
			var todayDD = getToday().substring(8);
			
			var key_man = '<%=box.get("SESSION_ENONO")%>';
			var gbn_cd = '<%=box.get("SESSION_GBN_CD")%>';
			var team_cd = '<%=box.get("SESSION_TEAMCD")%>';

	        dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// ���³�¥
	                            "GUN_GBN:STRING(1),"+			// ���°��籸��
								"DPT_CD:STRING(6),"+			// ���ºμ�
								"DPT_NM:STRING(10),"+			// ���ºμ���
								"SEQ_NO:STRING(1),"+			// ���缱
								"ENO_NO:STRING(10),"+			// �����ڻ��
								"JOB_CD:STRING(10),"+			// ����������
								"APP_TIME:STRING(10),"+			// ����ð�
								"PENO_NO:STRING(10),"+			// ����ڻ��
								"APP_YN:STRING(10),"+			// ���翩��
								"ENO_NM:STRING(10),"+			// �����ڸ�
								"JOB_NM:STRING(10),"+			// ������
								"REQ_NO:STRING(20)"				// ������
								);
			cfStyleGrid(form1.grdT_DI_ACCELERATE,15,"true","false")      // Grid Style ����
			
			form1.grdT_DI_ACCELERATE.SelectionColorProp("FocusEditRow", "BgColor") = "";
			form1.grdT_DI_ACCELERATE.SelectionColorProp("EditRow", "BgColor") = "";


            form1.grdT_DI_ACCELERATE.SelectionColorProp("FocusEditRow", "TextColor") = "#000000";
            form1.grdT_DI_ACCELERATE.SelectionColorProp("FocusCurRow", "TextColor") = "#000000";
            form1.grdT_DI_ACCELERATE.SelectionColorProp("EditRow", "TextColor") = "#000000";
            form1.grdT_DI_ACCELERATE.SelectionColorProp("CurRow", "TextColor") = "#000000";

   	        var oYear = getToday().substring(0,4);

   	        document.getElementById("txtPIS_YY_SHR").value = oYear;
			document.form1.txtPIS_YY_SHR.focus();


            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";

            document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.getString("SESSION_ENONM") %>";


		        if(todayMM == "01" || todayMM == "02" || todayMM == "03" ) {
		             document.form1.cmbPIS_MM_SHR.value = "010203";
		        }else if(todayMM == "04" || todayMM == "05" || todayMM == "06" ) {
		             document.form1.cmbPIS_MM_SHR.value = "040506";
		        }else if(todayMM == "07" || todayMM == "08" || todayMM == "09" ) {
		             document.form1.cmbPIS_MM_SHR.value = "070809";
		        }else if(todayMM == "10" || todayMM == "11" || todayMM == "12" ) {
		             document.form1.cmbPIS_MM_SHR.value = "101112";
		        }

		        var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�

				form1.grdT_DI_ACCELERATE.ColumnProp('MM_OCT', 'Name') = pis_mm.substr(0,2) +"��";
				form1.grdT_DI_ACCELERATE.ColumnProp('MM_NOV', 'Name') = pis_mm.substr(2,2) +"��";
				form1.grdT_DI_ACCELERATE.ColumnProp('MM_DEC', 'Name') = pis_mm.substr(4,2) +"��";




<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M") && (box.getString("SESSION_ENONO").equals("6060002") || box.getString("SESSION_ENONO").equals("2180001")|| box.getString("SESSION_ENONO").equals("6080002"))) {
%>
			 document.getElementById("approval_btn").style.display = "";
			 document.getElementById("append_btn").style.display = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

<%//A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A") && (box.getString("SESSION_ENONO").equals("3100006") || box.getString("SESSION_ENONO").equals("2050004") || box.getString("SESSION_ENONO").equals("2060009"))) {
%>


			document.getElementById("approval_btn").style.display = "";
			document.getElementById("append_btn").style.display = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";




<%//A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>

			document.getElementById("approval_btn").style.display = "";
			document.getElementById("append_btn").style.display = "";
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";



<%
    }else{
%>
		//	fnc_ChangeStateElement(false, "cmbPIS_MM_SHR");     �Ϲݻ����  �Ұ�  ��ġ  ���� Test ��...
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

			fnc_ChangeStateElement(false, "txtENO_NO_SHR");
			fnc_ChangeStateElement(false, "txtENO_NM_SHR");
			fnc_ChangeStateElement(false, "ImgEnoNoSHR");

            fnc_HiddenElement("approval_btn");
			fnc_HiddenElement("append_btn");

			 //document.getElementById("approval_btn").style.display = "none";
			 //document.getElementById("append_btn").style.display = "none";
<%
	}
%>
			fnc_SearchList();
			fnc_OnLoadApproval();

        }

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNmSHR() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


		//�Է¿Ϸ�
		function fnc_Inputcomplete() {
		}
        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			if(dsT_DI_ACCELERATE.CountRow < 1){
				alert("���������������� ���� ��ȸ�Ͻʽÿ�.");
				return;
			}

            //ds�� ���Ϲ޴´�.
            //fnc_GetApproverDS(dsT_DI_APPROVAL);
			var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�


			var STR_YMD_SHR = document.getElementById("txtPIS_YY_SHR").value + pis_mm.substr(0,2) + "01";
			var END_YMD_SHR = document.getElementById("txtPIS_YY_SHR").value+"-12-31";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
			var EMP_NO      = "<%=box.getString("SESSION_ENONO") %>";

			dsT_DI_APPROVAL.ClearData();
			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"A");

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();


            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = STR_YMD_SHR;   //dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// �����Ϻ� ���¿��� ������ ���� �ʰ� �ϱ����ؼ�...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "A";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("hidREQ_NO").value;

            }
        }
        function fnc_OnLoadApproval() {

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_DI_APPROVAL,15,"false","false")      // Grid Style ����
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight   = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }
        function fnc_Report() {
			if(confirm("����Ͻðڽ��ϱ�? �����ް������� �����Ͻ��Ŀ��� ����� �ݿ��˴ϴ�")){
			var pis_yy = document.form1.txtPIS_YY_SHR.value;	//�ش�⵵
			var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�
				var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
				if(dsT_DI_ACCELERATE.CountRow == 0){
					alert("����� �����͸� ���� ��ȸ�Ͻʽÿ�");
					return;
				}
				if(dsT_DI_APPROVAL.CountRow == 0){
					alert("���缱�� ���� �Ͻʽÿ�");
					return;
				}

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund020.cmd.GUND020CMD&S_MODE=REP&PIS_YY="+pis_yy+"&PIS_MM="+pis_mm+"&DPT_CD="+DPT_CD;
				trT_DI_APPROVAL.post();
			}
        }


        function fnc_Poschange(Row,Colid) {//Colid �̻��

            var f = document.form1;
            f.row_num.value = Row;//���� row;


                f.H_val_fix.value = "";
                f.P_val_fix.value = "";
                f.R_val_fix.value = "";

            var IndexColCnt = dsT_DI_ACCELERATE.CountColumn;       //Į�� �� ����
            var Dm_ColCnt   = IndexColCnt-8;       // ������ ����Ÿ�¿��� �׸���� ���� ����κ��� ������ �����κ�(��¥) ������ ����

            var H_count = 0;  //����Ÿ�¿� ���� ���� �� �ް� ������ ����
            var P_count = 0;
            var R_count = 0;


            for ( var i = 7; i <= Dm_ColCnt + 8; i++ )
            {
                if ( dsT_DI_ACCELERATE.NameValue(Row,dsT_DI_ACCELERATE.ColumnID(i)) == "H" )
                    H_count = H_count + 1;
                else if ( dsT_DI_ACCELERATE.NameValue(Row,dsT_DI_ACCELERATE.ColumnID(i)) == "P" )
                    P_count = P_count + 1;
                else if ( dsT_DI_ACCELERATE.NameValue(Row,dsT_DI_ACCELERATE.ColumnID(i)) == "R" )
                    R_count = R_count + 1;
            }

            f.H_val.value = Number(H_count);
            f.P_val.value = Number(P_count);
            f.R_val.value = Number(R_count);



        }

		function fnc_commnmPopup_gund020(ctrl_01,ctrl_02,ctrl_03,ctrl_04){

			var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
			obj.title = ctrl_03;
			obj.gbn = ctrl_04;

			window.showModalDialog("/common/popup/codenm_gund020.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");


			if(obj.comm_cd != '' && obj.comm_nm != ''){
				document.getElementById(ctrl_01).value = obj.comm_cd;
				document.getElementById(ctrl_02).value = obj.comm_nm;
			}


		}


    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_HOLIDAY) |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAY)          |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_ACCELERATE) |
    | 3. ���Ǵ� Table List(T_DI_ACCELERATE)          |
    +-------------------------------------------------->
    <Object ID="dsT_DI_ACCELERATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                           |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_ACCELERATE_CR) |
    | 3. ���Ǵ� Table List(T_DI_ACCELERATE)             |
    +----------------------------------------------------->
    <Object ID="dsT_DI_ACCELERATE_CR" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_APPROVAL)			 	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_ACCELERATE)	|
    | 3. ���Ǵ� Table List(T_DI_ACCELERATE)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_ACCELERATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

	<!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_APPROVAL)		|
    | 3. ���Ǵ� Table List(T_DI_APPROVAL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_APPROVAL=T_DI_APPROVAL)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_ACCELERATE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();
			dsT_CM_PERSON.DataId="/servlet/GauceChannelSVL?cmd=hr.gun.d.gund020.cmd.GUND020CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
			dsT_CM_PERSON.Reset();

        } else {

            // �������  EDIT �Ұ�
          for(var i = 1; i <= dsT_DI_ACCELERATE.CountRow; i++){
            if (dsT_DI_ACCELERATE.NameValue(i, "END_TAG") == "R") {
                document.getElementById("resultMessage").innerText = '** ������� ���� �۾���  �Ұ��մϴ�. **';
		   			for(i=1;i<=dsT_DI_ACCELERATE.CountColumn;i++){
		                 	grdT_DI_ACCELERATE.ColumnProp(dsT_DI_ACCELERATE.ColumnID(i), 'edit') = "none";
		            }
	           break;
			}
		  }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_ACCELERATE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_ACCELERATE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">

		var pis_yy = document.form1.txtPIS_YY_SHR.value;	//�ش�⵵
		var pis_mm = document.form1.cmbPIS_MM_SHR.value;	//�ش�б�
		var lday = 31;

        //���� ����(�����, �Ͽ���) RESET
		for(i=1;i<=31;i++){
             grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_OCT", 'HeadBgColor') = "#F7DCBB";
             grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_NOV", 'HeadBgColor') = "#F7DCBB";
             grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_DEC", 'HeadBgColor') = "#F7DCBB";
        }

		grdT_DI_ACCELERATE.ColumnProp('MM_OCT', 'Name') = pis_mm.substr(0,2) +"��";
		grdT_DI_ACCELERATE.ColumnProp('MM_NOV', 'Name') = pis_mm.substr(2,2) +"��";
		grdT_DI_ACCELERATE.ColumnProp('MM_DEC', 'Name') = pis_mm.substr(4,2) +"��";

            //���� ����(�����, �Ͽ���) RESET
			for(i=1;i<=dsT_DI_ACCELERATE.CountColumn;i++){
			  if (dsT_DI_ACCELERATE.ColumnID(i) > "AT1" && dsT_DI_ACCELERATE.ColumnID(i) <= "AT9") {
                 grdT_DI_ACCELERATE.ColumnProp(dsT_DI_ACCELERATE.ColumnID(i)+"_V", 'HeadBgColor') = "#F7DCBB";
               	 grdT_DI_ACCELERATE.ColumnProp(dsT_DI_ACCELERATE.ColumnID(i), 'edit') = "Any";
              }
            }

        if (iCount < 1)    {

        } else {
            //���� ����(�����, �Ͽ���)
			for(i=1;i<=iCount;i++){
                grdT_DI_ACCELERATE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM"), 'HeadBgColor') = "#F47380";
            //    grdT_DI_ACCELERATE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM")+"_V", 'HeadBgColor') = "#F47380";
                grdT_DI_ACCELERATE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM"), 'edit') = "none";
            }

        }
		//LAST Day ���� �Ұ� - 1st
        lday = fnc_Lastday(pis_yy,pis_mm.substr(0,2)) ;
			for(i=lday+1;i<=31;i++){
                grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_OCT_V", 'HeadBgColor') = "#F47380";
                grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_OCT", 'edit') = "none";
            }
		//LAST Day ���� �Ұ� - 2nd
        lday = fnc_Lastday(pis_yy,pis_mm.substr(2,2)) ;
			for(i=lday+1;i<=31;i++){
                grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_NOV_V", 'HeadBgColor') = "#F47380";
                grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_NOV", 'edit') = "none";
            }
		//LAST Day ���� �Ұ� -3th
        lday = fnc_Lastday(pis_yy,pis_mm.substr(4,2)) ;
			for(i=lday+1;i<=31;i++){
                grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_DEC_V", 'HeadBgColor') = "#F47380";
                grdT_DI_ACCELERATE.ColumnProp("AT"+i+"_DEC", 'edit') = "none";
            }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_ACCELERATE_CR Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

            document.getElementById("resultMessage").innerText = "* "+document.getElementById("txtPIS_YY").value+"�⵵ �����Ͱ� �����Ǿ����ϴ�.";

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_ACCELERATE_CR Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        document.getElementById("resultMessage").innerText = "* "+document.getElementById("txtPIS_YY").value+"�⵵ �����Ͱ� �̹� �����մϴ�.";

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 1)    {
			document.getElementById("txtDPT_CD_SHR").value = dsT_CM_PERSON.NameValue(1, "GUN_DPT");
			alert("��ȸ ��ư�� �ٽ� �ѹ� Click�Ͽ� �ֽʽÿ�");
        }

    </Script>
	<script language=JavaScript for=dsT_CM_PERSON event=onLoadError()>
		alert("onLoadError");
	</script>
    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_ACCELERATE event="OnSuccess()">
        if(trT_DI_ACCELERATE.KeyValue.substring(0,4) == "tr02"){
            fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
            fnc_SearchList();
        }
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_ACCELERATE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("����� �Ϸ�Ǿ����ϴ�.");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>
    <!--------------------------------------------+
    | Grid�� DblClick������ �߻��ϴ� �̺�Ʈ ó��  |
    +--------------------------------------------->

    <script language="javascript"  for=grdT_DI_ACCELERATE event=OnColumnPosChanged(Row,Colid)>

         fnc_Poschange(Row,Colid);


    </script>


    <script language=JavaScript for=grdT_DI_ACCELERATE event=OnClick(row,colid)>

    return;

        if (colid.substring(0,2) == "AT")  {
            //��밡���� ������ ���� ���

                if(dsT_DI_ACCELERATE.NameValue(row, "YRP_REM") <= (dsT_DI_ACCELERATE.NameValue(row, "ATT_OCT")+dsT_DI_ACCELERATE.NameValue(row, "ATT_NOV")+dsT_DI_ACCELERATE.NameValue(row, "ATT_DEC"))){
                    alert("��밡���� �̻�� ������ �����ϴ�.");
                    //return;
                }
        }





/*         var colid_1 = '';
        var colid_s = colid.split("_");
		var vCNT = dsT_DI_ACCELERATE.NameValue(row, "YRP_REM") - (dsT_DI_ACCELERATE.NameValue(row, "ATT_OCT")+dsT_DI_ACCELERATE.NameValue(row, "ATT_NOV")+dsT_DI_ACCELERATE.NameValue(row, "ATT_DEC"));
        // �������� chekbox�� ����Ŭ���Ͽ� �ش� ���� �ݿ�
        if (colid.substring(0,2) == "AT")  {
            //��밡���� ������ ���� ���
            if(dsT_DI_ACCELERATE.NameValue(row, colid.replace("_V","")) == ""){
                if(dsT_DI_ACCELERATE.NameValue(row, "YRP_REM") <= (dsT_DI_ACCELERATE.NameValue(row, "ATT_OCT")+dsT_DI_ACCELERATE.NameValue(row, "ATT_NOV")+dsT_DI_ACCELERATE.NameValue(row, "ATT_DEC"))){
                    alert("��밡���� �̻�� ������ �����ϴ�.");
                    return;
                }
            }

            colid_1 = colid.replace("_V","");

            //if(form1.grdT_DI_ACCELERATE.ColumnProp(colid_1, 'edit') == 'NONE'){
            //    return;
            //}

            if (dsT_DI_ACCELERATE.NameValue(row, colid_1) == 'H') {
                dsT_DI_ACCELERATE.NameValue(row, colid_1) = '';
                //�����հ����
                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])-1;
            }else if (dsT_DI_ACCELERATE.NameValue(row, colid_1) == 'P') {
                dsT_DI_ACCELERATE.NameValue(row, colid_1) = '';
                //�����հ����
                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])-0.5;
            }
            else {
				if (vCNT == 0.5) {
	                dsT_DI_ACCELERATE.NameValue(row, colid_1) = 'P';
	                //�����հ����
	                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])+0.5;
				}
	            else {
					dsT_DI_ACCELERATE.NameValue(row, colid_1) = 'H';
	                //�����հ����
	                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])+1;
				}
            }
        } */

    </script>

    <script language="javascript"  for=grdT_DI_ACCELERATE event=onKeyPress(keycode)>


   return;

        var form        = document.form1;
        var row_num     = form.row_num.value;

        var col_id      = grdT_DI_ACCELERATE.GetColumn();//���� ������ �÷�
        form.col_id.value = col_id;

        var temp_val = dsT_DI_ACCELERATE.NameValue(row_num,col_id);

        var NYRP_CNT_TOT = Number(form.H_val.value) + (Number(form.P_val.value)*0.5)  + (Number(form.R_val.value)*0.5)  ;



        //�Է¿Ϸ� �����Ұ�(�����ڴ� ����)
        if ( dsT_DI_ACCELERATE.NameValue(row_num,"END_TAG") != "Y"
                || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {

            if ( col_id != "JOB_NM" && col_id != "ENO_NO" && col_id != "ENO_NM" && col_id != "YRP_CNT" && col_id != "YRP_REM" && col_id != "REM_CNT" )
            {
                //��밡���� Ű�ڵ�
                //(             H,               P,               R)
                if (keycode == 72 || keycode == 80 || keycode == 82) {
                    //alert(dsT_DI_ACCELERATE.NameValue(row_num,"YRP_REM") +",  "+ NYRP_CNT_TOT);

                    //����(H)
                    if ( keycode == "72" ) {
                        if ( dsT_DI_ACCELERATE.NameValue(row_num,"YRP_REM") < NYRP_CNT_TOT+1 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "H";
                        }
                    //����������(P)
                    } else if ( keycode == "80" ) {
                        if ( dsT_DI_ACCELERATE.NameValue(row_num,"YRP_REM") < NYRP_CNT_TOT+0.5 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "P";
                        }

                    //���Ŀ�����(R)
                    } else if ( keycode == "82" ) {
                        if ( dsT_DI_ACCELERATE.NameValue(row_num,"YRP_REM") < NYRP_CNT_TOT+0.5 ) {
                            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
                            form.pre_data.value = temp_val;//������ ����
                            return;
                        } else {
                            form.pre_data.value = "R";
                        }

                    }

                } else {
                     form.pre_data.value = "";
                     dsT_DI_ACCELERATE.NameValue(row_num,col_id) = "";
                }
            }

        } else {
            alert("�����Է¿Ϸ�� �����Դϴ�. ���� �Ұ����մϴ�.");

            form.pre_data.value = temp_val;//������ ����
        }

    </script>

    <script language="javascript"  for=grdT_DI_ACCELERATE event=OnExit(Row,Colid,olddata)>

//alert(Row+" ,  "+Colid+" ,  "+olddata)
		// ��ȿ Ű�� Ȯ��
        if ( dsT_DI_ACCELERATE.NameValue(Row,Colid) != "H" && dsT_DI_ACCELERATE.NameValue(Row,Colid) != "P" && dsT_DI_ACCELERATE.NameValue(Row,Colid) != "R" && dsT_DI_ACCELERATE.NameValue(Row,Colid) != null  && dsT_DI_ACCELERATE.NameValue(Row,Colid) != ""){
            dsT_DI_ACCELERATE.NameValue(Row,Colid) = olddata;
            return;
        }

  		var use_cnt =  dsT_DI_ACCELERATE.NameValue(Row,"ATT_OCT") + dsT_DI_ACCELERATE.NameValue(Row,"ATT_NOV") + dsT_DI_ACCELERATE.NameValue(Row,"ATT_DEC") ;

		if ( dsT_DI_ACCELERATE.NameValue(Row,Colid) == "H" ) use_cnt = use_cnt + 1;
		if ( dsT_DI_ACCELERATE.NameValue(Row,Colid) == "P" || dsT_DI_ACCELERATE.NameValue(Row,Colid) == "R" ) use_cnt = use_cnt + 0.5;

        if ( dsT_DI_ACCELERATE.NameValue(Row,"YRP_REM") < use_cnt ){
            dsT_DI_ACCELERATE.NameValue(Row,Colid) = olddata;
            alert("���̻� ������ ����Ͻ� �� �����ϴ�.");
            return;
        }

				dsT_DI_ACCELERATE.NameValue(Row, "ATT_OCT") = 0;
				dsT_DI_ACCELERATE.NameValue(Row, "ATT_NOV") = 0;
				dsT_DI_ACCELERATE.NameValue(Row, "ATT_DEC") = 0;

		          for ( var i = 9; i <= 39; i++ ) {
		                if ( dsT_DI_ACCELERATE.ColumnValue(Row,i) == "H" )
		                     dsT_DI_ACCELERATE.NameValue(Row, "ATT_OCT") = dsT_DI_ACCELERATE.NameValue(Row, "ATT_OCT") + 1;
		                else if ( dsT_DI_ACCELERATE.ColumnValue(Row,i) == "P" || dsT_DI_ACCELERATE.ColumnValue(Row,i) == "R")
		                     dsT_DI_ACCELERATE.NameValue(Row, "ATT_OCT") = dsT_DI_ACCELERATE.NameValue(Row, "ATT_OCT") + 0.5;
		          }

		          for ( var i = 40; i <= 69; i++ ) {
		                if ( dsT_DI_ACCELERATE.ColumnValue(Row,i) == "H" )
		                     dsT_DI_ACCELERATE.NameValue(Row, "ATT_NOV") = dsT_DI_ACCELERATE.NameValue(Row, "ATT_NOV") + 1;
		                else if ( dsT_DI_ACCELERATE.ColumnValue(Row,i) == "P" || dsT_DI_ACCELERATE.ColumnValue(Row,i) == "R")
		                     dsT_DI_ACCELERATE.NameValue(Row, "ATT_NOV") = dsT_DI_ACCELERATE.NameValue(Row, "ATT_NOV") + 0.5;
		          }

		          for ( var i = 70; i <= 105; i++ ) {
		                if ( dsT_DI_ACCELERATE.ColumnValue(Row,i) == "H" )
		                     dsT_DI_ACCELERATE.NameValue(Row, "ATT_DEC") = dsT_DI_ACCELERATE.NameValue(Row, "ATT_DEC") + 1;
		                else if ( dsT_DI_ACCELERATE.ColumnValue(Row,i) == "P" || dsT_DI_ACCELERATE.ColumnValue(Row,i) == "R")
		                     dsT_DI_ACCELERATE.NameValue(Row, "ATT_DEC") = dsT_DI_ACCELERATE.NameValue(Row, "ATT_DEC") + 0.5;
		          }


    </script>



    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {
			document.getElementById("hidREQ_NO").value = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
        }else{
			document.getElementById("hidREQ_NO").value = "";
		}
		var APP_YN = "";

		for(var i = 1; i <= dsT_DI_APPROVAL.CountRow; i++){
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="Y"){
                APP_YN = "Y";
            }
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="N"){
                APP_YN = "N";
				break;
            }
		}

		if(APP_YN=="Y"){
			document.getElementById("save_btn").style.display = "none";		// �����ư
			document.getElementById("append_btn").style.display = "none";	// ��Ź�ư
			document.getElementById("btn_InsDel").style.display = "none";	// ���缱��ư
			document.getElementById("resultMessage").innerText = '���� �Ϸ�Ǿ����ϴ�. ���� �۾� �Ұ��մϴ�.';
            // ����Ϸ�� EDIT �Ұ�
   			for(i=1;i<=dsT_DI_ACCELERATE.CountColumn;i++){
                 	grdT_DI_ACCELERATE.ColumnProp(dsT_DI_ACCELERATE.ColumnID(i), 'edit') = "none";
            }
			grdT_DI_ACCELERATE.ColumnProp("REM_CNT", 'show') = "false";
			grdT_DI_ACCELERATE.ColumnProp("USE_PER", 'show') = "false";
		}else if(APP_YN=="N"){
<% //A �� �ڱ�μ��� ����
			if(box.getString("SESSION_DIL_AUTHO").equals("A") || box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			document.getElementById("resultMessage").innerText = '�ΰ� ���� ��ġ �� ���缱�� ������ ��  ��� �����մϴ�.';
<%
	}
%>
			document.getElementById("save_btn").style.display = "";
			grdT_DI_ACCELERATE.ColumnProp("REM_CNT", 'show') = "false";
			grdT_DI_ACCELERATE.ColumnProp("USE_PER", 'show') = "false";
		}else{

			document.getElementById("approval_btn").style.display = "";
			document.getElementById("append_btn").style.display = "";
			document.getElementById("save_btn").style.display = "";
			document.getElementById("btn_InsDel").style.display = "";	// ���缱��ư
			grdT_DI_ACCELERATE.ColumnProp("REM_CNT", 'show') = "false";
			grdT_DI_ACCELERATE.ColumnProp("USE_PER", 'show') = "false";
			document.getElementById("resultMessage").innerText = ' ';
		}
    </Script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ��Է�" ){

		window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
  </script>
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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<input type="hidden" id="hidREQ_NO">
<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ް����������</td>
					<td align="right" class="navigator">HOME/���°���/��������/<font color="#000000">�����ް����������</font></td>
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
	<span id="append_btn" style="display:none">
	  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRep','','/images/button/btn_ReportOver.gif',1)">  <img src="/images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Report()"></a>
	</span>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	<span id="save_btn" style="display:none">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	</span>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>

            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="70"></col>
                                <col width="80"></col>
                                <col width="60"></col>
                                <col width="80"></col>
                                <col width="60"></col>
                                <col width="170"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                <td class="padding2423">
									<input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','60','115');"></a>
								</td>
                    <td align="center" class="searchState">�ش�б�</td>
                    <td class="padding2423">
                        <select id=cmbPIS_MM_SHR  style="width:72">
                            <option value="010203">1/4�б�</option>
                            <option value="040506">2/4�б�</option>
                            <option value="070809">3/4�б�</option>
                            <option value="101112">4/4�б�</option>
                        </select>
                                <td align="right" class="searchState">�Ҽ�&nbsp;</td>
                                <td class="padding2423">
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="4" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
										<img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','HUGA')">
									</a>
                                </td>

								<td class="searchState" align="right">���</td>
								<td class="padding2423" align="left">
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
									<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
								</td>

			 					<!-- <td class="searchState" align="right"></td>
								<td class="padding2423" align="left">
									<input id="txtGBN_CD" name="txtGBN_CD" size="7" maxlength= "7" show="false">
									<input id="txtTEAM_CD" name="txtTEAM_CD" size="7" maxlength= "7"  class="input_ReadOnly" readonly>
								</td> -->

                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<div id="approval_btn" style="display:none">
	<!-- ���缱 ���̺� ���� -->
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:112px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'		width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
	            					<C> id='SEQ_NO'		width=40	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'		width=96	name='�μ�'		align=center	</C>
									<C> id='JOB_NM'		width=96	name='����'		align=center	</C>
									<C> id='ENO_NO'		width=100	name='���'		align=center	show=false</C>
									<C> id='ENO_NM'		width=100	name='����'		align=center	</C>
									<C> id='APP_YN'		width=100	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')} </C>
									<C> id='REMARK1'	width=87	name='����'		align=center 	Color='Blue'	edit=none</C>
									<C> id='REMARK'		width=60	name='����'		align=center	show=false</C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>

			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td align="right">
	                        <span id="btn_InsDel">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>

	                        </span>
			            </td>
					</tr>
				</table>
			</td>


		</tr>
	</table>
</div>


<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="66%"><span id="resultMessage">&nbsp;</span></td>
					<!--
                    <td align="right" width="">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInputcomplete','','/images/button/btn_InputcompleteOver.gif',1)">    <img src="/images/button/btn_InputcompleteOn.gif"   name="imgInputcomplete"   width="80" height="20" border="0" align="absmiddle" onClick="fnc_Inputcomplete()"></a>
                    </td>
					-->
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_ACCELERATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"						value="dsT_DI_ACCELERATE">
							<param name="EdiTABLE"					value="true">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=34			name='NO'				align=center			value={String(Currow)}		</FC>
								<FC> id='DPT_NM'			width=80			name='�Ҽ�'				align=center			Edit=None					</FC>
								<FC> id='JOB_NM'				width=50			name='����'				align=center			Edit=None					</FC>
								<FC> id='ENO_NO'			width=60			name='���'				align=center			Edit=None	show=false	</FC>
								<FC> id='ENO_NM'			width=60			name='����'				align=center			Edit=None					</FC>
                                <FC> id='YRP_CNT'			width=50			name='�� ����'  		align=center			Edit=None	DECAO=1	</FC>
                                <FC> id='YRP_REM'			width=50			name='�̻��;����'	align=center			Edit=None	DECAO=1	</FC>
                                <FC> id='REM_CNT'		    width=40			name='�ܿ�'	        	align=center			Edit=None	DECAO=1  show=false Value={ (YRP_REM-(ATT_OCT+ATT_NOV+ATT_DEC))}</FC>
                                <FC> id='USE_PER'			width=50			name='����;����'  	align=center			Edit=None	DECAO=0	Value={ (YRP_CNT - YRP_REM+(ATT_OCT+ATT_NOV+ATT_DEC))/YRP_CNT*100}	show=false	</FC>
                                <G> id='MM_OCT' name='1��'  HeadBgColor='#F7DCBB'
                                    <C> id='AT1_OCT'		width=20		name='1'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT1_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT2_OCT'		width=20		name='2'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT2_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT3_OCT'		width=20		name='3'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT3_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT4_OCT'		width=20		name='4'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT4_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT5_OCT'		width=20		name='5'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT5_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT6_OCT'		width=20		name='6'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT6_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT7_OCT'		width=20		name='7'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT7_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT8_OCT'		width=20		name='8'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT8_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT9_OCT'		width=20		name='9'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT9_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT10_OCT'		width=20		name='10'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT10_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT11_OCT'		width=20		name='11'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT11_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT12_OCT'		width=20		name='12'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT12_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT13_OCT'		width=20		name='13'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT13_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT14_OCT'		width=20		name='14'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT14_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT15_OCT'		width=20		name='15'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT15_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT16_OCT'		width=20		name='16'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT16_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT17_OCT'		width=20		name='17'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT17_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT18_OCT'		width=20		name='18'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT18_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT19_OCT'		width=20		name='19'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT19_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT20_OCT'		width=20		name='20'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT20_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT21_OCT'		width=20		name='21'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT21_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT22_OCT'		width=20		name='22'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT22_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT23_OCT'		width=20		name='23'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT23_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT24_OCT'		width=20		name='24'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT24_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT25_OCT'		width=20		name='25'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT25_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT26_OCT'		width=20		name='26'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT26_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT27_OCT'		width=20		name='27'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT27_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT28_OCT'		width=20		name='28'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT28_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT29_OCT'		width=20		name='29'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT29_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT30_OCT'		width=20		name='30'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT30_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT31_OCT'		width=20		name='31'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT31_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
								</G>
                                <G> id='MM_NOV' name='2��'  HeadBgColor='#F7DCBB'
                                    <C> id='AT1_NOV'		width=20		name='1'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT1_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT2_NOV'		width=20		name='2'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT2_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT3_NOV'		width=20		name='3'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT3_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT4_NOV'		width=20		name='4'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT4_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT5_NOV'		width=20		name='5'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT5_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT6_NOV'		width=20		name='6'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT6_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT7_NOV'		width=20		name='7'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT7_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT8_NOV'		width=20		name='8'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT8_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT9_NOV'		width=20		name='9'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT9_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT10_NOV'		width=20		name='10'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT10_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT11_NOV'		width=20		name='11'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT11_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT12_NOV'		width=20		name='12'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT12_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT13_NOV'		width=20		name='13'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT13_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT14_NOV'		width=20		name='14'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT14_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT15_NOV'		width=20		name='15'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT15_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT16_NOV'		width=20		name='16'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT16_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT17_NOV'		width=20		name='17'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT17_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT18_NOV'		width=20		name='18'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT18_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT19_NOV'		width=20		name='19'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT19_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT20_NOV'		width=20		name='20'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT20_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT21_NOV'		width=20		name='21'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT21_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT22_NOV'		width=20		name='22'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT22_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT23_NOV'		width=20		name='23'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT23_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT24_NOV'		width=20		name='24'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT24_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT25_NOV'		width=20		name='25'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT25_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT26_NOV'		width=20		name='26'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT26_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT27_NOV'		width=20		name='27'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT27_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT28_NOV'		width=20		name='28'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT28_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT29_NOV'		width=20		name='29'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT29_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT30_NOV'		width=20		name='30'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT30_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT31_NOV'		width=20		name='31'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT31_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>

								</G>
                                <G> id='MM_DEC' name='3��'  HeadBgColor='#F7DCBB'
                                    <C> id='AT1_DEC'		width=20		name='1'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT1_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT2_DEC'		width=20		name='2'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT2_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT3_DEC'		width=20		name='3'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT3_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT4_DEC'		width=20		name='4'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT4_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT5_DEC'		width=20		name='5'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT5_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT6_DEC'		width=20		name='6'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT6_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT7_DEC'		width=20		name='7'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT7_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT8_DEC'		width=20		name='8'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT8_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT9_DEC'		width=20		name='9'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT9_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
									<C> id='AT10_DEC'		width=20		name='10'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT10_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT11_DEC'		width=20		name='11'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT11_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT12_DEC'		width=20		name='12'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT12_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT13_DEC'		width=20		name='13'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT13_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT14_DEC'		width=20		name='14'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT14_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT15_DEC'		width=20		name='15'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT15_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT16_DEC'		width=20		name='16'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT16_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT17_DEC'		width=20		name='17'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT17_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT18_DEC'		width=20		name='18'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT18_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT19_DEC'		width=20		name='19'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT19_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT20_DEC'		width=20		name='20'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT20_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT21_DEC'		width=20		name='21'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT21_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT22_DEC'		width=20		name='22'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT22_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT23_DEC'		width=20		name='23'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT23_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT24_DEC'		width=20		name='24'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT24_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT25_DEC'		width=20		name='25'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT25_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT26_DEC'		width=20		name='26'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT26_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT27_DEC'		width=20		name='27'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT27_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT28_DEC'		width=20		name='28'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT28_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT29_DEC'		width=20		name='29'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT29_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
                                    <C> id='AT30_DEC'		width=20		name='30'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT30_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
								    <C> id='AT31_DEC'		width=20		name='31'				align=center	edit='AlphaUpper'       bgcolor={Decode(AT31_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','#FEEFEF')} </C>
								</G>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td  align="right" class="searchState" width="100" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:H&nbsp;</td>
        <td  width="50" bgcolor="#F2AC47"><input type="text" name="H_val" size="3" readOnly ></td>
        <td  width="50" >&nbsp;</td>
        <td  align="right" class="searchState" width="100" >���� ����:P&nbsp;</td>
        <td  width="50" bgcolor="#46B8FF"><input type="text" name="P_val" size="3" readOnly></td>
        <td  width="50" >&nbsp;</td>
        <td  align="right" class="searchState" width="100" >���� ����:R&nbsp;</td>
        <td  width="50" bgcolor="#80AD80"><input type="text" name="R_val" size="3" readOnly></td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->
<input type="hidden" name="H_val_fix" value="">
<input type="hidden" name="P_val_fix" value="">
<input type="hidden" name="R_val_fix" value="">

<input type="hidden" name="row_num" value="">
<input type="hidden" name="col_id" value="UATT_Z">
<input type="hidden" name="pre_data" value="">

<input type="hidden" name="str_ymd" value="">

</form>
<!-- form �� -->

</body>
</html>