<!--
***********************************************************************
* @source      : act_approver.jsp
* @description : Action Plan Ȯ����������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2019/03/15     �̵���        �����ۼ�
*----------------------------------------------------------------------
*
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%
    String dpt_cd     = request.getParameter("DPT_CD");
    String eno_no     = request.getParameter("ENO_NO");
%>

<html>

    <head>
    <title>Ȯ����������ȸ(act_approver)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/result.js"></script>	    
    <script language=javascript src="../../common/common.js"></script>
    <script language="javascript" src="../../common/calendar/calendar.js"></script>
    
    <base target="_self">
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var paramDataSet  = window.dialogArguments;

        var paramDataSet1 = window.dialogArguments;


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR01"
											                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_PERSON.reset();

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

            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style ����

            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����
 
            //�����ͼ� ����
            dsT_CM_DEPT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR_DPT"
						                                 										+ "&ENO_NO="+"<%=eno_no%>";
			dsT_CM_DEPT.reset();            

            var eno_no  = dsT_CM_DEPT.NameValue(1,"ENO_NO");
            var dpt_cd  = dsT_CM_DEPT.NameValue(1,"DPT_CD");


            //�Ѿ�� ����� ������ �����ϰ�
            document.getElementById("txtENO_NO").value      = eno_no;


            //�Ѿ�� ������� ������� �˻�
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO");
            
            if(dsT_CM_DEPT.NameValue(1,"ENO_NO") == "") {
            	
                alert("��û�� ������ �����ϴ�.");
                
                window.close();
                
                return;
                
            }

            //�˻�����(�Ҽ�)����
            if(dpt_cd != "") {
            	
                document.getElementById("txtDPT_CD_SHR").value  = dpt_cd;

                fnc_GetCommNm('A4', "txtDPT_CD_SHR", "txtDPT_NM_SHR");
                
            } else {
            	
                document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
                document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
                
            }

            //��û�� ���� �߰�
            document.getElementById("lblJOB_NM_A2").innerText   = dsT_CM_DEPT.NameValue(1,"JOB_NM");
            document.getElementById("lblENO_NO_A2").innerText   = dsT_CM_DEPT.NameValue(1,"ENO_NO");
            document.getElementById("lblENO_NM_A2").innerText   = dsT_CM_DEPT.NameValue(1,"ENO_NM");

            //��û�� ���� ����
            document.getElementById("txtENO_NO").value      = enoObj.eno_no;
            document.getElementById("txtENO_NM").value      = enoObj.eno_nm;
            document.getElementById("txtDPT_CD").value      = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM").value      = enoObj.dpt_nm;
            document.getElementById("txtJOB_CD").value      = enoObj.job_cd;
            document.getElementById("txtJOB_NM").value      = enoObj.job_nm;
            document.getElementById("txtHEAD_TAG").value    = enoObj.head_tag;

            cfCopyDataSet(paramDataSet, dsT_ACT_APPROVAL);
            
            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR"
						                                 + "&ENO_NO="+"<%=eno_no%>"
						                                 + "&RET_CD=1"					                                 
						                                 + "&DPT_CD="+dsT_CM_DEPT.NameValue(1,"DPT_CD");
            dsT_CM_PERSON.reset();

            // �μ��ڵ� �ڵ鸵�Ҽ��ְ�
			document.getElementById("txtDPT_CD_SHR").value = "";
			document.getElementById("txtDPT_NM_SHR").value = "";

        }

        /**
         * Ȯ���ڸ� ������ �� Ȯ���� ������ Ȯ���������� �Ѿ
         * (Ȯ���ڰ� ������ ��û�ڰ� Ȯ���ڷ� �Ѿ)
         */
        function fnc_Confirm() {

        	// ���� ���� Check

            cfCopyDataSet(dsT_ACT_APPROVAL, paramDataSet1);
            
            window.close();

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
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_ACT_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>



    <Script For=dsT_ACT_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>



    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>



    <Script For=dsT_ACT_APPROVAL Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>



    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    

    <Script For=dsT_ACT_APPROVAL Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var i = 0;

		var dutyCd = document.getElementById("txtDUTY_CD").value;
		var dutyNm = document.getElementById("txtDUTY_NM").value;

		if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == "<%=eno_no%>"){
			alert("����� ������ Ȯ���ڰ� �ɼ� �����ϴ�");
			return false;
		}

		var headTag =  document.getElementById("txtHEAD_TAG").value;

        //�ߺ����üũ
        for(i=1; i<=dsT_ACT_APPROVAL.countRow; i++){
        	
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_ACT_APPROVAL.NameValue(i,'ENO_NO')){
            	
                alert("�ش� Ȯ���ڴ� �̹� Ȯ�ζ��ο� ���ԵǾ� �ֽ��ϴ�.");
                
                return false;
                
            }
            
        }
        
        dsT_ACT_APPROVAL.InsertRow(1);//���������� �ֱ� ���� insert
        
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"ENO_NM") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"SEQ_NO") = dsT_ACT_APPROVAL.CountRow;
        
    </script>




    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var i = 0;

		if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == "<%=eno_no%>"){
			alert("����� ������ Ȯ���ڰ� �ɼ� �����ϴ�");
			return false;
		}


		// �μ��常 �����忡�� ��ó�˼� �ִ�
		var dutyCd = document.getElementById("txtDUTY_CD").value;
		var dutyNm = document.getElementById("txtDUTY_NM").value;
		var headTag =  document.getElementById("txtHEAD_TAG").value;

		
        //�ߺ����üũ
        for(i=1; i<=dsT_ACT_APPROVAL.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_ACT_APPROVAL.NameValue(i,'ENO_NO')){
                alert("�ش� Ȯ���ڴ� �̹� Ȯ�ζ��ο� ���ԵǾ� �ֽ��ϴ�.");
                return false;
            }
        }

        
        dsT_ACT_APPROVAL.InsertRow(1);//���������� �ֱ� ���� insert

        
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"ENO_NM") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"SEQ_NO") = dsT_ACT_APPROVAL.CountRow;
        
    </script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event=OnDblClick(row,colid)>

        var j = 0;
        var i = 0;

        // ����ڴ� ���� ���Ѵ�.
		/*
        if(dsT_ACT_APPROVAL.CountRow == row){
            alert("��û�ڴ� Ȯ�ζ��ο��� ������ �� �����ϴ�.");
            return;
        }
		*/
        dsT_ACT_APPROVAL.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_ACT_APPROVAL.CountRow-1; i>=1; i--){
        	
            j++;
            
            dsT_ACT_APPROVAL.NameValue(i,"SEQ_NO") = j;
            
        }

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event=OnReturn(row,colid)>

        var j = 0;
        var i = 0;

        // ����ڴ� ���� ���Ѵ�.
        if(dsT_ACT_APPROVAL.CountRow == row){
            alert("��û�ڴ� Ȯ�ζ��ο��� ������ �� �����ϴ�.");
            return;
        }

        dsT_ACT_APPROVAL.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_ACT_APPROVAL.CountRow-1; i>=1; i--){
            j++;
            dsT_ACT_APPROVAL.NameValue(i,"SEQ_NO") = j;
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">Ȯ����������ȸ</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">��� ��ȣ/����&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">

                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">

                                        <input type="hidden" id="txtENO_NO">
                                        <input type="hidden" id="txtENO_NM">
                                        <input type="hidden" id="txtDPT_CD">
                                        <input type="hidden" id="txtDPT_NM">
                                        <input type="hidden" id="txtJOB_CD">
                                        <input type="hidden" id="txtJOB_NM">

                                        <input type="hidden" id="txtDUTY_CD">
                                        <input type="hidden" id="txtDUTY_NM">
                                        <input type="hidden" id="txtHEAD_TAG">

                                    </td>

                                    <td align="center" class="searchState">�Ҽ�&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="../../images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:157px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           	width=100  	name=����   align=left   </C>
                                    <C> id=DPT_NM            	width=110   name=�Ҽ�   align=left   </C>
                                    <C> id=JOB_NM            	width=60   	name=����   align=left   </C>
                                    <C> id=ENO_NM            	width=70   	name=����   align=center </C>
                                    <C> id=DUTY_NM            width=80   	name=��å   align=center </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><font color = "blue">�� �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>Ȯ�ζ���</strong>
	        </td>
	    </tr>
	    <tr>
	        <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:157px;">
                                <param name="DataID"            value="dsT_ACT_APPROVAL">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    	value="true">
                                <param name="Format"            value='
                                    <C> id=SEQ_NO          		width=39    	name=NO     align=center   </C>
                                    <C> id=DPT_NM            	width=110   	name=�Ҽ�   align=left     </C>
                                    <C> id=JOB_NM            	width=110    	name=����   align=center   </C>
                                    <C> id=ENO_NM           	width=120   	name=����   align=center   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><font color = "blue">�� �ش��׸��� ����Ŭ�� �Ͻø� �����˴ϴ�.</font></span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="blueBold">��û��</td>
                        <td align="center" class="blueBold">����</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="blueBold">���</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="blueBold">����</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','../../images/button/btn_ConfirmOver.gif',1)"><img src="../../images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    </form>
    <!-- form �� -->

</body>
</html>