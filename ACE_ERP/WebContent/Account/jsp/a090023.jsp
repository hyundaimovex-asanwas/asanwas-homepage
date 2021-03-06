<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 자산변경		
+ 프로그램 ID	:  A090003.html
+ 기 능 정 의	:  자산변경을 하는 화면이다
+ 작   성  자 :  이민정
+ 작 성 일 자 : 
-----------------------------------------------------------------------------
+ 수 정 내 용 :  자산변경 화면 전체적인 수정
+ 수   정  자 :  정영식  
+ 수 정 일 자 :  2009.10.16
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090003_s1, A090003_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>  
<title>자산변경</title>
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
get_cookdata();
var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);

var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	//지점코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//자산중분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";  
	gcds_asdivcod.Reset();

	div2.style.display = "";

	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_sys_fr.bindcolval ="";

	gcrd_gubun.codevalue ="1";

 }

/******************************************************************************
	Description : 조회
	              gcrd_gubun 구분값으로 토지 및 상각이전에 폐기, 매각, 자본적지출건을 조회가능
******************************************************************************/
function ln_Query(){
	
	var str1 = gclx_fdcode.BindColVal;            //지점
	var str2 = txt_COSTCD.value;									//원가코드
	var str3 = txt_jasan.value;										//자산명
	var str4 = gcem_jasan.text;										//자산코드
	var str5 = gclx_asdivcod.BindColVal;					//자산중분류
	var str6 = gclx_ascosdiv2_2.BindColVal;				//자산소분류
	var str7 = gclx_sys_fr.BindColVal;						//상태구분

  if(gcrd_gubun.codevalue=="1"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_s1_1?v_str1="+str1+"&v_str2="+str2
																														 + "&v_str3="+str3+"&v_str4="+str4
																														 + "&v_str5="+str5+"&v_str6="+str6
																														 + "&v_str7="+str7;
		//prompt("",gcds_code01.DataID )
		gcds_code01.Reset(); 
	}else if(gcrd_gubun.codevalue=="2"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_s1_2?v_str1="+str1+"&v_str2="+str2
																														 + "&v_str3="+str3+"&v_str4="+str4
																														 + "&v_str5="+str5+"&v_str6="+str6
																														 + "&v_str7="+str7;
		//prompt("",gcds_code01.DataID )
		gcds_code01.Reset(); 
	}

  gcds_code02.ClearAll();


}

