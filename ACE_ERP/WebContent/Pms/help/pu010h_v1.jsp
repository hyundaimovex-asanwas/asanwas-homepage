<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 기안/자재청구 새버전 v1
 * 프로그램ID 	: pu010h_v1
 * J  S  P	   	: Pms/help/pu010h_v1.jsp
 * 서 블 릿		: pu010hs
 * 작 성 자		: 심동현
 * 작 성 일		: 2015-01-08
 * [ 수정일자 ][수정자] 내용
 * [2012-11-16][박경국] ITEM_SEQ 등 수정
 새 결재선 반영하기 함수로 수정 , 저장 쪽도 고쳐야 합니다. 크허..그러면 조회도 (__);
 *****************************************************************************/
%>
<%@ page import="pms.common.*" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid =0;
	//int v_ap_m_sid = HDUtil.nullCheckNum(request.getParameter("ap_m_sid"));
	    //파일리스트 html 만들기
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//값을 불러와서 
		String sys_fileList ="";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>전자결재 - 자재청구</title>
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
	alert(g_WinParam);
	
    var array1= new Array();
	var array2= new Array();
	var array3= new Array();
	var array4= new Array();
	var array5= new Array();
	
	var strAppline_gb=""; //결재선라인 조회 구분 
	alert(g_WinParam[2]);
	
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
		//cfStyleGrid(getObjectFirst("gr_apline_rqst"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		//cfStyleGrid(getObjectFirst("gr_RcpDpt2"), "comn");
		fnSelect();//청구 정보 조회
		fnSetApline(g_WinParam[2]);//결재선 세팅
	}

		// 메인 조회
		function fnSelect() {
			
			//기본사항 조회 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_rqst_sid="+g_WinParam[1];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT=ds_default)",  param);
		     //prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
		     //alert(ds_default.countrow+":::"+ds_default.namevalue(ds_default.rowposition,"RQST_DATE"));
		     
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
		     
		      // 품목
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                       + ",v_rqst_sid="+g_WinParam[1];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT9=ds_default9 )",  param);
				    // prompt('',ds_default.dataid);   
				     tr_post(tr1);
		     /*
		     if(strAppline_gb=="1"){
			     //결재선 조회 
			     
			    sp0.style.display = "";
				sp1.style.display = "none";
				
				
				if(0[4]==""||0[4]=="undefined"||array2[4]=="undefined"||array2[4]==""){ //결재선을 안만든 경우 
					
					 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=5"
				                     + ",v_empno1="+array2[3]
				                     + ",v_empno2="+array3[3]
				                     + ",v_empno3="+array4[3]
				                     + ",v_empno4="+array5[3];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
				     tr_post(tr1);
					
				}else {                //결재선을 만든 경우 
			     
				    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
				                     + ",v_sid="+array2[4];
				 	//alert(param);
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
				     tr_post(tr1);
				}
		    }else if(strAppline_gb=="2"){
		    
		        sp0.style.display = "none";
				sp1.style.display = "";
		         //alert("g_WinParam[3]::"+g_WinParam[3]+"::");
		    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",dsType=1"
			          + ",s_ap_m_sid="+g_WinParam[3]
			          + ",s_ap_gu=1"; 
		         ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H", "JSP(O:AP_LINE_DS=ds_default2)",  param);
		         tr_post(tr1);
		    }*/
		}

		//결재선 세팅
		function fnSetApline(val){
			//alert("받아온 결재선="+val);
			var apline_tot = new Array();
			var apline_row = new Array();

			if(val!=""){
				ds_apline.clearData();	//먼저 지우고
				
				apline_tot=val.split(";");	// 결재선 행별로 나눔
				//alert("실제 결재선 행 + 1개 == "+apline_tot.length);	// 1행이면 2 리턴.. ;가 마지막에 들어가 있으니
				for(i=1;i<apline_tot.length;i++){
					apline_row = apline_tot[i-1].split("/");  // 1행부터
					/*
					alert(apline_row.length);	//
					alert("기본결재선(1) : " + apline_row[0]);	//
					alert("순번 : " + apline_row[1]);	//
					alert("결재유형 : " + apline_row[2]);	//
					alert("사번 : " + apline_row[3]);	//
					alert("이름 : " + apline_row[4]);	//
					alert("직위 : " + apline_row[5]);	//
					alert("부서 : " + apline_row[6]);	//
					alert("내 결재선 SID : " + apline_row[7]);	//
					*/
					
					ds_apline.AddRow();
					ds_apline.NameValue(i, "SEQ") 				= apline_row[1];//순번
					ds_apline.NameValue(i, "AP_TYPE") 			= apline_row[2];//결재유형
					ds_apline.NameValue(i, "ENO_NO")			= apline_row[3];//사번
					ds_apline.NameValue(i, "ENO_NM") 			= apline_row[4];//이름
					ds_apline.NameValue(i, "JOB_NM") 			= apline_row[5];//직위
					ds_apline.NameValue(i, "DPT_NM") 			= apline_row[6];//부서
					if(apline_row[1]==1){
						ds_apline.NameValue(i, "AP_STATUS_D") 	= "2";	//==상신
						
					}else{
						ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==미결
					};
					ds_apline.NameValue(i, "U_DATE") 			= "";
					ds_apline.NameValue(i, "AP_DESC") 			= "";
				}
			}else{
				/*
		    	v_job="S_AP";
		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					+ ",v_dwr_sid=<%//=v_dwr_sid%>"
					+ ",v_ap_m_sid=<%//=v_ap_m_sid%>"	//결재선sid
					;
				
				//이 결재선 조회도 Ap200I.java로 옮기는게 맞을 듯.. -_-
		        ln_TRSetting(tr1, 
		        	"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",	
		            "JSP(O:DS_APLINE=ds_apline)",
		            param);
		        tr_post(tr1);*/
			}
		} 		
		
		
		// 상신
		function fnApply_1() {
			//alert("fnApply_1");
		   var app_row="";
		
		   //데이터 셋헤드 설정 
		   
		   fnSetHeader();
		   ds_approve.addrow();
		   
		   app_row = ds_approve.rowposition;
		   //alert(g_WinParam[1]);
		   ds_approve.namevalue(app_row,"DOC_SID") = g_WinParam[1]; //등록번호//배포번호//수신열람번호
		   ds_approve.namevalue(app_row,"DOC_GU") = "30";  //구매
		   ds_approve.namevalue(app_row,"DOC_GU2") = g_WinParam[0]; // ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의,340 구매검수)
		   ds_approve.namevalue(app_row,"AP_GU_1") = array2[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_1") = array2[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_1") = array2[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_1") = array2[3];
		   ds_approve.namevalue(app_row,"AP_GU_2") = array3[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_2") = array3[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_2") = array3[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_2") = array3[3];
		   ds_approve.namevalue(app_row,"AP_GU_3") = array4[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_3") = array4[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_3") = array4[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_3") = array4[3];
		   ds_approve.namevalue(app_row,"AP_GU_4") = array5[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_4") = array5[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_4") = array5[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_4") = array5[3];
		   ds_approve.namevalue(app_row,"AP_STATUS_M") = "2"; //승인진행
		   //prompt('',ds_approve.text);
    
		    ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(I:DS_APPROVE=ds_approve,O:msgDS=msgDS)", "proType=A, dsType=1");
	        tr_post(tr3);
		}
		

		// 상신 데이터 셋헤드 설정 
		function fnSetHeader() {
			var Theader = "DOC_SID:DECIMAL(10.0),DOC_GU:STRING(10),DOC_GU2:STRING(10),"
			    				+ "AP_GU_1:STRING(10),AP_SEQ_1:DECIMAL(10.0),AP_TYPE_1:STRING(10),AP_EMPNO_1:STRING(10),"
								+ "AP_GU_2:STRING(10),AP_SEQ_2:DECIMAL(10.0),AP_TYPE_2:STRING(10),AP_EMPNO_2:STRING(10),"
								+ "AP_GU_3:STRING(10),AP_SEQ_3:DECIMAL(10.0),AP_TYPE_3:STRING(10),AP_EMPNO_3:STRING(10),"
								+ "AP_GU_4:STRING(10),AP_SEQ_4:DECIMAL(10.0),AP_TYPE_4:STRING(10),AP_EMPNO_4:STRING(10),"
								+ "AP_STATUS_M:STRING(1)"; 
			ds_approve.SetDataHeader(Theader);
		}
		
		
		
		// 반송  
		function fnApply_2(){
			var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
 											+ ",s_ap_m_sid="+g_WinParam[3]
 											+ ",sEmpNo="+gusrid
										    + ",sApDesc=" + ds_default2.namevalue(ds_default2.rowposition,"AP_DESC") 
								            + ",sEmpNmk="+gusrnm;
			//alert(param);								            
		    ln_TRSetting(tr4,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H_01","JSP(I:AP_LINE_DS=ds_default2, O:msgDS=msgDS)", param);
	        tr_post(tr4); 


		}
		
			// 승인  
		function fnApply_3(){
			var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
 											+ ",s_ap_m_sid="+g_WinParam[3]
 											+ ",sEmpNo="+gusrid
								            + ",sEmpNmk="+gusrnm;
		    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H","JSP(I:AP_LINE_DS=ds_default2, O:msgDS=msgDS)", param);
	        tr_post(tr2); 
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
		<script language=JavaScript  for=ds_default event="OnLoadStarted()" >
			//fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds_default event="OnLoadCompleted(row,colid)">
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds_default event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";

			//fnHideLoading();
		</script>
		
<!-----------------------------------------------------------------------------
	DataSet Components 선언 
	# 조회를 할 경우 사용한다. 
------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%>

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id="ds_approve" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
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

<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
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


<script language=JavaScript for=tr1 event=OnSuccess()>
</script>

<script language=JavaScript for=tr4 event=OnSuccess()>
	alert("정상적으로 반려처리 되었습니다.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

<script language=JavaScript for=tr4 event=OnFail()>
	alert("Error Code : " + tr4.ErrorCode + "\n" + "Error Message : " + tr4.ErrorMsg + "\n");
</script>

<script language=JavaScript for=tr3 event=OnSuccess()>
	alert("정상적으로 상신처리 되었습니다.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

<script language=JavaScript for=tr3 event=OnFail()>
	alert("Error Code : " + tr3.ErrorCode + "\n" + "Error Message : " + tr3.ErrorMsg + "\n");
</script>


<script language=JavaScript for=tr2 event=OnSuccess()>
	alert("정상적으로 승인처리 되었습니다.");
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


<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=15> </td>
  </tr>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">기본사항</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=850>

		<table width="850px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">청구번호</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_no" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">청구일자</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">현장명</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_site_nm" type="text" class="textbox2"  size="28" style="height:19px" readonly>
				</td>
                <td height="25px"  bgcolor="#eeeeee" align=center class="text">투입창고</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_put_wh" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">특이사항</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
                    <input type="text" name='txt_rqst_memo' id="txt_rqst_memo" style="width:650px;" class='textbox2'   readOnly="readonly">
                </td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">첨부파일</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
                    <input type="text" name='txt_real_file' id="txt_real_file" style="width:450px;" class='textbox2'   readOnly="readonly">
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

<!-- 결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">품목</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=850 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='850px' height='400px' border='1'>
			<param name="DataID"		    value="ds_default9">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="ViewSummary"       value="1">
			<param name="Format" 			value="
             <C> name='RQST_SID' 	ID='RQST_SID'   		width=40 		align=CENTER	edit=none show=false</C>
             <C> name='ITEM_SID' 	ID='ITEM_SID'   		width=40 		align=CENTER	edit=none show=false</C>
             <C> name='순번' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
             <C> name='품명' 		ID='ITEM_NM'    		width=150 	align=CENTER	 editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
             <C> name='규격' 		ID='ITEM_SIZE'   		width=80 		align=CENTER	 </C>
             <C> name='단위' 		ID='ITEM_UNIT'   		width=80 		align=CENTER	  </C>
            <G> name='도급'
             <C> name='수량' 		ID='DG_CNT'   		width=45 		align=right decao=2	</C>
             <C> name='단가'    	ID='DG_AMT'    	    width=85 		align=right	 show=true decao=0	sumtext='총'  sumtextalign='right' </C>
             <C> name='금액(자동)'  ID='DG_SUM_AMT'   width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
            </G>
            <G> name='예산'
             <C> name='수량' 		ID='RQST_CNT'   	width=45 		align=right	 decao=2	</C>
             <C> name='단가' 		ID='YS_AMT'   			width=85 		align=right	 decao=0 sumtext='원'  sumtextalign='left'</C>
             <C> name='금액(자동)'  ID='YS_SUM_AMT'    width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
            </G>
             <C> name='용도' 		ID='RQST_USE'    	width=150 	align=CENTER	 show=false</C>
             <C> name='소요일' 		ID='DATE_USE'    	width=80 		align=CENTER	 EditStyle=popup sumtext='원'  sumtextalign='left'</C>
             <C> name='비고' 		ID='RQST_NOTE'    	width=150 		align=LEFT	 	 </C>



			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<!-- 결재 / [결재|참조|시행] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">결재선</font>
	</td>
	<td height=30  align ="right">
	  	
		<span id=sp0 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"	        align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    </span>
	    <span id=sp1 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_3();">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"	align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	     </span>
	</td>
  </tr>
  <tr>
	<td height=25 width=850 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='850px' height='120px' border='1'>
			<param name="DataID"		    value="ds_default2">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='결재SID'   ID='ap_m_sid'   	               width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='구분'     	ID=AP_TYPE_NM          	   width=55	align=center editlimit=50 show=true edit=none</C>
              <C> name='결재자'    	ID=EMPNMK		   	               width=69 	align=center editlimit=50 show=true edit=none</C>
              <C> name='사번'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='직위'		ID=PAYGRD  		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='부서'    	ID=DEPTNM	   	                   width=200 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='의견'	    ID=AP_DESC     		           width=150	align=center editlimit=200 show=true edit=true</C>
              <C> name='결재일시'	ID=U_DATE			               width=200 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width=850 align=center>
  <tr>
	<td>
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
	<param name=DataID    value=ds_default>
	<param name=BindInfo  value='  
	 <C>Col=RQST_SID	 	 	Ctrl=txt_rqst_sid    	Param=value </C>
	 <C>Col=RQST_NO 	  		Ctrl=txt_rqst_no     	Param=value </C>
	 <C>Col=RQST_MEMO		Ctrl=txt_rqst_memo  	Param=value </C>	 
	 <C>Col=RQST_STATUS 	Ctrl=txt_rqst_status  	Param=value </C>
	 <C>Col=RQST_STATUS_NM 	Ctrl=txt_rqst_status_nm  	Param=value </C>
	 <C>Col=RQST_DATE 	  	Ctrl=txt_rqst_date     Param=value </C>
	 <C>Col=RQST_USE       	Ctrl=txt_rqst_use      Param=value </C>
	 <C>Col=SITE_SID          	Ctrl=txt_site_sid        Param=value </C>
	 <C>Col=PU_SITE_CD 	    Ctrl=txt_pu_site_cd   Param=value </C>
	 <C>Col=PU_EMPNO 		Ctrl=txt_pu_empno  	Param=value </C>
	 <C>Col=SITE_NM 			Ctrl=txt_site_nm  		Param=value </C>
	 <C>Col=REAL_FILE 			Ctrl=txt_real_file	  	Param=value </C>
	 <C>Col=SYS_FILE 			Ctrl=txt_sys_file  		Param=value </C>	 
	 <C>Col=PUT_WH 			Ctrl=txt_put_wh  		Param=value </C>	 	 
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>