<!--
*****************************************************
* @source       : gunc010.jsp
* @description : ���ϱٹ�������� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/08      ������        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ϱٹ��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	//�˻�����
			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value;      //���ϱٹ�����.
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value;       //�Ҽ�
			var ENO_NO_SHR   = document.getElementById("txtENO_NO_SHR").value;

            //�ش����� ������ ��ȸ����.
			if(HOL_YMD_SHR.trim().length == 0){
					alert("���ϱٹ����ڸ� �Է��ϼ���.");
					document.getElementById("txtHOL_YMD_SHR").focus();
					return false;
			}

			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(HOL_YMD_SHR.trim().length != 10){
					alert("���ϱٹ����ڰ� �߸� �Ǿ����ϴ�.");
					document.getElementById("txtHOL_YMD_SHR").focus();
					return false;
			}

			//�Ҽ��� ������
			if(DPT_CD_SHR.trim().length == 0){
					alert("�Ҽ��� �Է��ϼ���.");
					document.getElementById("txtDPT_CD_SHR").focus();
					return false;
			}


            //��ȸ �ش����� �����Ѵ�.
            document.getElementById("hidDPT_CD_ORI").value = DPT_CD_SHR;

			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=SHR"
                                      + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                      + "&DPT_CD_SHR="+DPT_CD_SHR
                                      + "&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_DI_HOLIDAYWORK.reset();

            //������ ��ȸ
            fnc_SearchApprover();


        }

        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {
            var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;

			HOL_YMD = HOL_YMD.replace("-","").replace("-","")
            var REQ_NO  = HOL_YMD + "H" + DPT_CD;

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=H";
            dsT_DI_APPROVAL.Reset();
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
            var HOL_YMD_SHR  = document.form1.txtHOL_YMD_SHR.value;
            var MSG05 = "";


			if (!dsT_DI_HOLIDAYWORK.IsUpdated && !dsT_DI_APPROVAL.IsUpdated ) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
            //5ȸ �ʰ���û�� �ʰ��к��� �����Ǵ�ü�ް�����
            for(var i = 1; i <= dsT_DI_HOLIDAYWORK.CountRow; i++) {



		           //******************  2011.05       5ȸ�ʰ���û�� �ʰ��к��� �����Ǵ�ü�ް�����
    	            var ENO_NO_NEW  = dsT_DI_HOLIDAYWORK.NameString(i, "ENO_NO");  // - 5ȸ Check ��� �����ȣ
					dsT_DI_HOLWORK_05.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=SHR_05"
                                      + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                      + "&ENO_NO_SHR="+ENO_NO_NEW;
					dsT_DI_HOLWORK_05.reset();

            	if(dsT_DI_HOLWORK_05.CountRow >= 3 && dsT_DI_HOLIDAYWORK.NameString(i, "REP_APP") == '1') {

	            	  MSG05 = dsT_DI_HOLIDAYWORK.NameString(i, "ENO_NM")+ " - ���� �ٹ����� 3ȸ �ʰ�  ��û �Ұ��մϴ�.\n\n��ü�ް��� ��û �� ���� �ٶ��ϴ�.\n\n ���� �ٹ����� ��û�� : ";

	            	  		for(var j = 1; j <= dsT_DI_HOLWORK_05.CountRow; j++) {
	            	  	 	    MSG05 = MSG05 + dsT_DI_HOLWORK_05.NameString(j, "HOL_YMD") + "  ";
	            	  		}
	            	  alert(MSG05);
            	}

           	}

			if (MSG05 != "") {
			    document.getElementById("resultMessage").innerText = '>> �۾��� ��ҵǾ����ϴ�. ���� �� �ٽ� �����Ͽ� �ֽʽÿ�';
			    return;
			}

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD&S_MODE=SAV";
			trT_DI_HOLIDAYWORK.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

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

            if (dsT_DI_HOLIDAYWORK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_HOLIDAYWORK.GridToExcel("���ϱٹ��������", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }


        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
            //�����ϴ� �͵� ����
             fnc_HiddenElement("imgSelectapproval");
             fnc_HiddenElement("imgReport");
             fnc_HiddenElement("imgSave");
             fnc_DisableElementAll(elementList);

			dsT_DI_HOLIDAYWORK.ClearData();
			dsT_DI_APPROVAL.ClearData();


            document.getElementById("hidDPT_CD_ORI").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ�
            document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ�
            document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// �Ҽ�


			document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtHOL_YMD_SHR.focus();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_HOLIDAYWORK.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();

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

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //�����ϴ� �͵� ����
            fnc_HiddenElement("imgSelectapproval");
            fnc_HiddenElement("imgReport");
            fnc_HiddenElement("imgSave");

            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,15,"false","false")      // Grid Style ����
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

            document.getElementById("hidDPT_CD_ORI").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ�
            document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// �Ҽ�
            document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// �Ҽ�

<%
    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "txtDPT_NM_SHR");
            fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }
