<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 자산명관리
+ 프로그램 ID	: A010011.html
+ 기 능 정 의	: 자산명관리
+ 최 초 이 력	: 정영식
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ 수 정 내 용  :	
+ 수   정  자  :  
+ 수 정 일 자  :  
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A010011_s1, A010011_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title></title>

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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

  /*
	if(gf_empno_Enable(gs_userid,gcds_userid2)){
			sp0.style.display = "";
		}else{
		sp0.style.display = "none"; //숨김
	}

    gcra_useyn.codevalue ="T";	

	txt_vend_cd.value  = "" ;
	txt_vend_nm.value  = "" ;
	gcem_vend_id2.text	= "" ;
	txt_empnm.value	= "" ;	
	txt_email.value	= "" ;	
	txt_deptnm.value = "" ;	
	txt_hpno.value	= "" ;	
	txt_telno.value	= "" ;	
	gcem_dsudt.text = "" ;	
	gcra_usegb.CodeValue = "" ; 
	txt_bsns_cnd.value	= "" ;	
	txt_bsns_knd.value = "" ;	
	*/

	ln_Before();
	gcra_astuseyn00.codevalue="T";
	gcra_astuseyn.codevalue="T";

  if(gs_userid=="6070001"){
		sp0.style.display = "";
	}else{
		sp0.style.display = "none"; //숨김
	}									
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcds_ast2nd00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101"; 
	gcds_ast2nd00.Reset();

    gcds_ast2nd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101"; 
	gcds_ast2nd.Reset();
}

/******************************************************************************
	Description : 소분류 조회 [검색]
******************************************************************************/
function ln_Small_Query00(strparam){
	gcds_ast3rd00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2="+strparam;  
	gcds_ast3rd00.Reset();
}


/******************************************************************************
	Description : 소분류 조회 [입력]
******************************************************************************/
function ln_Small_Query(strparam){
	gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2="+strparam;  
	gcds_ast3rd.Reset();
}



/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010011_s2?v_str1="+gclx_ast2nd00.bindcolval
											                           	+"&v_str2="+gclx_ast3rd00.bindcolval
																		+"&v_str3="+gcem_astnm00.text
											                            +"&v_str4="+gcra_astuseyn00.codevalue; 
 	//prompt('',gcds_data.DataID);																												
	gcds_data.Reset();

}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	ln_SetDataHeader();
  gcds_data.addrow();	
 	gcds_data.namevalue(gcds_data.rowposition,"ASTUSEYN")="T";
}


/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if(!ln_Chk_Save())return;

	if(gcds_data.IsUpdated){
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010011_t2";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_data.post();
		}
	}
}

/******************************************************************************************
	Descrition : 로그인시 해당사번만 삭제 가능함.
	parameter  : 사번코드
	retun      : true - 가능 , false - 불가능
	             gcds_name - dataset 명
******************************************************************************************/
function gf_empno_Enable(s, gcds_name){
 /*
	gcds_name.DataID = g_servlet+"/Account.commdtil_s5?v_str1=2169"
													  +"&v_str2="+s;
	                                                  

  //prompt("",gcds_name.DataID );																							
	gcds_name.Reset();			

	if(gcds_name.countrow>0){
		return true;
  }else { 
		return false;
	}
	*/
}


/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
  
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){ 
			if(gcds_data.namevalue(i,"AST2ND") == ""){ 
				alert("중분류를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"ASTNM") == ""){ 
				alert("자산명을 입력하세요.");
				return false;
			}
			if(gcds_data.namevalue(i,"ASTUSEDT") == ""){ 
				alert("사용일자를 입력하세요.");
				return false;
			}

			if(gcds_data.namevalue(i,"ASTUSEYN") == ""){ 
				alert("사용유무를 입력하세요.");
				return false;
			}


			if(gcds_data.namevalue(i,"AST3RD")==""){
				gcds_data.namevalue(i,"AST3RD")="00";
			}
		}
	} 
	return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
  /*
	gcds_data.undo(gcds_data.rowposition);
	*/
}
/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
  
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data.KeyValue = "Account.A010011_t2(I:USER=gcds_data)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010011_t2";
		gctr_data.post();
		return ln_Query();
	}	else {
	  gcds_data.undo(gcds_data.rowposition);
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : 문자열체크
******************************************************************************/
function ln_email(src){
  /*
	var src;
	for (j=0;j<src.length;j++){
	//  alert("::j::::"+j);
		if(src.charAt(j) =="@"){
			return true;		
		}
	}  
	
	return false;
	*/
} 


/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Find2(){
 /*
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

  //

	if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
    alert("신규 등록시에만 찾기 버튼 사용기 가능합니다.");
		return;
	}
	//if(gcds_data.countrow >0&& gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")<>""&&gcds_data.namevalue(gcds_data.rowposition."VEND_NM")<>""){
   // alert("신규등록시에서 찾기 버튼 사용기 가능합니다.");
	//	return;
//	}


	strURL = "../../Account/html/A010047_popup.html";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
//alert("result::"+arrParam);
	 	txt_vend_nm.value = arrParam[1];
		txt_vend_cd.value = arrParam[0];
		gcem_vend_id2.text = arrParam[2];
		txt_bsns_cnd.value = arrParam[3];
		txt_bsns_knd.value = arrParam[4];
	} else {
		txt_vend_nm.value = "";
		txt_vend_cd.value = "";
		gcem_vend_id2.text = "";
		txt_bsns_cnd.value = "";
		txt_bsns_knd.value = "";
	} //거래처 찾기

	*/
}



/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){

}


