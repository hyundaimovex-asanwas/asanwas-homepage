<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명     : 신용카드 결제 Help 
 * 프로그램ID   : RV005H (코드는 대문자)
 * J  S  P      : rv005h (jsp파일명은 소문자로 한다 )
 * 서 블 릿     : Rv005H
 * 작 성 자     : 김영민
 * 작 성 일     : 2006-06-28
 * 기능정의     : 신용카드 결제
 * [수정일자][수정자] 내용
 * [20091221][박경국] 무통장입금 부분 입금내역 조회해서 선택 후 결제 하는 화면으로 수정
 * [20091228][심동현] 화면/그리드 사이즈, 스크립트 수정

 * [20111102][심동현] 결제폼 "ac" 객체는 총 7개   쇼핑몰 쪽 결제창이 더 최근 것이구나...(__)
 * [20111102][심동현] 0가상계좌  			공통코드 AC001 > 020 
 * [20111102][심동현] 1계좌이체				공통코드 AC001 > 030 
 * [20111102][심동현] 2EDI 카드				공통코드 AC001 > 040 
 * [20111102][심동현] 3상품권				공통코드 AC001 > 060 
 * [20111102][심동현] 4무통장입금			공통코드 AC001 > 080 
 * [20111102][심동현] 5기타대체				공통코드 AC001 > 090 
 * [20111102][심동현] 6KCP 온라인 신용카드	공통코드 AC001 > 051 인터넷(카)2- 전화예약 > 직접결제
 * [20111102][심동현] 이 페이지에 없는 		공통코드 AC001 > 050 인터넷(카) - 직접예약 > 직접결제
 * [20140121][심동현] 시스템 이전
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String  dirPath         = request.getContextPath();
    String  v_card_no       = HDUtil.nullCheckStr(request.getParameter("v_card_no"));       //원승인 카드번호
    String  v_expire_year   = HDUtil.nullCheckStr(request.getParameter("v_expire_year"));   //카드 유효년
    String  v_expire_month  = HDUtil.nullCheckStr(request.getParameter("v_expire_month"));  //카드 유효월
    String  v_auth_no       = HDUtil.nullCheckStr(request.getParameter("v_auth_no"));       //원승인번호
    String  v_org_date      = HDUtil.nullCheckStr(request.getParameter("v_org_date"));      //원거래일자

    int     c_pay_amt       = HDUtil.nullCheckNum(request.getParameter("v_account_amt"));   //금액
    int     TR_SID 	 	    = HDUtil.nullCheckNum(request.getParameter("TR_SID"));
    String  v_client_cd     = HDUtil.nullCheckStr(request.getParameter("v_client_cd"));     //대리점코드
    String  v_goods_nm      = HDUtil.nullCheckStr(request.getParameter("v_goods_nm"));      //상품명

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");

    String firstday = m_today.format(date.getTime()).substring(0,8);
    String totDay = m_today.format(date.getTime());           

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>- 요금결제 창입니다 -</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
    <script language="javascript">
        var v_job = "H";
        
        var v_plan_pay_date = "";       //입금예정일자

        /* 결제 항목
         * array
         * 0 : 가상계좌 이체
         * 1 : 계좌이체 (사용안함) → 온라인 신용카드
         * 2 : 신용카드 EDI
         * 3 : 상품권결제
         * 4 : 무통장입금
         * 5 : 기타대체
         * 6 : 신용카드 Online
         */		
        subimg__a_url = new Array();
        subimg__url = new Array();
        subimg__a_url[0] = new Image();
        subimg__a_url[1] = new Image();
        subimg__a_url[2] = new Image();
        subimg__a_url[3] = new Image();
        subimg__a_url[4] = new Image();
        subimg__a_url[5] = new Image();
        subimg__a_url[6] = new Image();
        
        subimg__url[0] = new Image();
        subimg__url[1] = new Image();
        subimg__url[2] = new Image();
        subimg__url[3] = new Image();
        subimg__url[4] = new Image();
        subimg__url[5] = new Image();
        subimg__url[6] = new Image();
    
        subimg__a_url[0].src="<%=dirPath%>/Sales/images/ac_01_on.gif";
        subimg__a_url[1].src="<%=dirPath%>/Sales/images/ac_02_on.gif";
        subimg__a_url[2].src="<%=dirPath%>/Sales/images/ac_03_on.gif";
        subimg__a_url[3].src="<%=dirPath%>/Sales/images/ac_04_on.gif";
        subimg__a_url[4].src="<%=dirPath%>/Sales/images/ac_05_on.gif";
        subimg__a_url[5].src="<%=dirPath%>/Sales/images/ac_06_on.gif";
		subimg__a_url[6].src="<%=dirPath%>/Sales/images/ac_07_on.gif";

        subimg__url[0].src="<%=dirPath%>/Sales/images/ac_01.gif";
        subimg__url[1].src="<%=dirPath%>/Sales/images/ac_02.gif";
        subimg__url[2].src="<%=dirPath%>/Sales/images/ac_03.gif";
        subimg__url[3].src="<%=dirPath%>/Sales/images/ac_04.gif";
        subimg__url[4].src="<%=dirPath%>/Sales/images/ac_05.gif";
        subimg__url[5].src="<%=dirPath%>/Sales/images/ac_06.gif";
        subimg__url[6].src="<%=dirPath%>/Sales/images/ac_07.gif";
                
        var sub_click_img = 9;
        
        //결제 모듈 상수 변수 선언
        var common_card_term_id  = "";   //단말기 아이디
        var common_acct_term_id  = "";   //계좌이체 및 가상계좌 아이디
        var common_acct_join_no = "";    //계좌이체 및 가상계좌 가맹점 ID
        
        //결제 공통 모듈
        var c_pay_gubn          = "";   //결제수단
        var c_pay_manage_no     = "";   //결제 관리번호
        var c_van_cd            = "";   //van 구분
        var c_pay_amt           = "";   //거래금액
        var c_acct_join_no      = "";   //가맹점 ID
        var c_terminal_id       = "";   //단말기 아이디
        
        //가상계좌 / 계좌이체 결제 관련 연동 변수 선언
        //요청
        var r_order_nm          = "";   //주문자명
        var r_order_tel_no      = "";   //주문자 전화번호
        var r_order_e_mail      = "";   //주문자 E-mail
        var r_user_key          = "";   //사용자 KEY
        
        //무통장 거래내역 SID
        var TR_SID          	= "";   //무통장거래SID
        //응답
        var s_bank_cd           = "";   //은행코드
        var s_bank_nm           = "";   //은행명
        var s_order_nm          = "";   //주문자명
        var s_order_tel_no      = "";   //주문자 전화번호
        var s_order_e_mail      = "";   //주문자 E-mail
        var s_user_key          = "";   //사용자 KEY
        
        //신용카드 결제 관련 연동 변수 선언
        //요청변수
        var r_card_no           = "";   //카드번호
        var r_valid_terms       = "";   //유효기간
        var r_halbu_terms       = "";   //할부구분
        var r_card_way_cd       = "";   //10:KeyIn, 20:Swipe
        var r_agree_no          = "";   //승인번호 취소시
        var r_org_agree_date    = "";   //거래일자 취소시
        
        //응답변수
        var s_resp_code         = "";   //응답코드
        var s_van_idx_no        = "";   //거래고유번호
        var s_agree_time        = "";   //거래승인일시요일

        var s_issue_company_cd  = "";   //카드사 코드
        var s_issue_company_nm  = "";   //카드사명
        var s_card_join_no      = "";   //가맹점번호
        var s_card_company_nm   = "";   //매입사명
        var s_agree_no          = "";   //승인번호
        var s_print_cd          = "";   //프린트코드
        var s_auto_cd           = "";   //자동이체구분
        var s_remark            = "";   //가맹점사용 Field
        var s_resp_msg1         = "";
        var s_resp_msg2         = "";
        
       	<%// Tab Image Control%>
        function fnOnChangTab(tab_idx){
            if(tab_idx==2 && c_pay_amt<1000){
                alert("신용카드 결제는 1,000원 이상에서만 가능합니다.");
                return;
            }
            if(tab_idx==4){
	            c_pay_date1.text='<%=firstday%>';
				   
	        	//2007-06-11 계좌번호  by 심동현 
	        	//2009-12-28 입금내역 중 선택으로 바뀌면서 더이상 필요없음.
				//계좌번호 [AC021]
				//dstype=5 : detail_nm을 보여주면서 '전체'
	            //codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC021&s_item1=Y";
	            //codeDs1.Reset();
            }
           
           
    
            for(var i=0; i<document.all("ac").length; i++){
                if(i==tab_idx){
                    document.all("ac")[i].style.display = "inline";
                    for(var j=0; j<getObjectList("ac_btn_"+i).length; j++)
                        getObjectList("ac_btn_"+i)[j].style.display = "inline";
                } else {
                    document.all("ac")[i].style.display = "none";
                    for(var j=0; j<getObjectList("ac_btn_"+i).length; j++)
                        getObjectList("ac_btn_"+i)[j].style.display = "none";
                }
            }
        }
        
        function changesub (no) {
            for (i=0; i<=6;i++){
                if(eval("document.images.ac_"+i)!=undefined){
                    obj = eval("document.images.ac_"+i);
                    if (i == no)
                        obj.src = subimg__a_url[i].src;
                    else
                        obj.src = subimg__url[i].src;
                }
            }
        }
    
        function changesubclick (no) {
            if(no==2 && c_pay_amt<1000) return;
            
            sub_click_img = no;
            for (i=0; i<=6;i++){
                if(eval("document.images.ac_"+i)!=undefined){
                    obj = eval("document.images.ac_"+i);
                    if (i == no)
                      obj.src = subimg__a_url[i].src;
                    else
                      obj.src = subimg__url[i].src;
                }
            }
        }
        
        function changesubout (no) {
            changesubclick(sub_click_img);
        }

        /*
         * 입력 파라미터
         * 결제 : 
         *  - 0 : 대리점코드
         *  - 1 : 결제금액
         *  - 2 : 상품명
         */
        var strParam = new Array();
        strParam=window.dialogArguments;
        
