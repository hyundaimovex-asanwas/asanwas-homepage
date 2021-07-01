<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 포캐스팅(서비스)생성
 * 프로그램ID   : RM270I
 * J  S  P      : rm270i
 * 서 블 릿        : Rm270I
 * 작 성 자        : 정하나
 * 작 성 일        : 2010-08-09
 * 기능정의     : 포캐스팅(서비스) (조회 등록 삭제 수정)
 * 수정내용     : 기능(function) 구현
 * 수 정 자        : 
 * 최종수정일자 : 
 * TODO         : 화면디자인상에 기능 구현

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
        

    }
    
    function fnSelect() {
        var_saup        = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index);        //지역
        var_upjang      = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);  //업장
        var_menu_cd     = txt_menu_cd.value;          //메뉴코드

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+var_saup
                    + ",v_upjang_sid="+var_upjang
                    + ",v_menu_cd="+var_menu_cd;
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm270I", 
            "JSP(O:DEFAULT=ds1)", 
            v_param);
        tr_post(tr1);
    }
    

			
 
    function fnApply() {
        if (ds1.IsUpdated) {
            if (fnChk()) {			
                window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                document.all.LowerFrame.style.visibility="visible";        
                                                
             ln_TRSetting(tr_save, 
                            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm270I", 
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
    	alert("SUCC");
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
        fnSelect();
    </script>

    <script language="javascript" for="tr_save" event="onfail()">
    	alert("FAIL");
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

    <table cellpadding="0" cellspacing="0" border="0" width="845">
        <tr> 
            <td align="right">
                <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
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
								<C> name='지역' 		ID='SAUP_NM'				 	HeadAlign=Center Width=100  align=left editlimit=10 show=true edit=none</C>																																																																																						
								<C> name='영업장명' 		ID='UPJANG_NM' 				 	HeadAlign=Center Width=120  align=left editlimit=30 BgColor=#fefec0 edit=none</C>																					
                                <C> name='메뉴명'          ID='MENU_NM'        Width=120   align=left edit=none</C>																			
								<C> name='회차'          ID='USE_SEQ'        Width=50   align=right editlimit=26 edit=Numeric</C>			
								<C> name='생성'  		ID='CREATE_YN'   	HeadAlign=Center Width=30 align=center editlimit=1 editstyle=checkbox</C>																														
								<C> name='시작일자' 	ID='BGN_DATE' 	HeadAlign=Center Width=80  align=center editlimit=26 mask='XXXX-XX-XX'</C>
								<C> name='종료일자' 	ID='END_DATE' 	HeadAlign=Center Width=80  align=center editlimit=26 mask='XXXX-XX-XX'</C>
								<C> name='수량'          ID='MENU_CNT'        Width=60   align=right editlimit=26 edit=Numeric</C>	       																			
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



                        