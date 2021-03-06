<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  경리회계 - 관리항목 Popup
+ 프로그램 ID	:  MTotalbal_popup.html
+ 기 능 정 의	:  관리항목 팝업창.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 
------------------------------------------------------------------------------
+ 수 정 내 용  :	계정원장에서 전표팝업으로 넘어가지 않음.
                  (전표번호와 접수번호 혼동하여 사용함 ==> 수정)
+ 수   정  자  :  정영식
+ 수 정 일 자  :  2007.05.17
----------------------------------------------------------------------------->
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>계정원장 Popup</title>

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
var p_fdcod="";		//지점코드
var p_atcod="";		//계정코드
var p_frdat="";		//검색일자 from
var p_todat="";		//검색일자 to
var ref_cd1="";		//관리항목1 코드
var ref_va1="";		//관리항목1 값
var ref_cd2="";		//관리항목2 코드
var ref_va2="";		//관리항목2 값
var ref_cd3="";		//관리항목3 코드
var ref_va3="";		//관리항목3 값
var ref_cnt="";		//관리항목 CNT
var chk_prt="";		//출력구분
//get_cookdata();
var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments;

	ln_SetDataHeader();
	
	p_fdcod = strParam[0];	//지점코드
	p_atcod = strParam[1];	//계정코드
	p_frdat = strParam[2];	//일자 from
	p_todat = strParam[3];	//일자 to
	ref_cd1 = strParam[4];	//관리항목1 코드
	ref_va1 = strParam[5];	//관리항목1 값
	ref_cd2 = strParam[6];	//관리항목2 코드
	ref_va2 = strParam[7];	//관리항목2 값
	ref_cd3 = strParam[8];	//관리항목3 코드
	ref_va3 = strParam[9];	//관리항목3 값
	ref_chk = strParam[10];	//잔액장[A],원장[B] 구분
	ref_cnt = strParam[11]; //관리항목 CNT	
	
	ln_Before(ref_cnt);
	
	if (ref_chk == "A") {
		gclx_fsrefcd1.Enable = true;
		gclx_fsrefva1.Enable = true;
		gclx_fsrefcd2.Enable = false;
		gclx_fsrefva2.Enable = false;
		gclx_fsrefcd3.Enable = false;
		gclx_fsrefva3.Enable = false;
		gclx_fsrefcd1.BindColVal = ref_cd1;	//관리항목1
		ref_cnt = '1';
	}else if (ref_chk == "B") {
		gclx_fsrefcd2.Enable = false;	
		gclx_fsrefva2.Enable = false;
		gclx_fsrefcd3.Enable = false;
		gclx_fsrefva3.Enable = false;
		if(ref_cnt=="1") {
			gclx_fsrefcd1.Enable = true;
			gclx_fsrefva1.Enable = true;
			gclx_fsrefcd1.BindColVal = ref_cd1;	//관리항목1
		}else if(ref_cnt=="2") {
			gclx_fsrefcd1.Enable = true;
			gclx_fsrefva1.Enable = true;
			gclx_fsrefcd2.Enable = true;
			gclx_fsrefva2.Enable = true;
			gclx_fsrefcd1.BindColVal = ref_cd1;	//관리항목1	
			gclx_fsrefcd2.BindColVal = ref_cd2;	//관리항목2
		}else if(ref_cnt=="3") {
			gclx_fsrefcd1.Enable = true;
			gclx_fsrefva1.Enable = true;
			gclx_fsrefcd2.Enable = true;
			gclx_fsrefva2.Enable = true;
			gclx_fsrefcd3.Enable = true;
			gclx_fsrefva3.Enable = true;
			gclx_fsrefcd1.BindColVal = ref_cd1;	//관리항목1
			gclx_fsrefcd2.BindColVal = ref_cd2;	//관리항목2
			gclx_fsrefcd3.BindColVal = ref_cd3;	//관리항목3	
		}
	}

	ln_RefValQuery(ref_cnt);

	gclx_sfdcode.BindColVal = p_fdcod;	//지점코드
	gcem_staxdatfr.text = p_frdat;			//기간fr
	gcem_staxdatto.text = p_todat;			//기간to

	ln_CurActcode(p_atcod);
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
  
	var str1  = gclx_sfdcode.BindColVal;	
	var str2  = gcem_staxdatfr.text;			
	var str3  = gcem_staxdatto.text;
	var str4  = gcem_curatcode_fr01.text;
	var str5  = str2.substring(0,4);
	var str6  = "";												//전기이월
	var str7  = gclx_fsrefcd1.bindcolval;	//관리항목1 코드
	var str8  = gclx_fsrefva1.bindcolval;	//관리항목1 값
	var str9  = gclx_fsrefcd2.bindcolval;	//관리항목2 코드
	var str10 = gclx_fsrefva2.bindcolval;	//관리항목2 값
	var str11 = gclx_fsrefcd3.bindcolval;	//관리항목3 코드
	var str12 = gclx_fsrefva3.bindcolval;	//관리항목3 값
	var str13 = "";												//관리항목 CNT

	if(str7!='' && str9=='' && str11==''){
		str13 = '1';
	}else if(str7!='' && str9!='' && str11=='') {
		str13 = '2';
	}else if(str7!='' && str9!='' && str11!='') {
		str13 = '3';
	}

	if (str2.substring(6,8) =="01") {
		str6 = Number(str2.substring(0,6)-1)+"31";
	}else{
		str6 = Number(str2-1);
	}

	if(str2 != "" && str3 != "" && str4 != "") {
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												  + "&v_str2="+str2
																												 + "&v_str3="+str3
																												 + "&v_str4="+str4
																												 + "&v_str5="+str5
																												 + "&v_str6="+str6
																												 + "&v_str7="+str7
																												 + "&v_str8="+str8
																												 + "&v_str9="+str9
																												 + "&v_str10="+str10
																												 + "&v_str11="+str11
																												 + "&v_str12="+str12
																												 + "&v_str13="+str13;
		gcds_data1.Reset();
	}else{
		alert("계정코드를 선택하십시오.");
	}
}

