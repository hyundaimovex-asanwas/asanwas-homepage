<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 -카드 팝업
+ 프로그램 ID	:  card_popup.jsp
+ 기 능 정 의	:  카드번호
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2009.12.09
-----------------------------------------------------------------------------
+ 수 정 내 용 :	우리은행 추가    
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2014.04.28
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>법인카드</title>

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

var g_cdcodenam="";
var g_gbcd="";
var g_cmtype="";
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
  gclx_cardcd.index=0;
	gcrd_gbcd.codevalue="";
	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_card_s3?v_str1="+fn_trim(gcrd_gbcd.codevalue)
	                                                          +"&v_str2="+fn_trim(gclx_cardcd.bindcolval)
															  +"&v_str3="+fn_trim(txt_cardno.value); 
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
		window.returnValue = gcds_code01.namevalue(row,"REAL_CARDNO"); 
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:438px;border:1 solid #708090">
	<tr>
		<td class="tab11" width="65px;" bgcolor="#eeeeee">카드구분</td>
		<td class="tab11" width="220px">
		  <comment id="__NSID__">
			<object id=gcrd_gbcd classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:24;width:210">
				<param name=Cols	value="3">
				<param name=Format	value="^전체,01^법인,02^개인법인">
			 </object>
		  </comment><script>__ws__(__NSID__);</script> 
		</td>
		<td class="tab11" width="65px;" bgcolor="#eeeeee">카드종류</td>
		<td class="tab11" width="80px;">
			<comment id="__NSID__">
				<object  id=gclx_cardcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:1px;font-size:12px;width:70px">
					<param name=CBData				value="^전체,001^현대,002^외환,003^농협,004^우리">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort				value="false">
					<param name=ListExprFormat	    value="CDNAM^0^70">
					<param name=BindColumn			value="CDCODE">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee">카드번호</td>
		<td width="255px" colspan=2>
			<input type="text" class="txt11" id="txt_cardno" style="position:relative;left:4px;width:280px;" onkeydown="if(event.keyCode==13) ln_Query();">
		</td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;position:relative;left:32px;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:438;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=GUBUN,		    Name=카드구분,  width=110,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     sort = true</C>
					<C>ID=CARDNM,	      Name=카드종류,  width=110,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     sort = true</C>
					<C>ID=CARDNONM,		  Name=카드번호,  width=200,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   sort = true</C>
					<C>ID=REAL_CARDNO,	Name=카드번호,  width=200,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   sort = true  show=false</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:440;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

