<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 협력업체정보변경
 * 프로그램ID   : MY330I
 * J  S  P      : my330i
 * 서 블 릿        : My330I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-15
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
     
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">
        
        var jobFlag = "";
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

            fnInit(); 
            
            // 
            codeDs1.deleteRow(1);
            codeDs2.deleteRow(1);
            codeDs3.deleteRow(1);
            codeDs4.deleteRow(1);
            codeDs5.deleteRow(1);
            
            dir_yn.index = 0;
            area_cd.index = 0;
            use_yn.index = 0;
        } 
            
        /*
         * 초기작업
         * Header 설정 
         */
        function fnInit(){
           jobFlag = "INIT";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
                "JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
            
            fnSelect();
        }
            
        /*
         * 메인 조회
         */
        function fnSelect() {
            if (ds1.IsUpdated==false ) {
                var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                          + ",sClient_nm=22000";
                
                ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
                    "JSP(O:DS1=ds1)",
                    param);
                tr_post(tr1);
            } else {
                alert("작업중인 상태에서는 조회할수 없습니다!");
            }
        }
         
        /*
         * 입력 체크
         */
        function fnCheck() {
            if (ds1.IsUpdated) {
                if (jobFlag != "D") {
                    for(var i=1; i<=ds1.CountRow; i++){
                        if(ds1.NameValue(ds1.rowposition, "sal_dam_sid")=="") {
                            alert("영업담당자를 선택하세요!");
                            getObjectFirst("sal_dam_nm").focus();
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
                            alert("협력업체담당자를 입력하세요!");
                            getObjectFirst("client_dam_nm").focus();
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "tel_no")=="") {
                            alert("전화번호를 입력하세요!");
                            getObjectFirst("tel_no").focus();
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "mobile_no")=="") {
                            alert("휴대전화를 입력하세요!");
                            getObjectFirst("mobile_no").focus();
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "fax_no")=="") {
                            alert("팩스를 입력하세요!");
                            getObjectFirst("fax_no").focus();
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "e_mail")=="") {
                            alert("이메일을 입력하세요!");
                            getObjectFirst("e_mail").focus();
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "zip_cd")=="") {
                            alert("우편번호를 선택하세요!");
                            return;
                        }
                        if(ds1.NameValue(ds1.rowposition, "address2")=="") {
                            alert("상세주소를 입력하세요!");
                            getObjectFirst("address2").focus();
                            return;
                        }
                    }
                }
            }
            return true;
        } 
             
        /*
         * 저장
         */     
        function fnApply() {
            if (ds1.IsUpdated ) {
                if(fnCheck()){
                  ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
                    "JSP(I:DS1=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
                    tr_post(tr1);
                }
            }   
        }
            
        /*
         * 취소 
         */
        function fnCancel() {
            ds1.undoall();
        }
        /*
         * 우편번호 팝업 
         */ 
        function fnZipCodePopup() {
           var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
                
            strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);    
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                zip_cd.Text= arrParam[0];
                address1.value = arrParam[1];
                
            } else {
              zip_cd.Text = "";
              address1.value = "";
            }                       
        }           
        
        /*
         * 공통코드 팝업
         */
        function fnCommonCodePopup(head, headNm) {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            
            arrParam[0] = head;
            arrParam[1] = headNm;
            arrResult = showModalDialog(strURL,arrParam,strPos);    
            
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                
                if (head == 'AC002') {      // 은행 
                    bancod.value = arrParam[1];
                    bannam.value = arrParam[2];
                } 
            } else {
                if (head == 'AC002') {  // 은행 
                    bancod.value = "";
                    bannam.value = "";
                }
            }
            return ;
        }       
        </script>
        

<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
%>
    
    <script language="javascript" for="tr1" event="onsuccess()">
        window.status="작업이 성공적으로 완료되었습니다.";
    </script>   
    
    <script language="javascript" for="tr1" event="OnFail()">
        //document.all.LowerFrame.style.visibility="hidden";
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

/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  협력업체 조회 -->
    <param name="SyncLoad"  value="true">
</object>

