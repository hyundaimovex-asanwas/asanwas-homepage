<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<!-- <meta charset=euc-kr"> -->
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Cache-control" content="no-cache"/>
	<meta http-equiv="Cache-control" content="no-store"/>
	<meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=1080" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<jsp:include page="/Pms/common/include/head.jsp"/>
<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >


	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var menuWin;	//��â �����.

	var Tabvalue = 1;
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("grd_ITEM_D"), "comn");	//list detail

		cfStyleGrid(getObjectFirst("grd_ITEM_D_grid"), "comn");		//list detail
		cfStyleGrid(getObjectFirst("grd_ITEM_D_grid2"), "comn");	//list detail
		cfStyleGrid(getObjectFirst("grd_ITEM_D_grid3"), "comn");	//list detail
		
		fnInit();
		
	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
        
    	strParam=window.dialogArguments;

		document.getElementById("v_project").value = strParam[0];				//Project Code 
		document.getElementById("v_no_budget").value = strParam[1];				//��������   
        
        var cost_cd = strParam[0];   //�ּ� Ǯ����ߵ�
        
        var no_budget = strParam[1];
        
    	var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
								    		+ ",V_COST_CD=" + cost_cd 
								    		+ ",V_NO_BUDGET=" + no_budget
								    		;
        
    	
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
		
        ln_TRSetting(tr1, 
		        	"<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
		            "JSP(O:DS_ITEM_M=ds_item_m,O:DS_PROJECT=ds_project)",
		            param);

		
        tr_post(tr1);

        

		
		
        
    }
	
    
    <%//���� ��ȸ %>
    function fnSelect() {

    	v_job="S";

    	/* protype = select , v_site_sid ,  */
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_code=" + txtCOMM_CD_SHR.value				//�˻�����
							;

        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd010",
	            "JSP(O:DS_ITEM_M=ds_item_m)", //ȭ�� ���
	            v_param);

        
        tr_post(tr1);

    }    
    





	<%//����=���ο�û %>
	function fnApply(){
		
		v_job = "A";
		
		if (ds_item_d.NameValue(ds_item_d.rowposition,"COST_YN") == 'Y') {

			if (ds_item_d.NameValue(ds_item_d.rowposition,"ITEM_CD") == '') {
				
				alert("ǰ���ڵ�� ������ ä��ñ� �ٶ��ϴ�.");
				
				return false;
				
			}

		}

		if (ds_item_d.IsUpdated) {

			  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
				                "JSP(I:DS_ITEM_D=ds_item_d)",
				                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                );

			  tr_post(tr1);

			  
        }else{
        	
     		alert("������ Data�� �����ϴ�.");
		
        }
		
		
	 }




		<%//�ű� ���� %>
	      function fnAddNew() {
	    	  
	          // AddNew �� �Է� ���̺�� ��Ŀ��
	          ds_item_d.AddRow(); 
	          
	          ds_item_d.namevalue(ds_item_d.RowPosition, "COST_CD")= document.getElementById("v_project").value;
	          ds_item_d.namevalue(ds_item_d.RowPosition, "NO_BUDGET")= document.getElementById("v_no_budget").value;	           
	          ds_item_d.NameValue(ds_item_d.RowPosition,"DT_APPLY") = "<%=DateUtil.getCurrentDate(8)%>";

	      }

	      
	      
	  	<%//�׼� �ٿ��ϱ�%>
	    function fnExcel() {

	        if(Tabvalue  == 1){

	        	alert("Tree�� �ٸ� Tab�� �����Ͻñ� �ٶ��ϴ�.");
		        //getObjectFirst("grd_ITEM_D").SetExcelTitle(0, "");
		        //getObjectFirst("grd_ITEM_D").SetExcelTitle(1, "value:���࿹��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        //getObjectFirst("grd_ITEM_D").GridToExcel("���࿹����Ȳ", "���࿹����Ȳ.xls", 8);  
	        	
	        }else if(Tabvalue  == 2){
	        	
		        getObjectFirst("grd_ITEM_D_grid").SetExcelTitle(0, "");
		        
		        getObjectFirst("grd_ITEM_D_grid").SetExcelTitle(1, "value:���࿹��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        
		        getObjectFirst("grd_ITEM_D_grid").GridToExcel("���࿹����Ȳ", "���࿹����Ȳ.xls", 8);        

	        }else if(Tabvalue  == 3){
	        	
		        getObjectFirst("grd_ITEM_D_grid2").SetExcelTitle(0, "");
		        
		        getObjectFirst("grd_ITEM_D_grid2").SetExcelTitle(1, "value:��������������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        
		        getObjectFirst("grd_ITEM_D_grid2").GridToExcel("����������������Ȳ", "����������������Ȳ.xls", 8);        

	        }else if(Tabvalue  == 4){	       
	        	
		        getObjectFirst("grd_ITEM_D_grid3").SetExcelTitle(0, "");
		        
		        getObjectFirst("grd_ITEM_D_grid3").SetExcelTitle(1, "value:��ü����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        
		        getObjectFirst("grd_ITEM_D_grid3").GridToExcel("��ü������Ȳ", "��ü������Ȳ.xls", 8);        

	        }


	    	
	    }	      
	      
	    
	  	<%//Print�ϱ�%>
	    function fnPrint() {

	         alert("�������Դϴ�.");

	    }	 	    
	    
	    
</script>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                            |
    | 2. �̸� : ds_item_m,    ds_item_d            |
    +----------------------------------------------->
    
	<object id=ds_item_m classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>
	
	<object id=ds_item_d classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>

	<object id=ds_project classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>


	<object id=ds_item_d_grid classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>

	<object id=ds_item_d_grid2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>
	
	<object id=ds_item_d_grid3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>
		
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : tr1                  				|
    +----------------------------------------------->
    
	<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
	    <param name="KeyName"    value="toinb_dataid4"/>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>


<!--*************************************
*                                       *
*  Component���� �߻��ϴ� Event ó����  *
*                                       *
**************************************-->

<!-------------------------------------------------+
| �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
+-------------------------------------------------->

<%//������ �׸��� OnClick %>

<script language="javascript"  for=tb_TreeView event=OnClick()>

	
	var overId1 = "CD_COST";
	
	var overId2 = "TREE_LEVEL";
	
	var overNm = tb_TreeView.ItemText;
	
	var Row = ds_item_m.NameValueRow("DS_KSITEM",overNm);
	
	var overValue1 = ds_item_m.NameValue(Row,overId1);
	
	var overValue2 = ds_item_m.NameValue(Row,overId2);

	//alert("Row : "+Row+", overValue1 : "+overValue1+", overValue2 : "+overValue2);
	overValue2 = parseInt(overValue2)+1;
		
  	v_job="S";

    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_project="    + v_project.value					//project �ڵ�
							+ ",v_no_budget="  + v_no_budget.value					//���� ����		      
							+ ",v_overValue1=" + overValue1							//�ڵ��
							+ ",v_overValue2=" + overValue2							//Tree Level					
							;

    ln_TRSetting(tr1, 
	          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
	          "JSP(O:DS_ITEM_D=ds_item_d)", 						
	          v_param);

    //alert(v_param);
    
    tr_post(tr1);

</script>


<script language=JavaScript  for=ds_item_m event=OnLoadCompleted(row)>

	
		if(row>0){

			tb_TreeView.focus();

			tb_TreeView.ExpandLevel = '2';

			tb_TreeView.index = 3;	

		  	v_job="S";

		  	var v_project_s =  document.getElementById("v_project").value;		  	
		  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project_s							//project �ڵ�
										+ ",v_no_budget="  + v_no_budget_s							//���� ����		      
										+ ",v_overValue1=P" //+ overValue1							//�ڵ��
										+ ",v_overValue2=2" //+ overValue2							//Tree Level						
										;

		  	
		    //alert(v_param);
		    
		    ln_TRSetting(tr1, 
			          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
			          "JSP(O:DS_ITEM_D=ds_item_d)", 						
			          v_param);
		
		    
		    tr_post(tr1);			
			

			document.getElementById("v_project_nm").value = ds_item_m.namevalue(1, "DS_KSITEM");
			document.getElementById("v_order_amt").value = ds_item_m.namevalue(1, "ORDER_AMT");
			document.getElementById("v_act_amt").value = ds_item_m.namevalue(1, "EXE_ACT_AMT");			
			
			document.getElementById("v_pro").value = Math.round((ds_item_m.namevalue(1, "EXE_ACT_AMT")/ds_item_m.namevalue(1, "ORDER_AMT")) * 100);					
			
        }
		
</script>




<script language=JavaScript for=grd_ITEM_D event=OnPopup(Row,Colid,data,xpos,ypos)>

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "<%=dirPath%>/Pms/new/bud/bd013.jsp";
		
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		sApproveLine = arrResult; 
		
		if (arrResult != null) {
    		arrParam = arrResult.split(";");
    	   	ds_item_d.Namevalue(ds_item_d.rowposition,"ITEM_CD")=arrParam[0];    		
    	   	ds_item_d.Namevalue(ds_item_d.rowposition,"ITEM_NM")=arrParam[1];	
        }
			
</script>


<script language=JavaScript for=grd_ITEM_D_grid event=OnPopup(Row,Colid,data,xpos,ypos)>

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "<%=dirPath%>/Pms/new/bud/bd013.jsp";
		
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		sApproveLine = arrResult; 
		
		if (arrResult != null) {
    		arrParam = arrResult.split(";");
    		ds_item_d_grid.Namevalue(ds_item_d_grid.rowposition,"ITEM_CD")=arrParam[0];    		
    		ds_item_d_grid.Namevalue(ds_item_d_grid.rowposition,"ITEM_NM")=arrParam[1];	
        }
			
</script>

<script language=JavaScript for=grd_ITEM_D_grid2 event=OnPopup(Row,Colid,data,xpos,ypos)>

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "<%=dirPath%>/Pms/new/bud/bd013.jsp";
		
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		sApproveLine = arrResult; 
		
		if (arrResult != null) {
    		arrParam = arrResult.split(";");
    		ds_item_d_grid2.Namevalue(ds_item_d_grid2.rowposition,"ITEM_CD")=arrParam[0];      		
    		ds_item_d_grid2.Namevalue(ds_item_d_grid2.rowposition,"ITEM_NM")=arrParam[1];	
        }
			
</script>

<script language=JavaScript for=grd_ITEM_D_grid3 event=OnPopup(Row,Colid,data,xpos,ypos)>

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "<%=dirPath%>/Pms/new/bud/bd013.jsp";
		
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		sApproveLine = arrResult; 
		
		if (arrResult != null) {
    		arrParam = arrResult.split(";");
    		ds_item_d_grid3.Namevalue(ds_item_d_grid3.rowposition,"ITEM_CD")=arrParam[0]; 
    		ds_item_d_grid3.Namevalue(ds_item_d_grid3.rowposition,"ITEM_NM")=arrParam[1];	
        }
			
</script>

<script language=JavaScript for=mxTab event=OnSelChanged(index)>

		//tree ��ȸ
		if(index == '1'){
			
				document.getElementById("mxTab_Tree").style.display = "";
				document.getElementById("mxTab_Grid").style.display = "none";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";
				Tabvalue = 1;

		//���࿹�� ��ȸ
        }else if(index == '2'){
				
				document.getElementById("mxTab_Tree").style.display = "none";	        	
				document.getElementById("mxTab_Grid").style.display = "";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";
				
				
			  	v_job="S";

			  	var v_project_s =  document.getElementById("v_project").value;		  	
			  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project_s							//project �ڵ�
											+ ",v_no_budget="  + v_no_budget_s							//���� ����		      
											+ ",v_overValue1=P" 
											+ ",v_overValue2=1" 					
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
				          "JSP(O:DS_ITEM_D_GRID=ds_item_d_grid)", 						
				          v_param);

			    tr_post(tr1);	
				Tabvalue = 2;

				
		//������/�������� ��ȸ				
        }else if(index == '3'){
			
			document.getElementById("mxTab_Tree").style.display = "none";	        	
			document.getElementById("mxTab_Grid").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "";
			document.getElementById("mxTab_Grid3").style.display = "none";
			
			
		  	v_job="S";

		  	var v_project_s =  document.getElementById("v_project").value;		  	
		  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project_s							//project �ڵ�
										+ ",v_no_budget="  + v_no_budget_s							//���� ����		      
										+ ",v_overValue1=P" 
										+ ",v_overValue2=1" 					
										;
		    
		    ln_TRSetting(tr1, 
			          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
			          "JSP(O:DS_ITEM_D_GRID2=ds_item_d_grid2)", 						
			          v_param);

		    tr_post(tr1);	
			Tabvalue = 3;

			
		//��ü���� ��ȸ			
        }else if(index == '4'){
			
			document.getElementById("mxTab_Tree").style.display = "none";	        	
			document.getElementById("mxTab_Grid").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "none";
			document.getElementById("mxTab_Grid3").style.display = "";
			
			
		  	v_job="S";

		  	var v_project_s =  document.getElementById("v_project").value;		  	
		  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project_s							//project �ڵ�
										+ ",v_no_budget="  + v_no_budget_s							//���� ����		      
										+ ",v_overValue1=P" 
										+ ",v_overValue2=1" 					
										;
		    
		    ln_TRSetting(tr1, 
			          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
			          "JSP(O:DS_ITEM_D_GRID3=ds_item_d_grid3)", 						
			          v_param);

		    tr_post(tr1);			    
			Tabvalue = 4;

        }
		

		
</script>





<script language=JavaScript for=grd_ITEM_D event=OnCloseUp(row,colid)>

	  		if (ds_item_d.NameValue(row,"COST_YN") == 'N') {

	  			grd_ITEM_D.ColumnProp("ORDER_AMT_OLD","Edit")="none";
				grd_ITEM_D.ColumnProp("ORDER_AMT_NOW","Edit")="none";			
				grd_ITEM_D.ColumnProp("ORDER_AMT_DIF","Edit")="none";
				grd_ITEM_D.ColumnProp("EXE_ACT_AMT_OLD","Edit")="none";
				grd_ITEM_D.ColumnProp("EXE_ACT_AMT_NOW","Edit")="none";			
				grd_ITEM_D.ColumnProp("EXE_ACT_AMT_DIF","Edit")="none";	
				grd_ITEM_D.ColumnProp("ITEM_CD","Edit")="none";			
				grd_ITEM_D.ColumnProp("ITEM_NM","Edit")="none";	
				
	  		} else if (ds_item_d.NameValue(row,"COST_YN") == 'Y') {

	  			//grd_ITEM_D.ColumnProp("ORDER_AMT_OLD","Edit")="";
				grd_ITEM_D.ColumnProp("ORDER_AMT_NOW","Edit")="";			
				//grd_ITEM_D.ColumnProp("ORDER_AMT_DIF","Edit")="";
				//grd_ITEM_D.ColumnProp("EXE_ACT_AMT_OLD","Edit")="";
				grd_ITEM_D.ColumnProp("EXE_ACT_AMT_NOW","Edit")="";			
				//grd_ITEM_D.ColumnProp("EXE_ACT_AMT_DIF","Edit")="";	
				//grd_ITEM_D.ColumnProp("ITEM_CD","Edit")="";			
				grd_ITEM_D.ColumnProp("ITEM_NM","Edit")="";					
				
	  		}       
    
    
</script>

<script language=JavaScript for=grd_ITEM_D event=OnDropDown(row,colid)>

    //alert("28 Occur OnDropDown Event :" + "<ROW :" + row +">"+ "<Colid :" + colid + ">" )

</script>



 <!-----------------------------+
 | Transaction Successful ó��      |
 +------------------------------>
 <script for=tr1 event="OnSuccess()">
 
	if(v_job=="A"){
		
		//alert("���������� ����Ǿ����ϴ�.");
		fnInit();
	}
	
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
 </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->


</head>

    <jsp:include page="/Common/sys/body_s11.jsp"/>



<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
	        	<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">
	        	<img src="<%=dirPath%>/Sales/images/plus.gif"					style="cursor:pointer" onclick="fnAddNew()">
	        	<img src="<%=dirPath%>/Sales/images/save.gif"					style="cursor:pointer" onclick="fnApply()">	
	        	
	        	<img src="<%=dirPath%>/Sales/images/excel.gif"					style="cursor:pointer" onclick="fnExcel()">
	        	<img src="<%=dirPath%>/Sales/images/print.gif"					style="cursor:pointer" onclick="fnPrint()">	
	        		        	
	        </td>
	    </tr>
	</table>
<!-- ��ư ���̺� �� -->
	
	
	

<!-- �� ��� ���۳�Ʈ ���� -->
<object id=mxTab classid=<%=HDConstant.MxTab_CLSID%> width="1000" height="20" style="position:relative; left:10px; top:5;" border=0> 
		<param name="BackColor"						value="#FEFEC0">
		<param name="DisableBackColor"				value="#BDBDBD">
		<param name="Format"						value='
						<T>divid="mxTab_Tree"	title="  T r e e  "</T>
						<T>divid="mxTab_Grid"	title="���࿹��"</T>
						<T>divid="mxTab_Grid2"	title="������/��������"</T>
						<T>divid="mxTab_Grid3"	title="  ��    ü  "</T>						
		'>
</object>




<br><br>

<!-- input ��  ���� --> 
	<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
		
			<td align="center" class="text" width="80">Project</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_project'   id='v_project'  style="width:70px;"   class='input01' readOnly="readonly">
			    <input type="text"  name='v_project_nm'   id='v_project_nm'  style="width:150px;"   class='input01' readOnly="readonly">			    
			</td>		
			<td align="center" class="text" width="80">��������</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_no_budget'   id='v_no_budget'  style="width:50px;" class='input01'  readOnly="readonly">
			</td>		
		
			<td align="center" class="text" width="80">���ޱݾ�</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_order_amt'   id='v_order_amt'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>	
			
			<td align="center" class="text" width="80">���࿹��</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_act_amt'   id='v_act_amt'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>	
			
			<td align="center" class="text" width="80">�����</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_pro'   id='v_pro'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>							
		</tr>
	</table>
<!-- input ��  �� --> 

<!-- ���� ��ȸ Tree ���̺� ����-->
<div id="mxTab_Tree" style="position:relative; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>
				<!-- ���� ȭ�� ����-->
				<table width="250" border="0" cellspacing="0" cellpadding="0">
					<tr align="center"  valign="top">
						<td  class="l">
							<!-- ���� ��ȸ Tree ����-->
							<table width="250" height = "600" border="0" cellspacing="0" cellpadding="0">
							    <tr>
									<td>
							            <table border="0" cellspacing="0" cellpadding="0">
							                <tr align="center">
							                    <td>
							                        <object id="tb_TreeView" classid=<%=HDConstant.MxTree_CLSID_S%> style="width:250px;height:600px;">
							                            <param name="DataID"					value="ds_item_m">
														<param name=TextColumn					value="DS_KSITEM">
														<param name=LevelColumn					value="TREE_LEVEL">
														<param name=ExpandLevel					value="0">
														<param name=BorderStyle  				value="2">
														<param name=Index            			value="3">														
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- ���� ��ȸ Tree ��-->
	
						</td>
					</tr>
				</table>
				<!-- ���� ȭ�� ��-->
			</td>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- ������ ȭ�� ����-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- ���� ��ȸ �׸��� ���̺� ����-->
							<table width="740" height = "620" border="0" cellspacing="0" cellpadding="0">
							    <tr>
									<td class="paddingTop8">
							            <table border="0" cellspacing="0" cellpadding="0">
							                <tr align="left">
							                    <td> 
							                        <object id="grd_ITEM_D" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:740px;height:620px;">
							                            <param name="DataID"						value="ds_item_d">
							                            <param name="EdiTABLE"						value="true">
							                            <param name="DragDropEnable"				value="true">
							                            <param name="SortView"						value="Left">
							                            <param name="VIEWSUMMARY"					value=0>
							                            <param name="Format"						value="
							                                <C> id='COST_CD'				name='CODE'			width=80			show=false</C>							                            
							                                <C> id='DS_KSITEM'				name='Content'		width=180			align=left</C>									                                
							                                <C> id='CD_COST'				name='CODE'			width=80			align=left</C>
							                                <C> id='NO_BUDGET'				name='����' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	EditStyle=Combo	Data='Y:Y,N:N'</C> 									                                
							                               <G> name='����' 
							                                <C> id='ORDER_AMT_OLD'			name='����'			width=70			align=right decao = 0 edit=none</C> 
							                                <C> id='ORDER_AMT_NOW'			name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='����'			width=70			align=right decao = 0 edit=none</C>
							                               </G>							                               
							                               <G> name='����' 							                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 edit=none</C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 edit=none</C> 
							                               </G>	
							                                <C> id='ITEM_CD'				name='ǰ��\\�ڵ�'	width=100			align=center edit=none</C> 				                                
							                                <C> id='ITEM_NM'				name='ǰ��\\�ڵ�'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- ���� ��ȸ �׸��� ���̺� ��-->
	
						</td>
					</tr>
				</table>
				<!-- ������ ȭ�� ��-->
			</td>
		</tr>
	</table>

</form>
<!-- form �� -->

</div>



<!-- ���� ��ȸ Grid ���̺� ����-->
<div id="mxTab_Grid" style="position:absolute; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >
<br>

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- ������ ȭ�� ����-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- ���� ��ȸ �׸��� ���̺� ����-->
							<table width="1000" height = "620" border="0" cellspacing="0" cellpadding="0">
							    <tr>
									<td class="paddingTop8">
							            <table border="0" cellspacing="0" cellpadding="0">
							                <tr align="left">
							                    <td> 
							                        <object id="grd_ITEM_D_grid" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:1000px;height:620px;">
							                            <param name="DataID"						value="ds_item_d_grid">
							                            <param name="EdiTABLE"						value="true">
							                            <param name="DragDropEnable"				value="true">
							                            <param name="SortView"						value="Left">
							                            <param name="VIEWSUMMARY"					value=0>
							                            <param name="Format"						value="
							                                <C> id='DS_KSITEM'				name='Content'		width=380			align=left</C>									                                
							                                <C> id='CD_COST'				name='CODE'			width=120			align=left</C>
							                                <C> id='NO_BUDGET'				name='����' 		align=center	 	show=false</C> 
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 	
							                               <G> name='����' 
							                                <C> id='ORDER_AMT_OLD'			name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='ORDER_AMT_NOW'			name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='����'			width=70			align=right decao = 0 </C>
							                               </G>							                               
							                               <G> name='����' 							                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 </C> 
							                               </G>	
							                                <C> id='ITEM_CD'				name='ǰ��\\�ڵ�'	width=100			align=center </C> 					                                
							                                <C> id='ITEM_NM'				name='ǰ��\\�ڵ�'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- ���� ��ȸ �׸��� ���̺� ��-->
	
						</td>
					</tr>
				</table>
				<!-- ������ ȭ�� ��-->
			</td>
		</tr>
	</table>

</form>
<!-- form �� -->

</div>



<!-- ���� ��ȸ Grid2 ���̺� ����-->
<div id="mxTab_Grid2" style="position:absolute; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >
<br>

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- ������ ȭ�� ����-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- ���� ��ȸ �׸��� ���̺� ����-->
							<table width="1000" height = "620" border="0" cellspacing="0" cellpadding="0">
							    <tr>
									<td class="paddingTop8">
							            <table border="0" cellspacing="0" cellpadding="0">
							                <tr align="left">
							                    <td> 
							                        <object id="grd_ITEM_D_grid2" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:1000px;height:620px;">
							                            <param name="DataID"						value="ds_item_d_grid2">
							                            <param name="EdiTABLE"						value="true">
							                            <param name="DragDropEnable"				value="true">
							                            <param name="SortView"						value="Left">
							                            <param name="VIEWSUMMARY"					value=0>
							                            <param name="Format"						value="
							                                <C> id='DS_KSITEM'				name='Content'		width=380			align=left</C>									                                
							                                <C> id='CD_COST'				name='CODE'			width=120			align=left</C>
							                                <C> id='NO_BUDGET'				name='����' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 								                                
							                               <G> name='����' 
							                                <C> id='ORDER_AMT_OLD'			name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='ORDER_AMT_NOW'			name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='����'			width=70			align=right decao = 0 </C>
							                               </G>		
							                               
							                               <G> name='������' 							                                
							                                <C> id='PRO_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='PRO_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='PRO_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               
							                               <G> name='��������' 			             							                                
							                                <C> id='BID_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='BID_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='BID_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               			                               
							                               <G> name='���࿹��' 							                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 show=false</C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 show=false</C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 show=false</C> 
							                               </G>	
							                                <C> id='ITEM_CD'				name='ǰ��\\�ڵ�'	width=100			align=center </C> 					                                
							                                <C> id='ITEM_NM'				name='ǰ��\\�ڵ�'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- ���� ��ȸ �׸��� ���̺� ��-->
	
						</td>
					</tr>
				</table>
				<!-- ������ ȭ�� ��-->
			</td>
		</tr>
	</table>

</form>
<!-- form �� -->

</div>


<!-- ���� ��ȸ Grid3 ���̺� ����-->
<div id="mxTab_Grid3" style="position:absolute; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >
<br>

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- ������ ȭ�� ����-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- ���� ��ȸ �׸��� ���̺� ����-->
							<table width="1000" height = "620" border="0" cellspacing="0" cellpadding="0">
							    <tr>
									<td class="paddingTop8">
							            <table border="0" cellspacing="0" cellpadding="0">
							                <tr align="left">
							                    <td> 
							                        <object id="grd_ITEM_D_grid3" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:1000px;height:620px;">
							                            <param name="DataID"						value="ds_item_d_grid3">
							                            <param name="EdiTABLE"						value="true">
							                            <param name="DragDropEnable"				value="true">
							                            <param name="SortView"						value="Left">
							                            <param name="VIEWSUMMARY"					value=0>
							                            <param name="Format"						value="
							                                <C> id='DS_KSITEM'				name='Content'		width=380			align=left</C>									                                
							                                <C> id='CD_COST'				name='CODE'			width=120			align=left</C>
							                                <C> id='NO_BUDGET'				name='����' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 	
							                               <G> name='����' 
							                                <C> id='ORDER_AMT_OLD'			name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='ORDER_AMT_NOW'			name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='����'			width=70			align=right decao = 0 </C>
							                               </G>	
							                               <G> name='������' 							                                
							                                <C> id='PRO_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='PRO_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='PRO_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               
							                               <G> name='��������' 			             							                                
							                                <C> id='BID_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='BID_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='BID_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               			                               
							                               <G> name='���࿹��' 							                                						                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='����'			width=70			align=right decao = 0 </C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='����'			width=70			align=right decao = 0 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='����'			width=70			align=right decao = 0 </C> 
							                               </G>
							                                <C> id='ITEM_CD'				name='ǰ��\\�ڵ�'	width=100			align=center </C> 						                                
							                                <C> id='ITEM_NM'				name='ǰ��\\�ڵ�'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- ���� ��ȸ �׸��� ���̺� ��-->
	
						</td>
					</tr>
				</table>
				<!-- ������ ȭ�� ��-->
			</td>
		</tr>
	</table>

</form>
<!-- form �� -->

</div>



</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

