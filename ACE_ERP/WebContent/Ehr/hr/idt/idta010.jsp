	<!--*************************************************
	* @source      : idta010.jsp														*
	* @description : �����߱�ó�� PAGE 										    *
	****************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*------------------------------------------------------------------
	* 2016/04/28            �̵���          	        erp �̻�
	***************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

	<title>�����߱�ó��(idta010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var today = getToday();

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			
            var STR_YMD     = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD     = document.getElementById("txtEND_YMD_SHR").value;
            var CEF_STS     = document.getElementById("cmbCEF_STS_SHR").value;


            dsT_ID_CEFBOOK.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta010.cmd.IDTA010CMD"
                                  + "&S_MODE=SHR"
                                  + "&STR_YMD="+STR_YMD
                                  + "&END_YMD="+END_YMD
                                  + "&CEF_STS="+CEF_STS;

            dsT_ID_CEFBOOK.reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
        	//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {

            if(dsT_ID_CEFBOOK.CountRow == 0) {
                alert("��� ���� �����ϴ�.");
                return;
            }
            
            trT_ID_CEFBOOK.KeyValue = "service_tr06(I:dsT_ID_CEFBOOK=dsT_ID_CEFBOOK)";
            trT_ID_CEFBOOK.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta010.cmd.IDTA010CMD"
                                    + "&S_MODE=SAV";
            trT_ID_CEFBOOK.post();

            var url = "idta020_R_PV.jsp";
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }


        function fnc_Print1() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //�߱޸ż�
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //�߱޻���
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //�߱޹�ȣ

			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print1.Preview();

        }

        function fnc_Print2() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //�߱޸ż�
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //�߱޻���
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //�߱޹�ȣ

			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print2.Preview();

        }

        function fnc_Print3() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //�߱޸ż�
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //�߱޻���
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //�߱޹�ȣ

			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print3.Preview();

        }

        function fnc_Print4() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // ���¿� ���� ��ư ó�� - CEF_STS, 'A', '����', 'B', '��û', 'C', '�ݼ�', 'E', '�߱�', 'F', '�������'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //����
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //���� ����
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //�߱޸ż�
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //�߱޻���
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //�߱޹�ȣ

			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print4.Preview();

        }



		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
		}

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			
        	window.close();
			
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	
        	cfStyleGrid_New(form1.grdT_ID_CEFBOOK, 0, "true", "false");      // Grid Style ����

            document.getElementById("txtSTR_YMD_SHR").value = gcurdate.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = gcurdate;

            document.getElementById("cmbCEF_STS_SHR").value = "B";
            
            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * �߱� �� �μ� ó��
         */
        function fnc_ProcPrt2() {


        var REQ_NO = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");
        var CEF_STS;
        var CEF_SEC;
        var rowIndex;

        fnc_SearchList();

        //�Է��� ��û��ȣ�� ������ Row�� �̵�
        rowIndex = dsT_ID_CEFBOOK.NameValueRow("REQ_NO", REQ_NO);

        if(rowIndex > 0) {
            dsT_ID_CEFBOOK.RowPosition = rowIndex;
            CEF_STS = dsT_ID_CEFBOOK.NameValue(rowIndex, "CEF_STS");
            CEF_SEC = dsT_ID_CEFBOOK.NameValue(rowIndex, "CEF_SEC");
        }



		dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'SPL_YMD') = today;

		// save
		trT_ID_CEFBOOK.KeyValue = "tr01(I:dsT_ID_CEFBOOK=dsT_ID_CEFBOOK)";
		trT_ID_CEFBOOK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SAV";
		trT_ID_CEFBOOK.post();

        //�������� ���
        if(CEF_SEC == "01") {
            fnc_Print1();
        }

        //������� ���
        if(CEF_SEC == "02") {
            fnc_Print2();
        }

        //�������� ���
        if(CEF_SEC == "03") {
            fnc_Print3();
        }

        //���Ա����
        if(CEF_SEC == "04") {
            fnc_Print4();
        }

        }


        /**
         * �߱� �� �μ� ó��
         */
        function fnc_ProcPrt() {
            var chkVal = "";

            for(var i=1; i<=dsT_ID_CEFBOOK.CountRow; i++) {
                if(dsT_ID_CEFBOOK.NameString(i, "IS_CHK") == "T") {
                    chkVal += dsT_ID_CEFBOOK.NameString(i, "REQ_NO") + " ";
                }
            }
            trT_ID_CEFBOOK.KeyValue = "service_tr06(I:dsT_ID_CEFBOOK=dsT_ID_CEFBOOK)";
            trT_ID_CEFBOOK.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta010.cmd.IDTA010CMD"
                                    + "&S_MODE=PROC";
            trT_ID_CEFBOOK.post();

            for(var i=1; i<=dsT_ID_CEFBOOK.CountRow; i++) {
                if(dsT_ID_CEFBOOK.NameString(i, "IS_CHK") == "T") {

					ENO_NO = dsT_ID_CEFBOOK.NameString(i, "ENO_NO");  //���
					CEF_SEC = dsT_ID_CEFBOOK.NameString(i, "CEF_SEC"); //���� ����
					CEF_CNT = dsT_ID_CEFBOOK.NameString(i, "CEF_CNT"); //�ż�
					REQ_NO = dsT_ID_CEFBOOK.NameString(i, "REQ_NO");	//��û��ȣ


					if (CEF_SEC == "04"){
				  		var hnwparm = "[:ENO_NO]="+ENO_NO+"[:CEF_SEC]="+CEF_SEC+"[:CEF_CNT]="+CEF_CNT+"[:REQ_NO]="+REQ_NO;
						document.form1.rptObject1.SetValues(hnwparm);
			            document.form1.rptObject1.RunButton("Print");
				  	}
				  	else
				  	{
				  		var hnwparm = "[:ENO_NO]="+ENO_NO+"[:CEF_SEC]="+CEF_SEC+"[:CEF_CNT]="+CEF_CNT+"[:REQ_NO]="+REQ_NO;
						document.form1.rptObject.SetValues(hnwparm);
			            document.form1.rptObject.RunButton("Print");
				  	}

                }
            }

            fnc_SearchList();
        }



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EXAMINATION)			   |
    | 3. ���Ǵ� Table List(T_CM_EXAMINATION) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_ID_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="false">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<Object ID="dsT_ID_CEFBOOK_PRINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ID_CEFBOOK)		   |
    | 3. ���Ǵ� Table List(T_ID_CEFBOOK)		       |
    +------------------------------------------------------>
	<Object ID="trT_ID_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �뵵 ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R4"/>
       <jsp:param name="CODE_GUBUN"    value="R4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_ID_CEFBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadError()">
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnDataError()">
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnFail()">
        alert(trT_ID_CEFBOOK.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��                              |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_ID_CEFBOOK event="OnDblClick(row,colid)">
        if(row < 1) {
            return;
        } else {
            var REQ_NO = dsT_ID_CEFBOOK.NameValue(row, "REQ_NO");

            var url = "../../hr/idt/idta011.jsp?&REQ_NO="+REQ_NO;
            window.showModalDialog(url, "", "dialogWidth:1050px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            fnc_SearchList();
        }
    </script>

    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript" for=grdT_ID_CEFBOOK event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "IS_CHK" && dsT_ID_CEFBOOK.CountRow > 0) {
            for(var i=1; i<=dsT_ID_CEFBOOK.CountRow; i++) {

                if(bCheck == "1") {
                    dsT_ID_CEFBOOK.NameString(i, "IS_CHK") = "T";
                } else {
                    dsT_ID_CEFBOOK.NameString(i, "IS_CHK") = "F";
                }
            }
        }
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">



	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"  ><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"    ><img src="../../images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>  -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"      ><img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="70"></col>
					<col width="180"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">��ȸ�Ⱓ</td>
					<td class="padding2423" align="left" colspan="3">
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
						<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','110');"></a> -->
						~
						<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
						<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"></a> -->
					</td>
                    <td class="searchState" align="right">��ȸ����</td>
                    <td class="padding2423" align="left">
                        <select id="cmbCEF_STS_SHR" style="WIDTH: 80px" onChange="fnc_SearchList()">
                            <option value="">���</option>
                            <option value="A">����</option>
                            <option value="B">��û</option>
                            <option value="C">�ݼ�</option>
                            <option value="E">�߱�</option>
                            <option value="F">�������</option>
                        </select>
                    </td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ID_CEFBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:600px;">
						<param name="DataID" 				value="dsT_ID_CEFBOOK">
						<param name="Editable" 				value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 				value="Left">
						<param name="Format" 				value='
							<C> id={currow}				width=25	name="NO"				align=center	Edit=none	 </C>
                            <C> id="IS_CHK"     			width=60    name="���"           align=center    EditStyle=CheckBox,Pointer=Hand     HeadCheckShow=true      HeadCheck=true</C>
							<C> id="REQ_NO"				width=80	name="��û��ȣ"		align=center	Edit=none	 </C>
							<C> id="DPT_NM"				width=80 	name="�μ�"			align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="JOB_NM"				width=100	name="����"			align=center	Edit=none	 </C>
							<C> id="ENO_NM"				width=80	name="����"			align=center	Edit=none	 </C>
							<C> id="CEF_SEC_NM" 		width=130	name="��������"	align=center	Edit=none	 </C>
							<C> id="CEF_RSN_NM" 		width=130	name="�뵵"			align=center	Edit=none	 </C>
                            <C> id="CEF_STS_NM" 		width=40    name="����"           align=center    Edit=none   </C>
                            <C> id="CEF_NO"     		width=70    name="�߱޹�ȣ"     align=center    Edit=none    </C>
							<C> id="SPL_YMD"			width=70	name="�߱���"			align=center	Edit=none	 </C>
                            <C> id="CEF_CNT"    		width=35    name="�ż�"           align=center    Edit=none    </C>
                            <C> id="IPT_YMD"     		width=70    name="��û��"     	align=center    Edit=none    </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</form>
	<!-- form �� -->



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### �� �� �� �� �� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print1  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2756 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=319 ,right=1944 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2187 ,right=363 ,bottom=2656 ,border=true</X>
		<X>left=38 ,top=1353 ,right=1944 ,bottom=1525 ,border=true</X>
		<X>left=38 ,top=1012 ,right=1944 ,bottom=1184 ,border=true</X>
		<X>left=38 ,top=844 ,right=1944 ,bottom=1016 ,border=true</X>
		<X>left=38 ,top=675 ,right=1944 ,bottom=847 ,border=true</X>
		<X>left=38 ,top=506 ,right=1944 ,bottom=678 ,border=true</X>
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1219 ,bottom=2756</I>
		<L> left=694 ,top=247 ,right=1291 ,bottom=247 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=319 ,right=1941 ,bottom=319 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2656 ,right=1941 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=319 ,right=1944 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2656 </L>
		<L> left=1941 ,top=319 ,right=1941 ,bottom=2656 </L>
		<L> left=322 ,top=322 ,right=322 ,bottom=1522 </L>
		<L> left=984 ,top=675 ,right=984 ,bottom=1012 </L>
		<L> left=1309 ,top=678 ,right=1309 ,bottom=1016 </L>
		<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
		<L> left=41 ,top=2466 ,right=359 ,bottom=2466 </L>
		<L> left=38 ,top=2275 ,right=363 ,bottom=2275 </L>

		<C>id='CEF_NO', left=38, top=241, right=506, bottom=306, align='left' ,mask='�� XXXXXXXXX ȣ', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PER_ADR', left=344, top=384, right=1922, bottom=450, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ADDRESS', left=344, top=559, right=1922, bottom=625, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DPT_NM', left=344, top=725, right=975, bottom=791, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JOB_NM', left=1334, top=725, right=1925, bottom=791, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENO_NM', left=344, top=894, right=975, bottom=959, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CET_NO', left=1334, top=894, right=1925, bottom=959, align='left' , face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CEF_RSN_NM', left=344, top=1062, right=1922, bottom=1128, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JPR_YMD', left=344, top=1234, right=725, bottom=1300, align='left' , mask='XXXX�� XX�� XX��',face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REMARK', left=344, top=1370, right=1025, bottom=1510, align='left' ,face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SPL_YMD2', left=1319, top=2025, right=1819, bottom=2094, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>


		<T>id='�� �� �� �� ��' ,left=25 ,top=91 ,right=1959 ,bottom=237 ,face='HY�߰��' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=994 ,top=894 ,right=1306 ,bottom=959 ,face='����' ,size=12 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=994 ,top=725 ,right=1306 ,bottom=791 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2200 ,right=334 ,bottom=2266 ,face='����' ,size=13 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2487 ,right=119 ,bottom=2547 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2578 ,right=119 ,bottom=2637 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2403 ,right=119 ,bottom=2456 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2347 ,right=119 ,bottom=2397 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2287 ,right=119 ,bottom=2341 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=378 ,right=316 ,bottom=444 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=553 ,right=316 ,bottom=619 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=719 ,right=316 ,bottom=784 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=887 ,right=316 ,bottom=953 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=1062 ,right=316 ,bottom=1128 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=47 ,top=1228 ,right=316 ,bottom=1294 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=1397 ,right=316 ,bottom=1462 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��� ����� ������.' ,left=344, top=1547, right=1934, bottom=1644 ,face='����' ,align='left',size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>

		<C>id='{decode(DRV_TAG,1,\'����� ���α� ����� 194\',2,\'������ ���� ������ ȭ�������� 10\',\'����� ���α� ����� 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY�߰��' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	
		<T>id='�� �� �� �� �� �� ȸ ��' , align='left' ,left=1101 ,top=2336 ,right=1840 ,bottom=2434 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ǥ�̻�  ��  ��  ��' , align='left' ,left=1101 ,top=2445 ,right=1840 ,bottom=2543 ,face='HY�߰��' ,size=14  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
		<I>id='../../images/common/icon.jpg' ,left=741 ,top=2700 ,right=1219 ,bottom=2800</I>

		<I>id='../../images/common/1.jpg' ,left=142 ,top=2291 ,right=329 ,bottom=2456</I>
		<I>id='../../images/common/2.jpg' ,left=142 ,top=2476 ,right=329 ,bottom=2640</I>

	</B>
">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### �� �� �� �� �� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print2  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=2729 ,face='Arial' ,size=10 ,penwidth=1
		<I>id='../../Common/img/icon.jpg' ,left=740 ,top=2613 ,right=1219 ,bottom=2713</I>
		<X>left=37 ,top=269 ,right=1943 ,bottom=2605 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=37 ,top=2136 ,right=363 ,bottom=2605 ,border=true</X>
		<X>left=37 ,top=1303 ,right=1943 ,bottom=1474 ,border=true</X>
		<X>left=37 ,top=1131 ,right=1943 ,bottom=1305 ,border=true</X>
		<X>left=37 ,top=962 ,right=1943 ,bottom=1134 ,border=true</X>
		<X>left=37 ,top=794 ,right=1943 ,bottom=965 ,border=true</X>
		<X>left=37 ,top=456 ,right=1943 ,bottom=628 ,border=true</X>
		<X>left=37 ,top=625 ,right=1943 ,bottom=796 ,border=true</X>
		<L> left=37 ,top=269 ,right=37 ,bottom=2602 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=42 ,top=269 ,right=1940 ,bottom=269 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=42 ,top=2605 ,right=1940 ,bottom=2605 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1943 ,top=269 ,right=1943 ,bottom=2602 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=321 ,top=272 ,right=321 ,bottom=1471 </L>
		<L> left=985 ,top=625 ,right=985 ,bottom=962 </L>
		<L> left=1274 ,top=628 ,right=1274 ,bottom=965 </L>
		<L> left=1274 ,top=1134 ,right=1274 ,bottom=1303 </L>
		<L> left=985 ,top=1131 ,right=985 ,bottom=1303 </L>
		<L> left=37 ,top=269 ,right=37 ,bottom=2605 </L>
		<L> left=1940 ,top=269 ,right=1940 ,bottom=2605 </L>
		<L> left=118 ,top=2228 ,right=118 ,bottom=2605 </L>
		<L> left=42 ,top=2415 ,right=358 ,bottom=2415 </L>
		<L> left=37 ,top=2225 ,right=355 ,bottom=2225 </L>

		<C>id='CEF_NO', left=35, top=191, right=503, bottom=257, align='left' ,mask='�� XXXXXXXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PER_ADR', left=329, top=329, right=1907, bottom=396, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ADDRESS', left=329, top=503, right=1907, bottom=566, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DPT_NM', left=329, top=673, right=962, bottom=740, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JOB_NM', left=1286, top=673, right=1875, bottom=740, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CET_NO', left=1286, top=844, right=1875, bottom=910, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENO_NM', left=329, top=838, right=962, bottom=904, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CEF_RSN_NM', left=329, top=1011, right=1907, bottom=1075, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JPR_YMD', left=329, top=1182, right=711, bottom=1248, align='left' ,mask='XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REMARK', left=326, top=1343, right=1008, bottom=1421, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RET_YMD', left=1286, top=1184, right=1667, bottom=1251, align='left' ,mask='XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


		<L> left=695 ,top=198 ,right=1290 ,bottom=198 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<T>id='�� �� �� �� ��' ,left=24 ,top=42 ,right=1959 ,bottom=187 ,face='HY�߰��' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=987 ,top=675 ,right=1274 ,bottom=741 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=987 ,top=844 ,right=1274 ,bottom=910 ,face='����' ,size=12 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�����' ,left=987 ,top=1184 ,right=1274 ,bottom=1250 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2149 ,right=334 ,bottom=2215 ,face='����' ,size=13 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=45 ,top=2436 ,right=118 ,bottom=2497 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=45 ,top=2529 ,right=118 ,bottom=2587 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=45 ,top=2352 ,right=118 ,bottom=2405 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=45 ,top=2297 ,right=118 ,bottom=2347 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=45 ,top=2236 ,right=118 ,bottom=2291 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=45 ,top=327 ,right=319 ,bottom=393 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=45 ,top=504 ,right=319 ,bottom=570 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=45 ,top=670 ,right=319 ,bottom=733 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=45 ,top=836 ,right=319 ,bottom=902 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=45 ,top=1012 ,right=319 ,bottom=1078 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=45 ,top=1179 ,right=319 ,bottom=1245 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=45 ,top=1347 ,right=319 ,bottom=1413 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��� ����� ������.' ,left=344, top=1547, right=1934, bottom=1644 ,face='����' ,align='left',size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>

		<T>id='���� ���α� ����� 194', align='left' ,left=1200 ,top=2225 ,right=1840 ,bottom=2323 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� �� �� �� �� ȸ ��' , align='left' ,left=1200 ,top=2336 ,right=1840 ,bottom=2434 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ǥ�̻� ���� �� �� ��' , align='left' ,left=1200 ,top=2445 ,right=1840 ,bottom=2543 ,face='HY�߰��' ,size=14  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
		<I>id='../../images/common/icon.jpg' ,left=741 ,top=2700 ,right=1219 ,bottom=2800</I>

	</B>
">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ���� �� �� �� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print3  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2729 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=269 ,right=1944 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2137 ,right=363 ,bottom=2606 ,border=true</X>
		<X>left=38 ,top=1303 ,right=1944 ,bottom=1475 ,border=true</X>
		<X>left=38 ,top=1131 ,right=1944 ,bottom=1306 ,border=true</X>
		<X>left=38 ,top=962 ,right=1944 ,bottom=1134 ,border=true</X>
		<X>left=38 ,top=794 ,right=1944 ,bottom=966 ,border=true</X>
		<X>left=38 ,top=456 ,right=1944 ,bottom=628 ,border=true</X>
		<X>left=38 ,top=625 ,right=1944 ,bottom=797 ,border=true</X>
		<L> left=38 ,top=269 ,right=38 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=269 ,right=1941 ,bottom=269 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2606 ,right=1941 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=269 ,right=1944 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=322 ,top=272 ,right=322 ,bottom=1472 </L>
		<L> left=984 ,top=625 ,right=984 ,bottom=962 </L>
		<L> left=1275 ,top=628 ,right=1275 ,bottom=966 </L>
		<L> left=1275 ,top=1134 ,right=1275 ,bottom=1303 </L>
		<L> left=984 ,top=1131 ,right=984 ,bottom=1303 </L>
		<L> left=38 ,top=269 ,right=38 ,bottom=2606 </L>
		<L> left=1941 ,top=269 ,right=1941 ,bottom=2606 </L>
		<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
		<L> left=41 ,top=2416 ,right=359 ,bottom=2416 </L>
		<L> left=38 ,top=2225 ,right=356 ,bottom=2225 </L>

		<C>id='CEF_NO', left=35, top=191, right=503, bottom=257, align='left' ,mask='�� XXXXXXXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PER_ADR', left=329, top=329, right=1907, bottom=396, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ADDRESS', left=329, top=503, right=1907, bottom=566, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DPT_NM', left=329, top=673, right=962, bottom=740, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JOB_NM', left=1286, top=673, right=1875, bottom=740, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CET_NO', left=1286, top=844, right=1875, bottom=910, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENO_NM', left=329, top=838, right=962, bottom=904, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CEF_RSN_NM', left=329, top=1011, right=1907, bottom=1075, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JPR_YMD', left=329, top=1182, right=711, bottom=1248, align='left' ,mask='XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REMARK', left=326, top=1343, right=1008, bottom=1421, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RET_YMD', left=1286, top=1184, right=1667, bottom=1251, align='left' ,mask='XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

		<L> left=694 ,top=197 ,right=1291 ,bottom=197 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<T>id='�� �� �� �� ��' ,left=25 ,top=41 ,right=1959 ,bottom=187 ,face='HY�߰��' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=988 ,top=675 ,right=1275 ,bottom=741 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=988 ,top=844 ,right=1275 ,bottom=909 ,face='����' ,size=12 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�����' ,left=988 ,top=1184 ,right=1275 ,bottom=1250 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2150 ,right=334 ,bottom=2216 ,face='����' ,size=13 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2437 ,right=119 ,bottom=2497 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2528 ,right=119 ,bottom=2587 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2353 ,right=119 ,bottom=2406 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2297 ,right=119 ,bottom=2347 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2237 ,right=119 ,bottom=2291 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=328 ,right=319 ,bottom=394 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=503 ,right=319 ,bottom=569 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=669 ,right=319 ,bottom=734 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=837 ,right=319 ,bottom=903 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=1012 ,right=319 ,bottom=1078 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=44 ,top=1178 ,right=319 ,bottom=1244 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=1347 ,right=319 ,bottom=1412 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��� ����� ������.' ,left=344, top=1547, right=1934, bottom=1644 ,face='����' ,align='left',size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>

		<T>id='���� ���α� ����� 194', align='left' ,left=1200 ,top=2225 ,right=1840 ,bottom=2323 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� �� �� �� �� ȸ ��' , align='left' ,left=1200 ,top=2336 ,right=1840 ,bottom=2434 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ǥ�̻� ���� �� �� ��' , align='left' ,left=1200 ,top=2445 ,right=1840 ,bottom=2543 ,face='HY�߰��' ,size=14  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
		<I>id='../../images/common/icon.jpg' ,left=741 ,top=2700 ,right=1219 ,bottom=2800</I>

	</B>
">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### �� �� (Ȯ��) �� �� �� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print4  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      	VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            	VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2756 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=319 ,right=1944 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2187 ,right=363 ,bottom=2656 ,border=true</X>
		<X>left=38 ,top=1353 ,right=1944 ,bottom=1525 ,border=true</X>
		<X>left=38 ,top=1012 ,right=1944 ,bottom=1184 ,border=true</X>
		<X>left=38 ,top=844 ,right=1944 ,bottom=1016 ,border=true</X>
		<X>left=38 ,top=675 ,right=1944 ,bottom=847 ,border=true</X>
		<X>left=38 ,top=506 ,right=1944 ,bottom=678 ,border=true</X>
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1219 ,bottom=2753</I>
		<L> left=38 ,top=319 ,right=38 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=319 ,right=1941 ,bottom=319 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2656 ,right=1941 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=319 ,right=1944 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2656 </L>
		<L> left=1941 ,top=319 ,right=1941 ,bottom=2656 </L>
		<L> left=322 ,top=322 ,right=322 ,bottom=1522 </L>
		<L> left=984 ,top=675 ,right=984 ,bottom=1012 </L>
		<L> left=1309 ,top=678 ,right=1309 ,bottom=1016 </L>
		<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
		<L> left=41 ,top=2466 ,right=359 ,bottom=2466 </L>
		<L> left=38 ,top=2275 ,right=363 ,bottom=2275 </L>
		<T>id='�� �� (Ȯ��) �� �� ��' ,left=25 ,top=91 ,right=1959 ,bottom=237 ,face='HY�߰��' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=994 ,top=894 ,right=1306 ,bottom=959 ,face='����' ,size=12 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=994 ,top=725 ,right=1306 ,bottom=791 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2200 ,right=334 ,bottom=2266 ,face='����' ,size=13 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2487 ,right=119 ,bottom=2547 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2578 ,right=119 ,bottom=2637 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2403 ,right=119 ,bottom=2456 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2347 ,right=119 ,bottom=2397 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2287 ,right=119 ,bottom=2341 ,face='����' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���� ���α� ����� 194', align='left' ,left=1200 ,top=2225 ,right=1840 ,bottom=2323 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� �� �� �� �� ȸ ��' , align='left' ,left=1200 ,top=2336 ,right=1840 ,bottom=2434 ,face='HY�߰��' ,size=14   ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ǥ�̻� ���� �� �� ��' , align='left' ,left=1200 ,top=2445 ,right=1840 ,bottom=2543 ,face='HY�߰��' ,size=14  ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
		<I>id='../../images/common/icon.jpg' ,left=741 ,top=2700 ,right=1219 ,bottom=2800</I>
		<T>id='��     ��' ,left=47 ,top=378 ,right=316 ,bottom=444 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=553 ,right=316 ,bottom=619 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=719 ,right=316 ,bottom=784 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=887 ,right=316 ,bottom=953 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=47 ,top=1062 ,right=316 ,bottom=1128 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���ӱⰣ' ,left=47 ,top=1228 ,right=316 ,bottom=1294 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=1397 ,right=316 ,bottom=1462 ,face='����' ,size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��� ����� ������.' ,left=344, top=1547, right=1934, bottom=1644 ,face='����' ,align='left',size=14 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=538 ,top=241 ,right=1438 ,bottom=241 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>

		<C>id='CEF_NO', left=38, top=241, right=506, bottom=306, align='left' ,mask='�� XXXXXXXXX ȣ', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PER_ADR', left=344, top=384, right=1922, bottom=450, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ADDRESS', left=344, top=559, right=1922, bottom=625, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DPT_NM', left=344, top=725, right=975, bottom=791, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JOB_NM', left=1334, top=725, right=1925, bottom=791, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENO_NM', left=344, top=894, right=975, bottom=959, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CET_NO', left=1334, top=894, right=1925, bottom=959, align='left' , face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CITY', left=344, top=1062, right=1922, bottom=1128, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='STR_YMD', left=344, top=1234, right=725, bottom=1300, align='left' , mask='XXXXXXXXXX  ~',face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='END_YMD', left=744, top=1234, right=1225, bottom=1300, align='left' , face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CEF_RSN_NM', left=344, top=1403, right=1922, bottom=1469, align='left', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURDT', left=1319, top=2025, right=1819, bottom=2094, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>

	</B>
">
</OBJECT>


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

