<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계 - 예산변경 팝업
+ 프로그램 ID	:  Bgtdetail_popup1.html
+ 기 능 정 의	:  예산신청관리 등록,변경,조회 및 출력 화면이다.
+ 작   성  자 :  이 민 정
+ 서 블 릿 명	:	 
------------------------------------------------------------------------------>
<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>예산변경 팝업</title>

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

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments;

	ln_DispChk(0);
	ln_Before();
	p_fdcode = strParam[0];	//지점코드
	p_bgtrno = strParam[1];	//신청서번호
	p_bgtryy = strParam[2];	//예산년도
	p_bgtdpt = strParam[3];	//신청부서
	p_fsrefc = strParam[4];	//관리항목코드

	ln_QueryDetail();
//  gcds_data1.namevalue(gcds_data1.rowposition,"ATCODE") = "1111";
//  prompt('',gcds_data1.text);
    var strsatcode = gcds_data1.namevalue(gcds_data1.rowposition,"SATCODE");

    ln_RefQuery(gcds_data1.namevalue(gcds_data1.rowposition,"ATCODE"));
  
    //alert("gs_deptnm::"+gs_deptnm);
    //alert("gdeptnm::"+gdeptnm);
    //alert("gusrnm::"+gusrnm);
  
	txt_deptcd.value = gs_deptcd;
	txt_deptnm.value = gs_deptnm;
	txt_empnm.value  = gs_usrnm;
	txt_empno.value  = gs_userid;
    gclx_satcode.bindcolval=strsatcode;
	//ln_SetDataHeader();
	//ln_Add();
	//ln_RowAdd('01');
}

/******************************************************************************************
	Description : 조회 - 상세조회
******************************************************************************************/
function ln_QueryDetail(){
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+p_fdcode
										+ "&v_str2="+p_bgtrno+"&v_str3="+p_bgtryy+"&v_str4="+p_bgtdpt+"&v_str5="+p_fsrefc;
//  prompt('',gcds_data1.DataID);
	gcds_data1.Reset();
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
		var str4 = gclx_bgtdpt.BindColVal;	//신청부서
		var str5 = gclx_fsrefcd.BindColVal;	//관리항목코드
		if(str2!="") {
			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+str1
												+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
			gcds_data1.Reset();
		}else{alert("신청서번호를 입력해 주십시오.");	}
	}else if(e=="S"){
		var str1 = gclx_fdcode1.BindColVal;	//지점코드
		var str2 = gcem_bgtrqno.text;				//신청서번호
		var str3 = gcem_bgtyy.text;					//예산년도
		var str4 = gclx_bgtdpt.BindColVal;	//신청부서
		var str5 = gclx_fsrefcd.BindColVal;	//관리항목코드
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
		gcds_data1.Reset();
	}else if(e=="05"){
		var str1 = gclx_sfdcode2.BindColVal;	//지점코드
		var str2 = gcem_swrdtfr2.text;				//작성일자fr
		var str3 = gcem_swrdtto2.text;				//작성일자to
		var str4 = gclx_sbgtdpt2.BindColVal;	//신청부서
		var str5 = txt_atcodenm2.value;				//계정과목
		var str6 = gclx_satcode2.BindColVal;	//세목명
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s10?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6;
		gcds_data2.Reset();
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
		var str7 = gclx_bgtdpt3.BindColVal;		//신청부서
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
		var str7 = gclx_bgtdpt4.BindColVal;		//신청부서
		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s9?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
		gcds_data4.Reset();
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
	var str4 = gclx_sbgtdpt2.bindcolval;	//신청부서
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
	gcds_data1_1.ClearData();
	
	txt_deptcd.value = gs_deptcd;
	txt_deptnm.value = gs_deptnm;
	txt_empnm.value  = gs_usrnm;
	txt_empno.value  = gs_userid;
	gclx_fdcode1.bindcolval=gs_fdcode;
	
	gclx_bgtdpt.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");//신청부서
	gcem_bgtyy.text = gs_date2;			//예산년도
	gclx_bgtrqst.bindcolval = "N";	//신청서상태[대기]
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

	if(gcds_data1.IsUpdated && !gcds_data1_1.IsUpdated) {	
		if(ln_Chk('01')==false) return false;
		for(var i=1;i<=gcds_data1.countrow;i++){//MST(0) SAVE
			if(gcds_data1.SysStatus(i)=="1") {
				gcds_data1.namevalue(row,"BGTDIV")  = gcds_bgtdpt.namevalue(row2,"BGTDIVCD");		 //신청본부
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
	}else if(!gcds_data1.IsUpdated && gcds_data1_1.IsUpdated) {	
		gcds_data1.namevalue(row,"CHK")="T";
		if(ln_Chk('02')==false) return false;
		for(var i=1;i<=gcds_data1_1.countrow;i++){//MST(0)/DTL(0) SAVE
			if(gcds_data1_1.namevalue(i,"CDNAM")!="") {
				gcds_data1_1.namevalue(i,"DVTFRSATCD")  = gcds_data1_1.namevalue(i,"CDNAM");	//세목
			}
		}
		gctr_data1_1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
		gctr_data1_1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
		gctr_data1_1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=B";
		gctr_data1_1.post();
		ln_Query('S');
	}else if(gcds_data1.IsUpdated && gcds_data1_1.IsUpdated) { 
		if(ln_Chk('02')==false) return false;
		for(var i=1;i<=gcds_data1.countrow;i++){//MST(0)/DTL(0) SAVE
			if(gcds_data1.SysStatus(i)=="1") {
				gcds_data1.namevalue(row,"BGTDIV")  = gcds_bgtdpt.namevalue(row2,"BGTDIVCD");		 //신청본부
				gcds_data1.namevalue(row,"BGTTYPE") = "1";	//관리타입
				gcds_data1.namevalue(row,"BGTMACT") = "01";	//예산타입
				gcds_data1.namevalue(row,"FSREFCD") = gcds_fsrefcd.namevalue(row3,"CDCODE"); //관리항목코드
			}
		}
		gctr_data1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
		gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
		gctr_data1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=C";
		gctr_data1.post();
		ln_Query('S');
	}else{
		alert("저장하실 정보가 없습니다.");
	}
}

/******************************************************************************
	Description : 승인요청
******************************************************************************/
function ln_SanReq() {
	/*if(gcds_data1.countrow>0){
		var row = gcds_data1.rowposition;
		if (confirm("승인 요청 하시겠습니까?")){	
			gcds_data1.namevalue(row,"BGTRQST")="R";
			gctr_data1.KeyValue = "Account.a080003_t1(I:USER=gcds_data1)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t1";
			gctr_data1.Parameters = "v_str1="+gs_date3;
			gctr_data1.post();
			ln_Query('S');
		}
	}*/

	var s_temp = "FDCODE:STRING(2),BGTRQNO:STRING(12),BGTRQST:STRING(1)";
	gcds_temp05.SetDataHeader(s_temp);

	if(gcds_data2.countrow>0){
		var gchk = "F";
		var kchk = "F";
		var hchk = "F";
		for(var j=1;j<=gcds_data2.countrow;j++){
			if(gcds_data2.namevalue(j,"CHK")=="T"){
				gchk = "T";
			}
			if(gcds_data2.namevalue(j,"CHK")=="T"&&gcds_data2.namevalue(j,"BGTRQST")=="R"){
				kchk = "T";//승인요청
			}else if(gcds_data2.namevalue(j,"CHK")=="T"&&gcds_data2.namevalue(j,"BGTRQST")=="Y"){
				hchk = "T";//승인완료
			}
		}

		if(gchk=="F")	{
			alert("승인요청할 건을 선택해주세요.");
			return false;
		}

		if(kchk=="T")	{
			alert("승인요청이 처리된 건입니다.");
			return false;
		}

		if(hchk=="T")	{
			alert("이미 승인완료하신 건이 존재합니다.");
			return false;
		}
		var row = gcds_temp05.rowposition;
		if (confirm("승인 요청 하시겠습니까?")){
			for(var i=1;i<=gcds_data2.countrow;i++){
				if(gcds_data2.namevalue(i,"CHK")=="T"){
					gcds_temp05.addrow();	
					var str1 = gcds_data2.namevalue(i,"FDCODE");
					var str2 = gcds_data2.namevalue(i,"BGTRQNO");
					//gcds_temp05.namevalue(row,"FDCODE")=gcds_data2.namevalue(i,"FDCODE");
					//gcds_temp05.namevalue(row,"BGTRQNO")=gcds_data2.namevalue(i,"BGTRQNO");
					//gcds_temp05.namevalue(row,"BGTRQST")="R";
				}
			}
			gctr_data1.KeyValue = "Account.a080003_t4(I:USER=gcds_temp05)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t4";
			gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3=R";
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

		if (fn_trim(gclx_bgtdpt.bindcolval)==""){
			alert("신청부서를 입력하십시요.");
			gclx_bgtdpt.focus();
			return false; 
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

		if (fn_trim(gclx_bgtdpt.bindcolval)==""){
			alert("신청부서를 입력하십시요.");
			gclx_bgtdpt.focus();
			return false; 
		}

		if (fn_trim(gcem_whybgtrqnote.text)==""){
			alert("신청사유를 입력하십시요.");
			gcem_whybgtrqnote.focus();
			return false; 
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
						if(gcds_data1_1.namevalue(i,"BGTRQDIV")!="01"){
							gcds_data1_1.namevalue(i,"BGTFRMON") = "0"+gcds_data1_1.namevalue(i,"BGTFRMON");
						}
					}
				}
			}
		}
	}
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){
	if(gcds_data1.countrow>0){
		if(ln_AppChk())
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
		}
	}
}

