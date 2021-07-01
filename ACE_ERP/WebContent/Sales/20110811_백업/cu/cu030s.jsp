<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 단체조회      
 * 프로그램ID 	: CU030S        
 * J  S  P		: cu030s        
 * 서 블 릿		: Cu030s        
 * 작 성 자		: 구자헌        
 * 작 성 일		: 2006-06-05    
 * 기능정의		: 단체조회(조회)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
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
		 * 초기작업
		 */
		function fnInit(){
			ds2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010";
			ds2.Reset();
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
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu030s?proType=S&dsType=1"
							+ "&s_GroupCd="+txt_group_cd.value.toUpperCase()
							+ "&s_GroupNm="+txt_group_nm.value
							+ "&s_SalDamSid="+txt_sal_dam_sid.value
							+ "&s_UseYn="+drp_use_yn.bindcolval;
			ds1.Reset();			
		}
		
		/*
		 * 키보드로 팝업 조회
		 */		
		function fnSelectDs11() {
			if(txt_sal_dam_cd.value!=""&&txt_sal_dam_nm.value=="") {
				ds11.Dataid="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?proType=S&dsType=1"
					+ "&s_SalDamCd="+txt_sal_dam_cd.value.toUpperCase();
				ds11.Reset();
			}	
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
			if(ds1.RowCount==0){
				alert("데이터를 먼저 조회하시길 바랍니다.");
				return;
			}
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:단체조회 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("단체조회", "단체조회.xls", 8);		 
		}
			
		/*
		 * 팝업버튼으로 조회
		 */
		function fnPopup() {
		
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				//arrParam[0] : 영업담당자sid
				//arrParam[1] : 영업담당자코드
				//arrParam[2] : 영업담당자이름
				strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:390px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != undefined) {
					arrParam = arrResult.split(";");
					txt_sal_dam_sid.value = arrParam[0];
				   	txt_sal_dam_cd.value = arrParam[1];
					txt_sal_dam_nm.value = arrParam[2];
				} else {
					txt_sal_dam_sid.value = "";
				   	txt_sal_dam_cd.value = "";
					txt_sal_dam_nm.value = "";
				}
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
			fnShowLoading(410,180);			
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  조회완료
	%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();	
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  조회중 오류 
	%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("<%=HDConstant.AS_MSG_SEARCH_ERR%>");
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  검색조건 조회중 
	%>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);			
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  검색조건 조회완료
	%>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();	
			ds2.insertrow(1);
			ds2.namevalue(1,"detail") = "";
			ds2.namevalue(1,"detail_nm") = "전체";
			drp_use_yn.index = 0;
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  검색조건 조회중 오류 
	%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();	
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help조회 
	%>
		<script language=JavaScript  for=ds11 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help조회완료
	%>
		<script language=JavaScript  for=ds11 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			if(ds11.namevalue(ds11.rowposition,"sal_dam_nm") != undefined) {
				txt_sal_dam_nm.value=ds11.namevalue(ds11.rowposition,"sal_dam_nm");
				txt_sal_dam_sid.value=ds11.namevalue(ds11.rowposition,"sal_dam_sid");
			}
			else {
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  조회중 오류 
	%>		
 		<script language=JavaScript  for=ds11 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();				
		</script>
	<%
	/*******************************************************************************
				가우스 오브젝트  Dataset , TR 선언
	*******************************************************************************/
	%>
		<%=HDConstant.COMMENT_START%>
			<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- 메인 --%>
		<%=HDConstant.COMMENT_END%>
		<%=HDConstant.COMMENT_START%>
			<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- 검색조건 --%>
		<%=HDConstant.COMMENT_END%>
		<%=HDConstant.COMMENT_START%>
			<object id=ds11 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- 검색조건2 --%>
		<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" border="0">
				<tr height="30px">
					<td width='845px'>
						<table border="0" cellpadding="0" cellspacing="1"  width='845px'>
							<tr>
								<td width="845px" align="right">
									<table  cellpadding="0" cellspacing="0" border="0"><nobr>
										<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
										<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnExcelDs1()"></nobr>
								  	</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td></td>
				</tr>
				<tr> 
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="845px">
							<tr height="30px"> 
								<td width="80px" height="30px" class="text">영업담당자</td>
								<td align="left" bgcolor="#ffffff" width='270px'>&nbsp;
									<input id="txt_sal_dam_cd" type="text" class="textbox" readonly="readonly" size='10'  align='absmiddle' maxlength="7" onchange="txt_sal_dam_nm.value='',txt_sal_dam_sid.value=''" onblur="fnSelectDs11()">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle  ALT="영업담당자를 검색합니다"  align=center onclick="fnPopup();">
									<input id="txt_sal_dam_nm" type="text" class="boardt04" align=absmiddle  maxlength="22" readonly>
									<input id="txt_sal_dam_sid" type="hidden">
								</td>
								<td width="70px" height="30px" class="text">단체코드</td>
								<td align="center" bgcolor="#ffffff">
									<input id="txt_group_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:65px; height:18px" maxlength="4">
								</td>
								<td width="70px" height="30px" class="text">단체명</td>
								<td align="center" bgcolor="#ffffff">
									<input id="txt_group_nm" type="text" class="textbox" size=15 maxlength="42">
								</td>
								<td width="70px" height="30px" class="text">사용유무</td>
								<td align="center" bgcolor="#ffffff">
									<%=HDConstant.COMMENT_START%>
									<object id=drp_use_yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=170 width=50 style="position:relative;left:1px;top:2px" align="absmiddle" class="txtbox" >
										<param name=ComboDataID			value=ds2>
										<param name=SearchColumn		value="detail_nm">
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="detail_nm^0^50">
										<param name=BindColumn			value="detail">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>
	</tr>

	<tr>
		<td height="10px"></td>
	</tr>

	<tr> 
		<td valign=top> 
			<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
				<tr> 
					<td>
					<%
					/*---------------------------------------------------------------------------->
						HTML Desc	: xxxxxxxx 
									: 검색 종류 - 분류코드, 분류명
						Object ID 	: 그리드 , gr1
						Data ID		: ds1
					-----------------------------------------------------------------------------*/
					%>
					<%=HDConstant.COMMENT_START%>											
					<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
						<param name="DataID"		VALUE="ds1">
						<param name="BorderStyle"   VALUE="0">
						<param name="Fillarea"		VALUE="true">
						<param name=ColSizing       value="false">
						<param name="IndWidth"      value="0">
						<param name="editable"      value="true">
						<param name=UsingOneClick  	value="1">
						<param name=Viewsummary  	value="1">
						<param name=sortview	value="right">
						<param name="Format"		VALUE="  
							<C> name='영업담당자' ID='sal_dam_nm'  Width=100 align=left sumtext=계</C>
							<C> name='단체코드'	  ID='group_cd'    Width=80 align=center sumtext=@cnt sort=true</C>
							<C> name='단체명'     ID='group_nm'    Width=100 align=left sort=true</C>
							<C> name='대표자'     ID='vd_direct'   Width=100 align=center</C>
							<C> name='전화번호'   ID='tel_no'      Width=100 align=center/C>
							<C> name='휴대전화'   ID='mobile_no'   Width=100 align=center</C>
							<C> name='팩스번호'   ID='fax_no'      Width=100 align=center</C>
							<C> name='메일주소'   ID='e_mail'      Width=120 align=left</C>
							<C> name='우편번호'   ID='zip_cd'      Width=70  align=center mask='XXX-XXX'</C>
							<C> name='주소1'      ID='address1'    Width=200 align=left</C>
							<C> name='주소2' 	  ID='address2'    Width=135 align=left</C>
							<C> name='비고'       ID='desc'        Width=100 align=left</C>
							<C> name='사용유무'   ID='use_yn_nm'   Width=100 align=center</C>
						">
					</object> 
					<%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

	<%
	/*******************************************************************************
				Bind 선언
	*******************************************************************************/
	%>
	<%=HDConstant.COMMENT_START%>
    <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
       <param name="DataId" value="ds1">
       <param name=BindInfo    value="
       
        ">
    </object>
	<%=HDConstant.COMMENT_END%>      

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
