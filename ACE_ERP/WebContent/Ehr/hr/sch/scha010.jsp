	<!--*************************************************************************
	* @source      : scha010.jsp												*
	* @description : ���ڱݽ�û�� PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/04/28            �̵���            	ERP �̻�									*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���ڱݽ�û��</title>
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
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->
    <!-- ÷�� ������ ���� -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->
    
	<script language="javascript">

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			//���ڱݽ�û�� ��ȸ
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value;
            var QUARTER_SHR = document.getElementById("cmbQUARTER_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO").value;
            
            dsFILE.ClearData();
            
			dsT_SC_SCHLBOOK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha010.cmd.SCHA010CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&QUARTER_SHR="+QUARTER_SHR+"&ENO_NO="+ENO_NO;
			dsT_SC_SCHLBOOK.reset();
			
			
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
			trT_SC_SCHLBOOK.KeyValue = "tr01(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
			trT_SC_SCHLBOOK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha010.cmd.SCHA010CMD&S_MODE=SAV";
			
			//prompt(this, dsT_SC_SCHLBOOK.text);
			
			trT_SC_SCHLBOOK.post();
			
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			
            if (dsT_SC_SCHLBOOK.CountRow < 1) {
            	
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
				
                alert("���� �� �ڷᰡ �����ϴ�!");
                
                return;
                
            }else{
            	
                if(dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "PAY_YN") != "0") {
                    alert("������ �Ϸ� �Ǿ����ϴ�. �����Ͻ� �� �����ϴ�.");
                    return;
                }
                
                if(dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "IS_MOD") != "1") {
                    alert("���� �Ⱓ�� �������ϴ�. �����Ͻ� �� �����ϴ�.");
                    return;
                }
                
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
           		
            	tmpMSG += "�����     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "�������  = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YM")+"\n";
            	tmpMSG += "�����     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM")+"\n";
            	
	            if( confirm(tmpMSG) ){
	            	
                    //�ش� ���� �����ϱ��� ���ϵ��� ���� �����Ѵ�.
                    for(var i=1; i<=dsFILE.CountRow; i++) {
                    	
                        dsFILE.DeleteRow(i);
                        
                    }
                    
                    fnc_DelFile();
                    
					var IOC_GBN = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "IOC_GBN");
					var ENO_NO  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NO");
					var PIS_YM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YM");
					var BIR_YMD = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "BIR_YMD");
					var SEL_NM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM");

					dsT_SC_SCHLBOOK.DeleteRow(dsT_SC_SCHLBOOK.RowPosition);
					// �Ķ���� �߰�
					trT_SC_SCHLBOOK.Parameters = "IOC_GBN="+IOC_GBN+",ENO_NO="+ENO_NO+",PIS_YM="+PIS_YM+",BIR_YMD="+BIR_YMD+",SEL_NM="+SEL_NM;

					trT_SC_SCHLBOOK.KeyValue = "tr02(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
					trT_SC_SCHLBOOK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha010.cmd.SCHA010CMD&S_MODE=DEL";
					trT_SC_SCHLBOOK.post();
					
				}
	            
			}
            
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
			
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            
			var ENO_NO = document.form1.txtENO_NO.value;
			var PAY_YM = document.form1.txtPIS_YM.value.replace(/-/g, "");
			
			if(dsT_SC_SCHLBOOK.CountRow == 0) {
                alert("��� ����Ÿ�� ������ �ּ���!");
                return;
            }
			
		    var hnwparm = "[:ENO_NO]="+ENO_NO+"[:PAY_YM]="+PAY_YM;
		    
            document.form1.rptObject.SetValues(hnwparm);
            
            document.form1.rptObject.RunButton("Print");
            
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
			
			
			if (dsT_SC_SCHLBOOK.CountColumn == 0) {
				
				dsT_SC_SCHLBOOK.setDataHeader("IOC_GBN:STRING, PIS_YM:STRING, PAY_YMD:STRING, ENO_NO:STRING, ENO_NM:STRING, OCC_CD:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, HIR_YMD:STRING, CHI_AMT:STRING, TEL_NO:STRING, BIR_YMD:STRING, SEL_NM:STRING, MF_TAG:STRING, OLD_AGE:STRING, FSCH_CD:STRING, SCH_CD:STRING, SCH_NM:STRING, MAJ_NM:STRING, RET_AMT:INT, EDU_AMT:INT, END_AMT:INT, SCO_AMT:INT, OTH_AMT:INT, TOT_AMT:INT, PAY_AMT:INT, IMG_YN:STRING, FILE_KEY:STRING, IS_MOD:STRING, PAY_YN:STRING");
			
			}

			//alert(document.form1.txtJOB_NM.value);
			/*
			if(document.form1.txtJOB_NM.value != "�󹫺�"){
			
	            if(document.getElementById("hidPAST_MON").value < 1) {
	            	
	                alert("�����Ⱓ�� 1���� �ȵǾ��� ��� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
	                return;
	                
	            }
            
			}
            */

            if(dsVI_T_PERSON.NameValue(0,"PAY_YM") == "") {
            	
                alert("���ڱ� ��û�Ⱓ�� �ƴմϴ�. ��û�� �Ͻ� �� �����ϴ�.");
                return;
                
            }

            //��� â �Է� �����ϰ�
			dsT_SC_SCHLBOOK.AddRow();
            dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "IS_MOD") = "1";
            dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "PAY_YN") = "0";

            //������ ���� Ű�� ����
            dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "FILE_KEY") = "scha010"+(new Date().getTime());

            fnc_EnableElementAll(oInputElementList, new Array("medTOT_AMT"));

            //�ڵ� ���ε�� ��� ������ ������� ������ �ذ�
            fnc_SearchInfo();

			// EMEdit default ��
			document.medRET_AMT.Text = "";
			document.medEDU_AMT.Text = "";
			document.medEND_AMT.Text = "";
			document.medTOT_AMT.Text = "";
			document.form1.cmbFSCH_CD.selectedIndex = 0;

			// ����/�� ���� ����
			document.form1.hidIOC_GBN.value = "1"; // ����

            document.getElementById("txtPIS_YM").value = dsVI_T_PERSON.NameValue(0,"PAY_YM");
            document.getElementById("txtPAY_YMD").value = dsVI_T_PERSON.NameValue(0,"PAY_YMD");
            document.getElementById("txtSCH_NM").focus();


				if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003" || gusrid == "2180001"){

						fnc_ShowElement("imgEnoNo");

				}

				

		}

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
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

			if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6050006" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003" || gusrid == "2180001"){
					
	            document.getElementById('txtENO_NO_SHR').value = '';
	            document.getElementById('txtENO_NM_SHR').value = '';
	
	            dsVI_T_PERSON.ClearData();
	            document.form1.hidPAST_MON.value  = "";
	            document.form1.txtENO_NO.value    = "";
	            document.form1.txtENO_NM.value    = "";
	            document.form1.txtDPT_NM.value    = "";
	            document.form1.txtJOB_NM.value    = "";
	            document.form1.txtHIR_YMD.value   = "";
	            document.form1.hidOCC_CD.value    = "";

    		}else{

	            // �α����� ������� ��������� ��ȸ
	            fnc_SearchInfo();

    		}

	        document.getElementById("resultMessage").innerText = ' ';


			// �޺��ڽ� �⺻ ����
			document.form1.cmbFSCH_CD.selectedIndex = 0;
            fnc_DisableElementAll(oInputElementList);

        	dsT_SC_SCHLBOOK.ClearData();
            dsFILE.ClearData();

            // �⺻ Ű ���� �����ϰ� �ִ� �Է��� �� �ִ� ������ �����Ѵ�.
            document.getElementById("cmbFSCH_CD").selectedIndex = 1;
            fnc_ChangeFsch();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			
			if (dsT_SC_SCHLBOOK.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
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
			
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
         	
         	/*
			if(document.form1.txtJOB_NM.value != "�󹫺�"){         	
	            if(document.getElementById("hidPAST_MON").value < 1) {
	                alert("�����Ⱓ�� 1���� �ȵǾ��� ��� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
	                return;
	            }
			}
         	*/
         	
			
			var edu_amt = form1.medEDU_AMT.Text;
			var tot_amt = form1.medTOT_AMT.Text;
			
            if(document.form1.cmbFSCH_CD.selectedIndex == "0") {       	
                	
                	if(edu_amt > 75000) {
    	                alert("���л��� ��� 75000�� �̻� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
    	                return;
    	            }
                	if(tot_amt > 75000) {
    	                alert("���л��� ��� 75000�� �̻� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
    	                return;
    	            }            	
                	
                }			
			
            if(document.form1.cmbFSCH_CD.selectedIndex == "1" || document.form1.cmbFSCH_CD.selectedIndex == "2" ||document.form1.cmbFSCH_CD.selectedIndex == "3" ) {       	
            	/*
            	if(edu_amt > 500000) {
	                alert("����л��� ��� 50���� �̻� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
	                return;
	            }
            	if(tot_amt > 500000) {
	                alert("����л��� ��� 50���� �̻� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
	                return;
	            }     
            	*/
            	
            	if(tot_amt > 400000) {
	                alert("����л��� ��� 40���������� �����˴ϴ�.");
	                //tot_amt = 400000; 
	    			//document.medTOT_AMT.Text = "400000";
	                pay_amt = 400000;
	                dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "PAY_AMT") = pay_amt;

	            }               	
            	
            }

            if(document.form1.cmbFSCH_CD.selectedIndex == "4" || document.form1.cmbFSCH_CD.selectedIndex == "5" || document.form1.cmbFSCH_CD.selectedIndex == "6" || document.form1.cmbFSCH_CD.selectedIndex == "7" ||
            	 document.form1.cmbFSCH_CD.selectedIndex == "8" || document.form1.cmbFSCH_CD.selectedIndex == "9" || document.form1.cmbFSCH_CD.selectedIndex == "10") {
	            /*
            	if(edu_amt > 2500000) {
	                alert("���л��� ��� 250���� �̻� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
	                return;
	            }
	            if(tot_amt > 2500000) {
	                alert("���л��� ��� 250���� �̻� ���ڱ� ��û�� �Ͻ� �� �����ϴ�.");
	                return;
	            }	            
	            */
	            

	            if(tot_amt > 2000000) {
	                alert("���л��� ��� 200���������� �����˴ϴ�.");
	                //tot_amt = 2000000; 
	    			//document.medTOT_AMT.Text = "2000000";	                
	                pay_amt = 2000000;	  
	                dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "PAY_AMT") = pay_amt;	                
	            }	  
	            
	            
            }

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	// �г� ���� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_E9.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_E9.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_E9.NameValue(i,"CODE_NAME");
				document.getElementById("cmbFSCH_CD").add(oOption);
			}
        	
            // �⺻ Ű ���� �����ϰ� �ִ� �Է��� �� �ִ� ������ �����Ѵ�.
            document.getElementById("cmbFSCH_CD").selectedIndex = 1;
            
            fnc_ChangeFsch();
            
            document.getElementById("txtPIS_YY_SHR").value = gcurdate.substring(0,4);
            
			cfStyleGrid_New(form1.grdT_SC_SCHLBOOK,15,"false","false");      // Grid Style ����
			
            //�Է� ���ϰ� ����
			fnc_DisableElementAll(oInputElementList);
			
            document.getElementById('txtENO_NO_SHR').value = gusrid;
            document.getElementById('txtENO_NM_SHR').value = gusrnm;
            
			if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003" || gusrid == "2180001"){
				
	            fnc_ShowElement("eno_no");
	            fnc_ShowElement("eno_no_shr");

    		}

            //�α����� ������� ��������� ��ȸ
            fnc_SearchInfo();

        }

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

        //�Է��ʵ�
        var oInputElementList = new Array("txtBIR_YMD"
                                         ,"txtSEL_NM"
                                         ,"cmbFSCH_CD"
                                         ,"txtSCH_NM"
                                         ,"txtMAJ_NM"
                                         ,"medRET_AMT"
                                         ,"medEDU_AMT"
                                         ,"medEND_AMT"
                                         ,"medTOT_AMT"
                                         ,"FileAdd"
                                         ,"FileDel"
                                         );
        //�Է��ʵ� ���� �׸�
        var oInputExceptionList = new Array(
                                          "txtSEL_NM"
                                         ,"txtBIR_YMD"
                                         ,"medTOT_AMT"
                                         );

 		/********************************************
         * ���õ� ����� �ش��ϴ� ������� ��ȸ          		*
         ********************************************/
        function fnc_SearchInfo(){
            var ENO_NO_SHR = document.getElementById('txtENO_NO_SHR').value;

			dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha010.cmd.SCHA010CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO_SHR;
			dsVI_T_PERSON.reset();
        }

  		/********************************************
         * �ֹε�Ϲ�ȣ �Է½� �ڵ� ������(-) �ֱ� 			*
         ********************************************/
		function cfCheckNumber5(){
			if((event.keyCode < 48)||(event.keyCode > 57)){
				if(event.keyCode != 45){
					event.returnValue=false;
				}
			}
			if( document.form1.txtBIR_YMD.value.length == 6 ){
				document.form1.txtBIR_YMD.value += "-";
			}
		}

  		/********************************************
         * �ֹε�Ϲ�ȣ �ʵ忡�� ��Ŀ�� ������ ��ȿ���� �˻�      *
         ********************************************/
		function checkSSN(){
			// ������ ����
			var ssn = removeChar( document.form1.txtBIR_YMD.value, "-" ) ;
			if( document.form1.txtBIR_YMD.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				document.form1.txtBIR_YMD.value = "";
				document.form1.txtBIR_YMD.focus();
			}else{
				document.form1.hidBIR_YMD.value = ssn.substr(0,6);
			}
		}

		/********************************************
         * ÷������ ó��								*
         ********************************************/
		function fnc_FileUpload(){

            if(dsFILE.CountRow == 5) {
            	
                alert("�� �̻� ÷�������� �߰��Ͻ� �� �����ϴ�.");
                
                return;
                
            }

            var key = dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "FILE_KEY");

            if(key == "") {
            	
                key = "scha010"+(new Date().getTime());
                
                dsT_SC_SCHLBOOK.NameValue(dsT_SC_SCHLBOOK.RowPosition, "FILE_KEY") = key;
                
            }          
            
			fnc_AddFile(key, false);

		}

		/********************************************
         * ÷������ ����								*
         ********************************************/
		function fnc_FileDelete() {
			
            if(dsFILE.CountRow < 1) {
            	
                alert("������ ������ �������� �ʽ��ϴ�.");
                
                return;
            }

            if( confirm("÷�ε� ������ �����Ͻðڽ��ϱ�?") ){
            	
                dsFILE.DeleteRow(dsFILE.RowPosition);
                
                fnc_DelFile();
                
            }
		}

		/********************************************
         * �հ豸�ؼ� �ֱ�	 							*
         ********************************************/
		function fnc_sum(){
			var ret_amt = form1.medRET_AMT.Text;
			var edu_amt = form1.medEDU_AMT.Text;
			var end_amt = form1.medEND_AMT.Text;

			if( ret_amt == "" ){ ret_amt = 0; }
			if( edu_amt == "" ){ edu_amt = 0; }
			if( end_amt == "" ){ end_amt = 0; }


			var sum = eval( ret_amt+"+"+edu_amt+"+"+end_amt )+"";

			form1.medTOT_AMT.Text = sum;
		}

        //�ִ� �Է°��� �����ϱ� ���� ���� ����
        var vMAX_RET_AMT =0 ;   //���б�
        var vMAX_EDU_AMT =0 ;   //������
        var vMAX_END_AMT =0 ;   //�⼺ȸ��(�б����)

        /**
         * �г��� ���� �Ǿ����� �Է��� �� �ִ� �ִ� ���� ������Ŵ
         */
        function fnc_ChangeFsch() {
        	
            var fsch_cd = document.getElementById("cmbFSCH_CD").value
            if(fsch_cd == "" || fsch_cd == null || fsch_cd == 'undefined') return;

            var vGrade = fsch_cd.substr(0,1);
            var vClass = fsch_cd.substr(1,1);

            //���б�, ����б�, ���б� ���� ����
            var vGradekey;
            if(vGrade == 2)     vGradekey = 0;      //���б�
            else if(vGrade == 3)vGradekey = 1;      //����б�
            else                vGradekey = 2;      //���б�(������, 4���)

            //�г� ������ ������
            var vClassKey;
            if(vClass == 1)     vClassKey = 0;      // 1�г�
            else if(vClass == 2)vClassKey = 1;      // 2�г�
            else if(vClass == 3)vClassKey = 2;      // 3�г�
            else                vClassKey = 3;      // 4�г�

        }

        /**
         * ���ڱ������ݾ׿� ���� �������� ����
         */
        function fnc_ShowNotice() {
        	
            var href_page = "../../../Ehr/hr/sch/scha011.jsp";

            window.showModalDialog(href_page, "", "dialogWidth:570px; dialogHeight:350px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            
        }

		/**����˾����� ������ �������� */
		function fnc_showEmplPopUp(){
			
			var obj = new String();
			
			obj.eno_no = document.getElementById('txtENO_NO').value;
			obj.eno_nm = document.getElementById('txtENO_NM').value;
			
			window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
			document.getElementById('txtENO_NO_SHR').value = obj.eno_no;
			document.getElementById('txtENO_NM_SHR').value = obj.eno_nm;
			document.getElementById('txtENO_NO').value = obj.eno_no;
			document.getElementById('txtENO_NM').value = obj.eno_nm;
			document.getElementById('hidDPT_CD').value = obj.dpt_cd;
			document.getElementById('txtDPT_NM').value = obj.dpt_nm;
			document.getElementById('txtJOB_NM').value = obj.job_nm;
			document.getElementById('txtHIR_YMD').value = obj.hir_ymd;

            var ENO_NO_SHR = document.getElementById('txtENO_NO').value;

			dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sch.a.scha010.cmd.SCHA010CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO_SHR;
			dsVI_T_PERSON.reset();
			
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SC_SCHLBOOK)			   |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet								       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_SC_SCHLBOOK)		       |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �г� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E9"/>
       <jsp:param name="CODE_GUBUN"    value="E9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //�ڵ� ���ε�� ��� ������ ������� ������ �ذ�
            fnc_SearchInfo();
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.CountRow);

            //�Է� ���ϰ� ����
			fnc_DisableElementAll(oInputElementList);
            
        }
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			
            document.getElementById("resultMessage").innerText = "�ش����� ������ �����ϴ�.";
            
			//alert("�ش����� ������ �����ϴ�.");
			
		} else {
			
            //�����Ⱓ�� 1���� �ȵ� ��� �޼��� ó��
            /*
            if(dsVI_T_PERSON.NameValue(1,"JOB_NM") != "�󹫺�"){
            	
	            if(1 > dsVI_T_PERSON.NameValue(0,"PAST_MON")) {
	            	
	                alert("�����Ⱓ�� 1���� �ȵǾ��� ��� ���ڱ� ��û�� �Ͻ� �� �����ϴ�!");
	                
	            }
            }
			*/
			
			
			// ��� ���� ����
            document.form1.hidPAST_MON.value  = dsVI_T_PERSON.NameValue(0,"PAST_MON");
            document.form1.txtENO_NO.value    = dsVI_T_PERSON.NameValue(0,"ENO_NO");
            document.form1.txtENO_NM.value    = dsVI_T_PERSON.NameValue(0,"ENO_NM");
            document.form1.txtDPT_NM.value    = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            document.form1.txtJOB_NM.value    = dsVI_T_PERSON.NameValue(0,"JOB_NM");
			document.form1.txtHIR_YMD.value   = dsVI_T_PERSON.NameValue(0,"HIR_YMD");
			document.form1.hidOCC_CD.value    = dsVI_T_PERSON.NameValue(0,"OCC_CD");
			
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
	
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        
        cfErrorMsg(this);
        
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
	
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        
        cfErrorMsg(this);
        
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
	
        document.getElementById("resultMessage").innerText = ' ';
        
        //Dataset���� Error ó��
        
        cfErrorMsg(this);
        
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnSuccess()">
	
		alert("����Ǿ����ϴ�");
		
		fnc_SearchList();
		
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnFail()">
	
        cfErrorMsg(this);
        
    </script>
    

	<!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó��			   |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_SC_SCHLBOOK event=OnRowPosChanged(row)>
    
        //�Է� ���ϰ� ����
        fnc_DisableElementAll(oInputElementList);

        //�ִ밪 �Է� ���ϰ� ���Ѱ� ����
        fnc_ChangeFsch();

        if(row > 0) {
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_SC_SCHLBOOK.NameValue(row, "FILE_KEY"));
            

            //���� �Ϸᰡ ���� �ʾҰų� �����Ⱓ �̸�
            
            if(dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "0" && dsT_SC_SCHLBOOK.NameValue(row, "IS_MOD") == "1") {
            	
                //���������ϰ� â Ǯ�� ����
                fnc_EnableElementAll(oInputElementList, oInputExceptionList);
                
            }
            
        }
        
	</script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_SC_SCHLBOOK event=CanRowPosChange(row)>
	
        if(row >0) {
        	
            //���� �Ϸᰡ ���� �ʾҰų� �����Ⱓ �̸�
            
            if(dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "0" && dsT_SC_SCHLBOOK.NameValue(row, "IS_MOD") == "1") {

                if ( dsT_SC_SCHLBOOK.NameValue(row,"FSCH_CD") == "" ) {
                	
                    alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','FSCH_CD') + " ]�� �ʼ� �Է»����Դϴ�");
                    
                    document.getElementById("cmbFSCH_CD").focus();
                    
                    return false;
                    
                }
                
        		if ( dsT_SC_SCHLBOOK.NameValue(row,"ENO_NO") == "" ) {
        			
        			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
        			
                    document.getElementById("txtENO_NO").focus();
                    
        			return false;
        			
        		}
        		
        		if ( dsT_SC_SCHLBOOK.NameValue(row,"SEL_NM") == "" ) {
        			
        			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','SEL_NM') + " ]�� �ʼ� �Է»����Դϴ�");
        			
                    document.getElementById("txtSEL_NM").focus();
                    
        			return false;
        			
        		}
        		
        		if ( dsT_SC_SCHLBOOK.NameValue(row,"BIR_YMD") == "" ) {
        			
        			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','BIR_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
        			
                    document.getElementById("txtBIR_YMD").focus();
                    
        			return false;
        			
        		}
        		
        		if ( dsT_SC_SCHLBOOK.NameValue(row,"TOT_AMT") == "" || dsT_SC_SCHLBOOK.NameValue(row,"TOT_AMT") == "0") {
        			
        			alert("�����ݾ��� ����ֽ��ϴ�. �����ݾ��� �Է��ϼ���.");
        			
        			return false;
        			
        		}
        		
        		if( dsT_SC_SCHLBOOK.RowStatus(row) == 1 && document.form1.txtBIR_YMD.value.length < 8){
        			
        			alert("�߸��� �ֹι�ȣ�Դϴ�.");
        			
        			return false;
        			
        		}

                if( fnc_covNumber(getTodayArray()[1]) > 3 && dsT_SC_SCHLBOOK.NameValue(row,"RET_AMT") > 0) {
                	
                    alert("[���б�]�� 1�б� ���� �Է��� �����մϴ�.");
                    
                    document.getElementById("medRET_AMT").focus();
                    
                    return false;
                    
                }
                
            }
            
        }
        
	</script>

    <!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
    
        if(row > 0) {
        	
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
            
            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            if (vFILE_NAME != "" && vFILE_URL != "") {
            	
                cfDownload(vFILE_NAME, vFILE_URL);
                
            }
            
        }
    </script>
	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- Ķ���� ������-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

	<!-- form ���� -->
	<form name="form1" id="form1">


	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>  -->
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPrint','','../../images/button/btn_PrintOver.gif',1)"> <img src="../../images/button/btn_PrintOn.gif"  name="ImgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>  -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="100"></col>
                            <col width="100"></col>
                            <col width="120"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">��û�⵵&nbsp;</td>
                            <td class="padding2423">
                                   <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                            </td>
                            <td class="searchState" align="right">��&nbsp;&nbsp;��&nbsp;</td>
                            <td class="padding2423" align="left">
                                <select id="cmbQUARTER_SHR" style="width:80" onchange="fnc_SearchList();">
                                    <option value="">��ü</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                </select>
                            </td>
                            <td align="right" class="searchState"><div id="eno_no" style="display:none">��&nbsp;&nbsp;��&nbsp;</div></td>
                            <td class="padding2423">
                            <div id="eno_no_shr" style="display:none">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13){fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchInfo();fnc_SearchList();}cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength="10" onkeypress="if(event.keyCode==13){fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchInfo();fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchInfo();fnc_SearchList();"></a>

                            </div>
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
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
			<col width="100"></col>
			<col width="130"></col>
			<col width="100"></col>
			<col width="130"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="*"></col>
        </colgroup>
        <tr>
            <td align="center" class="blueBold">�Ҽ�</td>
            <td class="padding2423">
                <input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
                <input type="hidden" id="hidDPT_CD" size="10">
                <input type="hidden" id="hidIOC_GBN" size="10">
            </td>
            <td align="center" class="blueBold">����</td>
            <td class="padding2423">
                <input id="txtJOB_NM" size="7" class="input_ReadOnly" readonly>
                <input type="hidden" id="hidOCC_CD" size="10">
                <input type="hidden" id="hidPAST_MON">
            </td>
            <td align="center" class="blueBold">���</td>
            <td class="padding2423"><input id="txtENO_NO" name="txtENO_NO" size="10" class="input_ReadOnly" readonly maxlength="8" style="ime-mode:disabled" onKeypress="cfNumberCheck()"></td>
            <td align="center" class="blueBold">����</td>
            <td class="padding2423">
				<input id="txtENO_NM" size="12" class="input_ReadOnly" readonly>
				<div id="imgEnoNo" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_showEmplPopUp()"></a>
				</div>
			</td>
            <td align="center" class="blueBold">�Ի���</td>
            <td class="padding2423"><input id="txtHIR_YMD" size="12" maxLength="10" class="input_ReadOnly" readonly></td>
        </tr>
        </table>
        </td>
    </tr>

	<tr><td>&nbsp;</td></tr>

	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="100"></col>
			<col width="130"></col>
			<col width="100"></col>
			<col width="130"></col>

			<col width="100"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="100"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">�б���</td>
			<td class="padding2423"><input id="txtSCH_NM" size="12" maxLength="25"></td>
			<td align="center" class="blueBold">�а�</td>
			<td class="padding2423"><input id="txtMAJ_NM" size="14" maxLength="26"></td>
			<td align="center" class="blueBold">�г�</td>
			<td class="padding2423">
				<select id="cmbFSCH_CD" name="cmbFSCH_CD" style="width:65px" onchange="fnc_ChangeFsch()">
                    <option></option>
                </select>
			</td>
            <td align="center" class="blueBold">���޳��</td>
            <td class="padding2423">
                <input type="text" id="txtPIS_YM" style="ime-mode:disabled" size="7" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="blueBold">��������</td>
            <td class="padding2423">
                <input type="text" id="txtPAY_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly" readonly>
            </td>
		</tr>
		<tr>
			<td align="center" class="blueBold">����</td>
			<td class="padding2423"><input id="txtSEL_NM" size="12" maxLength="12"></td>
			<td align="center" class="blueBold">�ֹι�ȣ</td>
			<td class="padding2423"><input id="txtBIR_YMD" size="8" maxLength="8" style="ime-mode:disabled"  onKeypress="cfCheckNumber5();"></td>
			<td align="center" class="blueBold" rowspan="3">���⼭��<br>÷��</td>
			<td class="padding2423" colspan="5"  rowspan="3" align="right">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)">
				<img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)">
				<img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete();"></a>

                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:100px;">
                    <param name="DataID" 					value="dsFILE">
                    <param name="Editable" 					value="false">
                    <param name="DragDropEnable" 		value="true">
                    <param name="SortView" 				value="Left">
                    <param name=ViewHeader  				value="false">
                    <param name="Format" 					value='
                        <C> id="{CUROW}"    width="30"      	name="NO"         		align="center"  	value={String(Currow)}</C>
                        <C> id=FILE_NAME    	width="270"     name="���ϸ�"      	align="left"    	leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">���б�</td>
			<td class="padding2423">
    			<table width="100%" border="0" >
    			<tr>
    				<td width="90%">
    					<comment id="__NSID__"><object id="medRET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
    						<param name=Alignment				value=2>
    						<param name=Border					value=true>
    						<param name=ClipMode					value=true>
    						<param name=DisabledBackColor		value="#EEEEEE">
    						<param name=Enable					value=true>
    						<param name=IsComma				value=true>
    						<param name=Language				value=0>
    						<param name=MaxLength				value=8>
    						<param name=Numeric					value=true>
    						<param name=NumericRange			value=0~+:0>
    						<param name=ShowLiteral				value=false>
    						<param name=Visible						value=true>
    					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
    				</td>
    				<td align="left">��</td>
    			</tr>
    			</table>
			</td>
			<td align="center" class="blueBold">������</td>
			<td class="padding2423">
    			<table width="100%" border="0" >
    				<tr>
    				<td width="90%">
    					<comment id="__NSID__"><object id="medEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
    						<param name=Alignment				value=2>
    						<param name=Border					value=true>
    						<param name=ClipMode					value=true>
    						<param name=DisabledBackColor		value="#EEEEEE">
    						<param name=Enable					value=true>
    						<param name=IsComma				value=true>
    						<param name=Language				value=0>
    						<param name=MaxLength				value=8>
    						<param name=Numeric					value=true>
    						<param name=NumericRange			value=0~+:0>
    						<param name=ShowLiteral				value=false>
    						<param name=Visible					value=true>
    					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
    				</td>
    				<td align="left">��</td>
    				</tr>
    			</table>
			</td>
        </tr>
        <tr>
			<td align="center" class="blueBold">�б��������</td>
			<td class="padding2423">
    			<table width="100%" border="0" >
    				<tr>
    				<td width="90%">
    					<comment id="__NSID__"><object id="medEND_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
    						<param name=Alignment				value=2>
    						<param name=Border					value=true>
    						<param name=ClipMode					value=true>
    						<param name=DisabledBackColor		value="#EEEEEE">
    						<param name=Enable					value=true>
    						<param name=IsComma				value=true>
    						<param name=Language				value=0>
    						<param name=MaxLength				value=8>
    						<param name=Numeric					value=true>
    						<param name=NumericRange			value=0~+:0>
    						<param name=ShowLiteral				value=false>
    						<param name=Visible					value=true>
    					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
    				</td>
    				<td align="left">��</td>
    				</tr>
    			</table>
			</td>
			<td align="center" class="blueBold">��</td>
			<td class="padding2423">
    			<table width="100%" border="0" >
    			<tr>
    				<td width="90%">
    					<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
    						<param name=Alignment				value=2>
    						<param name=Border					value=true>
    						<param name=ClipMode					value=true>
    						<param name=DisabledBackColor		value="#EEEEEE">
    						<param name=Enable					value=true>
    						<param name=IsComma				value=true>
    						<param name=Language				value=0>
    						<param name=MaxLength				value=9>
    						<param name=Numeric					value=true>
    						<param name=NumericRange			value=0~+:0>
    						<param name=ShowLiteral				value=false>
    						<param name=Visible						value=true>
    						<param name=ReadOnly 				value=true>
    					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
    				</td>
    				<td align="left">��</td>
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

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:360px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
                        <param name="ColSelect"  value="true">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width="30"		name="NO"					align="center"	value={String(Currow)}</C>
                            <C> id="PIS_QQ"	    	width="30"		name="�б�"					align="center"	Edit=none</C>
                            <C> id="IPT_YMD"		width="70"		name="��û����"			align="center"	Edit=none</C>
                            <C> id="SEL_NM"     	width="60"      	name="����"               	align="center"  	Edit=none</C>
							<C> id="BIR_YMD"		width="100"		name="�ֹι�ȣ"			align="center"	Edit=none</C>
							<C> id="MF_TAG"		width="40"		name="����"					align="center"	Edit=none	EditStyle=Combo		Data="F:����,M:����"</C>
							<C> id="OLD_AGE"		width="40"		name="����"					align="center"	Edit=none</C>
							<C> id="SCH_NM"		width="100"		name="�б���"				align="left"		Edit=none	LeftMargin="10"</C>
							<C> id="MAJ_NM"		width="100"		name="�а���"				align="left"		Edit=none	LeftMargin="10"</C>
							<C> id="RET_AMT"		width="70"		name="���б�"				align="right"		Edit=none	RightMargin="10"</C>
							<C> id="EDU_AMT"		width="70"		name="������"				align="right"		Edit=none	RightMargin="10"</C>
							<C> id="END_AMT"		width="70"		name="�б��;������" 	align="right"		Edit=none	RightMargin="10"</C>
							<C> id="TOT_AMT"		width="70"		name="�հ�"					align="right"		Edit=none	RightMargin="10"</C>
							<C> id="PAY_AMT"		width="70"		name="���ޱݾ�"			align="right"		Edit=none	RightMargin="10"</C>
							<C> id="PAY_YN"	    	width="40"		name="����;����"			align="center"	Edit=none	value={decode(PAY_YN, "0", "��û", "1", "����", "2", "�ݼ�", "3", "��ǥ", "4", "����")}</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_SC_SCHLBOOK ���� ���̺� -->
	<object id="bndT_SC_SCHLBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_SC_SCHLBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=IOC_GBN		Ctrl=hidIOC_GBN		Param=value</C>
			<C>Col=PIS_YM		Ctrl=txtPIS_YM		Param=value</C>
			<C>Col=PAY_YMD		Ctrl=txtPAY_YMD		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value</C>
			<C>Col=SEL_NM		Ctrl=txtSEL_NM		Param=value</C>
			<C>Col=OLD_AGE		Ctrl=txtOLD_AGE		Param=value</C>
			<C>Col=FSCH_CD		Ctrl=cmbFSCH_CD		Param=value</C>
			<C>Col=SCH_NM		Ctrl=txtSCH_NM		Param=value</C>
			<C>Col=MAJ_NM		Ctrl=txtMAJ_NM		Param=value</C>
			<C>Col=RET_AMT		Ctrl=medRET_AMT		Param=Text</C>
			<C>Col=EDU_AMT		Ctrl=medEDU_AMT		Param=text</C>
			<C>Col=END_AMT		Ctrl=medEND_AMT		Param=text</C>
			<C>Col=SCO_AMT		Ctrl=medSCO_AMT		Param=text</C>
			<C>Col=OTH_AMT		Ctrl=medOTH_AMT		Param=text</C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=text</C>
		">
	</object>