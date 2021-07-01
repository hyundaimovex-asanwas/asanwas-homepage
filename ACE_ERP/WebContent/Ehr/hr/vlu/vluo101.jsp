<!--
***********************************************************************
* @source      : vluo101.jsp
* @description : ��ǥ���� ����/�ΰ�PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/13      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>��ǥ���� ����</title>
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

        var year    = "2021";
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;
        	var GOAL_SEQ = document.getElementById("txtGOAL_SEQ").value;
        	
            dsT_EVL_GOALLIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo100.cmd.VLUO100CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+GOAL_SEQ;
            dsT_EVL_GOALLIST.Reset();
            
            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);  

            if(dsT_EVL_GOALLIST.NameValue(1,"APP_STATUS") == "Y"){
            	
            	alert("�̹� ����ó���Ǿ����ϴ�.");
            	fnc_display("n");
            	
            }else if(dsT_EVL_GOALLIST.NameValue(1,"APP_STATUS") == "S"){
            	
            	alert("���� ��������Դϴ�.\n\n������ ����� �ؾ� �����Ͻ� �� �ֽ��ϴ�.");
            	fnc_display("n");

            }           

            fnc_SetGrdHeight();

          
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
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  			*
         *******************************************/
        function fnc_OnLoadProcess() {

			var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
			var GOAL_SEQ = "<%=request.getParameter("GOAL_SEQ") %>";
			
            document.getElementById("txtEVL_YYYY").value = year;
            document.getElementById("txtENO_NO").value = ENO_NO;
            document.getElementById("txtGOAL_SEQ").value = GOAL_SEQ;            
            fnc_GetNm();
            		
			cfStyleGrid_New3(grdT_EVL_GOALLIST_01, 0, "false", "false");
			grdT_EVL_GOALLIST_01.RowHeight = 100;          // Grid Row Height Setting
			grdT_EVL_GOALLIST_01.TitleHeight = "40";
			
    		fnc_SearchList();

        }



        /*****************************************************
         * ���� status Y:����, N:�ΰ�                             *
         ****************************************************/

        function fnc_Approval(yn) {

 			var ENO_NO 	= document.getElementById("txtENO_NO").value;
 			var GOAL_SEQ 	= document.getElementById("txtGOAL_SEQ").value;
        	var kind = "";

        	if(yn == "Y") {
	        	kind = "����";
			} else {
	        	kind = "�ΰ�";
			}
        	if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;


			dsT_EVL_GOALLIST.UserStatus(1) = 1; //���� ������ ���� ����		
				
			trT_EVL_APPROVAL.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
	        trT_EVL_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo100.cmd.VLUO100CMD&S_MODE=UPT_02&EVL_YYYY="+year+"&ENO_NO="+ENO_NO+"&STATUS="+yn+"&GOAL_SEQ="+GOAL_SEQ;
	        trT_EVL_APPROVAL.post();

			alert(kind + "�Ͽ����ϴ�.");

			// ���� �� â ����
			window.close();

        }
        
   
		// display
        function fnc_display(yn) {

        	if(yn == "n") {
	        	document.getElementById("btnApproval").style.display = "none";
				document.getElementById("btnReject").style.display = "none";

			} else {
				document.getElementById("btnApproval").style.display = "";
				document.getElementById("btnReject").style.display = "";

			}
     	
        }

        function fnc_SetGrdHeight() {
        	
        	var height = 0;

			height = (dsT_EVL_GOALLIST.CountRow * 100) + 20;
			
			if(height < 420) { // �ּ� ���� 400px
				height = 420;
			}
            grdT_EVL_GOALLIST.style.height = height;
            grdT_EVL_GOALLIST_01.style.height = height;
            
        }

        function fnc_GetNm() {
        	
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            
            return true;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_EVL_GOALLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_APPROVAL) |
    | 3. ���Ǵ� Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EVL_GOALLIST) |
    | 3. ���Ǵ� Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EVL_APPROVAL) |
    | 3. ���Ǵ� Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_GOALLIST Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-- Ʈ������ ����. -->
    <script for=trT_EVL_GOALLIST event="OnSuccess()">

        fnc_SearchList();

    </script>


    <!--Ʈ������ ���� -->
    <script for=trT_EVL_GOALLIST event="OnFail()">

        cfErrorMsg(this);

    </script>




<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<div class="evl_container"><!-- evl_container ����-->

