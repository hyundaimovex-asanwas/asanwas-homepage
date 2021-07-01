<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 미출경자 입력
 * 프로그램ID 	: CQ510I
 * J  S  P		: cq510i
 * 서 블 릿		: Cq510I
 * 작 성 자		: 김영민
 * 작 성 일		: 2006-07-20
 * 기능정의		: 미출경자 입력
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-11-26][심동현] 출경체크 부분 수정.
 *						[운영마감 후 취소]의 경우 더이상 노쇼로 업뎃하지 않음.
 *						고성사무소 누구랑 이야기해야 할까..;;
 *						운영마감=Y && 예약상태=취소 인 사람들은 노쇼로 바꿀 수 없음..
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

<%// HTML 시작%>
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
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		fnInit(); 
	}
	
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        v_depart_date.Text='<%=firstday%>';
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
        
        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y";
        ds_status.Reset();	//예약상태

        ds_status1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y&s_item3=Y";
        ds_status1.Reset();	//예약상태-출경구분용
        
	}

    /*
     * 시간, 상품정보 조회
     */     
    function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ",sDepartDate=" + v_depart_date.Text;

        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
            v_param);
        tr_post(tr2);
    }   

    /*
     * 반 정보 조회
     */     
    function fnSelectDs4() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ",sDepartDate=" + v_depart_date.Text
                    + ",sGoodsSid=" + lc_goods.ValueOfIndex("goods_sid",lc_goods.Index)
                    + ",sDepartTime=" + lc_time.ValueOfIndex("DEPART_TIME",lc_time.Index);

        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds_ban)",
            v_param);
        tr_post(tr3);
    }   

    /*
     * 조 정보 조회
     */     
    function fnSelectDs5() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ",sDepartDate=" + v_depart_date.Text
                    + ",sDepartTime=" + lc_time.ValueOfIndex("DEPART_TIME",lc_time.Index)
                    + ",sGoodsSid=" + lc_goods.ValueOfIndex("goods_sid",lc_goods.Index)
                    + ",sClass=" + lc_ban.ValueOfIndex("CLASS", lc_ban.Index);

        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds_jo)",
            v_param);
        tr_post(tr4);
    }   

	function fnSelect() {
        if(v_depart_date.Text.trim()=="" || v_depart_date.Text.trim().length!=8){
            alert("출발일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
            return;
        }
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ", v_saup_sid="+ ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ", v_depart_date="+ v_depart_date.Text
                    + ", v_depart_time="+ lc_time.ValueOfIndex("DEPART_TIME", lc_time.Index)
                    + ", v_goods_sid="+ lc_goods.ValueOfIndex("GOODS_SID", lc_goods.Index)
                    + ", v_class="+ lc_ban.ValueOfIndex("CLASS", lc_ban.Index)
                    + ", v_teams="+ lc_jo.ValueOfIndex("TEAMS", lc_jo.Index)
                    + ", v_cust_nm="+ v_cust_nm.value
                    + ", v_manage_no="+ v_manage_no.Text
                    + ", v_out_gubn="+ v_out_gubn.value;

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq510I",
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
	}

	function fnApply() {
		if (ds1.IsUpdated) {
			for ( i=1; i<= ds1.CountRow; i++ )  {
				if(ds1.namevalue(i,"job_sel")=="" ) {
					alert(ds1.namevalue(i,"cust_nm")+" 고객을 [선택]으로 수정할 수 없습니다.");
					return;
				}
				if(ds1.namevalue(i,"status_cd")=="RC" && ds1.namevalue(i,"job_sel")=="NS" ) {
					alert(ds1.namevalue(i,"cust_nm")+" 고객을 [취소] → [노쇼]로 수정할 수 없습니다.");
					return;
				}
				if(ds1.namevalue(i,"status_cd")=="RC" && ds1.namevalue(i,"job_sel")=="DP" ) {
					alert(ds1.namevalue(i,"cust_nm")+" 고객을 [취소] → [출경]으로 수정합니다.");
				}
			};	

            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq510I",
                "JSP(I:DEFAULT=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
		}
	}
	
	function fnBarcoding() {
		if (barcoding.value.length == 12) {
			for (i = 1 ; i <= ds1.countrow; i++) {
				if (barcoding.value == ds1.namevalue(i, "UNITY_NO")) {
					ds1.namevalue(i, "BAR_SEL") = "T";
					barcoding.value ="";
					barcoding.focus();
					return;
				}
			}
		} else {
			return;
		}
	}

</script>



<script language=JavaScript for=ds_status1 event="OnLoadCompleted(row)">
	ds_status1.DeleteRow(3);
</script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
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

<script language="javascript" for="tr2" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr2" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr3" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr3" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr3.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr3.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr3.ErrorCode + "\n" + "Error Message : " + tr3.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr4" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr4" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr4.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr4.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr4.ErrorCode + "\n" + "Error Message : " + tr4.ErrorMsg + "\n");
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
	window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	document.all.LowerFrame.style.visibility="visible";	
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)"> <%// Main %>
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>

