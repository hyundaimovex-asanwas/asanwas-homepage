<!--
    ************************************************************************************
    * @Source         : mema013.jsp                                                    *
    * @Description    : �λ�⺻4 PAGE                                                 *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>�λ�⺻4</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if (form1.ENO_NO.value == "" || (parent.dsT_ME_PERSON.CountRow < 1 && parent.dsT_ME_PERSON.RowStatus(1) != 1)) {

                dsT_ME_FAMILY.ClearData();//��������
                dsT_ME_QUALIFICATION.ClearData();//�ڰݸ���
                dsT_ME_BHISTORY.ClearData();//�Ի������
                
                form1.grdT_ME_FAMILY.Editable = "false";
                form1.grdT_ME_QUALIFICATION.Editable = "false";
                form1.grdT_ME_BHISTORY.Editable = "false";
                
                document.getElementById("imgAppend1").disabled = true;
                document.getElementById("imgRemove1").disabled = true;
                document.getElementById("imgAppend2").disabled = true;
                document.getElementById("imgRemove2").disabled = true;
                document.getElementById("imgAppend3").disabled = true;
                document.getElementById("imgRemove3").disabled = true;

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;

            }else{
                form1.grdT_ME_FAMILY.Editable = "true";
                form1.grdT_ME_QUALIFICATION.Editable = "true";
                form1.grdT_ME_BHISTORY.Editable = "true";

	            document.getElementById("imgAppend1").disabled = false;
	            document.getElementById("imgRemove1").disabled = false;
	            document.getElementById("imgAppend2").disabled = false;
	            document.getElementById("imgRemove2").disabled = false;
	            document.getElementById("imgAppend3").disabled = false;
	            document.getElementById("imgRemove3").disabled = false;                            
            }            

            
            trT_ME_PERSON.KeyValue = "SVL(O:dsT_ME_FAMILY=dsT_ME_FAMILY, O:dsT_ME_QUALIFICATION=dsT_ME_QUALIFICATION, O:dsT_ME_BHISTORY=dsT_ME_BHISTORY)";
            trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema013.cmd.MEMA013CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            trT_ME_PERSON.post();

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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ME_FAMILY.IsUpdated && !dsT_ME_QUALIFICATION.IsUpdated && !dsT_ME_BHISTORY.IsUpdated) {
//              document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_ME_PERSON2.KeyValue = "SVL(I:dsT_ME_FAMILY=dsT_ME_FAMILY, I:dsT_ME_QUALIFICATION=dsT_ME_QUALIFICATION, I:dsT_ME_BHISTORY=dsT_ME_BHISTORY)";
                trT_ME_PERSON2.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema013.cmd.MEMA013CMD&S_MODE=SAV";
                trT_ME_PERSON2.post();

            } else {

                return false;

            }

            return true;

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
        function fnc_Append(num) {
        
            if(num == "1"){
                dsT_ME_FAMILY.AddRow();
                
                form1.grdT_ME_FAMILY.setColumn(form1.grdT_ME_FAMILY.getColumnID(0));
                
                dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
                
            }else if(num == "2"){
                dsT_ME_QUALIFICATION.AddRow();
                
                form1.grdT_ME_QUALIFICATION.setColumn(form1.grdT_ME_QUALIFICATION.getColumnID(0));
                
                dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
                
            }else if(num == "3"){
                dsT_ME_BHISTORY.AddRow();
                
                form1.grdT_ME_BHISTORY.setColumn(form1.grdT_ME_BHISTORY.getColumnID(0));
                
                dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
                
            }

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove(num) {

            if(num == "1"){
	            if (dsT_ME_FAMILY.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }
	            
	            if (confirm("����[" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"REL_NM") + "] [" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"ENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
	
	            dsT_ME_FAMILY.DeleteRow(dsT_ME_FAMILY.RowPosition);
	            
	            form1.grdT_ME_FAMILY.setColumn(form1.grdT_ME_FAMILY.getColumnID(0));
                form1.grdT_ME_FAMILY.Focus();

            }else if(num == "2"){
	            if (dsT_ME_QUALIFICATION.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }
	            
	            if (confirm("�ڰݸ���[" + dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition,"QUA_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
	            
                dsT_ME_QUALIFICATION.DeleteRow(dsT_ME_QUALIFICATION.RowPosition);

                form1.grdT_ME_QUALIFICATION.setColumn(form1.grdT_ME_QUALIFICATION.getColumnID(0));
                form1.grdT_ME_QUALIFICATION.Focus();
            
            }else if(num == "3"){
	            if (dsT_ME_BHISTORY.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }
	            
	            if (confirm("ȸ���[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"CMP_NAM") + "] �Ի���[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"STR_YMD") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
	            
                dsT_ME_BHISTORY.DeleteRow(dsT_ME_BHISTORY.RowPosition);
            
                form1.grdT_ME_BHISTORY.setColumn(form1.grdT_ME_BHISTORY.getColumnID(0));
                form1.grdT_ME_BHISTORY.Focus();

            }

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_FAMILY.ClearData();
			dsT_ME_QUALIFICATION.ClearData();
			dsT_ME_BHISTORY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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
            
            for ( i = 1; i <= dsT_ME_FAMILY.CountRow; i++ ) {
                if ( dsT_ME_FAMILY.RowStatus(i) == 1 ||
                     dsT_ME_FAMILY.RowStatus(i) == 3 ) {
                     
                    // ��������
                    if( dsT_ME_FAMILY.NameValue(i, "REL_CD") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_FAMILY.RowPosition = i;
                        return false;
                    }
                    
                    // ����
                    if( dsT_ME_FAMILY.NameValue(i, "ENO_NM") == '' ) {
                        alert("��������� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_FAMILY.RowPosition = i;
                        return false;
                    }
                     
                }
            }
            
            for ( i = 1; i <= dsT_ME_QUALIFICATION.CountRow; i++ ) {
                if ( dsT_ME_QUALIFICATION.RowStatus(i) == 1 ||
                     dsT_ME_QUALIFICATION.RowStatus(i) == 3 ) {

                    // �ڰݸ���
                    if( dsT_ME_QUALIFICATION.NameValue(i, "QUA_CD") == '' ) {
                        alert("�ڰݸ���� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        return false;
                    }
                    
                    // �������
                    /*if( dsT_ME_QUALIFICATION.NameValue(i, "GAN_YMD") == '' ) {
                        alert("������ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_QUALIFICATION.RowPosition = i;
                        return false;
                    } */                   

                }
            }
            
            for ( i = 1; i <= dsT_ME_BHISTORY.CountRow; i++ ) {
                if ( dsT_ME_BHISTORY.RowStatus(i) == 1 ||
                     dsT_ME_BHISTORY.RowStatus(i) == 3 ) {
                     
                    // �Ի�����
                    if( dsT_ME_BHISTORY.NameValue(i, "STR_YMD") == '' ) {
                        alert("�Ի����ڴ� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_BHISTORY.RowPosition = i;
                        return false;
                    }
                    
                }
            }            
            

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_ME_FAMILY, 15,"false","false");
            form1.grdT_ME_FAMILY.HiddenHScroll  = true;
            form1.grdT_ME_FAMILY.DisableNoHScroll = false;
            cfStyleGrid(form1.grdT_ME_QUALIFICATION, 15,"false","false");
            form1.grdT_ME_QUALIFICATION.HiddenHScroll  = true;
            form1.grdT_ME_QUALIFICATION.DisableNoHScroll = false;
            cfStyleGrid(form1.grdT_ME_BHISTORY, 15,"false","false");
            form1.grdT_ME_BHISTORY.HiddenHScroll  = true;
            form1.grdT_ME_BHISTORY.DisableNoHScroll = false;
            
            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

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
    | 2. �̸� : dsT_ME_FAMILY                       |
    | 3. Table List : T_ME_FAMILY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ME_QUALIFICATION                       |
    | 3. Table List : T_ME_QUALIFICATION                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ME_BHISTORY                       |
    | 3. Table List : T_ME_BHISTORY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_BHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_PERSON2                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ME_FAMILY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_FAMILY.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <Script For=dsT_ME_QUALIFICATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_QUALIFICATION.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <Script For=dsT_ME_BHISTORY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_BHISTORY.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>
        
    <Script For=dsT_ME_QUALIFICATION Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>
        
    <Script For=dsT_ME_BHISTORY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>    
    
    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_FAMILY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[����/����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("����/���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_ME_QUALIFICATION Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�ڰݸ���/�����] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�ڰݸ���/����Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_ME_BHISTORY Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�Ի���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�Ի��Ͽ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>
    
    <script for=trT_ME_PERSON2 event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        if (parent.savflag != '1') {
            parent.savflag = 1;
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    <script for=trT_ME_PERSON2 event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    <script language="javascript"  for=grdT_ME_FAMILY event=OnExit(row,colid,olddata)>

        if(colid == "BIR_YMD"){
            if(dsT_ME_FAMILY.NameValue(row,colid) != "" && !cfDateExpr(dsT_ME_FAMILY.NameValue(row,colid))){
                alert('��¥���Ŀ� �����ʽ��ϴ�.');
                dsT_ME_FAMILY.NameValue(row,colid) = "";
            }
        }

    </script>
    
    <script language="javascript"  for=grdT_ME_QUALIFICATION event=OnExit(row,colid,olddata)>

        if(colid == "GAN_YMD"){
            if(dsT_ME_QUALIFICATION.NameValue(row,colid) != "" && !cfDateExpr(dsT_ME_QUALIFICATION.NameValue(row,colid))){
                alert('��¥���Ŀ� �����ʽ��ϴ�.');
                dsT_ME_QUALIFICATION.NameValue(row,colid) = "";
            }
        }

    </script>
    
    <script language="javascript"  for=grdT_ME_BHISTORY event=OnExit(row,colid,olddata)>

        if(colid == "STR_YMD" || colid == "END_YMD"){
            if(dsT_ME_BHISTORY.NameValue(row,colid) != "" && !cfDateExpr(dsT_ME_BHISTORY.NameValue(row,colid))){
                alert('��¥���Ŀ� �����ʽ��ϴ�.');
                dsT_ME_BHISTORY.NameValue(row,colid) = "";
            }
            
            if( dsT_ME_BHISTORY.NameValue(row, "STR_YMD") != '' && dsT_ME_BHISTORY.NameValue(row, "END_YMD") != '' ) {
                if( cfDateDiff(dsT_ME_BHISTORY.NameValue(row, "STR_YMD").replace(/\-/g,''),dsT_ME_BHISTORY.NameValue(row, "END_YMD").replace(/\-/g,'')) < 0 ) {
                    alert("�Ի����ڰ� ������ں��� Ů�ϴ�.");
                    dsT_ME_BHISTORY.RowPosition = row;
                    dsT_ME_BHISTORY.NameValue(row,"END_YMD") = "";
                    return false;
                }
            }
            
        }

    </script>
    
    <script language=JavaScript for=grdT_ME_FAMILY event=OnClick(row,colid)>
    
	   if(colid == "REL_NM" && dsT_ME_FAMILY.RowStatus(dsT_ME_FAMILY.RowPosition) == 1){
	       var obj =  new String();
	       obj = fnc_commonCodePopupReturn('��������','G1');
	       
	       if(obj != null){
	           dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "REL_CD") = obj.comm_cd;
	           dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "REL_NM") = obj.comm_nm;
	       }
       
       }
	   
	   if(colid == "EDGR_NM"){
	       var obj =  new String();
	       obj = fnc_commonCodePopupReturn('�з±���','E1');
	       
           if(obj != null){
               dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "EDGR_CD") = obj.comm_cd;
               dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition, "EDGR_NM") = obj.comm_nm;
           }	       
	   
	   }
	
    </script>
    
    <script language=JavaScript for=grdT_ME_QUALIFICATION event=OnClick(row,colid)>

       if(colid == "QUA_NM" && dsT_ME_QUALIFICATION.RowStatus(dsT_ME_QUALIFICATION.RowPosition) == 1){
           var obj =  new String();
           obj = fnc_commonCodePopupReturn('�ڰݸ���','H1');
           
           if(obj != null){
               dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition, "QUA_CD") = obj.comm_cd;
               dsT_ME_QUALIFICATION.NameValue(dsT_ME_QUALIFICATION.RowPosition, "QUA_NM") = obj.comm_nm;
           }           
       
       }
	
    </script>

    
    


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend1','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('1');return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove1','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove('1');return false;"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
	        <comment id="__NSID__">
	        <object id="grdT_ME_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:99px;">
	            <param name="DataID"                  value="dsT_ME_FAMILY">
	            <param name="Format"                  value="
	                <C> id={currow}        width=39    name='NO'           align=center   Edit=none   </C>
	                <C> id=REL_NM          width=110   name='����'         align=center   Edit=none   </C>
	                <C> id=ENO_NM          width=110   name='����'         align=center               </C>
	                <C> id=BIR_YMD         width=110   name='�������'     align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
	                <C> id=EDGR_NM         width=110   name='�з�'                        Edit=none   </C>
	                <C> id=OCC_NAM         width=169   name='�ٹ�ó'                                  </C>
	                <C> id=JOB_CD          width=110   name='����'                                    </C>
	            ">
	        </object>
	        </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="80"></col>
        <col width="215"></col>
        <col width="7"></col>
        <col width="100"></col>
        <col width=""></col>
    </colgroup>
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�ڰݸ���</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend2','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('2');return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove2','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove('2');return false;"></a>
        </td>
        <td></td>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�Ի������</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend3','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('3');return false;"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove3','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove('3');return false;"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
	        <comment id="__NSID__">
            <object id="grdT_ME_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:99px;">
                <param name="DataID"                  value="dsT_ME_QUALIFICATION">
                <param name="Format"                  value="
                    <C> id={currow}        width=24   name='NO'           align=center   Edit=none   </C>
                    <C> id=QUA_NM          width=80   name='�ڰݸ���'                    Edit=none   </C>
                    <C> id=GAN_YMD         width=70   name='�����'       align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
                    <C> id=APP_ADM         width=89   name='����ó'                                  </C>
                ">
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
        <td>
	        <comment id="__NSID__">
            <object id="grdT_ME_BHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:99px;">
                <param name="DataID"                  value="dsT_ME_BHISTORY">
                <param name="Format"                  value="
                    <C> id={currow}        width=24   name='NO'           align=center   Edit=none   </C>
                    <C> id=CMP_NAM         width=90   name='ȸ���'                                  </C>
                    <C> id=STR_YMD         width=70   name='�Ի���'       align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
                    <C> id=END_YMD         width=70   name='�����'       align=center   Edit=Numeric    mask='XXXX-XX-XX'   </C>
                    <C> id=JOB_CD          width=50   name='����'                                    </C>
                    <C> id=SAL_AMT         width=65   name='�޿���'       align=right                </C>
                    <C> id=CHG_JOB         width=90   name='������'     align=left                 </C>
                ">
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
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