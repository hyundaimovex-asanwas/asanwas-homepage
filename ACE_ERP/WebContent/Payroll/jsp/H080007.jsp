<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사/인사개인정보
+ 프로그램 ID	: H080007.HTML (원본 H030006.HTML)
+ 기 능 정 의	: 조회,저장,삭제,출력,사진
+ 변 경 이 력	: 임 대원 과장
+ 서 블 릿 명	: hclcode_s1, h080007_s0, h080007_s1, h080007_s2, h080007_s3,
								h080007_s4, h080007_s5, h080007_s6, h080007_s7, h080007_s8,
								h080007_s9, h080007_s11
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>인사개인정보</title>
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
//get_cookdata();

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	//ln_SetHeader();
	ln_Before();
	ln_Query();
}

/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Before(){

	//소속코드
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_dept.Reset();

	//소속-팀 조회
	gcds_deptlevel.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_deptlevel.Reset();

	//직위코드
	gcds_deptlvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_deptlvl.Reset();

	//직급코드
	//gcds_grddiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001";
	//gcds_grddiv.Reset();

	//직군
	gcds_jobgrph.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000";
	gcds_jobgrph.Reset();

	//학력코드
	gcds_edccd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1115";
	gcds_edccd.Reset();

	//입사코드
	gcds_empdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1119";
	gcds_empdiv.Reset();

	//종교코드
	gcds_rilign.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1117";
	gcds_rilign.Reset();

	//은행코드
	gcds_paybnkcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1411";
	gcds_paybnkcd.Reset();

	//호주관계코드
	gcds_hdfamret.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	gcds_hdfamret.Reset();

	//사내연고 직위코드
	gcds_relatgrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_relatgrd.Reset();

	//추천인 직위코드
	gcds_nomingrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_nomingrd.Reset();

	//사내연고 관계코드
	gcds_relatre.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	gcds_relatre.Reset();

	//추천인 관계코드
	gcds_nominre.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
	gcds_nominre.Reset();

	//보훈대상자코드
	gcds_mrtdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1135";
	gcds_mrtdiv.Reset();

	//채용구분
	gcds_recdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2035";
	gcds_recdiv.Reset();

	//직종구분
	gcds_jobkind.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2034";
	gcds_jobkind.Reset();

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){
	gcte_disp.ActiveIndex = 1;

	//alert(gusrnm);
	//alert(gusrid);
	gcds_data00.DataID = "/servlet/Contract.h080007_s1?"
									 + "v_str1=&v_str2=&v_str3=" + gusrnm
									 + "&v_str4=" + gs_date + "&v_str7=" + gusrid;
	gcds_data00.Reset();
}

/******************************************************************************
	Description : 가족사항조회
******************************************************************************/
function ln_FamQuery() {
	gcds_data02.DataID = "/servlet/Contract.h080007_s2?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	//prompt('',gcds_data02.DataID);
	gcds_data02.Reset();
}

/******************************************************************************
	Description : 경력사항조회
******************************************************************************/
function ln_CarQuery() {
	gcds_data03.DataID = "/servlet/Contract.h080007_s3?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	//prompt('',gcds_data03.DataID);
	gcds_data03.Reset();
}

/******************************************************************************
	Description : 자격증사항조회
******************************************************************************/
function ln_LicQuery() {

	if (gcds_lcstype.countrow<1) {
		//자격증종류
		gcds_lcstype.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1127";
		gcds_lcstype.Reset();

		//자격증등급
		gcds_lcscd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1128";
		gcds_lcscd.Reset();
	}

	gcds_data04.DataID = "/servlet/Contract.h080007_s4?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data04.Reset();
}

/******************************************************************************
	Description : 학력사항조회
******************************************************************************/
function ln_EduQuery() {

	//window.status="데이타 조회중입니다. 잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";

	if (gcds_hieduc.countrow<1) {
		//학력
		gcds_hieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1115";
		gcds_hieduc.Reset();

		//전공
		gcds_pieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1129";
		gcds_pieduc.Reset();

		//졸업구분
		gcds_gieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1118";
		gcds_gieduc.Reset();
	}

	gcds_data05.DataID = "/servlet/Contract.h080007_s5?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	//prompt('',gcds_data05.DataID);
	gcds_data05.Reset();

}

/******************************************************************************
	Description : 보증+신체
******************************************************************************/
function ln_AssQuery() {
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";

	if (gcds_assret.countrow<1) {
		//관계코드
		gcds_assret.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1132";
		gcds_assret.Reset();

		//장애구분
		gcds_disdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1135";
		gcds_disdiv.Reset();

		//장애등급
		gcds_disgrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1136";
		gcds_disgrd.Reset();

		//색맹
		gcds_colblnyn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2022";
		gcds_colblnyn.Reset();

	}

	gcds_data06.DataID = "/servlet/Contract.h080007_s6?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno")
									 + "&v_str2=A";
	gcds_data06.Reset();

	if (gcds_milidiv.countrow<1) {
		//병역구분
		gcds_milidiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1168";
		gcds_milidiv.Reset();

		//군별
		gcds_miliknd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1116";
		gcds_miliknd.Reset();

		//계급
		gcds_miligrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1134";
		gcds_miligrd.Reset();

		//군별
		gcds_milispec.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1116";
		gcds_milispec.Reset();

		//역종
		gcds_militype.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1133";
		gcds_militype.Reset();

		//제대구분
		gcds_militgbn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2021";
		gcds_militgbn.Reset();

	}

	//병무사항
	gcds_data052.DataID = "/servlet/Contract.h080007_s6?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno")
									 + "&v_str2=B";
	gcds_data052.Reset();

}

/******************************************************************************
	Description : 어학사항조회
******************************************************************************/
function ln_EngQuery() {
	//영어수준
	gcds_englvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1149";
	gcds_englvl.Reset();
}

/******************************************************************************
	Description : 발령사항조회
******************************************************************************/
function ln_OrdQuery() {
	//window.status="데이타 조회중입니다...잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";

	if (gcds_ordcd.countrow<1) {
		//발령구분
		gcds_ordcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>ordcode_s1?v_str1=1149";
		gcds_ordcd.Reset();

		//호봉
		gcds_payseq.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1184";
		gcds_payseq.Reset();
	}

  //// 2008.05.29 정영식 막음.
	//gcds_data07.DataID = "/servlet/Contract.h080007_s7?"

	gcds_data07.DataID = "/servlet/Contract.h080001_s7?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data07.Reset();
}

/******************************************************************************
	Description : 고과사항
******************************************************************************/
function ln_DeuQuery() {
  //// 2008.05.29 정영식 막음.
	//gcds_data09.DataID = "/servlet/Contract.h080007_s8?"

	if(!ln_Chk_Query())return;
	gcds_data09.DataID = "/servlet/Contract.h080001_s8?"
										 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data09.Reset();
}

/******************************************************************************
	Description : 교육사항
******************************************************************************/
function ln_ReqQuery() {
	gcds_data10.DataID = "/servlet/Contract.h080007_s9?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data10.Reset();
}

/******************************************************************************
	Description : 상벌관리
******************************************************************************/
function ln_RewQuery() {
	if (gcds_rewgbn.countrow<1){
		//상벌구분
		gcds_rewgbn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2030";
		gcds_rewgbn.Reset();

		//상벌종류
		gcds_rewkin.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2031";
		gcds_rewkin.Reset();
	}

	gcds_data11.DataID = "/servlet/Contract.h080007_s11?"
									 + "v_str1=" + gcds_data00.namevalue(gcds_data00.rowposition,"empno");
	gcds_data11.Reset();
}

/******************************************************************************
	Description : 출력 - 내역조회
******************************************************************************/
function ln_PrintQuery(){

	var str1 = "";																	    //지급일자
	var str2 = gs_date2;																//적용년월
	var str3 = '1';																			//지급구분[1:정기급여]
	var str4 = fn_trim(gclx_deptcd.BindColVal);					//소속
	var str5 = '';																			//직군
	var str6 = '';																			//사번부터
	var str7 = '';																			//사번까지
	var str8 = fn_trim(txt_empnmk.value);               //성명
	var str9 = fn_trim(gclx_deptlvl.BindColVal);				//직위
	var str10 = ''; //직급

	gcds_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020005_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + str8
									 + "&v_str9=" + str9
									 + "&v_str10=" + str10
									 + "&v_str11=" + ''//gs_level
									 + "&v_str12=" + '';//gs_treecd;
	gcds_temp.Reset(); //그리드
}


/******************************************************************************
	Description :  고과조회 체크
******************************************************************************/
function ln_Chk_Query(){
//gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

  var date = new Date();
  var year = gcurdate.substring(0,4);
  var month = gcurdate.substring(5,7);
  var date = gcurdate.substring(8,10);


	if (year == '2011' && month == '06'  && (date =='23'||date =='24') ){	
      return true;
	//if (year == '2009' && month == '12' && date =='10'){	
	//		return true; 
//	}else if(year =='2009' && month =='1'){
//		return true;
//	}else if(year >='2010'){
//		return true;
	} else { 
		alert(" 조회가능 기간이 아닙니다.");
		return false; 
	}
}

/******************************************************************************
	Description : 헤더생성
******************************************************************************/
function ln_SetHeader(){


}
//

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(e){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
//prompt('',gcds_data99.text);
//	var obj = eval("gcds_data"+e);

	if (!gcds_data00.IsUpdated ){
		alert("저장하실 정보가 없습니다.");
	} else {
			if (confirm("해당 입력정보를 저장하겠습니까 ?")) {
					gctr_data.KeyValue = "Contract.h080007_t1(I:USER=gcds_data00)";
					gctr_data.Action = "/servlet/Contract.h080007_t1";
					gctr_data.post();
					//prompt('',gcds_data00.text);
			}
		}
}


