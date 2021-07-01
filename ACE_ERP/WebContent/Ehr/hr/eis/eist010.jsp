<!--
***********************************************************************
* @source      : eist010.jsp
* @description : Ÿ�ӽ�Ʈ ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/01/09            �̵���            	ERP�̻�						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>Ÿ�ӽ�Ʈ ���</title>
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


        var today = gcurdate;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			var eno_no = document.getElementById('txtENO_NO_SHR').value;
			
			trT_TS_TIMESHEET.KeyValue = "tr05(O:dsT_TS_TIMESHEET=dsT_TS_TIMESHEET)";
			
			trT_TS_TIMESHEET.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist010.cmd.EIST010CMD&S_MODE=SHR"
																			            + "&PIS_YM="+pis_ym
																			            + "&ENO_NO="+eno_no;			

			trT_TS_TIMESHEET.post();    		

			
			
			//chk = chk + parseInt(dsT_TS_TIMESHEET.NameValue(j, dsT_TS_TIMESHEET.columnid(i+3)));
			var chk = 0;
			
    		for(var i=1; i <= dsT_TS_TIMESHEET.CountRow; i++) {				
			
    			if(dsT_TS_TIMESHEET.NameValue(i, "STATUS") == "R" || dsT_TS_TIMESHEET.NameValue(i, "STATUS") == "Y"){
    				
    				chk = chk + 1;
    				
    			}
    			
    		}
    		
    		//������°� �ƴϸ� == ����̳� �Ϸ�����̸� ȭ���� edit false
    		if(chk != 0){
    		
				cfStyleGrid_New(form1.grdT_TS_TIMESHEET,15,"false","true");      // Grid Style ����
				
    		}else{
        		

    			cfStyleGrid_New(form1.grdT_TS_TIMESHEET,15,"true","true");      // Grid Style ����
 			
        	}			
			
			
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

			//if(!fnc_SaveItemCheck()) fnc_SearchList();	//��ȿ�� üũ

			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			var eno_no = document.getElementById('txtENO_NO_SHR').value;			
			
			trT_TS_TIMESHEET.KeyValue = "tr01(I:dsT_TS_TIMESHEET=dsT_TS_TIMESHEET)";

			trT_TS_TIMESHEET.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist010.cmd.EIST010CMD&S_MODE=SAV"
																					            + "&PIS_YM="+pis_ym
																					            + "&ENO_NO="+eno_no;						

			//prompt(this, trT_TS_TIMESHEET.action);
			
			trT_TS_TIMESHEET.post();

			fnc_SearchList();

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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_TS_TIMESHEET.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_TS_TIMESHEET.GridToExcel("Ÿ�ӽ�Ʈ��Ȳ", '', 225);
			
			
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
        function fnc_SearchItemCheck() {

        	
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	for(var i=0; i < dsT_TS_TIMESHEET.CountColumn; i++) {
        	
        		var chk = 0;

        		for(var j=1; j <= dsT_TS_TIMESHEET.CountRow; j++) {	

        			chk = chk + parseInt(dsT_TS_TIMESHEET.NameValue(j, dsT_TS_TIMESHEET.columnid(i+3)));
	
        		}
        		
        	}
        	
			return true;
			
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

        	var chk = 0;
            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;            
            
            if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2020009" && gusrid != "2010005" && gusrid != "2030009" && gusrid != "2030003"){ 

	         	fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgEnoNo");

			  }            
            

			fnc_SearchList();
			

    		for(var i=1; i <= dsT_TS_TIMESHEET.CountRow; i++) {				
			
    			if(dsT_TS_TIMESHEET.NameValue(i, "STATUS") == "R" || dsT_TS_TIMESHEET.NameValue(i, "STATUS") == "Y"){
    				
    				chk = chk + 1;
    				
    			}
    			
    		}
    		

    		//������°� �ƴϸ� == ����̳� �Ϸ�����̸� ȭ���� edit false
    		if(chk != 0){
    		
				cfStyleGrid_New(form1.grdT_TS_TIMESHEET,15,"false","true");      // Grid Style ����			
			
			
        	}else{
        		
    			cfStyleGrid_New(form1.grdT_TS_TIMESHEET,15,"true","true");      // Grid Style ����
    			
        	}
    		
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		
        /*****************
         * 16.  ���ó��   *
         ****************/
        function fnc_Conduct() {

            if (!confirm("����Ͻðڽ��ϱ�?\n\n����� �ڿ��� ������ �� �����ϴ�.\n\n���� �ݷ��� ���������մϴ�.")){
	            
            	return;
            	
            }else{
            	
			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			var eno_no = document.getElementById('txtENO_NO_SHR').value;			
			
			dsT_TS_TIMESHEET.UserStatus(1) = 1; //���� ������ ���� ����			
			
			trT_TS_TIMESHEET.KeyValue = "tr01(I:dsT_TS_TIMESHEET=dsT_TS_TIMESHEET)";

			trT_TS_TIMESHEET.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist010.cmd.EIST010CMD&S_MODE=UPT"
																					            + "&PIS_YM="+pis_ym
																					            + "&ENO_NO="+eno_no;						

			//prompt(this, dsT_TS_TIMESHEET.text);
			
			trT_TS_TIMESHEET.post();
            
            
            }

			fnc_SearchList();
            
        }		
		
		
        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */

        function fnc_GetNm() {
        	 
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_TS_TIMESHEET)   |
    | 3. ���Ǵ� Table List()		     |
    +------------------------------------------------>
    <Object ID="dsT_TS_TIMESHEET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">  
    </Object>


    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_TS_TIMESHEET)	    |
    | 3. ���Ǵ� Table List()	            |
    +--------------------------------------------------->
    <Object ID ="trT_TS_TIMESHEET" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
			<Param Name=KeyValue 	Value="sample_tr01(O:dsT_TS_TIMESHEET=dsT_TS_TIMESHEET)">            
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_TS_TIMESHEET Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_TS_TIMESHEET Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_TS_TIMESHEET Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_TS_TIMESHEET event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_TS_TIMESHEET event="OnFail()">
        cfErrorMsg(this);
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
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)"><img src="../../images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();"></a>
			&nbsp;&nbsp;
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
				
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>

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
									<col width="60"></col>
									<col width="100"></col>
									<col width="60"></col>
									<col width="*"></col>									
								</colgroup>
							<tr>
								<td align="right" class="searchState">�� ��&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13)cfNumberCheck();">
								</td>
								<td align="right" class="searchState">�� ��&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}"  style="ime-mode:disabled"   >
					                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}"   >
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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