//alert("strParam : " + strParam + " : " + strParam.length);
        var v_display   = strParam[0];
        var v_client_cd = strParam[1];
        c_pay_amt       = strParam[2];
        var v_goods_nm  = strParam[3];
        common_card_term_id = strParam[4];
        common_acct_term_id = strParam[5];
        common_acct_join_no = strParam[6];
        var v_client_sid = strParam[7];
		var v_cust_nm 	= strParam[8];       //관광객명	2010-01-14 수정..

        /*
         * 신용카드 취소시 파라미터 추가
         */
        var v_auth_gubn     = "1100";   //승인구분 1100 (신용승인), 1102 (신용취소)
        var v_card_no       = "";   //카드번호
        var v_expire_date   = "";   //유효기간
        var v_auth_no       = "";   //승인번호
        var v_org_pay_date  = "";   //원거래승인일자
        var v_halbu_terms   = "00"; //할부기간
        
        var v_expire_year   = "";   //유효년
        var v_expire_month  = "";   //유효월
        
        if(strParam.length==15){//취소시 파라미터 15개.
            v_auth_gubn     = "1102";	//위에서 strParam[8]이 관광객명을 받으면서 강제코딩으로 수정 2010-01-14
            v_card_no       = strParam[9];
            v_expire_date   = strParam[10];
            v_halbu_terms   = strParam[11];
            v_auth_no       = strParam[12];
            v_org_pay_date  = strParam[13];
            c_pay_manage_no = strParam[14];

            v_expire_year   = "";
            v_expire_month  = "";
            if(v_expire_date!=undefined && v_expire_date.length==4){
                v_expire_year = v_expire_date.substring(0, 2);
                v_expire_month = v_expire_date.substring(2);
            }
        }
        
        
        function fnOnLoad(){
            cfStyleGrid(getObjectFirst("gr_gift"), "comn");
            cfStyleGrid(getObjectFirst("gr_giftList"), "comn");
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            
            for(var i=0; i<v_display.length; i++){
                if(v_display.charAt(i)=="1"){
                    if(sub_click_img==9)
                        sub_click_img = i;
                    if(getObjectFirst("tr_ac_"+i)!=undefined) 
                        getObjectFirst("tr_ac_"+i).style.display = "inline";
                } else {
                    if(getObjectFirst("tr_ac_"+i)!=undefined)
                        getObjectFirst("tr_ac_"+i).style.display = "none";
                }
            }
            
            changesubclick(sub_click_img);
            fnOnChangTab(sub_click_img);

            window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);
            
            ds_giftType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC003";
            ds_giftType.Reset();
            
            ds_accType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC019&s_item=Y";
            ds_accType.Reset();
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(O:CARD=ds_card,O:ACCOUNT=ds_account,O:NOACCOUNT=ds_noaccount,O:TONGJANG=ds_tongjang,O:ETC=ds_etc,O:GIFT=ds_gift)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
            
            for(var i=0; i<document.all("c_pay_amt").length; i++){
                document.all("c_pay_amt")[i].Text = c_pay_amt;
            }
            
            getObjectFirst("r_card_no").Text        = v_card_no;
            getObjectFirst("r_halbu_terms").value   = v_halbu_terms;
            getObjectFirst("v_expire_year").Text    = v_expire_year;
            getObjectFirst("v_expire_month").Text   = v_expire_month;
            getObjectFirst("r_agree_no").Text       = v_auth_no;
            getObjectFirst("r_org_agree_date").Text = v_org_pay_date;
   			getObjectFirst("v_noaccount_nm").value = v_cust_nm;//입금자명에 선택된 관광객명을 찍어주기 2010-01-14
            if(strParam.length==15){
                getObjectFirst("r_card_no").Enable        = "false";
                getObjectFirst("v_expire_year").Enable    = "false";
                getObjectFirst("v_expire_month").Enable   = "false";
                getObjectFirst("r_agree_no").Enable       = "false";
                getObjectFirst("r_org_agree_date").Enable = "false";
            }
        }
        
        /*
         * 카드결제
         */
        function fnCardTrans(){
            c_pay_gubn      = "040";
            c_van_cd        = "01";
            c_terminal_id   = common_card_term_id;
            c_pay_amt       = getObjectFirst("c_pay_amt").Text.trim();

            r_card_no       = getObjectFirst("r_card_no").Text.trim();
            r_valid_terms   = getObjectFirst("v_expire_year").Text.trim()+getObjectFirst("v_expire_month").Text.trim();
            //할부 : BC Top 포인트( topChk ) 체크할 경우, +60을 해줍니다.
            //      어차피 Form 값으로 들어가기 때문에 2자리만 맞추면 숫자건 문자건 무관합니다.
            if(getObjectFirst("topChk").checked){
	            r_halbu_terms   = parseInt(getObjectFirst("r_halbu_terms").value) + 60;
            }else{
	            r_halbu_terms   = getObjectFirst("r_halbu_terms").value;
            };
            r_card_way_cd   = "10"; //KeyIn
            r_agree_no      = getObjectFirst("r_agree_no").Text.trim();
            r_org_agree_date= getObjectFirst("r_org_agree_date").Text.trim();
            
            //현재년월을 구함
            var v_user_expire = (fnGetYear() + fnGetMonth()).substring(2);

            if(c_pay_amt=="" || eval(c_pay_amt)<1000){
                alert("결제 금액 <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("c_pay_amt").Focus();
                return;
            }
            
            if(r_card_no=="" || r_card_no.length<13){
                alert("카드번호 <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("r_card_no").Focus();
                return;
            }

            if(getObjectFirst("v_expire_year").Text=="" || getObjectFirst("v_expire_year").Text.trim().length<2){
                alert("유효기간 년도 <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_expire_year").Focus();
                return;
            }
            if(getObjectFirst("v_expire_month").Text=="" || getObjectFirst("v_expire_month").Text.trim().length<2){
                alert("유효기간 월 <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_expire_month").Focus();
                return;
            }
            if(eval(getObjectFirst("v_expire_month").Text)<1 || eval(getObjectFirst("v_expire_month").Text.trim())>12){
                alert("유효기간 월 <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_expire_month").Focus();
                return;
            }
            if(r_valid_terms<v_user_expire){
                alert("유효기간은 현재 년월보다 작을 수 없습니다.");
                getObjectFirst("v_expire_year").Focus();
                return;
            }
            
            if(c_pay_manage_no == "")
            	fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 결제관리번호 채번 파라미터 추가
            
            if(c_pay_manage_no==""){
                alert("결제 관리번호를 추출하지 못했습니다.");
                return;
            }
 
            //acc_frm 초기화
            document.acc_frm.reset();
            
            document.acc_frm.c_pay_gubn.value          = c_pay_gubn;
            document.acc_frm.c_pay_manage_no.value     = c_pay_manage_no;
            document.acc_frm.c_van_cd.value            = c_van_cd;
            document.acc_frm.c_pay_amt.value           = c_pay_amt;
            document.acc_frm.c_terminal_id.value       = c_terminal_id;

            //document.acc_frm.r_app_type.value          = "1100";
            document.acc_frm.r_app_type.value          = v_auth_gubn;
            document.acc_frm.r_card_no.value           = r_card_no;
            document.acc_frm.r_valid_terms.value       = r_valid_terms;
            document.acc_frm.r_halbu_terms.value       = r_halbu_terms;
            document.acc_frm.r_card_way_cd.value       = r_card_way_cd;
            document.acc_frm.r_agree_no.value          = r_agree_no;
            document.acc_frm.r_org_agree_date.value    = r_org_agree_date;
            
            document.acc_frm.action ="<%=HDConstant.KCP_CARD_AUTH%>";
            document.acc_frm.submit();
            fnShowLoading(410,180);
            
            
            
            setTimeout("fnAccountFail()", 1000*10);    //10초동안 무 응답시 alert Message

//alert(document.acc_frm.action);

        }
        
        function fnAccountFail(){
            fnHideLoading();;
            alert("결제 TimeOut");
        }
        
        /*
         * 가상계좌
         */
        function fnNonAccountTrans(){
            c_pay_gubn = "020";
            c_pay_manage_no = "";
            c_van_cd        = "01";
            c_terminal_id   = common_acct_term_id;
            c_acct_join_no  = common_acct_join_no;
            c_pay_amt       = getObjectFirst("c_pay_amt").Text;
            
            if(getObjectFirst("v_noaccount_nm").value==""){
                alert("입금자명을 입력하시길 바랍니다.");
                return;
            }

            fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 결제관리번호 채번 파라미터 추가
            
            if(c_pay_manage_no==""){
                alert("결제 관리번호를 추출하지 못했습니다.");
                return;
            }

            //acc_frm 초기화
            document.acc_frm.reset();

            document.acc_frm.c_pay_gubn.value          = c_pay_gubn;
            document.acc_frm.c_pay_manage_no.value     = c_pay_manage_no;
            document.acc_frm.c_van_cd.value            = c_van_cd;
            document.acc_frm.c_pay_amt.value           = c_pay_amt;
            document.acc_frm.c_terminal_id.value       = c_terminal_id;
            document.acc_frm.c_acct_join_no.value      = c_acct_join_no;
            document.acc_frm.r_user_key.value          = v_goods_nm;

            document.acc_frm.r_order_nm.value          = getObjectFirst("v_noaccount_nm").value

            document.acc_frm.action ="<%=HDConstant.KCP_ACCOUNT_AUTH%>";
            document.acc_frm.submit();
        }
        /*
         * 계좌이체
         */
        function fnAccountTrans(){
            c_pay_gubn = "030";
            c_pay_manage_no = "";
            c_van_cd        = "01";
            c_terminal_id   = common_acct_term_id;
            c_acct_join_no  = common_acct_join_no;
            c_pay_amt       = getObjectFirst("c_pay_amt").Text;

            if(getObjectFirst("v_account_nm").value==""){
                alert("입금자명을 입력하시길 바랍니다.");
                return;
            }
            
            fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 결제관리번호 채번 파라미터 추가
            
            if(c_pay_manage_no==""){
                alert("결제 관리번호를 추출하지 못했습니다.");
                return;
            }

            //acc_frm 초기화
            document.acc_frm.reset();

            document.acc_frm.c_pay_gubn.value          = c_pay_gubn;
            document.acc_frm.c_pay_manage_no.value     = c_pay_manage_no;
            document.acc_frm.c_van_cd.value            = c_van_cd;
            document.acc_frm.c_pay_amt.value           = c_pay_amt;
            document.acc_frm.c_terminal_id.value       = c_terminal_id;
            document.acc_frm.c_acct_join_no.value      = c_acct_join_no;
            document.acc_frm.r_user_key.value          = v_goods_nm;
            document.acc_frm.r_order_nm.value          = getObjectFirst("v_account_nm").value;

            document.acc_frm.action ="<%=HDConstant.KCP_ACCOUNT_AUTH%>";
            document.acc_frm.submit();
        }
        
        
        /**
         * 무통장 입금 결제
         */
        function fnTongJangTrans(){
        	var v_sel_cnt="0";
        	
        	if(getObjectFirst("ds_tongjang").CountRow==0){
            alert("먼저 [조회==>선택] 후 클릭하시길 바랍니다.");
            return;
	        }
        	c_pay_gubn = "080";
        	c_pay_amt  = getObjectFirst("c_pay_amt").Text.trim();
        	
        	fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 결제관리번호 채번 파라미터 추가
        	if(c_pay_manage_no==""){
                alert("결제 관리번호를 추출하지 못했습니다.");
                return;
            }
            
  
			//무통입금일자 설정
			v_plan_pay_date = c_pay_date1.text;
			v_bank_cd=v_bancod.value;
			
        	for(var i=1; i<=getObjectFirst("ds_tongjang").CountRow; i++){
        		if(getObjectFirst("ds_tongjang").NameValue(i, "JOB_SEL")=="T"){
                   	v_sel_cnt++;
        		}
        	}
        	if(v_sel_cnt==1){
       		 	for(var i=1; i<=getObjectFirst("ds_tongjang").CountRow; i++){
	        		if(getObjectFirst("ds_tongjang").NameValue(i, "JOB_SEL")=="T"){
		    			if(getObjectFirst("ds_tongjang").NameValue(i, "c_balance_amt") >= c_pay_amt){ 				    	   	
			    	   		var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
					       		+ ",v_client_sid="+v_client_sid
		    		   	        + ",v_pay_manage_no="+c_pay_manage_no
		       	   		        + ",v_pay_date="+v_plan_pay_date
		       		    	    + ",v_pay_time="+''
		       	    	    	+ ",v_bank_cd="+v_bank_cd
			       	        	+ ",v_pay_amt="+c_pay_amt
			               	    + ",v_pay_cd="+c_pay_gubn;
				        				
			        			ln_TRSetting(tr_save2, 
			               		"<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
					           	"JSP(I:TONGJANG=ds_tongjang)",
			   			        v_param);
		       				    tr_post(tr_save2);
			    	   	}
	        			if(c_pay_amt > getObjectFirst("ds_tongjang").NameValue(i, "c_balance_amt") ){						    
			    	   	alert("잔액을 초과하였습니다.");
				    	return;
				    	}
				    }
				}
			}
       		if(v_sel_cnt==0){
	       	   alert("선택된 내역이 없습니다.");
		       return;
		    }
        	if(v_sel_cnt > 1){
       	 	   alert("한개의 내역만 선택할 수 있습니다.");
	    	   return;
        	}
		}
        
        /**
         * 무통장 입금 조회
         */
        function fnSelect() {
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",c_pay_date1=" + c_pay_date1.text
		            + ",v_order_nm=" + v_order_nm.value 
                    + ",v_bank_acc_no=" + v_bank_acc_no.value
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac080I_02", 
	            "JSP(O:MAIN_DS=ds_tongjang)",
	            v_param);
	        tr_post(tr1);
		}
        
        
        /**
         * 기타대체 : 화면에 없어..버튼이..움;;
         */
        function fnEtcTrans(){
        	if(v_pay_empnmk.value==""){
        		alert("입금자 <%=HDConstant.A_MSG_MUST_INPUT%>");
        		return;
        	}
        	if(c_pay_date2.Text=="" || c_pay_date2.Text.trim().length!=8){
        		alert("입금일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
        		return;
        	}

        	c_pay_gubn = "090";
        	
        	fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 결제관리번호 채번 파라미터 추가
        	if(c_pay_manage_no==""){
                alert("결제 관리번호를 추출하지 못했습니다.");
                return;
            }
        	


			ds_etc.AddRow();
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_MANAGE_NO") = c_pay_manage_no;
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_CD") = c_pay_gubn;
        	ds_etc.NameValue(ds_etc.CountRow, "ACC_CD") = v_acc_cd.ValueOfIndex("DETAIL", v_acc_cd.Index);
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_DATE") = c_pay_date2.Text;
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_EMPNMK") = v_pay_empnmk.value;
        	ds_etc.NameValue(ds_etc.CountRow, "PAY_AMT") = c_pay_amt;
        	ds_etc.NameValue(ds_etc.CountRow, "CLIENT_SID") = v_client_sid;

            ln_TRSetting(tr_save2, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(I:ETC=ds_etc)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr_save2);
        }
        
        function fnBankAccountPopup(){
            var arrParam    = new Array();

            var strURL = "<%=dirPath%>/Sales/help/ac003h.jsp";
            var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            var arrResult = showModalDialog(strURL,arrParam,strPos); 

            if(arrResult!=null && arrResult!=undefined){
                arrParam = arrResult.split(";");
                getObjectFirst("v_bank_acc_no").value = arrParam[0];
                getObjectFirst("v_bancod").value = arrParam[1];
                getObjectFirst("v_banknm").value = arrParam[2];
            } else {
                getObjectFirst("v_bank_acc_no").value = "";
                getObjectFirst("v_bancod").value = "";
                getObjectFirst("v_banknm").value = "";
            }
        }

        /*
         * 상품권
         */
        function fnGiftTrans(){
            var v_gift_amt = 0;
            var v_gift_qty = 0;
            c_pay_gubn = "060";
            if(getObjectFirst("ds_gift").CountRow==0){
                alert("상품권 정보를 먼저 등록하시길 바랍니다.");
                return;
            }
            
            for(var i=1; i<=getObjectFirst("ds_gift").CountRow; i++){
                if(getObjectFirst("ds_gift").NameValue(i, "PAY_AMT")==0){
                    alert(i+ "번째 행의 데이터 금액부분이 빠져 있습니다.");
                    return;
                }
                v_gift_amt += getObjectFirst("ds_gift").NameValue(i, "PAY_AMT")*1000;
                
                /**
                 * 상품권 수량 체크, 수량이 0 이면 안됨...
                 */
                if(getObjectFirst("ds_gift").NameValue(i, "PAY_QTY")==0){
                    alert(i+ "번째 행의 데이터 금액부분이 빠져 있습니다.");
                    return;
                }
                v_gift_qty += getObjectFirst("ds_gift").NameValue(i, "PAY_QTY");
            }
            
            if(v_gift_amt!=c_pay_amt){
                alert("결제 요청 금액["+c_pay_amt+"]과 입금된 상품권 금액["+v_gift_amt+"]이 틀립니다.");
                return;
            }

            fnGetManageNo(c_pay_gubn, c_pay_amt);//20140122 결제관리번호 채번 파라미터 추가
            
            if(c_pay_manage_no==""){
                alert("결제 관리번호를 추출하지 못했습니다.");
                return;
            }

            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(I:GIFT=ds_gift)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,v_client_cd="+v_client_cd+",v_pay_manage_no="+c_pay_manage_no+",c_pay_amt="+c_pay_amt+",v_gift_qty="+v_gift_qty);
            tr_post(tr_save);
        }
        
        function fnGiftAdd(){
            getObjectFirst("ds_gift").AddRow();
            getObjectFirst("gr_gift").SetColumn("GIFT_TYPE");
        }
        
        function fnGiftDel(){
            getObjectFirst("ds_gift").DeleteRow(getObjectFirst("ds_gift").RowPosition);
        }
        
        function fnGiftCancel(){
            getObjectFirst("ds_gift").UndoAll();
        }
        
        //결제 관리 번호 추출 : 대부분의 결제에서 씁니다. 당근~ 20140121
        // 파라미터를 추가했음 v_pay_amt, v_pay_cd
        function fnGetManageNo(p_pay_cd, p_pay_amt){
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(O:PAY_MANAGE_NO=ds_manage_no)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_cd="+p_pay_cd+",v_pay_amt="+p_pay_amt);
            tr_post(tr1);
        }
        
        /*
         * 카드취소
         */
        function fnCardCancel(){
        }
        
        /*
         * 결제 종료
         */
        function fnPopClose(){
        	//alert(v_plan_pay_date);
            window.returnValue=c_pay_gubn+":"+c_pay_manage_no+":"+v_plan_pay_date;
            window.close();
        }

        /*
         * 결제 연동페이지에서 처리완료 (상품권은 처리안함)
         * pay_gubn     : 결제수단 (020:가상계좌, 030:계좌이체 040:신용카드 060:상품권
         * retn_code    : 응답코드
         *                0000:정상응답
         *                9999:사용자취소
         *                etc :van 오류코드
         * arr_param    : 결과값
         * 설 명 : retn_code가 0000이 아닌경우 result_param 에 에러 메시지를 뿌려준다.
         *       result_param의 구분자는 ":"으로 구분되면, 각각의 ds_... 의 칼럼 순서대로 넘어온다.
         */
        function fnAccountSuccess(pay_gubn, retn_code, result_param){
            fnHideLoading();;
            var arr_param = new Array();
            if(retn_code=="0000"){  //정상응답
                arr_param = result_param.split(":");
                //가상계좌
                if(pay_gubn == "020"){
                    getObjectFirst("ds_noaccount").UndoAll();
                    getObjectFirst("ds_noaccount").AddRow();
                    
                    for(var i=1; i<=getObjectFirst("ds_noaccount").CountColumn; i++)
                        getObjectFirst("ds_noaccount").ColumnString(getObjectFirst("ds_noaccount").CountRow, i) = arr_param[i-1];
                    
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:NOACCOUNT_TEMP=ds_noaccount_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    
                    getObjectFirst("ds_noaccount").NameValue(getObjectFirst("ds_noaccount").CountRow, "CLIENT_SID") = v_client_sid;
                    
                    v_plan_pay_date = arr_param[arr_param.length-1];
                    
                    var v_user_msg = "";
                    v_user_msg  = "가상계좌 정보　"
                                + "[입금은행 : "+ getObjectFirst("ds_noaccount").NameValue(getObjectFirst("ds_noaccount").CountRow, "BANK_NM")+"　"
                                + "가상계좌번호 : "+ getObjectFirst("ds_noaccount").NameValue(getObjectFirst("ds_noaccount").CountRow, "BANK_ACCT")+"]";
                    //alert(v_user_msg);
					prompt("가상 계좌번호 안내 : 아래 번호는 복사(Ctrl+c)하실 수 있습니다.",v_user_msg);
                //계좌이체
                } else if(pay_gubn == "030"){
                    getObjectFirst("ds_account").UndoAll();
                    getObjectFirst("ds_account").AddRow();
                    
                    for(var i=1; i<=getObjectFirst("ds_account").CountColumn; i++)
                        getObjectFirst("ds_account").ColumnString(getObjectFirst("ds_account").CountRow, i) = arr_param[i-1];
                    
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:ACCOUNT_TEMP=ds_account_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    
                    getObjectFirst("ds_account").NameValue(getObjectFirst("ds_account").CountRow, "CLIENT_SID") = v_client_sid;
                    
                //신용카드
                } else if(pay_gubn == "040"){
                    getObjectFirst("ds_card").UndoAll();
                    getObjectFirst("ds_card").AddRow();

                    for(var i=1; i<=getObjectFirst("ds_card").CountColumn; i++)
                        getObjectFirst("ds_card").ColumnString(getObjectFirst("ds_card").CountRow, i) = arr_param[i-1];
                    
                    getObjectFirst("ds_card").NameValue(getObjectFirst("ds_card").CountRow, "CLIENT_SID") = v_client_sid;
                    
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:CARD_TEMP=ds_card_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);

                    var v_user_msg = "";
                    v_user_msg  = "--------------------------------------------\n\n"
                                + "     승인번호 ("+ getObjectFirst("ds_card").NameValue(getObjectFirst("ds_card").RowPosition, "AGREE_NO") +")\n\n"
                                + "     입금확인 메뉴에서\n\n"
                                + "     결제결과를 확인하실 수 있습니다.\n\n"
                                + "--------------------------------------------";
                    alert(v_user_msg);
                } else {
                    alert("알수 없는 결제구분수단입니다. ["+ pay_gubn +"]");
                    return;
                }
            } else if(retn_code=="9999"){//사용자취소
                alert("사용자 취소를 선택하셨습니다.");
                return;
            } else {    //거절응답
                if(pay_gubn == "040"){
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:CARD_TEMP=ds_card_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    alert("결제 응답코드 : "+retn_code + "\n\n처리결과 : " + ds_card_temp.NameValue(1, "RESP_MSG"));
                } else if(pay_gubn == "020"){
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:NOACCOUNT_TEMP=ds_noaccount_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    alert("결제 응답코드 : "+retn_code + "\n\n처리결과 : " + ds_noaccount_temp.NameValue(1, "RESP_MSG"));
                } else if(pay_gubn == "030"){
                    ln_TRSetting(tr1, 
                        "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                        "JSP(O:ACCOUNT_TEMP=ds_account_temp)",
                        "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_pay_manage_no="+c_pay_manage_no);
                    tr_post(tr1);
                    alert("결제 응답코드 : "+retn_code + "\n\n처리결과 : " + ds_account_temp.NameValue(1, "RESP_MSG"));
                } else {
                    alert("결제 응답코드 : "+retn_code + "\n\n처리결과 : " + result_param);
                }
                return;
            }
            
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                "JSP(I:ACCOUNT=ds_account,I:NOACCOUNT=ds_noaccount,I:CARD=ds_card)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,v_client_cd="+v_client_cd);
            tr_post(tr_save);
        }
    </script>
