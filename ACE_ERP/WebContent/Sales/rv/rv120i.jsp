<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 주말할증관리
 * 프로그램ID 	: RV120I
 * J  S  P		: rv120i
 * 서 블 릿		: Rv120I
 * 작 성 자		: 심동현
 * 작 성 일		: 2008-07-22
 * [ 수정일자 ][수정자] 내용
 * [2008-07-22][심동현] 신규메뉴 생성
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
		
		var jobFlag = "";
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			fnInit(); 
			fnSetHeaderDs1();
		} 
			

		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				s_temp += "DC_SID:INT,"
					   +"DC_GUBUN_CD:STRING,"
					   +"DC_ITEM2:STRING,"
					   +"BGN_DATE:STRING,"
					   +"END_DATE:STRING,"
					   +"APP_DC_CD:STRING,"
					   +"APP_DC_RATE:STRING,"
					   +"FOC_PERSONS:INT,"
					   +"USE_YN:STRING,"
				
				ds1.SetDataHeader(s_temp);
			}
		}	
			
		 
		/*
		 * 초기작업
		 * Header 설정 
		 * RV003 할인코드, RV004 할인적용방법 SY011 사용유무
		 */
		function fnInit(){
    	   jobFlag = "INIT";

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_GOODS_DS=ds_goods)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);            

	        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds_saup.Reset(); //지역코드

	        ds_season.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RM006&s_Item1=Y";
	        ds_season.Reset(); //시즌

	        ds_useYN.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY011&s_Item1=Y";
	        ds_useYN.Reset(); //사용유무

	        ds_G_useYN.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY011&s_Item1=Y";
	        ds_G_useYN.Reset(); //사용유무 Grid

	        ds_G_useYN.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY011&s_Item1=Y";
	        ds_G_useYN.Reset(); //사용유무 Grid

	        ds_G_age.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=RV014&s_Item1=Y";
	        ds_G_age.Reset(); 	//연령코드 Grid

	        
		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			if (ds1.IsUpdated) {
				alert("수정중인 행이 있어 조회할 수 없습니다.");
			} else {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sDate="	+ sDate.Text												//기준일자
						  + ",sSaup=" 	+ lc_saup.ValueOfIndex("saup_sid",lc_saup.Index)			//지역
		 				  + ",sGoods=" 	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index) 		//상품
			 			  + ",sSeason=" + lc_season.ValueOfIndex("DETAIL", lc_season.Index)   		//시즌
  				          + ",sUse_yn=" + lc_useYN.ValueOfIndex("detail", lc_useYN.Index);			//사용유무
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv120I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
		}
			
		
			
		/*
		 * 저장
		 */
		function fnApply() {
			var row=ds1.countRow;
			
			if (ds1.IsUpdated) {
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv120I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            		tr_post(tr1);
			}			
		}
		
		/*
		 * 행삭제
		 */
		 
		function fnDeleteRowDs1() {
			 ds1.DeleteRow(ds1.rowposition);
			
		}
		 
		/*
		* 행추가 
		*/
		function fnAddRowDs1() {
			ds1.addRow();
		}
		 
		/*
		 * 취소 
		 */
		function fnCancel() {
			ds1.undoall();
		}
		
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>

	
 
	<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	</script>
 
 	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		window.status="조회가 완료 되었습니다.";
	</script>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	
	
	<script language="javascript"  for=gr1  event=OnColumnPosChanged(Row,Colid)>
/*	if (ds1.RowStatus(ds1.RowPosition) == 0) {
		gr1.ColumnProp("dc_item2","Edit")="None";
		gr1.ColumnProp("bgn_date","Edit")="None";
	} else {
	    gr1.ColumnProp("dc_item2","Edit")="";
		gr1.ColumnProp("bgn_date","Edit")="";

	}*/
  </script>
	
	
	
	

<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  대리점 조회 -->
	<param name="SyncLoad" 	value="false">
</object>


