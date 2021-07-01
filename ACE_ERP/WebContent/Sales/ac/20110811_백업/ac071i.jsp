<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 가상계좌 가수관리(조회)
 * 프로그램ID 	: AC071I
 * J  S  P		: ac071I
 * 서 블 릿		: Ac071I
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-12-13
 * [수  정   일  자][수정자] 내용
 * [2007-12-10][심동현] KCP의 가상계좌 [정산관리>매입마감내역] 에서 일별 마감내역을 액셀로 다운로드 > 업로드하여 원본 보관

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
			cfStyleGrid(getObjectFirst("gr2"), "comn1");
			cfStyleGrid(getObjectFirst("gr1_1"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");

									
			fnInit(); 

		}		

		/*
		 * 초기작업
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
			//2007-12-11 사이트코드  by 심동현 
			sSiteCode.Index=0;
			
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS_ALL=codeDs1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
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
		            + ",sTr_Order_Nm=" + sTr_Order_Nm.value
                    + ",sSiteCode=" + sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index)
                    + ",sSAUP_SID=" + lc1.ValueOfIndex("saup_sid", lc1.Index);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac071I", 
	            "JSP(O:MAIN_DS1=acctDs1,O:MAIN_DS2=acctDs2,O:MAIN_DS3=acctDs3)",//
	            v_param);
	        tr_post(tr1);
		}
		
	
	
		
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
	        if(acctDs1.CountRow==0){
    	        alert("데이터를 먼저 조회하시길 바랍니다.");
        	    return;
        	};

			gr3.runexcelsheet("대조확인2");
			gr1_1.runexcelsheet("대조확인1");
			gr2.runexcelsheet("Join현황");	
			gr1.runexcelsheet("정리현황");	

			/*        	   
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").SetExcelTitle(1, "value:가상계좌 대조확인; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr3").GridToExcel("대조확인2","가상계좌 거래내역.xls", 24);
	        
	        getObjectFirst("gr1_1").SetExcelTitle(0, "");
	        getObjectFirst("gr1_1").SetExcelTitle(1, "value:가상계좌 대조확인; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1_1").GridToExcel("대조확인1","가상계좌 거래내역.xls", 24);
	        
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").SetExcelTitle(1, "value:가상계좌 Join현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr2").GridToExcel("Join현황","가상계좌 거래내역.xls", 24);
	
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:가상계좌 정리현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("정리현황","가상계좌 거래내역.xls", 24);*/
		}
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>


	<script language=JavaScript  for=acctDs1 event="OnLoadCompleted(row)">
		if(acctDs1.countrow <= 0) {
			return;
		}
				
