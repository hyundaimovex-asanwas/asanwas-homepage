<!--
    ******************************************************************
    * @Source              : codb010.jsp                                                                       *
    * @Description        : �����ڵ���                                                                                          *
    * @Font                   :                                                                                      *
    * @Developer Desc :                                                                                          *
    *******************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                               *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�															   *
    *******************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�����ڵ���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

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
        	
			var f = document.form1;
			
			//if (!valid(form1)) return;//Validation ����
			
			try {
				
	            dsT_CM_COMMON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb010.cmd.CODB010CMD&S_MODE=SHR&COMM_CD="+f.txtCOMM_CD_SHR.value;
	            
	            //prompt(this,dsT_CM_COMMON.DataID);
	            
	            dsT_CM_COMMON.Reset();
	            
			} catch ( exception ) {
				
				fcWindowsXpSp2Notice(false);
				return;
				
			}
			
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
			var f = document.form1;
			if(fnc_SaveItemCheck()) {
				tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
				tr01T_CM_COMMON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb010.cmd.CODB010CMD&S_MODE=SAV";
				tr01T_CM_COMMON.post();

	            dsT_CM_COMMON.Reset();

	            ds01T_CM_COMMON.Reset();
			} else {
				return;
			}
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (ds01T_CM_COMMON.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");//�޼����� �����ε� ������ �������
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + ds01T_CM_COMMON.ColumnString(ds01T_CM_COMMON.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            ds01T_CM_COMMON.DeleteRow(ds01T_CM_COMMON.RowPosition);
			tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
			tr01T_CM_COMMON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb010.cmd.CODB010CMD&S_MODE=DEL";
			tr01T_CM_COMMON.post();
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
            // �ش� Dataset�� Header�� ������ Header ����
            if (ds01T_CM_COMMON.CountColumn == 0) {
                ds01T_CM_COMMON.setDataHeader("CD_GBN:STRING, COMM_CD:STRING, COMM_NM:STRING, COMM_NM2:STRING, STR_YMD:STRING, END_YMD:STRING, SORT_NO:DECIMAL, GBN2_TAG:STRING, EXT_01:STRING, EXT_02:STRING, EXT_03:STRING, EXT_04:STRING, REMARK:STRING, REMARK2:STRING, REMARK3:STRING, OTH_DEC:STRING");
            }

            // AddNew �� �Է� ���̺�� ��Ŀ��
            ds01T_CM_COMMON.AddRow();

            enableInput();// �Է��ʵ� Ȱ��ȭ

            var oCD_GBN = dsT_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition,"COMM_CD");
            if(oCD_GBN == undefined){
	            oCD_GBN = "**";
            }
            //ds01T_CM_COMMON.NameValue(dsT_CM_COMMON.RowPosition, "STR_YMD") = getToday();

            document.getElementById("txtCD_GBN").value = oCD_GBN;
			document.getElementById("txtCOMM_CD").focus();
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
        	
			dsT_CM_COMMON.ClearData();
			ds01T_CM_COMMON.ClearData();
			fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtCOMM_CD_SHR").focus();
			
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
        	
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CM_COMMON.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

			window.close();
			
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
   			var f = document.form1;

			//DataSet�� ���� ���� Ȯ��
			if (!ds01T_CM_COMMON.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oCD_GBN, oCOMM_CD, oCOMM_NM, oSORT_NO, oEND_YMD;
			var RowCnt = ds01T_CM_COMMON.CountRow;
			for(i=1; i<=RowCnt; i++){

				oCD_GBN = ds01T_CM_COMMON.NameValue(i,"CD_GBN");
				if(oCD_GBN.trim() == ""){
					alert(i+"��°�� ���뱸���ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCD_GBN").focus();
					return false;
				}

				oCOMM_CD = ds01T_CM_COMMON.NameValue(i,"COMM_CD");
				if(oCOMM_CD.trim() == ""){
					alert(i+"��°�� �ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCOMM_CD").focus();
					return false;
				}

				oCOMM_NM = ds01T_CM_COMMON.NameValue(i,"COMM_NM");
				if(oCOMM_NM.trim() == ""){
					alert(i+"��°�� �ڵ��1�� �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCOMM_NM").focus();
					return false;
				}

				/*
				oSORT_NO = ds01T_CM_COMMON.NameValue(i,"SORT_NO");
				if(oSORT_NO.toString().trim().length == 0 || oSORT_NO == 0){
					alert(i+"��°�� ���ļ�����  �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.medSORT_NO.Focus();
					return false;
				}
				*/

				oEND_YMD = ds01T_CM_COMMON.NameValue(i,"END_YMD");
				if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){
					alert(i+"��°�� ������ڰ�  �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtEND_YMD").focus();
					return false;
				}
			}

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	
            //Grid Style ����
			cfStyleGrid_New(form1.grdT_CM_COMMON,15,"false","right");
			cfStyleGrid_New(form1.grd01T_CM_COMMON,15,"false","right");

			disableInput();//�Է��ʵ� ��Ȱ��ȭ
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){

			document.form1.txtCD_GBN.readOnly = false;
			document.form1.txtCD_GBN.className = "";
			document.form1.txtCOMM_CD.readOnly = false;
			document.form1.txtCOMM_CD.className = "";
			document.form1.txtCOMM_NM.readOnly = false;
			document.form1.txtCOMM_NM.className = "";
			document.form1.txtCOMM_NM2.readOnly = false;
			document.form1.txtCOMM_NM2.className = "";
			document.form1.txtSTR_YMD.readOnly = false;
			document.form1.txtSTR_YMD.className = "";
  			document.getElementById("imgSTR_YMD").disabled = false;
			document.form1.txtEND_YMD.readOnly = false;
			document.form1.txtEND_YMD.className = "";
  			document.getElementById("imgEND_YMD").disabled = false;
			form1.medSORT_NO.Enable = "true";
			document.form1.txtGBN2_TAG.readOnly = false;
			document.form1.txtGBN2_TAG.className = "";
			document.form1.txtEXT_01.readOnly = false;
			document.form1.txtEXT_01.className = "";
			document.form1.txtEXT_02.readOnly = false;
			document.form1.txtEXT_02.className = "";
			document.form1.txtEXT_03.readOnly = false;
			document.form1.txtEXT_03.className = "";
			document.form1.txtEXT_04.readOnly = false;
			document.form1.txtEXT_04.className = "";
			document.form1.txtREMARK.readOnly = false;
			document.form1.txtREMARK.className = "";
			document.form1.txtREMARK2.readOnly = false;
			document.form1.txtREMARK2.className = "";
			document.form1.txtREMARK3.readOnly = false;
			document.form1.txtREMARK3.className = "";
			document.form1.txtOTH_DEC.readOnly = false;
			document.form1.txtOTH_DEC.className = "";

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtCD_GBN.readOnly = true;
			document.form1.txtCD_GBN.className = "input_ReadOnly";
			document.form1.txtCOMM_CD.readOnly = true;
			document.form1.txtCOMM_CD.className = "input_ReadOnly";
			document.form1.txtCOMM_NM.readOnly = true;
			document.form1.txtCOMM_NM.className = "input_ReadOnly";
			document.form1.txtCOMM_NM2.readOnly = true;
			document.form1.txtCOMM_NM2.className = "input_ReadOnly";
			document.form1.txtSTR_YMD.readOnly = true;
			document.form1.txtSTR_YMD.className = "input_ReadOnly";
  			document.getElementById("imgSTR_YMD").disabled = true;
			document.form1.txtEND_YMD.readOnly = true;
			document.form1.txtEND_YMD.className = "input_ReadOnly";
  			document.getElementById("imgEND_YMD").disabled = true;
			form1.medSORT_NO.Enable = "false";
			document.form1.txtGBN2_TAG.readOnly = true;
			document.form1.txtGBN2_TAG.className = "input_ReadOnly";
			document.form1.txtEXT_01.readOnly = true;
			document.form1.txtEXT_01.className = "input_ReadOnly";
			document.form1.txtEXT_02.readOnly = true;
			document.form1.txtEXT_02.className = "input_ReadOnly";
			document.form1.txtEXT_03.readOnly = true;
			document.form1.txtEXT_03.className = "input_ReadOnly";
			document.form1.txtEXT_04.readOnly = true;
			document.form1.txtEXT_04.className = "input_ReadOnly";
			document.form1.txtREMARK.readOnly = true;
			document.form1.txtREMARK.className = "input_ReadOnly";
			document.form1.txtREMARK2.readOnly = true;
			document.form1.txtREMARK2.className = "input_ReadOnly";
			document.form1.txtREMARK3.readOnly = true;
			document.form1.txtREMARK3.className = "input_ReadOnly";
			document.form1.txtOTH_DEC.readOnly = true;
			document.form1.txtOTH_DEC.className = "input_ReadOnly";

  		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                                      |
    | 2. �̸� : dsT_CM_COMMON                                      |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CM_COMMON                                  |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID="ds01T_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : tr01T_CM_COMMON                                    |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CM_COMMON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			enableInput();//�Է��ʵ� Ȱ��ȭ
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_COMMON.CountRow);
        }
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CM_COMMON.CountRow);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_COMMON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr01T_CM_COMMON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr01T_CM_COMMON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid���� row�� Ŭ��������      |
    +------ -------------------->
	<script for=grdT_CM_COMMON event=OnClick(Row,Colid)>

		var overId = "COMM_CD";
		
		var overValue = dsT_CM_COMMON.NameValue(Row,overId);
		
		try {
			ds01T_CM_COMMON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb010.cmd.CODB010CMD&S_MODE=SHR_01&"+overId+"="+overValue;
			ds01T_CM_COMMON.Reset();

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
			
		}
		
	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->



