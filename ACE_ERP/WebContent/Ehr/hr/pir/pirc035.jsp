	<!--*************************************************************************
	* @source      : pirc035.jsp												*
	* @description : ���º����û�� PAGE										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2009/10/22            ������          	        �����ۼ�									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
	String eno_nm = box.getString("SESSION_ENONM");         //ǰ���ڻ��
	String dep_cd = box.getString("SESSION_DPTCD");         //ǰ���ڻ��

	String MODE = request.getParameter("MODE");		// ����(INS: ��ϸ��, UPDATE:�������)

	String str_ymd_shr = request.getParameter("str_ymd_shr");
	String end_ymd_shr = request.getParameter("end_ymd_shr");
 %>
<html>
<head>
	<title>���º����û��(pirc035)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var today = getToday();
		var btnList = 'TFTTFFTT';
		var isSHR = false;
		var REQ_NO = "";
		var REQ_YMD = "";

		var dsTemp = window.dialogArguments;
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var REQ_NO_SHR = document.getElementById("txtREQ_NO_SHR").value;

			trT_DI_DILIGENCE_SHR.KeyValue = "tr05(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_DILIGENCE_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc035.cmd.PIRC035CMD"
			                       + "&S_MODE=SHR"
                                   + "&REQ_NO_SHR="+REQ_NO_SHR;
			trT_DI_DILIGENCE_SHR.post();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
/*
            if(REQ_YMD == ""){
                REQ_YMD = document.getElementById("txtREQ_YMD").value;
                REQ_NO =  document.getElementById("txtREQ_NO").value;
            }
*/
            //ó���� �ڵ����� ���� �ʳѾ�Ƿ� ���¸� �ٲپ��ش�.
            //dsT_DI_APPROVAL.UserStatus(1) = "1";

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_APPROVAL=dsT_DI_APPROVAL,O:dsT_DI_DILIGENCE_TEMP=dsT_DI_DILIGENCE_TEMP)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc035.cmd.PIRC035CMD&S_MODE=SAV&REQ_NO="+document.getElementById("txtREQ_NO_SHR").value;
			trT_DI_DILIGENCE.post();

        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			var CHN_YMD = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "CHN_YMD");
			var REQ_NO = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO");
			var ENO_NO = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO");
			var REQ_YMD = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "BF_YMD");
           	// ���º����û�� ����
            if (dsT_DI_APPROVAL.CountRow > 0 && dsT_DI_APPROVAL.NameValue(1,"APP_YN") == "����") {
                alert("����Ϸ�� �����ʹ� ������ �� �����ϴ�!");
	        	return;
			}

			if (dsT_DI_DILIGENCE.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "��û��ȣ = "+REQ_NO+"\n";
				tmpMSG += "�������� = "+REQ_YMD+"\n";
            	tmpMSG += "��� = "+ENO_NO+"\n";
            	tmpMSG += "���� = "+dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM")+"\n";


	            if( confirm(tmpMSG) ){

					dsT_DI_DILIGENCE.DeleteRow(dsT_DI_DILIGENCE.RowPosition);

					trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
					trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc035.cmd.PIRC035CMD&S_MODE=DEL&REQ_YMD="+REQ_YMD+"&REQ_NO="+REQ_NO+"&CHN_YMD="+CHN_YMD+"&ENO_NO="+ENO_NO;
					trT_DI_DILIGENCE.post();
				}
			}
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			// �� �߰�
			dsT_DI_DILIGENCE.AddRow();

