<!--
    ************************************************************************************
    * @Source         : cdpb030.jsp                                                    *
    * @Description    : ��å�������� PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/23  |  ���м�   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<% String title = request.getParameter("TITLE"); %>
<% String resp_cd = request.getParameter("RESP_CD"); %>

<html>

    <head>
    <title><%=title%>(cdpb030)</title>
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
tmp=window.location;
tmp=String(tmp).split('?'); //? ���İ� �迭�� ���
tmp=tmp[1].split('&');//������ ������ �迭�� ���

//������ ���
for(k in tmp) {
tmp2=tmp[k].split('='); //Ű�� ���и�
eval("var "+tmp2[0]+"=tmp2[1]");
// document.write(tmp2[0]+' '+tmp2[1]+'<br>');
}
//alert(tmp2[1]);




        var btnList = 'TFFTFTFT';
        var opener = window.dialogArguments;
//alert("1");
//alert("<%=resp_cd%>");
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

//            var RESC_CD = <%=resp_cd%>
//            var RESP_CD    = opener.resp_cd;
//alert("2");
//alert("<%=resp_cd%>");
//            if(link_resp_cd) alert(link_resp_cd);
            dsT_CD_RESPCODE.ClearData();
            dsT_CD_RESPCODE.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb030.cmd.CDPB030CMD&S_MODE=SHR&RESP_CD="+RESP_CD;
            dsT_CD_RESPCODE.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if(fnc_SaveItemCheck()) {

                trT_CD_RESPMST.KeyValue = "SVL(I:dsT_CD_RESPMST=dsT_CD_RESPMST)";
                trT_CD_RESPMST.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb030.cmd.CDPB030CMD&S_MODE=SAV&RESP_CD="+RESP_CD;
                trT_CD_RESPMST.post();
                dsT_CD_RESPMST.Reset();
			} else {
				return;
			}

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var f = document.form1;

            if (!dsT_CD_RESPMST.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            return true;
        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            // ��å����� ������ ��ȸ
            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_RESPMST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/


        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'D') {

                document.getElementById("txtPOSITION_TXT").disabled  = false;
                document.getElementById("txtCAREERF_TXT").disabled   = false;
                document.getElementById("txtDEFINT_TXT").disabled    = false;
                document.getElementById("txtAFFAIR_TXT").disabled    = false;
                document.getElementById("txtABILITY_TXT").disabled   = false;
                document.getElementById("txtEXPOCC_TXT").disabled    = false;
                document.getElementById("txtENCOCC_TXT").disabled    = false;
                document.getElementById("txtETC_TXT").disabled       = false;
                document.getElementById("txtROADMAP_TXT").disabled   = false;

            }
            else if (prop == 'E') {

                document.getElementById("txtPOSITION_TXT").disabled  = true;
                document.getElementById("txtCAREERF_TXT").disabled   = true;
                document.getElementById("txtDEFINT_TXT").disabled    = true;
                document.getElementById("txtAFFAIR_TXT").disabled    = true;
                document.getElementById("txtABILITY_TXT").disabled   = true;
                document.getElementById("txtEXPOCC_TXT").disabled    = true;
                document.getElementById("txtENCOCC_TXT").disabled    = true;
                document.getElementById("txtETC_TXT").disabled       = true;
                document.getElementById("txtROADMAP_TXT").disabled   = true;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_RESPCODE)   |
    | 3. ���Ǵ� Table List(T_CD_RESPCODE)          |
    +----------------------------------------------->
    <Object ID="dsT_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_RESPMST)   |
    | 3. ���Ǵ� Table List(T_CD_RESPMST)          |
    +----------------------------------------------->
    <Object ID="dsT_CD_RESPMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CD_RESPMST                      |
    | 3. Table List : T_CD_RESPMST                  |
    +----------------------------------------------->
    <Object ID ="trT_CD_RESPMST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_RESPMST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnLoadCompleted(iCount)">

//        var RESP_CD  = opener.resp_cd;
        var RESP_CD = <%=resp_cd%>

        dsT_CD_RESPMST.ClearData();
        dsT_CD_RESPMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb030.cmd.CDPB030CMD&S_MODE=SHR_01&RESP_CD="+RESP_CD;
        dsT_CD_RESPMST.Reset();
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_RESPCODE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_RESPCODE Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CD_RESPMST Event="OnLoadCompleted(iCount)">

 //       var RESP_CD  = opener.resp_cd;
        var work = opener.work;