<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ȭ�� ����-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">
						<!-- power Search���̺� ���� -->
						<table width="300" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="paddingTop8">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" class="blueTable">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<colgroup>
														<col width="100"></col>
														<col width=""></col>
														<col width="60"></col>
													</colgroup>
													<tr>
														<td align="right" class="searchState">�ڵ�/�ڵ��</td>
														<td align="center"><input name="txtCOMM_CD_SHR" style="width 100%;" class="divInput" onKeypress="javascript:if(event.keyCode==13)fnc_SearchList()"></td>
														<td align="left"></td>
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
						<table width="300" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						        <td class="paddingTop15">
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
						<table width="300" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:470px;">
						                            <param name="DataID"						value="dsT_CM_COMMON">
						                            <param name="EdiTABLE"					value="false">
						                            <param name="DragDropEnable"			value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"			value=0>
						                            <param name="Format"						value="
						                                <C> id='CURROW'		width=40		name='NO'							align=center		value={String(Currow)}  	</C>
						                                <C> id='COMM_CD'	width=70		name='�ڵ�'			sort=true	align=center 		</C>
						                                <C> id='COMM_NM'	width=154		name='�ڵ��'		sort=true	align=left			</C>
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

					</td>
				</tr>
			</table>
			<!-- ���� ȭ�� ��-->
		</td>
		<td>
			<!-- ������ ȭ�� ����-->
			<table width="690" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- ���� �Է� ���̺� ���� -->
						<table width="690" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width="250"></col>
											<col width="90"></col>
											<col width=""></col>
										</colgroup>
										<tr>
											<td align="center" class="blueBold">���뱸���ڵ�</td>
											<td class="padding2423"><input id="txtCD_GBN" style="width:100%" maxlength="2"></td>
											<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��</td>
											<td class="padding2423"><input id="txtCOMM_CD" style="width:100%"  maxlength="5"></td>
										</tr>
										<tr>
											<td align="center" class="blueBold">�ڵ��1</td>
											<td class="padding2423"><input id="txtCOMM_NM" style="width:100%" maxlength="50"></td>
											<td align="center" class="blueBold">�ڵ��2</td>
											<td class="padding2423"><input id="txtCOMM_NM2" style="width:100%" maxlength="50"></td>
										</tr>
										<tr>
											<td align="center" class="blueBold">�������</td>
											<td class="padding2423">
												<input id="txtSTR_YMD" style="width:80%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
												<!--  
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtSTR_YMD','','390','150');"></a>
												-->
											</td>
											<td align="center" class="blueBold">�������</td>
											<td class="padding2423">
												<input id="txtEND_YMD" style="width:80%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
												<!-- 
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','640','150');"></a>
												-->
											</td>
										</tr>
										<tr>
											<td align="center" class="blueBold">���ļ���</td>
											<td class="padding2423">
												<comment id="__NSID__"><object id="medSORT_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
													<param name=Alignment					value=0>
													<param name=Border						value=true>
													<param name=ClipMode						value=true>
													<param name=DisabledBackColor			value="#EEEEEE">
													<param name=Enable						value=true>
													<param name=IsComma					value=true>
													<param name=Language					value=0>
													<param name=MaxLength					value=4>
													<param name=Numeric						value=true>
													<param name=ShowLiteral					value="false">
													<param name=Visible							value="true">
												</object></comment><script> __ShowEmbedObject(__NSID__); </script>
											</td>
											<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��2</td>
											<td class="padding2423"><input id="txtGBN2_TAG" style="width:100%" maxlength="2"></td>
										</tr>
										<tr>
											<td align="center" class="blueBold">��Ÿ�׸�1</td>
											<td class="padding2423"><input id="txtEXT_01" style="width:100%" maxlength="50"></td>
											<td align="center" class="blueBold">��Ÿ�׸�2</td>
											<td class="padding2423"><input id="txtEXT_02" style="width:100%" maxlength="50"></td>
										</tr>
										<tr>
											<td align="center" class="blueBold">��Ÿ�׸�3</td>
											<td class="padding2423"><input id="txtEXT_03" style="width:100%" maxlength="50"></td>
											<td align="center" class="blueBold">��Ÿ�׸�4</td>
											<td class="padding2423"><input id="txtEXT_04" style="width:100%" maxlength="50"></td>
										</tr>
										<tr>
											<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��1</td>
											<td class="padding2423"><input id="txtREMARK" style="width:100%" maxlength="20"></td>
											<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��2</td>
											<td class="padding2423"><input id="txtREMARK2" style="width:100%" maxlength="60"></td>
										</tr>
										<tr>
											<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��3</td>
											<td class="padding2423"><input id="txtREMARK3" style="width:100%" maxlength="20"></td>
											<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;Ÿ</td>
											<td class="padding2423"><input id="txtOTH_DEC" style="width:100%" maxlength="50"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- ���� �Է� ���̺� �� -->

						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="690" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grd01T_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:690px;height:351px;">
						                            <param name="DataID"						value="ds01T_CM_COMMON">
						                            <param name="EdiTABLE"					value="false">
						                            <param name="DragDropEnable"			value="true">
						                            <param name="SortView"					value="Left">
						                            <param name="VIEWSUMMARY"			value=0>
						                            <param name="Format"						value="
						                                <C> id='CURROW'		width=50		name='NO'							align=center		value={String(Currow)}	</C>
						                                <C> id='COMM_CD'	width=80		name='�ڵ�'			sort=true	align=center 										</C>
						                                <C> id='COMM_NM'	width=240		name='�ڵ��'		sort=true	align=left				                    		</C>
						                                <C> id='SORT_NO'	width=80		name='���ļ���'	sort=true	align=left			value={String(SORT_NO)}	</C>
						                                <C> id='STR_YMD'	width=100		name='�������'	sort=true	align=center										 	</C>
						                                <C> id='END_YMD'	width=100		name='�������'	sort=true	align=center										 	</C>
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

					</td>
				</tr>
			</table>
			<!-- ������ ȭ�� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_CM_COMMON                                   |
    | 3. Table List : T_CM_COMMON                                 |
    +----------------------------------------------->
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="ds01T_CM_COMMON">
		<Param Name="BindInfo", Value="
			<C>Col='CD_GBN'			Ctrl='txtCD_GBN'				Param=value</C>
			<C>Col='COMM_CD'		Ctrl='txtCOMM_CD'			Param=value</C>
			<C>Col='COMM_NM'		Ctrl='txtCOMM_NM'			Param=value</C>
			<C>Col='COMM_NM2'		Ctrl='txtCOMM_NM2'			Param=value</C>
			<C>Col='STR_YMD'		Ctrl='txtSTR_YMD'			Param=value</C>
			<C>Col='END_YMD'		Ctrl='txtEND_YMD'			Param=value</C>
			<C>Col='SORT_NO'		Ctrl='medSORT_NO'			Param=text	</C>
			<C>Col='GBN2_TAG'		Ctrl='txtGBN2_TAG'			Param=value</C>
			<C>Col='EXT_01'			Ctrl='txtEXT_01'				Param=value</C>
			<C>Col='EXT_02'			Ctrl='txtEXT_02'				Param=value</C>
			<C>Col='EXT_03'			Ctrl='txtEXT_03'				Param=value</C>
			<C>Col='EXT_04'			Ctrl='txtEXT_04'				Param=value</C>
			<C>Col='REMARK'			Ctrl='txtREMARK'				Param=value</C>
			<C>Col='REMARK2'		Ctrl='txtREMARK2'				Param=value</C>
			<C>Col='REMARK3'		Ctrl='txtREMARK3'				Param=value</C>
			<C>Col='OTH_DEC'		Ctrl='txtOTH_DEC'			Param=value</C>
	    ">
	</object>
