<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 단체등록
 * 프로그램ID 	: CU030I
 * J  S  P		: cu030i
 * 서 블 릿		: Cu030i
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-05
 * 기능정의		: 단체등록(조회,변경,저장)
 * [ 수정일자 ][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2010-06-14][정하나] 후정산유무 컬럼 추
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
		
		/* 페이지로딩 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출		
		 	cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		}

		/* 검색조건 설정		 */
		function fnInit(){		
			ds2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010";
			ds2.Reset();
			
			ds3.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=RV036";
			ds3.Reset();
						
									
			if (ds1.countrow<1){
				var s_temp =  "group_nm:STRING,group_cd:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
			
		/* 메인 조회		 */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/* 데이터셋 조회		 */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu030i?proType=S&dsType=1"
							+ "&s_GroupCd="+txt_group_cd1.value.toUpperCase()
							+ "&s_GroupNm="+txt_group_nm1.value
							+ "&s_SalDamSid="+txt_sal_dam_sid1.value
							+ "&s_UseYn="+drp_use_yn1.bindcolval;
			ds1.Reset();			
		}
		
		/* 키보드로 팝업 조회		 */		
		function fnSelectDs11() {
			if(txt_sal_dam_cd1.value!=""&&txt_sal_dam_nm1.value=="") {
				ds11.Dataid="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?proType=S&dsType=1"
					+ "&s_SalDamCd="+txt_sal_dam_cd1.value.toUpperCase();
				ds11.Reset();
			}	
		}		
			
		/* 행추가, 신규 		 */
		function fnAddRowDs1() {
			ds1.addrow();
		}
			
		/* 행삭제, 삭제		 */
		function fnDeleteRowDs1() {
			ds1.deleterow(ds1.rowposition);
		}
			
		/* 저장		 */
		function fnApply() {
			if(ds1.IsUpdated) {
				tr1.KeyValue="Cu030i(I:INPUT_DATA=ds1)";
				tr1.Action="<%=dirPath%><%=HDConstant.PATH_CU%>Cu030i?proType=A&dsNum=1";
				tr1.Post();
				ds1.resetstatus();
				msgTxt.innerHTML="<%=HDConstant.A_MSG_SAVE_DONE%>";
			}
		}
			
		/* 취소 		 */
		function fnCancelDs1() {
			ds1.undoall();
			msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}			
			
		/* 프린트		 */
		function fnPrintDs1() {
		}
			
		/* 엑셀		 */
		function fnExcelDs1() {

		}
			
		/* 팝업버튼으로 조회		 */
		function fnPopup(p) {
		
				if (p=="1") {
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
						txt_sal_dam_sid1.value = arrParam[0];
					   	txt_sal_dam_cd1.value = arrParam[1];
						txt_sal_dam_nm1.value = arrParam[2];
					} else {

					}
					
				} else if(p=="2") {
					var arrParam	= new Array();
					var arrResult	= new Array();
					var strURL;	
					var strPos;
					//arrParam[0] : zipcd
					//arrParam[1] : address1
					//arrParam[2] : address2
					strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:390px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);

					if (arrResult != undefined) {
						arrParam = arrResult.split(";");
						txt_zip_cd.value = arrParam[0];
					   	txt_address1.value = arrParam[1];
					} else {

					}

				} else if(p=="3") {
					var arrParam	= new Array();
					var arrResult	= new Array();
					var strURL;	
					var strPos;
					arrParam[0] = "SY006";
					arrParam[1] = "지역"; //공통코드의 마스터값
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:390px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);	
			
					if (arrResult != undefined) {
						arrParam = arrResult.split(";");
				    	txt_area_cd.value = arrParam[1];
						txt_area_cd_nm.value = arrParam[2];
					} else {

					}

				} else if(p=="4") {
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
						ds1.namevalue(ds1.rowposition,"sal_dam_sid")=arrParam[0];
					   	txt_sal_dam_cd.value = arrParam[1];
						txt_sal_dam_nm.value = arrParam[2];
					} else {

					}
				}

		}
			
		/* 입력 체크		 */
		function fnCheck() {
		
		}
		
		/* 체크박스의 값을 데이터셋으로 연동		 */
		function fnCheckbox() {
			if(txt_use_yn.checked==true) {
				ds1.namevalue(ds1.rowposition,"use_yn")="Y";
			}
			else {
				ds1.namevalue(ds1.rowposition,"use_yn")="N";
			}		
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
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  조회완료
	%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();
			if( row < 1){
				msgTxt.innerHTML="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  조회중 오류 
	%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("<%=HDConstant.AS_MSG_SEARCH_ERR%>");
			msgTxt.innerHTML="<%=HDConstant.AS_MSG_SEARCH_ERR%>";			fnHideLoading();
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  검색조건 조회중 
	%>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadStarted()" >
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);
		</script>				
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  검색조건 조회완료
	%>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();
			if( row < 1){
				msgTxt.innerHTML="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
			else {
				ds2.insertrow(1);
				ds2.namevalue(1,"detail") = "";
				ds2.namevalue(1,"detail_nm") = "전체";
				drp_use_yn1.index = 0;
			}			
		</script>
		
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();
			if( row < 1){
				msgTxt.innerHTML="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
			else {
				after_cu.index =0;
			}			
		</script>
		
				
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  검색조건 조회중 오류 
	%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			msgTxt.innerHTML="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();
		</script>
		
 		<script language=JavaScript  for=ds3 event="OnLoadError()">
			msgTxt.innerHTML="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();
		</script>
				
						
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help조회 
	%>
		<script language=JavaScript  for=ds11 event="OnLoadStarted()" >
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);			
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help조회완료
	%>
		<script language=JavaScript  for=ds11 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();			
			if(ds11.namevalue(ds11.rowposition,"sal_dam_nm") != undefined) {
				txt_sal_dam_nm1.value=ds11.namevalue(ds11.rowposition,"sal_dam_nm");
				txt_sal_dam_sid1.value=ds11.namevalue(ds11.rowposition,"sal_dam_sid");
			}
			else {
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help조회중 오류 
	%>		
 		<script language=JavaScript  for=ds11 event="OnLoadError()">
			msgTxt.innerHTML="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();			
		</script>
		
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  키보드로 행추가 
	%>			
		<script language="javascript" for="gr1" event="OnLastDown()">
			if(ds1.rowstatus(ds1.rowposition)=='0'||ds1.rowstatus(ds1.rowposition)=='3') {
				fnAddRowDs1();
			}
		</script>
	
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  데이터셋의 값을 체크박스로 연동
	%>

	<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
		if(ds1.namevalue(row,"use_yn")=="Y") {
			txt_use_yn.checked=true;
		}
		else {
			txt_use_yn.checked=false;
		}
	</script>		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	

	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패
	%>
		<script language="javascript" for="tr1" event="onfail()">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";
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
			<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- 검색조건 --%>
		<%=HDConstant.COMMENT_END%>	
				
		<%=HDConstant.COMMENT_START%>
			<object id=ds11 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- 검색조건2 --%>
		<%=HDConstant.COMMENT_END%>
		<%=HDConstant.COMMENT_START%>
			<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
			<param name="KeyName"  value="toinb_dataid4">
			</object>
		<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border="0" cellpadding="0" cellspacing="0" width="845" bordercolor=orange>
  <tr>
	<td>
	  <table  cellpadding="0" cellspacing="0" border="0">
		<tr> 
		  <td width="51px">
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="500px">
			  <tr> 
				<td width="80px" height="30px" class="text">단체코드</td>
				<td align="center" bgcolor="#ffffff">
				  <input id="txt_group_cd1" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px" maxlength="4">
				</td>
				<td width="80px" height="30px"  class="text">영업담당자</td>
				<td align="center" bgcolor="#ffffff"><nobr>
					<input id="txt_sal_dam_cd1" type="text" class="textbox" readonly="readonly"  style= "position:relative;left:0px;top:1px;width:60px; height:18px" maxlength="7" onchange="txt_sal_dam_nm1.value='',txt_sal_dam_sid1.value=''" onblur="fnSelectDs11()">
					<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:pointer;position:relative;left:0px;top:1px" align=center onclick="fnPopup('1');">
					<input id="txt_sal_dam_nm1" type="text" class="boardt04"  style= "position:relative;left:0px;top:3px;color:black;width:110px; height:20px;" maxlength="22" readonly>
					<input id="txt_sal_dam_sid1" type="hidden"></nobr>
				</td>
			  </tr>
			  <tr>
				<td width="80px" height="30px"  class="text">단체명</td>
				<td align="center" bgcolor="#ffffff">
						<input id="txt_group_nm1" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="42">
				</td>
				<td width="80px" height="30px"  class="text">사용유무</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=drp_use_yn1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;left:1px;top:2px" class="txtbox" >
							<param name=ComboDataID			value=ds2>
							<param name=SearchColumn		value="detail_nm">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="detail_nm^0^100">
							<param name=BindColumn			value="detail">
						</object>
						<%=HDConstant.COMMENT_END%>
				</td>
			  </tr>
			</table>
		  </td>
		  <td width="325" align="right"><table  cellpadding="0" cellspacing="0" border="0"><nobr>
			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
			<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:pointer;position:relative;left:3px;top:3px"  onClick="fnAddRowDs1()" >
			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnDeleteRowDs1()" >
			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply()">
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnCancelDs1()"></nobr>
		  </td>
		</tr>
	  </table>	
	</td>
  </tr>
  
  <tr>
	<td height="10px"></td>
  </tr>
  
</table>	

  <tr> 
	<td valign=top> 
	  <table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:200px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
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
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:220px;HEIGHT:420px;border:1 solid #777777;">
				<param name="DataID"		VALUE="ds1">
				<param name="BorderStyle"   VALUE="0">
				<param name="Fillarea"		VALUE="true">
				<param name=ColSizing       value="false">
				<param name="IndWidth"      value="0">
				<param name="editable"      value="true">
				<param name=UsingOneClick  	value="1">
				<param name="SortView"      value="right">
				<param name="Format"		VALUE="  
					<C> name='단체명'     ID='group_nm'    Width=110 align=left sort=true</C>
					<C> name='단체코드'	  ID='group_cd'    Width=80 align=center sort=true</C>
				">
			</object> 
			<%=HDConstant.COMMENT_END%>
		  </td>
		  <td width="15px">&nbsp;</td>
		  <td valign=top>
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="610px">
			  <tr>
				<td width="100px" height="30px" class="text">단체코드</td>
				<td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
					<input id="txt_group_cd" type="text" class="input" style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="4" onBlur="bytelength(this,this.value,4);">
					&nbsp; 영문/숫자 4자리
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">단체명</td>
				<td width="200px" align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_group_nm" type="text" class="input" style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="42" onBlur="bytelength(this,this.value,42);">
				</td>
				<td width="100px" height="30px" class="text">대표자</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_vd_direct" type="text" class="input"  style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="22" onBlur="bytelength(this,this.value,22);">
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">전화번호</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_tel_no" type="text" class="input""  style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="20" onBlur="bytelength(this,this.value,20);">
				</td>
				<td width="100px" height="30px" class="text">휴대전화</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
				<input id="txt_mobile_no" type="text" class="input"  style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="15" onBlur="bytelength(this,this.value,15);">
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">팩스번호</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_fax_no" type="text" class="textbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="20" onBlur="bytelength(this,this.value,20);">
				</td>
				<td width="100px" height="30px" class="text">메일주소</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_e_mail" type="text" class="input"  style= "position:relative;left:-5px;top:0px;width:100px; height:18px;" maxlength="30" onBlur="bytelength(this,this.value,30);">
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">우편번호</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_zip_cd" type="text" class="input"  readonly="readonly" style= "position:relative;left:-5px;top:3px;width:100px; height:18px;" maxlength="6" onBlur="bytelength(this,this.value,6);">
				<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="우편변호를 검색합니다" style="cursor:pointer;position:relative;left:-5px;top:1px" align=center onclick="fnPopup('2');">
				</td>
				<td width="100px" height="30px" class="text">지역코드</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_area_cd" type="text" class="input"  readonly="readonly" style= "position:relative;left:-5px;top:1px;width:40px; height:18px;" maxlength="2" onBlur="bytelength(this,this.value,2);">
				<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="지역코드를 검색합니다" style="cursor:pointer;position:relative;left:-5px;top:1px" align=center onclick="fnPopup('3');">
					<input id="txt_area_cd_nm" type="text" class="boardt04"  style= "position:relative;left:-5px;top:3px;width:100px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" readonly>
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">주소1</td>
				<td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
					<input id="txt_address1" type="text" class="input"  style= "position:relative;left:-5px;top:0px;width:300px; height:18px;" maxlength="60" onBlur="bytelength(this,this.value,60);">
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">주소2</td>
				<td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
					<input id="txt_address2" type="text" class="input"  style= "position:relative;left:-5px;top:0px;width:300px; height:18px;" maxlength="60" onBlur="bytelength(this,this.value,60);">
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">비고사항</td>
				<td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
					<input id="txt_desc" type="text" class="input"  style= "position:relative;left:-5px;top:0px;width:300px; height:18px;" maxlength="62" onBlur="bytelength(this,this.value,62);">
				</td>
			  </tr>
			  <tr>
				<td width="100px" height="30px" class="text">영업담당자</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_sal_dam_cd" type="text" class="input"  readonly="readonly" style= "position:relative;left:-5px;top:1px;width:60px; height:18px;" maxlength="10" onBlur="bytelength(this,this.value,10);">
				<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:pointer;position:relative;left:-5px;top:1px" align=center onclick="fnPopup('4');">
					<input id="txt_sal_dam_nm" type="text" class="input01"  style= "position:relative;left:-5px;top:3px;width:110px; height:20px;" maxlength="22" onBlur="bytelength(this,this.value,22);" readonly>
				</td>
				<td width="100px" height="30px" class="text">사용유무</td>
				<td align="left" bgcolor="#ffffff">&nbsp;
					<input id="txt_use_yn" type="checkbox" class=""  style= "position:relative;left:0px;top:0px;width:18px; height:20px;" onclick="fnCheckbox()">
				</td>
			  </tr>	
			  
			   <tr>
				<td width="100px" height="30px"  class="text" >후정산유무</td>
				<td colspan="3" align="left" bgcolor="#ffffff">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=after_cu classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=40 width=40 style="position:relative;left:1px;top:2px" class="txtbox" >
							<param name=ComboDataID			value=ds3>
							<param name=SearchColumn		value="detail_nm">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="detail_nm^0^40">
							<param name=BindColumn			value="detail">
						</object>
						<%=HDConstant.COMMENT_END%>&nbsp;※ "후정산"인 경우 계약금 미납으로 자동 취소되지 않습니다.
				</td>
			  </tr>
							  													
			</table>			
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
  	 <C>Col=group_cd               Ctrl=txt_group_cd             Param=value</C>
 	 <C>Col=group_nm               Ctrl=txt_group_nm             Param=value</C>
  	 <C>Col=vd_direct              Ctrl=txt_vd_direct            Param=value</C>
 	 <C>Col=tel_no                 Ctrl=txt_tel_no               Param=value</C>
  	 <C>Col=mobile_no              Ctrl=txt_mobile_no            Param=value</C>
 	 <C>Col=fax_no                 Ctrl=txt_fax_no               Param=value</C>
  	 <C>Col=e_mail                 Ctrl=txt_e_mail               Param=value</C>
 	 <C>Col=zip_cd                 Ctrl=txt_zip_cd               Param=value</C>
  	 <C>Col=area_cd                Ctrl=txt_area_cd              Param=value</C>
 	 <C>Col=area_cd_nm             Ctrl=txt_area_cd_nm           Param=value</C>
  	 <C>Col=address1               Ctrl=txt_address1             Param=value</C>
 	 <C>Col=address2               Ctrl=txt_address2             Param=value</C>
  	 <C>Col=memo                   Ctrl=txt_desc                 Param=value</C>
  	 <C>Col=sal_dam_cd             Ctrl=txt_sal_dam_cd          Param=value</C>
  	 <C>Col=sal_dam_nm             Ctrl=txt_sal_dam_nm           Param=value</C>
  	 <C>Col=after_cu         Ctrl=after_cu           Param=BindColVal </C>	
              ">
      </object>
	 <%=HDConstant.COMMENT_END%>      

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
