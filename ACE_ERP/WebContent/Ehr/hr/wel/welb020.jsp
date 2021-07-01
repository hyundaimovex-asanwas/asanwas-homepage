<!--
***********************************************************************
* @source      : welb020.jsp
* @description : ���������ݰ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/08      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���������ݰ���(welb020)</title>
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

		var btnList = 'TFTTTFTT';
        var type = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
			var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;
            var dpt_cd   = document.getElementById("txtDPT_CD_SHR").value;

           document.getElementById("txtDPT_CD_SHR").focus();

            if(pis_yymm == "") {
                alert("������� �Է��ϼ���");
                return;
            }

			dsT_WL_HDPDBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb020.cmd.WELB020CMD&S_MODE=SHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7)+"&DPT_CD="+dpt_cd;
    		dsT_WL_HDPDBOOK.reset();

            //��ȸ�Ҷ� �ʱ�ȭ

            fnc_EnableElementAll(shrList);
            dsT_WL_HDPDBOOK.UseChangeInfo = true;
            type = "";


           if(dsT_WL_HDPDBOOK.NameValue(1,"DPT_NM") == null){
              fnc_ShowElement("imgConduct");
              fnc_ShowElement("Image4");
              fnc_HiddenElement("imgConfirm");
              fnc_ShowElement("Image5");
           }

        }

        /**
         * ó�� ����
         */
        function fnc_Proc() {




            var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;

            if(pis_yymm == "") {
                alert("������� �Է��ϼ���");
                return;
            }

            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";


            dsT_WL_HDPDBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb020.cmd.WELB020CMD&S_MODE=SHR_PROC&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
            dsT_WL_HDPDBOOK.reset();


            fnc_DisableElementAll(shrList);
            dsT_WL_HDPDBOOK.UseChangeInfo = false;  //������ ��� �Է��ϰ� ����(insert ó��)
            type = "PROC";
            alert("���� ����� Ȯ�� �� ���� ��ư�� ��������");
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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

			trT_WL_HDPDBOOK.KeyValue = "tr01(I:dsT_WL_HDPDBOOK=dsT_WL_HDPDBOOK)";
			trT_WL_HDPDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb020.cmd.WELB020CMD&S_MODE=SAV&TYPE="+type;
			trT_WL_HDPDBOOK.post();

            fnc_ShowElement("imgConfirm");

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_HDPDBOOK.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("�����Ͻ� [�������:"+dsT_WL_HDPDBOOK.NameValue(dsT_WL_HDPDBOOK.RowPosition,'PIS_YM')+"/����:"+dsT_WL_HDPDBOOK.NameValue(dsT_WL_HDPDBOOK.RowPosition,'ENO_NM')+"/��ȣ:"+dsT_WL_HDPDBOOK.NameValue(dsT_WL_HDPDBOOK.RowPosition,'PHN_NO')+"] �� �ش��ϴ� �����͸� �����մϴ�.\n�����Ͻðڽ��ϱ�?")){
                dsT_WL_HDPDBOOK.DeleteRow(dsT_WL_HDPDBOOK.RowPosition);

				trT_WL_HDPDBOOK2.KeyValue = "tr01(I:dsT_WL_HDPDBOOK=dsT_WL_HDPDBOOK)";
				trT_WL_HDPDBOOK2.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb020.cmd.WELB020CMD&S_MODE=DEL";
				trT_WL_HDPDBOOK2.post();
			}

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {
			var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;
			var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;

	        var url = "welb020_PV.jsp?PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7)+"&DPT_CD="+dpt_cd;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			if (dsT_WL_HDPDBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_WL_HDPDBOOK.GridToExcel("���������ݰ���", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_WL_HDPDBOOK.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_WL_HDPDBOOK.setDataHeader(   "GUBUN:STRING"
                                               +",PIS_YYMM:STRING"
                                               +",PIS_YY:STRING"
                                               +",PIS_MM:STRING"
                                               +",ENO_NO:STRING"
                                               +",ENO_NM:STRING"
                                               +",DPT_CD:STRING"
                                               +",DPT_NM:STRING"
                                               +",JOB_CD:STRING"
                                               +",JOB_NM:STRING"
                                               +",PHN_NO:STRING"
                                               +",KR_USE_AMT:INT"
                                               +",KR_SUB_AMT:INT"
                                               +",FR_USE_AMT:INT"
                                               +",FR_SUB_AMT:INT"
                                               +",SUB_AMT_SUM:INT"
                                               +",TOTAL:INT"
                                               +",REMARK:STRING"
                                               +",ABA_CD:STRING"
                                               +",ABA_NM:STRING"
                                               +",ACC_NO:STRING" );
			}

			dsT_WL_HDPDBOOK.AddRow();

            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "GUBUN")    = "U";
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "PIS_YYMM") = getTodayArray()[0]+"-"+getTodayArray()[1];
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "PIS_YY")   = getTodayArray()[0];
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "PIS_MM")   = getTodayArray()[1];
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "ENO_NO")   = "<%=box.get("SESSION_ENONO") %>";
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "ENO_NM")   = "<%=box.get("SESSION_ENONM") %>";
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "DPT_CD")   = "<%=box.get("SESSION_DPTCD") %>";
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "DPT_NM")   = "<%=box.get("SESSION_DPTNM") %>";
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "JOB_CD")   = "<%=box.get("SESSION_JOBCD") %>";
            dsT_WL_HDPDBOOK.NameString(dsT_WL_HDPDBOOK.RowPosition, "JOB_NM")   = "<%=box.get("SESSION_JOBNM") %>";
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

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtDPT_CD_SHR").value ='';
			document.getElementById("txtDPT_NM_SHR").value ='';

			dsT_WL_HDPDBOOK.ClearData();

			fnc_EnableElementAll(shrList);

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_HDPDBOOK.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

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
			if (!dsT_WL_HDPDBOOK.IsUpdated && dsT_WL_HDPDBOOK.UseChangeInfo) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
				return false;
			}

            if(type == "PROC"
                    && !confirm(document.getElementById('txtPIS_YM_SHR').value+" �����͸� �űԷ� �����մϴ�.\n���� �����ʹ� �ʱ�ȭ �˴ϴ�. �����Ͻðڽ��ϱ�?"))
                return false;

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //cfStyleGrid2(form1.grdT_WL_HDPDBOOK);      // Grid Style ����

            cfStyleGrid(form1.grdT_WL_HDPDBOOK,15,"false","false");      // Grid Style ����
            form1.grdT_WL_HDPDBOOK.Editable = "true";

            document.getElementById('txtPIS_YM_SHR').value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById('txtPIS_YM_SHR').focus();
        }

        //�Ϸ� �� ��ư �Ⱥ��̰�
        function hid_button() {

           var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;
           dsT_WL_HDPDBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb020.cmd.WELB020CMD&S_MODE=FINSHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
    	   dsT_WL_HDPDBOOK.reset();

           var YN_TAG = document.getElementById('hidYN_TAG').value;
     	   if(YN_TAG > 0 ){
     	      fnc_HiddenElement("imgConduct");
              fnc_HiddenElement("Image4");
              fnc_HiddenElement("imgConfirm");
              fnc_HiddenElement("Image5");
    	   }
    	   else{
            fnc_ShowElement("imgConduct");
            fnc_ShowElement("Image4");
            fnc_ShowElement("imgConfirm");
            fnc_ShowElement("Image5");
            }

           fnc_SearchList();
         }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        var shrList = new Array(     "txtPIS_YM_SHR"
                                    ,"imgPIS_YM_SHR"
                                    ,"txtDPT_CD_SHR"
                                    ,"imgDPT_CD_SHR"
                                );


        /**
         * �Ϸ� ����
         */
        function fnc_Fins() {

         if(dsT_WL_HDPDBOOK.CountRow < 1) {
				alert("'��ȸ'�� 'ó��->����' ��ư�� ������ �� �Ϸ��۾��� �Ͻʽÿ�.");
			}
	    else{
	          var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;

			trT_WL_HDPDBOOK.KeyValue = "tr01(O:dsT_WL_HDPDBOOK=dsT_WL_HDPDBOOK)";
		    trT_WL_HDPDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb020.cmd.WELB020CMD&S_MODE=FINS&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
			trT_WL_HDPDBOOK.post();

			fnc_HiddenElement("imgConduct");
            fnc_HiddenElement("Image4");
            fnc_HiddenElement("imgConfirm");
            fnc_HiddenElement("Image5");


		    }
        }

        // �޷� ��Ŀ�� ����
          function card_con(){
           document.getElementById('txtDPT_CD_SHR').focus();
           document.getElementById('txtPIS_YM_SHR').focus();
          }

       //������� ��Ŀ�� ����
          function mon_con(){
           var sub = document.getElementById('txtPIS_YM_SHR');

          if((sub.length == 7)){
				document.getElementById('txtDPT_CD_SHR').focus();
			}
         }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_HDPDBOOK) |
    | 3. ���Ǵ� Table List(T_WL_HDPDBOOK)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPDBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_HDPDBOOK)	|
    | 3. ���Ǵ� Table List(T_WL_HDPDBOOK)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_HDPDBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_WL_HDPDBOOK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_HDPDBOOK Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
 			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
         } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
         }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_HDPDBOOK Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_HDPDBOOK Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_HDPDBOOK event="OnSuccess()">
	    fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>
    <script for=trT_WL_HDPDBOOK2 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_HDPDBOOK event="OnFail()">
        cfErrorMsg(this);
    </script>
    <script for=trT_WL_HDPDBOOK2 event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess(); hid_button();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" onblur="card_con();"></iframe>
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���������ݰ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/��ź�����/<font color="#000000">���������ݰ���</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Proc()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="70"></col>
								<col width="80"></col>
                                <col width="70"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">�������&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) cfCheckNumber(); " onkeyup="cfDateHyphen(this);" style="ime-mode:disabled"  onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value='';}  hid_button();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','116');"></a>
                                </td>
                                <td class="searchState" align="right">�ҼӺ�</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD_SHR" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                                    <input id="txtDPT_NM_SHR" style="width:100px" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgDPT_CD_SHR" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
    			         			<input type="hidden" id="hidABA_CD" name="hidABA_CD" size="2" maxlength="2" >
                                    <!--  �Ϸ� ��ư -->
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_OutOver.gif',1)"><img src="/images/button/btn_OutOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Fins()"></a>
                                    <input type="hidden" id="hidYN_TAG">
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
						<object	id="grdT_WL_HDPDBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
							<param name="DataID"     value="dsT_WL_HDPDBOOK">
                            <param name="ColSelect"  value="true">
                            <param name="Editable"   value="true">
							<param name="Format"     value="
								<C> id={currow}		 width=30   name='NO'			align=center           </C>
								<C> id='DPT_NM'		 width=70	name='�Ҽ�'			align=left Edit=None   </C>
								<C> id='JOB_NM'		 width=50	name='����'			align=center Edit=None </C>
								<C> id='ENO_NO'		 width=60	name='���'			align=center Edit=None </C>
								<C> id='ENO_NM'		 width=60	name='����'			align=center Edit=None </C>
								<C> id='PHN_NO'		 width=90	name='�޴�����ȣ'	align=center Edit=None </C>
								<C> id='ABA_NM'      width=55   name='���¸�'       align=center Edit=None </C>
								<C> id='ACC_NO'		 width=100	name='���¹�ȣ'		align=center Edit=None </C>
                            	<C> id='KR_SUB_AMT'  width=60   name='������'       align=right  rightMargin='10'    Edit=Numeric    BgColor='#F0FFF0'</C>
                                <C> id='KR_USE_AMT'	 width=65	name='������ȭ��'	align=right  rightMargin='10'    Edit=Numeric    BgColor='#F0FFF0'</C>
								<C> id='FR_USE_AMT'	 width=65	name='������ȭ��'	align=right  rightMargin='10'    Edit=Numeric    BgColor='#F0FFF0'</C>
								<C> id='TOTAL'		 width=60	name='�հ�'			align=right  rightMargin='10'    Edit=Numeric    BgColor='#F0FFF0'</C>
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


<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->
<object id="bndT_WL_HDPDBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WL_HDPDBOOK">
    <Param Name="BindInfo", Value='
        <C>Col=YN_TAG       Ctrl=hidYN_TAG         Param=value     </C>
        <C>Col=ABA_CD       Ctrl=txtABA_CD          Param=value     </C>
    '>
</object>

