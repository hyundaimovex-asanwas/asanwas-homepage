<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 영업담당정보입력 
 * 프로그램ID 		: SY410I (코드는 대문자)
 * J  S  P			: sy410i (jsp파일명은 소문자로 한다 )
 * 서 블 릿			: Sy410i
 * 작 성 자			: 안준성
 * 작 성 일			: 2006-05-26
 * 기능정의			: 영업담당정보입력 조회, 등록, 삭제, 팝업조회 , 검색 
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
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
			function fnOnLoad(tree_idx){
				fnInit_tree(tree_idx);	//트리초기화 호출
				fnInit();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  선조회
// Parameter 	: 
%>
			function fnInit(){ 
		       		cfStyleGrid(getObjectFirst("gr1"), "comn");			
				ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=1&proType=INIT";
				ds2.Reset();			
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=2&proType=INIT";
				ds3.Reset();							
				ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=S&s_Head=SY012&s_Detail=&s_DetailNm=";
				ds4.Reset();											
				ds5.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=S&s_Head=SY006&s_Detail=&s_DetailNm=";
				ds5.Reset();															
			}
			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function fnSetHeaderDs1(){
				if (ds1.countrow<1){
				var s_temp = "sal_dam_sid:STRING,sal_dam_cd:STRING,sal_dam_nm:STRING,name_gu:STRING,office_tel:STRING,house_tel:STRING,mobile_tel:STRING,etc_tel:STRING,fax_no:STRING,business_gu:STRING,business_gunm:STRING,area_cd:STRING,area_cdnm:STRING,b_email:STRING,msn_email:STRING,etc_email:STRING,bithday:STRING,bithday_gu:STRING,zip_cd:STRING,address1:STRING,address2:STRING,sal_dam_desc:STRING,empno:STRING,empnmk:STRING,deptcd:STRING,deptnm:STRING,use_yn:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [조회]
%>
			function fnSelect() {
				fnSelectDs1();
			}
									
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  분개코드 조회
// Parameter 	: 
%>
			function fnSelectDs1() {
				if (ds1.IsUpdated ) {
					alert("수정중인 행이 있습니다!");
				} else {
					ds1.ClearAll();
					ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?dsType=1&proType=S&sSaldamCd="+sSaldamCd.value+"&sSaldamNm="+sSaldamNm.value;
					ds1.Reset();
				}
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  신규 
// Parameter 	: 
%>
			function fnAddRowDs1() {
					fnSetHeaderDs1();
					ds1.AddRow();
					
					row.value = ds1.RowPosition;
					
					sal_dam_cd.readOnly = false;
					sal_dam_nm.readOnly = false; 
					name_gu.readOnly = false; 	
					office_tel.readOnly = false; 
					house_tel.readOnly = false; 		
					mobile_tel.readOnly = false; 
					etc_tel.readOnly = false; 		
					fax_no.readOnly = false;   	
					b_email.readOnly = false;   	 	
					msn_email.readOnly = false;   	
					etc_email.readOnly = false;   	 	
					bithday.readOnly = false;   	   	
					address2.readOnly = false;   	 		
					sal_dam_desc.readOnly = false;   	 		
					empno.readOnly = false;  					
			}
						
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ]
%>

		function fnApply() {
			fnApplyDs1();
		}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ] 
// 					: 마스터  
%>
			function fnApplyDs1() {
				if(ds1.IsUpdated) {
					for( i=1;i<=ds1.CountRow;i++ ) {				
						if ( ds1.namevalue(i,"sal_dam_nm") == '' ) {
							alert("담당자명은 필수 입력사항입니다.");
							return;
						}
						if ( ds1.namevalue(i,"sal_dam_cd") == '' ) {
							alert("담당자코드는 필수 입력사항입니다.");
							return;
						}						
					}
					tr1.KeyValue = "Sy410I(I:INPUT_DATA=ds1)";
					tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410I?proType=A&dsNum=1";
					tr1.post();
				}
			}		

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  [버튼] 삭제 
//						: 마스터는 삭제시 Commit
%>
			function fnDeleteRowDs1() {			
					ds1.deleterow(ds1.rowposition);
			}
				
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
			function fnCancel(){
				if(ds1.IsUpdated ) {
					ds1.undoall();
				}
				msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
				return;
			}
						
		
<%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
///////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
// Description :  담당업무 팝업                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
		function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrParam[0] = ds4.namevalue(1,"head");
				arrParam[1] = ds4.namevalue(1,"detail_nm"); //공통코드의 마스터값

				arrResult = showModalDialog(strURL,arrParam,strPos);	

				if (arrResult != null) {
					arrParam = arrResult.split(";");
			    	business_gu.value = arrParam[1];
					business_gunm.value = arrParam[2];
				} else {
			    	business_gu.value = "";
					business_gunm.value = "";				
				}
		} 			
		
<%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
///////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
// Description :  근무지역 팝업                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
		function fnPopup2() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrParam[0] = ds5.namevalue(1,"head");
				arrParam[1] = ds5.namevalue(1,"detail_nm"); //공통코드의 마스터값
				arrResult = showModalDialog(strURL,arrParam,strPos);	
			
				if (arrResult != null) {
					arrParam = arrResult.split(";");
			    	area_cd.value = arrParam[1];
					area_cdnm.value = arrParam[2];
				} else {
			    	area_cd.value = "";
					area_cdnm.value = "";				
				}
		} 			
		
