<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사고과관리 - 고과점수 입력
+ 프로그램 ID	:   H060004.html
+ 기 능 정 의	:   
+ 변 경 이 력	: 
+ 서 블 릿 명	:   h060004_s1, h060004_s2, hclcode_s1, h060004_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
/*******************************************************************************
Description :  전역변수
gstr_yyymm   -- 고과년월
gstr_empno   -- 사번
gstr_grpcd   -- 직급구분(과장이상/대리이하)
gstr_jobgrph -- 직군구분(기술직/사무직/영업직)
gstr_evaseq  -- 차수
gstr_gubun   --  UserStatus 구분 ( 1-insert, )
gstr_rowposition -- Row position
*******************************************************************************/
var gstr_yyymm, gstr_empno, gstr_grpcd, gstr_jobgrph, gstr_evaseq,gstr_gubun, gstr_rowposition, ASSES
get_cookdata();
lfn_init();

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	  //gcem_yymm.text = gcurdate.substring(0,7); 

    //2009.06.08 신규추가
    gcds_evaym.DataID = "/servlet/Person.hclcode_s1?v_str1=2063";
	  gcds_evaym.Reset();  

		gcem_yymm.text=gcds_evaym.namevalue(gcds_evaym.rowposition,"MINORNM");

		txt_empnoh.value = gusrid;
	  txt_empnmh.value = gusrnm;
    gcem_yymm.enable=false;
		
		//공통코드
		ln_Luxecombo_load();  
		gcra_gubun.CodeValue=1

		ln_Submit_St();
}

/******************************************************************************
	Description : 제출 상태 조회
******************************************************************************/
function ln_Submit_St(){
		gcds_submit2.DataID = "/servlet/Person.h060014_s6?v_str1="+gcem_yymm.text    //고과년월
		                                                        +"&v_str2="+txt_empnoh.value;	//고과자
    //prompt('',gcds_submit2.DataID);
	  gcds_submit2.Reset();  

		if(gcds_submit2.namevalue(gcds_submit2.rowposition,"SUBMITST")=="C"){
      txt_SubmitSt.value="제출";
		}else{
			txt_SubmitSt.value="미제출";
		}
}

/******************************************************************************
	Description : 조회 (피고과자정보)
******************************************************************************/
function ln_Query(){

    //본사
		gcds_data.DataID = "/servlet/Person.h060014_s1?v_str1="+gcem_yymm.text		//고과년월
														 +"&v_str2="+txt_empnoh.value	//고과자	
														 +"&v_str3="+txt_empnm.value	//피고과자
														 +"&v_str4="+gcra_gubun.CodeValue;	//정규직 계약직


		//prompt("",gcds_data.DataID);
		gcds_data.Reset(); 

		ln_Reset('q');

    //
		gcds_data5.DataID = "/servlet/Person.h060014_s5?v_str1="+gcem_yymm.text		//고과년월
														 +"&v_str2="+txt_empnoh.value	//고과자	
														 +"&v_str3="+txt_empnm.value	//피고과자
														 +"&v_str4="+gcra_gubun.CodeValue;	//정규직 계약직

		//prompt("",gcds_data.DataID);
		gcds_data5.Reset(); 

		ln_Reset('q');

		ln_Submit_St();
}

/******************************************************************************
	Description : 조회 (고과표  및 고과결과)
******************************************************************************/
function ln_Query2(){
		gcds_data2.DataID = "/servlet/Person.h060014_s2?v_str1="+gstr_yyyymm						//고과년월
                                                          +"&v_str2="+gstr_empno						//피고과자사번
																													+"&v_str3="+gstr_grpcd					   //직급(과장이상/대리이하)
																													//+"&v_str4="+gcra_divcd.CodeValue//부문(능력고과/직업고과)
																													+"&v_str5="+gstr_jobgrph		      //공통&(사무직or기술직or영업직)
																													+"&v_str6="+txt_empnoh.value			//고과자
																													+"&v_str7="+gstr_evaseq;					//차수
    //prompt("",gcds_data2.DataID);
		gcds_data2.Reset(); 
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

  if(gcem_yymm.text<'200906'){
		alert("해당 고과는 저장할 수 없습니다.");
		return;
	}

	 //기존에 완료 된 건은 더이상 제출 못하게함.
	 if(txt_SubmitSt.value=="제출"){
			alert("이미 제출되어 저장할 수 없습니다.");
			return;
	 }

  if (fn_trim(txt_empnoh.value)=="") {
		alert("고과자를 다시 선택해 주십시요");
		return; 
	}

	if (gcds_data2.countrow<1){
	alert ("저장할 정보가 없습니다.");
	}else {
		if(ln_Chk()){
			if (confirm("저장하시겠습니까?")) {
				ln_Datasave();
				gctr_data.action = "/servlet/Person.h060014_t1";
			//prompt("gcds_data2",gcds_data2.text);
				gctr_data.post();
				ln_Reset('r');
				ln_Query();
				ln_Query2();
			}
		}//if ln_Chk
	}
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
	alert("개발중입니다.");
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_data2.RunExcel('고과점수');
}


