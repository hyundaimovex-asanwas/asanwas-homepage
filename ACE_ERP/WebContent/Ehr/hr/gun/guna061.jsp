<!--
***********************************************************************
* @source      : guna061.jsp
* @description : ���º����û��Ȳ�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>���º����û��Ȳ��(guna061)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';
		var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            

			dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna061.cmd.GUNA061CMD&S_MODE=SHR&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
			dsT_DI_CHANGE.reset();

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            var req_no  = document.getElementById("txtREQ_NO").value;
            var dpt_nm  = document.getElementById("txtDPT_NM").value;
            var chn_ymd = document.getElementById("txtCHN_YMD").value;
            var req_ymd = document.getElementById("txtREQ_YMD").value;

            var pjob_nm = document.getElementById("txtPJOB_NM").value;
            var peno_no = document.getElementById("txtPENO_NO").value;
            var peno_nm = document.getElementById("txtPENO_NM").value;
            var app_ymd = document.getElementById("txtAPP_YMD").value;
            var app_nm  = document.getElementById("txtAPP_NM").value;

            var url = "guna061_PV.jsp?req_no="+req_no+"&dpt_nm="+dpt_nm+"&chn_ymd="+chn_ymd+"&req_ymd="+req_ymd+"&pjob_nm="+pjob_nm+"&peno_no="+peno_no+"&peno_nm="+peno_nm+"&app_ymd="+app_ymd+"&app_nm="+app_nm;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtREQ_NO").value = dsTemp.NameValue(1,"REQ_NO");
            document.getElementById("txtDPT_NM").value = dsTemp.NameValue(1,"DPT_NM");
            document.getElementById("txtCHN_YMD").value = dsTemp.NameValue(1,"CHN_YMD");
            document.getElementById("txtREQ_YMD").value = dsTemp.NameValue(1,"REQ_YMD");

			cfStyleGrid(form1.grdT_DI_CHANGE,0,"false","false");      // Grid Style ����

<%
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			if(dsTemp.NameValue(1,"END_TAG") != "Y" && dsTemp.NameValue(1,"APP_YN") == "Y"){
                document.getElementById("imgConduct").disabled = false;
                document.getElementById("imgConduct").style.display = "";
            }else{
                document.getElementById("imgConduct").disabled = true;
                document.getElementById("imgConduct").style.display = "none";
            }
<%
    }else{
%>
        document.getElementById("imgConduct").disabled = true;
        document.getElementById("imgConduct").style.display = "none";
<%
    }
%>

            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. ó�� ��ư                            *
         ********************************************/
        function fnc_Reflect() {

            if (!confirm("ó���Ͻðڽ��ϱ�?")){
                return;
            }
            
            //���õ� ROW�� dsT_DI_CHANGE_CP �����Ͽ� guna061�� dsT_DI_CHANGE_CP �Ѱ��ش�.
            cfCopyDataSet(dsTemp, dsT_DI_CHANGE_01, "copyHeader=yes,rowFrom="+1+",rowCnt=1");

            dsT_DI_CHANGE_01.NameValue(1,"CHECKED") = "1";

            trT_DI_CHANGE.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE_01)";
            trT_DI_CHANGE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna060.cmd.GUNA060CMD&S_MODE=SAV";
            trT_DI_CHANGE.post();
            
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_CHANGE)		 	   |
    | 3. ���Ǵ� Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_CHANGE)		 	   |
    | 3. ���Ǵ� Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    
	<Script For=dsT_DI_CHANGE_01 Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    
    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton                      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_CHANGE)        |
    | 3. ���Ǵ� Table List(T_DI_CHANGE)                  |
    +------------------------------------------------------>
    <Object ID="trT_DI_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
	<Script For=dsT_DI_CHANGE_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    
	<Script For=dsT_DI_CHANGE_01 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    
    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_DI_CHANGE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        window.close();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_DI_CHANGE event="OnFail()">
        cfErrorMsg(this);
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

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���º����û��Ȳ��</td>
					<td align="right" class="navigator">HOME/���°���/���ϱ��°���/<font color="#000000">���º����û��Ȳ��</font></td>
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
			    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"> <img src="/images/button/btn_ConductOn.gif" name="imgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- ���� �Է� ���̺� ���� -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="100"></col>
					<col width="90"></col>
                    <col width="100"></col>
					<col width="90"></col>
                    <col width="100"></col>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��û��ȣ</td>
					<td class="padding2423">
                        <input id="txtREQ_NO" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">��û�Ҽ�</td>
					<td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">�ش������</td>
					<td class="padding2423">
                        <input id="txtCHN_YMD" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">��û����</td>
					<td class="padding2423">
						<input id="txtREQ_YMD" style="width:100%;" class="input_ReadOnly" readonly>
					</td>
				</tr>
            </table>
            </td>
        <tr>
            <td class="paddingTop8">
                <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>��������</strong>
            </td>
        </tr>
        <tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
                    <col width="90"></col>
					<col width="60"></col>
                    <col width="90"></col>
					<col width="60"></col>
                    <col width="90"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">����</td>
					<td class="padding2423">
                        <input id="txtPJOB_NM" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">���</td>
					<td class="padding2423">
                        <input id="txtPENO_NO" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
					<td class="padding2423">
                        <input id="txtPENO_NM" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">������</td>
					<td class="padding2423">
                        <input id="txtAPP_YMD" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�ϷῩ��</td>
					<td class="padding2423">
                        <input id="txtAPP_NM" style="width:100%;" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->
</tr>
</table>

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- ��ȸ ���� ���̺� ���� -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ��ȸ ���� ���̺� �� -->
			</td>
		</tr>
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_CHANGE">
						<param name="Format" value='
							<C> id="{CUROW}"	width=44	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="DPT_NM"		width=100	name="�Ҽ�"			align=left		</C>
							<C> id="JOB_NM"		width=60	name="����"			align=center	</C>
							<C> id="ENO_NO"		width=70	name="���"			align=center	</C>
							<C> id="ENO_NM"		width=65	name="����"			align=center	</C>
							<G> name="����������"  HeadBgColor="#F7DCBB"
								<C> id="BF_GUN_NM"		width=70	name="����"	align=center	</C>
								<C> id="BF_REMARK"		width=100	name="���"	align=left	    </C>
							</G>
							<G> name="�����ı���"  HeadBgColor="#F7DCBB"
								<C> id="GUN_NM"			width=70	name="����"	align=center	</C>
								<C> id="REMARK" 		width=100	name="���"	align=left	    </C>
								<C> id="REASON"			width=100	name="����"	align=left	    </C>
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
	<!-- ���� ��ȸ �׸��� ���̺� ��-->

	</form>
	<!-- form �� -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_DI_CHANGE ���� ���̺� -->
	<object id="bndT_DI_CHANGE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_CHANGE">
		<Param Name="BindInfo", Value="
			<C>Col=PJOB_NM		Ctrl=txtPJOB_NM		Param=value</C>
            <C>Col=PENO_NO		Ctrl=txtPENO_NO		Param=value</C>
            <C>Col=PENO_NM		Ctrl=txtPENO_NM		Param=value</C>
            <C>Col=APP_YMD		Ctrl=txtAPP_YMD		Param=value</C>
            <C>Col=APP_NM		Ctrl=txtAPP_NM		Param=value</C>
		">
	</object>