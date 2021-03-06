<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  장부관리 - 계정별 잔액장
+ 프로그램 ID	:  A030015.html
+ 기 능 정 의	:  
+ 작   성  자 :  YS.JEONG
+ 수 정 일 자 :  2006.10.18
-----------------------------------------------------------------------------
+ 수 정 내 용  :	개선사항 수정 및 출력물 작성  
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.10
-----------------------------------------------------------------------------
+ 수 정 내 용  :	저장품( 1120700 )의 경우 세목을 반제단위가 아닌 원가로 조회 가능하게 함.
+ 수   정  자  :  정영식
+ 수 정 일 자  :  2010.12.08
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>계정별잔액장</title>

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
var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //년월
var gs_date3 = gcurdate.substring(0,4); //년
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    ln_DispChk(0);	
	ln_Before();

	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_fdcode_2.bindcolval = gs_fdcode;
	
}

/******************************************************************************************
	Description : 결재전 조회
******************************************************************************************/
function ln_Query(){

 var strGubun = '0';

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s3?v_str1="+gclx_fdcode.bindcolval //지점       
						+"&v_str2="+txt_atcode_fr.value		//계정fr       
						+"&v_str3="+txt_atcode_to.value   //계정to   
						+"&v_str4="+gcem_datefr.text			//처리기간FR 
						+"&v_str5="+gcem_dateto.text			//처리기간TO 
						+"&v_str6="+txt_vendcd_fr.value   //거래처fr
						+"&v_str7="+txt_vendcd_to.value   //거래처to 
						+"&v_str8="+strGubun ;  //정산구분  
						
//	  prompt("gcds_data01",gcds_data01.DataID);
	  gcds_data01.Reset();
	
}

/******************************************************************************************
	Description : 결재후 조회
	              2010.12.07 JYS 저장품(1120700) 예외처리.(서울지점만 처리함.)

				  장기선급비용 - 반제 단위가 없어졌음
******************************************************************************************/
function ln_Query2(){

	 var strGubun = '0';
	
	 if(gclx_fdcode_2.bindcolval=="02"&&txt_atcode_fr_2.value=="1120700"&&txt_atcode_to_2.value=="1120700"){
	      gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s4?v_str1="+gclx_fdcode_2.bindcolval //지점  
																				+"&v_str2="+txt_atcode_fr_2.value		//계정fr       
																				+"&v_str3="+txt_atcode_to_2.value   //계정to   
																				+"&v_str4="+gcem_datefr_2.text			//처리기간FR 
																				+"&v_str5="+gcem_dateto_2.text			//처리기간TO 
																				+"&v_str6="+txt_vendcd_fr_2.value   //거래처fr
																				+"&v_str7="+txt_vendcd_to_2.value   //거래처to 
																				+"&v_str8="+strGubun    //정산구분  
																				+"&v_str9="+gclx_fsrefcd_2.bindcolval //세목구분  
																				+"&v_str10="+gcem_vend_fr_2.text    //세목값FR  
																				+"&v_str11="+gcem_vend_to_2.text;   //세목값TO  
																																															
		  //prompt("gcds_data02_4",gcds_data02.DataID);
		  gcds_data02.Reset();	
	 }else{
		  gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s1?v_str1="+gclx_fdcode_2.bindcolval //지점    
																				+"&v_str2="+txt_atcode_fr_2.value		//계정fr       
																				+"&v_str3="+txt_atcode_to_2.value   //계정to   
																				+"&v_str4="+gcem_datefr_2.text			//처리기간FR 
																				+"&v_str5="+gcem_dateto_2.text			//처리기간TO 
																				+"&v_str6="+txt_vendcd_fr_2.value   //거래처fr
																				+"&v_str7="+txt_vendcd_to_2.value   //거래처to 
																				+"&v_str8="+strGubun    //정산구분  
																				+"&v_str9="+gclx_fsrefcd_2.bindcolval //세목구분  
																				+"&v_str10="+gcem_vend_fr_2.text    //세목값FR  
																				+"&v_str11="+gcem_vend_to_2.text;   //세목값TO  
																																									
		  //prompt("gcds_data02_1",gcds_data02.DataID);
		  gcds_data02.Reset();	
	 }
			

}


/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  
	//지점
	gcem_datefr.text = "19900101"; //년월
	gcem_dateto.text = gs_date;

	gcem_datefr_2.text = "19900101"; //년월
	gcem_dateto_2.text = gs_date;
	
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	gcds_fdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode2.Reset();

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
	Description : 출력 결재전
******************************************************************************/
function ln_Print(){
 var strGubun = '0';
  gcds_print2.clearAll();
	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s3?v_str1="+gclx_fdcode.bindcolval //지점
						+"&v_str2="+txt_atcode_fr.value		//계정fr       
						+"&v_str3="+txt_atcode_to.value   //계정to   
						+"&v_str4="+gcem_datefr.text			//처리기간FR 
						+"&v_str5="+gcem_dateto.text			//처리기간TO 
						+"&v_str6="+txt_vendcd_fr.value   //거래처fr
						+"&v_str7="+txt_vendcd_to.value   //거래처to 
						+"&v_str8="+strGubun ;  //정산구분  
	//prompt('',gcds_print1.DataID);
	gcds_print1.Reset(); 

}

/******************************************************************************
	Description : 출력 결재후
******************************************************************************/
function ln_Print2(){

 var strGubun = '0';

  gcds_print4.clearAll();


  if(gclx_fdcode_2.bindcolval=="02"&&txt_atcode_fr_2.value=="1120700"&&txt_atcode_to_2.value=="1120700"){
   gcds_print3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s4?v_str1="+gclx_fdcode_2.bindcolval //지점  
																										+"&v_str2="+txt_atcode_fr_2.value		//계정fr       
																										+"&v_str3="+txt_atcode_to_2.value   //계정to   
																										+"&v_str4="+gcem_datefr_2.text			//처리기간FR 
																										+"&v_str5="+gcem_dateto_2.text			//처리기간TO 
																										+"&v_str6="+txt_vendcd_fr_2.value   //거래처fr
																										+"&v_str7="+txt_vendcd_to_2.value   //거래처to 
																										+"&v_str8="+strGubun    //정산구분  
																										+"&v_str9="+gclx_fsrefcd_2.bindcolval //세목구분  
																										+"&v_str10="+gcem_vend_fr_2.text    //세목값FR  
																										+"&v_str11="+gcem_vend_to_2.text;   //세목값TO  
																																														
																										//prompt("gcds_data02_4",gcds_data02.DataID);
	   gcds_print3.Reset();	
   }else{

	gcds_print3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030015_s1?v_str1="+gclx_fdcode_2.bindcolval //지점
					+"&v_str2="+txt_atcode_fr_2.value		//계정fr       
					+"&v_str3="+txt_atcode_to_2.value   //계정to   
					+"&v_str4="+gcem_datefr_2.text			//처리기간FR 
					+"&v_str5="+gcem_dateto_2.text			//처리기간TO 
					+"&v_str6="+txt_vendcd_fr_2.value   //거래처fr
					+"&v_str7="+txt_vendcd_to_2.value   //거래처to 
					+"&v_str8="+strGubun   //정산구분  
					+"&v_str9="+gclx_fsrefcd_2.bindcolval //세목구분  
					+"&v_str10="+gcem_vend_fr_2.text    //세목값FR  
					+"&v_str11="+gcem_vend_to_2.text;   //세목값TO  
	//prompt('',gcds_print1.DataID);
	gcds_print3.Reset(); 
   }
}

/******************************************************************************
	Description : 출력 - Header Set
******************************************************************************/
function ln_SetDataHeader(p){

  if(p=="01"){
		if (gcds_print2.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,ATKORNAM:STRING,COCODE:STRING,DIVCD:STRING,";
			s_temp+="DEPTCD:STRING,FSREFCD:STRING,FSREFVAL:STRING,ATKORNAM:STRING,CDNAM:STRING,";
			s_temp+="SSNBR1:STRING,VENDNM:STRING,BJANAMT:DECIMAL,FSREFNM:STRING,ACTDAT:STRING,";
			s_temp+="FDCODENM:STRING,REMARK:STRING,CURDT:STRING,CURDT2:STRING,FSREFVAL:STRING";
			gcds_print2.SetDataHeader(s_temp);
		}
	}else if(p=="02"){
		if (gcds_print4.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,ATKORNAM:STRING,COCODE:STRING,DIVCD:STRING,";
			s_temp+="DEPTCD:STRING,FSREFCD:STRING,FSREFVAL:STRING,ATKORNAM:STRING,CDNAM:STRING,";
			s_temp+="SSNBR1:STRING,VENDNM:STRING,BJANAMT:DECIMAL,FSREFNM:STRING,ACTDAT:STRING,";
			s_temp+="FDCODENM:STRING,REMARK:STRING,CURDT:STRING,CURDT2:STRING,FSREFVAL:STRING";
			gcds_print4.SetDataHeader(s_temp);
		}
	}
}


/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	//gcgd_data01.RunExcel("계정별잔액장 결재전");
   gcgd_data01.GridToExcel("계정별잔액장 결재전","",2);
}