<script language=JavaScript for=v_depart_date event=OnKillFocus()> <%// 출경시간 변경 %>
    if ( v_depart_date.Modified ) {
        fnSelectDs3();          
    }
</script>

<script language=JavaScript for=lc_saup event=OnSelChange()> <%// 지역 체인지 %>
    fnSelectDs3();
</script>
<script language=JavaScript for=lc_time event=OnSelChange()> <%// 지역 체인지 %>
    fnSelectDs4();
</script>
<script language=JavaScript for=lc_ban event=OnSelChange()> <%// 지역 체인지 %>
    fnSelectDs5();
</script>
<script language=JavaScript for=lc_goods event=OnSelChange()> <%// 상품 체인지 %>
    fnSelectDs4();
</script>


<script language=JavaScript for=gr1 event=OnClick(Row,Colid)> <%// Grid Event: √ 컬럼 클릭할 때 %>
    if(ds1.CountRow==0)
        return;

    if(Row==0 && Colid=="JOB_SEL"){
        for(var i=1; i<=ds1.CountRow; i++){
			if(ds1.NameValue(i, "status_cd")!="RC"){
            	ds1.NameValue(i, "JOB_SEL") = ds1.NameValue(1, "JOB_SEL");
            }
        }
    } else if(Row==0 && Colid=="BAR_SEL"){
        for(var i=1; i<=ds1.CountRow; i++){
            ds1.NameValue(i, "BAR_SEL") = ds1.NameValue(1, "BAR_SEL");
        }
    }
</script>


