
<!--*************************************************************************
	* @source      : taxa250.jsp												*
	* @description : �ҵ��������û PAGE 												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/20            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%
	//������ 'IT' �̰ų� '�渮��' �̸� ������ ������ ������.
	boolean isMaster = false;
	if (box.getString("SESSION_ROLE_CD").equals("1001")
			|| box.getString("SESSION_ROLE_CD").equals("1010")) {
		isMaster = true;
	}
%>

<html>
<head>
<title>�ҵ��������û(taxa250)</title>
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

		var btnList = 'TTFTFTTT';
		var today = getToday();
        var trTypeMsg = "";


		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.form1.txtSTR_YMD_SHR.value;
			var END_YMD_SHR = document.form1.txtEND_YMD_SHR.value;
			var CEF_SEC_SHR = document.form1.cmbCEF_SEC_SHR.value;
			var CEF_STS_SHR = document.form1.cmbCEF_STS_SHR.value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;

            if(ENO_NO_SHR == "") {
                alert("����� ��� �ֽ��ϴ�. ����� �Է��� �ּ���.");
                document.getElementById("txtENO_NO_SHR").focus();
                return;
            }

			dsT_AC_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&CEF_STS_SHR="+CEF_STS_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_AC_CEFBOOK.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�						        *
         ********************************************/
        function fnc_Save(sts) {
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_RSN = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN");  //�뵵


            //�̹� ����������� ó���� �Ǿ� �ִٸ� ���̻� �μ⸦ ���ϰ� ����
            if(CEF_STS == "F"
                    && dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'SPL_YMD') != "") {
                alert("���̻� ��� �Ͻ� �� �����ϴ�.\n�ű� ��û �� ��� �Ͻʽÿ�.");
                return;
            }

            //���� ����� �ϸ鼭 ��ư�� ���� ����
            if(CEF_STS == "F")
                fnc_HiddenElement("btnF");      //�������

			dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'CEF_STS') = sts;
			if(sts == "F" || sts == "E"){
				dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'SPL_YMD') = today;
			}

			if ( !fnc_SaveItemCheck() ) {
				return;
			}


            //��� �޼����� ��� �ϱ� ����
            if(sts == "A")
                trTypeMsg = "����"
            else if(sts == "B")
                trTypeMsg = "���ν�û"
            else if(sts == "F")
                trTypeMsg = "�������"

            //������ ������� ����Ʈ�� ������ ����
            document.getElementById("txtENO_NO_SHR").value = dsT_AC_CEFBOOK.NameString(dsT_AC_CEFBOOK.RowPosition, "ENO_NO");
            document.getElementById("txtENO_NM_SHR").value = dsT_AC_CEFBOOK.NameString(dsT_AC_CEFBOOK.RowPosition, "ENO_NM");

			// save
			trT_AC_CEFBOOK.KeyValue = "tr01(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
			trT_AC_CEFBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SAV";
			trT_AC_CEFBOOK.post();

			fnc_ChangeStateElement(false, "txtSTR_YY");  //�ͼӳ⵵ ��Ȱ��ȭ

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
            if(dsT_AC_CEFBOOK.RowPosition == "0") return;

            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_CNT = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_CNT");  //�߱޸ż�
            var CEF_RSN = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN");  //�߱޻���
            var REQ_NO  = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");   //�߱޹�ȣ

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var STR_YMD  = document.getElementById("txtREQ_YMD").value;
            var STR_YY  = document.getElementById("txtSTR_YY").value;

            var STR_YM  = document.getElementById("txtCEF_YY").value;
			var DPT_CD ="";
            if(CEF_STS != "E" && CEF_STS != "F") {
                alert("���°� �߱��̳� ��������� �ƴϸ� ����Ͻ� �� �����ϴ�.");
                return;
            }
        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("�μ��Ͻ� ������ �����ϴ�.");
                return;
            }

			//01^�ٷμҵ��õ¡�� ������,02^�ٷμҵ��õ¡����,03^�����ҵ��õ¡�� ������,04^���ټ���õ¡������
			if(CEF_SEC == "01"){  //�ٷμҵ��õ¡�� ������
				var url = "taxa160_PV.jsp"
	                    + "?PIS_YY="+STR_YY   //����⵵
	                    + "&ENO_NO="+ENO_NO     //���
	                    + "&DPT_CD="+DPT_CD 		//�μ��ڵ�
	                    + "&STR_YMD="+STR_YMD	//��û����
	                    + "&CEF_CNT="+CEF_CNT
	                    + "&TYPE=E&STP_GBN=1&TAX_GBN=8&PRT_GBN=1&CHK_OCC=ALL"
	                    + "&SEND_PARM=2";

	                    //+ "&TYPE="+TYPE			//������ E : ������� ��� �Ѵ�.
	                    //+ "&STP_GBN="+STP_GBN	//������� ���� : ������ ������� : 1
	                    //+ "&TAX_GBN="+TAX_GBN   //���걸��:1��������
	                    //+ "&PRT_GBN="+PRT_GBN   //���� ����(������ 1: �ҵ���,������)
	                    //+ "&CHK_OCC="+CHK_OCC;  //�ٷα��б���(���⼭�� ���ǹ�)
            }else if(CEF_SEC == "02"){  //�ٷμҵ� ��õ¡����

                var url = "taxa080_PV.jsp"
                    + "?PIS_YY="+STR_YY
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                    + "&CEF_CNT="+CEF_CNT
                    + "&TYPE=1"
                    + "&SEND_PARM=2";

            }else if(CEF_SEC == "03"){  //�����ҵ� ��õ¡��������

            	var url = "taxa170_PV.jsp"
                    + "?PIS_YM="+STR_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&STP_GBN=1"//+STP_GBN
                    + "&CEF_CNT="+CEF_CNT
                    + "&PRT_GBN=1"//+PRT_GBN;


            }else if(CEF_SEC == "04"){  //���ټ� ����

				var url = "taxa180_PV.jsp"
                    + "?PIS_YY="+STR_YM.replace("-","")
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                     + "&CEF_CNT="+CEF_CNT
//                    + "&JOB_CD="+JOB_CD
                    + "&IS_YEAR_AMT=Y"//+IS_YEAR_AMT
                    + "&SEND_PARM=2";
                   // + "&DOC1="+DOC1
                   // + "&DOC2="+DOC2
                   // + "&DOC3="+DOC3;

            }
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_CEFBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AC_CEFBOOK.GridToExcel("�ҵ��������û", '', 225)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
      			if (dsT_AC_CEFBOOK.CountColumn == 0) {
				dsT_AC_CEFBOOK.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, ENO_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, PER_ADR:STRING, ADDRESS:STRING, CEF_SEC:STRING, CEF_CNT:STRING, CEF_RSN:STRING, CEF_STS:STRING, CEF_STS_NM:STRING, REQ_YMD:STRING, CEF_NO:STRING, SPL_YMD:STRING, PRT_YMD:STRING, REMARK:STRING, CEF_YY:STRING, STR_YY:STRING");
			}

            for(var i=1; i<=dsT_AC_CEFBOOK.CountRow; i++) {
                if(dsT_AC_CEFBOOK.RowStatus(i) == "1") {
                    alert("�̹� �űԽ�û���� �ֽ��ϴ�. ���� �� ����ϼ���.");
                    return;
                }
            }

			// �� �߰�
			dsT_AC_CEFBOOK.AddRow();

            //��� ���� ã�ƿͼ� �ֱ�
            document.getElementById("txtENO_NO").value = document.getElementById("txtENO_NO_SHR").value;
            fnc_SearchEmpNo();

			document.form1.cmbCEF_RSN.selectedIndex = 0;
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_YMD") = today;
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS") = "A";
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS_NM") = "�ű�";
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC") = "01";
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_YY") = getTodayArray()[0]+"-"+getTodayArray()[1];
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "STR_YY") = getTodayArray()[0]-1;

            fnc_ChangeStateElement(false, "txtSTR_YY");  //�ͼӳ⵵ ��Ȱ��ȭ
            //�ͼӳ⵵ �ʱⰪ ����
            document.getElementById("txtSTR_YY").value = today.substring(0,4); // 2009�� 12�� ���� today.substring(0,4)-1
            fnc_HiddenElement("img_spinup");//��ȭ��ǥ ����
            fnc_HiddenElement("img_spindown");//�Ʒ� ȭ��ǥ ����

            //�뵵�� ��Ÿ�϶� ������ Ȱ��ȭ �Լ� ȣ��
            fnc_Searchcmb();
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
			if (dsT_AC_CEFBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
                // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
                var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");

                //����� ��û ���� �϶��� ������ ����
                if(!(CEF_STS == "A" || CEF_STS == 'B')) {
                    alert("���°� �����̰ų� ��û�϶��� ������ �����մϴ�.");
                    return;
                }

           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "��Ϲ�ȣ = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO")+"\n";
            	tmpMSG += "���       = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "����       = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "����    = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN")+"\n";

	            if( confirm(tmpMSG) ){
					var REQ_NO = dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");

					dsT_AC_CEFBOOK.DeleteRow(dsT_AC_CEFBOOK.RowPosition);

                    //��� �޼����� �Ѹ��� ����
                    trTypeMsg = "����";

					// �Ķ���� �߰�
					trT_AC_CEFBOOK_DEL.Parameters = "REQ_NO="+REQ_NO;

					trT_AC_CEFBOOK_DEL.KeyValue = "tr01(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
					trT_AC_CEFBOOK_DEL.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=DEL";
					trT_AC_CEFBOOK_DEL.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
            document.getElementById("txtCEF_CNT").value = "";
            document.getElementById("cmbCEF_SEC_SHR").selectedIndex = 0;
            document.getElementById("cmbCEF_STS_SHR").selectedIndex = 0;
            document.getElementById("cmbCEF_RSN").selectedIndex = 0;
            document.getElementById("rdoCEF_SEC").CodeValue = "10";

        	document.getElementById("resultMessage").innerText = ' ';
        	fnc_DisableElementAll(elementList);

        	dsT_AC_CEFBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_AC_CEFBOOK.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
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
  			if ( !dsT_AC_CEFBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

            for(var i=1; i<=dsT_AC_CEFBOOK.CountRow; i++) {
                if(dsT_AC_CEFBOOK.NameString(i, "CEF_CNT") == 0) {
                    alert("�ż��Է��� �ʼ� �Է»����Դϴ�.");
                    dsT_AC_CEFBOOK.RowPosition == i;

                    document.getElementById("txtCEF_CNT").focus();
                    return false;
                }
            }

            if(document.getElementById("rdoCEF_SEC").CodeValue == 02){
               document.getElementById("hidHIR_YMD").value = "20050701";
               var HIR_YMD = document.getElementById("hidHIR_YMD").value;

               var STR_YY = document.getElementById("txtSTR_YY").value.substring(0,4);

               if(HIR_YMD>STR_YY){
                   alert(HIR_YMD + " > "+STR_YY+"�Ի�⵵���� ������¥�� �����Ͻ� �� �����ϴ�. ��� �� �ٽ� ������ �ֽʽÿ�.");
                   fnc_DisableElementAll(elementList);
                   fnc_HiddenElement("btnA");      //����
                   fnc_HiddenElement("btnB");      //���ν�û
                   fnc_HiddenElement("btnF");      //�������
                   return false;
               }
            }

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {


            // �뵵 ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_R4.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_R4.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_R4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_RSN").add(oOption);

			}


            // ���� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_AC.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_AC.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_AC.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_SEC_SHR").add(oOption);
			}

			fnc_DisableElementAll(elementList);
            fnc_HiddenElement("btnA");      //����
            fnc_HiddenElement("btnB");      //���ν�û
            fnc_HiddenElement("btnF");      //�������

            document.getElementById("changeDate_01").style.display = "";
            document.getElementById("changeDate_02").style.display = "none";


			cfStyleGrid(form1.grdT_AC_CEFBOOK,15,"false","false");      // Grid Style ����


            document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.getString("SESSION_ENONM") %>";
            document.getElementById("hidHIR_YMD").value = "20050701";
            alert("hidHIR_YMD = "+ document.getElementById("hidHIR_YMD").value)
            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getToday();

            //�ͼӳ⵵ �ʱⰪ ����
            document.getElementById("txtSTR_YY").value = today.substring(0,4);  // 2009�� 12�� ���� today.substring(0,4)-1
            fnc_HiddenElement("img_spinup");//��ȭ��ǥ ����
            fnc_HiddenElement("img_spindown");//�Ʒ� ȭ��ǥ ����

<%
    //IT �����ڳ�  �渮 ������ �̸� ������� �˻��ϰ� �Ϲ������̸� ������� �˻����ϰ� ����
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

            document.getElementById("rdoCEF_SEC").Format = "01^�ٷμҵ��õ¡��������,02^�ٷμҵ��õ¡����,04^���ټ���õ¡������";
<%
    }