<BR>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_TIMESHEET" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_TIMESHEET">
                            <param name="Editable"    				value="true">	
							<PARAM NAME="BorderStyle"				VALUE="0">
							<PARAM NAME="Indwidth"					VALUE="0">
							<PARAM NAME="Fillarea"					VALUE="true">
							<param name="VIEWSUMMARY"			    value=1>
							<PARAM NAME="Colsizing"					VALUE="true">                            			
                            <param name="Format"					value='
								<C> id={currow}		width=25    name="No"		    	align=center SumBgColor=#C3D0DB </C>
								<C> id="PJT_CD"	    width=140	name="������Ʈ�ڵ�"	    align=center show=false</C>								
								<C> id="PJT_NM"	    width=120	name="������Ʈ��"	        align=left suppress=1 SumBgColor=#C3D0DB SubSumText="�հ�" </C>

                                <C> id="DAY_01"		width=25	name="1"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_01,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_02"		width=25	name="2"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_02,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_03"		width=25	name="3"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_03,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_04"		width=25	name="4"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_04,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_05"		width=25	name="5"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_05,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_06"     width=25	name="6"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_06,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_07"     width=25	name="7"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_07,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_08"     width=25	name="8"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_08,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_09"     width=25	name="9"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_09,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_10"     width=25	name="10"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_10,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_11"     width=25	name="11"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_11,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_12"     width=25	name="12"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_12,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_13"     width=25	name="13"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_13,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_14"     width=25	name="14"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_14,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_15"     width=25	name="15"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_15,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_16"     width=25	name="16"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_16,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_17"     width=25	name="17"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_17,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_18"     width=25	name="18"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_18,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_19"     width=25	name="19"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_19,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_20"     width=25	name="20"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_20,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_21"     width=25	name="21"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_21,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_22"     width=25	name="22"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_22,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_23"     width=25	name="23"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_23,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_24"     width=25	name="24"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_24,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_25"     width=25	name="25"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_25,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_26"     width=25	name="26"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_26,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_27"     width=25	name="27"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_27,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_28"     width=25	name="28"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_28,"1","#EBF7FF","2","#FFEAEA","#FFFFFF")}</C>
                                <C> id="DAY_29"     width=25	name="29"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_29,"1","#EBF7FF","2","#FFEAEA","9","#191919","#FFFFFF")}</C>
                                <C> id="DAY_30"     width=25	name="30"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_30,"1","#EBF7FF","2","#FFEAEA","9","#191919","#FFFFFF")}</C>
                                <C> id="DAY_31"     width=25	name="31"		align=center    decao=0 SumBgColor=#C3D0DB SumText=@sum	BgColor={Decode(YOIL_31,"1","#EBF7FF","2","#FFEAEA","9","#191919","#FFFFFF")}</C>
                                <C> id="STATUS"     width=45	name="����"		align=center    EditStyle=Combo Data="S:����,R:���,Y:����" AlwaysShowEditStyle=false</C>
							
							'>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->


<!-- �ȳ� ���� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            �� <b>�Է¹��</b><br> 
		       &nbsp;&nbsp;1. �Ϸ� 8�ð��� �������� �ٹ��ð��� ����Ͽ� �Է��մϴ�.(EX  ���������:4, ���� �� ����Ȱ��:4 )<br>  
		       &nbsp;&nbsp;2. Min : 0 (������) ~ MAX : 24 (���, �����)<br> 
			   &nbsp;&nbsp;3. ������ ��� �ϼ����� �� <b>"���"</b> ��ư�� �����ּ���.<br> 
            </td>
        </tr>
</table>
<!-- �ȳ� ���� ��-->

</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