/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(e){

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

	if (gcds_temp.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

		gcds_report0.ClearData();

		var ls_temp="CTITLE:STRING,EMPNO:STRING,EMPNMK:STRING,DEPTNM:STRING,PAYGRDNM:STRING,PAYSEQNM:STRING,PAYBNKNM:STRING,";
		ls_temp +="PAYNUM:STRING,P10000:DECIMAL,P11000:DECIMAL,P12000:DECIMAL,P21000:DECIMAL,P22000:DECIMAL,P23000:DECIMAL,";
		ls_temp +="P24000:DECIMAL,P25000:DECIMAL,P26000:DECIMAL,P27000:DECIMAL,P28000:DECIMAL,P29000:DECIMAL,";
		ls_temp +="P30000:DECIMAL,P31000:DECIMAL,P32000:DECIMAL,P36000:DECIMAL,P37000:DECIMAL,P38000:DECIMAL,";

		ls_temp +="PX0010:DECIMAL,PX0020:DECIMAL,PX0030:DECIMAL,PX0040:DECIMAL,P34000:DECIMAL,P35000:DECIMAL,P39000:DECIMAL,";

		ls_temp +="S91000:DECIMAL,T11000:DECIMAL,T12000:DECIMAL,B11000:DECIMAL,B12000:DECIMAL,B13000:DECIMAL,";

		ls_temp +="B15000:DECIMAL,B14000:DECIMAL,B16000:DECIMAL,BX0010:DECIMAL,BX0020:DECIMAL,BX0030:DECIMAL,";
		ls_temp +="BX0040:DECIMAL,P41000:DECIMAL,P42000:DECIMAL,T21000:DECIMAL,T22000:DECIMAL,S93000:DECIMAL,";

		ls_temp +="TS9100:DECIMAL,TT1100:DECIMAL,TT1200:DECIMAL,S94000:DECIMAL,STRTDT:STRING,PAYDT:STRING,JOBGRPHNM:STRING,";
		ls_temp +="DIVNM1:STRING,INSURNM1:STRING,TOTDAY1:STRING,TOTCNT1:DECIMAL,PERAMT1:DECIMAL,TOTAMT1:DECIMAL,";
		ls_temp +="DIVNM2:STRING,INSURNM2:STRING,TOTDAY2:STRING,TOTCNT2:DECIMAL,PERAMT2:DECIMAL,TOTAMT2:DECIMAL,";
		ls_temp +="DIVNM3:STRING,INSURNM3:STRING,TOTDAY3:STRING,TOTCNT3:DECIMAL,PERAMT3:DECIMAL,TOTAMT3:DECIMAL,";
		ls_temp +="SANGNAME:STRING,SANGRAT:STRING,BAEBUSU:STRING";
		
		ls_temp +=",PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
		
		gcds_report0.SetDataHeader(ls_temp);

		gcds_report0.Addrow();

		if (gcds_temp.namevalue(gcds_temp.rowposition,"PAYDIV") == '정기급여') { 
			gcds_report0.namevalue(1,"CTITLE")=gcds_temp.namevalue(gcds_temp.rowposition,"APPDT")
		                                  +""+gcds_temp.namevalue(gcds_temp.rowposition,"PAYDIV").substring(2,4);
		}else { 
			gcds_report0.namevalue(1,"CTITLE")=gcds_temp.namevalue(gcds_temp.rowposition,"APPDT")
		                                  +""+gcds_temp.namevalue(gcds_temp.rowposition,"PAYDIV").substring(0,2);
		}
		
		gcds_report0.namevalue(1,"EMPNO")=gcds_temp.namevalue(gcds_temp.rowposition,"EMPNO");
		gcds_report0.namevalue(1,"EMPNMK")=gcds_temp.namevalue(gcds_temp.rowposition,"EMPNMK");
		gcds_report0.namevalue(1,"DEPTNM")=gcds_temp.namevalue(gcds_temp.rowposition,"DEPTNM");
		gcds_report0.namevalue(1,"PAYGRDNM")=gcds_temp.namevalue(gcds_temp.rowposition,"PAYGRDNM");
		gcds_report0.namevalue(1,"PAYSEQNM")=gcds_temp.namevalue(gcds_temp.rowposition,"PAYSEQNM");
		gcds_report0.namevalue(1,"PAYBNKNM")=gcds_temp.namevalue(gcds_temp.rowposition,"PAYBNKNM");
		gcds_report0.namevalue(1,"PAYNUM")=gcds_temp.namevalue(gcds_temp.rowposition,"PAYNUM");

		gcds_report0.namevalue(1,"P10000")=gcds_temp.namevalue(gcds_temp.rowposition,"P10000");
		gcds_report0.namevalue(1,"P11000")=gcds_temp.namevalue(gcds_temp.rowposition,"P11000");
		gcds_report0.namevalue(1,"P12000")=gcds_temp.namevalue(gcds_temp.rowposition,"P12000");
		gcds_report0.namevalue(1,"P21000")=gcds_temp.namevalue(gcds_temp.rowposition,"P21000");
		gcds_report0.namevalue(1,"P22000")=gcds_temp.namevalue(gcds_temp.rowposition,"P22000");
		gcds_report0.namevalue(1,"P23000")=gcds_temp.namevalue(gcds_temp.rowposition,"P23000");
		gcds_report0.namevalue(1,"P24000")=gcds_temp.namevalue(gcds_temp.rowposition,"P24000");
		gcds_report0.namevalue(1,"P25000")=gcds_temp.namevalue(gcds_temp.rowposition,"P25000");
		gcds_report0.namevalue(1,"P26000")=gcds_temp.namevalue(gcds_temp.rowposition,"P26000");
		gcds_report0.namevalue(1,"P27000")=gcds_temp.namevalue(gcds_temp.rowposition,"P27000");
		gcds_report0.namevalue(1,"P28000")=gcds_temp.namevalue(gcds_temp.rowposition,"P28000");
		gcds_report0.namevalue(1,"P29000")=gcds_temp.namevalue(gcds_temp.rowposition,"P29000");
		gcds_report0.namevalue(1,"P30000")=gcds_temp.namevalue(gcds_temp.rowposition,"P30000");
		gcds_report0.namevalue(1,"P31000")=gcds_temp.namevalue(gcds_temp.rowposition,"P31000");
		gcds_report0.namevalue(1,"P32000")=gcds_temp.namevalue(gcds_temp.rowposition,"P32000");
		gcds_report0.namevalue(1,"P34000")=gcds_temp.namevalue(gcds_temp.rowposition,"P34000");
		gcds_report0.namevalue(1,"P35000")=gcds_temp.namevalue(gcds_temp.rowposition,"P35000");
		gcds_report0.namevalue(1,"P39000")=gcds_temp.namevalue(gcds_temp.rowposition,"P39000");
		gcds_report0.namevalue(1,"P36000")=gcds_temp.namevalue(gcds_temp.rowposition,"P36000");
		gcds_report0.namevalue(1,"P37000")=gcds_temp.namevalue(gcds_temp.rowposition,"P37000");
		gcds_report0.namevalue(1,"P38000")=gcds_temp.namevalue(gcds_temp.rowposition,"P38000");
		gcds_report0.namevalue(1,"P41000")=gcds_temp.namevalue(gcds_temp.rowposition,"P41000");
		gcds_report0.namevalue(1,"P42000")=gcds_temp.namevalue(gcds_temp.rowposition,"P42000");
		gcds_report0.namevalue(1,"PX0010")=gcds_temp.namevalue(gcds_temp.rowposition,"PX0010");
		gcds_report0.namevalue(1,"PX0020")=gcds_temp.namevalue(gcds_temp.rowposition,"PX0020");
		gcds_report0.namevalue(1,"PX0030")=gcds_temp.namevalue(gcds_temp.rowposition,"PX0030");
		gcds_report0.namevalue(1,"PX0040")=gcds_temp.namevalue(gcds_temp.rowposition,"PX0040");
		gcds_report0.namevalue(1,"S91000")=gcds_temp.namevalue(gcds_temp.rowposition,"S91000");
		gcds_report0.namevalue(1,"S93000")=gcds_temp.namevalue(gcds_temp.rowposition,"S93000");
		gcds_report0.namevalue(1,"S94000")=gcds_temp.namevalue(gcds_temp.rowposition,"S94000");
		gcds_report0.namevalue(1,"T11000")=gcds_temp.namevalue(gcds_temp.rowposition,"T11000");
		gcds_report0.namevalue(1,"T12000")=gcds_temp.namevalue(gcds_temp.rowposition,"T12000");
		gcds_report0.namevalue(1,"T21000")=gcds_temp.namevalue(gcds_temp.rowposition,"T21000");
		gcds_report0.namevalue(1,"T22000")=gcds_temp.namevalue(gcds_temp.rowposition,"T22000");
		gcds_report0.namevalue(1,"B11000")=gcds_temp.namevalue(gcds_temp.rowposition,"B11000");
		gcds_report0.namevalue(1,"B12000")=gcds_temp.namevalue(gcds_temp.rowposition,"B12000");
		gcds_report0.namevalue(1,"B13000")=gcds_temp.namevalue(gcds_temp.rowposition,"B13000");
		gcds_report0.namevalue(1,"B14000")=gcds_temp.namevalue(gcds_temp.rowposition,"B14000");
		gcds_report0.namevalue(1,"B15000")=gcds_temp.namevalue(gcds_temp.rowposition,"B15000");
		gcds_report0.namevalue(1,"B16000")=gcds_temp.namevalue(gcds_temp.rowposition,"B16000");
		gcds_report0.namevalue(1,"BX0010")=gcds_temp.namevalue(gcds_temp.rowposition,"BX0010");
		gcds_report0.namevalue(1,"BX0020")=gcds_temp.namevalue(gcds_temp.rowposition,"BX0020");
		gcds_report0.namevalue(1,"BX0030")=gcds_temp.namevalue(gcds_temp.rowposition,"BX0030");
		gcds_report0.namevalue(1,"BX0040")=gcds_temp.namevalue(gcds_temp.rowposition,"BX0040");
		gcds_report0.namevalue(1,"PAYDT") =gcds_temp.namevalue(gcds_temp.rowposition,"PAYDT");
		gcds_report0.namevalue(1,"STRTDT")=gcds_temp.namevalue(gcds_temp.rowposition,"STRTDT");
	  gcds_report0.namevalue(1,"JOBGRPHNM")=gcds_temp.namevalue(gcds_temp.rowposition,"JOBGRPHNM");
		gcds_report0.namevalue(1,"TS9100") =gcds_temp.namevalue(gcds_temp.rowposition,"TS9100");
		gcds_report0.namevalue(1,"TT1100")=gcds_temp.namevalue(gcds_temp.rowposition,"TT1100");
	  gcds_report0.namevalue(1,"TT1200")=gcds_temp.namevalue(gcds_temp.rowposition,"TT1200");
		gcds_report0.namevalue(1,"P35000")=gcds_temp.namevalue(gcds_temp.rowposition,"P35000");

		gcds_report0.namevalue(1,"PR0020")=gcds_temp.namevalue(gcds_temp.rowposition,"PR0020");
		gcds_report0.namevalue(1,"PR0030")=gcds_temp.namevalue(gcds_temp.rowposition,"PR0030");
		gcds_report0.namevalue(1,"PR0040")=gcds_temp.namevalue(gcds_temp.rowposition,"PR0040");
		gcds_report0.namevalue(1,"BR0020")=gcds_temp.namevalue(gcds_temp.rowposition,"BR0020");
		gcds_report0.namevalue(1,"BR0030")=gcds_temp.namevalue(gcds_temp.rowposition,"BR0030");
		gcds_report0.namevalue(1,"BR0040")=gcds_temp.namevalue(gcds_temp.rowposition,"BR0040");
//대출상환 START------------------------------------------------------------------------------------------
		gcds_report0.namevalue(1,"APLAMT")=gcds_temp.namevalue(gcds_temp.rowposition,"APLAMT");
		gcds_report0.namevalue(1,"APLRAT")=gcds_temp.namevalue(gcds_temp.rowposition,"APLRAT");
		gcds_report0.namevalue(1,"APPCNT")=gcds_temp.namevalue(gcds_temp.rowposition,"APPCNT");
		gcds_report0.namevalue(1,"APJAMT")=gcds_temp.namevalue(gcds_temp.rowposition,"APJAMT");
//대출상환 END--------------------------------------------------------------------------------------------
    var str6= '1';///fn_trim(gclx_select_ec01az.BindColVal);// 상여구분
	   if(str6=='5')
	   {gcds_report0.namevalue(1,"SANGNAME") ="상   여   율 :";
		gcds_report0.namevalue(1,"SANGRAT") =gcds_temp.namevalue(gcds_temp.rowposition,"SANGRAT")+""+"%";
		}
	  	var str1=gcds_temp.namevalue(gcds_temp.rowposition,"P23002");
	    var str2=gcds_temp.namevalue(gcds_temp.rowposition,"P23003");
		  var str3 =gcds_temp.namevalue(gcds_temp.rowposition,"P23004");
	  	var str4=gcds_temp.namevalue(gcds_temp.rowposition,"P23005");
	    var str5=gcds_temp.namevalue(gcds_temp.rowposition,"P23006");
		gcds_report0.namevalue(1,"BAEBUSU") =str1+"-"+str2+"-"+str3+"-"+str4+"-"+str5;

		gcds_report1.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050005_s1?" 
		             + "v_str3=" + gcds_temp.namevalue(gcds_temp.rowposition,"EMPNO");
		gcds_report1.Reset(); //그리드
		for(var i=1;i<=gcds_report1.countrow; i++)  //저축내역 리포터 최대 3개 row
		{
		gcds_report1.rowposition=i;   
			gcds_report0.namevalue(1,("DIVNM"+i)) =  gcds_report1.namevalue(gcds_report1.rowposition,"DIVNM");
		  gcds_report0.namevalue(1,("INSURNM"+i)) =gcds_report1.namevalue(gcds_report1.rowposition,"INSURNM");
			gcds_report0.namevalue(1,("TOTDAY"+i)) = gcds_report1.namevalue(gcds_report1.rowposition,"TOTDAY");
			gcds_report0.namevalue(1,("TOTCNT"+i)) = gcds_report1.namevalue(gcds_report1.rowposition,"TOTCNT");
			gcds_report0.namevalue(1,("PERAMT"+i)) = gcds_report1.namevalue(gcds_report1.rowposition,"PERAMT");
			gcds_report0.namevalue(1,("TOTAMT"+i)) = gcds_report1.namevalue(gcds_report1.rowposition,"TOTAMT");
		}
		gcrp_print.preview();
	}
}


