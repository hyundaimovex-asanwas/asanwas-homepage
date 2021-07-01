<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 체류현황
 * 프로그램ID 	: AC020S
 * J  S  P		: ac020s
 * 서 블 릿		: Ac020S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-07
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
		cfStyleGrid(getObjectFirst("gr4"), "comn");
		cfStyleGrid(getObjectFirst("gr5"), "comn");
		cfStyleGrid(getObjectFirst("gr6"), "comn");
		cfStyleGrid(getObjectFirst("gr7"), "comn");
		cfStyleGrid(getObjectFirst("gr8"), "comn");
		
		
		sJobDate.text='<%=firstday%>';
                  
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";
		 
		// 사업소, 고객구분
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=codeDs1)", 
            param);
            
        tr_post(tr1);		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	
 		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
        	+ "sSaup_sid=" +codeDs1.namevalue(codeDs1.rowposition,"saup_sid") + ","        
        	+ "sJobDate=" + sJobDate.text + ","
        	+ "sAll=" + sAll.value;
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy510S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3,O:DS4=ds4,O:DS5=ds5,O:DS6=ds6,O:DS7=ds7,O:DS8=ds8)",
            param);
        tr_post(tr1);

    }
 	
  	function fnExcel() {
  	
		  	getObjectFirst("gr8").SetExcelTitle(0, "");
	        getObjectFirst("gr8").GridToExcel("Sheet8","자료전송.xls", 32);   

        	getObjectFirst("gr7").SetExcelTitle(0, "");
	        getObjectFirst("gr7").GridToExcel("Sheet7","자료전송.xls", 32);   
	        
	        getObjectFirst("gr6").SetExcelTitle(0, "");
	        getObjectFirst("gr6").GridToExcel("Sheet6","자료전송.xls", 32);   
	        
	        getObjectFirst("gr5").SetExcelTitle(0, "");
	        getObjectFirst("gr5").GridToExcel("Sheet5","자료전송.xls", 32);   
	        
	        getObjectFirst("gr4").SetExcelTitle(0, "");
	        getObjectFirst("gr4").GridToExcel("Sheet4","자료전송.xls", 32);   
	        
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").GridToExcel("Sheet3","자료전송.xls", 32);   
	        
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").GridToExcel("Sheet2","자료전송.xls", 32);   
	        
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("Sheet1","자료전송.xls", 32);   
            
	        
            
        }
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
		resultMsg.innerHTML="자료 건수 = <b>영업장정보: "+ds1.CountRow+", 동정보:"+ds2.CountRow+", 객실타입정보: "+ds3.CountRow+", 객실정보: "+ds4.CountRow+", 상품정보: "+ds5.CountRow+", 공통코드: "+ds6.CountRow+", 매출처정보: "+ds7.CountRow+", 옵션요금정보: "+ds8.CountRow+"</b>";		
	</script>	
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<!--  사업소 -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td bgcolor="#ffffff" width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845' bgcolor="#ffffff">
					<tr>
					<td align='right'>
						<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
						<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- 엑셀 -->
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr height="30px">
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height="30px">
						<td align=left width=70 class="text">&nbsp;지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
								<%=HDConstant.COMMENT_START%>
                            <object id=sSaupSid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=BindColumn      value="saup_sid">
                                <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120"></object>
							<%=HDConstant.COMMENT_END%>
						</td>	
    					<td align=left width=70 class="text">기준일자</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	<%=HDConstant.COMMENT_START%>
					     	<object id=sJobDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">																				
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">																				
							</object> 일 이후 
							<%=HDConstant.COMMENT_END%>&nbsp;
						</td>		
						<td align=left width=100 class="text">전체</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
							<select name=sAll>
								<option value="Y">전체</option>
								<option value="N">범위적용</option>
							</select>
						</td>	
					</tr>
				</table>
			</td>
		</tr>
		
				
		<tr>
			<td height=420>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:190; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="영업장정보"</T>
											<T>divid="mxTab_page2"	title="동정보"</T>
											<T>divid="mxTab_page3"	title="객실타입정보"</T>
											<T>divid="mxTab_page4"	title="객실정보"</T>
											<T>divid="mxTab_page5"	title="상품정보"</T>
											<T>divid="mxTab_page6"	title="공통코드"</T>
											<T>divid="mxTab_page7"	title="매출처정보"</T>
											<T>divid="mxTab_page8"	title="옵션요금정보"</T>
											'>	
																												
									</object>
									<%=HDConstant.COMMENT_END%>	
									<div class=page id="mxTab_page1" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
									
	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
							               	<C> name='업장SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='업장코드'			ID='UPJANG_CD'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='업장명'			ID='UPJANG_NM'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='업장영문명'			ID='UPJANG_ENG_NM'		width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='업장단축명'			ID='UPJANG_SHORT_NM'	width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='업장타입'			ID='UPJANG_TYPE'		width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='직영여부'			ID='DIRECT_YN'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='사용여부'			ID='USE_YN'				width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='화면표시순서'		ID='DISPLAY_SEQ'		width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='참고사항'			ID='REMARKS'			width=100 align=left editlimit=50 show=true </C>  
							               		<C> name='사업SID'			ID='SAUP_SID'			width=100 align=left editlimit=50 show=true </C>  
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='동SID'				ID='DONG_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='동코드'			ID='DONG_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='동이름'			ID='DONG_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='영문명'			ID='DONG_ENG_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='단축명'			ID='DONG_SHORT_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='업장SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C> 
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page3" style="position:absolute; left:170; top:210; width:845; height:300">
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
										<param name="Format" 			value="
						           			<C> name='객실타입SID'				ID='ROOM_TYPE_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='업장SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='객실등급코드'			ID='ROOM_GRADE_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='배드타입'			ID='BED_TYPE_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='객실타입'			ID='ROOM_TYPE_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='객실타입명'			ID='ROOM_TYPE_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='평형'				ID='PYUNG'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='최소인원'			ID='STD_PERSONS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='최대인원'			ID='MAX_PERSONS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='화면표시순서'			ID='DISPLAY_SEQ'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='사용여부'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page4" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds4">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='객실SID'			ID='ROOM_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='객실번호'			ID='ROOM_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='시작일자'			ID='BGN_DATE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='종료일자'			ID='END_DATE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='객실전망:R'			ID='ROOM_VIEW_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='객실층'			ID='FLOORS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='사용여부:S'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='사업장SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='동SID'				ID='DONG_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='객실타입SID'		ID='ROOM_TYPE_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='참고사항'			ID='REMARKS'			width=100 align=left editlimit=50 show=true </C> 
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page5" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr5 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds5">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='상품SID'			ID='GOODS_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='상품코드'			ID='GOODS_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='상품명'			ID='GOODS_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='영문상품명'			ID='ENG_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='기본경로'			ID='COURSE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='박수'				ID='NIGHTS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='일수'				ID='DAYS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='사용여부'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page6" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr6 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds6">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='대분류'			ID='HEAD'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='소분류'			ID='DETAIL'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='소분류명'			ID='DETAIL_NM'		width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성1'				ID='ITEM1'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성2'				ID='ITEM2'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성3'				ID='ITEM3'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성4'				ID='ITEM4'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성5'				ID='ITEM5'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성6'				ID='ITEM6'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성7'				ID='ITEM7'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성8'				ID='ITEM8'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성9'				ID='ITEM9'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성10'			ID='ITEM10'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성11'			ID='ITEM11'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성12'			ID='ITEM12'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성13'			ID='ITEM13'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성14'			ID='ITEM14'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='속성15'			ID='ITEM15'			width=100 align=left editlimit=50 show=true </C> 
						           			
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page7" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr7 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds7">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='매출처SID'		ID='CLIENT_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='회계거래처'		ID='VEND_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='매출처코드'		ID='CLIENT_CD'		width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='매출처명'			ID='CLIENT_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='매출처구분'		ID='CLIENT_GU'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='대리점구분'		ID='AGEN_GU'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='직판여부'			ID='DIR_YN'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='지역코드'			ID='AREA_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='영업담당자코드'	ID='SAL_DAM_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='매출처담당자'		ID='CLIENT_DAM_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='전화번호'			ID='TEL_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='휴대전화'			ID='MOBILE_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='FAX번호'			ID='FAX_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='이메일'			ID='E_MAIL'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='우편번호'			ID='ZIP_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='주소1'			ID='ADDRESS1'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='주소2'			ID='ADDRESS2'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='수수료율'			ID='COMMI_RATE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='계약상태'			ID='CUNT_STATUS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='은행코드'			ID='BANCOD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='은행계좌번호'		ID='BANK_ACC_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='예금주'			ID='BANK_ACCT_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='사용여부'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='법인타입'			ID='VEND_TYPE'	width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='사업자번호'		ID='VEND_ID'	width=100 align=left editlimit=50 show=true </C> 
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page8" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr8 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds8">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           					<C> name='메뉴SID'			ID='MENU_SID'	width=100 align=left editlimit=12 show=true</C>
													<C> name='메뉴코드'			ID='MENU_CD'	 width=100 align=left editlimit=13 show=true</C>
													<C> name='메뉴구분코드'		ID='MENU_GUBUN_CD'	width=100  align=left editlimit=2 show=true</C>
													<C> name='메뉴구분1'			ID='MENU_ITEM1'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='메뉴구분2'			ID='MENU_ITEM2'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='메뉴구분3'			ID='MENU_ITEM3'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='메뉴구분4'			ID='MENU_ITEM4'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='메뉴구분5'			ID='MENU_ITEM5'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='적용시작일자'		ID='BGN_DATE'	 width=100 align=left editlimit=8 show=true</C>
													<C> name='적용종료일자'		ID='END_DATE'	 width=100 align=left editlimit=8 show=true</C>
													
													<C> name='시작인원'			ID='BGN_PERSONS'	width=100  align=left editlimit=4 show=true</C>
													<C> name='종료인원'			ID='END_PERSONS'	width=100  align=left editlimit=4 show=true</C>
													<C> name='메뉴명'			ID='MENU_NM'	 width=100 align=left editlimit=50 show=true</C>
													<C> name='메뉴영문명'			ID='MENU_ENG_NM'	width=100  align=left editlimit=30 show=true</C>
													<C> name='메뉴단축명'			ID='MENU_SHORT_NM'	width=100  align=left editlimit=12 show=true</C>
													<C> name='과세여부'			ID='TAX_YN'	 width=100 align=left editlimit=1 show=true</C>
													<C> name='세금계산방법'		ID='TAX_CALCU_CD'	width=100  align=left editlimit=1 show=true</C>
													<C> name='단가'				ID='UNIT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='공급가'			ID='NET_AMT'	width=100  align=left editlimit=12 show=true dec=0</C>
													<C> name='부가세'			ID='VAT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													
													<C> name='특소세'			ID='EXCISE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='교육세'			ID='EDU_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='농특세'			ID='VILLAGE_AMT' width=100 	 align=left editlimit=12 show=true dec=0</C>
													<C> name='체육기금'			ID='SPORTS_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='관광기금'			ID='TOUR_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='협회비'			ID='ASSOC_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='봉사료'			ID='TIP_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='통화코드(RV022)'	ID='CURRENCY_CD'	width=100  align=left editlimit=3 show=true</C>
													<C> name='옵션상품여부'		ID='OPTION_YN'	 	width=100 align=left editlimit=1 show=true</C>
													<C> name='옵션표시(RV023)'	ID='OPTION_VIEW_CD' width=100 	 align=left editlimit=1 show=true</C>
													
													<C> name='화면표시순서'		ID='DISPLAY_SEQ'	width=100  align=left editlimit=4 show=true</C>
													<C> name='사용여부'			ID='USE_YN'	 width=100 align=left editlimit=1 show=true</C>
													<C> name='사업SID'			ID='SAUP_SID'	width=100  align=left editlimit=12 show=true</C>
													<C> name='업장SID'			ID='UPJANG_SID' width=100 	 align=left editlimit=12 show=true</C>
													<C> name='참고사항'			ID='REMARKS'	width=100  align=left editlimit=100 show=true</C>

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
		<tr>
			<td id=resultMsg></td>
		</tr>
		<tr>
			<td>※ 조회 후 GRID 상단의 각 Tab을 한번씩 클릭한 후 [액셀] 버튼을 누르면 데이터의 잘림 없이 다운로드됩니다.</td>
		</tr>
		
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

