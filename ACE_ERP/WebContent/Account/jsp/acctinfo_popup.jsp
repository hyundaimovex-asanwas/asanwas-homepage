<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 계좌정보관리	
+ 프로그램 ID	:  acctinfo_poopup.jsp
+ 기 능 정 의	:  계좌정보관리 팝업
+ 작   성  자      :  정  영  식
+ 작 성 일 자     :  2016.10.19
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
<title>계좌정보관리 팝업</title>
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
var gs_strGubun =""; //전표유무
var g_param;         //거래처코드,명,사업자등록번호
var g_strcomgb="" ;   //업체구분


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
   gcra_useyn.codevalue ="T";

	var strParam = new Array();
	strParam=window.dialogArguments;

	if(strParam[0]=="0020"){
        g_param = strParam[1];
		if(g_param!=""){
		    gcem_vendnm.text=g_param;
			ln_Query2();
		}
    }else if(strParam[0]=="VAT"){ //매입매출 등록의 거래처
		g_strcomgb="T"; //매입매출에서는 간이과세업체는 조회 되지 않게 함. 2009.04.23
    }else{
    
		if(strParam.length==0){

		}else if(strParam.length==1){
			gs_strGubun = strParam[0];
			ln_Query2();
		}else if(strParam.length==2) {
			gs_strGubun = strParam[0];
			gcem_vendnm.text=strParam[1];
			if(gcem_vendnm.text==""){
			}else{
				ln_Query2();
			}
		}
  }
	//계정구분
	//gcds_comcode01.DataID =  g_servlet+"/Account.vendcode_s1?v_str1=";
	//gcds_comcode01.Reset();

	
}

/******************************************************************************
	Description : 조회
******************************************************************************/


<%
/******************************************************************************
	Description : 전표에서만 조회함. 거래처명/거래처코드/사업자등록번호로 조회가능
******************************************************************************/
%>
function ln_Query(){
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>acctinfo_popup_s1?v_str1="+gcem_acctinfo.text+"&v_str2="+gcra_useyn.codevalue;                           
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

<%
/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
%>
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"ACCTCD")  + ";" 
                           + gcds_code01.namevalue(row,"ACCTNO") ; 			
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

<comment id="__NSID__"><object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_comcode01" event="onloadCompleted(row,colid)">
	gcds_comcode01.insertrow(1);
	gcds_comcode01.namevalue(1,"VEND_CD") = "";
	gcds_comcode01.namevalue(1,"VEND_NM") = "전체";
	gcds_comcode01.index=0;
</script>

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
		<td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">검색조건</td>
		<td width="165px" style="border:0 solid #708090;height:25px"><comment id="__NSID__">
			<object  id=gcem_acctinfo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:160px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit     value="true">
				<param name=PromptChar	    value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td colspan =2 >&nbsp;
			<comment id="__NSID__">
			<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:0px;top:2px;width:170px;height:20px;">
				<param name=Cols	value="3">
				<param name=Format	value="T^사용,F^미사용,^전체">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td> 
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="계좌정보를 검색합니다" style="position:relative;left:0px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
	
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle"     VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
			  <PARAM NAME="ColSizing"		VALUE="true">
			  <param name="sortview"        value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=ACCTCD,		 Name=계좌코드,       width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true   </C>
					<C>ID=ACCTNO,		 Name=계좌번호,		width=200,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort=true   </C>
					<C>ID=ACCTREMARK,	 Name=적요,	        width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true   </C>
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