<!--*************************************************************************
* @source      : pire050.jsp														*
* @description : �λ� ��Ȳ �˻�                      									*
* @source      : pire050.jsp														*
* @description : �λ� ��Ȳ �˻�													*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2011/06/30            �̵���            	�����ۼ�                       				 *
* 2016/04/28            �̵���            	ERP �̻�									 *
***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�λ� ��Ȳ</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


		var today = gcurdate;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {


			var ls_data = "";

            var CLAS_CD_SHR = document.getElementById("cmbCLAS_CD_SHR").value;

            var FIELD_CD_SHR = document.getElementById("cmbFIELD_CD_SHR").value;
            var FIELD2_CD_SHR = document.getElementById("cmbFIELD2_CD_SHR").value;
            var FIELD3_CD_SHR = document.getElementById("cmbFIELD3_CD_SHR").value;

            var SHAPE_CD_SHR = document.getElementById("cmbSHAPE_CD_SHR").value;
            var JOB_CD_SHR = document.getElementById("cmbJOB_CD_SHR").value;
            var SEX_CD_SHR = document.getElementById("cmbSEX_CD_SHR").value;
            var YEAR_CD_SHR = document.getElementById("cmbYEAR_CD_SHR").value;



            var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;

            var HIRG_YMD_SHR  = document.getElementById("txtHIRG_YMD_SHR").value;
            var ENDG_YMD_SHR = document.getElementById("txtENDG_YMD_SHR").value;

            var JPR_YMD_SHR  = document.getElementById("txtJPR_YMD_SHR").value;
            var ENDJ_YMD_SHR  = document.getElementById("txtENDJ_YMD_SHR").value;

            var RET_YMD_SHR  = document.getElementById("txtRET_YMD_SHR").value;
            var ENDR_YMD_SHR  = document.getElementById("txtENDR_YMD_SHR").value;



			if (document.form1.chkHIR_YMD_SHR.checked)
				ls_data += "&HIR_YMD_SHR=" + HIR_YMD_SHR + "&END_YMD_SHR="+END_YMD_SHR;
			else
				ls_data += "";

			if (document.form1.chkHIRG_YMD_SHR.checked)
				ls_data += "&HIRG_YMD_SHR=" + HIRG_YMD_SHR + "&ENDG_YMD_SHR="+ENDG_YMD_SHR;
			else
				ls_data += "";

			if (document.form1.chkJPR_YMD_SHR.checked)
				ls_data += "&JPR_YMD_SHR=" + JPR_YMD_SHR + "&ENDJ_YMD_SHR="+ENDJ_YMD_SHR;
			else
				ls_data += "";

			if (document.form1.chkRET_YMD_SHR.checked)
				ls_data += "&RET_YMD_SHR=" + RET_YMD_SHR + "&ENDR_YMD_SHR="+ENDR_YMD_SHR;
			else
				ls_data += "";


            dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.e.pire050.cmd.PIRE050CMD&S_MODE=SHR"
            						+"&CLAS_CD_SHR="+CLAS_CD_SHR
            						+"&FIELD_CD_SHR="+FIELD_CD_SHR
            						+"&FIELD2_CD_SHR="+FIELD2_CD_SHR
            						+"&FIELD3_CD_SHR="+FIELD3_CD_SHR
            						+"&SHAPE_CD_SHR="+SHAPE_CD_SHR
            						+"&JOB_CD_SHR="+JOB_CD_SHR
            						+"&SEX_CD_SHR="+SEX_CD_SHR
            						+"&YEAR_CD_SHR="+YEAR_CD_SHR
 			                        + ls_data;


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

            if (dsT_CM_PERSON.CountRow < 1 ) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("�λ� ��Ȳ", '', 225);

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

           	document.form1.cmbCLAS_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD2_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbFIELD3_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbSHAPE_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbJOB_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbSEX_CD_SHR.selectedIndex      = 0;
           	document.form1.cmbYEAR_CD_SHR.selectedIndex      = 0;


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
			
        	window.close();
        	
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


			document.getElementById('txtHIR_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtEND_YMD_SHR').value = gcurdate;

			document.getElementById('txtHIRG_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtENDG_YMD_SHR').value = gcurdate;

			document.getElementById('txtJPR_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtENDJ_YMD_SHR').value = gcurdate;

			document.getElementById('txtRET_YMD_SHR').value = gcurdate.substring(0,8)+'01';
			document.getElementById('txtENDR_YMD_SHR').value = gcurdate;

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","true");



            //����
            for( var i = 1; i <= dsCOMMON_DPT.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);
            }

            //�μ�
            for( var i = 1; i <= dsCOMMON_DPT2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT2.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT2.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD2_CD_SHR").add(oOption);
            }

            //��
            for( var i = 1; i <= dsCOMMON_DPT3.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_DPT3.NameValue(i,"DPT_CD");
                oOption.text  = dsCOMMON_DPT3.NameValue(i,"DPT_NM");
                document.getElementById("cmbFIELD3_CD_SHR").add(oOption);
            }



            //�ٷα�������
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);
            }

            //��������
            for( var i = 1; i <= dsCOMMON_A2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD_SHR").add(oOption);
            }

            //���౸��
            for( var i = 1; i <= dsCOMMON_Z2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Z2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Z2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSEX_CD_SHR").add(oOption);
            }

            //��������
            for( var i = 1; i <= dsCOMMON_A4.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbYEAR_CD_SHR").add(oOption);
            }

            fnc_SearchList();
            
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


    <!-- ���� �޺��� ���� DataSet -->

    <!-- ���� ���� -->
    <jsp:include page="../../common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �μ� ���� -->
    <jsp:include page="../../common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT2"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �� ���� -->
    <jsp:include page="../../common/gauceDataSet_DPT.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_DPT3"/>
       <jsp:param name="CODE_GUBUN"    value="SHR_DPT3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- �ٷα��� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Z2"/>
       <jsp:param name="CODE_GUBUN"    value="Z2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
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
            url = "../../../Ehr/hr/pir/pirc010.jsp";

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
    | 2. �̸� : trT_CM_PERSON                    |
    | 3. Table List : T_CM_PERSON                |
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- Ķ���� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)">  <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->






