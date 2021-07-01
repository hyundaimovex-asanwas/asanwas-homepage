<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 인감관리	
+ 프로그램 ID	:  signet_id_popup.jsp
+ 기 능 정 의	:  인감ID 팝업
+ 작   성  자      :  JYS
+ 작 성 일 자     :  2017.05.17
-----------------------------------------------------------------------------
+ 서 블 릿 명	:  empno_asnhr_popup1.java
------------------------------------------------------------------------------>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>인감ID 조회</title>

<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var parentGubun="";
get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){


}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_s1?v_str1="+txt_nm.value
															            +"&v_str2=";
    gcds_data.Reset();
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
function ln_Close(e){
    var row= gcds_data.rowposition;

	if(e=="A"){
		window.returnValue = gcds_data.namevalue(row,"SIGNET_ID") + ";" 
		                   + gcds_data.namevalue(row,"SIGNET_GB") + ";"
		                   + gcds_data.namevalue(row,"SIGNET_HEAD_NO") + ";"
		                   + gcds_data.namevalue(row,"MGR_TEAMCD") + ";"
		                   + gcds_data.namevalue(row,"MGR_TEAMNM") ;
		window.close();
	}else{
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
	alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:572px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="50px;" bgcolor="#eeeeee">인감ID</td>
		<td width="120px">
			<input type="text" class="txt11" id="txt_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td width ="390" align="right" ><img src="../../Common/img/btn/com_b_find.gif" alt="인감ID를 검색합니다" style="position:relative;left:2px;top:1px;cursor:hand;"  onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:570;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle"     VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
			  <param name="sortview"        value=left>
			  <PARAM NAME="Format"			VALUE="  
				<C>ID=SIGNET_ID,		Name=인감ID,       width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
				<C>ID=SIGNET_GB,		Name=구분,         width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true EditStyle=Combo,  Data='1:법인인감,2:사용인감'</C>
				<C>ID=SIGNET_HEAD_NO,	Name=인감기준번호,	  width=100,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true</C>
				<C>ID=MGR_TEAMNM,,		Name=관리팀,	      width=150,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true</C>
				<G>Name='관리책임자'   HeadAlign=Center    HeadBgColor=#B9D4DC
				<C>ID=MAIN_EMPNMK,		Name=정,          width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
				<C>ID=SUB_EMPNMK,		Name=부,          width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
				</G>
			 ">
	    	</OBJECT>
	    	</comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:572;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close"  border="0" src="../../Common/img/btn/com_b_close.gif"  style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<!-- <iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 