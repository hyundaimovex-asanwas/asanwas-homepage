<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 조장운전자 생성
 * 프로그램ID 	: CQ100I
 * J  S  P		: cq100i
 * 서 블 릿		: Cq100I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-11
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-07-24][심동현] 상품 조건을 추가 (생성/조회/삭제시 상품별로)
 *						동시에 데이터셋, 럭스콤보 등의 명명방식을 좀 정리해야 할 것 같음.
 *						조건에서 자주 쓰이는 것들 싹 정리해야 할 듯 합니다.
 *						예를 들면 ds_saup, ds_goods, ... , lc_saup, lc_goods 이런시긍로.. 명명규칙을.!!!
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
        var v_job = "H";
        var div='';

		/*
		 * 페이지로딩 
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			
			fnInit(); 
		} 
		
		//페이지 초기화
		function fnInit() {
			div="init";
			sJob_date.text='<%=firstday%>';	
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드 
	        
		}
		
		//생성버튼
		function fnApply() {	
			fnCreate();	//생성
			fnSelect();	//조회
		}
		
		//삭제버튼
		function fnDelete() {
			fnDeleteDs1();	//삭제
			fnSelect();		//조회
		}
		
		//메인 조회
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid="+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",sJob_date=" + sJob_date.Text
			          + ",sJob_seq=" + sJob_seq.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq100I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * 생성
		 */
		function fnCreate() {
			if(lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)=="0" ){
				alert("상품='전체'로 생성 불가합니다. 상품을 선택해주세요"); 
			}else{
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
				          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				          + ",sGoods_sid="+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)				          
				          + ",sJob_date=" + sJob_date.Text
			        	  + ",sJob_seq=" + sJob_seq.value;
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq100I",
				    "JSP(O:DS1=ds1)",
				    param);
				   
				tr_post(tr1);
			};
		}
		
		/*
		 * 삭제 
		 */
		function fnDeleteDs1() {
			if(lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)=="0" ){
				alert("상품='전체'로 삭제 불가합니다. 상품을 선택해주세요"); 
			}else{
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
				          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				          + ",sGoods_sid="+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)			          
				          + ",sJob_date=" + sJob_date.Text
				          + ",sJob_seq=" + sJob_seq.value;
				      
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq100I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			};
		}
		
		
		//상품조회
		function fnSelectGoodsLC() {
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
	            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				+ ",sDepartDate=" + sJob_date.Text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_GOODS_DS=ds_goods)",
	            param);
	        tr_post(tr2);
		};
		</script>

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	


	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//상품 재검색
	</script>	

	<script language=JavaScript for=sJob_date event=OnKillFocus()> <!-- 출경시간 변경 -->
		fnSelectGoodsLC();			
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

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 상품 -->
	<param name="SyncLoad" 	value="false">
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
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="545"> 
					<tr height="30px">
						<td width=545>
							<table border='0' cellpadding="0" cellspacing="1" width="645" bgcolor="#666666">
								<tr>
									<td align=center class="text" width="60">지역</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_saup>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^60">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align=center class="text"  width="70">출발일자</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sJob_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox" style= "width:65px; height:17px;">			
											<param name=Text 				value="">
											<param name=Alignment 			value=1>
											<param name=Format 				value="0000-00-00">
											<param name=Cursor	 			value="iBeam">
											<param name=Border	 			value="false">		
											<param name=InheritColor      	value="true">																																																				
											<param name=ReadOnly  			value="false">
											<param name=SelectAll  			value="true">
											<param name=SelectAllOnClick  	value="false">																					
										</object>&nbsp;
										<%=HDConstant.COMMENT_END%>
								 	</td>
									<td align=center class="text" width="60">상품</td>
									<td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
				                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_goods>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^100"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
								 	
								 	<td align=center class="text" width="70">작업구분</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<select name="sJob_seq">
											<option value="1">조장</option>
											<option value="3">학단조장</option>
											<option value="2">운전자</option>
										</select>
									</td>	
								</tr>
							</table>
						</td>
					 	<td width='300' align=right>
							<table width='200'>
								<tr>
									<td align=right>
										<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"	align=absmiddle onClick="fnApply();">		<!-- 생성 -->
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/delete.gif"	style="cursor:hand"	align=absmiddle onClick="fnDelete()">		<!--  -->
									</td>
								</tr>
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
			<td colspan=2>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td width='845'>
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
								  <C> name='신청서번호'    	ID='accept_no'   width=150 	align=left editlimit=16 show=true</C>
								  <C> name='출발일자'  		ID='depart_date' width=200	align=left editlimit=10 show=true</C>
								  <C> name='상품명'     		ID='goods_nm'    width=200 	align=left editlimit=40 show=true</C>
								  <C> name='조장수'       	ID='jo_cnt'      width=80 	align=right editlimit=11 show=true</C>
								  <C> name='학단조장수'     ID='stu_jo_cnt'      width=80 	align=right editlimit=11 show=true</C>								  
								  <C> name='운전자수'    	ID='drive_cnt'   width=80 	align=right editlimit=11 show=true</C>
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

