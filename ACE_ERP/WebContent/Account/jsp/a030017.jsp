<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  결산관리-거래처원장	(잔액/내용)
+ 프로그램 ID	:  A030023.html
+ 기 능 정 의	:  거래처원장 조회 및 출력 
+ 작   성  자 :  하민숙 
+ 서 블 릿 명	:	 a030023_s1, a030023_s2
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 누계적용  
+ 수   정  자 :  정 영 식
+ 수 정 일 자 :  2006.02.09
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 쿼리수정과 거래처별잔액,거래처별내용,거래처별채권채무 추가  
+ 수   정  자 :  구 자 헌
+ 수 정 일 자 :  2006.02.20
+ 서 블 릿 명 :  a030023_s3, a030023_s4, a030023_s5
-----------------------------------------------------------------------------
+ 수 정 내 용  :	 개선사항 수정 및 출력물 수정  
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.10
------------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>채권채무내역</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //현재달, to
var gs_date3 = gcurdate.substring(0,4) + "01"; //첫달, from
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var  p_fcode;
var	 p_fsdt;
var	 p_fnbr;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	//ln_DispChk(0);
	ln_Before();
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(s){

	if(s=="01") {
    if(fn_trim(txt_scccode1.value) == "") {alert("거래처선택은 필수항목입니다"); txt_scccode1.focus(); return; 
		}else{
		var str11 = gclx_sfdcode1.BindColVal;        //	지점코드
		var str12 = gcem_staxdatfr1.text;	           // 	기간from 
		var str13 = gcem_staxdatto1.text;            //  기간to		
		var str14 = txt_scccode1.value;              // 거래처
		var str15 = gcem_atcode_fr01.text;          //	계정과목from
		var str16 = gcem_atcode_to01.text;          //  계정과목to
		/***
		gcds_data1.DataID = "/services/servlet/Account.a030023_s1?v_str1="+str11
														                              + "&v_str2="+str12
														                              + "&v_str3="+str13
															                            + "&v_str4="+str14
														                              + "&v_str5="+str15
														                           	  + "&v_str6="+str16;
		gcds_data1.Reset();
    ***/

    gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s11?v_str1="+str11
														                              + "&v_str2="+str12
														                              + "&v_str3="+str13
															                            + "&v_str4="+str14
														                              + "&v_str5="+str15
														                           	  + "&v_str6="+str16;
		gcds_data1.Reset();



		}
	}else if(s=="02") {

   if(fn_trim(txt_scccode3.value) == "")  {alert("거래처선택은 필수항목입니다");  txt_scccode3.focus(); return;
	
	 }else{
		var str21 = gclx_sfdcode2.BindColVal;            	//지점코드
		var str22 = gcem_staxdatfr2.text;            	  	//기간from
		var str23 = gcem_staxdatto2.text;                  //기간to		
		var str24 = txt_scccode3.value;                   //거래처
		var str25 = gcem_atcode_fr02.text;     	          //계정과목from
		var str26 = gcem_atcode_to02.text;                //계정과목to

		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s2?v_str1="+str21
														                              + "&v_str2="+str22
														                              + "&v_str3="+str23
														                          	  + "&v_str4="+str24
												                        		      + "&v_str5="+str25
												                          			  + "&v_str6="+str26;
		gcds_data2.Reset();
	 }
	}else if(s=="03") {
   if (fn_trim(gcem_atcode_fr03.text) == "") 	{alert("계정선택은 필수항목입니다"); gcem_atcode_fr03.focus();	return; 
   }else{
		var str31 = gclx_sfdcode3.BindColVal;          //	지점코드
		var str32 = gcem_staxdatfr3.text;	             // 	기간from 
		var str33 = gcem_staxdatto3.text;             //  기간to		
		var str34 = txt_scccode5.value;                // 거래처 from
		var str35 = txt_scccode7.value;               // 거래처 to
		var str36 = gcem_atcode_fr03.text;             //  계정과목
		/*
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s3?v_str1="+str31
														                              + "&v_str2="+str32
														                              + "&v_str3="+str33
															                            + "&v_str4="+str34
														                              + "&v_str5="+str35
														                           	  + "&v_str6="+str36;
	  */
	  gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s13?v_str1="+str31
														                              + "&v_str2="+str32
														                              + "&v_str3="+str33
															                            + "&v_str4="+str34
														                              + "&v_str5="+str35
														                           	  + "&v_str6="+str36;
		gcds_data3.Reset();
}
	}else if(s=="04") {

   if (fn_trim(gcem_atcode_fr04.text) == "") 	{alert("계정선택은 필수항목입니다"); gcem_atcode_fr04.focus();	return; 
   }else{
		var str41 = gclx_sfdcode4.BindColVal;         //	지점코드
		var str42 = gcem_staxdatfr4.text;	            // 	기간from 
		var str43 = gcem_staxdatto4.text;             //  기간to		
		var str44 = txt_scccode9.value;               // 거래처 from
		var str45 = txt_scccode11.value;              // 거래처 to
		var str46 = gcem_atcode_fr04.text;             //  계정과목
		/*
		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s4?v_str1="+str41
														                              + "&v_str2="+str42
														                              + "&v_str3="+str43
															                            + "&v_str4="+str44
														                              + "&v_str5="+str45
														                           	  + "&v_str6="+str46;
		*/
    gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s14?v_str1="+str41
														                              + "&v_str2="+str42
														                              + "&v_str3="+str43
															                            + "&v_str4="+str44
														                              + "&v_str5="+str45
														                           	  + "&v_str6="+str46;
		gcds_data4.Reset();
  }
	}else if(s=="05") {
	  /**
	  if(fn_trim(txt_scccode13.value) == "") {alert("거래처선택은 필수항목입니다"); txt_scccode13.focus(); return;
    }else{
		**/
		var str51 = gclx_sfdcode5.BindColVal;          //	지점코드
		var str52 = gcem_staxdatfr5.text;	             // 	기간from 
		var str53 = gcem_staxdatto5.text;              //  기간to		
		var str54 = txt_scccode13.value;               // 거래처
		/*
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s5?v_str1="+str51
														                              + "&v_str2="+str52
														                              + "&v_str3="+str53
															                            + "&v_str4="+str54;
    */
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s15?v_str1="+str51
														                              + "&v_str2="+str52
														                              + "&v_str3="+str53
															                            + "&v_str4="+str54;
		gcds_data5.Reset();
		//}
	}

}

/***********************************************************************************************
	Description : 잔액 구하기....
	parameter   : 
**********************************************************************************************/
function ln_Sum1(){
	
	var slpval = 0;
	var atdecr;
	gcgd_disp01.redraw="false";
	for(i=1;i<=gcds_data1.countrow;i++){
		atdecr = gcds_data1.namevalue(i,"ATDECR");
		gcds_temp1.ImportData(gcds_data1.ExportData(i,1,false));
		/*
		if(atdecr == "1"){
			slpval = slpval + gcds_data1.namevalue(i,"DETOT") - gcds_data1.namevalue(i,"CRTOT");
		}
		else{
			slpval = slpval + gcds_data1.namevalue(i,"CRTOT") - gcds_data1.namevalue(i,"DETOT");
		}
		gcds_temp1.namevalue(i,"SLPVAL") = slpval;
		*/
	}
	gcgd_disp01.redraw="true";

}

/***********************************************************************************************
	Description : 누계 구하기....
	parameter   : 
**********************************************************************************************/
function ln_Sum2(){
  var strmdetot = 0; //차변누계
	var strmcrtot = 0; //대변누계
	var stractdat =""; //월계구분
	var strsumdt ="";  //누계년월
	var intfromrow ="1";  //import시 처음.
	var tempdt="";
	var stryymmdd=""; //일자
	var cnt=0; //갯수

  //gcgd_disp02.DataID ="";			   
	gcgd_disp02.redraw="false";

	
  //전기이월 import
	//gcds_temp2.ImportData(gcds_data2.ExportData(1,1,false)

	for(i=1;i<=gcds_data2.countrow;i++){
    cnt+=1;
	  stractdat=(gcds_data2.namevalue(i,"ACTDAT")); 
		strsumdt = stractdat.substring(0,6)+"33";
	
		if(stractdat.substring(6,8)=="00"){ //전기이월
		  strmdetot=0;
			strmcrtot=0;
			gcds_temp2.ImportData(gcds_data2.ExportData(intfromrow,cnt,false));
			strmdetot += gcds_data2.namevalue(i,"DETOT");
			strmcrtot += gcds_data2.namevalue(i,"CRTOT");
			//gcds_temp2.namevalue(gcds_temp2.rowposition,"DETOT") = strmdetot;
			//gcds_temp2.namevalue(gcds_temp2.rowposition,"CRTOT") = strmcrtot;
			intfromrow =i+1;
			cnt=0;
		
		}else if(stractdat.substring(6,8)=="32"){  //월합계
		  //alert("intfromrow::"+intfromrow+"::i::"+i);
			//prompt("ExportData",gcds_data2.ExportData(intfromrow,cnt,false));
			gcds_temp2.ImportData(gcds_data2.ExportData(intfromrow,cnt,false));
      gcds_temp2.addrow(); //누계 추가
			strmdetot += gcds_data2.namevalue(i,"DETOT");
			strmcrtot += gcds_data2.namevalue(i,"CRTOT");
      gcds_temp2.namevalue(gcds_temp2.rowposition,"DETOT") = strmdetot;
			gcds_temp2.namevalue(gcds_temp2.rowposition,"CRTOT") = strmcrtot;
			gcds_temp2.namevalue(gcds_temp2.rowposition,"ACTDAT") = strsumdt;
			gcds_temp2.namevalue(gcds_temp2.rowposition,"ATCODE") = gcds_data2.namevalue(i,"ATCODE");
			gcds_temp2.namevalue(gcds_temp2.rowposition,"GUBUN") = "33";
			gcds_temp2.namevalue(gcds_temp2.rowposition,"ATKORNAM2") = gcds_data2.namevalue(i,"ATKORNAM2");
			intfromrow =i+1;
			cnt=0;
		}
	}//for


  i=0;
  for(i=1;i<=gcds_temp2.countrow;i++){
	  stryymmdd = gcds_temp2.namevalue(i,"ACTDAT");
		if (stryymmdd.substring(6,8)=="00"){
			gcds_temp2.namevalue(i,"ATKORNAM")="            전기이월";
			//gcds_temp2.namevalue(i,"ACTDAT")="";
		}else if (stryymmdd.substring(6,8)=="32"){
			gcds_temp2.namevalue(i,"ATKORNAM")="            월    계";
			gcds_temp2.namevalue(i,"FSREFVAL")="";
			gcds_temp2.namevalue(i,"VEND_NM")="";
			//gcds_temp2.namevalue(i,"ACTDAT")="";
		}else if (stryymmdd.substring(6,8)=="33"){
			gcds_temp2.namevalue(i,"ATKORNAM")="            누    계";
			//gcds_temp2.namevalue(i,"ACTDAT")="";
		}else{
		//	tempdt = gcds_temp2.namevalue(i,"ACTDAT")
			//tempdt = tempdt.substring(0,4)+"-"+tempdt.substring(4,6)+"-"+tempdt.substring(6,8);
		//	gcds_temp2.namevalue(i,"ACTDAT")=tempdt;
		}
  }

  /*
	for(i=1;i<=gcds_temp2.countrow;i++){
		if (gcds_temp2.namevalue(i,"ATCODE")=="000"){
			gcds_temp2.namevalue(i,"ACTDAT")="전기이월"
		}else if (gcds_temp2.namevalue(i,"ATCODE")=="888"){
			gcds_temp2.namevalue(i,"ACTDAT")="월계"
		}else if (gcds_temp2.namevalue(i,"ATCODE")=="999"){
			gcds_temp2.namevalue(i,"ACTDAT")="누계"
		}else{
		//	tempdt = gcds_temp2.namevalue(i,"ACTDAT")
			//tempdt = tempdt.substring(0,4)+"-"+tempdt.substring(4,6)+"-"+tempdt.substring(6,8);
		//	gcds_temp2.namevalue(i,"ACTDAT")=tempdt;
		}
  }
	*/
	ln_Janamt_Sum();

	//gcgd_disp02.DataID ="gcds_temp2";
  //prompt("",gcds_temp2.text);
	gcgd_disp02.redraw = "true";  
}


