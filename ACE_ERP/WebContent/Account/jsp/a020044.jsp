<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  경리회계 - 전표결재	
+ 프로그램 ID	:  A020044.html
+ 기 능 정 의	:  결재요청한 전표를 결재 승인하고 
                              동시에 총계정원장과 합계잔액 테이블에 데이타를 입력한다.
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.02.04
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 1. 예산, 회계 구분하여 조회 ==> 예산결재자인 경우 결재요청 필요(o)
                 2. 전표번호 생성
								 3. 예산집계 테이블 적용
								 4. 자금관련 금액 반영
								 5. 외화 금액 및 환율 반영
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2006.04.21
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 1. 외화 환율변환 프로세스 변경
                 기존 ==> 역사적, 월말, 평균 환율에 달러금액을 일괄적으로 곱해서 구함.
								 변경 ==> 역사적 환율 중 재고자산, 선급비용, 유형자산, 무형자산, 선수수익 등은
								          관리항목 외화금액 필드에 입력된 데이타를 가져옴.

+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2006.11.16
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 1. 결재시 Slipref에 전표번호, 전표일자 update
                 2. 결재시 ACTSGNSTS 에 전표일자 추가 (필드도 추가함)
								 3. 결재취소시 반영해야함.
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2007.05.11
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 회계일자 변경시 예산이 존재할 경우 체크함 (회계년월이 변경 될 경우만 적용)
                 변경
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2007.10.18
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 예산관리자의 경우 판관비관련 전표만 조회 가능하게 함. 
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2010.02.04
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 구분 추가 
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2010.02.07
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 전표결재 조회만 가능하게 함.
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2010.03.03
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>전표결재조회</title>

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
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;

var gs_cashamt =0;        //현금금액
var gs_chadae_gubun="";   //현금계정의 차대 구분 1-현금차변, 2-현금대변
var gs_Eqcashamt =0;      //현금등가물금액
var gs_Eqchadae_gubun=""; //현금등가물계정의 차대 구분 1-현금등가물차변, 2-현금등가물대변
var gs_decash=0;          //차변현금
var gs_Eqcrcash=0;        //대변현금등가물금액
var gs_Eqdecash=0;        //차변현금등가물금액
var gs_crcash=0;        //대변현금
var gs_totcnt=0;        //전기시 선택된 모든 전표를 더함.(현금)
var gs_Etotcnt=0;       //전기시 선택된 모든 전표를 더함.(현금등가물)
var gs_cnt=0;           //전체건수
var gs_failcnt=0;       //총 실패건수
var gs_succcnt=0;       //총 성공건수
var gs_Total_cnt=0;
var gs_gubun=""; //chk 시 click구분


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	ln_Before();
	gcem_fsdat_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + '01';
	gcem_fsdat_to.text = gs_date;
    txt_empno.value = gs_userid;
	txt_empnmk.value = gs_usernm;
    gclx_fsstat.index=2;
	gclx_fdcode.bindcolval=gs_fdcode;
	ln_Count();

	if(gs_fdcode!='02') gclx_fdcode.Enable=false; 
}

function ln_Count(){
  
  //gs_cnt+=1;
  //txt_count.value=gs_cnt+"/"+gs_Total_cnt;
	//setTimeout("ln_Count()", 100);
}

