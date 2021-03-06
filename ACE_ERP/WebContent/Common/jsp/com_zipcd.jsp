<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: COM_ZIPCD.HTML
+ 기 능 정 의	: 우편번호 검색
+ 변 경 이 력	: 
+ 서 블 릿 명	: h020002_s2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>우편번호 검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	if (txt_zip.value.length<1) {
		alert("조회를 원하시는 동을 입력해 주세요");
	} else {
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h020002_s2?"
									 + "v_str1=" + txt_zip.value;
        //prompt('',gcds_data.DataID);
		gcds_data.Reset();
	}
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(){
	window.close();
}

/******************************************************************************
	Description : 주소선택
******************************************************************************/
function ln_Ok(){
	if (gcds_data.countrow<1) {
		alert("선택하실 주소가 없습니다");
	} else {
		var row = gcds_data.rowposition;
		var pam1 = gcds_data.namevalue(row,"ZIPCD");	//우편번호
		var pam2 = gcds_data.namevalue(row,"SIDO");		//시,도
		var pam3 = gcds_data.namevalue(row,"GUGUN");	//구,군
		var pam4 = gcds_data.namevalue(row,"DONG");		//동
		var pam5 = gcds_data.namevalue(row,"BUNJI");	//번지

//		window.returnValue = pam1 + ";" + pam2 + " ;" + pam3 + " ;" + pam4 + ";" + pam5 + ";";
		window.returnValue = pam1 + ";" + pam2 + " ;" + pam3 + " ;" + pam4 + ";";
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onDblClick(row)">
	ln_Ok();
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellspacing="0" cellpadding="0" style="position:relative;left:5px;top:5px;width:620;border:1 solid #708090">
  <tr>
    <td class="tab12" width="100" bgcolor="#eeeeee">동이름</td>
		<td width="120px;"><input type=text id=txt_zip class="txt11" style="width:100px" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td width="400px"><img src="../img/btn/com_b_search.gif" style="position:relative;top:0px;left:0px;cursor:hand" onclick="ln_Query()"></td>
  </tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" style="position:relative;left:5px;top:10px;width:620;">
  <tr>
    <td colspan=3 align="left">
			<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
				style="height:299;width:618;border:1 solid #708090" id="gcgd_disp">
          <param name="DataID" 					value="gcds_data">
          <param name="fillarea" 				value="true">
          <param name="indwidth" 				value="0">
          <param name="BorderStyle"			value="0">
		      <param name="FontSize"     		value="9">
					<param name="sortview"				VALUE=left>
          <param name="Format" value='
            <F>id=ZIPCD,	name=우편번호,	width=60,	 	align=center,	headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF, Mask="XXX-XXX"</F>
            <C>id=SIDO,		name=시,				width=80,		align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF, sort = true</C>
						<C>id=GUGUN,	name=구군,			width=80,		align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF, sort = true</C>
						<C>id=DONG,		name=동,				width=200,	align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF</C>
						<C>id=BUNJI,	name=번지,			width=181,	align=left,		headBgcolor=#B9D4DC,	 sumbgcolor=#FFEFEF</C>
					'>
			</object>
    </td>
  </tr>
	<tr><td height="10px"></td></tr>
   <tr>
    <td colspan=3 align="center">
			<img src="../img/btn/com_b_select.gif" style="position:relative;top:0px;left:0px;cursor:hand" onclick="ln_Ok()">
			<img src="../img/btn/com_b_close.gif" style="position:relative;top:0px;left:0px;cursor:hand" onclick="ln_Close()">
    </td>
   </tr>
</table>


</body>
</html>