/******************************************************************************
	Description : 삭제 - 예산 신청 Detail (1)
******************************************************************************/
function ln_RowDel(e){
	if(gcds_data1_1.countrow>0){
		if (confirm("삭제 하시겠습니까?")){	
			if(e=="01"){
				gcds_data1_1.deleterow(gcds_data1_1.rowposition);
				gctr_data1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1_1)";
				gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
				gctr_data1.post();
			}
		}
	}else alert("삭제할 정보가 없습니다.");
}

/******************************************************************************
	Description : 승인완료건 체크
******************************************************************************/
function ln_AppChk(){
	for(var i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(i,"BGTRQST")=="Y"){
			alert("승인완료건은 삭제할 수 없습니다.");
			return false;
		}
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
function ln_Print(){
	if(gcds_data2.countrow>0){
		var g_chk = "F";
		for(var i=1;i<=gcds_data2.countrow;i++){
			if(gcds_data2.namevalue(i,"CHK")=="T"){
				g_chk ="T";
			}	
		}
		if(g_chk=="T") {
			var str1 = g_fdcode;	//gclx_fdcode1.BindColVal;	//지점코드
			var str2 = g_bgtrqno;	//gcem_bgtrqno.text;				//신청서번호
			var str3 = gs_date;									//신청일자
			
			gcds_print.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s7?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
			gcds_print.Reset();
			
			gcds_data2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s4?v_str1="+str1+"&v_str2="+str2;
			gcds_data2_2.Reset();
		}else{
			alert("출력할 정보를 선택해 주세요.");
			return false;
		}
	}else alert("출력할 정보가 없습니다.");
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
						  + "ATKORNAM:STRING,CDNAM:STRING,JANAMT:DECIMAL,CHK:STRING,BGTFRDEPT:STRING,BGTDEPTNM:STRING";
	gcds_data1_1.SetDataHeader(s_temp2);
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_disp01.RunExcel('예산신청관리');
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_bgtyy.text = gs_date2;		//예산년도
	gcem_wrdt.text  = gs_date;		//작성일자
	gclx_bgtrqst.bindcolval = "N";
	
	txt_deptcd.value = gs_deptcd;
	txt_deptnm.value = gs_deptnm;
	txt_empnm.value  = gs_usrnm;
	txt_empno.value  = gs_userid;
	
	if(gs_deptcd==null){	//회계개발자
		gs_deptcd = "C000";
	}

	if(gs_deptcd!="C000"){//사용자부서
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str3="+gs_deptcd;
		gcds_deptemp.Reset();
	}else{
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str3="+gs_deptcd;
		gcds_deptemp.Reset();
	}

	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	if(gs_vendcd!="1200"){//신청부서-일반부서
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N";
		gcds_bgtdpt.Reset();
	}else{	//신청부서-관리지원본부
		gcds_bgtdpt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt.Reset();
	}

	//원가구분
	gcds_costcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0030"; 
	gcds_costcd.Reset();

	//신청구분
	gcds_bgtrqdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2150";
	gcds_bgtrqdiv.Reset();

	//관리항목
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1=&v_str2=B";
	gcds_fsrefcd.Reset();

	//세목
	gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s6?v_str1=";
	gcds_satcode.Reset();
	//gclx_satcode.enable = false;	

	/*변경예산신청서***********************************************************/
	/*
	gcem_swrdtfr2.text = gs_date3+"01";	//작성일자fr
	gcem_swrdtto2.text = gs_date;				//작성일자to

	//지점코드
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	if(gs_vendcd!="1200"){//신청부서-일반부서
		gcds_bgtdpt2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N";
		gcds_bgtdpt2.Reset();
	}else{	//신청부서-관리지원본부
		gcds_bgtdpt2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt2.Reset();
	}
	*/

	/*항목조회*****************************************************************/
	/*gcem_wrdt3.text = gs_date2;
	gcem_bgtmmfr3.text = gs_date4;
	gcem_bgtmmto3.text = gs_date4;
	gclx_bgtrqst3.bindcolval = "Y";

	//지점코드[검색]
	gcds_fdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode3.Reset();

	if(gs_vendcd!="1200"){//신청부서-일반부서
		gcds_bgtdpt3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N";
		gcds_bgtdpt3.Reset();
	}else{	//신청부서-관리지원본부
		gcds_bgtdpt3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt3.Reset();
	}

	//예산신청구분
	gcds_bgtrqst3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2150"; 
	gcds_bgtrqst3.Reset();
	*/

	/*잔액조회*****************************************************************/
	/*gcem_wrdt4.text		 = gs_date2;
	gcem_bgtmmfr4.text = gs_date4;
	gcem_bgtmmto4.text = gs_date4;
	gclx_bgtrqst4.bindcolval = "Y";

	//지점코드[검색]
	gcds_fdcode4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode4.Reset();

	if(gs_vendcd!="1200"){//신청부서-일반부서
		gcds_bgtdpt4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N";
		gcds_bgtdpt4.Reset();
	}else{	//신청부서-관리지원본부
		gcds_bgtdpt4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt4.Reset();
	}

	//예산신청구분
	gcds_bgtrqst4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2150"; 
	gcds_bgtrqst4.Reset();
	

	//세목-변경신청
	gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode.Reset();

	//세목-변경예산신청서
	gcds_ssatcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_ssatcode2.Reset();

	//세목-변경신청 그리드
	gcds_satcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode2.Reset();
	*/
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
	gcds_sfsrefcd2.Reset();
}

/******************************************************************************************
	Description : 조회 - 세목코드 조회(변경신청탭)
******************************************************************************************/
function ln_SatQuery(e){
	if(e!="0003"){
		//gclx_satcode.enable = true;
		gcds_satcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e;
		gcds_satcode.Reset();
	}else{
		//gclx_satcode.enable = false;
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
	if(e!="0003"){
		gclx_satcode2.enable = true;
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
	var str5 =	gclx_bgtdpt.bindcolval;		//신청부서
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
	Description : 부서코드 - 관리항목 찾기
**********************************************************************************************/
function ln_FsrefDept(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Commdtil_popup_dept.html";
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

	if(ln_Chk('02')==false) return false;
		if(gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTRQDIV") == "04"){
			gcds_data1_1.namevalue(gcds_data1_1.rowposition,"BGTFRDEPT") = arrParam[0];	//예산부서
			gctr_data1_1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
			gctr_data1_1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
			gctr_data1_1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=B";
			gctr_data1_1.post();
		}else{
			ln_Save();
		}
	//ln_Query('S');
}

/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Actcode_popup.html";
	arrParam[0]="ATUSEYN";
	arrParam[1]="B";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="01"){
			gcem_atcode.text = arrParam[0];
			txt_atcodenm.value = arrParam[1];
			ln_RefQuery(arrParam[0]);	//관리항목 조회
		}else{
			gcem_atcode2.text = arrParam[0];
			txt_atcodenm2.value = arrParam[1];
			ln_RefQuery2(arrParam[0]);	//관리항목 조회
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

	strURL = "./Actcode_popup.html";
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

		strURL = "./Commdtil_popup_ifrm.html";
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
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"DVTFRSATCD")  = arrParam[0];	//세목
		gctr_data1_1.KeyValue = "Account.a080003_t2(I:USER=gcds_data1,I:USER2=gcds_data1_1)";
		gctr_data1_1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_t2";
		gctr_data1_1.Parameters = "v_str1="+gs_date3+",v_str2="+gcem_wrdt.text.substring(4,6)+",v_str3=B";
		gctr_data1_1.post();
		//ln_Query('S');
	}
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-예산신청내역, 1-변경예산신청
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1");//,"div_disp2","div_disp3","div_disp4"
	for(var i=0;i<=0;i++)	{//3
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
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
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtrqst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_costcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

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
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1_1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
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
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	
	}
</script>

<script language="javascript" for="gcds_data4" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt04.innerText = "조회건수 : " + row + " 건"; 
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	
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
</script>

<script language="javascript" for="gcds_bgtdpt" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_bgtdpt" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	gcds_bgtdpt.InsertRow(1);
	gcds_bgtdpt.NameValue(1,"BGTDEPT")="";
	gcds_bgtdpt.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdpt.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
	}else gclx_bgtdpt.index = 0;
</script>

<script language="javascript" for="gcds_bgtdpt2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_bgtdpt2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	gcds_bgtdpt2.InsertRow(1);
	gcds_bgtdpt2.NameValue(1,"BGTDEPT")="";
	gcds_bgtdpt2.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_sbgtdpt2.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
	}else gclx_sbgtdpt2.index = 0;
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

