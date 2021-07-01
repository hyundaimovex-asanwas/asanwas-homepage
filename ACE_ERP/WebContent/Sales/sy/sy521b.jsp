<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 체류현황
 * 프로그램ID 	: AC020S
 * J  S  P		: ac020s
 * 서 블 릿		: Ac020S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-07
 * 기능정의		:
 * 수정내용		: 
 * 수 정 자		:
 * 최종수정일자 	:
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD 정보 -->
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
		function fnOnLoad(){
            cfStyleTab(getObjectFirst("mxTab"), "comn");
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			cfStyleGrid(getObjectFirst("gr4"), "comn");
			
			fnInit(); 
		}		

		/*
		 * 초기작업
		 */
		function fnInit(){
    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_SY%>Sy521B",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}

		/**
		 * 엑셀적용 
		 * 파일 업로드 후에 조회 
		 */
		 
		function fnExcelApply()  {
		
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy521B",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS1=ds1,O:EXCELDS2=ds2,O:EXCELDS3=ds3,O:EXCELDS4=ds4)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>");
            tr_post(tr1);
		}
		
		/*
		 * 저장
		 */
		function fnApply() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
						 
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated) {
				 ln_TRSetting(tr1, 
                	"<%=dirPath%><%=HDConstant.PATH_SY%>Sy521B",
               	 "JSP(I:EXCELDS1=ds1,I:EXCELDS2=ds2,I:EXCELDS3=ds3,I:EXCELDS4=ds4,O:RESULT=ds_result)",
               	 param);
               	 
            	tr_post(tr1);
			}	
		}
		
		/*
		 * 엑셀적용후 저장 
		 */
			
			
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
    </script>
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
    </script>
	<script language="javascript" for="gcip_file" event=OnClick()>
	    if (fn_trim(gcip_file.value)!="") {
	    	file_path.value = gcip_file.value;
	    }
	</script>
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		if (ds1.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds1.countrow; i++) {
			ds1.namevalue(i, "yn") = "U";
		}
	</script>
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
		if (ds2.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds2.countrow; i++) {
			ds2.namevalue(i, "yn") = "U";
		}
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		if (ds3.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds3.countrow; i++) {
			ds3.namevalue(i, "yn") = "U";
		}
	</script>	
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		if (ds4.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds4.countrow; i++) {
			ds4.namevalue(i, "yn") = "U";
		}
	</script>		
	<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
        if(ds_result.CountRow>0){
            var v_result_msg = "";
            for(var i=1; i<=ds_result.CountRow; i++){
                if(ds_result.NameValue(i, "MSG_CD")!="0000")
                    v_result_msg += ds_result.NameValue(i, "MSG")+"\n";
            }
    
            if(v_result_msg!="")
                alert(v_result_msg);
        }
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
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>


<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
	
