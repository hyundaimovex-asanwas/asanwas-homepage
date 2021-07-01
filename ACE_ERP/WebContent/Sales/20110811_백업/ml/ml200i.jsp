<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 직원 면세 복지품 입력 / 조회
 * 프로그램ID 	: DF310I
 * J  S  P		: df310i
 * 서 블 릿		: Df310I
 * 기능정의		: 직원 면세 복지품 입력 / 조회
 * [ 수정일자 ][수정자] 내용
 * [2010-09-25][심동현] 신규 작성
 * [2010-10-18][심동현] 새 메뉴트리 적용
 * [2011-01-11][심동현] 몰 관리자의 결제화면이라고 하면 다양한 결제방법을 제공해야 정상이겠지?
 * [2011-10-12][심동현] 가상, 신용카드(EDI), 무통장입금 3개는 있어야 할 
 
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
    String endDay = m_today.format(date.getTime());
    date.add(java.util.Calendar.DATE, -2);        
    String startDay = m_today.format(date.getTime());           

	   
	//쿠키불러오기 시작
	String v_login_name ="";
	String v_login_id = "";
	Cookie cookies[] = request.getCookies();
     if(cookies != null) {
          for(int i=0; i<cookies.length; i++){
               if(cookies[i].getName().equals("vusrid") ) {
                    v_login_id = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
               }
               if(cookies[i].getName().equals("vusrnm") ) {
                    v_login_name = cookies[i].getValue() ;	//=> cookie에서 값 추출할때 사용                             
               }
          }
     } 
	//쿠키불러오기 끝
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
        var c_pay_manage_no     = "";   //결제 관리번호
        
        
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		div = 'init';
		fnInit(); 
	}

	function fnInit(){
   		sBgnDate.text='<%=startDay%>';
   		sEndDate.text='<%=endDay%>';
		
		cfStyleGrid(getObjectFirst("gr1"), "comn");
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML001&s_item1=Y";
        codeDs1.Reset();
		
	}


	function fnSelect() {
		v_job = "S";
		v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                + ",dsType=1"
	            + ",sBgnDate=" + sBgnDate.text
	            + ",sEndDate=" + sEndDate.text
	            + ",sTr_OrderNm=" + getObjectFirst("sTr_OrderNm").value
                + ",sTrGu=" + sTrGu.ValueOfIndex("detail", sTrGu.Index);

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml200I", 
            "JSP(O:DS_MAIN=ds1)",
            v_param);
        tr_post(tr1);
	}

	function fnApply() {
	}


	//직원검색 팝
	function fnOrdererPopup(){
	    var strURL = "<%=dirPath%>/Coopbiz/help/sy030h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
    	
		if(return_value!=undefined){
			var arrParam = return_value.split(";");
            getObjectFirst("sUserId").value = arrParam[0];
            getObjectFirst("sUserNm").value = arrParam[1];
		}
	}

	//요금 결제버튼 전체
    function fnAccount() {
        var v_sel_cnt = 0;
        var v_account_amt = 0;
        var v_client_cd = "";
        var v_client_sid = 0;
        var v_pay_method ="00101000"; 	//결제방법 비트 배열^^ 
			        					//쇼핑몰용: 가상, 신용카드EDI, 무통장, 신용카드 Online Direct(전액 결제일 때만)

        if(getObjectFirst("ds1").CountRow==0){
            alert("먼저 조회후 클릭하시길 바랍니다.");
            return;
        }
        
        for(var i=1; i<=getObjectFirst("ds1").CountRow; i++){
            if( getObjectFirst("ds1").NameValue(i, "JOB_SEL")=="T" ){
                v_sel_cnt++;
                v_account_amt += getObjectFirst("ds1").NameValue(i, "PAYING_AMT");
                v_client_cd = getObjectFirst("ds1").NameValue(i, "CLIENT_CD");
                v_client_sid = getObjectFirst("ds1").NameValue(i, "CLIENT_SID");
                
              
                if(getObjectFirst("ds1").NameValue(i, "PAYING_AMT")==0){
                    alert("결제할 금액을 입력하시길 바랍니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAYING_AMT");
                    return;
                }
                
                if(eval(getObjectFirst("ds1").NameValue(i, "PAYING_AMT"))>eval(getObjectFirst("ds1").NameValue(i, "ARREARS_AMT"))){
                    alert("결제할 금액이 현재 미납액 보다 더 많은 금액입니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAYING_AMT");
                    return;
                }

				//루프를 돌다가 1건이라도 주문총액을 결제하는 것이 아니면 다이렉트 불가
                if(getObjectFirst("ds1").NameValue(i, "PAYING_AMT")!=getObjectFirst("ds1").NameValue(i, "AMT_EXCH")){
					v_pay_method ="00101000"; 
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
        var v_pay_date = "<%=DateUtil.getCurrentDate(8)%>";	//여기서 입금일자 디폴트 세팅을 해부리네..우씨..;
        var v_pay_cd = "";
        var v_plan_pay_date = "";   //입금예정일자
        
        /**결제 항목
         * arrParam[0]
         * 0 : 가상계좌 이체
         * 1 : 계좌이체 (사용안함)
         * 2 : 신용카드 EDI
         * 3 : 상품권결제
         * 4 : 무통장입금
         * 5 : 기타대체
         * 6 : 신용카드 Online
         */

		//쇼핑몰용:가상, 신용카드EDI, 무통장, 신용카드 Online 끝
        arrParam[0] = v_pay_method;
        arrParam[1] = v_client_cd;
        arrParam[2] = v_account_amt;
        arrParam[3] = ds1.NameValue(ds1.RowPosition, "ORDER_GUBN");//거래구분 
        
        arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";     //단말기번호
        arrParam[5] = "<%=HDConstant.KCP_TERM_ID%>";    //계좌이체 및 가상계좌 터미널 ID
        arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP%>";  //계좌이체 및 가상계좌 가맹점 번호
        arrParam[7] = v_client_sid;                     //대리점 Sid
        arrParam[8] = ds1.NameValue(ds1.RowPosition, "USER_NM");
        arrParam[9] = ds1.NameValue(ds1.RowPosition, "ORDER_NO");        // 주문번호(다이렉트 결제시 아이디로 사용)
//prompt("","<%=dirPath%>");
//prompt("",arrParam);
//alert(arrParam);

		//여기서 결제창 팝!
        arrResult = fnCreditPop_mall("<%=dirPath%>", arrParam);
//alert("arrResult : " + arrResult);	//여기서는 제대로 받아오는 무통입금일자..

		//결제 후 리턴 값으로 업데이트 하는 부분.. 
        if(arrResult!=null && arrResult!=undefined){
            arrParam = arrResult.split(":");
            v_pay_cd = arrParam[0];			//040:1101180002	카드edi의 경우 이렇게 받아온다.
            v_pay_manage_no = arrParam[1];
            if(arrParam.length>2)
                v_plan_pay_date = arrParam[2];	//가상계좌의 경
            
//alert("arrParam : " + arrParam + " v_pay_cd : " +  v_pay_cd + " v_pay_manage_no : " + v_pay_manage_no);
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_client_cd="+v_client_cd
                        + ",v_pay_manage_no="+v_pay_manage_no
                        + ",v_account_amt="+v_account_amt
                        + ",v_pay_date="+v_pay_date
                        + ",v_pay_cd="+v_pay_cd
                        + ",v_plan_pay_date="+v_plan_pay_date;
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_ML%>Ml200I",
                "JSP(I:DEFAULT=ds1)",
                v_param);
            tr_post(tr_save);

        }
    }

	function fnPayApply(pay_manage_no){
		alert("결제결과 업데이트");

   		var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
		   	        + ",v_pay_manage_no="+pay_manage_no
					;
	        				
		ln_TRSetting(tr1,
			   		"<%=dirPath%>/servlet/coopbiz.menu.df.Df310I",
		           	"JSP(I:DS1=ds1)",
   			        v_param);
		tr_post(tr1);
	}


    //결제 관리 번호 추출
    function fnGetManageNo(){
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
            "JSP(O:PAY_MANAGE_NO=ds_manage_no)",
            "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_client_cd=10135");
        tr_post(tr1);
    }

	//카드 영수증 팝업
	function popReceipt(idx){
		var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
	   	window.open(receiptURL,"cardReceipt","width=386,height=760,top=0,left=0, scrollbars=1");
	}

	//명세서  팝업
	function popConfirm(order_sid){
		var receiptURL ="http://com.hdasan.com/shop_statement.asp?order_sid=" + order_sid;
	   	window.open(receiptURL,"shopStatement","width=730,height=670,scrollbars=yes,toolbar=no,menubar=yes,location=no,directories=no,top=100,left=100,noresize");
	}
	
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>


<script language=javascript for="gr1" event="OnClick(Row,Colid)">
	//제목 클릭했을 때
    if(Row==0) {
        if(Colid == "JOB_SEL"){
            for(var i=1; i<=ds1.CountRow; i++){
//            alert(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT"));
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                
                if(getObjectFirst("ds1").NameValue(i, Colid)=="T")
                    getObjectFirst("ds1").NameValue(i, "PAYING_AMT")=getObjectFirst("ds1").NameValue(i, "ARREARS_AMT");
                else
                    getObjectFirst("ds1").NameValue(i, "PAYING_AMT")=0;
            }
        }else if(Colid == "PAYING_AMT"){
            for(var j=1; j<=ds1.CountRow; j++){
      	        // alert(getObjectFirst("ds1").NameValue(j,"PAYING_AMT"));
       	         ds1.NameValue(j, Colid) = ds1.NameValue(1, Colid);
           };
         }   
        return;
    }


    if(Colid=="JOB_SEL"){
		//기존 클릭이벤트 
        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T"){
            getObjectFirst("ds1").NameValue(Row, "PAYING_AMT")=getObjectFirst("ds1").NameValue(Row, "ARREARS_AMT");
//            getObjectFirst("ds1").NameValue(Row, "PAYING_AMT")=1001;
        }else{
            getObjectFirst("ds1").NameValue(Row, "PAYING_AMT")=0;
        };

	    if(getObjectFirst("ds1").NameValue(Row, "AMT_PAID")>getObjectFirst("ds1").NameValue(Row, "AMT_EXCH")){
	        alert("주문총액보다 입금액이 더 많습니다.결제하실 수 없습니다.");
	        ds1.Undo(ds1.RowPosition);
	    };
	};	
	