/******************************************************************************
	Description : 로딩
******************************************************************************/
function ln_Before(){
	 //지점
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();

  /**
	//login 자와 결재자 matching확인
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0900&v_str2="+gs_userid;
	//prompt("",gcds_login.DataID);
	gcds_login.Reset();

  if( gcds_login.countrow>0){
		//txt_gubun.value=gcds_login.namevalue(gcds_login.rowposition,"CDREMARK");
		//hid_gubun.value=gcds_login.namevalue(gcds_login.rowposition,"GBCD");
	}else{
		alert("결재자가 아닙니다. 확인바랍니다.");
		return;
	}
	**/

  /**
  //금강산 달러환율
  gcds_exrate.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_exrate_s1?v_str1=02&v_str2=";
	//prompt("",gcds_exrate.DataID);
	gcds_exrate.Reset();
  **/
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  var strempno="";
	var strGubun="";

  //2010.02.04 JYS 회계일자 체크, 지점코드 체크
	if(gclx_fdcode.bindcolval==""){
		alert("지점구분을 선택하십시요!");
		return false;
	}

  /*
  if(gs_userid=="2020009"){
		alert("fr length:::"+gcem_fsdat_fr.text);
		alert("to length:::"+gcem_fsdat_to.text);
	}
	*/
	if(gcem_fsdat_fr.text<="19000101"||gcem_fsdat_to.text<="19000101"){
		alert("회계일자를 확인하십시요!");
		return false;
	}


  if(txt_empno.value=="2050028"){
     strempno="";
	}else{
     strempno=txt_empno.value;
	}

  //2007.05.30 정영식 추가//////////////////////////
	//서울을 제외하고 결재구분에 관계없이 모두 조회함.
	/**
  if(gclx_fdcode.bindcolval=="02"){ //서울
    strGubun = hid_gubun.value;
	}else if(gclx_fdcode.bindcolval=="03"){ //금강산
    strGubun = "01";
	}else if(gclx_fdcode.bindcolval=="04"){ //개성
    strGubun = "01";
	}else{ 
    strGubun = hid_gubun.value;
	}
	**/
	///////////////////////////////////////////////////

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s1?v_str1="+gcem_fsdat_fr.text
																		  +"&v_str2="+gcem_fsdat_to.text
																		  +"&v_str3="+strempno
																		  +"&v_str4="+gclx_fsstat.bindcolval
																		  +"&v_str5="+''//gclx_gubun.bindcolval
																		  +"&v_str6="+gclx_fdcode.bindcolval
																		  +"&v_str7="+txt_remark.value
																		  +"&v_str8="+gclx_gubun.bindcolval //결재 구분 01 -회계, 02-예산, 06-자금	
																		  +"&v_str9=A";		
    //prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();	
	
	gs_cnt=0;
	gs_succcnt=0;
	gs_failcnt=0;
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 체크
	Parameter   :  p - 구분  01 결재, 02, 결재취소, 03 - 반송건
******************************************************************************/
function ln_Chk(p){
	
	if (p=='01'){
    //if(hid_gubun.value=="02") {
		//	alert("예산은 결재 할 수 없습니다.");
		//	return false;
    //}

		for(a=1;a<=gcds_data01.countrow;a++){
			if(gcds_data01.namevalue(a,"CHK")=="T" && gcds_data01.namevalue(a,"ACCSGNEND")=="Y"){
			  alert("결재완료건이 존재합니다. 확인하십시요.");
				return false;
			}

      //2008.07.14. 정영식 추가...전표번호를 임의로 입력할 경우 
			//회계일자 <> 전표번호의 일자가 틀린 경우 체크함.
      if(gcds_data01.namevalue(a,"CHK")=="T"&&gcem_ssdate.text!=""){
			  if(gcds_data01.namevalue(a,"ACTDAT")!=gcem_ssdate.text){
					alert("선택한 데이타의 회계일자와 전표일자가 동일하지 않습니다. 확인하십시요.");
					return false;
				}
			}
		}//for
		return true;
	}

 if (p=='02'){
		//if(hid_gubun.value=="02") {
		//	alert("예산은 결재취소 할 수 없습니다.");
		//	return false;
    // }
		
		for(a=1;a<=gcds_data01.countrow;a++){
			if(gcds_data01.namevalue(a,"CHK")=="T" && gcds_data01.namevalue(a,"ACCSGNEND")!="Y"){
			  alert("결재완료건이 아닙니다. 확인하십시요.");
				return false;
			}
		}

		// 반제데이타 이미 전표 정산전표가 작성 되었을 경우 발생전표 취소못함.
		return true;
	}

	if (p=='03'){
		for(a=1;a<=gcds_data01.countrow;a++){
			if(gcds_data01.namevalue(a,"CHK")=="T" && gcds_data01.namevalue(a,"ACCSGNEND")=="Y"){
			  alert("결재완료건입니다. 확인하십시요.");
				return false;
			}
		}
			return true;
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

  ln_SetDataHeader('01');
  ln_SetDataHeader('09');
	ln_SetDataHeader('10');
	gs_failcnt=0;       //총 실패건수
  gs_succcnt=0;       //총 성공건수


	if(ln_Chk('01')){
	  if(!ln_Chk_Bgt()) return;
		if(confirm("결재하시겠습니까?")){
			ln_Detail();
			ln_Msg(); 
			ln_Query();
			gcds_data03.ClearData();
		}
	}
}

/******************************************************************************
	Description : 전표번호로 전표 Detail데이타를 조회 후 데이타를 넘김
	parameter   :
******************************************************************************/
function ln_Detail(){

	var tempDataSet="";
	var stractyymm = ""; //회계년월
	var strexyymm ="";   //환율기준년월
	var strexrate ="";   //환율	
  gs_Total_cnt=0;

/**
	for(i=1;i<=gcds_data01.countrow;i++){
		if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
      gs_Total_cnt+=1;
		}
	}
**/
  document.all.LowerFrame2.style.visibility="visible";
	for(i=1;i<=gcds_data01.countrow;i++){
		gs_totcnt=0;
		gs_Etotcnt=0;
		tempDataSet="";

		if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
		  gs_cnt+=1;
				
		  gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s2?v_str1="+gcds_data01.namevalue(i,"FDCODE")
			 																    +"&v_str2="+gcds_data01.namevalue(i,"FSDAT")
																			    +"&v_str3="+gcds_data01.namevalue(i,"FSNBR");
       // prompt("",gcds_data02.DataID );																							
	      gcds_data02.Reset();
				
          tempDataSet = gcds_data02.ExportData(1,gcds_data02.CountRow,false);
				gcds_data03.ImportData(tempDataSet);
        
        if(ln_Chk_Cash()){//현금계정체크  (현금원화, 현금외화)
					ln_Cash()
				}

        /* 임시로 막음.
				if(ln_Chk_EqCash()){//현금등가물
				  alert("현금등가물존재");
          ln_EqCash()
				}
				*/


        /****
        var temp1=gcds_data01.namevalue(i,"SSDAT");
				var temp2=gcds_data01.namevalue(i,"SSNBR")

				gcem_gubun.text =temp1.substring(0,1);
				gcem_ssdate.text =temp1.substring(1,9);
				gcem_ssnbr.text =temp1.substring(0,6);
        ****/
  
				ln_Date(i);   //결재일자
				ln_Exrate();  //금강산 환율 적용
        		gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t1?";

				var strssdate="";
				var strssnbr="";

				if(gcem_gubun.text!=""&&gcem_ssdate.text!=""&&gcem_ssnbr.text!=""){
					strssdate = gcem_gubun.text+gcem_ssdate.text;
					strssnbr = gcem_ssnbr.text;
				}

				//alert("strssdate::"+strssdate+"::strssnbr::"+strssnbr);
   			//prompt("gcds_data03",gcds_data03.text);
				gctr_data01.Parameters = "v_str1="+gs_date+",v_str2="+gs_userid+",v_str3="+gs_fdcode+",v_str4="+strssdate+",v_str5="+strssnbr;
				gctr_data01.post();
		}
	}
	document.all.LowerFrame2.style.visibility="hidden";
}

/******************************************************************************
	Description : 금강산 지점의 경우 환율 적용
	parameter   : 
	ref         : 계정과목에 따라 환율 적용을 달리한다.
	              <정의>                        계정코드 첫자리
	              1. 자산/부채 - 월말 환율       1 / 2           EXRATEGB ='1'
								2. 자본      - 역사적 환율     3               EXRATEGB ='3'
								3. 수익/비용 - 평균환율        4               EXRATEGB ='4' 
								예외.계정테이블에서 ATCURTYPE = 'Y' 인 경우는 역사적환율 적용함.
								==> 변경 ATCURTYPE = 'Y' 인 경우 는 원화금액을 그대로 가져옴. EXRATEGB ='9'
******************************************************************************/
function ln_Exrate(i){
   var strAtcode=""; //계정코드
	 var stryymm="";   //회계년월
	 var temp="";
	 var tempval=0;
	 for(s=1;s<=gcds_data03.countrow;s++){
	    if(gcds_data03.namevalue(s,"FDCODE")=="03"){
        
				//금액변경 -- 원화를 외화에 넣음.///////////////////////////////////////////////////////////
        //총계정원장
				/*
        gcds_data03.namevalue(s,"FODEAMT")=gcds_data03.namevalue(s,"DEAMT");     //차변       DETOT
				gcds_data03.namevalue(s,"FOCRAMT")=gcds_data03.namevalue(s,"CRAMT");     //대변       CRTOT
        gcds_data03.namevalue(s,"FODECASH")=gcds_data03.namevalue(s,"DECASH");   //차변현금
				gcds_data03.namevalue(s,"FOCRCASH")=gcds_data03.namevalue(s,"CRCASH");   //대변현금
				gcds_data03.namevalue(s,"FOEDECASH")=gcds_data03.namevalue(s,"EDECASH"); //차변현금등가물 
				gcds_data03.namevalue(s,"FOECRCASH")=gcds_data03.namevalue(s,"ECRCASH"); //대변현금등가물

        //집계
				gcds_data03.namevalue(s,"FODEUPTOT")=gcds_data03.namevalue(s,"DEUPTOT");  //차변상위금액
				gcds_data03.namevalue(s,"FOCRUPTOT")=gcds_data03.namevalue(s,"CRUPTOT");  //대변상위금액
        gcds_data03.namevalue(s,"FODEUPCASH")=gcds_data03.namevalue(s,"DEUPCASH"); //차변상위현금
				gcds_data03.namevalue(s,"FOCRUPCASH")=gcds_data03.namevalue(s,"CRUPCASH"); //대변상위현금

				gcds_data03.namevalue(s,"DEAMT")=0;
				gcds_data03.namevalue(s,"CRAMT")=0;
				gcds_data03.namevalue(s,"DECASH")=0;
				gcds_data03.namevalue(s,"CRCASH")=0;
				gcds_data03.namevalue(s,"EDECASH")=0;
				gcds_data03.namevalue(s,"ECRCASH")=0;
				gcds_data03.namevalue(s,"DEUPTOT")=0;
				gcds_data03.namevalue(s,"CRUPTOT")=0;
				gcds_data03.namevalue(s,"DEUPCASH")=0;
				gcds_data03.namevalue(s,"CRUPCASH")=0;
			  */
				///////////////////////////////////////////////////////////////////////////////////////////  

        stryymm = gcds_data03.namevalue(s,"ACTDAT")
        stryymm = stryymm.substring(0,6) 
				if(gcds_data03.namevalue(s,"ATCURTYPE")=="Y"){
					 gcds_data03.namevalue(s,"EXRATE")=1;      //환율은 항상 1로 함.
					 gcds_data03.namevalue(s,"EXRATEDT")=stryymm||"00";    
					 gcds_data03.namevalue(s,"EXRATEGB")='9';  //원화금액을 그래로 가져옴.
           
					 //추가 : 2007.05.10 - 통합결산시 외화금액 입력/////////////////////
					 //관리항목 외화금액을 찾아서 입력된 원화금액을 가져온다.
					 for(z=1;z<=9;z++){
							if( gcds_data03.namevalue(s,"FSREFCD0"+z)=="1045"){  
								if(gcds_data03.namevalue(s,"CHAAMT")!=0){ 
									gcds_data03.namevalue(s,"FODEAMT")= gcds_data03.namevalue(s,"FSREFVAL0"+z); //외화차변금액
								}else if(gcds_data03.namevalue(s,"DAEAMT")!=0){
									gcds_data03.namevalue(s,"FOCRAMT")= gcds_data03.namevalue(s,"FSREFVAL0"+z); //외화대변금액
								}
								break;
							}
					 }
					 ///////////////////////////////////////////////////////////////////
				}else{
				  strAtcode = gcds_data03.namevalue(s,"ATCODE");
					strAtcode=strAtcode.substring(0,1);
					if(strAtcode == "1"|| strAtcode =="2" ){ 
					  gcds_data03.namevalue(s,"EXRATE")= 0;   //월말환율
						//gcds_data03.namevalue(s,"EXRATE")= ln_Exrate_find('02',stryymm);   //월말환율
						gcds_data03.namevalue(s,"EXRATEDT")="";     
						gcds_data03.namevalue(s,"EXRATEGB")='1';                         //
					}else if(strAtcode == "3"){               
						gcds_data03.namevalue(s,"EXRATE")=ln_Exrate_find('01',stryymm);  //역사적환율
						gcds_data03.namevalue(s,"EXRATEDT")=stryymm||"00";    
						gcds_data03.namevalue(s,"EXRATEGB")='3';                         //역사적환율 경우
						ln_Exrate_Data(s,gcds_data03.namevalue(s,"EXRATE"));
					}else if(strAtcode == "4"){               
					  gcds_data03.namevalue(s,"EXRATE")=0;  //평균환율
						//gcds_data03.namevalue(s,"EXRATE")=ln_Exrate_find('03',stryymm);  //평균환율
						gcds_data03.namevalue(s,"EXRATEDT")="";    
						gcds_data03.namevalue(s,"EXRATEGB")='4';                         //
					}
				}
			}
	 }
}

/******************************************************************************
	Description : 역사적 환율시 외화금액 적용
	parameter   : p1 - row
	              p2 - 환율
******************************************************************************/
function ln_Exrate_Data(p1, p2){
 // alert("row"+p1+"환율"+p2);
 
	//총계정원장
	gcds_data03.namevalue(s,"FODEAMT")=gcds_data03.namevalue(s,"CHAAMT")*p2;     //차변       DETOT
	gcds_data03.namevalue(s,"FOCRAMT")=gcds_data03.namevalue(s,"DAEAMT")*p2;     //대변       CRTOT
	gcds_data03.namevalue(s,"FODECASH")=gcds_data03.namevalue(s,"DECASH")*p2;   //차변현금
	gcds_data03.namevalue(s,"FOCRCASH")=gcds_data03.namevalue(s,"CRCASH")*p2;   //대변현금
	gcds_data03.namevalue(s,"FOEDECASH")=gcds_data03.namevalue(s,"EDECASH")*p2; //차변현금등가물 
	gcds_data03.namevalue(s,"FOECRCASH")=gcds_data03.namevalue(s,"ECRCASH")*p2; //대변현금등가물

	//집계
	gcds_data03.namevalue(s,"FODEUPTOT")=gcds_data03.namevalue(s,"CHAUPAMT")*p2;  //차변상위금액
	gcds_data03.namevalue(s,"FOCRUPTOT")=gcds_data03.namevalue(s,"DAEUPAMT")*p2;  //대변상위금액
	gcds_data03.namevalue(s,"FODEUPCASH")=gcds_data03.namevalue(s,"DEUPCASH")*p2; //차변상위현금
	gcds_data03.namevalue(s,"FOCRUPCASH")=gcds_data03.namevalue(s,"CRUPCASH")*p2; //대변상위현금

	/*alert("FODEAMT"+gcds_data03.namevalue(s,"FODEAMT")+"CHAAMT"+gcds_data03.namevalue(s,"CHAAMT"));
	alert("FOCRAMT"+gcds_data03.namevalue(s,"FOCRAMT")+"DAEAMT"+gcds_data03.namevalue(s,"DAEAMT"));
	alert("FODECASH"+gcds_data03.namevalue(s,"FODECASH")+"DECASH"+gcds_data03.namevalue(s,"DECASH"));
	alert("FOCRCASH"+gcds_data03.namevalue(s,"FOCRCASH")+"CRCASH"+gcds_data03.namevalue(s,"CRCASH"));
	alert("FOEDECASH"+gcds_data03.namevalue(s,"FOEDECASH")+"EDECASH"+gcds_data03.namevalue(s,"EDECASH"));
	alert("FOECRCASH"+gcds_data03.namevalue(s,"FOECRCASH")+"ECRCASH"+gcds_data03.namevalue(s,"ECRCASH"));
	alert("FODEUPTOT"+gcds_data03.namevalue(s,"FODEUPTOT")+"CHAUPAMT"+gcds_data03.namevalue(s,"CHAUPAMT"));
	alert("FOCRUPTOT"+gcds_data03.namevalue(s,"FOCRUPTOT")+"DAEUPAMT"+gcds_data03.namevalue(s,"DAEUPAMT"));
	alert("FODEUPCASH"+gcds_data03.namevalue(s,"FODEUPCASH")+"DEUPCASH"+gcds_data03.namevalue(s,"DEUPCASH"));
	alert("FOCRUPCASH"+gcds_data03.namevalue(s,"FOCRUPCASH")+"CRUPCASH"+gcds_data03.namevalue(s,"CRUPCASH"));
	*/
}
/******************************************************************************
	Description : 환율 찾기
	parameter   : p1 - 구분 01 : 역사적,   02: 월말 ,  03: 평균환율
	              p2 - 회계년월
******************************************************************************/
function ln_Exrate_find(p1, p2){
   var erstddat="";
	 var temp="";
	 //alert("p1:"+p1+"p2:"+p2);
	 for(g=1;g<=gcds_exrate.countrow;g++){
	    erstddat = gcds_exrate.namevalue(g,"ERSTDDAT");
      erstddat=erstddat.substring(0,6);
			//alert("g::"+g+":erstddat:"+erstddat);
	    if(erstddat==p2){
				if(p1=="01"){
				   temp = gcds_exrate.namevalue(g,"ERHIS"); 
				  // alert("ERHIStemp"+ temp);
           return temp ; 
				}else if(p1=="02"){
				   temp = gcds_exrate.namevalue(g,"ERMMLAST"); 
				  // alert("ERMMLASTtemp"+ temp);
           return temp ; 
				}else if(p1=="03"){
				   temp = gcds_exrate.namevalue(g,"ERAVG"); 
				  // alert("ERAVGtemp"+ temp);
           return temp ; 
				}
			}
	 }
}



/******************************************************************************
	Description : 결재일자 & 잔액넘기기 & 회계일자 & 전표번호
	parameter   : i는 나중에 없앰
******************************************************************************/
function ln_Date(i){
   var stractyymm="";
	 for(s=1;s<=gcds_data03.countrow;s++){
	    gcds_data03.namevalue(s,"SSDAT")=gcds_data01.namevalue(i,"SSDAT");
			gcds_data03.namevalue(s,"SSNBR")=gcds_data01.namevalue(i,"SSNBR");

			gcds_data03.namevalue(s,"ACTDAT")=gcds_data01.namevalue(i,"ACTDAT");
	    //gcds_data03.namevalue(s,"ACTDAT")=gcds_data01.namevalue(i,"ACTDAT");
			stractyymm = gcds_data01.namevalue(i,"ACTDAT");
      stractyymm = stractyymm.substring(0,6);
      gcds_data03.namevalue(s,"ACTYYMM")=stractyymm;
			gcds_data03.namevalue(s,"SGNDAT")=gs_date;
			gcds_data03.namevalue(s,"CHAUPAMT")=gcds_data03.namevalue(s,"CHAAMT");
			gcds_data03.namevalue(s,"DAEUPAMT")=gcds_data03.namevalue(s,"DAEAMT");
			gcds_data03.namevalue(s,"DEUPCASH")=gcds_data03.namevalue(s,"DECASH");
			gcds_data03.namevalue(s,"CRUPCASH")=gcds_data03.namevalue(s,"CRCASH");
	 }
}

/******************************************************************************
	Description : 현금계정 확인  (현금원화 -1110110, 현금외화 - 1110120)
	parameter   :
******************************************************************************/
function ln_Chk_Cash(){
	for(j=1;j<=gcds_data02.countrow;j++){
		if((gcds_data02.namevalue(j,"ATCODE")=="1110101")||(gcds_data02.namevalue(j,"ATCODE")=="1110102")){
			gs_chadae_gubun=gcds_data02.namevalue(j,"ATDECR"); 
      if(gs_chadae_gubun=="1"){
        gs_cashamt =gcds_data02.namevalue(j,"CHAAMT");
			}else if(gs_chadae_gubun=="2"){
				gs_cashamt =gcds_data02.namevalue(j,"DAEAMT");   
			}
      //alert("gs_chadae_gubun::"+gs_chadae_gubun+":gs_cashamt:"+gs_cashamt);
			return true;
			break;
		}
	}
	return false;
}

/******************************************************************************
	Description : 합계잔액 테이블의 차변현금과 대변현금을 구분하여 넣음.
         기준 : 1.현금계정만 적용
				        2.현금의 상대 계정에 현금필드에 현금금액 넣음.
							예1)  계정    차변    대변        계정    차변   대변   차변현금   대변현금
								    =====================       =========================================
                    급여    1000       0        급여    1000      0         0        1000
									미지급    1000       0      미지급    1000      0         0         500
										현금       0    1500        현금       0   1500         0           0
								보통예금       0     500    보통예금       0    500         0           0

							예2)  계정    차변    대변        계정    차변   대변   차변현금   대변현금
								    =====================       =========================================
                    급여    1000       0        급여    1000      0         0         500
										현금       0     500        현금       0    500         0           0
								당좌예금       0     500    당좌예금       0    500         0           0

                 3. 예 1에서 처럼 현금상대계정이 현금보다 작을 경우 상위 계정의 금액부터 현금에 입력한다.
	parameter   :
******************************************************************************/
function ln_Cash(){
  var tempamt=0; //계정금액
	
	for(k=1;k<=gcds_data02.countrow;k++){
	  tempamt=0;
		gs_decash=0;
		gs_crcash=0;
		gs_totcnt+=1;
		gcds_data03.namevalue(gs_totcnt,"DECASH")=0;
    gcds_data03.namevalue(gs_totcnt,"CRCASH")=0;
		//alert("k::"+k+":gs_totcnt:" +gs_totcnt);
		if((gcds_data02.namevalue(k,"ATCODE")=="1110101")||(gcds_data02.namevalue(k,"ATCODE")=="1110102")){
		}else{
			if(gs_chadae_gubun!=gcds_data02.namevalue(k,"ATDECR")){
			  //alert("k::"+k+" :step1:");
				if(gcds_data02.namevalue(k,"ATDECR")=="1"){
				  //alert("k::"+k+" :step1_1:");
					tempamt =gcds_data02.namevalue(k,"CHAAMT");
				}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
					tempamt =gcds_data02.namevalue(k,"DAEAMT");   
					//alert("k::"+k+" :step1_2:");
				}

				// alert("k::"+k+" :tempamt:"+tempamt);
					
				if(gs_cashamt<=tempamt){  //현금금액 <= 상대계정
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_decash=gs_cashamt;
						//alert("k::"+k+" :step2_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_crcash=gs_cashamt;
						//alert("k::"+k+" :step2_2:");
					}
          gs_cashamt=0;
				}else{                     //현금금액 > 상대계정
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_decash=tempamt;  
						//	alert("k::"+k+" :step3_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_crcash=tempamt;
						//	alert("k::"+k+" :step3_2:");
					}
					gs_cashamt = Number(gs_cashamt)-Number(tempamt); //gs_decash
				}
			}
			gcds_data03.namevalue(gs_totcnt,"DECASH")=Number(gs_crcash);
      gcds_data03.namevalue(gs_totcnt,"CRCASH")=Number(gs_decash);
     // alert("k::"+k+" :gs_decash:"+gs_decash+" :gs_crcash:"+gs_crcash);
		 //alert("gs_totcnt"+gs_totcnt+" DECASH"+gcds_data03.namevalue(gs_totcnt,"DECASH")+" CRCASH"+gcds_data03.namevalue(gs_totcnt,"CRCASH"));
		}
	}//for

}

