<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여-공조회비대출관리
+ 프로그램 ID	: p050018.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제|실행(개인의 대출을 대출표에서 가져와 생성한다.)
+ 변 경 이 력	: 
+ 수 정 이 력	: 이동훈
+ 수 정 이 력	: 이동훈 2011.03.02 
+ 서 블 릿 명	: p050018_s1, p050018_t1
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>공조회비대출관리</title>
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
var gs_level;
var gs_treecd;
var gstrChk =""; //등록

//get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


   ln_Before();

}

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Before(){

		gcem_curdt.text = gs_date2;

		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_s1?v_str1=" + txt_empnmk.value
																								+ "&v_str2=" + gcem_curdt.text;

		gcds_data.Reset(); 



}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_s1?v_str1=" + txt_empnmk.value
																								+ "&v_str2=" + gcem_curdt.text;

	 gcds_data.Reset(); 

	 ln_Enable("f");

	 gstrChk="";

}

/******************************************************************************
	Description : 조회 - Detail
******************************************************************************/
function ln_Query2(){

	gcds_detail.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_s1?v_str1=" + txt_empnmk.value  + "&v_str3=" + gcem_empno.text;

	gcds_detail.Reset(); 

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gstrChk="";

	ln_Enable("t")

	gcds_data.addrow();


}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {

		if(ln_Chk(gclx_exe.bindcolval)){

			if(ln_Valchk()){

				if (confirm("저장하시겠습니까?")) {

					gcds_temp.ClearData();

					var row = gcds_temp.rowposition;

					var THeader = "EMPNO:STRING(7),APPDT:STRING(8),APLDT:STRING(8),"
											+ "APPAMT:DECIMAL(9),REASON:STRING(50),EXE:STRING(1)";

					gcds_temp.SetDataHeader(THeader);

					for(i=1;i<=gcds_data.countrow;i++) {
						if (gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==2){

							gcds_temp.addrow();
							gcds_temp.namevalue(1,"EMPNO")  = gcds_data.namevalue(i,"EMPNO");		
							gcds_temp.namevalue(1,"APPDT") = gcds_data.namevalue(i,"APPDT");	
							gcds_temp.namevalue(1,"APLDT") = gcds_data.namevalue(i,"APLDT");	
							gcds_temp.namevalue(1,"APPAMT") = gcds_data.namevalue(i,"APPAMT");	
							gcds_temp.namevalue(1,"REASON") = gcds_data.namevalue(i,"REASON");	
							gcds_temp.namevalue(1,"EXE") = gcds_data.namevalue(i,"EXE");	

							gctr_data.KeyValue = "p050018_t1(I:USER=gcds_temp)";
							gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t1";
							gctr_data.post();
							ln_Query();
						}

						if (gcds_data.SysStatus(i)==3){

							gctr_data.KeyValue = "p050018_t1(I:USER=gcds_data)";
							gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t1";
							gctr_data.post();
							ln_Query();

						}

					}

				}

			}//if ln_Valchk

		}//if ln_Chk

	}

}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(e){

	if(e == "0"){
			if (gclx_exe.bindcolval == '0') {
				ln_SaveExe2();
				return false; 
			}else {		
				return false; 
			}
	}else{
			if (gclx_exe.bindcolval == '1') {
				ln_SaveExe();
				return false; 
			}else {		
				return false; 
			}
	}


}

