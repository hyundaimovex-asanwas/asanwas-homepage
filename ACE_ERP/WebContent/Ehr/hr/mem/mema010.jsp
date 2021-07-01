<!--
    ************************************************************************************
    * @Source         : mema010.jsp                                                    *
    * @Description    : �λ������� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>�λ�������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.upload.pds");
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        var btnList = 'TTTTFFFT';
        var imgBox  = null;        // ���ε�� ���� �����ֱ�

        //���â���� ����� ��� �����ϱ� ���� ���
        var dsTemp = window.dialogArguments;

        var savflag = '';
        var ahiflag = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if (document.getElementById("txtENO_NO").value == "") {

                alert("���/������ ���� �Է��Ͻ� ���� �۾��Ͽ� �ֽñ� �ٶ��ϴ�.");
                document.getElementById("txtENO_NM").focus();

                return;

            }

            dsT_ME_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema010.cmd.MEMA010CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO").value;
            dsT_ME_PERSON.Reset();

            if (document.getElementById("txtENO_NO").disabled == false) {
                document.getElementById("txtENO_NM").focus();
            }

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

            if(fnc_SaveItemCheck()) {

                trT_ME_PERSON.KeyValue = "SVL(I:SAV=dsT_ME_PERSON)";
                trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema010.cmd.MEMA010CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO").value+"&HEAD_CD="+document.getElementById("txtHEAD_CD").value+"&DPT_CD="+document.getElementById("txtDPT_CD").value;
                trT_ME_PERSON.post();

   				//�Ի��� ��� ���翩�� Ȯ��
				ahiflag = 'SAV';
	            dsT_ME_AHISTORY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema019.cmd.MEMA019CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO").value;
	            dsT_ME_AHISTORY.Reset();

            }
            else {
                fnc_TabSave();
            }


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
            var ENO_NO = document.getElementById('txtENO_NO').value;

            if (ENO_NO == "") {
                alert("����� �Է��Ͽ� ȭ���� ��ȸ�Ͻ� �Ŀ� �۾��Ͻñ� �ٶ��ϴ�.");
                return;
            }

            if (dsT_ME_PERSON.CountRow < 1) {
                alert("�Է��Ͻ� ������� ȭ���� ��ȸ�Ͻ� �Ŀ� �۾��Ͻñ� �ٶ��ϴ�.");
                return;
            }

            if (dsT_ME_PERSON.RowStatus(dsT_ME_PERSON.RowPosition) == 1) {
                alert("�ű��۾��� ��� ȭ���� ���� �����Ͻ� �Ŀ� �۾��Ͻñ� �ٶ��ϴ�..");
                return;
            }

			//�İ߻�� �λ�������� ��ũ
			window.showModalDialog("/hr/pir/pird020.jsp", dsT_ME_PERSON, "dialogWidth:840px; dialogHeight:580px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_ME_PERSON.CountColumn == 0) {
                dsT_ME_PERSON.setDataHeader("ENO_NO:STRING:NOTNULL, OCC_CD:STRING, ENO_NM:STRING:NOTNULL, NAM_ENG:STRING, NAM_CHI:STRING, MF_TAG:STRING, BIR_YMD:STRING, BIR_TAG:STRING, CET_NO:STRING, HEAD_CD:STRING, REG_CD:STRING, DPT_CD:STRING, JOB_CD:STRING, DUTY_CD:STRING, TEAM_CD:STRING, HIR_YMD:STRING, TERM1_YMD:STRING, TERM2_YMD:STRING");
            }

            if (dsT_ME_PERSON.IsUpdated ) {
                alert("�ش� �ʼ��Է��׸�[���/����]�� �Է����� �����̰ų� ��������� �����մϴ�.\n�ش� �۾� ������ �Ŀ� �ű� �۾��� �Ͻñ� �ٶ��ϴ�.");
                document.getElementById("txtENO_NM").focus();
                return;
            }

            fnc_Clear();
            dsT_ME_PERSON.ClearData();

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_PERSON.AddRow();

            // ���� �ʱ�ȭ�� ȣ��
            fnc_ClickTab(1);

            // KEY �ʵ�� �űԽ� �Է� ����
            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("cmbBIR_TAG").value = 'S';

            fnc_ColEnabled('E');

            form1.txtENO_NM.focus();
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

            document.getElementById("txtENO_NO").value    = '';
            document.getElementById("txtENO_NM").value    = '';
            document.getElementById("txtNAM_CHI").value   = '';
            document.getElementById("txtBIR_YMD").value   = '';
            document.getElementById("txtAGE").value       = '';
            document.getElementById("cmbBIR_TAG").value   = '';
            document.getElementById("txtNAM_ENG").value   = '';
            document.getElementById("txtCET_NO").value    = '';
            document.getElementById("cmbMF_TAG").value    = '';
            document.getElementById("txtHIR_YMD").value   = '';
            document.getElementById("txtHEAD_CD").value   = '';
            document.getElementById("txtHEAD_NM").value   = '';
            document.getElementById("txtOCC_CD").value    = '';
            document.getElementById("txtOCC_NM").value    = '';
            document.getElementById("txtTERM1_YMD").value = '';
            document.getElementById("txtTERM2_YMD").value = '';
            document.getElementById("txtDPT_CD").value    = '';
            document.getElementById("txtDPT_NM").value    = '';
            document.getElementById("txtJOB_CD").value    = '';
            document.getElementById("txtJOB_NM").value    = '';
            document.getElementById("txtTEAM_CD").value   = '';
            document.getElementById("txtTEAM_NM").value   = '';
            document.getElementById("txtDUTY_CD").value   = '';
            document.getElementById("txtDUTY_NM").value   = '';
            document.getElementById("txtREG_CD").value    = '';
            document.getElementById("txtREG_NM").value    = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ME_PERSON.ClearData();

            for (var i = 1; i <= 11; i++) {
                document.getElementById('view_'+i).style.display='none';
            }

            document.getElementById('view_1').style.display='inline';

            // ������ �ʱ�ȭ�� ȣ��
            fnc_ViewFrame(1);
            fnc_ViewFrameTab(1);

            fnc_ColEnabled('D');

            // �̹��� �ʱ�ȭ
            var ENO_NO = '';
            var FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";

            imgBox.setImage(FILEURL);

            old_enono = "";

            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("txtENO_NM").focus();

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
            var f = document.form1;

            if (dsT_ME_PERSON.OrgNameString(dsT_ME_PERSON.RowPosition,"ENO_NO") != document.getElementById("txtENO_NO").value) {
                alert("����� ������ �� �����ϴ�!");
                document.getElementById("txtENO_NO").value = dsT_ME_PERSON.OrgNameString(dsT_ME_PERSON.RowPosition,"ENO_NO");
                document.getElementById("txtENO_NM").focus();
                return false;
            }

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ME_PERSON.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            // ��� CHECK
            if (document.getElementById("txtENO_NO").value.substr(0,1) != '8' &&
                document.getElementById("txtENO_NO").value.substr(0,1) != '9') {
                alert("��ȿ�� ����� �ƴմϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtENO_NO").focus();
                return false;
            }

            // ��������
            if (document.getElementById("txtENO_NM").value == "") {
                alert("���������� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtENO_NM").focus();
                return false;
            }

            // �������
            if (document.getElementById("txtBIR_YMD").value == "") {
                alert("��������� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtBIR_YMD").focus();
                return false;
            }

            // ������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtBIR_YMD"), '�������')) {
                document.getElementById("txtBIR_YMD").focus();
                return false;
            }

            // �ֹι�ȣ
            if (document.getElementById("txtCET_NO").value == "") {
                alert("�ֹι�ȣ�� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtCET_NO").focus();
                return false;
            }

            // �ֹι�ȣ CHECK
            if (!fnc_SsnValid(document.getElementById("txtCET_NO"))) {
                document.getElementById("txtCET_NO").focus();
                return false;
            }

            // ���� CHECK
            if ((document.getElementById("txtCET_NO").value.substr(7,1) == "1" &&  document.getElementById("cmbMF_TAG").value != "M") ||
                (document.getElementById("txtCET_NO").value.substr(7,1) == "2" &&  document.getElementById("cmbMF_TAG").value != "W")) {
                alert("�߸��� �����Դϴ�. Ȯ���Ͻñ� �ٶ��ϴ�.");
                document.getElementById("cmbMF_TAG").focus();
                return false;
            }

            // ���������
            if (document.getElementById("txtHIR_YMD").value == "") {
                alert("����������� �ʼ� �Է»����Դϴ�.");
                document.getElementById("txtHIR_YMD").focus();
                return false;
            }

            // ��������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtHIR_YMD"), '���������') && document.getElementById("txtHIR_YMD").value != "") {
                document.getElementById("txtHIR_YMD").focus();
                return false;
            }

            // 1�����Ⱓ CHECK
            if (!fnc_CheckDate(document.getElementById("txtTERM1_YMD"), '1�����Ⱓ') && document.getElementById("txtTERM1_YMD").value != "") {
                document.getElementById("txtTERM1_YMD").focus();
                return false;
            }

            // 2�����Ⱓ CHECK
            if (!fnc_CheckDate(document.getElementById("txtTERM2_YMD"), '2�����Ⱓ') && document.getElementById("txtTERM2_YMD").value != "") {
                document.getElementById("txtTERM2_YMD").focus();
                return false;
            }

            return true;
        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            imgBox = new Image(document.form1.viewImage);

            fnc_ColEnabled('D');

            // ���� �ʱ�ȭ�� ȣ��
            fnc_ClickTab(1);

            document.getElementById("txtENO_NO").disabled   = false;

            // Ÿȭ�����κ��� ȣ��� ��� �ش� ������� �İ߻�� ��ȸ
            if (dsTemp != null) {
                document.getElementById("txtENO_NO").value = dsTemp.eno_no;

                document.getElementById("ImgAddNew").disabled = true;

                fnc_SearchList();
            }
            else {

                document.getElementById("ImgAddNew").disabled = false;

            }

            document.getElementById("txtENO_NM").focus();
        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_ME_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            if (dsTemp != null) {
                window.close();
            }
            else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

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

        var old_i = 0;                 // �� ��ȣ
        var old_u = 0;                 // �����ǹ�ȣ
        var old_enono = '';            // ���(��Ŭ���� ���� �Էµ� ����� ���ϱ� ����)

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtNAM_CHI").disabled  = false;
                document.getElementById("txtBIR_YMD").disabled  = false;
                document.getElementById("txtAGE").disabled      = false;
                document.getElementById("cmbBIR_TAG").disabled  = false;
                document.getElementById("txtNAM_ENG").disabled  = false;
                document.getElementById("txtCET_NO").disabled   = false;
                document.getElementById("cmbMF_TAG").disabled   = false;
                document.getElementById("txtHIR_YMD").disabled  = false;
                document.getElementById("txtHEAD_CD").disabled  = false;
                document.getElementById("txtOCC_CD").disabled   = false;
                document.getElementById("txtTERM1_YMD").disabled = false;
                document.getElementById("txtTERM2_YMD").disabled = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtJOB_CD").disabled   = false;
                document.getElementById("txtTEAM_CD").disabled  = false;
                document.getElementById("txtREG_CD").disabled   = false;

                document.getElementById("ImgBirYmd").disabled  = false;
                document.getElementById("ImgHirYmd").disabled  = false;
                document.getElementById("ImgTerm1Ymd").disabled = false;
                document.getElementById("ImgTerm2Ymd").disabled = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtNAM_CHI").disabled  = true;
                document.getElementById("txtBIR_YMD").disabled  = true;
                document.getElementById("txtAGE").disabled      = true;
                document.getElementById("cmbBIR_TAG").disabled  = true;
                document.getElementById("txtNAM_ENG").disabled  = true;
                document.getElementById("txtCET_NO").disabled   = true;
                document.getElementById("cmbMF_TAG").disabled   = true;
                document.getElementById("txtHIR_YMD").disabled  = true;
                document.getElementById("txtHEAD_CD").disabled  = true;
                document.getElementById("txtOCC_CD").disabled   = true;
                document.getElementById("txtTERM1_YMD").disabled = true;
                document.getElementById("txtTERM2_YMD").disabled = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtJOB_CD").disabled   = true;
                document.getElementById("txtTEAM_CD").disabled  = true;
                document.getElementById("txtREG_CD").disabled   = true;

                document.getElementById("ImgBirYmd").disabled  = true;
                document.getElementById("ImgHirYmd").disabled  = true;
                document.getElementById("ImgTerm1Ymd").disabled = true;
                document.getElementById("ImgTerm2Ymd").disabled = true;

            }

        }

        /*********************************
         * �ǹ�ư Ŭ���� �ش� ȭ�� ȣ��  *
         *********************************/
        function fnc_ClickTab(i) {
            var ENO_NO = document.getElementById('txtENO_NO').value;

            if (ENO_NO == "" && i != 1 && i != 11) {
                alert("����� �Է��Ͽ� ȭ���� ��ȸ�Ͻ� �Ŀ� �۾��Ͻñ� �ٶ��ϴ�.");
                return;
            }

            if (dsT_ME_PERSON.CountRow < 1 && i != 1 && i != 11) {
                alert("�Է��Ͻ� ������� ȭ���� ��ȸ�Ͻ� �Ŀ� �۾��Ͻñ� �ٶ��ϴ�.");
                return;
            }

            if (dsT_ME_PERSON.RowStatus(dsT_ME_PERSON.RowPosition) == 1 && i != 1) {
                alert("�ű��۾��� ��� ȭ���� ���� �����Ͻ� �Ŀ� �۾��Ͻñ� �ٶ��ϴ�..");
                return;
            }

            fnc_ViewFrame(i);

        }

        /********************************************
         * ��ȭ�� ȣ��� ���� jsp ������ �ѷ��ش�.  *
         ********************************************/
        function fnc_ViewFrame(i) {

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var iframe = document.getElementById("iframe_"+i);

            // ������ �ٸ� ���� Ŭ���� ��� ����ȭ���� ������ �ʰ�, ���ο� ȭ���� ����
            if (old_i != i && old_i != 0) {

                document.getElementById('view_'+old_i).style.display='none';
            }

            document.getElementById('view_'+i).style.display='inline';

            if (i != 1) {

                if (iframe.src == "about:blank") {

                    // ��������� ����/�İ߻���������� �� �Ѱ���
                    if (i != 11) {
                        iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
                    }
                    else {
                        iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO+"&srcid=mema010";
                    }

                }
                else {

                    // ����� ����Ǵ� ��� ���� �������� ���� ������ �ٽ� �������� ����
                    //if (iframe.contentWindow.document.getElementById("ENO_NO").value != ENO_NO) {

                        iframe.contentWindow.document.getElementById("ENO_NO").value = ENO_NO;

                        if (i != 11) {
                            iframe.contentWindow.fnc_SearchList();
                        }

                    //}
                }
            }
            else {

                fnc_ViewFrameTab(1);

            }

            old_i=i;
            old_enono = ENO_NO;

        }

        /*******************************************************
         * ��ȭ����� ������ ȣ��� ���� jsp ������ �ѷ��ش�.  *
         *******************************************************/
        function fnc_ViewFrameTab(u) {

            var ENO_NO = document.getElementById("txtENO_NO").value;
            var iframe = document.getElementById("iframe_tab_"+u);

            // ������ �ٸ� ���� Ŭ���� ��� ����ȭ���� ������ �ʰ�, ���ο� ȭ���� ����
            if (old_u != u && old_u != 0) {

                document.getElementById('view_tab_'+old_u).style.display='none';
            }

            document.getElementById('view_tab_'+u).style.display='inline';

            if (iframe.src == "about:blank") {

              iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
            }
            else {

                // ����� ����Ǵ� ��� ���� �������� ���� ������ �ٽ� �������� ����
                if (iframe.contentWindow.document.getElementById("ENO_NO").value != ENO_NO) {

                    iframe.contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                    iframe.contentWindow.fnc_SearchList();


                }else if(u == "1"){//�λ�⺻2�� �İ����� ������ ������ �ٽ���ȸ
					iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
                }
            }

            old_u=u;

            document.getElementById("resultMessage").innerText = ' ';

        }

        /*************************************************************************
         * ������ ���ε� ���丮�� �̹����� �ѷ��ִ� User Defined Object
         * - usage : var obj = new Image(�̹����ױ���ID);
         *               obj.setImage("������ �̹��������� ��ġ�� ���ϸ�");
         *************************************************************************/
        function Image(imgTag) {
            var imgTag = imgTag;
            var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
            var imgUrl = "";

            this.setImage = function(imgBox) {
                imgUrl = imgBox;
                imgTag.src = action + "&IMAGE=" +imgUrl;
            }

        }

        /********************************************************************
         * ��ȸ�� ȭ�鿡�� ��� ����� ����� ����� ���� ������ ��ȸ�ؿ�
         ********************************************************************/
        function fnc_chkEnoNo() {

            if (dsT_ME_PERSON.CountRow > 0) {
                if (document.getElementById("txtENO_NO").value  == "") {
                    fnc_Clear();
                    return;
                }

                if (document.getElementById("txtENO_NO").value != dsT_ME_PERSON.OrgNameValue(1, "ENO_NO")) {
                    fnc_SearchList();
                }
            }
        }

        /********************************************************************
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         ********************************************************************/
        function fnc_ClickEmpPopup() {

            fnc_empl3Popup('txtENO_NO','txtENO_NM','','','','','2');

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchList();
            }

        }

        function fnc_UsrGetEnoNo() {

            if (document.getElementById("txtENO_NM").value  == "") {

                fnc_Clear();
                return;
            }

            // �İ߻�� ��ü
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO', '2');

            if (document.getElementById("txtENO_NO").value  == "") {

                fnc_Clear();
                return;
            }
            else {

                fnc_SearchList();
            }
        }


        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("�߸��� �ֹι�ȣ�Դϴ�. Ȯ�ιٶ��ϴ�.");
                    return false;
                }
            }

            return true;
        }

        function fnc_setMfTag() {

            // ������ ������ ���
            if (document.getElementById("txtCET_NO").value.substr(7,1) == '1') {
                dsT_ME_PERSON.NameValue(1, "MF_TAG") = 'M';
            }
            // ������ ������ ���
            else if (document.getElementById("txtCET_NO").value.substr(7,1) == '2') {
                dsT_ME_PERSON.NameValue(1, "MF_TAG") = 'W';
            }
        }

        function fnc_TabSave() {
            var ENO_NO = document.getElementById('txtENO_NO').value;
            var tmp_i = 0;
            var tmp_u = 0;
            var Msg = '';

            Msg = document.getElementById("resultMessage").innerText;

            tmp_i = old_i;
            tmp_u = old_u;

            if (old_i != 1) {

                fnc_ViewFrame(1);
            }

            // �λ�⺻2, 3, 4  ������� ����� ����
            for (var k = 1; k <= 3; k++) {
                var iTabframe = document.getElementById('iframe_tab_'+k);

                if (iTabframe.src != "about:blank") {

                    if (iTabframe.contentWindow.document.getElementById("ENO_NO").value == ENO_NO) {

                        fnc_ViewFrameTab(k);

                        if (!iTabframe.contentWindow.fnc_Save()) {

                            old_u = k;
                            return;
                        }
                    }
                }
            }

            if (tmp_i != 1) {
                fnc_ViewFrame(tmp_i);
            }
            else {
                fnc_ViewFrameTab(tmp_u);
            }

            if (savflag == '1') {
                fnc_Message(document.getElementById("resultMessage"), "MSG_01");
                savflag = '';
            }
            else {
                document.getElementById("resultMessage").innerText = Msg;
            }

            old_i = tmp_i;
            old_u = tmp_u;
        }

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ME_AHISTORY                     |
    | 3. Table List : T_ME_AHISTORY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">

        var ENO_NO  = "";
        var FILEURL = "";

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_PERSON.CountRow);

        }

        ENO_NO = dsT_ME_PERSON.NameValue(1, "ENO_NO");
        FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";

        imgBox.setImage(FILEURL);

        document.getElementById("txtENO_NO").disabled = false;
        document.getElementById("txtENO_NM").focus();

        if (old_i == 0) {
            return;
        }

        // ���� ���� �⺻������ ���
        if (old_i == 1) {

            document.getElementById("iframe_tab_"+old_u).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
            document.getElementById("iframe_tab_"+old_u).contentWindow.fnc_SearchList();

            if (iCount > 0) {
                document.getElementById("resultMessage").innerText = '';
            }

            // ��� �ʱ�ȭ
            for (i = 1; i <= 3; i++) {

                if (i != old_u && document.getElementById("iframe_tab_"+i).src != "about:blank") {

                    document.getElementById("iframe_tab_"+i).contentWindow.document.getElementById("ENO_NO").value = "";

                }
            }

        }
        else {

            //if (old_enono != ENO_NO) {

                document.getElementById("iframe_"+old_i).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                document.getElementById("iframe_"+old_i).contentWindow.fnc_SearchList();
            //}

        }

        if (old_enono != ENO_NO) {
            old_enono = ENO_NO;
        }

    </Script>

    <Script For=dsT_ME_AHISTORY Event="OnLoadCompleted(iCount)">

		if (iCount == 0) {

			if(ahiflag == "SAV"){
				alert("������ �Ϸ�Ǿ����ϴ�. �Ի��İ���� �Է����ּ���.");
			}else if(ahiflag == "SHR"){
				alert("�Ի��İ���� �����ϴ�. �Ի��İ���� �Է����ּ���.");
			}
			ahiflag = "";

			fnc_ClickTab(7);

		} else {

		}

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_ME_AHISTORY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_TabSave();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�λ�������</td>
                    <td align="right" class="navigator">HOME/�λ����/�İ߻��/<font color="#000000">�λ�������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="140"></col>
                    <col width="90 "></col>
                    <col width="140"></col>
                </colgroup>
                <tr>
                    <td class="padding2423" colspan="7">
                        <!-- �� ��ư ���̺� ���� -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <tr>
                                <td>
                                    <input type=button id="btnMEMA011" value="�⺻����"         style="width:80pt;" onclick="fnc_ClickTab(1)">
                                    <input type=button id="btnMEMA015" value="�з»���"         style="width:80pt;" onclick="fnc_ClickTab(2)">
                                    <!-- <input type=button id="btnMEMA023" value="��������"         style="width:49pt;" onclick="fnc_ClickTab(3)"> -->
                                    <!-- <input type=button id="btnMEMA016" value="��������"         style="width:49pt;" onclick="fnc_ClickTab(4)"> -->
                                    <!-- <input type=button id="btnMEMA017" value="�ڰݸ���"         style="width:49pt;" onclick="fnc_ClickTab(5)"> -->
                                    <!-- <input type=button id="btnMEMA018" value="�Ի������"       style="width:52pt;" onclick="fnc_ClickTab(6)"> -->
                                    <input type=button id="btnMEMA019" value="�Ի��İ��"       style="width:80pt;" onclick="fnc_ClickTab(7)">
                                    <input type=button id="btnMEMA020" value="�뿪�񺯰�"       style="width:80pt;" onclick="fnc_ClickTab(8)">
                                    <input type=button id="btnMEMA021" value="��������"         style="width:80pt;" onclick="fnc_ClickTab(9)">
                                    <input type=button id="btnMEMA022" value="��ຯ��"         style="width:80pt;" onclick="fnc_ClickTab(10)">
                                    <input type=button id="btnPIRA032" value="�������"         style="width:80pt;" onclick="fnc_ClickTab(11)">
                                </td>
                            <tr>
                        </table>
                        <!-- �� ��ư ���̺� �� -->
                    </td>
                </tr>
                <tr>
                    <td align="center" rowspan="7"><img id="viewImage" src="init" border="0" width="125" height="167" onerror="this.src='/images/common/none.jpg';"></td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="8" style="width:100%;ime-mode:disabled" onChange="fnc_chkEnoNo();" onKeyPress="JavaScript: cfNumberCheck();if (event.keyCode == 13) {document.getElementById('btnMEMA011').focus(); fnc_SearchList();}">
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" maxlength="12" style="width:78%; ime-mode: active" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_UsrGetEnoNo();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                    </td>
                    <td align="center" class="creamBold">���ڼ���</td>
                    <td class="padding2423">
                        <input id="txtNAM_CHI" maxlength="12" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                        <input id="txtBIR_YMD" style="width:51%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�������');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBirYmd" name="ImgBirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBIR_YMD','','145','125');"></a>
                        <input id="txtAge" style="width:14%" class="input_ReadOnly" readonly>��
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <select id="cmbBIR_TAG" style="width:100%" >
                            <option value="S">���</option>
                            <option value="M" >����</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtNAM_ENG" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ֹι�ȣ</td>
                    <td class="padding2423">    <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onChange="javascript : if (fnc_SsnValid(this) == true) {fnc_setMfTag();}"></td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <select id="cmbMF_TAG" style="width:100%" >
                            <option value="M">����</option>
                            <option value="W" >����</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">���������</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '���������');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onkeydown="if(event.keyCode==9){form1.txtTERM1_YMD.focus();event.returnValue=false;}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirYmd" name="ImgHirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIR_YMD','','630','150');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHEAD_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtHEAD_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtOCC_CD" name="txtOCC_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtOCC_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">1�����Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtTERM1_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '1�����Ⱓ');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onkeydown="if(event.keyCode==9){form1.txtTERM2_YMD.focus();event.returnValue=false;}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTerm1Ymd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTerm1Ymd" name="ImgTerm1Ymd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTERM1_YMD','','630','175');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtDPT_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtJOB_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">2�����Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtTERM2_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '2�����Ⱓ');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTerm2Ymd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTerm2Ymd" name="ImgTerm2Ymd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTERM2_YMD','','630','205');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtTEAM_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtTEAM_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;å</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtDUTY_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREG_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtREG_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- �⺻���� ���� -->