%>
            var hir_ymd = document.getElementById("hidHIR_YMD").value.substring(0,4);
            if(hir_ymd == today.substring(0,4)){
                   document.getElementById("rdoCEF_SEC").Format = "02^�ٷμҵ��õ¡����,04^���ټ���õ¡������";
             }

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
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

        //�Է� element��
        var elementList = new Array(     "txtHIR_CNT"
                                        ,"txtEXP_CNT"
                                        ,"txtRET_CNT"
                                        ,"txtCAR_CNT"
                                   //   ,"txtREMARK"     //Ȱ��ȭ
                                        ,"rdoCEF_SEC"
                                        ,"txtCEF_CNT"
                                        ,"cmbCEF_RSN"
                                        ,"txtCEF_YY"
                                        ,"txtSTR_YY"
                                        ,"img_spinup"
                                        ,"img_spindown"
                                        ,"btnPrintCef"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'1','');

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'1','');
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'1','');

            if(obj != null && obj.eno_no != "") {
                dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SHR_02&ENO_NO="+obj.eno_no;
                dsVI_T_PERSON.reset();
            } else {
                document.getElementById("txtENO_NO" ).value = "";
                document.getElementById("txtENO_NM" ).value = "";
                document.getElementById("txtPER_ADR").value = "";
                document.getElementById("txtADDRESS").value = "";
                document.getElementById("hidDPT_CD" ).value = "";
                document.getElementById("txtDPT_NM" ).value = "";
                document.getElementById("hidJOB_CD" ).value = "";
                document.getElementById("txtJOB_NM" ).value = "";
                document.getElementById("hidHIR_YMD").value = "";
            }
        }


        /********************************************
         * 17. ��Ÿ�Լ�                 			*
         ********************************************/
       //�뵵�� ��Ÿ�϶� ������ Ȱ��ȭ �Ѵ�.
        function fnc_Searchcmb(){
        	if(document.getElementById("cmbCEF_RSN" ).value=='19'){
        	    fnc_ChangeStateElement(true, "txtREMARK");  //Ȱ��ȭ
        	}
        	else{
        	    fnc_ChangeStateElement(false, "txtREMARK");  //Ȱ��ȭ
        	}
        }

    </script>
