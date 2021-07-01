	<!--*************************************************************************
	* @source      : crua030.jsp												*
	* @description : �հ��ڵ�� PAGE		 								    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/03      ���뼺          �����ۼ�									*
    * 2007/05/09   ����ȣ          Ȯ��ó�� ���� ����                           *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�հ��ڵ��(crua030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFTFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {
			var f = document.form1;

			if(!fnc_SearchItemCheck()) return;

			//���ڱ� ��û�� ó�� ��ȸ
			var regyy        = f.txtREGYY_SHR.value;
			var regch        = f.txtREGCH_SHR.value;
			var reg_str      = f.txtREG_NO_STR.value;
			var reg_end      = f.txtREG_NO_END.value;
			var school       = f.cmbSCHOOL_SHR.value;
			var split_flag   = f.rdoSPLIT_FLAG_SHR.CodeValue;
			var passtag      = f.cmbPASSTAG_SHR.value;



            //ä�� ���� ����Ʈ ��ȸ
            dsT_RC_HISTORY.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=SHR2&PIS_YY="+regyy+"&SEQ_NO="+regch;
            dsT_RC_HISTORY.reset();

            //ä�������� ����Ʈ ��ȸ
            dsT_RC_MASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua030.cmd.CRUA030CMD"
                                 + "&S_MODE=SHR"
                                 + "&REGYY="+regyy
                                 + "&REGCH="+regch
                                 + "&REG_STR="+reg_str
                                 + "&REG_END="+reg_end
                                 + "&SCHOOL="+school
                                 + "&SPLIT_FLAG="+split_flag
                                 + "&PASSTAG="+passtag;
            dsT_RC_MASTER.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 *
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;

			trT_RC_MASTER.KeyValue = "tr01(I:dsT_RC_MASTER=dsT_RC_MASTER)";
			trT_RC_MASTER.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua030.cmd.CRUA030CMD&S_MODE=SAV";
			trT_RC_MASTER.post();

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			var f = document.form1;
			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";
			f.txtREG_NO_STR.value = "";
			f.txtREG_NO_END.value = "";
			f.cmbSCHOOL_SHR.value = "";
			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";
			f.cmbPASSTAG_SHR.value = "";
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_RC_MASTER.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var regyy = document.getElementById('txtREGYY_SHR');
			var regch = document.getElementById('txtREGCH_SHR');
			var reg_str = document.getElementById('txtREG_NO_STR');
			var reg_end = document.getElementById('txtREG_NO_END');

			if(regyy.value == '') {
				alert("�⵵�� �ʼ� �Է»����Դϴ�!");
				regyy.focus();
				return false;
			} else if(regyy.value.length < 4) {
				alert("4�ڸ����� �⵵�� �Է��ϼ���!");
				regyy.focus();
				return false;
			}
			if(regch.value == '') {
				alert("ȸ���� �ʼ� �Է»����Դϴ�!");
				regch.focus();
				return false;
			} else if(regch.value.length < 2) {
				alert("2�ڸ����� ȸ���� �Է��ϼ���!");
				regch.focus();
				return false;
			}

			if(reg_str.value != '' && reg_str.value.length < 11) {
				alert("11�ڸ����� �����ȣ�� �Է��ϼ���!");
				reg_str.focus();
				return false;
			}
			if(reg_end.value != '' && reg_end.value.length < 11) {
				alert("11�ڸ����� �����ȣ�� �Է��ϼ���!");
				reg_end.focus();
				return false;
			}

			return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_MASTER.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   *
         ********************************************/
        function fnc_OnLoadProcess() {
			var f = document.form1;

			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";

			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";


  			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid(form1.grdT_RC_MASTER,15,"false","right");      // Grid Style ����
			f.txtREGYY_SHR.focus();

		    fnc_SearchList();
                form1.grdT_RC_MASTER.ColumnProp("{currow}" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("REG_NO" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("ENO_NM" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("BIRYMD" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SEXGU" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_YMD" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_NM" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_MAJOR" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("SCH_GRDYN" , "Sort") = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG" , "Sort")   = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG1" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG2" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG3" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("PASSTAG4" , "Sort")  = "false";
                form1.grdT_RC_MASTER.ColumnProp("FINAL_PASS", "Sort") = "false";

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /**
         * �հݿ��� �ϰ� �ݿ�
         */
   /*   function fnc_BatchAdjust() {
            var pro_sts = dsT_RC_HISTORY.NameString(0, "PRO_STS");
            var columnName = "";

            if(pro_sts == "3")
                columnName = "PASSTAG1";
            else if(pro_sts == "4")
                columnName = "PASSTAG2";
            else if(pro_sts == "5")
                columnName = "PASSTAG3";
            else if(pro_sts == "6")
                columnName = "PASSTAG4";

            var passtag = document.getElementById("cmbPASSTAG").value;
            document.getElementById("cmbPASSTAG").value = "";

            if(columnName != "" || dsT_RC_MASTER.CountRow == 0) {
                for(var i=1; i<=dsT_RC_MASTER.CountRow; i++) {
                    dsT_RC_MASTER.NameString(i, columnName) = passtag;
                }
            } else {
                alert("�ݿ��� ����� �����ϴ�.");
            }
        }*/

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_MASTER)		   |
    | 3. ���Ǵ� Table List(T_RC_MASTER) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_RC_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_HISTORY)  |
    | 3. ���Ǵ� Table List(T_RC_HISTORY)          |
    +----------------------------------------------->
    <Object ID="dsT_RC_HISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_RC_MASTER)		|
    | 3. ���Ǵ� Table List(T_RC_MASTER)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_MASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:dsT_RC_MASTER=dsT_RC_MASTER)">
    </Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_RC_MASTER Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

	<Script For=dsT_RC_HISTORY Event="OnLoadCompleted(iCount)">

        grdT_RC_MASTER.ColumnProp("PASSTAG1", "BgColor") = "";
        grdT_RC_MASTER.ColumnProp("PASSTAG2", "BgColor") = "";
        grdT_RC_MASTER.ColumnProp("PASSTAG3", "BgColor") = "";
        grdT_RC_MASTER.ColumnProp("PASSTAG4", "BgColor") = "";

        if (iCount == 1)    {
            var pro_sts = dsT_RC_HISTORY.NameString(0, "PRO_STS");
            var columnName;
            if(pro_sts == "3")
                columnName = "PASSTAG1";
            else if(pro_sts == "4")
                columnName = "PASSTAG2";
            else if(pro_sts == "5")
                columnName = "PASSTAG3";
            else if(pro_sts == "6")
                columnName = "PASSTAG4";

            grdT_RC_MASTER.ColumnProp(columnName, "BgColor") = "#EEEEEE";
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_RC_MASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_RC_MASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

   <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_RC_MASTER event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>


    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_RC_MASTER event="OnFail()">
        if (trT_RC_MASTER.ErrorCode != 50015) {
			document.getElementById("resultMessage").innerText = ' ';
			cfErrorMsg(this);
		}
    </script>


    <!--------------------------+
    | �׸��带 ����Ŭ��������  |
    +--------------------------->
    <script language=JavaScript for=grdT_RC_MASTER event=OnDblClick(row,colid)>
        var pro_sts = dsT_RC_HISTORY.NameString(0, "PRO_STS");
        var columnName;
        var passTag;

        if(pro_sts == "3")
            columnName = "PASSTAG1";
        else if(pro_sts == "4")
            columnName = "PASSTAG2";
        else if(pro_sts == "5")
            columnName = "PASSTAG3";
        else if(pro_sts == "6")
            columnName = "PASSTAG4";


        if(columnName == colid) {
            passTag = dsT_RC_MASTER.NameString(row, colid);

            if(passTag == "Y") passTag = "N";
            else passTag = "Y";

            dsT_RC_MASTER.NameString(row, colid) = passTag;
        }
    </script>

     <!--------------------------+
     | �׸��� Ŭ���� Y/N ����    |
     +--------------------------->
     <script language="javascript" for=grdT_RC_MASTER event=OnClick(row,colid)>
        if(row>0 && colid.substring(0,2) =="PA" || colid.substring(0,5) == "FINAL"){
          if(dsT_RC_MASTER.NameValue(row,colid) =="Y"){
             dsT_RC_MASTER.NameValue(row,colid) = "";
          }else{
             dsT_RC_MASTER.NameValue(row,colid) = "Y";
          }
        }
     </script>


    <!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�հ��ڵ��</td>
					<td align="right" class="navigator">HOME/��Ÿ/ä�����/<font color="#000000">�հ��ڵ��</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="40"></col>
							<col width="70"></col>
							<col width="100"></col>
							<col width="170"></col>
							<col width="40"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="searchState">�⵵&nbsp;</td>
							<td class="padding2423">
                                <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                            <input type="text" id="txtREGYY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                        </td>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtREGYY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                    </tr>
                                    <tr>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtREGYY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                    </tr>
                                </table>
							</td>
							<td align="right" class="searchState">�����ȣ&nbsp;</td>
							<td class="padding2423">
								<input id="txtREG_NO_STR"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"> - <input id="txtREG_NO_END"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled">
							</td>
							<td align="right" class="searchState">�з�</td>
							<td class="padding2423">
                                <select id="cmbSCHOOL_SHR">
                                    <option value="">�� ü</option>
                                    <option value="Y">�����̻�</option>
                                    <option value="N">�����̸�</option>
                                </select>
							</td>
							<td align="right" class="searchState">�հݿ���</td>
							<td class="padding2423">
                                <select id="cmbPASSTAG_SHR">
                                    <option value="">��������</option>
                                    <option value="1">�����հ�</option>
                                    <option value="2">1�������հ�</option>
                                    <option value="3">2�������հ�</option>
                                    <option value="4">3�������հ�</option>
                                    <option value="5">��ü�˻��հ�</option>
                                    <option value="6">�����հ�</option>
                                </select>
							</td>
						</tr>
						<tr>
							<td align="center" class="searchState">����&nbsp;</td>
							<td class="padding2423">
								<input id="txtREGCH_SHR"  size="4" maxLength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
							</td>
							<td align="center" class="searchState">����/��±���&nbsp;</td>
							<td class="padding2423"><comment id="__NSID__">
								<object id=rdoSPLIT_FLAG_SHR classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:20; width:140">
									<param name=AutoMargin	value="true">
									<param name=Cols		value="2">
									<param name=Format		value="A^���Ի��,B^��»��">
								</object>
								</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td>
							<td></td>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                 <!--      <td align="right">
                           <select id="cmbPASSTAG">
                                <option value=""></option>
                                <option value="Y">Y</option>
                                <option value="N">N</option>
                            </select>
                            &nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBatchAdjust','','/images/button/BatchAdjustOver.gif',1)"><img type="image" style="border:0" src="/images/button/BatchAdjustOn.gif"  id="imgBatchAdjust"  name="imgBatchAdjust" width="80" height="20" border="0" align="absmiddle" onClick="fnc_BatchAdjust()"></a>
                   -->
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
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_RC_MASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_RC_MASTER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value="
                            <C> id={currow}     width='40'  name='NO'           align=center    value={String(currow)} </C>
                            <C> id='REG_NO'     width='80'  name='�����ȣ'     align='center'  </C>
                            <C> id='ENO_NM'     width='60'  name='����'         align='center'  </C>
                            <C> id='BIRYMD'     width='80'  name='�������'     align='center'  Mask='XXXX-XX-XX'  </C>
                            <C> id='SEXGU'      width='45'  name='����'         align='center'  Value={Decode(SEXGU,'M','��','F','��')}  </C>
                            <C> id='SCH_YMD'    width='70'  name='�����⵵'     align='center'  Mask='XXXX-XX'  </C>
                            <C> id='SCH_NM'     width='90'  name='��ű�'       align='left'    </C>
                            <C> id='SCH_MAJOR'  width='90'  name='����'         align='left'    </C>
                            <C> id='SCH_GRDYN'  width='90'  name='����/����'    align='left'    </C>
                            <C> id='TOTAL_PNT'  width='60'  name='������'       align='center'  </C>
                            <C> id='TOTAL_COV'  width='60'  name='ȯ����'       align='center'  </C>
                            <C> id='TOTAL_SUM'  width='60'  name='�հ�'         align='center'  </C>
                            <C> id='PASSTAG'    width='60'  name='����'         align='center'  color={Decode(PASSTAG,'Y','#FF0000')}</C>
                            <C> id='PASSTAG1'   width='60'  name='����1'        align='center'  color={Decode(PASSTAG1,'Y','#FF0000')}</C>
                            <C> id='PASSTAG2'   width='60'  name='����2'        align='center'  color={Decode(PASSTAG2,'Y','#FF0000')}</C>
                            <C> id='PASSTAG3'   width='60'  name='����3'        align='center'  color={Decode(PASSTAG3,'Y','#FF0000')}</C>
                            <C> id='PASSTAG4'   width='60'  name='�Ű�'         align='center'  color={Decode(PASSTAG4,'Y','#FF0000')}</C>
                            <C> id='FINAL_PASS' width='60'  name='�����հ�'     align='center'  color={Decode(FINAL_PASS,'Y','#FF0000')}</C>
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