<script language="javascript" for="gcds_bgtdpt3" event="onloadCompleted(row,colid)">
	gcds_bgtdpt3.InsertRow(1);
	gcds_bgtdpt3.NameValue(1,"BGTDEPT")="";
	gcds_bgtdpt3.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdpt3.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
	}else gclx_bgtdpt3.index = 0;
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

<script language="javascript" for="gcds_bgtdpt4" event="onloadCompleted(row,colid)">
	gcds_bgtdpt4.InsertRow(1);
	gcds_bgtdpt4.NameValue(1,"BGTDEPT")="";
	gcds_bgtdpt4.NameValue(1,"BGTNAM")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdpt4.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
	}else gclx_bgtdpt4.index = 0;
</script>

<script language="javascript" for="gcds_bgtrqst4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

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
	ln_FsrefCode(str1);
</script>

<script language="javascript" for="gcds_satcode" event="onloadCompleted(row,colid)">
	if(row<1){
		gcds_satcode.InsertRow(1);
		gcds_satcode.NameValue(1,"CDCODE")="00";
		gcds_satcode.NameValue(1,"CDNAM")="00";
		gclx_satcode.index = 0;
		//gclx_satcode.enable = false;
	}else{
		if(gcds_fsrefcd.namevalue(1,"CDCODE")!="0003"){
			gcds_satcode.InsertRow(1);
			gcds_satcode.NameValue(1,"CDCODE")="";
			gcds_satcode.NameValue(1,"CDNAM")="";
			//gclx_satcode.enable = true;
		}else{
			gcds_satcode.InsertRow(1);
			gcds_satcode.NameValue(1,"CDCODE")="00";
			gcds_satcode.NameValue(1,"CDNAM")="00";
			gclx_satcode.index = 0;
			//gclx_satcode.enable = false;
		}
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
	// document.all.LowerFrame.style.visibility="hidden";
	var janamt = gcds_janamt.namevalue(row,"JANAMT");
	if (janamt!=null) {
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"JANAMT") = janamt;
	}else{
		gcds_data1_1.namevalue(gcds_data1_1.rowposition,"JANAMT") = 0;
	}
