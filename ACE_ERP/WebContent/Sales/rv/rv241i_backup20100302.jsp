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
 * [2010-03-02][심동현] GRID 싹 수
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

        fnInit(); 
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : 선조회 
// Parameter    : 
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
		cfStyleGrid(getObjectFirst("gr2"), "comn1");
        getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        getObjectFirst("ds_goods").Reset();
        
        //사업구분
        // 사용(item1) Y	// 사업자(item3) Y
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CU004&s_item1=Y&s_item3=Y";
        codeDs1.Reset();
        
        //할인유형(cust_type)	
        // 사용(item1) Y	// 사업자(item4) Y
        codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV003&s_item1=Y&s_item4=Y"; 
        codeDs2.Reset();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
    function fnSelect() {
       // if(getObjectFirst("sClientSid").value==""){
       //     alert("대리점을 먼저 선택하시길 바랍니다.");
       //     return;
       // }
        
        if(getObjectFirst("sSDate").Text.trim()=="" || getObjectFirst("sSDate").Text.trim().length!=8){
            alert("출발일자(From)를 입력하시길 바랍니다.");
            getObjectFirst("sSDate").Focus();
            return;
        }
        
        if(getObjectFirst("sEDate").Text.trim()=="" || getObjectFirst("sEDate").Text.trim().length!=8){
            alert("출발일자(To)를 입력하시길 바랍니다.");
            getObjectFirst("sEDate").Focus();
            return;
        }
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sClientSid="+getObjectFirst("sClientSid").value
                    + ",sGoodsSid="+sGoodSid.ValueOfIndex ("GOODS_SID", sGoodSid.Index)
                    + ",sSDate="+getObjectFirst("sSDate").Text
                    + ",sEDate="+getObjectFirst("sEDate").Text
                    + ",sAcceptNo="+getObjectFirst("sAcceptNo").Text
                    + ",sCustNm="+getObjectFirst("sCustNm").value;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
            "JSP(O:DS1=ds1)",
            v_param);
            

        tr_post(tr1);
        
		if(getObjectFirst("sAcceptNo").Text == "" ){
            getObjectFirst("save_amt_btn").style.display = "none";
		}
    }


   function fnSelectDs2() {
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sRsvSid="+ds1.namevalue(ds1.rowposition, "RSV_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
            "JSP(O:DS2=ds2)",
            v_param);
        tr_post(tr2);
    }

    //판매가 계산 로직
    function fnSaveAmt(){
        v_job = "C";

        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
            "JSP(O:DS2=ds_result)",
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,v_accept_sid="+v_accept_sid);
        tr_post(tr2);
    }

    
    
   /**
     * 적용 함수
     */
    function fnApply() {    
        if (ds1.IsUpdated) {
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac120I",
                "JSP(I:DS2=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr1);
        } else {
            alert("변경 내역이 없습니다.");
        }
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
        getObjectFirst("gr1").SetExcelTitle(1, "value:적용객실 요금 수정; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("적용객실 요금 수정", "적용객실 요금 수정.xls", 8);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  협력업체팝업
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            sClientSid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          sClientSid.value = "";
			getObjectFirst("save_amt_btn").style.display = "none";
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
            getObjectFirst("sAcceptNo").Text   = arrParam[1];
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

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        getObjectFirst("save_amt_btn").style.display = "none";
	}

    if(v_accept_sid!=""){
    	getObjectFirst("save_amt_btn").style.display = "inline";
    }	
</script>

<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
	if (row <= 0) {
		return;
	}
	fnSelectDs2();
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">협력업체코드</td>
                                <td align="left" bgcolor="#ffffff" colspan='4'>&nbsp;<input type="text" value="" name="v_client_cd" id="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                  
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="협력업체코드를 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                  
                                    <input type="text" value="" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="" name="sClientSid" readOnly>
                                </td>
                                
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">상품코드</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sGoodSid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=180 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^150">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            
                                <td width="100px" height="25px" class="text">출발일자</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sSDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=sEDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">신청서번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=sAcceptNo classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000000000000">
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
                                <td width="100px" height="25px" class="text">성명</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
                
                <tr>
                	<td>
                		 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=520>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=520; height:430px" border="1">
                            <param name="DataID"            value="ds1">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
								<C> name='순번'     		ID='KEY_SEQ'   		Width=50   	align=Left 	Edit=none  show=false  SumText=합계 </C>
								<C> name='출발일자'       	ID='DEPART_DATE'    Width=60   	align=Left 	Edit=none suppress=1 mask='XXXXXXXX'</C>
								<C> name='복귀일자'       	ID='ARRIVE_DATE'    Width=60   	align=Left 	Edit=none suppress=2 mask='XXXXXXXX'</C>
								<C> name='박수'       		ID='NIGHTS' 	    Width=35   	align=center	Edit=none suppress=3</C>
								<C> name='신청번호'       	ID='ACCEPT_NO'      Width=90    align=center 	Edit=none suppress=4</C>
								<C> name='성명'           	ID='CUST_NM'        Width=60   	align=Left 	Edit=none   </C>
								<C> name='사업구분'        	ID='SAUP_GU'        Width=60   	align=Left 	editstyle=lookup data='codeDs1:detail:detail_nm'</C>
								<C> name='할인유형'        	ID='CUST_TYPE'      Width=110   	align=Left 	editstyle=lookup data='codeDs2:detail:detail_nm'  </C>
								
								<C> name='객실코드'     	ID='ROOM_TYPE'   	Width=60   	align=Left 	Edit=none   suppress=4</C>
								<C> name='판매가'         	ID='TOT_TOUR_AMT'  		Width=70   	align=Right Edit=none SumText=@sum  Dec=0</C>
								<C> name='입금액'         	ID='TOT_PAY_AMT'   Width=70   	align=Right Edit=none SumText=@sum  Dec=0</C>
								<C> name='주민/여권번호'	ID='MANAGE_NO'      Width=100	align=Left 	Edit=none   show=false</C>
								<C> name='예약SID'         	ID='RSV_SID'    	Width=70   	align=Right Edit=none   show=false</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                                        
                     <td width=290>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=290; height:430px" border="1">
                            <param name="DataID"            value="ds2">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
								<C> name='순번'     	ID='KEY_SEQ'   		Width=40   	align=center	Edit=none </C>
								<C> name='품목'       	ID='MENU_NM' 		Width=90  	align=Left 	Edit=none   suppress=1 SumText=합계 </C>
								<C> name='판매가'       ID='USE_AMT'  		Width=65   	align=Right 		  	SumText=@sum  Dec=0</C>
								<C> name='사용일자'     ID='USE_DATE'    	Width=70   	align=Right Edit=none  mask='XXXX-XX-XX'</C>
								<C> name='예약SID'      ID='RSV_SID'    	Width=70   	align=Right Edit=none  show=false </C>
								<C> name='메뉴SID'      ID='MENU_SID'    	Width=70   	align=Right Edit=none  show=false </C>
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

