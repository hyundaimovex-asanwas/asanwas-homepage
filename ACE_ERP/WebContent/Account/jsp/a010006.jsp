
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 금융코드관리
+ 프로그램 ID	: A010006
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 구자헌 / 정하나 (09.01.30-카드관리)
+ 서 블 릿 명	: a010006_s2, a010006_t2 : 카드관리
              a010006_s3, a010006_t3 : 환율관리
              a010006_s4, a010006_t4 : 은행코드관리
              a010006_s5, a010006_s5 : 은행계좌관리
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>금융코드관리</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩시
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_MajorQuery();        //시작시
	//ln_SetDataHeader();
	//ln_Before();          //시작시
	//ln_Luxequery();				//공통코드
	ln_Tabset(0);
	gcra_calyn.CodeValue = 'Y';
}

/******************************************************************************
	Description : 데이타셋 조회
******************************************************************************/
function ln_MajorQuery(){

	
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_dept.Reset();
	
//	gclx_dept.BindColVal = gcds_dept.namevalue(gcds_dept.rowposition,"DEPTCD");
//	gclx_dept.index = 0; //카드관리의 소속콤보


	gcds_card3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_s2?v_str1=1134";
	gcds_card3.Reset();
	gclx_cacardspec.BindColVal = gcds_card3.namevalue(gcds_card3.rowposition,"CDNAM");
	gclx_cacardspec.index = 0;  //카드관리의 카드종류콤보
	
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010003_s1?v_str1=&v_str2=";
	gcds_dept1.Reset();
	gclx_cadeptcd.BindColVal = gcds_dept1.namevalue(gcds_dept1.rowposition,"DEPTNMK");
	gclx_cadeptcd.index = 0;  //카드관리의 관리부서콤보

	gcds_curr1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_s2?v_str1=1043";
	gcds_curr1.Reset();

	//gclx_curr.BindColVal = gcds_curr1.namevalue(gcds_curr1.rowposition,"CDCODE");
	//gclx_curr.index = 0;  //환율관리의 통화코드콤보

	gclx_curr.BindColVal = '02';
	//gclx_curr.index = 0;  //환율관리의 통화코드콤보

	gcds_ercode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_s2?v_str1=1043";
	gcds_ercode1.Reset();
	//gclx_ercode.BindColVal = gcds_ercode1.namevalue(gcds_ercode1.rowposition,"CDCODE");
	//gclx_ercode.index = 0;  //환율관리의 통화코드콤보

	gclx_ercode.BindColVal = '02';

}

/******************************************************************************
	Description : 카드관리 조회
	Parameter : 
******************************************************************************/
function ln_Query1(){

	gcem_canbr.enable = "false";

	 var str1 = gcra_calyn.CodeValue;
	 var str2 = txt_banknm.value;
	 var str3 = txt_banknb.value;
	 var str4 = txt_vend_nm1.value;

	gcds_card2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_s2?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	//prompt(this,gcds_card2.DataID);  
	gcds_card2.Reset();
	gcds_card2.rowposition = 1; //카드관리의 그리드

}

/******************************************************************************
	Description : 카드관리 삽입, 삭제
******************************************************************************/
function ln_Add1(){

	gcds_card2.addrow();
	gcem_canbr.enable = "true";
	gcem_canbr.focus();
	gcra_cadiv.CodeValue = "1";
	gcra_useyn2.CodeValue ="Y";

}

function ln_Save1(){

	if (!ln_Valchk1()) return;

	if (gcds_card2.IsUpdated) {

		if (confirm("입력하신 사항을 저장하시겠습니까?")){
			gctr_card2.KeyValue = "a010006_t2(I:USER=gcds_card2)";
			gctr_card2.Action ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t2?";
			
			gctr_card2.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
			//prompt('',gcds_card2.text);
			gctr_card2.post();
			return ln_Query1();
		}
	}

}

function ln_Delete1(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_card2.deleterow(gcds_card2.rowposition);
		gctr_card2.KeyValue = "a010006_t2(I:USER=gcds_card2)";
		gctr_card2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t2";
		gctr_card2.post();
		return ln_Query1();
	}
}

/******************************************************************************
	Description : 환율관리 조회
	Parameter : gclx_curr, gcem_ref, gcem_ref1
******************************************************************************/
function ln_Query2(){

	gclx_ercode.enable = "false";
	gcem_erstddat.enable = "false";

	var str11 = gclx_curr.bindcolval;
	var str12 = gcem_ref.text;
	var str13 = gcem_ref1.text;
	gcds_curr.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_s3?v_str1="+str11+"&v_str2="+str12+"&v_str3="+str13;
	gcds_curr.Reset();  //환율관리의 그리드
	gcds_curr.rowposition = 1;

}

/******************************************************************************
	Description : 환율관리 삽입, 삭제
******************************************************************************/
function ln_Add2(){

	gcds_curr.addrow();
	gclx_ercode.enable = "true";
	gcem_erstddat.enable = "true";
	gclx_ercode.BindColVal = '02';
	//gclx_ercode.focus();


}

function ln_Save2(){
	if (!ln_Valchk2()) return;
	if (gcds_curr.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){
			gctr_curr.KeyValue = "a010006_t3(I:USER=gcds_curr)";
			//prompt("",gcds_curr.text);
			gctr_curr.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t3";
			gctr_curr.post();
			return ln_Query2();
		}
	}
}

function ln_Delete2(){
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_curr.deleterow(gcds_curr.rowposition);
		gctr_curr.KeyValue = "a010006_t3(I:USER=gcds_curr)";
		gctr_curr.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t3";
		gctr_curr.post();
		return ln_Query2();
	}
}

/******************************************************************************
	Description : 은행코드관리 조회
	Parameter : txt_bankname
******************************************************************************/
function ln_Query3(){

	gcem_bancod.enable = "false";

	var str11 = txt_bankname.value;
	gcds_bank1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_s4?v_str1=" + str11;
	gcds_bank1.Reset();
	gcds_bank1.rowposition = 1;

}

/******************************************************************************
	Description : 은행코드관리 삽입, 삭제
******************************************************************************/
function ln_Add3(){

	gcds_bank1.addrow();
	gcem_bancod.enable = "true";
	gcem_bancod.focus();

}

function ln_Save3(){

	if (!ln_Valchk3()) return;

	if (gcds_bank1.IsUpdated) {

		if (confirm("입력하신 사항을 저장하시겠습니까?")){
			gctr_bank1.KeyValue = "a010006_t4(I:USER=gcds_bank1)";
			gctr_bank1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t4";
			gctr_bank1.post();
			return ln_Query3();
		}
	}

}

