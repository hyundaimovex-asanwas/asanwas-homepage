	<!--*************************************************************************
	* @source      : welk011.jsp												*
	* @description : ���Խ�û PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/12/17            ������                     ��ٹ�����û �����ۼ�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="common.util.DateUtil" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //���
	String eno_nm = box.getString("SESSION_ENONM");         //����
	String dep_cd = box.getString("SESSION_DPTCD");         //�μ�
	String dep_nm = box.getString("SESSION_DPTNM");         //�μ���
	String job_nm = box.getString("SESSION_JOBNM");         //����
	String nam_eng = box.getString("SESSION_NAM_ENG");         //������
	String eng_dpt_nm = box.getString("SESSION_ENG_DPT_NM");         //�����μ���
	String eng_job_nm = box.getString("SESSION_ENG_JOB_NM");         //����������

	String SESSION_ROLE_CD = box.getString("SESSION_ROLE_CD");         //����

	// ����
	int dayOfWeek = DateUtil.getDayOfWeek(new Date());
	// ����ð�
	String CurHour = DateUtil.getCurrentHour();

	System.out.println("���� [" + dayOfWeek + "] �ð� [" + CurHour + "]");
%>
<html>
<head>
	<title>���Խ�û(welj010)</title>
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
		//��.��û���� : ���� ������, �ݿ��� ���� 04:00
		if(4 == <%=dayOfWeek%> || 6 == <%=dayOfWeek%> ){
			if("<%=CurHour%>" >= "16"){
				alert("��û������ ���� ������, �ݿ��� ���� 4�ñ����Դϴ�");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			}
		}else{
		}

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_WL_CARD_SHR.KeyValue = "tr05(O:dsT_WL_CARD=dsT_WL_CARD)";
			trT_WL_CARD_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.k.welk010.cmd.WELK010CMD"
                                   + "&S_MODE=SHR"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_WL_CARD_SHR.post();
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
			trT_WL_CARD.KeyValue = "tr01(I:dsT_WL_CARD=dsT_WL_CARD)";
			trT_WL_CARD.action = "/servlet/GauceChannelSVL?cmd=hr.wel.k.welk010.cmd.WELK010CMD&S_MODE=SAV";
			trT_WL_CARD.post();
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
			// �� �߰�
			dsT_WL_CARD.AddRow();
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENO_NM") = "<%=eno_nm%>";
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "DPT_NM") = "<%=dep_nm%>";
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "JOB_NM") = "<%=job_nm%>";
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "NAM_ENG") = "<%=nam_eng%>";
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENG_DPT_NM") = "<%=eng_dpt_nm%>";
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENG_JOB_NM") = "<%=eng_job_nm%>";

        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_CARD.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
				var endTag = dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "END_TAG");
				if(endTag == "T"){
					alert("�߱��� �Ϸ�� �����ʹ� �����Ҽ� �����ϴ�");
					return;
				}
           		var tmpMSG = "�����Ͻðڽ��ϱ�?\n";

	            if( confirm(tmpMSG) ){
					dsT_WL_CARD.DeleteRow(dsT_WL_CARD.RowPosition);
					trT_WL_CARD.KeyValue = "tr01(I:dsT_WL_CARD=dsT_WL_CARD)";
					trT_WL_CARD.action = "/servlet/GauceChannelSVL?cmd=hr.wel.k.welk010.cmd.WELK010CMD&S_MODE=DEL";
					trT_WL_CARD.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_CARD.ClearData();
			dsT_WL_CARD.ClearData();
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
			var NAM_ENG = document.getElementById("txtNAM_ENG").value;
			var TEL1	= document.getElementById("txtTEL1").value;
			var TEL2	= document.getElementById("txtTEL2").value;
			var TEL3	= document.getElementById("txtTEL3").value;

			var MOBILE1	= document.getElementById("txtMOBILE1").value;
			var MOBILE2	= document.getElementById("txtMOBILE2").value;
			var MOBILE3	= document.getElementById("txtMOBILE3").value;

			var FAX1	= document.getElementById("txtFAX1").value;
			var FAX2	= document.getElementById("txtFAX2").value;
			var FAX3	= document.getElementById("txtFAX3").value;

			var ADDR	= document.getElementById("txtADDR").value;

			var EMAIL	= document.getElementById("txtEMAIL").value;

			if(NAM_ENG == ""){
				alert("���������� �Է��Ͻʽÿ�");
				document.getElementById("txtNAM_ENG").focus();
				return;
			}
			if(TEL1 == ""){
				alert("��ȭ��ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtTEL1").focus();
				return;
			}
			if(TEL2 == ""){
				alert("��ȭ��ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtTEL2").focus();
				return;
			}
			if(TEL3 == ""){
				alert("��ȭ��ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtTEL3").focus();
				return;
			}
			if(MOBILE1 == ""){
				alert("�̵���ȭ��ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtMOBILE1").focus();
				return;
			}
			if(MOBILE2 == ""){
				alert("�̵���ȭ��ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtMOBILE2").focus();
				return;
			}
			if(MOBILE3 == ""){
				alert("�̵���ȭ��ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtMOBILE3").focus();
				return;
			}
			if(FAX1 == ""){
				alert("�ѽ���ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtFAX1").focus();
				return;
			}
			if(FAX2 == ""){
				alert("�ѽ���ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtFAX2").focus();
				return;
			}
			if(FAX3 == ""){
				alert("�ѽ���ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtFAX3").focus();
				return;
			}
			if(ADDR == ""){
				alert("ȸ���ּҸ� �����Ͻʽÿ�");
				document.getElementById("txtADDR").focus();
				return;
			}
			if(EMAIL == ""){
				alert("�̸����� �Է��Ͻʽÿ�");
				document.getElementById("txtEMAIL").focus();
				return;
			}
         	if ( !dsT_WL_CARD.isUpdated && !dsT_WL_CARD.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_WL_CARD.SetDataHeader(
        	        			"ENO_NO:STRING(11):KEYVALUETYPE,"+			// ���
								"SEQ:DECIMAL(2):KEYVALUETYPE,"+			// ���
	                            "REQ_YMD:STRING(10),"+			// ����
								"REMARK:STRING(100)"			// ���
								);
			document.getElementById("txtENO_NO").value = "<%=eno_no%>";
			document.getElementById("txtENO_NM").value = "<%=eno_nm%>";
			document.getElementById("txtDPT_NM").value = "<%=dep_nm%>";
			document.getElementById("txtJOB_NM").value = "<%=job_nm%>";

<%
    //�����ʹ� ���μ� ����
    if("1001".equals(SESSION_ROLE_CD) || "1002".equals(SESSION_ROLE_CD)  ) {
%>

<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=dep_cd%>";
			document.getElementById('ImgEnoNo').style.display = "none";

<%
	}
%>

			cfStyleGrid2(form1.grdT_WL_CARD,0,"true","false");      // Grid Style ����

			fnc_SearchList();

        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
<%
    //�����ʹ� ���μ� ����
    if("1001".equals(SESSION_ROLE_CD) || "1002".equals(SESSION_ROLE_CD)  ) {
%>
            document.getElementById('hidEMPL_DPT_CD').value = "";
<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=dep_cd%>";
			document.getElementById('ImgEnoNo').style.display = "none";

<%
	}
%>

            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
				fnc_CmPerson();
            }
        }
		function fnc_CmPerson(eno_no){
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_CM_PERSON.KeyValue = "tr05(O:dsT_CM_PERSON=dsT_CM_PERSON)";
			trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.wel.k.welk010.cmd.WELK010CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_CM_PERSON.post();
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

            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }


        //������ ��¥���� üũ
        function fnc_ChkDate() {

            var PIS_YYMM = document.getElementById("txtPIS_YYMM").value.replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(PIS_YYMM != ""){
	            if(PIS_YYMM < today.substring(0,6)){
	                alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
	                document.getElementById("txtPIS_YYMM").value = "";
	                document.getElementById("txtPIS_YYMM").focus();
	                return false;
	            }
            }

        }
		function fnc_Addr(){

			var addval = document.getElementById("txtADDR").value;

			if (addval=="1") {
				document.getElementById("txtENG_ADDR").value = "66 Jeokseon-dong, Jongno-gu, Seoul 110-052, Korea";
			} else if(addval=="2") {
				document.getElementById("txtENG_ADDR").value ="Hyundai Pusan New-port Terminal Main Bldg, 1522 Seongbuk-dong, Gangseo-gu, Busan 618-410, Korea";
			} else if(addval=="3") {
				document.getElementById("txtENG_ADDR").value = "8F 45 4ga Namdaemunro, Jung-gu, Seoul, 100-743, Korea";
			} else if(addval=="4") {
				document.getElementById("txtENG_ADDR").value = "5F Hyundai Logiem, Christian World Bldg., Yeonji-dong 1-1, Jongno-gu, Seoul, Korea";
			} else if(addval=="5") {
				document.getElementById("txtENG_ADDR").value = "Dept IT,Hyundai Elevator LTD. Bubal-eup,Icheon-si, Kyounggi-do,Korea";
			} else if(addval=="6") {
				document.getElementById("txtENG_ADDR").value = "1-83 Dongsung-dong, Jongno-gu, Seoul 110-510, Korea";
			}
			else if(addval=="7") {
				document.getElementById("txtENG_ADDR").value = "Hyundai Building 140-2, Kye-Dong, Jongno-Gu, Seoul, 110-793, Korea";
			}
			else if(addval=="8") {
				document.getElementById("txtENG_ADDR").value = "Hungkuk Bldg 12F., 226 Sinmunno-1ga, Jongno-gu, Seoul 110-786, Korea";
			}
			else if(addval=="9") {
				document.getElementById("txtENG_ADDR").value = "12th Floor, Capital Tower 736-1, Yeoksam-dong, Kangnam-gu, Seoul 135-983, Korea";
			}else if(addval=="10") {
				document.getElementById("txtENG_ADDR").value = "Hyundai Group Bldg., 1-7 Yeonji-dong, Jongno-gu, Seoul, Korea";
			}else if(addval=="11") {
				document.getElementById("txtENG_ADDR").value = "36-1 Yeouido-Dong Yeongdeungpo-Gu, SEOUL,KOREA,150-886";
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_CARD)			 	   |
    | 3. ���Ǵ� Table List(T_WL_CARD) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_CARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)			 	   |
    | 3. ���Ǵ� Table List(T_CM_PERSON) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_CARD)		       |
    | 3. ���Ǵ� Table List(T_WL_CARD)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_CARD_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_CARD=dsT_WL_CARD)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_CARD)		       |
    | 3. ���Ǵ� Table List(T_WL_CARD)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_CARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_CARD=dsT_WL_CARD)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_CARD)		       |
    | 3. ���Ǵ� Table List(T_WL_CARD)			       |
    +------------------------------------------------------>
	<Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CM_PERSON=dsT_CM_PERSON)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_CARD Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_CARD.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_CARD Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_CARD Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=trT_CM_PERSON Event="OnSuccess()">

		if (dsT_CM_PERSON.CountRow > 0)    {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENO_NO") = dsT_CM_PERSON.NameValue(1, "ENO_NO");
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENO_NM") = dsT_CM_PERSON.NameValue(1, "ENO_NM");
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "NAM_ENG") = dsT_CM_PERSON.NameValue(1, "NAM_ENG");
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "DPT_NM") = dsT_CM_PERSON.NameValue(1, "DPT_NM");
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "JOB_NM") = dsT_CM_PERSON.NameValue(1, "JOB_NM");
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENG_JOB_NM") = dsT_CM_PERSON.NameValue(1, "ENG_JOB_NM");
			dsT_WL_CARD.NameValue(dsT_WL_CARD.RowPosition, "ENG_DPT_NM") = dsT_CM_PERSON.NameValue(1, "ENG_DPT_NM");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=trT_CM_PERSON Event="OnFail()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
		fnc_SearchList();
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_CARD event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_CARD_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_CARD event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>


	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for="dsT_WL_CARD" event=OnRowPosChanged(row)>
		var endTag = dsT_WL_CARD.NameValue(row, "END_TAG");
		if(endTag == "T"){
			fnc_ChangeStateElement(false, "txtTEL1");
			fnc_ChangeStateElement(false, "txtTEL2");
			fnc_ChangeStateElement(false, "txtTEL3");
			fnc_ChangeStateElement(false, "txtMOBILE1");
			fnc_ChangeStateElement(false, "txtMOBILE2");
			fnc_ChangeStateElement(false, "txtMOBILE3");
			fnc_ChangeStateElement(false, "txtFAX1");
			fnc_ChangeStateElement(false, "txtFAX2");
			fnc_ChangeStateElement(false, "txtFAX3");
			fnc_ChangeStateElement(false, "txtADDR");
			fnc_ChangeStateElement(false, "txtEMAIL");
			fnc_ChangeStateElement(false, "txtREMARK");
		}else{
			fnc_ChangeStateElement(true, "txtTEL1");
			fnc_ChangeStateElement(true, "txtTEL2");
			fnc_ChangeStateElement(true, "txtTEL3");
			fnc_ChangeStateElement(true, "txtMOBILE1");
			fnc_ChangeStateElement(true, "txtMOBILE2");
			fnc_ChangeStateElement(true, "txtMOBILE3");
			fnc_ChangeStateElement(true, "txtFAX1");
			fnc_ChangeStateElement(true, "txtFAX2");
			fnc_ChangeStateElement(true, "txtFAX3");
			fnc_ChangeStateElement(true, "txtADDR");
			fnc_ChangeStateElement(true, "txtEMAIL");
			fnc_ChangeStateElement(true, "txtREMARK");
		}

	</script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"  onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���Խ�û</td>
					<td align="right" class="navigator">HOME/�����Ļ�/����/<font color="#000000">���Խ�û</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->


	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" class="input_ReadOnly"  readonly maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readonly maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">

                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td class="creamBold" align="center">��������</td>
                    <td class="padding2423">
                        <input id="txtNAM_ENG" name="txtNAM_ENG" size="20" maxlength="20" class="input_ReadOnly"  readonly>
                    </td>

					<td align="center" class="creamBold">�����Ҽ�</td>
					<td class="padding2423"><input id="txtENG_DPT_NM" size="30" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423"><input id="txtENG_JOB_NM" size="30" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">TEL</td>
                    <td class="padding2423">
                        <input id="txtTEL1" name="txtTEL1" size="4" maxlength="4" > -
                        <input id="txtTEL2" name="txtTEL2" size="4" maxlength="4" > -
                        <input id="txtTEL3" name="txtTEL3" size="4" maxlength="4" >
                    </td>
					<td class="creamBold" align="center">MOBILE</td>
                    <td class="padding2423">
                        <input id="txtMOBILE1" name="txtMOBILE1" size="4" maxlength="4" > -
                        <input id="txtMOBILE2" name="txtMOBILE2" size="4" maxlength="4" > -
                        <input id="txtMOBILE3" name="txtMOBILE3" size="4" maxlength="4" >
					</td>
					<td class="creamBold" align="center">FAX</td>
                    <td class="padding2423">
                        <input id="txtFAX1" name="txtFAX1" size="4" maxlength="4" > -
                        <input id="txtFAX2" name="txtFAX2" size="4" maxlength="4" > -
                        <input id="txtFAX3" name="txtFAX3" size="4" maxlength="4" >
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�ּ�</td>
                    <td class="padding2423" colspan="3">
					  <select id="txtADDR" name = "txtADDR" width="40" onChange="fnc_Addr()" >
						<option value="10" >110-754 ����Ư���� ���α� ������ 1-7 ����׷� </option>
						<option value="2" >618-410 �λ�� ������ ���ϵ� 1522���� ����λ���׸� 6��</option>
						<option value="3" >100-743 ����� �߱� ���빮�� 4�� 45���� ���ѻ��ȸ�Ǽ� B/D 8��</option>
						<option value="4" >110-738 ����� ���α� ������ 1-1���� ������ȸ�� �����������5��</option>
						<option value="5" >467-734 ��⵵ ��õ�� �ι��� ���뿤�������͢� ���������</option>
						<option value="6" >110-510 ����� ���α� ������ 1-83 ���뿤�������͢� 3�� ���������</option>
						<option value="7" >110-793 ����� ���α� �赿 140-2 �������</option>
						<option value="8" >110-786 ���� ���α� �Ź���1�� 226 �ﱹ�������12F </option>
						<option value="9" >135-983 ����� ������ ���ﵿ 736-1 ĳ��ŻŸ�� 12��</option>
						<option value="1" >110-052 ����Ư���� ���α� ������ 66����</option>
						<option value="11" >150-886 ����� �������� ���ǵ��� 36-1���� Ű��FS���� 8�� ��������</option>
					  </select>
					</td>
					<td class="creamBold" align="center">E-MAIL</td>
                    <td class="padding2423">
                        <input id="txtEMAIL" name="txtEMAIL" size="15" maxlength="20" >@hdasan.com
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�����ּ�</td>
                    <td class="padding2423" colspan="5">
					  <input id="txtENG_ADDR" name="txtENG_ADDR" size="100" maxlength="100" class="input_ReadOnly"  readonly >
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">���</td>
                    <td class="padding2423" colspan="5">
					  <input id="txtREMARK" name="txtREMARK" size="100" maxlength="100" >
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->
	<p>
