<%@ page language="java" contentType="text/html;charset=euc-kr" %>

  <!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 가전표관리항목()	
+ 프로그램 ID	:  Slipref_popup.html
+ 기 능 정 의	:  관리항목 팝업창
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2005.11.08
-----------------------------------------------------------------------------
+ 수 정 내 용 :	   
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>관리항목조회</title>

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
var gs_strGubun="";
get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	var strParam = new Array();
	strParam=window.dialogArguments;

	if(strParam.length==0){

	}else if(strParam.length==1){
		gs_strGubun = strParam[0];

		if (gs_strGubun == ""){
			ln_Query("02");
		}else{
			ln_Query("01"); //표준
		}

	}

	
}

/******************************************************************************
	Description : 조회
	Parameter   : p - '01' Commdtil에서 가져옴
	                  그외 각 해당 테이블에서 가져옴
******************************************************************************/
function ln_Query(p){

	if (p=="01"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>slipref_s1?v_str1="+gs_strGubun+"&v_str2="+txt_cmtype.value+"&v_str3="+txt_cmnam.value; 
	}else{


	}

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
		window.returnValue = gcds_code01.namevalue(row,"CDCODE") + ";" 
	                   	 + gcds_code01.namevalue(row,"CDNAM");
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
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:478px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee" align=center>코드</td>
		<td width="55px"><input type="text" class="txt11" id="txt_cmtype" style="width:40px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td class="tab16" width="80px;" bgcolor="#eeeeee" align=center>코드명</td>
		<td width="110px"><input type="text" class="txt11" id="txt_cmnam" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="분류코드를 검색합니다" style="position:relative;left:92px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:477;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=CDCODE,		Name=코드,	width=71,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=CDNAM,		Name=코드명,		width=185,  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true</C>
					<C>ID=DSUDT,		Name=폐기일자,	width=75,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=CMREMARK,	Name=비고,	    width=130,  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:479;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 