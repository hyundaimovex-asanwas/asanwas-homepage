<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 상품요금관리 
 * 프로그램ID   : RV020I
 * J  S  P      : rv020i
 * 서 블 릿        : Rv020I
 * 작 성 자        : 구자헌
 * 작 성 일        : 2006-05-16
 * 기능정의     : 상품 요금 관리 (조회 등록 삭제 수정)
 * 수정내용     : 기능(function) 구현
 * 수 정 자        : 김영민
 * 최종수정일자 : 2006-05-22 
 * TODO         : 화면디자인상에 기능 구현
 * TODO         : 이벤트 수정
 * TODO         : 화면구성 수정
 * TODO         : 검색조건란 자동 값넣기 기능 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-04-02][심동현] 화면 그리드 수정
 * [2009-11-30][박경국] 검색 조건 추가[이용일자]
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
    var var_saup = "";
    var var_upjang = "";
    var var_cust = "";
    
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}

    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
        
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds_saup.Reset(); //지역코드
        ds_cust.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV003&s_item1=Y&s_item4=Y";//dstype=3만 공통코드 속성15로 정렬함. 
        ds_cust.Reset(); //고객유형
        ds_pay.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV029&s_item1=Y";
        ds_pay.Reset(); //요금분류코드
        ds_addr.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RM022&s_item1=Y";
        ds_addr.Reset(); //숙소타입
        
        v_date.text="<%=firstday%>";
    }
    
    function fnSelect() {
        var_saup    = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index);        //지역
        var_upjang  = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);  //업장
        var_cust    = v_cust.ValueOfIndex("DETAIL", v_cust.Index);          //고객구분

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+var_saup
                    + ",v_upjang_sid="+var_upjang
					+ ",v_date="+v_date.text                   
                    + ",v_cust="+var_cust;
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		fnShowLoading(610,400);
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv020I", 
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
    }
    
    function fnAddRow() {
        ds1.AddRow();
        
        if(ds1.CountRow==0){
            alert("조회를 먼저 하시길 바랍니다.");
            return;
        }
        ds1.namevalue(ds1.rowposition,"SAUP_SID") = var_saup;
        ds1.namevalue(ds1.rowposition,"UPJANG_SID") = var_upjang;
        
        gr1.SetColumn("MENU_CD");
    }

    function fnDeleteRow() {
        ds1.DeleteRow(ds1.RowPosition);
    }

    function fnApply() {
        if (ds1.IsUpdated) {
            if (fnChk()) {
                window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
				fnShowLoading(610,400);

                ln_TRSetting(tr_save, 
                            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv020I", 
                            "JSP(I:DEFAULT=ds1)",
                            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr_save);
            }
        }
    }
    
    function fnCancel() {           
        ds1.undoall();
        window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";      
    }

    function fnChk() {
        for(i=1;i<=ds1.CountRow;i++) {
            if(ds1.namevalue(i,"menu_cd")=="") {
                alert("메뉴코드<%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds1.namevalue(i,"menu_item1")=="") {
                alert("고객유형<%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds1.namevalue(i,"bgn_date")=="") {
                alert("적용 시작일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds1.namevalue(i,"end_date")=="") {
                alert("적용 종료일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
        }
        return true;
    }

</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  지역 선택시 업장정보 조회
%>
    <script language=JavaScript for=v_saup event=OnSelChange()>
        var v_param = "dsType=1"
                    + "&proType=S"
                    + "&s_SaupSid="+v_saup.bindcolval
                    + "&s_UpjangType=80";
        ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
        ds_upjang.Reset(); //업장
    </script>

    <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
        if(colid=="MENU_ITEM1") {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            //arrParam[0] : head
            //arrParam[1] : detail
            //arrParam[2] : detail_nm
            //arrParam[3] : item1               
            arrParam[0] = "RV003";
            arrParam[1] = "고객구분"; //공통코드의 마스터값
            strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);
            if (arrResult != undefined) {
                arrParam = arrResult.split(";");
                ds1.namevalue(ds1.rowposition,"MENU_ITEM1")=arrParam[1];
                ds1.namevalue(ds1.rowposition,"MENU_ITEM1_NM")=arrParam[2];
            }
        }
    </script>
    
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
	    if(Row==0) {
	        if(ds1.CountRow<=1) return;
	        gr1.Redraw = "False";
	        if(Colid=="MENU_ITEM1" || Colid=="MENU_ITEM2" || Colid=="MENU_ITEM3"){
	            for(var i=2; i<=ds1.CountRow; i++){
	                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	                ds1.NameValue(i, Colid+"_NM") = ds1.NameValue(1, Colid+"_NM");
	            }
	        } else if(Colid=="MENU_CD" || Colid=="BGN_DATE" || Colid=="END_DATE"){//일단 여기만 사용!2010-02-24
	            for(var i=2; i<=ds1.CountRow; i++){
	                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	            }
	        }
	        gr1.Redraw = "True";
	        return;
	    }
	</script>
    
    <script language=JavaScript for=gr1 event=OnExit(Row,Colid,olddata)>
        if(Colid=="MENU_ITEM1") {
            ds1.NameValue(Row, "MENU_ITEM1_NM") = "";
            for(var i=2; i<=ds_cust.CountRow; i++){
                if(ds_cust.NameValue(i, "DETAIL")==ds1.NameValue(Row, Colid)){
                    ds1.NameValue(Row, "MENU_ITEM1_NM") = ds_cust.NameValue(i, "DETAIL_NM");
                    return;
                }
            }
        }
    </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  지역 조회중
%>
    <script language=JavaScript  for=ds_saup event="OnLoadStarted()" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		fnShowLoading(610,400);
    </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  지역 조회완료
%>
    <script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();
    </script>   
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  업장 조회중
%>
    <script language=JavaScript  for=ds_upjang event="OnLoadStarted()" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		fnShowLoading(610,400);
    </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  업장 조회완료
%>
    <script language=JavaScript  for=ds_upjang event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		fnHideLoading();
    </script>

    <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		fnHideLoading();
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
    <script language="javascript" for="tr1" event="onsuccess()">
		fnHideLoading();
        window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
    </script>

    <script language="javascript" for="tr1" event="onfail()">
		fnHideLoading();
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

    <script language="javascript" for="tr_save" event="onsuccess()">
		fnHideLoading();
        window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
        fnSelect();
    </script>

    <script language="javascript" for="tr_save" event="onfail()">
		fnHideLoading();
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<%=HDConstant.COMMENT_START%>
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object  id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_pay classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_addr classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

    <table cellpadding="0" cellspacing="0" border="0" width="845">
        <tr> 
            <td align="right">
                <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                <img src="<%=dirPath%>/Sales/images/plus.gif"    style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
                <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
                <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                    <tr bgcolor="#6f7f8d" height=25>
                        <td class=text>지역</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_saup>
                                <param name=SearchColumn        value="saup_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="saup_nm^0^100">
                                <param name=BindColumn          value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td class=text>업장명</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_upjang>
                                <param name=SearchColumn        value="upjang_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="upjang_nm^0^130">
                                <param name=BindColumn          value="upjang_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td class=text>고객유형</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=180 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_cust>
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="DETAIL_NM^0^180">
                                <param name=BindColumn          value="DETAIL">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class=text>이용일자</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                <object id=v_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>  height='16px' width=67 align=center class='textbox'>
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
                    </tr>
                </table>
            </td>
        </tr>
    </table>        
    <table border= "0" cellpadding=0 cellspacing=0>
        <tr>
            <td height=3  border="0"></td>
        </tr>
        <tr> 
            <td valign=top> 
                <table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
                    <tr> 
                        <td>
                            <%=HDConstant.COMMENT_START%>                                           
                            <object  classid=<%=HDConstant.CT_GRID_CLSID%> id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
                                <param name="DataID"        VALUE="ds1">
                                <param name="BorderStyle"   VALUE="0">
                                <param name=ColSizing       value="true">
                                <param name="editable"      value="true">
                                <param name=UsingOneClick   value="1">
                                <Param Name="AllShowEdit"   value="True">
                                <param name="Format"        VALUE="  
                                    <FC> name=''            ID='{CURROW}'       Width=25    align=center</FC>
                                    <FC> name='메뉴코드√'    ID='MENU_CD'       Width=60    align=center edit=upper</FC>
                                    <FC> name='메뉴명'      ID='MENU_NM'    	Width=90   align=left</FC>
                                    <C> name='고객유형'     ID='MENU_ITEM1'     Width=110    align=left editstyle=Lookup Data='ds_cust:DETAIL:DETAIL_NM'</C>
                                    <C> name='요금분류'     ID='MENU_ITEM2'     Width=80    align=left editstyle=Lookup Data='ds_pay:DETAIL:DETAIL_NM'</C>
                                    <C> name='숙소'     	ID='MENU_ITEM3'     Width=50    align=left editstyle=Lookup Data='ds_addr:DETAIL:DETAIL_NM'</C>
                                    <C> name='적용\\시작일자√' ID='BGN_DATE'    Width=90    align=left Edit=Numeric mask='XXXX/XX/XX'</C>
                                    <C> name='적용\\종료일자√' ID='END_DATE'	Width=90    align=left Edit=Numeric mask='XXXX/XX/XX'</C>
                                    <C> name='요금'			ID='UNIT_AMT'  		Width=75    align=right Edit=Numeric dec=0</C>
                                    <C> name='사용여부'     ID='USE_YN'         Width=60    align=center EditStyle=CheckBox</C>
                                    <C> name='과세여부'     ID='TAX_YN'			Width=60    align=center EditStyle=CheckBox</C>
                                    <C> name='메뉴영문명'   ID='MENU_ENG_NM'	Width=100   align=left Edit=Aplha</C>
                                    <C> name='메뉴단축명'   ID='MENU_SHORT_NM'	Width=100   align=left Edit=Any</C>

                                ">
                            </object> 
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                    </tr>

                    <tr>
                        <td>※ 숙박비를 제외한 각 유형별 비용을 설정합니다.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

