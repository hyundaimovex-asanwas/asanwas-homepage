<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 	: 사원  Help 
 * 프로그램ID 	: SMS011
 * J  S  P		: SMS011
 * 서 블 릿		: SMS011
 * 작 성 자		: 이동훈
 * 작 성 일		: 2019-06-19
 * 기능정의		: 퇴사자 조회
 * 수정내용		: 
 * 수 정 자		: 
 * 최종수정일자 :  
 *****************************************************************************/
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>

<%	// ContextPath 변수 설정.
  	String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>인원정보&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>

		<script language="javascript">
		
		
			function fnOnLoad() {
				
				cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			}
			
			
			
			
			function fnSelect() {
				
	    	  	//퇴사자 조회
	            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	            								+ ",ENO_NM="  + ENO_NM.value;
	            
	        	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Sms010",  "JSP(O:gcds_old=gcds_old)",  param);

	    	    tr_post(tr1);	              
            

           }
           
			
			

           function fnAdd() {
        	   
				var row = gcds_old.rowposition;
			
				window.returnValue =
							gcds_old.namevalue(row, "DPT_NM")		+";"+ 
							gcds_old.namevalue(row, "JOB_NM")		+";"+ 
							gcds_old.namevalue(row, "ENO_NM")		+";"+ 
							gcds_old.namevalue(row, "EM_PHN_NO");
					
			 	fnClose();
			 	
			}

           
           
			function fnClose() {
				
				window.close();
				
			}
			
			
		</script>
		

		
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		
			fnAdd();
			
		</script>
		
		
		
		
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	
            	fnAdd();
            }
            
		</script>
		
		
		
<%=HDConstant.COMMENT_START%>		
<object  id=gcds_old classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<%=HDConstant.COMMENT_END%>




<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


	</head>	<!--  BODY START -->
	
	
	  <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	  
		<table border="0" cellpadding="0" cellspacing="0" width='400px' style="position:relative;top:1px;width:50;height:15;left:3;">
			<tr>
				<td align='center' width='400px' colspan='4'>
					<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:50;height:15;">인원정보</font>
							</td>
						</tr>
						
						<tr>
							<td width=400 colspan="4">
								<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
									<tr>
										<td align=right width="400px">
											<img src="<%=dirPath%>/Sales/images/p_find.gif" style="cursor:hand;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" 	style="cursor:hand;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" 	style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr height="5px">
							<td colspan='4'></td>
						</tr>						
						
						<tr>
							<td colspan='4' width='400'>
								<table width=400 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
            		                <tr height="20px">
                    		            <td align=left class="text" width="200px">성명</td>
			        						<td align=left bgcolor="#ffffff" >&nbsp;<input type="text" name="ENO_NM" size="15" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>
			      	         		</tr>
                        		</table>
							</td>
						</tr>
						
						
						<tr height="5px">
							<td colspan='4'></td>
						</tr>
						
						
						<tr>
							<td width='400px' align='center' colspan='4'>
								<table cellpadding="0" cellspacing="0" border="0" width='400px'>
									<tr>
										<td align='center'>
											<%=HDConstant.COMMENT_START%>
											<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=400px; height:200px;" border="1">
												<param name="DataID"			value="gcds_old">
												<param name="BorderStyle" 		value="0"> 
												<param name="AllShowEdit" 		value="false">
												<param name="ColSizing"     	value="true">
												<param name="Fillarea"			value="true">
												<param name="AutoResizing" 		value=true> 
												<param name="Editable"  		value="false">
												<param name="AddSelectRows" 	value=true>
												<param name="IndWidth"      	value="0">
												<param name="LineColor" 		value="#dddddd">
			                                    <param name=ViewSummary  		value="1">
												<param name="Format" 			value="
												    <C> name='성명'      		ID='ENO_NM'		align=center  	width=80 </C>
												    <C> name='부서'      		ID='DPT_NM'		align=left  	width=120 </C>									    
												    <C> name='직위'      		ID='JOB_NM'		align=left  	width=70 </C>									    
												    <C> name='번호'    			ID='EM_PHN_NO'	align=center	width=100 </C>
									                ">
											</object>
											<%=HDConstant.COMMENT_END%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
			
			
		</table>
	</body>	<!-- BODY END -->
</html>

