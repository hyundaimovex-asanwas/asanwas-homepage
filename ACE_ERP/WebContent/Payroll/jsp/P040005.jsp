<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/퇴직금내역조회
+ 프로그램 ID	: p010005.HTML
+ 기 능 정 의	: 조회|출력
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.03 - 소스 정리
+ 서 블 릿 명	: p040005_s1
------------------------------------------------------------------------------>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>퇴직금내역조회</title>


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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	window.status="";
	var mon = [31,28,31,30,31,30,31,31,30,31,30,31];
	var y, m;
	today=new Date();
	y=today.getFullYear();
	m=today.getMonth();

	var today;
	day = new Date(y,m,1);	
	year = y;
	// 윤년이면 2월 날수를 29로...
	if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
		mon[1] = 29;
	else
		mon[1] = 28;
	gcem_jigub11.Text=gs_date.substr(0,6)+"01";
  gcem_jigub12.Text=gs_date.substr(0,6)+mon[m];

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	var str1 = fn_trim(gcem_jigub11.Text);
	var str2 = fn_trim(gcem_jigub12.Text);
	var str3 = fn_trim(txt_empnm_search.value);

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040005_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3;
	gcds_data.Reset(); 
	gcds_data.rowposition=1;

}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvyyyy(yyyy,mm) {

	if(parseInt(mm)==1)	{
    returnPrv=(parseInt(yyyy)-1)+"";
	}
	else returnPrv=yyyy;

	return returnPrv;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvmm(prv) {

	var returnPrv="";
	if(prv.substr(0,1)=="0") prv=prv.substr(1,1);
	if(parseInt(prv)==1) returnPrv="12";
	else returnPrv=(parseInt(prv)-1)+"";
	if(returnPrv.length ==1)	returnPrv="0" + returnPrv ;

	return returnPrv;

}

/******************************************************************************
	Description : 
******************************************************************************/
function yyyymmPlusMinus(str2){
	if( str2.length ==6) {
	 str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str2.substr(4,2));
	 str2_2=ln_prvyyyy(str2_1.substr(0,4),str2_1.substr(4,2)) +""+ ln_prvmm(str2_1.substr(4,2));
	 str2_3=ln_prvyyyy(str2_2.substr(0,4),str2_2.substr(4,2)) +""+ ln_prvmm(str2_2.substr(4,2));
	}
}

/******************************************************************************
	Description : 출력 - "퇴사통보"
******************************************************************************/
function ln_Print(){
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

	gcds_report0.ClearData();
	var str2=gcds_data.namevalue(gcds_data.rowposition,"APPDT");
			yyyymmPlusMinus(str2);

var ls_temp="CTITLE:STRING,APPDT:STRING,EMPNO:STRING,EMPDIV:STRING,EMPNMK:STRING,DEPTNM:STRING,PAYGRDNM:STRING,STRTDT:STRING,";
	ls_temp +="RESINO:STRING,ENDDT:STRING,JDDAY:STRING,DUYEAR:DECIMAL,DUYMM:DECIMAL,DUDAY:DECIMAL,CADDR:STRING,BASDAY1:DECIMAL,";
	ls_temp +="BASDAY2:DECIMAL,BASDAY3:DECIMAL,BASDAY4:DECIMAL,BASMAX1:DECIMAL,BASMAX2:DECIMAL,BASMAX3:DECIMAL,";
	ls_temp +="BASMAX4:DECIMAL,BASAMT1:DECIMAL,BASAMT2:DECIMAL,BASAMT3:DECIMAL,BASAMT4:DECIMAL,BASBUS1:DECIMAL,";
	ls_temp +="BASBUS2:DECIMAL,BASBUS3:DECIMAL,BASBUS4:DECIMAL,BAEDAY1:DECIMAL,BAEDAY2:DECIMAL,BAEDAY3:DECIMAL,BAEDAY4:DECIMAL,";
	ls_temp +="BAEAMT1:DECIMAL,BAEAMT2:DECIMAL,BAEAMT3:DECIMAL,BAEAMT4:DECIMAL,BASAMT_SUM:DECIMAL,BASBUS_SUM:DECIMAL,BAEAMT_SUM:DECIMAL,";
	ls_temp +="YEAQTY:DECIMAL,YEAPAY:DECIMAL,";
	ls_temp +="AVGYER:DECIMAL,AVGAMT:DECIMAL,AVGBOS:DECIMAL,AVGETC:DECIMAL,AVG_SUM:DECIMAL,P21000:DECIMAL,P22000:DECIMAL,";
	ls_temp +="P24000:DECIMAL,P29000:DECIMAL,P38000:DECIMAL,P27000:DECIMAL,PX0000:DECIMAL,JUSPAY:DECIMAL,JUSRET:DECIMAL,JUSYER:DECIMAL,";
	ls_temp +="JUSBOS:DECIMAL,S91000:DECIMAL,S94000:DECIMAL,T21000:DECIMAL,T22000:DECIMAL,T23000:DECIMAL,T24000:DECIMAL,P43000:DECIMAL,";
	ls_temp +="P41000:DECIMAL,P42000:DECIMAL,RETJUH:DECIMAL,BX0010:DECIMAL,BX0020:DECIMAL,BX0030:DECIMAL,BX0040:DECIMAL,";
	ls_temp +="S93000:DECIMAL,CMM1:STRING,CMM2:STRING,CMM3:STRING,CMM4:STRING,AMTTXT:STRING,";
	ls_temp +="REF1:STRING,REF2:STRING,REF3:STRING,REF4:STRING,REF:STRING";

	gcds_report0.SetDataHeader(ls_temp);

	gcds_report0.Addrow();
	gcds_report0.namevalue(1,"CTITLE")	=	gs_date;
	gcds_report0.namevalue(1,"CMM1")		=	str2.substr(4,2);
	gcds_report0.namevalue(1,"CMM2")		=	str2_1.substr(4,2);
	gcds_report0.namevalue(1,"CMM3")		=	str2_2.substr(4,2);
	gcds_report0.namevalue(1,"CMM4")		=	str2_3.substr(4,2);
	gcds_report0.namevalue(1,"APPDT")		=	gcds_data.namevalue(gcds_data.rowposition,"APPDT");
	gcds_report0.namevalue(1,"EMPNO")		=	gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	gcds_report0.namevalue(1,"EMPDIV")	=	gcds_data.namevalue(gcds_data.rowposition,"EMPDIV");
	gcds_report0.namevalue(1,"EMPNMK")	=	gcds_data.namevalue(gcds_data.rowposition,"EMPNMK");
	gcds_report0.namevalue(1,"DEPTNM")	=	gcds_data.namevalue(gcds_data.rowposition,"DEPTNM");
	gcds_report0.namevalue(1,"PAYGRDNM")=	gcds_data.namevalue(gcds_data.rowposition,"PAYGRDNM");
	gcds_report0.namevalue(1,"STRTDT")	=	gcds_data.namevalue(gcds_data.rowposition,"STRTDT");
	gcds_report0.namevalue(1,"ENDDT")		=	gcds_data.namevalue(gcds_data.rowposition,"ENDDT");

	var strDUYEAR = gcds_data.namevalue(gcds_data.rowposition,"DUYEAR")+"";
	var strDUYMM  = gcds_data.namevalue(gcds_data.rowposition,"DUYMM")+"";
	var strDUDAY  = gcds_data.namevalue(gcds_data.rowposition,"DUDAY")+"";

	gcds_report0.namevalue(1,"DUYEAR") = parseInt(strDUYEAR);
	gcds_report0.namevalue(1,"DUYMM")  = parseInt(strDUYMM);
	gcds_report0.namevalue(1,"DUDAY")  = parseInt(strDUDAY);

	gcds_report0.namevalue(1,"JDDAY")=strDUYEAR+"년 "+strDUYMM+"월";

	var strCA1=gcds_data.namevalue(gcds_data.rowposition,"CADDR01");
	var strCA2=gcds_data.namevalue(gcds_data.rowposition,"CADDR02");

	gcds_report0.namevalue(1,"CADDR")=strCA1+" "+strCA2;
	gcds_report0.namevalue(1,"BASDAY1")=gcds_data.namevalue(gcds_data.rowposition,"BASDAY1");
	gcds_report0.namevalue(1,"BASDAY1")=gcds_data.namevalue(gcds_data.rowposition,"BASDAY1");
	gcds_report0.namevalue(1,"BASDAY2")=gcds_data.namevalue(gcds_data.rowposition,"BASDAY2");
	gcds_report0.namevalue(1,"BASDAY3")=gcds_data.namevalue(gcds_data.rowposition,"BASDAY3");
	gcds_report0.namevalue(1,"BASDAY4")=gcds_data.namevalue(gcds_data.rowposition,"BASDAY4");
	gcds_report0.namevalue(1,"BASMAX1")=gcds_data.namevalue(gcds_data.rowposition,"BASMAX1");
	gcds_report0.namevalue(1,"BASMAX2")=gcds_data.namevalue(gcds_data.rowposition,"BASMAX2");
	gcds_report0.namevalue(1,"BASMAX3")=gcds_data.namevalue(gcds_data.rowposition,"BASMAX3");
	gcds_report0.namevalue(1,"BASMAX4")=gcds_data.namevalue(gcds_data.rowposition,"BASMAX4");
	gcds_report0.namevalue(1,"BASAMT1")=gcds_data.namevalue(gcds_data.rowposition,"BASAMT1");
	gcds_report0.namevalue(1,"BASAMT2")=gcds_data.namevalue(gcds_data.rowposition,"BASAMT2");
	gcds_report0.namevalue(1,"BASAMT3")=gcds_data.namevalue(gcds_data.rowposition,"BASAMT3");
	gcds_report0.namevalue(1,"BASAMT4")=gcds_data.namevalue(gcds_data.rowposition,"BASAMT4");
	gcds_report0.namevalue(1,"BASBUS1")=gcds_data.namevalue(gcds_data.rowposition,"BASBUS1");
	gcds_report0.namevalue(1,"BASBUS2")=gcds_data.namevalue(gcds_data.rowposition,"BASBUS2");
	gcds_report0.namevalue(1,"BASBUS3")=gcds_data.namevalue(gcds_data.rowposition,"BASBUS3");
	gcds_report0.namevalue(1,"BASBUS4")=gcds_data.namevalue(gcds_data.rowposition,"BASBUS4");
	gcds_report0.namevalue(1,"BAEDAY1")=gcds_data.namevalue(gcds_data.rowposition,"BAEDAY1");
	gcds_report0.namevalue(1,"BAEDAY2")=gcds_data.namevalue(gcds_data.rowposition,"BAEDAY2");
	gcds_report0.namevalue(1,"BAEDAY3")=gcds_data.namevalue(gcds_data.rowposition,"BAEDAY3");
	gcds_report0.namevalue(1,"BAEDAY4")=gcds_data.namevalue(gcds_data.rowposition,"BAEDAY4");
	gcds_report0.namevalue(1,"BAEAMT1")=gcds_data.namevalue(gcds_data.rowposition,"BAEAMT1");
	gcds_report0.namevalue(1,"BAEAMT2")=gcds_data.namevalue(gcds_data.rowposition,"BAEAMT2");
	gcds_report0.namevalue(1,"BAEAMT3")=gcds_data.namevalue(gcds_data.rowposition,"BAEAMT3");
	gcds_report0.namevalue(1,"BAEAMT4")=gcds_data.namevalue(gcds_data.rowposition,"BAEAMT4");

	gcds_report0.namevalue(1,"BASAMT_SUM")=gcds_data.namevalue(gcds_data.rowposition,"BASAMT1")
																				+gcds_data.namevalue(gcds_data.rowposition,"BASAMT2")
																				+gcds_data.namevalue(gcds_data.rowposition,"BASAMT3")
																				+gcds_data.namevalue(gcds_data.rowposition,"BASAMT4");

	gcds_report0.namevalue(1,"BASBUS_SUM")=gcds_data.namevalue(gcds_data.rowposition,"BASBUS1")
																				+gcds_data.namevalue(gcds_data.rowposition,"BASBUS2")
																				+gcds_data.namevalue(gcds_data.rowposition,"BASBUS3")
																				+gcds_data.namevalue(gcds_data.rowposition,"BASBUS4");

	gcds_report0.namevalue(1,"BAEAMT_SUM")=gcds_data.namevalue(gcds_data.rowposition,"BAEAMT1")
																				+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT2")
																				+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT3")
																				+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT4")
																				+gcds_data.namevalue(gcds_data.rowposition,"AVGYER");

	gcds_report0.namevalue(1,"YEAQTY")=gcds_data.namevalue(gcds_data.rowposition,"YEAQTY");
	gcds_report0.namevalue(1,"YEAPAY")=gcds_data.namevalue(gcds_data.rowposition,"YEAPAY");

	gcds_report0.namevalue(1,"AVGYER")=gcds_data.namevalue(gcds_data.rowposition,"AVGYER");
	gcds_report0.namevalue(1,"AVGAMT")=gcds_data.namevalue(gcds_data.rowposition,"AVGAMT");
	gcds_report0.namevalue(1,"AVGBOS")=gcds_data.namevalue(gcds_data.rowposition,"AVGBOS");

	var str_baeday1 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY1");
	var str_baeday2 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY2");
	var str_baeday3 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY3");
	var str_baeday4 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY4");
	var str_bdaysum = str_baeday1+str_baeday2+str_baeday3+str_baeday4;
	var str_bamtsum = gcds_data.namevalue(gcds_data.rowposition,"BAEAMT1")
									+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT2")
									+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT3")
									+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT4")
									+gcds_data.namevalue(gcds_data.rowposition,"AVGYER");

	gcds_report0.namevalue(1,"AVGETC")= Math.floor((str_bamtsum/str_bdaysum)*30);
	//gcds_report0.namevalue(1,"AVGETC")= gcds_data.namevalue(gcds_data.rowposition,"AVGETC");

	gcds_report0.namevalue(1,"AVG_SUM")=gcds_data.namevalue(gcds_data.rowposition,"AVGYER")
																		 +gcds_data.namevalue(gcds_data.rowposition,"AVGAMT")
																		 +gcds_data.namevalue(gcds_data.rowposition,"AVGBOS")
																		 +gcds_data.namevalue(gcds_data.rowposition,"AVGETC");

	gcds_report0.namevalue(1,"P21000")=gcds_data.namevalue(gcds_data.rowposition,"P21000");
	gcds_report0.namevalue(1,"P22000")=gcds_data.namevalue(gcds_data.rowposition,"P22000");
	gcds_report0.namevalue(1,"P24000")=gcds_data.namevalue(gcds_data.rowposition,"P24000");
	gcds_report0.namevalue(1,"P29000")=gcds_data.namevalue(gcds_data.rowposition,"P29000");
	gcds_report0.namevalue(1,"P38000")=gcds_data.namevalue(gcds_data.rowposition,"P38000");
	gcds_report0.namevalue(1,"P27000")=gcds_data.namevalue(gcds_data.rowposition,"P27000");
	gcds_report0.namevalue(1,"PX0000")=gcds_data.namevalue(gcds_data.rowposition,"PX0000");
	gcds_report0.namevalue(1,"JUSPAY")=gcds_data.namevalue(gcds_data.rowposition,"JUSPAY");
	gcds_report0.namevalue(1,"JUSRET")=gcds_data.namevalue(gcds_data.rowposition,"JUSRET");
	gcds_report0.namevalue(1,"JUSYER")=gcds_data.namevalue(gcds_data.rowposition,"JUSYER");
	gcds_report0.namevalue(1,"JUSBOS")=gcds_data.namevalue(gcds_data.rowposition,"JUSBOS");
	gcds_report0.namevalue(1,"S91000")=gcds_data.namevalue(gcds_data.rowposition,"S91000");
	gcds_report0.namevalue(1,"S94000")=gcds_data.namevalue(gcds_data.rowposition,"S94000");
	gcds_report0.namevalue(1,"T21000")=gcds_data.namevalue(gcds_data.rowposition,"T21000");
	gcds_report0.namevalue(1,"T22000")=gcds_data.namevalue(gcds_data.rowposition,"T22000");
	gcds_report0.namevalue(1,"T23000")=gcds_data.namevalue(gcds_data.rowposition,"T23000");
	gcds_report0.namevalue(1,"T24000")=gcds_data.namevalue(gcds_data.rowposition,"T24000");
	gcds_report0.namevalue(1,"P43000")=gcds_data.namevalue(gcds_data.rowposition,"P43000");
	gcds_report0.namevalue(1,"P41000")=gcds_data.namevalue(gcds_data.rowposition,"P41000");
	gcds_report0.namevalue(1,"P42000")=gcds_data.namevalue(gcds_data.rowposition,"P42000");
	gcds_report0.namevalue(1,"RETJUH")=gcds_data.namevalue(gcds_data.rowposition,"RETJUH");
	gcds_report0.namevalue(1,"BX0010")=gcds_data.namevalue(gcds_data.rowposition,"BX0010");
	gcds_report0.namevalue(1,"BX0020")=gcds_data.namevalue(gcds_data.rowposition,"BX0020");
	gcds_report0.namevalue(1,"BX0030")=gcds_data.namevalue(gcds_data.rowposition,"BX0030");
	gcds_report0.namevalue(1,"BX0040")=gcds_data.namevalue(gcds_data.rowposition,"BX0040");
	gcds_report0.namevalue(1,"S93000")=gcds_data.namevalue(gcds_data.rowposition,"S93000");
	gcds_report0.namevalue(1,"RESINO")=gcds_data.namevalue(gcds_data.rowposition,"RESINO");

	gcds_report0.namevalue(1,"AMTTXT")=" X (" + strDUYEAR + " + " + strDUYMM + " / 12)";

	gcds_report0.namevalue(1,"REF1")=gcds_data.namevalue(gcds_data.rowposition,"REF1");
	gcds_report0.namevalue(1,"REF2")=gcds_data.namevalue(gcds_data.rowposition,"REF2");
	gcds_report0.namevalue(1,"REF3")=gcds_data.namevalue(gcds_data.rowposition,"REF3");
  gcds_report0.namevalue(1,"REF4")=gcds_data.namevalue(gcds_data.rowposition,"REF4");
	gcds_report0.namevalue(1,"REF") =gcds_data.namevalue(gcds_data.rowposition,"REF");

	gcrp_print.preview();
	}
}

