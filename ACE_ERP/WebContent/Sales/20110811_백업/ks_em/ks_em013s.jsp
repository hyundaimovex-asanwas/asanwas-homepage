<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 인사현황
+ 프로그램ID : ks_em013s.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2008.09.17
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em013_S.java
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
/*
	var gs_date = gcurdate;
	var year_date = gcurdate.substring(2,4);
	var yymmdd = gcurdate;
*/
	var gs_date ='<%=firstday%>';
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

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em013_S"
											 + "?v_str1=" + fn_trim(gcds_vend_cd.text)						//근무업체
											 + "&v_str2=" + fn_trim(gclx_dept_cd.bindcolval)			 	//직장
											 + "&v_str3=" + fn_trim(gcds_ord_dt_fr.Text)					  	//입직일 from
											 + "&v_str4=" + fn_trim(gcds_ord_dt_to.Text)					  	//입직일 to
											 + "&v_str5=" + fn_trim(gcds_ord_cd.bindcolval);			  	//부서

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

  	gcds_ord_dt_fr.text = gs_date;
  	gcds_ord_dt_to.text = gs_date;

	//발령구분
	gcds_ks010.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS010";
	gcds_ks010.Reset();
  	
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


/*----------------------------------------------------------------------------
	Description : 
----------------------------------------------------------------------------*/

function ln_Find_s(e){

		var arrResult	= new Array();
		var strURL;
		var strPos;
		arrParam = e;
		strURL = "../popup/ks_em_popup.jsp";
		strPos = "dialogWidth:370px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
		
		//prompt (this, arrResult);
		//	gcds_data00.addrow();
			arrParam = arrResult.split(";");
		
		if ( arrParam[0] == '01'){			
			gclx_vend_cd.Text=arrParam[1];							
			gclx_vend_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '04'){			
			gclx_work_cd.Text=arrParam[1];
			gclx_work_nm.Text=arrParam[2];
		}					

}
}




/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName1 = "인사 현황";
    var szPath = "C:\\Test\\현황.xls";
       if (gcds_data00.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
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
		<script language="javascript" for="tr1" event="onsuccess()">
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">

		</script>


<!-- 인사기본 -->
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


<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>

<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 직장구분 -->
<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 발령구분 -->
<OBJECT id=gcds_ks010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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

<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black border=0><!-- body table -->
	<tr height="20px"><!-- 버튼 영역 시작-->
		<td align="left" colspan="3">
			<table width="820" border="0"  cellspacing="0" cellpadding="0">
				<tr>
					<td align="right" height="30px">		
						<img src="<%=dirPath%>/Sales/images/excel.gif"   	style="cursor:hand" onclick="ln_Excel()">
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>																		
			</table>
		</td>
	 </tr>
	 <tr height=20><!-- 조회 영역 시작-->
		<td>
			<table cellpadding=0 cellspacing=1 style="width:829px;height:20px;" bgcolor="#708090">
				<tr>
				  <td bgcolor="#eeeeee" width="50" align = center>소 속</td>
					<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:80px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcds_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:70px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="true">
										</OBJECT>
										<OBJECT id=gcds_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>										
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_Find_s('01');">
									</td>										
									<td bgcolor="#eeeeee" width="50" align = center>직장구분</td>
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
									<td bgcolor="#eeeeee" width="50" align = center>근무현장</td>
									<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:80px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcds_work_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:70px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gcds_work_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>	
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_Find_s('04');">
									</td>					
									</tr>
									<tr>
									  <td bgcolor="#eeeeee" width="50" align = center>입직일</td>
										<td bgcolor="#FFFFFF">
													<%=HDConstant.COMMENT_START%>
														<OBJECT id=gcds_ord_dt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
														style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														</OBJECT><%=HDConstant.COMMENT_END%>								
																<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcds_ord_dt_fr', 'Text');">
																	<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>								
																<%=HDConstant.COMMENT_START%>
																	<OBJECT id=gcds_ord_dt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
																	style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
																	<param name=Alignment			value=0>
																	<param name=Border	      value=true>
																	<param name=Format	      value="YYYY/MM/DD">
																	<param name=PromptChar	  value="_">								
																	</OBJECT><%=HDConstant.COMMENT_END%>								
																<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcds_ord_dt_to', 'Text');">
															</td>
										<td bgcolor="#eeeeee" width="50" align = center>발령구분</td>
										<td bgcolor="#FFFFFF">
														<%=HDConstant.COMMENT_START%>
														<object id=gcds_ord_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
														style="position:relative;left:8px;top:1px;font-size:12px;width:120px;" >
														<param name=ComboDataID			value="gcds_ks010">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort				    value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^120">
														<param name=BindColumn			value=COM_CODE>
														</object></comment>	<script>__ws__(__NSID__);</script>					
										</td>						
										<td align="center" width="50" bgcolor="#eeeeee">성명</td>
										<td bgcolor="#FFFFFF">
										  <input type="text" id="txt_empnmk" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
											<img src="<%=dirPath%>/Sales/images/help.gif" alt="성명을 검색합니다" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find()">
										  <input type="text" id="txt_empno" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
										</td>
									</tr>
								</table>
							  </td>
						    </tr>			
							<tr>
								<td valign="top" bgcolor="#FFFFFF"><br>
									<table cellpadding=0 cellspacing=0 style="width:827px;height:390px;">
										<tr>
											<td bgcolor="#FFFFFF" align="left" class="tab_z1111"  >
												<%=HDConstant.COMMENT_START%>
												<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:827;height:370px;border:0">
												<PARAM NAME="DataID"			VALUE="gcds_data00">
												<PARAM NAME="BorderStyle" VALUE="0">
												<PARAM NAME="Indwidth"		VALUE="0">
												<PARAM NAME="Fillarea"		VALUE="true">
												<PARAM NAME="Colsizing"		VALUE="true">
												<PARAM NAME="TitleHeight"	VALUE=30>
												<param name="sortview"     value=left>
												<PARAM NAME="Format"			VALUE="  
					                			<F> Name=NO				  ID={CurRow}         HeadAlign=Center   HeadBgColor=#B9D4DC Width=30,  align=center </F> 
													<FC>Name=직번,      ID=EMPNO					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,  sort = true </FC>
													<FC>Name=성명,      ID=EMPNMK					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60, align=center  sort = true </FC>						
													<FC>Name=소속,  	ID=VEND_NM			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=center,  sort = true </FC>
													<FC>Name=직장구분,      ID=DEPT_NM					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=65,align=center</FC>
													<FC>Name=근무현장,    ID=WORK_NM				  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=center</FC>
													<FC>Name=비용부담업체,      ID=C_VEND_NM					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center</FC>
													<C>Name=직종,       ID=JOB_NM					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center</C>
													<C>Name=입직일,     ID=START_DT			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
													<C>Name=성별,       ID=SEX							HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,sort = true, value={if(SEX='M','남',IF(SEX='F','여',''))}</C>
													<C>Name=생년월일,       ID=BIRTHDAY							HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=center Mask='XXXX/XX/XX'</C>
													<C>Name=년차,       ID=CON_YEAR 			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,sort = true </C>
													<C>Name=학력,       ID=ATT_CD  			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=55,align=center, value={if(ATT_CD='1','중졸',IF(ATT_CD='2','전졸',IF(ATT_CD='3','대졸','')))}</C>
												">
												</OBJECT><%=HDConstant.COMMENT_END%>
														<fieldset style="width:827;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
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