/***********************************************************************************************
	Description : 잔액 구하기....
	parameter   : 
	참       조 : 일자별 잔액 = 전기이월 잔액 + 일자잔액(누적해서)
	              월계의 잔액 = 전기이월 잔액 + 월계의 잔액
								누계의 잔액 = 이전누계잔액 + 전기이월잔액 + 월계의 잔액
**********************************************************************************************/
function ln_Janamt_Sum(){
	var dblbfamt =0; //전기이월금액
	var dblmmsum =0; //월계잔액
	var dbladdsum=0; //누계잔액

	for(i=1;i<=gcds_temp2.countrow;i++){
		if(gcds_temp2.namevalue(i,"GUBUN")=="00"){ //전기이월
		  dblbfamt =0;
			dblmmsum =0;
			dbladdsum=0;
			dblbfamt = gcds_temp2.namevalue(i,"JANAMT");
			dbladdsum = dblbfamt;
		}else if(gcds_temp2.namevalue(i,"GUBUN")=="32"){ //월계
		  dblmmsum = gcds_temp2.namevalue(i,"JANAMT"); 
			gcds_temp2.namevalue(i,"JANAMT") = dblbfamt+dblmmsum; 
		}else if(gcds_temp2.namevalue(i,"GUBUN")=="33"){ //누계
      gcds_temp2.namevalue(i,"JANAMT") = dbladdsum;
		}else{  //일반잔액
      dbladdsum += gcds_temp2.namevalue(i,"JANAMT");
			gcds_temp2.namevalue(i,"JANAMT") = dbladdsum;
		}
	}
}


/***********************************************************************************************
	Description : 잔액 구하기....
	parameter   : 
	참       조 : 일자별 잔액 = 전기이월 잔액 + 일자잔액(누적해서)
	              월계의 잔액 = 전기이월 잔액 + 월계의 잔액
								누계의 잔액 = 이전누계잔액 + 전기이월잔액 + 월계의 잔액
**********************************************************************************************/
function ln_Janamt_Sum4(){
	var dblbfamt =0; //전기이월금액
	var dblmmsum =0; //월계잔액
	var dbladdsum=0; //누계잔액

	for(i=1;i<=gcds_temp4.countrow;i++){
		if(gcds_temp4.namevalue(i,"GUBUN")=="00"){ //전기이월
		  dblbfamt =0;
			dblmmsum =0;
			dbladdsum=0;
			dblbfamt = gcds_temp4.namevalue(i,"JANAMT");
			dbladdsum = dblbfamt;
		}else if(gcds_temp4.namevalue(i,"GUBUN")=="32"){ //월계
		  dblmmsum = gcds_temp4.namevalue(i,"JANAMT"); 
			gcds_temp4.namevalue(i,"JANAMT") = dblbfamt+dblmmsum; 
		}else if(gcds_temp4.namevalue(i,"GUBUN")=="33"){ //누계
      gcds_temp4.namevalue(i,"JANAMT") = dbladdsum;
		}else{  //일반잔액
      dbladdsum += gcds_temp4.namevalue(i,"JANAMT");
			gcds_temp4.namevalue(i,"JANAMT") = dbladdsum;
		}
	}
}


/***********************************************************************************************
	Description : 잔액 구하기....
	parameter   : 
**********************************************************************************************/
function ln_Sum3(){
	
	var slpval = 0;
	var atdecr;
	gcgd_disp03.redraw="false";
	for(i=1;i<=gcds_data3.countrow;i++){
		atdecr = gcds_data3.namevalue(i,"ATDECR");
		gcds_temp3.ImportData(gcds_data3.ExportData(i,1,false));
		/*
		if(atdecr == "1"){
			slpval = slpval + gcds_data3.namevalue(i,"DETOT") - gcds_data3.namevalue(i,"CRTOT");
		}
		else{
			slpval = slpval + gcds_data3.namevalue(i,"CRTOT") - gcds_data3.namevalue(i,"DETOT");
		}
		gcds_temp3.namevalue(i,"SLPVAL") = slpval;
		*/
	}

	gcgd_disp03.redraw="true";

}

/***********************************************************************************************
	Description : 누계 구하기....
	parameter   : 
**********************************************************************************************/
function ln_Sum4(){

  var strmdetot = 0; //차변누계
	var strmcrtot = 0; //대변누계
	var stractdat =""; //월계구분
	var strsumdt ="";  //누계년월
	var intfromrow ="1";  //import시 처음.
	var tempdt="";
	var stryymmdd=""; //일자
	var cnt=0; //갯수

	gcgd_disp04.redraw="false";

	for(i=1;i<=gcds_data4.countrow;i++){
    cnt+=1;
	  stractdat=(gcds_data4.namevalue(i,"ACTDAT")); 
		strsumdt = stractdat.substring(0,6)+"33";
	
		if(stractdat.substring(6,8)=="00"){ //전기이월
		  strmdetot=0;
			strmcrtot=0;
			gcds_temp4.ImportData(gcds_data4.ExportData(intfromrow,cnt,false));
			strmdetot += gcds_data4.namevalue(i,"DETOT");
			strmcrtot += gcds_data4.namevalue(i,"CRTOT");
			intfromrow =i+1;
			cnt=0;
		
		}else if(stractdat.substring(6,8)=="32"){  //월합계
			gcds_temp4.ImportData(gcds_data4.ExportData(intfromrow,cnt,false));
      gcds_temp4.addrow(); //누계 추가
			strmdetot += gcds_data4.namevalue(i,"DETOT");
			strmcrtot += gcds_data4.namevalue(i,"CRTOT");
      gcds_temp4.namevalue(gcds_temp4.rowposition,"DETOT") = strmdetot;
			gcds_temp4.namevalue(gcds_temp4.rowposition,"CRTOT") = strmcrtot;
			gcds_temp4.namevalue(gcds_temp4.rowposition,"ACTDAT") = strsumdt;
			//gcds_temp4.namevalue(gcds_temp4.rowposition,"ATCODE") = gcds_data4.namevalue(i,"ATCODE");
			gcds_temp4.namevalue(gcds_temp4.rowposition,"GUBUN") = "33";
			//gcds_temp4.namevalue(gcds_temp4.rowposition,"ATKORNAM2") = gcds_data4.namevalue(i,"ATKORNAM2");
			intfromrow =i+1;
			cnt=0;
		}
	}//for


  i=0;
  for(i=1;i<=gcds_temp4.countrow;i++){
	  stryymmdd = gcds_temp4.namevalue(i,"ACTDAT");
		if (stryymmdd.substring(6,8)=="00"){
			gcds_temp4.namevalue(i,"CDNAM")="            전기이월";
      gcds_temp4.namevalue(i,"ACTDAT")="";
		}else if (stryymmdd.substring(6,8)=="32"){
			gcds_temp4.namevalue(i,"CDNAM")="            월    계";
			gcds_temp4.namevalue(i,"ACTDAT")="";
		}else if (stryymmdd.substring(6,8)=="33"){
			gcds_temp4.namevalue(i,"CDNAM")="            누    계";
			gcds_temp4.namevalue(i,"ACTDAT")="";
		}else{
		}
  }

	ln_Janamt_Sum4();

	//gcgd_disp02.DataID ="gcds_temp2";
  //prompt("",gcds_temp2.text);
	gcgd_disp04.redraw = "true";   


  /***
  var strmdetot = 0; //차변누계
	var strmcrtot = 0; //대변누계
	var stractdat =""; //월계구분
	var strsumdt ="";  //누계년월
	var intfromrow ="1";  //import시 처음.
	var tempdt="";

	gcgd_disp04.redraw="false";
	
	for(i=1;i<=gcds_data4.countrow;i++){

	  stractdat=(gcds_data4.namevalue(i,"ACTDAT")); 
		strsumdt = stractdat.substring(0,6)+"33";
		//alert(strsumdt);

		if(stractdat.substring(6,8)=="32"){  //월합계
			gcds_temp4.ImportData(gcds_data4.ExportData(intfromrow,i,false));
      gcds_temp4.addrow(); //누계 추가
			strmdetot += gcds_data4.namevalue(i,"DETOT");
			strmcrtot += gcds_data4.namevalue(i,"CRTOT");
      gcds_temp4.namevalue(gcds_temp4.rowposition,"DETOT") = strmdetot;
			gcds_temp4.namevalue(gcds_temp4.rowposition,"CRTOT") = strmcrtot;
			gcds_temp4.namevalue(gcds_temp4.rowposition,"ACTDAT") = strsumdt;
		  gcds_temp4.namevalue(gcds_temp4.rowposition,"ATCODE") = "999";			
			intfromrow = i+1;
		}
	}//for

	for(i=1;i<=gcds_temp4.countrow;i++){

		if (gcds_temp4.namevalue(i,"ACTDAT").substring(6,8)=="00"){
			gcds_temp4.namevalue(i,"ACTDAT")="전기이월"
		}else if (gcds_temp4.namevalue(i,"ACTDAT").substring(6,8)=="32"){
			gcds_temp4.namevalue(i,"ACTDAT")="월계"
		}else if (gcds_temp4.namevalue(i,"ACTDAT").substring(6,8)=="33"){
			gcds_temp4.namevalue(i,"ACTDAT")="누계"
		}else{
		//	tempdt = gcds_temp4.namevalue(i,"ACTDAT")
		//	tempdt = tempdt.substring(0,4)+"-"+tempdt.substring(4,6)+"-"+tempdt.substring(6,8);
		//	gcds_temp4.namevalue(i,"ACTDAT")=tempdt;
		}
  }

	//prompt("",gcds_temp4.text);
	gcgd_disp04.redraw = "true";

	***/

}

