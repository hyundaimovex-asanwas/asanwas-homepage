<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 조장운전자 선별
 * 프로그램ID 	: CQ110I
 * J  S  P		: cq110i
 * 서 블 릿		: Cq110I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-11
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
			
			div.value = 'init';
			initDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			initDs1.Reset(); //지역코드
	    }
		/*
		 * 출경시간, 상품조회
		 */		
		function fnSelectDs3() {
		
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,menuIdx=322,"
	            + "sSaupSid=" + initDs1.namevalue(initDs1.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=initDs2,O:S_GOODS_DS=initDs3)",
	            param);
	        tr_post(tr2);
		}	
		
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoodSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sDepartDate=" + sBgnDate.text
			          + ",sDepartTime=" + lc2.ValueOfIndex("depart_time",lc2.Index)
			         
			          + ",sSaup_gu=" + sSaupGu.value;
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq110I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * 저장
		 */
		function fnApply() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq110I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
			
			fnSelect();
		}
		
	
		</script>

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
	</script>	
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)"> <!-- 지역 -->
			if (row <1) {
				return;
			}
			for (i = 1; i <= ds1.countrow; i++) {
				ds1.namevalue(i, "is_flag") = ds1.namevalue(i,"status_cd");
			}
	</script>
	
	<script language=JavaScript  for=initDs1 event="OnLoadCompleted(row)"> <!-- 지역 -->
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=initDs2 event="OnLoadCompleted(row)"> <!-- 출경시간 -->
			lc2.Index = 0;
	</script>
	
	
	<script language=JavaScript  for=initDs3 event="OnLoadCompleted(row)"> <!-- 상품 -->
			div.value = '';
			initDs3.deleteRow(1);
			lc3.Index = 0;
	</script>
	
	
	<script language=JavaScript for= lc1 event=OnSelChange()> <!-- 지역 체인지 -->
		if ( div.value != 'init') {
			fnSelectDs3();
		}
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()> <!-- 출경시간 변경 -->
		if ( div.value != 'init' ) {	//출발일자
			if ( sBgnDate.Modified ) {
				div.value = 'init';
				fnSelectDs3();			
			}
		}				
	</script>
	
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
        if(row==0){
            if(ds1.CountRow==0) return;
            
            if(colid=="status_cd"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "status_cd") = ds1.NameValue(1, "status_cd");
                }
            } 
            return;
        }
 </script>
	
	
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=initDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=initDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  출경시간 -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=initDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
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
		
		<tr>
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td align=right>
							<table width='845'>
									<tr>
										<td align=right>
											<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
											<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer"	align=absmiddle onClick="fnApply()">		<!-- 저장 -->
										</td>
									</tr>
								</table>
						</td>
					</tr>
					<tr height="10px">
						<td></td>
					</tr>
					<tr height="30px">
						<td width=845>
							<table border='0' cellpadding="0" cellspacing="1" width="845" bgcolor="#666666">
								<tr height='30px'>
									<td align=left class="text" width="80px">지역</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs1>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^120">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align=left class="text"  width="80">출발일자</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 				value="">
											<param name=Alignment 			value=1>
											<param name=Format 				value="0000-00-00">
											<param name=Cursor	 			value="iBeam">
											<param name=Border	 			value="false">		
											<param name=InheritColor      	value="true">																																																				
											<param name=ReadOnly  			value="false">
											<param name=SelectAll  			value="true">
											<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">																			
										</object>&nbsp;
									
				                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs2>
											<param name=BindColumn      value="depart_time">
				                            <param name=BindColVal      value="depart_time">
											<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
											<param name=ListExprFormat  value="depart_time_nm^0^50">
										</object>
										<%=HDConstant.COMMENT_END%>																				
									</td>																							
									<td align=left class="text" width="80">상품정보</td>
				                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
				                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs3>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^140"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
									<td  align=left class="text" width="50">구분</td>
									<td bgcolor="#ffffff" valign="middle" align='center'>
										<select name='sSaupGu'>
											<option value="50">조장</option>
											<option value="55">학단조장</option>											
											<option value="60">운전자</option>
										</select>
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
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=IndWidth" value="20">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								  <C> name='No'             ID='{STRING(CURROW)}'           Width=30 BgColor=#996699   align=center</C>
								  <C> name='선택'    		ID='status_cd'  width=30 	align=left editlimit=16 show=true EditStyle=CheckBox</C>
								  <C> name='구분'  			ID='saup_gu' 	width=100	align=left editlimit=10 show=true edit=none</C>
								  <C> name='성명'     		ID='cust_nm'    width=100 	align=left editlimit=40 show=true edit=none</C>
								  <C> name='주민등록번호'   ID='regi_no'    width=150 	align=left editlimit=11 show=true edit=none</C>
								  <C> name='RSV_SID'    	ID='rsv_sid'   	width=110 	align=left editlimit=11 show=false edit=none</C>
								  <C> name='IS_FLAG'    	ID='is_flag'   	width=110 	align=left editlimit=11 show=false edit=none</C>
								 ">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<input type='hidden' name='div' value=''>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

