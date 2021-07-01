	<!--*************************************************************************
	* @source      : guna014.jsp												*
	* @description : ���º��� PAGE										        *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/06/01      �̵���        ERP �̻�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
	//String eno_no = gusrid;         	//ǰ���ڻ��
	//String eno_nm = gusrnm;         //ǰ���ڻ��
	//String dep_cd = gdeptcd;         //ǰ���ںμ�
	
	//String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
	//String eno_nm = box.getString("SESSION_ENONM");         //ǰ���ڻ��
	//String dep_cd = box.getString("SESSION_DPTCD");         //ǰ���ڻ��
	
	String MODE = request.getParameter("MODE");		// ����(INS: ��ϸ��, UPDATE:�������)

	String str_ymd_shr = request.getParameter("str_ymd_shr");
	String end_ymd_shr = request.getParameter("end_ymd_shr");

	String param_eno_no = request.getParameter("eno_no");
	String param_req_no = request.getParameter("req_no");
	String param_app_yn_nm = request.getParameter("app_yn_nm");
 %>
<html>
<head>
<title>���º���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var today = gcurdate;

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
			
			trT_DI_DILIGENCE_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna013.cmd.GUNA013CMD"
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

			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			// save
			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_APPROVAL=dsT_DI_APPROVAL,O:dsT_DI_DILIGENCE_TEMP=dsT_DI_DILIGENCE_TEMP)";
			
			trT_DI_DILIGENCE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna013.cmd.GUNA013CMD&S_MODE=SAV&REQ_NO="+document.getElementById("txtREQ_NO_SHR").value;
			
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

					if(REQ_NO == ""){
						return;
					}

					trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
					
					trT_DI_DILIGENCE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna013.cmd.GUNA013CMD&S_MODE=DEL&REQ_YMD="+REQ_YMD+"&REQ_NO="+REQ_NO+"&CHN_YMD="+CHN_YMD+"&ENO_NO="+ENO_NO;
					
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

			if(dsT_DI_DILIGENCE.CountRow > 0){
				
				if(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_YMD") == ""){
					
					alert("�������� �ʼ� �Է»����Դϴ�");
					
					return;
					
				}
				
			}
			
			// �� �߰�
			dsT_DI_DILIGENCE.AddRow();

		    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001" ){ 


				if(dsT_DI_DILIGENCE.CountRow > 1){
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;	
					
					
				}else{
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;	
				}
				
				fnc_ChangeStateElement(false, "ImgEnoNo");
				fnc_ChangeStateElement(false, "txtENO_NO");
				fnc_ChangeStateElement(false, "txtENO_NM");

    		}else{

				if(dsT_DI_DILIGENCE.CountRow > 1){
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NM");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_CD");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_NM");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "JOB_NM");
					
				}else{
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;						
				}
		
				fnc_DisableElementAll(elementList);
				fnc_ChangeStateElement(true, "ImgEnoNo");
				fnc_ChangeStateElement(true, "txtENO_NO");
				fnc_ChangeStateElement(true, "txtENO_NM");
				fnc_ChangeStateElement(true, "txtREMARK");

    	}

			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "FLAG") = "INS";
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			
			if(dsT_DI_DILIGENCE.CountRow > 0){
				
				if(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_YMD") == ""){
					
					alert("�������� �ʼ� �Է»����Դϴ�");
					
					return;
					
				}
				
			}
			
			var STR_YMD_SHR = "<%=str_ymd_shr%>";
			
			var END_YMD_SHR = "<%=end_ymd_shr%>";

            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;
            
			var EMP_NO      = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO");

			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"U")

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
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
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

			document.form1.txtENO_NO.value =gusrid;
			document.form1.txtENO_NM.value =gusrnm;

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
			
			// ��ü�ް�(T), ��ü����(U) ������� üũ
			
			var gunCnt = 0;
			
			var afterGunCnt = 0;
			
     		for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
     			
				// ���³�¥ �ݵ�� �Է��ؾ��Ѵ�
				
				if( (dsT_DI_DILIGENCE.RowStatus(i) == 3 || dsT_DI_DILIGENCE.RowStatus(i) == 2) && dsT_DI_DILIGENCE.NameValue(i,"BF_YMD").trim() == "" ){
					
                    alert("���³�¥�� �ݵ�� �Է��ؾ��մϴ�..");
                    
                    dsT_DI_DILIGENCE.RowPosition = i;
                    
                    form1.grdT_DI_DILIGENCE.SetColumn("BF_YMD");
                    
                    return false;
                    
                }
				
     		    //���� �ݵ�� �Է��� �ʿ��ϴ�.
                //if( (dsT_DI_DILIGENCE.RowStatus(i) == 3 || dsT_DI_DILIGENCE.RowStatus(i) == 2) && dsT_DI_DILIGENCE.NameValue(i,"AF_REMARK").trim() == "" ){
               //     alert("�ش� ������ �ݵ�� �Է��ؾ��մϴ�..");
               //     dsT_DI_DILIGENCE.RowPosition = i;
               //    form1.grdT_DI_DILIGENCE.SetColumn("AF_REMARK");
               //     return false;
               // }
     		    
				 GUN_CD = dsT_DI_DILIGENCE.NameValue(i,"BF_GUN_CD");
				 
				 AF_GUN_CD = dsT_DI_DILIGENCE.NameValue(i,"AF_GUN_CD");
				 
				 
				 //2020.08.06 ���� ������ �����θ� ��������
				 if(GUN_CD == "M"){
					 
					 if(GUN_CD != AF_GUN_CD){
						 
					 	alert("���� ������ �����θ� �����Ҽ� �ֽ��ϴ�");
					 	return;
					 	
					 }
					 
				 }
				 
				 
				 if(GUN_CD == "T"){
					 
					 gunCnt +=1;
					 
				 }else if(GUN_CD == "U"){
					 
					 gunCnt += 0.5;
					 
				 }

				 if(AF_GUN_CD == "T"){
					 
					 afterGunCnt +=1;
					 
				 }else if(AF_GUN_CD == "U"){
					 
					 afterGunCnt += 0.5;
					 
				 }
     		}
     		
			 if(afterGunCnt != gunCnt){
				 
				alert("���� ��ü�ް�, ��ü���� ��ŭ�� �����Ҽ� �ֽ��ϴ�");
				
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "AF_GUN_CD") = "";
				
				return;
			 }

			 
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

			cfStyleGrid_New(form1.grdT_DI_DILIGENCE,15,"true","false");      // Grid Style ����
			
			cfStyleGrid_New(form1.grdT_DI_DILIGENCE_BEFORE,15,"true","false");      // Grid Style ����
			
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,15,"true","false");      // Grid Style ����


            document.getElementById('hidEMPL_DPT_CD').value = gdeptcd;




            if("<%=param_app_yn_nm%>" =="����Ϸ�" || "<%=param_app_yn_nm%>"=="����������"){
                document.getElementById("append_btn").style.display = "none";
                document.getElementById("btn_InsDel").style.display = "none";
            }else{
                document.getElementById("append_btn").style.display = "";
                document.getElementById("btn_InsDel").style.display = "";
            }
			document.getElementById("resultMessage").innerText = '**�۾�����:�� Sheet�� ������ ���ϴ� ���¸� ����Ŭ��=>�Ʒ� Sheet �����ʿ��� ����=>���缱����=>���.**';

			<%
				if("READ".equals(MODE)){
			%>
					document.getElementById("txtREQ_NO_SHR").value = "<%=param_req_no%>";
					fnc_SearchList();
					fnc_SearchYRP("<%=param_eno_no%>") ;
			<%
				}else{
			
			%>
					fnc_SearchYRP(gusrid) ;
			
			<%
				}
			%>
			
			document.getElementById("txtMODE").value = "<%=MODE%>";
			
			fnc_DisableElementAll(elementList);

        	// ����(�Է�)
        	var h4_cd = "";

			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {

                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE")

			    if(h4_cd == "D" || h4_cd == "Y" ||
			       h4_cd == "M" || h4_cd == "N" || h4_cd == "O" || h4_cd == "X" || h4_cd == "9" ||
				   h4_cd == "K" || h4_cd == "V" || h4_cd == "L" || h4_cd == "E"
				){
                    continue;
			    }

				oOption       = document.createElement("OPTION");
				
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
           	 	
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
        	    
				document.getElementById("cmbGUN_CD").add(oOption);
				
			}

			dsT_CM_COMMON_H4.InsertRow(1);
			
			dsT_CM_COMMON_H4.NameValue(1,"CODE") =  "";
			
        	dsT_CM_COMMON_H4.NameValue(1,"CODE_NAME") = "";

			fnc_BeforeDilList(gusrid);
        }


        function fnc_BeforeDilList(ENO_NO) {

			trT_DI_DILIGENCE_BEFORE.KeyValue = "tr06(O:dsT_DI_DILIGENCE_BEFORE=dsT_DI_DILIGENCE_BEFORE)";
			
			trT_DI_DILIGENCE_BEFORE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna013.cmd.GUNA013CMD"
												                       + "&S_MODE=SHR_06"
									                                   + "&ENO_NO="+ENO_NO;
			
			trT_DI_DILIGENCE_BEFORE.post();

        }

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
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

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

  		}

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            
            fnc_SearchEmpNo();
            
        }
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
        	
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;

                dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"DPT_CD")           = obj.dpt_cd;
				fnc_SearchYRP(obj.eno_no) ;
				fnc_BeforeDilList(obj.eno_no);
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }


        }
        //������ ��¥���� üũ
        function fnc_ChkDate(BF_YMD) {

            var PIS_YYMMDD = BF_YMD;
            
			if(PIS_YYMMDD.length != 8){
				alert("��¥�� ��Ȯ�� �Է��Ͻʽÿ�.  ����:YYYYMMDD  ���ڸ� �Է�");
			}
			
            var today = gcurdate.replace("-","").replace("-","");

            if(PIS_YYMMDD != ""){
            	
	            if(PIS_YYMMDD < today){
	            	
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

        function fnc_SearchYRP(ENO_NO) {
        	
			var today = gcurdate.replace("-","").replace("-","").substring(0,4);
			
			trT_DI_YEARLY.KeyValue = "tr06(O:dsT_DI_YEARLY=dsT_DI_YEARLY)";
			
			trT_DI_YEARLY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna012.cmd.GUNA012CMD"
				                                   + "&S_MODE=SHR_YRP"
				                                   + "&YYYY="+today+"&ENO_NO="+ENO_NO;
			
			trT_DI_YEARLY.post();
		}
		/********************************************
         * 01. ����üũ 			 	*
         ********************************************/
        function fnc_YrpCheck() {
			
			var NEW_GUN_CD = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "AF_GUN_CD");		//�ű� �����ڵ�
			
			var MF_TAG     = dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "MF_TAG");

			// ������ �ް� Check
			if(NEW_GUN_CD == "J" && MF_TAG == "M"){
				
				alert("���������� ������ �ް��� ����Ҽ� �����ϴ�.");
				
				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "AF_GUN_CD") = "";
				
				return;
				
			}
			
			//15�Ϻ��� ���� ����� ��������û����
			//15�Ϻ��� ���� ����� ��������û�Ұ�
			//��밡���ѿ���
			var YRP_CNT = document.getElementById("txtYRP_CNT").value;			//����
			var AYRP_CNT = document.getElementById("txtAYRP_CNT").value;		//������
			var NET_YRP_CNT = document.getElementById("txtNET_YRP_CNT").value;	//�����߻��ϼ�
			var YRP_USE = document.getElementById("txtYRP_USE").value;			//����ѿ���
			var ADD_YRP_CNT = 0;
			
			//H:����, P:����������, R:���Ŀ�����
			 for(var i = 1; i<= dsT_DI_DILIGENCE.countrow; i++ ) {
				 
				 AF_GUN_CD = dsT_DI_DILIGENCE.NameValue(i,"AF_GUN_CD");
				 
				 if(AF_GUN_CD == "H"){
					 
					ADD_YRP_CNT += 1;
					
				 }else if(AF_GUN_CD == "P"){
					 
					ADD_YRP_CNT += 0.5;
					
				 }else if(AF_GUN_CD == "R"){
					 
					ADD_YRP_CNT += 0.5;
				 }
				 
				 BF_GUN_CD = dsT_DI_DILIGENCE.NameValue(i,"BF_GUN_CD");
				 
				 if(BF_GUN_CD == "H"){
					 
					ADD_YRP_CNT -= 1;
					
				 }else if(BF_GUN_CD == "P"){
					 
					ADD_YRP_CNT -= 0.5;
					
				 }else if(BF_GUN_CD == "R"){
					 
					ADD_YRP_CNT -= 0.5;
					
				 }
			 }

			if(NEW_GUN_CD == "H"){
				
				if(NET_YRP_CNT - YRP_USE - ADD_YRP_CNT < 0){
					
					alert("�������� ����մϴ�");
					
				}
			}else if(NEW_GUN_CD == "P" || NEW_GUN_CD == "R"){
				
				if(NET_YRP_CNT - YRP_USE - ADD_YRP_CNT < 0){
					
					alert("�������� ����մϴ�");
					
				}
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
    | 1. ��¥�� ���������� �����ڵ� �������°� DataSet			   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE_BEFORE)			 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE_BEFORE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_BEFORE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 2. �̸� : dsT_DI_YEARLY                     |
    | 3. Table List : T_DI_YEARLY                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
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

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_YEARLY)		       |
    | 3. ���Ǵ� Table List(T_DI_YEARLY)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_YEARLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr06(O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_DILIGENCE_BEFORE)		       |
    | 3. ���Ǵ� Table List(trT_DI_DILIGENCE_BEFORE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE_BEFORE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr02(O:dsT_DI_DILIGENCE_BEFORE=dsT_DI_DILIGENCE_BEFORE)">
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
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "CHN_YMD")   = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "BF_YMD");

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
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE_TEMP Event="OnLoadCompleted(iCount)">
        alert("����� �Ϸ�Ǿ����ϴ�");
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
	if("READ".equals(MODE)){
%>
		document.getElementById("txtREQ_NO_SHR").value  = "<%=param_req_no%>";
<%
	}else{
%>
		document.getElementById("txtREQ_NO_SHR").value  = dsT_DI_DILIGENCE_TEMP.NameValue(1, "REQ_NO");
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
	<script language=JavaScript for=grdT_DI_DILIGENCE event=OnClick(Row,Colid)>
		if(Colid == "CHN_YMD"){
			document.getElementById("resultMessage").innerText = '** ������ �Է� ���� : YYYYMMDD ���ڸ� �Է¹ٶ��ϴ� **';
			return false;
		}

	</script>

	<!-----------------------------------------------------+
    | Grid ���� ��¥ ���������� �����ڵ� ��������						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_DI_DILIGENCE event=OnExit(row,colid,olddata)>
		if(colid == "BF_YMD"){

			var BF_YMD = dsT_DI_DILIGENCE.NameValue(row, "BF_YMD");
			
			var ENO_NO = dsT_DI_DILIGENCE.NameValue(row, "ENO_NO");
			
			if(!cfDateExpr(BF_YMD)){
				
				alert(BF_YMD + " �� �������� ��¥ Ÿ���� �ƴմϴ�.\ �ٽ� �Է��Ͻʽÿ�");
				
				dsT_DI_DILIGENCE.NameValue(row, "BF_YMD") = "";
				
				return false;
				
			}

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
				
				trT_DI_DILIGENCE_CD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna013.cmd.GUNA013CMD"
																   + "&S_MODE=SHR_CD"
																   + "&PIS_YYMMDD="+BF_YMD
																   + "&ENO_NO="+ENO_NO;
				
				trT_DI_DILIGENCE_CD.post();
			}
			
		// �����ڵ� üũ
		}
		if(colid == "CHN_YMD"){
			
			var CHN_YMD = dsT_DI_DILIGENCE.NameValue(row, "CHN_YMD");
			
			var ENO_NO = dsT_DI_DILIGENCE.NameValue(row, "ENO_NO");

			if(!cfDateExpr(CHN_YMD)){
				
				alert(CHN_YMD + " �� �������� ��¥ Ÿ���� �ƴմϴ�.\ �ٽ� �Է��Ͻʽÿ� YYYYMMDD");
				
				dsT_DI_DILIGENCE.NameValue(row, "CHN_YMD") = "";
				
				return false;
				
			}

			if(fnc_ChkDate(CHN_YMD)){
				
				for(var i=1; i<dsT_DI_DILIGENCE.countrow; i++){
					
					if(dsT_DI_DILIGENCE.NameValue(i, "CHN_YMD") == CHN_YMD){
						
						alert("������¥�� �����Ҽ� �����ϴ�. \n\n �ټ��� ���¸� ����� 1���� ó��(��������/���±��� �Է�)�ٶ��ϴ�.");
						
						dsT_DI_DILIGENCE.NameValue(row, "CHN_YMD") = "";
						
						return false;
					}
					
				}

			}

		}
	</script>
	
