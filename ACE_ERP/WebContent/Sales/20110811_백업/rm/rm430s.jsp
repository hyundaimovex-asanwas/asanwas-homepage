<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 일자별 상품조회
 * 프로그램ID 	 : RM430S
 * J  S  P		 : rm430s
 * 서 블 릿		 : RM430S
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-06-21
 * 기능정의		 : 일자별 상품조회 (조회)
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

	// 날짜 기본값 설정.
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());		   
	date.set(java.util.Calendar.HOUR_OF_DAY, 744);      
	String lastday = m_today.format(date.getTime());		      
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
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
	/*
	 * 선조회
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=lastday%>';		
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		gr1.TitleHeight = "35";
		
        //상품정보
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds2.Reset(); 		
	}
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sBgnDate.text.trim() == '' || sEndDate.text.trim() == '' ) {
    		alert("출발일자를 입력해 주세요.");
    		return;
   		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sBgnDate=" + sBgnDate.text + ","
            + "sEndDate=" + sEndDate.text + ","                    
            + "sGoodsSid=" + sGoodsSid.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm430S",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
	/*
	 * 상품코드 팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sGoodsSid.value = arrParam[0];
				sGoodsCd.value = arrParam[1];
				sGoodsNm.value = arrParam[2];					
			} else {
		    	sGoodsSid.value = '';
				sGoodsCd.value = '';
				sGoodsNm.value = '';					
			}
	} 				
	/*
	 * 엑셀
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("일자별 상품조회");
	}
	/*
	 * 상품정보 자동셋팅(조건)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {   
		var exit=false;	
		if ( dataSet == 'ds2' ) {	//상품정보
			for ( i=1; i<=ds2.CountRow; i++ ) {
				if ( ds2.namevalue(i,"goods_cd") == sGoodsCd.value ) {
					sGoodsSid.value = ds2.namevalue(i,"goods_sid");
					sGoodsNm.value = ds2.namevalue(i,"goods_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				sGoodsSid.value = '';
				sGoodsNm.value = '';				
			}			
		}		
	} 
			
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
    <script language=JavaScript for=sBgnDate event=OnKillFocus()>
        if( sBgnDate.Modified == true )
			sEndDate.text = sBgnDate.text;
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
            window.status = "조회가 완료 되었습니다.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "조회가 실패하였습니다.";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
</script>

<script language=JavaScript  for=ds2 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 상품정보 -->
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  																															
						            			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
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
			            					<td align=left width=70 class="text">&nbsp;<b>출발일자</b></td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										     <comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;-
										     <comment id="__NSID__"><object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;
											</td>
			            					<td align=left width=70 class="text">&nbsp;상품코드</td>
			                                <td align=left bgcolor="#ffffff" width=500>&nbsp;																										
												<input id="sGoodsSid" type="hidden">                                
												<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" onBlur="fnSetting('ds2')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="근무지역을 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
												<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" readOnly>																						
											</td>
					         			</tr>
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
            	<tr>
            		<td height=10  border="0"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:380px" border="1">
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="
                                           <FC> name=''             ID='{String(CURROW)}'           Width=30    align=center </FC>
							               <C> name='출발일자'  ID='depart_date'        HeadAlign=Center Width=80  align=center edit=none editlimit=8 sort=true show=true mask='XXXX-XX-XX'</C>
							               <C> name='상품명'     ID='goods_nm'   HeadAlign=Center Width=150  align=left edit=none editlimit=50 sort=true show=true</C>
							               <C> name='출발시간'  ID='depart_time'        HeadAlign=Center Width=60  align=center editlimit=4 show=true</C>
							               <C> name='박수'       ID='nights'     HeadAlign=Center Width=30  align=right editlimit=5 show=true</C>
							               <C> name='일수' ID='days'       HeadAlign=Center Width=30  align=right edit=none editlimit=5 show=true</C>
							               <C> name='도착일자'  ID='arrive_date'        HeadAlign=Center Width=70  align=center edit=none editlimit=8 show=true mask='XXXX-XX-XX'</C>
							               <C> name='도착시간'  ID='arrive_time'        HeadAlign=Center Width=60  align=center editlimit=4 show=true</C>
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

