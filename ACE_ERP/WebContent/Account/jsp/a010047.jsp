<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 거래처별담당자관리
+ 프로그램 ID	: a010047.jsp
+ 기 능 정 의	: 거래처별담당자관리
+ 최 초 이 력	: 정하나
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ 수 정 내 용  :	수정시점에 거래처 찾기 버튼 사용 금지
+ 수   정  자  :  정영식
+ 수 정 일 자  :  2009.10.09

+ 변 경 이 력	: 이동훈 2020.07.21 630번째 줄에 Format만 수정해줌
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010047_s1, a010047_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>


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

	if(gf_empno_Enable(gs_userid,gcds_userid2)){
			sp0.style.display = "";
		}else{
		sp0.style.display = "none"; //숨김
	}

    gcra_useyn.codevalue ="T";	
    gcra_usegb_0.codevalue="1"
    gclx_status_0.bindcolval="Y";

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
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_s1?v_str1="+gcem_vend_cd.text
			                                                            +"&v_str2="+gcem_vendnm.text
			                                                            +"&v_str3="+gcem_vend_id.text
			                                                            +"&v_str4="+gcem_empnm.text
			                                                            +"&v_str5="+gcra_useyn.codevalue
																		+"&v_str6="+gclx_status_0.bindcolval
																		+"&v_str7="+gcra_usegb_0.codevalue;
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	ln_SetDataHeader();
	gcds_data.addrow();	
	gcra_usegb.CodeValue="T";
	
	//결재 프로세스 없음. 
	//gclx_status.bindcolval ="N";
	gclx_status.bindcolval ="Y";
}


/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
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
	gcds_name.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s5?v_str1=2169"
													                    +"&v_str2="+s;	                                                 
  //prompt("",gcds_name.DataID );																							
	gcds_name.Reset();			

	if(gcds_name.countrow>0){
		return true;
  	}else { 
		return false;
	}
}


/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){

	//	alert("::i:"+i+"::gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i)); 

				if(gcds_data.namevalue(i,"VEND_CD") == ""){ //거래처				
					alert("거래처를 입력하세요.");
					return false;
				}
				if(gcds_data.namevalue(i,"VEND_ID") == ""){//사업자등록번호
					alert("사업자등록번호를 입력하세요.");
					return false;
				}
				if(gcds_data.namevalue(i,"EMPNM") == ""){ //담당자명				
					alert("담당자명을 입력하세요.");
					return false;
				}
				if(gcds_data.namevalue(i,"BSNS_CND") == "" || gcds_data.namevalue(i,"BSNS_KND") == "" ){ //업종, 업태				
					alert("업종 또는 업태를 업체 코드관리에서 먼저 입력해주세요 .");
					return false;
				}
				if(gcds_data.namevalue(i,"EMAIL") == "" ){ //EMAIL				
					alert("EMAIL을 입력하세요.");
					return false;
				}else{
					var aa = gcds_data.namevalue(i,"EMAIL");
					if(!ln_email(aa)){
					//	alert("result::"+result);  
						alert("EMAIL을 정확히 입력하세요.");
						return false;
					} 
				}
			}

	} return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}
/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.KeyValue = "Account.A010047_t1(I:USER=gcds_data)";
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t1";
		gctr_pyo.post();
		return ln_Query();
	}
	else gcds_data.undo(gcds_data.rowposition);
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

	var src;
	for (j=0;j<src.length;j++){
	//  alert("::j::::"+j);
		if(src.charAt(j) =="@"){
			return true;		
		}
	}  
	
	return false;
} 


/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Find2(){
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


	strURL = "../../Account/jsp/a010047_popup.jsp";
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
		var THeader = "CHK:String(1),SEQ:Decimal(2),VEND_CD:String(13),VEND_NM:String(62),VEND_ID:String(15),EMPNM:String(30),"
					+ "EMAIL:String(40),DEPTNM:String(30),HPNO:String(15),"
					+ "TELNO:String(15),ENDDT:String(8),USEGB:String(1),BSNS_CND:String(62),BSNS_KND:String(62),I_EMPNO:String(10),"
					+ "U_EMPNO:String(10),STATUS:String(1),VEND_ID_LEN:Decimal(2),SB_REASON:String(100)";
		gcds_data.SetDataHeader(THeader);		//Header Set
	}
}