/******************************************************************************
	Description : 출력 - 퇴직소득원천징수영수증/지급조서
******************************************************************************/
function ln_Print2(){
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

	gcds_report0.ClearData();

	var ls_temp="EMPNO:STRING,EMPNMK:STRING,RESINO:STRING,APPDT:STRING,EMPDIV:STRING,DEPTNM:STRING,PAYGRDNM:STRING,";
	ls_temp +="STRTDT:STRING,ENDDT:STRING,JDDAY:STRING,DUYEAR:DECIMAL,DUYMM:DECIMAL,DUDAY:DECIMAL,CADDR:STRING,";
	ls_temp +="J_CMP:STRING,J_SAP:STRING,J_AMT:DECIMAL,J_MUN:DECIMAL,J_RAT:DECIMAL,";
	ls_temp +="J_STRTDT:STRING,J_ENDDT:STRING,J_DUYEAR:DECIMAL,S91AMT:DECIMAL,S91STD:DECIMAL,";
	ls_temp +="J_T2300:DECIMAL,J_T2400:DECIMAL,T21000:DECIMAL,S91000:DECIMAL,T91AMT:DECIMAL,T23000:DECIMAL,T24000:DECIMAL,";
	ls_temp +="DUYEAR1:DECIMAL,AMT01:DECIMAL,AMT02:DECIMAL,AMT03:DECIMAL,AMT04:DECIMAL,AMT05:DECIMAL,";
	ls_temp +="AMT06:DECIMAL,AMT07:DECIMAL,AMT08:DECIMAL,AMT09:DECIMAL,AMT10:DECIMAL,AMT11:DECIMAL,AMT12:DECIMAL,";
	ls_temp +="CURDT:STRING,HTITLE:STRING";
	
	gcds_report0.SetDataHeader(ls_temp);

	for (i=1;i<=3;i++) {
		
		gcds_report0.Addrow();

	gcds_report0.namevalue(i,"EMPNO")		=	gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	gcds_report0.namevalue(i,"EMPNMK")	=	gcds_data.namevalue(gcds_data.rowposition,"EMPNMK");
	gcds_report0.namevalue(i,"RESINO")  = gcds_data.namevalue(gcds_data.rowposition,"RESINO");
	gcds_report0.namevalue(i,"APPDT")		=	gcds_data.namevalue(gcds_data.rowposition,"APPDT");
	gcds_report0.namevalue(i,"EMPDIV")	=	gcds_data.namevalue(gcds_data.rowposition,"EMPDIV");
	gcds_report0.namevalue(i,"DEPTNM")	=	gcds_data.namevalue(gcds_data.rowposition,"DEPTNM");
	gcds_report0.namevalue(i,"PAYGRDNM")=	gcds_data.namevalue(gcds_data.rowposition,"PAYGRDNM");
	gcds_report0.namevalue(i,"STRTDT")	=	gcds_data.namevalue(gcds_data.rowposition,"STRTDT");
	gcds_report0.namevalue(i,"ENDDT")		=	gcds_data.namevalue(gcds_data.rowposition,"ENDDT");

	var strDUYEAR = gcds_data.namevalue(gcds_data.rowposition,"DUYEAR")+"";
	var strDUYMM  = gcds_data.namevalue(gcds_data.rowposition,"DUYMM")+"";
	var strDUDAY  = gcds_data.namevalue(gcds_data.rowposition,"DUDAY")+"";

	gcds_report0.namevalue(i,"JDDAY")	 = strDUYEAR+"년 "+strDUYMM+"월";
	gcds_report0.namevalue(i,"DUYEAR") = parseInt(strDUYEAR);
	gcds_report0.namevalue(i,"DUYMM")  = parseInt(strDUYMM);
	gcds_report0.namevalue(i,"DUDAY")  = parseInt(strDUDAY);

	var strCA1=gcds_data.namevalue(gcds_data.rowposition,"CADDR01");
	var strCA2=gcds_data.namevalue(gcds_data.rowposition,"CADDR02");

	gcds_report0.namevalue(i,"CADDR")		=	strCA1+" "+strCA2;
	gcds_report0.namevalue(i,"J_CMP")		=	gcds_data.namevalue(gcds_data.rowposition,"J_CMP");
	gcds_report0.namevalue(i,"J_SAP")		=	gcds_data.namevalue(gcds_data.rowposition,"J_SAP");
	gcds_report0.namevalue(i,"J_AMT")		=	gcds_data.namevalue(gcds_data.rowposition,"J_AMT");
	gcds_report0.namevalue(i,"J_MUN")		=	gcds_data.namevalue(gcds_data.rowposition,"J_MUN");
	gcds_report0.namevalue(i,"J_RAT")		=	gcds_data.namevalue(gcds_data.rowposition,"J_RAT");
	gcds_report0.namevalue(i,"J_STRTDT")=	gcds_data.namevalue(gcds_data.rowposition,"J_STRTDT");
	gcds_report0.namevalue(i,"J_ENDDT")	=	gcds_data.namevalue(gcds_data.rowposition,"J_ENDDT");
	gcds_report0.namevalue(i,"J_DUYEAR")=	gcds_data.namevalue(gcds_data.rowposition,"J_DUYEAR");
	gcds_report0.namevalue(i,"S91AMT")	=	gcds_data.namevalue(gcds_data.rowposition,"S91AMT");
	gcds_report0.namevalue(i,"S91STD")	=	gcds_data.namevalue(gcds_data.rowposition,"S91STD");
	gcds_report0.namevalue(i,"J_T2300")	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2300");
	gcds_report0.namevalue(i,"J_T2400")	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2400");
	gcds_report0.namevalue(i,"T21000")	= gcds_data.namevalue(gcds_data.rowposition,"T21000");
	gcds_report0.namevalue(i,"S91000")	= gcds_data.namevalue(gcds_data.rowposition,"S91000");
	gcds_report0.namevalue(i,"T91AMT")	= gcds_data.namevalue(gcds_data.rowposition,"T91AMT");
	gcds_report0.namevalue(i,"T23000")	=	gcds_data.namevalue(gcds_data.rowposition,"T23000");
	gcds_report0.namevalue(i,"T24000")	=	gcds_data.namevalue(gcds_data.rowposition,"T24000");
	gcds_report0.namevalue(i,"DUYEAR1")	=	gcds_data.namevalue(gcds_data.rowposition,"DUYEAR1");

	var strJAMT = gcds_data.namevalue(gcds_data.rowposition,"J_AMT");
	var strJMUN = gcds_data.namevalue(gcds_data.rowposition,"J_MUN");
	var strJRAT = gcds_data.namevalue(gcds_data.rowposition,"J_RAT");

	gcds_report0.namevalue(i,"AMT01")		= parseInt(strJAMT+strJMUN+strJRAT);	//(102) 계

	var strS91STD		= gcds_data.namevalue(gcds_data.rowposition,"S91STD");
	var strDUYEAR1	= gcds_data.namevalue(gcds_data.rowposition,"DUYEAR1");
	
	gcds_report0.namevalue(i,"AMT02")		= parseInt(strS91STD)/parseInt(strDUYEAR1);	//퇴직과세표준÷근속연수

	var strT91AMT  = gcds_data.namevalue(gcds_data.rowposition,"T91AMT");

	gcds_report0.namevalue(i,"AMT03")		= parseInt(strT91AMT)*parseInt(strDUYEAR1);	//연평균산출세액*근속연수

	var strT21000 = gcds_data.namevalue(gcds_data.rowposition,"T21000");

	var amt04_floor = parseInt(strT91AMT)*parseInt(strDUYEAR1)-parseInt(strT21000);

	gcds_report0.namevalue(i,"AMT04")		= Math.floor(parseInt(amt04_floor)/10)*10;	//산출세액-세액공제

	var strS91000 = gcds_data.namevalue(gcds_data.rowposition,"S91000");

	gcds_report0.namevalue(i,"AMT05")		= parseInt(strS91000+strJAMT);	//(104) 계(13)
	gcds_report0.namevalue(i,"AMT06")		= parseInt(strS91000+strJAMT+strJMUN+strJRAT);	//(104) 계(16)
	gcds_report0.namevalue(i,"AMT07")		= parseInt(strDUYEAR*12)+parseInt(strDUYMM);	//(17) 근속월수

	var strT23000		= gcds_data.namevalue(gcds_data.rowposition,"T23000");
	var strT24000		= gcds_data.namevalue(gcds_data.rowposition,"T24000");
	var strJ_T2300	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2300");
	var strJ_T2400	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2400");

	gcds_report0.namevalue(i,"AMT08")		= parseInt(strT23000)-parseInt(strJ_T2300);		//결정세액-종(전)근무지 기납부세액
	gcds_report0.namevalue(i,"AMT09")		= parseInt(strT23000)+parseInt(strT24000);		//계 (29) 소득세+주민세
	gcds_report0.namevalue(i,"AMT10")		= parseInt(strJ_T2300)+parseInt(strJ_T2400);	//계 (30) 소득세+주민세
	gcds_report0.namevalue(i,"AMT11")		= parseInt(strT24000)+parseInt(strJ_T2400);		//계 (31) 주민세(결정세액+종(전)근무지 기납부세액)
	gcds_report0.namevalue(i,"AMT12")		= (parseInt(strT24000)+parseInt(strJ_T2400))	//계 (31) 소득세+주민세(총)
																			+ (parseInt(strT23000)-parseInt(strJ_T2300));	
  
	gcds_report0.namevalue(i,"CURDT")=	gs_date;

	if (i==1) { 
		gcds_report0.namevalue(i,"HTITLE")	=	"(발 행 자 보 고 용)";
	}else if(i==2) {
		gcds_report0.namevalue(i,"HTITLE")	=	"(발 행 자 보 관 용)";
	}else if(i==3) {
		gcds_report0.namevalue(i,"HTITLE")	=	"(소 득 자 보 관 용)";
	}

	}//end for
		gcrp_print2.preview();
	}
}

/******************************************************************************
	Description : 출력 - 정산영수증 
******************************************************************************/
function ln_Print3(){
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
		 gcds_report3.ClearData();

		 gcds_report3.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040005_s2?v_str1="   
												 + gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
		 gcds_report3.Reset(); 
		 if(gcds_report3.countRow > 0) {
			 gcrp_print3.preview();
		 }else{
			 alert("출력하실 정보가 없습니다");
		 }
	}
}

/******************************************************************************
	Description : 보고서 조회 - 상여명세서 조회
******************************************************************************/
function ln_Query2(){ //사원별대장 탭 조회
var str1=gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
var str2=gcds_data.namevalue(gcds_data.rowposition,"ENDDT");
	gcds_report4.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040005_s3?v_str1="   + str1
	                    + "&v_str2=" + str2.substring(0,4);
	gcds_report4.Reset(); //그리드
	gcds_report4.rowposition=1;
}