/******************************************************************************
	Description : 자산변경 상세 조회
******************************************************************************/
function ln_Query2(row){

	var str1 = gcds_code01.namevalue(row,"FDCODE"); //지점
	var str2 = gcds_code01.namevalue(row,"ATCODE");	//계정
	var str3 = gcds_code01.namevalue(row,"AST1ST");	//제1구분
	var str4 = gcds_code01.namevalue(row,"AST2ND");	//제2구분
	var str5 = gcds_code01.namevalue(row,"AST3RD");	//제3구분
	var str6 = gcds_code01.namevalue(row,"ASTSEQ");	//일련번호

	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_s2?v_str1="+str1+"&v_str2="+str2
									                                       + "&v_str3="+str3+"&v_str4="+str4
									                                       + "&v_str5="+str5+"&v_str6="+str6;
	//prompt("",gcds_code02.DataID )
	gcds_code02.Reset(); 
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

  if(gcds_code01.rowposition<1) {
		alert("변경할 자산을 선택해 주십시요.");
		return false;
	}

	//자산상태가 매각 또는 폐기된 건은 더이상 등록 못하게 함.
	for(i=1;i<=gcds_code02.rowposition;i++){
		if(gcds_code02.namevalue(i,"CHGTYPE")=="1"){
			alert("매각 건은 더 이상 자산 변경할 수 없습니다.");
			return false;
		}

		if(gcds_code02.namevalue(i,"CHGTYPE")=="2"){
			alert("폐기건은 더 이상 자산 변경할 수 없습니다.");
			return false;
		}
	}

	gcds_code02.addrow();
  ln_Lx_Enable(gcds_code02.rowposition);
  gcds_code02.namevalue(gcds_code02.rowposition,"FDCODE")=gcds_code01.namevalue(gcds_code01.rowposition,"FDCODE");
	gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE")=gcds_code01.namevalue(gcds_code01.rowposition,"ATCODE");
	gcds_code02.namevalue(gcds_code02.rowposition,"AST1ST")=gcds_code01.namevalue(gcds_code01.rowposition,"AST1ST");
	gcds_code02.namevalue(gcds_code02.rowposition,"AST2ND")=gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND");
	gcds_code02.namevalue(gcds_code02.rowposition,"AST3RD")=gcds_code01.namevalue(gcds_code01.rowposition,"AST3RD");
	gcds_code02.namevalue(gcds_code02.rowposition,"ASTSEQ")=gcds_code01.namevalue(gcds_code01.rowposition,"ASTSEQ");

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if(!ln_Chk()) return;

	if (gcds_code02.IsUpdated ){
		if (confirm("저장하시겠습니까 ?")) {
		  
			if(gclx_chgtype.bindcolval=="3"){ // 자본적지출
				gcds_code02.namevalue(gcds_code02.rowposition,"CHGAMT2")=gcem_chgamt2_3.text;  
			}
     
			gctr_code01.KeyValue = "Account.a090023_t3(I:USER=gcds_code02)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_t3";
      		gctr_code01.Parameters="v_str1="+gs_date+",v_str2="+gs_userid;		
 		  //prompt('',gcds_code02.text);
			gctr_code01.post();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	if (gcds_code01.RowStatus(gcds_code01.rowposition) == "1" ){
		gcds_code01.Undo(gcds_code01.RowPosition);
	}else{
		if(gcds_code02.rowposition!=gcds_code02.countrow){
			alert("최종건만 삭제 가능합니다.");
			return false;
		}

		if(gclx_chgtype.bindcolval==1){
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=gcem_chgdate.text.substring(0,6)){
				alert("매각일자가 최종상각월보다 적어야 삭제 가능합니다.");
				return false;
			}
    }else if(gclx_chgtype.bindcolval==2){
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=gcem_chgdate_2.text.substring(0,6)){
				alert("폐기일자가 최종상각월보다 적어야 삭제 가능합니다.");
				return false;
			}
		}else if(gclx_chgtype.bindcolval==3){
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=gcem_chgdate_3.text.substring(0,6)){
				alert("자본적지출 일자가 최종상각월보다 적어야 삭제 가능합니다.");
				return false;
			}
		}
	
		if (confirm("선택하신 사항을 삭제하시겠습니까?")){
			gcds_code02.deleterow(gcds_code02.rowposition);
			gctr_code01.KeyValue = "a090023_t3(I:USER=gcds_code02)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_t3";
			//prompt('',gcds_code02.text);
			gctr_code01.post();
		}
	}
}