/******************************************************************************
	Description : Dataset Head 설정 - 계정별 잔액
  parameter   : 전표DTL
	          
******************************************************************************/
function ln_SetDataHeader1(){
	if (gcds_temp1.countrow<1){
	  var s_temp = "ATCODE:STRING,ATKORNAM:STRING,BEVAL:DECIMAL,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVAL:DECIMAL,ATDECR:STRING,FSREFVAL:STRING,VEND_NM:STRING";
		gcds_temp1.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
  parameter   : 전표DTL
	          
******************************************************************************/
function ln_SetDataHeader2(){
	if (gcds_temp2.countrow<1){
	  var s_temp = "ATCODE:STRING,ATKORNAM:STRING,ATKORNAM2:STRING,ACTDAT:STRING,GUBUN:STRING,REMARK:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,JANAMT:DECIMAL,FSREFVAL:STRING,VEND_NM:STRING";
		gcds_temp2.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 거래처별 잔액
  parameter   : 전표DTL
	          
******************************************************************************/
function ln_SetDataHeader3(){
	if (gcds_temp3.countrow<1){
	  var s_temp = "FSREFVAL:STRING,CDNAM:STRING,BEVAL:DECIMAL,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVAL:DECIMAL,ATDECR:STRING";
		gcds_temp3.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
  parameter   : 전표DTL
	          
******************************************************************************/
function ln_SetDataHeader4(){
	if (gcds_temp4.countrow<1){
	  var s_temp = "ACTDAT:STRING,FSREFVAL:STRING,CDNAM:STRING,REMARK:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,JANAMT:DECIMAL,ATCODE:STRING,GUBUN:STRING";
		gcds_temp4.SetDataHeader(s_temp);
	}
}

/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
**********************************************************************************************/
function ln_Popup01(p2,p){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];

					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];				
						//ln_CurActcode();	//현재계정 조회
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
						//ln_CurActcode();	//현재계정 조회
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

	}else if(p=="02"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr02.text = arrParam[0];
					txt_atkornam_fr02.value = arrParam[1];
					
					gcem_atcode_to02.text = arrParam[0];
					txt_atkornam_to02.value = arrParam[1];
			 }else if(p2=="to"){
					gcem_atcode_to02.text = arrParam[0];
					txt_atkornam_to02.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr02.text = "";
				txt_atkornam_fr02.value ="";
			}else if(p2=="to"){
				gcem_atcode_to02.text = "";
				txt_atkornam_to02.value = "";
			}
		}
	}
}

/***********************************************************************************************
	Description : 거래처 찾기
	parameter   :
**********************************************************************************************/
function ln_Popup02(p2,p){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if(p=="03"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					txt_scccode5.value = arrParam[0];
					txt_scccode6.value = arrParam[1];

					txt_scccode7.value = arrParam[0];
					txt_scccode8.value = arrParam[1];				
						//ln_CurActcode();	//현재계정 조회
			 }else if(p2=="to"){
					txt_scccode7.value = arrParam[0];
					txt_scccode8.value = arrParam[1];
						//ln_CurActcode();	//현재계정 조회
			 }
		} else {
			if(p2=="fr") {
				txt_scccode5.value = "";
				txt_scccode6.value ="";
			}else if(p2=="to"){
				txt_scccode7.value = "";
				txt_scccode8.value = "";				
			}
		}
	}else if(p=="04"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					txt_scccode9.value = arrParam[0];
					txt_scccode10.value = arrParam[1];

					txt_scccode11.value = arrParam[0];
					txt_scccode12.value = arrParam[1];				
						//ln_CurActcode();	//현재계정 조회
			 }else if(p2=="to"){
					txt_scccode11.value = arrParam[0];
					txt_scccode12.value = arrParam[1];
						//ln_CurActcode();	//현재계정 조회
			 }
		} else {
			if(p2=="fr") {
				txt_scccode9.value = "";
				txt_scccode10.value ="";
			}else if(p2=="to"){
				txt_scccode11.value = "";
				txt_scccode12.value = "";				
			}
		}
	}
}

/***********************************************************************************************
	Description : [일별] - 전표 찾기
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_Popup7(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;//지점코드
	arrParam[1] = fsdt;//일자
	arrParam[2] = fnbr;//등록번호

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : 거래처 찾기1
	parameter   :
**********************************************************************************************/

function ln_Popup1(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_scccode1.value = arrParam[0];
		txt_scccode2.value = arrParam[1];
	} else {
		txt_scccode1.value = "";
		txt_scccode2.value = "";
	}
}

/***********************************************************************************************
	Description : 거래처 찾기2
	parameter   :
**********************************************************************************************/

function ln_Popup2(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_scccode3.value = arrParam[0];
		txt_scccode4.value = arrParam[1];
	} else {
		txt_scccode3.value = "";
		txt_scccode4.value = "";
	}
}

/***********************************************************************************************
	Description : 거래처별잔액/계정과목찾기
	parameter   :
**********************************************************************************************/

function ln_Popup3(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_atcode_fr03.text = arrParam[0];
		txt_atcode_fr03.value = arrParam[1];
	} else {
		gcem_atcode_fr03.text = "";
		txt_atcode_fr03.value = "";
	}
}

/***********************************************************************************************
	Description : 거래처별내용/계정과목찾기
	parameter   :
**********************************************************************************************/

function ln_Popup4(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_atcode_fr04.text = arrParam[0];
		txt_atcode_fr04.value = arrParam[1];
	} else {
		gcem_atcode_fr04.text = "";
		txt_atcode_fr04.value = "";
	}
}

/***********************************************************************************************
	Description : 거래처 찾기5
	parameter   :
**********************************************************************************************/

