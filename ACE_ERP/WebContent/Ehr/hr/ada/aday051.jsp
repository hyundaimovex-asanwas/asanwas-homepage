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
<title>���� ��û(aday051.jsp)</title>
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
		var req_no =  param.req_no;
		var yymm = req_no.substr(0,6);
		var site = req_no.substr(6,4);	
		var obj = new String();
		obj.app_cmt = "";
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	dsT_CA_MASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_MST"
												+ "&REQ_NO=" + req_no;			
        	dsT_CA_MASTER.reset();


        	
			dsT_CA_DETAIL.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_DTL"
												+ "&PIS_YYMM=" + yymm
												+ "&SITE_CD=" + site;			
			dsT_CA_DETAIL.reset();


			
            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD&S_MODE=SHR_APP"
													+ "&PIS_YYMM=" + yymm
													+ "&SITE_CD=" + site;	
            dsT_DI_APPROVAL.Reset();
            
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
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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
         * 08. ��ȿ�� �˻� *
         ******************/
        function fnc_Valid() {

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

            window.close();

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


            cfStyleGrid5(form1.grdT_CA_Detail,0,"false","true");      		// Grid Style ����
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"true","false");      	// Grid Style ����

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

	        fnc_SearchList();

	        document.getElementById("txtPIS_YYMM_SHR").value = yymm.substr(0,4)+"-"+yymm.substr(4,2); // �ش���
            document.getElementById("txtSITE_CD_SHR").value = site;       
            document.getElementById("txtSITE_NM_SHR").value = dsT_CA_MASTER.namevalue(1,"SITE_NM");  
	        
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


		/********************
         * 16. ���� ó��
         *******************/
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

            var app_yn = "Y";    //����ϷῩ��

			if (kind == "�ΰ�") {

				app_yn = "N";

				window.showModalDialog("/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			}

			dsT_DI_APPROVAL.UserStatus(1) = 1;

			dsT_DI_APPROVAL.NameValue(1,"REMARK") = obj.app_cmt;   	//�����ǰ� Container

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";

			trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday050.cmd.ADAY050CMD"
			                                      + "&S_MODE=UPT_APP"
			                                      + "&APP_YN="  +app_yn
			                                      + "&GUN_GBN=" +"K"
			                                      + "&REQ_NO="  +param.req_no;

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

    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
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

    <!--------------------------+
    | grid���� row�� Ŭ��������      |
    +------ -------------------->
	<script for=grdT_CA_Detail event=OnDblClick(Row,Colid)>
	
        var param = new String();

  		param.cet_no = dsT_CA_DETAIL.NameValue(Row, "CET_NO");
  		param.wrk_ym = dsT_CA_DETAIL.NameValue(Row, "WRK_YM");

    	window.showModalDialog("/hr/ada/aday052.jsp", param, "dialogWidth:420px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

	</script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CA_MASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

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
    <script for=trT_DI_APPROVAL event="OnSuccess()">
		alert("ó���Ǿ����ϴ�");
        //document.getElementById("resultMessage").innerText = "���ó���Ǿ����ϴ�";
		fnc_OnLoadProcess();
		fnc_HiddenElement("imgApproval");
		fnc_HiddenElement("imgRejection");		
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
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('����');"></a>
    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('�ΰ�');"></a>
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
								<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" class="input_ReadOnly" readonly>
							</td>					                        
                            <td class="searchState" align="right">�� �� &nbsp;</td>
	                        <td class="padding2423">
	                         <input id="txtSITE_CD_SHR" name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" class="input_ReadOnly" readonly>
							 <input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="20" maxlength="20" class="input_ReadOnly" readonly>
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
											<C> id='REQ_NO'				width=40	name='��Ϲ�ȣ'	align=center	show=false</C>
			            					<C> id='SEQ_NO'				width=40	name='����'			align=center	show=false</C>
											<C> id='SEQ_NM'				width=50	name='����'			align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
			            					<C> id='DPT_NM'				width=80	name='�μ�'			align=center	show=false</C>
											<C> id='JOB_NM'				width=60	name='����'			align=center	</C>
											<C> id='ENO_NM'				width=70	name='����'			align=center	</C>
											<C> id='APP_YN'				width=150	name='���翩��'	align=center	Value={DECODE(APP_YN,'Y','����','N','�ΰ�','�̰�')&' '&UPT_YMD} </C>											
											<C> id='REMARK1'				width=60	name='����'			align=center 	Color='Blue'	</C>

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
							<param name="DataID"					value="dsT_CA_DETAIL">
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
				 <tr>
						<td> <BR><font color = "red" size = "3">
								&nbsp;&nbsp;&nbsp;* ������ Double Clike �Ͻø� �ش� �ٷ����� ���� ��Ȳ�� ��ȸ�Ͻ� �� �ֽ��ϴ�.</font><BR>
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