<script language=JavaScript for=grdT_DI_DILIGENCE event=OnCloseUp(row,colid)>

		if(colid == "AF_GUN_CD"){
			
			var BF_GUN_CD = dsT_DI_DILIGENCE.NameValue(row, "BF_GUN_CD");
			
			var AF_GUN_CD = dsT_DI_DILIGENCE.NameValue(row, "AF_GUN_CD");
			
			
			//2020.08.06 ���� ������ �����θ� ��������
			if(BF_GUN_CD == "M" && AF_GUN_CD != "M"){
				
				alert("���� ������ �����θ� ����Ҽ� �ֽ��ϴ�");
				
				dsT_DI_DILIGENCE.NameValue(row, "AF_GUN_CD") = "";
				
				return;
			}			 
			 
			
			
			if(BF_GUN_CD == "T" && !(AF_GUN_CD == "T" || AF_GUN_CD == "U")){
				
				alert("��ü�ް��� ��ü�ް��θ� ����Ҽ� �ֽ��ϴ�");
				
				dsT_DI_DILIGENCE.NameValue(row, "AF_GUN_CD") = "";
				
				return;
			}
			
			if(BF_GUN_CD == "U" && AF_GUN_CD != "U"){
				
				alert("��ü������ ��ü�����θ� ����Ҽ� �ֽ��ϴ�");
				
				dsT_DI_DILIGENCE.NameValue(row, "AF_GUN_CD") = "";
				
				return;
				
			}
			
			/*2019.11.11 ������ ���̿� �̵��� ���� */
			if(BF_GUN_CD == "H" && (AF_GUN_CD == "P" || AF_GUN_CD == "R")){
				
				alert("������ ������ �����Ͻ� ��� �ܿ� �������� �þ�ϴ�.\n\n���� ������ ��� �����Ͻñ� �ٶ��ϴ�.");

			}			
			
			fnc_YrpCheck();
			
		}

