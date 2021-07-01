<!--
***********************************************************************
* @source      : vluk010.jsp
* @description : �򰡱Ⱓ ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/22      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�򰡱Ⱓ ����(vluk010)</title>
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
    <script language="javascript" >

		var btnList = 'TTTTFFTT';

        var today = '<%=box.get("SESSION_TODAY")%>';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var eva_yy = document.getElementById('txtEVA_YY_SHR').value;

            if(!fnc_SearchItemCheck()) return;  //��ȸ ��ȿ�� �˻�

			dsT_EV_RQSTYMD.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk010.cmd.VLUK010CMD&S_MODE=SHR&EVAYM="+eva_yy;
    		dsT_EV_RQSTYMD.reset();

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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

            trT_EV_RQSTYMD.KeyValue = "tr01(I:dsT_EV_RQSTYMD=dsT_EV_RQSTYMD)";
			trT_EV_RQSTYMD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk010.cmd.VLUK010CMD&S_MODE=SAV";
			trT_EV_RQSTYMD.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_EV_RQSTYMD.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

			if(confirm("[�⵵:"+dsT_EV_RQSTYMD.NameValue(dsT_EV_RQSTYMD.RowPosition,'EVAYM')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_EV_RQSTYMD.DeleteRow(dsT_EV_RQSTYMD.RowPosition);
				trT_EV_RQSTYMD.KeyValue = "tr01(I:dsT_EV_RQSTYMD=dsT_EV_RQSTYMD)";
				trT_EV_RQSTYMD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk010.cmd.VLUK010CMD&S_MODE=DEL";
				trT_EV_RQSTYMD.post();
			}

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

            //DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_EV_RQSTYMD.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_EV_RQSTYMD.setDataHeader("EVAYM:STRING:KEYVALUE, STR_YMD:STRING, END_YMD:STRING");
			}

            dsT_EV_RQSTYMD.AddRow();
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


        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_RQSTYMD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            var eva_yy = document.getElementById('txtEVA_YY_SHR');

            if(eva_yy.value == "" || eva_yy.value.length < 6){
                alert("6�ڸ��� ����� �Է��ϼ���!");
                eva_yy.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_RQSTYMD.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}


            //��û��, �������� ������ ���� ����
            var str_ymd;
            var end_ymd;
            var str_ymd2;
            var end_ymd2;

            for(var i=1; i<=dsT_EV_RQSTYMD.CountRow; i++) {
                str_ymd = parseInt(dsT_EV_RQSTYMD.NameString(i, "STR_YMD").replace(/-/g, ""));
                end_ymd = parseInt(dsT_EV_RQSTYMD.NameString(i, "END_YMD").replace(/-/g, ""));

                for(var j=1; j<=dsT_EV_RQSTYMD.CountRow; j++) {
                    if(i == j) continue;

                    str_ymd2 = parseInt(dsT_EV_RQSTYMD.NameString(j, "STR_YMD").replace(/-/g, ""));
                    end_ymd2 = parseInt(dsT_EV_RQSTYMD.NameString(j, "END_YMD").replace(/-/g, ""));

                    if((str_ymd  <= str_ymd2 && str_ymd2 <= end_ymd)
                            || (str_ymd  <= end_ymd2 && end_ymd2 <= end_ymd)
                            || (str_ymd2 <= str_ymd  && str_ymd  <= end_ymd2)
                            || (str_ymd2 <= end_ymd  && end_ymd  <= end_ymd2)) {
                        alert(i+"��° �ٰ� "+j+"��° ���� �Ⱓ���� �ߺ��˴ϴ�.\n ��û�����Ͽ�, ��û�������� Ȯ���� �ּ���.");
                        return false;
                    }
                }
            }

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_EV_RQSTYMD,15,"false","false");      // Grid Style ����

			document.getElementById("txtEVA_YY_SHR").value = getToday().substring(0,7);

            fnc_DisableElementAll(elementList);
            
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		var elementList = new Array( "txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"imgSTR_YMD"
                                    ,"imgEND_YMD");

		var keyList = new Array(     "txtSTR_YMD"
                                    ,"txtEND_YMD");


        /**
         * ��û �������ڸ� ������ ��û �⵵�� �ڵ����� ���ε�
         */
        function bindEVA_YY() {
            var str_ymd = document.getElementById("txtSTR_YMD").value;
            var eva_yy = "";

            if(str_ymd.length > 5) {
                eva_yy = str_ymd.substr(0,4)+str_ymd.substr(5.2);
            }
            dsT_EV_RQSTYMD.NameString(dsT_EV_RQSTYMD.RowPosition, "EVAYM") = eva_yy;
        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_EV_RQSTYMD)   |
    | 3. ���Ǵ� Table List(T_EV_RQSTYMD)		     |
    +------------------------------------------------>
    <Object ID="dsT_EV_RQSTYMD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_EV_RQSTYMD)	    |
    | 3. ���Ǵ� Table List(T_EV_RQSTYMD)	            |
    +--------------------------------------------------->
    <Object ID ="trT_EV_RQSTYMD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_RQSTYMD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_RQSTYMD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_RQSTYMD Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_RQSTYMD event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_RQSTYMD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_EV_RQSTYMD event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            fnc_EnableElementAll(elementList);
        }
    </script>


    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_EV_RQSTYMD event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_EV_RQSTYMD.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_EV_RQSTYMD.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�򰡱Ⱓ����</td>
					<td align="right" class="navigator">HOME/�λ���/������/<font color="#000000">�򰡱Ⱓ����</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">������&nbsp;</td>
								<td class="padding2423">

                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
											    <input type="text" id="txtEVA_YY_SHR" style="ime-mode:disabled" size="7" maxlength= "7" onkeypress="javascript:if(event.keyCode==13)fnc_SearchList(); cfDateHyphen(this);  cfNumberCheck()">
                                            </td>

                                        </tr>

                                    </table>

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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�򰡽�����</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this); bindEVA_YY();" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imdSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imdSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','60','180');"></a>
                    </td>
                    <td align="center" class="creamBold">��������</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','60','180');"></a>
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
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_EV_RQSTYMD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_EV_RQSTYMD">
                            <param name="Format"					value="
								<C> id={currow}				width=65    	name='NO'		    	align=center </C>
								<C> id='EVAYM'	    		width=230		name='������'	    align=center mask='XXXX-XX'</C>
                                <C> id='STR_YMD' 			width=230		name='�� ������'	    align=center </C>
								<C> id='END_YMD'			width=230		name='�� ������'	    align=center </C>
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

</form>
<!-- form �� -->

</body>
</html>

<!-- ������ �Ⱓ ���� ���̺� -->
<object id="bndT_EV_RQSTYMD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_RQSTYMD">
    <Param Name="BindInfo", Value='
        <C> Col=EVAYM         Ctrl=txtEVAYM      		Param=value</C>
        <C> Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value</C>
        <C> Col=END_YMD      Ctrl=txtEND_YMD      Param=value</C>
    '>
</object>