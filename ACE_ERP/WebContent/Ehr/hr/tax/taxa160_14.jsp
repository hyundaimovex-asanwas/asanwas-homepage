	<!--*************************************************************************
	* @source      : taxa160.jsp												*
	* @description : �ٷμҵ��õ¡��������
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2015/03/12          �̵���             	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�ٷμҵ��õ¡��������(taxa160)</title>
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
		var year = getToday().substring(0,4);

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {


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
			var PIS_YY   = document.getElementById("txtPIS_YY_SHR").value;
			var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var PRT_GBN  = fnc_GetCheckedValue("rdoPRT_GBN");

			if(!fnc_SearchItemCheck()) return;//�ʼ� ��ȸ���� üũ

			var url = "taxa160_14_PV.jsp"
                    + "?PIS_YY="+PIS_YY
                    + "&ENO_NO="+ENO_NO
                    + "&STP_GBN=1"  	  			//1�������, 2���λ���
                    + "&PRT_GBN="+PRT_GBN 	  	//���౸��
                    + "&SEND_PARM=1";

			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

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
			document.getElementById("txtPIS_YY_SHR").value      = year;
			document.getElementById("txtENO_NO_SHR").value      = "";
            document.getElementById("txtDPT_CD_SHR").value      = "";
            document.getElementById("txtENO_NM_SHR").value      = "";
            document.getElementById("txtDPT_NM_SHR").value      = "";
            document.getElementById("txtSTR_YMD_SHR").value     = "";

            document.getElementsByName("rdoSTP_GBN")[0].checked = true;
            document.getElementsByName("rdoTAX_GBN")[0].checked = true;
            document.getElementsByName("rdoPRT_GBN")[0].checked = true;
            document.getElementsByName("rdoTYPE")[2].checked    = true;

            document.getElementById("chkOCC_CD_A").checked      = true;
            document.getElementById("chkOCC_CD_M").checked      = false;

        	document.getElementById("resultMessage").innerText = ' ';
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
       		if( document.form1.txtPIS_YY_SHR.value=="" ){
       			alert("���س⵵�� �Է��Ͻʽÿ�.");
       			document.form1.txtPIS_YY_SHR.focus();
        		return false;
        	}
       		/*
       		if( document.form1.txtENO_NO_SHR.value=="" ){
       			alert("�����ȣ�� �Է��Ͻʽÿ�.");
       			document.form1.txtENO_NO_SHR.focus();
        		return false;
        	}
        	*/
        	return true;
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
            
        	document.form1.txtPIS_YY_SHR.value = "2014";

        	//document.getElementsByName("rdoTYPE")[2].checked    = true;

<%
    //�����ڳ� �λ� ������ �̸� ���� �˻��ϰ� �Ϲ������̸� �ڱ����� �˻�
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			fnc_ChangeStateElement(false, "txtPIS_YY_SHR");
            fnc_ChangeStateElement(false, "ImgDptCdShr");
            fnc_ChangeStateElement(false, "rdoTYPE");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";            
            
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

            document.getElementById('txtENO_NO_SHR').value = "<%=box.get("SESSION_ENONO") %>";
            document.getElementById('txtENO_NM_SHR').value = "<%=box.get("SESSION_ENONM") %>";
<%
    }
%>

        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

	   }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
	    }
        
		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}
    </script>
</head>




	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->



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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��õ¡��������_2014</td>
					<td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�ҵ��������� - ��õ¡��������_2014</font>
				</td>
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
	        <!--  
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	        -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>

                <tr>
                    <td align="right" class="searchState">���걸��&nbsp;</td>
                    <td class="padding2423">
                        <input type="radio" class="noview" name="rdoTAX_GBN" value="8" checked>&nbsp;��������
                        <!--<input type="radio" class="noview" name="rdoTAX_GBN" value="9">&nbsp;���������� -->
                    </td>
                </tr>

                <tr><td height="15"></td></tr>

                <tr>
                    <td class="searchState" align="right">����⵵&nbsp;</td>
                    <td class="padding2423" align="left">
                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="40" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4" class="input_ReadOnly" readonly>
                                </td>
                                
                                <!--  
                                <td style="height:9px; padding-left:0px; border-style:none">
                                <img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none">
                                <img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            
                            	-->
                            	</tr>
                        </table>
                    </td>
					<!--  
                    <td align="right" class="searchState">�Ű�����&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','410','150');"></a>
                    </td>
                    -->
                </tr>

                <tr><td height="15"></td></tr>

                <tr>
                    <td align="right" class="searchState">���౸��&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="1" checked>&nbsp;�ҵ��ں�����
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="2">&nbsp;�����ں����
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="3">&nbsp;�����ں�����
                    </td>
                </tr>

                <tr><td height="15"></td></tr>
				
				<!--  
                <tr>
                    <td align="right" class="searchState">���ο���&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="1" checked>&nbsp;�������
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="2">&nbsp;���λ���
                    </td>
                </tr>
                <tr><td height="15" colspan="4"></td></tr>
				-->

                <tr>
                    <td align="right" class="searchState">�������&nbsp;</td>
                    <td align="left" colspan="3">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <!--  
                            <tr>
                                <td align="left" class="searchState">
                                    <input type="radio" class="noview" name="rdoTYPE" value="O" checked>&nbsp;�ٷα���
                                </td>
                                <td class="padding2423">
                                    <input type="checkbox" class="noview" name="chkOCC_CD_A" checked style="DISPLAY:none">&nbsp;�繫��
                                    &nbsp;&nbsp;&nbsp;
                                    <input type="checkbox" class="noview" name="chkOCC_CD_M" style="DISPLAY:none">
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="left" class="searchState">
                                    <input type="radio" class="noview" name="rdoTYPE" value="D">&nbsp;�μ�
                                </td>
                                <td class="padding2423">
                                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="10" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCdShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCdShr" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                                </td>
                            </tr>
                            -->
                            <tr>
                                <td align="left" class="searchState">
                                    <input type="radio" class="noview" name="rdoTYPE" value="E"  checked>&nbsp;���
                                </td>
                                <td class="padding2423">
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchList();"onblur="fnc_SearchList();" style="ime-mode:disabled"> 
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchList();"onblur="fnc_SearchList();"> 
							<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							<input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
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



	</form>
	<!-- form �� -->

</body>
</html>