function ln_Delete3(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_bank1.deleterow(gcds_bank1.rowposition);
		gctr_bank1.KeyValue = "a010006_t4(I:USER=gcds_bank1)";
		gctr_bank1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t4";
		gctr_bank1.post();
		return ln_Query3();
	}
}

/******************************************************************************
	Description : 은행계좌관리 조회
	Parameter : txt_account
******************************************************************************/
function ln_Query4(){

	gcem_bancod2.enable = "false";
	txt_bnknum.disabled = true;

	var str11 = txt_account.value;
	gcds_acc.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_s5?v_str1=" + str11;
	gcds_acc.Reset();
	gcds_acc.rowposition = 1;

}

/******************************************************************************
	Description : 은행계좌관리 삽입, 삭제
******************************************************************************/
function ln_Add4(){

	gcds_acc.addrow();
	gcem_bancod2.enable = "true";
	txt_bnknum.disabled = false;
	gcem_bancod2.focus();

}

function ln_Save4(){

	if (!ln_Valchk4()) return;

	if (gcds_acc.IsUpdated) {

		if (confirm("입력하신 사항을 저장하시겠습니까?")){
			gctr_acc.KeyValue = "a010006_t5(I:USER=gcds_acc)";
			gctr_acc.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t5";
			gctr_acc.post();
			return ln_Query4();
		}
	}

}

function ln_Delete4(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_acc.deleterow(gcds_acc.rowposition);
		gctr_acc.KeyValue = "a010006_t5(I:USER=gcds_acc)";
		gctr_acc.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_t5";
		gctr_acc.post();
		return ln_Query4();
	}
}

/******************************************************************************
	Description : 탭
	Parameter   : 0-카드관리, 1-환율관리, 2-은행코드관리, 3-은행계좌관리
******************************************************************************/
function ln_Tabset(index){

	var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4");

	for(var i=0;i<=3;i++)	{

		if(i==index) eval("document.all."+div_cm[i]+".style.display='block';");
		else eval("document.all."+div_cm[i]+".style.display='none';");
	}

}

/******************************************************************************
	Description : 분류코드찾기 팝업
******************************************************************************/
function ln_Popup(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./banklist_popup2.jsp";
	strPos = "dialogWidth:488px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_caaccbank.value = ln_Trim(arrParam[0]);
		txt_caaccbank1.value = ln_Trim(arrParam[1]);
	} else {
		txt_caaccbank.value = "";
		txt_caaccbank1.value = "";
	} //카드관리의 결재은행

}

function ln_Popup1(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./banklist1_popup.jsp";
	strPos = "dialogWidth:318px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bancod2.text = ln_Trim(arrParam[0]);
		txt_bancod3.value = ln_Trim(arrParam[1]);
		txt_banna2.value = ln_Trim(arrParam[2]);
	} else {
		gcem_bancod2.text = "";
		txt_bancod3.value = "";
		txt_banna2.value = ""; //
	}

}

function ln_Popup2(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL =  "<%=dirPath%>/Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
	//arrParam[0] : zip
	//arrParam[1] - [4] : address1 - address4
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_czipcd.text = arrParam[0];
		txt_caddr01.value = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
	
	}
}

function ln_Find(){
	var arrSend	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrSend[0]="H050005";
	strURL = "<%=dirPath%>/Payroll/jsp/H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		//eval(e).value  = arrParam[0];
		txt_caempno.value = ln_Trim(arrParam[1]);
		txt_caempno1.value = ln_Trim(arrParam[0]);
	} else {
		//eval(e).value = "";
		txt_caempno.value = "";
		txt_caempno1.value = "";
	}//카드관리의 사원번호
}


function ln_Find1(){
	var arrResult	= new Array();
	var strURL;	
	var strPos;
    alert("2");
	strURL = "<%=dirPath%>/Payroll/jsp/H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		//eval(e).value  = arrParam[0];
		txt_empno.value = ln_Trim(arrParam[1]);
		txt_empnmk.value = ln_Trim(arrParam[0]);
	} else {
		//eval(e).value = "";
		txt_empno.value = "";
		txt_empnmk.value = "";
	} //계좌관리의 사원번호
}

function ln_Find2(){
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");

	 	txt_vend_nm2.value = ln_Trim(arrParam[1]);
		txt_vend_nm.value = ln_Trim(arrParam[0]);
		 // arrParam[2]= txt_vendcd02.value;     //거래처코드
		//	arrParam[6]= gcem_vendnm02.text;     //거래처
	} else {
		//eval(e).value = "";
		txt_vend_nm.value = "";
	} //거래처 찾기
}


/******************************************************************************
	Description : 공백문자체크
******************************************************************************/
function ln_Valchk1() {

	if (fn_trim(gcem_canbr.text) == "") {			
		alert("정확한 카드번호를 입력해 주십시오");
		//gcem_canbr.text = "";
		gcem_canbr.focus();
		return false;
	}
	
	// 미사용일경우 폐기일자 체크 
	if (gcra_useyn2.codevalue=="N"){
		if(fn_trim(gcem_dsudt.text)==""){
			alert("폐기일자를 입력하여 주십시오.");
			gcem_dsudt.focus();
			return false;
		}
	}
	return true; //카드관리
}

function ln_Valchk2() {

	if (fn_trim(gclx_ercode.BindColVal) == "") {			
		alert("정확한 통화코드를 입력해 주십시오");
		//gclx_ercode.value = "";
		gclx_ercode.focus();
		return false;
	}

	if (fn_trim(gcem_erstddat.text) == "") {			
		alert("정확한 기준일자를 입력해 주십시오");
		//gcem_erstddat.text = "";
		gcem_erstddat.focus();
		return false;
	}
	return true;

}

function ln_Valchk3() {

	if (fn_trim(gcem_bancod.text) == "") {			
		alert("정확한 은행코드를 입력해 주십시오");
		//gcem_bancod.text = "";
		gcem_bancod.focus();
		return false;
	}
	return true;

}

function ln_Valchk4() {

	if (fn_trim(gcem_bancod2.text) == "") {			
		alert("정확한 은행코드를 입력해 주십시오");
		//txt_bancod2.value = "";
		gcem_bancod2.focus();
		return false;
	}

	if (fn_trim(txt_bnknum.value) == "") {			
		alert("정확한 계좌번호를 입력해 주십시오");
		//txt_bnknum.value = "";
		txt_bnknum.focus();
		return false;
	}
	return true;

}

/******************************************************************************
	Description : 공백제거
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

/******************************************************************************
	Description : 공백제거
******************************************************************************/
function ln_Excel(){
	gcgd_disp1.GridToExcel('개인명 법인카드','',8);

}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 카드관리 -->

<comment id="__NSID__"><object  id=gcds_card2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 카드관리 -->

<comment id="__NSID__"><object  id=gcds_card3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 카드관리 -->