%>

<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			 document.getElementById("approval_btn").style.display = "";
			 document.getElementById("approval_btn").style.display = "";
<%  //A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			document.getElementById("approval_btn").style.display = "";
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }else{
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

			fnc_ChangeStateElement(false, "txtENO_NO");
			fnc_ChangeStateElement(false, "txtENO_NM");
			fnc_ChangeStateElement(false, "ImgEnoNo");
			document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
			document.getElementById("approval_btn").style.display = "none";

<%
	}
%>
            document.form1.txtHOL_YMD_SHR.focus();
			document.getElementById("resultMessage").innerText = '>> �۾�����: �ٹ����� ��ȸ => �ٹ��ð�/���� �Է� => ����';
            //�������ڸ��� �� �ε�
    //        fnc_SearchList();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



        /**
         * ���缱 ����.
         */
        function fnc_Approval() {
            var DPT_CD = document.getElementById("hidDPT_CD_ORI").value;
			var EMP_NO =  "<%=box.getString("SESSION_ENONO") %>";
            var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value;
			HOL_YMD = HOL_YMD.replace("-","").replace("-","")

            //ds�� ���Ϲ޴´�.
            dsT_DI_APPROVAL.ClearData();
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "H");

            //������ IsUpdated üũ�ϰ� ����

            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"GUN_DPT")=  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");	//���缱(�������)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = HOL_YMD;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = "<%=box.get("SESSION_ENONO")%>";	//����� ���
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "H";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
            }
        }

		function fnc_Hol_Time(){

           var hol_time =  fnc_covNumber(document.getElementById("cmbEND_AFT_HOUR").value) - fnc_covNumber(document.getElementById("cmbSTR_AFT_HOUR").value);

   		   if(document.getElementById("cmbSTR_AFT_HOUR").value == "24") {
				document.getElementById("cmbSTR_AFT_MIN").value = "00";
   		   }
   		   if(document.getElementById("cmbEND_AFT_HOUR").value == "24") {
				document.getElementById("cmbEND_AFT_MIN").value = "00";
   		   }

           if(parseInt(hol_time) < 0){
              alert("����ð��� ���۽ð����� �۽��ϴ�. �ٽ� ������ �ּ���");
              document.getElementById("cmbEND_AFT_HOUR").value = "00";
              document.getElementById("cmbEND_AFT_MIN" ).value = "00";
              return;
   		   }
   		   if(!(parseInt(hol_time) == 0) && ((parseInt(hol_time) > 8) || (parseInt(hol_time) < 4))) {
              alert("8�ð�/�� �ʰ�  �Ǵ� 4�ð�/�� �̸�  �ٹ� ������. �ٽ� ������ �ּ���");
              document.getElementById("cmbEND_AFT_HOUR").value = "00";
              document.getElementById("cmbEND_AFT_MIN" ).value = "00";
              return;
   		   }

		}

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3", "1", "1");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3");

            if(obj.eno_no.substring(0,1) == "8"){
              alert("�İ߻���� �ش� �޴��� ��û�� �� �����ϴ�.");
              dsT_DI_HOLIDAYWORK.DeleteRow(dsT_DI_HOLIDAYWORK.RowPosition);
              return false;
            }

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            } else {
                document.getElementById("txtENO_NO").value = "";
	            document.getElementById("txtENO_NM").value = "";
	            document.getElementById("txtJOB_CD").value = "";
	            document.getElementById("txtJOB_NM").value = "";
	            document.getElementById("txtDPT_CD").value = "";
	            document.getElementById("txtDPT_NM").value = "";
            }
        }

        function fnc_Ymd_Len(){
            if(document.getElementById("txtHOL_YMD_SHR").value.length == 10){
              fnc_SearchList();
            }

        }


  		/**
         * ��¥ üũ ���� ���������� üũ �Ѵ�.
         */
		function fnc_CheckDate(){
			var sel_ymd = document.getElementById("txtHOL_YMD_SHR").value.replace(/-/g, "");

			if(sel_ymd.length == 8){

                //1.������������ üũ
                dsT_DI_HOLIDAY.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=SHR_02"
                                      + "&HOL_YMD="+sel_ymd;
                dsT_DI_HOLIDAY.reset();

           /**     if(dsT_DI_HOLIDAY.NameValue(1,"CHK_YN") == "N"){
                    alert("�ش����ڴ� ��û���� ���ڰ� �ƴմϴ�.");
                    document.getElementById("txtHOL_YMD_SHR").value = "";
                    document.getElementById("txtHOL_YMD_SHR").focus();
                    return false;
                }  ��� ���� ���� Test�� **/
			}
		}


        /**
         * ���ó��
         */
        function fnc_Conduct() {

        	var unworked_no = 0;

            if(dsT_DI_HOLIDAYWORK.CountRow < 1){
              alert("��Ű����� ���ϱٹ���û������ �����ϴ�");
              return;
            }

            //��û�� ���� �̱ٹ� ���� ��� ������� ����!
            for(var i = 1; i <= dsT_DI_HOLIDAYWORK.CountRow; i++) {
            	if(dsT_DI_HOLIDAYWORK.NameString(i, "REP_APP") == "3")
            		unworked_no++;
            }

            //�������� �ٹ��ð��� ������ ����!
            for(var i = 1; i <= dsT_DI_HOLIDAYWORK.CountRow; i++) {
            	if(dsT_DI_HOLIDAYWORK.NameString(i, "STR_AFT_HOUR") == "00" && dsT_DI_HOLIDAYWORK.NameString(i, "STR_AFT_MIN") == "00"
            	  && dsT_DI_HOLIDAYWORK.NameString(i, "END_AFT_HOUR") == "00" && dsT_DI_HOLIDAYWORK.NameString(i, "END_AFT_MIN") == "00"
            	  && dsT_DI_HOLIDAYWORK.NameString(i, "REP_APP") != "3") {
	              alert("�ٹ��ð��� �Է��Ͻʽÿ�.");
	              return;
            	}
           	}

            if(dsT_DI_HOLIDAYWORK.CountRow == unworked_no){
            	alert("���� �̱ٹ��� ����� �ʿ䰡 �����ϴ�.");
            	return;
            }

            //1.���ó�� ������
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("���缱�� �������ּ���.");
                return;
            }
            //2.���ó��

            var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value;
			var GUN_YMD = HOL_YMD.replace("-","").replace("-","")
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var REQ_NO  = GUN_YMD + "H" + DPT_CD;

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc090.cmd.GUNC090CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +"R"
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"H"
                                      + "&GUN_DPT=" +DPT_CD
                                      + "&REQ_NO="+REQ_NO;
			trT_DI_HOLIDAYWORK.post();
		}


        //�Է� element
        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_AFT_HOUR"
                                        ,"cmbSTR_AFT_MIN"
                                        ,"cmbEND_AFT_HOUR"
                                        ,"cmbEND_AFT_MIN"
                                        ,"txtREMARK" );

        //���� �׸�
        var exceptionList = new Array(   "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_HOLIDAYWORK                                |
    | 3. Table List : T_DI_HOLIDAYWORK                           |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_DI_HOLWORK_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_HOLIDAY                                      |
    | 3. Table List : T_DI_HOLIDAY                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			                  |
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_HOLIDAYWORK)		  |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK)	                  |
    +--------------------------------------------------->
    <Object ID ="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_DI_HOLIDAYWORK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

        var APP_YN  = dsT_DI_HOLIDAYWORK.NameString(1, "SIGN_TAG");  //������ ���� ���� '':����, 'R':���, 'Y':����, 'N':�ݷ�

            if(APP_YN == "" || APP_YN == "N") {
                fnc_ShowElement("imgSelectapproval");
                fnc_ShowElement("imgReport");
                fnc_ShowElement("imgSave");
           		rdoREP_APP.Enable = "true";


			}else if(APP_YN == "R" || APP_YN == "Y") { // ������� ��� �����ư �Ⱥ��̰�.. �� ���¿��� ���� �� �ð��ٲ� �����Ҽ��ִ�.
			        fnc_HiddenElement("imgSave");
    	            fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");
	                fnc_DisableElementAll(elementList);
					rdoREP_APP.Enable = "false";
                    }
			rdoREP_APP.reset();
    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnDataError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_HOLIDAYWORK event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_HOLIDAYWORK event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|
    +-------------------------------------->
	<script language="javascript"  for=dsT_DI_HOLIDAYWORK  event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        var today   = fnc_covNumber(getToday());

        if(row > 0) {

            //������ ��û�Ⱓ�̸� �Է�â Ǯ�� ����
            /*
             * TEST
            if(holFrom <= today && today <= holTo) {
             */

                //��������̰ų� �ΰ��϶� ������ ������
                if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
                        || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N"
                        || dsT_DI_APPROVAL.NameString(2, "APP_YN") == "N") {
                    //�ű��� ���
                    if(dsT_DI_HOLIDAYWORK.RowStatus(row) == "1") {
                        fnc_EnableElementAll(elementList);
                    } else {
                        fnc_EnableElementAll(elementList, exceptionList);
                    }
                }
            /*
            }
            */
        }
	</script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_DI_HOLIDAYWORK event=CanRowPosChange(row)>

		var oENO_NO = dsT_DI_HOLIDAYWORK.NameValue(row, "ENO_NO");
		if(oENO_NO.trim().length == 0){
			alert("����� �Է��ϼ���.");
			document.getElementById("txtENO_NO").focus();
			return false;
		}
		if(oENO_NO.trim().length != 6){
			alert("����� �߸��Ǿ����ϴ�.");
			document.getElementById("txtENO_NO").focus();
			return false;
		}

		var oREP_APP = dsT_DI_HOLIDAYWORK.NameValue(row, "REP_APP");
		var oREP_YMD = dsT_DI_HOLIDAYWORK.NameValue(row, "REP_YMD");
		var oREP_TYP = dsT_DI_HOLIDAYWORK.NameValue(row, "REP_TYP");
		var oHOL_YMD = dsT_DI_HOLIDAYWORK.NameValue(row, "HOL_YMD");
		if(oREP_APP.trim() == ""){
			alert("���ϱٹ���û�� �����ϼ���.");
			return false;
		}else if(oREP_APP.trim() == "2" ){
		    if(oREP_YMD.trim() == ""){
				alert("��ü������ �����Ͻʽÿ�.");
				return false;
			}
			if(oREP_TYP.trim() == ""){
				alert("��ü�ް� ����/���� �����Ͻʽÿ�.");
				return false;
			}
			if(oREP_YMD <= oHOL_YMD){
				alert("��ü �ް����� ���ϱٹ����� �����Դϴ�. �ٽ� ������ �ּ���");
				document.getElementById("txtREP_YMD").focus();
				return false;
			}
		}else if(oREP_APP.trim() == "1" || oREP_APP.trim() == "3"){
			    if(oREP_TYP.trim() == "" || oREP_YMD.trim() == ""){
			    }
			    else{
			    document.getElementById("txtREP_YMD").value = "";
			    document.getElementById("rdoREP_TYP").CodeValue="";
			    rdoREP_TYP.Reset();
				alert("��ü�ް� �Է»����� ��ҵǾ����ϴ�.");
				return false;
				}
		}
		var hol_time =  fnc_covNumber(document.getElementById("cmbEND_AFT_HOUR").value) - fnc_covNumber(document.getElementById("cmbSTR_AFT_HOUR").value);
	   if(!(parseInt(hol_time) == 0) && ((parseInt(hol_time) > 8) || (parseInt(hol_time) < 4))) {
	          alert("8�ð�/�� �ʰ�  �Ǵ� 4�ð�/�� �̸�  �ٹ� ������. �ٽ� ������ �ּ���");
              document.getElementById("cmbEND_AFT_HOUR").value = "00";
              document.getElementById("cmbEND_AFT_MIN" ).value = "00";
              return false;
   		   }

    </script>
    <!-----------------------------+
    | ���� ��ư  ���������� ó�� |
    +------------------------------>
	<script language=JavaScript for=rdoREP_APP event=OnSelChange()>
		if(rdoREP_APP.CodeValue == "1" || rdoREP_APP.CodeValue == "3"){
			fnc_ChangeStateElement(false, "txtREP_YMD");
			fnc_ChangeStateElement(false, "imgREP_YMD");
		    document.getElementById("txtREP_YMD").value = "";
		    document.getElementById("rdoREP_TYP").CodeValue="";
		    document.getElementById("rdoREP_TYP").DataValue="";
		    rdoREP_TYP.Reset();
			rdoREP_TYP.Enable = "false";
		}else{
			fnc_ChangeStateElement(true, "txtREP_YMD");
			fnc_ChangeStateElement(true, "imgREP_YMD");
			rdoREP_TYP.Enable = "true";
		}

	</script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		var obj = new String();
		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
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
<input type=hidden id="txtENO_NO_SHR" size="10">
<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱٹ��������</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���ϱٹ��������</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
		  * ���ϱٹ����ޱ���:����1��~���Ϻб��� �ݿ��޿��� ���� <br>
		  * �Է±Ⱓ:���ϱٹ��ǽ� ������ �ݿ��ϱ��� ǰ��,����Ϸ�  <br>
		  * ���� �ٹ� �ð� : 4 ~ 8 �ð� ���� <br>
			</font>
		</td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td align="center" class="greenTable">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            	<colgroup>
                	<col width="100"></col>
                    <col width="200"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
					<td align="right" class="searchState">���ϱٹ�����&nbsp;</td>
                    <td class="padding2423">

                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="100" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input id="txtHOL_YMD_SHR" readonly size="10" maxLength="10" onblur="cfCheckDate(this);"  onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" onFocus="fnc_CheckDate();fnc_Ymd_Len();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHOL_YMD_SHR','','190','115');"></a>
                                </td>
                            </tr>
                   </table>

					</td>
                    <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                    <td class="padding2423">
                        <input id="hidDPT_CD_ORI" type="hidden">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->



