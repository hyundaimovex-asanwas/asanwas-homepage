<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 객실정보조회
 * 프로그램ID 	 : Rm040S
 * J  S  P		 : Rm040S
 * 서 블 릿		 : Rm040S
 * 작 성 자		 : 남기표
 * 작 성 일		 : 2006-06-20
 * 기능정의		 : 객실정보 조회(조회, 엑셀)
 * 				      메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
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
			var s_temp1 = "UPJANG_CD:STRING,UPJANG_NM:STRING,FLOORS:STRING,ROOM_NO:STRING,ROOM_TYPE_CD:STRING,ROOM_TYPE_NM:STRING,ROOM_VIEW_NM:STRING,ROOM_STATE_NM:STRING,BGN_DATE:STRING,END_DATE:STRING,USE_YN_NM:STRING";
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
		
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds2.Reset(); //지역코드
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040S",
            "JSP(O:DS5=ds5,O:DS4=ds4)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1); 		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";    
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sUpjangSid=" + ds3.namevalue(ds3.rowposition,"upjang_sid") + ","
	            + "sRoomTypeSid=" + ds4.namevalue(ds4.rowposition,"detail")+","
	            + "sDate=" + sDate.text;;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040S",
	            "JSP(O:DEFAULT=ds1)",
	            param);
	        tr_post(tr1);
    }
	/*
	 * 영업장조회
	 */
    function fnSelectDS3() {
        v_job = "H";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040S",
            "JSP(O:DS3=ds3)",
            param);
        tr_post(tr2);;
    }   

	
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 (사용안함)
%>
    function fnExcel() {
        if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:고객정보조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("고객정보조회", "고객정보조회.xls", 8);
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
		     	if ( ds1.namevalue(1,colid) == 'T' ) {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'F';
			    } else {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'T';			    
			    }
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
        document.all.LowerFrame.style.visibility="hidden";
        if(v_job=="I") {
            window.status = "작업이 완료 되었습니다.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "작업이 실패하였습니다.";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
	    
	    if(v_job == "H") return;
	    if( row < 1){
	        alert(row + " 검색된 데이타가 없습니다."); 
	    }
	</script>
	
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		div='';
	</script>	

	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row,colid)">
		fnSelectDS3();
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
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="500px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left class="text">&nbsp;지역</td>
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
			            					<td align=left class="text">&nbsp;사용유무</td>                                                                                                                                                                                                                                                                                                                                         
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>                                                                                                                                                                                                   
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>                                                                                                                                          
													<param name=ComboDataID		value=ds4>                                                                                                                                                                      
													<param name=BindColumn      value="head">                                                                                                                                                              
                                                    <param name=BindColVal      value="head">                                                                                                                                                                                                                      
													<param name=EditExprFormat	value="%,%;head,detail_nm">                                                                                                                                         
													<param name=ListExprFormat  value="detail_nm^0^120"></object>                                                                                                                                                
												<%=HDConstant.COMMENT_END%>
											</td>	                                                                                                                                                                                             																			
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left class="text">&nbsp;영업장</td>
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
											<td align=left class="text">&nbsp;기준일자</td>
											<td align=left bgcolor="#ffffff">&nbsp;	
												 <%=HDConstant.COMMENT_START%>
                                                    <object id=sDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                    </object>
                                                <%=HDConstant.COMMENT_END%>
											</td>
			            				</tr>											            				
			            			</table>
								</td>
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">
												<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="fnExcel()">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
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
									-----------------------------------------------------------------------------*/
									%>							
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name="Format" 			value="
											<C> name='영업장SID'      	ID='upjang_sid' show=false</C>																		
											<C> name='객실타입SID'    	ID='room_type_sid' show=false</C>																																																							
											<C> name='영업장코드'      	ID='upjang_cd' width=120 align=right</C>
											<C> name='영업장명'      		ID='upjang_nm' width=150 align=left</C>																		
											<C> name='객실층'      		ID='floors' align=center show=true</C>
											<C> name='객실SID'      		ID='room_sid' show=false</C>																		
											<C> name='객실번호'      		ID='room_no' show=true</C>
											<C> name='객실타입'      		ID='room_type_cd' show=true</C>
											<C> name='객실전망'      		ID='room_view_nm' show=true</C>
											<C> name='객실상태'      		ID='room_state_nm' show=true</C>
											<C> name='시작일자'     		ID='bgn_date' align=center width=70 mask=XXXX-XX-XX show=true</C>
											<C> name='종료일자'     		ID='end_date' align=center width=70 mask=XXXX-XX-XX show=true</C>
											<C> name='사용여부'       	ID='use_yn_nm' align=center show=true</C>
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

                                                                                    