<div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:none">
<table width="800" height="285" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    <tr><td align="center">
        <!-- �� ��ư ���̺� ���� -->
        <table width="796" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop5">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <tr>
                            <td align="left">
                                <input type=button id="btn1" value="�λ�⺻2"      onclick="fnc_ViewFrameTab(1)">
                                <input type=button id="btn2" value="�λ�⺻3"      onclick="fnc_ViewFrameTab(2)">
                                <input type=button id="btn3" value="�λ�⺻4"      onclick="fnc_ViewFrameTab(3)">
                                <input type=hidden id="ENO_NO" size="10">
                            </td>
                        <tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- �� ��ư ���̺� �� -->

        <!-- �λ�⺻2 ���� -->
        <div id="view_tab_1" style="width:796;height:254;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_1" src="about:blank" load_src="/hr/mem/mema011.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- �λ�⺻2 �� -->

        <!-- �λ�⺻3 ���� -->
        <div id="view_tab_2" style="width:796;height:254;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_2" src="about:blank" load_src="/hr/mem/mema012.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- �λ�⺻3 �� -->

        <!-- �λ�⺻4 ���� -->
        <div id="view_tab_3" style="width:796;height:254;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_3" src="about:blank" load_src="/hr/mem/mema013.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- �λ�⺻4 �� -->

    </td></tr>