</head>

<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_CEFBOOK)			   |
    | 3. ���Ǵ� Table List(T_AC_CEFBOOK) 			 	   |
    +------------------------------------------------------>
<Object ID="dsT_AC_CEFBOOK"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_CEFBOOK_UPT"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>


<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�ּ�)							       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
<Object ID="dsVI_T_PERSON"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_CEFBOOK)			   |
    | 3. ���Ǵ� Table List(T_AC_CEFBOOK)				   |
    +------------------------------------------------------>
<Object ID="trT_AC_CEFBOOK"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_CEFBOOK_DEL"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<!-- ���� �޺��� ���� DataSet -->
<!-- �뵵 ���� -->
<jsp:include page="/common/gauceDataSet.jsp" flush="true">
	<jsp:param name="DATASET_ID" value="dsT_CM_COMMON_R4" />
	<jsp:param name="CODE_GUBUN" value="R4" />
	<jsp:param name="SYNCLOAD" value="false" />
	<jsp:param name="USEFILTER" value="false" />
</jsp:include>

<!-- ���� ���� -->
<jsp:include page="/common/gauceDataSet.jsp" flush="true">
	<jsp:param name="DATASET_ID" value="dsT_CM_COMMON_AC" />
	<jsp:param name="CODE_GUBUN" value="AC" />
	<jsp:param name="SYNCLOAD" value="false" />
	<jsp:param name="USEFILTER" value="false" />