/******************************************************************************************
	Description : 조회 - 최초조회
******************************************************************************************/
function ln_Query2(){
  
	var str1  = gclx_sfdcode.BindColVal;	
	var str2  = gcem_staxdatfr.text;			
	var str3  = gcem_staxdatto.text;
	var str4  = gcem_curatcode_fr01.text;
	var str5  = str2.substring(0,4);
	var str6  = "";												//전기이월
	var str7  = gclx_fsrefcd1.bindcolval;	//관리항목1 코드
	var str8  = ref_va1;									//관리항목1 값
	var str9  = gclx_fsrefcd2.bindcolval;	//관리항목2 코드
	var str10 = ref_va2;									//관리항목2 값
	var str11 = gclx_fsrefcd3.bindcolval;	//관리항목3 코드
	var str12 = ref_va3;									//관리항목3 값
	var str13 = ref_cnt;									//관리항목 CNT

	if (str2.substring(6,8) =="01") {
		str6 = Number(str2.substring(0,6)-1)+"31";
	}else{ str6 = Number(str2-1);	}

	if(str2 != "" && str3 != "" && str4 != "") {
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												 + "&v_str2="+str2
																												 + "&v_str3="+str3
																												 + "&v_str4="+str4
																												 + "&v_str5="+str5
																												 + "&v_str6="+str6
																												 + "&v_str7="+str7
																												 + "&v_str8="+str8
																												 + "&v_str9="+str9
																												 + "&v_str10="+str10
																												 + "&v_str11="+str11
																												 + "&v_str12="+str12
																												 + "&v_str13="+str13;
		//prompt('',gcds_data1.DataID)
		gcds_data1.Reset();
	}
}


/******************************************************************************************
	Description : 조회 - 관리항목 코드 조회
******************************************************************************************/
function ln_RefQuery(e){
	//관리항목1[검색]
	gcds_fscd01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e;
	gcds_fscd01.Reset();

	//관리항목2[검색]
	gcds_fscd02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e;
	gcds_fscd02.Reset();

	//관리항목3[검색]
	gcds_fscd03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e;
	gcds_fscd03.Reset();
}

