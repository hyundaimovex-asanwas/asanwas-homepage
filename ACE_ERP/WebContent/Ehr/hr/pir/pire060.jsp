<!--*************************************************************************
* @source      : pire060.jsp												*
* @description : �ٹ� �Ⱓ �˻�                      					    *
* @source      : pire060.jsp												*
* @description : �ٹ� �Ⱓ �˻�												*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2011/08/01            �̵���            	�����ۼ�                        *

***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�ٹ� �Ⱓ �˻�(pire060)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTTFT';
		var today = getToday();


		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            var FIELD_CD_SHR = document.getElementById("cmbFIELD_CD_SHR").value;
            var FIELD2_CD_SHR = document.getElementById("cmbFIELD2_CD_SHR").value;

            var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;


            dsT_CM_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire060.cmd.PIRE060CMD&S_MODE=SHR"
            						+"&FIELD_CD_SHR="+FIELD_CD_SHR
            						+"&FIELD2_CD_SHR="+FIELD2_CD_SHR
            						+"&HIR_YMD_SHR="+HIR_YMD_SHR
            						+"&END_YMD_SHR="+END_YMD_SHR;

			//prompt(this, dsT_CM_PERSON.dataid);

            dsT_CM_PERSON.reset();


        }


		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("�ο���Ȳ", '', 225);
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

           	document.form1.cmbFIELD_CD_SHR.selectedIndex      = 0;
           	//document.form1.cmbFIELD2_CD_SHR.selectedIndex      = 0;

        	document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_PERSON.ClearData();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_CM_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			document.getElementById('txtHIR_YMD_SHR').value = getToday().substring(0,8)+'01';
			document.getElementById('txtEND_YMD_SHR').value = getToday();

            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_PERSON,0,"false","true");

			//�Ҽ�
			gcds_FIELD2_CD_SHR.DataID="/servlet/GauceChannelSVL?cmd=hr.pir.e.pire060.cmd.PIRE060CMD&S_MODE=SHR_DPT";
           					//	+"&DPT="+document.getElementById('cmbFIELD_CD_SHR').value;

			gcds_FIELD2_CD_SHR.Reset();


            // �ٹ�������  �˻� �޺��ڽ� ����
			//for( var i = 1; i <= dsT_CM_COMMON_B7.CountRow; i++ ) {
			//	oOption       = document.createElement("OPTION");
            //    oOption.value = dsT_CM_COMMON_B7.NameValue(i,"CODE");
            //    oOption.text  = dsT_CM_COMMON_B7.NameValue(i,"CODE_NAME");
			//	document.getElementById("cmbFIELD_CD_SHR").add(oOption);
			//}

            //�Ҽ�
            for( var i = 1; i <= dsCOMMON_DPT2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT2.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT2.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD2_CD_SHR").add(oOption);
            }

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

		/********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

		/********************************************
         * onselchange�� ���             			*
         ********************************************/
		function fnc_match() {






			 if(document.getElementById('cmbFIELD_CD_SHR').value=="1"){ 	//����


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="2"){ //�ؿ�


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="3"){ //��������


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="4"){ //�ݰ���


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="5"){ //����


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="6"){ //��


			 }else if(document.getElementById('cmbFIELD_CD_SHR').value=="8"){ //�����

			 //	gcds_FIELD2_CD_SHR.DataID="/servlet/GauceChannelSVL?cmd=hr.pir.e.pire060.cmd.PIRE060CMD&S_MODE=SHR_DPT"
	         //   						+"&DPT="+document.getElementById('cmbFIELD_CD_SHR').value;

			 //	gcds_FIELD2_CD_SHR.Reset();

	         //   for( var i = 1; i <= gcds_FIELD2_CD_SHR.CountRow; i++ ) {
	         //       oOption       = document.createElement("OPTION");
	         //       oOption.value = gcds_FIELD2_CD_SHR.NameValue(i,"DPT_CD");
	         //       oOption.text  = gcds_FIELD2_CD_SHR.NameValue(i,"DPT_NM");
	         //       document.getElementById("cmbFIELD2_CD_SHR").add(oOption);

			 //	}

		     }

		}

    </script>
