<!--
    ************************************************************************************
    * @Source              : codb020.jsp                                                                        *
    * @Description        : �μ��ڵ����                                                                                            *
    * @Font                   :                                                                                        *
    * @Developer Desc :                                                                                            *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                             	*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�																*
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�μ��ڵ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >


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
        	
			if(fnc_SaveItemCheck()) {
				
				tr01T_CM_DEPT.KeyValue = "SVL(I:ds01T_CM_DEPT=ds01T_CM_DEPT)";
				tr01T_CM_DEPT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SAV_01";
				tr01T_CM_DEPT.post();
	            dsT_CM_DEPT.Reset();//Ʈ���� �籸���Ѵ�.
	            
			} else {
				return;
			}
			
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
        	
			// ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (ds01T_CM_DEPT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			//�����μ��� ������ ���� �ʵȴ�
			var oDOWNDPT_CD = ds01T_CM_DEPT.NameValue(ds01T_CM_DEPT.RowPosition,"DOWNDPT_CD");
			//alert("row:"+ds01T_CM_DEPT.RowPosition+", down:"+oDOWNDPT_CD);
			if(oDOWNDPT_CD == "2"){
				alert("�����μ��� �����մϴ�.");
				return false;
			}

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + ds01T_CM_DEPT.ColumnString(ds01T_CM_DEPT.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            
            
            ds01T_CM_DEPT.DeleteRow(ds01T_CM_DEPT.RowPosition);
			tr01T_CM_DEPT.KeyValue = "SVL(I:ds01T_CM_DEPT=ds01T_CM_DEPT)";
			tr01T_CM_DEPT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=DEL";
			tr01T_CM_DEPT.post();
            dsT_CM_DEPT.Reset();//Ʈ���� �籸���Ѵ�.
            
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

            if(document.tvT_CM_DEPT.ItemText.trim() == ""){
            	alert("Ʈ�� �������� ���� �������ּ���.");
	            return false;
            }

			//AddNew
            ds01T_CM_DEPT.AddRow();

            //���� ���õ� Ʈ���� ������ �����´�.
			var overNm = document.tvT_CM_DEPT.ItemText;
			var Row = dsT_CM_DEPT.NameValueRow("DPT_NM",overNm);
			var oUPCD_GBN = dsT_CM_DEPT.NameValue(Row,"CD_GBN");
			var oUPDPT_CD = dsT_CM_DEPT.NameValue(Row,"DPT_CD");
			var oUPDPT_NM = dsT_CM_DEPT.NameValue(Row,"DPT_NM");

			var oDPT_LBL=	dsT_CM_DEPT.NameValue(Row,"DPT_LBL");
			var oCOUNT_REM=dsT_CM_DEPT.NameValue(Row,"COUNT_REM");
			var dsCnt = ds01T_CM_DEPT.CountRow

			//����Ʈ���� �ϱ����� ������ �ø���.
			oDPT_LBL = parseInt(oDPT_LBL)+1;
			//����Ʈ���� ������ seq�� ����Ͽ� �ڿ� ���δ�.
			oCOUNT_REM = oCOUNT_REM+lpad(parseInt(dsCnt)-1, 3, "0");
			//alert("oDPT_LBL:"+oDPT_LBL+", oCOUNT_REM:"+oCOUNT_REM);

            document.getElementById("txtUPCD_GBN").value = oUPCD_GBN;
            document.getElementById("txtUPDPT_CD").value = oUPDPT_CD;
            document.getElementById("txtUPDPT_NM").value = oUPDPT_NM;
            document.getElementById("txtDPT_LBL").value = oDPT_LBL;
            document.getElementById("txtCOUNT_REM").value = oCOUNT_REM;

			//�ڵ屸���� ����Ʈ ���� �ش�.
			if(oUPCD_GBN.trim() == ""){
				document.getElementById("txtCD_GBN").value = "B2";
				enableInput2();
			}else if(oUPCD_GBN == "B2"){
				document.getElementById("txtCD_GBN").value = "A4";
				enableInput();
			}else if(oUPCD_GBN == "A4"){
				document.getElementById("txtCD_GBN").value = "A6";
				//--enableInput2();
				enableInput();

			}

			//�Է� ���̺�� ��Ŀ��
			document.getElementById("txtDPT_CD").focus();
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
        	
			dsT_CM_DEPT.ClearData();
			dsT_CM_DEPT.Reset();
			ds01T_CM_DEPT.ClearData();
			
			disableInput();//�Է��ʵ� ��Ȱ��ȭ
			
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
        	
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (ds01T_CM_DEPT.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

        	window.close();
        	
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
        	
   			var f = document.form1;

			//DataSet�� ���� ���� Ȯ��
			if (!ds01T_CM_DEPT.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oCD_GBN, oDPT_CD, oDPT_NM, oSTR_YMD, oEND_YMD, oCOM_NO;
			var RowCnt = ds01T_CM_DEPT.CountRow;
			
			for(i=1; i<=RowCnt; i++){
				oCD_GBN = ds01T_CM_DEPT.NameValue(i,"CD_GBN");
				if(oCD_GBN.trim() == ""){
					alert("�ڵ屸���� �߸��Ǿ����ϴ�." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtCD_GBN").focus();
					return false;
				}

				oDPT_CD = ds01T_CM_DEPT.NameValue(i,"DPT_CD");
				
				if(oDPT_CD.trim() == ""){
					alert("�μ��ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtDPT_CD").focus();
					return false;
				}

				oDPT_NM = ds01T_CM_DEPT.NameValue(i,"DPT_NM");
				
				if(oDPT_NM.trim() == ""){
					alert("�μ����� �߸��Ǿ����ϴ�." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtDPT_NM").focus();
					return false;
				}

				oSTR_YMD = ds01T_CM_DEPT.NameValue(i,"STR_YMD");
				
				if(!cfDateExpr(oSTR_YMD) || oSTR_YMD.trim().length == 0){//������� �ݵ�� �����Ѵ�.
					alert("�������  �߸��Ǿ����ϴ�." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtSTR_YMD").focus();
					return false;
				}

				oEND_YMD = ds01T_CM_DEPT.NameValue(i,"END_YMD");
				
				if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){//������� �ȵ��� �ȴ�.
					alert("�������  �߸��Ǿ����ϴ�." );
					ds01T_CM_DEPT.RowPosition = i;
					document.getElementById("txtEND_YMD").focus();
					return false;
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	
            //Grid Style ����
   			cfStyleGrid_New(form1.grd01T_CM_DEPT,15,"false","right");

            // �ٹ�������  �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_B7.CountRow; i++ ) {
				
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_B7.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_B7.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGBN_CD").add(oOption);
				
			}

			//form load�� ������ �μ��ڵ� Ʈ�����·� ��ȸ
            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����
			
			try {
				dsT_CM_DEPT.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SHR";
				dsT_CM_DEPT.Reset();

				ds02T_CM_DEPT.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SHR_02";
				ds02T_CM_DEPT.Reset();

				disableInput();//�Է��ʵ� ��Ȱ��ȭ
				
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

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)  - A4(�Ҽ�)*
         ********************************************/
  		function enableInput(){

			document.form1.txtCD_GBN.readOnly = false;
  			document.form1.txtCD_GBN.className = "";
			document.form1.txtDPT_CD.readOnly = false;
  			document.form1.txtDPT_CD.className = "";
			document.form1.txtDPT_NM.readOnly = false;
  			document.form1.txtDPT_NM.className = "";
			document.form1.txtSORT_NO.readOnly = false;
  			document.form1.txtSORT_NO.className = "";

			document.form1.txtSTR_YMD.readOnly = false;
  			document.form1.txtSTR_YMD.className = "";
  			document.getElementById("img_HelpOn2").disabled = false;
			document.form1.txtEND_YMD.readOnly = false;
  			document.form1.txtEND_YMD.className = "";
  			document.getElementById("img_HelpOn3").disabled = false;
  			document.getElementById("cmbGBN2_TAG").disabled = false;
  			document.getElementById("cmbGBN_CD").disabled = false;

			document.form1.txtREMARK.readOnly = false;
  			document.form1.txtREMARK.className = "";
			document.form1.txtHEAD_CD.readOnly = false;
  			document.form1.txtHEAD_CD.className = "";
  			document.getElementById("cmbHEAD_TAG").disabled = false;
			document.form1.txtREG_CD.readOnly = false;
  			document.form1.txtREG_CD.className = "";
  			document.getElementById("ImgRegCd").disabled = false;

			document.medCOM_NO.Enable = "true";
			document.form1.txtOFFICE.readOnly = false;
  			document.form1.txtOFFICE.className = "";
			document.form1.txtREMARK2.readOnly = false;
  			document.form1.txtREMARK2.className = "";
			document.form1.txtREMARK3.readOnly = false;
  			document.form1.txtREMARK3.className = "";

  		}

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)  - B2(����)*
         ********************************************/
  		function enableInput2(){

			document.form1.txtCD_GBN.readOnly = false;
  			document.form1.txtCD_GBN.className = "";
			document.form1.txtDPT_CD.readOnly = false;
  			document.form1.txtDPT_CD.className = "";
			document.form1.txtDPT_NM.readOnly = false;
  			document.form1.txtDPT_NM.className = "";
			document.form1.txtSORT_NO.readOnly = false;
  			document.form1.txtSORT_NO.className = "";

			document.form1.txtSTR_YMD.readOnly = false;
  			document.form1.txtSTR_YMD.className = "";
  			document.getElementById("img_HelpOn2").disabled = false;
			document.form1.txtEND_YMD.readOnly = false;
  			document.form1.txtEND_YMD.className = "";
  			document.getElementById("img_HelpOn3").disabled = false;
  			document.getElementById("cmbGBN2_TAG").disabled = true;
  			document.getElementById("cmbGBN_CD").disabled = true;

			document.form1.txtREMARK.readOnly = true;
  			document.form1.txtREMARK.className = "inputDisabled";
			document.form1.txtHEAD_CD.readOnly = true;
  			document.form1.txtHEAD_CD.className = "inputDisabled";
  			document.getElementById("cmbHEAD_TAG").disabled = true;
			document.form1.txtREG_CD.readOnly = true;
  			document.form1.txtREG_CD.className = "inputDisabled";
  			document.getElementById("ImgRegCd").disabled = true;

			document.medCOM_NO.Enable = "false";
			document.form1.txtOFFICE.readOnly = true;
  			document.form1.txtOFFICE.className = "inputDisabled";
			document.form1.txtREMARK2.readOnly = true;
  			document.form1.txtREMARK2.className = "inputDisabled";
			document.form1.txtREMARK3.readOnly = true;
  			document.form1.txtREMARK3.className = "inputDisabled";

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtCD_GBN.readOnly = true;
  			document.form1.txtCD_GBN.className = "inputDisabled";
			document.form1.txtDPT_CD.readOnly = true;
  			document.form1.txtDPT_CD.className = "inputDisabled";
			document.form1.txtDPT_NM.readOnly = true;
  			document.form1.txtDPT_NM.className = "inputDisabled";
			document.form1.txtSORT_NO.readOnly = true;
  			document.form1.txtSORT_NO.className = "inputDisabled";

			document.form1.txtSTR_YMD.readOnly = true;
  			document.form1.txtSTR_YMD.className = "inputDisabled";
  			document.getElementById("img_HelpOn2").disabled = true;
			document.form1.txtEND_YMD.readOnly = true;
  			document.form1.txtEND_YMD.className = "inputDisabled";
  			document.getElementById("img_HelpOn3").disabled = true;
  			document.getElementById("cmbGBN2_TAG").disabled = true;
  			document.getElementById("cmbGBN_CD").disabled = true;

			document.form1.txtREMARK.readOnly = true;
  			document.form1.txtREMARK.className = "inputDisabled";
			document.form1.txtHEAD_CD.readOnly = true;
  			document.form1.txtHEAD_CD.className = "inputDisabled";
  			document.getElementById("cmbHEAD_TAG").disabled = true;
			document.form1.txtREG_CD.readOnly = true;
  			document.form1.txtREG_CD.className = "inputDisabled";
  			document.getElementById("ImgRegCd").disabled = true;

			document.medCOM_NO.Enable = "false";
			document.form1.txtOFFICE.readOnly = true;
  			document.form1.txtOFFICE.className = "inputDisabled";
			document.form1.txtREMARK2.readOnly = true;
  			document.form1.txtREMARK2.className = "inputDisabled";
			document.form1.txtREMARK3.readOnly = true;
  			document.form1.txtREMARK3.className = "inputDisabled";

  		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. Ʈ�������� DataSet                                               |
    | 2. �̸� : dsT_CM_DEPT                                            |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. Ʈ�� �̹��� DataSet                                              |
    | 2. �̸� : idsT_CM_DEPT                                           |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <!--
	<object id=idsT_CM_DEPT classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
			<param name=SyncLoad	value="true">
	</object>
	 -->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CM_DEPT                                        |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <Object ID="ds01T_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CM_DEPT                                        |
    | 3. Table List : T_CM_DEPT                                       |
    +----------------------------------------------->
    <Object ID="ds02T_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CM_DEPT                                    |
    | 3. Table List : T_CM_DEPT                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_DEPT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     		Value="dataid">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    	value="dsT_CM_COMMON_B7"/>
       <jsp:param name="CODE_GUBUN"    value="B7"/>
       <jsp:param name="SYNCLOAD"      	value="false"/>
       <jsp:param name="USEFILTER"     	value="false"/>
    </jsp:include>
    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {
        	
	        //�μ������� �ϳ��� ������ ȸ�������� �ִ´�.
	        dsT_CM_DEPT.AddRow();
			tr01T_CM_DEPT.KeyValue = "SVL(I:dsT_CM_DEPT=dsT_CM_DEPT)";
			tr01T_CM_DEPT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SAV";
			tr01T_CM_DEPT.post();
            dsT_CM_DEPT.Reset();//Ʈ���� �籸���Ѵ�.
            
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_DEPT.CountRow);
            
        }
        
    </Script>

    <Script For=ds01T_CM_DEPT Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CM_DEPT.CountRow);
        }
        
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CM_DEPT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_DEPT Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr01T_CM_DEPT event="OnSuccess()">
	    fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr01T_CM_DEPT event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-------------------------------+
    | treeview���� item�� Ŭ��������      |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CM_DEPT event=OnClick()>
    
		var overId1 = "DPT_CD";
		var overId2 = "COUNT_REM";
		var overNm = tvT_CM_DEPT.ItemText;
		var Row = dsT_CM_DEPT.NameValueRow("DPT_NM",overNm);
		var overValue1 = dsT_CM_DEPT.NameValue(Row,overId1);
		var overValue2 = dsT_CM_DEPT.NameValue(Row,overId2);
		
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1);
		
		try {
			ds01T_CM_DEPT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb020.cmd.CODB020CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CM_DEPT.Reset();

			//disable ó��, ������ ������ ������ ����,���� �ڵ屸��, �μ��ڵ�, �μ���, ���ļ���, �����, ����ϸ� ����Ѵ�.
			var oUPCD_GBN = document.getElementById("txtUPCD_GBN").value;
			
			//alert("treeview���� item�� Ŭ��������  = "+oUPCD_GBN)

			if(oUPCD_GBN.trim() == "B2" || oUPCD_GBN.trim() == "A4"){//�����ڵ尡 B2�̸� �����̴�.
				enableInput();
			}else{
				enableInput2();
			}

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">
<!-- ���ε��� ���� �ӽõ����� ���� -->
<input type="hidden" id="txtDPT_LBL">
<input type="hidden" id="txtCOUNT_REM">
<input type="hidden" id="txtDOWNDPT_CD">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
     <!--       <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>   -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>				
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">�����ڵ屸��</td>
					<td class="padding2423"><input id="txtUPCD_GBN" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="blueBold">�����μ��ڵ�</td>
					<td class="padding2423"><input id="txtUPDPT_CD" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="blueBold">�����μ���</td>
					<td class="padding2423"><input id="txtUPDPT_NM" style="width:100%" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="150"></col>
					<col width="100"></col>
					<col width="150"></col>
					<col width="100"></col>
					<col width="150"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">�ڵ屸��</td>
					<td class="padding2423"><input id="txtCD_GBN" style="width:100%" maxlength="2"></td>
					<td align="center" class="blueBold">�μ��ڵ�</td>
					<td class="padding2423"><input id="txtDPT_CD" style="width:100%" maxlength="6"></td>
					<td align="center" class="blueBold">�μ���</td>
					<td class="padding2423"><input id="txtDPT_NM" style="width:100%" maxlength="30"></td>
					<td align="center" class="blueBold">���ļ���</td>
					<td class="padding2423"><input id="txtSORT_NO" style="width:100%" maxlength="4"></td>
				</tr>
				<tr>
					<td align="center" class="blueBold">�����</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:70" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<!--   
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','65','159');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle"></a>
					    -->
					</td>
					<td align="center" class="blueBold">�����</td>
					<td class="padding2423">
						<input id="txtEND_YMD" style="width:70" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<!--
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','265','159');"><img src="../../images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle"></a>
						-->
					</td>
					
					<td align="center" class="blueBold">�ٹ�������</td>
					<td class="padding2423">
						<select id="cmbGBN_CD" style="width:100%">
							<option value="" >����</option>
						</select>
					</td>
					
					<td align="center" class="blueBold">�ٹ���</td>
					<td class="padding2423">
                        <input id="txtREG_CD" style="width:21%" maxlength="3" onChange="fnc_GetCommNm('B3', 'txtREG_CD','txtREG_NM')">
                        <input id="txtREG_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRegCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRegCd" name="ImgRegCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREG_CD','txtREG_NM','����','B3')"></a>
					</td>					
					
				</tr>
				
				<!--  
				<tr>
					<td align="center" class="blueBold">ȸ��μ��ڵ�</td>
					<td class="padding2423"><input id="txtREMARK" style="width:100%" maxlength="20"></td>
					<td align="center" class="blueBold">�ι��ڵ�</td>
                    <td class="padding2423">
                        <input id="txtPART_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('B1', 'txtPART_CD','txtPART_NM')"> <input id="txtPART_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPartCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPartCd" name="ImgPartCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtPART_CD','txtPART_NM','�ι�','B1')"></a>
                    </td>
					<td align="center" class="blueBold">�����</td>
					<td class="padding2423">
					<comment id="__NSID__">
					<object id=cmbHEAD_TAG classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 height=25 width=120>
					<param name=ComboDataID		value=ds02T_CM_DEPT>
					<param name=SearchColumn		value=DPT_NM>
					<param name=Sort					value=True>
					<param name=BindColumn      	value="DPT_CD">
					<param name=ListExprFormat		value = "DPT_CD^0^50,DPT_NM^0^150">
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>

					<td align="center" class="blueBold">������</td>
					<td class="padding2423">
						<select id="cmbGBN2_TAG" style="width:100%">
							<option value="" >����</option>
							<option value="1" >A</option>
							<option value="2" >B</option>
							<option value="3" >C</option>
							<option value="4" >D</option>
						</select>
					</td>
				</tr>

				<tr>
					<td align="center" class="blueBold">��������ڹ�ȣ</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medCOM_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=Format						value="000-00-00000">
							<param name=IsComma					value=false>
							<param name=Language					value=0>
							<param name=Numeric					value=false>
							<param name=PromptChar				value=" ">
							<param name=ShowLiteral	                 value="false">
							<param name=Visible                      value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">���ұ�û</td>
					<td class="padding2423"><input id="txtOFFICE" style="width:100%" maxlength="20"></td>
                    <td align="center" class="blueBold">��ǥ������</td>
                    <td class="padding2423"><input id="txtHEAD_CD" style="width:100%" maxlength="3"></td>
					<td align="center" class="blueBold">������</td>
					<td class="padding2423"><input id="txtREMARK3" style="width:100%" maxlength="60"></td>
				</tr>
                <tr>
                    <td align="center" class="blueBold">�μ��ּ�</td>
                    <td class="padding2423" colspan="7"><input id="txtREMARK2" style="width:100%" maxlength="150"></td>
                </tr>
                -->
                

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

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_DEPT" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:390px;height:370px">
							<param name=DataID				value="dsT_CM_DEPT">
							<param name=TextColumn			value="DPT_NM">
							<param name=LevelColumn		value="DPT_LBL">
							<param name=ExpandLevel			value="0">
							<param name=BorderStyle  		value="2">
							<param name=UseImage      		value="false">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ Ʈ�� ��-->
		</td>
		<td>
			<!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grd01T_CM_DEPT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:370px">
							<param name="DataID"							value="ds01T_CM_DEPT">
                            <param name="EdiTABLE"						value="false">
                            <param name="DragDropEnable"				value="true">
                            <param name="SortView"						value="Left">
                            <param name="VIEWSUMMARY"				value=0>
                            <param name="Format"							value="
								<C> id='CURROW'		width=50		name='NO'				align=center		value={CurRow}		</C>
								<C> id='CD_GBN'		width=80	    name='�ڵ屸��'		sort=true			align=center				</C>
								<C> id='DPT_CD'		width=100	    name='�μ��ڵ�'		sort=true			align=center				</C>
								<C> id='DPT_NM'		width=150		name='�μ���'			sort=true			align=left 					</C>
								<C> id='STR_YMD'	width=90		name='�����'			sort=true			align=center 			</C>
								<C> id='END_YMD'	width=90		name='�����'			sort=true			align=center				</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ �׸��� ���̺� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_CM_DEPT                                   |
    | 3. Table List : T_CM_DEPT                                 |
    +----------------------------------------------->
	<object id="bndT_CM_DEPT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="ds01T_CM_DEPT">
		<Param Name="BindInfo", Value="
			<C>Col='UPCD_GBN'			Ctrl='txtUPCD_GBN'				Param=value</C>
			<C>Col='UPDPT_CD'			Ctrl='txtUPDPT_CD'				Param=value</C>
			<C>Col='UPDPT_NM'			Ctrl='txtUPDPT_NM'				Param=value</C>

			<C>Col='CD_GBN'				Ctrl='txtCD_GBN'					Param=value</C>
			<C>Col='DPT_CD'				Ctrl='txtDPT_CD'					Param=value</C>
			<C>Col='DPT_NM'				Ctrl='txtDPT_NM'					Param=value</C>
			<C>Col='SORT_NO'			Ctrl='txtSORT_NO'				Param=value</C>

			<C>Col='STR_YMD'			Ctrl='txtSTR_YMD'				Param=value</C>
			<C>Col='END_YMD'			Ctrl='txtEND_YMD'				Param=value</C>
			<C>Col='GBN2_TAG'			Ctrl='cmbGBN2_TAG'				Param=value</C>
			<C>Col='GBN_CD'				Ctrl='cmbGBN_CD'				Param=value</C>

			<C>Col='PART_CD'			Ctrl='txtPART_CD'					Param=value</C>
			<C>Col='PART_NM'			Ctrl='txtPART_NM'					Param=value</C>

			<C>Col='REMARK'				Ctrl='txtREMARK'					Param=value</C>
			<C>Col='HEAD_CD'			Ctrl='txtHEAD_CD'					Param=value</C>
			<C>Col='HEAD_TAG'			Ctrl='cmbHEAD_TAG'				Param=BindColVal</C>
			<C>Col='REG_CD'				Ctrl='txtREG_CD'					Param=value</C>
			<C>Col='REG_NM'				Ctrl='txtREG_NM'					Param=value</C>


			<C>Col='COM_NO'				Ctrl='medCOM_NO'				Param=text	</C>
			<C>Col='OFFICE'				Ctrl='txtOFFICE'					Param=value</C>
			<C>Col='REMARK2'			Ctrl='txtREMARK2'					Param=value</C>
			<C>Col='REMARK3'			Ctrl='txtREMARK3'					Param=value</C>

			<C>Col='DPT_LBL'				Ctrl='txtDPT_LBL'					Param=value</C>
			<C>Col='COUNT_REM'		Ctrl='txtCOUNT_REM'				Param=value</C>
			<C>Col='DOWNDPT_CD'		Ctrl='txtDOWNDPT_CD'			Param=value</C>
	    ">
	</object>