<br>

	<div class="btn_group_right" ><!-- btn_group ����-->
		<ul class="list">
			<li><a href="#"><img id="btnApproval" 	name="btnApproval" 	src="../../images/button/btn_ApprovalOn.gif" onmouseover="this.src='../../images/button/btn_ApprovalOver.gif'" 	onmouseout="this.src='../../images/button/btn_ApprovalOn.gif'" alt="����" onclick="fnc_Approval('Y');" /></a></li>
			<li><a href="#"><img id="btnReject" 	name="btnReject" 	src="../../images/button/btn_RejectionOn.gif" onmouseover="this.src='../../images/button/btn_RejectionOver.gif'" onmouseout="this.src='../../images/button/btn_RejectionOn.gif'" alt="�ΰ�" onclick="fnc_Approval('S');" /></a></li>
		</ul>
	</div><!-- //btn_group ��-->


	<div class="inquiry"><!-- inquiry ����-->
		<form action="" method="post" >
			<fieldset>
				<legend>��ǥ����</legend>
					<p>�ش�⵵ :
					<span>
						<input type="text" id=txtEVL_YYYY name="txtEVL_YYYY" size="4" readonly class="input_ReadOnly" />
					</span>
					&nbsp;&nbsp;���� :
					<span>
						<input type="text" id="txtENO_NO" name="txtENO_NO" size="10" maxlength="10" class="input_ReadOnly" readonly /><input type="text" style="display:none" />
						<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly" readonly /><input type="text" style="display:none" />				
					</span>
					&nbsp;&nbsp;���� :
					<span>
						<input type="text" id="txtGOAL_SEQ" name="txtGOAL_SEQ" size="5" maxlength="5" class="input_ReadOnly" readonly /><input type="text" style="display:none" />
					</span>					
					</p>
			</fieldset>
		</form>
	</div><!-- // inquiry ��-->


		
	<!-- ���� ��ȸ �׸��� ���̺� ����
	<table  summary="��ǥ����" class="evl_table">
	<caption>��ǥ����</caption>
			<colgroup>
				<col width="50px" />
				<col width="150px" />
				<col width="500px" />
				<col width="200px" />
				<col width="90px" />	
				<col width="20px" />												
			</colgroup>
			<thead>
				<tr>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">NO</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">������������</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">���θ�ǥ �޼�����<BR>(�򰡱���/�������)</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">��ǥ</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����ġ<BR>(100%)</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;"> </th>

				</tr>		
			</thead>
			<tbody>
	<tr>
	<td colspan="6">
	<div style="width:1000px; height:400px; overflow-y:auto;">
		<table style='font:11px "����",Dotum,"����",Gulim,Verdana,Arial,sans-serif; color:#555; color:#454e69; font-weight:normal;'>
		    <tr align="center">
		        <td>
		        	<comment id="__NSID__">
						<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:400px;">
							<param name="DataID"				value="dsT_EVL_GOALLIST">
		                	<param name=HiddenVScroll 			value="false">
		                	<param name=HiddenHScroll 			value="false">
	                		<param name=ViewHeader 				value="false">
							<param name="Format"				value="
								<C> id={currow}			width=48   	name='NO'			align=center </C>
								<C> id='CATEGORY'		width=150	name='������������'	align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'		width=500	name='���θ�ǥ'		align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET'		width=200	name='�޼�����'		align=center	wordwrap=word Multiline=true </C>
								<C> id='WEIGHT'			width=100	name='����ġ'			align=center	wordwrap=word Multiline=true </C>																														
							">
						</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>	        
		    </tr>
		</table>
	</div>
	</td>
	</tr>
	</table>	