/******************************************************************************
	Description : 현금등가물 계정 확인 (계정코드-11101***)
	parameter   :
******************************************************************************/
function ln_Chk_EqCash(){
  var strAtcode="";
	for(j=1;j<=gcds_data02.countrow;j++){
	  strAtcode=gcds_data02.namevalue(j,"ATCODE");
		strAtcode = strAtcode.substring(0,5);
		if(strAtcode=="11101"){
			gs_Eqchadae_gubun=gcds_data02.namevalue(j,"ATDECR"); 
      if(gs_Eqchadae_gubun=="1"){
        gs_Eqcashamt =gcds_data02.namevalue(j,"CHAAMT");
			}else if(gs_chadae_gubun=="2"){
				gs_Eqcashamt =gcds_data02.namevalue(j,"DAEAMT");   
			}
      //alert("gs_Eqchadae_gubun"+gs_Eqchadae_gubun+"gs_Eqcashamt"+gs_Eqcashamt);
			return true;
			break;
		}
	}
	return false;
}

/******************************************************************************
	Description : 합계잔액 테이블의 차변현금과 대변현금을 구분하여 넣음.
         기준 : 1.현금등가물계정만 적용
				        2.현금등가물의 상대 계정에 현금필드에 현금금액 넣음.
							예1)  계정    차변    대변        계정    차변   대변   차변현금등가물  대변현금등가물
								    =====================       ====================================================
                    급여    1000       0        급여    1000      0         0              1000
									미지급    1000       0      미지급    1000      0         0               500
										현금       0    1500        현금       0   1500         0                 0
								보통예금       0     500    보통예금       0    500         0                 0

							예2)  계정    차변    대변        계정    차변   대변   차변현금등가물  대변현금등가물
								    =====================       ====================================================
                    급여    1000       0        급여    1000      0         0               500
										현금       0     500        현금       0    500         0                 0
								당좌예금       0     500    당좌예금       0    500         0                 0

                 3. 예 1에서 처럼 현금상대계정이 현금보다 작을 경우 상위 계정의 금액부터 현금에 입력한다.
	parameter   :
******************************************************************************/
function ln_EqCash(){
  var tempamt=0; //계정금액
  var strAtcode=""; //
 
//  alert("ln_EqCash");
	for(k=1;k<=gcds_data02.countrow;k++){
	 // alert("k::"+k);
	  strAtcode=gcds_data02.namevalue(k,"ATCODE");
		strAtcode = strAtcode.substring(0,5);
	  tempamt=0;
		gs_Eqdecash=0;
		gs_Eqcrcash=0;
		gs_Etotcnt+=1;
		gcds_data03.namevalue(gs_totcnt,"EDECASH ")=0;
    gcds_data03.namevalue(gs_totcnt,"ECRCASH")=0;
	//	alert("k::"+k+"strAtcode" +strAtcode);

		if(strAtcode="11101"){
		}else{
			if(gs_Eqchadae_gubun!=gcds_data02.namevalue(k,"ATDECR")){
			  //alert("k::"+k+" :step1:");
				if(gcds_data02.namevalue(k,"ATDECR")=="1"){
				  //alert("k::"+k+" :step1_1:");
					tempamt =gcds_data02.namevalue(k,"CHAAMT");
				}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
					tempamt =gcds_data02.namevalue(k,"DAEAMT");   
					//alert("k::"+k+" :step1_2:");
				}

				// alert("k::"+k+" :tempamt:"+tempamt);
					
				if(gs_Eqcashamt<=tempamt){  //현금등가물금액 <= 상대계정
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_Eqdecash=gs_Eqcashamt; 
						//alert("k::"+k+" :step2_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_Eqcrcash=gs_Eqcashamt;
						//alert("k::"+k+" :step2_2:");
					}
          gs_Eqcashamt=0;
				}else{                     //현금등가물금액 > 상대계정
					if(gcds_data02.namevalue(k,"ATDECR")=="1"){
						gs_Eqdecash=tempamt;  
						//alert("k::"+k+" :step3_1:");
					}else if(gcds_data02.namevalue(k,"ATDECR")=="2"){
						gs_Eqcrcash=tempamt;
						//alert("k::"+k+" :step3_2:");
					}
					gs_Eqcashamt = Number(gs_Eqcashamt)-Number(tempamt); //gs_decash
				}
			}
			gcds_data03.namevalue(gs_totcnt,"EDECASH")=Number(gs_Eqcrcash);
      gcds_data03.namevalue(gs_totcnt,"ECRCASH")=Number(gs_Eqdecash);
     // alert("k::"+k+" gs_Eqdecash"+gs_Eqdecash+" gs_Eqcrcash"+gs_Eqcrcash);
		  //alert("gs_totcnt"+gs_totcnt+" DECASH"+gcds_data03.namevalue(gs_totcnt,"DECASH")+" CRCASH"+gcds_data03.namevalue(gs_totcnt,"CRCASH"));
		}
	}//for
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
  parameter   : 전표DTL
	             p - 01 ;결재 
							 p - 02 :결재취소
