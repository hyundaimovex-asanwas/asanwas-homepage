<!--
*****************************************************
* @source       : vluk090.jsp
* @description  : ������������ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/11/26      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>������������(vluk090)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

          //�˻����� 4����
          var REG_YM_SHR 	= document.form1.txtREG_YM_SHR.value;          //�ش�⵵
          var EMPNOH 		= document.form1.txtENOH_NO_SHR.value;         //�����
          var GUBUN 		= "";
          var GOGA1 		= document.form1.goga1.value;         			//�������
          var JOB_CD_FROM 	= document.form1.cmbJOB_CD_FROM.value;          //���� ����
          var JOB_CD_TO 	= document.form1.cmbJOB_CD_TO.value;         	//���� ��

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//�����
          }


		  	if(GUBUN == "1"){ //������
		       	//���� ��ȸ
		       	dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GOGA1="+GOGA1+"&JOB_CD_FROM="+JOB_CD_FROM+"&JOB_CD_TO="+JOB_CD_TO;
		       	dsT_EV_ABLRST.reset();
			}else{ 			//�����
		       	//���� ��ȸ
		       	dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GOGA1="+GOGA1+"&JOB_CD_FROM="+JOB_CD_FROM+"&JOB_CD_TO="+JOB_CD_TO;
		       	dsT_EV_ABLRST.reset();
			}

        }


        function fnc_SearchList2() {

          //�˻����� 4����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //�����
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//�����
          }

			if(document.form1.txtREG_YM_SHR.value !="2013-11"){
				alert("2013�� 11���� ���� �����մϴ�.");
				return false;
			}

            dsT_EV_ABLRST.ClearData();

		  	if(GUBUN == "1"){ //������

		       	dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_02&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
		       	dsT_EV_ABLRST2.reset();
			}else{ 			//�����

		       	dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_03&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
		       	dsT_EV_ABLRST2.reset();
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


			if(document.form1.txtREG_YM_SHR.value != "2013-11"){
				alert("2013�� 11���� ���� �����մϴ�.");
				return false;
			}

			if (dsT_EV_ABLRST.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {
				if (confirm("�����Ͻðڽ��ϱ�?")) {
		            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
		            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SAV";
		            trT_EV_ABLRST.post();
				}
			}
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

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("�����������", '', 225);

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

            var f = document.form1;
            f.txtENOH_NO_SHR.value = '';
            f.txtENOH_NM_SHR.value = '';


            dsT_EV_ABLRST.ClearData();

            document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

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

            if (!dsT_EV_ABLRST.IsUpdated) {
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

			document.getElementById("loctitle").innerText = "HOME/�λ���/�����/";

			document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

	        cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","true");      // Grid Style ����

        	//����
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM", "", "�� ü");
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO", "", "�� ü");


        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /********************
         * 16.    ����       *
         *******************/
        function fnc_Execute() {

			alert("������");

        	/*
			if (dsT_EV_ABLRST.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {

		    	if(document.form1.txtREG_YM_SHR.value==""){
					alert("�������� Ȯ���Ͻʽÿ�.");
					return false;
				}

				fnc_SearchList2();
			}
			*/
        }



		/******************************************************************************
			17. ��޻��� --> ����� �׻� ���� �� totavg(��������)�� ������ �Ŀ� �����ؾ���.
		******************************************************************************/
		function fnc_Grade(){

		  //alert("������");

	
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//�����
          }

		    if(document.form1.txtREG_YM_SHR.value == ""){
				alert("�������� �������� �ʽ��ϴ�. Ȯ�ιٶ��ϴ�.");
				return;
			}

			if(document.form1.txtREG_YM_SHR.value != "2013-11"){
				alert("2013�� 11���� ��޻��� �����մϴ�.");
				return false;
			}


			//���޺� ��� �ο���
		  	if(GUBUN == "1"){ //������

			 	dsT_EV_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_04&REG_YM_SHR="+REG_YM_SHR;
			    dsT_EV_GRADE.reset();

			}else{ 			//�����

		       	dsT_EV_GRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_05&REG_YM_SHR="+REG_YM_SHR;
		       	dsT_EV_GRADE.reset();
			}


			//���޺� rank
		  	if(GUBUN == "1"){ //������

			 	dsT_EV_GRADE2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_06&REG_YM_SHR="+REG_YM_SHR;
			    dsT_EV_GRADE2.reset();

			}else{ 			//�����

		       	dsT_EV_GRADE2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SHR_07&REG_YM_SHR="+REG_YM_SHR;
		       	dsT_EV_GRADE2.reset();
			}


		    if (confirm(document.form1.txtREG_YM_SHR.value+"�� ��޻����� �Ͻðڽ��ϱ�?")) {

				fnc_Grade_Update();

	            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_GRADE2=dsT_EV_GRADE2)";
	            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SAV_GRD";
	            trT_EV_ABLRST.post();

			}


		}

		/******************************************************************************
			Description : ��޻��� --> ����� �׻� ���� �� totavg(��������)�� ������ �Ŀ� �����ؾ���.
		******************************************************************************/
		function fnc_Grade_Update(){

			var intCnt=0;
			var intS=0;
			var intA=0;
			var intB=0;
			var intC=0;
			var intD=0;
			var intStart=1;

			for(i=1;i<=dsT_EV_GRADE.countrow;i++){ //���޺� row

				intCnt=0;                               //���޺� ��� �ʱ�ȭ

				intS=dsT_EV_GRADE.namevalue(i,"S");

				intA=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A");

				intB=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A")+dsT_EV_GRADE.namevalue(i,"B");

				intC=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A")+dsT_EV_GRADE.namevalue(i,"B")+dsT_EV_GRADE.namevalue(i,"C");

				intD=dsT_EV_GRADE.namevalue(i,"S")+dsT_EV_GRADE.namevalue(i,"A")+dsT_EV_GRADE.namevalue(i,"B")+dsT_EV_GRADE.namevalue(i,"C")+dsT_EV_GRADE.namevalue(i,"D");

				_loop:

				for(j=intStart;j<=dsT_EV_GRADE2.countrow;j++){ //��ü ���޺� rank ����..

					intCnt +=1;                           //����

		       		if(dsT_EV_GRADE.namevalue(i,"PAYGRD2")==dsT_EV_GRADE2.namevalue(j,"PAYGRD2")){

						intStart+=1;

						if(intCnt<=intS){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="S";
						}else if(intCnt<=intA){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="A";
						}else if(intCnt<=intB){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="B";
		        		}else if(intCnt<=intC){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="C";
		        		}else if(intCnt<=intD){
							dsT_EV_GRADE2.namevalue(j,"GRADE")="D";
						}

					}else{
						break _loop;
					}

				}//for j

		  }//for i

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

    <Object ID="dsT_EV_ABLRST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_GRADE2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

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

    <Script For=dsT_EV_ABLRST2 Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {

        	for(var i=1;i<=iCount;i++) {

				if(dsT_EV_ABLRST2.namevalue(i,"DPTAVG")==0){

					dsT_EV_ABLRST2.namevalue(i,"TOTAVG") = dsT_EV_ABLRST2.namevalue(i,"CORAVG");

				}else{

					dsT_EV_ABLRST2.namevalue(i,"TOTAVG") = dsT_EV_ABLRST2.namevalue(i,"CORAVG")*0.9 + dsT_EV_ABLRST2.namevalue(i,"DPTAVG")*0.5 ;

				}
			}

			if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")) {

	            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST2=dsT_EV_ABLRST2)";
	            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.k.vluk090.cmd.VLUK090CMD&S_MODE=SAV_EXE";
	            trT_EV_ABLRST.post();

				fnc_SearchList();

			}

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
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
            cfErrorMsg(this);
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

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">������������</font></td>
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
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_execute.gif',1)"><img src="/images/button/btn_execute.gif"   name="Image1"   border="0" align="absmiddle" onClick="fnc_Execute()"></a>-->
			&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_Grade.gif',1)"><img src="/images/button/btn_Grade.gif"   name="Image2"   border="0" align="absmiddle" onClick="fnc_Grade()"></a>
			&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td align="center" class="greenTable">
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
		               <colgroup>
		                    <col width="70"></col>
		                    <col width="100"></col>
		                    <col width="70"></col>
		                    <col width="140"></col>
		                    <col width="50"></col>
		                    <col width="*"></col>
		               </colgroup>
		               		<tr>
                                <td class="searchState" align="center">������</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                                </td>
								<td class="searchState" align="center">�����</td>
								<td >
									<input id="txtENOH_NO_SHR" name="txtENOH_NO_SHR" size="7" maxlength="7"  onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENOH_NO_SHR','txtENOH_NM_SHR');">
									<input id="txtENOH_NM_SHR" name="txtENOH_NM_SHR" size="8" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENOH_NO_SHR', 'txtENOH_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENOH_NO_SHR','txtENOH_NM_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENOH_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENOH_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENOH_NO_SHR','txtENOH_NM_SHR');"></a>
								</td>
								<td class="searchState" align="center">����</td>
                                <td class="padding2423" style="width:150" >
                                    <fieldset>
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" value="0">������
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="1">�����
                                    </fieldset>
                                </td>
				            </tr>
							<tr class="paddingTop5" >
								<td class="searchState" align="center">����</td>
				                <td class="padding2423" align="left">
									<select id="cmbEVA_SEQ" style="width:100">
										<option value="0">��ü</option>
										<option value="1">�繫��</option>
										<option value="2">������</option>
										<option value="3">�����</option>
										<option value="4">��Ÿ</option>
										<option value="5">��������</option>
									</select>
				                </td>
								<td class="searchState" align="center">�������</td>
								<td class="padding2423">
									<input type="checkbox" name="goga1" style="border:0" onClick="if(this,this.checked) {goga1.value = 'T'}else{goga1.value = ''}">����
								</td>							
								<td class="searchState" align="center">����</td>
								<td colspan="3">
		                        <select id="cmbJOB_CD_FROM" style="width:100px;" onChange="">
		                        </select>
		                        &nbsp;~&nbsp;
		                        <select id="cmbJOB_CD_TO" style="width:100px;" onChange="">
		                        </select>
				                </td>
						</tr>
             	</table>
        	</td>
    	</tr>
</table>
<!-- power Search���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='EMPNO'     width=50   	name='���'    		align=center    edit=none </FC>
                                    <FC> id='DEPTNM'    width=110   name='�Ҽ�'   		align=left    	edit=none </FC>
                                    <FC> id='GRDNM'    	width=65   	name='����'   		align=left    	edit=none </FC>
                                    <FC> id='EMPNMK'   	width=75  	name='�ǰ����'  	align=left      edit=none </FC>

								<G> Name='��ݱ�' HeadAlign=Center HeadBgColor=#F7DCBB
                                    <C> id='SCR11'   	width=60  	name='1��'      	align=center    dec = 3 edit=none value={IF (SCR11='0','',SCR11)}</C>
                                    <C> id='GOG11'   	width=60  	name='�����'      	align=center    edit=none</C>

                                    <C> id='SCR12'   	width=60  	name='2��'      	align=center    dec = 3 edit=none value={IF (SCR12='0','',SCR12)}</C>
                                   <C> id='GOG12'   	width=60  	name='�����'      	align=center    edit=none</C>

                                    <C> id='SCR13'   	width=60  	name='3��'      	align=center    dec = 3 edit=none value={IF (SCR13='0','',SCR13)}</C>                                                                        								
                                   <C> id='GOG13'   	width=60  	name='�����'      	align=center    edit=none</C>

                                    <C> id='SCR14'   	width=60  	name='�μ���'      	align=center    dec = 3 edit=none value={IF (SCR14='0','',SCR14)}</C>                                                                        								
 
                                    <C> id='TOTAVG1'     width=55   	name='����'      	align=center    edit=none </C>
                                </G>                                    

								<G> Name='�Ϲݱ�' HeadAlign=Center HeadBgColor=#F7DCBB
                                    <C> id='SCR21'   	width=60  	name='1��'      	align=center    dec = 3 edit=none value={IF (SCR21='0','',SCR21)} </C>
                                   <C> id='GOG21'   	width=60  	name='�����'      	align=center    edit=none</C>

                                    <C> id='SCR22'   	width=60  	name='2��'      	align=center    dec = 3 edit=none value={IF (SCR22='0','',SCR22)} </C>
                                   <C> id='GOG22'   	width=60  	name='�����'      	align=center    edit=none</C>

                                    <C> id='SCR23'   	width=60  	name='3��'      	align=center    dec = 3 edit=none value={IF (SCR23='0','',SCR23)} </C>     
                                   <C> id='GOG23'   	width=60  	name='�����'      	align=center    edit=none</C>

                                    <C> id='SCR24'   	width=60  	name='�μ���'      	align=center    dec = 3 edit=none value={IF (SCR24='0','',SCR24)} </C>     

                                    <C> id='TOTAVG2'     width=55   	name='����'      	align=center    edit=none </C>
                                </G>    
                                    <C> id='TOTAVG_FINAL'     width=50   	name='����;����'    align=center    edit=none bgcolor='#F5F6CE'</C>
                                    <C> id='GRADE'      width=50   	name='���;���'   	align=center    edit=none bgcolor='#F5D0A9'</C>
								<G> Name='�����������' HeadAlign=Center HeadBgColor=#F7DCBB
                                    <C> id='GRADE2'     width=70   	name='������'      	align=center    bgcolor='#F7BE81'</C>
                                    <C> id='GRADE3'     width=75   	name='��ǥ�̻�'   	align=center    bgcolor='#FAAC58'</C>
                                </G>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                     </tr>
					 <tr>
							<td> <P>&nbsp;&nbsp;<BR>
									&nbsp;&nbsp;* ��޻��� : �������� �������� ��� ��� ������.(������ �� ��ǥ�̻� ������������� ���� ������ ������)<BR>
							        &nbsp;&nbsp;* ��� ���� ��ư�� ������, ����� ���� �� ���� �����ϸ� �˴ϴ�.<BR>
							        &nbsp;&nbsp;* ������, ������ �� ��ǥ�̻� ������������� ���� ���� �Ŀ��� ���� ��ư���� �����ϸ� ���� �˴ϴ�.<BR>
									&nbsp;&nbsp;* ��, ���� ������ ��� �ٽ�  ��޻��� ��ư�� ������ ���� ���� ����� ������ ���� �ȵ˴ϴ�.
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


