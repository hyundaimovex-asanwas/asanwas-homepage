<!--
/*--------------------------------------------------------------------------------
+ �ý��۸� : �Ͽ��� �λ���� - �����Է�
+ ������� : ���� �Է�,����,����,��ȸ�Ѵ�.
+ ���α׷�ID : aday100.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2013.04.03
----------------------------------------------------------------------------------
+ �������� : 
+ �� �� �� : 
+ �������� : 
----------------------------------------------------------------------------------*/
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();
    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>�Ͽ��� ���°���</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTTTT';
        var savObj = new Array();
        var today = getToday();
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			dsT_CA_Master.ClearData();

			//���� ��ȸ
			var SITE_CD_SHR = document.getElementById("txtSITE_CD_SHR").value;		// �Ҽ�
			
            //�����ͼ� ����
            dsT_CA_Master.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR&SITE_CD_SHR="+SITE_CD_SHR;
            dsT_CA_Master.Reset();

        }

		/***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList2() {

        	dsT_CA_Detail.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR_01"
										+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
										+ "&ENO_NM=" + dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"ENO_NM") 
										+ "&CET_NO=" + dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"CET_NO"); 

        	dsT_CA_Detail.Reset(); 

        }


        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

			if (confirm("���������� �����Ͻðڽ��ϱ�?")) {

	            // �ش� Dataset�� Header�� ������ Header ����
	            if (dsT_CA_Temp.CountColumn == 0) {
	            	dsT_CA_Temp.setDataHeader("WRK_DT:STRING, YOIL:STRING, SITE_CD:STRING, ENO_NM:STRING, CET_NO:STRING, WRK_GB:STRING, WRK_YM:STRING");
	            }

				for(i=1;i<=dsT_CA_Detail.countrow;i++){	
					
					dsT_CA_Temp.addrow();

					dsT_CA_Temp.namevalue(i,"WRK_DT") = dsT_CA_Detail.namevalue(i,"WRK_DT"); 
					dsT_CA_Temp.namevalue(i,"YOIL") 		= dsT_CA_Detail.namevalue(i,"YOIL");
					dsT_CA_Temp.namevalue(i,"SITE_CD") = dsT_CA_Detail.namevalue(i,"SITE_CD");
					dsT_CA_Temp.namevalue(i,"ENO_NM") = dsT_CA_Detail.namevalue(i,"ENO_NM");
					dsT_CA_Temp.namevalue(i,"CET_NO") = dsT_CA_Detail.namevalue(i,"CET_NO");
					dsT_CA_Temp.namevalue(i,"WRK_GB") = dsT_CA_Detail.namevalue(i,"WRK_GB");
					dsT_CA_Temp.namevalue(i,"WRK_YM") = document.getElementById("txtPIS_YYMM_SHR").value;

					}
								
				trT_CA_Detail.KeyValue = "tr01(I:dsT_CA_Temp=dsT_CA_Temp)";
				trT_CA_Detail.action = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SAV";
	            trT_CA_Detail.post();

	            dsT_CA_Temp.ClearData();
				dsT_CA_Detail.ClearData();

				}

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
			function fnc_Add(){

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

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CA_Master.IsUpdated)  {
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


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
			cfStyleGrid5(form1.grdT_CA_Master,0,"false","true");
			cfStyleGrid(form1.grdT_CA_Detail,15,"true","false");

            //��¥���� ���ε�
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 0);
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // �ش��� To

			//���� ��� �����¸� �����°� ����
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}			

 			document.getElementById("gcem_str_dt").Text = today.substring(0,7)+"01";	 
	        document.getElementById("gcem_end_dt").Text = today;


<%
	if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002"))  {
%>

	        
			var eno_no = "<%=box.get("SESSION_ENONO")%>";	//���; 
            //�����ͼ� ����
            dsT_CA_BELONG.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR_03&eno_no="+eno_no;
            dsT_CA_BELONG.Reset();

            document.getElementById("txtSITE_CD_SHR").value = dsT_CA_BELONG.namevalue(1,"SITE_CD"); 		// 
            document.getElementById("txtSITE_NM_SHR").value = dsT_CA_BELONG.namevalue(1,"SITE_NM");		//           

<%
	}
%>

	        
			fnc_SearchList();



            
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/***********************
		* 		���°��� �ð� �Է�   	 *
		**********************/

		function fnc_Settle(){
	
				dsT_CA_Detail.ClearData();		
	
				if(!fnc_Settle_Chk()) return;
	
				var str_dt 	=  document.getElementById("gcem_str_dt").Text;
				var end_dt =  document.getElementById("gcem_end_dt").Text;

				dsT_CA_Date.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday020.cmd.ADAY020CMD&S_MODE=SHR_02&str_dt="+str_dt+"&end_dt="+end_dt;
				dsT_CA_Date.Reset();
	
				var date = fnc_Day_Chk(str_dt,end_dt);
	
				for(i=1;i<=date;i++){	
	
						var dateOfWeek1 = dsT_CA_Date.namevalue(i,"YYMMDD"); 
						var Yoil = dsT_CA_Date.namevalue(i,"YOIL"); 

			            // �ش� Dataset�� Header�� ������ Header ����
			            if (dsT_CA_Detail.CountColumn == 0) {
			            	dsT_CA_Detail.setDataHeader("WRK_DT:STRING, YOIL:STRING, SITE_CD:STRING, ENO_NM:STRING, CET_NO:STRING, WRK_GB:STRING");
			            }

						
						dsT_CA_Detail.addrow();
	
						//�������
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"WRK_DT") = dsT_CA_Date.namevalue(i,"YYMMDD"); 
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"YOIL") 	  = dsT_CA_Date.namevalue(i,"YOIL");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"SITE_CD") = dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"SITE_CD");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"ENO_NM") = dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"ENO_NM");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"CET_NO") = dsT_CA_Master.namevalue(dsT_CA_Master.rowposition,"CET_NO");
						dsT_CA_Detail.namevalue(dsT_CA_Detail.rowposition,"WRK_GB") = "X";
	
				}
		}


		/***********************
		* 		�����Է��� üũ 	 			*
		**********************/
		function fnc_Settle_Chk(){
	
			var chk = 0;

			var str_dt 	=  document.getElementById("gcem_str_dt").Text;
			var end_dt =  document.getElementById("gcem_end_dt").Text;
			
			for(i=1;i<=dsT_CA_Master.countrow;i++){		
				chk = 1;
					if(str_dt == "" || end_dt == "" ){		
					alert("��¥�� �Է��ϼ���");
					}
			}
			if(chk==0){
				alert("����ڸ� �����Ͻʽÿ�.");
				return false;	
			}
			return true;	
		}

		/******************************************************************************
			Description : ��¥ ���� ��ȸ Parameter   : frdt - �����, todt - ������
		******************************************************************************/
	
		function fnc_Day_Chk(frdt,todt) { 
	
			var fryy =frdt.substring(0,4);
			var frmm =frdt.substring(4,6);
			var frdd =frdt.substring(6,8);
			var toyy =todt.substring(0,4);
			var tomm =todt.substring(4,6);
			var todd =todt.substring(6,8);
	
			frdate=new Date(fryy,frmm-1,frdd); //�������� 1�� ���� 
			todate=new Date(toyy,tomm-1,todd); //���ó�¥ 
	
			frtime=frdate.getTime(); //��߽ð� 
			totime=todate.getTime(); //�����ð�
			cha=totime-frtime;       //�ð����� 
			conv=Math.floor(cha/(60*60*24*1000))+1; //�ð����̸� �������̷� ��� 
			return conv
				
		}
			
		

