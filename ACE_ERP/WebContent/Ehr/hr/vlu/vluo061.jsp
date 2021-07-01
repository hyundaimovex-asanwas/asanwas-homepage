<!--
*****************************************************
* @source       : vluo061.jsp
* @description  : ������� �Է� �˾� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2017/04/10      �̵���        �����ۼ�.
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
			var HENO_NO = strParam[3];
			var HENO_NM = strParam[4];
			var GOAL_SEQ = strParam[5];

			dsT_EV_RQSCORE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo060.cmd.VLUO060CMD"
																									     + "&S_MODE=SHR_ITEM"
																									     + "&REG_YM_SHR="+REG_YM_SHR
																									     + "&ENO_NO="+ENO_NO
																									     + "&HENO_NO="+HENO_NO
																									     + "&GOAL_SEQ="+GOAL_SEQ;
			dsT_EV_RQSCORE.reset();


            for (var i = 1; i <= dsT_EV_RQSCORE.CountRow; i++) {        	
            	
	            if(dsT_EV_RQSCORE.NameValue(i, "SELF_SCR") == "S") {
	            	dsT_EV_RQSCORE.namevalue(i,"SCORE") = (10 * dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD"))/10;            	
	            } else if(dsT_EV_RQSCORE.NameValue(i, "SELF_SCR") == "A"){
	            	dsT_EV_RQSCORE.namevalue(i,"SCORE") = (8.5 * dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD"))/10;    
	            } else if(dsT_EV_RQSCORE.NameValue(i, "SELF_SCR") == "B"){
	            	dsT_EV_RQSCORE.namevalue(i,"SCORE") = (7 * dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD"))/10;    
	            } else if(dsT_EV_RQSCORE.NameValue(i, "SELF_SCR") == "C"){
	            	dsT_EV_RQSCORE.namevalue(i,"SCORE") = (5.5 * dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD"))/10; 
	            } else if(dsT_EV_RQSCORE.NameValue(i, "SELF_SCR") == "D"){
	            	dsT_EV_RQSCORE.namevalue(i,"SCORE") = (4 * dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD"))/10;    	            	
	            }

        	}
            cfCopyDataSet(dsT_EV_RQSCORE, dsT_EV_RQSCORE_01);
			
			
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
		   var HENO_NO = strParam[3];
  		   var GSTR_EMPNO =  document.form1.txtENO_NO_SHR.value;
  		   var TOTAL_SCR = 0;
		   var EVASEQ = document.form1.txtGOAL_SEQ.value;

  			if (dsT_EV_RQSCORE.countrow<1){
  				
  				alert ("������ ������ �����ϴ�.");
  				
  			}else{

  				if(fnc_Chk()){

  					if (confirm("�����Ͻðڽ��ϱ�?")) {

  							for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){

  								if ((dsT_EV_RQSCORE.SysStatus(i)==2)||(dsT_EV_RQSCORE.SysStatus(i)==3)){
	  									dsT_EV_RQSCORE.namevalue(i,"EMPNOH")	=	document.form1.txtHENO_NO_SHR.value;
	  									dsT_EV_RQSCORE.namevalue(i,"EMPNO")		=	document.form1.txtENO_NO_SHR.value;
	  									dsT_EV_RQSCORE.namevalue(i,"EVASEQ")	=	document.form1.txtGOAL_SEQ.value;
  								}

  								TOTAL_SCR = TOTAL_SCR + dsT_EV_RQSCORE.namevalue(i,"DPT_CH_SCR");

  							}

  							trT_EV_RQSCORE.KeyValue = "tr01(I:dsT_EV_RQSCORE=dsT_EV_RQSCORE)";
  							trT_EV_RQSCORE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo060.cmd.VLUO060CMD&S_MODE=SAV";
  							
  							//prompt(this, dsT_EV_RQSCORE.text);
  							
  							trT_EV_RQSCORE.post();

  							fnc_SearchList();

  					}
  				}

        	}
  			
       }

		/******************************************************************************
				Description : ����Ÿ �� ��� ����
			******************************************************************************/
			function fnc_SetDataHeader(){


					if (dsT_EV_RQSCORE.countrow<1){
						var s_temp = " EVAYM:STRING(7),SEQ2:DECIMAL(2),WORKGB:STRING(50),WKCONT:STRING(2048),"
											 + " IMPORT:DECIMAL(3),SCORE:DECIMAL(2),CH_SCORE:DECIMAL(3.1),"
											 + " DPT_IMPORT:DECIMAL(3),SCR:DECIMAL(3.1),"
											 + " SCRGBN:STRING(1),DPT_CH_SCR:DECIMAL(5.3),DPT_CH_SCR:DECIMAL(5.3),EMPNOH:STRING(7),EMPNO:STRING(7),EVQSEQ:STRING(1)";
						dsT_EV_RQSCORE.SetDataHeader(s_temp);
					}


			}



		/******************************************************************************
		Description : Check
		******************************************************************************/
	    function fnc_Chk() {

	    	for (i=1;i<=dsT_EV_RQSCORE.countrow;i++){
	    		
					if (dsT_EV_RQSCORE.namevalue(i,"CHK01") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK02") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK03") == "F" && dsT_EV_RQSCORE.namevalue(i,"CHK04") == "F"
					 && dsT_EV_RQSCORE.namevalue(i,"CHK05") == "F" && dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD") != 0){

								alert("���ǰ��� ������ ��� �򰡿�Ҹ� üũ�Ͻʽÿ�");

								dsT_EV_RQSCORE.rowposition = i;

					  			return false;

								break;

					}
					else if (dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD") == 0) {
						
					}

			}
	    	
	    	
	    	for (i=1;i<=dsT_EV_RQSCORE.countrow;i++){
	    		
				if (dsT_EV_RQSCORE.namevalue(i,"FEEDBACK") == "" && dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD") != 0){

						alert(i+"��° �׸��� ���ǰ��� �Է��Ͻʽÿ�");

						dsT_EV_RQSCORE.rowposition = i;

				  		return false;

						break;
							
				}
				else if (dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD") == 0) {
					
				}
		}
	    	

		  //����üũ
			var str="";
		  
			var dbltemp=0;

		  	for(i=1;i<=dsT_EV_RQSCORE.countrow;i++){
		  		
				dbltemp=parseInt(dbltemp)+parseInt(dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD"));

		  	}
		  	
		  	//alert(dbltemp);

			if(dbltemp!=100) {
				alert("����ġ �հ谡 100 �� �ƴմϴ�. Ȯ�� �ٶ��ϴ�.");
				return false;
			}
			
			
			//����ġ ���. ���� ����ġ�� -5~+5 , �߰� ����ġ�� 0~10���� ����. 
			//����ڰ� �ο��� ����ġ�� ���� �ǰ���ڰ� �Է��� ������ +- 5�� ���� �� ������~
			for(i=1;i<=dsT_EV_RQSCORE.countrow-1;i++){
				
				
		  		if (parseInt(dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD")) < parseInt(dsT_EV_RQSCORE_01.namevalue(i,"WEIGHT"))-5 
					|| parseInt(dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD")) > parseInt(dsT_EV_RQSCORE_01.namevalue(i,"WEIGHT"))+5){
		  			
						alert(i+"��° �׸񿡼� ����ġ ���� �������� �Ѿ���ϴ�.(-5 ~ +5)\n\nȮ�� �ٶ��ϴ�.");
						
						dsT_EV_RQSCORE.namevalue(i,"WEIGHT_HEAD") = dsT_EV_RQSCORE_01.namevalue(i,"WEIGHT_HEAD");
						
						return false;
						
				}
		  		

		  		
		  		
		  		if(dsT_EV_RQSCORE.namevalue(i,"CATEGORY") == "���� ������"){
		  				
					if(parseInt(dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.countrow,"WEIGHT_HEAD")) > 10){
						
						alert("���� �������� ����ġ �ִ밪�� 10�Դϴ�.\n\nȮ�� �ٶ��ϴ�.");
						
						return false;
						
					}		  	
				}
			  		
		  		
		  		
		  		
			}		
			
			

			
			
			return true;

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

        fnc_SetDataHeader();

		document.getElementById("txtREG_YM_SHR").value = strParam[0];
		document.getElementById("txtENO_NO_SHR").value = strParam[1];
		document.getElementById("txtENO_NM_SHR").value = strParam[2];
		document.getElementById("txtHENO_NO_SHR").value = strParam[3];
		document.getElementById("txtHENO_NM_SHR").value = strParam[4];
		document.getElementById("txtGOAL_SEQ").value = strParam[5];
		
		fnc_SearchList();

		cfStyleGrid6(form1.grdT_EV_RQSCORE);

	    for ( i=1;i<=dsT_EV_RQSCORE.countrow;i++){
	   	  if(dsT_EV_RQSCORE.namevalue(i,"DPT_IMPORT") == "0")
    	  {
    	  	dsT_EV_RQSCORE.namevalue(i,"DPT_IMPORT")=dsT_EV_RQSCORE.namevalue(i,"IMPORT");
    	  	
    	  	}
	      }
	    
	    
	    
	    
	    
	    
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


		if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {

			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "F";
			dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "F";

			if ("CHK01" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK01") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "1";
                dsT_EV_RQSCORE.namevalue(row,"SCR") = "10" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD");
				//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK02" == col) {
				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK02") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "2";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "8.5" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD");
				//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK03" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK03") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "3";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "7" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD");
				//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK04" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK04") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "4";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "5.5" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD");
				//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}else if ("CHK05" == col) {

				dsT_EV_RQSCORE.namevalue(dsT_EV_RQSCORE.rowposition,"CHK05") = "T";
				dsT_EV_RQSCORE.namevalue(row,"SCRGBN") = "5";
				dsT_EV_RQSCORE.namevalue(row,"SCR") = "4" ;
				dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD");
				//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;

			}

		}   
		
		//alert(dsT_EV_RQSCORE.namevalue(row,"SCR"));
		
		dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = (dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD"))*0.1;
		//dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR")  * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;



    </Script>

	 <Script For=grdT_EV_RQSCORE Event="OnExit(row,colid,olddata)" >

	 dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"WEIGHT_HEAD")/10;
	 //dsT_EV_RQSCORE.namevalue(row,"DPT_CH_SCR") = dsT_EV_RQSCORE.namevalue(row,"SCR") * dsT_EV_RQSCORE.namevalue(row,"DPT_IMPORT")/10;


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

    <Object ID="dsT_EV_RQSCORE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1150" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_CancelOver.gif',1)"><img src="../../images/button/btn_CancelOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1150" border="0" cellspacing="0" cellpadding="0">
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
                                    <input id=txtHENO_NO_SHR name=txtHENO_NO_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <input id=txtHENO_NM_SHR name=txtHENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <input id=txtGOAL_SEQ name=txtGOAL_SEQ size="10" class="input_ReadOnly"  readOnly>
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
<table width="1150" border="0" cellspacing="0" cellpadding="0">
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
<table width="1150" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_RQSCORE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1160px;height:640px;">
                                <param name="DataID"                 		value="dsT_EV_RQSCORE">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="AutoReSizing"           	value="true">
                                <param name=ColSizing  				 	value="true">
                                <param name="RowHeight"   				value='20'>
								<param name=TitleHeight 					value="20">
								<param name="VIEWSUMMARY"          value=1>
    							<Param Name="SummaryHeight"  		value="40">								
                                <param name="Format"                 		value="
                                <C> id='TEAM_CD'     				width=20   		name='team'    				align=center   edit=none show=false</C>
                                <C> id='DPT_CD'     				width=20   		name='DEPT'    				align=center   edit=none show=false</C>
                                <C> id='HEAD_CD'     				width=20   		name='DEPT'    				align=center   edit=none show=false</C>
                                    <C> id='GOAL_NO'     			width=25   		name='No'    				align=center   edit=none  sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}  </C>
                                    <C> id='CATEGORY'    			width=70  		name='�� ��'   				align=left     	wordwrap=wordex Multiline=true scroll=vert edit=none sumbgcolor=#dae0ee edit=none BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
                                    <C> id='FORMULA'    			width=220   	name='�� �� �� ��'   		align=left     	wordwrap=wordex Multiline=true scroll=both sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')} </C>
                                    <G> name='��ǥ'	 HeadAlign=Center HeadBgColor=#dae0ee		
										<C> id='GOALSET_10'		width=80	name='10����ǥ'		align=left		wordwrap=wordex Multiline=true scroll=both sumbgcolor=#dae0ee  BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
										<C> id='GOALSET'		width=80	name='������ǥ'		align=left		wordwrap=wordex Multiline=true scroll=both sumbgcolor=#dae0ee  BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
									</G>
                                    <C> id='SELF_COMMENT'			width=180		name='����'					align=left		wordwrap=word 		Multiline=true sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
									<C> id='SELF_SCR'				width=30		name='����\\��'				align=center		EditStyle=Combo		Data='S:S,A:A,B:B,C:C,D:D' sumbgcolor=#dae0ee edit=none SumText={Round(sum(SCORE),3)} BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>


								<G> Name='���� ��' HeadAlign=Center HeadBgColor=#dae0ee
										<C>id='WEIGHT'    			width=50  	name='����ġ'  			align=center  sumbgcolor=#dae0ee BodyFontStyle=bold  SumText={Round(sum(WEIGHT),3)} show=false</C>								
										<C>id='WEIGHT_HEAD'    		width=50  	name='����ġ'  	align=center  sumbgcolor=#dae0ee BodyFontStyle=bold  SumText={Round(sum(WEIGHT_HEAD),3)}</C>								
					
										<C>id='DPT_IMPORT'    		width=50  	name='����ġ'  			align=center  sumbgcolor=#dae0ee BodyFontStyle=bold  SumText={Round(sum(DPT_IMPORT),3)} show=false</C>
	                                    <C>id='CHK01'    			width=30  	name='S'     			align=center  EditStyle=CheckBox  BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK02'   			width=30  	name='A'      			align=center  EditStyle=CheckBox  BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK03'   			width=30  	name='B'   				align=center  EditStyle=CheckBox  BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK04'    			width=30   	name='C'      			align=center  EditStyle=CheckBox 	BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C>id='CHK05'    			width=30   	name='D'      			align=center  EditStyle=CheckBox 	BgColor='#E4F7BA' sumbgcolor=#dae0ee</C>
	                                    <C> id='SCR'       			width=30   	name='���' 			align=center  edit=none value={IF(SCR='0','',SCR)} dec=1  sumbgcolor=#dae0ee </C>
										<C> id='DPT_CH_SCR'     	width=60   	name='ȯ������' 		align=center  dec=3  value={Round((DPT_CH_SCR),3)} SumText={Round(sum(DPT_CH_SCR),3)} sumbgcolor=#dae0ee edit=none  show=false</C>
										<C> id='DPT_CH_SCR'     	width=60   	name='ȯ������'  		align=center  dec=2  value={Round((DPT_CH_SCR),2)} SumText={Round(sum(DPT_CH_SCR),2)} sumbgcolor=#dae0ee edit=none BodyFontStyle=bold BgColor=#E3E3FF SumFontStyle=bold</C>
										<C> id='FEEDBACK'       	width=160   name='���ǰ�'  		align=center  wordwrap=wordex Multiline=true scroll=both sumbgcolor=#dae0ee</C>

								</G>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
				</table>
		</td>
		</tr>
		<tr>
			<td align="left" class="blueBold">
				<br><font color="black" size="2" bold="2">
				�� �ֿ� ���������� ĭ �������� ������ ������� �ش��׸��� ����Ŭ�� �Ͻø� �������ϴ�. </br>
				�� ����ġ ���� ���� : �� �׸񺰷�</font> <font color="red" size="2" bold="5">��5 ����</font> 
				<font color="black" size="2" bold="2">�����մϴ�. <br>
				�� ���� ������ : �����Ű�� ������ �������� �򰡽ǽ�, �׸� ������ ����ġ�� </font>
				<font color="red" size="2" bold="5">�ִ�10����</font> <font color="black" size="2" bold="2">�����մϴ�. </font>
			</td>
		</tr>
</table>


<!-- ���� ��ȸ �׸��� ���̺� ��-->
</form>
<!-- form �� -->
</body>
</html>

