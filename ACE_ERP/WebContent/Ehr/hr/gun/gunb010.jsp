<!--
***********************************************************************
* @source      : gunb010.jsp
* @description : �����/Refresh�ް���Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/28      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�����/Refresh�ް���Ȳ(gunb010)</title>
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // �ش���
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // �ش�⵵
			
			var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var use = document.getElementById("cmb_USE_SHR").value; // ��뱸��

            if(!fnc_SearchItemCheck()) return;//�˻����� ��ȿ�� �˻�

			if(ActiveIndex==1){
				dsT_DI_DILIGENCE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb010.cmd.GUNB010CMD&S_MODE=SHR_01&PIS_YYMM="+PIS_YYMM_SHR+"&DPT_CD="+dpt_cd+"&USE="+use;
			    dsT_DI_DILIGENCE_01.reset();
			}else{
				dsT_DI_DILIGENCE_02.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb010.cmd.GUNB010CMD&S_MODE=SHR_02&PIS_YYMM="+PIS_YY_SHR+"&DPT_CD="+dpt_cd+"&USE="+use;
			    dsT_DI_DILIGENCE_02.reset();
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
				if (dsT_DI_DILIGENCE_01.CountRow < 1) {
            	    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                	return;
				}
            	form1.grdT_DI_DILIGENCE_01.GridToExcel("������ް���Ȳ", '', 225)

			}else{
				if (dsT_DI_DILIGENCE_02.CountRow < 1) {
					alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
					return;
				}
	            form1.grdT_DI_DILIGENCE_02.GridToExcel("Refresh�ް���Ȳ", '', 225)

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
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

			document.getElementById("cmb_USE_SHR").value = "";
        	document.getElementById("resultMessage").innerText = ' ';
        	dsT_DI_DILIGENCE_01.ClearData();
        	dsT_DI_DILIGENCE_02.ClearData();

            TabEvent(0);
                    	
        	document.form1.txtPIS_YYMM_SHR.focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {

            var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value;
            var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value;

            if(ActiveIndex == 0){
	            //�ش����� ������ ��ȸ����.
				if(PIS_YYMM_SHR.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("�ش����� �Է��ϼ���.");
						document.getElementById("txtPIS_YYMM_SHR").focus();
						return false;
					}
				}
	
				//�ش����� �߸��Ǿ����� ��ȸ����.
				if(PIS_YYMM_SHR.trim().length != 7){
					if(event.type == "change"){
						return false;
					}else{
						alert("�ش����� �߸��Ǿ����ϴ�.");
						document.getElementById("txtPIS_YYMM_SHR").focus();
						return false;
					}
				}
				
			} else {
                //�ش�⵵�� ������ ��ȸ����.
                if(PIS_YY_SHR.trim().length == 0){
                    if(event.type == "change"){
                        return false;
                    }else{
                        alert("�ش�⵵�� �Է��ϼ���.");
                        document.getElementById("txtPIS_YY_SHR").focus();
                        return false;
                    }
                }

                //�ش�⵵�� �߸��Ǿ����� ��ȸ����.
                if(PIS_YY_SHR.trim().length != 4){
                    if(event.type == "change"){
                        return false;
                    }else{
                        alert("�ش�⵵�� �߸��Ǿ����ϴ�.");
                        document.getElementById("txtPIS_YY_SHR").focus();
                        return false;
                    }
                }
            }			

            return true;

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


			document.form1.txtPIS_YYMM_SHR.value = getToday().substring(0,7); // �ش���
			document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4); // �ش�⵵


			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_DI_DILIGENCE_01,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdT_DI_DILIGENCE_02,0,"false","false");      // Grid Style ����



            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       
<%
    }
