<!--
    ************************************************************************************
    * @source         : saga270.jsp 				                                   *
    * @description   : ����ȸ���� PAGE.                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+ *
    * 2011/09/06  |  �̵���   | ����ȸ����                                             *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>����ȸ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

        var savObj = new Array();
        
        var today = gcurdate;
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			dsT_Loan_Detail.ClearData();

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // ��ȯ���ؿ�
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ��ȯ���ؿ�

			//�������ڰ� ������ ��ȸ ����.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("��ȯ���ؿ� �Է��ϼ���.");
					document.getElementById("PIS_YYMM_SHR").focus();
					return false;
				}
			}

            //�����ͼ� ����
            dsT_Loan_Master.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR
																								            +"&ENO_NO_SHR="+ENO_NO_SHR;

            dsT_Loan_Master.Reset();

        }

		/***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }





        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			if (confirm("�����Ͻðڽ��ϱ�?")) {

					dsT_Loan_Temp.ClearData();

					var row = dsT_Loan_Temp.rowposition;

					var THeader = "ENO_NO:STRING(7),APPDT:STRING(10),APLDT:STRING(10),APPAMT:DECIMAL(9),REASON:STRING(50),EXE:STRING(1)";

					dsT_Loan_Temp.SetDataHeader(THeader);

					for(i=1;i<=dsT_Loan_Master.countrow;i++) {

						if (dsT_Loan_Master.SysStatus(i)==1||dsT_Loan_Master.SysStatus(i)==2||dsT_Loan_Master.SysStatus(i)==3){

							dsT_Loan_Temp.addrow();
							dsT_Loan_Temp.namevalue(1,"ENO_NO") = dsT_Loan_Master.namevalue(i,"ENO_NO");
							dsT_Loan_Temp.namevalue(1,"APPDT") 	= dsT_Loan_Master.namevalue(i,"APPDT");
							dsT_Loan_Temp.namevalue(1,"APLDT") 	= dsT_Loan_Master.namevalue(i,"APLDT");
							dsT_Loan_Temp.namevalue(1,"APPAMT") = dsT_Loan_Master.namevalue(i,"APPAMT");
							dsT_Loan_Temp.namevalue(1,"REASON") = dsT_Loan_Master.namevalue(i,"REASON");
							dsT_Loan_Temp.namevalue(1,"EXE") = dsT_Loan_Master.namevalue(i,"EXE");

							//Ʈ����� ����
							trT_Loan_Master.KeyValue = "SVL(I:SAV=dsT_Loan_Temp)";
							trT_Loan_Master.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SAV";
							trT_Loan_Master.Post();

						}

					}

				}

        }


		/******************************************************************************
			 ����2
		******************************************************************************/
		function fnc_SaveDetail(){

			if (dsT_Loan_Detail.countrow<2){
				alert ("������ ������ �����ϴ�.");
			}else {

				var str1 = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");

				if (confirm("�����Ͻðڽ��ϱ�?")) {

					//Ʈ����� ����
					trT_Loan_Detail.KeyValue = "SVL(I:SAV=dsT_Loan_Detail)";
					trT_Loan_Detail.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SAV_01&ENO_NO="+str1;
					trT_Loan_Detail.Post();



				}
			}
		}


		/******************************************************************************
			����3
		******************************************************************************/
		function fnc_SaveRep(){

		var str1 = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");

		var txtREP_DAY = document.getElementById("txtREP_YMD").value;

		if (document.getElementById("txtREP_YMD").value != "" && document.getElementById("cmbREPYN_TAG").bindcolval == 'Y') {

					var temp1 = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APBAMT");
					var temp2 = Trunc(ln_Calamt_End(dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APBAMT"), txtREP_DAY),0);
					var temp3 = temp1 + temp2;

					var temp4 = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APJAMT");
					var temp5 = 0;
					var temp6 = temp4 + temp5;

					alert("����1 : 25�Ͽ� �޿��������� �ʾ��� ���\n��ȯ �� �ܾ� = "+temp1 +"\n�ߵ���ȯ���� = " + temp2 + "\n�ߵ���ȯ �ݾ� = " + temp3 + "\n\n����2 : 25�Ͽ� �޿������Ǿ��� ���\n��ȯ �� �ܾ� = "+temp4 +"\n�ߵ���ȯ���� = " + temp5 + "\n�ߵ���ȯ �ݾ� = " + temp6 + "\n\n����� ����1�� �������� ���Ǿ� ���ϴ�.");
		
					if (confirm("�ߵ���ȯ�ϴ°��� �½��ϱ�?")) {


						if(txtREP_DAY.substring(0,7) != dsT_Loan_Master.namevalue(1,"APLDT").substring(0,7)) {                                   //��ȯȽ��

							dsT_Loan_Temp.ClearData();

							var row = dsT_Loan_Temp.rowposition;

							var THeader = "ENO_NO:STRING(7),REPDT:STRING(10),REPYN:STRING(1),REPMM:STRING(7),"

											+ "APBAMT:DECIMAL(9),APLAMT:DECIMAL(9),CALAMT:DECIMAL(9),APLDT:STRING(10)";

							dsT_Loan_Temp.SetDataHeader(THeader);

							for(i=1;i<=dsT_Loan_Master.countrow;i++) {

								if (dsT_Loan_Master.SysStatus(i)==1||dsT_Loan_Master.SysStatus(i)==2||dsT_Loan_Master.SysStatus(i)==3){

									dsT_Loan_Temp.addrow();

									dsT_Loan_Temp.namevalue(1,"ENO_NO") = dsT_Loan_Master.namevalue(i,"ENO_NO");
									dsT_Loan_Temp.namevalue(1,"REPDT")  = document.getElementById("txtREP_YMD").value;
									dsT_Loan_Temp.namevalue(1,"REPYN")  = dsT_Loan_Master.namevalue(i,"REPYN");
									dsT_Loan_Temp.namevalue(1,"REPMM")  = dsT_Loan_Master.namevalue(i,"REPDT").substring(0,7);
									dsT_Loan_Temp.namevalue(1,"APBAMT") = dsT_Loan_Master.namevalue(i,"APBAMT");							//�ߵ���ȯ�϶� ��ȯ�� �ܾ��� ��ȯ ������ �ȴ�!
									dsT_Loan_Temp.namevalue(1,"APLAMT") = dsT_Loan_Master.namevalue(i,"APBAMT");							//�ߵ���ȯ�϶� ��ȯ�� �ܾ��� ��ȯ ������ �ȴ�!
									dsT_Loan_Temp.namevalue(1,"CALAMT") = ln_Calamt_End(dsT_Loan_Master.namevalue(i,"APBAMT"), txtREP_DAY );     //���� ���ڸ� �����.
									dsT_Loan_Temp.namevalue(1,"APLDT")  = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APLDT");			//��ȯ����
								}
							}

							//Ʈ����� ����
							trT_Loan_Rep.KeyValue = "SVL(I:SAV=dsT_Loan_Temp)";
							trT_Loan_Rep.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SAV_REP";
							trT_Loan_Rep.Post();

							fnc_SearchList();


						}

						else { // ���� ���ڸ��� �ߵ� ��ȯ�ϴ� �� �̻��� ����!!!!

							dsT_Loan_Temp.ClearData();

							var row = dsT_Loan_Temp.rowposition;

							var THeader = "ENO_NO:STRING(7),REPDT:STRING(10),REPYN:STRING(1),REPMM:STRING(7),"

											+ "APBAMT:DECIMAL(9),APLAMT:DECIMAL(9),CALAMT:DECIMAL(9),APLDT:STRING(10)";

							dsT_Loan_Temp.SetDataHeader(THeader);

							for(i=1;i<=dsT_Loan_Master.countrow;i++) {

								if (dsT_Loan_Master.SysStatus(i)==1||dsT_Loan_Master.SysStatus(i)==2||dsT_Loan_Master.SysStatus(i)==3){

									dsT_Loan_Temp.addrow();
									dsT_Loan_Temp.namevalue(1,"ENO_NO") = dsT_Loan_Master.namevalue(i,"ENO_NO");
									dsT_Loan_Temp.namevalue(1,"REPDT")  = dsT_Loan_Master.namevalue(i,"REPDT");
									dsT_Loan_Temp.namevalue(1,"REPYN")  = dsT_Loan_Master.namevalue(i,"REPYN");
									dsT_Loan_Temp.namevalue(1,"REPMM")  = dsT_Loan_Master.namevalue(i,"REPDT").substring(0,7);
									dsT_Loan_Temp.namevalue(1,"APBAMT") = dsT_Loan_Master.namevalue(i,"APBAMT");							//�ߵ���ȯ�϶� ��ȯ�� �ܾ��� ��ȯ ������ �ȴ�!
									dsT_Loan_Temp.namevalue(1,"APLAMT") = dsT_Loan_Master.namevalue(i,"APBAMT");							//�ߵ���ȯ�϶� ��ȯ�� �ܾ��� ��ȯ ������ �ȴ�!
									dsT_Loan_Temp.namevalue(1,"CALAMT") = ln_Calamt(dsT_Loan_Master.namevalue(i,"APPAMT"), dsT_Loan_Master.namevalue(1,"APPDT") ) + ln_Calamt_End(dsT_Loan_Master.namevalue(i,"APBAMT"), dsT_Loan_Master.namevalue(i,"REPDT") );     //���� ���ڸ� �����.
									dsT_Loan_Temp.namevalue(1,"APLDT")  = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APLDT");			//��ȯ����
								}
							}

							//Ʈ����� ����
							trT_Loan_Rep.KeyValue = "SVL(I:SAV=dsT_Loan_Temp)";
							trT_Loan_Rep.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SAV_REP";
							trT_Loan_Rep.Post();

							fnc_SearchList();

						}

					}

					return false;

				}
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


			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; 	// ��������
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; 		// ���

			//�������ڰ� ������ ��ȸ����.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �߸��Ǿ����� ��ȸ����.

			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}


			dsT_RP_REPORT.ClearAll();
			ln_SetDataHeader();
			dsT_RP_REPORT.Addrow();
			dsT_RP_REPORT.namevalue(1,"MM") = " ����ȸ ���� ���� ���� ( "+PIS_YYMM_SHR+" �� )" ;
			dsT_RP_REPORT.namevalue(1,"PRINTDT") = today;
			dsT_RP_REPORT.namevalue(1,"CNT") = "�հ�" ;


			dsT_RP_REPORT2.ClearData();
            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SHR_PRINT&PIS_YYMM_SHR="+PIS_YYMM_SHR;
            dsT_RP_REPORT2.Reset();

			gcrp_print.Preview();


        }


		/*******************************************************************************
		  Description : ����Ÿ�� ���
		******************************************************************************/
		function ln_SetDataHeader(){
					if(dsT_RP_REPORT.countrow<1){
						var s_temp = "MM:STRING,PRINTDT:STRING,CNT:STRING";
						dsT_RP_REPORT.SetDataHeader(s_temp);
					}
		 }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_Loan_Detail.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            
            form1.grdT_Loan_Detail.GridToExcel("����ȸ����", '', 225);
        	
        	
        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            dsT_Loan_Detail.ClearData();
            dsT_Loan_Master.AddRow();
            //enableInput();	// �Է��ʵ� Ȱ��ȭ


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
			function fnc_Add(){

			}

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

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

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_Loan_Master.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

        	window.close();


        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_CP_PAYTABLE.isUpdated && dsT_CP_PAYTABLE.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
			cfStyleGrid_New(form1.grdT_Loan_Master,15,"true","true");
			cfStyleGrid_New(form1.grdT_Loan_Detail,15,"true","false");

            document.getElementById('txtPIS_YYMM_SHR').value = today.substring(0,7);

			var txtPIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");

			//disableInput();//�Է��ʵ� ��Ȱ��ȭ

            dsT_Loan_Master.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SHR&PIS_YYMM_SHR="+txtPIS_YYMM_SHR;
            dsT_Loan_Master.Reset();


        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17.
         ****************************/
         function fnc_FileUpload() {

        }

        /*****************************
         * 17.
         ****************************/
		function fnc_proc() {

		}

		/********************************************************************
         * 18.
         ********************************************************************/
        function fnc_AccountPopup() {


        }
        /********************************************************************
         * 19.
         ********************************************************************/
        function fnc_PrjPopup() {

        }
        /********************************************************************
         * 20.
         ********************************************************************/
        function fnc_VendorPopup() {


        }
        /********************************************************************
         * 21.
         ********************************************************************/
        function fnc_CostDeptPopup() {


        }
        /*************************
         * �׸��� ���� ó��      *
         ************************/
		function fnc_ChangeGrid() {


		}

        /********************************************************************
         * 21. ����
         ********************************************************************/

		function fnc_Run(){

			var THeader = "ENO_NO:STRING(7),APPDT:STRING(10),APLDT:STRING(10),APLCNT:DECIMAL(3),APPAMT:DECIMAL(9),"
									+ "APBAMT:DECIMAL(9),APLAMT:DECIMAL(9),APJAMT:DECIMAL(9),RATAMT:DECIMAL(9),CALAMT:DECIMAL(9),"
									+ "REPDT:STRING(10),REPYN:CHAR(1),AMT_1:DECIMAL(9),REASON:STRING(50),EXE:STRING(1)";

			dsT_Loan_Detail.SetDataHeader(THeader);

			for(j=1;j<=36;j++) {

				dsT_Loan_Detail.addrow();

				if (j!=36) {
						dsT_Loan_Detail.namevalue(j,"ENO_NO") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");			//���
						dsT_Loan_Detail.namevalue(j,"APPDT")  = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPDT");				//��������
						dsT_Loan_Detail.namevalue(j,"APPAMT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT");			//����ݾ�
						dsT_Loan_Detail.namevalue(j,"REASON") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"REASON");			//�������

						dsT_Loan_Detail.namevalue(j,"APLCNT") = j;                                    //��ȯȽ��

						if (j==1){
							dsT_Loan_Detail.namevalue(j,"APLDT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APLDT").replace("-", "").replace("-", "");;			//��ȯ����
						}else{
							dsT_Loan_Detail.namevalue(j,"APLDT") = ln_Aplday(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));					//��ȯ����
						}

						dsT_Loan_Detail.namevalue(j,"APLAMT") =  Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/36));	  //��ȯ����

						if (j==1){

							dsT_Loan_Detail.namevalue(j,"APBAMT") = ln_Apbamt(j,dsT_Loan_Detail.namevalue(j,"APPAMT"),0);     //��ȯ���ܾ�
							dsT_Loan_Detail.namevalue(j,"APJAMT") = ln_Apjamt(dsT_Loan_Detail.namevalue(j,"APPAMT"),dsT_Loan_Detail.namevalue(j,"APLAMT"));     //��ȯ���ܾ�
							dsT_Loan_Detail.namevalue(j,"CALAMT") = Math.floor((dsT_Loan_Detail.namevalue(j,"APBAMT")*0.03)/12) + ln_Calamt(dsT_Loan_Detail.namevalue(j,"APPAMT"), dsT_Loan_Detail.namevalue(j-1,"APPDT") );     //������ ���� ���ڸ� �����. ������� �� ����� ����.

						}else{

							dsT_Loan_Detail.namevalue(j,"APBAMT") = ln_Apbamt(j,dsT_Loan_Detail.namevalue(j-1,"APBAMT"),dsT_Loan_Detail.namevalue(j-1,"APLAMT"));     //��ȯ���ܾ�
							dsT_Loan_Detail.namevalue(j,"APJAMT") = ln_Apjamt(dsT_Loan_Detail.namevalue(j-1,"APJAMT"),dsT_Loan_Detail.namevalue(j-1,"APLAMT") );	//��ȯ�� �ܾ�
							dsT_Loan_Detail.namevalue(j,"CALAMT") = Math.floor((dsT_Loan_Detail.namevalue(j-1,"APJAMT")*0.03)/12);											//���������ݾ�.

						}//j==1 ���⼭ �� -_-;;;

						dsT_Loan_Detail.namevalue(j,"APLDT") = ln_Aplday(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));							//��ȯ����
						dsT_Loan_Detail.namevalue(j,"RATAMT") = Math.floor((dsT_Loan_Detail.namevalue(j,"APBAMT")*0.03)/12);

						var amt_01 = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/36));						//��ȯ����
						var amt_02 = Math.floor(dsT_Loan_Detail.namevalue(j,"CALAMT"));

						dsT_Loan_Detail.namevalue(j,"AMT_1")  = amt_01+amt_02;																	//��ȯ��


				}else{ // j==36 ���������� �ܱݵ��� ���� ó�����ش�.

					dsT_Loan_Detail.namevalue(j,"ENO_NO")  = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");		 //���
					dsT_Loan_Detail.namevalue(j,"APPDT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPDT");			//��������
					dsT_Loan_Detail.namevalue(j,"APPAMT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT");		//����ݾ�
					dsT_Loan_Detail.namevalue(j,"REASON") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"REASON");		//�������
					dsT_Loan_Detail.namevalue(j,"APLCNT") = j;																				//Ƚ��

					dsT_Loan_Detail.namevalue(j,"APLDT") = ln_Aplday(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));					//��ȯ����

					var appamt_eja = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/36));
					var appamt_won = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")));
					var appamt_jan = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/36))*36;

					dsT_Loan_Detail.namevalue(j,"APBAMT") = appamt_eja+(appamt_won-appamt_jan);								//��ȯ�� �ܾ�
					dsT_Loan_Detail.namevalue(j,"APJAMT") = 0;																					//��ȯ�� �ܾ� �� �о���.
					dsT_Loan_Detail.namevalue(j,"APLAMT") =  appamt_eja+(appamt_won-appamt_jan);								//��ȯ����	�°�...

					dsT_Loan_Detail.namevalue(j,"APLDT") = ln_Aplday(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));								//��ȯ����
					dsT_Loan_Detail.namevalue(j,"RATAMT") = Math.floor((dsT_Loan_Detail.namevalue(j,"APBAMT")*0.03)/12);				//��ȯ����
					dsT_Loan_Detail.namevalue(j,"CALAMT") = Math.floor(((appamt_eja+(appamt_won-appamt_jan))*0.03)/12);				//��ȯ����

					var amt_01 = dsT_Loan_Detail.namevalue(j,"APLAMT")												//��ȯ����
					var amt_02 = Math.floor(dsT_Loan_Detail.namevalue(j,"CALAMT"));								//��ȯ����

					dsT_Loan_Detail.namevalue(j,"AMT_1")  = amt_01+amt_02;										//��ȯ��

				}

		    //2011.08.31 JYS �߰�
				dsT_Loan_Detail.namevalue(j,"EXE") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"EXE");			//����������

			}//FOR

		}


		/******************************************************************************
			Description : �����ܾ� ,
			              cnt - Ƚ��, apjamt - �����ܾ�, aplamt - ��ȯ����
		******************************************************************************/
		function ln_Apbamt(cnt,apbamt,aplamt) {
			if(cnt==1){
				return apbamt
			}else{
		    apbamt = apbamt - aplamt
				return apbamt;
			}
		}

		/******************************************************************************
			Description : �����ܾ� ,
			              cnt - Ƚ��, apjamt - �����ܾ�, aplamt - ��ȯ����
		******************************************************************************/
		function ln_Apjamt(apjamt,aplamt) {
		    apjamt = apjamt - aplamt
				return apjamt;
		}

		/******************************************************************************
			Description : ���ʴ������� ���� ����ؼ� ����������ڿ� ���Ѵ�~
							  apjamt - �����ܾ�, aplamt - ��ȯ����
		******************************************************************************/
		function ln_Calamt(apjamt,aplday) {

				var yyyy = aplday.substr(0,4);
				var mm = aplday.substr(5,2);
				var dd = aplday.substr(8,2);


				var minus2;

				if(yyyy%4 == 0) {	//�����̸�
					if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31�Ϸ� ������
						minus2 = (31 - dd + 1)/31;
					}else if(mm == 2){			//29�Ϸ� ������
						minus2 = (29 - dd + 1)/29;
					}else{							//30�Ϸ� ������
						minus2 = (30 - dd + 1)/30;
					}
				}
				else{	//������ �ƴϸ�
					if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 08 || mm == 10 || mm == 12){	//31�Ϸ� ������
						minus2 = (31 - dd + 1)/31;
					}else if(mm == 2){			//28�Ϸ� ������
						minus2 = (28 - dd + 1)/28;
					}else{							//30�Ϸ� ������
						minus2 = (30 - dd + 1)/30;
					}
				}

				return apjamt*0.03/12*minus2;

		}


		/******************************************************************************
			Description : �ߵ���ȯ�������� ���� ���
							  apjamt - �����ܾ�, aplamt - ��ȯ����
		******************************************************************************/
		function ln_Calamt_End(apjamt,aplday) {

				var yyyy = aplday.substr(0,4);
				var mm = aplday.substr(5,2);
				var dd = aplday.substr(8,2);

				var minus2;

				if(yyyy%4 == 0) {	//�����̸�
					if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31�Ϸ� ������
						minus2 = ( dd - 1 )/31;
					}else if(mm == 2){			//29�Ϸ� ������
						minus2 = ( dd - 1 )/29;
					}else{							//30�Ϸ� ������
						minus2 = ( dd - 1 )/30;
					}
				}
				else{	//������ �ƴϸ�
					if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31�Ϸ� ������
						minus2 = ( dd - 1 )/31;
					}else if(mm == 2){			//28�Ϸ� ������
						minus2 = ( dd - 1 )/28;
					}else{							//30�Ϸ� ������
						minus2 = ( dd - 1 )/30;
					}
				}

				return apjamt*0.03/12*minus2;

		}

		/******************************************************************************
			Description : ��ȯ����
			              cnt - Ƚ��, aplday - ��ȯ����
		******************************************************************************/
		function ln_Aplday(cnt,aplday) {

			var yyyy="",mm="",dd="";

			yyyy = aplday.substr(0,4);
			mm = aplday.substr(4,2);
			dd = aplday.substr(6,2);

			if(cnt==1){
				return aplday;
			}else{
				if (mm=="12"){
						yyyy = Number(yyyy) + 1;
						mm="01";
		        return yyyy+mm+dd;
				}else{
		        mm = Number(mm) + 1;
						if(mm=="10"||mm=="11"||mm=="12"){
		        }else{
							mm="0"+mm;
						}
				    return yyyy + mm+ dd;
				}
			}
		}

		/******************************************************************************
			Description : ��ȯ����
			              apjamt-�����ܾ�
		******************************************************************************/
		function ln_RATAMT(apjamt) {

			var RATAMT=0;

			if (apjamt<=5000000){
				return 	RATAMT = Math.floor((apjamt*0.03)/12)
			}else{
				return RATAMT = Math.floor(((5000000*0.02) + (apjamt-5000000)*0.03)/12);
			}

		}




		/***********************
		* 	�����ȸ�� �˾�    *
		**********************/
		function fnc_EmplPop() {

		var obj = new String();

		obj.shr_kind = "SHR_02";
		obj.eno_nm = "";

		window.showModalDialog("../../common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		document.getElementById("txtENO_NO").value = obj.eno_no;
		document.getElementById("txtENO_NM").value = obj.eno_nm;

        document.getElementById("txtDPT_NM").value = obj.dpt_nm;
        document.getElementById("txtJOB_NM").value = obj.job_nm;

		}

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          	*
         ********************************************/
  		function enableInput(){

			document.form1.txtENO_NO.readOnly = false;
			document.form1.txtENO_NO.className = "";

			document.form1.txtENO_NM.readOnly = false;
			document.form1.txtENO_NM.className = "";

			document.form1.txtAPP_YMD.readOnly = false;
			document.form1.txtAPP_YMD.className = "";

			document.form1.cmbAPP_AMT.readOnly = false;
			document.form1.cmbAPP_AMT.className = "";

			document.form1.txtAPL_YMD.readOnly = false;
			document.form1.txtAPL_YMD.className = "";

			document.form1.cmbREASON_TAG.readOnly = false;
			document.form1.cmbREASON_TAG.className = "";

			document.form1.txtREP_YMD.readOnly = false;
			document.form1.txtREP_YMD.className = "";

			document.form1.cmbREPYN_TAG.readOnly = false;
			document.form1.cmbREPYN_TAG.className = "";

			document.form1.cmbEXE_TAG.readOnly = false;
			document.form1.cmbEXE_TAG.className = "";



  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)        *
         ********************************************/
  		function disableInput(){

			document.form1.txtENO_NO.readOnly = true;
			document.form1.txtENO_NO.className = "input_ReadOnly";

			document.form1.txtENO_NM.readOnly = true;
			document.form1.txtENO_NM.className = "input_ReadOnly";

			document.form1.txtAPP_YMD.readOnly = true;
			document.form1.txtAPP_YMD.className = "input_ReadOnly";

			document.form1.cmbAPP_AMT.readOnly = true;
			document.form1.cmbAPP_AMT.className = "input_ReadOnly";

			document.form1.txtAPL_YMD.readOnly = true;
			document.form1.txtAPL_YMD.className = "input_ReadOnly";

			document.form1.cmbREASON_TAG.readOnly = true;
			document.form1.cmbREASON_TAG.className = "input_ReadOnly";

			document.form1.cmbEXE_TAG.readOnly = true;
			document.form1.cmbEXE_TAG.className = "input_ReadOnly";

  		}
  		/********************************************
         * �� ���� �̵�         		*
         ********************************************/
  		function on_Move(a){



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
    | 2. �̸� : dsT_Loan_Master                     |
    | 3. Table List : T_AC_COLOAN                   |
    +----------------------------------------------->
    <Object ID="dsT_Loan_Master" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        	Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
		<param name="SortExpr"			value="+EXE">
		<param name="SubsumExpr"		value="Total,2:EXE">
    </Object>

    <Object ID="dsT_Loan_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_Loan_Temp" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>


   	<!-- ���� �޺��� ���� DataSet -->

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!----------------------------------------------+
    | 1. ����Ʈ�� DataSet                     		|
    | 2. �̸� : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
		<param name="SuppressColumns"   value="1:EXE">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
		<param name="SubsumExpr"		value="2:EXE">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->

    <Object ID ="trT_Loan_Master" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <Object ID ="trT_Loan_Detail" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <Object ID ="trT_Loan_Rep" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ��ȸ�� Data Transacton                |
    | 2. �̸� : trT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID ="trT_Loan_Master_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!--------------------------+
    | grid���� row�� Ŭ��������      |
    +------ -------------------->
	<script for=grdT_Loan_Master event=OnClick(Row,Colid)>

		var overId = "ENO_NO";

		var overValue = dsT_Loan_Master.NameValue(Row,overId);
		var EXE = dsT_Loan_Master.NameValue(Row,"EXE");
		var APPDT = dsT_Loan_Master.NameValue(Row,"APPDT");		
		
		try {

			dsT_Loan_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga270.cmd.SAGA270CMD&S_MODE=SHR_01&ENO_NO_SHR="+overValue+"&EXE="+EXE+"&APPDT="+APPDT;
			dsT_Loan_Detail.Reset();

		} catch ( exception ) {

			fcWindowsXpSp2Notice(false);

			return;

		}

	</script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_Loan_Master Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_Loan_Master.UserStatus(i) = 1;
            }

            if(dsT_Loan_Master.NameValue(1, "MNG_NO") == ''){
            //	enableInput();
            }

        }
    </Script>

    <Script For=dsT_Loan_Detail Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_Loan_Master Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_Loan_Detail Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_Loan_Rep Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_Loan_Master Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[��������/��������/����/���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("��������/�ٷα���/����/ȣ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=dsT_Loan_Detail Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_Loan_Master event="OnSuccess()">
    	alert("�⺻������ ����Ǿ����ϴ�. ���λ��� �ϰ������Ͻʽÿ�");
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        fnc_SearchList();
    </script>

    <script for=trT_Loan_Detail event="OnSuccess()">
		alert("���λ��� ������ �Ϸ�Ǿ����ϴ�");
    </script>

    <script for=trT_Loan_Rep event="OnSuccess()">
		alert("�ߵ���ȯ ������ �Ϸ�Ǿ����ϴ�");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_Loan_Master event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_Loan_Detail event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_Loan_Rep event="OnFail()">
        cfErrorMsg(this);
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
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
						<table width="1000" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="paddingTop8">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" class="blueTable">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<colgroup>
														<col width="100"></col>
														<col width="200"></col>
														<col width="100"></col>
														<col width=""></col>
													</colgroup>
													<tr>
													<td align="left" class="searchState">��ȯ���ؿ�</td>
													<td>
														<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
														<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','150');"></a>
													</td>
													<td align="center" class="searchState">�����ȣ</td>
													<td>
														<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
														<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
														<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
													</td>

													</tr>
												</table>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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

			<!-- ���� ȭ�� ����-->
			<table width="1000" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">

						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="400" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_Loan_Master" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:527px;">
						                            <param name="DataID"				value="dsT_Loan_Master">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"				value="Left">
						                            <param name="VIEWSUMMARY"			value=1>
						                            <param name="Format"						value="
														<FC> Name='��'				ID={CURROW}  	HeadAlign=Center Width=40   		align=center	SumBgColor=#C3D0DB</FC>
														<FC> Name='���'				ID=ENO_NO  		HeadAlign=Center Width=55		align=center	SumBgColor=#C3D0DB</FC>
														<FC> Name='����'				ID=ENO_NM 		HeadAlign=Center Width=60		align=center	SumBgColor=#C3D0DB</FC>
														<C> Name='�Ҽ�'				ID=DPT_NM  		HeadAlign=Center Width=100  	align=center	SumBgColor=#C3D0DB	SumText='��' </C>
														<C> Name='����'				ID=JOB_NM			HeadAlign=Center Width=60		align=center	SumBgColor=#C3D0DB</C>
														<C> Name='������'			ID=APPDT			HeadAlign=Center Width=80		align=center	SumBgColor=#C3D0DB</C>
														<C> Name='�����'			ID=APPAMT  		HeadAlign=Center Width=65		align=RIGHT		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='Ƚ��'				ID=APLCNT  		HeadAlign=Center Width=50		align=center	SumBgColor=#C3D0DB</C>
														<C> Name='��ȯ���ܾ�'		ID=APBAMT  		HeadAlign=Center Width=90		align=RIGHT		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='��ȯ����'			ID=APLAMT  		HeadAlign=Center Width=70		align=RIGHT		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='��ȯ���ܾ�'		ID=APJAMT  		HeadAlign=Center Width=90		align=RIGHT		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='��ȯ��'			ID=APLDT  			HeadAlign=Center Width=70		align=center	SumBgColor=#C3D0DB</C>
														<C> Name='����'				ID=CALAMT			HeadAlign=Center Width=70		align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='��ȯ��'			ID='AMT_1'  		HeadAlign=Center Width=80 		align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='�������'			ID=REASON  		HeadAlign=Center Width=80 		align=center	SumBgColor=#C3D0DB	value={if(REASON='1','��ȥ',IF(REASON='2','���ڱ�',IF(REASON='3','����',IF(REASON='4','��Ÿ',''))))}</C>
														<C> Name='�ߵ���ȯ'			ID=REPYN  			HeadAlign=Center Width=70 		align=center	SumBgColor=#C3D0DB	value={if(REPYN='Y','��ȯ',IF(REPYN='N','�̻�ȯ',''))}</C>
														<C> Name='�ߵ���ȯ'			ID=REPDT  			HeadAlign=Center Width=80		align=center	SumBgColor=#C3D0DB	show=false</C>
														<C> Name='��/����'			ID='EXE'  			HeadAlign=Center Width=80		align=center	SumBgColor=#C3D0DB	value={if(EXE='0','����',IF(EXE='1','�ӿ�',''))} suppress=1</C>
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


			<!-- ���� ȭ�� ��-->
		</td>
		<td width=5></td>
		<td>
			<!-- ������ ȭ�� ����-->
			<table width="495" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td>
						<!-- ���� �Է� ���̺� ���� -->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="495" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width=""></col>

										</colgroup>
										<tr>
											<td align="center" class="blueBold">���</td>
											<td class="padding2423">
												<input id="txtENO_NO" name="txtENO_NO" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO','txtENO_NM');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO','txtENO_NM');fnc_SearchList();" style="ime-mode:disabled">
												<input id="txtENO_NM" name="txtENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO');fnc_SearchList();">

						                        <input type="hidden" id="txtDPT_NM" name="txtDPT_NM">
						                        <input type="hidden" id="txtJOB_NM" name="txtJOB_NM">

												<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){return;} fnc_EmplPop();""></a>
											</td>
										</tr>

										<tr>
											<td align="center" class="blueBold">����</td>
											<td class="padding2423">

												<comment id="__NSID__">
												<object id=cmbEXE_TAG classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
												<param name="CBData" 			value="0^������������,1^�ӿ���������">
												<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME">
												<param name="Index" 			value="0">
												<param name="SearchColumn" 		value="COM_SNAME">
												<param name="ListExprFormat" 	value="COM_SNAME^0^100">
												<param name="BindColumn" 		value="COM_CODE">
												<param name="ComboStyle"  		value="2">
												<param name="Enable" 			value="true">
												</object>
												</comment><script> __ShowEmbedObject(__NSID__); </script>

											</td>

										</tr>

										<tr>
											<td align="center" class="blueBold">������</td>
											<td class="padding2423">
												<input id="txtAPP_YMD" style="width:30%;padding-left:6" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgAPP_YMD" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtAPP_YMD','','500','200');"></a>
											</td>
										</tr>

										<tr>
											<td align="center" class="blueBold">�����</td>

											<td class="padding2423">
												<comment id="__NSID__">
												<object id=cmbAPP_AMT classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
												<param name="CBData" 			value="1000000^1�鸸��,2000000^2�鸸��,3000000^3�鸸��,4000000^4�鸸��,5000000^5�鸸��" />
												<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME">
												<param name="Index" 			value="0">
												<param name="SearchColumn" 		value="COM_SNAME">
												<param name="ListExprFormat" 	value="COM_SNAME^0^100">
												<param name="BindColumn" 		value="COM_CODE">
												<param name="ComboStyle"  		value="2">
												<param name="Enable" 			value="true">
												</object>
												</comment><script> __ShowEmbedObject(__NSID__); </script>
											</td>

										</tr>
										<tr>
											<td align="center" class="blueBold">��ȯ��</td>
											<td class="padding2423">

												<input id="txtAPL_YMD" style="width:30%;padding-left:6" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPL_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgAPL_YMD" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtAPL_YMD','','500','200');"></a>

											</td>
										</tr>

										<tr>
											<td align="center" class="blueBold">�������</td>
											<td class="padding2423">

												<object id=cmbREASON_TAG classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 style="position:relative;left:0px;top:2px;font-size:12px;width:112px;">
												<param name="CBData" 			value="1^��ȥ,2^���ڱ�,3^����,4^��Ÿ">
												<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME">
												<param name="Index" 			value="0">
												<param name="SearchColumn" 		value="COM_SNAME">
												<param name="ListExprFormat" 	value="COM_SNAME^0^100">
												<param name="BindColumn" 		value="COM_CODE">
												<param name="ComboStyle"  		value="2">
												<param name="Enable" 			value="true">
												</object>

												&nbsp;&nbsp;



											</td>
										</tr>

										<tr>



											<td align="center" class="blueBold">�ߵ���ȯ</td>
											<td class="padding2423">
												<input id="txtREP_YMD" style="width:30%;padding-left:6" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgREP_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgREP_YMD" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtREP_YMD','','390','150');"></a>

											    &nbsp;


												<comment id="__NSID__">
												<object id=cmbREPYN_TAG classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 style="position:relative;left:0px;top:2px;font-size:12px;width:70px;">
												<param name="CBData" 					value="N^�̻�ȯ,Y^��ȯ" />
												<param name="CBDataColumns" 			value="COM_CODE,COM_SNAME">
												<param name="Index" 						value="0">
												<param name="SearchColumn" 			value="COM_SNAME">
												<param name="ListExprFormat" 			value="COM_SNAME^0^60">
												<param name="BindColumn" 				value="COM_CODE">
												<param name="ComboStyle"  				value="2">
												<param name="Enable" 						value="true">
												</object>
												</comment><script> __ShowEmbedObject(__NSID__); </script>
												&nbsp;

									            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">
									            <img src="../../images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SaveRep();">
									            </a>

											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
						<!-- ���� �Է� ���̺� �� -->

						<!-- ��ȸ ���� ���̺� ���� -->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="paddingTop8">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										<td  align="right" style="padding-top:3px;position:relative;left:-4px;top:1px;"><nobr>&nbsp;
            								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">
            								<img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_SaveDetail()"></a>
            								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">
            								<img src="../../images/button/BatchCreateOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Run()"></a>
            								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> 
            								<img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
										</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- ��ȸ ���� ���̺� �� -->

						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_Loan_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:310px;">
						                            <param name="DataID"						value="dsT_Loan_Detail">
						                            <param name="EdiTABLE"					value="false">
						                            <param name="DragDropEnable"			value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"			value=1>
						                            <param name="Format"						value="
														<C> Name='��'			ID={CURROW} 	HeadAlign=Center Width=25  		align=center	SumBgColor=#C3D0DB </C>
														<C> Name='��ȯ���ܾ�'	ID=APBAMT 		HeadAlign=Center Width=80	 	align=right		SumBgColor=#C3D0DB SumText='�հ�'</C>
														<C> Name='��ȯ���ܾ�'	ID=APJAMT 		HeadAlign=Center Width=80	 	align=right		SumBgColor=#C3D0DB </C>
														<C> Name='��ȯ��'		ID=APLDT 		HeadAlign=Center Width=70	 	align=center 	SumBgColor=#C3D0DB </C>
														<C> Name='��ȯ����'		ID=APLAMT 		HeadAlign=Center Width=70	 	align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='����'			ID=CALAMT		HeadAlign=Center Width=60  		align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='��ȯ��'		ID='AMT_1' 		HeadAlign=Center Width=70		align=right 		SumBgColor=#C3D0DB SumText=@sum	</C>
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

					</td>
				</tr>
			</table>
			<!-- ������ ȭ�� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    		value="dsT_RP_REPORT2">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" 					VALUE="


