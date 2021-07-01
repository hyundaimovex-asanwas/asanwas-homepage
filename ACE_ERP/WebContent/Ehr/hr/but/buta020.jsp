<!--
*****************************************************
* @source       : buta020.jsp
* @description  : ����ǰ�Ǽ��ۼ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<%
	String ord_no = request.getParameter("ORD_NO");         //ǰ�ǹ�ȣ
	String eno_no = request.getParameter("PENO_NO");         //ǰ���ڻ��
	String app_status = request.getParameter("APP_STATUS"); //�������
    String app_cmt = request.getParameter("APP_CMT");       //�������ǰ�
%>

<html>
<head>
<title>����ǰ�Ǽ�</title>
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

        var obj = new String();
        
		obj.app_cmt = "";

        var dsTemp = window.dialogArguments;

        var status = "";//���� ���� ����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if(dsTemp != "Modal"){
            	
                trT_DI_BUSINESSTRIP.KeyValue = "tr(O:dsT_DI_BUSINESSTRIP=dsT_DI_BUSINESSTRIP, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
                trT_DI_BUSINESSTRIP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SHR_03&ORD_NO="+dsT_DI_BUSINESSTRIP.NameValue(1,"ORD_NO")+"&ENO_NO="+dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO");
                trT_DI_BUSINESSTRIP.post();
                
            }else{
            	
	        	trT_DI_BUSINESSTRIP.KeyValue = "tr(O:dsT_DI_BUSINESSTRIP=dsT_DI_BUSINESSTRIP, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_BUSINESSTRIP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SHR_03&ORD_NO=<%=ord_no%>&ENO_NO=<%=eno_no%>";
				trT_DI_BUSINESSTRIP.post();
				
			}

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //ǰ�ǹ�ȣ ��ȸ
            dsORD_NO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SHR_01";
			dsORD_NO.reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;


            var but_fr_ymd = document.getElementById("txtBUT_FR_YMD").value;
            var but_to_ymd = document.getElementById("txtBUT_TO_YMD").value;			
			
			fnc_Auto_Input(but_fr_ymd,but_to_ymd);
			
            //ǰ�ǹ�ȣ ����
            if(document.getElementById("txtORD_NO").value.trim() == ""){
				fnc_SearchItem();

				//���缱�� ǰ�ǹ�ȣ �Է�
	            for(i=1; i<=dsT_DI_APPROVAL.CountRow; i++){
					dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = dsT_DI_BUSINESSTRIP.NameValue(1,"ORD_NO");
	            }
            }

            var ord_no = dsT_DI_BUSINESSTRIP.NameValue(1,"ORD_NO");
            var eno_no = dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO");
            var nam_kor = dsT_DI_BUSINESSTRIP.NameValue(1,"NAM_KOR");
            var dpt_cd = dsT_DI_BUSINESSTRIP.NameValue(1,"DPT_CD");
            var job_cd = dsT_DI_BUSINESSTRIP.NameValue(1,"JOB_CD");

            var msgFlag = "";
            if(dsT_DI_BUSINESSTRIP.IsUpdated == true){
                var msgFlag = "Y";
            }

			trT_DI_BUSINESSTRIP.KeyValue = "tr(I:dsT_DI_BUSINESSTRIP=dsT_DI_BUSINESSTRIP, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_BUSINESSTRIP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SAV_01&ORD_NO="+ord_no+"&ENO_NO="+eno_no+"&NAM_KOR="+nam_kor+"&DPT_CD="+dpt_cd+"&JOB_CD="+job_cd+"&APP_CMT=����";
			trT_DI_BUSINESSTRIP.post();

            status = "SV";

            if(msgFlag == "Y"){
               document.getElementById("btn_appre").style.display = "none";//��žʺ��̰�
       		   alert("����Ǿ����ϴ�. �����꼭�� Ȯ���ϼ���.");
       		}

        }



		function fnc_Save_Insa(){
            var ord_no = dsT_DI_BUSINESSTRIP.NameValue(1,"ORD_NO");
			trT_DI_BUSINESSTRIP.KeyValue = "tr(I:dsT_DI_BUSINESSTRIP=dsT_DI_BUSINESSTRIP)";
			trT_DI_BUSINESSTRIP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SAV_DATE&ORD_NO="+ord_no;
			trT_DI_BUSINESSTRIP.post();

		}

        /*****************
         * 03-1.���ó�� *
         ****************/
        function fnc_Conduct() {

			if(!fnc_SaveItemCheck()) return;

            var ord_no = dsT_DI_BUSINESSTRIP.NameValue(1,"ORD_NO");
            var eno_no = dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO");
            var nam_kor = dsT_DI_BUSINESSTRIP.NameValue(1,"NAM_KOR");
            var dpt_cd = dsT_DI_BUSINESSTRIP.NameValue(1,"DPT_CD");
            var job_cd = dsT_DI_BUSINESSTRIP.NameValue(1,"JOB_CD");

            dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
            dsT_DI_BUSINESSTRIP_STATE.AddRow();
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ORD_NO") = document.getElementById("txtORD_NO").value;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_STATUS") = "SA";
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_CMT") = "���";
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_YN") = null;

			dsT_DI_APPROVAL.UseChangeInfo = "false";

			trT_DI_BUSINESSTRIP.KeyValue = "tr(I:dsT_DI_BUSINESSTRIP=dsT_DI_BUSINESSTRIP,I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_BUSINESSTRIP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SAV_01_APP&ORD_NO="+ord_no+"&ENO_NO="+eno_no+"&NAM_KOR="+nam_kor+"&DPT_CD="+dpt_cd+"&JOB_CD="+job_cd+"&APP_CMT=���";
			trT_DI_BUSINESSTRIP.post();

			alert("����� �Ϸ�Ǿ����ϴ�.");
			
			window.close();
			
            fnc_InputDisabled();//�Է¶� disabled
                
            document.getElementById("btn_appre").style.display = "none";//��žʺ��̰�
                
	        document.getElementById("imgSave").style.display = "none";//���� �ʺ��̰�
	            
	        document.getElementById("btn_InsDel").style.display = "none"; //���缱 ����, ���� ��ư
	            
	        status = "SA";
	            
			fnc_SearchList();


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
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "B");

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
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "B";
				dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
            }
            fnc_AutoApproval(dsT_DI_APPROVAL.countrow);
        }

		function fnc_AutoApproval(appNumParam){
		
			
			var appNum = appNumParam + 1;
			var appNum_1YN = "N";
			var appNum_2YN = "N";
			var appNum_3YN = "N";
			var obj    = new String;

			 //���� ���������� ������ �ߺ� �˻�)
			for(var i = 1; i<=appNumParam; i++) {

				if (dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2030007") {
	            		appNum_1YN = "Y";
	            //} else if (dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2030007") {
	            //		appNum_2YN = "Y";
				} else if(dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2180001") {
	            		appNum_2YN = "Y";
	            }

			}
            //���� ���������� ���� �����ͼ¿� ������� �⺻���� Setting(ǰ�ǹ�ȣ,�����������)
			for(var i = appNum; i<=appNum+1; i++) {

				var r;

				if (i == appNum ) {

				       if (appNum_1YN == "Y" )  continue;
	            	   obj = fnc_GetCommonEnoObj_DH("2030007");
						r = "9";
	            //} else if (i == appNum + 1) {
                //
	            //       if (appNum_2YN == "Y" )  continue;
	            //		obj = fnc_GetCommonEnoObj_DH("2030007");
				//		r = "8";
				} else if (i == appNum + 1) {
					
				        if (appNum_3YN == "Y" )  continue;
	            		obj = fnc_GetCommonEnoObj_DH("2180001");
	            		r = "8";
	            }

				dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = "9"+r;;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_GBN") = "B";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"PENO_NO") = gusrid;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ORD_NO") = document.getElementById("txtORD_NO").value;
			}
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

			dsT_DI_BUSINESSTRIP.ClearData();
			dsT_DI_APPROVAL.ClearData();
            dsORD_NO.ClearData();
            dsT_DI_BUSINESSTRIP_BASIS.ClearData();
            dsT_DI_BUSINESSTRIP_STATE.ClearData();
            dsT_DI_APPROVAL.ClearData();

            fnc_InputEnable();

	        fnc_OnLoadProcess();

	        document.getElementById("imgSave").style.display = "";
	        document.getElementById("btn_trbfee").style.display = "none";

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtBUT_FR_YMD").focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

                if (dsT_DI_BUSINESSTRIP.IsUpdated)  {

                    if (!fnc_ExitQuestion()) return;

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
            var but_city = document.getElementById("txtBUT_CITY");
            var city_dpt = document.getElementById("txtCITY_DPT1");
            var city_arv = document.getElementById("txtCITY_ARV1");
            var city_gbn = document.getElementById("cmbCITY_GBN1");
            var but_obj = document.getElementById("txtBUT_OBJ");
            var pc_cctrcd = document.getElementById("txtPC_CCTRCD");
            var pc_gbn = document.getElementById("txtPC_GBN");
            var wbs_fr_ymd = document.getElementById("txtWBS_FR_YMD");
            var wbs_to_ymd = document.getElementById("txtWBS_TO_YMD");


            //if(dsTemp == "Modal" && status != "SV") return;//�˾��� ���

			if (!dsT_DI_BUSINESSTRIP.IsUpdated && !dsT_DI_APPROVAL.IsUpdated && !dsT_DI_BUSINESSTRIP_STATE) {
                alert("������ �ڷᰡ �����ϴ�.fnc_SaveItemCheck");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

           if(dsT_DI_APPROVAL.CountRow < 1){
               alert("���缱�� 1���̻� �����ϼž� �մϴ�! ���� �����Դϴ�.");
                return false;
            }

            if(but_fr_ymd.value == ""){
                alert("���� �������� �Է��ϼ���!");
                but_fr_ymd.focus();
                return false;
            }
            if(but_to_ymd.value == ""){
                alert("���� �������� �Է��ϼ���!");
                but_to_ymd.focus();
                return false;
            }

            if(document.getElementById("cmbBUT_GBN").value == "" ){
                alert("���������� �����ϼ���!");
                document.getElementById("cmbBUT_GBN").focus();
                return false;
            }
            if(document.getElementById("txtOFFER_GBN").value == "Y" && document.getElementById("cmbSTART_GBN").value == ""){
            	alert("������������ ��߱����� �����ϼ���!");
            	document.getElementById("cmbSTART_GBN").focus();
            	return false;
            }

            if(but_city.value == ""){
                alert("�������� �Է��ϼ���!");
                but_city.focus();
                return false;
            }
            if(city_dpt.value == ""){
                alert("������� �Է��ϼ���!");
                city_dpt.focus();
                return false;
            }
            if(city_arv.value == ""){
                alert("�������� �Է��ϼ���!");
                city_arv.focus();
                return false;
            }
            if(city_gbn.value == ""){
                alert("��������� �Է��ϼ���!");
                city_gbn.focus();
                return false;
            }
            if(but_obj.value == ""){
                alert("��������� �Է��ϼ���!");
                but_obj.focus();
                return false;
            }

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //if(dsTemp != "Modal"){

        	//alert("* �����û�� ���ǻ���\n\n1)���������� �ֱٹ���(����)�� ���� ������ ������ �ƴ϶� '�ܱ�'�� \n -> ����� ��û ���ʿ�(����� ����)\n\n2)��, �ܱ��� �Ұ����ϰ� �߽ĺ� �߻��ϴ� ��쿡 ���Ͽ� ����ǰ�Ǽ�\n  ���Ŀ� ��� ��û ����");

            //}


            //������� ��ȸ
            dsT_DI_BUSINESSTRIP_BASIS.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SHR_02";
            dsT_DI_BUSINESSTRIP_BASIS.reset();

            if(dsTemp != "Modal"){ //�˾��� �ƴѰ��
                fnc_BusinesstripInsert(); //ǰ�Ǽ� �ۼ��� ����
            }else{ //�˾��� ���
                fnc_OnLoadPop();
            }

            //�����Ҷ� �⺻����
            document.getElementById("cmbBUT_GBN").value = "2";

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����

			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
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

            dsT_DI_BUSINESSTRIP.ClearAll();
            
            dsT_DI_APPROVAL.ClearAll();

			// �����ͼ��� ��� ���� ����.
			dsT_DI_BUSINESSTRIP.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, NAM_KOR:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, BUT_FR_YMD:STRING, BUT_FR_GBN:STRING, BUT_TO_YMD:STRING, BUT_TO_GBN:STRING, SLEEP_DAY:STRING, BUT_DAY:STRING, BUT_CITY:STRING, CITY_DPT1:STRING, CITY_ARV1:STRING, CITY_GBN1:STRING, CITY_DPT2:STRING, CITY_ARV2:STRING, CITY_GBN2:STRING, CITY_DPT3:STRING, CITY_ARV3:STRING, CITY_GBN3:STRING, CITY_DPT4:STRING, CITY_ARV4:STRING, CITY_GBN4:STRING, CITY_DPT5:STRING, CITY_ARV5:STRING, CITY_GBN5:STRING, CITY_DPT6:STRING, CITY_ARV6:STRING, CITY_GBN6:STRING, CITY_DPT7:STRING, CITY_ARV7:STRING, CITY_GBN7:STRING, CITY_DPT8:STRING, CITY_ARV8:STRING, CITY_GBN8:STRING, BUT_OBJ:STRING, BUT_ADDR:STRING, BUT_NAME:STRING, BUT_PHONE:STRING, REMARK:STRING, COM_YN:STRING, COM_CNT:STRING, COM_CD1:STRING, COM_NM1:STRING, COM_NO1:STRING, COM_NAM1:STRING, COM_CD2:STRING, COM_NM2:STRING, COM_NO2:STRING, COM_NAM2:STRING, COM_CD3:STRING, COM_NM3:STRING, COM_NO3:STRING, COM_NAM3:STRING, COM_CD4:STRING, COM_NM4:STRING, COM_NO4:STRING, COM_NAM4:STRING, COM_CD5:STRING, COM_NM5:STRING, COM_NO5:STRING, COM_NAM5:STRING, APP_CMT:STRING, BASIS_YN:STRING, OFFER_GBN:STRING,START_GBN:STRING,BUT_AFF:STRING,BUT_GBN:STRING,PC_GBN:STRING,PC_CCTRCD:STRING,PC_CCTRNM:STRING");

            dsT_DI_BUSINESSTRIP.AddRow();

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


            //ǰ�ǹ�ȣ ��ȸ
            dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SHR_PER";
            dsT_CM_PERSON.reset();
			
            dsT_DI_BUSINESSTRIP.NameValue(1,"DPT_CD") = dsT_CM_PERSON.NameValue(1,"DPT_CD");
            dsT_DI_BUSINESSTRIP.NameValue(1,"DPT_NM") = dsT_CM_PERSON.NameValue(1,"DPT_NM");     
            dsT_DI_BUSINESSTRIP.NameValue(1,"JOB_CD") = dsT_CM_PERSON.NameValue(1,"JOB_CD");
            dsT_DI_BUSINESSTRIP.NameValue(1,"JOB_NM") = dsT_CM_PERSON.NameValue(1,"JOB_NM");     
            dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO") = gusrid;
            dsT_DI_BUSINESSTRIP.NameValue(1,"NAM_KOR") = gusrnm;


            //���� ���������� ���� �����ͼ¿� ������� �⺻���� Setting(ǰ�ǹ�ȣ,�����������)
            dsT_DI_APPROVAL.NameValue(1,"ORD_NO") = document.getElementById("txtORD_NO").value;
            dsT_DI_APPROVAL.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_APPROVAL.NameValue(1,"NAM_KOR") = document.getElementById("txtNAM_KOR").value;
            dsT_DI_APPROVAL.NameValue(1,"DPT_CD") = document.getElementById("txtDPT_CD").value;
            dsT_DI_APPROVAL.NameValue(1,"DPT_NM") = document.getElementById("txtDPT_NM").value;
            dsT_DI_APPROVAL.NameValue(1,"JOB_CD") = document.getElementById("txtJOB_CD").value;
            dsT_DI_APPROVAL.NameValue(1,"JOB_NM") = document.getElementById("txtJOB_NM").value;
            dsT_DI_APPROVAL.NameValue(1,"AUTHO_CD") = "A1";

            //���� ������Ʈ �⺻ ����
            document.form1.rdoBUT_FR_GBN.CodeValue = "A";
            document.form1.rdoBUT_TO_GBN.CodeValue = "P";
            document.getElementById("hidCOM_YN").value = "N";


			//������������ �⺻����
			fnc_OFFER_GBN();


		}

		/*************************
         * 17. �����ϼ� �ڵ���� *
         *************************/
		function fnc_Auto_Input(str_ymd, end_ymd) {           
            
            var str = document.getElementById("txtBUT_FR_YMD").value.split("-");
            var end = document.getElementById("txtBUT_TO_YMD").value.split("-");
            var str_date;
            var end_date;
            var sleep_day;


            if(document.getElementById("txtBUT_FR_YMD").value != "" && document.getElementById("txtBUT_TO_YMD").value != ""){

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
            document.getElementById("chkOFFER_GBN").disabled = true;
            document.getElementById("cmbSTART_GBN").disabled = true;
            document.getElementById("cmbBUT_GBN").disabled = true;
            document.getElementById("txtBUT_CITY").className = "input_ReadOnly";
            document.getElementById("txtBUT_CITY").readOnly = true;
            document.getElementById("txtCITY_DPT1").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT1").readOnly = true;
            document.getElementById("txtCITY_ARV1").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV1").readOnly = true;
            document.getElementById("cmbCITY_GBN1").disabled = true;
            document.getElementById("txtCITY_DPT2").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT2").readOnly = true;
            document.getElementById("txtCITY_ARV2").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV2").readOnly = true;
            document.getElementById("cmbCITY_GBN2").disabled = true;
            document.getElementById("txtCITY_DPT3").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT3").readOnly = true;
            document.getElementById("txtCITY_ARV3").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV3").readOnly = true;
            document.getElementById("cmbCITY_GBN3").disabled = true;
            document.getElementById("txtCITY_DPT4").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT4").readOnly = true;
            document.getElementById("txtCITY_ARV4").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV4").readOnly = true;
            document.getElementById("cmbCITY_GBN4").disabled = true;
            document.getElementById("txtCITY_DPT5").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT5").readOnly = true;
            document.getElementById("txtCITY_ARV5").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV5").readOnly = true;
            document.getElementById("cmbCITY_GBN5").disabled = true;
            document.getElementById("txtCITY_DPT6").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT6").readOnly = true;
            document.getElementById("txtCITY_ARV6").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV6").readOnly = true;
            document.getElementById("cmbCITY_GBN6").disabled = true;
            document.getElementById("txtCITY_DPT7").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT7").readOnly = true;
            document.getElementById("txtCITY_ARV7").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV7").readOnly = true;
            document.getElementById("cmbCITY_GBN7").disabled = true;
            document.getElementById("txtCITY_DPT8").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT8").readOnly = true;
            document.getElementById("txtCITY_ARV8").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV8").readOnly = true;
            document.getElementById("cmbCITY_GBN8").disabled = true;
            document.getElementById("txtBUT_OBJ").className = "input_ReadOnly";
            document.getElementById("txtBUT_OBJ").readOnly = true;
            document.getElementById("txtBUT_AFF").className = "input_ReadOnly";
            document.getElementById("txtBUT_AFF").readOnly = true;
            document.getElementById("txtBUT_ADDR").className = "input_ReadOnly";
            document.getElementById("txtBUT_ADDR").readOnly = true;
            document.getElementById("txtBUT_NAME").className = "input_ReadOnly";
            document.getElementById("txtBUT_NAME").readOnly = true;
            document.getElementById("txtBUT_PHONE").className = "input_ReadOnly";
            document.getElementById("txtBUT_PHONE").readOnly = true;
            document.getElementById("txtREMARK").className = "input_ReadOnly";
            document.getElementById("txtREMARK").readOnly = true;
            document.form1.rdoBUT_FR_GBN.Enable = "false";
            document.form1.rdoBUT_TO_GBN.Enable = "false";
            document.getElementById("radio1").disabled = true;
            document.getElementById("radio2").disabled = true;

            //���缱 ����, ���� ��ư
            document.getElementById("btn_InsDel").style.display = "none";

        }

        function fnc_InputEnable() {
            document.getElementById("txtBUT_FR_YMD").className = "";
            document.getElementById("txtBUT_FR_YMD").readOnly = false;
            document.getElementById("txtBUT_TO_YMD").className = "";
            document.getElementById("txtBUT_TO_YMD").readOnly = false;
            document.getElementById("chkOFFER_GBN").disabled = false;
            document.getElementById("cmbSTART_GBN").disabled = false;
            document.getElementById("cmbBUT_GBN").disabled = false;
            document.getElementById("txtBUT_CITY").className = "";
            document.getElementById("txtBUT_CITY").readOnly = false;
            document.getElementById("txtCITY_DPT1").className = "";
            document.getElementById("txtCITY_DPT1").readOnly = false;
            document.getElementById("txtCITY_ARV1").className = "";
            document.getElementById("txtCITY_ARV1").readOnly = false;
            document.getElementById("cmbCITY_GBN1").disabled = false;
            document.getElementById("txtCITY_DPT2").className = "";
            document.getElementById("txtCITY_DPT2").readOnly = false;
            document.getElementById("txtCITY_ARV2").className = "";
            document.getElementById("txtCITY_ARV2").readOnly = false;
            document.getElementById("cmbCITY_GBN2").disabled = false;
            document.getElementById("txtCITY_DPT3").className = "";
            document.getElementById("txtCITY_DPT3").readOnly = false;
            document.getElementById("txtCITY_ARV3").className = "";
            document.getElementById("txtCITY_ARV3").readOnly = false;
            document.getElementById("cmbCITY_GBN3").disabled = false;
            document.getElementById("txtCITY_DPT4").className = "";
            document.getElementById("txtCITY_DPT4").readOnly = false;
            document.getElementById("txtCITY_ARV4").className = "";
            document.getElementById("txtCITY_ARV4").readOnly = false;
            document.getElementById("cmbCITY_GBN4").disabled = false;
            document.getElementById("txtCITY_DPT5").className = "";
            document.getElementById("txtCITY_DPT5").readOnly = false;
            document.getElementById("txtCITY_ARV5").className = "";
            document.getElementById("txtCITY_ARV5").readOnly = false;
            document.getElementById("cmbCITY_GBN5").disabled = false;
            document.getElementById("txtCITY_DPT6").className = "";
            document.getElementById("txtCITY_DPT6").readOnly = false;
            document.getElementById("txtCITY_ARV6").className = "";
            document.getElementById("txtCITY_ARV6").readOnly = false;
            document.getElementById("cmbCITY_GBN6").disabled = false;
            document.getElementById("txtCITY_DPT7").className = "";
            document.getElementById("txtCITY_DPT7").readOnly = false;
            document.getElementById("txtCITY_ARV7").className = "";
            document.getElementById("txtCITY_ARV7").readOnly = false;
            document.getElementById("cmbCITY_GBN7").disabled = false;
            document.getElementById("txtCITY_DPT8").className = "";
            document.getElementById("txtCITY_DPT8").readOnly = false;
            document.getElementById("txtCITY_ARV8").className = "";
            document.getElementById("txtCITY_ARV8").readOnly = false;
            document.getElementById("cmbCITY_GBN8").disabled = false;
            document.getElementById("txtBUT_OBJ").className = "";
            document.getElementById("txtBUT_OBJ").readOnly = false;
            document.getElementById("txtBUT_AFF").className = "";
            document.getElementById("txtBUT_AFF").readOnly = false;
            document.getElementById("txtBUT_ADDR").className = "";
            document.getElementById("txtBUT_ADDR").readOnly = false;
            document.getElementById("txtBUT_NAME").className = "";
            document.getElementById("txtBUT_NAME").readOnly = false;
            document.getElementById("txtBUT_PHONE").className = "";
            document.getElementById("txtBUT_PHONE").readOnly = false;
            document.getElementById("txtREMARK").className = "";
            document.getElementById("txtREMARK").readOnly = false;
            document.form1.rdoBUT_FR_GBN.Enable = "true";
            document.form1.rdoBUT_TO_GBN.Enable = "true";
            document.getElementById("radio1").disabled = false;
            document.getElementById("radio2").disabled = false;

            //���缱 ����, ���� ��ư
            document.getElementById("btn_InsDel").style.display = "";

        }

        /*************************
         * 19. ���, ���� ó��   *
         *************************/
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;


            var app_yn = "";    //����ϷῩ��

            if(kind == "���"){
                fnc_InputDisabled();//�Է¶� disabled
                document.getElementById("btn_appre").style.display = "none";//��žʺ��̰�  ===>  ���� ���
                status = "A1";
                return false;

            }else if(kind == "����"){
                app_yn = "Y";
            }else if(kind == "�ΰ�" || kind == "�ݼ�"){

				if(obj.app_cmt == ""){
          			window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
          	    }

	            if(obj.app_cmt != ""){
					app_yn = "N";
		            if(kind == "�ΰ�") {
		            	app_yn = "N";

		            }else if(kind == "�ݼ�") {
		            	app_yn = "E";
		            }
	            }else{
                    alert("�ΰ� �Ǵ� �ݼۻ����� �Է��� ó���ٶ��ϴ�.\n \n�۾��� ��ҵǾ����ϴ�.");
	                return false;
            	}

            }

            dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
            dsT_DI_BUSINESSTRIP_STATE.AddRow();
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ORD_NO") = document.getElementById("txtORD_NO").value;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_STATUS") = status;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_CMT") = obj.app_cmt;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_YN") = app_yn;


            trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE )";
			trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SAV_02";
			trT_DI_BUSINESSTRIP_STATE.post();

            if(status == "SV"){//��������
                fnc_InputDisabled();//�Է¶� disabled
                document.getElementById("btn_appre").style.display = "none";//��žʺ��̰�
                status = "A1";
            }else{
                document.getElementById("btn_approval").style.display = "none";//�����ư�� �ʺ��̰�
            }

            document.getElementById("imgSave").style.display = "none";//���� �ʺ��̰�

            window.close();
            

        }

        /*****************************************
         * 22. �����Է��˾�(�ΰ�, �ݼ�ó��)      *
         ****************************************/
		function fnc_SubmitCancle(kind) {

            var obj = new String();

            window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != undefined){

                dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, KIND:STRING, APP_YN:STRING");
                dsT_DI_BUSINESSTRIP_STATE.AddRow();
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ORD_NO") = document.getElementById("txtORD_NO").value;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_STATUS") = status;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_CMT") = kind+"ó��-"+obj.app_cmt;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"KIND") = kind;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_YN") = "N";

                trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE)";
                trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta020.cmd.BUTA020CMD&S_MODE=SAV_03";
                trT_DI_BUSINESSTRIP_STATE.post();

                document.getElementById("btn_approval").style.display = "none";

            }

        }

        /*************************
         * 20. ���� ���         *
         *************************/
		function fnc_Calcul_Basis() {

            if(document.getElementById("txtOFFER_GBN").value == "Y" && document.getElementById("cmbSTART_GBN").value == ""){
                alert("������������ ��߱����� �����ϼ���!");
                document.getElementById("cmbSTART_GBN").focus();
                return false;
            }

            window.showModalDialog("../../../Ehr/hr/but/buta021.jsp?STATUS="+status, dsT_DI_BUSINESSTRIP, "dialogWidth:850px; dialogHeight:480px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(dsT_DI_BUSINESSTRIP.NameValue(1,"BASIS_YN") == "SA" && status == "SV" && dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO") == gusrid){

                status = "SV";

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
            if(("<%=app_cmt%>").substring(0,2) == "�ݼ�" && dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO") == gusrid){
	            status = "SV";
  			//����̳� ����Ȱ��� ���ʿ��ư �ʺ��̰��Ѵ�.
            }else if("<%=app_cmt%>" != "����"){
            	document.getElementById("imgSave").style.display = "none";
       			document.getElementById("btn_train").style.display = "none";
            }

            //�˾������� ��� �ʺ��̰�
            document.getElementById("ImgClear").style.display = "none";

            //��������� �����̰ų� ����ڰ� �ƴ� ����� �˾����� �������� �Է¶� Disabled
            if(status != "SV" || gusrid != '6060002' || gusrid != '2140002' || gusrid != '6180001' ||gusrid != '2180001'
            || dsT_DI_BUSINESSTRIP.NameValue(1,"ENO_NO") != gusrid){
                fnc_InputDisabled();

            }else{
                //������������� �����꼭�� �־�� ����� ���δ�.
                dsT_DI_BUSINESSTRIP_ACCOUNT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR&ORD_NO="+dsT_DI_BUSINESSTRIP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_ACCOUNT.reset();

                if(dsT_DI_BUSINESSTRIP_ACCOUNT.countRow > 0){
                    document.getElementById("btn_appre").style.display = "";
                }
            }

            //���� ����ڴ� �������� Enable
            if(gusrid == '6060002' || gusrid != '6180001' ||gusrid == '2180001'){
	            document.getElementById("txtBUT_FR_YMD").className = "";
	            document.getElementById("txtBUT_FR_YMD").readOnly = false;
	            document.getElementById("txtBUT_TO_YMD").className = "";
	            document.getElementById("txtBUT_TO_YMD").readOnly = false;
                //�����ư Show
                document.getElementById("btn_insa_save").style.display = "";

			}

            var APP_STATUS = "";
            var Aeno_no = "";

            if(("<%=app_cmt%>").substring(0,2) == "�ݼ�" || ("<%=app_cmt%>").substring(0,2) == "�ΰ�"){
            			document.getElementById("btn_approval").style.display = "none";
            			document.getElementById("resultMessage").innerText = '* �̹� ���� ó���Ϸ� �Ǿ����ϴ�. ��ȸ�� �����մϴ�. ';
            }else{
                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){

                    Aeno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");   //������
					APP_STATUS = dsT_DI_APPROVAL.NameValue(i,"APP_STATUS");   //���翩��  &&  (app_yn == null)

					if(Aeno_no == gusrid && ( APP_STATUS == "�̰�")){
						document.getElementById("btn_approval").style.display = "";
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
						break;
					}
                }
			}

        }

        /************************
         * 23. ������ ����      *
         ***********************/
		function fnc_SetCOM_YN(obj) {

			var kind = obj.id;

            if(kind == "radio2"){

                window.showModalDialog("../../../Ehr/hr/but/buta022.jsp", dsT_DI_BUSINESSTRIP, "dialogWidth:500px; dialogHeight:430px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CNT") != "0" && dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM1") != ""){
	                var remark = "";

                	if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM1") != "" ){
	                	remark = remark + dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM1")+" "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM1");
                	}
                	if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM2") != "" ){
	                	remark = remark + ", "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM2")+" "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM2");
                	}
                	if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM3") != "" ){
	                	remark = remark + ", "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM3")+" "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM3");
                	}
                	if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM4") != "" ){
	                	remark = remark + ", "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM4")+" "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM4");
                	}
                	if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM5") != "" ){
	                	remark = remark + ", "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM5")+" "+dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM5");
                	}
					remark = remark + " ����";

                    document.getElementById("txtREMARK").value = remark;
                    document.getElementById("hidCOM_YN").value = "Y";
                }else{
                    document.getElementById("radio1").checked = true;
                    document.getElementById("txtREMARK").value = "";
                    document.getElementById("hidCOM_YN").value = "N";
                }

            }else{

                if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CNT") != "0" && dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CNT") != ""){
		            if (!confirm("������ �����͸� ���� �Ͻðڽ��ϱ�?")){
	                    document.getElementById("radio2").checked = true;
						document.getElementById("hidCOM_YN").value = "Y";
						return;
					}
	            }

                //������ ���� Clear
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CNT") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CD1") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM1") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NO1") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM1") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CD2") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM2") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NO2") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM2") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CD3") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM3") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NO3") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM3") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CD4") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM4") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NO4") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM4") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_CD5") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NM5") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NO5") = "";
                dsT_DI_BUSINESSTRIP.NameValue(1,"COM_NAM5") = "";

                document.getElementById("txtREMARK").value = "";
                document.getElementById("hidCOM_YN").value = "N";

            }

        }

        /**************************************
         * 24. ö���̿������ν�û �˾�      *
         *************************************/
		function fnc_buta080Pop() {

            window.showModalDialog("../../../Ehr/hr/but/buta080.jsp", "Modal", "dialogWidth:870px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        }

		/*************************
         * 25. ������������ ����*
         *************************/
		function fnc_OFFER_GBN() {

			if(document.getElementById("chkOFFER_GBN").checked == true){
				document.getElementById("txtOFFER_GBN").value = "Y";
	            document.getElementById("cmbSTART_GBN").disabled = true;
	            document.getElementById("cmbSTART_GBN").value = "2";
			}else{
				document.getElementById("txtOFFER_GBN").value = "N";
	            document.getElementById("cmbSTART_GBN").disabled = true;
	            document.getElementById("cmbSTART_GBN").value = "2";
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
    | 3. Table List : T_DI_BUSINESSTRIP             |
    +----------------------------------------------->
    <Object ID="dsORD_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_BUSINESSTRIP_BASIS           |
    | 3. Table List : T_DI_BUSINESSTRIP_BASIS       |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_BUSINESSTRIP                 |
    | 3. Table List : T_DI_BUSINESSTRIP             |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_AD_DECISION                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_AD_DECISION                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                               |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_BUSINESSTRIP_ACCOUNT)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_ACCOUNT)       |
    +------------------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP)	|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_BUSINESSTRIP Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            //������ ���� ������ư ����
            if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_YN") == "Y"){
                document.getElementById("radio2").checked = true;
            }else{
                document.getElementById("radio1").checked = true;
            }

            //������������ ����
            if(dsT_DI_BUSINESSTRIP.NameValue(1,"OFFER_GBN") == "Y"){
				document.getElementById("chkOFFER_GBN").checked = true;
	            document.getElementById("cmbSTART_GBN").disabled = false;
            }else{
            	document.getElementById("chkOFFER_GBN").checked = false;
				document.getElementById("cmbSTART_GBN").value = "";
	            document.getElementById("cmbSTART_GBN").disabled = true;
            }

        }

    </Script>

    <Script For=dsORD_NO Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
			document.getElementById("txtORD_NO").value = dsORD_NO.NameValue(1,"ORD_NO");
        }

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
			//�������
			if(document.getElementById("cmbCITY_GBN1").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN1").add(oOption);

	            }
            }

			if(document.getElementById("cmbCITY_GBN2").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN2").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN3").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN3").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN4").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN4").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN5").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN5").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN6").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN6").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN7").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN7").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN8").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN8").add(oOption);
	            }
			}

        }

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    
        if (iCount < 1)    {

        } else {

            //ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            
            //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            
            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
            
            form1.grdT_DI_APPROVAL.TitleHeight = 18;
            form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = false;

            form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";
       }

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

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

    <Script For=dsORD_NO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP event="OnSuccess()">

        document.getElementById("btn_trbfee").style.display = "";

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5" align="left" width="385" height="35" >
            <span id="btn_trbfee" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAccount','','../../images/button/btn_AccountOver.gif',1)"><img src="../../images/button/btn_AccountOn.gif" name="imgAccount" width="90" height="20" border="0" align="absmiddle" onClick="fnc_Calcul_Basis();"></a>
            </span>
            <span id="btn_appre" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)"><img src="../../images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();"></a>
            </span>
            <span id="btn_insa_save" style="display:none">
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave2','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave2"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save_Insa()"></a>
            </span>


		</td>
		<td class="paddingTop5" align="left" width="70" height="35" >
            <span id="btn_train" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgKorail','','../../images/button/btn_KorailOver.gif',1)"><img src="../../images/button/btn_KorailOn.gif" name="imgKorail" width="60" height="20" border="0" align="absmiddle" onClick="fnc_buta080Pop();"></a>
            </span>
		</td>
		<td class="paddingTop5" align="right" width="535" height="35" >
		    <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)"><img src="../../images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" 	  onClick="fnc_SubmitApproval('����');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)"><img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('�ΰ�');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSendback','','../../images/button/btn_SendbackOver.gif',1)"><img src="../../images/button/btn_SendbackOn.gif" name="imgSendback" width="60" height="20" border="0" align="absmiddle"     onClick="fnc_SubmitApproval('�ݼ�');"></a>
            </span>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
		    <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ���� �Է� ���̺� ���� -->
			<table width="320" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="blueBold">ǰ�ǹ�ȣ</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="blueBold">�Ҽ�</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">����</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">������</td>
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
        <td width="30">&nbsp;&nbsp;</td>
        <td>
        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:660px;height:108px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NM'			width=70	name='����'			align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
								<C> id='ENO_NM'			width=90	name='������'			align=center</C>
								<C> id='JOB_NM'			width=80	name='����'			align=center	</C>
                                <C> id='DPT_NM'			width=100	name='��'			align=left		</C>
								<C> id='APP_STATUS'		width=170	name='�������'		align=left	    </C>
								<C> id='REMARK1'		width=120	name='�ǰ�'			align=center 	Color='Blue'	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
   				<tr>
                    <td align="right">
             &nbsp;    <span id="btn_InsDel">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
                       </span>
		            </td>
		       </tr>
            </table>
        	<!-- ���缱 ���� ���̺� �� -->
        </td>
    </tr>
