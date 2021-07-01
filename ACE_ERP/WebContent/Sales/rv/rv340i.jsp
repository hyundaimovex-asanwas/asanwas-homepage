<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 관광요금 입금액대체
 * 프로그램ID 	: rv340i
 * J  S  P		: rv340i
 * 서 블 릿		: Rv340I
 * 작 성 자		: 박경국
 * 작 성 일		: 2008-09-24
 * [수  정   일  자][수정자] 내용
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
		cfStyleGrid(getObjectFirst("gr1"), "comn1");
		sSDate.Text = '<%=firstday%>';	
		sEDate.Text = '<%=firstday%>';
		fnInit();

	} 
		 
	function fnInit() {
		// 지역
		v_job = 'init';
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=codeDs2)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
		codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		codeDs1.Reset(); //지역코드

		// 고객구분
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
            "JSP(O:CUSTALL=codeDs3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);
        
        //결제 코드 불러오기
 		codeDs4.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AC001";
		codeDs4.Reset(); //방북목적		

		getObjectFirst("sCustGu").index = 1; // 고객구분 관광객으로 default        
	}
	
	/*
	 * 메인 조회
	 */
	function fnSelect() {
		v_job = "S";
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
					  + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
			          + ",v_out_gubn="+ v_out_gubn.value
			          + ",sCustGu=" + sCustGu.ValueOfIndex("detail", sCustGu.Index);

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv340I",
		    "JSP(O:DS1=ds1)",
		    param);
		   
		tr_post(tr1);
	}
		
	/*
	* 인원 팝업 : 인원 그리드에서 
	*/
	function fnCustPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv004h_01.jsp"
		strPos = "dialogWidth:570px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"D_CUST_NM") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "D_RSV_SID") = arrParam[3];
	   		ds1.namevalue(ds1.rowposition, "D_TOT_PAY_AMT") = arrParam[2];
		} else {
			ds1.namevalue(ds1.rowposition,"D_CUST_NM") = "";
	   		ds1.namevalue(ds1.rowposition, "D_RSV_SID") = "";
			ds1.namevalue(ds1.rowposition,"D_TOT_PAY_AMT") = "";
   		}				
		
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
        getObjectFirst("gr1").SetExcelTitle(1, "value:입금액 대체  관리; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("입금액 대체","입금액대체.xls", 8);
	}

	//처리버튼 : 입금액 대체 결과를 화면에 보여준다.
	function fnSettle() {
		if(ds1.ConutRow <1) return;
		
		if(v_job!="calc"){
			for( i=1; i<=ds1.CountRow; i++ ) {
				var tour_amt 	= 0; //판매가
				var sale_amt_tot= 0; //총정산액
				var remain_amt	= 0; //잔액(=입금액-환불액-환입액-기정산액)
				var D_PAY_AMT	=0; //대체할 금액
				var D_TOT_PAY_AMT	=0; //대체받는 사람  금액
				tour_amt 	= getObjectFirst("ds1").NameValue(i,"tour_amt");
				sale_amt_tot= getObjectFirst("ds1").NameValue(i,"sale_amt_tot");
				remain_amt 	= getObjectFirst("ds1").NameValue(i,"remain_amt");
				D_PAY_AMT 	= getObjectFirst("ds1").NameValue(i,"D_PAY_AMT");
				D_TOT_PAY_AMT 	= getObjectFirst("ds1").NameValue(i,"D_TOT_PAY_AMT");


				if(getObjectFirst("ds1").NameValue(i, "D_PAY_AMT")!=0){
				  if(getObjectFirst("ds1").NameValue(i, "remain_amt") - getObjectFirst("ds1").NameValue(i, "D_PAY_AMT")>=0){
					//잔액이 대체액보다 크면 잔액= 잔액-대체액 ,  대체자 금액=원래금액+대체받는금
					getObjectFirst("ds1").NameValue(i, "remain_amt")=getObjectFirst("ds1").NameValue(i, "remain_amt") - getObjectFirst("ds1").NameValue(i, "D_PAY_AMT");
                    getObjectFirst("ds1").NameValue(i, "D_TOT_PAY_AMT")=getObjectFirst("ds1").NameValue(i, "D_TOT_PAY_AMT") +++ getObjectFirst("ds1").NameValue(i, "D_PAY_AMT");
		       	  }else{ 
		        	alert("잔액을 초과하였습니다");
		          }

				  if(ds1.namevalue(i, "D_RSV_SID")==""){
					alert("대체 받을 사람을 선택해주시기 바랍니다.");
					return false;
				  };
		    	}
		    }
			v_job="calc"; //1번 처리하면 변수를 calc로 넣어준다.2008-07-10
		}else{
		 alert("이미 처리버튼을 누르셨습니다.\n저장 또는 취소 버튼만 가능합니다.");
		 }
	}

	//적용
	function fnApply() {
		if ( ds1.isUpdated ) {
            v_job = "I";
            window.status="저장 중입니다. 잠시만 기다려 주십시오...";
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv340I",
                "JSP(I:DS1=ds1)",
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
			v_job=""; //취소누르면 변수 초기화
		}
		window.status="입금액 대체가 취소되었습니다.";
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
		if(v_job=="I"){
			fnSelect();
		};
	</script>	

	<script language=JavaScript for=sSDate event=OnKillFocus()>
	   if( sSDate.Modified == true )
			sEDate.text = sSDate.text;
	</script>	

	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="D_CUST_NM") {
			fnCustPopup();
		}
		if (colid=="n_card_no") {
			fnNcardPopup();
		}		                              

        if (colid=="room_type_cd") {		
			fnRoomTypePopup();
		}
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
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
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
						<td align=CENTER class="text" width='70'>출경구분</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                        	<select name="v_out_gubn" id="v_out_gubn" class="textbox">
                            	<option value="" selected>전체
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
								<param name="Editable"		value="True">
								<param name="BorderStyle"	value="0">
								<Param Name="AllShowEdit"   value="True">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name=ViewSummary     value=1>
								<param name="Format" 		value="
									
									<C> name='출발일자'   	ID='depart_date'  	width=66 	align=CENTER editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' SumText='합계' Edit=none</C>
									<C> name='상품'   		ID='goods_sid'  	width=60 	align=left editlimit=61 show=true suppress=2 SUMTEXT=@CNT EditStyle=Lookup Data='codeDs2:goods_sid:goods_nm' Edit=none</C>
									<C> name='대리점'   	ID='client_nm'  	width=70 	align=left editlimit=61 show=true suppress=3 SUMTEXT=건 Edit=none</C>
									<C> name='신청서번호'	ID='accept_no'  	width=90 	align=CENTER editlimit=61 show=true suppress=4  Edit=none</C>
									<C> name='객실타입'   	ID='room_type_nm'	width=55 	align=CENTER editlimit=61 show=true SUPPRESS=5 Edit=none</C>
									<C> name='성명'   		ID='cust_nm'  		width=55 	align=LEFT editlimit=61 show=true  SUPPRESS=6 Edit=none</C>
									<C> name='잔 액' 		ID='remain_amt'		width=70 	BgColor=pink align=right editlimit=61 show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='대체 할\\금액'   	ID='D_PAY_AMT'  width=70 	BgColor=pink align=right editlimit=61  show=true SumText=@sum  decao=0 Edit=Numeric	</C>
									<C> name='대체 받을\\사람'	ID='D_CUST_NM' width=70    BgColor=#D7FFDA align=left editlimit=61 editstyle=popup show=true SumText=@sum Edit=any	</C>
									<C> name='받을 사람\\입금액'	ID='D_TOT_PAY_AMT' width=70 BgColor=#D7FFDA align=right editlimit=61  show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='대체받을\\RSV_sid' 		ID='D_RSV_SID'		width=80 	align=center editlimit=61 show=False Edit=none</C>									
									<C> name='결제일자' 	ID='pay_date'		width=60 	align=CENTER editlimit=61 show=true SUPPRESS=8 Edit=none</C>
									<C> name='판매가'   	ID='tour_amt'  		width=60 	align=right editlimit=61 show=true   decao=0 BgColor=#fefec0 Edit=none</C>
									<C> name='입금액'   	ID='pay_amt'  		width=60 	align=right editlimit=61  show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='기정산액' 	ID='sale_amt'  		width=60	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#D7FFDA Edit=none</C>
									<C> name='정산예정액' 	ID='sale_amt_temp'	width=70	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#CCCCFF</C>
									<C> name='환불액'   	ID='refund_amt'  	width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#FED8DB Edit=none</C>
									<C> name='환입액' 	  	ID='fund_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='주민/여권'   	ID='manage_no' 		width=90 	align=center editlimit=61 show=true  Edit=none</C>
									<C> name='결제관리번호' ID='pay_manage_no'	width=90 	align=center editlimit=61 show=true  Edit=none</C>
									<C> name='예약sid' 		ID='rsv_sid'		width=90 	align=center editlimit=61 show=false Edit=none</C>
								">
							</object>
										<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
