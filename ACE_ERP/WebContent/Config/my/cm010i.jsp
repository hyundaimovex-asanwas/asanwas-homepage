<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>환경설정>마이페이지>커뮤니티>2015 소통QnA. 쓰기
 * 프로그램ID 	 : Config/my/cm010i
 * J  S  P		 : cm010i.jsp
 * 서 블 릿		 : Cm010I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2015-02-11
 * [ 수정일자 ][수정자] 내용
 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.HDConstant"%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
	<title>2015년 WORKSHOP [임직원 소통을 위한 Q&A] 질문</title>
		
	<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">
	<link href="<%=dirPath%>/Sales/common/css/common.css" rel="stylesheet" type="text/css">
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(){
	    v_job ="I";
		//데이터셋 헤더 초기화
		ds_wm.SetDataHeader("a1:STRING(200),a2:STRING(4000)");
		ds_wm.addrow();
		document.all.a1.focus();
    }
    

	<%//저장 %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_wm.RowPosition;
		
		if (ds_wm.IsUpdated) {
			ln_TRSetting(tr1, 
               "<%=dirPath%><%=HDConstant.PATH_MY%>Cm010I",
               "JSP(I:DS_WM=ds_wm)",
               "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
               	);
       		tr_post(tr1);

		}else {
     		alert("작성된 내용이 없습니다.");
	 	}
	}


	</script>

	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
	    
		if(document.form1.chkbox.checked) {
			var todayDate = new Date();
			todayDate.setDate( todayDate.getDate() + 1 );//3일
			document.cookie = "pop2015=done; path=/; expires=" + todayDate.toGMTString() + ";"
		}
		window.close();
	}
</script>

  
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_wm classid=<%=HDConstant.MxDataSetU_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTRU_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
</head>

<!-- //body_s.jsp -->
<body onLoad="fnOnLoad();">
<!-- //body_s.jsp -->

<table border='0' cellpadding='0' cellspacing='0' width="100%">
  <tr>
  	<td class="c" style="padding-top:10px">
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width="470">
  <tr>
  	<td class="c">
    <table border='0' cellpadding='0' cellspacing='0' width="430"> 
        <tr height='56px'>
            <td class="c bold" style="font-size:14px;color:#0033ff">2015년 WORKSHOP [임직원 소통을 위한 Q&A] 질문</td>
        </tr>
        <tr height='36px'>
            <td class="l">1. 질문 대상</td>
        </tr>
        <tr>
            <td class="c"><textarea name="a1" id="a1"  class=textbox cols=65 rows=5  tabindex="1"></textarea></td>
        </tr>
        <tr height='36px'>
            <td class="l">2. 질문 내용</td>
        </tr>
        <tr>
            <td class="c"><textarea name="a2" id="a2"  class=textbox cols=65 rows=23  tabindex="2"></textarea></td>
        </tr>
        <tr>
            <td class="l" style="padding-left:10px;">
            * 익명 제출이오니 질문 및 건의사항 등 자유롭게 작성하시기 바랍니다.<br>
			* 마감 예정 : 2월 25일</td>
        </tr>
        <tr height='40px'>
            <td class="c"><form name="form1" style="display:inline;margin:0px;">
				<input type="checkbox" name="chkbox" id="chkbox" onfocus='this.blur()' />
				</form>하루동안 안보기
            <img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" onClick="fnApply();"></td>
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
	
	     <object id=bn1 classid=<%=HDConstant.MxBinderU_CLASSID%>>
	             <param name="DataId" value="ds_wm">
	             <param name=BindInfo    value="
					<C>Col=A_SID	Ctrl=a_sid		Param=Value </C>
					<C>Col=A1       Ctrl=a1        Param=Value </C>
					<C>Col=A2    	Ctrl=a2    	Param=Value </C>
	              ">
	      </object>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		