function ln_Popup5(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_scccode13.value = arrParam[0];
		txt_scccode14.value = arrParam[1];
	} else {
		txt_scccode13.value = "";
		txt_scccode14.value = "";
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(s){

if(s == "01"){
		/*
		var str11 = gclx_sfdcode1.BindColVal; 
		var str12 = gcem_staxdatfr1.text;	  
		var str13 = gcem_staxdatto1.text;    
		var str14 = txt_scccode1.value;      
		var str15 = gcem_atcode_fr01.text; 
		var str16 = gcem_atcode_to01.text; 

		gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s1?v_str1="+str11
														                              + "&v_str2="+str12
														                              + "&v_str3="+str13
															                            + "&v_str4="+str14
														                              + "&v_str5="+str15
														                           	  + "&v_str6="+str16;
		gcds_print1.Reset();
		*/
		ln_Format1();
		gcrp_print1.preview();

 }else if(s == "02"){
		/*
		var str21 = gclx_sfdcode2.BindColVal;            
		var str22 = gcem_staxdatfr2.text;            	  
		var str23 = gcem_staxdatto2.text;                
		var str24 = txt_scccode3.value;                  
		var str25 = gcem_atcode_fr02.text;     	        
		var str26 = gcem_atcode_to02.text;              

		gcds_print2.DataID  = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s2?v_str1="+str21
														                              + "&v_str2="+str22
														                              + "&v_str3="+str23
														                          	  + "&v_str4="+str24
												                        		      + "&v_str5="+str25
												                          			  + "&v_str6="+str26;
		gcds_print2.Reset();
		*/

		//prompt("",gcds_temp2.text);
		ln_Format2();
		gcrp_print2.preview();
	
 }else if(s == "03"){

		/*
		var str31 = gclx_sfdcode3.BindColVal; 
		var str32 = gcem_staxdatfr3.text;	   
		var str33 = gcem_staxdatto3.text;  
		var str34 = txt_scccode5.value;     
		var str35 = txt_scccode7.value;      
		var str36 = gcem_atcode_fr03.text; 
		gcds_print3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s3?v_str1="+str31
														                              + "&v_str2="+str32
														                              + "&v_str3="+str33
															                            + "&v_str4="+str34
														                              + "&v_str5="+str35
														                           	  + "&v_str6="+str36;
		gcds_print3.Reset();
		*/
		ln_Format3();
		gcrp_print3.preview(); 
	
 }else if(s == "04"){

		/*
		var str41 = gclx_sfdcode4.BindColVal; 
		var str42 = gcem_staxdatfr4.text;	   
		var str43 = gcem_staxdatto4.text;    
		var str44 = txt_scccode9.value;      
		var str45 = txt_scccode11.value;      
		var str46 = gcem_atcode_fr04.text;   
		gcds_print4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s4?v_str1="+str41
														                              + "&v_str2="+str42
														                              + "&v_str3="+str43
															                            + "&v_str4="+str44
														                              + "&v_str5="+str45
														                           	  + "&v_str6="+str46;
		gcds_print4.Reset();
		*/
		ln_Format4();
		gcrp_print4.preview(); 

 }else if(s == "05"){
		
		/*
    var str51 = gclx_sfdcode5.BindColVal; 
		var str52 = gcem_staxdatfr5.text;	  
		var str53 = gcem_staxdatto5.text;   
		var str54 = txt_scccode13.value;    

		gcds_print5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s5?v_str1="+str51
														                              + "&v_str2="+str52
														                              + "&v_str3="+str53
															                            + "&v_str4="+str54;
		gcds_print5.Reset();
		*/
	
		ln_Format5();
		gcrp_print5.preview(); 

	}	

}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Format1() {

	var ls_for = "";

	var strfr = gcem_staxdatfr1.text;
	var strto = gcem_staxdatto1.text;
  var yyyy = strfr.substring(0,4);
  var mm = strfr.substring(4,6);	
	
  var yyyy2 = strto.substring(0,4);
  var mm2 = strto.substring(4,6);	 


	var yyyy3 = gs_date.substring(0,4);
	var mm3 = gs_date.substring(4,6);
	var dd3 = gs_date.substring(6,8);

	var fd = gcds_sfdcode1.NameValue(gcds_sfdcode1.rowposition,"FDNAME");
	var cmd = txt_scccode2.value; 
	ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=438 ,face='Arial' ,size=10 ,penwidth=1	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>	<T>id='거래처원장-계정별 잔액' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>	<L> left=238 ,top=437 ,right=2809 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=238 ,top=344 ,right=238 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=238 ,top=341 ,right=2809 ,bottom=341 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='잔액' ,left=2403 ,top=356 ,right=2794 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='대변' ,left=1984 ,top=356 ,right=2375 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='차변' ,left=1566 ,top=356 ,right=1959 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='전기이월' ,left=1147 ,top=356 ,right=1541 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='계정과목' ,left=247 ,top=356 ,right=1128 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='Page : #p of #t' ,left=2384 ,top=278 ,right=2806 ,bottom=331 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<C>id='작성일자:', left=2219, top=234, right=2378, bottom=284, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=2378 ,top=234 ,right=2803 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='(기간 : "+yyyy+"년 "+mm+"월 ~ "+yyyy2+"년 "+mm2+"월)' ,left=1003 ,top=122 ,right=1872 ,bottom=169 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='지   점 : "+fd+"' ,left=244 ,top=228 ,right=525 ,bottom=272 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='거래처 : "+cmd+"' ,left=244 ,top=278 ,right=1406 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=2809 ,top=344 ,right=2809 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1138 ,top=344 ,right=1138 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2397 ,top=344 ,right=2397 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1981 ,top=344 ,right=1981 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1553 ,top=341 ,right=1553 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=default ,left=0,top=0 ,right=2869 ,bottom=54 ,face='Arial' ,size=10 ,penwidth=1	<C>id='SLPVAL', left=2406, top=0, right=2803, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='CRTOT', left=1997, top=3, right=2384, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='BEVAL', left=1150, top=3, right=1538, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=1138 ,top=3 ,right=1138 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2397 ,top=0 ,right=2397 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1553 ,top=0 ,right=1553 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='DETOT', left=1569, top=3, right=1959, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='ATKORNAM', left=247, top=0, right=1128, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=238 ,top=0 ,right=238 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=238 ,top=53 ,right=2809 ,bottom=53 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L></B><B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=238 ,top=0 ,right=238 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1138 ,top=0 ,right=1138 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1553 ,top=0 ,right=1553 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<S>id='SUM(CRTOT)' ,left=1997 ,top=3 ,right=2384 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='SUM(SLPVAL)' ,left=2406 ,top=0 ,right=2803 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2397 ,top=0 ,right=2397 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=238 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='합계' ,left=244 ,top=3 ,right=1128 ,bottom=44 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<S>id='SUM(BEVAL)' ,left=1150 ,top=3 ,right=1538 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='SUM(DETOT)' ,left=1569 ,top=3 ,right=1959 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<L> left=238 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>	<L> left=234 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B>";

	gcrp_print1.Format = ls_for + gcrp_print1.Format;
}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Format2() {

	var ls_for = "";

	var strfr = gcem_staxdatfr2.text;
	var strto = gcem_staxdatto2.text;
  var yyyy = strfr.substring(0,4);
  var mm = strfr.substring(4,6);	
	
  var yyyy2 = strto.substring(0,4);
  var mm2 = strto.substring(4,6);	 


	var yyyy3 = gs_date.substring(0,4);
	var mm3 = gs_date.substring(4,6);
	var dd3 = gs_date.substring(6,8);

	var fd = gcds_sfdcode2.NameValue(gcds_sfdcode2.rowposition,"FDNAME");

	var cmd = txt_scccode4.value; 
//alert(cmd);
	ls_for +=" <B>id=Header ,left=0,top=0 ,right=2871 ,bottom=416 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                            ";
	ls_for +=" 	<T>id='(기간 : "+yyyy+"년 "+mm+"월 ~ "+yyyy2+"년 "+mm2+"월)' ,left=1003 ,top=201 ,right=1873 ,bottom=249 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>             ";
	ls_for +=" 	<T>id='지   점 : "+fd+"' ,left=225 ,top=257 ,right=505 ,bottom=302 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                    ";
	ls_for +=" 	<T>id='거래처 : "+cmd+"' ,left=225 ,top=307 ,right=1389 ,bottom=352 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                   ";
	ls_for +=" 	<T>id='계   정 :' ,left=225 ,top=357 ,right=357 ,bottom=402 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         ";
	ls_for +=" 	<C>id='ATKORNAM2', left=362, top=357, right=1384, bottom=402, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                             ";
	ls_for +=" 	<T>id='Page : #p of #t' ,left=2384 ,top=310 ,right=2807 ,bottom=362 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                  ";
	ls_for +=" 	<T>id='거래처원장-계정별 내용' ,left=1019 ,top=108 ,right=1844 ,bottom=183 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                       ";
	ls_for +=" </B>                                                                                                                                                                                                                             ";
	ls_for +=" <B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=103 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                           ";
	ls_for +=" 	<T>id='적요' ,left=556 ,top=24 ,right=1516 ,bottom=87 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                ";
	ls_for +=" 	<T>id='잔액' ,left=2400 ,top=26 ,right=2797 ,bottom=90 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                               ";
	ls_for +=" 	<T>id='차변' ,left=1556 ,top=26 ,right=1950 ,bottom=90 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                               ";
	ls_for +=" 	<T>id='대변' ,left=1984 ,top=26 ,right=2379 ,bottom=90 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                               ";
	ls_for +=" 	<T>id='일자' ,left=238 ,top=24 ,right=513 ,bottom=87 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                                 ";
	ls_for +=" 	<L> left=532 ,top=11 ,right=532 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                 ";
	ls_for +=" 	<L> left=1966 ,top=8 ,right=1966 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                ";
	ls_for +=" 	<L> left=2389 ,top=11 ,right=2389 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                               ";
	ls_for +=" 	<L> left=1537 ,top=11 ,right=1537 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                               ";
	ls_for +=" 	<L> left=2810 ,top=11 ,right=2810 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                               ";
	ls_for +=" 	<L> left=217 ,top=8 ,right=2810 ,bottom=8 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                   ";
	ls_for +=" 	<L> left=217 ,top=11 ,right=217 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                 ";
	ls_for +=" 	<L> left=217 ,top=103 ,right=2810 ,bottom=103 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                               ";
	ls_for +=" </B>                                                                                                                                                                                                                             ";
	ls_for +=" <B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                            ";
	ls_for +=" 	<L> left=217 ,top=0 ,right=217 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                   ";
	ls_for +=" 	<L> left=217 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>                                                                                                                                 ";
	ls_for +=" 	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                 ";
	ls_for +=" 	<L> left=2389 ,top=0 ,right=2389 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                 ";
	ls_for +=" 	<L> left=1966 ,top=0 ,right=1966 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                 ";
	ls_for +=" 	<L> left=532 ,top=0 ,right=532 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                   ";
	ls_for +=" 	<C>id='ACTDAT', left=238, top=0, right=513, bottom=45 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                            ";
	ls_for +=" 	<C>id='DETOT', left=1982, top=3, right=2373, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                               ";
	ls_for +=" 	<C>id='JANAMT', left=2402, top=3, right=2791, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                              ";
	ls_for +=" 	<C>id='DETOT', left=1556, top=3, right=1947, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                               ";
	ls_for +=" 	<C>id='REMARK', left=553, top=3, right=1349, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                ";
	ls_for +=" 	<C>id='ATKORNAM2', left=1368, top=3, right=1519, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                            ";
	ls_for +=" 	<L> left=1537 ,top=0 ,right=1537 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                 ";
	ls_for +=" </B>                                                                                                                                                                                                                             ";
	ls_for +=" <B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=26 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                            ";
	ls_for +=" 	<L> left=217 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                   ";
	ls_for +=" </B>                                                                                                                                                                                                                             ";
	ls_for +=" <B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                       ";
	ls_for +=" 	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>                                                                                                                                                 ";
	ls_for +=" 	<L> left=217 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                                   ";
	ls_for +=" 	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=225 ,top=13 ,right=849 ,bottom=61 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                  ";
	ls_for +=" </B>                                                                                                                                                                                                                             ";
	
	gcrp_print2.Format = ls_for + gcrp_print2.Format;
}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Format3() {

	var ls_for = "";

	var strfr = gcem_staxdatfr3.text;
	var strto = gcem_staxdatto3.text;
  var yyyy = strfr.substring(0,4);
  var mm = strfr.substring(4,6);	
	
  var yyyy2 = strto.substring(0,4);
  var mm2 = strto.substring(4,6);	 


	var yyyy3 = gs_date.substring(0,4);
	var mm3 = gs_date.substring(4,6);
	var dd3 = gs_date.substring(6,8);

	var fd = gcds_sfdcode3.NameValue(gcds_sfdcode3.rowposition,"FDNAME");
	var atcode = txt_atcode_fr03.value;

	ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=438 ,face='Arial' ,size=10 ,penwidth=1	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>	<T>id='거래처원장-거래처별 잔액' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>	<L> left=222 ,top=437 ,right=2809 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=222 ,top=344 ,right=222 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=222 ,top=341 ,right=2806 ,bottom=341 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='잔액' ,left=2403 ,top=356 ,right=2794 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='대변' ,left=1994 ,top=356 ,right=2384 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='차변' ,left=1569 ,top=356 ,right=1963 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='전기이월' ,left=1150 ,top=356 ,right=1544 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='거래처' ,left=275 ,top=356 ,right=1084 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='Page : #p of #t' ,left=2384 ,top=278 ,right=2806 ,bottom=331 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<C>id='작성일자:', left=2219, top=234, right=2378, bottom=284, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=2378 ,top=234 ,right=2803 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='(기간 : "+yyyy+"년 "+mm+"월 ~ "+yyyy2+"년 "+mm2+"월)' ,left=1003 ,top=122 ,right=1872 ,bottom=169 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=2809 ,top=344 ,right=2809 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1138 ,top=344 ,right=1138 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2397 ,top=344 ,right=2397 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1981 ,top=344 ,right=1981 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1553 ,top=341 ,right=1553 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='계정과목 : "+atcode+"' ,left=231 ,top=291 ,right=653 ,bottom=331 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='지점 : "+fd+"' ,left=231 ,top=241 ,right=563 ,bottom=284 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T></B><B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=222 ,top=0 ,right=222 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=219 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>	<C>id='SLPVAL', left=2406, top=0, right=2803, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='DETOT', left=1569, top=3, right=1959, bottom=50, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='CRTOT', left=1994, top=3, right=2381, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='BEVAL', left=1150, top=3, right=1538, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='CDNAM', left=234, top=0, right=1097, bottom=47, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=2397 ,top=0 ,right=2397 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1553 ,top=0 ,right=1553 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1138 ,top=0 ,right=1138 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=222 ,top=0 ,right=222 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='합계' ,left=238 ,top=0 ,right=1116 ,bottom=41 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=1138 ,top=0 ,right=1138 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1553 ,top=0 ,right=1553 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<S>id='{SUM(CRTOT)}' ,left=1997 ,top=3 ,right=2384 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='{SUM(SLPVAL)}' ,left=2406 ,top=0 ,right=2803 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<L> left=1981 ,top=0 ,right=1981 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2397 ,top=0 ,right=2397 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=222 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<S>id='{SUM(DETOT)}' ,left=1572 ,top=3 ,right=1959 ,bottom=41 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='{SUM(BEVAL)}' ,left=1150 ,top=3 ,right=1538 ,bottom=44 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<L> left=222 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>	<L> left=219 ,top=0 ,right=2806 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B>";

	gcrp_print3.Format = ls_for + gcrp_print3.Format;
}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Format4() {

	var ls_for = "";
  var temd="";
	var strfr = gcem_staxdatfr4.text;
	var strto = gcem_staxdatto4.text;
  var yyyy = strfr.substring(0,4);
  var mm = strfr.substring(4,6);	
	
  var yyyy2 = strto.substring(0,4);
  var mm2 = strto.substring(4,6);	 


	var yyyy3 = gs_date.substring(0,4);
	var mm3 = gs_date.substring(4,6);
	var dd3 = gs_date.substring(6,8);
  
	var fd = gcds_sfdcode4.NameValue(gcds_sfdcode4.rowposition,"FDNAME");
	var atcode = txt_atcode_fr04.value;

	ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=438 ,face='Arial' ,size=10 ,penwidth=1	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>	<T>id='거래처원장-거래처별 내용' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>	<L> left=228 ,top=344 ,right=228 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=228 ,top=341 ,right=2806 ,bottom=341 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='대변' ,left=2397 ,top=356 ,right=2788 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='Page : #p of #t' ,left=2384 ,top=278 ,right=2806 ,bottom=331 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<C>id='작성일자:', left=2219, top=234, right=2378, bottom=284, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=2378 ,top=234 ,right=2803 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='(기간 : "+yyyy+"년 "+mm+"월 ~ "+yyyy2+"년 "+mm2+"월)' ,left=1003 ,top=122 ,right=1872 ,bottom=169 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=2809 ,top=344 ,right=2809 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1256 ,top=344 ,right=1256 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2388 ,top=344 ,right=2388 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1966 ,top=341 ,right=1966 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='일자' ,left=253 ,top=356 ,right=409 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=438 ,top=344 ,right=438 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='차변' ,left=1978 ,top=356 ,right=2372 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='거래처' ,left=491 ,top=356 ,right=1209 ,bottom=425 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='적요' ,left=1269 ,top=356 ,right=1950 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='계정과목 : "+atcode+"' ,left=228 ,top=275 ,right=700 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='지  점 : "+fd+"' ,left=228 ,top=225 ,right=513 ,bottom=272 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=228 ,top=437 ,right=2809 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=228 ,top=0 ,right=228 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=228 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2388 ,top=0 ,right=2388 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1966 ,top=0 ,right=1966 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=438 ,top=0 ,right=438 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='CDNAM', left=450, top=0, right=1244, bottom=47, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='CRTOT', left=2403, top=3, right=2791, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='ACTDAT', left=247, top=0, right=419, bottom=44, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='REMARK', left=1269, top=3, right=1953, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='DETOT', left=1981, top=3, right=2372, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=1256 ,top=0 ,right=1256 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=144 ,face='Arial' ,size=10 ,penwidth=1	<L> left=228 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=Footer ,left=0 ,top=1857 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>	<L> left=228 ,top=0 ,right=2806 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B>";

	gcrp_print4.Format = ls_for + gcrp_print4.Format;
}
/******************************************************************************
	Description :
******************************************************************************/
function ln_Format5() {

	var ls_for = "";

	var strfr = gcem_staxdatfr5.text;
	var strto = gcem_staxdatto5.text;
  var yyyy = strfr.substring(0,4);
  var mm = strfr.substring(4,6);	
	
  var yyyy2 = strto.substring(0,4);
  var mm2 = strto.substring(4,6);	 


	var yyyy3 = gs_date.substring(0,4);
	var mm3 = gs_date.substring(4,6);
	var dd3 = gs_date.substring(6,8);

	var fd = gcds_sfdcode5.NameValue(gcds_sfdcode5.rowposition,"FDNAME");
	var cmd = txt_scccode14.value; 

	//ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=438 ,face='Arial' ,size=10 ,penwidth=1	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>	<T>id='거래처원장-거래처별채권채무' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>	<L> left=219 ,top=437 ,right=2806 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=219 ,top=344 ,right=219 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=219 ,top=341 ,right=2809 ,bottom=341 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=2378 ,top=234 ,right=2803 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='(기간 : "+yyyy+"년 "+mm+"월 ~ "+yyyy2+"년 "+mm+"월)' ,left=1003 ,top=122 ,right=1872 ,bottom=169 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=2809 ,top=344 ,right=2809 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='지   점 : "+fd+"' ,left=234 ,top=228 ,right=516 ,bottom=272 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='거래처 : "+cmd+"' ,left=234 ,top=278 ,right=1397 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='선수금' ,left=2613 ,top=356 ,right=2803 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='미지급금' ,left=2397 ,top=356 ,right=2584 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='외상매입금' ,left=2181 ,top=356 ,right=2369 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='채권합계' ,left=1963 ,top=356 ,right=2147 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='받을어음' ,left=1738 ,top=356 ,right=1925 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='단기대여금' ,left=1522 ,top=356 ,right=1709 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='선수금' ,left=1303 ,top=356 ,right=1491 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='미수금' ,left=1084 ,top=356 ,right=1272 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='외상매출금' ,left=872 ,top=356 ,right=1063 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='업체명' ,left=228 ,top=356 ,right=847 ,bottom=422 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='Page : #p of #t' ,left=2384 ,top=278 ,right=2806 ,bottom=331 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=856 ,top=344 ,right=856 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1072 ,top=344 ,right=1072 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1288 ,top=344 ,right=1288 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1506 ,top=344 ,right=1506 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1722 ,top=344 ,right=1722 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1950 ,top=344 ,right=1950 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2163 ,top=344 ,right=2163 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2388 ,top=341 ,right=2388 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2600 ,top=344 ,right=2600 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=219 ,top=0 ,right=219 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=219 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2600 ,top=0 ,right=2600 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2388 ,top=0 ,right=2388 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2163 ,top=0 ,right=2163 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1722 ,top=0 ,right=1722 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1506 ,top=0 ,right=1506 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1288 ,top=0 ,right=1288 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1072 ,top=3 ,right=1072 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=856 ,top=0 ,right=856 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='CDNAM', left=228, top=0, right=844, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=1950 ,top=0 ,right=1950 ,bottom=47 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<C>id='VAL1', left=872, top=0, right=1063, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL2', left=1084, top=0, right=1275, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL3', left=1300, top=0, right=1494, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL4', left=1522, top=0, right=1709, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL5', left=1738, top=0, right=1938, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='SUM1', left=1959, top=0, right=2150, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL6', left=2178, top=0, right=2375, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL7', left=2397, top=0, right=2588, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='VAL8', left=2613, top=0, right=2800, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C></B><B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=144 ,face='Arial' ,size=10 ,penwidth=1	<L> left=219 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B><B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>	<L> left=219 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B>";

  ls_for +=" <B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=436 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                  ";
	ls_for +=" 	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                        ";
	ls_for +=" 	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                        ";
	ls_for +=" 	<T>id='거래처원장-거래처별채권채무' ,left=1019 ,top=24 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                         ";
	ls_for +=" 	<L> left=220 ,top=437 ,right=2807 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                    ";
	ls_for +=" 	<L> left=220 ,top=344 ,right=220 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                     ";
	ls_for +=" 	<L> left=220 ,top=341 ,right=2810 ,bottom=341 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                    ";
	ls_for +=" 	<T>id='작성일자 : "+yyyy3+"/"+mm3+"/"+dd3+"' ,left=2379 ,top=233 ,right=2802 ,bottom=280 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>  ";
	ls_for +=" 	<T>id='(기간 : "+yyyy+"년 "+mm+"월 ~ "+yyyy2+"년 "+mm2+"월)' ,left=1003 ,top=122 ,right=1873 ,bottom=169 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>  ";
	ls_for +=" 	<L> left=2810 ,top=344 ,right=2810 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
	ls_for +=" 	<T>id='지   점 : "+fd+"' ,left=233 ,top=228 ,right=516 ,bottom=273 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                         ";
	ls_for +=" 	<T>id='거래처 : "+cmd+"' ,left=233 ,top=278 ,right=1397 ,bottom=323 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                        ";
	ls_for +=" 	<T>id='Page : #p of #t' ,left=2384 ,top=278 ,right=2807 ,bottom=331 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                       ";
	ls_for +=" 	<L> left=1119 ,top=344 ,right=1119 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
	ls_for +=" 	<L> left=1818 ,top=344 ,right=1818 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
	ls_for +=" 	<L> left=2146 ,top=344 ,right=2146 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
	ls_for +=" 	<L> left=2469 ,top=344 ,right=2469 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
	ls_for +=" 	<T>id='공사용역미수금' ,left=1828 ,top=357 ,right=2140 ,bottom=421 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                        ";
	ls_for +=" 	<T>id='미지급금' ,left=2490 ,top=357 ,right=2802 ,bottom=421 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                              ";
	ls_for +=" 	<T>id='외상매입금' ,left=2151 ,top=357 ,right=2463 ,bottom=421 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                            ";
	ls_for +=" 	<T>id='미수금' ,left=1495 ,top=357 ,right=1807 ,bottom=421 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                ";
	ls_for +=" 	<L> left=1466 ,top=344 ,right=1466 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
	ls_for +=" 	<T>id='외상매출금' ,left=1138 ,top=357 ,right=1450 ,bottom=421 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                            ";
	ls_for +=" 	<T>id='업체명' ,left=228 ,top=357 ,right=1111 ,bottom=421 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                 ";
	ls_for +=" </B>                                                                                                                                                                                                                    ";
	ls_for +=" <B>id=default ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                   ";
	ls_for +=" 	<L> left=220 ,top=0 ,right=220 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                        ";
	ls_for +=" 	<L> left=220 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>                                                                                                                      ";
	ls_for +=" 	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" 	<L> left=2469 ,top=0 ,right=2469 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" 	<L> left=2146 ,top=0 ,right=2146 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" 	<L> left=1818 ,top=0 ,right=1818 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" 	<L> left=1119 ,top=0 ,right=1119 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" 	<C>id='VAL5', left=2490, top=0, right=2802, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";
	ls_for +=" 	<C>id='VAL4', left=2151, top=0, right=2463, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";
	ls_for +=" 	<C>id='VAL3', left=1828, top=0, right=2140, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";
	ls_for +=" 	<C>id='VAL2', left=1495, top=3, right=1807, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";
	ls_for +=" 	<C>id='VAL1', left=1138, top=0, right=1450, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";
	ls_for +=" 	<L> left=1466 ,top=0 ,right=1466 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" 	<C>id='CDNAM', left=228, top=0, right=1111, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";
	ls_for +=" 	<L> left=220 ,top=50 ,right=2813 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
	ls_for +=" </B>                                                                                                                                                                                                                    ";
	ls_for +=" <B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                              ";
	ls_for +=" 	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>                                                                                                                                      ";
	ls_for +=" 	<L> left=220 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                        ";
	ls_for +=" </B>                                                                                                                                                                                                                    ";
	

	gcrp_print5.Format = ls_for + gcrp_print5.Format;
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


/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){

  if(e=="01") {
	gcgd_disp01.GridToExcel("거래처원장","",2);
	}
	else if(e=="02") {
	gcgd_disp02.GridToExcel("거래처원장","",2);
	}
  else if(e=="03") {
	gcgd_disp03.GridToExcel("거래처원장","",2);
	}
	else if(e=="04") {
	gcgd_disp04.GridToExcel("채권채무상세","",2);
	}
  else if(e=="05") {
	gcgd_disp05.GridToExcel("거래처별채권채무","",2);
	}

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	gcem_staxdatfr1.text = gs_date3; //탭1
	gcem_staxdatto1.text = gs_date2;
	gcem_staxdatfr2.text = gs_date3; //탭2
	gcem_staxdatto2.text = gs_date2;
	gcem_staxdatfr3.text = gs_date3; //탭3
	gcem_staxdatto3.text = gs_date2;
	gcem_staxdatfr4.text = gs_date3; //탭4
	gcem_staxdatto4.text = gs_date2;
	gcem_staxdatfr5.text = gs_date3; //탭5
	gcem_staxdatto5.text = gs_date2;

	//지점코드1
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();
	//지점코드2
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();
	//지점코드3
	gcds_sfdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode3.Reset();
	//지점코드4
	gcds_sfdcode4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode4.Reset();
	//지점코드5
	gcds_sfdcode5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode5.Reset();
	//거래처코드
	//gcds_scccode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendcode_s1?v_str1="; 
	//gcds_scccode.Reset();

}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-잔액코드, 1-내용항목
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp5","div_disp4");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}

  /*
	var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5");
	for(var i=0;i<=4;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
  */

}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="true">
  <!--param name=SortExpr   value="+ACTDAT"-->
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

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지점코드1 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지점코드2 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지점코드3 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지점코드4 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지점코드5 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 레포트 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id=gcds_print3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id=gcds_print4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id=gcds_print5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--object id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030023_t1(I:USER=gcds_data1)"> 
</object-->

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";	
	//ln_Format1();
	//gcrp_print1.preview(); 		
