<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계 - 예산변경
+ 프로그램 ID	:  A080003.html
+ 기 능 정 의	:  예산변경 등록,변경,조회 및 출력 화면이다.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 a080001_s1
------------------------------------------------------------------------------
+ 수 정 내 용 :	팝업추가,권한변경
+ 수   정  자 : 이민정
+ 수 정 일 자 : 2006.10.31
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>예산변경</title>

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


var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date4  = gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드
var gs_deptcd = gdeptcd;	//부서코드
var gs_deptnm = gdeptnm;	//부서명
var gs_usrnm  = gusrnm;		//사용자명
var SaveCheck = "";
var gs_vendcd = "";	//관리지원본부
var g_bgtrqno = "";
var g_fdcode  = "";
var g_satcode = ""; //팝업의 세목
var g_satcode1 = "F" //세목을 조회한곳

var g_satcode2 = ""; //팝업의 세목
var g_satcode2 = "F" //세목을 조회한곳

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_DispChk(0);
	ln_Before(); //변수초기화,룩업조회
	ln_SetDataHeader();
	ln_Add(); //Master추가
	ln_RowAdd('01'); //Detail추가
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	if(gs_userid=="ACCOUNT") {	//개발자용 테스트용
		txt_deptcd.value = "C220";
		txt_deptnm.value = "재무팀";
		txt_empnm.value  = "박상미";
		txt_empno.value  = "1990048";
		txt_nmk.value = "박상미";
		txt_nm.value = "1990048";
	}else{
		txt_deptcd.value = gs_deptcd;
		txt_deptnm.value = gs_deptnm;
		txt_empnm.value  = gs_usrnm;
		txt_empno.value  = gs_userid;
		txt_nmk.value = gs_usrnm;
		txt_nm.value = gs_userid;
	}

	//콤포넌트와 변수
	gcem_bgtyy.text = gs_date2;	//예산년도
	gclx_bgtrqst.bindcolval = "N";	//신청서상태
	gcem_wrdt.text  = gs_date;	//작성일자
	if(gs_deptcd==null){	//회계개발자
		gs_deptcd = "C000";
	}
	gclx_bgtrqst2.bindcolval = ""; //신청서상태

	gcem_bgtyy1.text = gs_date4; //년도월

	//데이터셋
	//로그인 사용자의 부서
	if(gs_deptcd!="C000"){
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str3="+gs_deptcd+"&v_str4=Y";
		gcds_deptemp.Reset();
	}else{
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str3="+gs_deptcd+"&v_str4=N";
		gcds_deptemp.Reset();
	}
	//관리항목 룩업
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1=&v_str2=B";
	gcds_fsrefcd.Reset();
	//콤보
	//지점
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	//신청서상태
	//신청부서-일반부서
	if(gs_vendcd!="1200"){
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt.Reset();
	//신청부서-관리지원본부
	}else{
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt.Reset();
	}
	//세목
	gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s6?v_str1=";
	gcds_satcode.Reset();
	gclx_satcode.enable = false;
	//원가구분
	//gcds_costcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0030"; 
	//gcds_costcd.Reset();
	//신청구분(탭1),예산구분(탭2) 룩업
	gcds_bgtrqdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2150";
	gcds_bgtrqdiv.Reset();

	/*변경예산신청서***********************************************************/

	gcem_swrdtfr2.text = gs_date3+"01";	//작성일자fr
	gcem_swrdtto2.text = gs_date;				//작성일자to

	//지점코드
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	if(gs_vendcd!="1200"){//신청부서-일반부서
		gcds_bgtdpt2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt2.Reset();
	}else{	//신청부서-관리지원본부
		gcds_bgtdpt2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt2.Reset();
	}
	
	/*변경신청현황 항목 조회**********************************************/
	gcem_bgtyy55.text = gs_date2;

	//지점[검색]
	gcds_sfdcode5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode5.Reset();

	if(gs_vendcd!="1200"){//신청본부[검색]-일반부서
		gcds_bgtdiv5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv5.Reset();
	}else{	//신청본부[검색]-관리지원본부
		gcds_bgtdiv5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv5.Reset();
	}

	if(gs_vendcd!="1200"){//신청부서[검색]-일반부서
		gcds_bgtdpt5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt5.Reset();
	}else{	//신청부서-관리지원본부
		gcds_bgtdpt5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt5.Reset();
	}

	
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){

	gcem_bgtrqno.enable = true;
	if(e=="01"){
		var str1 = gclx_fdcode1.BindColVal;	//지점코드
		var str2 = gcem_bgtrqno.text;				//신청서번호
		var str3 = gcem_bgtyy.text;					//예산년도
		var str4 = gcem_bgtdept1.text;	//신청부서
		var str5 = gclx_fsrefcd.BindColVal;	//관리항목코드
		if(str2!="") {
			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+str1
					
												+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
			gcds_data1.Reset();
		}else
			alert("신청서번호를 입력해 주십시오.");

	}else if(e=="S"){
		var str1 = gclx_fdcode1.BindColVal;	//지점코드
		var str2 = gcem_bgtrqno.text;				//신청서번호
		var str3 = gcem_bgtyy.text;					//예산년도
		var str4 = gcem_bgtdept1.text;	//신청부서
		var str5 = gclx_fsrefcd.BindColVal;	//관리항목코드
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
		gcds_data1.Reset();
	}else if(e=="02"){
		var str1 = gclx_fdcode1.BindColVal;	//지점코드
		var str2 = gcem_bgtrqno.text;				//신청서번호
		gcds_data1_1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s2?v_str1="+str1+"&v_str2="+str2;
		gcds_data1_1.Reset();
	}else if(e=="03"){
		var str1 = gclx_fdcode3.BindColVal;		//지점코드
		var str2 = gclx_bgtrqst3.BindColVal;	//승인구분
		var str3 = gcem_wrdt3.text;						//예산년도
		var str4 = gcem_bgtmmfr3.text;				//예산월fr
		var str5 = gcem_bgtmmto3.text;				//예산월fr
		var str6 = gclx_bgtrqdiv3.BindColVal;	//신청구분
		var str7 = gcem_bgtdept3.text;		//신청부서
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s8?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
		gcds_data3.Reset();
	}else if(e=="04"){
		var str1 = gclx_fdcode4.BindColVal;		//지점코드
		var str2 = gclx_bgtrqst4.BindColVal;	//승인구분
		var str3 = gcem_wrdt4.text;						//예산년도
		var str4 = gcem_bgtmmfr4.text;				//예산월fr
		var str5 = gcem_bgtmmto4.text;				//예산월fr
		var str6 = gclx_bgtrqdiv4.BindColVal;	//신청구분
		var str7 = gcem_bgtdept4.text;		//신청부서
		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s9?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
		gcds_data4.Reset();
	}else if(e=="05"){
		var str1 = gclx_sfdcode2.BindColVal;	//지점코드
		var str2 = gcem_swrdtfr2.text;				//작성일자fr
		var str3 = gcem_swrdtto2.text;				//작성일자to
		var str4 = gcem_bgtdept2.text;	//신청부서
		var str5 = txt_atcodenm2.value;				//계정과목
		var str6 = gclx_satcode2.BindColVal;	//세목명
		var str7 = gclx_bgtrqst2.BindColVal;  //신청서상태
		var str8 = txt_nm.value;             //담당자사번
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s10?v_str1="+str1+
				"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+
				"&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7+"&v_str8="+str8;
		gcds_data2.Reset(); //변경예산신청서
	}else if(e=="06"){
		var str1 = gclx_sfdcode5.BindColVal;	//지점
		var str2 = gcem_bgtyy55.text;					//년도
		var str3 = gcem_bgtdept5.text;		//신청부서
		var str4 = gclx_bgtdiv5.BindColVal;		//신청본부
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s11?"
											+ "v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
		gcds_data5.Reset(); //변경신청현황
	}
}

/******************************************************************************************
	Description : 조회 - 변경예산신청서(DTL[2])
******************************************************************************************/
function ln_Query2(){
	var str1 = gclx_fdcode1.BindColVal;	//지점코드
	var str2 = gcem_bgtrqno.text;				//신청서번호
	gcds_data3_1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s3?v_str1="+str1+"&v_str2="+str2;
	gcds_data3_1.Reset();
}

/******************************************************************************************
	Description : 조회 - 변경예산신청서(DTL[3])
******************************************************************************************/
function ln_Query3(){
	var str1 = gclx_sfdcode2.bindcolval;	//지점
	var str2 = gcem_swrdtfr2.text;				//작성일자fr
	var str3 = gcem_swrdtto2.text;				//작성일자to
	var str4 = gcem_bgtdept2.text;	//신청부서
	var str5 = txt_atcodenm2.value;				//계정과목
	var str6 = gclx_satcode2.bindcolval;	//세목명
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s10?v_str1="+str1+"&v_str2="+str2
										+ "&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6;
	gcds_data2.Reset();
	//var str1 = gclx_fdcode1.BindColVal;	//지점코드
	//var str2 = gcem_bgtrqno.text;				//신청서번호
	//gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s4?v_str1="+str1+"&v_str2="+str2;
	//gcds_data2.Reset();
}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
	gcds_data1.AddRow();
	gcem_bgtrqno.enable = false;
	gcds_data1_1.ClearData(); //데이터만 클리어
	if(gs_userid=="ACCOUNT") {	//개발자(테스트)용 계정일경우
		txt_deptcd.value = "C220";
		txt_deptnm.value = "재무팀";
		txt_empnm.value  = "박상미";
		txt_empno.value  = "1990048";
		gclx_fdcode1.index=2;
	}else{
		txt_deptcd.value = gs_deptcd;
		txt_deptnm.value = gs_deptnm;
		txt_empnm.value  = gs_usrnm;
		txt_empno.value  = gs_userid;
		gclx_fdcode1.bindcolval=gs_fdcode;
	}

	gcem_bgtdept1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");//신청부서
	gcem_bgtyy.text = gs_date2;			//예산년도
	gclx_bgtrqst.bindcolval = "A";	//신청서상태[작성중]
	gclx_bgtrqst.enable = false;		
	gcem_wrdt.text = gs_date;				//작성일자

	
}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	var row  = gcds_data1.rowposition;
	var row1 = gcds_data1_1.rowposition;
	var row2 = gcds_bgtdpt.rowposition;
	var row3 = gcds_fsrefcd.rowposition;
	gcds_data1_1.namevalue(row1,"JANAMT") = 0;	//잔액 default로 설정

	if(gcem_bgtdept1.text==""){
		alert("부서코드가 존재하지 않습니다. 확인바랍니다.");
		return;
	}
 
  //2008.07.01 부서명으로 본부코드를 가져옴...틀렸음....부서코드로 가져오게 함.
  /*
	if(gcem_bgtnam1.text!=""){
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam1.text;
    gcds_depttemp1.Reset();
  }else if(gcem_bgtdept1.text!=""){
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept1.text+"&v_str2=";
    gcds_depttemp1.Reset();
  }
	*/
 
  gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept1.text+"&v_str2=";
  gcds_depttemp1.Reset();


	if(gcds_data1.IsUpdated && !gcds_data1_1.IsUpdated) {	
		//alert("01");
		if(ln_Chk('01')==false) return false;
		for(var i=1;i<=gcds_data1.countrow;i++){//MST(0) SAVE
			if(gcds_data1.SysStatus(i)=="1") {
				gcds_data1.namevalue(row,"BGTDIV")  =gcds_depttemp1.namevalue(1,"GBCD");		 //신청본부
				gcds_data1.namevalue(row,"BGTTYPE") = "1";	//관리타입
				gcds_data1.namevalue(row,"BGTMACT") = "01";	//예산타입
				gcds_data1.namevalue(row,"FSREFCD") = gcds_fsrefcd.namevalue(row3,"CDCODE"); //관리항목코드
			}
		}	
		gctr_data1.KeyValue = "Account.a080003_t1(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
		gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t1";
		gctr_data1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=A";
		gctr_data1.post();
		ln_Query('S');
	}else if(!gcds_data1.IsUpdated && gcds_data1_1.IsUpdated) {	//DTL(0) SAVA
		//alert("02");
		gcds_data1.namevalue(row,"CHK")="T";
		if(ln_Chk('02')==false) return false;

		gctr_data1_1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
		gctr_data1_1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
		gctr_data1_1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=B";
		gctr_data1_1.post();
		ln_Query('S');
	}else if(gcds_data1.IsUpdated && gcds_data1_1.IsUpdated) { 
		//alert("03");
		gcds_data1.namevalue(row,"CHK")="T";
		if(ln_Chk('02')==false) return false;
		for(var i=1;i<=gcds_data1.countrow;i++){//MST(0)/DTL(0) SAVE
			if(gcds_data1.SysStatus(i)=="1") {
				//alert(gcds_bgtdpt.namevalue(row2,"BGTDIVCD")+":"+gcds_fsrefcd.namevalue(row3,"CDCODE"));
				gcds_data1.namevalue(row,"BGTDIV")  = gcds_depttemp1.namevalue(1,"GBCD");		 //신청본부
				gcds_data1.namevalue(row,"BGTTYPE") = "1";	//관리타입
				gcds_data1.namevalue(row,"BGTMACT") = "01";	//예산타입
				gcds_data1.namevalue(row,"FSREFCD") = gcds_fsrefcd.namevalue(row3,"CDCODE"); //관리항목코드
			}
		}
		gctr_data1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
		gctr_data1.Action   ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
		gctr_data1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=C";
		gctr_data1.post();
		ln_Query('S');
	}else{
		alert("저장하실 정보가 없습니다.");
	}
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){
	if(gcds_data1.countrow>0){
		if(ln_AppChk()) {
			if (confirm("삭제 하시겠습니까?")){	
				gcds_data1.deleterow(gcds_data1.rowposition);
				gctr_data1.KeyValue = "Account.a080003_t1(I:USER=gcds_data1)";
				gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t1";
				gctr_data1.post();
				ln_Query();
				gcds_data1_1.ClearData();
			}
		}
	}
}