</jsp:include>


<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
<Script For=dsT_AC_CEFBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_CEFBOOK.CountRow);
        }
    </Script>

<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("�ش����� ������ �����ϴ�.");
		} else {
			// ������� �Է� �� �߰����� �Է� �����ϰ� ó��

			// ��� ���� ����
			document.getElementById("txtENO_NO" ).value =   dsVI_T_PERSON.NameValue(0,"ENO_NO");
			document.getElementById("txtENO_NM" ).value =   dsVI_T_PERSON.NameValue(0,"ENO_NM");
			document.getElementById("txtPER_ADR").value =   dsVI_T_PERSON.NameValue(0,"PER_ADR");
			document.getElementById("txtADDRESS").value =   dsVI_T_PERSON.NameValue(0,"ADDRESS");
			document.getElementById("hidDPT_CD" ).value =   dsVI_T_PERSON.NameValue(0,"DPT_CD");
			document.getElementById("txtDPT_NM" ).value =   dsVI_T_PERSON.NameValue(0,"DPT_NM");
            document.getElementById("hidJOB_CD" ).value =   dsVI_T_PERSON.NameValue(0,"JOB_CD");
			document.getElementById("txtJOB_NM" ).value =   dsVI_T_PERSON.NameValue(0,"JOB_NM");
			document.getElementById("hidHIR_YMD").value =   dsVI_T_PERSON.NameValue(0,"HIR_YMD");
        }
    </Script>

