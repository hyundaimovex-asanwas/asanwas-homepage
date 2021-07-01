<!--
***********************************************************************
* @source      : vlul080.jsp
* @description : ��ǥ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/03/17      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��ǥ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/style_new.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var year    = getToday().substring(0,4);
        var dsTemp = window.dialogArguments;

        var selectRow = 0;

		var STS = "<%=request.getParameter("STATUS")%>";
        var ENO_NO = "";
        var ENO_NM = "";

        if(dsTemp != "Modal") {
			ENO_NO = "<%=box.get("SESSION_ENONO")%>";
			ENO_NM = "<%=box.get("SESSION_ENONM")%>";
		} else {
			ENO_NO = "<%=request.getParameter("ENO_NO")%>";
			ENO_NM = "<%=request.getParameter("ENO_NM")%>";
		}

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	fnc_Clear();

        	if(document.getElementById("txtENO_NM").value == "") {
	       		alert("������ �Է��� �ּ���.");
	       		return;
	       	}

	       	var obj = new String;

	       	
<%
    //�������� ��� �⵵, ��� �˻� Ȱ��ȭ
    if(box.getString("SESSION_ROLE_CD").equals("1001") || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			if(dsTemp != "Modal") {
		        obj = fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM");
		        ENO_NO = document.getElementById("txtENO_NO").value;
	        }
<%
    }
