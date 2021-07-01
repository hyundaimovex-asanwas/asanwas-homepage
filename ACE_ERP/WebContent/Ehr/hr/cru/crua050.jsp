<!--
***********************************************************************
* @source      : crua050.jsp
* @description : �����ɻ���ذ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/05      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����ɻ���ذ���(crua050)</title>
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
    <script language="javascript" >

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var oYMD_SHR = document.getElementById("txtYMD_SHR");
            if(oYMD_SHR.value == "") {
                alert("�������� �Է��� �ּ���");
                oYMD_SHR.focus();
                return;
            }

            var ymd = document.getElementById("txtYMD_SHR").value;
            var cd_gbn = document.getElementById("cmbCD_GBN_SHR").value;
            var work_gbn = document.getElementById("cmbWORK_GBN_SHR").value;
            var gubun = document.getElementById('cmbGUBUN_SHR').value;

            dsT_RC_JUDGESTD.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua050.cmd.CRUA050CMD&S_MODE=SHR&YMD="+ymd+"&CD_GBN="+cd_gbn+"&WORK_GBN="+work_gbn+"&GUBUN="+gubun;
            dsT_RC_JUDGESTD.reset();

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

				if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

				trT_RC_JUDGESTD.KeyValue = "tr01(I:dsT_RC_JUDGESTD=dsT_RC_JUDGESTD)";
				trT_RC_JUDGESTD.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua050.cmd.CRUA050CMD&S_MODE=SAV";
				trT_RC_JUDGESTD.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			var row = dsT_RC_JUDGESTD.RowPosition;

			if(dsT_RC_JUDGESTD.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
            if(dsT_RC_JUDGESTD.NameValue(row,"END_YMD") != ""){
                alert("�ش絥���ʹ� ������ �� �����ϴ�!");
                return;
            }
			if(confirm("[�����׸�:" + dsT_RC_JUDGESTD.NameValue(row,'CD_GBN') + "/������:" + dsT_RC_JUDGESTD.NameValue(row,'STR_YMD') + "]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_RC_JUDGESTD.DeleteRow(row);
				trT_RC_JUDGESTD.KeyValue = "tr01(I:dsT_RC_JUDGESTD=dsT_RC_JUDGESTD)";
				trT_RC_JUDGESTD.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua050.cmd.CRUA050CMD&S_MODE=DEL";
				trT_RC_JUDGESTD.post();
			}

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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_RC_JUDGESTD.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_RC_JUDGESTD.setDataHeader("CD_GBN:STRING:KEYVALUE, STR_YMD:STRING:KEYVALUE, END_YMD:STRING, WORK_GBN:STRING:KEYVALUE, SEQ_NO:STRING:KEYVALUE, BASE_CNT:STRING, BASE_CD:STRING, BASE_NM:STRING, FULL_CNT:STRING, THAN_TAG:STRING, ADD_CNT:INTEGER");
			}

			dsT_RC_JUDGESTD.AddRow();

			//�ӽ�SEQ, ����ÿ��� PK�� �Ϸù�ȣ�� ���
			dsT_RC_JUDGESTD.NameValue(dsT_RC_JUDGESTD.RowPosition,'SEQ_NO') = dsT_RC_JUDGESTD.CountRow;

			document.getElementById('cmbCD_GBN').focus();

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

            //document.getElementById("txtYMD_SHR").value = "";
            document.getElementById("cmbCD_GBN_SHR").value = "";
            document.getElementById("cmbWORK_GBN_SHR").value = "";
			document.getElementById('cmbGUBUN_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_RC_JUDGESTD.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_RC_JUDGESTD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_JUDGESTD.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			for(i=1;i<dsT_RC_JUDGESTD.CountRow+1;i++){
				if(dsT_RC_JUDGESTD.NameValue(i,'STR_YMD') != '' && dsT_RC_JUDGESTD.NameValue(i,'END_YMD') != ''){
					if (dsT_RC_JUDGESTD.NameValue(i,'STR_YMD') > dsT_RC_JUDGESTD.NameValue(i,'END_YMD')) {
						alert("�������� ������ ���� �ݵ�� �۾ƾ� �մϴ�.");
						dsT_RC_JUDGESTD.RowPosition = i;
						document.getElementById('txtSTR_YMD').focus();
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
        
            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_RC_JUDGESTD,15,"false","false");      // Grid Style ����

            document.getElementById("txtYMD_SHR").value = getToday();
            document.getElementById('txtYMD_SHR').focus();
            
            dsCOMM_CODE.ClearData();
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_E7");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_E6");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_H1");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_F1");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_Z5");
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /**
         * �����׸��� ���� �Ǿ����� ó���� ����
         */
		function fnc_ChangeCdGbn() {
            
            //�ش�Ǵ� ���  �ڵ� �ʱ�ȭ
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "WORK_GBN") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CD" ) = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "FULL_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "THAN_TAG") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "ADD_CNT" ) = "";
            
            //�׸�� ���� ��Ŵ
            fnc_BindCode();
		}
        
        /**
         * �����׸��� ����Ǿ����� ���缭 �����ų �׸��
         */
        function fnc_BindCode() {
            var cd_gbn      = document.getElementById("cmbCD_GBN").value;
            var oSelect     = document.getElementById("cmbWORK_GBN");
            var oOption;
            var wrkGbnNames;
            var wrkGbnVals;
            
            fnc_ChangeStateElement(false, "cmbBASE_CD");    //�����ڵ� ���
            fnc_ChangeStateElement(false, "txtBASE_CNT");   //������ �����ϰ�
            fnc_ChangeStateElement(false, "txtFULL_CNT");   //ȯ�길�� �����ϰ�
            fnc_ChangeStateElement(false, "cmbTHAN_TAG");   //���� ��� ���ϰ�
            fnc_ChangeStateElement(false, "txtADD_CNT" );   //������ ��� ���ϰ�

			//'UGRDYN','�з�'
			//'UYMD','�����⵵'
			//'TAVE','����'
			//'TOEIC','����'
			//'UMAJOR','����'
			//'AWDYN','���ƴ��'
			//'LICENCE','�ڰ���'
			//'MILYN','����'
            
            //===================================
            //1.�����ڵ带 ���ε� �սô�.
            //===================================
            
            //�з�, ����, �ڰ���, ����, ���ƴ��
            if(cd_gbn=="UGRDYN" || cd_gbn=="UMAJOR" || cd_gbn=="LICENCE" || cd_gbn=="MILYN" || cd_gbn=="AWDYN"){
                
                fnc_ChangeStateElement(true , "cmbBASE_CD");

                //�����ڵ� ���ε�
                //�з� �϶�
                if(cd_gbn=="UGRDYN")        
                    fnc_ConstructCommonCode("dsT_CM_COMMON_E7", "cmbBASE_CD");  
                    
                //���� �϶�
                else if(cd_gbn=="UMAJOR")  
                    fnc_ConstructCommonCode("dsT_CM_COMMON_E6", "cmbBASE_CD");  
              
                //�ڰ��� �϶�
                else if(cd_gbn=="LICENCE")
                    fnc_ConstructCommonCode("dsT_CM_COMMON_H1", "cmbBASE_CD");  

                //���� �϶�                
                else if(cd_gbn=="MILYN")
                    fnc_ConstructCommonCode("dsT_CM_COMMON_F1", "cmbBASE_CD");  

                //���ƴ�� �϶�                
                else if(cd_gbn=="AWDYN")
                    fnc_ConstructCommonCode("dsT_CM_COMMON_Z5", "cmbBASE_CD");  
            }
            
            else{
                document.getElementById('cmbBASE_CD').length = 0;
            }




            //===================================
            //2.�����׸� �ش��ϴ� �����׸��� ���ε� �սô�.
            //===================================
            
            //'TAVE:����'�� 'TOEIC:����'���� ȯ������ �Է��� �����ϴ�.
            if(cd_gbn=="TAVE" || cd_gbn=="TOEIC"){
                wrkGbnNames = new Array( ""
                                       , "�� ��"
                                       , "ȯ����"
                                       , "������" );
                wrkGbnVals  = new Array( ""
                                       , "1"
                                       , "2"
                                       , "3" );
            } else {
                wrkGbnNames = new Array( ""
                                       , "�� ��"
                                       , "������" );
                wrkGbnVals  = new Array( ""
                                       , "1"
                                       , "3" );
            }
            
            //�����׸� ���ε�
            oSelect.options.length = 0;
            
            for(var i=0; i<wrkGbnNames.length; i++) {
                oOption       = document.createElement("OPTION");
            
                oOption.value = wrkGbnVals[i];
                oOption.text  = wrkGbnNames[i];
                
                oSelect.add(oOption);
            }
            
            
            //������ ���� ���ε��սô�.
            document.getElementById("cmbBASE_CD").value     = dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CD");
            document.getElementById("cmbWORK_GBN").value    = dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "WORK_GBN");
        }
        
        /*
         * �����׸��� ���� �Ǿ����� ó���� �̺�Ʈ
         */
        function fnc_ChangeWrkGbn() {
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "WORK_GBN") = document.getElementById("cmbWORK_GBN").value;

            //�ش�Ǵ� ���  �ڵ� �ʱ�ȭ
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "FULL_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "THAN_TAG") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "ADD_CNT" ) = "";

            fnc_ChangeStateElement(false, "txtBASE_CNT");   //������ �����ϰ�
            fnc_ChangeStateElement(false, "txtFULL_CNT");   //ȯ�길�� �����ϰ�
            fnc_ChangeStateElement(false, "cmbTHAN_TAG");   //���� ��� ���ϰ�
            fnc_ChangeStateElement(false, "txtADD_CNT" );   //������ ��� ���ϰ�
            

            //'UGRDYN','�з�'
            //'UYMD','�����⵵'
            //'TAVE','����'
            //'TOEIC','����'
            //'UMAJOR','����'
            //'AWDYN','���ƴ��'
            //'LICENCE','�ڰ���'
            //'MILYN','����'
            var cd_gbn      = document.getElementById("cmbCD_GBN"  ).value;
            var wrk_gbn     = document.getElementById("cmbWORK_GBN").value;

            //�����⵵, ����, ����
            if(cd_gbn == "UYMD" || cd_gbn == "TAVE" || cd_gbn == "TOEIC") {
                fnc_ChangeStateElement(true, "txtBASE_CNT");   //������
                
                
                //ȯ������
                if(wrk_gbn == "2" && (cd_gbn == "TAVE" || cd_gbn == "TOEIC")) {
                    fnc_ChangeStateElement(true, "txtFULL_CNT");   //ȯ�길��
                } else {
                    fnc_ChangeStateElement(true, "cmbTHAN_TAG");   //����
                }
            } 
            
            if(wrk_gbn == "3") {
                fnc_ChangeStateElement(true, "txtADD_CNT" );   //������
            }
        }
        
        /**
         * �����ڵ尡 ���� �Ǿ����� ó���� �̺�Ʈ
         */
        function fnc_ChangeBaseCd() {
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CD") = document.getElementById("cmbBASE_CD").value;
        }

        /*****************************************
         * 18. �����ڵ� ���濡 ���ظ� ���� ó��  *
         ****************************************/
		function fnc_changeBaseCD(index) {
            //���� ���õ� ����Ʈ �ڽ��� INDEX�� ���ظ��� ǥ���Ѵ�
            dsT_RC_JUDGESTD.NameValue(dsT_RC_JUDGESTD.RowPosition, 'BASE_NM') = document.getElementById("cmbBASE_CD")[index].text;

		}

      
        //�׸� ����Ʈ
        var elementList = new Array(     "cmbCD_GBN"
                                        ,"txtSTR_YMD"
                                        ,"txtEND_YMD"
                                        ,"imgSTR_YMD"
                                        ,"imgEND_YMD"
                                        ,"cmbWORK_GBN"
                                        ,"txtBASE_CNT"
                                        ,"cmbBASE_CD"
                                        ,"txtFULL_CNT"
                                        ,"cmbTHAN_TAG"
                                        ,"txtADD_CNT" );
                                        
        var elementList2 = new Array(    "cmbCD_GBN"
                                        ,"txtSTR_YMD"
                                        ,"txtEND_YMD"
                                        ,"imgSTR_YMD"
                                        ,"imgEND_YMD"
                                        ,"cmbWORK_GBN" );
        
        var exceptionList = new Array(   "cmbCD_GBN"
                                        ,"txtSTR_YMD"
                                        ,"imgSTR_YMD"
                                        ,"cmbWORK_GBN" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_JUDGESTD) |
    | 3. ���Ǵ� Table List(T_RC_JUDGESTD)		     |
    +------------------------------------------------>
    <Object ID="dsT_RC_JUDGESTD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsCOMM_CODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_RC_JUDGESTD)	|
    | 3. ���Ǵ� Table List(T_RC_JUDGESTD)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_JUDGESTD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �з� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E7"/>
       <jsp:param name="CODE_GUBUN"    value="E7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E6"/>
       <jsp:param name="CODE_GUBUN"    value="E6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �ڰ��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H1"/>
       <jsp:param name="CODE_GUBUN"    value="H1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_F1"/>
       <jsp:param name="CODE_GUBUN"    value="F1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���ƴ�� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Z5"/>
       <jsp:param name="CODE_GUBUN"    value="Z5"/>
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
    <Script For=dsT_RC_JUDGESTD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_RC_JUDGESTD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_JUDGESTD Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�����׸�, ������, �����׸�, ����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[�����׸�, ������, �����׸�, ����]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_RC_JUDGESTD event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_RC_JUDGESTD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_RC_JUDGESTD event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            //�׸�� ���� ��Ŵ
            fnc_BindCode();

            //�ű��� ���        
            if(dsT_RC_JUDGESTD.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList2);
            } else {
                fnc_EnableElementAll(elementList2, exceptionList);
            }
        }
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

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ɻ���ذ���</td>
					<td align="right" class="navigator">HOME/��Ÿ/ä�����/<font color="#000000">�����ɻ���ذ���</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="70"></col>
                                    <col width="100"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="90"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="center" class="searchState">������</td>
                                <td class="padding2423">
                                    <input id="txtYMD_SHR" size="10" maxLength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfDateHyphen(this); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtYMD_SHR','','25','170');"></a>
                                </td>
                                <td align="center" class="searchState">�����׸�</td>
                                <td class="padding2423">
                                    <select id="cmbCD_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
                                        <option value="">�� ü</option>
                                        <option value="UGRDYN">�� ��</option>
                                        <option value="UYMD">�����⵵</option>
                                        <option value="TAVE">�� ��</option>
                                        <option value="TOEIC">�� ��</option>
                                        <option value="UMAJOR">�� ��</option>
                                        <option value="AWDYN">���ƴ��</option>
                                        <option value="LICENCE">�ڰ���</option>
                                        <option value="MILYN">����</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�����׸�&nbsp;</td>
								<td class="padding2423">
									<select id="cmbWORK_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
                                        <option value="">�� ü</option>
										<option value="1">�� ��</option>
							            <option value="2">ȯ����</option>
                                        <option value="3">������</option>
									</select>
								</td>
								<td align="right" class="searchState">������&nbsp;</td>
								<td class="padding2423">
									<select id="cmbGUBUN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option value="">�� ü</option>
										<option value="Y">�����</option>
									</select>
								</td>
								<td>&nbsp;</td>
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
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="120"></col>
					<col width="70"></col>
					<col width="100"></col>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�����׸�</td>
					<td class="padding2423">
                        <select id="cmbCD_GBN" style="WIDTH: 100%" onChange="fnc_ChangeCdGbn()">
                            <option value="UGRDYN">�� ��</option>
                            <option value="UYMD">�����⵵</option>
                            <option value="TAVE">�� ��</option>
                            <option value="TOEIC">�� ��</option>
                            <option value="UMAJOR">�� ��</option>
                            <option value="AWDYN">���ƴ��</option>
                            <option value="LICENCE">�ڰ���</option>
                            <option value="MILYN">����</option>
						</select>
                    </td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtSTR_YMD.disabled == true){ return; } calendarBtn('datetype1','txtSTR_YMD','','180','100');"></a>
					</td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423">
						<input id="txtEND_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','340','100');"></a>
					</td>
                    <td align="center" class="creamBold">�����׸�</td>
					<td class="padding2423" colspan="3">
                        <select id="cmbWORK_GBN" style="WIDTH: 100%" onChange="fnc_ChangeWrkGbn()">
						</select>
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423"><input id="txtBASE_CNT" size="10" maxLength="5" onkeypress="cfCheckNumber3();" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <select id="cmbBASE_CD" style="WIDTH: 100%" onchange="fnc_ChangeBaseCd()">
                        </select>
                    </td>
                    <td align="center" class="creamBold">ȯ�길��</td>
					<td class="padding2423"><input id="txtFULL_CNT" size="10" maxLength="3" onkeypress="cfCheckNumber3();" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <select id="cmbTHAN_TAG" style="WIDTH: 100%">
							<option value=""></option>
							<option value="1">�� ��</option>
							<option value="2">�� ��</option>
                            <option value="3">�� ��</option>
                            <option value="4">�� ��</option>
						</select>
                    </td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423"><input id="txtADD_CNT" size="4" maxLength="3" onkeypress="cfCheckNumber();" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly></td>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_RC_JUDGESTD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_RC_JUDGESTD">
							<param name="Format"					value="
								<C> id={currow}		width=39    name='NO'			align=center </C>
								<C> id='CD_GBN'		width=70	name='�����׸�'		align=left Value={Decode(CD_GBN,'UGRDYN','�з�','UYMD','�����⵵','TAVE','����','TOEIC','����','UMAJOR','����','AWDYN','���ƴ��','LICENCE','�ڰ���','MILYN','����')}</C>
								<C> id='STR_YMD'	width=70	name='������'		align=center </C>
								<C> id='END_YMD'	width=70	name='������'		align=center </C>
                                <C> id='WORK_GBN'	width=70	name='�����׸�'		align=center Value={DECODE(WORK_GBN,1,'�� ��',2,'ȯ����',3,'������')}</C>
								<C> id='BASE_CNT'	width=70	name='������'		align=center </C>
                                <C> id='BASE_CD'    width=180	name='�����ڵ��'		align=center EditStyle=Lookup Data='dsCOMM_CODE:CODE:CODE_NAME'</C>
                                <C> id='FULL_CNT'	width=65	name='ȯ�길��'		align=right </C>
                                <C> id='THAN_TAG'	width=65	name='����'		    align=center Value={DECODE(THAN_TAG,1,'�� ��',2,'�� ��',3,'�� ��',4,'�� ��')}</C>
								<C> id='ADD_CNT'	width=65	name='������'		align=right </C>
							">
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �����ɻ���ذ��� ���̺� -->
<object id="bndT_RC_JUDGESTD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_RC_JUDGESTD">
	<Param Name="BindInfo", Value='
		<C>Col=CD_GBN		Ctrl=cmbCD_GBN	      	Param=value		</C>
		<C>Col=STR_YMD		Ctrl=txtSTR_YMD      	Param=value		</C>
		<C>Col=END_YMD		Ctrl=txtEND_YMD	      	Param=value		</C>
		<C>Col=BASE_CNT		Ctrl=txtBASE_CNT     	Param=value		</C>
        <C>Col=FULL_CNT		Ctrl=txtFULL_CNT     	Param=value		</C>
        <C>Col=THAN_TAG		Ctrl=cmbTHAN_TAG     	Param=value		</C>
		<C>Col=ADD_CNT		Ctrl=txtADD_CNT	     	Param=value		</C>
    '>
</object>