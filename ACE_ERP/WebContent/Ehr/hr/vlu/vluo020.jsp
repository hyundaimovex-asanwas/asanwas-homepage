<!--
***********************************************************************
* @source      : vluo020.jsp
* @description : ������ǥ���� PAGE
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
<title>������ǥ �����Է�</title>
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

        var year    = "2020";
        var dsTemp = window.dialogArguments;
        var selectRow = 0;
        var count = 0;
        var ENO_NO = "";
        var ENO_NM = "";

		ENO_NO = gusrid;
		ENO_NM = gusrnm;


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	fnc_Clear();

        	if(document.getElementById("txtENO_NM").value == "") {
	       		alert("������ �Է��� �ּ���.");
	       		return;
	       	}

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;
        	
        	
        	dsT_EVL_GOALLIST_CNT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo020.cmd.VLUO020CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
        	dsT_EVL_GOALLIST_CNT.Reset();      
        	
        	
        	var seqqq = dsT_EVL_GOALLIST_CNT.nameValue(1, "GOAL_SEQ");
        	
            //dsT_EVL_GOALLIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo100.cmd.VLUO100CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+seqqq;
            //dsT_EVL_GOALLIST.Reset();
            //cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01); 
           
			dsT_EVL_GOALLIST_01.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo020.cmd.VLUO020CMD&S_MODE=SHR_01&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+seqqq;
			dsT_EVL_GOALLIST_01.Reset();

            cfCopyDataSet(dsT_EVL_GOALLIST_01, dsT_EVL_GOALLIST);  
           
            //dsT_EVL_GOALLIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo100.cmd.VLUO100CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+seqqq;
            //dsT_EVL_GOALLIST.Reset();
            //cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);  
 

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


			for(var i=0; i<=dsT_EVL_GOALLIST.CountRow; i++){       
				dsT_EVL_GOALLIST.UserStatus(i) = 1;				
			}

			//prompt(this, dsT_EVL_GOALLIST.text);
			
			for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {


				dsT_EVL_GOALLIST.nameValue(i, "SELF_COMMENT") 		= dsT_EVL_GOALLIST_01.nameValue(i, "SELF_COMMENT");
				dsT_EVL_GOALLIST.nameValue(i, "SELF_SCR") 			= dsT_EVL_GOALLIST_01.nameValue(i, "SELF_SCR");
			
			}			
			
			//prompt(this, dsT_EVL_GOALLIST.text);
			
            trT_EVL_GOALLIST.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
            trT_EVL_GOALLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo020.cmd.VLUO020CMD&S_MODE=UPT";
            trT_EVL_GOALLIST.post();

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
        	

        	
            //�⵵ Setting
            document.getElementById("txtEVL_YYYY").value = year;
            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;

        	//fnc_ChangeGrid();
        	
    		//�������� ��� �⵵, ��� �˻� Ȱ��ȭ
	    	if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "2070020" && gusrid != "2020008"){ 
	
				document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
		  		document.getElementById("txtEVL_YYYY").readOnly = true;
				document.getElementById("txtENO_NO").className = "input_ReadOnly";
		  		document.getElementById("txtENO_NO").readOnly = true;	  		
				document.getElementById("txtENO_NM").className = "input_ReadOnly";
		  		document.getElementById("txtENO_NM").readOnly = true;
		  		document.getElementById("ImgEnoNo").style.display = "none";
	
			}else{
	
	            document.getElementById("txtEVL_YYYY").className = "";
		  		document.getElementById("txtEVL_YYYY").readOnly = false;
				document.getElementById("txtENO_NO").className = "";
				
		  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
		  		document.getElementById("txtENO_NM").className = "";
		  		document.getElementById("txtENO_NM").readOnly = false;
	
	    	}
    	

			cfStyleGrid_New(grdT_EVL_GOALLIST_CNT, 0, "false", "false");  // Grid Style ����		
			cfStyleGrid_New3(grdT_EVL_GOALLIST_01, 0, "true", "false");    	

			grdT_EVL_GOALLIST_01.RowHeight = 100;          // Grid Row Height Setting
			grdT_EVL_GOALLIST_01.TitleHeight = "35";

    		fnc_SearchList();

        }


        /*****************************************************
         *    �űԵ��                                       *
         ****************************************************/
        function fnc_Insert(){

        	
        }

        
        /*****************************************************
         *    ��������                                       *
         ****************************************************/
        function fnc_Submit() {

        	// ��� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EVL_GOALLIST.CountRow < 1) {
            	document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_17");
                alert(fnc_GetMSG("MSG_17"));
                return;
            }

        	// DataSet�� ���� ���� Ȯ��
            if ( dsT_EVL_GOALLIST.IsUpdated || dsT_EVL_GOALLIST_01.IsUpdated ) {
				alert("������ �� ������ �ּ���.");
                return false;
            }

            if (confirm("�����������Ŀ��� ������ �Ұ����մϴ�. �����Ͻðڽ��ϱ�?") == false) return;



            //��ü�� �Ѿ�� �ؾ���
            dsT_EVL_GOALLIST_01.UseChangeInfo = "false";

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;            
        	var GOAL_SEQ = dsT_EVL_GOALLIST_01.nameValue(1, "GOAL_SEQ");                      
            
            trT_EVL_APPROVAL.Parameters = "EVL_YYYY="+EVL_YYYY+",ENO_NO="+ENO_NO+",GOAL_SEQ="+GOAL_SEQ;
            
            trT_EVL_APPROVAL.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST_01)";
            trT_EVL_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=SAV_01";
            trT_EVL_APPROVAL.post();

            dsT_EVL_GOALLIST_01.UseChangeInfo = "true";

            alert("��� �Ϸ�ƽ��ϴ�.");
            
        	document.getElementById("resultMessage").innerText = "���������� �Ϸ�Ǿ����ϴ�";


        }



        function fnc_SetGrdHeight() {
        	
        	var height = 0;

			height = (dsT_EVL_GOALLIST.CountRow * 100) + 20;

			if(height < 420) { // �ּ� ���� 300px
				height = 420;
			}
			
            grdT_EVL_GOALLIST.style.height = height;
            grdT_EVL_GOALLIST_01.style.height = height;            
            
         
        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            fnc_SearchList();

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList();
	    }                
        

        /*************************
         * �׸��� ���� ó��               *
         ************************/
		function fnc_ChangeGrid(obj) {

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO   = document.getElementById("txtENO_NO").value;
        	
        	//alert(obj);
        	
			if(obj == undefined){	//���� ��ȸ

				form1.grdT_EVL_GOALLIST_01.Format =   "<C> id='{currow}'			    		width=30		name='NO'			align=center		value={String(Currow)}		</C>" +
																	"<C> id='GOAL_SEQ'			width=120		name='GOAL_SEQ'		align=center		show=false </C>" +								
																	"<C> id='CATEGORY'			width=120		name='������������'	align=center		wordwrap=word 		Multiline=true edit=none</C>" +
																	"<C> id='FORMULA'			width=250		name='���θ�ǥ'		align=left			wordwrap=word 		Multiline=true edit=none</C>" +
																	"<G> name='��ǥ'			" +
																	"		<C> id='GOALSET_10'		width=100	name='10����ǥ'		align=left		wordwrap=word Multiline=true edit=none</C>" +
																	"		<C> id='GOALSET'		width=100	name='������ǥ'		align=left		wordwrap=word Multiline=true edit=none</C>" +
																	"</G>"	+
																	"<C> id='WEIGHT'			width=50		name='����ġ'		align=center		wordwrap=word 		Multiline=true edit=none</C>" +		
																	"<C> id='SELF_COMMENT'		width=270		name='����'			align=left			wordwrap=word 		Multiline=true </C>" +
																	"<C> id='SELF_SCR'			width=100		name='������'		align=center		EditStyle=Combo		Data='S:S,A:A,B:B,C:C,D:D' </C>";														
					
            }else if(obj == '0'){ //��� or �Ϸ�
            	
				form1.grdT_EVL_GOALLIST_01.Format =   "<C> id='{currow}'			    		width=30		name='NO'			align=center		value={String(Currow)}		sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C> "+
																	"<C> id='GOAL_SEQ'			width=120		name='GOAL_SEQ'		align=center		show=false BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +								
																	"<C> id='CATEGORY'			width=120		name='������������'	align=center		wordwrap=word 		Multiline=true edit=none sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C> " +
																	"<C> id='FORMULA'			width=250		name='���θ�ǥ'		align=left			wordwrap=word 		Multiline=true edit=none sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"<G> name='��ǥ'			" +
																	"		<C> id='GOALSET_10'		width=100	name='10����ǥ'		align=left		wordwrap=word Multiline=true edit=none BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"		<C> id='GOALSET'		width=100	name='������ǥ'		align=left		wordwrap=word Multiline=true edit=none BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"</G>"	+
																	//"<C> id='GOALSET'			width=160		name='��ǥ'			align=center		wordwrap=word 		Multiline=true edit=none sumbgcolor=#dae0ee</C>" +
																	"<C> id='WEIGHT'			width=50		name='����ġ'		align=center		wordwrap=word 		Multiline=true edit=none sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +		
																	"<C> id='SELF_COMMENT'		width=270		name='����'			align=left			wordwrap=word 		Multiline=true sumbgcolor=#dae0ee SumText='��' BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"<C> id='SCORE'				width=50		name='��'			align=center		SumText={Round(sum(SCORE),2)} value={Round((SCORE),2)} dec=2 show=false BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"<C> id='SELF_SCR'			width=100		name='������'		align=center		EditStyle=Combo		dec=2 Data='S:S,A:A,B:B,C:C,D:D'  sumbgcolor=#dae0ee SumText={Round(sum(SCORE),2)} BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>";

            }else{						//����
            	
				form1.grdT_EVL_GOALLIST_01.Format =   "<C> id='{currow}'			    		width=30		name='NO'			align=center		value={String(Currow)}	BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}	</C>" +
																	"<C> id='GOAL_SEQ'			width=120		name='GOAL_SEQ'		align=center		show=false BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +								
																	"<C> id='CATEGORY'			width=120		name='������������'	align=center		wordwrap=word 		Multiline=true BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"<C> id='FORMULA'			width=250		name='���θ�ǥ'		align=left			wordwrap=word 		Multiline=true BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"<G> name='��ǥ'			" +
																	"		<C> id='GOALSET_10'		width=100	name='10����ǥ'		align=left		wordwrap=word Multiline=true edit=none BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"		<C> id='GOALSET'		width=100	name='������ǥ'		align=left		wordwrap=word Multiline=true edit=none BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"</G>"	+
																	//"<C> id='GOALSET'			width=160		name='��ǥ'			align=center		wordwrap=word 		Multiline=true BgColor={IF(GOALSET='-','#FFCC66','FFFFFF')} </C>" +
																	"<C> id='WEIGHT'			width=50		name='����ġ'		align=center		wordwrap=word 		Multiline=true BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +		
																	"<C> id='SELF_COMMENT'		width=270		name='����'			align=left			wordwrap=word 		Multiline=true show=false BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>" +
																	"<C> id='SELF_SCR'			width=100		name='������'		align=center		EditStyle=Combo		dec=2 Data='S:S,A:A,B:B,C:C,D:D' show=false BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>";

            }

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

    <Object ID="dsT_EVL_GOALLIST_CNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST_01)">
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
    
    <Script For=dsT_EVL_GOALLIST_01 Event="OnLoadCompleted(iCount)">

    
    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EVL_GOALLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EVL_GOALLIST event="OnSuccess()">

    	alert("���������� ó���Ǿ����ϴ�.");
        fnc_SearchList();

        
    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EVL_GOALLIST event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EVL_APPROVAL event="OnSuccess()">

    	fnc_OnLoadProcess();

    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_EVL_GOALLIST event=CanRowPosChange(row)>


	</script>

	<!-----------------------------------------------------+
    | ���� grid���� row�� Ŭ��������                                  |
    +------------------------------------------------------>
	<script for=grdT_EVL_GOALLIST_CNT event=OnClick(Row,Colid)>

	    if (dsT_EVL_GOALLIST_01.IsUpdated)  {
	    	
	        if (confirm("�������� ���� �ڷ�� ���µ˴ϴ�.") == false){
	        	
	        	return;
	        }
	    }	
	    
		if(Row < 1) {
			
			return;
			
		} else {
			
        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO   = document.getElementById("txtENO_NO").value;			
        	var GOAL_SEQ = dsT_EVL_GOALLIST_CNT.NameValue(Row, "GOAL_SEQ");
        	
			dsT_EVL_GOALLIST_01.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo020.cmd.VLUO020CMD&S_MODE=SHR_01&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+GOAL_SEQ;
			dsT_EVL_GOALLIST_01.Reset();

            cfCopyDataSet(dsT_EVL_GOALLIST_01, dsT_EVL_GOALLIST);  

            fnc_SetGrdHeight();		

		}
		
		
		
	</script>

	<!-----------------------------------------------------+
    | �� �� ���ڵ� ���� ���� ������ �Ϸ�� ���Ŀ� �߻��ϴ� �̺�Ʈ	|
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_EVL_GOALLIST_01 event=OnClick(Row,Colid)>
    
    	selectRow = Row;

    	if(dsT_EVL_GOALLIST_CNT.nameValue(dsT_EVL_GOALLIST_CNT.rowposition, "STATUS") == '����'){
			//�̰� �� ���־���? 2020.11.30 �ּ�ó��
    		//if(Colid == 'SELF_SCR'){
    		//	alert("���� �� ������ ����� �ƴմϴ�.");	
    		//}

    	}	    	
    	
  	</script>

	<script language="javascript"  for=grdT_EVL_GOALLIST_01 event=OnDblClick(Row,Colid)>
	    
	if(dsT_EVL_GOALLIST_CNT.nameValue(dsT_EVL_GOALLIST_CNT.rowposition, "STATUS") == '���' || dsT_EVL_GOALLIST_CNT.nameValue(dsT_EVL_GOALLIST_CNT.rowposition, "STATUS") == '�Ϸ�'){

		if(Colid == '{currow}' || Colid == 'CATEGORY' || Colid == 'FORMULA' || Colid == 'GOALSET' || Colid == 'WEIGHT' || Colid =='GOALSET_10'){
			alert("���� ������ ������ �Ұ����մϴ�.");	
		}

	}
		
	if(dsT_EVL_GOALLIST_CNT.nameValue(dsT_EVL_GOALLIST_CNT.rowposition, "STATUS") == '����'){
		//�̰� �� ���־���? 2020.11.30 �ּ�ó��
		//if(Colid == 'SELF_COMMENT' || Colid == 'SELF_SCR'){
		//	alert("���� �� ������ ����� �ƴմϴ�.");	
		//}

	}	
	

		
  	</script>


    <!-----------------------------------------------------+
    | �ٸ� Column���� �ű涧 �̺�Ʈ |    -- Column�� ����Ǳ� ������ �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_EVL_GOALLIST_01 event=OnRowPosChanged(row)>

            for (var i = 1; i <= dsT_EVL_GOALLIST_01.CountRow; i++) {        	
        	
	            if(dsT_EVL_GOALLIST_01.NameValue(i, "SELF_SCR") == "S") {
	            	dsT_EVL_GOALLIST_01.namevalue(i,"SCORE") = (100 * dsT_EVL_GOALLIST_01.namevalue(i,"WEIGHT"))/100;            	
	            } else if(dsT_EVL_GOALLIST_01.NameValue(i, "SELF_SCR") == "A"){
	            	dsT_EVL_GOALLIST_01.namevalue(i,"SCORE") = (85 * dsT_EVL_GOALLIST_01.namevalue(i,"WEIGHT"))/100;    
	            } else if(dsT_EVL_GOALLIST_01.NameValue(i, "SELF_SCR") == "B"){
	            	dsT_EVL_GOALLIST_01.namevalue(i,"SCORE") = (70 * dsT_EVL_GOALLIST_01.namevalue(i,"WEIGHT"))/100;    
	            } else if(dsT_EVL_GOALLIST_01.NameValue(i, "SELF_SCR") == "C"){
	            	dsT_EVL_GOALLIST_01.namevalue(i,"SCORE") = (55 * dsT_EVL_GOALLIST_01.namevalue(i,"WEIGHT"))/100; 
	            } else if(dsT_EVL_GOALLIST_01.NameValue(i, "SELF_SCR") == "D"){
	            	dsT_EVL_GOALLIST_01.namevalue(i,"SCORE") = (40 * dsT_EVL_GOALLIST_01.namevalue(i,"WEIGHT"))/100;    	            	
	            }

        	}
        
        
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
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a></li>
		</ul>
	</div><!-- //btn_group ��-->

<!-- inquiry ����-->
<div class="inquiry">
	<form action="" method="post" >
		<fieldset>
			<legend>��ǥ����</legend>
				<p>�ش�⵵ :
				<span>
					<input type="text" id=txtEVL_YYYY name="txtEVL_YYYY" size="4" readonly class="input_ReadOnly" />
				</span>
				&nbsp;&nbsp;���� :
				<span>
					<input type="text" id="txtENO_NO" name="txtENO_NO" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" /><input type="text" style="display:none" />
					<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" /><input type="text" style="display:none" />
					<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
					<input type="hidden" id="hidEMPL_DPT_CD">					
				</span>
				</p>
		</fieldset>
	</form>
</div>
<!-- // inquiry ��-->

		
<!-- �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr >
	        <td>
				<comment id="__NSID__">
					<object	id="grdT_EVL_GOALLIST_CNT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:120px;">
						<param name="DataID"					value="dsT_EVL_GOALLIST_CNT">
						<param name=HiddenHScroll 				value="true">
						<param name=HiddenVScroll 				value="true">
						<param name="Format"					value="
				            <C> id=GOAL_SEQ         width=50		name='����'        		align=center </C>	
				           <G> name='������'	HeadBgColor='#dae0ee'			
                            <C> id=TEAM_NM			width=100		name='�Ҽ�'				align=center </C>
                            <C> id=PART_NM			width=140		name='��Ʈ'				align=left </C>                            
							<C> id=ENO_NM			width=70		name='�ۼ���'			align=center </C>
				           </G>				           
				           <G> name='����' 	HeadBgColor='#dae0ee'
                            <C> id=HTEAM_NM			width=100		name='�Ҽ�'				align=center </C>
                            <C> id=HPART_NM			width=140		name='��Ʈ'				align=left </C> 	                            
							<C> id=HENO_NM			width=70		name='����'			align=center </C>
				           </G>
							<C> id=STATUS			width=80		name='�������'			align=center </C>
			                <C> id=IPT_YMD       	width=80		name='�ۼ�����'     	align=center </C>								
							<C> id=FROM_TO			width=150		name='�Ⱓ'				align=center </C>
						">
					</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
<!-- �׸��� ���̺� ��-->		

<br>
	
<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
		<font color="blue" size="2" bold="5" face = "Verdana"">�� ���� �Է½� �ٹٲ��� Ctrl + Enter�� �����ø� �˴ϴ�.</font>
		    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


		
<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table summary="��ǥ����" class="evl_table">
	<caption>��ǥ����</caption>
			<colgroup>
				<col width="15" />
				<col width="25"/>
				<col width="25"/>
				<col width="20" />
				<col width="15"/>
				<col width="30" />
				<col width="18"/>
				<col width="15" />		
				<col width="30" />		
			</colgroup>
			<thead>
				<tr>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">NO</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">���� ��������</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">�������</th>
					<th colspan='1' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">��ǥ</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����ġ</th>
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����</th>					
					<th rowspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">������</th>					
					<th colspan='2' style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">�򰡱���(��ǥ)</th>				
				</tr>
				<tr>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">10����</th>				
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">���</th>
					<th style = "height:20px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">����</th>
				</tr>
			</thead>
	<tbody>
	<tr>
	<td colspan="9">
	<div style="width:1000px; height:300px; overflow-y:auto;">
		<table style='font:11px "����",Dotum,"����",Gulim,Verdana,Arial,sans-serif; color:#555; color:#454e69; font-weight:normal;'>
		    <tr align="center">
		        <td>
		        	<comment id="__NSID__">
						<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:770px;height:320px" border="0">
							<param name="DataID"				value="dsT_EVL_GOALLIST_01">
		                	<param name=HiddenVScroll 			value="true">
		                	<param name=HiddenHScroll 			value="true">
	                		<param name=ViewHeader 				value="false">
                            <param name="EdiTABLE"              value="false">	
							<param name="VIEWSUMMARY"			value=1>                            
	                		<param name=HeadBoarder  			value="none">
							<param name="Format"				value="
								<C> id={currow}				width=40    name='NO'			align=center 		sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='GOAL_SEQ'			width=150	name='GOAL_SEQ'		align=center		show=false </C>
								<C> id='CATEGORY'			width=150	name='������������'	align=center		wordwrap=word 		Multiline=true sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='FORMULA'			width=155	name='�������'		align=left			wordwrap=word 		Multiline=true sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='GOALSET_10'			width=98	name='��ǥ'			align=center		wordwrap=word 		Multiline=true edit=none sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='WEIGHT'				width=42	name='����ġ'		align=center		wordwrap=word 		Multiline=true edit=none sumbgcolor=#dae0ee BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='SELF_COMMENT'		width=208	name='����'			align=left			wordwrap=word 		Multiline=true edit=true sumbgcolor=#dae0ee SumText='��' BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='SCORE'				width=50	name='��'			align=center		SumText={sum(SCORE)} value={SCORE} dec=1 show=false BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
								<C> id='SELF_SCR'			width=75	name='������'		align=center		EditStyle=Combo		 dec=1 Data='S:S,A:A,B:B,C:C,D:D' edit=true sumbgcolor=#dae0ee SumText={sum(SCORE)}  BgColor={IF(CATEGORY='���� ������','#FFCC66','FFFFFF')}</C>
							">
						</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>
		        <td>
		            <comment id="__NSID__">
		            <object id="grdT_EVL_GOALLIST" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=230 height=320 border="0">
		                <param name="DataID"                 	 value="dsT_EVL_GOALLIST">
		                <param name=Sort						 value=false>
		               	<param name=ViewHeader 					 value="false">
		                <param name="INDICATORINFO"  			 value='<IndicatorInfo width="0" />'>
		                <param name=BackgroundInfo 				 value='
		                	<BACKGROUNDINFO borderstyle="none" />
		                '>
		                <param name="ColumnInfo"                  value='
		                	<COLUMNINFO>
								<COLUMN id="ID_INFO" view="false">
						    		<HEADER left="0" top="0" right="200" bottom="20" text="�򰡱���(��ǥ)" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    	</COLUMN>
								
						    	<COLUMN id="ID_GRADE_NM" refcolid="GRADE_NM">
						    		<HEADER left="0" top="20" right="50" bottom="40" text="���" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="0" top="0" right="50" bottom="20"  text="S" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����" />
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
						    		<HEADER left="50" top="20" right="220" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="0" right="220" bottom="20" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_A" refcolid="GRADE_A">
						    		<HEADER left="50" top="20" right="220" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="20" right="220" bottom="40" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_B" refcolid="GRADE_B">
						    		<HEADER left="50" top="20" right="220" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="40" right="220" bottom="60" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_C" refcolid="GRADE_C">
						    		<HEADER left="50" top="20" right="220" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="60" right="220" bottom="80" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
						    	</COLUMN>

						    	<COLUMN id="ID_GRADE_D" refcolid="GRADE_D">
						    		<HEADER left="50" top="20" right="220" bottom="40" text="����" bgcolor="#dae0ee" color="#34578c" fontstyle="bold" borderstyle="Line" bordercolor="#d1deeb" fontsize="9" fontname="����" />
						    		<VIEW left="50" top="80" right="220" bottom="100" borderstyle="Line" bordercolor="#9EBEC4" fontsize="9" fontname="����"/>
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

	<tr>
	 <td > <br> </td>
		<td align="left" class="blueBold">
			<br><font color="blue" size="2" bold="5" face = "Verdana"">�� ������ ���̵���� : S(110%�̻�), A(100%�̻�), B(90%�̻�), C(80%�̻�), D(80%�̸�)</font>						
		</td>
	 </td>
	</tr> 

</div><!-- //evl_container �� -->


</body>
</html>


