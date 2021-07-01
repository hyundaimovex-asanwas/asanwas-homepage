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
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String prmREQ_NO    = request.getParameter("REQ_NO");
    String prmTYPE      = request.getParameter("TYPE"); //"TYPE1" : �ű�, "TYPE2" : ���� ó��, "TYPE3" : ��ǥ, ����ó��
%>

<html>
<head>
	<title>������ݽ�û����(aida011.jsp)</title>
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

	<!-- ÷�� ������ ���� -->
    <jsp:include page="/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

	<script language="javascript">
        /**
         * FLAG status
         *  - "S" : ���
         *  - "O" : ����
         *  - "R" : �ΰ�
         *  - "C" : �ݼ�
         *  - "D" : ��ǥ
         *  - "E" : ����
         */

		var year = getToday().substring(0,4);
		var btnList;
        var prmREQ_NO   = "<%=prmREQ_NO %>";    //��û��ȣ
        var prmTYPE     = "<%=prmTYPE %>";      //"TYPE1" : �ű�, "TYPE2" : ���� ó��, "TYPE3" : ��ǥ, ����ó��

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
            dsRESULT.ClearData();

            trT_AD_AIDAPP2.KeyValue = "shr(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP, O:dsT_AD_DECISION=dsT_AD_DECISION)";
            trT_AD_AIDAPP2.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_04&REQ_NO="+prmREQ_NO;
            trT_AD_AIDAPP2.post();
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
			trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
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
			trT_AD_AIDAPP2.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
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
			var ENO_NO = document.getElementById("txtENO_NO").value;
			var REQ_NO = document.getElementById("txtREQ_NO").value;

            var url = "aida010_PV.jsp?REQ_NO="+REQ_NO+"&ENO_NO="+ENO_NO;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
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

<%
    //�����ڸ� ��û�� ������ ������ ���ִ�.
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
            fnc_ChangeStateElement(true, "txtENO_NO");
            fnc_ChangeStateElement(true, "txtENO_NM");
            fnc_ChangeStateElement(true, "ImgEnoNo");
<%
    }
