<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 관광 요금 결재
 * 프로그램ID 		: RV310I
 * J  S  P		: Rv310i
 * 서 블 릿		: Rv310i
 * 작 성 자		: 김영민
 * 작 성 일		: 2006-06-28
 * 기능정의		: 관광 요금 결재
 * 수정내용		: 
 * 수 정 자		: 김영민
 * 최종수정일자 	: 2006-06-28 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-12-24][심동현] 지역조건 추가...
 * [2008-05-10][심동현] 조회하여 보증금잔금 대체가 마무리되지 않은 경우 결제선택 불가
 * [2009-03-27][심동현] 이름 컬럼 소트 추가.. 필요한 경우 다음에 조회 순서 조정..
 * [2010-01-14][심동현] 결제창 팝업시 파라미터 추가 = 선택된 관광객명
 * [2010-06-08][박경국] 조회조건에 [상품순번][결제순번] 추가. 조회된 컬럼에 [결제순번] 추가.
 * [2010-06-14][정하나] 결제액 첫번째 row 금액 입력 후 클릭시, 전체 ,row 적용
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
    
    String startDay = m_today.format(date.getTime());           
    date.add(java.util.Calendar.DATE, +2);
    String endDay = m_today.format(date.getTime());

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
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
		<script language="javascript">
		var div='';

	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		div = 'init';
			fnInit(); 
		}

		function fnInit(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
            getObjectFirst("ds_goods").Reset();

			codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs1.Reset(); //지역코드
           
		}

		function fnSelect() {
            /*if(getObjectFirst("v_client_sid").value==""){
                alert("대리점을 먼저 검색하시길 바랍니다.");
                return;
            }*/
            
            if(getObjectFirst("v_depart_date1").Text.trim()=="" || getObjectFirst("v_depart_date1").Text.trim().length!=8){
                alert("출발일자 (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date1").Focus();
                return;
            }
            
            /*if(getObjectFirst("v_depart_date2").Text.trim()=="" || getObjectFirst("v_depart_date2").Text.trim().length!=8){
                alert("출발일자 (To) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date2").Focus();
                return;
            }*/
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                        + ",v_depart_date1="+getObjectFirst("v_depart_date1").Text
                        + ",v_depart_date2="+getObjectFirst("v_depart_date1").Text
                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                        + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
	      		        + ",v_pay_seq=" + v_payseq.ValueOfIndex("pay_seq", v_payseq.Index)
                        + ",v_cust_nm="+getObjectFirst("v_cust_nm").value
                        + ",v_pay_gubn="+getObjectFirst("v_pay_gubn").value
   	                    + ",v_saup_sid=" + v_saup_sid.ValueOfIndex("saup_sid", v_saup_sid.Index);
            
            if(getObjectFirst("v_cancel_yn").checked)
                v_param = v_param + ",v_cancel_yn=RC";
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv310I",
                "JSP(O:DEFAULT=ds1)",
                v_param);
            tr_post(tr1);
		}

		function fnApply() {
		}

    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            v_client_sid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          v_client_sid.value = "";
        }               
    }
    /**
     * 신청서 번호 조회
     */
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop("<%=dirPath%>");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
        }
    }
    //상품순번
		function fnSelectBound(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                  + ",v_accept_no=" + v_accept_no.Text;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
	            "JSP(O:DS_BOUND=ds_bound)",
	            param);
	           
	        tr_post(tr1);
	    }
	    
		//결제순번
		function fnSelectPayseq(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                  + ",v_accept_no=" + v_accept_no.Text
				          + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
		                  ;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
	            "JSP(O:DS_PAYSEQ=ds_payseq)",
	            param);
	        tr_post(tr1);
	    }
	    

	//요금 결제버튼
    function fnAccount() {
        var v_sel_cnt = 0;
        var v_account_amt = 0;
        var v_client_cd = "";
        var v_client_sid = "";
        
        if(getObjectFirst("ds1").CountRow==0){
            alert("먼저 조회후 클릭하시길 바랍니다.");
            return;
        }
        
        for(var i=1; i<=getObjectFirst("ds1").CountRow; i++){
            if((getObjectFirst("ds1").NameValue(i, "JOB_SEL")=="T")	|| (getObjectFirst("ds1").NameValue(i, "JOB_SEL2")=="T")){
                v_sel_cnt++;
                v_account_amt += getObjectFirst("ds1").NameValue(i, "PAY_AMT");
                v_client_cd = getObjectFirst("ds1").NameValue(i, "CLIENT_CD");
                v_client_sid = getObjectFirst("ds1").NameValue(i, "CLIENT_SID");
                
              
              
              
                if(getObjectFirst("ds1").NameValue(i, "PAY_AMT")==0){
                    alert("결재할 금액을 입력하시길 바랍니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                }
                
                if(eval(getObjectFirst("ds1").NameValue(i, "PAY_AMT"))>eval(getObjectFirst("ds1").NameValue(i, "ARREARS_AMT"))){
                    alert("결재할 금액이 현재 미납액 보다 더 많은 금액입니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                }
               
                if(getObjectFirst("ds1").NameValue(i, "AFTER_CU")=="1"){
                	// 1. 단체인원 선정산일 경우
                	// 2. 단체인원 선정산이면서 결제액+입금액이 계약금보다 작을 경우에는 경고창을 띄운다. 
                   	if((eval(getObjectFirst("ds1").NameValue(i, "PAY_AMT"))+eval(getObjectFirst("ds1").NameValue(i, "TOT_PAY_AMT")))<eval(getObjectFirst("ds1").NameValue(i, "DEPOSIT_AMT"))){
                    alert("계약금보다 적은 금액입니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                	}
                }
            }
        }
        
        if(v_sel_cnt==0){
            alert("선택된 내역이 없습니다.");
            return;
        }
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var v_pay_manage_no ="";
        var v_pay_date = "<%=DateUtil.getCurrentDate(8)%>";	//여기서 입금일자 디폴트 세팅을 해부리네..우씨.. 페이지 로드 타이밍의 날짜를 가지고 있음!! 켜놓고 다음 날 결제 시 ACCEPT_DATE와 PAY_DATE가 달라지게 됨..;
        var v_pay_cd = "";
        var v_plan_pay_date = "";   //입금예정일자
        
        /**결재 항목
         * arrParam[0]
         * 0 : 가상계좌 이체
         * 1 : 계좌이체 (사용안함)
         * 2 : 신용카드
         * 3 : 상품권결제
         * 4 : 무통장입금
         * 5 : 기타대체
         * 6 : 신용카드 Online
         */
		//직원용
        arrParam[0] = "1011101";
		//대리점용
//        arrParam[0] = "1010000";
        arrParam[1] = v_client_cd;
        arrParam[2] = v_account_amt;
        arrParam[3] = ds1.NameValue(ds1.RowPosition, "GOODS_NM");
        
        arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";     //단말기번호
        arrParam[5] = "<%=HDConstant.KCP_TERM_ID%>";    //계좌이체 및 가상계좌 터미널 ID
        arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP%>";  //계좌이체 및 가상계좌 가맹점 번호
        arrParam[7] = v_client_sid;                     //대리점 Sid
        arrParam[8] = ds1.NameValue(ds1.RowPosition, "CUST_NM");
//prompt("","<%=dirPath%>");
//prompt("",arrParam);

		//여기서 결제창 팝!
        arrResult = fnCreditPop("<%=dirPath%>", arrParam);
//alert("arrResult : " + arrResult);	여기서는 제대로 받아오는 무통입금일자..



		//결제 후 리턴 값으로 업데이트 하는 부분.. 
        if(arrResult!=null && arrResult!=undefined){
            arrParam = arrResult.split(":");
            v_pay_cd = arrParam[0];
            v_pay_manage_no = arrParam[1];
            if(arrParam.length>2)
                v_plan_pay_date = arrParam[2];
            
//alert("arrParam : " + arrParam + " v_pay_cd : " +  v_pay_cd + " v_pay_manage_no : " + v_pay_manage_no);
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_client_cd="+v_client_cd
                        + ",v_pay_manage_no="+v_pay_manage_no
                        + ",v_account_amt="+v_account_amt
                        + ",v_pay_date="+v_pay_date
                        + ",v_pay_cd="+v_pay_cd
                        + ",v_plan_pay_date="+v_plan_pay_date;
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv310I",
                "JSP(I:DEFAULT=ds1)",
                v_param);
            tr_post(tr_save);
        }
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
        alert("상품정보 <%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
	fnSelectBound();
</script>

<script language=JavaScript for=v_bound event=OnSelChange()>
 	if( div !="loadBound"){
		fnSelectPayseq();
	}
</script>

 <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
	 	div = "loadBound";	
 		ds_bound.insertrow(1);
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "0";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_NM") = "전체";
		v_bound.Index = 0; 
		div="";		
    </script>

<script language=JavaScript  for=ds_payseq event="OnLoadCompleted(row)">
 		ds_payseq.insertrow(1);
		ds_payseq.namevalue(ds_payseq.rowposition, "PAY_SEQ") = "0";
		ds_payseq.namevalue(ds_payseq.rowposition, "PAY_NM") = "전체";
		v_payseq.Index = 0;
    </script>

<script language=javascript for="gr1" event="OnClick(Row,Colid)">
	//제목 클릭했을 때
    if(Row==0) {
        if(Colid == "JOB_SEL"){
            for(var i=1; i<=ds1.CountRow; i++){
//            alert(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT"));
            	//보증즘 잔금 없는 넘들만.
				if(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT")==0){
	                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	                
	                if(getObjectFirst("ds1").NameValue(i, Colid)=="T")
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=getObjectFirst("ds1").NameValue(i, "ARREARS_AMT");
	                else
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=0;
				};
            }
        }else if(Colid == "JOB_SEL2"){ //계약금
            for(var i=1; i<=ds1.CountRow; i++){
//            alert(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT"));
            	//보증즘 잔금 없는 넘들만.
				if(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT")==0){
	                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	                
	                if(getObjectFirst("ds1").NameValue(i, Colid)=="T")
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=getObjectFirst("ds1").NameValue(i, "DEPOSIT_AMT");
	                else
	                    getObjectFirst("ds1").NameValue(i, "PAY_AMT")=0;
				};
            }
        }else if(Colid == "PAY_AMT"){
            for(var j=1; j<=ds1.CountRow; j++){
	            	        // alert(getObjectFirst("ds1").NameValue(j,"PAY_AMT"));
	            	         ds1.NameValue(j, Colid) = ds1.NameValue(1, Colid);
           };
         }   
        return;
    }


    if(Colid=="JOB_SEL"){
		//보증금대체 고려한 제약 조건 2008-05-10 by 심동현
		if(getObjectFirst("ds1").NameValue(Row, "REMAINED_DEPOSIT_AMT")>0){
			alert("["+getObjectFirst("ds1").NameValue(Row, "CUST_NM")+"]님은 보증금 대체가 완료되지 않아 지금 결제할 수 없습니다.\n영업담당자에게 보증금대체를 요청해주세요.");
			getObjectFirst("ds1").NameValue(Row, "JOB_SEL")="F";
		}else{
			//기존 클릭이벤트 
	        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T"){
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=getObjectFirst("ds1").NameValue(Row, "ARREARS_AMT");
	        }else{
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=0;
	        };

		    if(getObjectFirst("ds1").NameValue(Row, "TOT_PAY_AMT")>getObjectFirst("ds1").NameValue(Row, "TOT_TOUR_AMT")){
		        alert("판매가보다 입금액이 더 많습니다.결제하실 수 없습니다.");
		        ds1.Undo(ds1.RowPosition);
		    };
	
		};
	};	
	
	 if(Colid=="JOB_SEL2"){
		//보증금대체 고려한 제약 조건 2008-05-10 by 심동현
		if(getObjectFirst("ds1").NameValue(Row, "REMAINED_DEPOSIT_AMT")>0){
			alert("["+getObjectFirst("ds1").NameValue(Row, "CUST_NM")+"]님은 보증금 대체가 완료되지 않아 지금 결제할 수 없습니다.\n영업담당자에게 보증금대체를 요청해주세요.");
			getObjectFirst("ds1").NameValue(Row, "JOB_SEL2")="F";
		}else{
			//기존 클릭이벤트 
	        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T"){
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=getObjectFirst("ds1").NameValue(Row, "DEPOSIT_AMT");
	        }else{
	            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=0;
	        };

		    if(getObjectFirst("ds1").NameValue(Row, "TOT_PAY_AMT")>getObjectFirst("ds1").NameValue(Row, "TOT_TOUR_AMT")){
		        alert("판매가보다 입금액이 더 많습니다.결제하실 수 없습니다.");
		        ds1.Undo(ds1.RowPosition);
		    };
	
		};
	};	
    
</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
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

<script language="javascript" for="tr_save" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr_save.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr_save.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);

    fnSelect();
</script>

<script language="javascript" for="tr_save" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 사업지역구분 -->
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품순번 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_payseq classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  결제순번 -->
    <param name="SyncLoad"  value="True">
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
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/account.gif" style="cursor:hand" onClick="fnAccount()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td align="center" width="100px" class="text">대리점</td>
                                <td COLSPAN=3 align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="협력업체코드를 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
                                </td>
                                <td   align="center" width="100px" class="text">요금구분</td>
                                <td colspan='3' align="left" bgcolor="#ffffff">&nbsp;<select name=v_pay_gubn class="text">
                                        <option value="N">관광요금
                                        <option value="Y">OPTION요금
                                    </select>
                                    &nbsp;취소자포함 <input type=checkbox name=v_cancel_yn>
                                </td>
                            </tr>
                            <tr height="25px">
		                        <td  align="center" class="text" >지역</td>
		                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=v_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
		                                <param name=ComboDataID     value=codeDs1>
		                                <param name=ListExprFormat  value="saup_nm^1^80,saup_sid^1^40">
										<param name=SearchColumn	value="saup_nm">
										<param name=BindColumn		value="saup_sid">
		                            </object>
		                            <%=HDConstant.COMMENT_END%>
		                        </td>
                                <td  align="center" width="100px" class="text">상품코드</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            
                                <td  align="center"  width="100px" class="text">출발일자</td>
                                <td colspan='3'  align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date1 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=startDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;&nbsp;
                                    <!--  <object id=v_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>-->
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr height="25px">
                                <td  align="center" width="100px" class="text">신청서번호</td>
                                <td  clospan='2' align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="000000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
	                                <td  align="center" width="100px" class="text">상품순번</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_bound classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=50 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_bound>
                                            <param name=SearchColumn	value="BOUND_NM">
                                            <param name=BindColumn  	value="BOUND_SEQ">
                                            <param name=ListExprFormat  value="BOUND_NM^0^50">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td  align="center" width="100px" class="text">결제순번</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_payseq classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_payseq>
                                            <param name=SearchColumn	value="PAY_NM">
                                            <param name=BindColumn  	value="PAY_SEQ">
                                            <param name=ListExprFormat  value="PAY_NM^0^50">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>  
                                <td width="100px" class="text">성명</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="13" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>             
                <tr>
                    <td colspan="2">
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:360px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="True">
                        <param name="SuppressOption"    value="1">
                        <Param Name="UsingOneClick"     value="1">
                        <Param Name="AllShowEdit"       value="True">
                        <param name="ViewSummary"       value="1">
                        <Param Name="SortView"     value="Right">
                        <param name="Format"            value=" 
                            <FC> name='전체√'         ID='JOB_SEL'        Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False bgColor={IF(REMAINED_DEPOSIT_AMT>0,'#FF0000','#0000FF')}</FC>
                            <FC> name='계약√'         ID='JOB_SEL2'      Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False bgColor={IF(REMAINED_DEPOSIT_AMT>0,'#FF0000','#0000FF')}</FC>
                            <FC> name='NO'            ID='{CURROW}'       Width=35   edit=none align=center</FC>
                            <FC> name='결제순번'     	ID='PAY_SEQ'       	width=60	align=center editlimit=2 show=true </FC>
                            <FC> name='상품'          ID='GOODS_NM'       Width=100  SumText='총건수' Edit=none align=Left suppress=1</FC>
                            <C> name='출발일자'       ID='DEPART_DATE'    Width=60   SumText=@count Edit=none align=Left suppress=2</C>
                            <C> name='성명'           ID='CUST_NM'        Width=60   Edit=none align=Left suppress=3 SUMTEXT=@CNT sort=True</C>
                            <C> name='주민/여권번호'  ID='MANAGE_NO'      Width=60   SumText='결제예정금액' Edit=none align=Left suppress=4 show=true</C>
                            <C> name='객실\\코드'     ID='ROOM_TYPE_NM'   Width=50   Edit=none align=Left suppress=5</C>
                            <C> name='할인\\코드'     ID='CUST_TYPE_NM'   Width=50    Edit=none align=Center suppress=6< Dec=0/C>
                            <C> name='판매가'         ID='TOT_TOUR_AMT'   Width=60   SumText=@sum Edit=none align=Right Dec=0</C>
                            <G> name='입금액'
                            <C> name='입금액'         ID='TOT_PAY_AMT'    Width=60   SumText=@sum Edit=none align=Right Dec=0</C>
                            <C> name='미입금액'       ID='MI_PAY_AMT'     Width=60  SumText=@sum Edit=none align=Right Dec=0</C>
                            </G>
                            <C> name='미납액'         ID='ARREARS_AMT'    Width=60   SumText=@sum Edit=none align=Right Dec=0</C>
                            <C> name='계약금'         ID='DEPOSIT_AMT'    Width=60   SumText=@sum Edit=none align=Right Dec=0 show=false</C>
                            <C> name='결제액'         ID='PAY_AMT'        Width=60   SumText=@sum Edit=Numeric Dec=0 align=Right</C>
                            <C> name='신청번호'       ID='ACCEPT_NO'      Width=90   Edit=none align=Left</C>
                            <C> name='블록SID'        ID='BLOCK_SID'      Width=60   Edit=none align=Left show=false</C>
                            <C> name='보증잔금'       ID='REMAINED_DEPOSIT_AMT' Width=90 Edit=none align=RIGHT DEC=0 show=TRUE</C>
                            <C> name='정산시기'       ID='AFTER_CU'      Width=60   Edit=none align=Left show=false</C>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
     <tr>
         <td>
         	<table>
         	  <tr>
         	  	<td valign=top>
		         ※ GRID의 [선택] 항목에 색상이 나타납니다.<br>
		         　<font color=blue>파랑</font> : 지금 바로 결제할 수 있습니다.<br>
		         　<font color=red>빨강</font> : <b>블록 보증금을 대체한 후</b> 결제할 수 있습니다.<br>
		         　　　　영업담당자에게 문의해주세요.<br>
         	  	</td>
         	  	<td valign=top>
		         ※ <font color=red><b>가상계좌 결제 주의사항</b></font><br>
		         　계좌번호를 생성하면 "계좌번호안내창"이 뜹니다.<br>
		         　계좌번호를 복사하신 후 반드시 <b>확인</b>을 눌러 창을 닫아주세요.<br>
		         　　팝업 창이 닫히면서 <b>추가 저장 작업</b>이 진행되므로,<br> 
		         　　확인을 누르지 않은 상태에서 계좌이체를 하실 경우<br>
		         　　<B>입금확인이 자동 처리되지 않습니다</b>.<BR>
		         ※ 결제순번 별 조회: 신청서번호 => 상품순번 선택 시 결제순번이 선택 가능합니다.
         	  	</td>         	  	
         	  </tr>
         	</table>
         </td>
     </tr>
</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


