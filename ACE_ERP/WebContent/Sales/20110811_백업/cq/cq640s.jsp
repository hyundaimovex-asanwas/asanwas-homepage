<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 출발일별 현황
 * 프로그램ID 	: AC020S
 * J  S  P		: ac020s
 * 서 블 릿		: Ac020S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-27
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
		
		sSDate.text='<%=firstday%>';
                  
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";
		 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=codeDs1,O:RM015=codeDs2)",
            param);
            
        tr_post(tr1);		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sSDate.text.trim() == '' ) {
			alert("입경일자 입력해주세요.");
			return;
		}    

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaup_sid=" +codeDs1.namevalue(codeDs1.rowposition,"saup_sid") + ","        
            + "sSDate=" + sSDate.text + ","
            + "sSTime=" + codeDs2.namevalue(codeDs2.rowposition,"detail");
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq640S",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);

    }
 	
  	function fnExcel() {
            if(ds1.CountRow==0 && ds2.CountRow==0 && ds3.CountRow ==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:입경 UNC명단; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("입경 UNC명단", "입경 UNC명단.xls", 32);        
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
	
<script language=JavaScript  for=codeDs2 event="OnLoadCompleted(row)">
	codeDs2.insertRow(1);
	codeDs2.namevalue(codeDs2.rowposition, "detail") = "";
	codeDs2.namevalue(codeDs2.rowposition, "detail_nm") = "전체";
	
	sSTime.Index = 0;
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
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!-- 입경시간 -->
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr>
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
    					<td align=left width=70 class="text">&nbsp;입경일자</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	<%=HDConstant.COMMENT_START%>
					     	<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
							</object>
							<%=HDConstant.COMMENT_END%>&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=sSTime classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs2>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%;detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							<%=HDConstant.COMMENT_END%>																				
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
		<tr height="10px">
			<td></td>
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
																				
							             <G> name='순번' 
							               		<C>   name='Order' 			ID='{CURROW}'     width=50 align=left editlimit=50 show=true</C> 
							             </G>
							             
							             <G>name='소속'
											<C> name='Job' 				ID='COMPANY_NM'  width=100 align=left editlimit=50 show=true</C> 
										 </G>
										
										<G> name='직책'
											<C> name='Duty' 			ID='POSITIONS'   width=100 align=left editlimit=50 show=true</C> 
										</G>
										
										<G> name='성명'
											<C> name='Name' 			ID='CUST_NM'     width=150 align=left editlimit=50 show=true</C> 
										</G>
										
										<G> name='성별'
											<C> name='Sex' 			ID='SEX'         width=40 align=left editlimit=50 show=true</C> 
										</G>
										
										<G> name='주민등록번호'
											<C> name='KID' 	ID='REGI_NO'     width=120 align=left editlimit=50 show=true</C> 
										</G>
										
										<G> name='주소'
											<C> name='Address' 			ID='ADDRESS1'    width=150 align=left editlimit=50 show=true</C> 
										</G>
										
										<G> name='비고'
											<C> name='etc' 			ID='ETC'         width=150 align=left editlimit=50 show=true</C> 
										</G>
										
										<G> name='탑승차량'
											<C> name='Car No' 		ID='CAR_NO'      width=100 align=left editlimit=50 show=true</C> 
										</G>
										
										
											<C> name='생년월일' 		ID='BIRTHDAY'    width=100 align=left editlimit=50 show=true </C> 
											<C> name='반' 			ID='CLASS'       width=100 align=left editlimit=50 show=true</C>     
											<C> name='조' 			ID='TEAMS'       width=40 align=left editlimit=50 show=true</C>     
											<C> name='순번' 			ID='TOUR_NO'     width=100 align=left editlimit=50 show=true</C> 

											
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

