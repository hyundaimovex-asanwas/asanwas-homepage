<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 인감관리 팝업 	
+ 프로그램 ID	:  hcdept_asnhr_popup.jsp
+ 기 능 정 의	:  부서코드 팝업창 ( 인사시스템 부서코드 기준 ) 
+ 작   성  자      :  JYS  
+ 작 성 일 자     :  2017.04.07
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	:  hcdept_asnhr_s1 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>부서코드조회</title>
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
var parentGubun="";
var gs_strGubun =""; //관리항목 구분코드 - 0002 (부서)
var gs_Gubun="";//관리부서(A) 현업부서(B) 구분
var gs_Divcd="";//본부
var gs_Fdcode="";//지점
var gs_yyyymm=""; //년월

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;

    if(strParam.length==1){
		gs_Fdcode = strParam[0];
    }
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_asnhr_s1?v_str1="+txt_deptcd.value
	                                                                           +"&v_str2="+txt_deptnm.value;
																		
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
		window.returnValue = gcds_code01.namevalue(row,"DEPTCD") + ";"   
	                   	   + gcds_code01.namevalue(row,"DEPTNMK"); 
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
    <td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">소속명</td>
		<td width="110px"><input type="text" class="txt11" id="txt_deptnm" style="position:relative;left:5px;width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="30"></td>

		<td class="tab16" width="70px;" bgcolor="#eeeeee" align="center">소속코드</td>
		<td width="60px"><input type="text" class="txt11" id="txt_deptcd" style="position:relative;left:5px;width:50px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="7"></td>
	
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="소속코드를 검색합니다" style="position:relative;left:116px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle"     VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
		      <param name="sortview"        value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=DEPTCD,	  	 Name=소속,      width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true</C>
					<C>ID=DEPTNMK,		 Name=소속명,	    width=280,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort=true</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:478;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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