</script>
<script language="javascript" for="gcds_print2" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print2 event=OnLoadCompleted(row,colid)>
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
    //ln_Sum2();
		/*
		for(i=1;i<=gcds_temp2.countrow;i++){

    if(gcds_temp2.namevalue(i,"ACTDAT")=="누계") gcds_print2.addrow();

		tempdt = gcds_temp2.namevalue(i,"ACTDAT");
		tempdt = tempdt.substring(8,10);

   if(gcds_temp2.namevalue(i,"ACTDAT")!="전기이월" && gcds_temp2.namevalue(i,"ACTDAT")!="월계" && gcds_temp2.namevalue(i,"ACTDAT")!="누계")
   gcds_print2.namevalue(i,"ACTDAT")+tempdt;
   else gcds_print2.namevalue(i,"ACTDAT") = gcds_temp2.namevalue(i,"ACTDAT");
		gcds_print2.namevalue(i,"ATKORNAM") = gcds_temp2.namevalue(i,"ATKORNAM");	
		gcds_print2.namevalue(i,"REMARK")   = gcds_temp2.namevalue(i,"REMARK");
		gcds_print2.namevalue(i,"DETOT")    = gcds_temp2.namevalue(i,"DETOT");
		gcds_print2.namevalue(i,"CRTOT")    = gcds_temp2.namevalue(i,"CRTOT");		 
		}
			ln_Format2();	
	    gcrp_print2.preview();
		*/
