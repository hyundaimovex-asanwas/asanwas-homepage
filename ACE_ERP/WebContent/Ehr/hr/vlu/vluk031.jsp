<!--
*****************************************************
* @source       : vluk031.jsp
* @description  : �����ڼ��� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/10/10     �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�����ڼ���</title>
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

		var today = gcurdate;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var REG_YM_SHR = document.form1.txtREG_YM_SHR.text;        //�ش�⵵

            //if (document.form1.rdoGBN_SHR[0].checked) {
	            //���� ��ȸ - ������,����� - �Ϲ�
	        	dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR;
	        	dsT_EV_ABLRST.reset();
	        /*
            }else{
	            //���� ��ȸ - �μ���
	            dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR; //+"&GUBUN="+GUBUN;
	            dsT_EV_ABLRST.reset();
			}*/


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

			document.form1.txtREG_YM_SHR.text = gcurdate.substring(0,7);
			document.form1.txtREG_YMD_SHR.text = gcurdate;
			document.form1.txtHIR_YMD_SHR.text = gcurdate;

	        cfStyleGrid_New(form1.grdT_EV_ABLRST,15,"false","true");      // Grid Style ����

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {


        }


        /********************
         * 16. �������� ��� *
         *******************/
        function fnc_Append() {

          var REG_YM_SHR = document.form1.txtREG_YM_SHR.text;        //�ش�⵵

          var GUBUN 	= "";

          //if(document.form1.rdoGBN_SHR[0].checked){
          //      GUBUN = "1";//�Ϲ�
          //}else if(document.form1.rdoGBN_SHR[1].checked){
          //      GUBUN = "2";//�μ���
          //}

            //if (document.form1.rdoGBN_SHR[0].checked) {
	            //���� ��ȸ - ������,����� - �Ϲ�
	        	dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR;
	        	dsT_EV_ABLRST.reset();
	       /*
            }else{
	            //���� ��ȸ - �μ���
	            dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR;
	            dsT_EV_ABLRST.reset();
			}*/
			

			if (dsT_EV_ABLRST.countrow>0) {

				//if (document.form1.rdoGBN_SHR[0].checked) {
					if (confirm( "������� ������� �Ϲ� �ǰ���ڰ� �����մϴ�. ����� �ǰ���ڸ� ���� �� �ٽ� �����ϰڽ��ϱ�?")) {
						//����� �ǰ���� ����
			      		dsT_EV_ABLRST.DeleteAll();
			            trT_EV_ABLRST.KeyValue = "tr(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=DEL_01&REG_YM_SHR="+REG_YM_SHR;
			            trT_EV_ABLRST.post();
						//�ǰ���� ����
			       		fnc_Create();
					}
				/*
				}else{

					if (confirm( "������� ������� �μ��� �ǰ���ڰ� �����մϴ�. ����� �ǰ���ڸ� ���� �� �ٽ� �����ϰڽ��ϱ�?")) {
						//����� �ǰ���� ����
			      		dsT_EV_ABLRST.DeleteAll();
			            trT_EV_ABLRST.KeyValue = "tr(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=DEL_02&REG_YM_SHR="+REG_YM_SHR;
			            trT_EV_ABLRST.post();
						//�ǰ���� ����
			       		fnc_Create();
			       	}
				}*/

			}else{

				//if(GUBUN == '1'){
					//�Ϲ� �ǰ���� �űԻ���
					if (confirm("�ǰ���ڸ� ���� �Ͻðڽ��ϱ�?")){
						fnc_Create();
					}
				//}else{
				//	if (confirm("�μ��� �ǰ���ڸ� ���� �Ͻðڽ��ϱ�?")){
				//		fnc_Create();
				//	}
				//}
			}

        }

		function fnc_Create(){

            var REG_YM_SHR = document.form1.txtREG_YM_SHR.text;        //�ش�⵵

            //if (document.form1.rdoGBN_SHR[0].checked) {
	            //���� ��ȸ - ������,����� - �Ϲ�
				dsT_EV_ABLRST.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SHR_12&REG_YM_SHR="+REG_YM_SHR;
				dsT_EV_ABLRST.Reset();
			/*
            }else{
	            //���� ��ȸ - �μ���
	            dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SHR_13&REG_YM_SHR="+REG_YM_SHR;
	            dsT_EV_ABLRST.reset();
			}*/

			fnc_Confirm();

		}


		function fnc_Confirm(){

            //if (document.form1.rdoGBN_SHR[0].checked) {

				if (confirm("�Ϲ� ����ڸ� ��ȸ�Ͽ����ϴ�. �����Ͻðڽ��ϱ�?")) {

					for(i=1;i<=dsT_EV_ABLRST.countrow;i++){
						dsT_EV_ABLRST.UserStatus(i) = 1;
					}
			            trT_EV_ABLRST.KeyValue = "tr(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SAV_01";
			            trT_EV_ABLRST.post();
				}
			/*	
            }else{
				if (confirm("�μ��� ����ڸ� ��ȸ�Ͽ����ϴ�. �����Ͻðڽ��ϱ�?")) {

					for(i=1;i<=dsT_EV_ABLRST.countrow;i++){
						dsT_EV_ABLRST.UserStatus(i) = 1;
					}
			            trT_EV_ABLRST.KeyValue = "tr(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk030.cmd.VLUK030CMD&S_MODE=SAV_02";
			            trT_EV_ABLRST.post();
				}
			}*/
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)                       |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ABLRST)        |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_PERSON Event="OnLoadCompleted(iCount)">
		//fnc_Data_Create(iCount);
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PERSON Event="OnLoadError()">
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        //fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
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
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�ǰ���� �������</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','../../images/button/btn_CreateOver.gif',1)"><img src="../../images/button/btn_CreateOn.gif"   name="imgCreate"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:320px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <C> id='ENO_NO'     width=80   	name='���'    		align=center    edit=none </C>
                                    <C> id='DEPTNM'    	width=180   name='�Ҽ�'   		align=left    	edit=none </C>
                                    <C> id='GRDNM'    	width=90   	name='����'   		align=left    	edit=none </C>
                                    <C> id='ENO_NM'   	width=80  	name='����'  		align=left      edit=none </C>
                                    <C> id='WRDT'       width=80   	name='�������' 		align=center    edit=none mask='XXXX-XX'</C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        	</td>
					  		<td valign="top">
							<table border= "0" cellpadding=0 cellspacing=0  border=3 style='width:200px;height:160px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="blueBold"><nobr>&nbsp;��������</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
			                           <fieldset style="width:180px;border:0;">
			                           <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;">�Ϲ�
			                           <!--   <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;">�μ��� -->
			                           </fieldset>
			                        </td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="blueBold"><nobr>&nbsp;������</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=txtREG_YM_SHR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="YYYY/MM">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="blueBold"><nobr>&nbsp;���������</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=txtREG_YMD_SHR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="blueBold"><nobr>&nbsp;���</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=txtENO_NOFR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:53px; height:20px; font-family:����; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="0000000">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;&nbsp;~
									<comment id="__NSID__">
									<object id=txtENO_NOTO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:53px; height:20px; font-family:����; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="0000000">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="blueBold">&nbsp;�Ի�����</td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=txtHIR_YMD_SHR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt; " >
												<param name=Text          value="">
												<param name=Alignment	    value=0>
												<param name=Border	      value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;����</nobr>
									</td>
								</tr>
							</table>
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


