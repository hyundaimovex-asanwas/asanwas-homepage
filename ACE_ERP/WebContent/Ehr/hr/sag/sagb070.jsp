<!--
***********************************************************************
* @source      : sagb070.jsp
* @description : ö�ߴ������û PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/29      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<html>
<head>
	<title>ö�ߴ������û(sagb070)</title>
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
		var btnList = 'TTTTTFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

            var pis_ym   = document.getElementById("txtPIS_YM_SHR").value;
			var dpt_cd   = document.getElementById("txtDPT_CD_SHR").value;
			var dpt_nm   = document.getElementById("txtDPT_NM_SHR").value;

            if(pis_ym == "") {
                alert("��û ����� �Է��� �ּ���.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }
            if(dpt_cd == "") {
                alert("�Ҽ��ڵ带 �Է��� �ּ���.");
                document.getElementById("txtDPT_CD_SHR").focus();
                return;
            }
            if(dpt_nm == "") {
                alert("�߸��� �Ҽ��ڵ� �Դϴ�. Ȯ���� �ٽ� �Է��� �ּ���.");
                document.getElementById("txtDPT_CD_SHR").focus();
                return;
            }

            //������ ���� ��ȸ
            fnc_SearchApprover();

            //�˻� �Ҽ� �ڵ带 ����� �д�
            document.getElementById("hidDPT_CD_ORI").value = dpt_cd;
            document.getElementById("hidTAG_YM").value = pis_ym;

			dsT_CP_NIGHTDUTY.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb070.cmd.SAGB070CMD"
                                    + "&S_MODE=SHR"
                                    + "&DPT_CD="+dpt_cd
                                    + "&PIS_YM="+pis_ym;
			dsT_CP_NIGHTDUTY.reset();

			//�ش����� ���� �׸��� �÷����� �ٲ��.
			fnc_ChangeGrid();
        }

        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {
            var PIS_YM  = document.getElementById("txtPIS_YM_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&GUN_GBN=D"       // D.ö��
                                   + "&GUN_YMD="+PIS_YM
                                   + "&GUN_DPT="+DPT_CD;
            dsT_DI_APPROVAL.Reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem(row) {

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

            if(!fnc_SaveItemCheck()) return;

			// save
			trT_CP_NIGHTDUTY.KeyValue = "tr01(I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY,I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_CP_NIGHTDUTY.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb070.cmd.SAGB070CMD&S_MODE=SAV";
			trT_CP_NIGHTDUTY.post();

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {
        	// ���º����û�� ����
			if (dsT_CP_NIGHTDUTY.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

           	var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            tmpMSG += "��û��ȣ = "+dsT_CP_NIGHTDUTY.nameValue(dsT_CP_NIGHTDUTY.RowPosition, "REQ_NO")+"\n";
            tmpMSG += "���       = "+dsT_CP_NIGHTDUTY.nameValue(dsT_CP_NIGHTDUTY.RowPosition, "ENO_NO")+"\n";
            tmpMSG += "����       = "+dsT_CP_NIGHTDUTY.nameValue(dsT_CP_NIGHTDUTY.RowPosition, "ENO_NM")+"\n";

	        if(!confirm(tmpMSG) )
                return;

			dsT_CP_NIGHTDUTY.DeleteRow(dsT_CP_NIGHTDUTY.RowPosition);
            trT_CP_NIGHTDUTY.KeyValue = "tr01(I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_CP_NIGHTDUTY.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb070.cmd.SAGB070CMD&S_MODE=SAV";
            trT_CP_NIGHTDUTY.post();
        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CP_NIGHTDUTY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_NIGHTDUTY.GridToExcel("ö�ߴ������û", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CP_NIGHTDUTY.CountColumn < 1) {
                dsT_CP_NIGHTDUTY.setDataHeader("REQ_NO:STRING, ENO_NO:STRING:KEYVALUETYPE, PIS_YM:STRING:KEYVALUETYPE, DPT_CD:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, DUTY_CNT:DECIMAL, DUTY_AMT:DECIMAL, REMARK:STRING, END_TAG:STRING, MD_DSP:DECIMAL, AT1_CD:STRING, AT2_CD:STRING, AT3_CD:STRING, AT4_CD:STRING, AT5_CD:STRING, AT6_CD:STRING, AT7_CD:STRING, AT8_CD:STRING, AT9_CD:STRING, AT10_CD:STRING, AT11_CD:STRING, AT12_CD:STRING, AT13_CD:STRING, AT14_CD:STRING, AT15_CD:STRING, AT16_CD:STRING, AT17_CD:STRING, AT18_CD:STRING, AT19_CD:STRING, AT20_CD:STRING, AT21_CD:STRING, AT22_CD:STRING, AT23_CD:STRING, AT24_CD:STRING, AT25_CD:STRING, AT26_CD:STRING, AT27_CD:STRING, AT28_CD:STRING, AT29_CD:STRING, AT30_CD:STRING, AT31_CD:STRING");
            }

            var pis_ym      = document.getElementById("hidTAG_YM").value;
            var pis_list    = document.getElementById("hidTAG_YM").value.split("-");

            dsT_CP_NIGHTDUTY.AddRow();
            dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "REQ_NO") = pis_ym.replace(/\-/g,'')+document.getElementById("hidDPT_CD_ORI").value;
            dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "PIS_YM") = pis_ym;
            dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "MD_DSP") = fnc_Lastday(pis_list[0], pis_list[1]);

            document.getElementById("txtENO_NO").focus();
        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

        	//�������� üũ
			if(dsT_CP_NIGHTDUTY.RowStatus(dsT_CP_NIGHTDUTY.RowPosition) != 1 && dsT_CP_NIGHTDUTY.NameValue(dsT_CP_NIGHTDUTY.RowPosition,"APP_YN_NM") != "�̰�") return;

			if (dsT_DI_APPROVAL.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� �����ڸ� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "����     = "+dsT_DI_APPROVAL.nameValue(dsT_DI_APPROVAL.RowPosition, "JOB_NM")+"\n";
            	tmpMSG += "���     = "+dsT_DI_APPROVAL.nameValue(dsT_DI_APPROVAL.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "����     = "+dsT_DI_APPROVAL.nameValue(dsT_DI_APPROVAL.RowPosition, "ENO_NM")+"\n";

	            if( confirm(tmpMSG) ){

					dsT_DI_APPROVAL.DeleteRow(dsT_DI_APPROVAL.RowPosition);

	            	// seq_no ���� ����
	            	for(var i=1; i<dsT_DI_APPROVAL.CountRow; i++){
		            	if(parseInt(dsT_DI_APPROVAL.NameValue(i, "SEQ_NO")) > parseInt(SEQ_NO)){
		            		dsT_DI_APPROVAL.NameValue(i, "SEQ_NO") = parseInt(dsT_DI_APPROVAL.NameValue(i, "SEQ_NO"))-1;
		            	}
	            	}
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {
            //�����ϴ� �͵� ����
            fnc_HiddenElement("imgSelectapproval");
            fnc_HiddenElement("imgReport");
            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAppend");
            fnc_HiddenElement("imgRemove");
            fnc_DisableElementAll(elementList);


        	dsT_CP_NIGHTDUTY.ClearData();
        	dsT_DI_APPROVAL.ClearData();

            //������ ���� ����
            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";

            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";

            document.getElementById("resultMessage").innerText = ' ';

            fnc_ChangeGrid();

            document.form1.hidDPT_CD_ORI.value = '<%= box.get("SESSION_DPTCD")%>';
            document.form1.txtDPT_CD_SHR.value = '<%= box.get("SESSION_DPTCD")%>';
            document.form1.txtDPT_NM_SHR.value = '<%= box.get("SESSION_DPTNM")%>';

            document.form1.txtPIS_YM_SHR.focus();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CP_NIGHTDUTY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

            var pis_ym = document.getElementById("txtPIS_YM_SHR");

			if(pis_ym.value == ""){
				alert("�ش����� �Է��ϼ���!");
                pis_ym.focus();
				return false;
			}
            return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_CP_NIGHTDUTY.isUpdated
                    && !dsT_DI_APPROVAL.isUpdated) {
	         	alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
            //�����ϴ� �͵� ����
            fnc_HiddenElement("imgSelectapproval");
            fnc_HiddenElement("imgReport");
            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgAppend");
            fnc_HiddenElement("imgRemove");
            fnc_DisableElementAll(elementList);



            //CHECK_DATE!!!
            //â�� ������ ���糯¥�� ���� 15�� �����̸� �������� ������ �´�.
            var todayList   = getTodayArray();
            var hol_ymd     = getToday();
            if(fnc_covNumber(todayList[2]) > 15)
                hol_ymd     = addDate("M", getToday(), 1);

            document.getElementById("hidTAG_YM").value      = hol_ymd.substr(0, 7); // �ش���
            document.getElementById("txtPIS_YM_SHR").value  = hol_ymd.substr(0, 7); // �ش���

            //�ش����� ���� �׸��� �÷����� �ٲ��.
            fnc_ChangeGrid();


            document.form1.hidDPT_CD_ORI.value = '<%= box.get("SESSION_DPTCD")%>';
            document.form1.txtDPT_CD_SHR.value = '<%= box.get("SESSION_DPTCD")%>';
            document.form1.txtDPT_NM_SHR.value = '<%= box.get("SESSION_DPTNM")%>';
<%
    //�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "txtDPT_NM_SHR");
            fnc_ChangeStateElement(false, "ImgDptCd");


<%
    }
%>
            document.form1.txtPIS_YM_SHR.focus();

            fnc_SearchList();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"txtREMARK"
                                    ,"ImgEnoNo");


        /*************************************
         * 18. �����ϼ� ǥ�� �� �Է� ó��    *
         ************************************/
  		function fnc_LastDayOfMonth(yyyymm){

            var last_day = fnc_Lastday(yyyymm.value.substring(0,4), yyyymm.value.substring(5,7));

            dsT_CP_NIGHTDUTY.NameValue(dsT_CP_NIGHTDUTY.RowPosition,"MD_DSP") = last_day;

  		}

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "1");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "1");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "1");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;

                dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "DPT_CD") = obj.dpt_cd;
                dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "DPT_NM") = obj.dpt_nm;
                dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "JOB_CD") = obj.job_cd;
                dsT_CP_NIGHTDUTY.NameString(dsT_CP_NIGHTDUTY.RowPosition, "JOB_NM") = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value = "";
	            document.getElementById("txtENO_NM").value = "";
	            document.getElementById("txtJOB_CD").value = "";
	            document.getElementById("txtJOB_NM").value = "";
	            document.getElementById("txtDPT_CD").value = "";
	            document.getElementById("txtDPT_NM").value = "";
            }
        }


        /**
         * ������ ������ ��ȸ�սô�.
         */
        function fnc_Approval() {

            //������ ���� ��ȸ
            window.showModalDialog("./sagb071.jsp", dsT_DI_APPROVAL, "dialogWidth:500px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            for(var i=1; i<=4; i++) {
                document.getElementById("txtA"+i+"_ENO_NM").innerText   = dsT_DI_APPROVAL.NameValue(i, "JOB_NM")+" "+dsT_DI_APPROVAL.NameValue(i, "ENO_NM");
                document.getElementById("txtA"+i+"_APP_STS").innerText  = dsT_DI_APPROVAL.NameValue(i, "APP_YN_NM");
            }
        }


        /**
         * �׸��� ���� ó��
         */
		function fnc_ChangeGrid() {

			//�Էµ����ʹ� ���� �������̹Ƿ� ������ ǥ���ؾ� ��
			var PIS_YM_SHR= document.getElementById("hidTAG_YM").value;
			var preDate   = new Date(PIS_YM_SHR.substring(0,4), PIS_YM_SHR.substring(5,7)-2, "01");
			var prePIS_YY = preDate.getFullYear();
			var prePIS_MM = lpad((preDate.getMonth()+1),2,"0");
            var lastDay   = fnc_covNumber(fnc_Lastday(prePIS_YY, prePIS_MM));

			grdFormat = "<FC> id={currow}		width=30    name='NO'		    align=center                               </FC>"
                      + "<FC> id='DPT_NM'		width=80	name='�Ҽ�'			align=left		Edit=none	leftMargin='10'</FC>"
                      + "<FC> id='JOB_NM'		width=50	name='����'			align=left		Edit=none	leftMargin='10'</FC>"
                      + "<FC> id='ENO_NO'		width=60	name='���'			align=center	Edit=none                  </FC>"
                      + "<FC> id='ENO_NM'		width=60	name='����'			align=center	Edit=none                  </FC>"
                      + "<C> id='PIS_YM'		width=70	name='�ش���'		align=center	Edit=none                  </C>"
                      + "<C> id='DUTY_CNT'		width=70	name='�����ϼ�'		align=right 	Edit=none                  </C>"
                      + "<C> id='DUTY_AMT'		width=70	name='��������'		align=right 	Edit=none                  </C>"
                      + "<C> id='REMARK'		width=100	name='���'		    align=left	    Edit=none                  </C>"
                      + "<G> name='"+prePIS_YY+"�� "+prePIS_MM+"�� ��û��' HeadBgColor='#F7DCBB'";

            for(var i=1; i<=lastDay; i++)
                grdFormat+= "    <C> id='AT"+i+"_CD'	width=20	name='"+i+"'	align=center	Edit=none   bgcolor={Decode(AT"+i+"_CD,'Y','#F2AC47','#FEEFEF')}     </C>"

            grdFormat+= "</G>";

            form1.grdT_CP_NIGHTDUTY.Format = grdFormat;

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CP_NIGHTDUTY,15,"true","false");      // Grid Style ����

		}


        /**
         * ���ó��
         */
        function fnc_Conduct() {

            //1.���ó���ϱ��� �Է� �����͸� �ѹ� ����
            trT_CP_NIGHTDUTY2.KeyValue = "tr01(I:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_CP_NIGHTDUTY2.action = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb070.cmd.SAGB070CMD&S_MODE=SAV";
            trT_CP_NIGHTDUTY2.post();


            //2.���ó����
            if(dsT_DI_APPROVAL.CountRow < 2
                    || dsT_DI_APPROVAL.NameString(1, "ENO_NO") == ""
                    || (dsT_DI_APPROVAL.NameString(2, "ENO_NO") == ""
                            && dsT_DI_APPROVAL.NameString(4, "ENO_NO") == "")) {
                alert("������, ���������ڸ� �������ּ���.");
                return;
            }
            dsT_DI_APPROVAL.NameString(1, "APP_YN") = "R";
            trT_CP_NIGHTDUTY.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_CP_NIGHTDUTY.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +dsT_DI_APPROVAL.NameString(1, "APP_YN")
                                      + "&GUN_YMD=" +dsT_DI_APPROVAL.NameString(1, "GUN_YMD")
                                      + "&GUN_GBN=" +dsT_DI_APPROVAL.NameString(1, "GUN_GBN")
                                      + "&GUN_DPT=" +dsT_DI_APPROVAL.NameString(1, "GUN_DPT")
                                      + "&SEQ_NO="  +dsT_DI_APPROVAL.NameString(1, "SEQ_NO");
            trT_CP_NIGHTDUTY.post();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_NIGHTDUTY)		   |
    | 3. ���Ǵ� Table List(T_CP_NIGHTDUTY) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_NIGHTDUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet(���缱)					   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_APPROVAL)		   |
    | 3. ���Ǵ� Table List(T_CP_APPROVAL) 			   |
    +------------------------------------------------------>
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_NIGHTDUTY)		   |
    | 3. ���Ǵ� Table List(T_CP_NIGHTDUTY)			   |
    +------------------------------------------------------>
	<Object ID="trT_CP_NIGHTDUTY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	<Object ID="trT_CP_NIGHTDUTY2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

		}else{

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }
    </Script>


    <!-- ���缱 ��ȸ �� -->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
        fnc_HiddenElement("imgSelectapproval");
        fnc_HiddenElement("imgReport");
        fnc_HiddenElement("imgSave");
        fnc_HiddenElement("imgAppend");
        fnc_HiddenElement("imgRemove");


        //������ ���� ���ε�
        for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
            var seq_no = dsT_DI_APPROVAL.NameString(i, "SEQ_NO");

            document.getElementById("txtA"+seq_no+"_ENO_NM"  ).innerHTML = dsT_DI_APPROVAL.NameString(seq_no, "JOB_NM")+" "+dsT_DI_APPROVAL.NameString(seq_no, "ENO_NM");
            document.getElementById("txtA"+seq_no+"_APP_STS" ).innerHTML = dsT_DI_APPROVAL.NameString(seq_no, "APP_YN_NM")+"<br>"+dsT_DI_APPROVAL.NameString(seq_no, "APP_TIME");
        }

        var APP_YN  = dsT_DI_APPROVAL.NameString(1, "APP_YN");  //������ ���� ���� '':����, 'R':���, 'Y':����, 'N':�ݷ�
        var today   = fnc_covNumber(getToday());

        //CHECK_DATE!!!
        var tag_ymd = document.getElementById("hidTAG_YM").value+"01";
        var PIS_YM = addDate("M", tag_ymd, -1);

        //��û�Ⱓ
        var holFrom = fnc_covNumber(PIS_YM.substr(0, 6)+"16");
        var holTo   = fnc_covNumber(tag_ymd.substr(0, 6)+"15");

        //����Ⱓ
        var appFrom = fnc_covNumber(tag_ymd.substr(0, 6)+"11");
        var appTo   = fnc_covNumber(tag_ymd.substr(0, 6)+"15");

        //*****************
        //TEST
        //������ ��û�Ⱓ�̸�
        /*
        if(holFrom <= today
                && today <= holTo) {
        */
            //'�ݷ�'�̰ų� '����', '���' �̸� ����� ��� �� ������ ����
            if(APP_YN == "" || APP_YN == "N" || APP_YN == 'R') {
                fnc_ShowElement("imgSelectapproval");
                fnc_ShowElement("imgSave");
                fnc_ShowElement("imgAppend");
                fnc_ShowElement("imgRemove");
            }
        /*
        //TEST
        }
        //������ ����Ⱓ�̸�
        else if(appFrom <= today
                && today <= appTo) {
        */
            //'�ݷ�'�̰ų� '����', '���' �̸� ���缱 ���� �� ��� ����
            if(APP_YN == "" || APP_YN == "N" || APP_YN == 'R') {
                fnc_ShowElement("imgSelectapproval");
                fnc_ShowElement("imgReport");
                fnc_ShowElement("imgSave");
            }
        /*
        //TEST
        }
        */

    </Script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_CP_NIGHTDUTY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_CP_NIGHTDUTY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_CP_NIGHTDUTY event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��                |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_CP_NIGHTDUTY event=CanRowPosChange(row)>
        if (dsT_CP_NIGHTDUTY.NameValue(row, "ENO_NO") == "" ) {
            alert("[ " + grdT_CP_NIGHTDUTY.GetHdrDispName('-3', 'ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
            return false;
        }
    </script>



    <!-------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|
    +-------------------------------------->
    <script language="javascript"  for=dsT_CP_NIGHTDUTY  event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        grdT_CP_NIGHTDUTY.Editable = "false";


        var today   = fnc_covNumber(getToday());

        //CHECK_DATE!!!
        var tag_ymd = document.getElementById("hidTAG_YM").value+"01";
        var hol_ymd = addDate("M", tag_ymd, -1);

        //��û�Ⱓ
        var holFrom = fnc_covNumber(hol_ymd.substr(0, 6)+"16");
        var holTo   = fnc_covNumber(tag_ymd.substr(0, 6)+"15");

        if(row > 0) {

            //������ ��û�Ⱓ�̸� �Է�â Ǯ�� ����
            /*
             * TEST
            if(holFrom <= today && today <= holTo) {
             */
                //��������̰ų� �ΰ��϶� ������ ������
                if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
                        || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N"
                        || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "R") {

                    //�ű��� ���
                    if(dsT_CP_NIGHTDUTY.RowStatus(row) == "1") {
                        fnc_EnableElementAll(elementList);
                    } else {
                        //��� ����
                        fnc_ChangeStateElement(true, "txtREMARK");
                    }

                    grdT_CP_NIGHTDUTY.Editable = "true";
                }
            /*
            }
            */
        }
    </script>


    <!-------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|
    +-------------------------------------->
    <script language="javascript"  for=grdT_CP_NIGHTDUTY  event=OnRowPosChanged(row)>

    </script>

	<!-----------------------------------------------------+
    | Grid Ŭ���� ������Ȳ ��ȸ	  				   |
    +------------------------------------------------------>
	<script language="javascript" for=grdT_CP_NIGHTDUTY event=OnClick(row,colid)>

        if (row > 0
                && colid.substring(0,2) == "AT") {

            //��¥ ó���� ����
            if(dsT_CP_NIGHTDUTY.NameValue(row, "MD_DSP") < 1){
                alert("�ش����� ���� �Է��ϼ���!");
                return;
            }else if(colid.length > 6){//�ش���� ������������ ū ���ڴ� ������ �� ������ �Ѵ�.
                if(colid.substring(2,4) > dsT_CP_NIGHTDUTY.NameValue(row, "MD_DSP")){
                    return;
                }
            }

            //��������̰ų� �ΰ��϶� ������ ������
            if(!(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
                    || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N"
                    || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "R")) {
                return;
            }

            if(dsT_CP_NIGHTDUTY.NameValue(row, colid) == "Y"){
                dsT_CP_NIGHTDUTY.NameValue(row, colid) = "";
                dsT_CP_NIGHTDUTY.NameValue(row, "DUTY_CNT") = dsT_CP_NIGHTDUTY.NameValue(row, "DUTY_CNT") - 1;
            }else{
                dsT_CP_NIGHTDUTY.NameValue(row, colid) = "Y";
                dsT_CP_NIGHTDUTY.NameValue(row, "DUTY_CNT") = dsT_CP_NIGHTDUTY.NameValue(row, "DUTY_CNT") + 1;
            }
            dsT_CP_NIGHTDUTY.NameValue(row, "DUTY_AMT") = dsT_CP_NIGHTDUTY.NameValue(row, "DUTY_CNT") * 15000;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ö�ߴ������û</td>
					<td align="right" class="navigator">HOME/���°���/ö�ߴ���/<font color="#000000">ö�ߴ������û</font></td>
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
            <img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                        	<col width="100"></col>
                            <col width="80"></col>
                            <col width="90"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">�ش���&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YM','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','115');"><img src="/images/button/btn_HelpOn.gif" name="img_YM" width="21" height="20" border="0" align="absmiddle"></a>
                                <input type="hidden" id="hidTAG_YM">
                            </td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
                            <td class="padding2423" align="left">
                                <input id="hidDPT_CD_ORI" type="hidden">
                                <input id="txtDPT_CD_SHR" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                <input id="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
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

<table border="0">
    <tr>
    	<td valign="top">
        	<!-- ���� �Է� ���̺� ���� -->
        	<table width="375" border="0" cellspacing="0" cellpadding="0">
        		<tr>
        			<td class="paddingTop8">
                        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="70"></col>
                                <col width="120"></col>
                                <col width="70"></col>
                                <col width="*"  ></col>
                            </colgroup>
                            <tr>
                                <td align="center" class="creamBold">�����ȣ</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                    <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

                                    <input type="hidden" id="txtJOB_CD">
                                    <input type="hidden" id="txtJOB_NM">
                                    <input type="hidden" id="txtDPT_CD">
                                    <input type="hidden" id="txtDPT_NM">
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="creamBold">�����ϼ�</td>
                                <td class="padding2423">
                                    <input id="txtDUTY_CNT" size="5" style="text-align:right;" class="input_ReadOnly" readonly>
                                </td>
                                <td align="center" class="creamBold">��������</td>
                                <td class="padding2423">
			                        <comment id="__NSID__"><object id="medDUTY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
			                            <param name=Alignment                   value=2>
			                            <param name=Border                      value=true>
			                            <param name=ClipMode                    value=true>
			                            <param name=DisabledBackColor   value="#EEEEEE">
			                            <param name=Enable                      value=false>
			                            <param name=IsComma                 value=true>
			                            <param name=Language                    value=0>
			                            <param name=MaxLength               value=9>
			                            <param name=Numeric                 value=true>
			                            <param name=ShowLiteral             value="false">
			                            <param name=Visible                     value="true">
			                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" class="creamBold">���</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtREMARK" style="width=100%" onKeyUp="fc_chk_byte(this,50)">
                                </td>
                            </tr>
                        </table>
        			</td>
        		</tr>
        	</table>
        	<!-- ���� �Է� ���̺� �� -->
    	</td>
    	<td valign="top">

            <table width="420" border="0">
                <tr>
			        <td class="paddingTop8">
	                    <table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse"  bordercolor="#999999" align="center">
                            <tr align="center" height="25">
                                <td class="creamBold" width="100">������<input type="hidden" id="txtA2_ENO_NO"></td>
                                <td class="creamBold" width="100">����������<input type="hidden" id="txtA2_ENO_NO"></td>
                                <td class="creamBold" width="100">�μ���<input type="hidden" id="txtA3_ENO_NO"></td>
                                <td class="creamBold" width="100">������<input type="hidden" id="txtA4_ENO_NO"></td>
                            </tr>
	                        <tr align="center" height="25">
	                            <td id="txtA1_ENO_NM"></td>
	                            <td id="txtA2_ENO_NM"></td>
	                            <td id="txtA3_ENO_NM"></td>
	                            <td id="txtA4_ENO_NM"></td>
	                        </tr>
	                        <tr align="center" height="50">
	                            <td id="txtA1_APP_STS"></td>
	                            <td id="txtA2_APP_STS"></td>
	                            <td id="txtA3_APP_STS"></td>
	                            <td id="txtA4_APP_STS"></td>
	                        </tr>
	                    </table>
					</td>
                </tr>
                <tr>
                    <td align="right" height="20">
                        <img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                        <img src="/images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;"></a>
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
            <table width="60%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
        <td align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)"> <img src="/images/button/btn_AppendOn.gif" name="imgAppend"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)"> <img src="/images/button/btn_RemoveOn.gif"  name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;" colspan="2">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_NIGHTDUTY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
					<param name="DataID" value="dsT_CP_NIGHTDUTY">
					<param name="Editable" value="false">
					<param name="DragDropEnable" value="true">
					<param name="SortView" value="Left">
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

	<!-- T_CP_NIGHTDUTY ���� ���̺� -->
	<object id="bndT_CP_NIGHTDUTY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CP_NIGHTDUTY">
		<Param Name="BindInfo", Value="
            <C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
            <C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
            <C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
            <C>Col=DPT_NM		Ctrl=hidDPT_NM		Param=value</C>
            <C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
            <C>Col=JOB_NM		Ctrl=hidJOB_NM		Param=value</C>
            <C>Col=DUTY_CNT		Ctrl=txtDUTY_CNT	Param=value</C>
            <C>Col=DUTY_AMT		Ctrl=medDUTY_AMT	Param=text </C>
            <C>Col=REMARK	    Ctrl=txtREMARK		Param=value </C>
		">
	</object>