</table>
</div>
<!-- �λ�⺻2 �� -->

<!-- �з»��� ���� -->
<div id="view_2" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_2" src="about:blank" load_src="/hr/mem/mema014.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �з»��� �� -->

<!-- �������� ���� -->
<div id="view_3" style="width:800;height:100;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_3" src="about:blank" load_src="/hr/mem/mema015.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �з»��� �� -->

<!-- �������� ���� -->
<div id="view_4" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_4" src="about:blank" load_src="/hr/mem/mema016.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �������� �� -->

<!-- �ڰݸ��� ���� -->
<div id="view_5" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_5" src="about:blank" load_src="/hr/mem/mema017.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �ڰݸ��� �� -->

<!-- �Ի������ ���� -->
<div id="view_6" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_6" src="about:blank" load_src="/hr/mem/mema018.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �Ի������ �� -->

<!-- �Ի��İ�� ���� -->
<div id="view_7" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_7" src="about:blank" load_src="/hr/mem/mema019.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �Ի��İ�� �� -->

<!-- �뿪�񺯰泻�� ���� -->
<div id="view_8" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_8" src="about:blank" load_src="/hr/mem/mema020.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- �뿪�񺯰泻�� �� -->

<!-- ������������ ���� -->
<div id="view_9" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_9" src="about:blank" load_src="/hr/mem/mema021.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- ������������ �� -->

