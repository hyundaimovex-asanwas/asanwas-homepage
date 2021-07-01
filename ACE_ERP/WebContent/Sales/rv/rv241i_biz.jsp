<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 홈>관광영업>사업자 출입관리>출입 정보>방북신청(요금)
 *				  홈>관광영업>정산관리>매출 관리>사업자 요금정산[단기]
 * J  S  P      : Rv241I,AC120I
 * 서 블 릿     : AC120I
 * 작 성 자     : 심동현
 * 작 성 일     : 2006-08-10
 * 기능정의     :  적용객실 요금 수정
 * [수정  일자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-12-28][심동현] 요금계산 버튼 추가
 *						일반사업자는 유형따라 적용 : 유형에서 숙박옵션 수정 가능
 *						초청사업자는 초청유형만    : 관광요금 적용 <- 카운트의 기준으로 입력하
 *						사업구분(saup_gu) 및 할인유형(cust_type) 수정 가능?
 * [2010-03-02][심동현] GRID 싹 수정
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
    //date.set(java.util.Calendar.HOUR_OF_DAY, 240);
    String firstday = m_today.format(date.getTime());
    date.add(java.util.Calendar.DATE, +2);
    String endDay = m_today.format(date.getTime());

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
        var v_accept_sid = "";
        var v_job="";        
        
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩
// Parameter    :
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

        fnInit();

        codeDs1.deleterow(1);
        codeDs3.deleterow(1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : 선조회
// Parameter    :
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		v_job="I";
		
		// 상품정보
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_ARRIVE_GOODS_DS=codeDs7)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);



            //할인유형(cust_type)	
            // 사업자만 조회되므로 여기서도 관광객에 해당하는 것만 나오게..수정하자
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3"
							+"&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+"&s_Head=RV003"
							+"&s_item1=Y"	// 사용 Y
							+"&s_item4=Y";	// 사업자 Y. 
            codeDs1.Reset();
			//숙박비/식비 부과여부
            codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY010&s_item1=Y";
            codeDs2.Reset();
            //정산시기
            codeDs3.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV036&s_item1=Y";
            codeDs3.Reset();
            //정산담당
            codeDs4.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV035&s_item1=Y";
            codeDs4.Reset();

		getObjectFirst("sSDate").focus();	
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    :
%>
    function fnSelect() {
        v_job = "S";
    	if (getObjectFirst("sAcceptNo").Text.trim() =="" && getObjectFirst("sSDate").Text.trim() =="") {
	    	alert ("신청서 번호 또는 출발일을 입력하세요!");
	    	return;
    	}

    	v_accept_sid = getObjectFirst("v_accept_sid").value;

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sSDate="+getObjectFirst("sSDate").Text
                    + ",sAcceptNo="+getObjectFirst("sAcceptNo").Text
                    + ",sRoomType=" + getObjectFirst("sRoomType").Text
                    + ",sPrice=" + getObjectFirst("sPrice").Text
                    + ",sCustNm="+getObjectFirst("sCustNm").value
                    + ",v_out_gubn="+ v_out_gubn.value
                    + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
                    + ",sClientSid="+ sClientSid.value;

        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv241I",
            "JSP(O:DEFAULT=ds1)",
            v_param);


        tr_post(tr1);

        if ( ds1.CountRow > 0) {
				if(ds1.namevalue(ds1.RowPosition,"ACCT_CLOSE_YN") == 'Y' ){
				gr1.Editable = 'false';
				}else{
				gr1.Editable = 'true';
				}
			}

		if(getObjectFirst("sAcceptNo").Text == "" ){
            getObjectFirst("save_amt_btn").style.display = "none";
            }
    }

   /**
     * 적용 함수
     */
    function fnApply() {
    	v_job="A";
    	
        if (ds1.IsUpdated) {
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv241I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr1);
        } else {
            alert("변경 내역이 없습니다.");
        }
    }

    //판매가 계산 로직
    function fnSaveAmt(){
        v_job = "C";

        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv241I",
            "JSP(O:DS2=ds_result)",
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,v_accept_sid="+v_accept_sid);
        tr_post(tr2);
    }
  
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  엑셀 파일 출력
// Parameter    :
%>
    function fnExcel() {
        if(ds1.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:판매 객실료 수정; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("판매 객실료 수정", "판매 객실료 수정.xls", 8);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  협력업체팝업
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnClientPop("<%=dirPath%>", "");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            sClientSid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          sClientSid.value = "";
        }
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  신청서 번호 조회
%>
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop1("<%=dirPath%>",getObjectFirst("sSDate").Text);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("sAcceptNo").Text   = arrParam[1];
        } else {
            getObjectFirst("v_accept_sid").value = 0;
            getObjectFirst("sAcceptNo").Text   = "";
            getObjectFirst("save_amt_btn").style.display = "none";
            }
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  객실타입
%>
    function fnRoomTypePopup(){
        var arrResult   = new Array();

        var arrParam = "";
   		var strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
    	var strPos = "dialogWidth:495px;dialogHeight:389px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,arrParam,strPos);

        if (arrResult != null) {

            arrParam = arrResult.split(";");
            getObjectFirst("sRoomType").Text = arrParam[1];

        }
    }
