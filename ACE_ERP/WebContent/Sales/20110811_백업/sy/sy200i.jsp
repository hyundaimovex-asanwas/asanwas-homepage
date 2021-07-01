<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 시스템관리
 * 프로그램ID 	: SY200I
 * J  S  P		: sy200i
 * 서 블 릿		: Sy200i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-16
 * 기능정의	: 지역 관리(조회 등록 삭제 수정)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-08-05][박경국] 화면에 표시되는 컬럼 중 [사용여부],[순서] 항목 추
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

<!-- HTML 시작-->가
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
	<script language="JavaScript">
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
		}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>
		function fnSetHeaderDs1(){
				var s_temp = "saup_cd:STRING,saup_nm:STRING";
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
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200i?proType=S&dsType=1";
				ds1.Reset();
			}			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행추가 (그리드별)
// Parameter 	: 
%>
			function fnAddRowDs1() {
					ds1.addrow();
					gr1.setcolumn("saup_cd");
			
					window.status=" 행이 삽입되었습니다.";
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용 
// Parameter 	: 
%>
		function fnApply() {
				
			if (ds1.IsUpdated) {
				tr1.KeyValue = "Sy200i(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200i?proType=A&dsNum=1";
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
			gr1.RunExcelSheet("지역 관리");
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  우편번호 팝업
%>
			function fnZipCodePopup(){ 
			
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				
				strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);	
			
				if (arrResult != null) {
					arrParam = arrResult.split(";");
			   		zip_cd.Text = arrParam[0];
			   		address1.value = arrParam[1];
			   		
				} else {
				  zip_cd.value = "";
				  address1.value = "";
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  입력값 체크 
%>
		function fnCheck() {
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
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회완료
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
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
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  전체 프로그램 목록 
%>
<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  전체 프로그램 목록 
%>
<comment id="__NSID__"><object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table  cellpadding="0" cellspacing="0" border="0" BORDERCOLOR=ORANGE>
	<tr>
	  <TD ALIGN=RIGHT HEIGHT=30>
	   	<table  cellpadding="0" cellspacing="0" border="0">
		  <tr>        					
			<td align="right" width=100%>
			<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:hand;position:relative;top:3px" onclick="fnExcelDs1()">   
			<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;top:3px" onclick="fnSelect()">     
			<img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand;position:relative;top:3px"  onClick="fnAddRowDs1()" >
			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;top:3px" onClick="fnDeleteRowDs1()" >     
			<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;top:3px" onClick="fnApply()">      
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;top:3px"  onclick="fnCancelDs1()"> 
			</td>
		  </tr>
		</table>	
	  </td>
	</tr>
	<tr>
	  <td height=3  border="0"></td>
	</tr>
	<tr> 
	  <td> 
		<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:310px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
		  <tr> 
			<td>
				<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=250px; height:400px;border:1 solid #777777;">   
					<param name="DataID"			value="ds1">                                                                                                                              
					<param name="BorderStyle"   	value="0">                                                                                                                                        
					<param name="Fillarea"			value="true">                                                                                                                             
					<param name="ColSizing"     	value="true">                                                                                                                                     
					<param name="IndWidth"      	value="0">                                                                                                                                        
					<param name="Editable"      	value="true">                                                                                                                                     
					<param name="LineColor" 		value="#dddddd">                                                             
					<param name="Format"			value="  
						<c> Name='지역 코드'	 	ID='saup_cd'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center </c>
						<c> Name='지역 명' 			ID='saup_nm'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center </c>
					">
				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
			</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td valign="top">
			  <table width="495px" cellpadding="0" cellspacing="0">
			  	<tr>
			  		<td align="right">
			  			<table width="530px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" algin=right>
			  				<tr>
			  					<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="boardt02">지역 코드</td>
			  					<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="saup_cd" type="text" class="textbox"   size="10" value="" maxlength="2" onBlur="bytelength(this,this.value,5);" onkeydown="if (event.keyCode == 13) saup_nm.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">지역 명</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="saup_nm" type="text" class="textbox"    value="" size="30" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) saup_no.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">사용여부</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="use_yn" type="text" class="textbox"    value="" size="10" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) display_seq.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">순서</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="display_seq" type="text" class="textbox"    value="" size="10" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) display_seq.focus();">
			  					</td>
			  				</tr>
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">사업자 번호</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="saup_no" type="text" class="textbox"    value="" size="20" maxlength="12" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) ceo_nm.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">대표이사</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="ceo_nm" type="text" class="textbox"    value="" size="30" maxlength="20" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) zip_cd.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">우편번호</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<comment id="__NSID__"><object id=zip_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align=center>			
			  						<param name=Text 		value="">
			  						<param name=Alignment 	value=1>
			  						<param name=Format 		value="###-###">
			  						<param name=Cursor	 	value="iBeam">
			  						<param name=ReadOnly  	value="true">
			  					
			  				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;&nbsp;&nbsp;
			  				<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnZipCodePopup();"></td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">주 소</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="address1" type="text" class="textbox"    value="" size="40" maxlength="60" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) address2.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">상세주소</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="address2" type="text" class="textbox"    value="" size="40" maxlength="60" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) tel_no1.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">대표전화</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="tel_no1" type="text" class="textbox"    value="" size="20" maxlength="15" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) fax_no1.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">대표팩스</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="fax_no1" type="text" class="textbox"    value="" size="20" maxlength="15" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) uptae.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">업 태</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="uptae" type="text" class="textbox"    value="" size="30" maxlength="50" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) jongmok.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">종 목</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="jongmok" type="text" class="textbox"    value="" size="30" maxlength="50" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) homepage.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">홈페이지</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="homepage" type="text" class="textbox"    value="" size="25" maxlength="25" onBlur="bytelength(this,this.value,50);" onkeydown="if (event.keyCode == 13) e_mail.focus();">
			  					</td>
			  				</tr>	
			  				<tr>
			  					<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="boardt02">E-Mail</td>
			  					<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
			  						<input id="e_mail" type="text" class="textbox"    value="" size="25" maxlength="30" onBlur="bytelength(this,this.value,50);">
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
		<C>Col=saup_cd 			Ctrl=saup_cd 		    Param=value </C>
		<C>Col=saup_nm 			Ctrl=saup_nm 		    Param=value </C>
		<C>Col=display_seq 		Ctrl=display_seq 	    Param=value </C>
		<C>Col=use_yn 			Ctrl=use_yn 		    Param=value </C>
		<C>Col=saup_no 			Ctrl=saup_no 			Param=value </C>
		<C>Col=saup_eng_nm 		Ctrl=saup_eng_nm 		Param=value </C>
		<C>Col=ceo_nm 			Ctrl=ceo_nm 			Param=value </C>
		<C>Col=ceo_eng_nm 		Ctrl=ceo_eng_nm 		Param=value </C>
		<C>Col=zip_cd 			Ctrl=zip_cd 			Param=Text </C>
		<C>Col=address1 		Ctrl=address1 			Param=value </C>
		<C>Col=address2 		Ctrl=address2 			Param=value </C>
		<C>Col=address_eng 		Ctrl=address_eng 		Param=value </C>
		<C>Col=tel_no1 			Ctrl=tel_no1 			Param=value </C>
		<C>Col=tel_no2 			Ctrl=tel_no2 			Param=value </C>
		<C>Col=tel_no3 			Ctrl=tel_no3 			Param=value </C>
		<C>Col=fax_no1 			Ctrl=fax_no1 			Param=value </C>
		<C>Col=fax_no2 			Ctrl=fax_no2 			Param=value </C>
		<C>Col=fax_no3 			Ctrl=fax_no3 			Param=value </C>
		<C>Col=uptae 			Ctrl=uptae 				Param=value </C>
		<C>Col=jongmok 			Ctrl=jongmok 			Param=value </C>
		<C>Col=homepage 		Ctrl=homepage 			Param=value </C>
		<C>Col=e_mail 			Ctrl=e_mail 			Param=value </C>
		"     
	>	
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<input type="hidden" name="row" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