<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  협력업체구분 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  직판구분 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  계약상태 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  보증보험회사 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  하위협력업체 여부 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td height='30px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand" align=absmiddle onClick="fnApply();">
                            <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand" align=absmiddle onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr> 
        <tr>
            <td height='10px'></td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top'>
                            <table border='0' cellpadding='0' cellspacing='0' width='530px'>
                                <tr>
                                    <td width='535px'>
                                        <table border='0' cellpadding='0' cellspacing='1' width='845px' height='244px' bgcolor="#666666">
                                            <tr>
                                                <td height='25' class='text'>협력업체코드</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="00000">
                                                        <param name=Enable      value="false">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td class='text'>협력업체명</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='client_nm'       name='client_nm'        value='' maxlength='30' size='20'   class='input01' readOnly> <!-- 대리점 명 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='text'>거래처명</td>
                                                <td bgcolor='#FFFFFF'>
                                                    <input type='hidden' id='vend_cd'           name='vend_cd'          value='' maxlength='13' size='10'   class='textbox'> <!-- 거래처코드 -->
                                                    &nbsp;<input type='text' id='vend_nm'             name='vend_nm'          value='' maxlength='62' size='15'   class='input01' readOnly> <!-- 거래처명 -->
                                                </td>
                                                <td class='text'>영업담당자</td>
                                                <td bgcolor='#FFFFFF'>
                                                    <input type='hidden' id='sal_dam_sid'       name='sal_dam_sid'      value='' maxlength='12' size='12'   class='textbox' readonly> <!-- 영업담당자코드 -->
                                                    &nbsp;<input type='text' id='sal_dam_nm'      name='sal_dam_nm'       value='' maxlength='22' size='10'   class='input01' readOnly> <!-- 영업담당자명 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>협력업체담당자</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='client_dam_nm'   name='client_dam_nm'    value='' maxlength='20' size='20'   class='textbox'> <!-- 대리점담당자 -->
                                                </td>
                                                <td class='text'>직판여부</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=dir_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs2>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                        <param name=Enable          value="false">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>전화번호</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='tel_no'          name='tel_no'           value='' maxlength='20' size='20'   class='textbox'> <!-- 전화번호 -->
                                                </td>
                                                <td class='boardt02'>휴대전화</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='mobile_no'       name='mobile_no'        value='' maxlength='15' size='20'   class='textbox'> <!-- 휴대전화 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>팩스번호</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='fax_no'          name='fax_no'           value='' maxlength='20' size='20'   class='textbox'> <!-- FAX번호 -->
                                                </td>
                                                <td class='boardt02'>메일주소</td>
                                                <td bgcolor='#FFFFFF'>
                                                     &nbsp;<input type='text' id='e_mail'             name='e_mail'           value='' maxlength='30' size='23'   class='textbox'> <!-- 이메일 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>우편번호</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=zip_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="###-###">
                                                        <param name=Cursor      value="Hand">
                                                        <param name=Enable      value="False">
                                                        <param name=ReadOnly    value="True">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;
                                                    <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="우편번호를 검색합니다"  style="cursor:hand" id="zipcode_btn" onclick="fnZipCodePopup();" align='absmiddle'>                                                 
                                                </td>
                                                <td class='boardt02'>지역코드</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=area_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs3>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>주소1</td>
                                                <td bgcolor='#FFFFFF' colspan='3'>
                                                    &nbsp;<input type='text' id='address1'        name='address1'         value='' maxlength='60' size='50'   class='textbox'> <!-- 주소1 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>주소2</td>
                                                <td bgcolor='#FFFFFF'colspan='3'>
                                                    &nbsp;<input type='text' id='address2'        name='address2'         value='' maxlength='60' size='50'   class='textbox'> <!-- 주소2 -->
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class='text'>은행</td>
                                                <td bgcolor='#FFFFFF'>
                                                     &nbsp;<input type='text' id='bannam'             name='bannam'           value='' maxlength='30' size='20'   class='input01' readOnly> <!-- 은행명 -->
                                                </td>
                                                <td class='text'>계좌번호</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='bank_acc_no'         name='bank_acc_no'      value='' maxlength='20' size='20'   class='input01' readOnly> <!-- 은행계좌번호 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='text'>예금주</td>
                                                <td bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='bank_acct_nm'    name='bank_acct_nm'     value='' maxlength='32' size='20'   class='input01' readOnly> <!-- 예금주 -->
                                                </td>
                                                <td class='text'>사용유무</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs5>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                        <param name=Enable          value="false">
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
            </td>
        </tr>
    </table>
    
        <%
        /*=============================================================================
                                Bind 선언
        =============================================================================*/
        %>
        <%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=client_sid       Ctrl=client_sid         Param=value </C>
                    <C>Col=vend_cd          Ctrl=vend_cd            Param=value </C>
                    <C>Col=vend_nm          Ctrl=vend_nm            Param=value </C>
                    <C>Col=client_cd        Ctrl=client_cd          Param=Text </C>
                    <C>Col=client_nm        Ctrl=client_nm          Param=value </C>
                    <C>Col=client_gu        Ctrl=client_gu          Param=value </C>
                    <C>Col=agen_gu          Ctrl=agen_gu            Param=BindColVal </C>
                    <C>Col=agen_gu_name     Ctrl=agen_gu_name       Param=value </C>
                    <C>Col=dir_yn           Ctrl=dir_yn             Param=BindColVal </C>
                    <C>Col=dir_yn_name      Ctrl=dir_yn_name        Param=value </C>
                    <C>Col=area_cd          Ctrl=area_cd            Param=BindColVal </C>
                    <C>Col=area_cd_name     Ctrl=area_cd_name       Param=value </C>
                    <C>Col=sal_dam_sid      Ctrl=sal_dam_sid        Param=value </C>
                    <C>Col=sal_dam_nm       Ctrl=sal_dam_nm         Param=value </C>
                    <C>Col=client_dam_nm    Ctrl=client_dam_nm      Param=value </C>
                    <C>Col=tel_no           Ctrl=tel_no             Param=value </C>
                    <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
                    <C>Col=fax_no           Ctrl=fax_no             Param=value </C>
                    <C>Col=e_mail           Ctrl=e_mail             Param=value </C>
                    <C>Col=zip_cd           Ctrl=zip_cd             Param=Text </C>
                    <C>Col=address1         Ctrl=address1           Param=value </C>
                    <C>Col=address2         Ctrl=address2           Param=value </C>
                    <C>Col=commi_rate       Ctrl=commi_rate         Param=Text </C>
                    <C>Col=cunt_status      Ctrl=cunt_status        Param=BindColVal </C>
                    <C>Col=cunt_status_name Ctrl=cunt_status_name   Param=value </C>
                    <C>Col=bancod           Ctrl=bancod             Param=value </C>
                    <C>Col=bannam           Ctrl=bannam             Param=value </C>
                    <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
                    <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
                    <C>Col=use_yn           Ctrl=use_yn             Param=BindColVal </C>
                    <C>Col=use_yn_name      Ctrl=use_yn_name        Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

