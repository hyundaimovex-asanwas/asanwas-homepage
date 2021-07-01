<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	기초자료등록
+ 프로그램 ID	: AC01070.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: AC01070_S01,AC01070_S11,AC01070_T01
------------------------------------------------------------------------------>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/css/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/js/PubFun.js"></script>

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
  var gs_date = gn_Replace(gcurdate,"/");

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
		fnInit();               //초기화 함수
	}

	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function fnInit(){
		//*****  페이지 초기화 함수는 여기에..  ********
		cfStyleGrid(getObjectFirst("gr1"), "comn");	//그리드에 스타일 적용하는 부분. 1줄="comn";2줄="comn1"
		window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //브라우저 상태창 수정.
		//window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		//window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query() {

	}

	/******************************************************************************
		Description : 추가
	******************************************************************************/
	function ln_Add(){
	  gcds_data.addrow();

	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
		ln_Query();
	}

	/******************************************************************************
		Description : 삭제
	******************************************************************************/
	function ln_Delete(){

	}

	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
	}

	/******************************************************************************
		Description : 부서정보
	******************************************************************************/
	function ln_SrhBuse(){

	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

	}
	
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- master data -->
<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="false"></object>
<!--값체크-->
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	gn_LoadComp('1',gcds_data.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert(gn_Msg(1));
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gn_Msg(2));
</script>


</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
 		  <img src="../../Sales/images/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
			<img src="../../Sales/images/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()">
			<img src="../../Sales/images/com_b_save.gif"		style="cursor:hand"	onclick="ln_Save()">
			<img src="../../Sales/images/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
<!-- 			<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">11
			<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRow1()" >
			<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRow1()" >														
			<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()"> -->&nbsp;
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">국적구분</td>
					<td class="tab_b0100" style='width:180px'>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0100">고객명</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
					<td class="tab_a0100">주민/여권번호</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <!-- <td colspan=2>  -->
    <td>
      <table width="395" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:385px;height:430px;" viewastext>
							<param name="DataID"				value="gcds_data">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='성명'		  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='주민/여권번호'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='국적'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='성별'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='국적명'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='민족명'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='영문이름'	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='자택'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='핸드폰'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:386px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:482px;'>
		    <tr>
				  <td class="tab_b0100" style='width:100px;' rowspan=4>사진</td>
					<td class="tab_a0101">국적구분</td>
					<td class="tab_b0001" colspan=3>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">입출국증번호</td>
					<td class="tab_b0001" colspan=3>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">한글성명</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0101">주민/여권번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0100">생년월일</td>
					<td class="tab_b0000" colspan=3>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
			</table><BR>		
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:482px;'>
		    <tr>
					<td class="tab_a0101">성별</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0101">고객구분</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">사업구분</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>		
					<td class="tab_a0101">고객유형</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>						
				</tr>
		    <tr>
				  <td class="tab_a0101">영문성</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;					
						<font size='-1' face='돋움'><b>반입일</b></font>
					</td>		
					<td class="tab_a0101">영문이름</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">우편번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;			
					</td>		
					<td class="tab_a0101">직군</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">주소1</td>
					<td class="tab_b0001" colspan=3>
						<comment id="__NSID__"><object id=gcra_ classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
								<param name=Cols     value="3">
								<param name=CodeValue  value="0">
								<param name=Format   value="0^장기,1^단기">
						</object></comment><script>__ws__(__NSID__);</script>					
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">주소2</td>
					<td class="tab_b0001" colspan=3>
						<comment id="__NSID__"><object id=gcra_ classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
								<param name=Cols     value="3">
								<param name=CodeValue  value="0">
								<param name=Format   value="0^장기,1^단기">
						</object></comment><script>__ws__(__NSID__);</script>					
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">자택전화</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
						
					</td>		
					<td class="tab_a0101">핸드폰</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">직장명</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
						
					</td>		
					<td class="tab_a0101">직위</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">국적</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
						
					</td>		
					<td class="tab_a0101">민족</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">대리점</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
						
					</td>		
					<td class="tab_a0101">관광방문횟수</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">파견회사</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
						
					</td>		
					<td class="tab_a0101">소속팀</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0100">부임일</td>
					<td class="tab_b0000" colspan=3>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
					</td>		
				</tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

</body>
</html>