/******************************************************************************
	Description : 실행
******************************************************************************/
function ln_Run(){

	var THeader = "EMPNO:STRING(7),APPDT:STRING(8),APLDT:STRING(8),APLCNT:DECIMAL(3),APPAMT:DECIMAL(9),"
							+ "APBAMT:DECIMAL(9),APLAMT:DECIMAL(9),APJAMT:DECIMAL(9),RATAMT:DECIMAL(9),CALAMT:DECIMAL(9),"
							+ "REPDT:STRING(8),REPYN:CHAR(1),AMT_1:DECIMAL(9),REASON:STRING(50)";

	gcds_detail.SetDataHeader(THeader);

	for(j=1;j<=36;j++) {
		
		gcds_detail.addrow();
		
		if (j!=36) {
				gcds_detail.namevalue(j,"EMPNO")  = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");			//사번
				gcds_detail.namevalue(j,"APPDT") = gcds_data.namevalue(gcds_data.rowposition,"APPDT");				//대출일자
				gcds_detail.namevalue(j,"APPAMT") = gcds_data.namevalue(gcds_data.rowposition,"APPAMT");			//대출금액
				gcds_detail.namevalue(j,"REASON") = gcds_data.namevalue(gcds_data.rowposition,"REASON");			//대출사유
				
				gcds_detail.namevalue(j,"APLCNT") = j;                                    //상환횟수

				if (j==1){
					gcds_detail.namevalue(j,"APLDT") = gcds_data.namevalue(gcds_data.rowposition,"APLDT");			//상환일자
				}else{
					gcds_detail.namevalue(j,"APLDT") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDT"));					//상환일자
				}

				gcds_detail.namevalue(j,"APLAMT") =  Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/36));	  //상환원금
	 
				if (j==1){

					gcds_detail.namevalue(j,"APBAMT") = ln_Apbamt(j,gcds_detail.namevalue(j,"APPAMT"),0);     //상환전잔액
					gcds_detail.namevalue(j,"APJAMT") = ln_Apjamt(gcds_detail.namevalue(j,"APPAMT"),gcds_detail.namevalue(j,"APLAMT"));     //상환후잔액
					gcds_detail.namevalue(j,"CALAMT") = Math.floor((gcds_detail.namevalue(j,"APBAMT")*0.04)/12) + ln_Calamt(gcds_detail.namevalue(j,"APPAMT"), gcds_detail.namevalue(j-1,"APPDT") );     //최초의 대출 이자를 만든다. 여기까진 다 제대로 들어갔네.

				}else{

					gcds_detail.namevalue(j,"APBAMT") = ln_Apbamt(j,gcds_detail.namevalue(j-1,"APBAMT"),gcds_detail.namevalue(j-1,"APLAMT"));     //상환전잔액
					gcds_detail.namevalue(j,"APJAMT") = ln_Apjamt(gcds_detail.namevalue(j-1,"APJAMT"),gcds_detail.namevalue(j-1,"APLAMT") );	//상환후 잔액
					gcds_detail.namevalue(j,"CALAMT") = Math.floor((gcds_detail.namevalue(j-1,"APJAMT")*0.04)/12);											//정산이자잖아.

				}//j==1 여기서 끝 -_-;;;

				gcds_detail.namevalue(j,"APLDT") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDT"));							//상환일자
				gcds_detail.namevalue(j,"RATAMT") = Math.floor((gcds_detail.namevalue(j,"APBAMT")*0.04)/12);

				var amt_01 = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/36));						//상환원금
				var amt_02 = Math.floor(gcds_detail.namevalue(j,"CALAMT"));

				gcds_detail.namevalue(j,"AMT_1")  = amt_01+amt_02;																	//상환액


		}else{ // j==36 마지막에는 잔금등을 따로 처리해준다.

			gcds_detail.namevalue(j,"EMPNO")  = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");		 //사번
			gcds_detail.namevalue(j,"APPDT") = gcds_data.namevalue(gcds_data.rowposition,"APPDT");			//대출일자
			gcds_detail.namevalue(j,"APPAMT") = gcds_data.namevalue(gcds_data.rowposition,"APPAMT");		//대출금액
			gcds_detail.namevalue(j,"REASON") = gcds_data.namevalue(gcds_data.rowposition,"REASON");		//대출사유
			gcds_detail.namevalue(j,"APLCNT") = j;																				//횟수
			
			gcds_detail.namevalue(j,"APLDT") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDT"));					//상환일자

			var appamt_eja = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/36));
			var appamt_won = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")));
			var appamt_jan = Math.floor((gcds_data.namevalue(gcds_data.rowposition,"APPAMT")/36))*36;
	
			gcds_detail.namevalue(j,"APBAMT") = appamt_eja+(appamt_won-appamt_jan);								//상환전 잔액
			gcds_detail.namevalue(j,"APJAMT") = 0;																					//상환후 잔액 다 털었다.
			gcds_detail.namevalue(j,"APLAMT") =  appamt_eja+(appamt_won-appamt_jan);								//상환원금	맞고...

			gcds_detail.namevalue(j,"APLDT") = ln_Aplday(j,gcds_detail.namevalue(j-1,"APLDT"));								//상환일자
			gcds_detail.namevalue(j,"RATAMT") = Math.floor((gcds_detail.namevalue(j,"APBAMT")*0.04)/12);				//상환이자
			gcds_detail.namevalue(j,"CALAMT") = Math.floor(((appamt_eja+(appamt_won-appamt_jan))*0.04)/12);				//상환이자

			var amt_01 = gcds_detail.namevalue(j,"APLAMT")												//상환원금
			var amt_02 = Math.floor(gcds_detail.namevalue(j,"CALAMT"));								//상환이자

			gcds_detail.namevalue(j,"AMT_1")  = amt_01+amt_02;										//상환액

		}

	}//FOR              

}