******************************************************************************/
function ln_SetDataHeader(p){

	if(p=='01'){
		if (gcds_data03.countrow<1){
   
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSNUM:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
							 + "ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,"
							 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
							 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
               
							 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
               + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"

							 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							 + "BANJAEYN:STRING,COCODE:STRING,DIVCD:STRING,DEPTCD:STRING,ACTDAT:STRING,"
							 + "ACTYYMM:STRING,ATCURTYPE:STRING,BGTDIV:STRING,BGTDEPT:STRING,TYPE_FSREFCD:STRING,"
							 + "TYPE_FSREFVAL:STRING,FUNDDIV:STRING,BJFSREFCD:STRING,"
							 
							 + "SGNDAT:STRING,DECASH:DECIMAL,CRCASH:DECIMAL,CHAUPAMT:DECIMAL,DAEUPAMT:DECIMAL,DEUPCASH:DECIMAL,CRUPCASH:DECIMAL,"
							 //추가부분
							 + "SSDAT:STRING,SSNBR:STRING,EDECASH:DECIMAL,ECRCASH:DECIMAL,"
							 + "FODEAMT:DECIMAL,FOCRAMT:DECIMAL,FODECASH:DECIMAL,FOCRCASH:DECIMAL,FOEDECASH:DECIMAL,FOECRCASH:DECIMAL,"
							 + "FODEUPTOT:DECIMAL,FOCRUPTOT:DECIMAL,FODEUPCASH:DECIMAL,FOCRUPCASH:DECIMAL,"
							 + "EXRATE:DECIMAL,EXRATEDT:STRING,EXRATEGB:STRING";
			gcds_data03.SetDataHeader(s_temp);
		}
	}else if(p=='02'){
		if (gcds_data05.countrow<1){
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSNUM:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
							 + "ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,"
							
							 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
							 
							 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							 
							 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
							 
							 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
               + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"

							 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							 + "BANJAEYN:STRING,COCODE:STRING,DIVCD:STRING,DEPTCD:STRING,ACTDAT:STRING,"
							 + "ACTYYMM:STRING,ATCURTYPE:STRING,BGTDIV:STRING,BGTDEPT:STRING,TYPE_FSREFCD:STRING,"
							 + "TYPE_FSREFVAL:STRING,FUNDDIV:STRING,BJFSREFCD:STRING,"

							 + "SGNDAT:STRING,DECASH:DECIMAL,CRCASH:DECIMAL,CHAUPAMT:DECIMAL,DAEUPAMT:DECIMAL,DEUPCASH:DECIMAL,CRUPCASH:DECIMAL,"
							  //추가부분
							 + "SSDAT:STRING,SSNBR:STRING,EDECASH:DECIMAL,ECRCASH:DECIMAL,"
							 + "FODEAMT:DECIMAL,FOCRAMT:DECIMAL,FODECASH:DECIMAL,FOCRCASH:DECIMAL,FOEDECASH:DECIMAL,FOECRCASH:DECIMAL,"
							 + "FODEUPTOT:DECIMAL,FOCRUPTOT:DECIMAL,FODEUPCASH:DECIMAL,FOCRUPCASH:DECIMAL,"
							 + "EXRATE:DECIMAL,EXRATEDT:STRING,EXRATEGB:STRING";
			gcds_data05.SetDataHeader(s_temp);
		}
	}else if (p=='06'){
		if (gcds_data06.countrow<1){
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,"
							 + "EMPNO:STRING,ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,"
							 + "BIGO:STRING,BGTGB,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";

			gcds_data06.SetDataHeader(s_temp);
		}
	}else if (p=='09'){
		if (gcds_outdata.countrow<1){
		  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
			gcds_outdata.SetDataHeader(s_temp);
		}
	
	}else if (p=='10'){
		if (gcds_faildata.countrow<1){
		  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
			gcds_faildata.SetDataHeader(s_temp);
		}

	}else if(p=="CONFIRM"){
		if (gcds_confirm.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,EMPNO:STRING,"
								 + "ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,BIGO:STRING,BGTGB:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_confirm.SetDataHeader(s_temp);
		}
  }
}
/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 결재취소
******************************************************************************/
function ln_Cancel(){

  if(ln_Chk('02')){
		ln_SetDataHeader('02');
		ln_Cancel_Detail();
		if(ln_Chk_Banjae()){
			if(confirm("결재취소 하시겠습니까?")){	
				gctr_data02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t2?";
				//prompt("gcds_data05",gcds_data05.text);
				gctr_data02.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
				
				gctr_data02.post();
				ln_Query();
				gcds_data05.ClearData();
			}
		}
	}
}