<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=390 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=793 ,top=6 ,right=2200 ,bottom=107 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='��' ,left=32 ,top=295 ,right=92 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=92 ,top=295 ,right=192 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=192 ,top=295 ,right=292 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ҽ�' ,left=289 ,top=295 ,right=488 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=485 ,top=295 ,right=578 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>


	<T>id='���' ,left=586 ,top=295 ,right=731 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1251 ,top=295 ,right=1450 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=1072 ,top=295 ,right=1271 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=884 ,top=295 ,right=1083 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=719 ,top=295 ,right=890 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����+����' ,left=2476 ,top=295 ,right=2632 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MM', left=800, top=14, right=2100, bottom=98, face='HY������M', size=20,  forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=12 ,top=208 ,right=2817 ,bottom=208 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�� �� �� �� Ȳ' ,left=35 ,top=217 ,right=1450 ,bottom=292 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޿�����' ,left=2476 ,top=217 ,right=2632 ,bottom=292 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܾ�' ,left=2635 ,top=220 ,right=2814 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PRINTDT', left=2614, top=115, right=2817, bottom=153, align='right', face='����', size=9, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2349 ,top=107 ,right=2612 ,bottom=153 ,align='right' ,face='����' ,size=9 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=12 ,top=384 ,right=2817 ,bottom=384 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1959 ,top=205 ,right=1959 ,bottom=387 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2470 ,top=205 ,right=2470 ,bottom=387 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=205 ,right=1450 ,bottom=387 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2632 ,top=208 ,right=2632 ,bottom=390 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���� : ��' ,left=2614 ,top=159 ,right=2817 ,bottom=202 ,align='right' ,face='����' ,size=9 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=292 ,top=295 ,right=292 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=95 ,top=295 ,right=95 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=185 ,top=295 ,right=185 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=482 ,top=295 ,right=482 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=586 ,top=295 ,right=586 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=728 ,top=295 ,right=728 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=884 ,top=295 ,right=884 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=295 ,right=1069 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=295 ,right=1265 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=295 ,right=1598 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1676 ,top=295 ,right=1676 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=295 ,right=2230 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=12 ,top=208 ,right=12 ,bottom=387 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2817 ,top=208 ,right=2817 ,bottom=387 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='���ڻ�ȯ����' ,left=1964 ,top=217 ,right=2470 ,bottom=292 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=2000 ,top=295 ,right=2200 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȯ���ڴ���' ,left=2239 ,top=303 ,right=2464 ,bottom=364 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȯ���ݴ���' ,left=1687 ,top=303 ,right=1947 ,bottom=370 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȯ����' ,left=1450 ,top=300 ,right=1603 ,bottom=376 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȸ��' ,left=1600 ,top=341 ,right=1676 ,bottom=381 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȯ' ,left=1600 ,top=298 ,right=1676 ,bottom=338 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݻ�ȯ����' ,left=1459 ,top=217 ,right=1950 ,bottom=286 ,face='����' ,size=8 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=20 ,top=292 ,right=2629 ,bottom=292 </L>
