<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%
    // ContextPath
    String dirPath = request.getContextPath();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <title>PROJECT SAVE</title>
    
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>

<script language="javascript">
		
		
			var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

            function fnOnLoad() {

                fnInit();
                
            }
            

			
        	function fnInit(){
        		
        		v_job ="I";
        		
        		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>" ;
        		
        		//초기 코드 번호 생성 
        		ln_TRSetting(tr1, 
        	        	"<%=dirPath%><%=HDConstant.PATH_PRO%>Pr011",
        	            "JSP(O:DS_DEFAULT=ds_default)",
        	            param);
        		
        	    tr_post(tr1);
        	        
        	        
        	    document.getElementById("request_cd").value=ds_default.NameValue(1,"REQUEST_CD");
        	   
        	   
        	}
        	
        	
            function fnSelect() {
            	
            	//초기 화면 로드시에 데이터 먼저 조회
            	
                v_job="S";
            	

            }

            
            
            
            
            
      		function popup(e){

	      		if(e == 'pm'){

	      		 	var arrParam	= new Array();
	      	    	var arrResult	= new Array();
	      	    	var strURL;	
	      	    	var strPos;
	      			var ifVal = e;
	      			
	      	    	strURL = "<%=dirPath%>/Pms/new/pro/empno_popup.jsp";
	      	    	
	      	    	strPos = "dialogWidth:377px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	      	    	
	      	    	arrResult = showModalDialog(strURL,'',strPos);
	      	    	
	      	    	if (arrResult != null) {
	      	    		
	      	    		arrParam = arrResult.split(";");	      	    		

	      	    		eno_no.value = arrParam[0];
	      	    		eno_nm.value = arrParam[1];
	      	    		dept_cd.value = arrParam[2];
	      	    		
	      	        } else {
	      	        	
	      				fnEmpNoCleanup(ifVal);
	      				
	      	        }         	    	
	      	    	
	      		}
      	    	
      		}
      		
      		
      		
      		
      		function fnEmpNoCleanup(e){

      			
      			if(e == "pm"){
      				
      				//넘겨져서 돌아오는 값이 없으면 그대로 놔둔다. 
     				document.getElementById("suPm").value="";	 
      				
      			}
      			
      		}
      		
      		
      		
      		
      		<%//저장 작업 %>
      		function fnSave(){

      			v_job="A";

	        	ds_default.namevalue(ds_default.RowPosition, "REQUEST_CD") 		= document.getElementById("request_cd").value;
	        	ds_default.namevalue(ds_default.RowPosition, "REQUEST_NM") 		= document.getElementById("request_nm").value;
	        	ds_default.namevalue(ds_default.RowPosition, "PROP1") 			= document.getElementById("bigStatus").value;
	        	ds_default.namevalue(ds_default.RowPosition, "PROP2") 			= document.getElementById("midStatus").value;
	        	ds_default.namevalue(ds_default.RowPosition, "COMPANY_NM") 		= document.getElementById("balJu").value;
	        	ds_default.namevalue(ds_default.RowPosition, "DEPT_CD") 		= document.getElementById("dept_cd").value;  //담당팀
	        	ds_default.namevalue(ds_default.RowPosition, "PM") 				= document.getElementById("eno_no").value;   //사원 번호로 변경 



      			//입력값 체크
      			if(document.getElementById("bigStatus").value == "00"){
      				alert("대분류가 선택되지 않았습니다.");
      				return false;
      			}else if(document.getElementById("midStatus").value == "0000"){
      				alert("중분류가 선택되지 않았습니다.");
      	      		return false;
      	      	}
    	  		 

      			//저장버튼   
    	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr011",
		                "JSP(I:DS_DEFAULT=ds_default)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);      			
      			
      			
				ds_default.UserStatus(1) = 1;	
				
      			//prompt(this, ds_default.text);
      			
    	        tr_post(tr1);
    	        
    	        
    	        
      		}
      	
      		
      		
      	  //도급액 컴마 작업 	
      	  function inputNumberFormat(obj) { 
      		
      	      obj.value = comma(uncomma(obj.value)); 
      	  
      	  } 
		
      	
      	  
      	  function comma(str) { 
      		  
      	      str = String(str); 
      	      
      	      return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
      	      
      	  } 
      	  
      	  
      	  
      	  //콤마제거
      	  function uncomma(str) { 
      		  
      	      str = String(str); 
      	      
      	      return str.replace(/[^\d]+/g, ''); 
      	      
      	  }


            function fnClose() {
            	
                window.close();
                
            }
            

 </script>
 
 
 
<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		
		alert("성공적으로 저장되었습니다.");

		fnClose();
		
	}
	

</script>



<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">


	if(v_job=="A"){
		
		alert("성공적으로 처리되었습니다.");
		
		window.close();
	}
	
	
</script>


<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>



</head> 


        
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
<div>
<br>
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:10px;top:7px;">
		
			  <tr>
				<td height="25px" width="100px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp; 신청code</td>			  

				<td width="300px" style="border:1 solid #708090;border-left-width:0px">&nbsp;
					<input id="request_cd"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;text-align: center" readonly="readonly" >
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp; 신청명</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="request_nm"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;">
				</td>
			  </tr>
			  

			   <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대분류</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					 <select id=bigStatus style="WIDTH:100" >
                        <option value="00">선택</option> 
                        <option value="01">관광</option>                                  
                        <option value="03">건설</option>
                        <option value="04">경협</option>
                        <option value="05">개성</option>
                    </select>
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;중분류</td>
		  		<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					 <select id=midStatus style="WIDTH:100" >
                        <option value="0000">중분류 선택</option>
                        <option value="0501">MICE</option>
                        <option value="0502">통일교육</option>
                        <option value="0503">크루즈</option>
                        <option value="0504">국내관광</option>
                        <option value="0505">해외관광</option>
                        <option value="0506">항공발권</option>
                        <option value="0507">대북행사</option>
                        <option value="0508">개성연락사무소</option>
                        <option value="0509">ODA</option>
                        <option value="0510">PMC</option>
                        <option value="0511">면세사업</option>
                    </select>
				</td>
			  </tr>				  

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;발주처</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="balJu"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;">&nbsp;&nbsp;	
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수행PM</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="dept_cd"   type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">					
					<input id="eno_no"    type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">				
					<input id="eno_nm"    type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">&nbsp;
					<button onclick ="popup('pm')"> 직원검색 Click! </button>		
				</td>
			  </tr>
			</table>
			
<br>
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px" align="center">
			
                        <tr>
                            <td align="right">
                                <img name="btn_save" border="0" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnSave()"> &nbsp;                         
                            </td>
                            
                            <td align="left">
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
                            </td>
                        </tr>
            </table>
            
</div>


</body>
<!-- BODY END -->

</html>