/******************************************************************************
	Description : 저장2
******************************************************************************/
function ln_SaveDetail(){

	if (gcds_detail.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {

		var str1 = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");

		if (confirm("저장하시겠습니까?")) {

			gctr_data.KeyValue = "p050018_t2(I:USER=gcds_detail)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t2?v_str1"+str1;
			gctr_data.post();

		}
	}
}

/******************************************************************************
	Description : 저장3
******************************************************************************/
function ln_SaveRep(){

		var str1 = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");

		if (fn_trim(gcem_repdt.text)!= "" && gclx_repyn.bindcolval == 'Y') {			

					if (confirm("중도상환하는것이 맞습니까?")) {

						if(gcds_data.namevalue(gcds_data.rowposition,"APLCNT") != "1") {                                   //상환횟수
							gcds_temp.ClearData();
							var row = gcds_temp.rowposition;
							var THeader = "EMPNO:STRING(7),REPDT:STRING(8),REPYN:STRING(1),REPMM:STRING(6),"
											+ "APBAMT:DECIMAL(9),APLAMT:DECIMAL(9),CALAMT:DECIMAL(9),APLDT:STRING(8)";
							gcds_temp.SetDataHeader(THeader);
							for(i=1;i<=gcds_data.countrow;i++) {
								if (gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==2||gcds_data.SysStatus(i)==3){
									gcds_temp.addrow();
									gcds_temp.namevalue(1,"EMPNO")  = gcds_data.namevalue(i,"EMPNO");		
									gcds_temp.namevalue(1,"REPDT") = gcds_data.namevalue(i,"REPDT");	
									gcds_temp.namevalue(1,"REPYN") = gcds_data.namevalue(i,"REPYN");	
									gcds_temp.namevalue(1,"REPMM") = gcds_data.namevalue(i,"REPDT").substring(0,6);	
									gcds_temp.namevalue(1,"APBAMT") = gcds_data.namevalue(i,"APBAMT");							//중도상환일때 상환전 잔액이 상환 원금이 된다!
									gcds_temp.namevalue(1,"APLAMT") = gcds_data.namevalue(i,"APBAMT");							//중도상환일때 상환전 잔액이 상환 원금이 된다!
									gcds_temp.namevalue(1,"CALAMT") =  ln_Calamt_End(gcds_data.namevalue(i,"APBAMT"), gcds_data.namevalue(i,"REPDT") );     //대출 이자를 만든다. 
									gcds_temp.namevalue(1,"APLDT") = gcds_data.namevalue(gcds_data.rowposition,"APLDT");			//상환일자
								}
							}
							gctr_data.KeyValue = "p050018_t13(I:USER=gcds_temp)";
							gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t13";
							gctr_data.post();
							ln_Query();
						}
						else { // 대출 받자마자 중도 상환하는 별 이상한 경우면!!!! 짱나.. 유호정..

							gcds_temp.ClearData();
							var row = gcds_temp.rowposition;
							var THeader = "EMPNO:STRING(7),REPDT:STRING(8),REPYN:STRING(1),REPMM:STRING(6),"
											+ "APBAMT:DECIMAL(9),APLAMT:DECIMAL(9),CALAMT:DECIMAL(9),APLDT:STRING(8)";
							gcds_temp.SetDataHeader(THeader);
							for(i=1;i<=gcds_data.countrow;i++) {
								if (gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==2||gcds_data.SysStatus(i)==3){
									gcds_temp.addrow();
									gcds_temp.namevalue(1,"EMPNO")  = gcds_data.namevalue(i,"EMPNO");		
									gcds_temp.namevalue(1,"REPDT") = gcds_data.namevalue(i,"REPDT");	
									gcds_temp.namevalue(1,"REPYN") = gcds_data.namevalue(i,"REPYN");	
									gcds_temp.namevalue(1,"REPMM") = gcds_data.namevalue(i,"REPDT").substring(0,6);	
									gcds_temp.namevalue(1,"APBAMT") = gcds_data.namevalue(i,"APBAMT");							//중도상환일때 상환전 잔액이 상환 원금이 된다!
									gcds_temp.namevalue(1,"APLAMT") = gcds_data.namevalue(i,"APBAMT");							//중도상환일때 상환전 잔액이 상환 원금이 된다!
									gcds_temp.namevalue(1,"CALAMT") = ln_Calamt(gcds_data.namevalue(i,"APPAMT"), gcds_data.namevalue(1,"APPDT") ) + ln_Calamt_End(gcds_data.namevalue(i,"APBAMT"), gcds_data.namevalue(i,"REPDT") );     //대출 이자를 만든다. 
									gcds_temp.namevalue(1,"APLDT") = gcds_data.namevalue(gcds_data.rowposition,"APLDT");			//상환일자
								}
							}
							gctr_data.KeyValue = "p050018_t13(I:USER=gcds_temp)";
							gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t13";
							gctr_data.post();
							ln_Query();

						}

					}
					return false;
		}
}

/******************************************************************************
	Description : 저장4
******************************************************************************/
function ln_SaveExe(){
					if (confirm("임원 구분을 변경하는 것이 맞습니까?")) {
						gcds_temp.ClearData();
						var THeader = "EMPNO:STRING(7),EXE:STRING(1)";
						gcds_temp.SetDataHeader(THeader);
						gcds_temp.addrow();
						gcds_temp.namevalue(1,"EMPNO")  = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");		
						gcds_temp.namevalue(1,"EXE") = gclx_exe.bindcolval;	
						gctr_data.KeyValue = "p050018_t17(I:USER=gcds_temp)";
						gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t17";
						gctr_data.post();
						ln_Query();
					}
					return false;
}

/******************************************************************************
	Description : 저장5
******************************************************************************/
function ln_SaveExe2(){
					if (confirm("직원 구분을 변경하는 것이 맞습니까?")) {
						gcds_temp.ClearData();
						var THeader = "EMPNO:STRING(7),EXE:STRING(1)";
						gcds_temp.SetDataHeader(THeader);
						gcds_temp.addrow();
						gcds_temp.namevalue(1,"EMPNO")  = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");		
						gcds_temp.namevalue(1,"EXE") = gclx_exe.bindcolval;	
						gctr_data.KeyValue = "p050018_t17(I:USER=gcds_temp)";
						gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t17";
						gctr_data.post();
						ln_Query();
					}
					return false;
}

/******************************************************************************
	Description : 대출잔액 ,
	              cnt - 횟수, apjamt - 대출잔액, aplamt - 상환원금
******************************************************************************/
function ln_Apbamt(cnt,apbamt,aplamt) {
	if(cnt==1){
		return apbamt
	}else{
    apbamt = apbamt - aplamt
		return apbamt;
	}
}

/******************************************************************************
	Description : 대출잔액 ,
	              cnt - 횟수, apjamt - 대출잔액, aplamt - 상환원금
******************************************************************************/
function ln_Apjamt(apjamt,aplamt) {
    apjamt = apjamt - aplamt
		return apjamt;
}

/******************************************************************************
	Description : 최초대출이자 일할 계산해서 정산대출이자에 더한다~
					  apjamt - 대출잔액, aplamt - 상환원금
******************************************************************************/
function ln_Calamt(apjamt,aplday) {

		var yyyy = aplday.substr(0,4);
		var mm = aplday.substr(4,2);
		var dd = aplday.substr(6,2);

		var minus2;

		if(yyyy%4 == 0) {	//윤년이면
			if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31일로 끝나면
				minus2 = (31 - dd + 1)/31;	
			}else if(mm == 2){			//29일로 끝나면
				minus2 = (29 - dd + 1)/29;	
			}else{							//30일로 끝나면
				minus2 = (30 - dd + 1)/30;
			}
		}
		else{	//윤년이 아니면
			if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31일로 끝나면
				minus2 = (31 - dd + 1)/31;	
			}else if(mm == 2){			//28일로 끝나면
				minus2 = (28 - dd + 1)/28;	
			}else{							//30일로 끝나면
				minus2 = (30 - dd + 1)/30;
			}
		}
		return apjamt*0.04/12*minus2;

}


