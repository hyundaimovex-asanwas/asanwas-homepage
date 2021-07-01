<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ �ý��۸� : �Ͽ��� �λ���� - ���� ���
+ ������� : ���� ����Ѵ�.
+ ���α׷�ID : aday050.jsp
+ ������� : 
+ �� �� �� : �� �� ��
+ �ۼ����� : 2013.04.03
----------------------------------------------------------------------------------
+ �������� : 
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���� ��û(aday050.jsp)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >


		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TTTTTFTT';
        var param = window.dialogArguments;
		var chkValid  = 'T';
		var rq_seq = 0;
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			dsT_CA_DETAIL.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_DTL"
												+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
												+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;			
			dsT_CA_DETAIL.reset();

            //������ ��ȸ
            fnc_SearchApprover();

        }

        /**
         * ������ ������ ��ȸ�Ѵ�.
         */
        function fnc_SearchApprover() {

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_APP"
													+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
													+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;	

            dsT_DI_APPROVAL.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

        	dsREQ_NO.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_REQ"
										+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
										+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;	

        	dsREQ_NO.Reset();

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

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CA_MASTER.CountColumn == 0) {
                dsT_CA_MASTER.setDataHeader("ENO_NO:STRING:NOTNULL, ENO_NM:STRING:NOTNULL, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, REQ_NO:STRING, REQ_REMARK:STRING,  REQ_YMD:STRING");
            }

			// �� �߰�
			dsT_CA_MASTER.AddRow();

            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "ENO_NO")  = '<%=box.get("SESSION_ENONO") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "ENO_NM")  = '<%=box.get("SESSION_ENONM") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "DPT_CD")  = '<%=box.get("SESSION_TEAMCD") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "DPT_NM")  = '<%=box.get("SESSION_TEAMNM") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "JOB_CD")  = '<%=box.get("SESSION_JOBCD") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "JOB_NM")  = '<%=box.get("SESSION_JOBNM") %>';
            dsT_CA_MASTER.NameValue(dsT_CA_MASTER.RowPosition, "REQ_YMD") = '<%=box.get("SESSION_TODAY") %>';

        }

        /******************
         * 08. ��ȿ�� �˻� *
         ******************/
        function fnc_Valid() {

			if (!dsT_CA_MASTER.IsUpdated ) {
                alert("dsT_CA_MASTER �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

			if (!dsT_DI_APPROVAL.IsUpdated ) {
                alert("���缱�� �������� �ʾҽ��ϴ�");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
		function fnc_Append(){

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

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

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

            //�����ϴ� �͵� ����
            fnc_HiddenElement("imgReport");
 
            //��¥���� ���ε�
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 0);
            
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // �ش���
            
			cfStyleGrid5(form1.grdT_CA_Detail,0,"false","true");      		// Grid Style ����
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"true","false");      	// Grid Style ����

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

			fnc_AddNew();

	        dsT_DI_APPROVAL.SetDataHeader(

								"ENO_NO:STRING(10),"+			// �����ڻ��
								"ENO_NM:STRING(10),"+			// �����ڸ�
								"DPT_CD:STRING(6),"+			// ���ºμ�
								"DPT_NM:STRING(10),"+			// ���ºμ���
								"JOB_CD:STRING(10),"+			// ����������
								"JOB_NM:STRING(10),"+			// ������
								"SEQ_NO:STRING(2),"+			// ���缱
	        					"GUN_YMD:STRING(10),"+			// ��¥
								"PENO_NO:STRING(10),"+			// ����ڻ��
	                            "GUN_GBN:STRING(1),"+			// ���籸��
								"REQ_NO:STRING(10),"+			//
								"APP_YN:STRING(10)"				// ���翩��

								);

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
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		
		/********************
         * ���缱 ����.
         *******************/
        function fnc_Approval() {

			var chk = 0;
			
            if(dsT_DI_APPROVAL.CountRow > 0){		
                	
	            for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
	    			if(dsT_DI_APPROVAL.NameValue(i,"APP_YN") == "N"){
						chk = chk + 1;	
	        		}
	            }
	
				if(chk == 0){
	                alert("�̹� ����ϼ̽��ϴ�.\n\n�����Ͻ÷��� �ΰ�ó������ �Ͻñ� �ٶ��ϴ�.");
	                return;
				}

            }
	        	
            if(dsT_CA_DETAIL.CountRow < 1){
                alert("��Ű����� ���� ������ �����ϴ�\n\n��ȸ���� �Ͻñ� �ٶ��ϴ�.");
                return;
              }
        	
            var DPT_CD = "<%=box.getString("SESSION_DPTCD") %>";
			var EMP_NO =  "<%=box.getString("SESSION_ENONO") %>";
            var REQ_YMD = document.getElementById("txtREQ_YMD").value;

			REQ_YMD = REQ_YMD.replace("-","").replace("-","")

            //ds�� ���Ϲ޴´�.
            dsT_DI_APPROVAL.DeleteAll();

            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "K");

            //������ IsUpdated üũ�ϰ� ����
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);

            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){

                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") =  i;	//���缱(�������)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = REQ_YMD;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = "<%=box.get("SESSION_ENONO")%>";	//����� ���
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "K";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";

            }

	        fnc_HiddenElement("imgSelectapproval");            
	        fnc_ShowElement("imgReport");            
        }



		/********************
         * ���ó��
         *******************/
        function fnc_Conduct() {

            if(dsT_CA_DETAIL.CountRow < 1){
              alert("��Ű����� ���� ������ �����ϴ�");
              return;
            }

            //1.���ó�� ������
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("���缱�� �������ּ���.");
                return;
            }

            //��û��ȣ ����
			fnc_SearchItem();
            
            //2.���ó��
            var REQ_YMD = document.getElementById("txtPIS_YYMM_SHR").value;
			var GUN_YMD = REQ_YMD.replace("-","").replace("-","")
			var DPT_CD  = "<%=box.getString("SESSION_DPTCD") %>";
			var REQ_NO  = dsREQ_NO.NameValue(1,"REQ_NO");

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD"
		                                      + "&S_MODE=SAV_APP"
		                                      + "&APP_YN="  +"R"
		                                      + "&GUN_YMD=" +GUN_YMD
		                                      + "&GUN_GBN=" +"K"
		                                      + "&GUN_DPT=" +DPT_CD
		                                      + "&REQ_NO="	+REQ_NO;

			prompt(this,trT_DI_APPROVAL.action);
			
			trT_DI_APPROVAL.post();

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
    | 2. �̸� : dsREQ_NO                           |
    | 3. Table List :             					|
    +----------------------------------------------->
    <Object ID="dsREQ_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_DETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CA_BELONG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					|
    | 2. �̸��� tr_ + �ֿ� ���̺��()								|
    | 3. ���Ǵ� Table List()	        							|
    +--------------------------------------------------->
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CA_MASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_HiddenElement("imgReport");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			fnc_ShowElement("imgReport");
        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_CA_DETAIL Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CA_DETAIL.CountRow);
        }
    </Script>

    <!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    if (iCount >= 1)    {
	                fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");                
	                document.getElementById("resultMessage").innerText =  '** ����� �Ϸ�Ǿ����ϴ�. �������̹Ƿ� �۾��� �Ұ��մϴ�. **';

             for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
				if(dsT_DI_APPROVAL.NameValue(i,"APP_YN") == "N"){

    	            fnc_ShowElement("imgSelectapproval");
                	document.getElementById("resultMessage").innerText =  '** �ΰ����! �ٽ� ���缱 ������ �ڿ� ����ϼ���. **';
					break;
					}
            }
     }else {
    	 			fnc_ShowElement("imgSelectapproval");
     }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CA_MASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CA_DETAIL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>    

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CA_MASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("����Ǿ����ϴ�\n����� ���ؼ��� ��Ź�ư�� �����ּ���");

        fnc_ShowElement("imgReport");

    </script>

    <script for=trT_DI_APPROVAL event="OnSuccess()">
		alert("��ŵǾ����ϴ�");
        //document.getElementById("resultMessage").innerText = "���ó���Ǿ����ϴ�";
        //fnc_HiddenElement("imgReport");
		fnc_OnLoadProcess();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CA_MASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  	<script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		var obj = new String();
		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
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
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">


