<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 관광예약 할인상세 수정
 * J  S  P    : RV201I
 * 서 블 릿        : RV201I
 * 작 성 자        : 심동현
 * 작 성 일        : 2007-05-21
 * 기능정의     :  할인상세내역 수정
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩
// Parameter    :
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

        fnInit();
        fnInit1();

//        codeDs1.deleterow(1);
//        codeDs3.deleterow(1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : 선조회
// Parameter    :
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
    }

    function fnInit1() {
    
		//2007-05-10 할인상세 추가 by 심동현 
		//자차여부 (자차=Y, 버스=N)
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM021&s_item1=Y";
        codeDs1.Reset();
        
        //할인유형(cust_type)
        codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV003&s_item1=Y";
        codeDs2.Reset();

        //제주여부 (제주=Y, 非제주=N)
        codeDs3.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM020&s_item1=Y";
        codeDs3.Reset();
        
        //주말여부 (주말=Y, 주중=N)
        codeDs4.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM019&s_item1=Y";
        codeDs4.Reset();
		
        //테마코드(theme_cd)
        codeDs5.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM018&s_item1=Y";
        codeDs5.Reset();


		//2008-10-24 연령코드 수정 by 심동현 
        codeDs6.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV014&s_item1=Y";
        codeDs6.Reset();

	}