/******************************************************************************
	Description : 결재취소건 전표번호로 전표 Detail데이타를 조회 후 데이타를 넘김
	parameter   :
******************************************************************************/
function ln_Cancel_Detail(){
  var tempDataSet ="";
	for(i=1;i<=gcds_data01.countrow;i++){
		if((gcds_data01.namevalue(i,"CHK")=="T")&&(gcds_data01.namevalue(i,"ACCSGNEND")=="Y")){
			
				gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s2?v_str1="+gcds_data01.namevalue(i,"FDCODE")
																										     +"&v_str2="+gcds_data01.namevalue(i,"FSDAT")
																										 	   +"&v_str3="+gcds_data01.namevalue(i,"FSNBR");
        //prompt("",gcds_data04.DataID );																							
	      gcds_data04.Reset();
				tempDataSet = gcds_data04.ExportData(1,gcds_data04.CountRow,false);
				gcds_data05.ImportData(tempDataSet);

				//prompt('gcds_data05',gcds_data05.text);
				//prompt("",gcds_data05.text);
				//ln_Date();//결재일자
		}
	}
}

/******************************************************************************
	Description : 반제정산이 존재할 경우 반제원장(잔액장) 데이타 삭제 못함.
	parameter   :
******************************************************************************/
function ln_Chk_Banjae(){
  
	//추가 2007.06.01 반제체크안함.
	if(chkbox_banjae.checked==true){
		return true;
	}

  _out:
	for(k=1;k<=gcds_data05.countrow;k++){
	  //alert("BANJAEYN::"+gcds_data05.namevalue(k,"BANJAEYN"));
    //alert("ATDECR::"+gcds_data05.namevalue(k,"ATDECR"));
		//alert("CHAAMT::"+gcds_data05.namevalue(k,"CHAAMT"));
		//alert("DAEAMT::"+gcds_data05.namevalue(k,"DAEAMT"));
		if(gcds_data05.namevalue(k,"BANJAEYN")!="N"){
			if(gcds_data05.namevalue(k,"ATDECR")=="1"&&gcds_data05.namevalue(k,"CHAAMT")!=0){ //CHAAMT
				gcds_banjaerel.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s3?v_str1="+gcds_data05.namevalue(k,"FDCODE")
																										        +"&v_str2="+gcds_data05.namevalue(k,"FSDAT")
																										 	      +"&v_str3="+gcds_data05.namevalue(k,"FSNBR")
																														+"&v_str4="+gcds_data05.namevalue(k,"FSSEQ");
	      gcds_banjaerel.Reset();
				if(gcds_banjaerel.namevalue(1,"CNT")>=1){
					alert("해당전표로 정산된 데이타가 존재합니다. 결재취소할 수 없습니다.");
				  return false;			
				}
			}else if(gcds_data05.namevalue(k,"ATDECR")=="2"&&gcds_data05.namevalue(k,"DAEAMT")!=0){
        gcds_banjaerel.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s3?v_str1="+gcds_data05.namevalue(k,"FDCODE")
																										        +"&v_str2="+gcds_data05.namevalue(k,"FSDAT")
																										 	      +"&v_str3="+gcds_data05.namevalue(k,"FSNBR")
																														+"&v_str4="+gcds_data05.namevalue(k,"FSSEQ");																				
	      gcds_banjaerel.Reset();
				if(gcds_banjaerel.namevalue(1,"CNT")>=1){
					alert("해당전표로 정산된 데이타가 존재합니다. 결재취소할 수 없습니다.");
					return false;
				}
			}
		}
	}

	return true;
}

/******************************************************************************
	Description : 반송
******************************************************************************/
function ln_Back(){
  if(ln_Chk('03')){
		if(!ln_Back_Data()) return;
		if (confirm("반송하시겠습니까?")){		
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			//prompt("gcds_confirm",gcds_data06.text);
			gctr_data06.post();
			ln_Query();
		}
	}
}


