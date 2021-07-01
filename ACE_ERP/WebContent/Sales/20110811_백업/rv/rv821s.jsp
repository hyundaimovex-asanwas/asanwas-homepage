<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 월간 예약현황 (숙소별)
 * 프로그램ID 	: RV820S
 * J  S  P		: rv820s
 * 서 블 릿		: Rv820S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-08
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-11-13][심동현] 개성쪽 현황 보기
 *						금강산과 현재 반 구성이 달라서 예약시 지정하는 테마에 따라 결정된다
 *						따라서 개성쪽은 음..그리드 구성이 다른데.. 흠..
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
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			fnInit();
		} 
		 
		function fnInit() {
			sJob_date.text='<%=firstday%>';	
		}
		
		
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var saupSid = 5;
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid=5"
			          + ",sJob_date=" + sJob_date.Text
			          + ",sClientSid=";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
		}
			
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0&&ds2.RowCount==0&&ds3.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
			
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").SetExcelTitle(1, "value:PLZ 월간 예약현황(숙소별) 출력; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr3").GridToExcel("PLZ월간 예약현황(숙소별)","PLZ 월간 예약현황(숙소별).xls", 8);
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
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- PLZ 그리드  -->
	<param name="SyncLoad" 	value="true">
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
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr height="30px">
			<td width='545px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text"  width="70">작업년월</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sJob_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">																					
							</object>&nbsp;
							<%=HDConstant.COMMENT_END%>
					 	</td>
					</tr>
				</table>
			</td>
			<td width='200'>
				<table   border='0' cellpadding='0' cellspacing='0' width='200'>
					<tr>
						<td align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
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
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds3">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              	<FC> name='마감일'    	ID='RSV_CLOSE_DATE' width=60 align=left 	editlimit=5 show=true		suppress=1</FC>
						              	<FC> name='출발일'    	ID='DEPART_DATE'   	width=60 align=left 	editlimit=50 show=true		suppress=2</FC>
   						             	<FC> name='상품'    		ID='SHORT_NM'   	width=60 align=left 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=3</FC>
   						              	<FC> name='출력순서'    	ID='PRT_SEQ'   		width=100 align=left 	editlimit=50 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=4</FC>
   						            
   						              	<FC> name='합계'    	ID='U_TT'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='당일(연천)'    	ID='U_1001'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='양구(호텔급)'    	ID='U_YGH'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='양구(펜션급)'    	ID='U_YGP'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   						              	
										<C> name='TOT_CHK'		ID='tot_chk'		width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
						
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td>

			</td>
		</tr>
	</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

