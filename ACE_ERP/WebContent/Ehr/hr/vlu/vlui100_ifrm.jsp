<!--
*****************************************************
* @source       : vlui100.jsp
* @description  : �����Ű��ۼ� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����Ű��ۼ�(vlui100)</title>
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

        var REG_YM_SHR = window.external.GetFrame(window).REG_YM_SHR;

		var gs_format="";
		var gs_seq;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = parent.document.form1.txtREG_YM_SHR.value;        //�ش�⵵
			var ENO_NO = parent.document.form1.txtENO_NO_SHR.value;	//�Ҽ�


			trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_HWORKDTL=dsT_EV_HWORKDTL)";

			trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui100.cmd.VLUI100CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&REG_YM_SHR="+REG_YM_SHR
                                   + "&ENO_NO="+ENO_NO;

			trT_EV_ABLRST.post();




	    if(dsT_EV_HWORKDTL.namevalue(1,"WORKGB")==""&&dsT_EV_HWORKDTL.namevalue(1,"WKCONT")==""&&dsT_EV_HWORKDTL.namevalue(1,"IMPORT")==0){

				form1.txt_21.value="�ؾ����׸�";

	            form1.txt_31.value="��2012�� �ֿ���� �� ����(����) ��� \n (�ۼ��� ���κ� ���������, ����������ȹ���� �����Ͽ� �ۼ�)";

				form1.txt_41.value="����ġ�� �Ѱ谡 100% �ǵ��� ����"

			}

        }



/******************************************************************************
	Description : DTL ȭ�� DISPLAY
  parameter   :
******************************************************************************/
function ln_SetFormat(i){

	  	gs_format +="<table  cellpadding=0 cellspacing=0 style=width:800px;height:30px;font-size:9pt;background-color:#ffffff;>"
		gs_format +="	<tr>"
		gs_format +="		<td style=height:105px;border:1 solid #708090>"
		gs_format +="		<textarea id=txt_1"+i+"   style=width:40px;height:100px;overflow:auto;font-size:30pt;text-align:center;vertical-align:center; readOnly></textarea>"
		gs_format +="		</td>"
		gs_format +="		<td style=height:105px;border:1 solid #708090>"
		gs_format +="		 <textarea id=txt_2"+i+" style=width:82px;height:100px;overflow:auto;ime-mode:active; maxlength=50 onBlur=bytelength(this,this.value,100);></textarea>"
		gs_format +="		</td>"
		gs_format +="		<td style=height:105px;border:1 solid #708090>"
		gs_format +="		 <textarea id=txt_3"+i+" style=width:555px;height:100px;overflow:auto;ime-mode:active; maxlength=1000 onBlur=bytelength(this,this.value,1500);></textarea>"
		gs_format +="		</td>"
		gs_format +="		<td style=height:105px;border:1 solid #708090>"
		gs_format +="		 <textarea id=txt_4"+i+" style=width:62px;height:100px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,100);></textarea>"
		gs_format +="		</td>"
		gs_format +="		<td style=height:105px;border:1 solid #708090>"
		gs_format +="		 <textarea id=txt_5"+i+" style=width:60px;height:100px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,100);></textarea>"
		gs_format +="		</td>"
		gs_format +="	</tr>"
		gs_format +="</table>";

}


function ln_Display(i){

	if(i==1){
		form1.txt_11.value=dsT_EV_HWORKDTL.namevalue(i,"SEQ2");
		form1.txt_21.value=dsT_EV_HWORKDTL.namevalue(i,"WORKGB");
		form1.txt_31.value=dsT_EV_HWORKDTL.namevalue(i,"WKCONT");
		form1.txt_41.value=dsT_EV_HWORKDTL.namevalue(i,"IMPORT");
		form1.txt_51.value=dsT_EV_HWORKDTL.namevalue(i,"REMARK");
	}

	if(i==2){
		form1.txt_12.value=dsT_EV_HWORKDTL.namevalue(i,"SEQ2");
		form1.txt_22.value=dsT_EV_HWORKDTL.namevalue(i,"WORKGB");
		form1.txt_32.value=dsT_EV_HWORKDTL.namevalue(i,"WKCONT");
		form1.txt_42.value=dsT_EV_HWORKDTL.namevalue(i,"IMPORT");
		form1.txt_52.value=dsT_EV_HWORKDTL.namevalue(i,"REMARK");
	}

	if(i==3){
		form1.txt_13.value=dsT_EV_HWORKDTL.namevalue(i,"SEQ2");
		form1.txt_23.value=dsT_EV_HWORKDTL.namevalue(i,"WORKGB");
		form1.txt_33.value=dsT_EV_HWORKDTL.namevalue(i,"WKCONT");
		form1.txt_43.value=dsT_EV_HWORKDTL.namevalue(i,"IMPORT");
		form1.txt_53.value=dsT_EV_HWORKDTL.namevalue(i,"REMARK");
	}

}

function ln_Row_Clear(){

		for(i=gs_seq;i>=1;i--){

			table_1.deleteRow();
		}

		ln_Initial();
}

function ln_Initial(){

		gs_seq=1;

		gs_format ="";

		dsT_EV_HWORKDTL.deleteall();

		var oRow = table_1.insertRow();

	  	var oCell = oRow.insertCell();

		ln_SetFormat(gs_seq);

	  	oCell.innerHTML = gs_format;

		ln_SetDataHeader();

		dsT_EV_HWORKDTL.addrow();
}


function ln_SetDataHeader(){

		if (dsT_EV_HWORKDTL.countrow<1){
			var s_temp = " EVAYM:STRING(6),EMPNO:STRING(7),SEQ2:DECIMAL(2),WORKGB:STRING(100),WKCONT:STRING(2048),"
								 + " IMPORT:DECIMAL(3),REMARK:STRING(100)";
			dsT_EV_HWORKDTL.SetDataHeader(s_temp);
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



            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui100.cmd.VLUI100CMD&S_MODE=SAV&REG_YM_SHR="+REG_YM_SHR+"&GUBUN="+GUBUN;
            trT_EV_ABLRST.post();



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


            dsT_EV_HWORKDTL.ClearData();

            document.getElementById("resultMessage").innerText = ' ';



        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {


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

    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)                       |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_HWORKDTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

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
    <Script For=dsT_EV_HWORKDTL Event="OnLoadCompleted(row,colid)">

	  	var oRow;

		var oCell;

		for(i=1;i<=row;i++){

			if(i>1){

				gs_format="";

				oRow= table_1.insertRow();

				oCell = oRow.insertCell();

				ln_SetFormat(i);

				oCell.innerHTML = gs_format;

			}

			//��ȸ ����Ÿ ������
			ln_Display(i);
		}

		if (row==0)gs_seq = 1;

		else gs_seq = row;


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_HWORKDTL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- form ���� -->
<form name="form1">

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table id="table_1" value="" width="798" border="0" cellspacing="0" cellpadding="0">
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>