</head>




	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)		   |
    | 3. ���Ǵ� Table List(T_CM_PERSON) 			   	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>


	<OBJECT id=gcds_FIELD2_CD_SHR classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="SyncLoad" VALUE="True">
	</OBJECT>

    <!-- ���� �޺��� ���� DataSet -->

    <!-- �ٹ��� ���� -->
    <jsp:include page="/common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �Ҽ� ���� -->
    <jsp:include page="/common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT2"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �ٹ��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_B7"/>
       <jsp:param name="CODE_GUBUN"    value="B7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_CM_PERSON event="OnDblClick(row,colid)">
        if(row < 1) {
            return;
        } else {
            var url = "";
            var data = new String();

            data.eno_no     = dsT_CM_PERSON.NameValue(row, "ENO_NO");
            data.mode       = "read";
            url = "/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }
	</script>



	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON.CountRow);
        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
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
				<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ٹ� �Ⱓ �˻�</td>
				<td align="right" class="navigator">HOME/�λ����/�λ���Ȳ������/<font color="#000000">�ٹ� �Ⱓ �˻�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="greenTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
                <td align="right" class="searchState">�ٹ���</td>
                <td class="padding2423" align="left">

					<select id="cmbFIELD_CD_SHR" style="width:100" >
                        <option value="">��ü</option>
						<option value="1">����</option>
						<option value="2">�ؿ�</option>
						<option value="3">��������</option>
						<option value="4">�ݰ���</option>
						<option value="5">����</option>
						<option value="6">��</option>
						<option value="8">�����</option>
					</select>
                </td>

                <td align="right" class="searchState">�Ҽ�</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD2_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>

				<td class="searchState" align="right">�ٹ�����</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtHIR_YMD_SHR" name="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtEND_YMD_SHR" name="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgEND_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','134','108');"></a>
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
                        <object    id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                            <param name="DataID"                  value="dsT_CM_PERSON">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="right">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id={currow}      	width='35'  name='No'       			align=center value={String(Currow)} </FC>
								<FC> id='APP_YMD'		width='70'	name='�߷���'				align='center' mask='XXXX-XX-XX'</FC>


								<FC> id='APP_CD'		width='70'	name='�߷�'					align='center' </FC>

								<FC> id='STR_YMD'		width='70'	name='������'				align='center' mask='XXXX-XX-XX'</FC>
								<FC> id='END_YMD'		width='70'	name='������'				align='center' mask='XXXX-XX-XX'</FC>
								<FC> id='WRK_DAY'		width='70'	name='�ٹ���'				align='center' </FC>
								<FC> id='ENO_NM'		width='70'	name='����'					align='center' </FC>
								<C> id='GBN_NM'			width='100'	name='�ٹ���'				align='center' show=false</C>
								<C> id='ENO_NO'			width='60'	name='���'					align='center' </C>
								<C> id='HEAD_NM'		width='100'	name='����'					align='left' show=false </C>
								<C> id='DPT_NM'			width='100'	name='�Ҽ�'					align='center' </C>
								<C> id='TEAM_NM'		width='120'	name='��'					align='left' show=false </C>
								<C> id='JOB_NM'			width='80'	name='����'					align='center' </C>
								<C> id='HOB_CD'			width='50'	name='ȣ��'					align='center' show=false </C>
								<C> id='MF_TAG'			width='70'	name='����'					align='center' value={if(MF_TAG='M','����',IF(MF_TAG='F','����',''))}</C>
								<C> id='OCC_NM'			width='80'	name='�ٷα���'				align='center' </C>
								<C> id='DPA_YMD'		width='80'	name='�Ҽӹ߷���'			align='center' </C>
								<C> id='JPR_YMD'		width='90'	name='������'				align='center' </C>
								<C> id='HIRG_YMD'		width='90'	name='�׷� �Ի���'			align='center' </C>
								<C> id='HIR_YMD'		width='90'	name='�Ի���'				align='center' </C>
								<C> id='BIR_YMD'		width='90'	name='�������'				align='center' </C>
								<C> id='CET_NO'			width='120'	name='�ֹι�ȣ'				align='center' </C>
								<C> id='LSE_YY'			width='80'	name='�ټӳ��'				align='center' show=false </C>
								<C> id='EDGR_NM'		width='80'	name='�з� ����'			align='center' </C>
								<C> id='SCH_NM'			width='80'	name='�б�'					align='center' </C>
								<C> id='MAJ_NM'			width='80'	name='����'					align='center' </C>
								<C> id='GRD_NM'			width='80'	name='���� ����'			align='center' </C>
								<C> id='GUR_YMD'		width='90'	name='���� ����'			align='center' </C>
								<C> id='RADR_CT'		width='220'	name='�ּ�1'				align='left' </C>
								<C> id='RADR'			width='220'	name='�ּ�2'				align='left' </C>
								<C> id='PHN_NO'			width='100'	name='��ȭ��ȣ'				align='center' </C>
								<C> id='EM_PHN_NO'		width='100'	name='�޴���'				align='center' </C>
								<C> id='DUTY_NM'		width='80'	name='��å'					align='center' show=false</C>
								<C> id='REL_NM'			width='80'	name='���� ����'			align='center' </C>
								<C> id='RET_YMD'		width='80'	name='��� ����'			align='center' </C>
								<C> id='E_MAIL'			width='120'	name='E-Mail'				align='center' </C>
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