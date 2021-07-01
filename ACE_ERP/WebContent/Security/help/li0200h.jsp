<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 배포기안 :
 * 프로그램ID 	: li0200h
 * J  S  P	    	: li0200h.jsp
 * 서 블 릿		: li0200hs
 * 작 성 자		: 정영식
 * 작 성 일		: 2010-11-01
 * [ 수정일자 ][수정자] 내용
 * 
 *
 *						
 *****************************************************************************/
%>
<%@ page import="security.common.*" %>
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
		<title></title>
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
	
	if(g_WinParam[0]=="020"){
	    document.title ="전자결재 - 배포";
	}else if (g_WinParam[0]=="040"){
	    document.title ="전자결재 - 열람";
	}
		
	// 페이지 로딩
	  function fnOnLoad(){

			fnSelect();
		
	  }

		// 메인 조회
		function fnSelect() {
		
				if(g_WinParam[0]=="020"||g_WinParam[0]=="040"){   
				
					//배포 
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                       + ",v_dtb_mag_sid="+g_WinParam[1];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT3=ds_default)",  param);
				     //prompt('',param);   
				     tr_post(tr1);
				     
				     //수신부서  
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                       + ",v_dtb_mag_sid="+g_WinParam[1];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT9=ds_default9 )",  param);
				    // prompt('',ds_default.dataid);   
				     tr_post(tr1);
				
			     
				    //결재선 조회 
				    if(strAppline_gb=="1"){ //상신 
				    
				        sp0.style.display = "";
					    sp1.style.display = "none";
					    
					    if(array2[4]==""){ //결재선을 안만든 경우 
							 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						                     + ",v_empno1="+array2[3]
						                     + ",v_empno2="+array3[3]
						                     + ",v_empno3="+array4[3]
						                     + ",v_empno4="+array5[3];
						     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
						     tr_post(tr1);
						}else {                //결재선을 만든 경우 
					   
						    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						                       + ",v_sid="+array2[4];
						     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
						    // prompt('',ds_default.dataid);   
						     tr_post(tr1);
						}
					 }else if (strAppline_gb=="2"){//승인
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
		}
		
		/******************************************************************************
		// 상신
		*******************************************************************************/
		function fnApply_1() {
		   var app_row="";
		
		   //데이터 셋헤드 설정 
		   
		   fnSetHeader();
		   ds_approve.addrow();
		   
		   app_row = ds_approve.rowposition;
		   
		   ds_approve.namevalue(app_row,"DOC_SID") = g_WinParam[1]; //등록번호//배포번호//수신열람번호
		   ds_approve.namevalue(app_row,"DOC_GU") = "00";  //정보
		   ds_approve.namevalue(app_row,"DOC_GU2") = g_WinParam[0]; //문서구분 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 
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
    
           //prompt('ds_approve', ds_approve.text);
		  
			//alert(param);
		    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(I:DS_APPROVE=ds_approve,O:msgDS=msgDS)", "proType=A, dsType=1");
	        tr_post(tr1);
		
		}
		
		/******************************************************************************
		// 상신 데이터 셋헤드 설정 
		*******************************************************************************/
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
 											+ ",s_ap_m_sid="+g_WinParam[3]  //결재SID
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
			
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds_default event="OnLoadCompleted(row,colid)">
			if (row>0){
				if(ds_default.namevalue(row,"SND_DIV")=="3"){
					lbl_dptnm.innerText="수신처";
					gr_RcpDpt.ColumnProp("RCP_DPT_NM","name")="수신처";
				}else{
				    lbl_dptnm.innerText="수신부서";
				    gr_RcpDpt.ColumnProp("RCP_DPT_NM","name")="수신부서";
				}
				txt_reg_dat.value=ds_default.namevalue(row,"REG_DAT").substring(0,16);	
			}
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
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">배포번호</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_dtb_mag_sid" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업상태</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_dtb_sgn_sts_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청일시</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_reg_dat" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">문서등급</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_doc_grd_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">문서형태</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_doc_frm_nm" type="text" class="textbox2"  style="height:19px" size="18" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">소유부서</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_own_dpt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">생산부서</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prd_dpt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">생산자</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prd_psn_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">생산일자</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prd_dat" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>

			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">생성구분</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_crt_div_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">보존년한</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom >&nbsp;
					<input id="txt_prs_yr_lmt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">등록번호</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_doc_mag_sid" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">발신구분</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_snd_div_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">
					<label id=lbl_dptnm  name="lbl_dptnm"></label>
				</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom  colspan=3>&nbsp;
					<input id="txt_rcp_dpts_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">제목</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;
					<input id="txt_doc_tle" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">내용</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;
					<input id="txt_doc_cts" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">키워드</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;
					<input id="txt_doc_kwd" type="text" class="textbox2" size="90" style="height:19px" readonly>
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
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">수신부서</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='60px' border='1'>
			<param name="DataID"		    value="ds_default9">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='순번'     	    ID=CurRow   	        width=30	    align=center  show=true edit=none Value={CurRow}</ </C>
              <C> name='수신부서'    	ID=RCP_DPT_NM      width=635 	align=left        show=true edit=none</C>
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
              <C> name='직위'		ID=PAYGRD   		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='부서'    	ID=DEPTNM	   	                   width=90 	align=center editlimit=16 show=true edit=none</C>
              <C> name='상태'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none </C>
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
	 <C>Col=DTB_MAG_SID	  Ctrl=txt_dtb_mag_sid     Param=value </C>
	 <C>Col=DOC_MAG_SID	  Ctrl=txt_doc_mag_sid    Param=value </C>
	 <C>Col=DOC_GRD_NM 	  Ctrl=txt_doc_grd_nm     Param=value </C>
	 <C>Col=DOC_FRM_NM 	  Ctrl=txt_doc_frm_nm     Param=value </C>
	 <C>Col=OWN_DPT_NM 	  Ctrl=txt_own_dpt_nm     Param=value </C>
	 <C>Col=PRD_DPT_NM 	  Ctrl=txt_prd_dpt_nm      Param=value </C>
	 <C>Col=PRD_PSN_NM      Ctrl=txt_prd_psn_nm     Param=value </C>
	 <C>Col=PRD_DT   	          Ctrl=txt_prd_dat             Param=value </C>
	 <C>Col=CRT_DIV_NM 	      Ctrl=txt_crt_div_nm        Param=value </C>
	 <C>Col=PRS_YR_LMT_NM Ctrl=txt_prs_yr_lmt_nm  Param=value </C>
	 <C>Col=DOC_TLE 	          Ctrl=txt_doc_tle             Param=value </C>
	 <C>Col=DOC_CTS 	          Ctrl=txt_doc_cts            Param=value </C>
	 <C>Col=DOC_KWD 	          Ctrl=txt_doc_kwd           Param=value </C>
	 <C>Col=DTB_SGN_STS_NM      Ctrl=txt_dtb_sgn_sts_nm      Param=value </C>
	 <C>Col=SND_DIV_NM        Ctrl=txt_snd_div_nm      Param=value </C>
	 <C>Col=RCP_DPTS_NM    Ctrl=txt_rcp_dpts_nm     Param=value </C>
	 <C>Col=REG_DAT             Ctrl=txt_reg_dat             Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>      

</body>
<!- BODY END -->
</html>