/******************************************************************************************
	Description : 조회 - 관리항목 값 조회
	Parameter   : scnt:항목갯수
******************************************************************************************/
function ln_RefValQuery(scnt){
	if(scnt>=1) {	//관리항목1 값[검색]
		gcds_fsva01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd1.bindcolval;
		gcds_fsva01.Reset();

		gclx_fsrefva1.bindcolval = ref_va1;	//관리항목1값
	}

	if(scnt>=2) {	//관리항목2 값[검색]
		gcds_fsva02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd2.bindcolval;
		gcds_fsva02.Reset();
		
		gclx_fsrefva1.bindcolval = ref_va1;	//관리항목1값
		gclx_fsrefva2.bindcolval = ref_va2;	//관리항목1값
	}

	if(scnt>=3) {	//관리항목3 값[검색]
		gcds_fsva03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd3.bindcolval;
		gcds_fsva03.Reset();
		
		gclx_fsrefva1.bindcolval = ref_va1;	//관리항목1값
		gclx_fsrefva2.bindcolval = ref_va2;	//관리항목2값
		gclx_fsrefva3.bindcolval = ref_va3;	//관리항목3값
	}
}

/******************************************************************************
	Description : Enable 
******************************************************************************/
function ln_Enable(e){
	gclx_fsrefcd1.enable = true;
	gclx_fsrefva1.enable = true;
	gclx_fsrefcd2.enable = false;
	gclx_fsrefva2.enable = false;
	gclx_fsrefcd3.enable = false;
	gclx_fsrefva3.enable = false;
	
	if(e=='1'){
		gclx_fsrefcd1.enable = true;
		gclx_fsrefva1.enable = true;
		
		gclx_fsrefva2.bindcolval = "";
		gclx_fsrefva3.bindcolval = "";
	}else if(e=='2') {
		gclx_fsrefcd1.enable = true;
		gclx_fsrefva1.enable = true;
		gclx_fsrefcd2.enable = true;
		gclx_fsrefva2.enable = true;
		
		gclx_fsrefva3.bindcolval = "";
	}else if(e>=3) {
		gclx_fsrefcd1.enable = true;
		gclx_fsrefva1.enable = true;
		gclx_fsrefcd2.enable = true;
		gclx_fsrefva2.enable = true;
		gclx_fsrefcd3.enable = true;
		gclx_fsrefva3.enable = true;
	}
}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************************
	Description : 조회 - 출력
******************************************************************************************/
function ln_BefoPrtQuery(){
	gcds_print.ClearData();
	for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1  = gclx_sfdcode.BindColVal;	
		var str2  = gcem_staxdatfr.text;			
		var str3  = gcem_staxdatto.text;
		var str4  = gcds_temp.namevalue(i,"ATCODE");
		var str5  = str2.substring(0,4);
		var str6  = "";												//전기이월
		var str7  = gclx_fsrefcd1.bindcolval;	//관리항목1 코드
		var str8  = ref_va1;									//관리항목1 값
		var str9  = gclx_fsrefcd2.bindcolval;	//관리항목2 코드
		var str10 = ref_va2;									//관리항목2 값
		var str11 = gclx_fsrefcd3.bindcolval;	//관리항목3 코드
		var str12 = ref_va3;									//관리항목3 값
		var str13 = ref_cnt;									//관리항목 CNT

		if (str2.substring(6,8) =="01") {	
			str6 = Number(str2.substring(0,6)-1)+"31";
		}else{ str6 = Number(str2-1);	}
			
		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												 + "&v_str2=" +str2+ "&v_str3="+str3
																												 + "&v_str4=" +str4+ "&v_str5="+str5
																												 + "&v_str6=" +str6+ "&v_str7="+str7
																												 + "&v_str8=" +str8+ "&v_str9="+str9
																												 + "&v_str10="+str10+"&v_str11="+str11
																												 + "&v_str12="+str12+"&v_str13="+str13;
			gcds_data2.Reset();
		}
	}
	//chk_prt = "1";
}