</script>

<script language="javascript" for="gcds_print3" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print3 event=OnLoadCompleted(row,colid)>
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";	
	//ln_Format3();
	//gcrp_print3.preview(); 
</script>

<script language="javascript" for="gcds_print4" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print4 event=OnLoadCompleted(row,colid)>
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

   //for(var i=1;i<=gcds_print4.countrow;i++){
	//		gcds_print4.ImportData(gcds_temp4.ExportData(i,1,false));
			//gcds_print4.ImportData(gcds_temp4.ExportData(intfromrow,i,false));
		//alert(gcds_temp4.namevalue(i,"ACTDAT"));	
	// }
	/*
for(var i=1;i<=gcds_print4.countrow;i++){
      alert(gcds_print4.namevalue(i,"ACTDAT"));
		  if(gcds_print4.namevalue(i,"ACTDAT").substring(6,8)!="33")
		   gcds_print4.deleterow(gcds_print4.rowposition);
      // alert(gcds_temp4.namevalue(i,"ACTDAT"));  
			//alert(gcds_print4.namevalue(i,"ACTDAT"));
	}	 
	ln_Format4();
	gcrp_print4.preview(); 
	*/
</script>

<script language="javascript" for="gcds_print5" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print5 event=OnLoadCompleted(row,colid)>
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";	
	//ln_Format5();
	//gcrp_print5.preview(); 
</script>

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script><!--그리드1-->

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
	ln_SetDataHeader1();
	gcds_temp1.ClearData();
	ln_Sum1(); // 잔액
	gcds_data1.ClearData();
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script><!--그리드2-->

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//ft_cnt02.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");     	
	
  ln_SetDataHeader2();
	gcds_temp2.ClearData();
	ln_Sum2(); // 누계
	gcds_data2.ClearData();
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script><!--그리드3-->

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt03.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");     	 
  ln_SetDataHeader3();
	gcds_temp3.ClearData();
	ln_Sum3(); // 누계
	gcds_data3.ClearData();
</script>

<script language="javascript" for="gcds_data4" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script><!--그리드4-->

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//ft_cnt04.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");     
	//alert(""+row);
  ln_SetDataHeader4();
	gcds_temp4.ClearData();
	ln_Sum4(); // 누계
	gcds_data4.ClearData();

  //alert("countrow"+ gcds_temp4.countrow);
	/*
	for(var i=1;i<=gcds_temp4.countrow;i++){
 		  if(gcds_temp4.namevalue(i,"ACTDAT").substring(6,8)!="33")
		   gcds_temp4.deleterow(gcds_data4.rowposition);
 	}	
	*/

</script>

<script language="javascript" for="gcds_data5" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script><!--그리드5-->

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt05.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");     	 
  //ln_SetDataHeader4();
	//gcds_temp4.ClearData();
	//ln_Sum4(); // 누계
	//gcds_data4.ClearData();
</script>



<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode3" event="onloadCompleted(row,colid)">
	gcds_sfdcode3.InsertRow(1);
	gcds_sfdcode3.NameValue(1,"FDCODE")="";
	gcds_sfdcode3.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode3.index=2;
	}else{
		gclx_sfdcode3.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode4" event="onloadCompleted(row,colid)">
	gcds_sfdcode4.InsertRow(1);
	gcds_sfdcode4.NameValue(1,"FDCODE")="";
	gcds_sfdcode4.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode4.index=2;
	}else{
		gclx_sfdcode4.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode5" event="onloadCompleted(row,colid)">
	gcds_sfdcode5.InsertRow(1);
	gcds_sfdcode5.NameValue(1,"FDCODE")="";
	gcds_sfdcode5.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode5.index=2;
	}else{
		gclx_sfdcode5.bindcolval=gs_fdcode;
	}
</script>

<!--계정별잔액을 더블클릭했을 경우 계정별내용 검색 -->
<script language="JavaScript" for="gcgd_disp01" event="OnDblClick(row, colid)">
  gcds_temp2.clearAll();
	gcte_disp.ActiveIndex = 2;	
  //ln_DispChk(1);
	if (row <1) return;
	var str1 = gclx_sfdcode1.BindColVal;        	//지점코드
	var str2 = gcem_staxdatfr1.text;	    	      //기간from 
	var str3 = gcem_staxdatto1.text;              //기간to		
	var str4 = txt_scccode1.value;                //거래처
	var str5 = gcds_temp1.namevalue(gcds_temp1.rowposition,"ATCODE"); //계정과목1
	var str6 = gcds_temp1.namevalue(gcds_temp1.rowposition,"ATCODE"); //계정과목2
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s2?v_str1="+str1
														                              + "&v_str2="+str2
														                              + "&v_str3="+str3
														                          	  + "&v_str4="+str4
												                        		      + "&v_str5="+str5
												                          			  + "&v_str6="+str6;
  //prompt('',gcds_data2.DataID);
	
	gcds_data2.Reset();

 gclx_sfdcode2.BindColVal= gclx_sfdcode1.BindColVal;  
 txt_scccode3.value  = txt_scccode1.value;
 txt_scccode4.value  = txt_scccode2.value;
 gcem_atcode_fr02.text = gcds_temp1.namevalue(gcds_temp1.rowposition,"ATCODE"); 
 txt_atkornam_fr02.value =  gcds_temp1.namevalue(gcds_temp1.rowposition,"ATKORNAM"); 
 gcem_atcode_to02.text =  gcds_temp1.namevalue(gcds_temp1.rowposition,"ATCODE"); 
 txt_atkornam_to02.value =  gcds_temp1.namevalue(gcds_temp1.rowposition,"ATKORNAM"); 
 gcem_staxdatfr2.text= gcem_staxdatfr1.text;
 gcem_staxdatto2.text= gcem_staxdatto1.text;

// alert("txt_atkornam_fr02"+txt_atkornam_fr02.value);
 //alert("txt_atkornam_fr01"+txt_atkornam_fr01.value);

</script>

<!--거래처별잔액을 더블클릭했을 경우 계정별내용 검색 -->
<script language="JavaScript" for="gcgd_disp03" event="OnDblClick(row, colid)">
  gcds_temp4.clearAll();
	gcte_disp.ActiveIndex = 4;	
  //ln_DispChk(1);
	if (row <1) return;
	var str1 = gclx_sfdcode3.BindColVal;        	//지점코드
	var str2 = gcem_staxdatfr3.text;	    	      //기간from 
	var str3 = gcem_staxdatto3.text;              //기간to		
	var str4 = gcds_temp3.namevalue(gcds_temp3.rowposition,"FSREFVAL");  //거래처 from
	var str5 = gcds_temp3.namevalue(gcds_temp3.rowposition,"FSREFVAL");  //거래처 to
	var str6 = gcem_atcode_fr03.text;                                    //계정과목


  gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s4?v_str1="+str1
														                              + "&v_str2="+str2
														                              + "&v_str3="+str3
														                          	  + "&v_str4="+str4
												                        		      + "&v_str5="+str5
												                          			  + "&v_str6="+str6;
	//prompt("", gcds_data4.DataID);
	gcds_data4.Reset();
	gclx_sfdcode4.BindColVal= gclx_sfdcode3.BindColVal;  
	txt_scccode9.value  = txt_scccode5.value; 
	txt_scccode10.value = txt_scccode6.value;
	txt_scccode11.value = txt_scccode7.value;
	txt_scccode12.value =  txt_scccode8.value;
	gcem_atcode_fr04.text = gcem_atcode_fr03.text;
	txt_atcode_fr04.value = txt_atcode_fr03.value; 
</script>



<!--계정별내용 더블클릭시 전표팝업-->
<script language="JavaScript" for="gcgd_disp02" event="OnDblClick(row, colid)">
	var str1 = gclx_sfdcode2.BindColVal;
	var str2 = gcds_temp2.namevalue(gcds_temp2.rowposition,"ACTDAT");
	var str3 = gcds_temp2.namevalue(gcds_temp2.rowposition,"ATCODE");
	var str4 = txt_scccode3.value;
	var str5 = gcds_temp2.namevalue(gcds_temp2.rowposition,"DETOT");
	var str6 = gcds_temp2.namevalue(gcds_temp2.rowposition,"CRTOT");


	var strTo = str2;
	for(i=0; i<strTo.length; i++){
	strTo = strTo.replace('-', '');
 }
 	//alert(str1);	
 //alert(strTo);
 //	alert(str3);	
 //	alert(str4);	
	gcds_temp5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s6" +"?v_str1="+str1+"&v_str2="+strTo+"&v_str3="+str3
	+"&v_str4=" + str4 +"&v_str5=" + str5+"&v_str6=" + str6;	
		gcds_temp5.Reset();
	//	prompt("",gcds_temp5.DataID);

</script>


<!--거래처별내용 더블클릭시 전표팝업-->
<script language="JavaScript" for="gcgd_disp04" event="OnDblClick(row, colid)">
	var str1 = gclx_sfdcode4.BindColVal;
	var str2 = gcds_temp4.namevalue( gcds_temp4.rowposition,"ACTDAT");
	var str3 = gcds_temp4.namevalue( gcds_temp4.rowposition,"ATCODE");
	var str4 = gcds_temp4.namevalue( gcds_temp4.rowposition,"FSREFVAL");
	var strTo = str2;
	for(i=0; i<strTo.length; i++){
		strTo = strTo.replace('-', '');
	}
	var str5 = gcds_temp4.namevalue(gcds_temp4.rowposition,"DETOT");
	var str6 = gcds_temp4.namevalue(gcds_temp4.rowposition,"CRTOT");

	gcds_temp5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s6" +"?v_str1="+str1+"&v_str2="+strTo+"&v_str3="+str3
	+"&v_str4=" + str4 +"&v_str5=" + str5+"&v_str6=" + str6;	
	gcds_temp5.Reset();

