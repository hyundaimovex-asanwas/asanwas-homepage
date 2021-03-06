<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 로임현황
+ 프로그램ID : ks_em043s.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈  
+ 작성일자 : 2008.10.14
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em043_S1.java
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
	var gs_date = gcurdate;
	var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+"01";
    var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
    */
    
      var gs_date = '<%=firstday%>';
      
	  var yymmdd = gs_date.substring(0,6);

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!
		
			ln_before();//선조회
			
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

      		gcem_payym.Text = yymmdd;
			
		}


/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em043_S1"
											 + "?v_str1=" + fn_trim(gcem_payym.text) 		  		// 지급월 
											 + "&v_str2=" + fn_trim(gclx_dept_cd.bindcolval)	// 직장      
											 + "&v_str3=" + fn_trim(gclx_cmsosok.bindcolval);	// 근무업체     


  	//prompt('',gcds_data.DataID);
	
	gcds_data.Reset();
	
}

/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){


	//직장  KS006
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";	
	gcds_ks006.Reset();

	//소속팀  KS007
	gcds_cmsosok.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS007";	
	gcds_cmsosok.Reset();

	 ln_SetDataHeader();
	 	
}


/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader(){

	if (gcds_data.countrow<1){
	

		var s_temp = " HOL_DT:STRING(8), EMPNO:STRING(10), EMPNMK:STRING(10),"
		
							 + " DAY_CD:STRING(1), DAY_NM:STRING(5),"
							 
							 + " DEPT_CD:STRING(3), DEPT_NM:STRING(5), HOL_GB:STRING(1)";
							 

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
			Gauce Components Event Scripts 시작
=============================================================================*/
%>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ln_Start_Load()
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts 끝
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
		 alert("작업을 완료 하였습니다");
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

<!-- 직장  -->
<script language="javascript" 	for="gcds_ks006" event="onloadCompleted(row,colid)">
	gcds_ks006.insertrow(1);
	gcds_ks006.namevalue(1,"COM_CODE") = "";
	gcds_ks006.namevalue(1,"COM_SNAME") = "전체";
	gclx_dept_cd.index = 0;
	</script>
	
<!-- 근무현장  -->
<script language="javascript" 	for="gcds_cmsosok" event="onloadCompleted(row,colid)">
	gcds_cmsosok.insertrow(1);
	gcds_cmsosok.namevalue(1,"COM_CODE") = "";
	gcds_cmsosok.namevalue(1,"COM_SNAME") = "전체";
	gclx_cmsosok.index = 0;
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
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 공통코드 -->
<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cmsosok classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>
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
							<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onClick="ln_Print()">
							<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand"  onclick="ln_Query()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
 			          	<td bgcolor="#eeeeee" align="center" width="60">지급월</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
			              <OBJECT id=gcem_payym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
			              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
			              <param name=Alignment			value=0>
			              <param name=Border	      value=true>
			              <param name=Format	      value="YYYY/MM">
			              <param name=PromptChar	  value="_">
			              </OBJECT><%=HDConstant.COMMENT_END%>
			              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;top:2px;cursor:hand" onclick="__GetCallMonth('gcem_payym', 'Text');">
			              </td>
			              <td bgcolor="#eeeeee" align="center" width="60">직장</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_ks006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
				              </td>

							<td align="center" bgcolor="#eeeeee">소속구분</td>
							<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
							<object id="gclx_cmsosok" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" 
							style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 100px">
								<param name="ComboDataID" value="gcds_cmsosok" />
								<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
								<param name="SearchColumn" value="COM_SNAME" />
								<param name="Sort" value="false" />
								<param name="Index" value="0" />
								<param name="ListExprFormat" value="COM_SNAME^0^100" />
								<param name="BindColumn" value="COM_CODE" />
							 </object><%=HDConstant.COMMENT_END%>
							</td>
				       </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:829px;height:370px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:829;height:350px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="Editable"			value=true>
							<PARAM NAME="Colsizing"		VALUE="true">
							<param name=MultiRowSelect	value=true>
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
				                <FC> Name=NO		 ID={CurRow}   HeadAlign=Center   HeadBgColor=#B9D4DC   Width=28,  align=center  edit=none</FC> 
								<FC>Name=직장,       ID=DEPT_CD ,  width=80,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true </FC>
								<FC>Name=업체,   	 ID=VEND_NM ,  width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</FC>
			                <G> name=로임별기준금액    HeadBgColor=#B9D4DC,     
									<C>Name=일,    ID=PAY_GB1,    width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </C>
									<C>Name=일,    ID=PAY_GB2,    width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </C>
									<C>Name=일,    ID=PAY_GB3,  	 width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </C>
									<C>Name=일,    ID=PAY_GB4,    width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </C>
									<C>Name=일,    ID=PAY_GB5,    width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </C>
							</G>
								<C>Name=월로동보수계,  ID=MON_TOTAL_PAY,     width=90,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit= none </C>
								<C>Name=사보료,  	ID=SABO_PAY,   width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   edit= none</C>
								<C>Name=보조금,     ID=SUB_PAY,     width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff,align=left,   edit= none </C>
								<C>Name=총지불액,  ID=TOTAL_PAY,      width=80,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit= none</C>
								<C>Name=인원수, 	 ID=TOT_PEOPLE,      width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit= none</C>
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:829;height:20px;solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- 기본탭 -->
		<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
			<PARAM NAME="DataID"				VALUE="gcds_data">
			<PARAM NAME="ActiveBind"		VALUE="true">
			<PARAM NAME="BindInfo"			VALUE="
			<C>Col=DEPT_CD			Ctrl=gclx_dept_cd				Param=bindcolval</C>
			<C>Col=VEND_CD   			Ctrl=gclx_vend_cd   			Param=bindcolval</C>			
			<C>Col=PAY_GB1,			Ctrl=txt_job_nm      		  		Param=Text</C>
			<C>Col=PAY_GB2,			Ctrl=gcem_m_day      		  	Param=Text</C>
			<C>Col=PAY_GB3,			Ctrl=gcem_d_day      		  	Param=Text</C>
			<C>Col=PAY_GB4,			Ctrl=gcem_t_day      		 	Param=Text</C>
			<C>Col=PAY_GB5,			Ctrl=txt_w_day      		  		Param=Text</C>
			<C>Col=MON_TOTAL_PAY,	Ctrl=txt_m_total_pay      	Param=Text</C>
			<C>Col=SABO_PAY,			Ctrl=txt_sabo_pay      		  	Param=Text</C>
			<C>Col=SUB_PAY,			Ctrl=txt_sub_pay      		  	Param=Text</C>
			<C>Col=TOTAL_PAY,		Ctrl=txt_m_total_pay      		Param=Text</C>
			<C>Col=TOT_PEOPLE,		Ctrl=txt_m_total_pay      		Param=Text</C>
			">
		</OBJECT><%=HDConstant.COMMENT_END%>
	</table> 
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>