/******************************************************************************
	Description : 저장시 체크 
******************************************************************************/
function ln_Chk(){
    var strchgyymm="";

    if(gcds_code02.namevalue(gcds_code02.rowposition,"LOCKGB")=="Y"){
		alert("해당건은 수정할 수 없습니다.");
		return false;
	}	

	if(gclx_chgtype.bindcolval==""){
		alert("변경종류를 선택하십시요");
		return false;
	}

	if(gclx_chgtype.bindcolval=="1"){ //매각일경우
		if(gcem_chgdate.text==""){ 
			alert("매각일자는 필수 항목입니다.");
			gcem_chgdate.Focus();
			return false;
		}else{
			strchgyymm = gcem_chgdate.text.substring(0,6);
		}

		if(gcem_chgamt.text==""){ 
			alert("매각금액은 필수 항목입니다.");
			gcem_chgamt.Focus();
			return false;
		}	

		if(gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND")!="11"){ //토지가 아닌경우
			//날짜 체크 최종 상각월과 같은 월은 입력불가하게 함. 
			//변경일자는 최종 상각월보다 1개월 크야함.. ( 즉, 변경건 모두 입력 후에 해당월의 감가상각을 돌려야함. )
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=strchgyymm){
				alert("매각일자는 기존 감가상각년월보다 크야 합니다.")
				return false;
			}
			
			//2011.12.29 jys  매각건의 경우 감가상각 된건은 체크 안함.
			if (gcds_code01.namevalue(gcds_code01.rowposition,"ASTDEPRST")!="1"){   //완료가 아닌건.
				//2011.06.13 JYS 매각이 감가상각 최종월보다 2개월 이상되면, 감가상각 처리가 되지 않기 때문에 체크함	
				if(ln_SetYYYYMM(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM"))!=strchgyymm){ 
					alert("매각월은 기존 최종상각월+1월이어야 합니다.")
					return false;
				}
			}
		}


		//매각일 경우 매각처 필수항목
		if(txt_relfirm.value==""||txt_relfirmnm.value==""){
			alert("매각처를 입력하십시요.");
			return false;
		}

	}else if(gclx_chgtype.bindcolval=="2"){ //폐기일경우

		if(gcem_chgdate_2.text==""){ 
			alert("폐기일자는 필수 항목입니다.");
			gcem_chgdate_2.Focus();
			return false;
		}else{
			strchgyymm = gcem_chgdate_2.text.substring(0,6);
		}

		if(gcem_chgamt_2.text==""){ 
			alert("폐기금액은 필수 항목입니다.");
			gcem_chgamt_2.Focus();
			return false;
		}	


        if(gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND")!="11"){ //토지가 아닌경우
			//날짜 체크 최종 상각월과 같은 월은 입력불가하게 함. 
			//변경일자는 최종 상각월보다 1개월 크야함.. ( 즉, 변경건 모두 입력 후에 해당월의 감가상각을 돌려야함. )
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=strchgyymm){
				alert("폐기일자는 기존 감가상각년월보다 크야 합니다.")
				return false;
			}
        
            
			if (gcds_code01.namevalue(gcds_code01.rowposition,"ASTDEPRST")!="1"){   //완료가 아닌건.
				if(ln_SetYYYYMM(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM"))!=strchgyymm){ 
					alert("폐기월은 기존 최종상각월+1월이어야 합니다.")
					return false;
				}
			}
    	}

		//폐기일 경우 폐기처 필수항목
		//JYS 폐기처 선택항목으로 변경 ( 2011.06.13 시연회 중 )
		/**
		if(txt_relfirm_2.value==""||txt_relfirmnm_2.value==""){
			alert("폐기처를 입력하십시요.");
			return false;
		}
		**/

	}else if(gclx_chgtype.bindcolval=="3"){ //자본적지출일 경우 
    
    	if(gcem_chgdate_3.text==""){ 
			alert("자본적지출 일자는 필수 항목입니다.");
			gcem_chgdate_3.Focus();
			return false;
		}else{
			strchgyymm = gcem_chgdate_3.text.substring(0,6);
		}

		if(gcem_chgamt_3.text==""){ 
			alert("자본적지출 금액은 필수 항목입니다.");
			gcem_chgamt_3.Focus();
			return false;
		}	


       if(gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND")!="11"){ //토지가 아닌경우
			//날짜 체크 최종 상각월과 같은 월은 입력불가하게 함. 
			//변경일자는 최종 상각월보다 1개월 크야함.. ( 즉, 변경건 모두 입력 후에 해당월의 감가상각을 돌려야함. )
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=strchgyymm){
				alert("자본적지출 일자는 기존 감가상각년월보다 크야 합니다.")
				return false;
			}

			if (gcds_code01.namevalue(gcds_code01.rowposition,"ASTDEPRST")!="1"){   //완료가 아닌건.
				if(ln_SetYYYYMM(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM"))!=strchgyymm){ 
					alert("자본적지출월은 기존 최종상각월+1월이어야 합니다.")
					return false;
				}
			}
		}

    /**
		//자본적 지출일 경우 거래처 필수항목
		if(txt_relfirm_3.value==""||txt_relfirmnm_3.value==""){
			alert("거래처를 입력하십시요.");
			return false;
		}
		**/
	}
	return true
}


/******************************************************************************
	Description : 자산명 팝업
******************************************************************************/
function ln_Popup(e){

	if(e=='01'){           //자산명 팝업창
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;
		
		//strURL = "./Atcode_popup_1.jsp";
		strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_jasan.value = arrParam[1];  //자산명
			gcem_jasan.text = arrParam[0];  //자산코드
		} else {
			gcem_jasan.text = "";
			txt_jasan.value = "";
		}
	}
}

/******************************************************************************
	Description : 원가 팝업
	Parameter   : srow - grid의 row, strgb - 01: grid,  02:검색조건
******************************************************************************/
function ln_Popup2(srow,strgb){

  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="0030";//원가코드
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

  strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

 if(strgb=="02"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD.value = ln_Trim(arrParam[0]);
			txt_COSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD.value = "";	
			txt_COSTNM.value = "";
		}
	}
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 
/******************************************************************************
	Description : 변경종류 
******************************************************************************/
function ln_Lx_Enable(row){
  //alert("LOCKGB:::"+gcds_code02.namevalue(row,"LOCKGB"));
	if(gcds_code02.namevalue(row,"LOCKGB")=="Y"){
		gclx_chgtype.enable=false;
	}else{
		gclx_chgtype.enable=true;
	}
}

