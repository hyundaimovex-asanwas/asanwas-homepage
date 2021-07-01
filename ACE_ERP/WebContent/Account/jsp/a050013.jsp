<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 수출실적명세서
+ 프로그램 ID	:  A050013.html
+ 기 능 정 의	:  수출실적명세서 엑셀파일을 업로드 하여 
                 수출실적명세서 테이블에 저장하고, 이 데이터로 부터 
								 텍스트 파일을 생성하기 위해 내려받기 한다.
+ 작   성  자 :  정 영 식
+ 서 블 릿 명	:	 a050013_s1
-----------------------------------------------------------------------------
+ 수 정 내 용 :	수출실적명세서 전산매체작성 변경 ( 외화금액 13,2 -> 15,2 )         
+ 수   정  자 : 정  영  식
+ 수 정 일 자 :  2014.04.17
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>수출실적명세서</title>

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
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드

var gs_frdt="";
var gs_todt="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}


/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_saccyy.text    = gs_date2;	//년도
	gclx_saccyyqt.index = 0;				//기수

	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
    gclx_sfdcode.index=0;

	if (gcds_data99.countrow<1){
    
  }
}

/******************************************************************************
	Description : 엑셀 적용 버튼 작업시 엑셀Data ==> Grid로 업로드 함               
******************************************************************************/
function ln_Excel_Apply(){
  var s_temp = "";
	
	//데이터 초기화 ( 화면 Clear ) 
	gcds_head_a.clearAll();
	gcds_data_b.clearAll();

    //설정
	ln_Cnt_Setting();
	ln_SetDataHeader();

    //excel_upload ( grid와 연동 )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head 만들기
    //파일경로
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL")  = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_t2(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	//gctr_data_excel.Action = g_servlet+"/Account.excel_upload_t2?";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_t2?";

	gctr_data_excel.post();
}

/******************************************************************************************
	Description : C 테이블 빈값지정
******************************************************************************************/
function ln_Upload_Grid(){
 var strFDCODE="02";
 var strDATADIV="C";
 var strACCYM=gs_todt.substring(0,6);
 var strRPTGB="3";
 var strVENDID="2218113834";
 
	for(var i=1;i<=gcds_excel_grid.countrow;i++ ){
		gcds_excel_grid.namevalue(i,"FDCODE")=strFDCODE;
		gcds_excel_grid.namevalue(i,"DATADIV")=strDATADIV;
		gcds_excel_grid.namevalue(i,"ACCYM")=strACCYM;
		gcds_excel_grid.namevalue(i,"RPTGB")=strRPTGB;
		gcds_excel_grid.namevalue(i,"VENDID")=strVENDID;
		gcds_excel_grid.namevalue(i,"SEQNO")=i;
	}

	//A 테이블 입력값 셋팅
  ln_A_Setting(strFDCODE,"A",strACCYM,strRPTGB,strVENDID );

	//B 테이블 입력값 셋팅 
  ln_B_Setting(strFDCODE,"B",strACCYM,strRPTGB,strVENDID );
	//prompt('gcds_excel_grid',gcds_excel_grid.text);
	//prompt('gcds_head_a',gcds_head_a.text);
	//prompt('gcds_data_b',gcds_data_b.text);
}


/******************************************************************************************
	Description : 분기수에 의한 귀속년월 자동설정
******************************************************************************************/
function ln_Cnt_Setting(){
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var yyyy = gcem_saccyy.text;			//년도

	if(gisu=="1"){ 
		gs_frdt = yyyy+"0101";
		gs_todt = yyyy+"0331";
	}else if(gisu=="2"){
		gs_frdt = yyyy+"0401";
		gs_todt = yyyy+"0630";
	}else if(gisu=="3"){
		gs_frdt = yyyy+"0701";
		gs_todt = yyyy+"0930";
	}else if(gisu=="4"){
		gs_frdt = yyyy+"1001";
		gs_todt = yyyy+"1231";
	}
}

