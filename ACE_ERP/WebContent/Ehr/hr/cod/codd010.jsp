<!--
*****************************************************
* @source       : codd010.jsp
* @description : ���հ�����Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/04/28            �̵���            	ERP �̻�									
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�̰�����Ȳ</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO_SHR  = gusrid;//���
            var APP_GBN_SHR = document.getElementById("cmbAPP_GBN_SHR").value;//���籸��


            dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.d.codd010.cmd.CODD010CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&APP_GBN_SHR="+APP_GBN_SHR;
            dsT_DI_APPROVAL.reset();

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

            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_APPROVAL.GridToExcel("���հ�����Ȳ", '', 225);

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

            document.getElementById("cmbAPP_GBN_SHR").value = "";//���籸��
            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_APPROVAL.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        	window.close();
	        	
	        	opener.document.movForm.submit();
	        	//window.opener.location.href = window.opener.location.href;
	

	        	
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

            if (!dsT_DI_APPROVAL.IsUpdated) {
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


            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����

            document.getElementById("cmbAPP_GBN_SHR").value = "%";//���籸��

            fnc_SearchList();//�ڵ���ȸ

            if(sso_flag == ""){
	            if(dsT_DI_APPROVAL.countrow > 0){
	                alert(dsT_DI_APPROVAL.countrow+"���� �̰��系���� �����մϴ�.");
	            }
            }


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
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!------------------------------------+
    | 1. Logout�� DataSet                  |
    | 2. �̸� : dsT_CM_EMPLIST            |
    | 3. Table List :T_CM_EMPLIST         |
    +------------------------------------->
    <Object ID="ds_LOGOUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <Script For=ds_LOGOUT Event="OnLoadCompleted(iCount)">

        var frame = window.external.GetFrame(window);
        frame.outerWindow.do_logout();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=ds_LOGOUT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">

    var param = new String();

    if(row < 1) {

        return;

    } else {

        cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

        //���ϱ���, ���º���, �Ϳ�����
        if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "0" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "1" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "2"){
            
        	window.showModalDialog("../../hr/gun/guna071.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:900px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //����������        	
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "3"){
                
            	window.showModalDialog("../../hr/gun/guna072.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:1100px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //��������
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "9"){
	
			var url = "../../hr/but/buta027.jsp?ORD_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&PENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
			window.showModalDialog(url, "Modal", "dialogWidth:900px; dialogHeight:760px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        //�������
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "10"){
        	
            var url = "../../hr/aid/aida011.jsp?REQ_NO="+dsT_DI_APPROVAL.NameString(row, "REQ_NO")+"&TYPE=TYPE4";
			window.showModalDialog(url, "Modal", "dialogWidth:1050px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        //������û
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "11"){
        	
			window.showModalDialog("../../hr/edu/edue041.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:770px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

	    //OJT
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "14"){

      		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
        	window.showModalDialog("../../hr/edu/edug033.jsp", param, "dialogWidth:860px; dialogHeight:700px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");			
			
        //��������
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "15"){

      		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
        	window.showModalDialog("../../hr/cdp/book011.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //�Ͽ����빫��
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "16"){

      		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
        	window.showModalDialog("../../hr/ada/aday051.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        
        //����ٹ�_����
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "17"){

      		var url = "../../hr/gun/gune015.jsp?REQ_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
        	window.showModalDialog(url, param, "dialogWidth:1100px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        
        //����ٹ�_�����(��/�����/��õ/��������)
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "18"){

      		var url = "../../hr/gun/gunf085.jsp?REQ_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
        	window.showModalDialog(url, param, "dialogWidth:1100px; dialogHeight:850px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        //����ٹ�_�����(��/�����/��õ/��������)
        }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "19"){

      		var url = "../../hr/gun/gunf086.jsp?REQ_NO=" + dsT_DI_APPROVAL.NameValue(row,"REQ_NO")+ "&ENO_NO=" + dsT_DI_APPROVAL.NameValue(row,"PENO_NO") + "&APP_STATUS=" + dsT_DI_APPROVAL.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_APPROVAL.NameValue(row,"APP_CMT");
        	window.showModalDialog(url, param, "dialogWidth:1100px; dialogHeight:550px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

                	
        	
        }

        
        
        
		fnc_SearchList();
    }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="120"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">���籸��&nbsp;</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_GBN_SHR" style="width:100" onChange="fnc_SearchList();">
			                            <option value="%" >��ü</option>                            
			                        </select>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
        <td align="center" width="45%" valign="bottom">
            <b>�� ����Ŭ���� �Ͻø� �ش� ������Ȳ���� �̵��մϴ�. </b>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td style="padding-top:2px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
                            <param name="DataID"                value="dsT_DI_APPROVAL">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    		width=50    name='NO'           	align=center    value={String(Currow)}</C>
                                <FC> id='APP_GBN_NM' 		width=150   name='���籸��'     	align=center </FC>
                                <FC> id='APP_TITLE'  		width=550   name='����'         	align=left   	  </FC>
                                <FC> id='APP_YMD'    		width=110   name='�������'     	align=center </FC>
                                <C> id='PENO_NM'    		width=100    name='�����'       	align=center  </C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

