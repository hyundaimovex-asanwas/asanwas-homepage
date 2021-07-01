<!--
***********************************************************************
* @source      : pire030.jsp
* @description : �ڰ���/������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2008/08/18      �����        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�ڰ���/������Ȳ(pire030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTTFT';
		var today = getToday();

        var ActiveIndex = 0;


		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            var QUA_SHR = document.getElementById("txtQUA_SHR").value;
            var MAJ_SHR = document.getElementById("txtMAJ_SHR").value;

            var COMM_CNT = dsT_CM_COMMON.CountRow;
            var COMM_CD = '';
            var COMM_CNT_01 = dsT_CM_COMMON_01.CountRow;
            var COMM_CD_01 = '';

            if (dsT_CM_COMMON.CountRow > 0) {
                for (var i = 0; i < dsT_CM_COMMON.CountRow; i++) {
                    COMM_CD = COMM_CD + dsT_CM_COMMON.NameValue(i + 1, "COMM_CD") + ",";
                }
            }

            if (dsT_CM_COMMON_01.CountRow > 0) {
                for (var i = 0; i < dsT_CM_COMMON_01.CountRow; i++) {
                    COMM_CD_01 = COMM_CD_01 + dsT_CM_COMMON_01.NameValue(i + 1, "COMM_CD") + ",";
                }
            }

			if(ActiveIndex==1){   //�ڰ��� ��ȸ
			   	dsT_CM_QUALIFICATION.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire030.cmd.PIRE030CMD&S_MODE=SHR_01&QUA_SHR="+QUA_SHR+"&COMM_CNT="+COMM_CNT+"&COMM_CD="+COMM_CD;
			    dsT_CM_QUALIFICATION.reset();
			}else{               // ���� ��ȸ
				dsT_CM_SCHOOL.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire030.cmd.PIRE030CMD&S_MODE=SHR_02&MAJ_SHR="+MAJ_SHR+"&COMM_CNT_01="+COMM_CNT_01+"&COMM_CD_01="+COMM_CD_01;
			    dsT_CM_SCHOOL.reset();
			}

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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
        	alert("���� �غ����Դϴ�.");
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

	        if(ActiveIndex==1){
				if (dsT_CM_QUALIFICATION.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CM_QUALIFICATION.GridToExcel("�ڰ�����Ȳ", '', 225)

			}else{
				if (dsT_CM_SCHOOL.CountRow < 1) {
					alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
					return;
				}
	            form1.grdT_CM_SCHOOL.GridToExcel("������Ȳ", '', 225)
			}
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
         * 10. �ʱ�ȭ �Լ�  					    *
         ********************************************/
        function fnc_Clear() {

            document.getElementById("cmbRCV_DPT").length  = 0;
            document.getElementById("cmbRCV_DPT1").length = 0;

        	document.getElementById("resultMessage").innerText = '';

        	document.getElementById("txtQUA_SHR").value = '';
        	document.getElementById("txtMAJ_SHR").value = '';

        	dsT_CM_QUALIFICATION.ClearData();
        	dsT_CM_SCHOOL.ClearData();
        	dsT_CM_COMMON.ClearData();
        	dsT_CM_COMMON_01.ClearData();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  			    *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   *
         ********************************************/
        function fnc_OnLoadProcess() {
            //��ư�� �ʱ�ȭ
            TabEvent(0);


			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_CM_QUALIFICATION,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_CM_SCHOOL,0,"false","false");      // Grid Style ����


        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //Layer ID
        var layerList = new Array(  "tabPIRE030_01"
                                   ,"tabPIRE030_02" );

        //�˻�����
        var searchList = new Array( "changeDate_01"
                                   ,"changeDate_02" );

        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {

            ActiveIndex = idx+1;

            //Layer �����ְ� �ݱ�
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            fnc_ShowHiddenLayer(searchList, searchList[idx]);


            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";

        }

       /********************************************************
        * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
        *******************************************************/

       function fnc_selectDPT_01(ctrl_01) {

            var cd_gbn ='H1';
			var url = "./pire031.jsp?CD_GBN="+cd_gbn;
			window.showModalDialog(url, ctrl_01,  "dialogHeight:500px; dialogWidth:750px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			return ctrl_01;
		}


		function fnc_selectDPT_02(ctrl_01) {

            var cd_gbn ='E6';
			var url = "./pire031.jsp?CD_GBN="+cd_gbn;
			window.showModalDialog(url, ctrl_01,  "dialogHeight:500px; dialogWidth:750px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			return ctrl_01;
		}

       function find_Qua(){

            var tempDS = fnc_selectDPT_01(dsT_CM_COMMON);
			document.getElementById('cmbRCV_DPT').length = 0;

			var oOption;
			for(var i=0 ; i<tempDS.CountRow ; i++) {

				oOption = document.createElement("OPTION");
				oOption.text = tempDS.NameValue(i+1, 'COMM_CD')+" "+tempDS.NameValue(i+1, 'COMM_NM');
				oOption.value = tempDS.NameValue(i+1, 'COMM_CD');

				document.getElementById('cmbRCV_DPT').add(oOption);
			}
     	}

       function find_Maj(){

            var tempDS = fnc_selectDPT_02(dsT_CM_COMMON_01);
			document.getElementById('cmbRCV_DPT1').length = 0;

			var oOption;
			for(var i=0 ; i<tempDS.CountRow ; i++) {

				oOption = document.createElement("OPTION");
				oOption.text = tempDS.NameValue(i+1, 'COMM_CD')+" "+tempDS.NameValue(i+1, 'COMM_NM');
				oOption.value = tempDS.NameValue(i+1, 'COMM_CD');

				document.getElementById('cmbRCV_DPT1').add(oOption);
			}
       }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_QUALIFICATION)	   |
    | 3. ���Ǵ� Table List(T_CM_QUALIFICATION) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_SCHOOL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_COMMON)		   |
    | 3. ���Ǵ� Table List(dsT_CM_COMMON) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_COMMON_01)	   |
    | 3. ���Ǵ� Table List(dsT_CM_COMMON_01) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_COMMON_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_QUALIFICATION Event="OnLoadCompleted(iCount)">
  		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsT_CM_SCHOOL Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_CM_QUALIFICATION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
	<Script For=dsT_CM_SCHOOL Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� |
    +----------------------------------------------------------------->
	<Script For=dsT_CM_QUALIFICATION Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_CM_SCHOOL Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>




	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ڰ���/������Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�λ���Ȳ������<font color="#000000">�ڰ���/������Ȳ</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="500"></col>
                                <col width="*"></col>
                    </colgroup>
    				<tr>
    				    <td>&nbsp;</td>
    				    <td>
	                        <div id="changeDate_01" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:2;" >
                                <table width="100%" >
                                <col width="15%"></col>
                                <col width="20%"></col>
                                <col width="5%"></col>
                                <col width="*"></col>
                                <tr>
                                <td class="searchState" align="right">�ڰ���</td>
                                <td class="padding2423" align="left">
                                     <input type="text" id="txtQUA_SHR" name="txtQUA_SHR" size="10" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                </td>
                                <td> <select id="cmbRCV_DPT" name="cmbRCV_DPT"> </select> </td>
								<td>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgQualification" name="ImgQualification" width="21" height="20" border="0" align="absmiddle" onClick="find_Qua();"></a>
								</td>
                                </tr>
                                </table>
	       				    </div>
	                        <div id="changeDate_02" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:1; visibility:hidden" >
                                <table width="100%" >
                                <col width="15%"></col>
                                <col width="20%"></col>
                                <col width="5%"></col>
                                <col width="*"></col>
                               <tr>
                                <td class="searchState" align="right">����&nbsp;</td>
                                <td class="padding2423" align="left">
                                     <input type="text" id="txtMAJ_SHR" name="txtMAJ_SHR" size="10" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                </td>
                                <td> <select id="cmbRCV_DPT1" name="cmbRCV_DPT1"> </select> </td>
                                <td>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgQualification" name="ImgQualification" width="21" height="20" border="0" align="absmiddle" onClick="find_Maj();"></a>
								</td>
                                </tr>
                                </table>
	                        </div>
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
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->


    <!-- �� ��� ���۳�Ʈ ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8" align="left">

                <!-- �ǹ�ư���̺� ���� -->
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="120">
                            <!-- �ǿ��� -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">�ڰ�����Ȳ</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <!-- ������ -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">������Ȳ</td>
                                    <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="2" bgcolor="#A4A4A1"></td>
                    </tr>
                </table>
                <!-- �ǹ�ư���̺� �� -->
            </td>
        </tr>
    </table>


	<!-- ��1 ���� �Է� ���̺� ���� -->
	<div class=page id="tabPIRE030_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_QUALIFICATION">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value= '
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}   </C>
							<C> id="QUA_NM"     width=250   name="�ڰ���"       align=center    suppress = "1"</C>
							<C> id="DPT_NM"		width=135	name="�Ҽ�"		    align=left      leftMargin="10" </C>
							<C> id="JOB_NM"		width=125	name="����"		    align=center	</C>
							<C> id="ENO_NO"		width=115	name="���"		    align=center	</C>
							<C> id="ENO_NM"		width=115	name="����"		    align=center	</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</div>
	<!-- ��1 ���� �Է� ���̺� �� -->

	<!-- ��2 ���� �Է� ���̺� ���� -->
	<div class=page id="tabPIRE030_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_SCHOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_SCHOOL">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}  </C>
                            <C> id="MAJ_NM"     width=170   name="����"     align=center    suppress = "1"  </C>
							<C> id="DPT_NM"		width=135	name="�Ҽ�"		align=left		leftMargin="10" </C>
							<C> id="JOB_NM"		width=90	name="����"		align=center	                </C>
							<C> id="ENO_NO"		width=90	name="���"		align=center	                </C>
							<C> id="ENO_NM"		width=90	name="����"		align=center	                </C>
							<C> id="SCH_NAM"    width=165   name="�б�"     align=left      leftMargin="10" </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	</div>
	<!-- ��2 ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->
</body>
</html>

