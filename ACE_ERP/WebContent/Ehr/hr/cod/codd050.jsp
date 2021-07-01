<!--
*****************************************************
* @source       : codd050.jsp
* @description : ���� �޼��� ��Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/02/18            �̵���            	�����ۼ�									
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>
<%@ page import="sales.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>


<html>
<head>
<title>���� �޼��� ��Ȳ</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>



<%	
		// ContextPath ���� ����.
		SmartRequest sr = new SmartRequest(request);
		String dirPath  = request.getContextPath(); //HDASan
		
		String ssID = session.getId().substring(0,40);
		try {
		
		//String ssID	= sr.getString("ssID");

%>




    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO_SHR  = gusrid;//���

            dsT_AA_MESSAGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.d.codd050.cmd.CODD050CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_AA_MESSAGE.reset();

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


        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {


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

        	// Grid Style ����
            cfStyleGrid_New(form1.grdT_AA_MESSAGE,0,"false","false")      

          	//�ڵ���ȸ
            fnc_SearchList();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        
        
		/********************************************
         * 16. Ȯ�� ó��    						*
         ********************************************/
        function fnc_Confirm() {

            if (confirm("��� �޼����� Ȯ��ó�� �Ͻðڽ��ϱ�?\n\nȮ�� ó���� �� �̻� ��ȸ���� �ʽ��ϴ�.") == false) return;
			

		    for(var i=1; i<=dsT_AA_MESSAGE.CountRow; i++) {				    
		    	dsT_AA_MESSAGE.UserStatus(i) = 1;
		    }	            
            
            trT_AA_MESSAGE.KeyValue = "tr01(I:dsT_AA_MESSAGE=dsT_AA_MESSAGE)";
            trT_AA_MESSAGE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.d.codd050.cmd.CODD050CMD&S_MODE=SAV&ENO_NO="+gusrid;
            trT_AA_MESSAGE.post();
            
        }
        
        
    </script>

    </head>



    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->


    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                            |
    | 2. �̸� : dsT_AA_MESSAGE                     |
    | 3. Table List : T_AA_MESSAGE                 |
    +----------------------------------------------->
    <Object ID="dsT_AA_MESSAGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)           |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>

    <Object ID="trT_AA_MESSAGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_AA_MESSAGE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>



    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_AA_MESSAGE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>



    <!-----------------------------------------------------+
    | Transaction Successful ó��                          |
    +------------------------------------------------------>
    <script for=trT_AA_MESSAGE event="OnSuccess()">
    
        alert("���������� ��� Ȯ�� ó�� �Ǿ����ϴ�.");


        
    	//window.opener.location.href = window.opener.location.href;  
		<%
		System.out.println("ssID -->" + ssID);
		%>
		
        window.close();	
		
        
        opener.document.FormPortal.submit();
        
        //opener.document.location.reload();
        
		//window.parent.location.href = "<%=dirPath%>/portal.jsp?ssID="+<%=ssID%>;

		//opener.document.location.reload();

		//session.getId().substring(0,40)
		
    	//window.close();
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- form ���� -->
<form name="form1">


<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="center" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    
					<td height="30" class="paddingTop5" align="right">
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','../../images/button/btn_ConfirmOver.gif',1)">  
			            <img src="../../images/button/btn_ConfirmOn.gif"     name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm();">
			            </a>
					</td>
                </tr>
            </table>
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
                        <object id="grdT_AA_MESSAGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:600px;">
                            <param name="DataID"                value="dsT_AA_MESSAGE">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    		width=50    name='NO'           	align=center    value={String(Currow)}</C>
                                <FC> id='MSG_TYPE' 			width=120   name='�޼�������'     	align=center </FC>
                                <FC> id='MSG_CONTENT'  		width=550   name='����'         	align=left   </FC>
                                <FC> id='IPT_YMD'    		width=150   name='��������'     	align=center </FC>
                                <FC> id='STATUS'    		width=110   name='���°�'     		align=center </FC>                                
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


<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>
