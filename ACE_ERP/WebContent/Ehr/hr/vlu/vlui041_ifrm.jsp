<!--
*****************************************************
* @source       : vlui041.jsp
* @description  : �����Ű� PAGE
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
<title>�����Ű�(vlui041)</title>
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

		var gs_format ="";

		var gs_seq  = "";

        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

	            //�˻����� 2����
	            var REG_YM_SHR = parent.document.form1.txtREG_YM_SHR.value;        	//�ش�⵵
				var ENO_NO = parent.document.form1.txtENO_NO_SHR.value;				//�Ҽ�

				trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_HWORKDTL=dsT_EV_HWORKDTL)";
				trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui040.cmd.VLUI040CMD"
	                                   + "&S_MODE=SHR_WRK_01"
	                                   + "&REG_YM_SHR="+REG_YM_SHR
	                                   + "&ENO_NO="+ENO_NO;
				trT_EV_ABLRST.post();

		    if(dsT_EV_HWORKDTL.namevalue(1,"WORKGB")==""&&dsT_EV_HWORKDTL.namevalue(1,"WKCONT")==""&&dsT_EV_HWORKDTL.namevalue(1,"IMPORT")==0){

					txt_21.value="�ؾ����׸�";

		            txt_31.value="��2012�� �ֿ���� �� ����(����) ��� \n (�ۼ��� ���κ� ���������, ����������ȹ���� �����Ͽ� �ۼ�)";

					txt_41.value="����ġ�� �Ѱ谡 100% �ǵ��� ����"

				}

        	}



			/******************************************************************************
				Description : DTL ȭ�� DISPLAY
			  	parameter   :
			******************************************************************************/
			function fnc_SetFormat(i){

				  	gs_format +="<table  cellpadding=0 cellspacing=0 style=width:800px;height:30px;font-size:9pt;background-color:#ffffff;>"
					gs_format +="	<tr>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		<textarea id=txt_1"+i+"   style=width:40px;height:100px;overflow:auto;font-size:30pt;text-align:center;vertical-align:center; readOnly></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_2"+i+" style=width:82px;height:100px;overflow:auto;ime-mode:active; maxlength=50;></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_3"+i+" style=width:555px;height:100px;overflow:auto;ime-mode:active; maxlength=2000;></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_4"+i+" style=width:62px;height:100px;overflow:auto;ime-mode:active;  maxlength=50;></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_5"+i+" style=width:60px;height:100px;overflow:auto;ime-mode:active;  maxlength=50;></textarea>"
					gs_format +="		</td>"
					gs_format +="	</tr>"
					gs_format +="</table>";

			}


			function fnc_Display(i){

					eval("txt_1"+i).value=dsT_EV_HWORKDTL.namevalue(i,"SEQ2");
					eval("txt_2"+i).value=dsT_EV_HWORKDTL.namevalue(i,"WORKGB");
					eval("txt_3"+i).value=dsT_EV_HWORKDTL.namevalue(i,"WKCONT");
					eval("txt_4"+i).value=dsT_EV_HWORKDTL.namevalue(i,"IMPORT");
					eval("txt_5"+i).value=dsT_EV_HWORKDTL.namevalue(i,"REMARK");

			}

			function fnc_Row_Clear(gbn){

					if(gbn==1){
						for(i=gs_seq;i>1;i--){
							table_1.deleteRow();
						}
						gs_seq=1;
					}else if(gbn==2){
						for(i=gs_seq;i>=1;i--){
							table_1.deleteRow();
						}
						fnc_Initial();
					}
			}


			function fnc_Initial(){

					gs_seq=1;

					gs_format ="";

					dsT_EV_HWORKDTL.deleteall();

					var oRow = table_1.insertRow();

				  	var oCell = oRow.insertCell();

					fnc_SetFormat(gs_seq);

				  	oCell.innerHTML = gs_format;

					fnc_SetDataHeader();

					dsT_EV_HWORKDTL.addrow();
			}


			function fnc_SetDataHeader(){

					if (dsT_EV_HWORKDTL.countrow<1){
						var s_temp = " EVAYM:STRING(6),EMPNO:STRING(7),SEQ2:DECIMAL(2),WORKGB:STRING(100),WKCONT:STRING(4048),"
											 + " IMPORT:DECIMAL(3),REMARK:STRING(100)";
						dsT_EV_HWORKDTL.SetDataHeader(s_temp);
					}

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
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ABLRST)        |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_HWORKDTL Event="OnLoadCompleted(row,colid)">

	  	var oRow;

		var oCell;

		for(i=1;i<=row;i++){

			if(i>1){

				gs_format="";

				oRow= table_1.insertRow();

				oCell = oRow.insertCell();

				fnc_SetFormat(i);

				oCell.innerHTML = gs_format;

			}

			//��ȸ ����Ÿ ������
			fnc_Display(i);
		}

		if (row==0)gs_seq = 1;

		else gs_seq = row;


    </Script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll=auto >


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table id="table_1" value="" width="798" border="0" cellspacing="0" cellpadding="0">
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->


</body>
</html>


