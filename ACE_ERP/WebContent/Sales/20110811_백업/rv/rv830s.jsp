<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 숙소별 예약현황
 * 프로그램ID 	: RV820S
 * J  S  P		: rv820s
 * 서 블 릿		: Rv820S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-08
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
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
		 
		 // 지역 
		function fnInit() {
			sJob_date.text='<%=firstday%>';	
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_ARRIVE_GOODS_DS=ds4)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds2.Reset(); //지역코드
		}
		
		/*
		 * 영업장
		 */		
		function fnSelectDs3() {
		 window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid");
	            
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:UPJANG=ds3)",
	            param);
	        tr_post(tr2);
		}	
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sJob_date=" + sJob_date.Text
			          + ",sUpjang_sid=" + sUpjang_sid.valueOfIndex("upjang_sid", sUpjang_sid.Index)
			          + ",sGoods_sid=" + sGoods_sid.valueOfIndex("goods_sid", sGoods_sid.Index)
			          + ",sCust_name=" + sCust_name.value
			          + ",sDateSel=" + sDateSel.value
			          + ",v_prt_seq=" + v_prt_seq.value;
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv830S",
			    "JSP(O:DS1=ds1)",
			    param);
			 
			 
			//prompt("","<%=dirPath%><%=HDConstant.PATH_RV%>Rv830S");			   
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:투숙객 현황조회 출력; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("투숙객 현황조회","투숙객 현황조회.xls", 8);
		}
    	
		/**
	     * 검색조건 대리점  팝업 
	     */
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
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
	


	<script language=JavaScript for= lc1 event=OnSelChange()>
			fnSelectDs3();
	</script>	
	
		
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
			fnSelectDs3();
	</script>
	

<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 영업장 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 상품 -->
    <param name="SyncLoad"  value=false>
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
		<tr>
			<td width='845px'>
				<table   border='0' cellpadding='0' cellspacing='0' width='845px'>
					<tr>
						<td>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor=#666666>
								<tr height=26>
									<td align=left class="text" width="80px">상품</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=sGoods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds4>
											<param name=BindColumn      value="GOODS_SID">
				                            <param name=BindColVal      value="GOODS_SID">
											<param name=EditExprFormat	value="%,%;GOODS_NM,GOODS_SID">
											<param name=ListExprFormat  value="GOODS_NM^0^120">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align=left class="text">출력순서</td>
			                        <td align=left bgcolor="#ffffff" valign="middle" colspan=5>&nbsp;
			                                <select name="v_prt_seq" id="v_prt_seq" class="textbox">
			                                    <option value="1">객실번호순
			                                    <option value="2">관광객순
			                                </select>
			                        </td>
								</tr>
							</table>
						</td>
						<td align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
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
					<tr height='26px'>
						<td align=left class="text" width="80px">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds2>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text">&nbsp;
    					<select name="sDateSel">
							 <option value="1">작업일자</option>
							 <option value="2">출발일자</option>
						</select>
							</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sJob_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
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
							</object>&nbsp;
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=left class="text" width="80px">영업장</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=sUpjang_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds3>
								<param name=BindColumn      value="upjang_sid">
	                            <param name=BindColVal      value="upjang_sid">
								<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
								<param name=ListExprFormat  value="upjang_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text"  width="80">성명</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<input type="text" name="sCust_name" value="" size='10'>
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
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='420px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
                                <param name="ViewSummary"       value="1">
								<param name="Format" 			value="
                                   <FC> name='NO'           ID='{CURROW}'        Width=35   edit=none align=center</FC>
					               <FC> name='영업장'    		ID='upjang_nm'   	SumText='총건수' width=140 align=left editlimit=30 show=true  suppress=1</FC>
					               <FC> name='객실타입' 		ID='room_type_cd'   SumText=@count width=60 align=left editlimit=5 show=true suppress=2</FC>
					               <FC> name='동'       		ID='dong_nm'      	width=30 align=left editlimit=3 show=true suppress=3</FC>
					               <FC> name='객실번호'   		ID='room_no'     	width=80 align=left editlimit=5 show=true</FC>
					               <FC> name='영문성명'   		ID='cust_enm'    	width=130 align=left editlimit=61 show=true</FC>
					               <FC> name='성명'      		ID='cust_nm'     	width=60 align=left editlimit=30 show=true</FC>
					               <C> name='성별'  			ID='sex'         	width=40 align=center editlimit=50 show=true</C>
					               <C> name='주민등록번호'	ID='manage_no'   	width=80 align=left editlimit=20 show=true</C>
					               <C> name='반'        		ID='class'       	width=60 align=left editlimit=50 show=true</C>
					               <C> name='조'        		ID='teams'       	width=40 align=center editlimit=2 show=true</C>
					               <C> name='연령'      	 	ID='age_cd'      	width=80 align=left editlimit=50 show=true</C>
					               <C> name='배드타입'       ID='bed_type_cd'    width=60 align=left editlimit=50 show=true</C>
					               <C> name='상품'     		ID='goods_nm'    	width=100 align=left editlimit=40 show=true</C>
					               <C> name='출경일'  		ID='depart_date'    width=60 align=left editlimit=8 show=true</C>
					               <C> name='입경일'  		ID='arrive_date'    width=60 align=left editlimit=8 show=true</C>				             
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