function ln_Reset(){
  ln_Start();
  gcem_result1.text = '';
}

/******************************************************************************
	Description : 추가 - 예산 신청 Detail (1)
******************************************************************************/
function ln_RowAdd(e){
	if(gcds_data1.countrow>0){
		if(e=="01") {
			gcds_data1_1.AddRow();
			var row  = gcds_data1.rowposition;
			var row1 = gcds_data1_1.rowposition;
			/*관리항목코드*/
			gcds_data1_1.namevalue(row1,"FDCODE") = gcds_data1.namevalue(row,"FDCODE");
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTTOMON") = gcem_bgtyy1.text;
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTFRMON") = gcem_bgtyy1.text;
			//상태
			gcds_data1_1.namevalue(row1,"BGTRQST") = "N";
		}
	}
}

/******************************************************************************
	Description : 삭제 - 예산 신청 Detail (1)
******************************************************************************/
function ln_RowDel(e){
	if(gcds_data1_1.countrow>0){
		for(var i=1;i<=gcds_data1_1.countrow;i++) {
			if(gcds_data1_1.namevalue(i,"BGTRQST") != "N" && gcds_data1_1.namevalue(i,"CHK") == "T") {
				alert("작성중건만 삭제할 수 있습니다.");
				return;
			}
			else {
				if (confirm("삭제 하시겠습니까?")){	
					if(e=="01"){
						//if(gcds_data1_1.namevalue(gcds_data1_1.rowposition,"
						gcds_data1_1.deleterow(gcds_data1_1.rowposition);
						gctr_data1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1_1)";
						gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
						gctr_data1.post();
					}
				}
			}
		}
	}else
		alert("삭제할 정보가 없습니다.");
}

/******************************************************************************
	Description : 승인요청
******************************************************************************/
function ln_SanReq() {
	var s_temp = "FDCODE:STRING(2),BGTRQNO:STRING(12),BGTRQSEQ:STRING(2),BGTRQST:STRING(1)";
	gcds_temp05.SetDataHeader(s_temp);

	if(gcds_data2.countrow>0){
		var gchk = "F";
		var kchk = "F";
		var hchk = "F";
		for(var j=1;j<=gcds_data2.countrow;j++){
			if(gcds_data2.namevalue(j,"CHK")=="T"){
				gchk = "T";
			}
			if(gcds_data2.namevalue(j,"CHK")=="T"&&gcds_data2.namevalue(j,"BGTRQST")!="N"){
				kchk = "T";//승인요청
			}
		}

		if(gchk=="F")	{
			alert("승인요청할 건을 선택해주세요.");
			return false;
		}

		if(kchk=="T")	{
			alert("승인요청은 작성중인것만 가능합니다.");
			return false;
		}

		var row = gcds_temp05.rowposition;
		if (confirm("승인 요청 하시겠습니까?")){
			for(var i=1;i<=gcds_data2.countrow;i++){
				if(gcds_data2.namevalue(i,"CHK")=="T"){
					gcds_temp05.addrow();	

					gcds_temp05.namevalue(gcds_temp05.rowposition,"FDCODE")  = gcds_data2.namevalue(i,"FDCODE");
					gcds_temp05.namevalue(gcds_temp05.rowposition,"BGTRQNO") = gcds_data2.namevalue(i,"BGTRQNO");
					gcds_temp05.namevalue(gcds_temp05.rowposition,"BGTRQSEQ") = gcds_data2.namevalue(i,"BGTRQSEQ");
					gcds_temp05.namevalue(gcds_temp05.rowposition,"BGTRQST") = "R";

				}
			}
      //prompt('',gcds_temp05.text);
			gctr_data1.KeyValue = "Account.a080003_t4(I:USER=gcds_temp05)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t4";
			//gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3=R";
			gctr_data1.post();
			ln_Query('05');
			
		}
	}else alert("승인할 정보가 없습니다.");
}

/******************************************************************************
	Description : 필수항목 입력체크 
******************************************************************************/
function ln_Chk(e) {
	if(e=="01"){
		if (fn_trim(gclx_fdcode1.bindcolval)==""){
			alert("지점을 입력하십시요.");
			gclx_fdcode1.focus();
			return false; 
		}

		if (fn_trim(gcem_bgtyy.text)==""){
			alert("년도를 입력하십시요.");
			gcem_bgtyy.focus();
			return false; 
		}

		if (fn_trim(gcem_bgtdept1.text)==""){
			//alert("신청부서를 입력하십시요.");
			//gcem_bgtdept1.focus();
			//return false; 
		}

		if (fn_trim(gcem_whybgtrqnote.text)==""){
			alert("신청사유를 입력하십시요.");
			gcem_whybgtrqnote.focus();
			return false; 
		}
	}else if(e=="02"){
		if (fn_trim(gclx_fdcode1.bindcolval)==""){
			alert("지점을 입력하십시요.");
			gclx_fdcode1.focus();
			return false; 
		}

		if (fn_trim(gcem_bgtyy.text)==""){
			alert("년도를 입력하십시요.");
			gcem_bgtyy.focus();
			return false; 
		}

		if (fn_trim(gcem_bgtdept1.text)==""){
			//alert("신청부서를 입력하십시요.");
			//gcem_bgtdept1.focus();
			//return false; 
		}

		for(var i=1;i<=gcds_data1_1.countrow;i++){
			if(gcds_data1_1.namevalue(i,"BGTRQDIV")==""){
				alert("신청구분을 입력하십시요.");
				return false;
			}

			if(gcds_data1_1.namevalue(i,"BGTRQAMT")==0){
				alert("신청금액을 입력하십시요.");
				return false;
			}

			if(gcds_data1_1.namevalue(i,"BGTTOMON")==""){
				alert("배정월을 입력하십시요.");
				return false;
			}

			if(gcds_data1_1.namevalue(i,"BGTRQDIV")!="1"){
				if(gcds_data1_1.namevalue(i,"BGTTOMON")==""){
					alert("피전용월을 입력하십시요.");
					return false;
				}else{
					if (gcds_data1_1.namevalue(i,"BGTTOMON").length<=9 && gcds_data1_1.namevalue(i,"BGTTOMON").length<2){
						gcds_data1_1.namevalue(i,"BGTTOMON") = "0"+gcds_data1_1.namevalue(i,"BGTTOMON");
					}else if (gcds_data1_1.namevalue(i,"BGTFRMON").length<=9 && gcds_data1_1.namevalue(i,"BGTFRMON").length<2){
						if(gcds_data1_1.namevalue(i,"BGTRQDIV")!="01" || gcds_data1_1.namevalue(i,"BGTRQDIV")!="04"){
						gcds_data1_1.namevalue(i,"BGTFRMON") = "0"+gcds_data1_1.namevalue(i,"BGTFRMON");
						}
					}
				}
			}
		}
	}
}

