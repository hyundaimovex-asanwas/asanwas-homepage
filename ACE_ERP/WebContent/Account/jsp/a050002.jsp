<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 세금계산서합계표
+ 프로그램 ID	:  A050002.html
+ 기 능 정 의	:  세금계산서합계표 생성 및 조회 화면이다.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 a050002_s1
------------------------------------------------------------------------------
+ 수  정  자  :  정 영 식
+ 수 정 일 자 :  2010.03.29
+ 수 정 내 용 :  전자세금계산서 도입으로 인한 전산매체 format 변경 반영
------------------------------------------------------------------------------
+ 수  정  자  :  정 영 식
+ 수 정 일 자 :  2014.12.03
+ 수 정 내 용 :  그리드 엑셀 버튼 추가 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>세금계산서합계표</title>

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
var gs_deptcd = gdeptcd;	//부서코드
var gs_deptnm = gdeptnm;	//부서명
var gs_usrnm  = gusrnm;		//사용자명

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_DispChk(0);
	ln_Before();
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){
	if(e=="01"){ //매입
		var str1 = gclx_sfdcode.BindColVal;		//사업소
		var str2 = gcem_saccyy.text;					//예산년도
		var str5 = "A";												//매입
		var gisu = gclx_saccyyqt.BindColVal;	//기수
		if(gisu=="1"){ 			str3 = str2+"0101";	str4 = str2+"0331";
		}else if(gisu=="2"){str3 = str2+"0401";	str4 = str2+"0630";
		}else if(gisu=="3"){str3 = str2+"0701";	str4 = str2+"0930";
		}else if(gisu=="4"){str3 = str2+"1001";	str4 = str2+"1231";}
//		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s1?v_str1="+str1
//											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;

    //매입상세(전자세금계산 이외 수취분 )
    gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s01?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;
		gcds_data1.Reset();

		//매입합계(전자세금계산 이외 수취분 )
    gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s02?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;
		gcds_data2.Reset();

    //매입합계(전자세금계산 수취분 )
		gcds_data6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s07?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;
		//prompt('',gcds_data6.DataID);
		gcds_data6.Reset();

		 //매입합계 
    ln_A_Sum();

    var com="";
    if(str1==02){
      com='1018510695';
    }else if(str1==01){
      com='2218113834';
    }

    gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s1?v_str1="+com;
    gcds_data5.Reset();
	}else if(e=="02"){ //매출
		var str1 = gclx_sfdcode2.BindColVal;	//사업소
		var str2 = gcem_saccyy2.text;					//예산년도
		var str5 = "B";												//매출
		var gisu = gclx_saccyyqt2.BindColVal;	//기수
		if(gisu=="1"){ 			str3 = str2+"0101";	str4 = str2+"0331";
		}else if(gisu=="2"){str3 = str2+"0401";	str4 = str2+"0630";
		}else if(gisu=="3"){str3 = str2+"0701";	str4 = str2+"0930";
		}else if(gisu=="4"){str3 = str2+"1001";	str4 = str2+"1231";}
//		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s2?v_str1="+str1
//											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
//		gcds_data3.Reset();
//		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s3?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+gisu;
//		gcds_data4.Reset();

    //매출상세(전자세금계산 이외 발행분 )
    gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s03?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;
		gcds_data3.Reset();

    //매출합계(전자세금계산 이외 발행분 )
    gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s04?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;
		gcds_data4.Reset();
    
		//매출합계(전자세금계산 발행분 ) 
    gcds_data7.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050002_s05?v_str1="+str1
											+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+gisu;
		gcds_data7.Reset();

    //매출합계 
    ln_B_Sum();


    var com="";
    if(str1==02){
      com='1018510695';
    }else if(str1==01){
      com='2218113834';
    }

    gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050004_s1?v_str1="+com;
    gcds_data5.Reset();
	}
}

/*****************************************************************************************
	Description : 매출합계 sum
*****************************************************************************************/
function ln_B_Sum(){
  gcem_vendcnt42_sum.text = Number(gcem_vendcnt42_e.text) + Number(gcem_vendcnt42.text);  
  gcem_shtcnt42_sum.text = Number(gcem_shtcnt42_e.text) + Number(gcem_shtcnt42.text);  
  gcem_reqamt42_sum.text = Number(gcem_reqamt42_e.text)+ Number(gcem_reqamt42.text);  
  gcem_vatamt42_sum.text = Number(gcem_vatamt42_e.text) + Number(gcem_vatamt42.text);  
} 


/*****************************************************************************************
	Description : 매입합계 sum
*****************************************************************************************/
function ln_A_Sum(){
  gcem_vendcnt4a_sum.text = Number(gcem_vendcnt4a_e.text) + Number(gcem_vendcnt4a.text);  
  gcem_shtcnt4a_sum.text = Number(gcem_shtcnt4a_e.text) + Number(gcem_shtcnt4a.text);  
  gcem_reqamt4a_sum.text = Number(gcem_reqamt4a_e.text)+ Number(gcem_reqamt4a.text);  
  gcem_vatamt4a_sum.text = Number(gcem_vatamt4a_e.text) + Number(gcem_vatamt4a.text);  
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
	Description : 추가
******************************************************************************/
function ln_RowAdd(e){

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
  if(e=="01"){        //매입
    ln_Format1();
  }else if(e=="02"){  //매출
    ln_Format2(); 
  }
}

/******************************************************************************
	Description : 매입 PRINT FORMAT
******************************************************************************/
function ln_Format1() {
  gcds_temp01.ClearData();
  gcds_temp01.addrow();
  gcds_temp01.namevalue(gcds_temp01.countrow,"SACCYY") = gcem_saccyy.text;
  
  gcds_temp01.namevalue(gcds_temp01.countrow,"SACCYYQT") = gclx_saccyyqt.BindColVal;
  gcds_temp01.namevalue(gcds_temp01.countrow,"VEND_ID") = gcds_data5.namevalue(1,"VEND_ID");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VEND_NM") = gcds_data5.namevalue(1,"VEND_NM");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VD_DIRECT") = gcds_data5.namevalue(1,"VD_DIRECT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"ADDRESS1") = gcds_data5.namevalue(1,"ADDRESS1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"TAXTERMFR") = gcem_taxtermfr.text;
  gcds_temp01.namevalue(gcds_temp01.countrow,"TAXTERMTO") = gcem_taxtermto.text;
  gcds_temp01.namevalue(gcds_temp01.countrow,"WRDT") = gcem_wrdt.text;

  /***
  gcds_temp01.namevalue(gcds_temp01.countrow,"00001") = gcds_data2.namevalue(1,"00001");
  gcds_temp01.namevalue(gcds_temp01.countrow,"00002") = gcds_data2.namevalue(1,"00002");
  gcds_temp01.namevalue(gcds_temp01.countrow,"00003") = gcds_data2.namevalue(1,"00003");
  gcds_temp01.namevalue(gcds_temp01.countrow,"00004") = gcds_data2.namevalue(1,"00004");
  ***/

   //합계
	gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT_SUM")= gcds_data2.namevalue(1,"VENDCNT")+gcds_data6.namevalue(1,"VENDCNT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT_SUM") = gcds_data2.namevalue(1,"SHTCNT")+gcds_data6.namevalue(1,"SHTCNT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT_SUM") = gcds_data2.namevalue(1,"REQAMT")+gcds_data6.namevalue(1,"REQAMT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT_SUM") = gcds_data2.namevalue(1,"VATAMT")+gcds_data6.namevalue(1,"VATAMT");
	
	//전자세금계산서 이외 수취분 합계
	//소계

	//alert("gcds_data4::"+gcds_data4.namevalue(1,"VENDCNT"));
	//alert("gcds_data7;:"+gcds_data7.namevalue(1,"VENDCNT"));

	gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT") = gcds_data2.namevalue(1,"VENDCNT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT") = gcds_data2.namevalue(1,"SHTCNT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT") = gcds_data2.namevalue(1,"REQAMT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT") = gcds_data2.namevalue(1,"VATAMT");
	//사업자번호
  gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT1") = gcds_data2.namevalue(1,"VENDCNT1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT1") = gcds_data2.namevalue(1,"SHTCNT1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT1") = gcds_data2.namevalue(1,"REQAMT1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT1") = gcds_data2.namevalue(1,"VATAMT1");
	//주민번호
  gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT2") = gcds_data2.namevalue(1,"VENDCNT2");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT2") = gcds_data2.namevalue(1,"SHTCNT2");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT2") = gcds_data2.namevalue(1,"REQAMT2");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT2") = gcds_data2.namevalue(1,"VATAMT2");

	//전자세금계산서 발행분 합계
	//소계
	gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT_E") = gcds_data6.namevalue(1,"VENDCNT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT_E") = gcds_data6.namevalue(1,"SHTCNT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT_E") = gcds_data6.namevalue(1,"REQAMT");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT_E") = gcds_data6.namevalue(1,"VATAMT");
	//사업자번호
  gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT1_E") = gcds_data6.namevalue(1,"VENDCNT1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT1_E") = gcds_data6.namevalue(1,"SHTCNT1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT1_E") = gcds_data6.namevalue(1,"REQAMT1");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT1_E") = gcds_data6.namevalue(1,"VATAMT1");
	//주민번호
  gcds_temp01.namevalue(gcds_temp01.countrow,"VENDCNT2_E") = gcds_data6.namevalue(1,"VENDCNT2");
  gcds_temp01.namevalue(gcds_temp01.countrow,"SHTCNT2_E") = gcds_data6.namevalue(1,"SHTCNT2");
  gcds_temp01.namevalue(gcds_temp01.countrow,"REQAMT2_E") = gcds_data6.namevalue(1,"REQAMT2");
  gcds_temp01.namevalue(gcds_temp01.countrow,"VATAMT2_E") = gcds_data6.namevalue(1,"VATAMT2");
	

	gcds_temp02.ClearData();
  gcds_temp03.ClearData();
  var j = 1;
  var k = 1;
  for (i=1;i<=gcds_data1.countrow;i++) {
    if(i<6){
      gcds_temp02.Addrow();
      gcds_temp02.namevalue(i,"CURROW")   = i;
      gcds_temp02.namevalue(i,"VENDIDVS") = gcds_data1.namevalue(i,"VENDIDVS");
      gcds_temp02.namevalue(i,"VENDNAME") = gcds_data1.namevalue(i,"VENDNAME");
      gcds_temp02.namevalue(i,"SHTCNT")   = gcds_data1.namevalue(i,"SHTCNT");
      gcds_temp02.namevalue(i,"BLKCNT")   = gcds_data1.namevalue(i,"BLKCNT");
      gcds_temp02.namevalue(i,"REQAMT")   = gcds_data1.namevalue(i,"REQAMT");
      gcds_temp02.namevalue(i,"VATAMT")   = gcds_data1.namevalue(i,"VATAMT");
      gcds_temp02.namevalue(i,"BSNS_CND") = gcds_data1.namevalue(i,"BSNS_CND");
      gcds_temp02.namevalue(i,"BSNS_KND") = gcds_data1.namevalue(i,"BSNS_KND");
    }else if(i>5){
      gcds_temp03.Addrow();
      gcds_temp03.namevalue(j,"SACCYY")   = gcem_saccyy.text;
      gcds_temp03.namevalue(j,"SACCYYQT") = gclx_saccyyqt.BindColVal;
      gcds_temp03.namevalue(j,"VEND_ID")  = gcds_data5.namevalue(1,"VEND_ID");
      gcds_temp03.namevalue(j,"CURROW")   = i;
      gcds_temp03.namevalue(j,"VENDIDVS") = gcds_data1.namevalue(i,"VENDIDVS");
      gcds_temp03.namevalue(j,"VENDNAME") = gcds_data1.namevalue(i,"VENDNAME");
      gcds_temp03.namevalue(j,"SHTCNT")   = gcds_data1.namevalue(i,"SHTCNT");
      gcds_temp03.namevalue(j,"BLKCNT")   = gcds_data1.namevalue(i,"BLKCNT");
      gcds_temp03.namevalue(j,"REQAMT")   = gcds_data1.namevalue(i,"REQAMT");
      gcds_temp03.namevalue(j,"VATAMT")   = gcds_data1.namevalue(i,"VATAMT");
      gcds_temp03.namevalue(j,"BSNS_CND") = gcds_data1.namevalue(i,"BSNS_CND");
      gcds_temp03.namevalue(j,"BSNS_KND") = gcds_data1.namevalue(i,"BSNS_KND");
      if(j%20==1){
        gcds_temp03.namevalue(j,"FLAG")     = k++;
      }else{
        gcds_temp03.namevalue(j,"FLAG")     = k;
      }
      j++;
    }
  }
  var m = 1;
  var hd = 20-j%20;
  if(j%20!=0){
    for(m =1 ; m <= hd ; m++){
    gcds_temp03.Addrow();
    gcds_temp03.namevalue(j,"SACCYY")   = gcem_saccyy.text;
    gcds_temp03.namevalue(j,"SACCYYQT") = gclx_saccyyqt.BindColVal;
    gcds_temp03.namevalue(j,"VEND_ID")  = gcds_data5.namevalue(1,"VEND_ID");
    gcds_temp03.namevalue(j,"CURROW")   = "";
    gcds_temp03.namevalue(j,"VENDIDVS") = "";
    gcds_temp03.namevalue(j,"VENDNAME") = "";
    gcds_temp03.namevalue(j,"SHTCNT")   = "";
    gcds_temp03.namevalue(j,"BLKCNT")   = "";
    gcds_temp03.namevalue(j,"REQAMT")   = "";
    gcds_temp03.namevalue(j,"VATAMT")   = "";
    gcds_temp03.namevalue(j,"BSNS_CND") = "";
    gcds_temp03.namevalue(j,"BSNS_KND") = "";
    gcds_temp03.namevalue(j,"FLAG")     = k;
    j++;
    }
  }
  gcrp_print1.preview();
}