<comment id="__NSID__"><object  id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 카드관리 -->

<comment id="__NSID__"><object  id=gcds_curr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 환율관리 -->

<comment id="__NSID__"><object  id=gcds_curr1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 환율관리 -->

<comment id="__NSID__"><object  id=gcds_ercode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!-- 환율관리 -->

<comment id="__NSID__"><object  id=gcds_bank1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 은행코드관리 -->

<comment id="__NSID__"><object  id=gcds_acc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 은행계좌관리 -->

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><object  id="gctr_card2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> <!-- 카드관리 -->

<comment id="__NSID__"><object  id="gctr_curr" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> <!-- 환율관리 -->

<comment id="__NSID__"><object  id="gctr_bank1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> <!-- 은행코드관리 -->

<comment id="__NSID__"><object  id="gctr_acc" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> <!-- 은행계좌관리 -->

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcte_tab event=OnSelChanged(index)>

	ln_Tabset((index-1));

</script>

<script language="javascript" for="gclx_dept" event="OnCloseUp()">

	
</script>

<script language="javascript" for="gcds_card2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_curr" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
//	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_bank1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_acc" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
//	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.insertrow(1);
	gcds_dept.namevalue(1,"DEPTCD") = "";
	gcds_dept.namevalue(1,"DEPTNM") = "전체";
//	gclx_dept.index = 0;
</script>

<script language="javascript" for="gcds_card2" event="onloadCompleted(row,colid)">

	window.status="조회가 완료되었습니다.";
	lbl_search1.innerText = row + " 건";
//	document.all.LowerFrame.style.visibility="hidden";
	if (row <1)
		alert("검색된 데이터가 없습니다.");
</script><!-- 카드관리 -->

<script language="javascript" for="gcds_curr" event="onloadCompleted(row,colid)">

	window.status="조회가 완료되었습니다.";
	lbl_search2.innerText = row + " 건";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1)
		alert("검색된 데이터가 없습니다.");
</script><!-- 환율관리 -->

<script language="javascript" for="gcds_bank1" event="onloadCompleted(row,colid)">

	window.status="조회가 완료되었습니다.";
	lbl_search3.innerText = row + " 건";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1)
		alert("검색된 데이터가 없습니다.");
</script><!-- 은행코드관리 -->

<script language="javascript" for="gcds_acc" event="onloadCompleted(row,colid)">

	window.status="조회가 완료되었습니다.";
	lbl_search4.innerText = row + " 건";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1)
		alert("검색된 데이터가 없습니다.");
</script><!-- 은행계좌관리 -->

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gctr_card2" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_card2" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	  alert("Error Code : " + gctr_card2.ErrorCode + "\n" + "Error Message : " + gctr_card2.ErrorMsg + "\n");
</script><!-- 카드관리 -->




<script language="javascript" for="gctr_curr" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_curr" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
  alert("Error Code : " + gctr_curr.ErrorCode + "\n" + "Error Message : " + gctr_curr.ErrorMsg + "\n");
</script><!-- 환율관리 -->

<script language="javascript" for="gctr_bank1" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_bank1" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script><!-- 은행코드관리 -->

<script language="javascript" for="gctr_acc" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_acc" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script><!-- 은행계좌관리 -->

