<!--
*****************************************************
* @source       : vlul020.jsp
* @description  : �����������Է� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/11/15     �̵���        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�����������Է�</title>
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



        var frameid = window.external.GetFrame(window).FrameId;
        
        var GUBUN   = "";
        
		var cntchk = "N";
		
		var j=0;
		
		var GSTR_YYYYMM, GSTR_EMPNO, GSTR_EMPNMK, GSTR_GRPCD, GSTR_JOBGRPH, GSTR_EVASEQ,GSTR_ROWPOSITION,GSTR_PAYGRD;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

          //�˻����� 4����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //�����
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
              GUBUN = "1";			//������
	      }else if(document.form1.rdoGBN_SHR[1].checked){
	          GUBUN = "4";    		//PJT
	      }
                  
          
			  //����
		      dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul020.cmd.VLUL020CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		      dsT_EV_ABLRST.reset();
			  //fnc_Reset('q');

			  //�����
		      //dsT_EV_ABLRST2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul020.cmd.VLUL020CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		      //dsT_EV_ABLRST2.reset();
			  //fnc_Reset('q');


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


		}



		/******************************************************************************
			Description : Check
		******************************************************************************/
        function fnc_Chk() {

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

		document.getElementById("txtREG_YM_SHR").value = '2017';
		document.getElementById("txtENOH_NO_SHR").value=gusrid;
		document.getElementById("txtENOH_NM_SHR").value=gusrnm;

    
        cfStyleGrid_New(form1.grdT_EV_ABLRST,0,"true","true");      // Grid Style ����
        cfStyleGrid_New(form1.grdT_EV_ABLRST2,0,"true","true");      // Grid Style ����
		
	    //�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
		if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2070020" && gusrid != "2020008" ){ 
		
		
		            fnc_ChangeStateElement(false, "txtENOH_NO_SHR");
		            fnc_ChangeStateElement(false, "txtENOH_NM_SHR");
		            fnc_ChangeStateElement(false, "ImgEnoNo");

		    }


        

		fnc_SearchList();


        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /******************************
         * 16. �������       		   *
         ******************************/
        function fnc_Correct(){

          //�˻����� 2����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //�����
          //var GUBUN 	= "1";
          var GUBUN 	= "";

          if(document.form1.rdoGBN_SHR[0].checked){
              GUBUN = "1";			//������
	      }else if(document.form1.rdoGBN_SHR[1].checked){
	          GUBUN = "4";    		//PJT
	      }

          if(GUBUN =="1"){ 	//������
			  if(confirm("������ ��������� �Ͻðڽ��ϱ�?")){
			      dsT_EV_CORCAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul020.cmd.VLUL020CMD&S_MODE=SAV_COR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}
		  }else if(GUBUN =="4"){ 	//PJT
			  if(confirm("PJT ��������� �Ͻðڽ��ϱ�?")){
			      dsT_EV_CORCAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.l.vlul020.cmd.VLUL020CMD&S_MODE=SAV_COR_PJT&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}          
		  }
          
          
		}



		/******************************************************************************
		Description : ��������Է� �˾�â �߱�
		******************************************************************************/

		function fnc_Grid_Dblclick(row,col){

				GSTR_EMPNO		 = dsT_EV_ABLRST.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST.namevalue(row,"EMPNMK");
				GSTR_PAYGRD		 = dsT_EV_ABLRST.namevalue(row,"PAYGRD");
				GSTR_HEAD		 	 = dsT_EV_ABLRST.namevalue(row,"HEAD_CD");

				var GUBUN="1";



				var result="";
				var arrResult	= new Array();
				var arrParam	= new Array();
				var strURL;
				var strPos;

				arrParam[0] = document.form1.txtREG_YM_SHR.value; //���
			  	arrParam[1] = GSTR_EMPNO; //�ǰ����
			  	arrParam[2] = GSTR_EMPNMK; //�ǰ����

			  	arrParam[3] = document.form1.txtENOH_NO_SHR.value; //�����
			  	arrParam[4] = document.form1.txtENOH_NM_SHR.value; //�����

			  	arrParam[5] = GSTR_HEAD; //����
			  	arrParam[6] = GSTR_PAYGRD; //�ǰ����

			  	arrParam[7] = GUBUN; //������, �����, �μ��� radio button
			  	arrParam[8] = dsT_EV_ABLRST.namevalue(dsT_EV_ABLRST.rowposition,"EVASEQ"); //EVASEQ

			    strURL = "vlul021.jsp";
				strPos = "dialogWidth:1200px;dialogHeight:830px;status:no;scroll:no;resizable:no";
				result = showModalDialog(strURL,arrParam,strPos);

				fnc_SearchList();

		}


		function fnc_Grid_Dblclick2(row,col){

			GSTR_EMPNO		 = dsT_EV_ABLRST2.namevalue(row,"EMPNO");
			GSTR_EMPNMK		 = dsT_EV_ABLRST2.namevalue(row,"EMPNMK");
			GSTR_PAYGRD		 = dsT_EV_ABLRST2.namevalue(row,"PAYGRD");

			var GUBUN="1";

			var result="";
			var arrResult	= new Array();
			var arrParam	= new Array();
			var strURL;
			var strPos;

			arrParam[0] = document.form1.txtREG_YM_SHR.value; //���
		  	arrParam[1] = GSTR_EMPNO; //�ǰ����
		  	arrParam[2] = GSTR_EMPNMK; //�ǰ����

		  	arrParam[3] = document.form1.txtENOH_NO_SHR.value; //�����
		  	arrParam[4] = document.form1.txtENOH_NM_SHR.value; //�����

		  	arrParam[5] = GSTR_EMPNO; //�ǰ����
		  	arrParam[6] = GSTR_PAYGRD; //�ǰ����

		  	arrParam[7] = GUBUN; //������, �����, �μ��� radio button
		  	arrParam[8] = dsT_EV_ABLRST2.namevalue(dsT_EV_ABLRST2.rowposition,"EVASEQ"); //EVASEQ

		    strURL = "/hr/vlu/vlul021.jsp";
			strPos = "dialogWidth:1200px;dialogHeight:830px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);

			fnc_SearchList();

	}

		/******************************************************************************
			Description : ���������ȸ
		******************************************************************************/
	/*
		function fnc_Grid_Onclick(gubun,row){

		    GSTR_YYYYMM ="";
			GSTR_EMPNO = "";
			GSTR_GRPCD = "";
			GSTR_JOBGRPH = "";
			GSTR_EVASEQ = "";
			GSTR_PAYGRD = "";

			if(gubun=="1"){
				GSTR_YYYYMM	 = dsT_EV_ABLRST.namevalue(row,"EVAYM");
				GSTR_EMPNO		 = dsT_EV_ABLRST.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST.namevalue(row,"EMPNMK");
				GSTR_GRPCD		 = dsT_EV_ABLRST.namevalue(row,"GRPCD");
				GSTR_JOBGRPH	 = dsT_EV_ABLRST.namevalue(row,"JOBGRPH");
				GSTR_EVASEQ		 = dsT_EV_ABLRST.namevalue(row,"EVASEQ");
				GSTR_PAYGRD		 = dsT_EV_ABLRST.namevalue(row,"PAYGRD");
				GSTR_ROWPOSITION = dsT_EV_ABLRST.rowposition;
			}else if(gubun=="5"){
				GSTR_YYYYMM		 = dsT_EV_ABLRST2.namevalue(row,"EVAYM");
				GSTR_EMPNO		 = dsT_EV_ABLRST2.namevalue(row,"EMPNO");
				GSTR_EMPNMK		 = dsT_EV_ABLRST2.namevalue(row,"EMPNMK");
				GSTR_GRPCD		 = dsT_EV_ABLRST2.namevalue(row,"GRPCD");
				GSTR_JOBGRPH	 = dsT_EV_ABLRST2.namevalue(row,"JOBGRPH");
				GSTR_EVASEQ		 = dsT_EV_ABLRST2.namevalue(row,"EVASEQ");
				GSTR_PAYGRD		 = dsT_EV_ABLRST2.namevalue(row,"PAYGRD");
				GSTR_ROWPOSITION = dsT_EV_ABLRST2.rowposition;
			}

			fnc_SearchList2();

		} */

       /***********************
       * �����ȸ�� �˾� *
       **********************/
        function fnc_EmplPopp() {
			var obj = new String();
            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";
            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
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

    <Object ID="dsT_EV_CORCAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    </Object>



    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �׸��带 Ŭ�������� ó�� �� ����                 |
    +-------------------------------------------------->

    <!--
    <Script For=grdT_EV_ABLRST Event="OnClick(row,col)">
    	fnc_Grid_Onclick('1',row);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnClick(row,col)">
    	fnc_Grid_Onclick('5',row);
    </Script>
-->
    <Script For=grdT_EV_ABLRST Event="OnDblClick(row,col)">
    	fnc_Grid_Dblclick(row,col);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnDblClick(row,col)">
    	fnc_Grid_Dblclick2(row,col);
    </Script>

    <!--
    <Script For=grdT_EV_ABLRST2 Event="OnClick(row,col)">
    	fnc_Grid_Onclick('1',row);
    </Script>
-->
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_CORCAL Event="OnLoadCompleted(iCount)">
		alert("��������� ���ƽ��ϴ�");
		fnc_SearchList();
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        //fnc_SearchList();
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_correct.gif',1)"><img src="../../images/button/btn_correct.gif" name="Image2"  border="0" align="absmiddle" onClick="fnc_Correct()"></a>&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
	                            <col width="60"></col>
	                            <col width="50"></col>
	                            <col width="50"></col>
	                            <col width="140"></col>
	                            <col width="60"></col>
	                            <col width="140"></col>
	                            <col width="30"></col>
	                            <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
                                <td align="right" class="searchState">�����</td>
                                <td class="padding2423">
                                    <input id=txtENOH_NO_SHR name=txtENOH_NO_SHR size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENOH_NO_SHR', 'txtENOH_NM_SHR');">
                                    <input id=txtENOH_NM_SHR name=txtENOH_NM_SHR size="6" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENOH_NM_SHR', 'txtENOH_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENOH_NM_SHR', 'txtENOH_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENOH_NO_SHR','txtENOH_NM_SHR')"></a>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423" >
                                    <fieldset style="width:200px">
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" value="0" onClick="JavaScript: {fnc_SearchList();}" >������
                                    <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="1" onClick="JavaScript: {fnc_SearchList();}">PJT
                                    </fieldset>                                
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
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0" >
                    <tr align="left">
                        <td style="width:500px;height:20px;">
                          <font color="blue" size="2" bold="1" face = "Verdana"">&nbsp;A�׷�</font> 
                        </td>        
                        <td>&nbsp;
                        </td>                        
                        <td style="width:500px">
                          <font color="blue" size="2" bold="1" face = "Verdana"">&nbsp;B �׷�</font> 
                        </td>                                             
                    </tr>                               
                                        
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:550px;">
                                <param name="DataID"                 		value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               		value="false">
                                <param name="DragDropEnable"         		value="true">
                                <param name="SortView"               		value="Left">
                                <param name="VIEWSUMMARY"          			value=1>
                                <param name="AutoReSizing"          		value="true">
                                <param name=ColSizing  				 		value="true">
                                <param name="Format"                 		value="
                                
                                    <FC> id='{CUROW}'     		width=30    name='NO'     		align=center    value={String(Currow)}</FC>
                                    <FC> id='TEAM_NM'    		width=80  	name='�Ҽ�'   		align=left      	edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PART_NM'    		width=80  	name='��Ʈ'   		align=left      	edit=none sumbgcolor=#89add6</FC>  
                                    <FC> id='HENO_NM'   		width=60  	name='�����'   	align=center    edit=none sumbgcolor=#89add6 </FC>                               
                                    <FC> id='JOB_NM'   			width=50  	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText='�� ��'</FC>                                 
                                    <FC> id='ENO_NM'   			width=80  	name='�ǰ����'   	align=center    edit=none sumbgcolor=#89add6 </FC>
                                    <FC> id='DPT_CH_SCR2'   	width=50   	name='����'      	align=center    edit=none sumbgcolor=#89add6   value={Round((DPT_CH_SCR),2)} dec=2  </FC>
                                    <FC> id='AVGSCR'   			width=50  	name='����'   		align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(AVGSCR),2)} dec=2 </FC>
                                
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        
                        <td>&nbsp;
                        </td>      
                                                              
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:550px;">
                                <param name="DataID"                 		value="dsT_EV_ABLRST2">
                                <param name="EdiTABLE"               		value="false">
                                <param name="DragDropEnable"         		value="true">
                                <param name="SortView"               		value="Left">
                                <param name="VIEWSUMMARY"          			value=1>
                                <param name="AutoReSizing"          		value="true">
                                <param name=ColSizing  				 		value="true">
                                <param name="Format"                 		value="

                                    <FC> id='{CUROW}'     		width=30    name='NO'     		align=center    value={String(Currow)}</FC>
                                    <FC> id='TEAM_NM'    		width=80  	name='�Ҽ�'   		align=left      	edit=none sumbgcolor=#89add6</FC>
                                    <FC> id='PART_NM'    		width=80  	name='��Ʈ'   		align=left      	edit=none sumbgcolor=#89add6</FC>  
                                    <FC> id='HENO_NM'   		width=60  	name='�����'   	align=center    edit=none sumbgcolor=#89add6 </FC>                               
                                    <FC> id='JOB_NM'   			width=50  	name='����'      	align=center    edit=none sumbgcolor=#89add6 SumText='�� ��'</FC>                                 
                                    <FC> id='ENO_NM'   			width=80  	name='�ǰ����'   	align=center    edit=none sumbgcolor=#89add6 </FC>
                                    <FC> id='DPT_CH_SCR2'   	width=50   	name='����'      	align=center    edit=none sumbgcolor=#89add6   value={Round((DPT_CH_SCR),2)} dec=2  </FC>
                                    <FC> id='AVGSCR'   			width=50  	name='����'   		align=center    edit=none sumbgcolor=#89add6 SumText={Round(avg(AVGSCR),2)} dec=2 </FC>
                               
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


