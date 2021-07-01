<!--
*****************************************************
* @source       : vluf061.jsp
* @description : HRMS PAGE :: ���������_���
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/24     ���뼺        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<% String title = request.getParameter("TITLE"); %>

<head>
<title><%=title%>(vluf061)</title>
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

		var btnList = 'FFTFFFFT';
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			dsT_EV_DUTYSUB.ClearData();
			var temp = dsT_EV_DUTYSUB.dataid;	// importdata�� �� �� DataSet�� ������ dataid �Ӽ����� �������� ���� ����.
			//dsT_EV_DUTYSUB_01���� dsT_EV_DUTYSUB_07������ �����ͼ� �� �����Ͱ� �ִ� ������ ���� ���� dsT_EV_DUTYSUB �� ��´�.
			for(i=1;i<8;i++) {
				if(eval("dsT_EV_DUTYSUB_0"+i+".CountRow")>0) {
					eval("dsT_EV_DUTYSUB.ImportData(dsT_EV_DUTYSUB_0"+i+".ExportData(1, dsT_EV_DUTYSUB_0"+i+".CountRow, true));");
				}
			}//end for
			dsT_EV_DUTYSUB.dataid = temp;

			trT_EV_DUTYSUB.KeyValue = "tr01(I:dsT_EV_DUTYSUB=dsT_EV_DUTYSUB, I:dsT_EV_DUTYDESC=dsT_EV_DUTYDESC)";
			trT_EV_DUTYSUB.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf061.cmd.VLUF061CMD&S_MODE=SAV&DUTY_NO="+document.getElementById('cmbDUTY_NO').value+"&DUTY_CD="+document.getElementById('txtDUTY_CD').value;
			trT_EV_DUTYSUB.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete(gubun) {

			if(gubun == '1'){
				if(dsT_EV_DUTYSUB_01.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("��������["+dsT_EV_DUTYSUB_01.NameValue(dsT_EV_DUTYSUB_01.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_01.DeleteRow(dsT_EV_DUTYSUB_01.RowPosition);
				}
			} else if(gubun == '2'){
				if(dsT_EV_DUTYSUB_02.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("�䱸����["+dsT_EV_DUTYSUB_02.NameValue(dsT_EV_DUTYSUB_02.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_02.DeleteRow(dsT_EV_DUTYSUB_02.RowPosition);
				}
			} else if(gubun == '3'){
				if(dsT_EV_DUTYSUB_03.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("�䱸���["+dsT_EV_DUTYSUB_03.NameValue(dsT_EV_DUTYSUB_03.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_03.DeleteRow(dsT_EV_DUTYSUB_03.RowPosition);
				}
			} else if(gubun == '4'){
				if(dsT_EV_DUTYSUB_04.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("�䱸����["+dsT_EV_DUTYSUB_04.NameValue(dsT_EV_DUTYSUB_04.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_04.DeleteRow(dsT_EV_DUTYSUB_04.RowPosition);
				}
			} else if(gubun == '5'){
				if(dsT_EV_DUTYSUB_05.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("�䱸���["+dsT_EV_DUTYSUB_05.NameValue(dsT_EV_DUTYSUB_05.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_05.DeleteRow(dsT_EV_DUTYSUB_05.RowPosition);
				}
			} else if(gubun == '6'){
				if(dsT_EV_DUTYSUB_06.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("�ʿ䱳������["+dsT_EV_DUTYSUB_06.NameValue(dsT_EV_DUTYSUB_06.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_06.DeleteRow(dsT_EV_DUTYSUB_06.RowPosition);
				}
			} else if(gubun == '7'){
				if(dsT_EV_DUTYSUB_07.CountRow < 1) {
					alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
					return;
				}
				if(confirm("�ڰ���["+dsT_EV_DUTYSUB_07.NameValue(dsT_EV_DUTYSUB_07.RowPosition,'SEQ_NO')+"]�� �����͸� �����Ͻðڽ��ϱ�?")){
					dsT_EV_DUTYSUB_07.DeleteRow(dsT_EV_DUTYSUB_07.RowPosition);
				}
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

			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew(gubun) {

			eval("dsT_EV_DUTYSUB_0"+gubun+".AddRow()");
			eval("dsT_EV_DUTYSUB_0"+gubun+".NameValue(dsT_EV_DUTYSUB_0"+gubun+".RowPosition,'CONTENTS_GBN')="+gubun);

			eval("document.form1.grdT_EV_DUTYSUB_0"+gubun+".SetColumn('ITEM_01');");

			if(gubun == '1'){
				document.form1.txtITEM_01.focus();
			}

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_EV_DUTYDESC.IsUpdated || dsT_EV_DUTYSUB_01.IsUpdated || dsT_EV_DUTYSUB_02.IsUpdated || dsT_EV_DUTYSUB_03.IsUpdated || dsT_EV_DUTYSUB_04.IsUpdated || dsT_EV_DUTYSUB_05.IsUpdated || dsT_EV_DUTYSUB_06.IsUpdated || dsT_EV_DUTYSUB_07.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			window.close();

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

			if('<%=title%>' != '���������_���') return false;

			var form = document.form1;

			if ( form.cmbDUTY_NO.value == "" ) {
				alert("����ȸ���� �ʼ� �Է� �׸��Դϴ�.");
				form.cmbDUTY_NO.focus();
				return false;
			}
			if ( form.txtDUTY_CD.value == "" ) {
				alert("������ �ʼ� �Է� �׸��Դϴ�.");
				return false;
			}

			// ���������� ���� ��ȿ�� �˻�
			if( dsT_EV_DUTYSUB_01.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_01.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '�ֿ����'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]�� '����'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_03") == "") {
						alert("["+i+"]�� '�߿䵵'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_01.NameValue(i,"ITEM_04") == "") {
						alert("["+i+"]�� '���ΰ���'�� �ʼ� �Է»����Դϴ�.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_02.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_02.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_02.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '�䱸����'�� �ʼ� �Է»����Դϴ�.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_03.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_03.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_03.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '�䱸���'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_03.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]�� '������'�� �ʼ� �Է»����Դϴ�.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_04.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_04.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_04.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '�䱸����'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_04.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]�� '����'�� �ʼ� �Է»����Դϴ�.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_05.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_05.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_05.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '�䱸���'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_05.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]�� '����'�� �ʼ� �Է»����Դϴ�.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_06.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_06.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_06.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '����������'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_06.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]�� '�����Ʒñ��'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_06.NameValue(i,"ITEM_03") == "") {
						alert("["+i+"]�� '�ҿ�ð�'�� �ʼ� �Է»����Դϴ�.");
						return false;
					}
				}
			}
			if( dsT_EV_DUTYSUB_07.CountRow > 0 ) {
				for(i=1;i<dsT_EV_DUTYSUB_07.CountRow+1;i++){
					if(dsT_EV_DUTYSUB_07.NameValue(i,"ITEM_01") == "") {
						alert("["+i+"]�� '�ڰ���'�� �ʼ� �Է»����Դϴ�.");
						return false;
					} else if (dsT_EV_DUTYSUB_07.NameValue(i,"ITEM_02") == "") {
						alert("["+i+"]�� '�������'�� �ʼ� �Է»����Դϴ�.");
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

			cfStyleGrid(form1.grdT_EV_DUTYSUB_01,0,"false","false");     // Grid Style ����
			cfStyleGrid(form1.grdT_EV_DUTYSUB_02,0,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_EV_DUTYSUB_03,0,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_EV_DUTYSUB_04,0,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_EV_DUTYSUB_05,0,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_EV_DUTYSUB_06,0,"true","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_EV_DUTYSUB_07,0,"true","false");      // Grid Style ����

			var dsTemp = window.dialogArguments;

			if(dsTemp.CountRow>0){
				cfCopyDataSet(dsTemp, dsT_EV_DUTYDESC, "copyHeader=yes,rowFrom=1,rowCnt=1");
			} else {
				cfCopyDataSetHeader(dsTemp, dsT_EV_DUTYDESC);
				dsT_EV_DUTYDESC.AddRow();
			}

			//���۽� ����ȸ���� �������� ���� VLUF020CMD�� ���
			ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
			ds01T_EV_DUTYBAS.Reset();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*************************************************
         * 16. ����, ����, ���� �� �����ڵ� ��ȸ�� �˾�  *
         ************************************************/
		function fnc_dutyPopup(ctrl_01, ctrl_02, ctrl_03, ctrl_04) {

			var obj = new String();

			window.showModalDialog("/common/popup/duty.jsp", obj, "dialogWidth:368px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.duty_cd != ''){
				document.getElementById(ctrl_01).value = obj.thr_nm;
				document.getElementById(ctrl_02).value = obj.sec_nm;
				document.getElementById(ctrl_03).value = obj.duty_nm;
				document.getElementById(ctrl_04).value = obj.duty_cd;
			}

		}


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------+
    | 1. ��ȸ �� ����� DataSet          |
    | 2. �̸� : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. ��ȸ�� DataSet                  |
    | 2. �̸� : ds01T_EV_DUTYBAS         |
    | 3. Table List : T_EV_DUTYBAS       |
    +------------------------------------>
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!---------------------------------+
    | 1. ��ȸ �� ����� DataSet        |
    | 2. �̸� : dsT_EV_DUTYSUB         |
    | 3. Table List : T_EV_DUTYSUB     |
    +---------------------------------->
    <Object ID="dsT_EV_DUTYSUB_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!---------------------------------+
    | 1. ��ȸ �� ����� DataSet        |
    | 2. �̸� : dsT_EV_DUTYSUB         |
    | 3. Table List : T_EV_DUTYSUB     |
    +---------------------------------->
    <Object ID="dsT_EV_DUTYSUB_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. ��ȸ �� ����� DataSet          |
    | 2. �̸� : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. ��ȸ �� ����� DataSet          |
    | 2. �̸� : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------+
    | 1. ��ȸ �� ����� DataSet          |
    | 2. �̸� : dsT_EV_DUTYSUB           |
    | 3. Table List : T_EV_DUTYSUB       |
    +------------------------------------>
    <Object ID="dsT_EV_DUTYSUB_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------+
    | 1. ��ȸ �� ����� DataSet         |
    | 2. �̸� : dsT_EV_DUTYSUB          |
    | 3. Table List : T_EV_DUTYSUB      |
    +----------------------------------->
    <Object ID="dsT_EV_DUTYSUB_06" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------+
    | 1. ��ȸ �� ����� DataSet         |
    | 2. �̸� : dsT_EV_DUTYSUB          |
    | 3. Table List : T_EV_DUTYSUB      |
    +----------------------------------->
    <Object ID="dsT_EV_DUTYSUB_07" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------------+
    | 1. ����� DataSet							          |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DUTYRSH)	      |
    | 3. ���Ǵ� Table List(T_EV_DUTYRSH, T_CM_DUTYMST)  |
    +----------------------------------------------------->
    <Object ID="dsT_EV_DUTYDESC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton          |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)     |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)            |
    +------------------------------------------------->
    <Object ID ="trT_EV_DUTYSUB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST)">
    </Object>


	<!--*******************************************
    *                                             *
    *  Component���� �߻��ϴ� Event ó����        *
    *                                             *
    ********************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYSUB Event="OnLoadCompleted(iCount)">
        if (iCount < 1) {
			// dsT_EV_DUTYSUB_01���� dsT_EV_DUTYSUB_07������ DataSet�� ����� �����Ѵ�.
			var header = "GUBUN:STRING, DUTY_NO:INT, ENO_NO:STRING, DUTY_CD:STRING, RESEARCH_GBN:STRING, CONTENTS_GBN:STRING:KEYVALUETYPE, SEQ_NO:INT:KEYVALUETYPE, ITEM_01:STRING:NOTNULL, ITEM_02:STRING, ITEM_03:STRING, ITEM_04:STRING, ITEM_05:STRING";

			for(k=1;k<8;k++) {
				eval("dsT_EV_DUTYSUB_0"+k+".setDataHeader(header);");
			}

        } else {

			//dsT_EV_DUTYSUB���� SEQ_NO���� ������ġ�� ������ ���Ѵ�.
			for(j=1;j<8;j++) {
				//DataSet Copy�� ���� ���� ���� ����
				eval("rowFrom"+j+"= 0");
				eval("rowCnt"+j+"= 0");
				for(i=1;i<iCount+1;i++) {
					if(dsT_EV_DUTYSUB.NameValue(i,'CONTENTS_GBN') == j) {
						if(eval("rowFrom"+j) == 0) eval("rowFrom"+j+"="+i);
						eval("rowCnt"+j+"++");
					}
				}
			}
			// SEQ_NO���� ������ �����ͼ¿� �ش��ϴ� �����͸� �����Ѵ�.
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_01, "copyHeader=yes,rowFrom="+rowFrom1+",rowCnt="+rowCnt1);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_02, "copyHeader=yes,rowFrom="+rowFrom2+",rowCnt="+rowCnt2);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_03, "copyHeader=yes,rowFrom="+rowFrom3+",rowCnt="+rowCnt3);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_04, "copyHeader=yes,rowFrom="+rowFrom4+",rowCnt="+rowCnt4);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_05, "copyHeader=yes,rowFrom="+rowFrom5+",rowCnt="+rowCnt5);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_06, "copyHeader=yes,rowFrom="+rowFrom6+",rowCnt="+rowCnt6);
			cfCopyDataSet(dsT_EV_DUTYSUB, dsT_EV_DUTYSUB_07, "copyHeader=yes,rowFrom="+rowFrom7+",rowCnt="+rowCnt7);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYSUB Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYSUB Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            alert("���� ���� ������ ������ ȸ���� �����ϴ�.");
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			var i;
			var oOption;

			//�˻����� �޺��ڽ��� ����ȸ���� ����
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO")+"ȸ��";
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO").add(oOption);
        	}

			if(dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO') != '') {

				//����ȸ��
//				document.getElementById("cmbDUTY_NO")[dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO')-1].selected = true;
				for(i=1; i <= iCount; i++){
					if(dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO') == ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO")){
						document.getElementById("cmbDUTY_NO")[i-1].selected = true;
					}
				}
				document.getElementById('cmbDUTY_NO').disabled = 'disabled';
				document.getElementById('cmbDUTY_NO').style.backgroundColor = 'EEEEEE';

				//���� ���缭 ���� Item ���� ��ȸ
				dsT_EV_DUTYSUB.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf061.cmd.VLUF061CMD&S_MODE=SHR&DUTY_NO="+dsT_EV_DUTYDESC.NameValue(1,'DUTY_NO')+"&DUTY_CD="+dsT_EV_DUTYDESC.NameValue(1,'DUTY_CD');
				dsT_EV_DUTYSUB.reset();

			} else {

				//header ����
				var header = "GUBUN:STRING, DUTY_NO:INT, ENO_NO:STRING, DUTY_CD:STRING, RESEARCH_GBN:STRING, CONTENTS_GBN:STRING:KEYVALUETYPE, SEQ_NO:INT:KEYVALUETYPE, ITEM_01:STRING:NOTNULL, ITEM_02:STRING, ITEM_03:STRING, ITEM_04:STRING, ITEM_05:STRING";

				dsT_EV_DUTYSUB.setDataHeader(header);
				for(k=1;k<8;k++) {
					eval("dsT_EV_DUTYSUB_0"+k+".setDataHeader(header);");
				}

				//���� �˻� ��ư ���÷���
				document.all["duty"].style.display = "";

				document.form1.cmbDUTY_NO.focus();

			}
        }

		var title = '<%=title%>';
		if(title != '���������_���'){
			document.getElementById('save_btn').style.display = 'none';
			document.getElementById('searchDay').style.display = 'none';
			document.getElementById('button1').style.display = 'none';
			document.getElementById('button2').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button3').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button4').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button5').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button6').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			document.getElementById('button7').innerHTML = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';

			document.getElementById('txtDUTY_YMD').readOnly = true;
			document.getElementById('txtDUTY_YMD').className="input_ReadOnly";
			document.getElementById('txtDUTY_OBJ').readOnly = true;
			document.getElementById('txtDUTY_OBJ').className="input_ReadOnly";
			document.getElementById('txtITEM_01').readOnly = true;
			document.getElementById('txtITEM_01').className="input_ReadOnly";
			document.getElementById('txtITEM_02').readOnly = true;
			document.getElementById('txtITEM_02').className="input_ReadOnly";
			document.getElementById('cmbITEM_03').disabled = true;
			document.getElementById('cmbITEM_03').className="input_ReadOnly";
			document.getElementById('txtITEM_04').readOnly = true;
			document.getElementById('txtITEM_04').className="input_ReadOnly";
			document.getElementById('txtSCH_LBL').readOnly = true;
			document.getElementById('txtSCH_LBL').className="input_ReadOnly";

			document.form1.grdT_EV_DUTYSUB_02.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_03.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_04.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_05.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_06.Editable = 'false';
			document.form1.grdT_EV_DUTYSUB_07.Editable = 'false';
		}
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_01 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�ֿ����/����/�߿䵵/���ΰ���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�ֿ����/����/�߿䵵/���ΰ����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_01 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_01.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_01.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_02 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�䱸����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�䱸������ ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_02 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_02.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_02.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_03 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�䱸���/������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�䱸���/�������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_03 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_03.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_03.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_04 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�䱸����/����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�䱸����/���ؿ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_04 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_04.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_04.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_05 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�䱸���/����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�䱸���/���ؿ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_05 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_05.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_05.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_06 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[����������/�����Ʒñ��/�ҿ�ð�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����������/�����Ʒñ��/�ҿ�ð��� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_06 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_06.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_06.NameValue(row-1,'SEQ_NO')) + 1;

	</script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
	<Script For=dsT_EV_DUTYSUB_07 Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�ڰ���/�������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�ڰ���/��������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------------+
	| �ش� Row�� �߰� �Ǵ� ���ԵǾ�����  |
    +------------------------------------>
	<script language=JavaScript for=dsT_EV_DUTYSUB_07 event=OnRowInserted(row)>

		dsT_EV_DUTYSUB_07.NameValue(row,'SEQ_NO') = Number(dsT_EV_DUTYSUB_07.NameValue(row-1,'SEQ_NO')) + 1;

	</script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_DUTYSUB event="OnSuccess()">
		alert("�����Ͽ����ϴ�.");
		//���� �Ŀ��� �����ͼ��� ���¸� �ʱ�ȭ�Ѵ�.
		dsT_EV_DUTYDESC.ResetStatus()
		dsT_EV_DUTYSUB_01.ResetStatus()
		dsT_EV_DUTYSUB_02.ResetStatus()
		dsT_EV_DUTYSUB_03.ResetStatus()
		dsT_EV_DUTYSUB_04.ResetStatus()
		dsT_EV_DUTYSUB_05.ResetStatus()
		dsT_EV_DUTYSUB_06.ResetStatus()
		dsT_EV_DUTYSUB_07.ResetStatus()
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_DUTYSUB event="OnFail()">
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
<input type="hidden" name="tbl1_row_cnt" value="2">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><%=title%></td>
					<td align="right" class="navigator">HOME/�λ���/��������/��������/���������/<font color="#000000"><%=title%></font></td>
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
			<span id="save_btn">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			</span>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="90"></col>
                                <col width="120"></col>
                                <col width="90"></col>
                                <col width="120"></col>
                                <col width="90"></col>
                                <col width="120"></col>
                                <col width="40"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">����ȸ��&nbsp;</td>
                                <td class="padding2423">
									<select id="cmbDUTY_NO" name="cmbDUTY_NO" style="WIDTH: 65%">
									</select>
								</td>
                                <td align="right" class="searchState">�ۼ���&nbsp;</td>
                                <td class="padding2423">
									<input id=txtDUTY_YMD name=txtDUTY_YMD size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<span id="searchDay">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image3" width="21" height="20" border="0" align="absmiddle" onClick="calendarBtn('datetype1','txtDUTY_YMD','','300','120');"></a>
									</span>
                                </td>
                                <td align="right" class="searchState"></td>
                                <td class="padding2423"></td>
								<td></td>
								<td></td>
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
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������(Job Identification)</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="110"></col>
					<col width="90"></col>
					<col width="110"></col>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id=txtTHR_NM name=txtTHR_NM style="width:100%" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id=txtSEC_NM name=txtSEC_NM style="width:100%" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id=txtDUTY_NM name=txtDUTY_NM size="25" class="input_ReadOnly" readOnly>
						<input id=txtDUTY_CD name=txtDUTY_CD size="10" class="input_ReadOnly" readOnly style="TEXT-ALIGN:center">
						<span id="duty" style="display:none;">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtTHR_NM','txtSEC_NM','txtDUTY_NM','txtDUTY_CD')"></a>
						</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������(Job Objectives)</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��������</td>
					<td class="padding2423">
	                    <textarea id=txtDUTY_OBJ name=txtDUTY_OBJ rows="3" cols="115" onkeyup="fc_chk_byte(this,800);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="50"></td>
		<td width="650"></td>
		<td width="100"></td>
	</tr>
    <tr>
        <td colspan="2" class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������(Main Tasks and Responsibilities)</strong>
		</td>
        <td align="right">
		<span id="button1">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image11" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('1');return false;"></a>&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image12" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('1');return false;"></a>
		</td>
    </tr>
	<tr>
		<td align="left" class="padding2423">
			<comment id="__NSID__">
			<object id="grdT_EV_DUTYSUB_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:60px;height:100px;">
				<param name="DataID"            value="dsT_EV_DUTYSUB_01">
                <param name="LineColor"         value="Silver">
                <param name="IndWidth"          value="0">
                <param Name="Editable"          value="false">
                <param name="Format"            value='
					<C> id=SEQ_NO	   width=40   name=����			align=center  </C>
					<C> id=ITEM_01     width=224  name=�ֿ����		align=left  Show=false  </C>
					<C> id=ITEM_02     width=88   name=����			align=center  Show=false  </C>
					<C> id=ITEM_03     width=88   name=�߿䵵		align=center  Show=false  </C>
					<C> id=ITEM_04     width=370  name=���ΰ���		align=left  Show=false  </C>
                '>
             </object>
             </comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
		<td colspan="2">
			<table id=tbl1 width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="220"></col>
					<col width="40"></col>
					<col width="40"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�ֿ����</td>
					<td align="center" class="creamBold">����</td>
					<td align="center" class="creamBold">�߿䵵</td>
					<td align="center" class="creamBold">���ΰ���</td>
				</tr>
				<tr>
					<td align="center" class="padding2423">
						<input id="txtITEM_01" name="txtITEM_01" style="width:100%" ><br><br><br><br>
					</td>
					<td align="center" class="padding2423">
						<input id="txtITEM_02" name="txtITEM_02" style="width:100%" ><br><br><br><br>
					</td>
					<td align="center" class="padding2423">
						<select id="cmbITEM_03" name="cmbITEM_03" style="width:100%">
							<option value="��" >��</option>
							<option value="��" >��</option>
							<option value="��" >��</option>
						</select><br><br><br><br>
					</td>
					<td align="center" class="padding2423">
	                    <textarea id="txtITEM_04" name="txtITEM_04" rows="4" cols="61" onkeyup="fc_chk_byte(this,500);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�������</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="150"></col>
					<col width="250"></col>
					<col width="150"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�䱸�з¼���</td>
					<td class="padding2423" colspan="3">
						<input id=txtSCH_LBL name=txtSCH_LBL style="width:200">
					</td>
				</tr>
				<tr>
					<!-- <td align="center" class="creamBold">�䱸���� -->
					<td align="right" class="creamBold" colspan="2">�䱸����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button2">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image13" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('2');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image14" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('2');return false;"></a>
					</span>
					</td>
					<td align="right" class="creamBold" colspan="2">�䱸���
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button3">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image15" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('3');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image16" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('3');return false;"></a>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_02">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=370   name=�䱸����  align=left  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_03">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=270   name=�䱸���  align=left  </C>
                                <C> id=ITEM_02     width=100   name=������  align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="right" class="creamBold" colspan="2">�䱸����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button4">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image17','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image17" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('4');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image18','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image18" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('4');return false;"></a>
					</span>
					</td>
					<td align="right" class="creamBold" colspan="2">�䱸���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button5">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image19','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image19" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('5');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image20" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('5');return false;"></a>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_04">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=270   name=�䱸����  align=left  </C>
                                <C> id=ITEM_02     width=100   name=����	  align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_05">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=270   name=�䱸���  align=left  </C>
                                <C> id=ITEM_02     width=100   name=����	  align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="right" class="creamBold" colspan="2">�ʿ䱳������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button6">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image21" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('6');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image22" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('6');return false;"></a>
					</span>
					</td>
					<td align="right" class="creamBold" colspan="2">�ڰ���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="button7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image23" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew('7');return false;"></a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image24','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image24" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete('7');return false;"></a>
					</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_06" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_06">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=150   name=����������		align=left  </C>
                                <C> id=ITEM_02     width=150   name=�����Ʒñ��	align=left  </C>
                                <C> id=ITEM_03     width=70    name=�ҿ�Ⱓ		align=left  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="padding2423" colspan="2">
						<comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSUB_07" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:390px;height:140px;">
                            <param name="DataID"            value="dsT_EV_DUTYSUB_07">
                            <param name="LineColor"         value="Silver">
                            <param name="IndWidth"          value="0">
                            <param Name="Editable"          value="true">
                            <param name="Format"            value='
                                <C> id=ITEM_01     width=170   name=�ڰ���		align=left  </C>
                                <C> id=ITEM_02     width=200   name=�������	align=left  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr height="0">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>

	<!--
	**************************************************************
	* ���ε� ������Ʈ
	**************************************************************
	-->
	<!--  ���̺� -->
	<comment id="__NSID__">
	<object id="bndT_EV_DUTYRSH" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYDESC">
		<Param Name="ActiveBind"		Value=true>
		<Param Name="BindInfo", Value='
			<C>Col=DUTY_NO        Ctrl=cmbDUTY_NO       Param=value</C>
			<C>Col=DUTY_YMD       Ctrl=txtDUTY_YMD      Param=value</C>
			<C>Col=THR_NM         Ctrl=txtTHR_NM        Param=value</C>
			<C>Col=SEC_NM         Ctrl=txtSEC_NM        Param=value</C>
			<C>Col=DUTY_NM        Ctrl=txtDUTY_NM       Param=value</C>
			<C>Col=DUTY_CD        Ctrl=txtDUTY_CD       Param=value</C>
			<C>Col=DUTY_OBJ       Ctrl=txtDUTY_OBJ      Param=value</C>
			<C>Col=SCH_LBL        Ctrl=txtSCH_LBL       Param=value</C>
	    '>
	</object>
	</comment><script> __ShowEmbedObject(__NSID__); </script>


	<!--
	**************************************************************
	* ���ε� ������Ʈ
	**************************************************************
	-->
	<!--  ���̺� -->
	<comment id="__NSID__">
	<object id="bndT_EV_DUTYLST_01" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYSUB_01">
		<Param Name="ActiveBind"		Value=true>
		<Param Name="BindInfo", Value='
			<C>Col=ITEM_01       Ctrl=txtITEM_01      Param=value</C>
			<C>Col=ITEM_02       Ctrl=txtITEM_02      Param=value</C>
			<C>Col=ITEM_03       Ctrl=cmbITEM_03      Param=value</C>
			<C>Col=ITEM_04       Ctrl=txtITEM_04      Param=value</C>
	    '>
	</object>
	</comment><script> __ShowEmbedObject(__NSID__); </script>

