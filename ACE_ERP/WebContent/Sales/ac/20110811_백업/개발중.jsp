<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 관광요금 매출정산
 * 프로그램ID 	: AC130i
 * J  S  P		: ac130i
 * 서 블 릿		: Ac130I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-27
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
 * [2008-03-19][심동현] 관광요금 매출정산으로 메뉴수정
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
		sSDate.Text = '<%=firstday%>';	
		sEDate.Text = '<%=firstday%>';
		sPayDate.Text = '<%=firstday%>';			
		fnInit();

	} 
		 
	function fnInit() {
		// 지역
		div = 'init';
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=codeDs1,O:S_GOODS_DS=codeDs2)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		// 고객구분
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
            "JSP(O:CUSTALL=codeDs3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);
        
        //결제 코드 불러오기
 		codeDs4.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AC001";
		codeDs4.Reset(); //방북목적		
        
	}
	
	
	
	/*
	 * 메인 조회
	 */
	function fnSelect() {
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
					  + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
			          + ",sPayDate=" + sPayDate.Text
			          + ",v_out_gubn="+ v_out_gubn.value
			          + ",v_wrk_gubn="+ v_wrk_gubn.value
   			          + ",sCustGu=" + sCustGu.ValueOfIndex("detail", sCustGu.Index);

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac130I",
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

	//처리버튼 : 정산액 계산하기.
	function fnSettle() {
		if (ds1.ConutRow <1) return;
	    
		for( i=1; i<=ds1.CountRow; i++ ) {
			var tour_amt 	= 0;
			var remain_amt	= 0;
			
			tour_amt 	= getObjectFirst("ds1").NameValue(i,"tour_amt");
			remain_amt 	= getObjectFirst("ds1").NameValue(i,"pay_amt")-getObjectFirst("ds1").NameValue(i,"refund_amt")-getObjectFirst("ds1").NameValue(i,"fund_amt")-getObjectFirst("ds1").NameValue(i, "sale_amt");
			
									
			//판매가 =< (입금액-환불액-환입액-정산액) : 판매가만큼 정산
        	if (tour_amt <= remain_amt) {
	            getObjectFirst("ds1").NameValue(i, "sale_amt")= tour_amt;
	        } else { //판매가 >  (입금액-환불액-환입액-정산액) : 입금액만큼 정산 	즉, 작은 쪽만큼 정산가능!!!
	        	getObjectFirst("ds1").NameValue(i, "sale_amt")= remain_amt;
	        }
		}	
	}

	//적용
	function fnApply() {
		if ( ds1.isUpdated ) {
            v_job = "I";
            window.status="저장 중입니다. 잠시만 기다려 주십시오...";
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac130I",
                "JSP(I:DETAIL=ds1,O:msgDS=msgDS)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
         } else {
         	alert("업데이트된 행이 없습니다.");
		 }
	}	


	//취소
	function fnCancel(){

		if(ds1.IsUpdated){
			ds1.undoall();
		}
		window.status="정산액 계산이 취소되었습니다.";
		return;
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
</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
//		fnHideLoading();		
	</script>	

	<script language=JavaScript for=sSDate event=OnKillFocus()>
	   if( sSDate.Modified == true )
			sEDate.text = sSDate.text;
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
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  고객구분 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 결제방법 -->
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
	<tr height="480">
		<td width="640px" background="<%=dirPath%>/Sales/images/coming.jpg">
		</td>
	</tr>
</table>
<!--
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' bgcolor='#666666'>
								<tr>
									<td align=left class="text" width="50">지역</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs1>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^80">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align="center" width="50" height="30px" class="text" >대리점</td>
									<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
			                            &nbsp;
									</td>
									<td align=CENTER class="text" width="65">상품정보</td>
				                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs2>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^120"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">
				                        <img src="<%=dirPath%>/Sales/images/settle.gif" 	style="cursor:hand" align=absmiddle onClick="fnSettle();">
				                        <img src="<%=dirPath%>/Sales/images/save.gif" 		style="cursor:hand" align=absmiddle onClick="fnApply();">
				                        <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle onclick="fnCancel()">
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
						<td align=CENTER class="text" width='70'>출경구분</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                        	<select name="v_out_gubn" id="v_out_gubn" class="textbox">
                            	<option value="">전체
                                <option value="Y">출경
                                <option value="N">미출경
                            </select>
                        </td>
	                    <td align="center" width="70px" class="text">고객구분</td>
						<td align="center" bgcolor="#ffffff">
							<%=HDConstant.COMMENT_START%>
							<object id=sCustGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs3>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>	
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
								<param name=ViewSummary     value=1>
								<param name="Format" 		value="
									<C> name='출발일자'   	ID='depart_date'  	width=66 	align=CENTER editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' SumText='합계'</C>
									<C> name='상품'   		ID='goods_sid'  	width=60 	align=left editlimit=61 show=true suppress=2 SUMTEXT=@CNT EditStyle=Lookup Data='codeDs2:goods_sid:goods_nm'</C>
									<C> name='대리점'   	ID='client_nm'  	width=70 	align=left editlimit=61 show=true suppress=3 SUMTEXT=건</C>
									<C> name='신청서번호'	ID='accept_no'  	width=90 	align=CENTER editlimit=61 show=true suppress=4 </C>
									<C> name='객실타입'   	ID='room_type_nm'	width=55 	align=CENTER editlimit=61 show=true SUPPRESS=5</C>
									<C> name='성명'   		ID='cust_nm'  		width=55 	align=LEFT editlimit=61 show=true SUPPRESS=6</C>
									<C> name='결제방법'   	ID='pay_cd'  		width=55 	align=CENTER editlimit=61 show=true SUPPRESS=7 EditStyle=Lookup Data='codeDs4:DETAIL:DETAIL_NM'</C>
									<C> name='결제일자' 	ID='pay_date'		width=60 	align=CENTER editlimit=61 show=true SUPPRESS=8</C>
									<C> name='판매가'   	ID='tour_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#fefec0</C>
									<C> name='입금액'   	ID='pay_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='정산액' 	 	ID='sale_amt'  		width=60	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#D7FFDA</C>
									<C> name='환불액'   	ID='refund_amt'  	width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#FED8DB</C>
									<C> name='환입액' 	  	ID='fund_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0</C>
									<C> name='주민/여권'   	ID='manage_no' 		width=90 	align=center editlimit=61 show=true </C>
									<C> name='결제관리번호' ID='pay_manage_no'	width=90 	align=center editlimit=61 show=true </C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
				-. 판매가 : 해당 손님의 판매가 (할인, 할증 포함)<br>
				-. 입금액 : 해당 손님 결제건의 입금액<br>
				-. 정산액 : 해당 손님 결제건의 입금액 중 정산처리한 금액<br>
				-. 환불액 : 해당 손님 결제건의 입금액 중 환불처리한 금액<br>
				-. 환입액 : 해당 손님 결제건의 입금액 중 환불처리한 금액
			</td>
		</tr>
	</table>-->

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

