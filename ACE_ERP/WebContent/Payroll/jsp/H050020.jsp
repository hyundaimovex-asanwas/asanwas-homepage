<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: h050020.html
+ 기 능 정 의	: 재택관리
+ 최 초 이 력	: 정영식
+ 변 경 이 력	: 정영식 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: h050020_s1 , h050020_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>
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
//get_cookdata();
//lfn_init();
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


  gcem_appdt.text=gcurdate.substring(0,4) + gcurdate.substring(5,7) ;

  /*
  ln_SetDataHeader()
	
	gcem_fr.text = gcurdate.substring(0,7) + "01";	//시작일자
	gcem_to.text = gcurdate;												//종료일자
	//gcem_empno_1.value = gusrid;									//사용자ID
	//txt_NAME.value	= gusrnm;											//사용자명

	ln_Query2();
  ln_Enable("F");

	gclx_closeyn.index=0;
	gclx_gubun.index=0;

	//SGNM.value="김진환";
  //txt_SGNID.value="1990098";
  */

  gclx_jtgb.index=0;
	gclx_gubun.index=0;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_s2?v_str1=" + gcem_appdt.text  // 급여년월
									 + "&v_str2=" + gcem_empno.text                                     // 사번
									 + "&v_str3=" + fn_trim(txt_empnmmk.value)                          // 성명
							  	 + "&v_str4=" + gclx_jtgb.bindcolval                                // 재택구분
								   + "&v_str5=" + gclx_gubun.bindcolval ;                             // 구분
  
	//prompt('',gcds_data.DataID);
	gcds_data.Reset(); 

}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Chk(){

  if(fn_trim(gcem_appdt.text)==""){
		alert("급여년월을 확인하십시요");
		return false;
	}

	if(gclx_gubun.bindcolval==""){
		alert("정규직, 계약직 구분을 확인하십시요");
		return false;
	}

  gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_s1?v_str1=" + gcem_appdt.text  // 급여년월
									 + "&v_str2=" + gclx_gubun.bindcolval;                             // 사번
	//prompt('',gcds_chk.DataID);
	gcds_chk.Reset(); 

	return true;

}


/******************************************************************************
	Description : 마감
******************************************************************************/
function ln_Close() {
  
	gcds_temp.clearAll();
  if(gcds_temp.countrow<1){
		var THeader = "APPDT:STRING(6)";
  	gcds_temp.SetDataHeader(THeader);							
	}

	gcds_temp.Addrow();
  gcds_temp.namevalue(gcds_temp.rowposition,"APPDT") =gcem_appdt.text ;
 
	if (gcds_temp.IsUpdated) {
		if (confirm("급여년월 "+gcem_appdt.text+" 마감 하시겠습니까?")){	
			gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_t4?";
			gctr_data2.Parameters = "v_str1="+gclx_gubun.bindcolval;
			gctr_data2.post();
		}	
	}
}


/******************************************************************************
	Description : 반영
******************************************************************************/
function ln_Update() {

  if(gcds_data.countrow<1){
		alert("인사정보에 반영할 데이터가 없습니다. 확인 바랍니다.");
		return;
	}

	if(gcds_data.namevalue(gcds_data.rowposition,"CLOSEYN")=="Y"){
		alert("이미 마감 되었습니다. 반영할 수 없습니다.");
		return;
	}
 
  
	gcds_temp.clearAll();
  if(gcds_temp.countrow<1){
		var THeader = "APPDT:STRING(6),EMPNO:STRING(7),JTGB:DECIMAL(1.0)";
  	gcds_temp.SetDataHeader(THeader);							
	}


  for(i=1;i<=gcds_data.countrow;i++){
		gcds_temp.Addrow();
		gcds_temp.namevalue(gcds_temp.rowposition,"APPDT")=gcds_data.namevalue(i,"APPDT");
		gcds_temp.namevalue(gcds_temp.rowposition,"EMPNO")=gcds_data.namevalue(i,"EMPNO");
		gcds_temp.namevalue(gcds_temp.rowposition,"JTGB")=gcds_data.namevalue(i,"JTGB");
	}
 
	if (gcds_temp.IsUpdated) {
		if (confirm("급여년월 "+gcem_appdt.text+" 재택 구분을 인사기본정보에 반영하시겠습니까?")){	
			gctr_data3.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_t5?";
			gctr_data3.Parameters = "v_str1="+gclx_gubun.bindcolval;
			gctr_data3.post();
		}	
	}
}



