<!--
***********************************************************************
* @source      : weld050.jsp
* @description : ������ �ܵ� ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/15      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�������ܵ����(weld050)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TTTTFFTT';
		var cn_cd = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var ord_no = document.getElementById('cmbORD_NO_SHR').value;
			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			var cn_cd = document.getElementById('cmbCO_CD_SHR').value;

			dsT_WL_CONDORSV.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR&ORD_NO="+ord_no+"&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CN_CD="+cn_cd;
    		dsT_WL_CONDORSV.reset();

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

			trT_WL_CONDORSV.KeyValue = "tr01(I:dsT_WL_CONDORSV=dsT_WL_CONDORSV)";
			trT_WL_CONDORSV.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SAV";
			trT_WL_CONDORSV.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_CONDORSV.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
            
            var msg = "�����������ȣ:"+dsT_WL_CONDORSV.NameValue(dsT_WL_CONDORSV.RowPosition,'ORD_NO')
                    + "\n�ܵ�:"+dsCOMMON_CN.NameString(       dsCOMMON_CN.NameValueRow(       "CODE",     dsT_WL_CONDORSV.NameValue(dsT_WL_CONDORSV.RowPosition,'CN_CD')), "CODE_NAME")
                    + "\n����:"+dsT_CM_COMMON_CP.NameString(  dsT_CM_COMMON_CP.NameValueRow(  "COMM_CD",  dsT_WL_CONDORSV.NameValue(dsT_WL_CONDORSV.RowPosition,'CO_CD')), "COMM_NM")
                    + "\n�̿������:"+dsT_WL_CONDORSV.NameValue(dsT_WL_CONDORSV.RowPosition,'STR_YMD')
                    + "\n�� ������ �����Ͻðڽ��ϱ�?";
            
			if(confirm(msg)){
				dsT_WL_CONDORSV.DeleteRow(dsT_WL_CONDORSV.RowPosition);
				trT_WL_CONDORSV.KeyValue = "tr01(I:dsT_WL_CONDORSV=dsT_WL_CONDORSV)";
				trT_WL_CONDORSV.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=DEL";
				trT_WL_CONDORSV.post();
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_WL_CONDORSV.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_WL_CONDORSV.setDataHeader("ORD_NO:STRING, SEQ_NO:STRING, CN_CD:STRING, CO_CD:STRING, STR_YMD:STRING, RSV_NO:STRING, STAY_CNT:STRING, ROOM_CNT:STRING");
			}

			dsT_WL_CONDORSV.AddRow();
            document.getElementById("cmbORD_NO").value = document.getElementById("cmbORD_NO_SHR").value;
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

			document.getElementById('cmbORD_NO_SHR').selectedIndex = 0;
			document.getElementById('txtSTR_YMD_SHR').value = "";
			document.getElementById('txtEND_YMD_SHR').value = "";
			document.getElementById('cmbCO_CD_SHR').value = "";
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDORSV.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_CONDORSV.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_WL_CONDORSV.IsUpdated ) {
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

			//�ܵ�
            for( var i = 1; i <= dsCOMMON_CN.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_CN.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_CN.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCN_CD").add(oOption);

            }
			//�ܵ�(��ȸ)
            for( var i = 1; i <= dsCOMMON_CN.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_CN.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_CN.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCO_CD_SHR").add(oOption);

            }
            //�ܵ� ����Ʈ ��ü ��ȸ (weld020 ���) 
            dsT_CM_COMMON_CP.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=SHR_01";
            dsT_CM_COMMON_CP.Reset();

			//�ܵ� ������ ������ȣ
			dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR_01";
			dsT_WL_CONDOSSN.Reset();

			cfStyleGrid(form1.grdT_WL_CONDORSV,15,"false","false");      // Grid Style ����
            document.getElementById('cmbORD_NO_SHR').focus();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*********************************
         * 16. cmbCN_CD onChange�� ó��  *
         ********************************/
		function fnc_changeCN_CD() {

			var cn_cd = document.getElementById('cmbCN_CD').value;

			dsT_CM_COMMON.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld020.cmd.WELD020CMD&S_MODE=SHR_01&COMM_CD="+cn_cd;
			dsT_CM_COMMON.Reset();

		}

		/**********************************
         * 18. cmbORD_NO onChange�� ó��  *
         *********************************/
		function fnc_changeORD_NO() {

			var row = document.getElementById('cmbORD_NO').selectedIndex + 1;

			document.getElementById("txtSTR_YMD_").value = dsT_WL_CONDOSSN.NameValue(row, "STR_YMD");
			document.getElementById("txtEND_YMD_").value = dsT_WL_CONDOSSN.NameValue(row, "END_YMD");

		}
        
        //�Է�â ����Ʈ
        var elementList = new Array(     "cmbORD_NO"
                                        ,"txtSTR_YMD"
                                        ,"imgSTR_YMD"
                                        ,"cmbCN_CD"
                                        ,"cmbCO_CD"
                                        ,"txtRSV_NO"
                                        ,"txtSTAY_CNT" 
                                        ,"txtROOM_CNT" );
                                        
        var exceptionList = new Array(   "cmbORD_NO"
                                        ,"txtSTR_YMD"
                                        ,"imgSTR_YMD"
                                        ,"cmbCN_CD"
                                        ,"cmbCO_CD"
                                        ,"txtSTAY_CNT"
                                        ,"txtROOM_CNT" );
                                        
        var keyList = new Array(         "cmbORD_NO"
                                        ,"txtRSV_NO"
                                        ,"txtSTAY_CNT"
                                        ,"txtROOM_CNT" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDORSV) |
    | 3. ���Ǵ� Table List(T_WL_CONDORSV)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDORSV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_COMMON)   |
    | 3. ���Ǵ� Table List(T_CM_COMMON)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. ī�ǿ� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_COMMON_CP)|
    +------------------------------------------------>
    <Object ID="dsT_CM_COMMON_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOSSN) |
    | 3. ���Ǵ� Table List(T_WL_CONDOSSN)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_CONDORSV)	|
    | 3. ���Ǵ� Table List(T_WL_CONDORSV)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDORSV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ܵ� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_CN"/>
       <jsp:param name="CODE_GUBUN"    value="CN"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDORSV Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDORSV Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDORSV Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������] ���� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("''�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�ش� �ܵ��� ��ϵ� ������ �����ϴ�!");

        } else {

			var obj = document.getElementById("cmbCO_CD");
			//������ ��� clear
             for (i=0; i<obj.options.length; i++ ) {
                obj.options[i] = null;
             }
             obj.options.length = 0 ;

			//����
            for( i = 1; i <= dsT_CM_COMMON.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON.NameValue(i,"COMM_CD");
                oOption.text  = dsT_CM_COMMON.NameValue(i,"COMM_NM");
                document.getElementById("cmbCO_CD").add(oOption);

            }
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {



        } else {

			//������ �ܵ� ������ȣ
            for( i = 1; i <= dsT_WL_CONDOSSN.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
                oOption.text  = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
                document.getElementById("cmbORD_NO").add(oOption);

            }
			//������ �ܵ� ������ȣ
            for( i = 1; i <= dsT_WL_CONDOSSN.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
                oOption.text  = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
				document.getElementById("cmbORD_NO_SHR").add(oOption);

            }

			document.getElementById("txtSTR_YMD_").value = dsT_WL_CONDOSSN.NameValue(1, "STR_YMD");
			document.getElementById("txtEND_YMD_").value = dsT_WL_CONDOSSN.NameValue(1, "END_YMD");

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_CONDORSV event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_CONDORSV event="OnFail()">
        cfErrorMsg(this);
    </script>
    

    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CONDORSV event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            //�ű��� ���        
            if(dsT_WL_CONDORSV.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
            
            //�ܵ��� �ش��ϴ� �����ڵ带 �����Ѵ�.
            bndT_WL_CONDORSV.ActiveBind = false;
            fnc_changeCN_CD();
            document.getElementById("cmbCO_CD").value = dsT_WL_CONDORSV.NameString(row, "CO_CD");
            bndT_WL_CONDORSV.ActiveBind = true;
            
            //�����ȣ�� ��Ŀ�� �̵�
            document.getElementById("txtRSV_NO").focus();
        }
    </script>

    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_WL_CONDORSV event=CanRowPosChange(row)>
        var keyName;
        var colName;
        
        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);
                
                if (dsT_WL_CONDORSV.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_WL_CONDORSV.GetHdrDispName('-3', colName) + " ]��(��) �ʼ� �Է»����Դϴ�");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������ܵ����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ܵ�/<font color="#000000">�������ܵ����</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="100"></col>
									<col width="60"></col>
									<col width="230"></col>
									<col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">������</td>
								<td class="padding2423">
									<select id="cmbORD_NO_SHR" style="WIDTH:100%" onChange="fnc_SearchList();">
									</select>
								</td>
								<td align="right" class="searchState">�Ⱓ&nbsp;</td>
								<td class="padding2423">
									<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','175','110');"></a> ~
									<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','290','110');"></a>
								</td>
								<td align="center" class="searchState">�� ��</td>
								<td class="padding2423">
									<select id="cmbCO_CD_SHR" style="WIDTH:30%" onChange="fnc_SearchList();">
										<option value="">�� ü</option>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="150"></col>
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">������</td>
					<td class="padding2423">
						<select id="cmbORD_NO" style="WIDTH:70%" onChange="fnc_changeORD_NO();">
						</select>
						<input id="txtSEQ_NO"  size="3" class="input_ReadOnly" readonly style="text-align:center">
					</td>
					<td class="padding2423" colspan="2">
						<input id="txtSTR_YMD_"  size="10" class="input_ReadOnly" readonly style="text-align:center"> ~
						<input id="txtEND_YMD_" size="10" class="input_ReadOnly" readonly style="text-align:center">
					</td>
					<td align="center" class="creamBold">�̿������</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(dsT_WL_CONDORSV.CountColumn < 1) return;calendarBtn('datetype1','txtSTR_YMD','','430','100');"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<select id="cmbCN_CD" style="WIDTH:100" onChange="fnc_changeCN_CD();">
						</select>
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<select id="cmbCO_CD" style="WIDTH:160">
						</select>
					</td>
					<td align="center" class="creamBold">�����ȣ</td>
					<td class="padding2423">
						<input id="txtRSV_NO" maxLength="15">
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">�̿��ϼ�</td>
					<td class="padding2423">
						<input id="txtSTAY_CNT" size="4" maxLength="2" onkeypress="cfCheckNumber2();" style="ime-mode:disabled;text-align:center">
					</td>
					<td align="center" class="creamBold">���Ǽ�</td>
					<td class="padding2423" colspan="3">
						<input id="txtROOM_CNT" size="4" maxLength="2" onkeypress="cfCheckNumber2();" style="ime-mode:disabled;text-align:center">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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
						<object	id="grdT_WL_CONDORSV" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_WL_CONDORSV">
							<param name="Format"					value="
								<C> id={currow}		width=29    name='NO'				align=center </C>
								<C> id='ORD_NO'		width=90	name='�����������ȣ'	align=center </C>
								<C> id='SEQ_NO'		width=60	name='���ļ���'			align=center </C>
								<C> id='STR_YMD'	width=90	name='�̿������'		align=center </C>
								<C> id='CN_CD'		width=90	name='�ܵ�'				align=left EditStyle=Lookup  Data='dsCOMMON_CN:CODE:CODE_NAME'</C>
								<C> id='CO_CD'		width=170	name='����'				align=left EditStyle=Lookup  Data='dsT_CM_COMMON_CP:COMM_CD:COMM_NM'</C>
								<C> id='RSV_NO'		width=105	name='�����ȣ'			align=center </C>
								<C> id='STAY_CNT'	width=65	name='�̿��ϼ�'			align=center </C>
								<C> id='ROOM_CNT'	width=65	name='���Ǽ�'			align=center </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- KPI Pool ���� ���̺� -->
<object id="bndT_WL_CONDORSV" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_CONDORSV">
	<Param Name="BindInfo", Value='
		<C>Col=ORD_NO		Ctrl=cmbORD_NO	      	Param=value		</C>
		<C>Col=SEQ_NO    	Ctrl=txtSEQ_NO	     	Param=value		</C>
		<C>Col=STR_YMD		Ctrl=txtSTR_YMD	      	Param=value		</C>
		<C>Col=CN_CD		Ctrl=cmbCN_CD			Param=value		</C>
		<C>Col=CO_CD		Ctrl=cmbCO_CD			Param=value		</C>
		<C>Col=RSV_NO		Ctrl=txtRSV_NO			Param=value		</C>
		<C>Col=STAY_CNT		Ctrl=txtSTAY_CNT      	Param=value		</C>
		<C>Col=ROOM_CNT		Ctrl=txtROOM_CNT      	Param=value		</C>
    '>
</object>