<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
<Script For=dsT_AC_CEFBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
<Script For=dsT_AC_CEFBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
<script for=trT_AC_CEFBOOK event="OnSuccess()">
        var REQ_NO = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");
        var CEF_STS;
        var rowIndex;

        fnc_SearchList();

        //�Է��� ��û��ȣ�� ������ Row�� �̵�
        rowIndex = dsT_AC_CEFBOOK.NameValueRow("REQ_NO", REQ_NO);
        if(rowIndex > 0) {
            dsT_AC_CEFBOOK.RowPosition = rowIndex;
            CEF_STS = dsT_AC_CEFBOOK.NameValue(rowIndex, "CEF_STS");
        }

        //�޼��� �Ѹ���
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        if(trTypeMsg == "����")
            alert("* �ڷᰡ ����Ǿ����ϴ�.\n���ν�û�� ������� �� �ϳ��� �����Ͻñ� �ٶ��ϴ�.\n������½� ȸ�������� �̹��� ó���˴ϴ�.");
        else
            alert("* "+trTypeMsg+" �۾��� �Ϸ� �Ͽ����ϴ�!");


        //���� ���°��� ��������̶�� �װ��� �����
        if(CEF_STS == "F") {
            fnc_Print();
        }
    </script>

<script for=trT_AC_CEFBOOK_DEL event="OnSuccess()">
        fnc_SearchList();

        //�޼��� �Ѹ���
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* "+trTypeMsg+" �۾��� �Ϸ� �Ͽ����ϴ�!");
    </script>

<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
<script for=trT_AC_CEFBOOK event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>

<script for=trT_AC_CEFBOOK_DEL event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>