/******************************************************************************************
	Description : 조회 - 출력
******************************************************************************************/
function ln_PrtQuery(){
	gcds_print.ClearData();
	for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1  = gclx_sfdcode.BindColVal;	
		var str2  = gcem_staxdatfr.text;			
		var str3  = gcem_staxdatto.text;
		var str4  = gcds_temp.namevalue(i,"ATCODE");
		var str5  = str2.substring(0,4);
		var str6  = "";												//전기이월
		var str7  = gclx_fsrefcd1.bindcolval;	//관리항목1 코드
		var str8  = gclx_fsrefva1.bindcolval;	//관리항목1 값
		var str9  = gclx_fsrefcd2.bindcolval;	//관리항목2 코드
		var str10 = gclx_fsrefva2.bindcolval;	//관리항목2 값
		var str11 = gclx_fsrefcd3.bindcolval;	//관리항목3 코드
		var str12 = gclx_fsrefva3.bindcolval;	//관리항목3 값
		var str13 = "";												//관리항목 CNT

		if(str7!='' && str9=='' && str11==''){
			str13 = '1';
		}else if(str7!='' && str9!='' && str11=='') {
			str13 = '2';
		}else if(str7!='' && str9!='' && str11!='') {
			str13 = '3';
		}

		if (str2.substring(6,8) =="01") {	str6 = Number(str2.substring(0,6)-1)+"31";
		}else{ str6 = Number(str2-1);	}
			
		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>mtotalbal_popup_s1?v_str1="+str1
																												 + "&v_str2=" +str2+ "&v_str3="+str3
																												 + "&v_str4=" +str4+ "&v_str5="+str5
																												 + "&v_str6=" +str6+ "&v_str7="+str7
																												 + "&v_str8=" +str8+ "&v_str9="+str9
																												 + "&v_str10="+str10+"&v_str11="+str11
																												 + "&v_str12="+str12+"&v_str13="+str13;
			gcds_data2.Reset();
		}
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	if(chk_prt=="1") {
		ln_PrtQuery();			//출력
	}else{
		ln_BefoPrtQuery()		//선출력
	}

	if(gcds_print.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		gcds_print.namevalue(1,"ATKORNAM") = txt_curatkornam_to01.value;
		gcds_print.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
		gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr.text + gcem_staxdatto.text;
		gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		gcrp_print.preview(); 
	}
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "ATDECR:STRING,ATCODE:STRING,ATKORNAM:STRING,ACTDAT:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVLA:DECIMAL,"
						 + "REMARK:STRING,VENDER:STRING,LEVELS:STRING,FDCODE:STRING,"
						 + "FSDAT:STRING,FSNBR:STRING,FSNBRDT:STRING,FDCODENM:STRING,"
						 + "CURDT:STRING,CURDT2:STRING;SSDAT:STRING,SSNBR:STRING";
	gcds_print.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("계정원장","",2);
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(e){
	//지점코드[검색]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//관리항목1[검색]
	if(ref_cnt=="1" || ref_cnt=="2" || ref_cnt=="3") {
		gcds_fscd01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p_atcod;
		gcds_fscd01.Reset();
	}

	//관리항목2[검색]
	if(ref_cnt=="2" || ref_cnt=="3") {
		gcds_fscd02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p_atcod;
		gcds_fscd02.Reset();
	}

	//관리항목3[검색]
	if(ref_cnt=="3") {
		gcds_fscd03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p_atcod;
		gcds_fscd03.Reset();
	}
}

/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
**********************************************************************************************/
function ln_Popup(p2,p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];

					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					ln_CurActcode('1');				//현재계정 조회
					ln_RefQuery(arrParam[0]);	//관리항목 조회
					ln_Enable(Number(gcds_fscd01.countrow-1));
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					ln_CurActcode('1');				//현재계정 조회
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				txt_atkornam_fr01.value ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}
		}
	}
}