<body leftmargin="10" topmargin="10" marginwidth="0" marginheight="0" onLoad="fnOnLoad();">
<!--------------------------------- 코딩 부분 시작 ------------------------------->       
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
           <td width="422" height="30" align="left" valign="middle" class="tt"><img src="/HDASan/Sales/images/icon.gif" width="14" height="14"> 자료수신</td>
         </tr>
    </table>
    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td width='845px'>
                <table   border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td>
                            <table border='0' cellpadding='0' cellspacing='1' bgcolor=#666666>
                                <tr height="30px">
                                    <td align="center" width="85px" height="30px" class="text">엑셀파일</td>       
                                    <td width=350 bgcolor=#ffffff  valign="middle">&nbsp;
                                        <input type="text" name="file_path" value="" >&nbsp;
                                        <%=HDConstant.COMMENT_START%>
                                        <OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
                                            <param name="Text"      value="찾아보기">
                                        </OBJECT>&nbsp;
                                        <img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:hand"  border='0' onClick='javascript:fnExcelApply();'>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align='right' bgcolor=#ffffff>
                            <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand" align=absmiddle onClick="fnApply();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px"><td>&nbsp;</td></tr>

		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" bordercolor="#000000">
    									<%=HDConstant.COMMENT_START%>
    									<object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='845px' height='20px'>
    										<param name="BackColor"			value="#00ffff">
    										<param name="DisableBackColor"	value="#ffffee">
    										<param name="Format"			value='
    											<T>divid="mxTab_page1"	title="고객정보:TCU010"</T>
    											<T>divid="mxTab_page2"	title="예약정보:TRV010"</T>
    											<T>divid="mxTab_page3"	title="예약정보상세:TRV020"</T>
    											<T>divid="mxTab_page4"	title="예약요금:TRV030"</T>
    											'>	
    									</object>
    									<%=HDConstant.COMMENT_END%>	
                                    </td>
                                </tr>
                                <tr valign=top>
                                    <td align="left" width="845px" bordercolor="#000000">
    									<div class=page id="mxTab_page1" style="position:absolute; width:845; height:300">
    									<%=HDConstant.COMMENT_START%>
    									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
    	                        			<param name="DataID"		VALUE="ds1">
    	                        			<param name="BorderStyle"   VALUE="0">
    	                        			<param name=ColSizing       value="true">
    	                        			<param name="editable"      value="false">
    	                        			<param name=UsingOneClick  	value="1">
    	                                    <Param Name="AllShowEdit"   value="True">
    	                                    <param name="SortView"      value="Right">
    										<param name=SuppressOption value=1>
    										<param name="Format" 			value="
    												<C> name='고객SID'	ID='CUST_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='신청서번호'	ID='GROUP_CD'	width=100 align=left editlimit=20 show=true</C>
    												<C> name='주민/여권번호'	ID='MANAGE_NO'	width=100  align=left editlimit=20 show=true</C>
    												<C> name='그룹번호'	ID='GROUP_GU'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='주민번호'	ID='REGI_NO'	 width=100 align=left editlimit=13 show=true</C>
    												<C> name='인증여부'	ID='REGI_YN'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='고객구분'	ID='CUST_GU'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='국적구분'	ID='COUNTRY_GU'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='사업구분'	ID='SAUP_GU'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='고객유형'	ID='CUST_TYPE'	 width=100 align=left editlimit=3 show=true</C>
    												
    												<C> name='한글성명'	ID='CUST_NM'	 width=100 align=left editlimit=30 show=true</C>
    												<C> name='영문성'	ID='LAST_NM'	 width=100 align=left editlimit=30 show=true</C>
    												<C> name='영문성명'	ID='FIRST_NM'	 width=100 align=left editlimit=30 show=true</C>
    												<C> name='국가코드'	ID='COUNTRY_CD'	 width=100 align=left editlimit=3 show=true</C>
    												<C> name='민족코드'	ID='NATION_CD'	 width=100 align=left editlimit=3 show=true</C>
    												<C> name='생년월일'	ID='BIRTHDAY'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='성별'	ID='SEX'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='자택전화'	ID='TEL_NO'	 width=100 align=left editlimit=20 show=true</C>
    												<C> name='핸드폰'	ID='MOBILE_NO'	 width=100 align=left editlimit=20 show=true</C>
    												<C> name='이메일'	ID='E_MAIL'	 width=100 align=left editlimit=40 show=true</C>
    												
    												<C> name='FAX번호'	ID='FAX_NO'	 width=100 align=left editlimit=20 show=true</C>
    												<C> name='우편번호SID'	ID='ZIP_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
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
    												<C> name='북한방문횟수'	ID='NORTH_CNT'	 width=100 align=left editlimit=7 show=true dec=0</C>
    												<C> name='매출처SID'	ID='CLIENT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='신장'	ID='HEIGHT'	 width=100 align=left editlimit=5 show=true dec=0</C>
    												
    												<C> name='방북교육유무'	ID='EDUC_YN'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='방북교육과목'	ID='EDUC_SAUP_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='방북교육일자'	ID='EDUC_DT'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='현대실무번호'	ID='WORK_NO'	 width=100 align=left editlimit=20 show=true</C>
    												<C> name='직군'	ID='JOB_CD'	 width=100 align=left editlimit=2 show=true</C>
    										">
    									</object>
    									<%=HDConstant.COMMENT_END%>	
    									</div>
    									<div class=page id="mxTab_page2" style="position:absolute; width:845; height:300">
    									<%=HDConstant.COMMENT_START%>
    									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
    	                        			<param name="DataID"		VALUE="ds2">
    	                        			<param name="BorderStyle"   VALUE="0">
    	                        			<param name=ColSizing       value="true">
    	                        			<param name="editable"      value="false">
    	                        			<param name=UsingOneClick  	value="1">
    	                                    <Param Name="AllShowEdit"   value="True">
    	                                    <param name="SortView"      value="Right">
    										<param name=SuppressOption value=1>
    										<param name="Format" 			value="
    						           				<C> name='신청SID'	ID='ACCEPT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='신청서번호'	ID='ACCEPT_NO'	 width=100 align=left editlimit=14 show=true</C>
    												<C> name='신청일자'	ID='ACCEPT_DATE'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='출발일자'	ID='DEPART_DATE'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='사업소SID'	ID='SAUP_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='상품SID'	ID='GOODS_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='매출처SID'	ID='CLIENT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='행사SID'	ID='EVENT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='작업구분'	ID='JOB_GUBUN'	 width=100 align=left editlimit=1 show=true</C>
    										">
    									</object>
    									<%=HDConstant.COMMENT_END%>	
    									</div>
    									<div class=page id="mxTab_page3" style="position:absolute; width:845; height:300">
    									<%=HDConstant.COMMENT_START%>
    									<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
    	                        			<param name="DataID"		VALUE="ds3">
    	                        			<param name="BorderStyle"   VALUE="0">
    	                        			<param name=ColSizing       value="true">
    	                        			<param name="editable"      value="false">
    	                        			<param name=UsingOneClick  	value="1">
    	                                    <Param Name="AllShowEdit"   value="True">
    	                                    <param name="SortView"      value="Right">
    										<param name=SuppressOption value=1>
    										<param name="Format" 			value="
    						           				<C> name='예약SID'	ID='RSV_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='주예약SID'	ID='M_RSV_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='KEY-MAN'	ID='KEY_MAN'	 width=100 align=left editlimit=13 show=true</C>
    												<C> name='신청SID'	ID='ACCEPT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='업장SID'	ID='UPJANG_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												
    												<C> name='신청객실타입SID'	ID='A_ROOM_TYPE_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='신청객실SID'	ID='A_ROOM_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='객실타입SID'	ID='ROOM_TYPE_SID'	width=100  align=left editlimit=12 show=true dec=0</C>
    												<C> name='객실SID'	ID='ROOM_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='과거ROOM NO'	ID='OLD_ROOM_NO'	width=100  align=left editlimit=5 show=true dec=0</C>
    												
    												<C> name='블록SID'	ID='BLOCK_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='예약타입'	ID='RSV_TYPE'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='예약자료상태'	ID='STATUS_CD'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='출발일자'	ID='DEPART_DATE'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='출발시간'	ID='DEPART_TIME'	 width=100 align=left editlimit=4 show=true</C>
    
    												<C> name='박수'	ID='NIGHTS'	 width=100 align=left editlimit=5 show=true dec=0</C>
    												<C> name='입경일자'	ID='ARRIVE_DATE'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='입경시간'	ID='ARRIVE_TIME'	 width=100 align=left editlimit=4 show=true</C>
    												<C> name='고객SID'	ID='CUST_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='고객유형'	ID='CUST_TYPE'	 width=100 align=left editlimit=3 show=true</C>
    
    												<C> name='고객구분'	ID='CUST_GU'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='사업구분'	ID='SAUP_GU'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='연령코드'	ID='AGE_CD'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='동거코드'	ID='JOIN_CD'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='핸드폰'	ID='MOBILE_NO'	 width=100 align=left editlimit=15 show=true</C>
    
    												<C> name='직장명'	ID='COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
    												<C> name='직위'	ID='POSITIONS'	 width=100 align=left editlimit=30 show=true</C>
    												<C> name='주소SID'	ID='ZIP_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
    												<C> name='주소코드'	ID='ZIP_CD'	 width=100 align=left editlimit=6 show=true</C>
    												<C> name='주소1'	ID='ADDRESS1'	 width=100 align=left editlimit=60 show=true</C>
    
    												<C> name='반'	ID='CLASS'	 width=100 align=left editlimit=3 show=true</C>
    												<C> name='조'	ID='TEAMS'	 width=100 align=left editlimit=3 show=true</C>
    												<C> name='페이지NO'	ID='PAGE_NO'	 width=100 align=left editlimit=5 show=true dec=0</C>
    												<C> name='방북목적'	ID='NORTH_PURPOSE'	 width=100 align=left editlimit=62 show=true</C>
    												<C> name='운전여부'	ID='DRIVE_YN'	 width=100 align=left editlimit=1 show=true</C>
    
    												<C> name='취소사유코드'	ID='CANCEL_CD'	 width=100 align=left editlimit=2 show=true</C>
    												<C> name='관광증번호'	ID='TOUR_NO'	 width=100 align=left editlimit=20 show=true</C>
    												<C> name='법무부체크'	ID='MOJ_CHECK_YN'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='교육이수여부'	ID='EDUC_FINISH_YN'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='기관제출일자'	ID='ORG_SUBMIT_DATE'	 width=100 align=left editlimit=8 show=true</C>
    
    												<C> name='통일부일련번호'	ID='UNITY_NO'	 width=100 align=left editlimit=12 show=true</C>
    												<C> name='방북허가유무[남측]'	ID='SOUTH_PERMIT_YN'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='대북제출일자'	ID='NORTH_SUBMIT_DATE'	 width=100 align=left editlimit=8 show=true</C>
    												<C> name='대북제출시간'	ID='NORTH_SUBMIT_TIME'	 width=100 align=left editlimit=4 show=true</C>
    												<C> name='북한입국허가'	ID='NORTH_PERMIT_YN'	 width=100 align=left editlimit=1 show=true</C>
    
    												<C> name='예약신청방법'	ID='RSV_WAY_CD'	 width=100 align=left editlimit=1 show=true</C>
    												<C> name='참고사항'	ID='REMARKS'	 width=100 align=left editlimit=200 show=true</C>
    										">
    									</object>
    									<%=HDConstant.COMMENT_END%>	
    									</div>
    									<div class=page id="mxTab_page4" style="position:absolute; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds4">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='예약SID'		ID='RSV_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='사용일자'		ID='USE_DATE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='순번'		ID='KEY_SEQ'	 width=100 align=left editlimit=5 show=true dec=0</C>
											<C> name='메뉴SID'		ID='MENU_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='표준요금'		ID='STD_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='이용요금'		ID='USE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='판매수량'		ID='SALE_QTY'	 width=100 align=left editlimit=5 show=true dec=0</C>
											<C> name='옵션상품여부'	ID='OPTION_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='예약시결재여부'	ID='RSV_PAY_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='참고사항'		ID='REMARKS'	 width=100 align=left editlimit=100 show=true</C>
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

	<%=HDConstant.COMMENT_START%>	
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
         <param name="DataId" value="tempExcelDs">
         <param name=BindInfo    value="
            <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
            <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
          ">
    </object>		
    <%=HDConstant.COMMENT_END%>		
<!--------------------------------- 코딩 부분 끝 -------------------------------->   
    <iframe id="LowerFrame" 
            name="work" 
            style="visibility:hidden; position:absolute; left:280px; top:220px;" 
            Frameborder="0" src="/HDASan/Sales/common/img/flash/loading.swf" 
            width="320px" 
            height="42px">
    </iframe>   
<!---------------------------------- BODY End --------------------------------> 
    </body>
</html>