<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 사업자 정산현황
 * 프로그램ID 	: AC130s_BIZ
 * J  S  P		: ac130s_biz
 * 서 블 릿		: Ac130s_BIZ
 * 작 성 자		: 심동현
 * 작 성 일		: 2008-03-27
 * 수정내용		: AC001	 	입금결제코드
 * 수정내용		: AC001	010	현금
 * 수정내용		: AC001	020	가상계좌
 * 수정내용		: AC001	030	계좌이체
 * 수정내용		: AC001	040	신용카드
 * 수정내용		: AC001	050	인터넷(카)
 * 수정내용		: AC001	060	상품권
 * 수정내용		: AC001	070	외상
 * 수정내용		: AC001	080	무통장입금
 * 수정내용		: AC001	090	기타대체
 * 수정내용		: AC001	100	보증금
 * 수정내용		: AC001	110	보증금환불
 * 수정내용		: AC001	910	조정금액1
 * 수정내용		: AC001	920	조정금액2
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-03-28][심동현] 
 * [2008-07-10][심동현] 과입금(입금-판매가) 표시
 * [2008-07-15][심동현] 외상매출금 계산 재수정! 과입은 외상이 -일때 곱해서 보여주기..
 * [2008-11-05][심동현] 검색조건 수정: 출경구분 → 예약상태
 * 								 추가: 담당자 
 * [2010-03-11][심동현] "작업구분" 값 조정 , [전체] 추가..~
 * [2010-03-11][심동현] 고객구분 사업자 고정
 * [2010-03-22][박경국] [사업자비용] 리포트 출력 기능 추가.                                                                                               
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
	 var v_job='';
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("gr1"), "comn");
		sSDate.Text = '<%=firstday%>';	
		sEDate.Text = '<%=firstday%>';
		sPayDate.Text = '<%=firstday%>';			
		fnInit();

	} 
		 
	function fnInit() {
		v_job = 'init';
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드

		// 고객구분
//        ln_TRSetting(tr2, 
//            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
//            "JSP(O:CUSTALL=codeDs3)",
//            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
//        tr_post(tr2);
        
        //결제 코드 불러오기
 		codeDs4.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AC001";
		codeDs4.Reset(); //방북목적		

        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_Item1=Y";
        ds_status.Reset();	//예약상태


//		getObjectFirst("sCustGu").index = 1; // 고객구분 관광객으로 default        
	}
	
	
	
	/*
	 * 메인 조회
	 */
	function fnSelect() {
		v_job = "S";
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
 			          + ",dsType=1"
					  + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
					  + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
			          + ",sPayDate=" + sPayDate.Text
                      + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index)			          
	                  + ",sSalDamSid=" 	+ sSalDamSid.value                      
			          + ",v_wrk_gubn="+ v_wrk_gubn.value
   			          + ",sCustGu=2"	//사업자전용 
//   			          + ",sCustGu=" + sCustGu.ValueOfIndex("detail", sCustGu.Index);

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac130S_BIZ",
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
        getObjectFirst("gr1").SetExcelTitle(1, "value:매출정산 관리; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("매출정산 관리","매출정산관리.xls", 8);
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
    
	//영업담당자 팝업
	function fnPopup4() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sSalDamSid.value = arrParam[0];
				sSalDamCd.value = arrParam[1];
				sSalDamNm.value = arrParam[2];
			} else {
		    	sSalDamSid.value = 0;
				sSalDamCd.value = '';
				sSalDamNm.value = '';
			}
	}

	//상품조회
	function fnSelectLcGoods() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
				+ ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				+ ",sDepartDate=";
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		    "JSP(O:S_GOODS_DS=ds_goods)",
		    param);
		tr_post(tr1);
	};
	 /*
	 * 레포트
	 */
	function fnPrint() {
		var Row=ds1.rowposition;
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				      + ",dsType=2"
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
					  + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
		              + ",sPayDate=" + sPayDate.Text
                      + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index)			          
	                  + ",sSalDamSid=" 	+ sSalDamSid.value                      
			          + ",v_wrk_gubn="+ v_wrk_gubn.value
			          + ",v_accept_no="+getObjectFirst("ds1").NameValue(Row, "accept_no")
			          + ",v_real_client="+getObjectFirst("ds1").NameValue(Row, "real_client")
			          + ",sCustGu=2"	//사업자전용 
