<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 출경현황 조회
 * 프로그램ID 	 : CQ581S
 * J  S  P		 : cq581s
 * 서 블 릿		 : CQ581S
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2008-12-08 
 * 기능정의		 : 실입력, 취소, 운영마감, 출경, 노쇼 등 전체 세부현황 조회
 * [ 수정일자 ][수정자] 내용
 * [2008-12-08][심동현] 신규 메뉴 추가.
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

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
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
        var div='';
	/*
	 * 페이지로딩
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			fnInit();
		}
	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader(){
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
		div='init';	        
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
                      
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		sBgnDate.text='<%=firstday%>';

        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sBgnDate.text.trim() == '' ) {
			alert("출경일자를 입력해주세요.");
			return;
		}    
        v_job = "S";
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","        
            + "sBgnDate=" + sBgnDate.text + ","
 			+ "sGoodsSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index);

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq581S",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);

    }
	
	/*
	 * 엑셀
	 */
	function fnExcel() {
		if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:출경현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("출경현황","출경현황.xls", 8);
	}


	//상품조회
	function fnSelectGoodsLC() {
        window.status="조회 중입니다. 잠시만 기다려 주십시오...";	
        var param = "proType=INIT,dsType=1"
            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			+ ",sDepartDate=" + sBgnDate.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=ds_goods)",
            param);
        tr_post(tr2);
	};
	
    </script>	
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( sBgnDate.Modified ) {
			fnSelectGoodsLC();			
		}				
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
			fnSelectGoodsLC();
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
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>


<%
/*	============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
	<param name=SubsumExpr	value="Total,2:cust_gu_nm,1:class_nm">
</object>
<!--  지역 -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>	<%// 상품정보 %>
    <param name="SyncLoad"  value=false>
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
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

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">	
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcel()">  																				
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
		                            <tr bgcolor="#6f7f8d">
		            					<td align=left width=70 class="text">&nbsp;사업소</td>
		                                <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
			                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_saup>
											<param name=BindColumn      value="saup_sid">
		                                    <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^80"></object>
										<%=HDConstant.COMMENT_END%>
										</td>	
		            					<td align=left width=70 class="text">&nbsp;출경일자</td>
		                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
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
											<%=HDConstant.COMMENT_END%>
										</td>																				
										<td align=left class="text" width="60">상품정보</td>
					                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
					                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
												<param name=ComboDataID		value=ds_goods>
												<param name=BindColumn      value="goods_sid">
					                            <param name=BindColVal      value="goods_sid">
												<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
												<param name=ListExprFormat  value="goods_nm^0^120"></object>
											<%=HDConstant.COMMENT_END%>&nbsp;	
										</td>
			            			</tr>	
			            		</table>
							</td>
						  </tr>															
						</table>	
					</td>											
				</tr>												
				<tr height="10">
					<td></td>
				</tr>		
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
								<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
							                <C> name='출발일자'    	ID='depart_date'	width=80  align=center editlimit=11 show=true suppress=4 SubBgColor=LightBeige</C>
							                <C> name='상품'    		ID='goods_nm'   	width=100 align=center editlimit=11 show=true suppress=3 SubBgColor=LightBeige</C>
							                <C> name='고객구분'    	ID='cust_gu_nm'   	width=80  align=center editlimit=11 show=true suppress=2 SubBgColor=LightBeige</C>
							                <C> name='반'   		ID='class_nm' 		width=60  align=center show=true suppress=1 SubBgColor=LightBeige</C>
							                <C> name='조'        	ID='teams'   		width=60  align=center show=true SubBgColor=LightBeige</C>
							                <C> name='실입력'    	ID='cnt_input' 		width=70  align=right  decao=0 show=False SubBgColor=LightBeige</C>
											<C> name='입력후취소'	ID='cnt_n_rc'	  	width=70  align=right  decao=0 show=False SubBgColor=LightBeige</C>
											<C> name='총 인 원\\(운영마감)' ID='cnt_y'	width=80  align=right  decao=0 show=true SubBgColor=LightBeige</C>
											<C> name='마감후취소'	ID='cnt_y_rc' 		width=80  align=right  decao=0 show=true SubBgColor=LightBeige</C>
											<C> name='출 경'	   	ID='cnt_y_dp' 		width=80  align=right  decao=0 show=true SubColor=Blue SubBgColor=LightBeige</C>
											<C> name='No Show'	   	ID='cnt_y_ns'		width=80  align=right  decao=0 show=true SubColor=Red SubBgColor=LightBeige</C>
											<C> name='입 경'	   	ID='cnt_y_ar' 		width=80  align=right  decao=0 show=False SubColor=Blue SubBgColor=LightBeige</C>
										">
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


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


