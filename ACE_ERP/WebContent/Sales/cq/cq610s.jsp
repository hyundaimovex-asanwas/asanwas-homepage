<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 체류현황
 * 프로그램ID 	: AC020S
 * J  S  P		: ac020s
 * 서 블 릿		: Ac020S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-08-07
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-08-17][심동현] 그리드 및 쿼리 전면 수정
 * [2009-08-21][심동현] 2009-08-18 출입부터 관리 시작. 그리드 수정.
 * [2015-10-06][심동현] 체류 → 입경 의 tcq010상태값을 DP,AR 모두로 수정
 * [2015-10-07][심동현] 차량 추가^^
 * [2015-10-08][심동현] 차량상세 추가^^ 
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
		
		
		var Tabvalue = 1;		
		
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
		
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn1");
		cfStyleGrid(getObjectFirst("gr3"), "comn");
		cfStyleGrid(getObjectFirst("gr4"), "comn");
		
		sJobDate.text='<%=firstday%>';
                  
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";
		codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		codeDs1.Reset(); //지역코드 

        ds_dp_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_item1=Y";
        ds_dp_time.Reset();	//출경시각
        ds_ar_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
        ds_ar_time.Reset();	//입경시각

		
		// 사업소, 고객구분
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=codeDs2)", 
            param);
            
        tr_post(tr1);		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( sJobDate.text.trim() == '' ) {
			alert("입경일자 입력해주세요.");
			return;
		}    

        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaup_sid=" +codeDs1.namevalue(codeDs1.rowposition,"saup_sid") + ","        
            + "sJobDate=" + sJobDate.text + ","
            + "sCustGu=" + codeDs2.namevalue(codeDs2.rowposition,"detail") + ","
            + "sManageNo=" +  sManageNo.value + ","
            + "sName=" + sName.value;
            
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq610S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3,O:DS4=ds4)",
            param);
        tr_post(tr1);

    }
 	
	
	
  	function fnExcel() {
  		
  		
            if(ds1.CountRow==0 && ds2.CountRow==0 && ds3.CountRow ==0 && ds4.CountRow ==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            
	        if(Tabvalue  == 1){
            
	            getObjectFirst("gr1").SetExcelTitle(0, "");
	            getObjectFirst("gr1").SetExcelTitle(1, "value:체류인원총괄; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	            getObjectFirst("gr1").GridToExcel("체류인원총괄", "체류인원총괄.xls", 32);        

	        }else if(Tabvalue  == 2){
            
	            getObjectFirst("gr2").SetExcelTitle(0, "");
	            getObjectFirst("gr2").SetExcelTitle(1, "value:체류인원상세; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	            getObjectFirst("gr2").GridToExcel("체류인원상세", "체류인원상세.xls", 32);   

	        }else if(Tabvalue  == 3){
            
	            getObjectFirst("gr3").SetExcelTitle(0, "");
	            getObjectFirst("gr3").SetExcelTitle(1, "value:체류차량총괄; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	            getObjectFirst("gr3").GridToExcel("체류차량총괄", "체류차량총괄.xls", 32);        

	        }else if(Tabvalue  == 4){	
            
	            getObjectFirst("gr4").SetExcelTitle(0, "");
	            getObjectFirst("gr4").SetExcelTitle(1, "value:체류차량상세; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	            getObjectFirst("gr4").GridToExcel("체류차량상세", "체류차량상세.xls", 32);   
	            
	        }
            
        }
  	
</script>
		
		
		
		
<script language=JavaScript for=mxTab event=OnSelChanged(index)>

			if(index == '1'){

				Tabvalue = 1;
			
			}else if(index == '2'){
					
				Tabvalue = 2;

			}else if(index == '3'){
				
				Tabvalue = 3;
			
			}else if(index == '4'){
				  
				Tabvalue = 4;
			
			}

</script>


		
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
	</script>	
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_dp_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 출경시각 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입경시각 -->
    <param name="SyncLoad"  value="True">
</object>

<!--  사업소 -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!-- 고객구분 -->
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>



</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='1002'>	
		<tr height="30px">
			<td bgcolor="#ffffff" width='1002px' align='right'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
				<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcel()">		<!-- 엑셀 -->
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr height="30px">
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='1002' bgcolor="#666666">
					<tr height="30px">
						<td align=left width=70 class="text">&nbsp;지역</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
								
                            <object id=sSaupSid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=BindColumn      value="saup_sid">
                                <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120"></object>
							
						</td>	
    					<td align=left width=70 class="text">작업일자</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	
					     	<object id=sJobDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
							&nbsp;
						</td>		
						<td  align=left width=70 class="text">고객구분</td>
						<td align=left bgcolor="#ffffff" valign="middle">&nbsp;				
							
                            <object id=sCustGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs2>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%;detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
																
						</td>
						<td align=left width=100 class="text">주민등록번호</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
							<input type="text" name="sManageNo" value="" size='13' maxlength="13" class="textbox">
						</td>	
    					<td align=left width=40 class="text">성명</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	<input type="text" name="sName" value="" size='10' maxlength="10" class="textbox">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
				
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" height=410 border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:13; top:190; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="인원 총괄"</T>
											<T>divid="mxTab_page2"	title="인원 상세"</T>																		
											<T>divid="mxTab_page3"	title="차량 총괄"</T>
											<T>divid="mxTab_page4"	title="차량 상세"</T>
										'>
									</object>
										
									<div class=page id="mxTab_page1" style="position:absolute; left:13; top:210; width:1002; height:300">
									
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width:1000px; height:360" border="1" >
									
	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name=ViewSummary 	value=1>
										<param name="Format" 			value="
											<FC> name='출 경'	ID='CNT1'		width=70 align=right editlimit=50 show=true sumtext=@sum</FC>        
											<FC> name='주 간'	ID='CNT2'		width=70 align=right editlimit=50 show=true sumtext=@sum</FC>
											<FC> name='입 경'	ID='CNT3'		width=70 align=right editlimit=50 show=true sumtext=@sum</FC>
											<FC> name='야 간'	ID='CNT4'		width=70 align=right editlimit=50 show=true sumtext=@sum</FC>

											<C> name='구분'			ID='CUST_GU'		width=80 align=left editlimit=50 show=true suppress=1 </C>        
											<C> name='사업구분'		ID='GUBN'			width=100 align=left editlimit=50 show=true suppress=2 </C>        
											<C> name='총계'			ID='CNT_TOTAL'			width=70 align=right editlimit=50 show=false sumtext=@sum</C>
										<G> name='출경→체류'
											<C> name='내국인'		ID='CNT_GO_KR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>        
											<C> name='외국인'		ID='CNT_GO_FR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										<G> name='체류→체류'
											<C> name='내국인'		ID='CNT_STAY_KR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='외국인'		ID='CNT_STAY_FR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										<G> name='체류→입경'
											<C> name='내국인'		ID='CNT_COME_KR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='외국인'		ID='CNT_COME_FR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										<G> name='출경→입경'
											<C> name='내국인'		ID='CNT_TODAY_KR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='외국인'		ID='CNT_TODAY_FR'			width=60 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										">
									</object>
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:13; top:210; width:1002; height:300">
									
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width:1000px; height:360; " border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name=ViewSummary 	value=1>
										<param name="Format" 		value="
							            <C> name='구분'			ID='DIRECTION'     	width=100 align=center editlimit=50 show=true suppress=1 sort=true </C>
							            <C> name='고객구분'		ID='CUST_GU'       	width=60 align=center editlimit=50 show=true suppress=2 </C>
										<C> name='사업구분'		ID='SAUP_GU' 		width=60 align=center editlimit=50 show=true suppress=3 </C>
										<C> name='국적구분' 	ID='COUNTRY_GU'    	width=60 align=center editlimit=50 show=true suppress=4 sumtext='총 인원'</C>
										<C> name='성명' 		ID='CUST_NM' 		width=80 align=left editlimit=50 show=true sumtext=@cnt sort=true </C>
										<C> name='반' 			ID='CLASS' 			width=60 align=left editlimit=50 show=true </C>
										<C> name='조' 			ID='TEAMS' 			width=40 align=left editlimit=50 show=true</C>
										<C> name='주민등록번호'	ID='MANAGE_NO' 		width=100 align=left editlimit=50 show=true </C>        
										<C> name='성별'			ID='SEX' 			width=40 align=center editlimit=50 show=true </C>        
										<C> name='국적' 		ID='COUNTRY_NM'		width=60 align=center editlimit=50 show=true </C>        
										<C> name='민족' 		ID='NATION_MM' 		width=60 align=center editlimit=50 show=true </C>        
										<C> name='직장' 		ID='COMPANY_NM'		width=90 align=left editlimit=50 show=true sort=true </C>        
										<C> name='직위' 		ID='POSITIONS' 		width=90 align=left editlimit=50 show=true </C>        
										<C> name='방북목적'		ID='north_purpose'	width=110 align=left editlimit=62 show=true</C>
										<C> name='출경일자'		ID='DEPART_DATE' 	width=80 align=center editlimit=50 show=true mask='XXXX-XX-XX'</C>
										<C> name='출경시간'		ID='DEPART_TIME' 	width=60 align=center editlimit=50 show=true  mask='XX:XX'</C>        
										<C> name='입경일자'		ID='ARRIVE_DATE' 	width=80 align=center editlimit=50 show=true  mask='XXXX-XX-XX'</C>
										<C> name='입경시간'		ID='ARRIVE_TIME' 	width=60 align=center editlimit=50 show=true  mask='XX:XX'</C>        
										<C> name='상품' 		ID='GOODS_NM'     	width=100 align=left editlimit=50 show=true </C>        
										<C> name='객실등급' 	ID='ROOM_TYPE_CD'	width=70 align=left editlimit=50 show=true </C>        
										<C> name='방번호'		ID='ROOM_NO' 		width=100 align=left editlimit=50 show=false </C>        										                
										">
									</object>
									</div>

									<div class=page id="mxTab_page3" style="position:absolute; left:13; top:210; width:1002; height:300">
									<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width:1000px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds3">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name=ViewSummary 	value=1>
										<param name="Format" 			value="
											<FC> name='출 경'	ID='CNT1'		width=100 align=right editlimit=50 show=true sumtext=@sum</FC>        
											<FC> name='주 간'	ID='CNT2'		width=100 align=right editlimit=50 show=true sumtext=@sum</FC>
											<FC> name='입 경'	ID='CNT3'		width=100 align=right editlimit=50 show=true sumtext=@sum</FC>
											<FC> name='야 간'	ID='CNT4'		width=100 align=right editlimit=50 show=true sumtext=@sum</FC>

											<C> name='1.출경→체류'	ID='CNT_GO'			width=100 align=right editlimit=50 show=true sumtext=@sum</C>        
											<C> name='2.체류→체류'	ID='CNT_STAY'		width=100 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='3.체류→입경'	ID='CNT_COME'		width=100 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='4.출경→입경'	ID='CNT_TODAY'		width=100 align=right editlimit=50 show=true sumtext=@sum</C>
										">
									</object>
									</div>

									<div class=page id="mxTab_page4" style="position:absolute; left:13; top:210; width:1002; height:300">
									
									<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width:1000px; height:360; " border="1" >
	                        			<param name="DataID"		VALUE="ds4">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name=ViewSummary 	value=1>
										<param name="Format" 		value="
								            <C> name='구분'				ID='DIRECTION'     	width=100 align=center editlimit=50 show=true suppress=1 sort=true </C>
										  <G> name='협력사'
											<C> name='코드'				ID='CLIENT_CD'		width=50 align=center Edit=None suppress=1 sumtext=@CNT </C>
											<C> name='이름'				ID='CLIENT_NM'		width=80 align=left Edit=None suppress=1 sumtext='대' SumTextAlign=left sort=true</C>
										  </G>
										  <G> name='출국예정'
											<C> name='일자'				ID='DEPART_DATE'	width=60 align=center Edit=None </C>
											<C> name='시각'				ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm' </C>
											<C> name='운전자'			ID='DP_DRIVER'		width=60 align=center Edit=None </C>
										  </G>
										  <G> name='입국예정'
											<C> name='일자'				ID='ARRIVE_DATE'	width=60 align=center Edit=None</C>
											<C> name='시각'				ID='ARRIVE_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_ar_time:detail:detail_nm' </C>
											<C> name='운전자'			ID='AR_DRIVER'		width=60 align=center Edit=None </C>
										  </G>
										    <C> name='소속'       		ID='tt_client_nm'   align=left	width=80 	show=true   sort=true </C>
							                <C> name='차량SID'      	ID='car_sid'    	align=left width=100 	show=false</C>
											<C> name='차명'       		ID='car_nm'      	align=center width=100 	show=true  	</C>
											<C> name='차량\\등록번호'	ID='CAR_NO'	  		align=center Width=80   Edit=None 	sort=false</C>
											<C> name='차종' 			ID='CAR_TYPE' 	  	align=left Width=70   	Edit=None</C>
										">
									</object>
									</div>
									</td>		
								</tr>
								<tr height="10px">
									<td></td>
								</tr>
								<tr>
								
									<td>-. 작업일자의 체류 인원 / 차량 = [출경→체류] + [체류→체류]<BR>
										-. 작업일자의 출경 인원 / 차량 = [출경→체류] + [출경→입경]<BR>
										-. 작업일자의 입경 인원 / 차량 = [체류→입경] + [출경→입경]<BR><BR>

										※ 정확한 체류현황 수치를 위해서<BR>
										　1. <b>출입관리>입경자 관리>미입경자 확인</b>, <b>출입관리>입경자 관리>미입경차량 확인</b>을 정확히 완료하여야 합니다.<BR>
										　2. 입경 N/S인원 및 차량은 입경일자를 다음 입경예정일자로 다시 수정하여야 합니다. 
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