/******************************************************************************
	Description : 매출 PRINT FORMAT
******************************************************************************/
function ln_Format2() {
  gcds_temp04.ClearData();
  gcds_temp04.addrow();
  gcds_temp04.namevalue(gcds_temp04.countrow,"SACCYY") = gcem_saccyy2.text;
  gcds_temp04.namevalue(gcds_temp04.countrow,"SACCYYQT") = gclx_saccyyqt2.BindColVal;
  gcds_temp04.namevalue(gcds_temp04.countrow,"VEND_ID") = gcds_data5.namevalue(1,"VEND_ID");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VEND_NM") = gcds_data5.namevalue(1,"VEND_NM");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VD_DIRECT") = gcds_data5.namevalue(1,"VD_DIRECT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"ADDRESS1") = gcds_data5.namevalue(1,"ADDRESS1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"TAXTERMFR") = gcem_taxtermfr2.text;

  gcds_temp04.namevalue(gcds_temp04.countrow,"TAXTERMTO") = gcem_taxtermto2.text;
  gcds_temp04.namevalue(gcds_temp04.countrow,"WRDT") = gcem_wrdt2.text;

  /*
  gcds_temp04.namevalue(gcds_temp04.countrow,"00009") = gcds_data4.namevalue(1,"00009");
  gcds_temp04.namevalue(gcds_temp04.countrow,"00010") = gcds_data4.namevalue(1,"00010");
  gcds_temp04.namevalue(gcds_temp04.countrow,"00011") = gcds_data4.namevalue(1,"00011");
  gcds_temp04.namevalue(gcds_temp04.countrow,"00012") = gcds_data4.namevalue(1,"00012");
  */

  //합계
	gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT_SUM")= gcds_data4.namevalue(1,"VENDCNT")+gcds_data7.namevalue(1,"VENDCNT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT_SUM") = gcds_data4.namevalue(1,"SHTCNT")+gcds_data7.namevalue(1,"SHTCNT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT_SUM") = gcds_data4.namevalue(1,"REQAMT")+gcds_data7.namevalue(1,"REQAMT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT_SUM") = gcds_data4.namevalue(1,"VATAMT")+gcds_data7.namevalue(1,"VATAMT");
	
	//전자세금계산서 이외 발행분 합계
	//소계

	//alert("gcds_data4::"+gcds_data4.namevalue(1,"VENDCNT"));
	//alert("gcds_data7;:"+gcds_data7.namevalue(1,"VENDCNT"));

	gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT") = gcds_data4.namevalue(1,"VENDCNT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT") = gcds_data4.namevalue(1,"SHTCNT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT") = gcds_data4.namevalue(1,"REQAMT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT") = gcds_data4.namevalue(1,"VATAMT");
	//사업자번호
  gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT1") = gcds_data4.namevalue(1,"VENDCNT1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT1") = gcds_data4.namevalue(1,"SHTCNT1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT1") = gcds_data4.namevalue(1,"REQAMT1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT1") = gcds_data4.namevalue(1,"VATAMT1");
	//주민번호
  gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT2") = gcds_data4.namevalue(1,"VENDCNT2");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT2") = gcds_data4.namevalue(1,"SHTCNT2");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT2") = gcds_data4.namevalue(1,"REQAMT2");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT2") = gcds_data4.namevalue(1,"VATAMT2");

	//전자세금계산서 발행분 합계
	//소계
	gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT_E") = gcds_data7.namevalue(1,"VENDCNT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT_E") = gcds_data7.namevalue(1,"SHTCNT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT_E") = gcds_data7.namevalue(1,"REQAMT");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT_E") = gcds_data7.namevalue(1,"VATAMT");
	//사업자번호
  gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT1_E") = gcds_data7.namevalue(1,"VENDCNT1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT1_E") = gcds_data7.namevalue(1,"SHTCNT1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT1_E") = gcds_data7.namevalue(1,"REQAMT1");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT1_E") = gcds_data7.namevalue(1,"VATAMT1");
	//주민번호
  gcds_temp04.namevalue(gcds_temp04.countrow,"VENDCNT2_E") = gcds_data7.namevalue(1,"VENDCNT2");
  gcds_temp04.namevalue(gcds_temp04.countrow,"SHTCNT2_E") = gcds_data7.namevalue(1,"SHTCNT2");
  gcds_temp04.namevalue(gcds_temp04.countrow,"REQAMT2_E") = gcds_data7.namevalue(1,"REQAMT2");
  gcds_temp04.namevalue(gcds_temp04.countrow,"VATAMT2_E") = gcds_data7.namevalue(1,"VATAMT2");
	
	gcds_temp05.ClearData();
  gcds_temp06.ClearData();


  if(gcds_data3.countrow!=0){

		var j = 1;
		var k = 1;
		for (i=1;i<=gcds_data3.countrow;i++) {
			if(i<6){
				gcds_temp05.Addrow();
				gcds_temp05.namevalue(i,"CURROW")   = i;
				gcds_temp05.namevalue(i,"VENDIDVS") = gcds_data3.namevalue(i,"VENDIDVS");
				gcds_temp05.namevalue(i,"VENDNAME") = gcds_data3.namevalue(i,"VENDNAME");
				gcds_temp05.namevalue(i,"SHTCNT")   = gcds_data3.namevalue(i,"SHTCNT");
				gcds_temp05.namevalue(i,"BLKCNT")   = gcds_data3.namevalue(i,"BLKCNT");
				gcds_temp05.namevalue(i,"REQAMT")   = gcds_data3.namevalue(i,"REQAMT");
				gcds_temp05.namevalue(i,"VATAMT")   = gcds_data3.namevalue(i,"VATAMT");
				gcds_temp05.namevalue(i,"BSNS_CND") = gcds_data3.namevalue(i,"BSNS_CND");
				gcds_temp05.namevalue(i,"BSNS_KND") = gcds_data3.namevalue(i,"BSNS_KND");
			}else if(i>5){
				gcds_temp06.Addrow();
				gcds_temp06.namevalue(j,"SACCYY")   = gcem_saccyy2.text;
				gcds_temp06.namevalue(j,"SACCYYQT") = gclx_saccyyqt2.BindColVal;
				gcds_temp06.namevalue(j,"VEND_ID")  = gcds_data5.namevalue(1,"VEND_ID");
				gcds_temp06.namevalue(j,"CURROW")   = i;
				gcds_temp06.namevalue(j,"VENDIDVS") = gcds_data3.namevalue(i,"VENDIDVS");
				gcds_temp06.namevalue(j,"VENDNAME") = gcds_data3.namevalue(i,"VENDNAME");
				gcds_temp06.namevalue(j,"SHTCNT")   = gcds_data3.namevalue(i,"SHTCNT");
				gcds_temp06.namevalue(j,"BLKCNT")   = gcds_data3.namevalue(i,"BLKCNT");
				gcds_temp06.namevalue(j,"REQAMT")   = gcds_data3.namevalue(i,"REQAMT");
				gcds_temp06.namevalue(j,"VATAMT")   = gcds_data3.namevalue(i,"VATAMT");
				gcds_temp06.namevalue(j,"BSNS_CND") = gcds_data3.namevalue(i,"BSNS_CND");
				gcds_temp06.namevalue(j,"BSNS_KND") = gcds_data3.namevalue(i,"BSNS_KND");
				if(j%20==1){
					gcds_temp06.namevalue(j,"FLAG")     = k++;
				}else{
					gcds_temp06.namevalue(j,"FLAG")     = k;
				}
				j++;
			}
		}
		var m = 1;
		var hd = 20-j%20;
		if(j%20!=0){
			for(m =1 ; m <= hd ; m++){
			gcds_temp06.Addrow();
			gcds_temp06.namevalue(j,"SACCYY")   = gcem_saccyy2.text;
			gcds_temp06.namevalue(j,"SACCYYQT") = gclx_saccyyqt2.BindColVal;
			gcds_temp06.namevalue(j,"VEND_ID")  = gcds_data5.namevalue(1,"VEND_ID");
			gcds_temp06.namevalue(j,"CURROW")   = "";
			gcds_temp06.namevalue(j,"VENDIDVS") = "";
			gcds_temp06.namevalue(j,"VENDNAME") = "";
			gcds_temp06.namevalue(j,"SHTCNT")   = "";
			gcds_temp06.namevalue(j,"BLKCNT")   = "";
			gcds_temp06.namevalue(j,"REQAMT")   = "";
			gcds_temp06.namevalue(j,"VATAMT")   = "";
			gcds_temp06.namevalue(j,"BSNS_CND") = "";
			gcds_temp06.namevalue(j,"BSNS_KND") = "";
			gcds_temp06.namevalue(j,"FLAG")     = k;
			j++;
			}
		}
	}else{
	  for(x=1;x<=5;x++){
			gcds_temp05.Addrow();
			gcds_temp05.namevalue(x,"CURROW")   = x;
			gcds_temp05.namevalue(x,"VENDIDVS") = "";
			gcds_temp05.namevalue(x,"VENDNAME") = "";
			gcds_temp05.namevalue(x,"SHTCNT")   = 0;
			gcds_temp05.namevalue(x,"BLKCNT")   = 0;
			gcds_temp05.namevalue(x,"REQAMT")   = 0;
			gcds_temp05.namevalue(x,"VATAMT")   = 0;
			gcds_temp05.namevalue(x,"BSNS_CND") ="";
			gcds_temp05.namevalue(x,"BSNS_KND") ="";
		}
	}

  gcrp_print2.preview();

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('매입');
	}else {
		if (gcds_data3.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp02.RunExcel('매출');
	}
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
	/*** 매입 **********************************************************/
	gcem_saccyy.text    = gs_date2;	//년도
	gclx_saccyyqt.index = 0;				//기수
	gcem_wrdt.text		  = gs_date;	//작성일자
//	gcem_taxtermfr.text = gs_date3+"01";	//거래기간fr
//	gcem_taxtermto.text = gs_date;				//거래기간to

  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0101";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0401";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0701";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"1001";
    gcem_taxtermto.Text = gcem_saccyy.Text+"1231";
  }
	//지점코드
	gcds_fdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode1.Reset();
  gclx_sfdcode.index=0;

	/*** 매출 **********************************************************/
	gcem_saccyy2.text    = gs_date2; //년도
	gclx_saccyyqt2.index = 0;				 //기수
	gcem_wrdt2.text		   = gs_date;	 //작성일자		
