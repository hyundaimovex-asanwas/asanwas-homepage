<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/추계퇴직금조회
+ 프로그램 ID	: p040001
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 서 블 릿 명	: p040001_s1, p040001_s2, p040001_s3, p040001_s4
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>추계퇴직금조회</title>
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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);
var gs_date3 = gcurdate.substr(0,4)+ gcurdate.substr(5,2);
var str2_1=""; var str2_2=""; var str2_3="";  var str2_4="";  var str2_5="";  var str2_6="";
var str2_7=""; var str2_8=""; var str2_9=""; var str2_10=""; var str2_11=""; var str2_12="";
var str2_13=""; var str2_14=""; var str2_15="";
var gcem_jigub11 =""; gcem_jigub12 ="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_taeyeil.Text=gs_date;
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
	gcem_jigub11=gs_date.substr(0,6)+"01";
  gcem_jigub12=gs_date.substr(0,6)+mon[m];

	gcem_BASAMT_SUM.Text= "";//급여합계
	gcem_BASBUS_SUM.Text= "";//상여합계
	gcem_BAEAMT_SUM.Text= "";//기타수당합계
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query() {
  var str1 = fn_trim(gcem_jigub11);
	//var str2 = fn_trim(gcem_jigub12.Text);
	var str2 = fn_trim(gcem_taeyeil.Text);
	var str3 = fn_trim(gcem_emo.Text);
	var str4 = fn_trim(gclx_paydiv.BindColVal);

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s5?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4;
	gcds_data.Reset(); 
	gcds_data.rowposition=1;

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
	if (gcds_data.IsUpdated ) {
		if (confirm("퇴직급여변경사항을 저장하시겠습니까 ?"))	{
		//prompt('',gcds_data.text);
			ln_DataResave(gcds_data.rowposition);
			gctr_data.KeyValue = "Payroll.p040001_t1(I:USER=gcds_data)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_t1";
			gctr_data.post();
			ln_Query();
		}
	} 
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del(){

	if(gcds_data.countRow !=0)	{
		if (confirm("선택된 퇴직자급여사항을 삭제하시겠습니까 ?")) {
			gcem_BASAMT_SUM.Text= "";//급여합계
			gcem_BASBUS_SUM.Text= "";//상여합계
			gcem_BAEAMT_SUM.Text= "";//기타수당합계

			gcds_data.deleteRow(gcds_data.rowposition); //그리드
			gctr_data.KeyValue = "Payroll.p040001_t1(I:USER=gcds_data)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_t1";
			gctr_data.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : 계산
******************************************************************************/
function ln_Create(){

	var str1 = fn_trim(gcem_emo.Text);				//사번
	var str2 = '7';														//지급구분
	var str3 = fn_trim(gcem_taeyeil.Text);		//퇴직예정일
  
	if(str3.length < 8){
		alert("지급일자 8자리를 입력해주세요");
		gcem_taeyeil.Focus()
	}else if(str1 == ''){
		alert("사번을 입력하여 주십시오");
		return false;
  } else {
		
		if (gcds_data.countrow>0) {
			alert("계산이 완료되었습니다.");
		}else{
			gcds_select_create.ClearData();
			gcds_select_create.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s6?"
											 + "v_str1="  + str1
											 + "&v_str2=" + str2
											 + "&v_str3=" + str3;
			gcds_select_create.Reset(); 
			gcds_select_create.rowposition=1;
		}
	}
}

/******************************************************************************
	Description : 사원조회
******************************************************************************/
function ln_FindEmp(e,e2){
 
	if(fn_trim(gcem_taeyeil.Text).length ==8)	{
    if(e2=='2'){  
			var str1=fn_trim(gcem_emo.Text);
			gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s1?"
																+ "v_str1=" + str1;
			gcds_select_ec01az.Reset();

		}else	{
			var arrResult	= new Array();
			var arrSend	= new Array();
				arrSend[0]='P040001';
			window.dialogArguments=arrSend[0];
			var strURL;	
			var strPos;
			strURL = "./H030003_popup.jsp"
			//strURL = "P040001_popup.html"
			strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrSend,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
					gcem_emo.Text = arrParam[0];						// 사번
					hid_deptcd.value = arrParam[2];					//소속코드
					txt_deptnm.value = arrParam[3];					//소속명
					hid_hocode.value = arrParam[4];					//급호코드
					txt_ho.value = arrParam[5];							//급호명
					txt_name.value = arrParam[1];						//성명
					gcem_ipsail.Text = arrParam[6];					//입사일
					gcem_taesail.Text = arrParam[7];				//퇴사일
					txt_yyyy.value = arrParam[10];					//근속년수
					gclx_paydiv.BindColVal = arrParam[13];	//퇴직구분
			} else {
					gcem_emo.Text = "";											// 사번
					hid_deptcd.value = "";									//소속코드
					txt_deptnm.value = "";									//소속명
					hid_hocode.value =  "";									//급호코드
					txt_ho.value =  "";											//급호명
					txt_name.value = "";										//성명
					gcem_ipsail.Text = "";									//입사일
					gcem_taesail.Text = "";									//퇴사일
					txt_yyyy.value = "";										//근속년수
					gclx_paydiv.BindColVal = "";						//퇴직구분
			}
		}
	}else	{
		alert("퇴직예정일에 년월일을 정확히 입력하세요!")
    gcem_taeyeil.Focus();
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvyyyy(yyyy,mm) {
	//var returnPrv;
	if(parseInt(mm)==1)	{
        returnPrv=(parseInt(yyyy)-1)+"";
	}
	else returnPrv=yyyy;

	return returnPrv;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvmm(prv){

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
function yyyymmPlusMinus(str2) {

	if( str2.length ==8)	{
		str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str2.substr(4,2));
		str2_2=ln_prvyyyy(str2_1.substr(0,4),str2_1.substr(4,2)) +""+ ln_prvmm(str2_1.substr(4,2));
		str2_3=ln_prvyyyy(str2_2.substr(0,4),str2_2.substr(4,2)) +""+ ln_prvmm(str2_2.substr(4,2));
		str2_4=ln_prvyyyy(str2_3.substr(0,4),str2_3.substr(4,2)) +""+ ln_prvmm(str2_3.substr(4,2));
		str2_5=ln_prvyyyy(str2_4.substr(0,4),str2_4.substr(4,2)) +""+ ln_prvmm(str2_4.substr(4,2));
		str2_6=ln_prvyyyy(str2_5.substr(0,4),str2_5.substr(4,2)) +""+ ln_prvmm(str2_5.substr(4,2));
		str2_7=ln_prvyyyy(str2_6.substr(0,4),str2_6.substr(4,2)) +""+ ln_prvmm(str2_6.substr(4,2));
		str2_8=ln_prvyyyy(str2_7.substr(0,4),str2_7.substr(4,2)) +""+ ln_prvmm(str2_7.substr(4,2));
		str2_9=ln_prvyyyy(str2_8.substr(0,4),str2_8.substr(4,2)) +""+ ln_prvmm(str2_8.substr(4,2));
		str2_10=ln_prvyyyy(str2_9.substr(0,4),str2_9.substr(4,2)) +""+ ln_prvmm(str2_9.substr(4,2));
		str2_11=ln_prvyyyy(str2_10.substr(0,4),str2_10.substr(4,2)) +""+ ln_prvmm(str2_10.substr(4,2));
		str2_12=ln_prvyyyy(str2_11.substr(0,4),str2_11.substr(4,2)) +""+ ln_prvmm(str2_11.substr(4,2));
		str2_13=ln_prvyyyy(str2_12.substr(0,4),str2_12.substr(4,2)) +""+ ln_prvmm(str2_12.substr(4,2));
		str2_14=ln_prvyyyy(str2_13.substr(0,4),str2_13.substr(4,2)) +""+ ln_prvmm(str2_13.substr(4,2));
		str2_15=ln_prvyyyy(str2_14.substr(0,4),str2_14.substr(4,2)) +""+ ln_prvmm(str2_14.substr(4,2));
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Sang(){

	var str1=fn_trim(gcem_emo.Text);
	var str2=fn_trim(gcem_taeyeil.Text);

	if(str1== "")	{
		alert("사번을 정확히 입력해주세요");
		gcem_emo.Focus();
	}else if(str2.length== ""){
		alert("퇴직예정일을 정확히 입력해주세요");
		gcem_taeyeil.Focus();
	}	else{
		gcds_select_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s3?"   //상여금평균//연차평균
											 + "v_str1=" + str1 //사번
											 + "&v_str2=" + str2_12 //지급적용년월-12
											 + "&v_str3=" + str2_15 //지급적용년월-15
											 + "&v_str4=" + str2_1; //지급적용년월-1
		gcds_select_ec02az.Reset(); 
	}
}

/******************************************************************************
	Description : 상여금평균 계산
******************************************************************************/
function ln_SangAvg(){

	var str1 = fn_trim(gcem_emo.Text);				//사번
	var str2 = gcem_taeyeil.Text;							//퇴직예정일자(현재년 - 1년)
	var stryy = parseInt(str2.substr(0,4))-1;	//+ str2.substr(5,2)
	var strmm = str2.substr(4,2);

	//상여금평균
	gcds_data2.DataID="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s4?"
										+ "v_str1="  + str1
										+ "&v_str2=" + stryy+strmm
										+ "&v_str3=" + str2.substr(0,4)+str2.substr(4,2);
	//prompt('',gcds_data2.DataID);
	gcds_data2.Reset();

}

/******************************************************************************
	Description : 평균계산 
******************************************************************************/
function ln_AvgComplete() {

	var yavg = gcem_yunavg.text;	//년차수당
	var yyyy = txt_yyyy.value;		//근속년수

	var cnt = gcds_data2.namevalue(gcds_data2.rowposition,"COUNT");
	var amt = gcds_data2.namevalue(gcds_data2.rowposition,"AMT");
	var yamt = gcds_data2.namevalue(gcds_data2.rowposition,"YAMT");

	//급여평균
	gcem_payavg.text = (gcds_data.Sum(6,0,0)/3)+"";
	var pavg = gcem_payavg.text;	//급여평균

	//상여금평균
	if(gcem_sangavg.text == "" || gcem_sangavg.text == 0) {
		gcem_sangavg.text = 0;
		if (gcds_data2.namevalue(gcds_data2.rowposition,"S91000") == null) gcem_sangavg.text = 0;
	} else {
		gcem_sangavg.text = gcds_data2.namevalue(gcds_data2.rowposition,"S91000");
	}
	var savg = gcem_sangavg.text;	//상여금평균

	//년차수당
	if (gcem_yunavg.text == "" || gcem_yunavg.text == 0) {
		gcem_yunavg.text = 0;
		if (gcds_data2.namevalue(gcds_data2.rowposition,"YAMT") == null) yamt = 0;
	}else{
		gcem_yunavg.text = yamt;	//년차수당
	}
	
	//추계퇴직금 
	if (gcem_payavg.text == "" || gcem_payavg.text == 0 || gcem_payavg.text == 1) {
		gcem_chutae_amt.text = 0;
	} else { 
		gcem_chutae_amt.text = 0;
		gcem_chutae_amt.text = (parseInt(pavg) + parseInt(savg) + parseInt(yamt)) * parseInt(yyyy);	//추계퇴직금
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	if (gcds_data.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

	gcds_report0.ClearData();
	var str2=gcds_data.namevalue(gcds_data.rowposition,"APPDT");
			yyyymmPlusMinus(str2);

	var ls_temp="CTITLE:STRING,APPDT:STRING,EMPNO:STRING,EMPDIV:STRING,EMPNMK:STRING,DEPTNM:STRING,PAYGRDNM:STRING,STRTDT:STRING,RESINO:STRING,";
	ls_temp +="ENDDT:STRING,JDDAY:STRING,DUYEAR:DECIMAL,DUYMM:DECIMAL,DUDAY:DECIMAL,CADDR:STRING,BASDAY1:DECIMAL,";
	ls_temp +="BASDAY2:DECIMAL,BASDAY3:DECIMAL,BASDAY4:DECIMAL,BASMAX1:DECIMAL,BASMAX2:DECIMAL,BASMAX3:DECIMAL,";
	ls_temp +="BASMAX4:DECIMAL,BASAMT1:DECIMAL,BASAMT2:DECIMAL,BASAMT3:DECIMAL,BASAMT4:DECIMAL,BASBUS1:DECIMAL,";
	ls_temp +="BASBUS2:DECIMAL,BASBUS3:DECIMAL,BASBUS4:DECIMAL,BAEDAY1:DECIMAL,BAEDAY2:DECIMAL,BAEDAY3:DECIMAL,BAEDAY4:DECIMAL,";
	ls_temp +="BAEAMT1:DECIMAL,BAEAMT2:DECIMAL,BAEAMT3:DECIMAL,BAEAMT4:DECIMAL,BASAMT_SUM:DECIMAL,BASBUS_SUM:DECIMAL,BAEAMT_SUM:DECIMAL,";
	ls_temp +="YEAQTY:DECIMAL,YEAPAY:DECIMAL,";
	ls_temp +="AVGYER:DECIMAL,AVGAMT:DECIMAL,AVGBOS:DECIMAL,AVGETC:DECIMAL,AVG_SUM:DECIMAL,P21000:DECIMAL,P22000:DECIMAL,";
	ls_temp +="P24000:DECIMAL,P29000:DECIMAL,P38000:DECIMAL,P27000:DECIMAL,PX0000:DECIMAL,JUSPAY:DECIMAL,JUSRET:DECIMAL,";
	ls_temp +="JUSYER:DECIMAL,JUSBOS:DECIMAL,S91000:DECIMAL,S94000:DECIMAL,T21000:DECIMAL,T22000:DECIMAL,T23000:DECIMAL,T24000:DECIMAL,P43000:DECIMAL,";
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
																				+gcds_data.namevalue(gcds_data.rowposition,"BAEAMT4");

	gcds_report0.namevalue(1,"YEAQTY")=gcds_data.namevalue(gcds_data.rowposition,"YEAQTY");
	gcds_report0.namevalue(1,"YEAPAY")=gcds_data.namevalue(gcds_data.rowposition,"YEAPAY");

	gcds_report0.namevalue(1,"AVGYER")=gcds_data.namevalue(gcds_data.rowposition,"AVGYER");
	gcds_report0.namevalue(1,"AVGAMT")=gcds_data.namevalue(gcds_data.rowposition,"AVGAMT");
	gcds_report0.namevalue(1,"AVGBOS")=gcds_data.namevalue(gcds_data.rowposition,"AVGBOS");
	gcds_report0.namevalue(1,"AVGETC")=gcds_data.namevalue(gcds_data.rowposition,"AVGETC");

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
	
	gcds_report0.namevalue(1,"REF")=gcds_data.namevalue(gcds_data.rowposition,"REF");

	gcrp_print.preview();
	}
}

/******************************************************************************
	Description : 출력 - 영수증
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
	ls_temp +="AMT06:DECIMAL,AMT07:DECIMAL,AMT08:DECIMAL,AMT09:DECIMAL,AMT10:DECIMAL,AMT11:DECIMAL,AMT12:DECIMAL,CURDT:STRING,";
	ls_temp +="REF:STRING";
	
	gcds_report0.SetDataHeader(ls_temp);

	gcds_report0.Addrow();
	
	gcds_report0.namevalue(1,"EMPNO")		=	gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	gcds_report0.namevalue(1,"EMPNMK")	=	gcds_data.namevalue(gcds_data.rowposition,"EMPNMK");
	gcds_report0.namevalue(1,"RESINO")  = gcds_data.namevalue(gcds_data.rowposition,"RESINO");
	gcds_report0.namevalue(1,"APPDT")		=	gcds_data.namevalue(gcds_data.rowposition,"APPDT");
	gcds_report0.namevalue(1,"EMPDIV")	=	gcds_data.namevalue(gcds_data.rowposition,"EMPDIV");
	gcds_report0.namevalue(1,"DEPTNM")	=	gcds_data.namevalue(gcds_data.rowposition,"DEPTNM");
	gcds_report0.namevalue(1,"PAYGRDNM")=	gcds_data.namevalue(gcds_data.rowposition,"PAYGRDNM");
	gcds_report0.namevalue(1,"STRTDT")	=	gcds_data.namevalue(gcds_data.rowposition,"STRTDT");
	gcds_report0.namevalue(1,"ENDDT")		=	gcds_data.namevalue(gcds_data.rowposition,"ENDDT");

	var strDUYEAR = gcds_data.namevalue(gcds_data.rowposition,"DUYEAR")+"";
	var strDUYMM  = gcds_data.namevalue(gcds_data.rowposition,"DUYMM")+"";
	var strDUDAY  = gcds_data.namevalue(gcds_data.rowposition,"DUDAY")+"";

	gcds_report0.namevalue(1,"JDDAY")=strDUYEAR+"년 "+strDUYMM+"월";
	gcds_report0.namevalue(1,"DUYEAR") = parseInt(strDUYEAR);
	gcds_report0.namevalue(1,"DUYMM")  = parseInt(strDUYMM);
	gcds_report0.namevalue(1,"DUDAY")  = parseInt(strDUDAY);

	var strCA1=gcds_data.namevalue(gcds_data.rowposition,"CADDR01");
	var strCA2=gcds_data.namevalue(gcds_data.rowposition,"CADDR02");

	gcds_report0.namevalue(1,"CADDR")		=	strCA1+" "+strCA2;
	gcds_report0.namevalue(1,"J_CMP")		=	gcds_data.namevalue(gcds_data.rowposition,"J_CMP");
	gcds_report0.namevalue(1,"J_SAP")		=	gcds_data.namevalue(gcds_data.rowposition,"J_SAP");
	gcds_report0.namevalue(1,"J_AMT")		=	gcds_data.namevalue(gcds_data.rowposition,"J_AMT");
	gcds_report0.namevalue(1,"J_MUN")		=	gcds_data.namevalue(gcds_data.rowposition,"J_MUN");
	gcds_report0.namevalue(1,"J_RAT")		=	gcds_data.namevalue(gcds_data.rowposition,"J_RAT");
	gcds_report0.namevalue(1,"J_STRTDT")=	gcds_data.namevalue(gcds_data.rowposition,"J_STRTDT");
	gcds_report0.namevalue(1,"J_ENDDT")	=	gcds_data.namevalue(gcds_data.rowposition,"J_ENDDT");
	gcds_report0.namevalue(1,"J_DUYEAR")=	gcds_data.namevalue(gcds_data.rowposition,"J_DUYEAR");
	gcds_report0.namevalue(1,"S91AMT")	=	gcds_data.namevalue(gcds_data.rowposition,"S91AMT");
	gcds_report0.namevalue(1,"S91STD")	=	gcds_data.namevalue(gcds_data.rowposition,"S91STD");
	gcds_report0.namevalue(1,"J_T2300")	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2300");
	gcds_report0.namevalue(1,"J_T2400")	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2400");
	gcds_report0.namevalue(1,"T21000")	= gcds_data.namevalue(gcds_data.rowposition,"T21000");
	gcds_report0.namevalue(1,"S91000")	= gcds_data.namevalue(gcds_data.rowposition,"S91000");
	gcds_report0.namevalue(1,"T91AMT")	= gcds_data.namevalue(gcds_data.rowposition,"T91AMT");
	gcds_report0.namevalue(1,"T23000")	=	gcds_data.namevalue(gcds_data.rowposition,"T23000");
	gcds_report0.namevalue(1,"T24000")	=	gcds_data.namevalue(gcds_data.rowposition,"T24000");
	gcds_report0.namevalue(1,"DUYEAR1")	=	gcds_data.namevalue(gcds_data.rowposition,"DUYEAR1");

	var strJAMT = gcds_data.namevalue(gcds_data.rowposition,"J_AMT");
	var strJMUN = gcds_data.namevalue(gcds_data.rowposition,"J_MUN");
	var strJRAT = gcds_data.namevalue(gcds_data.rowposition,"J_RAT");

	gcds_report0.namevalue(1,"AMT01")		= parseInt(strJAMT+strJMUN+strJRAT);	//(102) 계

	var strS91STD		= gcds_data.namevalue(gcds_data.rowposition,"S91STD");
	var strDUYEAR1	= gcds_data.namevalue(gcds_data.rowposition,"DUYEAR1");
	
	gcds_report0.namevalue(1,"AMT02")		= parseInt(strS91STD)/parseInt(strDUYEAR1);	//퇴직과세표준÷근속연수

	var strT91AMT  = gcds_data.namevalue(gcds_data.rowposition,"T91AMT");

	gcds_report0.namevalue(1,"AMT03")		= parseInt(strT91AMT)*parseInt(strDUYEAR1);	//연평균산출세액*근속연수

	var strT21000 = gcds_data.namevalue(gcds_data.rowposition,"T21000");

	var amt04_floor = parseInt(strT91AMT)*parseInt(strDUYEAR1)-parseInt(strT21000);

	gcds_report0.namevalue(1,"AMT04")		= Math.floor(parseInt(amt04_floor)/10)*10;	//산출세액-세액공제

	var strS91000 = gcds_data.namevalue(gcds_data.rowposition,"S91000");

	gcds_report0.namevalue(1,"AMT05")		= parseInt(strS91000+strJAMT);	//(104) 계(13)
	gcds_report0.namevalue(1,"AMT06")		= parseInt(strS91000+strJAMT+strJMUN+strJRAT);	//(104) 계(16)
	gcds_report0.namevalue(1,"AMT07")		= parseInt(strDUYEAR*12)+parseInt(strDUYMM);	//(17) 근속월수

	var strT23000		= gcds_data.namevalue(gcds_data.rowposition,"T23000");
	var strT24000		= gcds_data.namevalue(gcds_data.rowposition,"T24000");
	var strJ_T2300	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2300");
	var strJ_T2400	=	gcds_data.namevalue(gcds_data.rowposition,"J_T2400");

	gcds_report0.namevalue(1,"AMT08")		= parseInt(strT23000)-parseInt(strJ_T2300);		//결정세액-종(전)근무지 기납부세액
	gcds_report0.namevalue(1,"AMT09")		= parseInt(strT23000)+parseInt(strT24000);		//계 (29) 소득세+주민세
	gcds_report0.namevalue(1,"AMT10")		= parseInt(strJ_T2300)+parseInt(strJ_T2400);	//계 (30) 소득세+주민세
	gcds_report0.namevalue(1,"AMT11")		= parseInt(strT24000)+parseInt(strJ_T2400);		//계 (31) 주민세(결정세액+종(전)근무지 기납부세액)
	gcds_report0.namevalue(1,"AMT12")		= (parseInt(strT24000)+parseInt(strJ_T2400))	//계 (31) 소득세+주민세(총)
																			+ (parseInt(strT23000)-parseInt(strJ_T2300));	
  
	gcds_report0.namevalue(1,"CURDT")		=	gs_date;
	gcds_report0.namevalue(1,"REF")			=	gcds_data.namevalue(gcds_data.rowposition,"REF");

	gcrp_print2.preview();
	}
}

/******************************************************************************
	Description : 세액
******************************************************************************/
function ln_TaxAmount(){

	var str0 = gcem_taeyeil.Text;							//퇴직예정일
	
	var str1 = fn_trim(str0.substring(0,6));	//급여년월
	var str2 = '7';														//지급구분[퇴직:7]
	var str3 = fn_trim(gcem_taeyeil.Text);		//지급일자

	if(str1.length < 6 )	{
		alert("퇴직예정일 6자리를 입력해주세요");
		gcem_taeyeil.Focus()
	}else if(str3.length < 8){
		alert("퇴직예정일 8자리를 입력해주세요");
		gcem_taeyeil.Focus()
  }else	{
		//if (gcds_data.countrow>0) {
		//	alert("세액계산이 완료되었습니다.");
		//}else{
			gcds_taxamo.ClearData();
			gcds_taxamo.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040008_s1?"
											 + "v_str1=" + str1
											 + "&v_str2=" + str2
											 + "&v_str3=" + str3
											 + "&v_str4=SP_P300002";
			gcds_taxamo.Reset(); //그리드
		//}
	}
}

/******************************************************************************
	Description : 저장시 데이타 재저장 
	parameter : row - rowposition
******************************************************************************/
function ln_DataResave(row){

		var baeamt = gcds_data.NameValue(row,"BAEAMT1")+
		             gcds_data.NameValue(row,"BAEAMT2")+
		             gcds_data.NameValue(row,"BAEAMT3")+
		             gcds_data.NameValue(row,"BAEAMT4");

		var baeday = gcds_data.NameValue(row,"BAEDAY1")+
		             gcds_data.NameValue(row,"BAEDAY2")+
		             gcds_data.NameValue(row,"BAEDAY3")+
		             gcds_data.NameValue(row,"BAEDAY4");

	 //기본급 평균
	 gcem_AVGAMT.Text = Math.round((gcds_data.NameValue(row,"BASAMT1")+
	 gcds_data.NameValue(row,"BASAMT2")+
	 gcds_data.NameValue(row,"BASAMT3")+
	 gcds_data.NameValue(row,"BASAMT4"))/3);
	
	 //상여금 평균
	 gcem_AVGBOS.Text = Math.round((gcds_data.NameValue(row,"BASBUS1")+
	 gcds_data.NameValue(row,"BASBUS2")+
	 gcds_data.NameValue(row,"BASBUS3")+
	 gcds_data.NameValue(row,"BASBUS4"))/12);
	
	 //기타수당 평균
   gcem_AVGETC.Text = Math.round((baeamt/baeday)*30);		//기타평균 AVGETC

 
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 상여금평균 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 엔터 사번 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 상여금,연차평균 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 계산 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 보고서 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 영수증 출력 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_taxamo classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 세액 프로시져 DataSet-->
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
<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onLoadCompleted(row,colid)">
	var yavg = gcem_yunavg.text;	//년차수당
	var yyyy = txt_yyyy.value;		//근속년수

	var cnt = gcds_data2.namevalue(gcds_data2.rowposition,"COUNT");
	var amt = gcds_data2.namevalue(gcds_data2.rowposition,"AMT");
	var yamt = gcds_data2.namevalue(gcds_data2.rowposition,"YAMT");

	//급여평균
	gcem_payavg.text = (gcds_data.Sum(6,0,0)/3)+"";
	var pavg = gcem_payavg.text;	

	//상여금평균
	gcem_sangavg.text = gcds_data2.namevalue(gcds_data2.rowposition,"S91000");
	var savg = gcem_sangavg.text;	

	//년차수당
	gcem_yunavg.text = yamt;	
	
	//추계퇴직금 
	gcem_chutae_amt.text = (parseInt(pavg) + parseInt(savg) + parseInt(yamt)) * parseInt(yyyy);	
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="조회가 완료 되었습니다.";
	if (gcds_select_ec01az.countRow > 0) {
	} else {
	alert("조회된 데이타가 없습니다.");
	gcem_emo.Text = "";				// 사번
	hid_deptcd.value = "";		//소속코드
	txt_deptnm.value = "";		//소속명
	hid_hocode.value =  "";		//급호코드
	txt_ho.value =  "";				//급호명
	txt_name.value = "";			//성명
	gcem_ipsail.Text = "";		//입사일
	gcem_taesail.Text = "";		//퇴사일
	txt_yyyy.value = "";			//근속년수
	}
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
	gcem_BASAMT_SUM.Text= "";//급여합계
	gcem_BASBUS_SUM.Text= "";//상여합계
	gcem_BAEAMT_SUM.Text= "";//기타수당합계
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	//document.all.LowerFrame.style.visibility="hidden";
	//window.status="조회가 완료 되었습니다.";
	if(gcds_data.countrow <=0)	{
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>
	if(row >0) {
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
		gcds_data.NameValue(row,"BAEAMT4");
	}
</script>

<script language="javascript" for="gcds_select_ec02az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_select_ec02az.countrow <=0)	{
		//	alert("조회된 데이타가 없습니다.");
	}	else 	{
		gcds_select_ec02az.rowposition=1;
	}
</script>

<script language="javascript" for="gcds_select_create" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_create" event="onloadcompleted(row,colid)">
	//계산 후 조회
	ln_Query();
</script>

<script language="javascript" for="gcds_taxamo" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_taxamo" event="onloadcompleted(row,colid)">
	//세액계산 후 조회
	ln_Query();
</script>

<script language=JavaScript for=gcem_emo event=OnKeyDown(kcode,scode)>
   if(kcode==13)   {
		if(gcem_emo.Text== "")		{
			alert("사번을 정확히 입력해주세요");
			gcem_emo.Focus();
		}	else	{
			ln_FindEmp('gcem_emo','2')
		}
	}
</script>

<script language=JavaScript for=gcem_taeyeil event=OnKeyDown(kcode,scode)>
  if(kcode==13)  {
		if(gcem_emo.Text== ""){
			alert("사번을 정확히 입력해주세요");
			gcem_emo.Focus();
		}else	{
			ln_FindEmp('gcem_emo','2')
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
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p040001_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_receipt.gif"	style="cursor:hand" onclick="ln_Print2()">
			<img src="../../Common/img/btn/com_b_taxamo.gif"	style="cursor:hand" onclick="ln_TaxAmount()">
			<img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_calc.gif"		style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Del()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;사번&nbsp;&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:0px; ">
						<comment id="__NSID__"><object id=gcem_emo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:0px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor	value=false>
							<param name=Enable				value=false>
						</object></comment><script>__ws__(__NSID__);</script>
					</td> 
					<td Style="height:23px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;padding-left:4px;"><nobr>&nbsp;<IMG SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="팝업창으로 성명을 검색합니다" onclick="ln_FindEmp('gcem_emo','gcem_taeyeil')" style="cursor:hand;" align=center >&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;퇴직예정일&nbsp;&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_taeyeil  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>  
					<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
				</tr>
			</table>		
			</td>
		</tr>
  <tr> 
  <td height=3><input type=hidden name=hid_hocode><input type=hidden name=hid_deptcd></td>
  </tr>  
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0"      
	   style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
					<td width="30" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;"  bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;소속&nbsp;&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;"><nobr>
						<input type="text" id=txt_deptnm style="width:101px;position:relative;left:2px" class="txt11" disabled>&nbsp;</nobr></td> 
		      <td width="10"   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;" bgcolor="#eeeeee">
						<nobr>&nbsp;급호&nbsp;</nobr></td>
					<td width="10"   style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;"><nobr><input type="text" id=txt_ho style="width:50px;position:relative;left:2px" class="txt11" disabled>&nbsp;</nobr></td>
          <td width="10"   style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee">
						<nobr>&nbsp;성명&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;"><nobr>
						<input type="text" id=txt_name style="position:relative;left:2px;top:0px;width:70px;" class="txt11" disabled>&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;"  bgcolor="#eeeeee">
						<nobr>&nbsp;입사일&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_ipsail classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:-2px;top:2px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ReadOnly	    value=True>
							<param name=Enable	      value=false>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>  
					<td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;" bgcolor="#eeeeee">
						<nobr>&nbsp;퇴사일&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_taesail classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:-2px;top:2px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ReadOnly	    value=True>
							<param name=Enable	      value=false>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script></nobr></td>  
					<td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;" bgcolor="#eeeeee">
						<nobr>&nbsp;근속년수&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;"><nobr><input type="text" id=txt_yyyy  style="position:relative;left:2px;top:0px;width:50px;text-align:right;"  class="txt11" disabled>&nbsp;</nobr></td>
          <td width="10" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px;" bgcolor="#eeeeee">
						<nobr>&nbsp;구분&nbsp;</nobr>
					</td>
					<td>
						<comment id="__NSID__"><object id=gclx_paydiv  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:3px;top:1px;font-size:12px;width:65px;height:150px;">
							<param name=CBData					value="3^퇴직,7^추계,1^중도">
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td width="100%" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px;"><nobr>&nbsp;</td> 					
				</tr>
			</table>	
		</td>
	</tr>
<tr><td height=5></td></tr>
  <tr> 
    <td colspan=2 valign=top> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
		   <td valign=top>
		<table cellpadding="0" cellspacing="0" border="0">
		  <tr>
			  <td colspan=2>
					<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create style="WIDTH: 280px; HEIGHT: 276px;border:1 solid #777777;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data">
						<PARAM NAME="Editable"		VALUE="false">
						<PARAM NAME="ColSizing"		VALUE="true">
            <PARAM NAME="BorderStyle" VALUE="0">
			      <PARAM NAME="Fillarea"		VALUE="true">
			      <PARAM NAME="Format"			VALUE="  
              <C> Name='소속' ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=80 </C>
							<C> Name='성명' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center   </C>
							<C> Name='사번' ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center </C> 
							<C> Name='퇴사일' ID=ENDDT HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=center Mask='XXXX/XX/XX' </C>						
						">
				  </OBJECT></comment><script>__ws__(__NSID__);</script>
		    </td>
			</tr>
			<tr><td height=3></td></tr>  
			<tr>
				<td colspan=2>
		<table width="282" height="482" border= "0" cellpadding=0 cellspacing=0  border=0 style=' height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'> 
			<tr>
        <td style="height:20px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;퇴직사유&nbsp;</nobr></td>
				<td style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><input id="txt_ref" type="text" class=txt21 style="width:200px;"></nobr></td> 
      </tr>
			<tr>
        <td style="height:20px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;사번/성명&nbsp;</nobr></td>
				<td style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT id=txt_empno TYPE=TEXT STYLE="width:60px;" class="txt21" readonly  >&nbsp;&nbsp;&nbsp;/&nbsp;<INPUT TYPE=TEXT STYLE="width:70px; "  id=txt_empnmk class="txt21" readonly  ></nobr></td> 
      </tr>
			<tr>
				<td style="height:25px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;소속/직위&nbsp;</nobr></td>
				<td style="width=30px; height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:100px; "  id=txt_DEPTNM class="txt21"  readonly  >&nbsp;&nbsp;/<INPUT TYPE=TEXT STYLE="width:70px; "  id=txt_PAYGRDNM class="txt21" readonly  ></nobr></td> 
			</tr>
			<tr>
				<td style="height:25px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;입/퇴사일&nbsp;</nobr></td>
				<TD style="border:0 solid #708090;border-bottom-width:1px; border-right-width:0px;"><nobr>
			<table cellspacing=0 cellpadding=0 border=0><tr><td>&nbsp;
				<comment id="__NSID__"><object id=gcem_STRTDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
				<comment id="__NSID__"><object id=gcem_ENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
				<td  width="100%" style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:20px; padding-top:4px;text-align:right;" id=txt_DUYEAR class="txt21" readonly  >&nbsp;&nbsp;년<INPUT TYPE=TEXT STYLE="width:20px;  padding-top:4px;text-align:right;" id=txt_DUYMM class="txt21" readonly  >&nbsp;&nbsp;개월<INPUT TYPE=TEXT STYLE="width:20px; padding-top:4px ;text-align:right;" id=txt_DUDAY class="txt21" readonly  >&nbsp;&nbsp;일&nbsp;</nobr></td> 
			</tr>	
			<tr>
        <td  style="height:23px; width:60px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;주소&nbsp;</nobr></td>
				<td  width="100%" style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:200px; " id=txt_CADDR01 class="txt21" readonly  >&nbsp;</nobr></td> 
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
		<table width="591" border= "0" cellpadding=0 cellspacing=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
			<tr>
				<TD colspan=10 align="left" style="height:20px; border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee">
					<nobr>&nbsp;1.퇴직금계산내역&nbsp;</nobr>
				</TD> 						
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
					<comment id="__NSID__"><object id=gcem_BASAMT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
				<td align=center style=" width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
					<nobr><input type=text id=txt_ref1 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
				<TD align="center" width=90 style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>	
					<comment id="__NSID__"><object id=gcem_BASBUS1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
				<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY1  readonly ></nobr></td>
				<td align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX1  readonly ></nobr></td>
				<td  align=center style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>1st월</nobr></td>
				<TD align="center" width=90 style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
					<comment id="__NSID__"><object id=gcem_BAEAMT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
			</tr>   
			<tr>
			<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY2  readonly  ></nobr></td>
			<td align=center  style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX2  readonly  ></nobr></td>
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>2nd월</nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BASAMT2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
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
			<TD align=center  style="height:20px; width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref2 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BASBUS2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
			<td align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY2  readonly ></nobr></td>
			<td align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX2  readonly ></nobr></td>
			<TD align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>2nd월</nobr></td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BAEAMT2  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
		</tr>   
		<tr>
			<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY3  readonly  ></nobr></td>
			<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX3  readonly  ></nobr></td>
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>3th월</nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BASAMT3  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1		validFeatures="ignoreStatus=yes" validExp=""> 
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td  align=center style=" width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY3  readonly ></nobr></td>
			<td align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX3  readonly ></nobr></td>
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>3th월</nobr></td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT3                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   
		<tr>
			<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY4  readonly  ></nobr></td>
			<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX4  readonly  ></nobr></td>
			<TD align=center  style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>4th월</nobr></td>
			<TD align=center align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASAMT4                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref4 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
			<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS4                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY4  readonly ></nobr></td>
			<td align=center  style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX4  readonly ></nobr></td>
			<TD align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>4th월</nobr></td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT4                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   
		<tr>
			<td colspan=3 align=center  style="height:22px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>년차일수</nobr></td>
			<TD  align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_YEAQTY                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td  align=center style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>년차수당</nobr></td>
			<TD  align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_YEAPAY                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 							 
			<td colspan=3 align=center   style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">평균년차수당</td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><comment id="__NSID__"><object id=gcem_AVGYER                
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
				</object></comment><script>__ws__(__NSID__);</script>
			</TD> 
		</tr>   
		<tr>
			<TD align=center colspan=3  style="height:22px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></TD> 
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASAMT_SUM                 
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS_SUM                
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center colspan=3  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT_SUM                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
		</tr>   
		<tr>
			<TD align=center colspan=3  style="height:22px;border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_AVGAMT                 
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_AVGBOS                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center colspan=3  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_AVGETC                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
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
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   		
	</table>
	<table border= "0" cellpadding=0 cellspacing=0><tr><td height=3></td></tr></table>

<!-- 기타수당 -->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
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
		<td align="center" style="height:23px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_P21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> <!-- 근속수당 -->
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P22000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 자기계발비 -->
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
		<td align="center"  style=" border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr><comment id="__NSID__"><object id=gcem_P24000               
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P29000               
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P38000      
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
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_PX0000      
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 기타 -->
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
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>&nbsp;&nbsp;</nobr></TD></tr>   	
</table>
<table cellpadding=0 cellspacing=0  border=0><tr><td height=3></td></tr></table>

<!-- 지급내역  -->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<td colspan=7 align="left" style="height:20px; width:70px; border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;3.퇴직금정산내역&nbsp;</nobr></td>
	</tr>   
	<tr>
		<td align="center"	style="height:20px; width:81px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>급여</nobr></td>
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>퇴직금</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>년차수당</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>상여</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>지급합계</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>실지급액</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp&nbsp</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_JUSPAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center" style=" border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_S94000
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>&nbsp&nbsp</nobr></TD></tr>   	
	</table>
<table cellpadding=0 cellspacing=0 border=0><tr><td height=3></td></tr></table>

<!--4.공제내역-->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
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
			<comment id="__NSID__"><object id=gcem_T21000  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> <!-- 정산갑근세 -->
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
			</object></comment><script>__ws__(__NSID__);</script></nobr></td>
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_T24000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode		 value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
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
			<comment id="__NSID__"><object id=gcem_BX0010   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px;right:8px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center"  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"><nobr>&nbsp;&nbsp;</nobr></td>
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_S93000                
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
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
</table></div>
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

		<C>Col=PAYDIV	 Ctrl=gclx_paydiv				Param=BindColVal</C>
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
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2710 ,face='굴림' ,size=10 ,penwidth=1
	<T>id='퇴직금 추계내역' ,left=653 ,top=3 ,right=1331 ,bottom=91 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1.인적사항' ,left=47 ,top=194 ,right=259 ,bottom=247 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDR', left=372, top=197, right=1475, bottom=253, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FFFBF0, backcolor=#FFFFFF</C>
	<L> left=22 ,top=184 ,right=1963 ,bottom=184 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=262 ,right=1963 ,bottom=262 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=409 ,right=1963 ,bottom=409 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='직 위 :' ,left=47 ,top=344 ,right=194 ,bottom=400 ,align='left'</T>
	<C>id='PAYGRDNM', left=209, top=344, right=381, bottom=400, align='left'</C>
	<T>id='퇴사일 :' ,left=513 ,top=344 ,right=647 ,bottom=400 ,align='left'</T>
	<C>id='ENDDT', left=663, top=344, right=875, bottom=400, align='left' ,mask='XXXX/XX/XX'</C>
	<T>id='재직기간 :' ,left=925 ,top=344 ,right=1100 ,bottom=400 ,align='left'</T>
	<C>id='JDDAY', left=1113, top=344, right=1553, bottom=400, align='left'</C>
	<T>id='사 유 :' ,left=1575 ,top=344 ,right=1691 ,bottom=400 ,align='left'</T>
	<C>id='REF', left=1700, top=344, right=1938, bottom=400, align='left'</C>
	<L> left=22 ,top=334 ,right=1963 ,bottom=334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=209, top=275, right=381, bottom=331, align='left'</C>
	<T>id='입사일 :' ,left=513 ,top=275 ,right=647 ,bottom=331 ,align='left'</T>
	<T>id='성 명 :' ,left=1575 ,top=275 ,right=1691 ,bottom=331 ,align='left'</T>
	<C>id='EMPNMK', left=1700, top=275, right=1938, bottom=331, align='left'</C>
	<C>id='DEPTNM', left=1113, top=275, right=1553, bottom=331, align='left'</C>
	<T>id='사 번 :' ,left=47 ,top=275 ,right=194 ,bottom=331 ,align='left'</T>
	<C>id='STRTDT', left=663, top=275, right=878, bottom=331, align='left' ,mask='XXXX/XX/XX'</C>
	<T>id='소       속 :' ,left=925 ,top=275 ,right=1100 ,bottom=331 ,align='left'</T>
	<C>id='RESINO', left=1678, top=197, right=1938, bottom=253, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FFFBF0, backcolor=#FFFFFF</C>
	<T>id='주민번호 :' ,left=1500 ,top=197 ,right=1666 ,bottom=253 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<T>id='주소 :' ,left=275 ,top=197 ,right=369 ,bottom=253 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FFFBF0 ,backcolor=#FFFFFF</T>
	<L> left=1963 ,top=184 ,right=1963 ,bottom=400 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=191 ,right=22 ,bottom=403 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='CTITLE', left=1391, top=125, right=1966, bottom=178, align='right' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=22 ,top=503 ,right=1963 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='2.퇴직금 계산내역' ,left=16 ,top=450 ,right=375 ,bottom=503 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BAEAMT_SUM', left=1250, top=937, right=1466, bottom=994, align='right'</C>
	<C>id='AVGYER', left=1250, top=869, right=1466, bottom=925, align='right'</C>
	<C>id='AVGETC', left=1250, top=1006, right=1466, bottom=1062, align='right'</C>
	<C>id='AVGBOS', left=766, top=1006, right=981, bottom=1062, align='right'</C>
	<C>id='YEAPAY', left=766, top=869, right=981, bottom=925, align='right'</C>
	<C>id='BASBUS_SUM', left=766, top=937, right=981, bottom=994, align='right'</C>
	<C>id='AVGAMT', left=281, top=1006, right=494, bottom=1062, align='right'</C>
	<C>id='BASAMT_SUM', left=281, top=937, right=494, bottom=994, align='right'</C>
	<C>id='YEAQTY', left=281, top=869, right=494, bottom=925, align='right'</C>
	<T>id='합계' ,left=519 ,top=937 ,right=741 ,bottom=994</T>
	<T>id='합계' ,left=38 ,top=937 ,right=259 ,bottom=994</T>
	<C>id='BAEAMT4', left=1250, top=800, right=1466, bottom=856, align='right'</C>
	<C>id='BAEAMT3', left=1250, top=734, right=1466, bottom=791, align='right'</C>
	<C>id='BAEAMT2', left=1250, top=666, right=1466, bottom=722, align='right'</C>
	<C>id='BASBUS4', left=766, top=800, right=981, bottom=856, align='right'</C>
	<C>id='BASBUS3', left=766, top=734, right=981, bottom=791, align='right'</C>
	<C>id='BASBUS2', left=766, top=666, right=981, bottom=722, align='right'</C>
	<C>id='BASAMT4', left=281, top=800, right=494, bottom=856, align='right'</C>
	<C>id='BASAMT3', left=281, top=734, right=494, bottom=791, align='right'</C>
	<C>id='BASAMT2', left=281, top=666, right=494, bottom=722, align='right'</C>
	<C>id='BASMAX4', left=1081, top=800, right=1150, bottom=856</C>
	<C>id='BAEDAY4', left=1003, top=800, right=1072, bottom=856</C>
	<C>id='BASMAX3', left=1081, top=734, right=1150, bottom=791</C>
	<C>id='BAEDAY3', left=1003, top=734, right=1072, bottom=791</C>
	<C>id='BAEDAY2', left=1003, top=666, right=1072, bottom=722</C>
	<C>id='BASMAX2', left=1081, top=666, right=1147, bottom=722</C>
	<C>id='BASMAX2', left=109, top=666, right=178, bottom=722</C>
	<C>id='BASDAY2', left=28, top=666, right=97, bottom=722</C>
	<C>id='BASDAY3', left=28, top=734, right=97, bottom=791</C>
	<C>id='BASMAX4', left=113, top=800, right=181, bottom=856</C>
	<C>id='BASMAX3', left=113, top=734, right=181, bottom=791</C>
	<T>id='평균년차수당' ,left=1009 ,top=869 ,right=1231 ,bottom=925</T>
	<T>id='년차일수' ,left=41 ,top=869 ,right=263 ,bottom=925</T>
	<T>id='년차수당' ,left=519 ,top=869 ,right=741 ,bottom=925</T>
	<L> left=1153 ,top=584 ,right=1153 ,bottom=859 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=106 ,top=584 ,right=106 ,bottom=859 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='BASDAY4', left=31, top=800, right=100, bottom=856</C>
	<L> left=22 ,top=506 ,right=22 ,bottom=1072 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=184 ,top=584 ,right=184 ,bottom=859 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1075 ,top=584 ,right=1075 ,bottom=859 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1963 ,top=506 ,right=1963 ,bottom=1069 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1478 ,top=503 ,right=1478 ,bottom=1072 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1241 ,top=584 ,right=1241 ,bottom=1069 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=750 ,top=584 ,right=750 ,bottom=1072 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=272 ,top=584 ,right=272 ,bottom=1069 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='평        균' ,left=38 ,top=1006 ,right=266 ,bottom=1062</T>
	<T>id='평        균' ,left=519 ,top=1006 ,right=747 ,bottom=1062</T>
	<L> left=22 ,top=1072 ,right=1963 ,bottom=1072 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='평        균' ,left=1006 ,top=1006 ,right=1234 ,bottom=1062</T>
	<T>id='합계' ,left=1006 ,top=937 ,right=1234 ,bottom=994</T>
	<L> left=22 ,top=1000 ,right=1963 ,bottom=1000 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='총  평  균  계' ,left=1594 ,top=937 ,right=1863 ,bottom=994</T>
	<L> left=25 ,top=931 ,right=1963 ,bottom=931 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=859 ,right=1963 ,bottom=859 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=22 ,top=794 ,right=1963 ,bottom=794 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=725 ,right=1963 ,bottom=725 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='계  산  내  역' ,left=1594 ,top=666 ,right=1863 ,bottom=722</T>
	<L> left=25 ,top=656 ,right=1963 ,bottom=656 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='기본급 + 직책 + 시간외' ,left=50 ,top=516 ,right=466 ,bottom=572</T>
	<T>id='퇴    직    금' ,left=1594 ,top=516 ,right=1863 ,bottom=572</T>
	<T>id='기타 및 월차수당' ,left=1013 ,top=516 ,right=1463 ,bottom=572</T>
	<T>id='상여금 및 년차수당' ,left=528 ,top=516 ,right=981 ,bottom=572</T>
	<L> left=22 ,top=581 ,right=1963 ,bottom=581 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='BAEAMT1', left=1250, top=597, right=1466, bottom=653, align='right'</C>
	<C>id='BASMAX1', left=1081, top=597, right=1147, bottom=653</C>
	<C>id='BAEDAY1', left=1003, top=597, right=1072, bottom=653</C>
	<C>id='BASBUS1', left=766, top=597, right=981, bottom=653, align='right'</C>
	<C>id='BASAMT1', left=281, top=597, right=494, bottom=653, align='right'</C>
	<C>id='BASMAX1', left=109, top=597, right=178, bottom=653</C>
	<C>id='BASDAY1', left=28, top=597, right=97, bottom=653</C>
	<C>id='JUSRET', left=1556, top=597, right=1828, bottom=653, align='right'</C>
	<L> left=994 ,top=500 ,right=994 ,bottom=1072 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=509 ,top=503 ,right=509 ,bottom=1069 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='CMM4', left=191, top=800, right=269, bottom=856 ,mask='XX월'</C>
	<C>id='CMM3', left=191, top=734, right=269, bottom=791 ,mask='XX월'</C>
	<C>id='CMM2', left=191, top=666, right=269, bottom=722 ,mask='XX월'</C>
	<C>id='CMM1', left=191, top=597, right=269, bottom=653 ,mask='XX월'</C>
	<C>id='CMM1', left=1159, top=597, right=1238, bottom=653 ,mask='XX월'</C>
	<C>id='CMM2', left=1159, top=666, right=1238, bottom=722 ,mask='XX월'</C>
	<C>id='CMM3', left=1159, top=734, right=1238, bottom=791 ,mask='XX월'</C>
	<C>id='CMM4', left=1159, top=800, right=1238, bottom=856 ,mask='XX월'</C>
	<T>id='3.기타수당 내역' ,left=13 ,top=1116 ,right=594 ,bottom=1169 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=53 ,top=1187 ,right=272 ,bottom=1241</T>
	<T>id='자기계발비' ,left=288 ,top=1187 ,right=509 ,bottom=1241</T>
	<T>id='차량유지비' ,left=528 ,top=1187 ,right=750 ,bottom=1241</T>
	<T>id='남북경협수당' ,left=775 ,top=1187 ,right=994 ,bottom=1241</T>
	<T>id='임원직책수당' ,left=1016 ,top=1187 ,right=1238 ,bottom=1241</T>
	<T>id='연장수당' ,left=1259 ,top=1187 ,right=1478 ,bottom=1241</T>
	<L> left=1491 ,top=1172 ,right=1491 ,bottom=1334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=997 ,top=1172 ,right=997 ,bottom=1334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=284 ,top=1172 ,right=284 ,bottom=1334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='P38000', left=1013, top=1262, right=1231, bottom=1319, align='right'</C>
	<C>id='P29000', left=772, top=1262, right=991, bottom=1319, align='right'</C>
	<L> left=22 ,top=1334 ,right=1963 ,bottom=1334 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='P21000', left=50, top=1262, right=266, bottom=1319, align='right'</C>
	<L> left=763 ,top=1172 ,right=763 ,bottom=1334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1244 ,top=1172 ,right=1244 ,bottom=1334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=509 ,top=1172 ,right=509 ,bottom=1334 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='P24000', left=528, top=1262, right=747, bottom=1319, align='right'</C>
	<C>id='P27000', left=1259, top=1262, right=1475, bottom=1319, align='right'</C>
	<C>id='P22000', left=288, top=1262, right=506, bottom=1319, align='right'</C>
	<L> left=22 ,top=1169 ,right=1963 ,bottom=1169 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=25 ,top=1253 ,right=1963 ,bottom=1253 </L>
	<L> left=22 ,top=1172 ,right=22 ,bottom=1334 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1963 ,top=1169 ,right=1963 ,bottom=1334 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='4.퇴직금 정산내역' ,left=16 ,top=1372 ,right=925 ,bottom=1428 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=22 ,top=1431 ,right=1963 ,bottom=1431 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='공                  제   (B)' ,left=1019 ,top=1444 ,right=1938 ,bottom=1500</T>
	<T>id='지                  급   (A)' ,left=47 ,top=1444 ,right=969 ,bottom=1500</T>
	<L> left=22 ,top=1512 ,right=1963 ,bottom=1512 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='확     인' ,left=769 ,top=1525 ,right=975 ,bottom=1578</T>
	<T>id='적     요' ,left=41 ,top=1525 ,right=263 ,bottom=1578</T>
	<T>id='확     인' ,left=1731 ,top=1525 ,right=1950 ,bottom=1578</T>
	<T>id='금               액' ,left=1259 ,top=1525 ,right=1706 ,bottom=1578</T>
	<T>id='적     요' ,left=1013 ,top=1525 ,right=1231 ,bottom=1578</T>
	<L> left=25 ,top=1584 ,right=1963 ,bottom=1584 </L>
	<L> left=1716 ,top=1509 ,right=1716 ,bottom=1591 ,penstyle=dot ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='JUSPAY', left=300, top=1594, right=663, bottom=1647, align='right'</C>
	<T>id='급     여' ,left=41 ,top=1594 ,right=263 ,bottom=1647</T>
	<L> left=25 ,top=1653 ,right=1963 ,bottom=1653 </L>
	<T>id='근로소득정산' ,left=1488 ,top=1594 ,right=1947 ,bottom=1647</T>
	<T>id='퇴직소득정산' ,left=1250 ,top=1594 ,right=1469 ,bottom=1647</T>
	<T>id='금               액' ,left=297 ,top=1525 ,right=744 ,bottom=1578</T>
	<C>id='T21000', left=1528, top=1662, right=1856, bottom=1719, align='right'</C>
	<C>id='T23000', left=1259, top=1662, right=1456, bottom=1719, align='right'</C>
	<T>id='갑 근 세' ,left=1009 ,top=1662 ,right=1228 ,bottom=1719</T>
	<C>id='JUSBOS', left=300, top=1662, right=663, bottom=1719, align='right'</C>
	<T>id='상     여' ,left=41 ,top=1662 ,right=263 ,bottom=1719</T>
	<L> left=25 ,top=1722 ,right=1963 ,bottom=1722 </L>
	<C>id='T22000', left=1528, top=1731, right=1856, bottom=1787, align='right'</C>
	<C>id='T24000', left=1259, top=1731, right=1456, bottom=1787, align='right'</C>
	<T>id='퇴 직 금' ,left=41 ,top=1731 ,right=263 ,bottom=1787</T>
	<T>id='주 민 세' ,left=1009 ,top=1731 ,right=1228 ,bottom=1787</T>
	<L> left=25 ,top=1791 ,right=1963 ,bottom=1791 </L>
	<T>id='년차수당' ,left=41 ,top=1800 ,right=263 ,bottom=1856</T>
	<C>id='JUSYER', left=300, top=1800, right=663, bottom=1856, align='right'</C>
	<T>id='국민연금' ,left=1009 ,top=1800 ,right=1228 ,bottom=1856</T>
	<L> left=25 ,top=1859 ,right=1963 ,bottom=1859 </L>
	<T>id='건강보험' ,left=1009 ,top=1869 ,right=1228 ,bottom=1922</T>
	<L> left=1722 ,top=1794 ,right=1722 ,bottom=2344 ,penstyle=dot ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=1928 ,right=1963 ,bottom=1928 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='고용보험' ,left=1013 ,top=1937 ,right=1231 ,bottom=1994</T>
	<L> left=22 ,top=1997 ,right=1963 ,bottom=1997 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='퇴직전환금' ,left=1009 ,top=2006 ,right=1228 ,bottom=2062</T>
	<T>id='기  타1' ,left=1009 ,top=2075 ,right=1228 ,bottom=2131</T>
	<C>id='S93000', left=1444, top=2281, right=1659, bottom=2337, align='right'</C>
	<T>id='합계 (B)' ,left=1013 ,top=2281 ,right=1231 ,bottom=2337</T>
	<C>id='BX0030', left=1444, top=2212, right=1659, bottom=2269, align='right'</C>
	<T>id='기  타3' ,left=1013 ,top=2212 ,right=1231 ,bottom=2269</T>
	<T>id='기  타2' ,left=1009 ,top=2144 ,right=1228 ,bottom=2200</T>
	<C>id='BX0020', left=1444, top=2144, right=1659, bottom=2200, align='right'</C>
	<L> left=25 ,top=2272 ,right=1963 ,bottom=2272 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=2134 ,right=1963 ,bottom=2134 </L>
	<L> left=25 ,top=2203 ,right=1963 ,bottom=2203 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=2066 ,right=1963 ,bottom=2066 </L>
	<L> left=25 ,top=2347 ,right=1963 ,bottom=2347 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='', left=297, top=2281, right=663, bottom=2337, align='right'</C>
	<T>id='퇴직급이체' ,left=41 ,top=2281 ,right=263 ,bottom=2337</T>
	<T>id='합 계 (A)' ,left=41 ,top=2212 ,right=263 ,bottom=2269</T>
	<C>id='S91000', left=297, top=2212, right=663, bottom=2269, align='right'</C>
	<T>id='차인지급액 (A-B)' ,left=1013 ,top=2359 ,right=1303 ,bottom=2416 ,align='left'</T>
	<C>id='BX0010', left=1444, top=2075, right=1659, bottom=2131, align='right'</C>
	<C>id='RETJUH', left=1444, top=2006, right=1659, bottom=2062, align='right'</C>
	<C>id='P42000', left=1444, top=1937, right=1659, bottom=1994, align='right'</C>
	<C>id='P41000', left=1444, top=1869, right=1659, bottom=1922, align='right'</C>
	<C>id='P43000', left=1444, top=1800, right=1659, bottom=1856, align='right'</C>
	<C>id='S94000', left=1306, top=2359, right=1659, bottom=2416, align='right'</C>
	<L> left=1475 ,top=1584 ,right=1475 ,bottom=1791 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=788 ,top=1512 ,right=788 ,bottom=2347 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=281 ,top=1512 ,right=281 ,bottom=2347 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1241 ,top=1512 ,right=1241 ,bottom=2347 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=25 ,top=2425 ,right=1963 ,bottom=2425 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=988 ,top=1434 ,right=988 ,bottom=2425 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1963 ,top=1431 ,right=1963 ,bottom=2425 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=22 ,top=1431 ,right=22 ,bottom=2425 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='REF1', left=522, top=597, right=734, bottom=653</C>
	<C>id='REF4', left=522, top=800, right=734, bottom=856</C>
	<C>id='REF3', left=522, top=734, right=734, bottom=791</C>
	<C>id='REF2', left=522, top=666, right=734, bottom=722</C>
	<T>id='기타' ,left=1503 ,top=1187 ,right=1722 ,bottom=1241</T>
	<C>id='PX0000', left=1503, top=1262, right=1719, bottom=1319, align='right'</C>
	<C>id='JUSRET', left=300, top=1731, right=663, bottom=1787, align='right'</C>
	<C>id='AMTTXT', left=1697, top=731, right=1944, bottom=787, align='left'</C>
	<C>id='AVG_SUM', left=1556, top=1006, right=1828, bottom=1062, align='right'</C>
	<C>id='AVG_SUM', left=1497, top=731, right=1697, bottom=787, align='right'</C>
</B>
<B>id=Footer ,left=0 ,top=2770 ,right=2000 ,bottom=2870 ,face='굴림' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=9 ,top=19 ,right=1988 ,bottom=97</T>
	<I>id='../../Common/img/icon.jpg' ,left=1591 ,top=0 ,right=1972 ,bottom=94</I>
	<L> left=19 ,top=0 ,right=1966 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분 - 영수증
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<!--param name="DetailDataID"	value="gcds_report2"-->
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2741 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1397 ,top=1616 ,right=1903 ,bottom=1687 ,backcolor=#C0C0C0</X>
	<X>left=459 ,top=203 ,right=500 ,bottom=244 ,border=true</X>
	<X>left=53 ,top=147 ,right=381 ,bottom=244 ,border=true</X>
	<L> left=6 ,top=125 ,right=1903 ,bottom=125 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1334 ,top=150 ,right=1900 ,bottom=150 </L>
	<T>id='관리' ,left=59 ,top=156 ,right=172 ,bottom=194 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=59 ,top=197 ,right=172 ,bottom=234 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=178 ,top=147 ,right=178 ,bottom=241 </L>
	<T>id='퇴직소득원천징수영수증/지급조서' ,left=522 ,top=184 ,right=1297 ,bottom=262 ,align='left' ,face='HY중고딕' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=6 ,top=2491 ,right=1903 ,bottom=2491 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=9 ,top=2634 ,right=1894 ,bottom=2712</T>
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
	<L> left=6 ,top=2637 ,right=1903 ,bottom=2637 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../../Common/img/icon.jpg' ,left=1513 ,top=2641 ,right=1894 ,bottom=2734</I>
	<L> left=931 ,top=1756 ,right=931 ,bottom=2028 </L>
	<L> left=1500 ,top=1756 ,right=1500 ,bottom=2028 </L>
	<L> left=1216 ,top=1756 ,right=1216 ,bottom=2028 </L>
	<L> left=1591 ,top=275 ,right=1591 ,bottom=334 </L>
	<T>id='101-85-10695' ,left=506 ,top=384 ,right=956 ,bottom=444 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='윤만준' ,left=506 ,top=453 ,right=956 ,bottom=512 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서울 종로구 계동 140-2' ,left=506 ,top=522 ,right=1897 ,bottom=581 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현대아산주식회사' ,left=1366 ,top=384 ,right=1897 ,bottom=444 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1366 ,top=453 ,right=1897 ,bottom=512 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	