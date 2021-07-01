<!--
***********************************************************************
* @source      : yaca040_14.jsp
* @description : ��αݰ��������Է� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/11/6            �̵���             �����ۼ�    
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>

<%

 	request.setCharacterEncoding("euc-kr"); 

    String PIS_YY       = request.getParameter("PIS_YY");        
    String ENO_NO       = request.getParameter("ENO_NO");
    String ENO_NM       = request.getParameter("ENO_NM");
    String DPT_NM       = request.getParameter("DPT_NM");
    String JOB_NM       = request.getParameter("JOB_NM");

    String CET_NO 	= request.getParameter("CET_NO");        
    String REL_CD 		= request.getParameter("REL_CD");   
    String NAM_KOR 	= request.getParameter("NAM_KOR");         
    String gusrid 		= request.getParameter("gusrid");
    
 	boolean itMaster = false;     
 	
	//itMaster = true;     
	//���������� �ƴ��� ����
	if(gusrid.equals("6060002") ) {
		itMaster = true;
	}
	 
%>

<html>
<head>
	<title>��αݰ��������Է�(yaca040_2014�⵵)</title>
	
    <jsp:include page="/Ehr/common/include/head.jsp"/>  	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

	<script language="javascript">

		var today = getToday();
		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTTTT';
        //�Ѿ�� ������ ó��
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";        
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";   
        
        var submit = "<%=request.getParameter("END_YN") %>";
        var CET_NO = "<%=request.getParameter("CET_NO") %>";        
        var REL_CD = "<%=request.getParameter("REL_CD") %>";   
        var NAM_KOR = "<%=request.getParameter("NAM_KOR") %>";         
        
        var gusrid = "<%=request.getParameter("gusrid") %>";  
        
	 	/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_DONATION.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SHR_142&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_DONATION.reset();
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
   
			var PIS_YY   = document.form1.txtPIS_YY_SHR.value;
			var ENO_NO  = document.form1.txtENO_NO_SHR.value;
			
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			//��ü�� �Ѿ�� �ؾ���
            dsT_AC_DONATION.UseChangeInfo = "false";
            			
			// save
			trT_AC_DONATION.Parameters = "PIS_YY="+PIS_YY+",ENO_NO="+ENO_NO;			
			trT_AC_DONATION.KeyValue = "tr01(I:dsT_AC_DONATION=dsT_AC_DONATION)";
			trT_AC_DONATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SAV_14";
			trT_AC_DONATION.post();

			fnc_UpdateAcc();
			
        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	// ���º����û�� ����

			if (dsT_AC_DONATION.CountRow < 1) {
				//fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

           	var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            tmpMSG += "����ڵ�Ϲ�ȣ = "+dsT_AC_DONATION.nameValue(dsT_AC_DONATION.RowPosition, "COM_NO")+"\n";
            tmpMSG += "��ȣ(���θ�)       = "+dsT_AC_DONATION.nameValue(dsT_AC_DONATION.RowPosition, "COM_NM")+"\n";

	        if( confirm(tmpMSG) ){
			    var status = dsT_AC_DONATION.RowStatus(dsT_AC_DONATION.RowPosition);
				dsT_AC_DONATION.DeleteRow(dsT_AC_DONATION.RowPosition);
			    if(status != 1){
                    trT_AC_DONATION.KeyValue = "tr01(I:dsT_AC_DONATION=dsT_AC_DONATION)";
                    trT_AC_DONATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=DEL_14";
                    trT_AC_DONATION.post();
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

                var url = "yaca040_PV.jsp?pis_yy="+pis_yy+"&eno_no="+eno_no;
                
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
                
            } else {
                alert("��ȸ�� �μⰡ���մϴ�.");
            }

            
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_DONATION.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_DONATION.GridToExcel("��αݰ��������Է�", '', 225);
        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_AC_DONATION.CountColumn < 1) {
            	
                //dsT_AC_DONATION.setDataHeader("PIS_YY:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, PIS_YM:STRING, COM_NO:STRING:KEYVALUETYPE, REMARK:STRING, COM_NM:STRING:KEYVALUETYPE, TOT_CNT:NUMBER, SUM_AMT:NUMBER, SEQ_NO:STRING:KEYVALUETYPE");
                
                alert("�ݵ�� ��ȸ�� �Է��� �����մϴ�.");                
                return false;
                
            }

            dsT_AC_DONATION.AddRow();
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;

            fnc_enableInput();

            document.getElementById("cmbREL_CD").focus();
			document.form1.txtTOT_CNT.value = "0";      
            fnc_GetFamNm();

        }

		/********************************************
         * 07. �ű� �Լ�2222 							*
         ********************************************/		
        function fnc_Add() {

        	dsT_AC_DONATION.AddRow();
            
        	//prompt(this,dsT_AC_DONATION.text);
        	
        	dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YY_SHR").value;
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;        	
            //dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_NM") = NAM_KOR;
			if(REL_CD == "0"){
				dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_CD") = "1";
			}else if(REL_CD == "1"||REL_CD == "2"){
				dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_CD") = "4";				
			}else if(REL_CD == "3"){
				dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_CD") = "2";
			}else if(REL_CD == "4"||REL_CD == "5"){
				dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_CD") = "3";	
			}else if(REL_CD == "6"){
				dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_CD") = "5";	
			}else if(REL_CD == "7"||REL_CD == "8"){
				dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_CD") = "6";						
			}			
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_NO") = CET_NO;            

            fnc_enableInput();
            
            document.getElementById("cmbFAM_NM").focus();
			document.form1.txtTOT_CNT.value = "0";     
            fnc_GetFamNm();            

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
			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';

        	dsT_AC_DONATION.ClearData();
            //fnc_disableInput();

            //document.getElementById("resultMessage").innerText = ' ';
            document.form1.print_flag.value = "N";
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_AC_DONATION.IsUpdated)  {
				if (!fnc_ExitQuestion2())  return;
			}

			window.close();
			//frame = window.external.GetFrame(window);

			//frame.CloseFrame();
        }

    	// ȭ�� ����� �ڷ� ���� ���� ��ȸ
    	function fnc_ExitQuestion2() {

    		if (confirm("����(����)�� �ڷᰡ �ֽ��ϴ�. \n\nȮ���� �����ø� ����� �ڷ�� ������� �ʰ� ���� �˴ϴ�.")) {
    			return true;
    		} else {
    			return false;
    		}
    	}		
		
		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            var rel_val = document.getElementById("cmbREL_CD1").value;


        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

	        var bizNo = document.getElementById("txtCOM_NO").value;

         	if ( !dsT_AC_DONATION.isUpdated ) {
	         	alert("������ �ڷᰡ �����ϴ�.");
                //fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

			//�ֹι�ȣ ����ڹ�ȣ üũ
			for(i=0;i<dsT_AC_DONATION.CountRow;i++){

			    if(dsT_AC_DONATION.RowLevel(i+1) !="9999"){
	                if(dsT_AC_DONATION.NameValue(i+1,"REL_CD") == '') {
	                    alert("��������� �ʼ� �Է� �׸��Դϴ�.");
	                    form1.cmbREL_CD.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '20') { // 20 : ��ġ�ڱ��� ��� ����ڹ�ȣ �Է¾���

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NO") == '') {
		                    alert("����ڹ�ȣ�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "").length != 10) {
		                    alert("����ڹ�ȣ�� �߸��Ǿ����ϴ�.");
		                    form1.txtCOM_NO.focus();
		                    return false;
		                }

			            bizNo = dsT_AC_DONATION.NameValue(i+1,"COM_NO").replace("-", "").replace("-", "");

			            if(bizNo_validate(bizNo) == false){
			            	alert("��ȿ���� ���� ����ڹ�ȣ�Դϴ�.");
			            	return false;
			            }


		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NM") == '') {
		                    alert("��ȣ(���θ�)�� �ʼ� �Է� �׸��Դϴ�.");
		                    form1.txtCOM_NM.focus();
		                    return false;
		                }
	                }else {

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NO") == ''){
		                	dsT_AC_DONATION.NameValue(i+1,"COM_NO") = '';
		                }

		                if(dsT_AC_DONATION.NameValue(i+1,"COM_NM") == ''){
		                	dsT_AC_DONATION.NameValue(i+1,"COM_NM") = '';
		                }
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_NO") == '') {
	                    alert("�ֹε�Ϲ�ȣ�� �ʼ� �Է� �׸��Դϴ�.");
	                    //form1.txtFAM_NO.focus();
	                    return false;
	                }

	                 if(dsT_AC_DONATION.NameValue(i+1,"FAM_NO").replace("-", "").length != 13) {
	                    alert("�ֹε�Ϲ�ȣ�� �߸��Ǿ����ϴ�.");
	                    //form1.txtFAM_NO.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_CD") == '') {
	                    alert("����� �ʼ� ���� �׸��Դϴ�.");
	                    form1.cmbFAM_CD.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_NM") == '') {
	                    alert("������ �ʼ� ���� �׸��Դϴ�.");
	                    form1.cmbFAM_NM.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"NTS_YN") == '') {
	                    alert("��ó�� �ʼ� ���� �׸��Դϴ�.");
	                    form1.cmbNTS_YN.focus();
	                    return false;
	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"NTS_YN") == '1' && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '10'
	                && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '20' 
	                && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '40' && dsT_AC_DONATION.NameValue(i+1,"REL_CD") != '41'){
	                	alert("�ش� ��������� ��ó�� ����û�ڷᰡ ������ �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.");
	                	form1.cmbNTS_YN.focus();
	                	return false;

	                }

	                if(dsT_AC_DONATION.NameValue(i+1,"FAM_CD") != '1' && (dsT_AC_DONATION.NameValue(i+1,"REL_CD") == '42'
	                || dsT_AC_DONATION.NameValue(i+1,"REL_CD") == '20')){
	                	alert("�ش� ��������� ���θ� ���� �����մϴ�. Ȯ�ιٶ��ϴ�.");
	                	form1.cmbFAM_NM.focus();
	                	return false;

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
    if(!itMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "imgEnoNo");
            document.getElementById("imgEnoNo").style.display = "none";

<%
    }