<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    :
%>
    function fnSelect() {

    	if (getObjectFirst("sAcceptNo").Text.trim() =="") {
	    	alert ("신청서 번호를 입력하세요!");
	    	return;
    	}
    	v_accept_sid = getObjectFirst("v_accept_sid").value;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sAcceptNo="+getObjectFirst("sAcceptNo").Text
                    + ",sAcceptSid="+ v_accept_sid
                    + ",sClientSid="+ sClientSid.value;

        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv201I",
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
     * 적용 함수 : 수정내역 저장
     */
    function fnApply() {
        if (ds1.IsUpdated) {
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv201I",
                "JSP(I:DS1=ds1,O:DS_RESULT=ds_result)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr1);
        } else {
            alert("변경 내역이 없습니다.");
        }
    }

    /*
     * 판매가 계산
     */
    function fnSaveAmt(){
        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv201I",
            "JSP(O:DS2=ds_result)",							//, O:AMT_RESULT=ds_amt_result
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,v_accept_sid="+v_accept_sid);
        tr_post(tr2);
//        fnSelect();
//        alert("판매가 계산이 완료 되었습니다.");

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
        getObjectFirst("gr1").SetExcelTitle(1, "value:관광예약 할인상세; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("관광예약 할인상세", "관광예약 할인상세.xls", 8);
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
        } else {
            getObjectFirst("v_accept_sid").value = 0;
            getObjectFirst("sAcceptNo").Text   = "";
            getObjectFirst("save_amt_btn").style.display = "none";
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

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_result" event="OnLoadCompleted(row)">
	if(row==0)
		return;
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>


<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    if(row==0){
    	v_accept_sid = "";
    	getObjectFirst("save_amt_btn").style.display = "none";
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }

    if(v_accept_sid!=""){
    	getObjectFirst("save_amt_btn").style.display = "inline";
    }
</script>

<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
//클릭했을때.. 행 자동 반영하기.
    if(Row==0) {	//제목줄을 클릭했을때.
    
        if(ds1.CountRow<=1) return;
        gr1.Redraw = "False";
        
        if(Colid=="CAROWNER_YN" || Colid=="CUST_TYPE" || Colid=="THEME_CD"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
//                ds1.NameValue(i, Colid+"_NM") = ds1.NameValue(1, Colid+"_NM");
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
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
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

	var alert_msg = "";
    if(ds_result.CountRow>0){
		for(var i=1; i<=ds_result.CountRow; i++){
			if(ds_result.NameValue(i, "MSG_CD")!="0000")
				alert_msg += ds_result.NameValue(i, "MSG") +"\n";
		}
		if(alert_msg!="")
			alert(alert_msg);
		else {
			alert("판매가 계산이 완료되었습니다.");
			fnSelect();
		}
    }
    	
    ds_result.ClearAll();
</script>

<script language="javascript" for="tr2" event="OnFail()">
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
	                            <td width="80px" height="25px" class="text">대리점</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="대리점을 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                    <input type="hidden" value="" id="sClientSid" readOnly>
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
                              </tr>
                              <!-- <tr>
                                <td width="80px" height="25px" class="text">출발일자</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
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
                                <td align=left class="text" height="25px">상품정보</td>
			                      <td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
			                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=150 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs2>
										<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
										<param name=ListExprFormat  value="goods_nm^0^140">
		                              </object>
									<%=HDConstant.COMMENT_END%>&nbsp;
								</td>
                            </tr>-->
                        </table>
                    </td>
                </tr>
                <tr>
                  <td style="padding-top:8px;padding-bottom:8px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                      	<td style="padding:6px" width=44><img src=../images/attention_Mark.jpg border=0></td>
                      	<td width=100%>　1. 2007년 5월 이후 관광객들의 할인상세내역 조회 및 판매가계산이 가능합니다.<br>
                      	　2. <font color=blue>자차, 할인유형, 테마 3가지만 수정 가능</font>하며 제주, 주말여부는 입력시 자동계산됩니다.<br>
                      	　3. [판매가계산]을 누를 경우 자동으로<font color=blue>표준요금과 판매가가 계산</font>되니, 특판가 등으로 판매가를 임의 수정한 경우 주의하세요.</br>
                      	　　　이미 계산된 판매가의 경우 <font color=blue>계산 전 상태로 복구할 수 없습니다!</font>
                      	</td>
                      </tr>
                    </table>
                  </td>
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
								<C> name='순번'     		ID='KEY_SEQ'   		Width=50   	align=Left 	   Edit=none  BgColor=#fefec0 show=false </C>
								<C> name='출발일'       	ID='DEPART_DATE'	Width=60   	align=Center 	Edit=none  BgColor=#fefec0 SumText=합계 suppress=1</C>
								<C> name='상품'          	ID='GOODS_SID'		Width=60  	align=Left	   Edit=none  BgColor=#fefec0  suppress=2 SumText=@cnt</C>
								<C> name='성명'           	ID='CUST_NM'		Width=50   	align=Left 	   Sort=True  Edit=none  BgColor=#fefec0 SumText=명</C>
								<C> name='주민/여권번호'	ID='MANAGE_NO'		Width=70	align=Left 	   Edit=none  BgColor=#fefec0  </C>
               			        <C> name='방장(동숙)'		ID='JOIN_TXT'		Width=75	align=Left	   Edit=none  bgcolor={DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', '#fefec0')}</C>
               			        <C> name='연령'             ID='AGE_CD'			Width=40    align=center   BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} Editstyle=lookup data='codeDs6:detail:detail_nm' </C>
								<C> name='확정객실'     	ID='ROOM_TYPE_CD'	Width=51   	align=center   Sortt=FALSE  Edit=none  BgColor=#fefec0  suppress=3</C>
								<C> name='표준요금'     	ID='STD_AMT'		Width=60   	align=Right    Edit=none  BgColor=#fefec0 SumText=@sum  Dec=0</C>
								<C> name='판매가'         	ID='USE_AMT'		Width=60   	align=Right    SumText=@sum  Dec=0 Edit=none  BgColor=#fefec0</C>
								<G> name='할인상세내역'
									<C> name='①자차√'      ID='CAROWNER_YN'  	Width=50   	align=center    BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} editstyle=lookup data='codeDs1:detail:detail_nm'</C>
									<C> name='②할인유형√'   ID='CUST_TYPE'   	Width=90   	align=center 	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}    editstyle=lookup data='codeDs2:detail:detail_nm'</C>
									<C> name='③제주'       ID='JEJU_YN'  		Width=50   	align=center    BgColor=#fefec0 editstyle=lookup data='codeDs3:detail:detail_nm' Edit=none</C>
									<C> name='④주말'      ID='WEEKEND_YN' 	Width=50   	align=center    BgColor=#fefec0 editstyle=lookup data='codeDs4:detail:detail_nm' </C>
									<C> name='⑤테마√'      ID='THEME_CD'  		Width=60   	align=center    BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} editstyle=lookup data='codeDs5:detail:detail_nm'</C>
								</G>
								<C> name='정산\\마감'			ID='ACCT_CLOSE_YN'	width=45 	align=center   edit=none  BgColor=#fefec0 show=false</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