</script>


<!--채권채무내역 -->
<script language="JavaScript" for="gcgd_disp05" event="OnDblClick(row, colid)">

  if(colid!="VAL1"&&colid!="VAL2"&&colid!="VAL3"&&colid!="VAL4"&&colid!="VAL5"){
		alert("해당 계정의 금액을 더블 클릭 하십시요.");
		return false;
	}
    gcds_temp4.clearAll();
	gcte_disp.ActiveIndex = 2;	
  //ln_DispChk(1);
	if (row <1) return;
	var str1 = gclx_sfdcode5.BindColVal;        	//지점코드
	var str2 = gcem_staxdatfr5.text;	    	      //기간from 
	var str3 = gcem_staxdatto5.text;              //기간to		
	var str4 = gcds_data5.namevalue(gcds_data5.rowposition,"FSREFVAL");  //거래처 
	var str5 = gcds_data5.namevalue(gcds_data5.rowposition,"FSREFVAL");  //거래처
	var str6 = "";
	var str7 = "";
  
	if(colid=="VAL1"){
	   str6 = "1110310"; 
		 str7="외상매출금";
	}else if(colid=="VAL2"){
	  str6 = "1110610"; 
		str7="미수금";
	}else if(colid=="VAL3"){ 
	  str6 = "1110620"; 
		str7="공사용역미수금";
	}else if(colid=="VAL4"){
	  str6 = "2100110"; 
		str7="외상매입금";
	}else if(colid=="VAL5"){
	  str6 = "2100510"; 
		str7="미지급금";
	}

  gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030023_s14?v_str1="+str1
														                              + "&v_str2="+str2
														                              + "&v_str3="+str3
														                          	  + "&v_str4="+str4
												                        		      + "&v_str5="+str5
												                          			  + "&v_str6="+str6;
	//prompt("", gcds_data4.DataID);
	gcds_data4.Reset();
	gclx_sfdcode4.BindColVal= gclx_sfdcode5.BindColVal;  
	txt_scccode9.value  = gcds_data5.namevalue(gcds_data5.rowposition,"FSREFVAL"); 
	txt_scccode10.value = gcds_data5.namevalue(gcds_data5.rowposition,"CDNAM");
	txt_scccode11.value = gcds_data5.namevalue(gcds_data5.rowposition,"FSREFVAL"); 
	txt_scccode12.value =  gcds_data5.namevalue(gcds_data5.rowposition,"CDNAM");
	gcem_atcode_fr04.text = str6;
	txt_atcode_fr04.value = str7; 
  gcem_staxdatfr4.text= str2 ;	    	      //기간from 
	gcem_staxdatto4.text= str3 ;              //기간to	 

</script>

<script language="javascript" for="gcds_temp5" event="onloadCompleted(row,colid)">
	var p_fcode = gcds_temp5.namevalue(gcds_temp5.rowposition,"FDCODE");
	 //alert(p_fcode);
	var p_fsdt  = gcds_temp5.namevalue(gcds_temp5.rowposition,"FSDAT");
		//alert(p_fcode);
	var p_fnbr = gcds_temp5.namevalue(gcds_temp5.rowposition,"FSNBR");
	//alert(p_fnbr);
		
	if(p_fcode== "")	alert("지점을 선택하십시오");
	ln_Popup7(p_fcode,p_fsdt,p_fnbr);
	gcds_temp5.ClearData();
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 잔액 -->
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">

	//ln_DispChk((index-1));

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!--
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript for=gctr_data2 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>
-->

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030017_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						  <PARAM NAME="BackColor"					  VALUE="#cccccc">
   					      <PARAM NAME="titleHeight"					VALUE="20px">
						  <PARAM NAME="DisableBackColor"	  VALUE="#eeeeee">
						  <PARAM NAME="Format"						  VALUE="
							    <T>divid=div_5		title=거래처별채권채무</T>
								<T>divid=div_4		title=상세내용</T>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------- 계정별잔액 --------------->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:455px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="10" style="display:none">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
			
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:165px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode1">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">거&nbsp;래&nbsp;처</td>
				<td class="tab22" width="220px">&nbsp;
					<nobr>
					<input id="txt_scccode2" type="text" class="txtbox"  style= "position:relative;left:-7px;top:3px;width:150px;height:20px;" maxlength="32">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup1();">
					<input id="txt_scccode1" type="text" class="txtbox"  style= "position:relative;left:-7px;top:3px;width:90px;height:20px;" maxlength="13">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3"><nobr>
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('01')">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('01')">
					<img src="../../Common/img/btn/com_b_query.gif"     style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('01')">
					</nobr>
				</td>
			</tr>
			
			<tr>			
				<td class="tab12" width="80px" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab23" style="height:30px;width:165px;">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr1', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto1', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;"></nobr>&nbsp;
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">계정과목</td>
				<td class="tab10" colspan="5" width="490px"><nobr>
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;left:5px;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup01('fr','01');">
					<comment id="__NSID__"><object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:10px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 					
					<font style="position:relative;left:10px">~</font>&nbsp;
 					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;left:5px;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup01('to','01');">
				    <comment id="__NSID__"><object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:10px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> </nobr>
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
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
						style="position:relative;left:8px;width:864px;height:360px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			     VALUE="gcds_temp1">
						<PARAM NAME="IndWidth"		     VALUE="0">
						<PARAM NAME="BorderStyle"      VALUE="0">
						<PARAM NAME="Fillarea"		     VALUE="true">
						<param name="Editable"         value="false">
			          <PARAM NAME="viewSummary"      VALUE="1">						
					  <PARAM NAME="ColSizing"		     VALUE="true">
					  <PARAM NAME="SortView"		     VALUE="left">
						<PARAM NAME="Format"			     VALUE="
						<C> Name='계정코드'  ID=ATCODE		 SumText='합계'  SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=80		 align=center show=false</C> 
						<C> Name='계정과목'  ID=ATKORNAM   SumText='합계'  SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=365   align=left</C>	
						<C> Name='거래처코드'  ID=FSREFVAL   SumText='합계'  SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=120   align=left show=false</C>	
						<C> Name='거래처명'  ID=VEND_NM    SumText='합계'  SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=120   align=left show=false</C>	
						<C> Name='전기이월'	 ID=BEVAL      SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right </C>
						<C> Name='차변'	    ID=DETOT       SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right</C> 
						<C> Name='대변'	    ID=CRTOT	     SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right</C> 
						<C> Name='잔액'	    ID=SLPVAL      SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right </C>
						">
						<!--
						<C> Name='계정코드'  ID=ATCODE     SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=170    align=left show=false</C> 
						<C> Name='계정과목'  ID=ATKORNAM   SumText='합계'   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=365    align=left</C> 
						<C> Name='전기이월'	 ID=BEVAL      SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right </C>
						<C> Name='차변'	    ID=DETOT       SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right</C> 
						<C> Name='대변'	    ID=CRTOT	     SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right</C> 
						<C> Name='잔액'	    ID=SLPVAL      SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right </C>  -->
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 
<!------------- 계정별내용 --------------->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:455px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
			
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:165px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">거&nbsp;래&nbsp;처</td>
				<td class="tab22" width="220px">&nbsp;
					<nobr>
					<input id="txt_scccode4" type="text" class="txtbox"  style= "position:relative;left:-7px;top:3px;width:150px;height:20px;" maxlength="32">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup2();">
					<input id="txt_scccode3" type="text" class="txtbox"  style= "position:relative;left:-7px;top:3px;width:90px;height:20px;" maxlength="13">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3"><nobr>
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('02')">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('02')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('02')">
					</nobr>
				</td>
			</tr>
			
			<tr>			
				<td class="tab12" width="80px" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab23" style="height:30px;width:165px;">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;"></nobr>&nbsp;
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">계정과목</td>
				<td class="tab10" colspan="5" width="490px"><nobr>
					<input id="txt_atkornam_fr02" type="text" class="txtbox"  style= "position:relative;left:5px;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup01('fr','02');">
					<comment id="__NSID__"><object  id=gcem_atcode_fr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:10px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<font style="position:relative;left:10px">~</font>&nbsp;
					<input id="txt_atkornam_to02" type="text" class="txtbox"  style= "position:relative;left:5px;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup01('to','02');">
				 <comment id="__NSID__"><object  id=gcem_atcode_to02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:10px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					</nobr>
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
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
						style="position:relative;left:8px;width:864px;height:360px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			     VALUE="gcds_temp2">
						<PARAM NAME="IndWidth"		     VALUE="0">
						<PARAM NAME="BorderStyle"      VALUE="0">
						<PARAM NAME="Fillarea"		     VALUE="true">
						<param name="Editable"         value="false">
			      <PARAM NAME="viewSummary"      VALUE="0">						
					  <PARAM NAME="ColSizing"		     VALUE="true">
					  <PARAM NAME="SortView"		     VALUE="left">
						<PARAM NAME="Format"			     VALUE="
					  <C> Name='계정코드' ID=ATCODE    HeadBgColor=#B9D4DC  bgcolor={decode(GUBUN,'00','#FFCCFF','32','#FFFFCC','33','#fafafa',#ffffff )}  width=70  align=center show=false</C>
						<C> Name='계정과목'  ID=ATKORNAM  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=215 align=left  </C> 
						<C> Name='거래처코드'  ID=FSREFVAL   SumText='합계'  SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=120   align=left show=false</C>	
						<C> Name='거래처명'  ID=VEND_NM   SumText='합계'  SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=120   align=left show=false</C>	
						<C> Name='일자'     ID=ACTDAT    HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=80  align=center  value={decode(GUBUN,'00','','32','','33','',ACTDAT)} MASK='XXXX/XX/XX'</</C>
						<C> Name='적요'     ID=REMARK    HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=250 align=left</C>
						<C> Name='차변'     ID=DETOT     HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=100 align=right</C> 
						<C> Name='대변'     ID=CRTOT     HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=100 align=right</C> 
						<C> Name='잔액'     ID=JANAMT    HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=100 align=right</C> 
						"><!--
						<C> Name='계정코드' ID=ATCODE HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=170    align=left show=false</C>
						<C> Name='일자' ID=ACTDAT HeadBgColor=#B9D4DC bgcolor=#ffffff width=80 align=center</C>
						<C> Name='계정과목' ID=ATKORNAM  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=315    align=left</C> 
						<C> Name='적요' ID=REMARK HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=250 align=left</C>
						<C> Name='차변'  ID=DETOT  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=100    align=right</C> 
						<C> Name='대변'  ID=CRTOT  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=100    align=right</C> -->
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!------------- 거래처별잔액 --------------->
<fieldset id=field3 style="position:absolute;top:160px;left:18px;height:455px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:10 solid #708090;">
			<tr>
			
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:250px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode3">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab22" width="220px">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr3', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto3', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;"></nobr>&nbsp;				
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3"><nobr>
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('03')">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('03')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('03')">
					</nobr>
				</td>
			</tr>
			
			<tr>			
				<td class="tab12" width="80px" bgcolor="#eeeeee">계정과목</td>
				<td class="tab23" style="height:30px;width:250px;"><nobr>
				<input id="txt_atcode_fr03" type="text" class="txtbox"  style= "position:relative;left:5px;top:-4px;width:100px;height:20px;" maxlength="36"  disabled>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup3();">
					<comment id="__NSID__"><object  id=gcem_atcode_fr03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:10px;top:0px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> </nobr>
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">거&nbsp;래&nbsp;처</td>
				<td class="tab10" colspan="5" width="490px">&nbsp;
					<nobr>
					<input id="txt_scccode6" type="text" class="txtbox"  style= "position:relative;left:-7px;top:-2px;width:105px;height:20px;" maxlength="32">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup02('fr','03');">
					<input id="txt_scccode5" type="text" class="txtbox"  style= "position:relative;left:-7px;top:-2px;width:45px;height:20px;" maxlength="13">~&nbsp;
					<input id="txt_scccode8" type="text" class="txtbox"  style= "position:relative;left:-7px;top:-2px;width:105px;height:20px;" maxlength="32">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup02('to','03');">
					<input id="txt_scccode7" type="text" class="txtbox"  style= "position:relative;left:-7px;top:-2px;width:45px;height:20px;" maxlength="13">
					</nobr>
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
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
						style="position:relative;left:8px;width:864px;height:360px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			     VALUE="gcds_temp3">
						<PARAM NAME="IndWidth"		     VALUE="0">
						<PARAM NAME="BorderStyle"      VALUE="0">
						<PARAM NAME="Fillarea"		     VALUE="true">
						<param name="Editable"         value="false">
			      <PARAM NAME="viewSummary"      VALUE="1">						
					  <PARAM NAME="ColSizing"		     VALUE="true">
					  <PARAM NAME="SortView"		     VALUE="left">
						<PARAM NAME="Format"			     VALUE="
						<C> Name='거래처코드' ID=FSREFVAL SumText='합계'   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=80    align=center show=false</C> 
						<C> Name='거래처'   ID=CDNAM SumText='합계'   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=365    align=left  sort=true</C> 		
						<C> Name='전기이월'	ID=BEVAL      SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right </C>
						<C> Name='차변'	    ID=DETOT       SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right</C> 
						<C> Name='대변'	    ID=CRTOT	     SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right</C> 
						<C> Name='잔액'	    ID=SLPVAL      SumText=@sum    SumBgColor=#C3D0DB  HeadAlign=Center  HeadBgColor=#B9D4DC Width=120	 align=right </C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!------------- 거래처별내용 --------------->