/******************************************************************************
	Description : 마감
******************************************************************************/
function ln_Create() { 
 
  //기존데이터 존재 하는지 체크 
	//마감이 안된 경우만 재생성 가능함.
	//마감이 된 경우는 어떤 경우라도 재생성 불가 //정규직, 계약직 구분하여 체크함.

	if(!ln_Chk()) return;

	gcds_temp.clearAll();
  if(gcds_temp.countrow<1){
		var THeader = "APPDT:STRING(6)";
  	gcds_temp.SetDataHeader(THeader);							
	}

	gcds_temp.Addrow();
  gcds_temp.namevalue(gcds_temp.rowposition,"APPDT") =gcem_appdt.text ;


	if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CLOSEYN")=="C"){
			alert("마감이 되었습니다. 전산팀에 문의합시시요.");
			return;
		}
		if (confirm("기존 "+gcem_appdt.text+ " 데이터가 존재합니다. 삭제 후 다시 생성하시겠습니까?")){	
				gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_t1?";
				gctr_pyo.Parameters = "v_str1="+gclx_gubun.bindcolval+",v_str2="+gusrid+",v_str3=ReNew";
				gctr_pyo.post();
		}
	}else{
		//신규생성 
		if (confirm("급여년월 "+gcem_appdt.text+" 데이터를 일괄 생성 하시겠습니까?")){	
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_t1?";
			gctr_pyo.Parameters = "v_str1="+gclx_gubun.bindcolval+",v_str2="+gusrid+",v_str3=New";
			gctr_pyo.post();
		}
	}
}



/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

  if(!ln_Chk()) return;

	if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CLOSEYN")=="C"){
			alert("마감이 되었습니다. 전산팀에 문의합시시요.");
			return;
		}
	}

	if (gcds_data.IsUpdated) {
		if (confirm("저장 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050020_t2?";
			gctr_data.post();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Valchk() {

  /*

	var row = gcds_data.rowposition;

	txt_SGDT.value = gcds_data.namevalue(row, "SGDT");
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("결재일 / 승인일이  처리 된 항목은  저장 할 수 없습니다."); 
		return false;
	}
	
	if (gcem_frdt.text == "") { 
		alert("정확한 신청 시작일을 입력해 주십시오."); 
		gcem_frdt.focus()
		return false;
	}

	if (gcem_todt.text == "") { 
		alert("정확한 신청 종료일을 입력해 주십시오."); 
		gcem_todt.focus()
		return false;
	}

	*/
	
	/**
	if (fn_trim(SGNM.value) == "") { 
		alert("정확한 결재자를 입력해 주십시오."); 
		SGNM.value ="";
		SGNM.focus()
		return false;
	}
	**/

	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
  /*

	if(!ln_Chk_Delete())return;
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
	  gcds_data.ClearAllMark();
		for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
				gcds_data.MarkRows(i,i);
			}
		}
		gcds_data.DeleteMarked();
		gctr_pyo.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050005_t1?v_str1=" + gcem_to.text+ "&v_str2=" + gcem_empno_1.text;
		
		gctr_pyo.post();
		ln_Query();
	}

	*/
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

  gcgd_pyo.GridToExcel("재택관리","",2);

 
}


/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Popup(gbn){

  
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	if(gbn=="1"){
	  if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
	}
	arrSend[0]="H050005";
	strURL = "../jsp/H030003_popup.jsp"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmmk.value = arrParam[0]; //성명
			
		} else {
			txt_empnmmk.value ="";			//성명
		}
	}
}

/******************************************************************************
	Description : enable / disable
******************************************************************************/
function ln_Enable(p){

/*
	if (p=="T"){
		//gcem_empno_1.enable = true;
		//txt_empnmk_1.disabled = false ;
		//txt_deptnm.disabled = false ;
		//txt_paygrdnm.disabled = false ;
		gclx_LAZCD.enable = true;	//휴가구분
		gcem_frdt.enable = true;
		gcem_todt.enable = true;
		txt_DTYREM.disabled = false ;

	}else if (p=="F") {
		//gcem_empno_1.enable = false;
		gcem_empno_1.ReadOnly = true;
		txt_empnmk_1.ReadOnly = true ;
		//txt_deptnm.disabled = true ;
		//txt_paygrdnm.disabled = true ;
    gclx_LAZCD.enable = false;	//휴가구분
	//	gcem_frdt.enable = false;
	//	gcem_todt.enable = false;
		txt_DTYREM.disabled = true ;
	}

	*/
}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){
  /*
		gcem_empno_1.text = "";
		txt_empnmk_1.value= "" ;
		txt_deptnm.value = "" ;
		txt_paygrdnm.value = "" ;
		gclx_LAZCD.bindcolval = "";	//휴가구분
		gcem_frdt.text = "";
		gcem_todt.text = "";
		txt_DTYREM.value = "" ;	

		*/
}