<%
    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
    if(!box.getString("SESSION_DIL_AUTHO").equals("M") && !box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			if(dsT_DI_DILIGENCE.CountRow > 1){
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = "<%=eno_no%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = "<%=eno_nm%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = "<%=dep_cd%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = "<%=box.getString("SESSION_DPTNM")%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = "<%=box.getString("SESSION_JOBNM")%>";
			}else{
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = "<%=eno_no%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = "<%=eno_nm%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = "<%=dep_cd%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = "<%=box.getString("SESSION_DPTNM")%>";
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = "<%=box.getString("SESSION_JOBNM")%>";
			}
		fnc_ChangeStateElement(false, "ImgEnoNo");
		fnc_ChangeStateElement(false, "txtENO_NO");
		fnc_ChangeStateElement(false, "txtENO_NM");

		//fnc_ChangeStateElement(true, "txtREMARK");
		//fnc_ChangeStateElement(true, "cmbGUN_CD");
		//fnc_ChangeStateElement(true, "txtPIS_YYMMDD");
		//fnc_ChangeStateElement(true, "ImgStrYmd");
<%
    }else{
%>


		if(dsT_DI_DILIGENCE.CountRow > 1){
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NO");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NM");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_CD");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_NM");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "JOB_NM");
		}else{
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = "<%=eno_nm%>";
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = "<%=dep_cd%>";
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = "<%=box.getString("SESSION_DPTNM")%>";
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = "<%=box.getString("SESSION_JOBNM")%>";
		}

		fnc_DisableElementAll(elementList);
		fnc_ChangeStateElement(true, "ImgEnoNo");
		fnc_ChangeStateElement(true, "txtENO_NO");
		fnc_ChangeStateElement(true, "txtENO_NM");

		fnc_ChangeStateElement(true, "txtREMARK");
		/*
		fnc_ChangeStateElement(true, "cmbGUN_CD");
		fnc_ChangeStateElement(true, "txtPIS_YYMMDD");
		fnc_ChangeStateElement(true, "ImgStrYmd");
		*/
<%
    }
%>
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "FLAG") = "INS";
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {

			var STR_YMD_SHR = "<%=str_ymd_shr%>";
			var END_YMD_SHR = "<%=end_ymd_shr%>";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;
			var EMP_NO      = "<%=eno_no%>";


			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 5)

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
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"BF_YMD"); // ���������j �Ϻ� ���¿��� ������ ���� �ʰ� �ϱ����ؼ�...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = dsT_DI_DILIGENCE.NameValue(1,"ENO_NO");
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = dsT_DI_DILIGENCE.NameValue(1,"REQ_NO");
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "U";
<%
	if("READ".equals(MODE)){
%>

<%
	}else{
%>
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
<%
	}
%>
            }

        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

			document.form1.txtENO_NO_SHR.value = '<%=eno_no %>';
			document.form1.txtENO_NM_SHR.value = '<%=eno_nm %>';
			document.getElementById("txtSTR_YMD_SHR").value = getToday();
			document.getElementById("txtEND_YMD_SHR").value = next_month(getToday())+"-"+getToday().substring(8);

        	dsT_DI_DILIGENCE.ClearData();
        	dsT_DI_APPROVAL.ClearData();

        	disableInput();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			window.close();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {

     		for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
				// ���³�¥ �ݵ�� �Է��ؾ��Ѵ�
				if( (dsT_DI_DILIGENCE.RowStatus(i) == 3 || dsT_DI_DILIGENCE.RowStatus(i) == 2) && dsT_DI_DILIGENCE.NameValue(i,"BF_YMD").trim() == "" ){
                    alert("���³�¥�� �ݵ�� �Է��ؾ��մϴ�..");
                    dsT_DI_DILIGENCE.RowPosition = i;
                    form1.grdT_DI_DILIGENCE.SetColumn("BF_YMD");
                    return false;
                }
     		    //���� �ݵ�� �Է��� �ʿ��ϴ�.
                if( (dsT_DI_DILIGENCE.RowStatus(i) == 3 || dsT_DI_DILIGENCE.RowStatus(i) == 2) && dsT_DI_DILIGENCE.NameValue(i,"AF_REMARK").trim() == "" ){
                    alert("�ش� ������ �ݵ�� �Է��ؾ��մϴ�..");
                    dsT_DI_DILIGENCE.RowPosition = i;
                    form1.grdT_DI_DILIGENCE.SetColumn("AF_REMARK");
                    return false;
                }
     		}

			//alert("[" + document.getElementById("cmbREQ_NO_SHR").value + "]");
            if(dsT_DI_APPROVAL.CountRow == 0){
                alert("���缱�� �����Ͻʽÿ�.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
			for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++){
				dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL.NameValue(i,"ENO_NM") + " ";
			}

			if(confirm("�����Ͻðڽ��ϱ�?")){
				return true;
			}else{
				return false;
			}
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	 dsT_DI_DILIGENCE.SetDataHeader(
        	        			"REQ_NO:STRING(11),"+			// ��Ϲ�ȣ
								"BF_YMD:STRING(10),"+			// ��������
	        					"ENO_NO:STRING(10),"+			// �����ȣ
	                            "DPT_NM:STRING(20),"+			// �Ҽ�
	                            "DPT_CD:STRING(20),"+			// �Ҽ�
								"JOB_NM:STRING(20),"+			// ����
								"ENO_NM:STRING(10),"+			// ����
								"AF_GUN_CD:STRING(10),"+		// �ı����׸�
								"AF_REMARK:STRING(50),"+		// �Ļ���
								"BF_REMARK:STRING(50),"+		// ������
								"BF_GUN_CD:STRING(2),"+			    // ���ڵ�
								"CHN_YMD:STRING(10),"+			// ��������
								"FLAG:STRING(10)"               // UPD ��ϸ��
								);

	        dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// ���³�¥
	                            "GUN_GBN:STRING(1),"+			// ���°��籸��
								"DPT_CD:STRING(2),"+			// ���ºμ�
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

			cfStyleGrid(form1.grdT_DI_DILIGENCE,15,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_DI_APPROVAL,15,"true","false")      // Grid Style ����

<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	   
<%//A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	    document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";

<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";
<%
	}
