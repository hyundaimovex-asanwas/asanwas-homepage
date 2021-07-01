<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
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
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >


	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var menuWin;	//새창 띄우기용.

	var Tabvalue = 1;
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("grd_ITEM_D"), "comn");	//list detail

		cfStyleGrid(getObjectFirst("grd_ITEM_D_grid"), "comn");		//list detail
		cfStyleGrid(getObjectFirst("grd_ITEM_D_grid2"), "comn");	//list detail
		cfStyleGrid(getObjectFirst("grd_ITEM_D_grid3"), "comn");	//list detail
		
		fnInit();
		
	}
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
        var strParam = new Array();	//팝업시 받아오는 파라미터들
        
    	strParam=window.dialogArguments;

		document.getElementById("v_project").value = strParam[0];				//Project Code 
		document.getElementById("v_no_budget").value = strParam[1];				//실행차수   
        
        var cost_cd = strParam[0];   //주석 풀어줘야됨
        
        var no_budget = strParam[1];
        
    	var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
								    		+ ",V_COST_CD=" + cost_cd 
								    		+ ",V_NO_BUDGET=" + no_budget
								    		;
        
    	
		//데이터셋 헤더 초기화 = 빈 조회
		
        ln_TRSetting(tr1, 
		        	"<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
		            "JSP(O:DS_ITEM_M=ds_item_m,O:DS_PROJECT=ds_project)",
		            param);

		
        tr_post(tr1);

        

		
		
        
    }
	
    
    <%//메인 조회 %>
    function fnSelect() {

    	v_job="S";

    	/* protype = select , v_site_sid ,  */
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_code=" + txtCOMM_CD_SHR.value				//검색조건
							;

        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd010",
	            "JSP(O:DS_ITEM_M=ds_item_m)", //화면 출력
	            v_param);

        
        tr_post(tr1);

    }    
    





	<%//저장=승인요청 %>
	function fnApply(){
		
		v_job = "A";
		
		if (ds_item_d.NameValue(ds_item_d.rowposition,"COST_YN") == 'Y') {

			if (ds_item_d.NameValue(ds_item_d.rowposition,"ITEM_CD") == '') {
				
				alert("품목코드는 무조건 채우시기 바랍니다.");
				
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
        	
     		alert("생성된 Data가 없습니다.");
		
        }
		
		
	 }




		<%//신규 생성 %>
	      function fnAddNew() {
	    	  
	          // AddNew 후 입력 테이블로 포커스
	          ds_item_d.AddRow(); 
	          
	          ds_item_d.namevalue(ds_item_d.RowPosition, "COST_CD")= document.getElementById("v_project").value;
	          ds_item_d.namevalue(ds_item_d.RowPosition, "NO_BUDGET")= document.getElementById("v_no_budget").value;	           
	          ds_item_d.NameValue(ds_item_d.RowPosition,"DT_APPLY") = "<%=DateUtil.getCurrentDate(8)%>";

	      }

	      
	      
	  	<%//액셀 다운하기%>
	    function fnExcel() {

	        if(Tabvalue  == 1){

	        	alert("Tree외 다른 Tab을 선택하시기 바랍니다.");
		        //getObjectFirst("grd_ITEM_D").SetExcelTitle(0, "");
		        //getObjectFirst("grd_ITEM_D").SetExcelTitle(1, "value:실행예산; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        //getObjectFirst("grd_ITEM_D").GridToExcel("실행예산현황", "실행예산현황.xls", 8);  
	        	
	        }else if(Tabvalue  == 2){
	        	
		        getObjectFirst("grd_ITEM_D_grid").SetExcelTitle(0, "");
		        
		        getObjectFirst("grd_ITEM_D_grid").SetExcelTitle(1, "value:실행예산; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        
		        getObjectFirst("grd_ITEM_D_grid").GridToExcel("실행예산현황", "실행예산현황.xls", 8);        

	        }else if(Tabvalue  == 3){
	        	
		        getObjectFirst("grd_ITEM_D_grid2").SetExcelTitle(0, "");
		        
		        getObjectFirst("grd_ITEM_D_grid2").SetExcelTitle(1, "value:가예산입찰예산; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        
		        getObjectFirst("grd_ITEM_D_grid2").GridToExcel("가예산입찰예산현황", "가예산입찰예산현황.xls", 8);        

	        }else if(Tabvalue  == 4){	       
	        	
		        getObjectFirst("grd_ITEM_D_grid3").SetExcelTitle(0, "");
		        
		        getObjectFirst("grd_ITEM_D_grid3").SetExcelTitle(1, "value:전체예산; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        
		        getObjectFirst("grd_ITEM_D_grid3").GridToExcel("전체예산현황", "전체예산현황.xls", 8);        

	        }


	    	
	    }	      
	      
	    
	  	<%//Print하기%>
	    function fnPrint() {

	         alert("개발중입니다.");

	    }	 	    
	    
	    
</script>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                            |
    | 2. 이름 : ds_item_m,    ds_item_d            |
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
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : tr1                  				|
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
*  Component에서 발생하는 Event 처리부  *
*                                       *
**************************************-->

<!-------------------------------------------------+
| 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
+-------------------------------------------------->

<%//마스터 그리드 OnClick %>

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
							+ ",v_project="    + v_project.value					//project 코드
							+ ",v_no_budget="  + v_no_budget.value					//실행 차수		      
							+ ",v_overValue1=" + overValue1							//코드명
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
										+ ",v_project="    + v_project_s							//project 코드
										+ ",v_no_budget="  + v_no_budget_s							//실행 차수		      
										+ ",v_overValue1=P" //+ overValue1							//코드명
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

		//tree 조회
		if(index == '1'){
			
				document.getElementById("mxTab_Tree").style.display = "";
				document.getElementById("mxTab_Grid").style.display = "none";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";
				Tabvalue = 1;

		//실행예산 조회
        }else if(index == '2'){
				
				document.getElementById("mxTab_Tree").style.display = "none";	        	
				document.getElementById("mxTab_Grid").style.display = "";
				document.getElementById("mxTab_Grid2").style.display = "none";
				document.getElementById("mxTab_Grid3").style.display = "none";
				
				
			  	v_job="S";

			  	var v_project_s =  document.getElementById("v_project").value;		  	
			  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											+ ",v_project="    + v_project_s							//project 코드
											+ ",v_no_budget="  + v_no_budget_s							//실행 차수		      
											+ ",v_overValue1=P" 
											+ ",v_overValue2=1" 					
											;
			    
			    ln_TRSetting(tr1, 
				          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
				          "JSP(O:DS_ITEM_D_GRID=ds_item_d_grid)", 						
				          v_param);

			    tr_post(tr1);	
				Tabvalue = 2;

				
		//가예산/입찰예산 조회				
        }else if(index == '3'){
			
			document.getElementById("mxTab_Tree").style.display = "none";	        	
			document.getElementById("mxTab_Grid").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "";
			document.getElementById("mxTab_Grid3").style.display = "none";
			
			
		  	v_job="S";

		  	var v_project_s =  document.getElementById("v_project").value;		  	
		  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project_s							//project 코드
										+ ",v_no_budget="  + v_no_budget_s							//실행 차수		      
										+ ",v_overValue1=P" 
										+ ",v_overValue2=1" 					
										;
		    
		    ln_TRSetting(tr1, 
			          "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd021",
			          "JSP(O:DS_ITEM_D_GRID2=ds_item_d_grid2)", 						
			          v_param);

		    tr_post(tr1);	
			Tabvalue = 3;

			
		//전체예산 조회			
        }else if(index == '4'){
			
			document.getElementById("mxTab_Tree").style.display = "none";	        	
			document.getElementById("mxTab_Grid").style.display = "none";
			document.getElementById("mxTab_Grid2").style.display = "none";
			document.getElementById("mxTab_Grid3").style.display = "";
			
			
		  	v_job="S";

		  	var v_project_s =  document.getElementById("v_project").value;		  	
		  	var v_no_budget_s =  document.getElementById("v_no_budget").value;

		    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
										+ ",v_project="    + v_project_s							//project 코드
										+ ",v_no_budget="  + v_no_budget_s							//실행 차수		      
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
 | Transaction Successful 처리      |
 +------------------------------>
 <script for=tr1 event="OnSuccess()">
 
	if(v_job=="A"){
		
		//alert("성공적으로 저장되었습니다.");
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



<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
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
<!-- 버튼 테이블 끝 -->
	
	
	

<!-- 탭 사용 컴퍼넌트 시작 -->
<object id=mxTab classid=<%=HDConstant.MxTab_CLSID%> width="1000" height="20" style="position:relative; left:10px; top:5;" border=0> 
		<param name="BackColor"						value="#FEFEC0">
		<param name="DisableBackColor"				value="#BDBDBD">
		<param name="Format"						value='
						<T>divid="mxTab_Tree"	title="  T r e e  "</T>
						<T>divid="mxTab_Grid"	title="실행예산"</T>
						<T>divid="mxTab_Grid2"	title="가예산/입찰예산"</T>
						<T>divid="mxTab_Grid3"	title="  전    체  "</T>						
		'>
</object>




<br><br>

<!-- input 쪽  시작 --> 
	<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
		
			<td align="center" class="text" width="80">Project</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_project'   id='v_project'  style="width:70px;"   class='input01' readOnly="readonly">
			    <input type="text"  name='v_project_nm'   id='v_project_nm'  style="width:150px;"   class='input01' readOnly="readonly">			    
			</td>		
			<td align="center" class="text" width="80">실행차수</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_no_budget'   id='v_no_budget'  style="width:50px;" class='input01'  readOnly="readonly">
			</td>		
		
			<td align="center" class="text" width="80">도급금액</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_order_amt'   id='v_order_amt'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>	
			
			<td align="center" class="text" width="80">실행예산</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_act_amt'   id='v_act_amt'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>	
			
			<td align="center" class="text" width="80">실행률</td>
			<td bgcolor='#ffffff' >&nbsp;
			    <input type="text"  name='v_pro'   id='v_pro'  style="width:70px;" class='input01'  readOnly="readonly">
			</td>							
		</tr>
	</table>
<!-- input 쪽  끝 --> 

<!-- 내용 조회 Tree 테이블 시작-->
<div id="mxTab_Tree" style="position:relative; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>
				<!-- 왼쪽 화면 시작-->
				<table width="250" border="0" cellspacing="0" cellpadding="0">
					<tr align="center"  valign="top">
						<td  class="l">
							<!-- 내용 조회 Tree 시작-->
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
							<!-- 내용 조회 Tree 끝-->
	
						</td>
					</tr>
				</table>
				<!-- 왼쪽 화면 끝-->
			</td>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- 오른쪽 화면 시작-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- 내용 조회 그리드 테이블 시작-->
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
							                                <C> id='NO_BUDGET'				name='차수' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	EditStyle=Combo	Data='Y:Y,N:N'</C> 									                                
							                               <G> name='도급' 
							                                <C> id='ORDER_AMT_OLD'			name='최초'			width=70			align=right decao = 0 edit=none</C> 
							                                <C> id='ORDER_AMT_NOW'			name='현재'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='증감'			width=70			align=right decao = 0 edit=none</C>
							                               </G>							                               
							                               <G> name='실행' 							                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 edit=none</C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 edit=none</C> 
							                               </G>	
							                                <C> id='ITEM_CD'				name='품목\\코드'	width=100			align=center edit=none</C> 				                                
							                                <C> id='ITEM_NM'				name='품목\\코드'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- 내용 조회 그리드 데이블 끝-->
	
						</td>
					</tr>
				</table>
				<!-- 오른쪽 화면 끝-->
			</td>
		</tr>
	</table>

</form>
<!-- form 끝 -->

</div>



<!-- 내용 조회 Grid 테이블 시작-->
<div id="mxTab_Grid" style="position:absolute; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >
<br>

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- 오른쪽 화면 시작-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- 내용 조회 그리드 테이블 시작-->
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
							                                <C> id='NO_BUDGET'				name='차수' 		align=center	 	show=false</C> 
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 	
							                               <G> name='도급' 
							                                <C> id='ORDER_AMT_OLD'			name='최초'			width=70			align=right decao = 0 </C> 
							                                <C> id='ORDER_AMT_NOW'			name='현재'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='증감'			width=70			align=right decao = 0 </C>
							                               </G>							                               
							                               <G> name='실행' 							                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 </C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 </C> 
							                               </G>	
							                                <C> id='ITEM_CD'				name='품목\\코드'	width=100			align=center </C> 					                                
							                                <C> id='ITEM_NM'				name='품목\\코드'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- 내용 조회 그리드 데이블 끝-->
	
						</td>
					</tr>
				</table>
				<!-- 오른쪽 화면 끝-->
			</td>
		</tr>
	</table>

</form>
<!-- form 끝 -->

</div>



<!-- 내용 조회 Grid2 테이블 시작-->
<div id="mxTab_Grid2" style="position:absolute; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >
<br>

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- 오른쪽 화면 시작-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- 내용 조회 그리드 테이블 시작-->
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
							                                <C> id='NO_BUDGET'				name='차수' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 								                                
							                               <G> name='도급' 
							                                <C> id='ORDER_AMT_OLD'			name='최초'			width=70			align=right decao = 0 </C> 
							                                <C> id='ORDER_AMT_NOW'			name='현재'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='증감'			width=70			align=right decao = 0 </C>
							                               </G>		
							                               
							                               <G> name='가예산' 							                                
							                                <C> id='PRO_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 </C>
							                                <C> id='PRO_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='PRO_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               
							                               <G> name='입찰예산' 			             							                                
							                                <C> id='BID_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 </C>
							                                <C> id='BID_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='BID_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               			                               
							                               <G> name='실행예산' 							                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 show=false</C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 show=false</C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 show=false</C> 
							                               </G>	
							                                <C> id='ITEM_CD'				name='품목\\코드'	width=100			align=center </C> 					                                
							                                <C> id='ITEM_NM'				name='품목\\코드'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- 내용 조회 그리드 데이블 끝-->
	
						</td>
					</tr>
				</table>
				<!-- 오른쪽 화면 끝-->
			</td>
		</tr>
	</table>

</form>
<!-- form 끝 -->

</div>


<!-- 내용 조회 Grid3 테이블 시작-->
<div id="mxTab_Grid3" style="position:absolute; left:10; top:1; width:1000; height:800; z-index:1;border:3;" >
<br>

	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td>
				<!-- 오른쪽 화면 시작-->
				<table width="740" border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<!-- 내용 조회 그리드 테이블 시작-->
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
							                                <C> id='NO_BUDGET'				name='차수' 		align=center	 	show=false</C> 	
							                                <C> id='COST_YN'				name='ITEM' 		width=40			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C> 	
							                               <G> name='도급' 
							                                <C> id='ORDER_AMT_OLD'			name='최초'			width=70			align=right decao = 0 </C> 
							                                <C> id='ORDER_AMT_NOW'			name='현재'			width=70			align=right decao = 0 </C>
							                                <C> id='ORDER_AMT_DIF'			name='증감'			width=70			align=right decao = 0 </C>
							                               </G>	
							                               <G> name='가예산' 							                                
							                                <C> id='PRO_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 </C>
							                                <C> id='PRO_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='PRO_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               
							                               <G> name='입찰예산' 			             							                                
							                                <C> id='BID_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 </C>
							                                <C> id='BID_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='BID_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 </C> 
							                               </G>		
							                               			                               
							                               <G> name='실행예산' 							                                						                                
							                                <C> id='EXE_ACT_AMT_OLD'		name='최초'			width=70			align=right decao = 0 </C>
							                                <C> id='EXE_ACT_AMT_NOW'		name='현재'			width=70			align=right decao = 0 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'		name='증감'			width=70			align=right decao = 0 </C> 
							                               </G>
							                                <C> id='ITEM_CD'				name='품목\\코드'	width=100			align=center </C> 						                                
							                                <C> id='ITEM_NM'				name='품목\\코드'	width=150			align=center EditStyle=Popup </C> 	
							                            ">
							                        </object>
							                    </td>
							                </tr>
							            </table>
							        </td>
							    </tr>
							</table>
							<!-- 내용 조회 그리드 데이블 끝-->
	
						</td>
					</tr>
				</table>
				<!-- 오른쪽 화면 끝-->
			</td>
		</tr>
	</table>

</form>
<!-- form 끝 -->

</div>



</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