</head>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif"><img src="../img/a010006_head.gif"></td>
    <td background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif">&nbsp;</td>
  </tr>
   
  
  <tr> 
    <td COLSPAN=2 ALIGN=LEFT>

      <table width="0" cellpadding="1" cellspacing="0" border="0">
			<tr> 
				<td width="0" align=RIGHT><NOBR>
					  <comment id="__NSID__"><object  id=gcte_tab classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px">
              <PARAM NAME="BackColor" VALUE="#cccccc">
              <PARAM NAME="titleHeight" VALUE="20px">
              <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
              <PARAM NAME="Format" VALUE="
              <T>divid=div1_disp1      title=카드관리</T>
              <T>divid=div2_disp2      title=환율관리</T>
			        <T>divid=div3_disp3      title=은행코드관리</T>
			        <T>divid=div4_disp4      title=은행계좌관리</T>">
				</object></comment><script>__ws__(__NSID__);</script> </NOBR>
				</td>
			</tr>
      </table>
    
	</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		<fieldset id="field1" style="position:absolute;top:70px;left:0px;height:485px;width:880px;bacground-color:#708090"></fieldset>
		<!----------- 카드관리 ----------->
		<div id="div_disp1">
			<table width="876" cellpadding="1" cellspacing="0" border="0">
				<tr><td height=5></td></tr>
				<tr>
					<td colspan=8 align=center>

						<table width="866" cellpadding="1" cellspacing="0" border="0" style='width:866px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
						<tr>
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>
							 사용유무</nobr></td>
							  <td style="border:0 solid #708090;border-right-width:1px;width:100px; " ><nobr>
							<comment id="__NSID__"><object id=gcra_calyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="left:-30px;top:0px;height:22;width:90;cursor:hand;" class="txtbox">
										<param name=Cols     value="2">
										<param name=Format   value="Y^사용,N^폐기">
									</object></comment><script>__ws__(__NSID__);</script>
								</td> 
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr> 결재은행</nobr></td>
								<td style="border:0 solid #708090;border-right-width:1px;width:65px;" ><nobr>&nbsp;
								<input id="txt_banknm" name="txt_banknm"	type='text'	style="width:50px;position:relative;left:-5px;top:1px" class="txtbox" > </td>
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr> 계좌번호 </nobr></td>

								<td style="border:0 solid #708090;border-right-width:1px;width100px;" ><nobr>&nbsp;
									<input id="txt_banknb" class="txtbox" type="text" style="width:90px;position:relative;left:-5px" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
								</td>

								    <td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;거래처&nbsp;&nbsp;</nobr></td>
								<td style="border:0 solid #708090 width=150px" ><nobr>&nbsp;
								<input id="txt_vend_nm1" name="txt_vend_nm1"	type='text'	style="width:140px;position:relative;left:-5px;top:1px" class="txtbox" > </td>
							   <td><nobr> 
							         <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"        style="cursor:hand;position:relative;top:-65px" onclick="ln_Excel()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Delete1()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Add1()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Save1()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Query1()"> 
									</nobr>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td ALIGN=CENTER>

					<table width="866" cellpadding="1" cellspacing="0" border="0">
								<tr> 
									<td style="width:866" ALIGN=LEFT VALIGN=TOP>
										<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp1  style="WIDTH: 580px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
											<PARAM NAME="DataID"        VALUE="gcds_card2">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<param NAME="Fillarea"      VALUE="true">
											<param NAME="SortView"      VALUE="Left">
											<param name="IndWidth"      value="0">
											<PARAM NAME="Format"        VALUE=" 
                        						<F> Name='카드번호'   ID=CANBR		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	 align=center sort=true bgcolor=#f5f5f5</F> 
												<C> Name='카드구분'   ID=CADIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=55,align=center, EditStyle='combo', data='1:법인,2:개인' </C>
						                        <C> Name='카드종류'	ID=CACARDSPEC		HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=center</C> 
						                        <C> Name='관리소속'	ID=CADEPTCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=center sort=true</C>
												<C> Name='거래처'	    ID=VEND_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=center sort=true</C>                   
												<C> Name='발급년월'   ID=CAISSYYMM		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center, Mask='XXXX/XX' sort=true</C> 
						                        <C> Name='유효년월'	ID=CAUSEYYMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center, Mask='XXXX/XX' sort=true</C> 
						                        <C> Name='결재일'		ID=CASTTDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center</C>
						                        <C> Name='결재은행'	ID=BANNA1		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center sort=true</C> 
						            			<C> Name='결재계좌번호' ID=CABANKNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=145		align=left sort=true</C> 
						                        <C> Name='예금주'		ID=CACUST		HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=left sort=true</C>										
						                        <C> Name='폐기일자'	ID=DSUDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=85	align=CENTER, Mask='XXXX/XX/XX' sort=true</C>
						                        <C> Name='사용유무'	ID=USE_TAG	HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=CENTER,  sort=true</C>
												<C> Name='사원번호'	ID=CAEMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=center sort=true</C> ">
										</object></comment><script>__ws__(__NSID__);</script> 
                  </td>
                  <td>
							<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:282px;height:420px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;카드번호</nobr></td>
								<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_canbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:110px;height:20px;position:relative;left:1px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="################">
											<param name=PromptChar    value="">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> </nobr>
							  </td>
							</tr>
							<tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;카드구분</nobr></td>  
								<td class="tab22">
									<comment id="__NSID__"><object  id=gcra_cadiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:5px;top:0px;height:24;width:110;cursor:hand;">
					           <param name=Cols     value="2">								 
						         <param name=Format   value="1^법인,2^개인">
			            </object></comment><script>__ws__(__NSID__);</script> 
								</td>
						</tr>
						<tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;카드종류</td>
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_cacardspec classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;left:1px;top:3px" class="txtbox" >
										<param name=ComboDataID			value=gcds_card3>
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="CDNAM^0^100">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;관리소속</td>					  
                      <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;<comment id="__NSID__">
									<object  id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=150 style="position:relative;left:1px;top:3px" class="txtbox" >
										<param name=ComboDataID			value=gcds_dept1>
										<param name=SearchColumn		value="DEPTNMK">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="DEPTNMK^0^140">
										<param name=BindColumn			value="DEPTCD">
									</object></comment><script>__ws__(__NSID__);</script> 
                      </td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;거래처</nobr></td>               
											<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
											<input id="txt_vend_nm" class="txtbox" type="text" style="width:60px;position:relative;left:-5px;top:-2px" maxlength="8" onBlur="bytelength(this,this.value,8);">
											<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="거래처를 검색합니다" style="position:relative;left:-8px;top:3px;cursor:hand;" onclick="ln_Find2()">
										<input id="txt_vend_nm2" class="txtbox" type="text" style="width:70px;position:relative;left:-11px;top:-2px" maxlength="20"> 
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;발급년월</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_caissyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:1px;width:53px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM">
									<param name=PromptChar	  value="_">
									</object></comment><script>__ws__(__NSID__);</script> 
									<img src="../img/calender.gif" value="calender.gif" id=img_caissyymm OnClick="__GetCallCalendar('gcem_caissyymm', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;유효년월</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_causeyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:1px;width:53px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM">
									<param name=PromptChar	  value="_">
									</object></comment><script>__ws__(__NSID__);</script> 
									<img src="../img/calender.gif" value="calender.gif" id=img_causeyymm OnClick="__GetCallCalendar('gcem_causeyymm', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;결재일</td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
                  <object  id=gcem_casttdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:1px;width:20px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="DD">
									<param name=PromptChar	  value="">
									</object></comment><script>__ws__(__NSID__);</script> &nbsp;<font style="position:relative;left:-2px;top:-4px">일</font></nobr>
											</td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;결재은행</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_caaccbank" class="txtbox" type="text" style="width:35px;position:relative;left:-5px;top:-2px" maxlength="4" onBlur="bytelength(this,this.value,4);">
									<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="결재은행을 검색합니다" style="cursor:hand;position:relative;left:-8px;top:3px" onclick="ln_Popup();">
									<input id="txt_caaccbank1" class="txtbox" type="text" style="width:85px;position:relative;left:-11px;top:-2px" maxlength="30">
									</nobr>
											</td>
                    </tr>
                   <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;결재계좌번호</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_cabankno" class="txtbox" type="text" style="width:140px;position:relative;left:-5px" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;예금주</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_cacust" class="txtbox" type="text" style="width:110px;position:relative;left:-5px" maxlength="16" onBlur="bytelength(this,this.value,16);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;폐기일자</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_dsudt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:1px;width:70px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									</object></comment><script>__ws__(__NSID__);</script> 
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_dsudt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
											</td>
                    </tr>
										<tr>
											<td class="tab19" style="" bgcolor="#eeeeee" align=center >사용유무</td>
											<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" >&nbsp;
												<comment id="__NSID__">
												<object id=gcra_useyn2 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
													<param name=Cols		value="2">
													<param name=Format	value="Y^사용,N^미사용">
												</object></comment><script>__ws__(__NSID__);</script> 
											</td> 
										</tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;사원번호</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;"><nobr>&nbsp;
												<input id="txt_caempno" class="txtbox" type="text" style="width:50px;position:relative;left:-5px;top:-2px" maxlength="7" onBlur="bytelength(this,this.value,7);">
										<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="사원번호를 검색합니다" style="position:relative;left:-8px;top:3px;cursor:hand;" onclick="ln_Find()">
										<input id="txt_caempno1" class="txtbox" type="text" style="width:45px;position:relative;left:-11px;top:-2px" maxlength="20"></nobr>
											</td>
                    </tr>
										<!-- <tr>
                      <td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
                      </td>
                    </tr> -->
						</table>
								</TD>
							</tr>
				</table>
								</td>
               </tr>
             </table>
			 <table border=0 cellpadding=0 cellspacing=0 width=875>
								<tr><td height=10></td></tr>
							 <tr>
							  <td>&nbsp;조회건수 : <label id="lbl_search1"></label></td>
							 </tr>
			</table>
			</div>
			<!--= 환율관리 ================================================================================-->
			<div id="div_disp2" style="display:none">
			<table width="876" cellpadding="1" cellspacing="0" border="0">
				<tr><td height=5></td></tr>
				<tr>
					<td colspan=8 align=center>
						<table width="866" cellpadding="1" cellspacing="0" border="0" style='width:866px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; 통화코드&nbsp;&nbsp;</nobr></td>
				                <td style="border:0 solid #708090;border-right-width:1px;width:140px">
								<nobr>
									<comment id="__NSID__"><object  id=gclx_curr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=100 style="position:relative;left:5px;top:3px" class="txtbox" >
										<param name=ComboDataID			value=gcds_curr1>
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="CDNAM^0^100">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
									</td>
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; 기준일자&nbsp;&nbsp;</nobr></td>
								<td width="0" align=LEFT ><nobr>
									<comment id="__NSID__"><object  id=gcem_ref classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:5px;width:60px;height:20px;" onkeydown="if(event.keyCode==13) ln_Query2();">
													<param name=Text			value="">
													<param name=Alignment		value=0>
													<param name=Numeric			value=true>
													<param name=IsComma			value=false>
													<param name=MaxLength		value=8>
													<param name=MaxDecimalPlace	value=0>
													<param name=promptchar  value="________">
									</object></comment><script>__ws__(__NSID__);</script> 
									<!--img src="../img/calender.gif" value="calender.gif" id=img_ref OnClick="__GetCallCalendar('gcem_ref', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"-->&nbsp;<font style="position:relative;top:-4px">~</font>&nbsp;

									<comment id="__NSID__"><object  id=gcem_ref1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:5px;width:60px;height:20px;" onkeydown="if(event.keyCode==13) ln_Query2();">
													<param name=Text			value="">
													<param name=Alignment		value=0>
													<param name=Numeric			value=true>
													<param name=IsComma			value=false>
													<param name=MaxLength		value=8>
													<param name=MaxDecimalPlace	value=0>
													<param name=promptchar  value="________">
									</object></comment><script>__ws__(__NSID__);</script> 
									<!--img src="../img/calender.gif" value="calender.gif" id=img_ref1 OnClick="__GetCallCalendar('gcem_ref1', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"-->
									</nobr></td>
								<td width=100%>&nbsp;</td>
								<td><nobr>      
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Delete2()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Add2()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Save2()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Query2()"> 
									</nobr>
								</td>
							</tr>
						</table>
                </td>
              </tr>
              <tr>
					<td ALIGN=CENTER>

							<table width="866" cellpadding="1" cellspacing="0" border="0">
								<tr> 
									<td style="width:866" ALIGN=LEFT VALIGN=TOP>
										<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2  style="WIDTH: 580px; HEIGHT: 390px;border:1 solid #777777;display:block;" viewastext>
											<PARAM NAME="DataID"        VALUE="gcds_curr">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<param NAME="Fillarea"      VALUE="true">
											<param NAME="SortView"      VALUE="left">
                      <param name="IndWidth"      value="0">
											<PARAM NAME="Format"        VALUE=" 
                        <F> Name='통화'         ID=ERCODENM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center sort=true bgcolor=#f5f5f5</C> 
                        <F> Name='기준일자'			ID=ERSTDDAT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	Align=Center mask='XXXX/XX/XX' sort=true bgcolor=#f5f5f5</C> 
                        <C> Name='월말'         ID=ERMMLAST	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Right decao=5 sort=true</C> 
                        <C> Name='평균'	        ID=ERAVG		 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Right decao=5 sort=true</C> 
                        <C> Name='역사적'	      ID=ERHIS		 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Right decao=5 sort=true</C>
											  <C> Name='송금받을때'		ID=ERSED		 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left sort=true</C> 
                        <C> Name='송금보낼때'		ID=ERREV		 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left sort=true</C> 
                        <C> Name='매매기준율'		ID=ERSTD		 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Right decao=5 sort=true</C> 
                        <C> Name='현금팔때'     ID=ERCASED	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Right decao=5 sort=true</C> 
                        <C> Name='현금살때'			ID=ERCAREV	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Right decao=5 sort=true</C> 
                        <C> Name='대미교차환율'	ID=ERCRORAT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=105	Align=Right decao=5 sort=true</C>
																						
												">

										</object></comment><script>__ws__(__NSID__);</script> 
                  </td>
                  <td>

									<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:282px;height:392px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;통화코드</nobr></td>
                      <td Style="border:0 solid #708090;border-bottom-width:1px">&nbsp;<comment id="__NSID__">
									<object  id=gclx_ercode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=100 style="position:relative;left:1px;top:3px" class="txtbox" >
										<param name=ComboDataID			value=gcds_ercode1>
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="CDNAM^0^100">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;기준일자</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_erstddat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:3px;left:1px;width:60px;height:20px;">
													<param name=Text			value="">
													<param name=Alignment		value=0>
													<param name=Numeric			value=true>
													<param name=IsComma			value=false>
													<param name=MaxLength		value=8>
													<param name=MaxDecimalPlace	value=0>
													<param name=promptchar  value="________">
									</object></comment><script>__ws__(__NSID__);</script> 
									<!--img src="../img/calender.gif" value="calender.gif" id=img_erstddat OnClick="__GetCallCalendar('gcem_erstddat', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;"-->&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;송금받을때</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_ersed"  class="txtbox" type="text" style="width:100px;position:relative;left:-5" maxlength="13" onBlur="bytelength(this,this.value,13);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;송금보낼때</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_errev" class="txtbox" type="text" style="width:100px;position:relative;left:-5px" maxlength="66" onBlur="bytelength(this,this.value,66);">&nbsp;</nobr>
											</td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;매매기준율</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_erstd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;" > 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;현금팔때</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_ercased classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;" > 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;현금살때</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_ercarev classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;" > 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;대미교차환율</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_ercrorat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;"> 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;월말</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_ermmlast classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;" > 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;평균</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_eravg classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;" > 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;역사적(월초)</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_erhis classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:85px; height:20px; font-family:굴림; font-size:9pt;" > 
													<param name=Text			value="1234">
													<param name=Alignment		value=2>
													<param name=Numeric			value=true>
													<param name=IsComma			value=true>
													<param name=MaxLength		value=10>
													<param name=MaxDecimalPlace	value=5>
												</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
										<tr>
                      <td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
                      </td>
                    </tr>
									</table>
											</TD>
										</tr>
									</table>
								</td>
               </tr>
             </table>
						 <table border=0 cellpadding=0 cellspacing=0 width=875>
								<tr><td height=10></td></tr>
							 <tr>
							  <td>&nbsp;조회건수 : <label id="lbl_search2"></label></td>
							 </tr>
						</table>
						</div>
		  <!----------- 은행코드관리 ------------>
			<div id="div_disp3" style="display:none">
			<table width="876" cellpadding="1" cellspacing="0" border="0">
				<tr><td height=5></td></tr>
				<tr>
					<td colspan=8 align=center>

						<table width="866" cellpadding="1" cellspacing="0" border="0" style='width:866px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							
							<tr>
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; 은 행 명&nbsp;&nbsp;</nobr></td>
								<td width="0" align=LEFT ><nobr>
									<INPUT TYPE=TEXT ID=txt_bankname class="txtbox"  width=70 height=18 style="position:relative;left:5px" maxlength="30" onBlur="bytelength(this,this.value,30);" onkeydown="if(event.keyCode==13) ln_Query3();"></nobr></td>
                 <td width=100%>&nbsp;</td>
                                <td><nobr>      
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Delete3()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Add3()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Save3()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Query3()"> 
									</nobr>
								</td>
                </tr>
                       </table>
                 </td>
               </tr>
               <tr>
								<td ALIGN=CENTER>

							<table width="866" cellpadding="1" cellspacing="0" border="0">
								<tr> 
									<td style="width:866" ALIGN=LEFT VALIGN=TOP>
										<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp3 style="WIDTH: 580px; HEIGHT: 390px;border:1 solid #777777;display:block;" viewastext>
											<PARAM NAME="DataID"        VALUE="gcds_bank1">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<param NAME="Fillarea"      VALUE="true">
											<param NAME="SortView"      VALUE="Left">
                      <param name="IndWidth"      value="0">
											<PARAM NAME="Format"        VALUE="  
                        <F> Name='은행코드' ID=BANCOD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		Align=Center sort=true bgcolor=#f5f5f5</C> 
                        <C> Name='은행명'	ID=BANNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=150		Align=Left sort=true</C> 
                        <C> Name='은행약어'	ID=BANNA1		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Left sort=true</C> 
                        <C> Name='업체번호'	ID=COMCOD			HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center sort=true</C> 
                        <C> Name='FSD ID'		ID=DNSID1		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center sort=true</C> 
                        <C> Name='모계좌번호' ID=BANNUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	Align=Left sort=true</C> 
                        <C> Name='구분코드'		ID=GUBUN1			HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center sort=true</C> 
                        <C> Name='오픈상태'	ID=GUBUN2		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	Align=Center</C>
                        <C> Name='참조번호'	ID=FILERR		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  Align=Center sort=true</C>">
										</object></comment><script>__ws__(__NSID__);</script> 
                  </td>
                  <td>

									<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:282px;height:392px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;은행코드</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_bancod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="######">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;은행명</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_bannam"  class="txtbox" type="text" style="width:140px;position:relative;left:-5px" maxlength="30" onBlur="bytelength(this,this.value,30);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;은행약어</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_banna1" class="txtbox" type="text" style="width:110px;position:relative;left:-5px" maxlength="16" onBlur="bytelength(this,this.value,16);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;업체번호</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_comcod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="##########">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;FBS ID</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_dnsid1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="########">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;모계좌번호</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_bannum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:110px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="###############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;구분코드</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_gubun1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="##">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;오픈상태</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_gubun2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="##">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;참조번호</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
								<object  id=gcem_filerr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="##########">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
                      </td>
                    </tr>
									</table>
											</TD>
										</tr>
									</table>
								</td>
               </tr>
             </table>
			 <table border=0 cellpadding=0 cellspacing=0 width=875>
						<tr><td height=10></td></tr>
						 <tr>
						  <td>&nbsp;조회건수 : <label id="lbl_search3"></label></td>
						 </tr>
			</table>
			</div>
		<!---------- 은행계좌관리 ------------>
		<div id="div_disp4" style="display:none">
			<table width="876" cellpadding="1" cellspacing="0" border="0">
				<tr><td height=5></td></tr>
				<tr>
					<td colspan=8 align=center>

						<table width="866" cellpadding="1" cellspacing="0" border="0" style='width:866px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							
							<tr>
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; 은 행 명&nbsp;&nbsp;</nobr></td>
								<td width="0" align=LEFT ><nobr>
									<INPUT TYPE=TEXT ID=txt_account class="txtbox"  width=70 height=18 style="position:relative;left:5px" maxlength="30" onBlur="bytelength(this,this.value,30);" onkeydown="if(event.keyCode==13) ln_Query4();"></nobr></td>
                                <td width=100%>&nbsp;</td>
                                <td><nobr>      
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Delete4()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-65px" onClick="ln_Add4()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Save4()">
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-65px" onClick="ln_Query4()"> 
									</nobr>
								</td>
                            </tr>
                       </table>
                 </td>
               </tr>
               <tr>
								<td ALIGN=CENTER>

							<table width="866" cellpadding="1" cellspacing="0" border="0">
								<tr> 
									<td style="width:866" ALIGN=LEFT VALIGN=TOP>
										<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp4  style="WIDTH: 461px; HEIGHT: 390px;border:1 solid #777777;display:block;" viewastext>
											<PARAM NAME="DataID"        VALUE="gcds_acc">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<param NAME="Fillarea"      VALUE="true">
											<param NAME="SortView"      VALUE="Left">
                      <param name="IndWidth"      value="0">
											<PARAM NAME="Format"        VALUE=" 
												<F> Name='코드' ID=BANNA1 HeadAlign=Center HeadBgColor=#B9D4DC Width=55 Align=Center sort=true bgcolor=#f5f5f5</F>				
												<C> Name='코드1' ID=BANCOD		HeadAlign=Center HeadBgColor=#B9D4DC Width=55	Align=Center sort=true show=false</C>
												<C> Name='은행명' ID=BANNAM  HeadAlign=Center HeadBgColor=#B9D4DC Width=55 Align=Left sort=true show=false</C>
                        <C> Name='계좌번호'	ID=BNKNUM			HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  Align=Left sort=true</C> 
                        <C> Name='은행지점'	ID=BNKNAM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left sort=true</C> 
                        <C> Name='계좌명'	ID=ACCTNONM			HeadAlign=Center HeadBgColor=#B9D4DC Width=115	Align=Left sort=true</C> 
                        <C> Name='예금주'		ID=ACCTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=115	Align=Left sort=true</C> 
                        <C> Name='계정코드' ID=ATCODE		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center sort=true</C> 
                        <C> Name='원가코드'		ID=COSTCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center sort=true</C> 
                        <C> Name='담당자'	ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Left sort=true</C>
                        <C> Name='전화번호'	ID=TELNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left sort=true</C> 
                        <C> Name='팩스번호'	ID=FAXNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left sort=true</C> 
                        <C> Name='무선번호'		ID=HPNO 	HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left sort=true</C> 
                        <C> Name='개설일자' ID=OPENDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	Align=Center Mask='XXXX/XX/XX' sort=true</C> 
                        <C> Name='대표자'		ID=DIRECT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95	Align=Left</C> 
                        <C> Name='우편번호'	ID=CZIPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Center Mask='XXX-XXX' sort=true</C>
                        <C> Name='주소1'	ID=CADDR01		HeadAlign=Center HeadBgColor=#B9D4DC Width=220	Align=Left sort=true</C> 
                        <C> Name='주소2'	ID=CADDR02			HeadAlign=Center HeadBgColor=#B9D4DC Width=220	Align=Left sort=true</C> 
                        <C> Name='폐기일자'		ID=DELDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	Align=Center Mask='XXXX/XX/XX XX:XX' sort=true</C> 
                        <C> Name='폐기자' ID=DELNAME		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Left sort=true</C> 
                        <C> Name='등록일자'		ID=CRTDATE			HeadAlign=Center HeadBgColor=#B9D4DC Width=110	Align=Center Mask='XXXX/XX/XX XX:XX' sort=true</C> 
                        <C> Name='등록자'	ID=CRTNAME		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	Align=Left sort=true</C>
                        ">
										</object></comment><script>__ws__(__NSID__);</script> 
                  </td>
                  <td>

									<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:401px;height:392px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
										<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;은행코드</nobr></td>
                      <td colspan=3 Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_bancod2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="######">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;
										<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="은행명을 검색합니다" style="cursor:hand;position:relative;left:-8px;top:3px" onclick="ln_Popup1();">
											<input id="txt_bancod3" class="txtbox" type="text" style="width:100px;position:relative;left:-11px;top:-2px" maxlength="30">&nbsp;<input id="txt_banna2" type="hidden"></nobr>
											</td>
										</tr>
										<tr>
                     <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;계좌번호</nobr></td>  
                      <td Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_bnknum" class="txtbox" type="text" style="width:100px;position:relative;left:-5px" maxlength="15" onBlur="bytelength(this,this.value,15);">&nbsp;</nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;은행지점</td>
                      <td colspan=3 Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_bnknam" class="txtbox" type="text" style="width:100px;position:relative;left:-5px" maxlength="50" onBlur="bytelength(this,this.value,50);">&nbsp;</nobr>
											</td>
											</tr>
											<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;계좌명</td>
                      <td colspan=3 Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_acctnonm" class="txtbox" type="text" style="width:250px;position:relative;left:-5px" maxlength="32" onBlur="bytelength(this,this.value,32);">&nbsp;</nobr>
											</td>
                    </tr>
										<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;예금주</nobr></td>
                      <td colspan="3" Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_acctnm" class="txtbox" type="text" style="width:250px;position:relative;left:-5px" maxlength="32" onBlur="bytelength(this,this.value,32);">&nbsp;</nobr>
											</td>
											</tr>
											<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;계정코드</nobr></td>  
                      <td Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#######">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;원가코드</td>
                      <td  Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_costcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:1px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#####">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
											</td>
											</tr>
											<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;담당자</td>
                      <td  Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_empno" class="txtbox" type="text" style="width:50px;position:relative;left:-5px;top:-2px" maxlength="7" onBlur="bytelength(this,this.value,7);">
										<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="담당자를 검색합니다" style="position:relative;left:-8px;top:3px;cursor:hand;" onclick="ln_Find1()">
										<input id="txt_empnmk" class="txtbox" type="text" style="width:45px;position:relative;left:-11px;top:-2px" maxlength="20"></nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;전화번호</nobr></td>
                      <td Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_telno" class="txtbox" type="text" style="width:100px;position:relative;left:-5px" maxlength="14" onBlur="bytelength(this,this.value,14);">&nbsp;</nobr>
											</td>
											</tr>
											<tr>
											<td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;팩스번호</nobr></td>  
                      <td Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_faxno" class="txtbox" type="text" style="width:100px;position:relative;left:-5px" maxlength="14" onBlur="bytelength(this,this.value,14);">&nbsp;</nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;무선번호</td>
                      <td  Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_hpno" class="txtbox" type="text" style="width:100px;position:relative;left:-5px" maxlength="14" onBlur="bytelength(this,this.value,14);">&nbsp;</nobr>
											</td>
											</tr>
											<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;개설일자</td>
                      <td  Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
										<object  id=gcem_opendt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative;top:3px;left:1px;width:70px;height:20px;">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										</object></comment><script>__ws__(__NSID__);</script> 
											<img src="../img/calender.gif" value="calender.gif" id=img_opendt OnClick="__GetCallCalendar('gcem_opendt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">
                   &nbsp;</nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;대표자</nobr></td>
                      <td colspan="3" Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_direct" class="txtbox" type="text" style="width:80px;position:relative;left:-5px" maxlength="12" onBlur="bytelength(this,this.value,12);">&nbsp;</nobr>
											</td>
											</tr>
											<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;우편번호</nobr></td>  
                      <td colspan="3" Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
										<object  id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative;top:3px;left:1px;width:50px;height:20px;">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="000-000">
										<param name=PromptChar	  value="_">
										</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
										<img alt="우편번호를 조회합니다" style="position:relative;left:-8px;top:3px;cursor:hand" src='<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif'  onclick="ln_Popup2()">
											</td>
                    </tr>
                    <tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;주소1</td>
                      <td colspan="3" Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_caddr01" class="txtbox" type="text" style="width:300px;position:relative;left:-5px" maxlength="70" onBlur="bytelength(this,this.value,70);">&nbsp;</nobr>
											</td>
											</tr>
											<tr>
											<td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;주소2</td>
                      <td colspan="3" Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_caddr02" class="txtbox" type="text" style="width:300px;position:relative;left:-5px" maxlength="70" onBlur="bytelength(this,this.value,70);">&nbsp;</nobr>
											</td>
                    </tr>
										<tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;폐기일자</nobr></td>
                      <td Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_deldate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:105px;height:20px;position:relative;left:1px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Numeric       value=false>
														<param name=Format        value="0000/00/00 00:00">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script> 						
											<img src="../img/calender.gif" value="calender.gif" id=img_deldate OnClick="__GetCallCalendar('gcem_deldate', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;
								</nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;폐기자</nobr></td>  
                      <td Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_delname" class="txtbox" type="text" style="width:70px;position:relative;left:-5px" maxlength="10" onBlur="bytelength(this,this.value,10);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;등록일자</td>
                      <td  Style="height:29px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gcem_crtdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:105px;height:20px;position:relative;left:1px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Numeric       value=false>
														<param name=Format        value="0000/00/00 00:00">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script> 						
											<img src="../img/calender.gif" value="calender.gif" id=img_crtdate OnClick="__GetCallCalendar('gcem_crtdate', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;
									</nobr>
											</td>
                      <td style="height:29px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;등록자</td>
                      <td  Style="height:29px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_crtname" class="txtbox" type="text" style="width:70px;position:relative;left:-5px" maxlength="10" onBlur="bytelength(this,this.value,10);">&nbsp;</nobr>
											</td>
                    </tr><tr>
                      <td colspan=2 style="height:100%;border:0 solid #708090;">
                      </td>
                    </tr>
									</table>
											</TD>
										</tr>
									</table>
								</td>
               </tr>
             </table>
			<table border=0 cellpadding=0 cellspacing=0 width=875>
						<tr><td height=10></td></tr>
						 <tr>
						  <td>&nbsp;조회건수 : <label id="lbl_search4"></label></td>
						 </tr>
			</table>

    </td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-- 카드관리 -->