%>



            if(dsTemp.NameValue(1,"APP_YN_NM")=="����Ϸ�" || dsTemp.NameValue(1,"APP_YN_NM")=="����������"){
                document.getElementById("append_btn").style.display = "none";
                document.getElementById("btn_InsDel").style.display = "none";
            }else{
                document.getElementById("append_btn").style.display = "";
                document.getElementById("btn_InsDel").style.display = "";
            }

<%
	if("READ".equals(MODE)){
%>
		document.getElementById("txtREQ_NO_SHR").value = dsTemp.NameValue(1,"REQ_NO");
		fnc_SearchList();
<%
	}
%>
			document.getElementById("txtMODE").value = "<%=MODE%>";
			fnc_DisableElementAll(elementList);
			/*
			fnc_ChangeStateElement(true, "txtREMARK");
			fnc_ChangeStateElement(true, "cmbGUN_CD");
			fnc_ChangeStateElement(true, "txtPIS_YYMMDD");
			fnc_ChangeStateElement(true, "ImgStrYmd");
			*/
        }

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"cmbGUN_CD"
                                    ,"txtREMARK"
                                    ,"txtPIS_YYMMDD"
                                    ,"ImgStrYmd"
                                     );

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

		/********************************************
         * �׸��� Ŭ���� ���±��м��� �˾�                 			*
         ********************************************/
        function fnc_SearchGun(row, colid) {

        }


		/********************************************
         * ��¥ ���� ��ȿ�� üũ                    *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
			/*
  			document.form1.txtREQ_YMD.readOnly = false;
	  		document.form1.txtREQ_YMD.className = "";
  			document.getElementById("imgREQ_YMD").disabled = false;
  			document.getElementById("imgREQ_YMD").style.display = "";
			*/
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
			/*
  			document.form1.txtREQ_YMD.readOnly = true;
	  		document.form1.txtREQ_YMD.className = "input_ReadOnly";
  			document.getElementById("imgREQ_YMD").disabled = true;
  			document.getElementById("imgREQ_YMD").style.display = "none";
			*/
  		}

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

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
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
        //������ ��¥���� üũ
        function fnc_ChkDate(BF_YMD) {

            var PIS_YYMMDD = BF_YMD;
			if(PIS_YYMMDD.length != 8){
				alert("��¥�� ��Ȯ�� �Է��Ͻʽÿ�");
			}
            var today = getToday().replace("-","").replace("-","");

            if(PIS_YYMMDD != ""){
	            if(PIS_YYMMDD <= today){
	                alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
	                dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_YMD") = "";
	                return false;
	            }
            }
			return true;
        }

		function fnc_GunApp(){
			if(dsT_DI_DILIGENCE.CountRow > 0){
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "AF_GUN_NM")= document.form1.cmbGUN_CD.options[document.form1.cmbGUN_CD.options.selectedIndex].text;
			}
		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)			 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. ��¥�� ���������� �����ڵ� �������°� DataSet			   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)			 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_CD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet(���缱)						   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_APPROVAL)		 	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 			 	   |
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

    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE_CD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr02(O:dsT_DI_DILIGENCE_CD=dsT_DI_DILIGENCE_CD)">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">

    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">

    </Script>

	<Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

    </Script>
	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE_CD Event="OnLoadCompleted(iCount)">
		if(iCount > 0){
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_GUN_CD") = dsT_DI_DILIGENCE_CD.NameValue(dsT_DI_DILIGENCE_CD.RowPosition, "GUN_CD");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_REMARK") = dsT_DI_DILIGENCE_CD.NameValue(dsT_DI_DILIGENCE_CD.RowPosition, "REMARK");
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "CHN_YMD") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_YMD");
			
		}
    </Script>
	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
		// �ش��ڵ��� �Է��ϼ���.
