<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 호텔별 시즌생성.
 * 프로그램ID 	 : RM210B
 * J  S  P		 : RM210B
 * 서 블 릿		 : RM210B
 * 기능정의		 : 객실 타입 등록 (조회 등록 삭제 수정)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-04-30][박경국] 호텔별 시즌 생성. 학단시즌컬럼 추가(SALES.TRM100: SEASON_CD_STU)
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
// Description 	: 선조회
// Parameter 	:
%>
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds2.Reset(); //지역코드

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210B",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	:
%>
    function fnSelect()
    {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" 
		        	+ ",v_saup_sid="  + drp_saup.ValueOfIndex("saup_sid", drp_saup.Index) 
                    + ",v_upjang_sid="  + drp_upjang.ValueOfIndex("upjang_sid", drp_upjang.Index); 
                    
       ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210B", 
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용
// Parameter 	:
%>
	function fnApply() {
        
        var checkDiv='';
        var checkDiv2='';
			if(ds1.IsUpdated) {
				for( i=1;i<=ds1.CountRow;i++ ) {
					if ( ds1.namevalue(i,"use_yn") == 'T' ) {
						checkDiv='true';
						break;
					}
				}
				if ( checkDiv != 'true' ) { 
						alert("적어도 하나의 생성체크를 선택하셔야 합니다."); return; 
				} 
		       	
		       	window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

				ln_TRSetting(tr1, 
                            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210B", 
                            "JSP(I:DEFAULT=ds1)", 
                            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr1);
        	}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
    <script language="javascript"  for=gr1 event=OnClick(row,colid)>
        if(row==0){
            if(ds1.CountRow==0) return;
            
            gr1.ReDraw = "False";

			if(colid=="USE_YN" ){
                for(var i=1; i<=ds1.CountRow; i++)
                    ds1.NameValue(i, "USE_YN") = ds1.NameValue(1, "USE_YN");
            }
            gr1.ReDraw = "True";
            return;
        }
    </script>
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		if ( colid == 'use_yn' ) {
			if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
				ds1.namevalue(row,"use_yn") = 'F';		
				alert("시작일자와 종료일자를 입력하셔야 합니다.");
			}
		}
	</script>
	<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		if ( colid == 'use_yn' ) {		
			if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
				ds1.namevalue(row,"use_yn") = 'F';		
				alert("시작일자와 종료일자를 입력하셔야 합니다.");
			}				
		}
	</script>
	<script language=JavaScript for= lc1 event=OnSelChange()>
		if ( div!='init')
			fnSelectDs3();
	</script>		
	<script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
		if ( colid == 'end_date' ) 	//시작일자와 종료일자의 차이 체크
			if ( ds1.namevalue(row,"bgn_date") != '' ) {			
				if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
					alert("종료일자가 시작일자보다 작습니다. 다시 입력해 주세요.");
					ds1.namevalue(row,"end_date") = '';
				}
			}
		if ( colid == 'bgn_date' ) 	//시작일자와 종료일자의 차이 체크
			if ( ds1.namevalue(row,"end_date") != '' ) {
				if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
					alert("종료일자가 시작일자보다 작습니다. 다시 입력해 주세요.");
					ds1.namevalue(row,"bgn_date") = '';
				}				
			}
	</script>	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=drp_saup event=OnSelChange()>
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_SaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&s_UpjangType=10&s_use_yn=Y";
        ds3.Reset(); //영업장코드
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
            //메시지 처리
	</script>
    <script language="javascript" for="tr1" event="OnFail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    </script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    if(v_job == "H") return;
    if( row < 1){
        alert("검색된 데이타가 없습니다."); 
    }