%>

			document.form1.txtPIS_YY_SHR.value = PIS_YY;		    
			document.form1.txtENO_NO_SHR.value = ENO_NO;
		    document.form1.txtENO_NM_SHR.value = ENO_NM;
		    document.form1.txtDPT_NM_SHR.value = DPT_NM;
		    document.form1.txtJOB_NM_SHR.value = JOB_NM;    
		
			cfStyleGrid_New(form1.grdT_AC_DONATION,15,"false","false");      // Grid Style ����

			dsT_AC_FAMILY.clearData();
			dsT_AC_FAMILY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SHR2_14&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
			dsT_AC_FAMILY.reset();

			//��������
			for( var i = 1; i <=  dsT_AC_FAMILY.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                oOption.text  = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                document.getElementById("cmbFAM_NM").add(oOption);

			}

            //�������
            for( var i = 1; i <= dsT_CM_COMMON_FB.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FB.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FB.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FB.NameValue(i,"CODE_NAME");
                document.getElementById("cmbREL_CD").add(oOption);

            }

            //���豸��
            for( var i = 1; i <= dsT_CM_COMMON_FD.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_FD.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_FD.NameValue(i,"CODE")+" "+dsT_CM_COMMON_FD.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFAM_CD").add(oOption);

            }



            fnc_SearchList();

		    if(submit=='Y' )
            {
	            alert("���������ϼ̽��ϴ�.");			    		    	
        		fnc_disableInput();
                return;
                
            }else if(submit!='Y' && dsT_AC_DONATION.countrow == ''){
            	fnc_Add();
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

            document.getElementById("txtTOT_CNT").className = "";
	  		document.getElementById("txtTOT_CNT").readOnly = false;
	  		form1.medSUM_AMT.Enable = "true";
            document.getElementById("txtCOM_NO").className = "";
	  		document.getElementById("txtCOM_NO").readOnly = false;
            document.getElementById("txtREMARK").className = "";
	  		document.getElementById("txtREMARK").readOnly = false;
            document.getElementById("txtCOM_NM").className = "";
	  		document.getElementById("txtCOM_NM").readOnly = false;
            //document.getElementById("txtSEQ_NO").className = "";
	  		//document.getElementById("txtSEQ_NO").readOnly = false;
            //document.getElementById("txtPIS_YM").className = "";
	  		//document.getElementById("txtPIS_YM").readOnly = false;
	  		document.getElementById("cmbREL_CD").disabled = false;

	//  		document.getElementById("cmbFAM_CD").disabled = false;
	//  	    document.getElementById("cmbFAM_NM").className = "";
	  		document.getElementById("cmbFAM_NM").disabled = false;
    		document.getElementById("txtFAM_NO").className = "";
	//  		document.getElementById("txtFAM_NO").disabled = false;
			document.getElementById("cmbNTS_YN").disabled = false;

  		}

        /********************************************
         * 17. �Է��ʵ� ��� �Ұ����ϰ�(Disable)    *
         ********************************************/
  		function fnc_disableInput(){

  			document.getElementById("txtTOT_CNT").className = "input_ReadOnly";
	  		document.getElementById("txtTOT_CNT").readOnly = true;
            form1.medSUM_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NO").readOnly = true;
            document.getElementById("txtREMARK").className = "input_ReadOnly";
	  		document.getElementById("txtREMARK").readOnly = true;
            document.getElementById("txtCOM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NM").readOnly = true;


	  		//document.getElementById("txtSEQ_NO").className = "input_ReadOnly";
	  		//document.getElementById("txtSEQ_NO").readOnly = true;
            //document.getElementById("txtPIS_YM").className = "input_ReadOnly";
	  		//document.getElementById("txtPIS_YM").readOnly = true;
	  		document.getElementById("cmbREL_CD").disabled = true;
	  		document.getElementById("cmbFAM_CD").disabled = true;
	  		document.getElementById("cmbFAM_NM").className = "input_ReadOnly";
	  		document.getElementById("cmbFAM_NM").disabled = true;
	  		document.getElementById("txtFAM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtFAM_NO").disabled = true;
	  		document.getElementById("cmbNTS_YN").disabled = true;
	  		
            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAddnew");
            fnc_HiddenElement("imgDelete");  
	  		

  		}

  		function fnc_disableInput2(){

  			document.getElementById("txtTOT_CNT").className = "input_ReadOnly";
	  		document.getElementById("txtTOT_CNT").readOnly = true;
            form1.medSUM_AMT.Enable = "false";
            document.getElementById("txtCOM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NO").readOnly = true;
            document.getElementById("txtREMARK").className = "input_ReadOnly";
	  		document.getElementById("txtREMARK").readOnly = true;
            document.getElementById("txtCOM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtCOM_NM").readOnly = true;
	  		document.getElementById("cmbREL_CD").disabled = true;
	  		document.getElementById("cmbFAM_CD").disabled = true;
	  		document.getElementById("cmbFAM_NM").className = "input_ReadOnly";
	  		document.getElementById("cmbFAM_NM").disabled = true;
	  		document.getElementById("txtFAM_NO").className = "input_ReadOnly";
	  		document.getElementById("txtFAM_NO").disabled = true;
	  		document.getElementById("cmbNTS_YN").disabled = true;

            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAddnew");
            fnc_HiddenElement("imgDelete");  
	  		
  		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {

        	fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','0');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {

            	fnc_SearchList();
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


		// ��α� �����(���� or �ξ簡��) ��ȸ
        function fnc_GetFamNm() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_FAMILY.clearData();
			dsT_AC_FAMILY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=SHR2_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_FAMILY.reset();

			document.getElementById("cmbFAM_NM").options.length = 0;

			//alert(document.getElementById("cmbFAM_NM").value);

			//���豸��
			oOption       = document.createElement("OPTION");
			oOption.value = "";
            oOption.text  = "";
            document.getElementById("cmbFAM_NM").add(oOption);

            for( var i = 1; i < dsT_AC_FAMILY.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                oOption.text  = dsT_AC_FAMILY.NameValue(i,"FAM_NM");
                document.getElementById("cmbFAM_NM").add(oOption);

            }
            dsT_AC_DONATION.NameValue(dsT_AC_DONATION.RowPosition,"FAM_NM") = NAM_KOR;
            
        }

        function setFamNo(selVal){

            for( var i = 1; i < dsT_AC_FAMILY.CountRow; i++ ) {
            	
            	if(dsT_AC_FAMILY.NameValue(i,"FAM_NM") == selVal){        	

    	        document.getElementById("cmbFAM_CD").value = dsT_AC_FAMILY.NameValue(i,"FAM_CD");
    	        document.getElementById("cmbFAM_CD").disabled = true;
    	        
    	        document.getElementById("txtFAM_NO").value = dsT_AC_FAMILY.NameValue(i,"FAM_NO");
    	        document.getElementById("txtFAM_NO").disabled = true;            		
            		
	            //document.getElementById("cmbFAM_CD").value = dsT_AC_FAMILY.NameValue(document.getElementById("cmbFAM_NM").selectedIndex,"FAM_CD");
	            //document.getElementById("cmbFAM_CD").disabled = true;
	            //document.getElementById("txtFAM_NO").value = dsT_AC_FAMILY.NameValue(document.getElementById("cmbFAM_NM").selectedIndex,"FAM_NO");
	            //document.getElementById("txtFAM_NO").disabled = true;
	            
	    		break;
    		
            	}
            	
            }

        }

        function fnc_UpdateAcc(){

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_DONATION2.UseChangeInfo = false;

			dsT_AC_DONATION2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=ACC_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_DONATION2.reset();
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
    | 2. �̸��� ds_ + �ֿ� ���̺���(T_AC_DONATION)		   |
    | 3. ���Ǵ� Table List(T_AC_DONATION) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_AC_DONATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_AC_DONATION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
	</Object>

	<Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
	</Object>



	<!-- ���� �޺��� ���� DataSet -->
    <!-- ���豸�� -->
    <jsp:include page="/Ehr/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FD"/>
       <jsp:param name="CODE_GUBUN"    value="FD"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-- ���� �޺��� ���� DataSet -->
    <!-- ������� -->
    <jsp:include page="/Ehr/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_FB"/>
       <jsp:param name="CODE_GUBUN"    value="FB"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺���(T_AC_DONATION)		   |
    | 3. ���Ǵ� Table List(T_AC_DONATION)			       |
    +------------------------------------------------------>
	<Object ID="trT_AC_DONATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AC_DONATION=dsT_AC_DONATION,I:dsT_AC_DONATION=dsT_AC_DONATION)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_AC_DONATION Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
		}else{
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_AC_DONATION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)      
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_AC_DONATION Event="OnDataError()">
        //document.getElementById("resultMessage").innerText = ' ';
        //prompt(this,dsT_AC_DONATION.text);        
        //Dataset���� Error ó��
	    if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�������/����ڵ�Ϲ�ȣ]\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        //else if (this.ErrorCode == 50019) {
	    //    alert("[�������/����ڵ�Ϲ�ȣ]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        //}
        else {        

		    cfErrorMsg(this);
	    }
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_AC_DONATION event="OnSuccess()">
	    //fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
	    alert("�۾��� �Ϸ� �Ͽ����ϴ�!");   	
		fnc_UpdateAcc();
        fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_AC_DONATION event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20"  onload="fnc_OnLoadProcess();">

	<!-- form ���� -->
	<form name="form1">
