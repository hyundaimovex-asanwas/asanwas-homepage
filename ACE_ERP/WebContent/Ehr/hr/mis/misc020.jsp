<!--
    ************************************************************************************
    * @Source         : misc020.jsp                                                    *
    * @Description    : �μ����ο������ȹ���� PAGE                                    *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/02 |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String PLN_AUTHO    = box.getString("SESSION_PLN_AUTHO");
    String ROLE_CD      = box.getString("SESSION_ROLE_CD");
    
    //���������� �ƴ��� ����
    boolean isMaster    = false;
    
    //������ ������ �����ڸ� �����
    // A ���μ�, S �ҼӺμ�
    // IT(1001)�� �����Ϳ� ������ ���� �λ�(1002)�� ������� ���� 
    if(PLN_AUTHO.equals("A")
            || ROLE_CD.equals("1001")) {
        isMaster = true;
    }
%>

<html>

    <head>
    <title>�μ����ο������ȹ����(misc020)</title>
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

        var btnList  = 'TFFTFTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var DPT_CD   = document.getElementById("txtDPT_CD_SHR").value;

            if (PIS_YY == "") {
                alert("����⵵�� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }
            
            //��ȹ�⵵�� �ʱ�ȭ �Ѵ�.
            fnc_BndHIR_YM();    


            dsT_MI_LEVYPLAN.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD"
                                   + "&S_MODE=SHR"
                                   + "&PIS_YY="+PIS_YY
                                   + "&DPT_CD="+DPT_CD
                                   + "&TYPE=MISC020";
            dsT_MI_LEVYPLAN.Reset();

            form1.grdT_MI_LEVYPLAN.Focus();

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

            if (ProSts != "1") {
                alert("�ο���ȹ �ۼ��Ⱓ�� �ƴϹǷ� �����۾��� �Ͻ� �� �����ϴ�.");
                return;
            }
            
            //DataSet�� ���� ���� Ȯ��
            if (!dsT_MI_LEVYPLAN.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }
            
            trT_MI_LEVYPLAN.KeyValue    = "tr01(I:SAV=dsT_MI_LEVYPLAN)";
            trT_MI_LEVYPLAN.action      = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD"
                                        + "&S_MODE=SAV";
            trT_MI_LEVYPLAN.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_MI_LEVYPLAN.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (ProSts != "1") {
                alert("�ο���ȹ �ۼ��Ⱓ�� �ƴϹǷ� �����۾��� �Ͻ� �� �����ϴ�.");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("��ȹ��� [" + dsT_MI_LEVYPLAN.NameValue(dsT_MI_LEVYPLAN.RowPosition,"HIR_YM") + "] ������� [" + dsT_MI_LEVYPLAN.NameValue(dsT_MI_LEVYPLAN.RowPosition,"LEVY_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_MI_LEVYPLAN.DeleteRow(dsT_MI_LEVYPLAN.RowPosition);

            trT_MI_LEVYPLAN.KeyValue    = "tr01(I:SAV=dsT_MI_LEVYPLAN)";
            trT_MI_LEVYPLAN.action      = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD"
                                        + "&S_MODE=SAV";
            trT_MI_LEVYPLAN.post();
            
        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
			var STR_YY = document.getElementById("cmbPIS_YY_SHR").value;
			var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
			var DPT_NM = document.getElementById("txtDPT_NM_SHR").value;

			var url = "misc025_PV.jsp?str_yy="+STR_YY+"&dpt_cd="+DPT_CD+"&dpt_nm="+DPT_NM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

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
            if (ProSts != "1") {
                alert("�ο���ȹ �ۼ��Ⱓ�� �ƴϹǷ� �ű��۾��� �Ͻ� �� �����ϴ�.");
                return;
            }

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_MI_LEVYPLAN.CountColumn == 0) {
                dsT_MI_LEVYPLAN.setDataHeader("PIS_YY:STRING, DPT_CD:STRING, DPT_NM:STRING, TSEQ_NO:STRING, JOB_CD:STRING, JOB_NM:STRING, JOB_GBN:STRING, HIR_YM:STRING, HEAD_CD:STRING, HEAD_NM:STRING, LEVY_CD:STRING, LEVY_NM:STRING, JIKMU_CD:STRING, JIKMU_NM:STRING, OCC_CD:STRING, OCC_NM:STRING, MF_TAG:STRING, MF_TNM:STRING, LEVY_TXT:STRING, REMARK:STRING, OENO_NO:STRING, OENO_NM:STRING, NDPT_CD:STRING, DUMMY:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_MI_LEVYPLAN.AddRow();
            
            dsT_MI_LEVYPLAN.NameString(dsT_MI_LEVYPLAN.RowPosition, "PIS_YY") = document.getElementById("cmbPIS_YY_SHR").value;
            dsT_MI_LEVYPLAN.NameString(dsT_MI_LEVYPLAN.RowPosition, "DPT_CD") = '<%=box.get("SESSION_DPTCD")%>';
            dsT_MI_LEVYPLAN.NameString(dsT_MI_LEVYPLAN.RowPosition, "DPT_NM") = '<%=box.get("SESSION_DPTNM")%>';
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

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_MI_LEVYPLAN.ClearData();

            document.getElementById("cmbPIS_YY_SHR").focus();

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


        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_MI_LEVYPLAN,0,"false","false");

            //�ٷα���
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD").add(oOption);

            }

            //�ι�(����)
            for( var i = 1; i <= dsCOMMON_B1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD").add(oOption);

            }

            //����
            cfCopyDataSet(fnc_GetJobCd(), dsCOMMON_JOB);
            dsCOMMON_JOB.AddRow();
            
            dsCOMMON_JOB.NameString(dsCOMMON_JOB.RowPosition, "COMM_CD") = "ZZ";
            dsCOMMON_JOB.NameString(dsCOMMON_JOB.RowPosition, "COMM_NM") = "�İ���";

            for( var i=1; i<=dsCOMMON_JOB.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_JOB.NameValue(i,"COMM_CD");
                oOption.text = dsCOMMON_JOB.NameValue(i,"COMM_CD")+': '+dsCOMMON_JOB.NameValue(i,"COMM_NM");
                document.getElementById("cmbJOB_CD").add(oOption);
            }


            //����
            cfCopyDataSet(fnc_GetDutyCd('DUTY2', '4'), dsCOMMON_DUTY);
            
            for( var i=1; i<=dsCOMMON_DUTY.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_DUTY.NameValue(i,"COMM_CD");
                oOption.text = dsCOMMON_DUTY.NameValue(i,"COMM_NM");
                document.getElementById("cmbJIKMU_CD").add(oOption);
            }


            //�������
            for( var i = 1; i <= dsCOMMON_G4.CountRow; i++ ) {

                // ��ȯ��ġ �� ������ ����
                if (dsCOMMON_G4.NameValue(i,"CODE") != '4' &&
                    dsCOMMON_G4.NameValue(i,"CODE") != '5') {
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_G4.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_G4.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbLEVY_CD").add(oOption);
                }

            }
            
            
            // ����⵵ �� ���Ⱓ ����
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();
            
<% 
    if(!isMaster) {
%>
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";
    
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "imgDPT_CD_SHR");
<%
    }
%>

            //��ȹ�⵵�� �ʱ�ȭ �Ѵ�.
            fnc_BndHIR_YM();    

            document.getElementById("cmbPIS_YY_SHR").focus();
        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        
        /**
         * ��� ������ ���� ó�� ����� ������
         */
        function fnc_ChgLEVY_CD() {
            // ��������� �������ȯ�� �ƴϸ� 
            if (document.getElementById("cmbLEVY_CD").value == '1') {

                fnc_ChangeStateElement(true, "txtOENO_NO");
                fnc_ChangeStateElement(true, "txtOENO_NM");
                fnc_ChangeStateElement(true, "ImgEnoNo");
                
            } else {
                document.getElementById("txtOENO_NO").value = "";
                document.getElementById("txtOENO_NM").value = "";

                fnc_ChangeStateElement(false, "txtOENO_NO");
                fnc_ChangeStateElement(false, "txtOENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
            }
            
        }
        
        /**
         * ��ȹ����� �ʱ�ȭ �Ѵ�.
         */
        function fnc_BndHIR_YM() {
            if(dsT_CP_WORKLOG.CountRow == 0) {
                document.getElementById("resultMessage").innerText = "��ȸ�� �����ȹ�� �����ϴ�.";
                return;
            }
        
            //��ȸ�� �⵵
            var LogRow  = dsT_CP_WORKLOG.NameValueRow("PIS_YY", document.getElementById("cmbPIS_YY_SHR").value);
            
            var PAY_YM  = dsT_CP_WORKLOG.NameValue(LogRow, "PAY_YMD").split("-");
            var APY_YM  = dsT_CP_WORKLOG.NameValue(LogRow, "APY_YMD").split("-");
            
            //�۾���ȣ�� �̸� ������ ����
            ProSts      = dsT_CP_WORKLOG.NameValue(LogRow, "PRO_STS");
            
            // ��ȹ���
            var oSelect = document.getElementById("cmbHIR_YM");
            var oOption;
            
            
            //��������
            var str_year  = parseInt(PAY_YM[0]);
            var str_mon   = parseInt(PAY_YM[1]);
            
            //���������
            var end_year  = parseInt(APY_YM[0]);
            var end_mon   = parseInt(APY_YM[1]);
            
            
            //�ʱ�ȭ
            oSelect.length = 1;
            
            while(true) {
                //�������� �������� �Ѿ�� ����
                if(str_year > end_year 
                        || (str_year == end_year && str_mon > end_mon))
                    break;
                    
            
                oOption         = document.createElement("OPTION");
                oOption.value   = str_year+"-"+lpad(str_mon, 2, '0');
                oOption.text    = str_year+"-"+lpad(str_mon, 2, '0');
                oSelect.add(oOption);
                
                
                //��¥�� ����
                if(str_mon == 12) {
                    str_year++;
                    str_mon = 1;
                } else {
                    str_mon++;
                }
            }
        }
                

        
        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtOENO_NO", "txtOENO_NM", "txtDPT_CD_SHR", "2");
            
            if (document.getElementById("txtOENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }   
        
        /**
         * ��� ������ ��ȸ �Ѵ�. 
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtOENO_NO", "txtOENO_NM", "txtDPT_CD_SHR", "2");
            fnc_SearchEmpNo();
        } 
         
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            
            // �İ߻�� ��ü
            obj = fnc_GetCommonEnoNm("txtOENO_NO", "txtOENO_NM", "txtDPT_CD_SHR", "2");
            if(obj != null && obj.eno_no != "") {            
                document.getElementById("txtOENO_NO").value     = obj.eno_no;
                document.getElementById("txtOENO_NM").value     = obj.eno_nm;
                document.getElementById("cmbMF_TAG").value      = obj.mf_tag;
            } else {
                document.getElementById("txtOENO_NO").value     = "";
                document.getElementById("txtOENO_NM").value     = "";
                document.getElementById("cmbMF_TAG").value      = "";
            }
        }  
        
        
        
        var elementList = new Array(    "txtDPT_CD"    
                                       ,"imgDPT_CD" 
                                       ,"cmbOCC_CD"     
                                       ,"cmbHEAD_CD"    
                                       ,"cmbJOB_CD"     
                                       ,"cmbJIKMU_CD"   
                                       ,"cmbHIR_YM"     
                                       ,"cmbMF_TAG"
                                       ,"cmbLEVY_CD"    
                                       ,"txtREMARK"     
                                       ,"txtLEVY_TXT"   
                                       ,"txtOENO_NO"    
                                       ,"txtOENO_NM"    
                                       ,"ImgEnoNo" );
                                       
        var exceptionList = new Array(  "txtDPT_CD"    
                                       ,"imgDPT_CD" );
 
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_MI_LEVYPLAN)  |
    | 3. ���Ǵ� Table List(T_MI_LEVYPLAN)         |
    +----------------------------------------------->
    <Object ID="dsT_MI_LEVYPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)   |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_MI_LEVYPLAN                     |
    | 3. Table List : T_MI_LEVYPLAN                 |
    +----------------------------------------------->
    <Object ID ="trT_MI_LEVYPLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_MI_LEVYPLAN)">
    </Object>

    <!-- ���� -->
    <Object ID="dsCOMMON_DUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-- ���� -->
    <Object ID="dsCOMMON_JOB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �ι� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B1"/>
       <jsp:param name="CODE_GUBUN"    value="B1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_G4"/>
       <jsp:param name="CODE_GUBUN"    value="G4"/>
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
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        var oSelect = document.getElementById("cmbPIS_YY_SHR");
        var oOption;

        oSelect.length = 0;
        
        if (iCount > 0)    {

            //����⵵
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption         = document.createElement("OPTION");
                oOption.value   = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text    = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oSelect.add(oOption);
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_MI_LEVYPLAN event="OnSuccess()">
        
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_MI_LEVYPLAN event="OnFail()">

        cfErrorMsg(this);

    </script>

     
     
     
    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_MI_LEVYPLAN event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            var LogRow  = dsT_CP_WORKLOG.NameValueRow("PIS_YY", document.getElementById("cmbPIS_YY_SHR").value);
            
            //PRO_STS  1:�۾� open, 2:�ο���ȹ�Ϸ�, 3:����ڼ���, 4:�����Ϸ�, 5:�±޿Ϸ�, 6:�޻��۾��Ϸ�, 7:�۾� close
            //�۾��� OPEN ���°� �ƴϸ� ���̻� ���� �� �� ����.
            if(ProSts != "1")
                return;
        
        
            //�ű��� ���        
            if(dsT_MI_LEVYPLAN.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
            
            fnc_ChgLEVY_CD();
        }
    </script>
 
 
 
    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_MI_LEVYPLAN event=CanRowPosChange(row)>
            
        if (dsT_MI_LEVYPLAN.RowStatus(row) == 1 
                || dsT_MI_LEVYPLAN.RowStatus(row) == 3 ) {
                
            // �μ�
            if( dsT_MI_LEVYPLAN.NameValue(row, "DPT_CD") == '' ) {
                alert("�μ��ڵ�� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtDPT_CD").focus();
                return false;
            }
    
            // �μ� CHECK
            if (dsT_MI_LEVYPLAN.NameValue(row, "DPT_CD") != "" 
                    && dsT_MI_LEVYPLAN.NameValue(row, "DPT_NM") == "") {
                alert("�Ҽ��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtDPT_CD").focus();
                return false;
            }
    
            // �ٷα���
            if( dsT_MI_LEVYPLAN.NameValue(row, "OCC_CD") == '' ) {
                alert("�ٷα����� �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbOCC_CD").focus();
                return false;
            }
    
            // ����
            if( dsT_MI_LEVYPLAN.NameValue(row, "HEAD_CD") == '' ) {
                alert("������ �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbHEAD_CD").focus();
                return false;
            }
    
            // ����
            if( dsT_MI_LEVYPLAN.NameValue(row, "JOB_CD") == '' ) {
                alert("������ �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbJOB_CD").focus();
                return false;
            }
    
            // �������
            if (dsT_MI_LEVYPLAN.NameValue(row, "JOB_CD") != 'ZZ') {
                // ������, �����
                dsT_MI_LEVYPLAN.NameValue(row, "JOB_GBN") = '1';
            }
            else {
                // �İ߻��
                dsT_MI_LEVYPLAN.NameValue(row, "JOB_GBN") = '2';
            }
    
            // ����
            if( dsT_MI_LEVYPLAN.NameValue(row, "JIKMU_CD") == '' ) {
                alert("������ �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbJIKMU_CD").focus();
                return false;
            }
    
            // ��ȹ���
            if( dsT_MI_LEVYPLAN.NameValue(row, "HIR_YM") == '' ) {
                alert("��ȹ����� �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbHIR_YM").focus();
                return false;
            }
    
            // �������
            if( dsT_MI_LEVYPLAN.NameValue(row, "LEVY_CD") == '' ) {
                alert("��������� �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbLEVY_CD").focus();
                return false;
            }
    
            // �������ȯ�� ���
            if (dsT_MI_LEVYPLAN.NameValue(row, "LEVY_CD") == '1') {
                // �������
                if (dsT_MI_LEVYPLAN.NameValue(row, "OENO_NO") == '') {
    
                    alert("�������ȯ�� ��� ��������� �ʼ� �Է»����Դϴ�.");
                    document.getElementById("txtOENO_NO").focus();
                    return false;
                }
    
                // ��� CHECK
                if (dsT_MI_LEVYPLAN.NameValue(row, "OENO_NO") != '' 
                        && dsT_MI_LEVYPLAN.NameValue(row, "OENO_NM") == '') {
    
                    alert("��������� �Է��Ͻ� �İ�������� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                    document.getElementById("txtOENO_NO").focus();
                    return false;
                }
    
                // ����
                if( dsT_MI_LEVYPLAN.NameValue(row, "MF_TAG") == '' ) {
                    alert("������ �ʼ� �Է»����Դϴ�.");
                    document.getElementById("cmbMF_TAG").focus();
                    return false;
                }
            }
        }
    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�μ����ο������ȹ����</td>
                    <td align="right" class="navigator">HOME/�濵����/�����ȹ/<font color="#000000">�μ����ο������ȹ����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">����⵵&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                    <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="65 "></col>
                    <col width="140"></col>
                    <col width="65 "></col>
                    <col width="85 "></col>
                    <col width="65 "></col>
                    <col width="85 "></col>
                    <col width="65 "></col>
                    <col width="160"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtDPT_CD" name="txtDPT_CD" size="2"  maxlength="3" onChange="fnc_GetCommNm('A4','txtDPT_CD','txtDPT_NM');">
                        <input id="txtDPT_NM" name="txtDPT_NM" size="12" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgDPT_CD" name="imgDPT_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','�μ�','DEPT')"></a>
                    </td>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbOCC_CD" name="cmbOCC_CD" style="width:100%">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbHEAD_CD" style="width:100%" >
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbJOB_CD" style="width:100%" >
                            <option value=""></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbJIKMU_CD" style="width:100%">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >��ȹ���</td>
                    <td class="padding2423" align="left">
                        <select id="cmbHIR_YM" style="width:100%" >
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >�������</td>
                    <td class="padding2423" align="left">
                        <select id="cmbLEVY_CD" style="width:100%" onchange="fnc_ChgLEVY_CD()">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                        <input id="txtOENO_NO" name="txtOENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtOENO_NM" name="txtOENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>

                </tr>
                <tr>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select id="cmbMF_TAG" style="width:100%">
                            <option value='M'>����</option>
                            <option value='W'>����</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >�ֿ����</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtREMARK" name="txtREMARK" style="width:470px" onkeyup="fc_chk_byte(this,255);">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >������</td>
                    <td class="padding2423" colspan="7">
                        <textarea id="txtLEVY_TXT"  name="txtLEVY_TXT" cols="115" rows="3" onkeyup="fc_chk_byte(this,1000);"></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_MI_LEVYPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
                            <param name="DataID"                  value="dsT_MI_LEVYPLAN">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'               align=center </C>
                                <C> id='PIS_YY'       width=60    name='����⵵'           align=center </C>
                                <C> id='LEVY_CD'      width=75    name='����'               align=left   EditStyle=Lookup Data='dsCOMMON_G4:CODE:CODE_NAME'</C>
                                <C> id='DPT_NM'       width=100   name='�μ�'               align=left </C>
                                <C> id='OCC_CD'       width=70    name='�ٷα���'               align=center EditStyle=Lookup Data='dsCOMMON_A1:CODE:CODE_NAME'</C>
                                <C> id='HEAD_CD'      width=70    name='����'               align=center EditStyle=Lookup Data='dsCOMMON_B1:CODE:CODE_NAME'</C>
                                <C> id='JOB_CD'       width=70    name='����'               align=center EditStyle=Lookup Data='dsCOMMON_JOB:COMM_CD:COMM_NM'</C>
                                <C> id='JIKMU_CD'     width=120   name='����'               align=left   EditStyle=Lookup Data='dsCOMMON_DUTY:COMM_CD:COMM_NM'</C>
                                <C> id='HIR_YM'       width=70    name='��ȹ���'           align=center </C>
                                <C> id='OENO_NM'      width=80    name='����;(�������ȯ)'  align=center </C>
                                <C> id='MF_TAG'       width=60    name='����'               align=center value={decode(MF_TAG, 'M', '����', '����')}</C>
                                <C> id='REMARK'       width=150   name='�ֿ����'           align=left   </C>
                                <C> id='LEVY_TXT'     width=250   name='������'           align=left   </C>
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
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_MI_LEVYPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY      Ctrl=txtPIS_YY       Param=value </C>
        <C> Col=DPT_CD      Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM      Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=TENO_NO     Ctrl=txtTENO_NO      Param=value </C>
        <C> Col=JOB_CD      Ctrl=cmbJOB_CD       Param=value </C>
        <C> Col=JOB_NM      Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=JOB_GBN     Ctrl=txtJOB_GBN      Param=value </C>
        <C> Col=HIR_YM      Ctrl=cmbHIR_YM       Param=value </C>
        <C> Col=HEAD_CD     Ctrl=cmbHEAD_CD      Param=value </C>
        <C> Col=HEAD_NM     Ctrl=txtHEAD_NM      Param=value </C>
        <C> Col=LEVY_CD     Ctrl=cmbLEVY_CD      Param=value </C>
        <C> Col=LEVY_NM     Ctrl=txtLEVY_NM      Param=value </C>
        <C> Col=JIKMU_CD    Ctrl=cmbJIKMU_CD     Param=value </C>
        <C> Col=JIKMU_NM    Ctrl=txtJIKMU_NM     Param=value </C>
        <C> Col=OCC_CD      Ctrl=cmbOCC_CD       Param=value </C>
        <C> Col=OCC_NM      Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=MF_TAG      Ctrl=cmbMF_TAG       Param=value </C>
        <C> Col=LEVY_TXT    Ctrl=txtLEVY_TXT     Param=value </C>
        <C> Col=REMARK      Ctrl=txtREMARK       Param=value </C>
        <C> Col=OENO_NO     Ctrl=txtOENO_NO      Param=value </C>
        <C> Col=OENO_NM     Ctrl=txtOENO_NM      Param=value </C>
        <C> Col=NDPT_CD     Ctrl=txtNDPT_CD      Param=value </C>
    '>
</object>
