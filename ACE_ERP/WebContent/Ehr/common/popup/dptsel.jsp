<!--
    ************************************************************************************
    * @Source         : dptsel.jsp                                                     *
    * @Description    : �ҼӼ��� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/27  |  ���뼺   | �����ۼ�                                               *
    * 2007/02/08  |  ���뼺   | �����˾����� �̵�                                      *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�ҼӼ���(dptsel)</title>
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
        var btnList = 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';

		var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_DEPT.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.dptsel.cmd.DPTSELCMD&S_MODE=SHR";
			dsT_CM_DEPT.Reset();

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

            var dpt_cd;

			if(dsT_CM_DEPT.NameValue(dsT_CM_DEPT.RowPosition, 'DPT_LBL') == '3'){
                dpt_cd = dsT_CM_DEPT.NameValue(dsT_CM_DEPT.RowPosition, 'DPT_CD');

				for(i=1;i<dsT_CM_DEPT_CP.CountRow+1;i++){
					if(dsT_CM_DEPT_CP.NameValue(i, 'DPT_CD') == dpt_cd) {
						alert("�̹� �����ϼ̽��ϴ�!");
						return;
					}
				}


                if(dsT_CM_DEPT.NameValueRow("DPT_CD", dpt_cd) != 0
                        &&  dsT_CM_DEPT.NameValue(dsT_CM_DEPT.NameValueRow("DPT_CD", dpt_cd), "NON_DELI") == "Y" ) {
                    alert("��� ����� ���� �Դϴ�.");
                    return;
                }


				//���õ� ROW�� ����
				dsT_CM_DEPT_CP.AddRow();
				dsT_CM_DEPT_CP.NameValue(dsT_CM_DEPT_CP.RowPosition, 'DPT_CD') = dsT_CM_DEPT.NameValue(dsT_CM_DEPT.RowPosition, 'DPT_CD');
				dsT_CM_DEPT_CP.NameValue(dsT_CM_DEPT_CP.RowPosition, 'DPT_NM') = dsT_CM_DEPT.NameValue(dsT_CM_DEPT.RowPosition, 'DPT_NM');

			}

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            dsT_CM_DEPT_CP.DeleteRow(dsT_CM_DEPT_CP.RowPosition);

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            window.close();
        }

		/********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_CM_DEPT,0,"false","false");
			form1.grdT_CM_DEPT.DragDropEnable  = "false";

			fnc_SearchList();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

		/********************
         * 16. Ȯ�ι�ư ó��  *
         *******************/
        function fnc_Confirm() {

            cfCopyDataSet(dsT_CM_DEPT_CP, dsTemp, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_CM_DEPT_CP.CountRow);
			dsT_CM_DEPT_CP.ClearAll();
			fnc_Exit();

        }


        /**
         * �ҼӸ� ������ �´�.
         */
        function fnc_AddDptCd() {
            var oCOMM_CD    = document.getElementById("txtCOMM_CD_SHR");
            var oCOMM_NM    = document.getElementById("txtCOMM_NM_SHR");

            fnc_GetCommCd('A4', 'txtCOMM_CD_SHR', 'txtCOMM_NM_SHR');


            if(oCOMM_CD.value == "") {
                return;
            }

			for(i=1;i<dsT_CM_DEPT_CP.CountRow+1;i++){
				if(dsT_CM_DEPT_CP.NameValue(i, 'DPT_CD') == oCOMM_CD.value) {
					alert("�̹� �����ϼ̽��ϴ�!");

                    oCOMM_CD.value = "";
                    oCOMM_NM.value = "";

					return;
				}
			}

            if(dsT_CM_DEPT.NameValueRow("DPT_CD", oCOMM_CD.value) != 0
                    &&  dsT_CM_DEPT.NameValue(dsT_CM_DEPT.NameValueRow("DPT_CD", oCOMM_CD.value), "NON_DELI") == "Y" ) {
                alert("��� ����� ���� �Դϴ�.");

                oCOMM_CD.value = "";
                oCOMM_NM.value = "";

                return;
            }

			//���õ� ROW�� ����
			dsT_CM_DEPT_CP.AddRow();
			dsT_CM_DEPT_CP.NameValue(dsT_CM_DEPT_CP.RowPosition, 'DPT_CD') = oCOMM_CD.value;
			dsT_CM_DEPT_CP.NameValue(dsT_CM_DEPT_CP.RowPosition, 'DPT_NM') = oCOMM_NM.value;


            oCOMM_CD.value = "";
            oCOMM_NM.value = "";
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_DEPT)    |
    | 3. ���Ǵ� Table List(T_CM_DEPT)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!----------------------------------------------+
    | 1. ī�ǿ� DataSet                             |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_DEPT)    |
    | 3. ���Ǵ� Table List(T_CM_DEPT)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_DEPT_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_DEPT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {


        }
        else {

			cfCopyDataSetHeader(dsT_CM_DEPT, dsT_CM_DEPT_CP);
			//dsT_CM_DEPT_CP.SetDataHeader("DPT_CD:STRING:KEYVALUE, DPT_NM:STRING");

			//alert("countrow : "+dsTemp.CountRow+"\n"+dsTemp.ExportData(1, dsTemp.CountRow, true));
			//�̹� ������ �Ҽӵ��� ������ �ٽ� �����ش�.
			if(dsTemp.CountRow != 0){
				for(i=1;i<=dsTemp.CountRow;i++){
					dsT_CM_DEPT_CP.AddRow();
					dsT_CM_DEPT_CP.NameValue(dsT_CM_DEPT_CP.RowPosition, 'DPT_CD') = dsTemp.NameValue(i, 'DPT_CD');
					dsT_CM_DEPT_CP.NameValue(dsT_CM_DEPT_CP.RowPosition, 'DPT_NM') = dsTemp.NameValue(i, 'DPT_NM');
				}
			}


        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_DEPT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DEPT_CP Event="OnDataError()">

        if (this.ErrorCode == 50019) {
	        alert("�ߺ����� �����մϴ�!");
			fnc_Remove();
        } else {
		    cfErrorMsg(this);
	    }

	</Script>

	<!-----------------------------+
    | Ʈ�� �並 ���� Ŭ�� ���� ��  |
    +------------------------------>
	<script language=JavaScript for=tvT_CM_DEPT event=OnDblClick()>

		fnc_Append();

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

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="650" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ҼӼ���</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="650" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="650" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td width="250" class="paddingTop8">


                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" class="greenTable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" class="searchState">�ҼӸ�&nbsp;</td>
                                            <td class="padding2423">
                                                <input type="text" name="txtCOMM_NM_SHR" id="txtCOMM_NM_SHR" maxlength="20" onkeypress="if(event.keyCode==13) fnc_AddDptCd();">
                                                <input type="hidden" name="txtCOMM_CD_SHR" id="txtCOMM_CD_SHR">
                                                <input type="text" style="display:none">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>


                    </td>
                </tr>
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_DEPT" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:250px;height:300px">
							<param name=DataID		value="dsT_CM_DEPT">
							<param name=TextColumn	value="DPT_NM">
							<param name=LevelColumn	value="DPT_LBL">
							<param name=ExpandLevel	value="0">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CM_DUTYMST">
							<param name=ImgCColumn	value="ImgC">
							<param name=ImgDColumn	value="ImgD">
							<param name=ImgOColumn	value="ImgO"> -->
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ Ʈ�� ��-->
    </td>
	<td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table width="100" border="0" cellspacing="0" cellpadding="0">
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
					</td>
				</tr>
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
					</td>
				</tr>
				<tr align="center">
					<td height="60">&nbsp;
					</td>
				</tr>
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
					</td>
				</tr>
				<tr height="40" align="center">
					<td>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ Ʈ�� ��-->
    </td>
    <td>
        <!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
        				<comment id="__NSID__">
        				<object	id="grdT_CM_DEPT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:270;height:350px;">
        					<param name="DataID"				value="dsT_CM_DEPT_CP">
        					<param name="EdiTABLE"				value="false">
        					<param name="DragDropEnable"		value="true">
        					<param name="SortView"				value="Left">
        					<param name="VIEWSUMMARY"			value=0>
        					<param name="Format"				value="
										<C> id='DPT_CD'		width=80       name='�Ҽ�'		align=center	</C>
										<C> id='DPT_NM'		width=170      name='�ҼӸ�'	align=left		</C>
        							">
        				</object>
        				</comment><script> __ShowEmbedObject(__NSID__); </script>
        			</td>
        		</tr>
        	</table>
        <!-- ���� ��ȸ �׸��� ���̺� ��-->
    </td>
</tr>
</table>

</form>
<!-- form �� -->

</body>
</html>