<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnHideLoading();;

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr1" event="OnFail()">
    fnHideLoading();;
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnHideLoading();;

    fnPopClose();
</script>

<script language="javascript" for="tr_save" event="OnFail()">
    fnHideLoading();;
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

<script language="javascript" for="tr_save2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnHideLoading();;

    fnPopClose();
</script>
<script language="javascript" for="tr_save2" event="OnFail()">
    fnHideLoading();;
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save2.ErrorCode + "\n" + "Error Message : " + tr_save2.ErrorMsg + "\n");
</script>

<script language="javascript" for="gr_gift" event="OnExit(Row, Colid, OldData)">
    if(Row<1) return;
    
    if(Colid=="GIFT_TYPE" || Colid=="FR_GIFT_SEQ" || Colid=="TO_GIFT_SEQ"){
        if(getObjectFirst("ds_gift").NameValue(Row, "GIFT_TYPE")!=""
            && getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ")!=""
            && getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ")!="")
        {
            if(OldData != getObjectFirst("ds_gift").NameValue(Row, Colid)){
                getObjectFirst("ds_giftAmt").NameValue(Row, "PAY_QTY") = 0;
                getObjectFirst("ds_giftAmt").NameValue(Row, "PAY_AMT") = 0;
                
                for(var i=getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ").length; i<6; i++)
                    getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ") = "0"+getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ");
    
                for(var i=getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ").length; i<6; i++)
                    getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ") = "0"+getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ");
    
                var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                            + ",v_gift_type="+getObjectFirst("ds_gift").NameValue(Row, "GIFT_TYPE")
                            + ",v_fr_gift_seq="+getObjectFirst("ds_gift").NameValue(Row, "FR_GIFT_SEQ")
                            + ",v_to_gift_seq="+getObjectFirst("ds_gift").NameValue(Row, "TO_GIFT_SEQ");
                ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                    "JSP(O:GIFTAMT=ds_giftAmt,O:GIFTLIST=ds_giftList)",
                    v_param);
                tr_post(tr1);
            }
        }
    }