/******************************************************************************
	Description : 승인완료건 체크
******************************************************************************/
function ln_AppChk(){
	//for(var i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(gcds_data1.rowposition,"BGTRQST")=="Y"){
			alert("승인완료건은 삭제할 수 없습니다.");
			return false;
		}
	//}
	if(gcds_data1_1.countrow > 0) {
		alert("Detail 행이 존재하면 삭제할 수 없습니다.");
		return false;
	}
	return true
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(e){

if(e=="05") {
	var s_temp = "CURDT:STRING,DEPTNM:STRING,BGTRQNO:STRING";
	gcds_print1.clearall();
	gcds_print1.SetDataHeader(s_temp);
	gcds_print1.addrow();




  var s_temp11 = "DIVNAME:STRING,BGTTOMON:STRING,FGNAM:STRING,SATNAM:STRING,KBUNAM:STRING,REALBGT:DECIMAL,USEAMT:DECIMAL,JANAMT:DECIMAL,BGTFRMON:STRING,TGNAM:STRING,TATNAM:STRING,SATNAM:STRING,BUSNAM:STRING,BGTRQAMT:DECIMAL,LASAMT:DECIMAL,FDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING,FSREFCD:STRING";
  gcds_printtemp.clearall();
	gcds_printtemp.SetDataHeader(s_temp11);


	if(gcds_data2.countrow>0){
		var g_chk = "F";
		var g_curdt = "";
		for(var i=1;i<=gcds_data2.countrow;i++){
      //alert(gcds_data2.namevalue(i,"CHK"));
			if(gcds_data2.namevalue(i,"CHK")=="T"){
				g_chk ="T";
				g_fdcode  = gcds_data2.namevalue(i,"FDCODE");
				g_bgtrqno = gcds_data2.namevalue(i,"BGTRQNO");
				gcds_print1.namevalue(gcds_print1.rowposition,"CURDT") = gcds_data2.namevalue(i,"WRDT");
				gcds_print1.namevalue(gcds_print1.rowposition,"DEPTNM") = gcds_data2.namevalue(i,"CDNAM");
				gcds_print1.namevalue(gcds_print1.rowposition,"BGTRQNO") = gcds_data2.namevalue(i,"BGTRQNO");
        var str1 = g_fdcode;		//지점코드
        var str2 = g_bgtrqno;		//신청서번호
        var str3 = gs_date;		  //신청일자
        gcds_print.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s7?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
        gcds_print.Reset();

        gcds_printtemp.addrow();

        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"DIVNAME") = gcds_print.namevalue(gcds_print.rowposition,"DIVNAME");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BGTTOMON") = gcds_print.namevalue(gcds_print.rowposition,"BGTTOMON");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"FGNAM") = gcds_print.namevalue(gcds_print.rowposition,"FGNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"SATNAM") = gcds_print.namevalue(gcds_print.rowposition,"SATNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"KBUNAM") = gcds_print.namevalue(gcds_print.rowposition,"KBUNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"REALBGT") = gcds_print.namevalue(gcds_print.rowposition,"REALBGT");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"USEAMT") = gcds_print.namevalue(gcds_print.rowposition,"USEAMT");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"JANAMT") = gcds_print.namevalue(gcds_print.rowposition,"JANAMT");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BGTFRMON") = gcds_print.namevalue(gcds_print.rowposition,"BGTFRMON");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"TGNAM") = gcds_print.namevalue(gcds_print.rowposition,"TGNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"TATNAM") = gcds_print.namevalue(gcds_print.rowposition,"TATNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"SATNAM") = gcds_print.namevalue(gcds_print.rowposition,"SATNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BUSNAM") = gcds_print.namevalue(gcds_print.rowposition,"BUSNAM");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BGTRQAMT") = gcds_print.namevalue(gcds_print.rowposition,"BGTRQAMT");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"LASAMT") = gcds_print.namevalue(gcds_print.rowposition,"LASAMT");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"FDCODE") = gcds_print.namevalue(gcds_print.rowposition,"FDCODE");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BGTYY") = gcds_print.namevalue(gcds_print.rowposition,"BGTYY");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BGTDIV") = gcds_print.namevalue(gcds_print.rowposition,"BGTDIV");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"BGTDPT") = gcds_print.namevalue(gcds_print.rowposition,"BGTDPT");
        gcds_printtemp.namevalue(gcds_printtemp.rowposition,"FSREFCD") = gcds_print.namevalue(gcds_print.rowposition,"FSREFCD");

			} 
		}
    gcrp_print.preview();
	}else
		alert("출력할 정보가 없습니다.");
} else if(e=="06") {
		if(gcds_data5.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			ln_SetDataHeader1();
			gcds_print2.ImportData(gcds_data5.ExportData(1,gcds_data5.countrow,false));
			if (gcds_print2.countrow>0) {
				for(i=1;i<=gcds_print2.countrow;i++){
					gcds_print2.namevalue(i,"HTITLE") = gs_date2;
					gcds_print2.namevalue(i,"CURDT") = gs_date;
					gcds_print2.namevalue(i,"REQDT") = gs_date;
					gcds_print2.namevalue(i,"DEPTNM")  = gcem_bgtnam5.text;
				}
			}
			gcrp_print2.preview();
		}
	}
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "FDCODE:STRING,BGTRQNO:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING,"
						 + "DEPTCD:STRING,EMPNO:STRING,WRDT:STRING,COSTCD:STRING,BGTRQST:STRING,"     
						 + "ATCODE:STRING,FSREFCD:STRING,SATCODE:STRING,BGTGBCD:STRING,"
						 + "BGTTYPE:STRING,BGTMACT:STRING,BGTRQNOTE:STRING,WHYRQNOTE:STRING,"
						 + "ATKORNAM:STRING,EMPNMK:STRING,CDNAM:STRING,CHK:STRING";
	gcds_data1.SetDataHeader(s_temp);

	var s_temp2 = "FDCODE:STRING,BGTRQNO:STRING,BGTRQDIV:STRING,BGTRQAMT:DECIMAL,"//BGTRQSEQ:STRING,
						  + "BGTTOMON:STRING,BGTFRMON:STRING,DVTFRACT:STRING,DVTFRSATCD:STRING,WHYRQNOTE:STRING,"     
						  + "BGTRQST:STRING,ATKORNAM:STRING,CDNAM:STRING,JANAMT:DECIMAL,CHK:STRING,BGTFRDEPT:STRING,BGTDEPTNM:STRING";
	gcds_data1_1.SetDataHeader(s_temp2);
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader1(){

		var s_temp = "ATCODE:STRING,ATKORNAM:STRING,SATNM:STRING,SATCODE:STRING,"
							 + "BGTMM01:DECIMAL,CHGMM01:DECIMAL,BGTMM02:DECIMAL,CHGMM02:DECIMAL,"
							 + "BGTMM03:DECIMAL,CHGMM03:DECIMAL,BGTMM04:DECIMAL,CHGMM04:DECIMAL,"
							 + "BGTMM05:DECIMAL,CHGMM05:DECIMAL,BGTMM06:DECIMAL,CHGMM06:DECIMAL,"
							 + "BGTMM07:DECIMAL,CHGMM07:DECIMAL,BGTMM08:DECIMAL,CHGMM08:DECIMAL,"
							 + "BGTMM09:DECIMAL,CHGMM09:DECIMAL,BGTMM10:DECIMAL,CHGMM10:DECIMAL,"
							 + "BGTMM11:DECIMAL,CHGMM11:DECIMAL,BGTMM12:DECIMAL,CHGMM12:DECIMAL,"
							 + "BGTSUM:DECIMAL,CHGSUM:DECIMAL,"
							 + "APPROVAL01:STRING,APPROVAL02:STRING,APPROVAL03:STRING,APPROVAL04:STRING,"
							 + "APPROVAL05:STRING,APPROVAL06:STRING,APPROVAL07:STRING,APPROVAL08:STRING,"
							 + "APPROVAL09:STRING,APPROVAL10:STRING,APPROVAL11:STRING,APPROVAL12:STRING,"
							 + "HTITLE:STRING,CURDT:STRING,REQDT:STRING,DEPTNM:STRING";
		gcds_print2.SetDataHeader(s_temp);

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data5.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_disp05.RunExcel('예산신청현황');
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************************
	Description : 조회 - 관리항목 코드 조회(변경신청탭)
******************************************************************************************/
function ln_RefQuery(e){
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	gcds_fsrefcd.Reset();
}

/******************************************************************************************
	Description : 조회 - 관리항목 코드 조회(변경예산신청서탭)
******************************************************************************************/
function ln_RefQuery2(e){
	gcds_sfsrefcd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	//prompt('', gcds_sfsrefcd2.DataID);	
	gcds_sfsrefcd2.Reset();
}

/******************************************************************************************
	Description : 조회 - 세목코드 조회(변경신청탭)
******************************************************************************************/
function ln_SatQuery(e){

	if(e!="0003"){
		g_satcode1 = "T";
		gclx_satcode.enable = true;
		gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e; //CMTYPE=e
		gcds_satcode.Reset();
	}else{
		gclx_satcode.enable = false;
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="00";
		gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
	}
}

/******************************************************************************************
	Description : 조회 - 세목코드 조회(변경예산신청서탭)
******************************************************************************************/
function ln_SatQuery2(e){
 // alert("e"+e);
	if(e!="0003"){
		gclx_satcode2.enable = false;
		gcds_ssatcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e;
		gcds_ssatcode2.Reset();
	}else{
		gclx_satcode2.enable = false;
		gcds_ssatcode2.InsertRow(1);
		gcds_ssatcode2.NameValue(1,"CDCODE")="00";
		gcds_ssatcode2.NameValue(1,"CDNAM")="00";
		gclx_satcode2.index = 0;
	}
}

/******************************************************************************************
	Description : 조회 - 세목코드 조회(변경예산 그리드)
******************************************************************************************/
function ln_SatQuery3(e){
	if(e!="0003"){
		gcds_satcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e;
		gcds_satcode2.Reset();
	}else{
		gcds_ssatcode2.InsertRow(1);
		gcds_ssatcode2.NameValue(1,"CDCODE")="00";
		gcds_ssatcode2.NameValue(1,"CDNAM")="00";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
	}
}

/******************************************************************************************
	Description : 예산 잔액계산
******************************************************************************************/
function ln_JanAmt(atc,fcd,sat){//추가예산 일경우
	var row  =  gcds_data1_1.rowposition;
	var row1 =  gcds_bgtdpt.rowposition;
	var str1 =	gclx_fdcode1.bindcolval;	//지점코드
	var str2 =	gcem_bgtyy.text;					//예산년도
	var str3 =	gcds_data1_1.namevalue(row,"BGTFRMON");	//예산월  
	var str4 =	gcds_bgtdpt.namevalue(row1,"GBCD");			//신청본부
	var str5 =	gcem_bgtdept1.text;		//신청부서
	var str6 =	atc;											//계정과목
	var str7 =	fcd;											//관리항목
	var str8 =	sat;											//세목  
	gcds_janamt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s5?v_str1="+str1
	                   + "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
	                   + "&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7
	                   + "&v_str8="+str8;
	gcds_janamt.Reset();
}

/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
**********************************************************************************************/
function ln_Popup(e){

	if(e=="01") {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "./bgtdetail1_popup.jsp";
		arrParam[0]=""; //지점
		arrParam[1]=gcem_bgtyy.text; //예산년도
		arrParam[2]=gcem_bgtdept1.text; //예산부서
		arrParam[3]="";
		arrParam[4]="";
		arrParam[5]=gcem_bgtyy1.text; //예산월
		
		strPos = "dialogWidth:520px;dialogHeight:385px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(e=="01"){
				txt_atcodenm.value = arrParam[1];
				gcem_atcode.text = arrParam[0];
				gcem_result1.text = arrParam[4];
				g_satcode = arrParam[2]; //세목
				ln_RefQuery(arrParam[0]);	//세목구함

      	ft_cnt01.innerText = "예산 잔액 : " + gcem_result1.text;
				//alert(arrParam[2]);
				//alert(arrParam[4]);

			}else{
				//gcem_atcode2.text = arrParam[0];
				//txt_atcodenm2.value = arrParam[1];
				//ln_RefQuery2(arrParam[0]);	//관리항목 조회
			}
		} else {
			if(e=="01"){
				gcem_atcode.text   = "";
				txt_atcodenm.value = "";
			}else{
				gcem_atcode2.text   = "";
				txt_atcodenm2.value = "";
			}
		}



	}else if(e=="02") {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;

			strURL = "./bgtdetail1_popup.jsp";
			arrParam[0]=""; //지점
			arrParam[1]=gcem_bgtyy.text; //예산년도
			arrParam[2]=gcem_bgtdept1.text; //예산부서
			arrParam[3]="";
			arrParam[4]="";
			arrParam[5]=gcem_bgtyy1.text; //예산월
			strPos = "dialogWidth:520px;dialogHeight:385px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				if(e=="02"){
					txt_atcodenm2.value = arrParam[1];
					gcem_atcode2.text = arrParam[0];
					//gclx_fsrefcd2.bindColVal =arrParam[2];
					//alert(arrParam[0]);
					//gcem_result1.text = arrParam[4];
					ln_RefQuery2(arrParam[0]);	//세목구함
					g_satcode = arrParam[2]; //세목
					//alert("g_satcode::"+g_satcode);
					gclx_satcode2.bindcolval=g_satcode;
				}else{
					//gcem_atcode2.text = arrParam[0];
					//txt_atcodenm2.value = arrParam[1];
					//ln_RefQuery2(arrParam[0]);	//관리항목 조회
				}
			} else {
				if(e=="02"){
					gcem_atcode2.text   = "";
					txt_atcodenm2.value = "";
				}else{
					gcem_atcode2.text   = "";
					txt_atcodenm2.value = "";
				}
			}

	} else if(e=="03") {

		var arrResult	= new Array();
		var arrParam = new Array();
		var strURL;	
		var strPos;

		var arrSend	= new Array();
		arrSend[0]='H030003';
		window.dialogArguments=arrSend[0];

		strURL = "./h030003_popup.jsp";
		strPos = "dialogWidth:377px;dialogHeight:380px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);

	 	if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_nm.value = arrParam[0];
			txt_nmk.value = arrParam[1];
		} else {
			txt_nm.value = "";
			txt_nmk.value = "";
		}
	}

}


/******************************************************************************
	Description : 자산명 팝업
******************************************************************************/
function ln_Popup03(){
	var row ="";
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	var arrParam	= new Array();

	strURL = "./atcode_popup.jsp";
	strPos = "dialogWidth:496px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";"); 
		gcem_jasan.value = ln_Trim(arrParam[0]);
		txt_jasan.value = ln_Trim(arrParam[1]); 

		gclx_cadeptcd_3.bindcolval=ln_Trim(arrParam[0]);
//		alert(arrParam[0]);

	} else {
		gcem_jasan.value = "";
		txt_jasan.value = "";

	}
}