<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 할인코드 -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 지역 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 상품 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds_season classid=<%=HDConstant.CT_DATASET_CLSID%>> 	<!-- 검색 : 시즌 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_useYN classid=<%=HDConstant.CT_DATASET_CLSID%>> 	<!-- 검색 : 사용유무 -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds_G_useYN classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 그리드 : 사용유무 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds_G_age classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  그리드 : 할인코드 -->
	<param name="SyncLoad" 	value="false">
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
			<td width='465px'></td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='380px'>
					<tr>
						<td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr height='10px'>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan=3>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" Wdith=845>
					<tr>
						<td width='70px' height="25px" class='text'>기준일자</td>
						<td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=sDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                <param name=Text        value="<%=firstday%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        <td class="text" width="40px">지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_saup>
                                <param name=ListExprFormat  value="saup_nm^0^60,saup_sid^1^0">
								<param name=SearchColumn	value="saup_nm">
								<param name=BindColumn		value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>					
						<td align=left class="text" width="70">상품정보</td>
						<td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
	                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>

                        <td WIDTH=40 class=text>시즌</td>
                        <td Wdith=100 bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=lc_season classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=90 align=absmiddle>
                                <param name=ComboDataID         value=ds_season>
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="DETAIL_NM^0^90">
                                <param name=BindColumn          value="DETAIL">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
						<td width='70px' class='text' >사용유무</td>
						<td width='100px' bgcolor='#FFFFFF' align='center'>
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_useYN classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=80 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_useYN>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>

					</tr>
				</table>
			</td>

		</tr> 
		<tr height='10px'>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px' height='410px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='410px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="False">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name=Viewsummary			value="1">
											<param name="Format" 			value="
											   <C> name='No.'				ID='{currow}'	width=30</C>
								               <C> name='지역'  			ID='dc_item3'    	width=80 align=center editlimit=50 show=true editstyle=lookup data='ds_saup:saup_sid:saup_nm' Show=true sumtext='계'</C>
								               <C> name='상품코드'  		ID='dc_item1'    	width=120 align=center editlimit=50 show=true editstyle=lookup data='ds_goods:goods_sid:goods_nm'</C>
								               <C> name='시작일'     		ID='bgn_date'    	width=85 align=CENTER editlimit=8 show=true Mask=XXXX-XX-XX</C>
								               <C> name='종료일'     		ID='end_date'    	width=85 align=CENTER editlimit=8 show=true Mask=XXXX-XX-XX</C>
								               <C> name='연령'  		  	ID='APP_PERSONS'   	width=60 align=center editlimit=50 show=true  editstyle=lookup data='ds_G_age:detail:detail_nm'</C>
								               <C> name='할증적용방법'    	ID='APP_DC_NM'   	width=90 align=center editlimit=50 show=true </C>
								               <C> name='할증적용\\(요율|금액)'  ID='app_dc_rate'    width=90 align=right editlimit=10 show=true decao=0</C>
								               <C> name='사용여부'    		ID='use_yn'   		width=80 align=center editlimit=50 show=true editstyle=lookup data='ds_G_useYN:detail:detail_nm'</C>
								        	">											
										</object>	
										<%=HDConstant.COMMENT_END%>								
									</td>
								</tr>
							</table>
						</td>
						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
			  <TABLE WIDTH=845 BORDER=0>
			    <TR>
			      <TD WIDTH=50%>
				2008년 일반 시즌  <BR>
				　비성수기 : 1.1~3.21 / 11.30~12.31 <BR>
				　평 수 기 : 3.22~4.11 / 6.1~7.11 / 11.16~11.29<BR>
				　성 수 기 : 4.12~4.30 / 5.12~5.31 / 7.12~9.26 / 11.2~11.15<BR>
				　최성수기 : 5.1~5.11 / 9.27~11.1<BR><BR>
			      </TD>
			      <TD WIDTH=50%>
				2008년 학생단체 시즌  <BR>	
				　비성수기 : 1.1~3.31<BR>
				　성 수 기 : 4.1~7.19 / 8.21~11.30<BR>
				　최성수기 : 7.20~8.20<BR>
			      </TD>
			    </TR>
			  </TABLE>
			</td>
		</tr>
		
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

