<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재기안 :자재청구
 * 프로그램ID 	: pu010h
 * J  S  P	    	: pu010h.jsp
 * 서 블 릿		: pu010hs
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-12-08
 * [ 수정일자 ][수정자] 내용
 * 
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
     
    //alert("g_WinParam::"+g_WinParam);
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
		                       + ",v_rqst_sid="+g_WinParam[1];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT=ds_default)",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
		      // 품목
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                       + ",v_rqst_sid="+g_WinParam[1];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT9=ds_default9 )",  param);
				    // prompt('',ds_default.dataid);   
				     tr_post(tr1);
		     
		     if(strAppline_gb=="1"){
			     //결재선 조회 
			     
			    sp0.style.display = "";
				sp1.style.display = "none";
				
				
				if(0[4]==""||0[4]=="undefined"||array2[4]=="undefined"||array2[4]==""){ //결재선을 안만든 경우 
					
					 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                     + ",v_empno1="+array2[3]
				                     + ",v_empno2="+array3[3]
				                     + ",v_empno3="+array4[3]
				                     + ",v_empno4="+array5[3];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
				     tr_post(tr1);
					
				}else {                //결재선을 만든 경우 
			     
				    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                     + ",v_sid="+array2[4];
				 	//alert(param);
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu010H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
				     tr_post(tr1);
				}
		    }else if(strAppline_gb=="2"){
		    
		        sp0.style.display = "none";
				sp1.style.display = "";
		        // alert("g_WinParam[3]::"+g_WinParam[3]+"::");
		    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",dsType=1"
			          + ",s_ap_m_sid="+g_WinParam[3]
			          + ",s_ap_gu=1"; 
		         ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H", "JSP(O:AP_LINE_DS=ds_default2)",  param);
		         tr_post(tr1);
		    }
		}
		
		
		// 상신
		function fnApply_1() {
		   var app_row="";
		
		   //데이터 셋헤드 설정 
		   
		   fnSetHeader();
		   ds_approve.addrow();
		   
		   app_row = ds_approve.rowposition;
		   //alert(g_WinParam[1]);
		   ds_approve.namevalue(app_row,"DOC_SID") = g_WinParam[1]; //등록번호//배포번호//수신열람번호
		   ds_approve.namevalue(app_row,"DOC_GU") = "30";  //구매
		   ds_approve.namevalue(app_row,"DOC_GU2") = g_WinParam[0]; // ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의)
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
			alert("반송 작업중입니다.");
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
			//fnHideLoading();
			//if (row>0){
			//	txt_reg_dat.value=ds_default.namevalue(row,"REG_DAT").substring(0,16);	
			//}
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
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-APPROVE_TYPE">
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
   /**
    alert("pS_YN::::::"+msgDS.namevalue(1,"pS_YN"));
    alert("pMsg::::::"+msgDS.namevalue(1,"pMsg"));
	
	if(msgDS.namevalue(1,"pS_YN")=="Y"){
		alert("::::::"+msgDS.namevalue(1,"pMsg"));
	}
	**/
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
	<td height=25 width=700>

		<table width="700px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">청구SID</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_sid" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">청구번호</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_no" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업상태</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_status" type="text" class="textbox2"  size="18" style="height:19px" maxLength="10" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">청구일자</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">사용처</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_use" type="text" class="textbox2"  style="height:19px" size="18" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">현장SID</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_site_sid" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">현장코드</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_pu_site_cd" type="text" class="textbox2"  size="10" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">현장담당자사번</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom >&nbsp;
					<input id="txt_pu_empno" type="text" class="textbox2"  size="10" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">현장명</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_site_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
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
	<td height=25 width=700 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='260px' border='1'>
			<param name="DataID"		    value="ds_default9">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='순번'     	    ID=CurRow   	        width=30	    align=center  show=true edit=none Value={CurRow}</ </C>
              <C> name='RQST_SID' 	ID='RQST_SID'   		width=40 		align=CENTER  show=true edit=none 	 </C>
              <C> name='ITEM_SID' 	ID='ITEM_SID'   		width=40 		align=CENTER  show=true edit=none 	 </C>
              <C> name='품명' 			ID='ITEM_NM'    		width=150 	align=CENTER  show=true edit=none 	 </C>
              <C> name='규격' 			ID='ITEM_SIZE'   		width=80 		align=CENTER  show=true edit=none 	 </C>
              <C> name='단위' 			ID='ITEM_UNIT'   		width=80 		align=CENTER  show=true edit=none 	 </C>
              <C> name='수량' 			ID='RQST_CNT'   		width=60 		align=CENTER  show=true edit=none  </C>
              <C> name='용도' 			ID='RQST_USE'    	width=150 	align=CENTER  show=true edit=none 	 </C>
              <C> name='소요일' 		ID='DATE_USE'    	width=80 		align=CENTER  show=true edit=none 	 </C>
              <C> name='비고' 			ID='RQST_NOTE'    	width=150 	align=LEFT	    show=true edit=none 	 </C>
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
	    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"	        align=right	style="cursor:hand;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    </span>
	    <span id=sp1 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"	align=right	style="cursor:hand;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:hand;position:relative;left:0px;top:0px" onClick="fnApply_3();">
	     </span>
	</td>
  </tr>
  <tr>
	<td height=25 width=700 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='100px' border='1'>
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
              <C> name='부서'    	ID=DEPTNM	   	                   width=90 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='의견'	    ID=AP_DESC     		           width=100	align=center editlimit=14 show=true edit=none</C>
              <C> name='결재일시'	ID=U_DATE			               width=209 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width=700 align=center>
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
	 <C>Col=RQST_STATUS 	Ctrl=txt_rqst_status  	Param=value </C>
	 <C>Col=RQST_DATE 	  	Ctrl=txt_rqst_date     Param=value </C>
	 <C>Col=RQST_USE       	Ctrl=txt_rqst_use      Param=value </C>
	 <C>Col=SITE_SID          	Ctrl=txt_site_sid        Param=value </C>
	 <C>Col=PU_SITE_CD 	    Ctrl=txt_pu_site_cd   Param=value </C>
	 <C>Col=PU_EMPNO 		Ctrl=txt_pu_empno  	Param=value </C>
	 <C>Col=SITE_NM 			Ctrl=txt_site_nm  		Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>