/***********************************************************************************************
	Description : 계정코드 찾기[예산신청내역]
**********************************************************************************************/
function ln_Popup2(row,atcd,e){
	/*if (atcd!=null){	//항목전용 아닌 경우
		gcds_fsrefcd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+atcd+"&v_str2=B";
		gcds_fsrefcd2.Reset();
		return false;
	}*/

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	arrParam[1]="B";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_data1_1.namevalue(row,"DVTFRACT") = arrParam[0];
		gcds_data1_1.namevalue(row,"ATKORNAM") = arrParam[1];

		gcds_fsrefcd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrParam[0]+"&v_str2=B";
		gcds_fsrefcd2.Reset();
	} else {
		gcds_data1_1.namevalue(row,"DVTFRACT") = "";
		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
	}
}

/***********************************************************************************************
	Description : 관리항목 찾기
**********************************************************************************************/
function ln_FsrefCode(e){
	if(e!=""){
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "./commdtil_popup_ifrm.jsp";
		arrParam[0]=e;
		arrParam[1]="";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"DVTFRSATCD") = arrParam[0];
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"CDNAM") = arrParam[1];
		} else {
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"DVTFRSATCD") = "";
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"CDNAM") = "";
		}

		if(ln_Chk('02')==false) return false;
			if(gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTRQDIV") == "01"){
				gcds_data1_1.namevalue(gcds_data1_1.rowposition,"DVTFRSATCD") = arrParam[0];	//세목
				gctr_data1_1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
				gctr_data1_1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
				gctr_data1_1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=B";
				gctr_data1_1.post();
			}else if(gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTRQDIV") == "04"){
			}else{
				//ln_Save();
			}
		//ln_Query('S');
	}
}

/***********************************************************************************************
	Description : 부서코드 - 관리항목 찾기
**********************************************************************************************/
function ln_FsrefDept(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./commdtil_popup_dept.jsp";
	arrParam[0]=gs_deptcd;
	arrParam[1]="";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTFRDEPT") = arrParam[0];
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTDEPTNM") = arrParam[1];
	} else {
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTFRDEPT") = "";
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTDEPTNM") = "";
	}

  /*
	if(ln_Chk('02')==false) return false;
		if(gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTRQDIV") == "04"){
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTFRDEPT") = arrParam[0];	//예산부서
			gctr_data1_1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
			gctr_data1_1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
			gctr_data1_1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=B";
			gctr_data1_1.post();
		}else{
			//ln_Save();
		}
   */
	//ln_Query('S');
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-예산신청내역, 1-변경예산신청
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3");
	for(var i=0;i<=2;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/***********************************************************************************************
	Description : 예산변경 찾기
	parameter   : e1:지점코드, e2:신청서번호, e3:예산년도, e4:신청부서, e5:관리항목코드
**********************************************************************************************/
function ln_DispControl(e1,e2,e3,e4,e5){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	var ls_data = gcds_data2.namevalue(gcds_data2.rowposition,"BGTRQST");	

//alert(ls_data);

	if(ls_data!='N'){

		strURL = "./bgtdetail_popup1.jsp";
		arrParam[0]=e1;
		arrParam[1]=e2;
		arrParam[2]=e3;
		arrParam[3]=e4;
		arrParam[4]=e5;
		strPos = "dialogWidth:885px;dialogHeight:579px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	} else {
		
		strURL = "./bgtdetail_popup.jsp";
		arrParam[0]=e1;
		arrParam[1]=e2;
		arrParam[2]=e3;
		arrParam[3]=e4;
		arrParam[4]=e5;
		strPos = "dialogWidth:885px;dialogHeight:579px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}
}






function ln_Popup_1(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam1.text;
	arrParam[1]=gcem_bgtdept1.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam1.text = arrParam[1];
		gcem_bgtdept1.text = arrParam[0];
//		gclx_bgtdiv5.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


function ln_Popup_2(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam2.text;
	arrParam[1]=gcem_bgtdept2.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam2.text = arrParam[1];
		gcem_bgtdept2.text = arrParam[0];
//		gclx_bgtdiv5.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


function ln_Popup_5(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam5.text;
	arrParam[1]=gcem_bgtdept5.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam5.text = arrParam[1];
		gcem_bgtdept5.text = arrParam[0];
		gclx_bgtdiv5.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data1_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+BGTRQNO">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_dbgtdpt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtrqst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!--comment id="__NSID__"><object  id=gcds_costcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script-->

<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtrqdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fsrefcd2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_janamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fdcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtrqst3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fdcode4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtrqst4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_deptemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfsrefcd2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_ssatcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_temp05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id=gcds_depttemp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_printtemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gctr_data1_1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	gcem_bgtrqno.enable = true;
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
		gcds_data1_1.ClearData();
	}else{
		ln_Query("02");
		////ln_Query2(); 임시막음
		////ln_Query3(); 임시막음
	}
</script>

<script language="javascript" for="gcds_data1_1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1_1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	/*************** 예산 잔액 계산 *******************/
	//ln_Popup2(row,gcem_atcode.text);		//관리항목
	var atc = gcem_atcode.text;					//피전용계정  
	var fsd = gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE");		//관리항목코드
	var sat = gclx_satcode.bindcolval;	//피전용세목
	//ln_JanAmt(atc,fsd,sat);							//예산 잔액계산
	//gcds_satcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+fsd;
	//gcds_satcode2.Reset();
	
	for(var i=1;i<=row;i++){
		if(gcds_data1.namevalue(i,"BGTRQDIV")=="01"){
			gcds_data1.namevalue(i,"BGTFRMON") = "";
		}
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	
	}
</script>

<script language="javascript" for="gcds_data4" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt04.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	
	}
</script>

<script language="javascript" for="gcds_data5" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode1.index=2;
	}else{
		gclx_fdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_deptemp" event="onloadCompleted(row,colid)">
	gs_vendcd = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	if(gcds_deptemp.countrow>0){
		gcem_bgtnam5.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept5.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

		gcem_bgtnam1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

		gcem_bgtnam2.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept2.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

	}else {
  }
</script>

<script language="javascript" for="gcds_bgtdpt" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>



<script language="javascript" for="gcds_dbgtdpt" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dbgtdpt" event="onloadCompleted(row,colid)">
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_bgtdpt2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>


<script language="javascript" for="gcds_fdcode3" event="onloadCompleted(row,colid)">
	gcds_fdcode3.InsertRow(1);
	gcds_fdcode3.NameValue(1,"FDCODE")="";
	gcds_fdcode3.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode3.index=2;
	}else{
		gclx_fdcode3.bindcolval=gs_fdcode;
	}
</script>


<script language="javascript" for="gcds_bgtrqst3" event="onloadCompleted(row,colid)">
	gcds_bgtrqst3.InsertRow(1);
	gcds_bgtrqst3.NameValue(1,"CDCODE")="";
	gcds_bgtrqst3.NameValue(1,"CDNAM")="";
	gclx_bgtrqdiv3.index = 0;
</script>

<script language="javascript" for="gcds_fdcode4" event="onloadCompleted(row,colid)">
	gcds_fdcode4.InsertRow(1);
	gcds_fdcode4.NameValue(1,"FDCODE")="";
	gcds_fdcode4.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode4.index=2;
	}else{
		gclx_fdcode4.bindcolval=gs_fdcode;
	}
</script>


<script language="javascript" for="gcds_bgtrqst4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	gcds_bgtrqst4.InsertRow(1);
	gcds_bgtrqst4.NameValue(1,"CDCODE")="";
	gcds_bgtrqst4.NameValue(1,"CDNAM")="";
	gclx_bgtrqdiv4.index = 0;
</script>

<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gclx_fsrefcd.index = 0;
	var str1 = gcds_fsrefcd.namevalue(row,"CDCODE");
	ln_SatQuery(str1);
</script>

<script language="javascript" for="gcds_sfsrefcd2" event="onloadCompleted(row,colid)">
	gclx_fsrefcd2.index = 0;
	var str1 = gcds_sfsrefcd2.namevalue(row,"CDCODE");
	ln_SatQuery2(str1);
</script>

<script language="javascript" for="gcds_fsrefcd2" event="onloadCompleted(row,colid)">
	var str1 = gcds_fsrefcd2.namevalue(row,"CDCODE");
	if(str1!="0003")
		ln_FsrefCode(str1);
</script>

<script language="javascript" for="gcds_satcode" event="onloadCompleted(row,colid)">
	if(row<1){
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="00";
		gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
		gclx_satcode.enable = false;
	}else{
		if(gcds_fsrefcd.namevalue(1,"CDCODE")!="0003"){
			gcds_satcode.InsertRow(1);
			gcds_satcode.NameValue(1,"CDCODE")="";
			gcds_satcode.NameValue(1,"CDNAM")="";
			gclx_satcode.enable = true;
		}else{
			gcds_satcode.InsertRow(1);
			gcds_satcode.NameValue(1,"CDCODE")="00";
			gcds_satcode.NameValue(1,"CDNAM")="00";
			gclx_satcode.index = 0;
			gclx_satcode.enable = false;
		}
	}
	if(g_satcode1=="T") {
		gclx_satcode.bindColVal = g_satcode;
	g_satcode1 = "F";

 } else if(g_satcode2=="T") {
		gclx_fsrefcd2.bindColVal = g_satcode2;
	g_satcode2 = "F";
}
</script>

<script language="javascript" for="gcds_satcode2" event="onloadCompleted(row,colid)">
	if(row<1){//그리드세목
		gcds_satcode2.InsertRow(1);
		gcds_satcode2.NameValue(1,"CDCODE")="00";
		gcds_satcode2.NameValue(1,"CDNAM")="00";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
	}else{
		if(gcds_fsrefcd2.namevalue(1,"CDCODE")!="0003"){
			gcds_satcode2.InsertRow(1);
			gcds_satcode2.NameValue(1,"CDCODE")="";
			gcds_satcode2.NameValue(1,"CDNAM")="";
			gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="ANY";
		}else{
			gcds_satcode2.InsertRow(1);
			gcds_satcode2.NameValue(1,"CDCODE")="00";
			gcds_satcode2.NameValue(1,"CDNAM")="00";
			gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
		}
	}
</script>

<script language="javascript" for="gcds_ssatcode2" event="onloadCompleted(row,colid)">
	if(row<1){
		gclx_satcode2.enable = false;
		gcds_ssatcode2.InsertRow(1);
		gcds_ssatcode2.NameValue(1,"CDCODE")="00";
		gcds_ssatcode2.NameValue(1,"CDNAM")="00";
		gclx_satcode2.index = 0;
	}else{
		gcds_ssatcode2.InsertRow(1);
		gcds_ssatcode2.NameValue(1,"CDCODE")="";
		gcds_ssatcode2.NameValue(1,"CDNAM")="";
		gclx_satcode2.enable = true;
	}
</script>

<script language="javascript" for="gcds_janamt" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	var janamt = gcds_janamt.namevalue(row,"JANAMT");
	if (janamt!=null) {
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"JANAMT") = janamt;
	}else{
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"JANAMT") = 0;
	}
</script>

<script language="javascript" for="gcds_print" event="onloadCompleted(row,colid)">
	if(gcds_print.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		//gcds_print.namevalue(1,"CURDT")  = gs_date;
		gcds_print.namevalue(1,"DEPTNM") = gcem_bgtnam2.text;
//		gcrp_print.preview();	//변경신청서 레포트
	}
</script>

<script language="javascript" for="gcds_sfdcode5" event="onloadCompleted(row,colid)">
	gcds_sfdcode5.InsertRow(1);
	gcds_sfdcode5.NameValue(1,"FDCODE")="";
	gcds_sfdcode5.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode5.index=2;
	}else{
		gclx_sfdcode5.bindcolval=gs_fdcode;
	}
</script>


<script language="javascript" for="gcds_bgtdiv5" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	gcds_bgtdiv5.InsertRow(1);
	gcds_bgtdiv5.NameValue(1,"BGTDIVCD")="";
	gcds_bgtdiv5.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv5.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv5.index = 0;
