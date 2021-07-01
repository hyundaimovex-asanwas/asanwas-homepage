<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 서비스 요금관리
 * 프로그램ID   : RV030I
 * J  S  P      : rv030i
 * 서 블 릿     : Rv030I
 * 작 성 자     : 구자헌
 * 작 성 일     : 2006-05-16
 * 기능정의     : 서비스 메뉴 / 요금 관리 (조회 등록 삭제 수정)
 * 최종수정일자 : 2006-05-22 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-11-30][심동현] 뭔가 이상..
 * [2010-08-11][심동현] 옵션에서 서비스로 명칭 변경
 *						추가 속성 수정 / 저장
 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

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
    var var_saup = "";
    var var_upjang = "";
    var var_menu_cd = "";
    var var_menu_nm = "";
    
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}

    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds_saup.Reset(); //지역코드
        
        ds_currency.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV022&s_item1=Y";
        ds_currency.Reset();
        
        ds_option.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV023&s_item1=Y";
        ds_option.Reset();

        ds_service_grade.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV038&s_item1=Y";
        ds_service_grade.Reset(); //서비스등급

        ds_service_age.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV039&s_item1=Y";
        ds_service_age.Reset(); //서비스연령

        ds_service_group.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=RV040&s_item1=Y";
        ds_service_group.Reset(); //서비스그룹

    }
    
    function fnSelect() {
        var_saup        = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index);        //지역
        var_upjang      = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);  //업장
        var_menu_cd     = txt_menu_cd.value;          //메뉴코드
        var_menu_nm     = txt_menu_nm.value;          //메뉴명

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+var_saup
                    + ",v_upjang_sid="+var_upjang
                    + ",v_menu_cd="+var_menu_cd
                    + ",v_menu_nm="+var_menu_nm;
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv030I", 
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
                document.all.LowerFrame.style.visibility="visible";

                ln_TRSetting(tr_save, 
                            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv030I", 
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
            if(ds1.namevalue(i,"MENU_CD")=="") {
                alert("메뉴코드<%=HDConstant.A_MSG_MUST_INPUT%>");
                gr1.setColumn("MENU_CD");
                ds1.RowPosition = i;
                return false;
            }
            if(ds1.namevalue(i,"BGN_DATGE")=="") {
                alert("적용 시작일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                gr1.setColumn("BGN_DATGE");
                ds1.RowPosition = i;
                return false;
            }
            if(ds1.namevalue(i,"END_DATE")=="") {
                alert("적용 종료일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                gr1.setColumn("END_DATE");
                ds1.RowPosition = i;
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
                    + "&s_UpjangType=99";
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
    
    <script language=JavaScript  for=ds_saup event="OnLoadStarted()" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
    <script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
    </script>   
    <script language=JavaScript  for=ds_upjang event="OnLoadStarted()" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
    <script language=JavaScript  for=ds_upjang event="OnLoadProsess(row)" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
    <script language=JavaScript  for=ds_upjang event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
    </script>

    <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
    <script language="javascript" for="tr1" event="onsuccess()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
    </script>

    <script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
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
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
        fnSelect();
    </script>

    <script language="javascript" for="tr_save" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
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
<object  id=ds_currency classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_option classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id=ds_service_age classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_service_grade classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_service_group classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=150 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_upjang>
                                <param name=SearchColumn        value="upjang_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="upjang_nm^0^150">
                                <param name=BindColumn          value="upjang_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td class=text>메뉴코드</td>
                        <td bgcolor="#ffffff">&nbsp;<input type=text name=txt_menu_cd class="txtbox" size=7 maxLength=5></td>
                        <td class=text>메뉴명</td>
                        <td bgcolor="#ffffff">&nbsp;<input type=text name=txt_menu_nm class="txtbox" size=15 maxLength=15></td>
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
                                    <FC> name=''             ID='{CURROW}'       Width=25    align=center </FC>                       
                                    <FC> name='메뉴SID'   	ID='MENU_SID'        Width=60    align=center edit=none</FC>
                                    <FC> name='메뉴코드'     ID='MENU_CD'        Width=60    align=center edit=upper</FC>
                                    <FC> name='메뉴명'      ID='MENU_NM'		Width=120   align=left</FC>
                                    <C> name='서비스연령'   ID='MENU_ITEM3' 	Width=70   align=left Editstyle=Lookup Data='ds_service_age:DETAIL:DETAIL_NM'</C>
                                    <C> name='서비스등급'   ID='MENU_ITEM4' 	Width=70   align=left Editstyle=Lookup Data='ds_service_grade:DETAIL:DETAIL_NM'</C>
                                    <C> name='서비스그룹'	ID='MENU_ITEM5' 	Width=70   align=left Editstyle=Lookup Data='ds_service_group:DETAIL:DETAIL_NM'</C>
                                    <C> name='M_SID'    	ID='ASSOC_AMT' 	 Width=50   align=left dec=0</C>
                                    <C> name='요금'       ID='UNIT_AMT'       Width=50    align=right     Edit=Numeric dec=0</C>
                                    <C> name='통화'       ID='CURRENCY_CD'    Width=50    align=left     Editstyle=Lookup Data='ds_currency:DETAIL:DETAIL_NM'</C>
                                    <C> name='적용시작일자' ID='BGN_DATE'         Width=80    align=center mask='XXXX/XX/XX'</C>
                                    <C> name='적용종료일자' ID='END_DATE'         Width=80    align=center mask='XXXX/XX/XX'</C>
                                    <C> name='과세여부'     ID='TAX_YN'         Width=60    align=center    EditStyle=CheckBox</C>
                                    <C> name='옵션'       ID='OPTION_YN'      Width=50    align=center    EditStyle=CheckBox</C>
                                    <C> name='사용여부'     ID='USE_YN'         Width=60    align=center    EditStyle=CheckBox</C>
                                    <C> name='참고사항'     ID='REMARKS'        Width=100   align=left</C>
                                    <C> name='메뉴영문명'    ID='MENU_ENG_NM'    Width=80   align=left show=false</C>
                                    <C> name='메뉴단축명'    ID='MENU_SHORT_NM'  Width=80   align=left</C>
                                    <C> name='옵션적용'     ID='OPTION_VIEW_CD' Width=100    align=left      Editstyle=Lookup Data='ds_option:DETAIL:DETAIL_NM'</C>
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



                        