/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//부문
	gcds_divcd.DataID = "/servlet/Person.hclcode_s1?v_str1=2015"; 
	gcds_divcd.Reset();

}

/******************************************************************************
	Description : Insert Data 저장
	                   저장시   고과자, 피고과자,차수 저장
******************************************************************************/
function ln_Datasave(){

	for ( i=1;i<=gcds_data2.countrow;i++){
		if ((gcds_data2.SysStatus(i)==2)||(gcds_data2.SysStatus(i)==3)){
			gcds_data2.namevalue(i,"EMPNOH")=	fn_trim(txt_empnoh.value);
			gcds_data2.namevalue(i,"EMPNO")	=	gstr_empno;
			gcds_data2.namevalue(i,"EVASEQ")=	gstr_evaseq; 
		}
  }
}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){

	if (gcds_data2.IsUpdated){
		if(ln_Chk2()){
			return true;
			//alert("1");
		}else{
			return false;
			//alert("2");
		}
	}else{
		return false;
		//alert("3");
	}	
}

function ln_Chk2(){
	
	for (i=1;i<=gcds_data2.countrow;i++){
		if (gcds_data2.namevalue(i,"CHK01") == "F" && gcds_data2.namevalue(i,"CHK02") == "F"  
		 && gcds_data2.namevalue(i,"CHK03") == "F" && gcds_data2.namevalue(i,"CHK04") == "F" 
		 && gcds_data2.namevalue(i,"CHK05") == "F"){
			alert("모든 평가요소를 체크하십시요");
      gcds_data2.rowposition = i;
  		return false;
			break;
		}
	}
	return true;
}

/******************************************************************************
	Description : 고과자 지정 Grid 초기화
	parameter - q : query시   r -reset 초기화
******************************************************************************/
function ln_Reset(p){

	if(p=="r"){
		if (gcds_data2.countrow>=1){
			gcds_data2.ClearData();	 
		}else{
			alert("초기화 할 데이터가 존재하지 않습니다.");
		}
	}else if(p=="q"){
		if (gcds_data2.countrow>=1) gcds_data2.ClearData();
	}
}


/******************************************************************************
	Description : 보정계산
******************************************************************************/
function ln_Corcal(){

//	gcds_col.DataID = "/servlet/Person.h060014_p5?v_str1="+gcem_yymm.text		//고과년월
//														+"&v_str2="+txt_empnoh.value;	//고과자
//gcds_col.Reset();
}

/******************************************************************************
	Description : 사원조회
******************************************************************************/
function ln_FindEmp(e, row){
  if (gusrid!="1990098"&&gusrid!="2020008"&& gusrid!="6070001"&& gusrid!="2050045" && gusrid!="6080002" ) return;
  var result="";
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

/*
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

	if (gs_treecd.length!=0 && gs_level!=0){
		gs_treecd = fn_treecd(gs_level, gs_treecd);
		arrParam[0]=gs_level;  
		arrParam[1]=gs_treecd;
	}else {
		arrParam[0]='';  
		arrParam[1]='';
	}
*/  
	strURL = "./H060014_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:383px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

 	if (result != null) {
		arrResult = result.split(";");
		//eval(e).value  = arrResult[0];
   
		if (e=="txt_empnmh") {
		  txt_empnmh.value = arrResult[0];
			txt_empnoh.value = arrResult[1];

		}else if(e=="EMPNMKH"){
		  gcds_data2.namevalue(row,"EMPNMKH")= arrResult[0];
      gcds_data2.namevalue(row,"EMPNOH") = arrResult[1];			
		}
	} else {
		//eval(e).value = "";
		if (e=="txt_empnmh") {
		  txt_empnmh.value="";
			txt_empnoh.value ="";
		}
	}
}