</script>

<script language=JavaScript for=grdT_DI_DILIGENCE_BEFORE event=OnDblClick(row,colid)>

	for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
		
		if(dsT_DI_DILIGENCE_BEFORE.NameValue(row,"PIS_YMD") == dsT_DI_DILIGENCE.NameValue(i,"BF_YMD")){
			
			alert("������¥�� �����Ҽ� �����ϴ�");
			
			return;
			
		}
		
		if(dsT_DI_DILIGENCE.NameValue(i,"CHN_YMD") == ""){
			
			alert(" �ټ��� ���¸� ����� 1���� ó��(��������/���±��� �Է�)�ٶ��ϴ�");
			
			return;
			
		}
	}

	dsT_DI_DILIGENCE.AddRow();
	
    dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"BF_YMD")	 =  dsT_DI_DILIGENCE_BEFORE.NameValue(row,"PIS_YMD");
    
    dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"BF_GUN_CD") =  dsT_DI_DILIGENCE_BEFORE.NameValue(row,"GUN_CD");
    
    dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"BF_REMARK") =  dsT_DI_DILIGENCE_BEFORE.NameValue(row,"REMARK");

    
		    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001" ){ 


				if(dsT_DI_DILIGENCE.CountRow > 1){
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;		
					
				}else{
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;				
					
				}
				
				fnc_ChangeStateElement(false, "ImgEnoNo");
				fnc_ChangeStateElement(false, "txtENO_NO");
				fnc_ChangeStateElement(false, "txtENO_NM");


    		}else{


				if(dsT_DI_DILIGENCE.CountRow > 1){
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NM");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_CD");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_NM");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "JOB_NM");
					
				}else{
					
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;		
					
				}
		
				fnc_DisableElementAll(elementList);
				fnc_ChangeStateElement(true, "ImgEnoNo");
				fnc_ChangeStateElement(true, "txtENO_NO");
				fnc_ChangeStateElement(true, "txtENO_NM");
		
				fnc_ChangeStateElement(true, "txtREMARK");


    		}

		    
			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "FLAG") = "INS";

			grdT_DI_DILIGENCE.AllShowEdit = "true";
			
			document.getElementById("resultMessage").innerText ="�Ʒ� Sheet �����ʿ��� ���� �� ����(������/���±���) ����=>���缱����=>���.**";




  </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>


	<select id="cmbGUN_CD" style="width='100';display:none" >
		<option value="">&nbsp;</option>
	</select>

	<!-- form ���� -->
	<form name="form1">
    <input type="hidden" id="hidEMPL_DPT_CD">
	<input type="hidden" id="txtREQ_NO_SHR">
	<input type="hidden" id="txtMODE">
	<input type="hidden" id="txtPIS_YYMMDD" name="txtPIS_YYMMDD" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">

	<!-- ����-->
	<input type="hidden" id="txtAYRP_CNT">
	<input type="hidden" id="txtYRP_CNT">




	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
			<span id="append_btn" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ReportOver.gif',1)">  <img src="../../images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			</span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="120"></col>
					<col width="200"></col>
					<col width="120"></col>
					<col width="200"></col>
					<col width="120"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="blueBold" align="center">�����߻��ϼ�</td>
                    <td class="padding2423">
                       <input id="txtNET_YRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>��
                    </td>

					<td align="center" class="blueBold">��������ϼ�</td>
					<td class="padding2423">
					 <input id="txtYRP_USE" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>��
					</td>
					<td align="center" class="blueBold">�̻���ϼ�</td>
					<td class="padding2423">
					 <input id="txtNOT_YRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>��
					</td>
				</tr>
				<tr>
					<td class="blueBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13)fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>

					<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="blueBold"></td>
					<td class="padding2423"></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	<!-- ���� �Է� ���̺� �� -->

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr><td>&nbsp;</td></tr>
	</table>


	<!-- ���缱 ���̺� ���� -->
	<!-- ���� ��ȸ �׸��� ���̺� ����-->

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td width=370>
							<comment id="__NSID__">
							<object	id="grdT_DI_DILIGENCE_BEFORE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:200px;">
								<param name="DataID"				value="dsT_DI_DILIGENCE_BEFORE">
								<param name="Editable" value="false">
								<param name="Format"				value="
	            					<C> id='PIS_YMD'	width=200		name='������'			MASK=XXXX-XX-XX 	align=center	edit=none</C>
	            					<C> id='GUN_CD'		width=200	name='���±���'		align=center	Edit=none  EditStyle=Lookup  Data='dsT_CM_COMMON_H4:CODE:CODE_NAME'</C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td>&nbsp;</td>
					<td>
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:200px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
	            					<C> id='SEQ_NO'	width=30	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=150	name='�μ�'		align=center	</C>
									<C> id='JOB_NM'	width=80	name='����'		align=center	</C>
									<C> id='ENO_NM'	width=80	name='����'		align=center	</C>
									<C> id='APP_YN'	width=80	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')} </C>
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

			            </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>


	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>

			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="hrTextGreen"><span id="resultMessage">&nbsp;</span></td>
						<td valign="top" class="searchState" align="right">
						<span id="btn_InsDel">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>

	                        </span>
						</td>
					</tr>
				</table>
			</td>

		</tr>
	</table>

	<!-- ���� ��ȸ �׸��� ���̺� ��-->


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:200px;">
						<param name="DataID" value="dsT_DI_DILIGENCE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name=IgnoreSelectionColor  value="true">
						<param name="Format" value='
							<C> id="{CUROW}"			width=29	name="NO"			align=center	value={String(Currow)}        </C>
							
							<G> name="����������"  HeadBgColor="#dae0ee"
								<C> id="BF_YMD"			width=200		name="������"			align=center	MASK=XXXX-XX-XX  edit={IF(FLAG="INS","true","false")}  </C>
								<C> id="BF_GUN_CD"		width=200	name="���±���"		align=center	Edit=none  EditStyle=Lookup  Data="dsT_CM_COMMON_H4:CODE:CODE_NAME"                  </C>

							</G>
							
							<G> name="�����ı���"  HeadBgColor="#dae0ee"
								<C> id="CHN_YMD"		width=200		name="������" 		align=center	MASK=XXXX-XX-XX Edit=Numeric </C>
								<C> id="AF_GUN_CD"		width=200		name="���±���"	    align=center	EditStyle=Combo Data=" : ,H:����,W:����,F:����,E:�Ʒ�,I:�����ް�,P:��������,R:���Ĺ���,M:����,T:��ü�ް�,Z:�����ް�,A:����ġ���ް�,B:���������ް�,C:�����ް�" AlwaysShowEditStyle=false </C>

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


<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<object id="bndT_DI_DILIGENCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_DILIGENCE">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO			Ctrl=txtENO_NO			Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=BF_YMD			Ctrl=txtPIS_YYMMDD  	Param=value</C>
		">
	</object>


		<!-- T_DI_YEARLY ���� ���̺� -->
	<object id="bndT_DI_YEARLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_YEARLY">
		<Param Name="BindInfo", Value="
			<C>Col=YRP_CNT			Ctrl=txtYRP_CNT				Param=value</C>
			<C>Col=AYRP_CNT			Ctrl=txtAYRP_CNT				Param=value</C>
			<C>Col=NET_YRP_CNT	Ctrl=txtNET_YRP_CNT		Param=value</C>
			<C>Col=YRP_USE				Ctrl=txtYRP_USE				Param=value</C>
			<C>Col=NOT_YRP_CNT	Ctrl=txtNOT_YRP_CNT		Param=value</C>
		">
	</object>
	
	
	