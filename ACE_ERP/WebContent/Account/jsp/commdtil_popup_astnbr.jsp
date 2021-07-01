<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 자산번호팝업	
+ 프로그램 ID	:  Commdtil_popup_astnbr.html
+ 기 능 정 의	:  자산번호 팝업
+ 작   성  자  :  정 영 식
+ 작 성 일 자 :  2011.05.11
-----------------------------------------------------------------------------
+ 수 정 내 용 : 조회 조건에 신규등록, 신규등록 외 추가 	   
+ 수   정   자 : 정 영 식 
+ 수 정 일 자 : 2011.12.29
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>관리항목-자산번호</title>

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
get_cookdata();
var g_fdcode="";
var g_atcode="";
var g_cmtype="";
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam=window.dialogArguments;
    g_fdcode=strParam[1]; //지점
	g_atcode=strParam[2]; //계정코드 

    gcrd_gubun.codevalue="1";
	//ln_Query();
}



/******************************************************************************
	Description : 계정코드로 중분류 찾기
	Parameter   : 
******************************************************************************/
function ln_Find_Ast2nd(strAtcode){
  var strAst2nd ="";

 	if(strAtcode=="1220100"){
		strAst2nd="11";
	} else if(strAtcode=="1220200"){
		strAst2nd="12";
	} else if(strAtcode=="1220300"){
		strAst2nd="13";
  } else if(strAtcode=="1220600"){
		strAst2nd="14";
  } else if(strAtcode=="1220400"){
		strAst2nd="15";
	} else if(strAtcode=="1220700"){
		strAst2nd="16";
	} else if(strAtcode=="1222100"){
		strAst2nd="17";
	}

	return strAst2nd;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

    var strAst2nd = ln_Find_Ast2nd(g_atcode);

	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s6?v_str1="+g_fdcode+"&v_str2="+strAst2nd
	                                                                                                                                    +"&v_str3="+txt_cdcodenm.value+"&v_str4="+gcrd_gubun.codevalue; 
	//prompt("",gcds_code01.DataID);
	gcds_code01.Reset();
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
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"H_ASTNBR")+";"
		                   + gcds_code01.namevalue(row,"H_ASTNBR"); 
		window.close();
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>
<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:582px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee">자산명</td>
		<td width="255px"><input type="text" class="txt11" id="txt_cdcodenm" style="position:relative;left:4px;width:240px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td>
		<comment id="__NSID__">
			<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:24; width:200">
				<param name=Cols	value="2">
				<param name=Format	value="1^신규등록,2^신규등록 외">
			</object>
		</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:580;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=H_ASTNBR,		Name=대표자산번호,	width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  mask='XXX-XXXXX' </C>
					<C>ID=ASTNM,	          Name=자산명,        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    </C>
					<C>ID=COSTNM,		  Name=원가명,        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    </C>
					<C>ID=ASAQSDAT,		Name=취득일자,      width=65,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  mask='XXXX/XX/XX'</C>
					<C>ID=ASTAQAMT,		Name=취득금액,      width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,   </C>
					<C>ID=ASAQSDIVNM,	Name=취득구분,      width=50,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  </C>
					<C>ID=USERNM,		    Name=사용자,        width=50, 	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  </C>
					<C>ID=VEND_NM,		   Name=구입처,        width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    </C>
					<C>ID=ASTSTATNM,	   Name=상태,          width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    </C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:582;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 