/******************************************************************************
	Description : 반송데이타 저장
******************************************************************************/
function ln_Back_Data(){
    var strtogb = "";
		var strfromgb="";
		var cnt=0;
		var tempnbr="";
		ln_SetDataHeader('06');
    
		/**
		if(hid_gubun.value=="01"){        //회계
			strfromgb="03";
		}else if(hid_gubun.value=="02"){  //예산
			strfromgb="02";
		}else if(hid_gubun.value=="03"){  //자금
			strfromgb="06";
		}
		**/

	  for(i=1;i<=gcds_data01.countrow;i++){
			if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="C")||(gcds_data01.namevalue(i,"ACCSGNEND")=="R"))){
			  cnt+=1;
				gcds_data06.addrow();
				var row =  gcds_data06.rowposition ; 
				tempnbr="";
				tempnbr = gcds_data01.namevalue(gcds_data01.rowposition,"FSNBR");
				tempnbr = tempnbr.substring(0,1);
        if (tempnbr=="9"){
					 strtogb ="04";
				}else{
					 strtogb ="01";
				}

				gcds_data06.namevalue(row,"FDCODE")=gcds_data01.namevalue(i,"FDCODE"); 
				gcds_data06.namevalue(row,"FSDAT")=gcds_data01.namevalue(i,"FSDAT");  
				gcds_data06.namevalue(row,"FSNBR")=gcds_data01.namevalue(i,"FSNBR");  
				gcds_data06.namevalue(row,"SEQ")=gcds_data01.namevalue(i,"SEQ"); 
				gcds_data06.namevalue(row,"ACCSGNID")=gcds_data01.namevalue(i,"ACCSGNID");      //결재자
				gcds_data06.namevalue(row,"EMPNO")= gcds_data01.namevalue(i,"EMPNO");  
				gcds_data06.namevalue(row,"ACCSGNDAT") =gcds_data01.namevalue(i,"ACCSGNDAT");  
				gcds_data06.namevalue(row,"ACCSGNEND") ="B"; 
				gcds_data06.namevalue(row,"FROMGB") =strfromgb; 
				gcds_data06.namevalue(row,"TOGB") =strtogb; 
				gcds_data06.namevalue(row,"BIGO") =gcds_data01.namevalue(i,"BIGO"); 
				gcds_data06.namevalue(row,"BGTGB") =""; 
				gcds_data06.namevalue(row,"WRDT") =gs_date;  
				gcds_data06.namevalue(row,"WRID") =gs_userid;  
				gcds_data06.namevalue(row,"UPDT") =gs_date;  
				gcds_data06.namevalue(row,"UPID") =gs_userid;  
			}//if
	 }//for

	 if(cnt==0){
			alert("반송 할 수 없습니다.");
			return false;
	 }else{
			return true;
	 }
}
/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("전표결재조회","",2);
}

/******************************************************************************
	Description : 결재권자 찾기
	parameter   :
******************************************************************************/
function ln_Popup(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0900";//결재자

	strURL =  "./commdtil_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno.value =arrResult[0];
		txt_empnmk.value = arrResult[1];
	}else{
    txt_empno.value="";
		txt_empnmk.value="";
	}
}

/******************************************************************************
	Description : Slipno popup
	parameter   :
******************************************************************************/
function ln_Popup_Slip_no(row){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
																									  
	arrParam[0] = gcds_data01.namevalue(row,"FDCODE");
	arrParam[1] = gcds_data01.namevalue(row,"FSDAT");
	arrParam[2] = gcds_data01.namevalue(row,"FSNBR");

	strURL = "./slipno_popup_confirm.jsp";
	strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	//alert("재조회");
	ln_Query();
}

/******************************************************************************
	Description : 다량의 건수를 전기 시킬때 100건 마다 사용함.
	parameter   : p1 - fdcode, p2-fsdat , p3 -fsnbr
******************************************************************************/
function ln_Fail_Data(p1,p2,p3){
  gcds_faildata.addrow();
	gcds_faildata.namevalue(gcds_faildata.rowposition,"FDCODE")=p1;
	gcds_faildata.namevalue(gcds_faildata.rowposition,"FSDAT")=p2;
	gcds_faildata.namevalue(gcds_faildata.rowposition,"FSNBR")=p3;
}


/******************************************************************************
	Description : msg
	parameter   : 
******************************************************************************/
function ln_Msg(){
  var strFail="";      //실패내역
	var temp="";

	for (f=1;f<=gcds_faildata.countrow;f++){
		temp="";
    temp = gcds_faildata.namevalue(f,"FDCODE")+"-"
		     + gcds_faildata.namevalue(f,"FSDAT")+"-"
         + gcds_faildata.namevalue(f,"FSNBR")
				 ;
		temp+='\n';
		strFail += temp ;
	}

	alert("작업이 끝났습니다." +'\n'+
	      "전체건수 : "+gs_cnt+'\n'+
	      "성공건수 : "+gs_succcnt+'\n'+
				"실패건수 : "+gs_failcnt+'\n'+
				"실패내역 : "+'\n'+ strFail	);
}

/******************************************************************************
	Description : 다량의 건수를 전기 시킬때 100건 마다 사용함.
	parameter   :
******************************************************************************/
function ln_Batch(){
  var tempcnt=0;
	var temptot=0;
	//txt_cnt.value=0;
	//txt_tot.value=0;

	if(confirm("결재하시겠습니까?")){
		ln_SetDataHeader('01');
		
		var tempDataSet="";
		
		//txt_tot.value=gcds_data01.countrow; 
		for(i=1;i<=gcds_data01.countrow;i++){
			gs_totcnt=0;
			if((gcds_data01.namevalue(i,"CHK")=="T")&&((gcds_data01.namevalue(i,"ACCSGNEND")=="R")||(gcds_data01.namevalue(i,"ACCSGNEND")=="C"))){
					
					tempcnt+=1; //100건마다 처리함.
          temptot+=1;
					gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_s2?v_str1="+gcds_data01.namevalue(i,"FDCODE")
																													 +"&v_str2="+gcds_data01.namevalue(i,"FSDAT")
																													 +"&v_str3="+gcds_data01.namevalue(i,"FSNBR");
					//prompt("",gcds_data02.DataID );																							
					gcds_data02.Reset();
					
					tempDataSet = gcds_data02.ExportData(1,gcds_data02.CountRow,false);
					gcds_data03.ImportData(tempDataSet);
					
					//alert("CRCASH"+gcds_data03.namevalue(1,"CRCASH"));
					if(ln_Chk_Cash()){//현금계정체크  (현금원화, 현금외화)
						//alert("현금존재");
						ln_Cash()
					}
					
					ln_Date2(i);//결재일자
          
					//txt_cnt.value=temptot;
			
				if(i==gcds_data01.countrow){
					  gctr_data09.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t1?";
						//prompt("gcds_data03",gcds_data03.text);
						gctr_data09.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
						gctr_data09.post();
						gcds_data03.ClearData();
						tempcnt=0;
						tempDataSet=""
				}else{
					if (tempcnt==1){
						gctr_data09.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020004_t1?";
						//prompt("gcds_data03",gcds_data03.text);
						gctr_data09.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
						gctr_data09.post();
						gcds_data03.ClearData();
						tempcnt=0;
						tempDataSet=""
					}
				}
			}//if
		}//for
	}//if
}

/******************************************************************************
	Description : 
	parameter   :
******************************************************************************/
function ln_Date2(i){
	 for(s=1;s<=gcds_data03.countrow;s++){
	    gcds_data03.namevalue(s,"SGNDAT")=gcds_data01.namevalue(i,"ACCSGNDAT");
			//gcds_data03.namevalue(s,"SGNDAT")=gs_date;
			gcds_data03.namevalue(s,"CHAUPAMT")=gcds_data03.namevalue(s,"CHAAMT");
			gcds_data03.namevalue(s,"DAEUPAMT")=gcds_data03.namevalue(s,"DAEAMT");
			gcds_data03.namevalue(s,"DEUPCASH")=gcds_data03.namevalue(s,"DECASH");
			gcds_data03.namevalue(s,"CRUPCASH")=gcds_data03.namevalue(s,"CRCASH");
	 }
}

