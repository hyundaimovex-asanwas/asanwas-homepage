<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 숙소별 매출현황
 * 프로그램ID 	: AC230S
 * J  S  P		: Ac230s
 * 서 블 릿		: Ac230S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-14
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2010-04-21][심동현] 공급가액, 부가세 컬럼 추가~
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan


	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());
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
		fnInit();
	}

	/*
	 * 선조회
	 */
	function fnInit(){

		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn");
		cfStyleGrid(getObjectFirst("gr3"), "comn");

		em_departDate.text='<%=firstday%>';

		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";

		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드


	}



	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( em_departDate.text.trim() == '' ) {
			alert("출발일자를 입력해주세요.");
			return;
		}

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  		+ ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          	+ ",sGoods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          	+ ",sSDate=" + em_departDate.Text;

        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac230S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
            param);
        tr_post(tr1);

    }

  	function fnExcel() {
            if(ds1.CountRow==0 && ds2.CountRow==0 && ds3.CountRow ==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:매출분석; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("매출분석", "숙소별매출분석.xls", 32);

            getObjectFirst("gr2").SetExcelTitle(0, "");
            getObjectFirst("gr2").SetExcelTitle(1, "value:입금내역 및 외상매출; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr2").GridToExcel("입금내역 및 외상매출", "숙소별매출분석.xls", 32);

             getObjectFirst("gr3").SetExcelTitle(0, "");
            getObjectFirst("gr3").SetExcelTitle(1, "value:거래선별 외상매출; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr3").GridToExcel("거래선별 외상매출", "숙소별매출분석.xls", 32);
	}

	//상품조회
	function fnSelectLcGoods() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
				+ ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				+ ",sDepartDate=" + em_departDate.Text;
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		    "JSP(O:S_GOODS_DS=ds_goods)",
		    param);
		tr_post(tr1);
	};	
	</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectLcGoods();//상품 재검색
	</script>

	<script language=JavaScript for=em_departDate event=OnKillFocus()>
		if ( em_departDate.Modified ) {
			fnSelectLcGoods();			
		}
	</script>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>

	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
	/*	if (ds1.namevalue(ds1.rowposition, "sub_yn") == "Y") {
			gr1.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("FocusEditRow", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("FocusCurRow", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("FocusSelRow", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("EditCol", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("EditRow", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("CurCol", "BgColor") = "#FFFF00";
			gr1.SelectionColorProp("CurRow", "BgColor") = "#FFFF00";

		} else if (ds1.namevalue(ds1.rowposition, "main_yn") == "Y") {
			gr1.SelectionColorProp("FocusCurCol", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("FocusEditCol", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("FocusEditRow", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("FocusCurCol", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("FocusCurRow", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("FocusSelRow", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("EditCol", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("EditRow", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("CurCol", "BgColor") = "#92DF7B";
			gr1.SelectionColorProp("CurRow", "BgColor") = "#92DF7B";
		} else {
			gr1.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("FocusEditRow", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("FocusCurRow", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("FocusSelRow", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("EditRow", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
			gr1.SelectionColorProp("CurRow", "BgColor") = "#FFFFFF";
		}
		*/
	</script>
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<!--  사업소 -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!-- 상품 -->
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


	<table border='0' cellpadding='0' cellspacing='0' width='845'>
		<tr>
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr>
						<td align=left class="text" width="60px">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=left class="text"  width="60">출발일자</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=em_departDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">
								<param name=SelectAllOnClickAny   value="false">
							</object>
							&nbsp;
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=left class="text" width="80">상품정보</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
								<%=HDConstant.COMMENT_START%>
	                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;
						</td>
					</tr>
				</table>
			</td>

			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='0' width='200' bgcolor="#ffffff">
					<tr>
					<td align='right'>
						<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
						<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- 엑셀 -->
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:120; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="매출분석"</T>
											<T>divid="mxTab_page2"	title="입금내역"</T>
											<T>divid="mxTab_page3"	title="거래선별 외상매출"</T>'>
									</object>
									<%=HDConstant.COMMENT_END%>	
									<div class=page id="mxTab_page1" style="position:absolute; left:170; top:140; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >

	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name="SuppressOption"    value="1">

										<param name=SelectionColor  value="
											<SC>Type='FocusCurCol', BgColor='Black', TextColor='Black'</SC>
										">

										<param name="Format" 			value="
											<G> name='사용객실/예약 /확정 적용등급 기준'
								              	<C> name='숙박지'			ID='UPJANG_NM'           	width=100 align=left edit=none show=true suppress=1 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='상품'            	ID='GOODS_NM'              	width=100 align=left edit=none show=true suppress=2 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='객실타입명'      	ID='ROOM_TYPE_NM'          	width=80 align=left edit=none show=true suppress=3 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='예약'				ID='A_ROOM_TYPE_CD'      	width=80 align=left edit=none show=true suppress=4 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='확정'            	ID='ROOM_TYPE_CD'           width=80 align=left edit=none show=true suppress=5 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
											</G>

											<C> name='연령구분'  				ID='AGE_CD_NM'              width=100 align=left edit=none show=true bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
											<C> name='할인유형'  				ID='CUST_TYPE_NM'           width=100 align=left edit=none show=true bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
											<C> name='인원'            		ID='PERSONS'                width=40 align=right edit=none show=true bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>

											<G> name='요금단가'
												<C> name='정상요금'        	ID='STD_AMT'               width=100 align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='할인'        		ID='DC_AMT'              	width=100 align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='할인율(%)'     		ID='DC_RATE'          	width=100 align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
												<C> name='판매가'          	ID='TOUR_AMT'               width=100 align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
											</G>

											<C> name='총할인액'        	ID='TOT_DC_AMT'             	width=100 align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>

											<G> name='총판매액'
												<C> name='매출액'       ID='TOT_TOUR_AMT'           width=100 	align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
								                <C> name='공급가액'     ID='supp_amt' 				width=100 	align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
								                <C> name='부가세'      	ID='tax_amt' 				width=100 	align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>

												<C> name='총할인율(%)'       ID='TOT_DC_RATE'            width=100 align=right edit=none show=true decao=0 bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>
											</G>

											<C> name='업장순서'        	ID='UPJANG_SEQ'             width=100 align=left edit=none show=false bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))}</C>
											<C> name='상품순서'        	ID='GOODS_SEQ'              width=100 align=left edit=none show=false bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))}</C>
											<C> name='객실타입순서'    	ID='ROOM_TYPE_SEQ'         	width=100 align=left edit=none show=false bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))}</C>
											<C> name='SUB  합계' 	   	ID='SUB_YN'                 width=100 align=left edit=none show=false bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))}</C>
											<C> name='Main 합계' 	  	ID='MAIN_YN'                 width=100 align=left edit=none show=false bgColor={IF(SUB_YN='Y','#FFFF00',IF(MAIN_YN='Y','#5a7dad','#FFFFFF'))} Color={IF(MAIN_YN='Y','#FFFFFF','#000000')}</C>

										">
									</object>
									<%=HDConstant.COMMENT_END%>
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:170; top:140; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption  value=1>
										<param name=ViewSummary     value=1>
										<param name="Format" 			value="
							             	<C> name='결제수단'			ID='PAY_NM'  		width=100   	align=left editlimit=50 show=true  Sumtext='합계'</C>
											<C> name='금액'				ID='PAY_AMT'  		width=100   	align=right editlimit=50 show=true decao=0 Sumtext=@sum</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
									</div>
									<div class=page id="mxTab_page3" style="position:absolute; left:170; top:140; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds3">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name=ViewSummary     value=1>
										<param name="Format" 			value="
											<C> name='코드'				ID='CLIENT_cd'  		width=70   	align=center editlimit=50 show=true </C>
							               	<C> name='거래처'			ID='CLIENT_NM'  		width=130   	align=left editlimit=50 show=true Sumtext='합계'</C>
											<C> name='외상매출액'		ID='CREDIT_AMT'  		width=100   	align=right editlimit=50 show=true decao=0 Sumtext=@sum</C>
											<C> name='과입액'			ID='OVER_AMT'  		width=100   	align=right editlimit=50 show=true decao=0 Sumtext=@sum</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</div>
							</td>
						</tr>
					</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