//	gcem_taxtermfr2.text = gs_date3+"01";	//거래기간fr
//	gcem_taxtermto2.text = gs_date;				//거래기간to
  if(gclx_saccyyqt2.Index=="0"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"0101";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"0331";
  }else if(gclx_saccyyqt2.Index=="1"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"0401";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"0630";
  }else if(gclx_saccyyqt2.Index=="2"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"0701";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"0930";
  }else if(gclx_saccyyqt2.Index=="3"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"1001";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"1231";
  }

	//지점코드
	gcds_fdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode2.Reset();

  gclx_sfdcode2.index=0;


  if (gcds_temp01.countrow<1){
    //var s_temp = "SACCYY:STRING,SACCYYQT:STRING,VEND_ID:STRING,VEND_NM:STRING,VD_DIRECT:STRING,ADDRESS1:STRING,TAXTERMFR:STRING,TAXTERMTO:STRING,WRDT:STRING,00001:DECIAML,00002:DECIAML,00003:DECIAML,00004:DECIAML";
    var s_temp = "SACCYY:STRING,SACCYYQT:STRING,VEND_ID:STRING,VEND_NM:STRING,VD_DIRECT:STRING,ADDRESS1:STRING,TAXTERMFR:STRING,TAXTERMTO:STRING,WRDT:STRING,"
		           + "VENDCNT_SUM:DECIAML,SHTCNT_SUM:DECIAML,REQAMT_SUM:DECIAML,VATAMT_SUM:DECIAML,"
							 + "VENDCNT:DECIAML,SHTCNT:DECIAML,REQAMT:DECIAML,VATAMT:DECIAML,"
							 + "VENDCNT1:DECIAML,SHTCNT1:DECIAML,REQAMT1:DECIAML,VATAMT1:DECIAML,"
							 + "VENDCNT2:DECIAML,SHTCNT2:DECIAML,REQAMT2:DECIAML,VATAMT2:DECIAML,"
							 + "VENDCNT_E:DECIAML,SHTCNT_E:DECIAML,REQAMT_E:DECIAML,VATAMT_E:DECIAML,"
							 + "VENDCNT1_E:DECIAML,SHTCNT1_E:DECIAML,REQAMT1_E:DECIAML,VATAMT1_E:DECIAML,"
							 + "VENDCNT2_E:DECIAML,SHTCNT2_E:DECIAML,REQAMT2_E:DECIAML,VATAMT2_E:DECIAML";
		
		gcds_temp01.SetDataHeader(s_temp);
  }
  if (gcds_temp02.countrow<1){
    var s_temp = "CURROW:STRING,VENDIDVS:STRING,VENDNAME:STRING,SHTCNT:DECIAML,BLKCNT:DECIAML,REQAMT:DECIAML,VATAMT:DECIAML,BSNS_CND:STRING,BSNS_KND:STRING";
    gcds_temp02.SetDataHeader(s_temp);
  }
  if (gcds_temp03.countrow<1){
    var s_temp = "SACCYY:STRING,SACCYYQT:STRING,VEND_ID:STRING,CURROW:STRING,VENDIDVS:STRING,VENDNAME:STRING,SHTCNT:DECIAML,BLKCNT:DECIAML,REQAMT:DECIAML,VATAMT:DECIAML,BSNS_CND:STRING,BSNS_KND:STRING,FLAG:DECIAML";
    gcds_temp03.SetDataHeader(s_temp);
  }


  if (gcds_temp04.countrow<1){
    var s_temp = "SACCYY:STRING,SACCYYQT:STRING,VEND_ID:STRING,VEND_NM:STRING,VD_DIRECT:STRING,ADDRESS1:STRING,TAXTERMFR:STRING,TAXTERMTO:STRING,WRDT:STRING,"
		           + "VENDCNT_SUM:DECIAML,SHTCNT_SUM:DECIAML,REQAMT_SUM:DECIAML,VATAMT_SUM:DECIAML,"
							 + "VENDCNT:DECIAML,SHTCNT:DECIAML,REQAMT:DECIAML,VATAMT:DECIAML,"
							 + "VENDCNT1:DECIAML,SHTCNT1:DECIAML,REQAMT1:DECIAML,VATAMT1:DECIAML,"
							 + "VENDCNT2:DECIAML,SHTCNT2:DECIAML,REQAMT2:DECIAML,VATAMT2:DECIAML,"
							 + "VENDCNT_E:DECIAML,SHTCNT_E:DECIAML,REQAMT_E:DECIAML,VATAMT_E:DECIAML,"
							 + "VENDCNT1_E:DECIAML,SHTCNT1_E:DECIAML,REQAMT1_E:DECIAML,VATAMT1_E:DECIAML,"
							 + "VENDCNT2_E:DECIAML,SHTCNT2_E:DECIAML,REQAMT2_E:DECIAML,VATAMT2_E:DECIAML";
							 
    gcds_temp04.SetDataHeader(s_temp);
  }
  if (gcds_temp05.countrow<1){
    var s_temp = "CURROW:STRING,VENDIDVS:STRING,VENDNAME:STRING,SHTCNT:DECIAML,BLKCNT:DECIAML,REQAMT:DECIAML,VATAMT:DECIAML,BSNS_CND:STRING,BSNS_KND:STRING";
    gcds_temp05.SetDataHeader(s_temp);
  }
  if (gcds_temp06.countrow<1){
    var s_temp = "SACCYY:STRING,SACCYYQT:STRING,VEND_ID:STRING,CURROW:STRING,VENDIDVS:STRING,VENDNAME:STRING,SHTCNT:DECIAML,BLKCNT:DECIAML,REQAMT:DECIAML,VATAMT:DECIAML,BSNS_CND:STRING,BSNS_KND:STRING,FLAG:DECIAML";
    gcds_temp06.SetDataHeader(s_temp);
  }
}


/******************************************************************************
	Description : 탭구분
	prameter    : 0-예산신청내역, 1-변경예산신청
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
Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01") {
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.GridToExcel("매입 세금계산서 합계표","",2);
	}else if(e=="02") {
		if (gcds_data3.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp02.GridToExcel("매출 세금계산서 합계표","",2);
	}
}

</script>
<script language=JavaScript for=gcrp_print2 event=OnError()>
  alert("Error Code = " + gcrp_print2.ErrorCode + "\n" + "Error Message = " + gcrp_print2.ErrorMsg);
</script>
<script language=JavaScript for=gcrp_print1 event=OnError()>
  alert("Error Code = " + gcrp_print1.ErrorCode + "\n" + "Error Message = " + gcrp_print1.ErrorMsg);
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object  id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>
<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	//ft_cnt01.innerText = "조회건수 : " + row + " 건";
//	if (row <1) {
//		alert("검색된 데이터가 없습니다.");
//	}else{
//	}
</script>
<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("전자세금계산서 이외 매출발행이 존재하지 않습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data4" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>


<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_fdcode1" event="onloadCompleted(row,colid)">
	gcds_fdcode1.InsertRow(1);
	gcds_fdcode1.NameValue(1,"FDCODE")="";
	gcds_fdcode1.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode.index=2;
	}else{
//		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_fdcode2" event="onloadCompleted(row,colid)">
	gcds_fdcode2.InsertRow(1);
	gcds_fdcode2.NameValue(1,"FDCODE")="";
	gcds_fdcode2.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode2.index=2;
	}else{
//		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>
<script language=JavaScript for=gclx_saccyyqt event=onSelChange()>
  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0101";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0401";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"0701";
    gcem_taxtermto.Text = gcem_saccyy.Text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.Text = gcem_saccyy.Text+"1001";
    gcem_taxtermto.Text = gcem_saccyy.Text+"1231";
  }
</script>
<script language=JavaScript for=gclx_saccyyqt2 event=onSelChange()>
  if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="1"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"0101";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"0331";
  }else if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="2"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"0401";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"0630";
  }else if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="3"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"0701";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"0930";
  }else if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="4"){
    gcem_taxtermfr2.Text = gcem_saccyy2.Text+"1001";
    gcem_taxtermto2.Text = gcem_saccyy2.Text+"1231";
  }
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*매입*/
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
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050002_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right><comment id="__NSID__">
						<object id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="position:relative;left:0px;width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=매입</T>									
							  <T>divid=div_2		title=매출</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
	<tr><td height=4></td></tr>
