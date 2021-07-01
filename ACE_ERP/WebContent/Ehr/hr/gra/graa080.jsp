<!--
***********************************************************************
* @source      : graa080.jsp
* @description : ����������/����������/¡���ڸ���Ʈ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      ���뼺        �����ۼ�.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����������/����������/¡���ڸ���Ʈ(graa080)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			
			var pis_yymm = document.getElementById('txtPIS_YYMM_SHR').value;
			var ret_yymm = document.getElementById('txtRET_YYMM_SHR').value;
			var apy_ymd = document.getElementById('txtAPY_YMD').value;
            var remark = "";
            if(document.form1.rdoREMARK[0].checked){
                remark = "��������";
            }else if(document.form1.rdoREMARK[1].checked){
                remark = "����";
            }else {
                remark = "¡��";
            }

            if(!fnc_SearchItemCheck()) return;

            dsT_PM_GRADE.ClearData();

            trT_PM_GRADE.KeyValue = "tr01(O:dsT_PM_GRADE=dsT_PM_GRADE)";
			trT_PM_GRADE.action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa080.cmd.GRAA080CMD&S_MODE=SHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7)+"&RET_YY="+ret_yymm.substring(0,4)+"&RET_MM="+ret_yymm.substring(5,7)+"&APY_YMD="+apy_ymd+"&REMARK="+remark;
			trT_PM_GRADE.post();

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

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

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
			
            document.getElementById('txtPIS_YYMM_SHR').value = '';
			document.getElementById('txtRET_YYMM_SHR').value = '';
			document.getElementById('txtAPY_YMD').value = '';
			document.form1.rdoREMARK[0].checked = true;
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_GRADE.ClearData();

            document.getElementById('txtPIS_YYMM_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {
			
			var pis_yymm = document.getElementById('txtPIS_YYMM_SHR');
			var ret_yymm = document.getElementById('txtRET_YYMM_SHR');
			var apy_ymd = document.getElementById('txtAPY_YMD');

            if(pis_yymm.value == ""){
                alert("���Գ���� �ݵ�� �Է��ϼž� �մϴ�!");
                pis_yymm.focus();
                return false;
            }
            if(ret_yymm.value == ""){
                alert("�ұ޳���� �ݵ�� �Է��ϼž� �մϴ�!");
                ret_yymm.focus();
                return false;
            }
            if(apy_ymd.value == ""){
                alert("ȣ��ǥ���ڴ� �ݵ�� �Է��ϼž� �մϴ�!");
                apy_ymd.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
			
			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_PM_GRADE,0,"false","false");      // Grid Style ����
			
            document.getElementById('txtPIS_YYMM_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_PM_GRADE)    |
    | 3. ���Ǵ� Table List(T_PM_GRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_PM_GRADE)	    |
    | 3. ���Ǵ� Table List(T_PM_GRADE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_PM_GRADE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_J3"/>
       <jsp:param name="CODE_GUBUN"    value="J3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">
		
        

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_PM_GRADE event="OnSuccess()">
        if (dsT_PM_GRADE.CountRow < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
			document.getElementById("resultMessage").innerText = "* �ڷᰡ ��ȸ�Ǿ����ϴ�!";

        }
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_PM_GRADE event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������/����������/¡���ڸ���Ʈ</td>
					<td align="right" class="navigator">HOME/�λ����/�±�/<font color="#000000">����������/����������/¡���ڸ���Ʈ</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                                    <col width="90"></col>
                                    <col width="80"></col>
                                    <col width="90"></col>
                                    <col width="90"></col>
                                    <col width="120"></col>
                                    <col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">���Գ��&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','10','115');"></a>
                                </td>
                                <td align="right" class="searchState">�ұ޳��&nbsp;</td>
								<td class="padding2423"><input id="txtRET_YYMM_SHR" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtRET_YYMM_SHR','','160','115');"></a>
                                </td>
								<td align="right" class="searchState">ȣ��ǥ����&nbsp;</td>
								<td class="padding2423"><input id="txtAPY_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','350','115');"></a></td>
                                <td class="padding2423">
									<input type="radio" id="radio1" name="rdoREMARK" style="border:none" value="0" checked>�������� <input type="radio" id="radio2" name="rdoREMARK" style="border:none" value="1">���� <input type="radio" id="radio2" name="rdoREMARK" style="border:none" value="2">¡��
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_PM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_PM_GRADE">
							<param name="Format"					value="
                                <C> id='NO'             width=29    name='NO'               align=center    </C>
                                <C> id='OCC_NM'         width=50    name='�ٷα���'             align=center    </C>
                                <C> id='DPT_NM'         width=100   name='�Ҽ�'             align=center    </C>
                                <C> id='JOB_NM'         width=50    name='����'             align=center    </C>
                                <C> id='ENO_NO'         width=70    name='���'             align=center    </C>
                                <C> id='ENO_NM'         width=70    name='����'             align=center    </C>
                                <C> id='SAL_GBN'        width=50    name='�޻�'           align=center    </C>
                                <C> id='JCD_CD'         width=100   name='����'             align=left EditStyle=Lookup  Data='dsCOMMON_J3:CODE:CODE_NAME'</C>
                                <C> id='STR_YMD'        width=70    name='�߻�����'         align=center Mask='XXXX-XX-XX'</C>
                                <C> id='END_YMD'        width=70    name='�߻�����'         align=center Mask='XXXX-XX-XX'</C>
                                <C> id='FROM_YMD'       width=70    name='������'           align=center Mask='XXXX-XX-XX'</C>
                                <C> id='TO_YMD'         width=70    name='������'           align=center Mask='XXXX-XX-XX'</C>
                                <C> id='HOB'            width=50    name='��ȣ��'           align=center    </C>
                                <C> id='BAS_AMT'        width=70    name='�⺻��'           align=right     </C>
                                <C> id='DUTY_AMT'       width=70    name='��å/����'        align=right     </C>
                                <C> id='OT_AMT'         width=70    name='�ð���'           align=right     </C>
                                <C> id='WEL_AMT'        width=70    name='����/���'        align=right     </C>
                                <C> id='OSE_AMT'        width=85    name='�ڱⰳ��/�ù�'    align=right     </C>
                                <C> id='RUN_AMT'        width=70    name='����'             align=right     </C>
                                <C> id='MH_AMT'         width=85    name='����/�ڱⰳ��'    align=right     </C>
                                <C> id='OLD_SALT_AMT'   width=80    name='�Ѱ�'             align=right     </C>
                                <C> id='FIN_HOB'        width=50    name='��ȣ��'           align=center    </C>
                                <C> id='BAS_AMT1'       width=70    name='�⺻��'           align=right     </C>
                                <C> id='DUTY_AMT1'      width=70    name='��å/����'        align=right     </C>
                                <C> id='OT_AMT1'        width=70    name='�ð���'           align=right     </C>
                                <C> id='WEL_AMT1'       width=70    name='����/���'        align=right     </C>
                                <C> id='OSE_AMT1'       width=85    name='�ڱⰳ��/�ù�'    align=right     </C>
                                <C> id='RUN_AMT1'       width=70    name='����'             align=right     </C>
                                <C> id='MH_AMT1'        width=85    name='����/�ڱⰳ��'    align=right     </C>
                                <C> id='NEW_SALT_AMT'   width=80    name='�Ѱ�'             align=right     </C>
                                <C> id='SALT_AMT'       width=80    name='�ұޱݾ�'         align=right     </C>
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
