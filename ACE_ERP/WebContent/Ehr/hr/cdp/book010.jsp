<!--
*****************************************************
* @source       : BOOK010.jsp
* @description : �������Խ�û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/15      �̵���        �����ۼ�
*----------------------------------------------------------------------
* 2016/06/01    |  ������   | �ҽ�����                                              *
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�������Խ�û</title>
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




        var param = window.dialogArguments;
		var chkValid  = 'T';
		var rq_seq = 0;
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//������û��Ȳ ���� ��ȸ
            //var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var rqst_no = param.req_no;

			dsT_ED_BOOKMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR&REQ_NO="+rqst_no;
			dsT_ED_BOOKMASTER.reset();


			dsT_ED_BOOKDETAIL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_02&REQ_NO="+rqst_no;
			dsT_ED_BOOKDETAIL.reset();

            //������ ��ȸ
            fnc_SearchApprover();


        }

        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {

            var REQ_NO  = param.req_no;

            dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=Q";
            dsT_DI_APPROVAL.Reset();
        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //��û��ȣ ��ȸ
            dsRQST_NO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_03";
			dsRQST_NO.reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			chkValid = "T";

			fnc_Valid();  //��ȿ�� �˻� �� �۾�

            if(chkValid == "F"){
             //  alert("�������� ��û�۾��� ��ҵǾ����ϴ�.");
              return;
            }

            //��û��ȣ ����
			fnc_SearchItem();

            var RQST_NO = dsRQST_NO.NameValue(1,"RQST_NO");

            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "RQST_REMARK") = document.getElementById("txtREMARK").value;

			trT_ED_BOOKMASTER.KeyValue = "tr01(I:dsT_ED_BOOKMASTER=dsT_ED_BOOKMASTER, I:dsT_ED_BOOKDETAIL=dsT_ED_BOOKDETAIL, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";

			trT_ED_BOOKMASTER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SAV&REQ_NO="+RQST_NO;
			
			trT_ED_BOOKMASTER.post();


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

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			fnc_First();

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_ED_BOOKMASTER.CountColumn == 0) {
                dsT_ED_BOOKMASTER.setDataHeader("ENO_NO:STRING:NOTNULL, ENO_NM:STRING:NOTNULL, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, RQST_NO:STRING, RQST_REMARK:STRING,  RQST_YMD:STRING");
            }
            
          
			// �� �߰�
			dsT_ED_BOOKMASTER.AddRow();
			

            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "ENO_NO")  = gusrid;
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "ENO_NM")  = gusrnm;
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "DPT_CD")  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "DPT_NM")  = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "JOB_CD")  = dsVI_T_PERSON.NameValue(0,"JOB_CD");
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "JOB_NM")  = dsVI_T_PERSON.NameValue(0,"JOB_NM");
             
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "RQST_YMD") = gcurdate;

			document.form1.txtREMARK.focus();

        }

        /******************
         * 08. ��ȿ�� �˻� *
         ******************/
        function fnc_Valid() {


			if (!dsT_ED_BOOKMASTER.IsUpdated ) {
                alert("dsT_ED_BOOKMASTER �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

			if (!dsT_ED_BOOKDETAIL.IsUpdated) {
                alert("���� �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

			if (!dsT_DI_APPROVAL.IsUpdated ) {
                alert("���缱�� �������� �ʾҽ��ϴ�");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}




/*
            //�ش����� ������ �߰�����.
            var HOL_YMD_SHR  = document.getElementById("txtHOL_YMD_SHR").value;      //���ϱٹ�����.
            var ENO_NO_SHR   = document.getElementById("txtENO_NO_SHR").value;       //��ȸ�� �����ȣ
			var DIL_AUTHO    = ""


			if((DIL_AUTHO == "M") || (DIL_AUTHO == "A")){
			fnc_ChangeStateElement(true, "txtENO_NO");
			fnc_ChangeStateElement(true, "txtENO_NM");
			fnc_ChangeStateElement(true, "ImgEnoNo");

            }else{
				fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
				fnc_ChangeStateElement(false, "ImgDptCd");
				fnc_ChangeStateElement(false, "txtENO_NO");
				fnc_ChangeStateElement(false, "txtENO_NM");
				fnc_ChangeStateElement(false, "ImgEnoNo");
	            document.getElementById("txtENO_NO").value = gusrid;
	            document.getElementById("txtENO_NM").value = gusrnm;
	            document.getElementById("txtJOB_CD").value = dsVI_T_PERSON.NameValue(0,"JOB_CD");


				document.getElementById("approval_btn").style.display = "none";
			}
*/
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
		function fnc_Append(){

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_ED_BOOKDETAIL.CountColumn == 0) {
                dsT_ED_BOOKDETAIL.setDataHeader("RQST_NO:STRING, RQST_SEQ:STRING, BOOK_NM:STRING, BOOK_PUL:STRING, BOOK_WRT:STRING, BOOK_QTY:STRING, BOOK_AMT:STRING, END_TAG:STRING, HOMEPAGE:STRING, BOOK_REMARK:STRING");
            }

			// �� �߰�
            dsT_ED_BOOKDETAIL.AddRow();

			rq_seq = rq_seq + 1;

            dsT_ED_BOOKDETAIL.NameValue(dsT_ED_BOOKDETAIL.RowPosition, "RQST_NO")  = dsRQST_NO.NameValue(dsRQST_NO.RowPosition, "RQST_NO");
            dsT_ED_BOOKDETAIL.NameValue(dsT_ED_BOOKDETAIL.RowPosition, "RQST_SEQ") = rq_seq;

		}


        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_BOOKDETAIL.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			dsT_ED_BOOKDETAIL.DeleteRow(dsT_ED_BOOKDETAIL.RowPosition);


        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_First() {

			dsT_ED_BOOKMASTER.ClearData();
			dsT_ED_BOOKDETAIL.ClearData();
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("resultMessage").innerText = ' ';

			chkValid = "T";

        }

        function fnc_Clear() {

			dsT_ED_BOOKMASTER.ClearData();
			dsT_ED_BOOKDETAIL.ClearData();
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("resultMessage").innerText = ' ';

			chkValid = "T";

			fnc_OnLoadProcess();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_ED_BOOKMASTER.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}

			window.close();

        }


        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

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

            fnc_ShowElement("imgSave");
            fnc_ShowElement("imgAppend");
            fnc_ShowElement("imgRemove");
            fnc_HiddenElement("imgReport");

			cfStyleGrid_New(form1.grdT_ED_BOOKDETAIL,15,"true","false")      // Grid Style ����

        	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			
			
			//�������� �ҷ����� �߰�  ( ����, �Ҽ�   ������ �����.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();

			fnc_AddNew();


            //�������ڸ��� �� �ε�
            //fnc_SearchList();
            document.getElementById("resultMessage").innerText = '�۾�����: �뵵> (�߰���ư) �Ʒ� �׸��忡 ������û > ���缱���� > ���� > ��� ';

	        dsT_DI_APPROVAL.SetDataHeader(

								"ENO_NO:STRING(10),"+			// �����ڻ��
								"ENO_NM:STRING(10),"+			// �����ڸ�
								"DPT_CD:STRING(6),"+			// ���ºμ�
								"DPT_NM:STRING(10),"+			// ���ºμ���
								"JOB_CD:STRING(10),"+			// ����������
								"JOB_NM:STRING(10),"+			// ������
								"SEQ_NO:STRING(2),"+			// ���缱
	        					"GUN_YMD:STRING(10),"+			// ���³�¥
								"PENO_NO:STRING(10),"+			// ����ڻ��
	                            "GUN_GBN:STRING(1),"+			// ���°��籸��
								"REQ_NO:STRING(10),"+			//
								"APP_YN:STRING(10)"				// ���翩��

								);
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

            var DPT_CD =  dsVI_T_PERSON.NameValue(0,"DPT_CD");

			var EMP_NO =  gusrid;

            var RQST_YMD = document.getElementById("txtRQST_YMD").value;

			RQST_YMD = RQST_YMD.replace("-","").replace("-","")

            //ds�� ���Ϲ޴´�.
            dsT_DI_APPROVAL.DeleteAll();

            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "Q");

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);

            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){

                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") =  i;	//���缱(�������)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = RQST_YMD;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = gusrid;	//����� ���
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "Q";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";

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
	            } else if (dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2070019") {
	            		appNum_2YN = "Y";
				//} else if(dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2110003") {
	            //		appNum_3YN = "Y";
	            }
	         }
            //�������� ���������� ���� �����ͼ¿� ������� �⺻���� Setting(ǰ�ǹ�ȣ,�����������)

			for(var i = appNum; i<=appNum+1; i++) {

				var r;

				if (i == appNum) {
	            		if (appNum_1YN == "Y" )  continue;
	            		obj = fnc_GetCommonEnoObj_DH("2030007");
						r = "9";
	            } else if (i == appNum + 1) {
	            		if (appNum_2YN == "Y" )  continue;
	            		obj = fnc_GetCommonEnoObj_DH("2070019");
						r = "8";
	            //} else if (i == appNum + 2) {
	            //		if (appNum_3YN == "Y" )  continue;
	            //		obj = fnc_GetCommonEnoObj_DH("2110003");
				//		r = "7";
	            }

	           	dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = "9"+r;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_GBN") = "Q";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"PENO_NO") = gusrid;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"REQ_NO") = document.getElementById("txtRQST_YMD").value;

			}

		}




        /**
         * ���ó��
         */
        function fnc_Conduct() {


            if(dsT_ED_BOOKMASTER.CountRow < 1){
              alert("��Ű����� �������Խ�û������ �����ϴ�");
              return;
            }

            if(dsT_ED_BOOKDETAIL.CountRow < 1){
              alert("��Ű����� �������Խ�û������ �����ϴ�");
              return;
            }

            //1.���ó�� ������
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("���缱�� �������ּ���.");
                return;
            }

            //2.���ó��

            var RQST_YMD = document.getElementById("txtRQST_YMD").value;
			var GUN_YMD = RQST_YMD.replace("-","").replace("-","")
            //var DPT_CD  = document.getElementById("hidDPT_CD_ORI").value;
			var DPT_CD  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			var REQ_NO  = dsRQST_NO.NameValue(1,"RQST_NO");

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +"R"
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"Q"
                                      + "&GUN_DPT=" +DPT_CD
                                      + "&REQ_NO="	+REQ_NO;

			trT_DI_APPROVAL.post();

        }



        //�Է� element
        var elementList = new Array( 	"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_HOL_HOUR"
                                        ,"cmbSTR_HOL_MIN"
                                        ,"cmbEND_HOL_HOUR"
                                        ,"cmbEND_HOL_MIN"
                                        ,"txtREMARK" );

        //���� �׸�
        var exceptionList = new Array(  "txtENO_NO"
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
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsRQST_NO                           |
    | 3. Table List :             					|
    +----------------------------------------------->
    <Object ID="dsRQST_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ED_BOOKDETAIL                   |
    | 3. Table List : T_ED_BOOKDETAIL               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKDETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_HOLIDAY                      |
    | 3. Table List : T_DI_HOLIDAY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�ּ�)              |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)      |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)        |
    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
	  <Param Name="UseChangeInfo"   Value="True">
	  <Param Name="ViewDeletedRow"  Value="False">
	 </Object>
    

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_HOLIDAYWORK)	|
    | 3. ���Ǵ� Table List(T_DI_HOLIDAYWORK)	        |
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ED_BOOKDETAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_HiddenElement("imgReport");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			fnc_ShowElement("imgReport");
        }
        var APP_YN  = dsT_DI_HOLIDAYWORK.NameString(1, "END_TAG");  //������ ���� ���� '':����, 'R':���, 'Y':����, 'N':�ΰ�

            if(APP_YN == "" || APP_YN == "N") {
                fnc_ShowElement("imgSelectapproval");
                fnc_ShowElement("imgReport");
                fnc_ShowElement("imgSave");
                fnc_ShowElement("imgAppend");
                fnc_ShowElement("imgRemove");

			}else if(APP_YN == "R" || APP_YN == "Y") { // ������� ��� �����ư �Ⱥ��̰�.. �� ���¿��� ���� �� �ð��ٲ� �����Ҽ��ִ�.
			        fnc_HiddenElement("imgSave");
		            fnc_HiddenElement("imgAppend");
                    fnc_HiddenElement("imgRemove");
    	            fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");
	                fnc_DisableElementAll(elementList);
	                document.getElementById("resultMessage").innerText = "* ����� �Ϸ�Ǿ����ϴ�. �������̹Ƿ� �۾��� �Ұ��մϴ�. *. ";
                    }
    </Script>

    <!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    if (iCount >= 1)    {
			        fnc_HiddenElement("imgSave");
		            fnc_HiddenElement("imgAppend");
                    fnc_HiddenElement("imgRemove");
    	            fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");
	                fnc_DisableElementAll(elementList);
	                document.getElementById("resultMessage").innerText =  '** ����� �Ϸ�Ǿ����ϴ�. �������̹Ƿ� �۾��� �Ұ��մϴ�. **';

             for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
				if(dsT_DI_APPROVAL.NameValue(i,"APP_YN") == "N"){
	                fnc_ShowElement("imgSelectapproval");
    	            fnc_ShowElement("imgReport");
        	        fnc_ShowElement("imgSave");
            	    fnc_ShowElement("imgAppend");
                	fnc_ShowElement("imgRemove");
                	document.getElementById("resultMessage").innerText =  '** �ΰ����! �۾��� �����մϴ�. **';
					break;
					}
            }
     }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_ED_BOOKDETAIL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ED_BOOKMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("����Ǿ����ϴ�\n����� ���ؼ��� ��Ź�ư�� �����ּ���");

        fnc_ShowElement("imgReport");

    </script>

    <script for=trT_DI_APPROVAL event="OnSuccess()">

		alert("��ŵǾ����ϴ�");
        //document.getElementById("resultMessage").innerText = "���ó���Ǿ����ϴ�";
        //fnc_HiddenElement("imgReport");
		fnc_OnLoadProcess();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ED_BOOKMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|
    +------------------------------------------->
	<script language="javascript"  for=dsT_DI_HOLIDAYWORK  event=OnRowPosChanged(row)>

        var today   = fnc_covNumber(getToday());

        if(row > 0) {

                //��������̰ų� �ΰ��϶� ������ ������

          if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
          		|| dsT_DI_APPROVAL.NameString(2, "APP_YN") == "N"	|| dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N") {
                    //�ű��� ���
                    if(dsT_DI_HOLIDAYWORK.RowStatus(row) == "1") {  //�ű�

                        fnc_EnableElementAll(elementList);

                    } else {
                        fnc_EnableElementAll(elementList, exceptionList);   //�ű��̿�
                    }
                }
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">-->

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <img src="../../images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<table border="0">
	<tr>
		<td valign="top">
			<!-- ���� �Է� ���̺� ���� -->
			<table width="450" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="80"></col>
                                <col width="100"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="blueBold">��û��</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"  class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14" class="input_ReadOnly"  readonly>
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">�Ҽ�</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                                <td align="center" class="blueBold">����</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="blueBold">��û��</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtRQST_YMD" name="txtRQST_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '��û����');" onkeypress="cfDateHyphen(this);cfCheckNumber();setStrEndDate(this.value);">
			                        <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRQST_YMD','','../../images/button/btn_HelpOver.gif',1)">
			                        <img src="../../images/button/btn_HelpOn.gif" id="ImgRQST_YMD" name="ImgRQST_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRQST_YMD','','36','227');"></a> -->
                                </td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">�뵵</td>
                                <td class="padding2423" colspan ="3">
                                    <input id="txtREMARK" style="width=100%" onKeyUp="fc_chk_byte(this,50)">
                                </td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:">
			<table width="530" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- ���缱 ���� ���̺� ���� -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:545px;height:110px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='SEQ_NM'	width=80		name='����'			align=center	Value={IF(SEQ_NO = '9','����', '����')}</C>
											<C> id='JOB_NM'	width=80		name='����'			align=center	</C>
											<C> id='ENO_NM'	width=80		name='����'			align=center	</C>
											<C> id='APP_YN'	width=160	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&APP_YMD} </C>
											<C> id='REMARK1'width=160	name='����'			align=center 	Color='Blue'	</C>
										">
										<param name="wmode" value="transparent" >
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>

				                        <img src="../../images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)" >
				                        <img src="../../images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)" >
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
		<td align="right">  <!-- �߰� ���� ��ư -->
			<img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
			<img src="../../images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_RemoveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ED_BOOKDETAIL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:230px;">
							<param name="DataID"				value="dsT_ED_BOOKDETAIL">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=30				name='NO'				align=center	value={String(Currow)}	</C>
								<C> id='BOOK_NM'			width=200			name='������'			align=center	</C>
								<C> id='BOOK_PUL'			width=120			name='���ǻ�'			align=center	</C>
								<C> id='BOOK_WRT'		width=100			name='����'				align=center	</C>
								<C> id='BOOK_QTY'			width=70				name='����'				align=center	edit=numeric editlimit=3</C>
								<C> id='BOOK_AMT'			width=80				name='����'				align=center	edit=numeric editlimit=6</C>
								<C> id='HOMEPAGE'			width=130			name='Ȩ������'		align=center	</C>
                                <C> id='BOOK_REMARK'    width=150            name='���'         		align=left      </C>
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
<object id="bndT_ED_BOOKMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKMASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			Param=value 	</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=RQST_YMD				Ctrl=txtRQST_YMD	   		Param=value		</C>
		<C>Col=RQST_REMARK			Ctrl=txtREMARK	   			Param=value		</C>
    '>
</object>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_ED_BOOKDETAIL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKDETAIL">
	<Param Name="BindInfo", Value='
        <C>Col=RQST_NO         		Ctrl=txtRQST_NO        		Param=value     </C>
		<C>Col=BOOK_NM   		 	Ctrl=txtBOOK_NM    		 	Param=value		</C>
		<C>Col=BOOK_PUL				Ctrl=txtBOOK_PUL     		Param=value		</C>
		<C>Col=BOOK_WRT     		Ctrl=txtBOOK_WRT     		Param=value 	</C>
		<C>Col=BOOK_QTY      		Ctrl=txtBOOK_QTY 		    Param=value 	</C>
		<C>Col=BOOK_AMT				Ctrl=txtBOOK_AMT	   		Param=value		</C>
		<C>Col=END_TAG				Ctrl=txtEND_TAG	   			Param=value		</C>
		<C>Col=HOMEPAGE				Ctrl=txtHOMEPAGE	   		Param=value		</C>
		<C>Col=BOOK_REMARK			Ctrl=txtBOOK_REMARK	   		Param=value		</C>
    '>
</object>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