/******************************************************************************
	Description : 예산결재요청
	parameter   :
******************************************************************************/
function ln_Popup_Confirm(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
  
	/**
	if(hid_gubun.value!="02"){ //
		alert("예산만 결재요청 가능합니다.");
		return;
	}
	**/

 //2010.02.07 jys
 for (i=1;i<=gcds_data01.countrow;i++){
		if((gcds_data01.namevalue(i,"CHK")=="T")&&(gcds_data01.namevalue(i,"ACCSGNEND")=="R")){
			if(gcds_data01.namevalue(i,"TOGB")!="02"){
				alert("구분이 예산이 아닌건은 예산 결재요청 할 수 없습니다.");
				return false;
			}
		}
	}


	//2007.10.18 예산 체크 
	if(!ln_Chk_Bgt()) return;

	strURL = "./confirm_popup.jsp";
	strPos = "dialogWidth:330px;dialogHeight:180px;status:no;scroll:no;resizable:no";

	result = showModalDialog(strURL,arrParam,strPos);
	//return result;
	if (result != null) {
		arrResult = result.split(";");
		//alert("0"+arrResult[0]);
		//alert("1"+arrResult[1]);
		gcds_confirm.ClearData();
		if (arrResult[1]= "Y" ){ //결재저장시
			ln_Confirm_Save(arrResult[0], arrResult[3],arrResult[4]); //결재자, 회계(예산)구분 01 회계, 02예산, Y -회계일자 변경
		}
	}
}

