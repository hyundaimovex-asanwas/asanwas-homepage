<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 입경 UNC 명단
 * 프로그램ID 	: CQ320S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2008-05-13
 * [수  정   일  자][수정자] 내용
 * [2008-05-13][심동현] 출경명단 화면 복사하여 제작..
 * [2009-07-08][심동현] 상품, 입경시각 조회 조건 재설정
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
   	date.set(java.util.Calendar.HOUR_OF_DAY, 120);         
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
		// 페이지 로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		} 

		//초기화
		function fnInit() {
			sEndDate.text='<%=firstday%>';	
	        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드
	        
		}
		// 지역별입경시간 조회
		function fnSelectLcArTime() {
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            	  + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid")+","
		              + "sArriveDate=" + sEndDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_ARRIVE_TIME_DS=ds_ar_time)",
	            param);
	        tr_post(tr2);
		}	

		//상품조회
		function fnSelectLcGoods() {
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
					+ ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
					+ ",sDepartDate=";	//입경일자 기준이라서 패스
			ln_TRSetting(tr3, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=ds_goods)",
			    param);
			tr_post(tr3);
		};


		// 메인 조회
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sArriveDate=" + sEndDate.Text
			          + ",sArriveTime=" + lc_ar_time.ValueOfIndex("detail", lc_ar_time.Index)
					  + ",sGoodsSid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",sJobsel=" + sJobsel.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq320S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
	
		// 엑셀
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:UNC 명단출력; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("UNC 명단출력","UNC 명단출력.xls", 8);
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

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectLcGoods();
		fnSelectLcArTime();
	</script>	

	<script language=JavaScript for=sEndDate event=OnKillFocus()>
		if ( sEndDate.Modified ) {
			div = 'init';
			fnSelectLcArTime();			
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
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  입경시간 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품(출) -->
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td width='695px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
				  <tr height='24px'>
					<td align=left class="text" width="70">지역</td>
                    <td align=left bgcolor="#ffffff">&nbsp;																										
						<%=HDConstant.COMMENT_START%>
                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds_saup>
							<param name=BindColumn      value="saup_sid">
                            <param name=BindColVal      value="saup_sid">
							<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^100">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>	
					<td align=left class="text"  width="70">입경일자</td>
                    <td align=left bgcolor="#ffffff" width=160>&nbsp;																							
						<%=HDConstant.COMMENT_START%>
						<object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
							<param name=Text 		value="">
							<param name=Alignment 	value=1>
							<param name=Format 		value="0000-00-00">
							<param name=Cursor	 	value="iBeam">
							<param name=Border	 	value="false">		
							<param name=InheritColor      value="true">																																																				
							<param name=ReadOnly  	value="false">
							<param name=SelectAll  	value="true">
							<param name=SelectAllOnClick  	value="true">		
							<param name=SelectAllOnClickAny  	value="false">																				
						</object>&nbsp;
                        <object id=lc_ar_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle >
							<param name=ComboDataID		value=ds_ar_time>
							<param name=BindColumn      value="detail">
                            <param name=BindColVal      value="detail">
							<param name=EditExprFormat	value="%,%;detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^40">
						</object>
						<%=HDConstant.COMMENT_END%>																				
					</td>
					<td align=left class="text" width="70">상품(출)</td>
                    <td align=left bgcolor="#ffffff">&nbsp;																										
						<%=HDConstant.COMMENT_START%>
                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds_goods>
                            <param name=SearchColumn        value="GOODS_NM">
                            <param name=Sort                value="false">
                            <param name=ListExprFormat      value="GOODS_NM^0^130">
                            <param name=BindColumn          value="GOODS_SID">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
				  </tr>
				  <tr height='24px'>
		            <td align=left class="text" width="70px">고객구분</td>
		            <td align="left" bgcolor="#ffffff" colspan=5>&nbsp;
    					<select name="sJobsel">
							 <option value="0">전체</option>
							 <option value="1">관광객</option>
							 <option value="2">사업자</option>
							 <option value="3">관광도우미</option>
						</select>
					</td>
				  </tr>
				</table>
		
			</td>
			<td width='150px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='150'>
					<tr>
						<td align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
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
								<param name=ViewSummary     value=1>
								<param name="Format" 			value="
								 <C> name='순번'   		ID='{CURROW}'  width=50 align=center editlimit=62 	show=true SumText='합계'</C>
					               <C> name='소속'   		ID='company_nm'  width=150 align=center editlimit=62 	show=true SumText=@count</C>
					               <C> name='직책'    		ID='positions'   width=100 align=center editlimit=62 	show=true</C>
					               <C> name='성명'      		ID='cust_nm'     width=200 align=center editlimit=93 	show=true</C>
					               <C> name='성별'  			ID='sex'         width=40 align=center editlimit=50 	show=true</C>
					               <C> name='주민등록번호'    ID='regi_no'     width=130 align=center editlimit=32 	show=true </C>
					               <C> name='주소'     		ID='address1'    width=150 align=center editlimit=60 	show=true</C>
					               <C> name='CUST_SID'     	ID='cust_sid'    width=100 align=center editlimit=12 	show=false</C>
					               <C> name='CUST_GU'      	ID='cust_gu'     width=100 align=center editlimit=1 	show=false</C>
					               <C> name='COUNTRY_GU'   	ID='country_gu'  width=100 align=center editlimit=2 	show=false</C>
					               <C> name='COUNTRY_CD'   	ID='country_cd'  width=100 align=center editlimit=3 	show=false</C>
					               <C> name='비고'  			ID='etc'         width=100 align=center editlimit=30 	show=true</C>
					               <C> name='탑승차량'       	ID='car_no'      width=100 align=center editlimit=54 	show=true</C>
					               <C> name='생년월일'     	ID='birthday'    width=100 align=center editlimit=10 	show=true</C>
					               <C> name='반'        		ID='class'       width=40 align=center editlimit=50 	show=true</C>
					               <C> name='조'        		ID='teams'       width=40 align=center editlimit=3 	show=true</C>
					               <C> name='관관증번호'    ID='tour_no'     width=100 align=center editlimit=20 	show=true</C>
					               <C> name='출발일자'    ID='depart_date'     width=90 align=center editlimit=20 	show=true</C>
					               <C> name='출발상품'    ID='goods_nm'     width=90 align=center editlimit=20 	show=true</C>
					               <C> name='입경시각'    ID='arrive_time'  width=60 align=center editlimit=20 	show=true</C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>※ [상품(출)] : 출경 당시의 상품입니다.<br>
			　 [고객구분] : 사업자 = 조장을 제외한 모든 사업자입니다.

			</td>
		</tr>		
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