<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  지역 %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  출경시간 %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  상품 %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_ban classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  반   %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_jo classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//  조   %>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//예약상태%>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//예약상태-출경구분용%>
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

    <table border='0' cellpadding='0' cellspacing='0'>  
        <tr>
            <td>
                <table border='0' cellpadding="0" cellspacing="0" width="1002"> 
                    <tr>
                        <td align=right>
							<img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:pointer" align=absmiddle onclick="fnSelect()">       <!-- 조회 -->
							<img src="<%=dirPath%>/Sales/images/save.gif"       style="cursor:pointer" align=absmiddle onClick="fnApply()">        <!-- 저장 -->
                        </td>
                    </tr>
                    <tr height="10px">
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <table border='0' cellpadding="0" cellspacing="1" width="1002" bgcolor="#666666">
                                <tr height='30px'>
                                    <td width=50 align=left class="text">지역</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                                     
                                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=BindColumn      value="saup_sid">
                                            <param name=BindColVal      value="saup_sid">
                                            <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                            <param name=ListExprFormat  value="saup_nm^0^80">
                                        </object>
                                    </td>   
                                    <td align=left class="text">출발일자</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                                        <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Text                value="">
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="YYYY-MM-DD">
                                            <param name=InputFormat         value="YYYYMMDD">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=ReadOnly            value="false">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>&nbsp;
                                        <object id=lc_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_time>
                                            <param name=BindColumn      value="depart_time">
                                            <param name=BindColVal      value="depart_time">
                                            <param name=EditExprFormat  value="%,%;depart_time,depart_time_nm">
                                            <param name=ListExprFormat  value="depart_time_nm^0^60">
                                        </object>
                                                                                                                     
                                    </td>                                                                                           
                                    <td align=left class="text">상품정보</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;                                                                                         
                                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_goods>
                                            <param name=BindColumn      value="goods_sid">
                                            <param name=BindColVal      value="goods_sid">
                                            <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                            <param name=ListExprFormat  value="goods_nm^0^130">
                                        </object>
                                    </td>
                                    <td width=50 align=left class="text">반</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;                                                                                         
                                        <object id=lc_ban classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=60 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_ban>
                                            <param name=BindColumn      value="CLASS">
                                            <param name=BindColVal      value="CLASS">
                                            <param name=ListExprFormat  value="CLASS_NM^0^60">
                                        </object>
                                        &nbsp;   
                                    </td>
                                    <td align=left class="text">조</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <object id=lc_jo classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=60 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_jo>
                                            <param name=BindColumn      value="TEAMS">
                                            <param name=BindColVal      value="TEAMS">
                                            <param name=ListExprFormat  value="TEAMS_NM^0^60">
                                        </object>
                                        &nbsp;   
                                    </td>
                                </tr>
                                <tr>
                                    <td align=center class="text">이름</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;<input type=text name="v_cust_nm" id="v_cust_nm" size=13 MaxLength="18" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                                    </td>
                                    <td align=left class="text">주민/여권번호</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <object id=v_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                            <param name=Format      value="0000000000000">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                            <param name=MaxLength   value="13">
                                        </object>
                                        
                                    </td>
                                    <td align=left class="text">출경구분</td>
                                    <td align=left bgcolor="#ffffff" valign="middle" colspan=3>
                                        &nbsp;<select name="v_out_gubn" id="v_out_gubn" class="textbox">
                                            <option value="">전체
                                            <option value="Y">출경
                                            <option value="N">미출경
                                        </select>
                                    </td>
                                    <td align=left class="text">바코딩</td>
                                    <td align=left bgcolor="#ffffff" valign="middle" colspan=5>&nbsp;
                                        <input type="text" name="barcoding" id=barcoding value="" class="textbox" maxlength="12"  onkeyup="fnBarcoding();">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="10px"><td></td></tr>
        <tr>
            <td valign=top>

				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='380px' border='1'>
					<param name="DataID"        value="ds1">
					<param name="ColSizing"     value="true">
					<param name="Fillarea"      value="false">
					<param name="Editable"      value="true">
					<param name="BorderStyle"   value="0">
					<param name=SortView        value="Right">
					<param name="SuppressOption"    value="1">
					<Param Name="AllShowEdit"   value="True">
					<Param Name="UsingOneClick"   value="1">
					<param name="ViewSummary"       value="1">
					<param name="Format"            value="
				        <C> name='출경구분√'    	ID='JOB_SEL'    width=80 align=Center EditStyle=lookup data='ds_status1:detail:detail_nm'   SumText='총건수'</C>
						<C> name='바코드구분√'		ID='BAR_SEL'    width=80 align=Center EditStyle=CheckBox SumText=@count</C>
						<C> name='운영마감'     	ID='CONFIRM_YN'	width=55 align=center Edit=None </C>
						<C> name='예약상태'     	ID='STATUS_CD'  width=60 align=center Edit=None BgColor={IF(STATUS_CD='RC','#fefec0','' )} editstyle=lookup data='ds_status:detail:detail_nm' </C>
				        <C> name='반'           	ID='CLASS_NM'   width=60 align=CENTER Edit=None </C>
				        <C> name='조'           	ID='TEAMS'      width=40 align=CENTER Edit=None </C>
				        <C> name='신청서번호'   	ID='ACCEPT_NO'  width=120 align=left Edit=None  Mask='XXXXX-XXXXXXXXX'</C>
				        <C> name='성명'         	ID='CUST_NM'    width=100 align=left Edit=None sort=true</C>
				        <C> name='주민/여권번호' 	ID='MANAGE_NO' width=100 align=left Edit=None </C>
				        <C> name='통일부번호'   	ID='UNITY_NO'   width=100 align=left Edit=None </C>
				        <C> name='출입경 비고사항'	ID='REMARKS'    width=200 align=left Edit=Any EditLimit='24'</C>
				    ">
				</object>
            </td>
        </tr>
        <tr>
            <td><BR>
            ※ [홈>관광영업>예약관리>반/조 객실배정>관광증번호 부여]에서 운영마감한 고객들만 조회됩니다.<BR>
            ※ 예약상태=<B>"취소" → "노쇼"</B> <FONT COLOR="RED">수정 불가</FONT><BR>
            ※ 예약상태=<B>"취소" → "출경"</B> <FONT COLOR="BLUE">수정 가능</FONT>
            </td>
        </tr>
    </table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