</script>

<script language="javascript" for="gcds_depttemp5" event="onloadCompleted(row,colid)">
	if(gcds_depttemp5.countrow>0){
    if(gcds_depttemp5.countrow == '1'){
      gcem_bgtnam5.text = gcds_depttemp5.namevalue(1,"CDNAM");
      gcem_bgtdept5.text = gcds_depttemp5.namevalue(1,"CDCODE");
      gclx_bgtdiv5.bindcolval = gcds_depttemp5.namevalue(1,"GBCD");
    }else{
      ln_Popup_5();
    }
	}else{
    gcem_bgtnam5.text = "";
    gcem_bgtdept5.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp1" event="onloadCompleted(row,colid)">
	if(gcds_depttemp1.countrow>0){
    if(gcds_depttemp1.countrow == '1'){
      gcem_bgtnam1.text = gcds_depttemp1.namevalue(1,"CDNAM");
      gcem_bgtdept1.text = gcds_depttemp1.namevalue(1,"CDCODE");
//      gclx_bgtdiv1.bindcolval = gcds_depttemp1.namevalue(1,"GBCD");
    }else{
      ln_Popup_1();
    }
	}else{
    gcem_bgtnam1.text = "";
    gcem_bgtdept1.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp2" event="onloadCompleted(row,colid)">
	if(gcds_depttemp2.countrow>0){
    if(gcds_depttemp2.countrow == '1'){
      gcem_bgtnam2.text = gcds_depttemp2.namevalue(1,"CDNAM");
      gcem_bgtdept2.text = gcds_depttemp2.namevalue(1,"CDCODE");
//      gclx_bgtdiv3.bindcolval = gcds_depttemp3.namevalue(1,"GBCD");
    }else{
      ln_Popup_2();
    }
	}else{
    gcem_bgtnam2.text = "";
    gcem_bgtdept2.text = "";
  }
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*예산신청내역*/
</script>

<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
 alert("OnPopup");
	if(gcds_data1_1.namevalue(row,"BGTRQDIV")!="01"){
		if(colid=="ATKORNAM"){
			ln_Popup2(row);	//계정찾기
		}else if(colid=="DVTFRSATCD"){
			ln_FsrefCode(gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE"));//세목찾기
		}else if(colid=="BGTDEPTNM"){
			ln_FsrefDept('0003');	//예산부서 찾기
		}
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>
  //alert("onclick");

	if(gcds_data1_1.namevalue(row,"BGTRQDIV") == "") {
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		gcds_data1_1.namevalue(row,"BGTFRMON") = "";
		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
		gcds_data1_1.namevalue(row,"DVTFRSATCD") = "";

	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="01"){//추가예산
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		//gcds_data1_1.namevalue(row,"BGTFRMON") = "";
		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
		gcds_data1_1.namevalue(row,"DVTFRSATCD") = "";

	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="02"){//기간전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="ANY";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
		gcds_data1_1.namevalue(row,"CDNAM")    = "";

	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV")=="03"){//항목전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="ANY";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="ANY";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV")=="04"){//부서전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('CDNAM','Edit')   ="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="ANY";
	}

	if(gcds_data1_1.namevalue(row,"BGTRQST")	== "A") {
		//gcgd_disp01.editable = true;
	}
	else {
		//gcgd_disp01.editable = false;
	}
	

</script>

<script language=JavaScript for=gcgd_disp01 event=OnKeyPress(kcode)>
		// alert("OnKeyPress");

</script>

<script language=JavaScript for=gcgd_disp01 event=OnCloseUp(row,colid)>
   // alert("OnCloseUp");

	if(gcds_data1_1.namevalue(row,"BGTRQDIV") == "") {
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		//gcds_data1_1.namevalue(row,"BGTFRMON") = "";
		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
		gcds_data1_1.namevalue(row,"DVTFRSATCD") = "";
	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="01"){//추가예산
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('CDNAM','Edit')   ="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		//gcds_data1_1.namevalue(row,"BGTFRMON") = "";
		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
		gcds_data1_1.namevalue(row,"CDNAM") = "";
	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="02"){//기간전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="ANY";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('CDNAM','Edit')="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		gcds_data1_1.namevalue(row,"ATKORNAM") = "";
		gcds_data1_1.namevalue(row,"CDNAM") = "";
	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="03"){//항목전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="ANY";
		gcgd_disp01.ColumnProp('CDNAM','Edit')="ANY";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')   ="None";
	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV")=="04"){//부서전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('CDNAM','Edit')   ="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="ANY";
	}

	/*피전용세목*/
	/*if(gcds_data1_1.namevalue(row,"DVTFRSATCD") !="") {
		var atc = gcds_data1_1.namevalue(row,"DVTFRACT");		//피전용계정
		var fsd = gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE");		//관리항목코드
		var sat = gcds_data1_1.namevalue(row,"DVTFRSATCD");	//피전용세목
		ln_JanAmt(atc,fsd,sat);	//예산 잔액계산
	}*/
	
	/*신청구분-그리드 선택시 잔액조회*/
	/*if(colid=="BGTRQDIV" && gcds_data1_1.namevalue(row,"BGTRQDIV")=="01" && gcds_data1_1.namevalue(row,"DVTFRSATCD")=="") {	
		////ln_Popup2(row,gcem_atcode.text);		//관리항목
		var atc = gcem_atcode.text;					//피전용계정  
		var fsd = gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE");		//관리항목코드
		var sat = gclx_satcode.bindcolval;	//피전용세목
		///ln_JanAmt(atc,fsd,sat);	//예산 잔액계산
	}else if(colid=="BGTRQDIV" && gcds_data1_1.namevalue(row,"BGTRQDIV")=="02" && gcds_data1_1.namevalue(row,"DVTFRSATCD")=="") {	
		ln_Popup2(row,gcem_atcode.text);		//관리항목
		var atc = gcem_atcode.text;					//피전용계정  
		var fsd = gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE");		//관리항목코드
		var sat = gclx_satcode.bindcolval;	//피전용세목
		///ln_JanAmt(atc,fsd,sat);	//예산 잔액계산
	}else if(colid=="BGTRQDIV" && gcds_data1_1.namevalue(row,"BGTRQDIV")=="03" && gcds_data1_1.namevalue(row,"DVTFRSATCD")=="") {	
		ln_Popup2(row,gcem_atcode.text);		//관리항목
		var atc = gcem_atcode.text;					//피전용계정  
		var fsd = gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE");		//관리항목코드
		var sat = gclx_satcode.bindcolval;	//피전용세목
		ln_JanAmt(atc,fsd,sat);	//예산 잔액계산
	}*/
</script>

<script language=JavaScript for=gcem_bgtnam5 event=OnKillFocus()>
  if(gcem_bgtnam5.text!=""){
    gcem_bgtdept5.text = "";
    gcds_depttemp5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam5.text;
    gcds_depttemp5.Reset();
  }else{
    gcem_bgtdept5.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept5 event=OnKillFocus()>
  if(gcem_bgtdept5.text!=""){
    gcem_bgtnam5.text="";
    gcds_depttemp5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept5.text+"&v_str2=";
    gcds_depttemp5.Reset();
  }else{
    gcem_bgtnam5.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam1 event=OnKillFocus()>
  if(gcem_bgtnam1.text!=""){
    gcem_bgtdept1.text = "";
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam1.text;
    gcds_depttemp1.Reset();
  }else{
    gcem_bgtdept1.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept1 event=OnKillFocus()>
  if(gcem_bgtdept1.text!=""){
    gcem_bgtnam1.text="";
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept1.text+"&v_str2=";
    gcds_depttemp1.Reset();
  }else{
    gcem_bgtnam1.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam2 event=OnKillFocus()>
  if(gcem_bgtnam2.text!=""){
    gcem_bgtdept2.text = "";
    gcds_depttemp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam2.text;
    gcds_depttemp2.Reset();
  }else{
    gcem_bgtdept2.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept2 event=OnKillFocus()>
  if(gcem_bgtdept2.text!=""){
    gcem_bgtnam2.text="";
    gcds_depttemp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept2.text+"&v_str2=";
    gcds_depttemp2.Reset();
  }else{
    gcem_bgtnam2.text="";
  }
</script>



<script language=JavaScript for=gcgd_disp01 event=CanColumnPosChange(row,colid)>
   //alert("CanColumnPosChange");

  if(colid=='BGTRQDIV' || colid=='BGTRQAMT' ){
    var tot = 0;
      for(var k=1; k<=gcds_data1_1.countrow;k++){
        if(gcds_data1_1.namevalue(k,"BGTRQDIV")!="01"){
          tot = tot+gcds_data1_1.namevalue(k,"BGTRQAMT");
        }
      }
    ft_cnt01.innerText = "추가 예산외 금액 : " + tot;
    if(gcem_result1.text<tot){
      alert("기존 잔액을 초과했습니다.");
      gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTRQAMT")=0;
    ft_cnt01.innerText = "추가 예산외 금액 : " + 0;
      return false;
    }
  }


	if(colid=="BGTFRMON") {	//예산 잔액계산(피전용월 선택시)
		var frmon = gcds_data1_1.namevalue(row,"BGTFRMON");
		var gdiv  = gcds_data1_1.namevalue(row,"BGTRQDIV");
		if(gdiv!="01" && frmon<10 && frmon!=0 && frmon.length<2){//월체크(피전용월)
			gcds_data1_1.namevalue(row,"BGTFRMON") = "0"+frmon;
		}

		/*ln_Popup2(row,gcem_atcode.text);	//관리항목
		var atc = gcem_atcode.text;//gcds_data1_1.namevalue(row,"DVTFRACT");		//피전용계정  
		var fsd = gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE");		//관리항목코드
		var sat = gclx_satcode.bindcolval;//gcds_data1_1.namevalue(row,"DVTFRSATCD");	//피전용세목
		ln_JanAmt(atc,fsd,sat);	//예산 잔액계산
		*/
	}

	if(colid=="BGTTOMON") {	//월체크(배정월)
		var tomon = gcds_data1_1.namevalue(row,"BGTTOMON");
		if(tomon<10 && tomon!=0 && tomon.length<2){
			gcds_data1_1.namevalue(row,"BGTTOMON") = "0"+tomon;
		}
	}


	return true;
</script>

<script language=JavaScript for=gcgd_disp01 event=OnCloseUp(row,colid)>
	
	if(colid=="BGTRQDIV") {
		gcds_data1_1.namevalue(row,"BGTTOMON") = gcem_bgtyy1.text;
		gcds_data1_1.namevalue(row,"BGTFRMON") = gcem_bgtyy1.text;
	}

</script>

<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	gcem_bgtrqno.enable = true;
	var f01 = gcds_data2.namevalue(row,"FDCODE");		//지점코드      
	var f02 = gcds_data2.namevalue(row,"BGTRQNO");	//신청서번호    
	var f03 = gcds_data2.namevalue(row,"BGTYY");		//예산년도      
	var f04 = gcds_data2.namevalue(row,"BGTDPT");		//신청부서      
	var f05 = gcds_data2.namevalue(row,"FSREFCD");	//관리항목코드  
	ln_DispControl(f01,f02,f03,f04,f05);
</script>

<script language=JavaScript for=gcgd_disp02 event=OnClick(Row,Colid)>
	if (Colid=="CHK") {
		for (var i=1; i<=gcds_data2.countrow;i++) {
			if(gcds_data2.namevalue(i,"CHK")=="T") {
				g_fdcode  = gcds_data2.namevalue(i,"FDCODE");
				g_bgtrqno = gcds_data2.namevalue(i,"BGTRQNO");
				break;
			}
		}
	}
</script>

<!--<script language=JavaScript for=gcgd_disp04 event=OnDblClick(row,colid)>
	ln_DispChk(0);	//변경신청탭
	gcte_disp.ActiveIndex = 1;
	var row  = gcds_data4.rowposition;
	var str1 = gcds_data4.namevalue(row,"FDCODE");	//지점코드
	var str2 = gcds_data4.namevalue(row,"BGTRQNO");	//신청서번호
	var str3 = gcds_data4.namevalue(row,"BGTYY");		//예산년도
	var str4 = gcds_data4.namevalue(row,"BGTDPT");	//신청부서
	var str5 = gcds_data4.namevalue(row,"FSREFCD");	//관리항목코드
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
	gcds_data1.Reset();
</script>-->

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
	SaveCheck = "Y";
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	SaveCheck = "N";
</script>

<script language=JavaScript for=gctr_data1_1 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data1_1 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()">
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a080003_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="position:relative;left:0px;width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=변경신청</T>									
							  <T>divid=div_2		title=변경예산신청서</T>
								<T>divid=div_3    title=변경신청현황</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
						<!-- <T>divid=div_3		title=예산변경현황</T>
						<T>divid=div_3		title=항목조회</T><T>divid=div_4		title=잔액조회</T> -->
					</td>
				</tr>
			</table>
		</td>
  </tr>
	<tr><td height=4></td></tr>
</table>

<!-- 변경신청 -------------------------------------------------------------------------------------------------->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" style="display:block">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab21" style="width:95px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:90px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">신청서번호</td>
				<td class="tab21" width="95px">
					<comment id="__NSID__"><object  id=gcem_bgtrqno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:85px" onKeydown="if(event.keyCode==13) ln_Query('01')">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="############">
						<param name=PromptChar	value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;&nbsp;도</td>
				<td class="tab21" width="110px">
					<comment id="__NSID__"><object  id=gcem_bgtyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:3px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script><font style="position:relative; left:5px;top:-3px;">년</font>
					<comment id="__NSID__"><object  id=gcem_bgtyy1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:3px; width:20px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script><font style="position:relative; left:5px;top:-3px;">월</font>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">담당부서</td>
				<td class="tab22">
					<input id=txt_deptcd type="hidden" class="txt11" style="position:relative;top:-1px;left:5px;width:108px;">
					<input id=txt_deptnm type="text" class="txt11" style="position:relative;top:-1px;left:5px;">
				</td>
			</tr>
			<tr> 				
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">담&nbsp;당&nbsp;자</td>
				<td class="tab21">
					<input id=txt_empno type="hidden" class="txt11" style="position:relative;top:-1px;left:5px;width:108px;">
					<input id=txt_empnm type="text"   class="txt11" style="position:relative;top:-1px;left:5px;width:90px;">
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">신청서상태</td>
				<td class="tab21">
					<comment id="__NSID__"><object  id=gclx_bgtrqst classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:85px;">
						<param name=CBData			    value="^ ,Y^승인완료,R^승인요청,N^작성중,B^반송"><!-- C^승인취소 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
						<param name=enable					value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">작성일자</td>
				<td class="tab21"><nobr>
					<comment id="__NSID__"><object  id=gcem_wrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">신청부서</td>
				<td class="tab22">
        

          <comment id="__NSID__"><object  id=gcem_bgtnam1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup_1()">
          <comment id="__NSID__"><object  id=gcem_bgtdept1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>

        
        
        
				</td>
			</tr>
			<tr> 				
				<!-- <td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">원가구분</td>
				<td class="tab21">
					<comment id="__NSID__"><object  id=gclx_costcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:200px;">
						<param name=ComboDataID			value="gcds_costcd">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
						<param name=Enable					value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td> -->
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">계정과목</td>
				<td class="tab21" width="350px" colspan="3"><nobr>
					<input id=txt_atcodenm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:200px;">
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('01')">
					<comment id="__NSID__"><object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">잔&nbsp;&nbsp;&nbsp;&nbsp;액</td>
				<td class="tab21" width="100px" ><nobr>
				<comment id="__NSID__"><OBJECT id=gcem_result1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:5px;top:2px; width:90px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Maxlength     value="15">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">세&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td class="tab22" width="300px"><nobr>
					<!-- display:none -->
					<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- hidden -->
					<input id=txt_satcode type="hidden" class="txt11" style="position:relative;top:0px;left:5px;width:158px;">
					<comment id="__NSID__"><object  id=gclx_satcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode"><!-- 세목 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^160">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr> 
				<td style="height:25px;width:80px;">&nbsp;</td>
				<td colspan="5">&nbsp;</td>
				<!-- <td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">적&nbsp;&nbsp;&nbsp;&nbsp;요</td>
				<td class="tab23" colspan="5"><comment id="__NSID__">
					<object  id=gcem_bgtrqnote classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:498px;height:20px;position:relative;left:5px;top:1px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td> -->
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="5px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:250px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"				VALUE="gcds_data1_1">
						<PARAM NAME="IndWidth"			VALUE="0">
						<PARAM NAME="BorderStyle"		VALUE="0">
						<PARAM NAME="Fillarea"			VALUE="true">
						<PARAM NAME="Editable"			VALUE="true">
						<PARAM NAME="UsingOneClick" VALUE="1">
						<param name="ViewSummary"		value=1>
						<PARAM NAME="Format"				VALUE="  
							<C> Name='선택'					ID=CHK			  HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center EditStyle='CheckBox' Pointer=Hand</C> 
							<C> Name='순번'					ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center </C> 
							<C> Name='신청구분'			ID=BGTRQDIV	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center  EditStyle=Lookup  Data='gcds_bgtrqdiv:CDCODE:CDNAM'</C> 
							<C> Name='금액'					ID=BGTRQAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right	 </C> 
							<C> Name='예산잔액'			ID=JANAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=right	 Edit=None Color=blue show=false</C> 
							<C> Name='배정월'				ID=BGTTOMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center Edit=none  EditStyle='Combo' Data='1:1월,2:2월,3:3월,4:4월,5:5월,6:6월,7:7월,8:8월,9:9월,10:10월,11:11월,12:12월'</C>
							<C> Name='피전용월'			ID=BGTFRMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center EditStyle='Combo' Data='1:1월,2:2월,3:3월,4:4월,5:5월,6:6월,7:7월,8:8월,9:9월,10:10월,11:11월,12:12월'</C>
							<C> Name='피전용계정'		ID=ATKORNAM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=135	align=left	 EditStyle='Popup'</C> 
							<C> Name='피전용세목'		ID=CDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=135	align=left	 EditStyle='Popup' Edit=none</C> 
							<C> Name='피전용부서'		ID=BGTDEPTNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=135	align=left	 EditStyle='Popup'</C>
							<C> Name='승인상태'     ID=BGTRQST    HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center EditStyle=Combo Data='Y:승인완료,N:작성중,R:승인요청,B:반송' Edit=none</C>
						"> <!-- 피전용세목 : EditStyle='Lookup' Data='gcds_satcode2:CDCODE:CDNAM' Data='gcds_dbgtdpt:BGTDEPT:BGTNAM'-->
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset>
					<fieldset style="position:relative;left:8px;width:866px;height:53px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;"><nobr><input type="text" class="txtbox" value="신청사유:" style="position:relative;top:-30px;left:5px;border:0;width:70px">
					<comment id="__NSID__">
					<object  id=gcem_whybgtrqnote classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:785px;height:51px;position:relative;left:1px;top:3px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script></nobr>
					</fieldset>
					</td>
				</tr>
				<tr>
					<td align="right">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_Reset()">
						<img src="../../Common/img/btn/com_b_delete.gif"	style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_save.gif"		style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_Save()">
						<img src="../../Common/img/btn/com_b_rowadd.gif" style="position:relative;right:5px;top:-358px;cursor:hand" onClick="ln_RowAdd('01')">
						<img src="../../Common/img/btn/com_b_rowdel.gif" style="position:relative;right:5px;top:-358px;cursor:hand" onClick="ln_RowDel('01')">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 

<!-- 변경예산신청서 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab21"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:95px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^95">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">작성일자</td>
				<td class="tab21" width="186px"><nobr><comment id="__NSID__">
					<object id=gcem_swrdtfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_swrdtfr2', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">~
					<comment id="__NSID__"><object id=gcem_swrdtto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_swrdtto2', 'Text')" style="position:relative;width:20px;left:-5px;top:1px;cursor:hand;"></nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">신청부서</td>
				<td class="tab21" style="height:25px;width:300px;">
        

          <comment id="__NSID__"><object  id=gcem_bgtnam2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup_2()">
          <comment id="__NSID__"><object  id=gcem_bgtdept2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>
        
        
        
        
        
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">신청서상태</td>
				<td class="tab22" style="width:120px">			
					<comment id="__NSID__"><object  id=gclx_bgtrqst2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
						<param name=CBData			    value="^ ,Y^승인완료,R^승인요청,N^작성중,B^반송"><!-- C^승인취소 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
						<param name=enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>			
			</tr>
			<tr> 				
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정과목</td>
				<td class="tab23" width="386px" colspan="3"><nobr>
					<input id=txt_atcodenm2 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:235px;">
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('02')">
<comment id="__NSID__"><object  id=gcem_atcode2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">세&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td class="tab23" width="120x"><nobr><comment id="__NSID__">
					<object  id=gclx_fsrefcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_sfsrefcd2"><!-- 관리항목코드 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<input id=txt_satcode2 type="hidden" class="txt11" style="position:relative;top:0px;left:5px;width:158px;">
					<comment id="__NSID__"><object  id=gclx_satcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_ssatcode2"><!-- 세목 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^160">
						<param name=BindColumn			value="CDCODE">
						<param name=enable					value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">담&nbsp;당&nbsp;자</td>
				<td width="120px">
					<input type="text" style="position:relative;left:5px;top:-3px;width:45px" class="txt11" id="txt_nmk">
					<input type="hidden" style="position:relative;left:5px;top:-3px;width:1px" class="txt11" id="txt_nm">
				  <img src="../../Common/img/btn/com_b_find.gif" alt="성명을 검색합니다" style="position:relative;left:0px;top:3px;cursor:hand;" onclick="ln_Popup('03')" >
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="5px"></td></tr>
	<tr>
		<td height="2px" align="right">
			<img src="../../Common/img/btn/com_b_appreq.gif"	style="position:relative;right:3px;top:-127px;cursor:hand" onClick="ln_SanReq()">
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:3px;top:-127px;cursor:hand" onClick="ln_Print('05')">
			<img src="../../Common/img/btn/com_b_query.gif"		style="position:relative;right:3px;top:-127px;cursor:hand" onclick="ln_Query('05')">
		</td>
	</tr>
	<tr> 			
		<td style="width:280" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
			<object  id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
					style="position:relative;top:-28px;left:8px;width:864px;height:362px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"				VALUE="gcds_data2">
				<PARAM NAME="IndWidth"			VALUE="0">
				<PARAM NAME="BorderStyle"		VALUE="0">
				<PARAM NAME="Fillarea"			VALUE="true">
				<PARAM NAME="Editable"			VALUE="true">
				<!-- <PARAM NAME="ViewSummary"		VALUE="1"> -->
				<PARAM NAME="UsingOneClick" VALUE="1">
				<PARAM NAME="Format"				VALUE="  
				<C> Name='선택'				ID=CHK			  HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center  SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' EditStyle='CheckBox' Pointer=Hand</C> 
				<C> Name='작성일자'		ID=WRDT				HeadAlign=Center HeadBgColor=#B9D4DC Width=95	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' mask='XXXX/XX/XX' Edit=none</C> 
				<C> Name='예산구분'		ID=BGTRQDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center	SumBgColor=#C3D0DB SumText=''	BgColor='#f5f5f5' EditStyle='lookup' Data='gcds_bgtrqdiv:CDCODE:CDNAM' Edit=none</C> 
				<C> Name='금액'				ID=BGTRQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95		align=right	SumBgColor=#C3D0DB SumText=''		BgColor='#f5f5f5'	Edit=none</C> 
				<F> Name='계정과목'		ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left		SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				<F> Name='세목'				ID=CDNAM   		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				<F> Name='상태'				ID=BGTRQST   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none EditStyle='Combo' Data='Y:승인완료,N:작성중,R:승인요청,B:반송'</F> 
				<F> Name='신청서번호'	ID=BGTRQNO 		HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				<F> Name='순서'				ID=BGTRQSEQ 		HeadAlign=Center HeadBgColor=#B9D4DC Width=40	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;top:-28px;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
			</fieldset>
			</td>
		</tr>
	</table>

<!-- 변경신청현황 ===========================================================================================================-->
<fieldset id=field3 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none;position:relative;left:0px">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab23" style="width:90px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode5">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^80">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;도</td>
				<td class="tab23" width="50px">
					<comment id="__NSID__"><object  id=gcem_bgtyy55 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">신청본부</td>
				<td class="tab23" width="90px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv5">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">신청부서</td>
				<td>


          <comment id="__NSID__"><object  id=gcem_bgtnam5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup_5()">
          <comment id="__NSID__"><object  id=gcem_bgtdept5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>



				</td>
				<!--td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">신청자</td>
				<td width="90px">
					<input id=txt_empno type="text" class="txt11" style="position:relative;top:0px;left:5px;width:70px;">
				</td-->
				<td align=right>
					<img src="../../Common/img/btn/com_b_print.gif"   style="position:relative;right:5px;top:-63px;cursor:hand" onclick="ln_Print('06')">
					<img src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-63px;cursor:hand" onclick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:-63px;cursor:hand" onclick="ln_Query('06')">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:390px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data5">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="true">
						<param name="ColSizing"		value="true">
						<PARAM NAME="ViewSummary"	VALUE="1">
						<PARAM NAME="Format"			VALUE="  
						<F> Name='계정과목'	ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=158	BgColor='#f5f5f5' align=left Edit=None SumText='합계' SumBgColor='#C3D0DB' Edit=none</F> 
						<F> Name='세목'			ID=SATNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=158	BgColor='#f5f5f5' align=left Edit=None SumText='' SumBgColor='#C3D0DB' Edit=none</F> 
						
						<G> Name='1월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='2월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM02 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM02 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='3월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM03 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM03 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='4월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM04 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM04 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='5월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM05 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM05 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='6월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM06 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM06 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='7월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM07 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM07 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='8월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM08 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM08 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='9월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM09 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM09 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='10월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM10 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM10 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='11월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM11 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM11 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						
						<G> Name='12월'			ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTMM12 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGMM12 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>

						<G> Name='계'				ID=BGTMM01 HeadAlign=Center HeadBgColor=#B9D4DC Width=180
							<C> Name='변경액'	ID=BGTSUM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=blue Edit=none</C>
							<C> Name='배정액'	ID=CHGSUM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right SumText=@sum	SumBgColor='#C3D0DB' color=red  Edit=none</C>
						</G>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - Master
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data1>
	<param name=BindInfo		value='  
		<C>Col=FDCODE				Ctrl=gclx_fdcode1				Param=BindColVal</C>
		<C>Col=BGTRQNO			Ctrl=gcem_bgtrqno				Param=text</C>
		<C>Col=BGTYY			  Ctrl=gcem_bgtyy				  Param=text</C>
		<C>Col=DEPTCD			  Ctrl=txt_deptcd				  Param=value</C>
		<C>Col=DEPTNM			  Ctrl=txt_deptnm				  Param=value</C>
		<C>Col=EMPNO			  Ctrl=txt_empno				  Param=value</C>
		<C>Col=EMPNMK			  Ctrl=txt_empnm					Param=value</C>
		<C>Col=BGTRQST			Ctrl=gclx_bgtrqst				Param=BindColVal</C>
		<C>Col=WRDT					Ctrl=gcem_wrdt					Param=text</C>
		<C>Col=BGTDPT			  Ctrl=gcem_bgtdept1				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_atcodenm				Param=value</C>
		<C>Col=ATCODE			  Ctrl=gcem_atcode				Param=text</C>
		<C>Col=SATCODE			Ctrl=gclx_satcode				Param=BindColVal</C>
		<C>Col=CDNAM			  Ctrl=txt_satcode				Param=value</C>
	'>
		<!--C>Col=COSTCD			Ctrl=gclx_costcd				Param=BindColVal</C-->
		<!--C>Col=FSREFCD			Ctrl=gclx_fsrefcd				Param=BindColVal</C-->
		<!--C>Col=BGTRQNOTE		Ctrl=gcem_bgtrqnote			Param=text</C-->
		<!--C>Col=WHYRQNOTE		Ctrl=gcem_whybgtrqnote	Param=text</C-->
		<!--C>Col=WHYRQNOTE		Ctrl=gcem_whybgtrqnote2	Param=text</C-->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  - 변경예산신청서
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data3_1>
	<param name=BindInfo		value='  
		<C>Col=BGTAMT			  Ctrl=gcem_bgtamt					Param=text</C>
		<C>Col=REBGTAMT			Ctrl=gcem_rebgtamt				Param=text</C>
		<C>Col=RESULTAMT		Ctrl=gcem_resultamt				Param=text</C>
		<C>Col=REMAINTAMT		Ctrl=gcem_remaintamt			Param=text</C>
		<C>Col=BGTRQAMT			Ctrl=gcem_bgtrqamt				Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print1">
	<param name="DetailDataID"		value="gcds_printtemp">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=619 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=37 ,top=124 ,right=876 ,bottom=201 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=2765 ,top=193 ,right=2765 ,bottom=548 </L>
	<T>id='부   서   명 :' ,left=37 ,top=347 ,right=267 ,bottom=400 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='요 청 일 자 :' ,left=37 ,top=286 ,right=267 ,bottom=341 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청서번호 :' ,left=37 ,top=405 ,right=267 ,bottom=458 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTRQNO', left=273, top=405, right=852, bottom=458, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1810 ,top=548 ,right=2765 ,bottom=548 </L>
	<T>id='담당자' ,left=1879 ,top=201 ,right=2048 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2051 ,top=193 ,right=2051 ,bottom=548 </L>
	<L> left=1810 ,top=193 ,right=1810 ,bottom=548 </L>
	<L> left=2228 ,top=193 ,right=2228 ,bottom=548 </L>
	<L> left=2405 ,top=193 ,right=2405 ,bottom=548 </L>
	<T>id='검   토' ,left=2056 ,top=201 ,right=2225 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=2233 ,top=201 ,right=2402 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본부장' ,left=2413 ,top=201 ,right=2580 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사  장' ,left=2590 ,top=201 ,right=2762 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2585 ,top=193 ,right=2585 ,bottom=548 </L>
	<L> left=1873 ,top=254 ,right=2765 ,bottom=254 </L>
	<L> left=1873 ,top=193 ,right=1873 ,bottom=548 </L>
	<L> left=1873 ,top=400 ,right=2765 ,bottom=400 </L>
	<T>id='결' ,left=1815 ,top=243 ,right=1868 ,bottom=294 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='재' ,left=1815 ,top=442 ,right=1868 ,bottom=492 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1810 ,top=132 ,right=2765 ,bottom=196 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='신청금액 내역' ,left=1815 ,top=135 ,right=2762 ,bottom=188 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=32 ,top=111 ,right=865 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='예산 변경 신청서' ,left=34 ,top=119 ,right=860 ,bottom=180 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='KBUNAM', left=273, top=347, right=852, bottom=400, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=273, top=286, right=852, bottom=341, align='left' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=143 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=185 ,top=71 ,right=2765 ,bottom=71 </L>
	<T>id='월' ,left=191 ,top=77 ,right=246 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=48 ,top=5 ,right=180 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서명' ,left=2164 ,top=77 ,right=2400 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용액' ,left=1209 ,top=77 ,right=1381 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실행액' ,left=1029 ,top=77 ,right=1201 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='잔액' ,left=1392 ,top=77 ,right=1564 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=1572 ,top=77 ,right=1627 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='변        경' ,left=1572 ,top=5 ,right=2762 ,bottom=69 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기          존' ,left=191 ,top=5 ,right=1564 ,bottom=69 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='요청액' ,left=2408 ,top=77 ,right=2580 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가용잔액' ,left=2590 ,top=77 ,right=2762 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=3 ,right=2765 ,bottom=3 </L>
	<T>id='세목' ,left=1947 ,top=77 ,right=2154 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정과목' ,left=1638 ,top=77 ,right=1937 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서명' ,left=781 ,top=77 ,right=1019 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세목' ,left=566 ,top=77 ,right=773 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정과목' ,left=257 ,top=77 ,right=556 ,bottom=140 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=3 ,right=40 ,bottom=143 </L>
	<L> left=40 ,top=143 ,right=2765 ,bottom=143 </L>
	<L> left=185 ,top=3 ,right=185 ,bottom=143 </L>
	<L> left=249 ,top=71 ,right=249 ,bottom=143 </L>
	<L> left=558 ,top=71 ,right=558 ,bottom=143 </L>
	<L> left=775 ,top=71 ,right=775 ,bottom=143 </L>
	<L> left=1021 ,top=71 ,right=1021 ,bottom=143 </L>
	<L> left=1204 ,top=71 ,right=1204 ,bottom=143 </L>
	<L> left=1384 ,top=71 ,right=1384 ,bottom=143 </L>
	<L> left=1566 ,top=3 ,right=1566 ,bottom=143 </L>
	<L> left=1630 ,top=71 ,right=1630 ,bottom=143 </L>
	<L> left=1942 ,top=71 ,right=1942 ,bottom=143 </L>
	<L> left=2156 ,top=71 ,right=2156 ,bottom=143 </L>
	<L> left=2402 ,top=71 ,right=2402 ,bottom=143 </L>
	<L> left=2585 ,top=71 ,right=2585 ,bottom=143 </L>
	<L> left=2765 ,top=3 ,right=2765 ,bottom=143 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=67 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='JANAMT', left=1392, top=0, right=1564, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='USEAMT', left=1209, top=0, right=1381, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REALBGT', left=1029, top=0, right=1201, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='KBUNAM', left=781, top=0, right=1019, bottom=61, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SATNAM', left=566, top=0, right=773, bottom=61, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTTOMON', left=191, top=0, right=246, bottom=61, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LASAMT', left=2590, top=0, right=2762, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTRQAMT', left=2408, top=0, right=2580, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BUSNAM', left=2164, top=0, right=2400, bottom=61, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TATNAM', left=1947, top=0, right=2154, bottom=61, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTFRMON', left=1572, top=0, right=1627, bottom=61, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1630 ,top=0 ,right=1630 ,bottom=66 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=66 </L>
	<L> left=2156 ,top=0 ,right=2156 ,bottom=66 </L>
	<L> left=1566 ,top=0 ,right=1566 ,bottom=66 </L>
	<L> left=1384 ,top=0 ,right=1384 ,bottom=66 </L>
	<L> left=2402 ,top=0 ,right=2402 ,bottom=66 </L>
	<L> left=2585 ,top=0 ,right=2585 ,bottom=66 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=66 </L>
	<C>id='TGNAM', left=1638, top=0, right=1937, bottom=61, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FGNAM', left=257, top=0, right=556, bottom=61, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DIVNAME', left=48, top=0, right=180, bottom=61, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 </L>
	<L> left=185 ,top=0 ,right=185 ,bottom=66 </L>
	<L> left=249 ,top=0 ,right=249 ,bottom=66 </L>
	<L> left=558 ,top=0 ,right=558 ,bottom=66 </L>
	<L> left=775 ,top=0 ,right=775 ,bottom=66 </L>
	<L> left=1021 ,top=0 ,right=1021 ,bottom=66 </L>
	<L> left=1204 ,top=0 ,right=1204 ,bottom=66 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=598 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=0 ,right=2765 ,bottom=0 </L>
	<L> left=2051 ,top=180 ,right=2051 ,bottom=534 </L>
	<L> left=1810 ,top=534 ,right=2765 ,bottom=534 </L>
	<L> left=1873 ,top=386 ,right=2765 ,bottom=386 </L>
	<L> left=1873 ,top=241 ,right=2765 ,bottom=241 </L>
	<T>id='담당자' ,left=1879 ,top=188 ,right=2048 ,bottom=238 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2228 ,top=180 ,right=2228 ,bottom=534 </L>
	<L> left=2405 ,top=180 ,right=2405 ,bottom=534 </L>
	<T>id='팀   장' ,left=2056 ,top=188 ,right=2225 ,bottom=238 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=2233 ,top=188 ,right=2402 ,bottom=238 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본부장' ,left=2413 ,top=188 ,right=2580 ,bottom=238 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사  장' ,left=2590 ,top=188 ,right=2762 ,bottom=238 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2585 ,top=180 ,right=2585 ,bottom=534 </L>
	<L> left=1873 ,top=180 ,right=1873 ,bottom=534 </L>
	<T>id='승' ,left=1815 ,top=230 ,right=1868 ,bottom=280 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=1815 ,top=429 ,right=1868 ,bottom=479 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2765 ,top=180 ,right=2765 ,bottom=534 </L>
	<X>left=1810 ,top=119 ,right=2765 ,bottom=185 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1810 ,top=180 ,right=1810 ,bottom=534 </L>
	<T>id='-신청사유 :' ,left=48 ,top=32 ,right=249 ,bottom=85 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WHYNOTE', left=254, top=32, right=1783, bottom=85, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='※예산주관 부서의견 :' ,left=45 ,top=138 ,right=529 ,bottom=191 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=1193, top=331, right=1524, bottom=384, align='left' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='※접수일 :' ,left=997 ,top=331 ,right=1188 ,bottom=384 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='예산주관부서' ,left=1815 ,top=122 ,right=2762 ,bottom=175 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=Footer ,left=0 ,top=1904 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2397 ,top=3 ,right=2775 ,bottom=85</I>
	<L> left=40 ,top=0 ,right=2770 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print2">
	<param name="DetailDataID"		value="gcds_print2">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='결' ,left=1519 ,top=153 ,right=1588 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=378 ,right=2813 ,bottom=378 </L>
	<L> left=1590 ,top=161 ,right=2813 ,bottom=161 </L>
	<T>id='사장' ,left=2572 ,top=103 ,right=2810 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본부장' ,left=2328 ,top=103 ,right=2564 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=2085 ,top=103 ,right=2318 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀장' ,left=1842 ,top=103 ,right=2074 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담당' ,left=1598 ,top=103 ,right=1831 ,bottom=159 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=98 ,right=2813 ,bottom=98 </L>
	<T>id='＊＊＊요청부서＊＊＊' ,left=1971 ,top=21 ,right=2416 ,bottom=85 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=201, top=331, right=1005, bottom=384, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='부 서 명:' ,left=40 ,top=331 ,right=196 ,bottom=384 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='요청일자:' ,left=40 ,top=275 ,right=196 ,bottom=328 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HTITLE', left=40, top=98, right=1008, bottom=175, align='left' ,mask='XXXX년 부서별 변경신청 현황(1월~12월)', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=40 ,top=177 ,right=1005 ,bottom=177 </L>
	<L> left=40 ,top=185 ,right=1005 ,bottom=185 </L>
	<T>id='재' ,left=1519 ,top=246 ,right=1588 ,bottom=325 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=98 ,right=1513 ,bottom=378 </L>
	<L> left=2566 ,top=98 ,right=2566 ,bottom=378 </L>
	<L> left=2323 ,top=98 ,right=2323 ,bottom=378 </L>
	<L> left=2077 ,top=98 ,right=2077 ,bottom=378 </L>
	<L> left=1834 ,top=98 ,right=1834 ,bottom=378 </L>
	<L> left=2813 ,top=98 ,right=2813 ,bottom=378 </L>
	<C>id='REQDT', left=201, top=275, right=450, bottom=328, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1590 ,top=98 ,right=1590 ,bottom=378 </L>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=3 ,right=2813 ,bottom=3 </L>
	<T>id='계정과목' ,left=48 ,top=8 ,right=392 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=3 ,right=40 ,bottom=101 </L>
	<L> left=394 ,top=3 ,right=394 ,bottom=101 </L>
	<L> left=865 ,top=3 ,right=865 ,bottom=101 </L>
	<L> left=1024 ,top=3 ,right=1024 ,bottom=101 </L>
	<L> left=1183 ,top=3 ,right=1183 ,bottom=101 </L>
	<L> left=1344 ,top=3 ,right=1344 ,bottom=101 </L>
	<L> left=1503 ,top=3 ,right=1503 ,bottom=101 </L>
	<L> left=1664 ,top=3 ,right=1664 ,bottom=101 </L>
	<L> left=1823 ,top=3 ,right=1823 ,bottom=101 </L>
	<L> left=1982 ,top=3 ,right=1982 ,bottom=101 </L>
	<L> left=2299 ,top=3 ,right=2299 ,bottom=101 </L>
	<L> left=2458 ,top=3 ,right=2458 ,bottom=101 </L>
	<L> left=2619 ,top=3 ,right=2619 ,bottom=101 </L>
	<L> left=2140 ,top=3 ,right=2140 ,bottom=101 </L>
	<L> left=2813 ,top=3 ,right=2813 ,bottom=101 </L>
	<L> left=40 ,top=101 ,right=2813 ,bottom=101 </L>
	<T>id='1월' ,left=712 ,top=8 ,right=863 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2625 ,top=8 ,right=2807 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세목' ,left=400 ,top=8 ,right=704 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=706 ,top=3 ,right=706 ,bottom=101 </L>
	<T>id='2월' ,left=873 ,top=8 ,right=1021 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3월' ,left=1032 ,top=8 ,right=1180 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4월' ,left=1191 ,top=8 ,right=1341 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5월' ,left=1349 ,top=8 ,right=1500 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6월' ,left=1508 ,top=8 ,right=1659 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7월' ,left=1670 ,top=8 ,right=1818 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8월' ,left=1828 ,top=8 ,right=1979 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9월' ,left=1987 ,top=8 ,right=2138 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10월' ,left=2146 ,top=8 ,right=2297 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12월' ,left=2466 ,top=8 ,right=2617 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11월' ,left=2307 ,top=8 ,right=2455 ,bottom=98 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=0 ,right=2813 ,bottom=0 </L>
	<C>id='ATKORNAM', left=48, top=5, right=392, bottom=66, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTSUM', left=2625, top=5, right=2807, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=394 ,top=0 ,right=394 ,bottom=66 </L>
	<L> left=1183 ,top=0 ,right=1183 ,bottom=66 </L>
	<L> left=1024 ,top=0 ,right=1024 ,bottom=66 </L>
	<L> left=865 ,top=0 ,right=865 ,bottom=66 </L>
	<L> left=1664 ,top=0 ,right=1664 ,bottom=66 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 </L>
	<L> left=1344 ,top=0 ,right=1344 ,bottom=66 </L>
	<L> left=2458 ,top=0 ,right=2458 ,bottom=66 </L>
	<L> left=2299 ,top=0 ,right=2299 ,bottom=66 </L>
	<L> left=2140 ,top=0 ,right=2140 ,bottom=66 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=66 </L>
	<L> left=1823 ,top=0 ,right=1823 ,bottom=66 </L>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=66 </L>
	<L> left=2619 ,top=0 ,right=2619 ,bottom=66 </L>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 </L>
	<C>id='SATNM', left=400, top=5, right=704, bottom=66, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=706 ,top=0 ,right=706 ,bottom=66 </L>
	<C>id='BGTMM01', left=712, top=5, right=863, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM02', left=873, top=5, right=1021, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM03', left=1032, top=5, right=1180, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM04', left=1191, top=5, right=1341, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM05', left=1349, top=5, right=1500, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM06', left=1508, top=5, right=1659, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM07', left=1670, top=5, right=1818, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM08', left=1828, top=5, right=1979, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM09', left=1987, top=5, right=2138, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM10', left=2146, top=5, right=2297, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM12', left=2466, top=5, right=2617, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTMM11', left=2307, top=5, right=2455, bottom=66, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=566 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=138 ,right=2813 ,bottom=138 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='담당' ,left=1598 ,top=241 ,right=1831 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀장' ,left=1842 ,top=241 ,right=2074 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=2085 ,top=241 ,right=2318 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본부장' ,left=2328 ,top=241 ,right=2564 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장' ,left=2572 ,top=241 ,right=2810 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1590 ,top=299 ,right=2813 ,bottom=299 </L>
	<L> left=40 ,top=534 ,right=2813 ,bottom=534 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='접 수 일:' ,left=971 ,top=463 ,right=1127 ,bottom=516 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=1130, top=463, right=1381, bottom=516, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='재' ,left=1519 ,top=384 ,right=1588 ,bottom=463 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결' ,left=1519 ,top=291 ,right=1588 ,bottom=368 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1513 ,top=233 ,right=1513 ,bottom=516 </L>
	<L> left=1513 ,top=233 ,right=2813 ,bottom=233 </L>
	<L> left=1513 ,top=516 ,right=2813 ,bottom=516 </L>
	<L> left=2566 ,top=233 ,right=2566 ,bottom=516 </L>
	<L> left=2323 ,top=233 ,right=2323 ,bottom=516 </L>
	<L> left=2077 ,top=233 ,right=2077 ,bottom=516 </L>
	<L> left=1834 ,top=233 ,right=1834 ,bottom=516 </L>
	<T>id='※예산 주관부서 의견' ,left=40 ,top=148 ,right=479 ,bottom=209 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='＊＊＊예산 주관부서＊＊＊' ,left=1913 ,top=156 ,right=2450 ,bottom=220 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2813 ,top=233 ,right=2813 ,bottom=516 </L>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 </L>
	<L> left=40 ,top=0 ,right=2813 ,bottom=0 </L>
	<T>id='합           계' ,left=48 ,top=5 ,right=704 ,bottom=61 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=66 ,right=2813 ,bottom=66 </L>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=66 </L>
	<L> left=1590 ,top=233 ,right=1590 ,bottom=516 </L>
	<L> left=706 ,top=0 ,right=706 ,bottom=66 </L>
	<L> left=865 ,top=0 ,right=865 ,bottom=66 </L>
	<L> left=1024 ,top=0 ,right=1024 ,bottom=66 </L>
	<L> left=1183 ,top=0 ,right=1183 ,bottom=66 </L>
	<L> left=1344 ,top=0 ,right=1344 ,bottom=66 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 </L>
	<L> left=1664 ,top=0 ,right=1664 ,bottom=66 </L>
	<L> left=1823 ,top=0 ,right=1823 ,bottom=66 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=66 </L>
	<L> left=2140 ,top=0 ,right=2140 ,bottom=66 </L>
	<L> left=2299 ,top=0 ,right=2299 ,bottom=66 </L>
	<S>id='{Sum(BGTSUM)}' ,left=2625 ,top=5 ,right=2807 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=2619 ,top=0 ,right=2619 ,bottom=66 </L>
	<S>id='{Sum(BGTMM12)}' ,left=2466 ,top=5 ,right=2617 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=2458 ,top=0 ,right=2458 ,bottom=66 </L>
	<S>id='{Sum(BGTMM11)}' ,left=2307 ,top=5 ,right=2455 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM04)}' ,left=1191 ,top=5 ,right=1341 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM05)}' ,left=1349 ,top=5 ,right=1500 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM06)}' ,left=1508 ,top=5 ,right=1659 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM07)}' ,left=1670 ,top=5 ,right=1818 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM08)}' ,left=1828 ,top=5 ,right=1979 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM09)}' ,left=1987 ,top=5 ,right=2138 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM10)}' ,left=2146 ,top=5 ,right=2297 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM03)}' ,left=1032 ,top=5 ,right=1180 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM02)}' ,left=873 ,top=5 ,right=1021 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(BGTMM01)}' ,left=712 ,top=5 ,right=863 ,bottom=61 ,align='right' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 