/******************************************************************************
	Description : 중도상환대출이자 일할 계산
					  apjamt - 대출잔액, aplamt - 상환원금
******************************************************************************/
function ln_Calamt_End(apjamt,aplday) {

		var yyyy = aplday.substr(0,4);
		var mm = aplday.substr(4,2);
		var dd = aplday.substr(6,2);

		var minus2;

		if(yyyy%4 == 0) {	//윤년이면
			if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31일로 끝나면
				minus2 = ( dd - 1 )/31;	
			}else if(mm == 2){			//29일로 끝나면
				minus2 = ( dd - 1 )/29;	
			}else{							//30일로 끝나면
				minus2 = ( dd - 1 )/30;
			}
		}
		else{	//윤년이 아니면
			if(mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12){	//31일로 끝나면
				minus2 = ( dd - 1 )/31;	
			}else if(mm == 2){			//28일로 끝나면
				minus2 = ( dd - 1 )/28;	
			}else{							//30일로 끝나면
				minus2 = ( dd - 1 )/30;
			}
		}

		return apjamt*0.04/12*minus2;

}

/******************************************************************************
	Description : 상환일자
	              cnt - 횟수, aplday - 상환일자
******************************************************************************/
function ln_Aplday(cnt,aplday) {

	var yyyy="",mm="",dd="";

	yyyy = aplday.substr(0,4);
	mm = aplday.substr(4,2);
	dd = aplday.substr(6,2);

	if(cnt==1){
		return aplday;
	}else{
		if (mm=="12"){
				yyyy = Number(yyyy) + 1;
				mm="01";
        return yyyy+mm+dd;
		}else{
        mm = Number(mm) + 1;
				if(mm=="10"||mm=="11"||mm=="12"){
        }else{
					mm="0"+mm;
				}
		    return yyyy + mm+ dd;  
		}
	}
}

/******************************************************************************
	Description : 상환이자 
	              apjamt-대출잔액
******************************************************************************/
function ln_RATAMT(apjamt) {

	var RATAMT=0;

	if (apjamt<=5000000){
		return 	RATAMT = Math.floor((apjamt*0.04)/12)
	}else{
		return RATAMT = Math.floor(((5000000*0.02) + (apjamt-5000000)*0.03)/12);
	}

}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk() {

	if (fn_trim(gcem_empno.text) == "") {			
		alert("정확한 사번을 입력해 주십시오");
		gcem_empno.text = "";
		return false;
	}

	if (fn_trim(gcem_appday.text)== "") {			
		alert("정확한 대출일을 입력해 주십시오");
		gcem_appday.text = "";
		gcem_appday.focus();
		return false;
	}

	if (fn_trim(gcem_aplday.text)== "") {			
		alert("정확한 상환일을 입력해 주십시오");
		gcem_aplday.text = "";
		gcem_aplday.focus();
		return false;
	}




	if (fn_trim(gcem_repdt.text)!= "" && gclx_repyn.bindcolval == 'Y') {
		ln_SaveRep();
		return false;	
	}


	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){

			gcds_data.deleterow(gcds_data.rowposition);
			gctr_data.KeyValue = "p050018_t1(I:USER=gcds_data)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_t1";
			gctr_data.post();
			ln_Query()
		}
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}




/*******************************************************************************
  Description : 출력물
******************************************************************************/
function ln_Print(){

			var strmm = gcem_curdt.text.substring(5,7);

			if (gcds_data.countrow<1) 
				alert("다운로드하실 자료가 없습니다.");
			else {
					gcds_rpt_head_6.ClearAll();
					ln_SetDataHeader();
					gcds_rpt_head_6.Addrow();
					gcds_rpt_head_6.namevalue(1,"MM") = " 공조회 운영기금 대출 대장 ( "+strmm+" 월 )" ;
					gcds_rpt_head_6.namevalue(1,"PRINTDT") = gs_date;
					gcds_rpt_head_6.namevalue(1,"CNT") = "합계" ;
					gcrp_print_6.preview();
			}
}

/*******************************************************************************
  Description : 데이타셋 헤드
******************************************************************************/
function ln_SetDataHeader(){

			if(gcds_rpt_head_6.countrow<1){

				var s_temp = "MM:STRING,PRINTDT:STRING,CNT:STRING";

				gcds_rpt_head_6.SetDataHeader(s_temp);

			}

 }


/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcds_excel.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050018_s2?v_str1=" + gclx_dept.bindcolval
																								+ "&v_str2=" + txt_empnmk.value
																								+ "&v_str3=" + gcem_curdt.text
																								+ "&v_str3=" + gs_level
																								+ "&v_str4=" + gs_treecd;
	gcds_excel.Reset(); 

}

