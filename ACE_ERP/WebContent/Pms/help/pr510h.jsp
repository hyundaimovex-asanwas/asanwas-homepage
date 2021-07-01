<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재기안 :발주의뢰서
 * 프로그램ID 	: pr510h
 * J  S  P	    : pr510h.jsp
 * 서 블 릿		: pr510h
 * 작 성 자		: 이동훈
 * 작 성 일		: 2015-09-12
 * [ 수정일자 ][수정자] 내용
 * [2015-09-12][이동훈]
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
		
//		alert(array2[0]);
//		alert(array2[1]);
//		alert(array2[2]);
//		alert(array2[3]);
//		alert(array2[4]);
		
		
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
		
		/*
	    if (g_WinParam[0]=="010") {
	    	sp0.style.display = "";
			sp1.style.display = "none";
	    }else{
	    	sp0.style.display = "none";
			sp1.style.display = "";
	    }
	    */
		    
	  }

		// 메인 조회
		function fnSelect() {
			
			//기본사항 조회 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
																	                       	 + ",v_ap_m_sid="+g_WinParam[3]
																				             + ",v_cd_site="+g_WinParam[4]
																				             + ",v_no_cont="+g_WinParam[5]
																							 + ",vEmpNo="+gusrid;
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     
		     //prompt(this, param);
		     
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
			
			
			
			// 업체추천내역
	        //var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		    //                   + ",v_ap_m_sid="+g_WinParam[3];        
		    // ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
		    // tr_post(tr1);
		     
		     
			 // (현장)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT3=ds_default3)",  param);
		     tr_post(tr1);
		     
			 // (본사)결재정보		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT4=ds_default4)",  param);
		     tr_post(tr1);
		     

		}
		
		
		// 승인  
		function fnApply_1(){
			
			if (confirm("승인하시겠습니까?")) {

				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
														 											+ ",v_ap_m_sid="+g_WinParam[3]
																						            + ",v_cd_site="+g_WinParam[4]
																						            + ",v_no_cont="+g_WinParam[5]
														 											+ ",vEmpNo="+gusrid
																						            + ",vEmpNmk="+gusrnm;

			    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H","JSP(O:msgDS=msgDS)", param);
			    
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
	
				ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H","JSP(O:msgDS=msgDS)", param);
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
			
			var url = "http://203.242.32.115/"+sys_file1; //운영
			location.href=url;
			
			//location.href = 'http://203.242.32.115/'+sys_file1; //운영
			//location.href = './download_zace.jsp?dir=pr010&sysfilename='+sys_file1; //운영			
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
	<colgroup>
		<col width="120"></col>
		<col width="250"></col>
		<col width="120"></col>
		<col width="*"></col>
	</colgroup>  
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px"  bgcolor="#eeeeee" align="center" class="text">하도계약번호</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_NO_GAHADOCONT" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">발주일자</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="30" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px" width="120px"  bgcolor="#eeeeee" align="center" class="text">현장명</td>
				<td  height="25px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<input id="txt_DS_SITE" type="text" class="textbox2"  size="30" style="height:19px" readonly>
			
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">과세비율</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_TY_TAX" type="text" class="textbox2"  size="3" style="height:19px" readonly>&nbsp;&nbsp;(
					<input id="txt_RT_TAX" type="text" class="textbox2"  size="6" style="height:19px" readonly>%&nbsp;)	
				</td>				
			</tr>
			<tr>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">외주공사명</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_HADOCONT" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">공사기간</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<object  id=txt_DT_FROM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
										<param name=Format				value="####-##-##">										
					</object>	
					&nbsp; ~ &nbsp;
					<object  id=txt_DT_TO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
										<param name=Format				value="####-##-##">										
					</object>	
				</td>
			</tr>
			<tr>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">도급금액</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<object  id=txt_AM_TT_DOKUB classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
					</object>				
				</td>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">실행금액</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<object  id=txt_AM_TT_SILHENG classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">												
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
					</object>	
					
					&nbsp; (
					<input id="txt_DAEBI" type="text" class="textbox2"  size="3" style="width:38px;height:19px;'" readonly>		
					% &nbsp; )
				</td>
			</tr>
			<tr>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">특기사항</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center colspan="3">&nbsp;
					<input id="txt_RM_REMARK" type="text" class="textbox2"  size="50" style="width:800px;height:25px;top:5px" readonly >	
				</td>
			</tr>
			<tr>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">첨부파일</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center colspan="4">&nbsp;
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

<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">입찰정보</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">현설예정일</td>
				<td  height="25px"bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_EXPLAIN" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">현설장소</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_AT_SITEEXPLAIN" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">견적제출일</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_BIDMAGAM" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">계약요청일</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_REQCONTRACT" type="text" class="textbox2"  size="30" style="height:19px" readonly>				
				</td>
			</tr>			
		</table>
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">지급조건</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">선급금</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_rqst_no4" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">대금조건</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
		</table>
	</td>
  </tr>
</table>

<!-- 업체추천 -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">업체추천</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='60px' border='1'>
			<param name="DataID"		    		value="ds_default2">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="ViewSummary"       value="0">
			<param name="Format" 				value="
	    		 <C> name='No' 							ID={CurRow}	   			width=20 		align=CENTER	edit=none</C>
	             <C> name='업체명' 						ID='EST_SID'	   			width=200 		align=CENTER	edit=none</C>
	             <C> name='대표자' 						ID='VEND_CD'   			width=100 		align=CENTER	edit=none</C>
	             <C> name='사업자등록번호' 			ID='VEND_NM'    			width=100 		align=CENTER	edit=none</C>
	             <C> name='주)공종명'					ID='TOT_EST_AMT'  		width=200 		align=CENTER	edit=none</C>
	             <C> name='추천사유'					ID='TOT_FN_EST'  		width=320 		align=CENTER	edit=none</C>
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
			  <C> name='결재SID'   ID=AP_M_SID   	               		width=80	align=left 	editlimit=5 show=FALSE edit=none    </C>
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
			  <C> name='결재SID'   ID=AP_M_SID   	               		width=80	align=left 	editlimit=5 show=FALSE edit=none    </C>
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

	 <C>Col=NO_GAHADOCONT 		Ctrl=txt_NO_GAHADOCONT  		Param=value </C>
	 <C>Col=DS_SITE 	 				Ctrl=txt_DS_SITE    					Param=value </C>
	 <C>Col=TY_TAX 	 					Ctrl=txt_TY_TAX    					Param=value </C>	
	 <C>Col=RT_TAX 	 					Ctrl=txt_RT_TAX    					Param=value </C>	  
 	 <C>Col=DS_HADOCONT				Ctrl=txt_DS_HADOCONT  			Param=value </C>
	 <C>Col=DT_FROM 	  				Ctrl=txt_DT_FROM   					Param=text </C>
	 <C>Col=DT_TO 	  					Ctrl=txt_DT_TO   					Param=text </C>
	 <C>Col=DT_REQCONTRACT       Ctrl=txt_DT_REQCONTRACT     	Param=value </C>
	 <C>Col=AM_TT_DOKUB 	    	Ctrl=txt_AM_TT_DOKUB   			Param=text </C>
	 <C>Col=AM_TT_SILHENG 			Ctrl=txt_AM_TT_SILHENG  			Param=text </C>
	 <C>Col=DAEBI 						Ctrl=txt_DAEBI  						Param=value </C>	 
	 <C>Col=RM_REMARK					Ctrl=txt_RM_REMARK					Param=value </C>	 
	 <C>Col=DT_EXPLAIN 				Ctrl=txt_DT_EXPLAIN  				Param=value </C>
	 <C>Col=AT_SITEEXPLAIN			Ctrl=txt_AT_SITEEXPLAIN 			Param=value </C>	 
	 <C>Col=DT_BIDMAGAM          	Ctrl=txt_DT_BIDMAGAM        		Param=value </C>
	 <C>Col=REAL_FILE 					Ctrl=txt_real_file	  					Param=value </C>
	 <C>Col=SYS_FILE 					Ctrl=txt_sys_file  						Param=value </C>	 
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>