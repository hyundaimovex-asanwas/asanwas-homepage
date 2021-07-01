<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 고객관리
 * 프로그램ID 	 : CU080S
 * J  S  P		 : cu080s
 * 서 블 릿		 : Cu080S
 * 작 성 자		 : 남기표
 * 작 성 일		 : 2006-06-16
 * 기능정의		 : 방북증신조회 (조회,엑셀)
 * 				      메세지를 발송하는 페이지는 외부SMS 모듈 처리를 위해 windwos서버에 ASP로 되어 있음.
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
       
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩
// Parameter 	:
%>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			fnInit();
		}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 선조회
// Parameter 	:
%>
	function fnInit(){
           v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");

		//2008-01-25 사이트코드  by 심동현 
//		sSiteCode.Index=0;
		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS_ALL=codeDs1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);           
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	:
%>
    function fnSelect() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

        v_job = "S";

        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid=" + txt_client_sid.value
                  + ",sEducNo=" + txt_educ_no.value
                  + ",sNcardNo=" + txt_n_card_no.value                  
                  + ",sCustNm=" + txt_cust_nm.value
                  + ",sManageNo=" + txt_manage_no.value;
 		ln_TRSetting(tr2, 
	        "<%=dirPath%><%=HDConstant.PATH_CU%>Cu080S",
	        "JSP(O:DEFAULT=ds1)",
	        param);
		tr_post(tr2);
    
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  협력업체 키보드로 조회
// Parameter 	: 
%>
	function fnSelectDs11() {
		if(txt_client_cd.value!=""&&txt_client_nm.value=="") {
			ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?proType=S&dsType=1&keyWord="+txt_client_sid.value+"&gubun=2" ;
			ds3.Reset();
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  협력업체정보 조회
// Parameter 	: 
%>
	function fnSelectDs13() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid=" + txt_client_sid.value;

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 (사용안함)
%>
    function fnExcel() {
        if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:방북증조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("방북증조회", "방북증조회.xls", 8);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  협력업체코드 Help
%>
    function fnClientSidPopup() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
            
        strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=2";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    	
        if (arrResult != null) {
            arrParam = arrResult.split(";");        
            txt_client_sid.value= arrParam[0];
            txt_client_nm.value= arrParam[1];
            txt_client_cd.value = arrParam[2];
          	fnSelectDs13();
        } else {

        }       
    }
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    

		</script>	    
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert(row + " 검색된 데이타가 없습니다."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") { sEducPlanDt.value=ds1.namevalue(row,"educ_plan_dt"); return; }
    if( row < 1){
        alert(row + " 검색된 데이타가 없습니다."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
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
            <table width="845" border="0" cellspacing="0" cellpadding="0">
                <tr>
            		<td align="right" valign="bottom">
            			<img src="<%=dirPath%>/Sales/images/refer.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnSelect()">
            			<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnExcel()">
            		</td>
            	</tr>

            	<tr>
            		<td height="10"></td>
            	</tr>
                <tr>
                    <td width="845">
                        <table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="845px">
							<tr>
								<td width="100px" height="30px" class="text">협력업체코드</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
                                 	<input id="txt_client_nm" type="text" class="textbox"  size='15' maxlength="10" onchange="txt_client_sid.value='',txt_client_nm.value=''" onblur="fnSelectDs11()" onkeyup="this.value=this.value.toUpperCase()">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="협력업체를 검색합니다" style="cursor:hand;position:relative;left:0px;top:0px" align='absmiddle' onclick="fnClientSidPopup();">
									<input id="txt_client_cd" type="hidden" class="boardt04"  style= "position:relative;left:0px;top:3px;color:black;width:100px; height:20px;" maxlength="50" readonly>
									<input id="txt_client_sid" type="hidden"> 
								</td>
								<td width="100px" class="text">방북증 승인번호</td>
								<td colspan=3 align="left" bgcolor="#ffffff" >&nbsp;
									<input type="text" name="txt_educ_no" size="15" maxlength="14" class="textbox"> (- 포함)
								</td>
							</tr>
							<tr>
								<td class="text">방북증번호</td>
								<td align="left" bgcolor="#ffffff" >&nbsp;
									<input type="text" name="txt_n_card_no" size="15" maxlength="12" class="textbox">
								</td>

								<td width="100px" height="30px" class="text">성명</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<input type="text" name="txt_cust_nm" size="15" maxlength="30" class="textbox"></td>
								<td width="100px" height="30px" class="text">주민/여권번호</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<input type="text" name="txt_manage_no" size="15" maxlength="20" class="textbox" onkeyup="this.value=this.value.toUpperCase()"></td>
							</tr>
						</table>
            		</td>
            	</tr>
            	<tr>
            		<td height="10"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=3>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:430px" border="1">
									<param name="DataID"			value="ds1">
									<param name="ColSizing"			value="true">
									<param name="Fillarea"			value="false">
									<param name="Editable"  		value="false">
									<param name="BorderStyle"       value="0">
									<param name="ViewSummary"       value="1">
									<param name="Format" 			value="
										<C> name='CLIENT_SID'	  	ID='client_sid'     	HeadAlign=Center Width=100 	show=false</C>
										<C> name='코드'		  		ID='client_cd'       	HeadAlign=Center align=center Width=50  </C>
										<C> name='협력업체'  	  	ID='client_nm'       	HeadAlign=Center align=left Width=100 sumtext=@cnt  </C>
										<C> name='성명'     	  	ID='cust_nm'          	HeadAlign=Center align=center Width=60 sumtext=명 </C>
										<C> name='주민/여권번호'	ID='manage_no'        	HeadAlign=Center align=center Width=100  mask='XXXXXX-XXXXXXX'</C>
										<C> name='방북증번호'	  	ID='n_card_no'     		HeadAlign=Center align=center Width=100 	</C>
										<C> name='지역'	  			ID='saup_sid'     		HeadAlign=Center align=center Width=60 editstyle=lookup data='codeDs1:saup_sid:saup_nm'	</C>
										<C> name='방북목적'  	  	ID='visit_object'     	HeadAlign=Center align=left Width=150  </C>
										<C> name='방북증승인번호'	ID='educ_no'     		HeadAlign=Center align=center Width=100 	</C>
									  <G> name='방문기간'
										<C> name='시작일'	  	  	ID='visit_fr_dt'      	HeadAlign=Center align=center Width=80 	mask='XXXX-XX-XX'</C>
										<C> name='종료일'	  	  	ID='visit_to_dt'      	HeadAlign=Center align=center Width=80 	mask='XXXX-XX-XX'</C>
									  </G>
									  <G> name='유효기간'
										<C> name='시작일'	  	  		ID='credit_fr_dt'      	HeadAlign=Center align=center Width=80 	mask='XXXX-XX-XX'</C>
										<C> name='종료일'	  	  		ID='credit_to_dt'      	HeadAlign=Center align=center Width=80 	mask='XXXX-XX-XX'</C>
									  </G>
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