%>


          //fnc_ShowElement(  "btnDEC"      );  //�����ں��� ��ư
            fnc_HiddenElement(  "btnDEC"      );  //�����ں��� ��ư
            fnc_ShowElement(  "btnSave"     );  //���� ��ư
            fnc_HiddenElement("imgRemove"   );
            fnc_HiddenElement("btnS"        );
            fnc_HiddenElement("btnO"        );
            fnc_HiddenElement("btnR"        );
            fnc_HiddenElement("btnC"        );
            fnc_HiddenElement("btnD"        );
            fnc_HiddenElement("btnE"        );


            // �޺��ڽ� �⺻ ����
            document.form1.cmbAID_CD.selectedIndex = 0;
            //document.form1.cmbABA_CD.selectedIndex = 0;
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
					trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=DEL";
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

            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";

            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";
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

            oElement = document.getElementById("txtAID_CET");
            if(oElement.value == "") {
                alert("������ֹι�ȣ�� ����� �ּ���.");
                oElement.focus();
                return false;
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
            /*
            oElement = document.getElementById("cmbABA_CD");
            if(oElement.value == "") {
                alert("������� ������ �ּ���.");
                oElement.focus();
                return false;
            }
            */
            oElement = document.getElementById("medHLP1_AMT");
            oElement2 = document.getElementById("medHLP2_AMT");
            if(oElement.Text == "0" && oElement2.Text == "0") {
                alert("������, �������� �ϳ��� �Է��ϼž� �˴ϴ�.");
                oElement.focus();
                return false;
            }

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_ConstructCommonCode("dsT_CM_COMMON_R1", "cmbAID_CD");   //��û���� ���� �޺��ڽ�
            //fnc_ConstructCommonCode("dsT_CM_COMMON_BK", "cmbABA_CD");   //����� �޺��ڽ�
			fnc_DisableElementAll(oElementList);                        //����Է�â ���Ƶα�

            //����Է�â�� ���Ƶ�
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");

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
                document.getElementById("txtENO_NO").value = "<%=box.get("SESSION_ENONO") %>";
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
            if(prmTYPE == "TYPE1" || prmTYPE == "TYPE2"){
                layerName = "procBTN";
            }else            if(prmTYPE == "TYPE3"){
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
                                    ,"txtAID_CET"
                                    ,"txtAID_NM"
                                    ,"txtAID_YMD"
                                    //,"cmbABA_CD"
                                    //,"txtREC_NM"
                                    //,"txtACC_NO"
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
        	if(document.form1.txtREQ_YMD.value == '')  { return ; }  // ��û���� ������� ����
        	if(document.getElementById("cmbAID_CD").value == '')  { return ; }  // ��û���� ������� ����


        	// ��ȸ����
        	var ENO_NO  = document.form1.txtENO_NO.value;
        	var LSE_YY  = document.form1.txtLSE_YY.value;
            var REQ_YMD = (document.form1.txtAID_YMD.value == null || document.form1.txtAID_YMD.value.trim() == '') ? (document.form1.txtREQ_YMD.value) : (document.form1.txtAID_YMD.value);
        	var HIR_YMD = document.form1.txtHIR_YMD.value;
        	var AID_CD  = document.form1.cmbAID_CD.value;
            var JOB_CD  = document.getElementById("hidJOB_CD").value;

			// ��û����, �ټӳ�� �� �ش��ϴ� ����������/������ ��ȸ
			dsT_AD_AIDAMT.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_03&ENO_NO="+ENO_NO+"&LSE_YY="+LSE_YY+"&AID_CD="+AID_CD+"&REQ_YMD="+REQ_YMD+"&HIR_YMD="+HIR_YMD+"&JOB_CD="+JOB_CD;
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
         * ������ �ʵ忡�� ��Ŀ�� ������  		     		*
         ********************************************/
	    function checkNAME(){
	    	var eno_nm = document.form1.txtENO_NM.value;
	    	var rec_nm = document.form1.txtREC_NM.value;
	    	var aid_cd = document.form1.cmbAID_CD.value;
	    	// ���ο� ���� ���������� ��� ��û�θ�� �����ָ��� ���� �� ����
	    	if( aid_cd == "AA"){  // ���ΰ�ȥ
	    		if( eno_nm != "" && rec_nm != "" && eno_nm == rec_nm ){
	    			alert("��û�ΰ� �����ְ� ���� �� �����ϴ�.");
	    			document.form1.txtREC_NM.focus();
	    			return;
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
            var appObj = new String;    //������
            var reqObj = new String;    //��û��

            //������ �˻� ������ ��ü   ==> ����������
            appObj = fnc_GetApprover(document.getElementById("txtENO_NO").value, "");
            //reqObj = fnc_GetCommonEnoObj("21008171");
            //appObj = fnc_GetCommonEnoObj("200218");

            //������ ������ ������ �Է� ����
            if(appObj == undefined
                    || appObj.eno_no == undefined
                    || appObj.eno_no == ""
                    || appObj.eno_nm == undefined
                    || appObj.eno_nm == "") {
                    alert("�����ڸ� �����Ͽ� �ֽʽÿ�");
                return;
            }

            document.getElementById("txtA1_ENO_NO").value       = "";
            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_ENO_NO").value       = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";


            //��û�� ����̶� ������ ����� ������ ù��° �����ڿ� �ְ� �ƴϸ� �ƴϸ� �ι�°�� ����
            dsT_AD_DECISION.ClearData();
            if(eno_no == appObj.eno_no) {
                idx = 2;
                dsT_AD_DECISION.AddRow();
            } else {
                idx = 1;
                dsT_AD_DECISION.AddRow();
                dsT_AD_DECISION.AddRow();

                //��û�� ���� ��ȸ
                reqObj = fnc_GetCommonEnoObj(eno_no);
            }


            for(var i = idx, j=1; i<=2; i++, j++) {
                if(i == 1) {
                    obj = reqObj;
                } else {
                    obj = appObj;
                }

                dsT_AD_DECISION.NameValue(j,"ENO_NO")           = obj.eno_no;
                dsT_AD_DECISION.NameValue(j,"ENO_NM")           = obj.eno_nm;
                dsT_AD_DECISION.NameValue(j,"DPT_CD")           = obj.dpt_cd;
                dsT_AD_DECISION.NameValue(j,"JOB_CD")           = obj.job_cd;
                dsT_AD_DECISION.NameValue(j,"ORD_NO")           = document.getElementById("txtREQ_NO").value;

                dsT_AD_DECISION.NameValue(j,"APP_YN")           = "1";
                if(j == 2) {
                    dsT_AD_DECISION.NameValue(j,"APP_YN")       = "2";
                }
                dsT_AD_DECISION.NameValue(j,"AUTHO_CD")         = "A"+i;

                document.getElementById("txtA"+j+"_ENO_NO").value = obj.eno_no;

                document.getElementById("txtA"+j+"_ENO_NM").innerText   = obj.job_nm+" "+obj.eno_nm;
                document.getElementById("txtA"+j+"_APP_STS").innerText  = "�̰�";
            }

        }


 		/********************************************
         * ��� ��ư Ŭ���� ó��                                   		*
         ********************************************/
        function fnc_btnS(){

            var aid_cd = dsT_AD_AIDAPP.NameString(0, "AID_CD");


            //������ ����̶� ��û�� ����� ������ �ٷ� ����� �Ѿ
            if(document.getElementById("txtENO_NO").value == dsT_AD_DECISION.NameString(1, "ENO_NO")) {
                alert("������ ����̶� ��û�� ����� ������ �ٷ� ����� �Ѿ2222222222.");

                //��û ���� ����
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "S"; //���

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();

                fnc_btnO();
				fnc_HiddenElement("btnS");
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
                   alert("������ ����̶� ��û�� ����� ������ �ٷ� ����� �Ѿ.");
                else if(dsT_AD_AIDAPP.CountRow != 0  && aid_cd == "AD")
                   alert("������ ����̶� ��û�� ����� ������ �ٷ� ����� �Ѿ.");

                return;
            }

        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("��� ó���� �ڷᰡ �����ϴ�!");
                return;
            }

            var oCheckList = new Array(  "txtAID_CET"
                                        ,"txtAID_NM"
                                        ,"txtAID_YMD"
//                                        ,"txtREC_NM"
//                                        ,"txtACC_NO"
                                        );

            var oCheckMsgList = new Array(
                                         "������ֹι�ȣ"
                                        ,"����ڼ���"
                                        ,"�߻�����"
//                                        ,"������"
//                                        ,"���¹�ȣ"
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
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
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

                //��û ���� ����
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "O"; //����

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
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
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
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
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
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
					trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=PROC_D"+"&GUBUN="+GUBUN+"&CCTR_CD="+CCTR_CD+"&CCTR_NM="+CCTR_NM+"&ENO_NO="+ENO_NO;;
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
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=PROC_E&SPL_YMD="+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD");
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

            if((dsT_AD_DECISION.NameString(1, "ENO_NO") == "<%=ls_UserId%>" && dsT_AD_DECISION.NameString(1, "APP_YN") == "N") ||
               (dsT_AD_DECISION.NameString(2, "ENO_NO") == "<%=ls_UserId%>" && dsT_AD_DECISION.NameString(2, "APP_YN") == "N"))
                isApproval = true;
            else
                isApproval = false;

            // ���� �Ұ��� �ϰ� ó��
            fnc_DisableElementAll(oElementList);
            fnc_ChangeStateElement(true, "txtRET_RSN");    //�ݼۻ���
            fnc_ChangeStateElement(false, "txtSPL_YMD");
            fnc_ChangeStateElement(false, "imgSPL_YMD");

            fnc_HiddenElement("btnDEC"      );
            fnc_HiddenElement("btnSave"     );
            fnc_HiddenElement("imgRemove"   );
          //  fnc_HiddenElement("imgPrint"    );
            fnc_HiddenElement("btnS"        );
            fnc_HiddenElement("btnO"        );
            fnc_HiddenElement("btnR"        );
            fnc_HiddenElement("btnC"        );
            fnc_HiddenElement("btnD"        );
            fnc_HiddenElement("btnE"        );

<%
    //������ ȭ���϶��� �μ��ư ��������
    if(prmTYPE.equals("TYPE3")) {
%>
            //����, ����, ��ǥ
            if( status == "O"
                    || status == "D"
                    || status == "E" )
                fnc_ShowElement("imgPrint");
<%
    }
%>

        	if( status == "S" ){        // ���
                fnc_ShowElement("imgRemove" );

                //����϶� ��û�ڶ� �ڽ��̶� ������ ������ ������ �����ϴ�.
                if(document.getElementById("txtENO_NO").value == "<%=ls_UserId %>"){
                  //fnc_ShowElement("btnDEC");
                    fnc_HiddenElement("btnDEC");
                    fnc_ShowElement("btnS"  );  //��� �Ŀ��� �ٽ� ��� �� �� ����
                }

                if(isApproval) {
    				fnc_ShowElement("btnO"  );
    				fnc_ShowElement("btnR"  );
                }

			}else if( status == "O" ){  // ����
<%
    //������ ������ �־�� �ݼ�, ��ǥ��ư ����
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>

                fnc_ShowElement("btnC"  ); //�ݼ�
                //���縦 �ؾ� �Ǵ� �����̸� �ݼۻ����� �Է°����ϰ�
                if(prmTYPE == "TYPE3")
                    fnc_ChangeStateElement(true, "txtRET_RSN");

                //�������� ���� ��� ��ǥ
                if(dsT_AD_AIDAPP.NameString(dsT_AD_AIDAPP.CountRow, "HLP2_AMT") != "0") {
                    fnc_ShowElement("btnD"  );

				}else if( status == "R" ){  // �ΰ�
					fnc_ShowElement("btnR"  );    // �ٸ� ������ �ΰ� ó�� �������



                //�������� ���� ��� ���� ���� �ٷ� ������ �����ϰ�
                }else {
                    fnc_ShowElement("btnE"  );

                    //��ǥó���Ǿ����� �������ڸ� �������ִ�. �������ڰ� �־�� ������ �����ϴ�.
                    fnc_ChangeStateElement(true, "txtSPL_YMD");
                    fnc_ChangeStateElement(true, "imgSPL_YMD");
                }
<%
    }
%>

			}else if( status == "R" ){  // �ΰ�
<%
    //������ ������ �־�� �ݼ�, ��ǥ��ư ����
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			fnc_ShowElement("btnR"  );
<%
    }
%>


			}else if( status == "C" ){  // �ݼ�


			}else if( status == "D" ){  // ��ǥ
<%
    //������ ������ �־�� ���޹�ư ����
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
                fnc_ShowElement("btnE"  );

                //��ǥó���Ǿ����� �������ڸ� �������ִ�. �������ڰ� �־�� ������ �����ϴ�.
                fnc_ChangeStateElement(true, "txtSPL_YMD");
                fnc_ChangeStateElement(true, "imgSPL_YMD");
<%
    }
%>

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
            if( document.form1.txtAID_CET.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){
                alert("�߸��� �ֹι�ȣ�Դϴ�.");
                document.form1.txtAID_CET.value = "";
                document.form1.txtAID_CET.focus();
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
                dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_01&ENO_NO="+obj.eno_no;
                dsVI_T_PERSON.reset();
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
                document.getElementById("txtAID_CET").value = document.getElementById("txtCET_NO").value;
                document.getElementById("txtAID_NM").value  = document.getElementById("txtENO_NM").value;
                document.getElementById("txtAID_YMD").value = document.getElementById("txtRET_YMD").value;
            }
            else{
                document.getElementById("txtAID_CET").value = "";
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

            //��û������ ����̸�
            if(document.getElementById("cmbAID_CD").value == "AG")
                end_ymd = document.getElementById("txtRET_YMD").value;                //�������
            else
                end_ymd = document.getElementById("txtAID_YMD").value;     //�߻�����


            document.getElementById("txtLSE_YY").value      = "";
            document.getElementById("txtLSE_MM").value      = "";

            if(str_ymd == ""
                    || str_ymd == undefined
                    || end_ymd == ""
                    || end_ymd == undefined) {
                return;
            }

            dsLSE_YMD.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD"
                             + "&S_MODE=SHR_LSE"
                             + "&STR_YMD="+str_ymd
                             + "&END_YMD="+end_ymd;
            dsLSE_YMD.reset();

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
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R1"/>
       <jsp:param name="CODE_GUBUN"    value="R1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �����  -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_BK"/>
       <jsp:param name="CODE_GUBUN"    value="BK"/>
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
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
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

            //���� �Ϸᰡ ���� �ʾҰų� �����Ⱓ �̸�
//            if(dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "0"
//                    && dsT_SC_SCHLBOOK.NameValue(row, "IS_MOD") == "1") {
//                //���������ϰ� â Ǯ�� ����
//                fnc_EnableElementAll(oElementList);
//            }
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

            //�������� �ֱ�
            //document.getElementById("cmbABA_CD").value      = dsVI_T_PERSON.NameValue(0, "ABA_CD");
            //document.getElementById("txtACC_NO").value      = dsVI_T_PERSON.NameValue(0, "ACC_NO");
            //document.getElementById("txtREC_NM").value      = dsVI_T_PERSON.NameValue(0, "REC_NAM");

            document.getElementById("txtREQ_YMD").value = getToday();

			// ��û�� ����� ���ޱݾ� ��ȸ
            changeAidYmd();
 			//getAidAmt();
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

			// �ٷα��� ��� ���ڸ� 3:����� 	//����� ������ �޿����������Ƿ� ���޾���
            if (document.getElementById("txtENO_NO").value.substr(0,1)  == "3") {
					document.form1.medHLP1_AMT.Text = 0;
					document.form1.medSUM_AMT.Text  = HLP2_AMT;
                }
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

/*           var aid_cd = dsT_AD_AIDAPP.NameString(0, "AID_CD");
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
                alert("����������� �������������� �濵������ ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
            else if(dsT_AD_AIDAPP.CountRow != 0  && aid_cd == "AD")
                alert("����������� �ֹε�ϵ�� �濵������ ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
            else
                alert("ó���� �Ϸ�Ǿ����ϴ�.");    */

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ݽ�û����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�������/<font color="#000000">������ݽ�û����</font></td>
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
	            <img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)" style="cursor:hand;">
				<img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)" style="cursor:hand;">
                <img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)" style="cursor:hand;">
	            <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)" style="cursor:hand;">
	            <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)" style="cursor:hand;">
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
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
    <!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
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
                                    <img src="/images/button/btn_SelectapprovalOn.gif"  id="btnDEC"     onClick="fnc_btnDEC()" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEC','','/images/button/btn_SelectapprovalOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_SaveOn.gif"            id="btnSave"    onClick="fnc_btnDEC();fnc_Save()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnSave','','/images/button/btn_SaveOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_ReportOn.gif"          id="btnS"       onClick="fnc_btnS()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnS','','/images/button/btn_ReportOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_ApprovalOn.gif"        id="btnO"       onClick="fnc_btnO()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnO','','/images/button/btn_ApprovalOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_RejectionOn.gif"       id="btnR"       onClick="fnc_btnR()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnR','','/images/button/btn_RejectionOver.gif',1)" style="cursor:hand;">
                                </td>
                            </tr>
                            </table>
                        </div>
                        <div id="popupBTN" style="display:none;position:absolute">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left">
                                    <img src="/images/button/btn_SendbackOn.gif"        id="btnC"       onClick="fnc_btnC()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnC','','/images/button/btn_SendbackOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_SlipOn.gif"            id="btnD"       onClick="fnc_btnD()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnD','','/images/button/btn_SlipOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_PaymentOn.gif"         id="btnE"       onClick="fnc_btnE()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnE','','/images/button/btn_PaymentOver.gif',1)" style="cursor:hand;">
                                </td>
                            </tr>
                            </table>
                        </div>
                    </td>
					<td>&nbsp;</td>
					<td align="right">
    					<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse"  bordercolor="#999999" align="right">
        					<tr align="center" height="25">
        						<td rowspan="2" class="creamBold" width="50">����<br>��Ȳ
                                    <input type="hidden" id="txtA1_ENO_NO">
                                    <input type="hidden" id="txtA2_ENO_NO">
                                </td>
                                <td id="txtA1_ENO_NM" width="120"></td>
                                <td id="txtA2_ENO_NM" width="120"></td>
        					</tr>
        					<tr align="center" height="25">
                                <td id="txtA1_APP_STS"></td>
                                <td id="txtA2_APP_STS"></td>
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
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="100"></col>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="60"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="creamBold">��û��ȣ</td>
			<td class="padding2423"><input id="txtREQ_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly></td>

            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo();">
                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidEMPL_DPT_CD">
            </td>
            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm();" onchange="fnc_SearchEmpNm();">
            </td>

			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<input id="txtJOB_NM" class="input_ReadOnly" size="10" readonly>
				<input type="hidden" id="hidOCC_CD" value="">
				<input type="hidden" id="hidJOB_CD" value="">
                <input type="hidden" id="hidDPT_CD" value="">
                <input type="hidden" id="hidAID_RPT" value="">
			</td>
			<td align="center" class="creamBold">�μ�</td>
			<td class="padding2423">
				<input id=txtDPT_NM class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">�ֹι�ȣ</td>
			<td class="padding2423"><input id="txtCET_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">�Ի���</td>
			<td class="padding2423"><input id="txtHIR_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">�����</td>
			<td class="padding2423"><input id="txtRET_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">�ټӳ��</td>
			<td class="padding2423"><input id="txtLSE_YY" class="input_ReadOnly" size="5" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">�ټӿ���</td>
			<td class="padding2423"><input id="txtLSE_MM" class="input_ReadOnly" size="5" style="ime-mode:disabled" readonly></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="8" class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> ���������� �߻��ϰ� �� ������� ����, �ֹι�ȣ, �߻�����</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="60"></col>
				<col width="110"></col>
				<col width="100"></col>
				<col width="110"></col>
				<col width="80"></col>
				<col width="110"></col>
				<col width="80"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="creamBold">��û����</td>
			<td class="padding2423">
				<select id="cmbAID_CD" style="WIDTH: 100%"  onChange="getRet_ymd();changeAidYmd();"></select>
    		</td>
			<td align="center" class="creamBold">������ֹι�ȣ</td>
			<td class="padding2423"><input id="txtAID_CET" size="17" maxLength="14" style="ime-mode:disabled" onKeypress="cfCheckNumber5();"></td>
			<td align="center" class="creamBold">����ڼ���</td>
			<td class="padding2423"><input id="txtAID_NM" size="17" maxLength="4"></td>
			<td align="center" class="creamBold">�߻�����</td>
			<td class="padding2423">
				<input type="text" id="txtAID_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);changeAidYmd();" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAID_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgAID_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtAID_YMD','','595','100');"></a>
			</td>
		</tr>
		<!--
		<tr>
			<td align="center" class="creamBold">�����</td>
			<td class="padding2423">
				<select id="cmbABA_CD" style="WIDTH: 100%"></select>
			</td>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423"><input id="txtREC_NM"size="17" maxLength="4" onFocusOut="checkNAME();"></td>
			<td align="center" class="creamBold">���¹�ȣ</td>
			<td class="padding2423"><input id="txtACC_NO"size="17" maxLength="18" style="ime-mode:disabled"  onkeypress="cfCheckNumber();"></td>
			<td align="center" class="creamBold">��û����</td>
			<td class="padding2423"><input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly></td>
		</tr>
		-->
		<tr>
			<td align="center" class="creamBold">���⼭��<br>÷��</td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>

			</td>
			<td align="center" class="creamBold">��û����</td>
			<td class="padding2423"><input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly></td>
		</tr>
		<tr>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medHLP1_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423">
				<table width="100%" border="0" >
				<tr>
					<td width="90%">
					<comment id="__NSID__"><object id="medHLP2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">���ޱݾ�</td>
			<td class="padding2423">
				<table width="100%" border="0" >
				<tr>
					<td width="90%">
						<comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment				value=2>
							<param name=Border					value=true>
							<param name=ClipMode				value=true>
							<param name=DisabledBackColor		value="#EEEEEE">
							<param name=Enable					value=true>
							<param name=IsComma					value=true>
							<param name=Language				value=0>
							<param name=MaxLength				value=9>
							<param name=Numeric					value=true>
							<param name=NumericRange			value=0~+:0>
							<param name=ShowLiteral				value=false>
							<param name=Visible					value=true>
							<param name=ReadOnly 				value=true>
							</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						</td>
						<td align="left">��</td>
					</tr>
					</table>
				</td>
				<td align="center" class="creamBold">��������</td>
				<td class="padding2423">
				    <input type="text" id="txtSPL_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSPL_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="ImgSPL_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSPL_YMD','','595','170');" disabled=true></a>
				</td>
			</tr>
			<tr>
			<td align="center" class="creamBold">������ȣ</td>
			<td class="padding2423"><input id="txtWORK_NO1" class="input_ReadOnly" size="17" maxLength="3" readonly></td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423">
                <input type="text" id="txtAID_STS_NM" class="input_ReadOnly" size="17" maxLength="3" readonly>
                <input type="hidden" id="txtAID_STS">
			</td>
			<td align="center" class="creamBold">�ΰ����</td>
				<td class="padding2423" colspan="3"><input id="txtRET_RSN" class="input_ReadOnly" size="31" maxLength="15" ></td>
			</tr>
			</table>
			</td>
		</tr>
        <tr>
            <td colspan="8" class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <tr>
                    <td>[��û�� ���� - �Ʒ��� ������� �۾��ϼ���]<br>
                    &nbsp;&nbsp;1. ��û������ �����ϼ���. <br>
                    &nbsp;&nbsp;2. ����� ����� �߻����ڴ� ���������� �߻��ϰ� �� ������� ����� ��¥�Դϴ�.<br>
                    &nbsp;&nbsp;3. ��û���� �ش系�� �Է��� ������ ���� -������ ����(���� ����) - ��� ��ư�� �����ϴ�.
                    </td>
                </tr>
            </table>
            </td>
        </tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->

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
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=AID_YMD		Ctrl=txtAID_YMD		Param=value</C>
			<C>Col=CET_NO		Ctrl=txtCET_NO		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=RET_YMD		Ctrl=txtRET_YMD		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=LSE_YY		Ctrl=txtLSE_YY		Param=value</C>
			<C>Col=LSE_MM		Ctrl=txtLSE_MM		Param=value</C>
			<C>Col=ABA_CD		Ctrl=cmbABA_CD		Param=value</C>
			<C>Col=ACC_NO		Ctrl=txtACC_NO		Param=value</C>
			<C>Col=REC_NM		Ctrl=txtREC_NM		Param=value</C>
			<C>Col=AID_CD		Ctrl=cmbAID_CD		Param=value</C>
			<C>Col=AID_NM		Ctrl=txtAID_NM		Param=value</C>
			<C>Col=AID_RPT		Ctrl=hidAID_RPT		Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=HLP1_AMT		Ctrl=medHLP1_AMT	Param=text</C>
			<C>Col=HLP2_AMT		Ctrl=medHLP2_AMT	Param=text</C>
			<C>Col=SUM_AMT		Ctrl=medSUM_AMT		Param=text</C>
			<C>Col=WORK_NO1		Ctrl=txtWORK_NO1	Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=AID_STS		Ctrl=txtAID_STS		Param=value</C>
			<C>Col=AID_STS_NM	Ctrl=txtAID_STS_NM	Param=value</C>
			<C>Col=RET_RSN		Ctrl=txtRET_RSN		Param=value</C>
			<C>Col=AID_CET		Ctrl=txtAID_CET		Param=value</C>
			<C>Col=DEC1_NM		Ctrl=txtDEC1_NM		Param=value</C>
			<C>Col=DEC1_YMD		Ctrl=txtDEC1_YMD	Param=value</C>
			<C>Col=DEC2_NM		Ctrl=txtDEC2_NM		Param=value</C>
			<C>Col=DEC2_YMD		Ctrl=txtDEC2_YMD	Param=value</C>
		">
	</object>