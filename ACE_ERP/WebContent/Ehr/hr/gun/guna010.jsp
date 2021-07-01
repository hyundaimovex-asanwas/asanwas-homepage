	<!--*************************************************************************
	* @source      : guna010.jsp												*
	* @description : ���ϱ��� ��Ȳ��� PAGE										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/09            ä����          	        �����ۼ�				*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String DPTCD = (String)request.getSession().getAttribute("SESSION_DPTCD");
	String DPTNM = (String)request.getSession().getAttribute("SESSION_DPTNM");
	String ENONO = (String)request.getSession().getAttribute("SESSION_ENONO");
 %>
<html>
<head>
	<title>���ϱ��� ��Ȳ(guna010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var today = getToday();
		var btnList = 'TFTTFFFT';
		var SANG_YN = "N";
        var GBN = "";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {
			var DPT_CD_SHR  = document.form1.txtDPT_CD_SHR.value;
			var GUN_YMD_SHR  = document.form1.txtGUN_YMD_SHR.value;

			if(DPT_CD_SHR == ""){
				alert("�Ҽ��� �Է��Ͻʽÿ�.");
				return;
			}

            GBN = "SHR";

			trT_DI_DILIGENCE.KeyValue = "tr05(O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY, O:dsO_one=dsT_DI_DILIGENCE, O:dsO_two=dsGun)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna010.cmd.GUNA010CMD&S_MODE=SHR_02&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR;
			trT_DI_DILIGENCE.post();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {
            var DPT_CD_SHR  = document.form1.txtDPT_CD_SHR.value;
            var GUN_YMD_SHR  = document.form1.txtGUN_YMD_SHR.value;

			//������ ������Ű�� ���ؼ� �۵�...
            for(i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
                dsT_DI_DILIGENCE.NameValue(i,"GUN_GBN_CP") = "0";
            }

            GBN = "SAV";

            if ( !fnc_SaveItemCheck() ) {
                return;
            }

			// save (�ش� ���ڵ� ������ ���κ� �űԻ���)
			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna010.cmd.GUNA010CMD&S_MODE=SAV"+"&DPT_CD_SHR="+DPT_CD_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR;
			trT_DI_DILIGENCE.post();

        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���

            var DPT_CD_SHR = document.getElementById('txtDPT_CD_SHR').value;
			var DPT_NM_SHR = document.getElementById('txtDPT_NM_SHR').value;
            var GUN_YMD_SHR = document.getElementById('txtGUN_YMD_SHR').value;
            var DPT_CNT = document.getElementById('txtDPT_CNT').value;

            var url = "guna010_PV.jsp?DPT_CD_SHR="+DPT_CD_SHR+"&DPT_NM_SHR="+DPT_NM_SHR+"&GUN_YMD_SHR="+GUN_YMD_SHR+"&DPT_CNT="+DPT_CNT;
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {

       }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/

        function fnc_Remove() {

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {
			document.form1.txtDPT_CD_SHR.value = '<%=DPTCD %>';
			document.form1.txtDPT_NM_SHR.value = '<%=DPTNM %>';
			//document.form1.txtGUN_YMD_SHR.value = today;

            document.getElementById("resultMessage").innerText = ' ';


        	dsGun.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_DI_DILIGENCE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_DI_DILIGENCE.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
	           return false;
			}

            //�����ڴ� �����ϴ�.
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	        /*
			//��Ͻð� üũ �ӽ� �ּ� (����� �븮, 2007-09-05)
			if( new Date().getHours() >= "9"){
				alert("���� ���� ��Ȳ����� ���� 9�� ������ �̷�������մϴ�.");
				return false;
			}

			// �������� üũ �ӽ� �ּ� ����
			var GUN_YMD = dsT_DI_DILIGENCE.NameValue(1, "GUN_YMD");
			if(GUN_YMD != getToday().replace("-","").replace("-","")){
				alert("�������ڰ� ���� ��¥�� �ƴմϴ�.");
				return false;
			}
			*/
<%
    }
%>

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("approval_flag").value = "N";//���ѷ��� ����

			document.form1.txtGUN_YMD_SHR.value = today;

			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"true","false");      // Grid Style ����

			cfStyleGrid(form1.grdGun,0,"true","false");      // Grid Style ����
			form1.grdGun.HiddenHScroll  = true;
			form1.grdGun.HiddenVScroll  = true;
			form1.grdGun.DisableNoHScroll = false;
			form1.grdGun.DisableNoVScroll = false;
			form1.grdGun.IgnoreSelectionColor = "true";

            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";


<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	   
<%//A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
		  fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
		  fnc_ChangeStateElement(false, "ImgDptCd");
		 document.getElementById("ImgDptCd").style.display = "none";

	     form1.grdT_DI_DILIGENCE.Editable = false;

<%
    }else{
%>
		  fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
		  fnc_ChangeStateElement(false, "ImgDptCd");
		 document.getElementById("ImgDptCd").style.display = "none";

	     form1.grdT_DI_DILIGENCE.Editable = false;

<%
	}
%>


			//���� �� ���ϱ��� ��ȸ
			//dsT_DI_HOLIDAY.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna010.cmd.GUNA010CMD&S_MODE=SHR&GUN_YMD_SHR="+today+"&GUN_DPT="+'<%=DPTCD %>';
			//dsT_DI_HOLIDAY.reset();

			fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 		*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

		/********************************************
         * �׸��� Ŭ���� ���±��м��� �˾�          *
         ********************************************/
        function fnc_SearchGun(row, colid, olddata) {

        	// �Ʒ� GUN_GBN <- ����Ÿset �� Į�������� ���������� �����ؾ� ��
        	var PrevGBN = "";
        	var PrevRMK = "";

        	if( colid == "POPUP" || colid == "GUN_GBN" ){
	        	var obj =  new String();

	        	if(colid == "POPUP"){//�˾�
		        	PrevGBN = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN");
	                PrevRMK = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
                    obj = fnc_commonCodePopupReturn('���±���','H4');

                }else{//�Է�
                    PrevGBN = olddata;
                    PrevRMK = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
                    obj.comm_cd = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN");
                    obj.comm_nm = "";
                }

        		if(obj != null ){
	        		var YRP_CNT = parseFloat(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "YRP_CNT"));
	        		var YRP_USE = parseFloat(dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "YRP_USE"));
	        		var HIR_YMD = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HIR_YMD");//�Ի���
	        		var GUN_YMD = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_YMD");  //��������

        			if(obj.comm_cd == "I"){  //Ư�� �ް�
		        		var obj3 = new String();
		        		obj3 = fnc_commonCodePopupReturn('Ư���ް�����','SF');
		        		if(obj3 != null){
			        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
			        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = obj3.comm_nm;
			        	}

	        		}else if(obj.comm_cd == "T"){  //��ü �ް�
                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";

	        		}else if(obj.comm_cd == "U"){  //��ü ����

                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                        dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";

	        		}else if(obj.comm_cd == "V"){  //��ü+������

                        if(HIR_YMD.substring(0,4) == GUN_YMD.substring(0,4)){//�����Ի��� ����
                            alert("���� �Ի����̹Ƿ� ��ü+���������� ����մϴ�.");
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
                        }else if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "V"){
                            alert("�������� ������ ��ü+�������� ����� �� �����ϴ�.");
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
                        }else{
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
                            dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
                        }
	        		}else if(obj.comm_cd == "J"){  //�������ް�
		        		var MF_TAG = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "MF_TAG");  // ��/�� ����
		        		if(MF_TAG == "M"){
		        			alert("�������ް��� ������ �� �����ϴ�.");
		        			if(PrevGBN==""){
		        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = "W";
		        			}else{
		        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = PrevGBN;
		        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK")  = PrevRMK;
		        			}
		        		}else{
			        		dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
		        		}

        			}else if(obj.comm_cd == "L"){//��Ÿ
	        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
	        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "����";

	        		}else{
						if(HIR_YMD.substring(0,4) == GUN_YMD.substring(0,4)){//�����Ի��� ����
		        			if(obj.comm_cd == "H"){
								if(YRP_CNT < YRP_USE+1 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "H"){
		        					alert("���� �Ի����̹Ƿ� �������� ����մϴ�.");
	        					}
		        			}
		        			if(obj.comm_cd == "P"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "P"){
		        					alert("���� �Ի����̹Ƿ� �������������� ����մϴ�.");
	        					}
		        			 }
		        			if(obj.comm_cd == "R"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "R"){
		        					alert("���� �Ի����̹Ƿ� ���ļ��������� ����մϴ�.");
	        					}
		        			}
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
						}else{
		        			if(obj.comm_cd == "H"){
								if(YRP_CNT < YRP_USE+1 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "H"){
		        					alert("������ ����� �� �����ϴ�.");
	        					}
		        			}
		        			if(obj.comm_cd == "P"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "P"){
		        					alert("������������ ����� �� �����ϴ�.");
	        					}
		        			 }
		        			if(obj.comm_cd == "R"){
								if(YRP_CNT < YRP_USE+0.5 && dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") != "R"){
		        					alert("���Ŀ������� ����� �� �����ϴ�.");
	        					}
		        			}
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN") = obj.comm_cd;
		        			dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK") = "";
	        			}
	        		}

	        		var orgGUN_GBN = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "GUN_GBN");

       				// Ư���ް�(�ű�,����,���� ����)
	        		if( orgGUN_GBN != "I" && obj.comm_cd == "I" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // �ű�
       				}else if( orgGUN_GBN == "I" && obj.comm_cd == "I" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // ����
       				}else if( orgGUN_GBN == "I" && obj.comm_cd != "I" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // ����
       				}

       				// ��ü�ް�(�ű�,����,���� ����)
	        		if( orgGUN_GBN != "T" && obj.comm_cd == "T" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // �ű�
       				}else if( orgGUN_GBN == "T" && obj.comm_cd == "T" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // ����
       				}else if( orgGUN_GBN == "T" && obj.comm_cd != "T" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // ����
        				//���������� ���� �ӽ÷� �־���. �Ѵ� HOL_YMD���
        				//dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HOL_YMD") = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
       				}

       				// ��ü����(�ű�,����,���� ����)
	        		if( orgGUN_GBN != "U" && obj.comm_cd == "U" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // �ű�
       				}else if( orgGUN_GBN == "U" && obj.comm_cd == "U" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // ����
       				}else if( orgGUN_GBN == "U" && obj.comm_cd != "U" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // ����
        				//���������� ���� �ӽ÷� �־���. �Ѵ� HOL_YMD���
        				//dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HOL_YMD") = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
       				}

       				// ��ü+������(�ű�,����,���� ����)
	        		if( orgGUN_GBN != "V" && obj.comm_cd == "V" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // �ű�
       				}else if( orgGUN_GBN == "V" && obj.comm_cd == "V" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // ����
       				}else if( orgGUN_GBN == "V" && obj.comm_cd != "V" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // ����
        				//���������� ���� �ӽ÷� �־���. �Ѵ� HOL_YMD���
        				//dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "HOL_YMD") = dsT_DI_DILIGENCE.OrgNameValue(dsT_DI_DILIGENCE.RowPosition, "REMARK");
       				}

       				// ��Ÿ
	        		if( orgGUN_GBN != "L" && obj.comm_cd == "L" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "INS"; // �ű�
       				}else if( orgGUN_GBN == "L" && obj.comm_cd == "L" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "UPT"; // ����
       				}else if( orgGUN_GBN == "L" && obj.comm_cd != "L" ){
        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "DEL"; // ����
       				}

       				if( orgGUN_GBN == "Q" || orgGUN_GBN == "I" || orgGUN_GBN == "T" || orgGUN_GBN == "U" || orgGUN_GBN == "V" || orgGUN_GBN == "L" ){
       					if(obj.comm_cd == "Q" || obj.comm_cd == "I" || obj.comm_cd == "T" || obj.comm_cd == "U" || obj.comm_cd == "V" || obj.comm_cd == "L"){
	        				dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS") = "REP"; // ��ü
       					}
       				}
					//alert("DTL_STS : "+dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DTL_STS"));

	        	}
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
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(���� ��ȸ��)						   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_HOLIDAY)			   |
    | 3. ���Ǵ� Table List(T_DI_HOLIDAY) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet(�������� ��ȸ��)						   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsGun" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">
    //alert("1:dsT_DI_HOLIDAY");
            document.form1.txtHOL_GBN.value    = dsT_DI_HOLIDAY.NameValue(1, "HOL_GBN");
    </Script>

	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
    //alert("2:dsT_DI_DILIGENCE");
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			document.form1.txtDPT_CNT.value = "0";
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);

			document.form1.txtDPT_CNT.value = dsT_DI_DILIGENCE.NameValue(1, "DPT_CNT");

			// ���� ��ȸ�� ���±��� ������ ��� (W:�������) ���� ����
			for(var i=1; i<=dsT_DI_DILIGENCE.CountRow; i++){
				if( dsT_DI_DILIGENCE.NameValue(i, "GUN_GBN") == "" ){
					//dsT_DI_DILIGENCE.NameValue(i, "GUN_GBN") = "W";

		            // �����̸� Y����
		            if( dsT_DI_HOLIDAY.NameValue(1, "HOL_GBN") != "����" ){ // ����
                      dsT_DI_DILIGENCE.NameValue(i, "GUN_GBN") = "Y";
                    }
				}
			}
        }

    </Script>

	<Script For=dsGun Event="OnLoadCompleted(iCount)">
    //alert("3:dsGun");
		if (iCount == 0)    {
			// �ʿ��� �ҽ� ����
		} else {
			// �ʿ��� �ҽ� ����
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
        //alert("trT_DI_DILIGENCE");
        if(GBN == "SAV"){
            fnc_SearchList();
		    fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        }
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        alert(trT_DI_DILIGENCE.ErrorMsg);
    </script>

<%
    //��ȸ�� �����ϰ�..
    if(!box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	<!-----------------------------------------------------+
    | Grid Ŭ���� ������Ȳ ��ȸ	  							   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_DILIGENCE event=OnClick(row,colid)>
		/*
        if(colid == "POPUP"){
            fnc_SearchGun(row, colid);
        }
		*/
	</script>
<%
    }
%>

	<script language="javascript"  for=grdT_DI_DILIGENCE event=OnExit(row,colid,olddata)>

	    var GUN_GBN = dsT_DI_DILIGENCE.NameValue(row,colid);
	    var HOL_GBN = dsT_DI_HOLIDAY.NameValue(1, "HOL_GBN");

        /*
	    alert("Occur OnEnter Event :" + "<row :" + row +">" +
	          "<colid :" + colid + ">" +
	          "<Before Data :" + olddata +
	          "> -->"+GUN_GBN );
	    */

	    //��ȿ�ڵ� Ȯ��
	    for(i=1; i<=dsGun.CountRow; i++){
            if(dsGun.NameValue(i,"GUN_GBN1").substring(0,1) == GUN_GBN || dsGun.NameValue(i,"GUN_GBN2").substring(0,1) == GUN_GBN){

                //���ϱ��� ���Ͽ� �Է°����� �ڵ� : ����(E), �Ʒ�(G), ����(K), ����(Y), ����(W), ����(F), ��Ÿ(L)
                if( (HOL_GBN == "����" || HOL_GBN == "Ư������") &&
                    (GUN_GBN != "E" && GUN_GBN != "G" && GUN_GBN != "K" && GUN_GBN != "Y" && GUN_GBN != "W" && GUN_GBN != "F" && GUN_GBN != "L") ){

                    alert("���Ͽ��� �ش� �����׸��� ����� �� �����ϴ�.");
                    dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
                    return false;
                }

                fnc_SearchGun(row, colid, olddata);
                return true;
	        }
        }

        alert("�߸��� �����׸��Դϴ�. �����ڵ带 Ȯ���ϼ���.");
        dsT_DI_DILIGENCE.NameValue(row,colid) = olddata;
        return false;

    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱ��� ��Ȳ</td>
					<td align="right" class="navigator">HOME/���°���/���ϱ��°���/<font color="#000000">���ϱ��� ��Ȳ</font></td>
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
			    <input type="hidden"id="approval_flag">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<!--
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				-->
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<!--
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print();"></a>
			-->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="30"></col>
							<col width="145"></col>
							<col width="60"></col>
							<col width="100"></col>
							<col width="30"></col>
							<col width="70"></col>
							<col width="40"></col>
							<col width="35"></col>
							<col width="55"></col>
							<col width="70"></col>
							<col width="30"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�Ҽ�</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13){fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');fnc_SearchList();}"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');fnc_SearchList();">
								<input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
		                        	<img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT');fnc_SearchList();">
	                        	</a>
							</td>
							<td class="searchState" align="right">��������</td>
							<td class="padding2423" align="left"><input id="txtGUN_YMD_SHR" size="10" maxLength="10" onblur="cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGUN_YMD_SHR','','190','115');"></a></td>
							<td class="searchState" align="right">���ο�</td>
							<td class="padding2423" align="left"><input id="txtDPT_CNT" size="4" class="input_ReadOnly"  readonly></td>
							<td class="searchState" align="right">���ϱ���</td>
							<td class="padding2423" align="left"><input id="txtHOL_GBN" size="10" class="input_ReadOnly"  readonly></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->

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

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center" valign="middle" height="55">
					<td rowspan="4">
						<comment id="__NSID__">
						<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:460px;height:348px;">
							<param name="DataID" value="dsT_DI_DILIGENCE">
							<param name="Editable" value="false">
							<param name="DragDropEnable" value="true">
							<param name="SortView" value="Left">
							<param name="Format" value='
								<C> id="{CUROW}"	width=35	name="NO"			align=center	value={String(Currow)}      </C>
								<C> id="JOB_NM"		width=50	name="����"			align=center	Edit=none                   </C>
								<C> id="ENO_NO"		width=80	name="���"			align=center	Edit=none                   </C>
								<C> id="ENO_NM"		width=80	name="����"			align=center	Edit=none                   </C>
								<C> id="GUN_GBN"	width=54	name="�����׸�"		align=center	Edit=none                 </C>
								<C> id="GUN_GBN_CP"	width=54	name="�����׸�"		align=center	Edit=none	show="false"    </C>
								<C> id="POPUP"      width=20    name=" "            align=center    Edit=none                   </C>
								<C> id="POPUP_CP"   width=20    name=" "            align=center    Edit=none   show="false"    </C>
								<C> id="REMARK"		width=120	name="���"			align=left		Edit=none	leftmargin="10"	</C>
							'>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td class="paddingTop3">
						<img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> ��������
					</td>
				</tr>
				<tr>
					<td>
					<comment id="__NSID__">
					<object id="grdGun" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:340px;height:276px;">
						<param name="DataID" value="dsGun">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="GUN_GBN1"		width=113	name="����"			align=left		Edit=none	leftmargin="10"</C>
							<C> id="GUN_CNT1"		width=55	name="��"			align=right 	Edit=none	rightmargin="10"</C>
							<C> id="GUN_GBN2"		width=113	name="����"			align=left		Edit=none	leftmargin="10"</C>
							<C> id="GUN_CNT2"		width=55	name="��"			align=right		Edit=none	rightmargin="10"</C>
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
