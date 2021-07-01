<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 일자별 상품관리
 * 프로그램ID 	 : RM430I
 * J  S  P		 : rm430i
 * 서 블 릿		 : RM430I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-06-12
 * 기능정의		 : 일자별 상품관리 (조회, 저장, 취소)
 * 				   메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-08-04][박경국] 검색조건에 [지역] 추가.
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
    date.set(java.util.Calendar.HOUR_OF_DAY, 1440);      
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
		fnSetHeader();
		
        //상품정보
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds2.Reset(); 
        //출경시간
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_Item1=Y";
        ds3.Reset();        
        //도착시간
        ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_Item1=Y";
        ds4.Reset();
        //지역코드	                        
        ds5.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds5.Reset();
	}
	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
			var s_temp1 = "use_yn:STRING,depart_date:STRING,yoil_nm:STRING,goods_sid:INT,goods_cd:STRING,goods_nm:STRING,depart_time:STRING,nights:INT,days:INT,arrive_date:STRING,arrive_time:STRING";
			ds1.SetDataHeader(s_temp1);
		}
	}	
	/*
	 * 메인조회
	 */
    function fnSelect() {
    	if ( ds1.isUpdated ) {
    		alert("수정중인 행이 있습니다."); 
    		return;
    	}
    	if ( sBgnDate.text == '' || sEndDate.text == '' ) {
    		alert("출발일자를 입력해 주세요.");
    		return;
    	}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	        + "sSaupSid="  + lc1.ValueOfIndex("saup_sid", lc1.Index) + ","
            + "sBgnDate="  + sBgnDate.text + ","
            + "sEndDate="  + sEndDate.text + ","                    
            + "sGoodsSid=" + sGoodsSid.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm430I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow() {
		ds1.addrow();
	}
	/*
	 * 행삭제(그리드별)
	 */
	function fnDeleteRow() {
		for ( i=ds1.CountRow; i>=1; i-- ) {
			if ( ds1.namevalue(i,"use_yn") == 'T') {
				ds1.deleterow(i);			
			}
		}
	}
	/*
	 *  적용
	 */
	function fnApply() {
    	for ( i=1; i<=ds1.CountRow; i++ ) {
    		if ( ds1.RowStatus(i) == 1 || ds1.RowStatus(i) == 2 || ds1.RowStatus(i) == 3 ) {
    			if ( ds1.namevalue(i,"depart_date") == '' ) {
    				alert("그리드의 출발일자를 입력해주세요.");
    				return;
   				}
    			if ( ds1.namevalue(i,"goods_sid") == '' ) {
    				alert("그리드의 상품정보를 입력해주세요.");
    				return;
   				}   				
    		}
    	}	
        v_job = "I";	
         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
         ln_TRSetting(tr1, 
             "<%=dirPath%><%=HDConstant.PATH_RM%>Rm430I",
             "JSP(I:DEFAULT=ds1)",
             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
         tr_post(tr1);
	}
	/*
	 *  취소
	 */
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
	/*
	 *  상품정보 팝업
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
				sGoodsSid.value = 0;
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
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='use_yn' ) {
			   	for(i=1;i<=ds1.CountRow;i++)
					ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }		
			if (row < 1 && colid=='depart_time' ) {
				for(i=1;i<=ds1.CountRow;i++){
		     		ds1.namevalue(i,colid) = ds1.namevalue(1, colid);
	    		}
		   }	
			if (row < 1 && colid=='nights' ) {
				for(i=1;i<=ds1.CountRow;i++){
		     		ds1.namevalue(i,colid) = ds1.namevalue(1, colid);
	    		}
		   }	
			if (row < 1 && colid=='days' ) {
				for(i=1;i<=ds1.CountRow;i++){
		     		ds1.namevalue(i,colid) = ds1.namevalue(1, colid);
	    		}
		   }	
			if (row < 1 && colid=='arrive_time' ) {
				for(i=1;i<=ds1.CountRow;i++){
		     		ds1.namevalue(i,colid) = ds1.namevalue(1, colid);
	    		}
		   }			   		   		   	
		</script>

	    <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
	        if(colid=="goods_cd") {
	            var arrParam    = new Array();
	            var arrResult   = new Array();
	            var strURL;
	            var strPos;

	            arrParam[0] = "RM002";
	            arrParam[1] = "상품정보";
	            strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
	            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	            arrResult = showModalDialog(strURL,arrParam,strPos);
	            if (arrResult != undefined) {
	                arrParam = arrResult.split(";");
	                ds1.namevalue(ds1.RowPosition,"goods_sid")=arrParam[0];	                
	                ds1.namevalue(ds1.RowPosition,"goods_cd")=arrParam[1];
	                ds1.namevalue(ds1.RowPosition,"goods_nm")=arrParam[2];
	            } else {
	                ds1.namevalue(ds1.RowPosition,"goods_sid")=0;	                
	                ds1.namevalue(ds1.RowPosition,"goods_cd")='';
	                ds1.namevalue(ds1.RowPosition,"goods_nm")='';	            
	            }
	        }
	    </script>
    
		<script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
			if ( colid == 'nights' ) {
				if ( ds1.namevalue(row,"nights") != '' ) {
					ds1.namevalue(row,"days") = ds1.namevalue(row,"nights") + 1;
					//날짜계산(도착일자 = 출발일자 + 박수)
					var dd = eval(ds1.namevalue(row,"depart_date").substring(6,8))*1 + eval(ds1.namevalue(row,"nights"))*1; // 날짜 계산
					var oDate = new Date(eval(ds1.namevalue(row,"depart_date").substring(0,4)), eval(ds1.namevalue(row,"depart_date").substring(4,6)), dd) // 계산된 날짜 객체 생성 (객체에서 자동 계산)
					
					if ( String(oDate.getMonth()).length <= 1 ) {
						if ( String(oDate.getDate()).length <= 1 ){
							if(oDate.getMonth()==0){//12월일 경우
							ds1.namevalue(row,"arrive_date") = "" + (oDate.getFullYear()-1) + "12" + "" + "0" + oDate.getDate();
							}
							else{
							ds1.namevalue(row,"arrive_date") = "" + oDate.getFullYear() + "0" +oDate.getMonth() + "0" + oDate.getDate();
							}
						}
						else{ 
							if(oDate.getMonth()==0){//12월일 경우
							ds1.namevalue(row,"arrive_date") = "" + (oDate.getFullYear()-1) + "12" + "" + oDate.getDate();
							}
							else{
							ds1.namevalue(row,"arrive_date") = "" + oDate.getFullYear() + "0" +oDate.getMonth() + "" + oDate.getDate();
							}
						}
					} else {
						if ( String(oDate.getDate()).length <= 1 )
							ds1.namevalue(row,"arrive_date") = "" + oDate.getFullYear() + "" +oDate.getMonth() + "0" + oDate.getDate();
						else 
							ds1.namevalue(row,"arrive_date") = "" + oDate.getFullYear() + "" +oDate.getMonth() + "" + oDate.getDate();
					}
				}
			}
			if ( colid == 'goods_cd' ) {
				var exit=false;
				for ( i=1; i<=ds2.CountRow; i++ ) {
					if ( ds2.namevalue(i,"goods_cd") == ds1.namevalue(row,colid) ) {
						ds1.namevalue(row,"goods_sid") = ds2.namevalue(i,"goods_sid");
						ds1.namevalue(row,"goods_nm") = ds2.namevalue(i,"goods_nm");
						exit=true;
						return;
					}
				}
				if ( exit != true ) {
					ds1.namevalue(row,"goods_sid") = 0;
					ds1.namevalue(row,"goods_nm") = '';				
				}
			}			
		</script>	
		
		<script language="javascript"  for=gr1 event=OnColumnPosChanged(row,colid)>
			if ( ds1.RowStatus(row) == 0) {
				gr1.ColumnProp('depart_date','Edit')='None';
				gr1.ColumnProp('goods_cd','Edit')='None';
			} else {
				gr1.ColumnProp('depart_date','Edit')='';
				gr1.ColumnProp('goods_cd','Edit')='';		
			}
		</script> 	
		
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
            alert(tr1.SrvErrMsg("ERROR",0));
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	 window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript  for=ds2 event="OnLoadStarted()">
	 window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
</script>

<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
</script>
<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
<!--  출발시간 -->
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!--  도착시간 -->
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- 지역 -->
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
						            			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
						            			<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnAddRow()">
						            			<img src="<%=dirPath%>/Sales/images/minus.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()">						            									            			
						            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
						            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
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
											<%=HDConstant.COMMENT_END%>&nbsp;-
										     <%=HDConstant.COMMENT_START%>
										     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
			            					<td align=left width=70 class="text">&nbsp;상품코드</td>
			                                <td align=left bgcolor="#ffffff" width=300>&nbsp;																										
												<input id="sGoodsSid" type="hidden">                                
												<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" onBlur="fnSetting('ds2')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="상품정보를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
												<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" readOnly>																						
											</td>
											<td align=left class="text" width="70px">지역</td>
						                    <td align=left bgcolor="#ffffff">&nbsp;																										
											<%=HDConstant.COMMENT_START%>
						                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="saup_sid">
	                					            <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^100">
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
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="
                                            <FC> name=''             ID='{String(CURROW)}'           Width=40    align=center</FC>
							               <C> name='삭제√'  ID='use_yn'        HeadAlign=Center Width=40  align=center editstyle=checkbox show=true</C>                                            
							               <C> name='출발일자'  ID='depart_date'        HeadAlign=Center Width=80  align=center editlimit=8 sort=true show=true mask='XXXX-XX-XX'</C>
							               <C> name='요일'    ID='yoil_nm'  HeadAlign=Center Width=30  BgColor=#fefec0 align=center edit=none show=true</C>							               
							               <C> name='상품SID'    ID='goods_sid'  HeadAlign=Center Width=100  align=left editlimit=12 show=false</C>
							               <C> name='상품코드'     ID='goods_cd'   HeadAlign=Center Width=70  align=center editlimit=50  editstyle=popup show=true</C>
							               <C> name='상품명'     ID='goods_nm'   HeadAlign=Center Width=120  align=left BgColor=#fefec0 edit=none editlimit=50 sort=true show=true</C>
							               <C> name='출발시간√'  ID='depart_time'        HeadAlign=Center Width=70  align=center editlimit=4 editstyle=lookup data='ds3:detail:detail_nm' show=true</C>
							               <C> name='박수√'       ID='nights'     HeadAlign=Center Width=40  align=right editlimit=3 show=true</C>
							               <C> name='일수√' ID='days'       HeadAlign=Center Width=40  align=right editlimit=3 show=true</C>
							               <C> name='도착일자'  ID='arrive_date'        HeadAlign=Center Width=70  align=center editlimit=8 show=true mask='XXXX-XX-XX'</C>
							               <C> name='도착시간√'  ID='arrive_time'        HeadAlign=Center Width=70  align=center editlimit=4 editstyle=lookup data='ds4:detail:detail_nm' show=true</C>
                            			">
                            		</object>
                            		<%=HDConstant.COMMENT_END%>
                				</td>
                		    </tr>
                		    <tr>
                				<td>
		                		    -. 각 일자에 등록된 상품을 삭제하려 할 때<BR>
		                		    　삭제V 체크 → [행삭제] 클릭 → [저장] 클릭<BR>
		                		    -. 2010-05-12 금강산 출입시 주 1회. 수요일<BR>
		                		    　2박 상품 = 출경 15:30, 입경 14:05<BR>
		                		    　자재당일 = 출경 09:40, 입경 15:30
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

