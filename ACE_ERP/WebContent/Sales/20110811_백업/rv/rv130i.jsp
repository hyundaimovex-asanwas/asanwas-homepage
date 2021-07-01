<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 기타 할인 / 할증관리
 * 프로그램ID 	: RV130I
 * J  S  P		: rv130i
 * 서 블 릿		: Rv130I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-20
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
		
		var jobFlag = "";
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			fnInit(); 
			fnSetHeaderDs1();
			
			codeDs1.deleteRow(1);
			codeDs2.deleteRow(1);
			codeDs3.deleteRow(1);
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
            	"<%=dirPath%><%=HDConstant.PATH_RV%>Rv130I",
            	"JSP(O:RV003=codeDs1,O:RV004=codeDs2, O:SY011=codeDs3, O:SSY011=sCodeDs2)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS_ALL=sCodeDs4,O:S_GOODS_DS=sCodeDs3)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);            

            //할인유형(cust_type) 검색조건 추가
            sCodeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV003&s_item1=Y";
            sCodeDs1.Reset();


		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			if (ds1.IsUpdated) {
				if (confirm("작업을 취소하고 조회하시겠습니까?")) {
					var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					          + ",sDate="+ sDate.Text
					          + ",sDc_item2=" + sDc_item2.ValueOfIndex("detail", sDc_item2.Index)
       				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
							  + ",sDc_item1=" + sDc_item1.ValueOfIndex("goods_sid",sDc_item1.Index)
			 				  + ",sDc_item3=" + sDc_item3.ValueOfIndex("saup_sid", sDc_item3.Index); //지역

					ln_TRSetting(tr1, 
					    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv130I",
					    "JSP(O:DS1=ds1)",
					    param);
					tr_post(tr1);
				} 
			} else {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sDate="+ sDate.Text
				          + ",sDc_item2=" + sDc_item2.ValueOfIndex("detail", sDc_item2.Index)
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index)
						  + ",sDc_item1=" + sDc_item1.ValueOfIndex("goods_sid",sDc_item1.Index)		//상품
		 				  + ",sDc_item3=" + sDc_item3.ValueOfIndex("saup_sid", sDc_item3.Index); 	//지역

				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv130I",
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
	                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv130I",
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
		document.all.LowerFrame.style.visibility="visible";	
	</script>
 
 	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		window.status="조회가 완료 되었습니다.";
		document.all.LowerFrame.style.visibility="hidden";
	</script>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	
	</script>	
	
	<script language="javascript"  for=gr1  event=OnColumnPosChanged(Row,Colid)>

	if (ds1.RowStatus(ds1.RowPosition) == 0) {
		gr1.ColumnProp("dc_item2","Edit")="None";
		gr1.ColumnProp("bgn_date","Edit")="None";
	} else {
	    gr1.ColumnProp("dc_item2","Edit")="";
		gr1.ColumnProp("bgn_date","Edit")="";

	}
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


<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  그리드 : 할인코드 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  그리드 : 할인적용방법 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  그리드 : 사용유무 -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 할인코드 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=sCodeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 사용유무 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=sCodeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 상품 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=sCodeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 검색 : 지역 -->
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

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
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
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
                            <object id=sDc_item3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                <param name=ComboDataID     value=sCodeDs4>
                                <param name=ListExprFormat  value="saup_nm^1^60,saup_sid^1^0">
								<param name=SearchColumn	value="saup_nm">
								<param name=BindColumn		value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>					
						<td align=left class="text" width="70">상품정보</td>
						<td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
	                        <object id=sDc_item1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=sCodeDs3>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>

						<td width='70px' class='text'>할인코드</td>
						<td width='100px' height="25px" bgcolor='#FFFFFF'>&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=sDc_item2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=sCodeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
						<td width='70px' class='text' >사용유무</td>
						<td width='100px' bgcolor='#FFFFFF' align='center'>
							<%=HDConstant.COMMENT_START%>
                            <object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=80 border="0" align=absmiddle>
								<param name=ComboDataID		value=sCodeDs2>
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
											<param name="Editable"  		value="true">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name=Viewsummary			value="1">
											<param name="Format" 			value="
											   <C> name='No.'				ID='{currow}'	width=30</C>
								               <C> name='할인코드SID'       ID='dc_sid'      	width=100 align=left editlimit=12 show=false </C>
								               <C> name='할인구분코드'  	ID='dc_gubun_cd'    width=100 align=left editlimit=1 show=false </C>
								               <C> name='지역'  			ID='dc_item3'    	width=80 align=center editlimit=50 show=true editstyle=lookup data='sCodeDs4:saup_sid:saup_nm' Show=true sumtext='계'</C>
								               <C> name='상품코드'  		ID='dc_item1'    	width=120 align=center editlimit=50 show=true editstyle=lookup data='sCodeDs3:goods_sid:goods_nm'</C>
								               <C> name='할인코드명'  		ID='dc_item2'    	width=120 align=left editlimit=50 show=true editstyle=lookup data='codeDs1:detail:detail_nm'</C>
								               <C> name='시작일'     		ID='bgn_date'    	width=85 align=CENTER editlimit=8 show=true Mask=XXXX-XX-XX</C>
								               <C> name='종료일'     		ID='end_date'    	width=85 align=CENTER editlimit=8 show=true Mask=XXXX-XX-XX</C>
								               <C> name='할인적용방법'    	ID='app_dc_cd'   	width=90 align=center editlimit=50 show=true editstyle=lookup data='codeDs2:detail:detail_nm'</C>
								               <C> name='할인적용\\(요율|금액)'  ID='app_dc_rate'    width=100 align=right editlimit=10 show=true</C>
								               <C> name='적용FOC인원'  		ID='foc_persons'    width=95 align=right editlimit=5 show=false</C>
								               <C> name='사용여부'    		ID='use_yn'   		width=80 align=center editlimit=50 show=true editstyle=lookup data='codeDs3:detail:detail_nm'</C>
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