/*    if(Colid=="PAY_YN"){
		//결제여부 Y면 카드 영수증 보여주기
		if(getObjectFirst("ds1").NameValue(Row, "PAY_YN")=="Y"){
			popReceipt(getObjectFirst("ds1").NameValue(Row, "VAN_IDX_NO"));
		}else{
	        alert("결제내역이 없습니다.");
		};
	};	*/
    
</script>

<script language=JavaScript for="gr1" event="OnRButtonUp(Row, Colid, xpos, ypos)">
	//우측버튼 클릭하면 명세창 팝
 	popConfirm(ds1.namevalue(Row, "ORDER_SID"));	//주문sid
</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<script language="javascript" for="ds_manage_no" event="OnLoadCompleted(row)">
    if(row==0){
        c_pay_manage_no = "";
        return;
    }
    c_pay_manage_no = ds_manage_no.NameValue(row, "PAY_MANAGE_NO");
</script>

<script language=JavaScript for=sBgnDate event=OnKillFocus()>
   if( sBgnDate.Modified == true )
		sEndDate.text = sBgnDate.text;
</script>

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

<object id=ds_manage_no classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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

		
				<tr height="35px">
					<td>
						<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
							<tr>
		                        <td align="center" width="90px" height="30px" class="text">거래구분</td>
								<td align="left" bgcolor="#ffffff" >&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^130">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="35px">
					<td>
						<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
							<tr>
								<td align=left width=90 class="text">주문일자</td>
								<td align=left bgcolor="#ffffff" width=300>&nbsp;
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
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align="center" width="90px" height="30px" class="text">주문자명</td>       
								<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_OrderNm id=sTr_OrderNm class="textbox"></td>
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
                            <FC> name='전체√'       ID='JOB_SEL'        Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </FC>
                            <FC> name='NO'          ID='{CURROW}'       Width=30   edit=none align=center</FC>
							<C> name='거래구분'		ID='ORDER_GUBN'	Width=60  align=center  show=true	Edit=none editstyle=lookup  data='codeDs1:detail:detail_nm' </C>
							<C> name='주문번호'    	ID='ORDER_NO'  	Width=85  align=center  show=true	Edit=none 	</C>
							<C> name='주문일자'    	ID='ORDER_DATE'	Width=60  align=center  show=true	Edit=none 	</C>
							<C> name='일련번호'    	ID='COL04'  	Width=55  align=center  show=false 	Edit=none</C>
							<C> name='주문자명'   	ID='USER_NM'  	Width=60  align=center  show=true	Edit=none 	</C>
							<C> name='연락처1'      ID='MOBILE_NO'  Width=85  align=center  show=true	Edit=none 	</C>
							<C> name='제품\\갯수'	ID='ITEM_CNT'  	Width=35  align=center  show=true	Edit=none decao=0	 	sumtext=@sum</C>
							<C> name='주문총액'		ID='AMT_EXCH'  	Width=70  align=center  show=true	Edit=none decao=0	align=Right 	sumtext=@sum</C>
                          <G> name='입금액'
                            <C> name='입금액'		ID='AMT_PAID'    Width=60   SumText=@sum Edit=none align=Right Decao=0</C>
                            <C> name='미입금액'		ID='AMT_NOT_PAID'   Width=60  SumText=@sum Edit=none align=Right Decao=0</C>
                            <C> name='미승인액'		ID='AMT_ONLINE_DR'	Width=60  SumText=@sum Edit=none align=Right Decao=0</C>
                          </G>
                            <C> name='미납액'		ID='ARREARS_AMT'    Width=60   SumText=@sum Edit=none align=Right Decao=0</C>
                            <C> name='결제액'		ID='PAYING_AMT'        Width=60   SumText=@sum Edit=Numeric Decao=0 align=Right</C>

							

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
         	<table width=100%>
         	  <tr>
         	  	<td valign=top width=50%>
		         ※ 그리드의 행을 우클릭하면<br>
		         　　 해당 주문번호의 명세서 창이 뜹니다.
         	  	</td>
         	  	<td valign=top width=50%>
		         ※ 온라인카드 다이렉트의 경우는 <B>전액결제</B>만 가능합니다.<br>
         	  	</td>         	  	
         	  </tr>
         	</table>
         </td>
     </tr>
</table>




<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