/******************************************************************************
	Description : Head(A,B 테이블) 설정  OK
******************************************************************************/
function ln_SetDataHeader(){
    var s_tmp1="";
	var s_tmp2="";

	s_tmp1 = "FDCODE:STRING,DATADIV:STRING,ACCYM:STRING,RPTGB:STRING,VENDID:STRING,VENDNM:STRING,"
			    + "VDDIRECT:STRING,VDADDR:STRING,BSNSCND:STRING,BSNSKND:STRING,PERIOD:STRING,WRDT:STRING,FILLER:STRING";
	gcds_head_a.SetDataHeader(s_tmp1);

	s_tmp2 = "FDCODE:STRING,DATADIV:STRING,ACCYM:STRING,RPTGB:STRING,VENDID:STRING,"
			    + "CNT_SUM:DECIMAL,FOAMT_SUM:DECIMAL,KOAMT_SUM:DECIMAL,EXCNT:DECIMAL,EXFOAMT:DECIMAL,EXKOAMT:DECIMAL,"
				+ "ETCNT:DECIMAL,ETFOAMT:DECIMAL,ETKOAMT:DECIMAL,FILLER:STRING";
	gcds_data_b.SetDataHeader(s_tmp2);
 }


/******************************************************************************************
	Description : A 테이블 설정
******************************************************************************************/
function ln_A_Setting(p1,p2,p3,p4,p5){

	gcds_head_a.Addrow();
	gcds_head_a.namevalue(gcds_head_a.rowposition,"FDCODE")=p1;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"DATADIV")="A";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"ACCYM")=p3;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"RPTGB")=p4;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VENDID")=p5;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VENDNM")="현대아산 주식회사";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VDDIRECT")="배국환";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"VDADDR")="강원 고성군 현내면 화진포서길 10";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"BSNSCND")="서비스건설외";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"BSNSKND")="기타사업남북경제협력사업";
    gcds_head_a.namevalue(gcds_head_a.rowposition,"PERIOD")=gs_frdt+gs_todt;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"WRDT")=gs_todt;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"FILLER")="";

}

/******************************************************************************************
	Description : B 테이블 설정
******************************************************************************************/
function ln_B_Setting(p1,p2,p3,p4,p5){

	gcds_data_b.Addrow();
	gcds_data_b.namevalue(gcds_data_b.rowposition,"FDCODE")=p1;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"DATADIV")="B";
	gcds_data_b.namevalue(gcds_data_b.rowposition,"ACCYM")=p3;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"RPTGB")=p4;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"VENDID")=p5;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"CNT_SUM")=gcds_excel_grid.countrow;           // 일단 한건으로 인식 ( 추후 확인해야함. )
	gcds_data_b.namevalue(gcds_data_b.rowposition,"FOAMT_SUM")=gcds_excel_grid.sum(5,0,0);
	gcds_data_b.namevalue(gcds_data_b.rowposition,"KOAMT_SUM")=gcds_excel_grid.sum(6,0,0);
	gcds_data_b.namevalue(gcds_data_b.rowposition,"EXCNT")=gcds_excel_grid.countrow;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"EXFOAMT")=gcds_excel_grid.sum(5,0,0);
    gcds_data_b.namevalue(gcds_data_b.rowposition,"EXKOAMT")=gcds_excel_grid.sum(6,0,0);
    gcds_data_b.namevalue(gcds_data_b.rowposition,"ETCNT")=0;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"ETFOAMT")=0;
    gcds_data_b.namevalue(gcds_data_b.rowposition,"ETKOAMT")=0;
	gcds_data_b.namevalue(gcds_data_b.rowposition,"FILLER")="";
}

/******************************************************************************************
	Description : 수출실적명세서 DB INSERT
*****************************************************************************************/
function ln_Create(){

	if(gcds_head_a.IsUpdated) {	
		if (confirm("수출실적명세서 데이터를 생성 하시겠습니까?")){	
			gctr_data.KeyValue = "Account.a050013_t1(I:USER=gcds_head_a,I:USER2=gcds_data_b,I:USER3=gcds_excel_grid)";
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_t1?";

			//prompt('gcds_head_a',gcds_head_a.text);
      //prompt('gcds_data_b',gcds_data_b.text);
			//prompt('gcds_excel_grid',gcds_excel_grid.text);
			gctr_data.post();
		}
	}else{
		alert("생성하실 정보가 없습니다.");
	}
}