<comment id="__NSID__"><object  id=gcbn_card classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_card2>
	<param name=BindInfo  value='  
	<C>Col=CANBR                    Ctrl=gcem_canbr             Param=text</C>
	<C>Col=CADIV                    Ctrl=gcra_cadiv             Param=CodeValue</C>
	<C>Col=CACARDSPEC               Ctrl=gclx_cacardspec        Param=BindColVal</C>
	<C>Col=CADEPTCD                 Ctrl=gclx_cadeptcd          Param=BindColVal</C>
	<C>Col=VEND_CD                  Ctrl=txt_vend_nm            Param=Value</C>
	<C>Col=VEND_NM                  Ctrl=txt_vend_nm2            Param=Value</C>
	<C>Col=CAISSYYMM                Ctrl=gcem_caissyymm         Param=text</C>
	<C>Col=CAUSEYYMM                Ctrl=gcem_causeyymm         Param=text</C>
	<C>Col=CASTTDAT                 Ctrl=gcem_casttdat          Param=text</C>
	<C>Col=CAACCBANK                Ctrl=txt_caaccbank          Param=value</C>
	<C>Col=BANNA1                   Ctrl=txt_caaccbank1         Param=value</C>
	<C>Col=CABANKNO                 Ctrl=txt_cabankno           Param=value</C>
	<C>Col=CACUST                   Ctrl=txt_cacust             Param=value</C>
	<C>Col=DSUDT                    Ctrl=gcem_dsudt             Param=text</C>
	<C>Col=USE_TAG                  Ctrl=gcra_useyn2            Param=CodeValue</C>
	<C>Col=CAEMPNO                  Ctrl=txt_caempno            Param=value</C>
	<C>Col=EMPNMK                   Ctrl=txt_caempno1           Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 환율관리 -->