</script>
<script language=JavaScript  for=ds_temp event="OnLoadCompleted(row)">
    if(row==0){
        ds1.NameValue(ds1.RowPosition, "UPJANG_SID")="";
        ds1.NameValue(ds1.RowPosition, "UPJANG_NM")="";
        ds1.NameValue(ds1.RowPosition, "ROOM_TYPE_CD") = "";
        ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_CD")="";
        ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_NM")="";
        ds1.NameValue(ds1.RowPosition, "BED_TYPE_CD")="";
        ds1.NameValue(ds1.RowPosition, "BED_TYPE_NM")="";
        alert("검색된 데이타가 없습니다.");
        return;
    }
    ds1.NameValue(ds1.RowPosition, "UPJANG_SID") = ds_temp.NameValue(row, "UPJANG_SID");
    ds1.NameValue(ds1.RowPosition, "UPJANG_NM") = ds_temp.NameValue(row, "UPJANG_NM");
    ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_CD")= ds_temp.NameValue(row, "ROOM_GRADE_CD");
    ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_NM")= ds_temp.NameValue(row, "ROOM_GRADE_NM");
    ds1.NameValue(ds1.RowPosition, "BED_TYPE_CD")  = ds_temp.NameValue(row, "BED_TYPE_CD");
    ds1.NameValue(ds1.RowPosition, "BED_TYPE_NM")  = ds_temp.NameValue(row, "BED_TYPE_NM");
</script>
<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

</script>
<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	ds3.insertRow(1);
	ds3.namevalue(1,"upjang_nm") = "전체";
    drp_upjang.index = 0;
</script>
<script language=javascript for=gr1 event="OnExit(Row, Colid, olddata)">
    if(Row==0) return;
    if(Colid=="ROOM_TYPE_CD"){
        if(ds1.NameValue(Row, Colid)==olddata) return;
        if(ds1.NameValue(Row, Colid).length!=5) {
            ds1.NameValue(Row, Colid) = olddata;
            return;
        }
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
    
        v_job = "S";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" 
                    + ",v_room_type_cd=" + ds1.NameValue(Row, Colid)
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210B", 
            "JSP(O:TEMP=ds_temp)",
            v_param);
        tr_post(tr1);
    }
</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
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
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
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
						<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
							<tr  bgcolor="#6f7f8d" height="30px" >
								<td width="100px" td align=left class="text">지역</td>
            					<td align="center" bgcolor="#ffffff">&nbsp;
            						<%=HDConstant.COMMENT_START%>
            						<object id=drp_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=200 align="center" class="txtbox" >
            							<param name=ComboDataID			value=ds2>
            							<param name=SearchColumn		value="saup_nm">
            							<param name=Sort				value="false">
            							<param name=ListExprFormat		value="saup_nm^0^140">
            							<param name=BindColumn			value="saup_sid">
            						</object>
                                    <%=HDConstant.COMMENT_END%>
            					</td>
                                <td width="100px"td align=left class="text">업장명</td>
            					<td align="center" bgcolor="#ffffff">&nbsp;
            						<%=HDConstant.COMMENT_START%>
            						<object id=drp_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=300 width=200 align="center" class="txtbox" >
            							<param name=ComboDataID			value=ds3>
            							<param name=SearchColumn		value="upjan_nm">
            							<param name=Sort				value="false">
            							<param name=ListExprFormat		value="upjang_nm^0^140">
            							<param name=BindColumn			value="upjang_sid">
            						</object>
                                    <%=HDConstant.COMMENT_END%>
            					</td>
                    		</tr>
	            		</table>
    	        	</td>
        	    </tr>
            </table>
       </td>
    <tr height="10">
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
			    	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:470px" border="1">
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		VALUE="
                                            <C> name='사업SID' 			ID='saup_sid' 		HeadAlign=Center Width=100  align=left 	editlimit=10 show=false</C>																																																									
											<C> name='영업장SID' 		ID='upjang_sid' 	HeadAlign=Center Width=100  align=left 	editlimit=10 show=false</C>																																							
											<C> name='영업장명' 		ID='upjang_nm' 		HeadAlign=Center Width=120  align=left 	editlimit=30 BgColor=#fefec0 edit=none</C>																					
											<C> name='생성'  			ID='use_yn'   		HeadAlign=Center Width=70 	align=center editlimit=1 edit={IF(Enable2=0,'false','true')} editstyle=checkbox</C>																														
											<C> name='시작일자' 		ID='bgn_date' 		HeadAlign=Center Width=150  	align=center editlimit=26 mask='XXXX-XX-XX'</C>
											<C> name='종료일자' 		ID='end_date' 		HeadAlign=Center Width=150  	align=center editlimit=26 mask='XXXX-XX-XX'</C>
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