</script>


</head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CA_Master                     |
    | 3. Table List : T_AC_COCA                   |
    +----------------------------------------------->
    <Object ID="dsT_CA_Master" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        	Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

    <Object ID="dsT_CA_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_Date" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_CA_BELONG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    

    <Object ID="dsT_CA_Temp" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID ="trT_CA_Detail" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!--------------------------+
    | grid���� row�� Ŭ��������      |
    +------ -------------------->
	<script for=grdT_CA_Master event=OnClick(Row,Colid)>
		fnc_SearchList2();
	</script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CA_Master Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_CA_Master.UserStatus(i) = 1;
            }
        }
    </Script>

    <Script For=dsT_CA_Detail Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CA_Master Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CA_Detail Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CA_Master Event="OnDataError()">
        //Dataset���� Error ó��
		 cfErrorMsg(this);
    </Script>

    <Script For=dsT_CA_Detail Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CA_Master event="OnSuccess()">
    	alert("�⺻������ ����Ǿ����ϴ�. ���λ��� �ϰ������Ͻʽÿ�");
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        fnc_SearchList();
    </script>

    <script for=trT_CA_Detail event="OnSuccess()">
		alert("���λ��� ������ �Ϸ�Ǿ����ϴ�");
    </script>


    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CA_Master event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_CA_Detail event="OnFail()">
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
	<form name="form1" id="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����Է�</td>
					<td align="right" class="navigator">HOME/�������/�Ͽ�������/<font color="#000000">�����Է�</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="100"></col>
					<col width="200"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
				<td align="center" class="searchState">���ؿ�</td>
				<td>
					<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
				</td>
                         <td class="searchState" align="right">�� �� &nbsp;</td>
                         <td class="padding2423">
                                 <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')">
						<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','�Ҽ�','AY');fnc_SearchList();"></a>
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

			<!-- ���� ȭ�� ����-->
			<table width="1000" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">

						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="400" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CA_Master" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:477px;">
						                            <param name="DataID"					value="dsT_CA_Master">
													<PARAM NAME="BorderStyle"			VALUE="0">
													<PARAM NAME="Indwidth"				VALUE="0">
													<PARAM NAME="Fillarea"				VALUE="true">
													<PARAM NAME="Editable"				VALUE="false">
													<PARAM NAME="Colsizing"				VALUE="true">
													<PARAM NAME="TitleHeight"			VALUE=20>
													<param name="sortview"				value=left>
													<PARAM NAME="Format"          		VALUE="  
														<FC>ID={CurRow}		Name=NO				Width=30,   			align=center,  		sort=false  editable=false </FC> 
														<FC>ID=ENO_NM,			Name=����,				width=80px,			align=center,		edit=none  sort=true </FC>	
														<FC>ID=CET_NO,		    Name=�������,	 	width=80px,			align=center,		edit=none  sort=true mask='XX-XX-XX' </FC>
														<FC>ID=SITE_NM,	  	Name=�Ҽ�,				width=175px,			align=left,			edit=none  sort=true </FC>														">
													</object>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- ���� ��ȸ �׸��� ���̺� ��-->


			<!-- ���� ȭ�� ��-->
		</td>
		<td width=15></td>
		<td>
			<!-- ������ ȭ�� ����-->
			<table width="395" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td>
						<!-- ���� �Է� ���̺� ���� -->
						<table width="395" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="395" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width=""></col>

										</colgroup>
										<tr>
											<td align="center" class="creamBold">����</td>
											<td class="padding2423">
						                        <comment id="__NSID__">
									              <OBJECT id=gcem_str_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
									              <param name=Alignment			value=0>
									              <param name=Border	      value=true>
									              <param name=Format	      value="YYYY/MM/DD">
									              <param name=PromptChar	  value="_">
									              </OBJECT>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>							  
						                        
						                        &nbsp;&nbsp;~
						                        <comment id="__NSID__">
									              <OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
									              <param name=Alignment			value=0>
									              <param name=Border	      value=true>
									              <param name=Format	      value="YYYY/MM/DD">
									              <param name=PromptChar	  value="_">
									              </OBJECT>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>	
						                        &nbsp;&nbsp;
									            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_ConductOn.gif',1)">
									            <img src="/images/button/btn_ConductOn.gif" name="imgSettle" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Settle();">
									            </a>

											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
						<!-- ���� �Է� ���̺� �� -->


						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="395" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_CA_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:395px;height:445px;">
						                            <param name="DataID"				value="dsT_CA_Detail">
													<PARAM NAME="BorderStyle"			VALUE="0">
													<PARAM NAME="Indwidth"				VALUE="0">
													<PARAM NAME="Fillarea"				VALUE="true">
													<PARAM NAME="Editable"				VALUE="false">
													<PARAM NAME="Colsizing"				VALUE="true">
													<PARAM NAME="TitleHeight"			VALUE=20>
													<param name="sortview"				value=left>
						                            <param name="Format"				value="
						                				<FC>Name=NO				  	ID={CurRow} 		Width=30,  		align=center, 	sort = true,		editable=false</FC>
														<FC>Name=����,       	   	ID=WRK_DT,		width=100,		align=center, 	sort = true, 	edit=none mask='XXXX-XX-XX' color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC>		
														<FC>Name=����,       	   	ID=YOIL,				width=50,		align=center, 	sort = true, 	edit=none 	value={IF (YOIL='1','��',IF (YOIL='2','��', IF (YOIL='3','ȭ', IF (YOIL='4','��', IF (YOIL='5','��', IF (YOIL='6','��', IF (YOIL='7','��', '' )))))))} color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC>		
														<FC>Name=����,       	   	ID=ENO_NM,		width=80,		align=center, 	sort = true, 	edit=none</FC>		
						                				<FC>Name=����,    	 		ID=WRK_GB,  		width=80,		align=center, 	sort = true,  	EditStyle=Combo, dec=0, 	Data='X:X,2:0.5 �ٹ�,1:�ٹ�,3:1.5 �ٹ�' color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</FC						                            ">
						                        </object>
						                        </comment><script> __ShowEmbedObject(__NSID__); </script>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- ���� ��ȸ �׸��� ���̺� ��-->

					</td>
				</tr>
			</table>
			<!-- ������ ȭ�� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

</body>
</html>