<%
////////////////////////////////////////////////////////////////////////////////
// Description 입금방법 구분 팝업
%>

 function fnConfirmView(dir) {
	var arrParam    = new Array();
    var arrResult   = new Array();

	var pay_sid = ds_detail.namevalue(ds_detail.rowposition, "PAY_SID1");
	var pay_manage_no = ds_detail.namevalue(ds_detail.rowposition, "PAY_MANAGE_NO");



		if (pay_sid == "020") { // 가상계좌
			var strURL = dir+"/Sales/help/rv007h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "030") { // 계좌이체
			var strURL = dir+"/Sales/help/rv008h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "040") { // 신용카드
			var strURL = dir+"/Sales/help/rv009h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "060") { // 상품권
			var strURL = dir+"/Sales/help/rv010h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else {
			return;
		}

    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

    arrResult =  showModalDialog(strURL,arrParam,strPos);

    }
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds_goods" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_result" event="OnLoadCompleted(row)">

	if(row==0)
		return;

	var alert_msg = "";
	for(var i=1; i<=row; i++){
		if(ds_result.NameValue(i, "MSG_CD")!="0000")
			alert_msg += ds_result.NameValue(i, "MSG") +"\n";
	}

	if(alert_msg!="")
		alert(alert_msg);
/*	else {
		alert("판매가 계산이 완료되었습니다.");
		fnSelect();
	}*/

</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>

<script language=javascript for="gr1" event="OnClick(Row, Colid)">
// 제목 선택할 때.. 전체 변경 가능한 이벤트
        if(Row==0){
            if(ds1.CountRow==0) return;

            if(Colid=="CUST_TYPE"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="STAY_YN"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="MEAL_YN"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="PAY_PRE"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }
            if(Colid=="PAY_SAUP"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                }
            }                                    
            return;
        }
</script>

<script language="javascript"  for="gr1" event=OnCloseUp(row,colid)>
// 룩업 컬럼을 선택 (할인유형) 하고 닫힐 때 발생하는 이벤트 : 20071031
//	if(colid=="CUST_TYPE"){
//		alert("Occur OnCloseUp Event :" + "<ROW :" + row +">"+ "<Colid :" + colid+ ">" );
//		alert(ds1.NameValue(row,"CUST_TYPE"));
//		gr1.ColumnProp("TOT_TOUR_AMT","Edit")=1; //되긴 하는군
//	};
</script>



<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    if(row==0){
    	v_accept_sid = "";
    	getObjectFirst("save_amt_btn").style.display = "none";
//    	getObjectFirst("pre_rsv_btn").style.display = "none";
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }

    if(v_accept_sid!=""){
    	getObjectFirst("save_amt_btn").style.display = "inline";
//    	getObjectFirst("pre_rsv_btn").style.display = "inline";
    }
</script>


<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="")
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

	var alert_msg = "";
	
	for(var i=1; i<=ds_result.CountRow; i++){
		if(ds_result.NameValue(i, "MSG_CD")!="0000")
			alert_msg += ds_result.NameValue(i, "MSG") +"\n";
	}

	if(alert_msg!="")
		alert(alert_msg);
	else {
		if(v_job =="C"){
			alert("판매가 계산이 완료되었습니다.");
		}
		if(v_job =="P"){
			alert("예약판매 체크가 완료되었습니다.");
		}
	
		fnSelect();
	}
    	
    ds_result.ClearAll();
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="")
        alert(error_msg);							//20070619 : 정산마감인 경우 여기서 메세지 띄워줍니다.
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>