function ln_Excel2(){
	//gcgd_data02.RunExcel("계정별잔액장 결재후");
  gcgd_data02.GridToExcel("계정별잔액장 결재후","",2);
}



/***********************************************************************************************
	Description : 레포트 컬럼 삽입하기
	parameter   : 결재전
**********************************************************************************************/
function ln_Sum(){
  var flag1 = "";//계정코드
  var flag2 = "";//세목코드
  var sum1 = 0;
  var sum2 = 0;
  var sum3 = 0;
  var j=1;

	for(i=1;i<=gcds_print1.countrow;i++){
    if(i==1){
      gcds_print2.addrow();
      gcds_print2.namevalue(j,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
      gcds_print2.namevalue(j,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
      gcds_print2.namevalue(j,"COCODE")=gcds_print1.namevalue(i,"COCODE");
      gcds_print2.namevalue(j,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
      gcds_print2.namevalue(j,"REMARK")=gcds_print1.namevalue(i,"REMARK");
      gcds_print2.namevalue(j,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
      gcds_print2.namevalue(j,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
      gcds_print2.namevalue(j,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
      gcds_print2.namevalue(j,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
      gcds_print2.namevalue(j,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
      gcds_print2.namevalue(j,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
      gcds_print2.namevalue(j,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
      gcds_print2.namevalue(j,"BJANAMT")=gcds_print1.namevalue(i,"BJANAMT");
	  gcds_print2.namevalue(j,"ACTDAT")=gcds_print1.namevalue(i,"ACTDAT");
      gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
      gcds_print2.namevalue(1,"CURDT2")		= gs_date;
      gcds_print2.namevalue(j,"FSREFVAL") = gcds_print1.namevalue(i,"FSREFVAL");
      flag1=gcds_print2.namevalue(j,"ATCODE");
      flag2=gcds_print2.namevalue(j,"FSREFVAL");
      sum1 += gcds_print1.namevalue(i,"BJANAMT");
      sum2 += gcds_print1.namevalue(i,"BJANAMT");
      sum3 += gcds_print1.namevalue(i,"BJANAMT");
      j++;
    }else if(flag1==gcds_print1.namevalue(i,"ATCODE") && flag2==gcds_print1.namevalue(i,"FSREFVAL")){
      gcds_print2.addrow();
      gcds_print2.namevalue(j,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
      gcds_print2.namevalue(j,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
      gcds_print2.namevalue(j,"COCODE")=gcds_print1.namevalue(i,"COCODE");
      gcds_print2.namevalue(j,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
      gcds_print2.namevalue(j,"REMARK")=gcds_print1.namevalue(i,"REMARK");
      gcds_print2.namevalue(j,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
      gcds_print2.namevalue(j,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
      gcds_print2.namevalue(j,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
      gcds_print2.namevalue(j,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
      gcds_print2.namevalue(j,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
      gcds_print2.namevalue(j,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
      gcds_print2.namevalue(j,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
      gcds_print2.namevalue(j,"BJANAMT")=gcds_print1.namevalue(i,"BJANAMT");
	  gcds_print2.namevalue(j,"ACTDAT")=gcds_print1.namevalue(i,"ACTDAT");
      gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
      gcds_print2.namevalue(1,"CURDT2")		= gs_date;
      gcds_print2.namevalue(j,"FSREFVAL") = gcds_print1.namevalue(i,"FSREFVAL");
      flag1=gcds_print2.namevalue(j,"ATCODE");
      flag2=gcds_print2.namevalue(j,"FSREFVAL");
      sum1 += gcds_print1.namevalue(i,"BJANAMT");
      sum2 += gcds_print1.namevalue(i,"BJANAMT");
      sum3 += gcds_print1.namevalue(i,"BJANAMT");
      j++;
    }else{
      if(flag1==gcds_print1.namevalue(i,"ATCODE") && flag2!=gcds_print1.namevalue(i,"FSREFVAL")){
        gcds_print2.addrow();
        gcds_print2.namevalue(j,"FDCODE")="";
        gcds_print2.namevalue(j,"ATCODE")="";
        gcds_print2.namevalue(j,"COCODE")="";
        gcds_print2.namevalue(j,"DIVCD")="";
        gcds_print2.namevalue(j,"REMARK")="";
        gcds_print2.namevalue(j,"FSREFCD")="";
        gcds_print2.namevalue(j,"ATKORNAM")="";
        gcds_print2.namevalue(j,"FSREFNM")="세목계";
        gcds_print2.namevalue(j,"CDNAM")="";
        gcds_print2.namevalue(j,"BEVAL")="";
        gcds_print2.namevalue(j,"SSNBR1")="";
	    gcds_print2.namevalue(j,"ACTDAT")="";
        gcds_print2.namevalue(j,"VENDNM")="";
        gcds_print2.namevalue(j,"BJANAMT")=sum1;
        gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
        gcds_print2.namevalue(1,"CURDT2")		= gs_date;
        gcds_print2.namevalue(j,"FSREFVAL") = "";
        j++;
        flag1=gcds_print1.namevalue(i,"ATCODE");
        flag2=gcds_print1.namevalue(i,"FSREFVAL");
        sum1 = 0;

        gcds_print2.addrow();
        gcds_print2.namevalue(j,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
        gcds_print2.namevalue(j,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
        gcds_print2.namevalue(j,"COCODE")=gcds_print1.namevalue(i,"COCODE");
        gcds_print2.namevalue(j,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
        gcds_print2.namevalue(j,"REMARK")=gcds_print1.namevalue(i,"REMARK");
        gcds_print2.namevalue(j,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
        gcds_print2.namevalue(j,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
        gcds_print2.namevalue(j,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
        gcds_print2.namevalue(j,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
        gcds_print2.namevalue(j,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
        gcds_print2.namevalue(j,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
        gcds_print2.namevalue(j,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
        gcds_print2.namevalue(j,"BJANAMT")=gcds_print1.namevalue(i,"BJANAMT");
	    gcds_print2.namevalue(j,"ACTDAT")=gcds_print1.namevalue(i,"ACTDAT");
		
        gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
        gcds_print2.namevalue(1,"CURDT2")		= gs_date;
        gcds_print2.namevalue(j,"FSREFVAL") = gcds_print1.namevalue(i,"FSREFVAL");
        flag1=gcds_print2.namevalue(j,"ATCODE");
        flag2=gcds_print2.namevalue(j,"FSREFVAL");
        sum1 += gcds_print1.namevalue(i,"BJANAMT");
        sum2 += gcds_print1.namevalue(i,"BJANAMT");
        sum3 += gcds_print1.namevalue(i,"BJANAMT");
        j++;
      }
      else if(i!=1 && flag1!=gcds_print1.namevalue(i,"ATCODE")){
        gcds_print2.addrow();
        gcds_print2.namevalue(j,"FDCODE")="";
        gcds_print2.namevalue(j,"ATCODE")="";
        gcds_print2.namevalue(j,"COCODE")="";
        gcds_print2.namevalue(j,"DIVCD")="";
        gcds_print2.namevalue(j,"REMARK")="";
        gcds_print2.namevalue(j,"FSREFCD")="";
        gcds_print2.namevalue(j,"ATKORNAM")="";
        gcds_print2.namevalue(j,"FSREFNM")="세목계";
        gcds_print2.namevalue(j,"CDNAM")="";
        gcds_print2.namevalue(j,"BEVAL")="";
        gcds_print2.namevalue(j,"SSNBR1")="";
	    gcds_print2.namevalue(j,"ACTDAT")="";
        gcds_print2.namevalue(j,"VENDNM")="";
        gcds_print2.namevalue(j,"BJANAMT")=sum1;
        gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
        gcds_print2.namevalue(1,"CURDT2")		= gs_date;
        gcds_print2.namevalue(j,"FSREFVAL") = "";
        j++;
        sum1 = 0;

        gcds_print2.addrow();
        gcds_print2.namevalue(j,"FDCODE")="";
        gcds_print2.namevalue(j,"ATCODE")="";
        gcds_print2.namevalue(j,"COCODE")="";
        gcds_print2.namevalue(j,"DIVCD")="";
        gcds_print2.namevalue(j,"REMARK")="";
        gcds_print2.namevalue(j,"FSREFCD")="";
        gcds_print2.namevalue(j,"ATKORNAM")="";
        gcds_print2.namevalue(j,"FSREFNM")="계정계";
        gcds_print2.namevalue(j,"CDNAM")="";
        gcds_print2.namevalue(j,"BEVAL")="";
        gcds_print2.namevalue(j,"SSNBR1")="";
		gcds_print2.namevalue(j,"ACTDAT")="";

        gcds_print2.namevalue(j,"VENDNM")="";
        gcds_print2.namevalue(j,"BJANAMT")=sum2;
        gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
        gcds_print2.namevalue(1,"CURDT2")		= gs_date;
        gcds_print2.namevalue(j,"FSREFVAL") = "";
        flag1=gcds_print1.namevalue(i,"ATCODE");
        flag2=gcds_print1.namevalue(i,"FSREFVAL");
        j++;
        sum2 = 0;


        gcds_print2.addrow();
        gcds_print2.namevalue(j,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
        gcds_print2.namevalue(j,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
        gcds_print2.namevalue(j,"COCODE")=gcds_print1.namevalue(i,"COCODE");
        gcds_print2.namevalue(j,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
        gcds_print2.namevalue(j,"REMARK")=gcds_print1.namevalue(i,"REMARK");
        gcds_print2.namevalue(j,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
        gcds_print2.namevalue(j,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
        gcds_print2.namevalue(j,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
        gcds_print2.namevalue(j,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
        gcds_print2.namevalue(j,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
        gcds_print2.namevalue(j,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
        gcds_print2.namevalue(j,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
        gcds_print2.namevalue(j,"BJANAMT")=gcds_print1.namevalue(i,"BJANAMT");
        gcds_print2.namevalue(j,"ACTDAT")=gcds_print1.namevalue(i,"ACTDAT");
	
        gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
        gcds_print2.namevalue(1,"CURDT2")		= gs_date;
        gcds_print2.namevalue(j,"FSREFVAL") = gcds_print1.namevalue(i,"FSREFVAL");
        flag1=gcds_print2.namevalue(j,"ATCODE");
        flag2=gcds_print2.namevalue(j,"FSREFVAL");
        sum1 += gcds_print1.namevalue(i,"BJANAMT");
        sum2 += gcds_print1.namevalue(i,"BJANAMT");
        sum3 += gcds_print1.namevalue(i,"BJANAMT");
        j++;

      }
      else{
        gcds_print2.addrow();
        gcds_print2.namevalue(j,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
        gcds_print2.namevalue(j,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
        gcds_print2.namevalue(j,"COCODE")=gcds_print1.namevalue(i,"COCODE");
        gcds_print2.namevalue(j,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
        gcds_print2.namevalue(j,"REMARK")=gcds_print1.namevalue(i,"REMARK");
        gcds_print2.namevalue(j,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
        gcds_print2.namevalue(j,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
        gcds_print2.namevalue(j,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
        gcds_print2.namevalue(j,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
        gcds_print2.namevalue(j,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
        gcds_print2.namevalue(j,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
        gcds_print2.namevalue(j,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
        gcds_print2.namevalue(j,"BJANAMT")=gcds_print1.namevalue(i,"BJANAMT");
	    gcds_print2.namevalue(j,"ACTDAT")=gcds_print1.namevalue(i,"ACTDAT");

        gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
        gcds_print2.namevalue(1,"CURDT2")		= gs_date;
        gcds_print2.namevalue(j,"FSREFVAL") = gcds_print1.namevalue(i,"FSREFVAL");
        flag1=gcds_print2.namevalue(j,"ATCODE");
        flag2=gcds_print2.namevalue(j,"FSREFVAL");
        j++;
        sum1 += gcds_print1.namevalue(i,"BJANAMT");
        sum2 += gcds_print1.namevalue(i,"BJANAMT");
        sum3 += gcds_print1.namevalue(i,"BJANAMT");
      }
    }
    if(i==gcds_print1.countrow){
      gcds_print2.addrow();
      gcds_print2.namevalue(j,"FDCODE")="";
      gcds_print2.namevalue(j,"ATCODE")="";
      gcds_print2.namevalue(j,"COCODE")="";
      gcds_print2.namevalue(j,"DIVCD")="";
      gcds_print2.namevalue(j,"REMARK")="";
      gcds_print2.namevalue(j,"FSREFCD")="";
      gcds_print2.namevalue(j,"ATKORNAM")="";
      gcds_print2.namevalue(j,"FSREFNM")="세목계";
      gcds_print2.namevalue(j,"CDNAM")="";
      gcds_print2.namevalue(j,"BEVAL")="";
      gcds_print2.namevalue(j,"SSNBR1")="";
      gcds_print2.namevalue(j,"VENDNM")="";
      gcds_print2.namevalue(j,"BJANAMT")=sum1;
      gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
      gcds_print2.namevalue(1,"CURDT2")		= gs_date;
      gcds_print2.namevalue(j,"FSREFVAL") = "";
      j++;
      sum1 = 0;

      gcds_print2.addrow();
      gcds_print2.namevalue(j,"FDCODE")="";
      gcds_print2.namevalue(j,"ATCODE")="";
      gcds_print2.namevalue(j,"COCODE")="";
      gcds_print2.namevalue(j,"DIVCD")="";
      gcds_print2.namevalue(j,"REMARK")="";
      gcds_print2.namevalue(j,"FSREFCD")="";
      gcds_print2.namevalue(j,"ATKORNAM")="";
      gcds_print2.namevalue(j,"FSREFNM")="계정계";
      gcds_print2.namevalue(j,"CDNAM")="";
      gcds_print2.namevalue(j,"BEVAL")="";
      gcds_print2.namevalue(j,"SSNBR1")="";
      gcds_print2.namevalue(j,"VENDNM")="";
	  gcds_print2.namevalue(j,"ACTDAT")="";

      gcds_print2.namevalue(j,"BJANAMT")=sum2;
      gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
      gcds_print2.namevalue(1,"CURDT2")		= gs_date;
      gcds_print2.namevalue(j,"FSREFVAL") = "";
      flag1=gcds_print1.namevalue(i,"ATCODE");
      flag2=gcds_print1.namevalue(i,"FSREFVAL");
      j++;
      sum2 = 0;
    }
	}
  gcds_print2.addrow();
  gcds_print2.namevalue(j,"FDCODE")="";
  gcds_print2.namevalue(j,"ATCODE")="";
  gcds_print2.namevalue(j,"COCODE")="";
  gcds_print2.namevalue(j,"DIVCD")="";
  gcds_print2.namevalue(j,"REMARK")="";
  gcds_print2.namevalue(j,"FSREFCD")="";
  gcds_print2.namevalue(j,"ATKORNAM")="";
  gcds_print2.namevalue(j,"FSREFNM")="합  계";
  gcds_print2.namevalue(j,"CDNAM")="";
  gcds_print2.namevalue(j,"BEVAL")="";
  gcds_print2.namevalue(j,"SSNBR1")="";
  gcds_print2.namevalue(j,"VENDNM")="";
  gcds_print2.namevalue(j,"ACTDAT")="";

  gcds_print2.namevalue(j,"BJANAMT")=sum3;
  gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
  gcds_print2.namevalue(1,"CURDT2")		= gs_date;
  gcds_print2.namevalue(j,"FSREFVAL") = "";
}

/***********************************************************************************************
	Description : 레포트 컬럼 삽입하기
	parameter   : 결재후
**********************************************************************************************/
function ln_Sum2(){
  var flag1 = "";//계정코드
  var flag2 = "";//세목코드
  var sum1 = 0;
  var sum2 = 0;
  var sum3 = 0;
  var j=1;
	for(i=1;i<=gcds_print3.countrow;i++){
    if(i==1){
      gcds_print4.addrow();
      gcds_print4.namevalue(j,"FDCODE")=gcds_print3.namevalue(i,"FDCODE");
      gcds_print4.namevalue(j,"ATCODE")=gcds_print3.namevalue(i,"ATCODE");
      gcds_print4.namevalue(j,"COCODE")=gcds_print3.namevalue(i,"COCODE");
      gcds_print4.namevalue(j,"DIVCD")=gcds_print3.namevalue(i,"DIVCD");
      gcds_print4.namevalue(j,"REMARK")=gcds_print3.namevalue(i,"REMARK");
      gcds_print4.namevalue(j,"FSREFCD")=gcds_print3.namevalue(i,"FSREFCD");
      gcds_print4.namevalue(j,"ATKORNAM")=gcds_print3.namevalue(i,"ATKORNAM");
      gcds_print4.namevalue(j,"FSREFNM")=gcds_print3.namevalue(i,"FSREFNM");
      gcds_print4.namevalue(j,"CDNAM")=gcds_print3.namevalue(i,"CDNAM");
      gcds_print4.namevalue(j,"BEVAL")=gcds_print3.namevalue(i,"BEVAL");
      gcds_print4.namevalue(j,"SSNBR1")=gcds_print3.namevalue(i,"SSNBR1");
      gcds_print4.namevalue(j,"VENDNM")=gcds_print3.namevalue(i,"VENDNM");
      gcds_print4.namevalue(j,"BJANAMT")=gcds_print3.namevalue(i,"BJANAMT");
	    gcds_print4.namevalue(j,"ACTDAT")=gcds_print3.namevalue(i,"ACTDAT");
	  
      gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
      gcds_print4.namevalue(1,"CURDT2")		= gs_date;
      gcds_print4.namevalue(j,"FSREFVAL") = gcds_print3.namevalue(i,"FSREFVAL");
      flag1=gcds_print4.namevalue(j,"ATCODE");
      flag2=gcds_print4.namevalue(j,"FSREFVAL");
      sum1 += gcds_print3.namevalue(i,"BJANAMT");
      sum2 += gcds_print3.namevalue(i,"BJANAMT");
      sum3 += gcds_print3.namevalue(i,"BJANAMT");
      j++;
    }else if(flag1==gcds_print3.namevalue(i,"ATCODE") && flag2==gcds_print3.namevalue(i,"FSREFVAL")){
      gcds_print4.addrow();
      gcds_print4.namevalue(j,"FDCODE")=gcds_print3.namevalue(i,"FDCODE");
      gcds_print4.namevalue(j,"ATCODE")=gcds_print3.namevalue(i,"ATCODE");
      gcds_print4.namevalue(j,"COCODE")=gcds_print3.namevalue(i,"COCODE");
      gcds_print4.namevalue(j,"DIVCD")=gcds_print3.namevalue(i,"DIVCD");
      gcds_print4.namevalue(j,"REMARK")=gcds_print3.namevalue(i,"REMARK");
      gcds_print4.namevalue(j,"FSREFCD")=gcds_print3.namevalue(i,"FSREFCD");
      gcds_print4.namevalue(j,"ATKORNAM")=gcds_print3.namevalue(i,"ATKORNAM");
      gcds_print4.namevalue(j,"FSREFNM")=gcds_print3.namevalue(i,"FSREFNM");
      gcds_print4.namevalue(j,"CDNAM")=gcds_print3.namevalue(i,"CDNAM");
      gcds_print4.namevalue(j,"BEVAL")=gcds_print3.namevalue(i,"BEVAL");
      gcds_print4.namevalue(j,"SSNBR1")=gcds_print3.namevalue(i,"SSNBR1");
      gcds_print4.namevalue(j,"VENDNM")=gcds_print3.namevalue(i,"VENDNM");
      gcds_print4.namevalue(j,"BJANAMT")=gcds_print3.namevalue(i,"BJANAMT"); gcds_print4.namevalue(j,"ACTDAT")=gcds_print3.namevalue(i,"ACTDAT");
      gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
      gcds_print4.namevalue(1,"CURDT2")		= gs_date;
      gcds_print4.namevalue(j,"FSREFVAL") = gcds_print3.namevalue(i,"FSREFVAL");
      flag1=gcds_print4.namevalue(j,"ATCODE");
      flag2=gcds_print4.namevalue(j,"FSREFVAL");
      sum1 += gcds_print3.namevalue(i,"BJANAMT");
      sum2 += gcds_print3.namevalue(i,"BJANAMT");
      sum3 += gcds_print3.namevalue(i,"BJANAMT");
      j++;
    }else{
      if(flag1==gcds_print3.namevalue(i,"ATCODE") && flag2!=gcds_print3.namevalue(i,"FSREFVAL")){
        gcds_print4.addrow();
        gcds_print4.namevalue(j,"FDCODE")="";
        gcds_print4.namevalue(j,"ATCODE")="";
        gcds_print4.namevalue(j,"COCODE")="";
        gcds_print4.namevalue(j,"DIVCD")="";
        gcds_print4.namevalue(j,"REMARK")="";
        gcds_print4.namevalue(j,"FSREFCD")="";
        gcds_print4.namevalue(j,"ATKORNAM")="";
        gcds_print4.namevalue(j,"FSREFNM")="세목계";
        gcds_print4.namevalue(j,"CDNAM")="";
        gcds_print4.namevalue(j,"BEVAL")="";
        gcds_print4.namevalue(j,"SSNBR1")="";
		gcds_print4.namevalue(j,"ACTDAT")="";
        gcds_print4.namevalue(j,"VENDNM")="";
        gcds_print4.namevalue(j,"BJANAMT")=sum1;
        gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
        gcds_print4.namevalue(1,"CURDT2")		= gs_date;
        gcds_print4.namevalue(j,"FSREFVAL") = "";
        j++;
        flag1=gcds_print3.namevalue(i,"ATCODE");
        flag2=gcds_print3.namevalue(i,"FSREFVAL");
        sum1 = 0;

        gcds_print4.addrow();
        gcds_print4.namevalue(j,"FDCODE")=gcds_print3.namevalue(i,"FDCODE");
        gcds_print4.namevalue(j,"ATCODE")=gcds_print3.namevalue(i,"ATCODE");
        gcds_print4.namevalue(j,"COCODE")=gcds_print3.namevalue(i,"COCODE");
        gcds_print4.namevalue(j,"DIVCD")=gcds_print3.namevalue(i,"DIVCD");
        gcds_print4.namevalue(j,"REMARK")=gcds_print3.namevalue(i,"REMARK");
        gcds_print4.namevalue(j,"FSREFCD")=gcds_print3.namevalue(i,"FSREFCD");
        gcds_print4.namevalue(j,"ATKORNAM")=gcds_print3.namevalue(i,"ATKORNAM");
        gcds_print4.namevalue(j,"FSREFNM")=gcds_print3.namevalue(i,"FSREFNM");
        gcds_print4.namevalue(j,"CDNAM")=gcds_print3.namevalue(i,"CDNAM");
        gcds_print4.namevalue(j,"BEVAL")=gcds_print3.namevalue(i,"BEVAL");
        gcds_print4.namevalue(j,"SSNBR1")=gcds_print3.namevalue(i,"SSNBR1");
		 gcds_print4.namevalue(j,"ACTDAT")=gcds_print3.namevalue(i,"ACTDAT");
        gcds_print4.namevalue(j,"VENDNM")=gcds_print3.namevalue(i,"VENDNM");
        gcds_print4.namevalue(j,"BJANAMT")=gcds_print3.namevalue(i,"BJANAMT");
        gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
        gcds_print4.namevalue(1,"CURDT2")		= gs_date;
        gcds_print4.namevalue(j,"FSREFVAL") = gcds_print3.namevalue(i,"FSREFVAL");
        flag1=gcds_print4.namevalue(j,"ATCODE");
        flag2=gcds_print4.namevalue(j,"FSREFVAL");
        sum1 += gcds_print3.namevalue(i,"BJANAMT");
        sum2 += gcds_print3.namevalue(i,"BJANAMT");
        sum3 += gcds_print3.namevalue(i,"BJANAMT");
        j++;
      }
      else if(i!=1 && flag1!=gcds_print3.namevalue(i,"ATCODE")){
        gcds_print4.addrow();
        gcds_print4.namevalue(j,"FDCODE")="";
        gcds_print4.namevalue(j,"ATCODE")="";
        gcds_print4.namevalue(j,"COCODE")="";
        gcds_print4.namevalue(j,"DIVCD")="";
        gcds_print4.namevalue(j,"REMARK")="";
        gcds_print4.namevalue(j,"FSREFCD")="";
        gcds_print4.namevalue(j,"ATKORNAM")="";
        gcds_print4.namevalue(j,"FSREFNM")="세목계";
        gcds_print4.namevalue(j,"CDNAM")="";
        gcds_print4.namevalue(j,"BEVAL")="";
        gcds_print4.namevalue(j,"SSNBR1")="";
		gcds_print4.namevalue(j,"ACTDAT")="";
		
        gcds_print4.namevalue(j,"VENDNM")="";
        gcds_print4.namevalue(j,"BJANAMT")=sum1;
        gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
        gcds_print4.namevalue(1,"CURDT2")		= gs_date;
        gcds_print4.namevalue(j,"FSREFVAL") = "";
        j++;
        sum1 = 0;

        gcds_print4.addrow();
        gcds_print4.namevalue(j,"FDCODE")="";
        gcds_print4.namevalue(j,"ATCODE")="";
        gcds_print4.namevalue(j,"COCODE")="";
        gcds_print4.namevalue(j,"DIVCD")="";
        gcds_print4.namevalue(j,"REMARK")="";
        gcds_print4.namevalue(j,"FSREFCD")="";
        gcds_print4.namevalue(j,"ATKORNAM")="";
        gcds_print4.namevalue(j,"FSREFNM")="계정계";
        gcds_print4.namevalue(j,"CDNAM")="";
        gcds_print4.namevalue(j,"BEVAL")="";
        gcds_print4.namevalue(j,"SSNBR1")="";
		gcds_print4.namevalue(j,"ACTDAT")="";
        gcds_print4.namevalue(j,"VENDNM")="";
        gcds_print4.namevalue(j,"BJANAMT")=sum2;
        gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
        gcds_print4.namevalue(1,"CURDT2")		= gs_date;
        gcds_print4.namevalue(j,"FSREFVAL") = "";
        flag1=gcds_print3.namevalue(i,"ATCODE");
        flag2=gcds_print3.namevalue(i,"FSREFVAL");
        j++;
        sum2 = 0;


        gcds_print4.addrow();
        gcds_print4.namevalue(j,"FDCODE")=gcds_print3.namevalue(i,"FDCODE");
        gcds_print4.namevalue(j,"ATCODE")=gcds_print3.namevalue(i,"ATCODE");
        gcds_print4.namevalue(j,"COCODE")=gcds_print3.namevalue(i,"COCODE");
        gcds_print4.namevalue(j,"DIVCD")=gcds_print3.namevalue(i,"DIVCD");
        gcds_print4.namevalue(j,"REMARK")=gcds_print3.namevalue(i,"REMARK");
        gcds_print4.namevalue(j,"FSREFCD")=gcds_print3.namevalue(i,"FSREFCD");
        gcds_print4.namevalue(j,"ATKORNAM")=gcds_print3.namevalue(i,"ATKORNAM");
        gcds_print4.namevalue(j,"FSREFNM")=gcds_print3.namevalue(i,"FSREFNM");
        gcds_print4.namevalue(j,"CDNAM")=gcds_print3.namevalue(i,"CDNAM");
        gcds_print4.namevalue(j,"BEVAL")=gcds_print3.namevalue(i,"BEVAL");
        gcds_print4.namevalue(j,"SSNBR1")=gcds_print3.namevalue(i,"SSNBR1");
		 gcds_print4.namevalue(j,"ACTDAT")=gcds_print3.namevalue(i,"ACTDAT");
        gcds_print4.namevalue(j,"VENDNM")=gcds_print3.namevalue(i,"VENDNM");
        gcds_print4.namevalue(j,"BJANAMT")=gcds_print3.namevalue(i,"BJANAMT");
        gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
        gcds_print4.namevalue(1,"CURDT2")		= gs_date;
        gcds_print4.namevalue(j,"FSREFVAL") = gcds_print3.namevalue(i,"FSREFVAL");
        flag1=gcds_print4.namevalue(j,"ATCODE");
        flag2=gcds_print4.namevalue(j,"FSREFVAL");
        sum1 += gcds_print3.namevalue(i,"BJANAMT");
        sum2 += gcds_print3.namevalue(i,"BJANAMT");
        sum3 += gcds_print3.namevalue(i,"BJANAMT");
        j++;

      }
      else{
        gcds_print4.addrow();
        gcds_print4.namevalue(j,"FDCODE")=gcds_print3.namevalue(i,"FDCODE");
        gcds_print4.namevalue(j,"ATCODE")=gcds_print3.namevalue(i,"ATCODE");
        gcds_print4.namevalue(j,"COCODE")=gcds_print3.namevalue(i,"COCODE");
        gcds_print4.namevalue(j,"DIVCD")=gcds_print3.namevalue(i,"DIVCD");
        gcds_print4.namevalue(j,"REMARK")=gcds_print3.namevalue(i,"REMARK");
        gcds_print4.namevalue(j,"FSREFCD")=gcds_print3.namevalue(i,"FSREFCD");
        gcds_print4.namevalue(j,"ATKORNAM")=gcds_print3.namevalue(i,"ATKORNAM");
        gcds_print4.namevalue(j,"FSREFNM")=gcds_print3.namevalue(i,"FSREFNM");
        gcds_print4.namevalue(j,"CDNAM")=gcds_print3.namevalue(i,"CDNAM");
        gcds_print4.namevalue(j,"BEVAL")=gcds_print3.namevalue(i,"BEVAL");
        gcds_print4.namevalue(j,"SSNBR1")=gcds_print3.namevalue(i,"SSNBR1");
		gcds_print4.namevalue(j,"ACTDAT")=gcds_print3.namevalue(i,"ACTDAT");
        gcds_print4.namevalue(j,"VENDNM")=gcds_print3.namevalue(i,"VENDNM");
        gcds_print4.namevalue(j,"BJANAMT")=gcds_print3.namevalue(i,"BJANAMT");
        gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
        gcds_print4.namevalue(1,"CURDT2")		= gs_date;
        gcds_print4.namevalue(j,"FSREFVAL") = gcds_print3.namevalue(i,"FSREFVAL");
        flag1=gcds_print4.namevalue(j,"ATCODE");
        flag2=gcds_print4.namevalue(j,"FSREFVAL");
        j++;
        sum1 += gcds_print3.namevalue(i,"BJANAMT");
        sum2 += gcds_print3.namevalue(i,"BJANAMT");
        sum3 += gcds_print3.namevalue(i,"BJANAMT");
      }
    }
    if(i==gcds_print3.countrow){
      gcds_print4.addrow();
      gcds_print4.namevalue(j,"FDCODE")="";
      gcds_print4.namevalue(j,"ATCODE")="";
      gcds_print4.namevalue(j,"COCODE")="";
      gcds_print4.namevalue(j,"DIVCD")="";
      gcds_print4.namevalue(j,"REMARK")="";
      gcds_print4.namevalue(j,"FSREFCD")="";
      gcds_print4.namevalue(j,"ATKORNAM")="";
      gcds_print4.namevalue(j,"FSREFNM")="세목계";
      gcds_print4.namevalue(j,"CDNAM")="";
      gcds_print4.namevalue(j,"BEVAL")="";
      gcds_print4.namevalue(j,"SSNBR1")="";
	  gcds_print4.namevalue(j,"ACTDAT")="";
      gcds_print4.namevalue(j,"VENDNM")="";
      gcds_print4.namevalue(j,"BJANAMT")=sum1;
      gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
      gcds_print4.namevalue(1,"CURDT2")		= gs_date;
      gcds_print4.namevalue(j,"FSREFVAL") = "";
      j++;
      sum1 = 0;

      gcds_print4.addrow();
      gcds_print4.namevalue(j,"FDCODE")="";
      gcds_print4.namevalue(j,"ATCODE")="";
      gcds_print4.namevalue(j,"COCODE")="";
      gcds_print4.namevalue(j,"DIVCD")="";
      gcds_print4.namevalue(j,"REMARK")="";
      gcds_print4.namevalue(j,"FSREFCD")="";
      gcds_print4.namevalue(j,"ATKORNAM")="";
      gcds_print4.namevalue(j,"FSREFNM")="계정계";
      gcds_print4.namevalue(j,"CDNAM")="";
      gcds_print4.namevalue(j,"BEVAL")="";
      gcds_print4.namevalue(j,"SSNBR1")="";
	  gcds_print4.namevalue(j,"ACTDAT")="";
      gcds_print4.namevalue(j,"VENDNM")="";
	  
      gcds_print4.namevalue(j,"BJANAMT")=sum2;
      gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
      gcds_print4.namevalue(1,"CURDT2")		= gs_date;
      gcds_print4.namevalue(j,"FSREFVAL") = "";
      flag1=gcds_print3.namevalue(i,"ATCODE");
      flag2=gcds_print3.namevalue(i,"FSREFVAL");
      j++;
      sum2 = 0;
    }
	}
  gcds_print4.addrow();
  gcds_print4.namevalue(j,"FDCODE")="";
  gcds_print4.namevalue(j,"ATCODE")="";
  gcds_print4.namevalue(j,"COCODE")="";
  gcds_print4.namevalue(j,"DIVCD")="";
  gcds_print4.namevalue(j,"REMARK")="";
  gcds_print4.namevalue(j,"FSREFCD")="";
  gcds_print4.namevalue(j,"ATKORNAM")="";
  gcds_print4.namevalue(j,"FSREFNM")="합  계";
  gcds_print4.namevalue(j,"CDNAM")="";
  gcds_print4.namevalue(j,"BEVAL")="";
  gcds_print4.namevalue(j,"SSNBR1")="";
  gcds_print4.namevalue(j,"ACTDAT")="";
 
  gcds_print4.namevalue(j,"VENDNM")="";
  gcds_print4.namevalue(j,"BJANAMT")=sum3;
  gcds_print4.namevalue(1,"FDCODENM") = gclx_fdcode_2.text;
  gcds_print4.namevalue(1,"CURDT2")		= gs_date;
  gcds_print4.namevalue(j,"FSREFVAL") = "";
}
/******************************************************************************
	Description : 
  parameter   : 
******************************************************************************/
function ln_Popup_Vendcd(p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	if(p=="fr"){
		arrParam[1]=txt_vendnm_fr.value;
	}else if(p=="to"){
		arrParam[1]=txt_vendnm_to.value;
	}
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	//ln_Popup('02','fr','','txt_custnm_fr')

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {    
				txt_vendcd_fr.value = arrParam[0];
				txt_vendnm_fr.value = arrParam[1];
				txt_vendcd_to.value = arrParam[0];
				txt_vendnm_to.value = arrParam[1];
		 }else if(to){
				txt_vendcd_to.value = arrParam[0];
				txt_vendnm_to.value = arrParam[1];
		 }
	} else {
		 if(p=="fr") {
			  txt_vendcd_fr.value = "";
				txt_vendnm_fr.value = "";
				txt_vendcd_to.value = "";
				txt_vendnm_to.value = "";
		 }else if(p=="to"){
				txt_vendcd_to.value = "";
				txt_vendnm_to.value = "";
		 }
	}
}
/******************************************************************************
	Description : 결재후 거래처
  parameter   : 
******************************************************************************/
function ln_Popup_Vendcd2(p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	if(p=="fr"){
		arrParam[1]=txt_vendnm_fr_2.value;
	}else if(p=="to"){
		arrParam[1]=txt_vendnm_to_2.value;
	}
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	//ln_Popup('02','fr','','txt_custnm_fr')

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {    
				txt_vendcd_fr_2.value = arrParam[0];
				txt_vendnm_fr_2.value = arrParam[1];
				txt_vendcd_to_2.value = arrParam[0];
				txt_vendnm_to_2.value = arrParam[1];
		 }else if(to){
				txt_vendcd_to_2.value = arrParam[0];
				txt_vendnm_to_2.value = arrParam[1];
		 }
	} else {
		 if(p=="fr") {
			  txt_vendcd_fr_2.value = "";
				txt_vendnm_fr_2.value = "";
				txt_vendcd_to_2.value = "";
				txt_vendnm_to_2.value = "";
		 }else if(p=="to"){
				txt_vendcd_to_2.value = "";
				txt_vendnm_to_2.value = "";
		 }
	}
}

/******************************************************************************
	Description : 결재 전 계정팝업
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode(p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	if(p=="fr"){
		arrParam[1]=txt_atkornam_fr.value;
	}else if(p=="to"){
		arrParam[1]=txt_atkornam_to.value;
	}
	arrParam[2]="ATDEBTYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {
				txt_atcode_fr.value = arrParam[0];
				txt_atkornam_fr.value = arrParam[1];
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }else if(p=="to"){
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }
	}else{
		 if(p=="fr") {
				txt_atcode_fr.value = "";
				txt_atkornam_fr.value = "";
				txt_atcode_to.value = "";
				txt_atkornam_to.value = "";
		 }else if(p=="to"){
				txt_atcode_to.text = "";
				txt_atkornam_to.value = "";					
		}
	}
}

/******************************************************************************
	Description : 결재후 계정팝업
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode2(p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	if(p=="fr"){
		arrParam[1]=txt_atkornam_fr_2.value;
	}else if(p=="to"){
		arrParam[1]=txt_atkornam_to_2.value;
	}
	arrParam[2]="ATDEBTYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {
				txt_atcode_fr_2.value = arrParam[0];
				txt_atkornam_fr_2.value = arrParam[1];
				txt_atcode_to_2.value = arrParam[0];
				txt_atkornam_to_2.value = arrParam[1];

				gcds_temp_2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrParam[0];	
				//prompt('',gcds_temp_2.DataID);
			  gcds_temp_2.Reset();

		 }else if(p=="to"){
				txt_atcode_to_2.value = arrParam[0];
				txt_atkornam_to_2.value = arrParam[1];
		 }
	}else{
		if(p=="fr") {
				txt_atcode_fr_2.value = "";
				txt_atkornam_fr_2.value = "";
				txt_atcode_to_2.value = "";
				txt_atkornam_to_2.value = "";
		}else if(p=="to"){
				txt_atcode_to_2.text = "";
				txt_atkornam_to_2.value = "";					
		 }
	}
}

/******************************************************************************
	Description : 반제정산 데이타 조회
  parameter   : 
******************************************************************************/
function ln_Popup_Detail(strfdcode, strfsdat, strfsnbr,strfsseq){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]=strfdcode;
	arrParam[1]=strfsdat;
	arrParam[2]=strfsnbr;
	arrParam[3]=strfsseq;

	arrParam[4]=gclx_fdcode.text;  //지점명
	arrParam[5]=gcds_data01.namevalue(gcds_data01.rowposition,"SSNBR1");  //전표번호
	arrParam[6]=gcds_data01.namevalue(gcds_data01.rowposition,"ATKORNAM");  //계정명
	arrParam[7]=gcds_data01.namevalue(gcds_data01.rowposition,"CHAAMT");  //차변금액
	arrParam[8]=gcds_data01.namevalue(gcds_data01.rowposition,"DAEAMT");  //대변금액
	arrParam[9]=gcds_data01.namevalue(gcds_data01.rowposition,"JANAMT");  //잔액
	arrParam[10]=gcds_data01.namevalue(gcds_data01.rowposition,"VENDNM"); //거래처명
	arrParam[11]=gcds_data01.namevalue(gcds_data01.rowposition,"REMARK"); //적요

	arrParam[12]=gcds_data01.namevalue(gcds_data01.rowposition,"ATCODE");  //계정코드
	arrParam[13]=gcds_data01.namevalue(gcds_data01.rowposition,"VENDCD");  //거래처코드

	arrParam[14]=gcds_data01.namevalue(gcds_data01.rowposition,"BJANAMT");  //승인잔액
  
  strURL = "./a030015_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/******************************************************************************
	Description : 결재 후 반제정산 데이타 조회
  parameter   : 
******************************************************************************/
function ln_Popup_Detail2(strfdcode, strfsdat, strfsnbr,strfsseq){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	
	arrParam[0]=strfdcode;
	arrParam[1]=strfsdat;
	arrParam[2]=strfsnbr;
	arrParam[3]=strfsseq;

	arrParam[4]=gclx_fdcode_2.text;  //지점명
	arrParam[5]=gcds_data02.namevalue(gcds_data02.rowposition,"SSNBR1");  //전표번호
	arrParam[6]=gcds_data02.namevalue(gcds_data02.rowposition,"ATKORNAM");  //계정명
	arrParam[7]=gcds_data02.namevalue(gcds_data02.rowposition,"CHAAMT");  //차변금액
	arrParam[8]=gcds_data02.namevalue(gcds_data02.rowposition,"DAEAMT");  //대변금액
	arrParam[9]=gcds_data02.namevalue(gcds_data02.rowposition,"JANAMT");  //잔액
	arrParam[10]=gcds_data02.namevalue(gcds_data02.rowposition,"VENDNM"); //거래처명
	arrParam[11]=gcds_data02.namevalue(gcds_data02.rowposition,"REMARK"); //적요

	arrParam[12]=gcds_data02.namevalue(gcds_data02.rowposition,"ATCODE");  //계정코드
	arrParam[13]=gcds_data02.namevalue(gcds_data02.rowposition,"VENDCD");  //거래처코드

	arrParam[14]=gcds_data02.namevalue(gcds_data02.rowposition,"BJANAMT");  //승인잔액
  
  strURL = "./a030015_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/******************************************************************************
	Description : 탭구분
	prameter    : 0-일별코드, 1-월별항목
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : 거래처 찾기 ==> 거래처가 아닌 일반 관리항목으로 변경됨.
******************************************************************************/
function Popup(p){             
  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(gclx_fsrefcd_2.bindcolval=="0020"||gclx_fsrefcd_2.bindcolval=="0029"){//부서코드나 거래처
		strURL = "./gczm_vender_popup.jsp";
	  strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
  }else if(gclx_fsrefcd_2.bindcolval=="0002"){
		strURL = "./hcdept_popup.jsp";
	  strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else{
	  arrParam[0] = gclx_fsrefcd_2.bindcolval;
		arrParam[1] = "";
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}
	
	result = showModalDialog(strURL,arrParam,strPos);
if (result != null) {
		arrResult = result.split(";");
		 if(p=="fr") {
				 gcem_vend_fr_2.text = arrResult[0];
				 txt_vend_fr_2.value = arrResult[1];

				 gcem_vend_to_2.text = arrResult[0];
				 txt_vend_to_2.value = arrResult[1];
		 }else if(p=="to"){
				gcem_vend_to_2.text = arrResult[0];
				txt_vend_to_2.value = arrResult[1];
			}
	} else {
		if(p=="fr") {
			gcem_vend_fr_2.text = "";
			txt_vend_fr_2.value = "";
		}else if(p=="to"){
			gcem_vend_to_2.text = "";
			txt_vend_to_2.value = "";
		}
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-- 결재전조회  -->
<comment id="__NSID__">
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
  <PARAM NAME="Usechangeinfo" VALUE="false">
  <PARAM name="SubsumExpr"	VALUE="2:ATKORNAM,1:FSREFNM">
</object> 
<!-- 결재후 조회  -->
<object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
  <PARAM NAME="Usechangeinfo" VALUE="false">
  <param name="SortExpr"	value="+ATCODE+FDCODE+FSREFNM+SSDAT+SSNBR+TSSEQ+TSDAT+TSNBR">
  <PARAM name="SubsumExpr"	VALUE="2:ATKORNAM,1:FSREFNM">
</object>
<!--지점  -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
<object  id=gcds_fdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
<object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
</object>
<object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
  <PARAM NAME="Usechangeinfo" VALUE="false">
  <PARAM name="SubsumExpr"	VALUE="2:ATCODE,1:FSREFVAL">
</object>
<object  id=gcds_print3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
</object>
<object  id=gcds_print4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  <PARAM NAME="UseFilter" VALUE="true">
  <PARAM NAME="Usechangeinfo" VALUE="false">
  <PARAM name="SubsumExpr"	VALUE="2:ATCODE,1:FSREFVAL">
</object>
<object  id=gcds_temp_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!--콤보-->
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
    gcds_data01.Filter();
		ft_cnt01.innerText = "조회건수 : " + row + " 건";
	}
</script>

<script language=JavaScript for="gcds_data01" event="onFilter(row)">
  if (gcds_data01.NameValue(row,"BJANAMT") == "0") return false
  else return true;
</script>

<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
    //ln_Data_Reset(); //데이타 재설정
    gcds_data02.Filter();
		ft_cnt02.innerText = "조회건수 : " + row + " 건";
	}
</script>

<script language="javascript" for="gcds_temp_2" event="onloadCompleted(row,colid)">

  //2009.04.14 JYS 보증금계정 예외 처리
  //2009.09.04 JYS 업무선급금, 계약선급금 예외처리
  //2010.07.02 JYS 하자보수충당부채
  //2012.02.06 JYS 장기선급비용 
	if(gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="1210710"||
	   gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="1112110"||
	   gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="1112120"||
	   gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="1210800"||
	   gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2102500"
	   ){
		gclx_fsrefcd_2.bindcolval = "0020"; //거래처를 넣음.
		gclx_fsrefcd_2.Enable=false;
		return;
	}

	//2010.12.07.JYS 저장품
	//서울지점만 이렇게 처리함.
    if(gclx_fdcode_2.bindcolval=="02"&&gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="1120700"){
		gclx_fsrefcd_2.bindcolval = "0030"; //원가코드를 넣음.
		gclx_fsrefcd_2.Enable=false;
		return;
	}

	//2012.04.12 JYS  계정명과 세목명이 다른 경우 
	if(gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2100520"||gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2100525"||
	   gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2100400"||gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2100800"||
	   gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2101000"||gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2102700"
	   ){
	   gclx_fsrefcd_2.bindcolval = "";
	   gclx_fsrefcd_2.Enable=false;
	   return;
	}
	
	
	//2016.03.31 JYS  지급어음
	if(gcds_temp_2.namevalue(gcds_temp_2.rowposition,"ATCODE")=="2100120" ){
	   gclx_fsrefcd_2.bindcolval = "0967"; //어음번호.
	   gclx_fsrefcd_2.Enable=false;
	   return;
	}



	for(i=1;i<=row;i++){
		if(fn_trim(txt_atkornam_fr_2.value)==fn_trim(gcds_temp_2.namevalue(i,"CDNAM"))){
		  gclx_fsrefcd_2.bindcolval = gcds_temp_2.namevalue(i,"CDCODE");
			break;
		}
	}

  gclx_fsrefcd_2.Enable=false;

  /*
	alert("row::::"+row);
	gclx_fsrefcd_2.ComboDataID="";
	gcds_temp_2.InsertRow(1);
	gcds_temp_2.NameValue(1,"CDCODE")="";
	gcds_temp_2.NameValue(1,"CDNAM")="";
	gcds_temp_2.index=0;
	gclx_fsrefcd_2.ComboDataID="gcds_temp";
	*/
</script>

<script language=JavaScript for="gcds_data02" event="onFilter(row)">
  if (gcds_data02.NameValue(row,"BJANAMT") == "0") return false
  else return true;
</script>
<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
  gcds_print1.Filter();
	gcds_print2.ClearData();
	ln_SetDataHeader('01');
	ln_Sum();
	gcrp_print.preview(); 

</script>
<script language=JavaScript for="gcds_print1" event="onFilter(row)">
  if (gcds_print1.NameValue(row,"BJANAMT") == "0") return false
  else return true;
</script>
<script language="javascript" for="gcds_print3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print3 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
  gcds_print3.Filter();
	gcds_print2.ClearData();
	ln_SetDataHeader('02');
	ln_Sum2();
	gcrp_print2.preview(); 
</script>
<script language=JavaScript for="gcds_print3" event="onFilter(row)">
  if (gcds_print3.NameValue(row,"BJANAMT") == "0") return false
  else return true;
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcrp_print event=OnError()>

alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

</script>
<script language=JavaScript for=gcrp_print2 event=OnError()>

alert("Error Code = " + gcrp_print2.ErrorCode + "\n" + "Error Message = " + gcrp_print2.ErrorMsg);

</script>

<script language=JavaScript for=gcgd_data01 event=OnDblClick(row,colid)>
	if(row>0){
	  //반제원전표번호로 정산데이타를 조회함.
		ln_Popup_Detail(gcds_data01.namevalue(row,"FDCODE"),gcds_data01.namevalue(row,"FSDAT"),gcds_data01.namevalue(row,"FSNBR"),gcds_data01.namevalue(row,"FSSEQ"));
	}
</script>

<script language=JavaScript for=gcgd_data02 event=OnDblClick(row,colid)>
	if(row>0){
	  //반제원전표번호로 정산데이타를 조회함.
		ln_Popup_Detail2(gcds_data02.namevalue(row,"FDCODE"),gcds_data02.namevalue(row,"FSDAT"),gcds_data02.namevalue(row,"FSNBR"),gcds_data02.namevalue(row,"FSSEQ"));
	}
</script>

<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030015_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right">&nbsp;
		</td>
  </tr>
	<tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						  <PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"		VALUE="20px">
						  <PARAM NAME="DisableBackColor"	 VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
							   	<T>divid=div_1		title=결재전</T>									
							    <T>divid=div_2		title=결재후</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- 결재전===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>지점코드</td>
				<td class="tab18" style="width:190px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab31" style="height:30px;width:360px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				  <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_datefr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
					~&nbsp;
					<comment id="__NSID__"><object  id=gcem_dateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dateto', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>

        <td class="tab31">&nbsp;</td>
				<td class="tab18" align=right >
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
       </td>

			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>계정과목</td>
				<td class="tab19" width="690px" colspan=9>
				  <nobr>
					<input id="txt_atkornam_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('fr');">
					<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_atkornam_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('to');">
					<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>거&nbsp;래&nbsp;처</td>
				<td class="tab19" width="690px" colspan=7>
				  <nobr>
					<input id="txt_vendnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd('fr');">
					<input id="txt_vendcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_vendnm_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd('to');">
					<input id="txt_vendcd_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>

	<tr><td height="3px" ></td></tr>
	<tr>
		<td>  
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data01  
				style="position:relative;left:3px;width:875px; height:370px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data01">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="false">
					<param name=viewsummary   value=1>
					<PARAM NAME="Format"			VALUE="           
					<C> Name='계정코드'	  ID=ATCODE	   HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	 edit=none SumBgColor=#C3D0DB sort = true  </C> 
					<C> Name='계정명'		  ID=ATKORNAM	subSumText=''  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=left     edit=none SumBgColor=#C3D0DB sort = true </C> 
					<C> Name='세목'		    ID=FSREFNM 	subSumText={decode(FSREFNM,'계 ','계정계','세목계' )} HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=left     edit=none SumBgColor=#C3D0DB </C> 
					<C> Name='세목코드'		ID=FSREFVAL  HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=left     edit=none SumBgColor=#C3D0DB show=false</C> 
					<C> Name='접수일자'   ID=TSDAT	   mask='XXXX/XX/XX' HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none SumBgColor=#C3D0DB sort = true</C> 
					<C> Name='전표일자'   ID=ACTDAT	   HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none SumBgColor=#C3D0DB sort = true mask='XXXX/XX/XX' </C>
					<C> Name='전표번호'   ID=SSNBR1	   HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none SumBgColor=#C3D0DB sort = true</C> 
					<C> Name='순번'			  ID=FSNUM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=28    align=center	 edit=none SumBgColor=#C3D0DB show=false </C> 
					<C> Name='거래처코드'	ID=VENDCD 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center     edit=none SumBgColor=#C3D0DB sort = true show=false</C> 
					<C> Name='거래처'		  ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	  align=left     edit=none SumBgColor=#C3D0DB sort = true </C> 
					<C> Name='결재전잔액'	ID=BJANAMT   Value={SubSum(BJANAMT)} HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right    edit=none SumBgColor=#C3D0DB sort = true SumText=@sum</C> 
					<C> Name='적요'		    ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=327  align=left     edit=none SumBgColor=#C3D0DB</C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">조회건수 : </font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-- 결재후===========================================================================================================-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>지점코드</td>
				<td class="tab18" style="width:190px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab31" style="height:30px;width:360px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				  <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_datefr_2', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
					~&nbsp;
					<comment id="__NSID__"><object  id=gcem_dateto_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dateto_2', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>
				 <td class="tab31">&nbsp;</td>
				<td class="tab18" align=right >
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print2()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel2()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query2()">
       </td>
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>계정과목</td>
				<td class="tab19" width="690px" colspan=7>
				  <nobr>
					<input id="txt_atkornam_fr_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode2('fr');">
					<input id="txt_atcode_fr_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_atkornam_to_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode2('to');">
					<input id="txt_atcode_to_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>거&nbsp;래&nbsp;처</td>
				<td class="tab19" width="690px" colspan=5>
				  <nobr>
					<input id="txt_vendnm_fr_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd2('fr');">
					<input id="txt_vendcd_fr_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_vendnm_to_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd2('to');">
					<input id="txt_vendcd_to_2" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>세&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td class="tab19" width="690px" colspan=5>
				  <nobr>
					<comment id="__NSID__">
					  <object  id=gclx_fsrefcd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:4px;font-size:12px;width:150px;">
								<param name=ComboDataID			value="gcds_temp_2"> 
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CDNAM^0^140">
								<param name=BindColumn			value=CDCODE> 
						</object>&nbsp;
					  <object  id=gcem_vend_fr_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:5px;top:5px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="#############">
								<param name=PromptChar    value="">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
						</object>
						  <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:6px;top:3px" align=center onclick="Popup('fr');">
							<input id="txt_vend_fr_2" type="text" class="txtbox"  style= "position:relative;left:4px;top:-2px;width:150px; height:20px;" maxlength="36" disabled> &nbsp; ~ &nbsp;
						<object  id=gcem_vend_to_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:5px;top:5px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Numeric       value=false>
								<param name=Format        value="#############">
								<param name=PromptChar    value="">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
						 <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:6px;top:3px" align=center onclick="Popup('to');">
						 <input id="txt_vend_to_2" type="text" class="txtbox"  style= "position:relative;left:4px;top:-2px;width:150px; height:20px;" maxlength="36"  disabled>
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>

	<tr><td height="3px" ></td></tr>
	<tr>
		<td>  
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data02  
				    style="position:relative;left:3px;width:875px; height:345px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data02">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="false">
					<param name=viewsummary   value=1>
					<PARAM NAME="Format"			VALUE="           
					<C> Name='계정코드'	  ID=ATCODE	     HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	 edit=none SumBgColor=#C3D0DB sort = true  </C> 
					<C> Name='계정명'		  ID=ATKORNAM	 subSumText=''  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=left     edit=none SumBgColor=#C3D0DB sort = true </C> 
					<C> Name='세목'		  ID=FSREFNM 	 subSumText={decode(FSREFNM,'계 ','계정계','세목계' )} HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=left     edit=none SumBgColor=#C3D0DB </C> 
					<C> Name='세목코드'	  ID=FSREFVAL    HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=left     edit=none SumBgColor=#C3D0DB show=false</C> 
					<C> Name='접수일자'     ID=TSDAT	     mask='XXXX/XX/XX' HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none SumBgColor=#C3D0DB sort = true</C> 
					<C> Name='전표일자'     ID=ACTDAT	     HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none SumBgColor=#C3D0DB sort = true mask='XXXX/XX/XX' </C>
					<C> Name='전표번호'     ID=SSNBR1	     HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none SumBgColor=#C3D0DB sort = true</C> 
					<C> Name='순번'		  ID=FSNUM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=28    align=center	 edit=none SumBgColor=#C3D0DB show=false </C> 
					<C> Name='거래처코드'	  ID=VENDCD 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center   edit=none SumBgColor=#C3D0DB sort = true show=false</C> 
					<C> Name='거래처'		  ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	  align=left     edit=none SumBgColor=#C3D0DB sort = true </C> 
					<C> Name='결재후잔액'	  ID=BJANAMT     Value={SubSum(BJANAMT)} HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right    edit=none SumBgColor=#C3D0DB sort = true SumText=@sum</C> 
					<C> Name='적요'		  ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=327   align=left     edit=none SumBgColor=#C3D0DB </C>
					<C> Name='잠금'		  ID=FSLOCK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=50    align=center   edit=none SumBgColor=#C3D0DB  sort = true   EditStyle=Combo Data='T:잠금'</C> 
					<C> Name='기타1'		  ID=FSREFNM2    HeadAlign=Center HeadBgColor=#B9D4DC Width=327   align=left     edit=none SumBgColor=#C3D0DB  show=false</C> 
					<C> Name='기타2'		  ID=REFVAL2 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=327   align=left     edit=none SumBgColor=#C3D0DB  show=false</C>
					<C> Name='사번'		  ID=EMPNMK  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=left     edit=none SumBgColor=#C3D0DB  show=true</C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;">조회건수 : </font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>


<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print2">
	<param name="DetailDataID"			    value="gcds_print2">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">

	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=369 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=963 ,top=34 ,right=1800 ,bottom=112 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=953 ,top=22 ,right=1788 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=797, top=119, right=1941, bottom=166 ,mask='(  기간 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계 정 별 잔 액 장' ,left=959 ,top=25 ,right=1781 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=28 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=772 ,top=284 ,right=772 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2809 ,top=284 ,right=2809 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1878 ,top=284 ,right=1878 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1000 ,top=284 ,right=1000 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=28 ,top=284 ,right=28 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=256 ,top=291 ,right=525 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=250 ,top=284 ,right=250 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=181, right=2806, bottom=228, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=259, top=181, right=1106, bottom=228, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계정코드' ,left=47 ,top=291 ,right=234 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='지점코드 :' ,left=44 ,top=181 ,right=244 ,bottom=228 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리항목 :' ,left=44 ,top=228 ,right=244 ,bottom=275 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM2', left=259, top=228, right=1106, bottom=275, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1353 ,top=284 ,right=1353 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=541 ,top=284 ,right=541 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='결제전 잔액' ,left=1891 ,top=291 ,right=2216 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='거래처' ,left=1363 ,top=291 ,right=1869 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='전표번호' ,left=1009 ,top=291 ,right=1344 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='세목' ,left=550 ,top=291 ,right=756 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='전표일자' ,left=781 ,top=291 ,right=988 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2225 ,top=284 ,right=2225 ,bottom=369 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='적요' ,left=2234 ,top=291 ,right=2806 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=28 ,top=369 ,right=2809 ,bottom=366 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=43 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=28 ,top=0 ,right=28 ,bottom=44 </L>
	<L> left=1878 ,top=0 ,right=1878 ,bottom=44 </L>
	<L> left=772 ,top=0 ,right=772 ,bottom=44 </L>
	<C>id='ATKORNAM', left=256, top=0, right=525, bottom=44, align='left', supplevel=2, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=250 ,top=0 ,right=250 ,bottom=44 </L>
	<C>id='ATCODE', left=38, top=0, right=247, bottom=44, supplevel=3, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1353 ,top=0 ,right=1353 ,bottom=44 </L>
	<C>id='FSREFNM', left=550, top=0, right=756, bottom=44, align='left', supplevel=2, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=541 ,top=0 ,right=541 ,bottom=44 </L>
	<C>id='ACTDAT', left=781, top=0, right=988, bottom=44 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1000 ,top=0 ,right=1000 ,bottom=44 </L>
	<C>id='SSNBR1', left=1009, top=0, right=1344, bottom=44, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNM', left=1363, top=0, right=1869, bottom=44, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BJANAMT', left=1891, top=0, right=2216, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2225 ,top=0 ,right=2225 ,bottom=44 </L>
	<C>id='REMARK', left=2234, top=0, right=2806, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2809 ,top=0 ,right=2809 ,bottom=44 </L>
	<L> left=31 ,top=44 ,right=2813 ,bottom=44 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=28 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2247 ,top=3 ,right=2625 ,bottom=84</I>
	<L> left=28 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcrp_print2" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print4">
	<param name="DetailDataID"			    value="gcds_print4">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=370 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=963 ,top=34 ,right=1799 ,bottom=111 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=953 ,top=21 ,right=1789 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=796, top=119, right=1942, bottom=167 ,mask='(  기간 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계 정 별 잔 액 장' ,left=958 ,top=24 ,right=1781 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=29 ,top=283 ,right=2810 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=283 ,right=2810 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1648 ,top=283 ,right=1648 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=283 ,right=29 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=40 ,top=291 ,right=307 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='CURDT2', left=2384, top=180, right=2807, bottom=228, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2807 ,bottom=280 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=259, top=180, right=1106, bottom=228, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지점코드 :' ,left=45 ,top=180 ,right=243 ,bottom=228 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리항목 :' ,left=45 ,top=228 ,right=243 ,bottom=275 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM2', left=259, top=228, right=1106, bottom=275, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='결제후 잔액' ,left=1656 ,top=291 ,right=1982 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1992 ,top=283 ,right=1992 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=368 ,right=2810 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='거래처' ,left=1135 ,top=291 ,right=1640 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1124 ,top=283 ,right=1124 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='전표번호' ,left=781 ,top=291 ,right=1117 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=773 ,top=283 ,right=773 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='전표일자' ,left=553 ,top=291 ,right=759 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=545 ,top=283 ,right=545 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='세목' ,left=323 ,top=291 ,right=529 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=312 ,top=283 ,right=312 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='적요' ,left=2006 ,top=291 ,right=2794 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=45 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=0 ,right=29 ,bottom=45 </L>
	<L> left=1648 ,top=0 ,right=1648 ,bottom=45 </L>
	<C>id='ATKORNAM', left=40, top=0, right=307, bottom=45, align='left', supplevel=2, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BJANAMT', left=1656, top=0, right=1982, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1992 ,top=0 ,right=1992 ,bottom=45 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=45 </L>
	<L> left=32 ,top=45 ,right=2813 ,bottom=45 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='VENDNM', left=1135, top=0, right=1640, bottom=45, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1124 ,top=0 ,right=1124 ,bottom=45 </L>
	<C>id='SSNBR1', left=781, top=0, right=1117, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=773 ,top=0 ,right=773 ,bottom=45 </L>
	<C>id='ACTDAT', left=553, top=0, right=759, bottom=45 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=545 ,top=0 ,right=545 ,bottom=45 </L>
	<C>id='FSREFNM', left=323, top=0, right=529, bottom=45, align='left', supplevel=2, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=312 ,top=0 ,right=312 ,bottom=45 </L>
	<C>id='REMARK', left=2006, top=0, right=2794, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1854 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2246 ,top=3 ,right=2625 ,bottom=85</I>
	<L> left=29 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</object></comment><script>__ws__(__NSID__);</script> 
<!--B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=220 ,bottom=50 </L>
	<L> left=439 ,top=0 ,right=439 ,bottom=50 </L>
	<L> left=960 ,top=0 ,right=960 ,bottom=50 </L>
	<L> left=1302 ,top=0 ,right=1302 ,bottom=50 </L>
	<L> left=2191 ,top=0 ,right=2191 ,bottom=50 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<T>id='합  계' ,left=445 ,top=8 ,right=953 ,bottom=50 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=220 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1823 ,top=0 ,right=1823 ,bottom=50 </L>
	<S>id='{Sum(BJANAMT)}' ,left=1828 ,top=8 ,right=2185 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B-->
<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 