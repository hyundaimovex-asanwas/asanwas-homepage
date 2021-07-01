<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 체류현황
 * 프로그램ID 	: AC020S
 * J  S  P		: ac020s
 * 서 블 릿		: Ac020S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-07
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
		cfStyleGrid(getObjectFirst("gr2"), "comn");
		cfStyleGrid(getObjectFirst("gr3"), "comn");
		cfStyleGrid(getObjectFirst("gr4"), "comn");
		cfStyleGrid(getObjectFirst("gr5"), "comn");
		cfStyleGrid(getObjectFirst("gr6"), "comn");
		cfStyleGrid(getObjectFirst("gr7"), "comn");
		
		
		sJobDate.text='<%=firstday%>';
                  
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";
		 
		// 사업소, 고객구분
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=codeDs1)", 
            param);
            
        tr_post(tr1);		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	
 		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
        	+ "sSaup_sid=" +codeDs1.namevalue(codeDs1.rowposition,"saup_sid") + ","        
        	+ "sJobDate=" + sJobDate.text;
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy520S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3,O:DS4=ds4,O:DS5=ds5,O:DS6=ds6,O:DS7=ds7)",
            param);
        tr_post(tr1);

    }
 	
  	function fnExcel() {
	        getObjectFirst("gr7").SetExcelTitle(0, "");
	        getObjectFirst("gr7").GridToExcel("Sheet7","자료전송.xls", 32);   

	        getObjectFirst("gr6").SetExcelTitle(0, "");
	        getObjectFirst("gr6").GridToExcel("Sheet6","자료전송.xls", 32);   

	        getObjectFirst("gr5").SetExcelTitle(0, "");
	        getObjectFirst("gr5").GridToExcel("Sheet5","자료전송.xls", 32);   

  
	        getObjectFirst("gr4").SetExcelTitle(0, "");
	        getObjectFirst("gr4").GridToExcel("Sheet4","자료전송.xls", 32);   
	        
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").GridToExcel("Sheet3","자료전송.xls", 32);   
	        
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").GridToExcel("Sheet2","자료전송.xls", 32);   
	        
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("Sheet1","자료전송.xls", 32);   
	        /*  	
			if(selExl[0].checked){
		        getObjectFirst("gr1").SetExcelTitle(0, "");
		        getObjectFirst("gr1").GridToExcel("Sheet1","자료전송.xls", 32);   
			}else if(selExl[1].checked){
		        getObjectFirst("gr2").SetExcelTitle(0, "");
		        getObjectFirst("gr2").GridToExcel("Sheet2","자료전송.xls", 32);   
			}else if(selExl[2].checked){
		        getObjectFirst("gr3").SetExcelTitle(0, "");
		        getObjectFirst("gr3").GridToExcel("Sheet3","자료전송.xls", 32);   
			}else if(selExl[3].checked){
	  	        getObjectFirst("gr4").SetExcelTitle(0, "");
		        getObjectFirst("gr4").GridToExcel("Sheet4","자료전송.xls", 32);   
			}else if(selExl[4].checked){
		        getObjectFirst("gr5").SetExcelTitle(0, "");
		        getObjectFirst("gr5").GridToExcel("Sheet5","자료전송.xls", 32);   
			}else if(selExl[5].checked){
		        getObjectFirst("gr6").SetExcelTitle(0, "");
		        getObjectFirst("gr6").GridToExcel("Sheet6","자료전송.xls", 32);   
			}else if(selExl[6].checked){
		        getObjectFirst("gr7").SetExcelTitle(0, "");
		        getObjectFirst("gr7").GridToExcel("Sheet7","자료전송.xls", 8);   
			}else{
				alert("자료를 선택해주세요.");			
			};*/
	        
        }
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
		resultMsg.innerHTML="자료 건수 = <b>고객정보: "+ds1.CountRow+", 예약정보:"+ds2.CountRow+", 예약정보상세: "+ds3.CountRow+", 예약요금: "+ds4.CountRow+", 사업자: "+ds5.CountRow+", 사업자예약: "+ds6.CountRow+", RF발급: "+ds7.CountRow+"</b>";
		
	</script>	
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>