/******************************************************************************
	Description : Enable or Disable
******************************************************************************/
function ln_Enable(p){

	if (p=="f"){

		if (gstrChk==""){

			gcem_empno.enable =false;
			txt_empnmk.ReadOnly =true;
			gcem_appday.enable =false;
			//gclx_appamt.enable =false;
			gcem_aplday.enable =false;
			//gclx_reason.enable =false;
			gcem_repdt.enable =false;
		}

	}else if(p=="t"){

			gcem_empno.enable =true;
			txt_empnmk.ReadOnly =true;
			gcem_appday.enable =false;
			gclx_appamt.enable =true;
			gcem_aplday.enable =false;

	}

}


/******************************************************************************
	Description : 사원조회
******************************************************************************/
function ln_Find(e){
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./P050018_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		gcem_empno.text = arrParam[1];
	} else {
		eval(e).value = "";
		gcem_empno.text  = "";
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id="gcds_data" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
	<param name="syncload"  value="false"> 
	<param name="SortExpr"	value="+EXE">
	<param name="SubsumExpr"	value="Total,2:EXE">
</object>
</comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__">
<object id="gcds_excel" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload"  value="false"> 
</object>
</comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__">
<object id="gcds_detail" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload" value="false"> 
</object>
</comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__">
<object id="gcds_temp" classid="clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49"  > 
  <param name="syncload" value="false"> 
</object>
</comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__">
<OBJECT id=gcds_rpt_head_6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">		<!-- 대출대장 출력물 head-->
	<param name="SuppressColumns"   value="1:EXE">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<!-- <param name="keyvalue"    value="p050008_t1(I:user=gcds_data)"> -->
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	  alert("에러가 발생 했습니다.");
	  window.status="조회가 완료 되었습니다.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "조회건수 : " + rowcount + " 건";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 
	window.status = " 조회가 완료 되었습니다.";
</script>


<script language=JavaScript  for=gcds_excel event="OnLoadStarted()" >
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_excel event=OnLoadCompleted(rowcount)>
	//document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 
	window.status = " 조회가 완료 되었습니다.";
	gcgd_excel.RunExcelEx('사내대출대장', 1, 0);
</script>


<script language=JavaScript  for=gcds_detail event=OnLoadCompleted(rowcount)>
  ft_cnt2.innerText = "조회건수 : " + rowcount + " 건";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 
	window.status = " 조회가 완료 되었습니다.";
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_grid1 event=OnClick(Row,Colid)>
	if (Row>0) {
		ln_Enable("f");
	}
	ln_Query2();
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gctr_data.ErrorMsg);
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p050018_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
		<!--	<img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">	 -->
		<!--	<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()"> -->
			<img src="../../Common/img/btn/com_b_print.gif"	  style="cursor:hand"  onclick="ln_Print()">	
			<img src="../../Common/img/btn/com_b_newadd.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
					<td width="10px" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
					<td width="100px"><nobr>
					<INPUT id="txt_empnmk" class="txt21" TYPE=TEXT STYLE="width:90px; position:relative;left:4px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 

					<td width="10px" class="tab29"  bgcolor="#eeeeee">
						<nobr>&nbsp;상환기준월&nbsp;</nobr></td>
					<td ><nobr>&nbsp;
						<comment id="__NSID__">
						<object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; ">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
						</object>
						</comment>
						<script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td> 

					<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
				</tr>
			</table>		
		</td>
  </tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__">
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid1  style="WIDTH: 480px; HEIGHT:420px;border:1 solid #777777;display:block;" >
							<PARAM NAME="DataID"		VALUE="gcds_data">
							<param NAME=BorderStyle		VALUE=0> 
							<param NAME=indwidth			VALUE=0>
							<PARAM NAME="Editable"		VALUE="False">
							<param NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"			VALUE="true">
							<param NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"		VALUE="  
								<FC> Name='순'				ID={CURROW}  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=CENTER	</FC> 		
								<FC> Name='사번'			ID=EMPNO  			HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	sort=true	BgColor='#f5f5f5'</FC> 
								<FC> Name='성명'			ID=EMPNMK 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	sort=true	BgColor='#f5f5f5'</FC> 
								<FC> Name='소속'			ID=DEPTNM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		sort=true	BgColor='#f5f5f5'</FC> 
								<C> Name='직위'				ID=PAYGRDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		sort=true	BgColor='#f5f5f5'</C> 
								<C> Name='대출일'			ID=APPDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center	sort=true	Mask='XXXX/XX/XX'	</C> 
								<C> Name='대출금'			ID=APPAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=RIGHT		sort=true</C> 
								<C> Name='횟수'				ID=APLCNT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	sort=true</C> 
								<C> Name='상환전잔액'		ID=APBAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT		sort=true</C> 
								<C> Name='상환원금'		ID=APLAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=RIGHT		sort=true</C> 
								<C> Name='상환후잔액'		ID=APJAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT		sort=true</C> 
								<C> Name='상환일'			ID=APLDT  			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	sort=true	Mask='XXXX/XX/XX'	</C> 
								<C> Name='이자'				ID=CALAMT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		sort=true</C> 
								<C> Name='상환액'			ID='AMT_1'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 		align=right		sort=true</C> 
								<C> Name='대출사유'		ID=REASON  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 		align=center	sort=true	  								value={if(REASON='1','결혼',IF(REASON='2','학자금',IF(REASON='3','주택',IF(REASON='4','기타',''))))}</C> 
								<C> Name='중도상환'	ID=REPYN  			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center		sort=true	  
								value={if(REPYN='Y','상환',IF(REPYN='N','미상환',''))}</C> 
								<C> Name='임/직원'		ID='EXE'  			HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center		sort=true 
								value={if(EXE='0','직원',IF(EXE='1','임원',''))} suppress=1</C> 

								">

						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:482px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
           


						<!-- 사내대출대장 Excel -->
					<comment id="__NSID__">
					<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel  style="WIDTH: 480px; HEIGHT:420px;border:1 solid #777777;display:none;" >
							<PARAM NAME="DataID"			VALUE="gcds_excel">
							<param NAME=BorderStyle		VALUE=0> 
							<param NAME=indwidth			VALUE=0>
							<PARAM NAME="Editable"		VALUE="False">
							<param NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"			VALUE="true">
							<param name="ViewSummary" value=1>
							<PARAM NAME="Format"			VALUE=" 
								<C> Name='순'					ID={CURROW}  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=CENTER	</C> 						
								<C> Name='소속'				ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=LEFT		SumText='계' SumColor=Black	</C> 
								<C> Name='직위'				ID=PAYGRDNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		 SumColor=Black</C> 
								<C> Name='사번'				ID=EMPNO  		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	 SumColor=Black</C> 
								<C> Name='성명'				ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	</C> 
								<C> Name='대출일'			ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	Mask='XXXX/XX/XX'	</C> 
								<C> Name='대출금'			ID=APPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT		SumText=@sum SumColor=Black	</C> 
								<C> Name='상환일'			ID=APLDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	Mask='XXXX/XX/XX'	</C> 
								<C> Name='상환원금'		ID=APLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT		SumText=@sum SumColor=Black	</C> 
								<C> Name='상환횟수'		ID=APPCNT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT		</C> 
								<C> Name='상환누계'		ID=TAPLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=RIGHT	 SumText=@sum SumColor=Black	</C> 
								<C> Name='대출잔액'		ID=CPJLAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=RIGHT	 SumText=@sum SumColor=Black	</C> 
								<C> Name='대출이자누계' ID=TRATAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  SumText=@sum SumColor=Black	</C> 
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>


					</td>
					<td width=3></td>
					<td valign=top>
						<table border="0"  cellpadding="0" cellspacing="0"  style="width:390px;height:210px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090">
					  
						<tr>	
							<td width="90px" class="tab25" bgcolor="#eeeeee"><nobr>&nbsp;사번&nbsp;</nobr>
							</td>
							<td width="55px" class="tab31"><nobr>
								<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=Readonly  value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
							</td>
							<td width="40px" class="tab31" ><nobr><img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="position:relative;top:2px;cursor:hand" onclick="ln_Find('txt_empnmk2')" ></nobr>
							</td>

							<td width="200px" class="tab24"><nobr>
							  <input id="txt_empnmk2" name="txt_empnmk2" type="text" class="txt21" style="width:75px;"  maxlength=10 readonly>&nbsp;&nbsp;</nobr>

									<comment id="__NSID__">
									<object id=gclx_exe classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:4px;font-size:12px;width:60px;">
									<param name="CBData" value="0^직원,1^임원" />
									<param name="CBDataColumns" value="COM_CODE,COM_SNAME" />
									<param name="Index" value="0" />
									<param name="SearchColumn" value="COM_SNAME" />
									<param name="ListExprFormat" value="COM_SNAME^0^50" />								
									<param name="BindColumn" value="COM_CODE" />
									<param name="Enable" value="true" />
									</object>
									</comment>
									<script>__ws__(__NSID__);</script>&nbsp;</nobr>	

							  </td>	
						</tr>
						<tr>
							<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;대출일&nbsp;</nobr></td>
							<td colspan=3 class="tab21"><nobr>
								<comment id="__NSID__">
								<object id=gcem_appday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " >
									<param name=Text          value="">
									<param name=Alignment	    value=0>
									<param name=Border	      value=True>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=MaxLength     value=8>
									<param name=IsComma       value=true>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									</object>
									</comment><script>__ws__(__NSID__);</script>&nbsp;
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_appday', 'Text','gcem_aplday', 'Text')"   style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
							</td>
						</tr>
						<tr>	
							<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;대출금&nbsp;</nobr></td>
							<td colspan=3 class="tab21"  ><nobr>
								<comment id="__NSID__">
									<object id=gclx_appamt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:2px;font-size:12px;width:112px;">
									<param name="CBData" value="1000000^1백만원,2000000^2백만원,3000000^3백만원,4000000^4백만원,5000000^5백만원" />
									<param name="CBDataColumns" value="COM_CODE,COM_SNAME" />
									<param name="Index" value="0" />
									<param name="SearchColumn" value="COM_SNAME" />
									<param name="ListExprFormat" value="COM_SNAME^0^70" />								
									<param name="BindColumn" value="COM_CODE" />
									<param name="Enable" value="true" />
									</object>
								</comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>          
							</tr>	
							<tr>
								<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;상환일&nbsp;</nobr></td>
								<td colspan=3 class="tab21"><nobr>
									<comment id="__NSID__">
									<object id=gcem_aplday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	    value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
									</object>
									</comment><script>__ws__(__NSID__);</script>&nbsp;
									
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_aplday', 'Text')"   style="position:relative;width:20px;left:5px;cursor:hand;"> 
									
									</nobr>
								
								</td> 
							</tr>
							<tr>
								<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;대출사유&nbsp;</nobr></td>
								<td colspan=3 class="tab21"><nobr>
									<comment id="__NSID__">
									<object id=gclx_reason classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:2px;font-size:12px;width:112px;">
									<param name="CBData" value="1^결혼,2^학자금,3^주택,4^기타" />
									<param name="CBDataColumns" value="COM_CODE,COM_SNAME" />
									<param name="Index" value="0" />
									<param name="SearchColumn" value="COM_SNAME" />
									<param name="ListExprFormat" value="COM_SNAME^0^70" />								
									<param name="BindColumn" value="COM_CODE" />
									<param name="Enable" value="true" />
									</object>
									</comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td> 
							</tr>

							<tr>
								<td width="90px" class="tab27" bgcolor="#eeeeee"><nobr>&nbsp;중도상환&nbsp;</nobr></td>
								<td class="tab21"><nobr>
									<comment id="__NSID__">
									<object id=gcem_repdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:dotum; font-size:9pt; " >
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=True>
										<param name=ClipMode	    value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
									</object>
									</comment><script>__ws__(__NSID__);</script>&nbsp;									
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_repdt', 'Text')"   style="position:relative;width:20px;left:5px;cursor:hand;"> 			
									</nobr>
								</td> 

								<td width="40px" class="tab11" colspan = 2>
								<nobr>&nbsp;
									<comment id="__NSID__">
									<object id=gclx_repyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:112px;">
									<param name="CBData" value="N^미상환,Y^상환" />
									<param name="CBDataColumns" value="COM_CODE,COM_SNAME" />
									<param name="Index" value="0" />
									<param name="SearchColumn" value="COM_SNAME" />
									<param name="ListExprFormat" value="COM_SNAME^0^70" />								
									<param name="BindColumn" value="COM_CODE" />
									<param name="Enable" value="true" />
									</object>
									</comment>
									<script>__ws__(__NSID__);</script>&nbsp;</nobr>						
								</td>
							</tr>

							<tr>
								<td colspan=4 align="right" style="padding-top:3px;position:relative;left:-4px;top:1px;"><nobr>&nbsp;
									<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_SaveDetail()">
									<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Run()">
								</td>
							</tr>

							<tr>
						<td colspan=4>
			        	<comment id="__NSID__">
						<OBJECT id=gcgd_create  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 390px; HEIGHT:240px;border:1 solid #777777;display:block;">
									<PARAM NAME="DataID"			VALUE="gcds_detail">
									<PARAM NAME=BorderStyle		VALUE=0> 
									<PARAM NAME=indwidth			VALUE=0>
									<PARAM NAME="Editable"			VALUE="True">
									<PARAM NAME="Fillarea"			VALUE="true">
									<PARAM NAME="ColSizing"			VALUE="true">
									<param name=ViewSummary		value=1>
									<PARAM NAME="Format"			VALUE="   
									<C> Name='횟수'			ID=APLCNT HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center	SumBgColor=#C3D0DB </C> 
									<C> Name='상환전잔액'	ID=APBAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=right	SumBgColor=#C3D0DB SumText='합계'</C> 
									<C> Name='상환후잔액'	ID=APJAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=right	SumBgColor=#C3D0DB</C> 
									<C> Name='상환월'		ID=APLDT HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=center SumBgColor=#C3D0DB SumText='' Mask='XXXX-XX'</C> 
									<C> Name='상환원금'	ID=APLAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=right	SumBgColor=#C3D0DB SumText=@sum</C> 
									<C> Name='이자'	ID=CALAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right	SumBgColor=#C3D0DB SumText=@sum</C> 
									<C> Name='상환액'		ID='AMT_1' HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=right SumBgColor=#C3D0DB SumText=@sum</C> 
       							">
								</OBJECT></comment><script>__ws__(__NSID__);</script>
								<fieldset id=ft_div2 style="width:392px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
									<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
								</fieldset>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		<C>Col=EMPNO		Ctrl=gcem_empno			Param=Text				</C>
		<C>Col=EMPNMK  	Ctrl=txt_empnmk2		Param=value			</C>
		<C>Col=APPDT			Ctrl=gcem_appday		Param=Text				</C>
		<C>Col=APPAMT		Ctrl=gclx_appamt			Param=bindcolval		</C>
		<C>Col=APLDT			Ctrl=gcem_aplday			Param=Text				</C>
		<C>Col=REASON		Ctrl=gclx_reason			Param=bindcolval		</C>
		<C>Col=REPDT			Ctrl=gcem_repdt			Param=Text				</C>
		<C>Col=REPYN	 		Ctrl=gclx_repyn			Param=bindcolval		</C>
		<C>Col=EXE	 		Ctrl=gclx_exe				Param=bindcolval		</C>

	'>