<br>
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="900" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">��αݰ��������Է�</td>
					<td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">��αݰ��������Է�</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="900" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="900px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>

	<!-- power Search���̺� ���� -->
	<table width="900px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
							<col width="70"></col>
							<col width="50"></col>
							<col width="60"></col>
                            <col width="180"></col>
                            <col width="80"></col>
                            <col width="90"></col>
                            <col width="90"></col>
							<col width=""></col>
                        </colgroup>
						<tr>
                            <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
							<td class="padding2423">
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>
							</td>
                            <td align="right" class="searchState">���&nbsp;</td>
                            <td class="padding2423">
                            	<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
								<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
                                <img src="../../images/button/btn_HelpOn.gif" id="imgEnoNo" name="imgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                <input type="hidden" id="hidEMPL_DPT_CD">
                            </td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="20" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">����&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="15" class="input_ReadOnly" readonly>
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
	<table width="900px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="150"></col>
                        <col width="180"></col>
                        <col width="120"></col>     
                        <col width="150"></col>   
                        <col width="120"></col>                                                                 
                        <col width=""></col>
                    </colgroup>
                    
                    <tr>
                        <td align="center" class="blueBold">����</td>
                        <td class="padding2423">
                             <select id="cmbFAM_NM" style="width=100%" onChange="setFamNo(this.value);">
                             </select>
                        </td>
                        <td align="center" class="blueBold">����</td>
                        <td class="padding2423">
                            <select id="cmbFAM_CD" style="width=100%">
                            </select>
                        </td>
                        <td align="center" class="blueBold">�ֹε�Ϲ�ȣ</td>
                        <td class="padding2423" colspan="2">
                             <input id="txtFAM_NO" style="width=100%;ime-mode:disabled;" maxLength="14" onKeypress="cfNumberCheck();" onKeyUp="cfCetNoHyphen(this);">
                        </td>
                      </tr>                    
                    <tr>
                        <td align="center" class="blueBold">��ó</td>
						<td class="padding2423" align="left">
								<select id="cmbNTS_YN" style="width:100%;">
									<option value=""></option>
									<option value="1">����û�ڷ�</option>
									<option value="2">�׹����ڷ�</option>
								</select>
						</td>                    
                        <td align="center" class="blueBold">�������</td>
                        <td class="padding2423"  colspan="4">
                            <select id="cmbREL_CD" style="width=60%">
                            </select>
                        </td>
                       </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                    <colgroup>
                        <col width="150"></col>
                        <col width="180"></col>
                        <col width="120"></col>                       
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="blueBold">��ȣ(���θ�)</td>
                        <td class="padding2423" >
                            <input id="txtCOM_NM" style="width=100%" maxLength="60" onKeyUp="fc_chk_byte(this,60)">
                        </td>
                        <td align="center" class="blueBold">��γ���</td>
                        <td class="padding2423">
                            <input id="txtREMARK" style="width=100%" maxLength="50" onKeyUp="fc_chk_byte(this,50)">
                        </td>
                    </tr>
                </table>

                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="150"></col>
                        <col width="180"></col>
                        <col width="120"></col>
                        <col width="150"></col>   
                        <col width="120"></col>       
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="blueBold">����ڵ�Ϲ�ȣ</td>
                        <td class="padding2423">
                            <input id="txtCOM_NO" maxlength="12" style="width=100%;ime-mode:disabled" onKeypress="javascript:cfNumberCheck();" onkeyup="cfComNoHyphen(this);">

                        </td>            						
						
                        <td align="center" class="blueBold">��ΰǼ�</td>
                        <td class="padding2423">
                        <input id="txtTOT_CNT" maxlength="3" style="width=100%;ime-mode:disabled;text-align:right" onKeypress="cfNumberCheck();"></td>
                        <td align="center" class="blueBold">��α��հ�</td>
                        <td class="padding2423">
                            <comment id="__NSID__">
                            <object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
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
                    </tr>
                </table>
			</td>
		</tr>
	</table>
	</td>
