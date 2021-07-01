<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 비밀번호설정
 * 프로그램ID 	: my510i
 * J  S  P		: my510i.jsp
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-10-24
 * 기능정의		: 비밀번호변경
 * [ 수정일자 ][수정자] 내용
 * [2011-10-24][박경국] 비밀번호변경
 * [2014-01-14][심동현] 이전 테스트만 완료.. 로긴 후 띄우는 페이지이므로 바로 변경
 *						향후 스크립트, 저장 로직 보완
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Config/common/include/head.jsp"/>
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
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
		} 
		
		function fnInit() {
			
			
			var THeader="pwd_new1:STRING(20):,pwd_new2:STRING(20)";
			ds1.SetDataHeader(THeader);
			
		    //alert("1"); 
	        ds1.addRow();	
	        //alert("2");
		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
		
		}
			
		/*
		 * 입력 체크
		 */
		function fnCheck() {
			 return true;
		}

		/*
		 * 저장
		 */		
		function fnApply() {
		
				   /*if(pwd_past.value==null ||pwd_past.value=='') {
						alert("기존 비밀번호를 입력하세요!");
						return false;
					} else*/
					if (pwd_new1.value==null ||pwd_new1.value=='') {
							alert("변경 할 비밀번호를 입력하세요!");
							return false;
					}  else if (pwd_new2.value==null ||pwd_new2.value=='') {
							alert("비밀번호 확인을 입력하세요!");
							return false;
					}	else if (pwd_new1.value != pwd_new2.value){
							alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
							return false;
					}	else if(pwd_new1.value.length < 8){
							alert("비밀번호는 문자,숫자,특수문자의 조합으로 8~20자리로 입력해 주세요");
							return false;
					}	else if(pwd_new1.value.length > 20){
							alert("비밀번호는 문자,숫자,특수문자의 조합으로 8~20자리로 입력해 주세요");
							return false;
					}	else if(!pwd_new1.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
							alert("비밀번호는 문자,숫자,특수문자의 조합으로 8~20자리로 입력해 주세요");
							return false; 
					}
					
					var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
									 + "sPwd_new1=" + ds1.namevalue(ds1.rowposition,"pwd_new1");	
			      
			      	//alert(param);
					ln_TRSetting(tr1, 
					    "<%=dirPath%><%=HDConstant.PATH_MY%>My510I",
					    "JSP(I:DS1=ds1)",
					    param);
					   
					tr_post(tr1);
		}
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
		alert("비밀번호가 변경 되었습니다");
		ds1.ClearData();
	</script>	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        alert("row::"+row);               	 			 	
	</script>		
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
	</object>

	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border="0" cellpadding="0" cellspacing="0" width="700">	
		<tr>
			<td align="right">
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table>
					<tr>
						<%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=450px; height:1" border="0" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name="Format" 			value="
				                <C> name='새로운비밀번호'		ID='pwd_new1' width=160  align=center editlimit=8  edit=none  show=false</C>
				                <C> name='새로운비밀번호확인'  	ID='pwd_new2' width=160    align=center editlimit=8 edit=none show=false</C>
				    			">
						</object>
						<%=HDConstant.COMMENT_END%>
					</tr>					
				</table>
				<table  border="0" cellpadding="0" cellspacing='3'>
					<tr>
						<td  width='120px' height='30px' class='boardt02'>새로운비밀번호</td>
						<td   bgcolor='#FFFFFF'>
							&nbsp;&nbsp;<input type="password" id='pwd_new1' 	value='' maxlength='20' minlength="7" size='30' 	class='textbox'>
						</td>
						<td>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;- [사번/아이디] 사용금지
						</td>
					</tr>
					<tr>
						<td width='120px' height='30px' class='boardt02'>새로운비밀번호확인</td>
						<td bgcolor='#FFFFFF'>
							&nbsp;&nbsp;<input type="password" id='pwd_new2' value='' maxlength='20' minlength="7" size='30' 	class='textbox'> 
						</td>
						<td>
						</td>
						<td>&nbsp;&nbsp;&nbsp;- 회사규정 업무처리 22. 정보보안규정에 의거<br>
						&nbsp;&nbsp;&nbsp;- [영문+숫자+특수문자] 8자~20자 사용						
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
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
	    <C>Col=pwd_new1           Ctrl=pwd_new1            Param=value </C>
	    <C>Col=pwd_new2         	Ctrl=pwd_new2	       Param=value </C>

	">
</object>
<%=HDConstant.COMMENT_END%>  
<input type="hidden" name="row" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		