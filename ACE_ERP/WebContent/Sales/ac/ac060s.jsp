<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 가수금 정리현황
 * 프로그램ID 	: AC060S
 * J  S  P		: ac060s
 * 서 블 릿		: Ac060S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-03
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
         var v_default_row = 1;
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			sSDate.Text = '<%=firstday%>';	
			sEDate.Text = '<%=firstday%>';	
			fnInit();
			fnInit2();
		} 
		 
		function fnInit() {
			div = 'init';
            codeDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC001&s_item1=Y";
            codeDs3.Reset();
            
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드
		}
		
			/*
		 * Description : 초기화
		 * 고객구분
		 */
		function fnInit2(){
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
	            "JSP(O:CUSTALL=codeDs4)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr2);
		}
				
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			if(lc3.ValueOfIndex("detail", lc3.Index)==""){
				alert('입금형태를 선택해 주세요!');
				return;
			}
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
		              + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
                      + ",sPay_cd=" + lc3.ValueOfIndex("detail", lc3.Index)
                         + ",v_out_gubn="+ v_out_gubn.value
                          + ",sCustGu=" + sCustGu.ValueOfIndex("detail", sCustGu.Index);
                      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac060S",
			    "JSP(O:DS1=ds1,O:DS2=ds2)",
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
            getObjectFirst("gr2").SetExcelTitle(0, "");
            getObjectFirst("gr2").SetExcelTitle(1, "value:형태별입금현황 (상세); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr2").GridToExcel("형태별입금현황 (상세)","형태별입금현황.xls", 32);
            
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:형태별입금현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("형태별입금현황","형태별입금현황.xls", 32);
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

    <script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

    <script language="javascript" for="tr2" event="onsuccess()">
        window.status="작업이 성공적으로 완료되었습니다.";
    </script>   

    <script language="javascript" for="tr2" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

   

   
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 상세  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  입금형태 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  입금형태 -->
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

	
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px' align=right>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
				<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- 엑셀 -->
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='25'>
                        <td class="text" width="60px">지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_saup>
                                <param name=ListExprFormat  value="saup_nm^0^100">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>   
						<td class="text" width="70">상품정보</td>
	                    <td align=left bgcolor="#ffffff" >&nbsp;<%=HDConstant.COMMENT_START%>
	                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=ListExprFormat  value="goods_nm^0^150">
                            </object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="60px" class="text" >대리점</td>
						<td align="left"  bgcolor="#ffffff">&nbsp;
                            <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='input01'>
                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
						</td>
                    </tr>
                    <tr height=25>
						<td class="text"  width="60">입금일자</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
							</object>~
	                       	<object id=sEDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">	
								<param name=SelectAllOnClickAny   value="false">
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
                        <td class="text" width="60px"> 입금형태</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=codeDs3>
                                <param name=ListExprFormat  value="detail_nm^0^100">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td> 
						 <td align=left class="text" width='100'>출경/고객구분</td>
                            <td align=left bgcolor="#ffffff" valign="middle" colspan=5>&nbsp;
                                <select name="v_out_gubn" id="v_out_gubn" class="textbox">
                                    <option value="">전체
                                    <option value="Y">출경
                                    <option value="N">미출경
                                </select>&nbsp;
								<%=HDConstant.COMMENT_START%>
								<object id=sCustGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
									<param name=ComboDataID		value=codeDs4>
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
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:180; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="입금내역"</T>
											<T>divid="mxTab_page2"	title="환불내역"</T>
											'>
									</object>
									<%=HDConstant.COMMENT_END%>	
									<div class=page id="mxTab_page1" style="position:absolute; left:170; top:200; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >

	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name="SuppressOption"    value="1">
										<param name="Format" 			value="
											<C> name='입금자'			ID='U_EMPNO'  		width=60   	align=left editlimit=50 show=true </C>		
											<C> name='입금은행'			ID='BANK_NM'  		width=60   	align=left editlimit=50 show=true </C>		
											<C> name='입금일'			ID='PAY_DATE'  		width=80   	align=center editlimit=50 show=true mask='XXXX-XX-XX'</C>		
											<C> name='총 입금액'		ID='TOT_PAY_AMT'  	width=100   	align=right editlimit=50 show=true dec=0</C>		
											<C> name='출발일자'			ID='DEPART_DATE'  	width=80   	align=center editlimit=50 show=true mask='XXXX-XX-XX'</C>		
											<C> name='상품'				ID='GOODS_NM'  		width=100   	align=left editlimit=50 show=true dec=0</C>		
											<C> name='입금액'			ID='PAY_AMT'  		width=100   	align=right editlimit=50 show=true dec=0</C>
											<C> name='카드번호'			ID='CARD_NO'  		width=120   	align=left editlimit=50 show=true dec=0</C>
											<C> name='승인번호'			ID='AGREE_NO'  		width=100   	align=left editlimit=50 show=true dec=0</C>		

										">
									</object>
									<%=HDConstant.COMMENT_END%>
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:170; top:200; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
											<C> name='입금자'			ID='U_EMPNO'  		width=60   	align=left editlimit=50 show=true </C>		
											<C> name='입금은행'			ID='BANK_NM'  		width=60   	align=left editlimit=50 show=true </C>		
											<C> name='입금일'			ID='PAY_DATE'  		width=100   	align=center editlimit=50 show=true mask='XXXX-XX-XX'</C>		
											<C> name='입금액'			ID='PAY_AMT'  		width=100   	align=right editlimit=50 show=true dec=0</C>		
											<C> name='환불일'			ID='REFUND_DATE'  		width=100   	align=center editlimit=50 show=true mask='XXXX-XX-XX'</C>		
											<C> name='환불액'			ID='REFUND_AMT'  		width=100   	align=right editlimit=50 show=true dec=0</C>		
											<C> name='환입액'			ID='FUND_AMT'  		width=100   	align=right editlimit=50 show=true dec=0</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
									</div>
									
							</td>
						</tr>
						</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td>

			</td>
		</tr>


	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

