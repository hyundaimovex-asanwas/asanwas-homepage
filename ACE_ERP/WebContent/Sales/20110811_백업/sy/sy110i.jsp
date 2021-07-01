<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 시스템관리
 * 프로그램ID 	: SY110I
 * J  S  P		: sy110i
 * 서 블 릿		: Sy110i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-16
 * 기능정의		: 일반 우편번호 관리 (조회 등록 삭제 수정)
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
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
		function fnSetHeaderDs1(){
				var s_temp = "zip_cd:STRING,address1:STRING,address2:STRING,address3:STRING,post_box:STRING";
				ds1.SetDataHeader(s_temp);
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 선조회 
// Parameter 	: 
%>
		function fnInit(){
		    fnSetHeaderDs1();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	: 
%>
		function fnSelect() {
			fnSelectDs1();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  
// Parameter 	: 
%>
		function fnSelectDs1() {
			if(ds1.Isupdated){
				alert("수정중인 행이 있습니다.");
			}else{
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy110i?proType=S&dsType=1&sKeyWord="+sKeyWord.value;
				ds1.Reset();
			}			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행추가 (그리드별)
// Parameter 	: 
%>
			function fnAddRowDs1() {
					fnSetHeaderDs1();
					ds1.addrow();
					gr1.setcolumn("zip_cd");
			
					window.status=" 행이 삽입되었습니다.";
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용 
// Parameter 	: 
%>
		function fnApply() {
				
			if (ds1.IsUpdated) {
				tr1.KeyValue = "Sy110i(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy110i?proType=A&dsNum=1";
				tr1.post();
				ds1.ResetStatus();
			}		
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
		function fnCancelDs1() {
			ds1.undoall();
			window. status="데이터 변경이 취소되었습니다.";
			return;		
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행삭제
// Parameter 	: 
%>
			function fnDeleteRowDs1() {			
				if(ds1.IsUpdated) {
					alert("수정중인 행이 있으면 삭제할 수 없습니다.");
					return;
				}else{
						ds1.deleterow(ds1.rowposition);
						fnApply();
						window.status="선택한행이 삭제되었습니다.";
					
						return;
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  인쇄 (사용안함)
%>
		function fnPrintDs1() {
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 (사용안함)
%>
		function fnExcelDs1() {
			gr1.RunExcelSheet("우편번호");
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  분류명 팝업 (사용안함)
%>
		function fnPopup() {
			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  입력값 체크 
%>
		function fnCheck() {
		}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function fnSetHeaderDs1(){
				if (ds1.countrow<1){
					var s_temp = "zip_cd:STRING,address1:STRING,address2:STRING,address3:STRING,post_box:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}
			
		
		</script>	
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
////////////////////////////////////////////////////////////////////////////////
//// 아래키가 눌렸을 경우 AddRow
%>
<script language=JavaScript for=gr1 event=onKeyPress(keycode)>

          if (keycode == 40) {
				fnAddRowDs1();
          }

 </script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="작업이 성공적으로 완료되었습니다.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
		<script language="javascript" for="tr1" event="onfail()">
			window.status="작업이 성공적으로 완료되지 못했습니다.";
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회완료
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
//			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" 조회중 에러가 발생했습니다 : " + ds1.ErrorMsg );
			window.status="조회가 완료 되었습니다.";
			//document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<comment id="__NSID__"><object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
  <tr height="30px" >                     
	<td align="left"  width="355px">
		<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left">
		  <tr  bgcolor="#6f7f8d" align="left">
			<td height="30px" width="60px"  bgcolor="#eeeeee" align="center" class="text">주 소</td>
			<td bgcolor="#ffffff" width="143px">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
				  <tr>
					<td width="110px" align="center"  bgcolor="#FFFFFF">
						<input height="22px" id="addr" name="sKeyWord" type="text" size="10"  maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelect();" class="textbox">
					</td>	
				  </tr>
				</table>
			</td>   
		  </tr>           
		</table>
	</TD>
	<TD width="645" align="right" >
		<table  cellpadding="0" cellspacing="0" border="0">
		  <tr>        					
			<td align="right" width=100%><NOBR>
			  <img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:hand;position:relative;top:3px" onclick="fnExcelDs1()">   
			  <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;top:3px" onclick="fnSelect()">     
			  <img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand;position:relative;top:3px"  onClick="fnAddRowDs1()" >
			  <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;top:3px" onClick="fnDeleteRowDs1()" >     
			  <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;top:3px" onClick="fnApply()">      
			  <img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;top:3px"  onclick="fnCancelDs1()"> </NOBR>
			</td>
		  </tr>
		</table>	
	</td>
  </tr>
  <tr>
	<td height=3 COLSPAN=2 border="0"></td>
  </tr>
  <tr> 
	<td COLSPAN=2> 
		<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:310px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
		  <tr> 
			<td>
				<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400px;border:1 solid #777777;">   
					<param name="DataID"			value="ds1">                                                                                                                              
					<param name="BorderStyle"   	value="0">                                                                                                                                        
					<param name="Fillarea"			value="true">                                                                                                                             
					<param name="ColSizing"     	value="true">                                                                                                                                     
					<param name="IndWidth"      	value="0">                                                                                                                                        
					<param name="Editable"      	value="true">                                                                                                                                     
					<param name="LineColor" 		value="#dddddd">                                                             
					<param name="Format"		value="  
						<c> Name='우편번호'	 	ID='zip_cd'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center mask='XXX-XXX'</c>
						<c> Name='시/도' 		ID='address1'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center </c>
						<c> Name='구/군' 		ID='address2'	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center </c>
						<c> Name='읍/면/동'	 	ID='address3'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=250  align=left </c>
						<c> Name='번지'	 		ID='post_box'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=195  align=left </c>
					">
				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
		<C>Col=zip_cd 			Ctrl=zip_cd 		    Param=Text </C>
		<C>Col=address1 		Ctrl=address1 		    Param=value </C>
		<C>Col=address2 		Ctrl=address2			Param=value </C>
		<C>Col=address3 		Ctrl=address3			Param=value </C>
		<C>Col=post_box 		Ctrl=post_box			Param=value </C>"     
	>
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<input type="hidden" name="row" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

