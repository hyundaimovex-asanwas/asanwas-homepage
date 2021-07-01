<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 고객등록
 * 프로그램ID 	: CU010i
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-30
 * 기능정의		: 고객등록 
 * [수  정   일  자][수정자] 내용
 * [2007-09-17][심동현] 새 메뉴트리 적용
 * [2009-02-26][심동현] 고객 행추가
 *						대리점 = 검색조건에서 끌고가기
 *						주소1,주소2,자택전화, 핸드폰 = 숨은 input으로 복사해놓았던 값들 끌고가기 기능 고민..;
 * [2009-03-05][심동현] 예약판매대상, 온천당첨여부 추가.
 * [2009-11-02][박경국] 일본 훼리호 판매용 고객등록화면. 내국인컬럼에 여권번호/여권종류/여권만기일 추가.
 * [2009-11-23][박경국] 일본 훼리호 판매용 고객등록화면. 내국인컬럼에 영문성/영문이름 추가.
 * [2011-04-21][박경국] 내국인이 해외관광을 하는 상황(전세기, 중국 수학여행 등)에 대비하여...고객등록 화면을 필수 요소만 입력하게 끔 수정(간략화).
                                   여권정보 입력, 비자유무 체크, 영문성/영문이름 입력
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


<%
	String basePath =  request.getServerName();

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i3.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">
	    var v_job = "";
	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit(); 
		
		lc_cust_gu.Index = "1";
		lc_cust.Index = 1;
		lc_country.Index = 1;
	
	}
	 
	/* 페이지 초기화 : 기본 코드정보를 얻어온다	 */
	function fnInit(){
        v_job = "H";

        cfStyleGrid(getObjectFirst("gr1"), "comn");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I3",
            "JSP(O:DEFAULT=ds1,O:CUSTALL=searchds1,O:NATIONALL=searchds2,O:NATION=initds1,O:AUTH=initds2,O:SEX=initds3,O:CUST=initds4,O:TRAD=initds5,O:PASS=initds6,O:CUST_TYPE=initds7,O:SAUP=initds8,O:BUY_TYPE=initds9,O:IMAGE=imgDs,O:CU019=initds10,O:CU020=initds11)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

	/* 조회 */
	function fnSelect() {
        v_job = "S";
        if(ds1.IsUpdated!=false && confirm("지금 현재 작업중인 데이터가 있습니다. 진행하시겠습니까")==false){
            return;
		}
		if(sAccpt_no.value == "" &&sCustNm.value == "" && sManegeNo.value == ""){
			alert("신청서번호, 고객명 또는 주민/여권번호 한가지는 반드시 입력되야 합니다.")
			return;
		}
	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid="+ sClientSid.value
                  + ",sCustGu=" + lc_cust.ValueOfIndex("detail", lc_cust.Index)
                  + ",sCountryGu=" + lc_country.ValueOfIndex("detail", lc_country.Index)
                  + ",sCustNm=" + sCustNm.value
                  + ",sAcceptNo=" + sAccpt_no.value
                  + ",sManegeNo=" + sManegeNo.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I3",
            "JSP(O:DEFAULT=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
	}


	/* 그리드 행추가*/
	function fnAddRow() {
		ds1.addRow();
		ds1.namevalue(ds1.rowposition,"group_cd") = sAccpt_no.value;
		ds1.namevalue(ds1.rowposition,"cust_nm") = sCustNm.value;
		ds1.namevalue(ds1.rowposition,"regi_no") = sManegeNo.value;
		
		getObjectFirst("regi_no").Focus();
        imgDs.addRow();
        lc_pass_type.Index = 0;	//0번째 것 , 일반여권(2) 으로 세팅. 이거 2번 = 코드 30 취업여권
        lc_regi_yn.Index = 0;
        lc_cust_gu.index=0;
    }

	/* 그리드 행삭제 */
	function fnDeleteRow() {
		if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        		alert("마감된 자료입니다. 삭제할수 없습니다");
        		
        		ds1.undo(ds1.rowposition);
        		return;
        	}
		ds1.DeleteRow(ds1.RowPosition);
        imgDs.DeleteRow(ds1.RowPosition);
	}

	/* 그리드 수정 취소*/
	function fnCancel() {
        ds1.undoall();
        imgDs.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
	}

    /* 적용(업데이트/인서트) 함수  */
    function fnApply() {    
        if (ds1.IsUpdated || imgDs.IsUpdated) {
        	if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        		alert("마감된 자료입니다\n\n수정할수  없습니다");
        		
        		ds1.undo(ds1.rowposition);
        		return;
        	}
        	
            if(fnCustInfoCheck()!=true) return;
            fnOnProgressStart();
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I3",
                "JSP(I:REGIST=ds1,I:IMAGE=imgDs,O:RESULT=ds_result)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr_save);
        } else {
            alert("고객 정보의 변경 내역이 없습니다.");
        }
    }
    
    
    /* 인증 1 */
	function fnConfirm() {
		alert("2008년 5월26일부로 실명확인 프로세스가 변경되었습니다.\n\n공지사항을 참고하여 [고객정보>고객조회]에서 인증을 받아주세요.\n\n6월 10일 출발일부터 실명확인되지 않은 관광객은 예약불가합니다.");
	
//    	var url = "http://com.hdasan.com/cNameCheckSYS.asp?Jumin="+ regi_no.Text +"&Name="+ txt_cust_nm.value +"&returnURL=erp.hdasan.com/services/Sales/common/include/confirm.jsp";
//		top.confirm = 	window.open(url, "comfirm" ,"width=400,height=280,left=300,top=0,toolbar=yes,status=yes,menubar=no,scrollbars=no,resize=no,resizable=no");    
//	  	top.confirm.opener = this;
    }
    
    /* 신청서번호     */
	function fnSelectAcceptNo() {
	
		if(sClientNm.value != "") {
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
	                  + ",sClientSid="+ sClientSid.value
	        fnOnProgressStart();
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I3",
	            "JSP(O:SEARCH_DS4=searchds4)",
	            param);
	        tr_post(tr1);
	       } else {
	       		alert("대리점를 선택해주세요!");
	       		return;
	       }
	}
	
	
	/* 대리점용 신청서 번호 적용	 */
	 
	 function fnAcceptApply() {
	 	if (sAccpt_no.value == "") {
	 		alert("적용할 신청서 번호가 없습니다!");
	 		return;
	 	}
	 	group_cd.value = sAccpt_no.value;
	 }
	 
	 
		/* 체크박스의 값을 데이터셋으로 연동		 */
		//비자유무 체크를 위해(해외관광) 임시로 height컬럼을 사용해서 1이면 비자(有) 0이면 비자(無)로 해준다. 20110506 박경국
		function fnCheckbox() {
			if(height.checked==true) {
				ds1.namevalue(ds1.rowposition,"height")=1;
			}
			else {
				ds1.namevalue(ds1.rowposition,"height")=0;
			}		
		}
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language="javascript" for="gcip_file" event=OnClick()>
	    if (fn_trim(gcip_file.value)!="") {
	    	txt_file.value = gcip_file.value;
	    	photo.src = gcip_file.value;
	    }
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	<script language="javascript" for="tr1" event="OnSuccess()">
	    fnOnProgressEnd();
	    if(ds1.CountRow>0)
	        fnScreenDisplay(ds1.NameValue(ds1.RowPosition, "COUNTRY_GU"));
	    else
	        fnScreenDisplay("");
	
	    var info_cnt = tr1.SrvErrCount("INFO");
	    var info_msg = "";
	    for(var i=0; i<info_cnt; i++){
	        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
	    }
	    if(info_msg!="") 
	        alert("============= 안내 메시지=============\n\n" + info_msg);
	        
	</script>
	
	<script language="javascript" for="tr1" event="OnFail()">
	    fnOnProgressEnd();
	    
	    var error_cnt = tr1.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert("서버로부터 다음과 같은 오류 메시지를 출력했습니다.\n\n" + error_msg);
	    else
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
	</script>
	
	<script language="javascript" for="tr_save" event="OnSuccess()">
	    fnOnProgressEnd();
	    
	    if(ds_result.CountRow>0){
	        for(var i=1, j=1; i<=ds1.CountRow; i++){
	            if(ds1.RowStatus(i)==1){
	                ds1.NameValue(i, "CUST_SID")=ds_result.NameValue(j, "CUST_SID");
	                j++;
	            }
	        }
	    }
	    ds1.ResetStatus();
	    imgDs.ResetStatus();
	    
	    if(ds1.CountRow>0)
	        fnScreenDisplay(ds1.NameValue(ds1.RowPosition, "COUNTRY_GU"));
	    else
	        fnScreenDisplay("");
	
	    var info_cnt = tr_save.SrvErrCount("INFO");
	    var info_msg = "";
	    for(var i=0; i<info_cnt; i++){
	        info_msg += tr_save.SrvErrMsg("INFO", i) + "\n";
	    }
	    if(info_msg!="") 
	        alert("============= 안내 메시지=============\n\n" + info_msg);
	        
	</script>
	
	<script language="javascript" for="tr_save" event="OnFail()">
	    fnOnProgressEnd();
	    
	    var error_cnt = tr_save.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
	
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  조회중 
	%>
	<script language=JavaScript  for=ds1 event="OnLoadError()">
	</script>
	<script language=JavaScript  for=searchds4 event="OnLoadCompleted(row)">
		sAccpt_no.value = searchds4.namevalue(searchds4.rowposition,"ACCEPT_NO");
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		
	    fnOnProgressEnd();
	     
	    if (ds1.countrow == 2000) {
			alert("데이터는 "+ ds1.countrow + "건 이상 조회 할 수 없습니다!");
		}
	    if(v_job == "H") return;
	    if( row < 1){
	        alert(row + " 검색된 데이타가 없습니다."); 
	    }
	    
	    //비자유무체크
	    if(ds1.namevalue(row,"height")==1) {
			//alert(ds1.namevalue(row,"height"));
			//alert("1");
			height.checked=true;
		}
		else {
			height.checked=false;
		}
	</script>
	
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    imgDs.RowPosition = Row;
	    fnScreenDisplay(ds1.NameValue(Row, "COUNTRY_GU"));
	</script>
	
	<script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
	//alert("사진정보"+imgDs.NameValue(Row, "PICTURE_INFO")+"*");
	    if(Row<1) return;
	    if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
	        photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
	    else 
	        photo.src = "<%=dirPath%>/Sales/images/00000.gif";
	</script>
	
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
	        if(row==0){
	            if(ds1.CountRow==0) return;
	            
	            if(colid=="GROUP_CD"){
	                for(var i=1; i<=ds1.CountRow; i++){
	                    ds1.NameValue(i, "GROUP_CD") = ds1.NameValue(1, "GROUP_CD");
	                }
	            } 
	            return;
	        }
	 </script>
	 	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  데이터셋의 값을 체크박스로 연동
	%>

	<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
		if(ds1.namevalue(row,"height")==1) {
			height.checked=true;
		}
		else {
			height.checked=false;
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
	<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=gcds_data00 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds10 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object id=searchds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  신청서 번호 -->
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	    <param name="StatusResetType" value="2">
	</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="50px">
		<td>
			<table  border="0" cellpadding="0" cellspacing="0"  width="845px">
				<tr>
					<td colspan='8'>
						<table  width='345px' border="0" cellspacing="0" cellpadding="0" align="right">
							<tr>
								<td align='right'>
									<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
	<!--								<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">-->
									<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td ></td>
				</tr>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
							<tr>
								<td align="center" width="100px" height="30px" class="text" >대리점</td>
								<td align="left"  bgcolor="#ffffff" >&nbsp;
                                   <input type="text" name='sClientNm' id='sClientNm' value='<%=c_nm%>' size='20' readonly='readonly'  class='textbox'>
                                   <input type="hidden" name='sClientSid' id='sClientSid' value='<%=c_sid%>'>
                                   <%if(v_ut.equals("")){%>
                                   <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
                                   <%}%>
								</td>
								<td align="center" width="100px" height="30px" class="text" >신청서번호</td>
								<td align="left"  bgcolor="#ffffff" >&nbsp;
                                   <input type="text" name='sAccpt_no' id='sAccpt_no' value='' size='20'   class='textbox'>
                                   <img src="<%=dirPath%>/Sales/images/help.gif" border="0" 		ALT="신청서번호를  검색합니다"  style="cursor:hand"  onclick="javascript:fnAcceptNoPopup('<%=dirPath%>');" align='absmiddle'>
                                   <img src="<%=dirPath%>/Sales/images/n_create.gif" border="0" 	ALT="신청서번호생성"  		style="cursor:hand"  onclick="javascript:fnSelectAcceptNo();" align='absmiddle'>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="5px">
					<td></td>
				</tr>
				<tr>
					<td colspan='5'>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" width='845px'>
							<tr>
								<td align="center" width="100px" height="30px" class="text">고객구분</td>
								<td align="center" bgcolor="#ffffff">
									<%=HDConstant.COMMENT_START%>
									<object id=lc_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								<td align="center" width="100px"  class="text">국적구분</td>
								<td align="center" bgcolor="#ffffff">
									<%=HDConstant.COMMENT_START%>
                                       	<object id=lc_country classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds2>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								<td align="center" width="100px" class="text">고객명</td>
								<td align="center" bgcolor="#ffffff"><input type="text" name="sCustNm" value="" size="15" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>
								<td align="center" width="100px" class="text">주민/여권번호</td>
								<td align="center" bgcolor="#ffffff"><input type="text" name="sManegeNo" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="5px">
		<td></td>										
	</tr>
	<tr>
		<td width="845" colspan="6">
			<table border="0" cellpadding="1" cellspacing="0" width="100%" >
		  		<tr>
					<td  valign="top">
			  			<table border="0" cellpadding="0" cellspacing="1" width="300px" >
							<tr>
				 				<td>
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=302px; height:442px" border="1">
								    <param name="DataID"           value="ds1">
								    <param name="BorderStyle"      value="0">
								    <!-- param name="Fillarea"     value="true"-->
								    <param name="ColSizing"        value="true">
								    <param name="editable"         value="false">
								    <param name="viewsummary"      value="1">
								    <param name=SortView  value="Right">
				                    <param name="Format"            value=" 
				                        <FC>name='한글성명'       ID='CUST_NM'            Width=80  align=Left sort=true sumtext='계'</FC>
				                        <C> name='주민/여권번호'    ID='MANAGE_NO'          Width=120 align=Left sort=true sumtext=@cnt</C>
				                        <C> name='신청서번호'    ID='GROUP_CD'          Width=120 align=Left </C>
								        <C> name='인증'      	ID='REGI_YN_NAME'    	Width=60  align=center show=false </C>
								        <C> name='고객'      	ID='CUST_GU_NAME'    	Width=50  align=center show=false</C>
								        <C> name='국적'         ID='COUNTRY_CD' 	Width=50  align=center show=false</C>
								        <C> name='민족'       	ID='NATION_CD_NAME'     Width=40  align=center show=false</C>
								        <C> name='민족'       	ID='nation_cd'     	Width=40  align=center show=false</C>
								        <C> name='성별'  		ID='SEX_GU_NAME'        Width=40  align=center show=false</C>
								        <C> name='대리점명'    	ID='CLIENT_NM'  		Width=100 align=Left show=false</C>
   								        <C> name='비자유무'    	ID='HEIGHT'  			Width=100 align=Left show=false</C>
								        <C> name='국적명'    	ID='COUNTRY_NM'  		Width=100 align=Left show=false</C>
								        <C> name='민족명'    	ID='NATION_CD_NM'  		Width=100 align=Left show=false</C>
										<C> name='영문성'    	ID='LAST_NM'  		Width=100 align=Left </C>
										<C> name='영문이름'    	ID='FIRST_NM'  		Width=100 align=Left </C>
										<C> name='자택'    	ID='TEL_NO'  		Width=100 align=Left show=false</C>
										<C> name='핸폰'    	ID='MOBILE_NO'  		Width=100 align=Left show=false</C>
										<C> name='예판'    	ID='PRESERV'  		Width=100 align=Left show=false</C>
										<C> name='온천'    	ID='SPA_YN'  		Width=100 align=Left show=false</C>						 						 
								    ">
									</object>
									<%=HDConstant.COMMENT_END%>										
				  				</td>
							</tr>
			  			</table>
					</td>
					<td width="15px"></td>
					<td valign="top">
			  			<table border="0" cellpadding="0" cellspacing="0" width="530px" bgcolor="#666666">
							<tr width="530px" bgcolor="#ffffff">
				 		    	<td width="425px" valign="top" >
									<table border="0" cellpadding="0" cellspacing="1" width="425px" bgcolor="#666666">
										<tr bgcolor="#ffffff">
											<td width='130px' height='25px' class='boardt02'>국적구분</td>
											<td  align=absmiddle >&nbsp;&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=lc_country_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
												<param name=ComboDataID		value=initds1>
												<param name=BindColumn      value="detail">
												<param name=BindColVal      value="detail">
												<param name=ListExprFormat  value="detail_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>	
						                          <script language=JavaScript for=lc_country_gu event=OnSelChange()>
						                              if (lc_country_gu.Text != "") {
						                                  ds1.NameValue(ds1.RowPosition, "country_gu_name") = lc_country_gu.Text;
						                                  
						                                  fnScreenDisplay(lc_country_gu.ValueOfIndex("detail", lc_country_gu.Index));
						                              }
						                          </script>
											</td>
										  </tr>
										  <tr height='22px'>
								    		<td class='boardt02'>한글성명</td>
											<td bgcolor='#ffffff'>&nbsp;&nbsp; <input type=text name=txt_cust_nm id=txt_cust_nm size=30 class="textbox" OnKeyUp="cfLengthCheck(this, 30);"></td>
										  </tr>			
										  <tr id=inner_person style="display:inline">
											<td width='130px' height='22px'  class='boardt02'>주민번호</td>
											<td bgcolor='#ffffff'>&nbsp;&nbsp;
												<%=HDConstant.COMMENT_START%>
					                            <object id=regi_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
						                          <param name=Format      value="000000-0000000">
						                          <param name=Alignment   value=1>
						                          <param name=ClipMode    value=true>
						                          <param name=Border      value=false>
						                          <param name=MaxLength   value="13">
						                          <param name=SelectAll   value=true>
						                          <param name=SelectAllOnClick      value=true>
						                          <param name=SelectAllOnClickAny   value=false>
					                            </object>
					                            <%=HDConstant.COMMENT_END%>
					                              <script language=javascript for=regi_no event="OnKillFocus()">
					                                  if(getObjectFirst("regi_no").Text!="" && fnJuminNoCheck(getObjectFirst("regi_no").Text)!=true) {
					                                      getObjectFirst("birthday").Text = "";
					                                      getObjectFirst("regi_no").Text = "";
					                                      getObjectFirst("regi_no").Focus();
					                                      return;
					                                  }
					                                  if(getObjectFirst("regi_no").Text.length==13){
					                                      var v_sex_gubn = getObjectFirst("regi_no").Text.substr(6, 1);
					                                      if(v_sex_gubn=="1" || v_sex_gubn=="2")
					                                          getObjectFirst("birthday").Text = "19" + getObjectFirst("regi_no").Text.substr(0, 6);
					                                      else 
					                                         getObjectFirst("birthday").Text = "20" + getObjectFirst("regi_no").Text.substr(0, 6);
					                                      
					                                      if(v_sex_gubn=="1" || v_sex_gubn=="3") ds1.NameValue(ds1.RowPosition, "SEX") = "M";
					                                      else ds1.NameValue(ds1.RowPosition, "SEX") = "F";
					                                  }
					                              </script>
													&nbsp;&nbsp;
                           					</td>
					 					 </tr>	
					  					 <tr>
											<td width='130px' height='22px'  class='boardt02'>여권번호</td>
											<td bgcolor='#ffffff'>&nbsp;&nbsp;
												<%=HDConstant.COMMENT_START%>
					                            <object id=pass_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
					                              <param name=Format      value="###############">
					                              <param name=Alignment   value=1>
					                              <param name=ClipMode    value=true>
					                              <param name=UpperFlag   value=1>
					                              <param name=Border      value=false>
					                              <param name=MaxLength   value="15">
					                              <param name=SelectAll   value=true>
					                              <param name=SelectAllOnClick      value=true>
					                              <param name=SelectAllOnClickAny   value=false>
						                        </object>
						                        <%=HDConstant.COMMENT_END%>
											</td>
					 					 </tr>
										  <tr>
											<td width='130px' height='25px'  class='boardt02'>여권종류</td>
											<td width='290px' bgcolor='#ffffff'>
					                        	<table border=0 cellspacing=0 cellpadding=0>
						                          <tr>
						                            <td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
						                              <%=HDConstant.COMMENT_START%>
						                              <object id=lc_pass_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
						                                  <param name=ComboDataID     value=initds6>
						                                  <param name=BindColumn      value="detail">
						                                  <param name=BindColVal      value="detail">
						                                  <param name=ListExprFormat  value="detail_nm^0^150">
						                              </object>
						                              <%=HDConstant.COMMENT_END%>
						                              <script language=JavaScript for=lc_pass_type event=OnSelChange()>
						                                  if (lc_pass_type.Text != "")
						                                      ds1.NameValue(ds1.RowPosition, "pass_type_name") = lc_pass_type.Text;
						                              </script>
					                          		</td>       
							                        <td bgcolor='#ffffff' height='22px' class='boardt02'>여권만기일
							                        </td>
						                          <td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
						                              <%=HDConstant.COMMENT_START%>
						                              <object id=pass_expire_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>            
						                                  <param name=Format      value="YYYY-MM-DD">
						                                  <PARAM NAME=InputFormat value="YYYYMMDD">
						                                  <param name=Alignment   value=1>
						                                  <param name=ClipMode    value=true>
						                                  <param name=Border      value=false>
						                                  <param name=SelectAll   value=true>
						                                  <param name=SelectAllOnClick      value=true>
						                                  <param name=SelectAllOnClickAny   value=false>
						                              </object>
						                              <%=HDConstant.COMMENT_END%>
						                       		</td>
					                          	</tr>
					                        </table>
					                      </td>
					                    </tr>
					                  <tr>
											<td width='130px' height='22px'  class='boardt02'>생년월일</td>
											<td bgcolor='#ffffff'>&nbsp;&nbsp;
						                    	<%=HDConstant.COMMENT_START%>
						                        	<object id=birthday classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>            
						                            	<param name=Format      value="YYYY-MM-DD">
						                                <PARAM NAME=InputFormat value="YYYYMMDD">
						                                <param name=Alignment   value=1>
						                                <param name=ClipMode    value=true>
						                                <param name=Border      value=false>
						                                <param name=SelectAll   value=true>
						                                <param name=SelectAllOnClick      value=true>
						                                <param name=SelectAllOnClickAny   value=false>
						                            </object>
						                        <%=HDConstant.COMMENT_END%> 
						                      </td>																		
										</tr>
					                    <tr>
					                        	<td width='130px' class='boardt02'>신청서번호</td>
					                            <td  bgcolor='#ffffff'>&nbsp;&nbsp;
					                            	<input type="text" name='group_cd' id='group_cd' value='' class='textbox' size='15'>
					                                	<img src="<%=dirPath%>/Sales/images/apply.gif" border="0" ALT="신청서번호를 적용합니다"  style="cursor:hand"  onclick="javascript:fnAcceptApply();" align='absmiddle'>
					                            </td>
					                        </tr>
					                      </table>
					                    </td>
					                  </tr>
									  <tr height="2px"  bgcolor="#ffffff">
										<td bgcolor="#ffffff" colspan="3"></td>
									  </tr>
									  <tr >
										<td width="530px" colspan="3">
											<table border="0" cellpadding="0" cellspacing="1" width="530px">
												<tr>
													<td width='130px' class='boardt02'>성별</td>
													<td bgcolor='#ffffff'>&nbsp;&nbsp;
														<%=HDConstant.COMMENT_START%>
															<object id=lc_sex classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=93 border="0" align=absmiddle>
																<param name=ComboDataID		value=initds3>
					                                            <param name=BindColumn      value="detail">
					                                            <param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^100">
															</object>
														<%=HDConstant.COMMENT_END%>
						                                  <script language=JavaScript for=lc_sex event=OnSelChange()>
					    	                                  if (lc_sex.Text != "")
					        	                                  ds1.NameValue(ds1.RowPosition, "sex_gu_name") = lc_sex.Text;
					            	                      </script>
													</td>		
													<td width='130px' class='boardt02'>비자유무</td>
													<td bgcolor='#ffffff'>&nbsp;&nbsp;
														<input id="height" type="checkbox" class=""  style= "position:relative;left:0px;top:0px;width:18px; height:20px;" onclick="fnCheckbox()">
													</td>
													<td bgcolor='#ffffff' height='23px'>
														<input type="hidden" name='lc_cust_gu' id='lc_cust_gu' value="1">
													</td>
												</tr>
												<tr>
													<td width='130px' class='boardt02'>영문성</td>
													<td bgcolor='#ffffff'>&nbsp;&nbsp;
														  <%=HDConstant.COMMENT_START%>
							                                  <object id=last_nm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='93px' align='absmiddle' class='textbox'>            
							                                      <param name=Format      value="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ">
							                                      <param name=Alignment   value=1>
							                                      <param name=ClipMode    value=true>
							                                      <param name=Border      value=false>
							                                      <param name=SelectAll   value=true>
							                                      <param name=SelectAllOnClick      value=true>
							                                      <param name=SelectAllOnClickAny   value=false>
							                                      <param name=UpperFlag   value=1>
							                                  </object>
							                              <%=HDConstant.COMMENT_END%>
													</td>		
													<td width='130px' class='boardt02'>영문이름
													</td>
													<td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
									        			<%=HDConstant.COMMENT_START%>
					                        		          <object id=first_nm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
					                                		      <param name=Format      value="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ">
							                                      <param name=Alignment   value=1>
					        		                              <param name=ClipMode    value=true>
					                		                      <param name=Border      value=false>
					                        		              <param name=SelectAll   value=true>
					                                		      <param name=SelectAllOnClick      value=true>
							                                      <param name=SelectAllOnClickAny   value=false>
					        		                              <param name=UpperFlag   value=1>
					                		                  </object>
					                            	      <%=HDConstant.COMMENT_END%>
													</td>
												</tr>	
													<td width='130px' class='boardt02'>핸드폰</td>
													<td bgcolor='#ffffff'>&nbsp;&nbsp;
														<%=HDConstant.COMMENT_START%>
					                                    	<object id=mobile_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='93px' align='absmiddle' class='textbox'>            
						                                        <param name=Format      value="99999999999999999999">
					                                            <param name=Alignment   value=1>
					                                            <param name=ClipMode    value=true>
					                                            <param name=Border      value=false>
					                                            <param name=SelectAll   value=true>
					                                            <param name=SelectAllOnClick      value=true>
					                                            <param name=SelectAllOnClickAny   value=false>
					                                            <param name=UpperFlag   value=1>
					                                        </object>
					                                    <%=HDConstant.COMMENT_END%>
													</td>
											<td width='130px' class='boardt02'>대리점</td>
											<td bgcolor='#ffffff' >&nbsp;&nbsp;
			             		                      <input type="text" name='client_nm' id='client_nm' value='' size='11' readonly='readonly'  class='textbox'>
			                                          <input type="hidden" name='client_sid' id='client_sid' value=''>
 		                      	                      <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="대리점를  검색합니다"  style="cursor:hand"  id="client_btn" onclick="javascript:fnClientPopup('<%=dirPath%>');" align='absmiddle'>
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
	<%=HDConstant.COMMENT_START%>
	     <object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="imgDs">
	             <param name=BindInfo    value="
	                <C>Col=PICTURE_INFO     Ctrl=gcip_file          Param=value</C>
	                <C>Col=PICTURE_URL      Ctrl=gcip_file          Param=value</C>
	              ">
	      </object>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds1">
	             <param name=BindInfo    value="
	                <C>Col=group_cd         Ctrl=group_cd           Param=Value</C>
	                <C>Col=height           Ctrl=height              Param=Checked</C>
	                <C>Col=regi_no          Ctrl=regi_no            Param=Text</C>
	                <C>Col=regi_yn_t        Ctrl=lc_regi_yn	 	    Param=BindColVal </C>
	                <C>Col=cust_gu          Ctrl=lc_cust_gu         Param=Value</C>
	                <C>Col=country_gu       Ctrl=lc_country_gu      Param=BindColVal </C>
	                <C>Col=saup_gu          Ctrl=lc_saup_gu         Param=BindColVal</C>
	                <C>Col=cust_type        Ctrl=lc_cust_type       Param=BindColVal </C>
	                <C>Col=CUST_NM          Ctrl=txt_cust_nm        Param=Value</C>
	                <C>Col=last_nm          Ctrl=last_nm            Param=Text</C>
	                <C>Col=first_nm         Ctrl=first_nm           Param=Text</C>
	                <C>Col=country_cd       Ctrl=country_cd         Param=Value</C>
	                <C>Col=nation_cd        Ctrl=lc_nation          Param=Value </C>
	                <C>Col=birthday         Ctrl=birthday            Param=Text</C>
	                <C>Col=sex              Ctrl=lc_sex             Param=BindColVal</C>
	                <C>Col=tel_no           Ctrl=tel_no             Param=Text</C>
	                <C>Col=mobile_no        Ctrl=mobile_no          Param=Text</C>
					<C>Col=zip_sid           Ctrl=zip_sid             Param=Value</C>                
	                <C>Col=zip_cd           Ctrl=zip_cd             Param=Text</C>
	                <C>Col=address1         Ctrl=txt_address1       Param=value</C>
	                <C>Col=address2         Ctrl=txt_address2       Param=value</C>
	                <C>Col=eng_zip_cd       Ctrl=eng_zip_cd         Param=Text</C>
	                <C>Col=eng_addr1        Ctrl=txt_eng_addr1      Param=value</C>
	                <C>Col=pass_type        Ctrl=lc_pass_type       Param=BindColVal</C>
	                <C>Col=pass_no          Ctrl=pass_no            Param=Text</C>
	                <C>Col=pass_expire_date Ctrl=pass_expire_date   Param=Text</C>
	                <C>Col=company_nm       Ctrl=txt_company_nm         Param=Value</C>
	                <C>Col=positions        Ctrl=txt_positions          Param=Value</C>
	                <C>Col=eng_company_nm   Ctrl=eng_company_nm     Param=Text</C>
	                <C>Col=eng_position     Ctrl=eng_position       Param=Text</C>
	                <C>Col=north_cnt        Ctrl=north_cnt          Param=Text </C>
	                <C>Col=client_sid       Ctrl=client_sid       Param=Value</C>
	                <C>Col=client_nm		Ctrl=client_nm			Param=Value</C>
	                <C>Col=country_nm       Ctrl=country_nm       Param=Value</C>
	                <C>Col=nation_cd_nm       Ctrl=lc_nation_nm       Param=Value</C>
	                <C>Col=job_cd			Ctrl=lc_job_gu			Param=BindColVal</C>
	
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%>      

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

