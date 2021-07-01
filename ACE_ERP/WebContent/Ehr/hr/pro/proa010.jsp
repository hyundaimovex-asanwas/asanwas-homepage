	<!--*************************************************************************
	* @source      : proa010.jsp												*
	* @description : �������װ��� PAGE												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/17            ä����         	        �����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�������װ���(proa010)</title>
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

		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;
			var PMT_YY_SHR = document.form1.txtPMT_YY_SHR.value;

			if( PMT_YY_SHR == "" ){
				alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
				return;
			}

            trT_PM_PROMOTION_SHR.KeyValue = "tr01(O:dsT_PM_PROMOTION=dsT_PM_PROMOTION, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_PROMOTION_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&PMT_YY_SHR="+PMT_YY_SHR;
            trT_PM_PROMOTION_SHR.post();
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
			trT_PM_PROMOTION.KeyValue = "tr01(I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)";
			trT_PM_PROMOTION.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SAV";
			trT_PM_PROMOTION.post();
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
		}

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			document.getElementById("resultMessage").innerText = ' ';
  			document.form1.txtPENO_NO.value = "";
  			document.form1.txtPENO_NM.value = "";
  			document.form1.txtPENO_NO2.value = "";
  			document.form1.txtPENO_NM2.value = "";
  			document.form1.txtPMT_LBL_CNT.value = "";
  			document.form1.txtENO_NO_SHR.value = "";
  			document.form1.txtENO_NM_SHR.value = "";
  			//document.form1.txtPMT_YY_SHR.value = next_yy;
  			disableInput();

        	dsT_PM_RECOMMAND.ClearData();
        	dsT_PM_PROMOTION.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROMOTION.IsUpdated)  {
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
         	if (!dsT_PM_PROMOTION.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

	        cfStyleGrid(form1.grdT_PM_PROMOTION,15,"true","false");
	        disableInput();
	        document.form1.txtPMT_YY_SHR.value = next_yy;
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
         * ���հ� ���	                       			*
         ********************************************/
        function setTotal() {

            var GOG_GAV = document.form1.txtGOG_GAV.value;//�������
        	var GOG_HTT = document.form1.txtGOG_HTT.value;//�ټӱⰣ
        	var EDU_SCR = document.form1.txtEDU_SCR.value;//��������
        	var GUN_GTT = document.form1.txtGUN_GTT.value;//���»���
        	var SAN_SCR = document.form1.txtSAN_SCR.value;//�������
        	//var EXM_TIC = document.form1.txtEXM_TIC.value;//�������
        	var CEN_SCR = document.form1.txtCEN_SCR.value;//��õ����

        	if(GOG_GAV == "") GOG_GAV = "0";
        	if(GOG_HTT == "") GOG_HTT = "0";
        	if(EDU_SCR == "") EDU_SCR = "0";
        	if(GUN_GTT == "") GUN_GTT = "0";
        	if(SAN_SCR == "") SAN_SCR = "0";
        	//if(EXM_TIC == "") EXM_TIC = "0";
        	if(CEN_SCR == "") CEN_SCR = "0";

        	// && EXM_TIC != ""                   +EXM_TIC+"+"
        	//alert(GOG_GAV +",  "+ GOG_HTT +",  "+ EDU_SCR +",  "+ GUN_GTT +",  "+ SAN_SCR +",  "+ CEN_SCR);
        	if(GOG_GAV != "" && GOG_HTT != "" && EDU_SCR != "" && GUN_GTT != "" && SAN_SCR != "" && CEN_SCR != "" ){
	        	document.form1.txtSPC_TOT.value = eval(GOG_HTT+"+"+EDU_SCR+"+"+GUN_GTT+"+"+SAN_SCR+"+"+CEN_SCR+"+"+GOG_GAV);
        	}
        }

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	for(var i=17; i<81; i++){
  		 		if(

                    i==17 || // �⵵-1
                    i==18 || // ����-1
                    i==19 || // �⵵-2
                    i==20 || // ����-2
                    i==21 || // �⵵-3
                    i==22 || // ����-3
                    i==23 || // �⵵-4
                    i==24 || // ����-4
                    i==25 || // �⵵-5
                    i==26 || // ����-5
                    i==27 || // ����1-1
                    i==28 || // ����1-2
                    i==29 || // ����1-3
                    i==30 || // ����1-4
                    i==31 || // ����1-5
                    i==33 || // �������
                    i==34 || // ����2-1
                    i==35 || // ����2-2
                    i==36 || // ����2-3
                    i==37 || // ����2-4
                    i==38 || // ����2-5

  		 		    i==41 || // ����1�⵵
  		 		    i==42 || // ����1�ڵ�
  		 		    i==43 || // ����1�ڵ��
  		 		    i==44 || // ����2�⵵
  		 		    i==45 || // ����2�ڵ�
  		 		    i==46 || // ����2�ڵ��
  		 		    i==47 || // ����3�⵵
  		 		    i==48 || // ����3�ڵ�
  		 		    i==49 || // ����3�ڵ��

  		 		    i==51 || // ����
  		 		    i==52 || // ����

  		 		    i==54 || // ���1�⵵
  		 		    i==55 || // ���1���
  		 		    i==56 || // ���2�⵵
  		 		    i==57 || // ���2���
  		 		    i==58 || // ���3�⵵
  		 		    i==59 || // ���3���

  		 		    i==61 || // ����1�⵵
  		 		    i==62 || // ����1���
  		 		    i==63 || // ����1����
  		 		    i==64 || // ����2�⵵
  		 		    i==65 || // ����2���
  		 		    i==66 || // ����2����
  		 		    i==67 || // ����3�⵵
  		 		    i==68 || // ����3���
  		 		    i==69 || // ����3����

  		 		    i==71 || // 1�� ��õ�� ���
  		 		    i==72 || // 1�� ��õ�� ����
  		 		    i==73 || // 2�� ��õ�� ���
  		 		    i==74 || // 2�� ��õ�� ����
  		 		    i==75 || // ��õ����
  		 		    i==76    // ����
  		 		  ) continue;

  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}
  			document.form1.rdoEST_CD[0].disabled  = false;   // �������� radioButton
  			document.form1.rdoEST_CD[1].disabled  = false;   // �������� radioButton
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","edit")  = "";
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","HeadCheckEnable") = "true";
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	for(var i=17; i<81; i++){
  				document.form1.elements[i].readOnly = true;
	  			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.form1.rdoEST_CD[0].disabled  = true;   // �������� radioButton
  			document.form1.rdoEST_CD[1].disabled  = true;   // �������� radioButton
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","edit")  = "none";
  			form1.grdT_PM_PROMOTION.ColumnProp("EST_CD_CK","HeadCheckEnable") = "false";
  		}

  		/********************************************
         * �׸��� Ŭ���� ������ư ���� 	        		*
         ********************************************/
  		function checkPmtStatus(row){
  			var EST_CD = dsT_PM_PROMOTION.NameValue(row, "EST_CD");
  			if(EST_CD == "Y"){
  				document.form1.rdoEST_CD[0].checked = true;
  			}else{
  				document.form1.rdoEST_CD[1].checked = true;
  			}
  		}

  		/********************************************
         * �������� üũ�ڽ�(on Grid) üũ���ΰ���       		*
         ********************************************/
  		function fnc_chgEST_CD(){
  			if( document.form1.rdoEST_CD[0].checked ){
	  			dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD') = 'Y';
  				dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD_CK') = 'T';
  			}else{
	  			dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD') = 'N';
  				dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD_CK') = 'F';
  			}
  		}

  		/********************************************
         * ��õ�� ���� ������ȸ  					   		*
         ********************************************/
  		function fnc_SearchRecommander(row){
	  		document.form1.txtPENO_NO.value = "";
  			document.form1.txtPENO_NM.value = "";
	  		document.form1.txtPENO_NO2.value = "";
  			document.form1.txtPENO_NM2.value = "";
  			document.form1.txtPMT_LBL_CNT.value = "";

  			var ENO_NO = dsT_PM_PROMOTION.NameValue(row, "ENO_NO");
			var PMT_YY = dsT_PM_PROMOTION.NameValue(row, "PMT_YY");

			if( PMT_YY == "" ){
				alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
				return;
			}

			dsT_PM_RECOMMAND.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO+"&PMT_YY="+PMT_YY;
			dsT_PM_RECOMMAND.reset();
  		}

        /**
         * �������װ��� �Ϸ� ó��
         */
        function fnc_Complete() {
            var PMT_YY_SHR  = document.form1.txtPMT_YY_SHR.value;

            if(dsT_CP_WORKLOG.CountRow == 1) {
                if(parseInt(dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) > 2) {
                    alert("�̹� �������װ��� ó���� �Ǿ����ϴ�.");
                    return;
                }
            } else {
                alert("�������װ��� ó���� �� �� �����ϴ�.");
                return;
            }

            if (dsT_PM_PROMOTION.isUpdated ) {
                alert("������ �����Ͱ� �ֽ��ϴ�. ���� ������� ���ּ���.");
                return false;
            }

            if(!confirm("�������װ��� ó���� �Ͻðڽ��ϱ�?")){
                return false;
            }

            dsT_CP_WORKLOG_SAV.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa010.cmd.PROA010CMD&S_MODE=SAV_COM&PMT_YY_SHR="+PMT_YY_SHR;
            dsT_CP_WORKLOG_SAV.reset();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_PROMOTION)		 	   |
    | 3. ���Ǵ� Table List(T_PM_PROMOTION) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PROMOTION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_PM_RECOMMAND" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_WORKLOG_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_PM_PROMOTION)			   |
    | 3. ���Ǵ� Table List(T_PM_PROMOTION)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_PROMOTION_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<Object ID="trT_PM_PROMOTION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PROMOTION.CountRow);
        }
    </Script>

	<Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
		if(dsT_CP_WORKLOG.CountRow == 1){ // ����
			if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                disableInput();
                alert("�������õ�ڰ����� �Ϸ���� �ʾҽ��ϴ�.");
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "2") {
                enableInput();
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
                disableInput();
                alert("�̹� �������װ��� ó���� �Ǿ����ϴ�.");
            }
		}else{
            disableInput();
			alert("��������ڼ����� �Ϸ���� �ʾҽ��ϴ�.");
		}
    </Script>

	<Script For=dsT_CP_WORKLOG_SAV Event="OnLoadCompleted(iCount)">
        alert("�������װ��� ó���� �Ǿ����ϴ�.");
        disableInput();
        dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = "3";
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_RECOMMAND Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {
            document.form1.txtPENO_NO.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NO");
            document.form1.txtPENO_NM.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NM");
            document.form1.txtPENO_NO2.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NO2");
            document.form1.txtPENO_NM2.value = dsT_PM_RECOMMAND.NameValue(1, "PENO_NM2");
            document.form1.txtPMT_LBL_CNT.value = dsT_PM_RECOMMAND.NameValue(1, "PMT_LBL_CNT");

        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
	<Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
	<Script For=dsT_CP_WORKLOG_SAV Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CP_WORKLOG_SAV Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnFail()">
        alert(trT_PM_PROMOTION.ErrorMsg);
    </script>

    <script language=JavaScript for=dsT_PM_PROMOTION event=OnRowPosChanged(row)>

		checkPmtStatus(row);//������ư
		fnc_SearchRecommander(row);//��õ�� ��ȸ

	</script>

    <script language="javascript"  for=grdT_PM_PROMOTION event=OnClick(row,colid)>

        if(colid == "EST_CD_CK" && row != "0"){
            if(dsT_PM_PROMOTION.NameValue(row,colid) == "T"){
                dsT_PM_PROMOTION.NameValue(row,"EST_CD") = "Y";
            }else{
                dsT_PM_PROMOTION.NameValue(row,"EST_CD") = "N";
            }

            checkPmtStatus(row);//������ư
        }

    </script>

    <script language="javascript" for=grdT_PM_PROMOTION event=OnHeadCheckClick(Col,Colid,bCheck)>

        for(var i=1; i<=dsT_PM_PROMOTION.CountRow; i++) {
            if(bCheck == "1" || bCheck == "T"){
                dsT_PM_PROMOTION.NameValue(i, "EST_CD") = "Y";
                dsT_PM_PROMOTION.NameValue(i, "EST_CD_CK") = "T";

            }else{
                dsT_PM_PROMOTION.NameValue(i, "EST_CD") = "N";
                dsT_PM_PROMOTION.NameValue(i, "EST_CD_CK") = "F";
            }
        }

        checkPmtStatus(dsT_PM_PROMOTION.RowPosition);//������ư

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������װ���</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">�������װ���</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
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
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">�����⵵&nbsp;</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPMT_YY_SHR" name="txtPMT_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YY_SHR" name="imgPMT_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YY_SHR','','102','108');"></a>
							</td>
							<td align="right" class="searchState">���&nbsp;</td>
							<td class="padding2423" align="left">
	                            <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
	                            <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
	                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');"></a>
	                            <input type="hidden" id="hidEMPL_DPT_CD">
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
                    <td colspan="10">
    					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="paddingTop8">
                                    <img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
                                    <strong>�λ�����</strong>
                                </td>
                            </tr>
                        </table>
                    </td>
				</tr>
				<tr>
					<td>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width="105"></col>
							<col width="60"></col>
							<col width="105"></col>
							<col width="60"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">���</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO" size="11" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">����</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�ٷα���</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidOCC_CD">
								<input id="txtOCC_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidJOB_CD">
								<input id="txtJOB_NM" size="11" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�Ի�����</td>
							<td class="padding2423" align="left">
								<input id="txtHIR_YMD" size="11" class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
                            <td align="center" class="creamBold">��������</td>
                            <td class="padding2423" align="left">
                                <input id="txtRET_YMD" size="11" class="input_ReadOnly" readonly>
                            </td>
							<td align="center" class="creamBold">�ι�</td>
							<td class="padding2423" align="left">
								<input id="txtHEAD_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�Ҽ�</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidDPT_CD">
								<input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�������</td>
							<td class="padding2423" align="left">
								<input id="txtBIR_YMD" size="11" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input id="txtJPR_YMD" size="11" class="input_ReadOnly" readonly>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td class="paddingTop8" colspan="10">
					   <img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
					   <strong>�������</strong>
					</td>
				</tr>
				<tr>
					<td colspan="10">
					<table width="100%" border="1" cellspacing="2" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<tr>
						<td>
						<table align="center" width="98%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="90"></col>
							<col width="50"></col>
							<col width="80"></col>
                            <col width="65"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td>&nbsp;&nbsp;<input id="txtGOG_YY5" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>����&nbsp;&nbsp;<input id="txtGOG_Y51" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY4" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>����&nbsp;&nbsp;<input id="txtGOG_Y41" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY3" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>����&nbsp;&nbsp;<input id="txtGOG_Y31" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY2" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>����&nbsp;&nbsp;<input id="txtGOG_Y21" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY1" size="4" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"> : </td>
							<td>����&nbsp;&nbsp;<input id="txtGOG_Y11" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
                            <td>�������</td>
							<td>�������</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;&nbsp;�⵵</td>
							<td>����1 <input id="txtGOG_Y52" size="2   " maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;�⵵</td>
							<td>����1 <input id="txtGOG_Y42" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;�⵵</td>
							<td>����1 <input id="txtGOG_Y32" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;�⵵</td>
							<td>����1 <input id="txtGOG_Y22" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;�⵵</td>
							<td>����1 <input id="txtGOG_Y12" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
                            <td>&nbsp;<input id="txtGOG_GAV" size="5" maxLength="5" style="ime-mode:disabled" onKeypress="cfNumberCheck();" onblur="setTotal();" >&nbsp;</td>
							<td>&nbsp;<input id="txtGOG_TOT" size="5" maxLength="5" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>����2 <input id="txtGOG_Y53" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>����2 <input id="txtGOG_Y43" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>����2 <input id="txtGOG_Y33" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>����2 <input id="txtGOG_Y23" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td>����2 <input id="txtGOG_Y13" size="2" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
                            <td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						</table>
						</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="10" class="paddingTop5">
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="60"></col>
							<col width="30"></col>
							<col width="60"></col>
							<col width="165"></col>
							<col width="60"></col>
							<col width="165"></col>
							<col width="60"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">�ټӱⰣ</td>
							<td class="padding2423" align="left" colspan="10">
                                <input id="txtGOG_HTT" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();">
							</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_SCR" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();">
                            </td>
							<td align="center" class="creamBold">����1</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_YY1" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtEDU_KN1" size="2" class="input_ReadOnly" readonly> <input id="txtEDU_KN1_NM" size="9" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">����2</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_YY2" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtEDU_KN2" size="2" class="input_ReadOnly" readonly> <input id="txtEDU_KN2_NM" size="9" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">����3</td>
							<td class="padding2423" align="left">
                                <input id="txtEDU_YY3" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtEDU_KN3" size="2" class="input_ReadOnly" readonly> <input id="txtEDU_KN3_NM" size="9" class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">���»���</td>
							<td class="padding2423" align="left">
                                <input id="txtGUN_GTT" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();"></td>
							<td align="center" class="creamBold">����</td>
							<td class="padding2423" align="left">
                                <input id="txtGUN_GTB" size="3" maxLength="3" value="0" class="input_ReadOnly" readonly>
                            </td>
							<td align="center" class="creamBold">����</td>
							<td class="padding2423" align="left" colspan="5">
                                <input id="txtGUN_GTC" size="3" maxLength="3" value="0" class="input_ReadOnly" readonly>
                            </td>
						</tr>
                    </table>

                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                        <colgroup>
                            <col width="60"></col>
                            <col width="30"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
                            <td align="center" class="creamBold">�������</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_SCR" size="3" maxLength="3" style="ime-mode:disabled" value="0" onblur="setTotal();">
                            </td>
                            <td align="center" class="creamBold">���1</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_YY1" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtSAN_RM1" size="14" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">���2</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_YY2" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtSAN_RM2" size="14" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">���3</td>
                            <td class="padding2423" align="left">
                                <input id="txtSAN_YY3" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtSAN_RM3" size="14" class="input_ReadOnly" readonly>
                            </td>
						</tr>
                    </table>

                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="60"></col>
                            <col width="30"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
							<td align="center" class="creamBold">�������</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_TIC" size="3" style="ime-mode:disabled" value="0" maxLength="3">
                            </td>
							<td align="center" class="creamBold">����1</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_YY1" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtEXM_SC1" size="7" class="input_ReadOnly" readonly> <input id="txtEXM_PNT1" size="3" class="input_ReadOnly" readonly>��
                            </td>
							<td align="center" class="creamBold">����2</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_YY2" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtEXM_SC2" size="7" class="input_ReadOnly" readonly> <input id="txtEXM_PNT2" size="3" class="input_ReadOnly" readonly>��
                            </td>
							<td align="center" class="creamBold">����3</td>
							<td class="padding2423" align="left">
                                <input id="txtEXM_YY3" size="4" maxLength="4" style="ime-mode:disabled" class="input_ReadOnly" readonly>�⵵ <input id="txtEXM_SC3" size="7" class="input_ReadOnly" readonly> <input id="txtEXM_PNT3" size="3" class="input_ReadOnly" readonly>��
                            </td>
						</tr>
						<tr>
							<td align="center" class="creamBold">��õ����</td>
							<td class="padding2423" align="left">
                                <input id="txtCEN_SCR" size="3" maxLength="3" value="0" onblur="setTotal();">
                            </td>
							<td align="center" class="creamBold">1����õ��</td>
							<td class="padding2423" align="left">
								<input id="txtPENO_NO" size="9"  maxlength="10" class="input_ReadOnly" readonly>
								<input id="txtPENO_NM" size="13" style="text-align:center" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">2����õ��</td>
							<td class="padding2423" align="left">
								<input id="txtPENO_NO2" size="9"  maxlength="10" class="input_ReadOnly" readonly>
								<input id="txtPENO_NM2" size="13" style="text-align:center" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">��õ����</td>
							<td class="padding2423" align="left">
								<input id="txtPMT_LBL_CNT" size="3" class="input_ReadOnly" readonly>
							</td>
						</tr>
                    </table>
                </tr>
                <tr>
                    <td colspan="10" class="paddingTop5">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="60"></col>
                            <col width="30"></col>
                            <col width="60"></col>
                            <col width="165"></col>
                            <col width="60"></col>
                            <col width=""></col>
                        </colgroup>
						<tr>
							<td align="center" class="creamBold">����</td>
							<td class="padding2423" align="left">
                                <input id="txtSPC_TOT" size="3" maxLength="3" value="0" class="input_ReadOnly" readonly>
                            </td>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input type="radio" name="rdoEST_CD" id="rdoEST_CD" checked style="margin-bottom:-2px;border:0;background-color:#ffffff;" onClick="fnc_chgEST_CD()">����
								&nbsp;&nbsp;
								<input type="radio" name="rdoEST_CD" id="rdoEST_CD" style="margin-bottom:-2px;border:0;background-color:#ffffff;" onClick="fnc_chgEST_CD()">�̽���
							</td>
							<td align="center" class="creamBold">���</td>
							<td class="padding2423" align="left"><input id="txtREMARK" size="63" maxLength="22"></td>
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td class="searchState" align="right">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)">  <img src="/images/button/btn_ConductOn.gif"   name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Complete()"></a>
	                    </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_PM_PROMOTION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
						<param name="DataID" value="dsT_PM_PROMOTION">
						<param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id={currow}     width=29    name="NO"               align=center    Edit=none       </C>
                            <C> id="PMT_GBN"    width=40    name="����"             align=center    Edit=none   value={decode(PMT_GBN, 1, "����", 2, "Ư��")}</C>
                            <C> id="OCC_NM"     width=40    name="�ٷα���"             align=center    Edit=none                                     </C>
                            <C> id="DPT_NM"     width=105   name="�Ҽ�"             align=center    Edit=none                                     </C>
                            <C> id="JOB_NM"     width=50    name="����"             align=center    Edit=none                                     </C>
                            <C> id="ENO_NO"     width=70    name="���"             align=center    Edit=none                                     </C>
                            <C> id="ENO_NM"     width=70    name="����"             align=center    Edit=none                                     </C>
                            <C> id="BIR_YMD"    width=70    name="�������"         align=center    Edit=none                         show="false"</C>
                            <C> id="HIR_YMD"    width=70    name="�Ի���"           align=center    Edit=none                         show="false"</C>
                            <C> id="HIRG_YMD"   width=70    name="�׷�;�Ի���"      align=center    Edit=none                                     </C>
                            <C> id="JPR_YMD"    width=70    name="����;������"      align=center    Edit=none                                     </C>
                            <C> id="JPR_CON"    width=60    name="����;�����Ⱓ"    align=center    Edit=none                                     </C>
                            <C> id="HIR_CON"    width=60    name="�ټӱⰣ"         align=center    Edit=none                                     </C>
                            <C> id="REMARK"     width=120   name="���"             align=left      Edit=none                         show="false"</C>
                            <C> id="SPC_TOT"    width=50    name="����"             align=center    Edit=none                                     </C>
                            <C> id="EST_CD"     width="50"  name="����;����"        align=center    Edit=none   EditStyle=CheckBox    show="false"</C>
                            <C> id="EST_CD_CK"  width="50"  name="����;����"        align=center    Edit={Decode(EST_CD,"Y","T","F")}   EditStyle=CheckBox HeadCheckShow=true</C>
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
	<!-- T_WL_DININGUSE ���� ���̺� -->
	<object id="bndT_PM_PROMOTION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_PROMOTION">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO	    Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM    	Param=value</C>
			<C>Col=HEAD_NM		Ctrl=txtHEAD_NM		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=OCC_NM		Ctrl=txtOCC_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=PR_SEQ		Ctrl=hidPR_SEQ		Param=value</C>

			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=HIRG_YMD		Ctrl=txtHIRG_YMD	Param=value</C>

			<C>Col=JPR_YMD		Ctrl=txtJPR_YMD		Param=value</C>
			<C>Col=GOG_YY5		Ctrl=txtGOG_YY5		Param=value</C>
			<C>Col=GOG_Y51		Ctrl=txtGOG_Y51		Param=value</C>
			<C>Col=GOG_Y52		Ctrl=txtGOG_Y52		Param=value</C>
			<C>Col=GOG_Y53		Ctrl=txtGOG_Y53		Param=value</C>
			<C>Col=GOG_YY4		Ctrl=txtGOG_YY4		Param=value</C>
			<C>Col=GOG_Y41		Ctrl=txtGOG_Y41		Param=value</C>
			<C>Col=GOG_Y42		Ctrl=txtGOG_Y42		Param=value</C>
			<C>Col=GOG_Y43		Ctrl=txtGOG_Y43		Param=value</C>

			<C>Col=GOG_YY3		Ctrl=txtGOG_YY3		Param=value</C>
			<C>Col=GOG_Y31		Ctrl=txtGOG_Y31		Param=value</C>
			<C>Col=GOG_Y32		Ctrl=txtGOG_Y32		Param=value</C>
			<C>Col=GOG_Y33		Ctrl=txtGOG_Y33		Param=value</C>
			<C>Col=GOG_YY2		Ctrl=txtGOG_YY2		Param=value</C>
			<C>Col=GOG_Y21		Ctrl=txtGOG_Y21		Param=value</C>
			<C>Col=GOG_Y22		Ctrl=txtGOG_Y22		Param=value</C>
			<C>Col=GOG_Y23		Ctrl=txtGOG_Y23		Param=value</C>
			<C>Col=GOG_YY1		Ctrl=txtGOG_YY1		Param=value</C>
			<C>Col=GOG_Y11		Ctrl=txtGOG_Y11		Param=value</C>
			<C>Col=GOG_Y12		Ctrl=txtGOG_Y12		Param=value</C>
			<C>Col=GOG_Y13		Ctrl=txtGOG_Y13		Param=value</C>
			<C>Col=GOG_CNT		Ctrl=txtGOG_CNT		Param=value</C>

			<C>Col=GOG_TOT		Ctrl=txtGOG_TOT		Param=value</C>
			<C>Col=GOG_GAV		Ctrl=txtGOG_GAV		Param=value</C>
			<C>Col=GOG_HTT		Ctrl=txtGOG_HTT		Param=value</C>
			<C>Col=GUN_GTB		Ctrl=txtGUN_GTB		Param=value</C>
			<C>Col=GUN_GTC		Ctrl=txtGUN_GTC		Param=value</C>
			<C>Col=GUN_GTT		Ctrl=txtGUN_GTT		Param=value</C>

			<C>Col=EDU_YY1		Ctrl=txtEDU_YY1		Param=value</C>
			<C>Col=EDU_KN1		Ctrl=txtEDU_KN1		Param=value</C>
			<C>Col=EDU_KN1_NM	Ctrl=txtEDU_KN1_NM	Param=value</C>
			<C>Col=EDU_YY2		Ctrl=txtEDU_YY2		Param=value</C>
			<C>Col=EDU_KN2		Ctrl=txtEDU_KN2		Param=value</C>
			<C>Col=EDU_KN2_NM	Ctrl=txtEDU_KN2_NM	Param=value</C>
			<C>Col=EDU_YY3		Ctrl=txtEDU_YY3		Param=value</C>
			<C>Col=EDU_KN3		Ctrl=txtEDU_KN3		Param=value</C>
			<C>Col=EDU_KN3_NM	Ctrl=txtEDU_KN3_NM	Param=value</C>
			<C>Col=EDU_SCR		Ctrl=txtEDU_SCR		Param=value</C>

			<C>Col=SAN_YY1		Ctrl=txtSAN_YY1		Param=value</C>
			<C>Col=SAN_RM1		Ctrl=txtSAN_RM1		Param=value</C>
			<C>Col=SAN_YY2		Ctrl=txtSAN_YY2		Param=value</C>
			<C>Col=SAN_RM2		Ctrl=txtSAN_RM2		Param=value</C>
			<C>Col=SAN_YY3		Ctrl=txtSAN_YY3		Param=value</C>
			<C>Col=SAN_RM3		Ctrl=txtSAN_RM3		Param=value</C>
			<C>Col=SAN_SCR		Ctrl=txtSAN_SCR		Param=value</C>

			<C>Col=CEN_SCR		Ctrl=txtCEN_SCR		Param=value</C>

			<C>Col=EXM_YY1		Ctrl=txtEXM_YY1		Param=value</C>
            <C>Col=EXM_SC1      Ctrl=txtEXM_SC1     Param=value</C>
			<C>Col=EXM_PNT1     Ctrl=txtEXM_PNT1	Param=value</C>
			<C>Col=EXM_YY2		Ctrl=txtEXM_YY2		Param=value</C>
            <C>Col=EXM_SC2      Ctrl=txtEXM_SC2     Param=value</C>
			<C>Col=EXM_PNT2     Ctrl=txtEXM_PNT2	Param=value</C>
			<C>Col=EXM_YY3		Ctrl=txtEXM_YY3		Param=value</C>
            <C>Col=EXM_SC3      Ctrl=txtEXM_SC3     Param=value</C>
			<C>Col=EXM_PNT3     Ctrl=txtEXM_PNT3	Param=value</C>
			<C>Col=EXM_TIC		Ctrl=txtEXM_TIC		Param=value</C>

			<C>Col=SPC_TOT		Ctrl=txtSPC_TOT		Param=value</C>
			<C>Col=EXP_CD		Ctrl=txtEXP_CD		Param=value</C>
			<C>Col=EST_CD		Ctrl=txtEST_CD		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>

			<C>Col=EXM_CMP		Ctrl=txtEXM_CMP		Param=value</C>

		">
	</object>