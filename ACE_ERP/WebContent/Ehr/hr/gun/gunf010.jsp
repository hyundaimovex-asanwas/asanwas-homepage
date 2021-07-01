<!--
*****************************************************
* @source       : gunf010.jsp
* @description : ���κ� �ٹ� ��Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/12/11      �̵���        ���� �ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���κ� �ٹ� ��Ȳ</title>
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


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����
        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;  	
			
			var eno_no = document.form1.txtENO_NO_SHR.value;	//���

			dsT_DI_OVERTIMEWORK.ClearData();
			
			//����� ������ ��ȸ����.
			if(eno_no == ""){
				
				alert("����� �Է��ϼ���.");
				
	            document.form1.txtENO_NO_SHR.focus();

				return;
        	}
			
			
			dsT_DI_OVERTIMEWORK.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf010.cmd.GUNF010CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PIS_YM="+PIS_YM.replace("-","");
			//prompt(this,dsT_DI_OVERTIMEWORK.dataid );
			dsT_DI_OVERTIMEWORK.reset();

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

			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
            if (dsT_DI_OVERTIMEWORK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_OVERTIMEWORK.GridToExcel("���κ� �ٹ� ��Ȳ", '', 225);

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

        	
			document.getElementById("txtENO_NO_SHR").value=gusrid;
			document.getElementById("txtENO_NM_SHR").value=gusrnm;        	
        	
			cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,15,"false","false");      // Grid Style ����

            document.getElementById("txtPIS_YM_SHR").value = gcurdate.substring(0,7);			
			
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2070019"){ 
				
			    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
		    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");

	    	}else{

	            fnc_ChangeStateElement(false, "ImgEnoNoSHR");
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

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
               //fnc_SearchList();
        }

        function fnc_Getcd() {
               fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
               //fnc_SearchList();
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
    | 2. �̸� : dsT_DI_OVERTIMEWORK                 |
    | 3. Table List : T_DI_OVERTIMEWORK             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
		<PARAM NAME="SubsumExpr"	  VALUE="total,1:WEEK_NO">        
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>




    <Object ID="dsT_DI_WEEKNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_OVERTIMEWORK)|
    | 3. ���Ǵ� Table List(T_DI_OVERTIMEWORK)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERTIMEWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_OVERTIMEWORK.focus();
        }

    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_OVERTIMEWORK Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_OVERTIMEWORK event="OnDblClick(row,colid)">


	</script>


    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_OVERTIMEWORK Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_OVERTIMEWORK event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- Ķ���� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
   	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                                <col width="50"></col>
                                <col width="250"></col>
                                <col width="150"></col>                                
                                <col width="*"></col>
                            </colgroup>
                            <tr>

			                    <td align="center" class="blueBold">�ش��</td>
								<td class="padding2423" align="left">
									<input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								</td>  

                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13){fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13){fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', document.getElementById('txtPIS_YM_SHR').value, document.getElementById('txtPIS_YM_SHR').value);"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="66%" height="20"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:450px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="							
								<C> id='WEEK_NO'		width=50			name='����'					align=center			suppress=1 Value={Decode(CurLevel,1,'�Ұ�',WEEK_NO)}</C> 								
								<C> id='DPT_NM'			width=120			name='�Ҽ�'					align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='ENO_NM'			width=80			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='HOL_YN'			width=50			name='����'					align=center			show=false</C>
								<C> id='REG_YMD'		width=100			name='����'					align=center			MASK='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='YOIL'			width=50			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='GUBUN'			width=80			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='STR_TIME'		width=100			name='�ٹ�����'				align=center			</C>
								<C> id='END_TIME'		width=100			name='�ٹ�����'				align=center			</C>		
								<C> id='WRK_TIME'		width=100			name='�ٹ��ð�'				align=center			DEC=1</C>			
								<C> id='WEEK_TOT_TIME'	width=100			name='����\\�ٷνð�'			align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='REMARK'			width=300			name='����'					align=left			</C>
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


<!-- ��ȸ ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�ٹ� �ð� ����</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >�ش� �� ����</td>
                    <td class="padding2423" align="left">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="12" maxlength="10" class="input_ReadOnly" readonly > ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="12" maxlength="10" class="input_ReadOnly" readonly >
                    </td>
                    <td align="center" class="blueBold">�� ���� �ð�</td>
                    <td class="padding2423" >
                        <input id="txtWEEK_TOTAL_TIME" name="txtWEEK_TOTAL_TIME" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">��û���� �ð�</td>
                    <td class="padding2423" >
                        <input id="txtPOSIBLE_TIME" name="txtPOSIBLE_TIME" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>                    
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->


</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

