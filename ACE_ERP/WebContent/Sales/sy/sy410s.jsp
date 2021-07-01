<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 영업담당정보조회
 * 프로그램ID 	: SY410S
 * J  S  P		: sy410s
 * 서 블 릿		: Sy410S
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-02
 * 기능정의		: 영업담당정보조회(조회)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
		<script language="javascript">
		
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		}

		/*
		 * 데이타셋 헤더 설정
		 */
		function fnSetHeaderDsInit(){
		
		}	
			
		/*
		 * 초기작업
		 */
		function fnInit(){
			
			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY008";
			ds2.reset();
		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/*
		 * 데이터셋 첫번째 조회
		 */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410S?proType=S&dsType=1&s_DeptCd="+txt_dept_cd.value.toUpperCase()
																					+"&s_SalDamCd="+txt_sal_dam_cd.value.toUpperCase()
																					+"&s_SalDamNm="+txt_sal_dam_nm.value
																					+"&s_UseYn=";
			ds1.Reset();			
		}
			
		/*
		 * 행추가 , 신규 
		 */
		function fnAddRowDs1() {

		}
			
		/*
		 * 행삭제, 삭제
		 */
		function fnDeleteRow() {

		}
			
		/*
		 * 저장
		 */
		function fnApply() {

		}
			
		/*
		 * 취소 
		 */
		function fnCancelDs1() {

		}			
			
		/*
		 * 프린트
		 */
		function fnPrintDs1() {
		}
			
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {

		}
			
		/*
		 * 팝업
		 */
		function fnPopup() {
			
		}
			
		/*
		 * 입력 체크
		 */
		function fnCheck() {
		
		}
		
		</script>		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회완료
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("<%=HDConstant.AS_MSG_SEARCH_ERR%>");
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회완료
%>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			document.all.LowerFrame.style.visibility="hidden";
			ds2.InsertRow(1);
			ds2.namevalue(1,"detail")="";
			ds2.namevalue(1,"detail_nm")="전체";
			drp_gunmu.index=0;
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>

<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<param name="SyncLoad" 	value="false">
	</object>
	<%=HDConstant.COMMENT_END%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<param name="SyncLoad" 	value="false">
	</object>
	<%=HDConstant.COMMENT_END%>



</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table  cellpadding="0" cellspacing="0" border="0">
		  <tr> 
			<td width="51px">
				<table width="660px" cellpadding="0" cellspacing="0" border="0"  style='width:660px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
				  <tr> 
					<td style="width:70px;height:30px;border:1 solid #708090;" bgcolor="#eeeeee" align=center class="txtbox">부서코드</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<input id="txt_dept_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px; height:20px;" maxlength="50">
					</td>
					<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">근무구분</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=drp_gunmu classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=80 style="position:relative;left:1px;top:2px" class="txtbox" >
							<param name=ComboDataID			value=ds2>
							<param name=SearchColumn		value="detail_nm">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="detail_nm^0^150">
							<param name=BindColumn			value="detail">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">담당자코드</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<input id="txt_sal_dam_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px; height:20px;" maxlength="50">
					</td>
					<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">담당자명</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<input id="txt_sal_dam_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px; height:20px;" maxlength="50">
					</td>
				  </tr>
				</table>
			</td>
			<td width="180" align="right"><table  cellpadding="0" cellspacing="0" border="0"><nobr>
				<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
				<img src="<%=dirPath%>/Sales/images/print.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnPrintDs1()">
				<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnExcelDs1()"></nobr>
			</td>
		  </tr>
		</table>	
	</td>
  </tr>
</table>		

<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:1px;width:310px;height:300px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
  <tr>
  	<td height=3  border="0"></td>
  </tr>
  <tr> 
	<td valign=top> 
		<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
		  <tr> 
			<td>
				<%=HDConstant.COMMENT_START%>											
				<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
					<param name="DataID"		VALUE="ds1">
					<param name="BorderStyle"   VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<param name=ColSizing       value="false">
					<param name="IndWidth"      value="0">
					<param name="editable"      value="true">
					<param name=UsingOneClick  	value="1">
					<param name="Format"		VALUE="  
						<C> name='부서명' 	  ID='deptnm' 	  HeadAlign=Center Width=150 align=left</C>						
						<C> name='담당자코드' ID='sal_dam_cd' HeadAlign=Center Width=80 align=center</C>
						<C> name='담당자명'   ID='sal_dam_nm' HeadAlign=Center Width=100 align=left</C>
						<C> name='동명이인구분' ID='name_gu'  HeadAlign=Center Width=100 align=center</C>
						<C> name='회사전화'  ID='office_tel'  HeadAlign=Center Width=100 align=center/C>
						<C> name='자택전화'  ID='house_tel'   HeadAlign=Center Width=100 align=center</C>
						<C> name='휴대전화'  ID='mobile_tel'  HeadAlign=Center Width=100 align=center</C>
						<C> name='팩스번호'  ID='fax_no'      HeadAlign=Center Width=100 align=center</C>
						<C> name='담당업무'  ID='business_gu_nm' HeadAlign=Center  Width=100 align=left</C>
						<C> name='근무지역'  ID='area_cd_nm'     HeadAlign=Center  Width=60 align=center</C>
						<C> name='기본메일주소' ID='b_email'  HeadAlign=Center Width=120 align=left</C>
						<C> name='생년월일'  ID='bithday'     HeadAlign=Center Width=80 align=center mask='XXXX/XX/XX'</C>
						<C> name='구분'      ID='bithday_gu_nm'  HeadAlign=Center Width=100 align=center</C>
						<C> name='우편번호'  ID='zip_cd'      HeadAlign=Center Width=70 align=center mask='XXX-XXX'</C>
						<C> name='주소1'     ID='address1'    HeadAlign=Center Width=200 align=left</C>
						<C> name='주소2' 	 ID='address2'    HeadAlign=Center Width=155 align=left</C>
						<C> name='비고'      ID='sal_dam_desc'        HeadAlign=Center Width=100 align=left</C>
					">
				</object> 
				<%=HDConstant.COMMENT_END%>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