-->

	
<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table summary="��ǥ����" class="evl_table">
	<caption>��ǥ����</caption>
			<colgroup>
				<col width="30" />
				<col width="120"/>
				<col width="200"/>
				<col width="50" />
				<col width="250"/>
				<col width="90" />
				<col width="90" />
				<col width="90" />
				<col width="80" />
				
			</colgroup>
			<thead>
				<tr>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">NO</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">���� ��������</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">�������</th>
					<th colspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">�򰡱���(��ǥ)</th>
					<th colspan='3' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">��ǥ</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����ġ<br>100%</th>
				</tr>
				<tr>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">���</th>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����</th>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">��ݱ�</th>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">10����</th>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����</th>
				</tr>
			</thead>
	<tbody>
	<tr>
	<td colspan="9">
	<div style="width:1000px; height:500px; overflow-y:auto;">
		<table style='font:11px "����",Dotum,"����",Gulim,Verdana,Arial,sans-serif; color:#555; color:#454e69; font-weight:normal;'>
		    <tr align="center">
		        <td>
		        	<comment id="__NSID__">
						<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:350px;height:520px;">
							<param name="DataID"				value="dsT_EVL_GOALLIST_01">
		                	<param name=HiddenVScroll 	value="true">
		                	<param name=HiddenHScroll 	value="true">
	                		<param name=ViewHeader 		value="false">
							<param name="Format"				value="
								<C> id={currow}		width=30   name='NO'		align=center </C>
								<C> id='GOAL_SEQ'	width=150	name='GOAL_SEQ'		align=center	show=false </C>
								<C> id='CATEGORY'	width=120	name='������������'		align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'	width=200	name='�������'	align=left	wordwrap=word Multiline=true </C>
							">
						</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>
		        <td>
		            <comment id="__NSID__">
		            <object id="grdT_EVL_GOALLIST" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=630 height=520 border="0">
		                <param name="DataID"                  value="dsT_EVL_GOALLIST">
		                <param name=Sort						 value=false>
		               	<param name=ViewHeader 		value="false">
		                <param name="INDICATORINFO"  value='<IndicatorInfo width="0" />'>
		                <param name=BackgroundInfo 	value='
		                	<BACKGROUNDINFO borderstyle="none" />
		                '>
		                <param name="ColumnInfo"                  value='
		                	<COLUMNINFO>
								<COLUMN id="ID_INFO" view="false">
						    		<HEADER left="0" top="0" right="300" bottom="20" text="�򰡱���(��ǥ)" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    	</COLUMN>
								
						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="50" bottom="40" text="���" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="0" top="0" right="50" bottom="20"  text="S" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="50" bottom="40" text="���" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="0" top="20" right="50" bottom="40"  text="A" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="50" bottom="40" text="���" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="0" top="40" right="50" bottom="60" text="B" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="50" bottom="40" text="���" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="0" top="60" right="50" bottom="80" text="C" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="50" bottom="40" text="���" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="0" top="80" right="50" bottom="100" text="D" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_S" refcolid="GRADE_S">
						    		<HEADER left="50" top="20" right="300" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="0" right="300" bottom="20" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_A" refcolid="GRADE_A">
						    		<HEADER left="50" top="20" right="300" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="20" right="300" bottom="40" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_B" refcolid="GRADE_B">
						    		<HEADER left="50" top="20" right="300" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="40" right="300" bottom="60" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_C" refcolid="GRADE_C">
						    		<HEADER left="50" top="20" right="300" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="60" right="300" bottom="80" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_D" refcolid="GRADE_D">
						    		<HEADER left="50" top="20" right="300" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="80" right="300" bottom="100" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GOALSET_HALF" refcolid="GOALSET_HALF">
						    		<HEADER left="300" top="0" right="390" bottom="40" text="��ݱ�" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="300" top="0" right="390" bottom="100" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>
						    	<COLUMN id="ID_GOALSET_10" refcolid="GOALSET_10">
						    		<HEADER left="390" top="0" right="480" bottom="40" text="10����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="390" top="0" right="480" bottom="100" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>
						    	<COLUMN id="ID_GOALSET" refcolid="GOALSET">
						    		<HEADER left="480" top="0" right="570" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="480" top="0" right="570" bottom="100" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>
						    	<COLUMN id="ID_WEIGHT" refcolid="WEIGHT">
						    		<HEADER left="570" top="0" right="630" bottom="40" text="����ġ" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="570" top="0" right="630" bottom="100" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>
						     </COLUMNINFO>
						 '>
		            </object>
		            </comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>
		    </tr>
		</table>
	</div>
	</td>
	</tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->
	
<!-- �׸��� ���̺� ����
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr >
	        <td>
				<comment id="__NSID__">
					<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:535px;">
						<param name="DataID"					value="dsT_EVL_GOALLIST">
						<param name=HiddenHScroll 				value="false">
						<param name=HiddenVScroll 				value="false">
						<param name="Format"					value="
								<C> id={currow}			width=48   	name='NO'											align=center </C>
								<C> id='GOAL_SEQ'		width=150	name='GOAL_SEQ'										align=center	show=false </C>
								<C> id='CATEGORY'		width=150	name='������������'									align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'		width=400	name='���θ�ǥ �޼�����\\(�򰡱���/�������)'		align=left		wordwrap=word Multiline=true </C>
			                <G> name='��ǥ' 			BgColor='#dae0ee'	
								<C> id='GOALSET_HALF'	width=100	name='��ݱ��ǥ'									align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET_10'		width=100	name='10����ǥ'										align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET'		width=100	name='������ǥ'										align=left		wordwrap=word Multiline=true </C>
							</G>	
								<C> id='WEIGHT'			width=80	name='����ġ'										align=center	 Edit=none</C>		
						">
					</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
 �׸��� ���̺� ��
-->



</div><!-- //evl_container �� -->


</body>
</html>

