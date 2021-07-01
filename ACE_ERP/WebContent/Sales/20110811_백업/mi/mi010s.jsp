<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 관광운영일지
 * 프로그램ID 	 : MI010S
 * J  S  P		 : mi010s
 * 서 블 릿		 : MI010S
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-18 
 * 기능정의		 : 관광운영일지 (조회)
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
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
        cfStyleGrid(getObjectFirst("gr3"), "comn");        
		fnSetHeader();

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
			alert("당일일자를 입력해주세요.");
			return;
		}    
        v_job = "S";
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","        
            + "sBgnDate=" + sBgnDate.text;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_MI%>Mi010S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
            param);
        tr_post(tr1);

    }
	/*
	 * 엑셀
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("관광객인원현황");
		gr2.runexcelsheet("관광객인원현황2");
		gr3.runexcelsheet("숙소이용현황");		
	}	
    </script>	
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);            
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
    	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>	

<%
/*	============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<!--  지역 -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
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
		
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">	
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle onclick="fnSelect()">																			
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  																				
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
					                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_saup>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left width=70 class="text">&nbsp;당일일자</td>
			                                <td align=left bgcolor="#ffffff" valign="middle" width="550">&nbsp;																							
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
					<td width="440px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="440px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
								1.관광객인원현황
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=440px; height:60" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name=ViewHeader  value="false">
										<param name="Format" 			value="
							                <C> name='제목'      ID='mm_name'  width=100   align=center show=true</C>
							                <C> name='인원수'   ID='mm_qty' width=60  align=right value={Number(mm_qty)} show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>		
									<br><br>														
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=440px; height:290" border="1" >
                            			<param name="DataID"		VALUE="ds2">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
							                <C> name='일자'      	ID='depart_date'  	 	width=70   	align=center show=true suppress=1 mask=XXXX-XX-XX </C>
							                <C> name='구분'   		ID='cust_gu' 	  		width=50  	align=center show=true</C>
							                <C> name='2박'        	ID='qty_28'   		value={Number(qty_28)} width=50    align=right show=true</C>
							                <C> name='2박내금'       	ID='qty_50'   		value={Number(qty_50)} width=50    align=right show=true</C>
							                <C> name='2박골프'       	ID='qty_51'   		value={Number(qty_51)} width=50    align=right show=true</C>
							                <C> name='2박승용'       	ID='qty_53'   		value={Number(qty_53)} width=50    align=right show=true</C>
							                <C> name='학생2박'      	ID='qty_32'   		value={Number(qty_32)} width=50    align=right  show=true</C>
							                <C> name='1박'        	ID='qty_27'   		value={Number(qty_27)} width=50    align=right  show=true</C>
							                <C> name='신규1박'     	ID='qty_40'   		value={Number(qty_40)} width=50    align=right  show=true</C>
							                <C> name='학생1박'     	ID='qty_31'   		value={Number(qty_31)} width=50    align=right  show=true</C>
							                <C> name='당일'        	ID='qty_30'   		value={Number(qty_30)} width=50    align=right  show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
								<td width=45>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td align="left" width="370px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
								2.숙소이용현황
									<%=HDConstant.COMMENT_START%>
									<object id=gr3 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=370px; height:360" border="1" >
                            			<param name="DataID"		VALUE="ds3">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
							                <C> name='구분'   	 	ID='upjang_nm' 	width=100  align=left show=true</C>
                                            <G> name='1박'
							                <C> name='인원'      	ID='i_d_qty_11' 	value={Number(i_d_qty_11)} width=50    align=right show=true</C>
							                <C> name='객실'        	ID='h_d_qty_11'    	value={Number(h_d_qty_11)} width=40   align=right show=true</C>
							                </G>
                                            <G> name='2박(1일차)'
							                <C> name='인원'      	ID='i_d_qty_12'  	value={Number(i_d_qty_12)} width=40    align=right show=true</C>
							                <C> name='객실'        	ID='h_d_qty_12'     value={Number(h_d_qty_12)} width=40   align=right show=true</C>
							                </G>
                                            <G> name='2박(2일차)'
							                <C> name='인원'      	ID='i_d_qty_21'  	value={Number(i_d_qty_21)} width=40    align=right show=true</C>
							                <C> name='객실'        	ID='h_d_qty_21'     value={Number(h_d_qty_21)} width=40   align=right show=true</C>
							                </G>															                															                
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