%>
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //Layer ID
        var layerList = new Array(  "tabGUNB010_01"
                                   ,"tabGUNB010_02" );

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
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)		   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
	<Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<Script For=dsT_DI_DILIGENCE_02 Event="OnLoadCompleted(iCount)">
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
	<Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
	<Script For=dsT_DI_DILIGENCE_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� |
    +----------------------------------------------------------------->
	<Script For=dsT_DI_DILIGENCE_01 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
	<Script For=dsT_DI_DILIGENCE_02 Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����/Refresh�ް���Ȳ</td>
					<td align="right" class="navigator">HOME/���°���/�ް���ȹ����/<font color="#000000">�����/Refresh�ް���Ȳ</font></td>
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
    			<td align="center" class="greenTable">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<colgroup>
    					<col width="50"></col>
    					<col width="180"></col>
    					<col width="80"></col>
                        <col width="205"></col>
    					<col width="80"></col>
                        <col width="150"></col>
    					<col width="*"></col>
    				</colgroup>
    				<tr>
    				    <td>&nbsp;</td>
    				    <td>
	                        <div id="changeDate_01" style="position:absolute; left:132; top:86; width:180; height:20; z-index:2;" >
                                <table>
                                <tr>                 
                                                
                                <td class="searchState" align="right">�ش���&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>                  
                                </td>
                                
                                </tr>
                                </table>          
	       				    </div>
	                        <div id="changeDate_02" style="position:absolute; left:132; top:86; width:180; height:20; z-index:1; visibility:hidden" >
                               <table>
                               <tr>                 
                                <td class="searchState" align="right">�ش�⵵&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>            
                                </td>
                                </tr>
                                </table>	                        
	                        </div>
                        </td>
    					<td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
    					<td class="padding2423" align="left">
    						<input id="txtDPT_CD_SHR" size="3" maxlength="2"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="16" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
    					</td>
    					<td align="right" class="searchState">��뱸��&nbsp;</td>
    					<td>
    						<select id="cmb_USE_SHR" style="width:100" onChange="fnc_SearchList();">
    							<option value="" >��ü</option>
    							<option value="1" >���</option>
                                <option value="2" >�̻��</option>
    						</select>
    					</td>
                        <td>&nbsp;</td>
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
                                    <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">������ް�</td>
                                    <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                                </tr>
                            </table>
                        </td>
                        <td> 
                            <!-- ������ -->
                            <table width="120" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                    <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                    <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">Refresh�ް�</td>
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
	<div class=page id="tabGUNB010_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4;" >

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_DI_DILIGENCE_01">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}   </C>
							<C> id="DPT_NM"		width=110	name="�Ҽ�"		    align=center    </C>
							<C> id="JOB_NM"		width=60	name="����"		    align=center	</C>
							<C> id="ENO_NO"		width=70	name="���"		    align=center	</C>
							<C> id="ENO_NM"		width=70	name="����"		    align=center	</C>
                            <G> name="���λ����ް�" HeadBgColor="#F7DCBB"
								<C> id="BIR_YMD"	width=95	name="�������"		align=center	</C>
                                <C> id="TBIR_YMD"     width=80  name="����"         align=center    </C>								
								<C> id="UBIR_YMD"	width=80	name="�����"		align=center	</C>
                            </G>
                            <G> name="��ȥ����ް�" HeadBgColor="#F7DCBB"
								<C> id="WED_YMD"	width=95	name="��ȥ�����"	align=center	</C>
								<C> id="UWED_YMD"	width=80	name="�����"		align=center	</C>
                            </G>
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
	<div class=page id="tabGUNB010_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3; visibility:hidden">

		<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_DI_DILIGENCE_02">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"			align=center	value={String(Currow)}   </C>
							<C> id="DPT_NM"		width=100	name="�Ҽ�"		align=left		leftMargin="10" </C>
							<C> id="JOB_NM"		width=60	name="����"		align=center	</C>
							<C> id="ENO_NO"		width=60	name="���"		align=center	</C>
							<C> id="ENO_NM"		width=60	name="����"		align=center	</C>
							<C> id="HIRG_YMD"	width=80	name="�׷��Ի���"	align=center	</C>
							<C> id="LSE_YY"		width=70	name="�ټӳ��"	align=center	</C>
                            <C> id="ATT_Z"		width=90	name="Refresh�ް�"	align=center	</C>
                            <C> id="ATT_S"		width=70	name="�����ް�"	align=center	</C>
							<C> id="PERIOD"	    width=150	name="���Ⱓ"	align=left		</C>
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

