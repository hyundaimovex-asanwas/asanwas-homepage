<!--
    ************************************************************************************
    * @Source         : codc010.jsp 					                               *
    * @Description    : ����ں� ���Ѱ���.   										   *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/15  |  ���ؼ�   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>����ں����Ѱ���(codc010)</title>
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

		var btnList = 'TFTTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


			//��ȸ�� ��ȿ�� üũ
			if( !fnc_SearchItemCheck() ) return;

            dsT_CM_USERAUTH.UseChangeInfo = true;    //false ������ �Է�

           //�����ͼ� ����
            dsT_CM_USERAUTH.DataID = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc010.cmd.CODC010CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_USERAUTH.Reset();

            form1.mgrdT_CM_USERAUTH.CollapseAll();

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

			if( !fnc_SaveItemCheck() ) return;

			for( i=1; i<= dsT_CM_USERAUTH.CountRow; i++ ) {
				if( dsT_CM_USERAUTH.NameValue(i,"T_CHECK") == 'T' )
					dsT_CM_USERAUTH.NameValue(i,"T_CHECK") = 'F';
			}

			for( i=1; i<= dsT_CM_USERAUTH.CountRow; i++ ) {
				if( dsT_CM_USERAUTH.RowStatus(i) == 3 ) {
					if( dsT_CM_USERAUTH.NameValue(i,"IO_FLG") == 'I' ) {
						dsT_CM_USERAUTH.UserStatus(i) = 1;
					}
				}
			}

			//Ʈ����� ����
            trT_CM_USERAUTH.KeyValue = "SVL(I:SAV=dsT_CM_USERAUTH)";
			trT_CM_USERAUTH.Action = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc010.cmd.CODC010CMD&S_MODE=SAV";
			trT_CM_USERAUTH.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
            var oENO_NO = document.getElementById("txtENO_NO_SHR");
            var oENO_NM = document.getElementById("txtENO_NM_SHR");

            if(oENO_NO.value == "" || oENO_NM.value == "") {
                alert("��� ������ �Է��� �ּ���.");
                oENO_NO.focus();
                return;
            }

            if(dsT_CM_USERAUTH.CountColumn == 0) {
                alert("��ȸ �� ����ϼ���");
                return;
            }

            if(!confirm(oENO_NM.value+"("+oENO_NO.value+") �� ��� ������ �����˴ϴ�.\n����Ͻðڽ��ϱ�?")) {
                return;
            }

            dsT_CM_USERAUTH.UseChangeInfo = false;    //false ������ �Է�

            //Ʈ����� ����
            trT_CM_USERAUTH.KeyValue = "SVL(I:SAV=dsT_CM_USERAUTH)";
            trT_CM_USERAUTH.Action = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc010.cmd.CODC010CMD&S_MODE=DEL&ENO_NO="+oENO_NO.value;
            trT_CM_USERAUTH.Post();
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

			document.getElementById("resultMessage").innerText = ' ';

			dsT_CM_USERAUTH.ClearAll();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_CM_USERAUTH.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			if( document.getElementById("txtENO_NO_SHR").value == '' ) {
				alert("����� �������ּ���.");
				return false;
			}
			return true;
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	if( !dsT_CM_USERAUTH.isUpdated ) {
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

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*********************
        * ������ �̿��� �˻� *
        *********************/
        function fnc_UsrGetEnoNo() {

            if (document.getElementById("txtENO_NM_SHR").value  == "") {

                fnc_Clear();
                return;
            }

            // ������ ��ü
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');


            if (document.getElementById("txtENO_NO_SHR").value  == "") {

                fnc_Clear();
                return;
            }
            else {

                fnc_SearchList();
            }
        }

        /**
         * ��� ������ �����Ѵ�.
         */
        function selectCheckAll() {
            for(var i=1; i<=dsT_CM_USERAUTH.CountRow; i++) {
                //�޴� ���� 'm' �޴�, 'f' �����޴�
                if(dsT_CM_USERAUTH.NameValue(i, "MENU_GBN") == "f") {
                    dsT_CM_USERAUTH.NameValue(i, "T_CHECK") = 'T';
                    dsT_CM_USERAUTH.NameValue(i, "BTN_01")  = 'T';
                    dsT_CM_USERAUTH.NameValue(i, "BTN_02")  = 'T';
                    dsT_CM_USERAUTH.NameValue(i, "BTN_03")  = 'T';
                    dsT_CM_USERAUTH.NameValue(i, "BTN_04")  = 'T';
                    dsT_CM_USERAUTH.NameValue(i, "BTN_05")  = 'T';
                    dsT_CM_USERAUTH.NameValue(i, "BTN_06")  = 'T';
                }
            }
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->

    <Object ID="dsT_CM_USERAUTH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
	    <Param name="SubsumExpr"	value="3:MENU_NM1,2:MENU_NM2">
    </Object>

	<object id=imgDsT_CM_USERAUTH classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
	     <param name="DataID"        value="service.csv">
	</object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_CM_USERAUTH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


	<script language=JavaScript for=mgrdT_CM_USERAUTH event="OnLButtonDown(type, index, colid, x, y)">
        var checkVal;
        var menu_lbl;

        //�޴����϶� ����
        if( colid == 'MENU_NM' ) {
            return;
        }

        //INDEX�� RowPosition �̶� ���� (�� �������� �־� ����)
        if(mgrdT_CM_USERAUTH.RowPosition != index)
            mgrdT_CM_USERAUTH.RowPosition = index;

        //TYPE�� VIEW �̰� ��ü ������ ���
		if( type == 3 && colid == 'T_CHECK' ) {

            if(dsT_CM_USERAUTH.NameValue(index, "T_CHECK") == "T") {
                checkVal = "F"
            } else {
                checkVal = "T"
            }
            //��ü ���� â ������
            dsT_CM_USERAUTH.NameValue(index, "T_CHECK") = checkVal;

            menu_lbl = dsT_CM_USERAUTH.NameValue(index, "MENU_LBL");    //�޴� ����


            //������ �޴��� �̴ϸ� �ش�Ǵ� �ٸ� ���� ��Ŵ  - �޴� ���� 'm' �޴�, 'f' �����޴�
            if(dsT_CM_USERAUTH.NameValue(index, "MENU_GBN") == "f") {


                dsT_CM_USERAUTH.NameValue(index, "BTN_01")  = checkVal;
                dsT_CM_USERAUTH.NameValue(index, "BTN_02")  = checkVal;
                dsT_CM_USERAUTH.NameValue(index, "BTN_03")  = checkVal;
                dsT_CM_USERAUTH.NameValue(index, "BTN_04")  = checkVal;
                dsT_CM_USERAUTH.NameValue(index, "BTN_05")  = checkVal;
                dsT_CM_USERAUTH.NameValue(index, "BTN_06")  = checkVal;

            } else {
                for(var i=index+1; i<=dsT_CM_USERAUTH.CountRow; i++) {
                    //������ �޴� �������� ũ�ų� ���� �޴��� ������ ����
                    if(menu_lbl >= dsT_CM_USERAUTH.NameValue(i, "MENU_LBL")) return;

                    if(dsT_CM_USERAUTH.NameValue(i, "MENU_GBN") == "f") {

                        dsT_CM_USERAUTH.NameValue(i, "T_CHECK") = checkVal;
                        dsT_CM_USERAUTH.NameValue(i, "BTN_01")  = checkVal;
                        dsT_CM_USERAUTH.NameValue(i, "BTN_02")  = checkVal;
                        dsT_CM_USERAUTH.NameValue(i, "BTN_03")  = checkVal;
                        dsT_CM_USERAUTH.NameValue(i, "BTN_04")  = checkVal;
                        dsT_CM_USERAUTH.NameValue(i, "BTN_05")  = checkVal;
                        dsT_CM_USERAUTH.NameValue(i, "BTN_06")  = checkVal;
                    } else {
                        dsT_CM_USERAUTH.NameValue(i, "T_CHECK") = checkVal;
                    }
                }

            }

		}

        //�����ϰ�� �����ΰ� ����
        else {
			if( dsT_CM_USERAUTH.NameValue(index, colid) == 'F' )
				dsT_CM_USERAUTH.NameValue(index, colid) = 'T';
			else if( dsT_CM_USERAUTH.NameValue(index, colid) == 'T' )
				dsT_CM_USERAUTH.NameValue(index, colid) = 'F';
		}

	</script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->

    <Script For=dsT_CM_USERAUTH Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_USERAUTH.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_USERAUTH Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_USERAUTH Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_USERAUTH event="OnSuccess()">
		fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_USERAUTH event="OnFail()">

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
						<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ں� ���Ѱ���</td>
						<td align="right" class="navigator">HOME/��������/���Ѱ���/<font color="#000000">����ں� ���Ѱ���</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
									<col width="100"></col>
									<col width="250"></col>
									<col width="580"></col>
								</colgroup>
								<tr>
									<td align="right" class="searchBold">���&nbsp;</td>
									<td><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="if (event.keyCode == 13) fnc_SearchList();cfNumberCheck(); " onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
									<input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR', '1');}">
								<!-- 	<input id=txtENO_NM_SHR size="8" style="text-align:center" class="input_ReadOnly" readonly>  -->
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
									</td>
									<td>&nbsp;</td>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td align="right" valign="bottom">
                            <img src="/images/button/btn_AllselectOn.gif" name="all_select" border="0" align="absmiddle" onclick="selectCheckAll()" style="cursor:hand;"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('all_select','','/images/button/btn_AllselectOver.gif',1)">
                        </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8" style="padding-top:1">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td height="2" bgcolor="#A4A4A1"></td>
	                </tr>
	            </table>
			</td>
		</tr>
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							  <object id=mgrdT_CM_USERAUTH classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=800 height=350>
							    <Param Name="DataID"		value="dsT_CM_USERAUTH">
							    <param name="ImageDataID"		value="imgDsT_CM_USERAUTH">
							    <Param Name="Sort"		value="false">
							    <Param Name="ColumnInfo"		value='
							      <COLUMNINFO>
							    	<COLUMN id="MENU_NM" refcolid="MENU_NM">
							    		<TREE type="2" levelcolumn="MENU_LBL"/>
							    		<HEADER left="0" top="0" right="403" bottom="30" bgcolor="#F7DCBB" text="�޴�"/>
							    		<VIEW left="0" top="0" right="403" bottom="23"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="T_CHECK" refcolid="T_CHECK">
							    		<HEADER left="403" top="0" right="463" bottom="30" bgcolor="#F7DCBB" text="��ü����"/>
							    		<VIEW type="check" left="403" top="0" right="463" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_01" refcolid="BTN_01">
							    		<HEADER left="463" top="0" right="513" bottom="30" bgcolor="#F7DCBB" text="�ű�"/>
							    		<VIEW left="463" top="0" right="513" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_02" refcolid="BTN_02">
							    		<HEADER left="513" top="0" right="563" bottom="30" bgcolor="#F7DCBB" text="��ȸ"/>
							    		<VIEW left="513" top="0" right="563" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_03" refcolid="BTN_03">
							    		<HEADER left="563" top="0" right="613" bottom="30" bgcolor="#F7DCBB" text="����"/>
							    		<VIEW left="563" top="0" right="613" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_04" refcolid="BTN_04">
							    		<HEADER left="613" top="0" right="663" bottom="30" bgcolor="#F7DCBB" text="����"/>
							    		<VIEW left="613" top="0" right="663" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_05" refcolid="BTN_05">
							    		<HEADER left="663" top="0" right="713" bottom="30" bgcolor="#F7DCBB" text="�μ�"/>
							    		<VIEW left="663" top="0" right="713" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
							    	</COLUMN>
							    	<COLUMN id="BTN_06" refcolid="BTN_06">
							    		<HEADER left="713" top="0" right="763" bottom="30" bgcolor="#F7DCBB" text="��Ÿ"/>
							    		<VIEW left="713" top="0" right="763" bottom="23"/>
							    		<CHILD type="image"/>
							    		<GROUP level="3" bgcolor="#FFFFFF"/>
							    		<GROUP level="2" bgcolor="#FFFFFF"/>
							    		<GROUP level="1" bgcolor="#FFFFFF"/>
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

</body>
</html>