/******************************************************************************
	Description : 출력 - 상여명세서
******************************************************************************/
function ln_Print4(){
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

			ln_Query2();
			var ls_temp = "CUDATE:STRING,CTITLE:STRING,PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING";
			gcds_report0.SetDataHeader(ls_temp);
			gcds_report0.Addrow();
			gcds_report0.namevalue(1,"CUDATE")=gs_date;

			//REPORT TITLE START--------------------------------------------------------------------------------------
			gcds_report0.namevalue(1,"CTITLE")="전체 상여대장";
			gcrp_print4.preview();		//상여대장
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--기본사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 보고서 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 정산영수증보고서 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SubsumExpr   value="1:SEQ">
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 상여 명세서 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속구분 DataSet-->
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
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
	gcem_BASAMT_SUM.Text= "";//급여합계
	gcem_BASBUS_SUM.Text= "";//상여합계
	gcem_BAEAMT_SUM.Text= "";//기타수당합계
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0) {
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	ft_cnt1.innerText="추계 퇴직금데이타 조회중입니다.";
	window.status="추계 퇴직금데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>
	if(row >0){
		gcem_BASAMT_SUM.Text= //급여합계
		gcds_data.NameValue(row,"BASAMT1")+
		gcds_data.NameValue(row,"BASAMT2")+
		gcds_data.NameValue(row,"BASAMT3")+
		gcds_data.NameValue(row,"BASAMT4");

		gcem_BASBUS_SUM.Text= //상여합계
		gcds_data.NameValue(row,"BASBUS1")+
		gcds_data.NameValue(row,"BASBUS2")+
		gcds_data.NameValue(row,"BASBUS3")+
		gcds_data.NameValue(row,"BASBUS4");

		gcem_BAEAMT_SUM.Text= //기타수당합계
		gcds_data.NameValue(row,"BAEAMT1")+
		gcds_data.NameValue(row,"BAEAMT2")+
		gcds_data.NameValue(row,"BAEAMT3")+
		gcds_data.NameValue(row,"BAEAMT4")+
		gcds_data.NameValue(row,"AVGYER");

		var str_baeday11 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY1");
		var str_baeday22 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY2");
		var str_baeday33 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY3");
		var str_baeday44 = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY4");
		var str_bdaysum2 = str_baeday11+str_baeday22+str_baeday33+str_baeday44;
		var str_bamtsum2 = gcds_data.namevalue(gcds_data.rowposition,"BAEAMT1")
									+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT2")
									+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT3")
									+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT4")
									+gcds_data.namevalue(gcds_data.rowposition,"AVGYER");

	 gcem_AVGETC.Text = Math.round((str_bamtsum2/str_bdaysum2)*30);		//기타평균 AVGETC

	 gcem_AVGAMT.Text = //기본급 평균
	 Math.round((gcds_data.NameValue(row,"BASAMT1")+
	 gcds_data.NameValue(row,"BASAMT2")+
	 gcds_data.NameValue(row,"BASAMT3")+
	 gcds_data.NameValue(row,"BASAMT4"))/3);

	 gcem_AVGBOS.Text = //상여금 평균
	 Math.round((gcds_data.NameValue(row,"BASBUS1")+
	 gcds_data.NameValue(row,"BASBUS2")+
	 gcds_data.NameValue(row,"BASBUS3")+
	 gcds_data.NameValue(row,"BASBUS4"))/12);

		if (gcds_data.namevalue(gcds_data.rowposition,"BAEDAY1") == gcds_data.namevalue(gcds_data.rowposition,"BASMAX1")) {
			gcds_data.namevalue(gcds_data.rowposition,"BAEDAY1") = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY1")-1;
			gcds_data.namevalue(gcds_data.rowposition,"BASDAY1") = gcds_data.namevalue(gcds_data.rowposition,"BASDAY1")-1;
			
			gcds_data.namevalue(gcds_data.rowposition,"BAEDAY4") = gcds_data.namevalue(gcds_data.rowposition,"BAEDAY4")+1;
			gcds_data.namevalue(gcds_data.rowposition,"BASDAY4") = gcds_data.namevalue(gcds_data.rowposition,"BASDAY4")+1;
		}
	}
</script>


 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
</script>
<script language="javascript" for="gctr_data" event="onerror()">
	alert("요청하신 작업을 성공적으로 수행하지 못했습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p040005_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_redetail.gif"	style="cursor:hand" onclick="ln_Print4()"><!--상여명세서--> 
			<img src="../../Common/img/btn/com_b_account.gif"	style="cursor:hand" onclick="ln_Print3()"><!--정산영수증--> 
			<img src="../../Common/img/btn/com_b_retirec.gif"	style="cursor:hand" onclick="ln_Print2()"><!--퇴직영수증--> 
	    <img src="../../Common/img/btn/com_b_reinfor.gif" style="cursor:hand" onclick="ln_Print()"><!--퇴사통보서--> 
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0"      
	   style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
				<nobr>&nbsp;기준일자&nbsp;</nobr></td>
			<TD style="border:0 solid #708090;border-right-width:1px;"><nobr>
	<table cellpadding=0 cellspacing=0>
		<tr>
			<td><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_jigub11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment	  value=0>
					<param name=Border	      value=True>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub11', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr></td><td>~</td>
			<td><nobr>
				<comment id="__NSID__"><object id=gcem_jigub12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				style="position:relative; left:1px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
				validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment	  value=0>
					<param name=Border	      value=True>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
			  </object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub12', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;&nbsp;</nobr></td></tr></table></nobr></TD>
      <td style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
			<td style="height:20px; border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff"><nobr><input id=txt_empnm_search name=txt_empnm_search type=text class="txt21" size=10 onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 
      <td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
		</tr>
	</table>		
		</td>
	</tr> 
  <tr> 
  <td height=3></td>
  </tr>  
  <tr> 
    <td colspan=2 valign=top> 
  <table width="876" cellpadding="0" cellspacing="0" border="0">
		<tr> 
		  <td valign=top>
	<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td colspan=2>
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  style="WIDTH: 280px; HEIGHT: 276px;border:1 solid #777777;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data">
					<PARAM NAME="Editable" VALUE="false">
					<PARAM NAME="ColSizing" VALUE="true">
					<PARAM NAME="BorderStyle" VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<PARAM NAME="Format"			VALUE="  
						<C> Name='소속' ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=80 </C>
						<C> Name='성명' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center   </C>
						<C> Name='사번' ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center </C> 
						<C> Name='퇴사일' ID=ENDDT HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=center Mask='XXXX/XX/XX' </C>
					">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
		  </td>
		</tr>
    <tr> <td height=3></td> </tr>  
		<tr>
			<td colspan=2>
	<table width="282" height="482" border= "0" cellpadding=0 cellspacing=0  border=0  style=' height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr>
			<td style="height:20px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;퇴직사유&nbsp;</nobr></td>
			<td style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><input id="txt_ref" type="text" class=txt21 style="width:200px;" readonly></nobr></td> 
		</tr>
		<tr>
      <td  style="height:20px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;사번/성명&nbsp;</nobr></td>
			<td style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT id=txt_empno TYPE=TEXT STYLE="width:60px;" class="txt21" readonly  value="" >&nbsp;&nbsp;&nbsp;/&nbsp;<INPUT TYPE=TEXT STYLE="width:70px; "  id=txt_empnmk class="txt21" readonly value=""  ></nobr></td> 
    </tr>
		<tr>
			<td  style="height:25px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;소속/직위&nbsp;</nobr></td>
			<td   style="width=30px; height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:100px; "  id=txt_DEPTNM class="txt21"  readonly  value="" >&nbsp;&nbsp;/<INPUT TYPE=TEXT STYLE="width:70px; "  id=txt_PAYGRDNM class="txt21" readonly value=""  ></nobr></td> 
		</tr>
		<tr>
			<td  style="height:25px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;입/퇴사일&nbsp;</nobr></td>
			<TD style="border:0 solid #708090;border-bottom-width:1px; border-right-width:0px;"><nobr>
				<table cellspacing=0 cellpadding=0 border=0>
					<tr>
						<td>&nbsp;
							<comment id="__NSID__"><object id=gcem_STRTDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"		style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
						</td>
						<td style="padding-top:4px;">/</td>
						<td>&nbsp;
							<comment id="__NSID__"><object id=gcem_ENDDT                
						   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
			         	    style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1
			            	validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
				</table></nobr>
			</TD>
    </tr>
		<tr>
      <td  style="height:23px; width:60px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;근무기간&nbsp;</nobr></td>
			<td  width="100%" style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:20px; padding-top:4px;text-align:right;" id=txt_DUYEAR class="txt21" readonly  value="" >&nbsp;&nbsp;년<INPUT TYPE=TEXT STYLE="width:20px;  padding-top:4px;text-align:right;" id=txt_DUYMM class="txt21" readonly  value="" >&nbsp;&nbsp;개월<INPUT TYPE=hidden STYLE="width:20px; padding-top:4px ;text-align:right;" id=txt_DUDAY class="txt21" readonly  value="" >&nbsp;&nbsp;<!-- 일 -->&nbsp; </nobr></td> 
		</tr>	
		<tr>
			<td  style="height:23px; width:60px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;주소&nbsp;</nobr></td>
			<td  width="100%" style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:200px; " id=txt_CADDR01 class="txt21" readonly  value="" >&nbsp;</nobr></td> 
		</tr>	
	</table>
	<fieldset style="width:282;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
		<font id=ft_cnt1 style="position:relative;top:4px;"></font>
	</fieldset>
						</td>
				  </tr>
		    </table>
      </td>
		  <td width=3>
		  </td>
		  <td valign=top>

<div id=div_jikwon style="display:block;">
<table width="591" border= "0" cellpadding=0 cellspacing=0  style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<TD colspan=10 align="left" style="height:20px; border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;1.퇴직금계산내역-직원&nbsp;</nobr></TD>                     
  </tr>   
	<tr>
		<TD colspan=4 align="center" style="height:20px; border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기본급+직책수당+시간외수당&nbsp;</nobr></TD> 
		<TD colspan=2 align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;상여금ㆍ년차수당&nbsp;</nobr></TD> 
		<TD colspan=4 align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타 수당&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:50px;text-align:center"  id=txt_BASDAY1  readonly ></nobr></td>
		<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:50px;text-align:center"  id=txt_BASMAX1  readonly  ></nobr></td>
		<td align=center style=" width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>1st월</nobr></td>
		<TD align=center width=90 align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASAMT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align=center style=" width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref1 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
		<TD align="center" width=90 style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS1               
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY1  readonly ></nobr></td>
		<td align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX1  readonly ></nobr></td>
		<td  align=center style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>1st월</nobr></td>
		
		<!-- 여기부터 -->
		<TD align="center" width=90 style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT1                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
	<tr>
		<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY2  readonly  ></nobr></td>
		<td align=center  style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX2  readonly  ></nobr></td>
		<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>2nd월</nobr></td>
		<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASAMT2                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center  style="height:20px; width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref2 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
		<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASBUS2                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY2  readonly ></nobr></td>
		<td align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX2  readonly ></nobr></td>
		<TD align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>2nd월</nobr></td>
		<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BAEAMT2                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
	<tr>
		<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY3  readonly  ></nobr></td>
		<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX3  readonly  ></nobr></td>
		<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>3th월</nobr></td>
		<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASAMT3                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center  style="height:20px; width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref3 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
		<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS3                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr></TD> 
		<td  align=center style=" width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY3  readonly ></nobr></td>
		<td align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX3  readonly ></nobr></td>
		<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>3th월</nobr></td>
		<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>	
			<comment id="__NSID__"><object id=gcem_BAEAMT3                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
	<tr>
		<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY4  readonly  ></nobr></td>
		<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX4  readonly  ></nobr></td>
		<TD align=center  style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>4th월</nobr></td>
		<TD align=center align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>	
			<comment id="__NSID__"><object id=gcem_BASAMT4                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref4 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
		<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASBUS4                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY4  readonly ></nobr></td>
		<td align=center  style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX4  readonly ></nobr></td>
		<TD align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>4th월</nobr></td>
		<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BAEAMT4                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>
	<tr>
		<TD align=center colspan=3  style="height:22px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>년차일수</nobr></TD> 
		<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_YEAQTY                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>년차수당</nobr></TD> 
		<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_YEAPAY                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center colspan=3  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>평균년차수당</nobr></TD> 
		<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_AVGYER                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
	<tr>
		<td colspan=3 align=center  style="height:22px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></td>
		<TD  align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASAMT_SUM                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align=center style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></td>
		<TD  align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BASBUS_SUM                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD>				 
		<td colspan=3 align=center   style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">합계</td>
		<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_BAEAMT_SUM                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
	<tr>
		<TD align=center colspan=3  style="height:22px;border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
		<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_AVGAMT                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
		<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_AVGBOS                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align=center colspan=3  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
		<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_AVGETC                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
</table>
<table border= "0" cellpadding=0 cellspacing=0><tr><td height=3></td></tr></table>

<!-- 기타수당 -->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<TD colspan=8 align="left" style="height=22px; border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;2.기타수당내역&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<TD align="center" style=" height:20px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>근속수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>자기계발비</nobr></TD> 
		<td align="center" style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>차량유지비</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>남북경협수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>임원직책수당</nobr></TD>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>연장수당</nobr></TD>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>기타</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<td align="center"  style="height:23px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_P21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1		validFeatures="ignoreStatus=yes" validExp=""> <!-- 근속수당 -->
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_P22000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 자기계발비 -->
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center"  style=" border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_P24000               
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 차량유지비 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_P29000               
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 남북경협수당 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_P38000                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 임원직책수당 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P27000 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 연장수당 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_PX0000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 기타 -->
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>&nbsp;&nbsp;</nobr></TD> 
	</tr>   
</table>
<table cellpadding=0 cellspacing=0  border=0><tr> <td height=3></td></tr></table>

<!-- 지급내역  -->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<td colspan=7 align="left" style="height:20px; width:70px; border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;3.퇴직금정산내역&nbsp;</nobr></td>
  </tr>   
	<tr>
		<td align="center" style="height:20px; width:81px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>급여</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>퇴직금</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>년차수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>상여</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>지급합계</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>실지급액</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp&nbsp</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_JUSPAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1		validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_JUSRET                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center"  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_JUSYER                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_JUSBOS              
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_S91000                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="0,000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center" style=" border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_S94000
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>&nbsp&nbsp</nobr></TD> 
	</tr>
</table>
<table cellpadding=0 cellspacing=0  border=0 ><tr> <td height=3></td></tr>  </table>

<!--4.공제내역-->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<td colspan=7 align="left" style="height:20px;  border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;4.공제내역&nbsp;</nobr></td>
  </tr>   
	<tr>
		<td align="center" style="height:20px; width:81px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>정산갑근세</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산주민세</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산국민연금</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산건강보험</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산고용보험</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>퇴직소득세</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>퇴직주민세</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" ><nobr>
			<comment id="__NSID__"><object id=gcem_T21000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_T22000 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center" style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" ><nobr>
			<comment id="__NSID__"><object id=gcem_P43000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_P41000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=Readonly      value=true>
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_P42000                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="0,000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center"   style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" ><nobr>
			<comment id="__NSID__"><object id=gcem_T23000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_T24000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   				
	<tr>
		<td align="center" style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타1&nbsp;</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타2&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타3&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타4&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;퇴직전환금&nbsp;</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;공제합계&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_BX0010                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px;right:8px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_BX0020                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center" style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_BX0030                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090; border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_BX0040                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_RETJUH                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center"  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>&nbsp;&nbsp;</nobr></td>
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_S93000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Readonly      value=true>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
</table>
</div>
  </td>
     </tr>
			</table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec01az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT   Ctrl=txt_appdt					Param=value</C>
		<C>Col=EMPNO   Ctrl=txt_empno					Param=value</C>
		<C>Col=EMPDIV  Ctrl=txt_empdiv				Param=value</C>
		<C>Col=EMPNMK  Ctrl=txt_empnmk				Param=value</C>
		<C>Col=DEPTNM  Ctrl=txt_DEPTNM				Param=value</C>
		<C>Col=PAYGRDNM Ctrl=txt_PAYGRDNM			Param=value</C>
		<C>Col=STRTDT  Ctrl=gcem_STRTDT       Param=Text</C>
		<C>Col=ENDDT   Ctrl=gcem_ENDDT				Param=Text</C>
		<C>Col=DUYEAR  Ctrl=txt_DUYEAR				Param=value</C>
		<C>Col=DUYMM   Ctrl=txt_DUYMM					Param=value</C>
		<C>Col=DUDAY   Ctrl=txt_DUDAY					Param=value</C>
		<C>Col=CADDR01 Ctrl=txt_CADDR01       Param=value</C>
		<C>Col=CADDR02 Ctrl=txt_CADDR02       Param=value</C>
		<C>Col=BASDAY1 Ctrl=txt_BASDAY1       Param=value</C>
		<C>Col=BASDAY2 Ctrl=txt_BASDAY2       Param=value</C>
		<C>Col=BASDAY3 Ctrl=txt_BASDAY3       Param=value</C>
		<C>Col=BASDAY4 Ctrl=txt_BASDAY4       Param=value</C>
		<C>Col=BASMAX1 Ctrl=txt_BASMAX1       Param=value</C>
		<C>Col=BASMAX2 Ctrl=txt_BASMAX2       Param=value</C>
		<C>Col=BASMAX3 Ctrl=txt_BASMAX3       Param=value</C>
		<C>Col=BASMAX4 Ctrl=txt_BASMAX4       Param=value</C>
		<C>Col=BASMAX1 Ctrl=txt_BAEMAX1       Param=value</C>
		<C>Col=BASMAX2 Ctrl=txt_BAEMAX2       Param=value</C>
		<C>Col=BASMAX3 Ctrl=txt_BAEMAX3       Param=value</C>
		<C>Col=BASMAX4 Ctrl=txt_BAEMAX4       Param=value</C>
		<C>Col=BASAMT1 Ctrl=gcem_BASAMT1      Param=Text</C>
		<C>Col=BASAMT2 Ctrl=gcem_BASAMT2      Param=Text</C>
		<C>Col=BASAMT3 Ctrl=gcem_BASAMT3      Param=Text</C>
		<C>Col=BASAMT4 Ctrl=gcem_BASAMT4      Param=Text</C>
		<C>Col=BASBUS1 Ctrl=gcem_BASBUS1      Param=Text</C>
		<C>Col=BASBUS2 Ctrl=gcem_BASBUS2      Param=Text</C>
		<C>Col=BASBUS3 Ctrl=gcem_BASBUS3      Param=Text</C>
		<C>Col=BASBUS4 Ctrl=gcem_BASBUS4      Param=Text</C>
		<C>Col=BAEDAY1 Ctrl=txt_BAEDAY1       Param=value</C>
		<C>Col=BAEDAY2 Ctrl=txt_BAEDAY2       Param=value</C>
		<C>Col=BAEDAY3 Ctrl=txt_BAEDAY3				Param=value</C>
		<C>Col=BAEDAY4 Ctrl=txt_BAEDAY4       Param=value</C>
		<C>Col=BAEAMT1 Ctrl=gcem_BAEAMT1      Param=Text</C>
		<C>Col=BAEAMT2 Ctrl=gcem_BAEAMT2      Param=Text</C>
		<C>Col=BAEAMT3 Ctrl=gcem_BAEAMT3      Param=Text</C>
		<C>Col=BAEAMT4 Ctrl=gcem_BAEAMT4      Param=Text</C>
		<C>Col=YEAQTY  Ctrl=gcem_YEAQTY       Param=Text</C>
		<C>Col=YEAPAY  Ctrl=gcem_YEAPAY       Param=Text</C>
		<C>Col=AVGYER  Ctrl=gcem_AVGYER       Param=Text</C>
		<C>Col=AVGAMT  Ctrl=gcem_AVGAMT       Param=Text</C>
		<C>Col=AVGBOS  Ctrl=gcem_AVGBOS       Param=Text</C>
		<C>Col=AVGETC  Ctrl=gcem_AVGETC       Param=Text</C>
		<C>Col=P21000  Ctrl=gcem_P21000       Param=Text</C>
		<C>Col=P22000  Ctrl=gcem_P22000				Param=Text</C>
		<C>Col=P24000  Ctrl=gcem_P24000       Param=Text</C>
		<C>Col=P29000  Ctrl=gcem_P29000       Param=Text</C>
		<C>Col=P38000  Ctrl=gcem_P38000       Param=Text</C>
		<C>Col=P27000  Ctrl=gcem_P27000       Param=Text</C>
		<C>Col=PX0000  Ctrl=gcem_PX0000       Param=Text</C>
		<C>Col=JUSPAY  Ctrl=gcem_JUSPAY       Param=Text</C>
		<C>Col=JUSRET  Ctrl=gcem_JUSRET       Param=Text</C>
		<C>Col=JUSYER  Ctrl=gcem_JUSYER       Param=Text</C>
		<C>Col=JUSBOS  Ctrl=gcem_JUSBOS       Param=Text</C>
		<C>Col=S91000  Ctrl=gcem_S91000       Param=Text</C>
		<C>Col=S94000  Ctrl=gcem_S94000       Param=Text</C>
		<C>Col=T21000  Ctrl=gcem_T21000       Param=Text</C>
		<C>Col=T22000  Ctrl=gcem_T22000       Param=Text</C>
		<C>Col=T23000  Ctrl=gcem_T23000       Param=Text</C>
		<C>Col=T24000  Ctrl=gcem_T24000       Param=Text</C>
		<C>Col=P43000  Ctrl=gcem_P43000       Param=Text</C>
		<C>Col=P41000  Ctrl=gcem_P41000       Param=Text</C>
		<C>Col=P42000  Ctrl=gcem_P42000       Param=Text</C>
		<C>Col=RETJUH  Ctrl=gcem_RETJUH       Param=Text</C>
		<C>Col=BX0010  Ctrl=gcem_BX0010       Param=Text</C>
		<C>Col=BX0020  Ctrl=gcem_BX0020       Param=Text</C>
		<C>Col=BX0030  Ctrl=gcem_BX0030       Param=Text</C>
		<C>Col=BX0040  Ctrl=gcem_BX0040       Param=Text</C>
		<C>Col=S93000  Ctrl=gcem_S93000       Param=Text</C>
		
		<C>Col=REF1		 Ctrl=txt_ref1					Param=value</C>
		<C>Col=REF2		 Ctrl=txt_ref2					Param=value</C>
		<C>Col=REF3		 Ctrl=txt_ref3					Param=value</C>
		<C>Col=REF4		 Ctrl=txt_ref4					Param=value</C>

		<C>Col=REF		 Ctrl=txt_ref						Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분 - 출력
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<!--param name="DetailDataID"	value="gcds_report2"-->
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2622 ,face='굴림' ,size=10 ,penwidth=1
	<C>id='CADDR', left=378, top=197, right=1441, bottom=253, align='left'</C>
	<L> left=22 ,top=184 ,right=1900 ,bottom=184 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=262 ,right=1900 ,bottom=262 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='RESINO', left=1622, top=197, right=1891, bottom=253, align='left' ,mask='XXXXXX-XXXXXXX'</C>
	<T>id='주민번호 :' ,left=1453 ,top=197 ,right=1619 ,bottom=253 ,align='left'</T>
	<T>id='주소 :' ,left=266 ,top=197 ,right=378 ,bottom=253 ,align='left'</T>
	<C>id='CTITLE', left=1328, top=125, right=1903, bottom=178, align='right' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1.인적사항' ,left=34 ,top=197 ,right=247 ,bottom=250 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 번 :' ,left=47 ,top=275 ,right=194 ,bottom=328 ,align='left'</T>
	<C>id='STRTDT', left=600, top=275, right=816, bottom=328, align='left' ,mask='XXXX/XX/XX'</C>
	<T>id='입사일 :' ,left=450 ,top=275 ,right=584 ,bottom=328 ,align='left'</T>
	<C>id='EMPNO', left=209, top=275, right=381, bottom=328, align='left'</C>
	<C>id='EMPNMK', left=1638, top=275, right=1875, bottom=328, align='left'</C>
	<T>id='성 명 :' ,left=1513 ,top=275 ,right=1628 ,bottom=328 ,align='left'</T>
	<C>id='DEPTNM', left=1050, top=275, right=1491, bottom=328, align='left'</C>
	<T>id='소      속 :' ,left=863 ,top=275 ,right=1038 ,bottom=328 ,align='left'</T>
	<L> left=22 ,top=331 ,right=1900 ,bottom=331 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='REF', left=1638, top=337, right=1875, bottom=391, align='left'</C>
	<T>id='사 유 :' ,left=1513 ,top=337 ,right=1628 ,bottom=391 ,align='left'</T>
	<C>id='JDDAY', left=1050, top=337, right=1491, bottom=391, align='left'</C>
	<T>id='재직기간 :' ,left=863 ,top=337 ,right=1038 ,bottom=391 ,align='left'</T>
	<C>id='ENDDT', left=600, top=337, right=813, bottom=391, align='left' ,mask='XXXX/XX/XX'</C>
	<T>id='퇴사일 :' ,left=450 ,top=337 ,right=584 ,bottom=391 ,align='left'</T>
	<C>id='PAYGRDNM', left=209, top=337, right=381, bottom=391, align='left'</C>
	<T>id='직 위 :' ,left=47 ,top=337 ,right=194 ,bottom=391 ,align='left'</T>
	<L> left=22 ,top=400 ,right=1900 ,bottom=400 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=184 ,right=1900 ,bottom=400 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=191 ,right=22 ,bottom=400 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=466 ,right=1900 ,bottom=466 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='2.퇴직금 계산내역' ,left=16 ,top=412 ,right=375 ,bottom=466 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴    직    금' ,left=1531 ,top=478 ,right=1800 ,bottom=531</T>
	<T>id='기타 및 월차수당' ,left=950 ,top=478 ,right=1400 ,bottom=531</T>
	<T>id='상여금 및 년차수당' ,left=497 ,top=478 ,right=931 ,bottom=531</T>
	<T>id='기본급 + 직책 + 시간외' ,left=50 ,top=478 ,right=466 ,bottom=531</T>
	<L> left=22 ,top=541 ,right=1900 ,bottom=541 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='JUSRET', left=1494, top=553, right=1766, bottom=606, align='right'</C>
	<C>id='BAEAMT1', left=1188, top=553, right=1403, bottom=606, align='right'</C>
	<C>id='CMM1', left=1097, top=553, right=1175, bottom=606 ,mask='XX월'</C>
	<C>id='BASMAX1', left=1019, top=553, right=1084, bottom=606</C>
	<C>id='BAEDAY1', left=941, top=553, right=1009, bottom=606</C>
	<C>id='BASBUS1', left=716, top=553, right=931, bottom=606, align='right'</C>
	<C>id='REF1', left=494, top=553, right=706, bottom=606</C>
	<C>id='BASAMT1', left=272, top=553, right=484, bottom=606, align='right'</C>
	<C>id='CMM1', left=184, top=553, right=263, bottom=606 ,mask='XX월'</C>
	<C>id='BASMAX1', left=106, top=553, right=175, bottom=606</C>
	<C>id='BASDAY1', left=28, top=553, right=97, bottom=606</C>
	<L> left=25 ,top=609 ,right=1900 ,bottom=609 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='계  산  내  역' ,left=1531 ,top=616 ,right=1800 ,bottom=669</T>
	<C>id='BAEAMT2', left=1188, top=616, right=1403, bottom=669, align='right'</C>
	<C>id='CMM2', left=1097, top=616, right=1175, bottom=669 ,mask='XX월'</C>
	<C>id='BASMAX2', left=1019, top=616, right=1084, bottom=669</C>
	<C>id='BAEDAY2', left=941, top=616, right=1009, bottom=669</C>
	<C>id='BASBUS2', left=716, top=616, right=931, bottom=669, align='right'</C>
	<C>id='BASAMT2', left=272, top=616, right=484, bottom=669, align='right'</C>
	<C>id='CMM2', left=184, top=616, right=263, bottom=669 ,mask='XX월'</C>
	<C>id='BASDAY2', left=28, top=616, right=97, bottom=669</C>
	<L> left=25 ,top=672 ,right=1903 ,bottom=672 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='BAEAMT3', left=1188, top=678, right=1403, bottom=731, align='right'</C>
	<C>id='CMM3', left=1097, top=678, right=1175, bottom=731 ,mask='XX월'</C>
	<C>id='BASMAX3', left=1019, top=678, right=1088, bottom=731</C>
	<C>id='BAEDAY3', left=941, top=678, right=1009, bottom=731</C>
	<C>id='BASBUS3', left=716, top=678, right=931, bottom=731, align='right'</C>
	<C>id='BASAMT3', left=272, top=678, right=484, bottom=731, align='right'</C>
	<C>id='CMM3', left=184, top=678, right=263, bottom=731 ,mask='XX월'</C>
	<C>id='BASDAY3', left=28, top=678, right=97, bottom=731</C>
	<C>id='AMTTXT', left=1619, top=678, right=1888, bottom=731, align='left'</C>
	<C>id='AVG_SUM', left=1428, top=678, right=1619, bottom=731, align='right'</C>
	<L> left=22 ,top=734 ,right=1900 ,bottom=734 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='BAEAMT4', left=1188, top=741, right=1403, bottom=794, align='right'</C>
	<C>id='CMM4', left=1097, top=741, right=1175, bottom=794 ,mask='XX월'</C>
	<C>id='BASMAX4', left=1019, top=741, right=1088, bottom=794</C>
	<C>id='BAEDAY4', left=941, top=741, right=1009, bottom=794</C>
	<C>id='BASBUS4', left=716, top=741, right=931, bottom=794, align='right'</C>
	<C>id='BASAMT4', left=272, top=741, right=484, bottom=794, align='right'</C>
	<C>id='CMM4', left=184, top=741, right=263, bottom=794 ,mask='XX월'</C>
	<C>id='BASDAY4', left=31, top=741, right=100, bottom=794</C>
	<L> left=25 ,top=797 ,right=1900 ,bottom=797 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='AVGYER', left=1188, top=803, right=1403, bottom=856, align='right'</C>
	<C>id='YEAQTY', left=272, top=803, right=484, bottom=856, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FFFBF0, backcolor=#FFFFFF</C>
	<L> left=25 ,top=859 ,right=1900 ,bottom=859 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='합계' ,left=38 ,top=866 ,right=259 ,bottom=919</T>
	<C>id='BASAMT_SUM', left=272, top=866, right=484, bottom=919, align='right'</C>
	<T>id='합계' ,left=944 ,top=866 ,right=1172 ,bottom=919</T>
	<C>id='BAEAMT_SUM', left=1188, top=866, right=1403, bottom=919, align='right'</C>
	<T>id='총  평  균  계' ,left=1531 ,top=866 ,right=1800 ,bottom=919</T>
	<L> left=22 ,top=922 ,right=1900 ,bottom=922 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='AVG_SUM', left=1494, top=928, right=1766, bottom=981, align='right'</C>
	<C>id='AVGETC', left=1188, top=928, right=1403, bottom=981, align='right'</C>
	<T>id='평        균' ,left=944 ,top=928 ,right=1172 ,bottom=981</T>
	<L> left=22 ,top=991 ,right=1900 ,bottom=991 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=469 ,right=22 ,bottom=991 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=469 ,right=1900 ,bottom=991 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=25 ,top=1056 ,right=1900 ,bottom=1056 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='기타' ,left=1425 ,top=1069 ,right=1644 ,bottom=1122</T>
	<T>id='연장수당' ,left=1188 ,top=1069 ,right=1406 ,bottom=1122</T>
	<T>id='임원직책수당' ,left=941 ,top=1069 ,right=1169 ,bottom=1122</T>
	<T>id='근속수당' ,left=41 ,top=1069 ,right=259 ,bottom=1122</T>
	<L> left=25 ,top=1125 ,right=1900 ,bottom=1125 </L>
	<C>id='PX0000', left=1428, top=1131, right=1644, bottom=1184, align='right'</C>
	<C>id='P21000', left=41, top=1131, right=259, bottom=1184, align='right'</C>
	<L> left=22 ,top=1194 ,right=1900 ,bottom=1194 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=266 ,top=1059 ,right=266 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=488 ,top=1059 ,right=488 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=709 ,top=1059 ,right=709 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1416 ,top=1059 ,right=1416 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1178 ,top=1059 ,right=1178 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=934 ,top=1059 ,right=934 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1900 ,top=1056 ,right=1900 ,bottom=1194 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=1059 ,right=22 ,bottom=1194 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='P38000', left=941, top=1131, right=1169, bottom=1184, align='right'</C>
	<T>id='지                  급   (A)' ,left=41 ,top=1278 ,right=925 ,bottom=1334</T>
	<T>id='공                  제   (B)' ,left=950 ,top=1278 ,right=1869 ,bottom=1334</T>
	<L> left=22 ,top=1266 ,right=1900 ,bottom=1266 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='4.퇴직금 정산내역' ,left=16 ,top=1206 ,right=925 ,bottom=1262 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=25 ,top=1344 ,right=1900 ,bottom=1344 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='적     요' ,left=950 ,top=1356 ,right=1169 ,bottom=1409</T>
	<T>id='확     인' ,left=716 ,top=1356 ,right=925 ,bottom=1409</T>
	<T>id='금               액' ,left=272 ,top=1356 ,right=706 ,bottom=1409</T>
	<T>id='적     요' ,left=41 ,top=1356 ,right=263 ,bottom=1409</T>
	<L> left=25 ,top=1412 ,right=1900 ,bottom=1412 </L>
	<T>id='근로소득정산' ,left=1425 ,top=1419 ,right=1884 ,bottom=1472</T>
	<T>id='퇴직소득정산' ,left=1188 ,top=1419 ,right=1406 ,bottom=1472</T>
	<C>id='JUSPAY', left=275, top=1419, right=638, bottom=1472, align='right'</C>
	<T>id='급     여' ,left=41 ,top=1419 ,right=263 ,bottom=1472</T>
	<L> left=25 ,top=1475 ,right=1900 ,bottom=1475 </L>
	<C>id='T21000', left=1528, top=1481, right=1856, bottom=1534, align='right'</C>
	<C>id='T23000', left=1209, top=1481, right=1406, bottom=1534, align='right'</C>
	<C>id='JUSBOS', left=275, top=1481, right=638, bottom=1534, align='right'</C>
	<T>id='상     여' ,left=41 ,top=1481 ,right=263 ,bottom=1534</T>
	<L> left=25 ,top=1537 ,right=1900 ,bottom=1537 </L>
	<C>id='T22000', left=1528, top=1544, right=1856, bottom=1597, align='right'</C>
	<C>id='T24000', left=1209, top=1544, right=1406, bottom=1597, align='right'</C>
	<C>id='JUSRET', left=278, top=1544, right=641, bottom=1597, align='right'</C>
	<T>id='퇴 직 금' ,left=44 ,top=1544 ,right=266 ,bottom=1597</T>
	<L> left=25 ,top=1600 ,right=1900 ,bottom=1600 </L>
	<L> left=1413 ,top=1412 ,right=1413 ,bottom=1600 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='P43000', left=1428, top=1606, right=1644, bottom=1659, align='right'</C>
	<C>id='JUSYER', left=275, top=1606, right=638, bottom=1659, align='right'</C>
	<T>id='년차수당' ,left=41 ,top=1606 ,right=263 ,bottom=1659</T>
	<L> left=25 ,top=1662 ,right=1900 ,bottom=1662 </L>
	<C>id='P41000', left=1428, top=1669, right=1644, bottom=1722, align='right'</C>
	<L> left=25 ,top=1725 ,right=1900 ,bottom=1725 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='P42000', left=1428, top=1731, right=1644, bottom=1784, align='right'</C>
	<L> left=22 ,top=1787 ,right=1900 ,bottom=1787 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='RETJUH', left=1428, top=1794, right=1644, bottom=1847, align='right'</C>
	<L> left=25 ,top=1850 ,right=1900 ,bottom=1850 </L>
	<C>id='BX0010', left=1428, top=1856, right=1644, bottom=1909, align='right'</C>
	<L> left=25 ,top=1912 ,right=1900 ,bottom=1912 </L>
	<C>id='BX0020', left=1428, top=1919, right=1644, bottom=1972, align='right'</C>
	<L> left=25 ,top=1975 ,right=1900 ,bottom=1975 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='BX0030', left=1428, top=1981, right=1644, bottom=2034, align='right'</C>
	<L> left=25 ,top=2037 ,right=1900 ,bottom=2037 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='S91000', left=272, top=1981, right=638, bottom=2034, align='right'</C>
	<T>id='합 계 (A)' ,left=41 ,top=1981 ,right=263 ,bottom=2034</T>
	<C>id='S93000', left=1428, top=2044, right=1644, bottom=2097, align='right'</C>
	<C>id='', left=272, top=2044, right=638, bottom=2097, align='right'</C>
	<T>id='퇴직급이체' ,left=41 ,top=2044 ,right=263 ,bottom=2097</T>
	<L> left=25 ,top=2106 ,right=1900 ,bottom=2106 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=266 ,top=1347 ,right=266 ,bottom=2106 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1178 ,top=1347 ,right=1178 ,bottom=2106 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1659 ,top=1603 ,right=1659 ,bottom=2106 ,penstyle=dot ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='S94000', left=1306, top=2119, right=1659, bottom=2175, align='right'</C>
	<T>id='차인지급액 (A-B)' ,left=1013 ,top=2119 ,right=1303 ,bottom=2175 ,align='left'</T>
	<T>id='5.반납확인' ,left=28 ,top=2119 ,right=609 ,bottom=2172 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=25 ,top=2181 ,right=1900 ,bottom=2181 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=25 ,top=2250 ,right=1900 ,bottom=2250 </L>
	<C>id='', left=716, top=2256, right=925, bottom=2309, align='right'</C>
	<C>id='', left=275, top=2256, right=706, bottom=2309, align='right'</C>
	<T>id='여권반납증' ,left=41 ,top=2256 ,right=259 ,bottom=2309</T>
	<L> left=22 ,top=2312 ,right=1900 ,bottom=2312 </L>
	<C>id='', left=1672, top=2319, right=1878, bottom=2375, align='right'</C>
	<C>id='', left=716, top=2319, right=925, bottom=2375, align='right'</C>
	<C>id='', left=275, top=2319, right=706, bottom=2375, align='right'</C>
	<T>id='회사신분증' ,left=41 ,top=2319 ,right=259 ,bottom=2372</T>
	<L> left=266 ,top=2184 ,right=266 ,bottom=2381 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=709 ,top=2184 ,right=709 ,bottom=2381 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='수     량' ,left=275 ,top=2194 ,right=706 ,bottom=2247</T>
	<T>id='확   인' ,left=716 ,top=2194 ,right=925 ,bottom=2247</T>
	<T>id='수    량' ,left=1194 ,top=2194 ,right=1656 ,bottom=2247</T>
	<L> left=1178 ,top=2184 ,right=1178 ,bottom=2381 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1659 ,top=2184 ,right=1659 ,bottom=2381 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=2384 ,right=1900 ,bottom=2384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='종  류' ,left=41 ,top=2194 ,right=259 ,bottom=2247</T>
	<L> left=113 ,top=2387 ,right=113 ,bottom=2603 </L>
	<T>id='재' ,left=38 ,top=2525 ,right=106 ,bottom=2578</T>
	<T>id='결' ,left=38 ,top=2422 ,right=106 ,bottom=2475</T>
	<T>id='담   당' ,left=131 ,top=2397 ,right=375 ,bottom=2450</T>
	<L> left=116 ,top=2453 ,right=1900 ,bottom=2453 </L>
	<L> left=25 ,top=2603 ,right=1900 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=1266 ,right=22 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=1266 ,right=1900 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=388 ,top=2387 ,right=388 ,bottom=2603 ,penstyle=dashdotdot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1488 ,top=2387 ,right=1488 ,bottom=2603 ,penstyle=dashdotdot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1178 ,top=2387 ,right=1178 ,bottom=2603 ,penstyle=dashdotdot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=2387 ,right=906 ,bottom=2603 ,penstyle=dashdotdot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=631 ,top=2387 ,right=631 ,bottom=2603 ,penstyle=dashdotdot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='퇴  사  통  보' ,left=653 ,top=3 ,right=1331 ,bottom=94 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=934 ,top=1269 ,right=934 ,bottom=2384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='BASMAX2', left=106, top=616, right=175, bottom=669</C>
	<C>id='BASMAX3', left=106, top=678, right=175, bottom=731</C>
	<C>id='BASMAX4', left=106, top=741, right=175, bottom=794</C>
	<T>id='년차일수' ,left=38 ,top=803 ,right=259 ,bottom=856 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<T>id='평        균' ,left=38 ,top=928 ,right=259 ,bottom=981</T>
	<C>id='AVGAMT', left=272, top=928, right=484, bottom=981, align='right'</C>
	<T>id='자기계발비' ,left=272 ,top=1069 ,right=484 ,bottom=1122</T>
	<C>id='P22000', left=272, top=1131, right=484, bottom=1184, align='right'</C>
	<C>id='REF2', left=494, top=616, right=706, bottom=669</C>
	<C>id='REF3', left=494, top=678, right=706, bottom=731</C>
	<C>id='REF4', left=494, top=741, right=706, bottom=794</C>
	<T>id='년차수당' ,left=494 ,top=803 ,right=706 ,bottom=856</T>
	<T>id='합계' ,left=494 ,top=866 ,right=706 ,bottom=919</T>
	<T>id='평        균' ,left=494 ,top=928 ,right=706 ,bottom=981</T>
	<C>id='YEAPAY', left=716, top=803, right=931, bottom=856, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FFFBF0, backcolor=#FFFFFF</C>
	<C>id='BASBUS_SUM', left=716, top=866, right=931, bottom=919, align='right'</C>
	<C>id='AVGBOS', left=716, top=928, right=931, bottom=981, align='right'</C>
	<T>id='평균년차수당' ,left=944 ,top=803 ,right=1166 ,bottom=856 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<T>id='3.기타수당 내역' ,left=16 ,top=1000 ,right=597 ,bottom=1053 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P24000', left=494, top=1131, right=706, bottom=1184, align='right'</C>
	<T>id='차량유지비' ,left=494 ,top=1069 ,right=706 ,bottom=1122</T>
	<T>id='남북경협수당' ,left=716 ,top=1069 ,right=931 ,bottom=1122</T>
	<C>id='P29000', left=716, top=1131, right=931, bottom=1184, align='right'</C>
	<C>id='P27000', left=1188, top=1131, right=1406, bottom=1184, align='right'</C>
	<L> left=1647 ,top=1059 ,right=1647 ,bottom=1194 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='검   토' ,left=403 ,top=2397 ,right=622 ,bottom=2450</T>
	<T>id='부 서 장' ,left=650 ,top=2397 ,right=894 ,bottom=2450</T>
	<T>id='사   장' ,left=1506 ,top=2397 ,right=1875 ,bottom=2450</T>
	<T>id='본 부 장' ,left=1213 ,top=2397 ,right=1456 ,bottom=2450</T>
	<T>id='중   역' ,left=919 ,top=2397 ,right=1163 ,bottom=2450</T>
	<T>id='합계 (B)' ,left=950 ,top=2044 ,right=1169 ,bottom=2097</T>
	<T>id='기  타3' ,left=950 ,top=1981 ,right=1169 ,bottom=2034</T>
	<T>id='기  타2' ,left=950 ,top=1919 ,right=1169 ,bottom=1972</T>
	<T>id='기  타1' ,left=950 ,top=1856 ,right=1169 ,bottom=1909</T>
	<T>id='퇴직전환금' ,left=950 ,top=1794 ,right=1169 ,bottom=1847</T>
	<T>id='고용보험' ,left=950 ,top=1731 ,right=1169 ,bottom=1784</T>
	<T>id='건강보험' ,left=950 ,top=1669 ,right=1169 ,bottom=1722</T>
	<T>id='국민연금' ,left=950 ,top=1606 ,right=1169 ,bottom=1659</T>
	<T>id='주 민 세' ,left=950 ,top=1544 ,right=1169 ,bottom=1597</T>
	<T>id='갑 근 세' ,left=950 ,top=1481 ,right=1169 ,bottom=1534</T>
	<T>id='확     인' ,left=1669 ,top=1356 ,right=1888 ,bottom=1409</T>
	<L> left=1659 ,top=1347 ,right=1659 ,bottom=1412 ,penstyle=dot ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='금               액' ,left=1188 ,top=1356 ,right=1647 ,bottom=1409</T>
	<C>id='', left=1194, top=2256, right=1656, bottom=2309, align='right'</C>
	<C>id='', left=1194, top=2319, right=1656, bottom=2375, align='right'</C>
	<T>id='기   타' ,left=950 ,top=2319 ,right=1169 ,bottom=2372</T>
	<T>id='건강보험증' ,left=950 ,top=2256 ,right=1169 ,bottom=2309</T>
	<T>id='종   류' ,left=950 ,top=2194 ,right=1169 ,bottom=2247</T>
	<C>id='', left=1672, top=2256, right=1878, bottom=2309, align='right'</C>
	<T>id='확   인' ,left=1672 ,top=2194 ,right=1881 ,bottom=2247</T>
	<L> left=100 ,top=544 ,right=100 ,bottom=797 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=178 ,top=544 ,right=178 ,bottom=794 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=266 ,top=544 ,right=266 ,bottom=987 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=488 ,top=469 ,right=488 ,bottom=991 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=709 ,top=544 ,right=709 ,bottom=987 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=709 ,top=1347 ,right=709 ,bottom=2106 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=934 ,top=469 ,right=934 ,bottom=991 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1013 ,top=544 ,right=1013 ,bottom=794 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1091 ,top=544 ,right=1091 ,bottom=794 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1178 ,top=544 ,right=1178 ,bottom=987 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1416 ,top=469 ,right=1416 ,bottom=991 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2770 ,right=2000 ,bottom=2870 ,face='굴림' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=9 ,top=19 ,right=1988 ,bottom=97</T>
	<I>id='../../Common/img/icon.jpg' ,left=1591 ,top=0 ,right=1972 ,bottom=94</I>
	<L> left=19 ,top=0 ,right=1966 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분 - 퇴직소득원천징수영수증
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<!-- <PARAM NAME="MasterDataID"			VALUE="gcds_report0"> -->
	<param name="DetailDataID"	value="gcds_report0">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2740 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1397 ,top=1616 ,right=1903 ,bottom=1685 ,backcolor=#C0C0C0 ,border=true</X>
	<X>left=459 ,top=203 ,right=500 ,bottom=244 ,border=true</X>
	<X>left=53 ,top=147 ,right=381 ,bottom=244 ,border=true</X>
	<L> left=6 ,top=125 ,right=1903 ,bottom=125 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1334 ,top=150 ,right=1900 ,bottom=150 </L>
	<T>id='관리' ,left=59 ,top=156 ,right=172 ,bottom=194 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=59 ,top=197 ,right=172 ,bottom=234 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=178 ,top=147 ,right=178 ,bottom=241 </L>
	<T>id='퇴직소득원천징수영수증/지급조서' ,left=522 ,top=184 ,right=1297 ,bottom=262 ,align='left' ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=6 ,top=2491 ,right=1903 ,bottom=2491 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='1. 거주지국과 거주지국코드는 외국인에 해당하는 경우에 한하여 기재하며, 국제표준화기구(ISO)가 정한 ISO코드 중 국명약어 및 국가코드를 기재합니다.' ,left=13 ,top=2316 ,right=1897 ,bottom=2347 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 원천징수의무자는 지급일이 속하는 연도의 다음 연도 2월말일(휴업 또는 폐업한 경우에는 ' ,left=13 ,top=2350 ,right=1897 ,bottom=2381 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    휴업일 또는 폐업일이 속하는 달의 다음 달 말일)까지 지급조서를 제출함.' ,left=13 ,top=2384 ,right=1897 ,bottom=2416 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 14)란에는 공무원의 경우는 명예퇴직수당을 기재하며, 근로기준법 제31조의 규정에 의한 퇴직자의 경우는 통상 퇴직금외 추가로 받는 퇴직급여를 기재합니다.' ,left=13 ,top=2419 ,right=1897 ,bottom=2450 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 31)차감 원천징수세액이 소액부징수에 해당하는 경우 \'0\'으로 기재합니다.' ,left=13 ,top=2453 ,right=1897 ,bottom=2484 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위의 원천징수액(근로소득)을 영수(지급)합니다.' ,left=588 ,top=2044 ,right=1563 ,bottom=2091 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=1156, top=2106, right=1563, bottom=2150, align='right' ,mask='XXXX년 XX월 XX일', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='징수(보고)의무자' ,left=663 ,top=2172 ,right=1016 ,bottom=2216 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=1038, top=2172, right=1263, bottom=2216, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(서명 또는 인)' ,left=1294 ,top=2172 ,right=1563 ,bottom=2216 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='귀하' ,left=1297 ,top=2259 ,right=1566 ,bottom=2303 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=6 ,top=2309 ,right=1903 ,bottom=2309 </L>
	<L> left=6 ,top=125 ,right=6 ,bottom=2491 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1903 ,top=125 ,right=1903 ,bottom=2491 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=6 ,top=2028 ,right=1906 ,bottom=2028 </L>
	<T>id='31)차감원천징수세액(29-30)' ,left=116 ,top=1966 ,right=641 ,bottom=2025 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AMT08', left=653, top=1966, right=928, bottom=2025, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT11', left=938, top=1966, right=1213, bottom=2025, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1222, top=1966, right=1497, bottom=2025, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT12', left=1506, top=1966, right=1897, bottom=2025, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=103 ,top=1959 ,right=1903 ,bottom=1959 </L>
	<C>id='AMT10', left=1506, top=1897, right=1897, bottom=1956, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1222, top=1897, right=1497, bottom=1956, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_T2400', left=938, top=1897, right=1213, bottom=1956, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_T2300', left=653, top=1897, right=928, bottom=1956, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='30)종(전)근무지 기납부세액' ,left=116 ,top=1897 ,right=641 ,bottom=1956 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=1891 ,right=1903 ,bottom=1891 </L>
	<C>id='AMT09', left=1506, top=1828, right=1897, bottom=1887, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1222, top=1828, right=1497, bottom=1887, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='T24000', left=938, top=1828, right=1213, bottom=1887, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='29)결정세액 (28)' ,left=116 ,top=1828 ,right=641 ,bottom=1887 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='T23000', left=653, top=1828, right=928, bottom=1887, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=103 ,top=1822 ,right=1903 ,bottom=1822 </L>
	<T>id='구     분' ,left=116 ,top=1759 ,right=641 ,bottom=1819 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=9 ,top=1753 ,right=1903 ,bottom=1753 </L>
	<T>id='소득세' ,left=653 ,top=1759 ,right=928 ,bottom=1819 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1506 ,top=1759 ,right=1897 ,bottom=1819 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='농어촌특별세' ,left=1222 ,top=1759 ,right=1497 ,bottom=1819 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=938 ,top=1759 ,right=1213 ,bottom=1819 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납' ,left=13 ,top=1769 ,right=100 ,bottom=1825 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부' ,left=13 ,top=1831 ,right=100 ,bottom=1887 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=13 ,top=1894 ,right=100 ,bottom=1950 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=13 ,top=1956 ,right=100 ,bottom=2012 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='24)연평균과세표준(23÷20)' ,left=116 ,top=1691 ,right=641 ,bottom=1750 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AMT02', left=653, top=1691, right=1044, bottom=1750, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='28)결정세액(26-27)' ,left=1056 ,top=1691 ,right=1394 ,bottom=1750 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AMT04', left=1406, top=1691, right=1897, bottom=1750, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=103 ,top=1684 ,right=1903 ,bottom=1684 </L>
	<C>id='T21000', left=1409, top=1628, right=1894, bottom=1678, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='23)퇴직소득과세표준' ,left=116 ,top=1622 ,right=641 ,bottom=1681 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=1616 ,right=1903 ,bottom=1616 </L>
	<T>id='22)퇴직소득공제' ,left=116 ,top=1553 ,right=641 ,bottom=1612 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=1547 ,right=1903 ,bottom=1547 </L>
	<T>id='21)퇴직급여액' ,left=116 ,top=1484 ,right=641 ,bottom=1544 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)세액공제' ,left=1056 ,top=1622 ,right=1394 ,bottom=1681 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91STD', left=653, top=1622, right=1044, bottom=1681, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT03', left=1406, top=1553, right=1897, bottom=1612, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='26)산출세액(25×20)' ,left=1056 ,top=1553 ,right=1394 ,bottom=1612 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91AMT', left=653, top=1553, right=1044, bottom=1612, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='T91AMT', left=1406, top=1484, right=1897, bottom=1544, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='25)연평균산출세액' ,left=1056 ,top=1484 ,right=1394 ,bottom=1544 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91000', left=653, top=1484, right=1044, bottom=1544, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=6 ,top=1478 ,right=1906 ,bottom=1478 </L>
	<L> left=103 ,top=1478 ,right=103 ,bottom=2028 </L>
	<T>id='제' ,left=13 ,top=1684 ,right=100 ,bottom=1741 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=13 ,top=1622 ,right=100 ,bottom=1678 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=13 ,top=1559 ,right=100 ,bottom=1616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=13 ,top=1497 ,right=100 ,bottom=1553 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)종(현)근무지' ,left=272 ,top=1416 ,right=641 ,bottom=1475 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=266 ,top=1409 ,right=1906 ,bottom=1409 </L>
	<L> left=266 ,top=1341 ,right=1906 ,bottom=1341 </L>
	<T>id='17)주(현)근무지' ,left=272 ,top=1347 ,right=641 ,bottom=1406 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무지구분' ,left=272 ,top=1278 ,right=641 ,bottom=1337 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속연수(20)' ,left=1641 ,top=1278 ,right=1897 ,bottom=1337 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='중복월수(19)' ,left=1406 ,top=1278 ,right=1625 ,bottom=1337 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속월수' ,left=1175 ,top=1278 ,right=1391 ,bottom=1337 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴사연월일' ,left=947 ,top=1278 ,right=1163 ,bottom=1337 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입사연월일' ,left=653 ,top=1278 ,right=931 ,bottom=1337 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DUYEAR1', left=1641, top=1347, right=1897, bottom=1406, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1406, top=1347, right=1625, bottom=1406, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT07', left=1175, top=1347, right=1391, bottom=1406, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=947, top=1347, right=1163, bottom=1406, align='right' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='STRTDT', left=653, top=1347, right=931, bottom=1406, align='right' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Column', left=1641, top=1416, right=1897, bottom=1475, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1406, top=1416, right=1625, bottom=1475, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_DUYEAR', left=1175, top=1416, right=1391, bottom=1475, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_ENDDT', left=947, top=1416, right=1163, bottom=1475, align='right' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='J_STRTDT', left=653, top=1416, right=931, bottom=1475, align='right' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1397 ,top=1478 ,right=1397 ,bottom=1753 </L>
	<L> left=1050 ,top=1481 ,right=1050 ,bottom=1753 </L>
	<L> left=6 ,top=1272 ,right=1906 ,bottom=1272 </L>
	<T>id='근속 연수' ,left=13 ,top=1278 ,right=263 ,bottom=1475 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=1203 ,right=1906 ,bottom=1203 </L>
	<T>id='16)계' ,left=116 ,top=1209 ,right=641 ,bottom=1269 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AMT06', left=1531, top=1209, right=1897, bottom=1269, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1238, top=1209, right=1516, bottom=1269, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT01', left=947, top=1209, right=1225, bottom=1269, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S91000', left=653, top=1209, right=931, bottom=1269, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1531, top=1141, right=1897, bottom=1200, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1238, top=1141, right=1516, bottom=1200, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_RAT', left=947, top=1141, right=1225, bottom=1200, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=653, top=1141, right=931, bottom=1200, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='15)퇴직보험금 등' ,left=116 ,top=1141 ,right=641 ,bottom=1200 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1169 ,top=1275 ,right=1169 ,bottom=1478 </L>
	<L> left=1397 ,top=1275 ,right=1397 ,bottom=1478 </L>
	<L> left=1631 ,top=1272 ,right=1631 ,bottom=1475 </L>
	<L> left=106 ,top=1134 ,right=1906 ,bottom=1134 </L>
	<T>id='14)명예퇴직수당(추가퇴직금)' ,left=116 ,top=1072 ,right=641 ,bottom=1131 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=1066 ,right=1906 ,bottom=1066 </L>
	<T>id='13)퇴직급여' ,left=116 ,top=1003 ,right=641 ,bottom=1062 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=997 ,right=1906 ,bottom=997 </L>
	<T>id='12)사업자등록번호' ,left=116 ,top=934 ,right=641 ,bottom=994 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=928 ,right=1906 ,bottom=928 </L>
	<T>id='11)지급처명' ,left=116 ,top=866 ,right=641 ,bottom=925 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=859 ,right=1906 ,bottom=859 </L>
	<L> left=6 ,top=791 ,right=1903 ,bottom=791 </L>
	<L> left=106 ,top=794 ,right=106 ,bottom=1272 </L>
	<T>id='세' ,left=13 ,top=1194 ,right=103 ,bottom=1241 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=13 ,top=1141 ,right=103 ,bottom=1187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=13 ,top=1087 ,right=103 ,bottom=1134 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=13 ,top=1034 ,right=103 ,bottom=1081 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=13 ,top=981 ,right=103 ,bottom=1028 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='처' ,left=13 ,top=928 ,right=103 ,bottom=975 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=13 ,top=875 ,right=103 ,bottom=922 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지' ,left=13 ,top=822 ,right=103 ,bottom=869 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=1531, top=1072, right=1897, bottom=1131, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1238, top=1072, right=1516, bottom=1131, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_MUN', left=947, top=1072, right=1225, bottom=1131, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=653, top=1072, right=931, bottom=1131, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT05', left=1531, top=1003, right=1897, bottom=1062, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1238, top=1003, right=1516, bottom=1062, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_AMT', left=947, top=1003, right=1225, bottom=1062, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S91000', left=653, top=1003, right=931, bottom=1062, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1531, top=934, right=1897, bottom=994, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1238, top=934, right=1516, bottom=994, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_SAP', left=947, top=934, right=1225, bottom=994, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_SAP', left=653, top=934, right=931, bottom=994, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1531, top=866, right=1897, bottom=925, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=1238, top=866, right=1516, bottom=925, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_CMP', left=947, top=866, right=1225, bottom=925, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='J_CMP', left=653, top=866, right=931, bottom=925, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='합  계' ,left=1531 ,top=797 ,right=1897 ,bottom=856 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(103) 종(전)' ,left=1238 ,top=797 ,right=1516 ,bottom=856 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(102) 종(전)' ,left=947 ,top=797 ,right=1225 ,bottom=856 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(101) 주(현)' ,left=653 ,top=797 ,right=931 ,bottom=856 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=266 ,top=1272 ,right=266 ,bottom=1478 </L>
	<L> left=647 ,top=794 ,right=647 ,bottom=2028 </L>
	<L> left=938 ,top=791 ,right=938 ,bottom=1478 </L>
	<L> left=1228 ,top=794 ,right=1228 ,bottom=1272 </L>
	<L> left=1522 ,top=794 ,right=1522 ,bottom=1272 </L>
	<T>id='10)지급처구분' ,left=116 ,top=797 ,right=641 ,bottom=856 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑨귀 속 연 도' ,left=13 ,top=728 ,right=494 ,bottom=787 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='까지' ,left=1081 ,top=728 ,right=1156 ,bottom=787 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENDDT', left=869, top=728, right=1075, bottom=787, align='right' ,mask='XXXX년', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='부터' ,left=781 ,top=728 ,right=856 ,bottom=787 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='STRTDT', left=569, top=728, right=775, bottom=787, align='right' ,mask='XXXX년', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=6 ,top=722 ,right=1903 ,bottom=722 </L>
	<L> left=1169 ,top=725 ,right=1169 ,bottom=791 </L>
	<C>id='CADDR', left=506, top=659, right=1897, bottom=719, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='⑧주   소' ,left=197 ,top=659 ,right=494 ,bottom=719 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=188 ,top=653 ,right=1903 ,bottom=653 </L>
	<T>id='⑥성   명' ,left=197 ,top=591 ,right=494 ,bottom=650 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1366, top=591, right=1897, bottom=650, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='⑦주민등록번호' ,left=966 ,top=591 ,right=1356 ,bottom=650 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=506, top=591, right=956, bottom=650, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=6 ,top=584 ,right=1903 ,bottom=584 </L>
	<T>id='소득자' ,left=16 ,top=591 ,right=181 ,bottom=719 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=959 ,top=587 ,right=959 ,bottom=650 </L>
	<L> left=1359 ,top=587 ,right=1359 ,bottom=650 </L>
	<L> left=188 ,top=516 ,right=1903 ,bottom=516 </L>
	<T>id='⑤소 재 지(주소)' ,left=197 ,top=522 ,right=494 ,bottom=581 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③대 표 자(성명)' ,left=197 ,top=453 ,right=494 ,bottom=512 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=188 ,top=447 ,right=1903 ,bottom=447 </L>
	<T>id='①사업자등록번호' ,left=197 ,top=384 ,right=494 ,bottom=444 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=6 ,top=378 ,right=1903 ,bottom=378 </L>
	<T>id='의무자' ,left=22 ,top=487 ,right=178 ,bottom=534 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징   수' ,left=22 ,top=434 ,right=178 ,bottom=481 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=188 ,top=381 ,right=188 ,bottom=722 </L>
	<T>id='④주민(법인)등록번호' ,left=966 ,top=453 ,right=1356 ,bottom=512 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='②법인명(상호)' ,left=966 ,top=384 ,right=1356 ,bottom=444 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=959 ,top=381 ,right=959 ,bottom=512 </L>
	<L> left=1359 ,top=381 ,right=1359 ,bottom=512 </L>
	<L> left=1334 ,top=209 ,right=1906 ,bottom=209 </L>
	<T>id='거주구분' ,left=1341 ,top=156 ,right=1584 ,bottom=206 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비거주자2' ,left=1753 ,top=156 ,right=1900 ,bottom=206 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1725 ,top=156 ,right=1753 ,bottom=206 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자1' ,left=1597 ,top=156 ,right=1725 ,bottom=206 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외국인' ,left=1341 ,top=216 ,right=1584 ,bottom=266 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인9' ,left=1753 ,top=216 ,right=1900 ,bottom=266 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1725 ,top=216 ,right=1753 ,bottom=266 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내국인1' ,left=1597 ,top=216 ,right=1725 ,bottom=266 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1334 ,top=272 ,right=1906 ,bottom=272 </L>
	<L> left=1591 ,top=150 ,right=1591 ,bottom=272 </L>
	<L> left=1334 ,top=150 ,right=1334 ,bottom=334 </L>
	<T>id='거주지국' ,left=1341 ,top=278 ,right=1478 ,bottom=328 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1334 ,top=334 ,right=1906 ,bottom=334 </L>
	<L> left=1484 ,top=275 ,right=1484 ,bottom=334 </L>
	<L> left=1791 ,top=275 ,right=1791 ,bottom=334 </L>
	<T>id='거주지국코드' ,left=1597 ,top=278 ,right=1784 ,bottom=328 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=497 ,top=381 ,right=497 ,bottom=791 </L>
	<L> left=931 ,top=1756 ,right=931 ,bottom=2028 </L>
	<L> left=1500 ,top=1756 ,right=1500 ,bottom=2028 </L>
	<L> left=1216 ,top=1756 ,right=1216 ,bottom=2028 </L>
	<L> left=1591 ,top=275 ,right=1591 ,bottom=334 </L>
	<T>id='101-85-10695' ,left=506 ,top=384 ,right=956 ,bottom=444 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='윤만준' ,left=506 ,top=453 ,right=956 ,bottom=512 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서울 종로구 계동 140-2' ,left=506 ,top=522 ,right=1897 ,bottom=581 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산주식회사' ,left=1366 ,top=384 ,right=1897 ,bottom=444 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1366 ,top=453 ,right=1897 ,bottom=512 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HTITLE', left=600, top=281, right=1063, bottom=353, face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 II : 근로소득원천징수영수증 REPORT
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report3">
	<!-- <PARAM NAME="DetailDataID"			VALUE="gcds_print"> -->
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2657 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1066 ,top=1266 ,right=1184 ,bottom=1569 ,border=true</X>
	<X>left=122 ,top=1684 ,right=303 ,bottom=1762 ,border=true</X>
	<X>left=22 ,top=1609 ,right=125 ,bottom=1806 ,border=true</X>
	<X>left=1066 ,top=1116 ,right=1184 ,bottom=1269 ,border=true</X>
	<X>left=1066 ,top=778 ,right=1184 ,bottom=1041 ,border=true</X>
	<X>left=172 ,top=1228 ,right=281 ,bottom=1569 ,border=true</X>
	<X>left=172 ,top=1003 ,right=281 ,bottom=1156 ,border=true</X>
	<X>left=172 ,top=891 ,right=281 ,bottom=1006 ,border=true</X>
	<X>left=122 ,top=891 ,right=175 ,bottom=1569 ,border=true</X>
	<X>left=22 ,top=778 ,right=125 ,bottom=1612 ,border=true</X>
	<X>left=22 ,top=437 ,right=125 ,bottom=706 ,border=true</X>
	<X>left=22 ,top=319 ,right=209 ,bottom=400 ,border=true</X>
	<X>left=22 ,top=206 ,right=209 ,bottom=322 ,border=true</X>
	<X>left=69 ,top=25 ,right=397 ,bottom=122 ,border=true</X>
	<T>id='(연말정산용)' ,left=634 ,top=81 ,right=1050 ,bottom=128 ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1441 ,top=397 ,right=1441 ,bottom=437 </L>
	<L> left=206 ,top=247 ,right=1953 ,bottom=247 </L>
	<L> left=22 ,top=1991 ,right=1950 ,bottom=1991 </L>
	<L> left=22 ,top=1953 ,right=1950 ,bottom=1953 </L>
	<L> left=1697 ,top=1609 ,right=1697 ,bottom=1803 </L>
	<L> left=1181 ,top=1153 ,right=1950 ,bottom=1153 </L>
	<L> left=1181 ,top=1191 ,right=1950 ,bottom=1191 </L>
	<L> left=1181 ,top=1228 ,right=1950 ,bottom=1228 </L>
	<L> left=1181 ,top=1303 ,right=1950 ,bottom=1303 </L>
	<L> left=1181 ,top=1341 ,right=1950 ,bottom=1341 </L>
	<L> left=1181 ,top=1378 ,right=1950 ,bottom=1378 </L>
	<L> left=1181 ,top=1416 ,right=1950 ,bottom=1416 </L>
	<L> left=1181 ,top=1453 ,right=1950 ,bottom=1453 </L>
	<L> left=1181 ,top=1491 ,right=1950 ,bottom=1491 </L>
	<L> left=1181 ,top=1528 ,right=1950 ,bottom=1528 </L>
	<L> left=1181 ,top=853 ,right=1953 ,bottom=853 </L>
	<L> left=1181 ,top=891 ,right=1953 ,bottom=891 </L>
	<L> left=1181 ,top=928 ,right=1953 ,bottom=928 </L>
	<L> left=1181 ,top=966 ,right=1953 ,bottom=966 </L>
	<L> left=1181 ,top=1003 ,right=1953 ,bottom=1003 </L>
	<L> left=1181 ,top=1041 ,right=1953 ,bottom=1041 </L>
	<L> left=184 ,top=1228 ,right=1066 ,bottom=1228 </L>
	<L> left=172 ,top=1191 ,right=1066 ,bottom=1191 </L>
	<L> left=278 ,top=1153 ,right=1066 ,bottom=1153 </L>
	<L> left=1181 ,top=437 ,right=1181 ,bottom=775 </L>
	<L> left=688 ,top=1841 ,right=688 ,bottom=1991 </L>
	<T>id='67)차감징수세액' ,left=131 ,top=1766 ,right=656 ,bottom=1800 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='66)주(현)근무지' ,left=309 ,top=1725 ,right=656 ,bottom=1759 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='65)종(전)근무지' ,left=309 ,top=1687 ,right=656 ,bottom=1722 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='64)결정세액' ,left=131 ,top=1650 ,right=656 ,bottom=1684 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='42)차감소득공제' ,left=131 ,top=1572 ,right=656 ,bottom=1606 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구   분' ,left=131 ,top=1612 ,right=656 ,bottom=1647 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='33)보험료' ,left=288 ,top=1231 ,right=656 ,bottom=1266 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='34)의료비' ,left=288 ,top=1269 ,right=656 ,bottom=1303 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='35)교육비' ,left=288 ,top=1306 ,right=656 ,bottom=1341 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='36)주택자금' ,left=288 ,top=1344 ,right=656 ,bottom=1378 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='37)기부금' ,left=288 ,top=1381 ,right=656 ,bottom=1416 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='38)혼인,이사,장례비' ,left=288 ,top=1419 ,right=656 ,bottom=1453 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='39)' ,left=288 ,top=1456 ,right=656 ,bottom=1491 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='40)계' ,left=288 ,top=1494 ,right=656 ,bottom=1528 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='41)표준공제' ,left=288 ,top=1531 ,right=656 ,bottom=1566 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=278 ,top=1528 ,right=1066 ,bottom=1528 </L>
	<L> left=278 ,top=1491 ,right=1066 ,bottom=1491 </L>
	<L> left=278 ,top=1453 ,right=1066 ,bottom=1453 </L>
	<L> left=278 ,top=1416 ,right=1066 ,bottom=1416 </L>
	<L> left=278 ,top=1378 ,right=1066 ,bottom=1378 </L>
	<L> left=278 ,top=1341 ,right=1066 ,bottom=1341 </L>
	<L> left=278 ,top=1566 ,right=1953 ,bottom=1566 </L>
	<L> left=278 ,top=1303 ,right=1066 ,bottom=1303 </L>
	<L> left=278 ,top=1266 ,right=1953 ,bottom=1266 </L>
	<T>id='23)근로소득금액' ,left=131 ,top=856 ,right=656 ,bottom=891 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=500, top=1119, right=656, bottom=1153 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='30)자녀양육비' ,left=288 ,top=1119 ,right=494 ,bottom=1153 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='28)장 애 인' ,left=288 ,top=1044 ,right=494 ,bottom=1078 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='27)경로우대' ,left=288 ,top=1006 ,right=494 ,bottom=1041 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='26)부양가족' ,left=288 ,top=969 ,right=494 ,bottom=1003 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='25)배우자' ,left=288 ,top=931 ,right=656 ,bottom=966 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='29)부녀자' ,left=288 ,top=1081 ,right=656 ,bottom=1116 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='24)본   인' ,left=288 ,top=894 ,right=656 ,bottom=928 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=278 ,top=1116 ,right=1128 ,bottom=1116 </L>
	<L> left=278 ,top=1078 ,right=1953 ,bottom=1078 </L>
	<L> left=278 ,top=1041 ,right=1066 ,bottom=1041 </L>
	<L> left=278 ,top=1003 ,right=1066 ,bottom=1003 </L>
	<L> left=278 ,top=966 ,right=1066 ,bottom=966 </L>
	<L> left=278 ,top=928 ,right=1066 ,bottom=928 </L>
	<T>id='22)근로소득공제' ,left=131 ,top=819 ,right=656 ,bottom=853 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='21)총 급 여(16)' ,left=131 ,top=781 ,right=656 ,bottom=816 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=288, top=744, right=656, bottom=778, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=281 ,top=703 ,right=281 ,bottom=778 </L>
	<T>id='공제' ,left=194 ,top=953 ,right=259 ,bottom=991 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=128 ,top=1475 ,right=169 ,bottom=1512 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금' ,left=128 ,top=1387 ,right=169 ,bottom=1425 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=128 ,top=1300 ,right=169 ,bottom=1337 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=128 ,top=1212 ,right=169 ,bottom=1250 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합' ,left=128 ,top=1125 ,right=169 ,bottom=1162 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)근무처명' ,left=131 ,top=481 ,right=656 ,bottom=516 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)사업자등록번호' ,left=131 ,top=519 ,right=656 ,bottom=553 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)급   여' ,left=131 ,top=556 ,right=656 ,bottom=591 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)상   여' ,left=131 ,top=594 ,right=656 ,bottom=628 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1341 ,top=1841 ,right=1341 ,bottom=1991 </L>
	<L> left=1434 ,top=1841 ,right=1434 ,bottom=1991 </L>
	<L> left=1622 ,top=1841 ,right=1622 ,bottom=1991 </L>
	<L> left=313 ,top=1841 ,right=313 ,bottom=1991 </L>
	<L> left=681 ,top=1841 ,right=681 ,bottom=1991 </L>
	<L> left=781 ,top=1841 ,right=781 ,bottom=1991 </L>
	<L> left=972 ,top=1841 ,right=972 ,bottom=1991 </L>
	<L> left=119 ,top=1841 ,right=119 ,bottom=1991 </L>
	<T>id='성   명' ,left=1441 ,top=1844 ,right=1616 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=1347 ,top=1844 ,right=1428 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=1628 ,top=1844 ,right=1947 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=694 ,top=1844 ,right=778 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성   명' ,left=788 ,top=1844 ,right=966 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=978 ,top=1844 ,right=1334 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=22 ,top=1916 ,right=1950 ,bottom=1916 </L>
	<L> left=22 ,top=1878 ,right=1953 ,bottom=1878 </L>
	<T>id='관계' ,left=31 ,top=1844 ,right=116 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성   명' ,left=128 ,top=1844 ,right=309 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=319 ,top=1844 ,right=675 ,bottom=1878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='69)부양가족공제자 명세 [당해 소득자의 주민등록표등본상에 등재되지 아니함에도, 기본공제 또는 주가공제를 받는 지를 기재합니다.]' ,left=25 ,top=1806 ,right=1944 ,bottom=1837 ,align='left' ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=22 ,top=1841 ,right=1950 ,bottom=1841 </L>
	<L> left=1416 ,top=1609 ,right=1416 ,bottom=1803 </L>
	<L> left=1213 ,top=1609 ,right=1213 ,bottom=1803 </L>
	<L> left=938 ,top=1609 ,right=938 ,bottom=1803 </L>
	<L> left=663 ,top=397 ,right=663 ,bottom=1803 </L>
	<L> left=122 ,top=1803 ,right=1953 ,bottom=1803 </L>
	<T>id='세' ,left=28 ,top=1750 ,right=119 ,bottom=1787 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=28 ,top=1706 ,right=119 ,bottom=1744 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=28 ,top=1662 ,right=119 ,bottom=1700 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=28 ,top=1622 ,right=119 ,bottom=1659 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세   액' ,left=131 ,top=1725 ,right=297 ,bottom=1756 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기납부' ,left=131 ,top=1691 ,right=297 ,bottom=1722 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1713 ,top=1762 ,right=1931 ,bottom=1762 </L>
	<L> left=300 ,top=1759 ,right=1697 ,bottom=1759 </L>
	<L> left=300 ,top=1722 ,right=1697 ,bottom=1722 </L>
	<L> left=122 ,top=1684 ,right=1953 ,bottom=1684 </L>
	<L> left=122 ,top=1647 ,right=1697 ,bottom=1647 </L>
	<L> left=1588 ,top=703 ,right=1588 ,bottom=1609 </L>
	<T>id='농어촌특별세' ,left=1222 ,top=1612 ,right=1409 ,bottom=1647 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1422 ,top=1612 ,right=1691 ,bottom=1647 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=669 ,top=1612 ,right=931 ,bottom=1647 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=944 ,top=1612 ,right=1206 ,bottom=1647 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=1078 ,top=1475 ,right=1172 ,bottom=1525 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=1078 ,top=1419 ,right=1172 ,bottom=1469 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=1078 ,top=1362 ,right=1172 ,bottom=1412 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=1078 ,top=1309 ,right=1172 ,bottom=1359 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=1075 ,top=1128 ,right=1175 ,bottom=1159 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=1075 ,top=1162 ,right=1175 ,bottom=1194 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감' ,left=1075 ,top=1194 ,right=1175 ,bottom=1225 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='면' ,left=1075 ,top=1225 ,right=1175 ,bottom=1256 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=122 ,top=1609 ,right=1953 ,bottom=1609 </L>
	<T>id='제' ,left=178 ,top=1469 ,right=272 ,bottom=1537 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=178 ,top=1394 ,right=272 ,bottom=1462 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=178 ,top=1319 ,right=272 ,bottom=1387 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=178 ,top=1247 ,right=272 ,bottom=1316 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=181 ,top=1112 ,right=272 ,bottom=1144 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=181 ,top=1081 ,right=272 ,bottom=1112 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가' ,left=181 ,top=1050 ,right=272 ,bottom=1081 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='추' ,left=181 ,top=1019 ,right=272 ,bottom=1050 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=194 ,top=912 ,right=259 ,bottom=950 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종' ,left=128 ,top=1037 ,right=169 ,bottom=1075 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1181 ,top=1116 ,right=1950 ,bottom=1116 </L>
	<C>id='Column', left=500, top=1044, right=656, bottom=1078 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='정' ,left=50 ,top=1044 ,right=97 ,bottom=1081 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='산' ,left=50 ,top=1156 ,right=97 ,bottom=1194 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=50 ,top=1269 ,right=97 ,bottom=1306 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=50 ,top=1381 ,right=97 ,bottom=1419 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조' ,left=1075 ,top=781 ,right=1175 ,bottom=819 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=1075 ,top=825 ,right=1175 ,bottom=862 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=1075 ,top=869 ,right=1175 ,bottom=906 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=1075 ,top=912 ,right=1175 ,bottom=950 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=1075 ,top=956 ,right=1175 ,bottom=994 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=1075 ,top=1000 ,right=1175 ,bottom=1037 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=500, top=1006, right=656, bottom=1041 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=500, top=969, right=656, bottom=1003 ,mask='(XX명)', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=122 ,top=891 ,right=1066 ,bottom=891 </L>
	<L> left=122 ,top=853 ,right=1066 ,bottom=853 </L>
	<L> left=1181 ,top=816 ,right=1953 ,bottom=816 </L>
	<L> left=122 ,top=816 ,right=1066 ,bottom=816 </L>
	<L> left=22 ,top=778 ,right=1953 ,bottom=778 </L>
	<T>id='소   득' ,left=28 ,top=741 ,right=278 ,bottom=775 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=281 ,top=741 ,right=1953 ,bottom=741 </L>
	<T>id='20)계(17+18+19)' ,left=1594 ,top=706 ,right=1947 ,bottom=741 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='19)' ,left=1191 ,top=706 ,right=1581 ,bottom=741 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='18)기타비과세' ,left=669 ,top=706 ,right=1175 ,bottom=741 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='17) 야간근로수당' ,left=288 ,top=706 ,right=656 ,bottom=741 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비과세' ,left=28 ,top=706 ,right=278 ,bottom=741 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1441 ,top=437 ,right=1441 ,bottom=703 </L>
	<L> left=922 ,top=437 ,right=922 ,bottom=703 </L>
	<T>id='15)주식매수선택권의 행사로 얻은 소득' ,left=131 ,top=631 ,right=656 ,bottom=666 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근' ,left=28 ,top=450 ,right=119 ,bottom=478 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='무' ,left=28 ,top=481 ,right=119 ,bottom=509 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='처' ,left=28 ,top=512 ,right=119 ,bottom=541 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=28 ,top=544 ,right=119 ,bottom=572 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=28 ,top=575 ,right=119 ,bottom=603 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=28 ,top=606 ,right=119 ,bottom=634 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=28 ,top=637 ,right=119 ,bottom=666 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=28 ,top=669 ,right=119 ,bottom=697 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=122 ,top=703 ,right=1953 ,bottom=703 </L>
	<T>id='16)계' ,left=131 ,top=669 ,right=656 ,bottom=703 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=122 ,top=666 ,right=1953 ,bottom=666 </L>
	<L> left=122 ,top=628 ,right=1953 ,bottom=628 </L>
	<L> left=122 ,top=591 ,right=1953 ,bottom=591 </L>
	<L> left=122 ,top=516 ,right=1953 ,bottom=516 </L>
	<L> left=122 ,top=478 ,right=1953 ,bottom=478 </L>
	<L> left=19 ,top=437 ,right=1950 ,bottom=437 </L>
	<L> left=1181 ,top=394 ,right=1181 ,bottom=437 </L>
	<T>id='까지' ,left=1869 ,top=403 ,right=1944 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=1481, top=403, right=1625, bottom=437, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='부터' ,left=1631 ,top=403 ,right=1706 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=1719, top=403, right=1863, bottom=437, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='Column', left=700, top=403, right=844, bottom=437, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='부터' ,left=850 ,top=403 ,right=925 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='Column', left=938, top=403, right=1081, bottom=437, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='까지' ,left=1088 ,top=403 ,right=1163 ,bottom=437 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑨귀속연도' ,left=28 ,top=403 ,right=659 ,bottom=437 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=206 ,top=397 ,right=1953 ,bottom=397 </L>
	<T>id='소득자' ,left=28 ,top=325 ,right=203 ,bottom=394 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=513 ,top=209 ,right=513 ,bottom=397 </L>
	<L> left=1438 ,top=322 ,right=1438 ,bottom=359 </L>
	<L> left=1038 ,top=322 ,right=1038 ,bottom=359 </L>
	<L> left=206 ,top=359 ,right=1953 ,bottom=359 </L>
	<L> left=206 ,top=322 ,right=1953 ,bottom=322 </L>
	<T>id='의무자' ,left=38 ,top=269 ,right=194 ,bottom=316 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징   수' ,left=38 ,top=216 ,right=194 ,bottom=262 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1038 ,top=206 ,right=1038 ,bottom=284 </L>
	<L> left=206 ,top=284 ,right=1953 ,bottom=284 </L>
	<L> left=206 ,top=206 ,right=1950 ,bottom=206 </L>
	<L> left=1881 ,top=153 ,right=1881 ,bottom=194 </L>
	<L> left=1684 ,top=153 ,right=1684 ,bottom=194 </L>
	<L> left=1413 ,top=194 ,right=1953 ,bottom=194 </L>
	<T>id='거주지국' ,left=1419 ,top=156 ,right=1569 ,bottom=191 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국코드' ,left=1691 ,top=156 ,right=1878 ,bottom=191 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1728 ,top=109 ,right=1728 ,bottom=150 </L>
	<L> left=1413 ,top=153 ,right=1953 ,bottom=153 </L>
	<L> left=1638 ,top=25 ,right=1638 ,bottom=109 </L>
	<T>id='외국인단일세율적용' ,left=1419 ,top=116 ,right=1722 ,bottom=150 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여 1' ,left=1750 ,top=116 ,right=1831 ,bottom=150 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1828 ,top=116 ,right=1866 ,bottom=150 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 2' ,left=1863 ,top=116 ,right=1944 ,bottom=150 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1413 ,top=109 ,right=1953 ,bottom=109 </L>
	<T>id='내·외국인' ,left=1419 ,top=72 ,right=1631 ,bottom=106 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내국인1' ,left=1647 ,top=72 ,right=1788 ,bottom=106 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1784 ,top=72 ,right=1822 ,bottom=106 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인9' ,left=1819 ,top=72 ,right=1944 ,bottom=106 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1413 ,top=69 ,right=1953 ,bottom=69 </L>
	<T>id='거주자2' ,left=1819 ,top=31 ,right=1944 ,bottom=66 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1784 ,top=31 ,right=1822 ,bottom=66 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자1' ,left=1647 ,top=31 ,right=1788 ,bottom=66 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=1419 ,top=31 ,right=1631 ,bottom=66 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(발행자 보고용)' ,left=634 ,top=134 ,right=1050 ,bottom=187 ,face='HY중고딕' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑종근로소득원천징수영수증' ,left=600 ,top=28 ,right=1344 ,bottom=75 ,align='left' ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=22 ,top=16 ,right=1953 ,bottom=16 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=194 ,top=25 ,right=194 ,bottom=119 </L>
	<T>id='번호' ,left=75 ,top=75 ,right=188 ,bottom=116 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리' ,left=75 ,top=31 ,right=188 ,bottom=72 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1409 ,top=25 ,right=1950 ,bottom=25 </L>
	<X>left=538 ,top=37 ,right=578 ,bottom=78 ,border=true</X>
	<L> left=1700 ,top=437 ,right=1700 ,bottom=703 </L>
	<L> left=122 ,top=553 ,right=1953 ,bottom=553 </L>
	<L> left=1572 ,top=153 ,right=1572 ,bottom=194 </L>
	<L> left=22 ,top=2641 ,right=1950 ,bottom=2641 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='6. □현금영수증사용액란은 □란에 기재할 공제액 중 현금영수증 사용액만을 기재합니다.(2005년 이후 사용분부터 기재)' ,left=28 ,top=2584 ,right=1947 ,bottom=2631 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 종합소득 특별공제(□~□)와 조세특례제한법상의 소득공제(□~□)는 제37호 서식의 공제액을 기재합니다. 5.□차감징수세액이 소액부징수에 해당하는 경우 \'0\'으로 기재합니다.' ,left=28 ,top=2531 ,right=1947 ,bottom=2578 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 갑종근로소득과 을종근로소득을 합산하여 연말정산시 납세조합란에 을근납세조합과 을종근로소득을 기재하고, □ 납세조합공제란을 기재합니다.' ,left=28 ,top=2478 ,right=1947 ,bottom=2525 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 원천징수의무자는 지급일이 속하는 연도의 다음 연도 2월 말일(휴업, 폐업한 경우에는 휴업일,폐업일이 속하는 달의 다음달 말일)까지 지급조서를 제출하여야 합니다.' ,left=28 ,top=2425 ,right=1947 ,bottom=2472 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 거주지국과 거주지국코드는 외국안에 해당하는 경우에 한하여 기재하며, 국제표준화기구(ISO)가 정한 ISO코드중 국방약어 및 국가코드를 기재합니다.' ,left=28 ,top=2372 ,right=1947 ,bottom=2419 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=22 ,top=2366 ,right=1950 ,bottom=2366 </L>
	<T>id='(서명 또는 인)' ,left=1609 ,top=2269 ,right=1878 ,bottom=2303 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수(보고)의무자' ,left=866 ,top=2269 ,right=1219 ,bottom=2303 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=1234, top=2187, right=1516, bottom=2216, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀하' ,left=347 ,top=2319 ,right=478 ,bottom=2353 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=22 ,top=16 ,right=22 ,bottom=2641 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1950 ,top=16 ,right=1950 ,bottom=2641 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=22 ,top=2053 ,right=1950 ,bottom=2053 </L>
	<T>id='※관계코드:소득자의 직계존속=1,배우자의 직계존속=2,배우자=3,직계비속=4,형제자매=5,기타=6(4,5,6의 경우 소득자와 배우자의 각각의 관계 포함함)' ,left=25 ,top=2000 ,right=1944 ,bottom=2047 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위의 원천징수액(근로소득)을 영수(지급)합니다.' ,left=575 ,top=2087 ,right=1650 ,bottom=2150 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1438 ,top=206 ,right=1438 ,bottom=284 </L>
	<T>id='⑩감면기간' ,left=1188 ,top=403 ,right=1434 ,bottom=437 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1066 ,top=991 ,right=1066 ,bottom=1609 </L>
	<T>id='①조 합 명' ,left=213 ,top=212 ,right=506 ,bottom=244 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='②조합장명' ,left=1044 ,top=212 ,right=1428 ,bottom=241 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='④주민(법인)등록번호' ,left=1044 ,top=253 ,right=1428 ,bottom=281 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑦주민등록번호' ,left=1044 ,top=328 ,right=1428 ,bottom=356 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③사업자등록번호' ,left=213 ,top=253 ,right=506 ,bottom=281 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑤소 재 지' ,left=213 ,top=291 ,right=506 ,bottom=319 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑥성   명' ,left=213 ,top=328 ,right=506 ,bottom=356 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='⑧주   소' ,left=213 ,top=366 ,right=506 ,bottom=394 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=519, top=328, right=850, bottom=356, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CADDNM', left=519, top=366, right=1756, bottom=394, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO', left=1447, top=328, right=1778, bottom=356, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PC11000', left=669, top=559, right=919, bottom=587, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC12000', left=669, top=597, right=919, bottom=625, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC13000', left=669, top=634, right=919, bottom=662, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PC10000', left=669, top=672, right=919, bottom=700, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM1', left=931, top=484, right=1175, bottom=512, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO1', left=931, top=522, right=1175, bottom=550, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC11000', left=931, top=559, right=1175, bottom=587, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC12000', left=931, top=597, right=1175, bottom=625, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC13000', left=931, top=634, right=1175, bottom=662, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC10000', left=931, top=672, right=1175, bottom=700, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCWKNM2', left=1188, top=484, right=1431, bottom=512, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BCRESINO2', left=1188, top=522, right=1431, bottom=550, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC21000', left=1188, top=559, right=1431, bottom=587, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC22000', left=1188, top=597, right=1431, bottom=625, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC23000', left=1188, top=634, right=1431, bottom=662, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BC20000', left=1188, top=672, right=1431, bottom=700, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='합  계' ,left=1706 ,top=441 ,right=1944 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세조합' ,left=1447 ,top=441 ,right=1694 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)' ,left=1188 ,top=441 ,right=1434 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)' ,left=928 ,top=441 ,right=1175 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)' ,left=669 ,top=441 ,right=916 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구   분' ,left=131 ,top=441 ,right=656 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PB10000', left=738, top=784, right=1050, bottom=812, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB20000', left=738, top=822, right=1050, bottom=850, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB30000', left=738, top=859, right=1050, bottom=887, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BAAMT01', left=738, top=897, right=1050, bottom=925, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BAAMT02', left=738, top=934, right=1050, bottom=962, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BAAMT03', left=738, top=972, right=1050, bottom=1000, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADAMT01', left=738, top=1009, right=1050, bottom=1037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADAMT02', left=738, top=1047, right=1050, bottom=1075, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADAMT03', left=738, top=1084, right=1050, bottom=1112, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADAMT04', left=738, top=1122, right=1050, bottom=1150, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='31)소수공제자추가공제' ,left=181 ,top=1159 ,right=656 ,bottom=1187 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='32)연금보험료공제' ,left=181 ,top=1197 ,right=656 ,bottom=1225 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ADAMT05', left=738, top=1159, right=1050, bottom=1187, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INSSUM', left=738, top=1234, right=1050, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PENSUM', left=738, top=1197, right=1050, bottom=1225, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MEDSUM', left=738, top=1272, right=1050, bottom=1300, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDUSUM', left=738, top=1309, right=1050, bottom=1337, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HOUSUM', left=738, top=1347, right=1050, bottom=1375, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCAMT011', left=1622, top=784, right=1934, bottom=812, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCAMT01', left=1622, top=822, right=1934, bottom=850, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCAMT02', left=1622, top=859, right=1934, bottom=887, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCAMT031', left=1622, top=897, right=1934, bottom=925, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCSUM', left=1622, top=1009, right=1934, bottom=1037, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TSTDSUM', left=1622, top=1047, right=1934, bottom=1075, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STDTAX', left=1622, top=1084, right=1934, bottom=1112, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDAMT01    ', left=1622, top=1122, right=1934, bottom=1150, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDAMT02', left=1622, top=1159, right=1934, bottom=1187, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDSUM', left=1622, top=1234, right=1934, bottom=1262, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDAMT01', left=1622, top=1272, right=1934, bottom=1300, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDAMT02', left=1622, top=1309, right=1934, bottom=1337, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDAMT03', left=1622, top=1347, right=1934, bottom=1375, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDAMT04', left=1622, top=1384, right=1934, bottom=1412, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDAMT05', left=1622, top=1422, right=1934, bottom=1450, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDSUM', left=1622, top=1534, right=1934, bottom=1562, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='43)개인연금저축 소득공제' ,left=1191 ,top=784 ,right=1581 ,bottom=812 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='44)연금 저축 소득 공제' ,left=1191 ,top=822 ,right=1581 ,bottom=850 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='45)투자조합출자등소득공제' ,left=1191 ,top=859 ,right=1581 ,bottom=887 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='46)신용카드등소득공제' ,left=1191 ,top=897 ,right=1581 ,bottom=925 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='47)' ,left=1191 ,top=934 ,right=1581 ,bottom=962 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='48)' ,left=1191 ,top=972 ,right=1581 ,bottom=1000 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='49)조특 소득 공제 계' ,left=1191 ,top=1009 ,right=1581 ,bottom=1037 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50)종합소득과세표준' ,left=1072 ,top=1047 ,right=1581 ,bottom=1075 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='51)산출세액' ,left=1072 ,top=1084 ,right=1581 ,bottom=1112 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='52)소득세법' ,left=1191 ,top=1122 ,right=1581 ,bottom=1150 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='53)조세특례제한법' ,left=1191 ,top=1159 ,right=1581 ,bottom=1187 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='54)' ,left=1191 ,top=1197 ,right=1581 ,bottom=1225 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='55)감면세액계' ,left=1191 ,top=1234 ,right=1581 ,bottom=1262 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='56)근로소득' ,left=1191 ,top=1272 ,right=1581 ,bottom=1300 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='57)납세조합공제' ,left=1191 ,top=1309 ,right=1581 ,bottom=1337 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='63)세액공제계' ,left=1191 ,top=1534 ,right=1581 ,bottom=1562 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='62)' ,left=1191 ,top=1497 ,right=1581 ,bottom=1525 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='61)' ,left=1191 ,top=1459 ,right=1581 ,bottom=1487 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='60)외국납부' ,left=1191 ,top=1422 ,right=1581 ,bottom=1450 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='59)기부 정치자금' ,left=1191 ,top=1384 ,right=1581 ,bottom=1412 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='58)주택차입금' ,left=1191 ,top=1347 ,right=1581 ,bottom=1375 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 정 세 액(51-55-63)' ,left=1075 ,top=1575 ,right=1581 ,bottom=1603 ,align='left' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산' ,left=519 ,top=212 ,right=769 ,bottom=241 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='111-01-1110100' ,left=519 ,top=253 ,right=841 ,bottom=281 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본사' ,left=522 ,top=291 ,right=772 ,bottom=319 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산' ,left=1444 ,top=212 ,right=1694 ,bottom=241 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='111-01-1110100' ,left=1444 ,top=253 ,right=1766 ,bottom=281 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CONSUM', left=738, top=1384, right=1050, bottom=1412, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MARSUM', left=738, top=1422, right=1050, bottom=1450, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1413 ,top=25 ,right=1413 ,bottom=194 </L>
	<C>id='OFFSUM', left=738, top=1575, right=1050, bottom=1603, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STDSUM', left=738, top=1534, right=1050, bottom=1562, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPCSUM', left=738, top=1497, right=1050, bottom=1525, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='RESSUM', left=1622, top=1574, right=1934, bottom=1603, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<T>id='사용액' ,left=1703 ,top=1650 ,right=1944 ,bottom=1681 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='68)현금영수증' ,left=1703 ,top=1616 ,right=1944 ,bottom=1644 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CASHSUM', left=1725, top=1725, right=1925, bottom=1753, align='right' ,mask='\XXXXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PB41000', left=722, top=1653, right=922, bottom=1681, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB51000', left=722, top=1691, right=922, bottom=1719, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB61000', left=722, top=1728, right=922, bottom=1756, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB71000', left=722, top=1766, right=922, bottom=1794, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB42000', left=994, top=1653, right=1194, bottom=1681, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB52000', left=994, top=1691, right=1194, bottom=1719, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB62000', left=994, top=1728, right=1194, bottom=1756, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB72000', left=994, top=1766, right=1194, bottom=1794, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB73000', left=1234, top=1766, right=1403, bottom=1794, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB63000', left=1234, top=1728, right=1403, bottom=1756, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB53000', left=1234, top=1691, right=1403, bottom=1719, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB43000', left=1234, top=1653, right=1403, bottom=1681, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB50000', left=1453, top=1691, right=1684, bottom=1719, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB60000', left=1453, top=1728, right=1684, bottom=1756, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB70000', left=1453, top=1766, right=1684, bottom=1794, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1', left=31, top=1884, right=113, bottom=1912, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT4', left=31, top=1922, right=113, bottom=1950, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT7', left=31, top=1959, right=113, bottom=1987, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM1', left=125, top=1884, right=306, bottom=1912, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM4', left=125, top=1922, right=306, bottom=1950, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM7', left=125, top=1959, right=306, bottom=1987, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO1', left=322, top=1884, right=628, bottom=1912, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO4', left=322, top=1922, right=628, bottom=1950, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO7', left=322, top=1959, right=628, bottom=1987, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO8', left=978, top=1959, right=1284, bottom=1987, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO2', left=978, top=1884, right=1284, bottom=1912, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO5', left=978, top=1922, right=1284, bottom=1950, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO6', left=1628, top=1922, right=1934, bottom=1950, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO3', left=1628, top=1884, right=1934, bottom=1912, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO9', left=1628, top=1959, right=1934, bottom=1987, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM2', left=784, top=1884, right=966, bottom=1912, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM5', left=784, top=1922, right=966, bottom=1950, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM8', left=784, top=1959, right=966, bottom=1987, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM9', left=1441, top=1956, right=1616, bottom=1984, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM6', left=1441, top=1919, right=1616, bottom=1947, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FAMNM3', left=1441, top=1881, right=1616, bottom=1909, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT2', left=694, top=1884, right=775, bottom=1912, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT5', left=694, top=1922, right=775, bottom=1950, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT8', left=694, top=1959, right=775, bottom=1987, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT9', left=1347, top=1959, right=1428, bottom=1987, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT6', left=1347, top=1922, right=1428, bottom=1950, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT3', left=1347, top=1884, right=1428, bottom=1912, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PB40000', left=1453, top=1651, right=1683, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

