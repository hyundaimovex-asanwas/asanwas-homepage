<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 대리점정보변경
 * 프로그램ID   : MY320I
 * J  S  P      : my320i
 * 서 블 릿        : My320I
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

            //cfStyleGrid(getObjectFirst("gr1"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn");
            cfStyleGrid(getObjectFirst("gr3"), "comn");
            
            fnInit(); 
            
            // 
            codeDs1.deleteRow(1);
            codeDs2.deleteRow(1);
            codeDs3.deleteRow(1);
            codeDs4.deleteRow(1);
            codeDs5.deleteRow(1);
            
            agen_gu.index = 0;
            dir_yn.index = 0;
            area_cd.index = 0;
            cunt_status.index = 0;
            use_yn.index = 0;
        } 
            
        /*
         * 초기작업
         * Header 설정 
         */
        function fnInit(){
            jobFlag = "INIT";
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                "JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
            
            fnSelect();
        }
            
        /*
         * 메인 조회
         */
        function fnSelect() {
            if (ds1.IsUpdated==false || !ds2.IsUpdated==false || !ds3.IsUpdated==false) {
                var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                          + ",sClient_nm=71000";
                
                ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                    "JSP(O:DS1=ds1)",
                    param);
                tr_post(tr1);
            } else {
                alert("작업중인 상태에서는 조회할수 없습니다!");
            }
        }
            
        /*
         * 저장
         */     
        function fnApply() {
            if (ds1.IsUpdated) {
                if(fnCheck()){
                  ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                    "JSP(I:DS1=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
                    tr_post(tr1);
                }
            } else {
                alert("변경된 내역이 없습니다.");
                return;
            }
        }
      
        /*
         * 계약정보, 지점조회
         */ 
        function fnSelectDs1() {
            jobFlag = "DETAIL";
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",sClient_sid=" + ds1.namevalue(ds1.rowposition,"client_sid");
                     
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                "JSP(O:DS3=ds3,O:DS2=ds2)",
                param);
            tr_post(tr1);
        }
            
        /*
         * 입력 체크
         */
        function fnCheck() {
            if (ds1.IsUpdated) {
                if (jobFlag != "D") {
                    if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
                        alert("대리점담당자를 입력하세요!");
                        getObjectFirst("client_dam_nm").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "tel_no")=="") {
                        alert("전화번호를 입력하세요!");
                        getObjectFirst("tel_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "mobile_no")=="") {
                        alert("휴대전화를 입력하세요!");
                        getObjectFirst("mobile_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "fax_no")=="") {
                        alert("팩스를 입력하세요!");
                        getObjectFirst("fax_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "e_mail")=="") {
                        alert("이메일을 입력하세요!");
                        getObjectFirst("e_mail").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "zip_cd")=="") {
                        alert("우편번호를 선택하세요!");
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "address2")=="") {
                        alert("상세주소를 입력하세요!");
                        getObjectFirst("address2").focus();
                        return false;
                    }
                }
            }
            return true;
        } 

        /*
         * 취소 
         */
        function fnCancel() {
            ds1.undoall();
            window. status="데이터 변경이 취소되었습니다.";
            return;     
        }

        /*
         * 엑셀
         */
        function fnExcelDs1() {
            gr1.runexcelsheet("고객엑셀등록");
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
         * 영업담당자
         */
         
         function fnSalDamPopup(flag) {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            
            
            arrResult = showModalDialog(strURL,arrParam,strPos);    
            
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                
                
                if (flag == "S") {
                    sSal_dam_sid.value = arrParam[0];
                    sSal_dam_nm.value = arrParam[2];
                } else if (flag == "I") {
                    sal_dam_sid.value = arrParam[0];
                    sal_dam_nm.value = arrParam[2];
                }
            } else {
                if (flag == "S") {
                    sSal_dam_sid.value = "";
                    sSal_dam_nm.value = "";
                } else if (flag == "I") {
                    sal_dam_sid.value = "";
                    sal_dam_nm.value = "";
                }
            }
         }

        /*
         * 대리점 팝업
         */
        function fnClientPopup() {
            
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            var dir = '<%=dirPath%>';
            
            arrResult = fnClientPop(dir,'1');
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                client_cd.value = arrParam[2];
                client_nm.value = arrParam[1];
            } else {
              client_nm.value = "";
              client_cd.value = "";
            }               
        }        
        </script>
        