/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
function ln_Query(e){

	var str1 = gclx_sfdcode.BindColVal;		//사업소
	var str21 = "A";					//년도
	var str22 = "B";					//년도
    var str23 = "C";					//년도
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var stryy = gcem_saccyy.text;					//년도
	var stryymm="";


	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

	if(gisu=="1"){
		stryymm=stryy+"03";
	}else if(gisu=="2"){
    stryymm=stryy+"06";
	}else if(gisu=="3"){
    stryymm=stryy+"09";
	}else if(gisu=="4"){
		stryymm=stryy+"12";
	}


	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..
	//A Record
	gcds_head_a.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s1?v_str1="+str1
																									        +"&v_str2="+str21
																									        +"&v_str3="+stryymm;			
  //prompt('',gcds_head_a.DataID);																													
	gcds_head_a.Reset();

	//B Record
	gcds_data_b.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s2?v_str1="+str1
																										      +"&v_str2="+str22
																										      +"&v_str3="+stryymm;
  //prompt('',gcds_data_b.DataID);
	gcds_data_b.Reset();

	//C Recode 
  gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s3?v_str1="+str1
																										          +"&v_str2="+str23
																										          +"&v_str3="+stryymm;
	gcds_excel_grid.Reset();
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

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/


/******************************************************************************
	Description : 내려받기
******************************************************************************/
function ln_Download(){
  var strfilenm = "A2218113.834";
	if (gcds_data99.countrow<1) {
		alert("다운로드하실 자료가 없습니다.");
	} else { 
		gcgd_data01.ExportFileEx(strfilenm,true,1,false);
 	}
}

/******************************************************************************
	Description : 내려받기 조회 
******************************************************************************/
function ln_Down_Query(){
	var str1 = gclx_sfdcode.BindColVal;		//사업소
	var str21 = "A";				     
	var str22 = "B";	
	var str23 = "C";	//
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var stryy = gcem_saccyy.text;					//년도
	var stryymm="";


	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

	if(gisu=="1"){
		stryymm=stryy+"03";
	}else if(gisu=="2"){
    stryymm=stryy+"06";
	}else if(gisu=="3"){
    stryymm=stryy+"09";
	}else if(gisu=="4"){
		stryymm=stryy+"12";
	}

  gcds_data99.clearAll();
	var s_temp = "DISKET:STRING";
	gcds_data99.SetDataHeader(s_temp);


	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..

	//HEADER A(1건)
	gcds_down_head.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s1?v_str1="+str1+"&v_str2="+str21+"&v_str3="+stryymm;
	gcds_down_head.Reset();

	//SUM B(1건)
	gcds_down_b.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s2?v_str1="+str1+"&v_str2="+str22+"&v_str3="+stryymm;
	gcds_down_b.Reset();

  //DATA(N개)
	gcds_down_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050013_s3?v_str1="+str1+"&v_str2="+str23+"&v_str3="+stryymm;
	gcds_down_data.Reset();

	ln_Display();
}


/******************************************************************************
	Description : 자료 내려받기 화면 display
******************************************************************************/
function ln_Display(){

  for(i=1;i<=gcds_down_head.countrow;i++){
    ln_Forward_Batch_head(i);
  }

  for(i=1;i<=gcds_down_b.countrow;i++){
    ln_Forward_Batch_B(i);
  }

  for(i=1;i<=gcds_down_data.countrow;i++){
    ln_Forward_Batch_data(i);
  }
}


/******************************************************************************
	Description : head
******************************************************************************/
function ln_Forward_Batch_head(i){
  var DISKET = "";
	DISKET+=strStr(gcds_down_head.namevalue(i,"DATADIV") ,"1");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"ACCYM")   ,"6");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"RPTGB")   ,"1");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VENDID")  ,"10");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VENDNM")  ,"30");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VDDIRECT"),"15");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"VDADDR")  ,"45");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"BSNSCND") ,"17");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"BSNSKND") ,"25");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"PERIOD")  ,"16");   //
	DISKET+=strStr(gcds_down_head.namevalue(i,"WRDT")    ,"8");    //
	DISKET+=strStr(gcds_down_head.namevalue(i,"FILLER")  ,"6");   //
  
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Forward_Batch_B(i){
 
  var DISKET = "";
 
  
	DISKET+=strStr(gcds_down_b.namevalue(i,"DATADIV")  ,"1");     //
	DISKET+=strStr(gcds_down_b.namevalue(i,"ACCYM")    ,"6");     //
    DISKET+=strStr(gcds_down_b.namevalue(i,"RPTGB")    ,"1");     //
	DISKET+=strStr(gcds_down_b.namevalue(i,"VENDID")   ,"10");    //
	DISKET+=intStr(gcds_down_b.namevalue(i,"CNT_SUM")  ,"7");     //
    DISKET+=intDec(gcds_down_b.namevalue(i,"FOAMT_SUM"),"15","2");//
	DISKET+=intStr(gcds_down_b.namevalue(i,"KOAMT_SUM"),"15");    //
	DISKET+=intStr(gcds_down_b.namevalue(i,"EXCNT")    ,"7");     //
	DISKET+=intDec(gcds_down_b.namevalue(i,"EXFOAMT")  ,"15","2");//
	DISKET+=intStr(gcds_down_b.namevalue(i,"EXKOAMT")  ,"15");    //
	DISKET+=intStr(gcds_down_b.namevalue(i,"ETCNT")    ,"7");     //
	DISKET+=intDec(gcds_down_b.namevalue(i,"ETFOAMT")  ,"15","2");//
	DISKET+=intStr(gcds_down_b.namevalue(i,"ETKOAMT")  ,"15");    //
	DISKET+=strStr(gcds_down_b.namevalue(i,"FILLER")   ,"51");    //

  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description :
	             
******************************************************************************/
function ln_Forward_Batch_data(i){
  var DISKET = "";
  
  
     //if(i>=132){
      //alert("i:::"+i+"::EXCHANGE::",gcds_down_data.namevalue(i,"EXCHANGE"));
      //intDec2(gcds_down_data.namevalue(i,"EXCHANGE"),"9","4");
    // }
    
	DISKET+=strStr(gcds_down_data.namevalue(i,"DATADIV") ,"1");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"ACCYM")   ,"6");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"RPTGB")   ,"1");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"VENDID")  ,"10");    //
	DISKET+=intStr(gcds_down_data.namevalue(i,"SEQNO")   ,"7");     //
	DISKET+=intStr(gcds_down_data.namevalue(i,"EXPTNO")  ,"15");    //
	DISKET+=strStr(gcds_down_data.namevalue(i,"SHIPDT")  ,"8");     //
	DISKET+=strStr(gcds_down_data.namevalue(i,"CURRCD")  ,"3");     //
	DISKET+=intDec2(gcds_down_data.namevalue(i,"EXCHANGE"),"9","4"); //
	DISKET+=intDec(gcds_down_data.namevalue(i,"FOAMT")   ,"15","2");//
	DISKET+=intStr(gcds_down_data.namevalue(i,"KOAMT")   ,"15");    //
	DISKET+=strStr(gcds_down_data.namevalue(i,"FILLER")  ,"90");    //
	 
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : 문자타입 공백 처리함.
******************************************************************************/
function strStr(a, b){
  var returnVal = "";
  if(a==null) a = "";
  var alength = calculateBytes(a);
  var tt = calculateBytesStr(a,b);

  if(alength<=b){
    returnVal+=a;
    for(var i=0; i<b-alength; i++){
      returnVal+=" ";
    }
  }else{
    returnVal = tt;
  }
  return returnVal;
}

