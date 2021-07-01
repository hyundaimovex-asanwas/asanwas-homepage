<!--
*****************************************************
* @source       : vlul010.jsp
* @description  : �������ۼ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2014/11/13     �̵���        ����
* 2016/07/05     �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<% String ENO_NO     = request.getParameter("ENO_NO"); %>

<html>
<head>
<title>�������ۼ�</title>
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



        
	    var dsTemp = window.dialogArguments;
	    
        var GUBUN   = "";

    	var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
			var ENO_NO = document.form1.txtENO_NO_SHR.value;			//���

			fnc_Term_Query(REG_YM_SHR);

			trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_HWORKMST=dsT_EV_HWORKMST)";
			trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD"
                                   + "&S_MODE=SHR"
                                   + "&REG_YM_SHR="+REG_YM_SHR
                                   + "&ENO_NO="+ENO_NO;
			trT_EV_ABLRST.post();

			if(dsT_EV_HWORKMST.countrow<1){
				fnc_AddNew();
			}else{
		        ifrm.fnc_Row_Clear(2); //�ʱ�ȭ
			}

			ifrm.fnc_SearchList();

        }


		function fnc_Term_Query(REG_YM_SHR){

			var evaym = REG_YM_SHR.substr(2,2)+REG_YM_SHR.substr(5,7);

	        dsT_EV_TERM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_TERM&evaym="+evaym;
	        dsT_EV_TERM.reset();

			document.form1.txt_term.value = dsT_EV_TERM.namevalue(dsT_EV_TERM.rowposition,"COMM_NM");

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

          	var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵

			if(REG_YM_SHR!='2016-11'){

					alert("�������� Ȯ�� �Ͻʽÿ�.");

					return false;
			}


			if(!ifrm.fnc_Save_Chk()) return;

			if (confirm("�����Ͻðڽ��ϱ�?")) {

				ifrm.fnc_Save();

			}

			fnc_SearchList();
			


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
			ifrm.fnc_Print();
            
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
          	var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          	var EMPNO 	= document.form1.txtENO_NO_SHR.value;           //�ǰ����

		  	if(REG_YM_SHR!='2016-11'){
				alert("�������� Ȯ�� �Ͻʽÿ�.");
				return false;
			}

			if(!fnc_Add_Chk()) false;

            trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_00&EMPNO="+EMPNO;
            trT_EV_ABLRST.post();

		  	i = dsT_EV_ABLRST.rowposition;

		  	fnc_SetDataHeader();

		  	dsT_EV_HWORKMST.Addrow();

			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EVAYM")   = REG_YM_SHR;
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EMPNO")   = dsT_EV_ABLRST.namevalue(i,"ENO_NO");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EMPNMK")  = dsT_EV_ABLRST.namevalue(i,"ENO_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"HEADCD")  = dsT_EV_ABLRST.namevalue(i,"HEAD_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"HEADNM")  = dsT_EV_ABLRST.namevalue(i,"HEAD_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DIVCD")   = dsT_EV_ABLRST.namevalue(i,"DPT_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DIVNM")   = dsT_EV_ABLRST.namevalue(i,"DPT_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DEPTCD")  = dsT_EV_ABLRST.namevalue(i,"TEAM_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DEPTNMK") = dsT_EV_ABLRST.namevalue(i,"TEAM_NM");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"PAYGRD")  = dsT_EV_ABLRST.namevalue(i,"JOB_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"PAYGRDNM")= dsT_EV_ABLRST.namevalue(i,"JOB_NM");

			ifrm.fnc_Row_Clear(2); //�ʱ�ȭ
        }


        /******************
         * 07. ��¥ �ű� �Լ�  *
         ******************/
        function fnc_New() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            //�˻����� 2����
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
			var EMPNO = document.form1.txtENO_NO_SHR.value;				//���

			fnc_Clear();

 			ifrm.fnc_Row_Clear(2);

          	document.form1.txtREG_YM_SHR.value = '2016-11';
          	document.form1.txt_term.value = '2016.01.01~2016.11.30';

			if(!fnc_Add_Chk()){
				fnc_SearchList();
			}else{

			}

        }

		/******************************************************************************
			Description : �߰��� üũ ���� ����Ÿ ����� �߰� ����.
		******************************************************************************/
		function fnc_Add_Chk(){

            //�˻����� 2����
            var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
			var ENO_NO = document.form1.txtENO_NO_SHR.value;			//���

	        dsT_EV_HWORKCHK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul010.cmd.VLUL010CMD&S_MODE=SHR_CHK&REG_YM_SHR="+REG_YM_SHR+"&ENO_NO="+ENO_NO;
	        dsT_EV_HWORKCHK.reset();

			if(dsT_EV_HWORKCHK.namevalue(1,"CNT")>0){
				alert("�̹� ����Ÿ�� �����մϴ�. ��ȸ �� �����Ͻʽÿ�.");
				return false;
			}

			return true;
		}


		/******************************************************************************
			Description : ����Ÿ�� ��� ����
		******************************************************************************/
		function fnc_SetDataHeader(){

		      //�����Ű�MST
			if (dsT_EV_HWORKMST.countrow<1){
						  var s_temp = " EVAYM:STRING(7),EMPNO:STRING(7),EMPNMK:STRING(30),HEADCD:STRING(4),HEADNM:STRING(50),"
									 + " DIVCD:STRING(4),DIVNM:STRING(50),DEPTCD:STRING(4),DEPTNMK:STRING(50),PAYGRD:STRING(4),PAYGRDNM:STRING(50), "
									 + " WORK_1:STRING(50),STARTDT_1:STRING(8),ENDDT_1:STRING(8),PLACE_1:STRING(50),REMARK_1:STRING(100),"
									 + " WORK_2:STRING(50),STARTDT_2:STRING(8),ENDDT_2:STRING(8),PLACE_2:STRING(50),REMARK_2:STRING(100),"
									 + " WORK_3:STRING(50),STARTDT_3:STRING(8),ENDDT_3:STRING(8),PLACE_3:STRING(50),REMARK_3:STRING(100),"
									 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
			  dsT_EV_HWORKMST.SetDataHeader(s_temp);
			}
		}

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        	
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        	ifrm.fnc_Add();

            
        }




        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
 			ifrm.fnc_Delete();
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //dsT_EV_HWORKMST.ClearData();

            document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            
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

		document.getElementById("txtREG_YM_SHR").value = '2016-11';

		
        if(dsTemp != "Modal"){ //�˾��� �ƴѰ��
            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;	
        }else{ //�˾��� ���
            document.getElementById("txtENO_NO_SHR").value = ENO_NO;
            fnc_GetNm();
        }	  		
		
    //����ȣCJ, �̻�GJ�� ��ȸ�����ϵ���

    	if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2020008" && gusrid != "2070020"){ 
    	
    	
			fnc_ChangeStateElement(false, "txtENO_NO_SHR");
			fnc_ChangeStateElement(false, "txtENO_NM_SHR");
			fnc_ChangeStateElement(false, "ImgEnoNo");


    	}


		fnc_SearchList();


        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
            fnc_SearchList();
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

    <Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKDTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKCHK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TERM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="20" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			&nbsp;&nbsp;&nbsp;	&nbsp;		
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="160"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly"  readOnly maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="120"></col>
					<col width="80"></col>
					<col width="60"></col>
					<col width="180"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="60"></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold" rowspan = 2>�� ��</td>
					<td align="center" class="blueBold" rowspan = 2>�� ��</td>
					<td align="center" class="blueBold" rowspan = 2>�� ��</td>

		            <td align="center" class="blueBold" colspan=3><nobr>�λ� �̵� ���� (���Ⱓ : 
		            		<input id="txt_term"  type="text" style= "position:center;left:0px;width:135px;height:20px;" ReadOnly>)</nobr></td>
					<td align="center" class="blueBold" rowspan = 2>�� ��</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">�ٹ� �Ⱓ</td>
					<td align="center" class="blueBold">�Ҽ���</td>
					<td align="center" class="blueBold">��� ����</td>
				</tr>
        		<tr>
					<td class="tab15" style=""rowspan=3>
					  <input id="txt_evaym"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_divcd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_deptcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_divnm"   type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_deptnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
					</td>
					<td class="tab18" style=""rowspan=3 align="center"><nobr>
					  <input id="txt_paygrd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width5px;height:20px;" ReadOnly>
						<input id="txt_paygrdnm" type="text"     class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style=""rowspan=3 align="center"><nobr>
						<input id="txt_empno"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_empnmk"  type="text"     class="txtbox"  style= "position:relative;left:0px;top:0px;width:55px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style="" align="center"><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=1>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=1>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</nobr></td>
					<td class="tab18" style="" align="center">
						<nobr><input id="txt_place_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:120px;height:20px;" ></nobr>
					</td>
					<td class="tab18" style="" align="center">
						<nobr><input id="txt_work_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ></nobr>
					</td>
          			<td class="tab18" style="" align="center">
          				<nobr><input id="txt_remark_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ></nobr>
				   </td>
				</tr>

				<tr>
					<td class="tab18" style="" align="center"><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 	 <comment id="__NSID__">
						 <object id=gcem_enddt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
							<input id="txt_place_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:120px;height:20px;" >
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
            		<input id="txt_work_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
          			</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
					    <input id="txt_remark_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>
				</tr>
				<tr>
					<td class="tab18" style="" align="center"><nobr>
						<comment id="__NSID__">
						<object id=gcem_startdt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>&nbsp; ~
  					 <comment id="__NSID__">
						 <object id=gcem_enddt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">
											<param name=Text					value="">
											<param name=Alignment     		value=0>
											<param name=Border        		value=true>
											<param name=Format        		value="YYYY/MM/DD">
											<param name=PromptChar    		value="_">
											<param name=BackColor     		value="#CCCCCC">
											<param name=InheritColor  		value=false>
						 </object></comment><script> __ShowEmbedObject(__NSID__); </script>

					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
						 <input id="txt_place_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:120px;height:20px;" >
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
						<input id="txt_work_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>

					<td class="tab18" style="" align="center"><nobr>
						 <input id="txt_remark_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>
				</tr>


			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td valign="top" width="300" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					<td valign="top" width="550" >* ���� �򰡱��� : S(��ǥ110%�̻�޼�), A(100%�̻�), B(90%�̻�), C(80%�̻�), D(80%�̸�)</td>					
					<td align="right">  <!-- �߰� ���� ��ư -->
						<img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)" style="cursor:hand;">
						<img src="../../images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_RemoveOver.gif',1)" style="cursor:hand;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->