<%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
///////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
// Description :  사원정보 팝업                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
%>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
		function fnPopup3() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy020h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				if ( empno.value != '' ) 
					arrParam[0] = empno.value;
				arrResult = showModalDialog(strURL,arrParam,strPos);	
			
				if (arrResult != null) {
					arrParam = arrResult.split(";");
			    	empno.value = arrParam[0];
					empnmk.value = arrParam[1];
			    	deptcd.value = arrParam[2];
					deptnm.value = arrParam[3];					
				} else {
			    	empno.value = "";
					empnmk.value = "";
			    	deptcd.value = "";
					deptnm.value = "";									
				}
		} 					

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  우편번호 팝업
%>
			function fnZipCodePopup(){ 
			
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				
				strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);	
			
				if (arrResult != null) {
					arrParam = arrResult.split(";");
			   		zip_cd.text = arrParam[0];
			   		address1.value = arrParam[1];
			   		
				} else {
				  zip_cd.text = "";
				  address1.value = "";
				}
			}
		/*
		 * 담당업무 자동셋팅(조건)
		 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		function fnSetting(dataSet) {   
			var exit=false;
			if ( dataSet == 'ds4' ) {	//담당업무
				for ( i=1; i<=ds4.CountRow; i++ ) {
					if ( ds4.namevalue(i,"detail") == business_gu.value ) {
						business_gu.value = ds4.namevalue(i,"detail");
						business_gunm.value = ds4.namevalue(i,"detail_nm");
						exit=true;
						return;
					}
				}
				if ( exit != true ) {
					business_gu.value = '';
					business_gunm.value = '';				
				}
			}	
			if ( dataSet == 'ds5' ) {	//근무지역
				for ( i=1; i<=ds5.CountRow; i++ ) {
					if ( ds5.namevalue(i,"detail") == area_cd.value ) {
						area_cd.value = ds5.namevalue(i,"detail");
						area_cdnm.value = ds5.namevalue(i,"detail_nm");
						exit=true;
						return;
					}
				}
				if ( exit != true ) {
					area_cd.value = '';
					area_cdnm.value = '';				
				}
			}				
		} 			
			
		</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>		
<%
////////////////////////////////////////////////////////////////////////////////
//// 영업담당자 정보를 조회한다 
%>	
		<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
				row.value = ds1.RowPosition;
				var index=lc1.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bithday_gu"));
				lc1.index=index;
				index=lc2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"use_yn"));
				lc2.index=index;				
		</script>
		
		<script language=JavaScript for= lc1 event=OnSelChange()>
			ds1.namevalue(ds1.RowPosition, "bithday_gu") = ds2.namevalue(ds2.rowposition, "detail");
		</script>		
		
		<script language=JavaScript for= lc2 event=OnSelChange()>
			ds1.namevalue(ds1.RowPosition, "use_yn") = ds3.namevalue(ds3.rowposition, "detail");		
		</script>				

<%
////////////////////////////////////////////////////////////////////////////////
//// 영업담당자 정보 조회
%>		
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
						
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			
			var index=lc1.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bithday_gu"));
			lc1.index=index;
			index=lc2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"use_yn"));
			lc2.index=index;			
			
			document.all.LowerFrame.style.visibility="hidden";
				sal_dam_cd.readOnly = false;
				sal_dam_nm.readOnly = false; 
				name_gu.readOnly = false; 	
				office_tel.readOnly = false; 
				house_tel.readOnly = false; 		
				mobile_tel.readOnly = false; 
				etc_tel.readOnly = false; 		
				fax_no.readOnly = false;   	
				b_email.readOnly = false;   	 	
				msn_email.readOnly = false;   	
				etc_email.readOnly = false;   	 	
				bithday.readOnly = false;   	   	
				address2.readOnly = false;   	 		
				sal_dam_desc.readOnly = false;   	 		
				empno.readOnly = false;   	 		
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			ds2.insertRow(1);
			ds2.namevalue(1,"detail_nm") = "";
			lc1.index = 0;			
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			ds3.insertRow(1);
			ds3.namevalue(1,"detail_nm") = "";
			lc2.index = 0;			
		</script>		
		
		<script language=JavaScript  for=ds5 event="OnLoadCompleted(row,colid)">
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>		
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds4" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds5" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

		
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName" value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="30px">
		<td>
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelect()">
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:pointer;position:relative;left:3px;top:3px"  onClick="fnAddRowDs1()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer;position:relative;left:3px;top:3px"  onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnDeleteRowDs1()" >																																								
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
					<td  width="500px">
						<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
							<tr  bgcolor="#6f7f8d" height="30px" >
								<td width="90px" class="text"> 담당자명 </td>
								<td bgcolor="#ffffff" width="200px">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
										<tr>
											<td width="150px" align="center"  bgcolor="#FFFFFF">
												<input height="22px" type="text" name="sSaldamNm" value="" size="20" class="textbox">
											</td>	
										</tr>
									</table>
								</td>
								<td width="90px" class="text"> 담당자코드 </td>
								<td bgcolor="#ffffff" width="200px">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
										<tr>
											<td width="150px" align="center"  bgcolor="#FFFFFF">
												<input height="22px" type="text" name="sSaldamCd" value="" size="20" class="textbox">
											</td>	
										</tr>
									</table>
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
					<td align="left" width="255px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=235px; height:390" border="1" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name="Format" 			value="
								<C> name='담당자SID' 		ID='sal_dam_sid' 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>
								<C> name='담당자명'  		ID='sal_dam_nm'   	HeadAlign=Center Width=100 align=left editlimit=22 sort=true</C>	
								<C> name='담당자사번' 	ID='sal_dam_cd' 		HeadAlign=Center Width=100  align=center editlimit=7 sort=true</C>
								<C> name='동명이인구분' 	ID='name_gu' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=22 show=false</C>
								<C> name='회사전화'  		ID='office_tel'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=20 show=false</C>											
								<C> name='자택전화' 		ID='house_tel' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20 show=false</C>
								<C> name='휴대전화'  		ID='mobile_tel'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=20 show=false</C>											
								<C> name='기타전화' 		ID='etc_tel' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20 show=false</C>
								<C> name='팩스번호'  		ID='fax_no'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=20 show=false</C>											
								<C> name='담당업무' 		ID='business_gu' 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=10 show=false</C>
								<C> name='담당업무명' 		ID='business_gunm' 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20 show=false</C>
								<C> name='근무지역'  		ID='area_cd'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=2 show=false</C>											
								<C> name='근무지역명'  		ID='area_cdnm'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=2 show=false</C>																														
								<C> name='기본메일주소' 	ID='b_email' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=30 show=false</C>
								<C> name='MSN메일주소'  		ID='msn_email'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=30 show=false</C>											
								<C> name='네이트메일주소' 	ID='etc_email' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=30 show=false</C>
								<C> name='생년월일'  		ID='bithday'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=8 show=false</C>											
								<C> name='음력양력구분' 	ID='bithday_gu' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=1 show=false</C>
								<C> name='우편번호'  		ID='zip_cd'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=left editlimit=6 show=false</C>																																																																																																																																																																					
								<C> name='주소1' 			ID='address1' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=60 show=false</C>
								<C> name='주소2' 			ID='address2' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=60 show=false</C>
								<C> name='비고사항' 		ID='sal_dam_desc' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=60 show=false</C>
								<C> name='사원번호' 		ID='empno' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=7 show=false</C>
								<C> name='사원명' 			ID='empnmk' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20 show=false</C>																			
								<C> name='부서코드' 		ID='deptcd' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=7 show=false</C>
								<C> name='부서명' 			ID='deptnm' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20 show=false</C>																			
								<C> name='사용유무' 		ID='use_yn' 				 	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=1 show=false</C>																			
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
					<td width="25px">
					</td>					
					<td align="left" valign="top" width="585px">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="585px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="boardt02">담당자사번</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="sal_dam_cd" type="text" class="textbox"  readonly="false" size="20" value="" maxlength="7" onBlur="bytelength(this,this.value,7);">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="boardt02">담당자명</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="sal_dam_nm" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="22" onBlur="bytelength(this,this.value,22);">
														</td>																									
													</tr>
													<tr>
														<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="2">&nbsp;
														</td>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">동명이인구분</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="name_gu" type="text" class="textbox"   readonly="true" value="" size="20" maxlength="22" onBlur="bytelength(this,this.value,22);">
														</td>																									
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">회사전화</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="office_tel" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">자택전화</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="house_tel" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">휴대전화</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_tel" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">기타전화</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="etc_tel" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">팩스번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="fax_no" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="20" onBlur="bytelength(this,this.value,20);">
														</td>
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">담당업무</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="business_gu" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:20px; height:20px;" maxlength="2" onBlur="fnSetting('ds4')">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="담당업무를 검색합니다" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
															<input id="business_gunm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black;" maxlength="50" onBlur="bytelength(this,this.value,50);" readOnly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">근무지역</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="area_cd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:20px; height:20px;" maxlength="2" onBlur="fnSetting('ds5')">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="근무지역을 검색합니다" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2();">
															<input id="area_cdnm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" readOnly>																						
														</td>																									
													</tr>																																																																																																			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">기본메일주소</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="b_email" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="30" onBlur="bytelength(this,this.value,30);">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">msn메일주소</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="msn_email" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="30" onBlur="bytelength(this,this.value,30);">
														</td>																									
													</tr>																																																																																																																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">네이트메일주소</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="etc_email" type="text" class="textbox"  readonly="true" size="20" value="" maxlength="30" onBlur="bytelength(this,this.value,30);">
														</td>
													</tr>																																																																																																																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">생년월일</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<comment id="__NSID__"><object id=bithday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=SelectAll  	value="true">
																<param name=SelectAllOnClick  	value="true">																																																
																<param name=SelectAllOnClickAny  	value="false">																																																																											
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;&nbsp;&nbsp;																																																					
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">음력 양력구분</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
							 								<comment id="__NSID__"><object id=lc1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=150 align=absmiddle>
																<param name=ComboDataID		value=ds2>
																<param name=EditExprFormat	value="%;bithday_gu">
																<param name=ListExprFormat  value="detail_nm^0^100">
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>																																	
														</td>																									
													</tr>																																																																																																																																																																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">우편번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<comment id="__NSID__"><object id=zip_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=60 onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="000-000">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">			
																<param name=InheritColor      value="true">																																																																																																																																		
																<param name=ReadOnly  	value="false">
																<param name=SelectAll  	value="true">
																<param name=SelectAllOnClick  	value="true">																																																
																<param name=SelectAllOnClickAny  	value="false">																																																																																																						
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="우편번호를 검색합니다" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnZipCodePopup();">																																																			
														</td>
													</tr>																																																																																																																																																																																																				
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주소1</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id=address1 type="text" class="textbox"  readonly="true" size="30" value="" maxlength="60" onBlur="bytelength(this,this.value,60);" readOnly>
														</td>
													</tr>																																																																																																																																																																																																				
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주소2</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="address2" type="text" class="textbox"  readonly="true" size="50" value="" maxlength="60" onBlur="bytelength(this,this.value,60);">
														</td>
													</tr>																																																																																																																																																																																																				
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">비고사항</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="sal_dam_desc" type="text" class="textbox"  readonly="true" size="60" value="" maxlength="60" onBlur="bytelength(this,this.value,60);">
														</td>
													</tr>			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">사원번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="empno" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,7);">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="사원번호를 검색합니다" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnPopup3();">
															<input id="empnmk" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:70px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" readOnly>																																															
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">부서코드</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="deptcd" type="text" class="boardt04"  readonly="true" size="4" value="" maxlength="4" onBlur="bytelength(this,this.value,4);">
															<input id="deptnm" type="text" class="boardt04"  readonly="true" size="20" value="" maxlength="50" onBlur="bytelength(this,this.value,50);">																										
														</td>																									
													</tr>			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">사용유무</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
							 								<comment id="__NSID__"><object id=lc2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=150 align=absmiddle>
																<param name=ComboDataID		value=ds3>
																<param name=EditExprFormat	value="%;use_yn">
																<param name=ListExprFormat  value="detail_nm^0^100">
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>																																																										
														</td>
													</tr>																																																																																																																																																																																																																																																																																																																																																																													
												</table>																						
											</td>
										</tr>
									</table>
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
		<C>Col=sal_dam_cd 		Ctrl=sal_dam_cd 		Param=value </C>
		<C>Col=sal_dam_nm    	Ctrl=sal_dam_nm      			Param=value </C>     
		<C>Col=name_gu 			Ctrl=name_gu 				Param=value </C>     
		<C>Col=office_tel      		Ctrl=office_tel      			Param=value </C>     
		<C>Col=house_tel 			Ctrl=house_tel 			Param=value </C>     
		<C>Col=mobile_tel      		Ctrl=mobile_tel      			Param=value </C>     
		<C>Col=etc_tel 					Ctrl=etc_tel 				Param=value </C>     
		<C>Col=fax_no   				Ctrl=fax_no   			Param=value </C>     
		<C>Col=business_gu 		Ctrl=business_gu 			Param=value </C>     
		<C>Col=business_gunm 	Ctrl=business_gunm 			Param=value </C>     		
		<C>Col=area_cd   			Ctrl=area_cd   			Param=value </C>     
		<C>Col=area_cdnm   		Ctrl=area_cdnm   			Param=value </C>     		
		<C>Col=b_email 				Ctrl=b_email 				Param=value </C>     
		<C>Col=msn_email       	Ctrl=msn_email       			Param=value </C>
		<C>Col=etc_email 			Ctrl=etc_email 		    Param=value </C>
		<C>Col=bithday   				Ctrl=bithday   		Param=text </C>
		<C>Col=bithday_gu      		Ctrl=bithday_gu      			Param=value </C>     
		<C>Col=zip_cd   				Ctrl=zip_cd   			Param=text </C>     
		<C>Col=address1 			Ctrl=address1 			Param=value </C>     
		<C>Col=address2 			Ctrl=address2 			Param=value </C>     
		<C>Col=sal_dam_desc 					Ctrl=sal_dam_desc 				Param=value </C>     
		<C>Col=empno 				Ctrl=empno 				Param=value </C>     
		<C>Col=empnmk 				Ctrl=empnmk 				Param=value </C>     		
		<C>Col=deptcd 				Ctrl=deptcd 				Param=value </C>
		<C>Col=deptnm 				Ctrl=deptnm 				Param=value </C>"		
	>
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