</B>

<B>id=Footer ,left=0 ,top=2770 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=9 ,top=19 ,right=1988 ,bottom=97</T>
	<I>id='../../Common/img/icon.jpg' ,left=1591 ,top=0 ,right=1972 ,bottom=94</I>
	<L> left=3 ,top=0 ,right=1963 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script>




<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 상여 명세서 급 여 ####
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print4  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	value="gcds_report4">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=175 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=908, top=56, right=1976, bottom=143, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<T>id='단위 : 원' ,left=2572 ,top=122 ,right=2789 ,bottom=185 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=2572, top=61, right=2789, bottom=122, align='right' ,mask='XXXX.XX.XX', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='Print Date:' ,left=2273 ,top=61 ,right=2569 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=246 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='성명' ,left=45 ,top=74 ,right=278 ,bottom=127 ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사번' ,left=45 ,top=13 ,right=278 ,bottom=71 ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2786 ,top=3 ,right=2786 ,bottom=243 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='지급년월-구분' ,left=333 ,top=13 ,right=648 ,bottom=71 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여외지급액' ,left=2260 ,top=74 ,right=2535 ,bottom=127 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=333 ,top=191 ,right=616 ,bottom=243 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세+주민세' ,left=2262 ,top=132 ,right=2535 ,bottom=185 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급일자' ,left=333 ,top=74 ,right=616 ,bottom=127 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급호' ,left=45 ,top=191 ,right=278 ,bottom=246 ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=45 ,top=132 ,right=278 ,bottom=185 ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=249 ,right=2781 ,bottom=246 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='차량유지비' ,left=1016 ,top=191 ,right=1228 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=1016 ,top=132 ,right=1228 ,bottom=185 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=1016 ,top=74 ,right=1228 ,bottom=127 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납' ,left=1299 ,top=16 ,right=1513 ,bottom=74 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=1299 ,top=77 ,right=1513 ,bottom=135 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연장수당' ,left=1299 ,top=132 ,right=1513 ,bottom=191 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=1299 ,top=193 ,right=1513 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남북경협수당' ,left=1585 ,top=13 ,right=1839 ,bottom=71 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장단수당' ,left=1585 ,top=74 ,right=1839 ,bottom=127 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1585 ,top=132 ,right=1839 ,bottom=185 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=1942 ,top=13 ,right=2167 ,bottom=71 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학자금' ,left=1942 ,top=74 ,right=2167 ,bottom=127 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임원직책수당' ,left=1905 ,top=132 ,right=2167 ,bottom=185 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=2307 ,top=13 ,right=2535 ,bottom=71 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급계' ,left=2257 ,top=191 ,right=2535 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급' ,left=1905 ,top=191 ,right=2167 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=1016 ,top=13 ,right=1228 ,bottom=71 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역근무수당' ,left=1585 ,top=191 ,right=1839 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=725 ,top=132 ,right=937 ,bottom=188 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호봉계' ,left=722 ,top=191 ,right=937 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=725 ,top=74 ,right=937 ,bottom=127 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2540 ,top=5 ,right=2540 ,bottom=246 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=32 ,top=3 ,right=32 ,bottom=243 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='기본급' ,left=725 ,top=13 ,right=937 ,bottom=71 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=288 ,top=3 ,right=288 ,bottom=246 </L>
	<L> left=675 ,top=3 ,right=675 ,bottom=246 </L>
	<L> left=32 ,top=3 ,right=2781 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='지급율' ,left=2561 ,top=191 ,right=2768 ,bottom=246 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=214 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2786 ,top=0 ,right=2786 ,bottom=214 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id={decode(curlevel,1,subavg(SANGRAT),SANGRAT)}, left=2559, top=164, right=2733, bottom=214, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='%' ,left=2733 ,top=164 ,right=2768 ,bottom=214 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id={decode(curlevel,1,'',DEPTNM)}, left=325, top=167, right=672, bottom=212, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
	<C>id={decode(T11000+T12000,0,'',T11000+T12000)}, left=2289, top=106, right=2535, bottom=153, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(curlevel,1,'명')}, left=556, top=111, right=601, bottom=161, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(curlevel,1,subcount(empno)-1,'')}, left=328, top=111, right=537, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P11000,0,'',P11000)}, left=714, top=56, right=939, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P12000,0,'',P12000)}, left=714, top=106, right=939, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P10000,0,'',P10000)}, left=714, top=0, right=939, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'',PAYSEQNM)}, left=45, top=161, right=278, bottom=214, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'소 계',PAYGRDNM)}, left=45, top=106, right=278, bottom=156, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'',EMPNMK)}, left=45, top=56, right=278, bottom=103, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(curlevel,1,'',EMPNO)}, left=45, top=0, right=278, bottom=50, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=0 ,right=32 ,bottom=214 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=32 ,top=216 ,right=2781 ,bottom=216 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id={decode(PX0020+PX0030+PX0040,0,'',PX0020+PX0030+PX0040)}, left=1918, top=159, right=2167, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P32000,0,'',P32000)}, left=1588, top=159, right=1839, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P28000,0,'',P28000)}, left=1278, top=159, right=1513, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P24000,0,'',P24000)}, left=992, top=159, right=1228, bottom=212, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P38000,0,'',P38000)}, left=1913, top=106, right=2162, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P31000,0,'',P31000)}, left=1582, top=106, right=1836, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P27000,0,'',P27000)}, left=1275, top=106, right=1513, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P23000,0,'',P23000)}, left=990, top=106, right=1228, bottom=156, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P21000+P22000+P23000+P24000+P25000+P26000+P27000+P28000+P29000+P30000+P31000+P32000+P36000+P37000+P38000+PX0020+PX0030+PX0040,0,'',P21000+P22000+P23000+P24000+P25000+P26000+P27000+P28000+P29000+P30000+P31000+P32000+P36000+P37000+P38000+PX0020+PX0030+PX0040)}, left=2289, top=56, right=2535, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P36000,0,'',P36000)}, left=1918, top=56, right=2167, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P30000,0,'',P30000)}, left=1588, top=56, right=1839, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P26000,0,'',P26000)}, left=1278, top=56, right=1513, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P22000,0,'',P22000)}, left=992, top=56, right=1228, bottom=106, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={decode(P39000,0,'',P39000)}, left=2289, top=0, right=2535, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P37000,0,'',P37000)}, left=1918, top=0, right=2167, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P29000,0,'',P29000)}, left=1588, top=0, right=1839, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(T11000,0,'',T11000)}, left=1275, top=0, right=1513, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={decode(P21000,0,'',P21000)}, left=992, top=0, right=1228, bottom=50, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=288 ,top=0 ,right=288 ,bottom=214 </L>
	<L> left=2540 ,top=0 ,right=2540 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=675 ,top=0 ,right=675 ,bottom=214 </L>
	<X>left=706 ,top=161 ,right=945 ,bottom=214 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id={P10000+P11000+P12000}, left=714, top=161, right=939, bottom=214, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<X>left=2215 ,top=161 ,right=2535 ,bottom=214 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id={decode(S91000,0,'',S91000)}, left=2225, top=161, right=2532, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id={decode(curlevel,1,'',PAYDTYM)}, left=328, top=8, right=675, bottom=50, align='left', supplevel=1 ,mask='XXXX년 XX월 상여', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
	<C>id={decode(curlevel,1,'',PAYDTYMD)}, left=328, top=58, right=656, bottom=106, align='left', supplevel=1 ,mask='XXXX-XX-XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=236 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2540 ,top=0 ,right=2540 ,bottom=228 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=32 ,top=0 ,right=32 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=288 ,top=0 ,right=288 ,bottom=228 </L>
	<L> left=2786 ,top=0 ,right=2786 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=675 ,top=0 ,right=675 ,bottom=228 </L>
	<L> left=32 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=32 ,top=0 ,right=2781 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id={Sum(P36000)} ,left=1916 ,top=66 ,right=2164 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P38000)} ,left=1916 ,top=124 ,right=2164 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P35000)} ,left=1916 ,top=177 ,right=2164 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(PX0010)} ,left=2244 ,top=66 ,right=2492 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P12000)} ,left=717 ,top=124 ,right=937 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P11000)} ,left=717 ,top=69 ,right=937 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P10000)} ,left=717 ,top=16 ,right=937 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id={SUM(P22000)} ,left=982 ,top=71 ,right=1222 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={SUM(P23000)} ,left=982 ,top=127 ,right=1222 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P28000)} ,left=1270 ,top=175 ,right=1513 ,bottom=225 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P27000)} ,left=1270 ,top=122 ,right=1513 ,bottom=172 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P26000)} ,left=1270 ,top=66 ,right=1513 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={SUM(P32000)} ,left=1590 ,top=177 ,right=1839 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={SUM(P31000)} ,left=1590 ,top=124 ,right=1839 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={SUM(P30000)} ,left=1590 ,top=69 ,right=1839 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P37000)} ,left=1916 ,top=16 ,right=2164 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={SUM(P29000)} ,left=1590 ,top=16 ,right=1839 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Sum(P25000)} ,left=1270 ,top=13 ,right=1513 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='명' ,left=579 ,top=132 ,right=632 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id=Count ,left=455 ,top=132 ,right=577 ,bottom=180 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='합 계' ,left=45 ,top=132 ,right=278 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총원' ,left=341 ,top=132 ,right=482 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=706 ,top=177 ,right=945 ,bottom=228 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id={SUM(P10000)+SUM(P11000)+SUM(P12000)}, left=717, top=180, right=937, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<S>id={SUM(P24000)} ,left=982 ,top=177 ,right=1222 ,bottom=222 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={SUM(P21000)} ,left=982 ,top=16 ,right=1222 ,bottom=64 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id={Avg(SANGRAT)} ,left=2561 ,top=175 ,right=2736 ,bottom=225 ,align='right' ,mask='XXX %' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='%' ,left=2736 ,top=175 ,right=2770 ,bottom=225 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<S>id={SUM(P39000)} ,left=2283 ,top=16 ,right=2532 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<X>left=2212 ,top=175 ,right=2532 ,bottom=228 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<S>id={SUM(S91000)} ,left=2223 ,top=180 ,right=2529 ,bottom=225 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<C>id={SUM(T11000)+SUM(T12000)}, left=2283, top=119, right=2532, bottom=172, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id={SUM(P21000)+SUM(P22000)+SUM(P23000)+SUM(P24000)+SUM(P25000)+SUM(P26000)+SUM(P27000)+SUM(P28000)+SUM(P29000)+SUM(P30000)+SUM(P31000)+SUM(P32000)+SUM(P36000)+SUM(P37000)+SUM(P38000)+SUM(PX0020)+SUM(PX0030)+SUM(PX0040)} ,left=2283 ,top=64 ,right=2532 ,bottom=116 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</C>