</script>

<script language="javascript" for="ds_giftAmt" event="OnLoadCompleted(row)">
    getObjectFirst("ds_gift").NameValue(getObjectFirst("ds_gift").RowPosition, "PAY_QTY") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_QTY");
    getObjectFirst("ds_gift").NameValue(getObjectFirst("ds_gift").RowPosition, "PAY_AMT") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_AMT");
</script>

<script language="javascript" for="ds_giftList" event="OnLoadCompleted(row)">
    if(row==0){
        getObjectFirst("div_giftList").style.display = "none";
        alert("상품권 상세정보내역이 없습니다.");
        return;
    }
    
    getObjectFirst("div_giftList").style.display = "inline";
</script>

<script language="javascript" for="ds_manage_no" event="OnLoadCompleted(row)">
    if(row==0){
        c_pay_manage_no = "";
        return;
    }
    c_pay_manage_no = ds_manage_no.NameValue(row, "PAY_MANAGE_NO");
</script>

<script language="javascript" for="ds_card_temp" event="OnLoadCompleted(row)">
    if(row==0) return;
    
    ds_card.NameValue(ds_card.CountRow, "ISSUE_COMPANY_NM") = ds_card_temp.NameValue(row, "ISSUE_COMPANY_NM")
    ds_card.NameValue(ds_card.CountRow, "CARD_COMPANY_NM") = ds_card_temp.NameValue(row, "CARD_COMPANY_NM")