/******************************************************************************
	Description : 숫자타입 공백 0으로 처리함.
******************************************************************************/
function intStr(a, b){
 
	var tmpa = new String(a);

  var returnVal="";
  if(a==null) a="";
  //var alength=a.length;
	
	var alength=tmpa.length;
  
  //alert("tmpa"+tmpa);
  
  //alert("alength::"+tmpa.length);

  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;

  return returnVal;
}

/******************************************************************************
	Description : 소수점 처리함.

******************************************************************************/
function intDec(a, b, c){
  var splitString="";
 	var tmpa = new String(a);
	var tmp="";
	var dec="";

  var returnVal="";
  if(a==null) a="";
  //var alength=a.length;
	
	var alength=tmpa.length;
  
  // alert("tmpa"+tmpa);
 //  alert("alength::"+tmpa.length);
  
	splitString = tmpa.split('.');
	/**
    alert("splitString[0].length::"+splitString[0].length);
	//alert("splitString[1]::"+splitString[1]);
	
    if(splitString[0].length ==alength){
  	  a +="00";
    }else{
      if(splitString[1].length ==1){
        a +="0"; 
      }
    }
    **/
  	
  	
   // tmpa = new String(a);
   // alength=tmpa.length;
    
    //alert("222tmpa"+tmpa);
    
    //alert("222alength"+alength);
	
	

  if(splitString[1]==undefined){ //alert("소수없음.");
		
		if(alength<b){
			for(var i=0; i<b-alength-c; i++){
				returnVal+="0";
			}
		}
		returnVal+=a;
		returnVal+="00"
	}else{  // alert("소수있음.");
  
		if(alength<=b){
			for(var i=0; i<b-alength+1; i++){
				returnVal+="0";
			}
		}
		returnVal+=splitString[0];
		returnVal+=splitString[1];
	}


  /**
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;
	**/

  return returnVal;
}

