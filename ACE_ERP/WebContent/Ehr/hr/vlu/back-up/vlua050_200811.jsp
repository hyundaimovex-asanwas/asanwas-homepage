<!--
    ************************************************************************************
    * @Source         : vlua050.jsp                                                    *
    * @Description    : ������ �׸���.                                             *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/15  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp"%>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>

    <head>
    <title>�������׸���(vlua050)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var year = getToday().substring(0,4);
        var btnList = 'TTTTFFTT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if( !fnc_SearchItemCheck() ) return;

            //�����ͼ� ����
            dsT_EV_ESTITEM.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SHR&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value+"&EVL_FRQ="+document.getElementById("cmbEVL_FRQ_SHR").value+"&GROUP_CD="+document.getElementById("cmbGROUP_CD_SHR").value+"&EST_CD="+document.getElementById("cmbEST_CD_SHR").value;
            dsT_EV_ESTITEM.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�����ͼ� ����(�򰡱����������� ��ȸ)
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )     return;

            //Ʈ����� ����
            trT_EV_ESTITEM.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SAV";
            trT_EV_ESTITEM.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            fnc_Remove();

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

            if (document.form1.cmbEVL_YY_SHR.value != year) {

                alert("�ش�⵵ �̿��� �ڷ�� �ű� ���� �� �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_07');
                document.form1.cmbEVL_YY_SHR.focus();
                return;

            }

            if( !fnc_SearchItemCheck() ) return;

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_ESTITEM.CountColumn == 0) {
                dsT_EV_ESTITEM.setDataHeader("GUBUN:STRING, EVL_YY:STRING, EVL_FRQ:INT, COMM_CD1:STRING, GROUP_CD:STRING, COMM_CD2:STRING, EST_CD:STRING, ABL_CD:STRING, ABL_NM:STRING, WEIGHT:INT, SUBITEM_01:STRING, SUBITEM_02:STRING, SUBITEM_03:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_ESTITEM.AddRow();

            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"GUBUN")    = form1.txtGUBUN.value;
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"EVL_YY")   = form1.cmbEVL_YY_SHR.value;
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"EVL_FRQ")  = form1.cmbEVL_FRQ_SHR.value;

            // �λ���
            if (GUBUN == "01") {
                dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"COMM_CD1") = "EG";
            }
            // ������
            else if (GUBUN == "02") {
                dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"COMM_CD1") = "4";
            }

            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"GROUP_CD") = form1.cmbGROUP_CD_SHR.value;
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"COMM_CD2") = "EA";
            dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,"EST_CD")   = form1.cmbEST_CD_SHR.value;

            form1.grdT_EV_ESTITEM.Draw = false;
            form1.grdT_EV_ESTITEM.RowPosition    = dsT_EV_ESTITEM.RowPosition;
            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_CD";
            form1.grdT_EV_ESTITEM.Draw = true;

            form1.grdT_EV_ESTITEM.Focus();

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

            //Row���°�
            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_ESTITEM.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

            if (document.form1.cmbEVL_YY_SHR.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� ���� �� �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.cmbEVL_YY_SHR.focus();
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("�ڵ�[" + dsT_EV_ESTITEM.NameValue(dsT_EV_ESTITEM.RowPosition,'ABL_CD') + "]�� �����Ͻðڽ��ϱ�?") == false) return;

            status = dsT_EV_ESTITEM.RowStatus(dsT_EV_ESTITEM.RowPosition);
            dsT_EV_ESTITEM.DeleteRow(dsT_EV_ESTITEM.RowPosition);

            if( status != 1 ) {
                //Ʈ����� ����
                trT_EV_ESTITEM.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=DEL";
                trT_EV_ESTITEM.Post();
            }

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_ESTITEM.Focus();

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("cmbEVL_YY_SHR")[4].selected = true;
            fnc_SearchItem();

            document.getElementById("cmbGROUP_CD_SHR")[0].selected = true;
            document.getElementById("cmbEST_CD_SHR")[0].selected = true;

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_ESTITEM.ClearAll();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ESTITEM.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( document.getElementById("cmbEVL_YY_SHR").value == '' ) {
                alert("�ش�⵵�� �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbEVL_YY_SHR").focus();
                return false;
            }

            if( document.getElementById("cmbEVL_FRQ_SHR").value == '' ) {
                alert(document.getElementById("cmbEVL_YY_SHR").value + "�⵵ �� ���� ���� �� �۾� �ϼ���!");
                document.getElementById("cmbEVL_FRQ_SHR").focus();
                return false;
            }

            if( document.getElementById("cmbGROUP_CD_SHR").value == '' ) {
                alert("�򰡱׷��� �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbGROUP_CD_SHR").focus();
                return false;
            }

            if( document.getElementById("cmbEST_CD_SHR").value == '' ) {
                alert("��������ǥ�� �ʼ� �Է»����Դϴ�.");
                document.getElementById("cmbEST_CD_SHR").focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (document.form1.cmbEVL_YY_SHR.value != year) {
                alert("����⵵ �̿��� �ڷ�� ���� �� ������ �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.cmbEVL_YY_SHR.focus();
                return false;
            }

            if ( dsT_EV_ESTITEM.isUpdated ) {
                for( i=1; i<=dsT_EV_ESTITEM.CountRow; i++ ) {
                    if( dsT_EV_ESTITEM.RowStatus(i) == 1 || dsT_EV_ESTITEM.RowStatus(i) == 2 || dsT_EV_ESTITEM.RowStatus(i) == 3 ) {
                        if( dsT_EV_ESTITEM.NameValue(i, "ABL_CD") == '' ) {
                            alert("�ڵ�� �ʼ� �Է»����Դϴ�.");
                            form1.grdT_EV_ESTITEM.Draw = false;
                            form1.grdT_EV_ESTITEM.RowPosition    = i;
                            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_CD";
                            form1.grdT_EV_ESTITEM.Draw = true;
                            form1.grdT_EV_ESTITEM.Focus();
                            return false;
                        }
                        if( dsT_EV_ESTITEM.NameValue(i, "ABL_NM") == '' ) {
                            alert("��Ī�� �ʼ� �Է»����Դϴ�.");
                            form1.grdT_EV_ESTITEM.Draw = false;
                            form1.grdT_EV_ESTITEM.RowPosition    = i;
                            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_NM";
                            form1.grdT_EV_ESTITEM.Draw = true;
                            form1.grdT_EV_ESTITEM.Focus();
                            return false;
                        }
                    }
                }
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            getSelYy2('cmbEVL_YY_SHR');                         //�ش� �⵵ AddItem
            document.getElementById("cmbEVL_YY_SHR").focus();   //set focus

            // ��������
            if (frameid == "vlua050") {
                // �λ���
                GUBUN = "01";

                //�򰡱׷�
                var oOption;
                for( i=1; i<=dsCOMMON_EG.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";

            }
            else {
                // ������
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            document.form1.txtGUBUN.value = GUBUN;

            //��������ǥ
            for( i=1; i<=dsCOMMON_EA.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_EA.NameValue(i,"CODE");
                oOption.text = dsCOMMON_EA.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEST_CD_SHR").add(oOption);
            }

            fnc_SearchItem();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

		//���⵵ ���� ����
        function fnc_Yearcopy(){

   			if( ! confirm("���⵵ ������ �����Ͻðڽ��ϱ�?") ){
				return false;
			}

            //�������׸� ������ ���� ��ȸ
            dsT_EV_ESTITEM_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SHR_01&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_ESTITEM_01.reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTITEM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTITEM_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID ="trT_EV_ESTITEM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ESTITEM)">
    </Object>

    <Object ID ="trT_EV_ESTITEM_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"  value="EG"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EA"/>
       <jsp:param name="CODE_GUBUN"    value="EA"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-----------------------------------------------------+
    | �ڵ�(Ű��)�� �����Ұ��ϰ� ���ֱ�                     |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_EV_ESTITEM event="OnLButtonDown(type,index, colid, x, y)">

        if( dsT_EV_ESTITEM.RowStatus(dsT_EV_ESTITEM.RowPosition)==0 ) {
            grdT_EV_ESTITEM.LayoutInfo("ColumnInfo", "ABL_CD::<CHILD>::type")='None';
        } else {
            grdT_EV_ESTITEM.LayoutInfo("ColumnInfo", "ABL_CD::<CHILD>::type")='Edit';
        }

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTITEM Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ESTITEM.CountRow);

        }

            form1.grdT_EV_ESTITEM.Draw = false;
            form1.grdT_EV_ESTITEM.RowPosition    = 1;
            form1.grdT_EV_ESTITEM.ColumnPosition = "ABL_CD";
            form1.grdT_EV_ESTITEM.Draw = true;

            form1.grdT_EV_ESTITEM.Focus();

    </Script>

    <Script For=dsT_EV_ESTITEM_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("���������Ͱ� �����մϴ�. ��� �Ͻðڽ��ϱ�?") ){
				return false;
			}

        }

		//Ʈ����� üũ�� ���� �ӽû���
        dsT_EV_ESTITEM_01.AddRow();

		//Ʈ����� ����
		trT_EV_ESTITEM_01.KeyValue = "SVL(I:dsT_EV_ESTITEM_01=dsT_EV_ESTITEM_01)";
		trT_EV_ESTITEM_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua050.cmd.VLUA050CMD&S_MODE=SAV_01&GUBUN="+document.getElementById("txtGUBUN").value+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
		trT_EV_ESTITEM_01.Post();

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //ȸ���޺� ��λ���
            for( i=0; i<=document.getElementById("cmbEVL_FRQ_SHR").length; i++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
            }

            document.getElementById("resultMessage").innerText = ' ';
            dsT_EV_ESTITEM.ClearAll();
            alert( document.getElementById("cmbEVL_YY_SHR").value + "�⵵ �� ���� ���� �� �۾� �ϼ���!");

        } else {

            //ȸ��
            var oOption;

            //ȸ���޺� ��λ���
            for( j=0; j<=document.getElementById("cmbEVL_FRQ_SHR").length; j++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
                document.getElementById("cmbEVL_FRQ_SHR").remove(1);
            }

            for( k=1; k<=Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); k++ ) {        //������ȸ��
                oOption = document.createElement("OPTION");
                oOption.value = k;
                oOption.text = k;
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

            fnc_SearchList();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTITEM Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTITEM_01 Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsCOMMON_EG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTITEM Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�ڵ�/��Ī/����ġ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�ڵ�/��Ī/����ġ�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsCOMMON_EG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ESTITEM event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <script for=trT_EV_ESTITEM_01 event="OnSuccess()">

		//������ �ش��ڷ� ����ȸ
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ESTITEM event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <script for=trT_EV_ESTITEM_01 event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������׸���</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�������׸���</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearcopy','','/images/button/btn_YearcopyOver.gif',1)"><img src="/images/button/btn_YearcopyOn.gif" name="imgYearcopy"    width="110" height="20" border="0" align="absmiddle" onClick="fnc_Yearcopy();"></a>
	            &nbsp;&nbsp;
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="130"></col>
                                    <col width="70"></col>
                                    <col width="50"></col>
                                    <col width="50"></col>
                                    <col width="40"></col>
                                    <col width="80"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                    <td align="right" width="1"></td>
                                    <td align="right" class="searchState">�ش�⵵</td>
                                    <td class="padding2423"><select id=cmbEVL_YY_SHR name=cmbEVL_YY_SHR onChange="fnc_SearchItem();"><select></td>
                                    <td align="right" class="searchState">ȸ��</td>
                                    <td class="padding2423">
                                        <select id="cmbEVL_FRQ_SHR" name="cmbEVL_FRQ_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select> </td>
                                    <td align="right" class="searchState">�򰡱׷�</td>
                                    <td class="padding2423">
                                        <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">��������ǥ</td>
                                    <td class="padding2423">
                                        <select id="cmbEST_CD_SHR" name="cmbEST_CD_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        </select>
                                    </td>
                                    <td align="left" width="200"></td>
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
                        <td align="right">&nbsp;</td>
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
                              <object id="grdT_EV_ESTITEM" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=800 height=340>
                                <Param Name="DataID"         value="dsT_EV_ESTITEM">
                                <Param Name="IndicatorInfo"     value='<INDICATORINFO width="0"></INDICATORINFO>'>
                                <param name="Sort"           value="false">
                                <Param Name="ColumnInfo"     value='
                                  <COLUMNINFO>
                                    <COLUMN id="ABL_CD" refcolid="ABL_CD">
                                        <HEADER left="0" top="0" right="40" bottom="30" bgcolor="#F7DCBB" text="�ڵ�"/>
                                        <VIEW bordercolor="silver" left="0" top="0" right="40" bottom="60" align="centercenter" />
                                        <CHILD type="edit" inputtype="num" limitlength="3" />
                                    </COLUMN>
                                    <COLUMN id="ABL_NM" refcolid="ABL_NM">
                                        <HEADER left="40" top="0" right="120" bottom="30" bgcolor="#F7DCBB" text="��  Ī"/>
                                        <VIEW bordercolor="silver" left="40" top="0" right="120" bottom="60" align="leftcenter" />
                                        <CHILD type="edit" inputtype="" limitlength="50" />
                                    </COLUMN>
                                    <COLUMN id="WEIGHT" refcolid="WEIGHT">
                                        <HEADER left="120" top="0" right="170" bottom="30" bgcolor="#F7DCBB" text="����ġ"/>
                                        <VIEW bordercolor="silver" left="120" top="0" right="170" bottom="60" align="rightcenter" />
                                        <CHILD type="edit" inputtype="num" limitlength="3" />
                                    </COLUMN>
                                    <COLUMN id="SUBITEM_01" refcolid="SUBITEM_01">
                                        <HEADER left="170" top="0" right="796" bottom="30" bgcolor="#F7DCBB" text="��        ��        ��        ǥ"/>
                                        <VIEW bordercolor="silver" left="170" top="0" right="796" bottom="20" align="leftcenter" />
                                        <CHILD type="edit" inputtype="" limitlength="300" />
                                    </COLUMN>
                                    <COLUMN id="SUBITEM_02" refcolid="SUBITEM_02">
                                        <HEADER left="170" top="0" right="796" bottom="30" bgcolor="#F7DCBB" text="��        ��        ��        ǥ"/>
                                        <VIEW bordercolor="silver" left="170" top="20" right="796" bottom="40" align="leftcenter"/>
                                        <CHILD type="edit" inputtype="" limitlength="300" />
                                    </COLUMN>
                                    <COLUMN id="SUBITEM_03" refcolid="SUBITEM_03">
                                        <HEADER left="170" top="0" right="796" bottom="30" bgcolor="#F7DCBB" text="��        ��        ��        ǥ"/>
                                        <VIEW bordercolor="silver" left="170" top="40" right="796" bottom="60" align="leftcenter"/>
                                        <CHILD type="edit" inputtype="" limitlength="300" />
                                    </COLUMN>
                                 </COLUMNINFO>'>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>


</body>
</html>