<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000"  border="1" cellspacing="0" cellpadding="0" bordercolor="#999999">
 
	<tr >
		<td style="padding-top:1px;">
			<table border=1 cellspacing="0" cellpadding="0" height="10px">
				<tr>
					<td align="center" class="blueBold" width="40px"  ROWSPAN="2">No</td>
					<td align="center" class="blueBold" width="100px" ROWSPAN="2">�� ��</td>
					<td align="center" class="blueBold" width="600px" ROWSPAN="2">�ֿ� ���� ����</td>
					<td align="center" class="blueBold" width="270px" colspan="3">���� ��</td>
				</tr>
				<tr>
					<td align="center" class="blueBold" width="90px" >����ġ(%)</td>
					<td align="center" class="blueBold" width="90px" >�����Է�</td>
					<td align="center" class="blueBold" width="90px" >ȯ������</td>
				</tr>
			</table>
		</td>
	</tr>


	<tr>
	 <td >
		<iframe id="ifrm" name="ifrm" src="./vlul010_ifrm.jsp" frameborder=0 style="position:relative;top:1px;width:1000;height:370px;border:1 solid #708090;"></iframe>
	 </td>
	</tr>

</table>


<!-- ���� ��ȸ �׸��� ���̺� ��-->
	<tr>
	 <td > <br> </td>
		<td align="left" class="blueBold">
			<font color="blue" size="2" bold="5" face = "Verdana"">�� ����ġ�� �� �հ�� </font>
			<font color="red" size="2" bold="5" face = "Verdana"">100% </font>
			<font color="blue" size="2" bold="5" face = "Verdana"">�� �ǵ���, ������ </font>
			<font color="red" size="2" bold="5" face = "Verdana"">S,A,B,C,D �� �����Ͽ�</font>
			<font color="blue" size="2" bold="5" face = "Verdana"">�Է��� �ֽñ� �ٶ��ϴ�. ȯ�������� </font>
			<font color="red" size="2" bold="5" face = "Verdana"">���� �� �ڵ����</font>
			<font color="blue" size="2" bold="5" face = "Verdana"">�˴ϴ�.
				<br>&nbsp;&nbsp;&nbsp;���� ���� �Ű� �ۼ� �ڷ�� �������� ���� ��(ex:2016-07 or 2015-11) ��ȸ�����մϴ�.
			</font>
		</td>
	 </td>
	</tr>
	