</table>

<!-- 매입 ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:620px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
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
					
					    <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')">
						<img src="../../Common/img/btn/com_b_query.gif"	 style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr><!-- 매입 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>등록번호</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:85px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=Format			value="000-00-00000">
									<param name=PromptChar	value="_">
									<param name=Enable			value="false">
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상&nbsp;&nbsp;&nbsp;&nbsp;호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업장주소</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_addrs classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>업&nbsp;&nbsp;&nbsp;&nbsp;태</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_bsnscnd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>종&nbsp;&nbsp;&nbsp;&nbsp;목</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_bsnsknd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>작성일자</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object id=gcem_wrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_wrdt','Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>거래기간</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object id=gcem_taxtermfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxtermfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~<comment id="__NSID__">
								<object id=gcem_taxtermto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_taxtermto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- 매입2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee" colspan=2><nobr>구&nbsp;&nbsp;&nbsp;&nbsp;분</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>매입처수</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>매&nbsp;&nbsp;&nbsp;&nbsp;수</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>세&nbsp;&nbsp;&nbsp;&nbsp;액</nobr></td>
							<td class="tab22" style="width:144px;" bgcolor="#eeeeee" align="center"><nobr>비&nbsp;&nbsp;&nbsp;&nbsp;고</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:144px;" colspan=2><nobr>합&nbsp;계&nbsp;분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4a_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4a_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4a_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4a_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							 <td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
             <tr>
							<td class="tab11" style="width:70px;" rowspan=3><nobr>전자<BR>세금계산서<BR>수취분</nobr></td>
              <td class="tab11" style="width:74px;"><nobr>사업자분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4c_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4c_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4c_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4c_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:74px;"><nobr>주민기재분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4b_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4b_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4b_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4b_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
            <tr>
							<td class="tab11" style="width:74px;"><nobr>소&nbsp;계</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4a_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4a_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4a_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4a_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;" align="center"><nobr><comment id="__NSID__">
								<object id=gcem_filler4a_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
						</tr>
						
						<tr>
							<td class="tab12" style="width:70px;" rowspan=3><nobr>전자<BR>세금계산서<BR>이외 수취분</nobr></td>
              <td class="tab11" style="width:74px;"><nobr>사업자분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4c classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4c classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4c classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4c classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:74px;"><nobr>주민기재분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4b classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4b classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4b classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4b classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
            <tr>
							<td class="tab12" style="width:74px;"><nobr>소&nbsp;계</nobr></td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt4a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt4a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt4a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt4a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:144px;" align="center"><nobr><comment id="__NSID__">
								<object id=gcem_filler4a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
						</tr>


						<!-- <tr>
							<td class="tab12" style="width:144px;"><nobr>사업자분</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr> -->
						<!-- <tr>
							<td class="tab11" style="width:144px;"><nobr>사업자분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab11" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab11" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab11" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr> -->
						<!-- <tr>
							<td class="tab12" style="width:144px;"><nobr>주민기재분</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td class="tab12" style="width:144px;"><nobr>&nbsp;</nobr></td>
							<td style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr> -->
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:240px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data1">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='등록번호'	ID=VENDIDVS	HeadAlign=Center HeadBgColor=#B9D4DC Width=93		align=center	SumText='계'	SumBgColor='#C3D0DB' mask='XXX-XX-XXXXX'</C>
								<C> Name='상호'			ID=VENDNAME	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='매수'			ID=SHTCNT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='공란수'		ID=BLKCNT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='공급가액'	ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='세액'			ID=VATAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='업태'			ID=BSNS_CND	HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='종목'			ID=BSNS_KND	HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 
			 
<!-- 매출 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:620px;width:879px;bacground-color:#708090"></fieldset>
	<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style='display:none'>	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>사업소</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
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
						<object id=gcem_saccyy2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
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
						<object  id=gclx_saccyyqt2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1기예정,2^1기확정,3^2기예정,4^2기확정">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
					
					    <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('02')"> 
						<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('02')">
						<img src="../../Common/img/btn/com_b_query.gif"	 style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr><!-- 매출 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>등록번호</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendid2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:85px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=Format			value="000-00-00000">
									<param name=PromptChar	value="_">
									<param name=Enable			value="false">
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상&nbsp;&nbsp;&nbsp;&nbsp;호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업장주소</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_addrs2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>업&nbsp;&nbsp;&nbsp;&nbsp;태</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_bsnscnd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>종&nbsp;&nbsp;&nbsp;&nbsp;목</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_bsnsknd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>작성일자</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object id=gcem_wrdt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_wrdt','Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>거래기간</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object id=gcem_taxtermfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxtermfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~<comment id="__NSID__">
								<object id=gcem_taxtermto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_taxtermto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- 매출2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee" colspan=2><nobr>구&nbsp;&nbsp;&nbsp;&nbsp;분</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>매출처수</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>매&nbsp;&nbsp;&nbsp;&nbsp;수</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
							<td class="tab11" style="width:144px;" bgcolor="#eeeeee"><nobr>세&nbsp;&nbsp;&nbsp;&nbsp;액</nobr></td>
							<td class="tab22" style="width:144px;" bgcolor="#eeeeee" align="center"><nobr>비&nbsp;&nbsp;&nbsp;&nbsp;고</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:144px;" colspan=2><nobr>합&nbsp;&nbsp;&nbsp;&nbsp;계</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt42_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt42_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt42_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt42_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
              <td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
            <tr>
							<td class="tab11" style="width:70px;" rowspan=3><nobr>전자<BR>세금계산서<BR>발행분</nobr></td>
              <td class="tab11" style="width:74px;"><nobr>사업자분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt43_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt43_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt43_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt43_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:74px;"><nobr>주민기재분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt44_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt44_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt44_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt44_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
            <tr>
							<td class="tab11" style="width:74px;"><nobr>소&nbsp;계</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt42_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt42_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt42_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt42_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;" align="center"><nobr><comment id="__NSID__">
								<object id=gcem_filler42_e classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
						</tr>
						
						<tr>
							<td class="tab12" style="width:70px;" rowspan=3><nobr>전자<BR>세금계산서<BR>이외 발행분</nobr></td>
              <td class="tab11" style="width:74px;"><nobr>사업자분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt43 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt43 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt43 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt43 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:74px;"><nobr>주민기재분</nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt44 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt44 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt44 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt44 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:144px;"><nobr>&nbsp;</nobr></td>
						</tr>
            <tr>
							<td class="tab12" style="width:74px;"><nobr>소&nbsp;계</nobr></td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:144px;"><nobr><comment id="__NSID__">
								<object id=gcem_vatamt42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:144px;" align="center"><nobr><comment id="__NSID__">
								<object id=gcem_filler42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
						</tr>
            
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:240px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data3">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='등록번호'	ID=VENDIDVS	HeadAlign=Center HeadBgColor=#B9D4DC Width=93		align=center	SumText='계'	SumBgColor='#C3D0DB' mask='XXX-XX-XXXXX'</C>
								<C> Name='상호'			ID=VENDNAME	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='매수'			ID=SHTCNT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='공란수'		ID=BLKCNT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='공급가액'	ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='세액'			ID=VATAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='업태'			ID=BSNS_CND	HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='종목'			ID=BSNS_KND	HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [매입]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data1>
	<param name=BindInfo		value='  
		<C>Col=VENDIDVS			Ctrl=gcem_vendid				Param=text</C>
		<C>Col=VENDNAME			Ctrl=gcem_vendnm				Param=text</C>
		<C>Col=VD_DIRECT	  Ctrl=gcem_vddirect			Param=text</C>
		<C>Col=ADDRESS1		  Ctrl=gcem_addrs				  Param=text</C>
		<C>Col=BSNS_CND		  Ctrl=gcem_bsnscnd				Param=text</C>
		<C>Col=BSNS_KND		  Ctrl=gcem_bsnsknd				Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [매입]
------------------------------------------------------------------------------>
<comment id="__NSID__">
   <!-- 전자세금계산서분 이외 -->
  <object  id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data2>
	<param name=BindInfo		value='  
	  <C>Col=VENDCNT1			Ctrl=gcem_vendcnt4c			Param=text</C>
		<C>Col=SHTCNT1			Ctrl=gcem_shtcnt4c			Param=text</C>
		<C>Col=REQAMT1			Ctrl=gcem_reqamt4c			Param=text</C>
		<C>Col=VATAMT1			Ctrl=gcem_vatamt4c			Param=text</C>

		<C>Col=VENDCNT2			Ctrl=gcem_vendcnt4b			Param=text</C>
		<C>Col=SHTCNT2			Ctrl=gcem_shtcnt4b			Param=text</C>
		<C>Col=REQAMT2			Ctrl=gcem_reqamt4b			Param=text</C>
		<C>Col=VATAMT2			Ctrl=gcem_vatamt4b			Param=text</C>

		<C>Col=VENDCNT			Ctrl=gcem_vendcnt4a			Param=text</C>
		<C>Col=SHTCNT				Ctrl=gcem_shtcnt4a			Param=text</C>
		<C>Col=REQAMT				Ctrl=gcem_reqamt4a			Param=text</C>
		<C>Col=VATAMT				Ctrl=gcem_vatamt4a			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__">
 <!-- 전자세금계산서분  -->