/******************************************************************************
	Description : 고과점수조회
******************************************************************************/
function ln_Grid_Onclick(gubun,row){
  gstr_yyyymm ="";
	gstr_empno = "";
	gstr_grpcd = "";
	gstr_jobgrph = "";
	gstr_evaseq = "";

	if(gubun=="1"){
		gstr_yyyymm		= gcds_data.namevalue(row,"EVAYM");
		gstr_empno		= gcds_data.namevalue(row,"EMPNO");
		gstr_grpcd		= gcds_data.namevalue(row,"GRPCD");
		gstr_jobgrph	= gcds_data.namevalue(row,"JOBGRPH");
		gstr_evaseq		= gcds_data.namevalue(row,"EVASEQ");
		gstr_rowposition =	gcds_data.RowPosition;
	}else if(gubun=="5"){
		gstr_yyyymm		= gcds_data5.namevalue(row,"EVAYM");
		gstr_empno		= gcds_data5.namevalue(row,"EMPNO");
		gstr_grpcd		= gcds_data5.namevalue(row,"GRPCD");
		gstr_jobgrph	= gcds_data5.namevalue(row,"JOBGRPH");
		gstr_evaseq		= gcds_data5.namevalue(row,"EVASEQ");
		gstr_rowposition =	gcds_data5.RowPosition;
	}
	
	ln_Query2();
}



function ln_ASSES(){

	for (i=1;i<=gcds_data.countrow;i++){
   // alert(gcds_data.namevalue(i,"SCR"));
    
		if(gcds_data.NameValue(i,"SCR")>=85){
		  gcds_data.NameValue(i,"ASSES")="상";
    // alert(gcds_data.NameValue(i,"ASSES"));
		}else if(gcds_data.namevalue(i,"SCR")>=75&&gcds_data.namevalue(i,"SCR")<85){
      gcds_data.namevalue(i,"ASSES")="중상";
		}else if(gcds_data.namevalue(i,"SCR")>=65&&gcds_data.namevalue(i,"SCR")<75){
      gcds_data.namevalue(i,"ASSES")="중";
		}else if(gcds_data.namevalue(i,"SCR")>=55&&gcds_data.namevalue(i,"SCR")<65){
      gcds_data.namevalue(i,"ASSES")="중하";
		}else if (gcds_data.namevalue(i,"SCR")>=0&&gcds_data.namevalue(i,"SCR")<55){
		  gcds_data.namevalue(i,"ASSES")="하";
		
	
		}
	}

}


/******************************************************************************
	Description : 최종 제출
	              최출시 고과자 사번 9999999 로 update
								고과차수 임의 변경 함.
******************************************************************************/
function ln_Submit(){
alert("1");
	if(gcem_yymm.text<'200906'){
		alert("해당 고과는 제출할 수 없습니다.");
		return;
	}

 //기존에 완료 된 건은 더이상 제출 못하게함.
 if(txt_SubmitSt.value=="제출"){
 alert("2");
		alert("이미 제출 되었습니다.");
		return;
 }


 if(gcds_data.countrow==0&&gcds_data5.countrow==0){
 alert("3");
	  alert("피고과자가 존재하지 않습니다.");
		return;
 }

//피고과자를 하나라도 입력하지 않을 경우 제출 못하게 체크함.
	for(i=1;i<=gcds_data.countrow;i++){
	alert("4");
		if(gcds_data.namevalue(i,"SCR")==0){
	alert("5");
			alert("본사소속 고과점수 입력이 완료 되지 않았습니다.::");
			return;
		}	
	}

	for(j=1;j<=gcds_data5.countrow;5++){
	alert("6");
		if(gcds_data5.namevalue(i,"SCR")==0){
		alert("7");
			alert("본사외소속 고과점수 입력이 완료 되지 않았습니다.::");
			return;
		}	
	}

	//메세지로 한 번 더 체크  한 번 제출하면 더 이상 수정 불가 함.
	if(confirm("제출 후 수정은 불가합니다. 제출 하시겠습니까?")){
alert("8");
	   ln_SetDataHeader();
     gcds_submit.Addrow(); 

		 gcds_submit.namevalue(gcds_submit.rowposition,"EVAYM")=gcem_yymm.text;
     gcds_submit.namevalue(gcds_submit.rowposition,"EMPNOH")=txt_empnoh.value;
		 gcds_submit.namevalue(gcds_submit.rowposition,"EMPNO")=gusrid;

		 gctr_data2.action = "/servlet/Person.h060014_t2";
     //gctr_data.Parameter = "v_str1='"+gcem_yymm.text+"',v_str2='"+txt_empnoh.value;
		 gctr_data2.post();

	}else{
		return; 
	}

//저장 update (넘기는 데이터 - 고과년월, 피고과자만을 키로 해서 모든 고과자를 9999999, 차수는 임의로 변경) 

}