<fieldset id=field4 style="position:absolute;top:160px;left:18px;height:455px;width:875px;bacground-color:#708090"></fieldset>
<div id="div_4" style="position:absolute;top:160px;left:170px;height:485px;width:870px;" >
<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" >
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-147px;width:866px;border:1 solid #708090;">
			<tr>
			
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:250px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode4">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab22" width="220px">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr4', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto4', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;"></nobr>&nbsp;				
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3"><nobr>
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('04')">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('04')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('04')">
					</nobr>
				</td>
			</tr>
			
			<tr>			
				<td class="tab12" width="80px" bgcolor="#eeeeee">계정과목</td>
				<td class="tab23" style="height:30px;width:250px;"><nobr>
					<input id="txt_atcode_fr04" type="text" class="txtbox"  style= "position:relative;left:5px;top:-3px;width:100px;height:20px;" maxlength="36"  disabled></nobr>
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:2px" align=center onclick="ln_Popup4();">
					<comment id="__NSID__"><object  id=gcem_atcode_fr04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:10px;top:3px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 				
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">거&nbsp;래&nbsp;처</td>
				<td class="tab10" colspan="5" width="490px">&nbsp;
					<nobr>
					<input id="txt_scccode10" type="text" class="txtbox"  style= "position:relative;left:-7px;top:0px;width:105px;height:20px;" maxlength="32">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup02('fr','04');">
					<input id="txt_scccode9" type="text" class="txtbox"  style= "position:relative;left:-7px;top:0px;width:45px;height:20px;" maxlength="13">~&nbsp;
					<input id="txt_scccode12" type="text" class="txtbox"  style= "position:relative;left:-7px;top:0px;width:105px;height:20px;" maxlength="32">		
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup02('to','04');">
					<input id="txt_scccode11" type="text" class="txtbox"  style= "position:relative;left:-7px;top:0px;width:45px;height:20px;" maxlength="13">
					</nobr>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-155px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp04  
						style="position:relative;left:8px;width:864px;height:360px; border:1 solid #708090;" viewastext>
						<PARAM NAME="DataID"			     VALUE="gcds_temp4">
						<PARAM NAME="IndWidth"		     VALUE="0">
						<PARAM NAME="BorderStyle"      VALUE="0">
						<PARAM NAME="Fillarea"		     VALUE="true">
						<param name="Editable"         value="false">
			          <PARAM NAME="viewSummary"      VALUE="0">						
					  <PARAM NAME="ColSizing"		     VALUE="true">
					  <PARAM NAME="SortView"		     VALUE="left">
						<PARAM NAME="Format"			     VALUE="
						<C> Name='일자'      ID=ACTDAT  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=70    align=center</C> 
						<C> Name='거래처코드'	  ID=FSREFVAL   HeadAlign=Center  HeadBgColor=#B9D4DC Width=80	 align=center show=false</C>
						<C> Name='거래처'	  ID=CDNAM   HeadAlign=Center  HeadBgColor=#B9D4DC Width=200	 align=left </C>
						<C> Name='적요'	    ID=REMARK  HeadAlign=Center  HeadBgColor=#B9D4DC Width=250	 align=left</C> 
						<C> Name='차변'	    ID=DETOT   HeadAlign=Center  HeadBgColor=#B9D4DC Width=100	 align=right</C> 
						<C> Name='대변'	    ID=CRTOT   HeadAlign=Center  HeadBgColor=#B9D4DC Width=100	 align=right </C>
						<C> Name='잔액'	    ID=JANAMT  HeadAlign=Center  HeadBgColor=#B9D4DC Width=100	 align=right </C>
						">
						<!--
						<C> Name='일자'      ID=ACTDAT  HeadBgColor=#B9D4DC  bgcolor=#ffffff  width=80    align=center</C> 
						<C> Name='거래처'	  ID=CDNAM   HeadAlign=Center  HeadBgColor=#B9D4DC Width=315	 align=left </C>
						<C> Name='적요'	    ID=REMARK  HeadAlign=Center  HeadBgColor=#B9D4DC Width=250	 align=left</C> 
						<C> Name='차변'	    ID=DETOT   HeadAlign=Center  HeadBgColor=#B9D4DC Width=100	 align=right</C> 
						<C> Name='대변'	    ID=CRTOT  HeadAlign=Center  HeadBgColor=#B9D4DC Width=100	 align=right </C>
						<C> Name='계정코드'   ID=ATCODE     HeadBgColor=#B9D4DC   align=left show=false</C> 	
						-->
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt04 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 
</div>
<!------------- 거래처별채권채무 --------------->
<fieldset id=field5 style="position:absolute;top:160px;left:18px;height:455px;width:875px;bacground-color:#708090"></fieldset>
<div id="div_5" style="position:absolute;top:160px;left:170px;height:485px;width:870px;" >
<table id="div_disp5" cellpadding="0" cellspacing="0" border="0" >
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-147px;width:866px;border:1 solid #708090;">
			<tr>
			
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:300px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode5">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab22" width="220px">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr5', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:0px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto5', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;"></nobr>&nbsp;				
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3"><nobr>
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('05')">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('05')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('05')">
					</nobr>
				</td>
			</tr>
			
			<tr>			
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">거&nbsp;래&nbsp;처</td>
				<td class="tab10" colspan="5" width="490px">&nbsp;
					<nobr>
					<input id="txt_scccode14" type="text" class="txtbox"  style= "position:relative;left:-7px;top:0px;width:105px;height:20px;" maxlength="32">			
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-7px;top:1px" align=center onclick="ln_Popup5();">
					<input id="txt_scccode13" type="text" class="txtbox"  style= "position:relative;left:-7px;top:0px;width:65px;height:20px;" maxlength="13">
					</nobr>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-155px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp05  
						style="position:relative;left:8px;width:864px;height:360px; border:1 solid #708090;" viewastext>
						<PARAM NAME="DataID"			     VALUE="gcds_data5">
						<PARAM NAME="IndWidth"		     VALUE="0">
						<PARAM NAME="BorderStyle"      VALUE="0">
						<PARAM NAME="Fillarea"		     VALUE="true">
						<param name="Editable"         value="true">
			          <PARAM NAME="viewSummary"      VALUE="1">						
					  <PARAM NAME="ColSizing"		     VALUE="true">
					  <PARAM NAME="SortView"		     VALUE="left">
						<PARAM NAME="Format"			     VALUE="
						<C> Name='업체코드'	       ID=FSREFVAL HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=80	   align=center edit=none  </C>
						<C> Name='업체명'	         ID=CDNAM    HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=243	 align=left   edit=none SumText='합   계' SumTextAlign=center sort = true</C>
						<C> Name='외상매출금'	     ID=VAL1     HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=105	 align=right  edit=none SumText=@sum sort = true</C> 
						<C> Name='미수금'	         ID=VAL2     HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=105	 align=right  edit=none SumText=@sum sort = true</C>
						<C> Name='공사용역미수금'	 ID=VAL3     HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=105	 align=right  edit=none SumText=@sum sort = true</C> 
						<C> Name='외상매입금'	     ID=VAL4     HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=105	 align=right  edit=none SumText=@sum sort = true</C>
						<C> Name='미지급금'	       ID=VAL5     HeadAlign=Center  HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB Width=105	 align=right  edit=none SumText=@sum sort = true</C>
						
  					">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt05 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
					</td>
				</tr>
			</table>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data
						style="position:absolute;top:452px; left:0px;WIDTH:874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_temp5">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="ViewHeader"	VALUE="False">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="HiddenVScroll" VALUE="True">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="
							<C> Name='' ID=FDCODE  	HeadAlign=Center	HeadBgColor=#B9D4DC  BgColor='#C3D0DB' Width=80  </C>
							<C> Name='' ID=FSDAT  	HeadAlign=Center	HeadBgColor=#B9D4DC BgColor='#C3D0DB' Width=70 align=center</C>
							<C> Name='' ID=FSNBR		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=86 align=RIGHT </C>	
							">
            </object></comment><script>__ws__(__NSID__);</script>  
		</td> 
	</tr> 
</table> 
</div>
<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_temp1">
	<param NAME="DetailDataID"			VALUE="gcds_temp1">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
 <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcrp_print2" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_temp2">
	<param NAME="DetailDataID"			VALUE="gcds_temp2">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<param name="BandSelection"		value="default:default">
	<!-- <PARAM NAME="NullRecordFlag"		    VALUE="false"> -->
	<param name="SuppressColumns"	      value="1:PageSkip,ATKORNAM2">
	<PARAM NAME="Format"                VALUE="
">

</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcrp_print3" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_temp3">
	<param NAME="DetailDataID"			VALUE="gcds_temp3">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
 <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcrp_print4" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_temp4">
	<param NAME="DetailDataID"			VALUE="gcds_temp4">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
 <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcrp_print5" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_data5">
	<param NAME="DetailDataID"			VALUE="gcds_data5">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
 <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

