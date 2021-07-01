<!--
***********************************************************************
* @source      : yaca030.jsp
* @description : �Ƿ����������Է� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      ���뼺        �����ۼ�.
* 2007/04/10      ���м�        �μ�κ� �߰�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");

     String ENO_NO       = request.getParameter("ENO_NO");
     String ENO_NM       = request.getParameter("ENO_NM");
     String DPT_NM       = request.getParameter("DPT_NM");
     String JOB_NM       = request.getParameter("JOB_NM");

     if(ENO_NO == null){
	      ENO_NO       = box.getString("SESSION_ENONO");
	      ENO_NM       = box.getString("SESSION_ENONM");
	      DPT_NM       = box.getString("SESSION_DPTNM");
	      JOB_NM       = box.getString("SESSION_JOBNM");
     }     
     

     //ROLE_CD�� IT���� ����
     boolean itMaster = false;

     if(ROLE_CD.equals("1001")) {
	 itMaster = true;
     }


     //���������� �ƴ��� ����
     boolean isMaster = false;

     if(YAC_AUTHO.equals("M")) {
     isMaster = true;
     }
     // ���� ����
     //boolean open_yn = false;

    //if(ENO_NO.equals("19511030")) {
    //   open_yn = true;
    //  }
%>

<html>
<head>
	<title>�Ƿ����������Է�(yaca030)</title>
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

	<script language="javascript">

		var today = getToday();
		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTTTT';
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        //�Ѿ�� ������ ó��
        var submit = "<%=request.getParameter("END_YN") %>";
        
        
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_MEDICAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_MEDICAL.reset();

            document.form1.print_flag.value = "Y";

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem(row) {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			//��ü�� �Ѿ�� �ؾ���
            dsT_AC_MEDICAL.UseChangeInfo = "false";

			// save
			trT_AC_MEDICAL.KeyValue = "tr01(I:dsT_AC_MEDICAL=dsT_AC_MEDICAL)";
			trT_AC_MEDICAL.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=SAV";
			trT_AC_MEDICAL.post();

			dsT_AC_MEDICAL.UseChangeInfo = "true";

			fnc_UpdateAcc();

        }

        function fnc_UpdateAcc(){

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_MEDICAL2.UseChangeInfo = false;

			dsT_AC_MEDICAL2.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=ACC&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_MEDICAL2.reset();
        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	// ���º����û�� ����

			if (dsT_AC_MEDICAL.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

           	var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            tmpMSG += "����ڵ�Ϲ�ȣ = "+dsT_AC_MEDICAL.nameValue(dsT_AC_MEDICAL.RowPosition, "COM_NO")+"\n";
            tmpMSG += "������       = "+dsT_AC_MEDICAL.nameValue(dsT_AC_MEDICAL.RowPosition, "COM_NM")+"\n";

	        if( confirm(tmpMSG) ){
			    var status = dsT_AC_MEDICAL.RowStatus(dsT_AC_MEDICAL.RowPosition);
				dsT_AC_MEDICAL.DeleteRow(dsT_AC_MEDICAL.RowPosition);
			    if(status != 1){
                    trT_AC_MEDICAL.KeyValue = "tr01(I:dsT_AC_MEDICAL=dsT_AC_MEDICAL)";
                    trT_AC_MEDICAL.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=DEL";
                    trT_AC_MEDICAL.post();
                }
			}

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {
            if ( document.form1.print_flag.value == "Y" ) {
                var pis_yy   = document.form1.txtPIS_YY_SHR.value;
                var eno_no  = document.form1.txtENO_NO_SHR.value;
                var eno_nm  = document.form1.txtENO_NM_SHR.value;


                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var s_year  = String(year);
                var s_month = String(month);
                var s_day = String(day);
                var today_val = s_year + "��  " + s_month + "��  " + s_day + "��"

                var url = "yaca030_PV.jsp?pis_yy="+pis_yy+"&eno_no="+eno_no+"&eno_nm="+eno_nm+"&today_val="+today_val;
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            } else {
                alert("��ȸ�� �μⰡ���մϴ�.");
            }
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_AC_MEDICAL.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AC_MEDICAL.GridToExcel("�Ƿ����������Է�", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_AC_MEDICAL.CountColumn < 1) {
                //dsT_AC_MEDICAL.setDataHeader("PIS_YY:STRING, ENO_NO:STRING, CARD_CNT:NUMBER, CASH_CNT:NUMBER, CARD_AMT:NUMBER, CASH_AMT:NUMBER, SUM_AMT:NUMBER, COM_NO:STRING:NOTNULL, COM_NM:STRING:NOTNULL, REL_CD:STRING, CET_NO:STRING, GBN_TAG:STRING");
                alert("�ݵ�� ��ȸ�� �Է��� �����մϴ�.");
                return false;
            }

            dsT_AC_MEDICAL.AddRow();
            dsT_AC_MEDICAL.NameValue(dsT_AC_MEDICAL.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_MEDICAL.NameValue(dsT_AC_MEDICAL.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;

            fnc_enableInput();

            document.getElementById("txtCARD_CNT").value = "";
            //document.getElementById("txtCASH_CNT").value = "";

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

            //document.form1.txtPIS_YY_SHR.value = today.substring(0,4);
			document.form1.txtENO_NO_SHR.value = '<%= box.get("SESSION_ENONO")%>';
            document.form1.txtENO_NM_SHR.value = '<%= box.get("SESSION_ENONM")%>';
            document.form1.txtDPT_NM_SHR.value = '<%= box.get("SESSION_DPTNM")%>';
            document.form1.txtJOB_NM_SHR.value = '<%= box.get("SESSION_JOBNM")%>';

        	dsT_AC_MEDICAL.ClearData();
            fnc_disableInput();

            document.getElementById("resultMessage").innerText = ' ';
            document.form1.print_flag.value = "N";
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_MEDICAL.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			//frame = window.external.GetFrame(window);

			//frame.CloseFrame();


			window.close();

			
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /* �ֹι�ȣ ��ȿ�� üũ */
        function Juminchk(str) {

			 var num = new Array(13);

			 var digit = new Array(12);
			 var sum = 0;
			 var i=0, j=0;

			 digit[1] = 2;
			 digit[2] = 3;
			 digit[3] = 4;
			 digit[4] = 5;
			 digit[5] = 6;
			 digit[6] = 7;
			 digit[7] = 8;
			 digit[8] = 9;
			 digit[9] = 2;
			 digit[10] = 3;
			 digit[11] = 4;
			 digit[12] = 5;

			 //����� �Է��� �ֹε�� ��ȣ�� �迭�� �ִ´�
			 for(j=1; j<=13; j++) {
			  	num[j] = parseInt(str.charAt(j-1),10)
			 } // for
			 //check_digit�� ��ȣ�� �����Ѵ�
			 for(i=1; i<=12; i++) {
			  	sum += digit[i] * num[i];
			 } // for

			 var div = (sum%11);
			 if(div == 1) {
			  	comp = 0;
			 } else if(div == 0) {
			  	comp = 1;
			 } else if((div != 0)&&(div != 1)) {
			  	comp = 11 - div;
			 } // else if

			 if(div == 0) {
			  	  if(num[13] == 1) return true;
			  	  else return false;
			 } else if(div == 1) {
				  if(num[13] == 0) return true;
				  else return false;
			 } else if((11-div) == num[13]) {

			  	  return true;
			 } else {

			  	  return false;
			 }

		}


		function fnRRNCheck(rrn) // ��ȿ���˻�. ����fnRRNCheck("8201011234567");
 		{
			if (fnrrnCheck(rrn) || fnfgnCheck(rrn)) {
		         return true;
     		}

     		return false;

 		}

	 function fnrrnCheck(rrn) // �ֹε�Ϲ�ȣ��ȿ���˻�.
	 {
	     var sum = 0;

	     if (rrn.length != 13) {
	         return false;
	    }
	    else if (rrn.substr(6, 1) != 1 && rrn.substr(6, 1) != 2 && rrn.substr(6, 1) != 3 && rrn.substr(6, 1) != 4) {
		     return false;
	    }

	     for (var i = 0; i < 12; i++) {
	         sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
	     }

	     if (((11 - (sum % 11)) % 10) == Number(rrn.substr(12, 1))) {
	         return true;
	     }

	     return false;
	 }

	function fnfgnCheck(rrn) // �ܱ��ε�Ϲ�ȣ��ȿ���˻�.
	{
		var sum = 0;

	     if (rrn.length != 13) {
	         return false;
	     }
	     else if (rrn.substr(6, 1) != 5 && rrn.substr(6, 1) != 6 && rrn.substr(6, 1) != 7 && rrn.substr(6, 1) != 8) {
	         return false;
	     }

	     if (Number(rrn.substr(7, 2)) % 2 != 0) {
	         return false;
	     }

	     for (var i = 0; i < 12; i++) {
	         sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
	     }

	     if ((((11 - (sum % 11)) % 10 + 2) % 10) == Number(rrn.substr(12, 1))) {
	         return true;
	     }

	     return false;
	 }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

        	var bizNo = document.getElementById("txtCOM_NO").value;
        	var juminno = document.getElementById("txtCET_NO").value;

         	if ( !dsT_AC_MEDICAL.isUpdated ) {
	         	alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

			//�ֹι�ȣ ����ڹ�ȣ üũ
			for(i=0;i<dsT_AC_MEDICAL.CountRow;i++){


			    if(dsT_AC_MEDICAL.RowLevel(i+1) !="9999"){

			    	if(dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == '1') {


		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") == '') {
		                    alert("�ֹε�Ϲ�ȣ�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "").length != 13) {
		                    alert("�ֹε�Ϲ�ȣ�� �߸��Ǿ����ϴ�.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                juminno = dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "");

			            /*if(Juminchk(juminno) == false){
			            	alert("��ȿ���� ���� �ֹι�ȣ�Դϴ�.");
			            	return false;
			            }*/

			            if(fnRRNCheck(juminno) == false){
			            	alert("��ȿ���� ���� �ֹι�ȣ�Դϴ�.");
			            	return false;
			            }

						var cnt = 0;

			            // �Ƿ�� ����û�ڷ�� ��������ں��� �ջ��Ͽ� ����
						// ��������ں��� �ѰǸ� �Է��� �� �ֵ��� üũ
			            for(j=0;j<dsT_AC_MEDICAL.CountRow;j++){

			            	if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") == dsT_AC_MEDICAL.NameValue(j+1,"CET_NO")
			            	&& dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == dsT_AC_MEDICAL.NameValue(j+1,"MED_CD") ) {

			            		cnt++;

			            		if(cnt > 1) {
			            			alert("�ֹε�Ϲ�ȣ: " + dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") + "\n�ش� ������� ����û �Ƿ���ڷᰡ �̹� ��ϵǾ� �ֽ��ϴ�.\n����û �Ƿ���ڷ�� ��������ں��� �ջ��Ͽ� �Է��� �ּ���." );
			            			return false;
			            		}
			            	}
			            }


		                if(dsT_AC_MEDICAL.NameValue(i+1,"REL_CD") == '') {
		                    alert("����� ����� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.cmbREL_CD.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == '') {
		                    alert("�Ƿ������ڵ�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.cmbMED_CD.focus();
		                    return false;
		                }

			    	}
			    	else
			    	{
		                if(dsT_AC_MEDICAL.NameValue(i+1,"COM_NO") == '') {
		                    alert("����ڹ�ȣ�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "").length != 10) {
		                    alert("����ڹ�ȣ�� �߸��Ǿ����ϴ�.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

		                bizNo = dsT_AC_MEDICAL.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "");

			            if(bizNo_validate(bizNo) == false){
			            	alert("��ȿ���� ���� ����ڹ�ȣ�Դϴ�.");
			            	return false;
			            }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO") == '') {
		                    alert("�ֹε�Ϲ�ȣ�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "").length != 13) {
		                    alert("�ֹε�Ϲ�ȣ�� �߸��Ǿ����ϴ�.");
		                    form1.txtCET_NO.focus();
		                    return false;
		                }

		                juminno = dsT_AC_MEDICAL.NameValue(i+1,"CET_NO").replace("-", "");

			            if(Juminchk(juminno) == false){
			            	alert("��ȿ���� ���� �ֹι�ȣ�Դϴ�.");
			            	return false;
			            }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"REL_CD") == '') {
		                    alert("����� ����� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.cmbREL_CD.focus();
		                    return false;
		                }

		                if(dsT_AC_MEDICAL.NameValue(i+1,"MED_CD") == '') {
		                    alert("�Ƿ������ڵ�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.cmbMED_CD.focus();
		                    return false;
		                }
	                }
                }
			}

			return true;

        }

        /* ����ڹ�ȣ ��ȿ�� üũ */
        function bizNo_validate(value){
        	var sumMod = 0;
        	sumMod += parseInt(value.substring(0,1));
        	sumMod += parseInt(value.substring(1,2)) * 3 % 10;
        	sumMod += parseInt(value.substring(2,3)) * 7 % 10;
        	sumMod += parseInt(value.substring(3,4)) * 1 % 10;
        	sumMod += parseInt(value.substring(4,5)) * 3 % 10;
        	sumMod += parseInt(value.substring(5,6)) * 7 % 10;
        	sumMod += parseInt(value.substring(6,7)) * 1 % 10;
        	sumMod += parseInt(value.substring(7,8)) * 3 % 10;
        	sumMod += Math.floor(parseInt(value.substring(8,9)) * 5/10);
        	sumMod += parseInt(value.substring(8,9)) * 5 % 10;
	        sumMod += parseInt(value.substring(9,10));

	        if(sumMod % 10 != 0){
	        	return false;
        	}

        	return true;
        }


        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

<%
    //�����ڰ� �ƴ� ��� Ÿ���� ��ȸ�� ���� �ʰ�
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";
			//document.getElementById("imgPrint").style.display = "none";

<%
    }
%>


            //���豸��
            for( var i = 1; i <= dsT_CM_COMMON_FA.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FA.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FA.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FA.NameValue(i,"CODE_NAME");
                document.getElementById("cmbREL_CD").add(oOption);

            }

            //�Ƿ������ڵ� ����
            for( var i = 1; i <= dsT_CM_COMMON_FC.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FC.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FC.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FC.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMED_CD").add(oOption);

            }

			//document.form1.txtPIS_YY_SHR.value = today.substring(0,4);
		   if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value =  today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            }

			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';

			cfStyleGrid(form1.grdT_AC_MEDICAL,15,"false","false");      // Grid Style ����

            //fnc_disableInput();

            fnc_SearchList();

		    if(submit=='Y' )
            {
        		fnc_disableInput();
                return;
            }

            
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. �Է��ʵ� ��� �����ϰ�(Enable)       *
         ********************************************/
  		function fnc_enableInput(){

            document.getElementById("txtCARD_CNT").className = "";
	  		document.getElementById("txtCARD_CNT").readOnly = false;
            //document.getElementById("txtCASH_CNT").className = "";
	  		//document.getElementById("txtCASH_CNT").readOnly = false;
	  		form1.medCARD_AMT.Enable = "true";
            //form1.medCASH_AMT.Enable = "true";
            //form1.medSUM_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "";
	  		document.getElementById("txtCOM_NO").readOnly = false;
            document.getElementById("txtCOM_NM").className = "";
	  		document.getElementById("txtCOM_NM").readOnly = false;
            document.getElementById("txtCET_NO").className = "";
	  		document.getElementById("txtCET_NO").readOnly = false;
	  		document.getElementById("cmbREL_CD").disabled = false;
	  		document.getElementById("cmbMED_CD").disabled = false;
            document.getElementById("cmbGBN_TAG").disabled = false;

  		}

        /********************************************
         * 17. �Է��ʵ� ��� �Ұ����ϰ�(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

  			document.getElementById("txtCARD_CNT").className = "input_ReadOnly";
	  		document.getElementById("txtCARD_CNT").readOnly = true;
	  		form1.medCARD_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NO").readOnly = true;
            document.getElementById("txtCOM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NM").readOnly = true;
            document.getElementById("txtCET_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCET_NO").readOnly = true;
	  		document.getElementById("cmbREL_CD").disabled = true;
	  		document.getElementById("cmbMED_CD").disabled = true;
            document.getElementById("cmbGBN_TAG").disabled = true;

            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAddnew");
            fnc_HiddenElement("imgDelete");  
            
  		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
        }

        function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

       }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_MEDICAL)		   |
    | 3. ���Ǵ� Table List(T_AC_MEDICAL) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_MEDICAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_AC_MEDICAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
        <Param Name="SubsumExpr" 	  		Value="total">
	</Object>

	<!-- ���� �޺��� ���� DataSet -->
    <!-- ���豸�� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FA"/>
       <jsp:param name="CODE_GUBUN"    value="FA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!-- ���� �޺��� ���� DataSet -->
    <!-- �Ƿ������ڵ� ���� -->
    <!-- �������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FC"/>
       <jsp:param name="CODE_GUBUN"    value="FC"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_MEDICAL)		   |
    | 3. ���Ǵ� Table List(T_AC_MEDICAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_MEDICAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AC_MEDICAL=dsT_AC_MEDICAL,I:dsT_AC_MEDICAL=dsT_AC_MEDICAL)">
	</Object>



	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_MEDICAL Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}else{
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount-1);
        }
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_AC_MEDICAL Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_MEDICAL Event="OnDataError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
	    if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[����ڵ�Ϲ�ȣ/������]\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_AC_MEDICAL event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_MEDICAL event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script language=JavaScript for=dsT_AC_MEDICAL event=OnRowPosChanged(row)>

        //if(dsT_AC_MEDICAL.RowStatus(row) == 1){
        //    fnc_enableInput();
        //}else{
        //    fnc_disableInput();
        //}

	</script>

<!-- <script language=JavaScript for=medCARD_AMT event=onKillFocus()>

        form1.medSUM_AMT.Text = Number(form1.medCARD_AMT.Text) + Number(form1.medCASH_AMT.Text);

      </script>

	<script language=JavaScript for=medCASH_AMT event=onKillFocus()>

        form1.medSUM_AMT.Text = Number(form1.medCARD_AMT.Text) + Number(form1.medCASH_AMT.Text);

    </script> -->


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

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ƿ����������Է�</td>
					<td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">�Ƿ����������Է�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- power Search���̺� ���� -->
	<table width="600px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="40"></col>
							<col width="50"></col>
                            <col width="150"></col>
                            <col width="50"></col>
                            <col width="80"></col>
                            <col width="50"></col>
							<col width=""></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
							<td class="padding2423">
<%
  if(!isMaster) {
%>
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>
<%
  }else{
%>
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4">
<%
  }
%>
							</td>
                            <td align="right" class="searchState">���&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10"onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
                                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                <input type="hidden" id="hidEMPL_DPT_CD">
                            </td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">����&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="6" class="input_ReadOnly" readonly>
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

	<!-- ���� �Է� ���̺� ���� -->
	<table width="600px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="55"></col>
                        <col width="70"></col>
                        <col width="120"></col>
                        <col width="80"></col>
                        <col width="105"></col>
                        <col width="60"></col>
                        <col width="55"></col>
                        <col width=""></col>
                    <tr>
                        <td align="center" class="creamBold">�����</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <select id="cmbREL_CD" style="width=100%">
                            </select>
                        </td>
                        <td align="center" class="creamBold">�ֹε�Ϲ�ȣ</td>
                        <td class="padding2423">
                            <input id="txtCET_NO" style="width=100%;ime-mode:disabled;" maxLength="14" onKeypress="cfNumberCheck();" onKeyUp="cfCetNoHyphen(this);">
                        </td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423" colspan="2">
                            <select id="cmbGBN_TAG" style="width=100%">
                                <option value=""></option>
                                <option value="A">�����</option>
                                <option value="B">65���̻���</option>
                            </select>
                        </td>
                    </tr>                        
                        
                    <tr>
                         <td align="center" class="creamBold" rowspan="2">����ó</td>
                        <td align="center" class="creamBold">����ڹ�ȣ</td>
                        <td class="padding2423">
                            <input id="txtCOM_NO" maxlength="12" style="width=100%;ime-mode:disabled" onKeypress="javascript:cfNumberCheck();" onkeyup="cfComNoHyphen(this);">
                        </td>
                        <td align="center" class="creamBold">������</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtCOM_NM" style="width=100%" maxLength="30" onKeyUp="fc_chk_byte(this,30)">
                        </td>
                        <td align="center" class="creamBold">�Ǽ�</td>
                        <td class="padding2423">
                            <input id="txtCARD_CNT" maxlength="3" style="width=100%;ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold" >���ޱݾ�</td>
                        <td class="padding2423">
	                        <comment id="__NSID__">
	                        <object id="medCARD_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
	                            <param name=Alignment               value=2>
	                            <param name=Border                  value=true>
	                            <param name=ClipMode                value=true>
	                            <param name=DisabledBackColor       value="#EEEEEE">
	                            <param name=Enable                  value=true>
	                            <param name=IsComma                 value=true>
	                            <param name=Language                value=0>
	                            <param name=MaxLength               value=8>
	                            <param name=Numeric                 value=true>
	                            <param name=NumericRange            value=0~+:0>
	                            <param name=ShowLiteral             value=false>
	                            <param name=Visible                 value=true>
	                            <param name=SelectAll               value="true">
	                        </object>
	                        </comment>
	                        <script> __ShowEmbedObject(__NSID__); </script>
                        </td>


                        <td align="center" class="creamBold">�Ƿ������ڵ� </td>
                          <td class="padding2423" colspan="4">
                           <select id="cmbMED_CD" style="width:100%" >
                            </select>
                        </tr>


                </table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->
	</td>
	<td valign="top">
        <table width="190px" border="1" cellspacing="0" cellpadding="0">
            <tr>
                <td class="searchState">
                    <br>
	                &nbsp;-���κ�, �������� �ջ�
	                &nbsp;&nbsp;�ݾװ� �Ǽ��� �Է��Ͻñ�
	                &nbsp;&nbsp;�ٶ��ϴ�.
                    <br>&nbsp;
	                <br>&nbsp;
                    <br>&nbsp;    
                    <br>&nbsp;             
                </td>
            </tr>
        </table>
	</td>
</tr>
</table>

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState" width="280"><span id="resultMessage">&nbsp;</span></td>
                        <td align="left" class="searchState">
                            <!--��10���� ������ ��ġ�ڱ� ��α��� �Է����� �����ŵ� �˴ϴ�.<BR>-->
                            <!--�ذ����޴� �Ƿ�� 200���� �̻��� �е鸸 �ݵ�� �Է� �ٶ��ϴ�.<BR>-->
                            <FONT color=#0033CC>�ر���û���� �������갣��ȭ���񽺸� ���� �����ϴ� �Ƿ���ڷ��� ��쿡�� �Ƿ�� ��������ں��� �Ƿ�� ���� �հ���� �����ϴ�. ���� ����ó�� ����ڵ�Ϲ�ȣ, �Ǽ��� ���� �ƴ��մϴ�.</FONT>
                        </td>
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
					<object id="grdT_AC_MEDICAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" 						value="dsT_AC_MEDICAL">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"			value=1>								
						<param name="Format" 						value='
                            <C> id={currow}     		width=34    	name="NO"                       	align=center    SumBgColor=#C3D0DB  SumText="�հ�"</C>
                        <G> name="�����" align=center HeadBgColor="#F7DCBB"
                            <C> id="REL_CD"     width=110   name="����"                     			align=center    EditStyle=Lookup Data="dsT_CM_COMMON_FA:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="CET_NO"     width=90    name="������ֹι�ȣ"           		align=center    SumBgColor=#C3D0DB</C>
                            <C> id="GBN_TAG"    width=65    name="����"                     			align=center    Value={Decode(GBN_TAG,"A","�����","B","65���̻���")}  SumBgColor=#C3D0DB</C>
                       </G>
                    	<G> name="����ó" align=center HeadBgColor="#F7DCBB"
                            <C> id="MED_CD"     	width=170   	name="�Ƿ������ڵ�"             	align=left    EditStyle=Lookup Data="dsT_CM_COMMON_FC:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="COM_NO"     	width=80    	name="����ڹ�ȣ"               	align=center    SumBgColor=#C3D0DB</C>
                            <C> id="COM_NM"     	width=115   	name="������"                 	align=left        SumBgColor=#C3D0DB</C>
                            <C> id="CARD_CNT"   	width=30    	name="�Ǽ�"                     	align=right      SumBgColor=#C3D0DB SumText=@sum</C>
                            <C> id="CARD_AMT"   	width=70    	name="���ޱݾ�"                 	align=right      SumBgColor=#C3D0DB SumText=@sum</C>
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

	<input type="hidden" name="print_flag" value="N">
	</form>
	<!-- form �� -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_MEDICAL ���� ���̺� -->
	<object id="bndT_AC_MEDICAL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_MEDICAL">
		<Param Name="BindInfo", Value="
            <C>Col=CARD_AMT     		Ctrl=medCARD_AMT    	Param=text  </C>
            <C>Col=CARD_CNT     		Ctrl=txtCARD_CNT    	Param=value </C>
            <C>Col=CASH_AMT			Ctrl=medCASH_AMT		Param=text  </C>
            <C>Col=CASH_CNT     		Ctrl=txtCASH_CNT    	Param=value </C>
            <C>Col=SUM_AMT			Ctrl=medSUM_AMT		Param=text  </C>
            <C>Col=COM_NO				Ctrl=txtCOM_NO			Param=value </C>
            <C>Col=COM_NM				Ctrl=txtCOM_NM			Param=value </C>
            <C>Col=REL_CD				Ctrl=cmbREL_CD			Param=value </C>
            <C>Col=MED_CD				Ctrl=cmbMED_CD			Param=value </C>
            <C>Col=CET_NO				Ctrl=txtCET_NO			Param=value </C>
            <C>Col=GBN_TAG				Ctrl=cmbGBN_TAG		Param=value </C>
           		">
	</object>