/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
}

/******************************************************************************
	Description : 본부-부-팀 [Default : LEVEL-3]
******************************************************************************/
function ln_DeptLevel(){

  if (gcds_data00.countrow<1) {
	} else {
	
	var row = gcds_data00.rowposition;
	var row2 = gcds_deptlevel.rowposition;

		if (gcds_data00.namevalue(row,"DEPTCD") == 'A000') {
			txt_dlevel.value  =  "현대아산";
		}else if (gcds_data00.namevalue(row,"LEVEL") =='2') {
			txt_dlevel.value  =  "현대아산";
		/********** [ 3 ] L E V E L   S T A R T *******************************************************************************/
		}else if (gcds_data00.namevalue(row,"LEVEL") =='3') {
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,2);	//LEVEL [ 2 ] CHECK
			var tree03 = gcds_data00.namevalue(row,"TREECD").substring(2,4);	//LEVEL [ 3 ] CHECK
			
			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (tree03 == gcds_deptlevel.namevalue(i,"TREECD").substring(2,4) && gcds_deptlevel.namevalue(i,"LEVEL") == '3'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,2)) {
					var level03 = gcds_data00.namevalue(row,"TREECD").substring(0,2) + "000000";
					for(j=1;j<=gcds_deptlevel.countrow;j++) {
						if (level03 == gcds_deptlevel.namevalue(j,"TREECD")) {		
							var re_deptnm = gcds_deptlevel.namevalue(j,"DEPTNM");
						}
					}
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);	// RESULT
		/********** [ 3 ] L E V E L   E N D ***********************************************************************************/
		
		/********** [ 4 ] L E V E L   S T A R T *******************************************************************************/
		}else if (gcds_data00.namevalue(row,"LEVEL") =='4') {
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,2);	//LEVEL [ 2 ] CHECK
			var tree04 = gcds_data00.namevalue(row,"TREECD").substring(4,6);	//LEVEL [ 4 ] CHECK

			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (tree04 == gcds_deptlevel.namevalue(i,"TREECD").substring(4,6) && gcds_deptlevel.namevalue(i,"LEVEL") == '4'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,2)) {
					var level04 = gcds_data00.namevalue(row,"TREECD").substring(0,4) + "0000";
					for(j=1;j<=gcds_deptlevel.countrow;j++) {
						if (level04 == gcds_deptlevel.namevalue(j,"TREECD")) {		
							var re_deptnm = gcds_deptlevel.namevalue(j,"DEPTNM");
						}
					}
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);	// RESULT
		/********** [ 4 ] L E V E L   E N D ***********************************************************************************/
		
		/********** [ 5 ] L E V E L   S T A R T *******************************************************************************/
		}else if (gcds_data00.namevalue(row,"LEVEL") =='5') {
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,2);	//LEVEL [ 2 ] CHECK
			var tree05 = gcds_data00.namevalue(row,"TREECD").substring(6,8);	//LEVEL [ 4 ] CHECK

			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (tree05 == gcds_deptlevel.namevalue(i,"TREECD").substring(6,8) && gcds_deptlevel.namevalue(i,"LEVEL") == '5'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,2)) {
					var level05 = gcds_data00.namevalue(row,"TREECD").substring(0,6) + "00";
					for(j=1;j<=gcds_deptlevel.countrow;j++) {
						if (level05 == gcds_deptlevel.namevalue(j,"TREECD")) {		
							var re_deptnm = gcds_deptlevel.namevalue(j,"DEPTNM");
						}
					}
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);	// RESULT
		/********** [ 5 ] L E V E L   E N D ***********************************************************************************/
		}else{
			txt_dlevel.value  =  fn_trim(gcds_data00.namevalue(row,"DEPTNM"));	// 그외 퇴직자 RESULT
		}
	}
  /*******
	if (gcds_data00.countrow<1) {
	} else {
	
	var row = gcds_data00.rowposition;
	var row2 = gcds_deptlevel.rowposition;
	var level2nm = gcds_data00.namevalue(row,"DEPTNM");
	var dlevel = gcds_deptlevel.namevalue(row2,"DEPTNM");
		
		if (gcds_data00.namevalue(row,"DEPTCD") == 'A000') {
			txt_dlevel.value  =  "현대아산";
		}else if (gcds_data00.namevalue(row,"LEVEL") =='2') {
			txt_dlevel.value  =  "현대아산";
		}else if (gcds_data00.namevalue(row,"LEVEL") =='3') {
			//alert("3 - "+gcds_data00.namevalue(row,"DEPTCD"));
			var level3 = gcds_data00.namevalue(row,"DEPTCD").substring(0,1);
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,4);
			for(i=1;i<=gcds_deptlevel.countrow;i++) {
				if (level3 == gcds_deptlevel.namevalue(i,"DEPTCD").substring(0,1) && gcds_deptlevel.namevalue(i,"LEVEL") == '2'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,4)) {
					var re_deptnm = gcds_deptlevel.namevalue(i,"DEPTNM");
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);
		}else if (gcds_data00.namevalue(row,"LEVEL") =='4') {
			//alert("4 - "+gcds_data00.namevalue(row,"DEPTCD"));
			var level3 = gcds_data00.namevalue(row,"DEPTCD").substring(0,2);
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,4);
			for(i=1;i<=gcds_deptlevel.countrow;i++) {				
				if (level3 == gcds_deptlevel.namevalue(i,"DEPTCD").substring(0,2) && gcds_deptlevel.namevalue(i,"LEVEL") == '3'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,4)) {
					var re_deptnm = gcds_deptlevel.namevalue(i,"DEPTNM");
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);
		}else{
			//alert("else - "+gcds_data00.namevalue(row,"DEPTCD"));
			var level3 = gcds_data00.namevalue(row,"DEPTCD").substring(0,2);
			var treenm = gcds_data00.namevalue(row,"TREECD").substring(0,4);
			for(i=1;i<=gcds_deptlevel.countrow;i++) {
				if (level3 == gcds_deptlevel.namevalue(i,"DEPTCD").substring(0,2) && gcds_deptlevel.namevalue(i,"LEVEL") == '3'
				 && treenm == gcds_deptlevel.namevalue(i,"TREECD").substring(0,4)) {
					var re_deptnm = gcds_deptlevel.namevalue(i,"DEPTNM");
				}else{
					var re_deptnm = "";
				}
			}
			txt_dlevel.value  =  fn_trim(re_deptnm);
		}

	}//end if

	******/
}



</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>



<comment id="__NSID__"><OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data052 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_relatgrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_nomingrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grddiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobgrph classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_edccd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_empdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rilign classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_paybnkcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hdfamret classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_relatre classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_assret classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_nominre classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_mrtdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcstype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcscd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_gieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_milidiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_miliknd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_miligrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_milispec classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_militype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_militgbn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_englvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_ordcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_payseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_disdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_disgrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_colblnyn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rewgbn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rewkin classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_recdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 입사채용 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobkind classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직종 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 출력-temp -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 출력 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 출력 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlevel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 소속-팀 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="데이타 조회중입니다. 잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	window.status="데이타 조회중입니다.. 잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
	window.status="데이타 조회중입니다... 잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data04" event="OnLoadStarted()">
	window.status="데이타 조회중입니다....잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data09" event="OnLoadStarted()">
	window.status="데이타 조회중입니다! 잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data10" event="OnLoadStarted()">
	window.status="데이타 조회중입니다.!.잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data11" event="OnLoadStarted()">
	window.status="데이타 조회중입니다!...잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_temp" event="OnLoadStarted()">
	window.status="데이타 조회중입니다!! 잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
	ln_DeptLevel();
	window.status="조회가 완료 되었습니다.";
	if (row>0){
		if (gcds_data00.namevalue(1,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data00.namevalue(1,"empno");
			photo.src="/servlet/Contract.h080007_s0?v_str1="+str1;
		}
	} else {
		alert("검색된 데이터가 없습니다.");
	}



	
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
//	// document.all.LowerFrame.style.visibility="hidden";

  //document.getElementById("LowerFrame").style.visibility="hidden";
	ft_cnt3.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt4.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data05" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt5.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data052" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
		gcds_data06.addrow();
	}
</script>

<script language="javascript" for="gcds_data07" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt7.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data09" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt9.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data10" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt10.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data11" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt11.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	
	ln_Print();

	window.status="조회가 완료 되었습니다.";
	//// document.all.LowerFrame.style.visibility="hidden";
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="onselChanged(index)">
	if (gcds_data00.countrow>0) {
		if (index=="2") ln_FamQuery();
		else if (index=="3") ln_CarQuery();
		else if (index=="4") ln_EduQuery();
		else if (index=="5") ln_EngQuery();
		else if (index=="6") ln_LicQuery();
		else if (index=="7") ln_OrdQuery();
		else if (index=="8") ln_DeuQuery();
		else if (index=="9") ln_ReqQuery();
		else if (index=="10") ln_AssQuery();
		else if (index=="11") ln_RewQuery();
	}
</script>

