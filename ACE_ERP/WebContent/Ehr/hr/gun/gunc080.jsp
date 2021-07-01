<!--
*****************************************************
* @source       : gunc080.jsp
* @description : ���ϱٹ����������ó�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/08/02      ������        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ϱٹ����������ó��(gunc080)</title>
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

        var today = getToday();
        
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����(�Ⱓ)
			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value;

            if(!fnc_SearchItemCheck()) return;
            
            
            //��ȸ �ش����� �����Ѵ�.
            document.getElementById("hidTAG_YM").value = HOL_YMD_SHR;

			dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc020.cmd.GUNC020CMD"
                                   + "&S_MODE=SHR"
                                   + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                   + "&GUNC=080";
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

            document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtHOL_YMD_SHR").focus();

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

			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value; // ���۳��

            if(HOL_YMD_SHR == ""){
                alert("�˻� �Ⱓ�� �Է��ϼ���!");
                document.getElementById("txtHOL_YMD_SHR").focus();
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
            document.getElementById("txtHOL_YMD_SHR").value = hol_ymd.substr(0, 7); // �ش���

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
            
            var text = "[�ش���:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+", "
                     + "�����:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PENO_NM")+"] "
                     + "�� �ڷḦ "+(app_yn == "Y" ? "����" : "�ΰ�")+" �Ͻðڽ��ϱ�?";
            
            if (!confirm(text)) return;
            
            
            
            //�������� ����
            var grp_no = dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GRP_NO");
            var idx = dsT_DI_APPROVAL.NameValueRow("GRP_NO", grp_no);
            
            for(var i=idx; i<=dsT_DI_APPROVAL.CountRow; i++) {
                if(grp_no != dsT_DI_APPROVAL.NameString(i, "GRP_NO"))
                    break;
               
                dsT_DI_APPROVAL.NameString(i, "APP_TAG") = app_yn;
            }
            
            trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc020.cmd.GUNC020CMD&S_MODE=SAV";
            trT_DI_APPROVAL.post();
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
        
        var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value.split("-");
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
                //����϶�, �ڱ� �ڽ��� �ƴҶ�
                if((papp_yn == "R")
                            && pseq_no != "0") {
            
                    // �������� ���
                    if (pseq_no == "3" || pseq_no == "4") {
                        fnc_ShowElement("imgApproval");
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
            param.gunc      = "080";

			window.showModalDialog("/hr/gun/gunc021.jsp", param, "dialogWidth:860px; dialogHeight:460px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱٹ����������ó��</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���ϱٹ����������ó��</font></td>
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
           &nbsp;&nbsp;&nbsp;&nbsp;�ػ󼼳����� ���Ͻø� �ش� ��û���� ������ ����Ŭ�� �ϼ���.
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
								<td align="right" class="searchState">��û���&nbsp;</td>
                                <td class="padding2423">
									<input id="txtHOL_YMD_SHR" size="8" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHOL_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgHOL_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtHOL_YMD_SHR','','70','110');"></a>
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
                                <C> id='GRP_NO'         width=45	name='GRP_NO'          align=center    Edit=none       Suppress=5</C>
								<C> id='GUN_YMD'		width=65	name='�ش���'	     align=center     Edit=none       Suppress=5</C>
                                <C> id='PDPT_NM'		width=100	name='�Ҽ�'		     align=center    Edit=none </C>
                                <C> id='PENO_NM'		width=70	name='�����'	    align=center    Edit=none </C>
                                
                                
								<G>name=�μ���		HeadBgColor=#F7DCBB      
	                                <C> id='ENO_NM3'	width=70	name='�μ���'	    align=center    Edit=none     Suppress=5</C>
	                                <C> id='APP_YN_NM3' width=55	name='������Ȳ'	    align=center 	Edit=none   Suppress=5</C>
									<C> id='APP_TIME3'	width=105	name='����ð�'	    align=center    Edit=none     </C>
								</G>
                                <G>name=������       HeadBgColor=#F7DCBB           
                                    <C> id='ENO_NM4'    width=70    name='������'      align=center    Edit=none   Suppress=5</C>
                                    <C> id='APP_YN_NM4' width=55    name='������Ȳ'     align=center    Edit=none   Suppress=5</C>
                                    <C> id='APP_TIME4'  width=105   name='����ð�'     align=center    Edit=none   </C>
                                </G>
								<C> id='ENO_CNT'		width=40	name='���;�ο�'	align=right		Edit=none </C>
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