//   			          + ",sCustGu=" + sCustGu.ValueOfIndex("detail", sCustGu.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac130S_BIZ",
		    "JSP(O:DEFAULT=ds9)",
		    param);
		   
		tr_post(tr1);
    }
    
</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectLcGoods();//상품 재검색
	</script>	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
//		fnHideLoading();		
		if(v_job=="I"){
			fnSelect();
		};
	</script>	

	<script language=JavaScript for=sSDate event=OnKillFocus()>
	   if( sSDate.Modified == true )
			sEDate.text = sSDate.text;
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
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  고객구분 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 결제방법 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 예약상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트--%>


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
							<table border='0' celpadding='0' cellspacing='1' bgcolor='#666666'>
								<tr>
									<td align=left class="text" width="40">지역</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_saup>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^80">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align="center" width="45" height="30px" class="text" >대리점</td>
									<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
			                            &nbsp;
									</td>
									<td align=CENTER class="text" width="60">상품정보</td>
				                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_goods>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^120"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
	            					<td align=center width=65 class="text">영업담당자</td>
	                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
										<input id="sSalDamSid" type="hidden" value="0">
										<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
										<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								  	</td>									
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
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
						<td align=CENTER class="text"  width="70">출발일자</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
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
							</object>&nbsp;~&nbsp;
	                       	<object id=sEDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
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
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=CENTER class="text" width="70">작업구분</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;	
                        	<select name="v_wrk_gubn" id="v_wrk_gubn" class="textbox">
                                <option value="">전체
                                <option value="1">정산
                                <option value="2">외상매출
                            </select></td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;	
                            <%=HDConstant.COMMENT_START%>
	                       	<object id=sPayDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
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
							</object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>
                        <td align=left class="text" width="70">예약상태</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=70 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_status>
                                <param name=ListExprFormat  value="detail_nm^0^70">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
	                    <td align="center" width="70px" class="text">Invoice</td>
						<td align="center" bgcolor="#ffffff"><img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" align=absmiddle 	OnClick="fnPrint()">
						</td><!-- 출력 -->
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
								<param name=ViewSummary     value=1>
								<param name="Format" 		value="
									<C> name='출발일자'   	ID='depart_date'  	width=66 	align=CENTER editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' SumText='합계'</C>
									<C> name='상품'   		ID='goods_sid'  	width=60 	align=left editlimit=61 show=true suppress=2 SUMTEXT=@CNT EditStyle=Lookup Data='ds_goods:goods_sid:goods_nm'</C>
									<C> name='대리점'   	ID='client_nm'  	width=70 	align=left editlimit=61 show=true suppress=3 SUMTEXT=건</C>
									<C> name='신청서번호'	ID='accept_no'  	width=90 	align=CENTER editlimit=61 show=true suppress=4 </C>
									<C> name='비용부담회사'	ID='real_client_nm'	width=90 	align=CENTER editlimit=61 show=true suppress=5 </C>
									<C> name='비용부담sid'	ID='real_client'	width=90 	align=CENTER editlimit=61 show=false </C>
									<C> name='객실타입'   	ID='room_type_nm'	width=55 	align=CENTER editlimit=61 show=true SUPPRESS=6</C>
									<C> name='성명'   		ID='cust_nm'  		width=55 	align=LEFT editlimit=61 show=true   </C>
									<C> name='상태'   		ID='status_cd' 		width=55 	align=center editlimit=61 show=true   </C>
									<C> name='판매가'   	ID='tour_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#fefec0</C>
									<C> name='입금액'   	ID='pay_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='정산액' 	 	ID='sale_amt'  		width=60	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#D7FFDA</C>
									<C> name='환불액'   	ID='refund_amt'  	width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#FED8DB</C>
									<C> name='환입액' 	  	ID='fund_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='외상매출' 	ID='credit_amt'  	width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='과입액' 		ID='over_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='대행사' 		ID='agency_amt' 	width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='주민/여권'   	ID='manage_no' 		width=90 	align=center editlimit=61 show=true </C>									
									<C> name='예약sid' 		ID='rsv_sid'		width=90 	align=center editlimit=61 show=false</C>
									
									
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
				※ 고객별 정산현황을 조회할 수 있습니다.<Br>
				　-. 판 매 가 : 해당 손님의 판매가 (할인, 할증 포함)<br>
				　-. 입 금 액 : 해당 손님의 입금액<br>
				　-. 정 산 액 : 해당 손님의 정산처리한 금액<br>
				　-. 환 불 액 : 해당 손님의 환불처리한 금액<br>
				　-. 환 입 액 : 해당 손님의 환입처리한 금액<br>
				　-. 외상매출 : 해당 손님의 외상매출 금<br>
				　-. 과 입 액 : 해당 손님의 입금액 - (판매가+환불액+환입액)<br>
			</td>
		</tr>
	</table>
