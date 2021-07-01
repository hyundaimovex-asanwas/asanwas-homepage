<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재기안 : 노무비명세서
 * 프로그램ID 	: pr070h
 * J  S  P	    : pr070h.jsp
 * 서 블 릿		: pr070h
 * 작 성 자		: 이동훈
 * 작 성 일		: 2015-10-07
 * [ 수정일자 ][수정자] 내용
 * [2015-10-07][이동훈]
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
		<title>전자결재 - 발주의뢰서결재</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">
	var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
	var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
	
    var g_WinParam = window.dialogArguments;
     
    //alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]+"::g_WinParam[2]::"+g_WinParam[2]+"::g_WinParam[3]::"+g_WinParam[3]);
    
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
             					 + ",v_ym_work="+g_WinParam[5];	                   
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr070H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     tr_post(tr1);

			// 출역내역
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				              	 + ",v_ap_m_sid="+g_WinParam[3]
				            	 + ",v_cd_site="+g_WinParam[4]
							 	 + ",v_ym_work="+g_WinParam[5];	         
		    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr070H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
		    tr_post(tr1);
		     
		     
			 // (현장)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr070H", "JSP(O:DS_DEFAULT3=ds_default3)",  param);
		     tr_post(tr1);
		     
			 // (본사)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr070H", "JSP(O:DS_DEFAULT4=ds_default4)",  param);
		     tr_post(tr1);
		     

		}
		
		
		// 승인  
		function fnApply_1(){
			
			if (confirm("승인하시겠습니까?")) {


				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
	 											+ ",v_ap_m_sid="+g_WinParam[3]
	 											+ ",vEmpNo="+gusrid
									            + ",vEmpNmk="+gusrnm;
				
			
				
			    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr070H","JSP(O:msgDS=msgDS)", param);
		        tr_post(tr2); 

			}

		}		

		// 반송  
		function fnApply_2(){
			
			  //alert(arrParam);
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
	
				ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr070H","JSP(O:msgDS=msgDS)", param);
				tr_post(tr3); 		
			
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
<%=HDConstant.COMMENT_START%>

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


<%=HDConstant.COMMENT_END%>


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
	<td height=25  width=950 align ="right">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
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
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">현장명</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_SITE" type="text" class="textbox2"  size="50" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">출역월</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_MONTH" type="text" class="textbox2" size="18" style="height:19px" readonly mask ='xxxx-xx'>
				</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
<br>
<!-- 출역 및 노무비 -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:200;height:15;">출역 및 노무비</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='300px' border='1'>
			<param name="DataID"		    		value="ds_default2">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="ViewSummary"       value="1">
			<param name="Format" 				value="
	    		 <C> name='No' 							ID={CurRow}	   			width=20 		align=CENTER	edit=none SumBgColor=#C3D0DB</C>
	             <C> name='현장명' 						ID='SITE_NM'	   			width=250 		align=CENTER	edit=none SumBgColor=#C3D0DB </C>
	             <C> name='성명' 						ID='ENO_NM'   				width=100 		align=CENTER	edit=none SumBgColor=#C3D0DB </C>
	             <C> name='생년월일' 					ID='CET_NO'    			width=100 		align=CENTER	edit=none SumBgColor=#C3D0DB mask='XX-XX-XX' </C>
	             <C> name='일당'							ID='WRK_AMT'  			width=100 		align=CENTER	edit=none SumBgColor=#C3D0DB Value={Number(WRK_AMT)} Dec=0</C>
	             <C> name='근로일수'					ID='WRK_DAY'  			width=80 		align=CENTER	edit=none SumBgColor=#C3D0DB </C>
	             <C> name='공수'							ID='GONGSU'  				width=80 		align=CENTER	edit=none SumBgColor=#C3D0DB </C>	             
	             <C> name='노무비'						ID='WRK_PAY'  				width=100 		align=CENTER	edit=none SumBgColor=#C3D0DB Value={Number(WRK_PAY)} Dec=0</C>        
	             <C> name='실지급액'					ID='AM_JIGUB'  			width=100 		align=CENTER	edit=none SumBgColor=#C3D0DB Value={Number(AM_JIGUB)} Dec=0</C>   	              
           ">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<!-- 현장결재선 발주의뢰결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">현장결재선</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline_rqst classid=<%=HDConstant.CT_GRID_CLSID%> width='950' height='100px' border='1'>
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
              <C> name='부서'    	ID=AP_DPTNM	   	                width=250 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         	width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='의견'	    ID=AP_DESC     		           width=110	align=center editlimit=14 show=true edit=none</C>
              <C> name='결재일시'	ID=A_DATE			               width=250 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<!-- 본사결재선 발주의뢰결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">본사결재선</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='100px' border='1'>
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
              <C> name='부서'    	ID=AP_DPTNM	   	                width=250 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         	width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='의견'	    ID=AP_DESC     		           width=110	align=center editlimit=14 show=true edit=none</C>
              <C> name='결재일시'	ID=A_DATE			               width=250 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object  id=gcbn_01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default1>
	<param name=BindInfo  value='  
	 <C>Col=DS_SITE	 	 				Ctrl=txt_DS_SITE    						Param=value </C>
	 <C>Col=DT_MONTH			 		Ctrl=txt_DT_MONTH	  					Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>

