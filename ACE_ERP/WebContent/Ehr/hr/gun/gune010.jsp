<!--
*****************************************************
* @source       : gune010.jsp
* @description : ����ٹ�������û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/10/18     MOON              �����ۼ�
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>

<html>
<head>
<title>����ٹ�������û</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<jsp:include page="/Security/common/include/head.jsp"/>
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
	

	
	var today = gcurdate;
	
	var GBN = "";
	
	// ��������
	
	
	
    /***********************************
     * 01. ��ȸ �Լ�_List ������ ��ȸ                *
     ***********************************/
    function fnc_SearchList() {

    	
    }
	

    /***********************************
     * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
     ***********************************/
    function fnc_SearchItem() {
    	

    }


    
    /******************
     * 03. ���� �Լ�         *
     ******************/
    function fnc_Save() {
    	

    }

    
    
    
    /******************
     * 04. ���� �Լ�         *
     ******************/
    function fnc_Delete() {
    	

    }

    
    
    /******************
     * 05. �μ� �Լ�        *
     ******************/
    function fnc_Print() {
    	
    	
    }

    
    
    
    /***********************
     * 06. ���� ���� �Լ�            *
     ***********************/
    function fnc_ToExcel() {
    	
    	
    }

    
    
    /******************
     * 07. �ű� �Լ�         *
     ******************/
    function fnc_AddNew() {
    	
    	
    }

    
    
    /******************
     * 08. ��ȿ�� �˻�      *
     ******************/
    function fnc_Valid() {
    	
    	
    }

    
    /******************
     * 08. �߰� �Լ�         *
     ******************/
	function fnc_Append() {
    	

    	var TOT_TIME = dsMonAccHour.NameValue(1,"ALL_TOT_TIME"); // �� �� ���� �ð�(����+����)
    	var REQ_TIME = document.getElementById("txtREQ_TIME").value; // ��û�� �ð�
    	
    	
    	
    	var catg = document.getElementById("cmbAPP_TYPE").value;
    	
    	
    	
    	var TOT_WEEK_TIME = "0";
    	var TOT_HOL_TIME = "0";
    	var CHK_WK_MON = "";
    	var CHK_WK_FRI = "";
    	var CHK_WK_FLAG = "N";
    	var APP_N_CHK = "N"; // �ΰῩ�� Ȯ��
        
    	
    	
    	
    	// �ִ��û�Ⱓ üũ
		var STR_YMD = document.getElementById("txtSTR_YMD").value;
		var END_YMD = document.getElementById("txtEND_YMD").value;
		var ovr_ymd = addDate("D", STR_YMD, 30);
		
		
		
		// �Է½ð�üũ
		var STR_TIME = "";
		var END_TIME = "";
		
		
		
		// �Է� ���ɽð� üũ
		cfXmlHttpStatus("HH24MI"); // �ð���ȸ
		
		
		
		//alert(GLS_SYSTEM_DATE);
		
		
		// GLS_SYSTEM_DATE�� js���Ͽ� ���ǵǾ� ����
		/*
		if(GLS_SYSTEM_DATE.length != 4) {
			
			alert("�ð������� ���ܰ� �߻��Ͽ����ϴ�.\n\n�ý��۴���ڿ��� ���� �ٶ��ϴ�.");
			
			return;
			
		}
		*/
		
		
		
		if( today.replaceAll("-","") > STR_YMD.replaceAll("-","") ) {
			
			alert("����ٹ� ��û�� �� ������ ���� ���ڿ� ���� ��û������ �����մϴ�.\n\n���� ���ڿ� ���ؼ��� ����� �Ͻ� �� �����ϴ�.");
			
			return;
			
		}
		
		
		
		
		
		if(catg == "AM") {
			
				/* 2021.02.03 üũ �κ��� �� �� Ȯ���ؾ� �� 
				if( (today.replaceAll("-","") == STR_YMD.replaceAll("-","")) &&  (((Number(GLS_SYSTEM_DATE)-16)+"") > "0600") )  {
					
					alert("����ٹ� ��û�� �� ���� ������ ���� ��û������ �����մϴ�.\n\n�Է½ð��� ���� �ð����� ����Ͻ� �� �����ϴ�.\n\n��� ����ð� �� �Է°��ɽð��� ���� ������ Ȯ���� �ֽñ� �ٶ��ϴ�.");
					
					return;
					
				}
				*/
			
		} else if(catg == "PM") {
			
				/* 2021.02.03 üũ �κ��� �� �� Ȯ���ؾ� �� 
				if( (today.replaceAll("-","") == STR_YMD.replaceAll("-","")) &&  (((Number(GLS_SYSTEM_DATE)-16)+"") > "1800") )  {
					
					alert("����ٹ� ��û�� �� ���� ���Ŀ� ���� ��û������ �����մϴ�.\n\n�Է½ð��� ���� �ð����� ����Ͻ� �� �����ϴ�.\n\n��� ����ð� �� �Է°��ɽð��� ���� ������ Ȯ���� �ֽñ� �ٶ��ϴ�.");
					
					return;
					
				}
				*/
			
		} else {
			
			
			
			
		}
		
		
		
		
		
		if(ovr_ymd < END_YMD) {
			
			alert("����ٹ� ��� ���� ���ڴ� ���� ���� �ִ� 30�� �Դϴ�.");
			
			return;
			
		}
		
    	
		
		if(REQ_TIME == "0" || REQ_TIME == "") {
			
			alert("��û �ð������� �ùٸ��� �ʽ��ϴ�.");
			
			return;
			
		}
		
		
		
		if(document.getElementById("txtREMARK").value.trim() == ""){
			
			alert("�ٹ������� �Է��� �ּ���");
			
			document.getElementById("txtREMARK").focus();
			
			return;
			
			
		}
		
		
		
		STR_TIME = document.getElementById("cmbSTR_OVR_HOUR").value+document.getElementById("cmbSTR_OVR_MIN").value;
		END_TIME = document.getElementById("cmbEND_OVR_HOUR").value+document.getElementById("cmbEND_OVR_MIN").value;

		
		
		
		if(catg == "AM") {
			
			
			if(  !((STR_TIME >= "0600" && STR_TIME <= "0900") && (END_TIME >= "0600" && END_TIME <= "0900")) ) {
				
				alert("���� : ���� 06:00 ~ ���� 09:00 ���̿��� ��ϰ����մϴ�.");
				
				return;
				
			}
			
		} else if(catg == "PM") {
			
			
			STR_TIME = (    (Number(STR_TIME.substring(0, 2)) >= 0 && Number(STR_TIME.substring(0, 2)) <= 6)    ?    ((Number(STR_TIME.substring(0, 2))+24)+""+STR_TIME.substring(2, 4)) : STR_TIME ); 
			END_TIME = (    (Number(END_TIME.substring(0, 2)) >= 0 && Number(END_TIME.substring(0, 2)) <= 6)    ?    ((Number(END_TIME.substring(0, 2))+24)+""+END_TIME.substring(2, 4)) : END_TIME );

			if( !((STR_TIME >= "1800" && STR_TIME <= "3000") && (END_TIME >= "1800" && END_TIME <= "3000"))  && STR_TIME != "" && END_TIME != "") {
				
				alert("���� : ���� 18:00 ~ ���� 06:00 ���̿��� ��ϰ����մϴ�.");
				
				return;
				
			}
			
		} else {
			
			
			
		}

		
		
		// ��û���п� ���� ����ٹ��Ͽ� ���� ��ϰ������� ��ȸ
		fnc_getOTPossibleDt(); 
		
		
		
    	dsT_DI_OVERTIMEWORK.ClearData();
		
    	
    	
    	// �ش� Dataset�� Header�� ������ Header ����
        if (dsT_DI_OVERTIMEWORK.CountColumn == 0) {
        	
        	dsT_DI_OVERTIMEWORK.setDataHeader("CONF_SEL:STRING,REG_YMD:STRING,STR_REG_YMD:STRING,END_REG_YMD:STRING,WK_MON:STRING,WK_FRI:STRING,AM_REQ_YN:STRING,PM_REQ_YN:STRING,WEEK_TOT_TIME:STRING,REQ_NO:STRING,ACC_TIME:STRING,END_TAG:STRING,STR_OVR_TIME:STRING,END_OVR_TIME:STRING,OVR_TIME:STRING,REMARK:STRING,APP_REMARK:STRING,PENO_NO:STRING,GUBN:STRING,HOL_TOT_TIME:STRING,ALL_TOT_TIME:STRING,WEEK_OF_YEAR:STRING,JOB_CD:STRING");
        
        }
		
		
    	
    	
    	
    	
		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
			
			
	        // ���� check! 
	        if(catg == "AM" && dsOTPossibleDt.NameString(i, "HOL_YN") == "Y") {
	        	
	        	alert("�ش����� ���Ϸ� ��������ٹ� ��û�� �Ұ��մϴ�. �ٹ����� �ٽ� ������ �ֽñ� �ٶ��ϴ�. ");
	        	
				continue;
				
	        } else if(catg == "PM" && dsOTPossibleDt.NameString(i, "HOL_YN") == "Y") {
	        	
	        	alert("�ش����� ���Ϸ� ���Ŀ���ٹ� ��û�� �Ұ��մϴ�. �ٹ����� �ٽ� ������ �ֽñ� �ٶ��ϴ�. ");
	        	
				continue;
				
	        } else if(catg == "WK" && dsOTPossibleDt.NameString(i, "HOL_YN") == "N") {
	        	
	        	alert("���ϱٹ���û�� ���� ���Ͽ��� �����մϴ�.");
	        	
				continue;
				
	        }
	        
	        
	        
	        
			// ���ϱٹ� ��û �Ǵ� ������� ������ ���� ó�� -- �츮�� ����. 
			//if(dsOTPossibleDt.NameString(i, "REG_YN") == "N" || dsOTPossibleDt.NameString(i, catg+"_REQ_YN") == "Y") continue;
	
			
			
			
			// �����ð� ��� = �� �ٹ��ð� + ��û�ð�
			TOT_TIME = Number(TOT_TIME) + Number(REQ_TIME);
			
			
			
			
			//�޾ƿ��� �� ����. 
			/*if(CHK_WK_MON != dsOTPossibleDt.NameString(i, "WK_MON") && CHK_WK_FRI != dsOTPossibleDt.NameString(i, "WK_FRI"))
			{
				TOT_WEEK_TIME = "0";
				CHK_WK_FLAG = "N";
				CHK_WK_MON = dsOTPossibleDt.NameString(i, "WK_MON");
		    	CHK_WK_FRI = dsOTPossibleDt.NameString(i, "WK_FRI");
			}*/
			
			
			
			
			// �ֺ� ���� �ð� ��� = 0 + ��û�ð�
			if (catg == "AM" || catg == "PM") {
				
					TOT_WEEK_TIME = Number(TOT_WEEK_TIME) + Number(REQ_TIME);
					
					//������ ����� ��52�ð� �ƴ� ��48.5�ð�
				    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {
					
						if( Number(TOT_TIME) > 8.5 ) {
							alert("�ֺ� ���� �ٹ��ð� : " + dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n�ʰ� �ð� : " + (Number(TOT_TIME) - 8.5 ) + 
						    			"H\n��û�ٹ��� : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n�ֺ� �ִ� ��ϰ����� 8.5�ð��� �ʰ��Ͽ����ϴ�.\n");
							continue;
						}
				    	
				    }else{
				    	

						if( Number(TOT_TIME) > 12 ) {
							alert("�ֺ� ���� �ٹ��ð� : " + dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n�ʰ� �ð� : " + (Number(TOT_TIME) - 12 ) + 
						    			"H\n��û�ٹ��� : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n�ֺ� �ִ� ��ϰ����� 12�ð��� �ʰ��Ͽ����ϴ�.\n");
							continue;
						}
						
				    }
				
			} else {
				
				
					TOT_HOL_TIME = Number(TOT_HOL_TIME) + Number(REQ_TIME);
					
					//������ ����� ��52�ð� �ƴ� ��48.5�ð�
				    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {
					
						if(Number(TOT_TIME) > 8.5 ) {
							alert("�ֺ� ���� �ٹ��ð� : " +  dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n�ʰ� �ð� : " + (Number(TOT_TIME) - 8.5 ) +  
						    			"H\n��û�ٹ��� : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n�ֺ� �ִ� ��ϰ����� 8.5�ð��� �ʰ��Ͽ����ϴ�.\n");
							continue;
						}
				    	
				    }else{

						if(Number(TOT_TIME) > 12 ) {
							alert("�ֺ� ���� �ٹ��ð� : " +  dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n�ʰ� �ð� : " + (Number(TOT_TIME) - 12 ) +  
						    			"H\n��û�ٹ��� : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n�ֺ� �ִ� ��ϰ����� 12�ð��� �ʰ��Ͽ����ϴ�.\n");
							continue;
							
						}
						
					}
				
			}
			

			
			dsT_DI_OVERTIMEWORK.AddRow();
			

			
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "CONF_SEL") 	= "F";
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REG_YMD") 		= dsOTPossibleDt.NameString(i, "REG_YMD"); // �ٹ���
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "STR_REG_YMD") 	= dsOTPossibleDt.NameString(i, "REG_YMD"); // �ٹ�������
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_REG_YMD") 	= dsOTPossibleDt.NameString(i, "REG_YMD"); // �ٹ�������
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "GUBN") 		= catg; //���а�
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_OF_YEAR") = dsWeekOfYear.NameString(i, "WEEK_NO"); //��������
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "JOB_CD") 		= dsT_DI_APPROVAL.NameString(i, "JOB_CD"); //�����ڵ�
			
			
			
			
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WK_MON") = dsOTPossibleDt.NameString(i, "WK_MON"); // �� ������
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WK_FRI") = dsOTPossibleDt.NameString(i, "WK_FRI"); // �� �ݿ���
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "AM_REQ_YN") = dsOTPossibleDt.NameString(i, "AM_REQ_YN"); // ������û����
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "PM_REQ_YN") = dsOTPossibleDt.NameString(i, "PM_REQ_YN"); // ���Ľ�û����
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REQ_NO") = dsOTPossibleDt.NameString(i, catg+"_REQ_NO"); // ��û��ȣ
			
			
			
			
			if(dsOTPossibleDt.NameString(i, catg+"_END_TAG") == "N") {
				
				if(confirm("��û���� �� �ΰ������� ���ԵǾ� �ֽ��ϴ�.\n�ΰ������� �ҷ� ���ðڽ��ϱ�?\n\nȮ�� - �ΰ������� ��û���� ����\n��� - �ű������� ��û���� ����")) {
					
					APP_N_CHK = "Y";
					
				} else {
					
					APP_N_CHK = "N";
					
				}
				
				
			}
			
			
			// �ΰ��϶� �����ð��� �� ����ŭ �����ش�.�ΰ��� Y
			if(APP_N_CHK == "Y") {
				
				
				TOT_WEEK_TIME = (Number(TOT_WEEK_TIME) - Number(REQ_TIME)) + Number(dsOTPossibleDt.NameString(i, catg+"_OVR_TIME")); // �����ð� ���
				TOT_HOL_TIME = (Number(TOT_HOL_TIME) - Number(REQ_TIME)) + Number(dsOTPossibleDt.NameString(i, catg+"_OVR_TIME")); // �����ð� ���
				
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_TOT_TIME") = (Number(TOT_WEEK_TIME) + Number(dsMonAccHour.NameString(i, "WEEK_TOT_TIME")))+""; // �ֺ������ٹ��ð�
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "HOL_TOT_TIME") = (Number(TOT_HOL_TIME) + Number(dsMonAccHour.NameString(i, "HOL_TOT_TIME")))+""; // �ֺ������ٹ��ð�
				
				
			} else {
				
				
				//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "ACC_TIME") = TOT_TIME; // �����ð�
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_TOT_TIME") = (Number(TOT_WEEK_TIME) + Number(dsMonAccHour.NameString(i, "WEEK_TOT_TIME")))+""; // �ֺ������ٹ��ð�
				//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_TOT_TIME") = (Number(REQ_TIME) + Number(dsOTPossibleDt.NameString(i, "WEEK_TOT_TIME")))+""; // �ֺ������ٹ��ð�
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "HOL_TOT_TIME") = (Number(TOT_HOL_TIME) + Number(dsMonAccHour.NameString(i, "HOL_TOT_TIME")))+""; // �ֺ������ٹ��ð�
			
			
			}
			
			
			
			
			// �ΰ��� ���� ��ϵ� ������ ǥ��
			if(APP_N_CHK == "Y") {
				
				
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "STR_OVR_TIME") = dsOTPossibleDt.NameString(i, catg+"_STR_OVR_HOUR")+dsOTPossibleDt.NameString(i, catg+"_STR_OVR_MIN"); // ����
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_OVR_TIME") = dsOTPossibleDt.NameString(i, catg+"_END_OVR_HOUR")+dsOTPossibleDt.NameString(i, catg+"_END_OVR_MIN"); // ����
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "OVR_TIME") = dsOTPossibleDt.NameString(i, catg+"_OVR_TIME"); // �ð�
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REMARK") = dsOTPossibleDt.NameString(i, catg+"_REMARK"); // �ٹ�����
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_TAG") = dsOTPossibleDt.NameString(i, catg+"_END_TAG")+""; // ��û���籸��
			
				
			} else {
				
				
				var temp_str = document.getElementById("cmbSTR_OVR_HOUR").value;
				var temp_end = document.getElementById("cmbEND_OVR_HOUR").value;
				
				
				if(catg == "PM") {
					
					if(Number(temp_str) >= 24) {
						
						temp_str = "0"+(Number(temp_str) - 24);
						
					}
					
					if(Number(temp_end) >= 24) {
						
						temp_end = "0"+(Number(temp_end) - 24);
						
					}
					
				}
				
				
				
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "STR_OVR_TIME") = temp_str+document.getElementById("cmbSTR_OVR_MIN").value; // ����
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_OVR_TIME") = temp_end+document.getElementById("cmbEND_OVR_MIN").value; // ����
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "OVR_TIME") = REQ_TIME; // �ð�
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REMARK") = document.getElementById("txtREMARK").value; // �ٹ�����
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_TAG") = dsOTPossibleDt.NameString(i, catg+"_END_TAG")+""; // ��û���籸��
			
			
			
			}

			
			
			
			
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "ALL_TOT_TIME") = Number(TOT_TIME); // �����ð�
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "APP_REMARK") = dsOTPossibleDt.NameString(i, catg+"_APP_REMARK"); // ������
			
			
			
			APP_N_CHK = "N"; // �ΰ� ���� �ʱ�ȭ
			
			
			
		}
		
		
	}
    
    
    
    
    
    /**************************
     * 09. ���� �Լ� - �Ϸ�   *
     **************************/
    function fnc_Remove() {
    	

       	var targetGrd = form1.grdT_DI_OVERTIMEWORK;

       	targetGrd.ReDraw = "false";	// �׸��� ��ü draw �� false �� ����

       	
       	for(var i=dsT_DI_OVERTIMEWORK.CountRow; i>=1; i--) {
       		
       		
   			if(dsT_DI_OVERTIMEWORK.NameString(i, "CONF_SEL") == "T") {
   				
   				
   				
   				dsT_DI_OVERTIMEWORK.DeleteRow( i );
   				
   				
   				
   				// �ֺ� 12�ð� üũ
   				var STR_TIME = dsT_DI_OVERTIMEWORK.NameString(i, "STR_OVR_TIME");
   				
				var END_TIME = dsT_DI_OVERTIMEWORK.NameString(i, "END_OVR_TIME");
				
				var CALC_TIME = ((fnc_covNumber(END_TIME.substring(0, 2)) * 60) + fnc_covNumber(END_TIME.substring(2, 4))) - 
				((fnc_covNumber(STR_TIME.substring(0, 2)) * 60) + fnc_covNumber(STR_TIME.substring(2, 4)));

				
				
				fnc_CalcAccReTime(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON"),dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI"),i,(CALC_TIME/60));
				
				
				
   			}
   			
   			
   		}
       	
       	
       	
       	//fnc_CalcReTime(); // �� 52�ð� üũ
       	
       	
       	
       	targetGrd.ReDraw = "true";
       	
       	
       	
    }
    
    
    
    
    
    

    /********************
     * 10. �ʱ�ȭ �Լ�   *
     ********************/
    function fnc_Clear() {
    	

    	
    }

    
    
    
    /************************
     * 11. ȭ�� ����(�ݱ�)   *
     ***********************/
    function fnc_Exit() {

		
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
    	
    }

    
    
    
    /********************************************
     * 14. Form Load �� Default �۾� ó�� �κ�    *
     *******************************************/
    function fnc_OnLoadProcess() {
    	
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
    	
    	
    	cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,0,"true","false"); // ����ٹ� Grid Style ����(�׸���, ���º����÷� width, ���üũ�ڽ�, �������)
    	
    
    	
        document.getElementById("txtENO_NO_SHR").value = gusrid;  
        document.getElementById("txtENO_NM_SHR").value = gusrnm;
        document.getElementById("txtDPT_NM").value = gdeptnm;
        document.getElementById("txtDPT_CD").value = gdeptcd;
        
        
        
    	// 1. �ڵ����缱 ���� ����
    	fnc_AutoApproval();
    	
    	
    	
    	// 2. �ش��� �Ⱓ/���� ���� ���� 
    	fnc_WeekOfYear();
    	
    	
    	
    	// 3. ��� ����ٹ� �����ð� ���
    	fnc_MonAccHour();
    	
    	
    	
    	// 4. �� / �п� ���� ����(�����ͼ� ����)
    	fnc_SetTime();
		
    	
    	
    	// 5. ����ٹ��� �������ڷ� �ʱ�ȭ ����
    	document.getElementById("txtSTR_YMD").value = today;
    	document.getElementById("txtEND_YMD").value = today;
    	
    	
    	
    }

    
    
	/********************
     * 15. ����Ű ó��   *
     *******************/
	function fnc_HotKey() {
		
		fnc_HotKey_Process(btnList, event.keyCode);
		
	}

	
	
	
    /**
     * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
     */
    function fnc_ClickEmpPopup() {

    	
		//�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
	    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {

			document.getElementById("hidEMPL_DPT_CD").value  = "";

		}

		
        fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", '','');

        
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

        
	    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
	    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {
	    	
			document.getElementById("hidEMPL_DPT_CD").value  = "";

		}

        
		fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');

		
        fnc_SearchEmpNo();
        
        
    }
    
    
    
    

    /**
     * ��������� ��ȸ �Ѵ�.
     * ������� �˻�
     */
    function fnc_SearchEmpNo() {
    	
        var obj = new String;

		//�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
	    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {
		
			document.getElementById("hidEMPL_DPT_CD").value  = "";

		}
		
        // ������ ��ü
        obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');
        
        //obj = fnc_GetCommonEnoObj_DH("txtENO_NO");
        

        if(obj != null && obj.eno_no != "") {
        	
            document.getElementById("txtENO_NO").value      = obj.eno_no;
            document.getElementById("txtENO_NM").value      = obj.eno_nm;
            document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
            document.getElementById("txtJOB_NM").value      = obj.job_nm;
            document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;
            

        } else {
        	
            document.getElementById("txtENO_NO").value      = "";
            document.getElementById("txtENO_NM").value      = "";
            document.getElementById("txtDPT_NM").value      = "";
            document.getElementById("txtJOB_NM").value      = "";
            
        }
        
        fnc_AutoApproval();

    }	
    
    
    
    
	
	/**************************
     *  16. �׿� �Լ� ó��    *
     *************************/
     
	/**
     * ����ٹ� ��û�� �Ⱓ üũ - �Ϸ�
     */
	function fnc_CheckDate() {
		
		var STR_YMD = document.getElementById("txtSTR_YMD").value.replaceAll("-","");
		var END_YMD = document.getElementById("txtEND_YMD").value.replaceAll("-","");
		
		
		if(STR_YMD > END_YMD) {
			
			alert("����ٹ����� ������ ������ �߸��Ǿ����ϴ�.");
			
			return false;
			
		}
		
		
		return true;
		
	}
	
	
	
	
	
	
	/**
     * �����ð����� - �Ϸ�
     */
     function fnc_CalcReTime() {
		
        //var TOT_TIME = document.getElementById("txtTOT_TIME").value; // ��� ���� �ð�
        var TOT_TIME = dsMonAccHour.NameValue(1,"ALL_TOT_TIME"); // �� ���� �ð�
        	
        
        for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
        	// �����ð� ���
 			TOT_TIME = Number(TOT_TIME) + Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
        	
 			if(Number(TOT_TIME) > 52) {
				alert("�� �ִ� ��� ������ 52�ð��� �ʰ��Ͽ����ϴ�.(���ϱٹ�����)\n�߰� �Ǵ� ������ �Ͻ� �� �����ϴ�.");
				return false;
			}
 			
        	dsT_DI_OVERTIMEWORK.NameString(i, "ALL_TOT_TIME") = TOT_TIME; // �����ð� ���� ó��
        	
        	
       	}
        
        
        return true;
        
	}
	
	
	
	
	
     /**
      * �����ð����� - �Ϸ�
      */
	function fnc_CalcAccReTime(mon, fri, row, calc) {
    	 
    	 
		var tempVal = 0; // ����ð�
		var tempVal2 = 0; // �ֺ� ���� ���� �ð�
		
		
		// �ֺ� �����ð� ��������
		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
			
			if(tempVal2 == 0 && mon == dsOTPossibleDt.NameString(i, "WK_MON") && fri == dsOTPossibleDt.NameString(i, "WK_FRI")) {
				
				tempVal2 = Number(dsOTPossibleDt.NameString(i, "WEEK_TOT_TIME"));
				
			}
			
			
		}
		
		
		
		// �հ�ð� ����
		for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
			
			
			if(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON") == mon && dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI") == fri) {
				
				
				if(i == row) {
					
					
					tempVal += calc;
					
					
				} else {
					
					
					tempVal += Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
					
					
				}
				
				
			}
			
		}
		
		
		
		
	    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {

			// �ֺ� 12�ð� üũ
			if( (tempVal2+tempVal) > 8.5) return false;	    	
	    	
	    }else{
	    	
			// �ֺ� 12�ð� üũ
			if( (tempVal2+tempVal) > 12) return false;
			
	    }
		
		// �ֺ� 12�ð� üũ
		//if( (tempVal2+tempVal) > 12) return false;
		
		
		
		var tempVal3 = 0; // ���� ����� �����ð�
		
		
		
		
		// ����� �ð��� ����
		for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
			
			
			
			if(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON") == mon && dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI") == fri) {
				
				
				if(i == row) {
					
					tempVal3 += calc;
					
				} else {
					
					tempVal3 += Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
					
				}
				
				dsT_DI_OVERTIMEWORK.NameString(i, "WEEK_TOT_TIME") = (tempVal3+tempVal2)+"";
				
			}
			
		}
		
		return true;
		
	}
	
     
     
     
     
	/**
	* �ٹ��ð��� ���� ������ üũ�Ѵ�. - �Ϸ�
	*/
	function fnc_OVR_Time(catg) {
		
		var OVR_time =  "";
		
		
		OVR_time = ((fnc_covNumber(document.getElementById("cmbEND_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbEND_OVR_MIN").value)) - 
		((fnc_covNumber(document.getElementById("cmbSTR_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbSTR_OVR_MIN").value));
		
		
		
		if(parseInt(OVR_time) < 0){
			
			alert("����ð��� ���۽ð����� �۽��ϴ�.\n�ٽ� ������ �ּ���");
			
			return;
			
		}
		
		
		document.getElementById("txtREQ_TIME").value = (OVR_time/60);
		
		
	}
	
	
	
	
	
	
	/**
	* ���ó��
	*/
	function fnc_Conduct() {
		
		
		if(dsT_DI_OVERTIMEWORK.CountRow < 1) {
			
			alert("��Ű����� ����ٹ���û������ �����ϴ�");
			
			return;
			
		}
		
		
		
		if(!fnc_CheckDate()) return;

		
		
		// �ڵ� ���缱 üũ
		if(dsT_DI_APPROVAL.CountRow < 1) {
			
			alert("�ڵ����缱 ������ �����ϴ�.");
			
			return;
			
		}
		
		
		
		if(!confirm("��û������ ��� �Ͻðڽ��ϱ�?")) return;
		
		
		
		
		dsT_DI_REQNO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_MAX";
		dsT_DI_REQNO.reset();
		
		
		
		var req_no = dsT_DI_REQNO.NameValue(1, "REQ_NO");
		
		
		
		//alert(dsT_DI_OVERTIMEWORK.NameString(1, "ALL_TOT_TIME"));
		
		
		
		GBN = "SAV01";
		
		trT_DI_OVERTIMEWORK.KeyValue = "SAV01(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
		
		trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD"
												+ "&S_MODE=UPT_APP" // ���
												+ "&APP_TYPE=" + document.getElementById("cmbAPP_TYPE").value // ���� / ���� ����
												+ "&APP_YN="  +"N" // ������� : ���
												+ "&GUN_YMD=" +today.replaceAll("-","") // ���ó�¥
												+ "&GUN_GBN=" +"O" // ������� : ����ٹ�������û�� ��Ī�� O�� �Ҵ�
												+ "&REQ_NO=" +req_no //
												;
		
		//prompt(this, trT_DI_OVERTIMEWORK.action);
		
		trT_DI_OVERTIMEWORK.post();
		
		
		
		
		// Oracle ������ �ڿ� Ms-Sql ������ �������ֱ�
		//var param = "proType=A";   	
		
		var param = "proType=A,ENO_NO=" + document.getElementById('txtENO_NO_SHR').value;		  //���	
		
		for(var i=0; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){    
			
			dsT_DI_OVERTIMEWORK.UserStatus(i) = 1;		
			
		}		
		
		
		ln_TRSetting(tr1, "../../../servlet/security.menu.li.MSSQL020",  "JSP(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK)",  param);
		
		//prompt(this, dsT_DI_OVERTIMEWORK.text);
			
		tr_post(tr1);	
						

		
		/* SMS �� ���߿� ���� */
		
		//if(confirm("�޼����� �����Ͻðڽ��ϱ�?")){			
			
			//var date;
			//var phone;
			
			//if (ds_default01.CountColumn == 0) {
			//	ds_default01.setDataHeader("MESSAGE:STRING, EM_PHN_NO:STRING");
			//}
			
			// �� �߰�
			//ds_default01.AddRow();	

			//date = gcem_staxdate.text;
			//date = date.substring(0,4) + "��" + date.substring(4,6) + "��" + date.substring(6,8) + "��";

			//phone = txt_phone_no.value;
			//phone = phone.replace("-","").replace("-", ""); 

		     
			   
				//trT_DI_SMSTRANS.KeyValue = "SAV01(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK)";
				
				//trT_DI_SMSTRANS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD"
				//												+ "&S_MODE=SMS_TRANS" 			// ���
				//												+ "&REQ_NO=" +req_no 			//
				//												;
				
				//prompt(this, trT_DI_SMSTRANS.action);
				
				//trT_DI_SMSTRANS.post();		     

		//}	
		

	}
	
	
	
	
	
	/**
	* �� / �� ������ �� ���� - �Ϸ�
	*/
	function fnc_SetTime() {
		
		
		// ��û���� �ʱ�ȭ
		dsT_DI_OVERTIMEWORK.ClearData();
		
		
		
		var catg = document.getElementById("cmbAPP_TYPE").value;
    	
		
		
    	document.getElementById("cmbSTR_OVR_HOUR").length = 0;
    	document.getElementById("cmbEND_OVR_HOUR").length = 0;
    	document.getElementById("cmbSTR_OVR_MIN").length = 0;
    	document.getElementById("cmbEND_OVR_MIN").length = 0;
		
    	
    	
		dsOT_Hour1.ClearData();
		dsOT_Hour2.ClearData();
		dsOT_Minute.ClearData();
		
		
		
		// �ش� Dataset�� Header�� ������ Header ����
        if (dsOT_Hour1.CountColumn == 0) {
        	dsOT_Hour1.setDataHeader("CODE:STRING,CODE_NAME:STRING");
        }
		
		
		
     	// �ش� Dataset�� Header�� ������ Header ����
        if (dsOT_Hour2.CountColumn == 0) {
        	dsOT_Hour2.setDataHeader("CODE:STRING,CODE_NAME:STRING");
        }
     	
     	
     	
    	// �ش� Dataset�� Header�� ������ Header ����
        if (dsOT_Minute.CountColumn == 0) {
        	dsOT_Minute.setDataHeader("CODE:STRING,CODE_NAME:STRING");
        }
		
    	
    	
		var cmbAMStr = new Array( "06","07","08" );
		var cmbAMEnd = new Array( "06","07","08","09" );
		
		
		
		//var cmbPMStr = new Array( "18","19","20","21","22","23" ); // ���� �ð��� ���� �ð��� �ٸ� ��� Ȱ�� - ����� ���۽ð��� ����ð��� �����ϰ� ������
		var cmbPMStr = new Array( "18","19","20","21","22","23","24","25","26","27","28","29","30" );
		var cmbPMEnd = new Array( "18","19","20","21","22","23","24","25","26","27","28","29","30" );
		
		
		
		var cmbWKStr = new Array( "00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24" );
		var cmbWKEnd = new Array( "00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24" );
		
		
		
		if(catg == "AM") {
			
				for(var i = 0; i < cmbAMStr.length; i++) {
					
					dsOT_Hour1.addrow();
					dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE") = cmbAMStr[i];
					dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = cmbAMStr[i];
					
				}
				
				
				for(var i = 0; i < cmbAMEnd.length; i++) {
					
					dsOT_Hour2.addrow();
					dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE") = cmbAMEnd[i];
					dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE_NAME") = cmbAMEnd[i];
					
				}
			
		} else if(catg == "PM") {
			
			
			for(var i = 0; i < cmbPMStr.length; i++) {
				
				dsOT_Hour1.addrow();
				
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE") = cmbPMStr[i];
				
				//dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = cmbPMStr[i];
				
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = (Number(cmbPMEnd[i]) > 23 ? "0"+(Number(cmbPMEnd[i]) - 24) : cmbPMEnd[i]);
				
				
			}
			
			
			
			for(var i = 0; i < cmbPMEnd.length; i++) {
				
				dsOT_Hour2.addrow();
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE") = cmbPMEnd[i];
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE_NAME") = (Number(cmbPMEnd[i]) > 23 ? "0"+(Number(cmbPMEnd[i]) - 24) : cmbPMEnd[i]);
				
			}
			
		} else  {
			

			for(var i = 0; i < cmbWKStr.length; i++) {
				
				dsOT_Hour1.addrow();
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE") = cmbWKStr[i];
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = cmbWKStr[i];
				
			}
			
			
			
			for(var i = 0; i < cmbWKEnd.length; i++) {
				
				dsOT_Hour2.addrow();
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE") = cmbWKEnd[i];
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE_NAME") = cmbWKEnd[i];
				
			}
			
			
		}
		
		
		
		
		
		dsOT_Minute.addrow();
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE") ="00";
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE_NAME") = "00";
		
		
		
		dsOT_Minute.addrow();
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE") ="30";
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE_NAME") = "30";
		
		
		
		fnc_BindingCommonCode(dsOT_Hour1, "cmbSTR_OVR_HOUR"); // ���� ���� ��
    	fnc_BindingCommonCode(dsOT_Hour2, "cmbEND_OVR_HOUR"); // ���� ���� ��
    	fnc_BindingCommonCode(dsOT_Minute, "cmbSTR_OVR_MIN"); // ���� ���� ��
    	fnc_BindingCommonCode(dsOT_Minute, "cmbEND_OVR_MIN"); // ���� ���� ��
    	
    	
    	
    	if(catg == "PM") {
    		
    		document.getElementById("cmbSTR_OVR_MIN").value = "00";
        	document.getElementById("cmbEND_OVR_MIN").value = "00";
        	
    	}
    	
    	
		
	}
	
	
	
	
	
	/**
	* �ڵ� ���缱 ó�� 
	*/
	function fnc_AutoApproval() {
		
		var ENO_NO = document.getElementById('txtENO_NO_SHR').value;
		var DPT_CD = document.getElementById('txtDPT_CD').value;
		
		dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_APP&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
								
		dsT_DI_APPROVAL.Reset();
		
	}
	
	
	
	
	
	/**
	* �ش��� �Ⱓ/�� ��ȸ 
	*/
	function fnc_WeekOfYear() {
		
		//var Today = document.getElementById('txtENO_NO_SHR').value;
		
		var REG_YMD = today;
		
		dsWeekOfYear.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_WK&REG_YMD="+REG_YMD;
		
		dsWeekOfYear.Reset();
		
	}
	
	
	
	
	
	/**
	* ��� ����ٹ� �����ð� ��ȸ 
	*/
	function fnc_MonAccHour() {
		
		
		
		var ENO_NO = document.getElementById('txtENO_NO_SHR').value;
		
		var WEEK_NO = dsWeekOfYear.NameValue(1,"WEEK_NO");
		
		dsMonAccHour.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_ACC&ENO_NO="+ENO_NO
																													+"&WEEK_NO="+WEEK_NO;
		
		dsMonAccHour.Reset();
		
	}
	
	
	
	
	
	/**
	* ����ٹ��� ���� ��ϰ������ڸ� ��ȸ 
	* ��,��,������ ����
	*/
	function fnc_getOTPossibleDt() {
		
		
		var STR_YMD = document.getElementById("txtSTR_YMD").value;
		
		
		GBN = "SVL01";
		
    	trT_DI_OVERTIMEWORK.KeyValue = "SVL01(O:dsOTPossibleDt=dsOTPossibleDt)";
    	
		trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_OTD&REG_YMD="+STR_YMD;
		
		//prompt(this,trT_DI_OVERTIMEWORK.action);
		
		trT_DI_OVERTIMEWORK.post();
		
	}
	
	
	
	
	
	// �Ϸ� - trim ��������
	String.prototype.trim = function(){
		
		return this.replace(/\s/g, "");
		
	}
	
	
	
	
	
	// �Ϸ� - replaceAll ��� - str.replaceAll("-","")
	String.prototype.replaceAll = function(taget, replacement){
		
		return this.split(taget).join(replacement);
		
	}
	
	
	</script>
	
	
	
	
	
</head>

<!--**************************************************************************************
*                                                                                        *
*  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                      *
*                                                                                        *
***************************************************************************************-->
	<!----------------------------------------------+
    | 1. �ð� �޺� �ڽ� ó����                                                         |
    | 2. �̸� : dsOT_Hour                             |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Hour1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <Object ID="dsT_DI_REQNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    
    <!----------------------------------------------+
    | 1. �ð� �޺� �ڽ� ó����                  |
    | 2. �̸� : dsOT_Hour                       |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsOT_Hour2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. �� �޺� �ڽ� ó����                     |
    | 2. �̸� : dsOT_Minute                     |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsOT_Minute" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                           |
    | 2. �̸� : dsT_DI_OVERTIMEWORK                   |
    | 3. Table List : T_DI_OVERTIMEWORK              |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                          |
    | 2. �̸� : dsT_DI_APPROVAL                       |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                          |
    | 2. �̸� :                                       |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsWeekOfYear" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                          |
    | 2. �̸� :                                       |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsMonAccHour" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                          |
    | 2. �̸� :                                       |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOTPossibleDt" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5"><!-- ���  -->
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>


	<!-----------------------------------------------------------------------------
		  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
	------------------------------------------------------------------------------>
	<object  id="tr1" classid="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>



<!--*************************************
*                                       *
*  Component���� �߻��ϴ� Event ó����  *
*                                       *
**************************************-->
	<!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    	
    	if (iCount > 0) {
    		
    	 // dsT_DI_APPROVAL.NameString(1, "DUTY_NM") = "����";
         // dsT_DI_APPROVAL.NameString(1, "HDPT_NM") = "�濵������";
         // dsT_DI_APPROVAL.NameString(1, "HJOB_NM") = "����";
         // dsT_DI_APPROVAL.NameString(1, "HJOB_CD") = "200";
         // dsT_DI_APPROVAL.NameString(1, "HENO_NM") = "������";
         // dsT_DI_APPROVAL.NameString(1, "HENO_NO") = "6180001";	    
            
    		var tmpTxt = "����� : " + dsT_DI_APPROVAL.NameString(1, "DPT_NM") +" "+
    			   					dsT_DI_APPROVAL.NameString(1, "JOB_NM")+" "+
    			   					dsT_DI_APPROVAL.NameString(1, "ENO_NM")+" / "+
    		                "������("+dsT_DI_APPROVAL.NameString(1, "DUTY_NM")+") : "+
    		                dsT_DI_APPROVAL.NameString(1, "HDPT_NM")+" "+
    		                dsT_DI_APPROVAL.NameString(1, "HJOB_NM")+" "+
    		                dsT_DI_APPROVAL.NameString(1, "HENO_NM");
    		                
    		document.getElementById("resultAppLine").innerText = tmpTxt;
    		
    		
    	} else {
    		
			alert("�ڵ����缱�� ��Ʈ�� ������ �����ϴ�.\n");
			
    		document.getElementById("resultAppLine").innerText = "";
    		
   		}
    	
    	
    	
    </Script>
    
    
    
    
    
    
    <Script For=dsWeekOfYear Event="OnLoadCompleted(iCount)">
    
    
    	if (iCount > 0) {
    		
    		document.getElementById("resultWkSq").innerText = dsWeekOfYear.NameValue(1,"WEEK_NO");
    		document.getElementById("resultWkterm").innerText = dsWeekOfYear.NameValue(1,"REG_YMD");
    		
    	}
    	
    	
    </Script>
    
    
    
    
    
    <Script For=dsMonAccHour Event="OnLoadCompleted(iCount)">
    
    	//2021.03.16 ������ ����� �� 52�ð��� �ƴ� �� 48.5�ð� ����
    	if (iCount > 0) {

    	    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {

        		document.getElementById("resultUse").innerText = dsMonAccHour.NameValue(1,"WEEK_TOT_TIME") + "H(����) + " + dsMonAccHour.NameValue(1,"HOL_TOT_TIME") + "H(����) = " + dsMonAccHour.NameValue(1,"ALL_TOT_TIME") + "H";
        		document.getElementById("resultAllow").innerText = (8.5 - Number(dsMonAccHour.NameValue(1,"ALL_TOT_TIME"))) +"H";

    		}else{    		

    		document.getElementById("resultUse").innerText = dsMonAccHour.NameValue(1,"WEEK_TOT_TIME") + "H(����) + " + dsMonAccHour.NameValue(1,"HOL_TOT_TIME") + "H(����) = " + dsMonAccHour.NameValue(1,"ALL_TOT_TIME") + "H";
    		document.getElementById("resultAllow").innerText = (12 - Number(dsMonAccHour.NameValue(1,"ALL_TOT_TIME"))) +"H";

    		}
    		
    		
    	} else {
    		
    	    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {

        		document.getElementById("resultUse").innerText = "0H(����) + 0H(����) = 0H";
        		document.getElementById("resultAllow").innerText = "8.5H";
        		dsMonAccHour.AddRow();
        		
    		}else{    		
    		
    		
    		document.getElementById("resultUse").innerText = "0H(����) + 0H(����) = 0H";
    		document.getElementById("resultAllow").innerText = "12H";
    		dsMonAccHour.AddRow();
    		
    		}
    		
    	}

    	
    </Script>
    
    
    
    
    
    
    <Script For=dsOTPossibleDt Event="OnLoadCompleted(iCount)">
    	
    	if (iCount > 0) {
    		
    		
    		var catg = document.getElementById("cmbAPP_TYPE").value;
    		
    		
    		//alert(catg);
    		
    		var REQ_CNT = 0;
    		
    		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
    			
    			
    			if(dsOTPossibleDt.NameString(i, "HOL_YN") == "N") {
    				
    				
    				REQ_CNT++;
    				
    				
   				}
    			
    			
    			
    			
    			//  ���� ���� üũ
    			//if(dsOTPossibleDt.NameString(i, "REG_YN") == "N")
   				//{
    			//	REQ_CNT++;
   				//}
    			
    			// �� ��û �Ǵ� ����Ϸ� üũ
    			//if(dsOTPossibleDt.NameString(i, catg+"_REQ_YN") == "Y")
    			//{
     			//	REQ_CNT++;
    			//}
   			}
    		
    		
    		
    		//if(REQ_CNT > 0)
    		//{
    		//	alert("��û�� �� ��û/���� ���� �Ǵ� ������ ���ԵǾ� �ֽ��ϴ�.\n\n��û �Ǵ� ���簡 �Ϸ�Ǿ��ų�,\n������ ���ԵǾ� �ִ� �ٹ����� ��û�Ͽ��� ���ܵ˴ϴ�.");
    		//}
    		
    		
    		
    		
    		if(REQ_CNT = 0) {
    			
    			
    			alert("��û�� �� ��û/���� ���� �Ǵ� ������ ���ԵǾ� �ֽ��ϴ�.\n\n��û �Ǵ� ���簡 �Ϸ�Ǿ��ų�,\n������ ���ԵǾ� �ִ� �ٹ����� ��û�Ͽ��� ���ܵ˴ϴ�.");
    			
    			
    		}
    		
    		
    		
    	}
    </Script>
    
    
    
    
    
    
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsWeekOfYear Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsMonAccHour Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsOTPossibleDt Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    
    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsWeekOfYear Event="OnDataError()">
        cfErrorMsg(this);
    </Script>    
    
    
    <Script For=dsMonAccHour Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsOTPossibleDt Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
	
        if(GBN == "SAV01") {
        	
        	alert("���������� ��� �Ǿ����ϴ�.\n\n���� ��Ȳ�� ����ٹ����� �޴����� Ȯ���Ͻñ� �ٶ��ϴ�.");
        	
        	window.close();
        	
        }
        
    </script>


	<script for=trT_DI_SMSTRANS event="OnSuccess()">

        	alert("�۾��� �Ϸ� �Ͽ����ϴ�");

    </script>
    
	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnFail()">
	
	
		cfErrorMsg(this);
		
		
    </script>
    
	<script for=trT_DI_SMSTRANS event="OnFail()">
	
	
		cfErrorMsg(this);
		
		
    </script>
    
    
    <!------------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|
    +------------------------------------------->
    <script language=JavaScript for=grdT_DI_OVERTIMEWORK event=OnExit(row,colid,olddata)>
    
    
	    var ovr_time = ""; 
	    
		var catg = document.getElementById("cmbAPP_TYPE").value;
		
		
		
		if(colid == "STR_OVR_TIME" || colid == "END_OVR_TIME") {
			
			
			if(colid == "STR_OVR_TIME") {
				
				ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "STR_OVR_TIME");
				
			} else {
				
				ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "END_OVR_TIME");
				
			}
			
			
			
			if(ovr_time == "") {
				
				alert("�ð� ������ �߸��Ǿ����ϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if(!fnc_isNumber(ovr_time)) {
				
				alert("���ڸ� �Է� �����մϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if(ovr_time.length > 4) {
				
				alert("�ð������� 4�ڸ��� �ʰ��� �� �����ϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if( !(ovr_time.substring(2, 4) == "00" || ovr_time.substring(2, 4) == "30") ) {
				
				alert("�д����� 30�� ������ �������� �մϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			
			var STR_TIME = dsT_DI_OVERTIMEWORK.NameString(row, "STR_OVR_TIME");
			var END_TIME = dsT_DI_OVERTIMEWORK.NameString(row, "END_OVR_TIME");
			
			
			
			if(catg == "AM") {
				
				
				if(  !((STR_TIME >= "0600" && STR_TIME <= "0900") && (END_TIME >= "0600" && END_TIME <= "0900")) ) {
					
					alert("���� : ���� 06:00 ~ ���� 09:00 ���̿��� ��ϰ����մϴ�.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
				}
				
			} else if(catg == "PM") {
				

				if((Number(STR_TIME.substring(0, 2)) >= 24 && Number(STR_TIME.substring(0, 2)) <= 30) || (Number(END_TIME.substring(0, 2)) >= 24 && Number(END_TIME.substring(0, 2)) <= 30)   ) {
					
					alert("�ùٸ� �Է½ð� ���� �ƴմϴ�.\n00:00 ~ 06:00 ���̷� �Է��Ͻʽÿ�.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
				}
				
				
				
				STR_TIME = (    (Number(STR_TIME.substring(0, 2)) >= 0 && Number(STR_TIME.substring(0, 2)) <= 6)    ?    ((Number(STR_TIME.substring(0, 2))+24)+""+STR_TIME.substring(2, 4)) : STR_TIME ); 
				END_TIME = (    (Number(END_TIME.substring(0, 2)) >= 0 && Number(END_TIME.substring(0, 2)) <= 6)    ?    ((Number(END_TIME.substring(0, 2))+24)+""+END_TIME.substring(2, 4)) : END_TIME );
	
				
				
				if( !((STR_TIME >= "1800" && STR_TIME <= "3000") && (END_TIME >= "1800" && END_TIME <= "3000"))  && STR_TIME != "" && END_TIME != "") {
					
					alert("���� : ���� 18:00 ~ ���� 06:00 ���̿��� ��ϰ����մϴ�.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
				}
				
			} else {
				
				
			}
			
			
			
			
			
			
			var CALC_TIME = ((fnc_covNumber(END_TIME.substring(0, 2)) * 60) + fnc_covNumber(END_TIME.substring(2, 4))) - 
			((fnc_covNumber(STR_TIME.substring(0, 2)) * 60) + fnc_covNumber(STR_TIME.substring(2, 4)));
			
			
			
			if(parseInt(CALC_TIME) < 0 && STR_TIME != "" && END_TIME != "") {
				
				alert("����ð��� ���۽ð����� �۽��ϴ�.\n�ٽ� ������ �ּ���");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			// �ֺ� 12�ð� üũ
			if(!fnc_CalcAccReTime(dsT_DI_OVERTIMEWORK.NameString(row, "WK_MON"),dsT_DI_OVERTIMEWORK.NameString(row, "WK_FRI"),row,(CALC_TIME/60))) {
				
				alert("�ֺ� �ִ� ��ϰ����� 12�ð��� �ʰ��Ͽ����ϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			var temp_ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME");
			
			
			dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME") = (CALC_TIME/60);
			
			
			// �� 52�ð� üũ
			/* if(!fnc_CalcReTime())
			{
				dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME") = temp_ovr_time;
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				return;
			} */
			
			
			
		}
		
		
		
		
		
	</script>
	
	
	
	
	
	
	<!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnHeadCheckClick(Col,Colid,bCheck)>

    
    
	    this.ReDraw = "false";	// �׸��� ��ü draw �� false �� ����
	
	    
	    
		if (bCheck == '1') {	// ��üüũ
			
			
			for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){
				
				dsT_DI_OVERTIMEWORK.NameString(i, Colid) = 'T';
				
			}
		
		
		}else{	// ��üüũ����
			
			
			for (var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){
				
				dsT_DI_OVERTIMEWORK.NameString(i, Colid) = 'F';
				
			}
		
		}
	    
	    

		this.ReDraw = "true";

		
		
    </script>
    
    
    
    
    
    
    <!-----------------------------------------------------+
    | grdT_DI_OVERTIMEWORK OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnClick(Row,Colid)>
	
		if(Colid == "END_TAG" && dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK") != "" ) {
			
			var obj =  dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK");
			
			window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
		}
		
	</script>
    
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- Ķ���� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>




<!-- form ���� -->
<form name="form1">





<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left">
		</td>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)">
			<img src="../../images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->




<!-- ���� ���̺� ���� 
<table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	<colgroup>
		<col width="340"/>
		<col width="340"/>
		<col width="320"/>
	</colgroup>
	<tr>
		<td align="center" class="blueBold">����ð�</td>
		<td align="center" class="blueBold">��û �Է� ���ɽð�</td>
		<td align="center" class="blueBold">�ֺ� ���� �ٹ��ð�</td>
	</tr>
	<tr height="60">
		<td align="center">���� : ���� 06:00 ~ ���� 09:00<br>���� : ���� 18:00 ~ ���� 06:00</td>
		<td align="center">���� : ������û ~ ���� 06:00 ����<br>���� : ������û ~ ���� 18:00 ����</td>
		<td align="center">�ִ� 12H ���� ����<br>(���ϱٹ� ����)</td>
	</tr>
</table>
���� ���̺� �� -->



<p><br></p>




<!-- ��û���� ���� -->
<table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	<colgroup>
		<col width="200"/>
		<col width="250"/>
		<col width="200"/>
		<col width="250"/>
	</colgroup>
	

	
	<tr>
		<td align="center" class="blueBold">�ڵ����缱</td>
		<td class="padding2423" colspan="3">
			<span id="resultAppLine">&nbsp;</span>
		</td>
	</tr>
	
	
	<tr>
		<td align="center" class="blueBold">�Ҽ�</td>
		<td class="padding2423" colspan="3">
			<input id="txtDPT_CD" name="txtDPT_CD" size="4" class="input_ReadOnly" readonly > 
			<input id="txtDPT_NM" name="txtDPT_NM" size="20" class="input_ReadOnly"  readonly >
			<!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
			<img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a-->
		</td>
		<!-- 
		<td align="center" class="blueBold">��Ʈ</td> maxlength="4" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')" 
		 <td class="padding2423">
			  <input type="hidden" id="txtPART_CD_SHR" name="txtPART_CD_SHR" size="25" class="input_ReadOnly"  readonly >  
			<input id="txtPART_NM" name="txtPART_NM" size="25" class="input_ReadOnly"  readonly >
		</td> 
		-->
	</tr>
	
	<tr>
		<td align="center" class="blueBold">���</td>
		<td class="padding2423">
		
<!--  		
            <input id="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
            <input id="txtENO_NM_SHR" size="8" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','','');"></a>
            <input type="hidden" id="hidEMPL_DPT_CD">
-->
 
			<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()" class="input_ReadOnly"  >
			<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "14" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()" class="input_ReadOnly"  > 
			<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

		</td>
		<td align="center" class="blueBold" rowspan="2">�� �����ð�(<span id="resultWkSq">&nbsp;</span>����)<br>(<span id="resultWkterm">&nbsp;</span>)</td>   
		<td class="padding2423">
			<!-- span id="resultMonth">&nbsp;</span> : <input id="txtTOT_TIME" name="txtTOT_TIME" size="5" class="input_ReadOnly" style="text-align: right"  readonly-->
			���ֻ�� : <span id="resultUse">&nbsp;</span>
		</td>
	</tr>
	
	<tr>
		<td align="center" class="blueBold">����ٹ� ����</td>
		<td class="padding2423">
			<select id="cmbAPP_TYPE" name="cmbAPP_TYPE" onchange="fnc_SetTime();">
				<option value="AM">������ٽ�û</option> 
				<option value="PM" selected>���Ŀ���ٹ���û</option>
				<option value="WK" >���ϱٹ���û</option>
			</select>
		</td>
		<td class="padding2423">
			<!-- span id="resultMonth">&nbsp;</span> : <input id="txtTOT_TIME" name="txtTOT_TIME" size="5" class="input_ReadOnly" style="text-align: right"  readonly-->
			��û���� : <span id="resultAllow">&nbsp;</span>
		</td>
	</tr>
	
	<tr>
		<td align="center" class="blueBold">����ٹ���</td>
		<td class="padding2423" colspan="3">
		
			<input id="txtSTR_YMD" class="input_ReadOnly" readonly size="10" maxLength="10" onblur="cfCheckDate(this);"  onkeypress="javascript:if(event.keyCode==13) cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)">
			<img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','187','285');">
			</a>
			

			<select id="cmbSTR_OVR_HOUR" style="width:50px" onChange="document.getElementById('cmbEND_OVR_HOUR').value = this.value;fnc_OVR_Time();">
			</select>:
			<select id="cmbSTR_OVR_MIN" style="width:50px" onChange="document.getElementById('cmbEND_OVR_MIN').value = this.value;fnc_OVR_Time();">
			</select>
			&nbsp;&nbsp;~&nbsp;&nbsp;
			
			
			
			
			
			<input id="txtEND_YMD" class="input_ReadOnly" readonly size="10" maxLength="10" onblur="cfCheckDate(this);"  onkeypress="javascript:if(event.keyCode==13) cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)">
			<img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','315','285');">
			</a>
						
			
			
			<select id="cmbEND_OVR_HOUR" style="width:50px" onChange="fnc_OVR_Time();">
			</select>:
			<select id="cmbEND_OVR_MIN" style="width:50px" onChange="fnc_OVR_Time();">
			</select>
			&nbsp;&nbsp;��û�ð� : <input id="txtREQ_TIME" name="txtREQ_TIME" size="4" class="input_ReadOnly" style="text-align: center;" value="0"  readonly>&nbsp;H
			
		</td>
	</tr>
	
	
	<tr>
		<td align="center" class="blueBold">�ٹ�����</td>
		<td class="padding2423" colspan="3">
			<input id="txtREMARK" style="width=100%" onKeyUp="fc_chk_byte(this,50)">
		</td>
	</tr>
	
	
</table>

<!-- ��û���� �� -->




<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState">
					<span id="resultMessage"> </span>
					</td>
				</tr>
			</table>
		</td>
		<td class="paddingTop8" align="right">  <!-- �߰� ���� ��ư -->
			<img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)" style="cursor:hand;">
			<img src="../../images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_RemoveOver.gif',1)" style="cursor:hand;">
		</td>
	</tr>
</table>





<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:230px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="Editable"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="Format"				value="
								<C> id='CONF_SEL'				width=50			name=''						align=center			EditStyle=CheckBox		Pointer=Hand		HeadCheckShow=true</C>
								<C> id='REG_YMD'				width=100			name='�ٹ�����'				align=center			Edit=none MASK='XXXX-XX-XX' </C>
								<C> id='WK_MON'					width=50			name='�� ������'				align=center			Edit=none show=false</C>
								<C> id='WK_FRI'					width=50			name='�� �ݿ���'				align=center			Edit=none show=false</C>
								<C> id='AM_REQ_YN'				width=50			name='������û����'				align=center			Edit=none show=false</C>
								<C> id='PM_REQ_YN'				width=50			name='���Ľ�û����'				align=center			Edit=none show=false</C>
								<C> id='WEEK_TOT_TIME'			width=100			name='�ֺ������ð�'				align=center			Edit=none show=false</C>
								<C> id='REQ_NO'					width=50			name='��û��ȣ'				align=center			Edit=none show=false</C>
								<C> id='ALL_TOT_TIME'			width=100			name='�ֺ������ð�'				align=center			Edit=none </C>
								<C> id='END_TAG'				width=70			name='�������'				align=center			EditStyle=Combo		Data=' :��û��,R:���,Y:����,N:�ΰ�'		Edit=none		Color='Blue'</C>
								<C> id='STR_OVR_TIME'			width=100			name='���۽ð�'				align=center			MASK='XX:XX'</C>
								<C> id='END_OVR_TIME'			width=100			name='����ð�'				align=center			MASK='XX:XX'</C>
								<C> id='OVR_TIME'				width=100			name='�ѱٹ��ð�'				align=center			Edit=none</C>
								<C> id='REMARK'					width=350			name='�ٹ�����'				align=center			</C>
								<C> id='APP_REMARK'				width=40			name='������'				align=center			Edit=none show=false</C>
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


<BR>

<font size=2 color=blue face = "����" bold=10>* �� �����ð�(����+����)�� ���/������/����Ϸ��� ������ ������ �ð��Դϴ�.</font>


</form>


<!-- form �� -->



</body>



</html>