<!--  사업소 -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
			<td bgcolor="#ffffff" width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845' bgcolor="#ffffff">
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
		<tr height="30px">
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height="30px">
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
    					<td align=left width=70 class="text">출경일자</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	<%=HDConstant.COMMENT_START%>
					     	<object id=sJobDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
						</td>		
						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='2' HEIGHT="420">
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:190; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="고객정보:TCU010"</T>
											<T>divid="mxTab_page2"	title="예약정보:TRV010"</T>
											<T>divid="mxTab_page3"	title="예약정보상세:TRV020"</T>
											<T>divid="mxTab_page4"	title="예약요금:TRV030"</T>
											<T>divid="mxTab_page5"	title="사업자:TCM010"</T>
											<T>divid="mxTab_page6"	title="사업자예약:TCM040"</T>
											<T>divid="mxTab_page7"	title="RF발급:RF_TAG_H"</T>
											'>	
									</object>
									<%=HDConstant.COMMENT_END%>	
									<div class=page id="mxTab_page1" style="position:absolute; left:170; top:210; width:845; height:300">
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
							               		<C> name='고객SID'	ID='CUST_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='신청서번호'	ID='GROUP_CD'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='주민/여권번호'	ID='MANAGE_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='그룹번호'		ID='GROUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='주민번호'		ID='REGI_NO'	 width=100 align=left editlimit=13 show=true</C>
												<C> name='인증여부'		ID='REGI_YN'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='고객구분'		ID='CUST_GU'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='국적구분'		ID='COUNTRY_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='사업구분'		ID='SAUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='고객유형'		ID='CUST_TYPE'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='한글성명'		ID='CUST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='영문성'	ID='LAST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='영문성명'	ID='FIRST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='국가코드'	ID='COUNTRY_CD'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='민족코드'	ID='NATION_CD'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='생년월일'	ID='BIRTHDAY'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='성별'		ID='SEX'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='자택전화'	ID='TEL_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='핸드폰'	ID='MOBILE_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='이메일'	ID='E_MAIL'	 width=100 align=left editlimit=40 show=true</C>
												<C> name='FAX번호'	ID='FAX_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='우편번호SID'	ID='ZIP_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='우편번호'	ID='ZIP_CD'	 width=100 align=left editlimit=6 show=true</C>
												<C> name='주소1'	ID='ADDRESS1'	 width=100 align=left editlimit=80 show=true</C>
												<C> name='주소2'	ID='ADDRESS2'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='외국우편번호'	ID='ENG_ZIP_CD'	 width=100 align=left editlimit=10 show=true</C>
												<C> name='영문주소1'	ID='ENG_ADDR1'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='영문주소2'	ID='ENG_ADDR2'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='여권종류'	ID='PASS_TYPE'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='여권번호'	ID='PASS_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='여권만기일'	ID='PASS_EXPIRE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='여권발행일'	ID='PASS_ISSUE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='여권발행지'	ID='PASS_AREA'	 width=100 align=left editlimit=22 show=true</C>
												<C> name='직장명'	ID='COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='직위'	ID='POSITIONS'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='영문직장명'	ID='ENG_COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='영문직위'	ID='ENG_POSITION'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='북한방문횟수'	ID='NORTH_CNT'	 width=100 align=left editlimit=7 show=true</C>
												<C> name='매출처SID'	ID='CLIENT_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='신장'	ID='HEIGHT'	 width=100 align=left editlimit=5 show=true</C>
												<C> name='실명확인'	ID='REGI_YN_T'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='직군'	ID='JOB_CD'	 width=100 align=left editlimit=2 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           				<C> name='신청SID'	ID='ACCEPT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='신청서번호'	ID='ACCEPT_NO'	 align=left editlimit=14 show=true</C>
												<C> name='신청일자'	ID='ACCEPT_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='출발일자'	ID='DEPART_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='사업소SID'	ID='SAUP_SID'	 align=left editlimit=12 show=true</C>
												<C> name='상품SID'	ID='GOODS_SID'	 align=left editlimit=12 show=true</C>
												<C> name='매출처SID'	ID='CLIENT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='행사SID'	ID='EVENT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='작업구분'	ID='JOB_GUBUN'	 align=left editlimit=1 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page3" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds3">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           				<C> name='예약SID'	ID='RSV_SID'	 align=left editlimit=12 show=true</C>
												<C> name='주예약SID'	ID='M_RSV_SID'	 align=left editlimit=12 show=true</C>
												<C> name='KEY-MAN'	ID='KEY_MAN'	 align=left editlimit=13 show=true</C>
												<C> name='신청SID'	ID='ACCEPT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='업장SID'	ID='UPJANG_SID'	 align=left editlimit=12 show=true</C>
												<C> name='신청객실타입SID'	ID='A_ROOM_TYPE_SID'	 align=left editlimit=12 show=true</C>
												<C> name='신청객실SID'	ID='A_ROOM_SID'	 align=left editlimit=12 show=true</C>
												<C> name='객실타입SID'	ID='ROOM_TYPE_SID'	 align=left editlimit=12 show=true</C>
												<C> name='객실SID'	ID='ROOM_SID'	 align=left editlimit=12 show=true</C>
												<C> name='과거ROOM NO'	ID='OLD_ROOM_NO'	 align=left editlimit=5 show=true</C>
												<C> name='블록SID'	ID='BLOCK_SID'	 align=left editlimit=12 show=true</C>
												<C> name='예약타입'	ID='RSV_TYPE'	 align=left editlimit=1 show=true</C>
												<C> name='예약자료상태'	ID='STATUS_CD'	 align=left editlimit=2 show=true</C>
												<C> name='출발일자'	ID='DEPART_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='출발시간'	ID='DEPART_TIME'	 align=left editlimit=4 show=true</C>
												<C> name='박수'	ID='NIGHTS'	 align=left editlimit=5 show=true</C>
												<C> name='입경일자'	ID='ARRIVE_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='입경시간'	ID='ARRIVE_TIME'	 align=left editlimit=4 show=true</C>
												<C> name='고객SID'	ID='CUST_SID'	 align=left editlimit=12 show=true</C>
												<C> name='고객유형'	ID='CUST_TYPE'	 align=left editlimit=3 show=true</C>
												<C> name='고객구분'	ID='CUST_GU'	 align=left editlimit=1 show=true</C>
												<C> name='사업구분'	ID='SAUP_GU'	 align=left editlimit=2 show=true</C>
												<C> name='연령코드'	ID='AGE_CD'	 align=left editlimit=2 show=true</C>
												<C> name='동거코드'	ID='JOIN_CD'	 align=left editlimit=2 show=true</C>
												<C> name='핸드폰'	ID='MOBILE_NO'	 align=left editlimit=15 show=true</C>
												<C> name='직장명'	ID='COMPANY_NM'	 align=left editlimit=30 show=true</C>
												<C> name='직위'	ID='POSITIONS'	 align=left editlimit=30 show=true</C>
												<C> name='주소SID'	ID='ZIP_SID'	 align=left editlimit=12 show=true</C>
												<C> name='주소코드'	ID='ZIP_CD'	 align=left editlimit=6 show=true</C>
												<C> name='주소1'	ID='ADDRESS1'	 align=left editlimit=60 show=true</C>
												<C> name='반'	ID='CLASS'	 align=left editlimit=3 show=true</C>
												<C> name='조'	ID='TEAMS'	 align=left editlimit=3 show=true</C>
												<C> name='페이지NO'	ID='PAGE_NO'	 align=left editlimit=5 show=true</C>
												<C> name='방북목적'	ID='NORTH_PURPOSE'	 align=left editlimit=62 show=true</C>
												<C> name='운전여부'	ID='DRIVE_YN'	 align=left editlimit=1 show=true</C>
												<C> name='취소사유코드'	ID='CANCEL_CD'	 align=left editlimit=2 show=true</C>
												<C> name='관광증번호'	ID='TOUR_NO'	 align=left editlimit=20 show=true</C>
												<C> name='법무부체크'	ID='MOJ_CHECK_YN'	 align=left editlimit=1 show=true</C>
												<C> name='교육이수여부'	ID='EDUC_FINISH_YN'	 align=left editlimit=1 show=true</C>
												<C> name='기관제출일자'	ID='ORG_SUBMIT_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='통일부일련번호'	ID='UNITY_NO'	 align=left editlimit=12 show=true</C>
												<C> name='방북허가유무[남측]'	ID='SOUTH_PERMIT_YN'	 align=left editlimit=1 show=true</C>
												<C> name='대북제출일자'	ID='NORTH_SUBMIT_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='대북제출시간'	ID='NORTH_SUBMIT_TIME'	 align=left editlimit=4 show=true</C>
												<C> name='북한입국허가'	ID='NORTH_PERMIT_YN'	 align=left editlimit=1 show=true</C>
												<C> name='예약신청방법'	ID='RSV_WAY_CD'	 align=left editlimit=1 show=true</C>
												<C> name='참고사항'	ID='REMARKS'	 align=left editlimit=200 show=true</C>
												
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page4" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds4">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
						           			<C> name='예약SID'		ID='RSV_SID'	 width=100 align=left editlimit=12 show=true</C>
											<C> name='사용일자'		ID='USE_DATE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='순번'		ID='KEY_SEQ'	 width=100 align=left editlimit=5 show=true</C>
											<C> name='메뉴SID'		ID='MENU_SID'	 width=100 align=left editlimit=12 show=true</C>
											<C> name='표준요금'		ID='STD_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='이용요금'		ID='USE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='판매수량'		ID='SALE_QTY'	 width=100 align=left editlimit=5 show=true</C>
											<C> name='옵션상품여부'	ID='OPTION_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='예약시결재여부'	ID='RSV_PAY_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='참고사항'		ID='REMARKS'	 width=100 align=left editlimit=100 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page5" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr5 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds5">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name='고객SID' ID='CUST_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='사진명단제출여부' ID='VISIT_K_LIST'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='실무번호' ID='WORK_NO'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='소속사' ID='CLIENT_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='비용부담회사' ID='REAL_CLIENT'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='방북교육이수여부' ID='N_EDUC_YN'	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page6" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr6 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds6">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name=' 예약SID' ID='RSV_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' 사업자SID' ID='CUST_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' 희망객실타입' ID='A_ROOM_TYPE_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' 희망객실 참고사항' ID='REMARKS'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' 방북증소재' ID='N_CARD_GU'	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page7" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr7 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds7">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name='태그시리얼'      ID='TAG_SER'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='발급순번'        ID='TAG_SEQ'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='발급구분'        ID='TAG_ISSUE_KIND' 	 width=100 align=left editlimit=8 show=true</C>
											<C> name='발급비고'        ID='COMMENT'       	 width=100 align=left editlimit=8 show=true</C>
											<C> name='회원키'          ID='MEMBER_NO'      	 width=100 align=left editlimit=8 show=true</C>
											<C> name='방북조'          ID='MEM_GROUP'      	 width=100 align=left editlimit=8 show=true</C>
											<C> name='이름'            ID='NAME'           	 width=100 align=left editlimit=8 show=true</C>
											<C> name='주민등록번호'    ID='PS_NO'          	 width=100 align=left editlimit=8 show=true</C>
											<C> name='방북구분'        ID='MEMBER_KIND'    	 width=100 align=left editlimit=8 show=true</C>
											<C> name='카드구분'        ID='RF_KIND'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='사용 시작일'     ID='USE_FROM'       	 width=100 align=left editlimit=8 show=true</C>
											<C> name='사용 종료일'     ID='USE_TO'         	 width=100 align=left editlimit=8 show=true</C>
											<C> name='키버젼'          ID='KEY_VER'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='발급인증코드'    ID='ISSUE_AUTH_CODE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='발급자'          ID='USER_ID'        	 width=100 align=left editlimit=8 show=true</C>
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
		<tr>
			<td id=resultMsg></td>
		</tr>
		<tr>
			<td>※ 조회 후 GRID 상단의 각 Tab을 한번씩 클릭한 후 [액셀] 버튼을 누르면 데이터의 잘림 없이 다운로드됩니다.</td>
		</tr>

	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