/******************************************************************************
	Description : 소수점 처리함.

******************************************************************************/
function intDec2(a, b, c){
    var splitString="";
 	
	var tmp="";
	var dec="";

  var returnVal="";
  if(a==null) a="";
  //var alength=a.length;
  
  //alert("a:::"+a);
	
  var tmpa = new String(a);
  var alength=tmpa.length;
  
  splitString = tmpa.split('.');
  //alert("splitString[0]::"+splitString[0]);
  //alert("splitString[1]::"+splitString[1]);
	
  
  //소수점 뒷자리를 모두 못가져올 경우 0을 붙임.	
  
  
  if(splitString[1]==undefined){
     splitString[1]="0";
  } 
  
  
  if(splitString[1].length ==3){
  	 a +="0";
  }else if(splitString[1].length ==2){
     a +="00";
  }else if(splitString[1].length ==1){
     a +="000";
  }else if(splitString[1].length ==0){
     a +="0000"; 
  }

  
  tmpa = new String(a);
  alength=tmpa.length;
  
  splitString = tmpa.split('.');
  
  //alert("tmpa22::"+tmpa);
  //alert("alength22::"+tmpa.length);
  
  
 
 //alert("2splitString[0]::"+splitString[0]);
 //alert("2splitString[1]::"+splitString[1]);
  
  //alert("b::"+b+"::alength::"+alength);

  if(splitString[1]==undefined){ //alert("소수없음.");
		if(alength<b){
			for(var i=0; i<b-alength-c; i++){
				returnVal+="0";
			}
		}
		returnVal+=a;
		returnVal+="00"
	}else{                                 // alert("소수있음.");  
   		if(alength<=b){
			for(var i=0; i<b-alength+1; i++){
				returnVal+="0";
			}
		}
		returnVal+=splitString[0];
		returnVal+=splitString[1];
	}


  /**
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;
	**/

  return returnVal;
}


/******************************************************************************
	Description : 음수(-) 처리 방법
******************************************************************************/
function minorintStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var temp = "";  
  var rst = "";
  if(a<0){
    a = strReplace(a, "-", "0");

    for(var k=0; k<a.length; k++){
      temp = a.charAt(k);
      if(k+1==a.length){
        temp=strReplace(temp, "0","}");
        temp=strReplace(temp, "1","J");
        temp=strReplace(temp, "2","K");
        temp=strReplace(temp, "3","L");
        temp=strReplace(temp, "4","M");
        temp=strReplace(temp, "5","N");
        temp=strReplace(temp, "6","O");
        temp=strReplace(temp, "7","P");
        temp=strReplace(temp, "8","Q");
        temp=strReplace(temp, "9","R");
      }
      rst += temp;
    }
  }else{
    rst = a;
  }

  var alength=rst.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=rst;
  return returnVal;
}

/******************************************************************************
	Description : 바이트 처리 
******************************************************************************/
function calculateBytes(szValue){
  var tcount = 0;
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
    }
    else{
      tcount += 1;
    }
  }
  return tcount;
}

/******************************************************************************
	Description : 바이트 
******************************************************************************/
function calculateBytesStr(szValue,b){
  var tcount = 0;
  var tstr = "";
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
      tstr += onechar;
    }
    else{
      tcount += 1;
      tstr += onechar;
    }
    if(tcount==b) break;
  }
  return tstr;
}

/******************************************************************************
	Description : 치환하기. 
******************************************************************************/
function strReplace(str, src, dest) {
  var reg = new RegExp(src, "gi");
  return str.replace(reg, dest);
}

/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("신용카드수취명세서","",2);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--지점 -->
<object  id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_excel_grid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>