<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
				<td class="searchState" align="right">��������</td>
                <td class="padding2423" align="left">
                    <select id=cmbCLAS_CD_SHR style="WIDTH:100" >
                        <option value="A">����</option>
                        <option value="E">����</option>
                        <option value="">��ü</option>
                    </select>
                </td>
                <td align="right" class="searchState">����</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>

				<td class="searchState" align="right">�Ի�����</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtHIR_YMD_SHR" name="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtEND_YMD_SHR" name="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgEND_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkHIR_YMD_SHR" style="border:none">����
				</td>
            </tr>

            <tr>
                <td align="right" class="searchState">��</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD2_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>
                <td align="right" class="searchState">����/��Ʈ</td>
                <td class="padding2423" align="left">
                    <select id=cmbFIELD3_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>
                <td class="searchState" align="right">�׷��Ի�����</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIRG_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgHIRG_YMD_SHR" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIRG_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtENDG_YMD_SHR" name="txtENDG_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENDG_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgENDG_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtENDG_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkHIRG_YMD_SHR" style="border:none">����
				</td>
            </tr>

            <tr>
                <td align="right" class="searchState">�ٷα���</td>
                <td class="padding2423" align="left">
                    <select id=cmbSHAPE_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>
                <td align="right" class="searchState">����</td>
                <td class="padding2423" align="left">
                    <select id=cmbJOB_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>
				<td class="searchState" align="right">��������</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtJPR_YMD_SHR" name="txtJPR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJPR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgJPR_YMD_SHR" name="imgJPR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtJPR_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtENDJ_YMD_SHR" name="txtENDJ_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENDJ_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgENDJ_YMD_SHR" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtENDJ_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkJPR_YMD_SHR" style="border:none">����
				</td>
            </tr>


            <tr>
				<td class="searchState" align="right">����</td>
                <td class="padding2423" align="left">
                    <select id=cmbSEX_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>



                <td align="right" class="searchState">����</td>
                <td class="padding2423" align="left">
                    <select id=cmbYEAR_CD_SHR style="WIDTH:100" >
                        <option value="">��ü</option>
                    </select>
                </td>
				<td class="searchState" align="right">�������</td>
				<td class="padding2423" align="left" >
					<input type="text" id="txtRET_YMD_SHR" name="txtRET_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRET_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgRET_YMD_SHR" name="imgRET_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtRET_YMD_SHR','','134','108');"></a>
				    -
					<input type="text" id="txtENDR_YMD_SHR" name="txtENDR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENDR_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgENDR_YMD_SHR" name="imgENDR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtENDR_YMD_SHR','','134','108');"></a>
                    <input type="checkbox" id="chkRET_YMD_SHR" style="border:none">����
				</td>
            </tr>

		</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
                            <param name="DataID"                  		value="dsT_CM_PERSON">
                            <param name="EdiTABLE"                		value="false">
                            <param name="DragDropEnable"          	value="true">
                            <param name="SortView"                		value="right">
                            <param name="VIEWSUMMARY"             	value=0>
                            <param name="Format"                  		value="
                                <FC> id='{currow}'      width='45'  name='No'       			align='center' </FC>
								<FC> id='ENO_NO'		width='60'	name='���'					align='center' </FC>
								<FC> id='OCC_NM'		width='80'	name='�ٷ�\\����'			align='center' </FC>
								<FC> id='JOB_NM'		width='80'	name='����'					align='center' </FC>
								<FC> id='ENO_NM'		width='70'	name='����\\(�ѱ�)'			align='center' </FC>
								<C> id='NAM_ENG'		width='120'	name='����\\(����)'			align='left' </C>
								<C> id='NAM_CHI'		width='70'	name='����\\(����)'			align='center' </C>
								<C> id='MF_TAG'			width='60'	name='����'					align='center' value={if(MF_TAG='M','����',IF(MF_TAG='F','����',''))}</C>
								<C> id='BIR_YMD'		width='80'	name='����\\����'			align='center' </C>
								<C> id='BIR_NM'			width='70'	name='����\\����'			align='center' value={if(BIR_NM='��','���',IF(BIR_NM='��','����',''))}</C>
								<C> id='CET_NO'			width='120'	name='�ֹι�ȣ'				align='center' </C>
								<C> id='REG_NM'			width='80'	name='��������'				align='center' </C>
								<C> id='HEAD_NM'		width='100'	name='����'					align='left' </C>
								<C> id='DPT_NM'			width='120'	name='��'					align='left' </C>
								<C> id='TEAM_NM'		width='120'	name='��Ʈ/����'			align='left' </C>
								<C> id='DPA_YMD'		width='80'	name='�Ҽ�\\�߷���'			align='center' </C>

								<C> id='JPR_YMD'		width='80'	name='������'				align='center' </C>
								<C> id='DUTY_NM'		width='80'	name='��å'					align='center' </C>
								<C> id='JIKMU_NM'		width='80'	name='����'					align='center' </C>

								<C> id='FINJ_NM'		width='80'	name='��������'				align='center' </C>
								<C> id='HOB_NM'			width='100'	name='����'					align='center' Value={Decode(HOB_NM, 0, '',HOB_NM)}</C>
								<C> id='HIR_NM'			width='80'	name='ä��\\����'			align='center' </C>
								<C> id='HIR_YMD'		width='80'	name='�Ի���'				align='center' </C>
								<C> id='HIRG_YMD'		width='80'	name='�׷�\\�Ի���'			align='center' </C>
								<C> id='RETP_YMD'		width='80'	name='���\\������'			align='center' </C>								
								<C> id='PER_ADR'		width='280'	name='����'					align='left' </C>
								<C> id='ZIP_NO'			width='120'	name='�����ȣ\\(�)'		align='left' mask='XXX-XXX'</C>
								<C> id='ADR_CT'			width='220'	name='�ּ�1\\(�)'		align='left' </C>
								<C> id='ADDRESS'	 	width='220'	name='�ּ�2\\(�)'		align='left' </C>
								<C> id='RZI_NO'			width='120'	name='�����ȣ\\(�ǰ���)'	align='left' mask='XXX-XXX'</C>
								<C> id='RADR_CT'		width='220'	name='�ּ�1\\(�ǰ���)'		align='left' </C>
								<C> id='RADR'			width='220'	name='�ּ�2\\(�ǰ���)'		align='left' </C>
								<C> id='PHN_REG'		width='80'	name='������ȣ'				align='center' show = 'false'</C>
								<C> id='PHN_NO'			width='100'	name='��ȭ��ȣ'				align='center' </C>
								<C> id='EM_PHN_NO'		width='100'	name='�޴���'				align='center' </C>
								<C> id='HOBBY'			width='80'	name='���'					align='center' </C>
								<C> id='SPEC_CD'		width='80'	name='Ư��'					align='center' </C>
								<C> id='WED_YMD'		width='80'	name='��ȥ\\�����'			align='center' </C>
								<C> id='REL_NM'			width='80'	name='����\\����'			align='center' </C>
								<C> id='EDGR_NM'		width='80'	name='�з�\\����'			align='center' </C>
								<C> id='SCH_NM'			width='120'	name='�б�'					align='left' </C>
								<C> id='MAJ_NM'			width='120'	name='����'					align='left' </C>
								<C> id='GRD_NM'			width='80'	name='����\\����'			align='center' </C>
								<C> id='GUR_YMD'		width='80'	name='����\\����'			align='center' </C>
								<C> id='RET_YMD'		width='80'	name='����\\����'			align='center' </C>
								<C> id='RET_CD'			width='80'	name='����\\����'			align='center' show = 'false'</C>
								<C> id='MRE_AMT'		width='80'	name='�ߵ� ����'			align='center' show = 'false'</C>
								<C> id='LSE_YY'			width='80'	name='�ټӳ��'				align='center' </C>
								<C> id='HOL_YY'			width='80'	name='�����ϼ�'				align='center' show = 'false'</C>
								<C> id='NPN_GRD'		width='80'	name='���ο��� ���'		align='center' show = 'false'</C>
								<C> id='ABA_NM'			width='80'	name='�۱�����'				align='center' </C>
								<C> id='ACC_NO'			width='120'	name='�۱ݰ��¹�ȣ'			align='center' </C>
								<C> id='E_MAIL'			width='120'	name='E-Mail'				align='center' </C>
								<C> id='TAX_DPTNM'		width='200'	name='ȸ��Ҽ�'				align='left' </C>
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