/******************************************************************************
	Description : 결재팝업
	Parameter :
******************************************************************************/
function ln_Submit(){
  /*
	var arrMst	= new Array();
	var arrDtl	= new Array();
	var m=0; //
	var cnt=0;
	var strFrdt="";
	var strTodt="";
	var yy="";
	var mm="";
	var dd="";
	var strFrtime="";
	var strTotime="";

	if(!ln_Chk_Submit()) return;
  
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			 arrMst[0]="HA4";                              //양식코드
			 arrMst[1]=gusrid;                             //기안자사번
			 arrMst[2]=fn_trim(gcds_data.namevalue(i,"DIVNM"))  //+" / "+gcds_data.namevalue(i,"DEPTNM"); //근무부서명
			 arrMst[3]=gcds_data.namevalue(i,"EMPNO");    //사번
			 arrMst[4]=gcds_data.namevalue(i,"PAYGRDNM"); //직위
			 arrMst[5]=gcds_data.namevalue(i,"EMPNMK");   //성명
			 break;
		}
  }

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			cnt+=1;
		}
	}
	arrMst[6]=cnt;                                      //휴일근무자 수 

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			strFrdt = gcds_data.namevalue(i,"FRDT");       //시작일
			yy = strFrdt.substring(0,4);
			mm = strFrdt.substring(4,6);
			dd = strFrdt.substring(6,8);
			arrDtl[0+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd);  

			strTodt = gcds_data.namevalue(i,"FRDT");       //종료일
			yy = strTodt.substring(0,4);
			mm = strTodt.substring(4,6);
			dd = strTodt.substring(6,8);
			arrDtl[1+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd); 

			arrDtl[2+m]=gcds_data.namevalue(i,"LAZFEENM"); //근태구분
			arrDtl[3+m]=gcds_data.namevalue(i,"DTYREM");   //신청사유
			arrDtl[4+m]=gcds_data.namevalue(i,"HLNO");    //근태번호
			m+=5;
		}
  }
	
	//기안호출
	//document.all("ifrm").src ="../../Person/html/GP_form.html";
	ifrm.ln_Popup('HA4',arrMst,arrDtl);

	*/
}



/******************************************************************************
	Description : 달력관련
  parameter   : 수정건의 경우 출발일은 key값이라서 수정 못하게 막음.
******************************************************************************/
function ln_Calendar(gbn){
  /*
	if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
		return false;
	}
	if(gbn=="fr"){
		__GetCallCalendar('gcem_frdt','Text');
	}else if(gbn=="to"){
		__GetCallCalendar('gcem_todt','Text');
	}
	*/
}

/******************************************************************************
	Description : 결재시체크
	Parameter :
******************************************************************************/
function ln_Chk_Submit(){
/*
	var cnt=0;
	_aa:
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"CLOSYN")!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"){
				alert("결재할 수 없습니다. 결재상태를 확인하십시요.");
				return false;
  		}
			cnt+=1;

			//근태의 경우 1인만 결재 가능...
			for(j=1;j<=gcds_data.countrow;j++){
				if(gcds_data.namevalue(j,"CHK")=="T"){
					if(gcds_data.namevalue(i,"EMPNO")!=gcds_data.namevalue(j,"EMPNO")){
						alert("동일한 사람만 결재 가능합니다.");
						return false;
						break _aa;
					}
				}
			}
		}
	}

	if(cnt==0){
		alert("결재할 대상을 선택하십시요.");
		return false;
	}
	return true;

	*/
}


