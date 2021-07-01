<!--
*****************************************************
* @source       : butb020.jsp
* @description  : �ؿ�����ǰ�Ǽ��ۼ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2010/03/11      ������        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String ord_no = request.getParameter("ORD_NO");         //ǰ�ǹ�ȣ
	String eno_no = request.getParameter("PENO_NO");         //ǰ���ڻ��
	String app_status = request.getParameter("APP_STATUS"); //�������
    String app_cmt = request.getParameter("APP_CMT");       //�������ǰ�
	String role_cd = box.getString("SESSION_ROLE_CD");         //�ѱ���
    //���缱����� ���� ����
    if(eno_no == null){
    	eno_no = (String)request.getSession().getAttribute("SESSION_ENONO");
    }

	System.out.println("ord_no [" + ord_no + "]");
	System.out.println("eno_no [" + eno_no + "]");
	System.out.println("app_status [" + app_status + "]");
	System.out.println("app_cmt [" + app_cmt + "]");

%>

<html>
<head>
<title>�ؿ�����ǰ�Ǽ��ۼ�(butc020)</title>
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
		var btnList = 'FFTTFTFT';

        var dsTemp = window.dialogArguments;

        var status = "";//���� ���� ����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            if(dsTemp != "Modal"){
                trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_DI_OVERSEASTRIP_DTL=dsT_DI_OVERSEASTRIP_DTL)";
                trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SHR_03&ORD_NO="+dsT_DI_DISPATCH.NameValue(1,"ORD_NO")+"&ENO_NO="+dsT_DI_DISPATCH.NameValue(1,"ENO_NO");
                trT_DI_DISPATCH_SHR.post();
            }else{
	        	trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_DI_OVERSEASTRIP_DTL=dsT_DI_OVERSEASTRIP_DTL)";
				trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SHR_03&ORD_NO=<%=ord_no%>&ENO_NO=<%=eno_no%>";
				trT_DI_DISPATCH_SHR.post();
			}

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //ǰ�ǹ�ȣ ��ȸ
            dsORD_NO.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SHR_01";
			dsORD_NO.reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;

            //ǰ�ǹ�ȣ ����
            if(document.getElementById("txtORD_NO").value.trim() == ""){
				fnc_SearchItem();

				//���缱�� ǰ�ǹ�ȣ �Է�
	            for(i=1; i<=dsT_DI_APPROVAL.CountRow; i++){
					dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = dsT_DI_DISPATCH.NameValue(1,"ORD_NO");
	            }
            }

            var ord_no = dsT_DI_DISPATCH.NameValue(1,"ORD_NO");

            var msgFlag = "";
            if(dsT_DI_DISPATCH.IsUpdated == true){
                var msgFlag = "Y";
            }
			for(var i = 1; i <= dsT_DI_OVERSEASTRIP_DTL.CountRow;i++){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(i,"ORD_NO") = dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ORD_NO");    //ǰ�ǹ�ȣ
			}
			trT_DI_DISPATCH.KeyValue = "tr(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL, I:dsT_DI_OVERSEASTRIP_DTL=dsT_DI_OVERSEASTRIP_DTL )";
			trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SAV_01&ORD_NO="+ord_no;
			trT_DI_DISPATCH.post();

            if(msgFlag == "Y"){
				alert("����Ǿ����ϴ�. ����ϼ���.");
       		}
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if(dsT_DI_OVERSEASTRIP_DTL.CountRow < 3){
                alert("����ϰ� �������� �־�� �մϴ�");
                return;
            }
			dsT_DI_OVERSEASTRIP_DTL.DeleteRow(dsT_DI_OVERSEASTRIP_DTL.RowPosition);
        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {
            dsT_DI_OVERSEASTRIP_DTL.AddRow();
            dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"ORD_NO") = dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ORD_NO");    //ǰ�ǹ�ȣ
            dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"ENO_NO") = dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ENO_NO");    //ǰ�ǹ�ȣ
            dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NO") = dsT_DI_OVERSEASTRIP_DTL.CountRow;//����

			var seq_no = dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NO");
			if(seq_no == "1"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NM") = "�����"
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"BUT_YMDHM") = (dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"BUT_FR_YMD")).replaceStr("-","")+"0000";
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"BUT_FR_NAT") = "KR"
			}else if(seq_no == "2"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NM") = "������"
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"BUT_YMDHM") = (dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"BUT_TO_YMD")).replaceStr("-","")+"0000";
			}else{
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NM") = "������"
			}
        }
        function fnc_Approval() {

            var DPT_CD = document.getElementById("txtDPT_CD").value;
			var EMP_NO =  document.getElementById("txtENO_NO").value;

      		//ds�� ���Ϲ޴´�.
            dsT_DI_APPROVAL.DeleteAll();
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "E");

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();
            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
				var tempEnoNo = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");

				dsT_DI_APPROVAL.addrow();
				dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ORD_NO");
				dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
				dsT_DI_APPROVAL.NameValue(i,"ENO_NM")= dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
				dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
				dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
				dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
				dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
				dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = i;
				dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "E";
				dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
            }
			fnc_AutoApproval(dsT_DI_APPROVAL.countrow);
        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
         //�̻��
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if(dsT_DI_APPROVAL.CountRow < 2){
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			dsT_DI_APPROVAL.DeleteRow(1);

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			dsT_DI_DISPATCH.ClearData();
			dsT_DI_APPROVAL.ClearData();
            dsORD_NO.ClearData();
            fnc_InputEnable();

	        fnc_OnLoadProcess();

	        document.getElementById("imgSave").style.display = "";

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtBUT_FR_YMD").focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
                if (dsT_DI_DISPATCH.IsUpdated)  {
                    if (!fnc_ExitQuestion()) return;
                }
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }else{
                window.close();
            }
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
            var but_fr_ymd = document.getElementById("txtBUT_FR_YMD");
            var but_to_ymd = document.getElementById("txtBUT_TO_YMD");
            var but_nat = document.getElementById("cmbBUT_NAT");
            var but_city = document.getElementById("txtBUT_CITY");
            var but_obj = document.getElementById("txtBUT_OBJ");
            /**
            var pc_cctrcd = document.getElementById("txtPC_CCTRCD");
            var pc_gbn = document.getElementById("txtPC_GBN");
            var wbs_fr_ymd = document.getElementById("txtWBS_FR_YMD");
            var wbs_to_ymd = document.getElementById("txtWBS_TO_YMD");
            **/
            var visa_yn = document.getElementById("cmbVISA_YN");
            var pass_yn = document.getElementById("cmbPASS_YN");
            var but_gbn = document.getElementById("cmbBUT_GBN");
            var currency_nm = document.getElementById("txtCURRENCY_NM");
            var ext_rate = document.getElementById("txtEXT_RATE");

			//alert("dsTemp : "+dsTemp+",    status : "+status);
            if(dsTemp == "Modal" && (status != "1" && status != "5")) return;//�˾��� ���

			if (!dsT_DI_DISPATCH.IsUpdated && !dsT_DI_APPROVAL.IsUpdated && !dsT_DI_OVERSEASTRIP_DTL.IsUpdated) {
                //alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

            if(dsT_DI_APPROVAL.CountRow < 4){
                alert("���缱�� �����ϼž� �մϴ�!");
                return false;
            }

            if(but_fr_ymd.value == ""){
                alert("���� �������� �Է��ϼ���!");
                but_fr_ymd.focus();
                return false;
            }
            if(but_to_ymd.value == ""){
                alert("���� �������� �Է��ϼ���!");
                dis_to_ymd.focus();
                return false;
            }
            /**
            if(pc_cctrcd.value == ""){
                alert("��ǥ�ڵ带 �Է��ϼ���!");
                 document.getElementById("ImgSelectSlip").focus();
                return false;
            }
			if(pc_gbn.value == "W"){
				if(but_fr_ymd.value.replaceStr("-", "") < wbs_fr_ymd.value){
					alert("������Ʈ���� ����������� �ʽ��ϴ�");
					 document.getElementById("txtBUT_FR_YMD").focus();
					return false;
				}
				if(but_to_ymd.value.replaceStr("-", "") > wbs_to_ymd.value){
					alert("������Ʈ���� ������������ �ʽ��ϴ�");
					 document.getElementById("txtBUT_TO_YMD").focus();
					return false;
				}
			}
			**/
            if(but_nat.value == ""){
                alert("���屹���� �Է��ϼ���!");
                but_nat.focus();
                return false;
            }
            if(but_city.value == ""){
                alert("�������� �Է��ϼ���!");
                but_city.focus();
                return false;
            }
            if(but_obj.value == ""){
                alert("��������� �Է��ϼ���!");
                but_obj.focus();
                return false;
            }
			if(visa_yn.value == ""){
                alert("�����ʿ俩�θ� �����ϼ���!");
                visa_yn.focus();
                return false;
            }
			if(pass_yn.value == ""){
                alert("�н������ʿ俩�θ� �����ϼ���!");
                pass_yn.focus();
                return false;
            }
			if(but_gbn.value == ""){
                alert("���籸���� �����ϼ���!");
                but_gbn.focus();
                return false;
            }
			if(currency_nm.value == ""){
                alert("�������ޱ����� �Է��ϼ���!");
                currency_nm.focus();
                return false;
            }
			if(ext_rate.value == "" || ext_rate.value == "0"){
                alert("ȯ���� �Է��ϼ���!");
                ext_rate.focus();
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.CountRow < 2){
                alert("������� �������� �����ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_YMDHM") == ""){
                alert("������� �Է��ϼž� �մϴ�!");
                return false;
            }
			if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_YMDHM").length != 12){
                alert("������� ��-��-��-��-�� �� ��� �Է��ؾ��մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_FR_NAT") == ""){
                alert("��߱����� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_FR_CITY") == ""){
                alert("��ߵ��ø� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_TO_NAT") == ""){
                alert("���������� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_TRA") == ""){
                alert("�������� ���� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_TO_CITY") == ""){
                alert("�������ø� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_YMDHM") == ""){
                alert("������� �Է��ϼž� �մϴ�!");
                return false;
            }
			if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_YMDHM").length != 12){
                alert("������� ��-��-��-��-�� �� ��� �Է��ؾ��մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_FR_NAT") == ""){
                alert("��߱����� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_FR_CITY") == ""){
                alert("��ߵ��ø� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_TO_NAT") == ""){
                alert("���������� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_TO_CITY") == ""){
                alert("�������ø� �Է� �ϼž� �մϴ�!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_TRA") == ""){
                alert("�������� ���� �ϼž� �մϴ�!");
                return false;
            }
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
			// ��������
			for( var i = 1; i <= dsT_CM_COMMON_L2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_L2.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_L2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbBUT_NAT").add(oOption);
			}

            if(dsTemp != "Modal"){ //�˾��� �ƴѰ��
                fnc_BusinesstripInsert(); //ǰ�Ǽ� �ۼ��� ����
            }else{ //�˾��� ���
                fnc_OnLoadPop();
            }

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)

			cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

			cfStyleGrid(form1.grdT_DI_OVERSEASTRIP_DTL,15,"true","false");      // Grid Style ����

            //���� ��ȸ
            dsT_CM_NAT.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=NAT_SHR";
			dsT_CM_NAT.reset();

			//ȯ�������ư ���̰��ϱ�
			if( "1001" == "<%=role_cd%>" || "1002" == "<%=role_cd%>"){
				if("<%=app_status%>" == "4"){
					document.getElementById("btn_exchSav").style.display = "";
					document.getElementById("txtEXT_RATE").className = "";
					document.getElementById("txtEXT_RATE").disabled = false;
				}
			}
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************************
         * 16. ǰ�Ǽ� �ۼ��� �����ͼ� ��� ���� �� ������ �߰�  *
         *******************************************************/
		function fnc_BusinesstripInsert() {

            dsT_DI_DISPATCH.ClearAll();
            dsT_DI_APPROVAL.ClearAll();

			// �����ͼ��� ��� ���� ����.
			dsT_DI_DISPATCH.setDataHeader("ORD_NO:STRING, "+	// ǰ�ǹ�ȣ
										"ENO_NO:STRING, "+		// ���
										"ENO_NM:STRING, "+		// ����
										"DPT_CD:STRING, "+		// �μ�
										"DPT_NM:STRING, "+		// �μ���
										"JOB_CD:STRING, "+		// �����ڵ�
										"JOB_NM:STRING, "+		// ������
										"BUT_FR_YMD:STRING, "+	// ���������
										"BUT_TO_YMD:STRING, "+	// ����������
										"SLEEP_DAY:STRING, "+	// ��
										"BUT_DAY:STRING, "+		// ��
										"BUT_CITY:STRING, "+	// ��������
										"BUT_NAT:STRING, "+		// ���屹��
										"BUT_OBJ:STRING,"+		// �������
										"BUT_AFF:STRING,"+		// ����ȿ��
										"BUT_GBN:STRING,"+		// ���籸��
										"VISA_YN:STRING,"+		// �����ʿ俩��
										"PASS_YN:STRING,"+		// �����ʿ俩��
										"BUT_EXPENSE:DECIMAL,"+	// �Ϻ�
										"BUT_LODGING:DECIMAL,"+	// ���ں�
										"BUT_SUM:DECIMAL,"+		// �Ϻ��հ�
										"BUT_AMT:DECIMAL,"+		// �Ϻ�
										"PC_GBN:STRING,"+		// ������Ʈ����(W,C)
										"PC_CCTRCD:STRING,"+	// ������Ʈ�ڵ�
										"PC_CCTRNM:STRING,"+	// ������Ʈ��
										"EXT_RATE:DECIMAL,"+	// ȯ������
										"CURRENCY_NM:STRING,"+	// ȯ������
										"APP_CMT:STRING,"+		// �����ǰ�
										"APP_STATUS:STRING,"+	// �������
										"APP_ENO_NO:STRING,"+	// ����ڻ��
										"APP_JOB_CD:STRING");	// ���������

			// �����ͼ��� ��� ���� ����.
			dsT_DI_OVERSEASTRIP_DTL.setDataHeader("ORD_NO:STRING, "+	// ǰ�ǹ�ȣ
										"ENO_NO:STRING, "+		// ���
										"SEQ_NO:STRING,"+
										"SEQ_NM:STRING,"+
										"BUT_YMDHM:STRING,"+
										"BUT_FR_NAT:STRING,"+
										"BUT_FR_NAT_NM:STRING,"+
										"BUT_FR_CITY:STRING,"+
										"BUT_FR_CITY_NM:STRING,"+
										"BUT_TO_NAT:STRING,"+
										"BUT_TO_NAT_NM:STRING,"+
										"BUT_TO_CITY:STRING,"+
										"BUT_TO_CITY_NM:STRING,"+
										"BUT_TRA:STRING"
											);	// ���������

			// �����ͼ��� ��� ���� ����.
			dsT_DI_BUDGET.setDataHeader(
										"ENO_NO:STRING, "+		// ���
										"DIS_FR_YMD:STRING, "+	// ���������
										"PC_GBN:STRING,"+	// ������Ʈ�ڵ�
										"PC_CCTRCD:STRING");	// �����ܾ�

			// �����ͼ��� ��� ���� ����.
			dsT_DI_BUDGET_RESULT.setDataHeader(
										"BUDGET_AMT:STRING");	// �����ܾ�

            dsT_DI_DISPATCH.AddRow();
            //SESSION ����
            dsT_DI_DISPATCH.NameValue(1,"DPT_CD") = '<%=box.get("SESSION_DPTCD")%>';
            dsT_DI_DISPATCH.NameValue(1,"JOB_CD") = '<%=box.get("SESSION_JOBCD")%>';
            dsT_DI_DISPATCH.NameValue(1,"ENO_NO") = '<%=box.get("SESSION_ENONO")%>';
            dsT_DI_DISPATCH.NameValue(1,"ENO_NM") = '<%=box.get("SESSION_ENONM")%>';
            dsT_DI_DISPATCH.NameValue(1,"DPT_NM") = '<%=box.get("SESSION_DPTNM")%>';
            dsT_DI_DISPATCH.NameValue(1,"JOB_NM") = '<%=box.get("SESSION_JOBNM")%>';
            // �����ͼ��� ��� ���� ����(����, ������ ����)
            dsT_DI_APPROVAL.setDataHeader("GUN_YMD:STRING, "+
										  "GUN_GBN:STRING, "+
										  "REQ_NO:STRING,"+
										  "ENO_NO:STRING, "+
										  "ENO_NM:STRING, "+
										  "DPT_CD:STRING, "+
										  "PENO_NO:STRING, "+
										  "DPT_NM:STRING, "+
										  "JOB_CD:STRING, "+
										  "JOB_NM:STRING, "+
										  "SEQ_NM:STRING, "+
										  "SEQ_NO:STRING");

		}
		function fnc_AutoApproval(appNumParam){
			var appNum = appNumParam + 1;
			var obj    = new String;
            //���� ���������� ���� �����ͼ¿� ������� �⺻���� Setting(ǰ�ǹ�ȣ,�����������)
			for(var i = appNum; i<=appNum+2; i++) {
				dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = "9"+i;
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "E";
				if (i == appNum) {
	            		obj = fnc_GetCommonEnoObj("1990071");
	            } else if (i == appNum + 1) {
	            		obj = fnc_GetCommonEnoObj("2020008");
				} else if (i == appNum + 2) {
	            		obj = fnc_GetCommonEnoObj("2030007");
	            }
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = '<%=box.get("SESSION_ENONO")%>';
	            dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = document.getElementById("txtORD_NO").value;
			}
		}
		/*************************
         * 17. �����ϼ� �ڵ���� *
         *************************/
		function fnc_Auto_Input(str_ymd, end_ymd) {
            var str = document.getElementById(str_ymd).value.split("-");
            var end = document.getElementById(end_ymd).value.split("-");
            var str_date;
            var end_date;
            var sleep_day;
            if(document.getElementById(str_ymd).value != "" && document.getElementById(end_ymd).value != ""){
                str_date = new Date(str[0],str[1]-1,str[2]);
                end_date = new Date(end[0],end[1]-1,end[2]);
                sleep_day = (end_date-str_date)/(24*60*60*1000);
                document.getElementById("txtSLEEP_DAY").value = sleep_day;
                document.getElementById("txtBUT_DAY").value = sleep_day+1;
            }
        }
        /***************************
         * 18. �Է¶� Disabledó�� *
         ***************************/
		function fnc_InputDisabled() {

            document.getElementById("txtBUT_FR_YMD").className = "input_ReadOnly";
            document.getElementById("txtBUT_FR_YMD").readOnly = true;
            document.getElementById("txtBUT_TO_YMD").className = "input_ReadOnly";
            document.getElementById("txtBUT_TO_YMD").readOnly = true;
            document.getElementById("cmbBUT_NAT").className = "input_ReadOnly";
            document.getElementById("cmbBUT_NAT").disabled = true;
            document.getElementById("cmbVISA_YN").className = "input_ReadOnly";
            document.getElementById("cmbVISA_YN").disabled = true;
            document.getElementById("cmbPASS_YN").className = "input_ReadOnly";
            document.getElementById("cmbPASS_YN").disabled = true;
            document.getElementById("txtEXT_RATE").className = "input_ReadOnly";
            document.getElementById("txtEXT_RATE").disabled = true;
            document.getElementById("cmbBUT_GBN").className = "input_ReadOnly";
            document.getElementById("cmbBUT_GBN").disabled = true;
            document.getElementById("txtBUT_CITY").className = "input_ReadOnly";
            document.getElementById("txtBUT_CITY").disabled = true;
            document.getElementById("txtBUT_OBJ").className = "input_ReadOnly";
            document.getElementById("txtBUT_OBJ").readOnly = true;
            document.getElementById("txtBUT_AFF").className = "input_ReadOnly";
            document.getElementById("txtBUT_AFF").readOnly = true;

            //���缱 ����, ���� ��ư
            document.getElementById("btn_InsDel").style.display = "none";
            //��ǥ ����, ���� ��ư
            //document.getElementById("btn_slip").style.display = "none";
        }

        function fnc_InputEnable() {
            document.getElementById("txtBUT_FR_YMD").className = "";
            document.getElementById("txtBUT_FR_YMD").readOnly = false;
            document.getElementById("txtBUT_TO_YMD").className = "";
            document.getElementById("txtBUT_TO_YMD").readOnly = false;
            document.getElementById("cmbBUT_NAT").className = "";
            document.getElementById("cmbBUT_NAT").disabled = false;
            document.getElementById("cmbVISA_YN").className = "";
            document.getElementById("cmbVISA_YN").disabled = false;
            document.getElementById("cmbPASS_YN").className = "";
            document.getElementById("cmbPASS_YN").disabled = false;
            document.getElementById("txtEXT_RATE").className = "";
            document.getElementById("txtEXT_RATE").disabled = false;
            document.getElementById("cmbBUT_GBN").className = "";
            document.getElementById("cmbBUT_GBN").disabled = false;
            document.getElementById("txtBUT_CITY").className = "";
            document.getElementById("txtBUT_CITY").disabled = false;
            document.getElementById("txtBUT_OBJ").className = "";
            document.getElementById("txtBUT_OBJ").readOnly = false;
            document.getElementById("txtBUT_AFF").className = "";
            document.getElementById("txtBUT_AFF").readOnly = false;
            //���缱 ����, ���� ��ư
            document.getElementById("btn_InsDel").style.display = "";
			//��ǥ ����, ���� ��ư
            //document.getElementById("btn_slip").style.display = "";
        }

        /*************************
         * 19. ���, ���� ó��   *
         *************************/
		function fnc_SubmitApproval(kind) {
            //���ó���� ������ �������� Ȯ��
            if (dsT_DI_DISPATCH.IsUpdated) {
                alert("ǰ�Ǽ� ������ ����Ǿ����ϴ�. ������ ����� �ٽ� Ȯ�����ּ���.");
                return false;
            }
            if(dsT_DI_APPROVAL.IsUpdated) {
                alert("���缱�� ����Ǿ����ϴ�. �ٽ� �������ּ���.");
                return false;
            }
            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;
            var app_eno_no = "<%=eno_no%>";
			var app_status = "";
            if(kind == "���"){
                app_status = "2";
				app_eno_no = '<%=box.getString("SESSION_ENONO")%>';
            }else if(kind == "����"){
                app_status = "3";
				app_eno_no
			}
			dsT_DI_DISPATCH.NameValue(1, "APP_CMT") = kind;
			dsT_DI_DISPATCH.NameValue(1, "APP_STATUS") = app_status;
			dsT_DI_DISPATCH.NameValue(1, "APP_ENO_NO") = app_eno_no;

			dsT_DI_DISPATCH.UserStatus(1)=1;

			var appCnt = 0;
			for(var i = 0; i < dsT_DI_APPROVAL.CountRow; i++){
				if(dsT_DI_APPROVAL.NameValue(i, "APP_YN") == "Y"){
					appCnt += 1;
				}
			}
			if(appCnt == dsT_DI_APPROVAL.CountRow){
				alert("�����������̹Ƿ� ���¹ݿ����� �ð��� �ټ� �ɸ��ϴ�.");
			}
			var paramURL = "cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SAV_02&APP_CMT="+kind+"&APP_STATUS="+app_status+"&APP_ENO_NO="+app_eno_no;
            trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
			trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?"+paramURL;
			trT_DI_DISPATCH.post();
            if(status == "2"){//��������
                fnc_InputDisabled();//�Է¶� disabled
                document.getElementById("btn_appre").style.display = "";//��žʺ��̰�
            }else{
                document.getElementById("btn_approval").style.display = "none";//�����ư�� �ʺ��̰�
            }
			if(kind == "����"){
                document.getElementById("btn_appre").style.display = "none";//��žʺ��̰�
                document.getElementById("btn_approval").style.display = "none";//�����ư�� �ʺ��̰�
			}
            document.getElementById("imgSave").style.display = "none";//���� �ʺ��̰�
        }
        /********************
         * 16. ���� �Է�    *
         *******************/
		function fnc_InputCurrency() {

            if(document.getElementById("cmbBUT_NAT").value == "KR"){
                alert("���ѹα��� ������ �� �����ϴ�!");
                document.getElementById("cmbBUT_NAT").value = "";
                return;
            }

  			var BUT_NAT = document.getElementById("cmbBUT_NAT").value;
			dsT_DI_OVERSEASBT_BASIS_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                                              + "&S_MODE=SHR_04"
                                              + "&BUT_CITY_CD="+BUT_NAT;
			dsT_DI_OVERSEASBT_BASIS_01.reset();
		}

        /*************************
         * 21. �˾��� ��� ó��  *
         *************************/
		function fnc_OnLoadPop() {

            status = "<%=app_status%>";
            fnc_SearchList(); //�ش� ����ǰ�Ǽ� ��ȸ

			//�ݼ۵Ȱ��� ����ڰ� ���� ����
            if(("<%=app_cmt%>").substring(0,2) == "�ݼ�" && dsT_DI_DISPATCH.NameValue(1,"ENO_NO") == '<%=box.get("SESSION_ENONO")%>'){
	            status = "1";
  			//����̳� ����Ȱ��� ���ʿ��ư �ʺ��̰��Ѵ�.
            }else if("<%=app_cmt%>" != "����"){
            	document.getElementById("imgSave").style.display = "none";
            	document.getElementById("ImgAppend").style.display = "none";
            	document.getElementById("ImgRemove").style.display = "none";
            }

            //�˾������� ��� �ʺ��̰�
            document.getElementById("ImgClear").style.display = "none";

            //��������� �����̰ų� ����ڰ� �ƴ� ����� �˾����� �������� �Է¶� Disabled
            if(status != "1" || dsT_DI_DISPATCH.NameValue(1,"ENO_NO") != '<%=box.get("SESSION_ENONO")%>'){
                fnc_InputDisabled();
            }else{
            }

            var temp = "";
            var eno_no = "";
			var app_yn = "";

            if("<%=app_status%>" == "2" || "<%=app_status%>" == "3" || "<%=app_status%>" == "5"){
                for(var i= 0; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");//������
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");//���翩��
					if(eno_no == '<%=box.get("SESSION_ENONO")%>' &&  (app_yn == 'R' ||  app_yn == 'E')){
						document.getElementById("btn_approval").style.display = "";
						break;
					}
                }
            }
            //������ĸ� �μⰡ ���δ�.

            if("<%=app_status%>" == "4" ){
				if( "1001" == "<%=role_cd%>" || "1002" == "<%=role_cd%>"){
					document.getElementById("btn_SlipProc").style.display = "";
				}
            }else{
                document.getElementById("btn_SlipProc").style.display = "none";
            }
        }

        /*****************************************
         * 22. �����Է��˾�(�ΰ�, �ݼ�ó��)      *
         ****************************************/
		function fnc_SubmitCancle(kind) {

            //if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

            var obj = new String();
			var app_yn = "";
            window.showModalDialog("/hr/but/butb023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != undefined){
				if(kind == "�ΰ�"){
					app_yn = "N";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "6";
				}else{//�ݼ�
					app_yn = "E";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "5";
				}
                dsT_DI_DISPATCH.NameValue(1,"APP_CMT") = kind+"ó��-"+obj.app_cmt;

                trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
                trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SAV_03&APP_YN="+app_yn;
                trT_DI_DISPATCH.post();

                document.getElementById("btn_approval").style.display = "none";
            }
        }
