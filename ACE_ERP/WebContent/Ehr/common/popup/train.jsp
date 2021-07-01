<!--
***********************************************************************
* @source      : train.jsp
* @description : ö������뼱�˻� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2008/09/11      �����         �����ۼ�.
***********************************************************************
-->



<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/sessionCheck.jsp" %>

<% String gubun = request.getParameter("GUBUN");  %>
<% String eno_no = request.getParameter("ENO_NO"); %>

<html>

    <head>
	<title>�뼱�̷°˻�(train)</title>
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

		var retObj = window.dialogArguments;

		retObj.str_city_ins = '';
		retObj.end_city_ins = '';
	    retObj.str_city = '';
	    retObj.end_city = '';


        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

             var GUBUN    = '<%=gubun%>';
             var ENO_NO   = "<%=eno_no%>";

            //�����ͼ� ����
            dsT_DI_BUSINESSTRIP_KORAIL.DataID = "/servlet/GauceChannelSVL?cmd=common.popup.train.cmd.TRAINCMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&GUBUN="+GUBUN;
            dsT_DI_BUSINESSTRIP_KORAIL.reset();

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


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {


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

            fnc_SearchList();

			cfStyleGrid(form1.grdT_DI_BUSINESSTRIP_KORAIL,0,"false","flase");      // Grid Style ����

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_BUSINESSTRIP_KORAIL)      |
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_KORAIL)             |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_KORAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), 'MSG_02');

        } else {
            //fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
		}

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_KORAIL Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
	<script language=JavaScript for=grdT_DI_BUSINESSTRIP_KORAIL event=OnDblClick(row,colid)>

		var retObj = window.dialogArguments;
		retObj.str_city_ins = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'STR_CITY_INS');
		retObj.end_city_ins = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'END_CITY_INS');
		retObj.str_city = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'STR_CITY');
		retObj.end_city = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'END_CITY');
		window.close();

	</script>

	<!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
	<script language=JavaScript for=grdT_DI_BUSINESSTRIP_KORAIL event=OnReturn(row,colid)>

		var retObj = window.dialogArguments;
		retObj.str_city_ins = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'STR_CITY_INS');
		retObj.end_city_ins = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'END_CITY_INS');
		retObj.str_city = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'STR_CITY');
		retObj.end_city = dsT_DI_BUSINESSTRIP_KORAIL.NameValue(row,'END_CITY');
		window.close();

	</script>


<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="400" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="25" background="/images/common/barBg.gif">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
	                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�뼱�̷� �˻�</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="400" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
	<!--             <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>  -->
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<!-- power Search���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="400" border="0" cellspacing="0" cellpadding="0">
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
	<table width="400" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr align="center">
	                    <td>
	                        <comment id="__NSID__">
	                        <object    id="grdT_DI_BUSINESSTRIP_KORAIL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:250px;">
	                            <param name="DataID"            value="dsT_DI_BUSINESSTRIP_KORAIL">
	                            <param Name="Editable"          value="false">
								<param name=HiddenVScroll       value="true">
								<param name="Format"            value='
	                            	<C> id={currow}		    width=35	name=NO	        align=center </C>
	                            	<C> id=STR_CITY	        width=50    name=�ڵ�  	    align=center show=false </C>
	                                <C> id=STR_CITY_INS	    width=147   name=�����	    align=center </C>
	                                <C> id=END_CITY         width=50    name=�ڵ�       align=center show=false </C>
	                                <C> id=END_CITY_INS	    width=147   name=������	    align=center </C>
                                    <C> id=CNT              width=50    name=Ƚ��       align=center </C>

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
	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="400" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState">* �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
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