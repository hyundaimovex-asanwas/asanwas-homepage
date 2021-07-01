<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 출경확정 마감
 * 프로그램ID 	: CQ540I
 * J  S  P		: cq540i
 * 서 블 릿		: Cq540I
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-07-26
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
	    date.add(java.util.Calendar.DATE, -28);
	    String firstday = m_today.format(date.getTime());
	    date.add(java.util.Calendar.DATE, +30);
	    String endday = m_today.format(date.getTime());  	 
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
			sFr_date.Text='<%=firstday%>';
			sTo_date.Text='<%=endday%>';
		} 
		 
		function fnInit() {
	
		}
		
		function fnApply() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq540I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			if(ds1.IsUpdated){
                alert("수정중인 데이터가 있습니다.");
                return;
            }
            
            if(getObjectFirst("sFr_date").Text.trim()=="" 
                || getObjectFirst("sFr_date").Text.trim().length!=8){
                alert("출발일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("sFr_date").Focus();
                return;
            }
            if(getObjectFirst("sTo_date").Text.trim()=="" 
                || getObjectFirst("sTo_date").Text.trim().length!=8){
                alert("출발일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("sTo_date").Focus();
                return;
            }
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sFr_date=" + sFr_date.Text
			          + ",sTo_date=" + sTo_date.Text
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq540I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * 생성
		 */
		function fnCreate() {
			
		}
		</script>

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>	
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='close_yn' ) {
		     	if ( ds1.namevalue(1,colid) == 'T' ) {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'F';
			    } else {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'T';			    
			    }
		   }
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

<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
	<param name="SyncLoad" 	value="true">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr>
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="545"> 
					<tr height="30px">
						<td width=545>
							<table border='0' cellpadding="0" cellspacing="1" width="345" bgcolor="#666666">
								<tr>
									<td align=left class="text"  width="110">출발일자</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sFr_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											 <param name=Format      value="YYYY-MM-DD">
                                            <PARAM NAME=InputFormat value="YYYYMMDD">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                             <param name=SelectAll   value=true>
	                                        <param name=SelectAllOnClick      value=true>
	                                        <param name=SelectAllOnClickAny   value=false>																			
										</object>&nbsp;~&nbsp;
										<object id=sTo_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											 <param name=Format      value="YYYY-MM-DD">
                                            <PARAM NAME=InputFormat value="YYYYMMDD">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                             <param name=SelectAll   value=true>
	                                        <param name=SelectAllOnClick      value=true>
	                                        <param name=SelectAllOnClickAny   value=false>																		
										</object>
										<%=HDConstant.COMMENT_END%>
								 	</td>
								</tr>
							</table>
						</td>
					 	<td width='500' align=right>
							<table width='500'>
								<tr>
									<td align=right>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand"	align=absmiddle onClick="fnApply()">		<!--  -->
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
								<param name=UsingOneClick  	value="1">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								  <C> name='출발일자'    	ID='caln_date'   		width=100 	align=center 	edit=none		editlimit=8 mask=XXXX-XX-XX show=true</C>
								  <C> name='요일'  		ID='yoil_nm' 			width=50	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='마감여부√'	ID='close_yn'    		width=65 	align=center 		editlimit=1 show=true editstyle=checkbox</C>
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