/******************************************************************************
	Description : 현재계정 조회
******************************************************************************/
function ln_CurActcode(e){
	if(e=="1"){
		var str1 = gcem_atcode_fr01.text;	
		var str2 = gcem_atcode_to01.text;	
	}else{
		var str1 = p_atcod;	
		var str2 = p_atcod;	
	}
	gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s0?v_str1="+str1+"&v_str2="+str2;
	gcds_temp.Reset();
}

/***********************************************************************************************
	Description : 전표 찾기
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_Popup2(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = fsdt;
	arrParam[2] = fnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:580px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : 누계
******************************************************************************/
function ln_Cumulative(){
	var row1 = gcds_data1.rowposition;
	var row  = gcds_data1.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*잔액계산*/
		if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//차변:월계
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;  //차변:누계
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//대변:월계
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//대변:누계
		}

		/*월계-누계*/			
		if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_data1.namevalue(i,"ACTDAT") = "전기이월";
		}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*월계*/
			if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_data1.namevalue(i,"ACTDAT") = "월계";

			/*누계*/
			}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_data1.namevalue(i,"ACTDAT") = "누계";
				l_33 = l_33+gcds_data1.namevalue(i,"DETOT");	//차
				r_33 = r_33+gcds_data1.namevalue(i,"CRTOT");	//대
				gcds_data1.namevalue(i,"DETOT") = l_33;
				gcds_data1.namevalue(i,"CRTOT") = r_33;
				if(gcds_data1.namevalue(i,"ATDECR") == "1") {
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//누계잔액
				}else{
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//누계잔액
				}
				if(gcds_data1.namevalue(1,"ACTDAT") == "전기이월") {
					gcds_data1.namevalue(i,"DETOT") = gcds_data1.namevalue(1,"DETOT")+gcds_data1.namevalue(i,"DETOT");
					gcds_data1.namevalue(i,"CRTOT") = gcds_data1.namevalue(1,"CRTOT")+gcds_data1.namevalue(i,"CRTOT");
					if(gcds_data1.namevalue(i,"ATDECR") == "1") {
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//누계잔액
					}else{
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//누계잔액
					}
				}
			}
		}
	}

	/*전기이월*/	
	if (gcds_data1.namevalue(1,"ACTDAT") != "전기이월") {	//전기이월 0일때
		gcds_data1.InsertRow(1);
		gcds_data1.namevalue(1,"ACTDAT") = "전기이월";
		gcds_data1.namevalue(1,"ATCODE") = gcds_data1.namevalue(2,"ATCODE");
		gcds_data1.namevalue(1,"DETOT")  = 0;
		gcds_data1.namevalue(1,"CRTOT")  = 0;
		gcds_data1.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : 누계
******************************************************************************/
function ln_Cumulative2(){
	var row1 = gcds_print.rowposition;
	var row  = gcds_print.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*잔액계산*/
		if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//차변:월계
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;  //차변:누계
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//대변:월계
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//대변:누계
		}

		/*월계-누계*/			
		if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_print.namevalue(i,"ACTDAT") = "전기이월";
		}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*월계*/
			if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_print.namevalue(i,"ACTDAT") = "월계";

			/*누계*/
			}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_print.namevalue(i,"ACTDAT") = "누계";
				l_33 = l_33+gcds_print.namevalue(i,"DETOT");	//차
				r_33 = r_33+gcds_print.namevalue(i,"CRTOT");	//대
				gcds_print.namevalue(i,"DETOT") = l_33;
				gcds_print.namevalue(i,"CRTOT") = r_33;
				if(gcds_print.namevalue(i,"ATDECR") == "1") {
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//누계잔액
				}else{
					gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//누계잔액
				}
				if(gcds_print.namevalue(1,"ACTDAT") == "전기이월") {
					gcds_print.namevalue(i,"DETOT") = gcds_print.namevalue(1,"DETOT")+gcds_print.namevalue(i,"DETOT");
					gcds_print.namevalue(i,"CRTOT") = gcds_print.namevalue(1,"CRTOT")+gcds_print.namevalue(i,"CRTOT");
					if(gcds_print.namevalue(i,"ATDECR") == "1") {
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//누계잔액
					}else{
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//누계잔액
					}
				}
			}
		}
	}

	/*전기이월*/	
	if (gcds_print.namevalue(1,"ACTDAT") != "전기이월") {	//전기이월 0일때
		gcds_print.InsertRow(1);
		gcds_print.namevalue(1,"ACTDAT") = "전기이월";
		gcds_print.namevalue(1,"ATCODE") = gcds_print.namevalue(2,"ATCODE");
		gcds_print.namevalue(1,"DETOT")  = 0;
		gcds_print.namevalue(1,"CRTOT")  = 0;
		gcds_print.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_data1.rowposition;
		window.returnValue = gcds_data1.namevalue(row,"ATCODE")  + ";" 
	                   	 + gcds_data1.namevalue(row,"ATKORNAM")+ ";" 
											 + gcds_data1.namevalue(row,"ATDECR")  + ";"
											 + gcds_data1.namevalue(row,"ATUPCODE");
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<!-- <PARAM NAME="SubsumExpr"	VALUE="1:LEVELS,2:ACTDAT"> -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fscd01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fscd02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fscd03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsva01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsva02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsva03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030022_t1(I:USER=gcds_data1)"> 
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
		ln_Cumulative();	//누계
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row>0) { 
		if (gcds_print.countrow<1) {
			for(i=1;i<=gcds_data2.countrow;i++){
				gcds_print.ImportData(gcds_data2.ExportData(i,1,false));
				gcds_print.namevalue(i,"FSNBRDT")  = gcds_data2.namevalue(i,"SSDAT")+gcds_data2.namevalue(i,"SSNBR");
			}
			ln_Cumulative2();	//누계
		}else{
			gcds_print.ImportData(gcds_data2.ExportData(1,gcds_data2.CountRow,false));
			ln_Cumulative2();	//누계
		}
	}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gclx_sfdcode.BindColVal = p_fdcod;