<object  id=gcbn_data8 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data6>
	<param name=BindInfo		value='  
		<C>Col=VENDCNT1			Ctrl=gcem_vendcnt4c_e			Param=text</C>
		<C>Col=SHTCNT1			Ctrl=gcem_shtcnt4c_e			Param=text</C>
		<C>Col=REQAMT1			Ctrl=gcem_reqamt4c_e			Param=text</C>
		<C>Col=VATAMT1			Ctrl=gcem_vatamt4c_e			Param=text</C>

		<C>Col=VENDCNT2			Ctrl=gcem_vendcnt4b_e			Param=text</C>
		<C>Col=SHTCNT2			Ctrl=gcem_shtcnt4b_e			Param=text</C>
		<C>Col=REQAMT2			Ctrl=gcem_reqamt4b_e			Param=text</C>
		<C>Col=VATAMT2			Ctrl=gcem_vatamt4b_e			Param=text</C>

		<C>Col=VENDCNT			Ctrl=gcem_vendcnt4a_e			Param=text</C>
		<C>Col=SHTCNT				Ctrl=gcem_shtcnt4a_e			Param=text</C>
		<C>Col=REQAMT				Ctrl=gcem_reqamt4a_e			Param=text</C>
		<C>Col=VATAMT				Ctrl=gcem_vatamt4a_e			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [매출]
------------------------------------------------------------------------------>

<comment id="__NSID__"><object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data3>
	<param name=BindInfo		value='  
		<C>Col=VENDIDVS			Ctrl=gcem_vendid2				Param=text</C>
		<C>Col=VENDNAME			Ctrl=gcem_vendnm2				Param=text</C>
		<C>Col=VD_DIRECT	  Ctrl=gcem_vddirect2			Param=text</C>
		<C>Col=ADDRESS1		  Ctrl=gcem_addrs2				Param=text</C>
		<C>Col=BSNS_CND		  Ctrl=gcem_bsnscnd2			Param=text</C>
		<C>Col=BSNS_KND		  Ctrl=gcem_bsnsknd2			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

  <!-- 전자세금계산서 이외의 분 -->
<comment id="__NSID__"><object  id=gcbn_data4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data4>
	<param name=BindInfo		value='  
		<C>Col=VENDCNT1			Ctrl=gcem_vendcnt43			Param=text</C>
		<C>Col=SHTCNT1			Ctrl=gcem_shtcnt43			Param=text</C>
		<C>Col=REQAMT1			Ctrl=gcem_reqamt43			Param=text</C>
		<C>Col=VATAMT1			Ctrl=gcem_vatamt43			Param=text</C>

		<C>Col=VENDCNT2			Ctrl=gcem_vendcnt44			Param=text</C>
		<C>Col=SHTCNT2			Ctrl=gcem_shtcnt44			Param=text</C>
		<C>Col=REQAMT2			Ctrl=gcem_reqamt44			Param=text</C>
		<C>Col=VATAMT2			Ctrl=gcem_vatamt44			Param=text</C>

		<C>Col=VENDCNT				Ctrl=gcem_vendcnt42			Param=text</C>
		<C>Col=SHTCNT				Ctrl=gcem_shtcnt42			Param=text</C>
		<C>Col=REQAMT				Ctrl=gcem_reqamt42			Param=text</C>
		<C>Col=VATAMT				Ctrl=gcem_vatamt42			Param=text</C>
	'>
</object>
</comment><script>__ws__(__NSID__);</script> 

<!-- 전자세금계산서분  -->
<comment id="__NSID__">
<object  id=gcbn_data6 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data7>
	<param name=BindInfo		value='  
		<C>Col=VENDCNT1			Ctrl=gcem_vendcnt43_e			Param=text</C>
		<C>Col=SHTCNT1			Ctrl=gcem_shtcnt43_e			Param=text</C>
		<C>Col=REQAMT1			Ctrl=gcem_reqamt43_e			Param=text</C>
		<C>Col=VATAMT1			Ctrl=gcem_vatamt43_e			Param=text</C>

		<C>Col=VENDCNT2			Ctrl=gcem_vendcnt44_e			Param=text</C>
		<C>Col=SHTCNT2			Ctrl=gcem_shtcnt44_e			Param=text</C>
		<C>Col=REQAMT2			Ctrl=gcem_reqamt44_e			Param=text</C>
		<C>Col=VATAMT2			Ctrl=gcem_vatamt44_e			Param=text</C>

		<C>Col=VENDCNT			Ctrl=gcem_vendcnt42_e			Param=text</C>
		<C>Col=SHTCNT				Ctrl=gcem_shtcnt42_e			Param=text</C>
		<C>Col=REQAMT				Ctrl=gcem_reqamt42_e			Param=text</C>
		<C>Col=VATAMT				Ctrl=gcem_vatamt42_e			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_temp01">
	<param NAME="DetailDataID"			VALUE="gcds_temp02">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">	
<!-- 	<param name="SuppressColumns"				VALUE="1:pageskip,ACTDAT"> -->
	<PARAM NAME="Format"                VALUE="
<A>ID=Area_01,left=0,top=0,right=2000,bottom=179,size=12,penwidth=2
  <R>ID='subtype1.sbt',left=0,top=22,right=1100,bottom=178,MasterDataID='gcds_temp01'