</form>
<!-- form �� -->


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!--  ���̺� -->
<object id="bndT_EV_HWORKMST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_HWORKMST">
	<Param Name="BindInfo", Value='
		<C>Col=EVAYM      		ctrl=txt_evaym		  		param=value	 </C>
		<C>Col=EMPNO      		ctrl=txt_empno		  		param=value	 </C>
		<C>Col=EMPNMK     	ctrl=txt_empnmk		  	param=value	 </C>
		<C>Col=HEADCD     		ctrl=txt_headcd		  		param=value	 </C>
		<C>Col=HEADNM     	ctrl=txt_headnm		  	param=value	 </C>
		<C>Col=DIVCD      		ctrl=txt_divcd		  		param=value	 </C>
		<C>Col=DIVNM      		ctrl=txt_divnm		  		param=value	 </C>
		<C>Col=DEPTCD     		ctrl=txt_deptcd     		param=value	 </C>
		<C>Col=DEPTNMK    	ctrl=txt_deptnm		  	param=value	 </C>
		<C>Col=PAYGRD     		ctrl=txt_paygrd     		param=value	 </C>
		<C>Col=PAYGRDNM   	ctrl=txt_paygrdnm   		param=value	 </C>
		<C>Col=WORK_1     	ctrl=txt_work_1     		param=value	 </C>
		<C>Col=STARTDT_1  	ctrl=gcem_startdt_1 	param=text   </C>
		<C>Col=ENDDT_1    	ctrl=gcem_enddt_1	  	param=text	 </C>
		<C>Col=PLACE_1    		ctrl=txt_place_1    		param=value	 </C>
		<C>Col=REMARK_1		ctrl=txt_remark_1 		param=value	 </C>
		<C>Col=WORK_2     	ctrl=txt_work_2     		param=value	 </C>
		<C>Col=STARTDT_2  	ctrl=gcem_startdt_2 	param=text   </C>
		<C>Col=ENDDT_2    	ctrl=gcem_enddt_2	  	param=text	 </C>
		<C>Col=PLACE_2    		ctrl=txt_place_2    		param=value	 </C>
		<C>Col=REMARK_2		ctrl=txt_remark_2 		param=value	 </C>
		<C>Col=WORK_3     	ctrl=txt_work_3     		param=value	 </C>
		<C>Col=STARTDT_3  	ctrl=gcem_startdt_3 	param=text   </C>
		<C>Col=ENDDT_3    	ctrl=gcem_enddt_3	  	param=text	 </C>
		<C>Col=PLACE_3    		ctrl=txt_place_3    		param=value	 </C>
		<C>Col=REMARK_3		ctrl=txt_remark_3 		param=value	 </C>
    '>
</object>