<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
		gcte_disp.ActiveIndex = 1;

		if (gcds_data00.namevalue(row,"picture")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data00.namevalue(row,"empno");
			photo.src="http://www.singiro.co.kr/servlet/Contract.h080007_s0?v_str1="+str1;
		}
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcte_disp.ActiveIndex = 1;
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("요청하신 작업이 성공적으로 수행되지 못했습니다.");

	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876", height="0" border="0" cellpadding="0" cellspacing="0">
	<tr height="30px">
		<td colspan="2"> 
			<div id=top_btn_visible style="display:block">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
			  <tr> 
					<td width="215" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/h080007_head.gif" width=197></td>
					<td width="661" align="right"  valign=middle background="../../Common/img/com_t_bg.gif">
					<img name="btn_save" src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
						<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_PrintQuery()"> -->
					</td>
				</tr>
			</table>
			</div>
		  <div id=top_btn_hidden style="display:none">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
				<tr> 
					<td width="215" background="../../Common/img/com_t_bg.gif"><img height=47 src="../img/h030001_head.gif" width=197></td>
					<td width="661" align="right"  valign=middle background="../../Common/img/com_t_bg.gif">
						<img name="btn_photo" src="../../Common/img/btn/com_b_photo.gif"  style="cursor:hand" onclick="ln_Photo()">
						<!-- <img name="btn_print" src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print"> -->
					</td>
				</tr>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td width=80%  height="0" valign="top">
			<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:4px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
				<tr>
					<td class="tab12">
						<table border=0 cellpadding=0 cellspacing=0 width="125px">
							<tr>
								<td class="tab13" style="height:126px;"><img id="photo" src="photo/00000.gif" border=0 width="85px" height="100px"></td>
							</tr>
							<tr>
								<td colspan="2">
									<table border="0" cellpadding=0 cellspacing=0>
										<tr>
											<td class="tab22" style="height:26px;width:125px" align=center><input type="text" id="txt_dlevel" class="txtbox" style="position:relative;top:3px;width:120px;height:19px;text-align:center;border:0px"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					
					<td>
						<table border="0" cellpadding=0 cellspacing=0 style="border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;">
							<tr> 
								<td class="tab11" width="80px;" bgcolor="#eeeeee">성명</td>
								<td class="tab21" width="400px;">
									<input type="text" id=txt_empnmk class="txt11" style="position:relative;top:2px;width:80px;border:0">
									<input type="text" id=txt_empnmc class="txt11" style="position:relative;top:2px;width:80px;border:0">
									<input type="text" id=txt_empnme class="txt11" style="position:relative;top:2px;width:180px;border:0">
								</td>
								<td class="tab11" width="80px;" bgcolor="#eeeeee">사번</td>
								<td class="tab22" width="185px"><input type="text" id=txt_empno class="txt11" style="position:relative;top:2px;width:80px;border:0" ></td>
							</tr> 
							<tr>
								<td colspan="4">
									<table border="0" cellpadding=0 cellspacing=0>
										<tr>
				              <td class="tab11" width="80px;" bgcolor="#eeeeee">주민번호</td>
					            <td class="tab21" width="200px">
												<comment id="__NSID__"><object id=gcem_resino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:92px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="000000-0000000">
														<param name=PromptChar	  value="_">
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
		                  <td class="tab11" width="80px" bgcolor="#eeeeee">생년월일</td>
			                <td class="tab22" width="75px">
												<comment id="__NSID__"><object id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<!-- <param name=Enable			  value="false"> -->
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td class="tab22" width="10px">&nbsp;</td>
											<td class="tab22" width="300px">
												<comment id="__NSID__"><object id=gcra_gldiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
													style="position:relative;left:0px;top:3px;height:20;width:100;cursor:hand;">
														<param name=Cols     value="2">
														<param name=Format   value="1^음력,2^양력">
														<!-- <param name=Enable	 value="false"> -->
												</object></comment><script>__ws__(__NSID__);</script>
												<input type="text" id=gclx_sex  class="txt11" style="position:relative;left:8px;top:0px;width:70px;border:0">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="tab11" bgcolor="#eeeeee">소속직위</td>
                <td class="tab21">
									<input type="text" id=gclx_deptcd  class="txt11" style="position:relative;left:8px;top:3px;width:120px;border:0">
									<input type="text" id=gclx_deptlvl class="txt11" style="position:relative;left:8px;top:3px;width:120px;border:0">
	
									<input type="text" id=txt_payseq class="txt11" style="position:relative;left:12px;top:3px;width:20px;border:0" maxlength="4" onBlur="bytelength(this,this.value,4);" >
									<input type="text" id=txt_ho class="txt11" style="border:0px;position:relative;left:10px;top:3px;width:30px;" value="호봉" >
								</td>
                <td class="tab11" bgcolor="#eeeeee">직군구분</td>
                <td class="tab22">
									<input type="text" id=gclx_jobgrph  class="txt11" style="position:relative;left:8px;top:3px;width:120px;border:0">
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">소속발령</td>
                      <td class="tab21" width="200px">
												<comment id="__NSID__"><object id=gcem_dpoffdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<!-- <param name=Enable			  value="false"> -->
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">승진일</td>
                      <td class="tab21" width="118px">
												<comment id="__NSID__"><object id=gcem_lamdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<!-- <param name=Enable			  value="false"> -->
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">수습여부</td>
                      <td class="tab22" width="185px">
												<comment id="__NSID__"><object id=gcra_trainyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
													style="position:relative;left:4px;top:0px;height:20;width:80;cursor:hand;">
														<param name=Cols     value="2">
														<param name=Format   value="1^Y,2^N">
														<!-- <param name=Enable	 value="false"> -->
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
                    </tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">입사</td>
                      <td class="tab21" width="200px">
												<input type="text" id=gclx_empdiv  class="txt11" style="position:relative;left:8px;top:3px;width:70px;border:0">
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">입사채용</td>
                      <td class="tab21" width="118px">
												<input type="text" id=gclx_recdiv  class="txt11" style="position:relative;left:8px;top:3px;width:70px;border:0">
											</td>
                      <td class="tab11" width="80px;" bgcolor="#eeeeee">직종</td>
                      <td class="tab22" width="185px">
												<input type="text" id=gclx_jobkind  class="txt11" style="position:relative;left:8px;top:3px;width:70px;border:0">
											</td>
                    </tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
                      <td class="tab12" width="80px;" bgcolor="#eeeeee">그룹입사일</td>
											<td class="tab23" width="200px">
												<comment id="__NSID__"><object id=gcem_grstrtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<!-- <param name=Enable			  value="false"> -->
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab12" width="80px;" bgcolor="#eeeeee">입사일</td>
                      <td class="tab23" width="118px">
												<comment id="__NSID__"><object id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<!-- <param name=Enable			  value="false"> -->
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td class="tab12" width="80px;" bgcolor="#eeeeee">퇴사일</td>
											<td width="100px">
												<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=false>
														<param name=Format	      value="YYYY/MM/DD">
														<!-- <param name=Enable			  value="false"> -->
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;top:18px;left:4px;">
				<tr>
					<td>
						<comment id="__NSID__"><object id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 
							style="width:660px;height:20px">
								<PARAM NAME="BackColor"					VALUE="#cccccc">
								<PARAM NAME="titleHeight"				VALUE="20px">
		            <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
								<PARAM NAME="Format"						VALUE="
									<T>divid=layer1  title='기본'</T>									
									<T>divid=layer2  title='가족'</T>
								  <T>divid=layer3  title='경력'</T>
								  <T>divid=layer5  title='학력'</T>
								  <T>divid=layer8  title='어학/전산'</T>
								  <T>divid=layer4  title='자격면허'</T>
								  <T>divid=layer7  title='사내경력'</T>
								  <T>divid=layer9  title='고과'</T>
								  <T>divid=layer10 title='교육'</T>
								  <T>divid=layer6  title='보증/신체/병역'</T>
								  <T>divid=layer11 title='상벌관리'</T>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!---------[TAB 1] left:200px;기본사항 ----------->
<div id="layer1" style="position:absolute; top:330px; left:175px; width:780px">
  <table style="border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td class="tab11" width="75px" bgcolor="#eeeeee">우편번호</td>
  	  <td class="tab21" width="120px">
				<comment id="__NSID__"><object id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:3px; width:50px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<param name=Format	      value="000-000">
						<!-- <param name=Enable	      value="false"> -->
						<param name=PromptChar	  value="_">
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">현주소</td>
  	  <td class="tab22" width="600px">
				<input type="text" id=txt_caddr01 class="txt11" style="position:relative;top:2px;width:575px;border:0" >
				<!-- <input type="text" id=txt_caddr02 class="txt11" style="position:relative;top:2px;width:300px;border:0" > -->
			</td>
  	</tr>
		<tr>
			<td class="tab11" bgcolor="#eeeeee">우편번호</td>
  	  <td class="tab21">
				<comment id="__NSID__"><object id=gcem_ozipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:3px; width:50px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<param name=Format	      value="000-000">
						<!-- <param name=Enable	      value="false"> -->
						<param name=PromptChar	  value="_">
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" bgcolor="#eeeeee">본적주소</td>
  	  <td class="tab22">
				<input type="text" id=txt_oaddr01 class="txt11" style="position:relative;top:2px;width:575px;border:0" >
				<!-- <input type="text" id=txt_oaddr02 class="txt11" style="position:relative;top:2px;width:300px;border:0" > -->
			</td>
  	</tr>
		<tr>
			<td colspan="4">
				<table cellpadding=0 cellspacing=0 border=0>
					<tr>
					  <td class="tab11" width="75px" bgcolor="#eeeeee">연락처</td>
					  <td class="tab22">&nbsp;(TEL)</td>
						<td class="tab22" width="95px;"><input type="text" id=txt_telno class="txt11" style="position:relative;top:2px;width:80px;border:0" ></td>
						<td class="tab22">&nbsp;&nbsp;(사내)</td>
						<td class="tab22" width="103px;"><input type="text" id=txt_offtelno class="txt11" style="position:relative;top:2px;width:80px;border:0" ></td>
						<td class="tab22">&nbsp;&nbsp;(H/P)</td>
						<td class="tab21" width="156px"><input type="text" id=txt_hpno class="txt11" style="position:relative;top:2px;width:80px;border:0" ></td>
		  		  <td class="tab11" width="75px" bgcolor="#eeeeee">eMail</td>
					  <td class="tab22" width="240px"><input type="text" id=txt_email class="txt11" style="position:relative;top:2px;width:140px;border:1" 
					  maxlength="30" onBlur="bytelength(this,this.value,30);" ></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table style="position:relative;top:4px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td class="tab11" width="76px" bgcolor="#eeeeee">기타사항</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">취미</td>
			<td class="tab21" width="150px"><input type="text" id=txt_hobby class="txt11" style="position:relative;top:2px;width:100px;border:0" ></td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">특기</td>
			<td class="tab21" width="180px"><input type="text" id=txt_special class="txt11" style="position:relative;top:2px;width:100px;border:0" ></td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">종교</td>
			<td class="tab22" width="240px">
				<input type="text" id=gclx_rilign  class="txt11" style="position:relative;left:8px;top:3px;width:70px;border:0">
			</td>
		</tr>
		<tr>
			<td class="tab12">&nbsp;</td>
			<td class="tab11" bgcolor="#eeeeee">결혼기념</td>
			<td class="tab21">
				<comment id="__NSID__"><object id=gcem_mrydt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:3px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<param name=Format	      value="YYYY/MM/DD">
						<!-- <param name=Enable			  value="false"> -->
						<param name=PromptChar	  value="_">
		    </object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" bgcolor="#eeeeee">건강보험</td>
			<td class="tab21"><nobr>
				<comment id="__NSID__"><object id=gcem_inscod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:4px; width:20px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<param name=Numeric	      value="true">
						<!-- <param name=Enable			  value="false"> -->
		    </object></comment><script>__ws__(__NSID__);</script>&nbsp;<input type=text value=등급 STYLE="BORDER:0px;width:30px" ></nobr>
			</td>
			<td class="tab11" bgcolor="#eeeeee">국민연금</td>
			<td class="tab22"><nobr>
				<comment id="__NSID__"><object id=gcem_pencod classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:4px; width:20px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<param name=Numeric	      value="true">
						<!-- <param name=Enable			  value="false"> -->
		    </object></comment><script>__ws__(__NSID__);</script>&nbsp;<input type=text value=등급 STYLE="BORDER:0px;width:30px" ></nobr>
			</td>
		</tr>
		<tr>
			<td class="tab11">&nbsp;</td>
			<td class="tab11" bgcolor="#eeeeee">노조가입</td>
			<td class="tab21">
				<comment id="__NSID__"><object id=gcra_labuniyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:4px;top:0px;height:20;width:120;cursor:hand;">
						<param name=Cols     value="2">
	          <param name=Format   value="1^노조,2^비노조">
						<!-- <param name=Enable	 value="false"> -->
        </object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab11" bgcolor="#eeeeee">보훈대상</td>
			<td class="tab21">
				<input type="text" id=gclx_mrtdiv  class="txt11" style="position:relative;left:8px;top:3px;width:70px;border:0">
			</td>
			<td class="tab11" bgcolor="#eeeeee">장애</td>
			<td class="tab22">
				<comment id="__NSID__"><object id=gcra_hitchyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:4px;top:0px;height:20;width:120;cursor:hand;" disabled>
						<param name=Cols     value="2">
	          <param name=Format   value="Y^예,N^아니오">
						<!-- <param name=Enable	 value="false"> -->
        </object>
			</td>
		</tr>
	</table>

	<table style="position:relative;top:8px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td class="tab11" width="75px" bgcolor="#eeeeee">급여</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">은행</td>
			<td class="tab21" width="150px;">
				<input type="text" id=gclx_paybnkcd  class="txt11" style="position:relative;left:8px;top:3px;width:70px;border:0">
			</td>
			<td class="tab11" width="75px" bgcolor="#eeeeee">계좌번호</td>
			<td class="tab22" width="497px">
				<comment id="__NSID__"><object id=gcem_payacnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:3px; width:130px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=false>
						<!-- <param name=Numeric	      value="true"> -->
						<!-- <param name=Enable			  value="false"> -->
						<param name=Format	      value="00000000000000000000">
		    </object></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 2] 가족사항 그리드----------->