<comment id="__NSID__"><object  id=gcbn_disp2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_curr>
	<param name=BindInfo  value='  
	<C>Col=ERCODE                   Ctrl=gclx_ercode            Param=BindColVal</C>
	<C>Col=ERSTDDAT      	          Ctrl=gcem_erstddat          Param=text</C>
	<C>Col=ERSED                    Ctrl=txt_ersed              Param=value</C>
	<C>Col=ERREV                    Ctrl=txt_errev              Param=value</C>
	<C>Col=ERSTD                    Ctrl=gcem_erstd             Param=text</C>
	<C>Col=ERCASED                  Ctrl=gcem_ercased           Param=text</C>
	<C>Col=ERCAREV                  Ctrl=gcem_ercarev           Param=text</C>
	<C>Col=ERCRORAT                 Ctrl=gcem_ercrorat          Param=text</C>
	<C>Col=ERMMLAST                 Ctrl=gcem_ermmlast          Param=text</C>
	<C>Col=ERAVG                    Ctrl=gcem_eravg             Param=text</C>
	<C>Col=ERHIS                    Ctrl=gcem_erhis             Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 은행코드관리 -->
<comment id="__NSID__"><object  id=gcbn_disp3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_bank1>
	<param name=BindInfo  value='  
	<C>Col=BANCOD                   Ctrl=gcem_bancod             Param=text</C>
	<C>Col=BANNAM      	            Ctrl=txt_bannam              Param=value</C>
	<C>Col=BANNA1                   Ctrl=txt_banna1              Param=value</C>
	<C>Col=COMCOD                   Ctrl=gcem_comcod             Param=text</C>
	<C>Col=DNSID1                   Ctrl=gcem_dnsid1             Param=text</C>
	<C>Col=BANNUM                   Ctrl=gcem_bannum             Param=text</C>
	<C>Col=GUBUN1                   Ctrl=gcem_gubun1             Param=text</C>
	<C>Col=GUBUN2                   Ctrl=gcem_gubun2             Param=text</C>
	<C>Col=FILERR                   Ctrl=gcem_filerr             Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 은행계좌관리 -->
