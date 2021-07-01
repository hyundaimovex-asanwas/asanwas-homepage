<!--
    ************************************************************************************
    * @source         : saga060.jsp 				                                   					*
    * @description   : �޿�������Ȳ PAGE.                                            				*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            			*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/01/14      �̵���        ERP �̻�
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�޿�������Ȳ</title>
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


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; 	// ���۳��
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; 	// ������


			//���۳���� ������ ��ȸ����.
			if(STR_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �Է��ϼ���.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(STR_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("���۳���� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ������ ��ȸ����.
			if(END_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �Է��ϼ���.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//�������� �߸��Ǿ����� ��ȸ����.
			if(END_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//�������� ���۳������ ũ�� �ȵȴ�.
			if(parseInt(END_YYMM_SHR.replaceStr("-","")) < parseInt(STR_YYMM_SHR.replaceStr("-",""))){
					alert("�������� ���۳������ �����ϴ�.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}


            //�����ͼ� ����
            dsT_CP_PAYMASTER.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR&STR_YYMM_SHR="+STR_YYMM_SHR
																								            +"&END_YYMM_SHR="+END_YYMM_SHR;

            dsT_CP_PAYMASTER.Reset();

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

			fnc_Report_4_1();	 		//���ο�

			//fnc_Report_4_2();  			//�ӿ�

			fnc_Report_4_3();  			//�ӿ��� ��

			gcrp_print.Preview();



        }


		/******************************************************************************
			Description : �޿�������Ȳ ���ο�����(Fheader �κ�)
		******************************************************************************/
		function fnc_Report_4_1(){

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // ��������
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // ��������

			dsT_RP_REPORT.ClearAll();

            dsT_RP_REPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR_PRINT&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR;
            dsT_RP_REPORT.Reset();

		}

		/******************************************************************************
			Description : �޿�������Ȳ �ӿ� ���� ��Ȳ
		******************************************************************************/
		function fnc_Report_4_2(){

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // ��������
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // ��������

			dsT_RP_REPORT2.ClearAll();

            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR_PRINT_02&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR;
            dsT_RP_REPORT2.Reset();

		}

		/******************************************************************************
			Description : �޿�������Ȳ �ӿ� ���� ��Ȳ
		******************************************************************************/
		function fnc_Report_4_3(){

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // ��������
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // ��������

			dsT_RP_REPORT3.ClearAll();

            dsT_RP_REPORT3.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga060.cmd.SAGA060CMD&S_MODE=SHR_PRINT_03&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR;
            dsT_RP_REPORT3.Reset();

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


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			fnc_ChangeGrid();      //�׸��� ���� ó��

            //��¥���� ���ε�
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, -1);
            document.getElementById("txtSTR_YYMM_SHR").value = svc_ymd.substr(0,7); // �ش��� From
            svc_ymd     = addDate("M", gcurdate, 0);
            document.getElementById("txtEND_YYMM_SHR").value = svc_ymd.substr(0,7); // �ش��� To


			//���� ��� �����¸� �����°� ����
			var STR_YYMM_SHR = (document.getElementById("txtSTR_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(STR_YYMM_SHR.trim() == ""){
				document.getElementById("txtSTR_YYMM_SHR").value = "";
			}

			var END_YYMM_SHR = (document.getElementById("txtEND_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(END_YYMM_SHR.trim() == ""){
				document.getElementById("txtEND_YYMM_SHR").value = "";
			}

			fnc_SearchList();
			
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*************************
         * �׸��� ���� ó��               *
         ************************/
		function fnc_ChangeGrid(obj) {

			if(obj == undefined || obj.value == "A"){
				form1.grdT_CP_PAYMASTER.Format = "<FC> id='{CUROW}'				width=40		name='NO'						align=center		value={String(Currow)}				</FC>" +
												"<FC> id='DPT_NM'				width=85		name='�Ҽ�'						align=center					</FC>" +
												"<C> id='ENO_NO'        		width=55        name='���'          			align=center    Edit=none  </C>" +
												"<C> id='ENO_NM'        		width=70        name='����'          			align=center    Edit=none  </C>" +
												"<C> id='JOB_NM'        		width=80       	name='����'        				align=center    Edit=none  </C>" +
												"<C> id='P01_AMT'       		width=80        name='�⺻��'        				align=right                     </C>" +
												"<C> id='P02_AMT'       		width=80        name='�ð���'        				align=right                     </C>" +
												"<C> id='P03_AMT'       		width=80        name='���ϱٹ�'       			align=right                     </C>" +
												"<C> id='P04_AMT'       		width=80        name='Ư����'     				align=right                     </C>" +
												"<C> id='P05_AMT'       		width=80        name='����'       				align=right                     </C>" +
												"<C> id='SALT_AMT'				width=80		name='�հ�'						align=right						</C>" +
												"<C> id='SUM_DED'			    width=80		name='������'						align=right						</C>" +
												"<C> id='PAY_AMT'				width=80		name='�Ǽ��ɾ�'					align=right						</C>";

            }

			//ù��° �μ� : �׸����                                        �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_CP_PAYMASTER,0,"false","false");
			

		}



</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CP_PAYMASTER                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!----------------------------------------------+
    | 1. ����Ʈ�� DataSet                     		|
    | 2. �̸� : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtSTR_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // ���۳��
			document.getElementById("txtEND_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // ������

			document.getElementById("txtSTR_YYMM_SHR").focus();
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="30"></col>
								<col width="200"></col>
								<col width="100"></col>
								<col width="200"></col>
								<col width="100"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td align="left" >
									<input id="txtSTR_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									&nbsp;~&nbsp;
									<input id="txtEND_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
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
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:450px;">
							<param name="DataID"							value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"						value="false">
							<param name="DragDropEnable"				value="true">
							<param name="SortView"						value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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
			R E P O R T   D E F I N I T I O N   -
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    			value="dsT_RP_REPORT3">
	<PARAM NAME="PaperSize"						VALUE="A4">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format" 						VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='�޿�������Ȳ_���ο�.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='dsT_RP_REPORT'
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=558 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=894 ,top=5 ,right=1918 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<L> left=32 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��  ��' ,left=45 ,top=241 ,right=246 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=360 ,right=2781 ,bottom=360 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=550 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��' ,left=201 ,top=373 ,right=246 ,bottom=421 ,face='����' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='.' ,left=138 ,top=373 ,right=164 ,bottom=421 ,face='����' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=201 ,top=431 ,right=246 ,bottom=482 ,face='����' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='.' ,left=138 ,top=431 ,right=164 ,bottom=482 ,face='����' ,size=10 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����������' ,left=77 ,top=492 ,right=246 ,bottom=540 ,align='right' ,face='����' ,size=8 ,bold=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=230 ,right=32 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=230 ,right=257 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=230 ,right=352 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1680 ,top=294 ,right=1680 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=590 ,top=230 ,right=590 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2474 ,top=230 ,right=2474 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=230 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='Print Date:' ,left=2250 ,top=132 ,right=2500 ,bottom=180 ,align='right' ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1   ���ο�' ,left=32 ,top=180 ,right=241 ,bottom=222 ,align='left' ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1685 ,top=299 ,right=1894 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=69 ,top=484 ,right=2781 ,bottom=484 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�ҵ漼' ,left=598 ,top=299 ,right=767 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���ο���' ,left=1132 ,top=299 ,right=1302 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ǰ�����' ,left=955 ,top=299 ,right=1124 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���� : ��' ,left=2580 ,top=180 ,right=2783 ,bottom=222 ,align='right' ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=71 ,top=484 ,right=71 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=590 ,top=294 ,right=1680 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1677 ,top=294 ,right=1900 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='�ο�' ,left=270 ,top=241 ,right=347 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����޾�' ,left=2487 ,top=241 ,right=2773 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>

			<T>id='��' ,left=1312 ,top=1 ,right=1384 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='�޿� ���� ��Ȳ' ,left=1390 ,top=1 ,right=1868 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='��' ,left=1138 ,top=1 ,right=1220 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>

			<L> left=773 ,top=296 ,right=773 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=426 ,right=2781 ,bottom=426 </L>
			<L> left=953 ,top=296 ,right=953 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1127 ,top=296 ,right=1127 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1307 ,top=296 ,right=1307 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1487 ,top=296 ,right=1487 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='ȸ������' ,left=1905 ,top=238 ,right=2461 ,bottom=288 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1900 ,top=230 ,right=1900 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2265 ,top=294 ,right=2265 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='��' ,left=2270 ,top=299 ,right=2466 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1902 ,top=294 ,right=2294 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2270 ,top=294 ,right=2471 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='��뺸��' ,left=1910 ,top=299 ,right=2080 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���纸��' ,left=2090 ,top=299 ,right=2260 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���ް�' ,left=381 ,top=241 ,right=561 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=601 ,top=238 ,right=1886 ,bottom=288 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ֹμ�' ,left=778 ,top=299 ,right=947 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=1492 ,top=299 ,right=1672 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��뺸��' ,left=1312 ,top=299 ,right=1482 ,bottom=349 ,face='����' ,size=10 ,bold=true ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2082 ,top=296 ,right=2082 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>

			<C>id='CYYYY', left=963, top=13, right=1135, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<C>id='CMM', left=1222, top=13, right=1310, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<C>id='CTITLE', left=1416, top=13, right=1553, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<C>id='TODATEE', left=2500, top=132, right=2783, bottom=180, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CYYYYO', left=45, top=373, right=140, bottom=421, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CMMO', left=153, top=373, right=204, bottom=421, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COUNTP', left=273, top=373, right=349, bottom=421, align='right'</C>
			<C>id='CYYYY', left=45, top=431, right=140, bottom=482, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CMM', left=153, top=431, right=204, bottom=482, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COUNTR', left=270, top=431, right=347, bottom=482, align='right'</C>
			<C>id='{COUNTR-COUNTP}', left=270, top=492, right=347, bottom=540, align='right', Dec=0</C>
			<C>id='S91000', left=360, top=373, right=582, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S91000R-S91000}', left=360, top=492, right=582, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S91000R', left=360, top=431, right=582, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='T11000', left=598, top=373, right=773, bottom=421, align='right'</C>
			<C>id='T11000R', left=598, top=429, right=773, bottom=479, align='right'</C>
			<C>id='{T11000R-T11000}', left=598, top=489, right=773, bottom=537, align='right', Dec=0</C>
			<C>id='T12000', left=778, top=373, right=953, bottom=421, align='right'</C>
			<C>id='T12000R', left=778, top=431, right=953, bottom=482, align='right'</C>
			<C>id='{T12000R-T12000}', left=778, top=492, right=953, bottom=540, align='right', Dec=0</C>
			<C>id='B11000', left=955, top=373, right=1124, bottom=421, align='right'</C>
			<C>id='B11000R', left=955, top=431, right=1124, bottom=482, align='right'</C>
			<C>id='{B11000R-B11000}', left=955, top=492, right=1124, bottom=540, align='right', Dec=0</C>
			<C>id='B12000', left=1132, top=373, right=1307, bottom=421, align='right'</C>
			<C>id='B12000R', left=1132, top=431, right=1307, bottom=482, align='right'</C>
			<C>id='{B12000R-B12000}', left=1132, top=492, right=1307, bottom=540, align='right', Dec=0</C>
			<C>id='B13000', left=1310, top=373, right=1484, bottom=421, align='right'</C>
			<C>id='B13000R', left=1310, top=431, right=1484, bottom=482, align='right'</C>
			<C>id='{B13000R-B13000}', left=1310, top=492, right=1484, bottom=540, align='right', Dec=0</C>
			<C>id='BXTOTAL', left=1490, top=376, right=1677, bottom=423, align='right'</C>
			<C>id='BXTOTALR', left=1490, top=434, right=1677, bottom=484, align='right'</C>
			<C>id='{BXTOTALR-BXTOTAL}', left=1490, top=495, right=1677, bottom=542, align='right', Dec=0</C>
			<C>id='S93000', left=1685, top=373, right=1894, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S93000R', left=1685, top=431, right=1894, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S93000R-S93000}', left=1685, top=492, right=1894, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='B23000', left=1910, top=373, right=2080, bottom=421, align='right'</C>
			<C>id='B23000R', left=1910, top=431, right=2080, bottom=482, align='right'</C>
			<C>id='{B23000R-B23000}', left=1910, top=492, right=2080, bottom=540, align='right', Dec=0</C>
			<C>id='B17000', left=2090, top=373, right=2260, bottom=421, align='right'</C>
			<C>id='B17000R', left=2090, top=431, right=2260, bottom=482, align='right'</C>
			<C>id='{B17000R-B17000}', left=2090, top=492, right=2260, bottom=540, align='right', Dec=0</C>
			<C>id='B23170', left=2270, top=373, right=2466, bottom=421, align='right'</C>
			<C>id='B23170R', left=2270, top=431, right=2466, bottom=482, align='right'</C>
			<C>id='{B23170R-B23170}', left=2270, top=492, right=2466, bottom=540, align='right', Dec=0</C>
			<C>id='S94000', left=2487, top=373, right=2773, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S94000R', left=2487, top=431, right=2773, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S94000R-S94000}', left=2487, top=492, right=2773, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>

		</B>
	</R>
</A>




<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='�޿�������Ȳ_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='dsT_RP_REPORT3'
		<B>id=default ,left=0,top=0 ,right=2871 ,bottom=415 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=32 ,top=77 ,right=2781 ,bottom=77 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��  ��' ,left=45 ,top=87 ,right=246 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='TAX_DPTNM', left=146, top=21, right=860, bottom=66, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=32 ,top=206 ,right=2781 ,bottom=206 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��' ,left=201 ,top=220 ,right=246 ,bottom=267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=220, right=204, bottom=267, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=220 ,right=164 ,bottom=267 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYYO', left=45, top=220, right=140, bottom=267, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CYYYY', left=45, top=278, right=140, bottom=328, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=32 ,top=273 ,right=2781 ,bottom=273 </L>
			<T>id='��' ,left=201 ,top=278 ,right=246 ,bottom=328 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=278, right=204, bottom=328, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=278 ,right=164 ,bottom=328 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ο�' ,left=270 ,top=87 ,right=347 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=71 ,top=331 ,right=2781 ,bottom=331 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='{COUNTR-COUNTP}', left=270, top=339, right=347, bottom=386, align='right', Dec=0</C>
			<C>id='COUNTR', left=270, top=278, right=347, bottom=328, align='right'</C>
			<C>id='COUNTP', left=270, top=220, right=347, bottom=267, align='right'</C>
			<L> left=257 ,top=79 ,right=257 ,bottom=392 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=32 ,top=397 ,right=2781 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�����������' ,left=77 ,top=339 ,right=246 ,bottom=386 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=79 ,right=32 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=593 ,top=79 ,right=593 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�ֹμ�' ,left=778 ,top=148 ,right=945 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ҵ漼' ,left=598 ,top=148 ,right=767 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ǰ�����' ,left=955 ,top=148 ,right=1124 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���ο���' ,left=1132 ,top=148 ,right=1302 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=947 ,top=140 ,right=947 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S93000', left=1683, top=220, right=1892, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1675 ,top=140 ,right=1675 ,bottom=397 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2474 ,top=79 ,right=2474 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�����޾�' ,left=2487 ,top=87 ,right=2773 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='{S94000R-S94000}', left=2487, top=339, right=2773, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2487, top=278, right=2773, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S94000', left=2487, top=220, right=2773, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2781 ,top=79 ,right=2781 ,bottom=397 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='{S91000R-S91000}', left=357, top=339, right=579, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S91000R', left=357, top=278, right=579, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000', left=357, top=220, right=579, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=352 ,top=77 ,right=352 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=773 ,top=140 ,right=773 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=71 ,top=333 ,right=71 ,bottom=400 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='{currow+1}', left=32, top=21, right=135, bottom=66, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S93000R', left=1683, top=278, right=1892, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S93000R-S93000}', left=1683, top=339, right=1892, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='��' ,left=1683 ,top=148 ,right=1892 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=1487 ,top=148 ,right=1672 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���ް�' ,left=360 ,top=87 ,right=582 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1127 ,top=140 ,right=1127 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1304 ,top=143 ,right=1304 ,bottom=400 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='��뺸��' ,left=1310 ,top=148 ,right=1479 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T11000', left=598, top=220, right=767, bottom=267, align='right'</C>
			<C>id='T11000R', left=598, top=278, right=767, bottom=328, align='right'</C>
			<C>id='{T11000R-T11000}', left=598, top=339, right=767, bottom=386, align='right', Dec=0</C>
			<L> left=1482 ,top=143 ,right=1482 ,bottom=400 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1900 ,top=77 ,right=1900 ,bottom=394 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1675 ,top=140 ,right=1897 ,bottom=140 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='��������' ,left=598 ,top=87 ,right=1889 ,bottom=138 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��뺸��' ,left=1908 ,top=143 ,right=2077 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2080 ,top=140 ,right=2080 ,bottom=397 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='ȸ������' ,left=1910 ,top=85 ,right=2455 ,bottom=135 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2260 ,top=140 ,right=2260 ,bottom=397 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='���纸��' ,left=2085 ,top=143 ,right=2254 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2262 ,top=143 ,right=2466 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T12000', left=775, top=220, right=942, bottom=267, align='right'</C>
			<C>id='B11000', left=953, top=220, right=1122, bottom=267, align='right'</C>
			<C>id='B12000', left=1132, top=220, right=1302, bottom=267, align='right'</C>
			<C>id='B13000', left=1310, top=220, right=1479, bottom=267, align='right'</C>
			<C>id='BXTOTAL', left=1487, top=220, right=1672, bottom=267, align='right'</C>
			<C>id='T12000R', left=775, top=278, right=942, bottom=328, align='right'</C>
			<C>id='B11000R', left=953, top=278, right=1122, bottom=328, align='right'</C>
			<C>id='B12000R', left=1132, top=278, right=1302, bottom=328, align='right'</C>
			<C>id='B13000R', left=1310, top=278, right=1479, bottom=328, align='right'</C>
			<C>id='BXTOTALR', left=1487, top=278, right=1672, bottom=328, align='right'</C>
			<C>id='{T12000R-T12000}', left=775, top=339, right=942, bottom=386, align='right', Dec=0</C>
			<C>id='{B11000R-B11000}', left=953, top=339, right=1122, bottom=386, align='right', Dec=0</C>
			<C>id='{B12000R-B12000}', left=1132, top=339, right=1302, bottom=386, align='right', Dec=0</C>
			<C>id='{B13000R-B13000}', left=1310, top=339, right=1479, bottom=386, align='right', Dec=0</C>
			<C>id='{BXTOTALR-BXTOTAL}', left=1487, top=339, right=1672, bottom=386, align='right', Dec=0</C>
			<L> left=595 ,top=140 ,right=1672 ,bottom=140 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='B23000', left=1905, top=220, right=2074, bottom=267, align='right'</C>
			<C>id='B17000', left=2088, top=220, right=2257, bottom=267, align='right'</C>
			<C>id='B23170', left=2265, top=220, right=2466, bottom=267, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='B23000R', left=1905, top=278, right=2074, bottom=328, align='right'</C>
			<C>id='B17000R', left=2088, top=278, right=2257, bottom=328, align='right'</C>
			<C>id='{B23000R-B23000}', left=1905, top=339, right=2074, bottom=386, align='right', Dec=0</C>
			<C>id='{B17000R-B17000}', left=2088, top=339, right=2257, bottom=386, align='right', Dec=0</C>
			<C>id='{B23170R-B23170}', left=2265, top=339, right=2466, bottom=386, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='B23170R', left=2265, top=278, right=2466, bottom=328, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1902 ,top=140 ,right=2262 ,bottom=140 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2257 ,top=140 ,right=2471 ,bottom=140 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		</B>



	</R>
</A>



<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../images/common/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>



">
</OBJECT>






</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

