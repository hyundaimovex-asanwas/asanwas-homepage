<!--
    ************************************************************************************
    * @Source         : edue033.jsp                                                    *
    * @Description    : ���������������� PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  ������   | �����ۼ�                                               *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/16  |  ������   | �ҽ�����                                               *                         *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>

    <head>
    <title>�ű���������</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >



        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	
            var EDU_CD = opener.edu_cd;
            
            var EDU_NM = opener.edu_nm;

            dsT_ED_CHASULIST.ClearData();

            dsT_ED_CHASULIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue033.cmd.EDUE033CMD"
						                                    + "&S_MODE=SHR"
						                                    + "&EDU_CD="+EDU_CD;

            dsT_ED_CHASULIST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if (!fnc_SaveItemCheck()) {
                return;
            }

			dsT_ED_CHASULIST.UseChangeInfo = false;
            trT_ED_CHASULIST.KeyValue = "tr01(I:SAV=dsT_ED_CHASULIST)";
            trT_ED_CHASULIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue033.cmd.EDUE033CMD&S_MODE=SAV&EDU_CD="+opener.edu_cd+"&MNGER_CD="+opener.mnger_cd+"&EDU_GBN_CD="+opener.edu_gbn_cd;
            trT_ED_CHASULIST.post();
            dsT_ED_CHASULIST.UseChangeInfo = true;
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //����� ���� ����� ������ ������
            if (dsT_ED_CHASULIST.CountColumn == 0) {
            	
				alert("��ȸ �� �߰��Ͻʽÿ�.");
				
				return;
				
            }

            // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ED_CHASULIST.AddRow();

            //������ ������ ��ȸ
            fnc_GetMaster();

            // �� row�� �߰��ϰ� �⺻���� �ʱ�ȭ ��Ŵ
             dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "EDU_CD")      = opener.edu_cd;
             dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "EDU_NM")      = opener.edu_nm;


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_ED_CHASULIST.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

	        // ��û��������
	        if (dsT_ED_CHASULIST.NameValue(1, "ENT_STR_YMD") == '') {
	            alert("��û�������ڴ� �ʼ��Է��׸��Դϴ�.");
	            document.getElementById("txtENT_STR_YMD").focus();
	            return false;
	        }

	        // ��û�������� CHECK
	        if (!fnc_CheckDate2(dsT_ED_CHASULIST.NameValue(1, "ENT_STR_YMD"), "��û��������")
	                && dsT_ED_CHASULIST.NameValue(1, "ENT_STR_YMD") != "") {
	            dsT_ED_CHASULIST.RowPosition = i;
	            document.getElementById("txtENT_STR_YMD").focus();
	            return false;
	        }

	        // ��û��������
	        if (dsT_ED_CHASULIST.NameValue(1, "ENT_END_YMD") == '') {
	            alert("��û�������ڴ� �ʼ��Է��׸��Դϴ�.");
	            document.getElementById("txtENT_END_YMD").focus();
	            return false;
	        }

	        // ��û�������� CHECK
	        if (!fnc_CheckDate2(dsT_ED_CHASULIST.NameValue(1, "ENT_END_YMD"), "��û��������")
	                && dsT_ED_CHASULIST.NameValue(1, "ENT_END_YMD") != "") {
	            dsT_ED_CHASULIST.RowPosition = i;
	            document.getElementById("txtENT_END_YMD").focus();
	            return false;
	        }

	        // ��û�Ⱓ
	        if(dsT_ED_CHASULIST.NameValue(1, "ENT_STR_YMD") != ''
	                && dsT_ED_CHASULIST.NameValue(1, "ENT_END_YMD") != '') {
	            if(removeChar(dsT_ED_CHASULIST.NameValue(1, "ENT_STR_YMD"),'-') > removeChar(dsT_ED_CHASULIST.NameValue(1, "ENT_END_YMD"),'-')) {
	                alert("��û�������ڴ� �ݵ�� ��û�������ں��� �۾ƾ��մϴ�.");
	                document.getElementById("txtENT_STR_YMD").focus();
	                return false;
	            }
	        }

	        // �н���������
	        if (dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD") == '') {
	            alert("�н��������ڴ� �ʼ��Է��׸��Դϴ�.");
	            document.getElementById("txtEDU_STR_YMD").focus();
	            return false;
	        }

	        // �н��������� CHECK
	        if (!fnc_CheckDate2(dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD"), "�н���������")
	                && dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD") != "") {
	            dsT_ED_CHASULIST.RowPosition = i;
	            document.getElementById("txtEDU_STR_YMD").focus();
	            return false;
	        }

	        if (dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD") == '') {
	            alert("�н��������ڴ� �ʼ��Է��׸��Դϴ�.");
	            document.getElementById("txtEDU_END_YMD").focus();
	            return false;
	        }

	        // �н��������� CHECK
	        if (!fnc_CheckDate2(dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD"), "�н���������")
	                && dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD") != "") {
	            dsT_ED_CHASULIST.RowPosition = i;
	            document.getElementById("txtEDU_END_YMD").focus();
	            return false;
	        }

	        // �н��Ⱓ
	        if(dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD") != ''
	                && dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD") != '') {
	            if(removeChar(dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD"),'-') > removeChar(dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD"),'-')) {
	                alert("�н��������ڴ� �ݵ�� �н��������ں��� �۾ƾ��մϴ�.");
	                document.getElementById("txtEDU_STR_YMD").focus();
	                return false;
	            }
	        }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_ComboSet();

            fnc_EnableElementAll(elementList);

            //��뺸��
            fnc_ConstructCommonCode("dsCOMMON_QA", "cmbINS_YN");

            document.getElementById('txtEDU_CD').value = opener.edu_cd;
            document.getElementById('txtEDU_NM').value = opener.edu_nm;
            
            // ������ ��ȸ
            fnc_SearchList();      
            
			document.getElementById("txtENT_STR_YMD").value = gcurdate;            
			document.getElementById("txtENT_END_YMD").value = gcurdate;             
			document.getElementById("txtEDU_STR_YMD").value = gcurdate;            
			document.getElementById("txtEDU_END_YMD").value = gcurdate;     			
        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_CHASULIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /**
         * �ֹι�ȣ ����
         */
        function fnc_SsnValid(val) {
            if (val != "") {
                if (!covSsnValidator_validate(removeChar(val,'-'))) {
                    alert("�߸��� �ֹι�ȣ�Դϴ�. Ȯ�ιٶ��ϴ�.");
                    return false;
                }
            }
            else {
                return false;
            }

            return true;
        }




        /**
         *   �űԹ�ư Ŭ����
         *   ������ ������ ��ȸ �����
         */

          function fnc_GetMaster(){

            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue033.cmd.EDUE033CMD"
                                      + "&S_MODE=NEW"
                                      + "&EDU_CD="+opener.edu_cd
                                      ;
            dsT_ED_COURSELIST.Reset();

          }

        /********************
         * �޺��ڽ� �� SET  *
         ********************/
        function fnc_ComboSet() {
            var oOption = null;

            //��������
            for( var i = 1; i <= dsCOMMON_Q6.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q6.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q6.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEDU_GBN_CD").add(oOption);

            }

            //�����ְ�
            for( var i = 1; i <= dsCOMMON_Q7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMNGER_CD").add(oOption);

            }

            //�����о�
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD").add(oOption);

            }

            //��������
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD").add(oOption);

            }

            //���δ�
            for( var i = 1; i <= dsCOMMON_QB.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QB.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QB.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCOST_CD").add(oOption);

            }

            //�������
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbPLACE_CD").add(oOption);

            }
        }

        var elementList = new Array(     "cmbINS_YN"
                                        ,"txtPLACE_TAG"
                                        ,"txtENT_STR_YMD"
                                        ,"txtENT_END_YMD"
                                        ,"txtEDU_STR_YMD"
                                        ,"txtEDU_END_YMD"
                                        ,"txtCET_NO"
                                        ,"txtSPK_ENO_NM"
                                        ,"ImgEntStrYmd"
                                        ,"ImgEntEndYmd"
                                         ,"ImgEduStrYmd"
                                         ,"ImgEduEndYmd"
                                        ,"ImgCetNo"

                                        ,"cmbEDU_GBN_CD"
                                        ,"cmbMNGER_CD"
                                        ,"cmbFIELD_CD"
                                        ,"cmbSHAPE_CD"
                                        ,"txtGOAL_TAG"

                                        ,"txtCONTENT_TXT"
                                        ,"txtEFFECT_TAG"
                                        ,"txtOBJ_TAG"
                                        ,"txtCPT_TAG"

                                        ,"txtINT_NAM"
                                        ,"txtFIX_NO"
                                        ,"txtDAY_NO"
                                        ,"txtTIME_NO"
                                        ,"medCOST_AMT"
                                        ,"cmbCOST_CD"
                                        ,"medRTN_AMT"
                                        ,"cmbPLACE_CD"
                                        ,"txtCPT_PNT"
                                        ,"txtSITE_TAG"
                                        );

        var exceptionList = new Array(  "cmbEDU_GBN_CD"
                                       ,"cmbPLACE_CD"
                                        );
        
		// Link
		function fnc_SiteTag(){
			
			var siteTag = document.getElementById("txtSITE_TAG").value;
			
			if(siteTag == ""){
				
				return;
				
			}
			
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
			
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_CHASULIST)|
    | 3. ���Ǵ� Table List(T_ED_CHASULIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsCHASU" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_CHASULIST)|
    | 3. ���Ǵ� Table List(T_ED_CHASULIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_LCTRLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_CHASULIST)|
    | 3. ���Ǵ� Table List(T_ED_CHASULIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_CHASULIST)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ��뺸�� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_QA"/>
       <jsp:param name="CODE_GUBUN"    value="QA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �������� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q6"/>
       <jsp:param name="CODE_GUBUN"    value="Q6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �����ְ� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �����о� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �������� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���δ� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_QB"/>
       <jsp:param name="CODE_GUBUN"    value="QB"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ������� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        	fnc_AddNew();

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_LCTRLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("�������� �ʴ� ������ �ֹι�ȣ�Դϴ�.");
            
            dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "SPK_ENO_NM") = "";
            
            return;

        } else {

            dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition, "SPK_ENO_NM") = dsT_ED_LCTRLIST.NameValue(1,'ENO_NM');
            
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnDataError()">

        cfErrorMsg(this);

    </Script>



    <!-- Ʈ������ ����. -->
    <script for=trT_ED_CHASULIST event="OnSuccess()">

        //�׸���� �� ���� �սô�.
        opener.fnc_SearchList();

        window.close();

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_CHASULIST event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

 
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();"> 