/*        if(v_job=="I"){ 	// 입력할 때.
			for(i = 1; i <= acctDs1.countrow; i++){
				acctDs1.namevalue(i, "TR_SID") = 0;
			}			*/
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';
        if(v_job=="I"){ 	// 입력할 때.
	        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //메시지 처리
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
	          	
        }  else if(v_job == "H" || v_job=="S") {	// 조회할 때.
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
<%=HDConstant.COMMENT_START%>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object id=acctDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=acctDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=acctDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
                        <td align="center" width="90px" height="30px" class="text">계좌구분</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sSiteCode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=CBData			value="W6677^관광요금,W8253^보증금">
								<param name=CBDataColumns	value="siteCode,siteNm">
								<param name=SearchColumn	value=siteNm>
								<param name=Sort			value=True>
								<param name=ListExprFormat	value="siteNm^1^70,siteCode^1^70">								
								<param name=BindColumn		value="siteCode">								
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
                        <td class="text" width="90px">지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=codeDs1>
                                <param name=ListExprFormat  value="saup_nm^1^80,saup_sid^1^40">
								<param name=SearchColumn	value="saup_nm">
								<param name=BindColumn		value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                            &nbsp;(Join현황에만 적용됩니다.)
                        </td>					

					</tr>
				</table>
			</td>
		</tr>
		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
						<td align=left width=90 class="text">마감일자</td>
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
						<td align="center" width="90px" height="30px" class="text">주문자명</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_Order_Nm id=sTr_Order_Nm  onkeydown="if(event.keyCode==13) fnSelect();"></td>
						
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10><td></td></tr>
		<tr height=420>
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="845px">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:190; width:845; height:20">
								<param name="BackColor"			value="#00ffff">
								<param name="DisableBackColor"	value="#ffffee">
								<param name="Format"			value='
									<T>divid="mxTab_page1"	title="정리현황"</T>
									<T>divid="mxTab_page2"	title="Join현황"</T>
									<T>divid="mxTab_page3"	title="대조확인"</T>									
									'>
							</object>
							<%=HDConstant.COMMENT_END%>	

							<div class=page id="mxTab_page1" style="position:absolute; left:170; top:210; width:845; height:400">
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="acctDs1">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
									<param name=VIEWSUMMARY 		value=1>	
							        <param name="Format"            value="
											<C> name='No'			ID='TR_DAY_NO' Width=30 Align=right Show=true decao=0 SUMTEXT=계</C>
											<C> name='결제관리번호'	ID='TR_PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
											<C> name='주문자명'		ID='TR_ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=건</C>
											<C> name='거래은행'		ID='TR_BANK_NM' Width=70 Align=center Show=true	</C>
											<C> name='거래금액'		ID='TR_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='고객입금'		ID='TR_PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='수수료'			ID='TR_EXTRA' Width=60 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='부가세'			ID='TR_VAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='수수료+\\부가세'	ID='TR_EXTVAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='입금액'			ID='TR_SALE_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='마감일자'		ID='TR_PAY_DATE' Width=70 Align=center Show=true	</C>
											<C> name='정산일자'		ID='TR_SETTLE_DATE' Width=70 Align=center Show=true	</C>
							                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=FALSE</C>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
							</div>		

							<div class=page id="mxTab_page2" style="position:absolute; left:170; top:210; width:845; height:400">
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2 width="845px" height="400px" border="1">
							        <param name="DataID"            value="acctDs2">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name="indwidth"			value="20">
									<param name=VIEWSUMMARY 		value=1>	
							        <param name="Format"            value="
											<C> name='No'			ID='TR_DAY_NO2' Width=30 Align=right Show=true decao=0 SUMTEXT=계</C>
											<C> name='결제관리번호'	ID='TR_PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
											<C> name='주문자명'		ID='TR_ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=건</C>
											<C> name='거래은행'		ID='TR_BANK_NM' Width=70 Align=center Show=true	</C>
											<C> name='거래금액'		ID='TR_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='고객입금'		ID='TR_PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='수수료'			ID='TR_EXTRA' Width=60 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='부가세'			ID='TR_VAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='수수료+\\부가세'	ID='TR_EXTVAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='입금액'			ID='TR_SALE_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='마감일자'		ID='TR_PAY_DATE' Width=70 Align=center Show=true	</C>
											<C> name='정산일자'		ID='TR_SETTLE_DATE' Width=70 Align=center Show=true	</C>
							                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=false</C>
											<C> name='지역'			ID='TR_SAUP_SID' Width=60 Align=center editstyle=lookup data='codeDs1:saup_sid:saup_nm' Show=true </C>
											<C> name='상품'			ID='TR_GOODS_NM' Width=80 Align=center Show=true	</C>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
							</div>

							<div class=page id="mxTab_page3" style="position:absolute; left:170; top:210; width:845; height:400">
							<table width=845 height=400 border="0" cellpadding="0" cellspacing="0">
							  <tr>
							  	<td>
								<%=HDConstant.COMMENT_START%>
								<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1_1 width="370px" height="400px" border="1">
								        <param name="DataID"            value="acctDs1">
								        <param name="BorderStyle"       value="0">
								        <param name="ColSizing"         value="true">
								       	<param name="IndWidth"  		value="20">
								        <param name="editable"          value="false">
								        <param name=SortView  			value="Left">
								        <param name="indwidth"			value="20">
										<param name=VIEWSUMMARY 		value=1>	
								        <param name="Format"            value="
								        	<G> name='KCP 거래내역'
												<C> name='결제관리번호'	ID='TR_PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
												<C> name='주문자명'		ID='TR_ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=건</C>
												<C> name='고객입금'		ID='TR_PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
												<C> name='마감일자'		ID='TR_PAY_DATE' Width=70 Align=center Show=true	</C>
								                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=FALSE</C>
											</G>
								        ">
								</object>
								<%=HDConstant.COMMENT_END%>
								</td>
								<td></td>
								<td>
								<%=HDConstant.COMMENT_START%>
								<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr3 width="370px" height="400px" border="1">
								        <param name="DataID"            value="acctDs3">
								        <param name="BorderStyle"       value="0">
								        <param name="ColSizing"         value="true">
								       	<param name="IndWidth"  		value="20">
								        <param name="editable"          value="false">
								        <param name=SortView  			value="Left">
								        <param name="indwidth"			value="20">
										<param name=VIEWSUMMARY 		value=1>	
								        <param name="Format"            value="
								        	<G> name='ERP 결제내역'
												<C> name='결제관리번호'	ID='PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
												<C> name='주문자명'		ID='ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=건</C>
												<C> name='고객입금'		ID='PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
												<C> name='결제일자'		ID='PAY_DATE' Width=70 Align=center Show=true	</C>
												<C> name='입금여부'		ID='PAY_YN' Width=70 Align=center Show=FALSE BgColor={IF(PAY_YN='Y','#fefec0','' )}</C>
								                <C> name='VIRTUAL_SID'  ID='VIRTUAL_SID' Width=100  align=left  show=FALSE</C>
											</G>
								        ">
								</object>
								<%=HDConstant.COMMENT_END%>
								
								</td>
							  </tr>
							</table>
							</div>												
						</td>
					</tr>				
				</table>
			</td>
		</tr>
		<tr>
			<td><br>※ 정리현황 : KCP에서 받은 파일을 정리한 Tab입니다.<br>
			※ Join현황 : KCP와 ERP의 거래내역을 Join하여 지역구분을 추가로 표시한 Tab입니다.<br>
			※ 대조확인 : KCP와 ERP의 거래내역을 따로 조회하여 비교할 수 있는 Tab입니다.<br>
			　KCP계 = ERP계 : 정상인 상황  <br>
			　KCP계 > ERP계 : 입금내역이 있으나 시스템에 입금이 잡히지 않은 상태. 입금표를 받아 전산 수정합니다.(대부분의 경우) <br>
			　KCP계 < ERP계 : 입금내역은 없는데 시스템에 돈이 있는 매우 비정상인 상태. 반드시 확인해야 합니다.
			
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