<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="onsuccess()">
        window.status="작업이 성공적으로 완료되었습니다.";
        
        if(ds1.CountRow>0 && jobFlag!="DETAIL"){
            fnSelectDs1()
        }
    </script>   
    
    <script language=JavaScript for=mxTab event=OnSelChanged(index)>
        if (index == 1) {
            tabFlag.value = "1";
        } else if (index == 2) {
            tabFlag.value = "2";
        } 
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
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  대리점 조회 -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  계약정보 -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지점정보 -->
    <param name="SyncLoad"  value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  대리점구분 -->
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
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  하위대리점 여부 -->
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
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td height='25px' align='right'>
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
                            <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                                <tr>
                                    <td width='100%'height='244px'>
                                        <table border='0' cellpadding='0' cellspacing='1' width='100%' height='244px' bgcolor="#666666">
                                            <tr>
                                                <td class='text'>대리점코드</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="00000">
                                                        <param name=Enable      value="false">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td  class='text'>대리점명</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='client_nm'       name='client_nm'        value='' maxlength='30' size='20'   class='input01' readOnly> <!-- 대리점 명 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>거래처명</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    <input type='hidden' id='vend_cd'           name='vend_cd'          value='' maxlength='13' size='10'   class='textbox'> <!-- 거래처코드 -->
                                                    &nbsp;&nbsp;<input type='text' id='vend_nm'             name='vend_nm'          value='' maxlength='62' size='15'   class='input01' readOnly> <!-- 거래처명 -->
                                                </td>
                                                <td  class='text'>영업담당자</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    <input type='hidden' id='sal_dam_sid'       name='sal_dam_sid'      value='' maxlength='12' size='12'   class='textbox' readonly> <!-- 영업담당자코드 -->
                                                    &nbsp;&nbsp;<input type='text' id='sal_dam_nm'      name='sal_dam_nm'       value='' maxlength='22' size='10'   class='input01' readOnly> <!-- 영업담당자명 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>대리점 구분</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=agen_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs1>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                        <param name=Enable          value="false">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                     
                                                </td>
                                                <td  class='text'>직판여부</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
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
                                                <td class='boardt02'>대리점담당자</td>
                                                <td colspan='3' width='300px' bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='client_dam_nm'   name='client_dam_nm'    value='' maxlength='20' size='20'   class='textbox'> <!-- 대리점담당자 -->
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>전화번호</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='tel_no'          name='tel_no'           value='' maxlength='20' size='20'   class='textbox'> <!-- 전화번호 -->
                                                    
                                                </td>
                                                <td  class='boardt02'>휴대전화</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='mobile_no'       name='mobile_no'        value='' maxlength='15' size='20'   class='textbox'> <!-- 휴대전화 -->
                                                </td>
                                            </tr>

                                            <tr>
                                                <td  class='boardt02'>팩스번호</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='fax_no'          name='fax_no'           value='' maxlength='20' size='20'   class='textbox'> <!-- FAX번호 -->
                                                </td>
                                                <td  class='boardt02'>메일주소</td>
                                                <td  bgcolor='#FFFFFF'>
                                                     &nbsp;&nbsp;<input type='text' id='e_mail'             name='e_mail'           value='' maxlength='30' size='23'   class='textbox'> <!-- 이메일 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>우편번호</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
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
                                                <td  class='boardt02'>지역코드</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
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
                                                <td  class='boardt02'>주소1</td>
                                                <td  bgcolor='#FFFFFF' colspan='3'>
                                                    &nbsp;&nbsp;<input type='text' id='address1'        name='address1'         value='' maxlength='60' size='50'   class='textbox'> <!-- 주소1 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>주소2</td>
                                                <td  bgcolor='#FFFFFF'colspan='3'>
                                                    &nbsp;&nbsp;<input type='text' id='address2'        name='address2'         value='' maxlength='60' size='50'   class='textbox'> <!-- 주소2 -->
                                                </td>
                                            </tr>

                                            <tr>
                                                <td  class='text'>수수료율</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=commi_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>           
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="00.00">
                                                        <param name=Enable      value="false">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>

                                                </td>
                                                <td  class='text'>계약상태</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=cunt_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs4>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">   
                                                        <param name=Enable          value="false">                                                 </object>
                                                    <%=HDConstant.COMMENT_END%>                                                     
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>은행</td>
                                                <td  bgcolor='#FFFFFF'>
                                                     <input type='hidden' id='bancod'           name='bancod'           value='' maxlength='6'  size='6'    class='input01' readOnly> <!-- 은행코드 -->
                                                     &nbsp;&nbsp;<input type='text' id='bannam'             name='bannam'           value='' maxlength='30' size='20'   class='input01' readOnly> <!-- 은행명 -->
                                                </td>
                                                <td  height='22px' class='text'>계좌번호</td>
                                                <td  height='22px' bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='bank_acc_no'         name='bank_acc_no'      value='' maxlength='20' size='20'   class='input01' readOnly> <!-- 은행계좌번호 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>예금주</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='bank_acct_nm'    name='bank_acct_nm'     value='' maxlength='32' size='20'   class='input01' readOnly> <!-- 예금주 -->
                                                </td>
                                                <td  class='text'>사용유무</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
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
                                <tr>
                                    <td height='10px'></td>
                                </tr>
                                <tr>
                                    <td>
                                        <table  border='0' cellpadding='0' cellspacing='0' width='845px'>
                                            <tr>
                                                <td align='left'>
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='200px' height='20px'> 
                                                        <param name="BackColor"         value="#00FFFF">
                                                        <param name="DisableBackColor"  value="#fffff0">
                                                        <param name="Format"            value='
                                                            <T>divid="tab1" title="계약정보"</T>
                                                            <T>divid="tab2" title="지점정보"</T>'>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            <tr >
                                                <td valign=top>
                                                    <div id=tab1 style="position:absolute; width:845; height:97">     
                                                        <%=HDConstant.COMMENT_START%>                                                                                                        
                                                        <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=845; height=97" border='1'>                                       
                                                            <param name="DataID"            value="ds2">                                                                                                                            
                                                            <param name="Fillarea"          value="true">                                                                                                                           
                                                            <param name="Editable"          value="false">                                                                                                                           
                                                            <param name="BorderStyle"       value="0">                                                                                                                       
                                                            <param name="Format"            value="                                                                                                                                 
                                                               <C> name='대리점SID'        ID='client_sid'         align=left editlimit=12 width=100 show=false</C>
                                                               <C> name='계약일자'          ID='cont_date'          align=left editlimit=8  width=100 show=true</C>
                                                               <C> name='만료일자'              ID='expire_date'        align=left editlimit=8  width=100 show=true</C>
                                                               <C> name='보험료'               ID='insur_amt'          align=left editlimit=10 width=100 show=true</C>
                                                               <C> name='보증보험회사코드'      ID='insur_comp_cd'      align=left editlimit=2  width=100 show=false </C>
                                                               <C> name='보증보험회사명'   ID='insur_comp_cd_name' align=left editlimit=50 width=205 show=true editstyle=popup</C>
                                                            ">                                                                                                                                                                              
                                                        </object> 
                                                        <%=HDConstant.COMMENT_END%>                                                                                                                                                                               
                                                    </div>   
                                                    <div id=tab2 style="position:absolute; width:845; height:97">   
                                                        <%=HDConstant.COMMENT_START%>                                                                                                                          
                                                        <object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=845; height=97" border='1'>                                                  
                                                            <param name="DataID"            value="ds3">                                                                                                                            
                                                            <param name="Fillarea"          value="true">                                                                                                                           
                                                            <param name="Editable"          value="false">                                                                                                                           
                                                             <param name="BorderStyle"       value="0">                                                                                                                                  
                                                            <param name="Format"            value="                                                                                                                                            
                                                               <C> name='지점코드'        ID='branch_cd'              width=60 align=left editlimit=3    show=true</C>
                                                               <C> name='지점명'          ID='branch_nm'              width=100 align=left editlimit=20 show=true</C>
                                                               <C> name='지역명'          ID='area_nm'                width=60 align=left editlimit=10 show=true editstyle=popup</C>
                                                               <C> name='본점여부'        ID='client_down_yn_name'    width=80 align=left editlimit=50 show=true editstyle=popup</C>
                                                               <C> name='담당자'          ID='empno'                  width=60 align=left editlimit=7    show=true</C>
                                                               <C> name='전화번호'        ID='tel_no'                 width=100 align=left editlimit=15 show=true</C>
                                                               <C> name='휴대전화'        ID='mobile_no'              width=100 align=left editlimit=15 show=true</C>
                                                               <C> name='팩스번호'        ID='fax_no'                 width=100 align=left editlimit=20 show=true</C>
                                                               <C> name='지점홈페이지'     ID='branch_url'             width=200 align=left editlimit=40 show=true</C>
                                                            ">                                                                                                                                                                                         
                                                        </object>     
                                                        <%=HDConstant.COMMENT_END%>
                                                    </div>
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

