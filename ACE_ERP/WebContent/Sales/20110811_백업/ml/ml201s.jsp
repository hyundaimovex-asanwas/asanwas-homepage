<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 쇼핑몰 입금확인
 * 프로그램ID 	: Ml300s
 * J  S  P		: ml300s
 * 서 블 릿		: Ml300s
 * 작 성 자		: 심동현
 * 작 성 일		: 2010-12-28 
 * [ 수정일자 ][수정자] 내용
 * [2010-12-28][심동현] 새로 제작 - 일단 선물세트용도
 * [2011-01-28][심동현] 결제정보에 관리번호 클릭하면 팝업창 띄우기..해야 함
 
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
			fnInit(); 
		}		

		/*
		 * 초기작업
		 */
		function fnInit(){
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';

            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML001&s_item1=Y";
            codeDs1.Reset();
            codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML002&s_item1=Y";
            codeDs2.Reset();

		}

		<%//메인 조회%>
		function fnSelect() {
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",sBgnDate=" + sBgnDate.text
		            + ",sEndDate=" + sEndDate.text
		            + ",sTr_OrderNm=" + sTr_OrderNm.value
                    + ",sTrGu=" + sTrGu.ValueOfIndex("detail", sTrGu.Index);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml200S", 
	            "JSP(O:DS_MAIN=ds_main)",
	            v_param);
	        tr_post(tr1);
		}
		
	
		<%//엑셀%>
		function fnds_main1() {
	        if(ds_main.CountRow==0){
    	        alert("데이터를 먼저 조회하시길 바랍니다.");
        	    return;
        	};
        	   
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:쇼핑몰 입금확인2; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","쇼핑몰 입금확인2.xls", 8);
		}

		<% //Description 입금방법 구분 팝업%>    
		function fnConfirmView(dir) {
			var arrParam    = new Array();
		    var arrResult   = new Array();
			
			var order_no 		= ds_main.namevalue(ds_main.rowposition,"ORDER_NO");
			var order_sid 		= ds_main.namevalue(ds_main.rowposition,"ORDER_SID");	
		
			var pay_sid 		= ds_main.namevalue(ds_main.rowposition, "PAY_SID");
			var pay_manage_no 	= ds_main.namevalue(ds_main.rowposition, "PAY_MANAGE_NO");
			var pay_cd 			= ds_main.namevalue(ds_main.rowposition,"PAY_CD");
			var pay_date 		= ds_main.namevalue(ds_main.rowposition,"PAY_DATE");

			var sales_gubn		= ds_main.namevalue(ds_main.rowposition,"SALES_GUBN");			
			

				if (pay_cd == "040") { // 신용카드
					var strURL = dir+"/Sales/help/ml201h.jsp?order_no="+order_no+"&order_sid="+order_sid+"&pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date+"&sales_gubn="+sales_gubn;
				} else if (pay_cd == "080") { // 무통장입금
					var strURL = dir+"/Sales/help/rv014h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
				} else if (pay_cd == "020") { // 가상계좌
					var strURL = dir+"/Sales/help/rv007h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
				} else if (pay_cd == "030") { // 계좌이체
					var strURL = dir+"/Sales/help/rv008h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
				} else if (pay_cd == "060") { // 상품권
					var strURL = dir+"/Sales/help/rv010h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
				} else if (pay_cd == "090") { // 기타대체
					var strURL = dir+"/Sales/help/rv015h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
				} else {
					return;
				}
		
		    var strPos = "dialogWidth:500px;dialogHeight:585px;status:no;scroll:no;resizable:no";
		    arrResult =  showModalDialog(strURL,arrParam,strPos); 
		    }
		</script>
		


<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
	   if( sBgnDate.Modified == true )
			sEndDate.text = sBgnDate.text;
	</script>
	<script language=JavaScript  for=ds_main event="OnLoadCompleted(row)">
		if (ds_main.countrow <= 0) {
			alert("결과가 없습니다. 조회 조건을 다시 한번 확인해 주세요.");
			return;
		}
	</script>
	<script language=javascript for="gr1" event="OnClick(Row, Colid)">
	    if(Row<1) return;
		if(Colid=="PAY_MANAGE_NO"){	    
		    fnConfirmView('<%=dirPath%>');
		}
	</script>	
	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// 입력할 때.
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
	
		
	<!--  팝업 차량 -->
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if(colid=="COL04") {                            
			fnConfirm(row);   
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

<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width=845>
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand" align=absmiddle onClick="fnds_main1();">
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
						<td align="left" bgcolor="#ffffff">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sTrGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^130">
							</object>
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
						<td align=left width=90 class="text">주문일자</td>
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
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="ds_main">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
									<param name="SuppressOption"    value="1">
									<param name="ViewSummary"    	value="1">
							        <param name="Format"            value="
<C> name='거래\\구분'	ID='ORDER_GUBN'	Width=55  align=center  show=true	suppress='4'  editstyle=lookup  data='codeDs1:detail:detail_nm' </C>
<C> name='거래\\구분2'	ID='ORDER_GUBN2'	Width=40  align=center  show=true	suppress='3'  editstyle=lookup  data='codeDs2:detail:detail_nm' </C>
<C> name='주문번호'    	ID='ORDER_NO'  	Width=80  align=center  show=true	suppress='2'</C>
<C> name='주문자명'   	ID='USER_NM'  	Width=70  align=left show=true	suppress=1 	</C>
<C> name='연락처1'      ID='MOBILE_NO'  Width=85  align=left show=true	suppress=1 	</C>
<C> name='제품\\갯수'	ID='ITEM_CNT'  	Width=35  align=center  show=true	Edit=none decao=0	suppress=1 	sumtext=@sum</C>
<C> name='주문총액'		ID='AMT_EXCH'  	Width=70  align=right   show=true	Edit=none decao=0	suppress=1 	sumtext=@sum</C>
<C> name='완납\\여부' 	ID='PAY_YN_TOT'	Width=30  align=center  show=true 	suppress=1  </C>
<G> name='결 제 정 보'
	<C> name='입금액'	ID='PAY_AMT'  	Width=70  align=right   show=true	suppress=1	Edit=none decao=0	sumtext=@sum</C>
	<C> name='일자' 	ID='PAY_DATE'  	Width=60  align=center  show=true 	</C>
	<C> name='방법' 	ID='PAY_CD_NM'  Width=60  align=center  show=true 	</C>
	<C> name='여부' 	ID='PAY_YN'  	Width=30  align=center  show=true 	</C>
	<C> name='총결제액'     ID='PAY_AMT_TOT'  	Width=70  align=right show=true	decao=0 	sumtext=@sum</C>
	<C> name='관리번호' ID='PAY_MANAGE_NO' 	Width=70  align=center  show=true 	</C>
</G>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>				
				</table>
				
			</td>
		</tr>

		<tr>
			<td><BR>※ 1개 주문에 여러 개의 결제 건이 있는 경우 이용가격과 주문총액의 합계는 그만큼 늘어나 표시됩니다.<BR>
			　주의하시기 바랍니다.<BR>
			※ 결제정보의 <b>관리번호</B> 컬럼을 클릭하면 결제정보 창이 뜹니다.
         </td>
     </tr>     

	</table>
	
	

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