<%
/*=============================================================================
			레포트 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
		<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds9">
		<PARAM NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="Format"                value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=466 ,face='Tahoma' ,size=10 ,penwidth=1
	<I>id='../images/report/head.jpg' ,left=151 ,top=48 ,right=1849 ,bottom=434</I>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=520 ,penwidth=1,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'
	<L> left=110 ,top=40 ,right=110 ,bottom=520 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=40 ,right=1900 ,bottom=520 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=40 ,right=110 ,bottom=40 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=400 ,right=110 ,bottom=400 ,penstyle=solid ,pencolor=#000000 </L>
	<L> left=370 ,top=40 ,right=370 ,bottom=520 </L>
	<L> left=760 ,top=400 ,right=760 ,bottom=520 </L>
	<L> left=1530 ,top=400 ,right=1530 ,bottom=520 </L>
	<L> left=1080 ,top=400 ,right=1080 ,bottom=520 </L>
	<L> left=1370 ,top=400 ,right=1370 ,bottom=520 </L>
	<L> left=110 ,top=520 ,right=1900 ,bottom=520 ,penstyle=solid  ,pencolor=#000000 </L>
	<L> left=1900 ,top=280 ,right=110 ,bottom=280 ,penstyle=solid </L>
	<L> left=1900 ,top=160 ,right=110 ,bottom=160 ,penstyle=solid </L>
	<T>id='업체명' ,left=140 ,top=40 ,right=350 ,bottom=160 ,face='Tahoma' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='성명' ,left=140 ,top=400 ,right=350 ,bottom=520 ,face='Tahoma' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='인원' ,left=140 ,top=280 ,right=350 ,bottom=400 ,face='Tahoma' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='방문지' ,left=140 ,top=160 ,right=350 ,bottom=280 ,face='Tahoma' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='명' ,left=470 ,top=280 ,right=580 ,bottom=400 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='left'</T>
	<T>id='상품' ,left=370 ,top=400 ,right=760 ,bottom=520 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='비고' ,left=1609 ,top=400 ,right=1820 ,bottom=520 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='기간' ,left=820 ,top=400 ,right=1032 ,bottom=520 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='금액(원)' ,left=1080 ,top=400 ,right=1370 ,bottom=520 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<T>id='박수' ,left=1376 ,top=400 ,right=1529 ,bottom=520 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T>
	<C>id='REAL_CLIENT_NM', left=420, top=40, right=1800, bottom=160,align='left'</C>
	<C>id='SAUP_NM', left=420, top=160, right=1800, bottom=280,align='left'</C>
	<S>id='COUNT', left=420, top=280, right=470, bottom=400,align='left'</S>
</B>
<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=120 ,penwidth=1,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'
	<L> left=1900 ,top=0 ,right=1900 ,bottom=120,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1530 ,top=0 ,right=1530 ,bottom=120 </L>
	<L> left=1370 ,top=0 ,right=1370 ,bottom=120 </L>
	<L> left=1080 ,top=0 ,right=1080 ,bottom=120 </L>
	<L> left=760 ,top=0 ,right=760 ,bottom=120 </L>
	<L> left=110 ,top=0 ,right=110 ,bottom=120,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=370 ,top=0 ,right=370 ,bottom=120 </L>
	<L> left=110 ,top=120 ,right=1900 ,bottom=120 </L>
	<C>id='CUST_NM', left=110, top=10, right=370, bottom=120</C>
	<C>id='GOODS_NM', left=370, top=10, right=760, bottom=120</C>
	<C>id='TERM', left=760, top=10, right=1080, bottom=120</C>
	<C>id='TOUR_AMT', left=1180, top=10, right=1370, bottom=120	decao=0</C>
	<C>id='NIGHTS', left=1400, top=10, right=1530, bottom=120</C>
	<C>id='REMARKS', left=1530, top=10, right=1900, bottom=120	decao=0</C>



</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=750 ,face='Tahoma' ,size=13 ,penwidth=1,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'
	<L> left=1080 ,top=0 ,right=1080 ,bottom=120 </L>
	<L> left=370 ,top=120 ,right=370 ,bottom=640 </L>
	<L> left=110 ,top=120 ,right=110 ,bottom=640,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=110 ,top=120 ,right=1900 ,bottom=120,penstyle=solid ,pencolor=#000000 </L>
	<L> left=110 ,top=640 ,right=1900 ,bottom=640,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=120 ,right=1900 ,bottom=640,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=370 ,top=0 ,right=370 ,bottom=120,penstyle=solid  ,pencolor=#000000 </L>
	<L> left=110 ,top=0 ,right=110 ,bottom=120,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1370 ,top=0 ,right=1370 ,bottom=120 </L>
	<L> left=370 ,top=0 ,right=1900 ,bottom=0,penstyle=solid ,pencolor=#000000 </L>
	<L> left=1900 ,top=0 ,right=1900 ,bottom=120 ,penstyle=solid ,penwidth=5 ,pencolor=#000000</L>
	<T>id='총 계' ,left=370 ,top=0 ,right=1080 ,bottom=120 ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특이사항' ,left=151 ,top=300 ,right=362 ,bottom=431 ,face='Tahoma' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1) 사업자요금 포함사항' ,left=402 ,top=159 ,right=1754 ,bottom=225 ,align='left' ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFFp</T>
	<T>id='     - 식사, 교통비(남측CIQ <-->금강산), 방북지원비, 숙박비' ,left=402 ,top=220 ,right=1754 ,bottom=286 ,align='left' ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     * 당일의 경우 숙박비 제외' ,left=405 ,top=282 ,right=1757 ,bottom=348 ,align='left' ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2) 기타사항' ,left=402 ,top=386 ,right=1754 ,bottom=452 ,align='left' ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     - 서울 <--> 고성간 버스 요금 본인 부담' ,left=407 ,top=455 ,right=1759 ,bottom=521 ,align='left' ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     - 관광요금 송금계좌: 신한은행 741-03-001948 현대아산(주)' ,left=407 ,top=527 ,right=1759 ,bottom=593 ,align='left' ,face='Tahoma' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='년' ,left=850 ,top=700 ,right=950 ,bottom=750 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=1110 ,top=700 ,right=1210 ,bottom=750 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일' ,left=1340 ,top=700 ,right=1440 ,bottom=750 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='REMARKS', left=1530, top=0, right=1900, bottom=120	</C>
	<S>id='{Sum(TOUR_AMT)}', left=1180, top=0, right=1370, bottom=120	decao=0</S>
	<C>id='', left=1217, top=700, right=1328, bottom=750</C>
	<C>id='', left=738, top=700, right=849, bottom=750</C>
	<C>id='', left=974, top=700, right=1093, bottom=750</C>
	
</B>
<B>id=Footer ,left=0 ,top=2460 ,right=2000 ,bottom=2660 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='현대 아산 주식회사' ,left=1150 ,top=0 ,right=1640 ,bottom=100 ,face='Tahoma' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관 광 사 업 본 부 장' ,left=1150 ,top=100 ,right=1640 ,bottom=200 ,face='Tahoma' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