</script>

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	ln_Query2();
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="전체";
	gclx_sfdcode.index=0;
</script>

<script language="javascript" for="gcds_fscd01" event="onloadCompleted(row,colid)">
	gcds_fscd01.InsertRow(1);
	gcds_fscd01.NameValue(1,"CDCODE")="";
	gcds_fscd01.NameValue(1,"CDNAM") ="";
	gclx_fsrefcd1.index=0;
</script>

<script language="javascript" for="gcds_fscd02" event="onloadCompleted(row,colid)">
	gcds_fscd02.InsertRow(1);
	gcds_fscd02.NameValue(1,"CDCODE")="";
	gcds_fscd02.NameValue(1,"CDNAM") ="";
	gclx_fsrefcd2.index=0;
</script>

<script language="javascript" for="gcds_fscd03" event="onloadCompleted(row,colid)">
	gcds_fscd03.InsertRow(1);
	gcds_fscd03.NameValue(1,"CDCODE")="";
	gcds_fscd03.NameValue(1,"CDNAM") ="";
	gclx_fsrefcd3.index=0;
</script>

<script language="javascript" for="gcds_fsva01" event="onloadCompleted(row,colid)">
	gcds_fsva01.InsertRow(1);
	gcds_fsva01.NameValue(1,"CDCODE")="";
	gcds_fsva01.NameValue(1,"CDNAM") ="";
	gclx_fsrefva1.index=0;
</script>

<script language="javascript" for="gcds_fsva02" event="onloadCompleted(row,colid)">
	gcds_fsva02.InsertRow(1);
	gcds_fsva02.NameValue(1,"CDCODE")="";
	gcds_fsva02.NameValue(1,"CDNAM") ="";
	gclx_fsrefva2.index=0;
</script>

<script language="javascript" for="gcds_fsva03" event="onloadCompleted(row,colid)">
	gcds_fsva03.InsertRow(1);
	gcds_fsva03.NameValue(1,"CDCODE")="";
	gcds_fsva03.NameValue(1,"CDNAM") ="";
	gclx_fsrefva3.index=0;
</script>

<script language=JavaScript for="gclx_fsrefcd1" event=OnCloseUp()>
	if (gclx_fsrefcd1.bindcolval!=""){
	gcds_fsva01.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd1.bindcolval;
	gcds_fsva01.Reset();
	}
