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
 * [2009-09-21][심동현] plz 추가
 
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
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");

			document.all.gridlayer1.style.display="none";
			document.all.gridlayer2.style.display="none";
			document.all.gridlayer3.style.display="none";

			fnInit();
		} 
		 
		function fnInit() {
		
			sJob_date.text='<%=firstday%>';	
    	    ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds_saup.Reset(); //지역코드		        
		}
		
		
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var saupSid = lc1.ValueOfIndex("saup_sid", lc1.Index);
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sJob_date=" + sJob_date.Text
			          + ",sClientSid=" + sClientSid.value;

			if(saupSid==1){	//금강산의 경우
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
				    "JSP(O:DS1=ds1)",
				    param);
			}else if(saupSid==2){	//개성의 경우
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
				    "JSP(O:DS2=ds2)",
				    param);
			}else if(saupSid==5){	//PLZ의 경우
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
				    "JSP(O:DS3=ds3)",
				    param);
			}			
			
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
			
			var saupSid = lc1.ValueOfIndex("saup_sid", lc1.Index);

			if(saupSid==1){	//금강산의 경우
		        getObjectFirst("gr1").SetExcelTitle(0, "");
		        getObjectFirst("gr1").SetExcelTitle(1, "value:금강산 월간 예약현황(숙소별) 출력; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr1").GridToExcel("금강산월간 예약현황(숙소별)","금강산 월간 예약현황(숙소별).xls", 8);
			}else if(saupSid==2){	//개성의 경우
		        getObjectFirst("gr2").SetExcelTitle(0, "");
		        getObjectFirst("gr2").SetExcelTitle(1, "value:개성 월간 예약현황(숙소별) 출력; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr2").GridToExcel("개성월간 예약현황(숙소별)","개성 월간 예약현황(숙소별).xls", 8);
			}else if(saupSid==5){	//PLZ
		        getObjectFirst("gr3").SetExcelTitle(0, "");
		        getObjectFirst("gr3").SetExcelTitle(1, "value:PLZ 월간 예약현황(숙소별) 출력; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr3").GridToExcel("PLZ월간 예약현황(숙소별)","PLZ 월간 예약현황(숙소별).xls", 8);
			}


				        
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
	    
		function fnSetGrid() {
			var saupSid = lc1.ValueOfIndex("saup_sid", lc1.Index);
			if(saupSid==1){
				document.all.gridlayer1.style.display="";
				document.all.gridlayer2.style.display="none";
				document.all.gridlayer3.style.display="none";				
			}else if(saupSid==2){
				document.all.gridlayer1.style.display="none";
				document.all.gridlayer2.style.display="";
				document.all.gridlayer3.style.display="none";				
			}else if(saupSid==5){
				document.all.gridlayer1.style.display="none";
				document.all.gridlayer2.style.display="none";
				document.all.gridlayer3.style.display="";
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

	<script language=JavaScript for=lc1 event=OnSelChange()>
	//지역 콤보 변경 할때.. 그리드 변하기
			fnSetGrid();
	</script>	

<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 금강산그리드  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 개성그리드  -->
	<param name="SyncLoad" 	value="true">
</object>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr height="30px">
			<td width='545px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr height='30px'>
						<td align="center" width="70px" height="30px" class="text" >대리점</td>
						<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
                            <input type="text" name='sClientNm' id='sClientNm' value='' size='20' readonly='readonly'  class='textbox'>
                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
						</td>

						<td align=left class="text" width="70px">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
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
							<div id=gridlayer1 style="display:;">
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
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
   						            
   						              	<FC> name='합계'    		ID='U_TT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='해금강'    	ID='U_HH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='비치'    		ID='U_FH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='팬션'    		ID='U_PT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='캠핑카'    	ID='U_CC'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='금강산'    	ID='U_GH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='별관'    		ID='U_GB'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='외금강'    	ID='U_MH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='구룡'    		ID='U_NV'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='온천'    		ID='U_OV'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='아난티'  		ID='U_AG'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='지오돔'    	ID='U_FD'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='텐트'    		ID='U_YT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일'    		ID='U_1D'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='사업자'    	ID='U_ZA'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='TOT_CHK'		ID='tot_chk'		width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
							</div>
							
							<div id=gridlayer2 style="display:;">
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds2">
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
   						            
   						              	<FC> name='합계'    		ID='U_TT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='박연'    		ID='U_BY'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='영통'    		ID='U_YT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='왕릉'    		ID='U_WR'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>

										<C> name='TOT_CHK'		ID='tot_chk'		width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
							</div>

							<div id=gridlayer3 style="display:;">
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
   						             	<FC> name='상품'    	ID='SHORT_NM'   	width=60 align=left 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=3</FC>
   						              	<FC> name='출력순서'    ID='PRT_SEQ'   		width=100 align=left 	editlimit=50 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=4</FC>
   						            
   						              	<FC> name='합계'    	ID='U_TT'   	width=85 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='당일(연천)'   ID='U_1001'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일(화천)'   ID='U_DHC'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일(가평)'   ID='U_DGP'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일(화성)'   ID='U_DHS'  	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일(횡성)'   ID='U_DHW'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일(양구)'   ID='U_DYG'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='당일(안산)'   ID='U_DAS'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='당일(구리)'   ID='U_DGR'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='당일(파주)'   ID='U_DPJ'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='당일(포천)'   ID='U_DPC'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='당일(한강)'   ID='U_DHR'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										
   						              	<C> name='양구(호텔)' 	ID='U_YGH'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='양구(펜션)' 	ID='U_YGP'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='속초(콘도)' 	ID='U_SCC'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='태안(수련)' 	ID='U_TAH'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='화천(텐트)' 	ID='U_HCD'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	
   						              	<C> name='하동(한옥)' 	ID='U_HDS'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>

   						              	<C> name='카멜리아' 	ID='U_FCM'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='크루즈훼리' 	ID='U_FCF'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='부관훼리' 	ID='U_FBG'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='스키캠프' 	ID='U_SSW'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='티켓전용' 	ID='U_TKO'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	
   						              	<C> name='제주그랜드' 		ID='U_JGR'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='제주뉴아일랜드' 	ID='U_JNI'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='제주뉴제주' 		ID='U_JNJ'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='펜스타' 			ID='U_FST'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	
										<C> name='TOT_CHK'		ID='tot_chk'	width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
							</div>

						</td>
						
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td>
※ 월간예약현황의 수치는 아래와 같은 조건으로 조회됩니다.<br>
　1. 기본 조건<br>
　　1.1. 고객구분=<b>관광객</b>("10") 이면서 사업구분=<b>일반("10") 또는 정부지원("20")</b> 인 고객<br>
　　1.2. 사업구분=<b>북측초청</b>("30")  또는 <b>이산가족</b>("40") 인 고객 (<b>고객구분에 관계없이</b> 모두 조회)<br>
<br>
　2. 계산식<br>
　　2.1. 일반예약 관광객 수 (실입력 기준)<br>
　　2.2.1. 유효 블록(OK,PK,DK)이 <b>아닌</b> 블록예약 관광객 수 (실입력 기준)<br>
　　2.2.2. 유효 블록(OK,PK,DK)의 확정 인원수와 해당 블록의 실입력 관광객 수 중에 큰 수<br>
　　※ 위 3가지를 다 더해서 보여줍니다.<br>
			</td>
		</tr>
	</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