<%
/******************************************************************************
Description : 승인요청
******************************************************************************/
%>
function ln_AppReq(){
    //상태값 체크 : 대기 반송 상태만 요청 가능함 
	if(!ln_Chk_Status("승인요청")) return false;
	
	if (confirm(" 해당 거래처 등록 승인 요청 하시겠습니까?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t2";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
	//	prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
	}else{
		gcds_data.UndoAll();
	}	
}

<%
/******************************************************************************
Description : 상태값 체크 
******************************************************************************/
%>
function ln_Chk_Status(strReq){
	var vcnt=0;
	
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.SysStatus(i)=="1"){
				alert("저장 후 "+strReq+" 하십시요.");
				return false;
			}
			vcnt+=1;	
		}
	}
	
	if (vcnt==0){
		alert("선택된 항목이 존재 하지 않습니다.");
		return false;
	}
	
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 "+strReq+" 대상 건이 아닙니다.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
		}
	}
	return true;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</object>
	
	<!-- 로그인 사번 체크  -->
	<object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
 	<object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
	</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
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

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id.Format = "000-00-00000";    //법인 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id.Format = "000000-0000000";  //개인 
	}
</script>

<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>
    var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }

	if(intChk==10){ //
		gcem_vend_id2.Format = "000-00-00000";    //법인 
	}else if(intChk==13){
		gcem_vend_id2.Format = "000000-0000000";  //개인 
	}
	
	gcem_vend_id2.text = gcds_data.namevalue(row,"VEND_ID");
	
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id2.Format = "000-00-00000";    //법인 
	}else if(intChk==13){
		gcem_vend_id2.Format = "000000-0000000";  //개인 
	}
	gcem_vend_id2.text = gcds_data.namevalue(row,"VEND_ID");

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
	    <td ><img src="../img/A010047_head.gif"></td>
	    <td width="685" align="right" background="../../Common/img/com_t_bg.gif"         style="padding-top:4px;">
				<!-- <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"   	 style="cursor:hand" onclick="ln_AppReq()">&nbsp;&nbsp; -->
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	     style="cursor:hand" onclick="ln_Add()" >
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"       style="cursor:hand" onclick="ln_Cancel()">
				<span id=sp0 style="display:none;">
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"   style="cursor:hand" onclick="ln_Delete()"> 
				</span>
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		 style="cursor:hand" onclick="ln_Save()">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		 style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
   </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15"  width="100px;" bgcolor="#eeeeee" align="center">거래처코드</td>
			<td class="tab18"  width="90px" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit			value="true">
				<param name=PromptChar			value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">거래처명</td>
			<td class="tab24" width="200px"  align="left" ><comment id="__NSID__">
				<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">상태</td>
			<td class="tab24" align="left" >
				<comment id="__NSID__">
					<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			     value="N^대기,R^승인요청,Y^완료,B^반송">
								<param name=CBDataColumns	     value="CODE,NAME">
								<param name=SearchColumn	     value=NAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat       value="NAME">								
								<param name=BindColumn		     value="CODE">
								<param name=Enable               value="false">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		<tr> 
		<td class="tab17" width="100px;" bgcolor="#eeeeee" align="center">사업자번호</td>
		<td class="tab11" width="230px" >
			<comment id="__NSID__">
			    <object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:130px;height:20px" >
					<param name=Cols		value="2">
					<param name=Format	value="1^사업자,2^주민">
			    </object>
			
				<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
					<param name=Text		  value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=Numeric       value=false>
					<param name=Format        value="###-##-#####">
					<param name=PromptChar    value="">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">담당자명</td>
		<td class="tab21" width="200px"  align="left" ><comment id="__NSID__">
			<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">구분</td>
		<td class="tab11" >&nbsp;
			<comment id="__NSID__">
			<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:175px;height:20px" >
				<param name=Cols	value="3">
				<param name=Format	value="T^사용,F^미사용,A^전체">
			</object></comment><script>__ws__(__NSID__);</script>
		</td> 	 
		</tr> 
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:592px;HEIGHT:397px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"		VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="true">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="Editable"     	value='true'>
						 <param name="sortview"     value=left>
					     <PARAM NAME="Format"		VALUE="  
							<FC>ID=CHK 	        Name='선택'          Width=28    HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </FC>
							<FC>ID=SEQ,		    Name=순번,			width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true show = false </FC>
							<FC>ID=VEND_CD,	    Name=거래처코드,		width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true</FC>
							<FC>ID=VEND_NM,	    Name=거래처명,		width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   edit=none, sort = true</FC>
							<FC>ID=VEND_ID,	    Name=사업자번호,		width=90,	HeadBgColor=#B9D4DC, align=center,   mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-*XXXXXX')} , edit=none, sort=true</FC>
							<FC>ID=EMPNM,		Name=담당자명,		width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </FC>
							<C> ID=EMAIL,		Name=E-mail,		width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=DEPTNM,	    Name=담당자부서명,	    width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=HPNO,		Name=핸드폰,		    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true show = true </C>
							<C> ID=TELNO,		Name=전화번호,		width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true show = true </C>
							<C> ID=ENDDT,		Name=폐기일자,		width=85,	HeadBgColor=#B9D4DC, align=center,   Mask='XXXX/XX/XX', edit=none, sort=true</C>
							<C> ID=BSNS_CND,	Name=업태,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=BSNS_KND,	Name=업종,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=USEGB		Name=사용구분,		width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, 	edit=none, sort = true, EditStyle=Combo, Data='T:사용,F:미사용', show = true </C>
							<C> ID=STATUS,	    Name=상태,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   edit=none, sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송',show = true </C>
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
					<td style="width:100px;height:25px;" bgcolor="#eeeeee" align=center class="tab19" rowspan="2" ><nobr>&nbsp;거래처(<font color="#ff0000">*</font>)</nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:180px;position:relative;left:-5px;top:0px"  ReadOnly >
					</td>
				</tr>
				<tr>
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:80px;position:relative;left:-5px;top:0px" maxlength="7"  ReadOnly>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="거래처를 검색합니다" style="position:relative;left:-8px;top:3px;cursor:hand;" onclick="ln_Find2()">						
					</td>
				</tr>
				<tr>
					<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사업자번호(<font color="#ff0000">*</font>)</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:1px;top:3px">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
				<!--  	<param name=Format        value="###-##-#####"> -->
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=readOnly      value=true>
					   </object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>담당자명(<font color="#ff0000">*</font>)</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_empnm"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
					</nobr></td>
				</tr>
					<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>전자우편(<font color="#ff0000">*</font>)</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
						<input id="txt_email"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:160px;height:20px;">
						</nobr></td>
					</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>부서명</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_deptnm"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>핸드폰</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_hpno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
						</nobr> 예)000-0000-0000 </td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>전화</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_telno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
						</nobr> 예)000-0000-0000 </td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>폐기일자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>&nbsp;<comment id="__NSID__">
							<object  id=gcem_dsudt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:3px;left:1px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_dsudt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
						</td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사용유무</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_usegb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
								<param name=Cols	value="2">
								<param name=Format	value="T^사용,F^미사용">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>업태</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_cnd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
						</nobr></td>

				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>업종</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_knd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
				
				<tr>
						<td class="tab19"  width="80px" height="25px" bgcolor="#eeeeee" align=center ><nobr>상태</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<comment id="__NSID__">
					 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
										<param name=CBData			     value="N^대기,R^승인요청,Y^완료,B^반송">
										<param name=CBDataColumns	     value="CODE,NAME">
										<param name=SearchColumn	     value=NAME>
										<param name=Sort			     value=false>
										<param name=ListExprFormat       value="NAME">								
										<param name=BindColumn		     value="CODE">
										<param name=Enable               value="false">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						</nobr></td>
				</tr>
				<tr>
						<td class="tab19"  width="80px" height="25px" bgcolor="#eeeeee" align=left><nobr>&nbsp;&nbsp;&nbsp;반송사유</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_sb_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
				
				<tr>
						<td height="25px"  align=center colspan=2 > <font color="#ff0000">*</font> 표시건은 필수 항목입니다.</td>
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

		<C>Col=VEND_CD,	    Ctrl=txt_vend_cd    Param=value			</C>
		<C>Col=VEND_NM,	    Ctrl=txt_vend_nm	Param=value			</C>
		<C>Col=VEND_ID,	    Ctrl=gcem_vend_id2	Param=text			</C>
		<C>Col=EMPNM,	    Ctrl=txt_empnm		Param=value			</C>
		<C>Col=EMAIL,	    Ctrl=txt_email		Param=value			</C>
		<C>Col=DEPTNM,		Ctrl=txt_deptnm		Param=value			</C>
		<C>Col=HPNO,		Ctrl=txt_hpno		Param=value			</C>
		<C>Col=TELNO,		Ctrl=txt_telno		Param=value			</C>
		<C>Col=ENDDT,		Ctrl=gcem_dsudt		Param=text			</C>
		<C>Col=BSNS_CND,	Ctrl=txt_bsns_cnd	Param=value			</C>
		<C>Col=BSNS_KND,	Ctrl=txt_bsns_knd	Param=value			</C>
		<C>Col=USEGB		Ctrl=gcra_usegb		Param=CodeValue		</C>
		<C>Col=STATUS		Ctrl=gclx_status	Param=bindcolval    </C>
		<C>Col=SB_REASON	Ctrl=txt_sb_reason	Param=value         </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



