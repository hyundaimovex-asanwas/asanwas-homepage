<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 예약확정명단
 * 프로그램ID 	: RV810S
 * J  S  P		: rv810s
 * 서 블 릿		: Rv810S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-06
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-12-15][박경국] 예약확정명단(결재용) 화면 생성 
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
				
			fnInit();
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			div = 'init';
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds2.Reset(); //지역코드
	   }
		
		/*
		 * 출경시간, 상품조회
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + lc1.ValueOfIndex("saup_sid",lc1.Index) + ","
				+ "sDepartDate=" + sBgnDate.text;
				
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
	            param);
	        tr_post(tr1);
		}	
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sClient_sid=" + sClientSid.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",sJobsel=" + sJobsel.value;
			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv812S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:예약확정명단(사업자); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("예약확정명단(사업자)","예약확정명단(사업자).xls", 8);
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
	    /**
     * 신청서 번호 조회
     */
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop("<%=dirPath%>");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
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
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
	</script>

	<script language=JavaScript for= lc1 event=OnSelChange()>
		if ( div != 'init' ) {	//지역
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	
	<script language=JavaScript for= lc2 event=OnSelChange()>
		if ( div != 'init' ) {	//출경시간
			div = 'init';					
		}
	</script>		
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		div = "";		
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
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  출경시간 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
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
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table   border='0' cellpadding='0' cellspacing='1' width='650' bgcolor='#666666'>
								<tr>
									<td align="center" width="70px" height="30px" class="text" >대리점</td>
									<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='15' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
									</td>
									 <td width="80px" height="25px" class="text">신청서번호</td>
		                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
		                                        <param name=Format      value="00000000000000">
		                                        <param name=Alignment   value=1>
		                                        <param name=ClipMode    value=true>
		                                        <param name=Border      value=false>
		                                        <param name=SelectAll   value=true>
		                                        <param name=SelectAllOnClick      value=true>
		                                        <param name=SelectAllOnClickAny   value=false>
		                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
					            <td align=left class="text" width="40px">신분</td>
					            <td align="left" bgcolor="#ffffff" colspan=3>&nbsp;
			    					<select name="sJobsel">
										 <option value="1">관광객</option>
										 <option value="2" SELECTED>사업자</option>
										 <option value="3">관광도우미</option>
									</select>
								</td>

								</tr>
							</table>
						</td>
						<td>
							<table   border='0' cellpadding='0' cellspacing='0' width='195'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
									</td>
								</tr>
							</table>
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
					<tr height='30px'>
						<td align=left class="text" width="100px">지역</td>
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
						<td align=left class="text"  width="110">출발일자</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
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
						
	                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds3>
								<param name=BindColumn      value="depart_time">
	                            <param name=BindColVal      value="depart_time">
								<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
								<param name=ListExprFormat  value="depart_time_nm^0^50">
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=left class="text" width="110">상품정보</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
								<%=HDConstant.COMMENT_START%>
	                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds4>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
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
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <FC>name='대리점코드'    	ID='client_cd'  	width=80	align=left editlimit=5 show=false </FC>
						              <FC>name='대리점명'    	ID='client_nm'   	width=140 	align=left editlimit=50 show=true suppress=1</FC>
						              <C> name='출발일'    	    ID='depart_date'   	width=60 	align=center editlimit=16 show=true</C>
						              <C> name='상품명'      	ID='goods_nm'   	width=90 	align=left editlimit=30 show=true suppress=2</C>
						              <FC>name='성명'      		ID='cust_nm'   		width=60 	align=left editlimit=30 show=true</FC>
						              <C> name='직장/직위'   	ID='company_nm' 	width=200 	align=left editlimit=61 show=true</C>
						              <C> name='생년월일'    	ID='manage_no'   	width=100	align=left editlimit=14 show=true</C>
						              <C> name='방문목적'		ID='VISIT_AIM'		width=100 	align=left Edit=None </C>
						              <C> name='방문기간'		ID='VISIT_DATES'	width=130 	align=center Edit=None</C>
						              <C> name='할인유형'		ID='CUST_TYPE_NAME'	width=100 	align=left Edit=None </C>
						              <C> name='요금'			ID='TOT_TOUR_AMT'	width=80 	align=center Edit=None	decao=0</C>
						              <C> name='입력자'			ID='i_empnm'		width=60	align=left show=true	</C>
						              <C> name='M_RSV_SID'    	ID='m_rsv_sid'   	width=100 	align=left editlimit=12 show=false</C>
						              <C> name='RSV_SID'      	ID='rsv_sid'     	width=100 	align=left editlimit=12 show=false</C>
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

