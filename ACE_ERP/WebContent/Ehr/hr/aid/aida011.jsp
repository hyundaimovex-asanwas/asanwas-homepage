	<!--*************************************************************************
	* @source      : aida010.jsp												*
	* @description : ������ݽ�û������ PAGE / �����ݽ�û���� PAGE(POP_UP)    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/12            ä����          	        �����ۼ�		        *
    * 2006/05/08            ���м�          	        �����ۼ�
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<%
    String prmREQ_NO    = request.getParameter("REQ_NO");
    String prmTYPE      = request.getParameter("TYPE"); //"TYPE1" : �ű�, "TYPE2" : ���� ó��, "TYPE3" : ����ó��
%>

<html>
<head>
<title>������ݽ�û����</title>
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
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																     *
    *																						 *
    ***************************************************************************************-->

	<!-- ÷�� ������ ���� -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

	<script language="javascript">

		var year = gcurdate.substring(0,4);
        
		var btnList;
		
        var prmREQ_NO   = "<%=prmREQ_NO %>";    //��û��ȣ
        
        var prmTYPE     = "<%=prmTYPE %>";      //"TYPE1" : �ű�, "TYPE2" : ���� ó��, "TYPE3" : ����ó��

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	
            dsRESULT.ClearData();

            trT_AD_AIDAPP2.KeyValue = "shr(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP, O:dsT_AD_DECISION=dsT_AD_DECISION)";
            
            trT_AD_AIDAPP2.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_04&REQ_NO="+prmREQ_NO;
            
            trT_AD_AIDAPP2.post();
            
            if(prmTYPE == "TYPE4"){

                fnc_ShowElement("btnO");
                fnc_ShowElement("btnR");         

            }    
            
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

            dsT_AD_AIDAPP.UseChangeInfo = false;
            dsT_AD_DECISION.UseChangeInfo = false;

			// save
			trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION, O:dsRESULT=dsRESULT)";
			trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
			trT_AD_AIDAPP.post();

        }

		
		
		
		
		
		
        /**
         * �����Լ� ���� �� �ٸ� ó���� ���� ����
         */
        function fnc_Save2() {
            dsT_AD_AIDAPP.UseChangeInfo = false;
            dsT_AD_DECISION.UseChangeInfo = true;

			// save
			trT_AD_AIDAPP2.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION, O:dsRESULT=dsRESULT)";
			trT_AD_AIDAPP2.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
			trT_AD_AIDAPP2.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
			
			//������ݽ�û��  ���� ��ȸ
			var REQ_NO = document.getElementById("txtREQ_NO").value;

			dsT_RP_REPORT.ClearAll();
			
            dsT_RP_REPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_PRINT0&REQ_NO="+REQ_NO;
            
            dsT_RP_REPORT.Reset();

			dsT_RP_REPORT2.ClearData();
			
            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_PRINT&REQ_NO="+REQ_NO;
            
            dsT_RP_REPORT2.Reset();

			gcrp_print.Preview();            
            
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
            //��û�� ������ �� �׸� ���� �ְ�
			if (dsT_AD_AIDAPP.CountColumn == 0) {
				dsT_AD_AIDAPP.setDataHeader(  "REQ_NO:STRING"
                                            +",ENO_NO:STRING"
                                            +",ENO_NM:STRING"
                                            +",CET_NO:STRING"
                                            +",OCC_CD:STRING"
                                            +",DPT_CD:STRING"
                                            +",DPT_NM:STRING"
                                            +",JOB_CD:STRING"
                                            +",JOB_NM:STRING"
                                            +",HIR_YMD:STRING"
                                            +",RET_YMD:STRING"
                                            +",LSE_YY:INT"
                                            +",LSE_MM:INT"
                                            +",ABA_CD:STRING"
                                            +",ABA_NM:STRING"
                                            +",ACC_NO:STRING"
                                            +",REC_NM:STRING"
                                            +",AID_CD:STRING"
                                            +",AID_CD_NM:STRING"
                                            +",AID_NM:STRING"
                                            +",AID_RPT:STRING"
                                            +",AID_YMD:STRING"
                                            +",SPL_YMD:STRING"
                                            +",REQ_YMD:STRING"
                                            +",HLP1_AMT:INT"
                                            +",HLP2_AMT:INT"
                                            +",SUM_AMT:INT"
                                            +",WORK_NO1:STRING"
                                            +",AID_STS:STRING"
                                            +",AID_STS_NM:STRING"
                                            +",RET_RSN:STRING"
                                            +",AID_CET:STRING"
                                            +",FILE_KEY:STRING"
                                            );
			}

            //������ �׸� �� �׸� ���� �ֱ�
            if (dsT_AD_DECISION.CountColumn == 0) {
                dsT_AD_DECISION.setDataHeader("ENO_NO:STRING"
                                            +",ENO_NM:STRING"
                                            +",DPT_CD:STRING"
                                            +",JOB_CD:STRING"
                                            +",APP_YN:STRING"
                                            +",APP_YN_NM:STRING"
                                            +",ARR_TIME:STRING"
                                            +",ORD_NO:STRING"
                                            +",AUTHO_CD:STRING"
                                            );
            }

			// �� �߰�
			dsT_AD_AIDAPP.AddRow();

			//������ ���� Ű�� ����
            dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition, "FILE_KEY") = "aida011"+(new Date().getTime());

            // �Է��ʵ� ��밡���ϰ�
            fnc_EnableElementAll(oElementList);


		    //�����ڸ� ��û�� ������ ������ ���ִ�.
		    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020"  || gusrid == "2180001" || gusrid == "3200018"  || gusrid == "2070019") {

	            fnc_ChangeStateElement(true, "txtENO_NO");
	            fnc_ChangeStateElement(true, "txtENO_NM");
	            fnc_ChangeStateElement(true, "ImgEnoNo");

    		}

            fnc_HiddenElement("btnDEC"      );  //�����ں��� ��ư
            fnc_ShowElement("btnSave"     );  //���� ��ư
            fnc_HiddenElement("imgRemove"   );
            fnc_HiddenElement("btnS"        );
            fnc_HiddenElement("btnO"        );
            fnc_HiddenElement("btnR"        );
            //fnc_HiddenElement("btnC"        );
            //fnc_HiddenElement("btnD"        );
            fnc_HiddenElement("btnE"        );

            // �޺��ڽ� �⺻ ����
            document.form1.cmbAID_CD.selectedIndex = 0;

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
	        if (dsT_AD_AIDAPP.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "��û����  = "+fnc_GetCommonName("dsT_CM_COMMON_R1", dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_CD"))+"\n";
            	tmpMSG += "�����     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_NM")+"\n";

	            if( confirm(tmpMSG) ){
					dsT_AD_AIDAPP.DeleteRow(dsT_AD_AIDAPP.RowPosition);
                    dsT_AD_DECISION.DeleteRow(dsT_AD_DECISION.RowPosition);

					//�ش� ���� �����ϱ��� ���ϵ��� ���� �����Ѵ�.
                    for(var i=1; i<=dsFILE.CountRow; i++) {
                        dsFILE.DeleteRow(i);
                    }
                    fnc_DelFile()

					trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
					trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=DEL";
					trT_AD_AIDAPP.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

  			fnc_DisableElementAll(oElementList);
	        document.getElementById("resultMessage").innerText = ' ';

			// �޺��ڽ� �⺻ ����
			document.form1.cmbAID_CD.selectedIndex = 0;
			//document.form1.cmbABA_CD.selectedIndex = 0;

        	dsT_AD_AIDAPP.ClearData();
            dsT_AD_DECISION.ClearData();
            dsRESULT.ClearData();
            dsFILE.ClearData();

            //������ ���� ����
            document.getElementById("txtA1_ENO_NO").innerText   = "";
            document.getElementById("txtA2_ENO_NO").innerText   = "";
            document.getElementById("txtA3_ENO_NO").innerText   = "";

            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";
            document.getElementById("txtA3_ENO_NM").innerText   = "";

            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";
            document.getElementById("txtA3_APP_STS").innerText  = "";
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			
            if (dsT_AD_AIDAPP.IsUpdated)  {
            	
                if (!fnc_ExitQuestion())  return;
                
            }
            
            opener.parent.fnc_SearchList();
            
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
			
         	if ( !dsT_AD_AIDAPP.isUpdated && !dsT_AD_DECISION.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

            var oElement;
            var oElement2;

            
            //2015.09.17.jys
            //����ϰ�� �ֹι�ȣ 7�ڸ� �̻� �Է��ؾ���. ������� + ����
             //��û������ �ڳ������ ��� �ֹι�ȣ 7�ڸ� �Է�  �������� + ����
            if(document.getElementById("cmbAID_CD").value == "AD"){
            	
            	if (document.form1.txtAID_CET.value.length<7){
            		
            		alert("����Ű�� ������ֹι�ȣ�� �������(6)+����(1) ��7�ڸ� �̻� �Է��ؾ��մϴ�.");
            		
            		document.getElementById("txtAID_CET").focus();
            		
            		return false;
            		
            	}else{
            		
            		if(document.form1.txtAID_CET.value.substring(6,7)!="3"&&document.form1.txtAID_CET.value.substring(6,7)!="4"){
            			
            			alert("������ֹι�ȣ�� ���������ڸ� Ȯ���Ͻʽÿ�. ��:3, ��:4");
            			
            			document.getElementById("txtAID_CET").focus();
            			
            			return false;
            			
            		}
            	}
            }            
            
            
            oElement = document.getElementById("txtAID_NM");
            
            if(oElement.value == "") {
                alert("����ڼ����� ����� �ּ���.");
                oElement.focus();
                return false;
            }
            
            oElement = document.getElementById("txtAID_YMD");
            
            if(oElement.value == "") {
                alert("�߻����ڸ� ����� �ּ���.");
                oElement.focus();
                return false;
            }
            
            oElement = document.getElementById("cmbAID_CD");
            
            if(oElement.value == "") {
                alert("��û������ ������ �ּ���.");
                oElement.focus();
                return false;
            }

            oElement = document.getElementById("medHLP1_AMT");
            oElement2 = document.getElementById("medHLP2_AMT");
            
            if(oElement.Text == "0" && oElement2.Text == "0") {
            	
                alert("������, �������� �ϳ��� �Է��ϼž� �˴ϴ�.");
                oElement.focus();
                return false;
                
            }

			var vFILE_NAME  = dsFILE.NameValue(dsFILE.RowPosition, "FILE_NAME");
			
			var vFILE_URL   = dsFILE.NameValue(dsFILE.RowPosition, "FILE_URL");

			var oElement3 = document.getElementById("cmbAID_CD").value;

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            fnc_ConstructCommonCode("dsT_CM_COMMON_R1", "cmbAID_CD","","�� ��");   //��û���� ���� �޺��ڽ�
			fnc_DisableElementAll(oElementList);                        //����Է�â ���Ƶα�

            //����Է�â�� ���Ƶ�
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");

			document.getElementById("txtAID_CET").disabled = true;
			document.getElementById("txtAID_CET").className = "input_ReadOnly";

            fnc_EnableElementAll(btnNameList);                          //����ư(��ȸ,����,��� ���)�� ��밡���ϰ� Ǯ��α�

            //�μ��ư �Ⱥ��̰�
            //fnc_HiddenElement("imgPrint"    );

			//��û ��ȣ�� ��������� �ű�
			if( prmREQ_NO == ''){
                //���ο� ���� �߰��ϰ�
                fnc_AddNew();

                //��ȸ�� ��ҹ�ư�� ��� ���ϰ� ����
                fnc_ChangeStateElement(false, "imgSearch");
                fnc_ChangeStateElement(false, "imgCancel");
                fnc_ChangeStateElement(false, "imgRemove");

                // ����Ű ��Ȱ��ȭ ó��
                btnList = "F"   //��ȸ
                        + "F"   //�ű�
                        + "T"   //����
                        + "F"   //���
                        + "F"   //����
                        + "T"   //�μ�
                        + "F"   //����
                        + "T";  //�ݱ�

                fnc_HotKey();

                //��û�� ������ �������
                document.getElementById("txtENO_NO").value = gusrid;

                fnc_SearchEmpNo();

			} else {

                // ����Ű ��Ȱ��ȭ ó��
                btnList = "T"   //��ȸ
                        + "T"   //�ű�
                        + "T"   //����
                        + "F"   //���
                        + "F"   //����
                        + "T"   //�μ�
                        + "F"   //����
                        + "T";  //�ݱ�

                fnc_HotKey();

                // ��û��ȣ(REQ_NO)�� �ش��ϴ� ��û�� ��ȸ
                fnc_SearchList();
            }

            //��ư ����Ʈ�� �����ݽô�.
            var layerName;
            
            if(prmTYPE == "TYPE1" || prmTYPE == "TYPE2" || prmTYPE == "TYPE4"){
            	
                layerName = "procBTN";

            }else if(prmTYPE == "TYPE3"){
                layerName = "popupBTN";
			}

            fnc_ShowHiddenLayer(new Array("procBTN", "popupBTN"), layerName);
            
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        //��ư��
        var btnNameList = new Array( "imgSearch"
                                    ,"imgCancel"
                                    ,"imgPrint"
                                    ,"imgExit" );

        //�Է�â��
        var oElementList = new Array("cmbAID_CD"
                                    ,"txtAID_NM"
                                    ,"txtAID_YMD"
                                    ,"medHLP1_AMT"
                                    ,"medHLP2_AMT"
                                    ,"medSUM_AMT"
                                    ,"imgAID_YMD"
                                    ,"FileAdd"
                                    ,"FileDel"
									);

		/********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

 		/********************************************
         * ��û���� �޺��ڽ� ������ �ش� ���� �ݾ� ��ȸ      		*
         ********************************************/
        function getAidAmt(){
 			

			
        	if(document.form1.txtENO_NO.value == '')   { return; } // ��� ������� ����

        	//if(document.form1.txtREQ_YMD.value == '')  { return ; }  // ��û���� ������� ����

        	if(document.getElementById("cmbAID_CD").value == '')  { return ; }  // ��û���� ������� ����


        	// ��ȸ����
        	var ENO_NO  = document.form1.txtENO_NO.value;
        	var LSE_YY  = document.form1.txtLSE_YY.value;
            var REQ_YMD = (document.form1.txtAID_YMD.value == null || document.form1.txtAID_YMD.value.trim() == '') ? (document.form1.txtREQ_YMD.value) : (document.form1.txtAID_YMD.value);
        	var HIR_YMD = document.form1.txtHIR_YMD.value;
        	var AID_CD  = document.form1.cmbAID_CD.value;
            var JOB_CD  = document.getElementById("hidJOB_CD").value;


			
			// ��û����, �ټӳ�� �� �ش��ϴ� ����������/������ ��ȸ
			dsT_AD_AIDAMT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_03&ENO_NO="+ENO_NO+"&LSE_YY="+LSE_YY+"&AID_CD="+AID_CD+"&REQ_YMD="+REQ_YMD+"&HIR_YMD="+HIR_YMD+"&JOB_CD="+JOB_CD;
			
			//prompt(this, dsT_AD_AIDAMT.dataid);
			
			dsT_AD_AIDAMT.reset();
			
        }

 		/********************************************
         * ��û���ڿ��� ��Ŀ�� ������ ��û���ڿ� ��       		*
         ********************************************/
		function cfCheckDateTermAIDA010(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�߻����ڰ� ��û���ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
			}
		}



 		/********************************************
         * ���缱���� ��ư Ŭ���� ó��                                   	*
         ********************************************/
        function fnc_btnDEC(){

            //��û�� ���
            var eno_no = document.getElementById("txtENO_NO").value;
            var eno_nm = document.getElementById("txtENO_NM").value;
            var job_nm = document.getElementById("txtJOB_NM").value;
            var idx    = "";


            //��� ���� ��������
        	var obj    = new String;
            var appObj = new String;    //������-1
            var appObj2 = new String;   //������-2
            var reqObj = new String;    //��û��
            
            reqObj = fnc_GetCommonEnoObj_DH("3200018");
            appObj = fnc_GetCommonEnoObj_DH("2070019");
            appObj2 = fnc_GetCommonEnoObj_DH("2030007");

            //������ ������ ������ �Է� ����
            if(appObj == undefined
                    || appObj.eno_no == undefined
                    || appObj.eno_no == ""
                    || appObj.eno_nm == undefined
                    || appObj.eno_nm == "") {
                return;
            }

            document.getElementById("txtA1_ENO_NO").value       = "";
            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_ENO_NO").value       = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";
            document.getElementById("txtA3_ENO_NO").value       = "";
            document.getElementById("txtA3_ENO_NM").innerText   = "";
            document.getElementById("txtA3_APP_STS").innerText  = "";


            
            //��û�� ����̶� ������ ����� ������ ù��° �����ڿ� �ְ� �ƴϸ� �ƴϸ� �ι�°�� ����
            dsT_AD_DECISION.ClearData();

                idx = 1;
                dsT_AD_DECISION.AddRow();
                dsT_AD_DECISION.AddRow();
                dsT_AD_DECISION.AddRow();

            for(var i = idx, j=1; i<=3; i++, j++) {
                if(i == 1) {
                    obj = reqObj;
                } else if(i == 2){
                    obj = appObj;
                } else {
                    obj = appObj2;
                }

                dsT_AD_DECISION.NameValue(j,"ENO_NO")           = obj.eno_no;
                dsT_AD_DECISION.NameValue(j,"ENO_NM")           = obj.eno_nm;
                dsT_AD_DECISION.NameValue(j,"DPT_CD")           = obj.dpt_cd;
                dsT_AD_DECISION.NameValue(j,"JOB_CD")           = obj.job_cd;
                dsT_AD_DECISION.NameValue(j,"ORD_NO")           = document.getElementById("txtREQ_NO").value;
                
				if(i == 1) {
                	dsT_AD_DECISION.NameValue(j,"APP_YN")           = "N";
                } else {
                	dsT_AD_DECISION.NameValue(j,"APP_YN")       = i;
				}

				
                dsT_AD_DECISION.NameValue(j,"AUTHO_CD")         = "A"+i;
                document.getElementById("txtA"+j+"_ENO_NO").value = obj.eno_no;
                document.getElementById("txtA"+j+"_ENO_NM").innerText   = obj.job_nm+" "+obj.eno_nm;
                document.getElementById("txtA"+j+"_APP_STS").innerText  = "����";
                
            }

        }


 		/********************************************
         * ��� ��ư Ŭ���� ó��                    *
         ********************************************/
        function fnc_btnS(){

            var aid_cd = dsT_AD_AIDAPP.NameString(0, "AID_CD");


        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("��� ó���� �ڷᰡ �����ϴ�!");
                return;
            }

            var oCheckList = new Array(
                                        "txtAID_NM"
                                        ,"txtAID_YMD"
                                        );

            var oCheckMsgList = new Array(
                                        "����ڼ���"
                                        ,"�߻�����"
                                        );
            var oElement;


            // ��� �ʵ� �Է� �� ��� ����
            for(var i=0; i<oCheckList.length; i++) {
                oElement = document.getElementById(oCheckList[i]);
                if(oElement.value == "") {
                    alert("[ " + oCheckMsgList[i] + " ]�� �ʼ� �Է»����Դϴ�");
                    return;
                }
            }

        	var tmpMSG = "�Ʒ� ���� ����Ͻðڽ��ϱ�?\n";
           	tmpMSG += "��û��ȣ  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "�߻�����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

            if( confirm(tmpMSG) ){

                // ����ϱ� ������ ��� ����Ÿ�� �����Ѵ�.
                fnc_Save2();

                var APP_YN = "N"; //==> ����������
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //��û ���� ����
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "S"; //���

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}

            if(dsT_AD_AIDAPP.CountRow != 0
                    && (   aid_cd == "AE"
                        || aid_cd == "AF"
                        || aid_cd == "AK"
                        || aid_cd == "AL"
                        || aid_cd == "AX"
                        || aid_cd == "AY"
                        || aid_cd == "AQ"
                        || aid_cd == "AR"
                        || aid_cd == "AS"
                        || aid_cd == "AT"
                        || aid_cd == "AZ"
                        || aid_cd == "BA"))
              //alert("����������� �������������� �濵������ ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
                alert("ó���� �Ϸ�Ǿ����ϴ�.");
            else if(dsT_AD_AIDAPP.CountRow != 0  && aid_cd == "AD")
              //alert("����������� �ֹε�ϵ�� �濵������ ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
                alert("ó���� �Ϸ�Ǿ����ϴ�.");
            else
                alert("ó���� �Ϸ�Ǿ����ϴ�.");

			fnc_HiddenElement("btnS"        );

        }

 		/********************************************
         * ���� ��ư Ŭ���� ó��                    *
         ********************************************/
        function fnc_btnO(){
        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("���� ó���� �ڷᰡ �����ϴ�!");
                return;
            }

            var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            tmpMSG += "��û��ȣ  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
            tmpMSG += "�߻�����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
            tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

            if( confirm(tmpMSG) ){

                // �����ϱ� ������ ��� ����Ÿ�� �����Ѵ�.
                fnc_Save2();


                var APP_YN = "Y";
        		var REQ_NO = document.form1.txtREQ_NO.value;
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //��û ���� ����
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "O"; //����

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
            
            window.close();
            
        }

 		/********************************************
         * �ΰ� ��ư Ŭ���� ó��                                   		*
         ********************************************/
        function fnc_btnR(){
        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("�ΰ� ó���� �ڷᰡ �����ϴ�!");
                return;
            }
        	if( document.form1.txtRET_RSN.value == ""){
	        	alert("�ΰ������ �Է��� �ּ���.");
	        	document.form1.txtRET_RSN.focus();
	        	return;
        	}
            var tmpMSG = "�Ʒ� ���� �ΰ� ó���Ͻðڽ��ϱ�?\n";
            tmpMSG += "��û��ȣ  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
            tmpMSG += "�߻�����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
            tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

            if( confirm(tmpMSG) ){
                var APP_YN = "R";
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //��û ���� ����
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "R"; //�ΰ�

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
            
            window.close();
            
        }

 		/********************************************
         * �ݼ� ��ư Ŭ���� ó��                                   		*
         ********************************************/
        function fnc_btnC(){
     		if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("�ݼ� ó���� �ڷᰡ �����ϴ�!");
                return;
            }
        	if( document.form1.txtRET_RSN.value == ""){
	        	alert("�ݼۻ����� �Է��� �ּ���.");
	        	document.form1.txtRET_RSN.focus();
	        	return;
        	}

        	var tmpMSG = "�Ʒ� ���� �ݼ�ó�� �Ͻðڽ��ϱ�?\n";
           	tmpMSG += "��û��ȣ  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "�߻�����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

	        if( confirm(tmpMSG) ){
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //��û ���� ����
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "C"; //�ݼ�

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
	        window.close();
        }

 		/********************************************
         * ��ǥ ��ư Ŭ���� ó��                                   		*
         ********************************************/
        function fnc_btnD(){
        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("��ǥ�� ������ �ڷᰡ �����ϴ�!");
                return;
            }
        	var tmpMSG = "�Ʒ� ���� ��ǥó���� �Ͻðڽ��ϱ�?\n";
           	tmpMSG += "��û��ȣ  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "�߻�����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

	        if( confirm(tmpMSG) ){
				var url = "/hr/but/buta011.jsp";
				var returnValue = new Array(2);
				window.showModalDialog(url, returnValue, "dialogWidth:730px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
				var GUBUN = returnValue[0]
				var CCTR_CD = returnValue[1]
				var CCTR_NM = returnValue[2]
				if(GUBUN == "undefined" || GUBUN == undefined || GUBUN == ""){
				}else{
					var REQ_NO = document.form1.txtREQ_NO.value;
					var ENO_NO = dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition,"ENO_NO");
					trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

					trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
					trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=PROC_D"+"&GUBUN="+GUBUN+"&CCTR_CD="+CCTR_CD+"&CCTR_NM="+CCTR_NM+"&ENO_NO="+ENO_NO;;
					trT_AD_AIDAPP.post();
				}
			}
        }

 		/********************************************
         * ���� ��ư Ŭ���� ó��                                   		*
         ********************************************/
        function fnc_btnE(){
          	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("���� ó���� �ڷᰡ �����ϴ�!");
                return;
            }

            //�������ڰ� ������ ����ó�� �Ұ����ϴ�.
			if(dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD").length == 0){
				alert("�������ڸ� �Է��ϼ���.");
				return;
			}

        	var tmpMSG = "�Ʒ� ���� ����ó�� �Ͻðڽ��ϱ�?\n";
           	tmpMSG += "��û��ȣ  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "�߻�����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "��������  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD")+"\n";
           	tmpMSG += "��û��    = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

	        if( confirm(tmpMSG) ){
        		var REQ_NO = document.form1.txtREQ_NO.value;

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=PROC_E&SPL_YMD="+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD");
				trT_AD_AIDAPP.post();
			}

        }

  		/********************************************
         * ���� ����(AID_STS)�� ���� Ȱ��ȭ ó�� *
         ********************************************/
        function checkAidStatus(){
  			
        	var status = dsT_AD_AIDAPP.NameValue(0, "AID_STS");

            //���������� ���θ� �ľ�
            var isApproval;


            
            if((dsT_AD_DECISION.NameString(1, "ENO_NO") == gusrid && dsT_AD_DECISION.NameString(1, "APP_YN") == "N") ||
               (dsT_AD_DECISION.NameString(2, "ENO_NO") == gusrid && dsT_AD_DECISION.NameString(2, "APP_YN") == "N") ||
               (dsT_AD_DECISION.NameString(3, "ENO_NO") == gusrid && dsT_AD_DECISION.NameString(3, "APP_YN") == "N"))
            	
                isApproval = true;
            
            else
            	
                isApproval = false;

            // ���� �Ұ��� �ϰ� ó��
            fnc_DisableElementAll(oElementList);
            fnc_ChangeStateElement(true, "txtRET_RSN");    //�ݼۻ���
            fnc_ChangeStateElement(true, "txtSPL_YMD");
            fnc_ChangeStateElement(false, "imgSPL_YMD");

            fnc_HiddenElement("btnDEC"      );
            fnc_HiddenElement("btnSave"     );
            fnc_HiddenElement("imgRemove"   );
            fnc_HiddenElement("btnS"        );
            fnc_HiddenElement("btnO"        );
            fnc_HiddenElement("btnR"        );
            //fnc_HiddenElement("btnC"        );       
            //fnc_HiddenElement("btnD"        );         
            fnc_HiddenElement("btnE"        );

            

            		
            		
<%
    //������ ȭ���϶��� �μ��ư ��������
    if(prmTYPE.equals("TYPE3")) {
%>
            //����, ����, ��ǥ
            if( status == "O"|| status == "D"|| status == "E" )
                fnc_ShowElement("imgPrint");
<%
    }
%>

        	if( status == "S" ){        // ���
                fnc_ShowElement("imgRemove" );

                //����϶� ��û�ڶ� �ڽ��̶� ������ ������ ������ �����ϴ�.
                if(document.getElementById("txtENO_NO").value == gusrid){

                    fnc_HiddenElement("btnDEC");
                    fnc_ShowElement("btnS"  );  //��� �Ŀ��� �ٽ� ��� �� �� ����
                    
                }

                if(isApproval) {
                	
    				fnc_ShowElement("btnO"  );
    				fnc_ShowElement("btnR"  );
    				
                }

			}else if( status == "O" ){  // ����

				
			    //������ ������ �־�� �ݼ�, ��ǥ��ư ����
			    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "3200018"  || gusrid == "2070019" ) {


	                //fnc_ShowElement("btnC"  ); //�ݼ�
	                //���縦 �ؾ� �Ǵ� �����̸� �ݼۻ����� �Է°����ϰ�
	                if(prmTYPE == "TYPE3")
	                    fnc_ChangeStateElement(true, "txtRET_RSN");
	
	                

	                
	                //�������� ���� ��� ��ǥ
	                if(dsT_AD_AIDAPP.NameString(dsT_AD_AIDAPP.CountRow, "HLP2_AMT") != "0") {
	                fnc_ShowElement("btnE"  );
	
	                
	                
	                //��ǥó���Ǿ����� �������ڸ� �������ִ�. �������ڰ� �־�� ������ �����ϴ�.
	                fnc_ChangeStateElement(true, "txtSPL_YMD");
	                fnc_ChangeStateElement(true, "imgSPL_YMD");
	
					}else if( status == "R" ){  // �ΰ�
						fnc_ShowElement("btnR"  );    // �ٸ� ������ �ΰ� ó�� �������
	
	
	
	                //�������� ���� ��� ���� ���� �ٷ� ������ �����ϰ�
	                }else {
	                    fnc_ShowElement("btnE"  );
	
	                    //��ǥó���Ǿ����� �������ڸ� �������ִ�. �������ڰ� �־�� ������ �����ϴ�.
	                    fnc_ChangeStateElement(true, "txtSPL_YMD");
	                    fnc_ChangeStateElement(true, "imgSPL_YMD");
	                }

    			}


			}else if( status == "R" ){  // �ΰ�

			    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "3200018"  || gusrid == "2070019") {				
				
					fnc_ShowElement("btnR"  );

    			}



			}else if( status == "C" ){  // �ݼ�


			}else if( status == "D" ){  // ��ǥ

    			//������ ������ �־�� ���޹�ư ����
			    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "3200018"  || gusrid == "2070019") {	
			    	
	                fnc_ShowElement("btnE"  );
	
	                //��ǥó���Ǿ����� �������ڸ� �������ִ�. �������ڰ� �־�� ������ �����ϴ�.
	                fnc_ChangeStateElement(true, "txtSPL_YMD");
	                fnc_ChangeStateElement(true, "imgSPL_YMD");

    			}


			}else if( status == "E" ){  // ����


			}else if( status == "A" ){  // ����
                //fnc_ShowElement("btnDEC"    );
                fnc_HiddenElement("btnDEC"    );
                fnc_ShowElement("btnSave"   );
                fnc_ShowElement("imgRemove" );
                fnc_ShowElement("btnS"      );

				fnc_EnableElementAll(oElementList);
			}
        	
        }


        /********************************************
         * �ֹε�Ϲ�ȣ �ʵ忡�� ��Ŀ�� ������ ��ȿ���� �˻�      *
         ********************************************/
        function checkSSN(){
            // ������ ����
            var ssn = removeChar( document.form1.txtAID_CET.value, "-" ) ;

            var chk = dsT_AD_AIDAPP.NameString(0, "AID_CD");

            if(chk != "AW" && chk != "AO" && chk != "BR" && chk != "AB" && chk != "AC" && chk != "AM" && chk != "AN" && chk != "BC" && chk != "BD"
            			   && chk != "AU" && chk != "AJ" && chk != "BB" && chk != "BF" && chk != "BG"){

	            if( document.form1.txtAID_CET.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){

	                alert("�߸��� �ֹι�ȣ�Դϴ�.");
	                document.form1.txtAID_CET.value = "";
	                document.form1.txtAID_CET.focus();
	            }

            }
            
        }


        /********************************************
         * �ֹε�Ϲ�ȣ �Է½� �ڵ� ������(-) �ֱ�          *
         ********************************************/
        function cfCheckNumber5(){
            if((event.keyCode < 48)||(event.keyCode > 57)){
                if(event.keyCode != 45){
                    event.returnValue=false;
                }
            }
            if( document.form1.txtAID_CET.value.length == 6 ){
                document.form1.txtAID_CET.value += "-";
            }
        }

        /********************************************
         * ÷������ ó��								*
         ********************************************/
		function fnc_FileUpload() {
            if(dsFILE.CountRow == 5) {
                alert("�� �̻� ÷�������� �߰��Ͻ� �� �����ϴ�.");
                return;
            }

            var key = dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition, "FILE_KEY");

            if(key == "") {
                key = "aida011"+(new Date().getTime());
                dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition, "FILE_KEY") = key;
            }

            if(!fnc_AddFileImg(key)) {
                return;
            }
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

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "1", "");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "1", "");
            fnc_SearchEmpNo();
            getRet_ymd();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "1", "");
            if(obj != null && obj.eno_no != "") {
                dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_01&ENO_NO="+obj.eno_no;
                dsVI_T_PERSON.reset();
                
                document.form1.txtLSE_YY.value  = dsVI_T_PERSON.NameValue(1, "LSE_YY");
                document.form1.txtLSE_MM.value  = dsVI_T_PERSON.NameValue(1, "LSE_MM");                
                
                //alert(dsVI_T_PERSON.NameValue(1, "ENO_NO"));
                //alert(dsVI_T_PERSON.NameValue(1, "LSE_YY"));
                //alert(dsVI_T_PERSON.NameValue(1, "LSE_MM"));                
                
            } else {
                document.getElementById("txtREQ_NO").value      = "";
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
                document.getElementById("hidOCC_CD").value      = "";
                document.getElementById("hidJOB_CD").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("hidDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtHIR_YMD").value     = "";
                document.getElementById("txtRET_YMD").value     = "";
                document.getElementById("txtLSE_YY").value      = "";
                document.getElementById("txtLSE_MM").value      = "";
            }
            getRet_ymd();
        }

       function getRet_ymd() {
             //��û������ ����̸�
            if(document.getElementById("cmbAID_CD").value == "AG"){
                //document.getElementById("txtAID_CET").value = document.getElementById("txtCET_NO").value;
                document.getElementById("txtAID_NM").value  = document.getElementById("txtENO_NM").value;
                document.getElementById("txtAID_YMD").value = document.getElementById("txtRET_YMD").value;
            }
            else{
                //document.getElementById("txtAID_CET").value = "";
                document.getElementById("txtAID_NM").value  = "";
                document.getElementById("txtAID_YMD").value = "";

            }
       }

        /**
         * �߻����ڰ� ����Ǿ����� �߻��ϴ� �̺�Ʈ
         */
        function changeAidYmd() {
        	
    	
        	
            var str_ymd = document.getElementById("txtHIR_YMD").value;
            var end_ymd;

            
            //2015.09.17 jys
            //��û������ �ڳ������ ��� �ֹι�ȣ 7�ڸ� �Է�  �������� + ����
            if(document.getElementById("cmbAID_CD").value == "AD"){
            	document.getElementById("txtAID_CET").disabled = false;
            	document.getElementById("txtAID_CET").readOnly = false;
            	if(document.form1.txtAID_CET.value.length<7){
            		alert("�ڳ������ �ֹι�ȣ ������ÿ��� �������+����[��:3,��:4]\n(��:1409143)7�ڸ���  ������ֹι�ȣ ���� �Է��Ͻʽÿ�.");
                }
            }else{
                document.getElementById("txtAID_CET").value="";
                document.getElementById("txtAID_CET").disabled = true;
                document.getElementById("txtAID_CET").readOnly = true;
            }
            /////////////////////////////////////////////////////////            
            
            
            
            //��û������ ����̸�
            if(document.getElementById("cmbAID_CD").value == "AG")
                end_ymd = document.getElementById("txtRET_YMD").value;                //�������
            else
                end_ymd = document.getElementById("txtAID_YMD").value;     //�߻�����

 
            //document.getElementById("txtLSE_YY").value      = "";
            //document.getElementById("txtLSE_MM").value      = "";

			/*
            if(str_ymd == ""
                    || str_ymd == undefined
                    || end_ymd == ""
                    || end_ymd == undefined) {
                return;
            }
			*/

			/*
            dsLSE_YMD.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD"
                             + "&S_MODE=SHR_LSE"
                             + "&STR_YMD="+str_ymd
                             + "&END_YMD="+end_ymd;
            
            dsLSE_YMD.reset();
            */

            
            getAidAmt();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDAPP)			 	   |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 1. ��ȸ�� DataSet								       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDTRF)			 	   |
    | 3. ���Ǵ� Table List(T_AD_AIDTRF) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAMT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_AD_DECISION                     |
    | 3. Table List : T_AD_DECISION                 |
    +----------------------------------------------->
    <Object ID="dsT_AD_DECISION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <Object ID="dsLSE_YMD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDAPP)			       |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	<Object ID="trT_AD_AIDAPP2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ��û���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R1"/>
       <jsp:param name="CODE_GUBUN"    value="R1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �����  -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_BK"/>
       <jsp:param name="CODE_GUBUN"    value="BK"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. ����Ʈ�� DataSet                     		|
    | 2. �̸� : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDAPP.CountRow);

            fnc_EnableElementAll(oElementList);
        }
    </Script>

    <!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó��			   |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AD_AIDAPP event=OnRowPosChanged(row)>
        //�Է� ���ϰ� ����
        fnc_DisableElementAll(oElementList);

        if(row > 0) {
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_AD_AIDAPP.NameValue(row, "FILE_KEY"));

        }
	</script>

	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			
			alert("�ش����� ������ �����ϴ�.");
			
		} else {
			
			// ������� �Է� �� ��û���� ���� �����ϰ� ó��
			document.getElementById("cmbAID_CD").disabled  = false;

			// ��� ���� ����
            document.getElementById("txtREQ_NO").value      = dsVI_T_PERSON.NameValue(0, "REQ_NO");
            document.getElementById("txtENO_NO").value      = dsVI_T_PERSON.NameValue(0, "ENO_NO");
            document.getElementById("txtENO_NM").value      = dsVI_T_PERSON.NameValue(0, "ENO_NM");
            document.getElementById("txtCET_NO").value      = dsVI_T_PERSON.NameValue(0, "CET_NO");
            document.getElementById("hidOCC_CD").value      = dsVI_T_PERSON.NameValue(0, "OCC_CD");
            document.getElementById("hidJOB_CD").value      = dsVI_T_PERSON.NameValue(0, "JOB_CD");
            document.getElementById("txtJOB_NM").value      = dsVI_T_PERSON.NameValue(0, "JOB_NM");
            document.getElementById("hidDPT_CD").value      = dsVI_T_PERSON.NameValue(0, "DPT_CD");
            document.getElementById("txtDPT_NM").value      = dsVI_T_PERSON.NameValue(0, "DPT_NM");
            document.getElementById("txtHIR_YMD").value     = dsVI_T_PERSON.NameValue(0, "HIR_YMD");
            document.getElementById("txtRET_YMD").value     = dsVI_T_PERSON.NameValue(0, "RET_YMD");
            
            document.getElementById("txtREQ_YMD").value = gcurdate;
            
			// ��û�� ����� ���ޱݾ� ��ȸ
            changeAidYmd();

        }
    </Script>

	<Script For=dsT_AD_AIDAMT Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			// ��û����, �ټӳ���� �ش��ϴ� ���ޱݾ��� ������
			// �ټӳ�� �ʵ忡 ���� ������ �ֱ� ���ؼ� 1���� ���� �����ϰ� �Ǿ��ִ�.
			// �Ʒ� else �������� ó�� �ϰ� �Ͽ���.
		} else {
			// �ش� ��û������ ������� ���� �ݾ� ����
			var HLP1_AMT = dsT_AD_AIDAMT.NameValue(0,"HLP1_AMT");
			var HLP2_AMT = dsT_AD_AIDAMT.NameValue(0,"HLP2_AMT");

			document.form1.medHLP1_AMT.Text = HLP1_AMT;
			document.form1.medHLP2_AMT.Text = HLP2_AMT;
			document.form1.medSUM_AMT.Text  = HLP1_AMT+HLP2_AMT;
			document.form1.hidAID_RPT.value = dsT_AD_AIDAMT.NameValue(0,"AID_RPT");

			if( (HLP1_AMT == "" || HLP1_AMT == "0") && (HLP2_AMT == "" || HLP2_AMT == "0") ){
				alert("��û���� ������ ��û������ ���� �ش������ �����ϴ�.");
			}
			
        }
		
    </Script>

    <!-- ������ ���� ��� -->
	<Script For=dsT_AD_DECISION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {

		} else {

            //��û�� ���
            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";
            document.getElementById("txtA3_ENO_NM").innerText   = "";
            document.getElementById("txtA3_APP_STS").innerText  = "";


            for(var i=1; i<=dsT_AD_DECISION.CountRow; i++) {
                document.getElementById("txtA"+i+"_ENO_NM").innerText   = dsT_AD_DECISION.NameString(i, "JOB_NM")+" "+dsT_AD_DECISION.NameString(i, "ENO_NM");
                document.getElementById("txtA"+i+"_APP_STS").innerText  = dsT_AD_DECISION.NameString(i, "APP_YN_NM");
                document.getElementById("txtA"+i+"_ENO_NO").value = dsT_AD_DECISION.NameString(1, "ENO_NO");

            }

            //������ ���� ��ȸ�� ���ѿ� ���� ��ư Ȱ��ȭ
            checkAidStatus();
        }
    </Script>

    <!-- �ټ����ڸ� ��ȸ�� ������ -->
	<Script For=dsLSE_YMD Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {

		} else {
            document.form1.txtLSE_YY.value  = dsLSE_YMD.NameValue(0,"LSE_YY");
            document.form1.txtLSE_MM.value  = dsLSE_YMD.NameValue(0,"LSE_MM");
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsT_AD_AIDAMT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsT_AD_AIDAPP Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_AD_DECISION Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnSuccess()">
	
        //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
        
        if (dsRESULT.Countrow == 1 && dsRESULT.NameString(0, "RESULT_MSG") != "") {
        	
            alert(dsRESULT.NameString(0, "RESULT_MSG"));
            
        } else {
        	
            dsRESULT.ClearData();

            fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

            //���� �� row�� ���� �ʾ����� â�� �ݴ´�.
            if(dsT_AD_AIDAPP.CountRow == 0) {
            	
                window.close();
                
            }

            //���� insert ó�� �������
            dsT_AD_AIDAPP.UseChangeInfo = true;
            dsT_AD_DECISION.UseChangeInfo = true;

            //�ű��϶�(TYPE1) ���λ����� ��û��ȣ�� TYPE �ڵ带 ������ ���� ��ȸ�� �� ó���� �����͸� ������ �´�.
            if(prmTYPE == "TYPE1")  {
                prmREQ_NO   = document.getElementById("txtREQ_NO").value;    //��û��ȣ
                prmTYPE     = "TYPE2";       //"TYPE1" : �ű�, "TYPE2" : ���� ó��, "TYPE3" : ��ǥ, ����ó��
            }

            

            
            fnc_OnLoadProcess();
            
        }
    </script>
    
	<script for=trT_AD_AIDAPP2 event="OnSuccess()">
	
        //���� insert ó�� �������
        dsT_AD_AIDAPP.UseChangeInfo = true;
        dsT_AD_DECISION.UseChangeInfo = true;

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   				       |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>
    
	<script for=trT_AD_AIDAPP2 event="OnFail()">
        alert(trT_AD_AIDAPP2.ErrorMsg);
    </script>

	<!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
    
        if(row > 0) {
        	
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
           
            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
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
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������ݽ�û����</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)" style="cursor:hand;">
                <img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)" style="cursor:hand;">
	            <img src="../../images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)" style="cursor:hand;">
	            <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)" style="cursor:hand;">
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

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

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr height="50">
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>&nbsp;</td>
                    <td align="center" align="right">
                        <div id="procBTN" style="display:none;position:absolute">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left">
                                    <img src="../../images/button/btn_SelectapprovalOn.gif"  	id="btnDEC"     onClick="fnc_btnDEC()" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEC','','../../images/button/btn_SelectapprovalOver.gif',1)" style="cursor:hand;">
                                    <img src="../../images/button/btn_SaveOn.gif"            		id="btnSave"    onClick="fnc_btnDEC();fnc_Save()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnSave','','../../images/button/btn_SaveOver.gif',1)" style="cursor:hand;">
                                    <img src="../../images/button/btn_ReportOn.gif"          		id="btnS"       	onClick="fnc_btnS()"   	border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnS','','../../images/button/btn_ReportOver.gif',1)" style="cursor:hand;">
                                    <img src="../../images/button/btn_ApprovalOn.gif"        	id="btnO"       	onClick="fnc_btnO()"   	border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnO','','../../images/button/btn_ApprovalOver.gif',1)" style="cursor:hand;">
                                    <img src="../../images/button/btn_RejectionOn.gif"       	id="btnR"       	onClick="fnc_btnR()"   	border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnR','','../../images/button/btn_RejectionOver.gif',1)" style="cursor:hand;">
                                </td>
                            </tr>
                            </table>
                        </div>
                        <div id="popupBTN" style="display:none;position:absolute">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left">
                              <!--<img src="../../images/button/btn_SendbackOn.gif"        	id="btnC"       	onClick="fnc_btnC()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnC','','../../images/button/btn_SendbackOver.gif',1)" style="cursor:hand;">
                              		<img src="../../images/button/btn_SlipOn.gif"            		id="btnD"       	onClick="fnc_btnD()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnD','','../../images/button/btn_SlipOver.gif',1)" style="cursor:hand;"> -->
                                    <img src="../../images/button/btn_PaymentOn.gif"         	id="btnE"       	onClick="fnc_btnE()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnE','','../../images/button/btn_PaymentOver.gif',1)" style="cursor:hand;">
                                </td>
                            </tr>
                            </table>
                        </div>
                    </td>
					<td>&nbsp;</td>
					<td align="right">
    					<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse"  bordercolor="#999999" align="right">
        					<tr align="center" height="25">
        						<td rowspan="2" class="blueBold" width="50">����<br>��Ȳ
                                    <input type="hidden" id="txtA1_ENO_NO">
                                    <input type="hidden" id="txtA2_ENO_NO">
                                    <input type="hidden" id="txtA3_ENO_NO">
                                </td>
                                <td id="txtA1_ENO_NM" width="120"></td>
                                <td id="txtA2_ENO_NM" width="120"></td>
                                <td id="txtA3_ENO_NM" width="120"></td>
        					</tr>
        					<tr align="center" height="25">
                                <td id="txtA1_APP_STS"></td>
                                <td id="txtA2_APP_STS"></td>
                                <td id="txtA3_APP_STS"></td>
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
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="80"></col>
				<col width="80"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="blueBold">��û��ȣ</td>
			<td class="padding2423"><input id="txtREQ_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly></td>

            <td align="center" class="blueBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo();">
                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidEMPL_DPT_CD">
            </td>
            <td align="center" class="blueBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm();" onchange="fnc_SearchEmpNm();">
            </td>

			<td align="center" class="blueBold">����</td>
			<td class="padding2423">
				<input id="txtJOB_NM" class="input_ReadOnly" size="10" readonly>
				<input type="hidden" id="hidOCC_CD" value="">
				<input type="hidden" id="hidJOB_CD" value="">
                <input type="hidden" id="hidDPT_CD" value="">
                <input type="hidden" id="hidAID_RPT" value="">
			</td>
			<td align="center" class="blueBold">�μ�</td>
			<td class="padding2423">
				<input id=txtDPT_NM class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">�ֹι�ȣ</td>
			<td class="padding2423"><input id="txtCET_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly></td>
			<td align="center" class="blueBold">�Ի���</td>
			<td class="padding2423"><input id="txtHIR_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="blueBold">�����</td>
			<td class="padding2423"><input id="txtRET_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="blueBold">�ټӳ��</td>
			<td class="padding2423"><input id="txtLSE_YY" class="input_ReadOnly" size="5" style="ime-mode:disabled" readonly></td>
			<td align="center" class="blueBold">�ټӿ���</td>
			<td class="padding2423"><input id="txtLSE_MM" class="input_ReadOnly" size="5" style="ime-mode:disabled" readonly></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="8" height = "50" class="paddingTop8"></td>
	</tr>	
	<tr>
		<td colspan="8" class="paddingTop8"><img src="../../images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> ���������� �߻��ϰ� �� ������� ����, �ֹι�ȣ, �߻�����</td>
	</tr>

	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="80"></col>
				<col width="140"></col>
				<col width="120"></col>
				<col width="140"></col>
				<col width="100"></col>
				<col width="140"></col>
				<col width="100"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="blueBold">��û����</td>
			<td class="padding2423">
				<select id="cmbAID_CD" style="WIDTH: 100%"  onChange="getRet_ymd();changeAidYmd();"></select>
    		</td>


			<td align="center" class="blueBold">������ֹι�ȣ</td>
			<td class="padding2423">