<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1952 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=40 ,top=1807 ,right=1961 ,bottom=1953 ,border=true ,penstyle=solid ,penwidth=3</X>
	<X>left=40 ,top=119 ,right=1961 ,bottom=669 ,border=true ,penstyle=solid ,penwidth=3</X>
	<C>id='SACCYYQT', left=1042, top=233, right=1111, bottom=296, face='Arial', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1958 ,top=394 ,right=40 ,bottom=394 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='1. 제출자 인적사항' ,left=50 ,top=318 ,right=492 ,bottom=384 ,align='left' ,face='Arial' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='VEND_ID', left=447, top=407, right=990, bottom=474, align='left' ,mask='XXX-XX-XXXXX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VEND_NM', left=1408, top=407, right=1950, bottom=474, align='left', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VD_DIRECT', left=447, top=503, right=990, bottom=569, align='left', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=1408, top=503, right=1950, bottom=569, align='left', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WRDT', left=1408, top=595, right=1953, bottom=661, align='left' ,mask='XXXX/XX/XX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')' ,left=1138 ,top=233 ,right=1164 ,bottom=296 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(' ,left=839 ,top=233 ,right=865 ,bottom=296 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SACCYY', left=857, top=233, right=1000, bottom=296, face='Arial', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='년' ,left=982 ,top=233 ,right=1035 ,bottom=296 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기' ,left=1087 ,top=233 ,right=1140 ,bottom=296 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6) 작  성  일  자' ,left=1011 ,top=595 ,right=1384 ,bottom=661 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3) 성   명  (대 표 자)' ,left=50 ,top=505 ,right=423 ,bottom=572 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2) 상   호   (법 인 명)' ,left=1011 ,top=410 ,right=1384 ,bottom=476 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4) 사 업 장 소 재 지' ,left=1011 ,top=503 ,right=1384 ,bottom=569 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5) 거  래  기  간' ,left=50 ,top=595 ,right=423 ,bottom=661 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1) 사업자 등록 번호' ,left=50 ,top=410 ,right=423 ,bottom=476 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=437 ,top=394 ,right=437 ,bottom=664 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=577 ,right=40 ,bottom=577 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=482 ,right=42 ,bottom=484 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='매입처별 세금계산서 합계표(갑)' ,left=643 ,top=153 ,right=1357 ,bottom=220 ,face='Arial' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[별지 제20호의 2 서식(1)]' ,left=50 ,top=50 ,right=537 ,bottom=116 ,align='left' ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1394 ,top=397 ,right=1394 ,bottom=667 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1000 ,top=397 ,right=1000 ,bottom=667 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='TAXTERMTO', left=680, top=595, right=905, bottom=661, align='left' ,mask='XXXX/XX/XX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='~' ,left=640 ,top=595 ,right=683 ,bottom=661 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAXTERMFR', left=447, top=595, right=640, bottom=661, align='left' ,mask='XXXX/XX/XX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='일' ,left=1781 ,top=1892 ,right=1828 ,bottom=1942 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='천' ,left=1699 ,top=1892 ,right=1746 ,bottom=1942 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='백만' ,left=1582 ,top=1892 ,right=1656 ,bottom=1942 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='십억' ,left=1500 ,top=1892 ,right=1574 ,bottom=1942 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조' ,left=1442 ,top=1892 ,right=1490 ,bottom=1942 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일' ,left=1349 ,top=1889 ,right=1397 ,bottom=1939 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='천' ,left=1267 ,top=1889 ,right=1315 ,bottom=1939 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='백만' ,left=1151 ,top=1889 ,right=1225 ,bottom=1939 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='십억' ,left=1069 ,top=1889 ,right=1143 ,bottom=1939 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조' ,left=1011 ,top=1889 ,right=1058 ,bottom=1939 ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 매입처별 명세(합계금액으로 기재)' ,left=50 ,top=1733 ,right=852 ,bottom=1799 ,align='left' ,face='Arial' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)공급가액' ,left=971 ,top=1823 ,right=1405 ,bottom=1879 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)' ,left=833 ,top=1823 ,right=950 ,bottom=1879 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)사업자' ,left=209 ,top=1823 ,right=434 ,bottom=1879 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)세  액' ,left=1453 ,top=1823 ,right=1818 ,bottom=1879 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1852 ,top=1863 ,right=1953 ,bottom=1918 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번 호' ,left=45 ,top=1889 ,right=185 ,bottom=1945 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)일련' ,left=45 ,top=1823 ,right=185 ,bottom=1879 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등록번 호' ,left=209 ,top=1889 ,right=434 ,bottom=1945 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)' ,left=468 ,top=1823 ,right=812 ,bottom=1879 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상 호 (법인명)' ,left=468 ,top=1889 ,right=812 ,bottom=1945 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='매수' ,left=833 ,top=1889 ,right=950 ,bottom=1945 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1844 ,top=1807 ,right=1844 ,bottom=1953 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=1807 ,right=1421 ,bottom=1953 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=958 ,top=1807 ,right=958 ,bottom=1953 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=826 ,top=1807 ,right=826 ,bottom=1953 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=445 ,top=1807 ,right=445 ,bottom=1953 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=191 ,top=1807 ,right=191 ,bottom=1953 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='SHTCNT', left=751, top=1590, right=881, bottom=1640, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT2', left=751, top=1498, right=881, bottom=1548, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT1', left=751, top=1384, right=881, bottom=1434, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT_E', left=751, top=1283, right=881, bottom=1334, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT2_E', left=751, top=1199, right=881, bottom=1249, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT1_E', left=751, top=1093, right=881, bottom=1143, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전자세금계산서수취분' ,left=58 ,top=1140 ,right=283 ,bottom=1251 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<L> left=37 ,top=1654 ,right=1958 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='VATAMT', left=1418, top=1588, right=1908, bottom=1638, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT', left=902, top=1588, right=1376, bottom=1638, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT', left=622, top=1590, right=722, bottom=1640, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소 계' ,left=304 ,top=1593 ,right=566 ,bottom=1643 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전자세금계산서이외수취분' ,left=58 ,top=1450 ,right=283 ,bottom=1625 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<C>id='VATAMT2', left=1418, top=1495, right=1908, bottom=1545, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT2', left=902, top=1495, right=1376, bottom=1545, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT2', left=622, top=1498, right=722, bottom=1548, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='발행분' ,left=304 ,top=1513 ,right=566 ,bottom=1564 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='주민등록번호' ,left=304 ,top=1463 ,right=566 ,bottom=1521 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='사업자등록' ,left=302 ,top=1349 ,right=564 ,bottom=1408 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='번호 발행분' ,left=302 ,top=1400 ,right=564 ,bottom=1450 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<C>id='VATAMT1', left=1418, top=1384, right=1908, bottom=1434, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT1', left=902, top=1384, right=1376, bottom=1434, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT1', left=622, top=1384, right=722, bottom=1434, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=37 ,top=1341 ,right=1958 ,bottom=1341 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='VATAMT_E', left=1418, top=1281, right=1908, bottom=1331, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT_E', left=902, top=1281, right=1376, bottom=1331, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT_E', left=622, top=1283, right=722, bottom=1334, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소 계' ,left=304 ,top=1286 ,right=566 ,bottom=1336 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=302 ,top=1164 ,right=564 ,bottom=1222 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='발행분' ,left=302 ,top=1214 ,right=564 ,bottom=1265 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<C>id='VATAMT2_E', left=1418, top=1196, right=1908, bottom=1246, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT2_E', left=902, top=1196, right=1376, bottom=1246, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT2_E', left=622, top=1199, right=722, bottom=1249, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=291 ,top=1159 ,right=1955 ,bottom=1159 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='사업자등록' ,left=302 ,top=1056 ,right=564 ,bottom=1114 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<T>id='번호 발행분' ,left=302 ,top=1106 ,right=564 ,bottom=1156 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
	<C>id='VATAMT1_E', left=1418, top=1093, right=1908, bottom=1143, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT1_E', left=902, top=1093, right=1376, bottom=1143, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT1_E', left=622, top=1093, right=722, bottom=1143, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=37 ,top=1042 ,right=1958 ,bottom=1042 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=291 ,top=1045 ,right=291 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='VATAMT_SUM', left=1418, top=979, right=1908, bottom=1029, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT_SUM', left=902, top=979, right=1376, bottom=1029, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT_SUM', left=751, top=979, right=881, bottom=1029, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCNT_SUM', left=622, top=979, right=722, bottom=1029, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='합 계' ,left=56 ,top=979 ,right=558 ,bottom=1029 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=37 ,top=958 ,right=1958 ,bottom=958 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='구 분' ,left=56 ,top=865 ,right=558 ,bottom=915 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7) ' ,left=579 ,top=847 ,right=749 ,bottom=897 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='매입처수' ,left=579 ,top=892 ,right=749 ,bottom=942 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8)' ,left=773 ,top=847 ,right=873 ,bottom=897 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='매수' ,left=773 ,top=897 ,right=873 ,bottom=947 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일' ,left=1868 ,top=900 ,right=1916 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='천' ,left=1781 ,top=900 ,right=1828 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='백만' ,left=1654 ,top=900 ,right=1728 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='십억' ,left=1550 ,top=900 ,right=1625 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10) 세                   액' ,left=1429 ,top=849 ,right=1910 ,bottom=900 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조' ,left=1471 ,top=900 ,right=1519 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9) 공 급 가 액' ,left=894 ,top=849 ,right=1376 ,bottom=900 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일' ,left=1334 ,top=900 ,right=1381 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='천' ,left=1249 ,top=900 ,right=1296 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='백만' ,left=1127 ,top=900 ,right=1201 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='십억' ,left=1035 ,top=900 ,right=1109 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조' ,left=960 ,top=900 ,right=1008 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=37 ,top=833 ,right=1958 ,bottom=833 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=40 ,top=833 ,right=40 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1958 ,top=833 ,right=1958 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1400 ,top=833 ,right=1400 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=577 ,top=833 ,right=577 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=746 ,top=833 ,right=746 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=886 ,top=833 ,right=886 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=291 ,top=1270 ,right=1955 ,bottom=1270 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=291 ,top=1455 ,right=1955 ,bottom=1455 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=291 ,top=1569 ,right=1955 ,bottom=1569 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='2. 매입세금계산서 총합계' ,left=45 ,top=765 ,right=651 ,bottom=820 ,align='left' ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=100 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=40 ,top=0 ,right=1961 ,bottom=101 ,border=true ,penstyle=solid ,penwidth=3</X>
	<C>id='', left=1852, top=5, right=1953, bottom=93, align='right'</C>
	<C>id='VATAMT', left=1453, top=5, right=1823, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT', left=971, top=5, right=1394, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT', left=833, top=5, right=950, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNAME', left=468, top=5, right=812, bottom=93, align='left'</C>
	<C>id='VENDIDVS', left=209, top=5, right=434, bottom=93 ,mask='XXX-XX-XXXXX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURROW', left=45, top=5, right=185, bottom=93, face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1844 ,top=0 ,right=1844 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=0 ,right=1421 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=958 ,top=0 ,right=958 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=826 ,top=0 ,right=826 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=445 ,top=0 ,right=445 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=191 ,top=0 ,right=191 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1315 ,top=64 ,right=1315 ,bottom=101 </L>
	<L> left=1228 ,top=64 ,right=1228 ,bottom=101 </L>
	<L> left=1140 ,top=64 ,right=1140 ,bottom=101 </L>
	<L> left=1053 ,top=64 ,right=1053 ,bottom=101 </L>
	<L> left=1482 ,top=64 ,right=1482 ,bottom=101 </L>
	<L> left=1569 ,top=64 ,right=1569 ,bottom=101 </L>
	<L> left=1656 ,top=64 ,right=1656 ,bottom=101 </L>
	<L> left=1744 ,top=64 ,right=1744 ,bottom=101 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=275 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1095 ,top=172 ,right=1961 ,bottom=251 ,border=true ,penstyle=solid ,penwidth=3</X>
	<X>left=40 ,top=0 ,right=1961 ,bottom=132 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='(   1   ) 쪽' ,left=1712 ,top=5 ,right=1950 ,bottom=45 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='95. 1. 25 승인' ,left=50 ,top=85 ,right=262 ,bottom=124 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='22226-54721일' ,left=50 ,top=42 ,right=288 ,bottom=82 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1527 ,top=175 ,right=1527 ,bottom=251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='17) 관리번호(매입)' ,left=1114 ,top=180 ,right=1511 ,bottom=246</T>
	<T>id='[인쇄용지(특급)70g/㎡]' ,left=1651 ,top=77 ,right=1950 ,bottom=124 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210mmX297mm' ,left=1712 ,top=40 ,right=1950 ,bottom=82 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

  </R>
</A>

<A>ID=Area_02,left=0,top=0,right=2000,bottom=179,size=12,penwidth=2
  <R>ID='subtype2.sbt',left=0,top=22,right=1100,bottom=178,DetailDataID='gcds_temp03'

<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=545 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=40 ,top=106 ,right=1961 ,bottom=545 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='[별지 제33호 서식(2)]' ,left=50 ,top=24 ,right=537 ,bottom=90 ,align='left' ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=1138 ,top=220 ,right=1164 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기' ,left=1087 ,top=220 ,right=1140 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SACCYYQT', left=1042, top=220, right=1111, bottom=283, face='Arial', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='년' ,left=982 ,top=220 ,right=1035 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SACCYY', left=857, top=220, right=1000, bottom=283, face='Arial', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=839 ,top=220 ,right=865 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='매입처별 세금계산서 합계표(을)' ,left=643 ,top=140 ,right=1357 ,bottom=206 ,face='Arial' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=45 ,top=402 ,right=1961 ,bottom=402 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='15)공급가액' ,left=971 ,top=421 ,right=1405 ,bottom=476 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='14)' ,left=833 ,top=421 ,right=950 ,bottom=476 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12)사업자' ,left=209 ,top=421 ,right=434 ,bottom=476 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)세  액' ,left=1453 ,top=421 ,right=1818 ,bottom=476 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1852 ,top=460 ,right=1953 ,bottom=516 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번 호' ,left=45 ,top=487 ,right=185 ,bottom=542 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11)일련' ,left=45 ,top=421 ,right=185 ,bottom=476 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등록번 호' ,left=209 ,top=487 ,right=434 ,bottom=542 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='13)' ,left=468 ,top=421 ,right=812 ,bottom=476 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상 호 (법인명)' ,left=468 ,top=487 ,right=812 ,bottom=542 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='매수' ,left=833 ,top=487 ,right=950 ,bottom=542 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1844 ,top=405 ,right=1844 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=405 ,right=1421 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=958 ,top=405 ,right=958 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=826 ,top=405 ,right=826 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=445 ,top=405 ,right=445 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=191 ,top=405 ,right=191 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='VEND_ID', left=1400, top=323, right=1942, bottom=389, align='left' ,mask='XXX-XX-XXXXX', face='Arial', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1) 사업자 등록 번호' ,left=1003 ,top=323 ,right=1376 ,bottom=389 ,align='left' ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=995 ,top=318 ,right=1961 ,bottom=318 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=995 ,top=392 ,right=1961 ,bottom=392 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=995 ,top=318 ,right=995 ,bottom=392 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1389 ,top=320 ,right=1389 ,bottom=394 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=101 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=40 ,top=0 ,right=1961 ,bottom=101 ,border=true ,penstyle=solid ,penwidth=3</X>
	<C>id='', left=1852, top=5, right=1953, bottom=93, align='right'</C>
	<C>id='VATAMT', left=1453, top=5, right=1823, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT', left=971, top=5, right=1394, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SHTCNT', left=833, top=5, right=950, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNAME', left=468, top=5, right=812, bottom=93, align='left'</C>
	<C>id='VENDIDVS', left=209, top=5, right=434, bottom=93 ,mask='XXX-XX-XXXXX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURROW', left=45, top=5, right=185, bottom=93, face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=191 ,top=0 ,right=191 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=445 ,top=0 ,right=445 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=826 ,top=0 ,right=826 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=958 ,top=0 ,right=958 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=0 ,right=1421 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1844 ,top=0 ,right=1844 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1228 ,top=64 ,right=1228 ,bottom=101 </L>
	<L> left=1140 ,top=64 ,right=1140 ,bottom=101 </L>
	<L> left=1053 ,top=64 ,right=1053 ,bottom=101 </L>
	<L> left=1482 ,top=64 ,right=1482 ,bottom=101 </L>
	<L> left=1569 ,top=64 ,right=1569 ,bottom=101 </L>
	<L> left=1656 ,top=64 ,right=1656 ,bottom=101 </L>
	<L> left=1744 ,top=64 ,right=1744 ,bottom=101 </L>
	<L> left=1315 ,top=64 ,right=1315 ,bottom=101 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=276 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1095 ,top=172 ,right=1961 ,bottom=251 ,border=true ,penstyle=solid ,penwidth=3</X>
	<X>left=40 ,top=0 ,right=1961 ,bottom=132 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='210mmX297mm' ,left=1712 ,top=37 ,right=1950 ,bottom=79 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(        ) 쪽' ,left=1712 ,top=5 ,right=1950 ,bottom=45 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[인쇄용지(특급)70g/㎡]' ,left=1651 ,top=71 ,right=1950 ,bottom=119 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1527 ,top=175 ,right=1527 ,bottom=251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='관리번호(매입)' ,left=1114 ,top=180 ,right=1511 ,bottom=246</T>
	<T>id='       경우에 사용합니다.' ,left=50 ,top=71 ,right=495 ,bottom=111 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FLAG', left=1847, top=3, right=1892, bottom=53</C>
	<T>id='※   이 서식은 매입처가 6개 이상으로서 매입처별세금계산서합계표(갑)을 초과하는' ,left=50 ,top=16 ,right=1619 ,bottom=56 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


  </R>