/******************************************************************************
	Description : 결재시 저장
	parameter   :  p - 결재자 사번
	               p1 - 회계/ 예산 구분
								 p2 - 회계일자 변경시 전표등록에서 함(Y)
******************************************************************************/
function ln_Confirm_Save(p, p1,p2){
		var strempno="";
    var strtogb="";

		ln_SetDataHeader("CONFIRM");

    for (i=1;i<=gcds_data01.countrow;i++){
			if((gcds_data01.namevalue(i,"CHK")=="T")&&(gcds_data01.namevalue(i,"ACCSGNEND")=="R")){
				gcds_confirm.addrow();

				gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=gcds_data01.namevalue(i,"FDCODE"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=gcds_data01.namevalue(i,"FSDAT");   
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=gcds_data01.namevalue(i,"FSNBR");  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=gcds_data01.namevalue(i,"SEQ");
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //결재자
				gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= gcds_data01.namevalue(i,"EMPNO"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="02"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") ="03"; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"BGTGB") =gcds_data01.namevalue(i,"BGTGB"); 
				gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gs_date;  
				gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  
			}
		}
		if (confirm("결재요청 하시겠습니까?")){	
			gctr_data07.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			//prompt("gcds_confirm",gcds_confirm.text);
			gctr_data07.post();
			ln_Query();
    }
}

/******************************************************************************
	Description : 회계일자 일괄변경함.  
	parameter   : 
	참       고 : 결재요청 건 중 체크된 건에 한해서 일괄변경함.
	              일괄변경시 전표 mst의 일자도 자동 변경됨.
								2007.10.18 정영식 수정 : 회계일자 변경시 예산 체크 함.
                2008.02.18 정영식 수정 : 회계년월을 체크함.
								2008.03.05 정영식 수정 : 자금(hid_gubun.value='03')의 경우는 예산이 존재하지 않아서 회계년월 변경 체크 안함.
******************************************************************************/
function ln_ChgData_Batch(){
  var strActyymm="";
	var strChgyymm="";

	if(gcem_chg_date.text==""){
		gcem_chg_date.focus();
		alert("변경할 회계일자를 입력하십시요");
		return;
	}
 
 
	for(i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			if(gcds_data01.namevalue(i,"FSSTAT")=="R"){
				//예산체크
				if(gcds_data01.namevalue(i,"BGTGB")!="Y"){ //예산이 없는 경우
					gcds_data01.namevalue(i,"ACTDAT")=gcem_chg_date.text;
				}else{ //예산이 존재하는 경우
					strActyymm = gcds_data01.namevalue(i,"ACTDAT").substring(0,6);
					strChgyymm = gcem_chg_date.text.substring(0,6);

					//alert("strActyymm:"+strActyymm+":strChgyymm:"+strChgyymm);
					//if(gcem_chg_date.text!=gcds_data01.namevalue(i,"ACTDAT")){
					/**
					if(strChgyymm !=strActyymm){ //년월이 다른 경우
						if(hid_gubun.value!='03'){ //자금이 아닐 경우만 체크함. 2008.03.05 
							gcgd_disp01.Focus();
							gcds_data01.rowposition = i;
							alert("예산이 존재하므로 전표등록에서 회계일자를 변경해 주십시요. ");
							break;
						}else{
              gcds_data01.namevalue(i,"ACTDAT")=gcem_chg_date.text; //(자금제외)
						}
					}else{ //동일 년월일 경우 
						gcds_data01.namevalue(i,"ACTDAT")=gcem_chg_date.text;
					}
					**/
				} //Y
			} //R	
		}//CHK	
	}//for

}

/******************************************************************************
	Description : 예산체크  
	parameter   : 
	참       고 : 회계일자 변경시 변경되면 체크함  
	              2008.02.18 정영식 수정 : 회계년월을 체크함.
								2008.03.05 정영식 수정 : 자금은 체크 안함.
******************************************************************************/
function ln_Chk_Bgt(){
	for(i=1;i<=gcds_data01.countrow;i++){	
		if(gcds_data01.namevalue(i,"BGTGB")=="Y"&&gcds_data01.namevalue(i,"CHK")=="T"){
		  /**
			if(hid_gubun.value!='03'){ //자금이 아닌 경우
				 if(gcds_data01.namevalue(i,"ACTDAT").substring(0,6)!=gcds_data01.OrgNameValue(i,"ACTDAT").substring(0,6)){
						gcgd_disp01.Focus();
						gcds_data01.rowposition = i;
						alert("예산이 존재하므로 전표등록에서 회계일자를 변경해 주십시요. ");
						return false;
				 }
			}
			**/
		}
	}
	return true;
}


function ln_TEST(){
  var str1 ="01";     //지점코드
	var str2 ="200602"; //년월
	var str3 ="1110101"; //
	var str4 ="03";     //사업소
	var str5 ="C000";   //본부
  var temp ="1120100"; //좌변수식. 우변수식
  
	gf_array_val(gcds_name,str1,str2,str4,str5,temp);

	//alert("TOTALVALUE"+gcds_name2.namevalue(1,"TOTALVALUE"));

}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_name classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_name2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표Detail -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표Detail_temp -->
<comment id="__NSID__"><object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 결재취소용 전표Detail -->
<comment id="__NSID__"><object  id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 결재취소용 전표Detail  export -->
<comment id="__NSID__"><object  id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반송 -->
<comment id="__NSID__"><object  id=gcds_data06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 지점 -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 실패건수 -->
<comment id="__NSID__"><object  id=gcds_outdata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 실패건수 누적-->
<comment id="__NSID__"><object  id=gcds_faildata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 로그인 체크 -->
<comment id="__NSID__"><object  id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 금강산 환율 -->
<comment id="__NSID__"><object  id=gcds_exrate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표결재 -->
<comment id="__NSID__"><object  id=gcds_confirm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제정산전표갯수 -->
<comment id="__NSID__"><object  id=gcds_banjaerel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 전표 Detail 넘기기 -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t1(I:USER=gcds_data03,O:USER2=gcds_outdata)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 결재취소 -->
<comment id="__NSID__"><object  id=gctr_data02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t2(I:USER=gcds_data05)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반송 -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6(I:USER=gcds_data06)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표 Detail 넘기기 -->
<comment id="__NSID__"><object  id=gctr_data09 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020004_t1(I:USER=gcds_data03)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 결재요청  -->
<comment id="__NSID__"><object  id=gctr_data07 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6f(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  


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
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
  
	gcds_data02.ClearData();
	gcds_data03.ClearData();
	gcds_data04.ClearData();
	gcds_data05.ClearData();
	gcds_data06.ClearData();
	gcds_outdata.ClearData();
	gcds_faildata.ClearData();
	
</script>


<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	
	//alert("onloadCompleted");

</script>


<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
	
	//alert("onloadCompleted");
  //alert("row:;"+row);

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
  gs_save_gubun="";
	
	if((row==0) && (colid=="CHK")){
	  if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		for(i=1;i<=gcds_data01.countrow;i++){
		  if(gs_gubun=="1"||gs_gubun==""){
        gcds_data01.namevalue(i,"CHK")="T";
			}else{
        gcds_data01.namevalue(i,"CHK")="F";
			}
			if(gcds_data01.namevalue(i,"ACCSGNEND")=="B"||gcds_data01.namevalue(i,"ACCSGNEND")=="N"){
				gcds_data01.namevalue(i,"CHK")="F";
			}
		}
	}else if(row!=0){
		if(gcds_data01.namevalue(row,"ACCSGNEND")=="B"||gcds_data01.namevalue(row,"ACCSGNEND")=="N"){
			gcds_data01.namevalue(row,"CHK")="F";
		}
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
  
	if(row>0){
		if(colid!="CHK" && colid!="ACTDAT" && colid!="BIGO"){
			ln_Popup_Slip_no(row);
		}
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnExit(row,colid,olddata)>
   // alert("row"+row+"colid"+colid);
		if(colid=="ACTDAT"){
		  if(gv_date_check(gcds_data01.namevalue(gcds_data01.rowposition,"ACTDAT"))){
			}else{
			  gcgd_disp01.EnableTabKey(false);
				alert("날짜형식이 틀렸습니다.");
        //gcgd_disp01.SetColumn("ACTDAT");
			}
		}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
	//alert("작업이 성공적으로 완료되었습니다.");
  gs_succcnt+=1;       //총 성공건수
	gcds_data03.ClearData();
</script>

<script language="javascript" for="gctr_data01" event="onfail()">
	//alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
	gs_failcnt+=1;       //총 실패건수

	ln_Fail_Data(gcds_outdata.namevalue(gcds_outdata.rowpotion,"FDCODE"),
	             gcds_outdata.namevalue(gcds_outdata.rowpotion,"FSDAT"),
							 gcds_outdata.namevalue(gcds_outdata.rowpotion,"FSNBR"));
	gcds_data03.ClearData();
</script>


<script language="javascript" for="gctr_data02" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data02" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data02.ErrorCode + "\n" + "Error Message : " + gctr_data02.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data06" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="test" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="test" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	//alert("Error Code : " + test.ErrorCode + "\n" + "Error Message : " + test.ErrorMsg + "\n");

	gcds_data03.ClearData();
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a020044_head.gif"></td>
		<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
		    <img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand" onClick="ln_Excel()" >
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="876px"> 
					<td width="70px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;회계일자&nbsp;</nobr></td>
					<td class="tab18" style="width:250px;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="####/##/##">
											<!--임시 <param name=Format        value="YYYY/MM/DD"> -->
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
							~&nbsp;
						 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="####/##/##">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"> 
							</nobr>
					</td>

          			<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>지점구분</nobr></td>
					<td class="tab18" style="width:200px;" align=left ><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
								<param name=ComboDataID    value="gcds_comfield">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					 </td> 
          
					<td width="70px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;결재권자</nobr></td>
					<td class="tab31" width="63px">
						<input type="text" class="txt11" id="txt_empno"  style="position:relative;left:4px;width:60px;background-color:#d7d7d7" readOnly></td>
					<td class="tab31" width="35px">
						<img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;position:relative;left:3px" onclick="ln_Popup()"></td>
					<td class="tab18" width="100px"><nobr>
						<input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="position:relative;left:5px;width:90px;"></nobr></td>	
        </tr>

        <tr>
          <td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;적    요&nbsp;</nobr></td>
					<td class="tab19" style="width:250px;"><nobr>&nbsp;
						<input id="txt_remark" type="text" class="txtbox"  style= "width:240px;height:20px;position:relative;left:-4px" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query()";>
						</nobr>
					</td>

					<td width="70px" style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;&nbsp;전표상태</nobr></td>
          <td class="tab19" style="width:200px;" align=left><nobr>&nbsp;<comment id="__NSID__">
						 <object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
											<param name=CBData			   value="A^전체,Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> 
							</nobr>
					</td>

          <td width="70px" style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;결재구분</nobr></td>
					<td class="tab19" style="width:200px;" align=left colspan=3><nobr>&nbsp;
            <comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=CBData			   value=" ^전체,01^회계,02^예산,06^자금">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> 

						<!-- <input type="text"   class="txt11" id="txt_gubun"  style="position:relative;left:-4px;width:60px;background-color:#d7d7d7" readOnly>
						<input type="hidden" class="txt11" id="hid_gubun"  style="position:relative;left:-4px;width:60px;background-color:#d7d7d7" readOnly> -->
					<!-- 	<input type="text" class="txt11" id="txt_count"  style="position:relative;left:-4px;width:60px;background-color:#d7d7d7" readOnly> -->
						<!--   <comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=CBData			   value="A^전체,01^현업,02^수정분개">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> 
							</nobr>
							<input type="text" class="txt11" id="txt_cnt"  style="position:relative;left:4px;top:-3px;width:40px;background-color:#d7d7d7" readOnly>
							&nbsp;/<input type="text" class="txt11" id="txt_tot"  style="position:relative;left:4px;top:-3px;width:40px;background-color:#d7d7d7" readOnly> -->
					</td>
				</tr>
		 </table>
		</td>
	</tr> 
	<tr>
		<td width="876px"  class="tab15" align="right">
			<nobr>				
				<span id=sp0 style="display:none;">
          <font style="position:relative;top:-4px;left:0px">반제처리안함</font>&nbsp;
          <input type=checkbox  id=chkbox_banjae  style="width:15px;position:relative;left:0px;top:-3px;color=#CCFFCC";>&nbsp;&nbsp;
					<font style="position:relative;top:-4px;left:0px">전표일자/전표번호</font>&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_gubun classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:18px;height:20px;position:relative;left:0px;top:2px">		
										<param name=Text					value="A">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Format        value="#">
										<param name=UpperFlag     value="1">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
					 </object>
					 &nbsp;
					<object  id=gcem_ssdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
					 </object></comment><script>__ws__(__NSID__);</script> 
					 <comment id="__NSID__">&nbsp;
					 <object  id=gcem_ssnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Format        value="######">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
					 </object></comment><script>__ws__(__NSID__);</script> 
        
				&nbsp;&nbsp;&nbsp;&nbsp;
			  <font style="position:relative;top:-4px;left:0px">일괄변경 회계일자</font>&nbsp;
				<comment id="__NSID__">&nbsp;
						<object  id=gcem_chg_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
          <img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_chg_date', 'Text')" style="position:relative;width:20px;left:0px;cursor:hand;">
					<img src="../../common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;left:0px" onClick="ln_ChgData_Batch()">
				</span>
				</nobr>
		  </td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
	<tr> 			
		<td style="width:280" ALIGN=LEFT VALIGN=TOP>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
				style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data01">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ViewSummary"	value=1>
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<PARAM NAME="Format"			VALUE="  
					<C> Name='선택'		    ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  SumBgColor=#C3D0DB align=center	EditStyle=CheckBox   </C> 
					<C> Name='지점'		    ID=FDNAME	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40	  SumBgColor=#C3D0DB edit=none  align=center sort=false  </C> 
					<C> Name='잠금'		    ID=FSLOCK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  SumBgColor=#C3D0DB align=center sort=true	  BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} </C>
					<C> Name='구분'	 	    ID=TOGB 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=44	  SumBgColor=#C3D0DB edit=none  align=center sort=true  EditStyle=Combo Data='01:,02:예산,03:회계,05:완료,06:자금' </C> 
					<C> Name='전표번호'		ID=SSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=102	  SumBgColor=#C3D0DB edit=none  align=center sort=true  BgColor=#CCFFCC</C> 
					<C> Name='접수번호'		ID=FSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=102	  SumBgColor=#C3D0DB edit=none  align=center sort=true  </C> 
					<C> Name='담당자'		  ID=EMPNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=0  	  SumBgColor=#C3D0DB edit=none  align=center sort=true show=false</C> 
					<C> Name='담당' 		  ID=EMPNMK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  SumBgColor=#C3D0DB edit=none  align=center sort=true </C> 
					<C> Name='적요'			  ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=200	  SumBgColor=#C3D0DB edit=none  align=left	 sort=true  SumText='합   계'</C> 
					<C> Name='금액'		  	ID=FSAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  SumBgColor=#C3D0DB edit=none  align=right  sort=true  SumText=@sum</C> 
					<C> Name='상태'		    ID=ACCSGNEND HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  SumBgColor=#C3D0DB edit=none  align=center sort=true  EditStyle=Combo Data='Y:결재완료,R:결재요청,N:결재대기,C:결재취소,B:반송' </C> 
					<C> Name='회계일자'		ID=ACTDAT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  SumBgColor=#C3D0DB align=center sort=true  Mask='XXXX/XX/XX' BgColor=#ffffcc  </C> 
					<C> Name='반송사유'		ID=BIGO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  SumBgColor=#C3D0DB align=center sort=true   BgColor=#ffffcc </C>
					             
					">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</tr>
</table>

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
<iframe id="LowerFrame2" name="work2" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/ing_bar.swf" width="320px" height="42px"></iframe> 

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 