/******************************************************************************
	Description : Dataset Head 설정 -  
******************************************************************************/
function ln_SetDataHeader(){
  
	if(gcds_data.countrow<1){
		var THeader = "AST2ND:STRING(2),AST2NDNM(60),AST3RD:STRING(2),AST3RDNM:STRING(60),"
								+ "ASTCD:STRING(5),ASTNM:STRING(60),ASTUSEDT:STRING(8),ASTCLSDT:STRING(8),ASTUSEYN:STRING(1),"
								+ "I_EMPNO:STRING(7),U_EMPNO:STRING(7)";
		gcds_data.SetDataHeader(THeader);							
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- 조회 -->
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 검색조건 : 자산중분류 -->
<object id=gcds_ast2nd00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 검색조건 : 자산소분류 -->
<object id=gcds_ast3rd00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 입력 : 자산중분류 -->
<object id=gcds_ast2nd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 입력 : 자산소분류 -->
<object id=gcds_ast3rd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-- 로그인 사번 체크  -->
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010011_t2(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
//		ln_Query();
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
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


<script language=JavaScript for=gclx_ast2nd event=OnSelChange()>
  //자산소분류[검색]
	if(gclx_ast2nd.BindColVal=='14'){
	  ln_Small_Query('14');
	}else if(gclx_ast2nd.BindColVal=='16'){
		ln_Small_Query('16');
	}else{	
		ln_Small_Query('00');
	}	
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010011_head.gif"></td>
    <td width="685" align="right" background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif" style="padding-top:4px;">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"    style="cursor:hand" onclick="ln_Cancel()">
			<span id=sp0 style="display:none;">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"    style="cursor:hand" onclick="ln_Delete()"> 
			</span>
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab32" width="100px;" height="30px" bgcolor="#eeeeee" align="center">자산중분류</td>
			<td class="tab35" width="130px" align="left">
				<comment id="__NSID__">
				<OBJECT id=gclx_ast2nd00 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:2px;top:0px;font-size:12px;width:110px;">
					<param name=ComboDataID			value="gcds_ast2nd00">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort						value=false>
					<param name=ListExprFormat	value="CDNAM^0^110">
					<param name=BindColumn			value="CDCODE">
					<param name=XPStyle         value=true>
				</OBJECT></comment><script>__ws__(__NSID__);</script> 				
			</td>
			<td class="tab35" width="100px;"  bgcolor="#eeeeee" align="center">자산소분류</td>
			<td class="tab35" width="130px"  align="left" >
				<comment id="__NSID__">
				<OBJECT id=gclx_ast3rd00 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:2px;top:0px;font-size:12px;width:110px;border-right-width:0px;right:0px;">
					<param name=ComboDataID			value="gcds_ast3rd00">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort						value=false>
					<param name=ListExprFormat	value="CDNAM^0^110">
					<param name=BindColumn			value="CDCODE">
					<param name=XPStyle         value=true>
				</OBJECT></comment><script>__ws__(__NSID__);</script> 		
			</td>
			<td class="tab35" width="100px;" bgcolor="#eeeeee" align="center">자산명</td>
		  <td class="tab35" >
			  <comment id="__NSID__">
				<object  id=gcem_astnm00 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:2px;width:200px" >
					<param name=Text		  value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=PromptChar    value="">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=UpperFlag     value=1>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		<tr> 
		<td class="tab25" width="100px;" height="30px" bgcolor="#eeeeee" align="center">사용유무</td>
		<td class="tab26" colspan=5>
			<comment id="__NSID__">
			<object id=gcra_astuseyn00 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:175px;height:20px" >
				<param name=Cols		value="3">
				<param name=Format	value="T^사용,F^미사용,^전체">
			</object></comment><script>__ws__(__NSID__);</script>
		</td> 	 
		</tr> 
	</table>
  </td>
	</tr>
	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:633px;HEIGHT:397px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle" VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="true">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="sortview"   value=left>
					     <PARAM NAME="Format"		VALUE="    
							<C>ID=AST2NDNM,	 Name=중분류,		  width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true </C>
							<C>ID=AST3RDNM,	 Name=소분류,	  	width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true </C>
							<C>ID=ASTCD,	   Name=자산코드,		width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true </C>
							<C>ID=ASTNM,  	 Name=자산명,		  width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true </C>
							<C>ID=ASTUSEDT,	 Name=사용일자,		width=75,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true  mask='XXXX-XX-XX' </C>
							<C>ID=ASTCLSDT,  Name=폐기일자,		width=75,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true  mask='XXXX-XX-XX' </C>
							<C>ID=ASTUSEYN,	 Name=사용유무,	  width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  EditStyle=Combo	Data='T:사용,F:미사용' </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--입력창 -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:230px;height:400px;border:1 solid #708090;">
				<tr>
					<td style="width:80px;height:30px;" bgcolor="#eeeeee" align=center class="tab19" ><nobr>&nbsp;중분류</nobr></td>               
					<td Style="width:150px;height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>
						<comment id="__NSID__">
							<OBJECT id=gclx_ast2nd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69	style="position:relative;left:2px;top:2px;font-size:12px;width:130px;">
									<param name=ComboDataID			value="gcds_ast2nd">
									<param name=CBDataColumns		value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="CDNAM^0^135">
									<param name=BindColumn			value="CDCODE">
									<param name=XPStyle         value=true>
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td width="100px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>소분류</nobr></td>
					<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>
						<comment id="__NSID__">
						<OBJECT id=gclx_ast3rd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:2px;top:2px;font-size:12px;width:130px;">
							<param name=ComboDataID			value="gcds_ast3rd">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="CDNAM^0^135">
							<param name=BindColumn			value="CDCODE">
							<param name=XPStyle         value=true>
						</OBJECT>
						</comment><script>__ws__(__NSID__);</script></nobr> 
					</td>
				</tr>
				<tr>
					<td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>자산코드</nobr></td>
					<td height="30px" class="tab22" style="text-align:left"><nobr>
						<comment id="__NSID__">
						<object  id=gcem_astcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:2px;width:50px" >
							<param name=Text		  value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=PromptChar    value="_">
							<param name=Format        value="#####">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=ReadOnly      value="true">
              <param name=ReadOnlyBackColor   value="#ccffcc">
						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
				</tr>
				<tr>
				  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>자산명</nobr></td>
			    <td height="30px" class="tab22" style="text-align:left"><nobr>
						<comment id="__NSID__">
						<object  id=gcem_astnm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:2px;width:130px" >
							<param name=Text		  value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=PromptChar    value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=UpperFlag     value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사용일자</nobr></td>
					<td height="30px" class="tab22" style="text-align:left"><nobr>
						<comment id="__NSID__">
						<object  id=gcem_astusedt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:3px;left:2px;width:70px;height:20px;">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_astusedt OnClick="__GetCallCalendar('gcem_astusedt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
						</nobr>
					</td>
				</tr>
				
				<tr>
					<td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>폐기일자</nobr></td>
					<td height="30px" class="tab22" style="text-align:left"><nobr>
						<comment id="__NSID__">
						<object  id=gcem_astclsdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:3px;left:2px;width:70px;height:20px;">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_astclsdt OnClick="__GetCallCalendar('gcem_astclsdt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사용유무</nobr></td>
					<td height="30px" class="tab22" style="text-align:left">&nbsp;
						<comment id="__NSID__">
						<object id=gcra_astuseyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
							<param name=Cols	value="2">
							<param name=Format	value="T^사용,F^미사용">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td> 
				</tr>
				<tr>
						<td class="tab23" align=center colspan=2 ></td>
				</tr>
			  </table>
		 </td>
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=AST2ND,	  Ctrl=gclx_ast2nd    Param=bindcolval		</C>  
		<C>Col=AST3RD,	  Ctrl=gclx_ast3rd	  Param=bindcolval	  </C>	
		<C>Col=ASTCD,	    Ctrl=gcem_astcd	    Param=text		    	</C>	
		<C>Col=ASTNM,	    Ctrl=gcem_astnm		  Param=text			    </C>	
		<C>Col=ASTUSEDT,  Ctrl=gcem_astusedt	Param=text			    </C>	
		<C>Col=ASTCLSDT,  Ctrl=gcem_astclsdt	Param=text			    </C>	
		<C>Col=ASTUSEYN,	Ctrl=gcra_astuseyn  Param=codevalue     </C>	
	'>
</object></comment><script>__ws__(__NSID__);</script>



<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