<!--  	  	<input id="txtAID_CET" size="17" maxLength="14" style="ime-mode:disabled" onKeypress="cfCheckNumber5();" onChange="javascript : if (checkSSN(this) == true) {fnc_setMfTag();}" ></td> -->
<!--	        <input id="txtAID_CET" size="17" maxLength="14" style="ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);"></td> -->
			<input type="text" id="txtAID_CET" style="ime-mode:disabled" size="17" maxlength="14" class="input_ReadOnly" readonly></td>


			<td align="center" class="blueBold">����ڼ���</td>
			<td class="padding2423">

			<input id="txtAID_NM" size="17" maxLength="4" style="ime-mode: active"></td>

			<td align="center" class="blueBold">�߻�����</td>
			<td class="padding2423">
				<input type="text" id="txtAID_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);changeAidYmd();" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAID_YMD','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" name="imgAID_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtAID_YMD','','800','150');"></a>
			</td>
		</tr>

		<tr>
			<td align="center" class="blueBold">���⼭��<br>÷��</td>
			<td class="padding2423" colspan="5">
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:60px;">
                    <param name="DataID" value="dsFILE">
                    <param name="Editable" value="false">
                    <param name="DragDropEnable" value="true">
                    <param name="SortView" value="Left">
                    <param name=ViewHeader  value="false">
                    <param name="Format" value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="270"     name="���ϸ�"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)"><img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>

			</td>
			<td align="center" class="blueBold">��û����</td>
			<td class="padding2423"><input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly></td>
		</tr>
		<tr>
			<td align="center" class="blueBold">������</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medHLP1_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode					value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
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
			<td align="center" class="blueBold">������</td>
			<td class="padding2423">
				<table width="100%" border="0" >
				<tr>
					<td width="90%">
					<comment id="__NSID__"><object id="medHLP2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
			</tr>
			</table>
			</td>
			<td align="center" class="blueBold">���ޱݾ�</td>
			<td class="padding2423">
				<table width="100%" border="0" >
				<tr>
					<td width="90%">
						<comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
				<td align="center" class="blueBold">��������</td>
				<td class="padding2423">
				    <input type="text" id="txtSPL_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSPL_YMD','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" name="ImgSPL_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSPL_YMD','','750','300');" disabled=true></a>
				</td>
			</tr>
			<tr>
			<td align="center" class="blueBold">������ȣ</td>
			<td class="padding2423"><input id="txtWORK_NO1" class="input_ReadOnly" size="17" maxLength="3" readonly></td>
			<td align="center" class="blueBold">����</td>
			<td class="padding2423">
                <input type="text" id="txtAID_STS_NM" class="input_ReadOnly" size="17" maxLength="3" readonly>
                <input type="hidden" id="txtAID_STS">
			</td>
			<td align="center" class="blueBold">�ΰ����</td>
				<td class="padding2423" colspan="3"><input id="txtRET_RSN" class="input_ReadOnly" size="31" maxLength="30" ></td>
			</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td colspan="8" height = "50" class="paddingTop8"></td>
		</tr>			
        <tr>
            <td colspan="8" class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <tr>
                    <td>[��û�� ���� - �Ʒ��� ������� �۾��ϼ���]<br><br>
                    &nbsp;&nbsp;1. ��û������ �����ϼ���. <br><br>
                    &nbsp;&nbsp;2. ����� ����� �߻����ڴ� ���������� �߻��ϰ� �� ������� ����� ��¥�Դϴ�.<br><br>
                    &nbsp;&nbsp;3. ��û���� �ش系�� �Է��� ������ ����(������ �ڵ� ����), ��� ��ư�� �����ϴ�.
                    </td>
                </tr>
            </table>
            </td>
        </tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    			value="dsT_RP_REPORT2">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="0">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" 						VALUE="

