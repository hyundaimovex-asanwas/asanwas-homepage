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
    <title>입찰정보</title>
    
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>

<script language="javascript">

			var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

			//bid010.jsp 에서 넘겨준 값
	      	var strParam = new Array();
	      	
	    	strParam=window.dialogArguments;
	
	        var bid_cd = strParam[0];

        
        	<%//페이지 온로드 %>
            function fnOnLoad() {

            	fnSelect();

            }
            

            <%//초기작업 %>
        	function fnInit(){

        		v_job ="I";

        	}
        	
        	
        	
            <%//기본 조회  %>
            function fnSelect() {

                v_job="S";

                document.getElementById("bid_cd").value = bid_cd;
            	// 검색 값 관련 
            	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"  	
            										+ ",v_bid=" + bid_cd						//입찰code
            										;

        		ln_TRSetting(tr1, 
        	        	"<%=dirPath%><%=HDConstant.PATH_BID%>Bid011",
        	            "JSP(O:DS_DEFAULT=ds_default)",
        	            param);

        		tr_post(tr1);                
                
               	    
            }
            


        <%//저장  %>
   		function fnSave(){

            v_job="A";   			
   			
      		var bid_cd = document.getElementById("bid_cd").value;
      		var bid_nm = document.getElementById("bid_nm").value;
      		var bid_dt = document.getElementById("bid_dt").value;
      		var estimate_amt =	document.getElementById("estimate_amt").value;      		
      		var yn_result = document.getElementById("yn_result").value;


      		//화면 콤마 제거후 세이브 전송 
      		estimate_amt = uncomma(estimate_amt);
	      		
      		ds_default.NameValue(ds_default.rowposition,"estimate_amt") = estimate_amt;
      		
      		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				          		/*
								+ ",v_bid_cd="+bid_cd 
				      			+ ",v_bid_nm="+bid_nm
				      			+ ",v_bid_dt="+bid_dt  	
				      			+ ",v_bid_amt="+estimate_amt  
				      			+ ",v_result="+yn_result  
								*/
				      			;
      		
      		
      		//저장버튼 눌린  
      		
   			ln_TRSetting(tr1, 
	   	        	"<%=dirPath%><%=HDConstant.PATH_BID%>Bid011",
	   	            "JSP(I:DS_DEFAULT=ds_default)",
	   	            param);
     		
      		//prompt(this, ds_default.text);
      		
   	        tr_post(tr1);
    	        
   	        
      		}
      	
      		
      		
        <%// 추정액 컴마 작업  %>
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


          <%// 닫기 %>
           function fnClose() {
           	
               window.close();
               
           }
           
        </script>
        
        
        
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		
		alert("성공적으로 저장되었습니다.");
		
		fnClose();
		
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
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:120;height:15;left:5px;">입찰 정보 관리</font>
                            </td>
                        </tr>
                     </table>
                </td>
                <td>

                </td>
            </tr>
        </table>
        
        
        
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:10px">
			  <tr>
				<td height="25px" width="120px" style="border:1 solid #708090;border-width:1 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;입찰 CODE</td>			  

				<td width="350px" style="border:1 solid #708090;border-left-width:0px">&nbsp;
					<input id="bid_cd"    type="text"   class="txtbox"  style= "position:relative;width:150px;height:20px;text-align:left;background-color:#d7d7d7" readonly="readonly" >
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;입찰명</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="bid_nm"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;">
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;입찰일자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<object  id=bid_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  		value="_">
							<param name=Enable				value="true">
					</object>
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;발주처</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="order_cd"    type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;background-color:#d7d7d7;">&nbsp;				
					<input id="order_nm"    type="text"   class="txtbox"  style= "position:relative;width:200px;height:20px;;background-color:#d7d7d7;">&nbsp;&nbsp;	
				</td>
			  </tr>
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;추정액</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="estimate_amt"    type="number"   class="txtbox"  style= "position:relative;width:150px;height:20px;" onkeydown="inputNumberFormat(this)" >		
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;등록자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="I_EMPNO"    		type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;background-color:#d7d7d7;">&nbsp;				
					<input id="NM_INSERT"    	type="text"   class="txtbox"  style= "position:relative;width:200px;height:20px;background-color:#d7d7d7;">&nbsp;&nbsp;	
				</td>
			  </tr>			  
			  
			   <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;사업성검토</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="ds_type"    		type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;;background-color:#d7d7d7">&nbsp;
				</td>
			  </tr>			  
			  
			   <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;낙찰여부</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					 <select id=yn_result style="WIDTH:100" >
						<option value="S">진행중</option>
						<option value="N">탈락</option>								
						<option value="Y">낙찰</option>   
						<option value="D">포기</option>   						        
                    </select>
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;background-color:#CEFBC9" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비고</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="remark"    		type="text"   class="txtbox"  style= "position:relative;width:350px;height:20px;">&nbsp;				
				</td>
			  </tr>					  
			  
			</table>
			
			
			
			
			
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px" align="center">
			
                        <tr>
                            <td align="right">
                                <img name="btn_save border="0" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnSave()"> &nbsp;                         
                            </td>
                            
                            <td align="left">
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
                            </td>
                        </tr>
            </table>
            
            
</div>
</body>
<!-- BODY END -->


<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" 			value="ds_default">
	             <param name=BindInfo    		value="
					<C>Col=BID_NM	 			Ctrl=bid_nm       				Param=value </C>
					<C>Col=BID_DT       	 	Ctrl=bid_dt        				Param=Text  </C>
					<C>Col=ORDER_CD	 			Ctrl=order_cd       			Param=value </C>
					<C>Col=ORDER_NM     	 	Ctrl=order_nm        			Param=value </C>
					<C>Col=estimate_amt	 		Ctrl=estimate_amt       		Param=value </C>
					<C>Col=I_EMPNO	 			Ctrl=I_EMPNO       				Param=value </C>
					<C>Col=NM_INSERT     	 	Ctrl=NM_INSERT        			Param=value </C>
					<C>Col=DS_TYPE    	 		Ctrl=DS_TYPE      				Param=value </C>				
					<C>Col=YN_RESULT     	 	Ctrl=yn_result        			Param=value </C>
					<C>Col=remark    	 		Ctrl=remark        				Param=value </C>
						
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 

</html>