/******************************************************************************
	Description : 최종 제출
	              최출시 고과자 사번 9999999 로 update
								고과차수 임의 변경 함.
******************************************************************************/
function ln_SetDataHeader(){
  //업적신고MST
  gcds_submit.clearAll();

	if (gcds_submit.countrow<1){
		var s_temp = " EVAYM:STRING(6),EMPNOH:STRING(7),EMPNO:STRING(7)";   //고과년월, 고과자, 로그인 사용자 ( 피고과자 아님)
	  gcds_submit.SetDataHeader(s_temp);
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--본사-->
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--본사외-->
<comment id="__NSID__"><OBJECT id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--고과부문-->
<comment id="__NSID__"><object id="gcds_divcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
  <object id="gcds_submit" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
	<OBJECT id=gcds_evaym classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true"><!-- 고과년월 -->
	</OBJECT>

	<object id="gcds_submit2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--보정계산-->
<!--<comment id="__NSID__"><OBJECT id=gcds_col classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<!--	<PARAM NAME="SyncLoad" VALUE="true">
<!--</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060004_t1(I:USER=gcds_data2)">
  </object>

  <object id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060004_t2(I:USER=gcds_submit)">
  </object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	//if (rowcount ==0 )	alert("검색된 데이타가 없습니다."); 


  ln_ASSES(); //평가

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
	gcds_data.RowPosition=gstr_rowposition;
</script>

<script language=JavaScript  for=gcds_data5 event=OnLoadCompleted(rowcount)>
	lbl_search5.innerText = "총 ( " + rowcount + " ) 건";
	gcds_data5.RowPosition=gstr_rowposition;
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	//if (rowcount ==0 )	alert("검색된 데이타가 없습니다."); 

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
	gcds_data.RowPosition=gstr_rowposition;
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	lbl_search2.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
</script>

<script language=JavaScript  for=gcds_col event="OnLoadStarted()" >
	window.status="보정계산 중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_col event=OnLoadCompleted(rowcount)>
	window.status="보정계산이 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount==0) { 
		alert("보정계산 되지 않았습니다.");
	}else{
		if(gcds_col.namevalue(1, "RETCOD") =="Y"){
			alert("정상적으로 보정계산 되었습니다.");
			ln_Query();
      ln_Query2();
		}else if (gcds_col.namevalue(1, "RETCOD") =="N"){
			alert("정상적으로 보정계산 되지 않았습니다.");
		}	
	}
</script>


<script language="javascript"	for="gcgd_data2" event="OnClick(row,col)">
	
	if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK01") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK02") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK03") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK04") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK05") = "F";

		if ("CHK01" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK01") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "1";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"ESCR");
		}else if ("CHK02" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK02") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "2";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"GSCR");
		}else if ("CHK03" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK03") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "3";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"MSCR");
		}else if ("CHK04" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK04") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "4";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"LSCR");
		}else if ("CHK05" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK05") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "5";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"PSCR");
		}
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_data event=OnClick(Row,Colid)>
	ln_Grid_Onclick('1',Row);
</script>

<script language="javascript"  for=gcgd_data5 event=OnClick(Row,Colid)>
	ln_Grid_Onclick('5',Row);
</script>

<!--<script language=JavaScript for=gcra_divcd event=OnSelChange()>
	if (gcds_data.rowposition<1) return;
		gstr_yyyymm		=	"";
		gstr_empno		= "";
		gstr_grpcd		= "";
		gstr_jobgrph	= "";
		gstr_evaseq		= "";

		gstr_yyyymm		= gcds_data.namevalue(gcds_data.rowposition,"EVAYM");
		gstr_empno		= gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
		gstr_grpcd		= gcds_data.namevalue(gcds_data.rowposition,"GRPCD");
		gstr_jobgrph	= gcds_data.namevalue(gcds_data.rowposition,"JOBGRPH");
		gstr_evaseq		= gcds_data.namevalue(gcds_data.rowposition,"EVASEQ");
		
		gstr_rowposition =gcds_data.RowPosition;
		ln_Query2();
</script>-->

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
    alert("저장에 성공하였습니다");
</script>

