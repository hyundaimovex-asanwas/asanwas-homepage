<!--
*****************************************************
* @source       : sagb090.jsp
* @description : ö�ߴ��������ó�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/30      ���뼺        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>ö�ߴ��������ó��(sagb090)</title>
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
		var btnList = 'TFFTFFFT';

        var today  = getToday();
        
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			//�˻�����(����)
			var pis_ym = document.getElementById("txtPIS_YM_SHR").value;

            if(!fnc_SearchItemCheck()) return;
            
            //��ȸ �ش����� �����Ѵ�.
            document.getElementById("hidTAG_YM").value = pis_ym;

			dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb090.cmd.SAGB090CMD"
                                   + "&S_MODE=SHR"
                                   + "&PIS_YM="+pis_ym
                                   + "&SAGB=090";
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

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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
            document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtPIS_YM_SHR").focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
				if (dsT_DI_APPROVAL.IsUpdated)  {
					if (!fnc_ExitQuestion()) return;
				}
	
				frame = window.external.GetFrame(window);
				frame.CloseFrame();

            }else{
                window.close();
            }

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_ym = document.getElementById("txtPIS_YM_SHR");

            if(pis_ym.value == ""){
                alert("�ش����� �Է��ϼ���!");
                pis_ym.focus();
                return false;
            }
            return true;
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

            fnc_HiddenElement("imgSelectapproval");
            fnc_HiddenElement("imgReport");
            fnc_HiddenElement("imgApproval");
            fnc_HiddenElement("imgRejection");

			cfStyleGrid(form1.grdT_DI_APPROVAL,0,"true","false")      // Grid Style ����
            
            //CHECK_DATE!!!
            //â�� ������ ���糯¥�� ���� 15�� �����̸� �������� ������ �´�.
            var todayList   = getTodayArray();
            var hol_ymd     = getToday();
            if(fnc_covNumber(todayList[2]) > 15)
                hol_ymd     = addDate("M", getToday(), 1);
            document.getElementById("txtPIS_YM_SHR").value = hol_ymd.substr(0, 7); // �ش���

            fnc_SearchList();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * ó�� ��ư
         */
		function fnc_Append(app_yn) {
            
            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("ó���� �ڷᰡ �����ϴ�!");
                document.getElementById("resultMessage").innerText = "* ó���� �ڷᰡ �����ϴ�!";
                return;
            }
            
            var text = "[�Ҽ�:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                     + "�����:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PENO_NM")+"] "
                     + "�� �ڷḦ "+(app_yn == "Y" ? "����" : "�ΰ�")+" �Ͻðڽ��ϱ�?";
            
            if (!confirm(text)) return;
            
            
            //�������� ����
            dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "APP_TAG") = app_yn;
            
            trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb090.cmd.SAGB090CMD&S_MODE=SAV";
            trT_DI_APPROVAL.post();
		}
        
        /**
         * ���ó��
         */
        function fnc_Conduct() {
            var isChk = false;
            
            for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
                if(dsT_DI_APPROVAL.NameString(i, "CHECKED") == "T") {
                    isChk = true;
                    
                    //üũ�� �Ǿ� �ִµ� �μ����� ���õǾ� ���� ������ ����
                    if(dsT_DI_APPROVAL.NameString(i, "ENO_NM3") == "") {
                        alert("�����ڸ� ������ �ּ���.");
                        return false;
                    }
                }
            }
            
            if (dsT_DI_APPROVAL.CountRow < 1
                    || !dsT_DI_APPROVAL.IsUpdated
                    || !isChk) {
                alert("ó���� �ڷᰡ �����ϴ�!");
                document.getElementById("resultMessage").innerText = "* ó���� �ڷᰡ �����ϴ�!";
                return;
            }
            
        
            if(!confirm("������ ���ǵ��� ���ó�� �մϴ�.\n����Ͻðڽ��ϱ�?")) {
                return;
            }
            for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++)
                if(dsT_DI_APPROVAL.NameString(i, "CHECKED") == "T")
                    dsT_DI_APPROVAL.NameString(i, "APP_TAG") = "Y";
            
            
            trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb090.cmd.SAGB090CMD&S_MODE=SAV";
            trT_DI_APPROVAL.post();
        }

		
		/**
         * ���缱 ����
         */
		function fnc_Approval(){

            //��ȯ�� dataSet ����
            if (dataSet.CountColumn == 0)
                dataSet.setDataHeader("JOB_CD:STRING, JOB_NM:STRING, ENO_NO:STRING, ENO_NM:STRING");
            dataSet.ClearData();

            //������ ���� ��ȸ
            window.showModalDialog("../gun/gunc022.jsp", dataSet, "dialogWidth:500px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            
            
            //������ ������ ������ ����
            if(dataSet.CountRow != 2)
                return;
            
            //����Ʈ ��ü���� üũ�� �༮�鸸 ������ ������ �ֱ�
            for(i=1; i<=dsT_DI_APPROVAL.countrow; i++){
                if( dsT_DI_APPROVAL.NameValue(i, "CHECKED") == "T") {
                    dsT_DI_APPROVAL.NameValue(i, "ENO_NM3") =  dataSet.NameString(1, "JOB_NM")+" "+dataSet.NameString(1, "ENO_NM");
                    dsT_DI_APPROVAL.NameValue(i, "JOB_CD3") =  dataSet.NameString(1, "JOB_CD");
                    dsT_DI_APPROVAL.NameValue(i, "ENO_NO3") =  dataSet.NameString(1, "ENO_NO");
                    
                    dsT_DI_APPROVAL.NameValue(i, "ENO_NM4") =  dataSet.NameString(2, "JOB_NM")+" "+dataSet.NameString(2, "ENO_NM");
                    dsT_DI_APPROVAL.NameValue(i, "JOB_CD4") =  dataSet.NameString(2, "JOB_CD");
                    dsT_DI_APPROVAL.NameValue(i, "ENO_NO4") =  dataSet.NameString(2, "ENO_NO");
                    
                    dsT_DI_APPROVAL.NameValue(i, "APP_TAG") =  "Y";
                }
            }

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
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dataSet" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_APPROVAL)		   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>



    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_DI_APPROVAL event=OnRowPosChanged(row)>
        fnc_HiddenElement("imgSelectapproval");
        fnc_HiddenElement("imgReport");
        fnc_HiddenElement("imgApproval");
        fnc_HiddenElement("imgRejection");
        
        var today   = fnc_covNumber(getToday());

        //CHECK_DATE!!!
        var tag_ymd = document.getElementById("hidTAG_YM").value+"01";
        
        //����Ⱓ
        var appFrom = fnc_covNumber(tag_ymd.substr(0, 6)+"11");
        var appTo   = fnc_covNumber(tag_ymd.substr(0, 6)+"15");
        
        if(row > 0) {
            var pseq_no = dsT_DI_APPROVAL.NameString(row, "PSEQ_NO");
            var papp_yn = dsT_DI_APPROVAL.NameString(row, "PAPP_YN");
            
            //������ ����Ⱓ�̸�
            /*
            test test test
            if(appFrom <= today
                    && today <= appTo) {
            */
                //�ΰ��̰ų�, ����϶�, �ڱ� �ڽ��� �ƴҶ�
                if(papp_yn == "R"
                        && pseq_no != "0") {
            
                    // �������� ���
                    if (pseq_no == "1") {
                        fnc_ShowElement("imgApproval");
                    } 
                    // �����������ΰ�� 
                    else if (pseq_no == "2") {
                        fnc_ShowElement("imgSelectapproval");
                        fnc_ShowElement("imgReport");                        
                    }
                    
                    fnc_ShowElement("imgRejection");
                }
            /*
            test test test
            }
            */
        }
    </script>

    <!-----------------------------------------------------+
    | Grid Head Check event ó��                                   |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_DI_APPROVAL event=OnHeadCheckClick(Col,Colid,bCheck)>
    
        if(Colid == "CHECKED" && dsT_DI_APPROVAL.CountRow > 0) {
            for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {
                if(dsT_DI_APPROVAL.NameString(i, "CHECKED") == "F") {
                    dsT_DI_APPROVAL.NameString(i, "CHECKED") = "T";
                } else if(dsT_DI_APPROVAL.NameString(i, "CHECKED") == "T") {
                    dsT_DI_APPROVAL.NameString(i, "CHECKED") = "F";
                }
            }
        }
        
    </script>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">

		if(row < 1) {
			return;
		} else {
            
            //������ ����
            var param = new String();
            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");
            param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");
            param.seq_no    = dsT_DI_APPROVAL.NameValue(row, "PSEQ_NO");
            param.grp_no    = dsT_DI_APPROVAL.NameValue(row, "GRP_NO");
            param.sagb      = "090";

			window.showModalDialog("/hr/sag/sagb091.jsp", param, "dialogWidth:860px; dialogHeight:460px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_SearchList();
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ö�ߴ��������ó��</td>
					<td align="right" class="navigator">HOME/���°���/ö�ߴ���/<font color="#000000">ö�ߴ��������ó��</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
	   <td height="35" class="paddingTop5">
	       &nbsp;&nbsp;&nbsp;&nbsp;�ػ󼼳����� ���Ͻø� �ش� ö�ߴ��������� ����Ŭ�� �ϼ���.
	   </td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">�ش���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YM','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','5','105');"><img src="/images/button/btn_HelpOn.gif" name="img_YM" width="21" height="20" border="0" align="absmiddle"></a>
                                    <input type="hidden" id="hidTAG_YM">
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
                    <td align="right">
						<img src="/images/button/btn_SelectapprovalOn.gif" name="imgSelectapproval" width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
			            <img src="/images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                        <img src="/images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                        <img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='{currow}'		width=24	name='NO'			align=center	value={String(Currow)}						</C>
								<C> id='GUN_YMD'		width=55	name='�ش���'	    align=center     Edit=none</C>
                                <C> id='PDPT_NM'		width=100	name='�Ҽ�'		    align=center    Edit=none </C>
                                <C> id='PENO_NM'		width=70	name='�����'	    align=center    Edit=none </C>
								<G>name=������		HeadBgColor=#F7DCBB
	                                <C> id='ENO_NM1'	width=70	name='������'	    align=center    Edit=none </C>
	                                <C> id='APP_YN_NM1' width=55	name='������Ȳ'	    align=center 	Edit=none</C>
									<C> id='APP_TIME1'	width=105	name='����ð�'	    align=center    Edit=none </C>
								</G>
								<G>name=����������		HeadBgColor=#F7DCBB
	                                <C> id='ENO_NM2'	width=70	name='������'	    align=center    Edit=none </C>
	                                <C> id='APP_YN_NM2' width=55	name='������Ȳ'	    align=center 	Edit=none</C>
									<C> id='APP_TIME2'	width=105	name='����ð�'	    align=center    Edit=none </C>
								</G>
                                <G>name=�μ���       HeadBgColor=#F7DCBB
                                    <C> id='ENO_NM3'    width=70    name='�μ���'      align=center    Edit=none </C>
                                    <C> id='APP_YN_NM3' width=55    name='������Ȳ'     align=center    Edit=none</C>
                                    <C> id='APP_TIME3'  width=105   name='����ð�'     align=center    Edit=none </C>
                                </G>
                                <G>name=������       HeadBgColor=#F7DCBB
                                    <C> id='ENO_NM4'    width=70    name='������'      align=center    Edit=none </C>
                                    <C> id='APP_YN_NM4' width=55    name='������Ȳ'     align=center    Edit=none</C>
                                    <C> id='APP_TIME4'  width=105   name='����ð�'     align=center    Edit=none </C>
                                </G>
								<C> id='ENO_CNT'		width=40	name='���;�ο�'	align=right		Edit=none </C>
                                <C> id='CHECKED'        width=60    name='�ݿ�'      align=center    EditStyle=CheckBox, Pointer=Hand  Edit={IF(CHECKED='','false','true')}    HeadCheckShow=true</C>
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