<div id="layer2" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
		  <td style="width:875;" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299">
            <param name=dataid					value=gcds_data02>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=26,	align=right </F> 
							<F> Name=주민번호 ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=100, align=center MASK="XXXXXX-XXXXXXX"</F> 
						 	<C> Name=성명			ID=FAMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=74,	align=left</C> 
							<C> Name=관계			ID=REFCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60,	align=left,		EditStyle=Lookup, Data="gcds_hdfamret:minorcd:minornm"</C> 
							<C> Name=동거			ID=LIVEYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=87,	align=center,	EditStyle=combo,	Data="1:동거,2:비동거"</C> 
							<C> Name=부양			ID=SPTYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=87,	align=center,	EditStyle=combo,	Data="1:부양,2:피부양"</C> 
							<C> Name=장애			ID=DISYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=77,	align=center,	EditStyle=combo,	Data="1:유,2:무"</C> 
							<C> Name=직업			ID=CMPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=165,	align=left</C> 
							<C> Name=학력			ID=LSTEDC		HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=left,		EditStyle=Lookup, Data="gcds_edccd:minorcd:minornm" </C> 
							<C> Name=의보			ID=MEDINYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=42,	align=center,	EditStyle=combo,	Data="1:유,2:무"</C> 
							<C> Name=소득			ID=GETYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=38,	align=center,	EditStyle=combo,	Data="Y:유,N:무", show=false</C> 
							<C> Name=수당			ID=PAYYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=38,	align=center,	EditStyle=combo,	Data="Y:유,N:무"</C> 
						'>
			  </OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 3] 경력사항 그리드----------->
<div id="layer3" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
		  <td style="width:875;" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299">
            <param name=dataid					value=gcds_data03>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC  Align=right Width=33 </F> 
							<G> Name=근무기간 HeadBgColor=#B9D4DC
		 						<C> Name=입사일		ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Align=center Mask="XXXX/XX/XX"</C> 
								<C> Name=퇴사일		ID=ENDDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Align=center Mask="XXXX/XX/XX"</C> 
	            </G>
							<C> Name=회사명			ID=CAPLACE	HeadAlign=Center HeadBgColor=#B9D4DC Width=174 Align=left</C> 
							<C> Name=직위명			ID=POSINM		HeadAlign=Center HeadBgColor=#B9D4DC Width=130 Align=left</C> 
							<C> Name=담당업무		ID=DUTYNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 Align=left</C>
							<C> Name=퇴직사유		ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=162 Align=left</C>
						'> 
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt3 style="position:relative;top:4px;"></font>
				</fieldset>
		  </td>
		</tr>
  </table>
</div>

<!---------[TAB 4] 자격면허사항 그리드----------->
<div id="layer4" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0 >
		<tr>
		  <td style="width:875;" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299">
            <param name=dataid					value=gcds_data04>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	align=right </F> 
							<C> Name=취득일자 ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center, Mask="XXXX/XX/XX"</C> 
							<C> Name=자격구분 ID=LCSCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left,		EditStyle=Lookup, Data="gcds_lcscd:minorcd:minornm"</C> 
							<C> Name=자격증명 ID=LCSTYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left,		EditStyle=Lookup, Data="gcds_lcstype:minorcd:minornm"</C> 
							<C> Name=증번호   ID=LCSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=center </C> 
							<C> Name=발행처   ID=ISSPART	HeadAlign=Center HeadBgColor=#B9D4DC Width=249	align=left </C> 
							<C> Name=수당			ID=APPYN		HeadAlign=Center HeadBgColor=#B9D4DC Width=38,	align=center,	EditStyle=combo,	Data="Y:유,N:무"</C> 
            '>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt4 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

  <!---------[TAB 5] 학력사항 그리드----------->
<div id="layer5" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; ">
  <table cellpadding=0 cellspacing=0 border=0 style="border:1 solid #708090;border-bottom-width:0px;">
		<tr>
		  <td style="width:875;" colspan="3">
				<comment id="__NSID__"><OBJECT id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299;">
            <param name=dataid					value=gcds_data05>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=Editable        value=false>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
				 			<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30, align=right</F>
							<G> Name=교육기간 HeadBgColor=#B9D4DC
								<C> Name=입학년도 ID=STRYY	HeadAlign=Center HeadBgColor=#B9D4DC Width=100, align=center</C> 
								<C> Name=졸업년도 ID=GRAYY	HeadAlign=Center HeadBgColor=#B9D4DC Width=100, align=center</C> 
							</G>
							<C> Name=학교명		ID=SCHNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=255 </C> 
							<C> Name=학력			ID=EDCCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=125 EditStyle=Lookup, data="gcds_hieduc:minorcd:minornm" </C> 
							<C> Name=전공			ID=PGCCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=145 Editstyle=LookUp, data="gcds_pieduc:minorcd:minornm"</C> 
							<C> Name=학위			ID=EDCDIV HeadAlign=Center HeadBgColor=#B9D4DC Width=104 Editstyle=LookUp, data="gcds_gieduc:minorcd:minornm"</C> 
						'>  
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt5 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 6] 신원보증/신체사항 ----------->
<div id="layer6" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td width="150px;">&nbsp;<b>보증/신체/병역사항</b></td>
			<td height="25px" align="right" valign="bottom">&nbsp;</td>
			<td width="4px;"></td>
		</tr>
		<tr>	
			<td colspan="3">
				<table border="0" cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-top-width:1px">
					<tr>
						<!--
						<td class="tab11" width="75px" bgcolor="#eeeeee">보증구분</td>
						<td class="tab21" width="100px;">
	 						<comment id="__NSID__"><object id=gclx_assgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
									<param name=CBData					value="1^인보증,2^보증보험">
									<param name=CBDataColumns		value="Code, Parm">
									<param name=SearchColumn		value="Parm">
									<param name=Sort						value="false">
									<param name=ListExprFormat	value="Parm^0^100">
									<param name=BindColumn			value="Code">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						-->
						<td class="tab11" width="75px" bgcolor="#eeeeee">보증기간</td>
						<td class="tab21" width="276px;">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="80px;" height="25px">
										<comment id="__NSID__"><object id=gcem_afrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
												<!-- <param name=Enable				value="false"> -->
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td align=center>&nbsp;~&nbsp;</td>
									<td>
										<comment id="__NSID__"><object id=gcem_atodt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
												<!-- <param name=Enable				value="false"> -->
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
							</table>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">보증금액</td>
						<td class="tab22" width="445px;">
							<comment id="__NSID__"><object id=gcem_assamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value=true>
									<param name=Maxlength     value="9">
									<!-- <param name=Enable				value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table>				
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">보증기관</td>
						<td class="tab21" width="276px" ><input type="text" id=txt_assinst class="txt11" style="position:relative;top:2px;width:200px;border:0" ></td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">증권번호</td>
						<td class="tab21" width="145px" >
							<comment id="__NSID__"><object id=gcem_assno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:8px;top:3px; width:128px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Format	      value="00000000000000000000">
									<param name=PromptChar	  value="_">
									<!-- <param name=Enable				value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="75" bgcolor="#eeeeee">납부금액</td>
						<td class="tab22" width="223px">
							<comment id="__NSID__"><object id=gcem_recpamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:8px;top:3px; width:92px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value=true>
									<param name=Maxlength     value="14">
									<!-- <param name=Enable				value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  <table cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;border:1 solid #708090;border-bottom-width:0px;">
		<tr>	
			<td colspan="3">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">검진기관</td>
						<td class="tab21" width="276px;"><input type="text" id=txt_hospital class="txt11" style="position:relative;top:2px;width:130px;border:0" ></td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">검진일자</td>
						<td class="tab22" width="100px;" colspan="3">
							<comment id="__NSID__"><object id=gcem_hosdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Format	      value="YYYY/MM/DD">
									<!-- <param name=Enable			  value="false"> -->
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab11" bgcolor="#eeeeee">소견</td>
						<td class="tab22" width="220px;" colspan="5"><input type="text" id=txt_hosmemo class="txt11" style="position:relative;top:2px;width:405px;border:0" ></td>
					</tr>
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">신장체중</td>
						<td class="tab21" width="150px;">
							<comment id="__NSID__"><object id=gcem_height classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:8px;top:4px; width:25px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value="true">
									<!-- <param name=Enable			  value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:8px;top:0px;">Cm</span>
							<comment id="__NSID__"><object id=gcem_weight classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:20px;top:4px; width:25px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Numeric	      value="true">
									<!-- <param name=Enable			  value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:22px;top:0px;">Kg</span>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">혈액형</td>
						<td class="tab21" width="130px;">
							<comment id="__NSID__"><object id=gcem_blood classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:8px;top:4px; width:20px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Format	      value="AA">
									<!-- <param name=Enable			  value="false"> -->
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:10px;top:-2px;">형</span>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">시력</td>
						<td class="tab22" width="238px;">
							<span style="position:relative;left:8px;top:-1px;">좌</span>
							<comment id="__NSID__"><object id=gcem_eyel classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:12px;top:5px; width:25px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment				value=0>
									<param name=Border					value=false>
									<param name=PromptChar			value="_">
									<param name=MaxLength       value=2>
                  <param name=MaxDecimalPlace value=1>
									<!-- <param name=Enable					value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
							<span style="position:relative;left:16px;top:-1px;">우</span>
							<comment id="__NSID__"><object id=gcem_eyer classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative; left:21px;top:5px; width:25px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
									<param name=Alignment				value=0>
									<param name=Border					value=false>
									<param name=PromptChar			value="_">
									<param name=MaxLength       value=2>
                  <param name=MaxDecimalPlace value=1>
									<!-- <param name=Enable					value="false"> -->
					    </object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab11" width="75px" bgcolor="#eeeeee">색맹</td>
						<td class="tab21" width="150px;">
	 						<comment id="__NSID__"><object id=gclx_colblnyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
									<param name=ComboDataID			value="gcds_colblnyn">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
									<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">재검유무</td>
						<td class="tab21" width="100px;">
							<comment id="__NSID__"><object id=gcra_hosrevit classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:20;width:90;cursor:hand;">
									<param name=Cols     value="2">
						      <param name=Format   value="1^Y,2^N">
									<!-- <param name=Enable	 value="false"> -->
			        </object>
						</td>
						<td class="tab11" width="75px" bgcolor="#eeeeee">장애구분</td>
						<td class="tab22" width="220px;">
	 						<comment id="__NSID__"><object id=gclx_disdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:115px;height:200px;">
									<param name=ComboDataID			value="gcds_disdiv">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
									<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
	 						<comment id="__NSID__"><object id=gclx_disgrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:80px;height:200px;">
									<param name=ComboDataID			value="gcds_disgrd">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
									<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  <table style="position:relative;top:5px;border:1 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
		<tr>
			<td width="100px;">&nbsp;<b>병무사항</b></td>
			<td height="25px" align="right" valign="bottom">&nbsp;</td>
			<td width="4px;"></td>
		</tr> 
		<tr>
		  <td style="border:0 solid #708090;border-top-width:1px" colspan="3">
				<table border="0" cellpadding=0 cellspacing=0>
					<tr>
						<td class="tab11" width="80px" bgcolor="#eeeeee">구분</td>
            <td class="tab21" width="170px">
	 						<comment id="__NSID__"><object id=gclx_milidiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value="gcds_milidiv">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
								<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="90px" bgcolor="#eeeeee">면제사유</td>
            <td class="tab21" width="280px"><INPUT type="text" id=txt_nmreason class="txt11" style="position:relative;top:2px;width:170px;border:0" ></td>
						<td class="tab11" width="80px" bgcolor="#eeeeee">제대</td>
						<td class="tab22" width="170px">
	 						<comment id="__NSID__"><object id=gclx_militgbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
									<param name=ComboDataID			value="gcds_militgbn">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
									<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
          </tr>
					<tr>
						<td class="tab11" bgcolor="#eeeeee">계급</td>
            <td class="tab21">
	 						<comment id="__NSID__"><object id=gclx_miligrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value="gcds_miligrd">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
								<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" bgcolor="#eeeeee">복무기간</td>
            <td class="tab21" >
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="75px;" height="25px">&nbsp;
										<comment id="__NSID__"><object id=gcem_milifrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative; left:1px;top:5px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<!-- <param name=Enable			  value="false"> -->
												<param name=PromptChar	  value="_">
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td align=center>&nbsp;~&nbsp;</td>
									<td>
										<comment id="__NSID__"><object id=gcem_militodt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative; left:1px;top:5px; width:70px; height:15px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="YYYY/MM/DD">
												<!-- <param name=Enable			  value="false"> -->
												<param name=PromptChar	  value="_">
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
							</table>
						</td>
						<td class="tab11" bgcolor="#eeeeee">역종</td>
						<td class="tab22" >
	 						<comment id="__NSID__"><object id=gclx_militype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value="gcds_militype">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
								<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td class="tab11" width="80px" bgcolor="#eeeeee">군별</td>
            <td class="tab21" width="100px">
	 						<comment id="__NSID__"><object id=gclx_milispec classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value="gcds_milispec">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
								<!-- <param name=Enable					value="false"> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="90px" bgcolor="#eeeeee">동원유무</td>
            <td class="tab22" width="430px" colspan="3">
							<comment id="__NSID__"><object id=gcra_miligbn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:20;width:350;cursor:hand;">
									<param name=Cols     value="3">
						      <param name=Format   value="1^동원 대상자,2^민방위 대상자,3^비 대상자">
									<!-- <param name=Enable	 value="false"> -->
			        </object></comment><script>__ws__(__NSID__);</script>
						</td>
          </tr>
				</table>
			</td>
		</tr>
	</table></div>

