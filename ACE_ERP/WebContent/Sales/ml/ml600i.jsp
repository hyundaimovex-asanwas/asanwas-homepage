<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 개성사업소 신용카드 거래내역 업로드
 * 프로그램ID 	: Ml600I
 * J  S  P		: ml600i
 * 서 블 릿		: Ml600I
 * 작 성 자		: 심동현
 * 작 성 일		: 2010-12-28 
 * [ 수정일자 ][수정자] 내용
 * [2012-12-28][심동현] 새로 제작
 * [2013-12-27][심동현] 이전 테스트
 * [2014-01-10][심동현] 조회, 저장, 다운, 업로드! 가 있네 여기...
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

			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			
			fnInit();
			
			if (excelDs.countrow<1){
				var s_temp = "COL00:STRING(2),COL01:STRING(10),COL02:STRING(12),COL03:STRING(8),COL04:STRING(4),COL05:STRING(20),COL06:STRING(13),"
						 	+ "EXCH_RATE:DECIMAL(10.2),COL08:DECIMAL(10),COL09:STRING(10),COL10:STRING(1),"
						 	+ "COL11:DECIMAL(10),COL12:STRING(8),COL13:STRING(20),COL14:STRING(4),"
						 	+ "COL15:STRING(2),COL16:STRING(14),COL17:STRING(8),ORDER_SID:DECIMAL(10)";						 	
				//헤더도 decimal(10)로  하는게 좋을듯.
				excelDs.SetDataHeader(s_temp);
			}
		}		

		/*
		 * 초기작업
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
			//거래구분
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML001&s_item1=Y";
            codeDs1.Reset();

        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);            
		}

		/**
		 * 엑셀적용 
		 * 파일 업로드 후에 조회 
		 */
		function fnExcelApply()  {
			v_job = "I";			
//			if(sAcctGu.ValueOfIndex("detail", sAcctGu.Index)=="") {
//				alert("엑셀적용 전에 계좌번호를 선택해 주세요.");
//				sAcctGu.focus();
//				return false;
//			}
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 	
		 	//alert(file_path.value);	//이건 정상. 따라서 tempExcelDs의 초기화 문제 같음. .
		 	//alert("info="+tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO"));//여기가 undefined
		 	//alert("url="+tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL")); 
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	//여기가 타입이 서치임!!!^^
                    + ",sTrGu=01";	//+ sTrGu.ValueOfIndex("detail", sTrGu.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
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
		            + ",sTr_OrderNm=" + sTr_OrderNm.value
                    + ",sTrGu=01"; //+ sTrGu.ValueOfIndex("detail", sTrGu.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
		
	
			
		/*
		 * 저장
		 */
		function fnApply() {

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:개성 현지불; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","개성 현지불.xls", 8);
		}
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		//alert("excelDs 로드 끝");
		//alert("v_job==="+v_job);
		if (excelDs.countrow <= 0) {
			return;
		}
		
		if (v_job == "I"){
			//alert("여기는?");
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "ORDER_SID") = 7;	//java에서 10으로 설정했음에도 자꾸 0으로 받아옴. 그래서 7로 수정.
			}			
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// 입력할 때.
	        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //메시지 처리
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
        }  else if(v_job == "H" || v_job=="S") {	// 조회할 때.
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}

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
//		    	alert(gcip_file.value);
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
	
		
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
	   if( sBgnDate.Modified == true )
			sEndDate.text = sBgnDate.text;
	</script>

<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>


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
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


</head>
<jsp:include page="/Common/sys/body_s05.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width=845>
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcelDs1();">
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
                        <td align="center" width="90px" height="30px" class="text">거래구분</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;<b>개성현지불</b>
						</td>
						<td align="center" width="90px" class="text">엑셀파일</td>       
						<td bgcolor=#ffffff  valign="middle" align=left>&nbsp;
							<input type="text" name="file_path" value="" >&nbsp;
							<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;" class="textbox">
								<param name="Text"		value="찾아보기">
							</OBJECT>&nbsp;
							<img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:pointer"  border='0' onClick='javascript:fnExcelApply();'>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
						<td align=left width=90 class="text">주문일자</td>
						<td align=left bgcolor="#ffffff" width=300>&nbsp;
						     
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
							&nbsp;-
						     
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
							
						</td>
						<td align="center" width="90px" height="30px" class="text">주문자명</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_OrderNm id=sTr_OrderNm class="textbox"></td>
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
							
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
<C> name='거래\\구분'	ID='COL00'  	Width=40  align=center  show=true 	</C>
<C> name='매출처'    	ID='COL01'  	Width=55  align=center  show=true 	</C>
<C> name='주문번호'    	ID='COL02'  	Width=80  align=center  show=true 	</C>
<C> name='주문일자'    	ID='COL03'  	Width=65  align=center  show=true 	</C>
<C> name='일련\\번호'  	ID='COL04'  	Width=50  align=center  show=true 	</C>
<C> name='주문자명'   	ID='COL05'  	Width=70  align=center  show=true 	</C>
<C> name='연락처1'      ID='COL06'  	Width=80  align=left    show=true 	</C>
<C> name='환율'         ID='EXCH_RATE'  	Width=50  align=right	show=true decao=2</C>
<C> name='이용\\가격'	ID='COL08'  	Width=45  align=right	show=true decao=0</C>
<C> name='결제\\방법'   ID='COL09'  	Width=60  align=center  show=true 	</C>
<C> name='승인\\여부' 	ID='COL10'  	Width=30  align=center  show=true 	</C>
<C> name='승인 금액' 	ID='COL11'  	Width=70  align=right	show=true decao=0	</C>
<C> name='카드사'      	ID='COL12'  	Width=70  align=center  show=true 	</C>
<C> name='카드번호'    	ID='COL13'  	Width=110 align=center  show=true 	</C>
<C> name='유효\\기간'   ID='COL14'  	Width=50  align=center  show=true 	</C>
<C> name='할부\\개월수' ID='COL15'  	Width=50  align=center  show=true 	</C>
<C> name='승인일시'    	ID='COL16'  	Width=100 align=center  show=true 	</C>
<C> name='승인번호'    	ID='COL17'  	Width=60  align=center  show=true 	</C>
<C> name='ORDER_SID'   	ID='ORDER_SID' 	Width=70  align=left  	show=true decao=0	</C>
					        ">
							</object>
							
						</td>
					</tr>				
				</table>
				
			</td>
		</tr>

		<tr>
			<td><br>※ 액셀 시트의 이름이 <b>"kaesong"</b> 이어야 합니다.</td>
		</tr>
	</table>
		
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="tempExcelDs">
             <param name=BindInfo    value="
                <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>		
      					

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