</B>
<B>id=Footer ,left=0 ,top=1891 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=37 ,top=19 ,right=2794 ,bottom=98 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=0 ,right=2781 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../../Common/img/icon.jpg' ,left=2402 ,top=8 ,right=2783 ,bottom=108</I>
</B>



">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
<!--
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=180 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='Print Date:' ,left=2275 ,top=61 ,right=2572 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=2574, top=61, right=2791, bottom=119, align='right' ,mask='XXXX.XX.XX', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='단위 : 원' ,left=2574 ,top=122 ,right=2791 ,bottom=180 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CTITLE', left=908, top=56, right=1976, bottom=143, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=249 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='성명' ,left=45 ,top=74 ,right=278 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사번' ,left=45 ,top=13 ,right=278 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급율' ,left=2580 ,top=191 ,right=2802 ,bottom=246 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2818 ,top=3 ,right=2818 ,bottom=243 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='지급년월-구분' ,left=333 ,top=13 ,right=648 ,bottom=71 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여외지급액' ,left=2260 ,top=74 ,right=2535 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=333 ,top=191 ,right=616 ,bottom=243 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=2283 ,top=132 ,right=2535 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급일자' ,left=333 ,top=74 ,right=616 ,bottom=127 ,align='left' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급호' ,left=45 ,top=191 ,right=278 ,bottom=246 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=45 ,top=132 ,right=278 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=249 ,right=2813 ,bottom=249 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='차량유지비' ,left=1016 ,top=191 ,right=1228 ,bottom=246 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=1016 ,top=132 ,right=1228 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=1016 ,top=74 ,right=1228 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납' ,left=1299 ,top=16 ,right=1513 ,bottom=74 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=1299 ,top=77 ,right=1513 ,bottom=135 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연장수당' ,left=1299 ,top=132 ,right=1513 ,bottom=191 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=1299 ,top=193 ,right=1513 ,bottom=249 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남북경협수당' ,left=1585 ,top=13 ,right=1839 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장단수당' ,left=1585 ,top=74 ,right=1839 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1585 ,top=132 ,right=1839 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=1942 ,top=13 ,right=2167 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학자금' ,left=1942 ,top=74 ,right=2167 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임원직책수당' ,left=1905 ,top=132 ,right=2167 ,bottom=185 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=2307 ,top=13 ,right=2535 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급계' ,left=2257 ,top=191 ,right=2535 ,bottom=246 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급' ,left=1905 ,top=191 ,right=2167 ,bottom=246 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=1016 ,top=13 ,right=1228 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역근무수당' ,left=1585 ,top=191 ,right=1839 ,bottom=246 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=725 ,top=132 ,right=937 ,bottom=188 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='호봉계' ,left=722 ,top=191 ,right=937 ,bottom=246 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=725 ,top=74 ,right=937 ,bottom=127 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2540 ,top=5 ,right=2540 ,bottom=249 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=32 ,top=3 ,right=32 ,bottom=243 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='기본급' ,left=725 ,top=13 ,right=937 ,bottom=71 ,align='right' ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=288 ,top=3 ,right=288 ,bottom=249 </L>
	<L> left=675 ,top=3 ,right=675 ,bottom=249 </L>
	<L> left=32 ,top=3 ,right=2813 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=225 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2818 ,top=0 ,right=2818 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,'',DEPTNM)}', left=325, top=167, right=672, bottom=212, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
	<C>id='{decode(T11000,0,'',T11000)}', left=2289, top=106, right=2535, bottom=153, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(curlevel,1,'명')}', left=556, top=111, right=601, bottom=161, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(curlevel,1,subcount(empno)-1,'')}', left=328, top=111, right=537, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P11000,0,'',P11000)}', left=714, top=56, right=939, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P12000,0,'',P12000)}', left=714, top=106, right=939, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P10000,0,'',P10000)}', left=714, top=0, right=939, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'',PAYSEQNM)}', left=45, top=161, right=278, bottom=217, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'소 계',PAYGRDNM)}', left=45, top=106, right=278, bottom=156, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'',EMPNMK)}', left=45, top=56, right=278, bottom=103, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,'',EMPNO)}', left=45, top=0, right=278, bottom=50, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=0 ,right=32 ,bottom=222 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=32 ,top=225 ,right=2813 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(PX0020+PX0030+PX0040,0,'',PX0020+PX0030+PX0040)}', left=1918, top=159, right=2167, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P32000,0,'',P32000)}', left=1588, top=159, right=1839, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P28000,0,'',P28000)}', left=1278, top=159, right=1513, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P24000,0,'',P24000)}', left=992, top=159, right=1228, bottom=212, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P38000,0,'',P38000)}', left=1913, top=106, right=2162, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P31000,0,'',P31000)}', left=1582, top=106, right=1836, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P27000,0,'',P27000)}', left=1275, top=106, right=1513, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P23000,0,'',P23000)}', left=990, top=106, right=1228, bottom=156, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PX0010,0,'',PX0010)}', left=2289, top=56, right=2535, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P36000,0,'',P36000)}', left=1918, top=56, right=2167, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P30000,0,'',P30000)}', left=1588, top=56, right=1839, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P26000,0,'',P26000)}', left=1278, top=56, right=1513, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P22000,0,'',P22000)}', left=992, top=56, right=1228, bottom=106, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(P39000,0,'',P39000)}', left=2289, top=0, right=2535, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P37000,0,'',P37000)}', left=1918, top=0, right=2167, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P29000,0,'',P29000)}', left=1588, top=0, right=1839, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P25000,0,'',P25000)}', left=1275, top=0, right=1513, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P21000,0,'',P21000)}', left=992, top=0, right=1228, bottom=50, align='right', supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=288 ,top=0 ,right=288 ,bottom=222 </L>
	<L> left=2540 ,top=0 ,right=2540 ,bottom=222 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=675 ,top=0 ,right=675 ,bottom=222 </L>
	<X>left=706 ,top=161 ,right=945 ,bottom=214 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{P10000+P11000+P12000}', left=714, top=161, right=939, bottom=214, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<X>left=2215 ,top=161 ,right=2535 ,bottom=214 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{decode(S91000,0,'',S91000)}', left=2225, top=161, right=2532, bottom=212, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(curlevel,1,'',PAYDTYM)}', left=328, top=5, right=675, bottom=50, align='left', supplevel=1 ,mask='XXXX년 XX월 상여', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
	<C>id='{decode(curlevel,1,'',PAYDTYMD)}', left=328, top=58, right=656, bottom=106, align='left', supplevel=1 ,mask='XXXX-XX-XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subavg(SANGRAT),SANGRAT)}', left=2585, top=164, right=2760, bottom=214, align='right' , face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='%' ,left=2760 ,top=164 ,right=2794 ,bottom=214 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=241 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=288 ,top=0 ,right=288 ,bottom=228 </L>
	<L> left=2818 ,top=0 ,right=2818 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id={Avg(SANGRAT)} ,left=2593 ,top=177 ,right=2768 ,bottom=228 ,align='right' ,mask='XXX %' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='%' ,left=2768 ,top=177 ,right=2802 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(P36000)}' ,left=1916 ,top=66 ,right=2164 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P38000)}' ,left=1916 ,top=124 ,right=2164 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P35000)}' ,left=1916 ,top=177 ,right=2164 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(T11000)}' ,left=2244 ,top=122 ,right=2492 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(PX0010)}' ,left=2244 ,top=66 ,right=2492 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P12000)}' ,left=717 ,top=124 ,right=937 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P11000)}' ,left=717 ,top=69 ,right=937 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P10000)}' ,left=717 ,top=16 ,right=937 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{SUM(P22000)}' ,left=982 ,top=71 ,right=1222 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P23000)}' ,left=982 ,top=127 ,right=1222 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P28000)}' ,left=1270 ,top=175 ,right=1513 ,bottom=225 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P27000)}' ,left=1270 ,top=122 ,right=1513 ,bottom=172 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P26000)}' ,left=1270 ,top=66 ,right=1513 ,bottom=119 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P32000)}' ,left=1590 ,top=177 ,right=1839 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P31000)}' ,left=1590 ,top=124 ,right=1839 ,bottom=175 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P30000)}' ,left=1590 ,top=69 ,right=1839 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P39000)}' ,left=2244 ,top=16 ,right=2492 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P37000)}' ,left=1916 ,top=16 ,right=2164 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P29000)}' ,left=1590 ,top=16 ,right=1839 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P25000)}' ,left=1270 ,top=13 ,right=1513 ,bottom=61 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<L> left=675 ,top=0 ,right=675 ,bottom=228 </L>
	<T>id='명' ,left=579 ,top=132 ,right=632 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=241 ,right=2813 ,bottom=241 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=32 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<S>id='Count' ,left=455 ,top=132 ,right=577 ,bottom=180 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='합 계' ,left=45 ,top=132 ,right=278 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총원' ,left=341 ,top=132 ,right=482 ,bottom=180 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2540 ,top=0 ,right=2540 ,bottom=228 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=32 ,top=0 ,right=32 ,bottom=228 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<X>left=706 ,top=177 ,right=945 ,bottom=228 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{SUM(P10000)+SUM(P11000)+SUM(P12000)}', left=717, top=180, right=937, bottom=217, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<S>id='{SUM(P24000)}' ,left=982 ,top=177 ,right=1222 ,bottom=222 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(P21000)}' ,left=982 ,top=16 ,right=1222 ,bottom=64 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(S91000)}' ,left=2217 ,top=177 ,right=2524 ,bottom=228 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
</B>
<B>id=Footer ,left=0 ,top=1865 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=42 ,top=19 ,right=2799 ,bottom=98 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=5 ,right=2813 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../../Common/img/icon.jpg' ,left=2439 ,top=8 ,right=2820 ,bottom=108</I>
</B>

-->