</A>


">
</object></comment><script>__ws__(__NSID__);</script> 


<!-- 매출 -->
<comment id="__NSID__"><object  id="gcrp_print2" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_temp04">
	<param NAME="DetailDataID"			VALUE="gcds_temp05">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="false">
 	<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="true">	 
<!-- 	<param name="SuppressColumns"				VALUE="1:pageskip,ACTDAT"> -->
	<PARAM NAME="Format"                VALUE="
<A>ID=Area_01,left=0,top=0,right=2000,bottom=179,size=12,penwidth=2
  <R>ID='subtype1.sbt',left=0,top=22,right=1100,bottom=178,MasterDataID='gcds_temp04'

	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1926 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=40 ,top=124 ,right=1961 ,bottom=587 ,border=true ,penstyle=solid ,penwidth=3</X>
		<X>left=40 ,top=1778 ,right=1961 ,bottom=1924 ,border=true ,penstyle=solid ,penwidth=3</X>
		<C>id='SACCYYQT', left=1042, top=233, right=1111, bottom=296, face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='1. 제출자 인적사항' ,left=50 ,top=318 ,right=492 ,bottom=373 ,align='left' ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id=')' ,left=1138 ,top=233 ,right=1164 ,bottom=296 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(' ,left=839 ,top=233 ,right=865 ,bottom=296 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='SACCYY', left=857, top=233, right=1000, bottom=296, face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='년' ,left=982 ,top=233 ,right=1035 ,bottom=296 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기' ,left=1087 ,top=233 ,right=1140 ,bottom=296 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='매출처별 세금계산서 합계표(갑)' ,left=643 ,top=153 ,right=1357 ,bottom=220 ,face='Arial' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='[별지 제20호의 2 서식(1)]' ,left=50 ,top=50 ,right=537 ,bottom=116 ,align='left' ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1958 ,top=378 ,right=40 ,bottom=378 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1394 ,top=378 ,right=1394 ,bottom=585 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=188 ,top=1778 ,right=188 ,bottom=1924 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='일' ,left=1778 ,top=1863 ,right=1826 ,bottom=1913 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='천' ,left=1696 ,top=1863 ,right=1744 ,bottom=1913 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=960 ,top=1778 ,right=960 ,bottom=1924 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1421 ,top=1778 ,right=1421 ,bottom=1924 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1844 ,top=1778 ,right=1844 ,bottom=1924 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='매수' ,left=833 ,top=1860 ,right=950 ,bottom=1916 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='상 호 (법인명)' ,left=468 ,top=1860 ,right=812 ,bottom=1916 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='13)' ,left=468 ,top=1794 ,right=812 ,bottom=1849 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='등록번 호' ,left=209 ,top=1860 ,right=434 ,bottom=1916 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='11)일련' ,left=45 ,top=1794 ,right=185 ,bottom=1849 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='번 호' ,left=45 ,top=1860 ,right=185 ,bottom=1916 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='비고' ,left=1852 ,top=1834 ,right=1953 ,bottom=1889 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='16)세  액' ,left=1453 ,top=1794 ,right=1818 ,bottom=1849 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='12)사업자' ,left=209 ,top=1794 ,right=434 ,bottom=1849 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='14)' ,left=833 ,top=1794 ,right=950 ,bottom=1849 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='15)공급가액' ,left=971 ,top=1794 ,right=1405 ,bottom=1849 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='3. 매출처별 명세(합계금액으로 기재)' ,left=50 ,top=1704 ,right=852 ,bottom=1770 ,align='left' ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='조' ,left=1011 ,top=1860 ,right=1058 ,bottom=1910 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='십억' ,left=1069 ,top=1860 ,right=1143 ,bottom=1910 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='백만' ,left=1151 ,top=1860 ,right=1225 ,bottom=1910 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='천' ,left=1267 ,top=1860 ,right=1315 ,bottom=1910 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='일' ,left=1349 ,top=1860 ,right=1397 ,bottom=1910 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='조' ,left=1442 ,top=1863 ,right=1490 ,bottom=1913 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='십억' ,left=1500 ,top=1863 ,right=1574 ,bottom=1913 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='백만' ,left=1582 ,top=1863 ,right=1656 ,bottom=1913 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=40 ,top=1574 ,right=1961 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='VATAMT', left=1421, top=1508, right=1910, bottom=1558, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT', left=905, top=1508, right=1378, bottom=1558, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT', left=624, top=1511, right=725, bottom=1561, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='소 계' ,left=307 ,top=1513 ,right=569 ,bottom=1564 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='전자세금계산서이외발행분' ,left=61 ,top=1371 ,right=286 ,bottom=1545 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<C>id='VATAMT2', left=1421, top=1416, right=1910, bottom=1466, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT2', left=905, top=1416, right=1378, bottom=1466, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT2', left=624, top=1418, right=725, bottom=1468, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=445 ,top=1773 ,right=445 ,bottom=1918 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='발행분' ,left=307 ,top=1434 ,right=569 ,bottom=1484 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<T>id='주민등록번호' ,left=307 ,top=1384 ,right=569 ,bottom=1442 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<T>id='사업자등록' ,left=304 ,top=1270 ,right=566 ,bottom=1328 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<T>id='번호 발행분' ,left=304 ,top=1320 ,right=566 ,bottom=1371 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<C>id='VATAMT1', left=1421, top=1304, right=1910, bottom=1355, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT1', left=905, top=1304, right=1378, bottom=1355, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT1', left=624, top=1304, right=725, bottom=1355, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=40 ,top=1262 ,right=1961 ,bottom=1262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='VATAMT_E', left=1421, top=1201, right=1910, bottom=1251, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT_E', left=905, top=1201, right=1378, bottom=1251, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT_E', left=624, top=1204, right=725, bottom=1254, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='소 계' ,left=307 ,top=1207 ,right=569 ,bottom=1257 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주민등록번호' ,left=304 ,top=1085 ,right=566 ,bottom=1143 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<T>id='발행분' ,left=304 ,top=1135 ,right=566 ,bottom=1185 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<C>id='VATAMT2_E', left=1421, top=1117, right=1910, bottom=1167, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT2_E', left=905, top=1117, right=1378, bottom=1167, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT2_E', left=624, top=1119, right=725, bottom=1169, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=294 ,top=1080 ,right=1958 ,bottom=1080 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='사업자등록' ,left=304 ,top=976 ,right=566 ,bottom=1035 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<T>id='번호 발행분' ,left=304 ,top=1027 ,right=566 ,bottom=1077 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<C>id='VATAMT1_E', left=1421, top=1013, right=1910, bottom=1064, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT1_E', left=905, top=1013, right=1378, bottom=1064, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT1_E', left=624, top=1013, right=725, bottom=1064, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='전자세금계산서발행분' ,left=61 ,top=1016 ,right=286 ,bottom=1191 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Multiline=true</T>
		<L> left=40 ,top=963 ,right=1961 ,bottom=963 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=294 ,top=966 ,right=294 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='VATAMT_SUM', left=1421, top=900, right=1910, bottom=950, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT_SUM', left=905, top=900, right=1378, bottom=950, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT_SUM', left=757, top=900, right=886, bottom=950, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDCNT_SUM', left=624, top=900, right=725, bottom=950, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='합 계' ,left=58 ,top=900 ,right=561 ,bottom=950 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=40 ,top=878 ,right=1961 ,bottom=878 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='구 분' ,left=58 ,top=786 ,right=561 ,bottom=836 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=826 ,top=1778 ,right=826 ,bottom=1924 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='7) ' ,left=582 ,top=767 ,right=751 ,bottom=818 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='매출처수' ,left=582 ,top=812 ,right=751 ,bottom=863 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='8)' ,left=778 ,top=767 ,right=878 ,bottom=818 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='매수' ,left=778 ,top=818 ,right=878 ,bottom=868 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='일' ,left=1871 ,top=820 ,right=1918 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='천' ,left=1783 ,top=820 ,right=1831 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='백만' ,left=1656 ,top=820 ,right=1730 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='십억' ,left=1553 ,top=820 ,right=1627 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='10) 세                   액' ,left=1431 ,top=770 ,right=1913 ,bottom=820 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='조' ,left=1474 ,top=820 ,right=1521 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='9) 공 급 가 액' ,left=897 ,top=770 ,right=1378 ,bottom=820 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='일' ,left=1336 ,top=820 ,right=1384 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='천' ,left=1251 ,top=820 ,right=1299 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='백만' ,left=1130 ,top=820 ,right=1204 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='십억' ,left=1037 ,top=820 ,right=1111 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='조' ,left=963 ,top=820 ,right=1011 ,bottom=870 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=40 ,top=754 ,right=1961 ,bottom=754 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=42 ,top=754 ,right=42 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1961 ,top=754 ,right=1961 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1402 ,top=754 ,right=1402 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=579 ,top=754 ,right=579 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=749 ,top=754 ,right=749 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=892 ,top=754 ,right=892 ,bottom=1574 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=294 ,top=1191 ,right=1958 ,bottom=1191 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=294 ,top=1376 ,right=1958 ,bottom=1376 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=294 ,top=1490 ,right=1958 ,bottom=1490 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='2. 매출세금계산서 총합계' ,left=48 ,top=685 ,right=654 ,bottom=741 ,align='left' ,face='Arial' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='WRDT', left=1402, top=532, right=1947, bottom=582, align='left' ,mask='XXXX/XX/XX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='6) 작  성  일  자' ,left=1008 ,top=529 ,right=1381 ,bottom=579 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='TAXTERMTO', left=654, top=529, right=878, bottom=579, align='left' ,mask='XXXX/XX/XX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='5) 거  래  기  간' ,left=50 ,top=529 ,right=423 ,bottom=579 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1958 ,top=519 ,right=40 ,bottom=519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='3) 성   명  (대 표 자)' ,left=50 ,top=460 ,right=423 ,bottom=511 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='VD_DIRECT', left=445, top=460, right=987, bottom=511, align='left', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='4) 사 업 장 소 재 지' ,left=1008 ,top=460 ,right=1381 ,bottom=511 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ADDRESS1', left=1402, top=460, right=1945, bottom=511, align='left', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1958 ,top=445 ,right=42 ,bottom=447 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='1) 사업자 등록 번호' ,left=45 ,top=389 ,right=418 ,bottom=439 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='VEND_ID', left=442, top=389, right=984, bottom=439, align='left' ,mask='XXX-XX-XXXXX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='2) 상   호   (법 인 명)' ,left=1005 ,top=389 ,right=1378 ,bottom=439 ,align='left' ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='VEND_NM', left=1402, top=389, right=1945, bottom=439, align='left', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=997 ,top=378 ,right=997 ,bottom=585 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=431 ,top=378 ,right=431 ,bottom=585 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='~' ,left=611 ,top=529 ,right=654 ,bottom=579 ,face='Arial' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='TAXTERMFR', left=447, top=529, right=611, bottom=579, align='left' ,mask='XXXX/XX/XX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT1_E', left=757, top=1013, right=886, bottom=1064, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT2_E', left=757, top=1119, right=886, bottom=1169, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT_E', left=757, top=1204, right=886, bottom=1254, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT1', left=757, top=1304, right=886, bottom=1355, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT2', left=757, top=1418, right=886, bottom=1468, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT', left=757, top=1511, right=886, bottom=1561, align='right', face='Lucida Console', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=106 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=40 ,top=0 ,right=1961 ,bottom=101 ,border=true ,penstyle=solid ,penwidth=3</X>
		<C>id='', left=1852, top=5, right=1953, bottom=93, align='right'</C>
		<C>id='VATAMT', left=1453, top=5, right=1823, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='REQAMT', left=971, top=5, right=1394, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='SHTCNT', left=833, top=5, right=950, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='VENDNAME', left=468, top=5, right=812, bottom=93, align='left'</C>
		<C>id='VENDIDVS', left=209, top=5, right=434, bottom=93 ,mask='XXX-XX-XXXXX', face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURROW', left=45, top=5, right=185, bottom=93, face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1844 ,top=0 ,right=1844 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1421 ,top=0 ,right=1421 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=958 ,top=0 ,right=958 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=826 ,top=0 ,right=826 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=445 ,top=0 ,right=445 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=191 ,top=0 ,right=191 ,bottom=101 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1315 ,top=64 ,right=1315 ,bottom=101 </L>
		<L> left=1228 ,top=64 ,right=1228 ,bottom=101 </L>
		<L> left=1140 ,top=64 ,right=1140 ,bottom=101 </L>
		<L> left=1053 ,top=64 ,right=1053 ,bottom=101 </L>
		<L> left=1482 ,top=64 ,right=1482 ,bottom=101 </L>
		<L> left=1569 ,top=64 ,right=1569 ,bottom=101 </L>
		<L> left=1656 ,top=64 ,right=1656 ,bottom=101 </L>
		<L> left=1744 ,top=64 ,right=1744 ,bottom=101 </L>
	</B>
	<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=278 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=1095 ,top=172 ,right=1961 ,bottom=251 ,border=true ,penstyle=solid ,penwidth=3</X>
		<X>left=40 ,top=0 ,right=1961 ,bottom=132 ,border=true ,penstyle=solid ,penwidth=3</X>
		<T>id='(   1   ) 쪽' ,left=1712 ,top=5 ,right=1950 ,bottom=45 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='95. 1. 25 승인' ,left=50 ,top=85 ,right=262 ,bottom=124 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='22226-54721일' ,left=50 ,top=42 ,right=288 ,bottom=82 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1527 ,top=175 ,right=1527 ,bottom=251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='17) 관리번호(매출)' ,left=1114 ,top=180 ,right=1511 ,bottom=246</T>
		<T>id='[인쇄용지(특급)70g/㎡]' ,left=1651 ,top=77 ,right=1950 ,bottom=124 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='210mmX297mm' ,left=1712 ,top=40 ,right=1950 ,bottom=82 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	</B>

  </R>
