<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 자산명	
+ 프로그램 ID	:  Astname_popup.html
+ 기 능 정 의	:  자산명 팝업창
+ 작   성  자 :  정영식
+ 작 성 일 자 :  2010.06.24
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>  
<title>자산명조회</title>
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
var parentGubun="";
var gs_strGubun ="";
var gs_Gubun="";//관리부서(A) 현업부서(B) 구분
var gs_Divcd="";//  본부
var gs_Fdcode="";//  지점
//get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
 	var strParam = new Array();

  ln_Before();

	strParam=window.dialogArguments;

	gclx_ast2nd00.bindcolval = strParam[0];
	gclx_ast3rd00.bindcolval = strParam[1];	
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	gcds_ast2nd00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101"; 
	gcds_ast2nd00.Reset();

}

/******************************************************************************
	Description : 소분류 조회 [검색]
******************************************************************************/
function ln_Small_Query00(strparam){
	gcds_ast3rd00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2="+strparam;  
	gcds_ast3rd00.Reset();
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_code.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010011_s2?v_str1="+gclx_ast2nd00.bindcolval
	                                                      +"&v_str2="+gclx_ast3rd00.bindcolval
																												+"&v_str3="+gcem_astnm00.text
	                                                      +"&v_str4=T"; 
	gcds_code.Reset();
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
		var row = gcds_code.rowposition;
		window.returnValue = gcds_code.namevalue(row,"ASTCD") + ";"
											 + gcds_code.namevalue(row,"ASTNM"); 
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_code classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 검색조건 : 자산중분류 -->
<object id=gcds_ast2nd00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 검색조건 : 자산소분류 -->
<object id=gcds_ast3rd00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_code" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	////document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	////document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code.countrow <=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language=JavaScript  for=gcds_ast2nd00 event=OnLoadCompleted(rowcount)>
	gcds_ast2nd00.InsertRow(1);
	gcds_ast2nd00.NameValue(1,"CDCODE")="";
	gcds_ast2nd00.NameValue(1,"CDNAM")="전체";
	gclx_ast2nd00.index=0;
</script>


<script language=JavaScript  for=gcds_ast3rd00 event=OnLoadCompleted(rowcount)>
	if(rowcount>1){
		gcds_ast3rd00.InsertRow(1);
		gcds_ast3rd00.NameValue(1,"CDCODE")="";
		gcds_ast3rd00.NameValue(1,"CDNAM")="전체";
		gclx_ast3rd00.index=0;
	}
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

<script language=JavaScript for=gclx_ast2nd00 event=OnSelChange()>
  //자산소분류[검색]
	if(gclx_ast2nd00.BindColVal=='14'){
	  ln_Small_Query00('14');
	}else if(gclx_ast2nd00.BindColVal=='16'){
		ln_Small_Query00('16');
	}else{	
		ln_Small_Query00('00');
	}	
</script>

<script language=JavaScript for=gcem_astnm00 event=onKeyDown(kcode,scode)>

   if (kcode ==13) ln_Query();

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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:578px;border:1 solid #708090">
	<tr>
    <td class="tab12" width="50px;" bgcolor="#eeeeee" align="center">중분류</td>
		<td width="110px">
			<comment id="__NSID__">
				<OBJECT id=gclx_ast2nd00 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:2px;top:0px;font-size:12px;width:105px;">
					<param name=ComboDataID			value="gcds_ast2nd00">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort						value=false>
					<param name=ListExprFormat	value="CDNAM^0^110">
					<param name=BindColumn			value="CDCODE">
					<param name=XPStyle         value=true>
					<param name=Enable          value="false">
				</OBJECT>
			</comment><script>__ws__(__NSID__);</script> 			
		</td>
    <td class="tab16" width="50px;" bgcolor="#eeeeee" align="center">소분류</td>
		<td width="110px">
			<comment id="__NSID__">
				<OBJECT id=gclx_ast3rd00 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:2px;top:0px;font-size:12px;width:105px;">
					<param name=ComboDataID			value="gcds_ast3rd00">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort						value=false>
					<param name=ListExprFormat	value="CDNAM^0^110">
					<param name=BindColumn			value="CDCODE">
					<param name=XPStyle         value=true>
					<param name=Enable          value="false">
				</OBJECT>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td class="tab16" width="50px;" bgcolor="#eeeeee" align="center">자산명</td>
		<td width="150px" >
			<comment id="__NSID__">
				<object  id=gcem_astnm00 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:2px;width:145px" >
					<param name=Text		     value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=PromptChar    value="">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=UpperFlag     value=1>
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="자산코드를 검색합니다" style="position:relative;left:2px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:576;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
				  <C>ID=AST2NDNM,		 Name=중분류,     width=120,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort=true</C>
					<C>ID=AST3RDNM,		 Name=소분류,     width=120,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort=true</C>
					<C>ID=ASTCD,		   Name=자산코드,   width=75,  	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true</C>
					<C>ID=ASTNM,		   Name=자산명,			width=240,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort=true</C>				
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:578;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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