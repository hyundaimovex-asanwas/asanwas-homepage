<!--
*****************************************************
* @source      : idtc070.jsp
* @description : �ְ�����Ȯ�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      �̵���        �����ۼ�
*-------------+-----------+--------------------------+
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�ְ�����Ȯ��</title>
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

		var today = gcurdate;   
        var eno_no = '';
        var eno_nm = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
        	

            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var PIS_YMD  = document.getElementById("txtPIS_YMD").value;


            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc070.cmd.IDTC070CMD"
										                                + "&S_MODE=SHR"
										                                + "&ENO_NO="+ENO_NO								                                
										                                + "&PIS_YMD="+PIS_YMD.replace("-","").replace("-","");
            //prompt(this, dsT_WF_WORKFORM.DataId);
            
            dsT_WF_WORKFORM.Reset();


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

            if(fnc_SaveItemCheck()) {


            	var WEEK_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"WEEK_NO"); 
            	var ENO_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"ENO_NO"); 
    			
                trT_WF_WORKFORM.KeyValue = "tr01(I:dsT_WF_WORKFORM2=dsT_WF_WORKFORM2)";
                
                trT_WF_WORKFORM.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc070.cmd.IDTC070CMD"
    																					            + "&S_MODE=SAV"
    																					            + "&WEEK_NO="+WEEK_NO
    																								+ "&ENO_NO="+ENO_NO;            
                //prompt(this, dsT_WF_WORKFORM.text);
                
                trT_WF_WORKFORM.post();                
                
                
                
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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        
        
        
        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_WF_WORKFORM2.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            return true;

        }

        
        
        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_WF_WORKFORM,0,"false","true");
            cfStyleGrid_New(form1.grdT_WF_WORKFORM2,0,"true","false");


            document.getElementById("txtPIS_YMD").value = today;
            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

    		//�������� ��� �⵵, ��� �˻� Ȱ��ȭ
	    	if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "2180005" && gusrid != "2070016" && gusrid != "1990071"){             
            
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNoShr");

	    	}else{
	    		
	            document.getElementById("txtENO_NO_SHR").value = "";
	            document.getElementById("txtENO_NM_SHR").value = "";		
	    		
	    	}

       		fnc_SearchList();
       		
        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {



        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

        	
        	
        }


        
       
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                       *
    *                                                                                        *
    ***************************************************************************************-->


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CD_MENTO)|
    | 3. ���Ǵ� Table List(T_CD_MENTO)       |
    +----------------------------------------------->
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_WF_WORKFORM2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_WF_WORKFORM                        |
    | 3. Table List : T_CD_MENTO                    |
    +----------------------------------------------->
    <Object ID ="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:dsT_WF_WORKFORM=dsT_WF_WORKFORM)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_WF_WORKFORM Event="OnClick(row, col)">
    
    
    
	var WEEK_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"WEEK_NO"); 
	var ENO_NO = dsT_WF_WORKFORM.NameValue(dsT_WF_WORKFORM.RowPosition,"ENO_NO"); 
    
    dsT_WF_WORKFORM2.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc020.cmd.IDTC020CMD"
																		        + "&S_MODE=SHR"
																		        + "&WEEK_NO="+WEEK_NO
																				+ "&ENO_NO="+ENO_NO;

    //prompt(this, dsT_WF_WORKFORM2.DataId);
    
	dsT_WF_WORKFORM2.Reset();	
    
	form1.grdT_WF_WORKFORM2.RowHeight = 97;          // Grid Row Height Setting
	form1.grdT_WF_WORKFORM2.TitleHeight = "30";


    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_WF_WORKFORM.CountRow);

        }

        document.getElementById("txtENO_NO").disabled  = true;
        document.getElementById("txtENO_NM").disabled  = true;
        document.getElementById("ImgEnoNo").disabled   = true;

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WF_WORKFORM event="OnSuccess()">

    	alert("���������� ó���Ǿ����ϴ�.");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WF_WORKFORM event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
								<col width="100"></col>
								<col width="80"></col>
								<col width="120"></col>
								<col width="120"></col>
								<col width="150"></col>
								<col width="80"></col>	
								<col width="*"></col>
							</colgroup>

                            <tr>
                            
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YMD" style="ime-mode:disabled" size="10" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYmd','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgStrYmd1" name="ImgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD','','20','120');"></a>
                                </td>                            
                            
                                <td align="right" class="searchState" width="40">Ȯ����</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="7" maxlength= "7"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="left" width="800">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:150px;">
                            <param name="DataID"                  value="dsT_WF_WORKFORM">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
	                                <C> id='WORK_WEEK'     		width=200   name='����'         	align=center edit='none'</C>
	                                <C> id='DPT_NM'     		width=250   name='�Ҽ�'          align=center edit='none' </C>
	                                <C> id='JOB_NM'     		width=250   name='����'         	align=center edit='none'</C>
	                                <C> id='ENO_NM'     		width=250   name='����'         	align=center edit='none'</C>                        
	                                
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


<BR>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="left" width="800">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_WF_WORKFORM2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:425px;">
                            <param name="DataID"                  value="dsT_WF_WORKFORM2">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
							<param name="Format"				value="
								<C> id='CET_NO'				width=85   	name='NO'			align=center 	suppress=1 edit=none</C>
								<C> id='PLAN_EXE'			width=30    name='����'			align=center 	Value={Decode(PLAN_EXE,'PLAN','��ȹ','EXE','���')} </C>
								<C> id='WORK_DETAIL1'		width=200	name='���ֿ���'		align=left		wordwrap=word 		Multiline=true </C>
								<C> id='WORK_DETAIL2'		width=200	name='����/����'		align=left		wordwrap=word 		Multiline=true </C>
								<C> id='WORK_DETAIL3'		width=200	name='��Ÿ'			align=left		wordwrap=word 		Multiline=true </C>
								<C> id='FEED_BACK'			width=280	name='�ǰ�'			align=left		wordwrap=word 		Multiline=true edit=true </C>
								<C> id='STAT'				width=40	name='����'			align=left		show = false 		BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>							
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- ���뺸�� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WF_WORKFORM">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        		Ctrl=txtENO_NO        		Param=value </C>
        <C> Col=ENO_NM        		Ctrl=txtENO_NM        		Param=value </C>
        <C> Col=WORK_WEEK        	Ctrl=txtWORK_WEEK       	Param=value </C>


    '>
</object>