</A>

<A>ID=Area_02,left=0,top=0,right=2000,bottom=179,size=12,penwidth=2
  <R>ID='subtype2.sbt',left=0,top=22,right=1100,bottom=178,DetailDataID='gcds_temp06'

<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=545 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=40 ,top=106 ,right=1961 ,bottom=545 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='[별지 제33호 서식(2)]' ,left=50 ,top=24 ,right=537 ,bottom=90 ,align='left' ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=1138 ,top=220 ,right=1164 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기' ,left=1087 ,top=220 ,right=1140 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SACCYYQT', left=1042, top=220, right=1111, bottom=283, face='Arial', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='년' ,left=982 ,top=220 ,right=1035 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SACCYY', left=857, top=220, right=1000, bottom=283, face='Arial', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=839 ,top=220 ,right=865 ,bottom=283 ,face='Arial' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='매출처별 세금계산서 합계표(을)' ,left=643 ,top=140 ,right=1357 ,bottom=206 ,face='Arial' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=45 ,top=402 ,right=1961 ,bottom=402 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='15)공급가액' ,left=971 ,top=421 ,right=1405 ,bottom=476</T>
	<T>id='14' ,left=833 ,top=421 ,right=950 ,bottom=476</T>
	<T>id='12)사업자' ,left=209 ,top=421 ,right=434 ,bottom=476</T>
	<T>id='16)세  액' ,left=1453 ,top=421 ,right=1818 ,bottom=476</T>
	<T>id='비고' ,left=1852 ,top=460 ,right=1953 ,bottom=516</T>
	<T>id='번 호' ,left=45 ,top=487 ,right=185 ,bottom=542</T>
	<T>id='11)일련' ,left=45 ,top=421 ,right=185 ,bottom=476</T>
	<T>id='등록번 호' ,left=209 ,top=487 ,right=434 ,bottom=542</T>
	<T>id='13)' ,left=468 ,top=421 ,right=812 ,bottom=476</T>
	<T>id='상 호 (법인명)' ,left=468 ,top=487 ,right=812 ,bottom=542</T>
	<T>id='매수' ,left=833 ,top=487 ,right=950 ,bottom=542</T>
	<L> left=1844 ,top=405 ,right=1844 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=405 ,right=1421 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=958 ,top=405 ,right=958 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=826 ,top=405 ,right=826 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=445 ,top=405 ,right=445 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=191 ,top=405 ,right=191 ,bottom=545 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='VEND_ID', left=1400, top=323, right=1942, bottom=389, align='left', face='Arial', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='1) 사업자 등록 번호' ,left=1003 ,top=323 ,right=1376 ,bottom=389 ,align='left' ,face='Arial' ,size=13 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=995 ,top=318 ,right=1961 ,bottom=318 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=995 ,top=392 ,right=1961 ,bottom=392 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=995 ,top=318 ,right=995 ,bottom=392 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1389 ,top=320 ,right=1389 ,bottom=394 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=101 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=40 ,top=0 ,right=1961 ,bottom=101 ,border=true ,penstyle=solid ,penwidth=3</X>
	<C>id='', left=1852, top=5, right=1953, bottom=93, align='right'</C>
	<C>id='VATAMT', left=1453, top=5, right=1823, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQAMT', left=971, top=5, right=1394, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='SHTCNT', left=833, top=5, right=950, bottom=93, align='right', face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNAME', left=468, top=5, right=812, bottom=93, align='left'</C>
	<C>id='VENDIDVS', left=209, top=5, right=434, bottom=93, face='Arial', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURROW', left=45, top=5, right=185, bottom=93, face='Lucida Console', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=191 ,top=0 ,right=191 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=445 ,top=0 ,right=445 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=826 ,top=0 ,right=826 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=958 ,top=0 ,right=958 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1421 ,top=0 ,right=1421 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1844 ,top=0 ,right=1844 ,bottom=100 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1315 ,top=64 ,right=1315 ,bottom=101 </L>
	<L> left=1228 ,top=64 ,right=1228 ,bottom=101 </L>
	<L> left=1140 ,top=64 ,right=1140 ,bottom=101 </L>
	<L> left=1053 ,top=64 ,right=1053 ,bottom=101 </L>
	<L> left=1482 ,top=64 ,right=1482 ,bottom=101 </L>
	<L> left=1569 ,top=64 ,right=1569 ,bottom=101 </L>
	<L> left=1656 ,top=64 ,right=1656 ,bottom=101 </L>
	<L> left=1744 ,top=64 ,right=1744 ,bottom=101 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=276 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1095 ,top=172 ,right=1961 ,bottom=251 ,border=true ,penstyle=solid ,penwidth=3</X>
	<X>left=40 ,top=0 ,right=1961 ,bottom=132 ,border=true ,penstyle=solid ,penwidth=3</X>
	<T>id='210mmX297mm' ,left=1712 ,top=37 ,right=1950 ,bottom=79 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(        ) 쪽' ,left=1712 ,top=5 ,right=1950 ,bottom=45 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[인쇄용지(특급)70g/㎡]' ,left=1651 ,top=71 ,right=1950 ,bottom=119 ,align='right' ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1527 ,top=175 ,right=1527 ,bottom=251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='관리번호(매출)' ,left=1114 ,top=180 ,right=1511 ,bottom=246</T>
	<T>id='※   이 서식은 매출처가 6개 이상으로서 매출처별세금계산서합계표(갑)을 초과하는' ,left=50 ,top=16 ,right=1315 ,bottom=56 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       경우에 사용합니다.' ,left=50 ,top=71 ,right=495 ,bottom=111 ,align='left' ,face='Arial' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FLAG', left=1847, top=3, right=1892, bottom=53</C>
</B>

  </R>

</A>


">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 