<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>


<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�ű���������</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">����</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="10"  maxlength="10" class="input_ReadOnly"  readOnly >
                        <input id="txtEDU_NM" name="txtEDU_NM" size="100" class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <select id="cmbEDU_GBN_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="blueBold">�����ְ�</td>
                    <td class="padding2423" >
                        <select id="cmbMNGER_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����о�</td>
                    <td class="padding2423" >
                        <select id="cmbFIELD_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <select id="cmbSHAPE_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">������ǥ</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGOAL_TAG"  name="txtGOAL_TAG" style="width:100%" maxlength="100" >
                    </td>
                </tr>

                 <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtCONTENT_TXT"  name="txtCONTENT_TXT" style="width:100%" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">���ȿ��</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEFFECT_TAG" name="txtEFFECT_TAG" style="width:100%" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtOBJ_TAG" name="txtOBJ_TAG" style="width:100%" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtCPT_TAG" name="txtCPT_TAG" style="width:100%" >
                    </td>
                </tr>



                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtINT_NAM"  name="txtINT_NAM" style="width:100%" maxlength="22" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtFIX_NO"  name="txtFIX_NO" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3" > ��
                    </td>
                    <td align="center" class="blueBold">�����ð�</td>
                    <td class="padding2423" >
                        <input id="txtTIME_NO"  name="txtTIME_NO" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3" > �ð�
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����ϼ�</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtDAY_NO"  name="txtDAY_NO" style="width:34%;ime-mode:disabled;text-align:right;" maxlength="3" > ��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">���δ�</td>
                    <td class="padding2423" >
                        <select id="cmbCOST_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <select id="cmbPLACE_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <table>
                            <tr>
                                <td width="235">
			                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
			                            <param name=Alignment            value=2>
			                            <param name=Border               value=true>
			                            <param name=ClipMode             value=true>
			                            <param name=DisabledBackColor    value="#EEEEEE">
			                            <param name=Enable               value=true>
			                            <param name=IsComma              value=true>
			                            <param name=Language             value=0>
			                            <param name=MaxLength            value=9>
			                            <param name=Numeric              value=true>
			                            <param name=ShowLiteral          value="false">
			                            <param name=Visible              value="true">
			                            <param name=SelectAll            value="true">
			                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
			                    </td>
			                    <td>
			                    ��
			                    </td>
			                </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">ȯ�ޱݾ�</td>
                    <td class="padding2423" >
                        <table>
                            <tr>
                                <td width="235">
			                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
			                            <param name=Alignment            value=2>
			                            <param name=Border               value=true>
			                            <param name=ClipMode             value=true>
			                            <param name=DisabledBackColor    value="#EEEEEE">
			                            <param name=Enable               value=true>
			                            <param name=IsComma              value=true>
			                            <param name=Language             value=0>
			                            <param name=MaxLength            value=9>
			                            <param name=Numeric              value=true>
			                            <param name=ShowLiteral          value="false">
			                            <param name=Visible              value="true">
			                            <param name=SelectAll            value="true">
			                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td>
                                ��
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�̼�����</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="2" > ��
                    </td>
                    <td align="center" class="blueBold">�������Ʈ</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="28" maxlength="300" >&nbsp;<input type="button" value="����" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                </tr>

                <tr>
                    <td align="center" class="blueBold">��뺸��</td>
                    <td class="padding2423" >
                        <select id="cmbINS_YN" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_TAG"  name="txtPLACE_TAG" style="width:100%" maxlength="50">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��û�Ⱓ</td>
                    <td class="padding2423" >
                        <input id="txtENT_STR_YMD"  name="txtENT_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtENT_STR_YMD', 'txtENT_END_YMD')">
                        <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEntStrYmd','','../../images/button/btn_HelpOver.gif',1)" >
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEntStrYmd" name="ImgEntStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtENT_STR_YMD','','340','100');"></a>--> ~
                        <input id="txtENT_END_YMD"  name="txtENT_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtENT_STR_YMD', 'txtENT_END_YMD')">
                        <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEntEndYmd','','../../images/button/btn_HelpOver.gif',1)" >
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEntEndYmd" name="ImgEntEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtENT_END_YMD','','300','400');"></a>-->
                    </td>
                    <td align="center" class="blueBold">�н��Ⱓ</td>
                    <td class="padding2423" >
                        <input id="txtEDU_STR_YMD"  name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD')">
                        <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd','','../../images/button/btn_HelpOver.gif',1)" >
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEduStrYmd" name="ImgEduStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD','','500','600');"></a>--> ~
                        <input id="txtEDU_END_YMD"  name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD')">
                        <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd','','../../images/button/btn_HelpOver.gif',1)" >
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEduEndYmd" name="ImgEduEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD','','700','800');"></a>-->
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->



