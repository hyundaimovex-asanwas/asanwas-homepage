<!--
*****************************************************
* @source       : vluo060.jsp
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
			
          
          //�˻�����
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //�ش�⵵
          var EMPNOH 	= document.form1.txtENOH_NO_SHR.value;        //�����
          var GUBUN 	= "";
		  
          /*
          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//PJT
          }else {
        	    GUBUN = "2";//PJT
          }*/
          GUBUN = "1"; //19�⵵�� PJT ��Ȱ��ȭ ��Ű�鼭 ������ �ϳ��� ����. 
          
          dsT_EV_ABLRST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo060.cmd.VLUO060CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		  dsT_EV_ABLRST.reset();

		  dsT_EV_ABLRST2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo060.cmd.VLUO060CMD&S_MODE=SHR2&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH+"&GUBUN="+GUBUN;
		  dsT_EV_ABLRST2.reset();		  
		  
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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("��ü��", '', 225);        	

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

		document.getElementById("txtREG_YM_SHR").value = '2020';
		document.getElementById("txtENOH_NO_SHR").value=gusrid;
		document.getElementById("txtENOH_NM_SHR").value=gusrnm;


        cfStyleGrid_New(form1.grdT_EV_ABLRST,0,"true","true");      // Grid Style ����
        cfStyleGrid_New(form1.grdT_EV_ABLRST2,0,"true","true");      // Grid Style ����
        
	    //�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
		if(gusrid != "6060002" && gusrid != "6180001"  && gusrid != "2070020" && gusrid != "2020008" ){ 
		
		
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
          var GUBUN 	= "";

          /*
          if(document.form1.rdoGBN_SHR[0].checked){
                GUBUN = "1";//������
          }else if(document.form1.rdoGBN_SHR[1].checked){
                GUBUN = "2";//PJT
          }else {

          }     
          */     
          GUBUN = "1";//������

          if(GUBUN =="1"){ 	//������
        	  
			  if(confirm("������ ��������� �Ͻðڽ��ϱ�?")){
			      dsT_EV_CORCAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo060.cmd.VLUO060CMD&S_MODE=SAV_COR&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}
          
		  }else if((GUBUN =="2")){	//PJT
			  
			  if(confirm("PJT ��������� �Ͻðڽ��ϱ�?")){
			      dsT_EV_CORCAL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo060.cmd.VLUO060CMD&S_MODE=SAV_COR_01&REG_YM_SHR="+REG_YM_SHR+"&EMPNOH="+EMPNOH;
			      dsT_EV_CORCAL.reset();
				}
		  
		  }

        }        
        

		/******************************************************************************
		Description : ��������Է� �˾�â �߱�
		******************************************************************************/

		function fnc_Grid_Dblclick(row,col){

				var result="";
				var arrResult	= new Array();
				var arrParam	= new Array();
				var strURL;
				var strPos;

				arrParam[0] = document.form1.txtREG_YM_SHR.value; //���
			  	arrParam[1] = dsT_EV_ABLRST.namevalue(row,"ENO_NO"); //�ǰ����
			  	arrParam[2] = dsT_EV_ABLRST.namevalue(row,"ENO_NM"); //�ǰ����
			  	arrParam[3] = dsT_EV_ABLRST.namevalue(row,"HENO_NO"); //�����
			  	arrParam[4] = dsT_EV_ABLRST.namevalue(row,"HENO_NM"); //�����
			  	arrParam[5] = dsT_EV_ABLRST.namevalue(row,"GOAL_SEQ"); //GOAL_SEQ

			  	//prompt(this, arrParam);
			  	
			    strURL = "vluo061.jsp";
				strPos = "dialogWidth:1200px;dialogHeight:830px;status:no;scroll:no;resizable:no";
				result = showModalDialog(strURL,arrParam,strPos);

				fnc_SearchList();

		}

		function fnc_Grid_Dblclick2(row,col){

			var result="";
			var arrResult	= new Array();
			var arrParam	= new Array();
			var strURL;
			var strPos;

			arrParam[0] = document.form1.txtREG_YM_SHR.value; //���
		  	arrParam[1] = dsT_EV_ABLRST2.namevalue(row,"ENO_NO"); //�ǰ����
		  	arrParam[2] = dsT_EV_ABLRST2.namevalue(row,"ENO_NM"); //�ǰ����
		  	arrParam[3] = dsT_EV_ABLRST2.namevalue(row,"HENO_NO"); //�����
		  	arrParam[4] = dsT_EV_ABLRST2.namevalue(row,"HENO_NM"); //�����
		  	arrParam[5] = dsT_EV_ABLRST2.namevalue(row,"GOAL_SEQ"); //GOAL_SEQ

		  	//prompt(this, arrParam);
		  	
		    strURL = "vluo061.jsp";
			strPos = "dialogWidth:1200px;dialogHeight:830px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);

			fnc_SearchList();

	}

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
    <Script For=grdT_EV_ABLRST Event="OnDblClick(row,col)">
    	fnc_Grid_Dblclick(row,col);
    </Script>

    <Script For=grdT_EV_ABLRST2 Event="OnDblClick(row,col)">
    	fnc_Grid_Dblclick2(row,col);
    </Script>
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
			<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            &nbsp;&nbsp;    -->    
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_correct.gif',1)"><img src="../../images/button/btn_correct.gif" name="Image2"  border="0" align="absmiddle" onClick="fnc_Correct()"></a>&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                                   <!--  <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" value="2" onClick="JavaScript: {fnc_SearchList();}">PJT -->
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

<br>

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
                                    <FC> id='DPT_CH_SCR'   	width=50   	name='����'      	align=center    edit=none sumbgcolor=#89add6   value={Round((DPT_CH_SCR),2)} dec=2  </FC>
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
                                    <FC> id='DPT_CH_SCR'   	width=50   	name='����'      	align=center    edit=none sumbgcolor=#89add6   value={Round((DPT_CH_SCR),2)} dec=2  </FC>
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