</object></comment><script>__ws__(__NSID__);</script>


<!-- Report 부분 -->


<comment id="__NSID__"><OBJECT id=gcrp_print_6  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_rpt_head_6">
	<param name="DetailDataID"			VALUE="gcds_data">   
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="PrintMargine"      value="false">                   
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="

<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=390 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=893 ,top=6 ,right=2100 ,bottom=107 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='순' ,left=32 ,top=295 ,right=92 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=92 ,top=295 ,right=192 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사유' ,left=192 ,top=295 ,right=292 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=289 ,top=295 ,right=488 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=485 ,top=295 ,right=578 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>


	<T>id='사번' ,left=586 ,top=295 ,right=731 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='만기일' ,left=1251 ,top=295 ,right=1450 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출금' ,left=1072 ,top=295 ,right=1271 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출일' ,left=884 ,top=295 ,right=1083 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=719 ,top=295 ,right=890 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원금+이자' ,left=2476 ,top=295 ,right=2632 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MM', left=900, top=14, right=2100, bottom=98, face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=12 ,top=208 ,right=2817 ,bottom=208 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='대 출 자 현 황' ,left=35 ,top=217 ,right=1450 ,bottom=292 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여공제' ,left=2476 ,top=217 ,right=2632 ,bottom=292 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출잔액' ,left=2635 ,top=220 ,right=2814 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PRINTDT', left=2614, top=107, right=2817, bottom=153, align='right' ,mask='XXXX.XX.XX', face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2349 ,top=107 ,right=2612 ,bottom=153 ,align='right' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=12 ,top=384 ,right=2817 ,bottom=384 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1959 ,top=205 ,right=1959 ,bottom=387 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2470 ,top=205 ,right=2470 ,bottom=387 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=205 ,right=1450 ,bottom=387 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2632 ,top=208 ,right=2632 ,bottom=390 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='단위 : 원' ,left=2614 ,top=159 ,right=2817 ,bottom=202 ,align='right' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=292 ,top=295 ,right=292 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=95 ,top=295 ,right=95 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=185 ,top=295 ,right=185 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=482 ,top=295 ,right=482 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=586 ,top=295 ,right=586 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=728 ,top=295 ,right=728 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=884 ,top=295 ,right=884 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=295 ,right=1069 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=295 ,right=1265 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=295 ,right=1598 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1676 ,top=295 ,right=1676 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=295 ,right=2230 ,bottom=387 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=12 ,top=208 ,right=12 ,bottom=387 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2817 ,top=208 ,right=2817 ,bottom=387 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='이자상환내역' ,left=1964 ,top=217 ,right=2470 ,bottom=292 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당월이자' ,left=2000 ,top=295 ,right=2200 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환이자누계' ,left=2239 ,top=303 ,right=2464 ,bottom=364 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환원금누계' ,left=1687 ,top=303 ,right=1947 ,bottom=370 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환원금' ,left=1450 ,top=300 ,right=1603 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회수' ,left=1600 ,top=341 ,right=1676 ,bottom=381 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환' ,left=1600 ,top=298 ,right=1676 ,bottom=338 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원금상환내역' ,left=1459 ,top=217 ,right=1950 ,bottom=286 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=20 ,top=292 ,right=2629 ,bottom=292 </L>