<!---------[TAB 7] 인사발령+상벌 그리드----------->
<div id="layer7" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
		  <td style="width:875;">
				<comment id="__NSID__"><OBJECT id=gcgd_disp07 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299">
            <param name=dataid					value=gcds_data07>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
							<F> Name=발령일자 ID=ORDDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=130,	align=center, MASK="XXXX/XX/XX"</F> 
						 	<C> Name=발령구분 ID=ORDCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=150, EditStyle=Lookup, Data="gcds_ordcd:ordcd:ordnm" </C> 
							<C> Name=소속			ID=DEPTCD HeadAlign=Center HeadBgColor=#B9D4DC Width=246, EditStyle=Lookup, Data="gcds_dept:deptcd:deptnm" show=false </C>
							<C> Name=소속			ID=DEPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=140 </C> 
							<C> Name=직위			ID=PAYGRD HeadAlign=Center HeadBgColor=#B9D4DC Width=153, EditStyle=Lookup, Data="gcds_deptlvl:minorcd:minornm"</C>
							<C> Name=호봉			ID=PAYSEQ HeadAlign=Center HeadBgColor=#B9D4DC Width=150, EditStyle=Lookup, Data="gcds_payseq:minorcd:minornm" </C>
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
<!--
							<C> Name=직급			ID= HeadAlign=Center HeadBgColor=#B9D4DC Width=70 </C>
					    <C> Name=발령사항 ID= HeadAlign=Center HeadBgColor=#B9D4DC Width=170 </C>
							
-->
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt7 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 8] 어학+전산----------->
<div id="layer8" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
			<td colspan="3">
				<table border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>
							<table border="0" cellpadding=0 cellspacing=0  border=0>
								<tr>
									<td class="tab11" width="100px" bgcolor="#eeeeee">제 1 외국어</td>
									<td class="tab11" width="100px" bgcolor="#eeeeee">토익</td>
									<td class="tab21" width="150px;">
										<comment id="__NSID__"><object id=gcem_toescr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<!-- <param name=Enable			  value="false"> -->
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="100px" bgcolor="#eeeeee">토플</td>
									<td class="tab22" width="421px;">
										<comment id="__NSID__"><object id=gcem_tofscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<!-- <param name=Enable			  value="false"> -->
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td class="tab11" bgcolor="#eeeeee">제 2 외국어</td>
									<td class="tab11" bgcolor="#eeeeee">JPT</td>
									<td class="tab21">
										<comment id="__NSID__"><object id=gcem_jptscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<!-- <param name=Enable			  value="false"> -->
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" bgcolor="#eeeeee">HSK</td>
									<td class="tab22">
										<comment id="__NSID__"><object id=gcem_hskscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Numeric	      value=true>
												<!-- <param name=Enable			  value="false"> -->
								    </object></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>	
									<td class="tab11" bgcolor="#eeeeee">기타 외국어</td>
									<td class="tab22" colspan=4><input id="txt_etclng" name="txt_etclng" type="text" class="txt11" style="position:relative;top:2px;width:580px;border:0" ></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  <table  cellpadding=0 cellspacing=0 border=0 style="position:relative;top:5px;border:1 solid #708090;border-bottom-width:0px;">
		<tr>
			<td>
				<table border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>
							<table cellpadding=0 cellspacing=0  border=0>
								<tr>
									<td class="tab11" width="100px;" bgcolor="#eeeeee">한글</td>
									<td class="tab21" width="120px;">
			   						<comment id="__NSID__"><object id=gclx_hwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^상,2^중,3^하">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
												<!-- <param name=Enable					value="false"> -->
			  						</object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="100px;" bgcolor="#eeeeee">엑셀</td>
									<td class="tab21" width="120px;">
			   						<comment id="__NSID__"><object id=gclx_exgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			  								<param name=CBData					value="1^상,2^중,3^하">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
												<!-- <param name=Enable					value="false"> -->
			   						</object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="100px;" bgcolor="#eeeeee">파워포인트</td>
									<td class="tab21" width="120px;">
			   						<comment id="__NSID__"><object id=gclx_pwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^상,2^중,3^하">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
												<!-- <param name=Enable					value="false"> -->
			   						</object></comment><script>__ws__(__NSID__);</script>
									</td>
									<td class="tab11" width="100px;" bgcolor="#eeeeee">엑세스</td>
									<td class="tab22" width="108px;">
			  						<comment id="__NSID__"><object id=gclx_acgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
			   							style="position:relative;left:8px;top:0px;font-size:12px;width:70px;height:200px;">
			   								<param name=CBData					value="1^상,2^중,3^하">
			   								<param name=CBDataColumns		value="Code, Parm">
			  								<param name=SearchColumn		value="Parm">
			  								<param name=Sort						value="false">
			  								<param name=ListExprFormat	value="Parm^0^80">
			  								<param name=BindColumn			value="Code">
												<!-- <param name=Enable					value="false"> -->
			   						</object></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr><td class="tab22" height="153px;">&nbsp;</td></tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 9] 사내시험+인사고과----------->
<div id="layer9" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
		  <td style="width:697;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp09 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:697;height:240">
            <param name=dataid					value=gcds_data09>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value="
							<F> Name=NO ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right  </F> 
							<C> Name=고과년월 ID=EVAYM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 Mask='XXXX/XX', align=center </C> 
							<C> Name=소속			ID=DEPTNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=230,  </C> 
						 	<C> Name=소속			ID=DEPTCD  HeadAlign=Center HeadBgColor=#B9D4DC Width=250, EditStyle=lookup, Data='gcds_dept:deptcd:deptnm'  show=false</C> 
							<C> Name=직위			ID=PAYGRD HeadAlign=Center HeadBgColor=#B9D4DC Width=80, EditStyle=lookup, Data='gcds_deptlvl:minorcd:minornm' </C>
							<C> Name=점수			ID=TOTAVG HeadAlign=Center HeadBgColor=#B9D4DC Width=80, align=right, show=false</C> 							
							<C> Name=고과등급		ID=GRADE3 HeadAlign=Center HeadBgColor=#B9D4DC Width=160 ,align=center</C>
						">
 <!-- 1/20일 고과 안보이게 막음, 각 ID=AVG1 , ID=AVG2, ID=AVG3,  ID=GOGAGB //	<C> Name='1차'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=65, align=center, </C> 
 7/22일 고과판정이 보이게 바꿨음.
									<C> Name='2차'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=65, align=center, </C> 
									<C> Name='3차'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=65, align=center, </C>  
<C> Name='판정'  ID=GRADE  HeadAlign=Center HeadBgColor=#B9D4DC Width=65, align=center,</C>
									-->
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt9 style="position:relative;top:4px;"></font>
				</fieldset>

				<!-- <C> Name=소속			ID=DEPTNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=250,  </C>  -->
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 10] 교육사항----------->
<div id="layer10" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
		  <td style="width:875;">
				<comment id="__NSID__"><OBJECT id=gcgd_disp10 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299">
            <param name=dataid					value=gcds_data10>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO					ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,  align=right </F> 
							<C> Name=시작일			ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=center, MASK="XXXX/XX/XX"</C>
							<C> Name=종료일			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=center, MASK="XXXX/XX/XX"</C>
							<C> Name=교육일수,	ID=EDUDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=100,	align=right </C>
							<F> Name=교육과정		ID=SUBJECT	HeadAlign=Center HeadBgColor=#B9D4DC Width=200,	align=left</F> 
						 	<C> Name=교육기관		ID=EDUINST	HeadAlign=Center HeadBgColor=#B9D4DC Width=149,	align=left </C> 
							<C> Name=교육장소		ID=EDUPLC		HeadAlign=Center HeadBgColor=#B9D4DC Width=180, align=left </C> 
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt10 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>

<!---------[TAB 11] 상벌관리 ----------->
<div id="layer11" style="position:absolute; top:330px; left:175px; width:780px; visibility:hidden; border:0 solid #708090;border-top-width:1px;">
  <table cellpadding=0 cellspacing=0 border=0 style="border:0 solid #708090;border-left-width:1px;border-right-width:1px">
		<tr>
		  <td style="width:875;" colspan="2">
				<comment id="__NSID__"><OBJECT id=gcgd_disp11 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
					style="width:875;height:299">
            <param name=dataid					value=gcds_data11>
						<param Name=BorderStyle			value=0> 
						<param name=indwidth        value=0>
						<param name=Editable				value=0>
						<param name=fillarea        value=true>
						<param name=headlinecolor   value=#999999>
						<param name=format          value='
							<F> Name=NO					ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=50,  align=right </F> 
							<C> Name=수여일자		ID=RECDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=120,	align=center, MASK="XXXX/XX/XX"</C>
							<C> Name=상벌구분		ID=REWGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=250,	align=left, editstyle="Lookup" data="gcds_rewgbn:minorcd:minornm"</C>
							<C> Name=상벌종류,	ID=REWKIND	HeadAlign=Center HeadBgColor=#B9D4DC Width=439,	align=left, editstyle="Lookup" data="gcds_rewkin:minorcd:minornm" </C>
						'>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875;height:20px;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt11 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>


<!-- 데이타바인드 정의부분 -->    <!--	-->