/******************************************************************************
	Description : 데이터 초기화  
******************************************************************************/
function ln_Clear(){
	gcem_chgdate.text="";
  gcem_chgamt.text="";
	gcem_chgamt2.text="";
	gcem_chgamt3.text="";
	txt_relfirm.value="";
   
	gcem_chgdate_2.text="";
  gcem_chgamt_2.text="";
	gcem_chgamt2_2.text="";
	gcem_chgamt3_2.text="";
	txt_relfirm_2.value="";

  gcem_chgdate_3.text="";
  gcem_chgamt_3.text="";
	gcem_chgamt2_3.text="";
	txt_relfirm_3.value="";
}

/******************************************************************************
	Description : 거래처 찾기
	Parameter   : 01 - 매각,  02 - 폐기,  03 - 자본적지출  
******************************************************************************/
function ln_Popup4(e){    
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos; 

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if(e=='01'){ 
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_relfirm.value = arrParam[0];
			txt_relfirmnm.value = arrParam[1];
		} else {
			txt_relfirm.value = "";
			txt_relfirmnm.value = "";
		}
	}else if(e=='02'){                   
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_relfirm_2.value = arrParam[0];
			txt_relfirmnm_2.value = arrParam[1];
		} else {
			txt_relfirm_2.value = "";
			txt_relfirmnm_2.value = "";
		}
	}else if(e=='03'){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_relfirm_3.value = arrParam[0];		
			txt_relfirmnm_3.value = arrParam[1];
		} else {
			txt_relfirm_3.value = "";		
		  txt_relfirmnm_3.value = "";
		}
	}
}


/******************************************************************************
	Description : 파라미터 받은 년월 + 1 월 
	Parameter   : 최종상각년월  
******************************************************************************/
function ln_SetYYYYMM(stryyyymm){

	var strSetYYMM="";
	var strYY = stryyyymm.substring(0,4);
	var strMM = stryyyymm.substring(4,6);

	if( parseInt(strMM)==12) {
    strYY = parseInt(strYY)+1;
		strMM = "01";
		strSetYYMM = strYY+ strMM;
	}else{
    strSetYYMM = parseInt(stryyyymm)+1
	}

  return  strSetYYMM;
}