</B>


<B>id=default ,left=0,top=0 ,right=2869 ,bottom=70 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=35, top=0, right=95, bottom=66, face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='{decode(curlevel,2,\'�Ұ�\',EXENMK)}' left=95, top=0, right=195, bottom=66, supplevel=2,	align='center', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='REASONK', left=195, top=0, right=295, bottom=66, align='left', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='DPT_NM', left=295, top=0, right=491, bottom=66, align='left', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=485, top=0, right=586, bottom=66, align='left', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NO', left=586, top=0, right=728, bottom=66, face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=734, top=0, right=884, bottom=66, align='left', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPDT', left=881, top=0, right=1080, bottom=66 , face='����', size=8, mask='XXXX/XX/XX', forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPAMT', left=1072, top=0, right=1268, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=1251, top=0, right=1450, bottom=66 , face='����', size=8, mask='XXXX/XX/XX', forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT', left=1450, top=0, right=1600, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLCNT', left=1600, top=0, right=1676, bottom=66, face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT_SUM', left=1687, top=0, right=1950, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALAMT', left=2037, top=0, right=2190, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RATAMT_SUM', left=2239, top=0, right=2464, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT_RATAMT', left=2470, top=0, right=2629, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APJAMT', left=2635, top=0, right=2814, bottom=66, align='right', face='����', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<L> left=12 ,top=0 ,right=12 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=12 ,top=69 ,right=2820 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2470 ,top=0 ,right=2470 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2632 ,top=0 ,right=2632 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=95 ,top=3 ,right=95 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=185 ,top=3 ,right=185 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=292 ,top=3 ,right=292 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=482 ,top=3 ,right=482 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=728 ,top=3 ,right=728 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=586 ,top=3 ,right=586 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=881 ,top=3 ,right=881 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=3 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1676 ,top=3 ,right=1676 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=3 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=3 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2817 ,top=0 ,right=2817 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1959 ,top=0 ,right=1959 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2233 ,top=3 ,right=2233 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>




