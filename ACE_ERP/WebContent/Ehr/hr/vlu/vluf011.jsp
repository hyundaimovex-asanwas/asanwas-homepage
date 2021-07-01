<!--
    ************************************************************************************
    * @Source              : vluf011.jsp                                                                                               *
    * @Description        : �����ڵ���                                                                                            *
    * @Font                   :                                                                                                                 *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/01  |  ������   | �����ۼ�                                                                                           *
    * 2006/09/29  |  ������   | ���߿Ϸ�                                                                                           *
    * 2006/11/06  |  ������   | ��ȿ��ó�� �߰�                                                                                 *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����ڵ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		var btnList = 'FTTTFFTT';

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
				tr01T_CM_DUTYMST.KeyValue = "SVL(I:ds01T_CM_DUTYMST=ds01T_CM_DUTYMST)";
				tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SAV_01";
				tr01T_CM_DUTYMST.post();
	            dsT_CM_DUTYMST.Reset();//Ʈ���� �籸���Ѵ�.
			} else {
				return;
			}
        }
        /********************
         * 03.2  ���� �Լ�  *
         ********************/
        function fnc_Save2() {

				tr01T_CM_DUTYMST.KeyValue = "SVL(I:dsT_ED_CLASS=dsT_ED_CLASS)";
				tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SAV_02";
				tr01T_CM_DUTYMST.post();

			var DUTY_CD = document.getElementById("txtDUTY_CD").value;

			tr01T_CM_DUTYMST.KeyValue = "tr06(O:dsT_ED_CLASS=dsT_ED_CLASS)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SHR_02&DUTY_CD="+DUTY_CD;
			tr01T_CM_DUTYMST.post();
        }
        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (ds01T_CM_DUTYMST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			//���������� ������ ���� �ʵȴ�
			var oDOWNDUTY_CD = ds01T_CM_DUTYMST.NameValue(ds01T_CM_DUTYMST.RowPosition,"DOWNDUTY_CD");
			//alert("row:"+ds01T_CM_DUTYMST.RowPosition+", down:"+oDOWNDUTY_CD);
			if(oDOWNDUTY_CD == "2"){
				alert("���������� �����մϴ�.");
				return false;
			}

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + ds01T_CM_DUTYMST.ColumnString(ds01T_CM_DUTYMST.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            ds01T_CM_DUTYMST.DeleteRow(ds01T_CM_DUTYMST.RowPosition);
			tr01T_CM_DUTYMST.KeyValue = "SVL(I:ds01T_CM_DUTYMST=ds01T_CM_DUTYMST)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=DEL_01";
			tr01T_CM_DUTYMST.post();
            dsT_CM_DUTYMST.Reset();//Ʈ���� �籸���Ѵ�.

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

            if(document.tvT_CM_DUTYMST.ItemText.trim() == ""){
            	alert("Ʈ�� �������� ���� �������ּ���.");
	            return false;
            }

			//AddNew
            ds01T_CM_DUTYMST.AddRow();

            fnc_ColEnabled('E');

            //���� ���õ� Ʈ���� ������ �����´�.
			var overNm = document.tvT_CM_DUTYMST.ItemText;
			var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
			var oUPDUTY_CD = dsT_CM_DUTYMST.NameValue(Row,"DUTY_CD");
			var oUPDUTY_NM = dsT_CM_DUTYMST.NameValue(Row,"DUTY_NM");

			var oDUTY_LBL=	dsT_CM_DUTYMST.NameValue(Row,"DUTY_LBL");
			var oCOUNT_REM=dsT_CM_DUTYMST.NameValue(Row,"COUNT_REM");
			var dsCnt = ds01T_CM_DUTYMST.CountRow

			//����Ʈ���� �ϱ����� ������ �ø���.
			oDUTY_LBL = parseInt(oDUTY_LBL)+1;
			//����Ʈ���� ������ seq�� ����Ͽ� �ڿ� ���δ�.
			oCOUNT_REM = oCOUNT_REM+lpad(parseInt(dsCnt)-1, 3, "0");
			//alert("oDUTY_LBL:"+oDUTY_LBL+", oCOUNT_REM:"+oCOUNT_REM);

            document.getElementById("txtUPDUTY_CD").value = oUPDUTY_CD;
            document.getElementById("txtUPDUTY_NM").value = oUPDUTY_NM;
            document.getElementById("txtDUTY_LBL").value = oDUTY_LBL;
            document.getElementById("txtCOUNT_REM").value = oCOUNT_REM;

			//�Է� ���̺�� ��Ŀ��
			document.getElementById("txtDUTY_CD").focus();
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			var DUTY_CD = document.getElementById("txtDUTY_CD").value;

           // dsT_ED_CLASS.AddRow();
           // dsT_ED_CLASS.NameValue(dsT_ED_CLASS.RowPosition, "DUTY_CD") = DUTY_CD;      // �����ڵ�

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_ED_CLASS.CountColumn == 0) {
                alert("���� �����ڵ带  ����, ��ȸ�۾��� �Ͻ� ������ �۾��� �Ͻñ� �ٶ��ϴ�.");
                return;
            }
            else {


               if (dsT_ED_CLASS.CountRow == 0) {

                    if (DUTY_CD == "") {
                       alert("���� �ڵ尡 �����ϴ�. �۾��� ��ҵǾ����ϴ�."+DUTY_CD);
                       return;
                    }

                    dsT_ED_CLASS.AddRow();

                    dsT_ED_CLASS.NameValue(dsT_ED_CLASS.RowPosition, "DUTY_CD") = DUTY_CD;      // �����ڵ�

               } else {

                    dsT_ED_CLASS.InsertRow(dsT_ED_CLASS.RowPosition+1);
                    dsT_ED_CLASS.NameValue(dsT_ED_CLASS.RowPosition, "DUTY_CD") = DUTY_CD;      // �����ڵ�
               }

            }
        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_CLASS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }


            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_ED_CLASS.ColumnString(dsT_ED_CLASS.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ED_CLASS.DeleteRow(dsT_ED_CLASS.RowPosition);
			tr01T_CM_DUTYMST.KeyValue = "SVL(I:dsT_ED_CLASS=dsT_ED_CLASS)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=DEL_02";
			tr01T_CM_DUTYMST.post();


        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {
			dsT_CM_DUTYMST.ClearData();
			dsT_ED_CLASS.ClearData();
			ds01T_CM_DUTYMST.ClearData();
			dsT_CM_DUTYMST.Reset();

			fnc_ColEnabled('D');
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (ds01T_CM_DUTYMST.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
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
        function fnc_SaveItemCheck() {
   			var f = document.form1;

			//DataSet�� ���� ���� Ȯ��
			if (!ds01T_CM_DUTYMST.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oDUTY_CD, oDUTY_NM, oIPT_YMD, oEND_YMD;
			var RowCnt = ds01T_CM_DUTYMST.CountRow;
			for(i=1; i<=RowCnt; i++){

				oDUTY_CD = ds01T_CM_DUTYMST.NameValue(i,"DUTY_CD");
				if(oDUTY_CD.trim().length != 6){
					alert(i+"��°�� �����ڵ�� �ݵ�� 6�ڸ����� �մϴ�.");
					ds01T_CM_DUTYMST.RowPosition = i;
					document.getElementById("txtDUTY_CD").focus();
					return false;
				}

				oDUTY_NM = ds01T_CM_DUTYMST.NameValue(i,"DUTY_NM");
				if(oDUTY_NM.trim() == ""){
					alert(i+"��°�� �������� �߸��Ǿ����ϴ�." );
					ds01T_CM_DUTYMST.RowPosition = i;
					document.getElementById("txtDUTY_NM").focus();
					return false;
				}

				oIPT_YMD = ds01T_CM_DUTYMST.NameValue(i,"IPT_YMD");
				if(!cfDateExpr(oIPT_YMD) || oIPT_YMD.trim().length == 0){//������� �ݵ�� �����Ѵ�.
					alert(i+"��°�� �������  �߸��Ǿ����ϴ�." );
					ds01T_CM_DUTYMST.RowPosition = i;
					document.getElementById("txtIPT_YMD").focus();
					return false;
				}

				oEND_YMD = ds01T_CM_DUTYMST.NameValue(i,"END_YMD");
				if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){//������� �ȵ��� �ȴ�.
					alert(i+"��°�� �������  �߸��Ǿ����ϴ�." );
					ds01T_CM_DUTYMST.RowPosition = i;
					document.getElementById("txtEND_YMD").focus();
					return false;
				}

				if(oEND_YMD.trim().length != 0){//������� �ִٸ� �ݵ�� ����Ϻ��� �����̾�� �Ѵ�.
					oIPT_YMD = parseInt(oIPT_YMD.replaceStr("-",""));
					oEND_YMD = parseInt(oEND_YMD.replaceStr("-",""));
					if(oIPT_YMD > oEND_YMD){
						alert(i+"��°�� ������� ����Ϻ��� �����ϴ�." );
						ds01T_CM_DUTYMST.RowPosition = i;
						document.getElementById("txtEND_YMD").focus();
						return false;
					}
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grd01T_CM_DUTYMST,15,"false","right");
            cfStyleGrid(form1.grdT_ED_CLASS,15,"true","right");

            fnc_ColEnabled('D');

			//form load�� ������ �����ڵ� Ʈ�����·� ��ȸ
            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����
			try {
				dsT_CM_DUTYMST.DataId="/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SHR";
				dsT_CM_DUTYMST.Reset();

				//idsT_CM_DUTYMST.DataId="/servlet/GauceChannelSVL?cmd=template.hhh.pilot.cmd.RetrieveTreeImageListCMD";
				//idsT_CM_DUTYMST.Reset();
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

		/***************************************
		 * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// �ش� �÷��� �Ӽ��� Enabled�� ����
			if (prop == 'E') {
				form1.txtDUTY_CD.disabled  = false;
				form1.txtDUTY_NM.disabled  = false;
				form1.txtIPT_YMD.disabled  = false;
				form1.txtEND_YMD.disabled  = false;

				document.getElementById("img_HelpOn1").disabled = false;
				document.getElementById("img_HelpOn2").disabled = false;
			}
			// �ش� �÷��� �Ӽ��� Disabled�� ����
			else if (prop == 'D') {
				form1.txtDUTY_CD.disabled  = true;
				form1.txtDUTY_NM.disabled  = true;
				form1.txtIPT_YMD.disabled  = true;
				form1.txtEND_YMD.disabled  = true;

				document.getElementById("img_HelpOn1").disabled = true;
				document.getElementById("img_HelpOn2").disabled = true;
			}
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
    | 2. �̸� : dsT_CM_DUTYMST                                            |
    | 3. Table List : T_CM_DUTYMST                                       |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. Ʈ�� �̹��� DataSet                                              |
    | 2. �̸� : idsT_CM_DUTYMST                                           |
    | 3. Table List : T_CM_DUTYMST                                       |
    +----------------------------------------------->
    <!--
	<object id=idsT_CM_DUTYMST classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
			<param name=SyncLoad	value="true">
	</object>
	 -->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CM_DUTYMST                                        |
    | 3. Table List : T_CM_DUTYMST                                       |
    +----------------------------------------------->
    <Object ID="ds01T_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CM_DUTYMST                                    |
    | 3. Table List : T_CM_DUTYMST                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_DUTYMST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
	        //���������� �ϳ��� ������ ȸ�������� �ִ´�.
	        dsT_CM_DUTYMST.AddRow();
			tr01T_CM_DUTYMST.KeyValue = "SVL(I:dsT_CM_DUTYMST=dsT_CM_DUTYMST)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SAV";
			tr01T_CM_DUTYMST.post();
            dsT_CM_DUTYMST.Reset();//Ʈ���� �籸���Ѵ�.
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_DUTYMST.CountRow);
        }
    </Script>

    <Script For=ds01T_CM_DUTYMST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

			fnc_ColEnabled('D');
        } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CM_DUTYMST.CountRow);

	        fnc_ColEnabled('E');
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CM_DUTYMST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_DUTYMST Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�����ڵ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�����ڵ忡 ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr01T_CM_DUTYMST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr01T_CM_DUTYMST event="OnFail()">
	    cfErrorMsg(this);
    </script>

    <!-------------------------------+
    | treeview���� item�� Ŭ��������      |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CM_DUTYMST event=OnItemClick()>
		var overId1 = "DUTY_CD";
		var overId2 = "COUNT_REM";
		var overNm = tvT_CM_DUTYMST.ItemText;
		var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
		var overValue1 = dsT_CM_DUTYMST.NameValue(Row,overId1);
		var overValue2 = dsT_CM_DUTYMST.NameValue(Row,overId2);
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1);
		try {
			ds01T_CM_DUTYMST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CM_DUTYMST.Reset();

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : T_ED_CLASS                          |
    | 3. Table List : T_ED_CLASS                    |
    +----------------------------------------------->
    <Object ID="dsT_ED_CLASS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

  <script language=JavaScript for=grd01T_CM_DUTYMST event=OnClick(row,colid)>

			var DUTY_CD = document.getElementById("txtDUTY_CD").value;

			tr01T_CM_DUTYMST.KeyValue = "tr06(O:dsT_ED_CLASS=dsT_ED_CLASS)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf011.cmd.VLUF011CMD&S_MODE=SHR_02&DUTY_CD="+DUTY_CD;
			tr01T_CM_DUTYMST.post();

  </script>
<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">
<!-- ���ε��� ���� �ӽõ����� ���� -->
<input type="hidden" id="txtDUTY_LBL">
<input type="hidden" id="txtCOUNT_REM">
<input type="hidden" id="txtDOWNDUTY_CD">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">(����)�����ڵ���</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">�����ڵ���</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423"><input id="txtUPDUTY_CD" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">����������</td>
					<td class="padding2423"><input id="txtUPDUTY_NM" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">���뿪����ǥ</td>
					<td class="padding2423"><input id="txtACH_COM" style="width:100%"></td>
					<td align="center" class="creamBold">����������ǥ</td>
					<td class="padding2423"><input id="txtACH_JOB" style="width:100%"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423"><input id="txtDUTY_CD" style="width:100%" maxlength="6"></td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423"><input id="txtDUTY_NM" style="width:100%" maxlength="25"></td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<input id="txtIPT_YMD" style="width:84" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn1" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"onclick="calendarBtn('datetype1','txtIPT_YMD','','450','134');"></a>
					</td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<input id="txtEND_YMD" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn2" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','650','134');"></a>
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

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
							<param name=DataID		value="dsT_CM_DUTYMST">
							<param name=TextColumn	value="DUTY_NM">
							<param name=LevelColumn	value="DUTY_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CM_DUTYMST">
							<param name=ImgCColumn	value="ImgC">
							<param name=ImgDColumn	value="ImgD">
							<param name=ImgOColumn	value="ImgO"> -->
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
						<object	id="grd01T_CM_DUTYMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:180px">
							<param name="DataID"							value="ds01T_CM_DUTYMST">
                            <param name="EdiTABLE"				value="false">
                            <param name="DragDropEnable"		value="true">
                            <param name="SortView"					value="Left">
                            <param name="VIEWSUMMARY"		value=0>
                            <param name="Format"						value="
								<C> id='DUTY_CD'		width=80	    name='�ڵ�'			sort=true		align=center									</C>
								<C> id='DUTY_NM'		width=120		name='������'		sort=true		align=left		 								</C>
								<C> id='ACH_COM'		width=90		name='�����ǥ'		sort=true		align=center 								</C>
								<C> id='ACH_JOB'		width=90		name='������ǥ'		sort=true		align=center 								</C>
								<C> id='IPT_YMD'		width=90		name='�����'		sort=true		align=center 								</C>
								<C> id='END_YMD'		width=90		name='�����'		sort=true		align=center									</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ �׸��� ���̺� ��-->
			<br>������������ �̼�����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image11" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image12" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save2()"></a>


			<!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ED_CLASS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:170px">
							<param name="DataID"							value="dsT_ED_CLASS">
                            <param name="EdiTABLE"				value="true">
                            <param name="DragDropEnable"		value="true">
                            <param name="SortView"					value="Left">
                            <param name="VIEWSUMMARY"		value=0>
                            <param name="Format"						value="
								<C> id='DUTY_CD'		width=100	    name='�����ڵ�'			sort=true		align=center	edit=none								</C>
								<C> id='CLAS_CD'		width=100		name='�з��ڵ�'		sort=true		align=left		 								</C>
								<C> id='CLAS_NM'		width=250		name='�����з���'		sort=true		align=center 								</C>
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

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                        |
    | 2. �̸� : bndT_CM_DUTYMST                     |
    | 3. Table List : T_CM_DUTYMST                  |
    +----------------------------------------------->
	<object id="bndT_CM_DUTYMST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="ds01T_CM_DUTYMST">
		<Param Name="BindInfo", Value="
			<C>Col='UPDUTY_CD'				Ctrl='txtUPDUTY_CD'				Param=value</C>
			<C>Col='UPDUTY_NM'				Ctrl='txtUPDUTY_NM'				Param=value</C>
			<C>Col='DUTY_CD'				Ctrl='txtDUTY_CD'					Param=value</C>
			<C>Col='DUTY_NM'				Ctrl='txtDUTY_NM'					Param=value</C>
			<C>Col='ACH_JOB'				Ctrl='txtACH_JOB'					Param=value</C>
			<C>Col='ACH_COM'				Ctrl='txtACH_COM'					Param=value</C>
			<C>Col='IPT_YMD'				Ctrl='txtIPT_YMD'					Param=value</C>
			<C>Col='END_YMD'				Ctrl='txtEND_YMD'					Param=value</C>
			<C>Col='DUTY_LBL'				Ctrl='txtDUTY_LBL'					Param=value</C>
			<C>Col='COUNT_REM'				Ctrl='txtCOUNT_REM'			Param=value</C>
			<C>Col='DOWNDUTY_CD'			Ctrl='txtDOWNDUTY_CD'			Param=value</C>
	    ">
	</object>
