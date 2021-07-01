<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 월별정리
 * 프로그램ID 	: AC520S
 * J  S  P		: ac520s
 * 서 블 릿		: Ac520S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-21
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
		 var div='';
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			sSDate.Text = '<%=firstday%>';	
			fnInit();
		} 
		 
		function fnInit() {
			codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs1.Reset(); //지역코드
			// 지역
			div = 'init';
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP( O:UPJANG=codeDs3)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		//상품조회
		function fnSelectLcGoods() {
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			    + ",sSaupSid=" + lc1.ValueOfIndex("saup_sid", lc1.Index)
					+ ",sDepartDate=";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=codeDs2)",
			    param);
			tr_post(tr1);
		};
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
			          + ",sSDate=" + sSDate.Text
   			          + ",sUpjang=" + sUpjang.ValueOfIndex("upjang_sid", sUpjang.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac520S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
			
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			if(ds1.countrow==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:월별정리; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("월별정리","월별정리.xls", 8);
		}
    	
	
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	
	<script language=JavaScript	for=saup_sid event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=lc1 event=OnSelChange()>
		fnSelectLcGoods();//상품 재검색
	</script>
<%

/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  영업장-->
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' width='400' bgcolor='#666666'>
								
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0' width='445px'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text" width="60px">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text"  width="60">작업년월</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
 
																											
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>												
                        <td align="center" width="100px" height="30px" class="text">영업장</td>
							<td align="center" bgcolor="#ffffff">
								<%=HDConstant.COMMENT_START%>
								<object id=sUpjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
									<param name=ComboDataID		value=codeDs3>
								<param name=BindColumn      value="upjang_sid">
	                            <param name=BindColVal      value="upjang_sid">
								<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
								<param name=ListExprFormat  value="upjang_nm^0^140">
								</object>
								<%=HDConstant.COMMENT_END%>	
						</td>
						<td align=left class="text" width="80">상품정보</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
								<%=HDConstant.COMMENT_START%>
	                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs2>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140">
							</object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								 <param name=ViewSummary     value=1>
								<param name="Format" 			value="
									
									<C> name='순번'   		ID='{CURROW}'  				width=30 	align=right editlimit=61 show=true SumText='합계'</C>
									<C> name='출발일자'   	ID='DEPART_DATE'  			width=100 	align=left editlimit=61 show=true suppress=1 mask='XXXX-XX-XX'  </C>
									<C> name='상품'   		ID='GOODS_NM'  				width=100 	align=left editlimit=61 show=true suopress=2</C>
									<C> name='인원'   		ID='QTY'  					width=50 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right dec=0</C>

									<G> name='관광 및 숙박기준 매출'
										<C> name='관광매출'   	ID='TOUR_AMT'  			width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right dec=0</C>
										<C> name='기준매출'   	ID='TOUR_BASE_AMT'  	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right dec=0</C>
									</G>
									<G> name='숙박비 단가조정'
										<C> name='기준숙박비'   	ID='BASE_ROOM_AMT'  	width=100 	align=right editlimit=61 show=true  SumText=@sum SumTextAlign=right dec=0</C>
										<C> name='조정율(%)'   		ID='CONT_RETE'  		width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right dec=0</C>
										<C> name='조정숙박비'   	ID='CONT_BASE_PRICE'  	width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right dec=0</C>
									</G>
									
									<C> name='총숙박비'   	ID='TOT_ROOM_AMT'  			width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right dec=0</C>

									
									       
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

