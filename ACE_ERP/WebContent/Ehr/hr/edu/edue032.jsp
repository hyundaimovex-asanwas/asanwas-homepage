<!--
    ************************************************************************************
    * @Source         : edue032.jsp                                                    *
    * @Description    : ��ܰ��½�û�� PAGE                                        *
    * @Developer Desc :                                                                   *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                       *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/16  |  ������   | �ҽ�����                                               *
    * 2016/07/26  |  �̵���   | ����                                                     *    
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>

    <head>
    <title>������û��</title>
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



        var opener = window.dialogArguments;
        var flag   = '';                       // 0: ��ȸ, 1: ����/����
        var edu_cd;
        var edu_nm;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	
            dsT_CM_EDUCATION.ClearData();
            dsT_ED_CHASULIST.ClearData();

            flag = '0';

            trT_ED_COURSEINFO.KeyValue = "SVL(O:SHR=dsT_ED_CHASULIST, O:SHR0=dsT_ED_COURSEINFO)";
            trT_ED_COURSEINFO.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue032.cmd.EDUE032CMD&S_MODE=SHR&EDU_AUTHO="+opener.edu_autho+"&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no;
            trT_ED_COURSEINFO.post();

            form1.grdT_CM_EDUCATION.Focus();

        }
        function fnc_SearchList2(row) {

            var edu_cd = opener.edu_cd;
	        var seq_no = dsT_ED_CHASULIST.NameValue(row, "SEQ_NO");
	       
	        dsT_CM_EDUCATION.ClearData();
	        dsT_DI_APPROVAL.ClearData();

	        trT_ED_CHASULIST.KeyValue = "SVL2(O:SHR2=dsT_CM_EDUCATION, O:SHR_APP=dsT_DI_APPROVAL)";
            trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue032.cmd.EDUE032CMD&S_MODE=SHR_ED&EDU_CD="+edu_cd+"&SEQ_NO="+seq_no;
            trT_ED_CHASULIST.post();
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

                flag = '1';

                dsT_ED_CHASULIST.UserStatus(dsT_ED_CHASULIST.RowPosition) = 1;

                trT_ED_COURSEINFO.KeyValue = "tr01(I:SAV=dsT_ED_CHASULIST,I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
                trT_ED_COURSEINFO.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue032.cmd.EDUE032CMD&S_MODE=SAV&DPT_CD="+gdeptcd+"&JOB_CD=''&ENO_NO="+document.getElementById("txtENO_NO").value;
                trT_ED_COURSEINFO.post();


            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = dsT_ED_CHASULIST.NameValue(1, "CHK_YN");

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_CHASULIST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�ش���� [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_CD") + "] [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + "] ��û�� ����Ͻðڽ��ϱ�?") == false) return;

            if (status == "Y")    {

                flag = '1';

                dsT_ED_CHASULIST.DeleteRow(dsT_ED_CHASULIST.RowPosition);

                trT_ED_COURSEINFO.KeyValue = "tr02(I:DEL=dsT_ED_CHASULIST)";
                trT_ED_COURSEINFO.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue032.cmd.EDUE032CMD&S_MODE=DEL";
                trT_ED_COURSEINFO.post();
            }
            else {
                flag = '';
                document.getElementById("Message").innerText = '* ��û���� ���� ���������� ��û����� �� �����ϴ�.';
                return;
            }

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

            if (dsT_CM_EDUCATION.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("��ܰ��½�û��", '', 225);

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

         //   fnc_Delete();

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

            // Ȯ�� CHECK
            if( document.getElementById("chkCHECK").checked == false ) {
                alert("��û�Ͻñ� ���� Ȯ�ζ��� üũ�Ͽ� �ֽʽÿ�.");
                document.getElementById("chkCHECK").focus();
                return false;
            }

            if(dsT_DI_APPROVAL.CountRow < 1){
				alert("���缱�� �ϳ��̻� ������ �ֽʽÿ�");
				return false;
			}

            if (dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "CHK_YN") == "Y") {
                alert("�̹� ��û�Ͻ� ���������Դϴ�.");
                document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
                return false;
            }

			// ��û�������� CHECK
			var rSTR_YMD = dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "ENT_STR_YMD");
			var rEND_YMD = dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "ENT_END_YMD");
			//var today = getToday();
			var today = gcurdate;

            if (rSTR_YMD > today ||  rEND_YMD <  today ) {
                alert("��û���ɱⰣ("+rSTR_YMD+ " ~ "+rEND_YMD + ") �ƴմϴ�.\r\n\r\n�ű����� ������ ��û�ٶ��ϴ�");
                document.getElementById("Message").innerText = '* �۾��� ��ҵǾ����ϴ�.';
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_EDUCATION,0,"false","false");
            cfStyleGrid_New(form1.grdT_ED_CHASULIST,0,"false","false");
            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");

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
								"JOB_NM:STRING(10)"				// ������
								);

            
            //�������� �ҷ����� �߰�  ( ����, �Ҽ�   ������ �����.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();
            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;
            document.getElementById("txtDPT_NM").value = gdeptnm;
            document.getElementById("txtJOB_NM").value = dsVI_T_PERSON.NameValue(0,"JOB_NM");
         
            fnc_SearchList();


        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_CHASULIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

          //  opener.fnc_SearchList();

            window.close();

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
		function fnc_proc(){
        	
         	edu_cd = document.getElementById("txtEDU_CD").value;
         	
         	edu_nm = document.getElementById("txtEDU_NM").value;
         	
         	window.showModalDialog("../../hr/edu/edue033.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
         	
		}

        //���缱����
		function fnc_Approval(){

			if (dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "CHK_YN") == "Y") {
                alert("�̹� ��û�Ͻ� ���������Դϴ�.");
                document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
                return;
            }

         	var STR_YMD_SHR = "";
			var END_YMD_SHR = "";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
			
			//2016.05.19 jys ����
            //var EMPL_DPT_CD = gdeptcd;
            var EMPL_DPT_CD = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			
			
			var EMP_NO      = gusrid;

			var year_yn = dsT_ED_CHASULIST.NameValue(1, "YEARPLAN_YN");
			var COST = dsT_ED_CHASULIST.NameValue(1, "COST_AMT");

      		//ds�� ���Ϲ޴´�.
            dsT_DI_APPROVAL.DeleteAll();

			if(year_yn != 'Y'){

				 fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"M",COST);
	            //������ IsUpdated üũ�ϰ� ����
	            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
	            fnc_MakeApprovalDS();
			} else {
				fnc_GetDiApproverDS2(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"M");
            }

            fnc_AutoApproval(dsT_DI_APPROVAL.countrow);
		}

		function fnc_GetDiApproverDS2(dataSet, p_EnoNo, p_DptCd, p_GbnCd, p_RetCd, p_StrYmd, p_EndYmd, p_AppNum, p_GunGbn) {
	        if(p_DptCd == undefined) {
	            p_DptCd = "";
	        }
	        // ��������
	        if(p_GbnCd == undefined) {
	            p_GbnCd = "1";
	        }
	        // �����ڸ�
	        if(p_RetCd == undefined) {
	            p_RetCd = "1";
	        }
	        // ��¥�� �ִ��� ���� üũ
	        p_StrYmd = fnc_GetDataStr(p_StrYmd);
	        p_EndYmd = fnc_GetDataStr(p_EndYmd);

	        dsT_DI_APPROVAL_TEMP.ClearData();
	        //�Ķ����
	        var paraVal = "&DPT_CD="  + p_DptCd  +
	                      "&GBN_CD="  + p_GbnCd  +
	                      "&RET_CD="  + p_RetCd  +
	                      "&STR_YMD=" + p_StrYmd +
	                      "&END_YMD=" + p_EndYmd +
	                      "&APP_NUM=" + p_AppNum +
	                      "&GUN_GBN=" + p_GunGbn +
	                      "&ENO_NO=" + p_EnoNo ;
	        dsT_DI_APPROVAL_TEMP.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue032.cmd.EDUE032CMD&S_MODE=APP"+paraVal;
			dsT_DI_APPROVAL_TEMP.reset();

	    }

	    function fnc_MakeApprovalDS(){
			dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = 99;	//���缱(�������)
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");	//���缱(�������)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// �Ϻ� ���¿��� ������ ���� �ʰ� �ϱ����ؼ�...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") =gusrid;	//����� ���
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "M";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
            }
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
            //���� ���������� ���� �����ͼ¿� ������� �⺻���� Setting(ǰ�ǹ�ȣ,�����������)
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
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_GBN") = "M";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"PENO_NO") = gusrid;
	            
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EDUCATION) |
    | 3. ���Ǵ� Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
    <Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_CHASULIST) |
    | 3. ���Ǵ� Table List(T_ED_CHASULIST)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_CHASULIST) |
    | 3. ���Ǵ� Table List(T_ED_CHASULIST)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSEINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_ED_COURSEINFO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_COURSEINFO)">
    </Object>
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ED_CHASULIST                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_CHASULIST)">
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
    
    
    
    
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�ּ�)							       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
	</Object>
    

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("objResultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("objResultMessage"), "MSG_03", dsT_CM_EDUCATION.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_CHASULIST Event="OnClick(row, col)">
		if (dsT_ED_CHASULIST.NameValue(row, "CHK_YN") != "Y")    {

            document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ͻ� �� �ֽ��ϴ�.';
            document.getElementById("chkCHECK").checked = false;
            document.getElementById("chkCHECK").disabled = false;
            document.getElementById("chkCHECK").focus();

        } else {

            document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
            document.getElementById("chkCheck").checked = true;
            document.getElementById("chkCheck").disabled = true;

        }
        fnc_SearchList2(row);
    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">
		if (dsT_ED_CHASULIST.NameValue(1, "CHK_YN") != "Y")    {

            document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ͻ� �� �ֽ��ϴ�.';
            document.getElementById("chkCHECK").checked = false;
            document.getElementById("chkCHECK").disabled = false;
            document.getElementById("chkCHECK").focus();

        } else {

            document.getElementById("Message").innerText = '* �ش� ���������� ��û�Ǿ����ϴ�.';
            document.getElementById("chkCheck").checked = true;
            document.getElementById("chkCheck").disabled = true;

        }
		
        fnc_SearchList2(1);

    </Script>
    <Script For=dsT_DI_APPROVAL_TEMP Event="OnLoadCompleted(iCount)">
        fnc_MakeApprovalDS();

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSEINFO Event="OnLoadCompleted(iCount)">

        document.getElementById("txtEDU_CD").value      = dsT_ED_COURSEINFO.NameValue(1, "EDU_CD");
        document.getElementById("txtEDU_NM").value      = dsT_ED_COURSEINFO.NameValue(1, "EDU_NM");
        document.getElementById("txtOBJ_TAG").value     = dsT_ED_COURSEINFO.NameValue(1, "OBJ_TAG");
        document.getElementById("txtCONTENT_TXT").value = dsT_ED_COURSEINFO.NameValue(1, "CONTENT_TXT");
        document.getElementById("txtCPT_TAG").value     = dsT_ED_COURSEINFO.NameValue(1, "CPT_TAG");
        document.getElementById("txtEFFECT_TAG").value  = dsT_ED_COURSEINFO.NameValue(1, "EFFECT_TAG");
        document.getElementById("txtINS_NM").value      = dsT_ED_COURSEINFO.NameValue(1, "INS_NM");
        document.getElementById("txtEDU_GBN_NM").value  = dsT_ED_COURSEINFO.NameValue(1, "EDU_GBN_NM");
        document.getElementById("txtMNGER_NM").value    = dsT_ED_COURSEINFO.NameValue(1, "MNGER_NM");
        document.getElementById("txtFIELD_NM").value    = dsT_ED_COURSEINFO.NameValue(1, "FIELD_NM");
        document.getElementById("txtSHAPE_NM").value    = dsT_ED_COURSEINFO.NameValue(1, "SHAPE_NM");
        document.getElementById("txtGOAL_TAG").value    = dsT_ED_COURSEINFO.NameValue(1, "GOAL_TAG");

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ED_CHASULIST event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ED_CHASULIST event="OnFail()">

        cfErrorMsg(this);
        flag = '';

    </script>
    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ED_COURSEINFO event="OnSuccess()">

        if (flag == '1') {

            fnc_SearchList();

        }

        flag = '';

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ED_COURSEINFO event="OnFail()">

        cfErrorMsg(this);
        flag = '';

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ReportOver.gif',1)">   <img src="../../images/button/btn_ReportOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">   <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������������</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >��������</td>
                    <td class="padding2423" align="left" colspan="5">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="10"  class="input_ReadOnly" readonly>
						<input id="txtEDU_NM" name="txtEDU_NM" size="100" class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">������ǥ</td>
                    <td class="padding2423">
                        <input id="txtGOAL_TAG" name="txtGOAL_TAG" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="73" rows="3" maxlength="300" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" >�������</td>
                    <td class="padding2423" align="left">
                        <input id="txtCPT_TAG" name="txtCPT_TAG" style="width:100%"  class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">���ȿ��</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtEFFECT_TAG"  name="txtEFFECT_TAG" cols="73" rows="3" maxlength="300" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">ȯ�޿���</td>
                    <td class="padding2423">
                        <input id="txtINS_NM" name="txtINS_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtEDU_GBN_NM" name="txtEDU_GBN_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�ְ�</td>
                    <td class="padding2423">
                        <input id="txtMNGER_NM" name="txtMNGER_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�о�</td>
                    <td class="padding2423">
                        <input id="txtFIELD_NM" name="txtFIELD_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423">
                        <input id="txtSHAPE_NM" name="txtSHAPE_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold" >�������</td>
                    <td class="padding2423" align="left">
                        <input id="txtOBJ_TAG" name="txtOBJ_TAG" style="width:100%"  class="input_ReadOnly" readonly>
                    </td>

                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->



<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������������</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <input id="txtSEQ_NO" name="txtSEQ_NO" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtINT_NAM" name="txtINT_NAM" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtPLACE_TAG" name="txtPLACE_TAG" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�����Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>

                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREQ_CNT" name="txtREQ_CNT" maxlength="20" style="width:70;text-align:right;" class="input_ReadOnly" readonly>
                        / <input id="txtFIX_NO" name="txtFIX_NO" maxlength="20" style="width:70;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">ȯ�޿���</td>
                    <td class="padding2423">
                        <input id="txtINS_NM" name="txtINS_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">ȯ�޿����</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="padding2423" colspan="6">
                        �ش� �������¸� ��û�մϴ�. <input type="checkbox" id="chkCHECK"  name="chkCHECK">Ȯ��&nbsp;&nbsp;
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->
<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="left" style="padding-right:5px; padding-bottom:2px;">
                        <input type="button" id="btnPROC1" style="cursor:hand;width:100pt;height:20pt;" value=" �ű��������� " onclick="fnc_proc()">
                    </td>
                    <td width="400" valign="top" align="right" class="searchState"><span id="Message">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_CHASULIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:140px;">
                            <param name="DataID"                  value="dsT_ED_CHASULIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='SEQ_NO'    			width=60    name='����'         			align=center </C>
                                <C> id='ENT_STR_YMD'  	width=90    name='��û��������'     	align=center </C>
                                <C> id='ENT_END_YMD'  	width=90    name='��û��������'     	align=center </C>
                                <C> id='EDU_STR_YMD'  	width=90    name='�н���������'     	align=center </C>
                                <C> id='EDU_END_YMD'  	width=90    name='�н���������'     	align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:350px;height:140px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
            					<C> id='SEQ_NO'	width=40	name='NO'			align=center	Value={IF (SEQ_NO > '90','����', '����')}</C>
            					<C> id='DPT_NM'	width=80	name='�μ�'			align=center	</C>
								<C> id='JOB_NM'	width=60	name='����'			align=center	</C>
								<C> id='ENO_NM'	width=70	name='����'			align=center	</C>
								<C> id='APP_YN'	width=70	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')} </C>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������û����Ȳ</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:150px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    	name='����'         align=center </C>
                                <C> id='ENO_NM'       width=80    	name='����'         align=center </C>
                                <C> id='DPT_NM'       width=100    	name='�μ�'         align=left   </C>
                                <C> id='JOB_NM'       width=80    	name='����'         align=center </C>
                                <C> id='EDU_NM'       width=300   	name='��������'   align=left   </C>
                                <C> id='SEQ_NO'       width=70    	name='����'         align=center </C>
                                <C> id='IPT_YMD'      width=80    	name='��û��'      align=center </C>
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
<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��û������</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="40 "></col>
                    <col width="198"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                    <col width="70 "></col>
                    <col width="196"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�� û ��</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtENO_NO" size="10" maxlength="8" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                        &nbsp;&nbsp;&nbsp;�μ� <input id="txtDPT_NM" size="20" class="input_ReadOnly" readonly>
                        &nbsp;&nbsp;���� <input id="txtJOB_NM" size="16" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->
</form>
<!-- form �� -->

</body>
</html>


	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_CM_EXAMINATION ���� ���̺� -->
	<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_ED_CHASULIST">
		<Param Name="BindInfo", Value="
			<C>Col=SEQ_NO			Ctrl=txtSEQ_NO			Param=value</C>
			<C>Col=EDU_STR_YMD		Ctrl=txtEDU_STR_YMD		Param=value</C>
			<C>Col=EDU_END_YMD		Ctrl=txtEDU_END_YMD		Param=value</C>
			<C>Col=INT_NAM			Ctrl=txtINT_NAM			Param=value</C>
			<C>Col=PLACE_TAG		Ctrl=txtPLACE_TAG		Param=value</C>
			<C>Col=COST_AMT			Ctrl=medCOST_AMT		Param=text</C>
			<C>Col=FIX_NO			Ctrl=txtFIX_NO			Param=value</C>
			<C>Col=REQ_CNT			Ctrl=txtREQ_CNT			Param=value</C>
			<C>Col=RTN_AMT			Ctrl=medRTN_AMT			Param=text</C>
		">
	</object>