%>
        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	
            //alert("1");
            dsT_EVL_GOALLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
            dsT_EVL_GOALLIST.Reset();

            //alert("2");
            
            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);

            //alert("3");            
            
            fnc_SetGrdHeight();

			/*if(getToday() > "2013-02-27") {
            	fnc_display("n");
            }*/
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

            // ����� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SaveItemCheck()) {
                return;
            }

			for(var i=0; i<dsT_EVL_GOALLIST.CountRow; i++){       
				dsT_EVL_GOALLIST.UserStatus(i) = 1;				
			}
            
            
            trT_EVL_GOALLIST.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
            trT_EVL_GOALLIST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul080.cmd.VLUL080CMD&S_MODE=SAV";
            trT_EVL_GOALLIST.post();
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            if (document.getElementById('txtEVL_YYYY').value != year) {
            	alert(fnc_GetMSG("MSG_10"));
                document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_10");
                document.getElementById('txtEVL_YYYY').focus();
                return;
            }

        	// ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EVL_GOALLIST.CountRow < 1) {
            	document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_05");
                alert(fnc_GetMSG("MSG_05"));
                return;
            }

            if(selectRow == 0) {
            	alert("������ ���� ������ �ּ���.");
                return;
            }

            if (confirm("���� �� �����ؾ� ������ �ݿ��˴ϴ�.") == false) return;

            //dsT_EVL_GOALLIST.DeleteRow(dsT_EVL_GOALLIST.RowPosition);
            //dsT_EVL_GOALLIST_01.DeleteRow(dsT_EVL_GOALLIST.RowPosition);

            var row = selectRow;

            dsT_EVL_GOALLIST.DeleteRow(row);
            dsT_EVL_GOALLIST_01.DeleteRow(row);
            selectRow = 0;

            //trT_EVL_GOALLIST.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
            //trT_EVL_GOALLIST.action = "/servlet/GauceChannelSVL?cmd=hr.evl.a.evla080.cmd.EVLA080CMD&S_MODE=DEL";
            //trT_EVL_GOALLIST.post();

            //fnc_SearchList();

            fnc_SetGrdHeight();



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

            if (dsT_EVL_GOALLIST.CountRow < 1) {
                alert(fnc_GetMSG("MSG_09"));
                return;
            }

            //header ����
            dsT_EVL_GOALLIST_PRT.setDataHeader("NO:NUMBER, "+
										"CATEGORY:STRING, "+
										"FORMULA:STRING, "+
										"GOAL_YMD:STRING, "+
										"WEIGHT:DECIMAL(3.0), "+
										"GRADE_NM:STRING, "+
										"GRADE:STRING ");

			grdT_EVL_GOALLIST_PRT.ColumnProp('INFO','Name') = "�Ҽ�: " + dsT_EVL_GOALLIST.NameValue(1,"DPT_NM")
																								 + "    ����: " + dsT_EVL_GOALLIST.NameValue(1,"JOB_NM")
																								 + "    ����: " + dsT_EVL_GOALLIST.NameValue(1,"ENO_NM") ;
			var grade_nm = "";
			var grade = "";
			var sum = 0;
			for(var i=0; i<dsT_EVL_GOALLIST.CountRow; i++){

				sum += dsT_EVL_GOALLIST.NameValue(i+1,"WEIGHT");

				for(var j=1; j<=5; j++) {
					dsT_EVL_GOALLIST_PRT.AddRow();
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"NO") 				= i+1;
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"CATEGORY") 	= dsT_EVL_GOALLIST.NameValue(i+1,"CATEGORY");
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"FORMULA") 		= dsT_EVL_GOALLIST.NameValue(i+1,"FORMULA");
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"GOAL_YMD") 	= dsT_EVL_GOALLIST.NameValue(i+1,"GOAL_YMD");
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"WEIGHT") 		= dsT_EVL_GOALLIST.NameValue(i+1,"WEIGHT");
					//alert(dsT_EVL_GOALLIST.NameValue(i+1,"WEIGHT"));


					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"GRADE_NM") 	= grade_nm;
					dsT_EVL_GOALLIST_PRT.NameValue((i*5)+j,"GRADE") 		= dsT_EVL_GOALLIST.NameValue(i+1,grade);

				}
			}

			grdT_EVL_GOALLIST_PRT.ColumnProp('WEIGHT','sumtext') = sum;
			grdT_EVL_GOALLIST_PRT.ExcelToPrintLandScape = 2;
			grdT_EVL_GOALLIST_PRT.GridToExcel("��ǥ����", '', 129);



        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/

        function fnc_AddNew() {

            
			for(var i=1; i<=dsT_EVL_GOALLIST.CountRow; i++){

				dsT_EVL_GOALLIST.NameValue(i,"CATEGORY") 		= dsT_EVL_GOALLIST_01.NameValue(i,"CATEGORY");
				dsT_EVL_GOALLIST.NameValue(i,"FORMULA") 		= dsT_EVL_GOALLIST_01.NameValue(i,"FORMULA");
				dsT_EVL_GOALLIST.NameValue(i,"GOAL_YMD") 		= dsT_EVL_GOALLIST_01.NameValue(i,"GOAL_YMD");
			}

			var row = dsT_EVL_GOALLIST.CountRow;
		
			//alert(row);
			
			dsT_EVL_GOALLIST.InsertRow(row+1);
		
			dsT_EVL_GOALLIST_01.InsertRow(row+1);

            dsT_EVL_GOALLIST.nameValue(row+1, "EVL_YYYY") = document.getElementById('txtEVL_YYYY').value;
            dsT_EVL_GOALLIST.nameValue(row+1, "ENO_NO") = ENO_NO;
            dsT_EVL_GOALLIST.nameValue(row+1, "GOAL_NO") = 1;

            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);

			fnc_SetGrdHeight();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			//document.getElementById("txtENO_NM").value = "<%=box.get("SESSION_ENONM")%>";
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EVL_GOALLIST.ClearData();
            dsT_EVL_GOALLIST_01.ClearData();

            selectRow = 0;
        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
	            frame = window.external.GetFrame(window);
	            frame.CloseFrame();
            }else{
                window.close();
            }

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

            if (document.getElementById("txtEVL_YYYY").value != year) {
                alert(fnc_GetMSG("MSG_01"));
                document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_01");
                document.getElementById("txtEVL_YYYY").focus();
                return false;
            }

			for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

				dsT_EVL_GOALLIST.nameValue(i, "CATEGORY") 		= dsT_EVL_GOALLIST_01.nameValue(i, "CATEGORY");
				dsT_EVL_GOALLIST.nameValue(i, "FORMULA") 		= dsT_EVL_GOALLIST_01.nameValue(i, "FORMULA");
				dsT_EVL_GOALLIST.nameValue(i, "GOAL_YMD") 		= dsT_EVL_GOALLIST_01.nameValue(i, "GOAL_YMD");
				dsT_EVL_GOALLIST.nameValue(i, "WEIGHT") 			= dsT_EVL_GOALLIST_01.nameValue(i, "WEIGHT");
			}

            // DataSet�� ���� ���� Ȯ��
            if ( !dsT_EVL_GOALLIST.IsUpdated ) {
				document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_02");
                return false;
            }

			// �����հ� üũ
			var weightTot = 0;
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	dsT_EVL_GOALLIST.NameValue(i, "GOAL_NO") = i;		// GOAL_NO ���� ä��
				weightTot = weightTot + dsT_EVL_GOALLIST.NameValue(i, "WEIGHT");

            }

            if(weightTot != 100) {
            	alert("���� �հ谡 100�� �ƴմϴ�. Ȯ�� �� �۾��� �ּ���.");

            	//grdT_EVL_GOALLIST.RowPosition = 1;
		      	//grdT_EVL_GOALLIST.ColumnPosition = "ID_WEIGHT";

            	return false;
            }

            return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  			*
         *******************************************/
        function fnc_OnLoadProcess() {

			// DATASET �ʱ�ȭ
            fnc_Clear();


			cfStyleGrid_New(grdT_EVL_GOALLIST_01, 0, "true", "false");
			grdT_EVL_GOALLIST_01.RowHeight = 100;          // Grid Row Height Setting
			grdT_EVL_GOALLIST_01.TitleHeight = "40";

			// ���������
			cfStyleGrid_New(grdT_EVL_GOALLIST_PRT, 0, "true", "false");  // Grid Style ����

            //�⵵ Setting
            if(dsTemp != "Modal") {
            	document.getElementById("txtEVL_YYYY").value = year;
			} else {

<%
			    if(request.getParameter("EVL_YYYY") == null) {
%>
					document.getElementById("txtEVL_YYYY").value = year;
<%
				}else {
%>
					document.getElementById("txtEVL_YYYY").value = "<%=request.getParameter("EVL_YYYY")%>";
<%
				}
%>
			}

            document.getElementById("txtENO_NO").value = ENO_NO;
            document.getElementById("txtENO_NM").value = ENO_NM;

<%
    //�������� ��� �⵵, ��� �˻� Ȱ��ȭ
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_YYYY").readOnly = true;
			document.getElementById("txtENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";
<%
	}else{
%>
            document.getElementById("txtEVL_YYYY").className = "";
	  		document.getElementById("txtEVL_YYYY").readOnly = false;
			document.getElementById("txtENO_NO").className = "";
	  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtENO_NM").className = "";
	  		document.getElementById("txtENO_NM").readOnly = false;

<%
    }%>

    		fnc_SearchList();

        }


        /********************************************
         * 15. ���� �����ִ� ȭ��                                          			*
         *******************************************/
        function fnc_Popup(){
        	
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			var url = "/hr/vlu/vlul081.jsp";

			window.showModalDialog(url, "Modal", "dialogWidth:900px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        	
        }
        
        
		// display
        function fnc_display(yn) {

        	if(yn == "n") {
	        	document.getElementById("btnAdd").style.display = "none";
				document.getElementById("btnDelete").style.display = "none";
				document.getElementById("btnSave").style.display = "none";

				grdT_EVL_GOALLIST_01.ColumnProp("CATEGORY","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("FORMULA","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("GOAL","Edit") = "None";


			} else {
				document.getElementById("btnAdd").style.display = "";
				document.getElementById("btnDelete").style.display = "";
				document.getElementById("btnSave").style.display = "";

				grdT_EVL_GOALLIST_01.ColumnProp("CATEGORY","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("FORMULA","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("GOAL","Edit") = "Any";

			}
        }

        function fnc_SetGrdHeight() {
        	var height = 0;

			height = (dsT_EVL_GOALLIST.CountRow * 100) + 20;

			if(height < 320) { // �ּ� ���� 360px
				height = 320;
			}

            grdT_EVL_GOALLIST_01.style.height = height;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

 	<!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST_PRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>





    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST_PRT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>



    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_GOALLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_display("y");
            document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_08");

        } else {

			// ����Ű��ȯ
			for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {
				//dsT_EVL_GOALLIST.nameValue(i, "CATEGORY") = dsT_EVL_GOALLIST.nameValue(i, "CATEGORY").replace(/&&/gi,"\r\n");
            	//dsT_EVL_GOALLIST.nameValue(i, "FORMULA") = dsT_EVL_GOALLIST.nameValue(i, "FORMULA").replace(/&&/gi,"\r\n");
            	//dsT_EVL_GOALLIST.nameValue(i, "GOAL") = dsT_EVL_GOALLIST.nameValue(i, "GOAL").replace(/&&/gi,"\r\n");
			}



            //document.getElementById("resultMessage").innerText = iCount + fnc_GetMSG("MSG                                                                                         _04");

        }

        var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        var GOAL_NO = dsT_EVL_GOALLIST.nameValue(1, "GOAL_NO");

        if(GOAL_NO == "" || GOAL_NO == undefined) {
        	GOAL_NO = "1";
        }



    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EVL_GOALLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EVL_GOALLIST event="OnSuccess()">

		if(dsTemp != "Modal") {
			//alert(fnc_GetMSG("MSG_03") + "\r\n��ǥ������ �Ϸ�Ǿ����� ����� �ּ���.");
		} else {
			//alert(fnc_GetMSG("MSG_03"));
		}

        //document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_03");
        fnc_SearchList();

    </script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EVL_GOALLIST_PRT event="OnSuccess()">

		alert("C:/��ǥ�����.xls �� ����Ǿ����ϴ�.");

    </script>



    <!--Ʈ������ ���� -->
    <script for=trT_EVL_GOALLIST event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EVL_GOALLIST_PRT event="OnFail()">

        cfErrorMsg(this);

    </script>



	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_EVL_GOALLIST event=CanRowPosChange(row)>


	</script>

	<!-----------------------------------------------------+
    | �� �� ���ڵ� ���� ���� ������ �Ϸ�� ���Ŀ� �߻��ϴ� �̺�Ʈ	|
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_EVL_GOALLIST_01 event=OnClick(Row,Colid)>
	    selectRow = Row;
  	</script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<div class="evl_container"><!-- evl_container ����-->

	<div class="info_title"><!-- info_title ����-->
		<h3 class="info_title_h3">��ǥ����</h3>

	</div><!-- //info_title ��-->


   <font size = "2" face="����">
	<b>1. ���� ����� ��ȣ �����Ͻʽÿ�. ������ ���� MBO�� �������ϸ�, ��ȣ ������ ���� ����� ������ �����մϴ�.</b><br><br>
	<b>2. ���� ������ǥ�� ���� ������ ��������, ����/�μ��� KPI ���� ����� �����մϴ� (��� 3~5�� ������ �߿䵵�� ���� ����).</b><br><br>
	<b>3. ��ǥ������ ����������ǥ�� �޼� ������ ��üȭ/��ġȭ�Ͽ� ����ϵ� ��ġȭ/�跮ȭ�� ����� ��� ��ü�� �޼� ��Ȳ�� �����մϴ�.</b><br><br>
	     1) ��ġ��ȹ ��ǥ (���� �ι�) : ���� �Ǵܱ����� ��Ȯ�� ������ �δ� ���� �߿��մϴ�.<br>	
	        (��: ����� �޼���, ����/������ ������ �޼���, �Ǹž� �޼���, ��񿹻� ��������, ������ ������, ���尳ô ����, Claim�Ǽ�, Error��, ���־�, ���귮 �޼���, ������ �޼��� ��)<br><br>		
	     2) ������ȹ ��ǥ (��ȹ, �����ι�) :��ġȭ�� ���� ��� �������� ǥ���ؾ� �ϹǷ� �߻����� �� ������ ������  �������� �򰡰� �� �� �ֵ��� �����Ͻʽÿ�.<br>		
	        (��: ��ħ/��ȹ�� �޼���, ������������ �޼���, ��ȹ/����/����å�� ���� ����, ��������/�ո�ȭ ����, ������ǥ �޼���, �������� ����, �������� ������)<br><br>		
	<b>4. �޼����� : �� �������� ��ǥ�� �޼������� �����մϴ�.</b><br><br> 	
	<b>5. ���� : ��ü ������ ���� 100%�� �ǵ��� �ۼ��Ͻʽÿ�.</b><br><br>
	<b>6. �������� �� ������ ����(���� �򰡽�)</b><br><br>	
	     1) ���� ���Զ� : ������ǥ�� ���� ���� ������ ���������� �����ϰ� ���� ���� ����.<br>	
	     2) ��� ���Զ� : ���ϰ� �ۼ��� ���������� ��������� �����Ͽ� ���� �Ǵ� Ȯ���Ͽ� ���(��� �ʼ�).<br>	
	     3) ������ : �� �׸񺰷� (���ߡ��޼���)������ ���Ͽ� �����ϰ� �����հ踦 ����.<br><br>	
	<b>7. ���� ����Ȯ�� : ���� �򰡽� �����ڿ� ���� �� �����ǰ��� �ݵ�� ����ؾ� �մϴ�.</b><br><br>	
	<font color = "blue" face="����"><b>�� �ٶ����� ��ǥ���� ��� (SMART��Ģ)</b></font><br><br>		
	     1) <font color = "blue" face="����"><b>S</b></font>pecific (��ü������)<br>	
	     2) <font color = "blue" face="����"><b>M</b></font>easurable (���������ϰ�)<br>	
	     3) <font color = "blue" face="����"><b>A</b></font>ttainable (�޼��Ҽ� �ִ�)<br>		
	     4) <font color = "blue" face="����"><b>R</b></font>easonable  Responsible (�ո����̰� å������ �ִ�)<br>
	     5) <font color = "blue" face="����"><b>T</b></font>ime-based (������ ������ �ִ�)<br>
