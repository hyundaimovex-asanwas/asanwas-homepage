<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Pms/common/include/head.jsp"/>
    <title>수주정보</title>
    
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>

<script language="javascript">

			var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

			var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
			var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";

    	
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

            	// 검색 값 관련 
            	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"  	
            										;

        		ln_TRSetting(tr1, 
        	        	"<%=dirPath%><%=HDConstant.PATH_BID%>Bid035",
        	            "JSP(O:DS_DEFAULT=ds_default)",
        	            param);

        		tr_post(tr1);                
                
               	    
            }
            


            <%//기본 저장  %>
      		function fnSave(){
      			
                v_job="A";
                
	      		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
	      		
	      		//저장
	   			ln_TRSetting(tr1, 
			   	        	"<%=dirPath%><%=HDConstant.PATH_BID%>Bid035",
			   	            "JSP(I:DS_DEFAULT=ds_default)",
			   	            param);

	   	        tr_post(tr1);
    	        
      		}

      		
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
	 
	if(v_job=="S"){
	    order_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    txt_empno.value = gusrid;
		txt_empnmk.value = gusrnm;	
	}	
		
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
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:120;height:15;left:5px;">수주 정보 관리</font>
                            </td>
                        </tr>
                     </table>
                </td>
            </tr>
        </table>
        
		<table border="0" cellpadding="0" cellspacing="0" >
			  <tr>
				<td height="25px" width="120px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;수주 CODE</td>			  

				<td width="350px" style="border:1 solid #708090;border-left-width:0px">&nbsp;
					<input id="order_cd"    type="text"   class="txtbox"  style= "position:relative;width:340px;height:20px;text-align:left;background-color:#d7d7d7" readonly="readonly" >
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;수주명</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="order_nm"    type="text"   class="txtbox"  style= "position:relative;width:340px;height:20px;">
				</td>
			  </tr>		  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;주요과제</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="content"    type="text"   class="txtbox"  style= "position:relative;width:340px;height:20px;">
				</td>
			  </tr>				  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;수행기간</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="period"    type="text"   class="txtbox"  style= "position:relative;width:340px;height:20px;">
				</td>
			  </tr>				  

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;발주처</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;		
					<input id="company_nm"    type="text"   class="txtbox"  style= "position:relative;width:340px;height:20px;">&nbsp;&nbsp;	
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;계약금액</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=contract_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='200px' align='absmiddle' class='textbox'>            
						<param name=Format      value="">
						<param name=Alignment   value=2>
						<param name=ClipMode    value=true>
						<param name=Border      value=false>
						<param name=MaxLength   value="13">
						<param name=SelectAll   value=true>
					</object>							
				</td>
			  </tr>
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;실행금액</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=execute_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='200px' align='absmiddle' class='textbox'>            
						<param name=Format      value="">
						<param name=Alignment   value=2>
						<param name=ClipMode    value=true>
						<param name=Border      value=false>
						<param name=MaxLength   value="13">
						<param name=SelectAll   value=true>
					</object>						
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;매출이익</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=sales_profit classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='200px' align='absmiddle' class='textbox'>            
						<param name=Format      value="">
						<param name=Alignment   value=2>
						<param name=ClipMode    value=true>
						<param name=Border      value=false>
						<param name=MaxLength   value="13">
						<param name=SelectAll   value=true>
					</object>		
				</td>
			  </tr>			  

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;이익률</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;      
					<input id="profit_rate"    type="text"   class="txtbox"  style= "position:relative;width:200px;height:20px;">		
				</td>
			  </tr>		

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기타</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="remark"    type="text"   class="txtbox"  style= "position:relative;width:340px;height:20px;">		
				</td>
			  </tr>	

				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수주일</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<object  id=order_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  		value="_">
							<param name=Enable				value="true">	
					</object>
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;등록자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">
					<input type="text" class="txt11" id="txt_empno"  style="width:60px;background-color:#d7d7d7" readOnly> &nbsp;
				    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="width:90px;" style="width:60px;background-color:#d7d7d7" readOnly> 
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
					<C>Col=ORDER_CD	 			Ctrl=order_cd       			Param=value </C>
					<C>Col=ORDER_NM     	 	Ctrl=order_nm     				Param=value </C>		
					<C>Col=COMPANY_NM	 		Ctrl=company_nm       			Param=value </C>	
					<C>Col=CONTENT	 			Ctrl=content       				Param=value </C>
					<C>Col=PERIOD	 			Ctrl=period       				Param=value </C>
					<C>Col=CONTRACT_AMT    	 	Ctrl=contract_amt     			Param=value </C>		
					<C>Col=EXECUTE_AMT   	 	Ctrl=execute_amt   				Param=value </C>
					<C>Col=SALES_PROFIT	 		Ctrl=sales_profit      			Param=value </C>	
					<C>Col=PROFIT_RATE    	 	Ctrl=profit_rate     			Param=value </C>		
					<C>Col=REMARK   	 		Ctrl=remark  					Param=value </C>
					<C>Col=ORDER_DT       	 	Ctrl=order_dt        			Param=Text  </C>
					<C>Col=I_EMPNO    	 		Ctrl=txt_empno     				Param=value </C>		
					<C>Col=NM_INSERT   	 		Ctrl=txt_empnmk					Param=value </C>
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 

</html>