<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/prize_cal.gif" style="cursor:hand;display:none" id="save_amt_btn" onClick="fnSaveAmt()">
                        <img src="<%=dirPath%>/Sales/images/price_chk.gif" style="cursor:hand;display:none" id="pre_rsv_btn" onClick="fnPreRsv()">
                        <img src="<%=dirPath%>/Sales/images/btn_northcount.gif" style="cursor:hand;display:none" onClick="fnNorthCnt()">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="80px" height="25px" class="text">출발일자</td>
                                <td align="center" bgcolor="#ffffff" width="73px">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sSDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>  height='16px' width=67 align=center class='textbox'>
                                        <param name=Format      value="YYYY-MM-dd">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td align=left class="text" width="70" height="25px">상품정보</td>
			                      <td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
			                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=150 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs7>
										<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
										<param name=ListExprFormat  value="goods_nm^0^140">
                              </object>
									<%=HDConstant.COMMENT_END%>&nbsp;
								</td>
                                <td width="80px" height="25px" class="text">신청서번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sAcceptNo classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="00000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Enable      value=false>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
                                <td width="80px" height="25px" class="text">객실타입</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;
                                <%=HDConstant.COMMENT_START%>
                                    <object id=sRoomType classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='80px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="AAAAA">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;
                                     <%=HDConstant.COMMENT_END%>
                                     <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="javascript:fnRoomTypePopup()" id="v_accept_btn">
                                </td>

                            </tr>
                            <tr>
								 <td width="80px" height="25px" class="text">판매가</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sPrice classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width=67 align=center class='textbox'>
                                        <param name=Format      value="##########">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                     <%=HDConstant.COMMENT_END%>

                                </td>
                                <td width="80px" height="25px" class="text">성명</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                                <td align=left class="text" width='80'>출경구분</td>
	                            <td align=left bgcolor="#ffffff" valign="middle" >&nbsp;
	                                <select name="v_out_gubn" id="v_out_gubn" class="textbox">
	                                    <option value="">전체
	                                    <option value="Y">출경
	                                    <option value="N">미출경
	                                </select>
	                            </td>
	                            <td width="80px" height="25px" class="text">협력업체</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="대리점을 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                    <input type="hidden" value="" id="sClientSid" readOnly>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=845>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:400px" border="1">
                            <param name="DataID"            value="ds1">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
							<param name=SortView  		      value="Right">
                            <param name="Format"            value="
                        		<C> name='협력\\업체명'	ID='CLIENT_NM'      Width=80	align=Left     Sort=True  Edit=none  BgColor=#fefec0 suppress=1</C>
								<C> name='출경\\일자'	ID='DEPART_DATE'	Width=70   	align=Center 	Edit=none  BgColor=#fefec0 mask='XXXX-XX-XX' suppress=2</C>
								<C> name='출경\\시각'	ID='DEPART_TIME'    Width=40   	align=Center 	Edit=none  BgColor=#fefec0 mask='XX:XX' suppress=3</C>
								<C> name='입경\\일자'	ID='ARRIVE_DATE'    Width=70   	align=Center 	Edit=none  BgColor=#fefec0 mask='XXXX-XX-XX' suppress=4</C>
								<C> name='입경\\시각'	ID='ARRIVE_TIME'    Width=40   	align=Center 	Edit=none  BgColor=#fefec0 mask='XX:XX' suppress=5</C>
								<C> name='성명'           	ID='CUST_NM'         Width=50   	align=Left 	   Sort=True  Edit=none  BgColor=#fefec0 sumtext='총'</C>
								<C> name='주민 /\\여권번호'	ID='MANAGE_NO'       Width=90	   align=Left 	   Edit=none  BgColor=#fefec0  Sort=True sumtext=@cnt</C>
								<C> name='객실타입'		ID='ROOM_TYPE_CD'	Width=55	align=center  Edit=none  BgColor=#fefec0 </C>
								<C> name='고객 유형√'	ID='CUST_TYPE'      Width=80	align=Left editstyle=lookup data='codeDs1:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}  </C>
								<C> name='숙박비\\부과√' ID='STAY_YN'       Width=45	   align=center editstyle=lookup data='codeDs2:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}  </C>
								<C> name='식비\\부과√'	ID='MEAL_YN'       Width=45	   align=center editstyle=lookup data='codeDs2:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}  </C>
							<G> name='정산'
								<C> name='시기√'		ID='PAY_PRE' 		Width=45 	align=left	editstyle=lookup data='codeDs3:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}  </C>
								<C> name='담당√'     	ID='PAY_SAUP'   	Width=45   	align=Left	editstyle=lookup data='codeDs4:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}  </C>
							</G>
								<C> name='방문비용'		ID='TOT_TOUR_AMT'  	Width=65   	align=Right    SumText=@sum  Decao=0 BgColor='#fefec0' Edit=none </C>
							<G> name='비용상세'
								<C> name='방북지원'		ID='BIZ_AMT4'  		Width=60   	align=right BgColor='#fefec0' decao=0 Edit=none </C>
								<C> name='도로교통'		ID='BIZ_AMT3'   	Width=60   	align=right BgColor='#fefec0' decao=0 Edit=none </C>
								<C> name='식대'      	ID='BIZ_AMT2'  	   	Width=60   	align=right BgColor='#fefec0' decao=0 Edit=none </C>
								<C> name='식수'      	ID='BIZ_QTY2'  	   	Width=40   	align=right BgColor='#fefec0' decao=0 Edit=none </C>
								<C> name='숙박비'    	ID='BIZ_AMT1'  		Width=60   	align=right BgColor='#fefec0' decao=0 Edit=none </C>
								<C> name='박수'			ID='BIZ_QTY1'  		Width=40   	align=right BgColor='#fefec0' decao=0 Edit=none </C>
							</G>								
								<C> name='입금액'		ID='TOT_PAY_AMT'   	Width=65   	align=Right    Edit=none  BgColor=#fefec0 SumText=@sum   Decao=0</C>
								<C> name='방문\\목적'	ID='NORTH_PURPOSE'	width=65	align=left 	show=true edit=none BgColor=#fefec0  </C>
                        		<C> name='협력업체'  	ID='CLIENT_NM'      Width=90    align=Left     Sort=True  Edit=none  BgColor=#fefec0 </C>
								<C> name='신청서번호'	ID='ACCEPT_NO'		Width=91    align=Left 	   Edit=none  BgColor=#fefec0 </C>
								<C> name='동행자'       ID='M_CUST_NM'		Width=60   	align=Left 	   Sort=True  Edit=none  BgColor=#fefec0 </C>
								<C> name='관계'         ID='JOIN_NM'		Width=45   	align=center	Edit=none  BgColor=#fefec0 </C>
								<C> name='상품'         ID='GOODS_SID'		Width=70  	align=Left 		editstyle=lookup data='codeDs7:goods_sid:goods_nm'    BgColor=#fefec0 edit=none </C>
								<C> name='예약\\상태'   ID='STATUS_NM'    	Width=55   	align=center	Edit=none  BgColor=#fefec0  </C>
								<C> name='정산\\마감'	ID='ACCT_CLOSE_YN'	width=45 	align=center	edit=none  BgColor=#fefec0</C>
								<C> name='입력자'		ID='i_empnm'		width=60	align=center	edit=none  BgColor=#fefec0  </C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
                <tr>
                    <td><BR>　■ <b>사업자<b>만 조회됩니다.<BR>
                    	　■ 신청서번호가 있는 경우에만 [판매가계산] 버튼이 나타납니다.<BR>
                    	　■ 입경일자, 입경시각, 객실타입, 동숙여부 등은 방북신청 화면에서 수정하셔야 합니다.<BR>
                    	　■ 금강산: "고객유형", "숙박비 부과여부", "식비부과여부", "객실타입"에 따라 비용이 결정됩니다.<BR>
                    	　■ 개　성: "출입수속비"는 방북지원 칸에, "출입증 수수료"는 도로교통 칸에 표시되며, 예약상태에 따라 자동으로 계산됩니다.<BR>
						<BR>
                    	

                    </td>
                </tr>
                
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

