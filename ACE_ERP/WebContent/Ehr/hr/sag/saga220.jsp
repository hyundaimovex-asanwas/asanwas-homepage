<!--
    ************************************************************************************
    * @source         : saga200.jsp 				                                   												     *
    * @description   : �޿��۱��Ƿڼ�                                 											 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            										 *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/06/01      �̵���        ERP �̻�
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>�޿��۱��Ƿڼ�</title>
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

        var savObj = new Array();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // ��������
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // ��������
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���

			//�������ڰ� ������ ��ȸ ����.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}


            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";

            //�����ͼ� ����
            dsT_CP_PAYTABLE.UseChangeInfo = true;
            dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga220.cmd.SAGA220CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CP_PAYTABLE.Reset();

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
			if( !fnc_SaveItemCheck() )	return;

            if(savObj.type == "UPLOAD"
                    && !confirm("[��������:"+savObj.apy_ymd+", �ٷα���:"+savObj.occ_cd+"] �� �ش� �Ǵ� ��� ����Ÿ�� �ʱ�ȭ �˴ϴ�.\n����Ͻðڽ��ϱ�?")){
                return;
            }

			//Ʈ����� ����
			trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE, O:dsRESULT=dsRESULT)";
			trT_CP_PAYTABLE.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga220.cmd.SAGA220CMD&S_MODE=SAV&TYPE="+savObj.type;
			trT_CP_PAYTABLE.Post();

        }

		/******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CP_PAYTABLE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_CP_PAYTABLE.ColumnString(dsT_CP_PAYTABLE.RowPosition,4) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CP_PAYTABLE.DeleteRow(dsT_CP_PAYTABLE.RowPosition);
			trT_CP_PAYTABLE.KeyValue = "SVL(I:SAV=dsT_CP_PAYTABLE)";
			trT_CP_PAYTABLE.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga220.cmd.SAGA220CMD&S_MODE=DEL";
			trT_CP_PAYTABLE.post();

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var JOB_CD_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // ��������

			//�������ڰ� ������ ��ȸ����.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//������ ������ ��ȸ ����.
			if(JOB_CD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("������ �Է��ϼ���.");
					document.getElementById("cmbSAL_GBN_SHR").focus();
					return false;
				}
			}

     	    var url = "saga220_PV.jsp?APY_YMD_SHR="+APY_YMD_SHR+"&OCC_CD_SHR=A&JOB_CD_SHR="+JOB_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYTABLE.GridToExcel("�޿����̺�", '', 225);

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var JOB_CD_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // ��������
			var JOB_NM_SHR = document.getElementById("txtJOB_NM_SHR").value; // ��������
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���
			var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value; // ����

			if(APY_YMD_SHR.trim().length == 0){
				alert("�������ڸ� �Է��ϼ���.");
				document.getElementById("txtAPY_YMD_SHR").focus();
				return false;
			}

			if(APY_YMD_SHR.trim().length != 10){
				alert("�������ڰ� �߸��Ǿ����ϴ�.");
				document.getElementById("txtAPY_YMD_SHR").focus();
				return false;
			}

			if(JOB_CD_SHR.trim().length == 0){
				alert("������ �Է��ϼ���.");
				document.getElementById("cmbSAL_GBN_SHR").focus();
				return false;
			}

			if(ENO_NO_SHR.trim().length == 0){
				alert("����� �Է��ϼ���.");
				document.getElementById("txtENO_NO_SHR").focus();
				return false;
			}

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CP_PAYTABLE.CountColumn == 0) {
                dsT_CP_PAYTABLE.setDataHeader("OCC_CD:STRING:KEYVALUETYPE,JOB_CD:STRING:KEYVALUETYPE,HOB_CD:STRING:KEYVALUETYPE,APY_YMD:STRING:KEYVALUETYPE,BAS_AMT:DECIMAL,DUTY_AMT:DECIMAL,OT_AMT:DECIMAL,WEL_AMT:DECIMAL,OSE_AMT:DECIMAL,RUN_AMT:DECIMAL,MH_AMT:DECIMAL,SOU_CNT:DECIMAL");
            }

            dsT_CP_PAYTABLE.AddRow();

			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"APY_YMD")=APY_YMD_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"JOB_CD")=JOB_CD_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"JOB_NM")=JOB_NM_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"ENO_NM")=ENO_NM_SHR;
			dsT_CP_PAYTABLE.NameValue(dsT_CP_PAYTABLE.RowPosition,"ENO_NO")=ENO_NO_SHR;

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

			fnc_OnLoadProcess();
			dsT_CP_PAYTABLE.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbSAL_GBN_SHR").value = "";
			document.getElementById("txtJOB_NM_SHR").value = "";
			document.form1.txtAPY_YMD_SHR.focus();


            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_PAYTABLE.IsUpdated)  {

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

        	if (!dsT_CP_PAYTABLE.isUpdated && dsT_CP_PAYTABLE.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	
			fnc_ChangeGrid();      //�׸��� ���� ó��

			document.form1.cmbSAL_GBN_SHR.selectedIndex = 0;

			//�ֱ� ������ ������ ��ȸ
			ds01T_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga220.cmd.SAGA220CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			//���� ��� �����¸� �����°� ����
			var APY_YMD_SHR = (document.getElementById("txtAPY_YMD_SHR").value).replace("-", "").replace("-", "");
			if(APY_YMD_SHR.trim() == ""){
				document.getElementById("txtAPY_YMD_SHR").value = "";
			}


            savObj.type = "";
            savObj.apy_ymd = "";
            
            fnc_SearchList();
            
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17. �������� ���ε� ó��  *
         ****************************/
         function fnc_FileUpload() {

        	var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // ��������

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// �ش� Dataset�� Header�� ������ Header ����
            if (dsFILE_UPLOAD.CountColumn < 1) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_CP_PAYTABLE=dsT_CP_PAYTABLE)";
                trFILE_UPLOAD.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga220.cmd.SAGA220CMD&S_MODE=SHR_02&APY_YMD="+APY_YMD_SHR+"&OCC_CD=A&JOB_CD="+JOB_CD_SHR;
                trFILE_UPLOAD.post();

            }

        }

        /*************************
         * �׸��� ���� ó��               *
         ************************/
		function fnc_ChangeGrid(obj) {

			if(obj == undefined || obj.value == "A"){
				form1.grdT_CP_PAYTABLE.Format = "<C> id='{CUROW}'		width=50		name='NO'						align=center		value={String(Currow)}		BgColor='#EEEEEE'		</C>" +
																		"<C> id='ENO_NM'        width=90        name='����'          	align=center    Edit=none  SumBgColor=#C3D0DB SumText='��'</C>" +
																		"<C> id='ENO_NO'        width=70        name='���'          	align=center    Edit=none  SumBgColor=#C3D0DB</C>" +
																		"<C> id='JOB_NM'        width=120        name='������'        	align=center    Edit=none  SumBgColor=#C3D0DB</C>" +
																		"<C> id='ABA_CD'        width=60        name='�ڵ�'      		align=center      SumBgColor=#C3D0DB</C>" +
																		"<C> id='ABA_NM'        width=130        name='�����'      	align=center       SumBgColor=#C3D0DB</C>" +
																		"<C> id='ACC_NO'        width=150        name='���¹�ȣ'      align=center       SumBgColor=#C3D0DB</C>" +
																		"<C> id='PAY_AMT'        width=90        name='�ݾ�'      		align=right       SumBgColor=#C3D0DB</C>" +
																		"<C> id='DESCPT'        width=200        name='���'      		align=center       SumBgColor=#C3D0DB</C>";

            }
			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_CP_PAYTABLE,15,"true","true");

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>



    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���ε�� Data Transacton              |
    | 2. �̸� : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CP_PAYTABLE                                |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
			document.getElementById("txtAPY_YMD_SHR").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
			document.getElementById("txtAPY_YMD_SHR").focus();
			document.getElementById("txtPAY_YMD_SHR").value = oAPY_YMD.substring(0,4);

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[��������/��������/����/���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("��������/�ٷα���/����/ȣ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CP_PAYTABLE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();
    </script>

    <script for=trFILE_UPLOAD event="OnSuccess()">
		document.getElementById("resultMessage").innerText = "����÷�ΰ� �Ϸ�Ǿ����ϴ�.";

        //ROW ���¸� �� INSERT ���·� ���� ���� ���� (���� db ������ ����)
        dsT_CP_PAYTABLE.UseChangeInfo = false;

        savObj.type     = "UPLOAD";
        //savObj.occ_cd   = document.getElementById("cmbOCC_CD_SHR").value; // �ٷα��б���
        savObj.apy_ymd  = document.getElementById("txtAPY_YMD_SHR").value; // ��������
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CP_PAYTABLE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">���س⵵</td>
								<td>
								<input id="txtPAY_YMD_SHR" style="width:83" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								</td>
								<td align="center" class="searchState">��������</td>
								<td>
									<input id="txtAPY_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','535','112');"></a>
								</td>
							</tr>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�޻󿩱���</td>
								<td>
								    <select id="cmbSAL_GBN_SHR" style="width:80" >
										<option value="0" >�޿�</option>
	                                    <option value="1" >��</option>
									</select>
								</td>
								<td align="center" class="searchState">�����ȣ</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"							value="dsT_CP_PAYTABLE">
							<param name="EdiTABLE"						value="false">
							<param name="DragDropEnable"				value="true">
							<param name="SortView"						value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

