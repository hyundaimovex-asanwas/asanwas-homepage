<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재기안 :본실행 결재
 * 프로그램ID 	: pr420h
 * J  S  P	    : pr420h.jsp
 * 서 블 릿		: pr420h
 * 작 성 자		: 이동훈
 * 작 성 일		: 2016-04-01
 * [ 수정일자 ][수정자] 내용
 * [2016-04-01][이동훈]
 *****************************************************************************/
%>
<%@ page import="pms.common.*" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid =0;
	//int v_ap_m_sid = HDUtil.nullCheckNum(request.getParameter("ap_m_sid"));
	
	//쿠키불러오기 시작
		String v_login_name ="";
		String v_login_id = "";
		Cookie cookies[] = request.getCookies();
	     if(cookies != null) {
	          for(int i=0; i<cookies.length; i++){
	               if(cookies[i].getName().equals("vusrid") ) {
	                    v_login_id = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
	               }
	               if(cookies[i].getName().equals("vusrnm") ) {
	                    v_login_name = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
	               }
	          }
	     } 
		//쿠키불러오기 끝
		
		
		  //파일리스트 html 만들기
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//값을 불러와서 
		String sys_fileList ="";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>전자결재 - 예산결재</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">
	var  gusrid  		="<%=(String)session.getAttribute("vusrid")%>";
	var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
	
    var g_WinParam = window.dialogArguments;
     
    //alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[3]::"+g_WinParam[3]+"::g_WinParam[4]::"+g_WinParam[4]+"::g_WinParam[5]::"+g_WinParam[5]);
    
    var array1= new Array();
	var array2= new Array();
	var array3= new Array();
	var array4= new Array();
	var array5= new Array();
	
	var strAppline_gb=""; //결재선라인 조회 구분 
	
	if(g_WinParam[2]!=""){
		
		array1=g_WinParam[2].split(";");
		array2 = array1[0].split("/");  //담당
		array3 = array1[1].split("/");  //검토
		array4 = array1[2].split("/");  //확인
		array5 = array1[3].split("/");  //승인
		strAppline_gb="1"; //상신
		
	}else{
		strAppline_gb="2"; // 미결재함에서 처리 할 경우 
	}
		
		
	// 페이지 로딩
	  function fnOnLoad(){

		cfStyleGrid(getObjectFirst("gr_apline"), "comn");
		cfStyleGrid(getObjectFirst("gr_apline_rqst"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		
		fnSelect();
		    
	  }

		// 메인 조회
		function fnSelect() {
			
			//기본사항 조회 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
														                       	 + ",v_ap_m_sid="+g_WinParam[3]
																	             + ",v_cd_site="+g_WinParam[4]
	           																	 + ",v_no_silheng="+g_WinParam[5];       
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     
		     tr_post(tr1);
		     
			
			 // 기본정보
	         //var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			 //												              	 	+ ",v_ap_m_sid="+g_WinParam[3]
			 //														            + ",v_cd_site="+g_WinParam[4]
			 //														            + ",v_no_silheng="+g_WinParam[5];        
		     // ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     //tr_post(tr1);			
			
			// 정보
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
															              	 	+ ",v_ap_m_sid="+g_WinParam[3]
																	            + ",v_cd_site="+g_WinParam[4]
            																	+ ",v_no_silheng="+g_WinParam[5];          
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
		     tr_post(tr1);
		     
		     
			 // (현장)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 																+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT3=ds_default3)",  param);
		     tr_post(tr1);
		     
			 // (본사)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 																+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT4=ds_default4)",  param);
		     tr_post(tr1);
		     

		}
		
		
		// 승인  
		function fnApply_1(){
			
			if (confirm("승인하시겠습니까?")) {

				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
	 											+ ",v_ap_m_sid="+g_WinParam[3]
	 											+ ",vEmpNo="+gusrid
									            + ",vEmpNmk="+gusrnm;

			    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H","JSP(O:msgDS=msgDS)", param);
			    
		        tr_post(tr2); 

			}

		}		

		// 반송  
		function fnApply_2(){
			
			  strURL = "<%=dirPath%>/Pms/help/pr010h_desc.jsp?";
			  strPos = "dialogWidth:800px;dialogHeight:150px;status:yes;scroll:yes;resizable:yes";
		      result = showModalDialog(strURL,arrParam,strPos);			

		      if(result != null){
			  	arrResult = result.split(";");
	          }  

			var ap_desc = arrResult[1];
		      
			if (confirm("반송하시겠습니까?")) {

				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
																								+ ",v_ap_m_sid="+g_WinParam[3]
																								+ ",vEmpNo="+gusrid
																				            	+ ",vEmpNmk="+gusrnm
															    								+ ",vApDesc=" + ap_desc; 				
	
				ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H","JSP(O:msgDS=msgDS)", param);
				
				tr_post(tr3); 		
			
			}
			
		}


		// 출력  
		function fnPrint(){

			if (ds_default1.countrow<1) {
				alert("출력하실 정보가 없습니다");
			} else {


				if(txt_TY_SILHENG.value == "가실행" || txt_TY_SILHENG.value == "본실행" || txt_TY_SILHENG.value == "변경실행"){
				
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
																	                       	 	+ ",v_ap_m_sid="+g_WinParam[3]
																				             	+ ",v_cd_site="+g_WinParam[4]
											 													+ ",v_no_silheng="+g_WinParam[5];      			

					ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT6=ds_default6, O:DS_DEFAULT7=ds_default7)",  param);
					
					tr_post(tr1); 							
										
					ln_RptFormat();					
					
					ReportID.Preview();
					
					
				}else if (txt_TY_SILHENG.value == "설계변경" || txt_TY_SILHENG.value == "집행승인"){
					
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    	 	+ ",v_ap_m_sid="+g_WinParam[3]
			             	+ ",v_cd_site="+g_WinParam[4]
							+ ",v_no_silheng="+g_WinParam[5];      			

					ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr430H", "JSP(O:DS_DEFAULT6=ds_default6)",  param);
					
					tr_post(tr1); 							

					ReportID00.Preview();
					
				}

			}
			
		}		
		
		
		/******************************************************************************
		Description :  출력물 포멧 작성
		******************************************************************************/
		function ln_RptFormat(){
		
			ln_Rpt_SetDataHeader();//데이타 셋헤드 

	        ds_print.addrow();	

			//var ls_for = "";

			for(i=1;i<=ds_default7.countrow;i++){			
			
			  row = ds_print.rowposition;				
				
			  ds_print.namevalue(row,"AP_DPTNM"+i)=ds_default7.namevalue(i,"AP_DPTNM");  
			  ds_print.namevalue(row,"AP_JOBNM"+i)=ds_default7.namevalue(i,"AP_JOBNM");
			  ds_print.namevalue(row,"EMPNM"+i)=ds_default7.namevalue(i,"EMPNM");
			  ds_print.namevalue(row,"A_DATE"+i)=ds_default7.namevalue(i,"A_DATE");
			  ds_print.namevalue(row,"AP_DESC"+i)=ds_default7.namevalue(i,"AP_DESC");			  

			}
	
			//ReportID.format = ls_for + ReportID.format ;

}
		
		/******************************************************************************
		Description : 출력format
	******************************************************************************/
		function ln_Rpt_SetDataHeader(){ //출력물 데이타 셋헤드 생성
			
			var ls_temp = "";
		
			if (ds_print.countrow<1){
				
				ds_print.SetDataHeader(ls_temp);
				
				ls_temp1 = "AP_DPTNM1:STRING(50),AP_JOBNM1:STRING(15),EMPNM1:STRING(10),A_DATE1:STRING(20),AP_DESC1:STRING(100),"     
							+"AP_DPTNM2:STRING(50),AP_JOBNM2:STRING(15),EMPNM2:STRING(10),A_DATE2:STRING(20),AP_DESC2:STRING(100),"  					
							+"AP_DPTNM3:STRING(50),AP_JOBNM3:STRING(15),EMPNM3:STRING(10),A_DATE3:STRING(20),AP_DESC3:STRING(100),"  					
							+"AP_DPTNM4:STRING(50),AP_JOBNM4:STRING(15),EMPNM4:STRING(10),A_DATE4:STRING(20),AP_DESC4:STRING(100),"  
							+"AP_DPTNM5:STRING(50),AP_JOBNM5:STRING(15),EMPNM5:STRING(10),A_DATE5:STRING(20),AP_DESC5:STRING(100),"     
							+"AP_DPTNM6:STRING(50),AP_JOBNM6:STRING(15),EMPNM6:STRING(10),A_DATE6:STRING(20),AP_DESC6:STRING(100),"  					
							+"AP_DPTNM7:STRING(50),AP_JOBNM7:STRING(15),EMPNM7:STRING(10),A_DATE7:STRING(20),AP_DESC7:STRING(100),"  					
							+"AP_DPTNM8:STRING(50),AP_JOBNM8:STRING(15),EMPNM8:STRING(10),A_DATE8:STRING(20),AP_DESC8:STRING(100),"  
							+"AP_DPTNM9:STRING(50),AP_JOBNM9:STRING(15),EMPNM9:STRING(10),A_DATE9:STRING(20),AP_DESC9:STRING(100),"  					
							+"AP_DPTNM10:STRING(50),AP_JOBNM10:STRING(15),EMPNM10:STRING(10),A_DATE10:STRING(20),AP_DESC10:STRING(100)"; 							
							
				ds_print.SetDataHeader(ls_temp1);
			}
			
		}
		
		
	</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>	
		<script language=JavaScript  for=ds_default1 event="OnLoadStarted()" >

		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds_default1 event="OnLoadCompleted(row,colid)">

		</script>

<%// Description  :  그리드 더블클릭 이벤트 발생%>          
    <script language=JavaScript for=gr_RcpDpt event=OnDblClick(row,colid)>
    
	  var result="";
	  var arrParam	= new Array();
	  var arrResult	= new Array();
  
	  arrParam[0]=g_WinParam[4];                   								// 현장코드
	  arrParam[1]=g_WinParam[5];                   								// 실행번호		  
	  
	  strURL = "<%=dirPath%>/Pms/help/pr421h.jsp?";
	  strPos = "dialogWidth:1100px;dialogHeight:700px;status:yes;scroll:yes;resizable:yes";
	
	  result = showModalDialog(strURL,arrParam,strPos);    
        
    </script>


<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds_default1 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
		</script>

<%/*=============================================================================
			 DataSet Component's Event Message Scripts
	=============================================================================*/
%>	

			
<!-----------------------------------------------------------------------------
	DataSet Components 선언 
	# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->


<object  id=ds_default1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id="msgDS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>





<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>


<script language=JavaScript for=tr2 event=OnSuccess()>
	alert("정상적으로 승인처리 되었습니다.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

<script language=JavaScript for=tr3 event=OnSuccess()>
	alert("정상적으로 반송처리 되었습니다.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

</head>	
	
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	

<!-- 결재 / [결재|반송] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25  width=1050 align ="right">
	    	<img src="<%=dirPath%>/Sales/images/print.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnPrint();">&nbsp;&nbsp;&nbsp;	
	
	    	<img src="<%=dirPath%>/Sales/images/btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	</td>
  </tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">기본사항</font>
	  </td>
  </tr>
  <tr>
	<colgroup>
		<col width="110"></col>
		<col width="250"></col>
		<col width="110"></col>
		<col width="250"></col>
		<col width="110"></col>		
		<col width="*"></col>
	</colgroup>  
	<td height=25 width=1050>
		<table width="1050px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">현장명</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_SITE" type="text" class="textbox2"  size="35" style="height:19px" readonly>
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">실행번호</td>
				<td height="25px"  width="610px" bgcolor="#FFFFFF" align="left" valign=center colspan="3">&nbsp;
					(
					<input id="txt_NO_SILHENG" type="text" class="textbox2" size="3" style="height:19px" readonly>
					차)		
					<input id="txt_DS_SILHENG" type="text" class="textbox2" size="50" style="height:19px" readonly>		
				</td>
			</tr>
			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">실행구분</td>
				<td  height="25px" width="250px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<input id="txt_TY_SILHENG" type="text" class="textbox2"  size="15" style="height:19px" readonly>						
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">요청자</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_REQUEST" type="text" class="textbox2"   style="height:19px" readonly>
				</td>	
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">요청일자</td>
				<td height="25px"  width="220px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_REQUEST" type="text" class="textbox2"   style="height:19px" readonly>
				</td>								
			</tr>
		</table>
	</td>
  </tr>
</table>


<!-- 정보 -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:100;height:15;">도급/실행 정보</font>
	  	&nbsp;&nbsp;&nbsp;&nbsp;  <font style="position:relative;top:1px;width:500;height:15;color:red">더블클릭하시면 상세내역을 보실 수 있습니다.</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='1050px' height='180px' border='1'>
			<param name="DataID"		    		value="ds_default2">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="ViewSummary"       value="1">
			<param name="GeneralEdit" 			value="true" />
			<param name="Format" 				value="
	    		<C> name='No' 			ID={CurRow}	   			width=30 		align=CENTER	edit=none</C>
 	 			<C> name='개요' 		ID='DS_REMARK'			width=300 		align=left		edit=none show=false</C>
		      <G> name='당초'
		        <C> name='도급' 		ID='AM_DOKUB_PRE'   		width=120 		align=right			edit=none Dec=0 sumtext=@sum</C>	             
		        <C> name='실행'    		ID='AM_SILHENG_PRE'    		width=150 		align=right	 		edit=none Dec=0 sumtext=@sum</C>             
		      </G>	
		        
		      <G> name='변경'
		        <C> name='도급' 		ID='AM_DOKUB_CUR'   		width=120 		align=right			edit=none Dec=0 sumtext=@sum</C>
		        <C> name='도급증감' 	ID='AM_DOKUB_CHA'   		width=120 		align=right			edit=none Dec=0 sumtext=@sum</C>		                          
		        <C> name='실행'   		ID='AM_SILHENG_CUR'   		width=120 		align=right	 		edit=none Dec=0 sumtext=@sum</C>
		        <C> name='실행증감' 	ID='AM_SILHENG_CHA'   		width=120 		align=right			edit=none Dec=0 sumtext=@sum</C>			             
		      </G>		
       		        
		      <G> name='실행율'
		        <C> name='당초실행율' 	ID='RT_SILHENG_PRE'   			width=100 		align=right			edit=none  Dec=3</C>		                          
		        <C> name='변경실행율' 	ID='RT_SILHENG_CUR'   			width=100 		align=right			edit=none  Dec=3</C>			             
		      </G>	       		        
       		            
           ">
		</object>   
				
	</td>
  </tr>
</table>

<!-- 현장결재선 실행예산결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">현장결재선</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		
		<object id=gr_apline_rqst classid=<%=HDConstant.CT_GRID_CLSID%> width='1050' height='100px' border='1'>
			<param name="DataID"		    		value="ds_default3">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		   			value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="Format" 				value="
			  <C> name='결재SID'   ID=AP_M_SID   	               		width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='구분'     	ID=AP_TYPE_NM   	   			width=80	align=center editlimit=50 show=true edit=none</C>
              <C> name='결재자'    	ID=EMPNM		   	           		width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='사번'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='직위'		ID=AP_JOBNM  		            width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='부서'    	ID=AP_DPTNM	   	                width=150 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         	width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='결재일시'	ID=A_DATE			               width=200 	align=center editlimit=50 show=true edit=none</C>              
              <C> name='의견'	    ID=AP_DESC     		           width=350	align=left editlimit=14 show=true edit=none</C>

			">
		</object>   
				
	</td>
  </tr>
</table>

<!-- 본사결재선실행예산결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">본사결재선</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='1050px' height='200px' border='1'>
			<param name="DataID"		    		value="ds_default4">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="Format" 				value="
			  <C> name='결재SID'   ID=AP_M_SID   	               		width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='구분'     	ID=AP_TYPE_NM   	   			width=80	align=center editlimit=50 show=true edit=none</C>
              <C> name='결재자'    	ID=EMPNM		   	           		width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='사번'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='직위'		ID=AP_JOBNM  		            width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='부서'    	ID=AP_DPTNM	   	                width=150 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         	width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='결재일시'	ID=A_DATE			               width=200 	align=center editlimit=50 show=true edit=none</C>              
              <C> name='의견'	    ID=AP_DESC     		           width=350	align=left  editlimit=14 show=true edit=none</C>

			">
		</object>   
				
	</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>

	<object  id=gcbn_02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default1>
	<param name=BindInfo  value='  

	 <C>Col=DS_SITE 	 				Ctrl=txt_DS_SITE    					Param=value </C>
	 <C>Col=DS_SILHENG 				Ctrl=txt_DS_SILHENG  				Param=value </C>	 
	 <C>Col=NO_SILHENG 				Ctrl=txt_NO_SILHENG  				Param=value </C>
	 <C>Col=DT_REQUEST 	 			Ctrl=txt_DT_REQUEST    			Param=value </C>	
	 
	 <C>Col=DS_REQUEST 	 			Ctrl=txt_DS_REQUEST    			Param=value </C>		 
	 
	 <C>Col=TY_SILHENG 	 			Ctrl=txt_TY_SILHENG    			Param=value </C>	 
	 
	'>
</object>
      


<!-----------------------------------------------------------------------------
	  가예산, 본예산, 변경예산 레포트 데이타   D E C L A R A T I O N
------------------------------------------------------------------------------>


	<object id=ReportID00 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
		<param name="MasterDataID"			value="ds_default5">
		<param name="PaperSize"					value="A4">
		<param name="LandScape" 				value="false" />
		<param name="PrintSetupDlgFlag" 		value="true" />
		<param name="ImagSyncFlag"     		value="true">
		<param name="PreviewZoom" 			value="120" />
		<param name="Format"						value="  


<A>id=Area1 ,left=0,top=0 ,right=4101 ,bottom=141
	<R>id='SILHENG.sbt' ,left=3 ,top=5 ,right=4072 ,bottom=138,	DetailDataID=ds_default5

<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2702 ,face='Tahoma' ,size=11 ,penwidth=1
	<L> left=733 ,top=1423 ,right=733 ,bottom=1585 </L>
	<T>id='예 산' ,left=818 ,top=1434 ,right=1061 ,bottom=1492 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1109 ,top=1423 ,right=1109 ,bottom=1585 </L>
	<T>id='실행율' ,left=1156 ,top=1434 ,right=1400 ,bottom=1492 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1474 ,top=1423 ,right=1474 ,bottom=1585 </L>
	<L> left=402 ,top=1426 ,right=402 ,bottom=1588 </L>
	<L> left=953 ,top=458 ,right=953 ,bottom=624 </L>
	<T>id='아래와 같이 예산 승인을 요청하오니 검토 후 재가하여 주시기 바랍니다.' ,left=336 ,top=738 ,right=1961 ,bottom=796 ,align='left' ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS_SITE', left=336, top=632, right=1466, bottom=699, align='left', face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1976 ,top=624 ,right=32 ,bottom=624 </L>
	<T>id='건설사업본부 사업지원부' ,left=339 ,top=553 ,right=908 ,bottom=611 ,align='left' ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1974 ,top=545 ,right=29 ,bottom=545 </L>
	<L> left=1969 ,top=712 ,right=37 ,bottom=712 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1971 ,top=458 ,right=11 ,bottom=458 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='기안자' ,left=1029 ,top=558 ,right=1193 ,bottom=611 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보존기간' ,left=997 ,top=476 ,right=1225 ,bottom=529 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1265 ,top=460 ,right=1265 ,bottom=627 </L>
	<T>id='제    목' ,left=90 ,top=635 ,right=254 ,bottom=693 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기안부서' ,left=90 ,top=553 ,right=254 ,bottom=611 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='문서번호' ,left=87 ,top=476 ,right=251 ,bottom=529 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=310 ,top=460 ,right=310 ,bottom=712 </L>
	<T>id='기안서' ,left=728 ,top=156 ,right=1275 ,bottom=370 ,face='나눔고딕' ,size=40 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=1492 ,top=2598 ,right=1918 ,bottom=2670</I>
	<L> left=1984 ,top=2064 ,right=40 ,bottom=2064 </L>
	<L> left=1982 ,top=2148 ,right=37 ,bottom=2148 </L>
	<L> left=1982 ,top=2230 ,right=37 ,bottom=2230 </L>
	<L> left=1984 ,top=2310 ,right=40 ,bottom=2310 </L>
	<L> left=1984 ,top=2397 ,right=40 ,bottom=2397 </L>
	<T>id='담 당' ,left=79 ,top=2080 ,right=323 ,bottom=2138 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검 토' ,left=79 ,top=2162 ,right=323 ,bottom=2220 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확 인' ,left=79 ,top=2241 ,right=323 ,bottom=2299 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승 인' ,left=82 ,top=2323 ,right=325 ,bottom=2381 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='협 조' ,left=85 ,top=2408 ,right=328 ,bottom=2466 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='협 조' ,left=87 ,top=2503 ,right=331 ,bottom=2561 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1984 ,top=2484 ,right=40 ,bottom=2484 </L>
	<L> left=1982 ,top=2574 ,right=37 ,bottom=2574 </L>
	<L> left=1987 ,top=1982 ,right=42 ,bottom=1982 </L>
	<L> left=937 ,top=1984 ,right=937 ,bottom=2574 </L>
	<L> left=1402 ,top=1982 ,right=1402 ,bottom=2572 </L>
	<L> left=344 ,top=1984 ,right=344 ,bottom=2574 </L>
	<T>id='결 재 일 시' ,left=1048 ,top=1992 ,right=1291 ,bottom=2051 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기 타' ,left=1598 ,top=1992 ,right=1842 ,bottom=2051 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/2015slg.jpg' ,left=40 ,top=233 ,right=524 ,bottom=389</I>
	<T>id='- 아     래 - ' ,left=818 ,top=990 ,right=1122 ,bottom=1048 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 공 사 명 : ' ,left=127 ,top=1132 ,right=400 ,bottom=1191 ,align='left' ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS_SITE', left=407, top=1127, right=1537, bottom=1193, align='left', face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성 명 / 직 위' ,left=513 ,top=1992 ,right=791 ,bottom=2051 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=1423 ,right=106 ,bottom=1585 </L>
	<T>id='비 고' ,left=1527 ,top=1434 ,right=1770 ,bottom=1492 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=1585 ,right=1849 ,bottom=1585 </L>
	<L> left=106 ,top=1511 ,right=1849 ,bottom=1511 </L>
	<L> left=106 ,top=1423 ,right=1849 ,bottom=1423 </L>
	<L> left=1849 ,top=1423 ,right=1849 ,bottom=1585 </L>
	<C>id='TY_SILHENG', left=127, top=1516, right=394, bottom=1582, face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구 분' ,left=159 ,top=1434 ,right=360 ,bottom=1492 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2016 - ' ,left=341 ,top=474 ,right=505 ,bottom=532 ,align='left' ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS_REQUEST', left=1286, top=550, right=1701, bottom=616, align='left', face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AM_DOKUB', left=423, top=1516, right=709, bottom=1582, align='right', face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF Dec=0</C>
	<T>id='도 급' ,left=450 ,top=1431 ,right=693 ,bottom=1490 ,face='굴림체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AM_DOKUB', left=786, top=1516, right=1072, bottom=1582, align='right', face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF Dec=0</C>
	<C>id='RT_SILHENG_CUR', left=1146, top=1516, right=1431, bottom=1582, align='right', face='굴림체', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Decao=2</C>
</B>



	</R>
</A>

"/>

</object>



<!-----------------------------------------------------------------------------
	  설계변경, 집행승인 레포트 데이타   D E C L A R A T I O N
------------------------------------------------------------------------------>


	<object id=ReportID classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
		<param name="MasterDataID"			value="ds_default6">
		<param name="PaperSize"					value="A4">
		<param name="LandScape" 				value="TRUE" />
		<param name="PrintSetupDlgFlag" 		value="true" />
		<param name="ImagSyncFlag"     		value="true">
		<param name="PreviewZoom" 			value="150" />
		<param name="Format"						value="  

<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=137
	<R>id='Change.sbt' ,left=3 ,top=5 ,right=2855 ,bottom=138 ,DetailDataID='ds_default6'
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=1177 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=5 ,top=304 ,right=1476 ,bottom=445 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<I>id='http://ace.hdasan.com/images/approval/2015slg.jpg' ,left=5 ,top=8 ,right=489 ,bottom=164</I>
			<T>id='  ' ,left=1535 ,top=167 ,right=1892 ,bottom=294 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='  ' ,left=8 ,top=743 ,right=307 ,bottom=1048 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='  ' ,left=5 ,top=445 ,right=310 ,bottom=728 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='  ' ,left=5 ,top=167 ,right=304 ,bottom=294 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<L> left=1056 ,top=1066 ,right=1056 ,bottom=1172 </L>
			<L> left=1476 ,top=1066 ,right=1476 ,bottom=1175 </L>
			<T>id='소계' ,left=373 ,top=976 ,right=537 ,bottom=1035 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1476 ,top=169 ,right=1476 ,bottom=294 </L>
			<L> left=1050 ,top=743 ,right=1050 ,bottom=1045 </L>
			<T>id='공통부대비' ,left=352 ,top=828 ,right=564 ,bottom=886 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=587 ,top=743 ,right=587 ,bottom=1048 </L>
			<L> left=307 ,top=746 ,right=307 ,bottom=1048 </L>
			<L> left=8 ,top=743 ,right=8 ,bottom=1045 </L>
			<T>id='공통공사비' ,left=53 ,top=855 ,right=265 ,bottom=934 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='경상비' ,left=370 ,top=902 ,right=534 ,bottom=960 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='재 료 비' ,left=362 ,top=458 ,right=527 ,bottom=511 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='노 무 비' ,left=362 ,top=527 ,right=527 ,bottom=585 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='경 비' ,left=365 ,top=593 ,right=529 ,bottom=651 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='소 계' ,left=365 ,top=664 ,right=529 ,bottom=722 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='발 주 처' ,left=58 ,top=241 ,right=259 ,bottom=280 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='계약금액[전체]' ,left=34 ,top=177 ,right=294 ,bottom=217 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<L> left=1476 ,top=230 ,right=11 ,bottom=230 </L>
			<L> left=701 ,top=167 ,right=701 ,bottom=230 </L>
			<T>id='실행공기' ,left=1577 ,top=241 ,right=1855 ,bottom=280 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='계약공기' ,left=1577 ,top=183 ,right=1855 ,bottom=222 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<C>id='DS_CLIENT', left=328, top=243, right=1185, bottom=283, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<T>id='순공사비' ,left=50 ,top=545 ,right=262 ,bottom=624 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<L> left=1476 ,top=167 ,right=11 ,bottom=167 </L>
			<L> left=1476 ,top=294 ,right=11 ,bottom=294 </L>
			<L> left=2802 ,top=167 ,right=2802 ,bottom=291 </L>
			<L> left=587 ,top=307 ,right=587 ,bottom=728 </L>
			<L> left=5 ,top=307 ,right=5 ,bottom=728 </L>
			<L> left=310 ,top=445 ,right=310 ,bottom=728 </L>
			<L> left=1050 ,top=304 ,right=1050 ,bottom=730 </L>
			<L> left=1476 ,top=304 ,right=1476 ,bottom=730 </L>
			<C>id='HAP', left=704, top=1087, right=1042, bottom=1146, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<L> left=5 ,top=445 ,right=1479 ,bottom=445 </L>
			<L> left=312 ,top=590 ,right=1476 ,bottom=590 </L>
			<L> left=310 ,top=659 ,right=1474 ,bottom=659 </L>
			<S>id='{Sum(UP_MATERIAL+UP_LABOR+UP_COST)}' ,left=709 ,top=664 ,right=1042 ,bottom=725 ,align='right' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
			<L> left=1476 ,top=519 ,right=310 ,bottom=519 </L>
			<C>id='UP_LABOR', left=704, top=527, right=1042, bottom=585, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<L> left=8 ,top=743 ,right=1476 ,bottom=743 </L>
			<L> left=307 ,top=820 ,right=1476 ,bottom=820 </L>
			<L> left=307 ,top=894 ,right=1474 ,bottom=894 </L>
			<L> left=304 ,top=968 ,right=1474 ,bottom=968 </L>
			<L> left=13 ,top=1048 ,right=1476 ,bottom=1048 </L>
			<L> left=13 ,top=1066 ,right=1476 ,bottom=1066 </L>
			<L> left=1535 ,top=307 ,right=1535 ,bottom=1172 </L>
			<L> left=2802 ,top=307 ,right=2802 ,bottom=1172 </L>
			<L> left=1535 ,top=307 ,right=2802 ,bottom=307 </L>
			<L> left=1535 ,top=1172 ,right=2802 ,bottom=1172 </L>
			<L> left=1476 ,top=1175 ,right=13 ,bottom=1175 </L>
			<L> left=1476 ,top=743 ,right=1476 ,bottom=1048 </L>
			<T>id='공통가설' ,left=368 ,top=757 ,right=545 ,bottom=810 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='금 액' ,left=648 ,top=347 ,right=992 ,bottom=407 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='비율(계약대비)' ,left=1124 ,top=349 ,right=1416 ,bottom=410 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<C>id='UP_COST', left=704, top=595, right=1042, bottom=656, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='UP_MATERIAL', left=704, top=452, right=1042, bottom=513, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='BUDAE', left=704, top=828, right=1042, bottom=889, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='KYUNGSANG', left=704, top=902, right=1042, bottom=963, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='GASUL', left=701, top=749, right=1040, bottom=815, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<S>id='{Sum(GASUL+BUDAE+KYUNGSANG)}' ,left=704 ,top=974 ,right=1042 ,bottom=1042 ,align='right' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
			<T>id='비 목' ,left=95 ,top=339 ,right=495 ,bottom=407 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<C>id='UP_MATERIAL_SUPPLY', left=1064, top=452, right=1402, bottom=513, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='UP_LABOR_SUPPLY', left=1064, top=524, right=1402, bottom=587, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='UP_COST_SUPPLY', left=1061, top=593, right=1400, bottom=659, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='GASUL_SUPPLY', left=1064, top=749, right=1402, bottom=815, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='BUDAE_SUPPLY', left=1064, top=826, right=1402, bottom=892, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='KYUNGSANG_SUPPLY', left=1064, top=900, right=1402, bottom=966, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
			<C>id='HAP_SUPPLY', left=1069, top=1085, right=1408, bottom=1151, align='right', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Decao=2</C>
			<T>id='%' ,left=1402 ,top=455 ,right=1468 ,bottom=513 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='%' ,left=1402 ,top=527 ,right=1468 ,bottom=585 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='%' ,left=1400 ,top=598 ,right=1466 ,bottom=656 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='%' ,left=1402 ,top=751 ,right=1468 ,bottom=810 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='%' ,left=1402 ,top=831 ,right=1468 ,bottom=889 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='%' ,left=1402 ,top=902 ,right=1468 ,bottom=960 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='%' ,left=1405 ,top=1087 ,right=1471 ,bottom=1146 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2802 ,top=167 ,right=1532 ,bottom=167 </L>
			<L> left=1535 ,top=230 ,right=2802 ,bottom=230 </L>
			<L> left=2802 ,top=294 ,right=1535 ,bottom=294 </L>
			<L> left=1892 ,top=169 ,right=1892 ,bottom=294 </L>
			<L> left=304 ,top=167 ,right=304 ,bottom=294 </L>
			<C>id='DS_REMARK', left=1572, top=349, right=2762, bottom=1135, align='left', Multiline=true ,valign=top</C>
			<C>id='DT_TO', left=2379, top=183, right=2609, bottom=222, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id=' ~' ,left=2331 ,top=183 ,right=2373 ,bottom=222 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DT_FROM', left=2103, top=243, right=2328, bottom=286, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DT_FROM', left=2103, top=183, right=2328, bottom=225, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='  ' ,left=701 ,top=167 ,right=1050 ,bottom=230 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='계약금액[당사분]' ,left=738 ,top=177 ,right=1029 ,bottom=217 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<C>id='AM_SUPPLY', left=318, top=172, right=693, bottom=225, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='AM_SUPPLY_OUR', left=1058, top=172, right=1468, bottom=225, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DT_TO', left=2381, top=243, right=2611, bottom=286, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id=' ~' ,left=2334 ,top=246 ,right=2376 ,bottom=286 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=13 ,top=728 ,right=1479 ,bottom=728 </L>
			<T>id='  ' ,left=8 ,top=1066 ,right=590 ,bottom=1175 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='실 행 예 산 서' ,left=1185 ,top=0 ,right=1781 ,bottom=108 ,face='나눔고딕' ,size=25 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DS_SITE', left=823, top=108, right=2140, bottom=164, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='합  계' ,left=191 ,top=1080 ,right=402 ,bottom=1159 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<L> left=1050 ,top=169 ,right=1050 ,bottom=230 </L>
		</B>
	</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=137
	<R>id='approval.sbt' ,left=5 ,top=0 ,right=2855 ,bottom=132 ,DetailDataID='ds_print'
		<B>id=DHeader ,left=0,top=0 ,right=3000 ,bottom=630 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='재' ,left=16 ,top=429 ,right=74 ,bottom=487 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='결' ,left=16 ,top=146 ,right=74 ,bottom=204 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='직위 / 성명' ,left=511 ,top=13 ,right=823 ,bottom=66 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='소속' ,left=251 ,top=13 ,right=487 ,bottom=66 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='NO' ,left=90 ,top=13 ,right=235 ,bottom=66 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1' ,left=90 ,top=74 ,right=235 ,bottom=127 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='2' ,left=90 ,top=130 ,right=235 ,bottom=183 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='3' ,left=90 ,top=185 ,right=235 ,bottom=238 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='4' ,left=90 ,top=241 ,right=235 ,bottom=294 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='5' ,left=90 ,top=296 ,right=235 ,bottom=349 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='6' ,left=90 ,top=352 ,right=235 ,bottom=405 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=85 ,top=405 ,right=2474 ,bottom=405 </L>
			<T>id='7' ,left=90 ,top=407 ,right=235 ,bottom=460 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=85 ,top=460 ,right=2474 ,bottom=460 </L>
			<T>id='8' ,left=90 ,top=463 ,right=235 ,bottom=516 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=85 ,top=516 ,right=2474 ,bottom=516 </L>
			<T>id='9' ,left=90 ,top=519 ,right=235 ,bottom=572 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='10' ,left=90 ,top=574 ,right=235 ,bottom=627 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=8 ,top=13 ,right=8 ,bottom=627 </L>
			<L> left=85 ,top=13 ,right=85 ,bottom=627 </L>
			<L> left=2802 ,top=13 ,right=2802 ,bottom=627 </L>
			<L> left=500 ,top=13 ,right=500 ,bottom=627 </L>
			<L> left=241 ,top=13 ,right=241 ,bottom=630 </L>
			<C>id='AP_DPTNM4', left=246, top=241, right=497, bottom=294</C>
			<C>id='AP_DPTNM3', left=246, top=185, right=497, bottom=238</C>
			<C>id='AP_DPTNM2', left=246, top=130, right=497, bottom=183</C>
			<C>id='AP_DPTNM5', left=246, top=296, right=497, bottom=349</C>
			<C>id='AP_DPTNM6', left=246, top=352, right=497, bottom=405</C>
			<C>id='AP_DPTNM7', left=246, top=407, right=497, bottom=460</C>
			<C>id='AP_DPTNM8', left=246, top=463, right=497, bottom=516</C>
			<C>id='AP_DPTNM9', left=246, top=519, right=497, bottom=572</C>
			<C>id='AP_DPTNM10', left=246, top=574, right=497, bottom=627</C>
			<C>id='AP_DPTNM1', left=246, top=71, right=497, bottom=127</C>
			<L> left=831 ,top=13 ,right=831 ,bottom=627 </L>
			<T>id='/' ,left=656 ,top=71 ,right=677 ,bottom=124 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=130 ,right=677 ,bottom=183 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=185 ,right=677 ,bottom=238 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=241 ,right=677 ,bottom=294 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=352 ,right=677 ,bottom=405 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=299 ,right=677 ,bottom=352 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=407 ,right=677 ,bottom=460 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=463 ,right=677 ,bottom=516 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=519 ,right=677 ,bottom=572 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='/' ,left=656 ,top=574 ,right=677 ,bottom=627 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='AP_JOBNM8', left=503, top=460, right=651, bottom=519, align='right', MargineX=3</C>
			<C>id='AP_JOBNM6', left=503, top=349, right=651, bottom=407, align='right', MargineX=3</C>
			<C>id='AP_JOBNM4', left=503, top=238, right=651, bottom=296, align='right', MargineX=3</C>
			<C>id='AP_JOBNM3', left=503, top=183, right=651, bottom=241, align='right', MargineX=3</C>
			<C>id='AP_JOBNM2', left=503, top=124, right=651, bottom=183, align='right', MargineX=3</C>
			<C>id='AP_JOBNM5', left=503, top=294, right=651, bottom=352, align='right', MargineX=3</C>
			<C>id='AP_JOBNM1', left=503, top=69, right=651, bottom=127, align='right', MargineX=3</C>
			<C>id='AP_JOBNM7', left=503, top=407, right=651, bottom=466, align='right', MargineX=3</C>
			<C>id='AP_JOBNM9', left=503, top=516, right=651, bottom=574, align='right', MargineX=3</C>
			<C>id='AP_JOBNM10', left=503, top=574, right=651, bottom=627, align='right', MargineX=3</C>
			<C>id='EMPNM1', left=683, top=71, right=823, bottom=124, align='left', MargineX=3</C>
			<C>id='EMPNM2', left=683, top=130, right=823, bottom=183, align='left', MargineX=3</C>
			<C>id='EMPNM10', left=683, top=574, right=823, bottom=627, align='left', MargineX=3</C>
			<C>id='EMPNM9', left=683, top=519, right=823, bottom=572, align='left', MargineX=3</C>
			<C>id='EMPNM8', left=683, top=463, right=823, bottom=516, align='left', MargineX=3</C>
			<C>id='EMPNM7', left=683, top=407, right=823, bottom=460, align='left', MargineX=3</C>
			<C>id='EMPNM6', left=683, top=352, right=823, bottom=405, align='left', MargineX=3</C>
			<C>id='EMPNM5', left=683, top=296, right=823, bottom=349, align='left', MargineX=3</C>
			<C>id='EMPNM4', left=683, top=241, right=823, bottom=294, align='left', MargineX=3</C>
			<C>id='EMPNM3', left=683, top=185, right=823, bottom=238, align='left', MargineX=3</C>
			<C>id='A_DATE1', left=839, top=74, right=1196, bottom=124</C>
			<C>id='A_DATE2', left=839, top=130, right=1196, bottom=180</C>
			<C>id='A_DATE3', left=839, top=185, right=1196, bottom=235</C>
			<C>id='A_DATE4', left=839, top=241, right=1196, bottom=291</C>
			<C>id='A_DATE5', left=839, top=296, right=1196, bottom=347</C>
			<C>id='A_DATE10', left=839, top=574, right=1196, bottom=624</C>
			<C>id='A_DATE8', left=839, top=463, right=1196, bottom=513</C>
			<C>id='A_DATE6', left=839, top=352, right=1196, bottom=402</C>
			<C>id='A_DATE7', left=839, top=407, right=1196, bottom=458</C>
			<C>id='A_DATE9', left=839, top=519, right=1196, bottom=569</C>
			<L> left=8 ,top=627 ,right=2802 ,bottom=627 </L>
			<L> left=8 ,top=13 ,right=2802 ,bottom=13 </L>
			<L> left=85 ,top=574 ,right=2474 ,bottom=574 </L>
			<L> left=85 ,top=69 ,right=2802 ,bottom=69 </L>
			<T>id='결재일시' ,left=841 ,top=16 ,right=1196 ,bottom=69 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1199 ,top=16 ,right=1199 ,bottom=627 </L>
			<T>id='의 견' ,left=1677 ,top=19 ,right=1990 ,bottom=71 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='AP_DESC1', left=1204, top=77, right=2471, bottom=127</C>
			<C>id='AP_DESC2', left=1204, top=132, right=2471, bottom=185</C>
			<C>id='AP_DESC3', left=1204, top=188, right=2471, bottom=241</C>
			<C>id='AP_DESC4', left=1204, top=243, right=2471, bottom=296</C>
			<C>id='AP_DESC5', left=1204, top=299, right=2471, bottom=352</C>
			<C>id='AP_DESC6', left=1204, top=355, right=2471, bottom=407</C>
			<C>id='AP_DESC7', left=1204, top=407, right=2471, bottom=460</C>
			<C>id='AP_DESC8', left=1204, top=463, right=2471, bottom=516</C>
			<C>id='AP_DESC9', left=1204, top=519, right=2471, bottom=572</C>
			<C>id='AP_DESC10', left=1204, top=574, right=2471, bottom=627</C>
			<L> left=2474 ,top=16 ,right=2474 ,bottom=627 </L>
			<L> left=85 ,top=127 ,right=2474 ,bottom=127 </L>
			<L> left=85 ,top=185 ,right=2474 ,bottom=185 </L>
			<L> left=85 ,top=238 ,right=2474 ,bottom=241 </L>
			<L> left=85 ,top=294 ,right=2474 ,bottom=294 </L>
			<L> left=85 ,top=349 ,right=2474 ,bottom=349 </L>
			<T>id='대표이사' ,left=2508 ,top=16 ,right=2768 ,bottom=69 ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
	</R>
</A>
<B>id=Footer ,left=0 ,top=1905 ,right=2871 ,bottom=2000 ,face='Tahoma' ,size=10 ,penwidth=1
	<I>id='http://ace.hdasan.com/images/approval/2014ci.gif' ,left=2384 ,top=26 ,right=2810 ,bottom=95</I>
</B>



"/>

</object>






</body>
<!- BODY END -->
</html>