<object  id=gcds_head_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data_c classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!--입력관련  -->
<object  id=gcds_ihead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--내려받기 -->
<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_down_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data_c" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data_c" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
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
//		gclx_sfdcode.index=2;
	}else{
//		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
		if (fn_trim(gcip_file.value)!="") {
				//alert("gcip_file::::"+gcip_file.value);
				file_path.value = gcip_file.value;
		}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	ln_Upload_Grid();
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050013_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:869px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="869px"> 
					<td width="102px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>엑셀파일</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
							<input type="text" name="file_path" value="" style="width:556px;position:relative;top:-2px" >&nbsp;
							<comment id="__NSID__">
							<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="width:70;height:20;position:relative;top:2px;fontSize=8"  >
								<param name = "Text"		value="찾아보기">
							</OBJECT>&nbsp;
							<img src="../../Common/img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:2px"  onClick="ln_Excel_Apply()">
							<img src="../../Common/img/btn/com_b_create.gif"    style="cursor:hand;position:relative;top:2px"  onClick="ln_Create()">
							</comment><script>__ws__(__NSID__);</script>  
							</nobr>
					</td> 
				</tr>
			</table>
		</td>
	</tr>
  <tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>사업소</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
								<param name=CBData					value="02^서울,01^고성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>년&nbsp;&nbsp;&nbsp;&nbsp;도</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;분&nbsp;기&nbsp;수&nbsp;</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1기예정,2^1기확정,3^2기예정,4^2기확정">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr><!--  ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상호(법인명)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit value="true">
									<param name=Language		value=1>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업자등록번호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=BackColor     value="#CCCCCC">
									<param name=Format			  value="000-00-00000">
									<param name=PromptChar	  value="_">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:230px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>사업장소재지</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vdaddr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:380px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
                  <param name=GeneralEdit   value="true">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- 매입2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>구&nbsp;&nbsp;&nbsp;&nbsp;분</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>거래건수</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>외&nbsp;&nbsp;&nbsp;&nbsp;화</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>원&nbsp;&nbsp;&nbsp;&nbsp;화</nobr></td>
							<td class="tab13" style="width:173px;" bgcolor="#eeeeee"><nobr>비&nbsp;&nbsp;&nbsp;&nbsp;고</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>합&nbsp;계&nbsp;분</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_cnt_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_foamt_sum  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_koamt_sum  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							 <td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
             <tr>
              <td class="tab11" style="width:173px;"><nobr>수출하는재화</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_excnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_exfoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_exkoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>기타영세율</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_etcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_etfoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_etkoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:220px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView  value="Left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='일련번호'	      ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	   	align=center	SumText=@count	SumBgColor='#C3D0DB' </C> 
								<C> Name='수출신고번호'  	ID=EXPTNO 	HeadAlign=Center HeadBgColor=#B9D4DC Width=170  	align=center	SumText='계'	  SumBgColor='#C3D0DB' sort=true mask='XXX-XX-XX-XXXXXXXX'  </C>
								<C> Name='선적일'     		ID=SHIPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	  align=center	SumText=''	    SumBgColor='#C3D0DB' sort=true mask='XXXX-XX-XX' </C>
								<C> Name='통화구분'	      ID=CURRCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=105  	align=center	SumBgColor='#C3D0DB' sort=true </C>
							  <G> Name='통관금액'       HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='외화'	    		  ID=FOAMT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=130		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='원화'	    	    ID=KOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='환율'   	      ID=EXCHANGE	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true </C>
							  </G>
								<C> Name='법인'   	      ID=FDCODE	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='자료구분'	      ID=DATADIV  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='귀속년월'   	  ID=ACCYM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='신고구분'   	  ID=RPTGB	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='사업자등록번호' ID=VENDID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
								<C> Name='일련번호'   	  ID=SEQNO	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=left  show=false</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	<tr>
    <td>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:173px;position:relative;left:5px;top:3px"><nobr><FONT SIZE="2" COLOR="blue"><B>[내려받기]</B></FONT></nobr></td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Download()">
						<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Down_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td colspan =2>
						<comment id="__NSID__">
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:867px;height:160px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"			VALUE="gcds_data99">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=843	align=left</C>
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=VENDNM			Ctrl=gcem_vendnm				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid				Param=text</C>
		<C>Col=VDDIRECT	  Ctrl=gcem_vddirect			Param=text</C>
		<C>Col=VDADDR	    Ctrl=gcem_vdaddr  			Param=text</C>
	'>
</object>


<object  id=gcbn_data_b classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data_b>
	<param name=BindInfo		value='  
		<C>Col=CNT_SUM  			Ctrl=gcem_cnt_sum  				Param=text</C>
		<C>Col=FOAMT_SUM			Ctrl=gcem_foamt_sum				Param=text</C>
		<C>Col=KOAMT_SUM			Ctrl=gcem_koamt_sum				Param=text</C>
		<C>Col=EXCNT    			Ctrl=gcem_excnt    				Param=text</C>
		<C>Col=EXFOAMT  			Ctrl=gcem_exfoamt  				Param=text</C>
		<C>Col=EXKOAMT  			Ctrl=gcem_exkoamt  				Param=text</C>
		<C>Col=ETCNT    			Ctrl=gcem_etcnt    				Param=text</C>
		<C>Col=ETFOAMT  			Ctrl=gcem_etfoamt  				Param=text</C>
		<C>Col=ETKOAMT  			Ctrl=gcem_etkoamt  				Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 