<!--
***********************************************************************
* @source      : pire040.jsp
* @description : ����/���������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/08/27      �幮��        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>����/�������Ȳ(pire040)</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTTTFT';
		var today = getToday();

        var ActiveIndex = 0;


		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            var	bas_ymd_shr1 = document.getElementById("txtBAS_YMD_SHR1").value;
            var	bas_ymd_shr = document.getElementById("txtBAS_YMD_SHR").value;

			if(ActiveIndex==1){   //���ƴ���� ��ȸ
	        	document.getElementById("imgPrint").style.display = "none";
	        	document.getElementById("imgPrint").disabled = true;
			   	dsT_CM_PERSON1.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire040.cmd.PIRE040CMD&S_MODE=SHR_01&BAS_YMD_SHR1="+bas_ymd_shr1;
			    dsT_CM_PERSON1.reset();
			}else{               //����αٷ��� ��ȸ
	        	document.getElementById("imgPrint").style.display = "";
		       	document.getElementById("imgPrint").disabled = false;
				dsT_CM_PERSON2.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire040.cmd.PIRE040CMD&S_MODE=SHR_02&BAS_YMD_SHR="+bas_ymd_shr;
			    dsT_CM_PERSON2.reset();
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
            var	bas_ymd_shr = document.getElementById("txtBAS_YMD_SHR").value;

    	    var url = "pire040_PV.jsp?BAS_YMD_SHR="+bas_ymd_shr;
	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

	        if(ActiveIndex==1){
				if (dsT_CM_PERSON1.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_CM_PERSON1.GridToExcel("���ƴ������Ȳ", '', 225)

			}else{
				if (dsT_CM_PERSON2.CountRow < 1) {
					alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
					return;
				}
	            form1.grdT_CM_PERSON2.GridToExcel("����αٷ�����Ȳ", '', 225)
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

        	document.getElementById("resultMessage").innerText = '';

        	document.getElementById("txtBAS_YMD_SHR1").value = '';
        	document.getElementById("txtBAS_YMD_SHR").value = '';

        	dsT_CM_PERSON1.ClearData();
        	dsT_CM_PERSON2.ClearData();
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
			cfStyleGrid(form1.grdT_CM_PERSON1,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_CM_PERSON2,0,"false","false");      // Grid Style ����

			//��ȸ���� ��¥ �⺻ ����
		    document.getElementById('txtBAS_YMD_SHR1').value = getToday().substring(0,4);
		    document.getElementById('txtBAS_YMD_SHR').value = getToday().substring(0,4);


        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //Layer ID
        var layerList = new Array(  "tabpire040_01"
                                   ,"tabpire040_02" );

        //�˻�����
        var searchList = new Array( "changeDate_01"
                                   ,"changeDate_02" );

        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {

            ActiveIndex = idx+1;

			if(ActiveIndex==1){   //���ƴ���� �μ� ��ư ����
	        	document.getElementById("imgPrint").style.display = "none";
	        	document.getElementById("imgPrint").disabled = true;
			}else{               //����αٷ��� �μ� ��ư ����
	        	document.getElementById("imgPrint").style.display = "";
		       	document.getElementById("imgPrint").disabled = false;
			}

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
	    /********************************************
    	* ��¥ ���� ��ȿ�� üũ                     *
	    ********************************************/
        function fnc_CheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON1)	   |
    | 3. ���Ǵ� Table List(T_CM_PERSON1) 		   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
	<Script For=dsT_CM_PERSON1 Event="OnLoadCompleted(iCount)">
  		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsT_CM_PERSON2 Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_CM_PERSON1 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
	<Script For=dsT_CM_PERSON2 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� |
    +----------------------------------------------------------------->
	<Script For=dsT_CM_PERSON1 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_CM_PERSON2 Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����/�������Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�λ���Ȳ������<font color="#000000">����/�������Ȳ</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
    				<tr>
    				    <td>&nbsp;</td>
    				    <td>
	                        <div id="changeDate_01" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:2;" >
                                <table width="100%">
                                <col width="10%"></col>
                                <col width="*"></col>
                                <tr>
                                <td class="searchState" align="right">���س⵵</td>
		                        <td class="padding2423" align="left">
			                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
			                            <tr>
			                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
			                                    <input type="text" id="txtBAS_YMD_SHR1" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
			                                </td>
			                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR1', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
			                            </tr>
			                            <tr>
			                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR1', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
			                            </tr>
			                        </table>
								</td>
								</td>
                                </tr>
                                </table>
	       				    </div>
							<div id="changeDate_02" style="position:absolute; left:132; top:86; width:100%; height:20; z-index:1; visibility:hidden" >
                                <table width="100%">
                                <col width="10%"></col>
                                <col width="*"></col>
								<tr>
									<td class="searchState" align="right">���س⵵&nbsp;</td>
									<td class="padding2423" align="left">
				                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
				                            <tr>
				                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
				                                    <input type="text" id="txtBAS_YMD_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
				                                </td>
				                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
				                            </tr>
				                            <tr>
				                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtBAS_YMD_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
				                            </tr>
				                        </table>

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
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)"  style="cursor:hand" id="TabBtn01">���ƴ������Ȳ</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <!-- ������ -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">����αٷ�����Ȳ</td>
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
	<div class=page id="tabpire040_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_PERSON1" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_PERSON1">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value= '
							<FC> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}  </FC>
							<FC> id="ENO_NO"		width=60	name="���"		align=center					</FC>
							<FC> id="ENO_NM"		width=60	name="����"		align=center					</FC>
							<C> id="AGE"		width=39	name="����"		align=center 					</C>
							<G> name="�з»���" align=center HeadBgColor="#F7DCBB"
								<C> id="SCH_NAM"    width=120   name="�б�"     align=left      leftMargin="10" </C>
    	                        <C> id="MAJ_NM"     width=120   name="����"     align=left    	leftMargin="10"  </C>
        	                    <C> id="GRD_YY"		width=50	name="�����⵵" align=center					</C>
                            </G>
							<C> id="DPT_NM"		width=90	name="�Ҽ�"		align=left		leftMargin="10" </C>
							<C> id="HIR_YMD"	width=80	name="�Ի���"	align=center					</C>
							<C> id="RET_YMD"	width=80	name="������"	align=center					</C>
							<C> id="OCC_NM"		width=60	name="�ٷα���"		align=center					</C>
							<C> id="JOB_NM"		width=40	name="����"		align=center	                </C>
							<C> id="MPVA_NM"	width=80	name="���"		align=left		leftMargin="10" </C>
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
	<div class=page id="tabpire040_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_PERSON2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_CM_PERSON2">
						<param name="Format" value='
							<FC> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}  </FC>
							<FC> id="ENO_NO"	width=60	name="���"		align=center						</FC>
							<FC> id="ENO_NM"	width=60	name="����"		align=center						</FC>
							<C> id="CET_NO"     width=100   name="�ֹε�Ϲ�ȣ"  align=left      leftMargin="10" </C>
                            <C> id="EM_PHN_NO"  width=100   name="����ο���ó"  align=left      leftMargin="10" </C>
                            <C> id="TRG_NM"		width=100	name="�����������" align=center					</C>
							<C> id="JHDC_NM"	width=80	name="�������"		align=center					</C>
							<C> id="JHDC_GRA"	width=60	name="��ֵ��	"	align=center					</C>
							<C> id="SER_STS"	width=60	name="��������"		align=center					</C>
							<C> id="JAN_YMD"	width=80	name="���������"	align=center					</C>
							<C> id="HIR_YMD"	width=80	name="�Ի���"		align=center					</C>
							<C> id="RET_YMD"	width=80	name="�����"		align=center					</C>
							<C> id="JOB_ONM"	width=80	name="�ٷ�����"		align=center					</C>
							<C> id="SAL_GBN"	width=80	name="�ӱ�����"		align=center					</C>
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

