<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 투어센터 정산내역 업로드
 * 프로그램ID 	: AC082I
 * J  S  P		: ac082I
 * 서 블 릿		: Ac082I
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-04-18 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2011-04-18][박경국] 투어센터 정산내역 업로드 신규화면.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	//날짜 세팅.
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
   String firsttime = m_today.format(date.getTime()).substring(8,12);
	 
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
		//전체변수 셋 : 조회구분하기 위해서
		    var v_job = "I";		
	    /*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
			if (excelDs.countrow<1){

			// 투어센터 정산내역 업로드 헤더 설정
							var s_temp =  "COL01:STRING,COL02:STRING,COL03:STRING,COL04:STRING,COL05:STRING,"
									 	+ "COL06:STRING,COL07:STRING,COL08:STRING,COL09:NUMBER,COL10:STRING,"
									 	+ "COL11:STRING,COL12:NUMBER,COL13:NUMBER,COL14:STRING,COL15:NUMBER,"
									 	+ "COL16:NUMBER,COL17:NUMBER,COL18:NUMBER,COL19:STRING,"
									 	+ "COL20:NUMBER,COL21:NUMBER,COL22:NUMBER,COL23:STRING,"
									 	+ "COL24:STRING,COL25:STRING,COL26:STRING,"
									 	+ "GARBAGE_SID:NUMBER;";
			
							excelDs.SetDataHeader(s_temp);
			}
		}		

		/*
		 * 초기작업
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_AC%>Ac082I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	
			//투어센터거래구분 [TC001]
			//dstype=5 : detail_nm을 보여주면서 '전체'
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=TC001&s_item1=Y";
            codeDs1.Reset();
		}

		/**
		 * 엑셀적용 
		 * 파일 업로드 후에 조회 
		 */
		 
		function fnExcelApply()  {
			tempExcelDs.addrow();
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 	
       	    v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
			ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac082I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)",
	            v_param);                

            tr_post(tr1);
		}
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",sBgnDate=" + sBgnDate.text
		            + ",sEndDate=" + sEndDate.text
		            + ",sNote=" + sNote.value
                    + ",sGubn01=" + sGubn01.ValueOfIndex("detail", sGubn01.Index);
            //alert(v_param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac082I", 
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
				
		/*
		 * 저장
		 */
		function fnApply() {
			/*if(sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index)=="") {
				alert("저장하시기 전에 사이트코드를 선택해 주세요.");
				sSiteCode.focus();				
				return false;
			}*/
		
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			//alert(i);
			//alert(excelDs.SysStatus(1));
			//alert(excelDs.countrow);
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_AC%>Ac082I",
               	  "JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	  param);
            	tr_post(tr1);
			} else {
				alert("업데이트된 행이 없습니다.");
			};	
		}
		
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
	        if(excelDs.CountRow==0){
    	        alert("데이터를 먼저 조회하시길 바랍니다.");
        	    return;
        	};
        	   
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:투어센터 거래내역; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","투어센터 거래내역.xls", 8);
		}
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
		<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		if (excelDs.countrow <= 0) {
			return;
		}
		if (v_job == "I"){
			for(i = 1; i <= excelDs.countrow; i++) {
				//alert(i);
				excelDs.namevalue(i, 'GARBAGE_SID') = 0;
				//alert(excelDs.namevalue(i, 'GARBAGE_SID'));
			}			
		};
	</script>

	<script language=JavaScript for=tr2 event=OnFail()>
	 var error_cnt = tr2.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
	</script>
	
	<script language=JavaScript for=tr1 event=OnFail()>
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
			//	alert(gcip_file.value);
		    	file_path.value = gcip_file.value;
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

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=excelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand" align=absmiddle onClick="fnExcelDs1();">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">구분</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sGubn01 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^130">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
						<td align="center" width="90px" class="text">엑셀파일</td>       
						<td bgcolor=#ffffff  valign="middle" align=left>&nbsp;
							<input type="text" name="file_path" value="" >&nbsp;
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
									<param name="Text"		value="찾아보기">
								</OBJECT>&nbsp;
								<img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:hand"  border='0' onClick='javascript:fnExcelApply();'>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
						<td align=left width=90 class="text">출발일자</td>
						<td align=left bgcolor="#ffffff" width=300>&nbsp;
						     <%=HDConstant.COMMENT_START%>
						     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
							<%=HDConstant.COMMENT_END%>&nbsp;-
						     <%=HDConstant.COMMENT_START%>
						     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align="center" width="90px" height="30px" class="text">비고</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sNote id=sNote></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10><td></td></tr>
		<tr height="100%">
			<td height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="845px" height="100%">
					<tr height="100%">
						<td height="100%">
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
	            	                <param name="ViewSummary"       value="1">			
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
											<C> name='구분'    		ID='COL01' 	Width=50  align=center  show=true  suppress=1		</C>
							                <C> name='국내\\국제' ID='COL02'  	Width=50  align=center  show=true  suppress=2		</C>
							                <C> name='상품명'  		ID='COL03'     Width=50  align=center  show=true  suppress=3		</C>
							                <C> name='발권일'      	ID='COL04'     Width=80  align=center  show=true	suppress=4	</C>
							                <C> name='출발일'    		ID='COL05'   	Width=80  align=center  show=true	suppress=5	</C>
							                <C> name='항공'  			ID='COL06'  	Width=40  align=center show=true	suppress=6	</C>
							                <C> name='소속'   	 		ID='COL07'   	Width=60  align=center show=true	suppress=7	</C>
							                <C> name='상용\\개인' ID='COL08'  	Width=80  align=center  show=true	DEC=0	suppress=8	SumText='총'</C>
							                <C> name='인원'    		ID='COL09' 	Width=40  align=center  show=true	SumText=@sum</C>
							                <C> name='승객명'    		ID='COL10'  	Width=80  align=center  show=true 	SumText='명'</C>
							                <C> name='상품'  			ID='COL11'    Width=100  align=center show=true	</C>
									     <G>name='결제내역'
											<C> name='카드'    	ID='COL12' 	Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
								            <C> name='현금'   		ID='COL13'   	Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
								         </G>
							                <C> name='입금일자'      ID='COL14'   	Width=80  align=RIGHT  show=true	</C>
							                <C> name='결제내역'    	ID='COL15'   	Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
							                <C> name='발권금액'  	ID='COL16'  	Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
							                <C> name='항공요금'   	ID='COL17'   	Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
							                <C> name='TAX'    			ID='COL18'  	Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
									     <G>name='세금계산서발행'
											<C> name='수수료율'    		ID='COL19' 		Width=80  align=RIGHT  show=true	</C>
								            <C> name='공급가액'   		ID='COL20'   		Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
   								            <C> name='세액'   				ID='COL21'   		Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
   								            <C> name='계'   				ID='COL22'   		Width=80  align=RIGHT  show=true	DEC=0	SumText=@sum</C>
								         </G>
							                <C> name='발권지'    	ID='COL23'   	Width=100 align=center  show=true	SumText='원'</C>
							                <C> name='계산서'  	ID='COL24'  	Width=50   align=center show=true	</C>
							                <C> name='주기'   	 	ID='COL25'   	Width=40   align=center show=true	</C>
							                <C> name='비고'    	ID='COL26'  	Width=100 align=center  show=true	</C>
							                <C> name='GARBAGE_SID'  		ID='GARBAGE_SID'  Width=80   align=center  show=false	</C>
							                
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>				
				</table>
			</td>
		</tr>
		<tr>
			<td>※ 액셀 시트의 이름이 "Sheet1" 이어야 합니다.</td>
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
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		