/**
        //��ǥ�ڵ� ȹ��
		function fnc_Slipconduct(){
            var but_fr_ymd = document.getElementById("txtBUT_FR_YMD");
            if(but_fr_ymd.value == ""){
                alert("���� �������� �Է��ϼ���!");
                but_fr_ymd.focus();
                return false;
            }
			var url = "/hr/but/buta011.jsp";
			var returnValue = new Array(2);
			window.showModalDialog(url, returnValue, "dialogWidth:730px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			var GUBUN = returnValue[0];
			var CCTR_CD = returnValue[1];
			var CCTR_NM = returnValue[2];
			var WBS_FR_YMD = returnValue[3];
			var WBS_TO_YMD = returnValue[4];

			if(GUBUN == "undefined" || GUBUN == undefined || GUBUN == ""){
			}else{
				if(GUBUN == "WBS"){
					GUBUN = "W";
				}else if(GUBUN == "COST"){
					GUBUN = "C";
				}
				document.getElementById("txtPC_GBN").value = GUBUN;
				document.getElementById("txtPC_CCTRCD").value = CCTR_CD;
				document.getElementById("txtPC_CCTRNM").value = CCTR_NM;
				document.getElementById("txtWBS_FR_YMD").value = WBS_FR_YMD;
				document.getElementById("txtWBS_TO_YMD").value = WBS_TO_YMD;

				dsT_DI_BUDGET.DeleteAll();
				dsT_DI_BUDGET.AddRow();
				dsT_DI_BUDGET.NameValue(1,"ENO_NO") =  '<%=box.get("SESSION_ENONO")%>';
				dsT_DI_BUDGET.NameValue(1,"PC_GBN") =   GUBUN;
				dsT_DI_BUDGET.NameValue(1,"PC_CCTRCD") =  CCTR_CD;
				dsT_DI_BUDGET.NameValue(1,"DIS_FR_YMD") =   but_fr_ymd.value;
                trT_DI_BUDGET_SHR.KeyValue = "tr(I:dsT_DI_BUDGET=dsT_DI_BUDGET,O:dsT_DI_BUDGET_RESULT=dsT_DI_BUDGET_RESULT)";
                trT_DI_BUDGET_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc021.cmd.BUTC021CMD&S_MODE=SHR_02";
                trT_DI_BUDGET_SHR.post();
			}
		}
		//��ǥó��
		function fnc_Slip() {
			if(confirm("��ǥó���Ͻðڽ��ϱ�?")){
				dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition, "APP_STATUS") = "7";
				trT_DI_DISPATCH_PROC.KeyValue = "tr02(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
				trT_DI_DISPATCH_PROC.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=PROC";
				trT_DI_DISPATCH_PROC.post();
			}else{
			}
		}
**/
		//��ȯ���� Link
		function fnc_Exchange(){
			window.open('http://fx.keb.co.kr/FER1101C.web','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
		}
		//ȯ������
		function fnc_ExchangeSave(){
			trT_DI_DISPATCH_EXCH.KeyValue = "tr02(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
			trT_DI_DISPATCH_EXCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=EXEC";
			trT_DI_DISPATCH_EXCH.post();
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
    | 2. �̸� : dsORD_NO                            |
    | 3. Table List : T_DI_DISPATCH             |
    +----------------------------------------------->
    <Object ID="dsORD_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_DISPATCH                 |
    | 3. Table List : T_DI_DISPATCH             |
    +----------------------------------------------->
    <Object ID="dsT_DI_DISPATCH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_OVERSEASTRIP_DTL)     |
    | 3. ���Ǵ� Table List(dsT_DI_OVERSEASTRIP_DTL) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_OVERSEASTRIP_DTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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
    | 2. �̸� : dsT_DI_BUDGET                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUDGET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_BUDGET                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUDGET_RESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_CM_NAT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_CM_CITY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_DISPATCH)	|
    | 3. ���Ǵ� Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_DISPATCH)	|
    | 3. ���Ǵ� Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUDGET_SHR)	|
    | 3. ���Ǵ� Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_BUDGET_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUDGET_SHR)	|
    | 3. ���Ǵ� Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_PROC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUDGET_SHR)	|
    | 3. ���Ǵ� Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_EXCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Z4"/>
       <jsp:param name="CODE_GUBUN"    value="Z4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ������ -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_L2"/>
       <jsp:param name="CODE_GUBUN"    value="L2"/>
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
    <Script For=dsT_DI_DISPATCH Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <Script For=dsORD_NO Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
			document.getElementById("txtORD_NO").value = dsORD_NO.NameValue(1,"ORD_NO");
        }

    </Script>


    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

            document.form1.grdT_DI_APPROVAL.Format = "<C> id='SEQ_NO'		width=40	name='NO'		align=center	show=false</C>"+
													 "<C> id='SEQ_NM'		width=40	name='NO'		align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>"+
                                                     "<C> id='DPT_NM'		width=95	name='�Ҽ�'		align=left		</C>"+
                                                     "<C> id='JOB_NM'		width=61	name='����'		align=center	</C>"+
                                                     "<C> id='ENO_NO'		width=70	name='���'		align=center  show=false	</C>"+
                                                     "<C> id='ENO_NM'		width=100	name='����'		align=center	</C>"+
                                                     "<C> id='APP_STATUS'	width=160	name='�������'	align=left	    </C>";

            //ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
            form1.grdT_DI_APPROVAL.TitleHeight = 18;
            form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
            form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }

    </Script>
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERSEASBT_BASIS_01 Event="OnLoadCompleted(iCount)">
        if(dsT_DI_OVERSEASBT_BASIS_01.CountRow == 1)
            document.getElementById("txtCURRENCY_NM").value = dsT_DI_OVERSEASBT_BASIS_01.NameString(1, "CURRENCY_NM");
    </Script>
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_DISPATCH Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsORD_NO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>


    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_DISPATCH Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_DISPATCH event="OnSuccess()">
        fnc_SearchList();
		if(dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") == "1" ){
			document.getElementById("btn_appre").style.display = "";
		}else{
			document.getElementById("btn_appre").style.display = "none";
		}
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_DISPATCH event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_DISPATCH_EXCH event="OnSuccess()">
        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_DISPATCH_EXCH event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUDGET_SHR event="OnSuccess()">
		document.getElementById("txtBUDGET_AMT").value = dsT_DI_BUDGET_RESULT.NameValue(1,"BUDGET_AMT");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUDGET_SHR event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_DISPATCH_PROC event="OnSuccess()">
        cfErrorMsg(this);
		window.close();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_DISPATCH_PROC event="OnFail()">
        cfErrorMsg(this);
		window.close();
    </script>

    <!---------------------------+
    | grid�� �˾��ʵ� Ŭ���� ó��|
    +---------------------------->
    <script language="javascript" for=grdT_DI_OVERSEASTRIP_DTL event=OnPopup(row,colid,data)>

        if(row > 0) {
			var obj = new String();
			obj.nat_cd = "";
			obj.nat_nm = "";
			obj.city_cd = "";
			obj.city_nm = "";
			window.showModalDialog("/common/popup/world_city.jsp", obj, "dialogWidth:500px; dialogHeight:550px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			if(colid == "BUT_FR_NAT_NM" || colid == "BUT_FR_CITY_NM"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_NAT") = obj.nat_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_NAT_NM") = obj.nat_nm;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_CITY") = obj.city_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_CITY_NM") = obj.city_nm;
			}else if(colid == "BUT_TO_NAT_NM" || colid == "BUT_TO_CITY_NM"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_NAT") = obj.nat_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_NAT_NM") = obj.nat_nm;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_CITY") = obj.city_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_CITY_NM") = obj.city_nm;
			}
        }
    </script>