<B>id=LDFooter ,left=0,top=0 ,right=2869 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=12 ,top=3 ,right=2817 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{Sum(APPAMT)} ', left=1072, top=3, right=1268, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_APLRAT)}', left=2470, top=3, right=2629, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(BALANCE)}', left=2640, top=3, right=2817, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=12 ,top=0 ,right=12 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1959 ,top=0 ,right=1959 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2470 ,top=0 ,right=2470 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2632 ,top=0 ,right=2632 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1676 ,top=0 ,right=1676 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=0 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=0 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=0 ,right=2230 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2817 ,top=0 ,right=2817 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='CNT', left=32, top=0, right=1046, bottom=66, face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=12 ,top=66 ,right=2820 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{SUM(APLAMT)}', left=1450, top=3, right=1600, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_SUM)}', left=1704, top=3, right=1947, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(CALAMT)}', left=1999, top=3, right=2204, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(RATAMT_SUM)}', left=2239, top=3, right=2476, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_RATAMT)}', left=2470, top=3, right=2629, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APJAMT)}', left=2635, top=3, right=2814, bottom=69, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
</B>


	<B>id=Footer ,left=0 ,top=1894 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=8 ,top=0 ,right=2818 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
		<I>id='../../images/common/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
	</B>



">
</OBJECT>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(Bind Component)                                          *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                        |
    | 2. �̸� : bndT_Loan_Detail                    |
    | 3. Table List : T_AC_COLOAN                   |
    +----------------------------------------------->
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_Loan_Master">
		<Param Name="BindInfo", Value="
			<C>Col='ENO_NO'			Ctrl='txtENO_NO'				Param=value			</C>
			<C>Col='ENO_NM'			Ctrl='txtENO_NM'				Param=value			</C>
			<C>Col='DPT_NM'			Ctrl='txtDPT_NM'				Param=value			</C>
			<C>Col='JOB_NM'			Ctrl='txtJOB_NM'				Param=value			</C>
			<C>Col='APPDT'			Ctrl='txtAPP_YMD'				Param=value			</C>
			<C>Col='APPAMT'			Ctrl='cmbAPP_AMT'			Param=bindcolval		</C>
			<C>Col='APLDT'			Ctrl='txtAPL_YMD'				Param=value			</C>
			<C>Col='REASON'			Ctrl='cmbREASON_TAG'		Param=bindcolval		</C>
			<C>Col='REPDT'			Ctrl='txtREP_YMD'				Param=value			</C>
			<C>Col='REPYN'			Ctrl='cmbREPYN_TAG'		Param=bindcolval		</C>
			<C>Col='EXE'				Ctrl='cmbEXE_TAG'			Param=bindcolval		</C>
	    ">
	</object>