</font>

<br>
        <table width="800" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE" height="30">
            <td width="800" height="30" colspan="4" align="center">
              	�򰡵�� (��ǥġ�� ���� ������ ������ Gap�� ��������)
            </td>        
          </tr>
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	���
            </td>
            <td width="330" align="center">
              	������ ����
            </td>
            <td width="330" align="center">
              	������ ����
            </td>
            <td width="70" align="center">
              	������
            </td>            
          </tr>          
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	S
            </td>
            <td width="330" align="center">
                    ��ǥġ �ſ� ��ȸ �޼�
            </td>
            <td width="330" align="center">
              	120% �̻�
            </td>
            <td width="70" align="center">
              	10
            </td>            
          </tr>
    
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	A
            </td>
            <td width="330" align="center">
                    ��ǥġ �̻� �޼�
            </td>
            <td width="330" align="center">
              	100%�̻� ~ 120%�̸�
            </td>
            <td width="70" align="center">
              	9
            </td>            
          </tr>

          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	B
            </td>
            <td width="330" align="center">
                    ��ǥġ ���Ͽ� �޼�
            </td>
            <td width="330" align="center">
              	80%�̻� ~ 100%�̸�
            </td>
            <td width="70" align="center">
              	8
            </td>            
          </tr>
          
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	C
            </td>
            <td width="330" align="center">
                    ��ǥġ �̴�
            </td>
            <td width="330" align="center">
              	60%�̻� ~ 80%�̸�
            </td>
            <td width="70" align="center">
              	7
            </td>            
          </tr>          
          
          <tr bgcolor="#FFFFFF" height="30">
            <td width="70" align="center">
              	D
            </td>
            <td width="330" align="center">
                    ��ǥġ �ſ� �̴�
            </td>
            <td width="330" align="center">
              	60% �̸�
            </td>
            <td width="70" align="center">
              	6
            </td>            
          </tr>          
                                   
        </table>








</div><!-- //evl_container �� -->



</body>
</html>