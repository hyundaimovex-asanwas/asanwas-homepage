<!--
    ************************************************************************************
    * @source         : saga200.jsp 				                                   *
    * @description   : ���κ��󼼳���(��) PAGE.                                                  *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/09/08  |  �̵���   | erp�� �̻�                                               		   *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���κ��󼼳���(��)</title>
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
		var btnList = 'T';
        var savObj = new Array();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // ���س⵵     	
			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���

			//�������ڰ� ������ ��ȸ ����.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}


	        dsT_CP_PAYTABLE.UseChangeInfo = true;
	        dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga200.cmd.SAGA200CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	        dsT_CP_PAYTABLE.Reset();

        }
        
        /***********************************
         *        01. �Ⱓ�ҵ�� ��ȸ  		   *
         ***********************************/
        function fnc_SearchList_Year() {

			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // ���س⵵ 	
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���

			//�������ڰ� ������ ��ȸ ����.
			if(PAY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("���س⵵�� �Է��ϼ���.");
					document.getElementById("txtPAY_YMD_SHR").focus();
					return false;
				}
			}

            //�����ͼ� ����
            dsT_CP_PAYTABLE.UseChangeInfo = true;
            dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga200.cmd.SAGA200CMD&S_MODE=SHR_ALL&PAY_YMD="+PAY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CP_PAYTABLE.Reset();

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

			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // ���س⵵        	
			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���


			//�������ڰ� ������ ��ȸ ����.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}


	        dsT_Grid_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga200.cmd.SAGA200CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	        dsT_Grid_Detail.Reset();

			var ls_temp = "CUDATE:STRING,CTITLE:STRING";

			dsT_RP_PAYTABLE.SetDataHeader(ls_temp);
			dsT_RP_PAYTABLE.Addrow();
			dsT_RP_PAYTABLE.namevalue(1,"CUDATE")=getToday();

			var yyyymmdd = document.getElementById("txtAPY_YMD_SHR").value; // ��������
			var yyyy = yyyymmdd.substring(0,4);
			var mm = yyyymmdd.substring(5,7);

			dsT_RP_PAYTABLE.namevalue(1,"CTITLE")= " �޿����� [" + yyyy + "��" + mm + "��]";

			gcrp_print.Preview();

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYTABLE.GridToExcel("�޿����̺�", '', 225);

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

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
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

			document.getElementById("txtPAY_YMD_SHR").value = '2015';            	
			document.getElementById("txtAPY_YMD_SHR").value = '2015-01-25';
			document.getElementById("txtAPY_YMD_SHR").focus();
    	
        	
			fnc_ChangeGrid();      //�׸��� ���� ó��

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17. �������� ���ε� ó��  *
         ****************************/
         function fnc_FileUpload() {



        }

        /*************************
         * �׸��� ���� ó��      *
         ************************/
		function fnc_ChangeGrid(obj) {


			if(obj == undefined || obj.value == "1"){
				
			form1.grdT_CP_PAYTABLE.Format =
					"<FC> id='{CUROW}'			width=40		name='NO'					align=center	value={String(Currow)}		BgColor='#EEEEEE'	SubSumText=''	</FC>" +
					"<FC> id='DPT_NM'        	width=90        name='�Ҽ�'         		align=center   </FC>" +
					"<FC> id='JOB_NM'        	width=65        name='����'        			align=center   </FC>" +
					"<FC> id='ENO_NM'        	width=60        name='����'          		align=center   SubSumText='�հ�' </FC>" +
					"<C> id='ENO_NO'        	width=60        name='���'          		align=center   </C>" +
					"<C> id='CET_NO'       		width=100       name='�ֹι�ȣ'        		align=center   </C>" +
					"<C> id='BAS_AMT'       	width=75        name='�⺻��'        		align=right    </C>" +
					"<C> id='DUTY_AMT'       	width=75        name='��å����'        		align=right    </C>" +
					"<C> id='LAW_AMT'       	width=75        name='�ð���'        		align=right    </C>" +
					"<C> id='LSEV_AMT'       	width=75        name='�ټӼ���'      		align=right    </C>" +
					"<C> id='ETC_AMT_11'      	width=90        name='�ڱ��ߺ�'      		align=right    </C>" +
					"<C> id='ETC_AMT_12'      	width=90        name='���ϰ���'      	    align=right    </C>" +
					"<C> id='BNS_AMT'       	width=75        name='�󿩺���'        		align=right    </C>" +
					"<C> id='ETC_AMT4'       	width=85        name='�����ξ��'        	align=right    </C>" +
					"<C> id='ETC_AMT'       	width=90        name='����������'     		align=right    </C>" +
					"<C> id='ETC_AMT_06'      	width=90        name='�ⳳ����'     	    align=right    </C>" +
					"<C> id='ETC_AMT_17'      	width=90        name='��������'      	    align=right     </C>" +
					"<C> id='ETC_AMT_18'      	width=90        name='�������'      	    align=right     </C>" +
					"<C> id='ETC_AMT_20'      	width=90        name='�ڰݼ���'      	    align=right     </C>" +
					"<C> id='ETC_AMT_19'      	width=90        name='����ܼ���'      		align=right     </C>" +
					"<C> id='ETC_AMT_13'      	width=90        name='Ư��������'      		align=right     </C>" +
					"<C> id='ETC_AMT_012'    	width=100       name='�����ٹ�(��)'      	align=right     </C>" +
					"<C> id='ETC_AMT2'       	width=100       name='�����ٹ�����'      	align=right     </C>" +
					"<C> id='ETC_AMT_013'    	width=100       name='�������(��)'     	align=right     </C>" +
					"<C> id='SCH_AMT'       	width=90        name='���ڱ�'      	    	align=right     </C>" +
					"<C> id='PPEN_AMT'       	width=75        name='���ο���'      		align=right    </C>" +
					"<C> id='ETC_AMT_HY'     	width=100       name='������å����'     	align=right     </C>" +
					"<C> id='ETC_AMT3'       	width=90        name='�Ĵ�'      	    	align=right     </C>" +
					"<C> id='ETC_AMT_23'     	width=90        name='�����ұ�'     		align=right     </C>" +
					"<C> id='ETC_AMT_BD'     	width=100       name='���ϱٹ�����'     	align=right     </C>" +
					"<C> id='ETC_AMT_117'    	width=100       name='�¼�����'     		align=right     </C>" +
					"<C> id='ETC_AMT_BA'      	width=90        name='��Ÿ����'      	    align=right     </C>" +
					"<C> id='SALT_AMT'      	width=75        name='�޿��Ѱ�'      		align=right    BgColor='#99FF99' </C>" +

					"<G> name='����' 		BgColor='#dae0ee'   "+
					"<C> id='INCM_TAX'       	width=75       	name='�ҵ漼'      		    align=right    </C>" +
					"<C> id='CITI_TAX'       	width=75        name='�ֹμ�'        	    align=right    </C>" +
					"<C> id='NPEN_AMT'       	width=75        name='���ο���'     	    align=right    </C>" +
					"<C> id='HINU_AMT'       	width=85        name='�ǷẸ���'      		align=right    </C>" +
					"<C> id='OLD_AMT'       	width=95        name='����纸��'    		align=right    </C>" +
					"<C> id='HINS_AMT'       	width=75        name='��뺸��'      	    align=right    </C>" +
					"<C> id='LAB_AMT'       	width=75        name='��������'      	    align=right    </C>" +
					"<C> id='PPED_AMT'       	width=75        name='���ο���'     		align=right    </C>" +
					"<C> id='ETC_AMT_21'      	width=85        name='���������'     		align=right    </C>" +
					"<C> id='DHLP_AMT'       	width=75        name='����ȸ��'      		align=right    </C>" +
					"<C> id='LON_RPY'       	width=80        name='�系����'       		align=right    </C>" +
					"<C> id='LON_INT'       	width=80        name='��ȯ����'     		align=right    </C>" +
					"<C> id='LON_RPY2'       	width=80        name='��������' 			align=right    </C>" +
					"<C> id='LON_INT2'       	width=80        name='��ȯ����'  			align=right    </C>" +
					"<C> id='ETC_AMT_A1'     	width=95        name='�ǰ���������'  		align=right    </C>" +
					"<C> id='ETC_AMT_A2'      	width=95        name='��뺸������'  		align=right    </C>" +
					"<C> id='ETC_AMT_A3'     	width=95        name='��������ҵ�'  		align=right    	</C>" +
					"<C> id='ETC_AMT_A4'      	width=95        name='���������ֹ�'  		align=right    	</C>" +
					"<C> id='ETC_AMT_A6'      	width=95        name='���������Ư'  		align=right    	</C>" +					
					"<C> id='ETC_AMT_ETC'    	width=75        name='��Ÿ'      			align=right    </C>" +
					"<C> id='DDTT_AMT'       	width=80        name='�����װ�'     		align=right    BgColor='#FFFF99'</C>" +
					"</G>"+
					"<C> id='PAY_AMT'       	width=85        name='�Ǽ��ɾ�'   			align=right    BgColor='#FF9999'</C>" +
					"<C> id='PIS_YYMM'       	width=120       name='���޳��'     		align=center        </C>" +					
					"<C> id='TAX_DPT2'       	width=120       name='ȸ��Ҽ�'     		align=left          </C>" +
					"<C> id='GBN_NM'       		width=120       name='�ٹ���'     			align=left          </C>";
			}


			//ù��° �μ� : �׸����
			//�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)
			//�׹�° �μ� : sort��� ��뿩��(false:�̻��, true:sort���)

			cfStyleGrid_New(form1.grdT_CP_PAYTABLE, 15,"false","true");

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
    | 2. �̸� : dsT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr        value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>




    <!----------------------------------------------+
    | 1. ����Ʈ�� DataSet                     		|
    | 2. �̸� : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_Grid_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
    	<param name="SubsumExpr"   		value="1:TAX_DPT">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>


    <!--*************************************
    *                                      *
    *  Component���� �߻��ϴ� Event ó���� *
    *                                      *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>



    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[��������/��������/����/���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("��������/�ٷα���/����/ȣ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearSalary','','../../images/button/btn_YearSalaryOver.gif',1)"><img src="../../images/button/btn_YearSalaryOn.gif" name="imgYearSalary" border="0" align="absmiddle" onClick="fnc_SearchList_Year()"></a>
			&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
								<col width="200"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>

								<td align="center" class="searchState">���س⵵</td>
								<td>
								<input id="txtPAY_YMD_SHR" style="width:83" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								</td>
								<td align="center" class="searchState">��������</td>
								<td>
									<input id="txtAPY_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','535','112');"></a>
								</td>

								<td align="center" class="searchState">�����ȣ</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
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
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                    </td>
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
						<object	id="grdT_CP_PAYTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_CP_PAYTABLE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
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
			R E P O R T   D E F I N I T I O N   -   #### �� �� �� �� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_RP_PAYTABLE">
	<param name="DetailDataID"	    			value="dsT_Grid_Detail">
	<PARAM NAME="PaperSize"						VALUE="A3">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="110">
	<PARAM NAME="Format" 						VALUE="

<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1405, top=56, right=2474, bottom=143, face='HY�߰��', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<T>id='���� : ��' ,left=3784 ,top=122 ,right=4001 ,bottom=169 ,align='right' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3704, top=82, right=4001, bottom=122, align='right', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=3450 ,top=61 ,right=3699 ,bottom=122 ,align='right' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=249 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3998 ,top=3 ,right=24 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=614 ,top=3 ,right=614 ,bottom=249 </L>
	<L> left=254 ,top=3 ,right=254 ,bottom=249 </L>
	<T>id='�⺻��' ,left=638 ,top=13 ,right=849 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=3 ,right=24 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2553 ,top=5 ,right=2553 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=246 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='��å����' ,left=638 ,top=74 ,right=849 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȣ����' ,left=635 ,top=191 ,right=849 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð���' ,left=638 ,top=130 ,right=849 ,bottom=188 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ٹ�����' ,left=1389 ,top=191 ,right=1648 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ټӼ���' ,left=902 ,top=13 ,right=1114 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ĵ�' ,left=1662 ,top=191 ,right=1921 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ް�' ,left=2254 ,top=191 ,right=2529 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ����' ,left=2254 ,top=16 ,right=2529 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�󿩺���' ,left=2254 ,top=74 ,right=2529 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ұ�' ,left=1971 ,top=13 ,right=2201 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ϱٹ�����' ,left=1942 ,top=71 ,right=2201 ,bottom=130 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�¼�����' ,left=1958 ,top=130 ,right=2201 ,bottom=188 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������å����' ,left=1662 ,top=130 ,right=1921 ,bottom=185 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ڱ�' ,left=1699 ,top=74 ,right=1921 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���' ,left=1699 ,top=13 ,right=1921 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��������' ,left=1389 ,top=130 ,right=1648 ,bottom=185 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ܼ���' ,left=1389 ,top=74 ,right=1648 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ϰ�������' ,left=1389 ,top=13 ,right=1648 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڰݼ���' ,left=1162 ,top=196 ,right=1373 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=1162 ,top=130 ,right=1373 ,bottom=191 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1162 ,top=77 ,right=1373 ,bottom=135 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ⳳ' ,left=1162 ,top=16 ,right=1373 ,bottom=74 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڱ��ߺ�' ,left=902 ,top=74 ,right=1114 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ξ��' ,left=902 ,top=130 ,right=1114 ,bottom=185 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����������' ,left=902 ,top=191 ,right=1114 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ǽ��ɾ�' ,left=3778 ,top=191 ,right=3990 ,bottom=249 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ҽ�' ,left=275 ,top=13 ,right=553 ,bottom=71 ,align='left' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=249 ,right=4006 ,bottom=249 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='���' ,left=37 ,top=13 ,right=249 ,bottom=71 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=37 ,top=130 ,right=249 ,bottom=185 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=37 ,top=191 ,right=249 ,bottom=249 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=37 ,top=74 ,right=249 ,bottom=127 ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����������' ,left=275 ,top=74 ,right=556 ,bottom=127 ,align='left' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=2580 ,top=130 ,right=2831 ,bottom=185 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���' ,left=2836 ,top=21 ,right=3135 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ī��' ,left=3461 ,top=74 ,right=3709 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ����' ,left=3741 ,top=19 ,right=3990 ,bottom=69 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=3778 ,top=130 ,right=3990 ,bottom=185 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ȸ����' ,left=3461 ,top=21 ,right=3709 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=3175 ,top=130 ,right=3424 ,bottom=191 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ȸ��' ,left=3175 ,top=188 ,right=3424 ,bottom=238 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�系����' ,left=3175 ,top=21 ,right=3424 ,bottom=77 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ο���' ,left=3175 ,top=77 ,right=3424 ,bottom=130 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��뺸��' ,left=2836 ,top=130 ,right=3135 ,bottom=183 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǰ�����' ,left=2836 ,top=74 ,right=3135 ,bottom=132 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼' ,left=2580 ,top=74 ,right=2831 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=2580 ,top=16 ,right=2831 ,bottom=71 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������ҵ�' ,left=3437 ,top=130 ,right=3736 ,bottom=183 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������ֹ�' ,left=3437 ,top=191 ,right=3736 ,bottom=243 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������Ư' ,left=3758 ,top=71 ,right=3990 ,bottom=127 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='�ǰ����� ����' ,left=2577 ,top=191 ,right=2839 ,bottom=243 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��뺸�� ����' ,left=2876 ,top=188 ,right=3138 ,bottom=241 ,align='right' ,face='HY�߰��' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=224 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=159 ,right=857 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3752 ,top=161 ,right=3995 ,bottom=220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3752 ,top=101 ,right=3995 ,bottom=156 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2207 ,top=159 ,right=2527 ,bottom=212 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=614 ,top=0 ,right=614 ,bottom=222 </L>
	<L> left=2556 ,top=0 ,right=2556 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=222 </L>
	<L> left=24 ,top=222 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,,ENO_NO)}', left=37, top=0, right=249, bottom=50, supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,ENO_NM)}', left=37, top=56, right=249, bottom=103, supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'�� ��\',JOB_NM)}', left=37, top=106, right=249, bottom=156, supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(ENO_NO))}', left=265, top=111, right=474, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'��\')}', left=487, top=111, right=532, bottom=161, align='left', supplevel=1, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(curlevel,1,,TEAM_NM)}', left=267, top=61, right=614, bottom=156, align='left', supplevel=1, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<C>id='{decode(curlevel,1,,DPT_NM)}', left=267, top=13, right=614, bottom=58, align='left', supplevel=1, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<C>id='{decode(BAS_AMT,0,,BAS_AMT)}', left=627, top=0, right=852, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DUTY_AMT,0,,DUTY_AMT)}', left=627, top=56, right=852, bottom=103, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LAW_AMT,0,,LAW_AMT)}', left=627, top=106, right=852, bottom=156, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_BAS_DUTY_LAW', left=627, top=159, right=852, bottom=212, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(LSEV_AMT,0,,LSEV_AMT)}', left=878, top=0, right=1114, bottom=50, align='right', supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_11,0,,ETC_AMT_11)}', left=878, top=56, right=1114, bottom=106, align='right', supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT4,0,,ETC_AMT4)}', left=876, top=106, right=1114, bottom=156, align='right', supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT,0,,ETC_AMT)}', left=878, top=159, right=1114, bottom=212, align='right', supplevel=2, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_06,0,,ETC_AMT_06)}', left=1135, top=0, right=1373, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_17,0,,ETC_AMT_17)}', left=1138, top=56, right=1373, bottom=103, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_18,0,,ETC_AMT_18)}', left=1135, top=106, right=1373, bottom=156, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_20,0,,ETC_AMT_20)}', left=1138, top=159, right=1373, bottom=212, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_12,0,,ETC_AMT_12)}', left=1394, top=0, right=1646, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_19,0,,ETC_AMT_19)}', left=1394, top=56, right=1646, bottom=103, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_13,0,,ETC_AMT_13)}', left=1389, top=106, right=1643, bottom=156, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT2,0,decode(ETC_AMT_099,0,,ETC_AMT_099),ETC_AMT2)}', left=1394, top=159, right=1646, bottom=212, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PPEN_AMT,0,,PPEN_AMT)}', left=1672, top=0, right=1921, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(SCH_AMT,0,,SCH_AMT)}', left=1672, top=56, right=1921, bottom=103, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_HY,0,,ETC_AMT_HY)}', left=1667, top=106, right=1916, bottom=156, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT3,0,,ETC_AMT3)}', left=1672, top=159, right=1921, bottom=212, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_23,0,,ETC_AMT_23)}', left=1953, top=0, right=2199, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_BD,0,,ETC_AMT_BD)}', left=1953, top=56, right=2199, bottom=106, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_117,0,,ETC_AMT_117)}', left=1953, top=108, right=2199, bottom=159, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_BA,0,,ETC_AMT_BA)}', left=2217, top=0, right=2524, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SALT_AMT', left=2217, top=159, right=2524, bottom=209, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(BNS_AMT,0,,BNS_AMT)}', left=2217, top=56, right=2524, bottom=103, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SOU_CNT', left=2580, top=0, right=2606, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'��\')}', left=2609, top=21, right=2633, bottom=21</C>
	<C>id='DFM_CNT', left=2635, top=0, right=2662, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'��\')}', left=2662, top=21, right=2686, bottom=21</C>
	<C>id='CHI_CNT', left=2688, top=0, right=2715, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'��\')}', left=2717, top=21, right=2741, bottom=21</C>
	<C>id='TRB_CNT', left=2741, top=0, right=2770, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,\'��\')}', left=2770, top=21, right=2794, bottom=21</C>
	<C>id='GOL_CNT', left=2797, top=0, right=2823, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=2580, top=56, right=2831, bottom=106, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=2580, top=108, right=2831, bottom=161, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(NPEN_AMT,0,,NPEN_AMT)}', left=2839, top=0, right=3135, bottom=50, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(HINU_AMT+OLD_AMT,0,,HINU_AMT+OLD_AMT)}', left=2839, top=56, right=3135, bottom=108, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(HINS_AMT,0,,HINS_AMT)}', left=2839, top=108, right=3135, bottom=159, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LON_RPY+LON_INT,0,,LON_RPY+LON_INT)}', left=3175, top=0, right=3424, bottom=53, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PPED_AMT,0,,PPED_AMT)}', left=3175, top=56, right=3424, bottom=106, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LAB_AMT,0,,LAB_AMT)}', left=3175, top=108, right=3424, bottom=159, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DHLP_AMT,0,,DHLP_AMT)}', left=3175, top=167, right=3424, bottom=217, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LON_RPY2+LON_INT2,0,,LON_RPY2+LON_INT2)}', left=3474, top=0, right=3707, bottom=53, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_21,0,,ETC_AMT_21)}', left=3474, top=56, right=3707, bottom=106, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DDTT_AMT,0,,DDTT_AMT)}', left=3757, top=103, right=3993, bottom=159, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='PAY_AMT', left=3757, top=161, right=3993, bottom=217, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(HOB_NM,0,,HOB_NM)}', left=37, top=164, right=243, bottom=214, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A3,0,,ETC_AMT_A3)}', left=3474, top=111, right=3707, bottom=161, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A4,0,,ETC_AMT_A4)}', left=3474, top=167, right=3707, bottom=217, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_ETC,0,,ETC_AMT_ETC)}', left=3760, top=0, right=3993, bottom=53, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A6,0,,ETC_AMT_A6)}', left=3757, top=45, right=3990, bottom=98, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A1,0,,ETC_AMT_A1)}', left=2577, top=167, right=2828, bottom=217, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(ETC_AMT_A2,0,,ETC_AMT_A2)}', left=2844, top=164, right=3138, bottom=214, align='right', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>