</tr>
</table>
	<!-- ���� �Է� ���̺� �� -->
	
	
    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="900" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <!-- <td valign="bottom" class="searchState" width="280"><span id="resultMessage">&nbsp;</span></td> -->
                        <td align="left" class="searchState">
						<FONT color=#0033CC>
			                            ����ġ�ڱ� ��α��� ���ó�� ������� ��ü�ݾ��� �ջ��Ͽ� 1������ �Է¹ٶ��ϴ�.<BR>
			                            ����ġ�ڱ� ��α��� ��ȣ�� ����ڵ�Ϲ�ȣ�� ���� �ƴ��մϴ�.<BR></FONT>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="900" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
					<comment id="__NSID__">
					<object id="grdT_AC_DONATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:900px;height:330px;">
						<param name="DataID" 						value="dsT_AC_DONATION">
						<param name="Editable" 					value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 					value="Left">
						<param name="VIEWSUMMARY"			value=1>							
						<param name="Format" 						value='
							<C> id={currow}			width=25    name="NO"		                	align=center  SumBgColor=#C3D0DB  SumText="�հ�"</C>
				    	<G> name="�����" HeadBgColor=#dae0ee    TextColor=#34578c  HeadFontStyle = "bold"   
							<C> id="FAM_NM"     	width=55    name="����"                     	align=center  SumBgColor=#C3D0DB </C>
							<C> id="FAM_CD"     	width=60    name="����"                     	align=center     EditStyle=Lookup Data="dsT_CM_COMMON_FD:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="FAM_NO"     	width=100    name="������ֹι�ȣ"           align=center  SumBgColor=#C3D0DB </C>
						</G>

                            <C> id="NTS_YN"			width=50	name="����"		            	align=center      Value={Decode(NTS_YN,"1","����û","2","�׿�")} SumBgColor=#C3D0DB</C>

                            <C> id="REL_CD"			width=100	name="�������"		            align=left      EditStyle=Lookup Data="dsT_CM_COMMON_FB:CODE:CODE_NAME" SumBgColor=#C3D0DB</C>
                            <C> id="COM_NM"		width=120	name="��ȣ(���θ�)"		    	align=left	   SumBgColor=#C3D0DB </C>

                            <C> id="REMARK"     	width=165    name="��γ���"                 	align=left       SumBgColor=#C3D0DB </C> 
                            <C> id="COM_NO"     	width=80    name="�����\\��Ϲ�ȣ"        align=center   SumBgColor=#C3D0DB </C>
                          	<C> id="TOT_CNT"		width=30	name="�Ǽ�"                     	align=center	RightMargin="1" SumBgColor=#C3D0DB </C>
							<C> id="SUM_AMT"		width=80	name="��α��հ�"	            align=right	   RightMargin="10" SumBgColor=#C3D0DB SumText=@sum</C>
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

	<!-- T_AC_DONATION ���� ���̺� -->
	<object id="bndT_AC_DONATION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_DONATION">
		<Param Name="BindInfo", Value="
			<C>Col=TOT_CNT		Ctrl=txtTOT_CNT		Param=value </C>
            <C>Col=SUM_AMT	Ctrl=medSUM_AMT	Param=text  </C>
            <C>Col=COM_NO		Ctrl=txtCOM_NO		Param=value </C>
            <C>Col=COM_NM		Ctrl=txtCOM_NM		Param=value </C>
            <C>Col=REMARK		Ctrl=txtREMARK		Param=value </C>
            <C>Col=REL_CD		Ctrl=cmbREL_CD		Param=value </C>       
            <C>Col=FAM_CD		Ctrl=cmbFAM_CD		Param=value </C>
            <C>Col=FAM_NM		Ctrl=cmbFAM_NM		Param=value </C>
            <C>Col=FAM_NO		Ctrl=txtFAM_NO		Param=value </C>
            <C>Col=NTS_YN		Ctrl=cmbNTS_YN		Param=value </C>
		">
	</object>