</script>

<script language="javascript" for="gcds_data2_2" event="onloadCompleted(row,colid)">
	if(gcrp_print.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		gcrp_print.preview();	//변경신청서 레포트
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
	if(gcds_data1_1.namevalue(row,"BGTRQDIV")!="01"){
		if(colid=="ATKORNAM"){
			ln_Popup2(row);		//계정찾기
		}else if(colid=="DVTFRSATCD"){
			ln_FsrefCode(gcds_fsrefcd2.namevalue(gcds_fsrefcd2.rowposition,"CDCODE"));//세목찾기
		}else if(colid=="BGTDEPTNM"){
			ln_FsrefDept('0003');	//예산부서 찾기
		}
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>
 if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="01"){//추가예산
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		gcds_data1_1.namevalue(row,"BGTFRMON") = "";
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
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="ANY";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="ANY";
		gcgd_disp01.ColumnProp('DVTFRSATCD','Edit')="ANY";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";
	}else if(gcds_data1_1.namevalue(row,"BGTRQDIV")=="04"){//부서전용
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('CDNAM','Edit')   ="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="ANY";
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnCloseUp(row,colid)>
	if(gcds_data1_1.namevalue(row,"BGTRQDIV") =="01"){//추가예산
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="None";
		gcgd_disp01.ColumnProp('ATKORNAM','Edit')="None";
		gcgd_disp01.ColumnProp('CDNAM','Edit')   ="None";
		gcgd_disp01.ColumnProp('BGTDEPTNM','Edit')="None";

		gcds_data1_1.namevalue(row,"BGTFRMON") = "";
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
		gcgd_disp01.ColumnProp('BGTFRMON','Edit')="ANY";
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

<script language=JavaScript for=gcgd_disp01 event=CanColumnPosChange(row,colid)>
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
</script>

<script language=JavaScript for=gcgd_disp04 event=OnDblClick(row,colid)>
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
</script>

<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	gcem_bgtrqno.enable = true;
	var str1 = gcds_data2.namevalue(row,"FDCODE");	//지점코드
	var str2 = gcds_data2.namevalue(row,"BGTRQNO");	//신청서번호
	var str3 = gcds_data2.namevalue(row,"BGTYY");		//예산년도
	var str4 = gcds_data2.namevalue(row,"BGTDPT");	//신청부서
	var str5 = gcds_data2.namevalue(row,"FSREFCD");	//관리항목코드
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080003_s1?v_str1="+str1
										+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
	gcds_data1.Reset();

	ln_DispChk(0);	//변경신청탭
	gcte_disp.ActiveIndex = 1;
</script>

<script language=JavaScript for=gcgd_disp02 event=OnClick(Row,Colid)>
	if (Colid=="CHK") {
		for (var i=1; i<=gcds_data2.countrow;i++) {
			if(i!=Row) {
				gcds_data2.namevalue(i,"CHK") = "F";
			}else{
				g_fdcode  = gcds_data2.namevalue(Row,"FDCODE");
				g_bgtrqno = gcds_data2.namevalue(Row,"BGTRQNO");
			}
		}
	}
</script>

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
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
						<!-- <T>divid=div_2		title=변경예산신청서</T><T>divid=div_3		title=항목조회</T><T>divid=div_4		title=잔액조회</T> -->
					</td>
				</tr>
			</table>
		</td>
  </tr>
	<tr><td height=4></td></tr>
</table>

<!-- 변경신청 -------------------------------------------------------------------------------------------------->
<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" style="display:block">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab21" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:110px;height:110px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
						<param name=Enable          value=false>
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
						<param name=Enable      value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;&nbsp;도</td>
				<td class="tab21" width="110px">
					<comment id="__NSID__"><object  id=gcem_bgtyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">담당부서</td>
				<td class="tab22">
					<input id=txt_deptcd type="hidden" class="txt11" style="position:relative;top:-1px;left:5px;width:108px;">
					<input id=txt_deptnm type="text"   class="txt11" style="position:relative;top:-1px;left:5px;width:158px;" disabled>
				</td>
			</tr>
			<tr> 				
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">담&nbsp;당&nbsp;자</td>
				<td class="tab21">
					<input id=txt_empno type="hidden" class="txt11" style="position:relative;top:-1px;left:5px;width:108px;">
					<input id=txt_empnm type="text"   class="txt11" style="position:relative;top:-1px;left:5px;width:108px;" disabled>
				</td>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">신청서상태</td>
				<td class="tab21">
					<comment id="__NSID__"><object  id=gclx_bgtrqst classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:85px;">
						<param name=CBData			    value=" ^ ,Y^승인완료,R^승인요청,N^승인대기,B^반송"><!-- C^승인취소 -->
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
				<td class="tab22"><nobr>
					<comment id="__NSID__"><object  id=gclx_bgtdpt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
						<param name=Enable          value=false>
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
				<td class="tab21" width="350px" colspan="5"><nobr>
					<input id=txt_atcodenm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:235px;" disabled>
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
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">세&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td class="tab22" width="180px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd"><!-- 관리항목코드 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<input id=txt_satcode type="hidden" class="txt11" style="position:relative;top:0px;left:5px;width:158px;">
					<comment id="__NSID__"><object  id=gclx_satcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:160px;height:200px;"><!-- display:none -->
						<param name=ComboDataID			value="gcds_satcode"><!-- 세목 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^160">
						<param name=BindColumn			value="CDCODE">
						<param name=Enable          value=false>
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
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:0px;width:864px;height:250px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"				VALUE="gcds_data1_1">
						<PARAM NAME="IndWidth"			VALUE="0">
						<PARAM NAME="BorderStyle"		VALUE="0">
						<PARAM NAME="Fillarea"			VALUE="true">
						<PARAM NAME="Editable"			VALUE="true">
						<PARAM NAME="UsingOneClick" VALUE="1">
						<PARAM NAME="Format"				VALUE="  
							<C> Name='선택'					ID=CHK			  HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center EditStyle='CheckBox' Pointer=Hand</C> 
							<C> Name='순번'					ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center </C> 
							<C> Name='신청구분'			ID=BGTRQDIV	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center   EditStyle='Lookup' Data='gcds_bgtrqdiv:CDCODE:CDNAM'</C> 
							<C> Name='금액'					ID=BGTRQAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95	align=right	 </C> 
							<C> Name='예산잔액'			ID=JANAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=right	 Edit=None Color=blue show=false</C> 
							<C> Name='배정월'				ID=BGTTOMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center EditStyle='Combo' Data='1:1월,2:2월,3:3월,4:4월,5:5월,6:6월,7:7월,8:8월,9:9월,10:10월,11:11월,12:12월'</C>
							<C> Name='피전용월'			ID=BGTFRMON		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center EditStyle='Combo' Data='1:1월,2:2월,3:3월,4:4월,5:5월,6:6월,7:7월,8:8월,9:9월,10:10월,11:11월,12:12월'</C>
							<C> Name='피전용계정'		ID=ATKORNAM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 EditStyle='Popup'</C> 
							<C> Name='피전용세목'		ID=CDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left	 EditStyle='Popup'</C> 
							<C> Name='피전용부서'		ID=BGTDEPTNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 EditStyle='Popup'</C>
							<C> Name='승인상태'			ID=BGTRQST		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center EditStyle='Combo' Data='Y:승인완료,R:승인요청,N:승인대기,B:반송'</C>
						"> <!-- 피전용세목 : EditStyle='Lookup' Data='gcds_satcode2:CDCODE:CDNAM' -->
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:0px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset>
					<fieldset style="position:relative;left:0px;width:866px;height:53px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;"><nobr><input type="text" class="txtbox" value="신청사유:" style="position:relative;top:-30px;left:5px;border:0;width:70px"><comment id="__NSID__">
					<object  id=gcem_whybgtrqnote classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:785px;height:51px;position:relative;left:5px;top:1px">		
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
						<!-- <img src="../../Common/img/btn/com_b_appreq.gif"	style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_SanReq()"> -->
						<!-- <img src="../../Common/img/btn/com_b_delete.gif"	style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_Add()">-->
						<!-- <img src="../../Common/img/btn/com_b_save.gif"		style="position:relative;right:-115px;top:-511px;cursor:hand" onClick="ln_Save()">  -->
						<img src="../../Common/img/btn/com_b_query.gif"		style="position:relative;right:-115px;top:-511px;cursor:hand" onclick="ln_Query('01')"> 
						
				<!-- 		<img src="../../Common/img/btn/com_b_rowadd.gif" style="position:relative;right:5px;top:-358px;cursor:hand" onClick="ln_RowAdd('01')">
						<img src="../../Common/img/btn/com_b_rowdel.gif" style="position:relative;right:5px;top:-358px;cursor:hand" onClick="ln_RowDel('01')"> -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		</td> 
	</tr> 
</table> 

<!-- 변경예산신청서 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab21" style="width:100px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:95px;height:95px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^95">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">작성일자</td>
				<td class="tab21" width="170px"><nobr><comment id="__NSID__">
					<object id=gcem_swrdtfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_swrdt2', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">~
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
				<td class="tab22" width="40px"><comment id="__NSID__">
					<object  id=gclx_sbgtdpt2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt2">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr> 				
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정과목</td>
				<td class="tab23" width="300px" colspan="3"><nobr>
					<input id=txt_atcodenm2 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:235px;">
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup()">
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
				<td width="406px"><nobr><comment id="__NSID__">
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
						style="position:relative;left:5px;top:0px;font-size:12px;width:160px;height:200px;">
						<param name=ComboDataID			value="gcds_ssatcode2"><!-- 세목 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^160">
						<param name=BindColumn			value="CDCODE">
						<param name=enable					value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="5px"></td></tr>
	<tr>
		<td height="2px" align="right">
	<!-- 		<img src="../../Common/img/btn/com_b_appreq.gif"	style="position:relative;right:3px;top:-127px;cursor:hand" onClick="ln_SanReq()">
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:3px;top:-127px;cursor:hand" onClick="ln_Print()"> -->
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
				<C> Name='구분'				ID=CHK			  HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center  SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' EditStyle='CheckBox' Pointer=Hand</C> 
				<F> Name='작성일자'		ID=WRDT				HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' mask='XXXX/XX/XX' Edit=none</F> 
				<F> Name='계정과목'		ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=260	align=left		SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				<F> Name='세목'				ID=CDNAM   		HeadAlign=Center HeadBgColor=#B9D4DC Width=190	align=left		SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				<F> Name='신청서상태'	ID=BGTRQST   	HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none EditStyle='Combo' Data='Y:승인완료,R:승인요청,N:승인대기,B:반송'</F> 
				<F> Name='신청서번호'	ID=BGTRQNO 		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=center	SumBgColor=#C3D0DB SumText='' BgColor='#f5f5f5' Edit=none</F> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;top:-22px;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
			</fieldset>
			</td>
		</tr>
	</table>
		</td> 
	</tr> 
</table> 

<!-- 항목조회 ===========================================================================================================-->
<fieldset id=field3 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab21" style="width:105px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:95px;height:95px;">
						<param name=ComboDataID			value="gcds_fdcode3">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^95">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">승인구분</td>
				<td class="tab21" width="95px">
					<comment id="__NSID__"><object  id=gclx_bgtrqst3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:85px;">
						<param name=CBData			    value="^ ,Y^승인완료,R^승인요청,N^승인대기,B^반송">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;도</td>
				<td class="tab21" width="40px" colspan="3">
					<comment id="__NSID__"><object  id=gcem_wrdt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:1px;width:35px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">예&nbsp;산&nbsp;월</td>
				<td class="tab22" width="320px" colspan="3">
					<comment id="__NSID__"><object  id=gcem_bgtmmfr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px;width:25px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmmto3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:2px;width:25px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr> 				
				<td class="tab12" style="height:25px;width:70px;" bgcolor="#eeeeee">예산구분</td>
				<td class="tab23">
					<comment id="__NSID__"><object  id=gclx_bgtrqdiv3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:95px;">
						<param name=ComboDataID			value="gcds_bgtrqst3">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^95">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">신청부서</td>
				<td width="200px" colspan="7">
					<comment id="__NSID__"><object  id=gclx_bgtdpt3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt3">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script></nobr> 
				</td>
				<td align="center">
					<img src="../../Common/img/btn/com_b_query.gif"		style="position:relative;right:-134px;top:-93px;cursor:hand" onclick="ln_Query('03')">
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
					<comment id="__NSID__"><object  id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:379px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data3">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="false">
						<param name="ViewSummary" value="1">
						<PARAM NAME="Format"			VALUE="  
							<C> Name='월'						ID=BGTMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center SumBgColor=#C3D0DB SumText=''			Edit=none</C> 
							<C> Name='계정과목'			ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=235	align=left	 SumBgColor=#C3D0DB SumText='합계'	Edit=none</C> 
							<C> Name='세목'					ID=SATNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left	 SumBgColor=#C3D0DB SumText=''			Edit=none</C> 
							<C> Name='승인구분'			ID=BGTRQST		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center SumBgColor=#C3D0DB SumText=''			EditStyle='Combo'		Data='Y:승인완료,R:승인요청,N:승인대기,B:반송' Edit=none</C> 
							<C> Name='배정액'				ID=BASICBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right  SumBgColor=#C3D0DB SumText=@sum		Edit=none</C> 
							<C> Name='요청액'				ID=BGTRQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right	 SumBgColor=#C3D0DB SumText=@sum		Edit=none</C> 
							<C> Name='승인액'				ID=APPAMT		 	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right  SumBgColor=#C3D0DB SumText=@sum		Edit=none</C> 
							<C> Name='가용사용잔액'	ID=RESULTS 		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right	 SumBgColor=#C3D0DB SumText=@sum		Edit=none</C> 
							<C> Name='잔액'					ID=JANAMT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right	 SumBgColor=#C3D0DB SumText=@sum		Edit=none show=false</C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt03" style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-- 잔액조회 ===========================================================================================================-->
<fieldset id=field4 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" style="display:none;position:relative;left:0px">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
				<td class="tab21" style="width:105px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:95px;height:95px;">
						<param name=ComboDataID			value="gcds_fdcode4">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^95">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">승인구분</td>
				<td class="tab21" width="95px">
					<comment id="__NSID__"><object  id=gclx_bgtrqst4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:85px;">
						<param name=CBData			    value="^ ,Y^승인완료,R^승인요청,N^승인대기,B^반송"><!-- C^승인취소 -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;도</td>
				<td class="tab21" width="40px" colspan="3">
					<comment id="__NSID__"><object  id=gcem_wrdt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:1px;width:35px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">예&nbsp;산&nbsp;월</td>
				<td class="tab22" width="320px" colspan="3">
					<comment id="__NSID__"><object  id=gcem_bgtmmfr4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px;width:25px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmmto4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:2px;width:25px;height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr> 				
				<td class="tab12" style="height:25px;width:70px;" bgcolor="#eeeeee">예산구분</td>
				<td class="tab23">
					<comment id="__NSID__"><object  id=gclx_bgtrqdiv4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:95px;">
						<param name=ComboDataID			value="gcds_bgtrqst4">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^95">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">신청부서</td>
				<td width="200px" colspan="7">
					<comment id="__NSID__"><object  id=gclx_bgtdpt4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt4">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script></nobr> 
				</td>
				<td align="center">
					<img src="../../Common/img/btn/com_b_query.gif"		style="position:relative;right:-134px;top:-93px;cursor:hand" onclick="ln_Query('04')">
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
					<comment id="__NSID__"><object  id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:379px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data4">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="false">
						<param name="ViewSummary" value="1">
						<PARAM NAME="Format"			VALUE="  
							<C> Name='월'					ID=BGTMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center SumBgColor=#C3D0DB SumText=''		 Edit=none</C> 
							<C> Name='계정과목'		ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 SumBgColor=#C3D0DB SumText='합계' Edit=none</C> 
							<C> Name='세목'				ID=SATNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left	 SumBgColor=#C3D0DB SumText=''		 Edit=none</C> 
							<C> Name='승인구분'		ID=BGTRQST		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center SumBgColor=#C3D0DB SumText=''		 EditStyle='Combo' Data='Y:승인완료,R:승인요청,N:승인대기,B:반송' Edit=none</C> 
							<C> Name='신청액'			ID=BGTRQAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right	 SumBgColor=#C3D0DB SumText=@sum	 Edit=none</C> 
							<C> Name='배정액'			ID=BASICBGT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right	 SumBgColor=#C3D0DB SumText=@sum	 Edit=none</C> 
							<C> Name='신청서번호'	ID=BGTRQNO 		HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center SumBgColor=#C3D0DB SumText=''		 Edit=none</C> 
							<C> Name='신청부서'		ID=DEPTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left	 SumBgColor=#C3D0DB SumText=''		 EditStyle='lookup'  Data='gcds_bgtdpt:CDCODE:CDNAM'  Edit=none</C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt04" style="position:relative;top:4px;"></font>
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
		<C>Col=EMPNO			  Ctrl=txt_empno				  Param=value</C>
		<C>Col=BGTRQST			Ctrl=gclx_bgtrqst				Param=BindColVal</C>
		<C>Col=BGTDPT			  Ctrl=gclx_bgtdpt				Param=BindColVal</C>
		<C>Col=COSTCD			  Ctrl=gclx_costcd				Param=BindColVal</C>
		<C>Col=ATCODE			  Ctrl=gcem_atcode				Param=text</C>
		<C>Col=FSREFCD			Ctrl=gclx_fsrefcd				Param=BindColVal</C>
		<C>Col=SATCODE			Ctrl=gclx_satcode				Param=BindColVal</C>
		<C>Col=CDNAM			  Ctrl=txt_satcode				Param=value</C>
		<C>Col=WRDT					Ctrl=gcem_wrdt					Param=text</C>
		<C>Col=BGTRQNOTE		Ctrl=gcem_bgtrqnote			Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_atcodenm				Param=value</C>
		<C>Col=DEPTNM			  Ctrl=txt_deptnm				  Param=value</C>
		<C>Col=EMPNMK			  Ctrl=txt_empnm					Param=value</C>
		<C>Col=WHYRQNOTE		Ctrl=gcem_whybgtrqnote	Param=text</C>
		<C>Col=WHYRQNOTE		Ctrl=gcem_whybgtrqnote2	Param=text</C>
	'>
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
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_data2_2">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="false">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=653 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=506 ,top=44 ,right=1344 ,bottom=119 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=500 ,top=31 ,right=1334 ,bottom=109 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='추가 예산 신청서' ,left=503 ,top=34 ,right=1328 ,bottom=97 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CURDT', left=1409, top=169, right=1928, bottom=222, align='right' ,mask='요청일자 : XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='재' ,left=975 ,top=534 ,right=1028 ,bottom=584 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결' ,left=975 ,top=337 ,right=1028 ,bottom=387 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1031 ,top=494 ,right=1925 ,bottom=494 </L>
	<L> left=1031 ,top=287 ,right=1031 ,bottom=641 </L>
	<L> left=1031 ,top=347 ,right=1925 ,bottom=347 </L>
	<L> left=1925 ,top=287 ,right=1925 ,bottom=641 </L>
	<L> left=1744 ,top=287 ,right=1744 ,bottom=641 </L>
	<T>id='사  장' ,left=1750 ,top=294 ,right=1919 ,bottom=344 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본부장' ,left=1572 ,top=294 ,right=1741 ,bottom=344 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=1394 ,top=294 ,right=1563 ,bottom=344 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검   토' ,left=1216 ,top=294 ,right=1384 ,bottom=344 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1566 ,top=287 ,right=1566 ,bottom=641 </L>
	<L> left=1388 ,top=287 ,right=1388 ,bottom=641 </L>
	<L> left=969 ,top=287 ,right=969 ,bottom=641 </L>
	<L> left=1209 ,top=287 ,right=1209 ,bottom=641 </L>
	<T>id='담당자' ,left=1038 ,top=294 ,right=1206 ,bottom=344 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=969 ,top=287 ,right=1925 ,bottom=287 </L>
	<L> left=969 ,top=641 ,right=1925 ,bottom=641 </L>
	<C>id='DEPTNM', left=303, top=347, right=884, bottom=400, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='부            서 : ' ,left=38 ,top=347 ,right=297 ,bottom=400 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='예  산  타  입 : ' ,left=38 ,top=584 ,right=297 ,bottom=637 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세     세    목 : ' ,left=38 ,top=525 ,right=297 ,bottom=578 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계  정  과  목 : ' ,left=38 ,top=466 ,right=297 ,bottom=519 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일  련  번  호 : ' ,left=38 ,top=287 ,right=297 ,bottom=341 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원  가  코  드 : ' ,left=38 ,top=406 ,right=297 ,bottom=459 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTRQNO', left=303, top=287, right=884, bottom=341, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SATNM', left=303, top=525, right=884, bottom=578, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=303, top=466, right=884, bottom=519, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COSTNM', left=303, top=406, right=884, bottom=459, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MACNM', left=303, top=584, right=884, bottom=637, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDEPTNM', left=1409, top=228, right=1928, bottom=281, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=390 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=41 ,top=0 ,right=1925 ,bottom=0 </L>
	<X>left=1403 ,top=0 ,right=1925 ,bottom=72 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=44 ,top=391 ,right=1925 ,bottom=391 </L>
	<T>id='피전용' ,left=1388 ,top=309 ,right=1559 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전용' ,left=1206 ,top=309 ,right=1378 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='피조기집행' ,left=1025 ,top=309 ,right=1197 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조기집행' ,left=844 ,top=309 ,right=1016 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차기이월' ,left=663 ,top=309 ,right=834 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전기이월' ,left=481 ,top=309 ,right=653 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총예산' ,left=1569 ,top=309 ,right=1741 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실적' ,left=1750 ,top=309 ,right=1922 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추가예산' ,left=300 ,top=309 ,right=472 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배정액' ,left=119 ,top=309 ,right=291 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=47 ,top=309 ,right=109 ,bottom=387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=41 ,top=303 ,right=1925 ,bottom=303 </L>
	<L> left=1925 ,top=303 ,right=1925 ,bottom=391 </L>
	<L> left=41 ,top=303 ,right=41 ,bottom=391 </L>
	<L> left=113 ,top=303 ,right=113 ,bottom=391 </L>
	<L> left=294 ,top=303 ,right=294 ,bottom=391 </L>
	<L> left=475 ,top=303 ,right=475 ,bottom=391 </L>
	<L> left=656 ,top=303 ,right=656 ,bottom=391 </L>
	<L> left=838 ,top=303 ,right=838 ,bottom=391 </L>
	<L> left=1019 ,top=303 ,right=1019 ,bottom=391 </L>
	<L> left=1200 ,top=303 ,right=1200 ,bottom=391 </L>
	<L> left=1381 ,top=303 ,right=1381 ,bottom=391 </L>
	<L> left=1563 ,top=303 ,right=1563 ,bottom=391 </L>
	<L> left=1744 ,top=303 ,right=1744 ,bottom=391 </L>
	<T>id='요     청    액 :' ,left=38 ,top=247 ,right=297 ,bottom=300 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가용사용잔액 :' ,left=38 ,top=187 ,right=297 ,bottom=241 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기집행누계액 : ' ,left=38 ,top=128 ,right=297 ,bottom=181 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='재  배  정  액 :' ,left=38 ,top=69 ,right=297 ,bottom=122 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배     정    액 :' ,left=38 ,top=9 ,right=297 ,bottom=62 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTRQAMT', left=303, top=247, right=666, bottom=300, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMAINTAMT', left=303, top=187, right=666, bottom=241, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESULTAMT', left=303, top=128, right=666, bottom=181, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REBGTAMT', left=303, top=69, right=666, bottom=122, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTAMT', left=303, top=9, right=666, bottom=62, align='right' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='신청금액 내역' ,left=1406 ,top=3 ,right=1919 ,bottom=59 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=84 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=41 ,top=0 ,right=41 ,bottom=84 </L>
	<L> left=113 ,top=0 ,right=113 ,bottom=84 </L>
	<L> left=294 ,top=0 ,right=294 ,bottom=84 </L>
	<L> left=475 ,top=0 ,right=475 ,bottom=84 </L>
	<L> left=656 ,top=0 ,right=656 ,bottom=84 </L>
	<L> left=838 ,top=0 ,right=838 ,bottom=84 </L>
	<L> left=1019 ,top=0 ,right=1019 ,bottom=84 </L>
	<L> left=1200 ,top=0 ,right=1200 ,bottom=84 </L>
	<L> left=1381 ,top=0 ,right=1381 ,bottom=84 </L>
	<L> left=1563 ,top=0 ,right=1563 ,bottom=84 </L>
	<L> left=1744 ,top=0 ,right=1744 ,bottom=84 </L>
	<C>id='BGTRQMON', left=47, top=3, right=109, bottom=81, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESULTAMT', left=1750, top=3, right=1922, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTBGTAMT', left=1569, top=3, right=1741, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DVTTOAMT', left=1388, top=3, right=1559, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DVTFRAMT', left=1206, top=3, right=1378, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMTGVTOB', left=1025, top=3, right=1197, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMTFROMA', left=844, top=3, right=1016, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMTGIVETO', left=663, top=3, right=834, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMTFROMB', left=481, top=3, right=653, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTADAMT', left=300, top=3, right=472, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTAMT', left=119, top=3, right=291, bottom=81, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1925 ,top=0 ,right=1925 ,bottom=84 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=603 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=41 ,top=0 ,right=1925 ,bottom=0 </L>
	<L> left=41 ,top=159 ,right=1925 ,bottom=159 </L>
	<T>id='*예산주관 부서의견 :' ,left=38 ,top=169 ,right=494 ,bottom=222 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=975 ,top=491 ,right=1028 ,bottom=541 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승' ,left=975 ,top=294 ,right=1028 ,bottom=344 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1031 ,top=244 ,right=1031 ,bottom=597 </L>
	<L> left=1744 ,top=244 ,right=1744 ,bottom=597 </L>
	<T>id='사  장' ,left=1750 ,top=250 ,right=1919 ,bottom=300 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본부장' ,left=1572 ,top=250 ,right=1741 ,bottom=300 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=1394 ,top=250 ,right=1563 ,bottom=300 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀   장' ,left=1216 ,top=250 ,right=1384 ,bottom=300 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1566 ,top=244 ,right=1566 ,bottom=597 </L>
	<L> left=1388 ,top=244 ,right=1388 ,bottom=597 </L>
	<T>id='담당자' ,left=1038 ,top=250 ,right=1206 ,bottom=300 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승인자 :' ,left=278 ,top=397 ,right=463 ,bottom=450 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=469, top=397, right=800, bottom=450, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=469, top=331, right=800, bottom=384, align='left' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='승인일 :' ,left=278 ,top=331 ,right=463 ,bottom=384 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='*신청사유 :' ,left=38 ,top=41 ,right=291 ,bottom=94 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WHYRQNOTE', left=297, top=41, right=1922, bottom=94, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1403 ,top=159 ,right=1925 ,bottom=231 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='예산주관부서' ,left=1406 ,top=162 ,right=1919 ,bottom=219 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1031 ,top=303 ,right=1925 ,bottom=303 </L>
	<L> left=969 ,top=244 ,right=969 ,bottom=597 </L>
	<L> left=1031 ,top=450 ,right=1925 ,bottom=450 </L>
	<L> left=969 ,top=244 ,right=1925 ,bottom=244 </L>
	<L> left=969 ,top=597 ,right=1925 ,bottom=597 </L>
	<L> left=1209 ,top=244 ,right=1209 ,bottom=597 </L>
	<L> left=1925 ,top=244 ,right=1925 ,bottom=597 </L>
</B>
<B>id=Footer ,left=0 ,top=2726 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1553 ,top=3 ,right=1931 ,bottom=84</I>
	<L> left=41 ,top=0 ,right=1925 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 