</script>

<script language=JavaScript for="gclx_fsrefcd2" event=OnCloseUp()>
	if (gclx_fsrefcd2.bindcolval!=""){
	gcds_fsva02.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd2.bindcolval;
	gcds_fsva02.Reset();
	}
</script>

<script language=JavaScript for="gclx_fsrefcd3" event=OnCloseUp()>
	if (gclx_fsrefcd3.bindcolval!=""){
	gcds_fsva03.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd3.bindcolval;
	gcds_fsva03.Reset();
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	//ln_Close('A');
	var row = gcds_data1.rowposition;
	var p_fcod = gcds_data1.namevalue(row,"FDCODE");	//지점코드
	var p_fsdt = gcds_data1.namevalue(row,"FSDAT");		//접수일자
	var p_fnbr = gcds_data1.namevalue(row,"FSNBR");		//접수번호

	//var p_fsdt = gcds_data1.namevalue(row,"SSDAT");		//일자
	//var p_fnbr = gcds_data1.namevalue(row,"SSNBR");		//등록번호
	//alert("p_fsdt::"+p_fsdt);
	//alert("p_fnbr::"+p_fnbr);

	
	ln_Popup2(p_fcod,p_fsdt,p_fnbr);	//전표 Popup
</script>

<script language=JavaScript for="gcgd_disp01" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()">
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030022_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
	<tr><td colspan="2" height="1px"></td></tr>
</table>

<table cellpadding="0" cellspacing="0" border="0">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:865px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab22" width="220px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
				</td>
			</tr>

			<tr> 				
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td class="tab23" colspan="5" width="490px">
					<comment id="__NSID__"><object id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:4px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:7px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;left:5;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					~&nbsp;
				 <comment id="__NSID__"><object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
				</td>
				<td class="tab12" width="60px" align=left>
					<img src="../../Common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,-1); ln_RefQuery(gcem_curatcode_fr01.text); ln_Enable(Number(gcds_fscd01.countrow-1));">
					<img src="../../Common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,1); ln_RefQuery(gcem_curatcode_fr01.text); ln_Enable(Number(gcds_fscd01.countrow-1));">
				</td>
				<td class="tab12" width="80px" bgcolor="#eeeeee">현재계정</td>
				<td width="170px">
					<comment id="__NSID__"><object  id=gcem_curatcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:3px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<input id="txt_curatkornam_to01" type="text" class="txtbox"  style= "position:relative;left:8px;top:-2px;width:105px;height:20px;" maxlength="36"  disabled>
				</td>
			</tr>
			</table>
				</td>
			</tr>
		<td>
		<tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;top:-3px;width:865px;border:1 solid #708090;">
			<tr> 				
				<td class="tab11" style="height:25px;width:75px;" bgcolor="#eeeeee">관리항목1</td>
				<td class="tab21" colspan="2" width="206px">
					<comment id="__NSID__"><object  id=gclx_fsrefcd1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:4px;top:0px;font-size:12px;width:195px;">
						<param name=ComboDataID			value="gcds_fscd01">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value=CDNAM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value=CDCODE>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">관리항목2</td>
				<td class="tab21" width="210px" align=left>
					<comment id="__NSID__"><object  id=gclx_fsrefcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fscd02">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">관리항목3</td>
				<td class="tab22" width="211px">
					<comment id="__NSID__"><object  id=gclx_fsrefcd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fscd03">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr> 				
				<td class="tab12" style="height:25px;width:75px;" bgcolor="#eeeeee">관리항목1 값</td>
				<td class="tab23" colspan="2" width="206px">
					<comment id="__NSID__"><object  id=gclx_fsrefva1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:4px;top:0px;font-size:12px;width:195px;">
						<param name=ComboDataID			value="gcds_fsva01">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value=CDNAM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value=CDCODE>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">관리항목2 값</td>
				<td class="tab23" width="210px" align=left>
					<comment id="__NSID__"><object  id=gclx_fsrefva2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fsva02">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">관리항목3 값</td>
				<td width="211px">
					<comment id="__NSID__"><object  id=gclx_fsrefva3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:202px;">
						<param name=ComboDataID			value="gcds_fsva03">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort            value="false">
						<param name=ListExprFormat	value="CDNAM^0^200">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
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
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:280px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="false">
						<PARAM NAME="Format"			VALUE="  
						<C> Name='일자'				ID=ACTDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center SumBgColor=#C3D0DB SumText='월계' </C> 
						<C> Name='전표번호'		ID={IF(SSDAT='','',SSDAT&'-'&SSNBR)}			HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=center SumBgColor=#C3D0DB SumText=''   </C> 
						<C> Name='접수일자'		ID=FSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=center SumBgColor=#C3D0DB SumText=''   SHOW=FALSE</C> 
						<C> Name='접수번호'		ID=FSNBR		HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=center SumBgColor=#C3D0DB SumText=''   SHOW=FALSE</C> 
						<C> Name='적요'				ID=REMARK			HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left	 SumBgColor=#C3D0DB SumText=''   </C> 
						<C> Name='거래처명'		ID=VENDER			HeadAlign=Center HeadBgColor=#B9D4DC Width=168	align=left	 SumBgColor=#C3D0DB SumText=''   </C> 
						<C> Name='차변'				ID=DETOT 			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right	 SumBgColor=#C3D0DB SumText=@sum </C> 
						<C> Name='대변'				ID=CRTOT 			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right	 SumBgColor=#C3D0DB SumText=@sum </C> 
						<C> Name='잔액'				ID=SLPVLA			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  SumBgColor=#C3D0DB SumText=@sum </C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset><!-- mask={decode(ACTDAT,'전기이월','XXXX','XXXX/XX/XX')} -->
					</td>
				</tr>

				<tr><td height="4px"></td></tr>
				<tr>
					<td height="30px;" align="center">
						<!-- <img name="btn_select" border="0" src="../../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')"> -->
						<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
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
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
		<C>Col=ATCODE				Ctrl=gcem_curatcode_fr01				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_curatkornam_to01				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=372 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=859, top=119, right=2003, bottom=166 ,mask='(  기간 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계  정  원  장' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=72 ,top=372 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=72 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='잔  액' ,left=2447 ,top=291 ,right=2803 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='대  변' ,left=2078 ,top=291 ,right=2434 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='차  변' ,left=1709 ,top=291 ,right=2066 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적  요' ,left=616 ,top=291 ,right=1272 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='일  자' ,left=78 ,top=291 ,right=278 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2809 ,top=284 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2441 ,top=284 ,right=2441 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=284 ,right=2072 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1703 ,top=284 ,right=1703 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=72 ,top=284 ,right=72 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=284 ,top=284 ,right=284 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=609 ,top=284 ,right=609 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=181, right=2806, bottom=228, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=72, top=181, right=919, bottom=228, align='left' ,mask='지      점: XXXXXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전표번호' ,left=291 ,top=291 ,right=603 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1278 ,top=284 ,right=1278 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='거래처명' ,left=1284 ,top=291 ,right=1697 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='ATKORNAM', left=72, top=228, right=919, bottom=281, align='left' ,mask='계정과목: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=72 ,top=0 ,right=72 ,bottom=50 </L>
	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>
	<C>id='SLPVLA', left=2447, top=0, right=2803, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2441 ,top=0 ,right=2441 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRTOT', left=2078, top=0, right=2434, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1709, top=0, right=2066, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1703 ,top=0 ,right=1703 ,bottom=50 </L>
	<C>id='ACTDAT', left=78, top=0, right=278, bottom=44, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=284 ,top=0 ,right=284 ,bottom=50 </L>
	<L> left=72 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='FSNBRDT', left=291, top=0, right=603, bottom=44, align='left' ,mask='XXXXXXXXX-XXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=609 ,top=0 ,right=609 ,bottom=50 </L>
	<C>id='VENDER', left=1284, top=0, right=1697, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1278 ,top=0 ,right=1278 ,bottom=50 </L>
	<C>id='REMARK', left=616, top=0, right=1272, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=72 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>
	<L> left=72 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 