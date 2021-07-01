<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 로임내역조회
+ 프로그램ID : ks_em042s.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2008.10.14
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em042_S.java
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
	var year_date = gcurdate.substring(2,4);
	var yymmdd = gcurdate.substring(0,7);
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

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em042_S1"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)				//지급월
											 + "&v_str2=" + fn_trim(gclx_dept_cd.bindcolval)	//직장
											 + "&v_str3=" + fn_trim(txt_empno.value)			    //직번
											 + "&v_str4=" + fn_trim(txt_empnmk.value);			    //성명
  //prompt('',gcds_data00.DataID);
  
	gcds_data00.Reset();
	
}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//직장  KS006
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";	
	gcds_ks006.Reset();
	
	}


/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(){//성명조회

  var arrParam	= new Array();
  
	var strURL   = "./ks_com_pop.jsp";
	
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	
	var arrResult = showModalDialog(strURL,window,strPos);
	
	
	if (arrResult != null) {
	
		arrParam = arrResult.split(";");
		
		txt_empno.value = arrParam[0];		
		txt_empnmk.value = arrParam[1];
		
	} else {
	
		txt_empno.value = "";		
		txt_empnmk.value = "";
		
	}
}

</script>


<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공-TR1
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">
		</script>

		<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		document.all.LowerFrame.style.visibility="visible";
		</script>
		<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
		</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>

<!-- 직장  -->
<script language="javascript" 	for="gcds_ks006" event="onloadCompleted(row,colid)">
	gcds_ks006.insertrow(1);
	gcds_ks006.namevalue(1,"COM_CODE") = "";
	gcds_ks006.namevalue(1,"COM_SNAME") = "전체";
	gclx_dept_cd.index = 0;
</script>


<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 공통코드 -->