<script language=JavaScript for=gctr2_data event=OnFail()>
   alert("Error Code : " + gctr2_data.ErrorCode + "\n" + "Error Message : " + gctr2_data.ErrorMsg + "\n");
</script>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>



<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h060014_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
		   <FONT SIZE="2" COLOR="#3300FF" style="position:relative;top:-6px">고과점수 입력 후 최종 [제출]하셔야 합니다.</FONT>
			<!--<img src="../../Common/img/btn/com_b_cor.gif"		style="cursor:hand;"  onclick="ln_Corcal()">-->
			<img src="../../Common/img/btn/com_b_submit.gif" style="cursor:hand"		onclick="ln_Submit()">
			<img src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand"		onclick="ln_Excel()">
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand"		onclick="ln_Print()"> -->
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand"		onclick="ln_Query()">&nbsp;
		</td>
  </tr>
	<tr>
		<td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'></td>
				<tr>
						<td width="10"   style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;고과년월&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp
								<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
								style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; "> 
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
						</td>
						<td width="0" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;고과자&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<input  id="txt_empnmh" name="txt_name" type="text" style="position:relative; left:-8px;top:-2px; width:60px; size=20"  class="txt21" disabled>
							</nobr>
							<img src="../../Common/img/btn/com_b_find.gif" alt="고과자를 검색합니다" style="position:relative;left:-9px;top:2px;cursor:hand;" onclick="ln_FindEmp('txt_empnmh','')">
							<input type="hidden" width="0" id="txt_empnoh">
						</td>
						<td width="0" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;피고과자&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;"><nobr>&nbsp;
							<input  id="txt_empnm" name="txt_name" type="text"  style="position:relative; left:-8px; width:100px; size=20" class="txt21" onkeydown="if(event.keyCode==13) ln_Query();"> </nobr>
						</td>
						<td width="150px" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;구분&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;" ><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcra_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:20; width:130">
						  <param name=Cols	value="2">
			        <param name=Format	value="1^정규직,2^계약직">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
						<td width="0" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;제출상태&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;"><nobr>&nbsp;
							<input  id="txt_SubmitSt" name="txt_SubmitSt" type="text"  style="position:relative; left:-8px; width:50px; size=20" class="txt21" disabled > </nobr>
						</td>
						<td width="100%" align=RIGHT><nobr>&nbsp;</nobr></td>
				</tr>
			</table> 
		</td>
	</tr>
	<tr><td height=3 colspan="2"></td></tr>

	<tr> 
		<td colspan=2>
			<table width="876" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:373px;" align=center valign=top>
							<table width="373px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:373px" align=LEFT valign=top  border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data  style="WIDTH: 370px;; HEIGHT: 215px;border:1 solid #777777;z-index:2;" viewastext>
												<param name="DataID"		    value="gcds_data">
												<param name="Editable"      value="false">
												<param name="BorderStyle"   value="0">  
												<param name="Fillarea"		  value="true">
												<param name=ColSelect       value=false>
												<param name=ViewSummary	    value=1>      
												<param name=IndWidth        value="0">
												<param name="Format"			  value="  
													<FC> Name='고과년월'	ID=EVAYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center mask='XXXX/XX' SumText=평균 sumbgcolor=#89add6  BgColor='#f5f5f5'  show=false</FC>
													<FC> Name='피고과자'	ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		show=false</FC>
													<FC> Name='소속'			ID=DEPTCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left   show=false </FC>
													<FC> Name='본사:소속'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<FC> Name='직위'			ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left		show=false</FC>
													<FC> Name='직위'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=left   sumbgcolor=#89add6  BgColor='#f5f5f5' SumText='평 균'</FC>
													<FC> Name='피고과자'	ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<C> Name='점수'				ID=SCR			HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right	SumText={Round(avg(SCR),2)}  	    sumbgcolor=#89add6</C>
  												<C> Name='평가'				ID=ASSES		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=center sumbgcolor=#89add6  value=''</C>
													<C> Name='고과그룹'		ID=GRPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show=false</C>
													<C> Name='고과그룹'		ID=GRPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show= false </C>

												 <C> Name='보정'				ID=AVGSCR		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right SumText={Round(avg(AVGSCR),1)} 		sumbgcolor=#89add6 show= false</C>  
											"> 
											</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>
						 </table>
						</td>

						<td style="width:500px;" align=center valign=top rowspan=2>
							<table width="500px" cellpadding="0" cellspacing="0" border="0">
							  <tr><td height=5></td></tr>
								<tr>
									<!-- <td width="500px" align=RIGHT><nobr>&nbsp;</nobr></td> -->
									<td style="height:30px;border:0"  ALIGN=RIGHT><nobr>
										<img src="../../Common/img/btn/com_b_reset.gif" style="cursor:hand"  onclick ="ln_Reset('r')" >
										<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand"  onclick="ln_Save()">&nbsp;</nobr></td>
								</tr>
								<tr> 
									<td style="width:500px" align=LEFT valign=top   border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH: 499px; HEIGHT: 389px;border:1 solid #777777;z-index:2;border-TOP-width:1px;" viewastext>
												<PARAM NAME="DataID"			VALUE="gcds_data2">
												<PARAM NAME="Editable"    VALUE="false">
												<PARAM NAME="BorderStyle" VALUE="0">
												<param name=ViewSummary	  value=1>
												<param name="Fillarea"		VALUE="true">
												<param name=IndWidth      value="0">
												<PARAM NAME="Format"			VALUE="  
												<C> Name='직군'			ID=JOBGRPH	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=RIGHT		Edit=none  show=false  </C>   
												<C> Name='직군'			ID=JOBGRPNM HeadAlign=Center HeadBgColor=#B9D4DC Width=45		align=left		Edit=none  show=false SumText=합계 sumbgcolor=#89add6 </C>   
												<C> Name='항목구분' ID=GRPITEM	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=RIGHT		Edit=none  show=false</C>  
												<C> Name='항목구분' ID=GRPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=95		align=left		Edit=none  show=false sumbgcolor=#89add6</C> 
												<C> Name='구분'     ID=DIVNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center		Edit=none  sumbgcolor=#89add6</C> 
												<C> Name='순번'			ID=PRTSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=38		align=Center		Edit=none  sumbgcolor=#89add6</C>
												<C> Name='평가요소'	ID=ASKITEM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		Edit=none  sumbgcolor=#89add6 SumText='합 계'</C>
											<G>Name='등   급' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=200
												<C> Name='탁월'			ID=CHK01		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='우수'			ID=CHK02		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='보통'			ID=CHK03		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='부족'			ID=CHK04		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='문제'			ID=CHK05		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
											</G>
												<C> Name='점수'			ID=SCR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=RIGHT		Edit=none  SumText=@sum  sumbgcolor=#89add6</C> ">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>
						 </table>
						</td>
					</tr>

					<tr> 
						<td style="width:373px;" align=center valign=top >
							<table width="373px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:373px" align=LEFT valign=top  border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data5  style="WIDTH: 370px;; HEIGHT: 205px;border:1 solid #777777;z-index:2;" viewastext>
												<param name="DataID"		    value="gcds_data5">
												<param name="Editable"      value="false">
												<param name="BorderStyle"   value="0">  
												<param name="Fillarea"		  value="true">
												<param name=ColSelect       value=false>
												<param name=ViewSummary	    value=1>      
												<param name=IndWidth        value="0">
												<param name="Format"			  value="  
													<FC> Name='고과년월'	ID=EVAYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center mask='XXXX/XX' SumText=평균 sumbgcolor=#89add6  BgColor='#f5f5f5'  show=false</FC>
													<FC> Name='피고과자'	ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		show=false</FC>
													<FC> Name='소속'			ID=DEPTCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left   show=false </FC>
													<FC> Name='본사외:소속'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<FC> Name='직위'			ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left		show=false</FC>
													<FC> Name='직위'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=left   sumbgcolor=#89add6  BgColor='#f5f5f5' SumText='평 균'</FC>
													<FC> Name='피고과자'	ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<C> Name='점수'				ID=SCR			HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right	SumText={Round(avg(SCR),2)}			sumbgcolor=#89add6</C>
												
													<C> Name='평가'				ID=ASSES		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=center sumbgcolor=#89add6 value=''</C>
													<C> Name='고과그룹'		ID=GRPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show=false</C>
													<C> Name='고과그룹'		ID=GRPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show= false </C>
												<C> Name='보정'				ID=AVGSCR		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right  SumText={Round(avg(AVGSCR),1)}	sumbgcolor=#89add6  show= false</C> 
											">
											</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>	
						 </table>
						</td>
					</tr>
					<tr>
						<td height="24"  style="width:380px">본사건수 : <label id="lbl_search"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;본사외건수 : <label id="lbl_search5"></label></td>
						<td height="24"  style="width:500px">조회건수 : <label id="lbl_search2"></label></td>
					</tr>	
			</table>
		</td>
	<tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	