<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
<script language=JavaScript for=dsT_AC_CEFBOOK
	event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        fnc_HiddenElement("btnA");      //����
        fnc_HiddenElement("btnB");      //���ν�û
        fnc_HiddenElement("btnF");      //�������
       // fnc_HiddenElement("txtCEF_YY");   //�ͼӳ��

        if(row > 0) {
            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(row, "CEF_STS");
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(row, "CEF_SEC");
            var ROW_STS = dsT_AC_CEFBOOK.RowStatus(row);

            if(CEF_STS == "A" || ROW_STS == "1") {
                fnc_EnableElementAll(elementList);
                fnc_ShowElement("btnA");

                if(ROW_STS != "1") {              //�ű԰� �ƴϸ� �渮�� ��û�� ��������� �����ϰ�
                    fnc_ShowElement("btnB");        //���ν�û
                    fnc_ShowElement("btnF");        //�������
                }

                //���ټ���õ¡�������� �ͼӳ⵵�� �Է����� ����

                if(CEF_SEC == "04") {
                    fnc_ChangeStateElement(false, "txtCEF_YY");
                    fnc_ChangeStateElement(false, "img_spinup1");
                    fnc_ChangeStateElement(false, "img_spindown1");
                }

<%
    //IT �����ڳ�  �渮 ������ �̸� ������� �˻��ϰ� �Ϲ������̸� ������� �˻����ϰ� ����
    if(!isMaster) {
%>
                //��� ��� ����
                fnc_ChangeStateElement(false, "txtENO_NO");
                fnc_ChangeStateElement(false, "txtENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    } else {
%>
                //�Է��϶��� ��� ���� �����ϰ�
                if(ROW_STS != "1") {
                    fnc_ChangeStateElement(false, "txtENO_NO");
                    fnc_ChangeStateElement(false, "txtENO_NM");
                    fnc_ChangeStateElement(false, "ImgEnoNo");
                }
<%
    }
%>
            }

            //��������� ��� �μⰡ ������
            //(����� �ѹ��� ������ ���)
            if(CEF_STS == "F"
                    && dsT_AC_CEFBOOK.NameValue(row,'SPL_YMD') == "") {
                fnc_ShowElement("btnF");        //�������
            }

            if(dsT_AC_CEFBOOK.NameValue(row,'PRT_YMD') == "") {
                fnc_ChangeStateElement(true, "btnPrintCef");    //��������
            }

        }
    </script>

<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
<script language=JavaScript for=dsT_AC_CEFBOOK
	event=CanRowPosChange(row)>
		if ( dsT_AC_CEFBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_AC_CEFBOOK.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
	</script>


<!-----------------------------------------------------+
    | ���� ������ �����Ҷ� ó��
    +------------------------------------------------------>


<!-----------------------------------------------------+
    | �������� ����� ����� �̺�Ʈ    				   |
    +------------------------------------------------------>

<script language=JavaScript for=rdoCEF_SEC event=OnSelChange()>

    var RDO_Value = rdoCEF_SEC.CodeValue;

      if(RDO_Value=="01") {//�ٷμҵ��õ¡�� ������

         var hir_ymd = document.getElementById("hidHIR_YMD").value;
         if(hir_ymd == today.substring(0,4)){
         fnc_HiddenElement("RDO_Value"); }

         document.getElementById("searchMessage_01").innerText = "�ͼӳ⵵";
         document.getElementById("changeDate_01").style.display = "";
         document.getElementById("changeDate_02").style.display = "none";
         fnc_ChangeStateElement(false, "txtSTR_YY");  //��Ȱ��ȭ
         fnc_HiddenElement("img_spinup");//��ȭ��ǥ ����
         fnc_HiddenElement("img_spindown");//�Ʒ� ȭ��ǥ ����
         document.getElementById("txtSTR_YY").value = today.substring(0,4)-1;

      }else if(RDO_Value=="02"){//�ٷμҵ��õ¡����
         document.getElementById("searchMessage_01").innerText = "�ͼӳ⵵";
         document.getElementById("changeDate_01").style.display = "";
         document.getElementById("changeDate_02").style.display = "none";
         fnc_ShowElement("img_spinup");
         fnc_ShowElement("img_spindown");
         fnc_ChangeStateElement(true , "txtSTR_YY");  //Ȱ��ȭ
         fnc_ChangeStateElement(true , "img_spinup");
         fnc_ChangeStateElement(true , "img_spindown");
         document.getElementById("txtSTR_YY").value = today.substring(0,4);

      }else if(RDO_Value=="03"){//�����ҵ��ģ¡�� ������
         document.getElementById("searchMessage_01").innerText = "�ͼӳ��";
         document.getElementById("changeDate_01").style.display = "none";
         document.getElementById("changeDate_02").style.display = "";
         fnc_ShowElement("txtCEF_YY");
         fnc_ShowElement("img_spinup1");
         fnc_ShowElement("img_spindown1");
         fnc_ChangeStateElement(true, "txtCEF_YY");  //Ȱ��ȭ
         fnc_ChangeStateElement(true, "img_spinup1");
         fnc_ChangeStateElement(true, "img_spindown1");

      }else if(RDO_Value=="04"){//���ټ���õ¡������
         document.getElementById("searchMessage_01").innerText = "�ͼӳ��";
         document.getElementById("changeDate_01").style.display = "none";
         document.getElementById("changeDate_02").style.display = "";
         fnc_ShowElement("txtCEF_YY");
         fnc_ChangeStateElement(false, "txtCEF_YY");  //��Ȱ��ȭ
         fnc_HiddenElement("img_spinup1");//��ȭ��ǥ ����
         fnc_HiddenElement("img_spindown1");//�Ʒ� ȭ��ǥ ����
      }
     </script>



<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"	onload="fnc_OnLoadProcess();">

<!-- Ķ���� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ҵ��������û</td>
					<td align="right" class="navigator">HOME/���꼼��/�ҵ���������/<font color="#000000">�ҵ��������û</font></td>
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
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<!-- 	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="70"></col>
					<col width="220"></col>
                    <col width="70"></col>
                    <col width="100"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">��û�Ⱓ</td>
					<td class="padding2423" align="left" colspan="5">
						<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','134','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
						~
						<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','248','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
                </tr>
                <tr>
					<td class="searchState" align="right" rowspan="2">����</td>
					<td class="padding2423" align="left" rowspan="2">
						<select id="cmbCEF_SEC_SHR" style="WIDTH: 160px" onChange="fnc_SearchList()">
							<option value="0">���</option>
						</select>
					</td>
					<td class="searchState" align="right">��ȸ����</td>
					<td class="padding2423" align="left">
						<select id="cmbCEF_STS_SHR" style="WIDTH: 70px" onChange="fnc_SearchList()">
							<option value="0">���</option>
							<option value="A">����</option>
							<option value="B">��û</option>
							<option value="C">�ݼ�</option>
							<option value="E">�߱�</option>
							<option value="F">�������</option>
						</select>
					</td>
                    <td align="right" class="searchState">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <input id="txtENO_NM_SHR" size="8" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');"></a>
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>
			</table>
			</td>
		</tr>
	</table>
<!-- power Search���̺� �� -->


<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<colgroup>
		<col width="398"></col>
		<col width="4"></col>
		<col width="398"></col>
	</colgroup>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr>
			<td align="right" height="20">
                <img src="/images/button/btn_SaveOn.gif" name="btnA" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('A');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnA','','/images/button/btn_SaveOver.gif',1)">
                <img src="/images/button/btn_AntOn.gif" name="btnB" border="0" align="absmiddle" onClick="fnc_Save('B');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnB','','/images/button/btn_AntOver.gif',1)">
                <img src="/images/button/btn_DirectPrintOn.gif" name="btnF" border="0" align="absmiddle" onClick="fnc_Save('F');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnF','','/images/button/btn_DirectPrintOver.gif',1)">
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="180"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">��û��ȣ</td>
			<td class="padding2423" align="left">
				<input id="txtREQ_NO" name="txtREQ_NO" size="12"  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">���</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidHIR_YMD">
            </td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423" align="left">
				<input id="txtJOB_NM" name="txtJOB_NM" size="10" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidJOB_CD">
			</td>
			<td align="center" class="creamBold">�μ�</td>
			<td class="padding2423" align="left">
				<input id="txtDPT_NM" name="txtDPT_NM" size="15" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidDPT_CD">
			</td>
		</tr>
		<tr>
		<td align="center" class="creamBold">����</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtPER_ADR" name="txtPER_ADR" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">�ּ�</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtADDRESS" name="txtADDRESS" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>
		</td>
	   </tr>
	   <tr>
		<td class="paddingTop5">

		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="60"></col>
				<col width="230"></col>
				<col width="60"></col>
				<col width="100"></col>
				<col width="60"></col>
				<col width="100"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
			<tr>
				<td align="center" class="creamBold" rowspan="4">����<br>����</td>
			<td class="padding2423" align="left" rowspan="4">
                <comment id="__NSID__">
                    <object id=rdoCEF_SEC classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200;height:90;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^�ٷμҵ��õ¡��������,02^�ٷμҵ��õ¡����,03^�����ҵ��õ¡��������,04^���ټ���õ¡������">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>

			</td>
			<td align="center" class="creamBold">�뵵</td>
			<td class="padding2423" colspan="3">
				<select id="cmbCEF_RSN" style="width:150px" onChange="fnc_Searchcmb()"></select>
				&nbsp;
			</td>

            <td align="center" class="creamBold">�ż�</td>
            <td class="padding2423">
                <input id="txtCEF_CNT" size="4"  maxlength="2" style="ime-mode:disabled">
            </td>
		    </tr>
		    <tr>
				<td align="center" class="creamBold">���</td>
				<td class="padding2423" colspan="5">
				<input type="text" id="txtREMARK" style="width:100%" class="input_ReadOnly" readonly>
				</td>
			</tr>
			<tr>
				<td align="center" class="creamBold"><span
					id="searchMessage_01">�ͼӳ⵵</span></td>
				<td class="padding2423" align="left">
				<table id="changeDate_01" height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td width="40" rowspan="2" style="padding-left:0px; border-style:none">
						<input type="text" id="txtSTR_YY" style="ime-mode:disabled" size="5" maxlength="4"
							onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()" class="input_ReadOnly" readonly>
						</td>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spinup" style="cursor: hand" onclick="datechange('txtSTR_YY', 'yyyy', 'next');"  src="/images/common/arrowup.gif"></TD>
					</tr>
					<tr>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spindown" style="cursor: hand" onclick="datechange('txtSTR_YY', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
					</tr>
				</table>
				<table id="changeDate_02" height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td width="40" rowspan="2" style="padding-left:0px; border-style:none">
						<input type="text" id="txtCEF_YY" style="ime-mode:disabled" size="7" maxlength="7"
							onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						</td>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spinup1" style="cursor: hand" onclick="datechange('txtCEF_YY', 'yyyymm', 'next');" src="/images/common/arrowup.gif"></TD>
					</tr>
					<tr>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spindown1" style="cursor: hand" onclick="datechange('txtCEF_YY', 'yyyymm', 'prev');" src="/images/common/arrowdown.gif"></TD>
					</tr>
					</td>
				</table>
				<td align="center" class="creamBold">����</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_STS_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">��û����</td>
			<td class="padding2423">
				<input type="text" id="txtREQ_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		    </tr>
		    <tr>
			<td align="center" class="creamBold">�߱޹�ȣ</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtCEF_NO" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">�߱�����</td>
			<td class="padding2423">
				<input type="text" id="txtSPL_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		    </tr>
		    </table>

		</td>
	</tr>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="3"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<tr>
				<td>[���� ��û���]<br>
				&nbsp;&nbsp;1. ���� ������
				�����ϼ���.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.
				��û�� ������ �ż��� �Է��ϰ� ��û�뵵�� �����ϼ���.<br>
				[������� ����]<br>
				&nbsp;&nbsp;��������� ������ ���� ������ ����� �� ������ ������ �̹��� ó�� �˴ϴ�.</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� --> <!-- ��ȸ ���� ���̺� ���� -->
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
<!-- ��ȸ ���� ���̺� �� --> <!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td><comment id="__NSID__"> <object
					id="grdT_AC_CEFBOOK"
					classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B"
					style="width:800px;height:144px;">
					<param name="DataID" value="dsT_AC_CEFBOOK">
					<param name="Editable" value="false">
					<param name="DragDropEnable" value="true">
					<param name="SortView" value="Left">
					<param name="Format"
						value='
							<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
							<C> id="REQ_NO"		width=75	name="��û��ȣ"		align=center	Edit=none	 </C>
							<C> id="ENO_NO"		width=60	name="���"			align=center	Edit=none	 Show=false</C>
							<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none	 Show=false</C>
							<C> id="JOB_NM"		width=60	name="����"			align=center	Edit=none	 Show=false</C>
							<C> id="DPT_NM"		width=100	name="�μ�"			align=left		Edit=none	 Show=false</C>
							<C> id="PER_ADR"	width=180	name="����"			align=left		Edit=none	 Show=false</C>
							<C> id="ADDRESS"	width=180	name="�ּ�"			align=left		Edit=none	 Show=false</C>
							<C> id="CEF_SEC"	width=160	name="��������"		align=left		EditStyle=Lookup  Data="dsT_CM_COMMON_AC:CODE:CODE_NAME" 	 LeftMargin="10"</C>
							<C> id="CEF_CNT"	width=40	name="�ż�"			align=center	Edit=none	 </C>
							<C> id="CEF_RSN"	width=140	name="�뵵"			align=left		EditStyle=Lookup  Data="dsT_CM_COMMON_R4:CODE:CODE_NAME" 	 LeftMargin="10"</C>
							<C> id="CEF_STS_NM" width=60	name="����"			align=center	Edit=none	</C>
							<C> id="REQ_YMD"	width=80	name="��û����"		align=center	Edit=none	 </C>
							<C> id="CEF_NO"		width=100	name="�߱޹�ȣ"		align=center	Edit=none	 </C>
							<C> id="SPL_YMD"	width=80	name="�߱�����"		align=center	Edit=none	 </C>
						'>
				</object> </comment><script> __ShowEmbedObject(__NSID__); </script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��--></form>
<!-- form �� -->

</body>
</html>


<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

<!-- T_AC_CEFBOOK ���� ���̺� -->
<object id="bndT_AC_CEFBOOK"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_CEFBOOK">
	<Param Name="BindInfo"
		, Value="
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=PER_ADR		Ctrl=txtPER_ADR		Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>
			<C>Col=CEF_RSN		Ctrl=cmbCEF_RSN		Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=CEF_NO		Ctrl=txtCEF_NO		Param=value</C>
			<C>Col=CEF_STS_NM	Ctrl=txtCEF_STS_NM	Param=value</C>
			<C>Col=CEF_SEC		Ctrl=rdoCEF_SEC		Param=CodeValue</C>
			<C>Col=CEF_CNT		Ctrl=txtCEF_CNT		Param=value</C>
			<C>Col=CEF_YY		Ctrl=txtCEF_YY		Param=value</C>
			<C>Col=CEF_YY		Ctrl=txtCEF_YY		Param=value</C>
			<C>Col=STR_YY		Ctrl=txtSTR_YY		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=hidHIR_YMD		Param=value</C>
		">
</object>