<%
	if("INS".equals(MODE)){
%>
		document.getElementById("txtREQ_NO_SHR").value  = dsT_DI_DILIGENCE_TEMP.NameValue(1, "REQ_NO");
<% 
	}else{
%>
		document.getElementById("txtREQ_NO_SHR").value  = dsTemp.NameValue(dsTemp.RowPosition, "REQ_NO");
<%
	}
%>


        fnc_SearchList();
    </script>
	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE_CD event="OnSuccess()">
		// �ش��ڵ��� �Է��ϼ���.
    </script>
	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        alert(trT_DI_DILIGENCE.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Grid Ŭ���� ������Ȳ ��ȸ	  							   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_DILIGENCE event=OnClick(row,colid)>
		//fnc_SearchGun(row, colid);
		/*
		if(dsT_DI_DILIGENCE.NameValue(row,"END_TAG") == "" &&  dsT_DI_DILIGENCE.NameValue(row,"REQ_NO") != ""){
			fnc_ChangeStateElement(false, "cmbGUN_CD");
			fnc_ChangeStateElement(false, "txtPIS_YYMMDD");
			fnc_ChangeStateElement(false, "txtREMARK");
		}
		*/
	</script>
	<!-----------------------------------------------------+
    | Grid ���� ��¥ ���������� �����ڵ� ��������						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_DI_DILIGENCE event=OnExit(row,colid,olddata)>
		if(colid == "BF_YMD"){
			var BF_YMD = dsT_DI_DILIGENCE.NameValue(row, "BF_YMD");
			var ENO_NO = dsT_DI_DILIGENCE.NameValue(row, "ENO_NO");
			/*
				for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
					alert("������ ���� ��� ��û���� " + i + "[" + dsT_DI_DILIGENCE.NameValue(i, 'BF_YMD') + "]");
				}
			*/
			if(fnc_ChkDate(BF_YMD)){
				for(var i=1; i<dsT_DI_DILIGENCE.countrow; i++){
					if(dsT_DI_DILIGENCE.NameValue(i, "BF_YMD") == BF_YMD){
						alert("������¥�� �����Ҽ� �����ϴ�");
						dsT_DI_DILIGENCE.NameValue(row, "BF_YMD") = "";
						return false;
					}
				}
				dsT_DI_DILIGENCE.NameValue(row, "CHN_YMD") = dsT_DI_DILIGENCE.NameValue(row, "BF_YMD");
				trT_DI_DILIGENCE_CD.KeyValue = "tr06(O:dsT_DI_DILIGENCE_CD=dsT_DI_DILIGENCE_CD)";
				trT_DI_DILIGENCE_CD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc035.cmd.PIRC035CMD"
										   + "&S_MODE=SHR_CD"
										   + "&PIS_YYMMDD="+BF_YMD
										   + "&ENO_NO="+ENO_NO;
				trT_DI_DILIGENCE_CD.post();
			}
		}
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>


	<select id="cmbGUN_CD" style="width='100';DISPLAY:none" >
		<option value="">&nbsp;</option>			
	</select>

	<!-- form ���� -->
	<form name="form1">
    <input type="hidden" id="hidEMPL_DPT_CD">
	<input type="hidden" id="txtREQ_NO_SHR">
	<input type="hidden" id="txtMODE">
	<input type="hidden" id="txtPIS_YYMMDD" name="txtPIS_YYMMDD" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���º����û��</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">���º����û��</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ReportOver.gif',1)">  <img src="/images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			</span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="110"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>

					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
<!--
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left">
                        <select id="cmbGUN_CD" style="width='100';" >
							<option value="">&nbsp;</option>			
						</select>
					</td>
					<td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtPIS_YYMMDD" name="txtPIS_YYMMDD" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YYMMDD','','20','120');"></a>
                    </td>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left"  colspan="3">
						<input id="txtREMARK" name="txtREMARK" size="30" maxlength= "50">
					</td>
				</tr>
-->
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	<!-- ���� �Է� ���̺� �� -->


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
									<C> id='REQ_NO'	width=40	name='��Ϲ�ȣ'	align=center show=false	</C>
	            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=96	name='�μ�'		align=center	</C>
									<C> id='JOB_NM'	width=96	name='����'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='���'		align=center	</C>
									<C> id='ENO_NM'	width=100	name='����'		align=center	</C>
									<C> id='APP_YN'	width=100	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')} </C>
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


	<!-- ���� ��ȸ �׸��� ���̺� ��-->
	<!-- ���� ��ȸ �׸��� ���̺� ����-->

	<table width="800" border="0" cellspacing="0" cellpadding="0">
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

	<!-- ���� ��ȸ �׸��� ���̺� ��-->


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
						<param name="DataID" value="dsT_DI_DILIGENCE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29	name="NO"			align=center	value={String(Currow)}        </C>
							<C> id="REQ_NO"		width=100	name="��Ϲ�ȣ"		align=center	Edit=none show=false</C>
							<C> id="FLAG"		width=100	name="��ϸ��"		align=center	Edit=none show=false</C>
							<C> id="ENO_NO"		width=100	name="���"			align=center	Edit=none show=false</C>
							<C> id="BF_YMD"		width=70	name="������"	align=center	MASK=XXXX-XX-XX  edit={IF(FLAG="INS","true","false")} </C>
							<C> id="CHN_YMD"	width=70	name="�����ı�����" align=center	MASK=XXXX-XX-XX Edit=none show=false   </C>
							<G> name="����������"  HeadBgColor="#F7DCBB"
								<C> id="BF_GUN_CD"		width=100	name="����"		align=center	Edit=none  EditStyle=Lookup  Data="dsT_CM_COMMON_H4:CODE:CODE_NAME"                  </C>
								<C> id="BF_GUN_NM"		width=70	name="���¸�"	align=center	Edit=none  show=false                  </C>
								<C> id="BF_REMARK"		width=195	name="����"		align=center	Edit=none                     </C>
							</G>
							<G> name="�����ı���"  HeadBgColor="#F7DCBB"
								<C> id="AF_GUN_CD"		width=100	name="����"	     align=center	EditStyle=Lookup  Data="dsT_CM_COMMON_H4:CODE:CODE_NAME"                  </C>
								<C> id="AF_REMARK"		width=200	name="����"	align=center	                    </C>
							</G>
						'>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<object id="bndT_DI_DILIGENCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_DILIGENCE">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO			Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM		Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=BF_YMD			Ctrl=txtPIS_YYMMDD  Param=value</C>
			<C>Col=AF_GUN_CD		Ctrl=cmbGUN_CD		Param=value</C>
		">
	</object>