/******************************************************************************
	Description : 삭제시 체크
	Parameter :   N-결재대기, R-회수, B-반송, H-회송 만 삭제가능함.
******************************************************************************/
function ln_Chk_Delete(){
 /*
	var cnt=0;
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(fn_trim(gcds_data.namevalue(i,"CLOSYN"))!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"&&gcds_data.namevalue(i,"CLOSYN")!="R"&&gcds_data.namevalue(i,"CLOSYN")!="B"&&gcds_data.namevalue(i,"CLOSYN")!="H"){
				alert("해당건은 삭제 할 수 없습니다.");
				return false;
  		}
			cnt+=1;
		}
	}

	if(cnt==0){
		alert("삭제할 대상을 선택하십시요.");
		return false;
	}
	return true;

	
	*/
}


/******************************************************************************
	Description : Dataset Head 설정 -  
  parameter   : 1 - 
	              2 - 
******************************************************************************/
function ln_SetDataHeader(){
/*
	if(gcds_data.countrow<1){
		var THeader = "APPDT:String(8),EMPNO:String(7),LAZCD:String(4),DEPTCD:String(4),PAYSEQ:String(4),"
								+ "FRDT:String(8),TODT:String(8),DTYREM:String(100),"
								+ "CLOSYN:String(1),SGDT:String(8),SGNID:String(7),AGRDT:String(8),AGRID:String(7),"
								+ "PAYDT:String(8),AMT:Decimal(7),DEPTNM:String(50), PAYGRDNM:String(30),EMPNMK:String(20),"
								+ "LAZFEENM:String(20),BEFYEAR:String(3),CURYEAR:String(3),USEYEAR:String(3),PAYYEAR:String(3),"
								+ "SGNM:String(20),AGNM:String(20),DIVNM:String(50),CHK:String(1),HLNO:STRING(14)";
		gcds_data.SetDataHeader(THeader);								//Header Set
	}

	*/
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
 <object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t1(I:USER=gcds_temp)">
</object>

 <object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t2(I:USER=gcds_data)">
</object>

<object id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t4(I:USER=gcds_temp)">
</object>

<object id=gctr_data3 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t5(I:USER=gcds_temp)">
</object>

</comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";

	

</script>








<!-- <script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>

	var row = gcds_data2.rowposition;

	if (txt_deptnm.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		txt_deptnm.value	= gcds_data2.namevalue(row,"DEPTNM");		//소속명
		MINORNM.value = gcds_data2.namevalue(row,"MINORNM");	    //직위
		txt_empnmk2.value	= gusrnm;																//성명	
	} else {
		txt_deptnm.value	= "";
		MINORNM.value = "";
		txt_empnmk2.value	= gusrnm;	
	}

</script>
 -->
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_pyo event=OnClick(Row,Colid)>
  /*
	if(Row>0){
	  gcem_empno_1.text = gcds_data.namevalue(Row, "EMPNO");
		if(fn_trim(gcds_data.namevalue(Row,"CLOSYN"))!=""&&gcds_data.namevalue(Row,"CLOSYN")!="N"&&gcds_data.namevalue(Row,"CLOSYN")!="R"&&gcds_data.namevalue(Row,"CLOSYN")!="B"&&gcds_data.namevalue(Row,"CLOSYN")!="H"){
			ln_Enable("F");
		}else{
      ln_Enable("T");
		}
	}
	*/
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_data2" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data2" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data3" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data3" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>



</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h050020_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <FONT SIZE="" COLOR=""> 반영 인사정보에 적용</FONT>&nbsp;
      <img src="../../Common/img/btn/com_b_banyoung.gif"   style="cursor:hand" onclick="ln_Update()">&nbsp;&nbsp;
		  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_finish.gif"  style="cursor:hand" onclick="ln_Close()">
		  <img src="../../Common/img/btn/com_b_create.gif"	style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>급여년월</nobr></td>
			<td width="210px" class="tab18"><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_appdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:1px;top:2px;width:50px;height:20px;" >
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_appdt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
			</td>
			<td width="80px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>사번</nobr></td>
			<td width="130px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
			<object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="0000000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=false>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td width="80px" align=center  class="tab18"  bgcolor="#eeeeee" ><nobr>성명</nobr></td>
			<td class="tab18" >&nbsp;
				<input id="txt_empnmmk" name="txt_empnmmk" type="text"  class="txtbox"  style= "position:relative;left:-5px;top:-2px;width:90px;height:20px;"  maxlength="20" onBlur="bytelength(this,this.value,20);" onkeydown="if(event.keyCode==13) ln_Query();">
			  <img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-5px;top:2px;" onclick="ln_Popup('0')" >
			</td> 
			</tr>

			<tr>
			<td width="80px"  bgcolor="#eeeeee" class="tab17" align=center><nobr>재택구분</nobr></td>
				<td class="tab19" style="width:140px;" align=center><nobr>&nbsp;
						<comment id="__NSID__">
						<object id=gclx_jtgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-20px;top:2px;" >
							<param name=CBData			    value="''^전체,0^근무,1^본사재택,2^금강산재택,3^고성재택,4^개성재택,5^도라산재택,6^현장재택">
							<param name=CBDataColumns	  value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORNM">
							<param name=Sort						value="FALSE">
							<param name=ListExprFormat	value="MINORNM^0^100">
							<param name=BindColumn			value="MINORCD">
							<param name=Enable          value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</nobr>
				</td> 
       <td width="80px"  bgcolor="#eeeeee" class="tab19" align=center><nobr>구분</nobr></td>
			 <td class="tab19" style="width:140px;" align=center colspan=3><nobr>&nbsp;
					<comment id="__NSID__">
					<object id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-20px;top:2px;" >
						<param name=CBData			    value="R^정규직,T^계약직">
						<param name=CBDataColumns	  value="MINORCD,MINORNM">
						<param name=SearchColumn		value="MINORNM">
						<param name=Sort						value="FALSE">
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value="MINORCD">
						<param name=Enable          value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</nobr>
			</td> 
		</tr>
	</table>

	<tr>
	<td COLSPAN=2>
<!-- 		<table>
			<tr>
			<td>
 -->				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
              <param name=SortView      value="Left">
							<param name="ColSizing"   value="true">
							<param name=MultiRowSelect	value=true>
							<param name="editable"    value="true">
							<PARAM NAME="Format"			VALUE="  
								
								<C> Name='급여년월'	  ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		  align=CENTER	sort= true Mask='XXXX/XX'   edit=none </C> 
								<C> Name='사번'	   		ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		  align=LEFT	  sort= true   edit=none </C>
								<C> Name='성명'				ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		  align=LEFT		sort= true   edit=none </C>
								<C> Name='재택구분'		ID=JTGB 		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 		align=LEFT		sort= true  EditStyle=Combo		Data='0:근무,1:본사재택,2:금강산재택,3:고성재택,4:개성재택,5:도라산재택,6:현장재택' BgColor=#ffffcc </C>
								<G> Name ='현재부서'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'    	  ID=CURDPT		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=LEFT    sort= true edit=none</C> 
								<C> Name='명'    	    ID=CURDTPNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=LEFT    sort= true edit=none</C> 
								</G>
								<G> Name='재택전부서' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	      ID=BEFDPT		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		  align=LEFT	sort= true  edit=none</C>
								<C> Name='명'	        ID=BEFDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		  align=LEFT	sort= true  edit=none</C>
								</G>
								<C> Name='재택후\\복귀'	ID=JTWK			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER	sort= true edit=none</C>
								<C> Name='마감'	      ID=CLOSEYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		  align=CENTER	sort= true EditStyle=Combo		Data='C:마감,N:진행중' edit=none</C>
								<C> Name='비고'		    ID=REMARK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=132		align=LEFT		BgColor=#ffffcc </C>
							">
            </object></comment><script>__ws__(__NSID__);</script>
			  </td>
			  </tr>
			 </table>

<!-- 			</td>
			
		 </td>
		 </tr>
		</table>
 -->
 </td>
 </tr>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
  </tr>	
</table>




<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>



