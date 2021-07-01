<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 기본로임등록
+ 프로그램ID : ks_em040i.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2008.10.14
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em040_S1.java, KS_Em040_t1.java
----------------------------------------------------------------------------------*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());		
%>
<!-- HTML 시작-->
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>
	<script language="javascript">
	
	get_cookdata();
	
	//로컬에서 사용하기 위해 임의로 막음.
	/*
	var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7);
	var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	
	var gs_date ='<%=firstday%>';
	
	var year_date =gs_date.substring(0,6);	

	
	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!
		
			ln_before();//선조회
			
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			
		}


/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em040_S1"	
	                         		+ "?v_str1=" + gcem_att_yymm.Text;			                         			

									 						
	gcds_data.Reset();


}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){	

  	ln_SetDataHeader();
  
  	gcem_att_yymm.text = year_date;

	
}


/*----------------------------------------------------------------------------
	Description : 저장
----------------------------------------------------------------------------*/
function ln_Save(){

  if(!ln_Save_Chk()) return;

	if (gcds_data.IsUpdated) {
		
		if (confirm("새로운 정보를 저장하시겠습니까?")){
		
			gctr_data.KeyValue = "KS_Em040_t1(I:USER=gcds_data)";
			
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em040_t1?";
			
			gctr_data.Parameters = "v_str1="+gusrid +","+ "v_str2="+gcem_att_yymm.text;
			
			//prompt('',gcds_data.dataID);
			
			gctr_data.post();
		}
	}
}

/*----------------------------------------------------------------------------
	Description : 저장시 체크 
----------------------------------------------------------------------------*/
function ln_Save_Chk(){


	for(i=1;i<=gcds_data.countrow;i++){



		}


	return true;
	
}




/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader(){

	if (gcds_data.countrow<1){
	
		var s_temp = " ATT_YM:STRING(8),"
							 
							 + " P_GB:STRING(1), D_PAY:DECIMAL(10),T_PAY:DECIMAL(10),"							 
							 
							 + " START_DT:STRING(8), END_DT:STRING(8)";
							 
		gcds_data.SetDataHeader(s_temp);
		
	}
	
}


/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_Start_Load(){

	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
    document.all.LowerFrame.style.visibility="visible";
    
}


/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_End_Load(row,cnt){

	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	eval(cnt).innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
}
</script>


<%
/*=============================================================================
				Developer Java Script 끝
=============================================================================*/
%>
    

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공-TR1
	%>
	
	<script language="javascript" for="gctr_data" event="onsuccess()">
		 alert("저장에 성공하였습니다");
	</script>
	
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
	%>
	
	<script language="javascript" for="gctr_data" event="onfail()">
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ln_Start_Load()
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>	
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>



<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">		
			                <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
			                <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				 <table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					 <tr>
						<td bgcolor="#eeeeee" align="center" width="120">기준년월</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
							              <OBJECT id=gcem_att_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
							              <param name=Alignment			value=0>
							              <param name=Border	      value=true>
							              <param name=Format	      value="YYYY/MM">
							              <param name=PromptChar	  value="_">
							              </OBJECT><%=HDConstant.COMMENT_END%>
              								<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;top:2px;cursor:hand" onclick="__GetCallMonth('gcem_att_yymm', 'Text');">
		 						</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td valign="top" bgcolor="#FFFFFF"><br>
		        <table cellpadding=0 cellspacing=1 style="width:829px;height:390px;" bgcolor="">
							<tr>
								<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
									<%=HDConstant.COMMENT_START%>
									<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
									<PARAM NAME="DataID"			VALUE="gcds_data">
									<PARAM NAME="BorderStyle" VALUE="0">
									<PARAM NAME="Indwidth"		VALUE="0">
									<PARAM NAME="Fillarea"		VALUE="true">
									<PARAM NAME="Colsizing"		VALUE="true">
									<PARAM NAME="TitleHeight"	VALUE=20>
									<param name="sortview"    value=left>
									<param name=MultiRowSelect	value=true>
									<param name=Editable      value="true">
									<param name=UsingOneClick  value="1">
									<PARAM NAME="Format"			VALUE="  
						                <F> Name=NO			 	ID={CurRow}   HeadAlign=Center   HeadBgColor=#B9D4DC   Width=28,  align=center  edit=none</F> 
						                <FC>Name=구분,    	 	ID=P_GB ,  width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center  edit=none </FC>								
										<FC>Name=일로임,		 ID=D_PAY   ,	width=150,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center </FC>
										<FC>Name=시간로임,	 ID=T_PAY   ,	width=150,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center </FC>
						                <FC>Name=사용기간,  	 ID=START_DT ,  	width=190,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none mask='XXXX/XX/XX' </FC>
						                <FC>Name=사용기간,  	 ID=END_DT ,  	width=190,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none mask='XXXX/XX/XX' </FC>
									">
									</OBJECT><%=HDConstant.COMMENT_END%>
								<fieldset style="width:829;height:20px;border:1 solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
									&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
								</fieldset>
						</td>																			
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>