1. "돈 줄 사람"을 조회합니다.<BR>
2. [잔액] 범위 내에서 대체 할 금액을 입력합니다.<br>
3. [대체 받을 사람]에서 [···] 버튼을 눌러 "돈 받을 사람"을 선택합니다.<br>
3-1. 여러 사람의 경우 2~3번을 반복합니다.<br>
4. [처리] 버튼을 클릭 후 금액을 확인합니다. (받을 사람 입금액 = 최초 입금액 + 대체 할 금액)<br>
5. [저장] 버튼을 누르면 금액이 대체됩니다.<br>
<br>
※ 한 사람이 여러 개의 결제 건을 가진 경우 각 건 별로 표시됩니다.<br>
※ 돈 준 사람은 "타인대체", 받은 사람은 "대체입금"이라는 회계구분 코드로 기록합니다.
			</td>
		</tr>
	</table>
	
 <%
/*=============================================================================
                        Bind 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
        <param name="DataId" value="ds1">
        <param name=BindInfo    value="
            <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
            <C>Col=accept_no                Ctrl=accept_no          Param=Text </C>
            <C>Col=accept_date              Ctrl=accept_date        Param=Text </C>
            <C>Col=goods_sid              Ctrl=v_goods        Param=BindColVal </C>
            <C>Col=depart_date              Ctrl=depart_date        Param=Text </C>
        ">
</object>
<%=HDConstant.COMMENT_END%>	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