</B>


<B>id=default ,left=0,top=0 ,right=2869 ,bottom=70 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=35, top=0, right=95, bottom=66, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='{decode(curlevel,2,\'소계\',EXENMK)}' left=95, top=0, right=195, bottom=66, supplevel=2,	align='center', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='REASONK', left=195, top=0, right=295, bottom=66, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='DEPTNM', left=295, top=0, right=491, bottom=66, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=485, top=0, right=586, bottom=66, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=586, top=0, right=728, bottom=66, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=734, top=0, right=884, bottom=66, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPDT', left=881, top=0, right=1080, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPAMT', left=1072, top=0, right=1268, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=1251, top=0, right=1450, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT', left=1450, top=0, right=1600, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLCNT', left=1600, top=0, right=1676, bottom=66, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT_SUM', left=1687, top=0, right=1950, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALAMT', left=2037, top=0, right=2190, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RATAMT_SUM', left=2239, top=0, right=2464, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT_RATAMT', left=2470, top=0, right=2629, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APJAMT', left=2635, top=0, right=2814, bottom=66, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>

	<L> left=12 ,top=0 ,right=12 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=12 ,top=69 ,right=2820 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2470 ,top=0 ,right=2470 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2632 ,top=0 ,right=2632 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=95 ,top=3 ,right=95 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=185 ,top=3 ,right=185 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=292 ,top=3 ,right=292 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=482 ,top=3 ,right=482 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=728 ,top=3 ,right=728 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=586 ,top=3 ,right=586 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=881 ,top=3 ,right=881 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=3 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1676 ,top=3 ,right=1676 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=3 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=3 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2817 ,top=0 ,right=2817 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1959 ,top=0 ,right=1959 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2233 ,top=3 ,right=2233 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>




