<!--
*****************************************************
* @source      : idtc020.jsp
* @description : �ְ�������� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      �̵���        �����ۼ�
*-------------+-----------+--------------------------+
*****************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
    String prmENO_NO    = request.getParameter("ENO_NO");
	String prmWEEK_NO   = request.getParameter("WEEK_NO");
%>

<html>
<head>
<title>�ְ��������</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/style_new.css" rel="stylesheet" type="text/css">	
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
        var dsTemp = window.dialogArguments;
        var selectRow = 0;
        var count = 0;

        
        var ENO_NO    = "<%=prmENO_NO %>";     //���
        var WEEK_NO   = "<%=prmWEEK_NO %>";    //���


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	fnc_Clear();

        	
            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc080.cmd.IDTC080CMD"
																			                + "&S_MODE=SHR_DTL"
																			                + "&WEEK_NO="+WEEK_NO
            																				+ "&ENO_NO="+ENO_NO;

            dsT_WF_WORKFORM.Reset();			

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


        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            return true;
            
        }

        

        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  	*
         *******************************************/
        function fnc_OnLoadProcess() {
   	
        	

            document.getElementById("txtWEEK_NO").value = WEEK_NO;  
            document.getElementById("txtENO_NO").value = ENO_NO;
            fnc_GetNm();
            

			document.getElementById("txtENO_NO").className = "input_ReadOnly";
		  	document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
		  	document.getElementById("txtENO_NM").readOnly = true;
		  	document.getElementById("ImgEnoNo").style.display = "none";
	

			cfStyleGrid_New(form1.grdT_WF_WORKFORM, 0, "true", "true");    	

			form1.grdT_WF_WORKFORM.RowHeight = 140;          // Grid Row Height Setting
			form1.grdT_WF_WORKFORM.TitleHeight = "30";

    		fnc_SearchList();

        }





        function fnc_SetGrdHeight() {
        	
        	var height = 0;

			height = (dsT_WF_WORKFORM.CountRow * 200) + 20;

			if(height < 420) { // �ּ� ���� 300px
				height = 420;
			}
			
			form1.grdT_WF_WORKFORM.style.height = height;

         
        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            fnc_SearchList();

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList();
	    }                
        

            
	    
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                           |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WF_WORKFORM)          |
    | 3. ���Ǵ� Table List(T_WF_WORKFORM)             |
    +----------------------------------------------->
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_DI_WEEK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WF_WORKFORM)          |
    | 3. ���Ǵ� Table List(T_WF_WORKFORM)             |
    +----------------------------------------------->
    <Object ID ="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     	Value="toinb_dataid4">
            <Param Name=KeyValue    	Value="tr01(I:SAV=dsT_WF_WORKFORM)">
    </Object>



    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����                    *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

    </Script>
    


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
     <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);


    </Script>




    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��  	   						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_WF_WORKFORM event="OnDblClick(row,colid)">
	
		if(row < 1) {
			
			return;
			
		} else {

			
            if(row == '1' || row == '4'){

            	alert("�Է��Ͻ� �� �����ϴ�");
            	
    			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL1","Edit") = "None";
    			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL2","Edit") = "None";
    			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL3","Edit") = "None";    			
    			
      		}else{
      			
      			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL1","Edit") = "True";
      			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL2","Edit") = "True";
      			grdT_WF_WORKFORM.ColumnProp("WORK_DETAIL3","Edit") = "True";      			
      			
      		}
            

		}
		
	</script>



    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_WF_WORKFORM event="OnSuccess()">

    	alert("���������� ó���Ǿ����ϴ�.");
        fnc_SearchList();

        
    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_WF_WORKFORM event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EVL_APPROVAL event="OnSuccess()">

    	fnc_OnLoadProcess();

    </script>





<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form ���� -->
<form name="form1">

	
<!-- power Search���̺� ���� -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" class="blueTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>

                    <td class="padding2423">

                        <input type="hidden"  id=txtWEEK_NO name="txtWEEK_NO" size="2"  readonly class="input_ReadOnly" />
                    </td>                         
                    <td align="right" class="searchState" width="70">�����ȣ&nbsp;</td>
                    <td class="padding2423">
						<input type="text" id="txtENO_NO" name="txtENO_NO" size="7"  maxlength="7"  class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" /><input type="text" style="display:none" />
						<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" /><input type="text" style="display:none" />
						<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
                    	<input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- power Search���̺� �� -->		
		
<br>	
	
<!-- ���� ��ȸ �׸��� ���̺� ����-->

<table>
    <tr align="center">
        <td>
        	<comment id="__NSID__">
				<object	id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:600px" border="0">
						<param name="DataID"				value="dsT_WF_WORKFORM">
               			<param name="ViewHeader" 			value="true">
                        <param name="EdiTABLE"              value="true">	
						<param name="VIEWSUMMARY"			value=0>                            
               			<param name="HeadBoarder"  			value="true">
						<param name="Format"				value="
							<C> id='CET_NO'				width=90   	name='NO'			align=center 	suppress=1</C>
							<C> id='PLAN_EXE'			width=50    name='����'			align=center 	Value={Decode(PLAN_EXE,'PLAN','��ȹ','EXE','���')} BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='WORK_DETAIL1'		width=220	name='���ֿ���'		align=left		wordwrap=word 		Multiline=true edit=true BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='WORK_DETAIL2'		width=220	name='����/����'		align=left		wordwrap=word 		Multiline=true edit=true BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='WORK_DETAIL3'		width=220	name='��Ÿ'			align=left		wordwrap=word 		Multiline=true edit=true BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='FEED_BACK'			width=180	name='�ǰ�'			align=left		wordwrap=word 		Multiline=true edit=none BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>
							<C> id='STAT'				width=40	name='����'			align=left		show = false 		BgColor={IF(STAT='NO','#8C8C8C','#FFFFFF')}</C>							
					">
				</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>

<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>



