<!--*************************************************************************
* @source      : taxa130.jsp                                                *
* @description : ���漼������Ȳ���� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/26            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>���漼������Ȳ����(taxa130)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "F"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����(ó��)
                    + "F"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
        var selectLayer = "layer_1";

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa130.cmd.TAXA130CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            if(selectLayer == "layer_3") {
                fnc_SearchList3();
            } else if(selectLayer == "layer_4") {
                fnc_SearchList4();
            }        
        }        
         
        /**
         * ��Ÿ�ҵ�/�������ξװ��� ������ �����´�.
         */
        function fnc_SearchList3() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR3");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR3").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR3");
            
            if(oPIS_YM.value == "") {
                alert("�ش����� ����ֽ��ϴ�.");
                oPIS_YM.focus();
                return;
            }

            params = "&S_MODE=SHR3"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            dsT_AC_ETCPAY3.dataid = dataClassName+params;
            dsT_AC_ETCPAY3.reset();
        }

        /**
         * ��õ¡������ ���� ��ȸ
         */
        function fnc_SearchList4() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR4");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR4").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR4");
            
            if(oPIS_YM.value == "") {
                alert("�ش����� ����ֽ��ϴ�.");
                oPIS_YM.focus();
                return;
            }            

            params = "&S_MODE=SHR4"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            trT_AC_ETCPAY4.KeyValue = "SAV(O:dsT_AC_ETCPAY4=dsT_AC_ETCPAY4)";
            trT_AC_ETCPAY4.action = dataClassName+params;
            trT_AC_ETCPAY4.post();
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
            var pis_ym      = document.getElementById("txtPIS_YM_SHR4").value.split("-");
            
            dsT_CM_COMMON_DPT.ClearData();

            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];

            dsT_CM_COMMON_DPT.dataid = dataClassName+params;
            dsT_CM_COMMON_DPT.reset();
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
            //������ȿ�� �˻�
            if(dsT_AC_ETCPAY3.CountColumn == 0) {
                alert("��ȸ�� ���� �Ͻñ� �ٶ��ϴ�");
                return;
            }
            if(!fnc_CheckElement(oInputFieldList, oElementMsgList, new Array("rdoADD_TAG"))) return;
            
            isAdd = false;

            var pis_ym      = document.getElementById("txtPIS_YM_SHR3").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD");
            var oSAL_CD     = document.getElementById("cmbSAL_CD");
            var add_tag     = fnc_GetCheckedValue("rdoADD_TAG");
            var oAMOUNT     = document.getElementById("txtAMOUNT");

            params = "&S_MODE=SAV"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value
                   + "&SAL_CD="+oSAL_CD.value
                   + "&ADD_TAG="+add_tag
                   + "&AMOUNT="+oAMOUNT.text;
                   
            alert(params);

            cfCopyDataSetHeader(dsT_AC_ETCPAY3, dsT_AC_ETCPAY3_SAV);
            dsT_AC_ETCPAY3_SAV.AddRow();

            trT_AC_ETCPAY3.KeyValue = "SAV(I:dsT_AC_ETCPAY3_SAV=dsT_AC_ETCPAY3_SAV)";
            trT_AC_ETCPAY3.action = dataClassName+params;
            trT_AC_ETCPAY3.post();
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {
            if(selectLayer == "layer_1") {
                fnc_Print1();
            } else if(selectLayer == "layer_2") {
                fnc_Print2();
            }
        }
        
        function fnc_Print1() {

            var PIS_YYMM = document.getElementById("txtPIS_YM_SHR1").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR1").value;
            var PIS_GBN = document.getElementById("cmbGBN").value;

            if (DPT_CD == null || DPT_CD == "" )
            {
                alert("�μ��� �����Ͽ� �ֽʽÿ�.");
                return;
            }

            var url = "taxa131_PV.jsp?PIS_YYMM="+PIS_YYMM + "&DPT_CD=" + DPT_CD + "&PIS_GBN=" + PIS_GBN;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }        
         
        function fnc_Print2() {
		    var PIS_YYMM = document.getElementById("txtPIS_YM_SHR2").value;
		    var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;

			var url = "taxa130_PV.jsp?PIS_YYMM="+PIS_YYMM + "&DPT_CD=" + DPT_CD;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }


        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if(selectLayer == "layer_3") {
                fnc_ToExcel3();
            } else if(selectLayer == "layer_4") {
                fnc_ToExcel4();
            }        
        }
         
        function fnc_ToExcel3() {
            if (dsT_AC_ETCPAY3.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_ETCPAY3.GridToExcel("���漼������Ȳ����", '', 225);
        }

        function fnc_ToExcel4() {
            if (dsT_AC_ETCPAY4.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_ETCPAY4.GridToExcel("���漼������Ȳ����", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        var isAdd = false;
        function fnc_AddNew() {
            if(dsT_AC_ETCPAY3.CountColumn == 0) {
                alert("��ȸ�� ���� �Ͻñ� �ٶ��ϴ�");
                return;
            }            
        
            if(isAdd) {
                if(!confirm("�Է��ϴ� �ڷᰡ �ֽ��ϴ�.\n�������� ������ �����˴ϴ�.\n����Ͻðڽ��ϱ�?")) {
                    return;
                }
            }
        
            isAdd = true;
            fnc_EnableElementAll(oInputFieldList);
            
            document.getElementById("cmbSAL_CD").selectedIndex = 0;
            document.getElementsByName("rdoADD_TAG")[0].checked = true;
            document.getElementById("cmbDPT_CD").selectedIndex = 0;     
            document.getElementById("txtAMOUNT").text = 0;
        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage3").innerText = ' ';
            document.getElementById("resultMessage4").innerText = ' ';

            dsT_AC_ETCPAY3.ClearData();
            dsT_AC_ETCPAY4.ClearData();

            //��� �Է�â�� �ʱ�ȭ
            fnc_ClearInputElement(oInputFieldList);
            fnc_DisableElementAll(oInputFieldList);
            
            document.getElementById("cmbDPT_CD_SHR3").selectedIndex = 0;
            document.getElementById("cmbDPT_CD").selectedIndex = 0;
            document.getElementById("cmbSAL_CD").selectedIndex = 0;
            
            document.getElementById("txtDPT_CD_SHR" ).value = "";
            document.getElementById("txtDPT_NM_SHR" ).value = "";
            document.getElementById("txtDPT_CD_SHR1").value = "";
            document.getElementById("txtDPT_NM_SHR1").value = "";
            document.getElementById("cmbDPT_CD_SHR3").value = "";
            document.getElementById("cmbDPT_CD_SHR4").value = "";
            
            isAdd = false;

            //���ڰ��� ���ε�
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY3.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //ù��° �μ� : �׸����
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_AC_ETCPAY3,0,"false","false");      // Grid Style ����
            cfStyleGrid(form1.grdT_AC_ETCPAY4,0,"false","false");      // Grid Style ����

            document.getElementById("txtPIS_YM_SHR1").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM_SHR2").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM_SHR3").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";
            document.getElementById("txtPIS_YM_SHR4").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";

            fnc_DisableElementAll(oInputFieldList);

            //���� �ڵ� ����
            fnc_BindingCommonCode(dsT_CM_COMMON_A4, "cmbDPT_CD_SHR3");
            fnc_BindingCommonCode(dsT_CM_COMMON_A4, "cmbDPT_CD");
            fnc_BindingCommonCode(dsT_CM_COMMON_H2, "cmbSAL_CD");

            //�μ��ڵ� ������Ŵ
            fnc_BindDpt();

            fnc_ShowHiddenLayer(oLayerList, "layer_1");
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/
         
        var oInputFieldList = new Array( "cmbSAL_CD"
                                        ,"rdoADD_TAG"
                                        ,"cmbDPT_CD"
                                        ,"txtAMOUNT");

        //�׸���� �޼���
        var oElementMsgList = new Array( "�׸�"
                                        ,"����"
                                        ,"�μ�"
                                        ,"�ݾ�");

        //���� �������� Layer �׸��
        var oLayerList      = new Array( "layer_1"
                                        ,"layer_2"
                                        ,"layer_3"
                                        ,"layer_4");

        /**
         * ������ â���� �����ְ� �ݴ� ��Ȱ
         * @param selectLayerName - ������ Layer �̸�
         */
        function fnc_ClickBtn(selectLayerName) {
            selectLayer = selectLayerName;
        
            //���̾ �����Ҷ����� ��Ű�� �����Ų��.
            if(selectLayerName == "layer_1" 
                    || selectLayerName == "layer_2") {
                btnList = "F"   //��ȸ
                        + "F"   //�ű�
                        + "F"   //����(ó��)
                        + "F"   //���
                        + "F"   //����
                        + "T"   //�μ�
                        + "F"   //����
                        + "T";  //�ݱ�                  
            } else if(selectLayerName == "layer_3") {
                btnList = "T"   //��ȸ
                        + "F"   //�ű�
                        + "T"   //����(ó��)
                        + "T"   //���
                        + "T"   //����
                        + "F"   //�μ�
                        + "F"   //����
                        + "T";  //�ݱ�              
            } else if(selectLayerName == "layer_4") {
                btnList = "T"   //��ȸ
                        + "F"   //�ű�
                        + "F"   //����(ó��)
                        + "T"   //���
                        + "T"   //����
                        + "F"   //�μ�
                        + "F"   //����
                        + "T";  //�ݱ�              
            }
        
            fnc_ShowHiddenLayer(oLayerList, selectLayerName);
        }

        /**
         * �ش������� ����ɶ����� �μ� ����Ʈ�� �����Ŵ
         */
        function fnc_BindDpt() {
            if(document.getElementById("txtPIS_YM_SHR4").value == "") {
                return;
            }        
        
            document.getElementById("cmbDPT_CD_SHR4").value = "";
            fnc_SearchItem();
            fnc_BindingCommonCode(dsT_CM_COMMON_DPT, "cmbDPT_CD_SHR4");
        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_ETCPAY3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY3_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet                               |
    +------------------------------------------------------>
    <!-- �μ� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �׸� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H2"/>
       <jsp:param name="CODE_GUBUN"    value="H2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_ETCPAY3" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <Object ID="trT_AC_ETCPAY4" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY3 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage3"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage3"),"MSG_03",iCount);
        }
    </Script>

    <Script For=dsT_AC_ETCPAY4 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage4"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage4"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY3 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_AC_ETCPAY4 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY3 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_ETCPAY4 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY3 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage3"), 'MSG_01');
        alert("* �۾��� �Ϸ� �Ͽ����ϴ�!");
        
        fnc_ClearInputElement(oInputFieldList);
        fnc_DisableElementAll(oInputFieldList);
        
        document.getElementsByName("rdoADD_TAG")[0].checked = true;
        fnc_SearchList3();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY3 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_ETCPAY4 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
    <script for=grdT_AC_ETCPAY3 event=OnDblClick(Row,Colid)>
        if(Row < 1) {
            return;
        } else {
            var href_page = "/hr/tax/taxa131.jsp"
                          + "?PIS_YY="+dsT_AC_ETCPAY3.NameValue(Row, "PIS_YY")
                          + "&PIS_MM="+dsT_AC_ETCPAY3.NameValue(Row, "PIS_MM")
                          + "&DPT_CD="+dsT_AC_ETCPAY3.NameValue(Row, "DPT_CD");

            window.showModalDialog(href_page, "", "dialogWidth:600px; dialogHeight:510px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList3();
        }
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���漼������Ȳ����</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">���漼������Ȳ����</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- Layer �� ��ư�� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="4" height="15"></td>
        </tr>
        <tr>
            <td width="25%" align="center"><input type="button" id="btnPROC1"  style="cursor:hand;width:120pt;height:20pt;" value=" �ֹμ�Ư��¡������ "             onclick="fnc_ClickBtn('layer_1')"></td>
            <td width="25%" align="center"><input type="button" id="btnPROC2"  style="cursor:hand;width:120pt;height:20pt;" value=" �ֹμ�Ư��¡����꼭 "             onclick="fnc_ClickBtn('layer_2')"></td>
            <td width="25%" align="center"><input type="button" id="btnPROC3"  style="cursor:hand;width:120pt;height:20pt;" value=" ��Ÿ�ҵ�/�������ξװ��� "             onclick="fnc_ClickBtn('layer_3')"></td>
            <td width="25%" align="center"><input type="button" id="btnPROC4"  style="cursor:hand;width:120pt;height:20pt;" value=" ��õ¡�����곻�� "             onclick="fnc_ClickBtn('layer_4')"></td>
        </tr>
        <tr>
            <td colspan="4" height="5"></td>
        </tr>
    </table>
    <!-- Layer �� ��ư�� -->

<!-- �ֹμ�Ư��¡������ Layer ���� -->
    <div id="layer_1" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:1;">
    <!-- ��ư ���̺� ���� -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print1()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- ��ư ���̺� �� -->

        <!-- power Search���̺� ���� -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="80"></col>
    					<col width="100"></col>
    					<col width="80"></col>
    					<col width="200"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    					<td class="searchState" align="right">�ش���</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR1" name="txtPIS_YM_SHR1" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR1','','134','108');"></a>
    					</td>
                       <td class="searchState" align="right">�μ�</td>
                      <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR1" name="txtDPT_CD_SHR1" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR1" name="txtDPT_NM_SHR1" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR1','txtDPT_NM_SHR1','�μ�','DEPT')">
                        </a>
                   		 </td>
                    	<td class="searchState" align="right">����</td>
    					<td class="padding2423" align="left">
							<select id="cmbGBN" name="cmbGBN">
                                <option value="1">�޿�</option>
                                <option value="2">��</option>
                                <option value="3">������</option>
                                <option value="4">��������</option>
                            </select>
                        </td>

    				</tr>
    			</table>
    			</td>
    		</tr>
    	</table>
    	<!-- power Search���̺� �� -->
    </div>
<!-- �ֹμ�Ư��¡������ Layer �� -->

<!-- �ֹμ�Ư��¡����꼭 Layer ���� -->
    <div id="layer_2" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:2;">
     <!-- ��ư ���̺� ���� -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print2()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- ��ư ���̺� �� -->

        <!-- power Search���̺� ���� -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="80"></col>
    					<col width="100"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    					<td class="searchState" align="right">�ش���</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR2" name="txtPIS_YM_SHR2" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR2','','134','108');"></a>
    					</td>
                       <td class="searchState" align="right">�μ�</td>
                      <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
                        </a>
                    </td>
    				</tr>
    			</table>
    			</td>
    		</tr>
    	</table>
    	<!-- power Search���̺� �� -->

    </div>
<!-- �ֹμ�Ư��¡����꼭 Layer �� -->

<!-- ��Ÿ�ҵ�/�������ξ� ���� Layer ���� -->
    <div id="layer_3" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:3;">

        <!-- ��ư ���̺� ���� -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList3()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel3()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- ��ư ���̺� �� -->

        <!-- power Search���̺� ���� -->
    	<table width="800" border="0" cellspacing="0" cellpadding="0">
    		<tr>
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="80"></col>
    					<col width="100"></col>
    					<col width="80"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    					<td class="searchState" align="right">�ش���</td>
    					<td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR3" name="txtPIS_YM_SHR3" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR3','','134','108');"></a>
    					</td>
                        <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423" align="left">
                            <select id="cmbDPT_CD_SHR3" name="cmbDPT_CD_SHR3">
                                <option value=""></option>
                            </select>
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
                            <col width="90"></col>
                            <col width="140"></col>
                            <col width="90"></col>
                            <col width="180"></col>
                            <col width="90"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                            <td class="padding2423">
                                <select name="cmbSAL_CD" id="cmbSAL_CD">
                                    <option value=""></option>
                                </select>
                            </td>
                            <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                            <td class="padding2423">
                                <input type="radio" id="rdoADD_TAG" name="rdoADD_TAG" value="0" style="border:none" checked> ��ȯ�ޱ�
                                <input type="radio" id="rdoADD_TAG" name="rdoADD_TAG" value="1" style="border:none" > �̳��α�
                            </td>
                            <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                            <td class="padding2423">
                            <select id="cmbDPT_CD" name="cmbDPT_CD">
                                <option value=""></option>
                            </select>
                            </td>                            
                        </tr>
                        <tr>
                            <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                            <td class="padding2423" colspan="5">
                                <comment id="__NSID__">
                                <object id="txtAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                                </object>
                                </comment>
                                <script> __ShowEmbedObject(__NSID__); </script>
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
                            <td valign="bottom" class="searchState"><span id="resultMessage3">&nbsp;</span></td>
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
                        <object id="grdT_AC_ETCPAY3" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID" value="dsT_AC_ETCPAY3">
                            <param name="Editable" value="true">
                            <param name="DragDropEnable" value="true">
                            <param name="SortView" value="Left">
                            <param name="Format" value='
                                <C> id="{CUROW}"     width=60         align=center   name="NO"         value={String(Currow)}    SubSumText=""</C>
                                <C> id=DPT_NM        width=145        align=center   name=" ��  �� "     </C>
                                <C> id=LAB_AMT       width=115        align=right    rightmargin=10        name="�ٷμҵ�"        </C>
                                <C> id=SO_AMT        width=115        align=right    rightmargin=10        name="��Ÿ�ҵ�"        </C>
                                <C> id=MIS_CAL       width=115        align=right    rightmargin=10        name="���ΰ��Ǽ�"    </C>
                                <C> id=MIS_AMT       width=115        align=right    rightmargin=10        name="���αݾ׽Ǽ�"    </C>
                                <C> id=MIS_PRO       width=115        align=right    rightmargin=10        name="�������"        </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        <!-- ���� ��ȸ �׸��� ���̺� ��-->

    </div>
<!-- ��Ÿ�ҵ�/�������ξ� ���� Layer �� -->

<!-- ��õ¡�����곻�� Layer ���� -->
    <div id="layer_4" style="position:absolute; visibility:hidden; display:none; width:640px; z-index:4;">

        <!-- ��ư ���̺� ���� -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="35" class="paddingTop5" align="right">
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList4()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel4()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
                </td>
            </tr>
        </table>
        <!-- ��ư ���̺� �� -->

        <!-- power Search���̺� ���� -->
        <table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" class="greenTable">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="80"></col>
                        <col width="100"></col>
                        <col width="80"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="searchState" align="right">�ش���</td>
                        <td class="padding2423" align="left">
                            <input type="text" id="txtPIS_YM_SHR4" name="txtPIS_YM_SHR4" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onchange="fnc_BindDpt()">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR4','','134','108');"></a>
                        </td>
                        <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423" align="left">
                            <select id="cmbDPT_CD_SHR4" name="cmbDPT_CD_SHR4">
                                <option value=""></option>
                            </select>
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
                            <td valign="bottom" class="searchState"><span id="resultMessage4">&nbsp;</span></td>
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
                        <comment id="__NSID4__">
                        <object id="grdT_AC_ETCPAY4" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID" value="dsT_AC_ETCPAY4">
                            <param name="Editable" value="true">
                            <param name="DragDropEnable" value="true">
                            <param name="SortView" value="Left">
                            <param name="Format" value='
                                <C> id="{CUROW}"            width=60        align=center        name="NO"         value={String(Currow)}    HeadBgColor="#F7DCBB"</C>
                                <C> id=DPT_NM               width=90        align=center        name="����"        HeadBgColor="#F7DCBB"</C>
                                <G> name="����������"    HeadBgColor="#F7DCBB"
                                    <C> id=NO_RTN           width=90        align=right    rightmargin=10        name="��ȯ�� (A)"        HeadBgColor="#F7DCBB"</C>
                                    <C> id=NO_PAY           width=90        align=right    rightmargin=10        name="�̳��� (B)"        HeadBgColor="#F7DCBB"</C>
                                </G>
                                <X> name="�ݿ���õ¡����"      HeadBgColor="#F7DCBB"
                                    <R>
                                        <G> name="���μҵ��(C) = (D+E+F)"           HeadBgColor="#F7DCBB"
                                            <C> id=LAB_AMT      width=90        align=right    rightmargin=10        name="�ٷμҵ� (D)"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=RET_AMT      width=90        align=right    rightmargin=10        name="�����ҵ� (E)"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=SO_AMT       width=90        align=right    rightmargin=10        name="��Ÿ�ҵ� (F)"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                        <C> id=YAC_AMT       width=140       align=right    rightmargin=10        name="����������ȯ�޺� (G)"        HeadBgColor="#F7DCBB"</C>
                                    </R>
                                </X>
                                <G> name="��������"                 HeadBgColor="#F7DCBB"
                                    <C> id=NO_YAC           width=140       align=right    rightmargin=10        name="�������� ��ȯ�޺�(H)"        HeadBgColor="#F7DCBB"</C>
                                    <C> id=MON_RTN          width=140       align=right    rightmargin=10        name="���ȯ��(I) (A+B+C+G)"        HeadBgColor="#F7DCBB"</C>
                                    <C> id=NO_MON           width=130       align=right    rightmargin=10        name="��ȯ�ޱ� (J)=(H+I)"        HeadBgColor="#F7DCBB"</C>
                                </G>
                                <X> name="�ݿ� ��õ¡�� ���μ���"     HeadBgColor="#F7DCBB"
                                    <R>
                                        <G> name="�� �� �� ��"      HeadBgColor="#F7DCBB"
                                            <C> id=RETURN       width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=PAY          width=90        align=right    rightmargin=10        name="��  ��"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                    </R>
                                </X>
                                <X> name="��� ��������"          HeadBgColor="#F7DCBB"
                                    <R>
                                        <G> name="���νǼ�(���)" HeadBgColor="#F7DCBB"
                                            <C> id=CAL_RTN      width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=CAL_PAY      width=90        align=right    rightmargin=10        name="�߰�����"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                        <G> name="���νǼ�(�ݾ�)" HeadBgColor="#F7DCBB"
                                            <C> id=AMT_RTN      width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=AMT_PAY      width=90        align=right    rightmargin=10        name="�߰�����"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                        <G> name="�������"     HeadBgColor="#F7DCBB"
                                            <C> id=PGM_RTN      width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                            <C> id=PGM_PAY      width=90        align=right    rightmargin=10        name="�߰�����"        HeadBgColor="#F7DCBB"</C>
                                        </G>
                                    </R>
                                </X>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID4__); </script>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        <!-- ���� ��ȸ �׸��� ���̺� ��-->

    </div>
<!-- ��õ¡�����곻�� Layer �� -->

    </form>
    <!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->