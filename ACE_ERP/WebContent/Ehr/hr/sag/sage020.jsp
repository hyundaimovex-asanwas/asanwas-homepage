<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ �ý��۸� : �Ĵ���� - �Ĵ���
+ ������� : �Ĵ� ��� ��ȸ�Ѵ�.
+ ���α׷�ID : sage020.jsp
+ ������� :
+ �� �� �� : �� �� ��
+ �ۼ����� : 2016.03.14
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.DateUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�Ĵ� ���</title>
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

		var year = gcurdate.substring(0,4);

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			//���� ��ȸ

			dsT_SA_PAYMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage020.cmd.SAGE020CMD&S_MODE=SHR"
																				+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
																				+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value
																				+ "&ENO_NO=" + document.getElementById("txtENO_NO_SHR").value;

			dsT_SA_PAYMASTER.reset();




        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_SA_PAYMASTER.KeyValue = "tr01(I:dsT_SA_PAYMASTER=dsT_SA_PAYMASTER)";
			trT_SA_PAYMASTER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage020.cmd.SAGE020CMD&S_MODE=SAV";
			trT_SA_PAYMASTER.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {


    		if (dsT_SA_PAYMASTER.countrow<1) {
    			alert("����Ͻ� ������ �����ϴ�");
    		} else {

    			dsT_RP_REPORT.clearall();

    		var ls_temp = "";



            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_RP_REPORT.CountColumn == 0) {
            	dsT_RP_REPORT.setDataHeader("WRK_YM:STRING, ");

            	//dsT_RP_REPORT.setDataHeader("WRK_YM:STRING, SITE_CD:STRING, SITE_NM:STRING, ENO_NM:STRING, CET_NO:STRING, INT_AGE:DECIMAL, WRK_AMT:DECIMAL, WRK_DAY:DECIMAL, WRK_PAY:DECIMAL, INCM_TAX:DECIMAL, CITI_TAX:DECIMAL, NPEN_AMT:DECIMAL, HINU_AMT:DECIMAL, HINS_AMT:DECIMAL, SUB_SUM:DECIMAL, ACT_AMT:DECIMAL, NPEN_CAMT:DECIMAL, HINU_CAMT:DECIMAL, HINS_CAMT:DECIMAL, SAN_CAMT:DECIMAL,SUB_CSUM:DECIMAL, FINAL_AMT:DECIMAL");
            	dsT_RP_REPORT.setDataHeader("WRK_YM:STRING,SITE_CD:STRING,SITE_NM:STRING,ENO_NM:STRING,REMARK:STRING,CET_NO:STRING,BNK_NM:STRING,ACC_NO:STRING,INT_AGE:DECIMAL,PH_NO:STRING,ADDRESS:STRING,WRK_AMT:DECIMAL,WRK_DAY:STRING,CNT:STRING,WRK_PAY:DECIMAL,INCM_TAX:DECIMAL,CITI_TAX:DECIMAL,NPEN_AMT:DECIMAL,HINU_AMT:DECIMAL,HINS_AMT:DECIMAL,SUB_SUM:DECIMAL,ACT_AMT:DECIMAL,NPEN_CAM:DECIMALT,HINU_CAMT:DECIMAL,HINS_CAMT:DECIMAL,SAN_CAMT:DECIMAL,SUB_CSUM:DECIMAL,FINAL_AMT:DECIMAL,APP_YN:STRING");
            }

    		dsT_RP_REPORT.ImportData(dsT_SA_PAYMASTER.ExportData(1,dsT_SA_PAYMASTER.countrow,false));

			var yyyy = document.getElementById("txtPIS_YYMM_SHR").value.substring(0,4);
			var mm = document.getElementById("txtPIS_YYMM_SHR").value.substring(5,7);

			for(i=1;i<=dsT_RP_REPORT.countrow;i++){

				if(dsT_RP_REPORT.namevalue(i,"WRK_DAY") == '0'){

					dsT_RP_REPORT.namevalue(i,"ENO_NM")="";

					dsT_RP_REPORT.namevalue(i,"SITE_NM")="                               �� ��";
					dsT_RP_REPORT.namevalue(i,"WRK_DAY")='';
					dsT_RP_REPORT.namevalue(i,"CNT")='';
					dsT_RP_REPORT.namevalue(i,"WRK_AMT")='';


				}

			}

    		fnc_RptFormat(yyyy,mm);

    		ReportID.SuppressColumns ="1:SITE_NM";

    		ReportID.Preview();

    		}


        }


        /******************************************************************************
				Description :  ��¹� ���� �ۼ�
		******************************************************************************/
		function fnc_RptFormat(yyyy,mm){

			var ls_for = "";

			ls_for += "<B>id=Header ,left=0,top=0 ,right=2900 ,bottom=120 ,face='Tahoma' ,size=10 ,penwidth=1";

			ls_for += "<T>id=''"+yyyy+"'�� '"+mm+"'�� �Ͽ�빫�� ������' ,left=800 ,top=0 ,right=2400 ,bottom=90 ,face='Tahoma' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

			ls_for += "<L> left=1180 ,top=100 ,right=2000 ,bottom=100 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>";

			//ls_for += "<I>id='"+rDOMAIN+"/common/img/icon.jpg' ,left=2550 ,top=1880 ,right=2800 ,bottom=1970</I>";

			ls_for += "<T>id='Page : #p of #t' ,left=950 ,top=1900 ,right=2000 ,bottom=2000 ,align='center' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

			ls_for += "</B>";




			ReportID.format = ls_for + ReportID.format ;

			//prompt(this, ReportID.format);


		}


		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_SA_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_SA_PAYMASTER.GridToExcel("�빫����Ȳ", '', 225);


        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {

		}

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {

        }



		/********************************************
         * 09. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {


		}

		/********************************************
         * 10. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_SA_PAYMASTER.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
        	window.close();

        }

		/********************************************
         * 11. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 12. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( !dsT_SA_PAYMASTER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            //��¥���� ���ε�
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, 0);
            
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // �ش��� To


			//���� ��� �����¸� �����°� ����
			var YYMM = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");

			if(YYMM.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}

            cfStyleGrid_New(form1.grdT_SA_PAYMASTER,0,"false","true");      // Grid Style ����



        }

		/********************************************
         * 14. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


		/******************************************************************************
		* 15.  �Ĵ� ���
		******************************************************************************/
	  	function fnc_Creat(){

				var yy = document.getElementById("txtPIS_YYMM_SHR").value.substring(0,4);
				var mm = document.getElementById("txtPIS_YYMM_SHR").value.substring(5,7);

		  		if(confirm( yy+"�� "+mm+"�� �Ĵ븦 ����Ͻðڽ��ϱ�?")){

		            // �ش� Dataset�� Header�� ������ Header ����
		            if (dsT_SA_PAYMASTER01.CountColumn == 0) {
		            	dsT_SA_PAYMASTER01.setDataHeader("WRK_YM:STRING");
			            dsT_SA_PAYMASTER01.addrow();
		            }else{

		            	dsT_SA_PAYMASTER01.addrow();
			        }



		            dsT_SA_PAYMASTER01.namevalue(dsT_SA_PAYMASTER01.rowposition,"WRK_YM") = document.getElementById("txtPIS_YYMM_SHR").value;

					trT_SA_PAYMASTER.KeyValue = "tr01(I:dsT_SA_PAYMASTER01=dsT_SA_PAYMASTER01)";

					trT_SA_PAYMASTER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.e.sage020.cmd.SAGE020CMD&S_MODE=SAV";

		            trT_SA_PAYMASTER.post();

				}

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

       function fnc_GetNm() {
    	   
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
                
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDAPP)			 	   |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SA_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
		<param name="SubsumExpr"		value="1:SITE_NM">
	</Object>

	<Object ID="dsT_SA_PAYMASTER01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDAPP)			       |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_SA_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SA_PAYMASTER=dsT_SA_PAYMASTER,I:dsT_SA_PAYMASTER=dsT_SA_PAYMASTER)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_SA_PAYMASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SA_PAYMASTER.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_SA_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_SA_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SA_PAYMASTER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SA_PAYMASTER event="OnFail()">
        alert(trT_SA_PAYMASTER.ErrorMsg);
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

	<!-- form ���� -->
	<form name="form1" id="form1">


	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','../../images/button/btn_CreateOver.gif',1)"><img src="../../images/button/btn_CreateOn.gif" name="imgCreate" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Creat()"></a>
	            &nbsp;&nbsp;
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"><img src="../../images/button/btn_ExcelOn.gif" name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="80"></col>
                            <col width="100"></col>
                            <col width="80"></col>
                            <col width="200"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>

							<td align="center" class="searchState">���ؿ�</td>
                            <td class="padding2423">
								<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
							</td>

                            <td class="searchState" align="right">�� �� &nbsp;</td>
	                        <td class="padding2423">
		                        <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:20%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')">
								<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','�Ҽ�','AY');fnc_SearchList();"></a>
	                        </td>

							<td align="center" class="searchState">����</td>
							<td >
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>

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
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_SA_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" 					value="dsT_SA_PAYMASTER">
						<PARAM NAME="TITLEHEIGHT"		VALUE=40>
						<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
						<PARAM NAME="BORDERSTYLE" 		VALUE="0">
						<PARAM NAME="INDWIDTH"			VALUE="0">
						<PARAM NAME="FILLAREA"				VALUE="true">
						<PARAM NAME="EDITABLE"				VALUE="true">
						<PARAM NAME="Colsizing"				VALUE="true">
                        <param name="SuppressOption"    	value="1">
						<param name="ViewSummary"  		value="1">
						<param name="Format" 					value="
               				<FC>Name=NO			ID={CurRow} 		Width=50,  	align=center, 	sort = false 				SumBgColor=#C3D0DB	editable=false</FC>
							<FC>Name=�Ҽ�,   		ID=SITE_NM,  		width=380, 	align=left, 		edit=none sort = true SumBgColor=#C3D0DB suppress=1 SubSumText='�� ��' </FC>
							<FC>Name=����,   		ID=JOB_NM,  		width=100, 	align=center, 	edit=none sort = true SumBgColor=#C3D0DB</FC>
							<FC>Name=���,   		ID=ENO_NO,  		width=100, 	align=center, 	edit=none sort = true SumBgColor=#C3D0DB</FC>
							<FC>Name=����,   		ID=ENO_NM,  		width=100, 	align=center, 	edit=none sort = true SumBgColor=#C3D0DB</FC>
							<FC>Name=�ϼ�,  		ID=WRK_DAY,  	width=70, 	align=center, 	edit=none sort = true  SumBgColor=#C3D0DB</FC>
							<FC>Name=���޾�,  		ID=WRK_PAY,  		width=170, 	align=right, 	edit=none sort = true  SumBgColor=#C3D0DB 	SumText=@sum</FC>

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





<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### �Ͽ��� �� �� ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    			value="dsT_RP_REPORT">
	<PARAM NAME="PaperSize"						VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" 						VALUE="

<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=90 ,face='����ü' ,size=9 ,penwidth=1
	<T>id='No' ,left=0 ,top=0 ,right=45 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�� ��' ,left=45 ,top=0 ,right=460 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�� ��' ,left=460 ,top=0 ,right=560 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ϼ�' ,left=560 ,top=0 ,right=640 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=640 ,top=0 ,right=720 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ϴ�' ,left=720 ,top=0 ,right=850 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�빫��' ,left=850 ,top=0 ,right=1000 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ٷ���' ,left=1000 ,top=0 ,right=1900 ,bottom=42 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ҵ漼' ,left=1000 ,top=42 ,right=1140 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ֹμ�' ,left=1140 ,top=42 ,right=1280 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���ο���' ,left=1280 ,top=42 ,right=1420 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ǰ�����' ,left=1420 ,top=42 ,right=1560 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��뺸��' ,left=1560 ,top=42 ,right=1700 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��' ,left=1700 ,top=42 ,right=1840 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�Ǽ��ɾ�' ,left=1840 ,top=0 ,right=1990 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ȸ��δ��' ,left=1990 ,top=0 ,right=2690 ,bottom=42 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���ο���' ,left=1990 ,top=42 ,right=2125 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ǰ�����' ,left=2125 ,top=42 ,right=2260 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���纸��' ,left=2260 ,top=42 ,right=2400 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��뺸��' ,left=2400 ,top=42 ,right=2540 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��' ,left=2540 ,top=42 ,right=2680 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�հ�' ,left=2680 ,top=0 ,right=2830 ,bottom=90 ,face='����ü' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=61 ,face='����ü' ,size=8 ,penwidth=1
	<C>id='{CURROW}', left=0, top=0, right=45, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SITE_NM', left=45, top=0, right=460, bottom=61, align='left', border=true, penstyle=solid, penwidth=1, pencolor=#000000, supplevel=1,BgColor=#C0C0C0</C>


	<C>id='{decode(ENO_NM,'',\'�� ��\',ENO_NM)}', left=460, top=0, right=560, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='WRK_DAY', left=560, top=0, right=640, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{decode(ENO_NM,'','',CNT)}', left=640, top=0, right=720, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{decode(ENO_NM,'','',WRK_AMT)}', left=720, top=0, right=850, bottom=61, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='WRK_PAY', left=850, top=0, right=1000, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='INCM_TAX', left=1000, top=0, right=1140, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='CITI_TAX', left=1140, top=0, right=1280, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='NPEN_AMT', left=1280, top=0, right=1420, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINU_AMT', left=1420, top=0, right=1560, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINS_AMT', left=1560, top=0, right=1700, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SUB_SUM', left=1700, top=0, right=1840, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='ACT_AMT', left=1840, top=0, right=1990, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='NPEN_CAMT', left=1990, top=0, right=2125, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINU_CAMT', left=2125, top=0, right=2260, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SAN_CAMT', left=2260, top=0, right=2400, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='HINS_CAMT', left=2400, top=0, right=2540, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SUB_CSUM', left=2540, top=0, right=2680, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='FINAL_AMT', left=2680, top=0, right=2830, bottom=61, align='right', border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=64 ,face='Arial' ,size=8 ,penwidth=1
	<X>left=0 ,top=0 ,right=850 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=850 ,top=0 ,right=1000 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1000 ,top=0 ,right=1140 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1140 ,top=0 ,right=1280 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1280 ,top=0 ,right=1420 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1420 ,top=0 ,right=1560 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1560 ,top=0 ,right=1700 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1700 ,top=0 ,right=1840 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1840 ,top=0 ,right=1990 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1990 ,top=0 ,right=2125 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2125 ,top=0 ,right=2260 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2260 ,top=0 ,right=2400 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2400 ,top=0 ,right=2540 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2540 ,top=0 ,right=2680 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2680 ,top=0 ,right=2830 ,bottom=64 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>


	<T>id='�Ѱ�' ,left=0 ,top=0 ,right=850 ,bottom=64 ,face='����ü' ,size=9 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>

	<C>id='{Sum(WRK_PAY)/2} ', left=850, top=1, right=1000, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(INCM_TAX)/2} ', left=1000, top=1, right=1140, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(CITI_TAX)/2} ', left=1140, top=1, right=1280, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(NPEN_AMT)/2} ', left=1280, top=1, right=1420, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINU_AMT)/2} ', left=1420, top=1, right=1560, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINS_AMT)/2} ', left=1560, top=1, right=1700, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(SUB_SUM)/2} ', left=1700, top=1, right=1840, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(ACT_AMT)/2} ', left=1840, top=1, right=1990, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>

	<C>id='{Sum(NPEN_CAMT)/2} ', left=1990, top=1, right=2125, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINU_CAMT)/2} ', left=2125, top=1, right=2260, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(SAN_CAMT)/2} ', left=2260, top=1, right=2400, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(HINS_CAMT)/2} ', left=2400, top=1, right=2540, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(SUB_CSUM)/2} ', left=2540, top=1, right=2680, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>
	<C>id='{Sum(FINAL_AMT)/2} ', left=2680, top=1, right=2830, bottom=62, align='right', face='����', size=8,  forecolor=#000000, backcolor=#C0C0C0 </C>


</B>

">
</OBJECT>





</body>
</html>