</script>

<script language="javascript" for="ds_account_temp" event="OnLoadCompleted(row)">
    if(row==0) return;
    
    ds_account.NameValue(ds_account.CountRow, "ORDER_NM") = ds_account_temp.NameValue(row, "ORDER_NM")
    ds_account.NameValue(ds_account.CountRow, "AGREE_CUST_NM") = ds_account_temp.NameValue(row, "AGREE_CUST_NM")
    ds_account.NameValue(ds_account.CountRow, "BANK_NM") = ds_account_temp.NameValue(row, "BANK_NM")
</script>

<script language="javascript" for="ds_noaccount_temp" event="OnLoadCompleted(row)">
    if(row==0) return;
    
    ds_noaccount.NameValue(ds_noaccount.CountRow, "ORDER_NM") = ds_noaccount_temp.NameValue(row, "ORDER_NM")
    ds_noaccount.NameValue(ds_noaccount.CountRow, "AGREE_CUST_NM") = ds_noaccount_temp.NameValue(row, "AGREE_CUST_NM")
    ds_noaccount.NameValue(ds_noaccount.CountRow, "BANK_NM") = ds_noaccount_temp.NameValue(row, "BANK_NM")
</script>
<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds_card classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_card_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_account classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_noaccount classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_account_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_noaccount_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_tongjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_etc classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_accType classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gift classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_giftAmt classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_giftList classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_giftType classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_manage_no classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=excelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=MAIN_DS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
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
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

    </head>
  