<!-- ��ຯ�泻�� ���� -->
<div id="view_10" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_10" src="about:blank" load_src="/hr/mem/mema022.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- ��ຯ�泻�� �� -->

<!-- ������� ���� -->
<div id="view_11" style="width:800;height:294;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_11" src="about:blank" load_src="/hr/pir/pira032.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- ������� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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
<!-- �޼����������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO         Ctrl=txtENO_NO      Param=value Disable=disabled</C>
        <C>Col=ENO_NM         Ctrl=txtENO_NM      Param=value </C>
        <C>Col=NAM_CHI        Ctrl=txtNAM_CHI     Param=value </C>
        <C>Col=BIR_YMD        Ctrl=txtBIR_YMD     Param=value </C>
        <C>Col=AGE            Ctrl=txtAGE         Param=value </C>
        <C>Col=BIR_TAG        Ctrl=cmbBIR_TAG     Param=value </C>
        <C>Col=NAM_ENG        Ctrl=txtNAM_ENG     Param=value </C>
        <C>Col=CET_NO         Ctrl=txtCET_NO      Param=value </C>
        <C>Col=MF_TAG         Ctrl=cmbMF_TAG      Param=value </C>
        <C>Col=HIR_YMD        Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=HEAD_CD        Ctrl=txtHEAD_CD     Param=value </C>
        <C>Col=HEAD_NM        Ctrl=txtHEAD_NM     Param=value </C>
        <C>Col=OCC_CD         Ctrl=txtOCC_CD      Param=value </C>
        <C>Col=OCC_NM         Ctrl=txtOCC_NM      Param=value </C>
        <C>Col=TERM1_YMD      Ctrl=txtTERM1_YMD   Param=value </C>
        <C>Col=TERM2_YMD      Ctrl=txtTERM2_YMD   Param=value </C>
        <C>Col=DPT_CD         Ctrl=txtDPT_CD      Param=value </C>
        <C>Col=DPT_NM         Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_CD         Ctrl=txtJOB_CD      Param=value </C>
        <C>Col=JOB_NM         Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=TEAM_CD        Ctrl=txtTEAM_CD     Param=value </C>
        <C>Col=TEAM_NM        Ctrl=txtTEAM_NM     Param=value </C>
        <C>Col=DUTY_CD        Ctrl=txtDUTY_CD     Param=value </C>
        <C>Col=DUTY_NM        Ctrl=txtDUTY_NM     Param=value </C>
        <C>Col=REG_CD         Ctrl=txtREG_CD      Param=value </C>
        <C>Col=REG_NM         Ctrl=txtREG_NM      Param=value </C>
    '>
</object>