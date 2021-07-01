<!--
*****************************************************
* @source       : BOOK040.jsp
* @description : �������Խ�û��Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/03/15      �̵���        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���� ���� ��Ȳ</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTFTT';
		var chkValid  = 'T';


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	//�˻�����
			var STR_YMD_SHR   = document.getElementById("txtSTR_YMD_SHR").value;      	//��û��
			var END_YMD_SHR   = document.getElementById("txtEND_YMD_SHR").value;      	//��û��
			var BOOK_NM_SHR   = document.getElementById("txtBOOK_NM_SHR").value;      	//����


            //��ȸ �ش����� �����Ѵ�.
			dsT_ED_BOOKMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.cdp.a.book030.cmd.BOOK030CMD"
                                      + "&S_MODE=SHR_40"
                                      + "&STR_YMD_SHR="+STR_YMD_SHR
                                      + "&END_YMD_SHR="+END_YMD_SHR
                                      + "&BOOK_NM_SHR="+BOOK_NM_SHR;
			dsT_ED_BOOKMASTER.reset();


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


        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_ED_BOOKMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_ED_BOOKMASTER.GridToExcel("������Ȳ��ȸ", '', 225);
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {



        }

        /******************
         * 08. ��ȿ�� �˻� *
         ******************/
        function fnc_Valid() {


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
		function fnc_Append(){


		}

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {


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

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //�����ϴ� �͵� ����

            //��¥���� ���ε�
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 1);

			document.getElementById("txtSTR_YMD_SHR").value = getToday().substring(0,7);
			document.getElementById("txtEND_YMD_SHR").value = svc_ymd.substring(0,7);


        	cfStyleGrid(form1.grdT_ED_BOOKMASTER,15,"false","true")      // Grid Style ����

            //document.getElementById("resultMessage").innerText = '�۾�����: ��û�� > ��ȸ��ư > ��ȸ';

            fnc_SearchList();

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

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_ED_BOOKMASTER)	|
    | 3. ���Ǵ� Table List(T_ED_BOOKMASTER)	        |
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    <!-----------------------------+
    | grid���� row��     Ŭ�������� |
    +------ ------------------------>
	<script for=grdT_ED_BOOKMASTER event=OnClick(Row,Colid)>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������Խ�û��Ȳ</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">�������Խ�û��Ȳ</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
		  </font>
		</td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                    <col width="200"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                   <td class="searchState" align="right">������û��&nbsp;</td>
                   <td class="padding2423" align="left" id="key1"  style="display:">
									<input id="txtSTR_YMD_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','75','112');"></a>
									~
									<input id="txtEND_YMD_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YMD_SHR','','190','112');"></a>
                   </td>
                    <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
					<td class="padding2423">
						<input id=txtBOOK_NM_SHR name=txtBOOK_NM_SHR size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
					</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->



<table border="0">
	<tr>
		<td valign="top">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">
			        	<!-- ������ ���� ���̺� ���� -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_ED_BOOKMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
										<param name="DataID"				value="dsT_ED_BOOKMASTER">
										<param name="SortView"				value="Left">
										<param name="Format"				value="
			            					<C> id='{CUROW}'		width=40	name='NO'			align=center	value={String(Currow)}	</C>
											<C> id='RQST_NO'		width=80	name='��û��ȣ'		align=center	mask='XXXXXX-XXXX' suppress = '2' </C>
			            					<C> id='DPT_NM'			width=80	name='��û�μ�'		align=center	suppress = '1' </C>
											<C> id='JOB_NM'			width=60	name='����'			align=center	show=false	suppress = '1' </C>
											<C> id='ENO_NO'			width=100	name='���'			align=center	show=false	suppress = '1' </C>
											<C> id='ENO_NM'			width=80	name='��û��'		align=center	suppress = '1' </C>
											<C> id='BOOK_NM'		width=250	name='������'		align=left		</C>
											<C> id='BOOK_PUL'		width=100	name='���ǻ�'		align=left		</C>
											<C> id='BOOK_WRT'		width=100	name='����'			align=center	</C>
											<C> id='BOOK_QTY'		width=60	name='����'			align=center	</C>
											<C> id='BOOK_AMT'		width=80	name='����'			align=center	</C>
											<C> id='RQST_REMARK'	width=120	name='�뵵'			align=left		suppress = '1' </C>
											<C> id='BOOK_REMARK'	width=100	name='���'			align=left		</C>
											<C> id='END_TAG'		width=100	name='�������'		align=center	suppress = '1' value={Decode(END_TAG,'R','����','A','���','N','�ΰ�','Y','����Ϸ�','������')} </C>
										">
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
			                </tr>
			            </table>
			        	<!-- ������  ���� ���̺� �� -->
 					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

</body>
</html>


