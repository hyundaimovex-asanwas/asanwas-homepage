<!--
***********************************************************************
* @source      : weld040.jsp
* @description : �ܵ���������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/15      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�ܵ����������(weld040)</title>
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
		var emp_Sbutton = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var ord_year = document.getElementById('txtYEAR_SHR').value;

			if(!fnc_SearchItemCheck()) return;

			dsT_WL_CONDOSSN.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld040.cmd.WELD040CMD&S_MODE=SHR&ORD_YEAR="+ord_year;
    		dsT_WL_CONDOSSN.reset();

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

			trT_WL_CONDOSSN.KeyValue = "tr01(I:dsT_WL_CONDOSSN=dsT_WL_CONDOSSN)";
			trT_WL_CONDOSSN.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld040.cmd.WELD040CMD&S_MODE=SAV";
			trT_WL_CONDOSSN.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_CONDOSSN.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[������ȣ:"+dsT_WL_CONDOSSN.NameValue(dsT_WL_CONDOSSN.RowPosition,'ORD_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_WL_CONDOSSN.DeleteRow(dsT_WL_CONDOSSN.RowPosition);
				trT_WL_CONDOSSN.KeyValue = "tr01(I:dsT_WL_CONDOSSN=dsT_WL_CONDOSSN)";
				trT_WL_CONDOSSN.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld040.cmd.WELD040CMD&S_MODE=DEL";
				trT_WL_CONDOSSN.post();
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
			if(dsT_WL_CONDOSSN.CountColumn < 1){
				alert("��ȸ �� �ű��ۼ��� �����մϴ�!");
				return;
			}
			var maxRow = dsT_WL_CONDOSSN.CountRow;
			var ord_no = 0;

			if(maxRow < 1){
				ord_no = getToday().substring(0,4)+"-01";
			} else {
				ord_no = dsT_WL_CONDOSSN.NameMax("ORD_NO", 0, 0).substring(0,4)+ "-" +
                         lpad((parseInt(dsT_WL_CONDOSSN.NameMax("ORD_NO", 0, 0).substring(5,7))+1), 2, '0');
			}

			dsT_WL_CONDOSSN.AddRow();
            if(dsT_WL_CONDOSSN.NameValue(dsT_WL_CONDOSSN.RowPosition, 'ORD_NO') == "")
    			dsT_WL_CONDOSSN.NameValue(dsT_WL_CONDOSSN.RowPosition, 'ORD_NO') = ord_no;
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
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOSSN.ClearData();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_CONDOSSN.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var ord_year = document.getElementById('txtYEAR_SHR').value;

			if(ord_year != '' && ord_year.length != 4){
				alert("������ �ݵ�� 4�ڸ��� �Է��ϼž� �մϴ�!");
				document.getElementById('txtYEAR_SHR').focus();
				return false;
			}
			return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_WL_CONDOSSN.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {


			cfStyleGrid(form1.grdT_WL_CONDOSSN,15,"false","false");      // Grid Style ����

            document.getElementById("txtYEAR_SHR").value = getTodayArray()[0];
            document.getElementById('txtYEAR_SHR').focus();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}
        
        var elementList = new Array(         "txtORD_NO"
                                            ,"txtSTR_YMD"
                                            ,"txtEND_YMD"
                                            ,"txtAPP1_YMD"
                                            ,"txtAPP2_YMD" 
                                            ,"imgSTR_YMD"
                                            ,"imgEND_YMD"
                                            ,"imgAPP1_YMD"
                                            ,"imgAPP2_YMD" );
                                            
        var exceptionList = new Array(       "txtORD_NO" );
        
        var keyList = new Array(             "txtORD_NO"
                                            ,"txtSTR_YMD"
                                            ,"txtEND_YMD"
                                            ,"txtAPP1_YMD"
                                            ,"txtAPP2_YMD" );


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOSSN) |
    | 3. ���Ǵ� Table List(T_WL_CONDOSSN)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_CONDOSSN)	|
    | 3. ���Ǵ� Table List(T_WL_CONDOSSN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOSSN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOSSN Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������ȣ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("������ȣ�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_CONDOSSN event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_CONDOSSN event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CONDOSSN event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            //�ű��� ���        
            if(dsT_WL_CONDOSSN.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>
 
    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_WL_CONDOSSN event=CanRowPosChange(row)>
        var keyName;
        var colName;
        
        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);
                
                if (dsT_WL_CONDOSSN.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_WL_CONDOSSN.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ܵ����������</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ܵ�/<font color="#000000">�ܵ����������</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<col width="80"></col>
								<col width="80"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="right" class="searchState">����&nbsp;</td>
								<td class="padding2423">
									<input id="txtYEAR_SHR"  size="4" maxLength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
								</td>
								<td>&nbsp;<td>
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
					<col width="60"></col>
					<col width="70"></col>
					<col width="60"></col>
					<col width="230"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">������ȣ</td>
					<td class="padding2423">
						<input id="txtORD_NO"  size="10" maxLength="7" style="ime-mode:disabled;text-align:center">
					</td>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtSTR_YMD','','150','152');"></a>
                         ~
						<input id="txtEND_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtEND_YMD','','270','152');"></a>
					</td>
					<td align="center" class="creamBold">��û�Ⱓ</td>
					<td class="padding2423">
						<input id="txtAPP1_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtAPP1_YMD','txtAPP1_YMD','txtAPP2_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP1_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPP1_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtAPP1_YMD','','450','152');"></a>
                         ~
						<input id="txtAPP2_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtAPP2_YMD','txtAPP1_YMD','txtAPP2_YMD'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP2_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPP2_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDOSSN.CountColumn < 1) return; calendarBtn('datetype1','txtAPP2_YMD','','570','152');"></a>
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
						<object	id="grdT_WL_CONDOSSN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_WL_CONDOSSN">
							<param name="Format"					value="
								<C> id={currow}		width=70    name='NO'			align=center </C>
								<C> id='ORD_NO'		width=155	name='������ȣ'		align=center </C>
								<C> id='STR_YMD'	width=20	name='�����������'	align=center Show=false </C>
								<C> id='END_YMD'	width=20	name='������������'	align=center Show=false </C>
								<C> id='YMD'		width=270	name='������'		align=center Value={(STR_YMD&' ~ '&END_YMD)} </C>
								<C> id='APP1_YMD'	width=20	name='��û������'	align=center Show=false </C>
								<C> id='APP2_YMD'	width=20	name='��û������'	align=center Show=false </C>
								<C> id='APP_YMD'	width=270	name='��û�Ⱓ'		align=center Value={(APP1_YMD&' ~ '&APP2_YMD)} </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- KPI Pool ���� ���̺� -->
<object id="bndT_WL_CONDOSSN" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_CONDOSSN">
	<Param Name="BindInfo", Value='
		<C>Col=ORD_NO		Ctrl=txtORD_NO	      	Param=value</C>
		<C>Col=STR_YMD    	Ctrl=txtSTR_YMD	     	Param=value</C>
		<C>Col=END_YMD		Ctrl=txtEND_YMD	      	Param=value</C>
		<C>Col=APP1_YMD		Ctrl=txtAPP1_YMD		Param=value</C>
		<C>Col=APP2_YMD		Ctrl=txtAPP2_YMD		Param=value</C>
    '>
</object>