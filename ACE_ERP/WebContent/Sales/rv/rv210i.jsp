<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : inboubd 관광 예약 (PLZ)
 * 프로그램ID 	 : rv210i
 * J  S  P		 : rv210i
 * 서 블 릿		 : rv210i
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-09
 * 기능정의		 : 승급/FOC/AD (조회, 저장, 취소)
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
	
    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);

%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
//			fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnInit();
	}


    /*
     * 초기작업
     * Header 설정 
     * 지역
     */
    function fnInit() {
    	//지역, 상품
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=S&s_BoundGu=02";
		ds_saup.Reset();
        
        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_Item1=Y";
        ds_status.Reset();	//예약상태
    
        v_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
       
       fnSetHeaderDs1();
    }
 
 	// 데이터셋 헤더 설저 (디테일)
 	function fnSetHeaderDs1(){
		if (ds1.countrow<1){	//헤더 초기화를 위해 강제 선조회
			v_job = "H";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                  + ",sGoodsSid=28"
                  + ",sDepartDate=20090101";
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv210I",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);
		}
	}
		
 
    /*
     * 메인 조회
     */
    function fnSelect() {
        var fr_date = v_depart_date.Text.trim();
        if(fr_date.length!=8) {
            alert("출발일자(From)를 입력하시길 바랍니다.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                  + ",sSaupSid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                  + ",sGoodsSid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
                  + ",sClientSid=" + v_client_sid.value
                  + ",sDepartDate=" + v_depart_date.Text
                  + ",sStatusCd=" + v_status.ValueOfIndex("detail", v_status.Index)
                  + ",sAcceptNo=" + v_accept_no.Text;
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv210I",
            "JSP(O:DS1=ds1)",
            param);
           
        tr_post(tr1);
    }
     
    function fnExcelDs1() {
        if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_cust").SetExcelTitle(0, "");
        getObjectFirst("gr_cust").SetExcelTitle(1, "value:관광예약현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_cust").GridToExcel("관광예약현황", "관광예약현황.xls", 8);        
    }

    /**
     * 검색조건 대리점  팝업 
     */
    function fnSelClientPopup(dirPath, servletPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrResult = fnClientPop(dirPath,'1');
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_sid.value = arrParam[0];
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
        } else {
            v_client_sid.value = "";
            v_client_nm.value  = "";
            v_client_cd.value = "";
        }               
    }

    // 신청서 번호 조회
    function fnAcceptNoPopup(dirPath, servletPath){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop(dirPath);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
        }
    }


	//상품조회
	function fnSelectGoodsLC() {
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
	
	
	/* 그리드 행추가*/
	function fnAddRow() {
		if(!v_client_sid.value) {
			alert("대리점을 입력하시기 합니다.");
			return;
		}
        var fr_date = v_depart_date.Text.trim();
        if(fr_date.length!=8) {
            alert("출발일자를 입력하시기 바랍니다.");
            v_depart_date.focus();
            return;
        }
		if(lc_goods.Index==0) {
			alert("상품을 선택하시기 바랍니다.");
			return;
		}		

		ds1.addRow();	
		ds1.namevalue(ds1.rowposition,"client_sid") = v_client_sid.value;
		ds1.namevalue(ds1.rowposition,"depart_date")= fr_date;
		ds1.namevalue(ds1.rowposition,"saup_sid") 	= lc_saup.ValueOfIndex("saup_sid", lc_saup.Index);
		ds1.namevalue(ds1.rowposition,"saup_nm") 	= lc_saup.ValueOfIndex("saup_nm", lc_saup.Index);
		ds1.namevalue(ds1.rowposition,"goods_sid")  = lc_goods.ValueOfIndex("goods_sid", lc_goods.Index);
		ds1.namevalue(ds1.rowposition,"goods_nm")   = lc_goods.ValueOfIndex("goods_nm", lc_goods.Index);
		ds1.namevalue(ds1.rowposition,"age_cd")  	= "1";
		ds1.namevalue(ds1.rowposition,"status_cd")  = "RA";
		ds1.namevalue(ds1.rowposition,"accept_no")  = v_accept_no.Text;;
	}


	//취소
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//상품 재검색
	</script>	
	
	
		<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
/*			var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
			lc_status2.index=index;
			index=lc_job.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"ad_job_sel"));
			lc_job.index=index;			
			
		    imgDs.RowPosition = Row;							*/
		</script>
		
		<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
		    	txt_file.value = gcip_file.value;
		    	photo.src = gcip_file.value;
		    }
		</script>	

		<script language=JavaScript for=sBgnDate event=OnKillFocus()> 
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
			}
		</script>		
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds_job event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";	                	 			 	
	</script>		
		
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품코드 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 예약상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 고객 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 국적 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=initds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 사업 -->
    <param name="SyncLoad"  value="True">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="50px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnAddRow()">
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
					 			</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>											
	</tr>
											
	<tr height="30px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr align=center>
                                <td class="text" width="70"><b>대리점</b></td>
                                <td align=left bgcolor="#FFFFFF" WIDTH="240">&nbsp;<input type="text" value="<%=c_cd%>" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
                                    <input type="hidden" value="<%=c_sid%>" name='v_client_sid' id='v_client_sid'>
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:120px;" class='input01' readOnly>
                                </td>
                                <td class="text" width="70"><b>신청서번호</b></td>
                                <td align=left bgcolor="#FFFFFF">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000-000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=true>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn">
                                </td>
								<td class="text" width="70">예약상태</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=70 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_status>
                                        <param name=ListExprFormat  value="detail_nm^0^70">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr align=center>
		                        <td class="text"><b>출발일자</b></td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
		                                <param name=Text        value="">
		                                <param name=Alignment   value=1>
		                                <param name=Format      value="0000-00-00">
		                                <param name=Cursor      value="iBeam">
		                                <param name=Border      value="false">      
		                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                                <param name=ReadOnly    value="false">
		                                <param name=SelectAll   value="true">
		                                <param name=SelectAllOnClick    value="true">
		                                <param name=SelectAllOnClickAny   value=false>
		                            </object>
		                            <%=HDConstant.COMMENT_END%>                                                                             
		                        </td>                                                                                           
                				<td class="text"><b>지역</b></td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
		                                <param name=ComboDataID     value=ds_saup>
		                                <param name=BindColumn      value="saup_sid">
		                                <param name=BindColVal      value="saup_sid">
		                                <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
		                                <param name=ListExprFormat  value="saup_nm^0^100">
		                            </object>
		                            <%=HDConstant.COMMENT_END%>
		                        </td>   
		                        <td class="text"><b>상품정보</b></td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
		                                <param name=ComboDataID     value=ds_goods>
		                                <param name=ListExprFormat  value="goods_nm^0^150"></object>
		                            <%=HDConstant.COMMENT_END%>
		                        </td>
																			
            				</tr>
            			</table>
					</td>
				</tr>															
			</table>	
		</td>											
	</tr>
	<tr>
		<td height="10"></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0" border=1>
				<tr valign="top"">
					<td align="left" width="450px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=450px; height:370" border="1" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name="Format" 			value="
				                <C> name='출발일자'			ID='depart_date' width=60  align=center editlimit=8  edit=none  show=true</C>
				                <C> name='지역'  			ID='saup_nm'	 width=40    align=center editlimit=8 edit=none show=true</C>
				                <C> name='상품명'    		ID='goods_nm'    width=100 align=center editlimit=40 edit=none show=true</C>
				                <C> name='성명'      		ID='cust_nm'     width=70  align=left editlimit=30 edit=none show=true</C>															                
				                <C> name='주민/여권번호'	ID='manage_no'	 width=100	align=left editlimit=20 edit=none show=true</C>
				                <C> name='연락처'   		ID='mobile_no'   width=70   align=left editlimit=12 edit=none show=true</C>
				                <C> name='비고'        		ID='remarks'     width=100  align=left editlimit=120 edit=none show=true</C>
				                <C> name='연령'  			ID='age_cd' 	 align=left editlimit=8 edit=none show=true</C>
				                <C> name='신청서번호'   	ID='accept_no'   WIDTH=100 align=left editlimit=14 edit=none show=true</C>
				                <C> name='판매가'      		ID='use_amt'     width=70 align=right editlimit=12 edit=none show=true decao=0</C>
				                <C> name='조'		     	ID='teams'  	 width=40 align=left editlimit=12 edit=none show=true</C>
				                <C> name='상태'		     	ID='status_cd' 	 width=40 align=left editlimit=12 edit=none show=true</C>
				                <C> name='예약sid'     		ID='rsv_sid'     align=left editlimit=12 edit=none show=true</C>
				                <C> name='고객sid'	     	ID='cust_sid'    align=left editlimit=12 edit=none show=true</C>
				                <C> name='상품sid'    		ID='goods_sid'   align=left editlimit=10 edit=none show=true</C>
				                <C> name='지역sid'    		ID='saup_sid'    align=left editlimit=10 edit=none show=true</C>
				                <C> name='대리점sid'   		ID='client_sid'  align=left editlimit=10 edit=none show=true</C>
				                <C> name='유입경로'    		ID='rsv_way_cd'  width=60 	align=left editlimit=15 edit=none show=false</C>

							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
					<td width="15px">
					</td>					
					<td align="right" valign="top" width="380px">
						<table width="380px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
							<tr>
								<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">성명</td>
								<td  height="25px"  bgcolor="#FFFFFF" align="left">
									<input type="hidden" id="rsv_sid" value="0">																									
									<input type="hidden" id="cust_sid" value="0">&nbsp;
									<input id="cust_nm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;">
								</td>
							</tr>
							<tr>
								<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주민/여권번호</td>
								<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
									<input id="manage_no" type="text" class="textbox"  size="20" value="">
								</td>																									
							</tr>																												
							<tr>
								<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">연령구분</td>
								<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
									<%=HDConstant.COMMENT_START%>
		                            <object id=lc_age classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=CBData			value="1^성인,5^아동">
										<param name=CBDataColumns	value="detail,detail_nm">
										<param name=SearchColumn	value="detail_nm">
										<param name=BindColumn  	value="detail">
										<param name=ListExprFormat  value="detail_nm^0^80">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>																								
							</tr>																												
							<tr>
								<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">연락처</td>
								<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
									<input id="mobile_no" type="text" class="textbox"  style="text-align:left;" value="" size="20">
								</td>																								
							</tr>																												
							<tr>
								<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">비고</td>
								<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
									<input id="remarks" type="text" class="textbox"  style="text-align:left;height:44px"  size="40" value="">
								</td>
							</tr>
							<tr>
								<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">예약상태</td>
								<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
									<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status>
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80">
										<param name=BindColumn  	value="detail">
										<param name=Enable2  value=true>
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>																									
							</tr>
						</table>																						
	
					</td>
				</tr>
			</table>
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
	<param name=BindInfo	value="                                                
	    <C>Col=cust_nm           Ctrl=cust_nm            Param=value </C>
	    <C>Col=manage_no         Ctrl=manage_no          Param=value </C>
	    <C>Col=mobile_no         Ctrl=mobile_no          Param=value </C>
	    <C>Col=remarks           Ctrl=remarks            Param=value </C>

		<C>Col=status_cd         Ctrl=lc_status2           Param=BindColVal </C>
		<C>Col=age_cd    		 Ctrl=lc_age	           Param=BindColVal </C>
	">
</object>
<%=HDConstant.COMMENT_END%>  


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