<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����û</td>
					<td align="right" class="navigator">HOME/�������/�Ͽ�������/<font color="#000000">�����û</font></td>
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

			<img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval" width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" >
			<img src="/images/button/btn_ReportOn.gif"          	name="imgReport"            	width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >

	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="150"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
							<td align="center" class="searchState">���ؿ�</td>
                            <td class="padding2423">
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
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->


<table border="0">
	<tr>
		<td valign="top">
			<!-- ���� �Է� ���̺� ���� -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="100"></col>
                                <col width="200"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="creamBold">�����</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"  class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14" class="input_ReadOnly"  readonly>
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="creamBold">�μ�</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>   
                            <tr>                                                         
                                <td align="center" class="creamBold">����</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="creamBold">�����</td>
                                <td class="padding2423">
			                        <input id="txtREQ_YMD" size="15"  class="input_ReadOnly"  readonly>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- ���缱 ���� ���̺� ���� -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:125px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='REQ_NO'		width=40		name='��Ϲ�ȣ'	align=center	show=false</C>
			            					<C> id='SEQ_NO'		width=40		name='����'			align=center	show=false</C>
											<C> id='SEQ_NM'		width=50		name='����'			align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
			            					<C> id='DPT_NM'		width=80		name='�μ�'			align=center	show=false</C>
											<C> id='JOB_NM'		width=60		name='����'			align=center	</C>
											<C> id='ENO_NM'		width=70		name='����'			align=center	</C>
											<C> id='APP_YN'		width=160		name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&UPT_YMD} </C>
											<C> id='REMARK1' 	width=60		name='����'			align=center 	Color='Blue'	</C>

										">
										<param name="wmode" value="transparent" >
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>

								</td>
			                </tr>
			            </table>
			        	<!-- ���缱 ���� ���̺� �� -->
 					</td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CA_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"					value="dsT_CA_Detail">
							<PARAM NAME="TITLEHEIGHT"		VALUE=40>
							<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
							<PARAM NAME="BORDERSTYLE" 		VALUE="0">
							<PARAM NAME="INDWIDTH"			VALUE="0">
							<PARAM NAME="FILLAREA"				VALUE="true">
							<PARAM NAME="EDITABLE"				VALUE="true">
							<PARAM NAME="Colsizing"				VALUE="true">						
							<param name="ViewSummary"  		value="1">
							<param name="Format"					value="
								<C> id='{CUROW}'			width=30			name='NO'			align=center	value={String(Currow)}	SumBgColor=#C3D0DB</C>
								<C> id='SITE_NM'				width=190			name='�Ҽ�'			align=left		sort = true SumBgColor=#C3D0DB SumText='��'</C>
								<C> id='ENO_NM'				width=90			name='����'			align=center	sort = true SumBgColor=#C3D0DB SumText=@count</C>
								<C> id='CET_NO'				width=90			name='�������'	align=center	sort = true, SumBgColor=#C3D0DB mask='XX-XX-XX' SumText='��'</C>								
								<C> id='WRK_AMT'			width=80			name='�ϴ�'			align=center	sort = true SumBgColor=#C3D0DB</C>
								<C> id='WRK_DAY'			width=80			name='�ٷ��ϼ�'	align=center	sort = true SumBgColor=#C3D0DB</C>
								<C> id='WRK_PAY'			width=90			name='�빫��'		align=center	sort = true SumBgColor=#C3D0DB SumText=@sum</C>
                                <C> id='WRK_YM'   			width=90          	name='�ٷδ�'      align=center	sort = true, SumBgColor=#C3D0DB mask='XXXX-XX' </C>
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
<object id="bndT_CA_MASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CA_MASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 		Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM					Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 		Ctrl=txtDPT_CD     			Param=value 		</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 		</C>
		<C>Col=JOB_CD     		 		Ctrl=txtJOB_CD     			Param=value 		</C>
		<C>Col=JOB_NM					Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=REQ_YMD					Ctrl=txtREQ_YMD	   			Param=value		</C>

    '>
</object>