/******************************************************************************
	Description : 파라미터 받은 년월 + 1 월 
	Parameter   : 최종상각년월  
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("변경내역","",2);
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<object  id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<object  id=gcds_cancel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<!-- 지점 -->
	<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>

	<!-- 자산분류 -->
	<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
		<PARAM NAME="SYNCLOAD" VALUE="false">
	</object>

	<!--자산소분류-->
	<OBJECT id="gcds_ascosdiv2_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
		<PARAM NAME="SYNCLOAD" VALUE="true">
	</OBJECT>

	<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_code01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow<=0)
		alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	ft_cnt02.innerText="데이타 조회중입니다.";
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)"> 
  ln_Lx_Enable(row);
  ft_cnt02.innerText = "조회건수 : " + row + " 건";
</script>

<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	window.status=" 감가상각 처리중입니다. ";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  감가상각처리를 완료 했습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<script language="javascript" for="gcds_cancel" event="OnLoadStarted()">
	window.status=" 감가상각 취소중입니다. ";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_cancel" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  감가상각취소를 완료 했습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.index=0;
</script>

<!-- 자산분류 (검색)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="전체";
	gclx_asdivcod.index=0;
</script>

<!-- 자산소분류 (검색)-->
<script language="javascript" for="gcds_ascosdiv2_2" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";   
	//document.all.LowerFrame.style.visibility="hidden";  	
  gcds_ascosdiv2_2.InsertRow(1);	
  gcds_ascosdiv2_2.NameValue(1,"CDCODE")="";
	gcds_ascosdiv2_2.NameValue(1,"CDNAM")="";
	gclx_ascosdiv2_2.index=0;	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
if(gclx_asdivcod.BindColVal=='14'){
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
	gcds_ascosdiv2_2.Reset();
}else if(gclx_asdivcod.BindColVal=='16'){
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
	gcds_ascosdiv2_2.Reset();
}else{
 	//자산소분류[검색]
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
	gcds_ascosdiv2_2.Reset();
}	
</script>


<!-- 그리드 선택일괄 체크 이벤트 -->
<script language="javascript" for="gclx_chgtype" event="OnSelChange2()">

  ln_Clear(); 

	if (gclx_chgtype.bindcolval=="1") {  //폐기
		//div1.style.display = "";
		div2.style.display = "";
		div3.style.display = "none";
		div4.style.display = "none";
	} else if (gclx_chgtype.bindcolval =="2") { //매각
		//div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "";
		div4.style.display = "none";	

		gcem_chgamt_2.text=gcds_code01.namevalue(gcds_code01.rowposition,"ASTRMAMT");  //폐기금액
	  gcem_chgamt2_2.text=gcds_code01.namevalue(gcds_code01.rowposition,"ASTRMAMT"); //페기손실
	} else if (gclx_chgtype.bindcolval =="3") { //자본적지출
		//div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "none";
		div4.style.display = "";
	} else {
		//div1.style.display = "";
		div2.style.display = "none";
		div3.style.display = "none";
		div4.style.display = "none";
	}
</script>

<!-- 매각시 유형자산 처분손실/처분이익 자동계산 -->
<script language=JavaScript for=gcem_chgamt event=OnKillFocus()> 
	var ls_chgamt=0;     //매각금액
	var ls_astrmamt=0;   //기존 잔존가액(장부가액)
	var ls_chgdiff=0;    //차액

	ls_chgamt = gcem_chgamt.Text;
	ls_astrmamt = gcds_code01.namevalue(gcds_code01.rowposition,"ASTRMAMT") ;

	gcem_chgamt2.Text=0;
	gcem_chgamt3.Text=0;
 	
	if( Number(ls_chgamt) > Number(ls_astrmamt)) { // 매각금액 > 장부가액 경우
		ls_chgdiff=(ls_chgamt - ls_astrmamt*1);
		gcem_chgamt3.Text=ls_chgdiff;                // 처분이익
	} else {
		ls_chgdiff=(ls_astrmamt - ls_chgamt*1);
		gcem_chgamt2.Text=ls_chgdiff;                // 처분손실 
	}
</script>

<!-- 자본적 지출에서 취득금액 계산 -->
<script language=JavaScript for=gcem_chgamt_3 event=OnKillFocus()> 

	var ls_chgamt = 0;                  //자본적지출금액
	var ls_astaqamt =0;                 //기존 취득금액
	var ls_chgsum=0;                    //합계

	ls_chgamt = gcem_chgamt_3.Text;     //자본적지출금액
	ls_astaqamt = gcds_code01.namevalue(gcds_code01.rowposition,"ASTAQAMT") ;
	ls_chgsum=(ls_astaqamt + ls_chgamt*1); //
  gcem_chgamt2_3.Text=ls_chgsum;
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
	
	if(row>0) {
		ln_Query2(row);
	}
</script>
 
<script language="javascript"  for=gcgd_disp02 event=OnClick(row,colid)>
	
	if(row>0) {
		ln_Lx_Enable(row);
	}
</script>
 
<script language=JavaScript for=gcds_code01 event=OnRowPosChanged(row)>

	if(row>0) {
	  ln_Query2(row);
		ln_Lx_Enable(row);
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
  alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		 <td  background="../../Common/img/com_t_bg.gif"  align=left><img src="../img/a090003_head.gif"></td>
		 <td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		        <img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onclick="ln_Excel()">
				<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr width="860px"> 		
			<td class="tab21" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " style="height:30px;width:80px;" bgcolor="#eeeeee" align="center">지&nbsp;&nbsp;&nbsp;&nbsp;점</td> 	
			<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="145px;" >&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
					<param name=ComboDataID          value="gcds_fdcode">
					<param name=CBDataColumns	     value="FDCODE,FDNAME">
					<param name=SearchColumn	     value="FDNAME">
					<param name=Sort			     value=false>
					<param name=ListExprFormat       value="FDNAME^0^150">								
					<param name=BindColumn		     value="FDCODE">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script> 				
			</td> 
			<td width="80px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; "  style="" bgcolor="#eeeeee" class="tab21" align=center >&nbsp;상태구분</td>
			<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="145px;" >&nbsp;
				
				<comment id="__NSID__">
					<OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-2px;top:2px;font-size:12px;width:110px;">
						<param name=CBData					value="^전체,0^정상,1^매각,2^폐기,3^자본적지출">
						<param name=CBDataColumns		value="Code, Parm">
						<param name=SearchColumn		value="Parm">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="Parm^0^110">
						<param name=BindColumn			value="Code">
					</OBJECT>
				</comment><script>__ws__(__NSID__);</script></nobr> 			
				
				
				<!-- <comment id="__NSID__">
				<OBJECT id=gcem_astnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">	
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="########">
					<param name=PromptChar   	value="_">
				</OBJECT>&nbsp;&nbsp;
				<OBJECT id=gcem_total classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:0px;top:2px;">	
					<param name=Text				value="">
					<param name=Alignment		value=2>
					<param name=Border			value=true>
					<param name=MaxLength   value=4>
					<param name=IsComma	    value=false>
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script>  -->
			</td> 
			<td width="80px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; "  style="" bgcolor="#eeeeee" class="tab21" align=center >&nbsp;원가명</td>
			<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; "  >&nbsp;
				<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','02')">
				<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
			</td>
		</tr>
		<!----------------------------------------------------------------------------------------------------------------->
		<tr width="876px"> 
			<td width="80px" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; "  style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>자산중분류</nobr></td>
			<td class="tab19" style="width:160px;" ><nobr>&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
					<param name=ComboDataID			value="gcds_asdivcod">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort						value=false>
					<param name=ListExprFormat	value="CDNAM^0^130">
					<param name=BindColumn			value="CDCODE">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script></nobr>
			</td>					
			<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>자산소분류</nobr></td>
			<td class="tab19" style="width:120px;"><nobr>&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_ascosdiv2_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-2px;top:2px;font-size:12px;width:110px;">
					<param name=ComboDataID			value="gcds_ascosdiv2_2">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort				value=false>
					<param name=ListExprFormat	value="CDNAM^0^110">
					<param name=BindColumn			value="CDCODE">
				 </OBJECT>
				 </comment><script>__ws__(__NSID__);</script></nobr> 
			 </td>
			 <td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;자산명</nobr></td>
			 <td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; "><nobr>&nbsp;
				<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-1px;top:-2px;" MaxLength=30>
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup(01)">
				<comment id="__NSID__">
				<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:50px">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#######">
					<param name=PromptChar	value="_">
					<param name=Enable			value="false">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script></nobr>						 
			 </td>
		 </tr>  
		 <tr>
		  <td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >구분</td>
			<td class="tab28" colspan=5 >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24px;width:240px">
					<param name=Cols	  value="2">
					<param name=Format	value="1^상각적용,2^상각미적용(토지)">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		 </tr>
  </table>

<table width="858px" cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;top:3px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01 	style="position:relative;left:0px;width:665px; height:225px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="false"> 
					<param name="Format"		value=" 
					<C> Name='자산번호'			ID=ASTNBR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='자산명'				ID=ASNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=left	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='취득일자'			ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center	BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} Mask='XXXX/XX/XX'</C>
					<C> Name='년수'		    	ID=ASLIFYER		HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='취득금액'			ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='전기누계액'	  ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='당기상각액'	  ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='잔존가액'			ID=ASTRMAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='상각월'		    ID=LASTYM   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} Mask='XXXX/XX'</C>
					">
			 </object>
			 </comment><script>__ws__(__NSID__);</script>
			</td>
      <td>
			<comment id="__NSID__">
			 <object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02 	style="position:relative;left:0px;width:190px; height:225px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		value="gcds_code02">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="false"> 
					<param name="Format"		value=" 
					<C> Name='순번'		    ID=CHGNO  		HeadAlign=Center HeadBgColor=#B9D4DC Width=35	  align=center  BgColor={IF(LOCKGB='Y','#FFCC66','FFFFFF')} </C>
					<C> Name='변경일자'		ID=CHGDATE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  BgColor={IF(LOCKGB='Y','#FFCC66','FFFFFF')} Mask=XXXX-XX-XX </C>
					<C> Name='자산상태'		ID=CHGTYPE		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  BgColor={IF(LOCKGB='Y','#FFCC66','FFFFFF')} EditStyle=Combo		Data='0:정상,1:매각,2:폐기,3:자본적지출' </C>	
					">
			 </object>
			 </comment><script>__ws__(__NSID__);</script>		
		</td>
	</tr>
	<tr>
		<td style="height:20px;" >
			<fieldset style="height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">&nbsp;<font id=ft_cnt01 style="position:relative;top:3px;cursor:hand;"></font></fieldset>
		</td>
    <td style="height:20px;" >
			<fieldset style="height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">&nbsp;<font id=ft_cnt02 style="position:relative;top:3px;cursor:hand;"></font></fieldset>
		</td>
  </tr>
	<tr><td style="height:5px;" colspan=2> </td></tr>
</table>	
	
<table cellpadding="0" cellspacing="0"  width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
		<tr>
			<td style="width:110px;" bgcolor="#FFCC66" align=center class="tab14" >&nbsp;변경종류&nbsp;</td>
			<td align=left class="tab31">
				<comment id="__NSID__">
				<OBJECT id=gclx_chgtype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 style="position:relative;left:7px;top:0px" class="txtbox" >
					<param name=CBData					value="1^매각,2^폐기,3^자본적지출">
					<param name=CBDataColumns		value="Code, Parm">
					<param name=SearchColumn		value="Parm">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="Parm^0^100">
					<param name=BindColumn			value="Code">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script> 				
			</td>
			<td align=right class="tab31" >
				<img id="btn_Delete08"   src="../../Common/img/btn/com_b_delete.gif"    style="cursor:hand;position:relative;top:2px;" onclick="ln_Delete()">
				<img id="btn_Insert08"   src="../../Common/img/btn/com_b_insert.gif"	  style="cursor:hand;position:relative;top:2px;" onClick="ln_Add()">
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Save()">
			</td>
		</tr>
</table>
		
 <div id=div2 style="display:none"><!-- 매각 -->
		<table cellpadding="0" cellspacing="0" width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
			<tr>
					<td class="tab11" width="110" bgcolor="#eeeeee">매각일자</td>
					<td class="tab21" width="110" height="30px" >
						<comment id="__NSID__">
						<object id=gcem_chgdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</object>
						</comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_chgdate', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
					</td>
					<td class="tab11" width="110"  height="30px" bgcolor="#eeeeee">매각금액</td>
					<td class="tab21" width="110"  height="30px" >
						<comment id="__NSID__">
						<object id=gcem_chgamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								<param name=Alignment					value=2>
								<param name=MaxDecimalPlace		value=0>
								<param name=MaxLength value=13>			  										
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" width="80" height="30px" bgcolor="#eeeeee">매각처</td>
					<td class="tab21" height="30px">
						<!-- <input type="text" id=txt_relfirm class="txt21" style="width:230px;" > -->
						<input id="txt_relfirm"   type=text    style= "position:relative;top:2px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find2('txt_MAKER','03');" readOnly>
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('01');">
						<input id="txt_relfirmnm" type="text"  style= "position:relative;top:2px;left:4px;width:220px; height:20px;background-color:#ccffcc;"class="txtbox"  maxlength="36" onBlur="bytelength(this,this.value,36);" readOnly>			
					</td>
				</tr>
				<tr>
					<td class="tab11" height="30px" bgcolor="#eeeeee">유형자산 처분손실</td>
					<td class="tab21" height="30px" width=110>
						<comment id="__NSID__">
						<object id=gcem_chgamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								<param name=Alignment					 value=2>
								<param name=ReadOnlyBackColor  value="#BEF781">
								<param name=ReadOnly           value="true">
								<param name=MaxDecimalPlace		 value=0>
								<param name=MaxLength          value=13>			  										
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" height="30px" bgcolor="#eeeeee">유형자산 처분이익</td>
					<td class="tab21" height="30px" width=110  colspan=3>
						<comment id="__NSID__">
						<object id=gcem_chgamt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								<param name=Alignment					 value=2>
								<param name=ReadOnlyBackColor  value="#BEF781">
								<param name=ReadOnly           value="true">
								<param name=MaxDecimalPlace	 	 value=0>
								<param name=MaxLength value=13>			  										
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
					
		<div id=div3 style="display:none"><!-- 폐기 -->
			<table cellpadding="0" cellspacing="0" width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
					<tr>
						<td class="tab11" width="110" bgcolor="#eeeeee">폐기일자</td>
						<td class="tab21" width=110   height="30px" >
							<comment id="__NSID__">
							<object id=gcem_chgdate_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  	style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_chgdate_2', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td class="tab11" width="110"  bgcolor="#eeeeee">폐기금액</td>
						<td class="tab21" width="110"  height="30px" >
							<comment id="__NSID__">
							<object id=gcem_chgamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								  style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
									<param name=Alignment					 value=2>
									<param name=ReadOnlyBackColor  value="#BEF781">
									<param name=ReadOnly           value="true">
									<param name=MaxDecimalPlace		 value=0>
									<param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
				    </td>				
						<td class="tab11" width="80" height="30px" bgcolor="#eeeeee">폐기처</td>
						<td class="tab21" height="30px" >
							<!-- <input type="text" id=txt_relfirm_2 class="txt21" style="width:170px;" > -->
							<input id="txt_relfirm_2"   type=text    style= "position:relative;top:2px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  readOnly>
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('02');">
							<input id="txt_relfirmnm_2" type="text"  style= "position:relative;top:2px;left:4px;width:220px; height:20px;background-color:#ccffcc;" class="txtbox"   readOnly>								
						</td>
		      </tr>
					<tr>
						<td class="tab11" height="30px" bgcolor="#eeeeee">유형자산 폐기손실</td>
						<td class="tab21" height="30px" width=110>
							<comment id="__NSID__">
							<object id=gcem_chgamt2_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="3"
								  style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
									<param name=Alignment					 value=2>
									<param name=ReadOnlyBackColor  value="#BEF781">
									<param name=ReadOnly           value="true">
									<param name=MaxDecimalPlace		 value=0>
									<param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script></td>
						<td class="tab11" height="30px" bgcolor="#eeeeee">잡수익</td>
						<td class="tab21" height="30px" width=180 colspan=3>
							<comment id="__NSID__">
							<object id=gcem_chgamt3_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2"
								style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								 <param name=Alignment					value=2>
								 <param name=ReadOnlyBackColor  value="#BEF781">
								 <param name=ReadOnly           value="true">
								 <param name=MaxDecimalPlace		value=0>
								 <param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
					</tr>				
				</table>
			</div>

			<div id=div4 style="display:none"><!-- 자본적지출 -->
				<table cellpadding="0" cellspacing="0" width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
					<tr>
						<td class="tab11" width="110" bgcolor="#eeeeee">자본적지출 일자</td>
						<td class="tab21" width=110   height="30px" >
							<comment id="__NSID__"><object id=gcem_chgdate_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_chgdate_3', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td class="tab11" width="110" height="30px" bgcolor="#eeeeee">자본적지출 금액</td>
						<td class="tab21" width="110" height="30px" >
							<comment id="__NSID__">
							<object id=gcem_chgamt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
								<param name=Alignment					value=2>
								<param name=MaxDecimalPlace		value=0>
								<param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="80" height="30px" bgcolor="#eeeeee">거래처</td>
						<td class="tab21" height="30px" >
							<!-- <input type="text" id=txt_relfirm_3 class="txt21" style="width:170px;" > -->
							<input id="txt_relfirm_3"   type=text    style= "position:relative;top:2px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  readOnly>
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('03');">
							<input id="txt_relfirmnm_3" type="text"  style= "position:relative;top:2px;left:4px;width:220px; height:20px;background-color:#ccffcc;" class="txtbox"   readOnly>								
						</td>
					</tr>
					<tr>
						<td class="tab11" height="30px" bgcolor="#eeeeee">취득금액</td>
						<td class="tab21" height="30px" colspan = 5>
							<comment id="__NSID__">
							<object id=gcem_chgamt2_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
									<param name=Alignment					 value=2>
									<param name=ReadOnlyBackColor  value="#BEF781">
									<param name=ReadOnly           value="true">
 									<param name=MaxDecimalPlace		 value=0>
  							  <param name=MaxLength          value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
						</td>
					</tr> 
				</table>
			</div>

</table>
 
<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_code02">
<PARAM NAME="BindInfo" VALUE="
		<C>Col=CHGTYPE		Ctrl=gclx_chgtype				  Param=BindColVal</C>
		
		<C>Col=CHGDATE			Ctrl=gcem_chgdate				Param=Text</C>
		<C>Col=CHGAMT			  Ctrl=gcem_chgamt				Param=Text</C>
		<C>Col=CHGAMT2		  Ctrl=gcem_chgamt2			  Param=Text</C>
		<C>Col=CHGAMT3		  Ctrl=gcem_chgamt3			  Param=Text</C>
		<C>Col=RELFIRM			Ctrl=txt_relfirm			  Param=value</C>
		<C>Col=RELFIRMNM		Ctrl=txt_relfirmnm		  Param=value</C>

		<C>Col=CHGDATE			Ctrl=gcem_chgdate_2			Param=Text</C>
		<C>Col=CHGAMT			  Ctrl=gcem_chgamt_2			Param=Text</C>
		<C>Col=CHGAMT2		  Ctrl=gcem_chgamt2_2			Param=Text</C>
		<C>Col=CHGAMT3		  Ctrl=gcem_chgamt3_2			Param=Text</C>
		<C>Col=RELFIRM			Ctrl=txt_relfirm_2			Param=value</C>
		<C>Col=RELFIRMNM  	Ctrl=txt_relfirmnm_2	  Param=value</C>

		<C>Col=CHGDATE			Ctrl=gcem_chgdate_3			Param=Text</C>
		<C>Col=CHGAMT			  Ctrl=gcem_chgamt_3			Param=Text</C>
		<C>Col=CHGAMT2		  Ctrl=gcem_chgamt2_3			Param=Text</C>
		<C>Col=RELFIRM			Ctrl=txt_relfirm_3			Param=value</C>
		<C>Col=RELFIRMNM  	Ctrl=txt_relfirmnm_3	  Param=value</C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>