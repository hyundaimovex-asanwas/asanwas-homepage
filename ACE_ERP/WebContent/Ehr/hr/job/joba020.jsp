<!--
    ************************************************************************************
    * @Source              : joba020.jsp                                               *
    * @Description        : �����̵������ۼ�                                           *
    * @Font                   :                                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  ������   | �����ۼ�                                               *
    * 2006/10/24  |  ������   | ���߿Ϸ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����̵������ۼ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		var btnList = 'FFTTFFFT';
		
		var ActiveIndex = 0;

        var oRSH_GBN = 1;//�����̵�, �ڱ�Ű� ��λ��
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        }

		/***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }

         /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			//���ÿ� �����ϰ� ����
			//msg�� trT_EV_QSTANS�� ����ϰ� �ߴ�

			if (!dsT_EV_CHGANS.IsUpdated && !dsT_EV_QSTANS.IsUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			if(fnc_SaveItemCheck1() && fnc_SaveItemCheck2()) {
				trT_EV_CHGANS.KeyValue = "SVL(I:dsT_EV_CHGANS=dsT_EV_CHGANS)";
				trT_EV_CHGANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_01&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value;
				trT_EV_CHGANS.post();
				
				trT_EV_QSTANS.KeyValue = "SVL(I:dsT_EV_QSTANS=dsT_EV_QSTANS)";
				trT_EV_QSTANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_02";
				trT_EV_QSTANS.post();
				
			} else {
				return;
			}

			/*
			if(ActiveIndex == 1){//�����̵���
				if(fnc_SaveItemCheck1()) {
					trT_EV_CHGANS.KeyValue = "SVL(I:dsT_EV_CHGANS=dsT_EV_CHGANS)";
					trT_EV_CHGANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_01&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value;
					trT_EV_CHGANS.post();
				} else {
					return;
				}
			}else if(ActiveIndex == 2){//�ڱ�Ű�
				if(fnc_SaveItemCheck2()) {
					trT_EV_QSTANS.KeyValue = "SVL(I:dsT_EV_QSTANS=dsT_EV_QSTANS)";
					trT_EV_QSTANS.action = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SAV_02";
					trT_EV_QSTANS.post();
				} else {
					return;
				}
			}
			*/

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			if(ActiveIndex == 1){//�����̵���
				dsT_EV_CHGANS.ClearData();
				dsT_EV_CHGANS.Reset();

				document.rdoCHANGE_GBN.CodeValue = "";
				document.rdoCHANGE_TIME.CodeValue = "";
				document.rdoNOCHANGE_GBN.CodeValue = "";

				document.rdoCHANGE_GBN.Enable = "true";
				document.rdoCHANGE_TIME.Enable = "true";
		        document.rdoNOCHANGE_GBN.Enable = "true";

				document.getElementById("txtCHANGE_DEC").value="";
				document.getElementById("txtCHANGE_DEC").readOnly = false;
				document.getElementById("txtCHANGE_DEC").className="";

				document.getElementById("txtNOCHANGE_DEC").value="";
				document.getElementById("txtNOCHANGE_DEC").readOnly = false;
				document.getElementById("txtNOCHANGE_DEC").className="";

				document.getElementById("txtHOPE_DEP1").readOnly = true;
				document.getElementById("txtHOPE_DEP1").className="";
				document.getElementById("txtHOPE_DEP1").value="";
				document.getElementById("txtHOPE_DEP1NM").value="";
				document.getElementById("img_HelpOn1").style.display = "";
				document.getElementById("txtHOPE_DEP2").readOnly = true;
				document.getElementById("txtHOPE_DEP2").className="";
				document.getElementById("txtHOPE_DEP2").value="";
				document.getElementById("txtHOPE_DEP2NM").value="";
				document.getElementById("img_HelpOn2").style.display = "";
				document.getElementById("txtHOPE_DEP3").readOnly = true;
				document.getElementById("txtHOPE_DEP3").className="";
				document.getElementById("img_HelpOn3").style.display = "";
				document.getElementById("txtHOPE_DEP3").value="";
				document.getElementById("txtHOPE_DEP3NM").value="";

			}else if(ActiveIndex == 2){//��������
				dsT_EV_QSTANS.ClearData();
				dsT_EV_QSTANS.Reset();

                document.grdT_EV_QSTANS.Enable = "true";

                for(i=1; i<=dsT_EV_QSTANS.CountRow; i++){
                    dsT_EV_QSTANS.NameValue(i,"ANS_A") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_B") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_C") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_D") = "F";
                    dsT_EV_QSTANS.NameValue(i,"ANS_E") = "F";
                }

			}
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_EV_CHGANS.IsUpdated)  {
	            if (!confirm("�����̵��� ���泻�� �����մϴ�.\n\nȮ���� �����ø� ����� �ڷ�� ������� �ʰ� ���� �˴ϴ�."))  return;
	        }

	        if (dsT_EV_QSTANS.IsUpdated)  {
	            if (!confirm("�ڱ�Ű��� ���泻�� �����մϴ�.\n\nȮ���� �����ø� ����� �ڷ�� ������� �ʰ� ���� �˴ϴ�."))  return;
	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/

        //�����̵� ��ȿ�� üũ
        function fnc_SaveItemCheck1() {
			var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
			/*
			if (!dsT_EV_CHGANS.IsUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}
			*/

			var oCHANGE_GBN, oCHANGE_DEC, oNOCHANGE_GBN, oNOCHANGE_DEC;
			var RowCnt = dsT_EV_CHGANS.CountRow;

			oCHANGE_GBN = dsT_EV_CHGANS.NameValue(RowCnt,"CHANGE_GBN");
			oNOCHANGE_GBN = dsT_EV_CHGANS.NameValue(RowCnt,"NOCHANGE_GBN");
			//if(oCHANGE_GBN.trim() == "" && oNOCHANGE_GBN.trim() == ""){
			//	alert("�����̵��� ���� ��� �Ǵ� �ǻ簡 ���� ����� �ϳ��̻� üũ�ؾ��մϴ�." );
			//	return false;
			//}

			oCHANGE_DEC = dsT_EV_CHGANS.NameValue(RowCnt,"CHANGE_DEC");
			if(document.rdoCHANGE_GBN.CodeValue == 4 && oCHANGE_DEC.trim() == "") {
				alert("�����̵��� ���� ��� �̵����� �׸��� ��Ÿ���븦 �Է��ϼ���" );
				document.getElementById("txtCHANGE_DEC").focus();
				return false;
			}

			oNOCHANGE_DEC = dsT_EV_CHGANS.NameValue(RowCnt,"NOCHANGE_DEC");
			if(document.rdoNOCHANGE_GBN.CodeValue == 4 && oNOCHANGE_DEC.trim() == "") {
				alert("�����̵� �ǻ簡 ���� ��� ���� �׸��� ��Ÿ�� �Է��ϼ���" );
				document.getElementById("txtNOCHANGE_DEC").focus();
				return false;
			}

			if(document.rdoNOCHANGE_GBN.CodeValue == "") {
				if(document.rdoCHANGE_GBN.CodeValue == ""){
					alert("�̵������� �����ϼ���");
					document.rdoCHANGE_GBN.Focus();
					return false;
				}
				if(document.rdoCHANGE_TIME.CodeValue == ""){
					alert("�̵��ñ⸦ �����ϼ���");
					document.rdoCHANGE_GBN.Focus();
					return false;
				}
				if(document.getElementById("txtHOPE_DEP1").value == ""){
					alert("�̵�����μ��� �����ϼ���");
					document.getElementById("txtHOPE_DEP1").focus();
					return false;
				}
			}


			return true;
        }

        //�ڱ�Ű� ��ȿ�� üũ
        function fnc_SaveItemCheck2() {
			var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            /*
			if (!dsT_EV_QSTANS.IsUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}
			*/

			var i = 0;
			var oANS_A, oANS_B, oANS_C, oANS_D, oANS_E;
			var RowCnt = dsT_EV_QSTANS.CountRow;

			for(i=1; i<=RowCnt; i++){
				oANS_A = dsT_EV_QSTANS.NameValue(i,"ANS_A");
				oANS_B = dsT_EV_QSTANS.NameValue(i,"ANS_B");
				oANS_C = dsT_EV_QSTANS.NameValue(i,"ANS_C");
				oANS_D = dsT_EV_QSTANS.NameValue(i,"ANS_D");
				oANS_E = dsT_EV_QSTANS.NameValue(i,"ANS_E");

				if((oANS_A.trim() == "F" || oANS_A.trim() == "") &&
				   (oANS_B.trim() == "F" || oANS_B.trim() == "") &&
				   (oANS_C.trim() == "F" || oANS_C.trim() == "") &&
				   (oANS_D.trim() == "F" || oANS_D.trim() == "") &&
				   (oANS_E.trim() == "F" || oANS_E.trim() == "")){
				   alert("�ڱ�Ű� "+i+"��°�� �����׸��� �������� �ʾҽ��ϴ�.");
				   return false;
				   /*
					if (confirm(i+"��°�� �����׸��� �������� �ʾҽ��ϴ�.\n �׷��� �����Ͻðڽ��ϱ�?")){
						return true;
					}else{
						return false;
					}
					*/
				}
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
			//Grid Style ����
			cfStyleGrid(form1.grdT_EV_QSTANS,0,"true","false");
			form1.grdT_EV_QSTANS.DragDropEnable  = "false";
			form1.grdT_EV_QSTANS.ColSizing  = "false";

			//form load�� ������ ������ ��ȸ
            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����
			try {
				//����� ���� �ҷ��´�.
	            dsT_EV_JOBCHG.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SHR";
	            dsT_EV_JOBCHG.Reset();
	            
<%
    //�������̸� ����������� ��� �˻�����
    if(!box.getString("SESSION_ROLE_CD").equals("1001")) {
%>	            
				//����� ������ �־�� ��������
				if(dsT_EV_JOBCHG.CountRow != 0){
<%
    }else{
%>
                    document.getElementById("txtPIS_YYMM").value = getToday();//�����ڴ� ����ڿ� ������ �ʵǹǷ� ���Ƿ� �־��ش�. 
<%
    }
%>
					//�����̵� �ҷ��´�.
					dsT_EV_CHGANS.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SHR_01&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value+"&ENO_NO="+document.getElementById("txtENO_NO").value;
		            dsT_EV_CHGANS.Reset();

					//�������缭 �ҷ��´�.
		            dsT_EV_QSTANS.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.a.joba020.cmd.JOBA020CMD&S_MODE=SHR_02&PIS_YYMM="+document.getElementById("txtPIS_YYMM").value+"&ENO_NO="+document.getElementById("txtENO_NO").value;
		            dsT_EV_QSTANS.Reset();
		            
<%
    //�������̸� ����������� ��� �˻�����
    if(!box.getString("SESSION_ROLE_CD").equals("1001")) {
%>            
	            }
<%
    }
%>	            
	            
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
        }

        /********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

		function cheakValue(obj){
			if (event.type =="click" || obj.value.length > 0){
				document.rdoNOCHANGE_GBN.Enable = "false";
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
				document.getElementById("txtNOCHANGE_DEC").value="";
			}else{
			}
		}

        //Layer ID
        var layerList = new Array(  "tabJOBA020_01"
                                   ,"tabJOBA020_02" );
        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {
        
            if(oRSH_GBN == "2" && idx== "1"){//�����̵��� ����
                alert("�����̵� �����ۼ��� �����մϴ�."); 
                return false
            }
            
            if(oRSH_GBN == "3" && idx== "0"){//�ڱ�Ű��� ����
                alert("�ڱ�Ű� �����ۼ��� �����մϴ�."); 
                return false
            }
        
            ActiveIndex = idx+1;
            
            //Layer �����ְ� �ݱ�
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            
            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }
            
                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }
            
            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";
            
        }
        
</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                                      |
    | 2. �̸� : dsT_EV_JOBCHG                                        |
    | 3. Table List : T_EV_JOBCHG                                    |
    +----------------------------------------------->
    <Object ID="dsT_EV_JOBCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_EV_QSTANS                                  |
    | 3. Table List : T_EV_QSTANS                                 |
    +----------------------------------------------->
    <Object ID="dsT_EV_QSTANS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_EV_QSTANS                                    |
    | 3. Table List : T_EV_QSTANS                                 |
    +----------------------------------------------->
    <Object ID ="trT_EV_QSTANS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_EV_CHGANS                                  |
    | 3. Table List : T_EV_CHGANS                                 |
    +----------------------------------------------->
    <Object ID="dsT_EV_CHGANS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_EV_CHGANS                                    |
    | 3. Table List : T_EV_CHGANS                                 |
    +----------------------------------------------->
    <Object ID ="trT_EV_CHGANS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBCHG Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //�����Ͱ� ���ٸ� �����ۼ� ����ڰ� �ƴϴ�.
			alert("�����̵���û ����ڰ� �ƴմϴ�.");
			//fnc_Exit();
			document.getElementById("imgSave").style.display = "none";
			//document.imgSave.style.visibility="hidden";

			rdoCHANGE_GBN.Enable = "false";
			document.getElementById("txtCHANGE_DEC").readOnly = true;
			document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";

			rdoCHANGE_TIME.Enable = "false";

			document.getElementById("txtHOPE_DEP1").readOnly = true;
			document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
			document.getElementById("img_HelpOn1").style.display = "none";
			document.getElementById("txtHOPE_DEP2").readOnly = true;
			document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
			document.getElementById("img_HelpOn2").style.display = "none";
			document.getElementById("txtHOPE_DEP3").readOnly = true;
			document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
			document.getElementById("img_HelpOn3").style.display = "none";

			rdoNOCHANGE_GBN.Enable = "false";
			document.getElementById("txtNOCHANGE_DEC").readOnly = true;
			document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";

            grdT_EV_QSTANS.Enable = "false";

        } else {
	        RowCnt = dsT_EV_JOBCHG.CountRow;

	        if(RowCnt != 1){
	        	alert("����� �������� ���� ����")
	        }

			//���������� �����ش�.
			document.getElementById("txtPIS_YYMM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"PIS_YYMM");
			document.getElementById("txtENO_NO").value = dsT_EV_JOBCHG.NameValue(RowCnt,"ENO_NO");
			document.getElementById("txtENO_NM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"ENO_NM");
			document.getElementById("txtDPT_CD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"DPT_CD");
			document.getElementById("txtDPT_NM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"DPT_NM");
			document.getElementById("txtJOB_CD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"JOB_CD");
			document.getElementById("txtJOB_NM").value = dsT_EV_JOBCHG.NameValue(RowCnt,"JOB_NM");
			document.getElementById("txtBIR_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"BIR_YMD");
			document.getElementById("txtHIR_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"HIR_YMD");
			document.getElementById("txtDPA_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"DPA_YMD");
			document.getElementById("txtJPR_YMD").value = dsT_EV_JOBCHG.NameValue(RowCnt,"JPR_YMD");

			//���м���(�ӽ�)
			//alert(dsT_EV_JOBCHG.NameValue(RowCnt,'EXM_PNT'));

			//����open �Ǿ�߸� �����ۼ��޴� ��� ����
			var oSTATUS_JOB = dsT_EV_JOBCHG.NameValue(RowCnt,"STATUS_JOB");//�۾�����
			if(oSTATUS_JOB != 2){
				alert("�����̵���û �����ۼ��Ⱓ�� �ƴմϴ�.");
	            //fnc_Exit();
				document.getElementById("imgSave").style.display = "none";
				document.getElementById("imgCancel").style.display = "none";
				//document.imgSave.style.visibility="hidden";

				rdoCHANGE_GBN.Enable = "false";
				document.getElementById("txtCHANGE_DEC").readOnly = true;
				document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";

				rdoCHANGE_TIME.Enable = "false";

				document.getElementById("txtHOPE_DEP1").readOnly = true;
				document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
				document.getElementById("img_HelpOn1").style.display = "none";
				document.getElementById("txtHOPE_DEP2").readOnly = true;
				document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
				document.getElementById("img_HelpOn2").style.display = "none";
				document.getElementById("txtHOPE_DEP3").readOnly = true;
				document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
				document.getElementById("img_HelpOn3").style.display = "none";

				rdoNOCHANGE_GBN.Enable = "false";
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";

                grdT_EV_QSTANS.Enable = "false";
			}

			oRSH_GBN = dsT_EV_JOBCHG.NameValue(RowCnt,"RSH_GBN");//���系�� ����

			if(oRSH_GBN == 1){//�����̵�, �ڱ�Ű� ��λ��
				TabEvent(0);
				
			}else if(oRSH_GBN == 2){//�����̵���
				TabEvent(0);
				
			}else if(oRSH_GBN == 3){//�ڱ�Ű�
				TabEvent(1);
				
			}
        }
    </Script>

    <Script For=dsT_EV_QSTANS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            ///fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
        }
    </Script>

    <Script For=dsT_EV_CHGANS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            //���� ���� ���ٸ� �����ϱ� ���� row�߰�
			dsT_EV_CHGANS.AddRow();
			rdoCHANGE_GBN.Focus();
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�

            //��Ÿ��ư ó��
			if(rdoCHANGE_GBN.CodeValue == 4){
				document.getElementById("txtCHANGE_DEC").readOnly = false;
				document.getElementById("txtCHANGE_DEC").className="";
			}else{
				document.getElementById("txtCHANGE_DEC").readOnly = true;
				document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";
				document.getElementById("txtCHANGE_DEC").value="";
			}

			if(rdoNOCHANGE_GBN.CodeValue == 4){
				document.getElementById("txtNOCHANGE_DEC").readOnly = false;
				document.getElementById("txtNOCHANGE_DEC").className="";
			}else{
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
				document.getElementById("txtNOCHANGE_DEC").value="";
			}

			if(rdoCHANGE_GBN.CodeValue != ""){
				rdoNOCHANGE_GBN.Enable = "false";
				document.getElementById("txtNOCHANGE_DEC").readOnly = true;
				document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
			}else{
				rdoCHANGE_GBN.Enable = "false";
				document.getElementById("txtCHANGE_DEC").readOnly = true;
				document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";

				rdoCHANGE_TIME.Enable = "false";

				document.getElementById("txtHOPE_DEP1").readOnly = true;
				document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
				document.getElementById("img_HelpOn1").style.display = "none";
				document.getElementById("txtHOPE_DEP2").readOnly = true;
				document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
				document.getElementById("img_HelpOn2").style.display = "none";
				document.getElementById("txtHOPE_DEP3").readOnly = true;
				document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
				document.getElementById("img_HelpOn3").style.display = "none";
			}
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_EV_JOBCHG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_EV_QSTANS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_EV_CHGANS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_EV_QSTANS Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_EV_CHGANS Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_EV_QSTANS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <script for=trT_EV_CHGANS event="OnSuccess()">
        //fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_EV_QSTANS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_EV_CHGANS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!---------------------------------+
    | CheckBox Ŭ����  �ߺ� üũ ó��       |
    +---------------------------------->
	<script language="javascript"  for=grdT_EV_QSTANS event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		if(Colid != 'QST_GBN_NM' && Colid != 'QST_ITEM_NM' && Row != '0'){
			//CheckBoxText�� Ŭ���ص� üũ�ȴ�.
			dsT_EV_QSTANS.NameValue(Row,Colid) = "T";

			if(Colid != "ANS_A"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_A") = "F";
	    	}
	    	if(Colid != "ANS_B"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_B") = "F";
	    	}
	    	if(Colid != "ANS_C"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_C") = "F";
	    	}
	    	if(Colid != "ANS_D"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_D") = "F";
	    	}
	    	if(Colid != "ANS_E"){
		    	dsT_EV_QSTANS.NameValue(Row,"ANS_E") = "F";
	    	}
    	}
	</script>

	<!---------------------------------+
    | Radio Button Ŭ���� ��ư ó��            |
    +---------------------------------->
    <script language=JavaScript for=rdoCHANGE_GBN event=OnSelChange()>
    	//��Ÿ��ư ó��
		if(rdoCHANGE_GBN.CodeValue == 4){
			document.getElementById("txtCHANGE_DEC").readOnly = false;
			document.getElementById("txtCHANGE_DEC").className="";
		}else{
			document.getElementById("txtCHANGE_DEC").readOnly = true;
			document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";
			document.getElementById("txtCHANGE_DEC").value="";
		}

		rdoNOCHANGE_GBN.Enable = "false";
		document.getElementById("txtNOCHANGE_DEC").readOnly = true;
		document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
		document.getElementById("txtNOCHANGE_DEC").value="";
	</script>

    <script language=JavaScript for=rdoCHANGE_TIME event=OnSelChange()>
	    rdoNOCHANGE_GBN.Enable = "false";
		document.getElementById("txtNOCHANGE_DEC").readOnly = true;
		document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
		document.getElementById("txtNOCHANGE_DEC").value="";
	</script>

    <script language=JavaScript for=rdoNOCHANGE_GBN event=OnSelChange()>
	    //��Ÿ��ư ó��
		if(rdoNOCHANGE_GBN.CodeValue == 4){
			document.getElementById("txtNOCHANGE_DEC").readOnly = false;
			document.getElementById("txtNOCHANGE_DEC").className="";
		}else{
			document.getElementById("txtNOCHANGE_DEC").readOnly = true;
			document.getElementById("txtNOCHANGE_DEC").className="input_ReadOnly";
			document.getElementById("txtNOCHANGE_DEC").value="";
		}

		rdoCHANGE_GBN.Enable = "false";
		document.getElementById("txtCHANGE_DEC").readOnly = true;
		document.getElementById("txtCHANGE_DEC").className="input_ReadOnly";
		document.getElementById("txtCHANGE_DEC").value="";

		rdoCHANGE_TIME.Enable = "false";

		document.getElementById("txtHOPE_DEP1").readOnly = true;
		document.getElementById("txtHOPE_DEP1").className="input_ReadOnly";
		document.getElementById("txtHOPE_DEP1").value="";
		document.getElementById("txtHOPE_DEP1NM").value="";
		document.getElementById("img_HelpOn1").style.display = "none";
		document.getElementById("txtHOPE_DEP2").readOnly = true;
		document.getElementById("txtHOPE_DEP2").className="input_ReadOnly";
		document.getElementById("txtHOPE_DEP2").value="";
		document.getElementById("txtHOPE_DEP2NM").value="";
		document.getElementById("img_HelpOn2").style.display = "none";
		document.getElementById("txtHOPE_DEP3").readOnly = true;
		document.getElementById("txtHOPE_DEP3").className="input_ReadOnly";
		document.getElementById("txtHOPE_DEP3").value="";
		document.getElementById("txtHOPE_DEP3NM").value="";
		document.getElementById("img_HelpOn3").style.display = "none";
	</script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����̵������ۼ�</td>
					<td align="right" class="navigator">HOME/�����̵�/�����̵��۾�/<font color="#000000">�����̵������ۼ�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
   			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong></td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="60"></col>
                                <col width="100"></col>
                                <col width="115"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">������</td>
                                <td class="padding2423">
                                	<input id="txtPIS_YYMM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�μ�</td>
                                <td class="padding2423">
                                	<input type=hidden id="txtDPT_CD" class="input_ReadOnly" readonly>
                                	<input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                	<input type=hidden id="txtJOB_CD" class="input_ReadOnly" readonly>
                                	<input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�μ��߷���/������</td>
                                <td class="padding2423">
                                	<input id="txtDPA_YMD" size="10" class="input_ReadOnly" readonly>&nbsp;/
                                	<input id="txtJPR_YMD" size="10" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423">
                                	<input id="txtENO_NO" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                	<input id="txtENO_NM" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�������</td>
                                <td class="padding2423">
                                	<input id="txtBIR_YMD" size="15" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�Ի���</td>
                                <td class="padding2423">
                                	<input id="txtHIR_YMD" size="15" class="input_ReadOnly" readonly>
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

    <!-- �� ��� ���۳�Ʈ ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8" align="left">  
                
                <!-- �ǹ�ư���̺� ���� -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                        <td width="120"> 
                            <!-- �ǿ��� -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                    <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">�����̵�</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td> 
                            <!-- ������ -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">�ڱ�Ű�</td>
                                    <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                        <td height="2" bgcolor="#A4A4A1"></td>
                    </tr>
                </table>            
                <!-- �ǹ�ư���̺� �� -->            
                
            </td>
        </tr>
    </table>

<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabJOBA020_01" style="position:absolute; left:20; top:221; width:800; height:340; z-index:4;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <colgroup>
	                    <col width="225"></col>
	                    <col width="135"></col>
	                    <col width=""></col>
	                </colgroup>
	                <tr>
	                    <td align="center" class="creamBold" colspan="2">�����׸�</td>
	                    <td align="center" class="creamBold">�������</td>
	                </tr>
	                <tr align="left">
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px" rowspan="3">1. �����̵��� ���� ���</td>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(1)�̵�����</td>
	                    <td class="padding2423">
							<comment id="__NSID__">
							<object id=rdoCHANGE_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:60; width:350">
								<param name=AutoMargin	value="false">
								<param name=Cols	value="1">
								<param name=DataID			value="dsT_EV_CHGANS">
								<param name=Format	value="1^���� ������,2^�巡�� ���� Ÿ�κ� ����,3^�μ��� �ΰ�����,4^�� Ÿ">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							&nbsp;&nbsp;&nbsp;&nbsp;<input id="txtCHANGE_DEC" style="width:90%">
						</td>
	                </tr>
	                <tr>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(2)�̵��ñ�</td>
	                    <td class="padding2423">
							<comment id="__NSID__">
							<object id=rdoCHANGE_TIME classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:60; width:400">
								<param name=AutoMargin	value="false">
								<param name=Cols	value="1">
								<param name=DataID			value="dsT_EV_CHGANS">
								<param name=Format	value="1^��� �̵�,2^3���� ���� �̵�,3^6���� ���� �̵�,4^ȸ���ħ���">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
						</td>
	                </tr>
	                <tr>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(3)�̵�����μ�</td>
	                    <td class="padding2423">
		                     &nbsp;1���� :
		                     <input id="txtHOPE_DEP1" size="8" maxlength="3"  class="input_ReadOnly" readonly onkeyup="cheakValue(this);">
		                     <input id="txtHOPE_DEP1NM" size="25" maxlength="3" class="input_ReadOnly" readonly>
		                     <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="cheakValue(this);fnc_commnmPopup('txtHOPE_DEP1','txtHOPE_DEP1NM','�μ�','DEPT');"></a><BR>
		                     &nbsp;2���� :
		                     <input id="txtHOPE_DEP2" size="8" maxlength="3" class="input_ReadOnly" readonly onkeyup="cheakValue(this);">
		                     <input id="txtHOPE_DEP2NM" size="25" maxlength="3" class="input_ReadOnly" readonly>
		                     <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="cheakValue(this);fnc_commnmPopup('txtHOPE_DEP2','txtHOPE_DEP2NM','�μ�','DEPT')"></a><BR>
		                     &nbsp;3���� :
		                     <input id="txtHOPE_DEP3" size="8" maxlength="3" class="input_ReadOnly" readonly onkeyup="cheakValue(this);">
		                     <input id="txtHOPE_DEP3NM" size="25" maxlength="3" class="input_ReadOnly" readonly>
		                     <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onClick="cheakValue(this);fnc_commnmPopup('txtHOPE_DEP3','txtHOPE_DEP3NM','�μ�','DEPT')"></a><BR>
						</td>
	                </tr>
	                <tr align="left">
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">2. �����̵� �ǻ簡 ���� ���</td>
	                    <td valign="top" class="creamBold" style="padding-left:5px;padding-top:5px">(1)����</td>
	                    <td class="padding2423">
							<comment id="__NSID__">
							<object id=rdoNOCHANGE_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:60; width:350">
								<param name=AutoMargin	value="false">
								<param name=Cols	value="1">
								<param name=DataID			value="dsT_EV_CHGANS">
								<param name=Format	value="1^���μ� �������� ����,2^���ٷα����� ������ ����,3^���ٷα����� ���� ���� �ʷ�,4^�� Ÿ">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							&nbsp;&nbsp;&nbsp;&nbsp;<input id="txtNOCHANGE_DEC" style="width:90%">
						</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>

</div>
<!-- ��1 ���� �Է� ���̺� �� -->

<!-- ��2 ���� �Է� ���̺� ���� -->
<div class=page id="tabJOBA020_02" style="position:absolute; left:20; top:221; width:800; height:340; z-index:3; visibility:hidden">
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	            	<tr>
                        <td>
				            <table width="799" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#A1A1A1" class="table_cream" frame="below">
				                <tr>
				                </tr>
				            </table>
				            <table width="799" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#A1A1A1" class="table_cream" frame="vsides">
				                <colgroup>
				                    <col width="110"></col>
				                    <col width="229"></col>
				                    <col width=""></col>
				                </colgroup>
				                <tr>
				                    <td align="center" style="height:25;background:#F7DCBB;font-weight: bolder;">����</td>
				                    <td align="center" style="height:25;background:#F7DCBB;font-weight: bolder;">�����׸�</td>
				                    <td align="center" style="height:25;background:#F7DCBB;font-weight: bolder;">�������</td>
				                </tr>
			                </table>
		                </td>
	            	</tr>
	                <tr>
	                    <td>
							<comment id="__NSID__">
							<object	id="grdT_EV_QSTANS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
	                            <param name="DataID"				value="dsT_EV_QSTANS">
	                            <param name="EdiTABLE"				value="true">
    	                        <param name="DragDropEnable"		value="false">
				                <param name="VIEWSUMMARY"		    value=0>
				                <param name=ViewHeader  			value="false">
	                            <param name="Format"						value="
	                                <C> id='QST_GBN_NM'		width=110		name='����'				align=left			edit=None						Suppress='1'						</C>
									<C> id='QST_ITEM_NM'	width=230		name='�����׸�'		    align=left			edit=None															</C>
									<C> id='ANS_A'			width=88								align=center		EditStyle=CheckBox		CheckBoxText='LST_A'		Pointer=Hand	</C>
									<C> id='ANS_B'			width=88		name='��'				align=center		EditStyle=CheckBox		CheckBoxText='LST_B'		Pointer=Hand	</C>
									<C> id='ANS_C'			width=88		name='��       ��'		align=center		EditStyle=CheckBox		CheckBoxText='LST_C'		Pointer=Hand	</C>
									<C> id='ANS_D'			width=88		name='��'				align=center		EditStyle=CheckBox		CheckBoxText='LST_D'		Pointer=Hand	</C>
									<C> id='ANS_E'			width=88								align=center		EditStyle=CheckBox		CheckBoxText='LST_E'		Pointer=Hand	</C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>

						</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
</div>
<!-- ��2 ���� �Է� ���̺� �� -->

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_EV_CHGANS                                   |
    | 3. Table List : T_EV_CHGANS                                 |
    +----------------------------------------------->
	<object id="bndT_EV_CHGANS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_CHGANS">
		<Param Name="BindInfo", Value="
			<C>Col='CHANGE_GBN'			Ctrl='rdoCHANGE_GBN'		Param=CodeValue</C>
			<C>Col='CHANGE_DEC'			Ctrl='txtCHANGE_DEC'		Param=value</C>
			<C>Col='CHANGE_TIME'		Ctrl='rdoCHANGE_TIME'		Param=CodeValue</C>
			<C>Col='HOPE_DEP1'			Ctrl='txtHOPE_DEP1'			Param=value</C>
			<C>Col='HOPE_DEP1NM'		Ctrl='txtHOPE_DEP1NM'		Param=value</C>
			<C>Col='HOPE_DEP2'			Ctrl='txtHOPE_DEP2'			Param=value</C>
			<C>Col='HOPE_DEP2NM'		Ctrl='txtHOPE_DEP2NM'		Param=value</C>
			<C>Col='HOPE_DEP3'			Ctrl='txtHOPE_DEP3'			Param=value</C>
			<C>Col='HOPE_DEP3NM'		Ctrl='txtHOPE_DEP3NM'		Param=value</C>
			<C>Col='NOCHANGE_GBN'		Ctrl='rdoNOCHANGE_GBN'		Param=CodeValue</C>
			<C>Col='NOCHANGE_DEC'		Ctrl='txtNOCHANGE_DEC'		Param=value</C>
	    ">
	</object>