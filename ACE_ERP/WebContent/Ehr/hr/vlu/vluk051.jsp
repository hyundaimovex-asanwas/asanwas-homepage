<!--
*****************************************************
* @source       : vluk051.jsp
* @description  : ������� �Է� �˾� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2013/05/07      �̵���        �����ۼ�.
* 2016/10/10     �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>
<head>
<title>������� �Է�</title>
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

        var GUBUN   = "";

		var strParam = new Array();

		strParam=window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
            var REG_YM_SHR = strParam[0];        //�ش�⵵
			var ENO_NO = strParam[1];			 //
			var ENO_NM = strParam[2];
			var ENOH_NO = strParam[3];
			var ENOH_NM = strParam[4];
			var HEAD_CD = strParam[5];
			var JOB_CD = strParam[6];
	  		var GUBUN =  strParam[7];
	  		var EVASEQ =  strParam[8];


			dsT_EV_RQSCORE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
												     + "&S_MODE=SHR_ITEM"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
												     + "&ENOH_NO="+ENOH_NO
												     + "&HEAD_CD="+HEAD_CD
												     + "&JOB_CD="+JOB_CD
												     + "&EVASEQ="+EVASEQ;
		    dsT_EV_RQSCORE.reset();
			    
		    dsT_EV_COMMENT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
												     + "&S_MODE=SHR_CMT"
												     + "&REG_YM_SHR="+REG_YM_SHR
												     + "&ENO_NO="+ENO_NO
												     + "&ENOH_NO="+ENOH_NO;
			dsT_EV_COMMENT.reset();		
			    
			    
			if(dsT_EV_COMMENT.countrow<1){
				
				dsT_EV_COMMENT.setDataHeader("EVAYM:STRING, EMPNOH:STRING, EMPNO:STRING, CMMENT:STRING");
				dsT_EV_COMMENT.AddRow();
			}

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        	return false;
        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

           var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        							//�ش�⵵
  		   var GUBUN =  strParam[7];
  		   var GSTR_EVASEQ =  strParam[8];
		   var ENOH_NO = strParam[3];
  		   var GSTR_EMPNO =  document.form1.txtENO_NO_SHR.value;
  		   var TOTAL_SCR = 0;
  		   //var CMMENT = document.form1.txtComment.value;
  		   
  		   var CMMENT = dsT_EV_COMMENT.namevalue(1,"CMMENT");
  		   //System.out.println(p_box);
  		   //alert(CMMENT);
            if (dsT_EV_RQSCORE.IsUpdated || dsT_EV_COMMENT.IsUpdated)  {

		  			if (dsT_EV_RQSCORE.countrow<1){
		  				alert ("������ ������ �����ϴ�.");
		  			}else {
		
		  				if(fnc_Chk()){
		
		  					if (confirm("�����Ͻðڽ��ϱ�?")) {
		
		  							for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){
		
		  								if ((dsT_EV_RQSCORE.SysStatus(i)==2)||(dsT_EV_RQSCORE.SysStatus(i)==3)){
			  									dsT_EV_RQSCORE.namevalue(i,"EMPNOH")=	document.form1.txtENOH_NO_SHR.value;
			  									dsT_EV_RQSCORE.namevalue(i,"EMPNO")	=	document.form1.txtENO_NO_SHR.value;
			  									dsT_EV_RQSCORE.namevalue(i,"EVASEQ")=	GSTR_EVASEQ;
		  										}
		
		  								TOTAL_SCR = TOTAL_SCR + dsT_EV_RQSCORE.namevalue(i,"SCR");
		  							}
		

		  							trT_EV_RQSCORE.KeyValue = "tr01(I:dsT_EV_RQSCORE=dsT_EV_RQSCORE)";
		  							trT_EV_RQSCORE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
										  	  							+ "&S_MODE=SAV"
										  	  							+ "&REG_YM_SHR="+REG_YM_SHR
										  	  							+ "&ENOH_NO="+ENOH_NO
										  	  							+ "&EMPNO="+GSTR_EMPNO
										  	  							+ "&GUBUN="+GUBUN
										  	  							+ "&TOTAL_SCR="+TOTAL_SCR
										  	  							+ "&EVASEQ="+GSTR_EVASEQ
			  															+ "&CMMENT="+CMMENT;  							
		  							trT_EV_RQSCORE.post();
		  							
		  							trT_EV_COMMENT.KeyValue = "tr01(I:dsT_EV_COMMENT=dsT_EV_COMMENT)";
		  							trT_EV_COMMENT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.k.vluk050.cmd.VLUK050CMD"
										  	  							+ "&S_MODE=SAV_CMT"
										  	  							+ "&REG_YM_SHR="+REG_YM_SHR
										  	  							+ "&ENOH_NO="+ENOH_NO
										  	  							+ "&EMPNO="+GSTR_EMPNO
			  															+ "&CMMENT="+CMMENT;  							
									//prompt(this,trT_EV_COMMENT.action);
		  							trT_EV_COMMENT.post();		  							

		  							fnc_SearchList();
		
		  					}
		  				}
		  			}
  			
  			
            }else{
            	
            	alert ("����� ������ �����ϴ�.");
            	
            }  		

        }

		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk() {

	    	for (i=1;i<=dsT_EV_RQSCORE.countrow;i++){

				if(dsT_EV_RQSCORE.namevalue(i,"GB_DTL") != "����" &&
					dsT_EV_RQSCORE.namevalue(i,"GB_DTL") != "������" &&
					dsT_EV_RQSCORE.namevalue(i,"GB_DTL") != "����"){

					if (dsT_EV_RQSCORE.namevalue(i,"CHK01") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK02") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK03") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK04") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK05") == "F"){

								alert("��� �򰡿�Ҹ� üũ�Ͻʽÿ�");

								dsT_EV_RQSCORE.rowposition = i;

					  			return false;

								break;

						}

				}

			}
	    	
	    	if (document.form1.txtComment.value == "" || document.form1.txtComment.value == null){
	    		
				alert("���ǰ��� �Է��Ͻʽÿ�");

	  			return false;	    		
	    		
	    	}

			return true;

	    }


		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk2(row) {

				if(dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "����" ||
					dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "������" ||
					dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "����"){
					
							dsT_EV_RQSCORE.namevalue(row,"CHK01") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK02") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK03") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK04") = "F";
							dsT_EV_RQSCORE.namevalue(row,"CHK05") = "F";

					  		return false;


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

			for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){

				dsT_EV_RQSCORE.namevalue(i,"CHK01") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK02") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK03") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK04") = "F";
				dsT_EV_RQSCORE.namevalue(i,"CHK05") = "F";

			}

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_RQSCORE.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

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

		document.getElementById("txtREG_YM_SHR").value = strParam[0];
		document.getElementById("txtENO_NO_SHR").value = strParam[1];
		document.getElementById("txtENO_NM_SHR").value = strParam[2];

		document.getElementById("txtENOH_NO_SHR").value = strParam[3];
		document.getElementById("txtENOH_NM_SHR").value = strParam[4];

		fnc_SearchList();

		cfStyleGrid_New2(form1.grdT_EV_RQSCORE);


		
        //cfStyleGrid(form1.grdT_EV_RQSCORE,15,"false","false");      // Grid Style ����

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>


    <Script For=grdT_EV_RQSCORE Event="OnClick(row,col)">

    if (dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "����"){
    	fnc_Chk2(row);
		//alert("�����׸� ���� �������� üũ�Ͻ� �ʿ�����ϴ�.");
    }else if(dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "������"){
    	fnc_Chk2(row);
		//alert("�������׸� ���� �������� üũ�Ͻ� �ʿ�����ϴ�.");
    }else if(dsT_EV_RQSCORE.namevalue(row,"GB_DTL") == "����"){
    	fnc_Chk2(row);
		//alert("�����׸� ���� �������� üũ�Ͻ� �ʿ�����ϴ�.");
    }else{

		if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {

			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "F";

			if ("CHK01" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "1";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"ESCR");

			}else if ("CHK02" == col) {
				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "2";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"GSCR");

			}else if ("CHK03" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "3";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"MSCR");

			}else if ("CHK04" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "4";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"LSCR");

			}else if ("CHK05" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "5";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = dsT_EV_RQSCORE.namevalue(row,"PSCR");

			}
		}

    }

    </Script>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_RQSCORE)                       |
    | 3. ���Ǵ� Table List(T_EV_RQSCORE)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_RQSCORE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_COMMENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ABLRST)        |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_RQSCORE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_EV_COMMENT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_RQSCORE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_RQSCORE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_RQSCORE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_RQSCORE event="OnFail()">
        if (trT_EV_RQSCORE.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1100" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1100" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="200"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly"  readOnly>
                               </td>
                                <td align="right" class="searchState">�ǰ����</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                </td>
                                <td align="right" class="searchState">�����</td>
                                <td class="padding2423">
                                    <input id=txtENOH_NO_SHR name=txtENOH_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtENOH_NM_SHR name=txtENOH_NM_SHR size="12" class="input_ReadOnly"  readOnly>
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
<table width="1100" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" width="600" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1100" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_RQSCORE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1100px;height:600px;">
                                <param name="DataID"                 	value="dsT_EV_RQSCORE">
                                <param name="EdiTABLE"               	value="false">
                                <param name="DragDropEnable"         	value="true">
                                <param name="VIEWSUMMARY"          		value=1>
    							<Param Name="SummaryHeight"  			value="40">
                                <param name="AutoReSizing"           	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="RowHeight"   				value='20'>
								<param name=TitleHeight 				value="20">
                                <param name="Format"                 	value="
                                    <C> id='GB_MST'     		width=100   name='����'    		align=center  	sumbgcolor=#dae0ee  edit=none  suppress=1  BgColor=#E4F7BA value={IF(GB_MST='01','����',IF(GB_MST='02','������','����'))} BodyFontStyle=bold</C>
                                    <C> id='GB_DTL'    			width=150  	name='�׸�'   		align=left      sumbgcolor=#dae0ee	edit=none BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
                                    <C> id='ACT_ITEM'    		width=520  	name='�ൿ��ǥ'   	align=left      SumText='�� ��' 		sumbgcolor=#dae0ee	edit=none  Multiline=true BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
                                    <C> id='T_SCR'   			width=40  	name='����'  		align=center  	sumbgcolor=#dae0ee  edit=none value={IF(T_SCR='0','',T_SCR)} BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))} </C>
								<G> Name='�����Է�' HeadAlign=Center HeadBgColor=#dae0ee
	                                    <C>id='CHK01'    		width=40  	name='Ź��'     		align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', '')))} BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK02'   		width=40  	name='���'      	align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', '')))} BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK03'   		width=40  	name='����'   		align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', '')))} BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK04'    		width=40   	name='����'      	align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', '')))} BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
	                                    <C>id='CHK05'    		width=40   	name='����'      	align=center    sumbgcolor=#dae0ee EditStyle=CheckBox CheckBoxColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', '')))} BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))}</C>
                                </G>
                                    <C> id='SCR'       			width=40   	name='���' 		align=center    SumText={Round(sum(SCR),2)} sumbgcolor=#89add6 edit=none value={IF(SCR='0','',SCR)} dec=2 BgColor={IF(GB_DTL='����','#FFCC66',IF (GB_DTL='������','#FFCC66' , IF (GB_DTL='����','#FFCC66', 'FFFFFF')))} BgColor=#E3E3FF BodyFontStyle=bold SumFontStyle=bold</C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>                  
                </table>
            </td>
        </tr>
</table>


<table width="1100" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60">
                            <colgroup>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right" >���ǰ�&nbsp;</td>
                                <td class="padding2423" align="left" id="txtComment"  style="display:">
									<textarea id="txtComment"  cols=160  rows=3></textarea>
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
<!-- -->
<object id="bndT_EV_COMMENT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_COMMENT">
	<Param Name="BindInfo", Value='
        <C>Col=CMMENT     		Ctrl=txtComment     		Param=value 	</C>
    '>
</object>