<comment id="__NSID__"><object  id=gcbn_disp4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_acc>
	<param name=BindInfo  value=" 
	<C>Col=BANCOD                   Ctrl=gcem_bancod2           Param=text</C>
	<C>Col=BNKNUM      	            Ctrl=txt_bnknum             Param=value</C>
	<C>Col=BNKNAM                   Ctrl=txt_bnknam             Param=value</C>
	<C>Col=ACCTNONM                 Ctrl=txt_acctnonm           Param=value</C>
	<C>Col=ACCTNM                   Ctrl=txt_acctnm             Param=value</C>
	<C>Col=ATCODE                   Ctrl=gcem_atcode            Param=text</C>
	<C>Col=COSTCD                   Ctrl=gcem_costcd            Param=text</C>
	<C>Col=EMPNO                    Ctrl=txt_empno              Param=value</C>
	<C>Col=TELNO                    Ctrl=txt_telno              Param=value</C>
	<C>Col=FAXNO                    Ctrl=txt_faxno              Param=value</C>
	<C>Col=HPNO                     Ctrl=txt_hpno               Param=value</C>
	<C>Col=OPENDT                   Ctrl=gcem_opendt            Param=text</C>
	<C>Col=DIRECT                   Ctrl=txt_direct             Param=value</C>
	<C>Col=CZIPCD                   Ctrl=gcem_czipcd            Param=text</C>
	<C>Col=CADDR01                  Ctrl=txt_caddr01            Param=value</C>
	<C>Col=CADDR02                  Ctrl=txt_caddr02            Param=value</C>
	<C>Col=DELDATE                  Ctrl=gcem_deldate           Param=text</C>
	<C>Col=DELNAME                  Ctrl=txt_delname            Param=value</C>
	<C>Col=CRTDATE                  Ctrl=gcem_crtdate           Param=text</C>
	<C>Col=CRTNAME                  Ctrl=txt_crtname            Param=value</C>
	<C>Col=BANNAM                   Ctrl=txt_bancod3            Param=value</C>
	<C>Col=EMPNMK                   Ctrl=txt_empnmk             Param=value</C>
	<C>Col=BANNA1                   Ctrl=txt_banna2             Param=value</C>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!--div class=page id="out_line" style="position:absolute; left:4; top:68; width:875; height:437;z-index:-1;">&nbsp;</div-->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
