<!--
*****************************************************
* @source       : butc020.jsp
* @description  : �İ�ǰ�Ǽ��ۼ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2010/02/04      ������        �����ۼ�
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

    //���缱����� ���� ����
    if(eno_no == null){
    	eno_no = (String)request.getSession().getAttribute("SESSION_ENONO");
    }

	//System.out.println("ord_no [" + ord_no + "]");
	//System.out.println("eno_no [" + eno_no + "]");
	//System.out.println("app_status [" + app_status + "]");
	//System.out.println("app_cmt [" + app_cmt + "]");

%>

<html>
<head>
<title>�İ�ǰ�Ǽ�(butc020)</title>
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
		var obj = new String();
		obj.app_cmt = "";
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            if(dsTemp != "Modal"){
                trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
                trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_03&ORD_NO="+dsT_DI_DISPATCH.NameValue(1,"ORD_NO")+"&ENO_NO="+dsT_DI_DISPATCH.NameValue(1,"ENO_NO");
                trT_DI_DISPATCH_SHR.post();
            }else{
	        	trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_03&ORD_NO=<%=ord_no%>&ENO_NO=<%=eno_no%>";
				trT_DI_DISPATCH_SHR.post();
			}

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //ǰ�ǹ�ȣ ��ȸ
            dsORD_NO.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_01";
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

			trT_DI_DISPATCH.KeyValue = "tr(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SAV_01&ORD_NO="+ord_no;
			trT_DI_DISPATCH.post();

            if(msgFlag == "Y"){

			   if(dsT_DI_DISPATCH.NameValue(1,"DIS_PAY_YN") == "Y"){
				   alert("����Ǿ����ϴ�. �İߺ��꼭�� Ȯ���Ͻð� ����ϼ���.");
			   }else{
				   document.getElementById("btn_appre").style.display = "";//��ź��̰�
				   alert("����Ǿ����ϴ�. ����ϼ���.");
			   }
       		}
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

        	var ord_no = dsT_DI_DISPATCH.NameValue(1,"ORD_NO");

 	        var url = "butc020_PV.jsp?ORD_NO="+ord_no+"&ENO_NO="+'<%=eno_no%>'+"&DPT_CD=" + '<%=box.get("SESSION_DPTCD")%>';
   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
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
        function fnc_Append() {

            var DPT_CD = document.getElementById("txtDPT_CD").value;
			var EMP_NO =  document.getElementById("txtENO_NO").value;

            //ds�� ���Ϲ޴´�.
            dsT_DI_APPROVAL.DeleteAll();
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "D");

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();
            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
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
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "D";
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
	        document.getElementById("btn_trbfee").style.display = "none";

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtDIS_FR_YMD").focus();

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
            var dis_fr_ymd = document.getElementById("txtDIS_FR_YMD");
            var dis_to_ymd = document.getElementById("txtDIS_TO_YMD");
            var dis_city = document.getElementById("cmbDIS_CITY");
            var dis_gun = document.getElementById("txtDIS_GUN");
            var dis_obj = document.getElementById("txtDIS_OBJ");


			//alert("dsTemp : "+dsTemp+",    status : "+status);
            if(dsTemp == "Modal" && (status != "1" && status != "5")) return;//�˾��� ���

			if (!dsT_DI_DISPATCH.IsUpdated && !dsT_DI_APPROVAL.IsUpdated ) {
                //alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

            if(dsT_DI_APPROVAL.CountRow < 4){
                alert("���缱�� �����ϼž� �մϴ�!");
                return false;
            }

            if(dis_fr_ymd.value == ""){
                alert("�İ� �������� �Է��ϼ���!");
                dis_fr_ymd.focus();
                return false;
            }
			if(!fnc_Auto_DisPayYn()){
				return false;
			}
            if(dis_to_ymd.value == ""){
                alert("�İ� �������� �Է��ϼ���!");
                dis_to_ymd.focus();
                return false;
            }

            if(dis_city.value == ""){
                alert("�İ����� �Է��ϼ���!");
                dis_city.focus();
                return false;
            }
            if(dis_obj.value == ""){
                alert("�İ߸����� �Է��ϼ���!");
                but_obj.focus();
                return false;
            }
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
			// ��������
			for( var i = 1; i <= dsT_CM_COMMON_Z4.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_Z4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_Z4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbDIS_CITY").add(oOption);
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
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";
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
										"DIS_FR_YMD:STRING, "+	// �İ߽�����
										"DIS_TO_YMD:STRING, "+	// �İ�������
										"SLEEP_DAY:STRING, "+	// ��
										"DIS_DAY:STRING, "+		// ��
										"DIS_PAY_YN:STRING, "+	// �İߺ����޿���
										"DIS_CITY:STRING, "+	// �İ�����
										"DIS_GUN:STRING, "+		// �ٹ���
										"DIS_OBJ:STRING,"+		// �İ߸���
										"DIS_AFF:STRING,"+		// �İ�ȿ��
										"APP_CMT:STRING,"+		// �����ǰ�
										"APP_STATUS:STRING,"+	// �������
										"APP_ENO_NO:STRING,"+	// ����ڻ��
										"APP_JOB_CD:STRING");	// ���������

			// �����ͼ��� ��� ���� ����.
			dsT_DI_BUDGET.setDataHeader(
										"ENO_NO:STRING, "+		// ���
										"DIS_FR_YMD:STRING");	// �İ߽�����


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
			fnc_AutoApproval(0);
			//������ĸ� �μⰡ ���δ�.
            //document.getElementById("imgPrint").style.display = "none";
            document.getElementById("cmbDIS_PAY_YN").readOnly = true;

		}
		function fnc_AutoApproval(appNumParam){
			var appNum = appNumParam + 1;
			var obj    = new String;
            //���� ���������� ���� �����ͼ¿� ������� �⺻���� Setting(ǰ�ǹ�ȣ,�����������)
			for(var i = appNum; i<=appNum+2; i++) {
				dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = "9"+i;
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "D";
				if (i == appNum) {
	            		obj = fnc_GetCommonEnoObj("1990025");
	            } else if (i == appNum + 1) {
	            		obj = fnc_GetCommonEnoObj("1990105");
				} else if (i == appNum + 2) {
	            		obj = fnc_GetCommonEnoObj("2100001");
	            }
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = '<%=box.get("SESSION_ENONO")%>';
	            dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("txtORD_NO").value;
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
                document.getElementById("txtDIS_DAY").value = sleep_day+1;
				fnc_Auto_DisPayYn();
            }
        }
		function fnc_Auto_DisPayYn(){
			var disDay = document.getElementById("txtDIS_DAY").value;
			if(disDay < 30){
				alert("�İ߱Ⱓ�� 30�� �̸��� ��������ǰ�Ǹ� �̿��Ͻñ� �ٶ��ϴ�");
				return false;
			}else{
				return true;
			}
		}
		function fnc_Auto_DisPayYn2(){
			var disCity = document.getElementById("cmbDIS_CITY").value;
			var ORD_NO  = document.getElementById("txtORD_NO").value;

			if(ORD_NO == "20100705003"){
				document.getElementById("cmbDIS_PAY_YN").value = "Y"
				return true;
			}

			if(disCity == "01" || disCity == "04" || disCity == "08"){
				document.getElementById("cmbDIS_PAY_YN").value = "N";
				alert("����/���/��õ ������ �İߺ� ���޵��� �ʽ��ϴ�");
			}else{
				document.getElementById("cmbDIS_PAY_YN").value = "Y"
			}



		}
        /***************************
         * 18. �Է¶� Disabledó�� *
         ***************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDIS_FR_YMD").className = "input_ReadOnly";
            document.getElementById("txtDIS_FR_YMD").readOnly = true;
            document.getElementById("txtDIS_TO_YMD").className = "input_ReadOnly";
            document.getElementById("txtDIS_TO_YMD").readOnly = true;
            document.getElementById("cmbDIS_CITY").className = "input_ReadOnly";
            document.getElementById("cmbDIS_CITY").disabled = true;
            document.getElementById("txtDIS_OBJ").className = "input_ReadOnly";
            document.getElementById("txtDIS_OBJ").readOnly = true;
            document.getElementById("txtDIS_AFF").className = "input_ReadOnly";
            document.getElementById("txtDIS_AFF").readOnly = true;

            //���缱 ����, ���� ��ư
            document.getElementById("btn_InsDel").style.display = "none";

        }

        function fnc_InputEnable() {
            document.getElementById("txtDIS_FR_YMD").className = "";
            document.getElementById("txtDIS_FR_YMD").readOnly = false;
            document.getElementById("txtDIS_TO_YMD").className = "";
            document.getElementById("txtDIS_TO_YMD").readOnly = false;
            document.getElementById("cmbDIS_CITY").className = "";
            document.getElementById("cmbDIS_CITY").disabled = false;
            document.getElementById("txtDIS_OBJ").className = "";
            document.getElementById("txtDIS_OBJ").readOnly = false;
            document.getElementById("txtDIS_AFF").className = "";
            document.getElementById("txtDIS_AFF").readOnly = false;
            //���缱 ����, ���� ��ư
            document.getElementById("btn_InsDel").style.display = "";

        }

        /*************************
         * 19. ���, ���� ó��   *
         *************************/
		function fnc_SubmitApproval(kind) {
            //���ó���� ������ �������� Ȯ��
            if (dsT_DI_DISPATCH.IsUpdated) {
                alert("ǰ�Ǽ� ������ ����Ǿ����ϴ�. ������ �İߺ� �ٽ� Ȯ�����ּ���.");
                return false;
            }
            if(dsT_DI_APPROVAL.IsUpdated && kind == "���") {
                alert("���缱�� ����Ǿ����ϴ�. �ٽ� �������ּ���.");
                return false;
            }
            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;
            var app_eno_no = "<%=eno_no%>";
			var app_status = "";

            if(kind == "���"){
                app_status = "2";
				app_eno_no = '<%=box.getString("SESSION_ENONO")%>';
            }
             else if(kind == "����"){
                app_status = "3";
			}

		//	if(obj.app_cmt != ""){
		//		dsT_DI_DISPATCH.NameValue(1, "APP_CMT") = obj.app_cmt;
		//	}

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
				kind = "����Ϸ�";
                app_status = "4";
				alert("�����������̹Ƿ� ���¹ݿ����� �ð��� �ټ� �ɸ��ϴ�.");
			}
			dsT_DI_DISPATCH.NameValue(1,"APP_CMT") = obj.app_cmt;
			var paramURL = "cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SAV_02&APP_CMT="+kind+"&APP_STATUS="+app_status+"&APP_ENO_NO="+app_eno_no;
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
            //document.getElementById("imgPrint").style.display = "";//�μ⺸�̰�
        }

        /*************************
         * 20. ���� ���         *
         *************************/
		function fnc_Calcul_Basis() {
            window.showModalDialog("/hr/but/butc021.jsp?STATUS="+status, dsT_DI_DISPATCH, "dialogWidth:750px; dialogHeight:480px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            //alert(dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") + " - " + status + " - " + dsT_DI_DISPATCH.NameValue(1,"ENO_NO") + " - " + '<%=box.get("SESSION_ENONO")%>');
            if(dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") == "1" && status == "1" && dsT_DI_DISPATCH.NameValue(1,"ENO_NO") == '<%=box.get("SESSION_ENONO")%>'){
                status = "1";
                //��Ź�ư Show
                document.getElementById("btn_appre").style.display = "";
            }
        }

        /*************************
         * 21. �˾��� ��� ó��  *
         *************************/
		function fnc_OnLoadPop() {

            status = "<%=app_status%>";
            fnc_SearchList(); //�ش� ����ǰ�Ǽ� ��ȸ

			//�ݼ۵Ȱ��� ����ڰ� ���� ����
            if(("<%=app_cmt%>").substring(0,2) == "�ݼ�" && dsT_DI_DISPATCH.NameValue(1,"ENO_NO") == '<%=box.get("SESSION_ENONO")%>'){
	            status = "1";   //���� ���·�
	            //document.getElementById("btn_appre").style.display = "";
  			//����̳� ����Ȱ��� ���ʿ��ư �ʺ��̰��Ѵ�.
            }else if("<%=app_cmt%>" != "����"){
            	document.getElementById("imgSave").style.display = "none";
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
			//�����꼭 ���̰��ϱ�...
			if(dsT_DI_DISPATCH.NameValue(1,"DIS_PAY_YN") == "Y"){
				document.getElementById("btn_trbfee").style.display = "";
			}else{
				document.getElementById("btn_trbfee").style.display = "none";
			}
            if("<%=app_status%>" == "2" || "<%=app_status%>" == "3" ){
                for(var i= 0; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//������
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//���翩��

			            //�ش� ������ �ǰ��Է� �غ�.
					if(eno_no == '<%=box.get("SESSION_ENONO")%>' &&  app_yn == "R" ){
						document.getElementById("btn_approval").style.display = "";
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
						break;
					}
                }
            }else{
            			document.getElementById("btn_approval").style.display = "none";
            			document.getElementById("resultMessage").innerText = '* �̹� ���� ó���Ϸ� �Ǿ����ϴ�. ��ȸ�� �����մϴ�. ';

            }

        }

        /*****************************************
         * 22. �����Է��˾�(�ΰ�, �ݼ�ó��)      *
         ****************************************/
		function fnc_SubmitCancle(kind) {

            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;


			var app_yn = "";
			if(obj.app_cmt == ""){
            	window.showModalDialog("/hr/but/butc023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			}
            if(obj.app_cmt != ""){
				if(kind == "�ΰ�"){
					app_yn = "N";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "6";
				}else{//�ݼ�
					app_yn = "E";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "5";
				}
                dsT_DI_DISPATCH.NameValue(1,"APP_CMT") = obj.app_cmt;
                trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
                trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SAV_03&APP_CMT="+kind+"&APP_YN="+app_yn;
                trT_DI_DISPATCH.post();

                document.getElementById("btn_approval").style.display = "none";
            }else{
                    alert("�ΰ� �Ǵ� �ݼۻ����� �Է��� ó���ٶ��ϴ�.\n \n�۾��� ��ҵǾ����ϴ�.");
	                return false;
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

    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Z4"/>
       <jsp:param name="CODE_GUBUN"    value="Z4"/>
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

        }

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
		if(dsT_DI_DISPATCH.NameValue(1,"DIS_PAY_YN") == "Y" ){
			document.getElementById("btn_trbfee").style.display = "";
		}else{
			document.getElementById("btn_trbfee").style.display = "none";
		}
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
    <script for=trT_DI_BUDGET_SHR event="OnSuccess()">
		document.getElementById("txtBUDGET_AMT").value = dsT_DI_BUDGET_RESULT.NameValue(1,"BUDGET_AMT");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUDGET_SHR event="OnFail()">
        cfErrorMsg(this);
    </script>
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

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�İ�ǰ�Ǽ�</td>
					<td align="right" class="navigator">HOME/���°���/�İ߰���/<font color="#000000">�İ�ǰ�Ǽ�</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5" align="left" width="400" height="35" >
            <span id="btn_trbfee" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAccount','','/images/button/btn_DispatchOver.gif',1)"><img src="/images/button/btn_DispatchOn.gif" name="imgAccount" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Calcul_Basis();"></a>
            </span>
            <span id="btn_appre" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)"><img src="/images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('���');"></a>
            </span>

		</td>
		<td class="paddingTop5" align="right" width="400" height="35" >
            <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('����');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('�ΰ�');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSendback','','/images/button/btn_SendbackOver.gif',1)"><img src="/images/button/btn_SendbackOn.gif" name="imgSendback" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('�ݼ�');"></a>
            </span>
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
								<td align="center" class="creamBold">�İ���</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
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
        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:560px;height:108px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='SEQ_NO'		width=40	name='NO'		align=center	show=false</C>
								<C> id='ENO_NO'		width=100	name='���'		align=center	show=false</C>
								<C> id='SEQ_NM'		width=50	name='����'		align=center	Value={IF (SEQ_NO > '90','����', '����')}</C>
								<C> id='ENO_NM'		width=70	name='������'	align=center</C>
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
                <tr>
                    <td align="right">
                        &nbsp;<span id="btn_InsDel">
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
        		              </span>
		            </td>
		       </tr>
            </table>
            <!-- ���缱 ���� ���̺� �� -->
        </td>
    </tr>
</table>

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<!--
				<colgroup>
					<col width="100"></col>
                    <col width="200"></col>
                    <col width="100"></col>
					<col width="**"></col>
				</colgroup>
				-->
				<tr>
					<td width="100" align="center" class="creamBold">�İ߱Ⱓ</td>
					<td width="350" class="padding2423">
						<input id="txtDIS_FR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtDIS_FR_YMD','txtDIS_FR_YMD','txtDIS_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtDIS_FR_YMD','txtDIS_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtDIS_FR_YMD.readOnly == true) return; calendarBtn('datetype1','txtDIS_FR_YMD','','40','235');"></a>
                        <input id="txtDIS_TO_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtDIS_TO_YMD','txtDIS_FR_YMD','txtDIS_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtDIS_FR_YMD','txtDIS_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtDIS_TO_YMD.readOnly == true) return; calendarBtn('datetype1','txtDIS_TO_YMD','','300','235');"></a>
						(<input id="txtSLEEP_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>��
                        <input id="txtDIS_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>�� )
                    </td>
					<td width="100" align="center" class="creamBold">�İߺ�</td>
                    <td class="padding2423" >
						<select id="cmbDIS_PAY_YN" name="cmbDIS_PAY_YN" style="width:85" disabled>
                            <option value="Y">����</option>
                            <option value="N">������</option>
                        </select>

					</td>
                </tr>
				<tr>
					<td align="center" class="creamBold">�İ�����</td>
					<td class="padding2423">
						<select id="cmbDIS_CITY" style="width='100';" onChange="fnc_Auto_DisPayYn2()">
						</select>
                    </td>
					<td align="center" class="creamBold">�ٹ���</td>
                    <td class="padding2423" >
						<input id="txtDIS_GUN" size="40" maxlength="25">
					</td>
                </tr>
                <tr>
					<td align="center" class="creamBold">�İ߸���</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtDIS_OBJ"  onKeyUp="fc_chk_byte(this,200)"  cols=110  rows=3 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">�İ�ȿ��</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtDIS_AFF"  onKeyUp="fc_chk_byte(this,200)" cols=110  rows=3 >
						</textarea>
					</td>
				</tr>

				<!-- ���̺������� ���Ͽ� ������ �� �±�(����� colgroup��ŭ td���־�� ���̺� ����� ��׷����� �ʴ´�.) -->
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
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
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->
                <!-- ���� ������ �� �±׷� ���Ͽ� ���� �β��� ���̴°��� �����ϱ����Ͽ� ����� #FFFFFF�� �ٲپ� �ش� ������ ������.-->
                <div style="position:absolute; left:20; top:585; width:800; height:1; z-index:2;" >
                    <table bgcolor="#FFFFFF" width="800"><tr><td></td></tr></table>
                </div>

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
        <C>Col=DIS_FR_YMD       Ctrl=txtDIS_FR_YMD  	Param=value 	</C>
        <C>Col=DIS_TO_YMD       Ctrl=txtDIS_TO_YMD  	Param=value 	</C>
		<C>Col=DIS_PAY_YN       Ctrl=cmbDIS_PAY_YN  	Param=value 	</C>
        <C>Col=SLEEP_DAY        Ctrl=txtSLEEP_DAY  	    Param=value 	</C>
        <C>Col=DIS_DAY          Ctrl=txtDIS_DAY  	    Param=value 	</C>
        <C>Col=DIS_CITY         Ctrl=cmbDIS_CITY  	    Param=value 	</C>
        <C>Col=DIS_GUN          Ctrl=txtDIS_GUN  	    Param=value 	</C>
        <C>Col=DIS_OBJ          Ctrl=txtDIS_OBJ  	    Param=value 	</C>
        <C>Col=DIS_AFF          Ctrl=txtDIS_AFF  	    Param=value 	</C>
    '>
</object>