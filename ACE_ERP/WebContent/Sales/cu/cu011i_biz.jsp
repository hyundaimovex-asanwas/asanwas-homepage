<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 실무번호등록
 * 프로그램ID 	 : CU011I
 * J  S  P		 : cu011i
 * 서 블 릿		 : CU011I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-07-25
 * 기능정의		 :  실무번호등록 (조회,저장)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-10-22][심동현] 사업자 추가정보 테이블 설계 변경 건 반영
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>

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

	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
			
	/* 선조회	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";   
        //대리점
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         

        lkDS_visit_k_list.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=S&s_Head=CU025&s_item1=Y";
        lkDS_visit_k_list.Reset(); //사진명단제출
	}
	/* 메인조회	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {        
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sClientSid=" + sClientSid.value + ","
	            + "sWorkNo=" +sWorkNo.value + ","
	            + "sWorkNoChk=" + sWorkNoChk.checked + ","
	            + "sCustNm=" + sCustNm.value + ","
	            + "sManageNo=" + sManageNo.value +","
	            + "sDepartDate=" +sDepartDate.Text;

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu011I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * 적용
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_CU%>Cu011I",
	             "JSP(I:DEFAULT=ds1)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
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

	/*
	 * 번호 생성
	 */
	function fnCreate() {
		//dataset에 row가 없으면 생성 금지.
        if(ds1.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
		
		if (ds1.isUpdated ){// 업데이트(선택체크)된 행이 없으면.
			v_job = "C";	
			window.status="생성 중입니다. 잠시만 기다려 주십시오...";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
			        + "sCreateCond=" + sCreateCond.value;
			     ln_TRSetting(tr1, 
			         "<%=dirPath%><%=HDConstant.PATH_CU%>Cu011I",
			         "JSP(I:CREATE=ds1)",
			         param);
			tr_post(tr1);
		} else {
			alert("생성할 대상을 선택해 주시기 바랍니다.");
		};
	};
	
	
	
	/*
	 * 대리점팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];					
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	} 	
	/*
	 * 대리점 자동셋팅(조건)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds_client' ) {	//대리점
			for ( i=1; i<=ds_client.CountRow; i++ ) {
				if ( ds_client.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds_client.namevalue(i,"client_sid");
					sClientNm.value = ds_client.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>



<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
    if(Row==0) {	//제목줄을 클릭했을때.
        if(ds1.CountRow<=1) return;
        gr1.Redraw = "False";
        

        //선택 
        if(Colid=="JOB_SEL"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        
        //교육유무
        if(Colid=="VISIT_K_LIST"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        gr1.Redraw = "True";
        return;
    }
	

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
        if(v_job=="C") {	// 생성 후에는 새로 조회
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            fnSelect();
        }  else if(v_job == "I") {	// 저장 후에는 걍 그대로
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {	// 초기화나 조회 후에는 서칭.
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        }
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
         window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds_client event="OnLoadCompleted(row)">
	    window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="false">
	</object>
	<!--  대리점  -->
	<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value=false>
	</object>

	<!-- GRID LOOKUP DS 사진명단제출  -->	
	<object id=lkDS_visit_k_list classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->										

  <table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<%
	/*---------------------------------------------------------------------------->
	HTML Desc	: 검색 부분 
				: 담당자명, 담당자코드
	-----------------------------------------------------------------------------*/
	%>
	<tr>
	  <td align="right" colspan="2">
		<table border="0"  cellpadding="0" cellspacing="0" width="100%">
		  <tr>
			<td align="right" height="30px">		
				<img src="<%=dirPath%>/Sales/images/n_create.gif"   style="cursor:hand" onclick="fnCreate()">
				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
			</td>
		  </tr>	
		</table>
	  </td>											
	</tr>
	<tr height="50px">
	  <td align="left"  colspan='2' width="845px">
		<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
		  <tr> 
			<td  width="845px">
		      <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
		      	<tr bgcolor="#6f7f8d">
		          <td align=left width=70 class="text">&nbsp;대리점</td>
		          <td align=left width=240 bgcolor="#ffffff">&nbsp;
					<input id="sClientSid" type="hidden" value="0">
					<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
					<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
					<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="" readOnly>																						
				  </td>	
		          <td align=left class="text"  width="80">현대실무번호</td>
		          <td align=left width=250 bgcolor="#ffffff">&nbsp;																							
					<input id="sWorkNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">
				  </td>
		          <td align=left class="text" width="150">실무번호 없는 사람만</td>
		          <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
					<input id="sWorkNoChk" type="checkbox" style= "position:relative;left:-0px;top:2px">		          
				  </td>
				</tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height=6></td>
		  </tr>
		  <tr>
			<td>
		      <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
		      	<tr bgcolor="#6f7f8d">
				  <td bgcolor="#FFFFFF" class="text" width="70">출발일자</td>
				  <td  bgcolor="#FFFFFF" align="center">
					<%=HDConstant.COMMENT_START%>
					<object id=sDepartDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
						<param name=Alignment 	value=1>
						<param name=Format      value="YYYY-MM-DD">
                        <PARAM NAME=InputFormat value="YYYYMMDD">
                        <param name=Cursor      value="iBeam">
                        <param name=Border      value="false">
                        <param name=InheritColor      value="true">
                        <param name=ReadOnly    value="false">
                        <param name=SelectAll   value="true">
                        <param name=SelectAllOnClick    value="true">
                        <param name=SelectAllOnClickAny   value=false>
					</object>
					<%=HDConstant.COMMENT_END%>
				  </TD>
		          <td align=left class="text" width="70">고객명</td>
		          <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					<input id="sCustNm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;">
				  </td>
		          <td align=left class="text" width="80">주민/여권번호</td>
		          <td align=left bgcolor="#ffffff">&nbsp;																										
					<input id="sManageNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">
				  </td>											                            

		          <td align=left width=70 class="text">&nbsp;생성조건</td>
		          <td align=left bgcolor="#ffffff">&nbsp;
		          	<select name="sCreateCond">
		          		<option value=1>실무</option>
		          		<option value=2>봉사</option>
		          	</select>
				  </td>	
				</tr>
			  </table>
			  			  
			</td>
		  </tr>															
		</table>	
	  </td>											
	</tr>
	<tr height="10">
	  <td colspan='2'></td>
	</tr>													
	<tr>
	  <td width="845px" colspan='2'>
		<table  border="0" cellpadding="0" cellspacing="0">
		  <tr valign="top"">
			<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
			<%
			/*---------------------------------------------------------------------------->
			HTML Desc	: 검색 종류 - 
			Object ID 	: 그리드 , gr1
			Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>							
			<%=HDConstant.COMMENT_START%>
			<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:380" border="1" >
               	<param name="DataID"		VALUE="ds1">
               	<param name="BorderStyle"   VALUE="0">
               	<param name=ColSizing       value="true">
               	<param name="editable"      value="true">
               	<param name=UsingOneClick  	value="1">
               	<param name="SortView"      value="Right">
				<param name=SuppressOption 	value=1>
				<param name=ViewSummary 	value=1>
                <Param Name="AllShowEdit"       value="True">
                <param name="ViewSummary"       value="1">
				<param name="Format" 			value="
					<FC> name='선택√'		ID='JOB_SEL' 	Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</FC>
			    	<C> name='고객SID'     ID='cust_sid'    align=left editlimit=12 show=false </C>
			    	<FC> name='성명'      	ID='cust_nm'	BgColor=#fefec0 width=60  align=left editlimit=30 edit=none sort=true show=true sumtext='계'</FC>
			    	<C> name='주민/여권번호'		ID='manage_no'		width=110	align=center editlimit=20 edit=none sort=true show=true sumtext=@cnt BgColor=#fefec0</C>
			    	<C> name='현대실무번호'		ID='work_no'		width=100	align=left		editlimit=20 sort=true	show=true </C>
			    	<C> name='사진명단 제출여부√'	ID='VISIT_K_LIST'	width=140   align=CENTER	editlimit=20 show=true  editstyle=lookup  data='lkDS_visit_k_list:detail:detail_nm' bgColor={IF(VISIT_K_LIST='N','#ffcccc','#FFFFFF') }</C>
			    	<C> name='이수여부'   ID='educ_yn_nm' BgColor=#fefec0 width=60 align=left editlimit=8 edit=none show=true</C>
			    	<C> name='교육과목' ID='educ_saup_nm'    BgColor=#fefec0 width=60    align=left editlimit=50 edit=none show=false</C>
			    	<C> name='교육일'      ID='educ_dt'   BgColor=#fefec0 width=70  align=left editlimit=8 edit=none show=false mask=XXXX-XX-XX</C>
			    	<C> name='예약상태'    ID='status'   BgColor=#fefec0 width=70  align=CENTER editlimit=8 edit=none show=True</C>
				">
			</object>
			<%=HDConstant.COMMENT_END%>
			</td>		
		  </tr>
		</table>
	  </td>
	</tr>
	<tr>
	  <td><BR>※ 사업자이면서 조회가 안되는 경우에는 <A HREF="cu010i_biz.jsp?idx=484" TARGET="_BLANK">[사업자등록]</A> 메뉴에 가서 직장코드를 검색 입력 후 저장해주시기 바랍니다.<br>
	  　 [방북신청현황], [확정명단(사업자)]에서 보이는 숫자보다 일반적으로 많아야 정상입니다.<BR>
	  ★ 사업자가 출경할 경우 [사진명단 제출여부]가 "제출"로 업뎃됩니다.
	  </td>
	</tr>
	
  </table>	
											
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