<body bgcolor="#FFFFFF" OnLoad="fnOnLoad()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<!--  loading file 상태바 플레쉬  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	

	
        <table width="900" height="325" border="0" cellspacing="0" cellpadding="0" background="<%=dirPath%>/Sales/images/c_bg.gif">
            <tr>
                <td valign="top">
                    
                    <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr height="10">
                            <td colspan=5></td>
                        </tr>
                        
                        <tr>
                            <td width=5></td>
                            <td width="83" valign="top">
                                <table width="83" border="0" cellspacing="0" cellpadding="0" align=center>
                                    <tr id="tr_ac_0" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_01_on.gif" name="ac_0" onMouseOver="changesub(0)" onMouseOut="changesubout(0)" style="cursor:pointer;display:inline" onClick="changesubclick(0),fnOnChangTab(0)"></td>
                                    </tr>
                                    <tr id="tr_ac_1" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_02.gif" name="ac_1" onMouseOver="changesub(1)" onMouseOut="changesubout(1)" style="cursor:pointer;display:inline" onClick="changesubclick(1),fnOnChangTab(1)"></td>
                                    </tr>
                                    <tr id="tr_ac_2" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_03.gif" name="ac_2" onMouseOver="changesub(2)" onMouseOut="changesubout(2)" style="cursor:pointer;display:inline" onClick="changesubclick(2),fnOnChangTab(2)"></td>
                                    </tr>
                                    <tr id="tr_ac_3" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_04.gif" name="ac_3" onMouseOver="changesub(3)" onMouseOut="changesubout(3)" style="cursor:pointer;display:inline" onClick="changesubclick(3),fnOnChangTab(3)"></td>
                                    </tr>
                                    <tr id="tr_ac_4" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_05.gif" name="ac_4" onMouseOver="changesub(4)" onMouseOut="changesubout(4)" style="cursor:pointer;display:inline" onClick="changesubclick(4),fnOnChangTab(4)"></td>
                                    </tr>
                                    <tr id="tr_ac_5" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_06.gif" name="ac_5" onMouseOver="changesub(5)" onMouseOut="changesubout(5)" style="cursor:pointer;display:inline" onClick="changesubclick(5),fnOnChangTab(5)"></td>
                                    </tr>
                                    <tr id="tr_ac_6" style="display:inline">
                                        <td height="45"><img src="<%=dirPath%>/Sales/images/ac_07.gif" name="ac_6" onMouseOver="changesub(6)" onMouseOut="changesubout(6)" style="cursor:pointer;display:inline" onClick="changesubclick(6),fnOnChangTab(6)"></td>
                                    </tr>
                                </table>
                            </td>
                            <td width=5></td>
                            <td width=800 valign="top">
                                <table height="280" border="0" cellspacing="0" cellpadding="0" align="center">
                                    <tr>
                                        <td width="10" height="15"><img src="<%=dirPath%>/Sales/images/1.gif"></td>
                                        <td background="<%=dirPath%>/Sales/images/2.gif"></td>
                                        <td width="10"><img src="<%=dirPath%>/Sales/images/3.gif"></td>
                                    </tr>
                                    <tr>
                                        <td width="10" background="<%=dirPath%>/Sales/images/8.gif"></td>
                                        <td bgcolor="ffffcc" width=770>
                                        <!--------------------------------------------------------------------------- 
                                                                     가상계좌
                                        ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">구매자명</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_noaccount_nm" id="v_noaccount_nm" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">결제금액</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        <!--------------------------------------------------------------------------- 
                                                       계좌이체 정보
                                        ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">구매자명</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_account_nm" id="v_account_nm" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">결제금액</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                            <!--------------------------------------------------------------------------- 
                                                                  EDI 카드 정보
                                            ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td width=30><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">결제금액</td>
                                                    <td width=230 bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
	                                                <td rowspan=7>전자문서교환(EDI [Electronic Data Interchange]) 방식의 <br>
	                                                	신용카드 결제입니다.<br><br>
	                                                	신용카드 번호와 유효기간만 있으면<br>
	                                                	승인할 수 있어, 대행 승인이 가능합니다.<br>
	                                                	(전화승인과 동일한 방식입니다.)<br><br>
	                                                	신용카드 전표를 발행할 수 없어<br>
	                                                	영수증으로 갈음합니다.<br>
	                                                </td>

                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">카드번호</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=r_card_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='150px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="0000-0000-0000-0000">
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>   
                                                    <td width="70" height="30" align="center">유효기간</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=v_expire_year classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='30px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="00">
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        &nbsp;년&nbsp;&nbsp;
                                                        
                                                        <object id=v_expire_month classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='30px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="00">
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        &nbsp;월
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">할부기간</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<select name="r_halbu_terms">
                                                            <option value="00">일시불
                                                            <option value="02">2개월
                                                            <option value="03">3개월
                                                            <option value="04">4개월
                                                            <option value="05">5개월
                                                            <option value="06">6개월
                                                            <option value="07">7개월
                                                            <option value="08">8개월
                                                            <option value="09">9개월
                                                            <option value="10">10개월
                                                            <option value="11">11개월
                                                            <option value="12">12개월
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">승인번호</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=r_agree_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=IsComma     value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">결제일자</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=r_org_agree_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=Format      value=YY-MM-DD>
                                                            <param name=InputFormat value=YYYYMMDD>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">BC 카드 </td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input type=checkbox name=topChk id=topChk> BC Top포인트 사용여부
                                                    </td>
                                                </tr>


                                            </table>
                                            <!--------------------------------------------------------------------------- 
                                                                      상품권 정보
                                            ---------------------------------------------------------------------------->
                                            <table width="770" height="100%" border="0" cellspacing="0" cellpadding="0" id="ac" style="display:none" valign="abstop">
                                                <tr height="30">
                                                    <td align="right">
                                                        <table width="270" height="30" border="0" cellpadding="0" cellspacing="0" >
                                                            <tr>
                                                                <td align="right"><img src="<%=dirPath%>/Sales/images/add.gif" style="cursor:pointer" onClick="fnGiftAdd()"></td>
                                                                <td width="60" align="right"><img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:pointer" onClick="fnGiftDel()"></td>
                                                                <td width="68" align="center"><img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:pointer" onClick="fnGiftCancel()"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign=top>
                                                        
                                                        <object id=gr_gift classid=<%=HDConstant.CT_GRID_CLSID%> style="width=770; height:160px;border:1 solid #777777;">
                                                            <param name="DataID"        value="ds_gift">
                                                            <param name="BorderStyle"   value="0"> 
                                                            <param name="ColSizing"     value="true">
                                                            <param name="Editable"      value="True">
                                                            <Param Name="UsingOneClick"     value="1">
                                                            <Param Name="AllShowEdit"       value="True">
                                                            <param name="Format"        value="
                                                                <c> Name='권종'        ID='GIFT_TYPE'     EditStyle=Lookup Data='ds_giftType:detail:detail_nm' Width=65  align=center </c>
                                                                <c> Name='시작'        ID='FR_GIFT_SEQ'   Edit=Numeric EditLimit=6 Width=45</c>
                                                                <c> Name='종료'        ID='TO_GIFT_SEQ'   Edit=Numeric EditLimit=6 Width=45</c>
                                                                <c> Name='매수'        ID='PAY_QTY'       Edit=None Width=40</c>
                                                                <c> Name='금액(천원)'   ID='PAY_AMT'       Edit=None Width=75</c>
                                                            ">
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="10"></td>
                                                </tr>
                                                <tr id="div_giftList" style="display:none">
                                                    <td valign=top>
                                                        
                                                        <object id=gr_giftList classid=<%=HDConstant.CT_GRID_CLSID%> style="width=100%; height:160px;border:1 solid #777777;">
                                                            <param name="DataID"        value="ds_giftList">
                                                            <param name="BorderStyle"   value="0"> 
                                                            <param name="ColSizing"     value="true">
                                                            <param name="Editable"      value="False">
                                                            <Param Name="UsingOneClick"     value="1">
                                                            <Param Name="AllShowEdit"       value="True">
                                                            <param name="Format"        value="
                                                                <c> Name='일련번호'     ID='GIFT_SEQ'     Edit=None Width=65 align=center</c>
                                                                <c> Name='상태'        ID='GIFT_STATE'   Edit=None Width=45 align=center</c>
                                                                <c> Name='유효기간'     ID='EFFICACY_DAY' Edit=None Width=65 align=center</c>
                                                                <c> Name='금액(천원)'   ID='PAY_AMT'      Edit=None Width=75</c>
                                                            ">
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                            <!--------------------------------------------------------------------------- 
                                                                무통장입금
	                                        ---------------------------------------------------------------------------->
                                            <table width="770" height="100%" border="0" cellspacing="0" cellpadding="0" id="ac" style="display:none" valign="abstop">
                                                <tr>
                                                	<TD>
                                                		<table width=100%>
                                                		   <tr>
										                        <td align="left" width="70" height="10" class="text">계좌번호</td>
																<td >&nbsp;<input name="v_bank_acc_no" id="v_bank_acc_no" type="text" style="width:130px;" class="textbox" readOnly>
			                                                    	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" align='absmiddle' onClick="fnBankAccountPopup()">
			                                                    </td>
                                                    			<td align="left" width="70" height="10" class="text">은행</td>
			                                                    <td >&nbsp;<input name="v_bancod" type="text" style="width:50px;" class="textbox" readOnly>
            			                                        	<input type="text" name="v_banknm" size="10" class="textbox" readonly></td>
            			                                        <td colspan=2 align="right" ><img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:pointer" onClick="fnSelect()"></td>
                        			                        </tr>
															<tr>
	                                                            <td align="left" width="70" height="10" class="text">결제금액</td> 
            			                                        <td >&nbsp;
                        			                                <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height="17" width='100px' align='absmiddle' class='textbox'>            
                                    			                        <param name=Alignment   value=1>
                                                			            <param name=ClipMode    value=true>
			                                                            <param name=Border      value=false>
            			                                                <param name=Enable      value=false>
                        			                                    <param name=SelectAll   value=true>
                                    			                        <param name=SelectAllOnClick      value=true>
                                                			            <param name=SelectAllOnClickAny   value=false>
			                                                        </object>
            			                                            
                                               				    </td>
																<td align=left width="70" height="10" class="text">입금일자</td>
																<td align=left>&nbsp;
																     
																     <object id=c_pay_date1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height="17" width="100"  class="textbox">
																		<param name=Alignment 	value=1>
																		<param name=Format      value="YYYY-MM-DD">
			                                        					<PARAM NAME=InputFormat value="YYYYMMDD">
																		<param name=ClipMode    value=true>
			                                                            <param name=Border      value=false>
			                                                            <param name=Enable      value=true>
			                                                            <param name=SelectAll   value=true>
			                                                            <param name=SelectAllOnClick      value=true>
			                                                            <param name=SelectAllOnClickAny   value=false>
			                                                            <param name=text value="">
																	</object>
																	&nbsp;
																</td>											  
																<td align="center" width="70" height="10" class="text">적 요</td>       
																<td valign="middle">&nbsp;&nbsp;<input type=text name=v_order_nm id=v_order_nm class="textbox"></td>
			                                                </tr>
			                                             </table>
			                                          </td>
			                                        </tr>
			                                        <tr>
			                                        	<td height=180>
															
															<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="770" height="170" border="1">
															        <param name="DataID"            value="ds_tongjang">
															        <param name="BorderStyle"       value="0">
															        <param name="ColSizing"         value="True">
															        <param name="editable"          value="True">
															        <param name=SortView  			value="Left">
															        <param name="indwidth"			value="20">
															        <Param Name="UsingOneClick"     value="1">
															        <Param Name="AllShowEdit"       value="True">
															        <param name="Format"            value="
																	        <FC> name='선택'        ID='JOB_SEL'        Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False bgColor={IF(REMAINED_DEPOSIT_AMT>0,'#FF0000','#0000FF')}</FC>
																			<C> name='계좌번호'    	ID='v_bank_acc_no'  Width=100  align=center  show=true 	edit=none</C>
															                <C> name='입금일자'    	ID='c_pay_date1'  	Width=100  align=center  show=true 	edit=none</C>  
															                <C> name='거래구분'  	ID='COL02'    		Width=100  align=center  show=true	edit=none</C>
															                <C> name='적요'     	ID='v_order_nm'    	Width=130  align=left  	 show=true	edit=none</C>
															                <C> name='취급점'   	ID='v_banknm'   	Width=80   align=center  show=true	edit=none</C>
														                    <C> name='입금액'    	ID='c_pay_amt'   	Width=70   align=RIGHT 	 show=true  edit=none	DEC=0</C>
														                    <C> name='사용액' 	    ID='c_use_amt' 		Width=70   align=RIGHT   show=true	edit=none   DEC=0</C>
															                <C> name='잔액'    		ID='c_balance_amt'	Width=70   align=RIGHT   show=true	edit=none   DEC=0</C>

															                <C> name='은행코드'   	ID='v_bancod'   	Width=100  align=center  show=false	edit=none</C>
															                <C> name='TR_SID'    	ID='TR_SID'  		Width=100  align=left    show=false	edit=none</C>

															        ">
															</object>
															
														</td>
													</tr>
												</table>
                                              <!--------------------------------------------------------------------------- 
																				기타대체
	                                        ---------------------------------------------------------------------------->
                                            <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">계정과목</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
					                                    <object id=v_acc_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
					                                        <param name=ComboDataID     value=ds_accType>
					                                        <param name=ListExprFormat  value="detail_nm^0^100">
					                                    </object>
					                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">입금자명</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_pay_empnmk" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">입금일자</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Format      value="YYYY-MM-DD">
                                        					<PARAM NAME=InputFormat value="YYYYMMDD">
                                        					<param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=true>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                            <param name=text value="<%=totDay%>">
                                                        </object>
                                                        
                                                      </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">결제금액</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        <!--------------------------------------------------------------------------- 
															KCP 온라인 신용카드
                                        ---------------------------------------------------------------------------->
                                            <table width="770" border="0" cellspacing="0" cellpadding="0" align="center" id="ac" style="display:none">
                                                <tr>
                                                    <td width=30><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">구매자명</td>
                                                    <td width=230 bgcolor="#FFFFCC">&nbsp;&nbsp;<input name="v_noaccount_nm" id="v_noaccount_nm" type="text" style="width:100px;" maxlength=10 class="textbox" OnKeyUp="cfLengthCheck(this, 10)" onBlur="cfLengthCheck(this, 10)"></td>
	                                                <td rowspan=2>일반적인 온라인 신용카드 결제방식입니다.<br><br>
	                                                	
	                                                	카드 소유자 본인이 직접 결제해야 하고,<br>
	                                                	공인인증서/안심클릭 등<br>
	                                                	암호화된 온라인 서명 절차를 따릅니다.<br><br>
	                                                	
	                                                	신용카드 전표를 발행할 수 있습니다.<br>
	                                                </td>
                                                </tr>
                                                <tr>
                                                    <td><img src="<%=dirPath%>/Sales/images/red_dot01.gif"></td>                                       
                                                    <td width="70" height="30" align="center">결제금액</td>
                                                    <td bgcolor="#FFFFCC">&nbsp;&nbsp;
                                                        <object id=c_pay_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                            <param name=Alignment   value=1>
                                                            <param name=ClipMode    value=true>
                                                            <param name=Border      value=false>
                                                            <param name=Enable      value=false>
                                                            <param name=SelectAll   value=true>
                                                            <param name=SelectAllOnClick      value=true>
                                                            <param name=SelectAllOnClickAny   value=false>
                                                        </object>
                                                        
                                                    </td>
                                                </tr>
                                            </table>

                                        </td>
                                        <td background="<%=dirPath%>/Sales/images/4.gif"></td>
                                    </tr>
                                    <tr  height="10">
                                        <td><img src="<%=dirPath%>/Sales/images/7.gif"></td>
                                        <td background="<%=dirPath%>/Sales/images/6.gif"></td>
                                        <td><img src="<%=dirPath%>/Sales/images/5.gif"></td>
                                    </tr>
                                </table>
                            </td>
                            <td width=5></td>
                        </tr>
                        <tr height="10">
                            <td colspan=5></td>
                        </tr>                        
                    </table>
                    
                    <table width="100%" height="35" bgcolor="#66CCFF">
                        <tr>
                            <td width="250"></td>
                            <td align=right>
                            <%
                                if(v_card_no.equals("")){
                            %>
                                <img name=ac_btn_0 id=ac_btn_0 style="display:none; cursor:pointer" onClick="fnNonAccountTrans()"  	src="<%=dirPath%>/Sales/images/create.gif">
                                <img name=ac_btn_1 id=ac_btn_1 style="display:none; cursor:pointer" onClick="fnAccountTrans()" 		src="<%=dirPath%>/Sales/images/acc_transfer.gif">
                                <img name=ac_btn_2 id=ac_btn_2 style="display:none; cursor:pointer" onClick="fnCardTrans()"  		src="<%=dirPath%>/Sales/images/account.gif" alt="카드결제">
                                <img name=ac_btn_3 id=ac_btn_3 style="display:none; cursor:pointer" onClick="fnGiftTrans()"  		src="<%=dirPath%>/Sales/images/account.gif">
                                <img name=ac_btn_4 id=ac_btn_4 style="display:none; cursor:pointer" onClick="fnTongJangTrans()"  	src="<%=dirPath%>/Sales/images/account.gif">
                                <img name=ac_btn_5 id=ac_btn_5 style="display:none; cursor:pointer" onClick="fnEtcTrans()"  		src="<%=dirPath%>/Sales/images/account.gif">
                                <img name=ac_btn_6 id=ac_btn_6 style="display:none; cursor:pointer" onClick="fnEtcTrans()"  		src="<%=dirPath%>/Sales/images/account.gif">
                            <%
                                } else {
                            %>
                                <img name=ac_btn_2 id=ac_btn_2 style="display:none; cursor:pointer" onClick="fnCardCancel()"  		src="<%=dirPath%>/Sales/images/adm_cancel.gif" alt="카드취소">
                            <%
                                }
                            %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td><br><h3>　　※ 안정적인 결제 진행을 위해 다른 마우스나 키보드 조작은 잠시 멈춰주시기 바랍니다.</h3>
                    <form name="acc_frm" method=post target="acc_iframe">
                        <!-- common -->
                        <input type=hidden name="c_pay_gubn">
                        <input type=hidden name="c_pay_manage_no">
                        <input type=hidden name="c_van_cd">
                        <input type=hidden name="c_pay_amt">
                        <input type=hidden name="c_acct_join_no">
                        <input type=hidden name="c_terminal_id">
                        <input type=hidden name="c_return_url" value="<%=HDConstant.KCP_RETURN_URL_ERP%>">
                        
                        <!-- account / noaccount request -->
                        <input type=hidden name="r_order_nm">
                        <input type=hidden name="r_order_email">
                        <input type=hidden name="r_user_key">
						<input type=hidden name="TR_SID">

                        <!-- card request -->
                        <input type=hidden name="r_app_type">
                        <input type=hidden name="r_card_no">
                        <input type=hidden name="r_valid_terms">
                        <input type=hidden name="r_halbu_terms">
                        <input type=hidden name="r_card_way_cd">
                        <input type=hidden name="r_agree_no">
                        <input type=hidden name="r_org_agree_date">
                        <input type=hidden name="r_remark">
                    </form>
                 </td>
            </tr>
        </table>
        
        <iframe name="acc_iframe" frameborder="0" height="0" width="0" marginheight="0" marginwidth="0" scrolling="yes" src=""></iframe>
  </body>
</html>