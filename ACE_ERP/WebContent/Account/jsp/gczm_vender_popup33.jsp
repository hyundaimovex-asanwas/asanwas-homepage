<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  거래처코드 조회 팝업	
+ 프로그램 ID	:  Gczm_vender_poopup33.html
+ 기 능 정 의	:  거래처코드 조회 팝업	창
+ 작   성  자   :  정하나
+ 작 성 일 자   :  2009.06.18
--------------------------------------------------------------------------------
+ 수   정  자   :   정영식
+ 수 정 일 자   :  2017.05.23
+ 수 정 내 용   :  검색조건은 사업자번호로 통일
-----------------------------------------------------------------------------
+ 서 블 릿 명	:  Account.a010003_s77
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>거래처코드조회</title>


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
	gcra_useyn.codevalue ="T";
	gcra_regno_gb.codevalue="1";
	var strParam = new Array();
	strParam=window.dialogArguments;
}

/******************************************************************************
	Description : 거래처명/거래처코드/사업자등록번호/담당자명으로 조회가능
******************************************************************************/
function ln_Query2(){
		
	if(gcra_regno_gb.codevalue=="1"){
		
		if(gcem_vend_id.text.length!=10){
			alert("사업자번호가 10자리가 아닙니다. 모두 입력하십시요.");
			return false;
		}
	}else if(gcra_regno_gb.codevalue=="2"){
		if(gcem_vend_id.text.length!=13){
			alert("주민번호가  13자리가 아닙니다. 모두 입력하십시요.");
			return false;
		}
	}	
	
	gcds_code01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s77?v_str1="
			                                                                +"&v_str2="
			                                                                +"&v_str3="+gcem_vend_id.text
			                                                                +"&v_str4="
			                                                                +"&v_str5="+gcra_useyn.codevalue;                           
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
		window.returnValue = gcds_code01.namevalue(row,"SEQ")  + ";" 
						+ gcds_code01.namevalue(row,"VEND_CD")  + ";"
	                   	+ gcds_code01.namevalue(row,"VEND_NM")  + ";"
						+ gcds_code01.namevalue(row,"EMPNM") + ";"
						+ gcds_code01.namevalue(row,"DEPTNM") + ";"
						+ gcds_code01.namevalue(row,"EMAIL")  + ";"
						+ gcds_code01.namevalue(row,"HPNO")  + ";"
						+ gcds_code01.namevalue(row,"TELNO")  + ";"
						+ gcds_code01.namevalue(row,"USEGB")  + ";"
						+ gcds_code01.namevalue(row,"VEND_ID")+ ";"
						+ gcds_code01.namevalue(row,"BSNS_CND")  + ";"
						+ gcds_code01.namevalue(row,"BSNS_KND")  + ";"
						+ gcds_code01.namevalue(row,"ADDRESS1")  + ";"
						+ gcds_code01.namevalue(row,"ADDRESS2")  + ";"
						+ gcds_code01.namevalue(row,"VD_DIRECT") + ";"
						+ gcds_code01.namevalue(row,"ORI_VEND_I")+ ";"
						+ gcds_code01.namevalue(row,"VEND_ID_LEN")+ ";"
						+ gcds_code01.namevalue(row,"COCOMYN");		
						window.close();
	} else {
		window.close();
	}
}


<%
/******************************************************************************
	Description : 채권가압류 
	parameter   : 
******************************************************************************/
%>
function  ln_Credgb_Alert(){
    var row = gcds_code01.rowposition;
	if(gcds_code01.namevalue(row,"CREDGB")=="1"||gcds_code01.namevalue(row,"CREDGB")=="2"){
		alert("[채권(가)압류] 업체입니다. \n\n업무시 참고 바랍니다.");
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

<script language=JavaScript for=gcra_regno_gb event=OnSelChange()>
	if(gcra_regno_gb.codevalue=="1"){
		gcem_vend_id.format ="000-00-00000";
	}else if(gcra_regno_gb.codevalue=="2"){	
		gcem_vend_id.format ="000000-0000000";
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
    ln_Credgb_Alert();
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

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:685px;border:0 solid #708090">
	<tr>
		<td class="tab37" width="80px;" bgcolor="#eeeeee" align="center" >등록번호</td>
		

		<td class="tab14" width="350px" align=left >
			<comment id="__NSID__">
			
			<object id=gcra_regno_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:180px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	value="1^사업자번호,2^주민번호">
			</object>
			
			<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px" onkeydown="if(event.keyCode==13) ln_Query2();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format          value="000-00-00000">
				<param name=PromptChar	    value="_">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">사용유무</td>
		<td width="90px" class="tab14" align=CENTER>
			<comment id="__NSID__">
			<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:155px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	value="T^사용,F^미사용">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		
		<td class="tab24" height="25px" width="155px" align="right" ><img src="../../Common/img/btn/com_b_find.gif" alt="거래처코드를 검색합니다" style="position:relative;left:0px;top:0px;cursor:hand;" onclick="ln_Query2()"></td>
	</tr>  
	<!-- 
    <tr>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">담당자명</td>
		<td width="175px" class="tab11"><comment id="__NSID__">
			<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:165px" onkeydown="if(event.keyCode==13) ln_Query2();">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit value="true">
				<param name=PromptChar	value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">사업자번호</td>
		<td width="90px" class="tab11" ><comment id="__NSID__">
			<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" onkeydown="if(event.keyCode==13) ln_Query2();">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit value="true">
				<param name=PromptChar	value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" >&nbsp;
			<comment id="__NSID__">
			<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:155px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	value="T^사용,F^미사용">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td> 	

	</tr>
	-->
</table>
 <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:680;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle"     VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
			  <PARAM NAME="ColSizing"		VALUE="true">
			  <param name="sortview"        value=left>
			  <PARAM NAME="Format"			VALUE="  
					<FC>ID=SEQ,		     Name=순번,		    width=40,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true show = false </FC>
					<FC>ID=VEND_CD,		 Name=거래처코드,		width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true Color={Decode(CREDGB,1,'red',2,'red','black')} </FC>
					<FC>ID=VEND_NM,		 Name=거래처명,		width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true Color={Decode(CREDGB,1,'red',2,'red','black')} </FC>
					<FC>ID=VEND_ID,		 Name='사업자번호',	width=120,	HeadBgColor=#B9D4DC, align=center,    edit=none,    sort = true,Color={Decode(CREDGB,1,'red',2,'red','black')}    mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')} </FC>
					<FC>ID=EMPNM,		 Name=담당자명,		width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true </FC>
					<C>ID=EMAIL,		 Name=E-mail,		width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true </C>
					<C>ID=DEPTNM,		 Name=담당자부서명,	width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true </C>
					<C>ID=HPNO,			 Name=전화번호1,		width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true </C>
					<C>ID=TELNO,		 Name=전화번호2,		width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true </C>
					<C>ID=USEGB,		 Name=사용구분,		width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true </C>
					<C>ID=COCOMYN,		 Name=업체구분,		width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true Color={Decode(CREDGB,1,'red',2,'red','black')}  show = true EditStyle=Combo Data='N:일반업체,Y:협력업체,S:특수관계업체,T:간이과세업체,M:면세업체'</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:685;height:20px;border:0 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
	
	
	<tr>
     	<td height="30px;" > * 경영관리팀 요청으로 검색 조건 변경합니다. ( 문의 : 박준용DR 3842 ) </td>
     </tr>
	
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 