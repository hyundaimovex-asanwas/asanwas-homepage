<!--
*****************************************************
* @source       : VLUK060.jsp
* @description : ���ǥ ���Է� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/10/10     �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���ǥ ���Է�</title>
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


		var chkValid  = 'T';


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	//�˻�����
			var REG_YM_SHR   = document.getElementById("txtREG_YM_SHR").value;      	//��û��
			var GBMST_STR   = document.getElementById("cmbGBMST_STR").value;      	//����
			var DTP_CD_SHR   = document.getElementById("txtDTP_CD_SHR").value;      	//�Ҽ�
			var DTP_CD_SHR2   = document.getElementById("txtDTP_CD_SHR2").value;      	//�Ҽ�2
			var JOB_CD_SHR       = document.getElementById("cmbJOB_CD_SHR").value; //����
			var JOB_CD_SHR2       = document.getElementById("cmbJOB_CD_SHR2").value;  //����2
			var JIKMU_CD_SHR       = document.getElementById("cmbJIKMU_CD_SHR").value;  //����

            //��ȸ �ش����� �����Ѵ�.
			if(REG_YM_SHR=='9999-99'){

			dsT_EV_RQSHEET.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk060.cmd.VLUK060CMD"
                                      + "&S_MODE=SHR"
                                      + "&REG_YM_SHR="+REG_YM_SHR
                                      + "&GBMST_STR="+GBMST_STR;
			dsT_EV_RQSHEET.reset();


        }else {

			dsT_EV_RQSHEET.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk060.cmd.VLUK060CMD"
                                      + "&S_MODE=SHR02"
                                      + "&REG_YM_SHR="+REG_YM_SHR
                                      + "&GBMST_STR="+GBMST_STR
                                      + "&DTP_CD_SHR="+DTP_CD_SHR
                                      + "&JOB_CD_SHR="+JOB_CD_SHR
                                      + "&JIKMU_CD_SHR="+JIKMU_CD_SHR;
			dsT_EV_RQSHEET.reset();

            }
			
			// ����Ű��ȯ
			for (var i = 1; i <= dsT_EV_RQSHEET.CountRow; i++) {

				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\n","");
				dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM") = dsT_EV_RQSHEET.nameValue(i, "ACT_ITEM").replace("\r","");	
			}
			
			dsT_EV_RQSHEET.ResetStatus();				
			
			
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

            var REG_YM_SHR = document.form1.gcem_yymm2.text;        							//������
  		  	var HEAD_CD = document.form1.txtDTP_CD_SHR2.value;
  		  	var JOB_CD = document.form1.cmbJOB_CD_SHR2.value;
  		  	var JIKMU_CD = document.form1.gclx_jobgrphcd.BindColVal;
  		  	var T_SCR = document.form1.txt_t_scr.value;
  		  	
			//alert(REG_YM_SHR);
			//alert(HEAD_CD);
			//alert(JOB_CD);
			//alert(JIKMU_CD);			
			//alert(T_SCR);			
  		  	
        	trT_EV_RQGROUP.KeyValue = "tr01(I:dsT_EV_RQGROUP=dsT_EV_RQGROUP)";
        	trT_EV_RQGROUP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk060.cmd.VLUK060CMD&S_MODE=SAV&REG_YM_SHR="+REG_YM_SHR+"&HEAD_CD="+HEAD_CD+"&JOB_CD="+JOB_CD+"&JIKMU_CD="+JIKMU_CD+"&T_SCR="+T_SCR;
        	trT_EV_RQGROUP.post();
  	
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/


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
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
			if (dsT_EV_RQSHEET.countrow<1){
				alert ("������ ������ �����ϴ�.");
			}else {

				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){

					for (var i=dsT_EV_RQSHEET.CountRow; i>0; i--){
							//prompt(this, dsT_EV_RQSHEET.text);
							//var BCHK = dsT_EV_RQSHEET.nameValue(dsT_EV_RQSHEET.RowPosition, "BCHK");

						if (dsT_EV_RQSHEET.namevalue(i,"BCHK") == "T"){

							dsT_EV_RQSHEET.deleterow(i);


						}

				}
						//prompt(this, dsT_EV_RQSHEET.text);

					//var HEAD_CD = dsT_EV_RQSHEET.namevalue(i,"HEAD_CD") ;

					        trT_EV_RQSHEET.KeyValue = "tr01(I:dsT_EV_RQSHEET=dsT_EV_RQSHEET)";
					        trT_EV_RQSHEET.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk060.cmd.VLUK060CMD&S_MODE=DEL";

					        
					        trT_EV_RQSHEET.post();
							fnc_SearchList();

			}
        }
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
        	
            //�����ϴ� �͵� ����

			for( var i = 1; i <= dsT_CM_COMMON_EC.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_EC.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_EC.NameValue(i,"CODE_NAME");
				document.getElementById("cmbJOB_CD_SHR").add(oOption);
			}

			for( var i = 1; i <= dsT_CM_COMMON_EC2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_EC2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_EC2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbJOB_CD_SHR2").add(oOption);
			}


			
            //��¥���� ���ε�
            var svc_ymd     = gcurdate;

            //svc_ymd     = addDate("M", gcurdate, 1);

			//document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);
			document.getElementById("txtREG_YM_SHR").value = '9999-99';


			if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "6050006" && gusrid != "2050045" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2140002" && gusrid != "2030007" ){ 


            document.getElementById("txtDTP_CD_SHR").value = "";// �Ҽ�
            document.getElementById("txtDTP_NM_SHR").value = "";// �Ҽ�

            fnc_ChangeStateElement(false, "txtDTP_CD_SHR");


            document.getElementById("txtDTP_CD_SHR2").value = "";// �Ҽ�
            document.getElementById("txtDTP_NM_SHR2").value = "";// �Ҽ�

            //fnc_ChangeStateElement(false, "txtDTP_CD_SHR2");

            fnc_ChangeStateElement(false, "ImgDptCd");


		    }


        	cfStyleGrid_New(form1.grdT_EV_RQSHEET,15,"true","true");     // Grid Style ����

			cfStyleGrid_New(form1.grdT_EV_RQGROUP,15,"false","true");      // Grid Style ����

            //document.getElementById("resultMessage").innerText = '�۾�����: ��û�� > ��ȸ��ư > ��ȸ';


            fnc_SearchList();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


		/********************
         * 16. ���ǥ �Է�  *
         *******************/
		function fnc_addarrow() {

			if (dsT_EV_RQSHEET.countrow > 0 ) {

				if  (fnc_Appoint_Chk()){

					var param1 = document.form1.txtDTP_CD_SHR2.value;
					var param2 = document.form1.txtDTP_NM_SHR2.value;					
					var param3 = document.form1.cmbJOB_CD_SHR2.value;	
					var param4 = document.form1.txt_t_scr.value;	
					
					for ( i=1;i<=dsT_EV_RQSHEET.countrow;i++){



						
						if (dsT_EV_RQSHEET.namevalue(i,"BCHK") =="T"){

										fnc_Header_create();

										dsT_EV_RQGROUP.addrow();

										j = dsT_EV_RQGROUP.countrow;

										dsT_EV_RQGROUP.namevalue(j,"D_EVAYM") =   document.form1.gcem_yymm2.text;
										dsT_EV_RQGROUP.namevalue(j,"D_GB_MST") = dsT_EV_RQSHEET.namevalue(i,"GB_MST") ;       			//�����
										dsT_EV_RQGROUP.namevalue(j,"D_GB_DTL") = dsT_EV_RQSHEET.namevalue(i,"GB_DTL") ;     			//����ڸ�
										dsT_EV_RQGROUP.namevalue(j,"D_ACT_ITEM"  ) = dsT_EV_RQSHEET.namevalue(i,"ACT_ITEM") ;  //

										dsT_EV_RQGROUP.namevalue(j,"DTP_CD"  ) = param1;  //
										dsT_EV_RQGROUP.namevalue(j,"DTP_NM"  ) = param2;  //										
										dsT_EV_RQGROUP.namevalue(j,"JOB_CD"  ) = param3;
										dsT_EV_RQGROUP.namevalue(j,"JIKMU_CD"  ) = "00";
										dsT_EV_RQGROUP.namevalue(j,"T_SCR"  ) = param4;
										
										//fnc_Evaseq(i, document.getElementById("cmbEVA_SEQ").value, document.form1.txtENO_NM.value);

						}
					} //for
				}

			}else{
				alert("�����Ͱ� �������� �ʽ��ϴ�");
			}

		}

        /******************************
         * 17. ���ǥ �Է� �� Ȯ�λ���       *
         ******************************/

		function fnc_Appoint_Chk(){

			var REG_YM_SHR = document.form1.gcem_yymm2.text;     	//������

			if(REG_YM_SHR.trim() == ""){

					alert("�ϴ� ������ �������� �Է��Ͻñ� �ٶ��ϴ�.");
					return false;
				}
			
			return true;

		}
		


        /******************************
         * 18. ����Ÿ�� ��� ����       *
         ******************************/

		function fnc_Header_create(){

			if (dsT_EV_RQGROUP.countrow<1){
				var Header1= "D_EVAYM:STRING,D_GB_MST:STRING,D_GB_DTL:STRING,D_ACT_ITEM:STRING,DTP_CD:STRING,DTP_NM:STRING,JOB_CD:STRING,JIKMU_CD:STRING,T_SCR:DECIMAL";
				dsT_EV_RQGROUP.SetDataHeader(Header1);
			}
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
    | 2. �̸� : dsT_CM_COMMON_EC                   |
    | 3. Table List : �����ڵ�               |
    +----------------------------------------------->
    <!-- ���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_EC"/>
       <jsp:param name="CODE_GUBUN"    value="EC"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_COMMON_EC 2                  |
    | 3. Table List : �����ڵ�               |
    +----------------------------------------------->
    <!-- ���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_EC2"/>
       <jsp:param name="CODE_GUBUN"    value="EC"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_EV_RQSHEET                   |
    | 3. Table List : T_EV_RQSHEET                  |
    +----------------------------------------------->
    <Object ID="dsT_EV_RQSHEET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_EV_RQGROUP                   |
    | 3. Table List : T_EV_RQGROUP               |
    +----------------------------------------------->
    <Object ID="dsT_EV_RQGROUP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_EV_RQSHEET)	|
    | 3. ���Ǵ� Table List(T_EV_RQSHEET)	        |
    +--------------------------------------------------->

    <Object ID ="trT_EV_JOBCD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_EV_RQSHEET" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_EV_RQGROUP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    <!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_EV_RQSHEET |
    +----------------------------------------------------------------->
    <Script For=dsT_EV_RQSHEET Event="OnLoadCompleted(iCount)">

    </Script>

    <Script For=dsT_EV_RQGROUP Event="OnLoadCompleted(iCount)">

    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_RQSHEET Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>


    <Script For=dsT_EV_RQGROUP Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_RQGROUP event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        dsT_EV_RQSHEET.ClearAll();
        dsT_EV_RQGROUP.ClearAll();    
        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_RQGROUP event="OnFail()">
        if (trT_EV_RQGROUP.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

    <!------------------------------+
    | grid���� row��     Ŭ�������� |
    +------ ------------------------>
	<script for=grdT_EV_RQSHEET event=OnClick(Row,Colid)>
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );

		var GB_DTL =dsT_EV_RQSHEET.NameValue(Row, "GB_DTL");

		var REG_YM_SHR   = document.getElementById("txtREG_YM_SHR").value;      	//��û��

		if(Row < 1) {
			return;
		} else {
			try {
			dsT_EV_RQGROUP.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk060.cmd.VLUK060CMD"
							                                      + "&S_MODE=SHR_02"
							                                      + "&REG_YM_SHR=REG_YM_SHR"
							                                      + "&GB_DTL="+GB_DTL;
			dsT_EV_RQGROUP.reset();

			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
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
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">




<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../../images/button/btn_DeleteOver.gif',1)"> <img src="../../images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td align="center" class="blueTable">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">

                <tr>
                   <td class="searchState" align="left">������&nbsp;</td>
						<td class="padding2423" align="left" id="key1"  style="display:">
                              <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" value="" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                         </td>
                          <td align=""left"" class="searchState">����</td>
                          <td class="padding2423">
                              <select id="cmbGBMST_STR"  onChange="fnc_SearchList()">
							  <option value="00">��ü</option>
							  <option value="01">����</option>
							  <option value="02">������</option>
							   <option value="03">����</option>
                               </select>
                           </td>
                    <td align=""left"" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
					<td class="padding2423">
						<input id=txtDTP_CD_SHR name=txtDTP_CD_SHR size="6" maxlength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDTP_CD_SHR','txtDTP_NM_SHR')">
						<input id=txtDTP_NM_SHR name=txtDTP_NM_SHR size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDTP_CD_SHR','txtDTP_NM_SHR','����','HEAD')"></a>
					</td>

                    <td align=""left"" class="searchState">����</td>
                      <td class="padding2423">
						<select id="cmbJOB_CD_SHR" style="WIDTH=100" onChange="fnc_SearchList()">
						<option value="0">���</option>
						</select>	&nbsp;
                       </td>


                      <td align="left" class="searchState">����</td>
                      <td class="padding2423">
                          <select id="cmbJIKMU_CD_SHR"  onChange="fnc_SearchList()">
                              <option value="01">���</option>
                              <option value="00">����</option>
                              <option value="10">�繫��</option>
                              <option value="20">������</option>
                              <option value="30">�����</option>
                              <option value="40">��Ÿ</option>
                          </select>
                       </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->





<table width="1000" border="0">
	<tr>
        <td class="paddingTop8">
        	<!-- ������ ���� ���̺� ���� -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_EV_RQSHEET" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:250px;">
							<param name="DataID"				value="dsT_EV_RQSHEET">
							<param name="SortView"			value="Left">
							<param name="Format"				value="
								<F> Name='����'			ID=BCHK		HeadAlign=Center HeadBgColor=#B9D4DC width=40 align=center, bgcolor=#f5f5f5, EditStyle=CheckBox, cursor=hand, sort=false</F>
            					<C> id='{CUROW}'		width=40	name='NO'			align=center		value={String(Currow)}	show=false</C>
								<C> id='EVAYM'       	width=70    name='������'     	align=center   		Edit=None mask='XXXX-XX'</C>
                                <C> id='GB_MST'        	width=70    name='����'         	align=center   		Edit=None value={IF (GB_MST='01','����',IF (GB_MST='02','������' , IF (GB_MST='03','����' '')))}</C>
                                <C> id='GB_DTL'        	width=80    name='�׸�'         	align=left   		Edit=None </C>
                                <C> id='ACT_ITEM'       width=420  	name='�ൿ��ǥ'     	align=left 			Edit=none</C>
                                <C> id='HEAD_NM'      	width=70    name='����'         	align=center   		Edit=None </C>
                                <C> id='JOB_NM'       	width=70  	name='����'     		align=center 		Edit=none</C>                                
                                <C> id='JIKMU_NM'      	width=70    name='����'         	align=center   		Edit=None </C>
                                <C> id='T_SCR'       	width=70  	name='����'     		align=center 		Edit=none</C>                                 
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- ������  ���� ���̺� �� -->
			</td>
	</tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="10%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" width="800" class="paddingTop5" align="center">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/addarrow1.gif',1)"><img src="../../images/button/addarrow1.gif" name="Image1" width="40" height="20" border="0" align="absmiddle" onClick="fnc_addarrow()"></a>
		</td>

		<td height="35" class="paddingTop5" align="right">
             <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="600" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_EV_RQGROUP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
							<param name="DataID"				value="dsT_EV_RQGROUP">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='D_EVAYM'       		width=100    name='������'    	align=center   		Edit=None mask='XXXX-XX'</C>
                                <C> id='D_GB_MST'        	width=100    name='����'         	align=center   		Edit=None value={IF(D_GB_MST='01','����',IF (D_GB_MST='02','������' , IF (D_GB_MST='03','����' '')))}</C>
                                <C> id='D_GB_DTL'        	width=100    name='�׸�'         	align=left   		Edit=None </C>
                                <C> id='D_ACT_ITEM'        	width=150  	name='�ൿ��ǥ'    	align=left 	 		Edit=none </C>
								<C> id='DTP_NM'        		width=70    name='����'         align=left   		Edit=None </C>								
								<C> id='JOB_CD'        		width=70    name='����'         align=center			Edit=none	EditStyle=Lookup  Data='dsT_CM_COMMON_EC:CODE:CODE_NAME' </C>
								<C> id='JIKMU_CD'        	width=70    name='����'         align=center   		Edit=None  value={IF(JIKMU_CD='00','����',IF (JIKMU_CD='10','�繫��' , IF (JIKMU_CD='20','������', IF (JIKMU_CD='30','�����', IF (JIKMU_CD='40','��Ÿ' '')))))}</C>
								<C> id='T_SCR'        		width=70    name='����'         align=center   		Edit=None  Dec=0 </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
		  		<td valign=top>
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=3
					style='width:200px;height:200px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="bludBold"><nobr>������</nobr></td>
						<td style="height:20px; border:0 solid #708090;border-bottom-width:1px; align=left"><nobr>
							<comment id="__NSID__">
							<object id=gcem_yymm2  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style=" position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; ">
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY-MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor   value=false>
										<param name=ReadOnly  	 value=false>
							</object>
							</comment><script> __ShowEmbedObject(__NSID__);</script>
						</td>
					</tr>
						<tr>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="bludBold">&nbsp;����</td>
						<td style="height:20px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
							<input id=txtDTP_CD_SHR2 name=txtDTP_CD_SHR2 size="4" class="input_ReadOnly" readonly>
							<input id=txtDTP_NM_SHR2 name=txtDTP_NM_SHR2 size="10" class="input_ReadOnly" readonly>
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDTP_CD_SHR2','txtDTP_NM_SHR2','����','HEAD')"></a>
						</td>
						</tr>
						<tr>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="bludBold">&nbsp;����</td>
						<td style="height:20px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
								<select id="cmbJOB_CD_SHR2" style="WIDTH:100px">
								</select>&nbsp;</nobr>
							</td>
						</tr>
							<tr>
									<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  class="bludBold">&nbsp;����</td>
									<td style="height:20px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
										<comment id="__NSID__">
										<object id=gclx_jobgrphcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=100>
										<param name="CBData" 				value="00^����" />
										<param name="CBDataColumns" 		value="COM_CODE,COM_SNAME" />
										<param name="Index" 				value="1" />
										<param name="SearchColumn" 			value="COM_SNAME" />
										<param name="ListExprFormat" 		value="COM_SNAME^0^70" />
										<param name="BindColumn" 			value="COM_CODE" />
										<param name="ComboStyle"  			value="2">		
										<param name="DefaultString"  		value="����">
																		
										<param name="Enable" 					value="true" />
									</object>
								</comment><script>__ShowEmbedObject(__NSID__);</script>&nbsp;</nobr>
								</td>
							</tr>
							<tr>
								<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"  class="bludBold">&nbsp;����</td>
								<td Style="height:20px;border:0 solid #708090;border-bottom-width:0px"><nobr>
									<input id="txt_t_scr" name="txt_t_scr" type="text"  class="txt21" style="position:relative; left:0px;width:100px;" maxlength=34 >&nbsp;</nobr>
								</td>
							</tr>
						</table>
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
<object id="bndT_EV_RQSHEET" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_RQSHEET">
	<Param Name="BindInfo", Value='
		<C>Col=EVAYM   		 	Ctrl=txtREG_YM_SHR    		 	Param=text		</C>
    '>
</object>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_EV_RQGROUP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_RQGROUP">
	<Param Name="BindInfo", Value='
		<C>Col=D_EVAYM     		 	Ctrl=gcem_yymm2     			Param=value 		</C>
        <C>Col=DTP_CD             	Ctrl=txtDTP_CD_SHR2      		Param=value     	</C>     
        <C>Col=DTP_NM             	Ctrl=txtDTP_NM_SHR2      		Param=value     	</C>
		<C>Col=JOB_CD				Ctrl=cmbJOB_CD_SHR2	   			Param=value			</C>
		<C>Col=JIKMU_CD				Ctrl=gclx_jobgrphcd	   			Param=BindColVal	</C>
		<C>Col=T_SCR   		 		Ctrl=txt_t_scr    		 		Param=value			</C>
    '>
</object>

