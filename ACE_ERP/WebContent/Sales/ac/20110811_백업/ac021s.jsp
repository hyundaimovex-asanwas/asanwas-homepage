<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 출발일별 현황
 * 프로그램ID 	: AC020S
 * J  S  P		: ac020s
 * 서 블 릿		: Ac020S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-27
 * 기능정의		:
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
 * [2007-10-30][심동현] 보증금, 온라인카드 컬럼 추가 
 * [2008-11-04][박경국] 출경구분 조회조건 => 예약상태 조회조건으로 변경
 * [2008-11-05][박경국] 출경구분 조회조건 => 영업담당자 조건추가
 * [2010-04-21][심동현] 공급가액, 부가세 컬럼 추가~
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
		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr_main"), "comn");
			sSDate.Text = '<%=firstday%>';	
			sEDate.Text = '<%=firstday%>';	
			fnInit();

		} 
		 
		function fnInit() {
			div = 'init';
        
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드
			//고객구분
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
	            "JSP(O:CUSTALL=ds_custGu)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
	        
	        //영업담당자
        	ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds_saldam.Reset();
	        
	        //예약상태
       		ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y";
            ds_status.Reset();	
        
	        // 고객구분 관광객으로 default
	        getObjectFirst("lc_custGu").index = 1; 
	        
		}
		
		
		
		// 메인 조회
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					  + ",sSalDamSid=" + sSalDamSid.value
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
		              + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
			          + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index)
   			          + ",sCustGu=" + lc_custGu.ValueOfIndex("detail", lc_custGu.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac020S",
			    "JSP(O:DS1=ds_g_main)",
			    param);
			    
			   // prompt('',param);
			   
			tr_post(tr1);
		}
			
		// 엑셀
		function fnExcelds_g_main() {
			if(ds_g_main.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr_main").SetExcelTitle(0, "");
	        getObjectFirst("gr_main").SetExcelTitle(1, "value:출발일별현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_main").GridToExcel("출발일별현황","출발일별현황.xls", 8);
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
	
	    
		//검색조건 대리점  팝업 
	    function fnResultPop(gubun) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	       
	        var param = "&sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                 + "&sGoods_sid=" + ds_g_main.namevalue(ds_g_main.rowposition, "goods_sid")
		                     + "&sClient_sid=" + ds_g_main.namevalue(ds_g_main.rowposition, "client_sid")
			                 + "&sSDate=" + ds_g_main.namevalue(ds_g_main.rowposition, "depart_date")
			                 + "&sUpjang_sid=" + ds_g_main.namevalue(ds_g_main.rowposition, "upjang_sid")
			                 + ",sCustGu=" + lc_custGu.ValueOfIndex("detail", lc_custGu.Index)
							 + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index);
          
			if (gubun == "020") {			//가상계좌
				var strURL = '<%=dirPath%>/Sales/help/ac020_1h.jsp?dsType=1' + param;
			} else if (gubun == "030") {	//계좌이체
				var strURL = '<%=dirPath%>/Sales/help/ac020_2h.jsp?dsType=2' + param;
			} else if (gubun == "040") {	//신용카드edi
				var strURL = '<%=dirPath%>/Sales/help/ac020_3h.jsp?dsType=3' + param;
			} else if (gubun == "050") {	//온라인카드
				var strURL = '<%=dirPath%>/Sales/help/ac020_9h.jsp?dsType=3' + param;
			} else if (gubun == "060") {	//상품권
				var strURL = '<%=dirPath%>/Sales/help/ac020_4h.jsp?dsType=4' + param;
			} else if (gubun == "080") {	//무통장입금. dsType 변수는 그닥 의미 없어보이는데;; 움..
				var strURL = '<%=dirPath%>/Sales/help/ac020_5h.jsp?dsType=5' + param;
			} else if (gubun == "090") {	//기타대체
				var strURL = '<%=dirPath%>/Sales/help/ac020_6h.jsp?dsType=6' + param;
			} else if (gubun == "100") {	//보증금
				var strURL = '<%=dirPath%>/Sales/help/ac020_8h.jsp?dsType=6' + param;
			} else if (gubun == "3") {		//환불
				var strURL = '<%=dirPath%>/Sales/help/ac020_7h.jsp?dsType=6' + param;
			} else if (gubun == "4") {		//환입
				var strURL = '<%=dirPath%>/Sales/help/ac020_7h.jsp?dsType=6' + param;
			};

//			prompt("",strURL);
		    var strPos = "dialogWidth:820px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		    arrResult = showModalDialog(strURL,arrParam,strPos); 
		   
		//   window.open(strURL, 'test', strPos);
	    
	    } 

		//상품조회
		function fnSelectLcGoods() {
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
				    + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
					+ ",sDepartDate=";
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=ds_goods)",
			    param);
			tr_post(tr2);
		};
		
	   //자동셋팅 영업담당자
	   function fnSetting(dataSet) {
	      var exit=false;
	      if ( dataSet == 'ds_saldam' ) {  //대리점
	         for ( i=1; i<=ds_saldam.CountRow; i++ ) {
	            if ( ds_saldam.namevalue(i,"sal_dam_cd") == sSalDamCd.value ) {
	               sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
	               sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
	               exit=true;
	               return;
	            }
	         }
	         if ( exit != true ) {
	               sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
	               sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
	         }
	      }
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
		</script>	
	
		<script language=JavaScript for=sSDate event=OnKillFocus()>
		   if( sSDate.Modified == true )
				sEDate.text = sSDate.text;
		</script>	
	
		<script language=JavaScript for=gr_main event=OnLButtonDblClk(row,colid,xpos,ypos)>
			if (colid == "a_amt") {
			
				if (ds_g_main.namevalue(ds_g_main.rowposition, "a_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('020');
			} else if (colid == "b_amt") {
				if (ds_g_main.namevalue(ds_g_main.rowposition, "b_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('030');
			} else if (colid == "c_amt") {	//신용카드
				if (ds_g_main.namevalue(ds_g_main.rowposition, "c_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('040');
			} else if (colid == "h_amt") {	//온라인카드
				if (ds_g_main.namevalue(ds_g_main.rowposition, "h_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('050');
			} else if (colid == "d_amt") {
				if (ds_g_main.namevalue(ds_g_main.rowposition, "d_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('060');
			} else if (colid == "e_amt") {	//무통장입금
				if (ds_g_main.namevalue(ds_g_main.rowposition, "e_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('080');
			} else if (colid == "f_amt") {	//기타대체
				if (ds_g_main.namevalue(ds_g_main.rowposition, "f_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('090');		
			} else if (colid == "g_amt") {	//보증금대체
				if (ds_g_main.namevalue(ds_g_main.rowposition, "g_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('100');
			}else if (colid == "refund_amt") {	//환불
				if (ds_g_main.namevalue(ds_g_main.rowposition, "refund_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('3');				
			}else if (colid == "fund_amt") {	//환입
				if (ds_g_main.namevalue(ds_g_main.rowposition, "fund_amt") == 0) {
					alert("조회할 내용이 없습니다!");
					return;
				}
				fnResultPop('4');				
			}
		</script>


<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_g_main classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_custGu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  고객구분 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>><!--  영업담당자  -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 예약상태 -->
    <param name="SyncLoad"  value="True">
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
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' width='605' bgcolor='#666666'>
								<tr>
									<td align=center width=65 class="text">영업담당자</td>
                                	<td align=left bgcolor="#ffffff">&nbsp;
										<input id="sSalDamSid" type="hidden" value="0">
										<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
										<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
										<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
									</td>
								     <td align=center class="text" width="60">예약상태</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=70 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_status>
                                            <param name=ListExprFormat  value="detail_nm^0^70">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
			                        <td align="center" width="60px" height="30px" class="text">고객구분</td>
										<td align="center" bgcolor="#ffffff">
											<%=HDConstant.COMMENT_START%>
											<object id=lc_custGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
												<param name=ComboDataID		value=ds_custGu>
												<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
												<param name=ListExprFormat  value="detail_nm^0^100">
											</object>
											<%=HDConstant.COMMENT_END%>	
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
								<tr>
								
									<td align='CENTER'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelds_g_main()">		<!-- 엑셀 -->
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
						<td align=left class="text" width="60px">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align="center" width="60px" height="30px" class="text" >대리점</td>
						<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
                            <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='textbox'>
                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
						</td>
						<td align=left class="text"  width="60">출발일자</td>
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
 
																											
							</object>~
						
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
						<td align=left class="text" width="80">상품정보</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=160 width=140 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
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
							<object id=gr_main classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds_g_main">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								 <param name=ViewSummary     value=1>
								<param name="Format" 			value="
									
									<C> name='출발일자'   	ID='depart_date' width=70 	align=center editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' SumText='합계'</C>
									<C> name='상품'   		ID='goods_nm'  	width=100 	align=left editlimit=61 show=true suppress=2 </C>
									<C> name='대리점'   	ID='client_nm'  width=100 	align=left editlimit=61 show=true suopress=3</C>
									<C> name='예약상태'    	ID='STATUS_CD'  width=60 	align=left Edit=None</C>
									<C> name='영업장'   	ID='upjang_nm'  width=100 	align=left editlimit=61 show=true </C>
									<C> name='인원수'   	ID='p_cnt'  	width=40 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right</C>
									<C> name='매출액'   	ID='tour_amt'  	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
					                <C> name='공급가액'     ID='supp_amt' 	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
					                <C> name='부가세'      	ID='tax_amt' 	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>

									<C> name='정산액'   	ID='sale_amt'  	width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='입금액'   	ID='pay_amt'  	width=100 	align=right editlimit=61 show=true  SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='외상매출금'   ID='credit_amt' width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='과입액'       ID='over_amt'   width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<G>	name='입금액 상세'
									<C> name='가상계좌'   	ID='a_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='신용카드'   	ID='c_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='온라인카드' 	ID='h_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='상품권'		ID='d_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
		                            <C> name='무통장입금'	ID='e_amt'      width=80    align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
		                            <C> name='기타대체'		ID='f_amt'      width=80    align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='보증금'		ID='g_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								</G>
									<C> name='보증금환입액' ID='fund_deposit_amt'  width=80	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='환불액'       ID='refund_amt' width=80	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='환입액'       ID='fund_amt'  	width=80	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>

									<C> name='계좌이체'   	ID='b_amt'  	width=80 	align=right editlimit=61 show=false SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='상품'			ID='goods_cd'  	width=100 	align=left editlimit=61 show=false</C>
									<C> name='영업장'		ID='upjang_cd'  	width=100 	align=left editlimit=61 show=false</C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>※ 상품>대리점>영업장 별로 집계되므로 출경구분 값음 GRID에 표시되지 않습니다.<BR>
			　관광객별 상세 정산현황을 보시려면 [홈>관광영업>정산관리>매출 관리>고객별 정산현황]을 참고해주세요.

			</td>
		</tr>
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

