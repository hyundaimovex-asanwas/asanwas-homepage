<!--
*****************************************************
* @source       : vlui010.jsp
* @description  : ���ǥ�Է� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ǥ�Է�(vlui010)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
            var GRADE_STR = document.form1.cmbGRADE_STR.value;    		//�򰡱׷�

            //���� ��ȸ
            dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&GRADE="+GRADE_STR;
            dsT_EV_ABLRST.reset();

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
        function fnc_Save(s_mode) {

            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SAV";
            trT_EV_ABLRST.post();
        	fnc_SearchList();
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			if (dsT_EV_ABLRST.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {

				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
					dsT_EV_ABLRST.deleterow(dsT_EV_ABLRST.rowposition);
			        trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
			        trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=DEL";
			        trT_EV_ABLRST.post();
					fnc_SearchList();
				}
			}
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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("���ǥ�Է�", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			dsT_EV_ABLRST.AddRow();

			dsT_EV_ABLRST.nameValue(dsT_EV_ABLRST.RowPosition, "EVAYM") = document.form1.txtREG_YM_SHR.value.replace("-","");        //�ش�⵵
			dsT_EV_ABLRST.nameValue(dsT_EV_ABLRST.RowPosition, "GRPCD") = document.form1.cmbGRADE_STR.value;        				//�ش�⵵


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


        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
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

            if (!dsT_EV_ABLRST.IsUpdated) {
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

			document.getElementById("loctitle").innerText = "HOME/�λ���/�����/";

			document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

	        cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");      // Grid Style ����

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /********************************************
         * 16. ó�� ��ư Ŭ���� ������ ���ǥ�� �Է� *
         *******************************************/
		function fnc_Conduct(){

            var txtJPR_YM = document.form1.txtJPR_YM.text;

			if (txtJPR_YM.trim().length != 6) {
				alert("������ ���ǥ�� �������� �Է��Ͻʽÿ�.");
		    	document.getElementById("txtJPR_YM").focus();
				return ;
			}else{

	            //���� ��ȸ
	            dsT_EV_ABLRSTCHK.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SHR_01&JPR_YM="+txtJPR_YM;
	            dsT_EV_ABLRSTCHK.reset();

			}

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->
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

    <Object ID="dsT_EV_ABLRSTCHK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRSTLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
            <Param Name=KeyValue    Value="sample_tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)">
    </Object>

    <Object ID ="trT_EV_ABLRSTLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:dsT_EV_ABLRSTLIST=dsT_EV_ABLRSTLIST)">
    </Object>
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

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

    <Script For=dsT_EV_ABLRSTCHK Event="OnLoadCompleted(iCount)">
        if (iCount >= 1)    {
            alert("������ �������� ���ǥ�� �����մϴ�.");
        } else {
	        //���� ��ȸ
	        dsT_EV_ABLRSTLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=SHR_02";
	        dsT_EV_ABLRSTLIST.reset();
        }
    </Script>

    <Script For=dsT_EV_ABLRSTLIST Event="OnLoadCompleted(iCount)">
        if (iCount >= 1)    {

			if (confirm(document.form1.txtJPR_YM.text+ "���ǥ�� �����Ͻðڽ��ϱ�?")) {
				for(i=1;i<=iCount;i++){
						dsT_EV_ABLRSTLIST.namevalue(i,"EVAYM") =  document.form1.txtJPR_YM.text;
						dsT_EV_ABLRSTLIST.UserStatus(i)=1; //insert
				}
			        	trT_EV_ABLRSTLIST.KeyValue = "tr01(I:dsT_EV_ABLRSTLIST=dsT_EV_ABLRSTLIST)";
						trT_EV_ABLRSTLIST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui010.cmd.VLUI010CMD&S_MODE=CRT";
						trT_EV_ABLRSTLIST.post();
						alert("��û�Ͻ� �۾��� �Ϸ��Ͽ����ϴ�.")
			}

        } else {
			alert("������ ������� ���ǥ�� �������� �ʾƼ�  ���ǥ�� �ϰ������� ������ �� �����ϴ�.");
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
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ǥ�Է�</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���ǥ�Է�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('SAV_02')"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="60"></col>
                                <col width="60"></col>
                                <col width="60"></col>
                                <col width=""></col>
                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <select id="cmbGRADE_STR">
                                        <option value="1">�븮����</option>
                                        <option value="2">�����̻�</option>
                                        <option value="4">�μ���</option>
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
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:420px;">
                            <param name="DataID"                	value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                	value="true">
                            <param name="DragDropEnable"        	value="true">
                            <param name="SortView"                	value="Left">
                            <param name="VIEWSUMMARY"            	value=0>
                            <param name="Format"                	value="
                                <C> id='EVAYM'       	width=60    name='������'     align=left   Edit=None show=false</C>
                                <C> id='DIVCD'        	width=60    name='�ι�'         align=left   Edit=None value={IF (DIVCD='1','�ɷ�',IF (DIVCD='2','����' , IF (DIVCD='3','�µ�' '')))}</C>
                                <C> id='JOBGRPH'        width=50    name='����'         align=left   Edit=None show=false</C>
                                <C> id='GRPITEM'        width=70    name='�׸񱸺�'     align=left   Edit=None value={IF (GRPITEM='1','�µ�',IF (GRPITEM='2','�ɷ�' , IF (GRPITEM='3','����',GRPITEM)))}</C>
                                <C> id='PRTSEQ'         width=30    name='����',        align=center Edit=none</C>
                                <C> id='ASKITEM'        width=150   name='�򰡿��'     align=left 	 Edit=none</C>
                                <C> id='ESCR'           width=40    name='Ź��'        	align=center Dec=2</C>
                                <C> id='GSCR'           width=40    name='���'         align=center Dec=2</C>
                                <C> id='MSCR'       	width=40    name='����'       	align=center Dec=2</C>
                                <C> id='LSCR'        	width=40    name='����' 		align=center Dec=2</C>
                                <C> id='PSCR'        	width=40    name='����'       	align=center Dec=2</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

		  		<td >
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=3
					style='width:243px;height:422px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;�ϰ�����</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=txtJPR_YM  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style=" position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; ">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object>
							</comment><script> __ShowEmbedObject(__NSID__);</script>
                        	<nobr>&nbsp;</nobr>
	            		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct()"></a>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" class="creamBold"><nobr>&nbsp;������</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gcem_yymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; " >
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
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;&nbsp;&nbsp;����</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gclx_grpcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
										<param name="CBData" 			value="1^�븮����,2^�����̻�,3^������,4^�μ�" />
										<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
										<param name="Index" 			value="0" />
										<param name="SearchColumn" 		value="COM_SNAME" />
										<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
										<param name="BindColumn" 		value="COM_CODE" />
										<param name="Enable" 			value="true" />
								</object>
							</comment><script>__ShowEmbedObject(__NSID__);</script>		&nbsp;</nobr>
							</td>
						</tr>
						<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;&nbsp;&nbsp;�ι�</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
								<comment id="__NSID__">
								<object id=gclx_divcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
											<param name="CBData" 			value="1^�ɷ�,2^����,3^�µ�" />
											<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
											<param name="Index" 			value="0" />
											<param name="SearchColumn" 		value="COM_SNAME" />
											<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
											<param name="BindColumn" 		value="COM_CODE" />
											<param name="Enable" 			value="true" />
								</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>	&nbsp;</nobr>
								</td>
							</tr>
							<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold"><nobr>&nbsp;&nbsp;&nbsp;����</nobr></td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
										<comment id="__NSID__">
										<object id=gclx_jobgrphcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
										<param name="CBData" 			value="00^����,10^�繫��,20^������,30^�����,40^��Ÿ" />
										<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
										<param name="Index" 			value="0" />
										<param name="SearchColumn" 		value="COM_SNAME" />
										<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
										<param name="BindColumn" 		value="COM_CODE" />
										<param name="Enable" 			value="true" />
									</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;�׸񱸺�</td>
									<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
										<comment id="__NSID__">
										<object id=gclx_grpitemcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=120>
										<param name="CBData" 			value="1^�µ�,2^�ɷ�,3^����" />
										<param name="CBDataColumns" 	value="COM_CODE,COM_SNAME" />
										<param name="Index" 			value="0" />
										<param name="SearchColumn" 		value="COM_SNAME" />
										<param name="ListExprFormat" 	value="COM_SNAME^0^70" />
										<param name="BindColumn" 		value="COM_CODE" />
										<param name="Enable" 			value="true" />
										</object>
										</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;����</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_prtseq   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:20px; height:18px; font-family:����;font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=ClipMode	      value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="">
										<param name=MaxLength     value=2>
										<param name=InheritColor  value=false>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;�򰡿��</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_askitem" name="txt_askitem" type="text"  class="txt21" style="position:relative; left:-5px;width:150px;" maxlength=34 >&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;Ź��</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_escr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:����;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;���</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_gscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:����;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;����</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_mscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:����;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="creamBold">&nbsp;&nbsp;&nbsp;����</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_lscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:����;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"  class="creamBold">&nbsp;&nbsp;&nbsp;����</td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gcem_pscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:����;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object>
									</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_EV_ABLRST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_ABLRST">
	<Param Name="BindInfo", Value='
    	<C>Col=EVAYM           	Ctrl=gcem_yymm2        		Param=text</C>
    	<C>Col=GRPCD          	Ctrl=gclx_grpcd2           	Param=BindColVal</C>
		<C>Col=DIVCD           	Ctrl=gclx_divcd            	Param=BindColVal</C>
		<C>Col=JOBGRPH       	Ctrl=gclx_jobgrphcd      	Param=BindColVal</C>
		<C>Col=PRTSEQ         	Ctrl=gcem_prtseq         	Param=text</C>
		<C>Col=GRPITEM       	Ctrl=gclx_grpitemcd      	Param=BindColVal</C>
		<C>Col=ASKITEM       	Ctrl=txt_askitem           	Param=value</C>
		<C>Col=ESCR            	Ctrl=gcem_escr          	Param=text</C>
		<C>Col=GSCR            	Ctrl=gcem_gscr          	Param=text</C>
		<C>Col=MSCR            	Ctrl=gcem_mscr         		Param=text</C>
		<C>Col=LSCR             Ctrl=gcem_lscr          	Param=text</C>
		<C>Col=PSCR             Ctrl=gcem_pscr         		Param=text</C>
    '>
</object>
