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
    var seq = 0;
	
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("grd_ITEM"), "comn");	//list detail

		fnInit();
		
	}
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
        var strParam = new Array();	//팝업시 받아오는 파라미터들
        
    	strParam=window.dialogArguments;

		document.getElementById("v_project").value    = strParam[0];				
		document.getElementById("v_project_nm").value = strParam[1];				 
		document.getElementById("v_ds_budget").value  = strParam[2];				

        fnSelect();
        
    }
    

    
    <%//메인 조회 %>
    function fnSelect() {

    	v_job="S";

    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								            + ",v_project="   + document.getElementById("v_project").value
								            + ",v_ds_budget=" + document.getElementById("v_ds_budget").value
    										;
   		
	   	ln_TRSetting(tr1, 
	            	"<%=dirPath%><%=HDConstant.PATH_BUD%>Bud050",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);

        tr_post(tr1);        
        
    }    
    


	<% //저장  %>
	function fnApply(){
		
		v_job = "A";

		if (ds_default.IsUpdated) {

			  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud050",
				                "JSP(I:DS_DEFAULT=ds_default)",
				                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                );
			  
			  //prompt(this, ds_default.text);
			  
			  tr_post(tr1);

			  
        }else{
        	
     		alert("생성된 Data가 없습니다.");
		
        }
		
		
	 }




	<% //행추가 %>
      function fnAdd() {
    	  
          ds_default.AddRow(); 

          
          var temp = ds_default.namevalue(ds_default.CountRow-1,"CD_COST").substr(10,2);
          
          //생각하기가 너무 싫다.
	      if(temp == "") {
          		temp = "01";
	      }else if(temp == "01"){
	    		temp = "02";
	      }else if(temp == "02"){
		    	temp = "03";	    	
	      }else if(temp == "03"){
		    	temp = "04";	    	
	      }else if(temp == "04"){
		    	temp = "05";	      
	      }else if(temp == "05"){
		    	temp = "06";	      
	      }else if(temp == "06"){
		    	temp = "07";	      
	      }else if(temp == "07"){
		    	temp = "08";	      
	      }else if(temp == "08"){
		    	temp = "09";	      
	      }else if(temp == "09"){
		    	temp = "10";	   
	      }else if(temp == "10"){
	    		temp = "11";
	      }else if(temp == "11"){
	    		temp = "12";	    		
	      }else if(temp == "12"){
		    	temp = "13";	    	
	      }else if(temp == "13"){
		    	temp = "14";	    	
	      }else if(temp == "14"){
		    	temp = "15";	      
	      }else if(temp == "15"){
		    	temp = "16";	      
	      }else if(temp == "16"){
		    	temp = "17";	      
	      }else if(temp == "17"){
		    	temp = "18";	      
	      }else if(temp == "18"){
		    	temp = "19";	      
	      }else if(temp == "19"){
		    	temp = "20";	 	
	      }else if(temp == "20"){
	    		temp = "21";
	      }else if(temp == "21"){
	    		temp = "22";	    		
	      }else if(temp == "22"){
		    	temp = "23";	    	
	      }else if(temp == "23"){
		    	temp = "24";	    	
	      }else if(temp == "24"){
		    	temp = "25";	      
	      }else if(temp == "25"){
		    	temp = "26";	      
	      }else if(temp == "26"){
		    	temp = "27";	      
	      }else if(temp == "27"){
		    	temp = "28";	      
	      }else if(temp == "28"){
		    	temp = "29";	      
	      }else if(temp == "29"){
		    	temp = "30";			    	
	      }else{
	    	  alert("코드등록을 30개로 제한했습니다.\n\n관리자에게 문의하시기 바랍니다.");
	    	  return;
	      }

            
          ds_default.namevalue(ds_default.rowposition,"COST_CD")   = document.getElementById("v_project").value;
          ds_default.namevalue(ds_default.rowposition,"NO_BUDGET") = document.getElementById("v_ds_budget").value;

          ds_default.namevalue(ds_default.rowposition,"CD_COST")   = document.getElementById("v_project").value + document.getElementById("v_ds_budget").value + temp;          
          
          seq = seq + 1;
          
      }

	      
  	<% //행삭제 %>
    function fnDelete() {
  	  
		ds_default.DeleteRow(ds_default.RowPosition);
		
		alert("행삭제 되었습니다\n\n저장까지 하셔야 실제로 반영됩니다.");

    }  

    
	    
</script>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : ds_default                          |
    +----------------------------------------------->

	<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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




 <!-----------------------------+
 | Transaction Successful 처리      |
 +------------------------------>
 <script for=tr1 event="OnSuccess()">
 
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
		fnSelect(); // 디테일들 조회하기
	}

    
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
        	<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">&nbsp;
        	<img src="<%=dirPath%>/Sales/images/plus.gif"					style="cursor:pointer" onclick="fnAdd()">&nbsp;
        	<img src="<%=dirPath%>/Sales/images/minus.gif"					style="cursor:pointer" onclick="fnDelete()">&nbsp;      	
        	<img src="<%=dirPath%>/Sales/images/save.gif"					style="cursor:pointer" onclick="fnApply()">	       	
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->
	


<!-- input 쪽  시작 --> 
<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
	<tr>
		<td align="center" class="text" width="80">Project</td>
		<td bgcolor='#ffffff' >&nbsp;
		    <input type="text"  name='v_project'   		id='v_project'  	style="width:50px;"   	class='input01' readOnly="readonly">
		    <input type="text"  name='v_project_nm'   	id='v_project_nm'  	style="width:300px;"   	class='input01' readOnly="readonly">	
		    <input type="text"  name='v_ds_budget'   	id='v_ds_budget'  	style="width:50px;"   	class='input01' readOnly="readonly">		    
		</td>				
	</tr>
</table>
<!-- input 쪽  끝 --> 

<br>
	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>
				<!-- 내용 조회 그리드 테이블 시작-->
				<table width="1000" height = "520" border="0" cellspacing="0" cellpadding="0">
				    <tr>
						<td class="paddingTop8">
	                        <object id="grd_ITEM" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:1000px;height:520px;">
	                            <param name="DataID"						value="ds_default">
	                            <param name="EdiTABLE"						value="true">
	                            <param name="DragDropEnable"				value="true">
	                            <param name="SortView"						value="Left">
								<param name="ViewSummary"       			value="1">
								<param name="ColSizing"        				value="true">
								<param name=ColSelect    					value="True">								                            
	                            <param name="Format"						value="
                					<C> ID='{CurRow}'				name='NO' 			width=50 			align=CENTER</C>
	                                <C> id='COST_CD'				name='COST_CD'		width=50			show=false</C>						                            
	                                <C> id='NO_BUDGET'				name='NO_BUDGET'	width=50			show=false</C>                  					
	                                <C> id='CD_COST'				name='CODE'			width=150			align=left</C>						                            
	                                <C> id='DS_KSITEM'				name='Content'		width=550			align=left SumText='총' </C>     
	                                <C> id='EXE_ACT_AMT'			name='실행금액'		width=200			align=right decao = 0 sumtext=@sum</C>
	                            ">
	                        </object>
				        </td>
				    </tr>
				</table>
				<!-- 내용 조회 그리드 데이블 끝-->
			</td>
		</tr>
	</table>

</form>
<!-- form 끝 -->



</form>
<!-- form 끝 -->


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