��.��û���� : ���� ������, �ݿ��� ���� 04:00				<br>
��.��û�������� �߱���Ȳ�� [�Ϸ�] �� �λ������� ���ɰ���	<br>
��.Ư�̻����� ������ �ۼ��Ͻñ� �ٶ��ϴ�.					<br>

	</p>
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
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
	<!-- ���� ��ȸ �׸��� ���̺� ��-->


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_CARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_CARD">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29   name="NO"		align=center	value={String(Currow)}</C>
                            <C> id="ENO_NO"     width=100  name="���"      align=center    edit=none     show=false        </C>
							<C> id="SEQ"	    width=100  name="����"      align=center      </C>
							<C> id="REQ_YMD"    width=100  name="��û��"    align=center      </C>
							<C> id="NAM_ENG"    width=200  name="������"    align=center      </C>
							<C> id="END_TAG"    width=100  name="�߱���Ȳ"    align=center   value={DECODE(END_TAG,"T","�Ϸ�","������")}   </C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->
	<!-- T_WL_CARD ���� ���̺� -->
	<object id="bndT_WL_CARD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_CARD">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=Value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=Value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=Value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=Value</C>
			<C>Col=NAM_ENG	    Ctrl=txtNAM_ENG		Param=Value</C>
			<C>Col=ENG_DPT_NM	Ctrl=txtENG_DPT_NM  Param=Value</C>
			<C>Col=ENG_JOB_NM	Ctrl=txtENG_JOB_NM  Param=Value</C>
			<C>Col=TEL1			Ctrl=txtTEL1		Param=Value</C>
			<C>Col=TEL2			Ctrl=txtTEL2		Param=Value</C>
			<C>Col=TEL3			Ctrl=txtTEL3		Param=Value</C>
			<C>Col=MOBILE1		Ctrl=txtMOBILE1		Param=Value</C>
			<C>Col=MOBILE2		Ctrl=txtMOBILE2		Param=Value</C>
			<C>Col=MOBILE3		Ctrl=txtMOBILE3		Param=Value</C>
			<C>Col=FAX1			Ctrl=txtFAX1		Param=Value</C>
			<C>Col=FAX2			Ctrl=txtFAX2		Param=Value</C>
			<C>Col=FAX3			Ctrl=txtFAX3		Param=Value</C>
			<C>Col=ADDR		    Ctrl=txtADDR	    Param=Value</C>
			<C>Col=EMAIL		Ctrl=txtEMAIL	    Param=Value</C>
			<C>Col=ENG_ADDR		Ctrl=txtENG_ADDR    Param=Value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=Value</C>
		">
	</object>