</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �򰡴���ڼ��� ���̺� -->
<object id="bndT_ED_CHASULIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_CHASULIST">
    <Param Name="BindInfo", Value='
        <C>Col=EDU_CD       Ctrl=txtEDU_CD       Param=value </C>
        <C>Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>

        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=INS_YN       Ctrl=cmbINS_YN       Param=value </C>
        <C>Col=PLACE_TAG    Ctrl=txtPLACE_TAG    Param=value </C>
        <C>Col=ENT_STR_YMD  Ctrl=txtENT_STR_YMD  Param=value </C>
        <C>Col=ENT_END_YMD  Ctrl=txtENT_END_YMD  Param=value </C>
        <C>Col=EDU_STR_YMD  Ctrl=txtEDU_STR_YMD  Param=value </C>
        <C>Col=EDU_END_YMD  Ctrl=txtEDU_END_YMD  Param=value </C>
        <C>Col=CET_NO       Ctrl=txtCET_NO       Param=value </C>
        <C>Col=SPK_ENO_NM   Ctrl=txtSPK_ENO_NM   Param=value </C>

        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=GOAL_TAG     Ctrl=txtGOAL_TAG     Param=value </C>

        <C>Col=CONTENT_TXT  Ctrl=txtCONTENT_TXT  Param=value </C>
        <C>Col=EFFECT_TAG   Ctrl=txtEFFECT_TAG   Param=value </C>
        <C>Col=OBJ_TAG      Ctrl=txtOBJ_TAG      Param=value </C>
        <C>Col=CPT_TAG      Ctrl=txtCPT_TAG      Param=value </C>

        <C>Col=INT_NAM      Ctrl=txtINT_NAM      Param=value </C>
        <C>Col=FIX_NO       Ctrl=txtFIX_NO       Param=value </C>
        <C>Col=DAY_NO       Ctrl=txtDAY_NO       Param=value </C>
        <C>Col=TIME_NO      Ctrl=txtTIME_NO      Param=value </C>
        <C>Col=COST_AMT     Ctrl=medCOST_AMT     Param=text  </C>
        <C>Col=COST_CD      Ctrl=cmbCOST_CD      Param=value </C>
        <C>Col=RTN_AMT      Ctrl=medRTN_AMT      Param=text  </C>
        <C>Col=PLACE_CD     Ctrl=cmbPLACE_CD     Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=SITE_TAG     Ctrl=txtSITE_TAG     Param=value </C>
    '>
</object>



<!-- ������ �Է����� �������� -->
<Object id="bndT_ED_COURSELIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
     <Param Name="DataID", Value="dsT_ED_COURSELIST">
     <Param Name="BindInfo", Value='
        <C>Col=EDU_CD   Ctrl=txtEDU_CD   Param=value </C>
        <C>Col=EDU_NM   Ctrl=txtEDU_NM   Param=value </C>
        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=GOAL_TAG     Ctrl=txtGOAL_TAG     Param=value </C>
        <C>Col=CONTENT_TXT  Ctrl=txtCONTENT_TXT  Param=value </C>
        <C>Col=EFFECT_TAG   Ctrl=txtEFFECT_TAG   Param=value </C>
        <C>Col=OBJ_TAG      Ctrl=txtOBJ_TAG      Param=value </C>
        <C>Col=CPT_TAG      Ctrl=txtCPT_TAG      Param=value </C>
     '>
</Object>