//alert(work);
        if (iCount > 0) {
            if (work == "1") {
                fnc_ColEnabled('D');
                document.getElementById("imgSave").disabled = false;
            }
            else {
                fnc_ColEnabled('E');
                document.getElementById("imgSave").disabled = true;
            }
        } else {
            if (work == "1") {

                fnc_ColEnabled('D');

                document.getElementById("imgSave").disabled = false;
                // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
                if (dsT_CD_RESPMST.CountColumn == 0) {
                    dsT_CD_RESPMST.setDataHeader("RESP_CD:STRING:NOTNULL, POSTION_TXT:STRING, CAREERF_TXT:STRING, DEFINT_TXT:STRING, AFFAIR_TXT:STRING, ABILITY_TXT:STRING, EXPOCC_TXT:STRING, ENCOCC_TXT:STRING, ETC_TXT:STRING, ROADMAP_TXT:STRING");
                }
                // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
                dsT_CD_RESPMST.AddRow();

//                dsT_CD_RESPMST.NameValue(1, "RESP_CD")   = opener.resp_cd;

                document.getElementById('txtPOSITION_TXT').focus();

            }
            else {
                fnc_ColEnabled('E');
                document.getElementById("imgSave").disabled = true;
            }
        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CD_RESPMST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_RESPMST Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CD_RESPMST event="OnFail()">

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
<input type="hidden" name="tbl1_row_cnt" value="2">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><%=title%></td>
					<td align="right" class="navigator">HOME/��������/CDP/��å����/��å�����/<font color="#000000"><%=title%></font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">   <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

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

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��å</td>
                    <td class="padding2423">
	                    <input id=txtRESP_NM name=txtRESP_NM size="50" class="input_ReadOnly" readOnly>
	                    <input id=txtRESP_CD name=txtRESP_CD size="6" class="input_ReadOnly" readOnly>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="300"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">Position</td>
					<td class="padding2423">
	                    <input id=txtPOSITION_TXT name=txtPOSITION_TXT size="34" maxlength="200">
					</td>
					<td align="center" class="creamBold">Career Field</td>
					<td class="padding2423">
	                    <input id=txtCAREERF_TXT name=txtCAREERF_TXT size="40" maxlength="200">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width=""></col>

				</colgroup>
				<tr>
					<td align="center" class="creamBold">Definition</td>
					<td class="padding2423">
	                    <input id=txtDEFINT_TXT name=txtDEFINT_T_TXT size="110" maxlength="200">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width=""></col>

				</colgroup>
				<tr>
					<td align="center" class="creamBold">&nbsp;</td>
					<td align="center" class="creamBold">����</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�ֿ����</td>
					<td class="padding2423">
	                    <textarea id=txtAFFAIR_TXT name=txtAFFAIR_TXT rows="3" cols="110" onkeyup="fc_chk_byte(this,2000);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width=""></col>

				</colgroup>
				<tr>
					<td align="center" class="creamBold">�䱸����</td>
					<td class="padding2423">
	                    <textarea id=txtABILITY_TXT name=txtABILITY_TXT rows="2" cols="110" onkeyup="fc_chk_byte(this,2000);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
	    <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="300"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�ʼ�����ٷα���</td>
					<td class="padding2423">
	                    <textarea id=txtEXPOCC_TXT name=txtEXPOCC_TXT rows="3" cols="45" onkeyup="fc_chk_byte(this,200);"></textarea>
					</td>
					<td align="center" class="creamBold">�������ٷα���</td>
					<td class="padding2423">
	                    <textarea id=txtENCOCC_TXT name=txtENCOCC_TXT rows="3" cols="40" onkeyup="fc_chk_byte(this,200);"></textarea>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��Ÿ</td>
					<td colspan="3" class="padding2423">
	                    <textarea id=txtETC_TXT name=txtETC_TXT rows="2" cols="110" onkeyup="fc_chk_byte(this,200);"></textarea>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">Career<br />Roadmap<br />(����)</td>
					<td colspan="3" class="padding2423">

 	                    <iframe id=txtROADMAP_SRC src=txtROADMAP_SRC  height=200 width=600></iframe>


  	                    <input id=txtROADMAP_TXT name=txtROADMAP_TXT size="100" onkeyup="fc_chk_byte(this,100);">

					</td>
				</tr>
			</table>
		</td>
	</tr>

	</table>

<!-- ���� �Է� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>

	<!--
	**************************************************************
	* ���ε� ������Ʈ
	**************************************************************
	-->

	<!-- ��å����� ���̺� -->
	<object id="bndT_CD_RESPCODE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CD_RESPCODE">
		<Param Name="BindInfo", Value='
			<C>Col=RESP_CD        Ctrl=txtRESP_CD       Param=value</C>
			<C>Col=RESP_NM        Ctrl=txtRESP_NM       Param=value</C>
	    '>
	</object>

	<!-- ��å�������� ���̺� -->
 	<object id="bndT_CD_RESPMST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_CD_RESPMST">
		<Param Name="BindInfo", Value='
			<C>Col=POSITION_TXT   Ctrl=txtPOSITION_TXT  Param=value</C>
			<C>Col=CAREERF_TXT    Ctrl=txtCAREERF_TXT   Param=value</C>
			<C>Col=DEFINT_TXT     Ctrl=txtDEFINT_TXT    Param=value</C>
			<C>Col=AFFAIR_TXT     Ctrl=txtAFFAIR_TXT    Param=value</C>
			<C>Col=ABILITY_TXT    Ctrl=txtABILITY_TXT   Param=value</C>
			<C>Col=EXPOCC_TXT     Ctrl=txtEXPOCC_TXT    Param=value</C>
			<C>Col=ENCOCC_TXT     Ctrl=txtENCOCC_TXT    Param=value</C>
			<C>Col=ETC_TXT        Ctrl=txtETC_TXT       Param=value</C>
			<C>Col=ROADMAP_TXT    Ctrl=txtROADMAP_TXT   Param=value</C>
			<C>Col=ROADMAP_SRC    Ctrl=txtROADMAP_SRC   Param=src</C>

	    '>
	</object>
