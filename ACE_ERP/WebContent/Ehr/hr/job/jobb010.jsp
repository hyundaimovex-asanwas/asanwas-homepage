<!--
    ************************************************************************************
    * @Source         : jobb010.jsp 					                                 *
    * @Description    : �����̵��������Ȳ.           *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/30  |  ���ؼ�   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>�����̵��������Ȳ(jobb010)</title>
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

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
		var btnList = 'T' + 'F' + 'T' + 'T' + 'T' + 'F' + 'F' + 'T';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			if( !fnc_SearchItemCheck() ) return;

			//�Ҽ�
			if( document.getElementById("searchDiv").value == '1' ) {
	            //�����ͼ� ����(�����̵��������Ȳ ��ȸ)
	            dsT_EV_JOBCHG.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb010.cmd.JOBB010CMD&S_MODE=SHR&txtPIS_YYMM_SHR="+document.getElementById("txtPIS_YYMM_SHR").value+"&cmbOCC_CD_SHR="+document.getElementById("cmbOCC_CD_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtCODE_SHR").value;
	            dsT_EV_JOBCHG.Reset();
            }
			//����
			if( document.getElementById("searchDiv").value == '2' ) {
	            //�����ͼ� ����(�����̵��������Ȳ ��ȸ)
	            dsT_EV_JOBCHG.DataID = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb010.cmd.JOBB010CMD&S_MODE=SHR&txtPIS_YYMM_SHR="+document.getElementById("txtPIS_YYMM_SHR").value+"&cmbOCC_CD_SHR="+document.getElementById("cmbOCC_CD_SHR").value+"&txtJOB_CD_SHR="+document.getElementById("txtCODE_SHR").value;
	            dsT_EV_JOBCHG.Reset();
            }


        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			if( !fnc_SaveItemCheck() )	return;

			//Ʈ����� ����
			trT_EV_JOBCHG.Action = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb010.cmd.JOBB010CMD&S_MODE=SAV";
			trT_EV_JOBCHG.Post();

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

            if (dsT_EV_JOBCHG.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_JOBCHG.GridToExcel("�����ο���Ȳ", '', 225)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

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

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);
			document.getElementById("cmbOCC_CD_SHR").value = '';
			document.getElementById("searchDiv").value = '1';
			document.getElementById("txtCODE_SHR").value = '';
			document.getElementById("txtCODE_NM_SHR").value = '';

			document.getElementById("resultMessage").innerText = '';
			dsT_EV_JOBCHG.ClearAll();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_EV_JOBCHG.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			if( document.getElementById("txtPIS_YYMM_SHR").value == '' ) {
				alert("�������� �ʼ��Է»����Դϴ�.");
                document.getElementById("txtPIS_YYMM_SHR").focus();
				return false;
			}

			if( document.getElementById("txtPIS_YYMM_SHR").value != '' && cfDateExpr(document.getElementById("txtPIS_YYMM_SHR").value) == false ) {
				alert("�������� ��¥���Ŀ� �����ʽ��ϴ�.");
                document.getElementById("txtPIS_YYMM_SHR").focus();
				return false;
			}
			return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	if ( dsT_EV_JOBCHG.isUpdated ) {

			} else {
				fnc_Message(document.getElementById("resultMessage"),"MSG_04");
				alert("���� �� �ڷᰡ �����ϴ�!");
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_JOBCHG, 15, "true", "false");

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);
            form1.grdT_EV_JOBCHG.RowHeight = "30";


        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************
         * 15. ���ǿ� ���� �����˾�â �б�  *
         *******************/
		function fnc_codePopup() {

			//�Ҽ�
			if( document.getElementById("searchDiv").value == '1' )
				fnc_commnmPopup('txtCODE_SHR','txtCODE_NM_SHR','�Ҽ�','DEPT')
			//����
			if( document.getElementById("searchDiv").value == '2' )
				fnc_commonCodePopup('txtCODE_SHR','txtCODE_NM_SHR','����','A2');


		}

        /********************
         * 16. ����Ű ó��  *
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->

    <Object ID="dsT_EV_JOBCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_JOBCHG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_JOBCHG)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-- �׸����� �˾��ʵ� Ŭ���� -->
    <script language="javascript" for=grdT_EV_JOBCHG event=OnPopup(Row,Colid,data)>

		var obj = new String();

		obj.title = '�Ҽ�';
		obj.gbn = 'DEPT';

		window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		if(obj.comm_cd != '' && obj.comm_nm != ''){
			dsT_EV_JOBCHG.NameValue(Row,"ACCEPT_DPTCD") = obj.comm_cd;
			dsT_EV_JOBCHG.NameValue(Row,"ACCEPT_DPTNM") = obj.comm_nm;
		}

    </script>

	<script language=JavaScript for=grdT_EV_JOBCHG event=OnExit(row,colid,olddata)>

		//�Ҽ����� ����
		if( colid == 'ACCEPT_DPTNM' ) {
			if( dsT_EV_JOBCHG.NameValue(row,colid) == '' )
				dsT_EV_JOBCHG.NameValue(row,'ACCEPT_DPTCD') = '';
		}

	</script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBCHG Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

        } else {

			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_JOBCHG.CountRow);

        }

  	 	form1.txtPIS_YYMM_SHR.focus();//set focus

    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_JOBCHG Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_JOBCHG Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_JOBCHG event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"),"MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_JOBCHG event="OnFail()">
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
	                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����̵��������Ȳ</td>
	                    <td align="right" class="navigator">HOME/�λ���/��������/�����̵�/<font color="#000000">�����̵��������Ȳ</font></td>
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
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',2)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
    				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',3)">  <img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<!-- ���� �Է� ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td align="center" class="greenTable">
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <colgroup>
	                                <col width="50"></col>
	                                <col width="50"></col>
	                                <col width="50"></col>
	                                <col width="50"></col>
	                                <col width="70"></col>
	                                <col width="50"></col>
	                                <col width="200"></col>
	                            </colgroup>
	                            <tr>
	                                <td align="right" class="searchState">������&nbsp;</td>
	                                <td class="padding2423">
									<input id="txtPIS_YYMM_SHR" style="ime-mode:disabled;text-align:center;" size="7" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();javascript:if(event.keyCode==13) fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','155','125');"><img src="/images/button/btn_HelpOn.gif" name="Image5" width="21" height="20" border="0" align="absmiddle"></a>
			                        </td>
	                                <td align="right" class="searchState">�ٷα���&nbsp;</td>
	                                <td class="">
										<select id="cmbOCC_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
											<option value='' selected>��ü</option>
											<option value='A'>�繫��</option>
											<option value='M'>�ù���</option>
										</select>
									</td>
	                                <td align="right" class="searchState">��ȸ����&nbsp;</td>
	                                <td class="">
										<select id="searchDiv" style="WIDTH: 80%;" onChange="javascript:document.getElementById('txtCODE_SHR').value='';document.getElementById('txtCODE_NM_SHR').value='';">
											<option value='1' selected>�Ҽ�</option>
											<option value='2'>����</option>
										</select>
									</td>
									<td align="left">
										<input id="txtCODE_SHR" size="8" style="text-align:center;" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">&nbsp;<input id="txtCODE_NM_SHR" size="8" class="input_ReadOnly" readOnly>
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)" onClick="fnc_codePopup();"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle"></a>
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
							<td align="right">&nbsp;</td>
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
	                        <object    id="grdT_EV_JOBCHG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
	                            <param name="DataID"                  value="dsT_EV_JOBCHG">
	                            <param name="EdiTABLE"                value="true">
	                            <param name="DragDropEnable"          value="true">
	                            <param name="SortView"                value="Left">
	                            <param name="VIEWSUMMARY"             value=0>
								<param name=UsingOneClick  value="1">
							    <param name="AutoReSizing"              value="true">
                            	<param name=ColSizing  value="true">

                                <param name="Format"                  value="
	                                <FC> id='PIS_YY'     width=80   name='�ش�⵵'      align=center	edit=none	show=false </FC>
	                                <FC> id='PIS_MM'     width=80   name='�ش��'        align=center 	edit=none	show=false </FC>
	                                <FC> id='HEAD_NM'    width=100   name='����'          align=center   edit=none   suppress =1 </FC>
	                                <FC> id='DPT_NM'     width=100  name='�Ҽ�'          align=center	edit=none   suppress =2 </FC>
	                                <FC> id='JOB_NM'     width=50   name='����'          align=center   edit=none </FC>
	                                <FC> id='ENO_NO'     width=70   name='���'          align=center 	 edit=none </FC>
	                                <FC> id='ENO_NM'     width=70   name='����'          align=center   edit=none </FC>
	                                <C> id='HIR_YMD'     width=70   name='�Ի���'        align=center	edit=none </C>
	                                <C> id='BIR_YMD'     width=70   name='�������'      align=center	edit=none </C>
	                                <C> id='JPR_YMD'     width=70   name='������'        align=center	edit=none </C>
	                                <C> id='DPA_YMD'     width=70   name='���Ҽ�;�߷���' align=center 	edit=none </C>
	                                <C> id='DHO_YMD'     width=70   name='�Ҽ�;�����Ⱓ' align=center 	edit=none		value={String(DHO_YMD)} </C>
	                                <C> id='EXM_PNT'     width=50   name='TOEIC'         align=center 	edit=none </C>
                                    <C> id='ANS_YN'      width=50   name='����;����'      align=center   edit=none </C>

                                    <G> name='����Ҽ�' HeadBgColor='#F7DCBB'
	                                    <C> id='HOPE_DEP1'     width=100    name='1����'        align=center 	edit=none </C>
	                                    <C> id='HOPE_DEP2'     width=100    name='2����'        align=center 	edit=none </C>
	                                    <C> id='HOPE_DEP3'     width=100    name='3����'        align=center 	edit=none </C>
	                                </G>

                                    <G> name='�̵������' HeadBgColor='#F7DCBB'
                                        <C> id='CHANGE_GBN'  width=150   name='�̵�����'        align=center   edit=none </C>
                                        <C> id='CHANGE_DEC'  width=250   name='��Ÿ����'        align=left     edit=none Multiline=true </C>
                                        <C> id='CHANGE_TIME' width=100   name='�̵��ñ�'        align=center   edit=none </C>
                                    </G>

                                    <G> name='Ȯ��' HeadBgColor='#F7DCBB'
	                                    <C> id='ACCEPT_GBN'    width=30    name='����'         align=center		editstyle=checkbox </C>
	                                    <C> id='ACCEPT_DPTCD'  width=80    name='�Ҽ�'         align=center		show=false </C>
	                                    <C> id='ACCEPT_DPTNM'  width=80    name='�ҼӸ�'       align=center		editstyle=popup </C>
	                                </G>
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