	<!--*************************************************************************
	* @source      : adva021.jsp												*
	* @description : �系�����û PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27            ä����          	        �����ۼ�									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�系�����û(adva021)</title>
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
		var btnList = 'FFTFFFTT';

        var ORD_NO_SHR = "<%=request.getParameter("ORD_NO_SHR") %>";
        var ENO_NO_SHR = "<%=request.getParameter("ENO_NO_SHR") %>";
        var GBN = "<%=request.getParameter("GBN") %>";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			dsT_EV_ADVTBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva020.cmd.ADVA020CMD&S_MODE=SHR_INFO&ORD_NO_SHR="+ORD_NO_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_EV_ADVTBOOK.reset();
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
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			// save
			trT_EV_ADVTBOOK.KeyValue = "tr01(I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)";
			trT_EV_ADVTBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva020.cmd.ADVA020CMD&S_MODE=SAV";
			trT_EV_ADVTBOOK.post();

			//�����ϰ� ������.
			fnc_Exit();

        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_ADVTBOOK.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var flag = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"FLAG");
            if(flag != "N"){
            	alert("��û�� ���� �ʾҽ��ϴ�.");
            	return;
            }

			if (confirm("��û������ �����Ͻðڽ��ϱ�?") == false) return;

            dsT_EV_ADVTBOOK.DeleteRow(dsT_EV_ADVTBOOK.RowPosition);



			trT_EV_ADVTBOOK.KeyValue = "tr01(I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)";
			trT_EV_ADVTBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva020.cmd.ADVA020CMD&S_MODE=DEL&ORD_NO_SHR="+ORD_NO_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			trT_EV_ADVTBOOK.post();

			//�����ϰ� ������.
			fnc_Exit();

        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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
	        document.getElementById("resultMessage").innerText = ' ';

        	dsT_EV_ADVTBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
            if (dsT_EV_ADVTBOOK.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

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
         	if ( !dsT_EV_ADVTBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

            if( document.getElementById("txtADV_REMARK").value.trim() == "" ) {
                alert("��û���⸦ �Է��ϼ���.");
                document.getElementById("txtADV_REMARK").focus();
                return false;
            }

            if( document.getElementById("txtADV_NOTICE").value.trim() == "" ) {
                alert("��������� �Է��ϼ���.");
                document.getElementById("txtADV_NOTICE").focus();
                return false;
            }

            if( document.getElementById("txtADV_PR").value.trim() == "" ) {
                alert("�ڱ�PR�� �Է��ϼ���.");
                document.getElementById("txtADV_PR").focus();
                return false;
            }

            if( document.getElementById("txtADV_ETC").value.trim() == "" ) {
                alert("�ٶ����/��Ÿ�� �Է��ϼ���.");
                document.getElementById("txtADV_ETC").focus();
                return false;
            }

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            fnc_SearchList();

            var today = getToday().replace("-","").replace("-","");
            var STR_YMD = document.getElementById("txtSTR_YMD").value.replace("-","").replace("-","");
            var END_YMD = document.getElementById("txtEND_YMD").value.replace("-","").replace("-","");

            if(STR_YMD <= today && END_YMD >= today && GBN == "adva020"){
            	document.getElementById("imgApplication").style.display = "";
	        	document.getElementById("ImgDelete").style.display = "";
	        	document.getElementById("imgApplication").disabled = false;
	        	document.getElementById("ImgDelete").disabled = false;

            }else{
            	document.getElementById("imgApplication").style.display = "none";
	        	document.getElementById("ImgDelete").style.display = "none";
   	        	document.getElementById("imgApplication").disabled = true;
	        	document.getElementById("ImgDelete").disabled = true;

   				document.getElementById('txtADV_REMARK').readOnly = true;
				document.getElementById('txtADV_REMARK').className="input_ReadOnly";
   				document.getElementById('txtADV_PR').readOnly = true;
				document.getElementById('txtADV_PR').className="input_ReadOnly";
   				document.getElementById('txtADV_NOTICE').readOnly = true;
				document.getElementById('txtADV_NOTICE').className="input_ReadOnly";
   				document.getElementById('txtADV_ETC').readOnly = true;
				document.getElementById('txtADV_ETC').className="input_ReadOnly";

            }

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
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ADVTBOOK)			   |
    | 3. ���Ǵ� Table List(T_EV_ADVTBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_ADVTBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ADVTBOOK)		       |
    | 3. ���Ǵ� Table List(T_EV_ADVTBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_EV_ADVTBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadCompleted(iCount)">
        var elementList = new Array( "txtADV_REMARK"
                                    ,"txtADV_PR"
                                    ,"txtADV_NOTICE"
                                    ,"txtADV_ETC");

		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ADVTBOOK.CountRow);

            // ��ȸ ��� ���̵�� �α� ���̵� �ٸ��� �Է� ������ �ȵǰ� ����
            if(ENO_NO_SHR != "<%=box.get("SESSION_ENONO") %>") {
                //fnc_DisableElementAll(elementList);// ���� �۾��� �帮�� ����
                document.getElementById('txtADV_REMARK').readOnly = true;
                document.getElementById('txtADV_REMARK').className="input_ReadOnly";
                document.getElementById('txtADV_PR').readOnly = true;
                document.getElementById('txtADV_PR').className="input_ReadOnly";
                document.getElementById('txtADV_NOTICE').readOnly = true;
                document.getElementById('txtADV_NOTICE').className="input_ReadOnly";
                document.getElementById('txtADV_ETC').readOnly = true;
                document.getElementById('txtADV_ETC').className="input_ReadOnly";

            } else {
                //fnc_EnableElementAll(elementList);// ���� �۾��� �帮�� ����
                document.getElementById('txtADV_REMARK').readOnly = false;
                document.getElementById('txtADV_REMARK').className="";
                document.getElementById('txtADV_PR').readOnly = false;
                document.getElementById('txtADV_PR').className="";
                document.getElementById('txtADV_NOTICE').readOnly = false;
                document.getElementById('txtADV_NOTICE').className="";
                document.getElementById('txtADV_ETC').readOnly = false;
                document.getElementById('txtADV_ETC').className="";


            }
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>


	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnFail()">
        alert(trT_EV_ADVTBOOK.ErrorMsg);
    </script>


    <!-----------------------------------------------------+
    | Grid Double Click Event                                   |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_EV_ADVTBOOK event=OnDblClick(row,colid)>
        alert("Occur OnDblClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" )
    </script>


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

    <!-- ��ư ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApplication','','/images/button/btn_ApplicationOver.gif',1)">  <img src="/images/button/btn_ApplicationOn.gif"   name="imgApplication" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a> -->
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- ���� �Է� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�������</strong></td>
    </tr>
	<tr>
		<td class="paddingTop3" colspan="2">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
            <col width="60"></col>
            <col width="80"></col>
            <col width="60"></col>
            <col width="90"></col>
            <col width="60"></col>
            <col width="90"></col>
            <col width="60"></col>
            <col width="110"></col>
            <col width="60"></col>
            <col width=""></col>
        </colgroup>
        <tr>
            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423" align="left">
                <input id="txtADV_ENO_NO" size="10" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423" align="left">
                <input id="txtADV_ENO_NM" size="12" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423" align="left">
                <input id="txtADV_OCC_NM" size="12" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423" align="left">
                <input id="txtADV_DPT_NM" size="15" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423" align="left">
                <input id="txtADV_JOB_NM" size="11" class="input_ReadOnly" readonly>
            </td>
        </tr>
        </table>
        </td>
    </tr>
    </table>

    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�系���𳻿�</strong></td>
    </tr>
	<tr>
		<td class="paddingTop3" colspan="2">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
            <col width="70"></col>
            <col width="120"></col>
            <col width="70"></col>
            <col width="120"></col>
            <col width="70"></col>
            <col width=""></col>
        </colgroup>
        <tr>
            <td align="center" class="creamBold">�����Ⱓ</td>
            <td class="padding2423" colspan="3">
                <input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                 ~
                <input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
                <input type="hidden" id="txtADV_CNT" size="6" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">������ȣ</td>
            <td class="padding2423">
                <input id="txtORD_NO" size="15" class="input_ReadOnly" readonly>
            </td>
        </tr>
        <tr>
            <td align="center" class="creamBold">����μ�</td>
            <td class="padding2423">
 <!--                <input id="txtDPT_CD" size="3" class="input_ReadOnly" readonly>   -->
                <input id="txtDPT_NM" size="18" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">�������</td>
            <td class="padding2423">
                <input id="txtJOB_NM" size="6"  class="input_ReadOnly" readonly>
                ~
                <input id="txtJOB_NM2" size="6"  class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">�����о�</td>
            <td class="padding2423">
            	<input id="txtFIELD_DIS" size="52" maxLength="10" class="input_ReadOnly" readonly>
           	</td>
        </tr>
        <tr>

            <td align="center" class="creamBold">�ֿ����</td>
            <td class="padding2423" colspan="3">
            	<input id="txtJOB_DIS" size="51" maxLength="10" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">�ڰݿ��</td>
            <td class="padding2423">
            	<input id="txtREMARK" size="52" maxLength="10" class="input_ReadOnly" readonly>
            </td>
        </tr>
        <tr>
            <td align="center" class="creamBold">����ڰ�</td>
            <td class="padding2423" colspan="3">
            	<input id="txtCONDITION_DIS" size="51" maxLength="10" class="input_ReadOnly" readonly>
            </td>
            <td align="center" class="creamBold">�ٹ���</td>
            <td class="padding2423">
            	<input id="txtAREA_DIS" size="52" maxLength="10" class="input_ReadOnly" readonly>
            </td>
        </tr>
        </table>
        </td>
    </tr>
    </table>

    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�系���𳻿�</strong></td>
    </tr>
	<tr>
		<td class="paddingTop3" colspan="2">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
            <col width="70"></col>
            <col width=""></col>
        </colgroup>
        <tr>
            <td align="center" class="creamBold">��û����</td>
            <td class="padding2423">
            	<textarea id=txtADV_REMARK name=txtADV_REMARK rows="5" cols="117" onkeyup="fc_chk_byte(this,4000);"></textarea>
            </td>
        </tr>
        <tr>
            <td align="center" class="creamBold">�ڱ�PR</td>
            <td class="padding2423">
                <textarea id=txtADV_PR name=txtADV_PR rows="5" cols="117" onkeyup="fc_chk_byte(this,4000);"></textarea>
            </td>
        </tr>
        <tr>
            <td align="center" class="creamBold">���������<br>Ư����<br>�ٶ����</td>
            <td class="padding2423">
            	<textarea id=txtADV_NOTICE name=txtADV_NOTICE rows="5" cols="117" onkeyup="fc_chk_byte(this,4000);"></textarea>
            </td>
        </tr>
        <tr>
            <td align="center" class="creamBold"><br>��&nbsp;&nbsp;Ÿ</td>
            <td class="padding2423">
                <textarea id=txtADV_ETC name=txtADV_ETC rows="5" cols="117" onkeyup="fc_chk_byte(this,4000);"></textarea>
            </td>
        </tr>
        </table>
        </td>
    </tr>
    </table>

    <!-- ���� �Է� ���̺� �� -->


    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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


    <!--**************************************************************************************
    *                                                                                        *
    *   ���ε� ������Ʈ                                                                             *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_EV_ADVTBOOK ���� ���̺� -->
    <object id="bndT_EV_ADVTBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_EV_ADVTBOOK">
        <Param Name="BindInfo", Value="
			<C>Col=ADV_ENO_NO       Ctrl=txtADV_ENO_NO      Param=value</C>
            <C>Col=ADV_ENO_NM       Ctrl=txtADV_ENO_NM      Param=value</C>
            <C>Col=ADV_DPT_NM       Ctrl=txtADV_DPT_NM      Param=value</C>
            <C>Col=ADV_JOB_NM       Ctrl=txtADV_JOB_NM      Param=value</C>
            <C>Col=ADV_OCC_NM       Ctrl=txtADV_OCC_NM      Param=value</C>
            <C>Col=ORD_NO           Ctrl=txtORD_NO          Param=value</C>
            <C>Col=DPT_CD           Ctrl=txtDPT_CD          Param=value</C>
            <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value</C>
            <C>Col=JOB_CD           Ctrl=txtJOB_CD          Param=value</C>
            <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value</C>
            <C>Col=JOB_NM2          Ctrl=txtJOB_NM2         Param=value</C>
            <C>Col=STR_YMD          Ctrl=txtSTR_YMD         Param=value</C>
            <C>Col=END_YMD          Ctrl=txtEND_YMD         Param=value</C>
            <C>Col=FIELD_DIS        Ctrl=txtFIELD_DIS       Param=value</C>
            <C>Col=JOB_DIS          Ctrl=txtJOB_DIS         Param=value</C>
            <C>Col=REMARK           Ctrl=txtREMARK          Param=value</C>
            <C>Col=CONDITION_DIS    Ctrl=txtCONDITION_DIS   Param=value</C>
            <C>Col=AREA_DIS         Ctrl=txtAREA_DIS        Param=value</C>
            <C>Col=ADV_CNT          Ctrl=txtADV_CNT         Param=value</C>
            <C>Col=ADV_REMARK       Ctrl=txtADV_REMARK      Param=value</C>
            <C>Col=ADV_PR           Ctrl=txtADV_PR          Param=value</C>
            <C>Col=ADV_NOTICE       Ctrl=txtADV_NOTICE      Param=value</C>
            <C>Col=ADV_ETC          Ctrl=txtADV_ETC         Param=value</C>
        ">
    </object>