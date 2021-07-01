<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재기안 :자재청구서
 * 프로그램ID 	: pr610h
 * J  S  P	    : pr610h.jsp
 * 서 블 릿		: pr610h
 * 작 성 자		: 이동훈
 * 작 성 일		: 2015-10-08
 * [ 수정일자 ][수정자] 내용
 * [2015-10-08][이동훈]
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
		<title>전자결재 - 자재청구서결재</title>
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
																	             + ",v_no_cont="+g_WinParam[5];         
	         
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr610H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     
		     tr_post(tr1);
		     
		    //첨부파일 쪼개기
		    var real_fileList="";
			var sys_fileList="";
				
			var real_fileList =txt_real_file.value;
			var sys_fileList =txt_sys_file.value;
		
			var real_file10= new Array();
			var sys_file10= new Array();
		
			real_file10 = real_fileList.split(":");	//배열로 정리
			sys_file10 = sys_fileList.split(":");	//배열로 정리
		
			var real_file1=real_file10.slice(0,1);
			var sys_file1=sys_file10.slice(0,1);	
			var real_file2=real_file10.slice(1,2);
			var sys_file2=sys_file10.slice(1,2);	
			var real_file3=real_file10.slice(2,3);
			var sys_file3=sys_file10.slice(2,3);	
			
			// 청구서 기본정보
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							              	 	+ ",v_ap_m_sid="+g_WinParam[3]
									            + ",v_cd_site="+g_WinParam[4]
									            + ",v_no_mr="+g_WinParam[5];        
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr610H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     tr_post(tr1);			
			
			// 청구서 품목정보
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							              	 	+ ",v_ap_m_sid="+g_WinParam[3]
									            + ",v_cd_site="+g_WinParam[4]
									            + ",v_no_mr="+g_WinParam[5];        
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr610H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
		     tr_post(tr1);
		     
		     
			 // (현장)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr610H", "JSP(O:DS_DEFAULT3=ds_default3)",  param);
		     tr_post(tr1);
		     
			 // (본사)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr610H", "JSP(O:DS_DEFAULT4=ds_default4)",  param);
		     tr_post(tr1);
		     

		}
		
		
		// 승인  
		function fnApply_1(){
			
			if (confirm("승인하시겠습니까?")) {


				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
	 											+ ",v_ap_m_sid="+g_WinParam[3]
	 											+ ",vEmpNo="+gusrid
									            + ",vEmpNmk="+gusrnm;
				
			
				
			    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr010H","JSP(O:msgDS=msgDS)", param);
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
	
				ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr610H","JSP(O:msgDS=msgDS)", param);
				
				tr_post(tr3); 		
			
			}
			
		}

  //첨부파일(1) 다운로드_열기
    function fnFile(){
	  
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
				
		if(real_file1==''){
		alert("첨부파일이 존재하지 않습니다")
		return;
		}else if(real_file1.length==1){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //로컬
		}
	}

  	//첨부파일(2) 다운로드_열기
    function fnFile2(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	

		//alert(real_file2);				
		//alert(sys_file2);						
		//alert(real_file2.length);
		
		if(real_file2.length==0){
		alert("2번째 파일이 존재하지 않습니다")
		}
		if(real_file2.length>0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //로컬
		}
	}
  	
	//첨부파일(3) 다운로드_열기
    function fnFile3(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
		
		if(real_file3.length==0){
		alert("3번째 파일이 존재하지 않습니다")
		}
		if(real_file3.length >0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //로컬
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
	<td height=25  width=1050 align ="right">
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
					<input id="txt_DS_DEPT" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">청구서번호</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_NO_MR" type="text" class="textbox2" size="15" style="height:19px" readonly>
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">청구일자</td>
				<td height="25px"  width="220px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_REQUEST" type="text" class="textbox2" style="height:19px" readonly>
				</td>				
			</tr>
			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">현설일시</td>
				<td  height="25px" width="250px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<input id="txt_DT_EXPLAIN" type="text" class="textbox2"  size="15" style="height:19px" readonly>
					<input id="txt_HH_EXPLAIN" type="text" class="textbox2"  size="1" style="height:19px" readonly>시
					<input id="txt_MM_EXPLAIN" type="text" class="textbox2"  size="1" style="height:19px" readonly>분								
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">계약요청일</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_CONTRACT" type="text" class="textbox2"   style="height:19px" readonly>
				</td>	
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">현장담당자</td>
				<td height="25px"  width="220px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_HNAME" type="text" class="textbox2"   style="height:19px" readonly>
				</td>								
			</tr>
			
			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">현설장소</td>
				<td  height="25px" width="250px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<input id="txt_AT_SITEEXPLAIN" type="text" class="textbox2"   style="height:19px" readonly>
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">청구품목수</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_CNT_ITEM" type="text" class="textbox2"   style="height:19px" readonly>
				</td>	
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">총청구수량</td>
				<td height="25px"  width="220px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<!-- <input id="txt_QN_ITEM" type="text" class="textbox2"   style="height:19px" readonly>  -->
					<comment id="__NSID__">
					<object  id=txt_QN_ITEM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="false">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
					</object>	
					</comment><script>__ws__(__NSID__);</script>					
				</td>								
			</tr>
						
			<tr>
				<td  height="25px"  width="110px" bgcolor="#eeeeee" align="center" class="text">청구내용</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_RM_REQUEST" type="text" class="textbox2"  size="10" style="height:19px" readonly>
				</td>
				<td  height="25px"  width="110px" bgcolor="#eeeeee" align="center" class="text">납품기간</td>
				<td  height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<input id="txt_FR_DELIVERY" type="text" class="textbox2"  size="14" style="height:19px" readonly> ~ 
					<input id="txt_TO_DELIVERY" type="text" class="textbox2"  size="14" style="height:19px" readonly>			
				</td>
				<td  height="25px"  width="110px" bgcolor="#eeeeee" align="center" class="text">합계금액</td>
				<td  height="25px" width="220px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<!--  <input id="txt_AM_ITEM" type="text" class="textbox2"  size="10" style="height:19px" readonly> -->
					<object  id=txt_AM_ITEM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="height:18px;width:100px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="false">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
					</object>			
				</td>				
			</tr>

			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">계약보증금율</td>
				<td  height="25px" width="250px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;&nbsp;계약금액의&nbsp;
					<input id="txt_RT_CONTRACT" type="text" class="numfield"  size="5" style="height:19px" readonly>&nbsp;%
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">인도조건</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_DELIVERY" type="text" class="textbox2"  size="20" style="height:19px" readonly>
				</td>	
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">대금지불조건</td>
				<td height="25px"  width="220px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_PAYMENT" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>								
			</tr>

			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">하자보증율</td>
				<td  height="25px" width="250px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;&nbsp;계약금액의&nbsp;
					<input id="txt_RT_FLAW" type="text" class="numfield"  size="5" style="height:19px" readonly>&nbsp;%
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">하자보증기간</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;&nbsp;준공 후
					<input id="txt_DS_FLAWTERM" type="text" class="textbox2"  size="1" style="height:19px" readonly> 년
				</td>	
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">지체상금율</td>
				<td height="25px"  width="220px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;&nbsp;1일 지체시마다 계약금액의 
					<input id="txt_DS_DELAY" type="text" class="numfield"  size="1" style="height:19px"  align="right"  readonly>/1000
				</td>								
			</tr>

			<tr>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">특기사항</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center colspan="5">&nbsp;
					<input id="txt_RM_ETC" type="text" class="textbox2"  style="width:800px;height:19px;top:5px" readonly >	
				</td>
			</tr>
			<tr>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">첨부파일</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center colspan="6">&nbsp;
                    <input type="text" name='txt_real_file' id="txt_real_file" style="width:700px;" class='textbox2'   readOnly="readonly">
                    <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='textbox2' value="(1)"  onclick="fnFile()" readOnly="readonly">
                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='textbox2'   value="(2)" onclick="fnFile2()" readOnly="readonly">
                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='textbox2'   value="(3)" onclick="fnFile3()" readOnly="readonly">
					<input id="txt_sys_file" type="hidden" class="textbox2" size="0" style="height:0px" readonly>
				</td>
			</tr>								
		</table>
	</td>
  </tr>
</table>


<!-- 청구서 품목정보 -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:100;height:15;">청구서 품목정보</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
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
	    		<C> name='No' 							ID={CurRow}	   			width=20 		align=CENTER	edit=none</C>
		        <G> name='청구품목'
		             <C> name='품목코드' 		ID='CD_ITEM'   		width=70 		align=CENTER		edit=none </C>
		             <C> name='명칭'    		ID='DS_ITEM'    	    width=150 		align=left	 		edit=none </C>
		             <C> name='규격'   			ID='SZ_ITEM'   		width=50 		align=CENTER	 	sumtext='@sum' sumtextalign='right'	 edit=none</C>
		             <C> name='단위'    		ID='UT_ITEM'    	    width=50 		align=CENTER	 	edit=none </C>		             
		        </G>		    		 	 
		        <G> name='청구'
		             <C> name='수량' 			ID='QN_ITEM'   		width=60 		align=CENTER		edit=none Value={Number(QN_ITEM)} Dec=0</C>
		             <C> name='단가'    			ID='UP_ITEM'    	    width=60 		align=CENTER	 	edit=none Value={Number(UP_ITEM)} Dec=0</C>
		             <C> name='금액'   			ID='AM_ITEM'   		width=80 		align=CENTER	 	edit=none Dec=0</C>
		        </G>	
		        <G> name='기청구'
		             <C> name='수량' 			ID='QN_ITEMp'   		width=50 		align=CENTER		edit=none Value={Number(QN_ITEMp)} Dec=0</C>
		             <C> name='금액'   			ID='AM_ITEMp'   		width=60 		align=CENTER	 	edit=none Value={Number(AM_ITEMp)} Dec=0</C>
		        </G>			        		    		 	 
		        <G> name='실행예산'
		             <C> name='공종코드' 		ID='CD_DKCOST'   	width=80 		align=CENTER		edit=none </C>
		             <C> name='공종명'    		ID='DS_COST'    	    width=150 		align=left	 		edit=none </C>
		             <C> name='규격'   			ID='SZ_SIZE'   			width=80 		align=CENTER	 	edit=none </C>
		        </G>	    		 

		        <G> name='도급'
		             <C> name='수량' 			ID='QN_TT_DOKUB'   	width=60 		align=CENTER		edit=none Value={Number(QN_TT_DOKUB)} Dec=0</C>
		             <C> name='단가'    			ID='UP_TT_DOKUB'    	width=60 		align=CENTER	 	edit=none Value={Number(UP_TT_DOKUB)} Dec=0</C>
		             <C> name='금액'   			ID='AM_TT_DOKUB'   	width=80 		align=CENTER	 	edit=none Value={Number(AM_TT_DOKUB)} Dec=0</C>
		        </G>	
		        <G> name='실행'
		             <C> name='수량' 			ID='QN_TT_SILHENG'   	width=60 		align=CENTER		edit=none Value={Number(QN_TT_SILHENG)} Dec=0</C>
		             <C> name='단가'    			ID='UP_TT_SILHENG'    	width=60 		align=CENTER	 	edit=none Value={Number(UP_TT_SILHENG)} Dec=0</C>
		             <C> name='금액'   			ID='AM_TT_SILHENG'   	width=80 		align=CENTER	 	edit=none Value={Number(AM_TT_SILHENG)} Dec=0</C>
		        </G>		
		        
	        	        		        
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
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='1050px' height='100px' border='1'>
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
	<object  id=gcbn_02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default1>
	<param name=BindInfo  value='  
	 <C>Col=AP_M_SID	 	 			Ctrl=txt_rqst_sid    					Param=value </C>
	 <C>Col=DS_SITE 	 				Ctrl=txt_DS_SITE    					Param=value </C>
	 <C>Col=RM_REQUEST 				Ctrl=txt_RM_REQUEST  				Param=value </C>
	 <C>Col=DS_DEPT 	 				Ctrl=txt_DS_DEPT    					Param=value </C>	
	 <C>Col=DT_REQUEST 	 			Ctrl=txt_DT_REQUEST    			Param=value </C>	 
	 <C>Col=FR_DELIVERY 	 			Ctrl=txt_FR_DELIVERY    			Param=value </C>	  
 	 <C>Col=TO_DELIVERY				Ctrl=txt_TO_DELIVERY  			Param=value </C>
	 <C>Col=DT_EXPLAIN 	  			Ctrl=txt_DT_EXPLAIN    				Param=value </C>
	 <C>Col=HH_EXPLAIN 	  			Ctrl=txt_HH_EXPLAIN   				Param=value </C>
	 <C>Col=MM_EXPLAIN       			Ctrl=txt_MM_EXPLAIN     			Param=value </C>
	 <C>Col=AT_SITEEXPLAIN 	  		Ctrl=txt_AT_SITEEXPLAIN   		Param=value </C>
	 
	 <C>Col=CNT_ITEM 	    			Ctrl=txt_CNT_ITEM   				Param=value </C>
	 <C>Col=QN_ITEM 					Ctrl=txt_QN_ITEM  					Param=text </C>
	 <C>Col=AM_ITEM 					Ctrl=txt_AM_ITEM  					Param=text </C>		
	 	 
	 <C>Col=DS_DELIVERY 	    		Ctrl=txt_DS_DELIVERY   			Param=value </C>
	 <C>Col=DS_PAYMENT 				Ctrl=txt_DS_PAYMENT  				Param=value </C>
	 <C>Col=DT_CONTRACT 			Ctrl=txt_DT_CONTRACT  			Param=value </C>	 
	 <C>Col=DS_HNAME					Ctrl=txt_DS_HNAME					Param=value </C>	
	 <C>Col=NO_MR 						Ctrl=txt_NO_MR  						Param=value </C>
	 <C>Col=RT_CONTRACT          	Ctrl=txt_RT_CONTRACT        		Param=value </C>	 
	 <C>Col=RT_FLAW					Ctrl=txt_RT_FLAW 					Param=value </C>		 
	 <C>Col=DS_FLAWTERM          	Ctrl=txt_DS_FLAWTERM        		Param=value </C>	 
	 <C>Col=DS_DELAY					Ctrl=txt_DS_DELAY 					Param=value </C>	
	 <C>Col=RM_ETC						Ctrl=txt_RM_ETC 						Param=value </C>		 

	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>