<table border="0">
	<tr>
		<td valign="top">
			<!-- ���� �Է� ���̺� ���� -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="100"></col>
                                <col width="250"></col>
                            </colgroup>
							<tr>
								<td align="center" class="creamBold">�����ȣ</td>
                                <td class="padding2423" >
                                    <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                    <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

                                    <input type="hidden" id="txtJOB_CD">
                                    <input type="hidden" id="txtJOB_NM">
                                    <input type="hidden" id="txtDPT_CD">
                                    <input type="hidden" id="txtDPT_NM">
                                </td>
							</tr>
	                        <tr>
								<td align="center" class="creamBold">�ٹ��ð�</td>
								<td class="padding2423" >
									<select id="cmbSTR_AFT_HOUR" style="width:40px" onChange="document.getElementById('cmbEND_AFT_HOUR').value = this.value;fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
									</select>:
                                    <select id="cmbSTR_AFT_MIN" style="width:40px" onChange="document.getElementById('cmbEND_AFT_MIN').value = this.value;fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="05">05</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>
                                    &nbsp;~&nbsp;
                                    <select id="cmbEND_AFT_HOUR" style="width:40px" onChange="fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                    </select>:
                                    <select id="cmbEND_AFT_MIN" style="width:40px" onChange="fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="05">05</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>
         						</td>
                            </tr>
                            <tr>
								<td align="center" class="creamBold">���籸��</td>
								<td class="padding2423" >
                                    <comment id="__NSID__">
                                        <object id=rdoREP_APP classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:14;width:220;">
                                            <param name=AutoMargin  value="true">
                                            <param name=Cols        value="3">
                                            <param name=Format      value="1^���ϱٹ�����,2^��ü�ް�,3^�̱ٹ�">
                                        </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
							</tr>
                            <tr>
								<td align="center" class="creamBold">��ü�ް�</td>
								<td class="padding2423" >
			 						<input type="text" id="txtREP_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgREP_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgREP_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtREP_YMD','','150','200');"></a>
                                    <comment id="__NSID__">
                                        <object id=rdoREP_TYP classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:14;width:90;">
                                            <param name=AutoMargin  value="true">
                                            <param name=Cols        value="2">
                                            <param name=Format      value="U^����,T^����">
                                        </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>

								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:none">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- ���缱 ���� ���̺� ���� -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:110px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='REQ_NO'	width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
			            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
			            					<C> id='DPT_NM'	width=80	name='�μ�'		align=center	show=false</C>
											<C> id='JOB_NM'	width=60	name='����'		align=center	</C>
											<C> id='ENO_NO'	width=100	name='���'		align=center	show=false</C>
											<C> id='ENO_NM'	width=70	name='����'		align=center	</C>
											<C> id='APP_YN'	width=160	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&APP_YMD} </C>
											<C> id='REMARK1'	width=60	name='����'	align=center 	Color='Blue'	</C>
											<C> id='REMARK'	width=60	name='����'		align=center	show=false</C>
										">
										<param name="wmode" value="transparent" >
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
			                </tr>
						  	<tr>
								<td align="right">
				                        <img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" >
				                        <img src="/images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >
								</td>
			                </tr>
			            </table>
			        	<!-- ���缱 ���� ���̺� �� -->
 					</td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				<!--	<td  align="right" valign="top">
				         <img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" >
				         <img src="/images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >
					</td> -->
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
						<object	id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				value="dsT_DI_HOLIDAYWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=30			name='NO'								align=center	value={String(Currow)}	</C>
								<C> id='JOB_NM'			width=50			name='����'								align=center													</C>
								<C> id='ENO_NO'			width=65			name='���'								align=center													</C>
								<C> id='ENO_NM'			width=65			name='����'								align=center													</C>
								<C> id='HOL_YMD'		width=80			name='�ٹ�����'							align=center													</C>
							    <G>name=������û����	HeadBgColor=#F7DCBB
  								  <C> id='STR_TIME'		width=65			name='���۽ð�'							align=center													</C>
                                  <C> id='END_TIME'		width=65			name='����ð�'						    align=center													</C>
                                  <C> id='TOT_TIME'		width=65			name='�ѱٹ��ð�'						align=center													</C>
				                </G>
				                <G>name=���ϱٹ���� 	HeadBgColor=#F7DCBB
			 	                  <C> id='STR_AFT_TIME'	width=65	    	name='���۽ð�'							align=center													</C>
                                  <C> id='END_AFT_TIME'	width=65		    name='����ð�'						    align=center													</C>
                                  <C> id='TOT_AFT_TIME'	width=65		    name='�ѱٹ��ð�'						align=center													</C>
				                  <C> id='REP_APP'		width=80			name='���籸��'						    align=center	value={Decode(REP_APP,'1','���ϱٹ�����','2','��ü�ް�','3','�̱ٹ�',' ')}	</C>
                                </G>
                                <G>name=��ü�ް�	 	HeadBgColor=#F7DCBB
   								  <C> id='REP_YMD'		width=80			name='��ü�ް���'						align=center													</C>
				                  <C> id='REP_TYP'		width=80			name='��������'						    align=center	value={Decode(REP_TYP,'U','����','T','����','')}	</C>
				                </G>
                                  <C> id='SIGN_TAG'     width=80 	        name='�������'        		            align=center    value={Decode(SIGN_TAG,'R','���','N','�ΰ�','Y','����Ϸ�','����')}                  </C>
                                  <C> id='REMARK'       width=250           name='�ٹ�����'                         align=left      Edit=none                  </C>

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
<object id="bndT_DI_HOLIDAYWORK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_HOLIDAYWORK">
	<Param Name="BindInfo", Value='
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD				Ctrl=txtJOB_CD	   			Param=value		</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
        <C>Col=STR_AFT_HOUR         Ctrl=cmbSTR_AFT_HOUR        Param=value     </C>
        <C>Col=STR_AFT_MIN          Ctrl=cmbSTR_AFT_MIN         Param=value     </C>
        <C>Col=END_AFT_HOUR         Ctrl=cmbEND_AFT_HOUR        Param=value     </C>
        <C>Col=END_AFT_MIN          Ctrl=cmbEND_AFT_MIN         Param=value     </C>
		<C>Col=REP_APP				Ctrl=rdoREP_APP				Param=CodeValue </C>
		<C>Col=REP_TYP				Ctrl=rdoREP_TYP				Param=CodeValue </C>
		<C>Col=REP_YMD				Ctrl=txtREP_YMD    		 	Param=value		</C>
        <C>Col=REMARK               Ctrl=txtREMARK              Param=value </C>
    '>
</object>