<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 자동차 운행계획서
 * 프로그램ID 	: CQ230S
 * J  S  P			: cq230s_biz
 * 서 블 릿		: CQ230S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-06
 * [수  정   일  자][수정자] 내용
 * [2010-04-06][박경국] 자동차 운행계획서 신규.
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
			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			fnInit();
			codeDs3.deleterow(1);
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			div = 'init';
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds2.Reset(); //지역코드
			
			//정산시기
            codeDs3.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV036&s_item1=Y";
            codeDs3.Reset();
            //정산담당
            codeDs4.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV035&s_item1=Y";
            codeDs4.Reset();
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
			          + ",dsType=1"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sClient_sid=" + sClientSid.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",sJobsel=" + sJobsel.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq230S",
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
	<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	pr1.PreView();
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
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table   border='0' cellpadding='0' cellspacing='1' width='700' bgcolor='#666666'>
								<tr>
									<td align="center" width="100px" height="30px" class="text" >대리점</td>
									<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='15' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
									</td>
									 <td width="100px" height="25px" class="text">신청서번호</td>
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
							<table   border='0' cellpadding='0' cellspacing='0' width='145'>
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
						<td align=left class="text"  width="100">출발일자</td>
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
						<td align=left class="text" width="100">상품정보</td>
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
						              <C> name='순'    			ID='{CURROW}'   width=40		align=center 	show=true </C>
						              <C> name='차종'    		ID='CAR_TYPE'   	width=80 		align=center 	show=true </C>
						              <C> name='차량명'        	ID='CAR_NM'       	width=80 		align=center 	show=true</C>
						              <C> name='차량번호'    	ID='CAR_NO'   		width=100 		align=center 	show=true</C>
						              <C> name='승차\\정원'    	ID='CAR_PERSONS'    					width=40 		align=center  	show=true</C>
						              <C> name='(운전자)/\\동승여부'     ID='DRIVE_YN'     		width=60 		align=center 	show=true </C>
						              <C> name='회사명\\(협력업체)'    	ID='COMPANY_NM'  width=100 	align=center  	show=true </C>
						              <C> name='직위'      		ID='POSITIONS'     						width=60 		align=left 	 		show=true</C>
						              <C> name='성명'   			ID='CUST_NM'  							width=60 	align=left 	 		show=true</C>
						              <C> name='주민등록번호'   			    ID='MANAGE_NO'  	width=100		align=center 	show=true</C>
						              <C> name='연락처\\(핸드폰번호)'    ID='MOBILE_NO'    	width=100 	align=center 	show=true</C>
						              <C> name='운행구간'    						ID='DRIVE_GU'   		width=200 		align=center 	show=true</C>
						              <C> name='운행신청'      					ID='DRIVE_ACCEPT'     	width=100 		align=center 	show=true</C>
						              <C> name='출경일\\(북행)'        		ID='DEPART_DATE'  width=60 		align=center	show=true</C>
						              <C> name='복귀일\\(남행)' 			ID='ARRIVE_DATE' 	width=60 		align=center 	show=true</C>
						              <C> name='방문목적'      					ID='NORTH_PURPOSE' 	width=100 	align=center show=true</C>
						              <C> name='비고' 								ID='REMARKS' 			 width=100 	align=center show=true </C>
               					">
							</object>   
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
				<B>*** 주의사항 ***</B><BR>
				1.성명: 공백없이 기재<BR>
				2.주민등록번호: '-'없이 기재<BR>
				3.운행신청:ex)수송장비,수출차량(장기)<BR>
				4.방문목적:자세히 기재
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

