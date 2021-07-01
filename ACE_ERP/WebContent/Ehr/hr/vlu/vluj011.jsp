<!--
*****************************************************
* @source       : vluj011.jsp
* @description  : ���κ� JOB PROFILE PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      �̵���        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String prmENO_NO    = request.getParameter("ENO_NO");
	String prmENO_NM    = request.getParameter("ENO_NM");
%>

<html>
<head>
<title>���κ� JOB PROFILE(vluj011)</title>
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

        //var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";
        var ActiveIndex = 0;
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 2����
        	var BASIC_YMD_SHR   = "201207";               
        	var ENO_NO   = "<%=prmENO_NO%>";    

	       //���� ��ȸ
	       dsT_EV_JOBSPEC.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.j.vluj010.cmd.VLUJ010CMD&S_MODE=SHR&BASIC_YMD_SHR="+BASIC_YMD_SHR+"&ENO_NO="+ENO_NO;	    
		   dsT_EV_JOBSPEC.reset();

			if(dsT_EV_JOBSPEC.countrow<1){
				fnc_Add();
			}else{
		    	ifrm.fnc_Row_Clear(2); //�ʱ�ȭ
			}
				ifrm.fnc_SearchList();

        }

        /***********************************
         * 				fnc_Add			    *
         ***********************************/
        function fnc_Add() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
          	var REG_YM_SHR = document.form1.cmbYMD_SHR.value;        //�ش�⵵
          	var EMPNO 	= document.form1.txtENO_NO_SHR.value;           //�ǰ����

			//if(!fnc_Add_Chk()) false;

            trT_EV_ABLRST.KeyValue = "tr01(O:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.j.vluj010.cmd.VLUJ010CMD&S_MODE=SHR_00&EMPNO="+EMPNO;
            trT_EV_ABLRST.post();

		  	i = dsT_EV_ABLRST.rowposition;

		  	fnc_SetDataHeader();

		  	dsT_EV_HWORKMST.Addrow();

			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"EVAYM")		= document.form1.cmbYMD_SHR.value; 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"ENO_NO")  	= dsT_EV_ABLRST.namevalue(i,"ENO_NO");   
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"HEAD_CD") 	= dsT_EV_ABLRST.namevalue(i,"HEAD_CD");
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"DPT_CD")  	= dsT_EV_ABLRST.namevalue(i,"DPT_CD"); 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"TEAM_CD") 	= dsT_EV_ABLRST.namevalue(i,"TEAM_CD");  
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOB_CD") 	= dsT_EV_ABLRST.namevalue(i,"JOB_CD");  
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOBGRPH")	= dsT_EV_ABLRST.namevalue(i,"JOBGRPH"); 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOBRR")		= dsT_EV_ABLRST.namevalue(i,"JOBRR"); 
			dsT_EV_HWORKMST.namevalue(dsT_EV_HWORKMST.rowposition,"JOBKIND")	= dsT_EV_ABLRST.namevalue(i,"JOBKIND"); 	

			ifrm.fnc_Row_Clear(2); //�ʱ�ȭ
        }

        
        
        /******************************************************************************
    	Description : ����Ÿ�� ��� ���� (dsT_EV_HWORKMST)
        parameter   :
       ******************************************************************************/
	    function fnc_SetDataHeader(){
	      
	          //��������,��������,��������
	    	if (dsT_EV_HWORKMST.countrow<1){
	    		var s_temp = " EVAYM:STRING(6),ENO_NO:STRING(7),HEAD_CD:STRING(4),"
	    							 + " DPT_CD:STRING(4),TEAM_CD:STRING(4),JOB_CD:STRING(4),"
	    							 + " JOBGRPH:STRING(20),JOBRR:STRING(20),JOBKIND:STRING(20),JOBNAME:STRING(80),"
	    							 + " JOBSM:STRING(2000),"
				 					 + " EDU:STRING(1),MAJOR:STRING(40),SEX:STRING(1),ETC:STRING(100),EXP:STRING(200),"
				 					 + " CERTIFICATE:STRING(200),FRGRD:STRING(200),OAGRD:STRING(200),TECH:STRING(500),"	
				 					 + " STUDY:STRING(200),STUDY2:STRING(200),STUDY3:STRING(200)";					 					 
	    		dsT_EV_HWORKMST.SetDataHeader(s_temp);
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

        	ifrm.fnc_Save();

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
        	ifrm.fnc_Print();
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_JOBSPEC.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("���κ� JOB PROFILE", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_JOBSPEC.CountRow < 1) {
            	fnc_SearchList();
            }            
           
            document.form1.txtJOBNAME.focus();
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
         	ifrm.fnc_Add();
        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        	ifrm.fnc_Delete();
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {


            dsT_EV_JOBSPEC.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            f.txtDPT_CD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //if (dsT_EV_JOBSPEC.IsUpdated)  {
            //    if (!fnc_ExitQuestion()) return;
            //}
            
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



        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

				document.getElementById("txtENO_NO_SHR").value="<%=prmENO_NO%>";   
				document.getElementById("txtENO_NM_SHR").value="<%=prmENO_NM%>"; 
			
			    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
		    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");	
		    	
				fnc_SearchList();    	
        }

        
			/******************************************************************************************
			Descrition : �Է°� üũ (db2 �Է½� �Է°� 2byte ��ȯ�� �ڸ��� üũ)
			******************************************************************************************/
			function bytelength(fe,bstr,mx) {
	
				var xx = "";
				var yy = "";
				var len = bstr.length;
		
				for (var i=0; i<bstr.length; i++) {
					xx = bstr.substr(i,1).charCodeAt(0);
					if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0);
		
					if (i==0) {
						if (xx>127) {	len++;len++; }
					} else {
						if (yy!="") {
							if (yy>127) { len++; }
							else { if (xx>127) { len++;len++; } }
						}
					}
				}
		
				if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;
		
				// Ŭ��� �޽��� �Ѹ���
				if (mx < len){
					alert('�Է��� ���� �� �߸��� �ֽ��ϴ�.\n�ٽ� �Է��Ͽ� �ֽʽÿ�');
					fe.focus();
					fe.select();
				}
		
				return len;
			}

        
	        //Layer ID
	        var layerList = new Array(  "tabvluj020_01"
	                                   ,"tabvluj020_02" );

	        //�˻�����
	        var searchList = new Array( "changeDate_01"
	                                   ,"changeDate_02" );        
        
	    /********************
	       * �ش� ���̾� �����ְ� �ݱ�
	       * @param Ŭ���� layer idx
	       *******************/
	    function TabEvent(idx) {        
        
            ActiveIndex = idx+1;
            
			if(ActiveIndex==1){   //�������

			}else{               //������

			}	    	
			
			
			
            //Layer �����ְ� �ݱ�
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            fnc_ShowHiddenLayer(searchList, searchList[idx]);	    	
	    	
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
    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)                       |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_JOBSPEC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
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


    <!--************************************* *
    *  Component���� �߻��ϴ� Event ó����  * *
    **************************************-->
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBSPEC Event="OnLoadCompleted(iCount)">
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
    <Script For=dsT_EV_JOBSPEC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ� JOB PROFILE</td>
					<td align="right" class="navigator">HOME/�λ���/�����/<font color="#000000">���κ� JOB PROFILE</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
	                            <col width="130"></col>
	                            <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">���ؿ�&nbsp;</td>
				                <td class="padding2423" align="left">
									<select id="cmbYMD_SHR" style="width:80">
										<option value="201207">2012-07</option>
										<option value="200902">2009-02</option>
									</select>
				                </td>								
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="6" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>1. ���� ������ ��������</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="80"></col>
                    <col width="60"></col>
                    <col width="300"></col>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id=txtENO_NO name=txtENO_NO size="7" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id=txtHEAD_NM name=txtHEAD_NM size="12" class="input_ReadOnly" readonly>
                        <input id=txtDPT_NM  name=txtDPT_NM  size="12" class="input_ReadOnly" readonly>
                        <input id=txtTEAM_NM name=txtTEAM_NM size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM size="8" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id=txtENO_NM name=txtENO_NM size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>2. ���� �з�</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width="70"></col>
                    <col width="60"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id=txtJOBGRPH name=txtJOBGRPH size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id=txtJOBRR name=txtJOBRR size="12" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">
                        <input id=txtJOBKIND name=txtJOBKIND size="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id=txtJOBNAME name=txtJOBNAME size="30" >
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>3. ���� ����</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
			<textarea id="txtJOBSM" style="font-size:9pt;width:800px;height:52px;border:1 solid #708090" onBlur="bytelength(this,this.value,2000);">
			</textarea>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->
<br>





    <!-- �� ��� ���۳�Ʈ ���� -->
    <comment id="__NSID__">
    <object id=tabvluj020 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C style="position:width:600; height:25;font-size: 12px;font-weight: bolder">
        <param name="BackColor"             		value="#F8B97B">
        <param name="DisableBackColor"  		value="#EEEEEE">
        <param name="TextColor"             		value="#000000">
        <param name="DisableTextColor"      	value="#878787">
        <param name="ActiveIndex"               value="1">
        <param  name="Format"
                value='
                    <T>divid="tabvluj010_01"    title="�������"</T>
                    <T>divid="tabvluj010_02"    title="������"</T>
                    '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabvluj010_01" style="left:20; top:175; width:800; height:300; z-index:2;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
<br>
	<tr><td> * ������ �����ϴ� ������ ����Ư������ �з��Ͽ� �ۼ��Ͻñ� �ٶ��ϴ� </td></tr>
	<tr><td> * �߰� ��ư�� ������ ��, ����: ����ġ�� �Ѱ谡 100%�� �ǵ���, ���̵�: ��/��/��, �߻���: ��/��/��/�ݱ�/�б��߿� �Է��Ͽ�<br> �ֽñ� �ٶ��ϴ� </td></tr>

	<tr>
		<td align="right">  <!-- �߰� ���� ��ư -->
			<img src="/images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)" style="cursor:hand;">
			<img src="/images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)" style="cursor:hand;">
		</td>
	</tr>
  	<tr>
  		<td>
			<table border="1"  cellpadding=0 cellspacing=0 style=width:800px;height:30px;font-size:9pt;background-color:#ffffff;>
				<tr>
					<td align="center" class="creamBold" width="30">NO</td>
					<td align="center" class="creamBold" width="80">����</td>
					<td align="center" class="creamBold" width="120">����</td>
					<td align="center" class="creamBold" width="360">���� ����</td>
					<td align="center" class="creamBold" width="50">����(%)</td>
					<td align="center" class="creamBold" width="80">���̵�(��/��/��)</td>
					<td align="center" class="creamBold" width="80">�߻���</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
	 <td >
		<iframe id="ifrm" name="ifrm" src="./vluj010_ifrm.jsp" frameborder=0 style="position:relative;top:1px;width:820;height:200px;border:1 solid #708090;"></iframe>
	 </td>
	</tr>

</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->
</div>
<!-- ��1 ���� �Է� ���̺� �� -->

<!-- ��2 ���� �Է� ���̺� ���� -->
<div class=page id="tabvluj010_02"  style="position:absolute; left:20; top:355; width:800; height:300; z-index:3; visibility:hidden">
		<tr><td height=5></td></tr>
		<tr><td> * �� ���������� ���� �ʿ��� �Ϲ��� �ڰݿ���� ����Ͻñ� �ٶ��ϴ� (������ ����� ����ϴ� ���� �ƴմϴ�) </td></tr>
		<br>
<!-- ���� �Է� ���̺� ���� -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="70 "></col>
                    <col width="70"></col>
                    <col width="100 "></col>
                    <col width="70"></col>
                    <col width="*"></col>
                </colgroup>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table_cream">
                <tr>
                    <td align="center" class="creamBold" rowspan="2">�Ϲ��ڰݿ��</td>
                    <td align="center" class="creamBold">�з�</td>
                    <td class="padding2423" >                        
                        <select id="cmbEDU" style="width:130px" >
                            <option value="1">����</option>
                            <option value="4">�ʴ���</option>
                            <option value="2">����</option>
                            <option value="3">���п���</option>                            
                        </select>
                    </td>                    
                    <td align="center" class="creamBold" width="130px">����</td>
                    <td class="padding2423" >                        
                    	<input id=txtMAJOR name=txtMAJOR size="30" >
                    </td>                    
                </tr>
                <tr>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423">                        
                        <select id="cmbSEX" style="width:130px" >
                            <option value="1">��</option>
                            <option value="2">��</option>
                            <option value="3">����</option>                                                   
                        </select>
                    </td>
                    <td align="center" class="creamBold" width="130px">��Ÿ</td>
                    <td class="padding2423">                        
                    	<input id=txtETC name=txtETC size="30" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="5">�ҿ� ����</td>
                    <td align="center" class="creamBold">�ش�о� ���</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtEXP name=txtEXP size="70" >
                    </td>                                   
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ҿ� �ڰ�/������</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtCERTI name=txtCERTI size="70" >
                    </td>    
                </tr>                
                <tr>
                    <td align="center" class="creamBold">�ܱ��� �ɷ�</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtFRGRD name=txtFRGRD size="70" >
                    </td>    
                </tr>                      
                <tr>
                    <td align="center" class="creamBold">OA �ɷ�</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtOAGRD name=txtOAGRD size="70" >
                    </td>    
                </tr>                      
                 <tr>
                    <td align="center" class="creamBold">�ǹ�����/�������</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtTECH name=txtTECH size="70" >
                    </td>    
                </tr>                     
                <tr>
                    <td align="center" class="creamBold" rowspan="3">���������� ���� �ҿ䱳��</td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtSTUDY name=txtSTUDY size="70" >
                    </td>                                   
                </tr>     
                 <tr>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtSTUDY2 name=txtSTUDY2 size="70" >
                    </td>   
                </tr>    
                 <tr>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" colspan="3">                        
                    	<input id=txtSTUDY3 name=txtSTUDY3 size="70" >
                    </td>   
                </tr>                                          
            </table>
        </td>
    </tr>
</table>
</div>
<!-- ��2 ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<object id="bndT_EV_ABLRST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_EV_JOBSPEC">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO	      	    Ctrl=txtENO_NO      	   		Param=value</C>
		<C>Col=ENO_NM			    Ctrl=txtENO_NM		   	    Param=value</C>
		<C>Col=JOBGRPH  			Ctrl=txtJOBGRPH  	   	 		Param=value</C>
		<C>Col=JOBRR    				Ctrl=txtJOBRR 	        		Param=value</C>
		<C>Col=JOBKIND		    	Ctrl=txtJOBKIND 	    		Param=value</C>
		<C>Col=JOBNAME		    	Ctrl=txtJOBNAME 	    		Param=value</C>
		<C>Col=JOBSM		    	Ctrl=txtJOBSM		    		Param=value</C>
        <C>Col=HEAD_NM    			Ctrl=txtHEAD_NM				Param=value</C>
        <C>Col=DPT_NM    			Ctrl=txtDPT_NM				Param=value</C>
        <C>Col=TEAM_NM   			Ctrl=txtTEAM_NM				Param=value</C>
        <C>Col=JOB_NM   			Ctrl=txtJOB_NM				Param=value</C>
        <C>Col=EDU					ctrl=cmbEDU         			param=value</C>
        <C>Col=MAJOR				ctrl=txtMAJOR        			param=value</C>
        <C>Col=SEX					ctrl=cmbSEX					param=value</C>
        <C>Col=ETC					ctrl=txtETC          			param=value</C>
        <C>Col=EXP					ctrl=txtEXP						param=value</C>
        <C>Col=CERTIFICATE  		ctrl=txtCERTI        			param=value</C>
        <C>Col=FRGRD					ctrl=txtFRGRD       			param=value</C>
        <C>Col=OAGRD      			ctrl=txtOAGRD       			param=value</C>
        <C>Col=TECH          		ctrl=txtTECH					param=value</C>
        <C>Col=STUDY				ctrl=txtSTUDY       			param=value</C>
        <C>Col=STUDY2				ctrl=txtSTUDY2       			param=value</C>
        <C>Col=STUDY3				ctrl=txtSTUDY3       			param=value</C>                
    '>
</object>