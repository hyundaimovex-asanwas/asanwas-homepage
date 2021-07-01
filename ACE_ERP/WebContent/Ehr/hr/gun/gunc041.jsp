<!--
***********************************************************************
* @source      : gunc041.jsp
* @description : ���κ����ϱٹ���Ȳ�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/07      ���뼺        �����ۼ�.
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
	<title>���κ����ϱٹ���Ȳ��(gunc041)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>
	<base target="_self">
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_DI_DILIGENCE.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc041.cmd.GUNC041CMD&S_MODE=SHR&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&STR_YMD="+dsTemp.NameValue(1,"STR_YMD")+"&END_YMD="+dsTemp.NameValue(1,"END_YMD");
            dsT_DI_DILIGENCE.reset();

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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�

            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)

            // ���� �� �ش� �׸���� Focus �̵�

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

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

			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style ����

            document.getElementById("txtDPT_NM").value = dsTemp.NameValue(1,"DPT_NM");
            document.getElementById("txtJOB_NM").value = dsTemp.NameValue(1,"JOB_NM");
            document.getElementById("txtENO_NO").value = dsTemp.NameValue(1,"ENO_NO");
            document.getElementById("txtENO_NM").value = dsTemp.NameValue(1,"ENO_NM");

            fnc_SearchList();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��()      |
    | 3. ���Ǵ� Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_DILIGENCE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>



<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ����ϱٹ���Ȳ��</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���κ����ϱٹ���Ȳ��</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- ���� �Է� ���̺� ���� -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="85"></col>
					<col width="100"></col>
					<col width="85"></col>
                    <col width="100"></col>
					<col width="85"></col>
                    <col width="100"></col>
					<col width="85"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtENO_NO" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��</td>
					<td class="padding2423">
                        <input id="txtENO_NM" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
				</tr>
            </table>
            </td>
	</table>
	<!-- ���� �Է� ���̺� �� -->
</tr>
</table>

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
	                        <object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
	                            <param name="DataID"            value="dsT_DI_DILIGENCE">
	                            <param Name="Editable"          value="false">
								<param name=HiddenHScroll    value="true">
	                            <param name="Format"            value='
                                    <C> id={currow}		width=59    	name="NO"				align=center					 	</C>
	                                <C> id=REP_APP		width=144 	  	name=��û����       	align=center 	value={Decode(REP_APP,"1","��ü�ް�","2","��ü����","3","���ϱٹ�����"," ")}	</C>
	                                <C> id=HOL_YMD		width=144  	 	name=���ϱٹ���     	align=center 	Mask="XXXX-XX-XX"	</C>
									<C> id=HOL_TIME		width=144		name=���ϱٹ��ð�		align=center						</C>
	                            	<C> id=HOW_YMD		width=144		name=��ü�ް������	  	align=center 	Mask="XXXX-XX-XX"	</C>
									<C> id=HOL_AMT		width=144		name=���ϱٹ�����		align=right		value={Decode(HOL_AMT,0,"",HOL_AMT)}	</C>
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