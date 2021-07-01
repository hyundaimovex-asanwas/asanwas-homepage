<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 객실정보
 * 프로그램ID 	 : RM040I
 * J  S  P		 : rm040i
 * 서 블 릿		 : RM040I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-06-20
 * 기능정의		 : 객실정보 (조회, 저장, 취소)
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
		if (ds1.countrow < 1){
			var s_temp1 = "UPJANG_SID:INT,UPJANG_NM:STRING,DONG_SID:INT,ROOM_TYPE_SID:INT,ROOM_SID:INT,ROOM_TYPE_CD:STRING,ROOM_NO:STRING,BGN_DATE:STRING,END_DATE:STRING,ROOM_VIEW_CD:STRING,ROOM_VIEW_NM:STRING,FLOORS:STRING,USE_YN:STRING,REMARKS:STRING";
			ds1.SetDataHeader(s_temp1);
		}	
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
        div='init';
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>";        		
        
        ds_use.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY011&s_Item1=Y";
        ds_use.Reset();         
	
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds2.Reset(); //지역코드
	
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040I",
            "JSP(O:DS5=ds5,O:DS_DONG=ds_dong)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1); 		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {    
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sUpjangSid=" + ds3.namevalue(ds3.rowposition,"upjang_sid") + ","
	            + "sRoomTypeSid=" + ds4.namevalue(ds4.rowposition,"room_type_sid");
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040I",
	            "JSP(O:DEFAULT=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * 영업장조회
	 */
    function fnSelectDS3() {
        v_job = "H";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040I",
            "JSP(O:DS3=ds3)",
            param);
        tr_post(tr2);;
    }   
	/*
	 * 동정보, 객실타입 조회
	 */		
	function fnSelectDS4() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
            + "sUpjangSid=" + ds3.namevalue(ds3.rowposition,"upjang_sid");
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040I",
            "JSP(O:DS_DONG=ds_dong,O:DS4=ds4)",
            param);
        tr_post(tr3)
	}    
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow1() {
		if ( ds3.namevalue(ds3.rowposition,"upjang_sid" )==0 || ds3.namevalue(ds3.rowposition,"upjang_sid" )==''  ) 
			alert("영업장 정보를 먼저 선택해주세요.");
		else if ( ds_dong.namevalue(ds_dong.rowposition,"dong_sid" )==0 || ds_dong.namevalue(ds_dong.rowposition,"dong_sid" )==''  ) 
			alert("동 정보를 먼저 선택해주세요.");			
		else if ( ds4.namevalue(ds4.rowposition,"room_type_sid" )==0 || ds4.namevalue(ds4.rowposition,"room_type_sid" )=='' ) 
			alert("객실타입을 먼저 선택해주세요.");			
		else  {
			ds1.addrow();
			ds1.namevalue(ds1.rowposition,"upjang_sid")=ds3.namevalue(ds3.rowposition,"upjang_sid" );
			ds1.namevalue(ds1.rowposition,"upjang_nm")=ds3.namevalue(ds3.rowposition,"upjang_nm" );			
			ds1.namevalue(ds1.rowposition,"dong_sid")=ds_dong.namevalue(ds_dong.rowposition,"dong_sid" );												
			ds1.namevalue(ds1.rowposition,"room_type_sid")=ds4.namevalue(ds4.rowposition,"room_type_sid" );			
			ds1.namevalue(ds1.rowposition,"room_type_cd")=ds4.namevalue(ds4.rowposition,"room_type_cd" );						
		}
		
	}
	/*
	 * 행삭제(그리드별)
	 */
	function fnDeleteRow1() {
		ds1.deleterow(ds1.rowposition);
	}
	/*
	 * 적용
	 */
	function fnApply() {
		if (ds1.IsUpdated ) {
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	            + "sUpjangSid=" + ds3.namevalue(ds3.rowposition,"upjang_sid") + ","
	            + "sRoomTypeSid=" + ds4.namevalue(ds4.rowposition,"room_type_sid");
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040I",
	             "JSP(I:DS1=ds1)",
	             param);
	         tr_post(tr1);
         }
	}
	/*
	 * 취소
	 */
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
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && ( colid=='bgn_date' || colid=='end_date' || colid=='room_view_cd' ) ) {
			   	for(i=1;i<=ds1.CountRow;i++)
		     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }		
		   if (row < 1 && colid=='use_yn' ) {
			   	for(i=1;i<=ds1.CountRow;i++)
			    	ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }			   
		</script>
		
	    <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
	        if(colid=="room_view_cd") {
	            var arrParam    = new Array();
	            var arrResult   = new Array();
	            var strURL;
	            var strPos;
				
	            arrParam[0] = "RM002";
	            arrParam[1] = "객실전망"; //공통코드의 마스터값
	            strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
	            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	            arrResult = showModalDialog(strURL,arrParam,strPos);
	            if (arrResult != undefined) {
	                arrParam = arrResult.split(";");
	                ds1.namevalue(ds1.RowPosition,"room_view_cd")=arrParam[1];	                
	                ds1.namevalue(ds1.RowPosition,"room_view_nm")=arrParam[2];
	            }
	        }	        
	    </script>
	    
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDS3();
		</script>	
		
		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div!='init')
				fnSelectDS4();
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
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
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
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr3" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
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
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
		fnSelectDS3();
	</script>
	
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	    fnSelectDS4();
	    div='';
	</script>		
	
	<script language=JavaScript for=ds1 event=OnColumnChanged(row,colid)>
        var flag = false;
        if(colid='room_view_cd'){
            for(var i=1; i<=ds5.CountRow; i++){
                if(ds5.NameValue(i, "detail")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "room_view_nm") = ds5.NameValue(i, "detail_nm");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "room_view_nm") = "";
        }		
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_dong classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
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
				<%
				/*---------------------------------------------------------------------------->
					HTML Desc	: 검색 부분 
								: 담당자명, 담당자코드
				-----------------------------------------------------------------------------*/
				%>											
				<tr>
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRow1()" >
												<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRow1()" >																																										
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
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
			            					<td align=left class="text" width=70>&nbsp;지역</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
			            					<td align=left class="text" width=70>&nbsp;영업장</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="upjang_sid">
                                                    <param name=BindColVal      value="upjang_sid">
													<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
													<param name=ListExprFormat  value="upjang_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>				
			            					<td align=left class="text" width=70>&nbsp;동 정보</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc_dong classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_dong>
													<param name=BindColumn      value="dong_sid">
                                                    <param name=BindColVal      value="dong_sid">
													<param name=EditExprFormat	value="%,%;dong_sid,dong_nm">
													<param name=ListExprFormat  value="dong_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>																																		
			            					<td align=left class="text" width=70>&nbsp;객실타입</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="room_type_sid">
                                                    <param name=BindColVal      value="room_type_sid">
													<param name=EditExprFormat	value="%,%;room_type_sid,room_type_cd">
													<param name=ListExprFormat  value="room_type_cd^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>																			
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left class="text" width=70>&nbsp;사용유무</td>
			                                <td align=left bgcolor="#ffffff" colspan="7">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_use>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
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
									<%
									/*---------------------------------------------------------------------------->
										HTML Desc	: 검색 종류 - 지역,영업장,객실타입:  
										Object ID 	: 그리드 , gr1
										Data ID		: ds1
										
										여기는 임시 수정을 위해 로컬만 고친것입니다. ...심동현 ~~~
									-----------------------------------------------------------------------------*/
									%>							
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name="Format" 			value="
										 	<C> name='No.'          ID='{STRING(CURROW)}'   Width=30    align=center</C>
											<C> name='영업장SID'      ID='upjang_sid'     align=right editlimit=5 show=false</C>																		
											<C> name='영업장'      ID='upjang_nm'   BgColor=#fefec0  width=100 align=left editlimit=5 edit=none show=true suppress=1</C>																																					
											<C> name='동정보'      ID='dong_sid'  BgColor=#fefec0 width=40  align=right editlimit=5 editstyle=lookup data='ds_dong:dong_sid:dong_nm' edit=none show=true suppress=2</C>																																																								
											<C> name='객실타입SID'      ID='room_type_sid'     align=right editlimit=5 show=false</C>																																																							
											<C> name='객실SID'      ID='room_sid'     align=right editlimit=5 show=false</C>																		
											<C> name='객실타입'      ID='room_type_cd'  BgColor=#fefec0  width=60 align=center editlimit=5 edit=none show=true suppress=3</C>																			
											<C> name='객실번호'      ID='room_no'     align=right editlimit=5 show=true suppress=4 sort=true</C>
											<C> name='평면순번'      ID='PLAN_IDX'     align=right editlimit=5 show=true</C>
											<C> name='시작일자√'     ID='bgn_date'    align=center width=70 editlimit=8 mask=XXXX-XX-XX show=true</C>
											<C> name='종료일자√'     ID='end_date'    align=center width=70 editlimit=8 mask=XXXX-XX-XX show=true</C>
											<C> name='전망코드√' ID='room_view_cd'        align=center editstyle=popup editlimit=2 show=true</C>
											<C> name='전망명' ID='room_view_nm'        BgColor=#fefec0 align=left width=100 editlimit=50 edit=none show=true</C>
											<C> name='객실층'       ID='floors'      align=right width=50 editlimit=3 show=true</C>
											<C> name='사용여부√'       ID='use_yn'      align=center width=60 editstyle=checkbox editlimit=1 show=true</C>
											<C> name='참고사항'       ID='remarks'      align=left width=150 show=true</C>																			
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