<script language=JavaScript for=grdT_DI_OVERSEASTRIP_DTL event=OnCloseUp(row,colid)>
/*
		if(colid == "BUT_FR_NAT" || colid == "BUT_TO_NAT"){
			var NAT_CD = dsT_CM_CITY.NameValue(row,"NAT_CD")
            //���� ��ȸ
            dsT_CM_CITY.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=CITY_SHR&NAT_CD=";
			dsT_CM_CITY.reset();
		}
*/
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

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ؿ�����ǰ�Ǽ�</td>
					<td align="right" class="navigator">HOME/���°���/�ؿ�����/<font color="#000000">�ؿ�����ǰ�Ǽ�</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5" align="left" width="435" height="35" >
            <span id="btn_SlipProc" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAccount','','/images/button/btn_SlipconductOver.gif',1)"><img src="/images/button/btn_SlipconductOn.gif" name="imgSlip" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Slip();"></a>
            </span>
            <span id="btn_appre" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)"><img src="/images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('���');"></a>
            </span>
            <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('����');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('�ΰ�');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSendback','','/images/button/btn_SendbackOver.gif',1)"><img src="/images/button/btn_SendbackOn.gif" name="imgSendback" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('�ݼ�');"></a>
            </span>
		</td>
		<td class="paddingTop5" align="right" width="285" height="35" >
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ���� �Է� ���̺� ���� -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="creamBold">ǰ�ǹ�ȣ</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="creamBold">�Ҽ�</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">����</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">������</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtNAM_KOR" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
        </td>
        <td width="30">&nbsp;</td>
        <td>
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:560px;height:108px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NO'		width=40	name='NO'		align=center	show='false'</C>
								<C> id='ENO_NO'		width=100	name='���'		align=center	show=false</C>
								<C> id='SEQ_NM'		width=50	name='����'		align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
								<C> id='ENO_NM'		width=70	name='������'		align=center</C>
								<C> id='JOB_NM'		width=60	name='����'		align=center	</C>
                                <C> id='DPT_NM'		width=100	name='�μ�'		align=left		</C>
								<C> id='APP_STATUS'	width=170	name='�������'	align=left	    </C>
								<C> id='REMARK1'	width=87	name='�ǰ�'		align=center 	Color='Blue'	</C>
								<C> id='REMARK'		width=60	name='����'		align=center	show=false</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right">
                        <span id="btn_InsDel">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()"></a>
                        </span>
		            </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">

				<colgroup>
					<col width="100"></col>
                    <col width="310"></col>
                    <col width="50"></col>
                    <col width="60"></col>
                    <col width="50"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">����Ⱓ</td>
					<td class="padding2423">
						<input id="txtBUT_FR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_FR_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_FR_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_FR_YMD','','40','235');"></a>
                        <input id="txtBUT_TO_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_TO_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_TO_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_TO_YMD','','300','235');"></a>
						(<input id="txtSLEEP_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>��
                        <input id="txtBUT_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>��)
                    </td>
					<td align="center" class="creamBold">����</td>
                    <td class="padding2423">
						<select id="cmbVISA_YN" name="cmbVISA_YN" style="width:85">
                            <option value="Y">�ʿ�</option>
                            <option value="N">���ʿ�</option>
                        </select>

					</td>
					<td align="center" class="creamBold">����</td>
                    <td class="padding2423" >
						<select id="cmbPASS_YN" name="cmbPASS_YN" style="width:85">
                            <option value="Y">�ʿ�</option>
                            <option value="N">���ʿ�</option>
                        </select>

					</td>
                </tr>
				<tr>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423">
						<select id="cmbBUT_NAT" style="width='110';" onChange="fnc_InputCurrency();">
						</select>
						<b>����</b>:<input id="txtCURRENCY_NM" size="5" align="right" class="input_ReadOnly" readOnly>
						<b>ȯ��</b>:<input id="txtEXT_RATE"  size="5" maxlength="10" align="right"   style="ime-mode:disabled" onkeypress="cfCheckNumber2()">
						<span id="btn_exchSav" style="display:none">
							<input type="button" value="ȯ������" size="10" align="right" onClick="fnc_ExchangeSave()">
						</span>
                    </td>
					<td align="center" class="creamBold">������</td>
                    <td class="padding2423" colspan="3" >
						<input id="txtBUT_CITY" size="40" maxlength="25">
					</td>
                </tr>
				<tr>
					<td align="center" class="creamBold">���籸��</td>
					<td class="padding2423" colspan="5">
						<select id="cmbBUT_GBN" style="width='120';">
							<option value="1">�������</option>
							<option value="2">��������</option>
						</select>
						 <input type="button" value="ȯ����ȸ" size="10" align="right" onClick="fnc_Exchange()">
                    </td>
                </tr>
                <!--
                <tr>
					<td align="center" class="creamBold">������Ʈ</td>
					<td class="padding2423" colspan="5">
						&nbsp;
						<input id="txtPC_CCTRCD" size="20" class="input_ReadOnly" readOnly>
						<input id="txtPC_CCTRNM" size="40"  class="input_ReadOnly" readOnly>
						<input type="hidden" id="txtPC_GBN" size="30" >
						<input type="hidden" id="txtWBS_FR_YMD" size="30" >
						<input type="hidden" id="txtWBS_TO_YMD" size="30" >
						<span id="btn_Slip">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectSlip','','/images/button/btn_SlipOver.gif',1)"> <img src="/images/button/btn_SlipOn.gif" name="ImgSelectSlip"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Slipconduct()"></a>
						<b>�����ܾ�</b> : <input id="txtBUDGET_AMT" size="15" align="right" class="input_ReadOnly" readOnly>
						</span>
					</td>
				</tr>
				 -->
                <tr>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423" colspan="5">
						<textarea id="txtBUT_OBJ"  onKeyUp="fc_chk_byte(this,200)"  cols=110  rows=3 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">����ȿ��</td>
					<td class="padding2423" colspan="5">
						<textarea id="txtBUT_AFF"  onKeyUp="fc_chk_byte(this,200)" cols=110  rows=3 >
						</textarea>
					</td>
				</tr>

				<!-- ���̺������� ���Ͽ� ������ �� �±�(����� colgroup��ŭ td���־�� ���̺� ����� ��׷����� �ʴ´�.) -->
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
            <table bgcolor="#FFFFFF" width="800"><tr><td>&nbsp;</td></tr></table>
		<!-- �������� -->
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
					<td align="center" class="creamBold">�ϴ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_EXPENSE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
										<!--
						<input id="txtBUT_EXPENSE" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
					<td align="center" class="creamBold">�ϴ��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_SUM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						<!--
						<input id="txtBUT_SUM" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
					<td align="center" class="creamBold">���ں�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_LODGING" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						<!--
						<input id="txtBUT_LODGING" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
					<td align="center" class="creamBold">�Ϻ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						<!--
						<input id="txtBUT_AMT" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
				</tr>
		</table>

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
	<!-- ��ư ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="right">
                            <span id="rate_msg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <img src="/images/button/btn_AppendOn.gif" name="ImgAppend"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppend','','/images/button/btn_AppendOver.gif',1)">
                            <img src="/images/button/btn_RemoveOn.gif" name="ImgRemove"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRemove','','/images/button/btn_RemoveOver.gif',1)">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
	<!-- ��ư ���̺� �� -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_OVERSEASTRIP_DTL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:150px;">
						<param name="DataID" value="dsT_DI_OVERSEASTRIP_DTL">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=30	name="NO"			align=center	value={String(Currow)}	</C>
                            <C> id="SEQ_NM"			width=60	name="����"		    align=center  Edit=none </C>
                            <C> id="BUT_YMDHM"	    width=120	name="�����"		align=center   MASK=XXXX-XX-XX-XX-XX </C>
						<G> name="�����"  HeadBgColor="#F7DCBB"
                            <C> id="BUT_FR_NAT"	    width=120	name="�����ڵ�"	align=left    show=false</C>
                            <C> id="BUT_FR_NAT_NM"	width=100	name="����"	    align=left EditStyle=PopupFix </C>
                            <C> id="BUT_FR_CITY"	width=110	name="�����ڵ�"	align=left  show=false</C>
                            <C> id="BUT_FR_CITY_NM"	width=140	name="����"	    align=left EditStyle=PopupFix </C>
						</G>
						<G> name="������"  HeadBgColor="#F7DCBB"
                            <C> id="BUT_TO_NAT"	    width=120	name="�����ڵ�"	align=left    show=false</C>
                            <C> id="BUT_TO_NAT_NM"  width=100	name="����"	    align=left EditStyle=PopupFix </C>
                            <C> id="BUT_TO_CITY"	width=110	name="�����ڵ�"	align=left    show=false</C>
                            <C> id="BUT_TO_CITY_NM"	width=140	name="����"	    align=left EditStyle=PopupFix </C>
						</G>
                            <C> id="BUT_TRA"	   width=70	name="����"	align=center  EditStyle=Combo Data="1:�װ�,2:��"  </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>


		</td>
	</tr>
</table>


<!-- ���� �Է� ���̺� �� -->


</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_DI_DISPATCH" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_DISPATCH">
	<Param Name="BindInfo", Value='
        <C>Col=ORD_NO     		Ctrl=txtORD_NO     		Param=value 	</C>
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     		Param=value 	</C>
        <C>Col=DPT_NM     		Ctrl=txtDPT_NM     		Param=value 	</C>
		<C>Col=JOB_CD			Ctrl=txtJOB_CD	   		Param=value		</C>
        <C>Col=JOB_NM			Ctrl=txtJOB_NM	   		Param=value		</C>
		<C>Col=ENO_NO   		Ctrl=txtENO_NO    		Param=value		</C>
		<C>Col=ENO_NM   		Ctrl=txtENO_NM    		Param=value		</C>
        <C>Col=BUT_FR_YMD       Ctrl=txtBUT_FR_YMD  	Param=value 	</C>
        <C>Col=BUT_TO_YMD       Ctrl=txtBUT_TO_YMD  	Param=value 	</C>
        <C>Col=PC_CCTRCD        Ctrl=txtPC_CCTRCD  		Param=value 	</C>
        <C>Col=PC_CCTRNM        Ctrl=txtPC_CCTRNM  		Param=value 	</C>
        <C>Col=PC_GBN           Ctrl=txtPC_GBN  		Param=value 	</C>
        <C>Col=SLEEP_DAY        Ctrl=txtSLEEP_DAY  	    Param=value 	</C>
        <C>Col=BUT_DAY          Ctrl=txtBUT_DAY  	    Param=value 	</C>
        <C>Col=BUT_NAT          Ctrl=cmbBUT_NAT  	    Param=value 	</C>
        <C>Col=BUT_CITY         Ctrl=txtBUT_CITY  	    Param=value 	</C>
        <C>Col=BUT_OBJ          Ctrl=txtBUT_OBJ  	    Param=value 	</C>
        <C>Col=BUT_AFF          Ctrl=txtBUT_AFF  	    Param=value 	</C>
        <C>Col=VISA_YN          Ctrl=cmbVISA_YN  	    Param=value 	</C>
        <C>Col=PASS_YN          Ctrl=cmbPASS_YN  	    Param=value 	</C>
        <C>Col=EXT_RATE         Ctrl=txtEXT_RATE  	    Param=value 	</C>
        <C>Col=BUT_EXPENSE      Ctrl=txtBUT_EXPENSE     Param=Text 	</C>
        <C>Col=BUT_SUM          Ctrl=txtBUT_SUM         Param=Text 	</C>
        <C>Col=BUT_LODGING      Ctrl=txtBUT_LODGING     Param=Text 	</C>
        <C>Col=BUT_AMT          Ctrl=txtBUT_AMT         Param=Text </C>
        <C>Col=CURRENCY_NM      Ctrl=txtCURRENCY_NM     Param=value		</C>
		<C>Col=BUT_GBN          Ctrl=cmbBUT_GBN         Param=value		</C>
    '>
</object>