<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor= ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">
			              <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
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
				              <td bgcolor="#eeeeee" align="center" width="60">성명</td>
										  <td bgcolor="#FFFFFF">
				                <input type="text" id="txt_empnmk" style="position:relative;left:15px;top:-2px;width:100px;" >
				                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:11px;top:2px;cursor:hand" onclick="ln_Find()">
												<input type="text" id="txt_empno" style="position:relative;left:8px;top:-2px;width:60px;" >
				              </td>
				            </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:829px;height:400px;">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111" width="620" height="150">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:620;height:400px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="viewsummary"		VALUE=1>
							<PARAM NAME="TitleHeight"	VALUE=35>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
								<FC> Name=NO		ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC  Width=30,   align=right  SumBgColor=#C3D0DB </FC> 
								<FC>ID=EMPNO,	    	Name=직번,	    width=50px,		align=center,	HeadBgColor=#B9D4DC sort=true	  SumBgColor=#C3D0DB</FC>
								<FC>ID=EMPNMK,		Name=이름,	    width=57px,		align=left,		HeadBgColor=#B9D4DC	sort=true   SumBgColor=#C3D0DB</FC>
								<FC>ID=SEX,			Name=성별,	width=30px,		align=left,		HeadBgColor=#B9D4DC	 SumBgColor=#C3D0DB</FC>
								<FC>ID=BIRTHDAY,		Name=생년월일,	  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false SumBgColor=#C3D0DB</FC>
								<FC>ID=JOB,		    	Name=직종,	  width=60px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</FC>
								<FC>ID=M_PAY,		Name=월로임,	    width=50px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</FC>
								<FC>ID=D_PAY,	  	Name=일로임,	width=50px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</FC>
								<FC>ID=T_PAY,	  	Name=시간로임,	width=50px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</FC>
								<FC>ID=WK_DAY,	  	Name=가동일수,	width=60px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</FC>
								<C>ID=O_H,		  		Name=연장,	  width=40px,		align=left,		HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	</C>
								<C>ID=N1_H,    		Name=야근,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB </C>
								<C>ID=N2_H,			Name=야근,	  width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=H_D,	    		Name=휴일\\근무,	  width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=E_H,				Name=조퇴,	    width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=HOL_1,	 	  	Name=정기\\휴가,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=HOL_2,	  		Name=보조\\휴가,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=HOL_3,	  		Name=보충\\휴가,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=HOL_4,	  		Name=산전\\휴가,	  width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=HOL_5,	  		Name=산후\\휴가,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=B_PAY,	  		Name=기본\\로임,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=X_PAY,			Name=초과\\로임,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=S_PAY,	  		Name=공제\\로임,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=TOT_PAY,	  	Name=로임계,	  width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=HOL_PAY,	  	Name=휴가비,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=M_TOT_PAY,	  	Name=월로\\임계,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=SABO_PAY,	  	Name=사보료,	  width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
								<C>ID=SUB_PAY,	  	Name=보조금,	width=40px,		align=left,		HeadBgColor=#B9D4DC	SumBgColor=#C3D0DB</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:620;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
                &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
						</td>
						<td>
							<table border="0" cellpadding="0" cellspacing="1" width="202px" bgcolor="#b5b5b5">
									<tr height="25">
										<td align="center"  bgcolor="#eeeeee">지급월 </td>
										<td bgcolor="#FFFFFF">
											<%=HDConstant.COMMENT_START%>
											<OBJECT id=gcem_payym2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="g_input1" style="position:relative;width:50px;left:0px;">
						                    <param name=Alignment			value=0>
						                    <param name=Border	      value=true>
						                    <param name=Format	      value="YYYY/MM">
						                    <param name=PromptChar	  value="_">
											  <param name=ReadOnly      value="true">
											</OBJECT>
											<%=HDConstant.COMMENT_END%>
										</td>
		
										<td  align="center" bgcolor="#eeeeee" >지급일 </td>
										<td bgcolor="#FFFFFF" >
						                  <%=HDConstant.COMMENT_START%>
						                  <OBJECT id=gcem_paydt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						                  style="position:relative; left:0px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
						                  <param name=Alignment			value=0>
						                  <param name=Border	      value=true>
						                  <param name=Format	      value="YYYY/MM">
						                  <param name=PromptChar	  value="_">
											<param name=ReadOnly      value="true">
						                  </OBJECT><%=HDConstant.COMMENT_END%>
										</td>								
									</tr>
									<tr height="25">								
										<td  align="center" bgcolor="#eeeeee" >직번</td>
										<td bgcolor="#FFFFFF">
											<input type="text" id="txt_empno2" style="position:relative;;left:0px;width:50px;" readonly>
										</td>
										<td  align="center" bgcolor="#eeeeee" >성명</td>
										<td bgcolor="#FFFFFF">
											<input type="text" id="txt_empnmk2" style="position:relative;;left:0px;width:50px;" readonly>
										</td>
									</tr>
									<tr height="25">	
										<td  align="center" bgcolor="#eeeeee" >입사일 </td>
										<td bgcolor="#FFFFFF">
						                  <%=HDConstant.COMMENT_START%>
						                  <OBJECT id=gcem_stdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						                  style="position:relative; left:0px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
						                  <param name=Alignment			value=0>
						                  <param name=Border	      value=true>
						                  <param name=Format	      value="YY/MM/DD">
						                  <param name=PromptChar	  value="_">
										  <param name=ReadOnly      value="true">
						                  </OBJECT><%=HDConstant.COMMENT_END%>
										</td>
										<td  align="center" bgcolor="#eeeeee">퇴사일 </td>
										<td bgcolor="#FFFFFF">
						                  <%=HDConstant.COMMENT_START%>
						                  <OBJECT id=gcem_eddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						                  style="position:relative; left:0px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
						                  <param name=Alignment			value=0>
						                  <param name=Border	      value=true>
						                  <param name=Format	      value="YY/MM/DD">
						                  <param name=PromptChar	  value="_">
										  <param name=ReadOnly      value="true">
						                  </OBJECT><%=HDConstant.COMMENT_END%>
										</td>
		
									</tr>
									<tr height="25">
									 <td  align="center" bgcolor="#eeeeee" >소속 </td>
										<td bgcolor="#FFFFFF" >
												<input type="text" id="txt_dept_nm" class="txt11" style="position: relative; left: 0px; width: 50px" readonly>
										</td>
									 <td  align="center" bgcolor="#eeeeee" >직종 </td>
										<td bgcolor="#FFFFFF" >
												<input type="text" id="txt_job_nm" class="txt11" style="position: relative; left: 0px; width: 50px" readonly>
										</td>
									</tr>
									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
		
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="2"><B>로동항목 </B></td>
										<td bgcolor="#FFFFFF" colspan="2">
										</td>
									</tr>
		
									<tr height="25">
									
										<td  align="center" bgcolor="#eeeeee">가동일수</td>
										<td bgcolor="#FFFFFF">
											<input type="text" id="txt_w_day" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										
										<td  align="center" bgcolor="#eeeeee">연장시간</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_over_time" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
									</tr>
		
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee">야간시간</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_night_time" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										<td  align="center" bgcolor="#eeeeee">야간시간</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_night_time2" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee">휴일근무</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_hol_work" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										<td  align="center" bgcolor="#eeeeee">조퇴시간</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_early_time" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee">정기휴가</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_holiday1" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										<td  align="center" bgcolor="#eeeeee">보조휴가</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_holiday2" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
									</tr>							
									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee"><B>로임</B></td>
										<td bgcolor="#FFFFFF">
										</td>
										<td  align="center" bgcolor="#eeeeee"><B>로임계</B></td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_total_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>								
									</tr>
									<tr height="25">							
										<td  align="center" bgcolor="#eeeeee">기본로임</td>
										<td bgcolor="#FFFFFF">
											<input type="text" id="txt_b_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>								
										<td  align="center" bgcolor="#eeeeee">초과로임</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_x_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee">공제로임</td>
										<td bgcolor="#FFFFFF" >
		                  					<input type="text" id="txt_s_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										<td bgcolor="#FFFFFF" colspan = "2"  ></td>
		
									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
		
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee"><B>기타</B></td>
										<td bgcolor="#FFFFFF">
										</td>
		
										<td  align="center" bgcolor="#eeeeee"><B>기타계</B></td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_etc_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>								
									</tr>
		
									<tr height="25">							
										<td  align="center" bgcolor="#eeeeee">휴가비</td>
										<td bgcolor="#FFFFFF">
											<input type="text" id="txt_hol_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										
										<td  align="center" bgcolor="#eeeeee">사보료</td>
										<td bgcolor="#FFFFFF">
		                  					<input type="text" id="txt_sabo_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
									</tr>
		
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee">보조금</td>
										<td bgcolor="#FFFFFF" >
		                  					<input type="text" id="txt_sub_pay" style="position:relative;left:0px;width:50px;text-align:right;" readonly>
										</td>
										<td bgcolor="#FFFFFF" colspan = "2"  ></td>
									</tr>
									
									
									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
		
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan = "2" >총지불액</td>
										<td bgcolor="#FFFFFF" colspan = "2"  ></td>
									</tr>
								</td>
							</tr>            
						</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<!-- 기본탭 -->
	<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"		VALUE="true">
		<PARAM NAME="BindInfo"			VALUE="
			<C>Col=EMPNO,			Ctrl=gcem_empno      		  	Param=Text</C>
			<C>Col=EMPNMK,		Ctrl=gcem_empnmk      		Param=Text</C>
			<C>Col=SEX,				Ctrl=gcem_sex      		  		Param=Text</C>
			<C>Col=BIRTHDAY,		Ctrl=gcem_birthday      		Param=Text</C>
			<C>Col=JOB,				Ctrl=txt_job_nm      		  		Param=Text</C>
			<C>Col=M_PAY,			Ctrl=gcem_m_day      		  	Param=Text</C>
			<C>Col=D_PAY,			Ctrl=gcem_d_day      		  	Param=Text</C>
			<C>Col=T_PAY,			Ctrl=gcem_t_day      		 	Param=Text</C>
			<C>Col=WK_DAY,			Ctrl=txt_w_day      		  		Param=Text</C>
			<C>Col=O_H,				Ctrl=txt_over_time      		  	Param=Text</C>
			<C>Col=N1_H,    			Ctrl=txt_night_time      		  	Param=Text</C>
			<C>Col=N2_H,				Ctrl=txt_night_time2      		  	Param=Text</C>
			<C>Col=H_D,	    		Ctrl=txt_hol_work      		  	Param=Text</C>
			<C>Col=E_H,				Ctrl=txt_early_time      		  	Param=Text</C>
			<C>Col=HOL_1,	 	 	Ctrl=txt_holiday1      		  		Param=Text</C>
			<C>Col=HOL_2,	  		Ctrl=txt_holiday2      		  		Param=Text</C>	
			<C>Col=HOL_3,	  		Ctrl=txt_holiday3      		  		Param=Text</C>		
			<C>Col=HOL_4,	  		Ctrl=txt_holiday4      		  		Param=Text</C>	
			<C>Col=HOL_5,	  		Ctrl=txt_holiday5      		  		Param=Text</C>	
			<C>Col=B_PAY,	  		Ctrl=txt_b_pay      		  		Param=Text</C>	
			<C>Col=X_PAY,			Ctrl=txt_x_pay      		  	  		Param=Text</C>	
			<C>Col=S_PAY,	  		Ctrl=txt_s_pay      		  		Param=Text</C>	
			<C>Col=TOT_PAY,		Ctrl=txt_total_pay      	  		Param=Text</C>
			<C>Col=HOL_PAY,		Ctrl=txt_hol_pay      		  		Param=Text</C>
			<C>Col=M_TOT_PAY,	Ctrl=txt_m_total_pay      		Param=Text</C>
			<C>Col=SABO_PAY,		Ctrl=txt_sabo_pay      		  	Param=Text</C>
			<C>Col=SUB_PAY,		Ctrl=txt_sub_pay      		  	Param=Text</C>
		">
	</OBJECT><%=HDConstant.COMMENT_END%>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>