<B>id=LDFooter ,left=0,top=0 ,right=2869 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=12 ,top=3 ,right=2817 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{Sum(APPAMT)} ', left=1072, top=3, right=1268, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_APLRAT)}', left=2470, top=3, right=2629, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(BALANCE)}', left=2640, top=3, right=2817, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=12 ,top=0 ,right=12 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1959 ,top=0 ,right=1959 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2470 ,top=0 ,right=2470 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2632 ,top=0 ,right=2632 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1676 ,top=0 ,right=1676 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=0 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=0 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=0 ,right=2230 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2817 ,top=0 ,right=2817 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='CNT', left=32, top=0, right=1046, bottom=66, face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=12 ,top=66 ,right=2820 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{SUM(APLAMT)}', left=1450, top=3, right=1600, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_SUM)}', left=1704, top=3, right=1947, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(CALAMT)}', left=1999, top=3, right=2204, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(RATAMT_SUM)}', left=2239, top=3, right=2476, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_RATAMT)}', left=2470, top=3, right=2629, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APJAMT)}', left=2635, top=3, right=2814, bottom=69, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#C0C0C0</C>
</B>


	<B>id=Footer ,left=0 ,top=1894 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=8 ,top=0 ,right=2818 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
		<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
	</B>




	">
	</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- Report 끝 부분 -->



<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>