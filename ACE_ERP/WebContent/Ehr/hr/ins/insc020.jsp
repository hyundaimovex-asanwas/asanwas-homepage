<!--
*****************************************************
* @source      : insc020.jsp
* @description : �����Ļ�/���纸��/������ع߻�����
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/13      ����ȣ                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>������ع߻�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">

    <!--*****************************
    *  CSS ����  *
    *****************************-->
    <style type="text/css">
    .header {
        padding: 1px;
        background-color: #f7dcbb;
        text-align: center;
    }
    .content {
        padding: 1px;
        padding-right : 6px;
        background-color: #ffffff;
        text-align: right;
    }
    .content2 {
        padding: 1px;
        background-color: #ffffff;
        text-align: center;
    }
    </style>


<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<script language="javascript" src="/common/dateformat.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "T"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "T"   //����
                    + "T";  //�ݱ�
        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.c.insc020.cmd.INSC020CMD";
        var params = null;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻�����
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");
            var oFROM_YMD   = document.getElementById("txtFROM_YMD_SHR");
            var oTO_YMD     = document.getElementById("txtTO_YMD_SHR");

            if(oFROM_YMD.value == "" ){
                alert("������� �Է��Ͻʽÿ�.");
                oFROM_YMD.focus();
                return;
            }
            
            if(oTO_YMD.value == "" ){
                alert("������� �Է��Ͻʽÿ�.");
                oTO_YMD.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&FROM_YMD="+oFROM_YMD.value
                   + "&TO_YMD="+oTO_YMD.value;

            dsT_IS_ACCIDENT.dataid = dataClassName+params;
            dsT_IS_ACCIDENT.reset();
        }
        
        /**
         * ����ӱ� ���������� ��ȸ�Ѵ�.
         */
        function fnc_SearchPay() {
            //�˻�����
            var oENO_NO         = document.getElementById("txtENO_NO");

            if(oENO_NO.value == "") {
                return;
            }

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&YMD="+getToday();

            //�ʱ�ȭ ��Ű��
            dsT_CP_PAYMASTER.ClearData();
            dsT_CP_CHANGE_FIELD.ClearData();
            dsT_CP_CHANGE1.ClearData();
            dsT_CP_CHANGE2.ClearData();
            dsT_CP_CHANGE3.ClearData();
            dsT_CP_CHANGE4.ClearData();
            dsT_CP_PAYMASTER_BONUS.ClearData();
            dsT_CP_YEARLYBONUS.ClearData();

            //���Ϲ��� DataSet ����
            trT_CP_PAYMASTER.KeyValue = "tr02"
                                   + "(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"         //��������
                                   + ",O:dsT_CP_CHANGE_FIELD=dsT_CP_CHANGE_FIELD"   //��Ÿ���� �׸�
                                   + ",O:dsT_CP_CHANGE1=dsT_CP_CHANGE1"             //��Ÿ����1
                                   + ",O:dsT_CP_CHANGE2=dsT_CP_CHANGE2"             //��Ÿ����2
                                   + ",O:dsT_CP_CHANGE3=dsT_CP_CHANGE3"             //��Ÿ����3
                                   + ",O:dsT_CP_CHANGE4=dsT_CP_CHANGE4"             //��Ÿ����4
                                   + ",O:dsT_CP_PAYMASTER_BONUS=dsT_CP_PAYMASTER_BONUS"//�󿩱�
                                   + ",O:dsT_CP_YEARLYBONUS=dsT_CP_YEARLYBONUS"     //����������
                                   + ")";
            trT_CP_PAYMASTER.action = "/servlet/GauceChannelSVL?cmd=hr.ins.c.insc010.cmd.INSC010CMD"+params;
            trT_CP_PAYMASTER.post();
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
            //�� ��ȿ�� ����
            if(!fnc_SaveItemCheck()) return;

            trT_IS_ACCIDENT.KeyValue = "tr01(I:dsT_IS_ACCIDENT=dsT_IS_ACCIDENT)";
            trT_IS_ACCIDENT.action = dataClassName+"&S_MODE=SAV";
            trT_IS_ACCIDENT.post();
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_IS_ACCIDENT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("������ȣ [" + dsT_IS_ACCIDENT.ColumnString(dsT_IS_ACCIDENT.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_IS_ACCIDENT.DeleteRow(dsT_IS_ACCIDENT.RowPosition);

            trT_IS_ACCIDENT.KeyValue = "SVL(I:dsT_IS_ACCIDENT=dsT_IS_ACCIDENT)";
            trT_IS_ACCIDENT.Action = dataClassName+"&S_MODE=DEL";
            trT_IS_ACCIDENT.post();
        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�˻�����
            var YMD = document.getElementById("txtFROM_YMD_SHR");

            if(YMD.value == "" ){
                alert("������� �Է��Ͻʽÿ�.");
                YMD.focus();
                return;
            }
			var url = "insc020_PV.jsp?STR_YMD="+YMD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {
            if (dsT_IS_ACCIDENT.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_IS_ACCIDENT.GridToExcel("���ο��ݰ���", '', 225);
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_IS_ACCIDENT.CountColumn == 0) {
                dsT_IS_ACCIDENT.setDataHeader("REQ_NO:STRING,  ENO_NO:STRING,  ENO_NM:STRING,  DPT_CD:STRING,  DPT_NM:STRING,  JOB_CD:STRING,  JOB_NM:STRING,  CET_NO:STRING,  HIRG_YMD:STRING,  SAN_YMD:STRING,  SAN_NAM:STRING,  SAN_REM:STRING,  HDC_GRA:STRING,  HDC_CD:STRING,  HDC_NM:STRING,  MED_AMT:INT,  HDC_AMT:INT,  SUR_AMT:INT,  STR_YMD:STRING,  END_YMD:STRING,  TMR_DD:STRING,  SAL_AMT:INT,  AVG_AMT:INT,  DAY_AMT:INT,  REC_AMT:INT,  REMARK:STRING");
            }            

            dsT_IS_ACCIDENT.AddRow();
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
            dsT_IS_ACCIDENT.ClearData();
            fnc_ClearInputElement(elementList);

            document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
            if (dsT_IS_ACCIDENT.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_IS_ACCIDENT.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_IS_ACCIDENT,15,"false","false")      // Grid Style ����

            var oSelect = null;
            var oOption = null;

            // ���� ���� �޺��ڽ� ����
            fnc_BindingCommonCode(document.getElementById("dsT_CM_COMMON_C6"), "cmbHDC_CD");
            
            // ���� ��� �޺��ڽ� ����
            oSelect = document.getElementById("cmbHDC_GRA");
            oSelect.options.length = 0;
            for( i= 0; i<=10; i++) {
                oOption       = document.createElement("OPTION");
                if(i == 0) {
                    oOption.value = "";
                    oOption.text  = "�����ϼ���";
                } else {
                    oOption.value = i;
                    oOption.text  = i;
                }
                oSelect.add(oOption);
            }

            //ó������ ������� ���ϰ� disable ��Ų��.
            fnc_DisableElementAll(elementList);
            fnc_DisableElementAll(btnElementList);
            
            //���� �ʱ�ȭ
            document.getElementById("txtFROM_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtTO_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /********************
         *     ��Ÿ �Լ�            *
         *******************/

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO');

            fnc_GetUserInfo();
        }

        /**
         * ���������� �����ɽô�.
         */
        function fnc_GetUserInfo() {
            var obj = fnc_GetEnoNm("txtENO_NO");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtHIRG_YMD").value = obj.hirg_ymd;
            document.getElementById("txtCET_NO").value = obj.cet_no;
        }
        
        var oElement = null;
        var oElementMsg = null;
        //���� ���ǵǾ� �ִ� �׸��
        var elementList = new Array(    "txtREQ_NO"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"txtSAN_YMD"
                                        ,"txtSAN_NAM"
                                        ,"txtSAN_REM"
                                        ,"cmbHDC_GRA"
                                        ,"cmbHDC_CD"
                                        ,"medMED_AMT"
                                        ,"medHDC_AMT"
                                        ,"medSUR_AMT"
                                        ,"txtSTR_YMD"
                                        ,"txtEND_YMD"
                                        ,"txtTMR_DD"
                                        ,"medSAL_AMT"
                                        ,"medREC_AMT"
                                        ,"txtREMARK"
                                        );

        //�׸���� �޼���
        var elementListMsg = new Array(  "������ȣ"
                                        ,"���"
                                        ,"����"
                                        ,"�߻�����"
                                        ,"�󺴸�"
                                        ,"����"
                                        ,"���ص��"
                                        ,"��������"
                                        ,"���޿�"
                                        ,"���ر޿�"
                                        ,"�����޿�"
                                        ,"û���Ⱓ����"
                                        ,"û���Ⱓ��"
                                        ,"�����ϼ�"
                                        ,"������ޱ޿�"
                                        ,"���ɾ�"
                                        ,"���"
                                        );

        //���� ����
        var exceptionList = new Array(   "txtREQ_NO"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"txtSAN_YMD"
                                        );
                                        
        var btnElementList = new Array(  "ImgEnoNo"
                                        ,"ImgSAN_YMD"
                                        ,"ImgSTR_YMD"
                                        ,"ImgEND_YMD"
                                        );
                                
        var btnExceptionList = new Array( "ImgEnoNo"
                                         ,"ImgSAN_YMD"
                                         );

        //�˻�â�� �˻� ���� �׸��
        var oSearchElementList = new Array(
                                         "txtFROM_YMD_SHR"
                                        ,"txtTO_YMD_SHR"
                                        ,"txtENO_NO_SHR"
                                        ,"txtENO_NM_SHR");

        
        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");
            
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
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        } 
         
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            
            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO");
            if(document.getElementById("txtENO_NO").value != "") {
            
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;
                document.getElementById("txtHIRG_YMD").value    = obj.hirg_ymd;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
                document.getElementById("txtHIRG_YMD").value    = "";
            }     
            
            //����� ����ɶ� ���� �� ����ӱ� ���� ��ȸ
            fnc_SearchPay();
        }   
        
        /**
         * ���ӱݾ��� �������� ����ӱ�, �޾��޿�û�� ������ ������ �´�.
         */
        function fnc_BindingAmt() {
            var sal_amt = fnc_covNumber(document.getElementById("medSAL_AMT").Text);
            var oAvg_amt = document.getElementById("medAVG_AMT");
            var oDay_amt = document.getElementById("medDAY_AMT");
            var tmr_dd  = fnc_covNumber(document.getElementById("txtTMR_DD").value);

            oAvg_amt.Text = sal_amt/tmr_dd;
            oDay_amt.Text = fnc_covNumber(oAvg_amt.Text) * 0.7;
        }       
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_IS_ACCIDENT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_IS_ACCIDENT                       |
    | 3. Table List : T_IS_ACCIDENT                 |
    +----------------------------------------------->
    <Object ID="dsT_IS_ACCIDENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���ӱݾ��� ������ ���� ���� ���ǵ� DS,TR insc010 ���� Ȱ�� -->
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>
        
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE_FIELD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_PAYMASTER_BONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!-- ���ӱݾ��� ������ ���� ���� ���ǵ� DS,TR insc010 ���� Ȱ�� -->

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet - ��������                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_C6"/>
       <jsp:param name="CODE_GUBUN"    value="C6"/>
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
    <Script For=dsT_IS_ACCIDENT Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_IS_ACCIDENT Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_IS_ACCIDENT Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_IS_ACCIDENT event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!-- �� ����ӱ��� ������ �´�. -->
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        var sal_amt = 0;
        sal_amt += dsT_CP_PAYMASTER.NameSum("BAS_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("DUTY_AMT" ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("OT_AMT"   ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("WEL_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("OSE_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("RUN_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("MH_AMT"   ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("LSEV_AMT" ,0, 0);    
        
        sal_amt += dsT_CP_CHANGE1.NameSum("AMOUNT"  ,0 ,0);
        sal_amt += dsT_CP_CHANGE2.NameSum("AMOUNT"  ,0 ,0);
        sal_amt += dsT_CP_CHANGE3.NameSum("AMOUNT"  ,0 ,0);
        sal_amt += dsT_CP_CHANGE4.NameSum("AMOUNT"  ,0 ,0);
        
        document.getElementById("medSAL_AMT").Text = sal_amt;
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_IS_ACCIDENT event="OnFail()">
        cfErrorMsg(this);
    </script>
    

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��                |
    +------------------------------------------------------>           
    <script language=JavaScript for=dsT_IS_ACCIDENT event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(dsT_IS_ACCIDENT.RowStatus(row) == "1") {
            fnc_EnableElementAll(elementList);
            fnc_EnableElementAll(btnElementList);
        } else {
            fnc_EnableElementAll(elementList, exceptionList);
            fnc_EnableElementAll(btnElementList, btnExceptionList);
        }
    </script>    
    
     <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |
    +--------------------------->
    <script for=dsT_IS_ACCIDENT event=CanRowPosChange(row)>
        var oElementName;
        var oElementMsg;
        var oElementValue;
        var saveStatus;
        
        //ds �Է� Ÿ���� insert ���� update������ ������
        //1:Insert
        //3:Update
        saveStatus = dsT_IS_ACCIDENT.RowStatus(row);                   
    

        for(var i=0; i<elementList.length; i++) {
        
            oElementName    = elementList[i].substring(3);
            oElementMsg     = elementListMsg[i];
            oElementValue   = dsT_IS_ACCIDENT.NameString(row, oElementName);
            
            //�Է»��°� insert�� ��� '������ޱ޿�(txtSAL_AMT)'�� ����
            if(saveStatus == 1 && (oElementName == "SAL_AMT" || oElementName == "REC_AMT")) continue;      
            
            //���ص�ް� ���������� ���� �Է�
            if(oElementName == "HDC_GRA" || oElementName == "HDC_CD") continue;            
            
            if(oElementValue == "") {
                alert("[ " + oElementMsg + " ]�� ���� ��� �ֽ��ϴ�.");
                document.getElementById(elementList[i]).focus();
                return false;
            }
        }
        
    </script>    
    
    
    <script language=JavaScript for=medSAL_AMT event=onKillFocus()>
        fnc_BindingAmt();
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ع߻�����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���纸��/<font color="#000000">������ع߻�����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                <col width="110"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�߻����</td>
                                <td class="padding2423" colspan="5">
                                    <input type="text" id="txtFROM_YMD_SHR" name="txtFROM_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtFROM_YMD_SHR','','125','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                    ~
                                    <input type="text" id="txtTO_YMD_SHR" name="txtTO_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtTO_YMD_SHR','','125','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">�� ��&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
        <td class="paddingTop8">

<!-- ������ -->
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>

                <tr>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    
                    
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" maxlength="12" style= "width:70%"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        
                        <input type="hidden" name="txtJOB_NM" id="txtJOB_NM">
                        <input type="hidden" name="txtCET_NO" id="txtCET_NO">
                        <input type="hidden" name="txtHIRG_YMD" id="txtHIRG_YMD">                        
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" maxlength="12" style= "width:70%"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>  

                    <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input type="text" id="txtDPT_NM" name="txtDPT_NM" size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center" rowspan="2">���ع߻�</td>
                    <td class="creamBold" align="center">�߻��Ͻ�</td>
                    <td class="padding2423">
                        <input type="text" id="txtSAN_YMD" name="txtSAN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="ImgSAN_YMD" id="ImgSAN_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSAN_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSAN_YMD','','160','205');" style="cursor:hand;">
                    </td>
                    <td class="creamBold" align="center">�󺴸�</td>
                    <td class="padding2423">
                        <input type="text" id="txtSAN_NAM" name="txtSAN_NAM" size="20" maxlength="30">
                    </td>
                    <td class="creamBold" align="center">������ȣ</td>
                    <td class="padding2423">
                        <input type="text" id="txtREQ_NO" name="txtREQ_NO" size="10" maxlength="11" style="ime-mode:disabled">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <input type="text" id="txtSAN_REM" name="txtSAN_REM" size="60" maxlength="30">
                    </td>
                    <td class="creamBold" align="center">�����ϼ�</td>
                    <td class="padding2423">
                        <input type="text" id="txtTMR_DD" name="txtTMR_DD" size="10" maxlength="9" value="0" style="text-align:right" style="ime-mode:disabled"  onkeypress="cfCheckNumber();" onchange="fnc_BindingAmt()">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;��</td>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <select name="cmbHDC_GRA" id="cmbHDC_GRA"></select>
                    </td>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <select name="cmbHDC_CD" id="cmbHDC_CD">
                            <option value="">�����ϼ���</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">����޿�</td>
                    <td class="creamBold" align="center">���޿�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medMED_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>      
                    </td>
                    <td class="creamBold" align="center">���ر޿�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHDC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                    </td>
                    <td class="creamBold" align="center">�����޿�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSUR_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                       
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center" rowspan="2">�޾��޿�</td>
                    <td class="creamBold" align="center">û���Ⱓ</td>
                    <td class="padding2423" colspan="5">
                        <input type="text" id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="ImgSTR_YMD" id="ImgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','160','305');" style="cursor:hand;">
                        &nbsp;~&nbsp;
                        <input type="text" id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="ImgEND_YMD" id="ImgEND_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEND_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','285','305');" style="cursor:hand;">
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">���</td>
                    <td class="padding2423" colspan="5">
                        <input type="text" id="txtREMARK" name="txtREMARK" size="60" maxlength="30">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center" rowspan="2">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="creamBold" align="center">���ӱݾ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                                           
                    </td>
                    <td class="creamBold" align="center">����ӱ�</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medAVG_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px" class="input_ReadOnly" readonly>
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>    
                    </td>
                    <td class="creamBold" align="center">�޾��޿�û��</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medDAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px" class="input_ReadOnly" readonly>
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                       
                    </td>
                <tr>
                    <td class="creamBold" align="center">���ɾ�</td>
                    <td class="padding2423" colspan="5">
                        <comment id="__NSID__"><object id="medREC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_IS_ACCIDENT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
							<param name="DataID"				value="dsT_IS_ACCIDENT">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</C>
                                <C> id=REQ_NO       width=80        align=center        name=������ȣ               </C>
                                <C> id=ENO_NO       width=80        align=center        name=����                   </C>
                                <C> id=ENO_NM       width=80        align=center        name=����                   </C>
                                <C> id=DPT_NM       width=80        align=center        name=�Ҽ�                   </C>
                                <C> id=JOB_NM       width=80        align=center        name=����                   </C>
                                <C> id=CET_NO       width=80        align=center        name=�ֹε�Ϲ�ȣ          </C>
                                <C> id=HIRG_YMD     width=80        align=center        name=�Ի���                   </C>
                                <C> id=SAN_YMD      width=80        align=center        name=���ع߻��Ͻ�           </C>
                                <C> id=SAN_NAM      width=80        align=center        name=�󺴸�                 </C>
                                <C> id=SAN_REM      width=80        align=center        name=����                   </C>
                                <C> id=HDC_GRA      width=80        align=center        name=���ص��               </C>
                                <C> id=HDC_CD       width=80        align=center        name=���������ڵ�          value={Decode(HDC_CD,'1','��ü�����','2','�ð������','3','û�������','4','��������','5','������ü��')} </C>
                                <C> id=MED_AMT      width=80        align=center        name=���޿�               </C>
                                <C> id=HDC_AMT      width=80        align=center        name=���ر޿�               </C>
                                <C> id=SUR_AMT      width=80        align=center        name=�����޿�               </C>
                                <C> id=STR_YMD      width=80        align=center        name=û���Ⱓ  ����           </C>
                                <C> id=END_YMD      width=80        align=center        name=û���Ⱓ  ��                       </C>
                                <C> id=TMR_DD       width=80        align=center        name=�����ϼ�               </C>
                                <C> id=SAL_AMT      width=80        align=center        name=������ޱ޿�           </C>
                                <C> id=AVG_AMT      width=80        align=center        name=����ӱ�/��            </C>
                                <C> id=DAY_AMT      width=80        align=center        name=�޾��޿�û��           </C>
                                <C> id=REC_AMT      width=80        align=center        name=���ɾ�                 </C>
                                <C> id=REMARK       width=80        align=center        name=���                   </C>

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

    <!--**************************************************************************************
    *                                                                                        *
    *   ���ε� ������Ʈ                                                                             *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_IS_ACCIDENT ���� ���̺� -->
    <object id="bndT_IS_ACCIDENT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_IS_ACCIDENT">
        <Param Name="BindInfo", Value="
            <C>Col=ENO_NO           Ctrl=txtENO_NO          Param=value</C>
            <C>Col=ENO_NM           Ctrl=txtENO_NM          Param=value</C>
            <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value</C>
            <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value</C>
            <C>Col=CET_NO           Ctrl=txtCET_NO          Param=value</C>
            <C>Col=HIRG_YMD         Ctrl=txtHIRG_YMD        Param=value</C>
            <C>Col=SAN_YMD          Ctrl=txtSAN_YMD         Param=value</C>
            <C>Col=SAN_NAM          Ctrl=txtSAN_NAM         Param=value</C>
            <C>Col=REQ_NO           Ctrl=txtREQ_NO          Param=value</C>
            <C>Col=SAN_REM          Ctrl=txtSAN_REM         Param=value</C>
            <C>Col=TMR_DD           Ctrl=txtTMR_DD          Param=value</C>
            <C>Col=HDC_GRA          Ctrl=cmbHDC_GRA         Param=value</C>
            <C>Col=HDC_CD           Ctrl=cmbHDC_CD          Param=value</C>
            <C>Col=MED_AMT          Ctrl=medMED_AMT         Param=text </C>
            <C>Col=HDC_AMT          Ctrl=medHDC_AMT         Param=text </C>
            <C>Col=SUR_AMT          Ctrl=medSUR_AMT         Param=text </C>
            <C>Col=STR_YMD          Ctrl=txtSTR_YMD         Param=value</C>
            <C>Col=END_YMD          Ctrl=txtEND_YMD         Param=value</C>
            <C>Col=REMARK           Ctrl=txtREMARK          Param=value</C>
            <C>Col=SAL_AMT          Ctrl=medSAL_AMT         Param=text </C>
            <C>Col=REC_AMT          Ctrl=medREC_AMT         Param=text </C>
            <C>Col=AVG_AMT          Ctrl=medAVG_AMT         Param=text </C>
            <C>Col=DAY_AMT          Ctrl=medDAY_AMT         Param=text </C>
        ">
    </object>