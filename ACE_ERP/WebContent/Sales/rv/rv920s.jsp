<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 예약확정명단_PLZ
 * 프로그램ID 	: RV810S_N
 * J  S  P		: rv810s_n
 * 서 블 릿		: Rv810S_N
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-06
 * [수  정   일  자][수정자] 내용
 * [2009-12-24][심동현] 순판매액 → 관광요금 + 옵션요금으로 분리~
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
				
			fnInit();
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			div = 'init';
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //지역코드	        
		}
		
		/*
		 * 출경시간, 상품조회
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
	            param);
	        tr_post(tr2);
		}	
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	
			          + ",sGcd=" + sGcd.value
			          + ",sCust_gubn=" + sCust_gubn.value
			          + ",sOpt=" + sOpt.value	;
				ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv920S",
			    "JSP(O:DS_MAIN=ds_main)",
			    param);
			tr_post(tr1);
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:예약확정명단; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("예약확정명단","예약확정명단.xls", 8);
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
	
	<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
		fnSelectBound();
	</script>
	
	 <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
 		ds_bound.insertrow(1);
 		
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "0";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_NM") = "전체";
		
		v_bound.Index = 0; 
    </script>
    
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( sBgnDate.Modified ) {
//				div = 'init';
				fnSelectDs3();			
		}
	</script>

	<script language=JavaScript for= lc1 event=OnSelChange()>
//		if ( div != 'init' ) {	//지역
//			div = 'init';			
			fnSelectDs3();
//		}
	</script>	
	
	<script language=JavaScript for= lc2 event=OnSelChange()>
//		if ( div != 'init' ) {	//출경시간
//			div = 'init';					
//		}
	</script>		
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		div = "";		
	</script>	


	
	<script language=javascript for="gr1" event="OnDblClick(Row, Colid)">
		//더블클릭 >> 팝업호출
	    if(Row==0) return;
	    popConfirm(ds1.namevalue(Row, "RSV_SID"));
	</script>

<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  출경시간 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품순번 -->
    <param name="SyncLoad"  value="True">
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

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="845px">
					<tr>
						<td style="padding-bottom:6px"><img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=right onClick="fnExcelDs1()">		<!-- 엑셀 -->
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=right onclick="fnSelect()"> 		<!-- 조회 -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td align=left>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text"  width="80">항차</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
		    				<select name="sGcd"> 
			    				<option value="0" SELECTED>전체</option>
								<option value="2">1항차</option>
								<option value="3">2항차</option>
							</select>
						</td>																							
						<td align=left class="text" width="80px">해당분야</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
		    				<select name="sCust_gubn"> 
			    				<option value="0" SELECTED>전체</option>
			    				<option value="1">파워블로거</option>
								<option value="2">해양/관광 부문 전공자</option>
								<option value="3">SNS 사용자</option>
							</select>
							
						</td>	
						<td align=left class="text" width="80">복귀정보</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<select name="sOpt">
								<option value="00" SELECTED>전체</option>
								<option value="01" >1. 4일 김포/인천 공항 복귀</option>
								<option value="02" >2. 4일 김해 공항 복귀</option>
								<option value="03" >3. 5일 김포/인천 공항 복귀</option>
								<option value="04" >4. 5일 김해 공항 복귀</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td>
				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width:98%; height:370px ;" border="1">
					<param name="DataID"		value="ds_main">
					<param name="ColSizing"		value="true">
					<param name="Fillarea"		value="false">
					<param name="Editable"		value="false">
					<param name="BorderStyle"	value="0">
					<param name=SortView  		value="Left">
					<param name="SuppressOption"    value="1">
					<param name="ViewSummary"       value="1">
					<param name="Format" 			value="
			              <C> name='참가번호'  		ID='evd_sid'  	width=70 	align=right show=true sumtext='총'</C>
			              <C> name='해당분야'   	ID='cust_gubn'  width=140 	align=left show=true sumtext=@cnt</C>
			              <C> name='블로그/SNS주소' ID='blog_addr'  width=150	align=left show=true suppress=1 sumtext='명'</C>
			              <C> name='동행구분'     	ID='join_gubn'  width=70 	align=center show=true</C>
			              <C> name='이름'    		ID='cust_nm'   	width=60 	align=center show=true</C>
			              <C> name='생년월일'      	ID='cust_bday'  width=70 	align=center show=true</C>
			              <C> name='핸드폰'    		ID='cust_mob'   width=100 	align=center show=true</C>
			              <C> name='복귀정보' 		ID='opt_0731' 	width=160 	align=left show=true</C>
			              <C> name='참가일시' 		ID='I_DATE' 	width=130 	align=center show=true</C>
            		">
				</object>   
			</td>
		</tr>
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