<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data00">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=EMPNMK			Ctrl=txt_empnmk		Param=Value</C>
		<C>Col=NMC				Ctrl=txt_empnmc		Param=Value</C>
		<C>Col=NME				Ctrl=txt_empnme		Param=Value</C>
		<C>Col=EMPNO			Ctrl=txt_empno		Param=Value</C>
		<C>Col=RESINO			Ctrl=gcem_resino	Param=Text</C>
		<C>Col=BIRDT			Ctrl=gcem_birdt		Param=Text</C>
		<C>Col=GLDIV			Ctrl=gcra_gldiv		Param=CodeValue</C>
		<C>Col=DEPTNM			Ctrl=gclx_deptcd	Param=value</C>
		<C>Col=PAYGNM			Ctrl=gclx_deptlvl	Param=value</C>
		<C>Col=GRDDIV			Ctrl=gclx_grddiv	Param=BindColVal</C>
		<C>Col=JOBGRPHNM	Ctrl=gclx_jobgrph	Param=Value</C>
		<C>Col=OZIPCD			Ctrl=gcem_ozipcd	Param=Text</C>
		<C>Col=CZIPCD			Ctrl=gcem_czipcd	Param=Text</C>
		<C>Col=OADDRNM		Ctrl=txt_oaddr01	Param=Value</C>
		<C>Col=CADDRNM		Ctrl=txt_caddr01	Param=Value</C>
		<C>Col=TELNO			Ctrl=txt_telno		Param=Value</C>
		<C>Col=HPNO				Ctrl=txt_hpno			Param=Value</C>
		<C>Col=OFFTELNO		Ctrl=txt_offtelno	Param=Value</C>
		<C>Col=EMAIL			Ctrl=txt_email		Param=Value</C>

		<C>Col=DPOFFDT		Ctrl=gcem_dpoffdt 	Param=Text</C>
		<C>Col=GRSTRTDT		Ctrl=gcem_grstrtdt	Param=Text</C>
		<C>Col=STRTDT			Ctrl=gcem_strtdt		Param=Text</C>
		<C>Col=HITCHYN		Ctrl=gcra_hitchyn		Param=CodeValue</C>

		<C>Col=HDFAMNM 		Ctrl=txt_hdfamnm  		Param=Value</C>
		<C>Col=HDFAMRET		Ctrl=gclx_hdfamret 		Param=BindColVal</C>
		<C>Col=HDFAMJOB		Ctrl=txt_hdfamjob 		Param=Value</C>
		<C>Col=EDCCD   		Ctrl=gclx_edccd   		Param=BindColVal</C>
		<C>Col=EMPDIVNM		Ctrl=gclx_empdiv  		Param=Value</C>
		<C>Col=HOUSDIV 		Ctrl=gclx_housdiv 		Param=Value</C>
		<C>Col=HOBBY   		Ctrl=txt_hobby    		Param=Value</C>
		<C>Col=SPECIAL 		Ctrl=txt_special  		Param=Value</C>
		<C>Col=RILIGNM 		Ctrl=gclx_rilign  		Param=Value</C>
		<C>Col=MRYDT   		Ctrl=gcem_mrydt   		Param=Text</C>
		<C>Col=INSCOD			Ctrl=gcem_inscod 			Param=Text</C>
		<C>Col=PENCOD			Ctrl=gcem_pencod 			Param=Text</C>
		<C>Col=LABUNIYN		Ctrl=gcra_labuniyn		Param=codevalue</C>
		<C>Col=MRTDIVNM		Ctrl=gclx_mrtdiv  		Param=Value</C>
		<C>Col=PAYBNKCDNM	Ctrl=gclx_paybnkcd		Param=Value</C>
		<C>Col=PAYACNT 		Ctrl=gcem_payacnt  		Param=Text</C>

		<C>Col=ENGLVL			Ctrl=gclx_englvl			Param=BindColVal</C>
		<C>Col=TOESCR 		Ctrl=gcem_toescr  		Param=Text</C>
		<C>Col=JPTSCR 		Ctrl=gcem_jptscr  		Param=Text</C>
		<C>Col=DELFSCR 		Ctrl=gcem_delfscr  		Param=Text</C>
		<C>Col=TOFSCR 		Ctrl=gcem_tofscr  		Param=Text</C>
		<C>Col=DALFSCR 		Ctrl=gcem_dalfscr  		Param=Text</C>
		<C>Col=TEPSSCR 		Ctrl=gcem_tepsscr  		Param=Text</C>
		<C>Col=ETCLNG 		Ctrl=txt_etclng  			Param=Value</C>

		<C>Col=HWGRDCD 		Ctrl=gclx_hwgrdcd			Param=BindColVal</C>
		<C>Col=EXGRDCD 		Ctrl=gclx_exgrdcd			Param=BindColVal</C>
		<C>Col=PWGRDCD 		Ctrl=gclx_pwgrdcd			Param=BindColVal</C>
		<C>Col=ACGRDCD 		Ctrl=gclx_acgrdcd			Param=BindColVal</C>
		<C>Col=PICFILE 		Ctrl=txt_file		  		Param=Value</C>

		<C>Col=LAMDT 			Ctrl=gcem_lamdt  			Param=Text</C>
		<C>Col=RELATNM 		Ctrl=txt_relatnm  		Param=Value</C>
		<C>Col=RELATGRD		Ctrl=gclx_relatgrd  	Param=BindColVal</C>
		<C>Col=RELATRE 		Ctrl=gclx_relatre  		Param=BindColVal</C>
		<C>Col=NOMINNM 		Ctrl=txt_nominnm	 		Param=Value</C>
		<C>Col=NOMINGRD		Ctrl=gclx_nomingrd  	Param=BindColVal</C>
		<C>Col=NOMINRE		Ctrl=gclx_nominre  		Param=BindColVal</C>
		<C>Col=JOBKINDNM	Ctrl=gclx_jobkind			Param=Value</C>
		<C>Col=RECDIVNM		Ctrl=gclx_recdiv			Param=Value</C>
		<C>Col=PAYSEQ 		Ctrl=txt_payseq		 		Param=Value</C>
		<C>Col=TRAINYN		Ctrl=gcra_trainyn  		Param=Codevalue</C>
		<C>Col=SEX				Ctrl=gclx_sex  				Param=Value</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcbn_data052 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_data052">
	<PARAM NAME="BindInfo"	VALUE="
		<C>Col=MILIDIV 		Ctrl=gclx_milidiv			Param=BindColVal</C>
		<C>Col=NMREASON 	Ctrl=txt_nmreason			Param=Value</C>
		<C>Col=MILITGBN		Ctrl=gclx_militgbn		Param=BindColVal</C>
		<C>Col=MILIGRD		Ctrl=gclx_miligrd			Param=BindColVal</C>
		<C>Col=MILIFRDT		Ctrl=gcem_milifrdt		Param=Text</C>
		<C>Col=MILITODT		Ctrl=gcem_militodt		Param=Text</C>
		<C>Col=MILITYPE		Ctrl=gclx_militype		Param=BindColVal</C>
		<C>Col=MILIKND		Ctrl=gclx_milispec		Param=BindColVal</C>
		<C>Col=MILINO			Ctrl=gcem_milino			Param=Text</C>
		<C>Col=MILIGBN		Ctrl=gcra_miligbn			Param=Codevalue</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcbn_data06 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_data06">
	<PARAM NAME="BindInfo"	VALUE="
		<C>Col=ASSGB 			Ctrl=gclx_assgb			Param=BindColVal</C>
		<C>Col=AFRDT 			Ctrl=gcem_afrdt			Param=Text</C>
		<C>Col=ATODT 			Ctrl=gcem_atodt			Param=Text</C>
		<C>Col=ASSAMT			Ctrl=gcem_assamt		Param=Text</C>
		<C>Col=ASSINST		Ctrl=txt_assinst		Param=Value</C>
		<C>Col=ASSNO 			Ctrl=gcem_assno			Param=Text</C>
		<C>Col=ASSNAME 		Ctrl=txt_assname		Param=Value</C>
		<C>Col=ASSRELA		Ctrl=gclx_assrela		Param=BindColVal</C>
		<C>Col=ASSRESINO	Ctrl=gcem_assresino	Param=Text</C>
		<C>Col=ASSTELNO 	Ctrl=txt_asstelno		Param=Value</C>
		<C>Col=ASSPOSTNO	Ctrl=gcem_assno			Param=Text</C>
		<C>Col=ASSADDR 		Ctrl=txt_assaddr		Param=Value</C>
		<C>Col=RECPAMT		Ctrl=gcem_recpamt		Param=Text</C>
		<C>Col=HOSPITAL		Ctrl=txt_hospital		Param=Value</C>
		<C>Col=HOSDT 			Ctrl=gcem_hosdt			Param=Text</C>
		<C>Col=HOSMEMO		Ctrl=txt_hosmemo		Param=Value</C>
		<C>Col=HEIGHT			Ctrl=gcem_height		Param=Text</C>
		<C>Col=WEIGHT			Ctrl=gcem_weight		Param=Text</C>
		<C>Col=BLOOD 			Ctrl=gcem_blood			Param=Text</C>
		<C>Col=EYEL 			Ctrl=gcem_eyel			Param=Text</C>
		<C>Col=EYER 			Ctrl=gcem_eyer			Param=Text</C>
		<C>Col=COLBLNYN		Ctrl=gclx_colblnyn	Param=BindColVal</C>
		<C>Col=HOSREVIT		Ctrl=gcra_hosrevit	Param=CodeValue</C>
		<C>Col=DISDIV			Ctrl=gclx_disdiv		Param=BindColVal</C>
		<C>Col=DISGRD			Ctrl=gclx_disgrd		Param=BindColVal</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<!--param name="DetailDataID"	value="gcds_report2"-->
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2754 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='지       급       내      역' ,left=545 ,top=849 ,right=1455 ,bottom=905 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1442 ,right=1971 ,bottom=1442 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=921 ,right=1971 ,bottom=921 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=833 ,right=1971 ,bottom=833 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=799 ,right=1971 ,bottom=799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=717 ,right=1971 ,bottom=717 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=1212 ,right=1969 ,bottom=1212 </L>
	<L> left=32 ,top=1074 ,right=1969 ,bottom=1074 </L>
	<L> left=32 ,top=1005 ,right=1969 ,bottom=1005 </L>
	<L> left=32 ,top=1143 ,right=1969 ,bottom=1143 </L>
	<L> left=32 ,top=1283 ,right=1969 ,bottom=1283 </L>
	<L> left=32 ,top=1357 ,right=1969 ,bottom=1357 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=717 ,right=29 ,bottom=799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=717 ,right=1971 ,bottom=799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='실수령액' ,left=1344 ,top=730 ,right=1519 ,bottom=783 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S93000', left=913, top=730, right=1320, bottom=783, align='right', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공제총액' ,left=701 ,top=730 ,right=889 ,bottom=783 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91000', left=267, top=730, right=672, bottom=783, align='right', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급총액' ,left=53 ,top=730 ,right=233 ,bottom=783 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S94000', left=1537, top=730, right=1945, bottom=783, align='right', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1529 ,top=720 ,right=1529 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=900 ,top=720 ,right=900 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=246 ,top=720 ,right=246 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1331 ,top=720 ,right=1331 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=685 ,top=720 ,right=685 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1971 ,top=833 ,right=1971 ,bottom=1442 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='P11000', left=307, top=1016, right=503, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P12000', left=307, top=1085, right=503, bottom=1140, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P21000', left=307, top=1154, right=503, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P22000', left=307, top=1222, right=503, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P23000', left=307, top=1291, right=503, bottom=1347, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P10000', left=307, top=942, right=503, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P24000', left=307, top=1365, right=503, bottom=1421, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='차랑유지비' ,left=58 ,top=1365 ,right=278 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=58 ,top=942 ,right=278 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=58 ,top=1222 ,right=278 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=58 ,top=1154 ,right=278 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=58 ,top=1016 ,right=278 ,bottom=1072 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=58 ,top=1085 ,right=278 ,bottom=1140 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1749, top=1365, right=1945, bottom=1421, align='right'</C>
	<T>id='휴일수당' ,left=1495 ,top=942 ,right=1728 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PX0010', left=1749, top=942, right=1945, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1749, top=1291, right=1945, bottom=1347, align='right'</C>
	<C>id='', left=1749, top=1222, right=1945, bottom=1278, align='right'</C>
	<C>id='PX0040', left=1749, top=1154, right=1945, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PX0030', left=1749, top=1085, right=1945, bottom=1140, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PX0020', left=1749, top=1016, right=1945, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR0020', left=1495, top=1016, right=1733, bottom=1072, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P37000', left=783, top=1016, right=979, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='개인연금보조' ,left=534 ,top=1016 ,right=754 ,bottom=1072 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납수당' ,left=534 ,top=1154 ,right=754 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=534 ,top=1222 ,right=754 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P27000', left=783, top=1291, right=979, bottom=1347, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P26000', left=783, top=1222, right=979, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P25000', left=783, top=1154, right=979, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P32000', left=783, top=1085, right=979, bottom=1140, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P28000', left=783, top=1365, right=979, bottom=1421, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='자격수당' ,left=534 ,top=1365 ,right=754 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P29000', left=783, top=942, right=979, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='남북경협수당' ,left=534 ,top=942 ,right=754 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=995 ,top=921 ,right=995 ,bottom=1437 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1003 ,top=921 ,right=1003 ,bottom=1437 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1474 ,top=926 ,right=1474 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1738 ,top=926 ,right=1738 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=926 ,right=291 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=926 ,right=516 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=770 ,top=926 ,right=770 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1249 ,top=926 ,right=1249 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='지역근무수당' ,left=534 ,top=1085 ,right=754 ,bottom=1140 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=1019 ,top=1294 ,right=1238 ,bottom=1349 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P39000', left=1265, top=1294, right=1463, bottom=1349, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P38000', left=1265, top=1217, right=1463, bottom=1273, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P36000', left=1265, top=1148, right=1463, bottom=1204, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P34000', left=1265, top=1077, right=1463, bottom=1135, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P31000', left=1265, top=1008, right=1463, bottom=1066, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P30000', left=1265, top=942, right=1463, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='특수지수당' ,left=1019 ,top=1008 ,right=1238 ,bottom=1066 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장단수당' ,left=1019 ,top=942 ,right=1238 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대보조' ,left=1019 ,top=1365 ,right=1238 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P35000', left=1265, top=1365, right=1463, bottom=1421, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR0030', left=1495, top=1085, right=1733, bottom=1140, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR0040', left=1495, top=1154, right=1733, bottom=1209, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='' ,left=1495 ,top=1222 ,right=1730 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1495 ,top=1291 ,right=1730 ,bottom=1347 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1495 ,top=1365 ,right=1730 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=833 ,right=29 ,bottom=1442 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1474 ,right=1971 ,bottom=1474 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1553 ,right=1971 ,bottom=1553 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=1775 ,right=1969 ,bottom=1775 </L>
	<L> left=32 ,top=1635 ,right=1969 ,bottom=1635 </L>
	<L> left=32 ,top=1707 ,right=1969 ,bottom=1707 </L>
	<C>id='T12000', left=307, top=1646, right=503, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='T11000', left=307, top=1572, right=503, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='갑근세' ,left=58 ,top=1572 ,right=278 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BX0010', left=1749, top=1572, right=1945, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0040', left=1749, top=1783, right=1945, bottom=1836, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0030', left=1749, top=1717, right=1945, bottom=1770, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0020', left=1749, top=1646, right=1945, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='B14000', left=1265, top=1646, right=1463, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='여직원회비' ,left=1019 ,top=1646 ,right=1238 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=1019 ,top=1572 ,right=1238 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B16000', left=1265, top=1572, right=1463, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='고용보험' ,left=534 ,top=1717 ,right=754 ,bottom=1770 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B13000', left=783, top=1717, right=979, bottom=1770, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='개인연금' ,left=534 ,top=1783 ,right=754 ,bottom=1836 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B15000', left=783, top=1783, right=979, bottom=1836, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='B11000', left=783, top=1572, right=979, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='건강보험' ,left=534 ,top=1572 ,right=754 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B12000', left=783, top=1646, right=979, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국민연금' ,left=534 ,top=1646 ,right=754 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보증보험' ,left=1495 ,top=1572 ,right=1730 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BR0020', left=1495, top=1646, right=1733, bottom=1701, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BR0030', left=1495, top=1717, right=1733, bottom=1770, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BR0040', left=1495, top=1783, right=1733, bottom=1836, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=291 ,top=1556 ,right=291 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1741 ,top=1556 ,right=1741 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1474 ,top=1556 ,right=1474 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1249 ,top=1556 ,right=1249 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1003 ,top=1556 ,right=1003 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=995 ,top=1556 ,right=995 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=770 ,top=1556 ,right=770 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=1556 ,right=516 ,bottom=1852 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=1855 ,right=1971 ,bottom=1855 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1479 ,right=29 ,bottom=1855 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=1479 ,right=1971 ,bottom=1855 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1982 ,right=1971 ,bottom=1982 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1892 ,right=1971 ,bottom=1892 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=2236 ,right=1969 ,bottom=2236 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=32 ,top=2154 ,right=1969 ,bottom=2154 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='당월불입액' ,left=1019 ,top=2000 ,right=1238 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계액' ,left=1257 ,top=2000 ,right=1474 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계횟수' ,left=778 ,top=2000 ,right=997 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=294 ,top=2000 ,right=513 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총불일기간' ,left=534 ,top=2000 ,right=754 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='저축종류' ,left=58 ,top=2000 ,right=278 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1487 ,top=1892 ,right=1487 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1479 ,top=1894 ,right=1479 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=1984 ,right=291 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1249 ,top=1984 ,right=1249 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1003 ,top=1984 ,right=1003 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=1984 ,right=516 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=770 ,top=1984 ,right=770 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=1892 ,right=29 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=1892 ,right=1971 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2326 ,right=1971 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='INSURNM1', left=307, top=2085, right=503, bottom=2140, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INSURNM2', left=307, top=2167, right=503, bottom=2223, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INSURNM3', left=307, top=2246, right=503, bottom=2302, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DIVNM1', left=77, top=2085, right=275, bottom=2140, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DIVNM2', left=77, top=2167, right=275, bottom=2223, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DIVNM3', left=77, top=2246, right=275, bottom=2302, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTCNT1', left=788, top=2085, right=984, bottom=2140, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTCNT2', left=788, top=2167, right=984, bottom=2223, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTCNT3', left=788, top=2246, right=984, bottom=2302, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTDAY2', left=524, top=2167, right=757, bottom=2223, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTDAY3', left=524, top=2246, right=757, bottom=2302, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERAMT3', left=1040, top=2246, right=1238, bottom=2302, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERAMT2', left=1040, top=2167, right=1238, bottom=2223, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERAMT1', left=1040, top=2085, right=1238, bottom=2140, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTAMT3', left=1270, top=2246, right=1466, bottom=2302, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTAMT2', left=1270, top=2167, right=1466, bottom=2223, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTAMT1', left=1270, top=2085, right=1466, bottom=2140, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTDAY1', left=524, top=2085, right=757, bottom=2140, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1746 ,top=1984 ,right=1746 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2625 ,right=1971 ,bottom=2625 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='누    계     내     역' ,left=48 ,top=2379 ,right=995 ,bottom=2434 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2532 ,right=1971 ,bottom=2532 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2447 ,right=1971 ,bottom=2447 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2360 ,right=1971 ,bottom=2360 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=2360 ,right=1971 ,bottom=2619 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='3669-3682, 3669-3915' ,left=1005 ,top=2463 ,right=1958 ,bottom=2519 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여/상여 문의 및 주소 변경' ,left=1005 ,top=2379 ,right=1958 ,bottom=2434 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세누계' ,left=534 ,top=2466 ,right=754 ,bottom=2521 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세누계' ,left=294 ,top=2466 ,right=513 ,bottom=2521 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득누계' ,left=56 ,top=2466 ,right=275 ,bottom=2521 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=770 ,top=2453 ,right=770 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=2453 ,right=516 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=2453 ,right=291 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1000 ,top=2363 ,right=1000 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='TT1200', left=558, top=2551, right=754, bottom=2604, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TS9100', left=77, top=2551, right=273, bottom=2604, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TT1100', left=307, top=2551, right=503, bottom=2604, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=2360 ,right=29 ,bottom=2619 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='저    축    내    역' ,left=556 ,top=1910 ,right=1103 ,bottom=1963 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회    사    대    출' ,left=1495 ,top=1910 ,right=1963 ,bottom=1963 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공       제       내       역' ,left=574 ,top=1487 ,right=1426 ,bottom=1540 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연차수당' ,left=1019 ,top=1085 ,right=1238 ,bottom=1140 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학비보조금' ,left=1019 ,top=1154 ,right=1238 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임원직책수당' ,left=1019 ,top=1222 ,right=1238 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연장수당' ,left=534 ,top=1294 ,right=754 ,bottom=1349 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=58 ,top=1294 ,right=278 ,bottom=1349 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=58 ,top=1651 ,right=278 ,bottom=1704 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYSEQNM', left=1352, top=376, right=1688, bottom=431, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=1352, top=304, right=1688, bottom=360, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SANGNAME', left=1064, top=445, right=1341, bottom=500, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='급       호 :' ,left=1064 ,top=376 ,right=1341 ,bottom=431 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직       위 :' ,left=1064 ,top=304 ,right=1341 ,bottom=360 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성       명 :' ,left=1064 ,top=230 ,right=1341 ,bottom=286 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYDT', left=1529, top=138, right=1969, bottom=193, align='right' ,mask='지급일:XXXX-XX-XX', face='굴림', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀하의 노고에 감사 드립니다.' ,left=482 ,top=532 ,right=1516 ,bottom=622 ,align='left' ,face='궁서' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SANGRAT', left=1352, top=445, right=1688, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1971 ,top=206 ,right=1971 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=206 ,right=29 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=204 ,right=1971 ,bottom=204 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=331, top=230, right=667, bottom=286, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=1352, top=230, right=1688, bottom=286, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=669 ,right=1971 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사       번 :' ,left=58 ,top=230 ,right=325 ,bottom=286 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소       속 :' ,left=58 ,top=304 ,right=325 ,bottom=357 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부양코드  :' ,left=56 ,top=373 ,right=323 ,bottom=429 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=331, top=304, right=667, bottom=357, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BAEBUSU', left=331, top=373, right=667, bottom=429, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYBNKNM', left=331, top=445, right=534, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계좌번호  :' ,left=56 ,top=445 ,right=323 ,bottom=500 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYNUM', left=564, top=445, right=968, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='/' ,left=534 ,top=445 ,right=564 ,bottom=500 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=749 ,top=2651 ,right=1228 ,bottom=2749</I>
	<C>id='CTITLE', left=497, top=34, right=1503, bottom=122 ,mask='XXXX 년 XX 월 XX 명세서', face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT', left=1757, top=2000, right=1953, bottom=2053, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='대출상환원금' ,left=1498 ,top=2000 ,right=1741 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출상환이자' ,left=1498 ,top=2085 ,right=1741 ,bottom=2140 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출상환회수' ,left=1498 ,top=2167 ,right=1741 ,bottom=2223 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출잔액' ,left=1498 ,top=2246 ,right=1741 ,bottom=2302 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='APLRAT', left=1757, top=2085, right=1953, bottom=2138, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPCNT', left=1757, top=2167, right=1953, bottom=2220, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APJAMT', left=1757, top=2246, right=1953, bottom=2299, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=2066 ,right=1474 ,bottom=2066 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1482 ,top=2066 ,right=1966 ,bottom=2066 </L>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

</BODY>
</HTML>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>