<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2659 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=26 ,top=601 ,right=1942 ,bottom=601 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1939 ,top=476 ,right=1939 ,bottom=950 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=26 ,top=476 ,right=1939 ,bottom=476 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='������' ,left=1291 ,top=860 ,right=1471 ,bottom=929 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ټӳ��' ,left=1291 ,top=743 ,right=1471 ,bottom=812 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û��' ,left=1294 ,top=624 ,right=1474 ,bottom=693 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���¹�ȣ' ,left=659 ,top=860 ,right=839 ,bottom=929 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=659 ,top=746 ,right=839 ,bottom=815 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=659 ,top=627 ,right=839 ,bottom=696 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ի���' ,left=1289 ,top=505 ,right=1468 ,bottom=574 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1265 ,top=479 ,right=1265 ,bottom=953 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1487 ,top=476 ,right=1487 ,bottom=950 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�߻���' ,left=659 ,top=503 ,right=839 ,bottom=572 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=849 ,top=476 ,right=849 ,bottom=950 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=643 ,top=479 ,right=643 ,bottom=953 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�����' ,left=40 ,top=860 ,right=220 ,bottom=929 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û����' ,left=40 ,top=743 ,right=220 ,bottom=812 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=40 ,top=622 ,right=220 ,bottom=691 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û��ȣ' ,left=37 ,top=505 ,right=217 ,bottom=574 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=476 ,right=26 ,bottom=950 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=688 ,top=352 ,right=116 ,bottom=352 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=688 ,top=339 ,right=116 ,bottom=339 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='Ȯ��' ,left=1582 ,top=201 ,right=1667 ,bottom=249 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1360 ,top=201 ,right=1445 ,bottom=249 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=984 ,top=275 ,right=1069 ,bottom=344 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=196 ,right=1513 ,bottom=413 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1738 ,top=196 ,right=1738 ,bottom=413 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���������� ��û��' ,left=77 ,top=241 ,right=720 ,bottom=318 ,face='����' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=971 ,top=196 ,right=1934 ,bottom=196 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=971 ,top=196 ,right=971 ,bottom=413 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=974 ,top=413 ,right=1937 ,bottom=413 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1077 ,top=257 ,right=1934 ,bottom=257 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1077 ,top=196 ,right=1077 ,bottom=413 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1289 ,top=193 ,right=1289 ,bottom=410 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���' ,left=1135 ,top=201 ,right=1220 ,bottom=249 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1937 ,top=196 ,right=1937 ,bottom=413 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1794 ,top=201 ,right=1879 ,bottom=249 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=839 ,right=1945 ,bottom=839 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=953 ,right=26 ,bottom=953 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=720 ,right=26 ,bottom=720 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=233 ,top=476 ,right=233 ,bottom=950 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1945 ,top=992 ,right=1945 ,bottom=1363 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=963 ,top=995 ,right=963 ,bottom=1365 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=995 ,right=26 ,bottom=995 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1947 ,top=1363 ,right=32 ,bottom=1363 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=26 ,top=992 ,right=26 ,bottom=1363 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=1098 ,right=26 ,bottom=1098 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�� �� ��' ,left=307 ,top=1011 ,right=693 ,bottom=1080 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1267 ,top=1011 ,right=1654 ,bottom=1080 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� �� :' ,left=50 ,top=1193 ,right=437 ,bottom=1262 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� �� �� �� :' ,left=992 ,top=1201 ,right=1378 ,bottom=1270 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=818 ,top=1196 ,right=926 ,bottom=1265 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1794 ,top=1196 ,right=1902 ,bottom=1265 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=2352 ,right=26 ,bottom=2514 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=2355 ,right=26 ,bottom=2355 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1945 ,top=2352 ,right=1945 ,bottom=2514 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=2511 ,right=26 ,bottom=2511 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='���� ���� :' ,left=511 ,top=2402 ,right=852 ,bottom=2471 ,face='����' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=1519 ,right=479 ,bottom=2310 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�� ��' ,left=40 ,top=2204 ,right=206 ,bottom=2273 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1693 ,top=1537 ,right=1924 ,bottom=1606 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1365 ,top=1519 ,right=1365 ,bottom=2310 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='�� �� ��' ,left=1400 ,top=1540 ,right=1630 ,bottom=1609 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1114 ,top=1540 ,right=1344 ,bottom=1609 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڼ���' ,left=823 ,top=1537 ,right=1053 ,bottom=1606 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�߻���' ,left=519 ,top=1537 ,right=749 ,bottom=1606 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û ����' ,left=233 ,top=1537 ,right=463 ,bottom=1606 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='NO' ,left=69 ,top=1535 ,right=177 ,bottom=1603 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ / ������  ���� ��Ȳ' ,left=534 ,top=1429 ,right=1487 ,bottom=1498 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1662 ,top=1519 ,right=1662 ,bottom=2310 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1085 ,top=1516 ,right=1085 ,bottom=2307 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=781 ,top=1519 ,right=781 ,bottom=2310 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=217 ,top=1519 ,right=217 ,bottom=2310 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1939 ,top=2162 ,right=24 ,bottom=2162 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1947 ,top=2051 ,right=32 ,bottom=2051 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=1942 ,right=26 ,bottom=1942 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=1834 ,right=26 ,bottom=1834 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1945 ,top=1728 ,right=29 ,bottom=1728 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1945 ,top=1622 ,right=29 ,bottom=1622 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1945 ,top=1516 ,right=29 ,bottom=1516 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=26 ,top=1408 ,right=26 ,bottom=2312 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1939 ,top=1408 ,right=24 ,bottom=1408 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1945 ,top=1408 ,right=1945 ,bottom=2307 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1942 ,top=2312 ,right=26 ,bottom=2312 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='AID_NM', left=921, top=743, right=1196, bottom=810, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM', left=299, top=624, right=574, bottom=691, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=921, top=627, right=1196, bottom=693, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HIR_YMD', left=1574, top=508, right=1849, bottom=574, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=1572, top=627, right=1847, bottom=693, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LSE_YY', left=1572, top=743, right=1847, bottom=810, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACC_NO', left=855, top=863, right=1257, bottom=929, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REC_NM', left=1574, top=863, right=1849, bottom=929, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AID_YMD', left=918, top=505, right=1193, bottom=572, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQ_NO', left=299, top=503, right=574, bottom=569, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COMM_NM', left=302, top=746, right=577, bottom=812, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ABA_NM', left=299, top=865, right=574, bottom=931, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HLP2_AMT', left=513, top=1196, right=788, bottom=1262, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HLP1_AMT', left=1500, top=1196, right=1775, bottom=1262, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COMM_NM', left=238, top=1640, right=466, bottom=1707, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1' ,left=71 ,top=1638 ,right=180 ,bottom=1707 ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AID_YMD', left=516, top=1643, right=749, bottom=1709, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AID_NM', left=820, top=1643, right=1053, bottom=1709, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HLP2_AMT', left=1111, top=1646, right=1344, bottom=1712, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HLP1_AMT', left=1400, top=1643, right=1632, bottom=1709, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUM_AMT', left=1691, top=1643, right=1924, bottom=1709, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HLP1_AMT', left=1397, top=2204, right=1630, bottom=2270, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUM_AMT', left=1693, top=2204, right=1926, bottom=2270, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HLP2_AMT', left=1106, top=2207, right=1339, bottom=2273, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPL_YMD', left=908, top=2402, right=1556, bottom=2469, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='../../images/common/icon.jpg' ,left=1558 ,top=2535 ,right=1939 ,bottom=2630</I>

	<C>id='NM1', left=1082, top=265, right=1281, bottom=331, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NM2', left=1302, top=265, right=1500, bottom=331, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NM3', left=1527, top=265, right=1725, bottom=331, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS1', left=1082, top=336, right=1281, bottom=402, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS2', left=1302, top=336, right=1500, bottom=402, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APP_STATUS3', left=1527, top=336, right=1725, bottom=402, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