</B>
<B>id=LDFooter ,left=0,top=0 ,right=4101 ,bottom=222 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=4003 ,top=0 ,right=4003 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=4006 ,top=0 ,right=29 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=614 ,top=0 ,right=614 ,bottom=222 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=222 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<X>left=614 ,top=167 ,right=876 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2215 ,top=167 ,right=2535 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3747 ,top=116 ,right=3998 ,bottom=164 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3747 ,top=167 ,right=3998 ,bottom=209 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� ��' ,left=50 ,top=103 ,right=222 ,bottom=153 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ѿ�' ,left=278 ,top=103 ,right=423 ,bottom=153 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=394 ,top=103 ,right=516 ,bottom=153 ,align='right' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='��' ,left=521 ,top=103 ,right=574 ,bottom=153 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BAS_AMT)}' ,left=638 ,top=5 ,right=868 ,bottom=56 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(DUTY_AMT)}' ,left=651 ,top=66 ,right=868 ,bottom=119 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(LAW_AMT)}' ,left=651 ,top=122 ,right=868 ,bottom=172 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(SUM_BAS_DUTY_LAW)}' ,left=624 ,top=167 ,right=873 ,bottom=209 ,align='right' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{Sum(LSEV_AMT)}' ,left=886 ,top=5 ,right=1130 ,bottom=56 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_11)}' ,left=889 ,top=61 ,right=1130 ,bottom=108 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT4)}' ,left=889 ,top=116 ,right=1130 ,bottom=164 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT)}' ,left=889 ,top=175 ,right=1130 ,bottom=220 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_06)}' ,left=1151 ,top=3 ,right=1392 ,bottom=61 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_17)}' ,left=1151 ,top=61 ,right=1392 ,bottom=116 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_18)}' ,left=1151 ,top=119 ,right=1392 ,bottom=169 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_20)}' ,left=1151 ,top=172 ,right=1392 ,bottom=222 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_12)}' ,left=1418 ,top=5 ,right=1670 ,bottom=56 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_19)}' ,left=1418 ,top=61 ,right=1670 ,bottom=114 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_13)}' ,left=1418 ,top=116 ,right=1670 ,bottom=167 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_999)}' ,left=1418 ,top=169 ,right=1670 ,bottom=220 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(PPEN_AMT)}' ,left=1688 ,top=0 ,right=1937 ,bottom=64 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(SCH_AMT)}' ,left=1688 ,top=61 ,right=1937 ,bottom=114 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_HY)}' ,left=1688 ,top=111 ,right=1937 ,bottom=161 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT3)}' ,left=1688 ,top=169 ,right=1937 ,bottom=220 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(ETC_AMT_23)}' ,left=1953 ,top=5 ,right=2204 ,bottom=61 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(ETC_AMT_BD)}' ,left=1953 ,top=61 ,right=2204 ,bottom=111 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(ETC_AMT_117)}' ,left=1953 ,top=114 ,right=2204 ,bottom=164 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(BNS_AMT)}' ,left=2215 ,top=64 ,right=2535 ,bottom=114 ,align='right' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(SALT_AMT)}' ,left=2215 ,top=167 ,right=2529 ,bottom=209 ,align='right' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{Sum(INCM_TAX)}' ,left=2580 ,top=56 ,right=2831 ,bottom=106 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(CITI_TAX)}' ,left=2580 ,top=114 ,right=2831 ,bottom=164 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(NPEN_AMT)}' ,left=2839 ,top=0 ,right=3135 ,bottom=50 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(HINU_AMT+OLD_AMT)}', left=2839, top=56, right=3135, bottom=106, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(HINS_AMT)}' ,left=2839 ,top=114 ,right=3135 ,bottom=164 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{Sum(LAB_AMT)}', left=3159, top=119, right=3408, bottom=169, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(DHLP_AMT)}' ,left=3159 ,top=169 ,right=3408 ,bottom=220 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_21)}' ,left=3469 ,top=64 ,right=3709 ,bottom=114 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_A3)}' ,left=3469 ,top=119 ,right=3709 ,bottom=167 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_A4)}' ,left=3469 ,top=172 ,right=3709 ,bottom=220 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(DDTT_AMT)}' ,left=3752 ,top=114 ,right=3993 ,bottom=161 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(PAY_AMT)}' ,left=3752 ,top=167 ,right=3993 ,bottom=209 ,align='right' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<L> left=24 ,top=222 ,right=4006 ,bottom=222 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=4003 ,top=222 ,right=26 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='{SUM(ETC_AMT_BA)}' ,left=2223 ,top=8 ,right=2537 ,bottom=64 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(PPED_AMT)}' ,left=3159 ,top=58 ,right=3408 ,bottom=108 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(LON_RPY+LON_INT)}', left=3159, top=3, right=3408, bottom=53, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(LON_RPY2+LON_INT2)}', left=3466, top=5, right=3707, bottom=56, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{Sum(ETC_AMT_A6)}', left=3749, top=64, right=3990, bottom=106, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(ETC_AMT_ETC)}', left=3749, top=8, right=3990, bottom=50, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(ETC_AMT_A1)}' ,left=2588 ,top=167 ,right=2828 ,bottom=214 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(ETC_AMT_A2)}' ,left=2844 ,top=167 ,right=3135 ,bottom=214 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>


</B>
<B>id=Footer ,left=0 ,top=2769 ,right=4101 ,bottom=2870 ,face='Tahoma' ,size=12 ,penwidth=1
	<T>id='#p/#t' ,left=773 ,top=3 ,right=3580 ,bottom=82</T>
</B>





">
</OBJECT>




</body>
</html>