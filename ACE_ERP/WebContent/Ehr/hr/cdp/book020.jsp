<!--
*****************************************************
* @source       : BOOK020.jsp
* @description : �������԰�����Ȳ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/16      �̵���        �����ۼ�
*----------------------------------------------------
* 2016/06/01    |  ������   | �ҽ�����                                        *
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���� ���� ��Ȳ</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�

        var today = gcurdate;

        var dsTemp = window.dialogArguments;
        
        var curRowPosition = 0;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����(�Ⱓ)
			var BOOK_YMD_SHR = document.getElementById("txtBOOK_YMD_SHR").value;
			var BOOK_YME_SHR = document.getElementById("txtBOOK_YME_SHR").value;


            var app_yn = document.getElementById("cmbAPP_YN").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;


            if(!fnc_SearchItemCheck()) return;


            //��ȸ �ش����� �����Ѵ�.
            document.getElementById("hidTAG_YM").value = BOOK_YMD_SHR;

			dsT_DI_APPROVAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book020.cmd.BOOK020CMD"
					                                   + "&S_MODE=SHR"
					                                   + "&BOOK_YMD_SHR="+BOOK_YMD_SHR
					                                   + "&BOOK_YME_SHR="+BOOK_YME_SHR
					                                   + "&APP_YN_SHR="+app_yn
					                                   + "&DPT_CD="+DPT_CD
					                                   + "&OUR_MAN="+our_man;

			dsT_DI_APPROVAL.reset();

			//dsT_DI_APPROVAL.RowPosition = curRowPosition;


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
            document.getElementById("cmbAPP_YN").value ='';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("txtOUR_MAN_SHR").value = '';
            document.getElementById("txtOUR_MAN_NM_SHR").value = '';
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtBOOK_YMD_SHR").focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
				if (dsT_DI_APPROVAL.IsUpdated)  {
					if (!fnc_ExitQuestion()) return;
				}

				window.close();

            }else{
                window.close();
            }

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var BOOK_YMD_SHR = document.getElementById("txtBOOK_YMD_SHR").value; // ���۳��

            if(BOOK_YMD_SHR == ""){
                alert("�˻� �Ⱓ�� �Է��ϼ���!");
                document.getElementById("txtBOOK_YMD_SHR").focus();
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


        	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"true","true")      // Grid Style ����
        	
        	
        	dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();

		
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006"  && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001" ){ 
	            document.getElementById("hidDPT_CD_ORI").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// �Ҽ�
	            document.getElementById("txtDPT_CD_SHR").value = dsVI_T_PERSON.NameValue(0,"DPT_CD");// �Ҽ�
	            document.getElementById("txtDPT_NM_SHR").value = dsVI_T_PERSON.NameValue(0,"DPT_NM");// �Ҽ�
	
	            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
	            fnc_ChangeStateElement(false, "ImgDptCd");
			
			 }
		

            //CHECK_DATE!!!
            //â�� ������ ���糯¥�� ���� 15�� �� / ���ó�¥�� ������ �´�.
            var todayList   = getTodayArray();
            var book_ymd    = gcurdate;

            book_ymd     = addDate("M", gcurdate, -1);
            document.getElementById("txtBOOK_YMD_SHR").value = book_ymd; // �ش��� From
            book_ymd     = addDate("M", gcurdate, 1);
            document.getElementById("txtBOOK_YME_SHR").value = book_ymd; // �ش��� To

            fnc_SearchList();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

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
    | 1. ��ȸ�� DataSet(�ּ�)              |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)      |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)        |
    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
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




    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->



	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">


        var param = new String();

		curRowPosition = dsT_DI_APPROVAL.RowPosition;

        if(row < 1) {
        	
            return;
            
        } else {


			//���ϱٹ� param �� Setting
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                      //������ ����
	            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");

          		param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");

          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");

            }
			
            //������ ����
          	param.req_no    = dsT_DI_APPROVAL.NameValue(row, "RQST_NO");

            window.showModalDialog("../../hr/cdp/book011.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();


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
       <td height="35" class="paddingTop5">
           &nbsp;&nbsp;�� �ش� ���������� ����Ŭ���ϸ� ���γ����� ��ȸ�� �� �ֽ��ϴ�.
       </td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                                <col width="230"></col>
                                <col width="80"></col>
                                <col width="200"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">��û����&nbsp;</td>
                                <td class="padding2423">
									<input id="txtBOOK_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBOOK_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgBOOK_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBOOK_YMD_SHR','','70','110');"></a>--> ~
									<input id="txtBOOK_YME_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBOOK_YME_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgBOOK_YME_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBOOK_YME_SHR','','70','110');"></a>-->
                                    <input type="hidden" id="hidTAG_YM">
								</td>
								<td class="searchState" align="right">�������</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_YN" style="width:100" onChange="fnc_SearchList();">
			                            <option value="" >��ü</option>
			                            <option value="A" >���</option>
			                            <option value="R" >����</option>
			                            <option value="N" >�ΰ�</option>
			                            <option value="Y" >����Ϸ�</option>
			                        </select>
                                </td>
                            </tr>
				<tr class="paddingTop5" >
					<td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>


					<td class="padding2423">
                        <input id="hidDPT_CD_ORI" type="hidden">
						<input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
					</td>

					<!--
                    <td class="padding2423">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" class="input_ReadOnly"  readonly maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)">
	                    <img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                    </td>
                    -->

					<td class="searchState" align="right">������&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9"        onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR')">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
        <td style="padding-top:2px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:320px;">
                            <param name="DataID"                	value="dsT_DI_APPROVAL">
                            <param name="SortView"               value="Left">                            
                            <param name="Format"                	value="
                                <FC> id='{CUROW}'    		width=60    	name='NO'           	align=center    value={String(Currow)}</C>
                                <FC> id='APP_YN_NM' 			width=90   	name='���籸��'     	align=center </FC>
                                <FC> id='RQST_NO'  			width=90   	name='��û��ȣ'     	align=center	MASK='XXXXXX-XXXX'  </FC>
                                <FC> id='RQST_REMARK'  	width=550   name='����'         		align=left   </FC>
                                <FC> id='ORD_DATE'    		width=90   	name='�������'     	align=center    MASK='XXXX-XX-XX' </FC>
                                <C>  id='PENO_NM'    			width=80    	name='�����'       	align=center  </C>
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