</B>


">
</OBJECT>





</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AD_AIDAPP ���� ���̺� -->
	<object id="bndT_AD_AIDAPP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDAPP">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO			Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO			Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM		Param=value</C>
			<C>Col=AID_YMD		Ctrl=txtAID_YMD		Param=value</C>
			<C>Col=CET_NO			Ctrl=txtCET_NO		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=RET_YMD		Ctrl=txtRET_YMD		Param=value</C>
			<C>Col=OCC_CD			Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=DPT_CD			Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD			Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=LSE_YY			Ctrl=txtLSE_YY			Param=value</C>
			<C>Col=LSE_MM			Ctrl=txtLSE_MM		Param=value</C>
			<C>Col=ABA_CD			Ctrl=cmbABA_CD		Param=value</C>
			<C>Col=ACC_NO			Ctrl=txtACC_NO		Param=value</C>
			<C>Col=REC_NM			Ctrl=txtREC_NM		Param=value</C>
			<C>Col=AID_CD			Ctrl=cmbAID_CD		Param=value</C>
			<C>Col=AID_NM			Ctrl=txtAID_NM			Param=value</C>
			<C>Col=AID_RPT			Ctrl=hidAID_RPT		Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=HLP1_AMT		Ctrl=medHLP1_AMT	Param=text</C>
			<C>Col=HLP2_AMT		Ctrl=medHLP2_AMT	Param=text</C>
			<C>Col=SUM_AMT		Ctrl=medSUM_AMT	Param=text</C>
			<C>Col=WORK_NO1	Ctrl=txtWORK_NO1	Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=AID_STS			Ctrl=txtAID_STS		Param=value</C>
			<C>Col=AID_STS_NM	Ctrl=txtAID_STS_NM	Param=value</C>
			<C>Col=RET_RSN		Ctrl=txtRET_RSN		Param=value</C>
			<C>Col=AID_CET			Ctrl=txtAID_CET		Param=value</C>
			<C>Col=DEC1_NM		Ctrl=txtDEC1_NM		Param=value</C>
			<C>Col=DEC1_YMD		Ctrl=txtDEC1_YMD	Param=value</C>
			<C>Col=DEC2_NM		Ctrl=txtDEC2_NM		Param=value</C>
			<C>Col=DEC2_YMD		Ctrl=txtDEC2_YMD	Param=value</C>
		">
	</object>