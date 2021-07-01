<!--
    ************************************************************************************
    * @Source         : vlua072.jsp                                                    *
    * @Description    : ���κ� �����򰡴���� ���� PAGE                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/22  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>���κ� �����򰡴���� ����(vlua072)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN     = request.getParameter("GUBUN");          //��������
    String EVL_YY    = request.getParameter("EVL_YY");         //�ش�⵵
    String EVL_GBN   = request.getParameter("EVL_GBN");        //����(����/����)
    String EVL_FRQ   = request.getParameter("EVL_FRQ");        //ȸ��
    String ENO_NO    = request.getParameter("ENO_NO");         //���
    String ACH_RATE  = request.getParameter("ACH_RATE");       //����
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var GUBUN      = "<%=GUBUN%>";
            var EVL_YY     = "<%=EVL_YY%>";
            var EVL_GBN    = "<%=EVL_GBN%>";
            var EVL_FRQ    = "<%=EVL_FRQ%>";
            var ENO_NO     = "<%=ENO_NO%>";
            var DEGREE_GBN = form1.txtDEGREE_GBN.value.trim();

            form1.txtFLAG.value = "1"; // ��ȸFLAG

            trT_EV_EVLIST_DT.KeyValue = "tr01(O:SHR=dsT_EV_EVLIST_DT,O:SHR2=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_DT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua072.cmd.VLUA072CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DEGREE_GBN="+DEGREE_GBN;
            trT_EV_EVLIST_DT.post();
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
            var CountRow = 0;

            // ������ DATASET Row ������� �ű�
            for (CountRow = 1; CountRow <= dsT_EV_EVLIST_DT.CountRow; CountRow++) {
                dsT_EV_EVLIST_DT.NameValue(CountRow, "SEQ_NO") = CountRow;
            }

            if (!fnc_SaveItemCheck()) {
                return;
            }

            form1.txtFLAG.value = "2"; // ����FLAG

            trT_EV_EVLIST_DT.KeyValue = "tr01(I:SAV=dsT_EV_EVLIST_DT,I:SAV2=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_DT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua072.cmd.VLUA072CMD&S_MODE=SAV";
            trT_EV_EVLIST_DT.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            if (dsT_EV_EVLIST_DT.CountColumn == 0) {
                dsT_EV_EVLIST_DT.setDataHeader("GUBUN:STRING, EVL_YY:STRING, EVL_GBN:STRING, EVL_FRQ:INT, ENO_NO:STRING, DEGREE_GBN:STRING, EVLENO_NO:STRING:NOTNULL, SEQ_NO:INT, REFENO_NO1:STRING, REFENO_NO2:STRING, REFENO_NO3:STRING, APPLY_RATE:DECIMAL, EVLDPT_NM:STRING, EVLJOB_NM:STRING, EVLENO_NM:STRING, REFDPT_NM1:STRING, REFJOB_NM1:STRING, REFENO_NM1:STRING, REFDPT_NM2:STRING, REFJOB_NM2:STRING, REFENO_NM2:STRING, REFDPT_NM3:STRING, REFJOB_NM3:STRING, REFENO_NM3:STRING, EVLHEAD_NM:STRING, REFHEAD_NM1:STRING, REFHEAD_NM2:STRING, REFHEAD_NM3:STRING");
            }

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_EVLIST_DT.InsertRow(dsT_EV_EVLIST_DT.RowPosition+1);
            form1.grdT_EV_EVLIST_DT.SetColumn(form1.grdT_EV_EVLIST_DT.GetColumnID(3));
            form1.grdT_EV_EVLIST_DT.Focus();

            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "GUBUN")      = form1.txtGUBUN.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "EVL_YY")     = form1.txtEVL_YY.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "EVL_GBN")    = form1.cmbEVL_GBN.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "EVL_FRQ")    = form1.cmbEVL_FRQ.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "ENO_NO")     = form1.txtENO_NO.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "DEGREE_GBN") = form1.txtDEGREE_GBN.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "APPLY_RATE") = form1.txtACH_RATE.value.trim();

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_EVLIST_DT.CountRow < 1) {
                document.getElementById("resultMessage").innerText = '������ �ڷᰡ �����ϴ�.';
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition,"EVLENO_NO") + "][" + dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition,"EVLENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_EVLIST_DT.DeleteRow(dsT_EV_EVLIST_DT.RowPosition);

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_EVLIST_DT.SetColumn(form1.grdT_EV_EVLIST_DT.GetColumnID(0));
            form1.grdT_EV_EVLIST_DT.Focus();

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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
            if (dsT_EV_EVLIST_HD.NameValue(1, "GROUP_CD").trim() == '') {
                alert("�򰡱׷��� �ʼ� �Է»����Դϴ�.");
                form1.cmbGROUP_CD.focus();
                return false;
            }

            if (!dsT_EV_EVLIST_DT.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                if (!dsT_EV_EVLIST_HD.IsUpdated ) {
                    document.getElementById("resultMessage").innerText = '���� �� ����ڰ� �����ϴ�..';
                    alert("���� �� ����ڰ� �����ϴ�..");
                    return false;
                }

            }

            if ( dsT_EV_EVLIST_DT.isUpdated ) {
                for( i = 1; i <= dsT_EV_EVLIST_DT.CountRow; i++ ) {
                    if( dsT_EV_EVLIST_DT.RowStatus(i) == 1 ||
                        dsT_EV_EVLIST_DT.RowStatus(i) == 3 ) {
                        // ���
                        if( dsT_EV_EVLIST_DT.NameValue(i, "EVLENO_NO").trim() == '' ) {
                            alert("����� �ʼ� �Է»����Դϴ�.");
                            dsT_EV_EVLIST_DT.RowPosition = i;
                            form1.grdT_EV_EVLIST_DT.SetColumn("EVLENO_NO");
                            form1.grdT_EV_EVLIST_DT.focus();
                            return false;
                        }

                        // �ݿ�����
                        if( dsT_EV_EVLIST_DT.NameValue(i, "APPLY_RATE") <= 0 ) {
                            alert("�ݿ������� �ʼ� �Է»����Դϴ�.");
                            dsT_EV_EVLIST_DT.RowPosition = i;
                            form1.grdT_EV_EVLIST_DT.SetColumn("APPLY_RATE");
                            form1.grdT_EV_EVLIST_DT.focus();
                            return false;
                        }
                    }
                }
            }

            // �ݿ����� ����üũ(������ 100�� �ƴϸ� ����)
            if (dsT_EV_EVLIST_DT.Sum(12,0,0) != 100 && dsT_EV_EVLIST_DT.CountRow != 0) {
                alert("�ݿ������� ������ 100 �̾�� �մϴ�. ["+dsT_EV_EVLIST_DT.Sum(12,0,0)+"]\nȮ�� �� �����ϼ���.");
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var DEGREE_GBN = null;

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_EVLIST_DT,0,"true","right");

            Colid = window.dialogArguments;

            form1.txtACH_RATE.value   = "<%=ACH_RATE%>";
            form1.txtDEGREE_GBN.value = '1';

            if ("<%=GUBUN%>" == "01") {
                //�򰡱׷�
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD").add(oOption);

                }

            }
            else if ("<%=GUBUN%>" == "02") {
                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD").add(oOption);
                }

            }

            form1.txtGUBUN.value = "<%=GUBUN%>";

            // �׸��忡 ���κ������򰡴���ڼ��� ������ ��ȸ
            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_EVLIST_DT.IsUpdated || dsT_EV_EVLIST_HD.IsUpdated)
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

    </script>

    </head>



    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_DT) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_DT)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(TEST_MAIN)      |
    | 3. ���Ǵ� Table List(TEST_MAIN)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_DT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_EVLIST_DT,I:SAV2=dsT_EV_EVLIST_HD)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �򰡱׷� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script  for=grdT_EV_EVLIST_DT event=OnClick(row,colid)>

        // ���°� 'insert'�� ���
        if( dsT_EV_EVLIST_DT.RowStatus(row) == 1 ) {

            // �Է½� ����� ���� Ű �Է� ����
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NO', 'Edit') = 'true';
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NM', 'Edit') = 'true';

        } else {

            // ����� ���� Ű �Է� �Ұ�
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NO', 'Edit') = 'None';
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NM', 'Edit') = 'None';
        }

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�..");

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("1������ �ʼ��Է��׸�[���/����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("1������ ���/���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EV_EVLIST_DT event="OnSuccess()">

        if (form1.txtFLAG.value == "1") {
            dsT_EV_EVLIST_HD.RowPosition = 1;
        }
        else {
            document.getElementById("resultMessage").innerText = '������ �Ϸ�Ǿ����ϴ�.';

            if (dsT_EV_EVLIST_DT.CountRow != 0) {
                window.returnValue = dsT_EV_EVLIST_HD.NameString(1, "GROUP_CD") + ";"+dsT_EV_EVLIST_DT.NameString(1, "REFENO_NM1") + ";"+dsT_EV_EVLIST_DT.NameString(1, "EVLENO_NM");

            }
            else {
                window.returnValue = dsT_EV_EVLIST_HD.NameString(1, "GROUP_CD") + ";";
            }
        }

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EV_EVLIST_DT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-- �׸����� �˾��ʵ� Ŭ���� -->
    <script language="javascript" for=grdT_EV_EVLIST_DT event=OnPopup(Row,Colid,data)>

        var obj = new String();

        obj.shr_kind = "SHR_01";

        obj.eno_nm = '';

        window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        if (form1.txtENO_NO.value == obj.eno_no) {
            alert("�Է��ϰ��� �ϴ� ���/�̸��� �����ڿ� �����մϴ�.");
            return;
        }

        // ���, ���� ��ȸ (����)
        if ( Colid == 'EVLENO_NO' ||
             Colid == 'EVLENO_NM' ) {

            for (var i = 1; i <= dsT_EV_EVLIST_DT.CountRow; i++) {

                if (obj.eno_no != '' && dsT_EV_EVLIST_DT.NameValue(i, 'EVLENO_NO') == obj.eno_no) {
                    alert('�̹� ������ ���ڻ���Դϴ�.');
                    return;
                }
            }

            if (obj.eno_no != '' &&
                (dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO1') == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO2') == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO3') == obj.eno_no )) {
                 alert('�̹� �������ڷ� �����Ǿ� �ֽ��ϴ�.');
                 return;
            }

            dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO')  = obj.eno_no;
            dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NM')  = obj.eno_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'EVLDPT_NM')  = obj.dpt_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'EVLJOB_NM')  = obj.job_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'EVLHEAD_NM') = obj.head_nm;
        }

        // ���, ���� ��ȸ (������1)
        if ( Colid == 'REFENO_NO1' ||
             Colid == 'REFENO_NM1' ) {

            if (obj.eno_no != '' &&
                (dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO')  == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO2') == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO3') == obj.eno_no )) {
                alert('�ش� ���ڿ� ���� �����ڰ� �̹� �����Ǿ� �ְų� ������ ���ڿ� �����մϴ�..');
                return;
            }

            dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO1')  = obj.eno_no;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NM1')  = obj.eno_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFDPT_NM1')  = obj.dpt_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFJOB_NM1')  = obj.job_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFHEAD_NM1') = obj.head_nm;
        }

        // ���, ���� ��ȸ (������2)
        if ( Colid == 'REFENO_NO2' ||
             Colid == 'REFENO_NM2' ) {

            if (obj.eno_no != '' &&
                (dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO')  == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO1') == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO3') == obj.eno_no )) {
                alert('�ش� ���ڿ� ���� �����ڰ� �̹� �����Ǿ� �ְų� ������ ���ڿ� �����մϴ�..');
                return;
            }

            dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO2')  = obj.eno_no;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NM2')  = obj.eno_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFDPT_NM2')  = obj.dpt_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFJOB_NM2')  = obj.job_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFHEAD_NM2') = obj.head_nm;
        }

        // ���, ���� ��ȸ (������3)
        if ( Colid == 'REFENO_NO3' ||
             Colid == 'REFENO_NM3' ) {

            if (obj.eno_no != '' &&
                (dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO')  == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO1') == obj.eno_no ||
                 dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO2') == obj.eno_no )) {
                alert('�ش� ���ڿ� ���� �����ڰ� �̹� �����Ǿ� �ְų� ������ ���ڿ� �����մϴ�..');
                return;
            }

            dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO3')  = obj.eno_no;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NM3')  = obj.eno_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFDPT_NM3')  = obj.dpt_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFJOB_NM3')  = obj.job_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'REFHEAD_NM3') = obj.head_nm;
        }


    </script>

    <!-- ��� �Ǵ�  ������ ������ �� ����, �Ҽ�, ������ �Բ� ���������� �� -->
    <script language="javascript"  for=grdT_EV_EVLIST_DT event=OnExit(Row,Colid,olddata)>

        // ����
        if (Colid == 'EVLENO_NO' || Colid == 'EVLENO_NM') {
            if (dsT_EV_EVLIST_DT.NameValue(Row, Colid) == "") {
                dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO') = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NM') = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'DPT_NM')    = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'JOB_NM')    = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'HEAD_NM')   = "";
            }

        }

        // ��������1
        if (Colid == 'REFENO_NO1' || Colid == 'REFENO_NM1') {
            if (dsT_EV_EVLIST_DT.NameValue(Row, Colid) == "") {
                dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO1')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NM1')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFDPT_NM1')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFJOB_NM1')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFHEAD_NM1') = "";
            }

        }

        // ��������2
        if (Colid == 'REFENO_NO1' || Colid == 'REFENO_NM2') {
            if (dsT_EV_EVLIST_DT.NameValue(Row, Colid) == "") {
                dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO2')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NM2')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFDPT_NM2')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFJOB_NM2')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFHEAD_NM2') = "";
            }

        }

        // ��������3
        if (Colid == 'REFENO_NO1' || Colid == 'REFENO_NM3') {
            if (dsT_EV_EVLIST_DT.NameValue(Row, Colid) == "") {
                dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NO3')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFENO_NM3')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFDPT_NM3')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFJOB_NM3')  = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'REFHEAD_NM3') = "";
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ� �����򰡴���� ����</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������ ���� </strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                <td align="right" class="searchState">�ش�⵵</td>
                                <td class="padding2423"><input id=txtEVL_YY name=txtEVL_YY size="4" class="input_ReadOnly" readOnly></td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423" class="input_ReadOnly" readOnly>
                                    <select id=cmbEVL_GBN name=cmbEVL_GBN disabled="true">
                                        <option value="1">����</option>
                                        <option value="2">����</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423" class="input_ReadOnly" readOnly>
                                    <select id=cmbEVL_FRQ name=cmbEVL_FRQ disabled="true">
                                        <option value="1">1ȸ</option>
                                        <option value="2">2ȸ</option>
                                        <option value="3">3ȸ</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�򰡱׷�</td>
                                <td class="padding2423">
                                    <select id=cmbGROUP_CD name=cmbGROUP_CD>
                                        <option vlaue=""></option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input id=txtDPT_NM name=txtDPT_NM   size="16" class="input_ReadOnly" readOnly></td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423"><input id=txtENO_NM name=txtENO_NM size="10" class="input_ReadOnly" readOnly></td>
                                <!-- Hidden Filed -->
                                <input type=hidden id=txtENO_NO><input type=hidden id=txtDEGREE_GBN><input type=hidden name=txtACH_RATE>
                                <input type=hidden name=txtFLAG>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ư ���̺�2 ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>���� ���� List</strong></td>
        <td align="right" valign="bottom">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image11" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image12" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺�2 �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_EVLIST_DT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
                            <param name="DataID"                  value="dsT_EV_EVLIST_DT">
                            <param name="EdiTABLE"                value="true">
                            <param name="IndWidth"                value="0">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="ColSizing"               value="true">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FG>  name='1����' HeadBgColor='#F7DCBB'
                                    <C> id='EVLHEAD_NM'   width=75    name='����'      align=left   Edit=None</C>
                                    <C> id='EVLDPT_NM'    width=80    name='�Ҽ�'      align=left   Edit=None</C>
                                    <C> id='EVLJOB_NM'    width=60    name='����'      align=center Edit=None</C>
                                    <C> id='EVLENO_NO'    width=75    name='���'      align=center Edit=Numeric EditStyle=Popup EditLimit=10 </C>
                                    <C> id='EVLENO_NM'    width=60    name='����'      align=center              EditStyle=Popup EditLimit=20 </C>
                                    <C> id='APPLY_RATE'   width=75    name='�ݿ�����'  EditLimit=6  </C>
                                </FG>
                                <G> name='������ 1' HeadBgColor='#F7DCBB'
                                    <C> id='REFHEAD_NM1'  width=75    name='����'      align=left   Edit=None</C>
                                    <C> id='REFDPT_NM1'   width=80    name='�Ҽ�'      align=left   Edit=None</C>
                                    <C> id='REFJOB_NM1'   width=60    name='����'      align=center Edit=None</C>
                                    <C> id='REFENO_NO1'   width=75    name='���'      align=center Edit=Numeric EditStyle=Popup EditLimit=10 </C>
                                    <C> id='REFENO_NM1'   width=60    name='����'      align=center              EditStyle=Popup EditLimit=20 </C>
                                </G>
                                <G> name='������ 2' HeadBgColor='#F7DCBB'
                                    <C> id='REFHEAD_NM2'  width=75    name='����'      align=left   Edit=None</C>
                                    <C> id='REFDPT_NM2'   width=80    name='�Ҽ�'      align=left   Edit=None</C>
                                    <C> id='REFJOB_NM2'   width=60    name='����'      align=center Edit=None</C>
                                    <C> id='REFENO_NO2'   width=75    name='���'      align=center Edit=Numeric EditStyle=Popup EditLimit=10 </C>
                                    <C> id='REFENO_NM2'   width=60    name='����'      align=center              EditStyle=Popup EditLimit=20 </C>

                                </G>
                                <G> name='������ 3' HeadBgColor='#F7DCBB'
                                    <C> id='REFHEAD_NM3'  width=75    name='����'      align=left   Edit=None</C>
                                    <C> id='REFDPT_NM3'   width=80    name='�Ҽ�'      align=left   Edit=None</C>
                                    <C> id='REFJOB_NM3'   width=60    name='����'      align=center Edit=None</C>
                                    <C> id='REFENO_NO3'   width=75    name='���'      align=center Edit=Numeric EditStyle=Popup EditLimit=10 </C>
                                    <C> id='REFENO_NM3'   width=60    name='����'      align=center              EditStyle=Popup EditLimit=20 </C>
                                </G>
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

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
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
<object id="bndT_EV_EVLIST_HD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_EVLIST_HD">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN        Ctrl=txtGUBUN      Param=value </C>
        <C>Col=EVL_YY       Ctrl=txtEVL_YY     Param=value </C>
        <C>Col=EVL_GBN      Ctrl=cmbEVL_GBN    Param=value </C>
        <C>Col=EVL_FRQ      Ctrl=cmbEVL_FRQ    Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM     Param=value </C>
        <C>Col=GROUP_CD     Ctrl=cmbGROUP_CD   Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM     Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO     Param=value </C>
    '>
</object>