</table>

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="150"></col>
                    <col width="400"></col>
                    <col width="250"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">����Ⱓ</td>
					<td class="padding2423" colspan="2">
						<input id="txtBUT_FR_YMD" size="10" maxlength="10" onblur="javascript:fnc_CheckDate(this);cfCheckDateTerm('txtBUT_FR_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD');cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)">
						<img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_FR_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_FR_YMD','','40','235');"></a>
                        <comment id="__NSID__">
							<object id=rdoBUT_FR_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:0;width:0;">
								<param name=AutoMargin	value="true">
								<param name=Cols		value="1">
								<param name=Format		value="A^����">
							</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>~&nbsp;&nbsp;
                        <input id="txtBUT_TO_YMD" size="10" maxlength="10" onblur="javascript:fnc_CheckDate(this);cfCheckDateTerm('txtBUT_TO_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD');cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_TO_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_TO_YMD','','300','235');"></a>
                        <comment id="__NSID__">
							<object id=rdoBUT_TO_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:0;width:0">
								<param name=AutoMargin	value="true">
								<param name=Cols		value="2">
								<param name=Format		value="P^����">
							</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script> (
                        <input id="txtSLEEP_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>��
                        <input id="txtBUT_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>�� )&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<B>��������&nbsp;&nbsp;</B>
						<select id="cmbBUT_GBN" name="cmbBUT_GBN" style="width:120">
                            <option value="1">����</option>
                            <option value="2">�Ϲ�����</option>
                        </select>

                    </td>
                    <td class="padding2423" rowspan="2" valign="top">
                        &nbsp;
                        <input type="checkbox" id="chkOFFER_GBN" style="border:0" align="absmiddle" onclick="fnc_OFFER_GBN()">��������(��������)
						<input type="hidden" id="txtOFFER_GBN">
						<br>
						&nbsp;

						<input type="hidden" id="cmbSTART_GBN" size="40"  class="input_ReadOnly" readOnly>
					</td>
                </tr>
                <tr>
					<td align="center" class="blueBold">�� �� ��</td>
					<td class="padding2423" colspan="2">
						<input id="txtBUT_CITY" size="30" maxlength="40" onKeyUp="fc_chk_byte(this,40)">
						&nbsp;
						<input type="hidden" id="txtPC_CCTRCD" size="20" >
						<input type="hidden" id="txtPC_CCTRNM" size="40"  class="input_ReadOnly" readOnly>
						<input type="hidden" id="txtPC_GBN" size="30" >
						<input type="hidden" id="txtWBS_FR_YMD" size="30" >
						<input type="hidden" id="txtWBS_TO_YMD" size="30" >
						<span id="btn_Slip" type="hidden"  >
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectSlip','','../../images/button/btn_SlipOver.gif',1)"> </a>
						</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold" rowspan="4">���屸��<BR><BR>��<BR><BR>�������</td>
					<td class="padding2423">
						<B>1. </B><input id="txtCITY_DPT1" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV1" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN1" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT2.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>5. </B><input id="txtCITY_DPT5" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV5" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN5" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT6.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
				</tr>
                <tr>
                    <td class="padding2423">
						<B>2. </B><input id="txtCITY_DPT2" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV2" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN2" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT3.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>6. </B><input id="txtCITY_DPT6" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV6" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN6" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT7.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                </tr>
                <tr>
                    <td class="padding2423">
						<B>3. </B><input id="txtCITY_DPT3" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV3" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN3" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT4.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>7. </B><input id="txtCITY_DPT7" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV7" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN7" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT8.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                </tr>
                <tr>
                    <td class="padding2423">
						<B>4. </B><input id="txtCITY_DPT4" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV4" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN4" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT5.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>8. </B><input id="txtCITY_DPT8" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV8" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN8" style="WIDTH: 50%">
                            <option value=""></option>
                        </select>
					</td>
                </tr>
                <tr>
					<td align="center" class="blueBold">�������</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtBUT_OBJ"  onKeyUp="fc_chk_byte(this,200)"  cols=110  rows=3 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="blueBold">����ȿ��</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtBUT_AFF"  onKeyUp="fc_chk_byte(this,200)" cols=110  rows=3 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="blueBold">��޿���ó</td>
					<td class="padding2423">
					    <B>����</B>
					    <input id="txtBUT_NAME" size="12" onKeyUp="fc_chk_byte(this,12)">
					</td>
                    <td class="padding2423" colspan="2">
                        <B>����ó</B>
						<input id="txtBUT_PHONE" size="20" maxLength="20" onkeypress="cfCheckNumber()" style="ime-mode:disabled">
					</td>
				</tr>
                <tr>
					<td align="center" class="blueBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" colspan="3">
						<input id="txtREMARK" size="80" onKeyUp="fc_chk_byte(this,80)">
                        <input type="hidden" id="hidAPP_CMT"">
					</td>
				</tr>				
                <tr>
					<td align="center" class="blueBold">�� �� ��</td>
					<td class="padding2423" colspan="3">
                        <input type="radio" id="radio1" name="rdoCOM_YN" style="border:none" onClick="fnc_SetCOM_YN(this)" checked>����
                        <input type="radio" id="radio2" name="rdoCOM_YN" style="border:none" onClick="fnc_SetCOM_YN(this)">����
                        <input type="hidden" id="hidCOM_YN">&nbsp;&nbsp;&nbsp;�ص������� ��û�� ���� �ְ� 5����� �����մϴ�.
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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



</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_DI_BUSINESSTRIP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_BUSINESSTRIP">
	<Param Name="BindInfo", Value='
        <C>Col=ORD_NO     		Ctrl=txtORD_NO     		Param=value 	</C>
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     		Param=value 	</C>
        <C>Col=DPT_NM     		Ctrl=txtDPT_NM     		Param=value 	</C>
		<C>Col=JOB_CD			Ctrl=txtJOB_CD	   		Param=value		</C>
        <C>Col=JOB_NM			Ctrl=txtJOB_NM	   		Param=value		</C>
		<C>Col=ENO_NO   		Ctrl=txtENO_NO    		Param=value		</C>
		<C>Col=NAM_KOR			Ctrl=txtNAM_KOR     	Param=value		</C>
        <C>Col=BUT_FR_YMD       Ctrl=txtBUT_FR_YMD  	Param=value 	</C>
        <C>Col=BUT_FR_GBN       Ctrl=rdoBUT_FR_GBN  	Param=CodeValue </C>
        <C>Col=BUT_TO_YMD       Ctrl=txtBUT_TO_YMD  	Param=value 	</C>
        <C>Col=PC_CCTRCD        Ctrl=txtPC_CCTRCD  		Param=value 	</C>
        <C>Col=PC_CCTRNM        Ctrl=txtPC_CCTRNM  		Param=value 	</C>
        <C>Col=PC_GBN           Ctrl=txtPC_GBN  		Param=value 	</C>
        <C>Col=BUT_TO_GBN       Ctrl=rdoBUT_TO_GBN  	Param=CodeValue </C>
        <C>Col=OFFER_GBN        Ctrl=txtOFFER_GBN  	    Param=value 	</C>
        <C>Col=START_GBN        Ctrl=cmbSTART_GBN  	    Param=value 	</C>
        <C>Col=BUT_GBN          Ctrl=cmbBUT_GBN  	    Param=value 	</C>
        <C>Col=SLEEP_DAY        Ctrl=txtSLEEP_DAY  	    Param=value 	</C>
        <C>Col=BUT_DAY          Ctrl=txtBUT_DAY  	    Param=value 	</C>
        <C>Col=BUT_CITY         Ctrl=txtBUT_CITY  	    Param=value 	</C>
        <C>Col=CITY_DPT1        Ctrl=txtCITY_DPT1  	    Param=value 	</C>
        <C>Col=CITY_ARV1        Ctrl=txtCITY_ARV1  	    Param=value 	</C>
        <C>Col=CITY_GBN1        Ctrl=cmbCITY_GBN1  	    Param=value 	</C>
        <C>Col=CITY_DPT2        Ctrl=txtCITY_DPT2  	    Param=value 	</C>
        <C>Col=CITY_ARV2        Ctrl=txtCITY_ARV2  	    Param=value 	</C>
        <C>Col=CITY_GBN2        Ctrl=cmbCITY_GBN2  	    Param=value 	</C>
        <C>Col=CITY_DPT3        Ctrl=txtCITY_DPT3  	    Param=value 	</C>
        <C>Col=CITY_ARV3        Ctrl=txtCITY_ARV3  	    Param=value 	</C>
        <C>Col=CITY_GBN3        Ctrl=cmbCITY_GBN3  	    Param=value 	</C>
        <C>Col=CITY_DPT4        Ctrl=txtCITY_DPT4  	    Param=value 	</C>
        <C>Col=CITY_ARV4        Ctrl=txtCITY_ARV4  	    Param=value 	</C>
        <C>Col=CITY_GBN4        Ctrl=cmbCITY_GBN4  	    Param=value 	</C>
        <C>Col=CITY_DPT5        Ctrl=txtCITY_DPT5  	    Param=value 	</C>
        <C>Col=CITY_ARV5        Ctrl=txtCITY_ARV5  	    Param=value 	</C>
        <C>Col=CITY_GBN5        Ctrl=cmbCITY_GBN5  	    Param=value 	</C>
        <C>Col=CITY_DPT6        Ctrl=txtCITY_DPT6  	    Param=value 	</C>
        <C>Col=CITY_ARV6        Ctrl=txtCITY_ARV6  	    Param=value 	</C>
        <C>Col=CITY_GBN6        Ctrl=cmbCITY_GBN6  	    Param=value 	</C>
        <C>Col=CITY_DPT7        Ctrl=txtCITY_DPT7  	    Param=value 	</C>
        <C>Col=CITY_ARV7        Ctrl=txtCITY_ARV7  	    Param=value 	</C>
        <C>Col=CITY_GBN7        Ctrl=cmbCITY_GBN7  	    Param=value 	</C>
        <C>Col=CITY_DPT8        Ctrl=txtCITY_DPT8  	    Param=value 	</C>
        <C>Col=CITY_ARV8        Ctrl=txtCITY_ARV8  	    Param=value 	</C>
        <C>Col=CITY_GBN8        Ctrl=cmbCITY_GBN8  	    Param=value 	</C>
        <C>Col=BUT_OBJ          	Ctrl=txtBUT_OBJ  	    Param=value 	</C>
        <C>Col=BUT_AFF          	Ctrl=txtBUT_AFF  	    Param=value 	</C>
        <C>Col=BUT_ADDR         	Ctrl=txtBUT_ADDR  	    Param=value 	</C>
        <C>Col=BUT_NAME         	Ctrl=txtBUT_NAME  	    Param=value 	</C>
        <C>Col=BUT_PHONE        	Ctrl=txtBUT_PHONE  	    Param=value 	</C>
        <C>Col=COM_YN           	Ctrl=hidCOM_YN          Param=value     </C>
        <C>Col=REMARK           	Ctrl=txtREMARK  	    	Param=value 	</C>
    '>
</object>